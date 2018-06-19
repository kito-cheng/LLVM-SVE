; RUN: opt -instcombine -S < %s | FileCheck %s

; CHECK-LABEL: fold
; CHECK: ret <4 x float> zeroinitializer
define <4 x float> @fold() {
  %t = call <4 x float> @llvm.floor.v4f32(<4 x float> zeroinitializer)
  ret <4 x float> %t
}

; CHECK-LABEL: no_fold
; CHECK: llvm.floor.nxv4f32
define <n x 4 x float> @no_fold() {
  %t = call <n x 4 x float> @llvm.floor.nxv4f32(<n x 4 x float> zeroinitializer)
  ret <n x 4 x float> %t
}


declare <4 x float> @llvm.floor.v4f32(<4 x float>)
declare <n x 4 x float> @llvm.floor.nxv4f32(<n x 4 x float>)
