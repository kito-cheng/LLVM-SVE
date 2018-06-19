; The tests below test the allocation of 128bit callee-saves
; on the stack, specifically their offsets.

; Padding of GPR64-registers is needed to ensure 16 byte alignment of
; the stack pointer after the GPR64/FPR64 block (which is also needed
; for the FPR128 saves when present).

; The emergency stack slot is created by LLVM when a register may be
; needed to calculate a stack-address and there is no free register,
; it can then spill any register to the stack, use it to materialise an
; address, do the stack access, and restore the register afterwards.
; The reason this is explicitly mentioned in these tests is because that
; stack slot should be allocated as close to the stackpointer as possible
; so to always be able to access it using SP+immediate.

; RUN: llc -mtriple=aarch64-linux-gnu -aarch64-vector-pcs=8 < %s | FileCheck %s

; Check that the alignment gap for the 8-byte x19 is padded
; with another 8 bytes. The CSR region will look like this:
;    +-------------------+
;    |/////padding///////|        (8 bytes)
;    |       X19         |        (8 bytes)
;    +-------------------+ <-  SP -16
;    |     Q10, Q11      |        (32 bytes)
;    +-------------------+ <-  SP -48
define aarch64_vector_pcs void @test_q10_q11_x19() nounwind {
; CHECK-LABEL: test_q10_q11_x19
; CHECK:      stp     q11, q10, [sp, #-48]!
; CHECK-NEXT: str     x19,      [sp, #32]
  call void asm sideeffect "nop", "~{x19}"()
  call void asm sideeffect "nop", "~{q10},~{q11}"()
  ret void
}

;    +-------------------+
;    |     X19, X20      |        (16 bytes)
;    +-------------------+ <-  SP -16
;    |     Q10, Q11      |        (32 bytes)
;    +-------------------+ <-  SP -48
define aarch64_vector_pcs void @test_q10_q11_x19_x20() nounwind {
; CHECK-LABEL: test_q10_q11_x19_x20
; CHECK:      stp     q11, q10, [sp, #-48]!
; CHECK-NEXT: stp     x20, x19, [sp, #32]
  call void asm sideeffect "nop", "~{x19},~{x20}"()
  call void asm sideeffect "nop", "~{q10},~{q11}"()
  ret void
}

; Check that the alignment gap is padded with another 8 bytes.
; The CSR region will look like this:
;    +-------------------+
;    |     X19, X20      |        (16 bytes)
;    +-------------------+ <-  SP -16
;    |/////padding///////|        (8 bytes)
;    |        X21        |        (8 bytes)
;    +-------------------+ <-  SP -32
;    |     Q10, Q11      |        (32 bytes)
;    +-------------------+ <-  SP -64
define aarch64_vector_pcs void @test_q10_q11_x19_x20_x21() nounwind {
; CHECK-LABEL: test_q10_q11_x19_x20_x21
; CHECK:      stp     q11, q10, [sp, #-64]!
; CHECK-NEXT: str     x21,      [sp, #32]
; CHECK-NEXT: stp     x20, x19, [sp, #48]
  call void asm sideeffect "nop", "~{x19},~{x20},~{x21}"()
  call void asm sideeffect "nop", "~{q10},~{q11}"()
  ret void
}

; Test with more callee saves, which triggers 'BigStack' in
; AArch64FrameLowering which in turn causes an emergency spill
; slot to be allocated. The emergency spill slot must be allocated
; as close as possible to SP, so at SP + 0.
;    +-------------------+
;    |     X19..X30      |        (96 bytes)
;    +-------------------+ <-  SP -96
;    |     Q8..Q31       |        (384 bytes)
;    +-------------------+ <-  SP -480
;    |   emergency slot  |        (16 bytes)
;    +-------------------+ <-  SP -496
define aarch64_vector_pcs void @test_q8_to_q31_x19_to_x30() nounwind {
; CHECK-LABEL: test_q8_to_q31_x19_to_x30
; CHECK:       sub     sp, sp, #496
; CHECK-NEXT:  stp     q31, q30, [sp, #16]     // 32-byte Folded Spill
; CHECK-NEXT:  stp     q29, q28, [sp, #48]     // 32-byte Folded Spill
; CHECK-NEXT:  stp     q27, q26, [sp, #80]     // 32-byte Folded Spill
; CHECK-NEXT:  stp     q25, q24, [sp, #112]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q23, q22, [sp, #144]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q21, q20, [sp, #176]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q19, q18, [sp, #208]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q17, q16, [sp, #240]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q15, q14, [sp, #272]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q13, q12, [sp, #304]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q11, q10, [sp, #336]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q9, q8, [sp, #368]      // 32-byte Folded Spill
; CHECK-NEXT:  stp     x28, x27, [sp, #400]    // 16-byte Folded Spill
; CHECK-NEXT:  stp     x26, x25, [sp, #416]    // 16-byte Folded Spill
; CHECK-NEXT:  stp     x24, x23, [sp, #432]    // 16-byte Folded Spill
; CHECK-NEXT:  stp     x22, x21, [sp, #448]    // 16-byte Folded Spill
; CHECK-NEXT:  stp     x20, x19, [sp, #464]    // 16-byte Folded Spill
; CHECK-NEXT:  stp     x29, x30, [sp, #480]    // 16-byte Folded Spill
  call void asm sideeffect "nop", "~{x19},~{x20},~{x21},~{x22},~{x23},~{x24},~{x25},~{x26},~{x27},~{x28},~{lr},~{fp}"()
  call void asm sideeffect "nop", "~{q8},~{q9},~{q10},~{q11},~{q12},~{q13},~{q14},~{q15},~{q16},~{q17},~{q18},~{q19},~{q20},~{q21},~{q22},~{q23},~{q24},~{q25},~{q26},~{q27},~{q28},~{q29},~{q30},~{q31}"()
  ret void
}


; When the total stack size >= 512, it will use the pre-increment
; rather than the 'sub sp, sp, <size>'. This also tests that the
; emergency slot is allocated at SP + 0.
;    +-------------------+
;    |     X19..X30      |        (96 bytes)
;    +-------------------+ <-  SP -96
;    |     Q8..Q31       |        (384 bytes)
;    +-------------------+ <-  SP -480
;    |       'obj'       |        (32 bytes)
;    +-------------------+ <-  SP -512
;    |   emergency slot  |        (16 bytes)
;    +-------------------+ <-  SP -528
define aarch64_vector_pcs void @test_q8_to_q31_x19_to_x30_preinc() nounwind {
; CHECK-LABEL: test_q8_to_q31_x19_to_x30_preinc
; CHECK:       stp     q31, q30, [sp, #-480]!  // 32-byte Folded Spill
; CHECK-NEXT:  stp     q29, q28, [sp, #32]     // 32-byte Folded Spill
; CHECK-NEXT:  stp     q27, q26, [sp, #64]     // 32-byte Folded Spill
; CHECK-NEXT:  stp     q25, q24, [sp, #96]     // 32-byte Folded Spill
; CHECK-NEXT:  stp     q23, q22, [sp, #128]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q21, q20, [sp, #160]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q19, q18, [sp, #192]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q17, q16, [sp, #224]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q15, q14, [sp, #256]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q13, q12, [sp, #288]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q11, q10, [sp, #320]    // 32-byte Folded Spill
; CHECK-NEXT:  stp     q9, q8, [sp, #352]      // 32-byte Folded Spill
; CHECK-NEXT:  stp     x28, x27, [sp, #384]    // 16-byte Folded Spill
; CHECK-NEXT:  stp     x26, x25, [sp, #400]    // 16-byte Folded Spill
; CHECK-NEXT:  stp     x24, x23, [sp, #416]    // 16-byte Folded Spill
; CHECK-NEXT:  stp     x22, x21, [sp, #432]    // 16-byte Folded Spill
; CHECK-NEXT:  stp     x20, x19, [sp, #448]    // 16-byte Folded Spill
; CHECK-NEXT:  stp     x29, x30, [sp, #464]    // 16-byte Folded Spill
; CHECK-NEXT:  sub     sp, sp, #48             // =48
; CHECK-NEXT:  mov     w[[IMM:[0-9]+]], #42
; CHECK-NEXT:  strb    w[[IMM]], [sp, #16]
; CHECK-NEXT:  strb    w[[IMM]], [sp, #47]
  %obj = alloca [ 32 x i8 ]
  %first = getelementptr [ 32 x i8 ], [ 32 x i8 ]* %obj, i32 0, i32 0
  %last  = getelementptr [ 32 x i8 ], [ 32 x i8 ]* %obj, i32 0, i32 31
  store i8 42, i8* %first
  store i8 42, i8* %last
  call void asm sideeffect "nop", "~{x19},~{x20},~{x21},~{x22},~{x23},~{x24},~{x25},~{x26},~{x27},~{x28},~{lr},~{fp}"()
  call void asm sideeffect "nop", "~{q8},~{q9},~{q10},~{q11},~{q12},~{q13},~{q14},~{q15},~{q16},~{q17},~{q18},~{q19},~{q20},~{q21},~{q22},~{q23},~{q24},~{q25},~{q26},~{q27},~{q28},~{q29},~{q30},~{q31}"()
  ret void
}
