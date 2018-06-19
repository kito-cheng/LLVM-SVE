//=----------------------- InterleavedGatherScatter.cpp----------------------=//
//
// The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the Interleaved Gather Scatter pass, which identifies
// masked gather and masked scatter intrinsics and transforms them into cheaper,
// target specific interleaved access intrinsics.
//
// When fixed-length vectors are used, this optimisation is achieved by creating
// wide loads followed by shuffles with constant indices, or shuffles followed
// by wide stores, which are then transformed into target specific interleaved
// access intrinsics in InterleavedAccessPass.  See that pass for more details.
//
// The wide-load approach does not work well for scalable vectors, as the
// shuffle masks are very cumbersome to reason with.  However, masked gathers
// and scatters can represent the same work quite easily.
//
// Accordingly, the job of this pass is to recognise groups of masked gathers
// or scatters, and replace each group with a single interleaved access where
// appropriate.
//
// This pass also does some rudimentary sinking of scatter stores using
// alias-analysis in order to create the required access groups.
//
//===----------------------------------------------------------------------===//
#include "llvm/ADT/DepthFirstIterator.h"
#include "llvm/ADT/MapVector.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Target/TargetLowering.h"
#include "llvm/Target/TargetSubtargetInfo.h"

using namespace llvm;
using namespace llvm::PatternMatch;

#define DEBUG_TYPE "interleaved-gather-scatter"

// Allow conversion of structured loads where not all elements of the structure
// are loaded by the original code.  This isn't generally safe without
// guaranteeing the additional loads will not cause faults that would never have
// occured in the original code.  Once we've added checks to guarantee this,
// this opt should be removed.
static cl::opt<bool> IGSAllBlocks(
    "sve-igs-all-blocks",
    cl::desc("Lowering gather/scatters to interleaved intrinsics in all "
             "basic blocks, not just loop blocks."),
    cl::init(false), cl::Hidden);

// Allow conversion of structured loads where not all elements of the structure
// are loaded by the original code.  This isn't generally safe without
// guaranteeing the additional loads will not cause faults that would never have
// occured in the original code.  Once we've added checks to guarantee this,
// this opt should be removed.
static cl::opt<bool> IGSAllowUnsafeLoads(
    "sve-igs-allow-unsafe-loads",
    cl::desc("Enable unsafe load patterns when lowering gather/scatters to "
             "interleaved intrinsics"),
    cl::init(false), cl::Hidden);

namespace llvm {
static void initializeInterleavedGatherScatterPass(PassRegistry &);
}

namespace {

class InterleavedGatherScatter : public FunctionPass {

public:
  static char ID;
  InterleavedGatherScatter(const TargetMachine *TM = nullptr)
      : FunctionPass(ID), TM(TM), TLI(nullptr) {
    initializeInterleavedGatherScatterPass(*PassRegistry::getPassRegistry());
  }

  StringRef getPassName() const override {
    return "Interleaved Gather Scatter Pass";
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesCFG();
    AU.addRequired<AAResultsWrapperPass>();
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addRequired<TargetTransformInfoWrapperPass>();
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addPreserved<AAResultsWrapperPass>();
  }

  bool runOnFunction(Function &F) override;

private:
  const TargetMachine *TM;
  const TargetLowering *TLI;
  const DataLayout *DL;
  AliasAnalysis *AA;
  LoopInfo *LI;
  ScalarEvolution *SE;
  TargetTransformInfo *TTI;

  // Map of gather/scatter instructions to their scalar base pointers.
  // These are inserted in program order for each block.
  MapVector<Instruction *, Value *> GSPtrMap;

  /// \brief The descriptor for a strided memory access.
  struct StrideDescriptor {
    // The current gather or scatter intrinsic.
    IntrinsicInst *Instruction;
    // The SCEV expression of the base ptr.
    const SCEV *BaseSCEV;
    // The start value of the vector of offsets from the base ptr.
    Value *Start;
    // The predicate for this access.
    Value *GP;
    // The access's stride in bytes. May be negative.
    int Stride;
    // The size of the memory object in bytes.
    unsigned Size;
    // The element type of the vector.
    Type *EltTy;
    // The alignment of this access in bytes.
    unsigned Align;
    // The byte offset between this access and the
    // first access that was entered into the same
    // group as this.
    int OffsetFromSD0;
    // If set, the type the address pointer was
    // bitcast to from an original type.
    Type *CastDestTy;

