//===----- SVEExpandLibCall - SVE Lib Call Expansion ----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This pass performs two optimizations:
//
// 1. Scalarizes scalable vector function calls by using the SVE
// pnext predicate generating instruction to efficiently loop through the
// vector arguments for the call, before merging the scalar result into the
// destination vector.
//
// 2. Expands memset and memcpy intrinsics to SVE loops.
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/VectorUtils.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/Local.h"
#include "Utils/AArch64BaseInfo.h"

using namespace llvm;
using namespace llvm::PatternMatch;

#define DEBUG_TYPE "sve-expandlibcall"

STATISTIC(NumExpandedCalls, "Number of SVE libcalls expanded");


static cl::opt<unsigned> ExpandMemCallThreshold(
  "sve-expand-mem-call-threshold", cl::init(128), cl::Hidden,
  cl::desc("Size threshold for expanding memset/memcpy calls to SVE loops"));

static cl::opt<bool> EnableMemCallRuntimeCheck(
  "sve-enable-mem-call-rtcheck", cl::init(true), cl::Hidden,
  cl::desc("Enable runtime check for small memsets/memcpy calls"));

namespace llvm {
  void initializeSVEExpandLibCallPass(PassRegistry &);
}

namespace {
struct SVEExpandLibCall : public FunctionPass {
  static char ID; // Pass identification, replacement for typeid
  SVEExpandLibCall(bool Optimize = true)
        : FunctionPass(ID), Optimize(Optimize) {
    initializeSVEExpandLibCallPass(*PassRegistry::getPassRegistry());
  }

  bool runOnFunction(Function &F) override;
private:
  Function *F;

  /// If Optimize is true, it will also expand calls for optimization purposes
  /// as opposed to lowering only (needed for calls to some vector intrinsics).
  bool Optimize;

  bool ExpandCallToLoop(IntrinsicInst *II);
  bool ExpandMemCallToLoop(MemIntrinsic *II);
  bool ReplaceReduction(IntrinsicInst *II);
  Instruction *CreatePNext(Type* Ty, Value* GP, Value* Pred);
  Instruction *CreateWhile(Intrinsic::ID ID, Type* Ty, Value* Op1, Value* Op2);
  Instruction *CreateLastB(Value* GP, Value* Vec);
  Instruction *CreateMergeCpy(Value *Merge, Value *GP, Value *Scalar);
  Instruction *CreateCall(Intrinsic::ID Id, Type *RetTy,
                          ArrayRef<Value *> Ops);
};
}

char SVEExpandLibCall::ID = 0;
static const char *name = "SVE Vector Lib Call Expansion";
INITIALIZE_PASS_BEGIN(SVEExpandLibCall, DEBUG_TYPE, name, false, false)
INITIALIZE_PASS_END(SVEExpandLibCall, DEBUG_TYPE, name, false, false)

namespace llvm {
FunctionPass *createSVEExpandLibCallPass(bool Optimize) {
  return new SVEExpandLibCall(Optimize);
}
}

// Check if the given instruction is a memory lib call that needs expanding.
static bool isMemLibCall(Instruction *I) {
  IntrinsicInst *II = dyn_cast<IntrinsicInst>(I);
  if (!II)
    return false;

  switch (II->getIntrinsicID()) {
    case Intrinsic::memset:
    case Intrinsic::memcpy:
      return true;
    default:
      break;
  }

  return false;
}

// Check if the given instruction is a vector lib call that needs expanding.
static bool isVectorLibCall(Instruction *I) {
  IntrinsicInst *II;
  if (!(II = dyn_cast<IntrinsicInst>(I)))
    return false;

  switch (II->getIntrinsicID()) {
    case Intrinsic::sin:
    case Intrinsic::cos:
    case Intrinsic::exp:
    case Intrinsic::exp2:
    case Intrinsic::log:
    case Intrinsic::log2:
    case Intrinsic::log10:
    case Intrinsic::pow:
    case Intrinsic::powi:
    case Intrinsic::masked_sin:
    case Intrinsic::masked_cos:
    case Intrinsic::masked_copysign:
    case Intrinsic::masked_exp:
    case Intrinsic::masked_exp2:
    case Intrinsic::masked_log:
    case Intrinsic::masked_log2:
    case Intrinsic::masked_log10:
    case Intrinsic::masked_maxnum:
    case Intrinsic::masked_minnum:
    case Intrinsic::masked_pow:
    case Intrinsic::masked_powi:
    case Intrinsic::masked_rint:
      break;
    default:
      return false;
  }

  // Check the types of the intrinsic call.
  auto RetTy = II->getFunctionType()->getReturnType();
  auto VTy = dyn_cast<VectorType>(RetTy);
  return VTy && VTy->isScalable();
}

