; RUN: llc -verify-machineinstrs -mattr=+sve -mtriple=aarch64 < %s | FileCheck %s

; vscale tests for vectors > 128 bits

define i64 @rdvl_nxv32i8_i16_test() {
; CHECK-LABEL: rdvl_nxv32i8_i16_test:
; CHECK: rdvl x0, #2
; CHECK-NEXT: ret
  %count = mul i16 vscale, 32
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv32i8_i32_test() {
; CHECK-LABEL: rdvl_nxv32i8_i32_test:
; CHECK: rdvl x0, #2
; CHECK-NEXT: ret
  %count = mul i32 vscale, 32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv32i8_i64_test() {
; CHECK-LABEL: rdvl_nxv32i8_i64_test:
; CHECK: rdvl x0, #2
; CHECK-NEXT: ret
  %count = mul i64 vscale, 32
  ret i64 %count
}

define i64 @rdvl_nxv16i16_i16_test() {
; CHECK-LABEL: rdvl_nxv16i16_i16_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i16 vscale, 16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i16_i32_test() {
; CHECK-LABEL: rdvl_nxv16i16_i32_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i32 vscale, 16
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i16_i64_test() {
; CHECK-LABEL: rdvl_nxv16i16_i64_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i64 vscale, 16
  ret i64 %count
}

define i64 @rdvl_nxv32i16_i16_test() {
; CHECK-LABEL: rdvl_nxv32i16_i16_test:
; CHECK: rdvl x0, #2
; CHECK-NEXT: ret
  %count = mul i16 vscale, 32
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv32i16_i32_test() {
; CHECK-LABEL: rdvl_nxv32i16_i32_test:
; CHECK: rdvl x0, #2
; CHECK-NEXT: ret
  %count = mul i32 vscale, 32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv32i16_i64_test() {
; CHECK-LABEL: rdvl_nxv32i16_i64_test:
; CHECK: rdvl x0, #2
; CHECK-NEXT: ret
  %count = mul i64 vscale, 32
  ret i64 %count
}

define i64 @rdvl_nxv8i32_i16_test() {
; CHECK-LABEL: rdvl_nxv8i32_i16_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 8
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i32_i32_test() {
; CHECK-LABEL: rdvl_nxv8i32_i32_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 8
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i32_i64_test() {
; CHECK-LABEL: rdvl_nxv8i32_i64_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 8
  ret i64 %count
}

define i64 @rdvl_nxv16i32_i16_test() {
; CHECK-LABEL: rdvl_nxv16i32_i16_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i16 vscale, 16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i32_i32_test() {
; CHECK-LABEL: rdvl_nxv16i32_i32_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i32 vscale, 16
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i32_i64_test() {
; CHECK-LABEL: rdvl_nxv16i32_i64_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i64 vscale, 16
  ret i64 %count
}

define i64 @rdvl_nxv4i64_i16_test() {
; CHECK-LABEL: rdvl_nxv4i64_i16_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 4
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i64_i32_test() {
; CHECK-LABEL: rdvl_nxv4i64_i32_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 4
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i64_i64_test() {
; CHECK-LABEL: rdvl_nxv4i64_i64_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 4
  ret i64 %count
}

define i64 @rdvl_nxv8i64_i16_test() {
; CHECK-LABEL: rdvl_nxv8i64_i16_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 8
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i64_i32_test() {
; CHECK-LABEL: rdvl_nxv8i64_i32_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 8
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i64_i64_test() {
; CHECK-LABEL: rdvl_nxv8i64_i64_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 8
  ret i64 %count
}

define i64 @rdvl_nxv16i64_i16_test() {
; CHECK-LABEL: rdvl_nxv16i64_i16_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i16 vscale, 16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i64_i32_test() {
; CHECK-LABEL: rdvl_nxv16i64_i32_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i32 vscale, 16
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i64_i64_test() {
; CHECK-LABEL: rdvl_nxv16i64_i64_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i64 vscale, 16
  ret i64 %count
}

define i64 @rdvl_nxv16f32_i32_test() {
; CHECK-LABEL: rdvl_nxv16f32_i32_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i32 vscale, 16
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16f32_i64_test() {
; CHECK-LABEL: rdvl_nxv16f32_i64_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i64 vscale, 16
  ret i64 %count
}

define i64 @rdvl_nxv16f64_i32_test() {
; CHECK-LABEL: rdvl_nxv16f64_i32_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i32 vscale, 16
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16f64_i64_test() {
; CHECK-LABEL: rdvl_nxv16f64_i64_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i64 vscale, 16
  ret i64 %count
}
