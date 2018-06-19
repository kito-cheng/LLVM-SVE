//===- LoopSpeculativeBoundsCheck.cpp - Versioning for may-alias tripcount-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// TODO: Rewrite description; this was based on LoopVersioningLICM
//
// When alias analysis is uncertain about the aliasing between any two accesses,
// it will return MayAlias. This uncertainty from alias analysis restricts LICM
// from proceeding further. In cases where alias analysis is uncertain we might
// use loop versioning as an alternative.
//
// Loop Versioning will create a version of the loop with aggressive aliasing
// assumptions in addition to the original with conservative (default) aliasing
// assumptions. The version of the loop making aggressive aliasing assumptions
// will have all the memory accesses marked as no-alias. These two versions of
// loop will be preceded by a memory runtime check. This runtime check consists
// of bound checks for all unique memory accessed in loop, and it ensures the
// lack of memory aliasing. The result of the runtime check determines which of
// the loop versions is executed: If the runtime check detects any memory
// aliasing, then the original loop is executed. Otherwise, the version with
// aggressive aliasing assumptions is used.
//
// Following are the top level steps:
//
// a) Perform LoopSpeculativeBoundsCheck's feasibility check.
// b) If loop is a candidate for versioning then create a memory bound check,
//    by considering all the memory accesses in loop body.
// c) Clone original loop and set all memory accesses as no-alias in new loop.
// d) Set original loop & versioned loop as a branch target of the runtime check
//    result.
//
// It transforms loop as shown below:
//
//                         +----------------+
//                         |Runtime Memcheck|
//                         +----------------+
//                                 |
//              +----------+----------------+----------+
//              |                                      |
//    +---------+----------+               +-----------+----------+
//    |Orig Loop Preheader |               |Cloned Loop Preheader |
//    +--------------------+               +----------------------+
//              |                                      |
//    +--------------------+               +----------------------+
//    |Orig Loop Body      |               |Cloned Loop Body      |
//    +--------------------+               +----------------------+
//              |                                      |
//              +----------+--------------+-----------+
//                                 |
//                        +--------+--------+
//                        |Exit Block (Join)|
//                        +-----------------+
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/MapVector.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/Analysis/GlobalsModRef.h"
#include "llvm/Analysis/LoopAccessAnalysis.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpander.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/Analysis/VectorUtils.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/MDBuilder.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/PredIteratorCache.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/Transforms/Utils/LoopVersioning.h"
#include "llvm/Transforms/Utils/ValueMapper.h"

#define DEBUG_TYPE "loop-speculative-bounds-check"

using namespace llvm;
using namespace llvm::PatternMatch;

namespace {
struct LoopSpeculativeBoundsCheck : public LoopPass {
  static char ID;

  bool runOnLoop(Loop *L, LPPassManager &LPM) override;
  bool processLoop(Loop *L);

  using llvm::Pass::doFinalization;

  bool doFinalization() override { return false; }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesCFG();
    AU.addRequired<AAResultsWrapperPass>();
    AU.addRequired<DominatorTreeWrapperPass>();
    AU.addRequiredID(LCSSAID);
    AU.addRequired<LoopAccessLegacyAnalysis>();
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequiredID(LoopSimplifyID);
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addRequired<TargetLibraryInfoWrapperPass>();
    AU.addPreserved<AAResultsWrapperPass>();
    AU.addPreserved<GlobalsAAWrapperPass>();
  }

  LoopSpeculativeBoundsCheck()
      : LoopPass(ID), AA(nullptr), SE(nullptr), LI(nullptr), DT(nullptr),
        TLI(nullptr), LAA(nullptr), LAI(nullptr), IsReadOnlyLoop(true) {
    initializeLoopSpeculativeBoundsCheckPass(*PassRegistry::getPassRegistry());
  }

  AliasAnalysis *AA;         // Current AliasAnalysis information
  ScalarEvolution *SE;       // Current ScalarEvolution
  LoopInfo *LI;              // Current LoopInfo
  DominatorTree *DT;         // Dominator Tree for the current Loop.
  TargetLibraryInfo *TLI;    // TargetLibraryInfo for constant folding.
  LoopAccessLegacyAnalysis *LAA;   // Current LoopAccessLegacyAnalysis
  const LoopAccessInfo *LAI; // Current Loop's LoopAccessInfo

