; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; LDNF1B (contiguous)
;

define <n x 16 x i8> @ldnf1b(<n x 16 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b:
; CHECK: ldnf1b {z0.b}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<n x 16 x i1> %pg, i8* %a)
  ret <n x 16 x i8> %load
}

define <n x 16 x i8> @ldnf1b_vnum(<n x 16 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_vnum:
; CHECK: ldnf1b {z0.b}, p0/z, [x0, #7, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i8* %a to <n x 16 x i8>*
  %t2 = getelementptr <n x 16 x i8>, <n x 16 x i8>* %t1, i64 7
  %base = bitcast <n x 16 x i8>* %t2 to i8*

  %load = call <n x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<n x 16 x i1> %pg, i8* %base)
  ret <n x 16 x i8> %load
}

define <n x 8 x i16> @ldnf1b_h(<n x 8 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_h:
; CHECK: ldnf1b {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<n x 8 x i1> %pg, i8* %a)
  %res = zext <n x 8 x i8> %load to <n x 8 x i16>
  ret <n x 8 x i16> %res
}

define <n x 8 x i16> @ldnf1b_h_vnum(<n x 8 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_h_vnum:
; CHECK: ldnf1b {z0.h}, p0/z, [x0, #6, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i8* %a to <n x 8 x i8>*
  %t2 = getelementptr <n x 8 x i8>, <n x 8 x i8>* %t1, i64 6
  %base = bitcast <n x 8 x i8>* %t2 to i8*

  %load = call <n x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<n x 8 x i1> %pg, i8* %base)
  %res = zext <n x 8 x i8> %load to <n x 8 x i16>
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @ldnf1b_s(<n x 4 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_s:
; CHECK: ldnf1b {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<n x 4 x i1> %pg, i8* %a)
  %res = zext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @ldnf1b_s_vnum(<n x 4 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_s_vnum:
; CHECK: ldnf1b {z0.s}, p0/z, [x0, #5, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i8* %a to <n x 4 x i8>*
  %t2 = getelementptr <n x 4 x i8>, <n x 4 x i8>* %t1, i64 5
  %base = bitcast <n x 4 x i8>* %t2 to i8*

  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<n x 4 x i1> %pg, i8* %base)
  %res = zext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @ldnf1b_d(<n x 2 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_d:
; CHECK: ldnf1b {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<n x 2 x i1> %pg, i8* %a)
  %res = zext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @ldnf1b_d_vnum(<n x 2 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_d_vnum:
; CHECK: ldnf1b {z0.d}, p0/z, [x0, #4, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i8* %a to <n x 2 x i8>*
  %t2 = getelementptr <n x 2 x i8>, <n x 2 x i8>* %t1, i64 4
  %base = bitcast <n x 2 x i8>* %t2 to i8*

  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<n x 2 x i1> %pg, i8* %base)
  %res = zext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDNF1H (contiguous)
;

define <n x 8 x i16> @ldnf1h(<n x 8 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h:
; CHECK: ldnf1h {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<n x 8 x i1> %pg, i16* %a)
  ret <n x 8 x i16> %load
}

define <n x 8 x i16> @ldnf1h_vnum(<n x 8 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h_vnum:
; CHECK: ldnf1h {z0.h}, p0/z, [x0, #3, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i16* %a to <n x 8 x i16>*
  %t2 = getelementptr <n x 8 x i16>, <n x 8 x i16>* %t1, i64 3
  %base = bitcast <n x 8 x i16>* %t2 to i16*

  %load = call <n x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<n x 8 x i1> %pg, i16* %base)
  ret <n x 8 x i16> %load
}

define <n x 4 x i32> @ldnf1h_s(<n x 4 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h_s:
; CHECK: ldnf1h {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldnf1.nxv4i16(<n x 4 x i1> %pg, i16* %a)
  %res = zext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @ldnf1h_s_vnum(<n x 4 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h_s_vnum:
; CHECK: ldnf1h {z0.s}, p0/z, [x0, #2, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i16* %a to <n x 4 x i16>*
  %t2 = getelementptr <n x 4 x i16>, <n x 4 x i16>* %t1, i64 2
  %base = bitcast <n x 4 x i16>* %t2 to i16*

  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldnf1.nxv4i16(<n x 4 x i1> %pg, i16* %base)
  %res = zext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @ldnf1h_d(<n x 2 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h_d:
; CHECK: ldnf1h {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldnf1.nxv2i16(<n x 2 x i1> %pg, i16* %a)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @ldnf1h_d_vnum(<n x 2 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h_d_vnum:
; CHECK: ldnf1h {z0.d}, p0/z, [x0, #1, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i16* %a to <n x 2 x i16>*
  %t2 = getelementptr <n x 2 x i16>, <n x 2 x i16>* %t1, i64 1
  %base = bitcast <n x 2 x i16>* %t2 to i16*

  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldnf1.nxv2i16(<n x 2 x i1> %pg, i16* %base)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDNF1H (contiguous, floating point)
;

define <n x 8 x half> @ldnf1h_f16(<n x 8 x i1> %pg, half* %a) {
; CHECK-LABEL: ldnf1h_f16:
; CHECK: ldnf1h {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 8 x half> @llvm.aarch64.sve.ldnf1.nxv8f16(<n x 8 x i1> %pg, half* %a)
  ret <n x 8 x half> %load
}

define <n x 8 x half> @ldnf1h_f16_vnum(<n x 8 x i1> %pg, half* %a) {
; CHECK-LABEL: ldnf1h_f16_vnum:
; CHECK: ldnf1h {z0.h}, p0/z, [x0, #-1, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast half* %a to <n x 8 x half>*
  %t2 = getelementptr <n x 8 x half>, <n x 8 x half>* %t1, i64 -1
  %base = bitcast <n x 8 x half>* %t2 to half*

  %load = call <n x 8 x half> @llvm.aarch64.sve.ldnf1.nxv8f16(<n x 8 x i1> %pg, half* %base)
  ret <n x 8 x half> %load
}

;
; LDNF1W (contiguous)
;

define <n x 4 x i32> @ldnf1w(<n x 4 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1w:
; CHECK: ldnf1w {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<n x 4 x i1> %pg, i32* %a)
  ret <n x 4 x i32> %load
}

define <n x 4 x i32> @ldnf1w_vnum(<n x 4 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1w_vnum:
; CHECK: ldnf1w {z0.s}, p0/z, [x0, #-2, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i32* %a to <n x 4 x i32>*
  %t2 = getelementptr <n x 4 x i32>, <n x 4 x i32>* %t1, i64 -2
  %base = bitcast <n x 4 x i32>* %t2 to i32*

  %load = call <n x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<n x 4 x i1> %pg, i32* %base)
  ret <n x 4 x i32> %load
}

define <n x 2 x i64> @ldnf1w_d(<n x 2 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1w_d:
; CHECK: ldnf1w {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldnf1.nxv2i32(<n x 2 x i1> %pg, i32* %a)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @ldnf1w_d_vnum(<n x 2 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1w_d_vnum:
; CHECK: ldnf1w {z0.d}, p0/z, [x0, #-3, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i32* %a to <n x 2 x i32>*
  %t2 = getelementptr <n x 2 x i32>, <n x 2 x i32>* %t1, i64 -3
  %base = bitcast <n x 2 x i32>* %t2 to i32*

  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldnf1.nxv2i32(<n x 2 x i1> %pg, i32* %base)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDNF1W (contiguous, floating point)
;

define <n x 4 x float> @ldnf1w_f32(<n x 4 x i1> %pg, float* %a) {
; CHECK-LABEL: ldnf1w_f32:
; CHECK: ldnf1w {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x float> @llvm.aarch64.sve.ldnf1.nxv4f32(<n x 4 x i1> %pg, float* %a)
  ret <n x 4 x float> %load
}

define <n x 4 x float> @ldnf1w_f32_vnum(<n x 4 x i1> %pg, float* %a) {
; CHECK-LABEL: ldnf1w_f32_vnum:
; CHECK: ldnf1w {z0.s}, p0/z, [x0, #-4, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast float* %a to <n x 4 x float>*
  %t2 = getelementptr <n x 4 x float>, <n x 4 x float>* %t1, i64 -4
  %base = bitcast <n x 4 x float>* %t2 to float*

  %load = call <n x 4 x float> @llvm.aarch64.sve.ldnf1.nxv4f32(<n x 4 x i1> %pg, float* %base)
  ret <n x 4 x float> %load
}

;
; LDNF1D (contiguous)
;

define <n x 2 x i64> @ldnf1d(<n x 2 x i1> %pg, i64* %a) {
; CHECK-LABEL: ldnf1d:
; CHECK: ldnf1d {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<n x 2 x i1> %pg, i64* %a)
  ret <n x 2 x i64> %load
}

define <n x 2 x i64> @ldnf1d_vnum(<n x 2 x i1> %pg, i64* %a) {
; CHECK-LABEL: ldnf1d_vnum:
; CHECK: ldnf1d {z0.d}, p0/z, [x0, #-5, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i64* %a to <n x 2 x i64>*
  %t2 = getelementptr <n x 2 x i64>, <n x 2 x i64>* %t1, i64 -5
  %base = bitcast <n x 2 x i64>* %t2 to i64*

  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<n x 2 x i1> %pg, i64* %base)
  ret <n x 2 x i64> %load
}

;
; LDNF1D (contiguous, floating point)
;

define <n x 2 x double> @ldnf1d_f64(<n x 2 x i1> %pg, double* %a) {
; CHECK-LABEL: ldnf1d_f64:
; CHECK: ldnf1d {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x double> @llvm.aarch64.sve.ldnf1.nxv2f64(<n x 2 x i1> %pg, double* %a)
  ret <n x 2 x double> %load
}

define <n x 2 x double> @ldnf1d_f64_vnum(<n x 2 x i1> %pg, double* %a) {
; CHECK-LABEL: ldnf1d_f64_vnum:
; CHECK: ldnf1d {z0.d}, p0/z, [x0, #-6, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast double* %a to <n x 2 x double>*
  %t2 = getelementptr <n x 2 x double>, <n x 2 x double>* %t1, i64 -6
  %base = bitcast <n x 2 x double>* %t2 to double*

  %load = call <n x 2 x double> @llvm.aarch64.sve.ldnf1.nxv2f64(<n x 2 x i1> %pg, double* %base)
  ret <n x 2 x double> %load
}

;
; LDNF1SB (contiguous)
;

define <n x 8 x i16> @ldnf1sb_h(<n x 8 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_h:
; CHECK: ldnf1sb {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<n x 8 x i1> %pg, i8* %a)
  %res = sext <n x 8 x i8> %load to <n x 8 x i16>
  ret <n x 8 x i16> %res
}

define <n x 8 x i16> @ldnf1sb_h_vnum(<n x 8 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_h_vnum:
; CHECK: ldnf1sb {z0.h}, p0/z, [x0, #-7, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i8* %a to <n x 8 x i8>*
  %t2 = getelementptr <n x 8 x i8>, <n x 8 x i8>* %t1, i64 -7
  %base = bitcast <n x 8 x i8>* %t2 to i8*

  %load = call <n x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<n x 8 x i1> %pg, i8* %base)
  %res = sext <n x 8 x i8> %load to <n x 8 x i16>
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @ldnf1sb_s(<n x 4 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_s:
; CHECK: ldnf1sb {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<n x 4 x i1> %pg, i8* %a)
  %res = sext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @ldnf1sb_s_vnum(<n x 4 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_s_vnum:
; CHECK: ldnf1sb {z0.s}, p0/z, [x0, #-8, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i8* %a to <n x 4 x i8>*
  %t2 = getelementptr <n x 4 x i8>, <n x 4 x i8>* %t1, i64 -8
  %base = bitcast <n x 4 x i8>* %t2 to i8*

  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<n x 4 x i1> %pg, i8* %base)
  %res = sext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @ldnf1sb_d(<n x 2 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_d:
; CHECK: ldnf1sb {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<n x 2 x i1> %pg, i8* %a)
  %res = sext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @ldnf1sb_d_vnum(<n x 2 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_d_vnum:
; CHECK: ldnf1sb {z0.d}, p0/z, [x0, #-7, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i8* %a to <n x 2 x i8>*
  %t2 = getelementptr <n x 2 x i8>, <n x 2 x i8>* %t1, i64 -7
  %base = bitcast <n x 2 x i8>* %t2 to i8*

  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<n x 2 x i1> %pg, i8* %base)
  %res = sext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDNF1SH (contiguous)
;

define <n x 4 x i32> @ldnf1sh_s(<n x 4 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1sh_s:
; CHECK: ldnf1sh {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldnf1.nxv4i16(<n x 4 x i1> %pg, i16* %a)
  %res = sext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @ldnf1sh_s_vnum(<n x 4 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1sh_s_vnum:
; CHECK: ldnf1sh {z0.s}, p0/z, [x0, #-6, mul vl]
; CHECK-NEXT: ret
  %t1 = bitcast i16* %a to <n x 4 x i16>*
  %t2 = getelementptr <n x 4 x i16>, <n x 4 x i16>* %t1, i64 -6
  %base = bitcast <n x 4 x i16>* %t2 to i16*

  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldnf1.nxv4i16(<n x 4 x i1> %pg, i16* %base)
  %res = sext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @ldnf1sh_d(<n x 2 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1sh_d:
; CHECK: ldnf1sh {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldnf1.nxv2i16(<n x 2 x i1> %pg, i16* %a)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

; NOTE: Also validates an out-of-range offset.
define <n x 2 x i64> @ldnf1sh_d_vnum(<n x 2 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1sh_d_vnum:
; CHECK: ldnf1sh {z0.d}, p0/z, [x{{[0-9]+}}]
; CHECK-NEXT: ret
  %t1 = bitcast i16* %a to <n x 2 x i16>*
  %t2 = getelementptr <n x 2 x i16>, <n x 2 x i16>* %t1, i64 8
  %base = bitcast <n x 2 x i16>* %t2 to i16*

  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldnf1.nxv2i16(<n x 2 x i1> %pg, i16* %base)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDNF1SW (contiguous)
;

define <n x 2 x i64> @ldnf1sw_d(<n x 2 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1sw_d:
; CHECK: ldnf1sw {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldnf1.nxv2i32(<n x 2 x i1> %pg, i32* %a)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

; NOTE: Also validates an out-of-range offset.
define <n x 2 x i64> @ldnf1sw_d_vnum(<n x 2 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1sw_d_vnum:
; CHECK: ldnf1sw {z0.d}, p0/z, [x{{[0-9]+}}]
; CHECK-NEXT: ret
  %t1 = bitcast i32* %a to <n x 2 x i32>*
  %t2 = getelementptr <n x 2 x i32>, <n x 2 x i32>* %t1, i64 -9
  %base = bitcast <n x 2 x i32>* %t2 to i32*

  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldnf1.nxv2i32(<n x 2 x i1> %pg, i32* %base)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

declare <n x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<n x 16 x i1>, i8*)

declare <n x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<n x 8 x i1>, i8*)
declare <n x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<n x 8 x i1>, i16*)
declare <n x 8 x half> @llvm.aarch64.sve.ldnf1.nxv8f16(<n x 8 x i1>, half*)

declare <n x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<n x 4 x i1>, i8*)
declare <n x 4 x i16> @llvm.aarch64.sve.ldnf1.nxv4i16(<n x 4 x i1>, i16*)
declare <n x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<n x 4 x i1>, i32*)
declare <n x 4 x float> @llvm.aarch64.sve.ldnf1.nxv4f32(<n x 4 x i1>, float*)

declare <n x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<n x 2 x i1>, i8*)
declare <n x 2 x i16> @llvm.aarch64.sve.ldnf1.nxv2i16(<n x 2 x i1>, i16*)
declare <n x 2 x i32> @llvm.aarch64.sve.ldnf1.nxv2i32(<n x 2 x i1>, i32*)
declare <n x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<n x 2 x i1>, i64*)
declare <n x 2 x double> @llvm.aarch64.sve.ldnf1.nxv2f64(<n x 2 x i1>, double*)
