; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

%svint8x2_t = type { <n x 16 x i8>, <n x 16 x i8> }
%svint8x3_t = type { <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8> }
%svint8x4_t = type { <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8> }

%svint16x2_t = type { <n x 8 x i16>, <n x 8 x i16> }
%svint16x3_t = type { <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16> }
%svint16x4_t = type { <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16> }

%svint32x2_t = type { <n x 4 x i32>, <n x 4 x i32> }
%svint32x3_t = type { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> }
%svint32x4_t = type { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> }

%svint64x2_t = type { <n x 2 x i64>, <n x 2 x i64> }
%svint64x3_t = type { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> }
%svint64x4_t = type { <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64> }

%svfloat16x2_t = type { <n x 8 x half>, <n x 8 x half> }
%svfloat16x3_t = type { <n x 8 x half>, <n x 8 x half>, <n x 8 x half> }
%svfloat16x4_t = type { <n x 8 x half>, <n x 8 x half>, <n x 8 x half>, <n x 8 x half> }

%svfloat32x2_t = type { <n x 4 x float>, <n x 4 x float> }
%svfloat32x3_t = type { <n x 4 x float>, <n x 4 x float>, <n x 4 x float> }
%svfloat32x4_t = type { <n x 4 x float>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float> }

%svfloat64x2_t = type { <n x 2 x double>, <n x 2 x double> }
%svfloat64x3_t = type { <n x 2 x double>, <n x 2 x double>, <n x 2 x double> }
%svfloat64x4_t = type { <n x 2 x double>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double> }

;
; LD1RQB
;

define <n x 16 x i8> @ld1rqb_i8(<n x 16 x i1> %pred, i8* %addr) {
; CHECK-LABEL: ld1rqb_i8:
; CHECK: ld1rqb {z0.b}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 16 x i8> @llvm.aarch64.sve.ld1rq.nxv16i8(<n x 16 x i1> %pred, i8* %addr)
  ret <n x 16 x i8> %res
}

