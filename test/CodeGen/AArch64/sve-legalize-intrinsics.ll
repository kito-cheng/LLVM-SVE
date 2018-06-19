; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 4 x float> @legalize_dup(<n x 4 x double> %a, <n x 4 x i1> %p, double %scalar) {
; CHECK-LABEL: legalize_dup
; CHECK-DAG:  zip1  [[LoP:p[0-9]+]].s, p0.s, p1.s
; CHECK-DAG:  zip2  [[HiP:p[0-9]+]].s, p0.s, p1.s
; CHECK-DAG:  ptrue [[TRUE:p[0-9]+]].d
; CHECK-DAG:  mov   z0.d, [[LoP]]/m, d2
; CHECK-DAG:  mov   z1.d, [[HiP]]/m, d2
; CHECK-DAG:  fcvt  z1.s, [[TRUE]]/m, z1.d
; CHECK-DAG:  fcvt  z0.s, [[TRUE]]/m, z0.d
; CHECK:      uzp1  z0.s, z0.s, z1.s
  %val = call <n x 4 x double> @llvm.aarch64.sve.dup.nxv4f64(<n x 4 x double> %a, <n x 4 x i1> %p, double %scalar)
  %conv = fptrunc <n x 4 x double> %val to <n x 4 x float>
  ret <n x 4 x float> %conv
}

declare <n x 4 x double> @llvm.aarch64.sve.dup.nxv4f64(<n x 4 x double>, <n x 4 x i1>, double)
