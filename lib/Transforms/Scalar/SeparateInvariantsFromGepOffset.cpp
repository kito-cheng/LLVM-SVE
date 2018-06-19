//===- SeparateInvariantsFromGepOffset - Improve gep offset expressions----===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//
//===----------------------------------------------------------------------===//

#include "llvm/Transforms/Scalar.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/ScalarEvolution.h"
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
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include <algorithm>
using namespace llvm;
using namespace llvm::PatternMatch;

#define DEBUG_TYPE "separate-gepinv"

STATISTIC(NumVisited,   "Number of loops visited.");
STATISTIC(NumOptimized, "Number of loops optimized.");

namespace llvm {
  void initializeSeparateInvariantsFromGepOffsetPass(PassRegistry &);
}

namespace {
struct SeparateInvariantsFromGepOffset : public FunctionPass {
  static char ID; // Pass identification, replacement for typeid
  SeparateInvariantsFromGepOffset() : FunctionPass(ID) {
    initializeSeparateInvariantsFromGepOffsetPass(
        *PassRegistry::getPassRegistry());
  }

  bool runOnFunction(Function &F) override {
    this->F = &F;
    LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
    TTI = &getAnalysis<TargetTransformInfoWrapperPass>().getTTI(F);
    SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();

    bool Changed = false;
    for (auto I = LI->begin(), IE = LI->end(); I != IE; ++I)
      for (auto L = df_begin(*I), LE = df_end(*I); L != LE; ++L)
        Changed |= runOnLoop(*L);

    return Changed;
  }

  bool runOnLoop(Loop *L);
  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequiredID(LoopSimplifyID);
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addRequired<TargetTransformInfoWrapperPass>();
  }

private:
  Function *F;
  LoopInfo *LI;
  ScalarEvolution *SE;
  TargetTransformInfo *TTI;

  bool Optimize_Addressing(BasicBlock *);
};
}

char SeparateInvariantsFromGepOffset::ID = 0;
static const char *name = "Separate Invariants From GEP Offset";
INITIALIZE_PASS_BEGIN(SeparateInvariantsFromGepOffset, DEBUG_TYPE, name,
                      false, false)
INITIALIZE_PASS_DEPENDENCY(LoopInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LoopSimplify)
INITIALIZE_PASS_DEPENDENCY(ScalarEvolutionWrapperPass)
INITIALIZE_PASS_END(SeparateInvariantsFromGepOffset, DEBUG_TYPE, name,
                    false, false)

namespace llvm {
FunctionPass *createSeparateInvariantsFromGepOffsetPass() {
  return new SeparateInvariantsFromGepOffset();
}
}

/// Hoist out loop invariants from GEP offset by adding them to Res,
/// and returning an offset expression that does not include the items
/// in Res.
static Value *OptimizeGEPExpr(Value *V, IRBuilder<> *Builder,
                              ScalarEvolution *SE, Loop *L,
                              SmallVectorImpl<Value*> &Res, bool DoIt) {
  // Values used in matching
  Value *Op, *LHS, *RHS;

  // Constants and loop invariants are leafs.
  if (L->isLoopInvariant(V)) {
    Res.push_back(V);
    return nullptr;
  }

  // Match: (sext|zext)(add (nuw|nsw) %lhs, %rhs)
  // And look for loop invariants in %lhs and %rhs
  if (match(V, m_CombineOr(m_SExt(m_Value(Op)), m_ZExt(m_Value(Op))))) {
    // Match the extend with 'add' and no wrapping flags
    if (match(V, m_SExt(m_NSWAdd(m_Value(), m_Value()))) ||
        match(V, m_ZExt(m_NUWAdd(m_Value(), m_Value())))) {
      // Push cast through add
      Op = OptimizeGEPExpr(Op, Builder, SE, L, Res, DoIt);

      // Result is loop invariant, this node is also loop invariant
      if (!Op) {
        Res.pop_back();
        Res.push_back(V);
        return nullptr;
      }

      // Do not make any IR changes in analysis mode
      if (!DoIt)
        return V;

      // Recreate cast
      Instruction::CastOps Opcode = cast<CastInst>(V)->getOpcode();
      Op = Builder->CreateCast(Opcode, Op, V->getType());

      // Return updated offset
      return Op;
    }
  }

  // Match: add %lhs, %rhs
  // And return %lhs or %rhs if the other operand is loop invariant.
  if (match(V, m_Add(m_Value(LHS), m_Value(RHS)))) {
    LHS = OptimizeGEPExpr(LHS, Builder, SE, L, Res, DoIt);
    RHS = OptimizeGEPExpr(RHS, Builder, SE, L, Res, DoIt);

    // We lose nsw flags when rewriting the expression
    if (LHS && RHS && DoIt)
      return Builder->CreateAdd(LHS, RHS);

    // Result is loop invariant, this node is also loop invariant
    if (!LHS && !RHS) {
      Res.pop_back();
      Res.pop_back();
      Res.push_back(V);
      return nullptr;
    }

    // One of the operands is not loop invariant
    return LHS ? LHS : RHS;
  }

  // Non-loopinvariant leaf node
  return V;
}

