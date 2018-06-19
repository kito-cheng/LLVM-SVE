//==- PreInlinerTransforms.cpp - Transforms that must happen before inlining-=//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// The PreInlinerTransformsPass implements the following transform:
//
//   if (!ptr || ptr && ptr->val)
//     foo(ptr, ...)
//
//  ==>
//
//   if (!ptr)
//     foo(ptr, ...)
//   else if (ptr && ptr->val)
//     foo(ptr, ...)
//
// So that the InliningCost may decide it is worth inlining
// one (or either) of the calls to foo, possibly eliminating
// various conditions/branches in the inlined function foo
// because of knowledge that 'ptr' is nullptr or known
// not nullptr.
//
//===----------------------------------------------------------------------===//
#include "llvm/ADT/SmallSet.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/Pass.h"
#include "llvm/Transforms/IPO.h"
#include "llvm/Transforms/IPO/PreInlinerTransforms.h"
#include "llvm/Transforms/Utils/Cloning.h"

#define PASSNAME "preinliner-transforms"

using namespace llvm;
using namespace PatternMatch;

namespace {
class PreInlinerTransformsImpl {
private:
  int DuplicationThreshold = 10;
  CallGraph *CG;

public:
  PreInlinerTransformsImpl(CallGraph *CG) : CG(CG) {}

  bool preInlineTransforms(Module &M);
  bool processCallSite(CallSite CS);
  bool ConditionEliminatesArg(Value *, Value *, bool);
  void transformCallSite(CallSite CS);

};
} // anonymous namespace

static bool HasUsesOutsideParentBB(Instruction *I) {
  for (auto U : I->users())
    if (auto *UI = dyn_cast<Instruction>(U))
      if (UI->getParent() != I->getParent())
        return true;
  return false;
}

void PreInlinerTransformsImpl::transformCallSite(CallSite CS) {
  auto *CallBB = CS.getParent();
  SmallVector<BasicBlock *, 5> Preds;
  for (auto BBI = llvm::pred_begin(CallBB), BBE = llvm::pred_end(CallBB);
       BBI != BBE; ++BBI)
    Preds.push_back(*BBI);

  // Split up the CallSite's BB into a block with instructions
  // upto and including the call, and another block with the rest.
  auto NextII = std::next(BasicBlock::iterator(CS.getInstruction()));
  (void)CallBB->splitBasicBlock(NextII);

  // Get Call Graph nodes
  auto *CGNode = (*CG)[CS.getParent()->getParent()];
  auto *CalledCGNode = (*CG)[CS.getCalledFunction()];

  DenseMap<Value *, SmallVector<std::pair<Value *, BasicBlock *>, 5> > NewPhis;

  // Copy the CallBB into its predecessors.
  for (auto *BB : Preds) {
    llvm::ValueToValueMapTy Remap;
    auto *ClonedCallBB = DuplicateInstructionsInSplitBetween(
        CallBB, BB, CallBB->getTerminator(), Remap);

    // Update Call Graph.
    auto NewCS = CallSite(&*Remap[CS.getInstruction()]);
    CGNode->addCalledFunction(NewCS, CalledCGNode);

    // Fix up uses of copied nodes (except for PHI nodes, these
    // will remain the same).
    for (auto &I : *CallBB) {
      if (!isa<PHINode>(I) && HasUsesOutsideParentBB(&I))
        NewPhis[&I].emplace_back(&*Remap[&I], ClonedCallBB);
    }
  }

  // Start removing the old instructions upto call,
  // starting with update to Call Graph.
  CGNode->removeCallEdgeFor(CS);

  // Construct new PHIs in the original CallBB
  for (auto &KV : NewPhis) {
    auto *Phi = PHINode::Create(KV.first->getType(), KV.second.size(), "preinl",
                                CallBB->getFirstNonPHI());
    for (auto &ValBlock : KV.second)
      Phi->addIncoming(ValBlock.first, ValBlock.second);
    KV.first->replaceAllUsesWith(Phi);
  }

  // Remove the other instructions in the original Call BB
  // with exception of PHIs and terminator.
  SmallVector<Instruction *, 10> ToBeRemoved;
  auto BBI = BasicBlock::iterator(CallBB->getFirstNonPHI());
  auto BBE = BasicBlock::iterator(CallBB->getTerminator());
  for (; BBI != BBE; ++BBI)
    ToBeRemoved.push_back(&*BBI);

  while (ToBeRemoved.size())
    ToBeRemoved.pop_back_val()->eraseFromParent();
}

