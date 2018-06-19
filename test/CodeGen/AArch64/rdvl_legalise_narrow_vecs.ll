; RUN: llc -verify-machineinstrs -mattr=+sve -mtriple=aarch64 < %s | FileCheck %s

; vscale tests for vectors < 128 bits

define i64 @rdvl_nxv2i8_i16_test() {
; CHECK-LABEL: rdvl_nxv2i8_i16_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 2
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i8_i32_test() {
; CHECK-LABEL: rdvl_nxv2i8_i32_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 2
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i8_i64_test() {
; CHECK-LABEL: rdvl_nxv2i8_i64_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 2
  ret i64 %count
}

define i64 @rdvl_nxv4i8_i16_test() {
; CHECK-LABEL: rdvl_nxv4i8_i16_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 4
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i8_i32_test() {
; CHECK-LABEL: rdvl_nxv4i8_i32_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 4
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i8_i64_test() {
; CHECK-LABEL: rdvl_nxv4i8_i64_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 4
  ret i64 %count
}

define i64 @rdvl_nxv8i8_i16_test() {
; CHECK-LABEL: rdvl_nxv8i8_i16_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 8
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i8_i32_test() {
; CHECK-LABEL: rdvl_nxv8i8_i32_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 8
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i8_i64_test() {
; CHECK-LABEL: rdvl_nxv8i8_i64_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 8
  ret i64 %count
}

define i64 @rdvl_nxv2i16_i16_test() {
; CHECK-LABEL: rdvl_nxv2i16_i16_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 2
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i16_i32_test() {
; CHECK-LABEL: rdvl_nxv2i16_i32_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 2
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i16_i64_test() {
; CHECK-LABEL: rdvl_nxv2i16_i64_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 2
  ret i64 %count
}

define i64 @rdvl_nxv4i16_i16_test() {
; CHECK-LABEL: rdvl_nxv4i16_i16_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 4
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i16_i32_test() {
; CHECK-LABEL: rdvl_nxv4i16_i32_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 4
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i16_i64_test() {
; CHECK-LABEL: rdvl_nxv4i16_i64_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 4
  ret i64 %count
}

define i64 @rdvl_nxv2i32_i16_test() {
; CHECK-LABEL: rdvl_nxv2i32_i16_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 2
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i32_i32_test() {
; CHECK-LABEL: rdvl_nxv2i32_i32_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 2
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i32_i64_test() {
; CHECK-LABEL: rdvl_nxv2i32_i64_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 2
  ret i64 %count
}

define i64 @rdvl_nxv2f32_i32_test() {
; CHECK-LABEL: rdvl_nxv2f32_i32_test:
; CHECK: cntd x0
; CHECK: ret
  %count = mul i32 vscale, 2
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2f32_i64_test() {
; CHECK-LABEL: rdvl_nxv2f32_i64_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 2
  ret i64 %count
}