static bool isReduction(Instruction *I) {
  auto *II = dyn_cast<IntrinsicInst>(I);
  if (!II)
    return false;

  unsigned VecArg;
  switch (II->getIntrinsicID()) {
  default:
    return false;
  case Intrinsic::experimental_vector_reduce_fadd:
    VecArg = 1;
    break;
  case Intrinsic::experimental_vector_reduce_add:
  case Intrinsic::experimental_vector_reduce_and:
  case Intrinsic::experimental_vector_reduce_or:
  case Intrinsic::experimental_vector_reduce_xor:
  case Intrinsic::experimental_vector_reduce_smax:
  case Intrinsic::experimental_vector_reduce_smin:
  case Intrinsic::experimental_vector_reduce_umax:
  case Intrinsic::experimental_vector_reduce_umin:
  case Intrinsic::experimental_vector_reduce_fmax:
  case Intrinsic::experimental_vector_reduce_fmin:
    VecArg = 0;
    break;
  }

  // Check the types of the intrinsic call.
  auto ParamTy = II->getFunctionType()->getParamType(VecArg);
  auto VTy = dyn_cast<VectorType>(ParamTy);
  return VTy && VTy->isScalable();
}

static Intrinsic::ID getUnmaskedIntrinsic(Intrinsic::ID ID) {
  switch (ID) {
    case Intrinsic::masked_sin:
      return Intrinsic::sin;
    case Intrinsic::masked_cos:
      return Intrinsic::cos;
    case Intrinsic::masked_copysign:
      return Intrinsic::copysign;
    case Intrinsic::masked_exp:
      return Intrinsic::exp;
    case Intrinsic::masked_exp2:
      return Intrinsic::exp2;
    case Intrinsic::masked_log:
      return Intrinsic::log;
    case Intrinsic::masked_log2:
      return Intrinsic::log2;
    case Intrinsic::masked_log10:
      return Intrinsic::log10;
    case Intrinsic::masked_maxnum:
      return Intrinsic::maxnum;
    case Intrinsic::masked_minnum:
      return Intrinsic::minnum;
    case Intrinsic::masked_pow:
      return Intrinsic::pow;
    case Intrinsic::masked_powi:
      return Intrinsic::powi;
    case Intrinsic::masked_rint:
      return Intrinsic::rint;
    default:
      llvm_unreachable("Unexpected intrinsic ID");
  }
}

Instruction *SVEExpandLibCall::CreatePNext(Type* Ty, Value* GP, Value* Pred) {
  SmallVector<Type*, 2> Types = { Ty };
  SmallVector<Value*, 2> Args { GP, Pred };

  Intrinsic::ID IntID = Intrinsic::aarch64_sve_pnext;
  Function *Intr = Intrinsic::getDeclaration(F->getParent(), IntID, Types);
  return CallInst::Create(Intr->getFunctionType(), Intr, Args);
}

/// Create call to specified WHILE intrinsic.
///
Instruction* SVEExpandLibCall::CreateWhile(Intrinsic::ID IntID, Type* Ty,
                                           Value* Op1, Value* Op2) {
  SmallVector<Type*, 2> Types = { Ty, Op1->getType() };
  SmallVector<Value*, 2> Args { Op1, Op2 };

  Function *Intrinsic = Intrinsic::getDeclaration(F->getParent(), IntID, Types);
  return CallInst::Create(Intrinsic->getFunctionType(), Intrinsic, Args);
}


Instruction *SVEExpandLibCall::CreateLastB(Value* GP, Value* Vec) {
  SmallVector<Value*, 2> Args { GP, Vec };

  Intrinsic::ID IntID = Intrinsic::aarch64_sve_lastb;
  auto *Intr = Intrinsic::getDeclaration(F->getParent(), IntID, Vec->getType());
  return CallInst::Create(Intr->getFunctionType(), Intr, Args);
}

Instruction *SVEExpandLibCall::CreateMergeCpy(Value *Merge, Value *GP,
                                              Value *Scalar) {
  auto VecTy = Merge->getType();
  SmallVector<Value*, 4> Args { Merge, GP, Scalar };

  Intrinsic::ID IntID = Intrinsic::aarch64_sve_dup;
  Function *Intr = Intrinsic::getDeclaration(F->getParent(), IntID, { VecTy });
  return CallInst::Create(Intr->getFunctionType(), Intr, Args);
}

