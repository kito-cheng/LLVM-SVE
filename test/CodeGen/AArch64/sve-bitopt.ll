; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 2 x i1> @and_3op_opt(<n x 2 x i1> %a, <n x 2 x i1> %b, <n x 2 x i1> %c) {
; CHECK-LABEL: @and_3op_opt
; CHECK: and p0.b, p0/z, p1.b, p2.b
  %and1 = and <n x 2 x i1> %a, %b
  %and2 = and <n x 2 x i1> %and1, %c
  ret <n x 2 x i1> %and2
}

define <n x 2 x i1> @and_3op_rev_opt(<n x 2 x i1> %a, <n x 2 x i1> %b, <n x 2 x i1> %c) {
; CHECK-LABEL: @and_3op_rev_opt
; CHECK: and p0.b, p2/z, p0.b, p1.b
  %and1 = and <n x 2 x i1> %a, %b
  %and2 = and <n x 2 x i1> %c, %and1
  ret <n x 2 x i1> %and2
}

define <n x 2 x i1> @or_not_opt(<n x 2 x i1> %a) {
; CHECK-LABEL: @or_not_opt
; CHECK: ptrue p0.d
; CHECK-NEXT: ret
  %true = shufflevector <n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %not = xor <n x 2 x i1> %a, %true
  %or = or <n x 2 x i1> %a, %not
  ret <n x 2 x i1> %or
}

define <n x 2 x i1> @or_not_rev_opt(<n x 2 x i1> %a) {
; CHECK-LABEL: @or_not_rev_opt
; CHECK: ptrue p0.d
; CHECK-NEXT: ret
  %true = shufflevector <n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %not = xor <n x 2 x i1> %a, %true
  %or = or <n x 2 x i1> %not, %a
  ret <n x 2 x i1> %or
}
