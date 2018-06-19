; RUN: llc -mtriple=arm64 -fp-contract=fast -o - %s | FileCheck %s
; RUN: llc -mtriple=arm64 -o - %s | FileCheck %s --check-prefix=FATTR

define double @test_fma_0(double %a, double %b, double %c) {
; CHECK-LABEL: test_fma_0:
; CHECK: fmadd
; FATTR-NOT: fmadd
  %mul = fmul double %a, %b
  %add = fadd double %c, %mul
  ret double %add
}

define double @test_fma_1(double %a, double %b, double %c) "fp-contract"="fast" {
; CHECK-LABEL: test_fma_1:
; CHECK: fmadd
; FATTR: fmadd
  %mul = fmul double %a, %b
  %add = fadd double %c, %mul
  ret double %add
}