  // TODO: Convert all uses to parameters?
  ValueToValueMapTy VMap;
  SmallVector<Instruction*, 4> DefsUsedOutside;

  bool IsReadOnlyLoop;          // Read only loop marker.
  Value *GlobalBoundPtr;        // Pointer to global loop bound variable
  LoadInst *GlobalLoadInst;     // Pointer to load from global

  bool isSuitableLoop(Loop *, AliasSetTracker &);
  bool legalLoopStructure(Loop *);
  bool legalLoopInstructions(Loop *);
  bool checkMemoryAccesses(AliasSetTracker &);
  bool instructionSafeForVersioning(Loop *, Instruction *);
  void addPHINodes(Loop *, Loop *);
  StringRef getPassName() const override { return "Loop SBC"; }
};
}

/// \brief Check loop structure and confirms it's good
///  for LoopSpeculativeBoundsCheck.
bool LoopSpeculativeBoundsCheck::legalLoopStructure(Loop *L) {
  // If we can compute a tripcount, we don't need to do anything.
  const SCEV *ExitCount = SE->getBackedgeTakenCount(L);
  if (ExitCount != SE->getCouldNotCompute()) {
    DEBUG(dbgs() << "    loop has known exit count, speculation unnecessary\n");
    return false;
  }

  // Loop must have a preheader, if not return false.
  if (!L->getLoopPreheader()) {
    DEBUG(dbgs() << "    loop preheader is missing\n");
    return false;
  }
  // Loop should be innermost loop, if not return false.
  if (L->getSubLoops().size()) {
    DEBUG(dbgs() << "    loop is not innermost\n");
    return false;
  }
  // Loop should have a single backedge, if not return false.
  // TODO: Revisit once we have multi-backedge support in the SLV?
  if (L->getNumBackEdges() != 1) {
    DEBUG(dbgs() << "    loop has multiple backedges\n");
    return false;
  }
  // Loop must have a single exiting block, if not return false.
  // TODO: Relax restriction in future to help out the SLV.
  if (!L->getExitingBlock()) {
    DEBUG(dbgs() << "    loop has multiple exiting block\n");
    return false;
  }
  // We only handle bottom-tested loop, i.e. loop in which the condition is
  // checked at the end of each iteration. With that we can assume that all
  // instructions in the loop are executed the same number of times.
  if (L->getExitingBlock() != L->getLoopLatch()) {
    DEBUG(dbgs() << "    loop is not bottom tested\n");
    return false;
  }
  // Parallel loops must not have aliasing loop-invariant memory accesses.
  // Hence we don't need to version anything in this case.
  if (L->isAnnotatedParallel()) {
    DEBUG(dbgs() << "    Parallel loop is not worth versioning\n");
    return false;
  }

  // Loop should have a dedicated exit block, if not return false.
  if (!L->hasDedicatedExits()) {
    DEBUG(dbgs() << "    loop does not have dedicated exit blocks\n");
    return false;
  }

  // Find an appropriate compare against a sign-extended load from a global
  // pointer; this prevents vectorization, so being able to conditionally
  // hoist the load out of the loop will allow scalar evolution to figure
  // things out and allow vectorization.
  //
  // TODO: Allow more cases than just icmp(ivar,ext?(ld(global)))
  auto *EBlock = L->getExitingBlock();
  auto *Term = EBlock->getTerminator();
  auto *ExitBlock = L->getExitBlock();
  ICmpInst::Predicate Pred;
  BasicBlock *TBlock, *FBlock;
  PHINode* IVar;
  Value* Addr;
  Value* Ld;

  if (match(Term, m_Br(m_ICmp(Pred, m_Add(m_PHI(IVar), m_One()),
                              m_AnyExtOrNone(m_Value(Ld))),
                       TBlock, FBlock)) &&
      match(Ld, m_Load(m_Value(Addr))) &&
      isa<GlobalVariable>(Addr) &&
      (TBlock == ExitBlock || FBlock == ExitBlock) &&
      L->isLoopInvariant(Addr)) {
    GlobalBoundPtr = Addr;
    GlobalLoadInst = cast<LoadInst>(Ld);
  } else {
    DEBUG(dbgs() << "    loop condition not a comparison with a global var\n");
    return false;
  }

  if (!L->contains(GlobalLoadInst->getParent())) {
    DEBUG(dbgs() << "    global load is not part of the loop\n");
    return false;
  }

  // Some safety checks to make sure the load will always occur. The checks for
  // no throwing instructions later is also part of this...
  // Get the exit blocks for the current loop.
  SmallVector<BasicBlock*, 8> ExitBlocks;
  L->getExitBlocks(ExitBlocks);

  // Verify that the block dominates each of the exit blocks of the loop.
  for (auto *EB : ExitBlocks)
    if (!DT->dominates(GlobalLoadInst->getParent(), EB)) {
      DEBUG(dbgs() << "    GlobalLoadInst doesn't dominate exit block\n");
      return false;
    }

  // As a degenerate case, if the loop is statically infinite then we haven't
  // proven anything since there are no exit blocks.
  if (ExitBlocks.empty()) {
    DEBUG(dbgs() << "    No exit blocks (infinite loop)\n");
    return false;
  }

  // Passed all structural checks, so onto testing individual instructions
  // and memory accesses...
  return true;
}

