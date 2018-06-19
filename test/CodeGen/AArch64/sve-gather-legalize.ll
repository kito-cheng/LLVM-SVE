; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

; Tests that exercise various type legalisation scenarios for ISD::MGATHER.

; Code generate load of an illegal datatype via promotion.
define <n x 2 x i8> @masked_gather_nxv2i8(<n x 2 x i8*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_gather_nxv2i8:
; CHECK: ld1sb {z0.d}, p0/z, [z0.d]
; CHECK: ret
  %data = call <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  ret <n x 2 x i8> %data
}

; Code generate load of an illegal datatype via promotion.
define <n x 2 x i16> @masked_gather_nxv2i16(<n x 2 x i16*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_gather_nxv2i16:
; CHECK: ld1sh {z0.d}, p0/z, [z0.d]
; CHECK: ret
  %data = call <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  ret <n x 2 x i16> %data
}

; Code generate load of an illegal datatype via promotion.
define <n x 2 x i32> @masked_gather_nxv2i32(<n x 2 x i32*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_gather_nxv2i32:
; CHECK: ld1sw {z0.d}, p0/z, [z0.d]
; CHECK: ret
  %data = call <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  ret <n x 2 x i32> %data
}

; Code generate the worst case scenario when all vector types are legal.
define <n x 16 x i8> @masked_gather_nxv16i8(i8* %base, <n x 16 x i8> %indices, <n x 16 x i1> %mask) {
; CHECK-LABEL: masked_gather_nxv16i8:
; CHECK-DAG: ld1sb {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK: ret
  %ptrs = getelementptr i8, i8* %base, <n x 16 x i8> %indices
  %data = call <n x 16 x i8> @llvm.masked.gather.nxv16i8(<n x 16 x i8*> %ptrs, i32 1, <n x 16 x i1> %mask, <n x 16 x i8> undef)
  ret <n x 16 x i8> %data
}

; Code generate the worst case scenario when all vector types are illegal.
define <n x 32 x i32> @masked_gather_nxv32i32(i32* %base, <n x 32 x i32> %indices, <n x 32 x i1> %mask) {
; CHECK-LABEL: masked_gather_nxv32i32:
; CHECK-NOT: unpkhi
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z0.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z1.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z2.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z3.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z4.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z5.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z6.s, sxtw #2]
; CHECK-DAG: ld1w {{{z[0-9]+}}.s}, {{p[0-9]+}}/z, [x0, z7.s, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr i32, i32* %base, <n x 32 x i32> %indices
  %data = call <n x 32 x i32> @llvm.masked.gather.nxv32i32(<n x 32 x i32*> %ptrs, i32 4, <n x 32 x i1> %mask, <n x 32 x i32> undef)
  ret <n x 32 x i32> %data
}

;; TODO: Currently, the sign extend gets applied to the values after a 'uzp1' of two
;; registers, so it doesn't get folded away. Same for any other vector-of-pointers
;; style gathers which don't fit in an <n x 2 x type*> single register. Better folding
;; is required before we can check those off.
define <n x 4 x i32> @masked_sgather_nxv4i8(<n x 4 x i8*> %ptrs, <n x 4 x i1> %mask) {
; CHECK-LABEL: masked_sgather_nxv4i8:
  %vals = call <n x 4 x i8> @llvm.masked.gather.nxv4i8(<n x 4 x i8*> %ptrs, i32 1, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  %svals = sext <n x 4 x i8> %vals to <n x 4 x i32>
  ret <n x 4 x i32> %svals
}

declare <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*>, i32, <n x 2 x i1>, <n x 2 x i8>)
declare <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*>, i32, <n x 2 x i1>, <n x 2 x i16>)
declare <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*>, i32, <n x 2 x i1>, <n x 2 x i32>)

declare <n x 4 x i8> @llvm.masked.gather.nxv4i8(<n x 4 x i8*>, i32, <n x 4 x i1>, <n x 4 x i8>)

declare <n x 16 x i8> @llvm.masked.gather.nxv16i8(<n x 16 x i8*>, i32, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 32 x i32> @llvm.masked.gather.nxv32i32(<n x 32 x i32*>, i32, <n x 32 x i1>, <n x 32 x i32>)