    /// \brief Create a StrideDescriptor from a gather or scatter intrinsic.
    ///
    /// Returns nullptr on failure
    static std::unique_ptr<StrideDescriptor>
    create(IntrinsicInst *Instr, ScalarEvolution *SE, const DataLayout *DL) {
      Value *Base, *Align, *GP, *Merge, *Start;
      ConstantInt *StrideInst;
      Type *CastDestTy = nullptr;
      bool IsLoad;
      if (match(Instr, m_Intrinsic<Intrinsic::masked_gather>(
                           m_Value(Base), m_Value(Align), m_Value(GP),
                           m_Value(Merge))))
        IsLoad = true;
      else if (match(Instr, m_Intrinsic<Intrinsic::masked_scatter>(
                                m_Value(), m_Value(Base), m_Value(Align),
                                m_Value(GP))))
        IsLoad = false;
      else
        return nullptr;
      if (auto BCBase = dyn_cast<BitCastInst>(Base)) {
        Base = BCBase->getOperand(0);
        CastDestTy =
            BCBase->getType()->getVectorElementType()->getPointerElementType();
      }
      auto GEP = dyn_cast<GetElementPtrInst>(Base);
      if (!GEP || (GEP->getNumOperands() > 2))
        return nullptr;
      if (IsLoad && !isa<UndefValue>(Merge))
        return nullptr;
      auto GEPPtr = GEP->getPointerOperand();
      if (!match(GEP->getOperand(1),
                 m_SeriesVector(m_Value(Start), m_ConstantInt(StrideInst))))
        return nullptr;
      auto ConstantAlign = dyn_cast<ConstantInt>(Align);
      if (!ConstantAlign)
        return nullptr;
      // TODO: Is bailing out the correct thing here? Or should we never even
      // get this far to begin with?
      // Failure context: denseLinearAlgebra, the pointers from a contiguous
      // load get passed straight through to a scatter store.
      if (!SE->isSCEVable(GEPPtr->getType()))
        return nullptr;
      auto BaseSCEV = SE->getSCEV(GEPPtr);
      Type *EltTy = GEP->getResultElementType();
      unsigned Size = DL->getTypeStoreSize(EltTy);
      int Stride = StrideInst->getSExtValue() * Size;
      // If we have pointers to aggregate types, those are bitcasted to scalar
      // types when used in gathers/scatters. The real size of the access is the
      // element size of the bitcast type, not the original aggregate type size.
      if (CastDestTy)
        Size = DL->getTypeStoreSize(CastDestTy);
      assert(Stride != 0 && "Stride (or size) is zero, and shouldn't be");
      return llvm::make_unique<StrideDescriptor>(
          Instr, BaseSCEV, Start, GP, Stride, Size, EltTy,
          ConstantAlign->getSExtValue(), CastDestTy);
    }
    StrideDescriptor(IntrinsicInst *Instruction, const SCEV *BaseSCEV,
                     Value *Start, Value *GP, int Stride, unsigned Size,
                     Type *EltTy, unsigned Align, Type *CastDestTy)
        : Instruction(Instruction), BaseSCEV(BaseSCEV), Start(Start), GP(GP),
          Stride(Stride), Size(Size), EltTy(EltTy), Align(Align),
          OffsetFromSD0(0), CastDestTy(CastDestTy) {}
  };

  typedef SmallVector<std::unique_ptr<StrideDescriptor>, 4> StrideGroup;

  /// \brief Adds a StrideDescriptor to a Group if possible
  ///
  /// Requires that existing members plus NewSD can be converted into a single
  /// strided access.  Returns true on success
  bool addSDToGroup(StrideDescriptor &NewSD, StrideGroup &Group);

  /// \brief Tries to Convert a group of gathers or scatters to a strided access
  ///
  /// Helper for lowerGatherScatterNoAliasGroup.  Returns true if anything
  /// changed.
  bool lowerSDGroup(StrideGroup &Group);

  /// \brief Takes a group of gathers or scatters with no aliasing concerns and
  /// attempts to convert into strided accesses
  ///
  /// Helper for lowerGatherScatters.  Returns true if anything changed
  bool lowerGatherScatterNoAliasGroup(
      SmallVectorImpl<IntrinsicInst *> &NoAliasGroup);

  /// \brief Takes an ordered list of all memory instructions in a block and
  /// attempts to lower any gathers or scatters into interleaved accesses
  ///
  /// Returns true if anything changed
  bool lowerGatherScatters(const SmallVectorImpl<Instruction *> &MemAccessList);

