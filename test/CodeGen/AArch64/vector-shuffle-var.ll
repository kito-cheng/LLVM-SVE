; Test that shufflevectors with variable masks are handled correctly.
; Copy of Generic version, with some specific asm tests.
; RUN: llc -mtriple=aarch64--linux-gnu < %s | FileCheck %s

; Test a fully-variable mask.
define <4 x float> @full(<4 x float> %a, <4 x float> %b, <4 x i32> %mask) {
  %res = shufflevector <4 x float> %a, <4 x float> %b, <4 x i32> %mask
  ret <4 x float> %res
}

; Test a mask in which some elements are constants and some are variable.
define <4 x float> @partial(<4 x float> %a, <4 x float> %b, i32 %idx) {
  %mask = insertelement <4 x i32> zeroinitializer, i32 %idx, i32 2
  %res = shufflevector <4 x float> %a, <4 x float> %b, <4 x i32> %mask
  ret <4 x float> %res
}

; Test a mask that can be simplified to an "even element" operation.
; Because on most targets llc doesn't run InstCombine before instruction
; selection, this simplification should happen at the SelectionDAG level.
define <4 x float> @const(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: const
; CHECK: uzp1 v0.4s, v0.4s, v1.4s
; CHECK: ret
  %mask1 = insertelement <4 x i32> zeroinitializer, i32 0, i32 0
  %mask2 = insertelement <4 x i32> %mask1, i32 2, i32 1
  %mask3 = insertelement <4 x i32> %mask2, i32 4, i32 2
  %mask4 = insertelement <4 x i32> %mask3, i32 6, i32 3
  %res = shufflevector <4 x float> %a, <4 x float> %b, <4 x i32> %mask4
  ret <4 x float> %res
}

; Test a mask in which some elements are variable and in which others are
; out of range.  The out-of-range elements produce undefined results at
; run time but the compiler cannot abort on them.
define <4 x float> @partial_oor(<4 x float> %a, <4 x float> %b, i32 %idx) {
  %mask1 = insertelement <4 x i32> zeroinitializer, i32 -1, i32 0
  %mask2 = insertelement <4 x i32> %mask1, i32 8, i32 1
  %mask3 = insertelement <4 x i32> %mask2, i32 %idx, i32 2
  %mask4 = insertelement <4 x i32> %mask3, i32 %idx, i32 3
  %res = shufflevector <4 x float> %a, <4 x float> %b, <4 x i32> %mask4
  ret <4 x float> %res
}

; Likewise for a mask that is fully-constant.
define <4 x float> @const_oor(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: const_oor
; CHECK: rev64
; CHECK: ret
  %mask1 = insertelement <4 x i32> zeroinitializer, i32 -1, i32 0
  %mask2 = insertelement <4 x i32> %mask1, i32 8, i32 1
  %mask3 = insertelement <4 x i32> %mask2, i32 1, i32 2
  %mask4 = insertelement <4 x i32> %mask3, i32 0, i32 3
  %res = shufflevector <4 x float> %a, <4 x float> %b, <4 x i32> %mask4
  ret <4 x float> %res
}

; Test a fully-variable mask in which the result is wider than the operands.
define <4 x i64> @full_widen(<2 x i64> %a, <2 x i64> %b, <4 x i32> %mask) {
  %res = shufflevector <2 x i64> %a, <2 x i64> %b, <4 x i32> %mask
  ret <4 x i64> %res
}

; Test a fully-constant mask in which the result is wider than the operands.
define <4 x i8> @const_widen(<2 x i8> %a, <2 x i8> %b) {
; CHECK-LABEL: const_widen
; CHECK: trn1 v0.4h, v0.4h, v1.4h
; CHECK: ret
  %mask1 = insertelement <4 x i32> zeroinitializer, i32 0, i32 0
  %mask2 = insertelement <4 x i32> %mask1, i32 2, i32 1
  %mask3 = insertelement <4 x i32> %mask2, i32 1, i32 2
  %mask4 = insertelement <4 x i32> %mask3, i32 3, i32 3
  %res = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> %mask4
  ret <4 x i8> %res
}

; Test a fully-variable mask in which the result is shorter than the operands.
define <4 x i64> @full_shorten(<8 x i64> %a, <8 x i64> %b, <4 x i64> %mask) {
  %res = shufflevector <8 x i64> %a, <8 x i64> %b, <4 x i64> %mask
  ret <4 x i64> %res
}

; Test a fully-variable mask that is wider than the values being selected.
define <2 x i8> @full_wide_mask(<2 x i8> %a, <2 x i8> %b, <2 x i64> %mask) {
  %res = shufflevector <2 x i8> %a, <2 x i8> %b, <2 x i64> %mask
  ret <2 x i8> %res
}

; Test a case where all vectors are 1x.
define <1 x i64> @single_res_inp(<1 x i64> %a, <1 x i64> %b, <1 x i2> %mask) {
  %res = shufflevector <1 x i64> %a, <1 x i64> %b, <1 x i2> %mask
  ret <1 x i64> %res
}

; Test a case where the results are 1x but the arguments aren't.
define <1 x i64> @single_res(<2 x i64> %a, <2 x i64> %b, <1 x i5> %mask) {
  %res = shufflevector <2 x i64> %a, <2 x i64> %b, <1 x i5> %mask
  ret <1 x i64> %res
}

; Test a case where the arguments are 1x but the result isn't.
define <8 x i64> @single_inp(<1 x i64> %a, <1 x i64> %b, <8 x i8> %mask) {
  %res = shufflevector <1 x i64> %a, <1 x i64> %b, <8 x i8> %mask
  ret <8 x i64> %res
}

@i = external global i8
@j = external global i8
define <2 x i16> @weird_const(<2 x i16> %a, <2 x i16> %b) {
  %res = shufflevector <2 x i16> %a, <2 x i16> %b,
                       <2 x i64> add(
                         <2 x i64> shufflevector(
                           <2 x i64> insertelement(
                             <2 x i64> undef,
                             i64 ptrtoint(i8* @i to i64), i32 0),
                           <2 x i64> insertelement(
                             <2 x i64> undef,
                             i64 ptrtoint(i8* @j to i64), i32 0),
                           <2 x i32> <i32 0, i32 2>),
                         <2 x i64> <i64 2, i64 4>)
  ret <2 x i16> %res
}
