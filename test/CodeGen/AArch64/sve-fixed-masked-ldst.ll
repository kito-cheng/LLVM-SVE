; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

;; Masked Loads & Stores - 2xT

declare <2 x i8>     @llvm.masked.load.v2i8( <2 x i8>*,     i32, <2 x i1>, <2 x i8>)
declare <2 x i16>    @llvm.masked.load.v2i16(<2 x i16>*,    i32, <2 x i1>, <2 x i16>)
declare <2 x i32>    @llvm.masked.load.v2i32(<2 x i32>*,    i32, <2 x i1>, <2 x i32>)
declare <2 x i64>    @llvm.masked.load.v2i64(<2 x i64>*,    i32, <2 x i1>, <2 x i64>)
declare <2 x float>  @llvm.masked.load.v2f32(<2 x float>*,  i32, <2 x i1>, <2 x float>)
declare <2 x double> @llvm.masked.load.v2f64(<2 x double>*, i32, <2 x i1>, <2 x double>)

declare void @llvm.masked.store.v2i8( <2 x i8>,     <2 x i8>*,     i32, <2 x i1>)
declare void @llvm.masked.store.v2i16(<2 x i16>,    <2 x i16>*,    i32, <2 x i1>)
declare void @llvm.masked.store.v2i32(<2 x i32>,    <2 x i32>*,    i32, <2 x i1>)
declare void @llvm.masked.store.v2i64(<2 x i64>,    <2 x i64>*,    i32, <2 x i1>)
declare void @llvm.masked.store.v2f32(<2 x float>,  <2 x float>*,  i32, <2 x i1>)
declare void @llvm.masked.store.v2f64(<2 x double>, <2 x double>*, i32, <2 x i1>)

define void @masked_load_store_v2i8(<2 x i8> *%a, <2 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v2i8:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: ld1sb {z[[IN:[0-9]+]].s}, [[MASK]]/z, [x0]
; CHECK-NEXT: add v[[OUT:[0-9]+]].2s, v[[IN]].2s, v[[IN]].2s
; CHECK-NEXT: st1b {z[[OUT]].s}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <2 x i8> @llvm.masked.load.v2i8(<2 x i8> *%a, i32 1, <2 x i1> %mask, <2 x i8> undef)
  %out_vals = add <2 x i8> %in_vals, %in_vals
  call void @llvm.masked.store.v2i8(<2 x i8> %out_vals, <2 x i8> *%a, i32 1, <2 x i1> %mask)
  ret void
}

define void @masked_load_store_v2i16(<2 x i16> *%a, <2 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v2i16:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: ld1sh {z[[IN:[0-9]+]].s}, [[MASK]]/z, [x0]
; CHECK-NEXT: add v[[OUT:[0-9]+]].2s, v[[IN]].2s, v[[IN]].2s
; CHECK-NEXT: st1h {z[[OUT]].s}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <2 x i16> @llvm.masked.load.v2i16(<2 x i16> *%a, i32 2, <2 x i1> %mask, <2 x i16> undef)
  %out_vals = add <2 x i16> %in_vals, %in_vals
  call void @llvm.masked.store.v2i16(<2 x i16> %out_vals, <2 x i16> *%a, i32 2, <2 x i1> %mask)
  ret void
}

define void @masked_load_store_v2i32(<2 x i32> *%a, <2 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v2i32:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: ld1w {z[[IN:[0-9]+]].s}, [[MASK]]/z, [x0]
; CHECK-NEXT: add v[[OUT:[0-9]+]].2s, v[[IN]].2s, v[[IN]].2s
; CHECK-NEXT: st1w {z[[OUT]].s}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <2 x i32> @llvm.masked.load.v2i32(<2 x i32> *%a, i32 4, <2 x i1> %mask, <2 x i32> undef)
  %out_vals = add <2 x i32> %in_vals, %in_vals
  call void @llvm.masked.store.v2i32(<2 x i32> %out_vals, <2 x i32> *%a, i32 4, <2 x i1> %mask)
  ret void
}

define void @masked_load_store_v2i64(<2 x i64> *%a, <2 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v2i64:
; CHECK: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-NEXT: ld1d {z[[IN:[0-9]+]].d}, [[MASK]]/z, [x0]
; CHECK-NEXT: add v[[OUT:[0-9]+]].2d, v[[IN]].2d, v[[IN]].2d
; CHECK-NEXT: st1d {z[[OUT]].d}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <2 x i64> @llvm.masked.load.v2i64(<2 x i64> *%a, i32 8, <2 x i1> %mask, <2 x i64> undef)
  %out_vals = add <2 x i64> %in_vals, %in_vals
  call void @llvm.masked.store.v2i64(<2 x i64> %out_vals, <2 x i64> *%a, i32 8, <2 x i1> %mask)
  ret void
}

