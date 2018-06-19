; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck -check-prefix=CONTIG-CHECK %s
; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -aarch64-sve-sg-to-contiguous-xform=false < %s | FileCheck -check-prefix=NONCONTIG-CHECK %s

;; This tests the transform of gathers and scatters with a fixed stride of 2 into contiguous
;; loads and stores with zips/uzps to mask out lanes.

define <n x 4 x i32> @gather_stride2_s(i32* %addr, <n x 4 x i1> %mask) {
; CONTIG-CHECK-LABEL: gather_stride2_s:
; CONTIG-CHECK: pfalse [[PF:p[0-9]+]].b
; CONTIG-CHECK: zip1 [[PREDL:p[0-9]+]].s, p0.s, [[PF]].s
; CONTIG-CHECK: zip2 [[PREDH:p[0-9]+]].s, p0.s, [[PF]].s
; CONTIG-CHECK-DAG: ld1w {[[DATAL:z[0-9]+]].s}, [[PREDL]]/z, [x0]
; CONTIG-CHECK-DAG: ld1w {[[DATAH:z[0-9]+]].s}, [[PREDH]]/z, [x0, #1, mul vl]
; CONTIG-CHECK: uzp1 z0.s, [[DATAL]].s, [[DATAH]].s
; CONTIG-CHECK: ret
; NONCONTIG-CHECK-LABEL: gather_stride2_s:
; NONCONTIG-CHECK: index z0.s, #0, #2
; NONCONTIG-CHECK: ld1w {z0.s}, p0/z, [x0, z0.s, sxtw #2]
; NONCONTIG-CHECK: ret
  %1 = insertelement <n x 4 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %indices = add <n x 4 x i32> %5, %3
  %ptrs = getelementptr i32, i32* %addr, <n x 4 x i32> %indices
  %vals = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %ptrs, i32 4, <n x 4 x i1> %mask, <n x 4 x i32> undef)
  ret <n x 4 x i32> %vals
}

define <n x 2 x i64> @gather_stride2_d(i64* %addr, <n x 2 x i1> %mask) {
; CONTIG-CHECK-LABEL: gather_stride2_d:
; CONTIG-CHECK: pfalse [[PF:p[0-9]+]].b
; CONTIG-CHECK: zip1 [[PREDL:p[0-9]+]].d, p0.d, [[PF]].d
; CONTIG-CHECK: zip2 [[PREDH:p[0-9]+]].d, p0.d, [[PF]].d
; CONTIG-CHECK-DAG: ld1d {[[DATAL:z[0-9]+]].d}, [[PREDL]]/z, [x0]
; CONTIG-CHECK-DAG: ld1d {[[DATAH:z[0-9]+]].d}, [[PREDH]]/z, [x0, #1, mul vl]
; CONTIG-CHECK: uzp1 z0.d, [[DATAL]].d, [[DATAH]].d
; CONTIG-CHECK: ret
; NONCONTIG-CHECK-LABEL: gather_stride2_d:
; NONCONTIG-CHECK: index z0.d, #0, #2
; NONCONTIG-CHECK: ld1d {z0.d}, p0/z, [x0, z0.d, lsl #3]
; NONCONTIG-CHECK: ret
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %indices = add <n x 2 x i64> %5, %3
  %ptrs = getelementptr i64, i64* %addr, <n x 2 x i64> %indices
  %vals = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  ret <n x 2 x i64> %vals
}

define void @scatter_stride2_s(i32* %addr, <n x 4 x i32> %data, <n x 4 x i1> %mask) {
; CONTIG-CHECK-LABEL: scatter_stride2_s:
; CONTIG-CHECK: pfalse [[PF:p[0-9]+]].b
; CONTIG-CHECK-DAG: zip1 [[DATAL:z[0-9]+]].s, z0.s, z0.s
; CONTIG-CHECK-DAG: zip2 [[DATAH:z[0-9]+]].s, z0.s, z0.s
; CONTIG-CHECK-DAG: zip1 [[PREDL:p[0-9]+]].s, p0.s, [[PF]].s
; CONTIG-CHECK-DAG: zip2 [[PREDH:p[0-9]+]].s, p0.s, [[PF]].s
; CONTIG-CHECK: st1w {[[DATAL]].s}, [[PREDL]], [x0]
; CONTIG-CHECK: st1w {[[DATAH]].s}, [[PREDH]], [x0, #1, mul vl]
; CONTIG-CHECK: ret
; NONCONTIG-CHECK-LABEL: scatter_stride2_s:
; NONCONTIG-CHECK: index z1.s, #0, #2
; NONCONTIG-CHECK: st1w {z0.s}, p0, [x0, z1.s, sxtw #2]
; NONCONTIG-CHECK: ret
  %1 = insertelement <n x 4 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %indices = add <n x 4 x i32> %5, %3
  %ptrs = getelementptr i32, i32* %addr, <n x 4 x i32> %indices
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %data, <n x 4 x i32*> %ptrs, i32 4, <n x 4 x i1> %mask)
  ret void
}

define void @scatter_stride2_d(i64* %addr, <n x 2 x i64> %data, <n x 2 x i1> %mask) {
; CONTIG-CHECK-LABEL: scatter_stride2_d:
; CONTIG-CHECK: pfalse [[PF:p[0-9]+]].b
; CONTIG-CHECK-DAG: zip1 [[DATAL:z[0-9]+]].d, z0.d, z0.d
; CONTIG-CHECK-DAG: zip2 [[DATAH:z[0-9]+]].d, z0.d, z0.d
; CONTIG-CHECK-DAG: zip1 [[PREDL:p[0-9]+]].d, p0.d, [[PF]].d
; CONTIG-CHECK-DAG: zip2 [[PREDH:p[0-9]+]].d, p0.d, [[PF]].d
; CONTIG-CHECK: st1d {[[DATAL]].d}, [[PREDL]], [x0]
; CONTIG-CHECK: st1d {[[DATAH]].d}, [[PREDH]], [x0, #1, mul vl]
; CONTIG-CHECK: ret
; NONCONTIG-CHECK-LABEL: scatter_stride2_d:
; NONCONTIG-CHECK: index z1.d, #0, #2
; NONCONTIG-CHECK: st1d {z0.d}, p0, [x0, z1.d, lsl #3]
; NONCONTIG-CHECK: ret
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %indices = add <n x 2 x i64> %5, %3
  %ptrs = getelementptr i64, i64* %addr, <n x 2 x i64> %indices
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %data, <n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

; Function Attrs: nounwind readonly
declare <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*>, i32, <n x 4 x i1>, <n x 4 x i32>) #0

; Function Attrs: nounwind readonly
declare <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*>, i32, <n x 2 x i1>, <n x 2 x i64>) #0

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32>, <n x 4 x i32*>, i32, <n x 4 x i1>) #1

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64>, <n x 2 x i64*>, i32, <n x 2 x i1>) #1

attributes #0 = { nounwind readonly }
attributes #1 = { nounwind }
