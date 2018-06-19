; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define void @adr_nxv2i64_mul_8(<n x 2 x i64>* %a, <n x 2 x i64>* %b, <n x 2 x i64>* %c) {
; CHECK-LABEL: adr_nxv2i64_mul_8:
; CHECK-DAG: ld1d {z[[IN0:[0-9]+]].d}, {{p[0-9]+}}/z, [x0]
; CHECK-DAG: ld1d {z[[IN1:[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
; CHECK:     adr  z[[RES:[0-9]+]].d, [z[[IN0]].d, z[[IN1]].d, lsl #3]
; CHECK:     st1d {z[[RES]].d}, {{p[0-9]+}}, [x2]
; CHECK:     ret
  %scale = insertelement <n x 2 x i64> undef, i64 8, i32 0
  %scales = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b

  %mul = mul <n x 2 x i64> %in1, %scales
  %res = add <n x 2 x i64> %in0, %mul

  store <n x 2 x i64> %res, <n x 2 x i64> *%c
  ret void
}

; as above but with shift in place of multiply
define void @adr_nxv2i64_shl_3(<n x 2 x i64>* %a, <n x 2 x i64>* %b, <n x 2 x i64>* %c) {
; CHECK-LABEL: adr_nxv2i64_shl_3:
; CHECK-DAG: ld1d {z[[IN0:[0-9]+]].d}, {{p[0-9]+}}/z, [x0]
; CHECK-DAG: ld1d {z[[IN1:[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
; CHECK:     adr  z[[RES:[0-9]+]].d, [z[[IN0]].d, z[[IN1]].d, lsl #3]
; CHECK:     st1d {z[[RES]].d}, {{p[0-9]+}}, [x2]
; CHECK:     ret
  %scale = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %scales = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b

  %mul = shl <n x 2 x i64> %in1, %scales
  %res = add <n x 2 x i64> %in0, %mul

  store <n x 2 x i64> %res, <n x 2 x i64> *%c
  ret void
}
