//===- SVEPostVectorize - A SVE Loops Optimizer -----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This pass looks for idioms that can be expressed more efficiently by SVE
// intrinsics.  The main focus is the IR produced by the loop vectoriser when
// its using scalable vectors.  The goal of the loop vectorizer is to represent
// scalable vectors in a generic way.  However, cases exists whereby SVE
// supports instructions that are specifically intended to handle common
// vectorization features and it's our job to recongnise them within the generic
// IR and construct a suitable replacement.
//
// An important case is the calculation of predicates used by a vectorized loop.
// In most cases the resulting IR uses types that are difficult for the code
// generator.  For example, as the original scalar induction variable is often
// an i64, vector types of <n x 16 x i64> are not uncommon.
//
// However, SVE has a WHILE instruction that allows induction based predicates
// to be calculated from the original scalar variables, thus removing the need
// to handle such unfriendly vector types.
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include <algorithm>
using namespace llvm;
using namespace llvm::PatternMatch;

// Shortened intrinsic methods to improve the readablity of match lines.
#define m_PropFF m_Intrinsic<Intrinsic::propff>
#define m_WhileLO m_Intrinsic<Intrinsic::aarch64_sve_whilelo>

#define DEBUG_TYPE "sve-postvec"

STATISTIC(NumVisited,   "Number of loops visited.");
STATISTIC(NumOptimized, "Number of loops optimized.");
STATISTIC(NumWhileConversions, "Number of while intrinsics introduced.");
STATISTIC(NumRedundantPropFFs, "Number of propff instructions removed.");
STATISTIC(NumSimplePropFFs, "Number of propff instructions simplified.");

namespace llvm {
  void initializeSVEPostVectorizePass(PassRegistry &);
}

namespace {
struct SVEPostVectorize : public FunctionPass {
  static char ID; // Pass identification, replacement for typeid
  SVEPostVectorize() : FunctionPass(ID) {
    initializeSVEPostVectorizePass(*PassRegistry::getPassRegistry());
  }

  bool runOnFunction(Function &F) override {
    this->F = &F;
    LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
    TTI = &getAnalysis<TargetTransformInfoWrapperPass>().getTTI(F);

    bool Changed = false;
    for (auto I = LI->begin(), IE = LI->end(); I != IE; ++I)
      // Traverse loop nest in post-order so sub-loops are processed first.
      for (auto L = po_begin(*I), LE = po_end(*I); L != LE; ++L)
        Changed |= runOnLoop(*L);

    // To catch the most cases it's important to perform post-while conversion
    // after we have achieved full coverage of pre-while conversion.
    if (Changed)
      for (auto &BB : F)
        if (VisitedBlocks.count(&BB))
          Optimize_PostWhileConversion(&BB);

    VisitedBlocks.clear();
    return Changed;
  }

  bool runOnLoop(Loop *L);
  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequiredID(LoopSimplifyID);
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequired<TargetTransformInfoWrapperPass>();
  }

private:
  Function *F;
  LoopInfo *LI;
  TargetTransformInfo *TTI;
  SmallPtrSet<BasicBlock *, 16> VisitedBlocks;

  bool Optimize_PreWhileConversion(BasicBlock *BB);
  bool Optimize_PostWhileConversion(BasicBlock *BB);
  bool Transform_StructAddressing(BasicBlock *BB);

  Instruction *CreateBrkn(Type *Ty, Value *Op1, Value *Op2);
  Instruction *CreateWhile(Intrinsic::ID IntID, Type *Ty, Value *Op1,
                           Value *Op2);
};
}

char SVEPostVectorize::ID = 0;
static const char *name = "SVE Post Vectorisation";
INITIALIZE_PASS_BEGIN(SVEPostVectorize, DEBUG_TYPE, name, false, false)
INITIALIZE_PASS_DEPENDENCY(LoopInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LoopSimplify)
INITIALIZE_PASS_END(SVEPostVectorize, DEBUG_TYPE, name, false, false)

namespace llvm {
FunctionPass *createSVEPostVectorizePass() {return new SVEPostVectorize();}
}

bool SVEPostVectorize::runOnLoop(Loop *L) {
  bool LoopOptimized = false;
  // Look for idioms introduced by the loop vectorizer that can be expressed
  // more efficiently using SVE specific intrinsics.

  SmallVector<BasicBlock *, 8> Worklist;
  for (auto BB = L->block_begin(), BE = L->block_end(); BB != BE; ++BB)
    if (!VisitedBlocks.count(*BB))
      Worklist.push_back(*BB);
  if (auto PreHeader = L->getLoopPreheader())
    if (!VisitedBlocks.count(PreHeader))
      Worklist.push_back(PreHeader);

  while (!Worklist.empty()) {
    // First block should be preheader if it exists.
    auto BB = Worklist.pop_back_val();
    LoopOptimized |= Optimize_PreWhileConversion(BB);
    LoopOptimized |= Transform_StructAddressing(BB);
    VisitedBlocks.insert(BB);
  }

  ++NumVisited;
  if (LoopOptimized)
    ++NumOptimized;

  return LoopOptimized;
}