/// \brief Check memory accesses in loop and confirms it's good for
/// LoopSpeculativeBoundsCheck.
bool LoopSpeculativeBoundsCheck::checkMemoryAccesses(AliasSetTracker &CurAST) {
  bool HasMayAlias = false;
  bool HasMod = false;
  // Memory check:
  // Find the alias set for the load which the loop condition depends upon,
  // then check the types are consistent, that we have potential writes in
  // the set, and that they *may* alias -- if they *must*, we can't help.
  // If there's no aliasing at all, LICM should have already dealt with this.
  // If it hasn't, probably worth looking into why...
  uint64_t Size = 0;
  auto &DL = GlobalLoadInst->getModule()->getDataLayout();
  if (GlobalLoadInst->getType()->isSized())
    Size = DL.getTypeStoreSize(GlobalLoadInst->getType());
  else {
    DEBUG(dbgs() << "    Unable to find size for GlobalLoadInst\n");
    return false;
  }

  AAMDNodes AAInfo;
  GlobalLoadInst->getAAMetadata(AAInfo);

  const AliasSet *AS = CurAST.getAliasSetForPointerIfExists(GlobalBoundPtr,
                                                            Size, AAInfo);
  if (!AS) {
    DEBUG(dbgs() << "    Unable to find AliasSet for Global Load\n");
    return false;
  }

  // With MustAlias its not worth adding runtime bound check.
  // If we only alias with ourselves (single pointer in the set), then
  // it's safe to proceed.
  if (AS->isMustAlias() && (AS->getRefCount() > 1)) {
    DEBUG(dbgs() << "    GlobalLoadInst in a MustAlias set\n");
    return false;
  }

  Value *SomePtr = AS->begin()->getValue();
  bool TypeCheck = true;
  // Check for Mod & MayAlias
  HasMayAlias |= AS->isMayAlias();
  HasMod |= AS->isMod();
  for (const auto &A : *AS) {
    Value *Ptr = A.getValue();
    // Alias tracker should have pointers of same data type.
    TypeCheck = (TypeCheck && (SomePtr->getType() == Ptr->getType()));
  }

  // Ensure types should be of same type.
  if (!TypeCheck) {
    DEBUG(dbgs() << "    Alias tracker type safety failed!\n");
    return false;
  }
  // Ensure loop body shouldn't be read only.
  if (!HasMod) {
    DEBUG(dbgs() << "    No memory modified in loop body\n");
    return false;
  }
  // Make sure alias set has may alias case.
  // If there no alias memory ambiguity, return false.
  if (!HasMayAlias) {
    DEBUG(dbgs() << "    No ambiguity in memory access.\n");
    return false;
  }
  return true;
}