// Returns 'true' if the condition makes an assumption that leads to Arg
// being Constant
bool PreInlinerTransformsImpl::ConditionEliminatesArg(Value *Condition,
                                                      Value *Arg,
                                                      bool BranchOnTrue) {
  Value *LHS, *RHS;
  if (BranchOnTrue)
    if (match(Condition, m_And(m_Value(LHS), m_Value(RHS)))) {
      if (ConditionEliminatesArg(LHS, Arg, BranchOnTrue))
        return true;
      return ConditionEliminatesArg(RHS, Arg, BranchOnTrue);
    }

  auto *CI = dyn_cast<ICmpInst>(Condition);
  if (!CI || !CI->isEquality())
    return false;

  if (CI->getOperand(0) == Arg && isa<Constant>(CI->getOperand(1)))
    return (CI->getPredicate() == ICmpInst::ICMP_EQ && BranchOnTrue) ||
           (CI->getPredicate() == ICmpInst::ICMP_NE && !BranchOnTrue);

  return false;
}

void getPredPath(BasicBlock *Start, SmallVectorImpl<BasicBlock *> &Path) {
  Path.push_back(Start);
  while (auto *BBSP = Path.back()->getSinglePredecessor())
    Path.push_back(BBSP);
}

bool PreInlinerTransformsImpl::processCallSite(CallSite CS) {
  auto *ParentBB = CS.getParent();
  if (ParentBB->getSinglePredecessor() ||
      &*ParentBB->getParent()->begin() == ParentBB)
    return false;

  // Don't handle e.g. Invoke instructions
  if (isa<TerminatorInst>(CS.getInstruction()) || ParentBB->isEHPad())
    return false;

  // Calculate the number of instructions in this block
  // upto this point to see if it crosses the threshold.
  auto BBE = BasicBlock::iterator(CS.getInstruction());
  int Count = 0;
  for (auto BBI = ParentBB->begin(); BBI != BBE; ++BBI, ++Count)
    if (isa<CallInst>(&*BBI) || Count >= DuplicationThreshold)
      return false;

  bool DoTransform = false;
  for (auto BBI = llvm::pred_begin(ParentBB), BBE = llvm::pred_end(ParentBB);
       BBI != BBE && !DoTransform; ++BBI) {
    // We don't handle loops to itself
    if (ParentBB == *BBI)
      return false;

    // Collect path of direct predecessors to this callsite
    SmallVector<BasicBlock *, 3> PredPath = { ParentBB };
    getPredPath(*BBI, PredPath);

    // Walk up the path and induce constants from condition expressions
    // for each of the arguments to the call.
    for (size_t P = 1; P < PredPath.size() && !DoTransform; ++P) {
      BranchInst *BI = dyn_cast<BranchInst>(PredPath[P]->getTerminator());
      if (!BI || !BI->isConditional())
        continue;

      // For each argument, try to induce constants from condition expressions
      // on the path to the callsite.
      for (auto &Arg : CS.args()) {
        auto *ArgVal = dyn_cast<Value>(&Arg);
        if (!ArgVal)
          continue;

        // Test If the first branch successor is on the calculated path
        // to the CallSite.
        bool BranchOnTrue = BI->getSuccessor(0) == PredPath[P - 1];
        if (!ConditionEliminatesArg(BI->getCondition(), ArgVal, BranchOnTrue))
          continue;

        DoTransform = true;
        break;
      }
    }
  }

  if (DoTransform)
    transformCallSite(CS);

  return DoTransform;
}

bool PreInlinerTransformsImpl::preInlineTransforms(Module &M) {
  SmallVector<CallSite, 10> CallSites;
  for (Function &F : M) {
    if (F.isDeclaration())
      continue;

    for (BasicBlock &BB : F)
      for (Instruction &I : BB) {
        CallSite CS(cast<Value>(&I));
        if (!CS || isa<IntrinsicInst>(I))
          continue;

        if (CS.getCalledFunction() && !CS.isNoInline())
          CallSites.push_back(CS);
      }
  }

  bool Changed = false;
  for (auto CS : CallSites)
    Changed |= processCallSite(CS);

  return Changed;
}

//===---------------------------------------------------------------===//
// Run functions
//===---------------------------------------------------------------===//
bool PreInlinerTransforms::runOnModule(Module &M) {
  if (skipModule(M))
    return false;

  auto *CG = &getAnalysis<CallGraphWrapperPass>().getCallGraph();
  PreInlinerTransformsImpl PIT(CG);
  return PIT.preInlineTransforms(M);
}

PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM) {
  auto *CG = &AM.getResult<CallGraphAnalysis>(M);

  PreInlinerTransformsImpl PIT(CG);
  PIT.preInlineTransforms(M);

  PreservedAnalyses PA;
  PA.preserve<CallGraphAnalysis>();
  return PA;
}

char PreInlinerTransforms::ID;
INITIALIZE_PASS_BEGIN(PreInlinerTransforms, PASSNAME, "Pre-inlining transforms",
                      false, false)
INITIALIZE_PASS_DEPENDENCY(CallGraphWrapperPass)
INITIALIZE_PASS_END(PreInlinerTransforms, PASSNAME, "Pre-inlining transforms",
                    false, false)

Pass *llvm::createPreInlinerTransformsPass() {
  return new PreInlinerTransforms();
}
