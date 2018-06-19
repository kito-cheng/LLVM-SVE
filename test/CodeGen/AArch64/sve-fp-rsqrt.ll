; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -mattr=+use-reciprocal-square-root -enable-unsafe-fp-math -fp-contract=fast < %s | FileCheck %s

declare <n x 4 x float> @llvm.sqrt.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.sqrt.nxv2f64(<n x 2 x double>)

define <n x 2 x double> @fsqrt_2d(<n x 2 x double> %a) {
; CHECK-LABEL: fsqrt_2d:
; CHECK: frsqrte [[EST1:z[0-9]+]].d, [[SRC1:z[0-9]+]].d
; CHECK-NEXT: fmul [[EST2:z[0-9]+]].d, [[EST1]].d, [[EST1]].d
; CHECK-NEXT: frsqrts [[EST2]].d, [[SRC1]].d, [[EST2]].d
; CHECK-NEXT: fmul [[EST1]].d, [[EST1]].d, [[EST2]].d
; CHECK-NEXT: fmul [[EST2]].d, [[EST1]].d, [[EST1]].d
; CHECK-NEXT: frsqrts [[EST2]].d, [[SRC1]].d, [[EST2]].d
; CHECK-NEXT: fmul [[EST1]].d, [[EST1]].d, [[EST2]].d
; CHECK-NEXT: fmul [[EST2]].d, [[EST1]].d, [[EST1]].d
; CHECK-NEXT: frsqrts [[EST2]].d, [[SRC1]].d, [[EST2]].d
; CHECK-NEXT: ptrue [[PRED:p[0-9]+]].d
; CHECK-NEXT: fmul [[EST1]].d, [[EST1]].d, [[EST2]].d
; CHECK-NEXT: fmul [[EST1]].d, [[SRC1]].d, [[EST1]].d
; CHECK-NEXT: fcmeq [[PRED]].d, [[PRED]]/z, [[SRC1]].d, #0.0
; CHECK-NEXT: sel [[SRC1]].d, [[PRED]], [[SRC1]].d, [[EST1]].d
; CHECK-NEXT: ret
  %1 = call <n x 2 x double> @llvm.sqrt.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %1
}

define <n x 4 x float> @fsqrt_4s(<n x 4 x float> %a) {
; CHECK-LABEL: fsqrt_4s:
; CHECK: frsqrte [[EST1:z[0-9]+]].s, [[SRC1:z[0-9]+]].s
; CHECK-NEXT: fmul [[EST2:z[0-9]+]].s, [[EST1]].s, [[EST1]].s
; CHECK-NEXT: frsqrts [[EST2]].s, [[SRC1]].s, [[EST2]].s
; CHECK-NEXT: fmul [[EST1]].s, [[EST1]].s, [[EST2]].s
; CHECK-NEXT: fmul [[EST2]].s, [[EST1]].s, [[EST1]].s
; CHECK-NEXT: frsqrts [[EST2]].s, [[SRC1]].s, [[EST2]].s
; CHECK-NEXT: ptrue [[PRED:p[0-9]+]].s
; CHECK-NEXT: fmul [[EST1]].s, [[EST1]].s, [[EST2]].s
; CHECK-NEXT: fmul [[EST1]].s, [[SRC1]].s, [[EST1]].s
; CHECK-NEXT: fcmeq [[PRED]].s, [[PRED]]/z, [[SRC1]].s, #0.0
; CHECK-NEXT: sel [[SRC1]].s, [[PRED]], [[SRC1]].s, [[EST1]].s
; CHECK-NEXT: ret
  %1 = call <n x 4 x float> @llvm.sqrt.nxv4f32(<n x 4 x float> %a)
  ret <n x 4 x float> %1
}

define <n x 2 x double> @frsqrt_2d(<n x 2 x double> %a) {
; CHECK-LABEL: frsqrt_2d:
; CHECK: frsqrte [[EST1:z[0-9]+]].d, [[SRC1:z[0-9]+]].d
; CHECK-NEXT: fmul [[EST2:z[0-9]+]].d, [[EST1]].d, [[EST1]].d
; CHECK-NEXT: frsqrts [[EST2]].d, [[SRC1]].d, [[EST2]].d
; CHECK-NEXT: fmul [[EST1]].d, [[EST1]].d, [[EST2]].d
; CHECK-NEXT: fmul [[EST2]].d, [[EST1]].d, [[EST1]].d
; CHECK-NEXT: frsqrts [[EST2]].d, [[SRC1]].d, [[EST2]].d
; CHECK-NEXT: fmul [[EST1]].d, [[EST1]].d, [[EST2]].d
; CHECK-NEXT: fmul [[EST2]].d, [[EST1]].d, [[EST1]].d
; CHECK-NEXT: frsqrts [[SRC1]].d, [[SRC1]].d, [[EST2]].d
; CHECK-NEXT: fmul [[SRC1]].d, [[EST1]].d, [[SRC1]].d
; CHECK-NEXT: fmov [[EST1]].d, #1.00000000
; CHECK-NEXT: fmul [[SRC1]].d, [[EST1]].d, [[SRC1]].d
; CHECK-NEXT: ret
  %1 = call <n x 2 x double> @llvm.sqrt.nxv2f64(<n x 2 x double> %a)
  %2 = fdiv fast <n x 2 x double> shufflevector (<n x 2 x double> insertelement (<n x 2 x double> undef, double 1.000000e+00, i32 0), <n x 2 x double> undef, <n x 2 x i32> zeroinitializer), %1
  ret <n x 2 x double> %2
}

define <n x 4 x float> @frsqrt_4s(<n x 4 x float> %a) {
; CHECK-LABEL: frsqrt_4s:
; CHECK: frsqrte [[EST1:z[0-9]+]].s, [[SRC1:z[0-9]+]].s
; CHECK-NEXT: fmul [[EST2:z[0-9]+]].s, [[EST1]].s, [[EST1]].s
; CHECK-NEXT: frsqrts [[EST2]].s, [[SRC1]].s, [[EST2]].s
; CHECK-NEXT: fmul [[EST1]].s, [[EST1]].s, [[EST2]].s
; CHECK-NEXT: fmul [[EST2]].s, [[EST1]].s, [[EST1]].s
; CHECK-NEXT: frsqrts [[SRC1]].s, [[SRC1]].s, [[EST2]].s
; CHECK-NEXT: fmul [[SRC1]].s, [[EST1]].s, [[SRC1]].s
; CHECK-NEXT: fmov [[EST1]].s, #1.00000000
; CHECK-NEXT: fmul [[SRC1]].s, [[EST1]].s, [[SRC1]].s
; CHECK-NEXT: ret
  %1 = call fast <n x 4 x float> @llvm.sqrt.nxv4f32(<n x 4 x float> %a)
  %2 = fdiv fast <n x 4 x float> shufflevector (<n x 4 x float> insertelement (<n x 4 x float> undef, float 1.000000e+00, i32 0), <n x 4 x float> undef, <n x 4 x i32> zeroinitializer), %1
  ret <n x 4 x float> %2
}
