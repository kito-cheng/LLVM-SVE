; RUN: not llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s  2> %t
; RUN: FileCheck --check-prefix=CHECK-ERRORS < %t %s

; Check for at least one invalid constant.
; CHECK-ERRORS: error: couldn't allocate input reg for constraint 'r'

define <n x 4 x float> @funcB4(<n x 4 x i32> %in) nounwind {
entry:
  %0 = tail call <n x 4 x float> asm sideeffect "ptrue p0.s, #1 \0Afabs $0.s, p0/m, $1.s \0A", "=w,r"(<n x 4 x i32> %in) nounwind
  ret <n x 4 x float> %0
}
