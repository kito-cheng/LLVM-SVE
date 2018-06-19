; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

declare {<n x 16 x i8>,    <n x 16 x i8>}    @llvm.aarch64.sve.ld2.nxv16i8(<n x 16 x i1>, <n x 16 x i8>*)
declare {<n x 8 x i16>,    <n x 8 x i16>}    @llvm.aarch64.sve.ld2.nxv8i16(<n x 8 x i1>,  <n x 8 x i16>*)
declare {<n x 4 x i32>,    <n x 4 x i32>}    @llvm.aarch64.sve.ld2.nxv4i32(<n x 4 x i1>,  <n x 4 x i32>*)
declare {<n x 2 x i64>,    <n x 2 x i64>}    @llvm.aarch64.sve.ld2.nxv2i64(<n x 2 x i1>,  <n x 2 x i64>*)
declare {<n x 4 x float>,  <n x 4 x float>}  @llvm.aarch64.sve.ld2.nxv4f32(<n x 4 x i1>,  <n x 4 x float>*)
declare {<n x 2 x double>, <n x 2 x double>} @llvm.aarch64.sve.ld2.nxv2f64(<n x 2 x i1>,  <n x 2 x double>*)

; ld2b
define { <n x 16 x i8>, <n x 16 x i8> } @ld2.nxv16i8(<n x 16 x i1> %gp, i8 *%addr, i64 %a) {
; CHECK-LABEL: ld2.nxv16i8:
; CHECK: ld2b {z0.b, z1.b}, p0/z, [x0, x1]
%addr2 = getelementptr i8, i8 *  %addr, i64 %a
%addr3 = bitcast i8* %addr2 to <n x 16 x i8>*
%res = call { <n x 16 x i8>, <n x 16 x i8> } @llvm.aarch64.sve.ld2.nxv16i8(<n x 16 x i1> %gp, <n x 16 x i8>* %addr3)
ret { <n x 16 x i8>, <n x 16 x i8> } %res
}

