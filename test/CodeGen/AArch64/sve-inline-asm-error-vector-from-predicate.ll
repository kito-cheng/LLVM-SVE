; RUN: not llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s  2> %t
; RUN: FileCheck --check-prefix=CHECK-ERRORS < %t %s

; Check for at least one invalid constant.
; CHECK-ERRORS: error: couldn't allocate input reg for constraint 'Upa'

define <n x 16 x i1> @funcB2(<n x 2 x i64> %in) nounwind {
entry:
  %0 = tail call <n x 16 x i1> asm sideeffect "mov $0.b, $1.b \0A", "=@3Upa,@3Upa"(<n x 2 x i64> %in) nounwind
  ret <n x 16 x i1> %0
}
