#ifndef LLVM_TRANSFORMS_VECTORIZE_LVCOMMON_H
#define LLVM_TRANSFORMS_VECTORIZE_LVCOMMON_H

#include "llvm/Support/CommandLine.h"

namespace llvm {


extern cl::opt<bool> EnableIfConversion;
extern cl::opt<unsigned> TinyTripCountVectorThreshold;
extern cl::opt<bool> MaximizeBandwidth;
extern cl::opt<bool> EnableMemAccessVersioning;
extern cl::opt<bool> EnableInterleavedMemAccesses;
extern cl::opt<unsigned> MaxInterleaveGroupFactor;
extern cl::opt<unsigned> ForceTargetNumScalarRegs;
extern cl::opt<unsigned> ForceTargetNumVectorRegs;
extern cl::opt<unsigned> ForceTargetMaxScalarInterleaveFactor;
extern cl::opt<unsigned> ForceTargetMaxVectorInterleaveFactor;
extern cl::opt<unsigned> ForceTargetInstructionCost;
extern cl::opt<unsigned> SmallLoopCost;
extern cl::opt<bool> LoopVectorizeWithBlockFrequency;
extern cl::opt<bool> EnableLoadStoreRuntimeInterleave;
extern cl::opt<unsigned> NumberOfStoresToPredicate;
extern cl::opt<bool> EnableIndVarRegisterHeur;
extern cl::opt<bool> EnableCondStoresVectorization;
extern cl::opt<unsigned> MaxNestedScalarReductionIC;
extern cl::opt<unsigned> PragmaVectorizeMemoryCheckThreshold;
extern cl::opt<unsigned> VectorizeSCEVCheckThreshold;
extern cl::opt<unsigned> PragmaVectorizeSCEVCheckThreshold;

}

#endif
