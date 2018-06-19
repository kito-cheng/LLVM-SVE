; RUN: llc < %s -mtriple=aarch64--linux-gnu -mattr=+sve | FileCheck %s

;;;;;;;;;;;;;;;;
;  8-bit data  ;
;;;;;;;;;;;;;;;;

declare void @setmem_i8(i8 *)

define void @ld1r_i8_from(<n x 16 x i8> *%addr) {
; CHECK-LABEL: ld1r_i8_from:
; CHECK: ld1rb {[[REG:z[0-9]+]].b}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1b {[[REG]].b},
  %valp = alloca i8
  call void @setmem_i8(i8 * %valp)
  %val = load i8, i8* %valp
  %1 = insertelement <n x 16 x i8> undef, i8 %val, i32 0
  %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  store <n x 16 x i8> %2, <n x 16 x i8> *%addr
  ret void
}

define void @ld1r_i8_i16_zext_from(<n x 8 x i16> *%addr) {
; CHECK-LABEL: ld1r_i8_i16_zext_from:
; CHECK: ld1rb {[[REG:z[0-9]+]].h}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1h {[[REG]].h},
  %valp = alloca i8
  call void @setmem_i8(i8 *%valp)
  %val = load i8, i8* %valp
  %extended_val= zext i8 %val to i16
  %1 = insertelement <n x 8 x i16> undef, i16 %extended_val, i16 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i8_i32_zext(<n x 4 x i32> *%addr) {
; CHECK-LABEL: ld1r_i8_i32_zext:
; CHECK: ld1rb {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1w {[[REG]].s},
  %valp = alloca i8
  call void @setmem_i8(i8 *%valp)
  %val = load i8, i8* %valp
  %extended_val= zext i8 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i8_i64_zext(<n x 2 x i64> *%addr) {
; CHECK-LABEL: ld1r_i8_i64_zext:
; CHECK: ld1rb {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1d {[[REG]].d},
  %valp = alloca i8
  call void @setmem_i8(i8 *%valp)
  %val = load i8, i8* %valp
  %extended_val = zext i8 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i8_i16_sext(<n x 8 x i16> *%addr) {
; CHECK-LABEL: ld1r_i8_i16_sext:
; CHECK: ld1rsb {[[REG:z[0-9]+]].h}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1h {[[REG]].h},
  %valp = alloca i8
  call void @setmem_i8(i8 *%valp)
  %val = load i8, i8* %valp
  %extended_val= sext i8 %val to i16
  %1 = insertelement <n x 8 x i16> undef, i16 %extended_val, i16 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i8_i32_sext(<n x 4 x i32> *%addr) {
; CHECK-LABEL: ld1r_i8_i32_sext:
; CHECK: ld1rsb {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1w {[[REG]].s},
  %valp = alloca i8
  call void @setmem_i8(i8 *%valp)
  %val = load i8, i8* %valp
  %extended_val= sext i8 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i8_i64_sext(<n x 2 x i64> *%addr) {
; CHECK-LABEL: ld1r_i8_i64_sext:
; CHECK: ld1rsb {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1d {[[REG]].d},
  %valp = alloca i8
  call void @setmem_i8(i8 *%valp)
  %val = load i8, i8* %valp
  %extended_val= sext i8 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i64 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

;;;;;;;;;;;;;;;;
; 16-bit  data ;
;;;;;;;;;;;;;;;;

declare void @setmem_i16(i16 *)

define void @ld1r_i16(<n x 8 x i16> *%addr) {
; CHECK-LABEL: ld1r_i16:
; CHECK: ld1rh {[[REG:z[0-9]+]].h}, p{{[0-9]+}}/z, [sp, #12
; CHECK: st1h {[[REG]].h},
  %valp = alloca i16
  call void @setmem_i16(i16 *%valp)
  %val = load i16, i16* %valp
  %1 = insertelement <n x 8 x i16> undef, i16 %val, i32 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i16_i32_zext(<n x 4 x i32> *%addr) {
; CHECK-LABEL: ld1r_i16_i32_zext:
; CHECK: ld1rh {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [sp, #12
; CHECK: st1w {[[REG]].s},
  %valp = alloca i16
  call void @setmem_i16(i16 *%valp)
  %val = load i16, i16* %valp
  %extended_val= zext i16 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i16_i64_zext(<n x 2 x i64> *%addr) {
; CHECK-LABEL: ld1r_i16_i64_zext:
; CHECK: ld1rh {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [sp, #12
; CHECK: st1d {[[REG]].d},
  %valp = alloca i16
  call void @setmem_i16(i16 *%valp)
  %val = load i16, i16* %valp
  %extended_val = zext i16 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i16_i32_sext(<n x 4 x i32> *%addr) {
; CHECK-LABEL: ld1r_i16_i32_sext:
; CHECK: ld1rsh {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [sp, #12
; CHECK: st1w {[[REG]].s},
  %valp = alloca i16
  call void @setmem_i16(i16 *%valp)
  %val = load i16, i16* %valp
  %extended_val= sext i16 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i16_i64_sext(<n x 2 x i64> *%addr) {
; CHECK-LABEL: ld1r_i16_i64_sext:
; CHECK: ld1rsh {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [sp, #12
; CHECK: st1d {[[REG]].d},
  %valp = alloca i16
  call void @setmem_i16(i16 *%valp)
  %val = load i16, i16* %valp
  %extended_val= sext i16 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

;;;;;;;;;;;;;;;;
; 32-bit  data ;
;;;;;;;;;;;;;;;;

declare void @setmem_i32(i32 *)

define void @ld1r_i32(<n x 4 x i32> *%addr) {
; CHECK-LABEL: ld1r_i32:
; CHECK: ld1rw {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1w {[[REG]].s},
  %valp = alloca i32
  call void @setmem_i32(i32 *%valp)
  %val = load i32, i32* %valp
  %1 = insertelement <n x 4 x i32> undef, i32 %val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i32_i64_zext(<n x 2 x i64> *%addr) {
; CHECK-LABEL: ld1r_i32_i64_zext:
; CHECK: ld1rw {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1d {[[REG]].d},
  %valp = alloca i32
  call void @setmem_i32(i32 *%valp)
  %val = load i32, i32* %valp
  %extended_val = zext i32 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}
define void @ld1r_i32_i64_sext(<n x 2 x i64> *%addr) {
; CHECK-LABEL: ld1r_i32_i64_sext:
; CHECK: ld1rsw {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1d {[[REG]].d},
  %valp = alloca i32
  call void @setmem_i32(i32 *%valp)
  %val = load i32, i32* %valp
  %extended_val= sext i32 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

;;;;;;;;;;;;;;;;
; 64-bit  data ;
;;;;;;;;;;;;;;;;

declare void @setmem_i64(i64 *)

define void @ld1r_i64(<n x 2 x i64> *%addr) {
; CHECK-LABEL: ld1r_i64:
; CHECK: ld1rd {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [sp, #8]
; CHECK: st1d {[[REG]].d},
  %valp = alloca i64
  call void @setmem_i64(i64 *%valp)
  %val = load i64, i64* %valp
  %1 = insertelement <n x 2 x i64> undef, i64 %val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

;;;;;;;;;;;
; FP data ;
;;;;;;;;;;;

declare void @setmem_float(float *)
declare void @setmem_double(double *)

define void @ld1r_float(<n x 4 x float> *%addr) {
; CHECK-LABEL: ld1r_float:
; CHECK: ld1rw {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1w {[[REG]].s},
  %valp = alloca float
  call void @setmem_float(float *%valp)
  %val = load float, float* %valp
  %1 = insertelement <n x 4 x float> undef, float %val, i32 0
  %2 = shufflevector <n x 4 x float> %1, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x float> %2, <n x 4 x float> *%addr
  ret void
}

define void @ld1r_float_unpacked(<n x 2 x float> *%addr) {
; CHECK-LABEL: ld1r_float_unpacked:
; CHECK: ld1rw {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [sp, #12]
; CHECK: st1w {[[REG]].d},
  %valp = alloca float
  call void @setmem_float(float *%valp)
  %val = load float, float* %valp
  %1 = insertelement <n x 2 x float> undef, float %val, i32 0
  %2 = shufflevector <n x 2 x float> %1, <n x 2 x float> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x float> %2, <n x 2 x float> *%addr
  ret void
}
define void @ld1r_double(<n x 2 x double> *%addr) {
; CHECK-LABEL: ld1r_double:
; CHECK: ld1rd {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [sp, #8]
; CHECK: st1d {[[REG]].d},
  %valp = alloca double
  call void @setmem_double(double *%valp)
  %val = load double, double* %valp
  %1 = insertelement <n x 2 x double> undef, double %val, i32 0
  %2 = shufflevector <n x 2 x double> %1, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x double> %2, <n x 2 x double> *%addr
  ret void
}
