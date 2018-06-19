; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

; UNPACKED OFFSETS

define void @masked_scatter_nxv2i16(<n x 2 x i16> %data, i16* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv2i16:
; CHECK: st1h {z0.d}, p0, [x0, z1.d, uxtw #1]
; CHECK-NEXT: ret
  %offsets.zext = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr i16, i16* %base, <n x 2 x i64> %offsets.zext
  call void @llvm.masked.scatter.nxv2i16(<n x 2 x i16> %data, <n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv2i32(<n x 2 x i32> %data, i32* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv2i32:
; CHECK: st1w {z0.d}, p0, [x0, z1.d, uxtw #2]
; CHECK-NEXT: ret
  %offsets.zext = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr i32, i32* %base, <n x 2 x i64> %offsets.zext
  call void @llvm.masked.scatter.nxv2i32(<n x 2 x i32> %data, <n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv2i64(<n x 2 x i64> %data, i64* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv2i64:
; CHECK: st1d {z0.d}, p0, [x0, z1.d, uxtw #3]
; CHECK-NEXT: ret
  %offsets.zext = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr i64, i64* %base, <n x 2 x i64> %offsets.zext
  call void @llvm.masked.scatter.nxv2i64(<n x 2 x i64> %data, <n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv2f16(<n x 2 x half> %data, half* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv2f16:
; CHECK: st1h {z0.d}, p0, [x0, z1.d, uxtw #1]
; CHECK-NEXT: ret
  %offsets.zext = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr half, half* %base, <n x 2 x i64> %offsets.zext
  call void @llvm.masked.scatter.nxv2f16(<n x 2 x half> %data, <n x 2 x half*> %ptrs, i32 2, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv2f32(<n x 2 x float> %data, float* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv2f32:
; CHECK: st1w {z0.d}, p0, [x0, z1.d, uxtw #2]
; CHECK-NEXT: ret
  %offsets.zext = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr float, float* %base, <n x 2 x i64> %offsets.zext
  call void @llvm.masked.scatter.nxv2f32(<n x 2 x float> %data, <n x 2 x float*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv2f64(<n x 2 x double> %data, double* %base, <n x 2 x i32> %offsets, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv2f64:
; CHECK: st1d {z0.d}, p0, [x0, z1.d, uxtw #3]
; CHECK-NEXT: ret
  %offsets.zext = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  %ptrs = getelementptr double, double* %base, <n x 2 x i64> %offsets.zext
  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %data, <n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

; PACKED OFFSETS

define void @masked_scatter_nxv4i16(<n x 4 x i16> %data, i16* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv4i16:
; CHECK: st1h {z0.s}, p0, [x0, z1.s, uxtw #1]
; CHECK-NEXT: ret
  %offsets.zext = zext <n x 4 x i32> %offsets to <n x 4 x i64>
  %ptrs = getelementptr i16, i16* %base, <n x 4 x i64> %offsets.zext
  call void @llvm.masked.scatter.nxv4i16(<n x 4 x i16> %data, <n x 4 x i16*> %ptrs, i32 2, <n x 4 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv4i32(<n x 4 x i32> %data, i32* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv4i32:
; CHECK: st1w {z0.s}, p0, [x0, z1.s, uxtw #2]
; CHECK-NEXT: ret
  %offsets.zext = zext <n x 4 x i32> %offsets to <n x 4 x i64>
  %ptrs = getelementptr i32, i32* %base, <n x 4 x i64> %offsets.zext
  call void @llvm.masked.scatter.nxv4i32(<n x 4 x i32> %data, <n x 4 x i32*> %ptrs, i32 4, <n x 4 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv4f16(<n x 4 x half> %data, half* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv4f16:
; CHECK: st1h {z0.s}, p0, [x0, z1.s, uxtw #1]
; CHECK-NEXT: ret
  %offsets.zext = zext <n x 4 x i32> %offsets to <n x 4 x i64>
  %ptrs = getelementptr half, half* %base, <n x 4 x i64> %offsets.zext
  call void @llvm.masked.scatter.nxv4f16(<n x 4 x half> %data, <n x 4 x half*> %ptrs, i32 2, <n x 4 x i1> %mask)
  ret void
}

define void @masked_scatter_nxv4f32(<n x 4 x float> %data, float* %base, <n x 4 x i32> %offsets, <n x 4 x i1> %mask) {
; CHECK-LABEL: masked_scatter_nxv4f32:
; CHECK: st1w {z0.s}, p0, [x0, z1.s, uxtw #2]
; CHECK-NEXT: ret
  %offsets.zext = zext <n x 4 x i32> %offsets to <n x 4 x i64>
  %ptrs = getelementptr float, float* %base, <n x 4 x i64> %offsets.zext
  call void @llvm.masked.scatter.nxv4f32(<n x 4 x float> %data, <n x 4 x float*> %ptrs, i32 4, <n x 4 x i1> %mask)
  ret void
}

declare void @llvm.masked.scatter.nxv2i16(<n x 2 x i16>, <n x 2 x i16*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2i32(<n x 2 x i32>, <n x 2 x i32*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2i64(<n x 2 x i64>, <n x 2 x i64*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2f16(<n x 2 x half>, <n x 2 x half*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2f32(<n x 2 x float>, <n x 2 x float*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2f64(<n x 2 x double>, <n x 2 x double*>, i32, <n x 2 x i1>)

declare void @llvm.masked.scatter.nxv4i16(<n x 4 x i16>, <n x 4 x i16*>, i32, <n x 4 x i1>)
declare void @llvm.masked.scatter.nxv4i32(<n x 4 x i32>, <n x 4 x i32*>, i32, <n x 4 x i1>)
declare void @llvm.masked.scatter.nxv4f16(<n x 4 x half>, <n x 4 x half*>, i32, <n x 4 x i1>)
declare void @llvm.masked.scatter.nxv4f32(<n x 4 x float>, <n x 4 x float*>, i32, <n x 4 x i1>)