  /// \brief Given a vector of pointers, try to find the base pointer used for
  /// gather/scatter ops.
  ///
  /// Returns the pointer if it can be found, otherwise returns nullptr.
  Value *findBasePtrFromVector(Value *VecPtr);

  /// \brief Scans the block and populated the alias set tracker given. This
  /// also knows how to analyze gather/scatter operations to find the base
  /// pointer, assuming they're in the expected canonical form.
  ///
  /// Returns true if any pointers were added to the AST.
  bool buildAliasSets(BasicBlock *BB, AliasSetTracker &AST,
                      Instruction *StartI);

  /// \brief Uses alias-analysis to try to sink stores down a basic block.
  /// Tries to sink sequential stores together
  ///
  /// Returns true if the block was modified.
  bool sinkScatterStores(BasicBlock *BB, AliasSetTracker &AST);

  /// \brief Uses alias-analysis to run checks on single stores within
  /// groups of sequential stores
  ///
  /// Returns true if the block was modified.
  bool isStoreSinkable(Instruction *I, Value *BasePtr, Instruction **LastGather,
                       AliasSetTracker &AST);

  /// \brief For 2 gather/scatter instructions, this checks that their
  /// element memory accesses are interleaving without overlapping
  /// This complements the AliasSetTracker, which can't deal
  /// with gather/scatters
  bool isAliasedGatherScatter(Instruction *I, Instruction *NextI);

  bool runOnLoop(Loop *L);
  bool runOnBlock(BasicBlock *Block);
};
} // end anonymous namespace.

char InterleavedGatherScatter::ID = 0;
static const char ia_name[] =
    "Lower interleaved gathers/scatters to target specific intrinsics";

INITIALIZE_PASS_BEGIN(InterleavedGatherScatter, "interleaved-gather-scatter",
                      ia_name, false, false)
INITIALIZE_PASS_DEPENDENCY(AAResultsWrapperPass)
INITIALIZE_PASS_DEPENDENCY(ScalarEvolutionWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LoopInfoWrapperPass)
INITIALIZE_PASS_END(InterleavedGatherScatter, "interleaved-gather-scatter",
                    ia_name, false, false)

FunctionPass *
llvm::createInterleavedGatherScatterPass(const TargetMachine *TM) {
  return new InterleavedGatherScatter(TM);
}

bool InterleavedGatherScatter::lowerSDGroup(StrideGroup &Group) {
  assert(!Group.empty());
  // Find the first and last SDs in the group.  Note the group is in reverse
  // instruction order, so FirstSD is at the back of the group, and LastSD is at
  // the front
  auto FirstSD = Group.back().get();
  auto LastSD = Group.front().get();
  auto ID = FirstSD->Instruction->getIntrinsicID();
  bool IsLoad = (ID == Intrinsic::masked_gather);
  assert((IsLoad || (ID == Intrinsic::masked_scatter)) &&
         "Attempted to lower unhandled intrinsic");

  // Find the SD with the lowest base address
  StrideDescriptor *LowestSD = FirstSD;
  for (auto I = Group.begin(), E = Group.end(); I != E; ++I) {
    auto SD = I->get();
    if (SD->OffsetFromSD0 < LowestSD->OffsetFromSD0)
      LowestSD = SD;
  }

  assert(LowestSD->Stride > 0 && "Don't have support for negative strides yet");
  unsigned Factor = unsigned(LowestSD->Stride) / LowestSD->Size;
  if (Factor > TLI->getMaxSupportedInterleaveFactor()) {
    DEBUG(dbgs() << "IGS: Skipping (Factor is too large)");
    return false;
  } else if (Factor == 1) {
    // Fixing this is SC-1270
    DEBUG(dbgs() << "IGS: Skipping (This should be a consecutive Load!)");
    return false;
  }

  // For gathers, this array holds the gather intrinsics.  For scatters, it
  // holds the values to be stored
  Value *Values[] = {nullptr, nullptr, nullptr, nullptr,
                     nullptr, nullptr, nullptr, nullptr};

  for (auto I = Group.begin(), E = Group.end(); I != E; ++I) {
    auto SD = I->get();
    int Offset = SD->OffsetFromSD0 - LowestSD->OffsetFromSD0;
    unsigned Index = unsigned(Offset) / LowestSD->Size;

    assert(!(Offset % LowestSD->Size) && "Offset isn't a multiple of Size");
    assert(Index < Factor && "Index out of range");
    assert(!Values[Index] && "Multiple nodes with the same Index");
    Values[Index] = IsLoad ? SD->Instruction : SD->Instruction->getOperand(0);
  }

  if ((Group.size() != Factor)) {
    if (!IsLoad) {
      // A future optimisation would be to spot blocks where there is a matching
      // ldN instruction, and use the loads in that to fill in gaps here
      DEBUG(dbgs() << "IGS: Skipping (Store group is not fully populated)\n");
      return false;
    } else if (!IGSAllowUnsafeLoads) {
      DEBUG(dbgs() << "IGS: Skipping (Load group is not fully populated)\n");
      return false;
    }
  }

  bool Changed;
  if (IsLoad)
    Changed = TLI->lowerGathersToInterleavedLoad(Values, FirstSD->Instruction,
                                                 Factor, TTI);
  else {
#ifndef NDEBUG
    for (auto *V : Values) {
      if (V)
        DEBUG(dbgs() << "IGS: Value to store: " << *V << "\n");
    }
    DEBUG(dbgs() << "IGS: Storing to location: "
                 << *LowestSD->Instruction->getOperand(1) << "\n");
#endif
    Changed = TLI->lowerScattersToInterleavedStore(
        Values, LowestSD->Instruction->getOperand(1), LastSD->Instruction,
        Factor, TTI);
  }

  if (Changed)
    for (auto I = Group.begin(), E = Group.end(); I != E; ++I) {
      (*I)->Instruction->eraseFromParent();
    }
  else
    DEBUG(dbgs() << "IGS: Skipping (lowering failed)");

  return Changed;
}

