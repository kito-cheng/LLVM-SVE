; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

declare void @llvm.aarch64.sve.st2.nxv16i8(<n x 16 x i8>, <n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>*)
declare void @llvm.aarch64.sve.st2.nxv8i16(<n x 8 x i16>, <n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>*)
declare void @llvm.aarch64.sve.st2.nxv4i32(<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>*)
declare void @llvm.aarch64.sve.st2.nxv2i64(<n x 2 x i64>, <n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>*)
declare void @llvm.aarch64.sve.st2.nxv4f32(<n x 4 x float>, <n x 4 x float>, <n x 4 x i1>, <n x 4 x float>*)
declare void @llvm.aarch64.sve.st2.nxv2f64(<n x 2 x double>, <n x 2 x double>, <n x 2 x i1>, <n x 2 x double>*)

; st2b
define void @st2.nxv16i8(<n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i1> %gp, i8 * %addr, i64 %idx) {
; CHECK-LABEL: st2.nxv16i8:
; CHECK: st2b {z0.b, z1.b}, p0, [x0, x1]
  %addr2 = getelementptr i8, i8 * %addr, i64 %idx
  %addr3 = bitcast i8* %addr2 to <n x 16 x i8>*
  call void @llvm.aarch64.sve.st2.nxv16i8(<n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i1> %gp, <n x 16 x i8>* %addr3)
  ret void
}

; st2h
define void @st2.nxv8i16(<n x 8 x i16> %a, <n x 8 x i16> %b, <n x 8 x i1> %gp, i16 *%addr, i64 %idx) {
; CHECK-LABEL: st2.nxv8i16:
; CHECK: st2h {z0.h, z1.h}, p0, [x0, x1, lsl #1]
  %addr2 = getelementptr i16, i16 * %addr, i64 %idx
  %addr3 = bitcast i16* %addr2 to <n x 8 x i16>*
  call void @llvm.aarch64.sve.st2.nxv8i16(<n x 8 x i16> %a, <n x 8 x i16> %b, <n x 8 x i1> %gp, <n x 8 x i16>* %addr3)
  ret void
}

; st2w
define void @st2.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i1> %gp, i32 *%addr, i64 %idx) {
; CHECK-LABEL: st2.nxv4i32:
; CHECK: st2w {z0.s, z1.s}, p0, [x0, x1, lsl #2]
  %addr2 = getelementptr i32, i32 * %addr, i64 %idx
  %addr3 = bitcast i32* %addr2 to <n x 4 x i32>*
  call void @llvm.aarch64.sve.st2.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i1> %gp, <n x 4 x i32>* %addr3)
  ret void
}

; st2w
define void @st2.nxv4i32_fold(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i1> %gp, i32 *%addrB, i32 *%addrA, i64 %idx) {
; CHECK-LABEL: st2.nxv4i32_fold:
; CHECK-DAG: lsl x[[N:[0-9]+]],  x2, #1
; CHECK-DAG: st2w {z0.s, z1.s}, p0, [x0, x[[N]], lsl #2]
; CHECK-DAG: st2w {z0.s, z1.s}, p0, [x1, x[[N]], lsl #2]
  %idx2 = shl i64 %idx, 1
  %addrA2 = getelementptr i32, i32 * %addrA, i64 %idx2
  %addrA3 = bitcast i32* %addrA2 to <n x 4 x i32>*
  call void @llvm.aarch64.sve.st2.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i1> %gp, <n x 4 x i32>* %addrA3)
  %addrB2 = getelementptr i32, i32 * %addrB, i64 %idx2
  %addrB3 = bitcast i32* %addrB2 to <n x 4 x i32>*
  call void @llvm.aarch64.sve.st2.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i1> %gp, <n x 4 x i32>* %addrB3)
  ret void
}

