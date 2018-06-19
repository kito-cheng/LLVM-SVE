//===- IntrinsicsAARCH64.td - Defines AARCH64 intrinsics ---*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines all of the AARCH64-specific intrinsics.
//
//===----------------------------------------------------------------------===//

let TargetPrefix = "aarch64" in {

def int_aarch64_ldxr : Intrinsic<[llvm_i64_ty], [llvm_anyptr_ty]>;
def int_aarch64_ldaxr : Intrinsic<[llvm_i64_ty], [llvm_anyptr_ty]>;
def int_aarch64_stxr : Intrinsic<[llvm_i32_ty], [llvm_i64_ty, llvm_anyptr_ty]>;
def int_aarch64_stlxr : Intrinsic<[llvm_i32_ty], [llvm_i64_ty, llvm_anyptr_ty]>;

def int_aarch64_ldxp : Intrinsic<[llvm_i64_ty, llvm_i64_ty], [llvm_ptr_ty]>;
def int_aarch64_ldaxp : Intrinsic<[llvm_i64_ty, llvm_i64_ty], [llvm_ptr_ty]>;
def int_aarch64_stxp : Intrinsic<[llvm_i32_ty],
                               [llvm_i64_ty, llvm_i64_ty, llvm_ptr_ty]>;
def int_aarch64_stlxp : Intrinsic<[llvm_i32_ty],
                                [llvm_i64_ty, llvm_i64_ty, llvm_ptr_ty]>;

def int_aarch64_clrex : Intrinsic<[]>;

def int_aarch64_sdiv : Intrinsic<[llvm_anyint_ty], [LLVMMatchType<0>,
                                LLVMMatchType<0>], [IntrNoMem]>;
def int_aarch64_udiv : Intrinsic<[llvm_anyint_ty], [LLVMMatchType<0>,
                                LLVMMatchType<0>], [IntrNoMem]>;

//===----------------------------------------------------------------------===//
// HINT

def int_aarch64_hint : Intrinsic<[], [llvm_i32_ty]>;

//===----------------------------------------------------------------------===//
// Data Barrier Instructions

def int_aarch64_dmb : GCCBuiltin<"__builtin_arm_dmb">, Intrinsic<[], [llvm_i32_ty]>;
def int_aarch64_dsb : GCCBuiltin<"__builtin_arm_dsb">, Intrinsic<[], [llvm_i32_ty]>;
def int_aarch64_isb : GCCBuiltin<"__builtin_arm_isb">, Intrinsic<[], [llvm_i32_ty]>;

}

//===----------------------------------------------------------------------===//
// Advanced SIMD (NEON)

let TargetPrefix = "aarch64" in {  // All intrinsics start with "llvm.aarch64.".
  class AdvSIMD_2Scalar_Float_Intrinsic
    : Intrinsic<[llvm_anyfloat_ty], [LLVMMatchType<0>, LLVMMatchType<0>],
                [IntrNoMem]>;

  class AdvSIMD_FPToIntRounding_Intrinsic
    : Intrinsic<[llvm_anyint_ty], [llvm_anyfloat_ty], [IntrNoMem]>;

  class AdvSIMD_1IntArg_Intrinsic
    : Intrinsic<[llvm_anyint_ty], [LLVMMatchType<0>], [IntrNoMem]>;
  class AdvSIMD_1FloatArg_Intrinsic
    : Intrinsic<[llvm_anyfloat_ty], [LLVMMatchType<0>], [IntrNoMem]>;
  class AdvSIMD_1VectorArg_Intrinsic
    : Intrinsic<[llvm_anyvector_ty], [LLVMMatchType<0>], [IntrNoMem]>;
  class AdvSIMD_1VectorArg_Expand_Intrinsic
    : Intrinsic<[llvm_anyvector_ty], [llvm_anyvector_ty], [IntrNoMem]>;
  class AdvSIMD_1VectorArg_Long_Intrinsic
    : Intrinsic<[llvm_anyvector_ty], [LLVMTruncatedType<0>], [IntrNoMem]>;
  class AdvSIMD_1IntArg_Narrow_Intrinsic
    : Intrinsic<[llvm_anyint_ty], [llvm_anyint_ty], [IntrNoMem]>;
  class AdvSIMD_1VectorArg_Narrow_Intrinsic
    : Intrinsic<[llvm_anyint_ty], [LLVMExtendedType<0>], [IntrNoMem]>;
  class AdvSIMD_1VectorArg_Int_Across_Intrinsic
    : Intrinsic<[llvm_anyint_ty], [llvm_anyvector_ty], [IntrNoMem]>;
  class AdvSIMD_1VectorArg_Float_Across_Intrinsic
    : Intrinsic<[llvm_anyfloat_ty], [llvm_anyvector_ty], [IntrNoMem]>;

  class AdvSIMD_2IntArg_Intrinsic
    : Intrinsic<[llvm_anyint_ty], [LLVMMatchType<0>, LLVMMatchType<0>],
                [IntrNoMem]>;
  class AdvSIMD_2FloatArg_Intrinsic
    : Intrinsic<[llvm_anyfloat_ty], [LLVMMatchType<0>, LLVMMatchType<0>],
                [IntrNoMem]>;
  class AdvSIMD_2VectorArg_Intrinsic
    : Intrinsic<[llvm_anyvector_ty], [LLVMMatchType<0>, LLVMMatchType<0>],
                [IntrNoMem]>;
  class AdvSIMD_2VectorArg_Compare_Intrinsic
    : Intrinsic<[llvm_anyvector_ty], [llvm_anyvector_ty, LLVMMatchType<1>],
                [IntrNoMem]>;
  class AdvSIMD_2Arg_FloatCompare_Intrinsic
    : Intrinsic<[llvm_anyint_ty], [llvm_anyfloat_ty, LLVMMatchType<1>],
                [IntrNoMem]>;
  class AdvSIMD_2VectorArg_Long_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMTruncatedType<0>, LLVMTruncatedType<0>],
                [IntrNoMem]>;
  class AdvSIMD_2VectorArg_Wide_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>, LLVMTruncatedType<0>],
                [IntrNoMem]>;
  class AdvSIMD_2VectorArg_Narrow_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMExtendedType<0>, LLVMExtendedType<0>],
                [IntrNoMem]>;
  class AdvSIMD_2Arg_Scalar_Narrow_Intrinsic
    : Intrinsic<[llvm_anyint_ty],
                [LLVMExtendedType<0>, llvm_i32_ty],
                [IntrNoMem]>;
  class AdvSIMD_2VectorArg_Scalar_Expand_BySize_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [llvm_anyvector_ty],
                [IntrNoMem]>;
  class AdvSIMD_2VectorArg_Scalar_Wide_BySize_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMTruncatedType<0>],
                [IntrNoMem]>;
  class AdvSIMD_2VectorArg_Scalar_Wide_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMTruncatedType<0>, llvm_i32_ty],
                [IntrNoMem]>;
  class AdvSIMD_2VectorArg_Tied_Narrow_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMHalfElementsVectorType<0>, llvm_anyvector_ty],
                [IntrNoMem]>;

  class AdvSIMD_3VectorArg_Intrinsic
      : Intrinsic<[llvm_anyvector_ty],
               [LLVMMatchType<0>, LLVMMatchType<0>, LLVMMatchType<0>],
               [IntrNoMem]>;
  class AdvSIMD_3VectorArg_Scalar_Intrinsic
      : Intrinsic<[llvm_anyvector_ty],
               [LLVMMatchType<0>, LLVMMatchType<0>, llvm_i32_ty],
               [IntrNoMem]>;
  class AdvSIMD_3VectorArg_Tied_Narrow_Intrinsic
      : Intrinsic<[llvm_anyvector_ty],
               [LLVMHalfElementsVectorType<0>, llvm_anyvector_ty,
                LLVMMatchType<1>], [IntrNoMem]>;
  class AdvSIMD_3VectorArg_Scalar_Tied_Narrow_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMHalfElementsVectorType<0>, llvm_anyvector_ty, llvm_i32_ty],
                [IntrNoMem]>;
  class AdvSIMD_CvtFxToFP_Intrinsic
    : Intrinsic<[llvm_anyfloat_ty], [llvm_anyint_ty, llvm_i32_ty],
                [IntrNoMem]>;
  class AdvSIMD_CvtFPToFx_Intrinsic
    : Intrinsic<[llvm_anyint_ty], [llvm_anyfloat_ty, llvm_i32_ty],
                [IntrNoMem]>;
}

// Arithmetic ops