bool InterleavedGatherScatter::addSDToGroup(StrideDescriptor &SD,
                                            StrideGroup &Group) {
  auto SD0 = Group.front().get();

  assert(SD0->Instruction->getIntrinsicID() ==
             SD.Instruction->getIntrinsicID() &&
         "Unexpected mix of loads and stores within a no-alias group");
  DEBUG(dbgs() << "Trying to add to group containing " << *SD0->Instruction
               << "\n");
  // Initial checks against first member
  if ((SD0->Start != SD.Start) || (SD0->Stride != SD.Stride) ||
      (SD0->Size != SD.Size) || (SD0->EltTy != SD.EltTy) ||
      (SD0->GP != SD.GP)) {
    DEBUG(dbgs() << "IGS: not adding to group (Failed initial checks) "
                 << *SD.Instruction << "\n");
    return false;
  }

  // Bases must have a constant offset
  auto OffsetSCEV = SE->getMinusSCEV(SD.BaseSCEV, SD0->BaseSCEV);
  auto ConstOffsetSVEV = dyn_cast<const SCEVConstant>(OffsetSCEV);
  if (!ConstOffsetSVEV) {
    DEBUG(dbgs() << "IGS: not adding to group (No const offset) "
                 << *SD.Instruction << "\n");
    return false;
  }
  int OffsetFromSD0 = ConstOffsetSVEV->getAPInt().getSExtValue();

  // Offset must be within the stride, and a multiple of size
  if ((std::abs(OffsetFromSD0) >= SD.Stride) || (OffsetFromSD0 % SD0->Size)) {
    DEBUG(dbgs() << "IGS: not adding to group (offset out of range) "
                 << *SD.Instruction << "\n");
    return false;
  }

  // Check that the offsets are within range for every other member
  for (auto I = Group.begin(), E = Group.end(); I != E; I++) {
    auto GroupSD = I->get();
    int OffsetFromGroupSD = OffsetFromSD0 - GroupSD->OffsetFromSD0;
    // If there are multiple accesses to the same offset, bail out. It's
    // possible a pass hasn't eliminated redundant memory ops.
    if (OffsetFromGroupSD == 0)
      return false;
    if (std::abs(OffsetFromGroupSD) >= SD.Stride) {
      DEBUG(dbgs() << "IGS: not adding to group (Offset out of range for "
                   << "another member) " << *SD.Instruction << "\n");
      return false;
    }
  }

  SD.OffsetFromSD0 = OffsetFromSD0;
  DEBUG(dbgs() << "IGS: Adding to existing StrideGroup: " << *SD.Instruction
               << "\n");
  return true;
}