Instruction *SVEExpandLibCall::CreateCall(Intrinsic::ID Id,
                                          Type *RetTy, ArrayRef<Value *> Ops) {
  auto Callee = Intrinsic::getDeclaration(F->getParent(), Id,
                                          Ops[0]->getType());
  auto CI = CallInst::Create(Callee->getFunctionType(), Callee, Ops);
  CI->setCallingConv(Callee->getCallingConv());
  return CI;
}

// Expand a call to memcpy or memset into an optimized SVE loop
bool SVEExpandLibCall::ExpandMemCallToLoop(MemIntrinsic *II) {
  if (II->isVolatile())
    return false;

  bool IndexMayOverflow = true;

  if (auto *CI = dyn_cast<ConstantInt>(II->getLength())) {
    if (CI->getZExtValue() < ExpandMemCallThreshold)
      return false;

    // Determine if constant is in range, so that index increment
    // will never overflow.
    if (CI->getZExtValue() < (UINT64_MAX - AArch64::SVEMaxBitsPerVector/8))
      IndexMayOverflow = false;
  }

  DEBUG(dbgs() << "SVEExpandLib: Expanding call to: " <<
                  II->getCalledFunction()->getName() << "\n");

  // Splitting basic block into expand (loop body) block and resume block.
  auto *ParentBlock = II->getParent();
  auto *PHBlock = ParentBlock->splitBasicBlock(II, "mem.ph");
  auto *LoopBlock = PHBlock->splitBasicBlock(II, "mem.exploop");
  auto *MemIntrBlock = LoopBlock->splitBasicBlock(II, "mem.intrinsic");
  auto *ResumeBlock = MemIntrBlock->splitBasicBlock(II, "mem.resume");

  // Fill in the preheader
  BasicBlock::iterator InsertPt(ParentBlock->getTerminator());
  IRBuilder<> Builder(&*InsertPt);

  // Always use a 64bit iteration counter
  Type *IdxTy = Builder.getInt64Ty();

  // Possibly zero-extend the length
  Value *Length = II->getLength();
  if (!Length->getType()->isIntegerTy(64)) {
    Length = Builder.CreateZExt(Length, IdxTy);
    IndexMayOverflow = false;
  }

  // If it was already zero/sign extended, there is no wrap
  if (isa<ZExtInst>(Length))
    IndexMayOverflow = false;

  // Create runtime check based on runtime vector length
  if (EnableMemCallRuntimeCheck) {
    auto *VT = VectorType::get(Builder.getInt8Ty(), 16, true);
    auto *Undef = UndefValue::get(VT);
    auto *EC = Builder.CreateElementCount(Builder.getInt64Ty(), Undef);
    auto *ScalarCompare = Builder.CreateICmpULE(EC, Builder.getInt64(16));
    Builder.CreateCondBr(ScalarCompare, MemIntrBlock, PHBlock);
    ParentBlock->getTerminator()->eraseFromParent();
  }

  // Create the splat (memset)
  Builder.SetInsertPoint(PHBlock->getTerminator());
  auto *ValTy = VectorType::get(Builder.getInt8Ty(), 16, true);
  Value *SetVal = nullptr;
  if (auto *MS = dyn_cast<MemSetInst>(II))
    SetVal =
        Builder.CreateVectorSplat(ValTy->getElementCount(), MS->getValue());

  // Expand the compare (0 < N)
  Value *Zero = ConstantInt::get(IdxTy, 0, false);
  auto *PredTy = VectorType::get(Builder.getInt1Ty(), 16, true);
  auto *PredPH = CreateWhile(Intrinsic::aarch64_sve_whilelo,
                             PredTy, Zero, Length);
  Builder.Insert(PredPH);
  // Fall through into LoopBlock

  // Set Insert point to loop body
  Builder.SetInsertPoint(LoopBlock->getTerminator());

  // Create PHI node for Induction and Predicate
  auto *Pred = Builder.CreatePHI(PredTy, 2);
  Pred->addIncoming(PredPH, PHBlock);

  auto *Ind = Builder.CreatePHI(IdxTy, 2);
  Ind->addIncoming(Zero, PHBlock);
  SmallVector<Value*,1> Indices = { Ind };

  // Create the load (in case of memcpy)
  if (auto *MC = dyn_cast<MemCpyInst>(II)) {
    auto SrcAddr = Builder.CreateGEP(MC->getRawSource(), Indices);
    SrcAddr = Builder.CreateBitCast(SrcAddr, ValTy->getPointerTo());
    SetVal = Builder.CreateMaskedLoad(SrcAddr, II->getAlignment(), Pred);
  }

  assert(SetVal && "No Value to store");

  // Create store
  auto *Addr = Builder.CreateGEP(II->getRawDest(), Indices);
  Addr = Builder.CreateBitCast(Addr, ValTy->getPointerTo());
  Builder.CreateMaskedStore(SetVal, Addr, II->getAlignment(), Pred);

  // Create next.index
  Value *NextInd = nullptr;
  if (IndexMayOverflow) {
    Value *CntVPop = Builder.CreateCntVPop(Pred, "popcnt");
    CntVPop = Builder.CreateZExtOrTrunc(CntVPop, IdxTy);
    NextInd = Builder.CreateNUWAdd(Ind, CntVPop);
  } else {
    Value *EC =
      Builder.CreateElementCount(IdxTy, UndefValue::get(ValTy));
    NextInd = Builder.CreateNUWAdd(Ind, EC);
  }

  Ind->addIncoming(NextInd, LoopBlock);

  // Create next.predicate
  auto *NextPred = CreateWhile(Intrinsic::aarch64_sve_whilelo,
                                PredTy, NextInd, Length);
  Builder.Insert(NextPred);
  Pred->addIncoming(NextPred, LoopBlock);

  // Create test and conditional branch
  Value *Continue = Builder.CreateExtractElement(NextPred, Builder.getInt64(0));
  Builder.CreateCondBr(Continue, LoopBlock, ResumeBlock);
  LoopBlock->getTerminator()->eraseFromParent();

  // Remove the original memset
  II->moveBefore(MemIntrBlock->getTerminator());

  NumExpandedCalls++;
  return true;
}


