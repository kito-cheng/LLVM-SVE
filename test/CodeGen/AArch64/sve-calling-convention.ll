; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s


define i64 @caller_plain_callee_plain(i64 %a) {
; CHECK-LABEL: caller_plain_callee_plain:
; CHECK-NOT: str z
; CHECK: bl callee_plain
; CHECK-NOT: ldr z
; CHECK: ret
  %val = call i64 @callee_plain(i64 %a)
  ret i64 %val
}

define i32 @caller_plain_callee_sve(i32 %a) {
; CHECK-LABEL: caller_plain_callee_sve:
; CHECK-NOT: str z
; CHECK: index z0
; CHECK-NOT: str z
; CHECK: bl callee_with_svec_arg
; CHECK-NOT: ldr z
; CHECK: ret
  %1 = insertelement <n x 4 x i32> undef, i32 %a, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %idx = add <n x 4 x i32> %5, %3
  %val = call i32 @callee_with_svec_arg(<n x 4 x i32> %idx)
  ret i32 %val
}

define <n x 2 x i64> @caller_sve_callee_plain(i64 %a) {
; CHECK-LABEL: caller_sve_callee_plain:
; CHECK: str z8
; CHECK: str z31
; CHECK: str p4
; CHECK: str p15
; CHECK: bl callee_plain
; CHECK: mov z0.d, x0
; CHECK: ldr p4
; CHECK: ldr p15
; CHECK: ldr z8
; CHECK: ldr z31
; CHECK: ret
  %val = call i64 @callee_plain(i64 %a)
  %elt = insertelement <n x 2 x i64> undef, i64 %val, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %splat
}

;; Note: this test is somewhat fragile in that we're not quite sure which
;; preserved register will be chosen for the load before the call, but
;; for now the register allocator chooses the lowest numbered preserved
;; register. Fix this if we get nice ranges for checking expressions.
define <n x 2 x i64> @caller_sve_callee_sve(<n x 2 x i64>* %a, i64 %b, i64 %c) {
; CHECK-LABEL: caller_sve_callee_sve:
; CHECK: str z8, [sp]
; CHECK: ld1d {z8.d}, p0/z, [x0]
; CHECK-NOT: str z
; CHECK: mov x0, x2
; CHECK-NOT: str z
; CHECK: bl callee_with_svec_return
; CHECK-NOT: ldr z
; CHECK: add z0.d, z8.d, z0.d
; CHECK: ldr z8, [sp]
; CHECK-NOT: ldr z
; CHECK: ret
  %ldv = load volatile <n x 2 x i64>, <n x 2 x i64>* %a, align 4
  %val = call <n x 2 x i64> @callee_with_svec_return(i64 %c)
  %add = add <n x 2 x i64> %ldv, %val
  ret <n x 2 x i64> %add
}

%struct.sizeless = type { <n x 2 x i64>, <n x 4 x i32> }

define i32 @caller_sve_struct_callee_plain(%struct.sizeless %data) {
; CHECK-LABEL: caller_sve_struct_callee_plain:
; CHECK: str z8
; CHECK: str z31
; CHECK: str p4
; CHECK: str p15
; CHECK-DAG: fmov x0, d0
; CHECK-DAG: str z1
; CHECK: bl callee_plain
; CHECK: ldr z0
; CHECK: fmov w0, s0
; CHECK: ldr p4
; CHECK: ldr p15
; CHECK: ldr z8
; CHECK: ldr z31
; CHECK: ret
  %vec64 = extractvalue %struct.sizeless %data, 0
  %scalar64 = extractelement <n x 2 x i64> %vec64, i32 0
  %unused = call i64 @callee_plain(i64 %scalar64)
  %vec32 = extractvalue %struct.sizeless %data, 1
  %scalar32 = extractelement <n x 4 x i32> %vec32, i32 0
  ret i32 %scalar32
}

declare i64 @callee_plain(i64)
declare i32 @callee_with_svec_arg(<n x 4 x i32> %vec)
declare <n x 2 x i64> @callee_with_svec_return(i64)
