; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -mattr=+use-iterative-reciprocal -enable-unsafe-fp-math -fp-contract=fast < %s | FileCheck %s

define <n x 2 x double> @frecp_2d(<n x 2 x double> %a) {
; CHECK-LABEL: frecp_2d:
; CHECK: frecpe z1.d, z0.d
; CHECK-NEXT: frecps z2.d, z0.d, z1.d
; CHECK-NEXT: fmul z1.d, z1.d, z2.d
; CHECK-NEXT: frecps z2.d, z0.d, z1.d
; CHECK-NEXT: fmul z1.d, z1.d, z2.d
; CHECK-NEXT: frecps z0.d, z0.d, z1.d
; CHECK-NEXT: fmul z0.d, z1.d, z0.d
; CHECK-NEXT: fmov z1.d, #1.00000000
; CHECK-NEXT: fmul z0.d, z1.d, z0.d
; CHECK-NEXT: ret
  %1 = fdiv fast <n x 2 x double> shufflevector (<n x 2 x double> insertelement (<n x 2 x double> undef, double 1.000000e+00, i32 0), <n x 2 x double> undef, <n x 2 x i32> zeroinitializer), %a
  ret <n x 2 x double> %1
}

define <n x 4 x float> @frecp_4s(<n x 4 x float> %a) {
; CHECK-LABEL: frecp_4s:
; CHECK: frecpe z1.s, z0.s
; CHECK-NEXT: frecps z2.s, z0.s, z1.s
; CHECK-NEXT: fmul z1.s, z1.s, z2.s
; CHECK-NEXT: frecps z0.s, z0.s, z1.s
; CHECK-NEXT: fmul z0.s, z1.s, z0.s
; CHECK-NEXT: fmov z1.s, #1.00000000
; CHECK-NEXT: fmul z0.s, z1.s, z0.s
; CHECK-NEXT: ret
  %1 = fdiv fast <n x 4 x float> shufflevector (<n x 4 x float> insertelement (<n x 4 x float> undef, float 1.000000e+00, i32 0), <n x 4 x float> undef, <n x 4 x i32> zeroinitializer), %a
  ret <n x 4 x float> %1
}