// Replace generic reduction intrinsics with SVE specific ones.
// We could handle this at the codegen level, but we do it here because the
// VECREDUCE_* SDNodes don't take a predicate, like the IR intrinsics, so we
// have to recover the original predicate from the input vector if it's a
// select. As the original mask may be potentially hoisted out of the block
// it can be more optimal to translate to target specific intrinsics here.
bool SVEExpandLibCall::ReplaceReduction(IntrinsicInst *II) {
  Intrinsic::ID NewID;
  Value *SrcV = II->getArgOperand(0);
  Type *ResultTy = II->getType();
  Type *I64Ty = Type::getInt64Ty(ResultTy->getContext());
  bool Ordered = false;
  FastMathFlags FMF;
  if (isa<FPMathOperator>(II))
    FMF = II->getFastMathFlags();
  
  switch (II->getIntrinsicID()) {
  default:
    llvm_unreachable("Unhandled intrinsic ID");
  case Intrinsic::experimental_vector_reduce_fadd:
    Ordered = !II->getFastMathFlags().unsafeAlgebra();
    NewID = Ordered ? Intrinsic::aarch64_sve_adda : Intrinsic::aarch64_sve_addv;
    SrcV = II->getArgOperand(1);
    break;
  case Intrinsic::experimental_vector_reduce_add:
    NewID = Intrinsic::aarch64_sve_uaddv;
    ResultTy = I64Ty;
    break;
  case Intrinsic::experimental_vector_reduce_and:
    NewID = Intrinsic::aarch64_sve_andv;
    break;
  case Intrinsic::experimental_vector_reduce_or:
    NewID = Intrinsic::aarch64_sve_orv;
    break;
  case Intrinsic::experimental_vector_reduce_xor:
    NewID = Intrinsic::aarch64_sve_eorv;
    break;
  case Intrinsic::experimental_vector_reduce_smax:
    NewID = Intrinsic::aarch64_sve_smaxv;
    break;
  case Intrinsic::experimental_vector_reduce_smin:
    NewID = Intrinsic::aarch64_sve_sminv;
    break;
  case Intrinsic::experimental_vector_reduce_umax:
    NewID = Intrinsic::aarch64_sve_umaxv;
    break;
  case Intrinsic::experimental_vector_reduce_umin:
    NewID = Intrinsic::aarch64_sve_uminv;
    break;
  case Intrinsic::experimental_vector_reduce_fmax:
    NewID = FMF.noNaNs() ? Intrinsic::aarch64_sve_maxnmv
                         : Intrinsic::aarch64_sve_maxv;
    break;
  case Intrinsic::experimental_vector_reduce_fmin:
    NewID = FMF.noNaNs() ? Intrinsic::aarch64_sve_minnmv
                         : Intrinsic::aarch64_sve_minv;
    break;
  }
  // Look for a select between a value and an identity element for a reduction.
  Value *Predicate = nullptr;
  Value *MaskedSrc;
  if (match(SrcV, m_Select(m_Value(Predicate), m_Value(MaskedSrc), m_Zero()))) {
    SrcV = MaskedSrc;
  } else {
    auto EC = cast<VectorType>(SrcV->getType())->getElementCount();
    Type *PredTy =
        VectorType::get(Type::getInt1Ty(SrcV->getType()->getContext()), EC);
    Predicate = ConstantInt::getTrue(PredTy);
  }

  SmallVector<Value *, 2> Args { Predicate };
  SmallVector<Type *, 2> Tys { SrcV->getType() };
  if (Ordered)
    Args.push_back(II->getArgOperand(0));
  Args.push_back(SrcV);
  Function *Decl = Intrinsic::getDeclaration(F->getParent(), NewID, Tys);
  Instruction *Rdx = CallInst::Create(Decl->getFunctionType(), Decl, Args);
  Rdx->insertAfter(II);
  if (II->getType() != Rdx->getType()) {
    assert(Rdx->getType()->isIntegerTy(64) && "Unexpected type mismatch");
    auto *CI = CastInst::CreateTruncOrBitCast(Rdx, II->getType());
    CI->insertAfter(Rdx);
    Rdx = CI;
  }
  II->replaceAllUsesWith(Rdx);
  II->eraseFromParent();
  return true;
}