/// \brief Check loop instructions safe for Loop versioning.
/// It returns true if it's safe else returns false.
/// Consider following:
/// 1) Check all load store in loop body are non atomic & non volatile.
/// 2) Check function call safety, by ensuring its not accessing memory.
/// 3) Loop body shouldn't have any may throw instruction.
bool LoopSpeculativeBoundsCheck::instructionSafeForVersioning(Loop *L,
                                                              Instruction *I) {
  assert(I != nullptr && "Null instruction found!");
  // Check function call safety
  if (isa<CallInst>(I) && !AA->doesNotAccessMemory(CallSite(I))) {
    DEBUG(dbgs() << "    Unsafe call site found.\n");
    return false;
  }
  // Avoid loops with possiblity of throw
  if (I->mayThrow()) {
    DEBUG(dbgs() << "    May throw instruction found in loop body\n");
    return false;
  }
  // If current instruction is load instructions
  // make sure it's a simple load (non atomic & non volatile)
  if (I->mayReadFromMemory()) {
    LoadInst *Ld = dyn_cast<LoadInst>(I);
    if (!Ld || !Ld->isSimple()) {
      DEBUG(dbgs() << "    Found a non-simple load.\n");
      return false;
    }
  }
  // If current instruction is store instruction
  // make sure it's a simple store (non atomic & non volatile)
  else if (I->mayWriteToMemory()) {
    StoreInst *St = dyn_cast<StoreInst>(I);
    if (!St || !St->isSimple()) {
      DEBUG(dbgs() << "    Found a non-simple store.\n");
      return false;
    }
    IsReadOnlyLoop = false;
  }
  return true;
}

/// \brief Check loop instructions and confirms it's good for
/// LoopSpeculativeBoundsCheck.
bool LoopSpeculativeBoundsCheck::legalLoopInstructions(Loop *L) {
  // Resetting counters.
  IsReadOnlyLoop = true;
  // Iterate over loop blocks and instructions of each block and check
  // instruction safety.
  for (auto *Block : L->getBlocks())
    for (auto &Inst : *Block) {
      // If instruction is unsafe just return false.
      if (!instructionSafeForVersioning(L, &Inst))
        return false;

      // If there's an outside use of this instruction, record that so
      // we can build a phi later.
      for (auto *U : Inst.users()) {
        Instruction *Use = cast<Instruction>(U);
        if (!L->contains(Use->getParent())) {
          DefsUsedOutside.push_back(&Inst);
          break;
        }
      }
    }

  // Read only loop should have already been handled, but we know there's
  // not a possible alias between the loop condition boundary and any
  // write in the loop; moving the load won't help SE check the loop
  // tripcount for further optimizations.
  if (IsReadOnlyLoop) {
    DEBUG(dbgs() << "    Found a read-only loop!\n");
    return false;
  }

  return true;
}

/// \brief Checks legality for LoopSpeculativeBoundsCheck by considering:
/// a) loop structure legality   b) loop instruction legality
/// c) loop memory access legality.
/// Return true if legal else returns false.
bool LoopSpeculativeBoundsCheck::isSuitableLoop(Loop *L,
                                                AliasSetTracker &CurAST) {
  DEBUG(dbgs() << "Loop: " << *L);
  // Check loop structure legality.
  if (!legalLoopStructure(L)) {
    DEBUG(dbgs()
          << "    Loop structure not suitable for "
          << "LoopSpeculativeBoundsCheck\n\n");
    return false;
  }
  // Check loop instruction legality.
  if (!legalLoopInstructions(L)) {
    DEBUG(dbgs()
          << "    Loop instructions not suitable for "
          << "LoopSpeculativeBoundsCheck\n\n");
    return false;
  }
  // Check loop memory access legality.
  if (!checkMemoryAccesses(CurAST)) {
    DEBUG(dbgs()
          << "    Loop memory access not suitable for "
          << "LoopSpeculativeBoundsCheck\n\n");
    return false;
  }
  // Loop versioning is feasible, return true.
  DEBUG(dbgs() << "    Loop Speculative Bounds Check possible\n\n");
  return true;
}

