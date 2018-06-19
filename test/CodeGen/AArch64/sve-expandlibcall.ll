; RUN: llc -O2 -march=aarch64 -mattr=+sve -verify-machineinstrs < %s | FileCheck %s
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

%svint32x2_t = type { <n x 4 x i32>, <n x 4 x i32> }

; Function Attrs: nounwind
define <n x 2 x double> @coscall(<n x 2 x double> %a) {
; CHECK-LABEL: coscall
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb d0, [[PG]]
; CHECK: bl cos
  %res = call <n x 2 x double> @llvm.cos.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind
define <n x 2 x float> @coscallf(<n x 2 x float> %a) {
; CHECK-LABEL: coscallf
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb s0, [[PG]]
; CHECK: bl cosf
  %res = call <n x 2 x float> @llvm.cos.nxv2f32(<n x 2 x float> %a)
  ret <n x 2 x float> %res
}

; Function Attrs: nounwind
define <n x 2 x double> @expcall(<n x 2 x double> %a) {
; CHECK-LABEL: expcall
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb d0, [[PG]]
; CHECK: bl exp
  %res = call <n x 2 x double> @llvm.exp.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind
define <n x 2 x float> @expcallf(<n x 2 x float> %a) {
; CHECK-LABEL: expcallf
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb s0, [[PG]]
; CHECK: bl expf
  %res = call <n x 2 x float> @llvm.exp.nxv2f32(<n x 2 x float> %a)
  ret <n x 2 x float> %res
}

; Function Attrs: nounwind
define <n x 2 x double> @exp2call(<n x 2 x double> %a) {
; CHECK-LABEL: exp2call
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb d0, [[PG]]
; CHECK: bl exp2
  %res = call <n x 2 x double> @llvm.exp2.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind
define <n x 2 x float> @exp2callf(<n x 2 x float> %a) {
; CHECK-LABEL: exp2callf
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb s0, [[PG]]
; CHECK: bl exp2f
  %res = call <n x 2 x float> @llvm.exp2.nxv2f32(<n x 2 x float> %a)
  ret <n x 2 x float> %res
}

; Function Attrs: nounwind
define <n x 2 x double> @logcall(<n x 2 x double> %a) {
; CHECK-LABEL: logcall
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb d0, [[PG]]
; CHECK: bl log
  %res = call <n x 2 x double> @llvm.log.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind
define <n x 2 x float> @logcallf(<n x 2 x float> %a) {
; CHECK-LABEL: logcallf
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb s0, [[PG]]
; CHECK: bl log
  %res = call <n x 2 x float> @llvm.log.nxv2f32(<n x 2 x float> %a)
  ret <n x 2 x float> %res
}

; Function Attrs: nounwind
define <n x 2 x double> @log2call(<n x 2 x double> %a) {
; CHECK-LABEL: log2call
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb d0, [[PG]]
; CHECK: bl log2
  %res = call <n x 2 x double> @llvm.log2.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind
define <n x 2 x float> @log2callf(<n x 2 x float> %a) {
; CHECK-LABEL: log2callf
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb s0, [[PG]]
; CHECK: bl log2f
  %res = call <n x 2 x float> @llvm.log2.nxv2f32(<n x 2 x float> %a)
  ret <n x 2 x float> %res
}

; Function Attrs: nounwind
define <n x 2 x double> @log10call(<n x 2 x double> %a) {
; CHECK-LABEL: log10call
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb d0, [[PG]]
; CHECK: bl log10
  %res = call <n x 2 x double> @llvm.log10.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind
define <n x 2 x float> @log10callf(<n x 2 x float> %a) {
; CHECK-LABEL: log10callf
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb s0, [[PG]]
; CHECK: bl log10f
  %res = call <n x 2 x float> @llvm.log10.nxv2f32(<n x 2 x float> %a)
  ret <n x 2 x float> %res
}

; Function Attrs: nounwind
define <n x 2 x double> @sincall(<n x 2 x double> %a) {
; CHECK-LABEL: sincall
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb d0, [[PG]]
; CHECK: bl sin
  %res = call <n x 2 x double> @llvm.sin.nxv2f64(<n x 2 x double> %a)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind
define <n x 2 x float> @sincallf(<n x 2 x float> %a) {
; CHECK-LABEL: sincallf
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb s0, [[PG]]
; CHECK: bl sinf
  %res = call <n x 2 x float> @llvm.sin.nxv2f32(<n x 2 x float> %a)
  ret <n x 2 x float> %res
}

define <n x 2 x float> @powcallf(<n x 2 x float> %a, <n x 2 x float> %b) {
; CHECK-LABEL: powcallf
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK-DAG: lastb s0, [[PG]]
; CHECK-DAG: lastb s1, [[PG]]
; CHECK: bl powf
  %res = call <n x 2 x float> @llvm.pow.nxv2f32(<n x 2 x float> %a, <n x 2 x float> %b)
  ret <n x 2 x float> %res
}

define <n x 2 x float> @powcallf_splatarg(<n x 2 x float> %a, float %b) {
; CHECK-LABEL: powcallf_splatarg
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb s0, [[PG]]
; CHECK-NOT: lastb
; CHECK: bl powf
; This test checks that the 2nd parameter is used directly from the splat
; vector's source scalar rather using another lastb.
  %broadcast.splatinsert = insertelement <n x 2 x float> undef, float %b, i32 0
  %broadcast.splat = shufflevector <n x 2 x float> %broadcast.splatinsert, <n x 2 x float> undef, <n x 2 x i32> zeroinitializer
  %res = call <n x 2 x float> @llvm.pow.nxv2f32(<n x 2 x float> %a, <n x 2 x float> %broadcast.splat)
  ret <n x 2 x float> %res
}

define <n x 2 x double> @powcall_splatarg(<n x 2 x double> %a, double %b) {
; CHECK-LABEL: powcall_splatarg
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb d0, [[PG]]
; CHECK-NOT: lastb
; CHECK: bl pow
  %broadcast.splatinsert = insertelement <n x 2 x double> undef, double %b, i32 0
  %broadcast.splat = shufflevector <n x 2 x double> %broadcast.splatinsert, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %res = call <n x 2 x double> @llvm.pow.nxv2f64(<n x 2 x double> %a, <n x 2 x double> %broadcast.splat)
  ret <n x 2 x double> %res
}

define <n x 2 x double> @powicall(<n x 2 x double> %a, i32 %b) {
; CHECK-LABEL: powicall:
; CHECK: pfalse [[PG:p[0-9]+]].b
; CHECK: pnext [[PG]].d
; CHECK: lastb d0, [[PG]]
; CHECK-NOT: lastb
; CHECK: bl __powidf2
  %res = call <n x 2 x double> @llvm.powi.nxv2f64(<n x 2 x double> %a, i32 %b)
  ret <n x 2 x double> %res
}

declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) nounwind

define void @sve_memset(i8* %dst, i8 %val, i64 %N) {
; CHECK-LABEL: sve_memset:
; CHECK: st1b
; CHECK-NOT: addvl
; CHECK: whilelo
  call void @llvm.memset.p0i8.i64(i8* %dst, i8 %val, i64 %N, i32 8, i1 false)
  ret void
}

define void @sve_memset_small(i8* %dst, i8 %val) {
; CHECK-LABEL: sve_memset_small:
; CHECK-NOT: st1b
; CHECK-NOT: whilelo
  call void @llvm.memset.p0i8.i64(i8* %dst, i8 %val, i64 3, i32 8, i1 false)
  ret void
}

define void @sve_memset_volatile(i8* %dst, i8 %val, i64 %N) {
; CHECK-LABEL: sve_memset_volatile:
; CHECK-NOT: st1b
; CHECK-NOT: whilelo
  call void @llvm.memset.p0i8.i64(i8* %dst, i8 %val, i64 %N, i32 8, i1 true)
  ret void
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture, i64, i32, i1) nounwind

define void @sve_memcpy(i8* %dst, i8* %src, i64 %N) {
; CHECK-LABEL: sve_memcpy:
; CHECK: ld1b
; CHECK: st1b
; CHECK-NOT: addvl
; CHECK: whilelo
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %dst, i8* %src, i64 %N, i32 8, i1 false)
  ret void
}

define void @sve_memcpy_small(i8* %dst, i8* %src) {
; CHECK-LABEL: sve_memcpy_small:
; CHECK-NOT: ld1b
; CHECK-NOT: st1b
; CHECK-NOT: whilelo
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %dst, i8* %src, i64 3, i32 8, i1 false)
  ret void
}

define void @sve_memcpy_volatile(i8* %dst, i8* %src, i64 %N) {
; CHECK-LABEL: sve_memcpy_volatile:
; CHECK-NOT: ld1b
; CHECK-NOT: st1b
; CHECK-NOT: whilelo
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %dst, i8* %src, i64 %N, i32 8, i1 true)
  ret void
}

; Check overflow behaviour

define void @sve_memset_largecst_ovf(i8* %dst, i8 %val, i64 %N) {
; CHECK-LABEL: sve_memset_largecst_ovf:
; CHECK: st1b
; CHECK-NOT: addvl
; CHECK: whilelo
  call void @llvm.memset.p0i8.i64(i8* %dst, i8 %val, i64 18446744073709551487, i32 8, i1 false)
  ret void
}

define void @sve_memset_largecst_no_ovf(i8* %dst, i8 %val, i64 %N) {
; CHECK-LABEL: sve_memset_largecst_no_ovf:
; CHECK: st1b
; CHECK: addvl
; CHECK: whilelo
  call void @llvm.memset.p0i8.i64(i8* %dst, i8 %val, i64 18446744073709549567, i32 8, i1 false)
  ret void
}

declare void @llvm.memset.p0i8.i32(i8* nocapture, i8, i32, i32, i1) nounwind
define void @sve_memset_i32_no_ovf(i8* %dst, i8 %val, i32 %N) {
; CHECK-LABEL: sve_memset_i32_no_ovf:
; CHECK: st1b
; CHECK: addvl
; CHECK: whilelo
  call void @llvm.memset.p0i8.i32(i8* %dst, i8 %val, i32 %N, i32 8, i1 false)
  ret void
}

; Function Attrs: nounwind
define <n x 4 x float> @masked_cos(<n x 4 x i1> %p, <n x 4 x float> %a) #0 {
; CHECK-LABEL: masked_cos
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: bl cosf
  %res = call fast <n x 4 x float> @llvm.masked.cos.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind
define <n x 4 x float> @masked_exp(<n x 4 x i1> %p, <n x 4 x float> %a) #0 {
; CHECK-LABEL: masked_exp
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: bl expf
  %res = call fast <n x 4 x float> @llvm.masked.exp.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind
define <n x 4 x float> @masked_exp2(<n x 4 x i1> %p, <n x 4 x float> %a) #0 {
; CHECK-LABEL: masked_exp2
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: bl exp2f
  %res = call fast <n x 4 x float> @llvm.masked.exp2.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind
define <n x 4 x float> @masked_log(<n x 4 x i1> %p, <n x 4 x float> %a) #0 {
; CHECK-LABEL: masked_log
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: bl logf
  %res = call fast <n x 4 x float> @llvm.masked.log.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind
define <n x 4 x float> @masked_log2(<n x 4 x i1> %p, <n x 4 x float> %a) #0 {
; CHECK-LABEL: masked_log2
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: bl log2f
  %res = call fast <n x 4 x float> @llvm.masked.log2.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind
define <n x 4 x float> @masked_log10(<n x 4 x i1> %p, <n x 4 x float> %a) #0 {
; CHECK-LABEL: masked_log10
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: bl log10f
  %res = call fast <n x 4 x float> @llvm.masked.log10.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind
define <n x 4 x float> @masked_pow(<n x 4 x i1> %p, <n x 4 x float> %a, <n x 4 x float> %b) #0 {
; CHECK-LABEL: masked_pow
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: bl powf
  %res = call fast <n x 4 x float> @llvm.masked.pow.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a, <n x 4 x float> %b)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind
define <n x 4 x float> @masked_sin(<n x 4 x i1> %p, <n x 4 x float> %a) #0 {
; CHECK-LABEL: masked_sin
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: bl sinf
  %res = call fast <n x 4 x float> @llvm.masked.sin.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a)
  ret <n x 4 x float> %res
}

