//===----- SVEIntrinsicOpts - SVE ACLE Intrinsics Opts --------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// Performs general IR level optimizations on SVE intrinsics.
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/Support/Debug.h"
#include "Utils/AArch64BaseInfo.h"

using namespace llvm;
using namespace llvm::PatternMatch;

#define DEBUG_TYPE "sve-intrinsicopts"

namespace llvm {
  void initializeSVEIntrinsicOptsPass(PassRegistry &);
}

namespace {
struct SVEIntrinsicOpts : public FunctionPass {
  static char ID; // Pass identification, replacement for typeid
  SVEIntrinsicOpts() : FunctionPass(ID) {
    initializeSVEIntrinsicOptsPass(*PassRegistry::getPassRegistry());
  }

  bool runOnFunction(Function &F) override;
  void getAnalysisUsage(AnalysisUsage &AU) const override;
private:
  bool optimizeBlock(BasicBlock *BB);
  bool optimizeIntrinsic(Instruction *I);
  bool IsReinterpretInst(const Instruction *I);
  bool ProcessPhiNode(Instruction *X);
  bool elideReinterprets(IntrinsicInst *X);
  bool optimizeExtractElement(Instruction *I);
  bool optimizeCnt(Instruction *I);
  bool optimizePTestAny(IntrinsicInst *IntrI);

  Function *F;
  DominatorTree *DT;
};
} // end anonymous namespace

void SVEIntrinsicOpts::getAnalysisUsage(AnalysisUsage &AU) const {
  AU.addRequired<DominatorTreeWrapperPass>();
  AU.setPreservesCFG();
}

char SVEIntrinsicOpts::ID = 0;
static const char *name = "SVE intrinsics optimizations";
INITIALIZE_PASS_BEGIN(SVEIntrinsicOpts, DEBUG_TYPE, name, false, false)
INITIALIZE_PASS_DEPENDENCY(DominatorTreeWrapperPass);
INITIALIZE_PASS_END(SVEIntrinsicOpts, DEBUG_TYPE, name, false, false)

namespace llvm {
FunctionPass *createSVEIntrinsicOptsPass() { return new SVEIntrinsicOpts(); }
}

/// The function checks if the Instruction is a reinterpret instrinsic
bool SVEIntrinsicOpts::IsReinterpretInst(const Instruction *I)
{
  const IntrinsicInst *Y = dyn_cast<IntrinsicInst>(I);
  if (!Y)
    return false;

  unsigned ID = Y->getIntrinsicID();
  if (ID != Intrinsic::aarch64_sve_reinterpret_bool_b &&
      ID != Intrinsic::aarch64_sve_reinterpret_bool_h &&
      ID != Intrinsic::aarch64_sve_reinterpret_bool_w &&
      ID != Intrinsic::aarch64_sve_reinterpret_bool_d)
        return false;

  return true;
}

/// The function will remove redundant reinterprets casting in the presence
/// of the control flow
bool SVEIntrinsicOpts::ProcessPhiNode(Instruction *X){

  SmallVector<Instruction *, 32> Worklist;
  auto RequiredType = X->getType();

  auto *PN = dyn_cast<PHINode>(X->getOperand(0));
  if (!PN)
    return false;

  for (Value *IncValPhi : PN->incoming_values())
  {
    auto *IncValPhiInst = dyn_cast<Instruction>(IncValPhi);
    if (!IncValPhiInst)
      return false;

    if (!IsReinterpretInst(IncValPhiInst))
      return false;

    Value *SourceVal = IncValPhiInst->getOperand(0);
    if (RequiredType != SourceVal->getType())
      return false;
  }

  LLVMContext &C1 = PN->getContext();
  IRBuilder<> builder(C1);
  builder.SetInsertPoint(PN);
  PHINode  *NPN = builder.CreatePHI(RequiredType, PN->getNumIncomingValues());
  Worklist.push_back(PN);

  for (unsigned i = 0; i < PN->getNumIncomingValues(); i++)
  {
    auto *Reinterpret = cast<Instruction>(PN->getIncomingValue(i));
    NPN->addIncoming(Reinterpret->getOperand(0), PN->getIncomingBlock(i));
    Worklist.push_back(Reinterpret);
  }

  // Cleanup Phi Node and reinterprets
  X->replaceAllUsesWith(NPN);
  X->eraseFromParent();

  for (auto &I : Worklist)
    if (I->use_empty())
      I->eraseFromParent();

  return true;
}