void LoopSpeculativeBoundsCheck::addPHINodes(Loop *SpeculativeLoop,
                                             Loop *NonSpeculativeLoop) {
  BasicBlock *PHIBlock = SpeculativeLoop->getExitBlock();
  assert(PHIBlock && "No single successor to loop exit block");

  for (auto *Inst : DefsUsedOutside) {
    auto *NonSpeculativeLoopInst = cast<Instruction>(VMap[Inst]);
    PHINode *PN = nullptr;
    bool Found = false;

    // First see if we have a single-operand PHI with the value defined by the
    // original loop.
    for (auto I = PHIBlock->begin(); (PN = dyn_cast<PHINode>(I)); ++I) {
      if (PN->getIncomingValue(0) == Inst) {
        Found = true;

        // Add the new incoming value from the non-versioned loop.
        PN->addIncoming(NonSpeculativeLoopInst,
                        NonSpeculativeLoop->getExitingBlock());
      }
    }
    // If not create it.
    if (!Found) {
      PN = PHINode::Create(Inst->getType(), 2, Inst->getName() + ".lver",
                           &PHIBlock->front());
      for (auto *User : Inst->users())
        if (!SpeculativeLoop->contains(cast<Instruction>(User)->getParent()))
          User->replaceUsesOfWith(Inst, PN);
      PN->addIncoming(Inst, SpeculativeLoop->getExitingBlock());

      // Add the new incoming value from the non-versioned loop.
      PN->addIncoming(NonSpeculativeLoopInst,
                      NonSpeculativeLoop->getExitingBlock());
    }
  }
}

bool LoopSpeculativeBoundsCheck::processLoop(Loop *L) {
  AliasSetTracker AST(*AA);
  bool Changed = false;

  for (auto *BB : L->getBlocks())
    AST.add(*BB);

  if (isSuitableLoop(L, AST)) {
    Loop *SpeculativeLoop;    // Loop with global load removed
    Loop *NonSpeculativeLoop; // Original loop code
    Value *RuntimeCheck = nullptr; // Runtime check to determine whether
                                   // to enter speculated loop
    Value *SCEVRuntimeCheck;

    BasicBlock *PH = L->getLoopPreheader();
    BasicBlock *CheckBB = PH;

    CheckBB->setName(L->getHeader()->getName() + ".speculative.bounds.check");

    // Create empty preheader for the loop (and after cloning for the
    // non-versioned loop).
    BasicBlock *NewPH =
    SplitBlock(CheckBB, CheckBB->getTerminator(), DT, LI);
    NewPH->setName(L->getHeader()->getName() + ".ph");

    SpeculativeLoop = L;
    SmallVector<BasicBlock *, 8> NonSpeculativeLoopBlocks;
    NonSpeculativeLoop =
    cloneLoopWithPreheader(NewPH, CheckBB, SpeculativeLoop, VMap,
                           ".specbounds.orig", LI, DT,
                           NonSpeculativeLoopBlocks);
    remapInstructionsInBlocks(NonSpeculativeLoopBlocks, VMap);

    addPHINodes(SpeculativeLoop, NonSpeculativeLoop);

    // Clone the load instruction into the new checking block
    IRBuilder<> Builder(CheckBB->getTerminator());
    Builder.SetCurrentDebugLocation(GlobalLoadInst->getDebugLoc());

    Instruction *ClonedLoad = GlobalLoadInst->clone();
    ClonedLoad->setName(GlobalLoadInst->getName() + ".speculative");
    Builder.Insert(ClonedLoad);

    // Copy across metadata.
    // TODO: Should we restrict some kinds of metadata?
    SmallVector<std::pair<unsigned, MDNode *>, 4> Metadata;
    GlobalLoadInst->getAllMetadataOtherThanDebugLoc(Metadata);

    for (auto M : Metadata)
      ClonedLoad->setMetadata(M.first, M.second);

    // Drop old SE info, recalculate trip count based on the load in CheckBB.
    GlobalLoadInst->replaceAllUsesWith(ClonedLoad);
    SE->forgetLoop(SpeculativeLoop);

    // Figure out which checks are needed based on the speculated trip count.
    LAI = &LAA->getInfo(SpeculativeLoop);
    SmallVector<RuntimePointerChecking::PointerCheck, 4> AliasChecks =
    LAI->getRuntimePointerChecking()->getChecks();

    Instruction *FirstCheckInst;
    Instruction *MemRuntimeCheck;
    std::tie(FirstCheckInst, MemRuntimeCheck) =
    LAI->addRuntimeChecks(CheckBB->getTerminator(), AliasChecks);

    // TODO: Using SCEV checks similar to LoopVersioning -- does this make
    // sense for the bounds checking? We're just concerned with a load
    // from a global used as a loop termination condition possibly aliasing
    // with writes inside the loop.
    const SCEVUnionPredicate &Pred = LAI->getPSE().getUnionPredicate();
    SCEVExpander Exp(*SE, CheckBB->getModule()->getDataLayout(),
                     "scev.check");
    SCEVRuntimeCheck =
    Exp.expandCodeForPredicate(&Pred, CheckBB->getTerminator());
    auto *CI = dyn_cast<ConstantInt>(SCEVRuntimeCheck);

    // Discard the SCEV runtime check if it is always true.
    if (CI && CI->isZero())
      SCEVRuntimeCheck = nullptr;

    // Figure out which checks which should plant
    if (MemRuntimeCheck && SCEVRuntimeCheck) {
      RuntimeCheck = BinaryOperator::Create(Instruction::Or, MemRuntimeCheck,
                                            SCEVRuntimeCheck, "ldist.safe");
      if (auto *I = dyn_cast<Instruction>(RuntimeCheck))
        I->insertBefore(CheckBB->getTerminator());
    } else
      RuntimeCheck = MemRuntimeCheck ? MemRuntimeCheck : SCEVRuntimeCheck;

    // We should get an alias check if the load was causing problems, so if
    // we don't get one something has gone wrong somewhere. For now default
    // to safe behaviour of always jumping to the original loop and let a
    // later pass remove the unused blocks...
    LLVMContext &Context = PH->getContext();
    Value *BrVal = RuntimeCheck ? RuntimeCheck : ConstantInt::getTrue(Context);

    Instruction *OrigTerm = CheckBB->getTerminator();
    BranchInst::Create(NonSpeculativeLoop->getLoopPreheader(),
                       SpeculativeLoop->getLoopPreheader(),
                       BrVal, OrigTerm);
    OrigTerm->eraseFromParent();

    // The loops merge in the original exit block.  This is now dominated by the
    // memchecking block.
    DT->changeImmediateDominator(SpeculativeLoop->getExitBlock(), CheckBB);

    Changed = true;
  }

  // Clear out data structures to avoid leaking memory...
  // TODO: Move to a per-loop structure as a local var?
  VMap.clear();
  DefsUsedOutside.clear();

  return Changed;
}