; st2d
define void @st2.nxv2i64(<n x 2 x i64> %a, <n x 2 x i64> %b, <n x 2 x i1> %gp, i64 *%addr, i64 %idx) {
; CHECK-LABEL: st2.nxv2i64:
; CHECK: st2d {z0.d, z1.d}, p0, [x0, x1, lsl #3]
  %addr2 = getelementptr i64, i64 * %addr, i64 %idx
  %addr3 = bitcast i64* %addr2 to <n x 2 x i64>*
  call void @llvm.aarch64.sve.st2.nxv2i64(<n x 2 x i64> %a, <n x 2 x i64> %b, <n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
  ret void
}

; st2w (FP)
define void @st2.nxv4f32(<n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x i1> %gp, float *%addr, i64 %idx) {
; CHECK-LABEL: st2.nxv4f32:
; CHECK: st2w {z0.s, z1.s}, p0, [x0, x1, lsl #2]
  %addr2 = getelementptr float, float * %addr, i64 %idx
  %addr3 = bitcast float* %addr2 to <n x 4 x float>*
  call void @llvm.aarch64.sve.st2.nxv4f32(<n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x i1> %gp, <n x 4 x float>* %addr3)
  ret void
}

; st2d (FP)
define void @st2.nxv2f64(<n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x i1> %gp, double *%addr, i64 %idx) {
; CHECK-LABEL: st2.nxv2f64:
; CHECK: st2d {z0.d, z1.d}, p0, [x0, x1, lsl #3]
  %addr2 = getelementptr double, double * %addr, i64 %idx
  %addr3 = bitcast double* %addr2 to <n x 2 x double>*
  call void @llvm.aarch64.sve.st2.nxv2f64(<n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x i1> %gp, <n x 2 x double>* %addr3)
  ret void
}

declare void @llvm.aarch64.sve.st3.nxv16i8(<n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>*)
declare void @llvm.aarch64.sve.st3.nxv8i16(<n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>*)
declare void @llvm.aarch64.sve.st3.nxv4i32(<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>*)
declare void @llvm.aarch64.sve.st3.nxv2i64(<n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>*)
declare void @llvm.aarch64.sve.st3.nxv4f32(<n x 4 x float>, <n x 4 x float>, <n x 4 x float>, <n x 4 x i1>, <n x 4 x float>*)
declare void @llvm.aarch64.sve.st3.nxv2f64(<n x 2 x double>, <n x 2 x double>, <n x 2 x double>, <n x 2 x i1>, <n x 2 x double>*)

; st3b
define void @st3.nxv16i8(<n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> %c, <n x 16 x i1> %gp, i8 *%addr, i64 %idx) {
; CHECK-LABEL: st3.nxv16i8:
; CHECK: st3b {z0.b, z1.b, z2.b}, p0, [x0, x1]
  %addr2 = getelementptr i8, i8 * %addr, i64 %idx
  %addr3 = bitcast i8* %addr2 to <n x 16 x i8>*
  call void @llvm.aarch64.sve.st3.nxv16i8(<n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> %c, <n x 16 x i1> %gp, <n x 16 x i8>* %addr3)
  ret void
}

; st3h
define void @st3.nxv8i16(<n x 8 x i16> %a, <n x 8 x i16> %b, <n x 8 x i16> %c, <n x 8 x i1> %gp, i16 *%addr, i64 %idx) {
; CHECK-LABEL: st3.nxv8i16:
; CHECK: st3h {z0.h, z1.h, z2.h}, p0, [x0, x1, lsl #1]
  %addr2 = getelementptr i16, i16 * %addr, i64 %idx
  %addr3 = bitcast i16* %addr2 to <n x 8 x i16>*
  call void @llvm.aarch64.sve.st3.nxv8i16(<n x 8 x i16> %a, <n x 8 x i16> %b, <n x 8 x i16> %c, <n x 8 x i1> %gp, <n x 8 x i16>* %addr3)
  ret void
}

; st3w
define void @st3.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c, <n x 4 x i1> %gp, i32 *%addr, i64 %idx) {
; CHECK-LABEL: st3.nxv4i32:
; CHECK: st3w {z0.s, z1.s, z2.s}, p0, [x0, x1, lsl #2]
  %addr2 = getelementptr i32, i32 * %addr, i64 %idx
  %addr3 = bitcast i32* %addr2 to <n x 4 x i32>*
  call void @llvm.aarch64.sve.st3.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c, <n x 4 x i1> %gp, <n x 4 x i32>* %addr3)
  ret void
}

; st3w
define void @st3.nxv4i32_fold(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c, <n x 4 x i1> %gp, i32 *%addrB, i32 *%addrA, i64 %idx) {
; CHECK-LABEL: st3.nxv4i32_fold:
; CHECK-DAG: lsl x[[N:[0-9]+]],  x2, #1
; CHECK-DAG: st3w {z0.s, z1.s, z2.s}, p0, [x0, x[[N]], lsl #2]
; CHECK-DAG: st3w {z0.s, z1.s, z2.s}, p0, [x1, x[[N]], lsl #2]
  %idx2 = shl i64 %idx, 1
  %addrA2 = getelementptr i32, i32 * %addrA, i64 %idx2
  %addrA3 = bitcast i32* %addrA2 to <n x 4 x i32>*
  call void @llvm.aarch64.sve.st3.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c, <n x 4 x i1> %gp, <n x 4 x i32>* %addrA3)
  %addrB2 = getelementptr i32, i32 * %addrB, i64 %idx2
  %addrB3 = bitcast i32* %addrB2 to <n x 4 x i32>*
  call void @llvm.aarch64.sve.st3.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c, <n x 4 x i1> %gp, <n x 4 x i32>* %addrB3)
  ret void
}

; st3d
define void @st3.nxv2i64(<n x 2 x i64> %a, <n x 2 x i64> %b, <n x 2 x i64> %c, <n x 2 x i1> %gp, i64 *%addr, i64 %idx) {
; CHECK-LABEL: st3.nxv2i64:
; CHECK: st3d {z0.d, z1.d, z2.d}, p0, [x0, x1, lsl #3]
  %addr2 = getelementptr i64, i64 * %addr, i64 %idx
  %addr3 = bitcast i64* %addr2 to <n x 2 x i64>*
  call void @llvm.aarch64.sve.st3.nxv2i64(<n x 2 x i64> %a, <n x 2 x i64> %b, <n x 2 x i64> %c, <n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
  ret void
}

; st3w (FP)
define void @st3.nxv4f32(<n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c, <n x 4 x i1> %gp, float *%addr, i64 %idx) {
; CHECK-LABEL: st3.nxv4f32:
; CHECK: st3w {z0.s, z1.s, z2.s}, p0, [x0, x1, lsl #2]
  %addr2 = getelementptr float, float * %addr, i64 %idx
  %addr3 = bitcast float* %addr2 to <n x 4 x float>*
  call void @llvm.aarch64.sve.st3.nxv4f32(<n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c, <n x 4 x i1> %gp, <n x 4 x float>* %addr3)
  ret void
}

; st3d (FP)
define void @st3.nxv2f64(<n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c, <n x 2 x i1> %gp, double *%addr, i64 %idx) {
; CHECK-LABEL: st3.nxv2f64:
; CHECK: st3d {z0.d, z1.d, z2.d}, p0, [x0, x1, lsl #3]
  %addr2 = getelementptr double, double * %addr, i64 %idx
  %addr3 = bitcast double* %addr2 to <n x 2 x double>*
  call void @llvm.aarch64.sve.st3.nxv2f64(<n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c, <n x 2 x i1> %gp, <n x 2 x double>* %addr3)
  ret void
}

declare void @llvm.aarch64.sve.st4.nxv16i8(<n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>*)
declare void @llvm.aarch64.sve.st4.nxv8i16(<n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>*)
declare void @llvm.aarch64.sve.st4.nxv4i32(<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>*)
declare void @llvm.aarch64.sve.st4.nxv2i64(<n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>*)
declare void @llvm.aarch64.sve.st4.nxv4f32(<n x 4 x float>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>, <n x 4 x i1>, <n x 4 x float>*)
declare void @llvm.aarch64.sve.st4.nxv2f64(<n x 2 x double>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>, <n x 2 x i1>, <n x 2 x double>*)

; st4b
define void @st4.nxv16i8(<n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> %c, <n x 16 x i8> %d, <n x 16 x i1> %gp, i8 *%addr, i64 %idx) {
; CHECK-LABEL: st4.nxv16i8:
; CHECK: st4b {z0.b, z1.b, z2.b, z3.b}, p0, [x0, x1]
  %addr2 = getelementptr i8, i8 * %addr, i64 %idx
  %addr3 = bitcast i8* %addr2 to <n x 16 x i8>*
  call void @llvm.aarch64.sve.st4.nxv16i8(<n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> %c, <n x 16 x i8> %d, <n x 16 x i1> %gp, <n x 16 x i8>* %addr3)
  ret void
}

; st4h
define void @st4.nxv8i16(<n x 8 x i16> %a, <n x 8 x i16> %b, <n x 8 x i16> %c, <n x 8 x i16> %d, <n x 8 x i1> %gp, i16 *%addr, i64 %idx) {
; CHECK-LABEL: st4.nxv8i16:
; CHECK: st4h {z0.h, z1.h, z2.h, z3.h}, p0, [x0, x1, lsl #1]
  %addr2 = getelementptr i16, i16 * %addr, i64 %idx
  %addr3 = bitcast i16* %addr2 to <n x 8 x i16>*
  call void @llvm.aarch64.sve.st4.nxv8i16(<n x 8 x i16> %a, <n x 8 x i16> %b, <n x 8 x i16> %c, <n x 8 x i16> %d, <n x 8 x i1> %gp, <n x 8 x i16>* %addr3)
  ret void
}

; st4w
define void @st4.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c, <n x 4 x i32> %d, <n x 4 x i1> %gp, i32 *%addr, i64 %idx) {
; CHECK-LABEL: st4.nxv4i32:
; CHECK: st4w {z0.s, z1.s, z2.s, z3.s}, p0, [x0, x1, lsl #2]
  %addr2 = getelementptr i32, i32 * %addr, i64 %idx
  %addr3 = bitcast i32* %addr2 to <n x 4 x i32>*
  call void @llvm.aarch64.sve.st4.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c, <n x 4 x i32> %d, <n x 4 x i1> %gp, <n x 4 x i32>* %addr3)
  ret void
}

; st4w
define void @st4.nxv4i32_fold(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c, <n x 4 x i32> %d, <n x 4 x i1> %gp, i32 *%addrB, i32 *%addrA, i64 %idx) {
; CHECK-LABEL: st4.nxv4i32_fold:
; CHECK-DAG: lsl x[[N:[0-9]+]],  x2, #1
; CHECK-DAG: st4w {z0.s, z1.s, z2.s, z3.s}, p0, [x0, x[[N]], lsl #2]
; CHECK-DAG: st4w {z0.s, z1.s, z2.s, z3.s}, p0, [x1, x[[N]], lsl #2]
  %idx2 = shl i64 %idx, 1
  %addrA2 = getelementptr i32, i32 * %addrA, i64 %idx2
  %addrA3 = bitcast i32* %addrA2 to <n x 4 x i32>*
  call void @llvm.aarch64.sve.st4.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c, <n x 4 x i32> %d, <n x 4 x i1> %gp, <n x 4 x i32>* %addrA3)
  %addrB2 = getelementptr i32, i32 * %addrB, i64 %idx2
  %addrB3 = bitcast i32* %addrB2 to <n x 4 x i32>*
  call void @llvm.aarch64.sve.st4.nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c, <n x 4 x i32> %d, <n x 4 x i1> %gp, <n x 4 x i32>* %addrB3)
  ret void
}

; st4d
define void @st4.nxv2i64(<n x 2 x i64> %a, <n x 2 x i64> %b, <n x 2 x i64> %c, <n x 2 x i64> %d, <n x 2 x i1> %gp, i64 *%addr, i64 %idx) {
; CHECK-LABEL: st4.nxv2i64:
; CHECK: st4d {z0.d, z1.d, z2.d, z3.d}, p0, [x0, x1, lsl #3]
  %addr2 = getelementptr i64, i64 * %addr, i64 %idx
  %addr3 = bitcast i64* %addr2 to <n x 2 x i64>*
  call void @llvm.aarch64.sve.st4.nxv2i64(<n x 2 x i64> %a, <n x 2 x i64> %b, <n x 2 x i64> %c, <n x 2 x i64> %d, <n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
  ret void
}

; st4w (FP)
define void @st4.nxv4f32(<n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c, <n x 4 x float> %d, <n x 4 x i1> %gp, float *%addr, i64 %idx) {
; CHECK-LABEL: st4.nxv4f32:
; CHECK: st4w {z0.s, z1.s, z2.s, z3.s}, p0, [x0, x1, lsl #2]
  %addr2 = getelementptr float, float * %addr, i64 %idx
  %addr3 = bitcast float* %addr2 to <n x 4 x float>*
  call void @llvm.aarch64.sve.st4.nxv4f32(<n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c, <n x 4 x float> %d, <n x 4 x i1> %gp, <n x 4 x float>* %addr3)
  ret void
}

; st4d (FP)
define void @st4.nxv2f64(<n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c, <n x 2 x double> %d, <n x 2 x i1> %gp, double *%addr, i64 %idx) {
; CHECK-LABEL: st4.nxv2f64:
; CHECK: st4d {z0.d, z1.d, z2.d, z3.d}, p0, [x0, x1, lsl #3]
  %addr2 = getelementptr double, double * %addr, i64 %idx
  %addr3 = bitcast double* %addr2 to <n x 2 x double>*
  call void @llvm.aarch64.sve.st4.nxv2f64(<n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c, <n x 2 x double> %d, <n x 2 x i1> %gp, <n x 2 x double>* %addr3)
  ret void
}