bool SVEIntrinsicOpts::elideReinterprets(IntrinsicInst *X) {

  // If the reinterpret instruction operand is a PHI Node
  if (isa<PHINode>(X->getOperand(0)))
    return ProcessPhiNode(X);

  // If we have a reinterpret intrinsic X of type A which is converting from
  // another reinterpret Y of type B, and the source type of Y is A, then we can
  // elide away both reinterprets if there are no other users of Y.
  IntrinsicInst *Y = dyn_cast<IntrinsicInst>(X->getOperand(0));
  if (!Y)
    return false;
  unsigned ID = Y->getIntrinsicID();
  if (ID != Intrinsic::aarch64_sve_reinterpret_bool_b &&
      ID != Intrinsic::aarch64_sve_reinterpret_bool_h &&
      ID != Intrinsic::aarch64_sve_reinterpret_bool_w &&
      ID != Intrinsic::aarch64_sve_reinterpret_bool_d)
    return false;

  Value *SourceVal = Y->getOperand(0);
  if (X->getType() != SourceVal->getType())
    return false;

  X->replaceAllUsesWith(SourceVal);
  X->eraseFromParent();
  if (Y->use_empty())
    Y->eraseFromParent();

  return true;
}

static bool simplifyReduction(IntrinsicInst *II) {
  // Look for re-interprets of the predicate and data of the reduction.
  // If they convert from the same types, strip them and transform the
  // reduction into one using the unconverted types.
  auto PredOp = dyn_cast<IntrinsicInst>(II->getArgOperand(0));
  auto DataOp = dyn_cast<IntrinsicInst>(II->getArgOperand(1));
  if (!PredOp || !DataOp)
    return false;
  if (PredOp->getIntrinsicID() != Intrinsic::aarch64_sve_reinterpret_bool_b ||
      DataOp->getIntrinsicID() != Intrinsic::aarch64_sve_reinterpret_bool_b)
    return false;

  auto SrcPred = PredOp->getArgOperand(0);
  auto SrcData = DataOp->getArgOperand(0);
  if (SrcPred->getType() != SrcData->getType())
    return false;
  if (SrcData->getType()->getScalarSizeInBits() != 1)
    return false;

  Value *Ops[] = { SrcPred, SrcData };
  Type *Tys[] = { SrcData->getType() };
  Module *M = II->getParent()->getParent()->getParent();
  auto Fn = Intrinsic::getDeclaration(M, II->getIntrinsicID(), Tys);
  auto CI = CallInst::Create(Fn, Ops, II->getName(), II);
  II->replaceAllUsesWith(CI);
  II->eraseFromParent();
  if (PredOp->use_empty())
    PredOp->eraseFromParent();
  if (DataOp->use_empty())
    DataOp->eraseFromParent();
  return true;
}

bool SVEIntrinsicOpts::optimizePTestAny(IntrinsicInst *IntrI) {
  // Replace ptest intrinsic with generic or reduction intrinsic.
  auto MaskOp = dyn_cast<IntrinsicInst>(IntrI->getArgOperand(0));
  auto PredOp = dyn_cast<IntrinsicInst>(IntrI->getArgOperand(1));

  if (!MaskOp || !PredOp)
    return false;

  // ptest expects predicate registers of type <n x 16 x i1>, re-interpret to
  // this type is necessary if source predicate is not single byte width
  if (MaskOp->getIntrinsicID() != Intrinsic::aarch64_sve_reinterpret_bool_b ||
      PredOp->getIntrinsicID() != Intrinsic::aarch64_sve_reinterpret_bool_b)
    return false;

  auto SrcMask = MaskOp->getArgOperand(0);
  // Check reinterpret operand types match
  if (SrcMask->getType() != PredOp->getArgOperand(0)->getType())
    return false;

  auto SrcMaskCst = dyn_cast<Constant>(SrcMask);
  if (!SrcMaskCst || !SrcMaskCst->isAllOnesValue())
    return false;

  Value *Ops[] = { PredOp };
  Type *Tys[] = { IntrI->getType(), PredOp->getType() };
  Module *M = IntrI->getParent()->getParent()->getParent();
  auto Fn = Intrinsic::getDeclaration(M,
                                      Intrinsic::experimental_vector_reduce_or,
                                      Tys);
  auto CI = CallInst::Create(Fn, Ops, IntrI->getName(), IntrI);
  IntrI->replaceAllUsesWith(CI);
  IntrI->eraseFromParent();

  if (MaskOp->use_empty())
    MaskOp->eraseFromParent();
  return true;
}

bool SVEIntrinsicOpts::optimizeIntrinsic(Instruction *I) {
  IntrinsicInst *IntrI = dyn_cast<IntrinsicInst>(I);
  if (!IntrI)
    return false;

  switch (IntrI->getIntrinsicID()) {
  case Intrinsic::aarch64_sve_reinterpret_bool_b:
  case Intrinsic::aarch64_sve_reinterpret_bool_h:
  case Intrinsic::aarch64_sve_reinterpret_bool_w:
  case Intrinsic::aarch64_sve_reinterpret_bool_d:
    return elideReinterprets(IntrI);
  case Intrinsic::aarch64_sve_ptrue: {
    auto Cst = dyn_cast<ConstantInt>(IntrI->getOperand(0));
    if (!Cst || Cst->getZExtValue() != 31)
      return false;
    I->replaceAllUsesWith(ConstantInt::getTrue(IntrI->getType()));
    I->eraseFromParent();
    return true;
  }
  case Intrinsic::aarch64_sve_orv:
  case Intrinsic::aarch64_sve_andv:
    return simplifyReduction(IntrI);
  case Intrinsic::aarch64_sve_ptest_any:
    return optimizePTestAny(IntrI);
  default:
    return false;
  }
}