let TargetPrefix = "aarch64", IntrProperties = [IntrNoMem] in {
  // Vector Add Across Lanes
  def int_aarch64_neon_saddv : AdvSIMD_1VectorArg_Int_Across_Intrinsic;
  def int_aarch64_neon_uaddv : AdvSIMD_1VectorArg_Int_Across_Intrinsic;
  def int_aarch64_neon_faddv : AdvSIMD_1VectorArg_Float_Across_Intrinsic;

  // Vector Long Add Across Lanes
  def int_aarch64_neon_saddlv : AdvSIMD_1VectorArg_Int_Across_Intrinsic;
  def int_aarch64_neon_uaddlv : AdvSIMD_1VectorArg_Int_Across_Intrinsic;

  // Vector Halving Add
  def int_aarch64_neon_shadd : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_uhadd : AdvSIMD_2VectorArg_Intrinsic;

  // Vector Rounding Halving Add
  def int_aarch64_neon_srhadd : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_urhadd : AdvSIMD_2VectorArg_Intrinsic;

  // Vector Saturating Add
  def int_aarch64_neon_sqadd : AdvSIMD_2IntArg_Intrinsic;
  def int_aarch64_neon_suqadd : AdvSIMD_2IntArg_Intrinsic;
  def int_aarch64_neon_usqadd : AdvSIMD_2IntArg_Intrinsic;
  def int_aarch64_neon_uqadd : AdvSIMD_2IntArg_Intrinsic;

  // Vector Add High-Half
  // FIXME: this is a legacy intrinsic for aarch64_simd.h. Remove it when that
  // header is no longer supported.
  def int_aarch64_neon_addhn : AdvSIMD_2VectorArg_Narrow_Intrinsic;

  // Vector Rounding Add High-Half
  def int_aarch64_neon_raddhn : AdvSIMD_2VectorArg_Narrow_Intrinsic;

  // Vector Saturating Doubling Multiply High
  def int_aarch64_neon_sqdmulh : AdvSIMD_2IntArg_Intrinsic;

  // Vector Saturating Rounding Doubling Multiply High
  def int_aarch64_neon_sqrdmulh : AdvSIMD_2IntArg_Intrinsic;

  // Vector Polynominal Multiply
  def int_aarch64_neon_pmul : AdvSIMD_2VectorArg_Intrinsic;

  // Vector Long Multiply
  def int_aarch64_neon_smull : AdvSIMD_2VectorArg_Long_Intrinsic;
  def int_aarch64_neon_umull : AdvSIMD_2VectorArg_Long_Intrinsic;
  def int_aarch64_neon_pmull : AdvSIMD_2VectorArg_Long_Intrinsic;

  // 64-bit polynomial multiply really returns an i128, which is not legal. Fake
  // it with a v16i8.
  def int_aarch64_neon_pmull64 :
        Intrinsic<[llvm_v16i8_ty], [llvm_i64_ty, llvm_i64_ty], [IntrNoMem]>;

  // Vector Extending Multiply
  def int_aarch64_neon_fmulx : AdvSIMD_2FloatArg_Intrinsic {
    let IntrProperties = [IntrNoMem, Commutative];
  }

  // Vector Saturating Doubling Long Multiply
  def int_aarch64_neon_sqdmull : AdvSIMD_2VectorArg_Long_Intrinsic;
  def int_aarch64_neon_sqdmulls_scalar
    : Intrinsic<[llvm_i64_ty], [llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;

  // Vector Halving Subtract
  def int_aarch64_neon_shsub : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_uhsub : AdvSIMD_2VectorArg_Intrinsic;

  // Vector Saturating Subtract
  def int_aarch64_neon_sqsub : AdvSIMD_2IntArg_Intrinsic;
  def int_aarch64_neon_uqsub : AdvSIMD_2IntArg_Intrinsic;

  // Vector Subtract High-Half
  // FIXME: this is a legacy intrinsic for aarch64_simd.h. Remove it when that
  // header is no longer supported.
  def int_aarch64_neon_subhn : AdvSIMD_2VectorArg_Narrow_Intrinsic;

  // Vector Rounding Subtract High-Half
  def int_aarch64_neon_rsubhn : AdvSIMD_2VectorArg_Narrow_Intrinsic;

  // Vector Compare Absolute Greater-than-or-equal
  def int_aarch64_neon_facge : AdvSIMD_2Arg_FloatCompare_Intrinsic;

  // Vector Compare Absolute Greater-than
  def int_aarch64_neon_facgt : AdvSIMD_2Arg_FloatCompare_Intrinsic;

  // Vector Absolute Difference
  def int_aarch64_neon_sabd : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_uabd : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_fabd : AdvSIMD_2VectorArg_Intrinsic;

  // Scalar Absolute Difference
  def int_aarch64_sisd_fabd : AdvSIMD_2Scalar_Float_Intrinsic;

  // Vector Max
  def int_aarch64_neon_smax : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_umax : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_fmax : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_fmaxnmp : AdvSIMD_2VectorArg_Intrinsic;

  // Vector Max Across Lanes
  def int_aarch64_neon_smaxv : AdvSIMD_1VectorArg_Int_Across_Intrinsic;
  def int_aarch64_neon_umaxv : AdvSIMD_1VectorArg_Int_Across_Intrinsic;
  def int_aarch64_neon_fmaxv : AdvSIMD_1VectorArg_Float_Across_Intrinsic;
  def int_aarch64_neon_fmaxnmv : AdvSIMD_1VectorArg_Float_Across_Intrinsic;

  // Vector Min
  def int_aarch64_neon_smin : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_umin : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_fmin : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_fminnmp : AdvSIMD_2VectorArg_Intrinsic;

  // Vector Min/Max Number
  def int_aarch64_neon_fminnm : AdvSIMD_2FloatArg_Intrinsic;
  def int_aarch64_neon_fmaxnm : AdvSIMD_2FloatArg_Intrinsic;

  // Vector Min Across Lanes
  def int_aarch64_neon_sminv : AdvSIMD_1VectorArg_Int_Across_Intrinsic;
  def int_aarch64_neon_uminv : AdvSIMD_1VectorArg_Int_Across_Intrinsic;
  def int_aarch64_neon_fminv : AdvSIMD_1VectorArg_Float_Across_Intrinsic;
  def int_aarch64_neon_fminnmv : AdvSIMD_1VectorArg_Float_Across_Intrinsic;

  // Pairwise Add
  def int_aarch64_neon_addp : AdvSIMD_2VectorArg_Intrinsic;

  // Long Pairwise Add
  // FIXME: In theory, we shouldn't need intrinsics for saddlp or
  // uaddlp, but tblgen's type inference currently can't handle the
  // pattern fragments this ends up generating.
  def int_aarch64_neon_saddlp : AdvSIMD_1VectorArg_Expand_Intrinsic;
  def int_aarch64_neon_uaddlp : AdvSIMD_1VectorArg_Expand_Intrinsic;

  // Folding Maximum
  def int_aarch64_neon_smaxp : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_umaxp : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_fmaxp : AdvSIMD_2VectorArg_Intrinsic;

  // Folding Minimum
  def int_aarch64_neon_sminp : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_uminp : AdvSIMD_2VectorArg_Intrinsic;
  def int_aarch64_neon_fminp : AdvSIMD_2VectorArg_Intrinsic;

  // Reciprocal Estimate/Step
  def int_aarch64_neon_frecps : AdvSIMD_2FloatArg_Intrinsic;
  def int_aarch64_neon_frsqrts : AdvSIMD_2FloatArg_Intrinsic;

  // Reciprocal Exponent
  def int_aarch64_neon_frecpx : AdvSIMD_1FloatArg_Intrinsic;

  // Vector Saturating Shift Left
  def int_aarch64_neon_sqshl : AdvSIMD_2IntArg_Intrinsic;
  def int_aarch64_neon_uqshl : AdvSIMD_2IntArg_Intrinsic;

  // Vector Rounding Shift Left
  def int_aarch64_neon_srshl : AdvSIMD_2IntArg_Intrinsic;
  def int_aarch64_neon_urshl : AdvSIMD_2IntArg_Intrinsic;

  // Vector Saturating Rounding Shift Left
  def int_aarch64_neon_sqrshl : AdvSIMD_2IntArg_Intrinsic;
  def int_aarch64_neon_uqrshl : AdvSIMD_2IntArg_Intrinsic;

  // Vector Signed->Unsigned Shift Left by Constant
  def int_aarch64_neon_sqshlu : AdvSIMD_2IntArg_Intrinsic;

  // Vector Signed->Unsigned Narrowing Saturating Shift Right by Constant
  def int_aarch64_neon_sqshrun : AdvSIMD_2Arg_Scalar_Narrow_Intrinsic;

  // Vector Signed->Unsigned Rounding Narrowing Saturating Shift Right by Const
  def int_aarch64_neon_sqrshrun : AdvSIMD_2Arg_Scalar_Narrow_Intrinsic;

  // Vector Narrowing Shift Right by Constant
  def int_aarch64_neon_sqshrn : AdvSIMD_2Arg_Scalar_Narrow_Intrinsic;
  def int_aarch64_neon_uqshrn : AdvSIMD_2Arg_Scalar_Narrow_Intrinsic;

  // Vector Rounding Narrowing Shift Right by Constant
  def int_aarch64_neon_rshrn : AdvSIMD_2Arg_Scalar_Narrow_Intrinsic;

  // Vector Rounding Narrowing Saturating Shift Right by Constant
  def int_aarch64_neon_sqrshrn : AdvSIMD_2Arg_Scalar_Narrow_Intrinsic;
  def int_aarch64_neon_uqrshrn : AdvSIMD_2Arg_Scalar_Narrow_Intrinsic;

  // Vector Shift Left
  def int_aarch64_neon_sshl : AdvSIMD_2IntArg_Intrinsic;
  def int_aarch64_neon_ushl : AdvSIMD_2IntArg_Intrinsic;

  // Vector Widening Shift Left by Constant
  def int_aarch64_neon_shll : AdvSIMD_2VectorArg_Scalar_Wide_BySize_Intrinsic;
  def int_aarch64_neon_sshll : AdvSIMD_2VectorArg_Scalar_Wide_Intrinsic;
  def int_aarch64_neon_ushll : AdvSIMD_2VectorArg_Scalar_Wide_Intrinsic;

  // Vector Shift Right by Constant and Insert
  def int_aarch64_neon_vsri : AdvSIMD_3VectorArg_Scalar_Intrinsic;

  // Vector Shift Left by Constant and Insert
  def int_aarch64_neon_vsli : AdvSIMD_3VectorArg_Scalar_Intrinsic;

  // Vector Saturating Narrow
  def int_aarch64_neon_scalar_sqxtn: AdvSIMD_1IntArg_Narrow_Intrinsic;
  def int_aarch64_neon_scalar_uqxtn : AdvSIMD_1IntArg_Narrow_Intrinsic;
  def int_aarch64_neon_sqxtn : AdvSIMD_1VectorArg_Narrow_Intrinsic;
  def int_aarch64_neon_uqxtn : AdvSIMD_1VectorArg_Narrow_Intrinsic;

  // Vector Saturating Extract and Unsigned Narrow
  def int_aarch64_neon_scalar_sqxtun : AdvSIMD_1IntArg_Narrow_Intrinsic;
  def int_aarch64_neon_sqxtun : AdvSIMD_1VectorArg_Narrow_Intrinsic;

  // Vector Absolute Value
  def int_aarch64_neon_abs : AdvSIMD_1IntArg_Intrinsic;

  // Vector Saturating Absolute Value
  def int_aarch64_neon_sqabs : AdvSIMD_1IntArg_Intrinsic;

  // Vector Saturating Negation
  def int_aarch64_neon_sqneg : AdvSIMD_1IntArg_Intrinsic;

  // Vector Count Leading Sign Bits
  def int_aarch64_neon_cls : AdvSIMD_1VectorArg_Intrinsic;

  // Vector Reciprocal Estimate
  def int_aarch64_neon_urecpe : AdvSIMD_1VectorArg_Intrinsic;
  def int_aarch64_neon_frecpe : AdvSIMD_1FloatArg_Intrinsic;

  // Vector Square Root Estimate
  def int_aarch64_neon_ursqrte : AdvSIMD_1VectorArg_Intrinsic;
  def int_aarch64_neon_frsqrte : AdvSIMD_1FloatArg_Intrinsic;

  // Vector Bitwise Reverse
  def int_aarch64_neon_rbit : AdvSIMD_1VectorArg_Intrinsic;

  // Vector Conversions Between Half-Precision and Single-Precision.
  def int_aarch64_neon_vcvtfp2hf
    : Intrinsic<[llvm_v4i16_ty], [llvm_v4f32_ty], [IntrNoMem]>;
  def int_aarch64_neon_vcvthf2fp
    : Intrinsic<[llvm_v4f32_ty], [llvm_v4i16_ty], [IntrNoMem]>;

  // Vector Conversions Between Floating-point and Fixed-point.
  def int_aarch64_neon_vcvtfp2fxs : AdvSIMD_CvtFPToFx_Intrinsic;
  def int_aarch64_neon_vcvtfp2fxu : AdvSIMD_CvtFPToFx_Intrinsic;
  def int_aarch64_neon_vcvtfxs2fp : AdvSIMD_CvtFxToFP_Intrinsic;
  def int_aarch64_neon_vcvtfxu2fp : AdvSIMD_CvtFxToFP_Intrinsic;

  // Vector FP->Int Conversions
  def int_aarch64_neon_fcvtas : AdvSIMD_FPToIntRounding_Intrinsic;
  def int_aarch64_neon_fcvtau : AdvSIMD_FPToIntRounding_Intrinsic;
  def int_aarch64_neon_fcvtms : AdvSIMD_FPToIntRounding_Intrinsic;
  def int_aarch64_neon_fcvtmu : AdvSIMD_FPToIntRounding_Intrinsic;
  def int_aarch64_neon_fcvtns : AdvSIMD_FPToIntRounding_Intrinsic;
  def int_aarch64_neon_fcvtnu : AdvSIMD_FPToIntRounding_Intrinsic;
  def int_aarch64_neon_fcvtps : AdvSIMD_FPToIntRounding_Intrinsic;
  def int_aarch64_neon_fcvtpu : AdvSIMD_FPToIntRounding_Intrinsic;
  def int_aarch64_neon_fcvtzs : AdvSIMD_FPToIntRounding_Intrinsic;
  def int_aarch64_neon_fcvtzu : AdvSIMD_FPToIntRounding_Intrinsic;

  // Vector FP Rounding: only ties to even is unrepresented by a normal
  // intrinsic.
  def int_aarch64_neon_frintn : AdvSIMD_1FloatArg_Intrinsic;

  // Scalar FP->Int conversions

  // Vector FP Inexact Narrowing
  def int_aarch64_neon_fcvtxn : AdvSIMD_1VectorArg_Expand_Intrinsic;

  // Scalar FP Inexact Narrowing
  def int_aarch64_sisd_fcvtxn : Intrinsic<[llvm_float_ty], [llvm_double_ty],
                                        [IntrNoMem]>;
}

let TargetPrefix = "aarch64" in {  // All intrinsics start with "llvm.aarch64.".
  class AdvSIMD_2Vector2Index_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [llvm_anyvector_ty, llvm_i64_ty, LLVMMatchType<0>, llvm_i64_ty],
                [IntrNoMem]>;
}

// Vector element to element moves
def int_aarch64_neon_vcopy_lane: AdvSIMD_2Vector2Index_Intrinsic;

let TargetPrefix = "aarch64" in {  // All intrinsics start with "llvm.aarch64.".
  class AdvSIMD_1Vec_Load_Intrinsic
      : Intrinsic<[llvm_anyvector_ty], [LLVMAnyPointerType<LLVMMatchType<0>>],
                  [IntrReadMem, IntrArgMemOnly]>;
  class AdvSIMD_1Vec_Store_Lane_Intrinsic
    : Intrinsic<[], [llvm_anyvector_ty, llvm_i64_ty, llvm_anyptr_ty],
                [IntrArgMemOnly, NoCapture<2>]>;

  class AdvSIMD_2Vec_Load_Intrinsic
    : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>],
                [LLVMAnyPointerType<LLVMMatchType<0>>],
                [IntrReadMem, IntrArgMemOnly]>;
  class AdvSIMD_2Vec_Load_Lane_Intrinsic
    : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>],
                [LLVMMatchType<0>, LLVMMatchType<0>,
                 llvm_i64_ty, llvm_anyptr_ty],
                [IntrReadMem, IntrArgMemOnly]>;
  class AdvSIMD_2Vec_Store_Intrinsic
    : Intrinsic<[], [llvm_anyvector_ty, LLVMMatchType<0>,
                     LLVMAnyPointerType<LLVMMatchType<0>>],
                [IntrArgMemOnly, NoCapture<2>]>;
  class AdvSIMD_2Vec_Store_Lane_Intrinsic
    : Intrinsic<[], [llvm_anyvector_ty, LLVMMatchType<0>,
                 llvm_i64_ty, llvm_anyptr_ty],
                [IntrArgMemOnly, NoCapture<3>]>;

  class AdvSIMD_3Vec_Load_Intrinsic
    : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>, LLVMMatchType<0>],
                [LLVMAnyPointerType<LLVMMatchType<0>>],
                [IntrReadMem, IntrArgMemOnly]>;
  class AdvSIMD_3Vec_Load_Lane_Intrinsic
    : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>, LLVMMatchType<0>],
                [LLVMMatchType<0>, LLVMMatchType<0>, LLVMMatchType<0>,
                 llvm_i64_ty, llvm_anyptr_ty],
                [IntrReadMem, IntrArgMemOnly]>;
  class AdvSIMD_3Vec_Store_Intrinsic
    : Intrinsic<[], [llvm_anyvector_ty, LLVMMatchType<0>,
                     LLVMMatchType<0>, LLVMAnyPointerType<LLVMMatchType<0>>],
                [IntrArgMemOnly, NoCapture<3>]>;
  class AdvSIMD_3Vec_Store_Lane_Intrinsic
    : Intrinsic<[], [llvm_anyvector_ty,
                 LLVMMatchType<0>, LLVMMatchType<0>,
                 llvm_i64_ty, llvm_anyptr_ty],
                [IntrArgMemOnly, NoCapture<4>]>;

  class AdvSIMD_4Vec_Load_Intrinsic
    : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>,
                 LLVMMatchType<0>, LLVMMatchType<0>],
                [LLVMAnyPointerType<LLVMMatchType<0>>],
                [IntrReadMem, IntrArgMemOnly]>;
  class AdvSIMD_4Vec_Load_Lane_Intrinsic
    : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>,
                 LLVMMatchType<0>, LLVMMatchType<0>],
                [LLVMMatchType<0>, LLVMMatchType<0>,
                 LLVMMatchType<0>, LLVMMatchType<0>,
                 llvm_i64_ty, llvm_anyptr_ty],
                [IntrReadMem, IntrArgMemOnly]>;
  class AdvSIMD_4Vec_Store_Intrinsic
    : Intrinsic<[], [llvm_anyvector_ty, LLVMMatchType<0>,
                 LLVMMatchType<0>, LLVMMatchType<0>,
                 LLVMAnyPointerType<LLVMMatchType<0>>],
                [IntrArgMemOnly, NoCapture<4>]>;
  class AdvSIMD_4Vec_Store_Lane_Intrinsic
    : Intrinsic<[], [llvm_anyvector_ty, LLVMMatchType<0>,
                 LLVMMatchType<0>, LLVMMatchType<0>,
                 llvm_i64_ty, llvm_anyptr_ty],
                [IntrArgMemOnly, NoCapture<5>]>;
}

