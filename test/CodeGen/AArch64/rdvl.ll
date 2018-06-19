; RUN: llc -verify-machineinstrs -mattr=+sve < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnueabi"

define i64 @rdvl_i8_as_i16() {
; CHECK-LABEL: rdvl_i8_as_i16:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i16 vscale, 16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i8_as_i32() {
; CHECK-LABEL: rdvl_i8_as_i32:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i32 vscale, 16
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i8_as_i64() {
; CHECK-LABEL: rdvl_i8_as_i64:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = mul i64 vscale, 16
  ret i64 %count
}

define i64 @rdvl_i16_as_i16() {
; CHECK-LABEL: rdvl_i16_as_i16:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 8
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i16_as_i32() {
; CHECK-LABEL: rdvl_i16_as_i32:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 8
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i16_as_i64() {
; CHECK-LABEL: rdvl_i16_as_i64:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 8
  ret i64 %count
}

define i64 @rdvl_i32_as_i16() {
; CHECK-LABEL: rdvl_i32_as_i16:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 4
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i32_as_i32() {
; CHECK-LABEL: rdvl_i32_as_i32:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 4
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i32_as_i64() {
; CHECK-LABEL: rdvl_i32_as_i64:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 4
  ret i64 %count
}

define i64 @rdvl_i64_as_i16() {
; CHECK-LABEL: rdvl_i64_as_i16:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i16 vscale, 2
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_f32_as_i32() {
; CHECK-LABEL: rdvl_f32_as_i32:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 4
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_f32_as_i64() {
; CHECK-LABEL: rdvl_f32_as_i64:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 4
  ret i64 %count
}

define i64 @rdvl_f64_as_i32() {
; CHECK-LABEL: rdvl_f64_as_i32:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 2
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_i64_as_i32() {
; CHECK-LABEL: rdvl_i64_as_i32:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i32 vscale, 2
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_f64_as_i64() {
; CHECK-LABEL: rdvl_f64_as_i64:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 2
  ret i64 %count
}

define i64 @rdvl_i64_as_i64() {
; CHECK-LABEL: rdvl_i64_as_i64:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = mul i64 vscale, 2
  ret i64 %count
}
