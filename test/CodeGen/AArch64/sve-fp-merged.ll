; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -fp-contract=fast < %s | FileCheck %s

; NOTE: -fp-contract=fast required for fmla

define <n x 4 x float> @fmla_s(<n x 4 x i1> %pred, <n x 4 x float> %acc,
                               <n x 4 x float> %m1, <n x 4 x float> %m2) {
; CHECK-LABEL: fmla_s:
; CHECK: fmla z0.s, p0/m, z1.s, z2.s
; CHECK: ret
  %mul = fmul <n x 4 x float> %m1, %m2
  %add = fadd <n x 4 x float> %acc, %mul
  %res = select <n x 4 x i1> %pred, <n x 4 x float> %add, <n x 4 x float> %acc
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fmla_sx2(<n x 2 x i1> %pred, <n x 2 x float> %acc,
                                 <n x 2 x float> %m1, <n x 2 x float> %m2) {
; CHECK-LABEL: fmla_sx2:
; CHECK: fmla z0.s, p0/m, z1.s, z2.s
; CHECK: ret
  %mul = fmul <n x 2 x float> %m1, %m2
  %add = fadd <n x 2 x float> %acc, %mul
  %res = select <n x 2 x i1> %pred, <n x 2 x float> %add, <n x 2 x float> %acc
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fmla_d(<n x 2 x i1> %pred, <n x 2 x double> %acc,
                                <n x 2 x double> %m1, <n x 2 x double> %m2) {
; CHECK-LABEL: fmla_d:
; CHECK: fmla z0.d, p0/m, z1.d, z2.d
; CHECK: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %add = fadd <n x 2 x double> %acc, %mul
  %res = select <n x 2 x i1> %pred, <n x 2 x double> %add, <n x 2 x double> %acc
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fmls_s(<n x 4 x i1> %pred, <n x 4 x float> %acc,
                               <n x 4 x float> %m1, <n x 4 x float> %m2) {
; CHECK-LABEL: fmls_s:
; CHECK: fmls z0.s, p0/m, z1.s, z2.s
; CHECK: ret
  %mul = fmul <n x 4 x float> %m1, %m2
  %sub = fsub <n x 4 x float> %acc, %mul
  %res = select <n x 4 x i1> %pred, <n x 4 x float> %sub, <n x 4 x float> %acc
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fmls_sx2(<n x 2 x i1> %pred, <n x 2 x float> %acc,
                                 <n x 2 x float> %m1, <n x 2 x float> %m2) {
; CHECK-LABEL: fmls_sx2:
; CHECK: fmls z0.s, p0/m, z1.s, z2.s
; CHECK: ret
  %mul = fmul <n x 2 x float> %m1, %m2
  %sub = fsub <n x 2 x float> %acc, %mul
  %res = select <n x 2 x i1> %pred, <n x 2 x float> %sub, <n x 2 x float> %acc
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fmls_d(<n x 2 x i1> %pred, <n x 2 x double> %acc,
                                <n x 2 x double> %m1, <n x 2 x double> %m2) {
; CHECK-LABEL: fmls_d:
; CHECK: fmls z0.d, p0/m, z1.d, z2.d
; CHECK: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %sub = fsub <n x 2 x double> %acc, %mul
  %res = select <n x 2 x i1> %pred, <n x 2 x double> %sub, <n x 2 x double> %acc
  ret <n x 2 x double> %res
}