bool InterleavedGatherScatter::lowerGatherScatterNoAliasGroup(
    SmallVectorImpl<IntrinsicInst *> &NoAliasGroup) {
  // Each inner vector contains a set of compatible gathers or scatters that
  // will be combined into a single strided access
  SmallVector<std::unique_ptr<StrideGroup>, 4> StrideGroups;
  bool Changed = false;
  bool MayStore = NoAliasGroup[0]->mayWriteToMemory();
  // Create StrideGroups from the Intrinsics
  for (auto Intrinsic : NoAliasGroup) {
    assert(MayStore == Intrinsic->mayWriteToMemory() &&
           "Mix of loads and stores");
    auto SD = StrideDescriptor::create(Intrinsic, SE, DL);
    if (SD) {
      DEBUG(dbgs() << "Attempting to add to existing groups: "
                   << *SD->Instruction << "\n");
    } else {
      DEBUG(dbgs() << "IGS: Skipping (failed to Create SD): " << *Intrinsic
                   << "\n");
      continue;
    }

    if (SD->Stride < 0) {
      // Don't yet support negative strides
      DEBUG(dbgs() << "IGS: Skipping (negative stride): " << *SD->Instruction
                   << "\n");
      continue;
    }

    if (((unsigned)SD->Stride) < SD->Size) {
      // Don't yet support strides less than size -- happens if the stride
      // was calculated against a smaller type but the pointers were then
      // bitcasted to a larger type, and the stride is less than the larger
      // type. Appears in some DSP code. Memory ops will overlap.
      DEBUG(dbgs() << "IGS: Skipping Stride: " << SD->Stride
                   << " less than Size: " << SD->Size << "\n");
      continue;
    }

    bool Added = false;
    if (!StrideGroups.empty()) {
      // Iterate backwards through the groups looking for a match.  Stores can
      // only match against the most recent group, since we don't know they
      // don't alias
      auto E = MayStore ? StrideGroups.rbegin() + 1 : StrideGroups.rend();
      for (auto I = StrideGroups.rbegin(); I != E; ++I) {
        StrideGroup *Group = I->get();
        if (addSDToGroup(*SD.get(), *Group)) {
          // Add SD to existing group
          Group->push_back(std::move(SD));
          Added = true;
          break;
        }
      }
    }

    if (Added)
      continue;

    // Create new group
    DEBUG(dbgs() << "IGS: New StrideGroup: " << *SD->Instruction << "\n");
    auto Group = llvm::make_unique<StrideGroup>();
    Group->push_back(std::move(SD));
    StrideGroups.push_back(std::move(Group));
  }

  // Lower each group
  for (auto I = StrideGroups.begin(), E = StrideGroups.end(); I != E; ++I) {
    Changed |= lowerSDGroup(*I->get());
  }

  NoAliasGroup.clear();
  return Changed;
}

/// \brief Replace masked gather/scatter intrinsics with strided load/stores
///
/// Takes a vector of all memory accesses in a block, in instruction order
/// Returns true if anything changed
bool InterleavedGatherScatter::lowerGatherScatters(
    const SmallVectorImpl<Instruction *> &MemAccessList) {
  // Holds a group of intrinsics that have no aliasing concerns
  SmallVector<IntrinsicInst *, 8> NoAliasGroup;
  bool Changed = false;

  // Note this iterates in reverse instruction order
  for (auto I = MemAccessList.rbegin(), E = MemAccessList.rend(); I != E; ++I)
    if (auto II = dyn_cast<IntrinsicInst>(*I)) {
      // If this intrinsic is different from the current group, break the
      // group
      if (!NoAliasGroup.empty() &&
          (II->getIntrinsicID() != NoAliasGroup[0]->getIntrinsicID())) {
        DEBUG(dbgs() << "IGS: Breaking group due to different intrinsic:" << *II
                     << "\n");
        Changed |= lowerGatherScatterNoAliasGroup(NoAliasGroup);
      }
      // Then add this intrinsic to the (possibly empty) group
      DEBUG(dbgs() << "IGS: Adding intrinsic to current group: " << *II
                   << "\n");
      NoAliasGroup.push_back(II);
    } else if ((*I)->mayWriteToMemory()) {
      if (!NoAliasGroup.empty()) {
        // Stores break the current group, but don't get added
        DEBUG(dbgs() << "IGS: Breaking group due to store: " << **I << "\n");
        Changed |= lowerGatherScatterNoAliasGroup(NoAliasGroup);
      }
    } else
      llvm_unreachable("Unexpected instruction");

  // lower the last group
  if (!NoAliasGroup.empty())
    Changed |= lowerGatherScatterNoAliasGroup(NoAliasGroup);

  return Changed;
}