/// Create call to specified BRKN intrinsic.
///
Instruction* SVEPostVectorize::CreateBrkn(Type* Ty, Value* Op1, Value* Op2) {
  SmallVector<Type*, 2> Types = { Ty };
  SmallVector<Value*, 2> Args { ConstantInt::getTrue(Ty), Op1, Op2 };

  Intrinsic::ID IntID = Intrinsic::aarch64_sve_brkn_z;
  Function *Intrinsic = Intrinsic::getDeclaration(F->getParent(), IntID, Types);
  return CallInst::Create(Intrinsic->getFunctionType(), Intrinsic, Args);
}

/// Create call to specified WHILE intrinsic.
///
Instruction* SVEPostVectorize::CreateWhile(Intrinsic::ID IntID, Type* Ty,
                                             Value* Op1, Value* Op2) {
  SmallVector<Type*, 2> Types = { Ty, Op1->getType() };
  SmallVector<Value*, 2> Args { Op1, Op2 };

  Function *Intrinsic = Intrinsic::getDeclaration(F->getParent(), IntID, Types);
  return CallInst::Create(Intrinsic->getFunctionType(), Intrinsic, Args);
}

/// Returns the intrinsic matching the specified predicate.
///
static Intrinsic::ID getMatchingWhileInst(ICmpInst::Predicate P,
                                          ConstantInt *Stride) {
  if ((P == ICmpInst::ICMP_ULT) && (Stride->getZExtValue() == 1))
    return Intrinsic::aarch64_sve_whilelo;

  return Intrinsic::not_intrinsic;
}

/// Replace generic induction predicate calculation with a WHILE intrinsic.
///
bool SVEPostVectorize::Optimize_PreWhileConversion(BasicBlock *BB) {
  bool LoopChanged = false;

  for (Instruction &I : *BB) {
    if (match(&I, m_PropFF()) && I.getType()->isVectorTy()) {
      // This is the generic way the loop vectorizer produces a scalable
      // induction predicate from two scalars i.curr (the start value of i for
      // the current loop iteration) and i.end (the loop's termination value).
      //
      // %i.vec = seriesvector i64 %i.curr, i64 1 as <n x VF x i64>
      // %predicate.with_overflow = icmp ult <n x VF x i64> %i.vec, %i.end.splat
      // %predicate = propff <n x VF x i1> %i.cmp

      Value *LHS, *RHS;
      ICmpInst::Predicate Pred;
      if (!match(I.getOperand(1), m_ICmp(Pred, m_Value(LHS), m_Value(RHS))))
        continue;

      Value *Start, *End; ConstantInt *Stride;
      if (match(LHS, m_SeriesVector(m_Value(Start), m_ConstantInt(Stride))) &&
          match(RHS, m_SplatVector(m_Value(End))))
        ; // do nothing
      else if (match(LHS, m_SplatVector(m_Value(End))) &&
               match(RHS, m_SeriesVector(m_Value(Start),m_ConstantInt(Stride))))
        Pred = ICmpInst::getSwappedPredicate(Pred);
      else
        continue;

      Intrinsic::ID IntID = getMatchingWhileInst(Pred, Stride);
      if (IntID == Intrinsic::not_intrinsic) {
        DEBUG(dbgs() << "SVE: WHILE predicate mismatch "
                     << *I.getOperand(1) << "\n");
        continue;
      }

      auto* WhileInst = CreateWhile(IntID, I.getType(), Start, End);
      DEBUG(dbgs() << "SVE: Replaced " << *I.getOperand(1) << " by "
                   << *WhileInst << "\n");
      WhileInst->insertBefore(&I);
      I.setOperand(1, WhileInst);

      ++NumWhileConversions;
      LoopChanged = true;
      continue;
    }
  }

  return LoopChanged;
}

