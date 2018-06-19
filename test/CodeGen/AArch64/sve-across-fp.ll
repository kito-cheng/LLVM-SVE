; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

; NOTE: Most testing is done within sve-intrinsics-fp-reduce.ll, here we
;       only care about the none standard types.

define float @fadda_nxv2f32(<n x 2 x i1> %pg, float %init, <n x 2 x float> %a) {
; CHECK-LABEL: fadda_nxv2f32:
; CHECK: fadda s0, p0, s0, z1.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.adda.nxv2f32(<n x 2 x i1> %pg,
                                                   float %init,
                                                   <n x 2 x float> %a)
  ret float %res
}

define float @faddv_nxv2f32(<n x 2 x i1> %pg, <n x 2 x float> %a) {
; CHECK-LABEL: faddv_nxv2f32:
; CHECK: faddv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.addv.nxv2f32(<n x 2 x i1> %pg,
                                                   <n x 2 x float> %a)
  ret float %res
}

define float @fmaxv_nxv2f32(<n x 2 x i1> %pg, <n x 2 x float> %a) {
; CHECK-LABEL: fmaxv_nxv2f32:
; CHECK: fmaxv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.maxv.nxv2f32(<n x 2 x i1> %pg,
                                                   <n x 2 x float> %a)
  ret float %res
}

define float @fmaxnmv_nxv2f32(<n x 2 x i1> %pg, <n x 2 x float> %a) {
; CHECK-LABEL: fmaxnmv_nxv2f32:
; CHECK: fmaxnmv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.maxnmv.nxv2f32(<n x 2 x i1> %pg,
                                                     <n x 2 x float> %a)
  ret float %res
}

define float @fminnmv_nxv2f32(<n x 2 x i1> %pg, <n x 2 x float> %a) {
; CHECK-LABEL: fminnmv_nxv2f32:
; CHECK: fminnmv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.minnmv.nxv2f32(<n x 2 x i1> %pg,
                                                     <n x 2 x float> %a)
  ret float %res
}

define float @fminv_nxv2f32(<n x 2 x i1> %pg, <n x 2 x float> %a) {
; CHECK-LABEL: fminv_nxv2f32:
; CHECK: fminv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.minv.nxv2f32(<n x 2 x i1> %pg,
                                                   <n x 2 x float> %a)
  ret float %res
}

declare float @llvm.aarch64.sve.adda.nxv2f32(<n x 2 x i1>, float, <n x 2 x float>)
declare float @llvm.aarch64.sve.addv.nxv2f32(<n x 2 x i1>, <n x 2 x float>)
declare float @llvm.aarch64.sve.maxv.nxv2f32(<n x 2 x i1>, <n x 2 x float>)
declare float @llvm.aarch64.sve.maxnmv.nxv2f32(<n x 2 x i1>, <n x 2 x float>)
declare float @llvm.aarch64.sve.minnmv.nxv2f32(<n x 2 x i1>, <n x 2 x float>)
declare float @llvm.aarch64.sve.minv.nxv2f32(<n x 2 x i1>, <n x 2 x float>)