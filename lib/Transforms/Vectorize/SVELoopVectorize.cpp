//===- SVELoopVectorize.cpp - A Loop Vectorizer ------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This is the LLVM loop vectorizer. This pass modifies 'vectorizable' loops
// and generates target-independent LLVM-IR.
// The vectorizer uses the TargetTransformInfo analysis to estimate the costs
// of instructions in order to estimate the profitability of vectorization.
//
// The loop vectorizer combines consecutive loop iterations into a single
// 'wide' iteration. After this transformation the index is incremented
// by the SIMD vector width, and not by one.
//
// This pass has three parts:
// 1. The main loop pass that drives the different parts.
// 2. LoopVectorizationLegality - A unit that checks for the legality
//    of the vectorization.
// 3. InnerLoopVectorizer - A unit that performs the actual
//    widening of instructions.
// 4. LoopVectorizationCostModel - A unit that checks for the profitability
//    of vectorization. It decides on the optimal vector width, which
//    can be one, if vectorization is not profitable.
//
//===----------------------------------------------------------------------===//
//
// The reduction-variable vectorization is based on the paper:
//  D. Nuzman and R. Henderson. Multi-platform Auto-vectorization.
//
// Variable uniformity checks are inspired by:
//  Karrenberg, R. and Hack, S. Whole Function Vectorization.
//
// The interleaved access vectorization is based on the paper:
//  Dorit Nuzman, Ira Rosen and Ayal Zaks.  Auto-Vectorization of Interleaved
//  Data for SIMD
//
// Other ideas/concepts are from:
//  A. Zaks and D. Nuzman. Autovectorization in GCC-two years later.
//
//  S. Maleki, Y. Gao, M. Garzaran, T. Wong and D. Padua.  An Evaluation of
//  Vectorizing Compilers.
//
//===----------------------------------------------------------------------===//

#include "llvm/Transforms/Vectorize/LoopVectorize.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/Hashing.h"
#include "llvm/ADT/MapVector.h"
#include "llvm/ADT/SCCIterator.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/Analysis/CodeMetrics.h"
#include "llvm/Analysis/GlobalsModRef.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopIterator.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/ScalarEvolutionExpander.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/Analysis/VectorUtils.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/DiagnosticInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/ValueHandle.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Pass.h"
#include "llvm/Support/BranchProbability.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Transforms/Utils/LoopSimplify.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/Transforms/Utils/LoopVersioning.h"
#include "llvm/Transforms/LVCommon.h"
#include "llvm/Transforms/Vectorize.h"
#include <algorithm>
#include <functional>
#include <map>
#include <tuple>

using namespace llvm;
using namespace llvm::PatternMatch;

#define LV_NAME "sve-loop-vectorize"
#define DEBUG_TYPE LV_NAME
#ifndef NDEBUG
#define NODEBUG_EARLY_BAILOUT()                                           \
  do { if (!::llvm::DebugFlag || !::llvm::isCurrentDebugType(DEBUG_TYPE)) \
      { return false; } } while (0)
#else
#define NODEBUG_EARLY_BAILOUT() { return false; }
#endif

STATISTIC(LoopsVectorized, "Number of loops vectorized");
STATISTIC(LoopsVectorizedWA, "Number of loops vectorized with WA");
STATISTIC(LoopsAnalyzed, "Number of loops analyzed for vectorization");


/// We don't interleave loops with a known constant trip count below this
/// number.
static const unsigned TinyTripCountInterleaveThreshold = 128;

/// Maximum vectorization interleave count.
const unsigned MaxInterleaveFactor = 16;


static cl::opt<bool> EnableScalableVectorisation(
    "force-scalable-vectorization", cl::init(false), cl::Hidden,
    cl::ZeroOrMore,
    cl::desc("Enable vectorization using scalable vectors"));

static cl::opt<bool> EnableVectorPredication(
    "force-vector-predication", cl::init(false), cl::Hidden, cl::ZeroOrMore,
    cl::desc("Enable predicated vector operations."));

static cl::opt<bool> EnableNonConsecutiveStrideIndVars(
    "enable-non-consecutive-stride-ind-vars", cl::init(false), cl::Hidden,
    cl::desc("Enable recognition of induction variables that aren't "
             "consecutive between loop iterations"));

static cl::opt<unsigned> VectorizerMemSetThreshold(
    "vectorize-memset-threshold", cl::init(8),
    cl::Hidden, cl::desc("Maximum (write size in bytes / aligment)"
                         " ratio for the memset."));

static cl::opt<bool> VectorizeMemset(
    "vectorize-memset", cl::init(true), cl::Hidden,
    cl::desc("Enable vectorization of loops with memset calls in the loop "
             "body"));

/// Create an analysis remark that explains why vectorization failed
///
/// \p PassName is the name of the pass (e.g. can be AlwaysPrint).  \p
/// RemarkName is the identifier for the remark.  If \p I is passed it is an
/// instruction that prevents vectorization.  Otherwise \p TheLoop is used for
/// the location of the remark.  \return the remark object that can be
/// streamed to.
static OptimizationRemarkAnalysis
createMissedAnalysis(const char *PassName, StringRef RemarkName, Loop *TheLoop,
                     Instruction *I = nullptr) {
  Value *CodeRegion = TheLoop->getHeader();
  DebugLoc StartLoc = TheLoop->getLocRange().getStart();
  DebugLoc EndLoc = TheLoop->getLocRange().getEnd();

  if (I) {
    CodeRegion = I->getParent();
    // If there is no debug location attached to the instruction, revert back to
    // using the loop's.
    if (I->getDebugLoc())
      StartLoc = EndLoc = I->getDebugLoc();
  }

  auto LocRange = DiagnosticLocation(StartLoc, EndLoc);
  OptimizationRemarkAnalysis R(PassName, RemarkName, LocRange, CodeRegion);
  R << "loop not vectorized: ";
  return R;
}

namespace {

// Forward declarations.
class LoopVectorizeHints;
class LoopVectorizationLegality;
class LoopVectorizationCostModel;
class LoopVectorizationRequirements;

/// Information about vectorization costs
struct VectorizationFactor {
  unsigned Width; // Vector width with best cost
  unsigned Cost; // Cost of the loop with that width
  bool isFixed; // Is the width an absolute value or a scale.
};

/// Returns true if the given loop body has a cycle, excluding the loop
/// itself.
static bool hasCyclesInLoopBody(const Loop &L) {
  if (!L.empty())
    return true;

  for (const auto &SCC :
       make_range(scc_iterator<Loop, LoopBodyTraits>::begin(L),
                  scc_iterator<Loop, LoopBodyTraits>::end(L))) {
    if (SCC.size() > 1) {
      DEBUG(dbgs() << "LVL: Detected a cycle in the loop body:\n");
      DEBUG(L.dump());
      return true;
    }
  }
  return false;
}

/// A helper function for converting Scalar types to vector types.
/// If the incoming type is void, we return void. If the VF is 1, we return
/// the scalar type.
static Type *ToVectorTy(Type *Scalar, unsigned VF, bool IsScalable) {
  if (Scalar->isVoidTy() || VF == 1)
    return Scalar;
  return VectorType::get(Scalar, VF, IsScalable);
}

static Type* ToVectorTy(Type *Scalar, VectorizationFactor VF) {
  if (Scalar->isVoidTy() || VF.Width == 1)
    return Scalar;
  return VectorType::get(Scalar, VF.Width, !VF.isFixed);
}

/// A helper function that returns GEP instruction and knows to skip a
/// 'bitcast'. The 'bitcast' may be skipped if the source and the destination
/// pointee types of the 'bitcast' have the same size.
/// For example:
///   bitcast double** %var to i64* - can be skipped
///   bitcast double** %var to i8*  - can not
static GetElementPtrInst *getGEPInstruction(Value *Ptr) {

  if (isa<GetElementPtrInst>(Ptr))
    return cast<GetElementPtrInst>(Ptr);

  if (isa<BitCastInst>(Ptr) &&
      isa<GetElementPtrInst>(cast<BitCastInst>(Ptr)->getOperand(0))) {
    Type *BitcastTy = Ptr->getType();
    Type *GEPTy = cast<BitCastInst>(Ptr)->getSrcTy();
    if (!isa<PointerType>(BitcastTy) || !isa<PointerType>(GEPTy))
      return nullptr;
    Type *Pointee1Ty = cast<PointerType>(BitcastTy)->getPointerElementType();
    Type *Pointee2Ty = cast<PointerType>(GEPTy)->getPointerElementType();
    const DataLayout &DL = cast<BitCastInst>(Ptr)->getModule()->getDataLayout();
    if (DL.getTypeSizeInBits(Pointee1Ty) == DL.getTypeSizeInBits(Pointee2Ty))
      return cast<GetElementPtrInst>(cast<BitCastInst>(Ptr)->getOperand(0));
  }
  return nullptr;
}

// FIXME: The following helper functions have multiple implementations
// in the project. They can be effectively organized in a common Load/Store
// utilities unit.

/// A helper function that returns the pointer operand of a load or store
/// instruction.
static Value *getPointerOperand(Value *I) {
  if (auto *LI = dyn_cast<LoadInst>(I))
    return LI->getPointerOperand();
  if (auto *SI = dyn_cast<StoreInst>(I))
    return SI->getPointerOperand();
  return nullptr;
}


/// A helper function that returns the alignment of load or store instruction.
static unsigned getMemInstAlignment(Value *I) {
  assert((isa<LoadInst>(I) || isa<StoreInst>(I)) &&
         "Expected Load or Store instruction");
  if (auto *LI = dyn_cast<LoadInst>(I))
    return LI->getAlignment();
  return cast<StoreInst>(I)->getAlignment();
}

/// A helper function that returns the address space of the pointer operand of
/// load or store instruction.
static unsigned getMemInstAddressSpace(Value *I) {
  assert((isa<LoadInst>(I) || isa<StoreInst>(I)) &&
         "Expected Load or Store instruction");
  if (auto *LI = dyn_cast<LoadInst>(I))
    return LI->getPointerAddressSpace();
  return cast<StoreInst>(I)->getPointerAddressSpace();
}

/// A helper function that adds a 'fast' flag to floating-point operations.
static Value *addFastMathFlag(Value *V) {
  if (isa<FPMathOperator>(V)) {
    FastMathFlags Flags;
    Flags.setUnsafeAlgebra();
    cast<Instruction>(V)->setFastMathFlags(Flags);
  }
  return V;
}

/// A helper function that returns an integer or floating-point constant with
/// value C.
static Constant *getSignedIntOrFpConstant(Type *Ty, int64_t C) {
  return Ty->isIntegerTy() ? ConstantInt::getSigned(Ty, C)
                           : ConstantFP::get(Ty, C);
}
/// InnerLoopVectorizer vectorizes loops which contain only one basic
/// block to a specified vectorization factor (VF).
/// This class performs the widening of scalars into vectors, or multiple
/// scalars. This class also implements the following features:
/// * It inserts an epilogue loop for handling loops that don't have iteration
///   counts that are known to be a multiple of the vectorization factor.
/// * It handles the code generation for reduction variables.
/// * Scalarization (implementation using scalars) of un-vectorizable
///   instructions.
/// InnerLoopVectorizer does not perform any vectorization-legality
/// checks, and relies on the caller to check for the different legality
/// aspects. The InnerLoopVectorizer relies on the
/// LoopVectorizationLegality class to provide information about the induction
/// and reduction variables that were found to a given vectorization factor.
class InnerLoopVectorizer {
public:
  InnerLoopVectorizer(Loop *OrigLoop, PredicatedScalarEvolution &PSE,
                      LoopInfo *LI, DominatorTree *DT,
                      const TargetLibraryInfo *TLI,
                      const TargetTransformInfo *TTI, AssumptionCache *AC,
                      OptimizationRemarkEmitter *ORE,
                      unsigned VecWidth, unsigned UnrollFactor,
                      bool VecWidthIsFixed)
      : OrigLoop(OrigLoop), PSE(PSE), LI(LI), DT(DT), TLI(TLI), TTI(TTI),
        AC(AC), ORE(ORE), VF(VecWidth), Scalable(!VecWidthIsFixed),
        UsePredication(EnableVectorPredication && isScalable()),
        UF(UnrollFactor), Builder(PSE.getSE()->getContext()),
        Induction(nullptr), OldInduction(nullptr), InductionStep(nullptr),
        WidenMap(UnrollFactor), VecBodyPostDom(nullptr), TripCount(nullptr),
        VectorTripCount(nullptr), Legal(nullptr), AddedSafetyChecks(false),
        LatchBranch(nullptr), IdxEnd(nullptr), IdxEndV(nullptr) {}

  // Perform the actual loop widening (vectorization).
  // MinimumBitWidths maps scalar integer values to the smallest bitwidth they
  // can be validly truncated to. The cost model has assumed this truncation
  // will happen when vectorizing.
  void vectorize(LoopVectorizationLegality *L,
                 MapVector<Instruction *, uint64_t> MinimumBitWidths) {
    MinBWs = MinimumBitWidths;
    Legal = L;
    // Create a new empty loop. Unlink the old loop and connect the new one.
    if (UsePredication)
      createEmptyLoopWithPredication();
    else
      createEmptyLoop();
    // Widen each instruction in the old loop to a new one in the new loop.
    // Use the Legality module to find the induction and reduction variables.
    vectorizeLoop();
  }

  // Return true if any runtime check is added.
  bool areSafetyChecksAdded() { return AddedSafetyChecks; }

  virtual ~InnerLoopVectorizer() {}

  bool isScalable() const {
    return (VF > 1) && Scalable;
  }

protected:
  /// A small list of PHINodes.
  typedef SmallVector<PHINode *, 4> PhiVector;
  /// When we unroll loops we have multiple vector values for each scalar.
  /// This data structure holds the unrolled and vectorized values that
  /// originated from one scalar instruction.
  typedef SmallVector<Value *, 2> VectorParts;

  // When we if-convert we need to create edge masks. We have to cache values
  // so that we don't end up with exponential recursion/IR.
  typedef DenseMap<std::pair<BasicBlock *, BasicBlock *>, VectorParts>
      EdgeMaskCache;

  /// \brief Add checks for strides that were assumed to be 1.
  ///
  /// Returns the last check instruction and the first check instruction in the
  /// pair as (first, last).
  std::pair<Instruction *, Instruction *> addStrideCheck(Instruction *Loc);

  /// Create an empty loop, based on the loop ranges of the old loop.
  void createEmptyLoop();
  /// Create an empty loop, using per-element predication to control termination
  void createEmptyLoopWithPredication();

  /// Set up the values of the IVs correctly when exiting the vector loop.
  void fixupIVUsers(PHINode *OrigPhi, const InductionDescriptor &II,
                    Value *CountRoundDown, Value *EndValue,
                    BasicBlock *MiddleBlock);

  /// Create a new induction variable inside L.
  PHINode *createInductionVariable(Loop *L, Value *Start, Value *End,
                                   Value *Step, Instruction *DL);
  /// Copy and widen the instructions from the old loop.
  virtual void vectorizeLoop();

  /// Fix a first-order recurrence. This is the second phase of vectorizing
  /// this phi node.
  void fixFirstOrderRecurrence(PHINode *Phi);

  /// \brief The Loop exit block may have single value PHI nodes where the
  /// incoming value is 'Undef'. While vectorizing we only handled real values
  /// that were defined inside the loop. Here we fix the 'undef case'.
  /// See PR14725.
  void fixLCSSAPHIs();

  /// Shrinks vector element sizes based on information in "MinBWs".
  void truncateToMinimalBitwidths();

  /// A helper function that computes the predicate of the block BB, assuming
  /// that the header block of the loop is set to True. It returns the *entry*
  /// mask for the block BB.
  VectorParts createBlockInMask(BasicBlock *BB);
  /// A helper function that computes the predicate of the edge between SRC
  /// and DST.
  VectorParts createEdgeMask(BasicBlock *Src, BasicBlock *Dst);

  /// A helper function to vectorize a single BB within the innermost loop.
  void vectorizeBlockInLoop(BasicBlock *BB, PhiVector *PV);

  /// Vectorize a single PHINode in a block. This method handles the induction
  /// variable canonicalization. It supports both VF = 1 for unrolled loops and
  /// arbitrary length vectors.
  void widenPHIInstruction(Instruction *PN, VectorParts &Entry, unsigned UF,
                           unsigned VF, PhiVector *PV);

  // Patch up the condition for a branch instruction after the block has been
  // vectorized; only used with predication for now.
  void patchLatchBranch(BranchInst *Br);

  /// Insert the new loop to the loop hierarchy and pass manager
  /// and update the analysis passes.
  void updateAnalysis();

  /// This instruction is un-vectorizable. Implement it as a sequence
  /// of scalars. If \p IfPredicateStore is true we need to 'hide' each
  /// scalarized instruction behind an if block predicated on the control
  /// dependence of the instruction.
  virtual void scalarizeInstruction(Instruction *Instr,
                                    bool IfPredicateStore = false);

  /// Vectorize Load and Store instructions,
  virtual void vectorizeMemoryInstruction(Instruction *Instr);
  virtual void vectorizeArithmeticGEP(Instruction *Instr);
  virtual void vectorizeGEPInstruction(Instruction *Instr);
  virtual void vectorizeMemsetInstruction(MemSetInst *MSI);

  /// Create a broadcast instruction. This method generates a broadcast
  /// instruction (shuffle) for loop invariant values and for the induction
  /// value. If this is the induction variable then we extend it to N, N+1, ...
  /// this is needed because each iteration in the loop corresponds to a SIMD
  /// element.
  virtual Value *getBroadcastInstrs(Value *V);

  /// This function adds (StartIdx, StartIdx + Step, StartIdx + 2*Step, ...)
  /// to each vector element of Val. The sequence starts at StartIndex.
  /// \p Opcode is relevant for FP induction variable.
  virtual Value *getStepVector(Value *Val, int StartIdx, Value *Step,
                               Instruction::BinaryOps Opcode =
                               Instruction::BinaryOpsEnd);
  virtual Value *getStepVector(Value *Val, Value* Start, Value *Step,
                               Instruction::BinaryOps Opcode =
                               Instruction::BinaryOpsEnd);

  virtual Value *getElementCount(Type* ETy, unsigned NumElts, bool Scalable,
                                 Type* RTy = nullptr);

  /// This function adds (StartIdx, StartIdx + Step, StartIdx + 2*Step, ...)
  /// to each vector element of Val. The sequence starts at StartIndex.
  /// Step is a SCEV. In order to get StepValue it takes the existing value
  /// from SCEV or creates a new using SCEVExpander.
  virtual Value *getStepVector(Value *Val, Value *Start, const SCEV *Step,
                               Instruction::BinaryOps Opcode =
                               Instruction::BinaryOpsEnd);

  /// Create a vector induction variable based on an existing scalar one.
  /// Currently only works for integer primary induction variables with
  /// a constant step.
  /// If TruncType is provided, instead of widening the original IV, we
  /// widen a version of the IV truncated to TruncType.
  void widenInductionVariable(const InductionDescriptor &II, VectorParts &Entry,
                              IntegerType *TruncType = nullptr);

  /// When we go over instructions in the basic block we rely on previous
  /// values within the current basic block or on loop invariant values.
  /// When we widen (vectorize) values we place them in the map. If the values
  /// are not within the map, they have to be loop invariant, so we simply
  /// broadcast them into a vector.
  VectorParts &getVectorValue(Value *V);

  /// Try to vectorize the interleaved access group that \p Instr belongs to.
  void vectorizeInterleaveGroup(Instruction *Instr);

  /// Generate a shuffle sequence that will reverse the vector Vec.
  virtual Value *reverseVector(Value *Vec);

  /// Returns (and creates if needed) the original loop trip count.
  Value *getOrCreateTripCount(Loop *NewLoop);

  /// Returns (and creates if needed) the trip count of the widened loop.
  Value *getOrCreateVectorTripCount(Loop *NewLoop);

  /// Returns (and creates if needed) the induction increment per iteration of
  /// the widened loop.
  Value *getOrCreateInductionStep(Loop *NewLoop);

  /// Emit a bypass check to see if the trip count would overflow, or we
  /// wouldn't have enough iterations to execute one vector loop.
  void emitMinimumIterationCountCheck(Loop *L, Value *Min, BasicBlock *Bypass);
  /// Emit a bypass check to see if the vector trip count is nonzero.
  void emitVectorLoopEnteredCheck(Loop *L, BasicBlock *Bypass);
  /// Emit a bypass check to see if all of the SCEV assumptions we've
  /// had to make are correct.
  void emitSCEVChecks(Loop *L, BasicBlock *Bypass);
  /// Emit bypass checks to check any memory assumptions we may have made.
  void emitMemRuntimeChecks(Loop *L, BasicBlock *Bypass);

  /// Add additional metadata to \p To that was not present on \p Orig.
  ///
  /// Currently this is used to add the noalias annotations based on the
  /// inserted memchecks.  Use this for instructions that are *cloned* into the
  /// vector loop.
  void addNewMetadata(Instruction *To, const Instruction *Orig);

  /// Add metadata from one instruction to another.
  ///
  /// This includes both the original MDs from \p From and additional ones (\see
  /// addNewMetadata).  Use this for *newly created* instructions in the vector
  /// loop.
  void addMetadata(Instruction *To, const Instruction *From);

  /// \brief Similar to the previous function but it adds the metadata to a
  /// vector of instructions.
  void addMetadata(SmallVectorImpl<Value *> &To, const Instruction *From);

  /// This is a helper class that holds the vectorizer state. It maps scalar
  /// instructions to vector instructions. When the code is 'unrolled' then
  /// then a single scalar value is mapped to multiple vector parts. The parts
  /// are stored in the VectorPart type.
  struct ValueMap {
    /// C'tor.  UnrollFactor controls the number of vectors ('parts') that
    /// are mapped.
    ValueMap(unsigned UnrollFactor) : UF(UnrollFactor) {}

    /// \return True if 'Key' is saved in the Value Map.
    bool has(Value *Key) const { return MapStorage.count(Key); }

    /// Initializes a new entry in the map. Sets all of the vector parts to the
    /// save value in 'Val'.
    /// \return A reference to a vector with splat values.
    VectorParts &splat(Value *Key, Value *Val) {
      VectorParts &Entry = MapStorage[Key];
      Entry.assign(UF, Val);
      return Entry;
    }

    ///\return A reference to the value that is stored at 'Key'.
    VectorParts &get(Value *Key) {
      VectorParts &Entry = MapStorage[Key];
      if (Entry.empty())
        Entry.resize(UF);
      assert(Entry.size() == UF);
      return Entry;
    }

  private:
    /// The unroll factor. Each entry in the map stores this number of vector
    /// elements.
    unsigned UF;

    /// Map storage. We use std::map and not DenseMap because insertions to a
    /// dense map invalidates its iterators.
    std::map<Value *, VectorParts> MapStorage;
  };

  ///\brief Perform CSE of induction variable instructions.
  void CSE(SmallVector<BasicBlock *, 4> &BBs, SmallSet<BasicBlock *, 2> &Preds);

  /// The original loop.
  Loop *OrigLoop;
  /// A wrapper around ScalarEvolution used to add runtime SCEV checks. Applies
  /// dynamic knowledge to simplify SCEV expressions and converts them to a
  /// more usable form.
  PredicatedScalarEvolution &PSE;
  /// Loop Info.
  LoopInfo *LI;
  /// Dominator Tree.
  DominatorTree *DT;
  /// Target Library Info.
  const TargetLibraryInfo *TLI;
  /// Target Transform Info.
  const TargetTransformInfo *TTI;
  /// Assumption Cache.
  AssumptionCache *AC;
  /// Interface to emit optimization remarks.
  OptimizationRemarkEmitter *ORE;
  /// Alias Analysis.
  AliasAnalysis *AA;

  /// \brief LoopVersioning.  It's only set up (non-null) if memchecks were
  /// used.
  ///
  /// This is currently only used to add no-alias metadata based on the
  /// memchecks.  The actually versioning is performed manually.
  std::unique_ptr<LoopVersioning> LVer;

  /// The vectorization SIMD factor to use. Each vector will have this many
  /// vector elements.
  unsigned VF;
  bool Scalable;
  bool UsePredication;

protected:
  /// Test if instruction I is the exit instruction of some recurrence. If yes,
  /// it sets RD with the associated RecurrenceDescriptor instance.
  bool testHorizontalReductionExitInst(Instruction *I, RecurrenceDescriptor &RD);

  /// The vectorization unroll factor to use. Each scalar is vectorized to this
  /// many different vector instructions.
  unsigned UF;

  /// The builder that we use
  IRBuilder<> Builder;

  // --- Vectorization state ---

  /// The vector-loop preheader.
  BasicBlock *LoopVectorPreHeader;
  /// The scalar-loop preheader.
  BasicBlock *LoopScalarPreHeader;
  /// Middle Block between the vector and the scalar.
  BasicBlock *LoopMiddleBlock;
  /// The ExitBlock of the scalar loop.
  BasicBlock *LoopExitBlock;
  /// The vector loop body.
  SmallVector<BasicBlock *, 4> LoopVectorBody;
  /// The scalar loop body.
  BasicBlock *LoopScalarBody;
  /// A list of all bypass blocks. The first block is the entry of the loop.
  SmallVector<BasicBlock *, 4> LoopBypassBlocks;
  /// The new Induction variable which was added to the new block.
  PHINode *Induction;
  /// The induction variable of the old basic block.
  PHINode *OldInduction;
  /// Value of the induction var for the next loop trip
  Value *InductionStep;
  /// Holds the entry predicates for the current iteration of the vector body.
  PhiVector Predicate;
  /// Holds the extended (to the widest induction type) start index.
  Value *ExtendedIdx;
  /// Maps scalars to widened vectors.
  ValueMap WidenMap;
  /// Store instructions that should be predicated, as a pair
  ///   <StoreInst, Predicate>
  SmallVector<std::pair<StoreInst *, Value *>, 4> PredicatedStores;
  EdgeMaskCache MaskCache;

  // Loop vector body current post-dominator block.
  BasicBlock *VecBodyPostDom;
  typedef std::pair<BasicBlock *, BasicBlock *> DomEdge;
  SmallVector<DomEdge, 4> VecBodyDomEdges;

  // Conditional blocks due to if-conversion.
  SmallSet<BasicBlock *, 2> PredicatedBlocks;
  /// Trip count of the original loop.
  Value *TripCount;
  /// Trip count of the widened loop (TripCount - TripCount % (VF*UF))
  Value *VectorTripCount;

  /// Map of scalar integer values to the smallest bitwidth they can be legally
  /// represented as. The vector equivalents of these values should be truncated
  /// to this type.
  MapVector<Instruction *, uint64_t> MinBWs;
  LoopVectorizationLegality *Legal;

  // Record whether runtime checks are added.
  bool AddedSafetyChecks;

  /// Stores new branch for vectorized latch block so it
  /// can be patched up after vectorization
  BranchInst *LatchBranch;

  /// TODO -- rename this and InductionStep?
  /// TODO -- move both to exit info descriptor?
  Value *IdxEnd;
  Value *IdxEndV;

  // Holds the end values for each induction variable. We save the end values
  // so we can later fix-up the external users of the induction variables.
  DenseMap<PHINode *, Value *> IVEndValues;
};

class InnerLoopUnroller : public InnerLoopVectorizer {
public:
  InnerLoopUnroller(Loop *OrigLoop, PredicatedScalarEvolution &PSE,
                    LoopInfo *LI, DominatorTree *DT,
                    const TargetLibraryInfo *TLI,
                    const TargetTransformInfo *TTI, AssumptionCache *AC,
                    OptimizationRemarkEmitter *ORE,
                    unsigned UnrollFactor)
      : InnerLoopVectorizer(OrigLoop, PSE, LI, DT, TLI, TTI, AC, ORE, 1,
                            UnrollFactor, true) {}

private:
  void scalarizeInstruction(Instruction *Instr,
                            bool IfPredicateStore = false) override;
  void vectorizeMemoryInstruction(Instruction *Instr) override;
  Value *getBroadcastInstrs(Value *V) override;
  Value *getStepVector(Value *Val, int StartIdx, Value *Step,
                       Instruction::BinaryOps Opcode =
                       Instruction::BinaryOpsEnd) override;
  Value *getStepVector(Value *Val, Value *Start, Value *Step,
                       Instruction::BinaryOps Opcode =
                       Instruction::BinaryOpsEnd) override;
  Value *getStepVector(Value *Val, Value *Start, const SCEV *StepSCEV,
                       Instruction::BinaryOps Opcode =
                       Instruction::BinaryOpsEnd) override;
  Value *reverseVector(Value *Vec) override;
};

/// \brief Look for a meaningful debug location on the instruction or it's
/// operands.
static Instruction *getDebugLocFromInstOrOperands(Instruction *I) {
  if (!I)
    return I;

  DebugLoc Empty;
  if (I->getDebugLoc() != Empty)
    return I;

  for (User::op_iterator OI = I->op_begin(), OE = I->op_end(); OI != OE; ++OI) {
    if (Instruction *OpInst = dyn_cast<Instruction>(*OI))
      if (OpInst->getDebugLoc() != Empty)
        return OpInst;
  }

  return I;
}

/// \brief Set the debug location in the builder using the debug location in the
/// instruction.
static void setDebugLocFromInst(IRBuilder<> &B, const Value *Ptr) {
  if (const Instruction *Inst = dyn_cast_or_null<Instruction>(Ptr))
    B.SetCurrentDebugLocation(Inst->getDebugLoc());
  else
    B.SetCurrentDebugLocation(DebugLoc());
}

#ifndef NDEBUG
/// \return string containing a file name and a line # for the given loop.
static std::string getDebugLocString(const Loop *L) {
  std::string Result;
  if (L) {
    raw_string_ostream OS(Result);
    if (const DebugLoc LoopDbgLoc = L->getStartLoc())
      LoopDbgLoc.print(OS);
    else
      // Just print the module name.
      OS << L->getHeader()->getParent()->getParent()->getModuleIdentifier();
    OS.flush();
  }
  return Result;
}
#endif

/// \brief Propagate known metadata from one instruction to another.
static void propagateMetadata(Instruction *To, const Instruction *From) {
  SmallVector<std::pair<unsigned, MDNode *>, 4> Metadata;
  From->getAllMetadataOtherThanDebugLoc(Metadata);

  for (auto M : Metadata) {
    unsigned Kind = M.first;

    // These are safe to transfer (this is safe for TBAA, even when we
    // if-convert, because should that metadata have had a control dependency
    // on the condition, and thus actually aliased with some other
    // non-speculated memory access when the condition was false, this would be
    // caught by the runtime overlap checks).
    if (Kind != LLVMContext::MD_tbaa && Kind != LLVMContext::MD_alias_scope &&
        Kind != LLVMContext::MD_noalias && Kind != LLVMContext::MD_fpmath &&
        Kind != LLVMContext::MD_nontemporal)
      continue;

    To->setMetadata(Kind, M.second);
  }
}

void InnerLoopVectorizer::addNewMetadata(Instruction *To,
                                         const Instruction *Orig) {
  // If the loop was versioned with memchecks, add the corresponding no-alias
  // metadata.
  if (LVer && (isa<LoadInst>(Orig) || isa<StoreInst>(Orig)))
    LVer->annotateInstWithNoAlias(To, Orig);
}

void InnerLoopVectorizer::addMetadata(Instruction *To,
                                      const Instruction *From) {
  propagateMetadata(To, From);
  addNewMetadata(To, From);
}

void InnerLoopVectorizer::addMetadata(SmallVectorImpl<Value *> &To,
                                      const Instruction *From) {
  for (Value *V : To)
    if (Instruction *I = dyn_cast<Instruction>(V))
      addMetadata(I, From);
}

/// \brief The group of interleaved loads/stores sharing the same stride and
/// close to each other.
///
/// Each member in this group has an index starting from 0, and the largest
/// index should be less than interleaved factor, which is equal to the absolute
/// value of the access's stride.
///
/// E.g. An interleaved load group of factor 4:
///        for (unsigned i = 0; i < 1024; i+=4) {
///          a = A[i];                           // Member of index 0
///          b = A[i+1];                         // Member of index 1
///          d = A[i+3];                         // Member of index 3
///          ...
///        }
///
///      An interleaved store group of factor 4:
///        for (unsigned i = 0; i < 1024; i+=4) {
///          ...
///          A[i]   = a;                         // Member of index 0
///          A[i+1] = b;                         // Member of index 1
///          A[i+2] = c;                         // Member of index 2
///          A[i+3] = d;                         // Member of index 3
///        }
///
/// Note: the interleaved load group could have gaps (missing members), but
/// the interleaved store group doesn't allow gaps.
class InterleaveGroup {
public:
  InterleaveGroup(Instruction *Instr, int Stride, unsigned Align)
      : Align(Align), SmallestKey(0), LargestKey(0), InsertPos(Instr) {
    assert(Align && "The alignment should be non-zero");

    Factor = std::abs(Stride);
    assert(Factor > 1 && "Invalid interleave factor");

    Reverse = Stride < 0;
    Members[0] = Instr;
  }

  bool isReverse() const { return Reverse; }
  unsigned getFactor() const { return Factor; }
  unsigned getAlignment() const { return Align; }
  unsigned getNumMembers() const { return Members.size(); }

  /// \brief Try to insert a new member \p Instr with index \p Index and
  /// alignment \p NewAlign. The index is related to the leader and it could be
  /// negative if it is the new leader.
  ///
  /// \returns false if the instruction doesn't belong to the group.
  bool insertMember(Instruction *Instr, int Index, unsigned NewAlign) {
    assert(NewAlign && "The new member's alignment should be non-zero");

    int Key = Index + SmallestKey;

    // Skip if there is already a member with the same index.
    if (Members.count(Key))
      return false;

    if (Key > LargestKey) {
      // The largest index is always less than the interleave factor.
      if (Index >= static_cast<int>(Factor))
        return false;

      LargestKey = Key;
    } else if (Key < SmallestKey) {
      // The largest index is always less than the interleave factor.
      if (LargestKey - Key >= static_cast<int>(Factor))
        return false;

      SmallestKey = Key;
    }

    // It's always safe to select the minimum alignment.
    Align = std::min(Align, NewAlign);
    Members[Key] = Instr;
    return true;
  }

  /// \brief Get the member with the given index \p Index
  ///
  /// \returns nullptr if contains no such member.
  Instruction *getMember(unsigned Index) const {
    int Key = SmallestKey + Index;
    if (!Members.count(Key))
      return nullptr;

    return Members.find(Key)->second;
  }

  /// \brief Get the index for the given member. Unlike the key in the member
  /// map, the index starts from 0.
  unsigned getIndex(Instruction *Instr) const {
    for (auto I : Members)
      if (I.second == Instr)
        return I.first - SmallestKey;

    llvm_unreachable("InterleaveGroup contains no such member");
  }

  Instruction *getInsertPos() const { return InsertPos; }
  void setInsertPos(Instruction *Inst) { InsertPos = Inst; }

private:
  unsigned Factor; // Interleave Factor.
  bool Reverse;
  unsigned Align;
  DenseMap<int, Instruction *> Members;
  int SmallestKey;
  int LargestKey;

  // To avoid breaking dependences, vectorized instructions of an interleave
  // group should be inserted at either the first load or the last store in
  // program order.
  //
  // E.g. %even = load i32             // Insert Position
  //      %add = add i32 %even         // Use of %even
  //      %odd = load i32
  //
  //      store i32 %even
  //      %odd = add i32               // Def of %odd
  //      store i32 %odd               // Insert Position
  Instruction *InsertPos;
};

/// \brief Drive the analysis of interleaved memory accesses in the loop.
///
/// Use this class to analyze interleaved accesses only when we can vectorize
/// a loop. Otherwise it's meaningless to do analysis as the vectorization
/// on interleaved accesses is unsafe.
///
/// The analysis collects interleave groups and records the relationships
/// between the member and the group in a map.
class InterleavedAccessInfo {
public:
  InterleavedAccessInfo(PredicatedScalarEvolution &PSE, Loop *L,
                        DominatorTree *DT, LoopInfo *LI)
  : PSE(PSE), TheLoop(L), DT(DT), LI(LI), LAI(nullptr),
  RequiresScalarEpilogue(false) {}

  ~InterleavedAccessInfo() {
    SmallSet<InterleaveGroup *, 4> DelSet;
    // Avoid releasing a pointer twice.
    for (auto &I : InterleaveGroupMap)
      DelSet.insert(I.second);
    for (auto *Ptr : DelSet)
      delete Ptr;
  }

  /// \brief Analyze the interleaved accesses and collect them in interleave
  /// groups. Substitute symbolic strides using \p Strides.
  void analyzeInterleaving(const ValueToValueMap &Strides);

  /// \brief Check if \p Instr belongs to any interleave group.
  bool isInterleaved(Instruction *Instr) const {
    return InterleaveGroupMap.count(Instr);
  }

  /// \brief Return the maximum interleave factor of all interleaved groups.
  unsigned getMaxInterleaveFactor() const {
    unsigned MaxFactor = 1;
    for (auto &Entry : InterleaveGroupMap)
      MaxFactor = std::max(MaxFactor, Entry.second->getFactor());
    return MaxFactor;
  }

  /// \brief Get the interleave group that \p Instr belongs to.
  ///
  /// \returns nullptr if doesn't have such group.
  InterleaveGroup *getInterleaveGroup(Instruction *Instr) const {
    if (InterleaveGroupMap.count(Instr))
      return InterleaveGroupMap.find(Instr)->second;
    return nullptr;
  }

  /// \brief Returns true if an interleaved group that may access memory
  /// out-of-bounds requires a scalar epilogue iteration for correctness.
  bool requiresScalarEpilogue() const { return RequiresScalarEpilogue; }

  /// \brief Initialize the LoopAccessInfo used for dependence checking.
  void setLAI(const LoopAccessInfo *Info) { LAI = Info; }

private:
  /// A wrapper around ScalarEvolution, used to add runtime SCEV checks.
  /// Simplifies SCEV expressions in the context of existing SCEV assumptions.
  /// The interleaved access analysis can also add new predicates (for example
  /// by versioning strides of pointers).
  PredicatedScalarEvolution &PSE;
  Loop *TheLoop;
  DominatorTree *DT;
  LoopInfo *LI;
  const LoopAccessInfo *LAI;

  /// True if the loop may contain non-reversed interleaved groups with
  /// out-of-bounds accesses. We ensure we don't speculatively access memory
  /// out-of-bounds by executing at least one scalar epilogue iteration.
  bool RequiresScalarEpilogue;

  /// Holds the relationships between the members and the interleave group.
  DenseMap<Instruction *, InterleaveGroup *> InterleaveGroupMap;

  /// Holds dependences among the memory accesses in the loop. It maps a source
  /// access to a set of dependent sink accesses.
  DenseMap<Instruction *, SmallPtrSet<Instruction *, 2>> Dependences;

  /// \brief The descriptor for a strided memory access.
  struct StrideDescriptor {
    StrideDescriptor(int64_t Stride, const SCEV *Scev, uint64_t Size,
                     unsigned Align)
    : Stride(Stride), Scev(Scev), Size(Size), Align(Align) {}

    StrideDescriptor() = default;

    // The access's stride. It is negative for a reverse access.
    int64_t Stride = 0;
    const SCEV *Scev = nullptr; // The scalar expression of this access
    uint64_t Size = 0;          // The size of the memory object.
    unsigned Align = 0;         // The alignment of this access.
  };

  /// \brief A type for holding instructions and their stride descriptors.
  typedef std::pair<Instruction *, StrideDescriptor> StrideEntry;

  /// \brief Create a new interleave group with the given instruction \p Instr,
  /// stride \p Stride and alignment \p Align.
  ///
  /// \returns the newly created interleave group.
  InterleaveGroup *createInterleaveGroup(Instruction *Instr, int Stride,
                                         unsigned Align) {
    assert(!InterleaveGroupMap.count(Instr) &&
           "Already in an interleaved access group");
    InterleaveGroupMap[Instr] = new InterleaveGroup(Instr, Stride, Align);
    return InterleaveGroupMap[Instr];
  }

  /// \brief Release the group and remove all the relationships.
  void releaseGroup(InterleaveGroup *Group) {
    for (unsigned i = 0; i < Group->getFactor(); i++)
      if (Instruction *Member = Group->getMember(i))
        InterleaveGroupMap.erase(Member);

    delete Group;
  }

  /// \brief Collect all the accesses with a constant stride in program order.
  void collectConstStrideAccesses(
      MapVector<Instruction *, StrideDescriptor> &AccessStrideInfo,
      const ValueToValueMap &Strides);

  /// \brief Returns true if \p Stride is allowed in an interleaved group.
  static bool isStrided(int Stride) {
    unsigned Factor = std::abs(Stride);
    return Factor >= 2 && Factor <= MaxInterleaveGroupFactor;
  }

  /// \brief Returns true if \p BB is a predicated block.
  bool isPredicated(BasicBlock *BB) const {
    return LoopAccessInfo::blockNeedsPredication(BB, TheLoop, DT);
  }

  /// \brief Returns true if LoopAccessInfo can be used for dependence queries.
  bool areDependencesValid() const {
    return LAI && LAI->getDepChecker().getDependences();
  }

  /// \brief Returns true if memory accesses \p A and \p B can be reordered, if
  /// necessary, when constructing interleaved groups.
  ///
  /// \p A must precede \p B in program order. We return false if reordering is
  /// not necessary or is prevented because \p A and \p B may be dependent.
  bool canReorderMemAccessesForInterleavedGroups(StrideEntry *A,
                                                 StrideEntry *B) const {

    // Code motion for interleaved accesses can potentially hoist strided loads
    // and sink strided stores. The code below checks the legality of the
    // following two conditions:
    //
    // 1. Potentially moving a strided load (B) before any store (A) that
    //    precedes B, or
    //
    // 2. Potentially moving a strided store (A) after any load or store (B)
    //    that A precedes.
    //
    // It's legal to reorder A and B if we know there isn't a dependence from A
    // to B. Note that this determination is conservative since some
    // dependences could potentially be reordered safely.
    // A is potentially the source of a dependence.
    auto *Src = A->first;
    auto SrcDes = A->second;

    // B is potentially the sink of a dependence.
    auto *Sink = B->first;
    auto SinkDes = B->second;

    // Code motion for interleaved accesses can't violate WAR dependences.
    // Thus, reordering is legal if the source isn't a write.
    if (!Src->mayWriteToMemory())
      return true;

    // At least one of the accesses must be strided.
    if (!isStrided(SrcDes.Stride) && !isStrided(SinkDes.Stride))
      return true;

    // If dependence information is not available from LoopAccessInfo,
    // conservatively assume the instructions can't be reordered.
    if (!areDependencesValid())
      return false;

    // If we know there is a dependence from source to sink, assume the
    // instructions can't be reordered. Otherwise, reordering is legal.
    return !Dependences.count(Src) || !Dependences.lookup(Src).count(Sink);
  }
    
  /// \brief Collect the dependences from LoopAccessInfo.
  ///
  /// We process the dependences once during the interleaved access analysis to
  /// enable constant-time dependence queries.
  void collectDependences() {
    if (!areDependencesValid())
      return;
    auto *Deps = LAI->getDepChecker().getDependences();
    for (auto Dep : *Deps)
      Dependences[Dep.getSource(*LAI)].insert(Dep.getDestination(*LAI));
  }
};

/// Utility class for getting and setting loop vectorizer hints in the form
/// of loop metadata.
/// This class keeps a number of loop annotations locally (as member variables)
/// and can, upon request, write them back as metadata on the loop. It will
/// initially scan the loop for existing metadata, and will update the local
/// values based on information in the loop.
/// We cannot write all values to metadata, as the mere presence of some info,
/// for example 'force', means a decision has been made. So, we need to be
/// careful NOT to add them if the user hasn't specifically asked so.
class LoopVectorizeHints {
  enum HintKind {
    HK_WIDTH,
    HK_UNROLL,
    HK_FORCE,
    HK_STYLE
  };

  /// Hint - associates name and validation with the hint value.
  struct Hint {
    const char *Name;
    unsigned Value; // This may have to change for non-numeric values.
    HintKind Kind;

    Hint(const char *Name, unsigned Value, HintKind Kind)
        : Name(Name), Value(Value), Kind(Kind) {}

    bool validate(unsigned Val) {
      switch (Kind) {
      case HK_WIDTH:
        return isPowerOf2_32(Val) && Val <= VectorizerParams::MaxVectorWidth;
      case HK_UNROLL:
        return isPowerOf2_32(Val) && Val <= MaxInterleaveFactor;
      case HK_FORCE:
        return Val <= 1;
      case HK_STYLE:
        return Val <= 2;
      }
      return false;
    }
  };

  /// Vectorization width.
  Hint Width;
  /// Vectorization interleave factor.
  Hint Interleave;
  /// Vectorization forced.
  Hint Force;
  /// Vectorization style (fixed/scaled vector width).
  Hint Style;

  /// Return the loop metadata prefix.
  static StringRef Prefix() { return "llvm.loop."; }

  /// True if there is any unsafe math in the loop.
  bool PotentiallyUnsafe;

public:
  enum ForceKind {
    FK_Undefined = -1, ///< Not selected.
    FK_Disabled = 0,   ///< Forcing disabled.
    FK_Enabled = 1     ///< Forcing enabled.
  };

   enum StyleKind {
    SK_Unspecified = 0,
    SK_Fixed = 1,       ///< Forcing fixed width vectorization.
    SK_Scaled = 2       ///< Forcing scalable vectorization.
  };

  LoopVectorizeHints(const Loop *L, bool DisableInterleaving,
                     OptimizationRemarkEmitter &ORE)
      : Width("vectorize.width", VectorizerParams::VectorizationFactor,
              HK_WIDTH),
        Interleave("interleave.count", DisableInterleaving, HK_UNROLL),
        Force("vectorize.enable", FK_Undefined, HK_FORCE),
        Style("vectorize.style", SK_Unspecified, HK_STYLE),
        PotentiallyUnsafe(false), TheLoop(L), ORE(ORE) {
    // Populate values with existing loop metadata.
    getHintsFromMetadata();

    // force-vector-interleave overrides DisableInterleaving.
    if (VectorizerParams::isInterleaveForced())
      Interleave.Value = VectorizerParams::VectorizationInterleave;

    DEBUG(if (DisableInterleaving && Interleave.Value == 1) dbgs()
          << "LV: Interleaving disabled by the pass manager\n");
  }

  /// Mark the loop L as already vectorized by setting the width to 1.
  void setAlreadyVectorized() {
    Width.Value = Interleave.Value = 1;
    Hint Hints[] = {Width, Interleave};
    writeHintsToMetadata(Hints);
  }

  bool allowVectorization(Function *F, Loop *L, bool AlwaysVectorize) const {
    if (getForce() == LoopVectorizeHints::FK_Disabled) {
      DEBUG(dbgs() << "LV: Not vectorizing: #pragma vectorize disable.\n");
      emitRemarkWithHints();
      return false;
    }

    if (!AlwaysVectorize && getForce() != LoopVectorizeHints::FK_Enabled) {
      DEBUG(dbgs() << "LV: Not vectorizing: No #pragma vectorize enable.\n");
      emitRemarkWithHints();
      return false;
    }

    if (getWidth() == 1 && getInterleave() == 1) {
      // FIXME: Add a separate metadata to indicate when the loop has already
      // been vectorized instead of setting width and count to 1.
      DEBUG(dbgs() << "LV: Not vectorizing: Disabled/already vectorized.\n");
      // FIXME: Add interleave.disable metadata. This will allow
      // vectorize.disable to be used without disabling the pass and errors
      // to differentiate between disabled vectorization and a width of 1.
      emitOptimizationRemarkAnalysis(
          F->getContext(), vectorizeAnalysisPassName(), *F, L->getStartLoc(),
          "loop not vectorized: vectorization and interleaving are explicitly "
          "disabled, or vectorize width and interleave count are both set to "
          "1");
      return false;
    }

    return true;
  }

  /// Dumps all the hint information.
  void emitRemarkWithHints() const {
    using namespace ore;
    if (Force.Value == LoopVectorizeHints::FK_Disabled)
      ORE.emit(OptimizationRemarkMissed(LV_NAME, "MissedExplicitlyDisabled",
                                        TheLoop->getStartLoc(),
                                        TheLoop->getHeader())
               << "loop not vectorized: vectorization is explicitly disabled");
    else {
      OptimizationRemarkMissed R(LV_NAME, "MissedDetails",
                                 TheLoop->getStartLoc(), TheLoop->getHeader());
      R << "loop not vectorized";
      if (Force.Value == LoopVectorizeHints::FK_Enabled) {
        R << " (Force=" << NV("Force", true);
        if (Style.Value == LoopVectorizeHints::SK_Fixed)
          R << ", Style=fixed";
        else if (Style.Value == LoopVectorizeHints::SK_Scaled)
          R << ", Style=scaled";
        if (Width.Value != 0)
          R << ", Vector Width=" << NV("VectorWidth", Width.Value);
        if (Interleave.Value != 0)
          R << ", Interleave Count=" << NV("InterleaveCount", Interleave.Value);
        R << ")";
      }
      ORE.emit(R);
    }
  }


  unsigned getWidth() const { return Width.Value; }
  unsigned getInterleave() const { return Interleave.Value; }
  enum ForceKind getForce() const { return (ForceKind)Force.Value; }
  unsigned getStyle() const { return Style.Value; }
  /// \brief If hints are provided that force vectorization, use the AlwaysPrint
  /// pass name to force the frontend to print the diagnostic.
  const char *vectorizeAnalysisPassName() const {
    if (getWidth() == 1)
      return LV_NAME;
    if (getForce() == LoopVectorizeHints::FK_Disabled)
      return LV_NAME;
    if (getForce() == LoopVectorizeHints::FK_Undefined && getWidth() == 0)
      return LV_NAME;
    return OptimizationRemarkAnalysis::AlwaysPrint;
  }

  bool allowReordering() const {
    // When enabling loop hints are provided we allow the vectorizer to change
    // the order of operations that is given by the scalar loop. This is not
    // enabled by default because can be unsafe or inefficient. For example,
    // reordering floating-point operations will change the way round-off
    // error accumulates in the loop.
    return getForce() == LoopVectorizeHints::FK_Enabled || getWidth() > 1;
  }

  bool isPotentiallyUnsafe() const {
    // Avoid FP vectorization if the target is unsure about proper support.
    // This may be related to the SIMD unit in the target not handling
    // IEEE 754 FP ops properly, or bad single-to-double promotions.
    // Otherwise, a sequence of vectorized loops, even without reduction,
    // could lead to different end results on the destination vectors.
    return getForce() != LoopVectorizeHints::FK_Enabled && PotentiallyUnsafe;
  }

  void setPotentiallyUnsafe() { PotentiallyUnsafe = true; }

private:
  /// Find hints specified in the loop metadata and update local values.
  void getHintsFromMetadata() {
    MDNode *LoopID = TheLoop->getLoopID();
    if (!LoopID)
      return;

    // First operand should refer to the loop id itself.
    assert(LoopID->getNumOperands() > 0 && "requires at least one operand");
    assert(LoopID->getOperand(0) == LoopID && "invalid loop id");

    for (unsigned i = 1, ie = LoopID->getNumOperands(); i < ie; ++i) {
      const MDString *S = nullptr;
      SmallVector<Metadata *, 4> Args;

      // The expected hint is either a MDString or a MDNode with the first
      // operand a MDString.
      if (const MDNode *MD = dyn_cast<MDNode>(LoopID->getOperand(i))) {
        if (!MD || MD->getNumOperands() == 0)
          continue;
        S = dyn_cast<MDString>(MD->getOperand(0));
        for (unsigned i = 1, ie = MD->getNumOperands(); i < ie; ++i)
          Args.push_back(MD->getOperand(i));
      } else {
        S = dyn_cast<MDString>(LoopID->getOperand(i));
        assert(Args.size() == 0 && "too many arguments for MDString");
      }

      if (!S)
        continue;

      // Check if the hint starts with the loop metadata prefix.
      StringRef Name = S->getString();
      if (Args.size() == 1)
        setHint(Name, Args[0]);
    }
  }

  /// Checks string hint with one operand and set value if valid.
  void setHint(StringRef Name, Metadata *Arg) {
    if (!Name.startswith(Prefix()))
      return;
    Name = Name.substr(Prefix().size(), StringRef::npos);

    const ConstantInt *C = mdconst::dyn_extract<ConstantInt>(Arg);
    if (!C)
      return;
    unsigned Val = C->getZExtValue();

    Hint *Hints[] = {&Width, &Style, &Interleave, &Force};
    for (auto H : Hints) {
      if (Name == H->Name) {
        if (H->validate(Val))
          H->Value = Val;
        else
          DEBUG(dbgs() << "LV: ignoring invalid hint '" << Name << "'\n");
        break;
      }
    }
  }

  /// Create a new hint from name / value pair.
  MDNode *createHintMetadata(StringRef Name, unsigned V) const {
    LLVMContext &Context = TheLoop->getHeader()->getContext();
    Metadata *MDs[] = {MDString::get(Context, Name),
                       ConstantAsMetadata::get(
                           ConstantInt::get(Type::getInt32Ty(Context), V))};
    return MDNode::get(Context, MDs);
  }

  /// Matches metadata with hint name.
  bool matchesHintMetadataName(MDNode *Node, ArrayRef<Hint> HintTypes) {
    MDString *Name = dyn_cast<MDString>(Node->getOperand(0));
    if (!Name)
      return false;

    for (auto H : HintTypes)
      if (Name->getString().endswith(H.Name))
        return true;
    return false;
  }

  /// Sets current hints into loop metadata, keeping other values intact.
  void writeHintsToMetadata(ArrayRef<Hint> HintTypes) {
    if (HintTypes.size() == 0)
      return;

    // Reserve the first element to LoopID (see below).
    SmallVector<Metadata *, 4> MDs(1);
    // If the loop already has metadata, then ignore the existing operands.
    MDNode *LoopID = TheLoop->getLoopID();
    if (LoopID) {
      for (unsigned i = 1, ie = LoopID->getNumOperands(); i < ie; ++i) {
        MDNode *Node = cast<MDNode>(LoopID->getOperand(i));
        // If node in update list, ignore old value.
        if (!matchesHintMetadataName(Node, HintTypes))
          MDs.push_back(Node);
      }
    }

    // Now, add the missing hints.
    for (auto H : HintTypes)
      MDs.push_back(createHintMetadata(Twine(Prefix(), H.Name).str(), H.Value));

    // Replace current metadata node with new one.
    LLVMContext &Context = TheLoop->getHeader()->getContext();
    MDNode *NewLoopID = MDNode::get(Context, MDs);
    // Set operand 0 to refer to the loop id itself.
    NewLoopID->replaceOperandWith(0, NewLoopID);

    TheLoop->setLoopID(NewLoopID);
  }

  /// The loop these hints belong to.
  const Loop *TheLoop;

  /// Interface to emit optimization remarks.
  OptimizationRemarkEmitter &ORE;
};

static void emitMissedWarning(Function *F, Loop *L,
                              const LoopVectorizeHints &LH,
                              OptimizationRemarkEmitter *ORE) {
  LH.emitRemarkWithHints();

  if (LH.getForce() == LoopVectorizeHints::FK_Enabled) {
    if (LH.getWidth() != 1)
      ORE->emit(DiagnosticInfoOptimizationFailure(
                    DEBUG_TYPE, "FailedRequestedVectorization",
                    {L->getLocRange().getStart(), L->getLocRange().getEnd()},
                    L->getHeader())
                << "loop not vectorized: "
                << "failed explicitly specified loop vectorization");
    else if (LH.getInterleave() != 1)
      ORE->emit(DiagnosticInfoOptimizationFailure(
                    DEBUG_TYPE, "FailedRequestedInterleaving",
                    {L->getLocRange().getStart(), L->getLocRange().getEnd()},
                    L->getHeader())
                << "loop not interleaved: "
                << "failed explicitly specified loop interleaving");
  }
}

/// LoopVectorizationLegality checks if it is legal to vectorize a loop, and
/// to what vectorization factor.
/// This class does not look at the profitability of vectorization, only the
/// legality. This class has two main kinds of checks:
/// * Memory checks - The code in canVectorizeMemory checks if vectorization
///   will change the order of memory accesses in a way that will change the
///   correctness of the program.
/// * Scalars checks - The code in canVectorizeInstrs and canVectorizeMemory
/// checks for a number of different conditions, such as the availability of a
/// single induction variable, that all types are supported and vectorize-able,
/// etc. This code reflects the capabilities of InnerLoopVectorizer.
/// This class is also used by InnerLoopVectorizer for identifying
/// induction variable and the different reduction variables.
class LoopVectorizationLegality {
public:
  LoopVectorizationLegality(
      Loop *L, PredicatedScalarEvolution &PSE, DominatorTree *DT,
      TargetLibraryInfo *TLI, AliasAnalysis *AA, Function *F,
      const TargetTransformInfo *TTI,
      std::function<const LoopAccessInfo &(Loop &)> *GetLAA, LoopInfo *LI,
      OptimizationRemarkEmitter *ORE, LoopVectorizationRequirements *R,
      LoopVectorizeHints *H)
      : NumPredStores(0), TheLoop(L), PSE(PSE), TLI(TLI), TTI(TTI), DT(DT),
        GetLAA(GetLAA), LAI(nullptr), ORE(ORE), InterleaveInfo(PSE, L, DT, LI),
        PrimaryInduction(nullptr), WidestIndTy(nullptr), HasFunNoNaNAttr(false),
        Requirements(R), Hints(H) {}

  /// Returns true if the function has an attribute saying that
  /// we can assume the absence of NaNs.
  bool hasNoNaNAttr(void) const { return HasFunNoNaNAttr; }

  /// ReductionList contains the reduction descriptors for all
  /// of the reductions that were found in the loop.
  typedef DenseMap<PHINode *, RecurrenceDescriptor> ReductionList;

  /// InductionList saves induction variables and maps them to the
  /// induction descriptor.
  typedef MapVector<PHINode *, InductionDescriptor> InductionList;

  /// RecurrenceSet contains the phi nodes that are recurrences other than
  /// inductions and reductions.
  typedef SmallPtrSet<const PHINode *, 8> RecurrenceSet;

  /// Returns true if it is legal to vectorize this loop.
  /// This does not mean that it is profitable to vectorize this
  /// loop, only that it is legal to do so.
  bool canVectorize();

  /// Returns the primary induction variable.
  PHINode *getPrimaryInduction() { return PrimaryInduction; }

  /// Returns the reduction variables found in the loop.
  ReductionList *getReductionVars() { return &Reductions; }

  /// Checks if all reduction can be performed using ordered intrinsics in
  /// the loop body (e.g. using '@llvm.aarch64.sve.adda.' intrinsic).
  bool allReductionsAreStrict() const {
    for (auto RedP : Reductions)
      if (!RedP.second.isOrdered())
        return false;

    return true;
  }

  /// Returns the induction variables found in the loop.
  InductionList *getInductionVars() { return &Inductions; }

  /// Return the first-order recurrences found in the loop.
  RecurrenceSet *getFirstOrderRecurrences() { return &FirstOrderRecurrences; }

  /// Return the set of instructions to sink to handle first-order recurrences.
  DenseMap<Instruction *, Instruction *> &getSinkAfter() { return SinkAfter; }

  /// Returns the widest induction type.
  Type *getWidestInductionType() { return WidestIndTy; }

  /// Returns True if V is an induction variable in this loop.
  bool isInductionVariable(const Value *V);

  /// Returns True if PN is a reduction variable in this loop.
  bool isReductionVariable(PHINode *PN) { return Reductions.count(PN); }

  /// Returns True if Phi is a first-order recurrence in this loop.
  bool isFirstOrderRecurrence(const PHINode *Phi);

  /// Return true if the block BB needs to be predicated in order for the loop
  /// to be vectorized.
  bool blockNeedsPredication(BasicBlock *BB);

  /// Check if this pointer is consecutive when vectorizing. This happens
  /// when the last index of the GEP is the induction variable, or that the
  /// pointer itself is an induction variable.
  /// This check allows us to vectorize A[idx] into a wide load/store.
  /// Returns:
  /// 0 - Stride is unknown or non-consecutive.
  /// 1 - Address is consecutive.
  /// -1 - Address is consecutive, and decreasing.
  int isConsecutivePtr(Value *Ptr);

  /// Returns true if the value V is uniform within the loop.
  bool isUniform(Value *V);

  /// Returns true if this instruction will remain scalar after vectorization.
  bool isUniformAfterVectorization(Instruction *I) { return Uniforms.count(I); }

  /// Returns the information that we collected about runtime memory check.
  const RuntimePointerChecking *getRuntimePointerChecking() const {
    return LAI->getRuntimePointerChecking();
  }

  const LoopAccessInfo *getLAI() const { return LAI; }

  /// \brief Check if \p Instr belongs to any interleaved access group.
  bool isAccessInterleaved(Instruction *Instr) {
    return InterleaveInfo.isInterleaved(Instr);
  }

  /// \brief Return the maximum interleave factor of all interleaved groups.
  unsigned getMaxInterleaveFactor() const {
    return InterleaveInfo.getMaxInterleaveFactor();
  }

  /// \brief Get the interleaved access group that \p Instr belongs to.
  const InterleaveGroup *getInterleavedAccessGroup(Instruction *Instr) {
    return InterleaveInfo.getInterleaveGroup(Instr);
  }

  /// \brief Returns true if an interleaved group requires a scalar iteration
  /// to handle accesses with gaps.
  bool requiresScalarEpilogue() const {
    return InterleaveInfo.requiresScalarEpilogue();
  }

  unsigned getMaxSafeDepDistBytes() { return LAI->getMaxSafeDepDistBytes(); }

  bool hasStride(Value *V) { return StrideSet.count(V); }
  bool mustCheckStrides() { return !StrideSet.empty(); }
  SmallPtrSet<Value *, 8>::iterator strides_begin() {
    return StrideSet.begin();
  }
  SmallPtrSet<Value *, 8>::iterator strides_end() { return StrideSet.end(); }

  /// Returns true if the target machine supports masked store operation
  /// for the given \p DataType and kind of access to \p Ptr.
  bool isLegalMaskedStore(Type *DataType, Value *Ptr) {
    return isConsecutivePtr(Ptr) && TTI->isLegalMaskedStore(DataType);
  }
  /// Returns true if the target machine supports masked load operation
  /// for the given \p DataType and kind of access to \p Ptr.
  bool isLegalMaskedLoad(Type *DataType, Value *Ptr) {
    return isConsecutivePtr(Ptr) && TTI->isLegalMaskedLoad(DataType);
  }
  /// Returns true if the target machine supports masked scatter operation
  /// for the given \p DataType.
  bool isLegalMaskedScatter(Type *DataType) {
    return TTI->isLegalMaskedScatter(DataType);
  }
  /// Returns true if the target machine supports masked gather operation
  /// for the given \p DataType.
  bool isLegalMaskedGather(Type *DataType) {
    return TTI->isLegalMaskedGather(DataType);
  }

  /// Returns true if the target machine can represent \p V as a masked gather
  /// or scatter operation.
  bool isLegalGatherOrScatter(Value *V) {
    auto *LI = dyn_cast<LoadInst>(V);
    auto *SI = dyn_cast<StoreInst>(V);
    if (!LI && !SI)
      return false;
    auto *Ptr = getPointerOperand(V);
    auto *Ty = cast<PointerType>(Ptr->getType())->getElementType();
    return (LI && isLegalMaskedGather(Ty)) || (SI && isLegalMaskedScatter(Ty));
  }

  /// Returns true if vector representation of the instruction \p I
  /// requires mask.
  bool isMaskRequired(const Instruction *I) { return (MaskedOp.count(I) != 0); }
  /// Returns true if the loop requires masked operations for vectorisation to
  /// be legal.
  bool hasMaskedOperations() { return MaskedOp.begin() != MaskedOp.end(); }
  unsigned getNumStores() const { return LAI->getNumStores(); }
  unsigned getNumLoads() const { return LAI->getNumLoads(); }
  unsigned getNumPredStores() const { return NumPredStores; }

private:
  /// Check if a single basic block loop is vectorizable.
  /// At this point we know that this is a loop with a constant trip count
  /// and we only need to check individual instructions.
  bool canVectorizeInstrs();

  /// When we vectorize loops we may change the order in which
  /// we read and write from memory. This method checks if it is
  /// legal to vectorize the code, considering only memory constrains.
  /// Returns true if the loop is vectorizable
  bool canVectorizeMemory();

  /// Return true if we can vectorize this loop using the IF-conversion
  /// transformation.
  bool canVectorizeWithIfConvert();

  /// Collect the variables that need to stay uniform after vectorization.
  void collectLoopUniforms();

  /// Return true if all of the instructions in the block can be speculatively
  /// executed. \p SafePtrs is a list of addresses that are known to be legal
  /// and we know that we can read from them without segfault.
  bool blockCanBePredicated(BasicBlock *BB, SmallPtrSetImpl<Value *> &SafePtrs);

  /// \brief Collect memory access with loop invariant strides.
  ///
  /// Looks for accesses like "a[i * StrideA]" where "StrideA" is loop
  /// invariant.
  void collectStridedAccess(Value *LoadOrStoreInst);

  /// Updates the vectorization state by adding \p Phi to the inductions list.
  /// This can set \p Phi as the main induction of the loop if \p Phi is a
  /// better choice for the main induction than the existing one.
  void addInductionPhi(PHINode *Phi, const InductionDescriptor &ID,
                       SmallPtrSetImpl<Value *> &AllowedExit);

  /// Create an analysis remark that explains why vectorization failed
  ///
  /// \p RemarkName is the identifier for the remark.  If \p I is passed it is
  /// an instruction that prevents vectorization.  Otherwise the loop is used
  /// for the location of the remark.  \return the remark object that can be
  /// streamed to.
  OptimizationRemarkAnalysis
  createMissedAnalysis(StringRef RemarkName, Instruction *I = nullptr) const {
    return ::createMissedAnalysis(Hints->vectorizeAnalysisPassName(),
                                  RemarkName, TheLoop, I);
  }

  unsigned NumPredStores;

  /// The loop that we evaluate.
  Loop *TheLoop;
  /// A wrapper around ScalarEvolution used to add runtime SCEV checks.
  /// Applies dynamic knowledge to simplify SCEV expressions in the context
  /// of existing SCEV assumptions. The analysis will also add a minimal set
  /// of new predicates if this is required to enable vectorization and
  /// unrolling.
  PredicatedScalarEvolution &PSE;
  /// Target Library Info.
  TargetLibraryInfo *TLI;
  /// Parent function
  Function *TheFunction;
  /// Target Transform Info
  const TargetTransformInfo *TTI;
  /// Dominator Tree.
  DominatorTree *DT;
  // LoopAccess analysis.
  std::function<const LoopAccessInfo &(Loop &)> *GetLAA;
  // And the loop-accesses info corresponding to this loop.  This pointer is
  // null until canVectorizeMemory sets it up.
  const LoopAccessInfo *LAI;
  /// Interface to emit optimization remarks.
  OptimizationRemarkEmitter *ORE;

  /// The interleave access information contains groups of interleaved accesses
  /// with the same stride and close to each other.
  InterleavedAccessInfo InterleaveInfo;

  //  ---  vectorization state --- //

  /// Holds the primary induction variable. This is the counter of the
  /// loop.
  PHINode *PrimaryInduction;
  /// Holds the reduction variables.
  ReductionList Reductions;
  /// Holds all of the induction variables that we found in the loop.
  /// Notice that inductions don't need to start at zero and that induction
  /// variables can be pointers.
  InductionList Inductions;
  /// Holds the phi nodes that are first-order recurrences.
  RecurrenceSet FirstOrderRecurrences;
  /// Holds instructions that need to sink past other instructions to handle
  /// first-order recurrences.
  DenseMap<Instruction *, Instruction *> SinkAfter;
  /// Holds the widest induction type encountered.
  Type *WidestIndTy;

  /// Allowed outside users. This holds the reduction
  /// vars which can be accessed from outside the loop.
  SmallPtrSet<Value *, 4> AllowedExit;
  /// This set holds the variables which are known to be uniform after
  /// vectorization.
  SmallPtrSet<Instruction *, 4> Uniforms;

  /// Can we assume the absence of NaNs.
  bool HasFunNoNaNAttr;

  /// Vectorization requirements that will go through late-evaluation.
  LoopVectorizationRequirements *Requirements;

  /// Used to emit an analysis of any legality issues.
  LoopVectorizeHints *Hints;

  ValueToValueMap Strides;
  SmallPtrSet<Value *, 8> StrideSet;

  /// While vectorizing these instructions we have to generate a
  /// call to the appropriate masked intrinsic
  SmallPtrSet<const Instruction *, 8> MaskedOp;

  /// If enabled, we will vectorize (some) loops which do not have
  /// a defined trip count that SCEV can determine.
  bool AllowUncounted;
};

/// LoopVectorizationCostModel - estimates the expected speedups due to
/// vectorization.
/// In many cases vectorization is not profitable. This can happen because of
/// a number of reasons. In this class we mainly attempt to predict the
/// expected speedup/slowdowns due to the supported instruction set. We use the
/// TargetTransformInfo to query the different backends for the cost of
/// different operations.
class LoopVectorizationCostModel {
public:
  LoopVectorizationCostModel(Loop *L, PredicatedScalarEvolution &PSE,
                             LoopInfo *LI, LoopVectorizationLegality *Legal,
                             const TargetTransformInfo &TTI,
                             const TargetLibraryInfo *TLI, DemandedBits *DB,
                             AssumptionCache *AC,
                             OptimizationRemarkEmitter *ORE, const Function *F,
                             const LoopVectorizeHints *Hints)
      : TheLoop(L), PSE(PSE), LI(LI), Legal(Legal), TTI(TTI), TLI(TLI), DB(DB),
        AC(AC), ORE(ORE), TheFunction(F), Hints(Hints) {}

  /// \return The most profitable vectorization factor and the cost of that VF.
  /// This method checks every power of two up to VF. If UserVF is not ZERO
  /// then this vectorization factor will be selected if vectorization is
  /// possible.
  VectorizationFactor selectVectorizationFactor(bool OptForSize);

  /// \return The size (in bits) of the smallest and widest types in the code
  /// that needs to be vectorized. We ignore values that remain scalar such as
  /// 64 bit loop indices.
  std::pair<unsigned, unsigned> getSmallestAndWidestTypes();

  /// \return The desired interleave count.
  /// If interleave count has been specified by metadata it will be returned.
  /// Otherwise, the interleave count is computed and returned. VF and LoopCost
  /// are the selected vectorization factor and the cost of the selected VF.
  unsigned selectInterleaveCount(bool OptForSize, VectorizationFactor VF,
                                 unsigned LoopCost);

  /// \return The most profitable unroll factor.
  /// This method finds the best unroll-factor based on register pressure and
  /// other parameters. VF and LoopCost are the selected vectorization factor
  /// and the cost of the selected VF.
  unsigned computeInterleaveCount(bool OptForSize, VectorizationFactor VF,
                                  unsigned LoopCost);

  /// \brief A struct that represents some properties of the register usage
  /// of a loop.
  struct RegisterUsage {
    /// Holds the number of loop invariant values that are used in the loop.
    unsigned LoopInvariantRegs;
    /// Holds the maximum number of concurrent live intervals in the loop.
    unsigned MaxLocalUsers;
    /// Holds the number of instructions in the loop.
    unsigned NumInstructions;
  };

  /// \return Returns information about the register usages of the loop for the
  /// given vectorization factors.
  SmallVector<RegisterUsage, 8> calculateRegisterUsage(ArrayRef<unsigned> VFs);

  /// Collect values we want to ignore in the cost model.
  void collectValuesToIgnore();

private:
  /// The vectorization cost is a combination of the cost itself and a boolean
  /// indicating whether any of the contributing operations will actually
  /// operate on vector values after type legalization in the backend. If this
  /// latter value is false, then all operations will be scalarized
  /// (i.e. no vectorization has actually taken place).
  typedef std::pair<unsigned, bool> VectorizationCostTy;

  /// Returns the expected execution cost. The unit of the cost does
  /// not matter because we use the 'cost' units to compare different
  /// vector widths. The cost that is returned is *not* normalized by
  /// the factor width.
  VectorizationCostTy expectedCost(VectorizationFactor VF);

  /// Returns the execution time cost of an instruction for a given vector
  /// width. Vector width of one means scalar.
  VectorizationCostTy getInstructionCost(Instruction *I,
                                         VectorizationFactor VF);

  /// The cost-computation logic from getInstructionCost which provides
  /// the vector type as an output parameter.
  unsigned getInstructionCost(Instruction *I, VectorizationFactor VF,
                              Type *&VectorTy);

  /// Returns whether the instruction is a load or store and will be a emitted
  /// as a vector operation.
  bool isConsecutiveLoadOrStore(Instruction *I);

  /// Create an analysis remark that explains why vectorization failed
  ///
  /// \p RemarkName is the identifier for the remark.  \return the remark object
  /// that can be streamed to.
  OptimizationRemarkAnalysis createMissedAnalysis(StringRef RemarkName) {
    return ::createMissedAnalysis(Hints->vectorizeAnalysisPassName(),
                                  RemarkName, TheLoop);
  }

public:
  /// Map of scalar integer values to the smallest bitwidth they can be legally
  /// represented as. The vector equivalents of these values should be truncated
  /// to this type.
  MapVector<Instruction *, uint64_t> MinBWs;

  /// The loop that we evaluate.
  Loop *TheLoop;
  /// Predicated scalar evolution analysis.
  PredicatedScalarEvolution &PSE;
  /// Loop Info analysis.
  LoopInfo *LI;
  /// Vectorization legality.
  LoopVectorizationLegality *Legal;
  /// Vector target information.
  const TargetTransformInfo &TTI;
  /// Target Library Info.
  const TargetLibraryInfo *TLI;
  /// Demanded bits analysis.
  DemandedBits *DB;
  /// Assumption cache.
  AssumptionCache *AC;
  /// Interface to emit optimization remarks.
  OptimizationRemarkEmitter *ORE;

  const Function *TheFunction;
  /// Loop Vectorize Hint.
  const LoopVectorizeHints *Hints;
  /// Values to ignore in the cost model.
  SmallPtrSet<const Value *, 16> ValuesToIgnore;
  /// Values to ignore in the cost model when VF > 1.
  SmallPtrSet<const Value *, 16> VecValuesToIgnore;
};

/// \brief This holds vectorization requirements that must be verified late in
/// the process. The requirements are set by legalize and costmodel. Once
/// vectorization has been determined to be possible and profitable the
/// requirements can be verified by looking for metadata or compiler options.
/// For example, some loops require FP commutativity which is only allowed if
/// vectorization is explicitly specified or if the fast-math compiler option
/// has been provided.
/// Late evaluation of these requirements allows helpful diagnostics to be
/// composed that tells the user what need to be done to vectorize the loop. For
/// example, by specifying #pragma clang loop vectorize or -ffast-math. Late
/// evaluation should be used only when diagnostics can generated that can be
/// followed by a non-expert user.
class LoopVectorizationRequirements {
public:
  LoopVectorizationRequirements(OptimizationRemarkEmitter &ORE)
      : NumRuntimePointerChecks(0), UnsafeAlgebraInst(nullptr), ORE(ORE) {}

  void addUnsafeAlgebraInst(Instruction *I) {
    // First unsafe algebra instruction.
    if (!UnsafeAlgebraInst)
      UnsafeAlgebraInst = I;
  }

  void addRuntimePointerChecks(unsigned Num) { NumRuntimePointerChecks = Num; }

  bool doesNotMeet(Function *F, Loop *L, const LoopVectorizeHints &Hints,
                   const LoopVectorizationLegality &LVL) {
    const char *PassName = Hints.vectorizeAnalysisPassName();
    bool Failed = false;
    if (UnsafeAlgebraInst && !Hints.allowReordering()) {
      if (LVL.allReductionsAreStrict()) {
        DEBUG(dbgs() << "LV: Vectorization possible with ordered reduction\n");
      } else {
        ORE.emit(
            OptimizationRemarkAnalysisFPCommute(PassName, "CantReorderFPOps",
                                                UnsafeAlgebraInst->getDebugLoc(),
                                                UnsafeAlgebraInst->getParent())
            << "loop not vectorized: cannot prove it is safe to reorder "
               "floating-point operations");
        Failed = true;
      }
    }

    // Test if runtime memcheck thresholds are exceeded.
    bool PragmaThresholdReached =
        NumRuntimePointerChecks > PragmaVectorizeMemoryCheckThreshold;
    bool ThresholdReached =
        NumRuntimePointerChecks > VectorizerParams::RuntimeMemoryCheckThreshold;
    if ((ThresholdReached && !Hints.allowReordering()) ||
        PragmaThresholdReached) {
      ORE.emit(OptimizationRemarkAnalysisAliasing(PassName, "CantReorderMemOps",
                                                  L->getStartLoc(),
                                                  L->getHeader())
               << "loop not vectorized: cannot prove it is safe to reorder "
                  "memory operations");
      DEBUG(dbgs() << "LV: Too many memory checks needed.\n");
      Failed = true;
    }

    return Failed;
  }

private:
  unsigned NumRuntimePointerChecks;
  Instruction *UnsafeAlgebraInst;

  /// Interface to emit optimization remarks.
  OptimizationRemarkEmitter &ORE;
};

static void addAcyclicInnerLoop(Loop &L, SmallVectorImpl<Loop *> &V) {
  if (L.empty()) {
    if (!hasCyclesInLoopBody(L))
      V.push_back(&L);
    return;
  }
  for (Loop *InnerL : L)
    addAcyclicInnerLoop(*InnerL, V);
}

/// The SVELoopVectorize Pass.
struct SVELoopVectorize : public FunctionPass {
  /// Pass identification, replacement for typeid
  static char ID;

  explicit SVELoopVectorize(bool NoUnrolling = false, bool AlwaysVectorize = true)
      : FunctionPass(ID), DisableUnrolling(NoUnrolling),
        AlwaysVectorize(AlwaysVectorize) {
    initializeSVELoopVectorizePass(*PassRegistry::getPassRegistry());
  }

  ScalarEvolution *SE;
  LoopInfo *LI;
  TargetTransformInfo *TTI;
  DominatorTree *DT;
  BlockFrequencyInfo *BFI;
  TargetLibraryInfo *TLI;
  DemandedBits *DB;
  AliasAnalysis *AA;
  AssumptionCache *AC;
  LoopAccessLegacyAnalysis *LAA;
  bool DisableUnrolling;
  bool AlwaysVectorize;
  OptimizationRemarkEmitter *ORE;

  BlockFrequency ColdEntryFreq;

  bool runOnFunction(Function &F) override {
    if (skipFunction(F))
      return false;

    SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();
    LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
    TTI = &getAnalysis<TargetTransformInfoWrapperPass>().getTTI(F);
    DT = &getAnalysis<DominatorTreeWrapperPass>().getDomTree();
    BFI = &getAnalysis<BlockFrequencyInfoWrapperPass>().getBFI();
    auto *TLIP = getAnalysisIfAvailable<TargetLibraryInfoWrapperPass>();
    TLI = TLIP ? &TLIP->getTLI() : nullptr;
    AA = &getAnalysis<AAResultsWrapperPass>().getAAResults();
    AC = &getAnalysis<AssumptionCacheTracker>().getAssumptionCache(F);
    LAA = &getAnalysis<LoopAccessLegacyAnalysis>();
    DB = &getAnalysis<DemandedBitsWrapperPass>().getDemandedBits();
    ORE = &getAnalysis<OptimizationRemarkEmitterWrapperPass>().getORE();

    // Compute some weights outside of the loop over the loops. Compute this
    // using a BranchProbability to re-use its scaling math.
    const BranchProbability ColdProb(1, 5); // 20%
    ColdEntryFreq = BlockFrequency(BFI->getEntryFreq()) * ColdProb;

    // Don't attempt if
    // 1. the target claims to have no vector registers, and
    // 2. interleaving won't help ILP.
    //
    // The second condition is necessary because, even if the target has no
    // vector registers, loop vectorization may still enable scalar
    // interleaving.
    if (!TTI->getNumberOfRegisters(true) && TTI->getMaxInterleaveFactor(1) < 2)
      return false;

    bool Changed = false;

    // The vectorizer requires loops to be in simplified form.
    // Since simplification may add new inner loops, it has to run before the
    // legality and profitability checks. This means running the loop vectorizer
    // will simplify all loops, regardless of whether anything end up being
    // vectorized.
    for (auto &L : *LI)
      Changed |= simplifyLoop(L, DT, LI, SE, AC, false /* PreserveLCSSA */);

    // Build up a worklist of inner-loops to vectorize. This is necessary as
    // the act of vectorizing or partially unrolling a loop creates new loops
    // and can invalidate iterators across the loops.
    SmallVector<Loop *, 8> Worklist;

    for (Loop *L : *LI)
      addAcyclicInnerLoop(*L, Worklist);

    LoopsAnalyzed += Worklist.size();

    // Now walk the identified inner loops.
    while (!Worklist.empty()) {
      Loop *L = Worklist.pop_back_val();

      // For the inner loops we actually process, form LCSSA to simplify the
      // transform.
      Changed |= formLCSSARecursively(*L, *DT, LI, SE);

      Changed |= processLoop(L);
    }

    // Process each loop nest in the function.
    return Changed;
  }

  static void AddRuntimeUnrollDisableMetaData(Loop *L) {
    SmallVector<Metadata *, 4> MDs;
    // Reserve first location for self reference to the LoopID metadata node.
    MDs.push_back(nullptr);
    bool IsUnrollMetadata = false;
    MDNode *LoopID = L->getLoopID();
    if (LoopID) {
      // First find existing loop unrolling disable metadata.
      for (unsigned i = 1, ie = LoopID->getNumOperands(); i < ie; ++i) {
        MDNode *MD = dyn_cast<MDNode>(LoopID->getOperand(i));
        if (MD) {
          const MDString *S = dyn_cast<MDString>(MD->getOperand(0));
          IsUnrollMetadata =
              S && S->getString().startswith("llvm.loop.unroll.disable");
        }
        MDs.push_back(LoopID->getOperand(i));
      }
    }

    if (!IsUnrollMetadata) {
      // Add runtime unroll disable metadata.
      LLVMContext &Context = L->getHeader()->getContext();
      SmallVector<Metadata *, 1> DisableOperands;
      DisableOperands.push_back(
          MDString::get(Context, "llvm.loop.unroll.runtime.disable"));
      MDNode *DisableNode = MDNode::get(Context, DisableOperands);
      MDs.push_back(DisableNode);
      MDNode *NewLoopID = MDNode::get(Context, MDs);
      // Set operand 0 to refer to the loop id itself.
      NewLoopID->replaceOperandWith(0, NewLoopID);
      L->setLoopID(NewLoopID);
    }
  }

  bool processLoop(Loop *L) {
    assert(L->empty() && "Only process inner loops.");

#ifndef NDEBUG
    const std::string DebugLocStr = getDebugLocString(L);
#endif /* NDEBUG */

    DEBUG(dbgs() << "\nLV: Checking a loop in \""
                 << L->getHeader()->getParent()->getName() << "\" from "
                 << DebugLocStr << "\n");

    LoopVectorizeHints Hints(L, DisableUnrolling, *ORE);

    DEBUG(dbgs() << "LV: Loop hints:"
                 << " force="
                 << (Hints.getForce() == LoopVectorizeHints::FK_Disabled
                         ? "disabled"
                         : (Hints.getForce() == LoopVectorizeHints::FK_Enabled
                                ? "enabled"
                                : "?"))
                 << " width=" << Hints.getWidth()
                 << " style="
                 << (Hints.getStyle() == LoopVectorizeHints::SK_Fixed
                         ? "fixed"
                         : (Hints.getStyle() == LoopVectorizeHints::SK_Scaled
                                ? "scaled"
                                : "default"))
                 << " unroll=" << Hints.getInterleave() << "\n");

    // Function containing loop
    Function *F = L->getHeader()->getParent();

    // Looking at the diagnostic output is the only way to determine if a loop
    // was vectorized (other than looking at the IR or machine code), so it
    // is important to generate an optimization remark for each loop. Most of
    // these messages are generated by emitOptimizationRemarkAnalysis. Remarks
    // generated by emitOptimizationRemark and emitOptimizationRemarkMissed are
    // less verbose reporting vectorized loops and unvectorized loops that may
    // benefit from vectorization, respectively.

    if (!Hints.allowVectorization(F, L, AlwaysVectorize)) {
      DEBUG(dbgs() << "LV: Loop hints prevent vectorization.\n");
      return false;
    }

    // Check the loop for a trip count threshold:
    // do not vectorize loops with a tiny trip count.
    const unsigned TC = SE->getSmallConstantTripCount(L);
    if (TC > 0u && TC < TinyTripCountVectorThreshold) {
      DEBUG(dbgs() << "LV: Found a loop with a very small trip count. "
                   << "This loop is not worth vectorizing.");
      if (Hints.getForce() == LoopVectorizeHints::FK_Enabled)
        DEBUG(dbgs() << " But vectorizing was explicitly forced.\n");
      else {
        DEBUG(dbgs() << "\n");
        ORE->emit(createMissedAnalysis(Hints.vectorizeAnalysisPassName(),
                                       "NotBeneficial", L)
                  << "vectorization is not beneficial "
                     "and is not explicitly forced");
        ORE->emit(createMissedAnalysis(Hints.vectorizeAnalysisPassName(),
                                       "NotBeneficial", L)
                  << "to locally force vectorization, prefix loop with "
                     "\"#pragma clang loop vectorize (enable)\"");
        ORE->emit(createMissedAnalysis(Hints.vectorizeAnalysisPassName(),
                                       "NotBeneficial", L)
                  << "to globally force vectorization, compile with "
                     "\"-mllvm -vectorizer-min-trip-count "
                  << std::to_string(TC) << "\"");
        return false;
      }
    }

    PredicatedScalarEvolution PSE(*SE, *L);

    std::function<const LoopAccessInfo &(Loop &)> GetLAA =
    [&](Loop &L) -> const LoopAccessInfo & { return LAA->getInfo(&L); };

    // Check if it is legal to vectorize the loop.
    LoopVectorizationRequirements Requirements(*ORE);
    LoopVectorizationLegality LVL(L, PSE, DT, TLI, AA, F, TTI, &GetLAA, LI, ORE,
                                  &Requirements, &Hints);
    if (!LVL.canVectorize()) {
      DEBUG(dbgs() << "LV: Not vectorizing: Cannot prove legality.\n");
      emitMissedWarning(F, L, Hints, ORE);
      return false;
    }

    // Use the cost model.
    LoopVectorizationCostModel CM(L, PSE, LI, &LVL, *TTI, TLI, DB, AC, ORE, F,
                                  &Hints);
    CM.collectValuesToIgnore();

    // Check the function attributes to find out if this function should be
    // optimized for size.
    bool OptForSize =
        Hints.getForce() != LoopVectorizeHints::FK_Enabled && F->optForSize();

    // Compute the weighted frequency of this loop being executed and see if it
    // is less than 20% of the function entry baseline frequency. Note that we
    // always have a canonical loop here because we think we *can* vectorize.
    // FIXME: This is hidden behind a flag due to pervasive problems with
    // exactly what block frequency models.
    if (LoopVectorizeWithBlockFrequency) {
      BlockFrequency LoopEntryFreq = BFI->getBlockFreq(L->getLoopPreheader());
      if (Hints.getForce() != LoopVectorizeHints::FK_Enabled &&
          LoopEntryFreq < ColdEntryFreq)
        OptForSize = true;
    }

    // Check the function attributes to see if implicit floats are allowed.
    // FIXME: This check doesn't seem possibly correct -- what if the loop is
    // an integer loop and the vector instructions selected are purely integer
    // vector instructions?
    if (F->hasFnAttribute(Attribute::NoImplicitFloat)) {
      DEBUG(dbgs() << "LV: Can't vectorize when the NoImplicitFloat"
                      "attribute is used.\n");
      ORE->emit(createMissedAnalysis(Hints.vectorizeAnalysisPassName(),
                                     "NoImplicitFloat", L)
                << "loop not vectorized due to NoImplicitFloat attribute");
      emitMissedWarning(F, L, Hints, ORE);
      return false;
    }

    // Check if the target supports potentially unsafe FP vectorization.
    // FIXME: Add a check for the type of safety issue (denormal, signaling)
    // for the target we're vectorizing for, to make sure none of the
    // additional fp-math flags can help.
    if (Hints.isPotentiallyUnsafe() &&
        TTI->isFPVectorizationPotentiallyUnsafe()) {
      DEBUG(dbgs() << "LV: Potentially unsafe FP op prevents vectorization.\n");
      ORE->emit(
          createMissedAnalysis(Hints.vectorizeAnalysisPassName(), "UnsafeFP", L)
          << "loop not vectorized due to unsafe FP support.");
      emitMissedWarning(F, L, Hints, ORE);
      return false;
    }

    // Select the optimal vectorization factor.
    const VectorizationFactor VF = CM.selectVectorizationFactor(OptForSize);

    // Select the interleave count.
    unsigned IC = CM.selectInterleaveCount(OptForSize, VF, VF.Cost);

    // Get user interleave count.
    unsigned UserIC = Hints.getInterleave();

    // Identify the diagnostic messages that should be produced.
    std::pair<StringRef, std::string> VecDiagMsg, IntDiagMsg;
    bool VectorizeLoop = true, InterleaveLoop = true;
    if (Requirements.doesNotMeet(F, L, Hints, LVL)) {
      DEBUG(dbgs() << "LV: Not vectorizing: loop did not meet vectorization "
                      "requirements.\n");
      emitMissedWarning(F, L, Hints, ORE);
      return false;
    }

    if (VF.Width == 1) {
      DEBUG(dbgs() << "LV: Vectorization is possible but not beneficial.\n");
      VecDiagMsg = std::make_pair(
          "VectorizationNotBeneficial",
          "the cost-model indicates that vectorization is not beneficial");
      VectorizeLoop = false;
    }

    if (IC == 1 && UserIC <= 1) {
      // Tell the user interleaving is not beneficial.
      DEBUG(dbgs() << "LV: Interleaving is not beneficial.\n");
      IntDiagMsg = std::make_pair(
          "InterleavingNotBeneficial",
          "the cost-model indicates that interleaving is not beneficial");
      InterleaveLoop = false;
      if (UserIC == 1) {
        IntDiagMsg.first = "InterleavingNotBeneficialAndDisabled";
        IntDiagMsg.second +=
            " and is explicitly disabled or interleave count is set to 1";
      }
    } else if (IC > 1 && UserIC == 1) {
      // Tell the user interleaving is beneficial, but it explicitly disabled.
      DEBUG(dbgs()
            << "LV: Interleaving is beneficial but is explicitly disabled.");
      IntDiagMsg = std::make_pair(
          "InterleavingBeneficialButDisabled",
          "the cost-model indicates that interleaving is beneficial "
          "but is explicitly disabled or interleave count is set to 1");
      InterleaveLoop = false;
    }

    if (!VectorizeLoop && InterleaveLoop && LVL.hasMaskedOperations()) {
      DEBUG(dbgs()
            << "LV: Interleaving is beneficial but loop contain masked access");
      IntDiagMsg = std::make_pair(
          "InterleavingBeneficialButContainsMaskedAccess",
          "interleaving not possible because of masked accesses");
      InterleaveLoop = false;
    }

    // Override IC if user provided an interleave count.
    IC = UserIC > 0 ? UserIC : IC;

    // Emit diagnostic messages, if any.
    const char *VAPassName = Hints.vectorizeAnalysisPassName();
    if (!VectorizeLoop && !InterleaveLoop) {
      // Do not vectorize or interleaving the loop.
      ORE->emit(OptimizationRemarkMissed(VAPassName, VecDiagMsg.first,
                                         {L->getLocRange().getStart(),
                                          L->getLocRange().getEnd()},
                                         L->getHeader())
                << VecDiagMsg.second);
      ORE->emit(OptimizationRemarkMissed(LV_NAME, IntDiagMsg.first,
                                         {L->getLocRange().getStart(),
                                          L->getLocRange().getEnd()},
                                         L->getHeader())
              << IntDiagMsg.second);
      return false;
    } else if (!VectorizeLoop && InterleaveLoop) {
      DEBUG(dbgs() << "LV: Interleave Count is " << IC << '\n');
      ORE->emit(OptimizationRemarkAnalysis(VAPassName, VecDiagMsg.first,
                                          {L->getLocRange().getStart(),
                                           L->getLocRange().getEnd()},
                                          L->getHeader())
                << VecDiagMsg.second);
    } else if (VectorizeLoop && !InterleaveLoop) {
      DEBUG(dbgs() << "LV: Found a vectorizable loop (" << VF.Width << ") in "
                   << DebugLocStr << '\n');
      ORE->emit(OptimizationRemarkAnalysis(LV_NAME, IntDiagMsg.first,
                                           {L->getLocRange().getStart(),
                                            L->getLocRange().getEnd()},
                                           L->getHeader())
                << IntDiagMsg.second);
    } else if (VectorizeLoop && InterleaveLoop) {
      DEBUG(dbgs() << "LV: Found a vectorizable loop (" << VF.Width << ") in "
                   << DebugLocStr << '\n');
      DEBUG(dbgs() << "LV: Interleave Count is " << IC << '\n');
    }

    using namespace ore;
    if (!VectorizeLoop) {
      assert(IC > 1 && "interleave count should not be 1 or 0");
      // If we decided that it is not legal to vectorize the loop, then
      // interleave it.
      InnerLoopUnroller Unroller(L, PSE, LI, DT, TLI, TTI, AC, ORE, IC);
      Unroller.vectorize(&LVL, CM.MinBWs);

      emitOptimizationRemark(F->getContext(), LV_NAME, *F, L->getStartLoc(),
                             Twine("interleaved loop (interleaved count: ") +
                                 Twine(IC) + ")");
    } else {
      // If we decided that it is *legal* to vectorize the loop then do it.
      InnerLoopVectorizer LB(L, PSE, LI, DT, TLI, TTI, AC, ORE, VF.Width, IC,
                             VF.isFixed);
      LB.vectorize(&LVL, CM.MinBWs);
      ++LoopsVectorized;
      if (LB.isScalable())
        ++LoopsVectorizedWA;

      // Add metadata to disable runtime unrolling a scalar loop when there are
      // no runtime checks about strides and memory. A scalar loop that is
      // rarely used is not worth unrolling.
      if (!LB.areSafetyChecksAdded())
        AddRuntimeUnrollDisableMetaData(L);

      // Report the vectorization decision.
      OptimizationRemark R(LV_NAME, "Vectorized",
                           {L->getLocRange().getStart(),
                            L->getLocRange().getEnd()},
                           L->getHeader());
      R << "vectorized loop (vectorization width: "
        << NV("VectorizationFactor", VF.Width)
        << ", interleaved count: " << NV("InterleaveCount", IC) << ")"
        << setExtraArgs()
        << "(runtime checks: "
        << NV("RTNeeded",
            std::string(LVL.getRuntimePointerChecking()->Need ? "" : "no"))
        << ", FixedWidthVectorization: "
        << NV("FixedWidthVectorization", std::string("scaled"))
        << ")";
      ORE->emit(R);
    }

    // Mark the loop as already vectorized to avoid vectorizing again.
    Hints.setAlreadyVectorized();

    DEBUG(verifyFunction(*L->getHeader()->getParent()));
    return true;
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<AssumptionCacheTracker>();
    AU.addRequired<BlockFrequencyInfoWrapperPass>();
    AU.addRequired<DominatorTreeWrapperPass>();
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addRequired<TargetTransformInfoWrapperPass>();
    AU.addRequired<AAResultsWrapperPass>();
    AU.addRequired<LoopAccessLegacyAnalysis>();
    AU.addRequired<DemandedBitsWrapperPass>();
    AU.addRequired<OptimizationRemarkEmitterWrapperPass>();
    AU.addPreserved<LoopInfoWrapperPass>();
    AU.addPreserved<DominatorTreeWrapperPass>();
    AU.addPreserved<BasicAAWrapperPass>();
    AU.addPreserved<GlobalsAAWrapperPass>();
  }
};

} // end anonymous namespace

//===----------------------------------------------------------------------===//
// Implementation of LoopVectorizationLegality, InnerLoopVectorizer and
// LoopVectorizationCostModel.
//===----------------------------------------------------------------------===//

Value *InnerLoopVectorizer::getBroadcastInstrs(Value *V) {
  // We need to place the broadcast of invariant variables outside the loop.
  Instruction *Instr = dyn_cast<Instruction>(V);
  bool NewInstr =
      (Instr && std::find(LoopVectorBody.begin(), LoopVectorBody.end(),
                          Instr->getParent()) != LoopVectorBody.end());
  bool Invariant = OrigLoop->isLoopInvariant(V) && !NewInstr;

  // Place the code for broadcasting invariant variables in the new preheader.
  IRBuilder<>::InsertPointGuard Guard(Builder);
  if (Invariant)
    Builder.SetInsertPoint(LoopVectorPreHeader->getTerminator());

  // Broadcast the scalar into all locations in the vector.
  Value *Shuf = Builder.CreateVectorSplat({VF, Scalable}, V, "broadcast");

  return Shuf;
}

Value *InnerLoopVectorizer::getStepVector(Value *Val, Value *Start,
                                          const SCEV *StepSCEV,
                                          Instruction::BinaryOps BinOp) {
  const DataLayout &DL = OrigLoop->getHeader()->getModule()->getDataLayout();
  SCEVExpander Exp(*PSE.getSE(), DL, "induction");
  Value *StepValue = Exp.expandCodeFor(StepSCEV, StepSCEV->getType(),
                                       &*Builder.GetInsertPoint());
  return getStepVector(Val, Start, StepValue, BinOp);
}

void InnerLoopVectorizer::widenInductionVariable(const InductionDescriptor &II,
                                                 VectorParts &Entry,
                                                 IntegerType *TruncType) {
  Value *Start = II.getStartValue();
  ConstantInt *Step = II.getConstIntStepValue();
  assert(Step && "Can not widen an IV with a non-constant step");

  // Construct the initial value of the vector IV in the vector loop preheader
  auto CurrIP = Builder.saveIP();
  Builder.SetInsertPoint(LoopVectorPreHeader->getTerminator());
  if (TruncType) {
    Step = ConstantInt::getSigned(TruncType, Step->getSExtValue());
    Start = Builder.CreateCast(Instruction::Trunc, Start, TruncType);
  }
  Value *SplatStart = Builder.CreateVectorSplat({VF, Scalable}, Start);
  Value *SteppedStart = getStepVector(SplatStart, 0, Step);
  Builder.restoreIP(CurrIP);

  Value *NumEls =
      getElementCount(Start->getType(), VF, Scalable, Start->getType());
  Value *SplatVF = Builder.CreateVectorSplat({VF, Scalable}, NumEls);
  PHINode *VecInd =
      PHINode::Create(SteppedStart->getType(), 2, "vec.ind",
                      &*LoopVectorBody[0]->getFirstInsertionPt());
  Value *LastInduction = VecInd;
  for (unsigned Part = 0; Part < UF; ++Part) {
    Entry[Part] = LastInduction;
    LastInduction = Builder.CreateAdd(LastInduction, SplatVF, "step.add");
  }

  auto Latch = LI->getLoopFor(LoopVectorBody[0])->getLoopLatch();
  VecInd->addIncoming(SteppedStart, LoopVectorPreHeader);
  VecInd->addIncoming(LastInduction, Latch);
}

Value *InnerLoopVectorizer::getStepVector(Value *Val, int Start, Value *Step,
                                          Instruction::BinaryOps BinOp) {
  Type *Ty = Val->getType()->getScalarType();
  return getStepVector(Val, ConstantInt::get(Ty, Start), Step, BinOp);
}

Value *InnerLoopVectorizer::getStepVector(Value *Val, Value *Start, Value *Step,
                                          Instruction::BinaryOps BinOp) {
  assert(Val->getType()->isVectorTy() && "Must be a vector");
  assert(Step->getType() == Val->getType()->getScalarType() &&
         "Step has wrong type");

  VectorType *Ty = cast<VectorType>(Val->getType());
  Value *One = ConstantInt::get(Start->getType(), 1);

  // Create a vector of consecutive numbers from Start to Start+VF
  Value *Cv = Builder.CreateSeriesVector(Ty->getElementCount(), Start, One);

  Step = Builder.CreateVectorSplat(Ty->getElementCount(), Step);
  if (Val->getType()->getScalarType()->isIntegerTy()) {
    // Add the consecutive indices to the vector value.
    assert(Cv->getType() == Val->getType() && "Invalid consecutive vec");
    // FIXME: The newly created binary instructions should contain nsw/nuw
    // flags, which can be found from the original scalar operations.
    Step = Builder.CreateMul(Cv, Step);
    return Builder.CreateAdd(Val, Step, "induction");
  } else {
    // Floating point induction.
    assert(Val->getType()->getScalarType()->isFloatingPointTy() &&
           "Elem must be an fp type");
    assert((BinOp == Instruction::FAdd || BinOp == Instruction::FSub) &&
           "Binary Opcode should be specified for FP induction");
    // Cv is an integer vector, need to convert to fp.

    // Floating point operations had to be 'fast' to enable the induction.
    FastMathFlags Flags;
    Flags.setUnsafeAlgebra();

    Cv = Builder.CreateUIToFP(Cv, Ty);
    Step = Builder.CreateFMul(Cv, Step);

    if (isa<Instruction>(Step))
      // Have to check, Step may be a constant
      cast<Instruction>(Step)->setFastMathFlags(Flags);

    Value *BOp = Builder.CreateBinOp(BinOp, Val, Step, "induction");
    if (isa<Instruction>(BOp))
      cast<Instruction>(BOp)->setFastMathFlags(Flags);
    return BOp;
  }
}

Value *InnerLoopVectorizer::getElementCount(Type* ElemTy, unsigned NumElts,
                                            bool Scalable, Type* RetTy) {
  if (!RetTy)
    RetTy = Builder.getInt32Ty();

  Value *V = UndefValue::get(VectorType::get(ElemTy, NumElts, Scalable));
  return Builder.CreateElementCount(RetTy, V);
}

int LoopVectorizationLegality::isConsecutivePtr(Value *Ptr) {
  assert(Ptr->getType()->isPointerTy() && "Unexpected non-ptr");
  auto *SE = PSE.getSE();
  // Make sure that the pointer does not point to structs.
  if (Ptr->getType()->getPointerElementType()->isAggregateType())
    return 0;

  // If this value is a pointer induction variable, we know it is consecutive.
  PHINode *Phi = dyn_cast_or_null<PHINode>(Ptr);
  if (Phi && Inductions.count(Phi)) {
    InductionDescriptor II = Inductions[Phi];
    return II.getConsecutiveDirection();
  }

  GetElementPtrInst *Gep = getGEPInstruction(Ptr);
  if (!Gep)
    return 0;

  unsigned NumOperands = Gep->getNumOperands();
  Value *GpPtr = Gep->getPointerOperand();
  // If this GEP value is a consecutive pointer induction variable and all of
  // the indices are constant, then we know it is consecutive.
  Phi = dyn_cast<PHINode>(GpPtr);
  if (Phi && Inductions.count(Phi)) {

    // Make sure that the pointer does not point to structs.
    PointerType *GepPtrType = cast<PointerType>(GpPtr->getType());
    if (GepPtrType->getElementType()->isAggregateType())
      return 0;

    // Make sure that all of the index operands are loop invariant.
    for (unsigned i = 1; i < NumOperands; ++i)
      if (!SE->isLoopInvariant(PSE.getSCEV(Gep->getOperand(i)), TheLoop))
        return 0;

    InductionDescriptor II = Inductions[Phi];
    return II.getConsecutiveDirection();
  }

  unsigned InductionOperand = getGEPInductionOperand(Gep);

  // Check that all of the gep indices are uniform except for our induction
  // operand.
  for (unsigned i = 0; i != NumOperands; ++i)
    if (i != InductionOperand &&
        !SE->isLoopInvariant(PSE.getSCEV(Gep->getOperand(i)), TheLoop))
      return 0;

  // We can emit wide load/stores only if the last non-zero index is the
  // induction variable.
  const SCEV *Last = nullptr;
  if (!Strides.count(Gep))
    Last = PSE.getSCEV(Gep->getOperand(InductionOperand));
  else {
    // Because of the multiplication by a stride we can have a s/zext cast.
    // We are going to replace this stride by 1 so the cast is safe to ignore.
    //
    //  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
    //  %0 = trunc i64 %indvars.iv to i32
    //  %mul = mul i32 %0, %Stride1
    //  %idxprom = zext i32 %mul to i64  << Safe cast.
    //  %arrayidx = getelementptr inbounds i32* %B, i64 %idxprom
    //
    Last = replaceSymbolicStrideSCEV(PSE, Strides,
                                     Gep->getOperand(InductionOperand), Gep);
    if (const SCEVCastExpr *C = dyn_cast<SCEVCastExpr>(Last))
      Last =
          (C->getSCEVType() == scSignExtend || C->getSCEVType() == scZeroExtend)
              ? C->getOperand()
              : Last;
  }
  if (const SCEVAddRecExpr *AR = dyn_cast<SCEVAddRecExpr>(Last)) {
    const SCEV *Step = AR->getStepRecurrence(*SE);

    // The memory is consecutive because the last index is consecutive
    // and all other indices are loop invariant.
    if (Step->isOne())
      return 1;
    if (Step->isAllOnesValue())
      return -1;

    // Try and find a different constant stride
    if (EnableNonConsecutiveStrideIndVars) {
      if (const SCEVConstant *SCC = dyn_cast<SCEVConstant>(Step)) {
        const ConstantInt *CI = SCC->getValue();
        // TODO: Error checking vs. INT_MAX?
        return (int)CI->getLimitedValue(INT_MAX);
      }
    }
  }

  return 0;
}

bool LoopVectorizationLegality::isUniform(Value *V) {
  return LAI->isUniform(V);
}

InnerLoopVectorizer::VectorParts &
InnerLoopVectorizer::getVectorValue(Value *V) {
  assert(V != Induction && "The new induction variable should not be used.");
  assert(!V->getType()->isVectorTy() && "Can't widen a vector");

  // If we have a stride that is replaced by one, do it here.
  if (Legal->hasStride(V))
    V = ConstantInt::get(V->getType(), 1);

  // If we have this scalar in the map, return it.
  if (WidenMap.has(V))
    return WidenMap.get(V);

  // If this scalar is unknown, assume that it is a constant or that it is
  // loop invariant. Broadcast V and save the value for future uses.
  Value *B = getBroadcastInstrs(V);
  return WidenMap.splat(V, B);
}

Value *InnerLoopVectorizer::reverseVector(Value *Vec) {
  assert(Vec->getType()->isVectorTy() && "Invalid type");
  VectorType *Ty = cast<VectorType>(Vec->getType());

  // i32 reverse_mask[n] = { n-1, n-2...1, 0 }
  Value *NumEls = getElementCount(Ty->getElementType(), VF, Scalable);
  Value *Start = Builder.CreateSub(NumEls, Builder.getInt32(1));
  Value *Step  = ConstantInt::get(Start->getType(), -1, true);
  Value *Mask  = Builder.CreateSeriesVector({VF,Scalable}, Start, Step);

  return Builder.CreateShuffleVector(Vec, UndefValue::get(Ty), Mask, "reverse");
}

// Get a mask to interleave \p NumVec vectors into a wide vector.
// I.e.  <0, VF, VF*2, ..., VF*(NumVec-1), 1, VF+1, VF*2+1, ...>
// E.g. For 2 interleaved vectors, if VF is 4, the mask is:
//      <0, 4, 1, 5, 2, 6, 3, 7>
static Constant *getInterleavedMask(IRBuilder<> &Builder, unsigned VF,
                                    unsigned NumVec) {
  SmallVector<Constant *, 16> Mask;
  for (unsigned i = 0; i < VF; i++)
    for (unsigned j = 0; j < NumVec; j++)
      Mask.push_back(Builder.getInt32(j * VF + i));

  return ConstantVector::get(Mask);
}

// Get the strided mask starting from index \p Start.
// I.e.  <Start, Start + Stride, ..., Start + Stride*(VF-1)>
static Constant *getStridedMask(IRBuilder<> &Builder, unsigned Start,
                                unsigned Stride, unsigned VF) {
  SmallVector<Constant *, 16> Mask;
  for (unsigned i = 0; i < VF; i++)
    Mask.push_back(Builder.getInt32(Start + i * Stride));

  return ConstantVector::get(Mask);
}

// Get a mask of two parts: The first part consists of sequential integers
// starting from 0, The second part consists of UNDEFs.
// I.e. <0, 1, 2, ..., NumInt - 1, undef, ..., undef>
static Constant *getSequentialMask(IRBuilder<> &Builder, unsigned NumInt,
                                   unsigned NumUndef) {
  SmallVector<Constant *, 16> Mask;
  for (unsigned i = 0; i < NumInt; i++)
    Mask.push_back(Builder.getInt32(i));

  Constant *Undef = UndefValue::get(Builder.getInt32Ty());
  for (unsigned i = 0; i < NumUndef; i++)
    Mask.push_back(Undef);

  return ConstantVector::get(Mask);
}

// Concatenate two vectors with the same element type. The 2nd vector should
// not have more elements than the 1st vector. If the 2nd vector has less
// elements, extend it with UNDEFs.
static Value *ConcatenateTwoVectors(IRBuilder<> &Builder, Value *V1,
                                    Value *V2) {
  VectorType *VecTy1 = dyn_cast<VectorType>(V1->getType());
  VectorType *VecTy2 = dyn_cast<VectorType>(V2->getType());
  assert(VecTy1 && VecTy2 &&
         VecTy1->getScalarType() == VecTy2->getScalarType() &&
         "Expect two vectors with the same element type");

  unsigned NumElts1 = VecTy1->getNumElements();
  unsigned NumElts2 = VecTy2->getNumElements();
  assert(NumElts1 >= NumElts2 && "Unexpect the first vector has less elements");

  if (NumElts1 > NumElts2) {
    // Extend with UNDEFs.
    Constant *ExtMask =
        getSequentialMask(Builder, NumElts2, NumElts1 - NumElts2);
    V2 = Builder.CreateShuffleVector(V2, UndefValue::get(VecTy2), ExtMask);
  }

  Constant *Mask = getSequentialMask(Builder, NumElts1 + NumElts2, 0);
  return Builder.CreateShuffleVector(V1, V2, Mask);
}

// Concatenate vectors in the given list. All vectors have the same type.
static Value *ConcatenateVectors(IRBuilder<> &Builder,
                                 ArrayRef<Value *> InputList) {
  unsigned NumVec = InputList.size();
  assert(NumVec > 1 && "Should be at least two vectors");

  SmallVector<Value *, 8> ResList;
  ResList.append(InputList.begin(), InputList.end());
  do {
    SmallVector<Value *, 8> TmpList;
    for (unsigned i = 0; i < NumVec - 1; i += 2) {
      Value *V0 = ResList[i], *V1 = ResList[i + 1];
      assert((V0->getType() == V1->getType() || i == NumVec - 2) &&
             "Only the last vector may have a different type");

      TmpList.push_back(ConcatenateTwoVectors(Builder, V0, V1));
    }

    // Push the last vector if the total number of vectors is odd.
    if (NumVec % 2 != 0)
      TmpList.push_back(ResList[NumVec - 1]);

    ResList = TmpList;
    NumVec = ResList.size();
  } while (NumVec > 1);

  return ResList[0];
}

// Try to vectorize the interleave group that \p Instr belongs to.
//
// E.g. Translate following interleaved load group (factor = 3):
//   for (i = 0; i < N; i+=3) {
//     R = Pic[i];             // Member of index 0
//     G = Pic[i+1];           // Member of index 1
//     B = Pic[i+2];           // Member of index 2
//     ... // do something to R, G, B
//   }
// To:
//   %wide.vec = load <12 x i32>                       ; Read 4 tuples of R,G,B
//   %R.vec = shuffle %wide.vec, undef, <0, 3, 6, 9>   ; R elements
//   %G.vec = shuffle %wide.vec, undef, <1, 4, 7, 10>  ; G elements
//   %B.vec = shuffle %wide.vec, undef, <2, 5, 8, 11>  ; B elements
//
// Or translate following interleaved store group (factor = 3):
//   for (i = 0; i < N; i+=3) {
//     ... do something to R, G, B
//     Pic[i]   = R;           // Member of index 0
//     Pic[i+1] = G;           // Member of index 1
//     Pic[i+2] = B;           // Member of index 2
//   }
// To:
//   %R_G.vec = shuffle %R.vec, %G.vec, <0, 1, 2, ..., 7>
//   %B_U.vec = shuffle %B.vec, undef, <0, 1, 2, 3, u, u, u, u>
//   %interleaved.vec = shuffle %R_G.vec, %B_U.vec,
//        <0, 4, 8, 1, 5, 9, 2, 6, 10, 3, 7, 11>    ; Interleave R,G,B elements
//   store <12 x i32> %interleaved.vec              ; Write 4 tuples of R,G,B
void InnerLoopVectorizer::vectorizeInterleaveGroup(Instruction *Instr) {
  const InterleaveGroup *Group = Legal->getInterleavedAccessGroup(Instr);
  assert(Group && "Fail to get an interleaved access group.");

  // Skip if current instruction is not the insert position.
  if (Instr != Group->getInsertPos())
    return;

  LoadInst *LI = dyn_cast<LoadInst>(Instr);
  StoreInst *SI = dyn_cast<StoreInst>(Instr);
  Value *Ptr = LI ? LI->getPointerOperand() : SI->getPointerOperand();

  // Prepare for the vector type of the interleaved load/store.
  Type *ScalarTy = LI ? LI->getType() : SI->getValueOperand()->getType();
  unsigned InterleaveFactor = Group->getFactor();
  Type *VecTy = VectorType::get(ScalarTy, InterleaveFactor * VF, Scalable);
  Type *PtrTy = VecTy->getPointerTo(Ptr->getType()->getPointerAddressSpace());

  // Prepare for the new pointers.
  setDebugLocFromInst(Builder, Ptr);
  VectorParts &PtrParts = getVectorValue(Ptr);
  SmallVector<Value *, 2> NewPtrs;
  unsigned Index = Group->getIndex(Instr);
  for (unsigned Part = 0; Part < UF; Part++) {
    // Extract the pointer for current instruction from the pointer vector. A
    // reverse access uses the pointer in the last lane.
    Value *NewPtr = Builder.CreateExtractElement(
        PtrParts[Part],
        Group->isReverse() ? Builder.getInt32(VF - 1) : Builder.getInt32(0));

    // Notice current instruction could be any index. Need to adjust the address
    // to the member of index 0.
    //
    // E.g.  a = A[i+1];     // Member of index 1 (Current instruction)
    //       b = A[i];       // Member of index 0
    // Current pointer is pointed to A[i+1], adjust it to A[i].
    //
    // E.g.  A[i+1] = a;     // Member of index 1
    //       A[i]   = b;     // Member of index 0
    //       A[i+2] = c;     // Member of index 2 (Current instruction)
    // Current pointer is pointed to A[i+2], adjust it to A[i].
    NewPtr = Builder.CreateGEP(NewPtr, Builder.getInt32(-Index));

    // Cast to the vector pointer type.
    NewPtrs.push_back(Builder.CreateBitCast(NewPtr, PtrTy));
  }

  setDebugLocFromInst(Builder, Instr);
  Value *UndefVec = UndefValue::get(VecTy);

  // Vectorize the interleaved load group.
  if (LI) {
    for (unsigned Part = 0; Part < UF; Part++) {
      Instruction *NewLoadInstr = Builder.CreateAlignedLoad(
          NewPtrs[Part], Group->getAlignment(), "wide.vec");

      for (unsigned i = 0; i < InterleaveFactor; i++) {
        Instruction *Member = Group->getMember(i);

        // Skip the gaps in the group.
        if (!Member)
          continue;

        Constant *StrideMask = getStridedMask(Builder, i, InterleaveFactor, VF);
        Value *StridedVec = Builder.CreateShuffleVector(
            NewLoadInstr, UndefVec, StrideMask, "strided.vec");

        // If this member has different type, cast the result type.
        if (Member->getType() != ScalarTy) {
          VectorType *OtherVTy = VectorType::get(Member->getType(), VF,
                                                 Scalable);
          StridedVec = Builder.CreateBitOrPointerCast(StridedVec, OtherVTy);
        }

        VectorParts &Entry = WidenMap.get(Member);
        Entry[Part] =
            Group->isReverse() ? reverseVector(StridedVec) : StridedVec;
      }

      addMetadata(NewLoadInstr, Instr);
    }
    return;
  }

  // The sub vector type for current instruction.
  VectorType *SubVT = VectorType::get(ScalarTy, VF, Scalable);

  // Vectorize the interleaved store group.
  for (unsigned Part = 0; Part < UF; Part++) {
    // Collect the stored vector from each member.
    SmallVector<Value *, 4> StoredVecs;
    for (unsigned i = 0; i < InterleaveFactor; i++) {
      // Interleaved store group doesn't allow a gap, so each index has a member
      Instruction *Member = Group->getMember(i);
      assert(Member && "Fail to get a member from an interleaved store group");

      Value *StoredVec =
          getVectorValue(dyn_cast<StoreInst>(Member)->getValueOperand())[Part];
      if (Group->isReverse())
        StoredVec = reverseVector(StoredVec);

      // If this member has different type, cast it to an unified type.
      if (StoredVec->getType() != SubVT)
        StoredVec = Builder.CreateBitOrPointerCast(StoredVec, SubVT);

      StoredVecs.push_back(StoredVec);
    }

    // Concatenate all vectors into a wide vector.
    Value *WideVec = ConcatenateVectors(Builder, StoredVecs);

    // Interleave the elements in the wide vector.
    Constant *IMask = getInterleavedMask(Builder, VF, InterleaveFactor);
    Value *IVec = Builder.CreateShuffleVector(WideVec, UndefVec, IMask,
                                              "interleaved.vec");

    Instruction *NewStoreInstr =
        Builder.CreateAlignedStore(IVec, NewPtrs[Part], Group->getAlignment());
    addMetadata(NewStoreInstr, Instr);
  }
}

static bool storeToSameAddress(ScalarEvolution *SE, StoreInst *A, StoreInst *B) {
  // Keep aliasing simple by rejecting all but identical stores.
  if (A->getType() != B->getType())
    return false;

  // Compare store
  if (A == B)
    return true;

  // Otherwise Compare pointers
  Value *APtr = A->getPointerOperand();
  Value *BPtr = B->getPointerOperand();
  if (A == B)
    return true;

  // Otherwise compare address SCEVs
  if (SE->getSCEV(APtr) == SE->getSCEV(BPtr))
    return true;

  return false;
}

void InnerLoopVectorizer::vectorizeMemsetInstruction(MemSetInst *MSI) {
  const auto Length = MSI->getLength();
  const auto IsVolatile = MSI->isVolatile();
  // Clamp Alignment to yield an acceptable vector element type.
  const auto Alignment = std::min(MSI->getAlignmentCst()->getZExtValue(),
                                  (uint64_t) 8);
  const auto Val = MSI->getValue();
  const auto Dest = MSI->getRawDest();
  auto CL = dyn_cast<ConstantInt>(Length);
  assert(CL && "Not a constant value.");
  assert((CL->getZExtValue() % Alignment == 0)
         && "Not a valid number of writes.");
  assert(((CL->getZExtValue() / Alignment) <= VectorizerMemSetThreshold)
         && "Not a valid number of elements.");
  assert(!IsVolatile && "Cannot transform a volatile memset.");
  assert(VectorizeMemset && "Should not vectorize memset.");
  assert(isScalable() && "Require WA.");

  VectorParts &Ptrs = getVectorValue(Dest);
  VectorParts &Vals = getVectorValue(Val);
  for (unsigned Part = 0; Part < UF; ++Part) {
    auto *Ctx = &MSI->getParent()->getParent()->getContext();
    assert(Vals[Part]->getType()->getScalarType()->getScalarSizeInBits() == 8
           && "Invalid pointer");
    Type *WideScalarTy = IntegerType::get(*Ctx, 8 * Alignment);
    VectorType::ElementCount EC(VF * Alignment, Scalable);
    Value *VecVal = Builder.CreateVectorSplat(EC, Val);
    auto WideVecTy = VectorType::get(WideScalarTy, VF, Scalable);
    VecVal = Builder.CreateBitCast(VecVal, WideVecTy);

    // Generate the actual memset replacement.
    auto AddrSpace = Ptrs[Part]->getType()->getPointerAddressSpace();
    auto WideVecPtrTy = VectorType::get(WideScalarTy->getPointerTo(AddrSpace),
                                        VF, Scalable);
    Value *P = Predicate[Part];
    for (unsigned i = 0; i < CL->getZExtValue(); i+=Alignment) {
      auto Ptr = Builder.CreateGEP(Ptrs[Part], Builder.getInt32(i));
      Ptr = Builder.CreateBitCast(Ptr, WideVecPtrTy);
      auto *NewMemset = Builder.CreateMaskedScatter(VecVal, Ptr, Alignment, P);
      propagateMetadata(NewMemset, MSI);
    }
  }
}

void InnerLoopVectorizer::vectorizeMemoryInstruction(Instruction *Instr) {
  // Attempt to issue a wide load.
  LoadInst *LI = dyn_cast<LoadInst>(Instr);
  StoreInst *SI = dyn_cast<StoreInst>(Instr);

  assert((LI || SI) && "Invalid Load/Store instruction");

  // Don't create a memory instruction for an intermediate store of a
  // reduction variable, because this will be one to a uniform address.
  if (SI) {
    for (auto &Reduction : *Legal->getReductionVars()) {
      RecurrenceDescriptor DS = Reduction.second;
      if (DS.IntermediateStore &&
          storeToSameAddress(PSE.getSE(), SI, DS.IntermediateStore))
        return;
    }
  }

  // Try to vectorize the interleave group if this access is interleaved.
  if (Legal->isAccessInterleaved(Instr))
    return vectorizeInterleaveGroup(Instr);

  Type *ScalarDataTy = LI ? LI->getType() : SI->getValueOperand()->getType();
  Type *DataTy = VectorType::get(ScalarDataTy, VF, Scalable);
  Value *Ptr = LI ? LI->getPointerOperand() : SI->getPointerOperand();
  unsigned Alignment = LI ? LI->getAlignment() : SI->getAlignment();
  // An alignment of 0 means target abi alignment. We need to use the scalar's
  // target abi alignment in such a case.
  const DataLayout &DL = Instr->getModule()->getDataLayout();
  if (!Alignment)
    Alignment = DL.getABITypeAlignment(ScalarDataTy);
  unsigned AddressSpace = Ptr->getType()->getPointerAddressSpace();
  unsigned ScalarAllocatedSize = DL.getTypeAllocSize(ScalarDataTy);
  unsigned VectorElementSize = DL.getTypeStoreSize(DataTy) / VF;

  if (SI && Legal->blockNeedsPredication(SI->getParent()) &&
      !Legal->isMaskRequired(SI) && !UsePredication)
    return scalarizeInstruction(Instr, true);

  if (ScalarAllocatedSize != VectorElementSize)
    return scalarizeInstruction(Instr);

  Constant *Zero = Builder.getInt32(0);
  VectorParts &Entry = WidenMap.get(Instr);

  // If the pointer is loop invariant scalarize the load.
  if (LI && Legal->isUniform(Ptr)) {
    // ... unless we're vectorizing for a scalable architecture.
    if (isScalable()) {
      // The pointer may be uniform from SCEV perspective,
      // but may not be hoisted out for other reasons.
      auto *PtrI = dyn_cast<Instruction>(Ptr);
      if (PtrI && OrigLoop->contains(PtrI)) {
        Ptr = Builder.CreateExtractElement(getVectorValue(Ptr)[0],
                        Builder.getInt32(0));
      }

      // Generate a scalar load...
      Instruction *NewLI = Builder.CreateLoad(Ptr);
      propagateMetadata(NewLI, LI);

      // ... and splat it.
      for (unsigned Part = 0; Part < UF; ++Part) {
        Entry[Part] =
            Builder.CreateVectorSplat({VF, Scalable}, NewLI, "uniform_load");
      }
    } else
      scalarizeInstruction(Instr);

    return;
  }

  // If the pointer is non-consecutive and gather/scatter is not supported
  // scalarize the instruction.
  int Stride = Legal->isConsecutivePtr(Ptr);
  bool Reverse = Stride < 0;
  bool HasConsecutiveStride = (std::abs(Stride) == 1);
  bool CreateGatherScatter =
       !HasConsecutiveStride &&
       ((LI && Legal->isLegalMaskedGather(ScalarDataTy)) ||
        (SI && Legal->isLegalMaskedScatter(ScalarDataTy)));

  if (!HasConsecutiveStride && !CreateGatherScatter)
    return scalarizeInstruction(Instr);

  VectorParts VectorGep;
  GetElementPtrInst *Gep = getGEPInstruction(Ptr);
  if (HasConsecutiveStride) {
    if (Gep && Legal->isInductionVariable(Gep->getPointerOperand())) {
      setDebugLocFromInst(Builder, Gep);
      Value *PtrOperand = Gep->getPointerOperand();
      Value *FirstBasePtr = getVectorValue(PtrOperand)[0];
      FirstBasePtr = Builder.CreateExtractElement(FirstBasePtr, Zero);

      // Create the new GEP with the new induction variable.
      GetElementPtrInst *Gep2 = cast<GetElementPtrInst>(Gep->clone());
      Gep2->setOperand(0, FirstBasePtr);
      Gep2->setName("gep.indvar.base");
      Ptr = Builder.Insert(Gep2);
    } else if (Gep) {
      setDebugLocFromInst(Builder, Gep);
      assert(PSE.getSE()->isLoopInvariant(PSE.getSCEV(Gep->getPointerOperand()),
                                          OrigLoop) &&
             "Base ptr must be invariant");
      // The last index does not have to be the induction. It can be
      // consecutive and be a function of the index. For example A[I+1];
      unsigned NumOperands = Gep->getNumOperands();
      unsigned InductionOperand = getGEPInductionOperand(Gep);
      // Create the new GEP with the new induction variable.
      GetElementPtrInst *Gep2 = cast<GetElementPtrInst>(Gep->clone());

      for (unsigned i = 0; i < NumOperands; ++i) {
        Value *GepOperand = Gep->getOperand(i);
        Instruction *GepOperandInst = dyn_cast<Instruction>(GepOperand);

        // Update last index or loop invariant instruction anchored in loop.
        if (i == InductionOperand ||
            (GepOperandInst && OrigLoop->contains(GepOperandInst))) {
          assert((i == InductionOperand ||
                  PSE.getSE()->isLoopInvariant(PSE.getSCEV(GepOperandInst),
                                               OrigLoop)) &&
                 "Must be last index or loop invariant");

          VectorParts &GEPParts = getVectorValue(GepOperand);
          Value *Index = GEPParts[0];
          Index = Builder.CreateExtractElement(Index, Zero);
          Gep2->setOperand(i, Index);
          Gep2->setName("gep.indvar.idx");
        }
      }
      Ptr = Builder.Insert(Gep2);
    } else { // No GEP
      // Use the induction element ptr.
      assert(isa<PHINode>(Ptr) && "Invalid induction ptr");
      setDebugLocFromInst(Builder, Ptr);
      VectorParts &PtrVal = getVectorValue(Ptr);
      Ptr = Builder.CreateExtractElement(PtrVal[0], Zero);
    }
  } else {
    // At this point we should vector version of GEP for Gather or Scatter
    assert(CreateGatherScatter && "The instruction should be scalarized");
    // For scalable vectorization, vectorizeGEPInstruction has already
    // handled this. Only useful for fixed-length.
    // TODO: Unify this version with the scalable code once we can discuss with
    // the community.
    if (Gep && !isScalable()) {
      SmallVector<VectorParts, 4> OpsV;
      // Vectorizing GEP, across UF parts, we want to keep each loop-invariant
      // base or index of GEP scalar
      for (Value *Op : Gep->operands()) {
        if (PSE.getSE()->isLoopInvariant(PSE.getSCEV(Op), OrigLoop))
          OpsV.push_back(VectorParts(UF, Op));
        else
          OpsV.push_back(getVectorValue(Op));
      }

      for (unsigned Part = 0; Part < UF; ++Part) {
        SmallVector<Value *, 4> Ops;
        Value *GEPBasePtr = OpsV[0][Part];
        for (unsigned i = 1; i < Gep->getNumOperands(); i++)
          Ops.push_back(OpsV[i][Part]);
        Value *NewGep =
            Builder.CreateGEP(nullptr, GEPBasePtr, Ops, "VectorGep");
        assert(NewGep->getType()->isVectorTy() && "Expected vector GEP");
        NewGep =
            Builder.CreateBitCast(NewGep, VectorType::get(Ptr->getType(),
                                                          {VF, Scalable}));
        VectorGep.push_back(NewGep);
      }
    } else
      VectorGep = getVectorValue(Ptr);
  }

  Type *DataPtrTy = DataTy->getPointerTo(AddressSpace);
  VectorParts Mask = createBlockInMask(Instr->getParent());

  VectorParts PredStoreMask;
  if (SI && Legal->blockNeedsPredication(SI->getParent()) &&
      !Legal->isMaskRequired(SI)) {
    assert(UsePredication && "Cannot predicate store without predication.");
    assert(SI->getParent()->getSinglePredecessor() &&
           "Only support single predecessor blocks.");
    PredStoreMask = createEdgeMask(SI->getParent()->getSinglePredecessor(),
                                   SI->getParent());
  }

  // Handle Stores:
  if (SI) {
    assert(!Legal->isUniform(SI->getPointerOperand()) &&
           "We do not allow storing to uniform addresses");
    setDebugLocFromInst(Builder, SI);
    // We don't want to update the value in the map as it might be used in
    // another expression. So don't use a reference type for "StoredVal".
    VectorParts StoredVal = getVectorValue(SI->getValueOperand());

    for (unsigned Part = 0; Part < UF; ++Part) {
      Instruction *NewSI = nullptr;
      if (CreateGatherScatter) {
        Value *P = Predicate[Part];

        if (Legal->isMaskRequired(SI))
          P = Builder.CreateAnd(P, Mask[Part]);

        NewSI = Builder.CreateMaskedScatter(StoredVal[Part], VectorGep[Part],
                                            Alignment, P);
      } else {
        // Calculate the pointer for the specific unroll-part.
        Value *VecPtr;

        Value *MaskPart = Mask[Part];
        Value *Data = StoredVal[Part];

        if (UsePredication)
          MaskPart = Builder.CreateAnd(MaskPart, Predicate[Part]);

        if (Reverse) {
          // If we store to reverse consecutive memory locations, then we need
          // to reverse the order of elements in the stored value.
          Data = reverseVector(Data);
          // If the address is consecutive but reversed, then the
          // wide store needs to start at the last vector element.
          VecPtr = Builder.CreateGEP(nullptr, Ptr, Builder.getInt32(1));
          VecPtr = Builder.CreateBitCast(VecPtr, DataPtrTy);
          VecPtr = Builder.CreateGEP(nullptr, VecPtr, Builder.getInt32(-Part-1));
          MaskPart = reverseVector(MaskPart);
        } else {
          VecPtr = Builder.CreateBitCast(Ptr, DataPtrTy);
          VecPtr = Builder.CreateGEP(nullptr, VecPtr, Builder.getInt32(Part));
        }

        if (Legal->isMaskRequired(SI))
          NewSI = Builder.CreateMaskedStore(Data, VecPtr, Alignment, MaskPart);
        else if (UsePredication) {
          Value* P = Predicate[Part];

          if (Legal->blockNeedsPredication(SI->getParent()))
            P = Builder.CreateAnd(P, PredStoreMask[Part]);

          if (Reverse)
            P = reverseVector(P);

          NewSI = Builder.CreateMaskedStore(Data, VecPtr, Alignment, P);
        } else
          NewSI = Builder.CreateAlignedStore(Data, VecPtr, Alignment);
      }
      addMetadata(NewSI, SI);
    }
    return;
  }

  // Handle loads.
  assert(LI && "Must have a load instruction");
  setDebugLocFromInst(Builder, LI);
  for (unsigned Part = 0; Part < UF; ++Part) {
    Instruction *NewLI;
    if (CreateGatherScatter) {
      Value *P = Predicate[Part];
      if (Legal->isMaskRequired(LI))
        P = Builder.CreateAnd(P, Mask[Part]);

      NewLI = Builder.CreateMaskedGather(VectorGep[Part], Alignment,
                                         P, 0, "wide.masked.gather");
      Entry[Part] = NewLI;
    } else {
      // Calculate the pointer for the specific unroll-part.
      Value *VecPtr;

      Value *MaskPart = Mask[Part];

      if (UsePredication)
        MaskPart = Builder.CreateAnd(MaskPart, Predicate[Part]);

      if (Reverse) {
        // If the address is consecutive but reversed, then the
        // wide load needs to start at the last vector element.
        VecPtr = Builder.CreateGEP(nullptr, Ptr, Builder.getInt32(1));
        VecPtr = Builder.CreateBitCast(VecPtr, DataPtrTy);
        VecPtr = Builder.CreateGEP(nullptr, VecPtr, Builder.getInt32(-Part-1));
        MaskPart = reverseVector(MaskPart);
      } else {
        VecPtr = Builder.CreateBitCast(Ptr, DataPtrTy);
        VecPtr = Builder.CreateGEP(nullptr, VecPtr, Builder.getInt32(Part));
      }

      if (Legal->isMaskRequired(LI))
        NewLI = Builder.CreateMaskedLoad(VecPtr, Alignment, MaskPart,
                                         UndefValue::get(DataTy),
                                         "wide.masked.load");
      else if (UsePredication) {
        Value* P = Reverse ? reverseVector(Predicate[Part]) : Predicate[Part];
        NewLI = Builder.CreateMaskedLoad(VecPtr, Alignment, P,
                                         UndefValue::get(DataTy),
                                         "wide.masked.load");
      } else
        NewLI = Builder.CreateAlignedLoad(VecPtr, Alignment, "wide.load");
      Entry[Part] = Reverse ? reverseVector(NewLI) : NewLI;
    }
    addMetadata(NewLI, LI);
  }
}

/// Depending on the access pattern, either of three things happen with
/// the GetElementPtr instruction:
/// - GEP is loop invariant:
///     Nothing
/// - GEP is affine function of loop iteration counter:
///     GEP is replaced by a seriesvector(%ptr, %stride)
/// - GEP is not affine:
/// - GEP pointer is a vectorized GEP instruction::
///     GEP is replaced by a vector of pointers using arithmetic
void InnerLoopVectorizer::vectorizeGEPInstruction(Instruction *Instr) {
  GetElementPtrInst *Gep = cast<GetElementPtrInst>(Instr);

  if (!isScalable()) {
    scalarizeInstruction(Instr);
    return;
  }

  auto *SE = PSE.getSE();

  // Handle all non loop invariant forms that are not affine, so that
  // when used as address it can be transformed into a gather load/store,
  // or when used as pointer arithmetic, it is just vectorized into
  // arithmetic instructions.
  auto *SAR = dyn_cast<SCEVAddRecExpr>(SE->getSCEV(Gep));
  if (!SAR || !SAR->isAffine()) {
    vectorizeArithmeticGEP(Gep);
    return;
  }

  // Create SCEV expander for Start- and StepValue
  const DataLayout &DL = Instr->getModule()->getDataLayout();
  SCEVExpander Expander(*SE, DL, "seriesgep");

  // Expand step and start value (the latter in preheader)
  const SCEV *StepRec = SAR->getStepRecurrence(*SE);

  // If the step can't be divided by the type size of the GEP (for example if
  // the type structure is { gep = { i64, i64 }, i64 }, then also use the
  // pointer arithmetic vectorization.
  if (auto *StepC = dyn_cast<SCEVConstant>(StepRec)) {
    if (StepC->getAPInt().getZExtValue() %
        DL.getTypeAllocSize(Gep->getType()->getPointerElementType())) {
      vectorizeArithmeticGEP(Gep);
      return;
    }
  }

  Value *StepValue = Expander.expandCodeFor(StepRec, StepRec->getType(),
                                            &*Builder.GetInsertPoint());

  // Try to find a smaller type for StepValue
  const SCEV *BETC = SE->getMaxBackedgeTakenCount(OrigLoop);
  if (auto * MaxIters = dyn_cast<SCEVConstant>(BETC)) {
    if (auto * CI = dyn_cast<ConstantInt>(StepValue)) {
      // RequiredBits = active_bits(max_iterations * step_value)
      APInt MaxItersV = MaxIters->getValue()->getValue();
      if (CI->isNegative())
        MaxItersV = MaxItersV.sextOrSelf(CI->getValue().getBitWidth());
      else
        MaxItersV = MaxItersV.zextOrSelf(CI->getValue().getBitWidth());

      APInt MaxVal = MaxItersV * CI->getValue();

      // Try to reduce this type from i64 to something smaller
      unsigned RequiredBits = MaxVal.getActiveBits();
      unsigned StepBits = StepValue->getType()->getIntegerBitWidth();
      while (RequiredBits <= StepBits && StepBits >= 32)
        StepBits = StepBits >> 1;

      // Truncate the step value
      Type *NewStepType = IntegerType::get(
          Instr->getParent()->getContext(), StepBits << 1);
      StepValue = Builder.CreateTrunc(StepValue, NewStepType);
    }
  }

  const SCEV *StartRec = SAR->getStart();
  Value *StartValue = Expander.expandCodeFor(
      StartRec, Gep->getType(), LoopVectorPreHeader->getTerminator());

  // Normalize Start offset for first iteration in case the
  // Induction variable does not start at 0.
  IRBuilder<>::InsertPoint IP = Builder.saveIP();
  Builder.SetInsertPoint(&*LoopVectorPreHeader->getTerminator());

  Value *Base = Gep->getPointerOperand();
  Value *Tmp2 = Builder.CreateBitCast(StartValue,
      Builder.getInt8PtrTy(Base->getType()->getPointerAddressSpace()));

  // We can zero extend the incoming value, because Induction is
  // the unsigned iteration counter.
  Value *Tmp = Induction->getIncomingValueForBlock(LoopVectorPreHeader);
  Tmp = Builder.CreateZExtOrTrunc(Tmp, StepValue->getType());
  Tmp = Builder.CreateMul(StepValue, Tmp);
  Tmp = Builder.CreateSub(ConstantInt::get(StepValue->getType(), 0), Tmp);
  Tmp = Builder.CreateGEP(Tmp2, Tmp);
  StartValue = Builder.CreateBitCast(Tmp, StartValue->getType());
  Builder.restoreIP(IP);

  // Normalize to be in #elements, not bytes
  Type *ElemTy = Instr->getType()->getPointerElementType();
  Tmp = ConstantInt::get(StepValue->getType(), DL.getTypeAllocSize(ElemTy));
  StepValue = Builder.CreateSDiv(StepValue, Tmp);

  // Get the dynamic VL
  Value *NumEls = getElementCount(Instr->getType(), VF, Scalable);
  NumEls = Builder.CreateZExtOrTrunc(NumEls, StepValue->getType());

  // Create the series vector
  VectorParts &Entry = WidenMap.get(Instr);

  // Induction is always the widest induction type in the loop,
  // but if that is not enough for evaluating the step, zero extend is
  // fine because Induction is the iteration counter, always unsigned.
  Value *IterOffset = Builder.CreateZExtOrTrunc(Induction, StepValue->getType());
  IterOffset = Builder.CreateMul(IterOffset, StepValue);
  for (unsigned Part = 0; Part < UF; ++Part) {
    // Tmp = part * stride * VL
    Value *UnrollOffset = ConstantInt::get(NumEls->getType(), Part);
    UnrollOffset = Builder.CreateMul(StepValue, UnrollOffset);
    UnrollOffset = Builder.CreateMul(NumEls, UnrollOffset);

    // Adjust offset for unrolled iteration
    Value *Offset = Builder.CreateAdd(IterOffset, UnrollOffset);
    Offset = Builder.CreateSeriesVector({VF,Scalable}, Offset, StepValue);

    // Address = getelementptr %scalarbase, seriesvector(0, step)
    Entry[Part] = Builder.CreateGEP(StartValue, Offset);
  }

  addMetadata(Entry, Instr);
}

void InnerLoopVectorizer::scalarizeInstruction(Instruction *Instr,
                                               bool IfPredicateStore) {
  assert(!Instr->getType()->isAggregateType() && "Can't handle vectors");
  assert(!isScalable() &&
         "Cannot scalarize instruction with scalable vectorization");

  // Holds vector parameters or scalars, in case of uniform vals.
  SmallVector<VectorParts, 4> Params;

  setDebugLocFromInst(Builder, Instr);

  // Find all of the vectorized parameters.
  for (unsigned op = 0, e = Instr->getNumOperands(); op != e; ++op) {
    Value *SrcOp = Instr->getOperand(op);

    // If we are accessing the old induction variable, use the new one.
    if (SrcOp == OldInduction) {
      Params.push_back(getVectorValue(SrcOp));
      continue;
    }

    // Try using previously calculated values.
    Instruction *SrcInst = dyn_cast<Instruction>(SrcOp);

    // If the src is an instruction that appeared earlier in the basic block,
    // then it should already be vectorized.
    if (SrcInst && OrigLoop->contains(SrcInst)) {
      assert(WidenMap.has(SrcInst) && "Source operand is unavailable");
      // The parameter is a vector value from earlier.
      Params.push_back(WidenMap.get(SrcInst));
    } else {
      // The parameter is a scalar from outside the loop. Maybe even a constant.
      VectorParts Scalars;
      Scalars.append(UF, SrcOp);
      Params.push_back(Scalars);
    }
  }

  assert(Params.size() == Instr->getNumOperands() &&
         "Invalid number of operands");

  // Does this instruction return a value ?
  bool IsVoidRetTy = Instr->getType()->isVoidTy();

  Value *UndefVec =
      IsVoidRetTy ? nullptr
                  : UndefValue::get(VectorType::get(Instr->getType(), VF));
  // Create a new entry in the WidenMap and initialize it to Undef or Null.
  VectorParts &VecResults = WidenMap.splat(Instr, UndefVec);

  VectorParts Cond;
  if (IfPredicateStore) {
    assert(Instr->getParent()->getSinglePredecessor() &&
           "Only support single predecessor blocks");
    Cond = createEdgeMask(Instr->getParent()->getSinglePredecessor(),
                          Instr->getParent());
  }

  // For each vector unroll 'part':
  for (unsigned Part = 0; Part < UF; ++Part) {
    // For each scalar that we create:
    for (unsigned Width = 0; Width < VF; ++Width) {

      // Start if-block.
      Value *Cmp = nullptr;
      if (IfPredicateStore) {
        Cmp = Builder.CreateExtractElement(Cond[Part], Builder.getInt32(Width));
        Cmp = Builder.CreateICmp(ICmpInst::ICMP_EQ, Cmp,
                                 ConstantInt::get(Cmp->getType(), 1));
      }

      Instruction *Cloned = Instr->clone();
      if (!IsVoidRetTy)
        Cloned->setName(Instr->getName() + ".cloned");
      // Replace the operands of the cloned instructions with extracted scalars.
      for (unsigned op = 0, e = Instr->getNumOperands(); op != e; ++op) {
        Value *Op = Params[op][Part];
        // Param is a vector. Need to extract the right lane.
        if (Op->getType()->isVectorTy())
          Op = Builder.CreateExtractElement(Op, Builder.getInt32(Width));
        Cloned->setOperand(op, Op);
      }
      addNewMetadata(Cloned, Instr);

      // Place the cloned scalar in the new loop.
      Builder.Insert(Cloned);

      // If we just cloned a new assumption, add it the assumption cache.
      if (auto *II = dyn_cast<IntrinsicInst>(Cloned))
        if (II->getIntrinsicID() == Intrinsic::assume)
          AC->registerAssumption(II);

      // If the original scalar returns a value we need to place it in a vector
      // so that future users will be able to use it.
      if (!IsVoidRetTy)
        VecResults[Part] = Builder.CreateInsertElement(VecResults[Part], Cloned,
                                                       Builder.getInt32(Width));
      // End if-block.
      if (IfPredicateStore)
        PredicatedStores.push_back(
            std::make_pair(cast<StoreInst>(Cloned), Cmp));
    }
  }
}

static Instruction *getFirstInst(Instruction *FirstInst, Value *V,
                                 Instruction *Loc) {
  if (FirstInst)
    return FirstInst;
  if (Instruction *I = dyn_cast<Instruction>(V))
    return I->getParent() == Loc->getParent() ? I : nullptr;
  return nullptr;
}

std::pair<Instruction *, Instruction *>
InnerLoopVectorizer::addStrideCheck(Instruction *Loc) {
  Instruction *tnullptr = nullptr;
  if (!Legal->mustCheckStrides())
    return std::pair<Instruction *, Instruction *>(tnullptr, tnullptr);

  IRBuilder<> ChkBuilder(Loc);

  // Emit checks.
  Value *Check = nullptr;
  Instruction *FirstInst = nullptr;
  for (SmallPtrSet<Value *, 8>::iterator SI = Legal->strides_begin(),
                                         SE = Legal->strides_end();
       SI != SE; ++SI) {
    Value *Ptr = stripIntegerCast(*SI);
    Value *C = ChkBuilder.CreateICmpNE(Ptr, ConstantInt::get(Ptr->getType(), 1),
                                       "stride.chk");
    // Store the first instruction we create.
    FirstInst = getFirstInst(FirstInst, C, Loc);
    if (Check)
      Check = ChkBuilder.CreateOr(Check, C);
    else
      Check = C;
  }

  // We have to do this trickery because the IRBuilder might fold the check to a
  // constant expression in which case there is no Instruction anchored in a
  // the block.
  LLVMContext &Ctx = Loc->getContext();
  Instruction *TheCheck =
      BinaryOperator::CreateAnd(Check, ConstantInt::getTrue(Ctx));
  ChkBuilder.Insert(TheCheck, "stride.not.one");
  FirstInst = getFirstInst(FirstInst, TheCheck, Loc);

  return std::make_pair(FirstInst, TheCheck);
}

PHINode *InnerLoopVectorizer::createInductionVariable(Loop *L, Value *Start,
                                                      Value *End, Value *Step,
                                                      Instruction *DL) {
  BasicBlock *Header = L->getHeader();
  BasicBlock *Latch = L->getLoopLatch();
  // As we're just creating this loop, it's possible no latch exists
  // yet. If so, use the header as this will be a single block loop.
  if (!Latch)
    Latch = Header;

  IRBuilder<> Builder(&*Header->getFirstInsertionPt());
  setDebugLocFromInst(Builder, getDebugLocFromInstOrOperands(OldInduction));

  auto *PredTy = VectorType::get(Builder.getInt1Ty(), VF, Scalable);
  auto *AllActive = ConstantInt::getTrue(PredTy);

  auto *Induction = Builder.CreatePHI(Start->getType(), 2, "index");
  for (unsigned i = 0; i < UF; ++i)
    Predicate.push_back(Builder.CreatePHI(PredTy, 2, "predicate"));

  Builder.SetInsertPoint(Latch->getTerminator());

  // Create i+1 and fill the PHINode.
  Value *Next = Builder.CreateAdd(Induction, Step, "index.next");
  Induction->addIncoming(Start, L->getLoopPreheader());
  Induction->addIncoming(Next, Latch);

  // Even though all lanes are active some code paths require a predicate.
  for (unsigned i = 0; i < UF; ++i) {
    Predicate[i]->addIncoming(AllActive, L->getLoopPreheader());
    Predicate[i]->addIncoming(AllActive, Latch);
  }

  // Create the compare.
  Value *ICmp = Builder.CreateICmpEQ(Next, End);
  Builder.CreateCondBr(ICmp, L->getExitBlock(), Header);

  // Now we have two terminators. Remove the old one from the block.
  Latch->getTerminator()->eraseFromParent();

  return Induction;
}

Value *InnerLoopVectorizer::getOrCreateTripCount(Loop *L) {
  if (TripCount)
    return TripCount;

  IRBuilder<> Builder(L->getLoopPreheader()->getTerminator());
  // Find the loop boundaries.
  ScalarEvolution *SE = PSE.getSE();
  const SCEV *BackedgeTakenCount = PSE.getBackedgeTakenCount();
  assert(BackedgeTakenCount != SE->getCouldNotCompute() &&
         "Invalid loop count");

  Type *IdxTy = Legal->getWidestInductionType();

  // The exit count might have the type of i64 while the phi is i32. This can
  // happen if we have an induction variable that is sign extended before the
  // compare. The only way that we get a backedge taken count is that the
  // induction variable was signed and as such will not overflow. In such a case
  // truncation is legal.
  if (BackedgeTakenCount->getType()->getPrimitiveSizeInBits() >
      IdxTy->getPrimitiveSizeInBits())
    BackedgeTakenCount = SE->getTruncateOrNoop(BackedgeTakenCount, IdxTy);
  BackedgeTakenCount = SE->getNoopOrZeroExtend(BackedgeTakenCount, IdxTy);

  // Get the total trip count from the count by adding 1.
  const SCEV *ExitCount = SE->getAddExpr(
      BackedgeTakenCount, SE->getOne(BackedgeTakenCount->getType()));

  const DataLayout &DL = L->getHeader()->getModule()->getDataLayout();

  // Expand the trip count and place the new instructions in the preheader.
  // Notice that the pre-header does not change, only the loop body.
  SCEVExpander Exp(*SE, DL, "induction");

  // Count holds the overall loop count (N).
  TripCount = Exp.expandCodeFor(ExitCount, ExitCount->getType(),
                                L->getLoopPreheader()->getTerminator());

  if (TripCount->getType()->isPointerTy())
    TripCount =
        CastInst::CreatePointerCast(TripCount, IdxTy, "exitcount.ptrcnt.to.int",
                                    L->getLoopPreheader()->getTerminator());

  return TripCount;
}

Value *InnerLoopVectorizer::getOrCreateVectorTripCount(Loop *L) {
  if (VectorTripCount)
    return VectorTripCount;

  Value *TC = getOrCreateTripCount(L);
  if (UsePredication) {
    // All iterations are done by the vector body so VectorTripCount==TripCount.
    VectorTripCount = TC;
    return VectorTripCount;
  }

  IRBuilder<> Builder(L->getLoopPreheader()->getTerminator());

  // Now we need to generate the expression for N - (N % VF), which is
  // the part that the vectorized body will execute.
  // The loop step is equal to the vectorization factor (num of SIMD elements)
  // times the unroll factor (num of SIMD instructions).
  Value *R = Builder.CreateURem(TC, InductionStep, "n.mod.vf");

  // If there is a non-reversed interleaved group that may speculatively access
  // memory out-of-bounds, we need to ensure that there will be at least one
  // iteration of the scalar epilogue loop. Thus, if the step evenly divides
  // the trip count, we set the remainder to be equal to the step. If the step
  // does not evenly divide the trip count, no adjustment is necessary since
  // there will already be scalar iterations. Note that the minimum iterations
  // check ensures that N >= Step.
  if (VF > 1 && !Scalable && Legal->requiresScalarEpilogue()) {
    auto *IsZero = Builder.CreateICmpEQ(R, ConstantInt::get(R->getType(), 0));
    R = Builder.CreateSelect(IsZero, InductionStep, R);
  }

  VectorTripCount = Builder.CreateSub(TC, R, "n.vec");

  return VectorTripCount;
}

Value *InnerLoopVectorizer::getOrCreateInductionStep(Loop *L) {
  if (InductionStep)
    return InductionStep;

  IRBuilder<> Builder(L->getLoopPreheader()->getTerminator());
  Value *TC = getOrCreateTripCount(L);
  Type *IdxTy = TC->getType();

  auto *TV = UndefValue::get(VectorType::get(IdxTy, VF, Scalable));
  auto *ActualVF = Builder.CreateElementCount(IdxTy, TV);
  InductionStep = Builder.CreateMul(ActualVF, ConstantInt::get(IdxTy, UF));

  return InductionStep;
}

void InnerLoopVectorizer::emitMinimumIterationCountCheck(Loop *L,
                                                         Value *MinCount,
                                                         BasicBlock *Bypass) {
  Value *Count = getOrCreateTripCount(L);
  BasicBlock *BB = L->getLoopPreheader();
  IRBuilder<> Builder(BB->getTerminator());

  // Generate code to check that the loop's trip count that we computed by
  // adding one to the backedge-taken count will not overflow.
  Value *CheckMinIters = Builder.CreateICmpULT(Count, MinCount,
                                               "min.iters.check");

  BasicBlock *NewBB =
      BB->splitBasicBlock(BB->getTerminator(), "min.iters.checked");
  // Update dominator tree immediately if the generated block is a
  // LoopBypassBlock because SCEV expansions to generate loop bypass
  // checks may query it before the current function is finished.
  DT->addNewBlock(NewBB, BB);
  if (L->getParentLoop())
    L->getParentLoop()->addBasicBlockToLoop(NewBB, *LI);
  ReplaceInstWithInst(BB->getTerminator(),
                      BranchInst::Create(Bypass, NewBB, CheckMinIters));
  LoopBypassBlocks.push_back(BB);
}

void InnerLoopVectorizer::emitVectorLoopEnteredCheck(Loop *L,
                                                     BasicBlock *Bypass) {
  Value *TC = getOrCreateVectorTripCount(L);
  BasicBlock *BB = L->getLoopPreheader();
  IRBuilder<> Builder(BB->getTerminator());

  // Now, compare the new count to zero. If it is zero skip the vector loop and
  // jump to the scalar loop.
  Value *Cmp = Builder.CreateICmpEQ(TC, Constant::getNullValue(TC->getType()),
                                    "cmp.zero");

  // Generate code to check that the loop's trip count that we computed by
  // adding one to the backedge-taken count will not overflow.
  BasicBlock *NewBB = BB->splitBasicBlock(BB->getTerminator(), "vector.ph");
  // Update dominator tree immediately if the generated block is a
  // LoopBypassBlock because SCEV expansions to generate loop bypass
  // checks may query it before the current function is finished.
  DT->addNewBlock(NewBB, BB);
  if (L->getParentLoop())
    L->getParentLoop()->addBasicBlockToLoop(NewBB, *LI);
  ReplaceInstWithInst(BB->getTerminator(),
                      BranchInst::Create(Bypass, NewBB, Cmp));
  LoopBypassBlocks.push_back(BB);
}

void InnerLoopVectorizer::emitSCEVChecks(Loop *L, BasicBlock *Bypass) {
  BasicBlock *BB = L->getLoopPreheader();

  // Generate the code to check that the SCEV assumptions that we made.
  // We want the new basic block to start at the first instruction in a
  // sequence of instructions that form a check.
  SCEVExpander Exp(*PSE.getSE(), Bypass->getModule()->getDataLayout(),
                   "scev.check");
  Value *SCEVCheck =
      Exp.expandCodeForPredicate(&PSE.getUnionPredicate(), BB->getTerminator());

  if (auto *C = dyn_cast<ConstantInt>(SCEVCheck))
    if (C->isZero())
      return;

  // Create a new block containing the stride check.
  BB->setName("vector.scevcheck");
  auto *NewBB = BB->splitBasicBlock(BB->getTerminator(), "vector.ph");
  // Update dominator tree immediately if the generated block is a
  // LoopBypassBlock because SCEV expansions to generate loop bypass
  // checks may query it before the current function is finished.
  DT->addNewBlock(NewBB, BB);
  if (L->getParentLoop())
    L->getParentLoop()->addBasicBlockToLoop(NewBB, *LI);
  ReplaceInstWithInst(BB->getTerminator(),
                      BranchInst::Create(Bypass, NewBB, SCEVCheck));
  LoopBypassBlocks.push_back(BB);
  AddedSafetyChecks = true;
}

void InnerLoopVectorizer::emitMemRuntimeChecks(Loop *L, BasicBlock *Bypass) {
  BasicBlock *BB = L->getLoopPreheader();

  // Generate the code that checks in runtime if arrays overlap. We put the
  // checks into a separate block to make the more common case of few elements
  // faster.
  Instruction *FirstCheckInst;
  Instruction *MemRuntimeCheck;
  std::tie(FirstCheckInst, MemRuntimeCheck) =
      Legal->getLAI()->addRuntimeChecks(BB->getTerminator());
  if (!MemRuntimeCheck)
    return;

  // Create a new block containing the memory check.
  BB->setName("vector.memcheck");
  auto *NewBB = BB->splitBasicBlock(BB->getTerminator(), "vector.ph");
  // Update dominator tree immediately if the generated block is a
  // LoopBypassBlock because SCEV expansions to generate loop bypass
  // checks may query it before the current function is finished.
  DT->addNewBlock(NewBB, BB);
  if (L->getParentLoop())
    L->getParentLoop()->addBasicBlockToLoop(NewBB, *LI);
  ReplaceInstWithInst(BB->getTerminator(),
                      BranchInst::Create(Bypass, NewBB, MemRuntimeCheck));
  LoopBypassBlocks.push_back(BB);
  AddedSafetyChecks = true;

  // We currently don't use LoopVersioning for the actual loop cloning but we
  // still use it to add the noalias metadata.
  LVer = llvm::make_unique<LoopVersioning>(*Legal->getLAI(), OrigLoop, LI, DT,
                                           PSE.getSE());
  LVer->prepareNoAliasMetadata();
}

void InnerLoopVectorizer::createEmptyLoop() {
  /*
   In this function we generate a new loop. The new loop will contain
   the vectorized instructions while the old loop will continue to run the
   scalar remainder.

       [ ] <-- loop iteration number check.
    /   |
   /    v
  |    [ ] <-- vector loop bypass (may consist of multiple blocks).
  |  /  |
  | /   v
  ||   [ ]     <-- vector pre header.
  ||    |
  ||    v
  ||   [  ] \
  ||   [  ]_|   <-- vector loop.
  ||    |
  | \   v
  |   >[ ]   <--- middle-block.
  |   / |
  |  /  |
  | /   v
  -|- >[ ]     <--- new preheader.
   |    |
   |    v
   |   [ ] \
   |   [ ]_|   <-- old scalar loop to handle remainder.
    \   |
     \  v
      >[ ]     <-- exit block.
   ...
   */

  BasicBlock *OldBasicBlock = OrigLoop->getHeader();
  BasicBlock *VectorPH = OrigLoop->getLoopPreheader();
  BasicBlock *ExitBlock = OrigLoop->getExitBlock();
  assert(VectorPH && "Invalid loop structure");
  assert(ExitBlock && "Must have an exit block");

  // Some loops have a single integer induction variable, while other loops
  // don't. One example is c++ iterators that often have multiple pointer
  // induction variables. In the code below we also support a case where we
  // don't have a single induction variable.
  //
  // We try to obtain an induction variable from the original loop as hard
  // as possible. However if we don't find one that:
  //   - is an integer
  //   - counts from zero, stepping by one
  //   - is the size of the widest induction variable type
  // then we create a new one.
  OldInduction = Legal->getPrimaryInduction();
  Type *IdxTy = Legal->getWidestInductionType();

  // Split the single block loop into the two loop structure described above.
  BasicBlock *VecBody =
    VectorPH->splitBasicBlock(VectorPH->getTerminator(), "vector.body");
  BasicBlock *MiddleBlock =
      VecBody->splitBasicBlock(VecBody->getTerminator(), "middle.block");
  BasicBlock *ScalarPH =
      MiddleBlock->splitBasicBlock(MiddleBlock->getTerminator(), "scalar.ph");

  // Create and register the new vector loop.
  Loop *Lp = new Loop();
  Loop *ParentLoop = OrigLoop->getParentLoop();

  if (ParentLoop) {
    ParentLoop->addChildLoop(Lp);
    ParentLoop->addBasicBlockToLoop(ScalarPH, *LI);
    ParentLoop->addBasicBlockToLoop(MiddleBlock, *LI);

  } else {
    LI->addTopLevelLoop(Lp);
  }
  Lp->addBasicBlockToLoop(VecBody, *LI);

  // Find the loop boundaries.
  Value *Count = getOrCreateTripCount(Lp);
  Value *StartIdx = ConstantInt::get(IdxTy, 0);
  Value *Step = getOrCreateInductionStep(Lp);

  // We need to test whether the backedge-taken count is uint##_max. Adding one
  // to it will cause overflow and an incorrect loop trip count in the vector
  // body. In case of overflow we want to directly jump to the scalar remainder
  // loop.
  emitMinimumIterationCountCheck(Lp, Step, ScalarPH);
  // Now, compare the new count to zero. If it is zero skip the vector loop and
  // jump to the scalar loop.
  emitVectorLoopEnteredCheck(Lp, ScalarPH);
  // Generate the code to check any assumptions that we've made for SCEV
  // expressions.
  emitSCEVChecks(Lp, ScalarPH);
  // Generate the code that checks in runtime if arrays overlap. We put the
  // checks into a separate block to make the more common case of few elements
  // faster.
  emitMemRuntimeChecks(Lp, ScalarPH);
  
  // Generate the induction variable.
  // The loop step is equal to the vectorization factor (num of SIMD elements)
  // times the unroll factor (num of SIMD instructions).
  Value *CountRoundDown = getOrCreateVectorTripCount(Lp);

  Induction =
      createInductionVariable(Lp, StartIdx, CountRoundDown, InductionStep,
                              getDebugLocFromInstOrOperands(OldInduction));

  // We are going to resume the execution of the scalar loop.
  // Go over all of the induction variables that we found and fix the
  // PHIs that are left in the scalar version of the loop.
  // The starting values of PHI nodes depend on the counter of the last
  // iteration in the vectorized loop.
  // If we come from a bypass edge then we need to start from the original
  // start value.

  // This variable saves the new starting index for the scalar loop. It is used
  // to test if there are any tail iterations left once the vector loop has
  // completed.
  LoopVectorizationLegality::InductionList::iterator I, E;
  LoopVectorizationLegality::InductionList *List = Legal->getInductionVars();
  for (I = List->begin(), E = List->end(); I != E; ++I) {
    PHINode *OrigPhi = I->first;
    InductionDescriptor II = I->second;

    // Create phi nodes to merge from the  backedge-taken check block.
    PHINode *BCResumeVal = PHINode::Create(
        OrigPhi->getType(), 3, "bc.resume.val", ScalarPH->getTerminator());
    Value *&EndValue = IVEndValues[OrigPhi];
    if (OrigPhi == OldInduction) {
      // We know what the end value is.
      EndValue = CountRoundDown;
    } else {
      IRBuilder<> B(LoopBypassBlocks.back()->getTerminator());
      Type *StepType = II.getStep()->getType();
      Instruction::CastOps CastOp =
          CastInst::getCastOpcode(CountRoundDown, true, StepType, true);
      Value *CRD = B.CreateCast(CastOp, CountRoundDown, StepType, "cast.crd");
      const DataLayout &DL = OrigLoop->getHeader()->getModule()->getDataLayout();
      EndValue = II.transform(B, CRD, PSE.getSE(), DL);
      EndValue->setName("ind.end");
    }

    // The new PHI merges the original incoming value, in case of a bypass,
    // or the value at the end of the vectorized loop.
    BCResumeVal->addIncoming(EndValue, MiddleBlock);

    // Fix the scalar body counter (PHI node).
    unsigned BlockIdx = OrigPhi->getBasicBlockIndex(ScalarPH);

    // The old induction's phi node in the scalar body needs the truncated
    // value.
    for (unsigned I = 0, E = LoopBypassBlocks.size(); I != E; ++I)
      BCResumeVal->addIncoming(II.getStartValue(), LoopBypassBlocks[I]);
    OrigPhi->setIncomingValue(BlockIdx, BCResumeVal);
  }

  // Add a check in the middle block to see if we have completed
  // all of the iterations in the first vector loop.
  // If (N - N%VF) == N, then we *don't* need to run the remainder.
  Value *CmpN =
      CmpInst::Create(Instruction::ICmp, CmpInst::ICMP_EQ, Count,
                      CountRoundDown, "cmp.n", MiddleBlock->getTerminator());
  ReplaceInstWithInst(MiddleBlock->getTerminator(),
                      BranchInst::Create(ExitBlock, ScalarPH, CmpN));

  // Get ready to start creating new instructions into the vectorized body.
  Builder.SetInsertPoint(&*VecBody->getFirstInsertionPt());

  // Save the state.
  LoopVectorPreHeader = Lp->getLoopPreheader();
  LoopScalarPreHeader = ScalarPH;
  LoopMiddleBlock = MiddleBlock;
  LoopExitBlock = ExitBlock;
  LoopVectorBody.push_back(VecBody);
  VecBodyPostDom = VecBody;
  LoopScalarBody = OldBasicBlock;

  // Keep all loop hints from the original loop on the vector loop (we'll
  // replace the vectorizer-specific hints below).
  if (MDNode *LID = OrigLoop->getLoopID())
    Lp->setLoopID(LID);

  LoopVectorizeHints Hints(Lp, true, *ORE);
  Hints.setAlreadyVectorized();
}

void InnerLoopVectorizer::createEmptyLoopWithPredication() {
  /*
   In this function we generate a new loop. The new loop will contain
   the vectorized instructions while the old loop will continue to run the
   scalar remainder.

      v
     [ ] <-- Back-edge taken count overflow check.
    /   \
   |    [ ]  <-- vector loop bypass (may consist of multiple blocks).
   |    / \
   |   [ ] \  <-- vector pre header.
   |    |   |
   | />[ ]  |
   | |_[ ]  |  <-- vector loop.
   |    |   |
   |   [ ]  |  <-- middle-block.
   |    |   |
   |   [ ]  |  <-- return point from predicated loop.
   |    |   |
   |<---/   |
   |       [ ] <-- scalar preheader.
   |        |
   |       [ ]<\
   |       [ ]_|  <-- old scalar loop to handle remainder.
   |        |
   |<-------/
   v
  [ ] <-- exit block.
  ...
  */

  assert(UsePredication && "predication required for this layout");
  BasicBlock *OldBasicBlock = OrigLoop->getHeader();
  BasicBlock *VectorPH = OrigLoop->getLoopPreheader();
  BasicBlock *ExitBlock = OrigLoop->getExitBlock();
  assert(VectorPH && "Invalid loop structure");
  assert(ExitBlock && "Must have an exit block");

  // Some loops have a single integer induction variable, while other loops
  // don't. One example is c++ iterators that often have multiple pointer
  // induction variables. In the code below we also support a case where we
  // don't have a single induction variable.
  //
  // We try to obtain an induction variable from the original loop as hard
  // as possible. However if we don't find one that:
  //   - is an integer
  //   - counts from zero, stepping by one
  //   - is the size of the widest induction variable type
  // then we create a new one.
  OldInduction = Legal->getPrimaryInduction();
  Type *IdxTy = Legal->getWidestInductionType();
  Type *PredTy = Builder.getInt1Ty();
  Type *PredVecTy = VectorType::get(PredTy, VF, Scalable);
  Constant *One = ConstantInt::get(IdxTy, 1);

  // Split the single block loop into the two loop structure described above.
  BasicBlock *VecBody =
    VectorPH->splitBasicBlock(VectorPH->getTerminator(), "vector.body");
  BasicBlock *MiddleBlock =
    VecBody->splitBasicBlock(VecBody->getTerminator(), "middle.block");
  BasicBlock *ScalarPH =
    MiddleBlock->splitBasicBlock(MiddleBlock->getTerminator(), "scalar.ph");

  // Create and register the new vector loop.
  Loop* Lp = new Loop();
  Loop *ParentLoop = OrigLoop->getParentLoop();

  if (ParentLoop) {
    ParentLoop->addChildLoop(Lp);
    ParentLoop->addBasicBlockToLoop(ScalarPH, *LI);
    ParentLoop->addBasicBlockToLoop(MiddleBlock, *LI);

  } else {
    LI->addTopLevelLoop(Lp);
  }
  Lp->addBasicBlockToLoop(VecBody, *LI);

  // Find the loop boundaries.
  Value *Count = getOrCreateTripCount(Lp);
  Value *StartIdx = ConstantInt::get(IdxTy, 0);
  getOrCreateInductionStep(Lp);
  IdxEnd = Count;

  // We need to test whether the backedge-taken count is uint##_max. Adding one
  // to it will cause overflow and an incorrect loop trip count in the vector
  // body. In case of overflow we want to directly jump to the scalar loop.
  {
    ScalarEvolution *SE = PSE.getSE();
    const SCEV *BackedgeTakenCount = PSE.getBackedgeTakenCount();
    Type *IdxTy = Legal->getWidestInductionType();

    // The exit count might have the type of i64 while the phi is i32. This can
    // happen if we have an induction variable that is sign extended before the
    // compare. The only way that we get a backedge taken count is that the
    // induction variable was signed and as such will not overflow. In such a
    // case truncation is legal.
    if (BackedgeTakenCount->getType()->getPrimitiveSizeInBits() >
        IdxTy->getPrimitiveSizeInBits())
      BackedgeTakenCount = SE->getTruncateOrNoop(BackedgeTakenCount, IdxTy);
    BackedgeTakenCount = SE->getNoopOrZeroExtend(BackedgeTakenCount, IdxTy);

    // If we know ahead of time that overflow is not possible we still plant
    // the check but in a manner that is easily removable by a later pass.
    APInt MaxTakenCount = SE->getUnsignedRange(BackedgeTakenCount).getUpper();
    Constant *MinCount = ConstantInt::get(IdxTy, (MaxTakenCount + 1) == 0);
    emitMinimumIterationCountCheck(Lp, MinCount, ScalarPH);
  }
  // Generate the code to check any assumptions that we've made for SCEV
  // expressions.
  emitSCEVChecks(Lp, ScalarPH);
  // Generate the code that checks in runtime if arrays overlap. We put the
  // checks into a separate block to make the more common case of few elements
  // faster.
  emitMemRuntimeChecks(Lp, ScalarPH);

  // Record the exit value of induction variables for use by fixupIVUsers.
  for (auto &Entry : *Legal->getInductionVars()) {
    PHINode *OrigPhi = Entry.first;
    InductionDescriptor II = Entry.second;

    IRBuilder<> B(LoopBypassBlocks.back()->getTerminator());
    auto StepType = II.getStep()->getType();
    auto CastOp = CastInst::getCastOpcode(IdxEnd, true, StepType, true);
    auto CRD = B.CreateCast(CastOp, IdxEnd, StepType, "cast.crd");
    const DataLayout &DL = OrigLoop->getHeader()->getModule()->getDataLayout();

    Value *&EndValue = IVEndValues[OrigPhi];
    EndValue = II.transform(B, CRD, PSE.getSE(), DL);
    EndValue->setName("ind.end");
  }

  // ***************************************************************************
  // Start of vector.ph
  // ***************************************************************************

  Builder.SetInsertPoint(&*Lp->getLoopPreheader()->getTerminator());
  setDebugLocFromInst(Builder, getDebugLocFromInstOrOperands(OldInduction));

  IdxEndV = Builder.CreateVectorSplat({VF, Scalable}, Count, "wide.end.idx");

  // Create the loop's entry predicate taking integer overflow into account.
  VectorParts EntryPreds;
  Value *TV = UndefValue::get(VectorType::get(IdxTy, VF, Scalable));
  Value *RuntimeVF = Builder.CreateElementCount(IdxTy, TV);

  // Chain the entry predicates taking the UF into account
  Value *PropPred = ConstantInt::getTrue(PredVecTy);
  for (unsigned i = 0; i < UF; ++i) {
    Value *Step = Builder.CreateMul(RuntimeVF, ConstantInt::get(IdxTy, i));
    Value *Idx = Builder.CreateAdd(StartIdx, Step);
    Value *SV = Builder.CreateSeriesVector({VF,Scalable}, Idx, One);
    Value *Cmp = Builder.CreateICmpULT(SV, IdxEndV);
    PropPred = Builder.CreatePropFF(PropPred, Cmp, "predicate.entry");
    EntryPreds.push_back(PropPred);
  }

  // ***************************************************************************
  // End of vector.ph
  // ***************************************************************************

  // ***************************************************************************
  // Start of vector.body
  // ***************************************************************************

  BasicBlock *Header = Lp->getHeader();
  BasicBlock *Latch = Lp->getLoopLatch();
  // As we're just creating this loop, it's possible no latch exists
  // yet. If so, use the header as this will be a single block loop.
  if (!Latch)
    Latch = Header;

  Builder.SetInsertPoint(&*Header->getFirstInsertionPt());
  setDebugLocFromInst(Builder, getDebugLocFromInstOrOperands(OldInduction));

  // Generate the induction variable.
  Induction = Builder.CreatePHI(IdxTy, 2, "index");
  for (unsigned i = 0; i < UF; ++i)
    Predicate.push_back(Builder.CreatePHI(PredVecTy, 2, "predicate"));

  // These Phis have two incoming values, but right now we only add the
  // one coming from the preheader. The other (from the loop latch block)
  // will be added in 'patchLatchBranch', after everything else has been
  // vectorized. This allows predicates from first-faulting loads or other
  // instructions to be added in before finalizing the phi.
  Induction->addIncoming(StartIdx, Lp->getLoopPreheader());
  for (unsigned i = 0; i < UF; ++i)
    Predicate[i]->addIncoming(EntryPreds[i], Lp->getLoopPreheader());

  Builder.SetInsertPoint(Latch->getTerminator());

  // We don't yet have a condition for the branch, since it may depend on
  // instructions within the loop (beyond just the trip count, if any).
  // As above, this will be added in 'patchLatchBranch'.
  Value *ICmp = UndefValue::get(Builder.getInt1Ty());
  LatchBranch = Builder.CreateCondBr(ICmp, Header, Lp->getExitBlock());
  // Now we have two terminators. Remove the old one from the block.
  Latch->getTerminator()->eraseFromParent();

  // ***************************************************************************
  // End of vector.body
  // ***************************************************************************

  // ***************************************************************************
  // Start of reduction.loop.ret
  // ***************************************************************************

  // The vector body processes all elements so after the reduction we are done.
  Instruction *OldTerm = MiddleBlock->getTerminator();
  BranchInst::Create(ExitBlock, OldTerm);
  OldTerm->eraseFromParent();

  // ***************************************************************************
  // End of reduction.loop.ret
  // ***************************************************************************

  // Get ready to start creating new instructions into the vectorized body.
  Builder.SetInsertPoint(&*VecBody->getFirstInsertionPt());

  // Save the state.
  LoopVectorPreHeader = Lp->getLoopPreheader();
  LoopScalarPreHeader = ScalarPH;
  LoopMiddleBlock = MiddleBlock;
  LoopExitBlock = ExitBlock;
  LoopVectorBody.push_back(VecBody);
  VecBodyPostDom = VecBody;
  LoopScalarBody = OldBasicBlock;

  LoopVectorizeHints Hints(Lp, true, *ORE);
  Hints.setAlreadyVectorized();
}

// Fix up external users of the induction variable. At this point, we are
// in LCSSA form, with all external PHIs that use the IV having one input value,
// coming from the remainder loop. We need those PHIs to also have a correct
// value for the IV when arriving directly from the middle block.
void InnerLoopVectorizer::fixupIVUsers(PHINode *OrigPhi,
                                       const InductionDescriptor &II,
                                       Value *CountRoundDown, Value *EndValue,
                                       BasicBlock *MiddleBlock) {
  // There are two kinds of external IV usages - those that use the value
  // computed in the last iteration (the PHI) and those that use the penultimate
  // value (the value that feeds into the phi from the loop latch).
  // We allow both, but they, obviously, have different values.

  assert(OrigLoop->getExitBlock() && "Expected a single exit block");

  DenseMap<Value *, Value *> MissingVals;

  // An external user of the last iteration's value should see the value that
  // the remainder loop uses to initialize its own IV.
  Value *PostInc = OrigPhi->getIncomingValueForBlock(OrigLoop->getLoopLatch());
  for (User *U : PostInc->users()) {
    Instruction *UI = cast<Instruction>(U);
    if (!OrigLoop->contains(UI)) {
      assert(isa<PHINode>(UI) && "Expected LCSSA form");
      MissingVals[UI] = EndValue;
    }
  }

  // An external user of the penultimate value need to see EndValue - Step.
  // The simplest way to get this is to recompute it from the constituent SCEVs,
  // that is Start + (Step * (CRD - 1)).
  for (User *U : OrigPhi->users()) {
    auto *UI = cast<Instruction>(U);
    if (!OrigLoop->contains(UI)) {
      const DataLayout &DL =
          OrigLoop->getHeader()->getModule()->getDataLayout();
      assert(isa<PHINode>(UI) && "Expected LCSSA form");

      IRBuilder<> B(MiddleBlock->getTerminator());
      Value *CountMinusOne = B.CreateSub(
          CountRoundDown, ConstantInt::get(CountRoundDown->getType(), 1));
      Value *CMO = B.CreateSExtOrTrunc(CountMinusOne, II.getStep()->getType(),
                                       "cast.cmo");
      Value *Escape = II.transform(B, CMO, PSE.getSE(), DL);
      Escape->setName("ind.escape");
      MissingVals[UI] = Escape;
    }
  }

  for (auto &I : MissingVals) {
    PHINode *PHI = cast<PHINode>(I.first);
    // One corner case we have to handle is two IVs "chasing" each-other,
    // that is %IV2 = phi [...], [ %IV1, %latch ]
    // In this case, if IV1 has an external use, we need to avoid adding both
    // "last value of IV1" and "penultimate value of IV2". So, verify that we
    // don't already have an incoming value for the middle block.
    if (PHI->getBasicBlockIndex(MiddleBlock) == -1)
      PHI->addIncoming(I.second, MiddleBlock);
  }
}

namespace {
struct CSEDenseMapInfo {
  static bool canHandle(const Instruction *I) {
    return isa<InsertElementInst>(I) || isa<ExtractElementInst>(I) ||
           isa<ShuffleVectorInst>(I) || isa<GetElementPtrInst>(I);
  }
  static inline Instruction *getEmptyKey() {
    return DenseMapInfo<Instruction *>::getEmptyKey();
  }
  static inline Instruction *getTombstoneKey() {
    return DenseMapInfo<Instruction *>::getTombstoneKey();
  }
  static unsigned getHashValue(const Instruction *I) {
    assert(canHandle(I) && "Unknown instruction!");
    return hash_combine(I->getOpcode(), hash_combine_range(I->value_op_begin(),
                                                           I->value_op_end()));
  }
  static bool isEqual(const Instruction *LHS, const Instruction *RHS) {
    if (LHS == getEmptyKey() || RHS == getEmptyKey() ||
        LHS == getTombstoneKey() || RHS == getTombstoneKey())
      return LHS == RHS;
    return LHS->isIdenticalTo(RHS);
  }
};
}

///\brief Perform cse of induction variable instructions.
void InnerLoopVectorizer::CSE(SmallVector<BasicBlock *, 4> &BBs,
                              SmallSet<BasicBlock *, 2> &PredBlocks) {
  // Perform simple cse.
  SmallDenseMap<Instruction *, Instruction *, 4, CSEDenseMapInfo> CSEMap;
  for (unsigned i = 0, e = BBs.size(); i != e; ++i) {
    BasicBlock *BB = BBs[i];
    for (BasicBlock::iterator I = BB->begin(), E = BB->end(); I != E;) {
      Instruction *In = &*I++;

      if (!CSEDenseMapInfo::canHandle(In))
        continue;

      // Check if we can replace this instruction with any of the
      // visited instructions.
      if (Instruction *V = CSEMap.lookup(In)) {
        In->replaceAllUsesWith(V);
        In->eraseFromParent();
        continue;
      }

      // Ignore instructions in conditional blocks. We create "if (pred) a[i] =
      // ...;" blocks for predicated stores. Every second block is a predicated
      // block.
      if (PredBlocks.count(BBs[i]))
        continue;

      // Check if we can replace this instruction with any of the
      // visited instructions.
      if (Instruction *V = CSEMap.lookup(In)) {
        In->replaceAllUsesWith(V);
        In->eraseFromParent();
        continue;
      }

      CSEMap[In] = In;
    }
  }
}

/// Estimate the overhead of scalarizing a value. Insert and Extract are set if
/// the result needs to be inserted and/or extracted from vectors.
static unsigned getScalarizationOverhead(Instruction *I, VectorizationFactor VF,
                                         const TargetTransformInfo &TTI) {
  if (VF.Width == 1)
    return 0;

  unsigned Cost = 0;
  Type *RetTy = ToVectorTy(I->getType(), VF);
  if (!RetTy->isVoidTy() &&
      (!isa<LoadInst>(I) || !TTI.supportsEfficientVectorElementLoadStore()))
    Cost += TTI.getScalarizationOverhead(RetTy, true, false);

  if (CallInst *CI = dyn_cast<CallInst>(I)) {
    SmallVector<const Value *, 4> Operands(CI->arg_operands());
    Cost += TTI.getOperandsScalarizationOverhead(Operands, VF.Width);
  } else if (!isa<StoreInst>(I) ||
             !TTI.supportsEfficientVectorElementLoadStore()) {
    SmallVector<const Value *, 4> Operands(I->operand_values());
    Cost += TTI.getOperandsScalarizationOverhead(Operands, VF.Width);
  }

  return Cost;
}

// Estimate cost of a call instruction CI if it were vectorized with factor VF.
// Return the cost of the instruction, including scalarization overhead if it's
// needed. The flag NeedToScalarize shows if the call needs to be scalarized -
// i.e. either vector version isn't available, or is too expensive.
static unsigned getVectorCallCost(CallInst *CI, VectorizationFactor VF,
                                  const TargetTransformInfo &TTI,
                                  const TargetLibraryInfo *TLI,
                                  LoopVectorizationLegality &Legal,
                                  bool &NeedToScalarize) {
  if (VectorizeMemset && isa<MemSetInst>(CI)) {
    auto MSI = cast<MemSetInst> (CI);
    const auto Length = MSI->getLength();
    const auto IsVolatile = MSI->isVolatile();
    const auto Alignment = MSI->getAlignmentCst()->getZExtValue();
    auto CL = dyn_cast<ConstantInt>(Length);
    auto CLength = CL->getZExtValue();
    assert (CL && ( CLength% Alignment == 0)
            && ((CLength / Alignment) <= VectorizerMemSetThreshold)
            && !IsVolatile && "Invalid memset call.");
    return CLength / Alignment;
  }
  Function *F = CI->getCalledFunction();
  StringRef FnName = CI->getCalledFunction()->getName();
  Type *ScalarRetTy = CI->getType();
  SmallVector<Type *, 4> Tys, ScalarTys;
  for (auto &ArgOp : CI->arg_operands())
    ScalarTys.push_back(ArgOp->getType());

  // Estimate cost of scalarized vector call. The source operands are assumed
  // to be vectors, so we need to extract individual elements from there,
  // execute VF.Width scalar calls, and then gather the result into the vector return
  // value.
  const unsigned ScalarCallCost = TTI.getCallInstrCost(F, ScalarRetTy, ScalarTys);
  if (VF.Width == 1)
    return ScalarCallCost;

  // Compute corresponding vector type for return value and arguments.
  Type *RetTy = ToVectorTy(ScalarRetTy, VF);
  for (auto &Op : CI->arg_operands()) {
    Type *ScalarTy = Op->getType();
    if (ScalarTy->isPointerTy() && Legal.isConsecutivePtr(Op))
      Tys.push_back(ScalarTy);
    else
      Tys.push_back(ToVectorTy(ScalarTy, VF));
  }

  if (!VF.isFixed) {
    IRBuilder<> Builder(CI);
    Type *PredTy = Builder.getInt1Ty();
    Tys.push_back(ToVectorTy(PredTy, VF));
  }

  // Compute costs of unpacking argument values for the scalar calls and
  // packing the return values to a vector.
  unsigned ScalarizationCost = getScalarizationOverhead(CI, VF, TTI);
  for (unsigned i = 0, ie = Tys.size(); i != ie; ++i)
    ScalarizationCost += getScalarizationOverhead(CI, VF, TTI);

  unsigned Cost = ScalarCallCost * VF.Width + ScalarizationCost;

  // If we can't emit a vector call for this function, then the currently found
  // cost is the cost we need to return.
  NeedToScalarize = true;
  FunctionType *FTy = FunctionType::get(RetTy, Tys, false);

  if (TLI && (TLI->getVectorizedFunction(FnName, VF.Width, FTy) != ""))
    return ScalarCallCost;

  if (!TLI || !TLI->isFunctionVectorizable(FnName, VF.Width, FTy) ||
      CI->isNoBuiltin())
    return Cost;

  // If the corresponding vector cost is cheaper, return its cost.
  unsigned VectorCallCost = TTI.getCallInstrCost(nullptr, RetTy, Tys);
  if (VectorCallCost < Cost) {
    NeedToScalarize = false;
    return VectorCallCost;
  }
  return Cost;
}

// Estimate cost of an intrinsic call instruction CI if it were vectorized with
// factor VF.  Return the cost of the instruction, including scalarization
// overhead if it's needed.
static unsigned getVectorIntrinsicCost(CallInst *CI, unsigned VF,
                                       const TargetTransformInfo &TTI,
                                       const TargetLibraryInfo *TLI) {
  Intrinsic::ID ID = getVectorIntrinsicIDForCall(CI, TLI);
  assert(ID && "Expected intrinsic call!");

  Type *RetTy = ToVectorTy(CI->getType(), VF, false);
  SmallVector<Type *, 4> Tys;
  for (unsigned i = 0, ie = CI->getNumArgOperands(); i != ie; ++i)
    Tys.push_back(ToVectorTy(CI->getArgOperand(i)->getType(), VF, false));

  FastMathFlags FMF;
  if (auto *FPMO = dyn_cast<FPMathOperator>(CI))
    FMF = FPMO->getFastMathFlags();

  return TTI.getIntrinsicInstrCost(ID, RetTy, Tys, FMF);
}

static Type *smallestIntegerVectorType(Type *T1, Type *T2) {
  IntegerType *I1 = cast<IntegerType>(T1->getVectorElementType());
  IntegerType *I2 = cast<IntegerType>(T2->getVectorElementType());
  return I1->getBitWidth() < I2->getBitWidth() ? T1 : T2;
}
static Type *largestIntegerVectorType(Type *T1, Type *T2) {
  IntegerType *I1 = cast<IntegerType>(T1->getVectorElementType());
  IntegerType *I2 = cast<IntegerType>(T2->getVectorElementType());
  return I1->getBitWidth() > I2->getBitWidth() ? T1 : T2;
}

void InnerLoopVectorizer::truncateToMinimalBitwidths() {
  // For every instruction `I` in MinBWs, truncate the operands, create a
  // truncated version of `I` and reextend its result. InstCombine runs
  // later and will remove any ext/trunc pairs.
  //
  SmallPtrSet<Value *, 4> Erased;
  for (auto &KV : MinBWs) {
    VectorParts &Parts = WidenMap.get(KV.first);
    for (Value *&I : Parts) {
      if (Erased.count(I) || I->use_empty())
        continue;
      auto *OriginalTy = cast<VectorType>(I->getType());
      Type *ScalarTruncatedTy =
          IntegerType::get(OriginalTy->getContext(), KV.second);
      Type *TruncatedTy = VectorType::get(ScalarTruncatedTy,
                                          OriginalTy->getElementCount());
      if (TruncatedTy == OriginalTy)
        continue;

      if (!isa<Instruction>(I))
        continue;

      IRBuilder<> B(cast<Instruction>(I));
      auto ShrinkOperand = [&](Value *V) -> Value * {
        if (auto *ZI = dyn_cast<ZExtInst>(V))
          if (ZI->getSrcTy() == TruncatedTy)
            return ZI->getOperand(0);
        return B.CreateZExtOrTrunc(V, TruncatedTy);
      };

      // The actual instruction modification depends on the instruction type,
      // unfortunately.
      Value *NewI = nullptr;
      if (BinaryOperator *BO = dyn_cast<BinaryOperator>(I)) {
        NewI = B.CreateBinOp(BO->getOpcode(), ShrinkOperand(BO->getOperand(0)),
                             ShrinkOperand(BO->getOperand(1)));
        cast<BinaryOperator>(NewI)->copyIRFlags(I);
      } else if (ICmpInst *CI = dyn_cast<ICmpInst>(I)) {
        NewI =
            B.CreateICmp(CI->getPredicate(), ShrinkOperand(CI->getOperand(0)),
                         ShrinkOperand(CI->getOperand(1)));
      } else if (SelectInst *SI = dyn_cast<SelectInst>(I)) {
        NewI = B.CreateSelect(SI->getCondition(),
                              ShrinkOperand(SI->getTrueValue()),
                              ShrinkOperand(SI->getFalseValue()));
      } else if (CastInst *CI = dyn_cast<CastInst>(I)) {
        switch (CI->getOpcode()) {
        default:
          llvm_unreachable("Unhandled cast!");
        case Instruction::Trunc:
          NewI = ShrinkOperand(CI->getOperand(0));
          break;
        case Instruction::SExt:
          NewI = B.CreateSExtOrTrunc(
              CI->getOperand(0),
              smallestIntegerVectorType(OriginalTy, TruncatedTy));
          break;
        case Instruction::ZExt:
          NewI = B.CreateZExtOrTrunc(
              CI->getOperand(0),
              smallestIntegerVectorType(OriginalTy, TruncatedTy));
          break;
        }
      } else if (ShuffleVectorInst *SI = dyn_cast<ShuffleVectorInst>(I)) {
        auto VTy0 = cast<VectorType>(SI->getOperand(0)->getType());
        auto Elements0 = VTy0->getElementCount();
        auto *O0 = B.CreateZExtOrTrunc(
            SI->getOperand(0), VectorType::get(ScalarTruncatedTy, Elements0));
        auto VTy1 = cast<VectorType>(SI->getOperand(1)->getType());
        auto Elements1 = VTy1->getElementCount();
        auto *O1 = B.CreateZExtOrTrunc(
            SI->getOperand(1), VectorType::get(ScalarTruncatedTy, Elements1));

        NewI = B.CreateShuffleVector(O0, O1, SI->getMask());
      } else if (isa<LoadInst>(I) || isa<CallInst>(I)) {
        // Don't do anything with the operands, just extend the result.
        continue;
      } else if (auto *IE = dyn_cast<InsertElementInst>(I)) {
        auto Elements = IE->getOperand(0)->getType()->getVectorNumElements();
        auto *O0 = B.CreateZExtOrTrunc(
            IE->getOperand(0), VectorType::get(ScalarTruncatedTy, Elements));
        auto *O1 = B.CreateZExtOrTrunc(IE->getOperand(1), ScalarTruncatedTy);
        NewI = B.CreateInsertElement(O0, O1, IE->getOperand(2));
      } else if (auto *EE = dyn_cast<ExtractElementInst>(I)) {
        auto Elements = EE->getOperand(0)->getType()->getVectorNumElements();
        auto *O0 = B.CreateZExtOrTrunc(
            EE->getOperand(0), VectorType::get(ScalarTruncatedTy, Elements));
        NewI = B.CreateExtractElement(O0, EE->getOperand(2));
      } else {
        llvm_unreachable("Unhandled instruction type!");
      }

      // Lastly, extend the result.
      NewI->takeName(cast<Instruction>(I));
      Value *Res = B.CreateZExtOrTrunc(NewI, OriginalTy);
      I->replaceAllUsesWith(Res);
      cast<Instruction>(I)->eraseFromParent();
      Erased.insert(I);
      I = Res;
    }
  }

  // We'll have created a bunch of ZExts that are now parentless. Clean up.
  for (auto &KV : MinBWs) {
    VectorParts &Parts = WidenMap.get(KV.first);
    for (Value *&I : Parts) {
      ZExtInst *Inst = dyn_cast<ZExtInst>(I);
      if (Inst && Inst->use_empty()) {
        Value *NewI = Inst->getOperand(0);
        Inst->eraseFromParent();
        I = NewI;
      }
    }
  }
}

void InnerLoopVectorizer::vectorizeLoop() {
  //===------------------------------------------------===//
  //
  // Notice: any optimization or new instruction that go
  // into the code below should be also be implemented in
  // the cost-model.
  //
  //===------------------------------------------------===//
  Constant *Zero = Builder.getInt32(0);

  // In order to support recurrences we need to be able to vectorize Phi nodes.
  // Phi nodes have cycles, so we need to vectorize them in two stages. First,
  // we create a new vector PHI node with no incoming edges. We use this value
  // when we vectorize all of the instructions that use the PHI. Next, after
  // all of the instructions in the block are complete we add the new incoming
  // edges to the PHI. At this point all of the instructions in the basic block
  // are vectorized, so we can use them to construct the PHI.
  PhiVector PHIsToFix;

  // Move instructions to handle first-order recurrences.
  DenseMap<Instruction *, Instruction *> SinkAfter = Legal->getSinkAfter();
  for (auto &Entry : SinkAfter) {
    Entry.first->removeFromParent();
    Entry.first->insertAfter(Entry.second);
    DEBUG(dbgs() << "Sinking" << *Entry.first << " after" << *Entry.second
                 << " to vectorize a 1st order recurrence.\n");
  }

  // Scan the loop in a topological order to ensure that defs are vectorized
  // before users.
  LoopBlocksDFS DFS(OrigLoop);
  DFS.perform(LI);

  // Vectorize all of the blocks in the original loop.
  for (LoopBlocksDFS::RPOIterator bb = DFS.beginRPO(), be = DFS.endRPO();
       bb != be; ++bb)
    vectorizeBlockInLoop(*bb, &PHIsToFix);

  // When using predication not all elements will be modified during the current
  // iteration and so we must iterate through the reduction variables selecting
  // between the original and new values for each element.
  if (UsePredication) {
    for (auto *RdxPhi : PHIsToFix) {
      assert(RdxPhi && "Unable to recover vectorized PHI");

      if (Legal->isFirstOrderRecurrence(RdxPhi))
        continue;

      // Find the reduction variable descriptor.
      assert(Legal->getReductionVars()->count(RdxPhi) &&
             "Unable to find the reduction variable");
      RecurrenceDescriptor RdxDesc = (*Legal->getReductionVars())[RdxPhi];

      VectorParts &VecRdxPhi = WidenMap.get(RdxPhi);
      Value * LoopExitInstr = RdxDesc.getLoopExitInstr();
      VectorParts &VectorExit = getVectorValue(LoopExitInstr);

      for (unsigned Part = 0; Part < UF; ++Part) {
        if (!RdxDesc.isOrdered()) {
          Instruction *Merge = SelectInst::Create(Predicate[Part],
                                                  VectorExit[Part],
                                                  VecRdxPhi[Part]);
          Merge->insertAfter(cast<Instruction>(VectorExit[Part]));
          VectorExit[Part] = Merge;
        }
      }
    }
  }

  // Insert truncates and extends for any truncated instructions as hints to
  // InstCombine.
  if (VF > 1)
    truncateToMinimalBitwidths();

  // At this point every instruction in the original loop is widened to a
  // vector form. Now we need to fix the recurrences in PHIsToFix. These PHI
  // nodes are currently empty because we did not want to introduce cycles.
  // This is the second stage of vectorizing recurrences.
  for (PHINode *Phi : PHIsToFix) {
    assert(Phi && "Unable to recover vectorized PHI");

    // Handle first-order recurrences that need to be fixed.
    if (Legal->isFirstOrderRecurrence(Phi)) {
      fixFirstOrderRecurrence(Phi);
      continue;
    }

    // If the phi node is not a first-order recurrence, it must be a reduction.
    // Get it's reduction variable descriptor.
    assert(Legal->isReductionVariable(Phi) &&
           "Unable to find the reduction variable");
    RecurrenceDescriptor RdxDesc = (*Legal->getReductionVars())[Phi];

    RecurrenceDescriptor::RecurrenceKind RK = RdxDesc.getRecurrenceKind();
    TrackingVH<Value> ReductionStartValue = RdxDesc.getRecurrenceStartValue();
    Instruction *LoopExitInst = RdxDesc.getLoopExitInstr();
    RecurrenceDescriptor::MinMaxRecurrenceKind MinMaxKind =
        RdxDesc.getMinMaxRecurrenceKind();
    setDebugLocFromInst(Builder, ReductionStartValue);

    // We need to generate a reduction vector from the incoming scalar.
    // To do so, we need to generate the 'identity' vector and override
    // one of the elements with the incoming scalar reduction. We need
    // to do it in the vector-loop preheader.
    if (UsePredication)
      Builder.SetInsertPoint(LoopBypassBlocks[0]->getTerminator());
    else
      Builder.SetInsertPoint(LoopBypassBlocks[1]->getTerminator());

    // This is the vector-clone of the value that leaves the loop.
    VectorParts &VectorExit = getVectorValue(LoopExitInst);
    Type *VecTy = VectorExit[0]->getType();

    // Find the reduction identity variable. Zero for addition, or, xor,
    // one for multiplication, -1 for And.
    Value *Identity;
    Value *VectorStart;
    if (RK == RecurrenceDescriptor::RK_IntegerMinMax ||
        RK == RecurrenceDescriptor::RK_FloatMinMax) {
      // MinMax reduction have the start value as their identify.
      if (VF == 1) {
        VectorStart = Identity = ReductionStartValue;
      } else {
        VectorStart = Identity =
            Builder.CreateVectorSplat({VF, Scalable},
                                      RdxDesc.getRecurrenceStartValue(),
                                      "minmax.ident");
      }
    } else {
      // Handle other reduction kinds:
      Constant *Iden = RecurrenceDescriptor::getRecurrenceIdentity(
          RK, VecTy->getScalarType());
      if (VF == 1) {
        Identity = Iden;
        // This vector is the Identity vector where the first element is the
        // incoming scalar reduction.
        VectorStart = ReductionStartValue;
      } else {
        Identity = ConstantVector::getSplat({VF, Scalable}, Iden);

        // This vector is the Identity vector where the first element is the
        // incoming scalar reduction.
        VectorStart =
            Builder.CreateInsertElement(Identity, ReductionStartValue, Zero);
      }
    }

    // Fix the vector-loop phi.

    // Reductions do not have to start at zero. They can start with
    // any loop invariant values.
    VectorParts &VecRdxPhi = WidenMap.get(Phi);
    BasicBlock *Latch = OrigLoop->getLoopLatch();
    Value *LoopVal = Phi->getIncomingValueForBlock(Latch);
    VectorParts &Val = getVectorValue(LoopVal);

    for (unsigned part = 0; part < UF; ++part) {
      // Only add the reduction start value to the first unroll part.
      Value *StartVal = (part == 0) ? VectorStart : Identity;

      Value *NewVal = Val[part];
      if (RdxDesc.isOrdered() && VF > 1) {
        StartVal = Builder.CreateExtractElement(StartVal,
                                                Builder.getInt32(0));
       NewVal = Val[UF-1];
      }

      cast<PHINode>(VecRdxPhi[part])
          ->addIncoming(StartVal, LoopVectorPreHeader);
      cast<PHINode>(VecRdxPhi[part])
          ->addIncoming(NewVal, LoopVectorBody.back());
    }

    // Before each round, move the insertion point right between
    // the PHIs and the values we are going to write.
    // This allows us to write both PHINodes and the extractelement
    // instructions.
    Builder.SetInsertPoint(&*LoopMiddleBlock->getFirstInsertionPt());

    VectorParts RdxParts = getVectorValue(LoopExitInst);
    setDebugLocFromInst(Builder, LoopExitInst);

    // If the vector reduction can be performed in a smaller type, we truncate
    // then extend the loop exit value to enable InstCombine to evaluate the
    // entire expression in the smaller type.
    if (VF > 1 && Phi->getType() != RdxDesc.getRecurrenceType()) {
      Type *RdxVecTy =
          VectorType::get(RdxDesc.getRecurrenceType(), VF, Scalable);
      Builder.SetInsertPoint(LoopVectorBody.back()->getTerminator());
      for (unsigned part = 0; part < UF; ++part) {
        Value *Trunc = Builder.CreateTrunc(RdxParts[part], RdxVecTy);
        Value *Extnd = RdxDesc.isSigned() ? Builder.CreateSExt(Trunc, VecTy)
                                          : Builder.CreateZExt(Trunc, VecTy);
        for (Value::user_iterator UI = RdxParts[part]->user_begin();
             UI != RdxParts[part]->user_end();)
          if (*UI != Trunc) {
            (*UI++)->replaceUsesOfWith(RdxParts[part], Extnd);
            RdxParts[part] = Extnd;
          } else {
            ++UI;
          }
      }
      Builder.SetInsertPoint(&*LoopMiddleBlock->getFirstInsertionPt());
      for (unsigned part = 0; part < UF; ++part)
        RdxParts[part] = Builder.CreateTrunc(RdxParts[part], RdxVecTy);
    }

    // Reduce all of the unrolled parts into a single vector.
    Value *ReducedPartRdx = RdxParts[0];
    unsigned Op = RecurrenceDescriptor::getRecurrenceBinOp(RK);
    setDebugLocFromInst(Builder, ReducedPartRdx);
    if (!RdxDesc.isOrdered()) {
      for (unsigned part = 1; part < UF; ++part) {
        if (Op != Instruction::ICmp && Op != Instruction::FCmp)
          // Floating point operations had to be 'fast' to enable the reduction.
          ReducedPartRdx = addFastMathFlag(
              Builder.CreateBinOp((Instruction::BinaryOps)Op, RdxParts[part],
                                  ReducedPartRdx, "bin.rdx"));
        else
          ReducedPartRdx = RecurrenceDescriptor::createMinMaxOp(
              Builder, MinMaxKind, ReducedPartRdx, RdxParts[part]);
      }
    } else {
      // for ordered reduction get the result of the last unrolled
      // instruction
      ReducedPartRdx=RdxParts[UF-1];
    }

    if ((VF > 1) && !isScalable() && !RdxDesc.isOrdered()) {
      // VF is a power of 2 so we can emit the reduction using log2(VF) shuffles
      // and vector ops, reducing the set of values being computed by half each
      // round.
      assert(isPowerOf2_32(VF) &&
             "Reduction emission only supported for pow2 vectors!");
      Value *TmpVec = ReducedPartRdx;
      SmallVector<Constant *, 32> ShuffleMask(VF, nullptr);
      for (unsigned i = VF; i != 1; i >>= 1) {
        // Move the upper half of the vector to the lower half.
        for (unsigned j = 0; j != i / 2; ++j)
          ShuffleMask[j] = Builder.getInt32(i / 2 + j);

        // Fill the rest of the mask with undef.
        std::fill(&ShuffleMask[i / 2], ShuffleMask.end(),
                  UndefValue::get(Builder.getInt32Ty()));

        Value *Shuf = Builder.CreateShuffleVector(
            TmpVec, UndefValue::get(TmpVec->getType()),
            ConstantVector::get(ShuffleMask), "rdx.shuf");

        if (Op != Instruction::ICmp && Op != Instruction::FCmp) {
          // Floating point operations had to be 'fast' to enable the reduction.
          TmpVec = addFastMathFlag(Builder.CreateBinOp(
              (Instruction::BinaryOps)Op, TmpVec, Shuf, "bin.rdx"));
        }
        else
          TmpVec = RecurrenceDescriptor::createMinMaxOp(Builder, MinMaxKind,
                                                        TmpVec, Shuf);
      }

      // The result is in the first element of the vector.
      ReducedPartRdx =
          Builder.CreateExtractElement(TmpVec, Builder.getInt32(0));
    }

    // Compute vector reduction for scalable vectors
    if ((VF > 1) && isScalable() && !RdxDesc.isOrdered()) {
      bool NoNaN = Legal->hasNoNaNAttr();
      ReducedPartRdx =
          createTargetReduction(Builder, TTI, RdxDesc, ReducedPartRdx, NoNaN);
    }

    if (VF > 1) {
      // If the reduction can be performed in a smaller type, we need to extend
      // the reduction to the wider type before we branch to the original loop.
      if (Phi->getType() != RdxDesc.getRecurrenceType())
        ReducedPartRdx =
            RdxDesc.isSigned()
                ? Builder.CreateSExt(ReducedPartRdx, Phi->getType())
                : Builder.CreateZExt(ReducedPartRdx, Phi->getType());
    }

    // Create a phi node that merges control-flow from the backedge-taken check
    // block and the middle block.
    PHINode *BCBlockPhi = PHINode::Create(Phi->getType(), 2, "bc.merge.rdx",
                                          LoopScalarPreHeader->getTerminator());
    for (unsigned I = 0, E = LoopBypassBlocks.size(); I != E; ++I)
      BCBlockPhi->addIncoming(ReductionStartValue, LoopBypassBlocks[I]);

    // When using predication the vector loop performs all iterations.
    if (!UsePredication)
      BCBlockPhi->addIncoming(ReducedPartRdx, LoopMiddleBlock);

    // If there were stores of the reduction value to a uniform memory address
    // inside the loop, create the final store here.
    if (StoreInst *SI = RdxDesc.IntermediateStore) {
      Builder.SetInsertPoint(LoopMiddleBlock->getTerminator());
      StoreInst *NewSI = Builder.CreateStore(ReducedPartRdx,
                                             SI->getPointerOperand());
      propagateMetadata(NewSI, SI);

      // If the reduction value is used in other places,
      // then let the code below create PHI's for that.
    }

    // Now, we need to fix the users of the reduction variable
    // inside and outside of the scalar remainder loop.
    // We know that the loop is in LCSSA form. We need to update the
    // PHI nodes in the exit blocks.
    for (BasicBlock::iterator LEI = LoopExitBlock->begin(),
                              LEE = LoopExitBlock->end();
         LEI != LEE; ++LEI) {
      PHINode *LCSSAPhi = dyn_cast<PHINode>(LEI);
      if (!LCSSAPhi)
        break;

      // All PHINodes need to have a single entry edge, or two if
      // we already fixed them.
      assert(LCSSAPhi->getNumIncomingValues() < 3 && "Invalid LCSSA PHI");

      // We found our reduction value exit-PHI. Update it with the
      // incoming bypass edge.
      if (LCSSAPhi->getIncomingValue(0) == LoopExitInst) {
        // Add an edge coming from the bypass.
        LCSSAPhi->addIncoming(ReducedPartRdx, LoopMiddleBlock);
      }
    } // end of the LCSSA phi scan.

    // Fix the scalar loop reduction variable with the incoming reduction sum
    // from the vector body and from the backedge value.
    int IncomingEdgeBlockIdx =
        Phi->getBasicBlockIndex(OrigLoop->getLoopLatch());
    assert(IncomingEdgeBlockIdx >= 0 && "Invalid block index");
    // Pick the other block.
    int SelfEdgeBlockIdx = (IncomingEdgeBlockIdx ? 0 : 1);
    Phi->setIncomingValue(SelfEdgeBlockIdx, BCBlockPhi);
    Phi->setIncomingValue(IncomingEdgeBlockIdx, LoopExitInst);
  } // end of for each Phi in PHIsToFix.

  // Make sure DomTree is updated.
  updateAnalysis();

  // Fix-up external users of the induction variables.
  for (auto &Entry : *Legal->getInductionVars())
    fixupIVUsers(Entry.first, Entry.second,
                 getOrCreateVectorTripCount(LI->getLoopFor(LoopVectorBody.front())),
                 IVEndValues[Entry.first], LoopMiddleBlock);

  fixLCSSAPHIs();

  // Predicate any stores.
  for (auto KV : PredicatedStores) {
    BasicBlock::iterator I(KV.first);
    auto *BB = SplitBlock(I->getParent(), &*std::next(I), DT, LI);
    auto *T = SplitBlockAndInsertIfThen(KV.second, &*I, /*Unreachable=*/false,
                                        /*BranchWeights=*/nullptr, DT, LI);
    I->moveBefore(T);
    I->getParent()->setName("pred.store.if");
    BB->setName("pred.store.continue");
  }
  DEBUG(DT->verifyDomTree());
  // Remove redundant induction instructions.
  CSE(LoopVectorBody, PredicatedBlocks);
}

void InnerLoopVectorizer::fixFirstOrderRecurrence(PHINode *Phi) {

  // This is the second phase of vectorizing first-order recurrences. An
  // overview of the transformation is described below. Suppose we have the
  // following loop.
  //
  //   for (int i = 0; i < n; ++i)
  //     b[i] = a[i] - a[i - 1];
  //
  // There is a first-order recurrence on "a". For this loop, the shorthand
  // scalar IR looks like:
  //
  //   scalar.ph:
  //     s_init = a[-1]
  //     br scalar.body
  //
  //   scalar.body:
  //     i = phi [0, scalar.ph], [i+1, scalar.body]
  //     s1 = phi [s_init, scalar.ph], [s2, scalar.body]
  //     s2 = a[i]
  //     b[i] = s2 - s1
  //     br cond, scalar.body, ...
  //
  // In this example, s1 is a recurrence because it's value depends on the
  // previous iteration. In the first phase of vectorization, we created a
  // temporary value for s1. We now complete the vectorization and produce the
  // shorthand vector IR shown below (for VF = 4, UF = 1).
  //
  //   vector.ph:
  //     v_init = vector(..., ..., ..., a[-1])
  //     br vector.body
  //
  //   vector.body
  //     i = phi [0, vector.ph], [i+4, vector.body]
  //     v1 = phi [v_init, vector.ph], [v2, vector.body]
  //     v2 = a[i, i+1, i+2, i+3];
  //     v3 = vector(v1(3), v2(0, 1, 2))
  //     b[i, i+1, i+2, i+3] = v2 - v3
  //     br cond, vector.body, middle.block
  //
  //   middle.block:
  //     x = v2(3)
  //     br scalar.ph
  //
  //   scalar.ph:
  //     s_init = phi [x, middle.block], [a[-1], otherwise]
  //     br scalar.body
  //
  // After execution completes the vector loop, we extract the next value of
  // the recurrence (x) to use as the initial value in the scalar loop.

  // Get the original loop preheader and single loop latch.
  auto *Preheader = OrigLoop->getLoopPreheader();
  auto *Latch = OrigLoop->getLoopLatch();

  // Get the initial and previous values of the scalar recurrence.
  auto *ScalarInit = Phi->getIncomingValueForBlock(Preheader);
  auto *Previous = Phi->getIncomingValueForBlock(Latch);

  auto *IdxTy = Builder.getInt32Ty();
  auto *EC = getElementCount(IdxTy, VF, Scalable);
  auto *One = ConstantInt::get(IdxTy, 1);
  auto *LastIdx = Builder.CreateBinOp(Instruction::Sub, EC, One);

  // Create a vector from the initial value.
  auto *VectorInit = ScalarInit;
  if (VF > 1) {
    Builder.SetInsertPoint(LoopVectorPreHeader->getTerminator());
    VectorInit = Builder.CreateInsertElement(
        UndefValue::get(VectorType::get(VectorInit->getType(), VF, Scalable)),
        VectorInit, LastIdx, "vector.recur.init");
  }

  // We constructed a temporary phi node in the first phase of vectorization.
  // This phi node will eventually be deleted.
  auto &PhiParts = getVectorValue(Phi);
  Builder.SetInsertPoint(cast<Instruction>(PhiParts[0]));

  // Create a phi node for the new recurrence. The current value will either be
  // the initial value inserted into a vector or loop-varying vector value.
  auto *VecPhi = Builder.CreatePHI(VectorInit->getType(), 2, "vector.recur");
  VecPhi->addIncoming(VectorInit, LoopVectorPreHeader);

  // Get the vectorized previous value. We ensured the previous values was an
  // instruction when detecting the recurrence.
  auto &PreviousParts = getVectorValue(Previous);

  // Set the insertion point to be after this instruction. We ensured the
  // previous value dominated all uses of the phi when detecting the
  // recurrence.
  Builder.SetInsertPoint(
      &*++BasicBlock::iterator(cast<Instruction>(PreviousParts[UF - 1])));

  // We will construct a vector for the recurrence by combining the values for
  // the current and previous iterations. This is the required shuffle mask.
  auto *ShuffleMask = Builder.CreateSeriesVector({VF, Scalable},
                                                 LastIdx, One);

  // The vector from which to take the initial value for the current iteration
  // (actual or unrolled). Initially, this is the vector phi node.
  Value *Incoming = VecPhi;

  // Shuffle the current and previous vector and update the vector parts.
  for (unsigned Part = 0; Part < UF; ++Part) {
    auto *Shuffle =
        VF > 1
            ? Builder.CreateShuffleVector(Incoming, PreviousParts[Part],
                                          ShuffleMask)
            : Incoming;
    PhiParts[Part]->replaceAllUsesWith(Shuffle);
    cast<Instruction>(PhiParts[Part])->eraseFromParent();
    PhiParts[Part] = Shuffle;
    Incoming = PreviousParts[Part];
  }

  // Fix the latch value of the new recurrence in the vector loop.
  VecPhi->addIncoming(Incoming,
                      LI->getLoopFor(LoopVectorBody[0])->getLoopLatch());

  // Extract the last vector element in the middle block. This will be the
  // initial value for the recurrence when jumping to the scalar loop.
  auto *Extract = Incoming;
  if (VF > 1) {
    Builder.SetInsertPoint(LoopMiddleBlock->getTerminator());
    Extract = Builder.CreateExtractElement(Extract, LastIdx,
                                           "vector.recur.extract");
  }

  // Fix the initial value of the original recurrence in the scalar loop.
  Builder.SetInsertPoint(&*LoopScalarPreHeader->begin());
  auto *Start = Builder.CreatePHI(Phi->getType(), 2, "scalar.recur.init");
  for (auto *BB : predecessors(LoopScalarPreHeader)) {
    auto *Incoming = BB == LoopMiddleBlock ? Extract : ScalarInit;
    Start->addIncoming(Incoming, BB);
  }

  Phi->setIncomingValue(Phi->getBasicBlockIndex(LoopScalarPreHeader), Start);
  Phi->setName("scalar.recur");

  // Finally, fix users of the recurrence outside the loop. The users will need
  // either the last value of the scalar recurrence or the last value of the
  // vector recurrence we extracted in the middle block. Since the loop is in
  // LCSSA form, we just need to find the phi node for the original scalar
  // recurrence in the exit block, and then add an edge for the middle block.
  for (auto &I : *LoopExitBlock) {
    auto *LCSSAPhi = dyn_cast<PHINode>(&I);
    if (!LCSSAPhi)
      break;
    if (LCSSAPhi->getIncomingValue(0) == Phi) {
      LCSSAPhi->addIncoming(Extract, LoopMiddleBlock);
      break;
    }
  }
}

void InnerLoopVectorizer::fixLCSSAPHIs() {
  for (BasicBlock::iterator LEI = LoopExitBlock->begin(),
                            LEE = LoopExitBlock->end();
       LEI != LEE; ++LEI) {
    PHINode *LCSSAPhi = dyn_cast<PHINode>(LEI);
    if (!LCSSAPhi)
      break;
    if (LCSSAPhi->getNumIncomingValues() == 1)
      LCSSAPhi->addIncoming(UndefValue::get(LCSSAPhi->getType()),
                            LoopMiddleBlock);
  }
}

InnerLoopVectorizer::VectorParts
InnerLoopVectorizer::createEdgeMask(BasicBlock *Src, BasicBlock *Dst) {
  assert(std::find(pred_begin(Dst), pred_end(Dst), Src) != pred_end(Dst) &&
         "Invalid edge");

  // Look for cached value.
  std::pair<BasicBlock *, BasicBlock *> Edge(Src, Dst);
  EdgeMaskCache::iterator ECEntryIt = MaskCache.find(Edge);
  if (ECEntryIt != MaskCache.end())
    return ECEntryIt->second;

  VectorParts SrcMask = createBlockInMask(Src);

  // The terminator has to be a branch inst!
  BranchInst *BI = dyn_cast<BranchInst>(Src->getTerminator());
  assert(BI && "Unexpected terminator found");

  if (BI->isConditional()) {
    VectorParts EdgeMask = getVectorValue(BI->getCondition());

    if (BI->getSuccessor(0) != Dst)
      for (unsigned part = 0; part < UF; ++part)
        EdgeMask[part] = Builder.CreateNot(EdgeMask[part]);

    for (unsigned part = 0; part < UF; ++part)
      EdgeMask[part] = Builder.CreateAnd(EdgeMask[part], SrcMask[part]);

    MaskCache[Edge] = EdgeMask;
    return EdgeMask;
  }

  MaskCache[Edge] = SrcMask;
  return SrcMask;
}

InnerLoopVectorizer::VectorParts
InnerLoopVectorizer::createBlockInMask(BasicBlock *BB) {
  assert(OrigLoop->contains(BB) && "Block is not a part of a loop");

  // Loop incoming mask is all-one.
  if (OrigLoop->getHeader() == BB) {
    Value *C = ConstantInt::get(IntegerType::getInt1Ty(BB->getContext()), 1);
    return getVectorValue(C);
  }

  // This is the block mask. We OR all incoming edges, and with zero.
  Value *Zero = ConstantInt::get(IntegerType::getInt1Ty(BB->getContext()), 0);
  VectorParts BlockMask = getVectorValue(Zero);

  // For each pred:
  for (pred_iterator it = pred_begin(BB), e = pred_end(BB); it != e; ++it) {
    VectorParts EM = createEdgeMask(*it, BB);
    for (unsigned part = 0; part < UF; ++part)
      BlockMask[part] = Builder.CreateOr(BlockMask[part], EM[part]);
  }

  return BlockMask;
}

void InnerLoopVectorizer::widenPHIInstruction(
    Instruction *PN, InnerLoopVectorizer::VectorParts &Entry, unsigned UF,
    unsigned VF, PhiVector *PV) {
  PHINode *P = cast<PHINode>(PN);
  // Handle recurrences.
  if (Legal->isReductionVariable(P) || Legal->isFirstOrderRecurrence(P)) {
    for (unsigned part = 0; part < UF; ++part) {
      // This is phase one of vectorizing PHIs.
      RecurrenceDescriptor RdxDesc = (*Legal->getReductionVars())[P];

      Type *VecTy = (VF == 1 || RdxDesc.isOrdered())
                        ? PN->getType()
                        : VectorType::get(PN->getType(), VF, Scalable);
      Entry[part] = PHINode::Create(VecTy, 2, "vec.phi",
                                    &*LoopVectorBody[0]->getFirstInsertionPt());
    }
    PV->push_back(P);
    return;
  }

  setDebugLocFromInst(Builder, P);
  // Check for PHI nodes that are lowered to vector selects.
  if (P->getParent() != OrigLoop->getHeader()) {
    // We know that all PHIs in non-header blocks are converted into
    // selects, so we don't have to worry about the insertion order and we
    // can just use the builder.
    // At this point we generate the predication tree. There may be
    // duplications since this is a simple recursive scan, but future
    // optimizations will clean it up.

    unsigned NumIncoming = P->getNumIncomingValues();

    // If the value is an exit value of a strictly ordered reduction,
    // skip this PHI node since the inputs to the reduction, as well as
    // the reduction itself, will already have been predicated.
    for (auto &Reduction : *Legal->getReductionVars()) {
      RecurrenceDescriptor DS = Reduction.second;
      auto LoopExitInstr = DS.getLoopExitInstr();
      if (LoopExitInstr == PN && DS.isOrdered()) {
        Value *V = DS.getUnsafeAlgebraInst();
        for (unsigned part = 0; part < UF; ++part)
           Entry[part] = getVectorValue(V)[part];
        return;
      }
    }

    // Generate a sequence of selects of the form:
    // SELECT(Mask3, In3,
    //      SELECT(Mask2, In2,
    //                   ( ...)))
    for (unsigned In = 0; In < NumIncoming; In++) {
      VectorParts Cond =
          createEdgeMask(P->getIncomingBlock(In), P->getParent());
      VectorParts &In0 = getVectorValue(P->getIncomingValue(In));

      for (unsigned part = 0; part < UF; ++part) {
        // We might have single edge PHIs (blocks) - use an identity
        // 'select' for the first PHI operand.
        if (In == 0)
          Entry[part] = Builder.CreateSelect(Cond[part], In0[part], In0[part]);
        else
          // Select between the current value and the previous incoming edge
          // based on the incoming mask.
          Entry[part] = Builder.CreateSelect(Cond[part], In0[part], Entry[part],
                                             "predphi");
      }
    }
    return;
  }

  // This PHINode must be an induction variable.
  // Make sure that we know about it.
  assert(Legal->getInductionVars()->count(P) && "Not an induction variable");

  InductionDescriptor II = Legal->getInductionVars()->lookup(P);
  const DataLayout &DL = OrigLoop->getHeader()->getModule()->getDataLayout();

  // FIXME: The newly created binary instructions should contain nsw/nuw flags,
  // which can be found from the original scalar operations.
  switch (II.getKind()) {
  case InductionDescriptor::IK_NoInduction:
    llvm_unreachable("Unknown induction");
  case InductionDescriptor::IK_IntInduction: {
    Type *PhiTy = P->getType();
    assert(P->getType() == II.getStartValue()->getType() && "Types must match");
    // Handle other induction variables that are now based on the
    // canonical one.
    Value *V = Induction;
    if (P != OldInduction || VF == 1) {
      // Handle other induction variables that are now based on the
      // canonical one.
      if (P != OldInduction) {
        V = Builder.CreateSExtOrTrunc(Induction, PhiTy);
        V = II.transform(Builder, V, PSE.getSE(), DL);
        V->setName("offset.idx");
      }
      Value *Broadcasted = getBroadcastInstrs(V);
      Value *NumEls = getElementCount(PhiTy, VF, Scalable, PhiTy);
      // After broadcasting the induction variable we need to make the vector
      // consecutive by adding 0, 1, 2, etc.
      for (unsigned part = 0; part < UF; ++part) {
        Value *Part = ConstantInt::get(PhiTy, part);
        Value *StartIdx = Builder.CreateMul(NumEls, Part);
        Entry[part] = getStepVector(Broadcasted, StartIdx, II.getStep());
      }
    } else {
      // Instead of re-creating the vector IV by splatting the scalar IV
      // in each iteration, we can make a new independent vector IV.
      widenInductionVariable(II, Entry);
    }
    return;
  }
  case InductionDescriptor::IK_FpInduction: {
    Type *PhiTy = P->getType();
    Value *V = Builder.CreateCast(Instruction::SIToFP, Induction, P->getType());
    V = II.transform(Builder, V, PSE.getSE(), DL);
    V->setName("fp.offset.idx");
    Value *Broadcasted = getBroadcastInstrs(V);
    Value *NumEls = getElementCount(PhiTy, VF, Scalable);
    for (unsigned part = 0; part < UF; ++part) {
      Value *Part = Builder.getInt32(part);
      Value *StartIdx = Builder.CreateMul(NumEls, Part);
      auto *StepVal = cast<SCEVUnknown>(II.getStep())->getValue();
      Entry[part] = getStepVector(Broadcasted, StartIdx, StepVal,
                                  II.getInductionOpcode());
    }
    return;
  }
  case InductionDescriptor::IK_PtrInduction: {
    // Handle the pointer induction variable case.
    assert(P->getType()->isPointerTy() && "Unexpected type.");
    // This is the normalized GEP that starts counting at zero.
    Value *PtrInd = Induction;
    PtrInd = Builder.CreateSExtOrTrunc(PtrInd, II.getStep()->getType());

    if (!isScalable()) {
      // This is the vector of results. Notice that we don't generate
      // vector geps because scalar geps result in better code.
      for (unsigned part = 0; part < UF; ++part) {
        if (VF == 1) {
          int EltIndex = part;
          Constant *Idx = ConstantInt::get(PtrInd->getType(),EltIndex);
          Value *GlobalIdx = Builder.CreateAdd(PtrInd, Idx);
          Value *SclrGep = II.transform(Builder, GlobalIdx, PSE.getSE(), DL);
          SclrGep->setName("next.gep");
          Entry[part] = SclrGep;
          continue;
        }

        Value *VecVal = UndefValue::get(VectorType::get(P->getType(), VF));
        for (unsigned int i = 0; i < VF; ++i) {
          int EltIndex = i + part * VF;
          Constant *Idx = ConstantInt::get(PtrInd->getType(),EltIndex);
          Value *GlobalIdx = Builder.CreateAdd(PtrInd, Idx);
          Value *SclrGep = II.transform(Builder, GlobalIdx, PSE.getSE(), DL);
          SclrGep->setName("next.gep");
          VecVal = Builder.CreateInsertElement(VecVal, SclrGep,
                                               Builder.getInt32(i),
                                               "insert.gep");
        }
        Entry[part] = VecVal;
      }
    } else {
      Type *PhiTy = PtrInd->getType();
      Value *NumEls = getElementCount(P->getType(), VF, Scalable, PhiTy);

      Value *StepValue;
      ScalarEvolution *SE = PSE.getSE();
      const DataLayout &DL = PN->getModule()->getDataLayout();
      SCEVExpander Expander(*SE, DL, "seriesgep");

      if (Legal->getInductionVars()->count(P)) {
        const SCEV *Step = Legal->getInductionVars()->lookup(P).getStep();
        StepValue = Expander.expandCodeFor(Step, Step->getType(),
                                           &*Builder.GetInsertPoint());
      } else {
        auto *SAR = dyn_cast<SCEVAddRecExpr>(SE->getSCEV(PN));
        assert(SAR && SAR->isAffine() && "Pointer induction not loop affine");

        // Expand step and start value (the latter in preheader)
        const SCEV *StepRec = SAR->getStepRecurrence(*SE);
        StepValue = Expander.expandCodeFor(StepRec, StepRec->getType(),
                                                  &*Builder.GetInsertPoint());
        // Normalize step to be in #elements, not bytes
        Type *ElemTy = PN->getType()->getPointerElementType();
        Value *Tmp = ConstantInt::get(StepValue->getType(),
                                      DL.getTypeAllocSize(ElemTy));
        StepValue = Builder.CreateSDiv(StepValue, Tmp);
      }

      for (unsigned part = 0; part < UF; ++part) {
        Value *Part = ConstantInt::get(PhiTy, part);
        Value *Idx = Builder.CreateMul(NumEls, Part);
        Value *GlobalIdx = Builder.CreateAdd(PtrInd, Idx);
        Value *SclrGep = II.transform(Builder, GlobalIdx, SE, DL);
        SclrGep->setName("next.gep");
        Value *Offs = Builder.CreateSeriesVector({VF,Scalable},
            ConstantInt::get(StepValue->getType(), 0), StepValue);
        Entry[part] = Builder.CreateGEP(SclrGep, Offs);
        Entry[part]->setName("vector.gep");
      }
    }
    return;
  }
  }
}

// Vectorize GEP as arithmetic instructions.
//
// This is required when a given GEP is not used for a load/store operation,
// but rather to implement pointer arithmetic. In this case, the pointer may
// be a vector of pointers (e.g. resulting from a load).
//
// This function makes a ptrtoint->arith->inttoptr transformation.
//
//      extern char * reg_names[];
//      void foo(void) {
//        for (int i = 0; i < K; i++)
//          reg_names[i]--;
//      }
//
//      %1 = getelementptr inbounds [0 x i8*]* @reg_names, i64 0, i64 %0
//      %2 = bitcast i8** %1 to <n x 8 x i8*>*
//      %wide.load = load <n x 8 x i8*>* %2, align 8, !tbaa !1
//      %3 = ptrtoint <n x 8 x i8*> %wide.load to <n x 8 x i64>
//      %4 = add <n x 8 x i64> %3, seriesvector (i64 -1, i64 0)
//      %5 = inttoptr <n x 8 x i64> %4 to <n x 8 x i8*>
//      %6 = bitcast i8** %1 to <n x 8 x i8*>*
//      store <n x 8 x i8*> %5, <n x 8 x i8*>* %6, align 8, !tbaa !1
void InnerLoopVectorizer::vectorizeArithmeticGEP(Instruction *Instr) {
  assert(isa<GetElementPtrInst>(Instr) && "Instr is not a GEP");
  GetElementPtrInst *GEP = static_cast<GetElementPtrInst *>(Instr);

  // Used types for inttoptr/ptrtoint transform
  Type *OrigPtrType = GEP->getType();
  const DataLayout &DL = GEP->getModule()->getDataLayout();
  Type *IntPtrType = DL.getIntPtrType(GEP->getType());

  // Constant and Variable elements are kept separate to allow IRBuilder
  // to fold the constant before widening it to a vector.
  VectorParts &Base = getVectorValue(GEP->getPointerOperand());
  VectorParts &Res = WidenMap.get(Instr);

  for (unsigned Part = 0; Part < UF; ++Part) {
    // Pointer To Int (pointer operand)
    Res[Part] = Builder.CreatePtrToInt(
        Base[Part], VectorType::get(IntPtrType, VF, Scalable));

    // Collect constants and split up the GEP expression into an arithmetic one.
    Value *Cst = ConstantInt::get(IntPtrType, 0, false);
    gep_type_iterator GTI = gep_type_begin(*GEP);
    for (unsigned I = 1, E = GEP->getNumOperands(); I != E; ++I, ++GTI) {
      // V is still scalar
      Value *V = GEP->getOperand(I);

      if (StructType *STy = GTI.getStructTypeOrNull()) {
        // Struct type, get field offset in bytes. Result is always a constant.
        assert(isa<ConstantInt>(V) && "Field offset must be constant");

        ConstantInt *CI = static_cast<ConstantInt *>(V);
        unsigned ByteOffset =
               DL.getStructLayout(STy)->getElementOffset(CI->getLimitedValue());
        V = ConstantInt::get(IntPtrType, ByteOffset, false);
      } else {
        // First transform index to pointer-type
        if (V->getType() != IntPtrType)
          V = Builder.CreateIntCast(V, IntPtrType, true, "idxprom");

        Value *TypeAllocSize = ConstantInt::get(
            V->getType(), DL.getTypeAllocSize(GTI.getIndexedType()), true);
        // Only widen non-constant offsets
        if (isa<Constant>(V))
          V = Builder.CreateMul(V, TypeAllocSize);
        else
          V = Builder.CreateMul(getVectorValue(V)[Part],
                                getVectorValue(TypeAllocSize)[Part]);
      }

      if (isa<Constant>(V))
        Cst = Builder.CreateAdd(Cst, V);
      else
        Res[Part] = Builder.CreateAdd(Res[Part], V);
    }

    // Add constant part and create final conversion to original type
    Res[Part] = Builder.CreateAdd(Res[Part], getVectorValue(Cst)[Part]);
    Res[Part] = Builder.CreateIntToPtr(
        Res[Part], VectorType::get(OrigPtrType, VF, Scalable));
  }
}

void InnerLoopVectorizer::patchLatchBranch(BranchInst *Br) {
  assert(UsePredication && "Expect predicate to drive loop termination.");
  assert(Br->getParent() == OrigLoop->getLoopLatch() &&
         "Non-latch branch cannot be patched");

  BasicBlock *LastBB = LoopVectorBody.back();
  // TODO: Shouldn't need to create new step + compare, just work with
  // existing compare? does propff do what we want? better to expose
  // partitioning instrs directly?

  // For now, we've just copied the original createEmptyLoopWithPredication
  // logic of generating a predicate solely from the (known) trip count.

  // When using predication the number of elements processed per iteration
  // becomes a runtime quantity.  However, index.next is calculated making the
  // assumption that a whole vector's worth of elements are processed, which
  // today is true for all but the last iteration.  This means index.next can
  // potentially be larger than that within the original loop, which prevents
  // the propagation of the original's wrapping knowldge.
  //
  // Instead we use scalar evolution to determine the wrapping behaviour of the
  // vector loop's index.next so later passes can optimise our control flow.
  // TODO: Certain loops will force the requirement that index.next be accurate
  // when exiting the loop, at which point an 'active element count' will be
  // used.  However, it seems inefficient to force this requirement for loops
  // that don't need it.

  ScalarEvolution *SE = PSE.getSE();
  const SCEV *IdxEndSCEV = SE->getSCEV(IdxEnd);
  APInt MaxIdxEnd = SE->getUnsignedRange(IdxEndSCEV).getUpper() - 1;

  const SCEV *StepSCEV = SE->getSCEV(InductionStep);
  APInt MaxStep = SE->getUnsignedRange(StepSCEV).getUpper();

  bool Overflow;

  APInt T1 = MaxIdxEnd.sadd_ov(MaxStep, Overflow);
  if (!Overflow)
    T1.sadd_ov(MaxStep, Overflow);
  bool NSW = !Overflow;

  APInt T2 = MaxIdxEnd.uadd_ov(MaxStep, Overflow);
  if (!Overflow)
    T2.uadd_ov(MaxStep, Overflow);
  bool NUW = !Overflow;

  Value *One = ConstantInt::get(Legal->getWidestInductionType(), 1);
  Type *IdxTy = Legal->getWidestInductionType();
  Value *TV = UndefValue::get(VectorType::get(IdxTy, VF, Scalable));
  Value *RuntimeVF = Builder.CreateElementCount(IdxTy, TV);

  // Propagate the predicates along the interleaved vector instructions.
  // For an UF = 4, see example below, where each line represents one iteration
  // of the  unrolled loop, 'c' stands for current predicate and 'n' for next
  // predicate.
  // In each iteration, the first next predicate (n0) is propagated from last
  // iteration current predicate (c3).
  // [c0][c1][c2][c3][n0][n1][n2][n3]
  //                 [c0][c1][c2][c3][n0][n1][n2][n3]
  //                                 [c0][c1][c2][c3][n0][n1][n2][n3]
  Value *PropValue = Predicate[UF-1];
  Value *NextIdx = Builder.CreateAdd(Induction, InductionStep, "index.next",
                                     NUW, NSW);
  for (unsigned i = 0; i < UF; ++i) {
    Value *Step = Builder.CreateMul(RuntimeVF, ConstantInt::get(IdxTy, i));
    Value *Idx = Builder.CreateAdd(NextIdx, Step, "", NUW, NSW);

    // Create the next predicate taking integer overflow into account.
    Value *NextPred = Builder.CreateSeriesVector({VF,Scalable}, Idx, One);
    NextPred = Builder.CreateICmpULT(NextPred, IdxEndV);
    PropValue = Builder.CreatePropFF(PropValue, NextPred, "predicate.next");
    Predicate[i]->addIncoming(PropValue, LastBB);
  }

  // An active first element means we have more work to do.
  PHINode *FirstPredPhi = Predicate.front();
  Value *FinalTest = FirstPredPhi->getIncomingValueForBlock(LastBB);
  // Test for first lane active.
  Value *Done = Builder.CreateExtractElement(FinalTest, Builder.getInt64(0));
  Induction->addIncoming(NextIdx, LoopVectorBody.back());
  LatchBranch->setCondition(Done);

  // ----------------------------------------------------------------------
  // Generate an llvm.assume() intrinsic about the bounds of this loopvar
  // if the chosen Index value replaces induction variables with smaller
  // type and/or range. This can be used in InstCombine for better folding
  // of some cases.
  // ----------------------------------------------------------------------

  // Get the range of the induction value.
  auto IndTy = cast<IntegerType>(Induction->getType());
  APInt MinRange = MaxIdxEnd;

  // Find a loop variable with the same start/step value
  // and reduce the range if possible.
  LoopVectorizationLegality::InductionList::iterator I, E;
  LoopVectorizationLegality::InductionList *List = Legal->getInductionVars();
  for (I = List->begin(), E = List->end(); I != E; ++I) {
    // Ignore FP inductions.
    if (!I->first->getType()->isIntegerTy())
      continue;
    // Check it is a non-negative, non-wrapping AddRec.
    auto *Phi = dyn_cast<SCEVAddRecExpr>(SE->getSCEV(I->first));
    if (!Phi)
      continue;

    // Must have same step value.
    if (!Phi->getStepRecurrence(*SE)->isOne())
      continue;

    // If range is smaller, reduce.
    APInt RRange = SE->getUnsignedRange(Phi).getSetSize();
    if (MinRange.getBitWidth() > RRange.getBitWidth())
      RRange = RRange.zext(MinRange.getBitWidth());
    else if (MinRange.getBitWidth() < RRange.getBitWidth())
      MinRange = MinRange.zext(RRange.getBitWidth());
    if (RRange.ult(MinRange))
      MinRange = RRange;
  }

  ConstantInt *MaxInd = ConstantInt::get(IndTy, MinRange.getLimitedValue());
  if (MaxInd->isMaxValue(false /* unsigned */))
    return;

  // Create the assume intrinsic in the preheader (llvm.assume must
  // dominate use in order to be effective in InstCombine)
  BasicBlock::iterator IP = Builder.GetInsertPoint();
  Builder.SetInsertPoint(IP->getParent()->getFirstNonPHI());

  // Induction < minrange.Upper
  CallInst *Assumption = Builder.CreateAssumption(
      Builder.CreateICmpULT(Induction, MaxInd));
  AC->registerAssumption(Assumption);

  // Restore insertion point
  Builder.SetInsertPoint(IP->getParent(), IP);
}

bool
InnerLoopVectorizer::testHorizontalReductionExitInst(Instruction *I,
                                                     RecurrenceDescriptor &RD) {
  auto Redux = Legal->getReductionVars();

  bool Found = false;
  for (auto Red : *Redux) {
    auto RedDesc = Red.second;
    if (!RedDesc.isOrdered())
      continue;

    if (RedDesc.getLoopExitInstr() == I) {
      Found = true;
      RD = RedDesc;
      break;
    }

    // Test if this is a PHI with an input from a horizontal ordered reduction.
    auto P = dyn_cast<PHINode>(RedDesc.getLoopExitInstr());
    if (P && P->getNumIncomingValues() == 2 &&
        ((P->getIncomingValue(0) == I) || (P->getIncomingValue(1) == I))) {
      Found = true;
      RD = RedDesc;
      break;
    }
  }

  if (!Found)
    return false;

  DEBUG(dbgs() << "LV: found an ordered horizontal reduction: ";
        I->print(dbgs());
        dbgs()<< "\n");

  return true;
}

void InnerLoopVectorizer::vectorizeBlockInLoop(BasicBlock *BB, PhiVector *PV) {
  // For each instruction in the old loop.
  for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e; ++it) {
    VectorParts &Entry = WidenMap.get(&*it);

    switch (it->getOpcode()) {
    case Instruction::Br:
      if (UsePredication && BB == OrigLoop->getLoopLatch())
        patchLatchBranch(cast<BranchInst>(it));
      continue;
    case Instruction::PHI: {
      // Vectorize PHINodes.
      widenPHIInstruction(&*it, Entry, UF, VF, PV);
      continue;
    } // End of PHI.

    case Instruction::FAdd: {
      // Just widen binops.
      BinaryOperator *BinOp = dyn_cast<BinaryOperator>(it);
      setDebugLocFromInst(Builder, BinOp);
      VectorParts &A = getVectorValue(it->getOperand(0));
      VectorParts &B = getVectorValue(it->getOperand(1));

      // Use this vector value for all users of the original instruction.
      RecurrenceDescriptor RD;
      const bool isHorizontalReduction =
          testHorizontalReductionExitInst(&*it, RD);
      VectorParts Mask = createBlockInMask(it->getParent());
      for (unsigned Part = 0; Part < UF; ++Part) {
        Value *V = nullptr;

        if (!isHorizontalReduction || VF == 1) {
          V = Builder.CreateBinOp(BinOp->getOpcode(), A[Part], B[Part]);
          if (BinaryOperator *VecOp = dyn_cast<BinaryOperator>(V))
            VecOp->copyIRFlags(BinOp);
        } else {
          auto X = A[Part];
          auto Y = B[Part];
          auto XTy = X->getType();
          auto YTy = Y->getType();

          if (YTy->isVectorTy() && !XTy->isVectorTy()) {
            if (Part > 0)
              X = Entry[Part-1];
            auto P = Builder.CreateAnd(Mask[Part], Predicate[Part]);
            V = createOrderedReduction(Builder, RD, Y, X, P);
          }
          if (XTy->isVectorTy() && !YTy->isVectorTy()) {
            if (Part > 0)
              Y = Entry[Part-1];
            auto P = Builder.CreateAnd(Mask[Part], Predicate[Part]);
            V = createOrderedReduction(Builder, RD, X, Y, P);
          }
          assert(V && "cannot find the reduction intrinsic");
        }
        Entry[Part] = V;
      }

      addMetadata(Entry, &*it);
      break;
    }
    case Instruction::Add:
    case Instruction::Sub:
    case Instruction::FSub:
    case Instruction::Mul:
    case Instruction::FMul:
    case Instruction::UDiv:
    case Instruction::SDiv:
    case Instruction::FDiv:
    case Instruction::URem:
    case Instruction::SRem:
    case Instruction::FRem:
    case Instruction::Shl:
    case Instruction::LShr:
    case Instruction::AShr:
    case Instruction::And:
    case Instruction::Or:
    case Instruction::Xor: {
      // Just widen binops.
      BinaryOperator *BinOp = dyn_cast<BinaryOperator>(it);
      setDebugLocFromInst(Builder, BinOp);
      VectorParts &A = getVectorValue(it->getOperand(0));
      VectorParts &B = getVectorValue(it->getOperand(1));

      // Use this vector value for all users of the original instruction.
      for (unsigned Part = 0; Part < UF; ++Part) {
        Value *V = Builder.CreateBinOp(BinOp->getOpcode(), A[Part], B[Part]);
        if (BinaryOperator *VecOp = dyn_cast<BinaryOperator>(V))
          VecOp->copyIRFlags(BinOp);

        Entry[Part] = V;
      }

      addMetadata(Entry, &*it);
      break;
    }
    case Instruction::Select: {
      // Widen selects.
      // If the selector is loop invariant we can create a select
      // instruction with a scalar condition. Otherwise, use vector-select.
      auto *SE = PSE.getSE();
      bool InvariantCond =
          SE->isLoopInvariant(PSE.getSCEV(it->getOperand(0)), OrigLoop);
      setDebugLocFromInst(Builder, &*it);

      // The condition can be loop invariant  but still defined inside the
      // loop. This means that we can't just use the original 'cond' value.
      // We have to take the 'vectorized' value and pick the first lane.
      // Instcombine will make this a no-op.
      VectorParts &Cond = getVectorValue(it->getOperand(0));
      VectorParts &Op0 = getVectorValue(it->getOperand(1));
      VectorParts &Op1 = getVectorValue(it->getOperand(2));

      Value *ScalarCond =
          (VF == 1)
              ? Cond[0]
              : Builder.CreateExtractElement(Cond[0], Builder.getInt32(0));

      for (unsigned Part = 0; Part < UF; ++Part) {
        Entry[Part] = Builder.CreateSelect(
            InvariantCond ? ScalarCond : Cond[Part], Op0[Part], Op1[Part]);
      }

      addMetadata(Entry, &*it);
      break;
    }

    case Instruction::ICmp:
    case Instruction::FCmp: {
      // Widen compares. Generate vector compares.
      bool FCmp = (it->getOpcode() == Instruction::FCmp);
      CmpInst *Cmp = dyn_cast<CmpInst>(it);
      setDebugLocFromInst(Builder, &*it);
      VectorParts &A = getVectorValue(it->getOperand(0));
      VectorParts &B = getVectorValue(it->getOperand(1));
      for (unsigned Part = 0; Part < UF; ++Part) {
        Value *C = nullptr;
        if (FCmp) {
          C = Builder.CreateFCmp(Cmp->getPredicate(), A[Part], B[Part]);
          cast<FCmpInst>(C)->copyFastMathFlags(&*it);
        } else {
          C = Builder.CreateICmp(Cmp->getPredicate(), A[Part], B[Part]);
        }
        Entry[Part] = C;
      }

      addMetadata(Entry, &*it);
      break;
    }

    case Instruction::Store:
    case Instruction::Load:
      vectorizeMemoryInstruction(&*it);
      break;
    case Instruction::ZExt:
    case Instruction::SExt:
    case Instruction::FPToUI:
    case Instruction::FPToSI:
    case Instruction::FPExt:
    case Instruction::PtrToInt:
    case Instruction::IntToPtr:
    case Instruction::SIToFP:
    case Instruction::UIToFP:
    case Instruction::Trunc:
    case Instruction::FPTrunc:
    case Instruction::BitCast: {
      CastInst *CI = dyn_cast<CastInst>(it);
      setDebugLocFromInst(Builder, &*it);
      /// Optimize the special case where the source is a constant integer
      /// induction variable. Notice that we can only optimize the 'trunc' case
      /// because: a. FP conversions lose precision, b. sext/zext may wrap,
      /// c. other casts depend on pointer size.

      if (CI->getOperand(0) == OldInduction &&
          it->getOpcode() == Instruction::Trunc) {
        InductionDescriptor II =
            Legal->getInductionVars()->lookup(OldInduction);
        if (auto StepValue = II.getConstIntStepValue()) {
          IntegerType *TruncType = cast<IntegerType>(CI->getType());
          if (VF == 1) {
            StepValue =
                ConstantInt::getSigned(TruncType, StepValue->getSExtValue());
            Value *ScalarCast =
                Builder.CreateCast(CI->getOpcode(), Induction, CI->getType());
            Value *Broadcasted = getBroadcastInstrs(ScalarCast);
            Type* ElemTy = Broadcasted->getType()->getScalarType();
            Value* NumEls = getElementCount(ElemTy, VF, Scalable, ElemTy);
            for (unsigned Part = 0; Part < UF; ++Part) {
              Value *Start =
                  Builder.CreateMul(NumEls, ConstantInt::get(ElemTy, Part));
              Entry[Part] = getStepVector(Broadcasted, Start, StepValue);
            }
          } else {
            // Truncating a vector induction variable on each iteration
            // may be expensive. Instead, truncate the initial value, and create
            // a new, truncated, vector IV based on that.
            widenInductionVariable(II, Entry, TruncType);
          }
          addMetadata(Entry, &*it);
          break;
        }
      }
      /// Vectorize casts.
      Type *DestTy =
          (VF == 1) ? CI->getType() :
                      VectorType::get(CI->getType(), VF, Scalable);

      VectorParts &A = getVectorValue(it->getOperand(0));
      for (unsigned Part = 0; Part < UF; ++Part)
        Entry[Part] = Builder.CreateCast(CI->getOpcode(), A[Part], DestTy);
      addMetadata(Entry, &*it);
      break;
    }

    case Instruction::Call: {
      if (auto MSI = dyn_cast<MemSetInst>(it)) {
        vectorizeMemsetInstruction(MSI);
        break;
      }
      // Ignore dbg intrinsics.
      if (isa<DbgInfoIntrinsic>(it))
        break;
      setDebugLocFromInst(Builder, &*it);

      Module *M = BB->getParent()->getParent();
      CallInst *CI = cast<CallInst>(it);

      StringRef FnName = CI->getCalledFunction()->getName();
      Function *F = CI->getCalledFunction();
      Type *RetTy = ToVectorTy(CI->getType(), VF, Scalable);

      Intrinsic::ID ID =
        getVectorIntrinsicIDForCall(CI, TLI, UsePredication && VF > 1);
      if (ID &&
          (ID == Intrinsic::assume || ID == Intrinsic::lifetime_end ||
           ID == Intrinsic::lifetime_start)) {
        if (isScalable() &&
            OrigLoop->isLoopInvariant(it->getOperand(0)) &&
            OrigLoop->isLoopInvariant(it->getOperand(1)))
          Builder.Insert(it->clone());
        else
          scalarizeInstruction(&*it);
        break;
      }
      // The flag shows whether we use Intrinsic or a usual Call for vectorized
      // version of the instruction.
      // Is it beneficial to perform intrinsic call compared to lib call?
      bool NeedToScalarize;
      unsigned CallCost = getVectorCallCost(CI, {VF, 1, !isScalable()}, *TTI,
                                            TLI, *Legal, NeedToScalarize);
      NeedToScalarize = NeedToScalarize && (!isScalable());
      bool UseVectorIntrinsic =
          ID && getVectorIntrinsicCost(CI, VF, *TTI, TLI) <= CallCost;
      if (!UseVectorIntrinsic && NeedToScalarize) {
        scalarizeInstruction(&*it);
        break;
      }

      const auto IsThereAMaskParam = isMaskedVectorIntrinsic(ID);
      const bool IsPredicated = IsThereAMaskParam.first ;
      const unsigned MaskPosition = IsThereAMaskParam.second ;
      const bool CallNeedsPredication =  IsPredicated ||
	(UsePredication && TLI->isFunctionVectorizable(FnName));
      for (unsigned Part = 0; Part < UF; ++Part) {
        SmallVector<Value *, 4> Args;
        for (unsigned i = 0, ie = CI->getNumArgOperands(); i != ie; ++i) {
          Value *Arg = CI->getArgOperand(i);
          // Some intrinsics have a scalar argument - don't replace it with a
          // vector.
          if (!UseVectorIntrinsic || !hasVectorInstrinsicScalarOpd(ID, i)) {
            VectorParts &VectorArg = getVectorValue(CI->getArgOperand(i));
            Arg = VectorArg[Part];
          }
          Args.push_back(Arg);
        }

        if (CallNeedsPredication) {
          // If the intrinsic or function is maskable, then we need to pass in
          // the loop predicate.
          const SmallVectorImpl<Value *>::iterator Insert = UseVectorIntrinsic ?
            Args.begin() + MaskPosition : Args.end();
          Args.insert(Insert, Predicate[Part]);
        }

        Function *VectorF;
        if (UseVectorIntrinsic) {
          // Use vector version of the intrinsic.
          Type *TysForDecl[] = {CI->getType()};
          if (VF > 1)
            TysForDecl[0] = VectorType::get(CI->getType()->getScalarType(),
                                            VF, Scalable);
          VectorF = Intrinsic::getDeclaration(M, ID, TysForDecl);
        } else {
          SmallVector<Type *, 4> Tys;
          for (unsigned i = 0, ie = CI->getNumArgOperands(); i != ie; ++i) {
            Value *Arg = CI->getArgOperand(i);
            // Check if the argument `x` is a pointer marked by an
            // OpenMP clause `linear(x:1)`.
            if (Arg->getType()->isPointerTy() &&
                (Legal->isConsecutivePtr(Arg) == 1) &&
                isa<VectorType>(Args[i]->getType())) {
              DEBUG(dbgs() << "LV: vectorizing " << *Arg
                           << " as a linear pointer with step 1");
              Args[i] =
                  Builder.CreateExtractElement(Args[i], Builder.getInt32(0));
              Tys.push_back(Arg->getType());
            } else
              Tys.push_back(ToVectorTy(Arg->getType(), VF, Scalable));
          }

          if (CallNeedsPredication) {
            // If the intrinsic or function is maskable, then we need to pass in
            // the loop predicate type in the correct place of the signature.
            const SmallVectorImpl<Type *>::iterator Insert =
                UseVectorIntrinsic ? Tys.begin() + MaskPosition : Tys.end();
            Tys.insert(Insert, Predicate[0]->getType());
          }

          // Use vector version of the library call.
          FunctionType *FTy = FunctionType::get(RetTy, Tys, false);
          DEBUG(dbgs() << "SVE LV: Looking for a signature" << *FTy << "\n");
	  const std::string VFnName = TLI->getVectorizedFunction(FnName, VF, FTy);
          assert(!VFnName.empty() && "Vector function name is empty.");
          VectorF = M->getFunction(VFnName);
          if (!VectorF) {
            // Generate a declaration
            VectorF =
                Function::Create(FTy, Function::ExternalLinkage, VFnName, M);
            VectorF->copyAttributesFrom(F);
          }
        }
        assert(VectorF && "Can't create vector function.");

        SmallVector<OperandBundleDef, 1> OpBundles;
        CI->getOperandBundlesAsDefs(OpBundles);
        CallInst *V = Builder.CreateCall(VectorF, Args, OpBundles);

        if (isa<FPMathOperator>(V))
          V->copyFastMathFlags(CI);

        Entry[Part] = V;
      }

      addMetadata(Entry, &*it);
      break;
    }

    case Instruction::GetElementPtr:
      vectorizeGEPInstruction(&*it);
      break;

    default:
      // All other instructions are unsupported. Scalarize them.
      scalarizeInstruction(&*it);
      break;
    } // end of switch.
  }   // end of for_each instr.
}

void InnerLoopVectorizer::updateAnalysis() {
  // Forget the original basic block.
  PSE.getSE()->forgetLoop(OrigLoop);

  // Update the dominator tree information.
  assert(DT->properlyDominates(LoopBypassBlocks.front(), LoopExitBlock) &&
         "Entry does not dominate exit.");

  /*
  for (unsigned I = 1, E = LoopBypassBlocks.size(); I != E; ++I)
    DT->addNewBlock(LoopBypassBlocks[I], LoopBypassBlocks[I-1]);
  DT->addNewBlock(LoopVectorPreHeader, LoopBypassBlocks.back());
  */

  // Add dominator for first vector body block.
  DT->addNewBlock(LoopVectorBody[0], LoopVectorPreHeader);
  for (const auto &Edge : VecBodyDomEdges)
    DT->addNewBlock(Edge.second, Edge.first);

  DT->addNewBlock(LoopMiddleBlock, LoopVectorBody.back());
  DT->addNewBlock(LoopScalarPreHeader, LoopBypassBlocks[0]);
  DT->changeImmediateDominator(LoopScalarBody, LoopScalarPreHeader);
  DT->changeImmediateDominator(LoopExitBlock, LoopBypassBlocks[0]);

  DEBUG(DT->verifyDomTree());
}

/// \brief Check whether it is safe to if-convert this phi node.
///
/// Phi nodes with constant expressions that can trap are not safe to if
/// convert.
static bool canIfConvertPHINodes(BasicBlock *BB) {
  for (BasicBlock::iterator I = BB->begin(), E = BB->end(); I != E; ++I) {
    PHINode *Phi = dyn_cast<PHINode>(I);
    if (!Phi)
      return true;
    for (unsigned p = 0, e = Phi->getNumIncomingValues(); p != e; ++p)
      if (Constant *C = dyn_cast<Constant>(Phi->getIncomingValue(p)))
        if (C->canTrap())
          return false;
  }
  return true;
}

bool LoopVectorizationLegality::canVectorizeWithIfConvert() {
  bool CanIfConvert = true;

  if (!EnableIfConversion) {
    ORE->emit(createMissedAnalysis("IfConversionDisabled")
              << "if-conversion is disabled");
    DEBUG(dbgs() << "LV: Not vectorizing - if-conversion is disabled.\n");
    CanIfConvert = false;
    NODEBUG_EARLY_BAILOUT();
  }

  assert(TheLoop->getNumBlocks() > 1 && "Single block loops are vectorizable");

  // A list of pointers that we can safely read and write to.
  SmallPtrSet<Value *, 8> SafePointes;

  // Collect safe addresses.
  for (BasicBlock *BB : TheLoop->blocks()) {
    if (blockNeedsPredication(BB))
      continue;

    for (Instruction &I : *BB)
      if (auto *Ptr = getPointerOperand(&I))
        SafePointes.insert(Ptr);
  }

  // Collect the blocks that need predication.
  BasicBlock *Header = TheLoop->getHeader();
  for (BasicBlock *BB : TheLoop->blocks()) {
    // We don't support switch statements inside loops.
    if (!isa<BranchInst>(BB->getTerminator())) {
      ORE->emit(createMissedAnalysis("LoopContainsSwitch", BB->getTerminator())
                << "loop contains a switch statement");
      DEBUG(dbgs() <<
            "LV: Not vectorizing - loop contains a switch statement.\n");
      CanIfConvert = false;
      NODEBUG_EARLY_BAILOUT();
    }

    // We must be able to predicate all blocks that need to be predicated.
   BasicBlock *PredB = BB->getSinglePredecessor();
    DebugLoc CmpLoc = DebugLoc();
    if (PredB && PredB->getTerminator())
      CmpLoc = PredB->getTerminator()->getDebugLoc();

    if (blockNeedsPredication(BB)) {
      if (!blockCanBePredicated(BB, SafePointes)) {
        auto R = createMissedAnalysis("NoCFGForSelect");
        R << "control flow cannot be substituted for a select";
        if (auto *PredB = BB->getSinglePredecessor())
          R << ore::setExtraArgs() << ore::NV("Cmp", PredB->getTerminator());
        ORE->emit(R);

        DEBUG(dbgs() <<
              "LV: Not vectorizing - cannot predicate all blocks for if-conversion.\n");
        CanIfConvert = false;
        NODEBUG_EARLY_BAILOUT();
      }
    } else if (BB != Header && !canIfConvertPHINodes(BB)) {
      auto R = createMissedAnalysis("NoCFGForSelect");
      R << "control flow cannot be substituted for a select";
      if (auto *PredB = BB->getSinglePredecessor())
        R << ore::setExtraArgs() << ore::NV("Cmp", PredB->getTerminator());
      ORE->emit(R);

      DEBUG(dbgs() <<
            "LV: Not vectorizing - phi nodes cannot be if converted.\n");
      CanIfConvert = false;
      NODEBUG_EARLY_BAILOUT();
    }
  }

  // We can if-convert this loop.
  return CanIfConvert;
}

bool LoopVectorizationLegality::canVectorize() {
  bool CanVectorize = true;

  // We must have a loop in canonical form. Loops with indirectbr in them cannot
  // be canonicalized.
  if (!TheLoop->getLoopPreheader()) {
    ORE->emit(createMissedAnalysis("CFGNotUnderstood")
              << "loop control flow is not understood by vectorizer");
    return false;
  }

  // We can only vectorize innermost loops.
  if (!TheLoop->empty()) {
    ORE->emit(createMissedAnalysis("NotInnermostLoop")
              << "loop is not the innermost loop");
    DEBUG(dbgs() << "LV: Not vectorizing - not the innermost loop.\n");
    CanVectorize = false;
    NODEBUG_EARLY_BAILOUT();
  }

  // We must have a single backedge.
  if (TheLoop->getNumBackEdges() != 1) {
    ORE->emit(createMissedAnalysis("CFGNotUnderstood")
              << "loop control flow is not understood by vectorizer"
              << ore::setExtraArgs()
              << " (Reason = multiple backedges)");
    return false;
  }

  // We must have a single exiting block.
  if (!TheLoop->getExitingBlock()) {
    ORE->emit(createMissedAnalysis("CFGNotUnderstood")
              << "loop control flow is not understood by vectorizer"
              << ore::setExtraArgs()
              << " (Reason = early exits)");

    return false;
  }

  // We only handle bottom-tested loops, i.e. loop in which the condition is
  // checked at the end of each iteration. With that we can assume that all
  // instructions in the loop are executed the same number of times.
  if (TheLoop->getExitingBlock() != TheLoop->getLoopLatch()) {
    ORE->emit(createMissedAnalysis("CFGNotUnderstood")
              << "loop control flow is not understood by vectorizer");
    return false;
  }

  // We need to have a loop header.
  DEBUG(dbgs() << "LV: Found a loop: " << TheLoop->getHeader()->getName()
               << '\n');

  // Check if we can if-convert non-single-bb loops.
  unsigned NumBlocks = TheLoop->getNumBlocks();
  if (NumBlocks != 1 && !canVectorizeWithIfConvert()) {
    DEBUG(dbgs() << "LV: Not vectorizing - can't if-convert the loop.\n");
    return false;
  }

  // ScalarEvolution needs to be able to find the exit count.
  auto *SE = PSE.getSE();
  const SCEV *ExitCount = PSE.getBackedgeTakenCount();
  if (ExitCount == SE->getCouldNotCompute()) {
    ORE->emit(createMissedAnalysis("CantComputeNumberOfIterations")
              << "could not determine number of loop iterations");
    DEBUG(dbgs() <<
        "LV: Not vectorizing - SCEV could not compute the loop exit count.\n");

    return false;
  }

  // Check if we can vectorize the instructions and CFG in this loop.
  if (!canVectorizeInstrs()) {
    DEBUG(dbgs() <<
          "LV: Not vectorizing - can't vectorize the instructions or CFG.\n");
    return false;
  }

  // Go over each instruction and look at memory deps.
  if (!canVectorizeMemory()) {
    DEBUG(dbgs() <<
          "LV: Can't vectorize due to memory conflicts.\n");
    return false;
  }

  if (CanVectorize) {
    // Collect all of the variables that remain uniform after vectorization.
    collectLoopUniforms();
    DEBUG(dbgs() << "LV: We can vectorize this loop"
                 << (LAI->getRuntimePointerChecking()->Need
                         ? " (with a runtime bound check)"
                         : "")
                 << "!\n");
  }

  bool UseInterleaved = TTI->enableInterleavedAccessVectorization();

  // If an override option has been passed in for interleaved accesses, use it.
  if (EnableInterleavedMemAccesses.getNumOccurrences() > 0)
    UseInterleaved = EnableInterleavedMemAccesses;

  // Analyze interleaved memory accesses.
  if (UseInterleaved)
    InterleaveInfo.analyzeInterleaving(Strides);

  unsigned SCEVThreshold = VectorizeSCEVCheckThreshold;
  if (Hints->getForce() == LoopVectorizeHints::FK_Enabled)
    SCEVThreshold = PragmaVectorizeSCEVCheckThreshold;

  if (PSE.getUnionPredicate().getComplexity() > SCEVThreshold) {
    ORE->emit(createMissedAnalysis("TooManySCEVRunTimeChecks")
              << "Too many SCEV assumptions need to be made and checked "
              << "at runtime");
    DEBUG(dbgs() << "LV: Too many SCEV checks needed.\n");
    return false;
  }

  // Okay! We can vectorize. At this point we don't have any other mem analysis
  // which may limit our maximum vectorization factor, so just return true with
  // no restrictions.
  return CanVectorize;
}

static Type *convertPointerToIntegerType(const DataLayout &DL, Type *Ty) {
  if (Ty->isPointerTy())
    return DL.getIntPtrType(Ty);

  // It is possible that char's or short's overflow when we ask for the loop's
  // trip count, work around this by changing the type size.
  if (Ty->getScalarSizeInBits() < 32)
    return Type::getInt32Ty(Ty->getContext());

  return Ty;
}

static Type *getWiderType(const DataLayout &DL, Type *Ty0, Type *Ty1) {
  Ty0 = convertPointerToIntegerType(DL, Ty0);
  Ty1 = convertPointerToIntegerType(DL, Ty1);
  if (Ty0->getScalarSizeInBits() > Ty1->getScalarSizeInBits())
    return Ty0;
  return Ty1;
}

/// \brief Check that the instruction has outside loop users and is not an
/// identified reduction variable.
static bool hasOutsideLoopUser(const Loop *TheLoop, Instruction *Inst,
                               SmallPtrSetImpl<Value *> &AllowedExit) {
  // Reduction and Induction instructions are allowed to have exit users. All
  // other instructions must not have external users.
  if (!AllowedExit.count(Inst))
    // Check that all of the users of the loop are inside the BB.
    for (User *U : Inst->users()) {
      Instruction *UI = cast<Instruction>(U);
      // This user may be a reduction exit value.
      if (!TheLoop->contains(UI)) {
        DEBUG(dbgs() << "LV: Found an outside user " << *UI << " for : "
              << *Inst << "\n");
        return true;
      }
    }
  return false;
}

void LoopVectorizationLegality::addInductionPhi(
    PHINode *Phi, const InductionDescriptor &ID,
    SmallPtrSetImpl<Value *> &AllowedExit) {
  Inductions[Phi] = ID;
  Type *PhiTy = Phi->getType();
  const DataLayout &DL = Phi->getModule()->getDataLayout();

  // Get the widest type.
  if (!PhiTy->isFloatingPointTy()) {
    if (!WidestIndTy)
      WidestIndTy = convertPointerToIntegerType(DL, PhiTy);
    else
      WidestIndTy = getWiderType(DL, PhiTy, WidestIndTy);
  }

  // Int inductions are special because we only allow one IV.
  if (ID.getKind() == InductionDescriptor::IK_IntInduction &&
      ID.getConstIntStepValue() &&
      ID.getConstIntStepValue()->isOne() &&
      isa<Constant>(ID.getStartValue()) &&
      cast<Constant>(ID.getStartValue())->isNullValue()) {

    // Use the phi node with the widest type as induction. Use the last
    // one if there are multiple (no good reason for doing this other
    // than it is expedient). We've checked that it begins at zero and
    // steps by one, so this is a canonical induction variable.
    if (!PrimaryInduction || PhiTy == WidestIndTy)
      PrimaryInduction = Phi;
  }

  // Both the PHI node itself, and the "post-increment" value feeding
  // back into the PHI node may have external users.
  AllowedExit.insert(Phi);
  AllowedExit.insert(Phi->getIncomingValueForBlock(TheLoop->getLoopLatch()));
  
  DEBUG(dbgs() << "LV: Found an induction variable.\n");
  return;
}

bool LoopVectorizationLegality::canVectorizeInstrs() {
  BasicBlock *Header = TheLoop->getHeader();
  LAI = &(*GetLAA)(*TheLoop);

  bool CanVectorize = true;

  // Look for the attribute signaling the absence of NaNs.
  Function &F = *Header->getParent();
  HasFunNoNaNAttr =
      F.getFnAttribute("no-nans-fp-math").getValueAsString() == "true";

  // For each block in the loop.
  for (Loop::block_iterator bb = TheLoop->block_begin(),
                            be = TheLoop->block_end();
       bb != be; ++bb) {

    // Scan the instructions in the block and look for hazards.
    for (BasicBlock::iterator it = (*bb)->begin(), e = (*bb)->end(); it != e;
         ++it) {

      if (PHINode *Phi = dyn_cast<PHINode>(it)) {
        Type *PhiTy = Phi->getType();
        // Check that this PHI type is allowed.
        if (!PhiTy->isIntegerTy() && !PhiTy->isFloatingPointTy() &&
            !PhiTy->isPointerTy()) {
          ORE->emit(createMissedAnalysis("CFGNotUnderstood", Phi)
                    << "loop control flow is not understood by vectorizer");
          DEBUG(dbgs() <<
                "LV: Not vectorizing - Found an non-int non-pointer PHI.\n");
          CanVectorize = false;
          NODEBUG_EARLY_BAILOUT();
        }

        // If this PHINode is not in the header block, then we know that we
        // can convert it to select during if-conversion. No need to check if
        // the PHIs in this block are induction or reduction variables.
        if (*bb != Header) {
          // Check that this instruction has no outside users or is an
          // identified reduction value with an outside user.
          // TODO: For now, we ignore this case with uncounted loops and just
          // focus on phis created in the header block.
          if (!hasOutsideLoopUser(TheLoop, &*it, AllowedExit))
            continue;
          ORE->emit(createMissedAnalysis("NeitherInductionNorReduction", Phi)
                    << "value could not be identified as "
                    "an induction or reduction variable");
          return false;
        }

        // We only allow if-converted PHIs with exactly two incoming values.
        if (Phi->getNumIncomingValues() != 2) {
          ORE->emit(createMissedAnalysis("CFGNotUnderstood", Phi)
                    << "control flow not understood by vectorizer");
          DEBUG(dbgs() <<
                "LV: Not vectorizing - Phi with more than two incoming values.\n");
          CanVectorize = false;
          NODEBUG_EARLY_BAILOUT();
          continue;
        }

        RecurrenceDescriptor RedDes;
        if (RecurrenceDescriptor::isReductionPHI(Phi, TheLoop, PSE.getSE(),
                                                 RedDes)) {
          if (RedDes.hasUnsafeAlgebra())
            Requirements->addUnsafeAlgebraInst(RedDes.getUnsafeAlgebraInst());
          AllowedExit.insert(RedDes.getLoopExitInstr());
          Reductions[Phi] = RedDes;
          DEBUG(dbgs() << "LV: Found a reduction variable " << *Phi << "\n");
          continue;
        }

        InductionDescriptor ID;
        RecurrenceDescriptor RecTmp;
        // First we do a check to see if the phi is a recognizable reduction,
        // if not we try to handle it as an induction variable if possible.
        if (InductionDescriptor::isInductionPHI(Phi, TheLoop, PSE, ID)) {
          addInductionPhi(Phi, ID, AllowedExit);
          if (ID.hasUnsafeAlgebra() && !HasFunNoNaNAttr)
            Requirements->addUnsafeAlgebraInst(ID.getUnsafeAlgebraInst());
          continue;
        }

        if (RecurrenceDescriptor::isFirstOrderRecurrence(Phi, TheLoop,
                                                         SinkAfter, DT)) {
          FirstOrderRecurrences.insert(Phi);
          continue;
        }

        // As a last resort, coerce the PHI to a AddRec expression
        // and re-try classifying it a an induction PHI.
        if (InductionDescriptor::isInductionPHI(Phi, TheLoop, PSE, ID, true)) {
          addInductionPhi(Phi, ID, AllowedExit);
          continue;
        }

        ORE->emit(createMissedAnalysis("NonReductionValueUsedOutsideLoop", Phi)
                  << "value that could not be identified as "
                  "reduction is used outside the loop");
        DEBUG(dbgs() << "LV: Found an unidentified PHI." << *Phi << "\n");
        return false;
      } // end of PHI handling

      // We handle calls that:
      //   * Are debug info intrinsics.
      //   * Have a mapping to an IR intrinsic.
      //   * Have a vector version available.
      CallInst *CI = dyn_cast<CallInst>(it);
      if (CI && !getVectorIntrinsicIDForCall(CI, TLI) &&
          !isa<DbgInfoIntrinsic>(CI) &&
          !(CI->getCalledFunction() && TLI &&
            TLI->isFunctionVectorizable(CI->getCalledFunction()->getName()))) {
        if (auto MSI = dyn_cast<MemSetInst>(CI)) {
          if (VectorizeMemset && EnableScalableVectorisation &&
              isLegalMaskedScatter(MSI->getValue()->getType())) {
            const auto Length = MSI->getLength();
            const auto IsVolatile = MSI->isVolatile();
            // Alignment is clamped to yield an acceptable vector element type.
            const auto Alignment =
                std::min(MSI->getAlignmentCst()->getZExtValue(), (uint64_t) 8);
            auto CL = dyn_cast<ConstantInt>(Length);
            if (CL && (CL->getZExtValue() % Alignment == 0)
                && ((CL->getZExtValue() / Alignment) <=
                    VectorizerMemSetThreshold)
                && !IsVolatile) {
              DEBUG(dbgs() << "LV: Found a vectorizable 'memset':\n" << *MSI);
              continue;
            }
          }
        }
        if (CI->isInlineAsm())
          ORE->emit(createMissedAnalysis("CantVectorizeCall")
                    << "inline assembly call cannot be vectorized"
                    << ore::setExtraArgs()
                    << " (Location = " << ore::NV("Location", CI) << ")");
        else {
          auto *Callee = CI->getCalledFunction();
          std::string CalleeName = Callee ? Callee->getName() : "[?]";
          ORE->emit(createMissedAnalysis("CantVectorizeCall")
                    << "call instruction cannot be vectorized"
                    << ore::setExtraArgs()
                    << " (Callee = " << CalleeName
                    << ", Location = " << ore::NV("Location", CI) << ")");
        }

        DEBUG(dbgs() <<
              "LV: Not vectorizing - found a non-intrinsic, non-libfunc callsite " <<
              *CI << "\n");
        CanVectorize = false;

        NODEBUG_EARLY_BAILOUT();
        continue;
      }

      // Intrinsics such as powi,cttz and ctlz are legal to vectorize if the
      // second argument is the same (i.e. loop invariant)
      if (CI && hasVectorInstrinsicScalarOpd(
                    getVectorIntrinsicIDForCall(CI, TLI), 1)) {
        auto *SE = PSE.getSE();
        if (!SE->isLoopInvariant(PSE.getSCEV(CI->getOperand(1)), TheLoop)) {
          ORE->emit(createMissedAnalysis("CantVectorizeIntrinsic", CI)
                    << "intrinsic instruction cannot be vectorized");
          DEBUG(dbgs() <<
                "LV: Not vectorizing - found unvectorizable intrinsic " << *CI << "\n");
          CanVectorize = false;
          NODEBUG_EARLY_BAILOUT();
          continue;
        }
      }

      // Check that the instruction return type is vectorizable.
      // Also, we can't vectorize extractelement instructions.
      if ((!VectorType::isValidElementType(it->getType()) &&
           !it->getType()->isVoidTy()) ||
          it->getType()->isFP128Ty() ||
          isa<ExtractElementInst>(it)) {
        ORE->emit(createMissedAnalysis("CantVectorizeInstructionReturnType", &*it)
                  << "instruction return type cannot be vectorized");
        DEBUG(dbgs() << "LV: Found unvectorizable type.\n");
        DEBUG(dbgs() <<
              "LV: Not vectorizing - found unvectorizable type " <<
              *(it->getType()) << "\n");
        CanVectorize = false;
        NODEBUG_EARLY_BAILOUT();
        continue;
      }

      if (StoreInst *SI = dyn_cast<StoreInst>(it)) {
        Value *Ptr = SI->getPointerOperand();
        auto *Ty = cast<PointerType>(Ptr->getType())->getElementType();
        if (std::abs(isConsecutivePtr(Ptr)) != 1 && !LAI->isUniform(Ptr) &&
            !isLegalMaskedScatter(Ty)) {
          ORE->emit(createMissedAnalysis("CantVectorizeNonUnitStride", &*it)
                    << "non consecutive store instructions cannot be "
                    << "vectorized");
          return false;
        }
      }
      if (LoadInst *LI = dyn_cast<LoadInst>(it)) {
        Value *Ptr = LI->getPointerOperand();
        auto *Ty = cast<PointerType>(Ptr->getType())->getElementType();
        if (std::abs(isConsecutivePtr(Ptr)) != 1 && !LAI->isUniform(Ptr) &&
            !isLegalMaskedGather(Ty)) {
          ORE->emit(createMissedAnalysis("CantVectorizeNonUnitStride", &*it)
                    << "non consecutive load instructions cannot be "
                    << "vectorized");
          return false;
        }
      }
      // Check that the stored type is vectorizable.
      if (StoreInst *ST = dyn_cast<StoreInst>(it)) {
        Type *T = ST->getValueOperand()->getType();
        if (!VectorType::isValidElementType(T) || it->getType()->isFP128Ty()) {
          ORE->emit(createMissedAnalysis("CantVectorizeStore", ST)
                    << "store instruction cannot be vectorized");
          return false;
        }

        // FP instructions can allow unsafe algebra, thus vectorizable by
        // non-IEEE-754 compliant SIMD units.
        // This applies to floating-point math operations and calls, not memory
        // operations, shuffles, or casts, as they don't change precision or
        // semantics.
      } else if (it->getType()->isFloatingPointTy() &&
                 (CI || it->isBinaryOp()) && !it->hasUnsafeAlgebra()) {
        DEBUG(dbgs() << "LV: Found FP op with unsafe algebra.\n");
        Hints->setPotentiallyUnsafe();
      }

      // Reduction instructions are allowed to have exit users.
      // All other instructions must not have external users.
      //
      // For uncounted loops we do allow induction variable
      // escapees.
      if (hasOutsideLoopUser(TheLoop, &*it, AllowedExit)) {
        ORE->emit(createMissedAnalysis("ValueUsedOutsideLoop", &*it)
                  << "value cannot be used outside the loop");
        return false;
      }
    } // next instr.
  }

  if (!PrimaryInduction) {
    DEBUG(dbgs() << "LV: Did not find one integer induction var.\n");
    if (Inductions.empty()) {
      ORE->emit(createMissedAnalysis("NoInductionVariable")
                << "loop induction variable could not be identified");
      DEBUG(dbgs() <<
            "LV: Not vectorizing - unable to identify loop induction variable.\n");
      CanVectorize = false;
    }
  }

  // Now we know the widest induction type, check if our found induction
  // is the same size. If it's not, unset it here and InnerLoopVectorizer
  // will create another.
  if (PrimaryInduction && WidestIndTy != PrimaryInduction->getType())
    PrimaryInduction = nullptr;

  return CanVectorize;
}

void LoopVectorizationLegality::collectStridedAccess(Value *MemAccess) {
  Value *Ptr = nullptr;
  if (LoadInst *LI = dyn_cast<LoadInst>(MemAccess))
    Ptr = LI->getPointerOperand();
  else if (StoreInst *SI = dyn_cast<StoreInst>(MemAccess))
    Ptr = SI->getPointerOperand();
  else
    return;

  Value *Stride = getStrideFromPointer(Ptr, PSE.getSE(), TheLoop);
  if (!Stride)
    return;

  DEBUG(dbgs() << "LV: Found a strided access that we can version");
  DEBUG(dbgs() << "  Ptr: " << *Ptr << " Stride: " << *Stride << "\n");
  Strides[Ptr] = Stride;
  StrideSet.insert(Stride);
}

void LoopVectorizationLegality::collectLoopUniforms() {
  // We now know that the loop is vectorizable!
  // Collect variables that will remain uniform after vectorization.
  std::vector<Value *> Worklist;
  BasicBlock *Latch = TheLoop->getLoopLatch();

  // Start with the conditional branch and walk up the block.
  Worklist.push_back(Latch->getTerminator()->getOperand(0));

  // Also add all consecutive pointer values; these values will be uniform
  // after vectorization (and subsequent cleanup) and, until revectorization is
  // supported, all dependencies must also be uniform.
  for (Loop::block_iterator B = TheLoop->block_begin(),
                            BE = TheLoop->block_end();
       B != BE; ++B)
    for (BasicBlock::iterator I = (*B)->begin(), IE = (*B)->end(); I != IE; ++I)
      if (I->getType()->isPointerTy() && isConsecutivePtr(&*I))
        Worklist.insert(Worklist.end(), I->op_begin(), I->op_end());

  while (!Worklist.empty()) {
    Instruction *I = dyn_cast<Instruction>(Worklist.back());
    Worklist.pop_back();

    // Look at instructions inside this loop.
    // Stop when reaching PHI nodes.
    // TODO: we need to follow values all over the loop, not only in this block.
    if (!I || !TheLoop->contains(I) || isa<PHINode>(I))
      continue;

    // This is a known uniform.
    Uniforms.insert(I);

    // Insert all operands.
    Worklist.insert(Worklist.end(), I->op_begin(), I->op_end());
  }
}

bool LoopVectorizationLegality::canVectorizeMemory() {
  LAI = &(*GetLAA)(*TheLoop);
  InterleaveInfo.setLAI(LAI);
  const OptimizationRemarkAnalysis *LAR = LAI->getReport();
  if (LAR) {
    OptimizationRemarkAnalysis VR(Hints->vectorizeAnalysisPassName(),
                                  "loop not vectorized: ", *LAR);
    ORE->emit(VR);
  }

  if (!LAI->canVectorizeMemory())
    return false;

  if (LAI->hasStoreToLoopInvariantAddress()) {
    ScalarEvolution *SE = PSE.getSE();
    std::list<StoreInst*> UnhandledStores;

    // For each invariant address, check its last stored value is the result
    // of one of our reductions and is unconditional.
    for (StoreInst *SI : LAI->getInvariantStores()) {
      bool FoundMatchingRecurrence = false;
      for (auto &II : Reductions) {
        RecurrenceDescriptor DS = II.second;
        StoreInst *DSI = DS.IntermediateStore;
        if (DSI && (DSI == SI) && !blockNeedsPredication(DSI->getParent())) {
          FoundMatchingRecurrence = true;
          break;
        }
      }

      if (FoundMatchingRecurrence)
        // Earlier stores to this address are effectively deadcode.
        UnhandledStores.remove_if([SE, SI](StoreInst *I) {
          return storeToSameAddress(SE, SI, I);
          });
      else
        UnhandledStores.push_back(SI);
    }

    bool IsOK = UnhandledStores.empty();
    // TODO: we should also validate against InvariantMemSets.
    if (!IsOK) {
      ORE->emit(createMissedAnalysis("CantVectorizeStoreToLoopInvariantAddress")
                << "write to a loop invariant address could not be vectorized");
      DEBUG(dbgs() << "LV: We don't allow storing to uniform addresses\n");
      return false;
    }
  }

  Requirements->addRuntimePointerChecks(LAI->getNumRuntimePointerChecks());
  PSE.addPredicate(LAI->getPSE().getUnionPredicate());

  return true;
}

bool LoopVectorizationLegality::isInductionVariable(const Value *V) {
  Value *In0 = const_cast<Value *>(V);

  if (EnableScalableVectorisation) {
    // TODO: Need to handle other arithmetic/logical instructions
    Instruction *Inst = dyn_cast<Instruction>(In0);
    if (Inst && Inst->getOpcode() == Instruction::Shl) {
      Value *ShiftVal = Inst->getOperand(1);
      if (!dyn_cast<ConstantInt>(ShiftVal))
        return false;
      In0 = Inst->getOperand(0);
    }
  }

  PHINode *PN = dyn_cast_or_null<PHINode>(In0);
  if (!PN)
    return false;

  return Inductions.count(PN);
}

bool LoopVectorizationLegality::isFirstOrderRecurrence(const PHINode *Phi) {
  return FirstOrderRecurrences.count(Phi);
}

bool LoopVectorizationLegality::blockNeedsPredication(BasicBlock *BB) {
  return LoopAccessInfo::blockNeedsPredication(BB, TheLoop, DT);
}

bool LoopVectorizationLegality::blockCanBePredicated(
    BasicBlock *BB, SmallPtrSetImpl<Value *> &SafePtrs) {
  const bool IsAnnotatedParallel = TheLoop->isAnnotatedParallel();

  for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e; ++it) {
    // Check that we don't have a constant expression that can trap as operand.
    for (Instruction::op_iterator OI = it->op_begin(), OE = it->op_end();
         OI != OE; ++OI) {
      if (Constant *C = dyn_cast<Constant>(*OI))
        if (C->canTrap())
          return false;
    }
    // We might be able to hoist the load.
    if (it->mayReadFromMemory()) {
      LoadInst *LI = dyn_cast<LoadInst>(it);
      if (!LI)
        return false;
      if (!SafePtrs.count(LI->getPointerOperand())) {
        if (isLegalMaskedLoad(LI->getType(), LI->getPointerOperand()) ||
            isLegalMaskedGather(LI->getType())) {
          MaskedOp.insert(LI);
          continue;
        }
        // !llvm.mem.parallel_loop_access implies if-conversion safety.
        if (IsAnnotatedParallel)
          continue;
        return false;
      }
    }

    // We don't predicate stores at the moment.
    if (it->mayWriteToMemory()) {
      StoreInst *SI = dyn_cast<StoreInst>(it);
      // We only support predication of stores in basic blocks with one
      // predecessor.
      if (!SI)
        return false;

      // Build a masked store if it is legal for the target.
      if (isLegalMaskedStore(SI->getValueOperand()->getType(),
                             SI->getPointerOperand()) ||
          isLegalMaskedScatter(SI->getValueOperand()->getType())) {
        MaskedOp.insert(SI);
        continue;
      }

      bool isSafePtr = (SafePtrs.count(SI->getPointerOperand()) != 0);
      bool isSinglePredecessor = SI->getParent()->getSinglePredecessor();

      if (++NumPredStores > NumberOfStoresToPredicate || !isSafePtr ||
          !isSinglePredecessor)
        return false;
    }
    if (it->mayThrow())
      return false;

    // The instructions below can trap.
    switch (it->getOpcode()) {
    default:
      continue;
    case Instruction::UDiv:
    case Instruction::SDiv:
    case Instruction::URem:
    case Instruction::SRem:
      return false;
    }
  }

  return true;
}

void InterleavedAccessInfo::collectConstStrideAccesses(
                                                       MapVector<Instruction *, StrideDescriptor> &AccessStrideInfo,
                                                       const ValueToValueMap &Strides) {

  auto &DL = TheLoop->getHeader()->getModule()->getDataLayout();

  // Since it's desired that the load/store instructions be maintained in
  // "program order" for the interleaved access analysis, we have to visit the
  // blocks in the loop in reverse postorder (i.e., in a topological order).
  // Such an ordering will ensure that any load/store that may be executed
  // before a second load/store will precede the second load/store in
  // AccessStrideInfo.
  LoopBlocksDFS DFS(TheLoop);
  DFS.perform(LI);
  for (BasicBlock *BB : make_range(DFS.beginRPO(), DFS.endRPO()))
    for (auto &I : *BB) {
      auto *LI = dyn_cast<LoadInst>(&I);
      auto *SI = dyn_cast<StoreInst>(&I);
      if (!LI && !SI)
        continue;

      Value *Ptr = getPointerOperand(&I);
      // We don't check wrapping here because we don't know yet if Ptr will be
      // part of a full group or a group with gaps. Checking wrapping for all
      // pointers (even those that end up in groups with no gaps) will be overly
      // conservative. For full groups, wrapping should be ok since if we would
      // wrap around the address space we would do a memory access at nullptr
      // even without the transformation. The wrapping checks are therefore
      // deferred until after we've formed the interleaved groups.
      int64_t Stride = getPtrStride(PSE, Ptr, TheLoop, Strides,
                                    /*Assume=*/true, /*ShouldCheckWrap=*/false);

      const SCEV *Scev = replaceSymbolicStrideSCEV(PSE, Strides, Ptr);
      PointerType *PtrTy = dyn_cast<PointerType>(Ptr->getType());
      uint64_t Size = DL.getTypeAllocSize(PtrTy->getElementType());

      // An alignment of 0 means target ABI alignment.
      unsigned Align = getMemInstAlignment(&I);
      if (!Align)
        Align = DL.getABITypeAlignment(PtrTy->getElementType());

      AccessStrideInfo[&I] = StrideDescriptor(Stride, Scev, Size, Align);
    }
}

// Analyze interleaved accesses and collect them into interleaved load and
// store groups.
//
// When generating code for an interleaved load group, we effectively hoist all
// loads in the group to the location of the first load in program order. When
// generating code for an interleaved store group, we sink all stores to the
// location of the last store. This code motion can change the order of load
// and store instructions and may break dependences.
//
// The code generation strategy mentioned above ensures that we won't violate
// any write-after-read (WAR) dependences.
//
// E.g., for the WAR dependence:  a = A[i];      // (1)
//                                A[i] = b;      // (2)
//
// The store group of (2) is always inserted at or below (2), and the load
// group of (1) is always inserted at or above (1). Thus, the instructions will
// never be reordered. All other dependences are checked to ensure the
// correctness of the instruction reordering.
//
// The algorithm visits all memory accesses in the loop in bottom-up program
// order. Program order is established by traversing the blocks in the loop in
// reverse postorder when collecting the accesses.
//
// We visit the memory accesses in bottom-up order because it can simplify the
// construction of store groups in the presence of write-after-write (WAW)
// dependences.
//
// E.g., for the WAW dependence:  A[i] = a;      // (1)
//                                A[i] = b;      // (2)
//                                A[i + 1] = c;  // (3)
//
// We will first create a store group with (3) and (2). (1) can't be added to
// this group because it and (2) are dependent. However, (1) can be grouped
// with other accesses that may precede it in program order. Note that a
// bottom-up order does not imply that WAW dependences should not be checked.
void InterleavedAccessInfo::analyzeInterleaving(
                                                const ValueToValueMap &Strides) {
  DEBUG(dbgs() << "LV: Analyzing interleaved accesses...\n");

  // Holds all accesses with a constant stride.
  MapVector<Instruction *, StrideDescriptor> AccessStrideInfo;
  collectConstStrideAccesses(AccessStrideInfo, Strides);

  if (AccessStrideInfo.empty())
    return;

  // Collect the dependences in the loop.
  collectDependences();

  // Holds all interleaved store groups temporarily.
  SmallSetVector<InterleaveGroup *, 4> StoreGroups;
  // Holds all interleaved load groups temporarily.
  SmallSetVector<InterleaveGroup *, 4> LoadGroups;

  // Search in bottom-up program order for pairs of accesses (A and B) that can
  // form interleaved load or store groups. In the algorithm below, access A
  // precedes access B in program order. We initialize a group for B in the
  // outer loop of the algorithm, and then in the inner loop, we attempt to
  // insert each A into B's group if:
  //
  //  1. A and B have the same stride,
  //  2. A and B have the same memory object size, and
  //  3. A belongs in B's group according to its distance from B.
  //
  // Special care is taken to ensure group formation will not break any
  // dependences.
  for (auto BI = AccessStrideInfo.rbegin(), E = AccessStrideInfo.rend();
       BI != E; ++BI) {
    Instruction *B = BI->first;
    StrideDescriptor DesB = BI->second;

    // Initialize a group for B if it has an allowable stride. Even if we don't
    // create a group for B, we continue with the bottom-up algorithm to ensure
    // we don't break any of B's dependences.
    InterleaveGroup *Group = nullptr;
    if (isStrided(DesB.Stride)) {
      Group = getInterleaveGroup(B);
      if (!Group) {
        DEBUG(dbgs() << "LV: Creating an interleave group with:" << *B << '\n');
        Group = createInterleaveGroup(B, DesB.Stride, DesB.Align);
      }
      if (B->mayWriteToMemory())
        StoreGroups.insert(Group);
      else
        LoadGroups.insert(Group);
    }

    for (auto AI = std::next(BI); AI != E; ++AI) {
      Instruction *A = AI->first;
      StrideDescriptor DesA = AI->second;

      // Our code motion strategy implies that we can't have dependences
      // between accesses in an interleaved group and other accesses located
      // between the first and last member of the group. Note that this also
      // means that a group can't have more than one member at a given offset.
      // The accesses in a group can have dependences with other accesses, but
      // we must ensure we don't extend the boundaries of the group such that
      // we encompass those dependent accesses.
      //
      // For example, assume we have the sequence of accesses shown below in a
      // stride-2 loop:
      //
      //  (1, 2) is a group | A[i]   = a;  // (1)
      //                    | A[i-1] = b;  // (2) |
      //                      A[i-3] = c;  // (3)
      //                      A[i]   = d;  // (4) | (2, 4) is not a group
      //
      // Because accesses (2) and (3) are dependent, we can group (2) with (1)
      // but not with (4). If we did, the dependent access (3) would be within
      // the boundaries of the (2, 4) group.
      if (!canReorderMemAccessesForInterleavedGroups(&*AI, &*BI)) {

        // If a dependence exists and A is already in a group, we know that A
        // must be a store since A precedes B and WAR dependences are allowed.
        // Thus, A would be sunk below B. We release A's group to prevent this
        // illegal code motion. A will then be free to form another group with
        // instructions that precede it.
        if (isInterleaved(A)) {
          InterleaveGroup *StoreGroup = getInterleaveGroup(A);
          StoreGroups.remove(StoreGroup);
          releaseGroup(StoreGroup);
        }

        // If a dependence exists and A is not already in a group (or it was
        // and we just released it), B might be hoisted above A (if B is a
        // load) or another store might be sunk below A (if B is a store). In
        // either case, we can't add additional instructions to B's group. B
        // will only form a group with instructions that it precedes.
        break;
      }

      // At this point, we've checked for illegal code motion. If either A or B
      // isn't strided, there's nothing left to do.
      if (!isStrided(DesA.Stride) || !isStrided(DesB.Stride))
        continue;

      // Ignore A if it's already in a group or isn't the same kind of memory
      // operation as B.
      if (isInterleaved(A) || A->mayReadFromMemory() != B->mayReadFromMemory())
        continue;

      // Check rules 1 and 2. Ignore A if its stride or size is different from
      // that of B.
      if (DesA.Stride != DesB.Stride || DesA.Size != DesB.Size)
        continue;

      // Ignore A if the memory object of A and B don't belong to the same
      // address space
      if (getMemInstAddressSpace(A) != getMemInstAddressSpace(B))
        continue;

      // Calculate the distance from A to B.
      const SCEVConstant *DistToB = dyn_cast<SCEVConstant>(
                                                           PSE.getSE()->getMinusSCEV(DesA.Scev, DesB.Scev));
      if (!DistToB)
        continue;
      int64_t DistanceToB = DistToB->getAPInt().getSExtValue();

      // Check rule 3. Ignore A if its distance to B is not a multiple of the
      // size.
      if (DistanceToB % static_cast<int64_t>(DesB.Size))
        continue;

      // Ignore A if either A or B is in a predicated block. Although we
      // currently prevent group formation for predicated accesses, we may be
      // able to relax this limitation in the future once we handle more
      // complicated blocks.
      if (isPredicated(A->getParent()) || isPredicated(B->getParent()))
        continue;

      // The index of A is the index of B plus A's distance to B in multiples
      // of the size.
      int IndexA =
      Group->getIndex(B) + DistanceToB / static_cast<int64_t>(DesB.Size);

      // Try to insert A into B's group.
      if (Group->insertMember(A, IndexA, DesA.Align)) {
        DEBUG(dbgs() << "LV: Inserted:" << *A << '\n'
              << "    into the interleave group with" << *B << '\n');
        InterleaveGroupMap[A] = Group;

        // Set the first load in program order as the insert position.
        if (A->mayReadFromMemory())
          Group->setInsertPos(A);
      }
    } // Iteration over A accesses.
  } // Iteration over B accesses.

  // Remove interleaved store groups with gaps.
  for (InterleaveGroup *Group : StoreGroups)
    if (Group->getNumMembers() != Group->getFactor())
      releaseGroup(Group);

  // Remove interleaved groups with gaps (currently only loads) whose memory
  // accesses may wrap around. We have to revisit the getPtrStride analysis,
  // this time with ShouldCheckWrap=true, since collectConstStrideAccesses does
  // not check wrapping (see documentation there).
  // FORNOW we use Assume=false;
  // TODO: Change to Assume=true but making sure we don't exceed the threshold
  // of runtime SCEV assumptions checks (thereby potentially failing to
  // vectorize altogether).
  // Additional optional optimizations:
  // TODO: If we are peeling the loop and we know that the first pointer doesn't
  // wrap then we can deduce that all pointers in the group don't wrap.
  // This means that we can forcefully peel the loop in order to only have to
  // check the first pointer for no-wrap. When we'll change to use Assume=true
  // we'll only need at most one runtime check per interleaved group.
  //
  for (InterleaveGroup *Group : LoadGroups) {

    // Case 1: A full group. Can Skip the checks; For full groups, if the wide
    // load would wrap around the address space we would do a memory access at
    // nullptr even without the transformation.
    if (Group->getNumMembers() == Group->getFactor())
      continue;

    // Case 2: If first and last members of the group don't wrap this implies
    // that all the pointers in the group don't wrap.
    // So we check only group member 0 (which is always guaranteed to exist),
    // and group member Factor - 1; If the latter doesn't exist we rely on
    // peeling (if it is a non-reveresed accsess -- see Case 3).
    Value *FirstMemberPtr = getPointerOperand(Group->getMember(0));
    if (!getPtrStride(PSE, FirstMemberPtr, TheLoop, Strides, /*Assume=*/false,
                      /*ShouldCheckWrap=*/true)) {
      DEBUG(dbgs() << "LV: Invalidate candidate interleaved group due to "
            "first group member potentially pointer-wrapping.\n");
      releaseGroup(Group);
      continue;
    }
    Instruction *LastMember = Group->getMember(Group->getFactor() - 1);
    if (LastMember) {
      Value *LastMemberPtr = getPointerOperand(LastMember);
      if (!getPtrStride(PSE, LastMemberPtr, TheLoop, Strides, /*Assume=*/false,
                        /*ShouldCheckWrap=*/true)) {
        DEBUG(dbgs() << "LV: Invalidate candidate interleaved group due to "
              "last group member potentially pointer-wrapping.\n");
        releaseGroup(Group);
      }
    } else {
      // Case 3: A non-reversed interleaved load group with gaps: We need
      // to execute at least one scalar epilogue iteration. This will ensure
      // we don't speculatively access memory out-of-bounds. We only need
      // to look for a member at index factor - 1, since every group must have
      // a member at index zero.
      if (Group->isReverse()) {
        releaseGroup(Group);
        continue;
      }
      DEBUG(dbgs() << "LV: Interleaved group requires epilogue iteration.\n");
      RequiresScalarEpilogue = true;
    }
  }
}

static TargetTransformInfo::ReductionFlags
getReductionFlagsFromDesc(RecurrenceDescriptor Rdx) {
  using RD = RecurrenceDescriptor;
  RD::RecurrenceKind RecKind = Rdx.getRecurrenceKind();
  TargetTransformInfo::ReductionFlags Flags;
  Flags.IsOrdered = Rdx.isOrdered();
  if (RecKind == RD::RK_IntegerMinMax || RecKind == RD::RK_FloatMinMax) {
    auto MMKind = Rdx.getMinMaxRecurrenceKind();
    Flags.IsSigned = MMKind == RD::MRK_SIntMax || MMKind == RD::MRK_SIntMin;
    Flags.IsMaxOp = MMKind == RD::MRK_SIntMax || MMKind == RD::MRK_FloatMax;
  }
  return Flags;
}

VectorizationFactor
LoopVectorizationCostModel::selectVectorizationFactor(bool OptForSize) {
  bool FixedWidth = !EnableScalableVectorisation;

  int UserVStyle = Hints->getStyle();
  if (UserVStyle != LoopVectorizeHints::SK_Unspecified) {
    FixedWidth = UserVStyle == LoopVectorizeHints::SK_Fixed;
    DEBUG(dbgs() << "LV: Using user vectorization style of "
                 << (FixedWidth ? "fixed" : "scaled") << " width.\n");
  }

  // Width 1 means no vectorize
  VectorizationFactor Factor = { 1U, 0U, FixedWidth };

  if (OptForSize && Legal->getRuntimePointerChecking()->Need) {
    ORE->emit(createMissedAnalysis("CantVersionLoopWithOptForSize")
              << "runtime pointer checks needed. Enable vectorization of this "
              "loop with '#pragma clang loop vectorize(enable)' when "
              "compiling with -Os/-Oz");
    DEBUG(dbgs() <<
          "LV: Aborting. Runtime ptr check is required with -Os/-Oz.\n");
    Factor.isFixed = true;
    return Factor;
  }

  if (!EnableCondStoresVectorization && Legal->getNumPredStores()) {
    ORE->emit(createMissedAnalysis("ConditionalStore")
              << "store that is conditionally executed prevents vectorization");
    DEBUG(dbgs() << "LV: No vectorization. There are conditional stores.\n");
    Factor.isFixed = true;
    return Factor;
  }

  // Find the trip count.
  unsigned TC = PSE.getSE()->getSmallConstantTripCount(TheLoop);
  DEBUG(dbgs() << "LV: Found trip count: " << TC << '\n');

  MinBWs = computeMinimumValueSizes(TheLoop->getBlocks(), *DB, &TTI);
  unsigned SmallestType, WidestType;
  std::tie(SmallestType, WidestType) = getSmallestAndWidestTypes();
  unsigned WidestRegister = TTI.getRegisterBitWidth(true);
  unsigned MaxSafeDepDist = -1U;

  // Get the maximum safe dependence distance in bits computed by LAA. If the
  // loop contains any interleaved accesses, we divide the dependence distance
  // by the maximum interleave factor of all interleaved groups. Note that
  // although the division ensures correctness, this is a fairly conservative
  // computation because the maximum distance computed by LAA may not involve
  // any of the interleaved accesses.
  if (Legal->getMaxSafeDepDistBytes() != -1U)
    MaxSafeDepDist =
        Legal->getMaxSafeDepDistBytes() * 8 / Legal->getMaxInterleaveFactor();

  // For the case when the register size is unknown we cannot vectorise loops
  // with data dependencies in a scalable manner.  However, when the
  // architecture provides an upper bound, we can query that before reverting
  // to fixed width vectors.
  if (MaxSafeDepDist < TTI.getRegisterBitWidthUpperBound(true)) {
    Factor.isFixed = true;
    // LAA may have assumed we can do strided during analysis
    if (Legal->getRuntimePointerChecking()->Strided &&
        TTI.canVectorizeNonUnitStrides(true)) {
      DEBUG(dbgs() <<
            "LV: Not vectorizing, can't do strided accesses on target.\n");
      ORE->emit(createMissedAnalysis("StridedAccess")
                << "Target doesn't support vectorizing strided accesses.");
      Factor.Width = 1;
      return Factor;
    }
  }

  WidestRegister =
      ((WidestRegister < MaxSafeDepDist) ? WidestRegister : MaxSafeDepDist);
  unsigned MaxVectorSize = WidestRegister / WidestType;

  DEBUG(dbgs() << "LV: The Smallest and Widest types: " << SmallestType << " / "
               << WidestType << " bits.\n");
  DEBUG(dbgs() << "LV: The Widest register is: " << WidestRegister
               << " bits.\n");

  if (MaxVectorSize == 0) {
    DEBUG(dbgs() << "LV: The target has no vector registers.\n");
    MaxVectorSize = 1;
  }

  assert(MaxVectorSize <= 64 && "Did not expect to pack so many elements"
                                " into one vector!");

  unsigned VF = MaxVectorSize;
  if (MaximizeBandwidth && !OptForSize) {
    // Collect all viable vectorization factors.
    SmallVector<unsigned, 8> VFs;
    unsigned NewMaxVectorSize = WidestRegister / SmallestType;
    for (unsigned VS = MaxVectorSize; VS <= NewMaxVectorSize; VS *= 2)
      VFs.push_back(VS);

    // For each VF calculate its register usage.
    auto RUs = calculateRegisterUsage(VFs);

    // Select the largest VF which doesn't require more registers than existing
    // ones.
    unsigned TargetNumRegisters = TTI.getNumberOfRegisters(true);
    for (int i = RUs.size() - 1; i >= 0; --i) {
      if (RUs[i].MaxLocalUsers <= TargetNumRegisters) {
        VF = VFs[i];
        break;
      }
    }
  }

  // If we optimize the program for size, avoid creating the tail loop.
  if (OptForSize) {
    // If we are unable to calculate the trip count then don't try to vectorize.
    if (TC < 2) {
      ORE->emit(
          createMissedAnalysis("UnknownLoopCountComplexCFG")
          << "unable to calculate the loop count due to complex control flow");
      DEBUG(dbgs() << "LV: Aborting. A tail loop is required with -Os/-Oz.\n");
      if (Factor.Width < 2)
        Factor.isFixed = true;
      return Factor;
    }

    // Find the maximum SIMD width that can fit within the trip count.
    VF = TC % MaxVectorSize;

    if (VF == 0)
      VF = MaxVectorSize;
    else {
      // If the trip count that we found modulo the vectorization factor is not
      // zero then we require a tail.
      ORE->emit(createMissedAnalysis("NoTailLoopWithOptForSize")
                << "cannot optimize for size and vectorize at the "
                "same time. Enable vectorization of this loop "
                "with '#pragma clang loop vectorize(enable)' "
                "when compiling with -Os/-Oz");
      DEBUG(dbgs() << "LV: Aborting. A tail loop is required with -Os/-Oz.\n");
      Factor.isFixed = true;
      return Factor;
    }
  }

  // If the target does not have a scalable reduction intrinsic, abort.
  if (!Factor.isFixed) {
    for (auto Rdx : *Legal->getReductionVars()) {
      auto Flags = getReductionFlagsFromDesc(Rdx.second);
      unsigned Opc = RecurrenceDescriptor::getRecurrenceBinOp(
          Rdx.second.getRecurrenceKind());
      if (!TTI.canReduceInVector(Opc, Rdx.second.getRecurrenceType(), Flags)) {
        ORE->emit(createMissedAnalysis("MissingReductionOperation")
                  << "Cannot use scalable vectorization due to an unsupported "
                     "reduction operation. Use fixed width vectorization.");
        DEBUG(dbgs() << "LV: Aborting. Unsupported reduction for scalable "
                        "vectorization.\n");
        Factor.isFixed = true;
        Factor.Width = 1;
        return Factor;
      }
    }
  }

  int UserVF = Hints->getWidth();
  if (UserVF != 0) {
    assert(isPowerOf2_32(UserVF) && "VF needs to be a power of two");
    DEBUG(dbgs() << "LV: Using user VF " << UserVF << ".\n");

    Factor.Width = UserVF;
    if (Factor.Width < 2)
      Factor.isFixed = true;
    return Factor;
  }

  float Cost = expectedCost({/*Width=*/1, 0, /*isFixed=*/true}).first;
#ifndef NDEBUG
  const float ScalarCost = Cost;
#endif /* NDEBUG */
  Factor.Width = 1;
  DEBUG(dbgs() << "LV: Scalar loop costs: " << (int)ScalarCost << ".\n");

  bool ForceVectorization = Hints->getForce() == LoopVectorizeHints::FK_Enabled;
  // Ignore scalar width, because the user explicitly wants vectorization.
  if (ForceVectorization && VF > 1) {
    Factor.Width = 2;
    Cost = expectedCost(Factor).first / (float)Factor.Width;
  }

  VectorizationFactor PotentialFactor = Factor;
  for (unsigned i = 2; i <= VF; i *= 2) {
    // Notice that the vector loop needs to be executed less times, so
    // we need to divide the cost of the vector loops by the width of
    // the vector elements.
    PotentialFactor.Width = i;
    VectorizationCostTy C = expectedCost(PotentialFactor);
    float VectorCost = C.first / (float)i;
    DEBUG(dbgs() << "LV: Vector loop of width " << i
                 << " costs: " << (int)VectorCost << ".\n");
    if (!C.second && !ForceVectorization) {
      DEBUG(
          dbgs() << "LV: Not considering vector loop of width " << i
                 << " because it will not generate any vector instructions.\n");
      continue;
    }
    if (VectorCost < Cost) {
      Cost = VectorCost;
      Factor = PotentialFactor;
    }
  }

  DEBUG(if (ForceVectorization && Factor.Width > 1 && Cost >= ScalarCost) dbgs()
        << "LV: Vectorization seems to be not beneficial, "
        << "but was forced by a user.\n");
  Factor.Cost = Factor.Width * Cost;
  if (Factor.Width < 2)
    Factor.isFixed = true;
  DEBUG(dbgs() << "LV: Selecting VF: " << (Factor.isFixed ? "" : "n x ") <<
        Factor.Width << ".\n");
  return Factor;
}

std::pair<unsigned, unsigned>
LoopVectorizationCostModel::getSmallestAndWidestTypes() {
  unsigned MinWidth = -1U;
  unsigned MaxWidth = 8;
  const DataLayout &DL = TheFunction->getParent()->getDataLayout();

  // For each block.
  for (Loop::block_iterator bb = TheLoop->block_begin(),
                            be = TheLoop->block_end();
       bb != be; ++bb) {
    BasicBlock *BB = *bb;

    // For each instruction in the loop.
    for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e; ++it) {
      Type *T = it->getType();

      // Skip ignored values.
      if (ValuesToIgnore.count(&*it))
        continue;

      // Only examine Loads, Stores and PHINodes.
      if (!isa<LoadInst>(it) && !isa<StoreInst>(it) && !isa<PHINode>(it))
        continue;

      // Examine PHI nodes that are reduction variables. Update the type to
      // account for the recurrence type.
      if (PHINode *PN = dyn_cast<PHINode>(it)) {
        if (!Legal->isReductionVariable(PN))
          continue;
        RecurrenceDescriptor RdxDesc = (*Legal->getReductionVars())[PN];
        T = RdxDesc.getRecurrenceType();
      }

      // Examine the stored values.
      if (StoreInst *ST = dyn_cast<StoreInst>(it))
        T = ST->getValueOperand()->getType();

      // Ignore loaded pointer types and stored pointer types that are not
      // vectorizable.
      //
      // FIXME: The check here attempts to predict whether a load or store will
      //        be vectorized. We only know this for certain after a VF has
      //        been selected. Here, we assume that if an access can be
      //        vectorized, it will be. We should also look at extending this
      //        optimization to non-pointer types.
      //
      if (T->isPointerTy() && !isConsecutiveLoadOrStore(&*it) &&
          !Legal->isAccessInterleaved(&*it) && !Legal->isLegalGatherOrScatter(&*it))
        continue;

      MinWidth = std::min(MinWidth,
                          (unsigned)DL.getTypeSizeInBits(T->getScalarType()));
      MaxWidth = std::max(MaxWidth,
                          (unsigned)DL.getTypeSizeInBits(T->getScalarType()));
    }
  }

  return {MinWidth, MaxWidth};
}

unsigned
LoopVectorizationCostModel::selectInterleaveCount(bool OptForSize,
                                                  VectorizationFactor VF,
                                                  unsigned LoopCost) {

  // -- The interleave heuristics --
  // We interleave the loop in order to expose ILP and reduce the loop overhead.
  // There are many micro-architectural considerations that we can't predict
  // at this level. For example, frontend pressure (on decode or fetch) due to
  // code size, or the number and capabilities of the execution ports.
  //
  // We use the following heuristics to select the interleave count:
  // 1. If the code has reductions, then we interleave to break the cross
  // iteration dependency.
  // 2. If the loop is really small, then we interleave to reduce the loop
  // overhead.
  // 3. We don't interleave if we think that we will spill registers to memory
  // due to the increased register pressure.

  // TODO: revisit this decision but for now it is not worth considering
  if (EnableVectorPredication && !VF.isFixed)
    return 1;

  // When we optimize for size, we don't interleave.
  if (OptForSize)
    return 1;

  // We used the distance for the interleave count.
  if (Legal->getMaxSafeDepDistBytes() != -1U)
    return 1;

  // Do not interleave loops with a relatively small trip count.
  unsigned TC = PSE.getSE()->getSmallConstantTripCount(TheLoop);
  if (TC > 1 && TC < TinyTripCountInterleaveThreshold)
    return 1;

  // Ordered reductions can't be used with interleaving.
  for (auto &Rdx : *Legal->getReductionVars())
    if (Rdx.second.isOrdered())
      return 1;

  unsigned TargetNumRegisters = TTI.getNumberOfRegisters(VF.Width > 1);
  DEBUG(dbgs() << "LV: The target has " << TargetNumRegisters
               << " registers\n");

  if (VF.Width == 1) {
    if (ForceTargetNumScalarRegs.getNumOccurrences() > 0)
      TargetNumRegisters = ForceTargetNumScalarRegs;
  } else {
    if (ForceTargetNumVectorRegs.getNumOccurrences() > 0)
      TargetNumRegisters = ForceTargetNumVectorRegs;
  }

  RegisterUsage R = calculateRegisterUsage({VF.Width})[0];
  // We divide by these constants so assume that we have at least one
  // instruction that uses at least one register.
  R.MaxLocalUsers = std::max(R.MaxLocalUsers, 1U);
  R.NumInstructions = std::max(R.NumInstructions, 1U);

  // We calculate the interleave count using the following formula.
  // Subtract the number of loop invariants from the number of available
  // registers. These registers are used by all of the interleaved instances.
  // Next, divide the remaining registers by the number of registers that is
  // required by the loop, in order to estimate how many parallel instances
  // fit without causing spills. All of this is rounded down if necessary to be
  // a power of two. We want power of two interleave count to simplify any
  // addressing operations or alignment considerations.
  unsigned IC = PowerOf2Floor((TargetNumRegisters - R.LoopInvariantRegs) /
                              R.MaxLocalUsers);

  // Don't count the induction variable as interleaved.
  if (EnableIndVarRegisterHeur)
    IC = PowerOf2Floor((TargetNumRegisters - R.LoopInvariantRegs - 1) /
                       std::max(1U, (R.MaxLocalUsers - 1)));

  // Clamp the interleave ranges to reasonable counts.
  unsigned MaxInterleaveCount = TTI.getMaxInterleaveFactor(VF.Width);

  // Check if the user has overridden the max.
  if (VF.Width == 1) {
    if (ForceTargetMaxScalarInterleaveFactor.getNumOccurrences() > 0)
      MaxInterleaveCount = ForceTargetMaxScalarInterleaveFactor;
  } else {
    if (ForceTargetMaxVectorInterleaveFactor.getNumOccurrences() > 0)
      MaxInterleaveCount = ForceTargetMaxVectorInterleaveFactor;
  }

  // If we did not calculate the cost for VF (because the user selected the VF)
  // then we calculate the cost of VF here.
  if (LoopCost == 0)
    LoopCost = expectedCost(VF).first;

  // Clamp the calculated IC to be between the 1 and the max interleave count
  // that the target allows.
  if (IC > MaxInterleaveCount)
    IC = MaxInterleaveCount;
  else if (IC < 1)
    IC = 1;

  // Interleave if we vectorized this loop and there is a reduction that could
  // benefit from interleaving.
  if (VF.Width > 1 && Legal->getReductionVars()->size()) {
    DEBUG(dbgs() << "LV: Interleaving because of reductions.\n");
    return IC;
  }

  // Note that if we've already vectorized the loop we will have done the
  // runtime check and so interleaving won't require further checks.
  bool InterleavingRequiresRuntimePointerCheck =
      (VF.Width == 1 && Legal->getRuntimePointerChecking()->Need);

  // We want to interleave small loops in order to reduce the loop overhead and
  // potentially expose ILP opportunities.
  DEBUG(dbgs() << "LV: Loop cost is " << LoopCost << '\n');
  if (!InterleavingRequiresRuntimePointerCheck && LoopCost < SmallLoopCost) {
    // We assume that the cost overhead is 1 and we use the cost model
    // to estimate the cost of the loop and interleave until the cost of the
    // loop overhead is about 5% of the cost of the loop.
    unsigned SmallIC =
        std::min(IC, (unsigned)PowerOf2Floor(SmallLoopCost / LoopCost));

    // Interleave until store/load ports (estimated by max interleave count) are
    // saturated.
    unsigned NumStores = Legal->getNumStores();
    unsigned NumLoads = Legal->getNumLoads();
    unsigned StoresIC = IC / (NumStores ? NumStores : 1);
    unsigned LoadsIC = IC / (NumLoads ? NumLoads : 1);

    // If we have a scalar reduction (vector reductions are already dealt with
    // by this point), we can increase the critical path length if the loop
    // we're interleaving is inside another loop. Limit, by default to 2, so the
    // critical path only gets increased by one reduction operation.
    if (Legal->getReductionVars()->size() && TheLoop->getLoopDepth() > 1) {
      unsigned F = static_cast<unsigned>(MaxNestedScalarReductionIC);
      SmallIC = std::min(SmallIC, F);
      StoresIC = std::min(StoresIC, F);
      LoadsIC = std::min(LoadsIC, F);
    }

    if (EnableLoadStoreRuntimeInterleave &&
        std::max(StoresIC, LoadsIC) > SmallIC) {
      DEBUG(dbgs() << "LV: Interleaving to saturate store or load ports.\n");
      return std::max(StoresIC, LoadsIC);
    }

    DEBUG(dbgs() << "LV: Interleaving to reduce branch cost.\n");
    return SmallIC;
  }

  // Interleave if this is a large loop (small loops are already dealt with by
  // this point) that could benefit from interleaving.
  bool HasReductions = (Legal->getReductionVars()->size() > 0);
  if (TTI.enableAggressiveInterleaving(HasReductions)) {
    DEBUG(dbgs() << "LV: Interleaving to expose ILP.\n");
    return IC;
  }

  DEBUG(dbgs() << "LV: Not Interleaving.\n");
  return 1;
}

SmallVector<LoopVectorizationCostModel::RegisterUsage, 8>
LoopVectorizationCostModel::calculateRegisterUsage(ArrayRef<unsigned> VFs) {
  // This function calculates the register usage by measuring the highest number
  // of values that are alive at a single location. Obviously, this is a very
  // rough estimation. We scan the loop in a topological order in order and
  // assign a number to each instruction. We use RPO to ensure that defs are
  // met before their users. We assume that each instruction that has in-loop
  // users starts an interval. We record every time that an in-loop value is
  // used, so we have a list of the first and last occurrences of each
  // instruction. Next, we transpose this data structure into a multi map that
  // holds the list of intervals that *end* at a specific location. This multi
  // map allows us to perform a linear search. We scan the instructions linearly
  // and record each time that a new interval starts, by placing it in a set.
  // If we find this value in the multi-map then we remove it from the set.
  // The max register usage is the maximum size of the set.
  // We also search for instructions that are defined outside the loop, but are
  // used inside the loop. We need this number separately from the max-interval
  // usage number because when we unroll, loop-invariant values do not take
  // more register.
  LoopBlocksDFS DFS(TheLoop);
  DFS.perform(LI);

  RegisterUsage RU;
  RU.NumInstructions = 0;

  // Each 'key' in the map opens a new interval. The values
  // of the map are the index of the 'last seen' usage of the
  // instruction that is the key.
  typedef DenseMap<Instruction *, unsigned> IntervalMap;
  // Maps instruction to its index.
  DenseMap<unsigned, Instruction *> IdxToInstr;
  // Marks the end of each interval.
  IntervalMap EndPoint;
  // Saves the list of instruction indices that are used in the loop.
  SmallSet<Instruction *, 8> Ends;
  // Saves the list of values that are used in the loop but are
  // defined outside the loop, such as arguments and constants.
  SmallPtrSet<Value *, 8> LoopInvariants;

  unsigned Index = 0;
  for (LoopBlocksDFS::RPOIterator bb = DFS.beginRPO(), be = DFS.endRPO();
       bb != be; ++bb) {
    RU.NumInstructions += (*bb)->size();
    for (Instruction &I : **bb) {
      IdxToInstr[Index++] = &I;

      // Save the end location of each USE.
      for (unsigned i = 0; i < I.getNumOperands(); ++i) {
        Value *U = I.getOperand(i);
        Instruction *Instr = dyn_cast<Instruction>(U);

        // Ignore non-instruction values such as arguments, constants, etc.
        if (!Instr)
          continue;

        // If this instruction is outside the loop then record it and continue.
        if (!TheLoop->contains(Instr)) {
          LoopInvariants.insert(Instr);
          continue;
        }

        // Overwrite previous end points.
        EndPoint[Instr] = Index;
        Ends.insert(Instr);
      }
    }
  }

  // Saves the list of intervals that end with the index in 'key'.
  typedef SmallVector<Instruction *, 2> InstrList;
  DenseMap<unsigned, InstrList> TransposeEnds;

  // Transpose the EndPoints to a list of values that end at each index.
  for (IntervalMap::iterator it = EndPoint.begin(), e = EndPoint.end(); it != e;
       ++it)
    TransposeEnds[it->second].push_back(it->first);

  SmallSet<Instruction *, 8> OpenIntervals;

  // Get the size of the widest register.
  unsigned MaxSafeDepDist = -1U;
  if (Legal->getMaxSafeDepDistBytes() != -1U)
    MaxSafeDepDist = Legal->getMaxSafeDepDistBytes() * 8;
  unsigned WidestRegister =
      std::min(TTI.getRegisterBitWidth(true), MaxSafeDepDist);
  const DataLayout &DL = TheFunction->getParent()->getDataLayout();

  SmallVector<RegisterUsage, 8> RUs(VFs.size());
  SmallVector<unsigned, 8> MaxUsages(VFs.size(), 0);

  DEBUG(dbgs() << "LV(REG): Calculating max register usage:\n");

  // A lambda that gets the register usage for the given type and VF.
  auto GetRegUsage = [&DL, WidestRegister](Type *Ty, unsigned VF) {
    if (Ty->isTokenTy())
      return 0U;
    unsigned TypeSize = DL.getTypeSizeInBits(Ty->getScalarType());
    return std::max<unsigned>(1, VF * TypeSize / WidestRegister);
  };

  for (unsigned int i = 0; i < Index; ++i) {
    Instruction *I = IdxToInstr[i];
    // Ignore instructions that are never used within the loop.
    if (!Ends.count(I))
      continue;

    // Remove all of the instructions that end at this location.
    InstrList &List = TransposeEnds[i];
    for (unsigned int j = 0, e = List.size(); j < e; ++j)
      OpenIntervals.erase(List[j]);

    // Skip ignored values.
    if (ValuesToIgnore.count(I))
      continue;

    // For each VF find the maximum usage of registers.
    for (unsigned j = 0, e = VFs.size(); j < e; ++j) {
      if (VFs[j] == 1) {
        MaxUsages[j] = std::max(MaxUsages[j], OpenIntervals.size());
        continue;
      }

      // Count the number of live intervals.
      unsigned RegUsage = 0;
      for (auto Inst : OpenIntervals) {
        // Skip ignored values for VF > 1.
        if (VecValuesToIgnore.count(Inst))
          continue;
        RegUsage += GetRegUsage(Inst->getType(), VFs[j]);
      }
      MaxUsages[j] = std::max(MaxUsages[j], RegUsage);
    }

    DEBUG(dbgs() << "LV(REG): At #" << i << " Interval # "
                 << OpenIntervals.size() << '\n');

    // Add the current instruction to the list of open intervals.
    OpenIntervals.insert(I);
  }

  for (unsigned i = 0, e = VFs.size(); i < e; ++i) {
    unsigned Invariant = 0;
    if (VFs[i] == 1)
      Invariant = LoopInvariants.size();
    else {
      for (auto Inst : LoopInvariants)
        Invariant += GetRegUsage(Inst->getType(), VFs[i]);
    }

    DEBUG(dbgs() << "LV(REG): VF = " << VFs[i] << '\n');
    DEBUG(dbgs() << "LV(REG): Found max usage: " << MaxUsages[i] << '\n');
    DEBUG(dbgs() << "LV(REG): Found invariant usage: " << Invariant << '\n');
    DEBUG(dbgs() << "LV(REG): LoopSize: " << RU.NumInstructions << '\n');

    RU.LoopInvariantRegs = Invariant;
    RU.MaxLocalUsers = MaxUsages[i];
    RUs[i] = RU;
  }

  return RUs;
}

LoopVectorizationCostModel::VectorizationCostTy
LoopVectorizationCostModel::expectedCost(VectorizationFactor VF) {
  VectorizationCostTy Cost;

  // For each block.
  for (Loop::block_iterator bb = TheLoop->block_begin(),
                            be = TheLoop->block_end();
       bb != be; ++bb) {
    VectorizationCostTy BlockCost;
    BasicBlock *BB = *bb;

    // For each instruction in the old loop.
    for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e; ++it) {
      // Skip dbg intrinsics.
      if (isa<DbgInfoIntrinsic>(it))
        continue;

      // Skip ignored values.
      if (ValuesToIgnore.count(&*it))
        continue;

      VectorizationCostTy C = getInstructionCost(&*it, VF);

      // Check if we should override the cost.
      if (ForceTargetInstructionCost.getNumOccurrences() > 0)
        C.first = ForceTargetInstructionCost;

      BlockCost.first += C.first;
      BlockCost.second |= C.second;
      DEBUG(dbgs() << "LV: Found an estimated cost of " << C.first
                   << " for VF " << (VF.isFixed ? "" : "n x ") << VF.Width
                   << " For instruction: " << *it << '\n');
    }

    // We assume that if-converted blocks have a 50% chance of being executed.
    // When the code is scalar then some of the blocks are avoided due to CF.
    // When the code is vectorized we execute all code paths.
    if (VF.Width == 1 && Legal->blockNeedsPredication(*bb))
      BlockCost.first /= 2;

    Cost.first += BlockCost.first;
    Cost.second |= BlockCost.second;
  }

  return Cost;
}

/// \brief Check if the load/store instruction \p I may be translated into
/// gather/scatter during vectorization.
///
/// Pointer \p Ptr specifies address in memory for the given scalar memory
/// instruction. We need it to retrieve data type.
/// Using gather/scatter is possible when it is supported by target.
/*
static bool isGatherOrScatterLegal(Instruction *I, Value *Ptr,
                                   LoopVectorizationLegality *Legal) {
  Type *DataTy = cast<PointerType>(Ptr->getType())->getElementType();
  return (isa<LoadInst>(I) && Legal->isLegalMaskedGather(DataTy)) ||
         (isa<StoreInst>(I) && Legal->isLegalMaskedScatter(DataTy));
}
 */

/// \brief Check whether the address computation for a non-consecutive memory
/// access looks like an unlikely candidate for being merged into the indexing
/// mode.
///
/// We look for a GEP which has one index that is an induction variable and all
/// other indices are loop invariant. If the stride of this access is also
/// within a small bound we decide that this address computation can likely be
/// merged into the addressing mode.
/// In all other cases, we identify the address computation as complex.
/*
static bool isLikelyComplexAddressComputation(Value *Ptr,
                                              LoopVectorizationLegality *Legal,
                                              ScalarEvolution *SE,
                                              const Loop *TheLoop) {
  GetElementPtrInst *Gep = dyn_cast<GetElementPtrInst>(Ptr);
  if (!Gep)
    return true;

  // We are looking for a gep with all loop invariant indices except for one
  // which should be an induction variable.
  unsigned NumOperands = Gep->getNumOperands();
  for (unsigned i = 1; i < NumOperands; ++i) {
    Value *Opd = Gep->getOperand(i);
    if (!SE->isLoopInvariant(SE->getSCEV(Opd), TheLoop) &&
        !Legal->isInductionVariable(Opd))
      return true;
  }

  // Now we know we have a GEP ptr, %inv, %ind, %inv. Make sure that the step
  // can likely be merged into the address computation.
  unsigned MaxMergeDistance = 64;

  const SCEVAddRecExpr *AddRec = dyn_cast<SCEVAddRecExpr>(SE->getSCEV(Ptr));
  if (!AddRec)
    return true;

  // Check the step is constant.
  const SCEV *Step = AddRec->getStepRecurrence(*SE);
  // Calculate the pointer stride and check if it is consecutive.
  const SCEVConstant *C = dyn_cast<SCEVConstant>(Step);
  if (!C)
    return true;

  const APInt &APStepVal = C->getAPInt();

  // Huge step value - give up.
  if (APStepVal.getBitWidth() > 64)
    return true;

  int64_t StepVal = APStepVal.getSExtValue();

  return StepVal > MaxMergeDistance;
}
 */

static bool isStrideMul(Instruction *I, LoopVectorizationLegality *Legal) {
  return Legal->hasStride(I->getOperand(0)) ||
         Legal->hasStride(I->getOperand(1));
}

// Given a Chain
//  A -> B -> Z,
// where:
//  A = s/zext
//  B = add
//  C = trunc
// Check this is one of
//  s/zext(i32) -> add -> trunc(valtype)
static bool isPartOfPromotedAdd(Instruction *I, Type **OrigType) {
  Instruction *TruncOp = I;

  // If I is one of step A, find step C
  if ((I->getOpcode() == Instruction::ZExt ||
       I->getOpcode() == Instruction::SExt)) {
    // Confirm that s/zext is *only* used for the add
    for(int K=0; K<2; ++K) {
      if (!TruncOp->hasOneUse())
        return false;
      TruncOp = dyn_cast<Instruction>(TruncOp->user_back());
    }
  }
  // If I is one of step B, find step C
  else if ((I->getOpcode() == Instruction::Add)) {
    if (!I->hasOneUse())
      return false;
    TruncOp = I->user_back();
  }

  // Check if I is one of step C
  if (TruncOp->getOpcode() != Instruction::Trunc)
    return false;

  if (Instruction *Opnd = dyn_cast<Instruction>(TruncOp->getOperand(0))) {
    if (TruncOp->getOpcode() != Instruction::Trunc ||
        Opnd->getOpcode() != Instruction::Add || !Opnd->hasNUses(1))
      return false;

    // Check each operand to the 'add'
    unsigned cnt = 0;
    for (Value *V : Opnd->operands()) {
      if (const Instruction *AddOpnd = dyn_cast<const Instruction>(V)) {
        if (AddOpnd->getOpcode() != Instruction::ZExt &&
            AddOpnd->getOpcode() != Instruction::SExt)
          break;

        if (!AddOpnd->getType()->isIntegerTy(32))
          break;

        if ( AddOpnd->getOperand(0)->getType() != TruncOp->getType() ||
            !AddOpnd->hasNUses(1))
          break;
      }
      cnt++;
    }

    if (cnt == Opnd->getNumOperands()) {
      if (OrigType)
        *OrigType = TruncOp->getType();
      return true;
    }
  }

  return false;
}

static MemAccessInfo calculateMemAccessInfo(Instruction *I,
                                            Type *VectorTy,
                                            LoopVectorizationLegality *Legal,
                                            ScalarEvolution *SE) {
  const DataLayout &DL = I->getModule()->getDataLayout();

  // Get pointer operand
  Value *Ptr = nullptr;
  if (auto *LI = dyn_cast<LoadInst>(I))
    Ptr = LI->getPointerOperand();
  if (auto *SI = dyn_cast<StoreInst>(I))
    Ptr = SI->getPointerOperand();

  assert (Ptr && "Could not get pointer operand from instruction");

  // Check for uniform access (scalar load + splat)
  if (Legal->isUniform(Ptr))
    return MemAccessInfo::getUniformInfo();

  // Get whether it is a predicated memory operation
  bool IsMasked = Legal->isMaskRequired(I);

  // Try to find the stride of the pointer expression
  if (auto *SAR = dyn_cast<SCEVAddRecExpr>(SE->getSCEV(Ptr))) {
    const SCEV *StepRecurrence = SAR->getStepRecurrence(*SE);
    if (auto *StrideV = dyn_cast<SCEVConstant>(StepRecurrence)) {
      // Get the element size
      unsigned VectorElementSize =
          DL.getTypeStoreSize(VectorTy) / VectorTy->getVectorNumElements();

      // Normalize Stride from bytes to number of elements
      int Stride =
          StrideV->getValue()->getSExtValue() / ((int64_t)VectorElementSize);
      return MemAccessInfo::getStridedInfo(Stride, Stride < 0, IsMasked);
    } else {
      // Unknown stride is a subset of gather/scatter
      return MemAccessInfo::getNonStridedInfo(StepRecurrence->getType(),
                                              IsMasked);
    }
  }

  // If this is a scatter operation try to find the type of the offset,
  // if applicable, e.g. A[i] = B[C[i]]
  //                              ^^^^ get type of C[i]
  Type *IdxTy = nullptr;
  bool IsSigned = true;
  if (auto *Gep = dyn_cast<GetElementPtrInst>(Ptr)) {
    for (unsigned Op=0; Op < Gep->getNumOperands(); ++Op) {
      Value *Opnd = Gep->getOperand(Op);
      if (Legal->isUniform(Opnd)) {
        continue;
      }

      // If there are multiple non-loop invariant indices
      // in this GEP, fall back to the worst case below.
      if (IdxTy != nullptr) {
        IdxTy = nullptr;
        break;
      }

      // If type is promoted, see if we can use smaller type
      IdxTy = Opnd->getType();
      if (auto *Ext = dyn_cast<CastInst>(Opnd)) {
        if (Ext->isIntegerCast())
          IdxTy = Ext->getSrcTy();
        if (isa<ZExtInst>(Ext))
          IsSigned = false;
      }
    }
  }

  // Worst case scenario, assume pointer size
  if (!IdxTy)
    IdxTy = DL.getIntPtrType(Ptr->getType());

  return MemAccessInfo::getNonStridedInfo(IdxTy, IsMasked, IsSigned);
}

LoopVectorizationCostModel::VectorizationCostTy
LoopVectorizationCostModel::getInstructionCost(Instruction *I,
                                               VectorizationFactor VF) {
  // If we know that this instruction will remain uniform, check the cost of
  // the scalar version.
  if (Legal->isUniformAfterVectorization(I))
    VF.Width = 1;

  Type *VectorTy;
  unsigned C = getInstructionCost(I, VF, VectorTy);

  bool TypeNotScalarized =
      VF.Width > 1 && !VectorTy->isVoidTy() &&
      TTI.getNumberOfParts(VectorTy) < VF.Width;
  return VectorizationCostTy(C, TypeNotScalarized);
}

unsigned LoopVectorizationCostModel::getInstructionCost(Instruction *I,
                                                        VectorizationFactor VF,
                                                        Type *&VectorTy) {
  Type *RetTy = I->getType();
  if (VF.Width > 1 && MinBWs.count(I))
    RetTy = IntegerType::get(RetTy->getContext(), MinBWs[I]);
  VectorTy = ToVectorTy(RetTy, VF);
  auto SE = PSE.getSE();

  // TODO: We need to estimate the cost of intrinsic calls.
  switch (I->getOpcode()) {
  case Instruction::GetElementPtr:
    // We mark this instruction as zero-cost because the cost of GEPs in
    // vectorized code depends on whether the corresponding memory instruction
    // is scalarized or not. Therefore, we handle GEPs with the memory
    // instruction cost.
    return 0;
  case Instruction::Br: {
    return TTI.getCFInstrCost(I->getOpcode());
  }
  case Instruction::PHI: {
    auto *Phi = cast<PHINode>(I);

    // First-order recurrences are replaced by vector shuffles inside the loop.
    // TODO: Does getShuffleCost need special handling for scalable vectors?
    if (VF.Width > 1 && Legal->isFirstOrderRecurrence(Phi))
      return TTI.getShuffleCost(TargetTransformInfo::SK_ExtractSubvector,
                                VectorTy, VF.Width - 1, VectorTy);

    // TODO: IF-converted IFs become selects.
    return 0;
  }
  case Instruction::Add:
  case Instruction::FAdd:
  case Instruction::Sub:
  case Instruction::FSub:
  case Instruction::Mul:
  case Instruction::FMul:
  case Instruction::UDiv:
  case Instruction::SDiv:
  case Instruction::FDiv:
  case Instruction::URem:
  case Instruction::SRem:
  case Instruction::FRem:
  case Instruction::Shl:
  case Instruction::LShr:
  case Instruction::AShr:
  case Instruction::And:
  case Instruction::Or:
  case Instruction::Xor: {
    // Since we will replace the stride by 1 the multiplication should go away.
    if (I->getOpcode() == Instruction::Mul && isStrideMul(I, Legal))
      return 0;
    // Certain instructions can be cheaper to vectorize if they have a constant
    // second vector operand. One example of this are shifts on x86.
    TargetTransformInfo::OperandValueKind Op1VK =
        TargetTransformInfo::OK_AnyValue;
    TargetTransformInfo::OperandValueKind Op2VK =
        TargetTransformInfo::OK_AnyValue;
    TargetTransformInfo::OperandValueProperties Op1VP =
        TargetTransformInfo::OP_None;
    TargetTransformInfo::OperandValueProperties Op2VP =
        TargetTransformInfo::OP_None;
    Value *Op2 = I->getOperand(1);

    // Check for a splat of a constant or for a non uniform vector of constants.
    if (isa<ConstantInt>(Op2)) {
      ConstantInt *CInt = cast<ConstantInt>(Op2);
      if (CInt && CInt->getValue().isPowerOf2())
        Op2VP = TargetTransformInfo::OP_PowerOf2;
      Op2VK = TargetTransformInfo::OK_UniformConstantValue;
    } else if (isa<ConstantVector>(Op2) || isa<ConstantDataVector>(Op2)) {
      Op2VK = TargetTransformInfo::OK_NonUniformConstantValue;
      Constant *SplatValue = cast<Constant>(Op2)->getSplatValue();
      if (SplatValue) {
        ConstantInt *CInt = dyn_cast<ConstantInt>(SplatValue);
        if (CInt && CInt->getValue().isPowerOf2())
          Op2VP = TargetTransformInfo::OP_PowerOf2;
        Op2VK = TargetTransformInfo::OK_UniformConstantValue;
      }
    }

    // Note: When we find a s/zext_to_i32->add->trunc_to_origtype
    //       chain, we ask the target if it has an add for the original
    //       type. This is not allowed in C, so the target should ensure
    //       that the instruction does the sign/zero conversion in 'int'.
    Type *OrigType = nullptr;
    if (isPartOfPromotedAdd(I, &OrigType))
      VectorTy = VectorType::get(OrigType, VF.Width, !VF.isFixed);

    return TTI.getArithmeticInstrCost(I->getOpcode(), VectorTy, Op1VK, Op2VK,
                                      Op1VP, Op2VP);
  }
  case Instruction::Select: {
    SelectInst *SI = cast<SelectInst>(I);
    const SCEV *CondSCEV = SE->getSCEV(SI->getCondition());
    bool ScalarCond = (SE->isLoopInvariant(CondSCEV, TheLoop));
    Type *CondTy = SI->getCondition()->getType();
    if (!ScalarCond)
      CondTy = VectorType::get(CondTy, VF.Width, !VF.isFixed);

    return TTI.getCmpSelInstrCost(I->getOpcode(), VectorTy, CondTy);
  }
  case Instruction::ICmp:
  case Instruction::FCmp: {
    Type *ValTy = I->getOperand(0)->getType();
    Instruction *Op0AsInstruction = dyn_cast<Instruction>(I->getOperand(0));
    auto It = MinBWs.find(Op0AsInstruction);
    if (VF.Width > 1 && It != MinBWs.end())
      ValTy = IntegerType::get(ValTy->getContext(), It->second);
    VectorTy = ToVectorTy(ValTy, VF);
    return TTI.getCmpSelInstrCost(I->getOpcode(), VectorTy);
  }
  case Instruction::Store:
  case Instruction::Load: {
    StoreInst *SI = dyn_cast<StoreInst>(I);
    LoadInst *LI = dyn_cast<LoadInst>(I);
    Type *ValTy = (SI ? SI->getValueOperand()->getType() : LI->getType());
    VectorTy = ToVectorTy(ValTy, VF);

    unsigned Alignment = SI ? SI->getAlignment() : LI->getAlignment();
    unsigned AS =
        SI ? SI->getPointerAddressSpace() : LI->getPointerAddressSpace();
    Value *Ptr = SI ? SI->getPointerOperand() : LI->getPointerOperand();
    // We add the cost of address computation here instead of with the gep
    // instruction because only here we know whether the operation is
    // scalarized.
    if (VF.Width == 1)
      return TTI.getAddressComputationCost(VectorTy) +
             TTI.getMemoryOpCost(I->getOpcode(), VectorTy, Alignment, AS);

    if (LI && Legal->isUniform(Ptr)) {
      // Scalar load + broadcast
      unsigned Cost = TTI.getAddressComputationCost(ValTy->getScalarType());
      Cost += TTI.getMemoryOpCost(I->getOpcode(), ValTy->getScalarType(),
                                  Alignment, AS);
      return Cost +
             TTI.getShuffleCost(TargetTransformInfo::SK_Broadcast, ValTy);
    }

    // For an interleaved access, calculate the total cost of the whole
    // interleave group.
    if (Legal->isAccessInterleaved(I)) {
      auto Group = Legal->getInterleavedAccessGroup(I);
      assert(Group && "Fail to get an interleaved access group.");

      // Only calculate the cost once at the insert position.
      if (Group->getInsertPos() != I)
        return 0;

      unsigned InterleaveFactor = Group->getFactor();
      Type *WideVecTy =
          VectorType::get(VectorTy->getVectorElementType(),
                          VectorTy->getVectorNumElements() * InterleaveFactor,
                          !VF.isFixed);

      // Holds the indices of existing members in an interleaved load group.
      // An interleaved store group doesn't need this as it doesn't allow gaps.
      SmallVector<unsigned, 4> Indices;
      if (LI) {
        for (unsigned i = 0; i < InterleaveFactor; i++)
          if (Group->getMember(i))
            Indices.push_back(i);
      }

      // Calculate the cost of the whole interleaved group.
      unsigned Cost = TTI.getInterleavedMemoryOpCost(
          I->getOpcode(), WideVecTy, Group->getFactor(), Indices,
          Group->getAlignment(), AS);

      if (Group->isReverse())
        Cost +=
            Group->getNumMembers() *
            TTI.getShuffleCost(TargetTransformInfo::SK_Reverse, VectorTy, 0);

      // FIXME: The interleaved load group with a huge gap could be even more
      // expensive than scalar operations. Then we could ignore such group and
      // use scalar operations instead.
      return Cost;
    }

    const DataLayout &DL = I->getModule()->getDataLayout();
    unsigned ScalarAllocatedSize = DL.getTypeAllocSize(ValTy);
    unsigned VectorElementSize = DL.getTypeStoreSize(VectorTy) / VF.Width;

    // Get information about vector memory access
    MemAccessInfo MAI = calculateMemAccessInfo(I, VectorTy, Legal, SE);

    // If there are no vector memory operations to support the stride,
    // get the cost for scalarizing the operation.
    if (!TTI.hasVectorMemoryOp(I->getOpcode(), VectorTy, MAI) ||
        ScalarAllocatedSize != VectorElementSize) {
      // Get cost of scalarizing
//      bool IsComplexComputation =
//          isLikelyComplexAddressComputation(Ptr, Legal, SE, TheLoop);
      unsigned Cost = 0;
      // The cost of extracting from the value vector and pointer vector.
      Type *PtrTy = ToVectorTy(Ptr->getType(), VF);
      for (unsigned i = 0; i < VF.Width; ++i) {
        //  The cost of extracting the pointer operand.
        Cost += TTI.getVectorInstrCost(Instruction::ExtractElement, PtrTy, i);
        // In case of STORE, the cost of ExtractElement from the vector.
        // In case of LOAD, the cost of InsertElement into the returned
        // vector.
        Cost += TTI.getVectorInstrCost(SI ? Instruction::ExtractElement
                                          : Instruction::InsertElement,
                                       VectorTy, i);
      }

      // The cost of the scalar loads/stores.
      /* TODO: Replace this with community code?
      Cost += VF.Width *
              TTI.getAddressComputationCost(PtrTy, IsComplexComputation);
       */
      Cost += VF.Width *
              TTI.getMemoryOpCost(I->getOpcode(), ValTy->getScalarType(),
                                  Alignment, AS);
      return Cost;
    }

    unsigned Cost = TTI.getAddressComputationCost(VectorTy);
    Cost += TTI.getVectorMemoryOpCost(I->getOpcode(), VectorTy, Ptr,
                                      Alignment, AS, MAI, I);

    if (MAI.isStrided() && MAI.isReversed())
      Cost +=
          TTI.getShuffleCost(TargetTransformInfo::SK_Reverse, VectorTy, 0);
    else if (MAI.isUniform())
      Cost += TTI.getShuffleCost(TargetTransformInfo::SK_Broadcast,
                                  VectorTy, 0);
    return Cost;
  }
  case Instruction::ZExt:
  case Instruction::SExt:
  case Instruction::FPToUI:
  case Instruction::FPToSI:
  case Instruction::FPExt:
  case Instruction::PtrToInt:
  case Instruction::IntToPtr:
  case Instruction::SIToFP:
  case Instruction::UIToFP:
  case Instruction::Trunc:
  case Instruction::FPTrunc:
  case Instruction::BitCast: {
    // We optimize the truncation of induction variable.
    // The cost of these is the same as the scalar operation.
    if (I->getOpcode() == Instruction::Trunc &&
        Legal->isInductionVariable(I->getOperand(0)))
      return TTI.getCastInstrCost(I->getOpcode(), I->getType(),
                                  I->getOperand(0)->getType());
// TODO: determine if still useful, deleting isPartOfPromotedAdd if not
//    // Don't count these
//    if (isPartOfPromotedAdd(I, nullptr))
//      return 0;
//
//    Type *SrcVecTy = ToVectorTy(I->getOperand(0)->getType(), VF);

    Type *SrcScalarTy = I->getOperand(0)->getType();
    Type *SrcVecTy = ToVectorTy(SrcScalarTy, VF);
    if (VF.Width > 1 && MinBWs.count(I)) {
      // This cast is going to be shrunk. This may remove the cast or it might
      // turn it into slightly different cast. For example, if MinBW == 16,
      // "zext i8 %1 to i32" becomes "zext i8 %1 to i16".
      //
      // Calculate the modified src and dest types.
      Type *MinVecTy = VectorTy;
      if (I->getOpcode() == Instruction::Trunc) {
        SrcVecTy = smallestIntegerVectorType(SrcVecTy, MinVecTy);
        VectorTy =
            largestIntegerVectorType(ToVectorTy(I->getType(), VF), MinVecTy);
      } else if (I->getOpcode() == Instruction::ZExt ||
                 I->getOpcode() == Instruction::SExt) {
        SrcVecTy = largestIntegerVectorType(SrcVecTy, MinVecTy);
        VectorTy =
            smallestIntegerVectorType(ToVectorTy(I->getType(), VF), MinVecTy);
      }
    }

    return TTI.getCastInstrCost(I->getOpcode(), VectorTy, SrcVecTy);
  }
  case Instruction::Call: {
    bool NeedToScalarize;
    CallInst *CI = cast<CallInst>(I);
    unsigned CallCost =
        getVectorCallCost(CI, VF, TTI, TLI, *Legal, NeedToScalarize);
    if (getVectorIntrinsicIDForCall(CI, TLI))
      return std::min(CallCost, getVectorIntrinsicCost(CI, VF.Width, TTI, TLI));
    return CallCost;
  }
  default: {
    // We are scalarizing the instruction. Return the cost of the scalar
    // instruction, plus the cost of insert and extract into vector
    // elements, times the vector width.
    unsigned Cost = 0;

    if (!RetTy->isVoidTy() && VF.Width != 1) {
      unsigned InsCost =
          TTI.getVectorInstrCost(Instruction::InsertElement,
                                                VectorTy);
      unsigned ExtCost =
          TTI.getVectorInstrCost(Instruction::ExtractElement,
                                                VectorTy);

      // The cost of inserting the results plus extracting each one of the
      // operands.
      Cost += VF.Width * (InsCost + ExtCost * I->getNumOperands());
    }

    // The cost of executing VF copies of the scalar instruction. This opcode
    // is unknown. Assume that it is the same as 'mul'.
    Cost += VF.Width * TTI.getArithmeticInstrCost(Instruction::Mul, VectorTy);
    return Cost;
  }
  } // end of switch.
}

char SVELoopVectorize::ID = 0;
static const char lv_name[] = "SVE Loop Vectorization";
INITIALIZE_PASS_BEGIN(SVELoopVectorize, LV_NAME, lv_name, false, false)
INITIALIZE_PASS_DEPENDENCY(TargetTransformInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(BasicAAWrapperPass)
INITIALIZE_PASS_DEPENDENCY(AAResultsWrapperPass)
INITIALIZE_PASS_DEPENDENCY(GlobalsAAWrapperPass)
INITIALIZE_PASS_DEPENDENCY(AssumptionCacheTracker)
INITIALIZE_PASS_DEPENDENCY(BlockFrequencyInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(DominatorTreeWrapperPass)
INITIALIZE_PASS_DEPENDENCY(ScalarEvolutionWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LoopInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LoopSimplify)
INITIALIZE_PASS_DEPENDENCY(LoopAccessLegacyAnalysis)
INITIALIZE_PASS_DEPENDENCY(DemandedBitsWrapperPass)
INITIALIZE_PASS_DEPENDENCY(OptimizationRemarkEmitterWrapperPass)
INITIALIZE_PASS_END(SVELoopVectorize, LV_NAME, lv_name, false, false)

namespace llvm {
Pass *createSVELoopVectorizePass(bool NoUnrolling, bool AlwaysVectorize) {
  return new SVELoopVectorize(NoUnrolling, AlwaysVectorize);
}
}

bool LoopVectorizationCostModel::isConsecutiveLoadOrStore(Instruction *Inst) {
  // Check for a store.
  if (StoreInst *ST = dyn_cast<StoreInst>(Inst))
    return Legal->isConsecutivePtr(ST->getPointerOperand()) != 0;

  // Check for a load.
  if (LoadInst *LI = dyn_cast<LoadInst>(Inst))
    return Legal->isConsecutivePtr(LI->getPointerOperand()) != 0;

  return false;
}

void LoopVectorizationCostModel::collectValuesToIgnore() {
  // Ignore ephemeral values.
  CodeMetrics::collectEphemeralValues(TheLoop, AC, ValuesToIgnore);

  // Ignore type-promoting instructions we identified during reduction
  // detection.
  for (auto &Reduction : *Legal->getReductionVars()) {
    RecurrenceDescriptor &RedDes = Reduction.second;
    SmallPtrSetImpl<Instruction *> &Casts = RedDes.getCastInsts();
    VecValuesToIgnore.insert(Casts.begin(), Casts.end());
  }

  // Ignore induction phis that are only used in either GetElementPtr or ICmp
  // instruction to exit loop. Induction variables usually have large types and
  // can have big impact when estimating register usage.
  // This is for when VF > 1.
  for (auto &Induction : *Legal->getInductionVars()) {
    auto *PN = Induction.first;
    auto *UpdateV = PN->getIncomingValueForBlock(TheLoop->getLoopLatch());

    // Check that the PHI is only used by the induction increment (UpdateV) or
    // by GEPs. Then check that UpdateV is only used by a compare instruction or
    // the loop header PHI.
    // FIXME: Need precise def-use analysis to determine if this instruction
    // variable will be vectorized.
    if (std::all_of(PN->user_begin(), PN->user_end(),
                    [&](const User *U) -> bool {
                      return U == UpdateV || isa<GetElementPtrInst>(U);
                    }) &&
        std::all_of(UpdateV->user_begin(), UpdateV->user_end(),
                    [&](const User *U) -> bool {
                      return U == PN || isa<ICmpInst>(U);
                    })) {
      VecValuesToIgnore.insert(PN);
      VecValuesToIgnore.insert(UpdateV);
    }
  }

  // Ignore instructions that will not be vectorized.
  // This is for when VF > 1.
  for (auto bb = TheLoop->block_begin(), be = TheLoop->block_end(); bb != be;
       ++bb) {
    for (auto &Inst : **bb) {
      switch (Inst.getOpcode())
      case Instruction::GetElementPtr: {
        // Ignore GEP if its last operand is an induction variable so that it is
        // a consecutive load/store and won't be vectorized as scatter/gather
        // pattern.

        GetElementPtrInst *Gep = cast<GetElementPtrInst>(&Inst);
        unsigned NumOperands = Gep->getNumOperands();
        unsigned InductionOperand = getGEPInductionOperand(Gep);
        bool GepToIgnore = true;

        // Check that all of the gep indices are uniform except for the
        // induction operand.
        for (unsigned i = 0; i != NumOperands; ++i) {
          if (i != InductionOperand &&
              !PSE.getSE()->isLoopInvariant(PSE.getSCEV(Gep->getOperand(i)),
                                            TheLoop)) {
            GepToIgnore = false;
            break;
          }
        }

        if (GepToIgnore)
          VecValuesToIgnore.insert(&Inst);
        break;
      }
    }
  }
}

void InnerLoopUnroller::scalarizeInstruction(Instruction *Instr,
                                             bool IfPredicateStore) {
  assert(!Instr->getType()->isAggregateType() && "Can't handle vectors");
  // Holds vector parameters or scalars, in case of uniform vals.
  SmallVector<VectorParts, 4> Params;

  setDebugLocFromInst(Builder, Instr);

  // Find all of the vectorized parameters.
  for (unsigned op = 0, e = Instr->getNumOperands(); op != e; ++op) {
    Value *SrcOp = Instr->getOperand(op);

    // If we are accessing the old induction variable, use the new one.
    if (SrcOp == OldInduction) {
      Params.push_back(getVectorValue(SrcOp));
      continue;
    }

    // Try using previously calculated values.
    Instruction *SrcInst = dyn_cast<Instruction>(SrcOp);

    // If the src is an instruction that appeared earlier in the basic block
    // then it should already be vectorized.
    if (SrcInst && OrigLoop->contains(SrcInst)) {
      assert(WidenMap.has(SrcInst) && "Source operand is unavailable");
      // The parameter is a vector value from earlier.
      Params.push_back(WidenMap.get(SrcInst));
    } else {
      // The parameter is a scalar from outside the loop. Maybe even a constant.
      VectorParts Scalars;
      Scalars.append(UF, SrcOp);
      Params.push_back(Scalars);
    }
  }

  assert(Params.size() == Instr->getNumOperands() &&
         "Invalid number of operands");

  // Does this instruction return a value ?
  bool IsVoidRetTy = Instr->getType()->isVoidTy();

  Value *UndefVec = IsVoidRetTy ? nullptr : UndefValue::get(Instr->getType());
  // Create a new entry in the WidenMap and initialize it to Undef or Null.
  VectorParts &VecResults = WidenMap.splat(Instr, UndefVec);

  VectorParts Cond;
  if (IfPredicateStore) {
    assert(Instr->getParent()->getSinglePredecessor() &&
           "Only support single predecessor blocks");
    Cond = createEdgeMask(Instr->getParent()->getSinglePredecessor(),
                          Instr->getParent());
  }

  // For each vector unroll 'part':
  for (unsigned Part = 0; Part < UF; ++Part) {
    // For each scalar that we create:

    // Start an "if (pred) a[i] = ..." block.
    Value *Cmp = nullptr;
    if (IfPredicateStore) {
      if (Cond[Part]->getType()->isVectorTy())
        Cond[Part] =
            Builder.CreateExtractElement(Cond[Part], Builder.getInt32(0));
      Cmp = Builder.CreateICmp(ICmpInst::ICMP_EQ, Cond[Part],
                               ConstantInt::get(Cond[Part]->getType(), 1));
    }

    Instruction *Cloned = Instr->clone();
    if (!IsVoidRetTy)
      Cloned->setName(Instr->getName() + ".cloned");
    // Replace the operands of the cloned instructions with extracted scalars.
    for (unsigned op = 0, e = Instr->getNumOperands(); op != e; ++op) {
      Value *Op = Params[op][Part];
      Cloned->setOperand(op, Op);
    }

    // Place the cloned scalar in the new loop.
    Builder.Insert(Cloned);

    // If we just cloned a new assumption, add it the assumption cache.
    if (auto *II = dyn_cast<IntrinsicInst>(Cloned))
      if (II->getIntrinsicID() == Intrinsic::assume)
        AC->registerAssumption(II);

    // If the original scalar returns a value we need to place it in a vector
    // so that future users will be able to use it.
    if (!IsVoidRetTy)
      VecResults[Part] = Cloned;

    // End if-block.
    if (IfPredicateStore)
      PredicatedStores.push_back(std::make_pair(cast<StoreInst>(Cloned), Cmp));
  }
}

void InnerLoopUnroller::vectorizeMemoryInstruction(Instruction *Instr) {
  assert(!Legal->isMaskRequired(Instr) &&
         "Unroller does not support masked operations!");
  StoreInst *SI = dyn_cast<StoreInst>(Instr);
  bool IfPredicateStore = (SI && Legal->blockNeedsPredication(SI->getParent()));

  return scalarizeInstruction(Instr, IfPredicateStore);
}

Value *InnerLoopUnroller::reverseVector(Value *Vec) { return Vec; }

Value *InnerLoopUnroller::getBroadcastInstrs(Value *V) { return V; }

Value *InnerLoopUnroller::getStepVector(Value *Val, Value *Start,
                                        const SCEV *StepSCEV,
                                        Instruction::BinaryOps BinOp) {
  const DataLayout &DL = OrigLoop->getHeader()->getModule()->getDataLayout();
  SCEVExpander Exp(*PSE.getSE(), DL, "induction");
  Value *StepValue = Exp.expandCodeFor(StepSCEV, StepSCEV->getType(),
                                       &*Builder.GetInsertPoint());
  return getStepVector(Val, Start, StepValue, BinOp);
}

Value *InnerLoopUnroller::getStepVector(Value *Val, int Start, Value *Step,
                                        Instruction::BinaryOps BinOp) {
  // When unrolling and the VF is 1, we only need to add a simple scalar.
  Type *Ty = Val->getType()->getScalarType();
  return getStepVector(Val, ConstantInt::get(Ty, Start), Step, BinOp);
}

Value *InnerLoopUnroller::getStepVector(Value *Val, Value* Start, Value *Step,
                                        Instruction::BinaryOps BinOp) {
  // When unrolling and the VF is 1, we only need to add a simple scalar.
  assert(!Val->getType()->isVectorTy() && "Val must be a scalar");
  if (Val->getType()->isFloatingPointTy()) {
    if (Start->getType()->isIntegerTy())
      Start = Builder.CreateUIToFP(Start, Val->getType());
    Step = addFastMathFlag(Builder.CreateFMul(Start, Step));
    return addFastMathFlag(Builder.CreateBinOp(BinOp, Val, Step, "fpinduction"));
  }
  return Builder.CreateAdd(Val, Builder.CreateMul(Start, Step), "induction");
}