// Memory ops

def int_aarch64_neon_ld1x2 : AdvSIMD_2Vec_Load_Intrinsic;
def int_aarch64_neon_ld1x3 : AdvSIMD_3Vec_Load_Intrinsic;
def int_aarch64_neon_ld1x4 : AdvSIMD_4Vec_Load_Intrinsic;

def int_aarch64_neon_st1x2 : AdvSIMD_2Vec_Store_Intrinsic;
def int_aarch64_neon_st1x3 : AdvSIMD_3Vec_Store_Intrinsic;
def int_aarch64_neon_st1x4 : AdvSIMD_4Vec_Store_Intrinsic;

def int_aarch64_neon_ld2 : AdvSIMD_2Vec_Load_Intrinsic;
def int_aarch64_neon_ld3 : AdvSIMD_3Vec_Load_Intrinsic;
def int_aarch64_neon_ld4 : AdvSIMD_4Vec_Load_Intrinsic;

def int_aarch64_neon_ld2lane : AdvSIMD_2Vec_Load_Lane_Intrinsic;
def int_aarch64_neon_ld3lane : AdvSIMD_3Vec_Load_Lane_Intrinsic;
def int_aarch64_neon_ld4lane : AdvSIMD_4Vec_Load_Lane_Intrinsic;

def int_aarch64_neon_ld2r : AdvSIMD_2Vec_Load_Intrinsic;
def int_aarch64_neon_ld3r : AdvSIMD_3Vec_Load_Intrinsic;
def int_aarch64_neon_ld4r : AdvSIMD_4Vec_Load_Intrinsic;

