; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -fp-contract=fast < %s | FileCheck %s

; NOTE: -fp-contract=fast required for fmla

define <n x 2 x double> @fdiv_d(<n x 2 x double> %_, <n x 2 x double> %a,
                                <n x 2 x double> %b) {
; CHECK-LABEL: fdiv_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: movprfx z0, z1
; CHECK-NEXT: fdiv z0.d, [[PG]]/m, z0.d, z2.d
; CHECK-NEXT: ret
  %res = fdiv <n x 2 x double> %a, %b
  ret <n x 2 x double> %res
}

define <n x 2 x double> @fmla_d(<n x 2 x double> %_, <n x 2 x double> %acc,
                                <n x 2 x double> %m1, <n x 2 x double> %m2) {
; CHECK-LABEL: fmla_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: movprfx z0, z1
; CHECK-NEXT: fmla z0.d, p0/m, z2.d, z3.d
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %res = fadd <n x 2 x double> %acc, %mul
  ret <n x 2 x double> %res
}

define <n x 2 x double> @fmls_d(<n x 2 x double> %_, <n x 2 x double> %acc,
                                <n x 2 x double> %m1, <n x 2 x double> %m2) {
; CHECK-LABEL: fmls_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: movprfx z0, z1
; CHECK-NEXT: fmls z0.d, p0/m, z2.d, z3.d
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %res = fsub <n x 2 x double> %acc, %mul
  ret <n x 2 x double> %res
}

define <n x 2 x double> @fnmla_d(<n x 2 x double> %_, <n x 2 x double> %acc,
                                 <n x 2 x double> %m1, <n x 2 x double> %m2) {
; CHECK-LABEL: fnmla_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: movprfx z0, z1
; CHECK-NEXT: fnmla z0.d, [[PG]]/m, z2.d, z3.d
; CHECK-NEXT: ret
  %neg_m1 = fsub <n x 2 x double>
               shufflevector (<n x 2 x double>
                 insertelement (<n x 2 x double> undef, double -0.000000e+00, i32 0),
                 <n x 2 x double> undef,
                 <n x 2 x i32> zeroinitializer),
               %m1

  %mul = fmul <n x 2 x double> %neg_m1, %m2
  %res = fsub <n x 2 x double> %mul, %acc
  ret <n x 2 x double> %res
}

define <n x 2 x double> @fnmls_d(<n x 2 x double> %_, <n x 2 x double> %acc,
                                 <n x 2 x double> %m1, <n x 2 x double> %m2) {
; CHECK-LABEL: fnmls_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: movprfx z0, z1
; CHECK-NEXT: fnmls z0.d, [[PG]]/m, z2.d, z3.d
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %res = fsub <n x 2 x double> %mul, %acc
  ret <n x 2 x double> %res
}