define void @masked_load_store_v2f32(<2 x float> *%a, <2 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v2f32:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: ld1w {z[[IN:[0-9]+]].s}, [[MASK]]/z, [x0]
; CHECK-NEXT: fadd v[[OUT:[0-9]+]].2s, v[[IN]].2s, v[[IN]].2s
; CHECK-NEXT: st1w {z[[OUT]].s}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <2 x float> @llvm.masked.load.v2f32(<2 x float> *%a, i32 4, <2 x i1> %mask, <2 x float> undef)
  %out_vals = fadd <2 x float> %in_vals, %in_vals
  call void @llvm.masked.store.v2f32(<2 x float> %out_vals, <2 x float> *%a, i32 4, <2 x i1> %mask)
  ret void
}

define void @masked_load_store_v2f64(<2 x double> *%a, <2 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v2f64:
; CHECK: ptrue [[PG:p[0-9]+]].d, vl2
; CHECK: cmpne [[MASK:p[0-9]+]].d, [[PG]]/z, {{z[0-9]+}}.d, #0
; CHECK-NEXT: ld1d {z[[IN:[0-9]+]].d}, [[MASK]]/z, [x0]
; CHECK-NEXT: fadd v[[OUT:[0-9]+]].2d, v[[IN]].2d, v[[IN]].2d
; CHECK-NEXT: st1d {z[[OUT]].d}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <2 x double> @llvm.masked.load.v2f64(<2 x double> *%a, i32 8, <2 x i1> %mask, <2 x double> undef)
  %out_vals = fadd <2 x double> %in_vals, %in_vals
  call void @llvm.masked.store.v2f64(<2 x double> %out_vals, <2 x double> *%a, i32 8, <2 x i1> %mask)
  ret void
}

;; Masked Loads & Stores - 4xT

declare <4 x i8>    @llvm.masked.load.v4i8( <4 x i8>*,    i32, <4 x i1>, <4 x i8>)
declare <4 x i16>   @llvm.masked.load.v4i16(<4 x i16>*,   i32, <4 x i1>, <4 x i16>)
declare <4 x i32>   @llvm.masked.load.v4i32(<4 x i32>*,   i32, <4 x i1>, <4 x i32>)
declare <4 x float> @llvm.masked.load.v4f32(<4 x float>*, i32, <4 x i1>, <4 x float>)

declare void @llvm.masked.store.v4i8( <4 x i8>,    <4 x i8>*,    i32, <4 x i1>)
declare void @llvm.masked.store.v4i16(<4 x i16>,   <4 x i16>*,   i32, <4 x i1>)
declare void @llvm.masked.store.v4i32(<4 x i32>,   <4 x i32>*,   i32, <4 x i1>)
declare void @llvm.masked.store.v4f32(<4 x float>, <4 x float>*, i32, <4 x i1>)

define void @masked_load_store_v4i8(<4 x i8> *%a, <4 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v4i8:
; CHECK: ptrue [[PG:p[0-9]+]].h, vl4
; CHECK: cmpne [[MASK:p[0-9]+]].h, [[PG]]/z, {{z[0-9]+}}.h, #0
; CHECK-NEXT: ld1sb {z[[IN:[0-9]+]].h}, [[MASK]]/z, [x0]
; CHECK-NEXT: add v[[OUT:[0-9]+]].4h, v[[IN]].4h, v[[IN]].4h
; CHECK-NEXT: st1b {z[[OUT]].h}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <4 x i8> @llvm.masked.load.v4i8(<4 x i8> *%a, i32 4, <4 x i1> %mask, <4 x i8> undef)
  %out_vals = add <4 x i8> %in_vals, %in_vals
  call void @llvm.masked.store.v4i8(<4 x i8> %out_vals, <4 x i8> *%a, i32 1, <4 x i1> %mask)
  ret void
}

define void @masked_load_store_v4i16(<4 x i16> *%a, <4 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v4i16:
; CHECK: ptrue [[PG:p[0-9]+]].h, vl4
; CHECK: cmpne [[MASK:p[0-9]+]].h, [[PG]]/z, {{z[0-9]+}}.h, #0
; CHECK-NEXT: ld1h {z[[IN:[0-9]+]].h}, [[MASK]]/z, [x0]
; CHECK-NEXT: add v[[OUT:[0-9]+]].4h, v[[IN]].4h, v[[IN]].4h
; CHECK-NEXT: st1h {z[[OUT]].h}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <4 x i16> @llvm.masked.load.v4i16(<4 x i16> *%a, i32 4, <4 x i1> %mask, <4 x i16> undef)
  %out_vals = add <4 x i16> %in_vals, %in_vals
  call void @llvm.masked.store.v4i16(<4 x i16> %out_vals, <4 x i16> *%a, i32 2, <4 x i1> %mask)
  ret void
}

define void @masked_load_store_v4i32(<4 x i32> *%a, <4 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v4i32:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl4
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: ld1w {z[[IN:[0-9]+]].s}, [[MASK]]/z, [x0]
; CHECK-NEXT: add v[[OUT:[0-9]+]].4s, v[[IN]].4s, v[[IN]].4s
; CHECK-NEXT: st1w {z[[OUT]].s}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <4 x i32> @llvm.masked.load.v4i32(<4 x i32> *%a, i32 4, <4 x i1> %mask, <4 x i32> undef)
  %out_vals = add <4 x i32> %in_vals, %in_vals
  call void @llvm.masked.store.v4i32(<4 x i32> %out_vals, <4 x i32> *%a, i32 4, <4 x i1> %mask)
  ret void
}

