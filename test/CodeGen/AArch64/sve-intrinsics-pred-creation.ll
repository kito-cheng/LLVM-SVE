; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; PTRUE
;

define <n x 16 x i1> @ptrue_b8() {
; CHECK-LABEL: ptrue_b8:
; CHECK: ptrue p0.b, pow2
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 0)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ptrue_b16() {
; CHECK-LABEL: ptrue_b16:
; CHECK: ptrue p0.h, vl1
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 1)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ptrue_b32() {
; CHECK-LABEL: ptrue_b32:
; CHECK: ptrue p0.s, mul3
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 30)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ptrue_b64() {
; CHECK-LABEL: ptrue_b64:
; CHECK: ptrue p0.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  ret <n x 2 x i1> %out
}

declare <n x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 %pattern)
declare <n x 8 x i1> @llvm.aarch64.sve.ptrue.nxv8i1(i32 %pattern)
declare <n x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 %pattern)
declare <n x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 %pattern)
