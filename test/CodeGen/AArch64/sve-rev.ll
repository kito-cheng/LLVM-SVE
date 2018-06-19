; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 16 x i8> @rev_i8(<n x 16 x i8> %a) {
; CHECK-LABEL: rev_i8:
; CHECK: rev z0.b, z0.b
; CHECK-NEXT: ret
  %1 = insertelement <n x 16 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 16 x i32> %1, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i32> %2, stepvector
  %4 = insertelement <n x 16 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 16), i32 1), i32 0
  %5 = shufflevector <n x 16 x i32> %4, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %mask = add <n x 16 x i32> %5, %3
  %res = shufflevector <n x 16 x i8> %a, <n x 16 x i8> undef, <n x 16 x i32> %mask
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @rev_i16(<n x 8 x i16> %a) {
; CHECK-LABEL: rev_i16:
; CHECK: rev z0.h, z0.h
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 8 x i32> %1, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i32> %2, stepvector
  %4 = insertelement <n x 8 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 8), i32 1), i32 0
  %5 = shufflevector <n x 8 x i32> %4, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %mask = add <n x 8 x i32> %5, %3
  %res = shufflevector <n x 8 x i16> %a, <n x 8 x i16> undef, <n x 8 x i32> %mask
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @rev_i32(<n x 4 x i32> %a) {
; CHECK-LABEL: rev_i32:
; CHECK: rev z0.s, z0.s
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 4), i32 1), i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %mask = add <n x 4 x i32> %5, %3
  %res = shufflevector <n x 4 x i32> %a, <n x 4 x i32> undef, <n x 4 x i32> %mask
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @rev_i64(<n x 2 x i64> %a) {
; CHECK-LABEL: rev_i64:
; CHECK: rev z0.d, z0.d
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 2 x i32> %1, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i32> %2, stepvector
  %4 = insertelement <n x 2 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 2), i32 1), i32 0
  %5 = shufflevector <n x 2 x i32> %4, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %mask = add <n x 2 x i32> %5, %3
  %res = shufflevector <n x 2 x i64> %a, <n x 2 x i64> undef, <n x 2 x i32> %mask
  ret <n x 2 x i64> %res
}

define <n x 2 x float> @rev_nxv2f32(<n x 2 x float> %a) {
; CHECK-LABEL: rev_nxv2f32:
; CHECK: rev z0.d, z0.d
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 2 x i32> %1, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i32> %2, stepvector
  %4 = insertelement <n x 2 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 2), i32 1), i32 0
  %5 = shufflevector <n x 2 x i32> %4, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %mask = add <n x 2 x i32> %5, %3
  %res = shufflevector <n x 2 x float> %a, <n x 2 x float> undef, <n x 2 x i32> %mask
  ret <n x 2 x float> %res
}

define <n x 4 x float> @rev_nxv4f32(<n x 4 x float> %a) {
; CHECK-LABEL: rev_nxv4f32:
; CHECK: rev z0.s, z0.s
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 4), i32 1), i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %mask = add <n x 4 x i32> %5, %3
  %res = shufflevector <n x 4 x float> %a, <n x 4 x float> undef, <n x 4 x i32> %mask
  ret <n x 4 x float> %res
}

define <n x 2 x double> @rev_f64(<n x 2 x double> %a) {
; CHECK-LABEL: rev_f64:
; CHECK: rev z0.d, z0.d
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 2 x i32> %1, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i32> %2, stepvector
  %4 = insertelement <n x 2 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 2), i32 1), i32 0
  %5 = shufflevector <n x 2 x i32> %4, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %mask = add <n x 2 x i32> %5, %3
  %res = shufflevector <n x 2 x double> %a, <n x 2 x double> undef, <n x 2 x i32> %mask
  ret <n x 2 x double> %res
}

define <n x 16 x i1> @rev_b8(<n x 16 x i1> %a) {
; CHECK-LABEL: rev_b8:
; CHECK: rev p0.b, p0.b
; CHECK-NEXT: ret
  %1 = insertelement <n x 16 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 16 x i32> %1, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i32> %2, stepvector
  %4 = insertelement <n x 16 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 16), i32 1), i32 0
  %5 = shufflevector <n x 16 x i32> %4, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %mask = add <n x 16 x i32> %5, %3
  %res = shufflevector <n x 16 x i1> %a, <n x 16 x i1> undef, <n x 16 x i32> %mask
  ret <n x 16 x i1> %res
}

define <n x 8 x i1> @rev_b16(<n x 8 x i1> %a) {
; CHECK-LABEL: rev_b16:
; CHECK: rev p0.h, p0.h
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 8 x i32> %1, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i32> %2, stepvector
  %4 = insertelement <n x 8 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 8), i32 1), i32 0
  %5 = shufflevector <n x 8 x i32> %4, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %mask = add <n x 8 x i32> %5, %3
  %res = shufflevector <n x 8 x i1> %a, <n x 8 x i1> undef, <n x 8 x i32> %mask
  ret <n x 8 x i1> %res
}

define <n x 4 x i1> @rev_b32(<n x 4 x i1> %a) {
; CHECK-LABEL: rev_b32:
; CHECK: rev p0.s, p0.s
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 4), i32 1), i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %mask = add <n x 4 x i32> %5, %3
  %res = shufflevector <n x 4 x i1> %a, <n x 4 x i1> undef, <n x 4 x i32> %mask
  ret <n x 4 x i1> %res
}

define <n x 2 x i1> @rev_b64(<n x 2 x i1> %a) {
; CHECK-LABEL: rev_b64:
; CHECK: rev p0.d, p0.d
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i32> undef, i32 -1, i32 0
  %2 = shufflevector <n x 2 x i32> %1, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i32> %2, stepvector
  %4 = insertelement <n x 2 x i32> undef, i32 sub (i32 mul (i32 vscale, i32 2), i32 1), i32 0
  %5 = shufflevector <n x 2 x i32> %4, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %mask = add <n x 2 x i32> %5, %3
  %res = shufflevector <n x 2 x i1> %a, <n x 2 x i1> undef, <n x 2 x i32> %mask
  ret <n x 2 x i1> %res
}


define <n x 8 x i16> @revb_i16(<n x 8 x i16> %a) {
; CHECK-LABEL: revb_i16:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: revb z0.h, [[PG]]/m, z0.h
; CHECK-NEXT: ret
  %res = call <n x 8 x i16> @llvm.bswap.nxv8i16(<n x 8 x i16> %a)
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @revb_i32(<n x 4 x i32> %a) {
; CHECK-LABEL: revb_i32:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: revb z0.s, [[PG]]/m, z0.s
; CHECK-NEXT: ret
  %res = call <n x 4 x i32> @llvm.bswap.nxv4i32(<n x 4 x i32> %a)
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @revb_i64(<n x 2 x i64> %a) {
; CHECK-LABEL: revb_i64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: revb z0.d, [[PG]]/m, z0.d
; CHECK-NEXT: ret
  %res = call <n x 2 x i64> @llvm.bswap.nxv2i64(<n x 2 x i64> %a)
  ret <n x 2 x i64> %res
}

declare <n x 8 x i16> @llvm.bswap.nxv8i16(<n x 8 x i16>)
declare <n x 4 x i32> @llvm.bswap.nxv4i32(<n x 4 x i32>)
declare <n x 2 x i64> @llvm.bswap.nxv2i64(<n x 2 x i64>)
