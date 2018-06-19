; RUN: llc < %s -mtriple=aarch64--linux-gnu -mattr=+sve | FileCheck %s

; remark: oor in function names refers to 'out o range' for the immediate being used

;;;;;;;;;;;;;;;;
; 8-bit data   ;
;;;;;;;;;;;;;;;;

define void @ld1r_i8(<n x 16 x i8> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8:
; CHECK: ld1rb {[[REG:z[0-9]+]].b}, p{{[0-9]+}}/z, [x1, #2]
; CHECK: st1b {[[REG]].b},
  %valp2 = getelementptr i8, i8* %valp, i32 2
  %val = load i8, i8* %valp2
  %1 = insertelement <n x 16 x i8> undef, i8 %val, i32 0
  %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  store <n x 16 x i8> %2, <n x 16 x i8> *%addr
  ret void
}

define void @ld1r_i8_oor_top(<n x 16 x i8> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i8, i8* %valp, i32 64
  %val = load i8, i8* %valp2
  %1 = insertelement <n x 16 x i8> undef, i8 %val, i32 0
  %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  store <n x 16 x i8> %2, <n x 16 x i8> *%addr
  ret void
}

define void @ld1r_i8_oor_low(<n x 16 x i8> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i8, i8* %valp, i32 -1
  %val = load i8, i8* %valp2
  %1 = insertelement <n x 16 x i8> undef, i8 %val, i32 0
  %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  store <n x 16 x i8> %2, <n x 16 x i8> *%addr
  ret void
}

define void @ld1r_i8_i16_zext(<n x 8 x i16> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i16_zext:
; CHECK: ld1rb {[[REG:z[0-9]+]].h}, p{{[0-9]+}}/z, [x1, #2]
; CHECK: st1h {[[REG]].h},
  %valp2 = getelementptr i8, i8* %valp, i32 2
  %val = load i8, i8* %valp2
  %extended_val= zext i8 %val to i16
  %1 = insertelement <n x 8 x i16> undef, i16 %extended_val, i16 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i8_i16_zext_oor_top(<n x 8 x i16> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i16_zext_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i8, i8* %valp, i32 64
  %val = load i8, i8* %valp2
  %extended_val= zext i8 %val to i16
  %1 = insertelement <n x 8 x i16> undef, i16 %extended_val, i16 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i8_i16_zext_oor_low(<n x 8 x i16> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i16_zext_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i8, i8* %valp, i32 -1
  %val = load i8, i8* %valp2
  %extended_val= zext i8 %val to i16
  %1 = insertelement <n x 8 x i16> undef, i16 %extended_val, i16 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i8_i32_zext(<n x 4 x i32> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i32_zext:
; CHECK: ld1rb {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [x1, #2]
; CHECK: st1w {[[REG]].s},
  %valp2 = getelementptr i8, i8* %valp, i32 2
  %val = load i8, i8* %valp2
  %extended_val= zext i8 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i8_i32_zext_oor_top(<n x 4 x i32> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i32_zext_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i8, i8* %valp, i32 64
  %val = load i8, i8* %valp2
  %extended_val= zext i8 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i8_i32_zext_oor_low(<n x 4 x i32> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i32_zext_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i8, i8* %valp, i32 -1
  %val = load i8, i8* %valp2
  %extended_val= zext i8 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i8_i64_zext(<n x 2 x i64> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i64_zext:
; CHECK: ld1rb {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [x1, #2]
; CHECK: st1d {[[REG]].d},
  %valp2 = getelementptr i8, i8* %valp, i32 2
  %val = load i8, i8* %valp2
  %extended_val = zext i8 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i8_i64_zext_oor_top(<n x 2 x i64> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i64_zext_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i8, i8* %valp, i32 64
  %val = load i8, i8* %valp2
  %extended_val = zext i8 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i8_i64_zext_oor_low(<n x 2 x i64> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i64_zext_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i8, i8* %valp, i32 -1
  %val = load i8, i8* %valp2
  %extended_val = zext i8 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i8_i16_sext(<n x 8 x i16> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i16_sext:
; CHECK: ld1rsb {[[REG:z[0-9]+]].h}, p{{[0-9]+}}/z, [x1, #2]
; CHECK: st1h {[[REG]].h},
  %valp2 = getelementptr i8, i8* %valp, i32 2
  %val = load i8, i8* %valp2
  %extended_val= sext i8 %val to i16
  %1 = insertelement <n x 8 x i16> undef, i16 %extended_val, i16 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i8_i16_sext_oor_top(<n x 8 x i16> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i16_sext_oor_top:
; CHECK-NOT: ld1rsb
  %valp2 = getelementptr i8, i8* %valp, i32 64
  %val = load i8, i8* %valp2
  %extended_val= sext i8 %val to i16
  %1 = insertelement <n x 8 x i16> undef, i16 %extended_val, i16 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i8_i16_sext_oor_low(<n x 8 x i16> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i16_sext_oor_low:
; CHECK-NOT: ld1rsb
  %valp2 = getelementptr i8, i8* %valp, i32 -1
  %val = load i8, i8* %valp2
  %extended_val= sext i8 %val to i16
  %1 = insertelement <n x 8 x i16> undef, i16 %extended_val, i16 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i8_i32_sext_oor_top(<n x 4 x i32> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i32_sext_oor_top:
; CHECK-NOT: ld1rsb
; CHECK: st1w {[[REG]].s},
  %valp2 = getelementptr i8, i8* %valp, i32 64
  %val = load i8, i8* %valp2
  %extended_val= sext i8 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i8_i32_sext_oor_low(<n x 4 x i32> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i32_sext_oor_low:
; CHECK-NOT: ld1rsb
; CHECK: st1w {[[REG]].s},
  %valp2 = getelementptr i8, i8* %valp, i32 -1
  %val = load i8, i8* %valp2
  %extended_val= sext i8 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i8_i64_sext(<n x 2 x i64> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i64_sext:
; CHECK: ld1rsb {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [x1, #2]
; CHECK: st1d {[[REG]].d},
  %valp2 = getelementptr i8, i8* %valp, i32 2
  %val = load i8, i8* %valp2
  %extended_val= sext i8 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i8_i64_sext_oor_top(<n x 2 x i64> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i64_sext_oor_top:
; CHECK-NOT: ld1rsb
  %valp2 = getelementptr i8, i8* %valp, i32 64
  %val = load i8, i8* %valp2
  %extended_val= sext i8 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i8_i64_sext_oor_low(<n x 2 x i64> *%addr, i8 *%valp) {
; CHECK-LABEL: ld1r_i8_i64_sext_oor_low:
; CHECK-NOT: ld1rsb
  %valp2 = getelementptr i8, i8* %valp, i32 -1
  %val = load i8, i8* %valp2
  %extended_val= sext i8 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

;;;;;;;;;;;;;;;;
; 16-bit  data ;
;;;;;;;;;;;;;;;;

define void @ld1r_i16(<n x 8 x i16> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16:
; CHECK: ld1rh {[[REG:z[0-9]+]].h}, p{{[0-9]+}}/z, [x1, #24]
; CHECK: st1h {[[REG]].h},
  %valp2 = getelementptr i16, i16* %valp, i32 12
  %val = load i16, i16* %valp2
  %1 = insertelement <n x 8 x i16> undef, i16 %val, i32 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i16_oor_top(<n x 8 x i16> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i16, i16* %valp, i32 64
  %val = load i16, i16* %valp2
  %1 = insertelement <n x 8 x i16> undef, i16 %val, i32 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i16_oor_low(<n x 8 x i16> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i16, i16* %valp, i32 -1
  %val = load i16, i16* %valp2
  %1 = insertelement <n x 8 x i16> undef, i16 %val, i32 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  store <n x 8 x i16> %2, <n x 8 x i16> *%addr
  ret void
}

define void @ld1r_i16_i32_zext(<n x 4 x i32> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i32_zext:
; CHECK: ld1rh {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [x1, #24]
; CHECK: st1w {[[REG]].s},
  %valp2 = getelementptr i16, i16* %valp, i32 12
  %val = load i16, i16* %valp2
  %extended_val= zext i16 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i16_i32_zext_oor_top(<n x 4 x i32> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i32_zext_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i16, i16* %valp, i32 64
  %val = load i16, i16* %valp2
  %extended_val= zext i16 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i16_i32_zext_oor_low(<n x 4 x i32> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i32_zext_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i16, i16* %valp, i32 -1
  %val = load i16, i16* %valp2
  %extended_val= zext i16 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i16_i64_zext(<n x 2 x i64> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i64_zext:
; CHECK: ld1rh {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [x1, #24]
; CHECK: st1d {[[REG]].d},
  %valp2 = getelementptr i16, i16* %valp, i32 12
  %val = load i16, i16* %valp2
  %extended_val = zext i16 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i16_i64_zext_oor_top(<n x 2 x i64> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i64_zext_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i16, i16* %valp, i32 64
  %val = load i16, i16* %valp2
  %extended_val = zext i16 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i16_i64_zext_oor_low(<n x 2 x i64> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i64_zext_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i16, i16* %valp, i32 -1
  %val = load i16, i16* %valp2
  %extended_val = zext i16 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i16_i32_sext(<n x 4 x i32> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i32_sext:
; CHECK: ld1rsh {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [x1, #24]
; CHECK: st1w {[[REG]].s},
  %valp2 = getelementptr i16, i16* %valp, i32 12
  %val = load i16, i16* %valp2
  %extended_val= sext i16 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i16_i32_sext_oor_top(<n x 4 x i32> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i32_sext_oor_top:
; CHECK-NOT: ld1rsh
  %valp2 = getelementptr i16, i16* %valp, i32 64
  %val = load i16, i16* %valp2
  %extended_val= sext i16 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i16_i32_sext_oor_low(<n x 4 x i32> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i32_sext_oor_low:
; CHECK-NOT: ld1rsh
  %valp2 = getelementptr i16, i16* %valp, i32 -1
  %val = load i16, i16* %valp2
  %extended_val= sext i16 %val to i32
  %1 = insertelement <n x 4 x i32> undef, i32 %extended_val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i16_i64_sext(<n x 2 x i64> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i64_sext:
; CHECK: ld1rsh {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [x1, #24]
; CHECK: st1d {[[REG]].d},
  %valp2 = getelementptr i16, i16* %valp, i32 12
  %val = load i16, i16* %valp2
  %extended_val= sext i16 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i16_i64_sext_oor_top(<n x 2 x i64> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i64_sext_oor_top:
; CHECK-NOT: ld1rsh
  %valp2 = getelementptr i16, i16* %valp, i32 64
  %val = load i16, i16* %valp2
  %extended_val= sext i16 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i16_i64_sext_oor_low(<n x 2 x i64> *%addr, i16 *%valp) {
; CHECK-LABEL: ld1r_i16_i64_sext_oor_low:
; CHECK-NOT: ld1rsh
  %valp2 = getelementptr i16, i16* %valp, i32 -1
  %val = load i16, i16* %valp2
  %extended_val= sext i16 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

;;;;;;;;;;;;;;;;
; 32-bit  data ;
;;;;;;;;;;;;;;;;

define void @ld1r_i32(<n x 4 x i32> *%addr, i32 *%valp) {
; CHECK-LABEL: ld1r_i32:
; CHECK: ld1rw {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [x1, #252]
; CHECK: st1w {[[REG]].s},
  %valp2 = getelementptr i32, i32* %valp, i32 63
  %val = load i32, i32* %valp2
  %1 = insertelement <n x 4 x i32> undef, i32 %val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i32_oor_top(<n x 4 x i32> *%addr, i32 *%valp) {
; CHECK-LABEL: ld1r_i32_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i32, i32* %valp, i32 64
  %val = load i32, i32* %valp2
  %1 = insertelement <n x 4 x i32> undef, i32 %val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i32_oor_low(<n x 4 x i32> *%addr, i32 *%valp) {
; CHECK-LABEL: ld1r_i32_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i32, i32* %valp, i32 -1
  %val = load i32, i32* %valp2
  %1 = insertelement <n x 4 x i32> undef, i32 %val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x i32> %2, <n x 4 x i32> *%addr
  ret void
}

define void @ld1r_i32_i64_zext(<n x 2 x i64> *%addr, i32 *%valp) {
; CHECK-LABEL: ld1r_i32_i64_zext:
; CHECK: ld1rw {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [x1, #252]
; CHECK: st1d {[[REG]].d},
  %valp2 = getelementptr i32, i32* %valp, i32 63
  %val = load i32, i32* %valp2
  %extended_val = zext i32 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i32_i64_zext_oor_top(<n x 2 x i64> *%addr, i32 *%valp) {
; CHECK-LABEL: ld1r_i32_i64_zext_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i32, i32* %valp, i32 64
  %val = load i32, i32* %valp2
  %extended_val = zext i32 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i32_i64_zext_oor_low(<n x 2 x i64> *%addr, i32 *%valp) {
; CHECK-LABEL: ld1r_i32_i64_zext_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i32, i32* %valp, i32 -1
  %val = load i32, i32* %valp2
  %extended_val = zext i32 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i32_i64_sext(<n x 2 x i64> *%addr, i32 *%valp) {
; CHECK-LABEL: ld1r_i32_i64_sext:
; CHECK: ld1rsw {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [x1, #252]
; CHECK: st1d {[[REG]].d},
   %valp2 = getelementptr i32, i32* %valp, i32 63
  %val = load i32, i32* %valp2
  %extended_val= sext i32 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i32_i64_sext_oor_top(<n x 2 x i64> *%addr, i32 *%valp) {
; CHECK-LABEL: ld1r_i32_i64_sext_oor_top:
; CHEC-NOT: ld1rsw
  %valp2 = getelementptr i32, i32* %valp, i32 64
  %val = load i32, i32* %valp2
  %extended_val= sext i32 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i32_i64_sext_oor_low(<n x 2 x i64> *%addr, i32 *%valp) {
; CHECK-LABEL: ld1r_i32_i64_sext_oor_low:
; CHEC-NOT: ld1rsw
  %valp2 = getelementptr i32, i32* %valp, i32 -1
  %val = load i32, i32* %valp2
  %extended_val= sext i32 %val to i64
  %1 = insertelement <n x 2 x i64> undef, i64 %extended_val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

;;;;;;;;;;;;;;;;
; 64-bit  data ;
;;;;;;;;;;;;;;;;

define void @ld1r_i64(<n x 2 x i64> *%addr, i64 *%valp) {
; CHECK-LABEL: ld1r_i64:
; CHECK: ld1rd {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [x1, #16]
; CHECK: st1d {[[REG]].d},
  %valp2 = getelementptr i64, i64* %valp, i64 2
  %val = load i64, i64* %valp2
  %1 = insertelement <n x 2 x i64> undef, i64 %val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i64_oor_top(<n x 2 x i64> *%addr, i64 *%valp) {
; CHECK-LABEL: ld1r_i64_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i64, i64* %valp, i64 64
  %val = load i64, i64* %valp2
  %1 = insertelement <n x 2 x i64> undef, i64 %val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

define void @ld1r_i64_oor_low(<n x 2 x i64> *%addr, i64 *%valp) {
; CHECK-LABEL: ld1r_i64_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr i64, i64* %valp, i64 -1
  %val = load i64, i64* %valp2
  %1 = insertelement <n x 2 x i64> undef, i64 %val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x i64> %2, <n x 2 x i64> *%addr
  ret void
}

;;;;;;;;;;;
; FP data ;
;;;;;;;;;;;

define void @ld1r_float(<n x 4 x float> *%addr, float *%valp) {
; CHECK-LABEL: ld1r_float:
; CHECK: ld1rw {[[REG:z[0-9]+]].s}, p{{[0-9]+}}/z, [x1, #8]
; CHECK: st1w {[[REG]].s},
  %valp2 = getelementptr float, float* %valp, i32 2
  %val = load float, float* %valp2
  %1 = insertelement <n x 4 x float> undef, float %val, i32 0
  %2 = shufflevector <n x 4 x float> %1, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x float> %2, <n x 4 x float> *%addr
  ret void
}

define void @ld1r_float_oor_top(<n x 4 x float> *%addr, float *%valp) {
; CHECK-LABEL: ld1r_float_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr float, float* %valp, i32 64
  %val = load float, float* %valp2
  %1 = insertelement <n x 4 x float> undef, float %val, i32 0
  %2 = shufflevector <n x 4 x float> %1, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x float> %2, <n x 4 x float> *%addr
  ret void
}

define void @ld1r_float_oor_low(<n x 4 x float> *%addr, float *%valp) {
; CHECK-LABEL: ld1r_float_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr float, float* %valp, i32 -1
  %val = load float, float* %valp2
  %1 = insertelement <n x 4 x float> undef, float %val, i32 0
  %2 = shufflevector <n x 4 x float> %1, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  store <n x 4 x float> %2, <n x 4 x float> *%addr
  ret void
}

define void @ld1r_float_unpacked(<n x 2 x float> *%addr, float *%valp) {
; CHECK-LABEL: ld1r_float_unpacked:
; CHECK: ld1rw {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [x1, #8]
; CHECK: st1w {[[REG]].d},
  %valp2 = getelementptr float, float* %valp, i32 2
  %val = load float, float* %valp2
  %1 = insertelement <n x 2 x float> undef, float %val, i32 0
  %2 = shufflevector <n x 2 x float> %1, <n x 2 x float> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x float> %2, <n x 2 x float> *%addr
  ret void
}

define void @ld1r_float_unpacked_oor_top(<n x 2 x float> *%addr, float *%valp) {
; CHECK-LABEL: ld1r_float_unpacked_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr float, float* %valp, i32 64
  %val = load float, float* %valp2
  %1 = insertelement <n x 2 x float> undef, float %val, i32 0
  %2 = shufflevector <n x 2 x float> %1, <n x 2 x float> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x float> %2, <n x 2 x float> *%addr
  ret void
}

define void @ld1r_float_unpacked_oor_low(<n x 2 x float> *%addr, float *%valp) {
; CHECK-LABEL: ld1r_float_unpacked_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr float, float* %valp, i32 -1
  %val = load float, float* %valp2
  %1 = insertelement <n x 2 x float> undef, float %val, i32 0
  %2 = shufflevector <n x 2 x float> %1, <n x 2 x float> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x float> %2, <n x 2 x float> *%addr
  ret void
}

define void @ld1r_double(<n x 2 x double> *%addr, double *%valp) {
; CHECK-LABEL: ld1r_double:
; CHECK: ld1rd {[[REG:z[0-9]+]].d}, p{{[0-9]+}}/z, [x1, #264]
; CHECK: st1d {[[REG]].d},
  %valp2 = getelementptr double, double* %valp, i32 33
  %val = load double, double* %valp2
  %1 = insertelement <n x 2 x double> undef, double %val, i32 0
  %2 = shufflevector <n x 2 x double> %1, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x double> %2, <n x 2 x double> *%addr
  ret void
}

define void @ld1r_double_oor_top(<n x 2 x double> *%addr, double *%valp) {
; CHECK-LABEL: ld1r_double_oor_top:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr double, double* %valp, i32 64
  %val = load double, double* %valp2
  %1 = insertelement <n x 2 x double> undef, double %val, i32 0
  %2 = shufflevector <n x 2 x double> %1, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x double> %2, <n x 2 x double> *%addr
  ret void
}

define void @ld1r_double_oor_low(<n x 2 x double> *%addr, double *%valp) {
; CHECK-LABEL: ld1r_double_oor_low:
; CHECK-NOT: ld1r{{[bhwd]}}
  %valp2 = getelementptr double, double* %valp, i32 -1
  %val = load double, double* %valp2
  %1 = insertelement <n x 2 x double> undef, double %val, i32 0
  %2 = shufflevector <n x 2 x double> %1, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  store <n x 2 x double> %2, <n x 2 x double> *%addr
  ret void
}