// Expand the vector intrinsic call to an SVE loop with
bool SVEExpandLibCall::ExpandCallToLoop(IntrinsicInst *II) {
  // We expand intrinsic call in the following code pattern for unpredicated
  // intrinsics. If the intrinsic has a predicate then we need to extract it
  // and use it as the gp for the pnext loop.
  // bb:
  //    %vecparam = <n x 4 x float>
  //    %vecparam2 = <n x 4 x float>
  //    %retval = call <n x 4 x float> @libfunc(%vecparam, %vecparam2)
  // to:
  // bb:
  //    %vecparam = <n x 4 x float>
  //    %vecparam2 = <n x 4 x float>
  //    %gp = sve_pnext(<n x 4 x i1> vecsplat(false))
  //    %output_val = <n x 4 x float> vecsplat(false)
  //    br exploop
  // exploop:
  //    %gp' = phi [%gp, bb], [%gpnext, exploop]
  //    %output_val' = phi [%output_val, bb], [%mergeout, exploop]
  //    %argval = sve_lastb(gp', vecparam)
  //    %argval2 = sve_lastb(gp', vecparam2)
  //    %callret = call float @libfunc(%argval, %argval2)
  //    %mergeout = sve_cpy(output_val', gp', callret)
  //    %gpnext = sve_pnext(%gp')
  //    %test = test any true %gpnext
  //    br i1 %test exploop, resume
  // resume:
  //    %newretval = phi <n x 4 x float> [%mergeout, exploop] ; RAUW old %retval
  auto PHBlock = II->getParent();
  auto LoopBlock = II->getParent()->splitBasicBlock(II, "exploop");
  auto ResumeBlock = LoopBlock->splitBasicBlock(&LoopBlock->front(), "resume");

  const auto IsThereAMaskParam = isMaskedVectorIntrinsic(II->getIntrinsicID());
  const bool IsPredicated = IsThereAMaskParam.first;
  const unsigned MaskPosition = IsThereAMaskParam.second;

  BasicBlock::iterator InsertPt(PHBlock->getTerminator());
  IRBuilder<> Builder(&*InsertPt);

  auto *VecTy = cast<VectorType>(II->getFunctionType()->getReturnType());
  auto EC = VecTy->getElementCount();
  auto ScalarTy = VecTy->getScalarType();
  auto PredTy = VectorType::get(Builder.getInt1Ty(), EC);

  auto PTrue = Builder.CreateVectorSplat(EC, Builder.getTrue());
  auto PFalse = Builder.CreateVectorSplat(EC, Builder.getFalse());
  Value *Predicate = IsPredicated ? II->getArgOperand(MaskPosition) : PTrue;

  auto InitGP = CreatePNext(PredTy, Predicate, PFalse);
  Builder.Insert(InitGP);
  auto InitOutVal = Builder.CreateVectorSplat(EC,
      Builder.getIntN(
        ScalarTy->getPrimitiveSizeInBits(), 0));
  InitOutVal = Builder.CreateBitCast(InitOutVal, VecTy);

  // Generate code for the expansion loop block.
  Builder.SetInsertPoint(LoopBlock->getTerminator());
  auto GP = Builder.CreatePHI(PredTy, 2, "gp");
  GP->addIncoming(InitGP, PHBlock);
  auto OutVal = Builder.CreatePHI(VecTy, 2, "outval");
  OutVal->addIncoming(InitOutVal, PHBlock);

  DEBUG(dbgs() << "SVEExpandLib: Expanding call to: " <<
                  II->getCalledFunction() << "\n");

  SmallVector<Value *, 4> ScalarArgs;

  // Emit code to find the the scalar argument values from original vectors.
  for (unsigned ArgIdx = 0; ArgIdx < II->getNumArgOperands(); ++ArgIdx) {
    // Skip the mask parameter
    if (IsPredicated && (MaskPosition == ArgIdx))
      continue;

    auto Param = II->getOperand(ArgIdx);
    // Optimize cases where the vector is a splat of a scalar, in which case
    // just use the original scalar without re-extracting it using lastb.
    Value *SplatVal;
    Value *LastArg;
    if (!Param->getType()->isVectorTy()) {
      // Scalar arg, pass through
      LastArg = Param;
    } else if (match(Param, m_SplatVector(m_Value(SplatVal))))
      LastArg = SplatVal;
    else {
      LastArg = CreateLastB(GP, Param);
      Builder.Insert(cast<Instruction>(LastArg));
    }
    ScalarArgs.push_back(LastArg);
  }

  // We need to generate a call to the scalar version of the function.
  Intrinsic::ID IID = II->getIntrinsicID();
  if (IsPredicated)
    IID = getUnmaskedIntrinsic(IID);

  auto NewCall = CreateCall(IID, ScalarTy, ScalarArgs);
  NewCall->setName("newcall");
  Builder.Insert(NewCall);

  // Merge in the new scalar call value into the result vector.
  auto MergeCpy = CreateMergeCpy(OutVal, GP, NewCall);
  OutVal->addIncoming(MergeCpy, LoopBlock);
  Builder.Insert(MergeCpy);

  // Generate 'next' predicate for subsequent element.
  auto GPNext = CreatePNext(PredTy, Predicate, GP);
  GP->addIncoming(GPNext, LoopBlock);
  Builder.Insert(GPNext);

  auto Test = getAnyTrueReduction(Builder, GPNext);
  Builder.CreateCondBr(Test, LoopBlock, ResumeBlock);

  // Now remove old terminator br.
  LoopBlock->getTerminator()->eraseFromParent();

  // Replace all uses of the old vector call with the new merged vector.
  Builder.SetInsertPoint(&ResumeBlock->front());
  auto ResumeVec = Builder.CreatePHI(VecTy, 1);
  ResumeVec->addIncoming(MergeCpy, LoopBlock);
  II->replaceAllUsesWith(ResumeVec);
  II->eraseFromParent();
  NumExpandedCalls++;
  return true;
}

