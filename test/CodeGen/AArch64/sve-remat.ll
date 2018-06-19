; RUN: llc < %s -mtriple=aarch64--linux-gnu -mattr=+sve -verify-machineinstrs | FileCheck %s

; Check that float 0.0/1.0 get rematerialized with an fmov instead
; of being spilled/filled.

declare void @bar(<n x 4 x float>)
declare void @baz(<n x 2 x double>)

define void @dupfloat0() {
; CHECK-LABEL: dupfloat0:
; CHECK-NOT: str z0
; CHECK: mov z0.s, #0
; CHECK-NOT: str z0
; CHECK: bl bar
; CHECK-NOT: ldr z0
; CHECK: mov z0.s, #0
; CHECK-NOT: ldr z0
; CHECK: bl bar
; CHECK: ret
  %fval = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %baz = shufflevector <n x 4 x float> %fval,
                       <n x 4 x float> undef,
                       <n x 4 x i32> zeroinitializer
  call void @bar(<n x 4 x float> %baz)
  call void asm sideeffect "", "~{z0},~{z1},~{z2},~{z3},~{z4},~{z5},~{z6},~{z7},~{z8},~{z9},~{z10},~{z11},~{z12},~{z13},~{z14},~{z15},~{z16},~{z17},~{z18},~{z19},~{z20},~{z21},~{z22},~{z23},~{z24},~{z25},~{z26},~{z27},~{z28},~{z29},~{z30},~{z31}"()
  call void @bar(<n x 4 x float> %baz)
  ret void
}

define void @dupfloat1() {
; CHECK-LABEL: dupfloat1:
; CHECK-NOT: str z0
; CHECK: fmov z0.s, #1.00000000
; CHECK-NOT: str z0
; CHECK: bl bar
; CHECK-NOT: ldr z0
; CHECK: fmov z0.s, #1.00000000
; CHECK-NOT: ldr z0
; CHECK: bl bar
; CHECK: ret
  %fval = insertelement <n x 4 x float> undef, float 1.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %fval,
                        <n x 4 x float> undef,
                        <n x 4 x i32> zeroinitializer
  call void @bar(<n x 4 x float> %splat)
  call void asm sideeffect "", "~{z0},~{z1},~{z2},~{z3},~{z4},~{z5},~{z6},~{z7},~{z8},~{z9},~{z10},~{z11},~{z12},~{z13},~{z14},~{z15},~{z16},~{z17},~{z18},~{z19},~{z20},~{z21},~{z22},~{z23},~{z24},~{z25},~{z26},~{z27},~{z28},~{z29},~{z30},~{z31}"()
  call void @bar(<n x 4 x float> %splat)
  ret void
}

define void @dupdouble0() {
; CHECK-LABEL: dupdouble0:
; CHECK-NOT: str z0
; CHECK: mov z0.d, #0
; CHECK-NOT: str z0
; CHECK: bl baz
; CHECK-NOT: ldr z0
; CHECK: mov z0.d, #0
; CHECK-NOT: ldr z0
; CHECK: bl baz
; CHECK: ret
  %dval = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %dval,
                         <n x 2 x double> undef,
                         <n x 2 x i64> zeroinitializer
  call void @baz(<n x 2 x double> %splat)
  call void asm sideeffect "", "~{z0},~{z1},~{z2},~{z3},~{z4},~{z5},~{z6},~{z7},~{z8},~{z9},~{z10},~{z11},~{z12},~{z13},~{z14},~{z15},~{z16},~{z17},~{z18},~{z19},~{z20},~{z21},~{z22},~{z23},~{z24},~{z25},~{z26},~{z27},~{z28},~{z29},~{z30},~{z31}"()
  call void @baz(<n x 2 x double> %splat)
  ret void
}

define void @dupdouble1() {
; CHECK-LABEL: dupdouble1:
; CHECK-NOT: str z0
; CHECK: fmov z0.d, #1.00000000
; CHECK-NOT: str z0
; CHECK: bl baz
; CHECK-NOT: ldr z0
; CHECK: fmov z0.d, #1.00000000
; CHECK-NOT: ldr z0
; CHECK: bl baz
; CHECK: ret
  %dval = insertelement <n x 2 x double> undef, double 1.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %dval,
                         <n x 2 x double> undef,
                         <n x 2 x i64> zeroinitializer
  call void @baz(<n x 2 x double> %splat)
  call void asm sideeffect "", "~{z0},~{z1},~{z2},~{z3},~{z4},~{z5},~{z6},~{z7},~{z8},~{z9},~{z10},~{z11},~{z12},~{z13},~{z14},~{z15},~{z16},~{z17},~{z18},~{z19},~{z20},~{z21},~{z22},~{z23},~{z24},~{z25},~{z26},~{z27},~{z28},~{z29},~{z30},~{z31}"()
  call void @baz(<n x 2 x double> %splat)
  ret void
}