/// This function is to be used for dealiasing purposes
/// The regular alias set tracker doesn't handle gather/scatter because
/// the size of the memory access is unknown
/// This function detects one specific case, where we know for sure
/// there is no aliasing
bool InterleavedGatherScatter::isAliasedGatherScatter(Instruction *I,
                                                      Instruction *NextI) {
  auto SD_cur = StrideDescriptor::create(dyn_cast<IntrinsicInst>(I), SE, DL);
  auto SD_next =
      StrideDescriptor::create(dyn_cast<IntrinsicInst>(NextI), SE, DL);
  // SD_next is a stride that could potentially interleave with SD_cur
  // without ovelapping
  if ((SD_cur->Start == SD_next->Start) &&
      (SD_cur->Stride == SD_next->Stride) && (SD_cur->Size == SD_next->Size) &&
      (SD_cur->EltTy == SD_next->EltTy) &&
      (SD_cur->BaseSCEV != SD_next->BaseSCEV)) {
    // We check there is no overlap but comparing size and offset of the first
    // beats The equal strides ensure subsequent beats will also not overlap
    auto OffsetSCEV = SE->getMinusSCEV(SD_next->BaseSCEV, SD_cur->BaseSCEV);
    auto ConstOffsetSVEV = dyn_cast<const SCEVConstant>(OffsetSCEV);
    if (!ConstOffsetSVEV) {
      return true;
    }
    unsigned OffsetFromCur = abs(ConstOffsetSVEV->getAPInt().getSExtValue());
    if ((OffsetFromCur >= SD_cur->Size) &&
        (OffsetFromCur <= (SD_cur->Stride - SD_cur->Size))) {
      return false;
    }
  }
  // By default we consider the gathers/scatters as aliased
  return true;
}

bool InterleavedGatherScatter::isStoreSinkable(Instruction *I, Value *BasePtr,
                                               Instruction **LastGather,
                                               AliasSetTracker &AST) {
  AAMDNodes AAInfo;
  I->getAAMetadata(AAInfo);
  AliasSet *AS1 = AST.getAliasSetForPointerIfExists(
      BasePtr, MemoryLocation::UnknownSize, AAInfo);
  assert(AS1 && "Alias set for gather/scatter not found");
  assert(I->mayWriteToMemory());
  BasicBlock::iterator Next(I);
  std::advance(Next, 1);
  for (auto End = I->getParent()->end(); Next != End; ++Next) {
    auto NextI = &*Next;
    if (!NextI->mayReadOrWriteMemory())
      continue;
    // Extract the pointer from the instruction.
    Value *NextPtr;
    bool IsGather = false;
    uint64_t Size;
    bool KnownGatherScatter = false;
    if (auto LI = dyn_cast<LoadInst>(NextI)) {
      if (!LI->isSimple()) {
        DEBUG(dbgs() << "Re-order: Can't sink past atomic or volatile.\n");
        // Can't sink past atomic or volatile loads.
        return false;
      }
      NextPtr = LI->getPointerOperand();
      Size = DL->getTypeStoreSize(LI->getType());
    } else if (auto SI = dyn_cast<StoreInst>(NextI)) {
      if (!SI->isSimple()) {
        DEBUG(dbgs() << "Re-order: store instruction is not simple.\n");
        return false;
      }
      NextPtr = SI->getPointerOperand();
      Size = DL->getTypeStoreSize(SI->getValueOperand()->getType());
    } else {
      // Check if this is a known gather/scatter in the block which we should
      // have cached in the baseptr map.
      NextPtr = GSPtrMap[NextI];
      if (!NextPtr) {
        DEBUG(dbgs()
              << "Re-order: this is a known gather/scatter,"
              << " which we should been have cached in the baseptr map.\n");
        // The base pointer couldn't be found so we have to stop.
        return false;
      }
      KnownGatherScatter = true;
      IsGather = !NextI->mayWriteToMemory();
      Size = MemoryLocation::UnknownSize;
    }

    // We have the next instruction's pointer value, now find the alias set.
    NextI->getAAMetadata(AAInfo);
    auto AS2 = AST.getAliasSetForPointerIfExists(NextPtr, Size, AAInfo);
    assert(AS2 && "Couldn't find alias set for re-ordering");

    if (AS1 == AS2) {
      if (!(KnownGatherScatter && !isAliasedGatherScatter(I, NextI))) {
        DEBUG(dbgs() << "Re-order: Detected a potential alias, cant sink "
                        "scatter below.\n");
        return false; // Detected a potential alias, stop.
      }
    }

    if (IsGather)
      *LastGather = NextI;

    DEBUG(dbgs() << "Re-order: Can sink scatter below " << *NextI << "\n");
  }
  return true;
}