// Compare by complexity, Constants first
static struct ComplexityCompare {
  bool operator() (Value *A, Value *B) { return isa<Constant>(A); };
} ComplexityCompareObj;

static Instruction *OptimizeGEP(GetElementPtrInst *Gep, IRBuilder<> *Builder,
                                ScalarEvolution *SE, Loop *L) {
  // See whether transform is beneficial
  SmallVector<Value*, 5> Factors;
  Value *NewOffset = OptimizeGEPExpr(Gep->getOperand(1), Builder, SE, L,
                                     Factors, false);

  // If not, skip
  if (Factors.size() == 0 || NewOffset == nullptr)
    return nullptr;

  // Do the transform!
  Factors.clear();
  NewOffset = OptimizeGEPExpr(Gep->getOperand(1), Builder, SE, L, Factors,
                              true);

  // Sort by complexity
  std::stable_sort(Factors.begin(), Factors.end(), ComplexityCompareObj);

  // Add loop invariants to pointer
  // Note: we'll lose the inbounds
  Value *Base = Gep->getPointerOperand();
  for (Value *V : Factors)
    Base = Builder->CreateGEP(Base, V);

  // Add the updated offset (without invariants)
  if (NewOffset)
    Base = Builder->CreateGEP(Base, NewOffset);

  return cast<Instruction>(Base);
}

// Transform:
//  %mul  = mul i64 %0, %1
//  %off0 = add i64 %mul, %index
//  %off1 = add i64 %off0, 1
//  %base = getelementptr inbounds float, float* %ptr, i64 %off1
// Into:
//  %mul   = mul i64 %0, %1
//  %base0 = getelementptr inbounds %ptr, %mul
//  %off0  = add i64 %index, 1
//  %base1 = getelementptr inbounds %base0, %off0
// TODO: Perhaps only do this for types/targets (e.g. SVE) that need this?
bool SeparateInvariantsFromGepOffset::Optimize_Addressing(BasicBlock *BB) {
  IRBuilder<> Builder(BB);

  // Look for 'getelementptr %liv, %offset'
  // where %liv is loop invariant, %offset is only used in
  // this gep, we optimize the expression.
  bool Changed = false;
  for (auto I = BB->begin(), E = BB->end(); I != E; ++I) {
    auto *Gep = dyn_cast<GetElementPtrInst>(I);
    if (!Gep || Gep->use_empty())
      continue;

    Loop *L = LI->getLoopFor(BB);
    if (!L)
      continue;

    if (Gep->getNumIndices() != 1)
      continue;

    if (!L->isLoopInvariant(Gep->getPointerOperand()))
      continue;

    if (L->isLoopInvariant(Gep->getOperand(1)))
      continue;

    if (Gep->getOperand(1)->getType()->isVectorTy())
      continue;

    if (!Gep->getOperand(1)->hasOneUse())
      continue;

    Builder.SetInsertPoint(BB, I);
    Instruction *Rtrn = OptimizeGEP(Gep, &Builder, SE, L);
    if (!Rtrn)
      continue;

    DEBUG(dbgs() << "Replacing " << Gep << "\nWith: " << Rtrn << "\n");
    I->replaceAllUsesWith(Rtrn);
    Changed = true;
  }

  return Changed;
}

bool SeparateInvariantsFromGepOffset::runOnLoop(Loop *L) {
  bool LoopOptimized = false;

  if (auto PreHeader = L->getLoopPreheader())
    LoopOptimized |= Optimize_Addressing(PreHeader);

  for (auto BB = L->block_begin(), BE = L->block_end(); BB != BE; ++BB)
    LoopOptimized |= Optimize_Addressing(*BB);

  ++NumVisited;
  if (LoopOptimized)
    ++NumOptimized;

  return LoopOptimized;
}
