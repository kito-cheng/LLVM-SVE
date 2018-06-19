; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; FCVT
;

define <n x 8 x half> @fcvt_f16_f32(<n x 8 x half> %a, <n x 16 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvt_f16_f32:
; CHECK: fcvt z0.h, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 8 x half> @llvm.aarch64.sve.fcvt.f16f32(<n x 8 x half> %a,
                                                           <n x 16 x i1> %pg,
                                                           <n x 4 x float> %b)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @fcvt_f16_f64(<n x 8 x half> %a, <n x 16 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvt_f16_f64:
; CHECK: fcvt z0.h, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x half> @llvm.aarch64.sve.fcvt.f16f64(<n x 8 x half> %a,
                                                           <n x 16 x i1> %pg,
                                                           <n x 2 x double> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fcvt_f32_f16(<n x 4 x float> %a, <n x 16 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: fcvt_f32_f16:
; CHECK: fcvt z0.s, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.fcvt.f32f16(<n x 4 x float> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 8 x half> %b)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fcvt_f32_f64(<n x 4 x float> %a, <n x 16 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvt_f32_f64:
; CHECK: fcvt z0.s, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.fcvt.f32f64(<n x 4 x float> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 2 x double> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fcvt_f64_f16(<n x 2 x double> %a, <n x 16 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: fcvt_f64_f16:
; CHECK: fcvt z0.d, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.fcvt.f64f16(<n x 2 x double> %a,
                                                             <n x 16 x i1> %pg,
                                                             <n x 8 x half> %b)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @fcvt_f64_f32(<n x 2 x double> %a, <n x 16 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvt_f64_f32:
; CHECK: fcvt z0.d, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.fcvt.f64f32(<n x 2 x double> %a,
                                                             <n x 16 x i1> %pg,
                                                             <n x 4 x float> %b)
  ret <n x 2 x double> %out
}

;
; FCVTZS
;

define <n x 8 x i16> @fcvtzs_i16_f16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: fcvtzs_i16_f16:
; CHECK: fcvtzs z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.fcvtzs.nxv8i16.nxv8f16(<n x 8 x i16> %a,
                                                                     <n x 8 x i1> %pg,
                                                                     <n x 8 x half> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @fcvtzs_i32_f32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvtzs_i32_f32:
; CHECK: fcvtzs z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.fcvtzs.nxv4i32.nxv4f32(<n x 4 x i32> %a,
                                                                     <n x 4 x i1> %pg,
                                                                     <n x 4 x float> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @fcvtzs_i64_f64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvtzs_i64_f64:
; CHECK: fcvtzs z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.fcvtzs.nxv2i64.nxv2f64(<n x 2 x i64> %a,
                                                                     <n x 2 x i1> %pg,
                                                                     <n x 2 x double> %b)
  ret <n x 2 x i64> %out
}

define <n x 4 x i32> @fcvtzs_i32_f16(<n x 4 x i32> %a, <n x 16 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: fcvtzs_i32_f16:
; CHECK: fcvtzs z0.s, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.fcvtzs.i32f16(<n x 4 x i32> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 8 x half> %b)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @fcvtzs_i32_f64(<n x 4 x i32> %a, <n x 16 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvtzs_i32_f64:
; CHECK: fcvtzs z0.s, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.fcvtzs.i32f64(<n x 4 x i32> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 2 x double> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @fcvtzs_i64_f16(<n x 2 x i64> %a, <n x 16 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: fcvtzs_i64_f16:
; CHECK: fcvtzs z0.d, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.fcvtzs.i64f16(<n x 2 x i64> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 8 x half> %b)
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @fcvtzs_i64_f32(<n x 2 x i64> %a, <n x 16 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvtzs_i64_f32:
; CHECK: fcvtzs z0.d, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.fcvtzs.i64f32(<n x 2 x i64> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 4 x float> %b)
  ret <n x 2 x i64> %out
}

;
; FCVTZU
;

define <n x 8 x i16> @fcvtzu_i16_f16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: fcvtzu_i16_f16:
; CHECK: fcvtzu z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.fcvtzu.nxv8i16.nxv8f16(<n x 8 x i16> %a,
                                                                     <n x 8 x i1> %pg,
                                                                     <n x 8 x half> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @fcvtzu_i32_f32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvtzu_i32_f32:
; CHECK: fcvtzu z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.fcvtzu.nxv4i32.nxv4f32(<n x 4 x i32> %a,
                                                                     <n x 4 x i1> %pg,
                                                                     <n x 4 x float> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @fcvtzu_i64_f64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvtzu_i64_f64:
; CHECK: fcvtzu z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.fcvtzu.nxv2i64.nxv2f64(<n x 2 x i64> %a,
                                                                     <n x 2 x i1> %pg,
                                                                     <n x 2 x double> %b)
  ret <n x 2 x i64> %out
}

define <n x 4 x i32> @fcvtzu_i32_f16(<n x 4 x i32> %a, <n x 16 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: fcvtzu_i32_f16:
; CHECK: fcvtzu z0.s, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.fcvtzu.i32f16(<n x 4 x i32> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 8 x half> %b)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @fcvtzu_i32_f64(<n x 4 x i32> %a, <n x 16 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvtzu_i32_f64:
; CHECK: fcvtzu z0.s, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.fcvtzu.i32f64(<n x 4 x i32> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 2 x double> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @fcvtzu_i64_f16(<n x 2 x i64> %a, <n x 16 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: fcvtzu_i64_f16:
; CHECK: fcvtzu z0.d, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.fcvtzu.i64f16(<n x 2 x i64> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 8 x half> %b)
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @fcvtzu_i64_f32(<n x 2 x i64> %a, <n x 16 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvtzu_i64_f32:
; CHECK: fcvtzu z0.d, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.fcvtzu.i64f32(<n x 2 x i64> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 4 x float> %b)
  ret <n x 2 x i64> %out
}

;
; SCVTF
;

define <n x 8 x half> @scvtf_f16_i16(<n x 8 x half> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: scvtf_f16_i16:
; CHECK: scvtf z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x half> @llvm.aarch64.sve.scvtf.nxv8f16.nxv8i16(<n x 8 x half> %a,
                                                                     <n x 8 x i1> %pg,
                                                                     <n x 8 x i16> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @scvtf_f32_i32(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: scvtf_f32_i32:
; CHECK: scvtf z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.scvtf.nxv4f32.nxv4i32(<n x 4 x float> %a,
                                                                      <n x 4 x i1> %pg,
                                                                      <n x 4 x i32> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @scvtf_f64_i64(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: scvtf_f64_i64:
; CHECK: scvtf z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.scvtf.nxv2f64.nxv2i64(<n x 2 x double> %a,
                                                                       <n x 2 x i1> %pg,
                                                                       <n x 2 x i64> %b)
  ret <n x 2 x double> %out
}

define <n x 8 x half> @scvtf_f16_i32(<n x 8 x half> %a, <n x 16 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: scvtf_f16_i32:
; CHECK: scvtf z0.h, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 8 x half> @llvm.aarch64.sve.scvtf.f16i32(<n x 8 x half> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 4 x i32> %b)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @scvtf_f16_i64(<n x 8 x half> %a, <n x 16 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: scvtf_f16_i64:
; CHECK: scvtf z0.h, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x half> @llvm.aarch64.sve.scvtf.f16i64(<n x 8 x half> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 2 x i64> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @scvtf_f32_i64(<n x 4 x float> %a, <n x 16 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: scvtf_f32_i64:
; CHECK: scvtf z0.s, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.scvtf.f32i64(<n x 4 x float> %a,
                                                             <n x 16 x i1> %pg,
                                                             <n x 2 x i64> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @scvtf_f64_i32(<n x 2 x double> %a, <n x 16 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: scvtf_f64_i32:
; CHECK: scvtf z0.d, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.scvtf.f64i32(<n x 2 x double> %a,
                                                              <n x 16 x i1> %pg,
                                                              <n x 4 x i32> %b)
  ret <n x 2 x double> %out
}

;
; UCVTF
;

define <n x 8 x half> @ucvtf_f16_i16(<n x 8 x half> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: ucvtf_f16_i16:
; CHECK: ucvtf z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x half> @llvm.aarch64.sve.ucvtf.nxv8f16.nxv8i16(<n x 8 x half> %a,
                                                                     <n x 8 x i1> %pg,
                                                                     <n x 8 x i16> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @ucvtf_f32_i32(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: ucvtf_f32_i32:
; CHECK: ucvtf z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.ucvtf.nxv4f32.nxv4i32(<n x 4 x float> %a,
                                                                      <n x 4 x i1> %pg,
                                                                      <n x 4 x i32> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @ucvtf_f64_i64(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: ucvtf_f64_i64:
; CHECK: ucvtf z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.ucvtf.nxv2f64.nxv2i64(<n x 2 x double> %a,
                                                                       <n x 2 x i1> %pg,
                                                                       <n x 2 x i64> %b)
  ret <n x 2 x double> %out
}

define <n x 8 x half> @ucvtf_f16_i32(<n x 8 x half> %a, <n x 16 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: ucvtf_f16_i32:
; CHECK: ucvtf z0.h, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 8 x half> @llvm.aarch64.sve.ucvtf.f16i32(<n x 8 x half> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 4 x i32> %b)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @ucvtf_f16_i64(<n x 8 x half> %a, <n x 16 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: ucvtf_f16_i64:
; CHECK: ucvtf z0.h, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x half> @llvm.aarch64.sve.ucvtf.f16i64(<n x 8 x half> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 2 x i64> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @ucvtf_f32_i64(<n x 4 x float> %a, <n x 16 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: ucvtf_f32_i64:
; CHECK: ucvtf z0.s, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.ucvtf.f32i64(<n x 4 x float> %a,
                                                             <n x 16 x i1> %pg,
                                                             <n x 2 x i64> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @ucvtf_f64_i32(<n x 2 x double> %a, <n x 16 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: ucvtf_f64_i32:
; CHECK: ucvtf z0.d, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.ucvtf.f64i32(<n x 2 x double> %a,
                                                              <n x 16 x i1> %pg,
                                                              <n x 4 x i32> %b)
  ret <n x 2 x double> %out
}

declare <n x 8 x half> @llvm.aarch64.sve.fcvt.f16f32(<n x 8 x half>, <n x 16 x i1>, <n x 4 x float>)
declare <n x 8 x half> @llvm.aarch64.sve.fcvt.f16f64(<n x 8 x half>, <n x 16 x i1>, <n x 2 x double>)
declare <n x 4 x float> @llvm.aarch64.sve.fcvt.f32f16(<n x 4 x float>, <n x 16 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.fcvt.f32f64(<n x 4 x float>, <n x 16 x i1>, <n x 2 x double>)
declare <n x 2 x double> @llvm.aarch64.sve.fcvt.f64f16(<n x 2 x double>, <n x 16 x i1>, <n x 8 x half>)
declare <n x 2 x double> @llvm.aarch64.sve.fcvt.f64f32(<n x 2 x double>, <n x 16 x i1>, <n x 4 x float>)

declare <n x 8 x i16> @llvm.aarch64.sve.fcvtzs.nxv8i16.nxv8f16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x i32> @llvm.aarch64.sve.fcvtzs.nxv4i32.nxv4f32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x i64> @llvm.aarch64.sve.fcvtzs.nxv2i64.nxv2f64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x double>)
declare <n x 4 x i32> @llvm.aarch64.sve.fcvtzs.i32f16(<n x 4 x i32>, <n x 16 x i1>, <n x 8 x half>)
declare <n x 4 x i32> @llvm.aarch64.sve.fcvtzs.i32f64(<n x 4 x i32>, <n x 16 x i1>, <n x 2 x double>)
declare <n x 2 x i64> @llvm.aarch64.sve.fcvtzs.i64f16(<n x 2 x i64>, <n x 16 x i1>, <n x 8 x half>)
declare <n x 2 x i64> @llvm.aarch64.sve.fcvtzs.i64f32(<n x 2 x i64>, <n x 16 x i1>, <n x 4 x float>)

declare <n x 8 x i16> @llvm.aarch64.sve.fcvtzu.nxv8i16.nxv8f16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x i32> @llvm.aarch64.sve.fcvtzu.nxv4i32.nxv4f32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x i64> @llvm.aarch64.sve.fcvtzu.nxv2i64.nxv2f64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x double>)
declare <n x 4 x i32> @llvm.aarch64.sve.fcvtzu.i32f16(<n x 4 x i32>, <n x 16 x i1>, <n x 8 x half>)
declare <n x 4 x i32> @llvm.aarch64.sve.fcvtzu.i32f64(<n x 4 x i32>, <n x 16 x i1>, <n x 2 x double>)
declare <n x 2 x i64> @llvm.aarch64.sve.fcvtzu.i64f16(<n x 2 x i64>, <n x 16 x i1>, <n x 8 x half>)
declare <n x 2 x i64> @llvm.aarch64.sve.fcvtzu.i64f32(<n x 2 x i64>, <n x 16 x i1>, <n x 4 x float>)

declare <n x 8 x half> @llvm.aarch64.sve.scvtf.nxv8f16.nxv8i16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x float> @llvm.aarch64.sve.scvtf.nxv4f32.nxv4i32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.scvtf.nxv2f64.nxv2i64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 8 x half> @llvm.aarch64.sve.scvtf.f16i32(<n x 8 x half>, <n x 16 x i1>, <n x 4 x i32>)
declare <n x 8 x half> @llvm.aarch64.sve.scvtf.f16i64(<n x 8 x half>, <n x 16 x i1>, <n x 2 x i64>)
declare <n x 4 x float> @llvm.aarch64.sve.scvtf.f32i64(<n x 4 x float>, <n x 16 x i1>, <n x 2 x i64>)
declare <n x 2 x double> @llvm.aarch64.sve.scvtf.f64i32(<n x 2 x double>, <n x 16 x i1>, <n x 4 x i32>)

declare <n x 8 x half> @llvm.aarch64.sve.ucvtf.nxv8f16.nxv8i16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x float> @llvm.aarch64.sve.ucvtf.nxv4f32.nxv4i32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.ucvtf.nxv2f64.nxv2i64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 8 x half> @llvm.aarch64.sve.ucvtf.f16i32(<n x 8 x half>, <n x 16 x i1>, <n x 4 x i32>)
declare <n x 8 x half> @llvm.aarch64.sve.ucvtf.f16i64(<n x 8 x half>, <n x 16 x i1>, <n x 2 x i64>)
declare <n x 4 x float> @llvm.aarch64.sve.ucvtf.f32i64(<n x 4 x float>, <n x 16 x i1>, <n x 2 x i64>)
declare <n x 2 x double> @llvm.aarch64.sve.ucvtf.f64i32(<n x 2 x double>, <n x 16 x i1>, <n x 4 x i32>)