bool InterleavedGatherScatter::sinkScatterStores(BasicBlock *BB,
                                                 AliasSetTracker &AST) {
  bool Changed = false;
  // To sink scatter stores, the idea is to start from the end of each block,
  // until we find our scatter store, we then scan all subsequent memory
  // accesses (scalar and vector), examining the alias sets of the pointers
  // to see if we can sink the store past it.
  //
  // We start from the end so that stores in the example block can be sunk:
  // bb:
  //   scatter.store p1, v
  //   gather.load p2
  //   scatter.store p3, v
  //   gather.load p4, v
  //   ...
  // ... assuming that p1 & p3 are may-alias, but neither aliases with p2 & p4.
  // This ensures we should be able to sink all stores as far as possible
  // with one pass, in this case both below p4.
  //
  // The caveat is that we cannot sink a store past a gather/scatter for
  // which we weren't able to find the base pointer.

  SmallVector<std::pair<Instruction *, Value *>, 8> GSInBlock;
  for (auto II = GSPtrMap.rbegin(), IE = GSPtrMap.rend(); II != IE; ++II)
    GSInBlock.push_back(*II);

  for (auto It = GSInBlock.begin(), E = GSInBlock.end(); It != E; ++It) {
    Instruction *I = It->first;
    Value *BasePtr = It->second;

    // Subsequent stores are evaluated together, to not sink only some of the
    // stores in the group
    // The would unnecessarily break stride groups
    SmallVector<std::pair<Instruction *, Value *>, 8> SubsequentStoresInBlock;
    while (I->mayWriteToMemory() && It->second) {
      SubsequentStoresInBlock.push_back(*It++);
      if (It == E)
        break;
      I = It->first;
    }

    if (SubsequentStoresInBlock.empty())
      continue;
    --It;

    for (auto CtgIt : SubsequentStoresInBlock)
      DEBUG(dbgs() << "Re-order: Trying to sink store: " << *(CtgIt.first));

    // Keep track of the last gather we have analyzed and found safe to
    // sink through. Don't bother doing any sinking if we can't find any.
    Instruction *LastGather = nullptr;
    // Building the AliasSet based on subsequent instructions in the block,
    // not on instructions that are executed previously
    AliasSetTracker ASTPartial(*AA);
    buildAliasSets(BB, ASTPartial, SubsequentStoresInBlock.back().first);
    for (auto CtgIt : SubsequentStoresInBlock) {
      I = CtgIt.first;
      BasePtr = CtgIt.second;
      if (!isStoreSinkable(I, BasePtr, &LastGather, ASTPartial))
        break;
    }

    if (!LastGather) {
      DEBUG(dbgs() << "Re-order: Not sinking as no gathers to be passed.\n");
      continue; //  No point in sinking.
    }

    for (auto CtgIt : SubsequentStoresInBlock) {
      I = CtgIt.first;
      I->removeFromParent();
      I->insertAfter(LastGather);
    }

    DEBUG(dbgs() << "Re-order: Sunk scatter instruction(s).\n");
    Changed = true;
  }

  return Changed;
}

bool InterleavedGatherScatter::runOnBlock(BasicBlock *Block) {
  bool Changed = false;

  {
    AliasSetTracker AST(*AA);
    if (buildAliasSets(Block, AST, NULL)) {
      DEBUG(dbgs() << "Dumping AST for block: " << Block->getName() << "\n");
      DEBUG(dbgs() << AST);
      // First we try to sink scatters down the loop block past any gathers,
      // so that the grouping phase can work later.
      Changed |= sinkScatterStores(Block, AST);
    }
  }
  // Clear GSPtrMap as optimization may RAUW values in the map.
  GSPtrMap.clear();
  // Holds loads & stores (inc gather,scatter)
  SmallVector<Instruction *, 16> MemAccessList;

  for (auto &Inst : *Block) {
    IntrinsicInst *II = nullptr;
    if ((II = dyn_cast<IntrinsicInst>(&Inst)) &&
        ((II->getIntrinsicID() == Intrinsic::masked_gather) ||
         (II->getIntrinsicID() == Intrinsic::masked_scatter)))
      MemAccessList.push_back(II);
    else if (Inst.mayWriteToMemory())
      MemAccessList.push_back(&Inst);
  }

  Changed |= lowerGatherScatters(MemAccessList);
  return Changed;
}