; ld2h
define { <n x 8 x i16>, <n x 8 x i16> } @ld2.nxv8i16(<n x 8 x i1> %gp, i16 *%addr, i64 %a) {
; CHECK-LABEL: ld2.nxv8i16:
; CHECK: ld2h {z0.h, z1.h}, p0/z, [x0, x1, lsl #1]
%addr2 = getelementptr i16, i16 *  %addr, i64 %a
%addr3 = bitcast i16* %addr2 to <n x 8 x i16>*
%res = call { <n x 8 x i16>, <n x 8 x i16> } @llvm.aarch64.sve.ld2.nxv8i16(<n x 8 x i1> %gp, <n x 8 x i16>* %addr3)
ret { <n x 8 x i16>, <n x 8 x i16> } %res
}

; ld2w
define { <n x 4 x i32>, <n x 4 x i32> } @ld2.nxv4i32(<n x 4 x i1> %gp, i32 *%addr, i64 %a) {
; CHECK-LABEL: ld2.nxv4i32:
; CHECK: ld2w {z0.s, z1.s}, p0/z, [x0, x1, lsl #2]
%addr2 = getelementptr i32, i32 *  %addr, i64 %a
%addr3 = bitcast i32* %addr2 to <n x 4 x i32>*
%res = call { <n x 4 x i32>, <n x 4 x i32> } @llvm.aarch64.sve.ld2.nxv4i32(<n x 4 x i1> %gp, <n x 4 x i32>* %addr3)
ret { <n x 4 x i32>, <n x 4 x i32> } %res
}

define { <n x 4 x float>, <n x 4 x float> } @ld2.nxv4f32(<n x 4 x i1> %gp, float *%addr, i64 %a) {
; CHECK-LABEL: ld2.nxv4f32:
; CHECK: ld2w {z0.s, z1.s}, p0/z, [x0, x1, lsl #2]
%addr2 = getelementptr float, float *  %addr, i64 %a
%addr3 = bitcast float* %addr2 to <n x 4 x float>*
%res = call { <n x 4 x float>, <n x 4 x float> } @llvm.aarch64.sve.ld2.nxv4f32(<n x 4 x i1> %gp, <n x 4 x float>* %addr3)
ret { <n x 4 x float>, <n x 4 x float> } %res
}

; ld2d
define { <n x 2 x i64>, <n x 2 x i64> } @ld2.nxv2i64(<n x 2 x i1> %gp, i64 *%addr, i64 %a) {
; CHECK-LABEL: ld2.nxv2i64:
; CHECK: ld2d {z0.d, z1.d}, p0/z, [x0, x1, lsl #3]
%addr2 = getelementptr i64, i64 *  %addr, i64 %a
%addr3 = bitcast i64* %addr2 to <n x 2 x i64>*
%res = call { <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld2.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
ret { <n x 2 x i64>, <n x 2 x i64> } %res
}

define { <n x 2 x double>, <n x 2 x double> } @ld2.nxv2f64(<n x 2 x i1> %gp, double *%addr, i64 %a) {
; CHECK-LABEL: ld2.nxv2f64:
; CHECK: ld2d {z0.d, z1.d}, p0/z, [x0, x1, lsl #3]
%addr2 = getelementptr double, double *  %addr, i64 %a
%addr3 = bitcast double* %addr2 to <n x 2 x double>*
%res = call { <n x 2 x double>, <n x 2 x double> } @llvm.aarch64.sve.ld2.nxv2f64(<n x 2 x i1> %gp, <n x 2 x double>* %addr3)
ret { <n x 2 x double>, <n x 2 x double> } %res
}

; ld2d with shift
define  <n x 2 x i64> @ld2.nxv2i64yy(<n x 2 x i1> %gp, i64 *%addr, i64 *%bddr, i64 %a) {
; CHECK-LABEL: ld2.nxv2i64yy:
; CHECK: lsl [[offset:x[0-9]+]], x2, #1
; CHECK: ld2d {z0.d, z1.d}, p0/z, [x0, [[offset]], lsl #3]
; CHECK: ld2d {z2.d, z3.d}, p0/z, [x1, [[offset]], lsl #3]
%a2 = shl i64 %a,  1
%addr2 = getelementptr i64, i64 *  %addr, i64 %a2
%addr3 = bitcast i64* %addr2 to <n x 2 x i64>*
%resA = call { <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld2.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
%bddr2 = getelementptr i64, i64 *  %bddr, i64 %a2
%bddr3 = bitcast i64* %bddr2 to <n x 2 x i64>*
%resB = call { <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld2.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %bddr3)
%resA0 = extractvalue { <n x 2 x i64>, <n x 2 x i64> } %resA, 0
%resB1 = extractvalue { <n x 2 x i64>, <n x 2 x i64> } %resB, 1
%res = add   <n x 2 x i64> %resA0, %resB1
ret  <n x 2 x i64> %res
}

declare {<n x 16 x i8>,    <n x 16 x i8>,    <n x 16 x i8>}    @llvm.aarch64.sve.ld3.nxv16i8(<n x 16 x i1>, <n x 16 x i8>*)
declare {<n x 8 x i16>,    <n x 8 x i16>,    <n x 8 x i16>}    @llvm.aarch64.sve.ld3.nxv8i16(<n x 8 x i1>,  <n x 8 x i16>*)
declare {<n x 4 x i32>,    <n x 4 x i32>,    <n x 4 x i32>}    @llvm.aarch64.sve.ld3.nxv4i32(<n x 4 x i1>,  <n x 4 x i32>*)
declare {<n x 2 x i64>,    <n x 2 x i64>,    <n x 2 x i64>}    @llvm.aarch64.sve.ld3.nxv2i64(<n x 2 x i1>,  <n x 2 x i64>*)
declare {<n x 4 x float>,  <n x 4 x float>,  <n x 4 x float>}  @llvm.aarch64.sve.ld3.nxv4f32(<n x 4 x i1>,  <n x 4 x float>*)
declare {<n x 2 x double>, <n x 2 x double>, <n x 2 x double>} @llvm.aarch64.sve.ld3.nxv2f64(<n x 2 x i1>,  <n x 2 x double>*)

; ld3b
define { <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8> } @ld3.nxv16i8(<n x 16 x i1> %gp, i8 *%addr, i64 %a) {
; CHECK-LABEL: ld3.nxv16i8:
; CHECK: ld3b {z0.b, z1.b, z2.b}, p0/z, [x0, x1]
%addr2 = getelementptr i8, i8 *  %addr, i64 %a
%addr3 = bitcast i8* %addr2 to <n x 16 x i8>*
%res = call { <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8> } @llvm.aarch64.sve.ld3.nxv16i8(<n x 16 x i1> %gp, <n x 16 x i8>* %addr3)
ret { <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8> } %res
}

; ld3h
define { <n x 8 x i16>, <n x 8 x i16> , <n x 8 x i16> } @ld3.nxv8i16(<n x 8 x i1> %gp, i16 *%addr, i64 %a) {
; CHECK-LABEL: ld3.nxv8i16:
; CHECK: ld3h {z0.h, z1.h, z2.h}, p0/z, [x0, x1, lsl #1]
%addr2 = getelementptr i16, i16 *  %addr, i64 %a
%addr3 = bitcast i16* %addr2 to <n x 8 x i16>*
%res = call { <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>  } @llvm.aarch64.sve.ld3.nxv8i16(<n x 8 x i1> %gp, <n x 8 x i16>* %addr3)
ret { <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>  } %res
}

; ld3w
define { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> } @ld3.nxv4i32(<n x 4 x i1> %gp, i32 *%addr, i64 %a) {
; CHECK-LABEL: ld3.nxv4i32:
; CHECK: ld3w {z0.s, z1.s, z2.s}, p0/z, [x0, x1, lsl #2]
%addr2 = getelementptr i32, i32 *  %addr, i64 %a
%addr3 = bitcast i32* %addr2 to <n x 4 x i32>*
%res = call { <n x 4 x i32>, <n x 4 x i32> , <n x 4 x i32> } @llvm.aarch64.sve.ld3.nxv4i32(<n x 4 x i1> %gp, <n x 4 x i32>* %addr3)
ret { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> } %res
}

define { <n x 4 x float>, <n x 4 x float>, <n x 4 x float> } @ld3.nxv4f32(<n x 4 x i1> %gp, float *%addr, i64 %a) {
; CHECK-LABEL: ld3.nxv4f32:
; CHECK: ld3w {z0.s, z1.s, z2.s}, p0/z, [x0, x1, lsl #2]
%addr2 = getelementptr float, float *  %addr, i64 %a
%addr3 = bitcast float* %addr2 to <n x 4 x float>*
%res = call { <n x 4 x float>, <n x 4 x float> , <n x 4 x float> } @llvm.aarch64.sve.ld3.nxv4f32(<n x 4 x i1> %gp, <n x 4 x float>* %addr3)
ret { <n x 4 x float>, <n x 4 x float>, <n x 4 x float> } %res
}

; ld3d
define { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @ld3.nxv2i64(<n x 2 x i1> %gp, i64 *%addr, i64 %a) {
; CHECK-LABEL: ld3.nxv2i64:
; CHECK: ld3d {z0.d, z1.d, z2.d}, p0/z, [x0, x1, lsl #3]
%addr2 = getelementptr i64, i64 *  %addr, i64 %a
%addr3 = bitcast i64* %addr2 to <n x 2 x i64>*
%res = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld3.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
ret { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %res
}

define { <n x 2 x double>, <n x 2 x double>, <n x 2 x double> } @ld3.nxv2f64(<n x 2 x i1> %gp, double *%addr, i64 %a) {
; CHECK-LABEL: ld3.nxv2f64:
; CHECK: ld3d {z0.d, z1.d, z2.d}, p0/z, [x0, x1, lsl #3]
%addr2 = getelementptr double, double *  %addr, i64 %a
%addr3 = bitcast double* %addr2 to <n x 2 x double>*
%res = call { <n x 2 x double>, <n x 2 x double>, <n x 2 x double> } @llvm.aarch64.sve.ld3.nxv2f64(<n x 2 x i1> %gp, <n x 2 x double>* %addr3)
ret { <n x 2 x double>, <n x 2 x double>, <n x 2 x double> } %res
}

; ld3d with shift
define  <n x 2 x i64> @ld3.nxv2i64yy(<n x 2 x i1> %gp, i64 *%addr, i64 *%bddr, i64 %a) {
; CHECK-LABEL: ld3.nxv2i64yy:
; CHECK: lsl [[offset:x[0-9]+]], x2, #1
; CHECK: ld3d {z0.d, z1.d, z2.d}, p0/z, [x0, [[offset]], lsl #3]
; CHECK: ld3d {z3.d, z4.d, z5.d}, p0/z, [x1, [[offset]], lsl #3]
%a2 = shl i64 %a,  1
%addr2 = getelementptr i64, i64 *  %addr, i64 %a2
%addr3 = bitcast i64* %addr2 to <n x 2 x i64>*
%resA = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld3.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
%bddr2 = getelementptr i64, i64 *  %bddr, i64 %a2
%bddr3 = bitcast i64* %bddr2 to <n x 2 x i64>*
%resB = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld3.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %bddr3)
%resA0 = extractvalue { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %resA, 0
%resB1 = extractvalue { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %resB, 1
%res = add   <n x 2 x i64> %resA0, %resB1
ret  <n x 2 x i64> %res
}

declare {<n x 16 x i8>,    <n x 16 x i8>,    <n x 16 x i8>,    <n x 16 x i8>}    @llvm.aarch64.sve.ld4.nxv16i8(<n x 16 x i1>, <n x 16 x i8>*)
declare {<n x 8 x i16>,    <n x 8 x i16>,    <n x 8 x i16>,    <n x 8 x i16>}    @llvm.aarch64.sve.ld4.nxv8i16(<n x 8 x i1>,  <n x 8 x i16>*)
declare {<n x 4 x i32>,    <n x 4 x i32>,    <n x 4 x i32>,    <n x 4 x i32>}    @llvm.aarch64.sve.ld4.nxv4i32(<n x 4 x i1>,  <n x 4 x i32>*)
declare {<n x 2 x i64>,    <n x 2 x i64>,    <n x 2 x i64>,    <n x 2 x i64>}    @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1>,  <n x 2 x i64>*)
declare {<n x 4 x float>,  <n x 4 x float>,  <n x 4 x float>,  <n x 4 x float>}  @llvm.aarch64.sve.ld4.nxv4f32(<n x 4 x i1>,  <n x 4 x float>*)
declare {<n x 2 x double>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>} @llvm.aarch64.sve.ld4.nxv2f64(<n x 2 x i1>,  <n x 2 x double>*)

; ld4b
define { <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8> } @ld4.nxv16i8(<n x 16 x i1> %gp, i8 *%addr, i64 %a) {
; CHECK-LABEL: ld4.nxv16i8:
; CHECK: ld4b {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0, x1]
%addr2 = getelementptr i8, i8 *  %addr, i64 %a
%addr3 = bitcast i8* %addr2 to <n x 16 x i8>*
%res = call { <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8> } @llvm.aarch64.sve.ld4.nxv16i8(<n x 16 x i1> %gp, <n x 16 x i8>* %addr3)
ret { <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8> } %res
}

; ld4h
define { <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16> } @ld4.nxv8i16(<n x 8 x i1> %gp, i16 *%addr, i64 %a) {
; CHECK-LABEL: ld4.nxv8i16:
; CHECK: ld4h {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0, x1, lsl #1]
%addr2 = getelementptr i16, i16 *  %addr, i64 %a
%addr3 = bitcast i16* %addr2 to <n x 8 x i16>*
%res = call { <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16> } @llvm.aarch64.sve.ld4.nxv8i16(<n x 8 x i1> %gp, <n x 8 x i16>* %addr3)
ret { <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16> } %res
}

; ld4h
define { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> , <n x 4 x i32> } @ld4.nxv4i32(<n x 4 x i1> %gp, i32 *%addr, i64 %a) {
; CHECK-LABEL: ld4.nxv4i32:
; CHECK: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0, x1, lsl #2]
%addr2 = getelementptr i32, i32 *  %addr, i64 %a
%addr3 = bitcast i32* %addr2 to <n x 4 x i32>*
%res = call { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> } @llvm.aarch64.sve.ld4.nxv4i32(<n x 4 x i1> %gp, <n x 4 x i32>* %addr3)
ret { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> } %res
}

define { <n x 4 x float>, <n x 4 x float>, <n x 4 x float> , <n x 4 x float> } @ld4.nxv4f32(<n x 4 x i1> %gp, float *%addr, i64 %a) {
; CHECK-LABEL: ld4.nxv4f32:
; CHECK: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0, x1, lsl #2]
%addr2 = getelementptr float, float *  %addr, i64 %a
%addr3 = bitcast float* %addr2 to <n x 4 x float>*
%res = call { <n x 4 x float>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float> } @llvm.aarch64.sve.ld4.nxv4f32(<n x 4 x i1> %gp, <n x 4 x float>* %addr3)
ret { <n x 4 x float>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float> } %res
}

; ld4d
define { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @ld4.nxv2i64(<n x 2 x i1> %gp, i64 *%addr, i64 %a) {
; CHECK-LABEL: ld4.nxv2i64:
; CHECK: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0, x1, lsl #3]
%addr2 = getelementptr i64, i64 *  %addr, i64 %a
%addr3 = bitcast i64* %addr2 to <n x 2 x i64>*
%res = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
ret { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %res
}

define { <n x 2 x double>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double> } @ld4.nxv2f64(<n x 2 x i1> %gp, double *%addr, i64 %a) {
; CHECK-LABEL: ld4.nxv2f64:
; CHECK: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0, x1, lsl #3]
%addr2 = getelementptr double, double *  %addr, i64 %a
%addr3 = bitcast double* %addr2 to <n x 2 x double>*
%res = call { <n x 2 x double>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double> } @llvm.aarch64.sve.ld4.nxv2f64(<n x 2 x i1> %gp, <n x 2 x double>* %addr3)
ret { <n x 2 x double>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double> } %res
}

; ld4d with shift
define  <n x 2 x i64> @ld4.nxv2i64yy(<n x 2 x i1> %gp, i64 *%addr, i64 *%bddr, i64 %a) {
; CHECK-LABEL: ld4.nxv2i64yy:
; CHECK: lsl [[offset:x[0-9]+]], x2, #1
; CHECK: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0, [[offset]], lsl #3]
; CHECK: ld4d {z4.d, z5.d, z6.d, z7.d}, p0/z, [x1, [[offset]], lsl #3]
%a2 = shl i64 %a,  1
%addr2 = getelementptr i64, i64 *  %addr, i64 %a2
%addr3 = bitcast i64* %addr2 to <n x 2 x i64>*
%resA = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
%bddr2 = getelementptr i64, i64 *  %bddr, i64 %a2
%bddr3 = bitcast i64* %bddr2 to <n x 2 x i64>*
%resB = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %bddr3)
%resA0 = extractvalue { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %resA, 0
%resB1 = extractvalue { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %resB, 1
%res = add   <n x 2 x i64> %resA0, %resB1
ret  <n x 2 x i64> %res
}

; ld4d with shift
define  <n x 2 x i64> @ld4.nxv2i64exp(<n x 2 x i1> %gp, i128 *%addr, i128 *%bddr, i64 %a) {
; CHECK-LABEL: ld4.nxv2i64exp:
; CHECK: lsl [[offset:x[0-9]+]], x2, #2
; CHECK: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0, [[offset]], lsl #3]
; CHECK: ld4d {z4.d, z5.d, z6.d, z7.d}, p0/z, [x1, [[offset]], lsl #3]
%a2 = shl i64 %a,  1
%addr2 = getelementptr i128, i128 *  %addr, i64 %a2
%addr3 = bitcast i128* %addr2 to <n x 2 x i64>*
%resA = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
%bddr2 = getelementptr i128, i128 *  %bddr, i64 %a2
%bddr3 = bitcast i128* %bddr2 to <n x 2 x i64>*
%resB = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %bddr3)
%resA0 = extractvalue { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %resA, 0
%resB1 = extractvalue { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %resB, 1
%res = add   <n x 2 x i64> %resA0, %resB1
ret  <n x 2 x i64> %res
}

; ld4d with shift
define  <n x 2 x i64> @ld4.nxv2i64exp2(<n x 2 x i1> %gp, <4 x i128> *%addr, <4 x i128> *%bddr, i64 %a) {
; CHECK-LABEL: ld4.nxv2i64exp2:
; CHECK: lsl [[offset:x[0-9]+]], x{{[0-9]+}}, #4
; CHECK: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0, [[offset]], lsl #3]
; CHECK: ld4d {z4.d, z5.d, z6.d, z7.d}, p0/z, [x1, [[offset]], lsl #3]
%a2 = shl i64 %a,  1
%addr2 = getelementptr <4 x i128>, <4 x i128> *  %addr, i64 %a2
%addr3 = bitcast <4 x i128>* %addr2 to <n x 2 x i64>*
%resA = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
%bddr2 = getelementptr <4 x i128>, <4 x i128> *  %bddr, i64 %a2
%bddr3 = bitcast <4 x i128>* %bddr2 to <n x 2 x i64>*
%resB = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %bddr3)
%resA0 = extractvalue { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %resA, 0
%resB1 = extractvalue { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %resB, 1
%res = add   <n x 2 x i64> %resA0, %resB1
ret  <n x 2 x i64> %res
}


; ld4d with shift
define  <n x 2 x i64> @ld4.nxv2i64exp3( <n x 2 x i1> %gp, i128 *%addr, i128 *%bddr, i64 %a, i64 %ss) {
; CHECK-LABEL: ld4.nxv2i64exp3:
; CHECK: lsl [[offset:x[0-9]+]], x{{[0-9]+}}, #25
; CHECK: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0, [[offset]], lsl #3]
; CHECK: ld4d {z4.d, z5.d, z6.d, z7.d}, p0/z, [x1, [[offset]], lsl #3]
%aa = shl i64 %a,  %ss
%a2 = shl i64 %aa, 24
%addr2 = getelementptr i128, i128 *  %addr, i64 %a2
%addr3 = bitcast i128* %addr2 to <n x 2 x i64>*
%resA = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %addr3)
%bddr2 = getelementptr i128, i128 *  %bddr, i64 %a2
%bddr3 = bitcast i128* %bddr2 to <n x 2 x i64>*
%resB = call { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1> %gp, <n x 2 x i64>* %bddr3)
%resA0 = extractvalue { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %resA, 0
%resB1 = extractvalue { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> } %resB, 1
%res = add   <n x 2 x i64> %resA0, %resB1
ret  <n x 2 x i64> %res
}
