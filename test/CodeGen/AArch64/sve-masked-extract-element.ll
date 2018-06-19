; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -o - %s | FileCheck %s

;; TODO: we should just have a single test file that covers nxv2f32 for all instructions.

;; Floating point extraction

declare float @llvm.aarch64.sve.lastb.nxv2f32(<n x 2 x i1>, <n x 2 x float>)

define float @flastb_nxv2i1_nxv2f32(<n x 2 x i1> %pred, <n x 2 x float> %v) {
; CHECK-LABEL:  flastb_nxv2i1_nxv2f32
; CHECK: lastb s0, p0, z0.s
; CHECK: ret
  %res = call float @llvm.aarch64.sve.lastb.nxv2f32(<n x 2 x i1> %pred, <n x 2 x float> %v)
  ret float %res
}