bool LoopSpeculativeBoundsCheck::runOnLoop(Loop *L, LPPassManager &LPM) {
  if (skipLoop(L))
    return false;

  // Only run on inner loops.
  if (!L->empty())
    return false;

  LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
  AA = &getAnalysis<AAResultsWrapperPass>().getAAResults();
  SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();
  DT = &getAnalysis<DominatorTreeWrapperPass>().getDomTree();
  TLI = &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI();
  LAA = &getAnalysis<LoopAccessLegacyAnalysis>();

  return processLoop(L);
}


char LoopSpeculativeBoundsCheck::ID = 0;
INITIALIZE_PASS_BEGIN(LoopSpeculativeBoundsCheck,
                      "loop-speculative-bounds-check",
                      "Loop Speculative Bounds Checking", false, false)
INITIALIZE_PASS_DEPENDENCY(AAResultsWrapperPass)
INITIALIZE_PASS_DEPENDENCY(DominatorTreeWrapperPass)
INITIALIZE_PASS_DEPENDENCY(GlobalsAAWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LCSSAWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LoopAccessLegacyAnalysis)
INITIALIZE_PASS_DEPENDENCY(LoopInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LoopSimplify)
INITIALIZE_PASS_DEPENDENCY(ScalarEvolutionWrapperPass)
INITIALIZE_PASS_DEPENDENCY(TargetLibraryInfoWrapperPass)
INITIALIZE_PASS_END(LoopSpeculativeBoundsCheck,
                    "loop-speculative-bounds-check",
                    "Loop Speculative Bounds Checking", false, false)

Pass *llvm::createLoopSpeculativeBoundsCheckPass() {
  return new LoopSpeculativeBoundsCheck();
}
