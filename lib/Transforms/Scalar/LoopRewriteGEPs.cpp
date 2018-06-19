//===- LoopRewriteGEPs.cpp ------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This pass attempts to provide GVN with more opportunities to eliminate
// partially redundant loads.  One of the barriers is when GVN cannot perform
// PHI translation, which occurs when address calculations use a common index
// (most likely the loop's induction variable) rather than a common base.
//
// We solve this by transforming:
//   %p1 = getelementptr float, float* %base, i64 %indvars.iv
//   %p2 = getelementptr float, float* %anotherbase, i64 %indvars.iv
// into:
//   %p1 = getelementptr float, float* %base, i64 %indvars.iv
//   %tmp = add i64 indvars.iv, <Constant>((%anotherbase-%base)/sizeof(float))
//   %p2 = getelementptr float, float* %base, i64 %tmp
//
//===----------------------------------------------------------------------===//

#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Support/Debug.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Scalar/LoopPassManager.h"
#include "llvm/Transforms/Utils/LoopUtils.h"

using namespace llvm;

#define DEBUG_TYPE "rewrite-geps-in-loop"

namespace {
class LoopRewriteGEPsPass : public LoopPass {
public:
  static char ID;
  ScalarEvolution *SE;

  LoopRewriteGEPsPass() : LoopPass(ID) {
    initializeLoopRewriteGEPsPassPass(*PassRegistry::getPassRegistry());
  }

  bool processLoop(Loop *L) {
    if (!L->empty())
      return false;

    bool Changed = false;

    for (BasicBlock *BB : L->blocks()) {
      const DataLayout &DL = BB->getModule()->getDataLayout();
      SmallVector<GetElementPtrInst *, 10> VisitedGEPs;

      for (Instruction &I : *BB) {
        auto *GEP = dyn_cast<GetElementPtrInst>(&I);
        if (!GEP)
          continue;
        if (GEP->getNumOperands() != 2)
          continue;
        // FIXME: Vector GEPs are not SCEVable
        if (GEP->getType()->isVectorTy())
          continue;

        Type* DataTy = GEP->getResultElementType();
        int64_t DataSize = DL.getTypeAllocSize(DataTy);
        Value* OrigIdx = GEP->getOperand(1);

        GetElementPtrInst *RelatedGEP = nullptr;
        Constant *IdxInc;

        // Look for a GEP that's identical in all but base pointer.
        for (auto VisitedGEP : VisitedGEPs) {
          if (VisitedGEP->getResultElementType() != DataTy)
            continue;
          if (VisitedGEP->getOperand(1) != OrigIdx)
            continue;

          // Calculate the distance betwen the two base pointers...
          auto *Dist = SE->getMinusSCEV(SE->getSCEV(GEP),
                                        SE->getSCEV(VisitedGEP));

          //...and if it's constant and of the correct scale.
          if (isa<SCEVConstant>(Dist)) {
            APInt CDist = cast<SCEVConstant>(Dist)->getAPInt();
            if (CDist.srem(DataSize))
              continue;

            // Can we calculate NewIdx without sext/trunc of the original?
            auto *IdxTy = cast<IntegerType>(OrigIdx->getType());
            APInt IdxIncVal1 = CDist.sdiv(DataSize);
            APInt IdxIncVal2 = IdxIncVal1.sextOrTrunc(IdxTy->getBitWidth());
            if (!APInt::isSameValue(IdxIncVal1, IdxIncVal2))
              continue;

            RelatedGEP = VisitedGEP;
            IdxInc = ConstantInt::get(IdxTy, IdxIncVal2);
            break;
          }
        }

        if (!RelatedGEP) {
          // Nothing we can do, but it's base pointer might be useful later.
          VisitedGEPs.push_back(GEP);
          continue;
        }

        DEBUG(dbgs() << "Rewrite GEP: Original GEP: " << *GEP << '\n');

        // Make a new better GEP.
        auto *NewIdx = BinaryOperator::CreateAdd(OrigIdx, IdxInc, "", GEP);
        GEP->setOperand(0, RelatedGEP->getOperand(0));
        GEP->setOperand(1, NewIdx);
        Changed = true;

        DEBUG(dbgs() << "Rewrite GEP: Related GEP : " << *RelatedGEP << '\n');
        DEBUG(dbgs() << "Rewrite GEP: New GEP Idx : " << *NewIdx << '\n');
        DEBUG(dbgs() << "Rewrite GEP: New GEP     : " << *GEP << '\n');
      }
    }

    return Changed;
  }

  bool runOnLoop(Loop *L, LPPassManager &LPM) override {
    if (skipLoop(L))
      return false;

    SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();
    return processLoop(L);
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesCFG();
    AU.addRequired<ScalarEvolutionWrapperPass>();
  }
};
}

char LoopRewriteGEPsPass::ID = 0;
INITIALIZE_PASS_BEGIN(LoopRewriteGEPsPass, DEBUG_TYPE,
                      "Rewrite GEPs in Loop", false, false)
INITIALIZE_PASS_DEPENDENCY(LoopPass)
INITIALIZE_PASS_DEPENDENCY(ScalarEvolutionWrapperPass)
INITIALIZE_PASS_END(LoopRewriteGEPsPass, DEBUG_TYPE,
                    "Rewrite GEPs in Loop", false, false)

Pass *llvm::createLoopRewriteGEPsPass() {
  return new LoopRewriteGEPsPass();
}
