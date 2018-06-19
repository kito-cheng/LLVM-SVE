; RUN: llc -mtriple=aarch64-linux-gnu -aarch64-vector-pcs=16 < %s | FileCheck %s

; Check that correct registers are preserved by the callee
; when using aarch64 vector pcs. We should expect registers
; Q16 and Q23 to be preserved, but Q15 is not.

define aarch64_vector_pcs void @callee(){
; CHECK-LABEL: callee:
; CHECK-NOT: q15
; CHECK: stp q23, q16
call void asm sideeffect "nop", "~{q15},~{q16},~{q23}"() nounwind
ret void
}

define <2 x i64> @caller(<2 x i64>* %y){
; CHECK-LABEL: caller:
; CHECK: ldr q16, [x0]
; CHECK-NEXT: bl callee
%ldv = load volatile <2 x i64>, <2 x i64>* %y, align 16
call aarch64_vector_pcs void @callee()
ret <2 x i64> %ldv
}