/// Find redundant PropFF instructions and remove them.
///
bool SVEPostVectorize::Optimize_PostWhileConversion(BasicBlock *BB) {
  bool LoopChanged = false;

  for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e;) {
    Instruction *I = &*it++;

    // propff(all_true, while(X, Y))  ==>  while(X, Y)
    if (match(I, m_PropFF(m_SplatVector(m_One()),
                          m_WhileLO(m_Value(), m_Value())))) {
      DEBUG(dbgs() << "SVE: Redundant PropFF " << *I << "\n");
      I->replaceAllUsesWith(I->getOperand(1));
      I->eraseFromParent();

      ++NumRedundantPropFFs;
      LoopChanged = true;
      continue;
    }

    // Consider the following pseudo IR:
    //
    // vec.ph:
    //   %cmp = <nx4xi1> whilelt(i64 %index.first, i64 %end.idx)
    //   br label %vector.body
    //
    // vec.body:
    //   %index = phi i64 [%index.first, %vec.ph], [%index.next, %vec.body]
    //   %pred = phi <nx4xi1> [%pred.first, %vec.ph], [%pred.next, %vec.body]
    //
    //   { some work }
    //
    //   %index.next = add nsw i64 %index, elementcount...
    //   %cmp = <nx4xi1> whilelt(i64 %index.next, i64 %end.idx)
    //   %pred.next = propff <nx4xi1> %pred, %cmp
    //
    //   { some work }
    //
    //   br i1 %cond, label %vec.body, label %vec.end
    //
    // vec.end:
    //
    // In this case the propff offers no value becuase the whilelt within the
    // vector body will do the right thing because regardless of the route into
    // vec.body we can prove '%index.next >= %index'.

    Value *Last;
    PHINode *IndexPHI, *PredPHI;
    if (match(I, m_PropFF(m_PHI(PredPHI),
                          m_WhileLO(m_NUWAdd(m_PHI(IndexPHI), m_Value()),
                                    m_Value(Last))))) {
      bool UnsafePHIOperand = false;

      for (unsigned i = 0, e = PredPHI->getNumIncomingValues(); i != e; ++i) {
        Value *PHIOp = PredPHI->getIncomingValue(i);
        BasicBlock *BB = PredPHI->getIncomingBlock(i);

        // If we are the PHI operand then '%index.next >= %index' is implied as
        // %index is a previous iteration's %index.next.
        if (PHIOp == I)
          continue;

        // If the PHI operand is all true, there is nothing to propagate.
        if (match(PHIOp, m_SplatVector(m_One())))
          continue;

        // Otherwise can we prove that %pred is calculated using the same logic
        // as %pred.next and that %pred.next's start value is derived from
        // %pred's start value.

        int Id = IndexPHI->getBasicBlockIndex(BB);
        Value *IndexFirst = Id != -1 ? IndexPHI->getIncomingValue(Id) : nullptr;

        auto WhileLO = m_WhileLO(m_Specific(IndexFirst), m_Specific(Last));
        if (match(PHIOp, WhileLO))
          continue;
        if (match(PHIOp, m_PropFF(m_SplatVector(m_One()), WhileLO)))
          continue;

        DEBUG(dbgs() << "SVE: Unexepected PHI operand " << *PHIOp << "\n");
        UnsafePHIOperand = true;
        break;
      }

      if (!UnsafePHIOperand) {
        DEBUG(dbgs() << "SVE: Redundant PropFF " << *I << "\n");
        I->replaceAllUsesWith(I->getOperand(1));
        I->eraseFromParent();

        ++NumRedundantPropFFs;
        LoopChanged = true;
        continue;
      }
    }

    //
    // we need some propagation but can we make it simpler than a propff
    //
    Value *Op2;
    if (match(I, m_PropFF(m_PHI(PredPHI), m_Value(Op2))))
    {
      bool BrknCompatible = true;

      for (unsigned i = 0, e = PredPHI->getNumIncomingValues(); i != e; ++i) {
        Value *PHIOp = PredPHI->getIncomingValue(i);

        // match everything where the following is true:
        //   if "any bit is false" then "last bit will also be false"

        if (PHIOp == I)
          continue;

        if (match(PHIOp, m_SplatVector(m_One())))
          continue;

        if (match(PHIOp, m_WhileLO(m_Value(), m_Value())))
          continue;

        DEBUG(dbgs() << "SVE: Failed to simplify " << *PHIOp << "\n");
        BrknCompatible = false;
        break;
      }

      if (!match(Op2, m_WhileLO(m_Value(), m_Value())))
        BrknCompatible = false;

      if (BrknCompatible) {
        // The worst case propff implementation is:
        //
        //   brkn(brkb(not(op1)),
        //        brkb(not(op2)))
        //
        // but by getting here we have determined that the bkrb/not applied to
        // both operands is redundent.

        auto* BrknInst = CreateBrkn(I->getType(), PredPHI, Op2);
        DEBUG(dbgs() << "SVE: Replaced " << *I << " by " << *BrknInst <<"\n");
        BrknInst->insertBefore(I);
        I->replaceAllUsesWith(BrknInst);
        I->eraseFromParent();

        ++NumSimplePropFFs;
        LoopChanged = true;
        continue;
      }
    }

    if (match(I, m_PropFF()))
      DEBUG(dbgs() << "SVE: Cannot prove " << *I << " is redundant.\n");
  }

  return LoopChanged;
}