define void @masked_load_store_v4f32(<4 x float> *%a, <4 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v4f32:
; CHECK: ptrue [[PG:p[0-9]+]].s, vl4
; CHECK: cmpne [[MASK:p[0-9]+]].s, [[PG]]/z, {{z[0-9]+}}.s, #0
; CHECK-NEXT: ld1w {z[[IN:[0-9]+]].s}, [[MASK]]/z, [x0]
; CHECK-NEXT: fadd v[[OUT:[0-9]+]].4s, v[[IN]].4s, v[[IN]].4s
; CHECK-NEXT: st1w {z[[OUT]].s}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <4 x float> @llvm.masked.load.v4f32(<4 x float> *%a, i32 4, <4 x i1> %mask, <4 x float> undef)
  %out_vals = fadd <4 x float> %in_vals, %in_vals
  call void @llvm.masked.store.v4f32(<4 x float> %out_vals, <4 x float> *%a, i32 4, <4 x i1> %mask)
  ret void
}

;; Masked Loads & Stores - 8xT

declare <8 x i8>  @llvm.masked.load.v8i8( <8 x i8>*,  i32, <8 x i1>, <8 x i8>)
declare <8 x i16> @llvm.masked.load.v8i16(<8 x i16>*, i32, <8 x i1>, <8 x i16>)

declare void @llvm.masked.store.v8i8 (<8 x i8>,  <8 x i8>*,  i32, <8 x i1>)
declare void @llvm.masked.store.v8i16(<8 x i16>, <8 x i16>*, i32, <8 x i1>)

define void @masked_load_store_v8i8(<8 x i8> *%a, <8 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v8i8:
; CHECK: ptrue [[PG:p[0-9]+]].b, vl8
; CHECK: cmpne [[MASK:p[0-9]+]].b, [[PG]]/z, {{z[0-9]+}}.b, #0
; CHECK-NEXT: ld1b {z[[IN:[0-9]+]].b}, [[MASK]]/z, [x0]
; CHECK-NEXT: add v[[OUT:[0-9]+]].8b, v[[IN]].8b, v[[IN]].8b
; CHECK-NEXT: st1b {z[[OUT]].b}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <8 x i8> @llvm.masked.load.v8i8(<8 x i8> *%a, i32 2, <8 x i1> %mask, <8 x i8> undef)
  %out_vals = add <8 x i8> %in_vals, %in_vals
  call void @llvm.masked.store.v8i8(<8 x i8> %out_vals, <8 x i8> *%a, i32 1, <8 x i1> %mask)
  ret void
}

define void @masked_load_store_v8i16(<8 x i16> *%a, <8 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v8i16:
; CHECK: ptrue [[PG:p[0-9]+]].h, vl8
; CHECK: cmpne [[MASK:p[0-9]+]].h, [[PG]]/z, {{z[0-9]+}}.h, #0
; CHECK-NEXT: ld1h {z[[IN:[0-9]+]].h}, [[MASK]]/z, [x0]
; CHECK-NEXT: add v[[OUT:[0-9]+]].8h, v[[IN]].8h, v[[IN]].8h
; CHECK-NEXT: st1h {z[[OUT]].h}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <8 x i16> @llvm.masked.load.v8i16(<8 x i16> *%a, i32 2, <8 x i1> %mask, <8 x i16> undef)
  %out_vals = add <8 x i16> %in_vals, %in_vals
  call void @llvm.masked.store.v8i16(<8 x i16> %out_vals, <8 x i16> *%a, i32 2, <8 x i1> %mask)
  ret void
}

;; Masked Loads & Stores - 16xT

declare <16 x i8> @llvm.masked.load.v16i8(<16 x i8>*, i32, <16 x i1>, <16 x i8>)

declare void @llvm.masked.store.v16i8(<16 x i8>, <16 x i8>*, i32, <16 x i1>)

define void @masked_load_store_v16i8(<16 x i8> *%a, <16 x i1> %mask) {
; CHECK-LABEL: masked_load_store_v16i8:
; CHECK: ptrue [[PG:p[0-9]+]].b, vl16
; CHECK: cmpne [[MASK:p[0-9]+]].b, [[PG]]/z, {{z[0-9]+}}.b, #0
; CHECK-NEXT: ld1b {z[[IN:[0-9]+]].b}, [[MASK]]/z, [x0]
; CHECK-NEXT: add v[[OUT:[0-9]+]].16b, v[[IN]].16b, v[[IN]].16b
; CHECK-NEXT: st1b {z[[OUT]].b}, [[MASK]], [x0]
; CHECK-NEXT: ret
  %in_vals = call <16 x i8> @llvm.masked.load.v16i8(<16 x i8> *%a, i32 1, <16 x i1> %mask, <16 x i8> undef)
  %out_vals = add <16 x i8> %in_vals, %in_vals
  call void @llvm.masked.store.v16i8(<16 x i8> %out_vals, <16 x i8> *%a, i32 1, <16 x i1> %mask)
  ret void
}