bool SVEExpandLibCall::runOnFunction(Function &F) {
  this->F = &F;
  bool Changed = false;
  SmallVector<Instruction *, 4> VectorWorkList;
  SmallVector<Instruction *, 4> MemWorkList;
  SmallVector<Instruction *, 4> ReductionWorkList;

  for (auto I = inst_begin(F), E = inst_end(F); I != E; ++I) {
    if (isVectorLibCall(&*I))
      VectorWorkList.push_back(&*I);
    else if (isMemLibCall(&*I))
      MemWorkList.push_back(&*I);
    else if (isReduction(&*I))
      ReductionWorkList.push_back(&*I);
  }

  for (auto *I : VectorWorkList)
    Changed |= ExpandCallToLoop(cast<IntrinsicInst>(I));

  for (auto *I : ReductionWorkList)
    Changed |= ReplaceReduction(cast<IntrinsicInst>(I));


  // If the target-feature for SVE is not set, we can't generate
  // explicit SVE intrinsics to optimize memsets.
  bool HasSVEAttribute = F.getAttributes()
                             .getFnAttributes()
                             .getAttribute("target-features")
                             .getValueAsString()
                             .contains("+sve");

  if (Optimize && HasSVEAttribute) {
    for (auto I : MemWorkList)
      Changed |= ExpandMemCallToLoop(cast<MemIntrinsic>(I));
  }

  return Changed;
}