; We use the expandlibcall pass to work round the code generator's inability to
; load/store structures of scalable vectors.

; Function Attrs: nounwind
define %svint32x2_t @struct_load_i32(%svint32x2_t* %addr) {
; CHECK-LABEL: @struct_load_i32
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {z0.s}, [[PG]]/z, [x0]
; CHECK-DAG: ld1w {z1.s}, [[PG]]/z, [x0, #1, mul vl]
  %res = load %svint32x2_t, %svint32x2_t* %addr
  ret %svint32x2_t %res
}

; Function Attrs: nounwind
define void @struct_store_i32(%svint32x2_t %data, %svint32x2_t* %addr) {
; CHECK-LABEL: @struct_store_i32
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: st1w {z0.s}, [[PG]], [x0]
; CHECK-DAG: st1w {z1.s}, [[PG]], [x0, #1, mul vl]
  store %svint32x2_t %data, %svint32x2_t* %addr
  ret void
}

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.cos.nxv4f32(<n x 4 x i1>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.exp.nxv4f32(<n x 4 x i1>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.exp2.nxv4f32(<n x 4 x i1>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.log.nxv4f32(<n x 4 x i1>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.log2.nxv4f32(<n x 4 x i1>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.log10.nxv4f32(<n x 4 x i1>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.pow.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.sin.nxv4f32(<n x 4 x i1>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.cos.nxv2f64(<n x 2 x double>)

; Function Attrs: nounwind readnone
declare <n x 2 x float> @llvm.cos.nxv2f32(<n x 2 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.exp.nxv2f64(<n x 2 x double>)

; Function Attrs: nounwind readnone
declare <n x 2 x float> @llvm.exp.nxv2f32(<n x 2 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.exp2.nxv2f64(<n x 2 x double>)

; Function Attrs: nounwind readnone
declare <n x 2 x float> @llvm.exp2.nxv2f32(<n x 2 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.log.nxv2f64(<n x 2 x double>)

; Function Attrs: nounwind readnone
declare <n x 2 x float> @llvm.log.nxv2f32(<n x 2 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.log2.nxv2f64(<n x 2 x double>)

; Function Attrs: nounwind readnone
declare <n x 2 x float> @llvm.log2.nxv2f32(<n x 2 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.log10.nxv2f64(<n x 2 x double>)

; Function Attrs: nounwind readnone
declare <n x 2 x float> @llvm.log10.nxv2f32(<n x 2 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.sin.nxv2f64(<n x 2 x double>)

; Function Attrs: nounwind readnone
declare <n x 2 x float> @llvm.sin.nxv2f32(<n x 2 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x float> @llvm.pow.nxv2f32(<n x 2 x float>, <n x 2 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.pow.nxv2f64(<n x 2 x double>, <n x 2 x double>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.powi.nxv2f64(<n x 2 x double>, i32)

; Function Attrs: nounwind
define <n x 4 x float> @masked_copysignf(<n x 4 x i1> %p, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: masked_copysignf:
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: bit
  %res = call fast <n x 4 x float> @llvm.masked.copysign.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a, <n x 4 x float> %b)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind
define <n x 2 x double> @masked_copysign(<n x 2 x i1> %p, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: masked_copysign:
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].d, p0
; CHECK: bit
  %res = call fast <n x 2 x double> @llvm.masked.copysign.nxv2f64(<n x 2 x i1> %p, <n x 2 x double> %a, <n x 2 x double> %b)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.copysign.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.masked.copysign.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

; Function Attrs: nounwind
define <n x 4 x float> @masked_rintf(<n x 4 x i1> %p, <n x 4 x float> %a) #0 {
; CHECK-LABEL: masked_rintf:
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: frintx
  %res = call fast <n x 4 x float> @llvm.masked.rint.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.rint.nxv4f32(<n x 4 x i1>, <n x 4 x float>)

; Function Attrs: nounwind
define <n x 2 x double> @masked_rint(<n x 2 x i1> %p, <n x 2 x double> %a) #0 {
; CHECK-LABEL: masked_rint:
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].d, p0
; CHECK: frintx
  %res = call fast <n x 2 x double> @llvm.masked.rint.nxv2f64(<n x 2 x i1> %p, <n x 2 x double> %a)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.masked.rint.nxv2f64(<n x 2 x i1>, <n x 2 x double>)

; Function Attrs: nounwind
define <n x 4 x float> @masked_maxnumf(<n x 4 x i1> %p, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: masked_maxnumf:
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: fmaxnm
  %res = call fast <n x 4 x float> @llvm.masked.maxnum.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a, <n x 4 x float> %b)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind
define <n x 2 x double> @masked_maxnum(<n x 2 x i1> %p, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: masked_maxnum:
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].d, p0
; CHECK: fmaxnm
  %res = call fast <n x 2 x double> @llvm.masked.maxnum.nxv2f64(<n x 2 x i1> %p, <n x 2 x double> %a, <n x 2 x double> %b)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.maxnum.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.masked.maxnum.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)


; Function Attrs: nounwind
define <n x 4 x float> @masked_minnumf(<n x 4 x i1> %p, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: masked_minnumf:
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].s, p0
; CHECK: fminnm
  %res = call fast <n x 4 x float> @llvm.masked.minnum.nxv4f32(<n x 4 x i1> %p, <n x 4 x float> %a, <n x 4 x float> %b)
  ret <n x 4 x float> %res
}

; Function Attrs: nounwind
define <n x 2 x double> @masked_minnum(<n x 2 x i1> %p, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: masked_minnum:
; CHECK: pfalse [[PX:p[0-9]+]].b
; CHECK: pnext [[PX]].d, p0
; CHECK: fminnm
  %res = call fast <n x 2 x double> @llvm.masked.minnum.nxv2f64(<n x 2 x i1> %p, <n x 2 x double> %a, <n x 2 x double> %b)
  ret <n x 2 x double> %res
}

; Function Attrs: nounwind readnone
declare <n x 4 x float> @llvm.masked.minnum.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)

; Function Attrs: nounwind readnone
declare <n x 2 x double> @llvm.masked.minnum.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