def int_aarch64_neon_st2  : AdvSIMD_2Vec_Store_Intrinsic;
def int_aarch64_neon_st3  : AdvSIMD_3Vec_Store_Intrinsic;
def int_aarch64_neon_st4  : AdvSIMD_4Vec_Store_Intrinsic;

def int_aarch64_neon_st2lane  : AdvSIMD_2Vec_Store_Lane_Intrinsic;
def int_aarch64_neon_st3lane  : AdvSIMD_3Vec_Store_Lane_Intrinsic;
def int_aarch64_neon_st4lane  : AdvSIMD_4Vec_Store_Lane_Intrinsic;

let TargetPrefix = "aarch64" in {  // All intrinsics start with "llvm.aarch64.".
  class AdvSIMD_Tbl1_Intrinsic
    : Intrinsic<[llvm_anyvector_ty], [llvm_v16i8_ty, LLVMMatchType<0>],
                [IntrNoMem]>;
  class AdvSIMD_Tbl2_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [llvm_v16i8_ty, llvm_v16i8_ty, LLVMMatchType<0>], [IntrNoMem]>;
  class AdvSIMD_Tbl3_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [llvm_v16i8_ty, llvm_v16i8_ty, llvm_v16i8_ty,
                 LLVMMatchType<0>],
                [IntrNoMem]>;
  class AdvSIMD_Tbl4_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [llvm_v16i8_ty, llvm_v16i8_ty, llvm_v16i8_ty, llvm_v16i8_ty,
                 LLVMMatchType<0>],
                [IntrNoMem]>;

  class AdvSIMD_Tbx1_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>, llvm_v16i8_ty, LLVMMatchType<0>],
                [IntrNoMem]>;
  class AdvSIMD_Tbx2_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>, llvm_v16i8_ty, llvm_v16i8_ty,
                 LLVMMatchType<0>],
                [IntrNoMem]>;
  class AdvSIMD_Tbx3_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>, llvm_v16i8_ty, llvm_v16i8_ty,
                 llvm_v16i8_ty, LLVMMatchType<0>],
                [IntrNoMem]>;
  class AdvSIMD_Tbx4_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>, llvm_v16i8_ty, llvm_v16i8_ty,
                 llvm_v16i8_ty, llvm_v16i8_ty, LLVMMatchType<0>],
                [IntrNoMem]>;
}
def int_aarch64_neon_tbl1 : AdvSIMD_Tbl1_Intrinsic;
def int_aarch64_neon_tbl2 : AdvSIMD_Tbl2_Intrinsic;
def int_aarch64_neon_tbl3 : AdvSIMD_Tbl3_Intrinsic;
def int_aarch64_neon_tbl4 : AdvSIMD_Tbl4_Intrinsic;

def int_aarch64_neon_tbx1 : AdvSIMD_Tbx1_Intrinsic;
def int_aarch64_neon_tbx2 : AdvSIMD_Tbx2_Intrinsic;
def int_aarch64_neon_tbx3 : AdvSIMD_Tbx3_Intrinsic;
def int_aarch64_neon_tbx4 : AdvSIMD_Tbx4_Intrinsic;

let TargetPrefix = "aarch64" in {
  class Crypto_AES_DataKey_Intrinsic
    : Intrinsic<[llvm_v16i8_ty], [llvm_v16i8_ty, llvm_v16i8_ty], [IntrNoMem]>;

  class Crypto_AES_Data_Intrinsic
    : Intrinsic<[llvm_v16i8_ty], [llvm_v16i8_ty], [IntrNoMem]>;

  // SHA intrinsic taking 5 words of the hash (v4i32, i32) and 4 of the schedule
  // (v4i32).
  class Crypto_SHA_5Hash4Schedule_Intrinsic
    : Intrinsic<[llvm_v4i32_ty], [llvm_v4i32_ty, llvm_i32_ty, llvm_v4i32_ty],
                [IntrNoMem]>;

  // SHA intrinsic taking 5 words of the hash (v4i32, i32) and 4 of the schedule
  // (v4i32).
  class Crypto_SHA_1Hash_Intrinsic
    : Intrinsic<[llvm_i32_ty], [llvm_i32_ty], [IntrNoMem]>;

  // SHA intrinsic taking 8 words of the schedule
  class Crypto_SHA_8Schedule_Intrinsic
    : Intrinsic<[llvm_v4i32_ty], [llvm_v4i32_ty, llvm_v4i32_ty], [IntrNoMem]>;

  // SHA intrinsic taking 12 words of the schedule
  class Crypto_SHA_12Schedule_Intrinsic
    : Intrinsic<[llvm_v4i32_ty], [llvm_v4i32_ty, llvm_v4i32_ty, llvm_v4i32_ty],
                [IntrNoMem]>;

  // SHA intrinsic taking 8 words of the hash and 4 of the schedule.
  class Crypto_SHA_8Hash4Schedule_Intrinsic
    : Intrinsic<[llvm_v4i32_ty], [llvm_v4i32_ty, llvm_v4i32_ty, llvm_v4i32_ty],
                [IntrNoMem]>;
}

// AES
def int_aarch64_crypto_aese   : Crypto_AES_DataKey_Intrinsic;
def int_aarch64_crypto_aesd   : Crypto_AES_DataKey_Intrinsic;
def int_aarch64_crypto_aesmc  : Crypto_AES_Data_Intrinsic;
def int_aarch64_crypto_aesimc : Crypto_AES_Data_Intrinsic;

// SHA1
def int_aarch64_crypto_sha1c  : Crypto_SHA_5Hash4Schedule_Intrinsic;
def int_aarch64_crypto_sha1p  : Crypto_SHA_5Hash4Schedule_Intrinsic;
def int_aarch64_crypto_sha1m  : Crypto_SHA_5Hash4Schedule_Intrinsic;
def int_aarch64_crypto_sha1h  : Crypto_SHA_1Hash_Intrinsic;

