; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -O0 < %s | FileCheck %s

; Check that the non-SVE (thus Neon) reduction intrinsic is created.
; resulting in the 'addv' instruction.
define i32 @add_no_sve(<4 x i32> %a) {
; CHECK-LABEL: add_no_sve
; CHECK: addv
  %res = call i32 @llvm.experimental.vector.reduce.add.i32.v4i32(<4 x i32> %a)
  ret i32 %res
}

declare i32 @llvm.experimental.vector.reduce.add.i32.v4i32(<4 x i32> %a)
