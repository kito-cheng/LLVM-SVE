//===- BOSCC.cpp ------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// \brief BOSCC Pass
//
// This pass reintroduces control flow on vectorized loops. It does so by
// detecting the following masked.[store|gather] into a block...
//
// ----- input -----
// %BB:
//   ...
//   ...
//   void call masked.[store|gather](..., with predicate %P, ...)
//   NextInst ...
//   ...
//   br ...
// ------------------
//
// ... and generating a new CFG as follows:
//
// ----- output -----
// %BB:
//   ...
//   %test = test any true %P
//   BR: if (%test) %guarded else %skip
//
// %guarded:
//   void call masked.[store|gather](..., with predicate %P, ...)
//   BR unconditional %skip
//
// %skip:
//   NextInst ...
//   ...
// ------------------
//
// The name of the pass stands for 'branches-on-superword-condition-codes', a
// technique for reintroducing control flow in vectorized loops described in
// http://www.mcs.anl.gov/papers/P1411.pdf
//
// This implementation does not use all the analysis described in the paper, but
// the mechanics of the optimization are basically the same, as in 'check a
// predicate, branch around if all false'.
//
// Eventually this optimization will make use of profile data when available.
//
// TODO:
// 1. Check Width and Interleave hints set to 1 (see setAlreadyVectorized in
//    loop vecotrizer). It might require to extract LoopVectorizeHints class in
//    a separate module/headerfile?
// 2. Use Alias Analysis to populate the UnsafeToMerge set.
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/VectorUtils.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Transforms/Vectorize.h"
#include <tuple>
#include <deque>
#include <map>
#include <set>

using namespace llvm;

#define DEBUG_TYPE "boscc"

STATISTIC(NumGuardedStores, "Number of masked stores that can be"
                            " guarded by a test on the predicate");
STATISTIC(NumGuardedBlocks, "Number of guarded blocks generated");

namespace {
class BOSCC : public LoopPass {
public:
  static char ID; // Pass identification.

  /// Constructor.
  explicit BOSCC() : LoopPass(ID) {
    initializeBOSCCPass(*PassRegistry::getPassRegistry());
  }

  /// LoopPass interface.
  bool runOnLoop(Loop *L, LPPassManager &) override;

  /// LoopPass interface.
  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<LoopInfoWrapperPass>();
  }

private:
  /// Loop info structure to update after the transformation.
  LoopInfo *LI;

  /// Container for the places there to split. Each element is a triple holding:
  ///   1. The instruction to be guarded by teh new block.
  ///   2. The instruction that follows, that is used as the first instruction
  ///      of the "skip" block.
  ///   3. The predicate that need to be checked.
  using TripleTy =
      std::tuple<BasicBlock::iterator, BasicBlock::iterator, Value *>;
  std::deque<TripleTy> Splits;

  /// Holds a mapping between the predicate that is being tested and the guarded
  /// basic block generated, to avoid unnecessary duplication.
  std::map<Value *, BasicBlock *> PredicateMapping;

  /// Set of instructions that are not safe to merge in the same predicated
  /// block.
  ///
  /// The UnsafeToMerge set holds instructions that can be guarded by a
  /// predicate check but that are executed around a memory access (R or W)
  /// call/instruction as follows:
  ///
  ///     ...
  ///     InstN
  ///     ...
  ///     FirstInstI
  ///     ...
  ///     ...
  ///     InstReadWriteMem
  ///     ...
  ///     ...
  ///     SecondInstI
  ///     ...
  ///     ...
  ///
  /// Because the code-generation of the guarded blocks happens from bottom to
  /// top in the vector body sequence, we need to add both instructions (first
  /// and second) to the unsafe to merge set, otherwise it would not find any
  /// basic block In PredicateMapping to merge to when processing FirstInstI
  /// after SecondInstI.
  std::set<Instruction *> UnsafeToMerge;

  /// Populate the structures needed by the pass.
  void runOnBasicBlock(BasicBlock *);
};
}

char BOSCC::ID = 0;
INITIALIZE_PASS_BEGIN(BOSCC, "boscc",
                      "Inserts branches-on-superword-condition-codes", false,
                      false)
// must be executed after loop vectorization
INITIALIZE_PASS_DEPENDENCY(LoopVectorize)
INITIALIZE_PASS_END(BOSCC, "boscc",
                    "Inserts branches-on-superword-condition-codes", false,
                    false)

namespace llvm {
Pass *createBOSCCPass() { return new BOSCC(); }
}

