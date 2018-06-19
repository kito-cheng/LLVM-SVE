; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

;
; FADDA
;

define half @fadda_f16(<n x 8 x i1> %pg, half %init, <n x 8 x half> %a) {
; CHECK-LABEL: fadda_f16:
; CHECK: fadda h0, p0, h0, z1.h
; CHECK-NEXT: ret
  %res = call half @llvm.aarch64.sve.adda.nxv8f16(<n x 8 x i1> %pg,
                                                  half %init,
                                                  <n x 8 x half> %a)
  ret half %res
}

define float @fadda_f32(<n x 4 x i1> %pg, float %init, <n x 4 x float> %a) {
; CHECK-LABEL: fadda_f32:
; CHECK: fadda s0, p0, s0, z1.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.adda.nxv4f32(<n x 4 x i1> %pg,
                                                   float %init,
                                                   <n x 4 x float> %a)
  ret float %res
}

define double @fadda_f64(<n x 2 x i1> %pg, double %init, <n x 2 x double> %a) {
; CHECK-LABEL: fadda_f64:
; CHECK: fadda d0, p0, d0, z1.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.adda.nxv2f64(<n x 2 x i1> %pg,
                                                    double %init,
                                                    <n x 2 x double> %a)
  ret double %res
}

;
; FADDV
;

define half @faddv_f16(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: faddv_f16:
; CHECK: faddv h0, p0, z0.h
; CHECK-NEXT: ret
  %res = call half @llvm.aarch64.sve.addv.nxv8f16(<n x 8 x i1> %pg,
                                                  <n x 8 x half> %a)
  ret half %res
}

define float @faddv_f32(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: faddv_f32:
; CHECK: faddv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.addv.nxv4f32(<n x 4 x i1> %pg,
                                                   <n x 4 x float> %a)
  ret float %res
}

define double @faddv_f64(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: faddv_f64:
; CHECK: faddv d0, p0, z0.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.addv.nxv2f64(<n x 2 x i1> %pg,
                                                    <n x 2 x double> %a)
  ret double %res
}

;
; FMAXNMV
;

define half @fmaxnmv_f16(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fmaxnmv_f16:
; CHECK: fmaxnmv h0, p0, z0.h
; CHECK-NEXT: ret
  %res = call half @llvm.aarch64.sve.maxnmv.nxv8f16(<n x 8 x i1> %pg,
                                                    <n x 8 x half> %a)
  ret half %res
}

define float @fmaxnmv_f32(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmaxnmv_f32:
; CHECK: fmaxnmv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.maxnmv.nxv4f32(<n x 4 x i1> %pg,
                                                     <n x 4 x float> %a)
  ret float %res
}

define double @fmaxnmv_f64(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmaxnmv_f64:
; CHECK: fmaxnmv d0, p0, z0.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.maxnmv.nxv2f64(<n x 2 x i1> %pg,
                                                      <n x 2 x double> %a)
  ret double %res
}

;
; FMAXV
;

define half @fmaxv_f16(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fmaxv_f16:
; CHECK: fmaxv h0, p0, z0.h
; CHECK-NEXT: ret
  %res = call half @llvm.aarch64.sve.maxv.nxv8f16(<n x 8 x i1> %pg,
                                                  <n x 8 x half> %a)
  ret half %res
}

define float @fmaxv_f32(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmaxv_f32:
; CHECK: fmaxv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.maxv.nxv4f32(<n x 4 x i1> %pg,
                                                   <n x 4 x float> %a)
  ret float %res
}

define double @fmaxv_f64(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmaxv_f64:
; CHECK: fmaxv d0, p0, z0.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.maxv.nxv2f64(<n x 2 x i1> %pg,
                                                    <n x 2 x double> %a)
  ret double %res
}

;
; FMINNMV
;

define half @fminnmv_f16(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fminnmv_f16:
; CHECK: fminnmv h0, p0, z0.h
; CHECK-NEXT: ret
  %res = call half @llvm.aarch64.sve.minnmv.nxv8f16(<n x 8 x i1> %pg,
                                                    <n x 8 x half> %a)
  ret half %res
}

define float @fminnmv_f32(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fminnmv_f32:
; CHECK: fminnmv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.minnmv.nxv4f32(<n x 4 x i1> %pg,
                                                     <n x 4 x float> %a)
  ret float %res
}

define double @fminnmv_f64(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fminnmv_f64:
; CHECK: fminnmv d0, p0, z0.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.minnmv.nxv2f64(<n x 2 x i1> %pg,
                                                      <n x 2 x double> %a)
  ret double %res
}

;
; FMINV
;

define half @fminv_f16(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fminv_f16:
; CHECK: fminv h0, p0, z0.h
; CHECK-NEXT: ret
  %res = call half @llvm.aarch64.sve.minv.nxv8f16(<n x 8 x i1> %pg,
                                                  <n x 8 x half> %a)
  ret half %res
}

define float @fminv_f32(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fminv_f32:
; CHECK: fminv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.minv.nxv4f32(<n x 4 x i1> %pg,
                                                   <n x 4 x float> %a)
  ret float %res
}

define double @fminv_f64(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fminv_f64:
; CHECK: fminv d0, p0, z0.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.minv.nxv2f64(<n x 2 x i1> %pg,
                                                    <n x 2 x double> %a)
  ret double %res
}

declare half @llvm.aarch64.sve.adda.nxv8f16(<n x 8 x i1>, half, <n x 8 x half>)
declare float @llvm.aarch64.sve.adda.nxv4f32(<n x 4 x i1>, float, <n x 4 x float>)
declare double @llvm.aarch64.sve.adda.nxv2f64(<n x 2 x i1>, double, <n x 2 x double>)

declare half @llvm.aarch64.sve.addv.nxv8f16(<n x 8 x i1>, <n x 8 x half>)
declare float @llvm.aarch64.sve.addv.nxv4f32(<n x 4 x i1>, <n x 4 x float>)
declare double @llvm.aarch64.sve.addv.nxv2f64(<n x 2 x i1>, <n x 2 x double>)

declare half @llvm.aarch64.sve.maxnmv.nxv8f16(<n x 8 x i1>, <n x 8 x half>)
declare float @llvm.aarch64.sve.maxnmv.nxv4f32(<n x 4 x i1>, <n x 4 x float>)
declare double @llvm.aarch64.sve.maxnmv.nxv2f64(<n x 2 x i1>, <n x 2 x double>)

declare half @llvm.aarch64.sve.maxv.nxv8f16(<n x 8 x i1>, <n x 8 x half>)
declare float @llvm.aarch64.sve.maxv.nxv4f32(<n x 4 x i1>, <n x 4 x float>)
declare double @llvm.aarch64.sve.maxv.nxv2f64(<n x 2 x i1>, <n x 2 x double>)

declare half @llvm.aarch64.sve.minnmv.nxv8f16(<n x 8 x i1>, <n x 8 x half>)
declare float @llvm.aarch64.sve.minnmv.nxv4f32(<n x 4 x i1>, <n x 4 x float>)
declare double @llvm.aarch64.sve.minnmv.nxv2f64(<n x 2 x i1>, <n x 2 x double>)

declare half @llvm.aarch64.sve.minv.nxv8f16(<n x 8 x i1>, <n x 8 x half>)
declare float @llvm.aarch64.sve.minv.nxv4f32(<n x 4 x i1>, <n x 4 x float>)
declare double @llvm.aarch64.sve.minv.nxv2f64(<n x 2 x i1>, <n x 2 x double>)
