; RUN: llc -mtriple=aarch64--linux-gnu -enable-no-nans-fp-math -mattr=+sve < %s | FileCheck %s
; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s --check-prefix=NAN

; CHECK-LABEL: t1
; CHECK: smax
define <n x 4 x i32> @t1(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i1> %gp) {
  %t1 = icmp sgt <n x 4 x i32> %a, %b
  %t2 = and <n x 4 x i1> %gp, %t1
  %t3 = select <n x 4 x i1> %t2, <n x 4 x i32> %a, <n x 4 x i32> %b
  ret <n x 4 x i32> %t3
}

; CHECK-LABEL: t1_2
; Inverted operands.
; CHECK: smax
define <n x 4 x i32> @t1_2(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i1> %gp) {
  %t1 = icmp slt <n x 4 x i32> %b, %a
  %t2 = and <n x 4 x i1> %gp, %t1
  %t3 = select <n x 4 x i1> %t2, <n x 4 x i32> %a, <n x 4 x i32> %b
  ret <n x 4 x i32> %t3
}

; CHECK-LABEL: t2
; CHECK: smin
define <n x 4 x i32> @t2(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i1> %gp) {
  %t1 = icmp slt <n x 4 x i32> %a, %b
  %t2 = and <n x 4 x i1> %gp, %t1
  %t3 = select <n x 4 x i1> %t2, <n x 4 x i32> %a, <n x 4 x i32> %b
  ret <n x 4 x i32> %t3
}

; CHECK-LABEL: t3
; CHECK: umax
define <n x 4 x i32> @t3(<n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i1> %gp) {
  %t1 = icmp ugt <n x 4 x i32> %a, %b
  %t2 = and <n x 4 x i1> %gp, %t1
  %t3 = select <n x 4 x i1> %t2, <n x 4 x i32> %a, <n x 4 x i32> %b
  ret <n x 4 x i32> %t3
}

; CHECK-LABEL: t4
; CHECK: umin
define <n x 16 x i8> @t4(<n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i1> %gp) {
  %t1 = icmp ult <n x 16 x i8> %a, %b
  %t2 = and <n x 16 x i1> %gp, %t1
  %t3 = select <n x 16 x i1> %t2, <n x 16 x i8> %a, <n x 16 x i8> %b
  ret <n x 16 x i8> %t3
}

; CHECK-LABEL: f32_minnm
; CHECK: fminnm z1.s, p0/m, z1.s, z0.s
define <n x 4 x float> @f32_minnm(<n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x i1> %gp) {
  %t1 = fcmp ogt <n x 4 x float> %b, %a
  %t2 = and <n x 4 x i1> %gp, %t1
  %t3 = select <n x 4 x i1> %t2, <n x 4 x float> %a, <n x 4 x float> %b
  ret <n x 4 x float> %t3
}

; CHECK-LABEL: f32_maxnm
; CHECK: fmaxnm z1.s, p0/m, z1.s, z0.s
define <n x 4 x float> @f32_maxnm(<n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x i1> %gp) {
  %t1 = fcmp olt <n x 4 x float> %b, %a
  %t2 = and <n x 4 x i1> %gp, %t1
  %t3 = select <n x 4 x i1> %t2, <n x 4 x float> %a, <n x 4 x float> %b
  ret <n x 4 x float> %t3
}

; CHECK-LABEL: f32_min
; NAN-NOT: fmin
define <n x 4 x float> @f32_min(<n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x i1> %gp) {
  %t1 = fcmp ugt <n x 4 x float> %b, %a
  %t2 = and <n x 4 x i1> %gp, %t1
  %t3 = select <n x 4 x i1> %t2, <n x 4 x float> %a, <n x 4 x float> %b
  ret <n x 4 x float> %t3
}