bool BOSCC::runOnLoop(Loop *L, LPPassManager &LPM) {
  LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();

  // must be the innermost loop (as it is supposed to be vectorized
  if (!L->getSubLoops().empty())
    return false;

  // Width and Interleave loop metadata set to 1 should be check here.

  for (auto &BB : L->blocks()) {
    runOnBasicBlock(BB);
  }

  // Process the places to split.
  for (auto Pair : Splits) {
    auto Inst = std::get<0>(Pair);
    auto Pred = std::get<2>(Pair);
    BasicBlock *Before = Inst->getParent();
    assert(Before && "Original basic block is missing.");

    // Search for a block that is already used for that predicate, and also
    // check if the instruction is unsafe to merge.
    if ((PredicateMapping.find(Pred) == std::end(PredicateMapping)) ||
        (UnsafeToMerge.find(&*Inst) != std::end(UnsafeToMerge))) {
      // Create the new block structure
      BasicBlock *Guarded = Before->splitBasicBlock(Inst, "guarded.block");
      ++NumGuardedBlocks;
      assert(Guarded && "Guarded block creation failed.");
      auto Next = std::get<1>(Pair);
      BasicBlock *After =
          Next->getParent()->splitBasicBlock(Next, "unconditional.block");
      assert(After && "Post store block creation failed.");
      // Update loop infos.
      L->addBasicBlockToLoop(Guarded, *LI);
      L->addBasicBlockToLoop(After, *LI);

      // Create the conditional test and the branch instruction.
      auto OldTerm = Before->getTerminator();
      IRBuilder<> Builder(OldTerm);
      // FIXME: Make this generic for all targets once we have generic reductions.
      Value *Done = getAnyTrueReduction(Builder, Pred);
      Builder.CreateCondBr(Done, Guarded, After);
      OldTerm->eraseFromParent();
      PredicateMapping[Pred] = Guarded;
    } else {
      // This predicate has already a guarded block, just move the store there
      // as it is not in the UnsafeToMerge set. Since the 'Splits' container is
      // populated from the front end, all the stores already in the guarded
      // block are subsequent to teh once we are currently processing,
      // i.e. program order of stores is guaranteed.
      auto InsertPoint = PredicateMapping[Pred]->getFirstNonPHI();
      Inst->moveBefore(InsertPoint);
    }
  }

  DEBUG(L->verifyLoop());

  const bool CodeHasChanged = !Splits.empty();

  // Clear up the data used in this particular loop.
  Splits.clear();
  PredicateMapping.clear();
  UnsafeToMerge.clear();
  return CodeHasChanged;
}

void BOSCC::runOnBasicBlock(BasicBlock *BB) {
  for (auto II = BB->begin(), BE = BB->end(); II != BE; ++II) {
    if (auto CI = dyn_cast<CallInst>(II)) {
      Function *F = CI->getCalledFunction();
      if (!F)
        continue;

      Intrinsic::ID IID = F->getIntrinsicID();
      if (!IID)
        continue;

      if ((IID == Intrinsic::masked_store) ||
          (IID == Intrinsic::masked_scatter)) {
        DEBUG(dbgs() << "Found a masked store\n");

        // Skip the main predicate of the loop because it would not make sense
        // for it to contain no inactive elements.
        auto Pred = II->getOperand(3);
        if (isa<PHINode>(Pred)) {
          DEBUG(dbgs() << "Skipping stores using the loop main predicate.\n");
          continue;
        }

        auto Next = std::next(II);
        if (isa<BranchInst>(Next)) {
          // For safety we skip masked.store followed by a branch instruction,
          // which is unlikely, but we want to skip handling multiple blocks
          // branching.
          DEBUG(dbgs() << "Skipping a branch instruction.\n");
          continue;
        }

        // Ignore the last instruction in a block.
        if (Next == BE)
          continue;

        DEBUG(dbgs() << "Adding store:\n"; II->print(dbgs());
              dbgs() << "\n followed by:\n"; Next->print(dbgs());
              dbgs() << "\n");
        /// Add the intruction to the list of split points.
        Splits.emplace_front(II, Next, Pred);
        ++NumGuardedStores;
      }
    }
  }

  // Extra checks to make sure program order is mantained.
  for (auto TI = Splits.begin(), TE = Splits.end(); TI != TE; ++TI) {
    auto TNext = std::next(TI);
    if (TNext == TE)
      break;

    auto FirstInstI = std::get<0>(*TNext);
    auto SecondInstI = std::get<0>(*TI);

    // Skip instructions from different BBs.
    if (FirstInstI->getParent() != SecondInstI->getParent())
      continue;

    for (auto II = std::next(FirstInstI); II != SecondInstI; ++II) {
      // In reality we should check for writes/reads from the same memory
      // location of the store. Right now we just use a safe condition, we will
      // refine the choice by cheking aliasing pointers in the future.
      if (II->mayReadOrWriteMemory()) {
        UnsafeToMerge.insert(&*FirstInstI);
        UnsafeToMerge.insert(&*SecondInstI);
        DEBUG(dbgs() << "Unsafe to merge pair:\n";
              dbgs() << *FirstInstI << "\n"; dbgs() << *SecondInstI << "\n");
      }
    }
  }

  // Useful for seeing what's going on in the full block, for example to check
  // how many predicates are in the block and if any of them are equivalent.
  DEBUG(dbgs() << "\nUnique blocks being processed: \n";
        std::set<BasicBlock *> Blocks;
        for (auto Split : Splits) {
          auto Store = std::get<0>(Split);
          Blocks.insert(Store->getParent());
        }
        for (auto BB : Blocks)
          dbgs() << *BB;);
}
