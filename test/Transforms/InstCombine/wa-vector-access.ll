; RUN: opt -mtriple=aarch64--linux-gnu -mattr=+sve -instcombine -S < %s | FileCheck %s

define i64 @extract_nxv2i64_scalar(<n x 2 x i64> %v1, <n x 2 x i64> %v2,
                                   i64 %index) {
; CHECK-LABEL: @extract_nxv2i64_scalar
; CHECK: extractelement
  %v = add <n x 2 x i64> %v1, %v2
  %res = extractelement <n x 2 x i64> %v, i64 31
  ret i64 %res
}

define i64 @extract_nxv2i64_valid_scalar(<n x 2 x i64> %v1, <n x 2 x i64> %v2,
                                   i64 %index) {
; CHECK-LABEL: @extract_nxv2i64_valid_scalar
; CHECK: extractelement
  %v = add <n x 2 x i64> %v1, %v2
  %res = extractelement <n x 2 x i64> %v, i64 1
  ret i64 %res
}

define <n x 16 x i8> @insert_nxv16i8_scalar(<n x 16 x i8> %vec, i8 %val) {
; CHECK-LABEL: @insert_nxv16i8_scalar
; CHECK: insertelement
  %1 = insertelement <n x 16 x i8> %vec, i8 %val, i32 33
  ; %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  ret <n x 16 x i8> %1
}

define <n x 16 x i8> @insert_nxv16i8_valid_scalar(<n x 16 x i8> %vec, i8 %val) {
; CHECK-LABEL: @insert_nxv16i8_valid_scalar
; CHECK: insertelement
  %1 = insertelement <n x 16 x i8> %vec, i8 %val, i32 3
  ; %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  ret <n x 16 x i8> %1
}

define <n x 16 x i8> @shuffle_nxv16i8_scalar(<n x 16 x i8> %pos, <n x 16 x i8> %vec, i8 %val) {
; CHECK-LABEL: @shuffle_nxv16i8_scalar
; CHECK: insertelement
; check: shufflevector
  %1 = insertelement <n x 16 x i8> %pos, i8 %val, i32 33
  %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> %vec, <n x 16 x i32> zeroinitializer
  ret <n x 16 x i8> %2
}

define <n x 16 x i8> @shuffle_nxv16i8_valid_scalar(<n x 16 x i8> %pos, <n x 16 x i8> %vec, i8 %val) {
; CHECK-LABEL: @shuffle_nxv16i8_valid_scalar
; CHECK: insertelement
; check: shufflevector
  %1 = insertelement <n x 16 x i8> %pos, i8 %val, i32 3
  %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> %vec, <n x 16 x i32> zeroinitializer
  ret <n x 16 x i8> %2
}

define i8 @insert_extract_nxv16i8_scalar(<n x 16 x i8> %vec, i8 %val) {
; CHECK-LABEL: @insert_extract_nxv16i8_scalar
; CHECK-NOT: insertelement
; CHECK-NOT: extractelement
; CHECK: ret i8 %val
  %1 = insertelement <n x 16 x i8> %vec, i8 %val, i32 33
  %res = extractelement <n x 16 x i8> %1, i64 33
  ret i8 %res
}
