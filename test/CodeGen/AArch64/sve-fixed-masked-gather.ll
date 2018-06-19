; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -asm-verbose=0 < %s | FileCheck %s

declare <2 x i8>     @llvm.masked.gather.v2i8( <2 x i8*>,     i32, <2 x i1>, <2 x i8>)
declare <2 x i16>    @llvm.masked.gather.v2i16(<2 x i16*>,    i32, <2 x i1>, <2 x i16>)
declare <2 x i32>    @llvm.masked.gather.v2i32(<2 x i32*>,    i32, <2 x i1>, <2 x i32>)
declare <2 x i64>    @llvm.masked.gather.v2i64(<2 x i64*>,    i32, <2 x i1>, <2 x i64>)
declare <2 x float>  @llvm.masked.gather.v2f32(<2 x float*>,  i32, <2 x i1>, <2 x float>)
declare <2 x double> @llvm.masked.gather.v2f64(<2 x double*>, i32, <2 x i1>, <2 x double>)

declare <4 x i8>    @llvm.masked.gather.v4i8( <4 x i8*>,    i32, <4 x i1>, <4 x i8>)
declare <4 x i16>   @llvm.masked.gather.v4i16(<4 x i16*>,   i32, <4 x i1>, <4 x i16>)
declare <4 x i32>   @llvm.masked.gather.v4i32(<4 x i32*>,   i32, <4 x i1>, <4 x i32>)
declare <4 x float> @llvm.masked.gather.v4f32(<4 x float*>, i32, <4 x i1>, <4 x float>)

define <2 x i8> @masked_gather_v2i8(<2 x i8*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_gather_v2i8:
; CHECK: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-NEXT: ld1sb {z[[DATA:[0-9]+]].d}, [[MASK]]/z, [z0.d]
; CHECK-NEXT: xtn v0.2s, v[[DATA]].2d
; CHECK-NEXT: ret
  %res = call <2 x i8> @llvm.masked.gather.v2i8(<2 x i8*> %ptrs, i32 1, <2 x i1> %mask, <2 x i8> undef)
  ret <2 x i8> %res
}

define <2 x i16> @masked_gather_v2i16(<2 x i16*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_gather_v2i16:
; CHECK: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-NEXT: ld1sh {z[[DATA:[0-9]+]].d}, [[MASK]]/z, [z0.d]
; CHECK-NEXT: xtn v0.2s, v[[DATA]].2d
; CHECK-NEXT: ret
  %res = call <2 x i16> @llvm.masked.gather.v2i16(<2 x i16*> %ptrs, i32 2, <2 x i1> %mask, <2 x i16> undef)
  ret <2 x i16> %res
}

define <2 x i32> @masked_gather_v2i32(<2 x i32*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_gather_v2i32:
; CHECK: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-NEXT: ld1sw {z[[DATA:[0-9]+]].d}, [[MASK]]/z, [z0.d]
; CHECK-NEXT: xtn v0.2s, v[[DATA]].2d
; CHECK-NEXT: ret
  %res = call <2 x i32> @llvm.masked.gather.v2i32(<2 x i32*> %ptrs, i32 4, <2 x i1> %mask, <2 x i32> undef)
  ret <2 x i32> %res
}

define <2 x i64> @masked_gather_v2i64(<2 x i64*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_gather_v2i64:
; CHECK: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-NEXT: ld1d {z0.d}, [[MASK]]/z, [z0.d]
; CHECK-NEXT: ret
  %res = call <2 x i64> @llvm.masked.gather.v2i64(<2 x i64*> %ptrs, i32 8, <2 x i1> %mask, <2 x i64> undef)
  ret <2 x i64> %res
}

define <2 x float> @masked_gather_v2f32(<2 x float*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_gather_v2f32:
; CHECK: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-NEXT: ld1sw {z[[DATA:[0-9]+]].d}, [[MASK]]/z, [z0.d]
; CHECK-NEXT: xtn v0.2s, v[[DATA]].2d
; CHECK-NEXT: ret
  %res = call <2 x float> @llvm.masked.gather.v2f32(<2 x float*> %ptrs, i32 4, <2 x i1> %mask, <2 x float> undef)
  ret <2 x float> %res
}

define <2 x double> @masked_gather_v2f64(<2 x double*> %ptrs, <2 x i1> %mask) {
; CHECK-LABEL: masked_gather_v2f64:
; CHECK: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-NEXT: ld1d {z0.d}, [[MASK]]/z, [z0.d]
; CHECK-NEXT: ret
  %res = call <2 x double> @llvm.masked.gather.v2f64(<2 x double*> %ptrs, i32 8, <2 x i1> %mask, <2 x double> undef)
  ret <2 x double> %res
}

define <4 x i8> @masked_gather_v4i8(i8* %base, <4 x i32> %idxs, <4 x i1> %mask) {
; CHECK-LABEL: masked_gather_v4i8:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl4
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: ld1sb {z[[DATA:[0-9]+]].s}, [[MASK]]/z, [x0, z0.s, sxtw]
; CHECK-NEXT: xtn v0.4h, v[[DATA]].4s
; CHECK-NEXT: ret
  %ptrs = getelementptr i8, i8* %base, <4 x i32> %idxs
  %res = call <4 x i8> @llvm.masked.gather.v4i8(<4 x i8*> %ptrs, i32 4, <4 x i1> %mask, <4 x i8> undef)
  ret <4 x i8> %res
}

define <4 x i16> @masked_gather_v4i16(i16* %base, <4 x i32> %idxs, <4 x i1> %mask) {
; CHECK-LABEL: masked_gather_v4i16:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl4
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: ld1sh {z[[DATA:[0-9]+]].s}, [[MASK]]/z, [x0, z0.s, sxtw #1]
; CHECK-NEXT: xtn v0.4h, v[[DATA]].4s
; CHECK-NEXT: ret
  %ptrs = getelementptr i16, i16* %base, <4 x i32> %idxs
  %res = call <4 x i16> @llvm.masked.gather.v4i16(<4 x i16*> %ptrs, i32 4, <4 x i1> %mask, <4 x i16> undef)
  ret <4 x i16> %res
}

define <4 x i32> @masked_gather_v4i32(i32* %base, <4 x i32> %idxs, <4 x i1> %mask) {
; CHECK-LABEL: masked_gather_v4i32:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl4
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: ld1w {z0.s}, [[MASK]]/z, [x0, z0.s, sxtw #2]
; CHECK-NEXT: ret
  %ptrs = getelementptr i32, i32* %base, <4 x i32> %idxs
  %res = call <4 x i32> @llvm.masked.gather.v4i32(<4 x i32*> %ptrs, i32 4, <4 x i1> %mask, <4 x i32> undef)
  ret <4 x i32> %res
}

define <4 x float> @masked_gather_v4f32(float* %base, <4 x i32> %idxs, <4 x i1> %mask) {
; CHECK-LABEL: masked_gather_v4f32:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl4
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: ld1w {z0.s}, [[MASK]]/z, [x0, z0.s, sxtw #2]
; CHECK-NEXT: ret
  %ptrs = getelementptr float, float* %base, <4 x i32> %idxs
  %res = call <4 x float> @llvm.masked.gather.v4f32(<4 x float*> %ptrs, i32 4, <4 x i1> %mask, <4 x float> undef)
  ret <4 x float> %res
}
