; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -asm-verbose=0 < %s | FileCheck %s

declare void @llvm.masked.scatter.v2i8( <2 x i8>,     <2 x i8*>,     i32, <2 x i1>)
declare void @llvm.masked.scatter.v2i16(<2 x i16>,    <2 x i16*>,    i32, <2 x i1>)
declare void @llvm.masked.scatter.v2i32(<2 x i32>,    <2 x i32*>,    i32, <2 x i1>)
declare void @llvm.masked.scatter.v2i64(<2 x i64>,    <2 x i64*>,    i32, <2 x i1>)
declare void @llvm.masked.scatter.v2f32(<2 x float>,  <2 x float*>,  i32, <2 x i1>)
declare void @llvm.masked.scatter.v2f64(<2 x double>, <2 x double*>, i32, <2 x i1>)

declare void @llvm.masked.scatter.v4i8( <4 x i8>,    <4 x i8*>,    i32, <4 x i1>)
declare void @llvm.masked.scatter.v4i16(<4 x i16>,   <4 x i16*>,   i32, <4 x i1>)
declare void @llvm.masked.scatter.v4i32(<4 x i32>,   <4 x i32*>,   i32, <4 x i1>)
declare void @llvm.masked.scatter.v4f32(<4 x float>, <4 x float*>, i32, <4 x i1>)

define void @masked_scatter_v2i8(<2 x i8> %data, <2 x i8*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_v2i8:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK-DAG: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-DAG: ushll v[[DATA:[0-9]+]].2d, v0.2s, #0
; CHECK-NEXT: st1b {z[[DATA]].d}, [[MASK]], [z1.d]
; CHECK-NEXT: ret
  call void @llvm.masked.scatter.v2i8(<2 x i8> %data, <2 x i8*> %ptrs, i32 1, <2 x i1> %mask)
  ret void
}

define void @masked_scatter_v2i16(<2 x i16> %data, <2 x i16*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_v2i16:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK-DAG: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-DAG: ushll v[[DATA:[0-9]+]].2d, v0.2s, #0
; CHECK-NEXT: st1h {z[[DATA]].d}, [[MASK]], [z1.d]
; CHECK-NEXT: ret
  call void @llvm.masked.scatter.v2i16(<2 x i16> %data, <2 x i16*> %ptrs, i32 2, <2 x i1> %mask)
  ret void
}

define void @masked_scatter_v2i32(<2 x i32> %data, <2 x i32*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_v2i32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK-DAG: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-DAG: ushll v[[DATA:[0-9]+]].2d, v0.2s, #0
; CHECK-NEXT: st1w {z[[DATA]].d}, [[MASK]], [z1.d]
; CHECK-NEXT: ret
  call void @llvm.masked.scatter.v2i32(<2 x i32> %data, <2 x i32*> %ptrs, i32 4, <2 x i1> %mask)
  ret void
}

define void @masked_scatter_v2i64(<2 x i64> %data, <2 x i64*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_v2i64:
; CHECK: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-NEXT: st1d {z0.d}, [[MASK]], [z1.d]
; CHECK-NEXT: ret
  call void @llvm.masked.scatter.v2i64(<2 x i64> %data, <2 x i64*> %ptrs, i32 8, <2 x i1> %mask)
  ret void
}

define void @masked_scatter_v2f32(<2 x float> %data, <2 x float*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_v2f32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK-DAG: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-DAG: ushll v[[DATA:[0-9]+]].2d, v0.2s, #0
; CHECK-NEXT: st1w {z[[DATA]].d}, [[MASK]], [z1.d]
; CHECK-NEXT: ret
  call void @llvm.masked.scatter.v2f32(<2 x float> %data, <2 x float*> %ptrs, i32 4, <2 x i1> %mask)
  ret void
}

define void @masked_scatter_v2f64(<2 x double> %data, <2 x double*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_scatter_v2f64:
; CHECK: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-NEXT: st1d {z0.d}, [[MASK]], [z1.d]
; CHECK-NEXT: ret
  call void @llvm.masked.scatter.v2f64(<2 x double> %data, <2 x double*> %ptrs, i32 8, <2 x i1> %mask)
  ret void
}

define void @masked_scatter_v4i8(<4 x i8> %data, i8* %base, <4 x i32> %idxs, <4 x i1> %mask) {
; CHECK-LABEL: masked_scatter_v4i8:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s, vl4
; CHECK-DAG: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-DAG: ushll v[[DATA:[0-9]+]].4s, v0.4h, #0
; CHECK-NEXT: st1b {z[[DATA]].s}, [[MASK]], [x0, z1.s, sxtw]
; CHECK-NEXT: ret
  %ptrs = getelementptr i8, i8* %base, <4 x i32> %idxs
  call void @llvm.masked.scatter.v4i8(<4 x i8> %data, <4 x i8*> %ptrs, i32 1, <4 x i1> %mask)
  ret void
}

define void @masked_scatter_v4i16(<4 x i16> %data, i16* %base, <4 x i32> %idxs, <4 x i1> %mask) {
; CHECK-LABEL: masked_scatter_v4i16:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s, vl4
; CHECK-DAG: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-DAG: ushll v[[DATA:[0-9]+]].4s, v0.4h, #0
; CHECK-NEXT: st1h {z[[DATA]].s}, [[MASK]], [x0, z1.s, sxtw #1]
; CHECK-NEXT: ret
  %ptrs = getelementptr i16, i16* %base, <4 x i32> %idxs
  call void @llvm.masked.scatter.v4i16(<4 x i16> %data, <4 x i16*> %ptrs, i32 2, <4 x i1> %mask)
  ret void
}

define void @masked_scatter_v4i32(<4 x i32> %data, i32* %base, <4 x i32> %idxs, <4 x i1> %mask) {
; CHECK-LABEL: masked_scatter_v4i32:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl4
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: st1w {z0.s}, [[MASK]], [x0, z1.s, sxtw #2]
; CHECK-NEXT: ret
  %ptrs = getelementptr i32, i32* %base, <4 x i32> %idxs
  call void @llvm.masked.scatter.v4i32(<4 x i32> %data, <4 x i32*> %ptrs, i32 4, <4 x i1> %mask)
  ret void
}

define void @masked_scatter_v4f32(<4 x float> %data, float* %base, <4 x i32> %idxs, <4 x i1> %mask) {
; CHECK-LABEL: masked_scatter_v4f32:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl4
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: st1w {z0.s}, [[MASK]], [x0, z1.s, sxtw #2]
; CHECK-NEXT: ret
  %ptrs = getelementptr float, float* %base, <4 x i32> %idxs
  call void @llvm.masked.scatter.v4f32(<4 x float> %data, <4 x float*> %ptrs, i32 4, <4 x i1> %mask)
  ret void
}
