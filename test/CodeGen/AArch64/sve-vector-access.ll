; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -O3 < %s | FileCheck %s

define i64 @extract_nxv2i64_scalar(<n x 2 x i64> %v1, <n x 2 x i64> %v2,
                                   i64 %index) {
; CHECK-LABEL: extract_nxv2i64_scalar
; CHECK: index
; CHECK: cmpeq
; check: lastb
  %v = add <n x 2 x i64> %v1, %v2
  %res = extractelement <n x 2 x i64> %v, i64 31
  ret i64 %res
}

define i64 @extract_nxv2i64_valid_scalar(<n x 2 x i64> %v1, <n x 2 x i64> %v2,
                                   i64 %index) {
; CHECK-LABEL: extract_nxv2i64_valid_scalar
; CHECK: mov
; CHECK: fmov x0
  %v = add <n x 2 x i64> %v1, %v2
  %res = extractelement <n x 2 x i64> %v, i64 1
  ret i64 %res
}

define <n x 16 x i8> @insert_nxv16i8_scalar(<n x 16 x i8> %vec, i8 %val) {
; CHECK-LABEL: insert_nxv16i8_scalar
; CHECK: cmpeq [[P:p[0-9]+]].b, p0/z
; CHECK: mov    z0.b, [[P]]/m, w0
  %1 = insertelement <n x 16 x i8> %vec, i8 %val, i32 33
  ret <n x 16 x i8> %1
}

define <n x 16 x i8> @insert_nxv16i8_valid_scalar(<n x 16 x i8> %vec, i8 %val) {
; CHECK-LABEL: insert_nxv16i8_valid_scalar
; CHECK: cmpeq [[P:p[0-9]+]].b, p0/z
; CHECK: mov    z0.b, [[P]]/m, w0
  %1 = insertelement <n x 16 x i8> %vec, i8 %val, i32 3
  ret <n x 16 x i8> %1
}
