; RUN: llc -O3 -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

declare i1 @llvm.aarch64.sve.orv.nxv4i1(<n x 4 x i1>, <n x 4 x i1>)
declare i1 @llvm.aarch64.sve.orv.nxv8i1(<n x 8 x i1>, <n x 8 x i1>)
declare i1 @llvm.aarch64.sve.andv.nxv4i1(<n x 4 x i1>, <n x 4 x i1>)
declare i1 @llvm.aarch64.sve.andv.nxv8i1(<n x 8 x i1>, <n x 8 x i1>)

define i1 @any_true(<n x 4 x i1> %p) {
; CHECK-LABEL: any_true:
; CHECK: ptest p1, p0.b
; CHECK: cset w0, ne
  %1 = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %ptrue = shufflevector <n x 4 x i1> %1, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %res = call i1 @llvm.aarch64.sve.orv.nxv4i1(<n x 4 x i1> %ptrue, <n x 4 x i1> %p)
  ret i1 %res
}

define i1 @any_true_illegal(<n x 8 x i1> %p, <n x 8 x i1> %pred) {
; CHECK-LABEL: any_true_illegal:
; CHECK-NOT: ptest
; CHECK: mov     [[VEC:z[0-9]+]].h, p0/z, #-1
; CHECK: orv     h[[FPR:[0-9]+]], p1, [[VEC]].h
; CHECK: umov    w{{[0-9]+}}, v[[FPR]].h[0]
  %res = call i1 @llvm.aarch64.sve.orv.nxv8i1(<n x 8 x i1> %pred, <n x 8 x i1> %p)
  ret i1 %res
}

define i1 @all_true(<n x 4 x i1> %p) {
; CHECK-LABEL: all_true:
; CHECK: nor p0.b, p1/z, p0.b, p0.b
; CHECK: ptest p1, p0.b
; CHECK: cset w0, eq
  %1 = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %ptrue = shufflevector <n x 4 x i1> %1, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %res = call i1 @llvm.aarch64.sve.andv.nxv4i1(<n x 4 x i1> %ptrue, <n x 4 x i1> %p)
  ret i1 %res
}

define i1 @all_true_illegal(<n x 8 x i1> %p, <n x 8 x i1> %pred) {
; CHECK-LABEL: all_true_illegal:
; CHECK-NOT: ptest
; CHECK: mov     [[VEC:z[0-9]+]].h, p0/z, #-1
; CHECK: andv    h[[FPR:[0-9]+]], p1, [[VEC]].h
; CHECK: umov    w{{[0-9]+}}, v[[FPR]].h[0]
  %res = call i1 @llvm.aarch64.sve.andv.nxv8i1(<n x 8 x i1> %pred, <n x 8 x i1> %p)
  ret i1 %res
}

define i1 @all_false(<n x 4 x i1> %p) {
; CHECK-LABEL: all_false:
; CHECK: ptest p1, p0.b
; CHECK: cset w0, eq
  %1 = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %ptrue = shufflevector <n x 4 x i1> %1, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %inv = xor <n x 4 x i1> %p, %ptrue
  %res = call i1 @llvm.aarch64.sve.andv.nxv4i1(<n x 4 x i1> %ptrue, <n x 4 x i1> %inv)
  ret i1 %res
}

; Not a reduction but similar thing.
define i1 @last_true(<n x 4 x i1> %p) {
; CHECK-LABEL: last_true:
; CHECK: ptest p1, p0.b
; CHECK: cset w0, lo
  %ec = mul i64 vscale, 4
  %idx = sub i64 %ec, 1
  %res = extractelement <n x 4 x i1> %p, i64 %idx
  ret i1 %res
}
