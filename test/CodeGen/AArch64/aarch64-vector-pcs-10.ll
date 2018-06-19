; RUN: llc -mtriple=aarch64-linux-gnu -aarch64-vector-pcs=10 < %s | FileCheck %s

; Check that correct registers are preserved by the callee
; when using aarch64 vector pcs. We should expect registers
; Q10 and Q23 to be preserved, but Q9 is not.

define aarch64_vector_pcs void @callee(){
; CHECK-LABEL: callee:
; CHECK-NOT: q9
; CHECK: stp q23, q10
call void asm sideeffect "nop", "~{q9},~{q10},~{q23}"() nounwind
ret void
}

define <2 x i64> @caller(<2 x i64>* %y){
; CHECK-LABEL: caller:
; CHECK: ldr q10, [x0]
; CHECK-NEXT: bl callee
%ldv = load volatile <2 x i64>, <2 x i64>* %y, align 16
call aarch64_vector_pcs void @callee()
ret <2 x i64> %ldv
}