def int_aarch64_crypto_sha1su0 : Crypto_SHA_12Schedule_Intrinsic;
def int_aarch64_crypto_sha1su1 : Crypto_SHA_8Schedule_Intrinsic;

// SHA256
def int_aarch64_crypto_sha256h   : Crypto_SHA_8Hash4Schedule_Intrinsic;
def int_aarch64_crypto_sha256h2  : Crypto_SHA_8Hash4Schedule_Intrinsic;
def int_aarch64_crypto_sha256su0 : Crypto_SHA_8Schedule_Intrinsic;
def int_aarch64_crypto_sha256su1 : Crypto_SHA_12Schedule_Intrinsic;

//===----------------------------------------------------------------------===//
// CRC32

let TargetPrefix = "aarch64" in {

def int_aarch64_crc32b  : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty],
    [IntrNoMem]>;
def int_aarch64_crc32cb : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty],
    [IntrNoMem]>;
def int_aarch64_crc32h  : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty],
    [IntrNoMem]>;
def int_aarch64_crc32ch : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty],
    [IntrNoMem]>;
def int_aarch64_crc32w  : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty],
    [IntrNoMem]>;
def int_aarch64_crc32cw : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty],
    [IntrNoMem]>;
def int_aarch64_crc32x  : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i64_ty],
    [IntrNoMem]>;
def int_aarch64_crc32cx : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i64_ty],
    [IntrNoMem]>;
}

//===----------------------------------------------------------------------===//
// SVE