/// Transform aggregate type addressing used by gathers/scatters to instead use
/// the first member address. This canonicalization is needed to optimize more
/// cases in the gather/scatter interleave lowering pass.
///
bool SVEPostVectorize::Transform_StructAddressing(BasicBlock *BB) {
  bool LoopChanged = false;
  // We look for patterns where a bitcast of a vector of pointers to aggregate
  // types is being fed by a GEP, with the GEP using a vector of offsets of
  // generated by a seriesvector.

  SmallVector<Instruction *, 8> ProcessedInsts;

  for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e; ++it) {
    Instruction *I = &*it;
    Value *BC, *GEPVal;
    if (!(match(I, m_Intrinsic<Intrinsic::masked_gather>(m_Value(BC))) ||
          match(I, m_Intrinsic<Intrinsic::masked_scatter>(m_Value(),
                                                          m_Value(BC)))))
      continue;

    if (!(match(BC, m_BitCast(m_Value(GEPVal))) &&
          isa<GetElementPtrInst>(GEPVal)))
      continue;

    auto *GEP = cast<GetElementPtrInst>(GEPVal);
    if (!isa<GetElementPtrInst>(GEP->getPointerOperand()))
      continue;
    Instruction *Offsets = dyn_cast<Instruction>(GEP->getOperand(1));
    Value *SVBase;
    ConstantInt *SVStep;
    if (!Offsets ||
        !match(Offsets, m_SeriesVector(m_Value(SVBase), m_ConstantInt(SVStep))))
      continue;

    // If the seriesvector step isn't 1, then this needs to be a real
    // gather/scatter.
    if (SVStep->getZExtValue() != 1)
      continue;

    auto BCInst = cast<BitCastInst>(BC);
    Type *SrcEltTy =
        BCInst->getSrcTy()->getVectorElementType()->getPointerElementType();
    if (!SrcEltTy->isAggregateType())
      continue;

    // The struct elements must not be themselves structs.
    auto IsAggTy = [](Type *Ty) { return Ty->isAggregateType(); };
    if (auto STy = dyn_cast<StructType>(SrcEltTy)) {
      if (std::any_of(STy->element_begin(), STy->element_end(), IsAggTy))
        continue;
    }

    // The size of the destination type must divide that of the aggregate type.
    auto DL = &F->getParent()->getDataLayout();
    Type *DstEltTy =
        BCInst->getDestTy()->getVectorElementType()->getPointerElementType();
    unsigned DestSize = DL->getTypeStoreSize(DstEltTy);
    unsigned AggSize = DL->getTypeStoreSize(SrcEltTy);
    if (AggSize % DestSize) {
      DEBUG(dbgs() << "SVE: Can't optimize gather/scatter. Aggregate size not"
                      " multiple of load/store elt size");
      continue;
    }

    // Create a new seriesvec to scale the base offset by the effective stride.
    unsigned Stride = AggSize / DestSize;
    IRBuilder<> B(cast<Instruction>(Offsets));
    // We need to create the same kind of scaling as non-aggregate
    // gathers/scatters in the loop, in order for LSR to create a single new
    // induction variable for all of them.
    auto NewBase = B.CreateShl(
        SVBase, ConstantInt::get(SVBase->getType(), Log2_64(Stride)));
    B.SetInsertPoint(I);
    auto NewOffsets = B.CreateSeriesVector(
        cast<VectorType>(Offsets->getType())->getElementCount(), NewBase,
        ConstantInt::get(SVStep->getType(), Stride));

    // The base address for the gather/scatter should be another GEP, which
    // we need to index further to get the element address.
    auto BaseGEP = cast<GetElementPtrInst>(GEP->getPointerOperand());
    SmallVector<Value *, 6> Indices;
    for (auto II = BaseGEP->idx_begin(), IE = BaseGEP->idx_end(); II != IE;
         ++II)
      Indices.push_back(*II);
    Indices.push_back(B.getInt32(0));
    auto NewBaseGEP = GetElementPtrInst::Create(
        nullptr, BaseGEP->getPointerOperand(), Indices, "basegep", BaseGEP);
    NewBaseGEP->setDebugLoc(BaseGEP->getDebugLoc());

    auto NewGEP = GetElementPtrInst::Create(nullptr, NewBaseGEP, {NewOffsets});
    NewGEP->setDebugLoc(GEP->getDebugLoc());
    B.Insert(NewGEP);
    auto NewBC = B.CreateBitCast(NewGEP, BC->getType());
    BC->replaceAllUsesWith(NewBC);

    ProcessedInsts.push_back(BCInst);
    ProcessedInsts.push_back(GEP);
    ProcessedInsts.push_back(BaseGEP);

    LoopChanged = true;
  }

  for (auto &I : ProcessedInsts) {
    if (I->getNumUses() == 0)
      I->eraseFromParent();
  }
  return LoopChanged;
}
