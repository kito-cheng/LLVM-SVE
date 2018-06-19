; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -fp-contract=fast < %s | FileCheck %s

; NOTE: -fp-contract=fast required for fmla

define <n x 4 x float> @fadd_s(<n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fadd_s:
; CHECK: fadd z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %res = fadd <n x 4 x float> %a, %b
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fadd_sx2(<n x 2 x float> %a, <n x 2 x float> %b) {
; CHECK-LABEL: fadd_sx2:
; CHECK: fadd z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %res = fadd <n x 2 x float> %a, %b
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fadd_d(<n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fadd_d:
; CHECK: fadd z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = fadd <n x 2 x double> %a, %b
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fdiv_s(<n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fdiv_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fdiv z0.s, [[PG]]/m, z0.s, z1.s
; CHECK-NEXT: ret
  %res = fdiv <n x 4 x float> %a, %b
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fdiv_sx2(<n x 2 x float> %a, <n x 2 x float> %b) {
; CHECK-LABEL: fdiv_sx2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fdiv z0.s, [[PG]]/m, z0.s, z1.s
; CHECK-NEXT: ret
  %res = fdiv <n x 2 x float> %a, %b
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fdiv_d(<n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fdiv_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fdiv z0.d, [[PG]]/m, z0.d, z1.d
; CHECK-NEXT: ret
  %res = fdiv <n x 2 x double> %a, %b
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fdivr_s(<n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fdivr_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fdivr z0.s, [[PG]]/m, z0.s, z1.s
; CHECK-NEXT: ret
  %res = fdiv <n x 4 x float> %b, %a
  ret <n x 4 x float> %res
}

define <n x 2 x double> @fdivr_d(<n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fdivr_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fdivr z0.d, [[PG]]/m, z0.d, z1.d
; CHECK-NEXT: ret
  %res = fdiv <n x 2 x double> %b, %a
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fmad_s(<n x 4 x float> %m1, <n x 4 x float> %m2, <n x 4 x float> %acc) {
; CHECK-LABEL: fmad_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fmad z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 4 x float> %m1, %m2
  %res = fadd <n x 4 x float> %acc, %mul
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fmad_sx2(<n x 2 x float> %m1, <n x 2 x float> %m2, <n x 2 x float> %acc) {
; CHECK-LABEL: fmad_sx2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fmad z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x float> %m1, %m2
  %res = fadd <n x 2 x float> %acc, %mul
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fmad_d(<n x 2 x double> %m1, <n x 2 x double> %m2, <n x 2 x double> %acc) {
; CHECK-LABEL: fmad_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fmad z0.d, [[PG]]/m, z1.d, z2.d
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %res = fadd <n x 2 x double> %acc, %mul
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fmla_s(<n x 4 x float> %acc, <n x 4 x float> %m1, <n x 4 x float> %m2) {
; CHECK-LABEL: fmla_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fmla z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 4 x float> %m1, %m2
  %res = fadd <n x 4 x float> %acc, %mul
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fmla_sx2(<n x 2 x float> %acc, <n x 2 x float> %m1, <n x 2 x float> %m2) {
; CHECK-LABEL: fmla_sx2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fmla z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x float> %m1, %m2
  %res = fadd <n x 2 x float> %acc, %mul
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fmla_d(<n x 2 x double> %acc, <n x 2 x double> %m1, <n x 2 x double> %m2) {
; CHECK-LABEL: fmla_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fmla z0.d, [[PG]]/m, z1.d, z2.d
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %res = fadd <n x 2 x double> %acc, %mul
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fmls_s(<n x 4 x float> %acc, <n x 4 x float> %m1, <n x 4 x float> %m2) {
; CHECK-LABEL: fmls_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fmls z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 4 x float> %m1, %m2
  %res = fsub <n x 4 x float> %acc, %mul
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fmls_sx2(<n x 2 x float> %acc, <n x 2 x float> %m1, <n x 2 x float> %m2) {
; CHECK-LABEL: fmls_sx2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fmls z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x float> %m1, %m2
  %res = fsub <n x 2 x float> %acc, %mul
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fmls_d(<n x 2 x double> %acc, <n x 2 x double> %m1, <n x 2 x double> %m2) {
; CHECK-LABEL: fmls_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fmls z0.d, [[PG]]/m, z1.d, z2.d
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %res = fsub <n x 2 x double> %acc, %mul
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fmsb_s(<n x 4 x float> %m1, <n x 4 x float> %m2, <n x 4 x float> %acc) {
; CHECK-LABEL: fmsb_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fmsb z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 4 x float> %m1, %m2
  %res = fsub <n x 4 x float> %acc, %mul
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fmsb_sx2(<n x 2 x float> %m1, <n x 2 x float> %m2, <n x 2 x float> %acc) {
; CHECK-LABEL: fmsb_sx2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fmsb z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x float> %m1, %m2
  %res = fsub <n x 2 x float> %acc, %mul
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fmsb_d(<n x 2 x double> %m1, <n x 2 x double> %m2, <n x 2 x double> %acc) {
; CHECK-LABEL: fmsb_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fmsb z0.d, [[PG]]/m, z1.d, z2.d
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %res = fsub <n x 2 x double> %acc, %mul
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fmul_s(<n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmul_s:
; CHECK: fmul z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %res = fmul <n x 4 x float> %a, %b
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fmul_sx2(<n x 2 x float> %a, <n x 2 x float> %b) {
; CHECK-LABEL: fmul_sx2:
; CHECK: fmul z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %res = fmul <n x 2 x float> %a, %b
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fmul_d(<n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmul_d:
; CHECK: fmul z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = fmul <n x 2 x double> %a, %b
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fneg_s(<n x 4 x float> %a) {
; CHECK-LABEL: fneg_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: fneg z0.s, [[PG]]/m, z0.s
; CHECK: ret
  %res = fsub <n x 4 x float>
           shufflevector (<n x 4 x float>
             insertelement (<n x 4 x float> undef, float -0.000000e+00, i32 0),
             <n x 4 x float> undef,
             <n x 4 x i32> zeroinitializer),
           %a
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fneg_sx2(<n x 2 x float> %a, <n x 2 x float> %b) {
; CHECK-LABEL: fneg_sx2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fneg z0.s, [[PG]]/m, z0.s
; CHECK: ret
  %res = fsub <n x 2 x float>
           shufflevector (<n x 2 x float>
             insertelement (<n x 2 x float> undef, float -0.000000e+00, i32 0),
             <n x 2 x float> undef,
             <n x 2 x i32> zeroinitializer),
           %a
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fneg_d(<n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fneg_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fneg z0.d, [[PG]]/m, z0.d
; CHECK: ret
  %res = fsub <n x 2 x double>
           shufflevector (<n x 2 x double>
             insertelement (<n x 2 x double> undef, double -0.000000e+00, i32 0),
             <n x 2 x double> undef,
             <n x 2 x i32> zeroinitializer),
           %a
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fnmad_s(<n x 4 x float> %m1, <n x 4 x float> %m2, <n x 4 x float> %acc) {
; CHECK-LABEL: fnmad_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fnmad z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %neg_m1 = fsub <n x 4 x float>
               shufflevector (<n x 4 x float>
                 insertelement (<n x 4 x float> undef, float -0.000000e+00, i32 0),
                 <n x 4 x float> undef,
                 <n x 4 x i32> zeroinitializer),
               %m1

  %mul = fmul <n x 4 x float> %neg_m1, %m2
  %res = fsub <n x 4 x float> %mul, %acc
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fnmad_sx2(<n x 2 x float> %m1, <n x 2 x float> %m2, <n x 2 x float> %acc) {
; CHECK-LABEL: fnmad_sx2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fnmad z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %neg_m1 = fsub <n x 2 x float>
               shufflevector (<n x 2 x float>
                 insertelement (<n x 2 x float> undef, float -0.000000e+00, i32 0),
                 <n x 2 x float> undef,
                 <n x 2 x i32> zeroinitializer),
               %m1

  %mul = fmul <n x 2 x float> %neg_m1, %m2
  %res = fsub <n x 2 x float> %mul, %acc
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fnmad_d(<n x 2 x double> %m1, <n x 2 x double> %m2, <n x 2 x double> %acc) {
; CHECK-LABEL: fnmad_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fnmad z0.d, [[PG]]/m, z1.d, z2.d
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

define <n x 4 x float> @fnmla_s(<n x 4 x float> %acc, <n x 4 x float> %m1, <n x 4 x float> %m2) {
; CHECK-LABEL: fnmla_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fnmla z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %neg_m1 = fsub <n x 4 x float>
               shufflevector (<n x 4 x float>
                 insertelement (<n x 4 x float> undef, float -0.000000e+00, i32 0),
                 <n x 4 x float> undef,
                 <n x 4 x i32> zeroinitializer),
               %m1

  %mul = fmul <n x 4 x float> %neg_m1, %m2
  %res = fsub <n x 4 x float> %mul, %acc
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fnmla_sx2(<n x 2 x float> %acc, <n x 2 x float> %m1, <n x 2 x float> %m2) {
; CHECK-LABEL: fnmla_sx2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fnmla z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %neg_m1 = fsub <n x 2 x float>
               shufflevector (<n x 2 x float>
                 insertelement (<n x 2 x float> undef, float -0.000000e+00, i32 0),
                 <n x 2 x float> undef,
                 <n x 2 x i32> zeroinitializer),
               %m1

  %mul = fmul <n x 2 x float> %neg_m1, %m2
  %res = fsub <n x 2 x float> %mul, %acc
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fnmla_d(<n x 2 x double> %acc, <n x 2 x double> %m1, <n x 2 x double> %m2) {
; CHECK-LABEL: fnmla_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fnmla z0.d, [[PG]]/m, z1.d, z2.d
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

define <n x 4 x float> @fnmls_s(<n x 4 x float> %acc, <n x 4 x float> %m1, <n x 4 x float> %m2) {
; CHECK-LABEL: fnmls_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fnmls z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 4 x float> %m1, %m2
  %res = fsub <n x 4 x float> %mul, %acc
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fnmls_sx2(<n x 2 x float> %acc, <n x 2 x float> %m1, <n x 2 x float> %m2) {
; CHECK-LABEL: fnmls_sx2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fnmls z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x float> %m1, %m2
  %res = fsub <n x 2 x float> %mul, %acc
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fnmls_d(<n x 2 x double> %acc, <n x 2 x double> %m1, <n x 2 x double> %m2) {
; CHECK-LABEL: fnmls_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fnmls z0.d, [[PG]]/m, z1.d, z2.d
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %res = fsub <n x 2 x double> %mul, %acc
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fnmsb_s(<n x 4 x float> %m1, <n x 4 x float> %m2, <n x 4 x float> %acc) {
; CHECK-LABEL: fnmsb_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fnmsb z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 4 x float> %m1, %m2
  %res = fsub <n x 4 x float> %mul, %acc
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fnmsb_sx2(<n x 2 x float> %m1, <n x 2 x float> %m2, <n x 2 x float> %acc) {
; CHECK-LABEL: fnmsb_sx2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fnmsb z0.s, [[PG]]/m, z1.s, z2.s
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x float> %m1, %m2
  %res = fsub <n x 2 x float> %mul, %acc
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fnmsb_d(<n x 2 x double> %m1, <n x 2 x double> %m2, <n x 2 x double> %acc) {
; CHECK-LABEL: fnmsb_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fnmsb z0.d, [[PG]]/m, z1.d, z2.d
; CHECK-NEXT: ret
  %mul = fmul <n x 2 x double> %m1, %m2
  %res = fsub <n x 2 x double> %mul, %acc
  ret <n x 2 x double> %res
}

define <n x 4 x float> @fsub_s(<n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fsub_s:
; CHECK: fsub z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %res = fsub <n x 4 x float> %a, %b
  ret <n x 4 x float> %res
}

define <n x 2 x float> @fsub_sx2(<n x 2 x float> %a, <n x 2 x float> %b) {
; CHECK-LABEL: fsub_sx2:
; CHECK: fsub z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %res = fsub <n x 2 x float> %a, %b
  ret <n x 2 x float> %res
}

define <n x 2 x double> @fsub_d(<n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fsub_d:
; CHECK: fsub z0.d, z0.d, z1.d
; CHECK: ret
  %res = fsub <n x 2 x double> %a, %b
  ret <n x 2 x double> %res
}

;
; Test intrinsics that have a instruction equivalent.
;

declare <n x 4 x float> @llvm.fabs.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.fabs.nxv2f64(<n x 2 x double>)

define <n x 4 x float> @fabs_s(<n x 4 x float> %a) {
; CHECK-LABEL: fabs_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fabs z0.s, [[PG]]/m, z0.s
; CHECK-NEXT: ret
  %res = call <n x 4 x float> @llvm.fabs.nxv4f32(<n x 4 x float> %a)
  ret <n x 4 x float> %res
}

define <n x 2 x double> @fabs_d(<n x 2 x double> %a) {
; CHECK-LABEL: fabs_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fabs z0.d, [[PG]]/m, z0.d
; CHECK-NEXT: ret
  %res = call <n x 2 x double> @llvm.fabs.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

declare <n x 4 x float> @llvm.ceil.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.ceil.nxv2f64(<n x 2 x double>)

define <n x 4 x float> @fceil_s(<n x 4 x float> %a) {
; CHECK-LABEL: fceil_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: frintp z0.s, [[PG]]/m, z0.s
; CHECK-NEXT: ret
  %res = call <n x 4 x float> @llvm.ceil.nxv4f32(<n x 4 x float> %a)
  ret <n x 4 x float> %res
}

define <n x 2 x double> @fceil_d(<n x 2 x double> %a) {
; CHECK-LABEL: fceil_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: frintp z0.d, [[PG]]/m, z0.d
; CHECK-NEXT: ret
  %res = call <n x 2 x double> @llvm.ceil.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

declare <n x 4 x float> @llvm.floor.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.floor.nxv2f64(<n x 2 x double>)

define <n x 4 x float> @ffloor_s(<n x 4 x float> %a) {
; CHECK-LABEL: ffloor_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: frintm z0.s, [[PG]]/m, z0.s
; CHECK-NEXT: ret
  %res = call <n x 4 x float> @llvm.floor.nxv4f32(<n x 4 x float> %a)
  ret <n x 4 x float> %res
}

define <n x 2 x double> @ffloor_d(<n x 2 x double> %a) {
; CHECK-LABEL: ffloor_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: frintm z0.d, [[PG]]/m, z0.d
; CHECK-NEXT: ret
  %res = call <n x 2 x double> @llvm.floor.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

declare <n x 4 x float> @llvm.nearbyint.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.nearbyint.nxv2f64(<n x 2 x double>)

define <n x 4 x float> @fnearbyint_s(<n x 4 x float> %a) {
; CHECK-LABEL: fnearbyint_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: frinti z0.s, [[PG]]/m, z0.s
; CHECK-NEXT: ret
  %res = call <n x 4 x float> @llvm.nearbyint.nxv4f32(<n x 4 x float> %a)
  ret <n x 4 x float> %res
}

define <n x 2 x double> @fnearbyint_d(<n x 2 x double> %a) {
; CHECK-LABEL: fnearbyint_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: frinti z0.d, [[PG]]/m, z0.d
; CHECK-NEXT: ret
  %res = call <n x 2 x double> @llvm.nearbyint.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

declare <n x 4 x float> @llvm.round.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.round.nxv2f64(<n x 2 x double>)

define <n x 4 x float> @fround_s(<n x 4 x float> %a) {
; CHECK-LABEL: fround_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: frinta z0.s, [[PG]]/m, z0.s
; CHECK-NEXT: ret
  %res = call <n x 4 x float> @llvm.round.nxv4f32(<n x 4 x float> %a)
  ret <n x 4 x float> %res
}

define <n x 2 x double> @fround_d(<n x 2 x double> %a) {
; CHECK-LABEL: fround_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: frinta z0.d, [[PG]]/m, z0.d
; CHECK-NEXT: ret
  %res = call <n x 2 x double> @llvm.round.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

declare <n x 4 x float> @llvm.sqrt.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.sqrt.nxv2f64(<n x 2 x double>)

define <n x 4 x float> @fsqrt_s(<n x 4 x float> %a) {
; CHECK-LABEL: fsqrt_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fsqrt z0.s, [[PG]]/m, z0.s
; CHECK-NEXT: ret
  %res = call <n x 4 x float> @llvm.sqrt.nxv4f32(<n x 4 x float> %a)
  ret <n x 4 x float> %res
}

define <n x 2 x double> @fsqrt_d(<n x 2 x double> %a) {
; CHECK-LABEL: fsqrt_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fsqrt z0.d, [[PG]]/m, z0.d
; CHECK-NEXT: ret
  %res = call <n x 2 x double> @llvm.sqrt.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

declare <n x 4 x float> @llvm.trunc.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.trunc.nxv2f64(<n x 2 x double>)

define <n x 4 x float> @ftrunc_s(<n x 4 x float> %a) {
; CHECK-LABEL: ftrunc_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: frintz z0.s, [[PG]]/m, z0.s
; CHECK-NEXT: ret
  %res = call <n x 4 x float> @llvm.trunc.nxv4f32(<n x 4 x float> %a)
  ret <n x 4 x float> %res
}

define <n x 2 x double> @ftrunc_d(<n x 2 x double> %a) {
; CHECK-LABEL: ftrunc_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: frintz z0.d, [[PG]]/m, z0.d
; CHECK-NEXT: ret
  %res = call <n x 2 x double> @llvm.trunc.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}