static bool isCntIntrinsic(Value *V, unsigned &Scale) {
  IntrinsicInst *CntIntr = dyn_cast<IntrinsicInst>(V);
  if (!CntIntr)
    return false;

  switch (CntIntr->getIntrinsicID()) {
  case Intrinsic::aarch64_sve_cntb:
    Scale = 16;
    break;
  case Intrinsic::aarch64_sve_cnth:
    Scale = 8;
    break;
  case Intrinsic::aarch64_sve_cntw:
    Scale = 4;
    break;
  case Intrinsic::aarch64_sve_cntd:
    Scale = 2;
    break;
  default:
    return false;
  }
  return true;
}

bool SVEIntrinsicOpts::optimizeCnt(Instruction *I) {
  // Replace an intrinsic call to cnt[bhwd] with a vscale constant.
  Value *LHS, *RHS;
  if (!I->getType()->isIntegerTy())
    return false;

  if (!match(I, m_Add(m_Value(LHS), m_Value(RHS))))
    return false;

  unsigned Scale;
  if (!isCntIntrinsic(LHS, Scale)) {
    std::swap(LHS, RHS);
    if (!isCntIntrinsic(LHS, Scale))
      return false;
  }

  // LHS should now contain the Cnt intrinsic.
  auto Cnt = cast<IntrinsicInst>(LHS);
  auto PredPat = dyn_cast<ConstantInt>(Cnt->getOperand(0));
  if (!PredPat || PredPat->getZExtValue() != 31)
    return false;
  Value *VScale = ConstantExpr::getMul(VScale::get(I->getType()),
                                       ConstantInt::get(I->getType(), Scale));
  Cnt->replaceAllUsesWith(VScale);
  Cnt->eraseFromParent();
  return true;
}

#define m_Reinterp_b m_Intrinsic<Intrinsic::aarch64_sve_reinterpret_bool_b>
bool SVEIntrinsicOpts::optimizeExtractElement(Instruction *I) {
  // Look for extractlements if lane 0, which could be a ptest first_active.
  // If so, the operand will probably be an AND of the Pg and the predicate to
  // test. Here we try to elide reinterprets on both operands of the AND and
  // ensure that the Pg is pushed down into the loop if possible so codegen
  // can peephole optimize it later.
  Instruction *AND, *ANDOp1, *ANDOp2;
  if (!match(I, m_ExtractElement(m_Instruction(AND), m_Zero())) ||
      !match(AND, m_And(m_Instruction(ANDOp1), m_Instruction(ANDOp2))))
    return false;

  Value *OpVal1, *OpVal2;
  if (match(ANDOp1, m_Reinterp_b(m_Value(OpVal1))) &&
      match(ANDOp2, m_Reinterp_b(m_Value(OpVal2)))) {
    if (OpVal1->getType() == OpVal2->getType()) {
      // The re-interprets are unnecessary, so now we can replace the entire
      // chain beginning at the extract, all the way up to the re-interprets.
      // I.e. replace: extract(and(reinterp(val1), reinterp(val2))) with:
      // extract(and(val1, val2)) with the new unconverted types.
      auto NewAnd =
          BinaryOperator::Create(Instruction::And, OpVal1, OpVal2,
                                 AND->getName(), cast<Instruction>(AND));
      I->setOperand(0, NewAnd);
      if (AND->use_empty())
        AND->eraseFromParent();
      if (ANDOp1->use_empty())
        ANDOp1->eraseFromParent();
      if (ANDOp2->use_empty())
        ANDOp2->eraseFromParent();
      // Another transform will convert ptrue predicates to IR vector constants,
      // then instcombine should clean up the AND.
      return true;
    }
  }
  return false;
}

bool SVEIntrinsicOpts::optimizeBlock(BasicBlock *BB) {
  bool Changed = false;
  for (auto II = BB->begin(), IE = BB->end(); II != IE;) {
    Instruction *I = &(*II);
    II = std::next(II);
    Changed |=
        optimizeIntrinsic(I) || optimizeCnt(I) || optimizeExtractElement(I);
  }
  return Changed;
}

bool SVEIntrinsicOpts::runOnFunction(Function &F) {
  DT = &getAnalysis<DominatorTreeWrapperPass>().getDomTree();
  this->F = &F;
  bool Changed = false;

  // Traverse the DT with an rpo walk so we see defs before uses, allowing
  // simplification to be done incrementally.
  BasicBlock *Root = DT->getRoot();
  ReversePostOrderTraversal<BasicBlock*> RPOT(Root);
  for (auto I = RPOT.begin(), E = RPOT.end(); I != E; ++I) {
    Changed |= optimizeBlock(*I);
  }

  return Changed;
}