define <n x 16 x i8> @ld1rqb_i8_imm(<n x 16 x i1> %pred, i8* %addr) {
; CHECK-LABEL: ld1rqb_i8_imm:
; CHECK: ld1rqb {z0.b}, p0/z, [x0, #16]
; CHECK-NEXT: ret
  %ptr = getelementptr inbounds i8, i8* %addr, i8 16
  %res = call <n x 16 x i8> @llvm.aarch64.sve.ld1rq.nxv16i8(<n x 16 x i1> %pred, i8* %ptr)
  ret <n x 16 x i8> %res
}

;
; LD1RQH
;

define <n x 8 x i16> @ld1rqh_i16(<n x 8 x i1> %pred, i16* %addr) {
; CHECK-LABEL: ld1rqh_i16:
; CHECK: ld1rqh {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 8 x i16> @llvm.aarch64.sve.ld1rq.nxv8i16(<n x 8 x i1> %pred, i16* %addr)
  ret <n x 8 x i16> %res
}

define <n x 8 x half> @ld1rqh_f16(<n x 8 x i1> %pred, half* %addr) {
; CHECK-LABEL: ld1rqh_f16:
; CHECK: ld1rqh {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 8 x half> @llvm.aarch64.sve.ld1rq.nxv8f16(<n x 8 x i1> %pred, half* %addr)
  ret <n x 8 x half> %res
}

define <n x 8 x i16> @ld1rqh_i16_imm(<n x 8 x i1> %pred, i16* %addr) {
; CHECK-LABEL: ld1rqh_i16_imm:
; CHECK: ld1rqh {z0.h}, p0/z, [x0, #-64]
; CHECK-NEXT: ret
  %ptr = getelementptr inbounds i16, i16* %addr, i16 -32
  %res = call <n x 8 x i16> @llvm.aarch64.sve.ld1rq.nxv8i16(<n x 8 x i1> %pred, i16* %ptr)
  ret <n x 8 x i16> %res
}

define <n x 8 x half> @ld1rqh_f16_imm(<n x 8 x i1> %pred, half* %addr) {
; CHECK-LABEL: ld1rqh_f16_imm:
; CHECK: ld1rqh {z0.h}, p0/z, [x0, #-16]
; CHECK-NEXT: ret
  %ptr = getelementptr inbounds half, half* %addr, i16 -8
  %res = call <n x 8 x half> @llvm.aarch64.sve.ld1rq.nxv8f16(<n x 8 x i1> %pred, half* %ptr)
  ret <n x 8 x half> %res
}

;
; LD1RQW
;

define <n x 4 x i32> @ld1rqw_i32(<n x 4 x i1> %pred, i32* %addr) {
; CHECK-LABEL: ld1rqw_i32:
; CHECK: ld1rqw {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 4 x i32> @llvm.aarch64.sve.ld1rq.nxv4i32(<n x 4 x i1> %pred, i32* %addr)
  ret <n x 4 x i32> %res
}

define <n x 4 x float> @ld1rqw_f32(<n x 4 x i1> %pred, float* %addr) {
; CHECK-LABEL: ld1rqw_f32:
; CHECK: ld1rqw {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 4 x float> @llvm.aarch64.sve.ld1rq.nxv4f32(<n x 4 x i1> %pred, float* %addr)
  ret <n x 4 x float> %res
}

define <n x 4 x i32> @ld1rqw_i32_imm(<n x 4 x i1> %pred, i32* %addr) {
; CHECK-LABEL: ld1rqw_i32_imm:
; CHECK: ld1rqw {z0.s}, p0/z, [x0, #112]
; CHECK-NEXT: ret
  %ptr = getelementptr inbounds i32, i32* %addr, i32 28
  %res = call <n x 4 x i32> @llvm.aarch64.sve.ld1rq.nxv4i32(<n x 4 x i1> %pred, i32* %ptr)
  ret <n x 4 x i32> %res
}

define <n x 4 x float> @ld1rqw_f32_imm(<n x 4 x i1> %pred, float* %addr) {
; CHECK-LABEL: ld1rqw_f32_imm:
; CHECK: ld1rqw {z0.s}, p0/z, [x0, #32]
; CHECK-NEXT: ret
  %ptr = getelementptr inbounds float, float* %addr, i32 8
  %res = call <n x 4 x float> @llvm.aarch64.sve.ld1rq.nxv4f32(<n x 4 x i1> %pred, float* %ptr)
  ret <n x 4 x float> %res
}

;
; LD1RQD
;

define <n x 2 x i64> @ld1rqd_i64(<n x 2 x i1> %pred, i64* %addr) {
; CHECK-LABEL: ld1rqd_i64:
; CHECK: ld1rqd {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 2 x i64> @llvm.aarch64.sve.ld1rq.nxv2i64(<n x 2 x i1> %pred, i64* %addr)
  ret <n x 2 x i64> %res
}

define <n x 2 x double> @ld1rqd_f64(<n x 2 x i1> %pred, double* %addr) {
; CHECK-LABEL: ld1rqd_f64:
; CHECK: ld1rqd {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 2 x double> @llvm.aarch64.sve.ld1rq.nxv2f64(<n x 2 x i1> %pred, double* %addr)
  ret <n x 2 x double> %res
}

define <n x 2 x i64> @ld1rqd_i64_imm(<n x 2 x i1> %pred, i64* %addr) {
; CHECK-LABEL: ld1rqd_i64_imm:
; CHECK: ld1rqd {z0.d}, p0/z, [x0, #64]
; CHECK-NEXT: ret
  %ptr = getelementptr inbounds i64, i64* %addr, i64 8
  %res = call <n x 2 x i64> @llvm.aarch64.sve.ld1rq.nxv2i64(<n x 2 x i1> %pred, i64* %ptr)
  ret <n x 2 x i64> %res
}

define <n x 2 x double> @ld1rqd_f64_imm(<n x 2 x i1> %pred, double* %addr) {
; CHECK-LABEL: ld1rqd_f64_imm:
; CHECK: ld1rqd {z0.d}, p0/z, [x0, #-128]
; CHECK-NEXT: ret
  %ptr = getelementptr inbounds double, double* %addr, i64 -16
  %res = call <n x 2 x double> @llvm.aarch64.sve.ld1rq.nxv2f64(<n x 2 x i1> %pred, double* %ptr)
  ret <n x 2 x double> %res
}

;
; LD2B
;

define %svint8x2_t @ld2b_i8(<n x 16 x i1> %pred, <n x 16 x i8>* %addr) {
; CHECK-LABEL: ld2b_i8:
; CHECK: ld2b {z0.b, z1.b}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint8x2_t @llvm.aarch64.sve.ld2.nxv16i8(<n x 16 x i1> %pred, <n x 16 x i8>* %addr)
  ret %svint8x2_t %res
}

;
; LD2H
;

define %svint16x2_t @ld2h_i16(<n x 8 x i1> %pred, <n x 8 x i16>* %addr) {
; CHECK-LABEL: ld2h_i16:
; CHECK: ld2h {z0.h, z1.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint16x2_t @llvm.aarch64.sve.ld2.nxv8i16(<n x 8 x i1> %pred,
                                                         <n x 8 x i16>* %addr)
  ret %svint16x2_t %res
}

define %svfloat16x2_t @ld2h_f16(<n x 8 x i1> %pred, <n x 8 x half>* %addr) {
; CHECK-LABEL: ld2h_f16:
; CHECK: ld2h {z0.h, z1.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svfloat16x2_t @llvm.aarch64.sve.ld2.nxv8f16(<n x 8 x i1> %pred,
                                                           <n x 8 x half>* %addr)
  ret %svfloat16x2_t %res
}

;
; LD2W
;

define %svint32x2_t @ld2w_i32(<n x 4 x i1> %pred, <n x 4 x i32>* %addr) {
; CHECK-LABEL: ld2w_i32:
; CHECK: ld2w {z0.s, z1.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint32x2_t @llvm.aarch64.sve.ld2.nxv4i32(<n x 4 x i1> %pred,
                                                         <n x 4 x i32>* %addr)
  ret %svint32x2_t %res
}

define %svfloat32x2_t @ld2w_f32(<n x 4 x i1> %pred, <n x 4 x float>* %addr) {
; CHECK-LABEL: ld2w_f32:
; CHECK: ld2w {z0.s, z1.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svfloat32x2_t @llvm.aarch64.sve.ld2.nxv4f32(<n x 4 x i1> %pred,
                                                           <n x 4 x float>* %addr)
  ret %svfloat32x2_t %res
}

;
; LD2D
;

define %svint64x2_t @ld2d_i64(<n x 2 x i1> %pred, <n x 2 x i64>* %addr) {
; CHECK-LABEL: ld2d_i64:
; CHECK: ld2d {z0.d, z1.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint64x2_t @llvm.aarch64.sve.ld2.nxv2i64(<n x 2 x i1> %pred,
                                                         <n x 2 x i64>* %addr)
  ret %svint64x2_t %res
}

define %svfloat64x2_t @ld2d_f64(<n x 2 x i1> %pred, <n x 2 x double>* %addr) {
; CHECK-LABEL: ld2d_f64:
; CHECK: ld2d {z0.d, z1.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svfloat64x2_t @llvm.aarch64.sve.ld2.nxv2f64(<n x 2 x i1> %pred,
                                                           <n x 2 x double>* %addr)
  ret %svfloat64x2_t %res
}

;
; LD3B
;

define %svint8x3_t @ld3b_i8(<n x 16 x i1> %pred, <n x 16 x i8>* %addr) {
; CHECK-LABEL: ld3b_i8:
; CHECK: ld3b {z0.b, z1.b, z2.b}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint8x3_t @llvm.aarch64.sve.ld3.nxv16i8(<n x 16 x i1> %pred, <n x 16 x i8>* %addr)
  ret %svint8x3_t %res
}

;
; LD3H
;

define %svint16x3_t @ld3h_i16(<n x 8 x i1> %pred, <n x 8 x i16>* %addr) {
; CHECK-LABEL: ld3h_i16:
; CHECK: ld3h {z0.h, z1.h, z2.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint16x3_t @llvm.aarch64.sve.ld3.nxv8i16(<n x 8 x i1> %pred,
                                                         <n x 8 x i16>* %addr)
  ret %svint16x3_t %res
}

define %svfloat16x3_t @ld3h_f16(<n x 8 x i1> %pred, <n x 8 x half>* %addr) {
; CHECK-LABEL: ld3h_f16:
; CHECK: ld3h {z0.h, z1.h, z2.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svfloat16x3_t @llvm.aarch64.sve.ld3.nxv8f16(<n x 8 x i1> %pred,
                                                           <n x 8 x half>* %addr)
  ret %svfloat16x3_t %res
}

;
; LD2W
;

define %svint32x3_t @ld3w_i32(<n x 4 x i1> %pred, <n x 4 x i32>* %addr) {
; CHECK-LABEL: ld3w_i32:
; CHECK: ld3w {z0.s, z1.s, z2.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint32x3_t @llvm.aarch64.sve.ld3.nxv4i32(<n x 4 x i1> %pred,
                                                         <n x 4 x i32>* %addr)
  ret %svint32x3_t %res
}

define %svfloat32x3_t @ld3w_f32(<n x 4 x i1> %pred, <n x 4 x float>* %addr) {
; CHECK-LABEL: ld3w_f32:
; CHECK: ld3w {z0.s, z1.s, z2.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svfloat32x3_t @llvm.aarch64.sve.ld3.nxv4f32(<n x 4 x i1> %pred,
                                                           <n x 4 x float>* %addr)
  ret %svfloat32x3_t %res
}

;
; LD3D
;

define %svint64x3_t @ld3d_i64(<n x 2 x i1> %pred, <n x 2 x i64>* %addr) {
; CHECK-LABEL: ld3d_i64:
; CHECK: ld3d {z0.d, z1.d, z2.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint64x3_t @llvm.aarch64.sve.ld3.nxv2i64(<n x 2 x i1> %pred,
                                                         <n x 2 x i64>* %addr)
  ret %svint64x3_t %res
}

define %svfloat64x3_t @ld3d_f64(<n x 2 x i1> %pred, <n x 2 x double>* %addr) {
; CHECK-LABEL: ld3d_f64:
; CHECK: ld3d {z0.d, z1.d, z2.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svfloat64x3_t @llvm.aarch64.sve.ld3.nxv2f64(<n x 2 x i1> %pred,
                                                           <n x 2 x double>* %addr)
  ret %svfloat64x3_t %res
}

;
; LD4B
;

define %svint8x4_t @ld4b_i8(<n x 16 x i1> %pred, <n x 16 x i8>* %addr) {
; CHECK-LABEL: ld4b_i8:
; CHECK: ld4b {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint8x4_t @llvm.aarch64.sve.ld4.nxv16i8(<n x 16 x i1> %pred, <n x 16 x i8>* %addr)
  ret %svint8x4_t %res
}

;
; LD4H
;

define %svint16x4_t @ld4h_i16(<n x 8 x i1> %pred, <n x 8 x i16>* %addr) {
; CHECK-LABEL: ld4h_i16:
; CHECK: ld4h {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint16x4_t @llvm.aarch64.sve.ld4.nxv8i16(<n x 8 x i1> %pred,
                                                         <n x 8 x i16>* %addr)
  ret %svint16x4_t %res
}

define %svfloat16x4_t @ld4h_f16(<n x 8 x i1> %pred, <n x 8 x half>* %addr) {
; CHECK-LABEL: ld4h_f16:
; CHECK: ld4h {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svfloat16x4_t @llvm.aarch64.sve.ld4.nxv8f16(<n x 8 x i1> %pred,
                                                           <n x 8 x half>* %addr)
  ret %svfloat16x4_t %res
}

;
; LD4W
;

define %svint32x4_t @ld4w_i32(<n x 4 x i1> %pred, <n x 4 x i32>* %addr) {
; CHECK-LABEL: ld4w_i32:
; CHECK: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint32x4_t @llvm.aarch64.sve.ld4.nxv4i32(<n x 4 x i1> %pred,
                                                         <n x 4 x i32>* %addr)
  ret %svint32x4_t %res
}

define %svfloat32x4_t @ld4w_f32(<n x 4 x i1> %pred, <n x 4 x float>* %addr) {
; CHECK-LABEL: ld4w_f32:
; CHECK: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svfloat32x4_t @llvm.aarch64.sve.ld4.nxv4f32(<n x 4 x i1> %pred,
                                                           <n x 4 x float>* %addr)
  ret %svfloat32x4_t %res
}

;
; LD4D
;

define %svint64x4_t @ld4d_i64(<n x 2 x i1> %pred, <n x 2 x i64>* %addr) {
; CHECK-LABEL: ld4d_i64:
; CHECK: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svint64x4_t @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1> %pred,
                                                         <n x 2 x i64>* %addr)
  ret %svint64x4_t %res
}

define %svfloat64x4_t @ld4d_f64(<n x 2 x i1> %pred, <n x 2 x double>* %addr) {
; CHECK-LABEL: ld4d_f64:
; CHECK: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call %svfloat64x4_t @llvm.aarch64.sve.ld4.nxv2f64(<n x 2 x i1> %pred,
                                                           <n x 2 x double>* %addr)
  ret %svfloat64x4_t %res
}

;
; LDNT1B
;

define <n x 16 x i8> @ldnt1b_i8(<n x 16 x i1> %pred, <n x 16 x i8>* %addr) {
; CHECK-LABEL: ldnt1b_i8:
; CHECK: ldnt1b {z0.b}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 16 x i8> @llvm.aarch64.sve.ldnt1.nxv16i8(<n x 16 x i1> %pred,
                                                            <n x 16 x i8>* %addr)
  ret <n x 16 x i8> %res
}

;
; LDNT1H
;

define <n x 8 x i16> @ldnt1h_i16(<n x 8 x i1> %pred, <n x 8 x i16>* %addr) {
; CHECK-LABEL: ldnt1h_i16:
; CHECK: ldnt1h {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 8 x i16> @llvm.aarch64.sve.ldnt1.nxv8i16(<n x 8 x i1> %pred,
                                                            <n x 8 x i16>* %addr)
  ret <n x 8 x i16> %res
}

define <n x 8 x half> @ldnt1h_f16(<n x 8 x i1> %pred, <n x 8 x half>* %addr) {
; CHECK-LABEL: ldnt1h_f16:
; CHECK: ldnt1h {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 8 x half> @llvm.aarch64.sve.ldnt1.nxv8f16(<n x 8 x i1> %pred,
                                                             <n x 8 x half>* %addr)
  ret <n x 8 x half> %res
}

;
; LDNT1W
;

define <n x 4 x i32> @ldnt1w_i32(<n x 4 x i1> %pred, <n x 4 x i32>* %addr) {
; CHECK-LABEL: ldnt1w_i32:
; CHECK: ldnt1w {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 4 x i32> @llvm.aarch64.sve.ldnt1.nxv4i32(<n x 4 x i1> %pred,
                                                            <n x 4 x i32>* %addr)
  ret <n x 4 x i32> %res
}

define <n x 4 x float> @ldnt1w_f32(<n x 4 x i1> %pred, <n x 4 x float>* %addr) {
; CHECK-LABEL: ldnt1w_f32:
; CHECK: ldnt1w {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 4 x float> @llvm.aarch64.sve.ldnt1.nxv4f32(<n x 4 x i1> %pred,
                                                              <n x 4 x float>* %addr)
  ret <n x 4 x float> %res
}

;
; LDNT1D
;

define <n x 2 x i64> @ldnt1d_i64(<n x 2 x i1> %pred, <n x 2 x i64>* %addr) {
; CHECK-LABEL: ldnt1d_i64:
; CHECK: ldnt1d {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 2 x i64> @llvm.aarch64.sve.ldnt1.nxv2i64(<n x 2 x i1> %pred,
                                                            <n x 2 x i64>* %addr)
  ret <n x 2 x i64> %res
}

define <n x 2 x double> @ldnt1d_f64(<n x 2 x i1> %pred, <n x 2 x double>* %addr) {
; CHECK-LABEL: ldnt1d_f64:
; CHECK: ldnt1d {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %res = call <n x 2 x double> @llvm.aarch64.sve.ldnt1.nxv2f64(<n x 2 x i1> %pred,
                                                               <n x 2 x double>* %addr)
  ret <n x 2 x double> %res
}

declare <n x 16 x i8> @llvm.aarch64.sve.ld1rq.nxv16i8(<n x 16 x i1>, i8*)
declare <n x 8 x i16> @llvm.aarch64.sve.ld1rq.nxv8i16(<n x 8 x i1>, i16*)
declare <n x 4 x i32> @llvm.aarch64.sve.ld1rq.nxv4i32(<n x 4 x i1>, i32*)
declare <n x 2 x i64> @llvm.aarch64.sve.ld1rq.nxv2i64(<n x 2 x i1>, i64*)
declare <n x 8 x half> @llvm.aarch64.sve.ld1rq.nxv8f16(<n x 8 x i1>, half*)
declare <n x 4 x float> @llvm.aarch64.sve.ld1rq.nxv4f32(<n x 4 x i1>, float*)
declare <n x 2 x double> @llvm.aarch64.sve.ld1rq.nxv2f64(<n x 2 x i1>, double*)

declare %svint8x2_t @llvm.aarch64.sve.ld2.nxv16i8(<n x 16 x i1>, <n x 16 x i8>*)
declare %svint16x2_t @llvm.aarch64.sve.ld2.nxv8i16(<n x 8 x i1>, <n x 8 x i16>*)
declare %svint32x2_t @llvm.aarch64.sve.ld2.nxv4i32(<n x 4 x i1>, <n x 4 x i32>*)
declare %svint64x2_t @llvm.aarch64.sve.ld2.nxv2i64(<n x 2 x i1>, <n x 2 x i64>*)
declare %svfloat16x2_t @llvm.aarch64.sve.ld2.nxv8f16(<n x 8 x i1>, <n x 8 x half>*)
declare %svfloat32x2_t @llvm.aarch64.sve.ld2.nxv4f32(<n x 4 x i1>, <n x 4 x float>*)
declare %svfloat64x2_t @llvm.aarch64.sve.ld2.nxv2f64(<n x 2 x i1>, <n x 2 x double>*)

declare %svint8x3_t @llvm.aarch64.sve.ld3.nxv16i8(<n x 16 x i1>, <n x 16 x i8>*)
declare %svint16x3_t @llvm.aarch64.sve.ld3.nxv8i16(<n x 8 x i1>, <n x 8 x i16>*)
declare %svint32x3_t @llvm.aarch64.sve.ld3.nxv4i32(<n x 4 x i1>, <n x 4 x i32>*)
declare %svint64x3_t @llvm.aarch64.sve.ld3.nxv2i64(<n x 2 x i1>, <n x 2 x i64>*)
declare %svfloat16x3_t @llvm.aarch64.sve.ld3.nxv8f16(<n x 8 x i1>, <n x 8 x half>*)
declare %svfloat32x3_t @llvm.aarch64.sve.ld3.nxv4f32(<n x 4 x i1>, <n x 4 x float>*)
declare %svfloat64x3_t @llvm.aarch64.sve.ld3.nxv2f64(<n x 2 x i1>, <n x 2 x double>*)

declare %svint8x4_t @llvm.aarch64.sve.ld4.nxv16i8(<n x 16 x i1>, <n x 16 x i8>*)
declare %svint16x4_t @llvm.aarch64.sve.ld4.nxv8i16(<n x 8 x i1>, <n x 8 x i16>*)
declare %svint32x4_t @llvm.aarch64.sve.ld4.nxv4i32(<n x 4 x i1>, <n x 4 x i32>*)
declare %svint64x4_t @llvm.aarch64.sve.ld4.nxv2i64(<n x 2 x i1>, <n x 2 x i64>*)
declare %svfloat16x4_t @llvm.aarch64.sve.ld4.nxv8f16(<n x 8 x i1>, <n x 8 x half>*)
declare %svfloat32x4_t @llvm.aarch64.sve.ld4.nxv4f32(<n x 4 x i1>, <n x 4 x float>*)
declare %svfloat64x4_t @llvm.aarch64.sve.ld4.nxv2f64(<n x 2 x i1>, <n x 2 x double>*)

declare <n x 16 x i8> @llvm.aarch64.sve.ldnt1.nxv16i8(<n x 16 x i1>, <n x 16 x i8>*)
declare <n x 8 x i16> @llvm.aarch64.sve.ldnt1.nxv8i16(<n x 8 x i1>, <n x 8 x i16>*)
declare <n x 4 x i32> @llvm.aarch64.sve.ldnt1.nxv4i32(<n x 4 x i1>, <n x 4 x i32>*)
declare <n x 2 x i64> @llvm.aarch64.sve.ldnt1.nxv2i64(<n x 2 x i1>, <n x 2 x i64>*)
declare <n x 8 x half> @llvm.aarch64.sve.ldnt1.nxv8f16(<n x 8 x i1>, <n x 8 x half>*)
declare <n x 4 x float> @llvm.aarch64.sve.ldnt1.nxv4f32(<n x 4 x i1>, <n x 4 x float>*)
declare <n x 2 x double> @llvm.aarch64.sve.ldnt1.nxv2f64(<n x 2 x i1>, <n x 2 x double>*)
