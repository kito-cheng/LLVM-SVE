; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

; Tests that exercise various type legalisation scenarios for ISD::MSCATTER.

; Code generate store of an illegal datatype via promotion.
define void @masked_scatter_nxv2i8(<n x 2 x i8> %data, i8* %base, <n x 2 x i8*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv2i8:
; CHECK: st1b  {z0.d}, p0, [z1.d]
; CHECK: ret
  call void @llvm.masked.scatter.nxv2i8(<n x 2 x i8> %data, <n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask)
  ret void
}

; Code generate store of an illegal datatype via promotion.
define void @masked_scatter_nxv2i16(<n x 2 x i16> %data, i16* %base, <n x 2 x i16*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv2i16:
; CHECK: st1h {z0.d}, p0, [z1.d]
; CHECK: ret
  call void @llvm.masked.scatter.nxv2i16(<n x 2 x i16> %data, <n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask)
  ret void
}

; Code generate store of an illegal datatype via promotion.
define void @masked_scatter_nxv2i32(<n x 2 x i32> %data, i32* %base, <n x 2 x i32*> %ptrs, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv2i32:
; CHECK: st1w {z0.d}, p0, [z1.d]
; CHECK: ret
  call void @llvm.masked.scatter.nxv2i32(<n x 2 x i32> %data, <n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

; Code generate the worst case scenario when all vector types are legal.
define void @masked_scatter_nxv16i8(<n x 16 x i8> %data, i8* %base, <n x 16 x i8> %offsets, <n x 16 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv16i8:
; CHECK-DAG: st1b {{{z[0-9]+}}.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: st1b {{{z[0-9]+}}.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: st1b {{{z[0-9]+}}.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK-DAG: st1b {{{z[0-9]+}}.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw]
; CHECK: ret
  %ptrs = getelementptr i8, i8* %base, <n x 16 x i8> %offsets
  call void @llvm.masked.scatter.nxv16i8(<n x 16 x i8> %data, <n x 16 x i8*> %ptrs, i32 1, <n x 16 x i1> %mask)
  ret void
}

; Code generate the worst case scenario when all vector types are illegal.
define void @masked_scatter_nxv32i32(<n x 32 x i32> %data, i32* %base, <n x 32 x i32> %offsets, <n x 32 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv32i32:
; CHECK-NOT: unpkhi
; CHECK-DAG: st1w {z0.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z1.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z2.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z3.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z4.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z5.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z6.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK-DAG: st1w {z7.s}, {{p[0-9]+}}, [x0, {{z[0-9]+}}.s, sxtw #2]
; CHECK: ret
  %ptrs = getelementptr i32, i32* %base, <n x 32 x i32> %offsets
  call void @llvm.masked.scatter.nxv32i32(<n x 32 x i32> %data, <n x 32 x i32*> %ptrs, i32 4, <n x 32 x i1> %mask)
  ret void
}

declare void @llvm.masked.scatter.nxv2i8(<n x 2 x i8>, <n x 2 x i8*>,  i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2i16(<n x 2 x i16>, <n x 2 x i16*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2i32(<n x 2 x i32>, <n x 2 x i32*>, i32, <n x 2 x i1>)

declare void @llvm.masked.scatter.nxv16i8(<n x 16 x i8>, <n x 16 x i8*>,  i32, <n x 16 x i1>)
declare void @llvm.masked.scatter.nxv32i32(<n x 32 x i32>, <n x 32 x i32*>,  i32, <n x 32 x i1>)