let TargetPrefix = "aarch64" in {  // All intrinsics start with "llvm.aarch64.".
  class AdvSIMD_1Vec_PredLoad_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMVectorSameWidth<0, llvm_i1_ty>, LLVMPointerTo<0>],
                [IntrReadMem, IntrArgMemOnly]>;

  class AdvSIMD_2Vec_PredLoad_Intrinsic
    : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>],
                [LLVMVectorSameWidth<0, llvm_i1_ty>, LLVMPointerTo<0>],
                [IntrReadMem, IntrArgMemOnly]>;

  class AdvSIMD_3Vec_PredLoad_Intrinsic
    : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>, LLVMMatchType<0>],
                [LLVMVectorSameWidth<0, llvm_i1_ty>, LLVMPointerTo<0>],
                [IntrReadMem, IntrArgMemOnly]>;

  class AdvSIMD_4Vec_PredLoad_Intrinsic
    : Intrinsic<[llvm_anyvector_ty, LLVMMatchType<0>,
                 LLVMMatchType<0>, LLVMMatchType<0>],
                [LLVMVectorSameWidth<0, llvm_i1_ty>, LLVMPointerTo<0>],
                [IntrReadMem, IntrArgMemOnly]>;

  class AdvSIMD_1Vec_PredStore_Intrinsic
      : Intrinsic<[],
                  [llvm_anyvector_ty,
                   LLVMVectorSameWidth<0, llvm_i1_ty>, LLVMPointerTo<0>],
                  [IntrArgMemOnly, NoCapture<2>]>;

  class AdvSIMD_2Vec_PredStore_Intrinsic
      : Intrinsic<[],
                  [llvm_anyvector_ty, LLVMMatchType<0>,
                   LLVMVectorSameWidth<0, llvm_i1_ty>, LLVMPointerTo<0>],
                  [IntrArgMemOnly, NoCapture<3>]>;

  class AdvSIMD_3Vec_PredStore_Intrinsic
      : Intrinsic<[],
                  [llvm_anyvector_ty, LLVMMatchType<0>, LLVMMatchType<0>,
                   LLVMVectorSameWidth<0, llvm_i1_ty>, LLVMPointerTo<0>],
                  [IntrArgMemOnly, NoCapture<4>]>;

  class AdvSIMD_4Vec_PredStore_Intrinsic
      : Intrinsic<[],
                  [llvm_anyvector_ty, LLVMMatchType<0>, LLVMMatchType<0>,
                   LLVMMatchType<0>,
                   LLVMVectorSameWidth<0, llvm_i1_ty>, LLVMPointerTo<0>],
                  [IntrArgMemOnly, NoCapture<5>]>;

  class AdvSIMD_2VectorArgIndexed_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMMatchType<0>,
                 llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_3VectorArgIndexed_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMMatchType<0>,
                 LLVMMatchType<0>,
                 llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_Merged1VectorArg_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMMatchType<0>],
                [IntrNoMem]>;

  class AdvSIMD_Pred1VectorArg_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMMatchType<0>],
                [IntrNoMem]>;

  class AdvSIMD_Pred2VectorArg_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMMatchType<0>,
                 LLVMMatchType<0>],
                [IntrNoMem]>;

  class AdvSIMD_Pred3VectorArg_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMMatchType<0>,
                 LLVMMatchType<0>,
                 LLVMMatchType<0>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_Compare_Intrinsic
    : Intrinsic<[LLVMVectorSameWidth<0, llvm_i1_ty>],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 llvm_anyvector_ty,
                 LLVMMatchType<0>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_CompareWide_Intrinsic
    : Intrinsic<[LLVMVectorSameWidth<0, llvm_i1_ty>],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 llvm_anyvector_ty,
                 LLVMType<nxv2i64>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_Saturating_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMVectorSameWidth<0, llvm_i1_ty>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_SaturatingWithPattern_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 llvm_i32_ty,
                 llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_Saturating_N_Intrinsic<LLVMType T>
    : Intrinsic<[T],
                [T, llvm_anyvector_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<LLVMType T>
    : Intrinsic<[T],
                [T, llvm_i32_ty, llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_ShiftWide_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMMatchType<0>,
                 LLVMType<nxv2i64>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_Reduce_Intrinsic
    : Intrinsic<[LLVMVectorElementType<0>],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 llvm_anyvector_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_ReduceWithInit_Intrinsic
    : Intrinsic<[LLVMVectorElementType<0>],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMVectorElementType<0>,
                 llvm_anyvector_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_Unpack_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMSubdivide2VectorType<0>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_ASRD_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMMatchType<0>,
                 llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_CADD_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMMatchType<0>,
                 LLVMMatchType<0>,
                 llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_CMLA_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMMatchType<0>,
                 LLVMMatchType<0>,
                 LLVMMatchType<0>,
                 llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_CMLA_LANE_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMMatchType<0>,
                 LLVMMatchType<0>,
                 llvm_i32_ty,
                 llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_CNT_Intrinsic
    : Intrinsic<[LLVMVectorOfBitcastsToInt<0>],
                [LLVMVectorOfBitcastsToInt<0>,
                 LLVMVectorSameWidth<0, llvm_i1_ty>,
                 llvm_anyvector_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_CNTB_Intrinsic
    : Intrinsic<[llvm_i64_ty],
                [llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_CNTP_Intrinsic
    : Intrinsic<[llvm_i64_ty],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 llvm_anyvector_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_DOT_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMSubdivide4VectorType<0>,
                 LLVMSubdivide4VectorType<0>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_DOT_Indexed_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMSubdivide4VectorType<0>,
                 LLVMSubdivide4VectorType<0>,
                 llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_DUP_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMVectorElementType<0>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_DUPQ_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 llvm_i64_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_EXPA_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMVectorOfBitcastsToInt<0>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_FCVT_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMVectorSameWidth<0, llvm_i1_ty>,
                 llvm_anyvector_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_FCVTZS_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMVectorSameWidth<0, llvm_i1_ty>,
                 llvm_anyvector_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_INSR_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMVectorElementType<0>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_PTRUE_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [llvm_i32_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_PUNPKHI_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMDoubleElementsVectorType<0>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_SCVTF_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMVectorSameWidth<0, llvm_i1_ty>,
                 llvm_anyvector_ty],
                [IntrNoMem]>;

  class AdvSIMD_SVE_SCALE_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMVectorSameWidth<0, llvm_i1_ty>,
                 LLVMMatchType<0>,
                 LLVMVectorOfBitcastsToInt<0>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_PTEST_Intrinsic
    : Intrinsic<[llvm_i1_ty],
                [LLVMType<nxv16i1>,
                 LLVMType<nxv16i1>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_TBL_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>,
                 LLVMVectorOfBitcastsToInt<0>],
                [IntrNoMem]>;

  class AdvSIMD_SVE_WHILE_Intrinsic
    : Intrinsic<[llvm_anyvector_ty],
                [llvm_anyint_ty, LLVMMatchType<1>],
                [IntrNoMem]>;

  // NOTE: There is no relationship between these intrinsics beyond an attempt
  // to reuse currently identical class definitions.
  class AdvSIMD_SVE_SADDV_Intrinsic : AdvSIMD_SVE_CNTP_Intrinsic;
  class AdvSIMD_SVE_TMAD_Intrinsic  : AdvSIMD_2VectorArgIndexed_Intrinsic;
  class AdvSIMD_SVE_TSMUL_Intrinsic : AdvSIMD_SVE_TBL_Intrinsic;
  class AdvSIMD_SVE_TSSEL_Intrinsic : AdvSIMD_SVE_TBL_Intrinsic;

  // This class of intrinsics are not intended to be useful within LLVM IR but
  // are instead here to support some of the more regid parts of the ACLE.
  class Builtin_SVCVT<string name, LLVMType OUT, LLVMType IN>
  : GCCBuiltin<"__builtin_sve_" # name>,
    Intrinsic<[OUT], [OUT, LLVMType<nxv16i1>, IN], [IntrNoMem]>;
}

def llvm_nxv16i1_ty : LLVMType<nxv16i1>;
def llvm_nxv4i32_ty : LLVMType<nxv4i32>;
def llvm_nxv2i64_ty : LLVMType<nxv2i64>;
def llvm_nxv8f16_ty : LLVMType<nxv8f16>;
def llvm_nxv4f32_ty : LLVMType<nxv4f32>;
def llvm_nxv2f64_ty : LLVMType<nxv2f64>;

let TargetPrefix = "aarch64" in {  // All intrinsics start with "llvm.aarch64.".

//
// Loads
//

def int_aarch64_sve_ld2 : AdvSIMD_2Vec_PredLoad_Intrinsic;
def int_aarch64_sve_ld3 : AdvSIMD_3Vec_PredLoad_Intrinsic;
def int_aarch64_sve_ld4 : AdvSIMD_4Vec_PredLoad_Intrinsic;

def int_aarch64_sve_ldff1 : Intrinsic<[llvm_anyvector_ty],
                                      [LLVMVectorSameWidth<0, llvm_i1_ty>,
                                       LLVMPointerToElt<0>],
                                      [IntrReadMem, IntrArgMemOnly]>;

def int_aarch64_sve_ldff1_gather : Intrinsic<[llvm_anyvector_ty],
                                             [LLVMVectorSameWidth<0, llvm_i1_ty>,
                                              LLVMPointerToElt<0>,
                                              LLVMVectorSameWidth<0, llvm_i64_ty>],
                                             [IntrReadMem, IntrArgMemOnly]>;

def int_aarch64_sve_ldnf1 : Intrinsic<[llvm_anyvector_ty],
                                      [LLVMVectorSameWidth<0, llvm_i1_ty>,
                                       LLVMPointerToElt<0>],
                                      [IntrReadMem, IntrArgMemOnly]>;

def int_aarch64_sve_ldnt1 : AdvSIMD_1Vec_PredLoad_Intrinsic;

def int_aarch64_sve_ld1rq : Intrinsic<[llvm_anyvector_ty],
                                      [LLVMVectorSameWidth<0, llvm_i1_ty>,
                                       LLVMPointerToElt<0>],
                                      [IntrReadMem, IntrArgMemOnly]>;

//
// Stores
//

def int_aarch64_sve_st2  : AdvSIMD_2Vec_PredStore_Intrinsic;
def int_aarch64_sve_st3  : AdvSIMD_3Vec_PredStore_Intrinsic;
def int_aarch64_sve_st4  : AdvSIMD_4Vec_PredStore_Intrinsic;

def int_aarch64_sve_stnt1 : AdvSIMD_1Vec_PredStore_Intrinsic;

//
// Prefetches
// Unfortunately, codegen has no distinction between pointer types, and so there
// needs to be some duplication here to encode the data type being prefetched

def int_aarch64_sve_prf : Intrinsic<[], [llvm_anyvector_ty,
                                         llvm_ptr_ty,
                                         llvm_i32_ty], [IntrArgMemOnly]>;
def int_aarch64_sve_prfb_gather : Intrinsic<[],
                                            [llvm_anyvector_ty,
                                             LLVMPointerType<llvm_i8_ty>,
                                             LLVMVectorSameWidth<0,llvm_i64_ty>,
                                             llvm_i32_ty],
                                            [IntrArgMemOnly]>;
def int_aarch64_sve_prfh_gather : Intrinsic<[],
                                            [llvm_anyvector_ty,
                                             LLVMPointerType<llvm_i8_ty>,
                                             LLVMVectorSameWidth<0,llvm_i64_ty>,
                                             llvm_i32_ty],
                                            [IntrArgMemOnly]>;
def int_aarch64_sve_prfw_gather : Intrinsic<[],
                                            [llvm_anyvector_ty,
                                             LLVMPointerType<llvm_i8_ty>,
                                             LLVMVectorSameWidth<0,llvm_i64_ty>,
                                             llvm_i32_ty],
                                            [IntrArgMemOnly]>;
def int_aarch64_sve_prfd_gather : Intrinsic<[],
                                            [llvm_anyvector_ty,
                                             LLVMPointerType<llvm_i8_ty>,
                                             LLVMVectorSameWidth<0,llvm_i64_ty>,
                                             llvm_i32_ty],
                                            [IntrArgMemOnly]>;

//
// Scalar to vector operations
//

def int_aarch64_sve_dup : AdvSIMD_SVE_DUP_Intrinsic;

//
// Arithmetic (Integer & Floating-point)
//

def int_aarch64_sve_abs  : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_add  : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_mad  : AdvSIMD_Pred3VectorArg_Intrinsic;
def int_aarch64_sve_mla  : AdvSIMD_Pred3VectorArg_Intrinsic;
def int_aarch64_sve_mls  : AdvSIMD_Pred3VectorArg_Intrinsic;
def int_aarch64_sve_msb  : AdvSIMD_Pred3VectorArg_Intrinsic;
def int_aarch64_sve_mul  : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_mulx : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_neg  : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_nmad : AdvSIMD_Pred3VectorArg_Intrinsic;
def int_aarch64_sve_nmla : AdvSIMD_Pred3VectorArg_Intrinsic;
def int_aarch64_sve_nmls : AdvSIMD_Pred3VectorArg_Intrinsic;
def int_aarch64_sve_nmsb : AdvSIMD_Pred3VectorArg_Intrinsic;
def int_aarch64_sve_sub  : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_subr : AdvSIMD_Pred2VectorArg_Intrinsic;

//
// Interger arithmetic
//

def int_aarch64_sve_sabd      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_sdiv      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_sdivr     : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_sdot      : AdvSIMD_SVE_DOT_Intrinsic;
def int_aarch64_sve_sdot_lane : AdvSIMD_SVE_DOT_Indexed_Intrinsic;
def int_aarch64_sve_smax      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_smin      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_smulh     : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_sqadd     : AdvSIMD_2VectorArg_Intrinsic;
def int_aarch64_sve_sqsub     : AdvSIMD_2VectorArg_Intrinsic;

def int_aarch64_sve_uabd      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_udiv      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_udivr     : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_udot      : AdvSIMD_SVE_DOT_Intrinsic;
def int_aarch64_sve_udot_lane : AdvSIMD_SVE_DOT_Indexed_Intrinsic;
def int_aarch64_sve_umax      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_umin      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_umulh     : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_uqadd     : AdvSIMD_2VectorArg_Intrinsic;
def int_aarch64_sve_uqsub     : AdvSIMD_2VectorArg_Intrinsic;

//
// Logical operations
//

def int_aarch64_sve_and  : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_bic  : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_cnot : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_eor  : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_not  : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_orr  : AdvSIMD_Pred2VectorArg_Intrinsic;

//
// Shifts
//

def int_aarch64_sve_asr      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_asr_wide : AdvSIMD_SVE_ShiftWide_Intrinsic;
def int_aarch64_sve_asrd     : AdvSIMD_SVE_ASRD_Intrinsic;
def int_aarch64_sve_insr     : AdvSIMD_SVE_INSR_Intrinsic;
def int_aarch64_sve_lsl      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_lsl_wide : AdvSIMD_SVE_ShiftWide_Intrinsic;
def int_aarch64_sve_lsr      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_lsr_wide : AdvSIMD_SVE_ShiftWide_Intrinsic;

//
// Integer reductions
//

def int_aarch64_sve_andv  : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_eorv  : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_orv   : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_saddv : AdvSIMD_SVE_SADDV_Intrinsic;
def int_aarch64_sve_smaxv : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_sminv : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_uaddv : AdvSIMD_SVE_SADDV_Intrinsic;
def int_aarch64_sve_umaxv : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_uminv : AdvSIMD_SVE_Reduce_Intrinsic;

//
// Comparisons (Integer & Floating-point)
//

def int_aarch64_sve_acge : AdvSIMD_SVE_Compare_Intrinsic;
def int_aarch64_sve_acgt : AdvSIMD_SVE_Compare_Intrinsic;

def int_aarch64_sve_cmpeq : AdvSIMD_SVE_Compare_Intrinsic;
def int_aarch64_sve_cmpge : AdvSIMD_SVE_Compare_Intrinsic;
def int_aarch64_sve_cmpgt : AdvSIMD_SVE_Compare_Intrinsic;
def int_aarch64_sve_cmphi : AdvSIMD_SVE_Compare_Intrinsic;
def int_aarch64_sve_cmphs : AdvSIMD_SVE_Compare_Intrinsic;
def int_aarch64_sve_cmpne : AdvSIMD_SVE_Compare_Intrinsic;
def int_aarch64_sve_cmpuo : AdvSIMD_SVE_Compare_Intrinsic;

def int_aarch64_sve_cmpeq_wide : AdvSIMD_SVE_CompareWide_Intrinsic;
def int_aarch64_sve_cmpge_wide : AdvSIMD_SVE_CompareWide_Intrinsic;
def int_aarch64_sve_cmpgt_wide : AdvSIMD_SVE_CompareWide_Intrinsic;
def int_aarch64_sve_cmphi_wide : AdvSIMD_SVE_CompareWide_Intrinsic;
def int_aarch64_sve_cmphs_wide : AdvSIMD_SVE_CompareWide_Intrinsic;
def int_aarch64_sve_cmple_wide : AdvSIMD_SVE_CompareWide_Intrinsic;
def int_aarch64_sve_cmplo_wide : AdvSIMD_SVE_CompareWide_Intrinsic;
def int_aarch64_sve_cmpls_wide : AdvSIMD_SVE_CompareWide_Intrinsic;
def int_aarch64_sve_cmplt_wide : AdvSIMD_SVE_CompareWide_Intrinsic;
def int_aarch64_sve_cmpne_wide : AdvSIMD_SVE_CompareWide_Intrinsic;

//
// While comparisons
//

def int_aarch64_sve_whilele : AdvSIMD_SVE_WHILE_Intrinsic;
def int_aarch64_sve_whilelo : AdvSIMD_SVE_WHILE_Intrinsic;
def int_aarch64_sve_whilels : AdvSIMD_SVE_WHILE_Intrinsic;
def int_aarch64_sve_whilelt : AdvSIMD_SVE_WHILE_Intrinsic;

//
// Counting bits
//

def int_aarch64_sve_cls : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_clz : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_cnt : AdvSIMD_SVE_CNT_Intrinsic;

//
// Conversion
//

def int_aarch64_sve_sxtb : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_sxth : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_sxtw : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_uxtb : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_uxth : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_uxtw : AdvSIMD_Merged1VectorArg_Intrinsic;

//
// Reversal
//

def int_aarch64_sve_rbit : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_revb : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_revh : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_revw : AdvSIMD_Merged1VectorArg_Intrinsic;

//
// Floating-point arithmetic
//

def int_aarch64_sve_abd       : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_cadd      : AdvSIMD_SVE_CADD_Intrinsic;
def int_aarch64_sve_cmla      : AdvSIMD_SVE_CMLA_Intrinsic;
def int_aarch64_sve_cmla_lane : AdvSIMD_SVE_CMLA_LANE_Intrinsic;
def int_aarch64_sve_div       : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_divr      : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_expa      : AdvSIMD_SVE_EXPA_Intrinsic;
def int_aarch64_sve_max       : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_maxnm     : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_min       : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_minnm     : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_mla_lane  : AdvSIMD_3VectorArgIndexed_Intrinsic;
def int_aarch64_sve_mls_lane  : AdvSIMD_3VectorArgIndexed_Intrinsic;
def int_aarch64_sve_mul_lane  : AdvSIMD_2VectorArgIndexed_Intrinsic;
def int_aarch64_sve_recpe     : AdvSIMD_1VectorArg_Intrinsic;
def int_aarch64_sve_recps     : AdvSIMD_2VectorArg_Intrinsic;
def int_aarch64_sve_recpx     : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_rinta     : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_rinti     : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_rintm     : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_rintn     : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_rintp     : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_rintx     : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_rintz     : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_rsqrte    : AdvSIMD_1VectorArg_Intrinsic;
def int_aarch64_sve_rsqrts    : AdvSIMD_2VectorArg_Intrinsic;
def int_aarch64_sve_scale     : AdvSIMD_SVE_SCALE_Intrinsic;
def int_aarch64_sve_sqrt      : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_tmad      : AdvSIMD_SVE_TMAD_Intrinsic;
def int_aarch64_sve_tsmul     : AdvSIMD_SVE_TSMUL_Intrinsic;
def int_aarch64_sve_tssel     : AdvSIMD_SVE_TSSEL_Intrinsic;

//
// Floating-point reductions
//

def int_aarch64_sve_adda   : AdvSIMD_SVE_ReduceWithInit_Intrinsic;
def int_aarch64_sve_addv   : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_maxv   : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_maxnmv : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_minv   : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_minnmv : AdvSIMD_SVE_Reduce_Intrinsic;

//
// Floating-point conversions
//

def int_aarch64_sve_fcvt   : AdvSIMD_SVE_FCVT_Intrinsic;
def int_aarch64_sve_fcvtzs : AdvSIMD_SVE_FCVTZS_Intrinsic;
def int_aarch64_sve_fcvtzu : AdvSIMD_SVE_FCVTZS_Intrinsic;
def int_aarch64_sve_scvtf  : AdvSIMD_SVE_SCVTF_Intrinsic;
def int_aarch64_sve_ucvtf  : AdvSIMD_SVE_SCVTF_Intrinsic;

// Variants of the above that are closely tied to the ACLE and its regid
// definition of "unused" bits when working with unpacked data types.
// For example, svcvt_f32_s64 expects the top half of active lanes to be zero'd.

def int_aarch64_sve_fcvtzs_i32f16 : Builtin_SVCVT<"svcvt_s32_f16", llvm_nxv4i32_ty, llvm_nxv8f16_ty>;
def int_aarch64_sve_fcvtzs_i32f64 : Builtin_SVCVT<"svcvt_s32_f64", llvm_nxv4i32_ty, llvm_nxv2f64_ty>;
def int_aarch64_sve_fcvtzs_i64f16 : Builtin_SVCVT<"svcvt_s64_f16", llvm_nxv2i64_ty, llvm_nxv8f16_ty>;
def int_aarch64_sve_fcvtzs_i64f32 : Builtin_SVCVT<"svcvt_s64_f32", llvm_nxv2i64_ty, llvm_nxv4f32_ty>;

def int_aarch64_sve_fcvtzu_i32f16 : Builtin_SVCVT<"svcvt_u32_f16", llvm_nxv4i32_ty, llvm_nxv8f16_ty>;
def int_aarch64_sve_fcvtzu_i32f64 : Builtin_SVCVT<"svcvt_u32_f64", llvm_nxv4i32_ty, llvm_nxv2f64_ty>;
def int_aarch64_sve_fcvtzu_i64f16 : Builtin_SVCVT<"svcvt_u64_f16", llvm_nxv2i64_ty, llvm_nxv8f16_ty>;
def int_aarch64_sve_fcvtzu_i64f32 : Builtin_SVCVT<"svcvt_u64_f32", llvm_nxv2i64_ty, llvm_nxv4f32_ty>;

def int_aarch64_sve_fcvt_f16f32   : Builtin_SVCVT<"svcvt_f16_f32", llvm_nxv8f16_ty, llvm_nxv4f32_ty>;
def int_aarch64_sve_fcvt_f16f64   : Builtin_SVCVT<"svcvt_f16_f64", llvm_nxv8f16_ty, llvm_nxv2f64_ty>;
def int_aarch64_sve_fcvt_f32f64   : Builtin_SVCVT<"svcvt_f32_f64", llvm_nxv4f32_ty, llvm_nxv2f64_ty>;

def int_aarch64_sve_fcvt_f32f16   : Builtin_SVCVT<"svcvt_f32_f16", llvm_nxv4f32_ty, llvm_nxv8f16_ty>;
def int_aarch64_sve_fcvt_f64f16   : Builtin_SVCVT<"svcvt_f64_f16", llvm_nxv2f64_ty, llvm_nxv8f16_ty>;
def int_aarch64_sve_fcvt_f64f32   : Builtin_SVCVT<"svcvt_f64_f32", llvm_nxv2f64_ty, llvm_nxv4f32_ty>;

def int_aarch64_sve_scvtf_f16i32  : Builtin_SVCVT<"svcvt_f16_s32", llvm_nxv8f16_ty, llvm_nxv4i32_ty>;
def int_aarch64_sve_scvtf_f16i64  : Builtin_SVCVT<"svcvt_f16_s64", llvm_nxv8f16_ty, llvm_nxv2i64_ty>;
def int_aarch64_sve_scvtf_f32i64  : Builtin_SVCVT<"svcvt_f32_s64", llvm_nxv4f32_ty, llvm_nxv2i64_ty>;
def int_aarch64_sve_scvtf_f64i32  : Builtin_SVCVT<"svcvt_f64_s32", llvm_nxv2f64_ty, llvm_nxv4i32_ty>;

def int_aarch64_sve_ucvtf_f16i32  : Builtin_SVCVT<"svcvt_f16_u32", llvm_nxv8f16_ty, llvm_nxv4i32_ty>;
def int_aarch64_sve_ucvtf_f16i64  : Builtin_SVCVT<"svcvt_f16_u64", llvm_nxv8f16_ty, llvm_nxv2i64_ty>;
def int_aarch64_sve_ucvtf_f32i64  : Builtin_SVCVT<"svcvt_f32_u64", llvm_nxv4f32_ty, llvm_nxv2i64_ty>;
def int_aarch64_sve_ucvtf_f64i32  : Builtin_SVCVT<"svcvt_f64_u32", llvm_nxv2f64_ty, llvm_nxv4i32_ty>;

//
// Permutations and selection
//

// TODO: Consider removing int_aarch64_sve_clasta & int_aarch64_sve_clastb.
def int_aarch64_sve_clasta    : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_clasta_n  : AdvSIMD_SVE_ReduceWithInit_Intrinsic;
def int_aarch64_sve_clastb    : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_clastb_n  : AdvSIMD_SVE_ReduceWithInit_Intrinsic;
def int_aarch64_sve_compact   : AdvSIMD_Pred1VectorArg_Intrinsic;
def int_aarch64_sve_dupq_lane : AdvSIMD_SVE_DUPQ_Intrinsic;
def int_aarch64_sve_ext       : AdvSIMD_2VectorArgIndexed_Intrinsic;
def int_aarch64_sve_lasta     : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_lastb     : AdvSIMD_SVE_Reduce_Intrinsic;
def int_aarch64_sve_rev       : AdvSIMD_1VectorArg_Intrinsic;
def int_aarch64_sve_splice    : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_sunpkhi   : AdvSIMD_SVE_Unpack_Intrinsic;
def int_aarch64_sve_sunpklo   : AdvSIMD_SVE_Unpack_Intrinsic;
def int_aarch64_sve_tbl       : AdvSIMD_SVE_TBL_Intrinsic;
def int_aarch64_sve_trn1      : AdvSIMD_2VectorArg_Intrinsic;
def int_aarch64_sve_trn2      : AdvSIMD_2VectorArg_Intrinsic;
def int_aarch64_sve_uunpkhi   : AdvSIMD_SVE_Unpack_Intrinsic;
def int_aarch64_sve_uunpklo   : AdvSIMD_SVE_Unpack_Intrinsic;
def int_aarch64_sve_uzp1      : AdvSIMD_2VectorArg_Intrinsic;
def int_aarch64_sve_uzp2      : AdvSIMD_2VectorArg_Intrinsic;
def int_aarch64_sve_zip1      : AdvSIMD_2VectorArg_Intrinsic;
def int_aarch64_sve_zip2      : AdvSIMD_2VectorArg_Intrinsic;

//
// Predicate creation
//

def int_aarch64_sve_ptrue : AdvSIMD_SVE_PTRUE_Intrinsic;

//
// Predicate operations
//

def int_aarch64_sve_and_z   : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_bic_z   : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_brka    : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_brka_z  : AdvSIMD_Pred1VectorArg_Intrinsic;
def int_aarch64_sve_brkb    : AdvSIMD_Merged1VectorArg_Intrinsic;
def int_aarch64_sve_brkb_z  : AdvSIMD_Pred1VectorArg_Intrinsic;
def int_aarch64_sve_brkn_z  : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_brkpa_z : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_brkpb_z : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_eor_z   : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_nand_z  : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_nor_z   : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_orn_z   : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_orr_z   : AdvSIMD_Pred2VectorArg_Intrinsic;
def int_aarch64_sve_pfirst  : AdvSIMD_Pred1VectorArg_Intrinsic;
def int_aarch64_sve_pnext   : AdvSIMD_Pred1VectorArg_Intrinsic;
def int_aarch64_sve_punpkhi : AdvSIMD_SVE_PUNPKHI_Intrinsic;
def int_aarch64_sve_punpklo : AdvSIMD_SVE_PUNPKHI_Intrinsic;

//
// Testing predicates
//

def int_aarch64_sve_ptest_any   : GCCBuiltin<"__builtin_sve_svptest_any">,   AdvSIMD_SVE_PTEST_Intrinsic;
def int_aarch64_sve_ptest_first : GCCBuiltin<"__builtin_sve_svptest_first">, AdvSIMD_SVE_PTEST_Intrinsic;
def int_aarch64_sve_ptest_last  : GCCBuiltin<"__builtin_sve_svptest_last">,  AdvSIMD_SVE_PTEST_Intrinsic;

//
// FFR manipulation
//

def int_aarch64_sve_rdffr  : GCCBuiltin<"__builtin_sve_svrdffr">,  Intrinsic<[llvm_nxv16i1_ty], []>;
def int_aarch64_sve_setffr : GCCBuiltin<"__builtin_sve_svsetffr">, Intrinsic<[], []>;
def int_aarch64_sve_wrffr  : GCCBuiltin<"__builtin_sve_svwrffr">,  Intrinsic<[], [llvm_nxv16i1_ty]>;

//
// Counting elements
//

def int_aarch64_sve_cntb : AdvSIMD_SVE_CNTB_Intrinsic;
def int_aarch64_sve_cnth : AdvSIMD_SVE_CNTB_Intrinsic;
def int_aarch64_sve_cntw : AdvSIMD_SVE_CNTB_Intrinsic;
def int_aarch64_sve_cntd : AdvSIMD_SVE_CNTB_Intrinsic;

def int_aarch64_sve_cntp : AdvSIMD_SVE_CNTP_Intrinsic;

//
// Saturating scalara arithmetic
//

def int_aarch64_sve_sqdech : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_sqdecw : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_sqdecd : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_sqdecp : AdvSIMD_SVE_Saturating_Intrinsic;

def int_aarch64_sve_sqdecb_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_sqdecb_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_sqdech_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_sqdech_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_sqdecw_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_sqdecw_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_sqdecd_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_sqdecd_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_sqdecp_n32 : AdvSIMD_SVE_Saturating_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_sqdecp_n64 : AdvSIMD_SVE_Saturating_N_Intrinsic<llvm_i64_ty>;

def int_aarch64_sve_sqinch : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_sqincw : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_sqincd : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_sqincp : AdvSIMD_SVE_Saturating_Intrinsic;

def int_aarch64_sve_sqincb_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_sqincb_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_sqinch_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_sqinch_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_sqincw_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_sqincw_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_sqincd_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_sqincd_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_sqincp_n32 : AdvSIMD_SVE_Saturating_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_sqincp_n64 : AdvSIMD_SVE_Saturating_N_Intrinsic<llvm_i64_ty>;

def int_aarch64_sve_uqdech : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_uqdecw : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_uqdecd : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_uqdecp : AdvSIMD_SVE_Saturating_Intrinsic;

def int_aarch64_sve_uqdecb_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_uqdecb_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_uqdech_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_uqdech_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_uqdecw_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_uqdecw_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_uqdecd_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_uqdecd_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_uqdecp_n32 : AdvSIMD_SVE_Saturating_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_uqdecp_n64 : AdvSIMD_SVE_Saturating_N_Intrinsic<llvm_i64_ty>;

def int_aarch64_sve_uqinch : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_uqincw : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_uqincd : AdvSIMD_SVE_SaturatingWithPattern_Intrinsic;
def int_aarch64_sve_uqincp : AdvSIMD_SVE_Saturating_Intrinsic;

def int_aarch64_sve_uqincb_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_uqincb_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_uqinch_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_uqinch_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_uqincw_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_uqincw_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_uqincd_n32 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_uqincd_n64 : AdvSIMD_SVE_SaturatingWithPattern_N_Intrinsic<llvm_i64_ty>;
def int_aarch64_sve_uqincp_n32 : AdvSIMD_SVE_Saturating_N_Intrinsic<llvm_i32_ty>;
def int_aarch64_sve_uqincp_n64 : AdvSIMD_SVE_Saturating_N_Intrinsic<llvm_i64_ty>;

//
// Reinterpreting data
//

def int_aarch64_sve_reinterpret_bool_b : Intrinsic<[LLVMType<nxv16i1>],
                                                   [llvm_anyvector_ty],
                                                   [IntrNoMem]>;

def int_aarch64_sve_reinterpret_bool_h : Intrinsic<[LLVMType<nxv8i1>],
                                                   [llvm_anyvector_ty],
                                                   [IntrNoMem]>;

def int_aarch64_sve_reinterpret_bool_w : Intrinsic<[LLVMType<nxv4i1>],
                                                   [llvm_anyvector_ty],
                                                   [IntrNoMem]>;

def int_aarch64_sve_reinterpret_bool_d : Intrinsic<[LLVMType<nxv2i1>],
                                                   [llvm_anyvector_ty],
                                                   [IntrNoMem]>;
}
