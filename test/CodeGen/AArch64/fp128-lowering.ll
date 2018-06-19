; RUN: llc -mtriple=aarch64--linux-gnu < %s | FileCheck %s

define i1 @fp128cmp(i8* %in1, i8* %in2) {
; CHECK-LABEL: fp128cmp
; CHECK: bl __netf2
; CHECK: bl __eqtf2
; CHECK-DAG: bl __eqtf2
; CHECK-DAG: bl __netf2
  %p1 = bitcast i8* %in1 to fp128*
  %a1 = load fp128, fp128* %p1, align 16
  %p2 = bitcast i8* %in2 to fp128*
  %a2 = load fp128, fp128* %p2, align 16
  %b1 = fcmp une fp128 %a1, 0xL00000000000000000000000000000000
  %b2 = fcmp oeq fp128 %a2, 0xL00000000000000000000000000000000
  %c1 = xor i1 %b1, true
  %d = or i1 %b2, %c1
  %c2 = xor i1 %b2, true
  %e = or i1 %b1, %c2
  %res = and i1 %d, %e
  ret i1 %res
}

define i1 @fp128cmp_simple(i8* %in1, i8* %in2) {
; CHECK-LABEL: fp128cmp_simple
; CHECK: bl __netf2
; CHECK: bl __eqtf2
  %p1 = bitcast i8* %in1 to fp128*
  %p2 = bitcast i8* %in2 to fp128*
  %A = load fp128, fp128* %p1, align 16
  %B = load fp128, fp128* %p2, align 16
  %X = fcmp une fp128 %A, 0xL00000000000000000000000000000000
  %Y = fcmp oeq fp128 %B, 0xL00000000000000000000000000000000
  %W = or i1 %X, %Y
  ret i1 %W
}