bool InterleavedGatherScatter::runOnLoop(Loop *L) {
  bool Changed = false;

  for (auto &Block : L->blocks()) {
    if (LI->getLoopFor(Block) != L) // Ignore blocks in subloop.
      continue;
    Changed |= runOnBlock(Block);
  }
  return Changed;
}

Value *InterleavedGatherScatter::findBasePtrFromVector(Value *VecPtr) {
  assert(VecPtr->getType()->isVectorTy() && "Expected vector-of-ptrs");
  // VecPtr should be a vector of pointers, possibly bitcasted.
  if (auto BCast = dyn_cast<BitCastInst>(VecPtr))
    VecPtr = BCast->getOperand(0);

  auto BaseGEP = dyn_cast<GetElementPtrInst>(VecPtr);
  if (!BaseGEP)
    return nullptr;

  // Base geps should always be in the form base + seriesvector (x, k).
  auto BasePtr = BaseGEP->getPointerOperand();
  if (!match(BaseGEP->getOperand(1), m_SeriesVector(m_Value(), m_Value())))
    return nullptr;
  BasePtr = BasePtr->stripPointerCasts();
  return BasePtr;
}

bool InterleavedGatherScatter::buildAliasSets(BasicBlock *BB,
                                              AliasSetTracker &AST,
                                              Instruction *StartI) {
  // Look for gather/scatters specifically as AliasSetTracker doesn't handle
  // these itself. Keeping this code in this pass because the style of
  // addressing is specific for scalable SVE.
  bool StartBuilding = false;
  for (auto &II : *BB) {
    Instruction *I = &II;

    // Building the AliasSet based on subsequent instructions in the block,
    // not on instructions that are executed previously
    // A store in the middle of the block will not care about aliasing
    // with a previous load
    if (!StartI || (I == StartI)) {
      StartBuilding = true;
    }
    if (!StartBuilding)
      continue;

    Value *VecPtr;
    // We want to handle the intrinsics specially instead of using the AST.
    if (match(I, m_Intrinsic<Intrinsic::masked_gather>(m_Value(VecPtr))) ||
        match(I, m_Intrinsic<Intrinsic::masked_scatter>(m_Value(),
                                                        m_Value(VecPtr)))) {
      ;
    } else {
      AST.add(I); // Let AST handle other instructions.
      continue;
    }

    DEBUG(dbgs() << "IGS: Finding base ptr of " << *I << "\n");
    Value *BasePtr = findBasePtrFromVector(VecPtr);
    GSPtrMap[I] = BasePtr;

    if (!BasePtr) {
      DEBUG(dbgs() << "IGS: Couldn't find base ptr of gather/scatter.\n");
      AST.add(I);
      continue;
    }

    // Now we add the pointer to the alias sets manually.
    AAMDNodes AAInfo;
    I->getAAMetadata(AAInfo);
    AST.add(BasePtr, MemoryLocation::UnknownSize, AAInfo);
  }
  return !AST.getAliasSets().empty();
}

bool InterleavedGatherScatter::runOnFunction(Function &F) {
  SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();
  TTI = &getAnalysis<TargetTransformInfoWrapperPass>().getTTI(F);
  AA = &getAnalysis<AAResultsWrapperPass>().getAAResults();
  LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();

  if (!TM)
    return false;

  DEBUG(dbgs() << "*** " << getPassName() << ": " << F.getName() << "\n");

  TLI = TM->getSubtargetImpl(F)->getTargetLowering();

  bool Changed = false;

  DL = &F.getParent()->getDataLayout();

  if (!IGSAllBlocks) {
    for (auto I = LI->begin(), IE = LI->end(); I != IE; ++I)
      for (auto L = df_begin(*I), LE = df_end(*I); L != LE; ++L) {
        Changed |= runOnLoop(*L);
      }
  } else {
    for (auto &BB : F) {
      Changed |= runOnBlock(&BB);
    }
  }
  return Changed;
}
