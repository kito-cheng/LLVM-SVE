; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -aarch64-sve-postvec=false < %s | FileCheck %s
; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -O0 -aarch64-sve-postvec=false < %s | FileCheck %s -check-prefix=CHECKO0

%vtype = type <n x 8 x i16>
%ptype = type <n x 16 x i1>
%itype = type i64
%svint32x2_t = type { <n x 4 x i32>, <n x 4 x i32> }

@iread  = external global %itype
@iwrite = external global %itype
@pread  = external global %ptype
@pwrite = external global %ptype
@vread  = external global %vtype
@vwrite = external global %vtype

;========================================================================
; DESCRIPTION:
; Test layout of SP addressable regions:
;   [prev_frame][VEC, PRED]
;                         ^
;                         SP
; VARIANT:
; o  2 Locals (1 predicate, 1 vector)
; o  SVE Region is SP Addressable
; o  No Framepointer
; o  No SVE register Saves
;
; Predicates are padded so that the total SVE region is a multiple of
; 8 predicate elements in size, leading to a static alignment.
;
; o (SVE Vector) V0 is allocated at offset '1' (#Vectors) from SP
; o (Pred  Vector) P0 is allocated at offset '0' (#Predicates) from SP
; o Because we do not have a FP, the epilogue adds 2 SVE elements to
;   the SP in the epilogue.
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
define void @spillfill_1p1v_sp_nofp_nosaves() {
; CHECK-LABEL: spillfill_1p1v_sp_nofp_nosaves
; CHECK:       addvl sp, sp, #-2
; CHECK-NOT:   sub sp,
  %p0 = alloca %ptype
  %v0 = alloca %vtype

; CHECK-DAG: adrp [[VLDADDR:x[0-9]+]], vread
; CHECK-DAG: ld1h {[[VLD:z[0-9]+]].h}, {{p[0-9]+}}/z, {{\[}}[[VLDADDR]]
; CHECK-DAG: st1h {[[VLD]].h}, {{p[0-9]+}}, [sp, #1, mul vl]
  %1 = load %vtype, %vtype* @vread
  store %vtype %1, %vtype* %v0

; CHECK-DAG: adrp [[PLDADDR:x[0-9]+]], pread
; CHECK-DAG: ldr [[PLD:p[0-9]+]], {{\[}}[[PLDADDR]]]
; CHECK-DAG: str [[PLD]], [sp]
  %2 = load %ptype, %ptype* @pread
  store %ptype %2, %ptype* %p0

; CHECK: addvl sp, sp, #2
; CHECK: ret
  ret void
}

;========================================================================
; DESCRIPTION:
; Test function (pro|epi)logue saving and restoring CSR
;   [prev_frame][VEC, PRED][Non-SVE]
;                                  ^
;                                  SP
; VARIANT:
; o  3 Locals (1 predicate, 1 vector, 1 scalar)
; o  SVE Region is SP Addressable
; o  No Framepointer
; o  1 Vector Callee Saved Register
;
; To save the vector register, the prologue first subtracts 2 VL
; (1 local, 1 save) from the SP and stores it right above the SP.
; It then allocates the Predicate region, followed by scalar region.
; To reload the vector register, the scalar region is deallocated
; first. Then the vector is reloaded from position '2' (second vector
; on the stack), after which both pred+vec regions are deallocated
; in one instruction (addvl sp, sp, #3).
;
; o (SVE Vector) V0 is allocated at offset '2' (#Vectors) from SP
; o (SVE Vector) CSR is allocated at offset '1' (#Vectors) from SP
; o (Pred  Vector) P0 is allocated at offset '0' (#Predicates) from SP
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
define %vtype @spillfill_1p1v1i_sp_nofp_1save() {
; CHECKO0-LABEL: spillfill_1p1v1i_sp_nofp_1save
; CHECKO0:    addvl  sp, sp, #-18
; CHECKO0:    str    {{z[0-9]+}}, [sp, #1, mul vl]
; CHECKO0:    addvl  sp, sp, #-1
; CHECKO0:    sub    sp, sp, #16
  %p0 = alloca %ptype
  %v0 = alloca %vtype
  %i0 = alloca i64

  ; Store at least one vector CSR
  %1 = load volatile %vtype , %vtype *@vread
  %2 = load volatile %vtype , %vtype *@vread
  %3 = load volatile %vtype , %vtype *@vread
  %4 = load volatile %vtype , %vtype *@vread
  %5 = load volatile %vtype , %vtype *@vread
  %6 = load volatile %vtype , %vtype *@vread
  %7 = load volatile %vtype , %vtype *@vread
  %8 = load volatile %vtype , %vtype *@vread
  %9 = load volatile %vtype , %vtype *@vread
  %10 = load volatile %vtype , %vtype *@vread
  %11 = load volatile %vtype , %vtype *@vread
  %12 = load volatile %vtype , %vtype *@vread
  %13 = load volatile %vtype , %vtype *@vread
  %14 = load volatile %vtype , %vtype *@vread
  %15 = load volatile %vtype , %vtype *@vread
  %16 = load volatile %vtype , %vtype *@vread
  %17 = load volatile %vtype , %vtype *@vread
  %18 = load volatile %vtype , %vtype *@vread
  %19 = load volatile %vtype , %vtype *@vread
  %20 = load volatile %vtype , %vtype *@vread
  %21 = load volatile %vtype , %vtype *@vread
  %22 = load volatile %vtype , %vtype *@vread
  %23 = load volatile %vtype , %vtype *@vread
  %24 = load volatile %vtype , %vtype *@vread
  %25 = load volatile %vtype , %vtype *@vread
  store volatile %vtype %1, %vtype* @vwrite
  store volatile %vtype %2, %vtype* @vwrite
  store volatile %vtype %3, %vtype* @vwrite
  store volatile %vtype %4, %vtype* @vwrite
  store volatile %vtype %5, %vtype* @vwrite
  store volatile %vtype %6, %vtype* @vwrite
  store volatile %vtype %7, %vtype* @vwrite
  store volatile %vtype %8, %vtype* @vwrite
  store volatile %vtype %9, %vtype* @vwrite
  store volatile %vtype %10, %vtype* @vwrite
  store volatile %vtype %11, %vtype* @vwrite
  store volatile %vtype %12, %vtype* @vwrite
  store volatile %vtype %13, %vtype* @vwrite
  store volatile %vtype %14, %vtype* @vwrite
  store volatile %vtype %15, %vtype* @vwrite
  store volatile %vtype %16, %vtype* @vwrite
  store volatile %vtype %17, %vtype* @vwrite
  store volatile %vtype %18, %vtype* @vwrite
  store volatile %vtype %19, %vtype* @vwrite
  store volatile %vtype %20, %vtype* @vwrite
  store volatile %vtype %21, %vtype* @vwrite
  store volatile %vtype %22, %vtype* @vwrite
  store volatile %vtype %23, %vtype* @vwrite
  store volatile %vtype %24, %vtype* @vwrite
  store volatile %vtype %25, %vtype* @vwrite

  %26 = load %vtype, %vtype* @vread
  store %vtype %26, %vtype* %v0

  %27 = load %ptype, %ptype* @pread
  store %ptype %27, %ptype* %p0

  %28 = load i64, i64* @iread
  store i64 %28, i64* %i0

; CHECKO0: add	    sp, sp, #16
; CHECKO0: ldr     z8, [sp, #18, mul vl]
; CHECKO0: addvl   sp, sp, #19
; CHECKO0: ret
  ret %vtype %26
}

;========================================================================
; DESCRIPTION:
; Test function (pro|epi)logue saving and restoring CSR where the PRED region
; is very large, so that the immediate field cannot reach the vector regsave
; in one try.
;
;   [prev_frame][VEC, --------PRED------------ ][Non-SVE]
;               ^                                       ^
;              TMP                                      SP
; VARIANT:
; o  3 Locals (1 predicate array of 256 elements, 1 vector, 1 scalar)
; o  SVE Region is SP Addressable
; o  No Framepointer
; o  1 Vector Save
; o  1 emergency spill slot (+ padding) because a scratch register
;    is needed to calculate base of SVE region to access a vector
;
; To restore the vector regsave while deallocating the VEC and PRED
; regions, first a temporary address is calculated (TMP). Then TMP is
; used to reload the regsave, after which the VEC and PRED regions are
; deallocated by moving TMP to SP.
;
; The jump over the predicate region to access the vector local happens
; when in AArch64RegisterInfo.cpp:eliminateFrameIndex() the call to
; 'rewriteAArch64FrameIndex()' leaves a remaining offset (because it does not
; fit the load/store' immediate field) and therefore requires an explicit
; scratch register to calculate the address.
;
; o (SVE Vector) CSR is allocated at offset
;     '32 bytes +   257 (#Vectors)' from SP
; o (SVE Vector) V0 is allocated at offset
;     '32 bytes +   256 (#Vectors)' from SP
; o (Pred  Vector Array) P0 is allocated at offsets
;     '32 bytes + 0-2047 (#Vectors)' from SP
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
define %vtype @spillfill_256p1v1i_sp_nofp_1vsave() {
; CHECKO0-LABEL: spillfill_256p1v1i_sp_nofp_1vsave
; CHECKO0-DAG:    addvl  sp, sp, #-2
; CHECKO0-DAG:    str    [[REGSAVE:z[0-9]+]], [sp, #17, mul vl]
; CHECKO0-DAG:    addvl   sp, sp, #-32
; CHECKO0-DAG:    addvl   sp, sp, #-32
; CHECKO0-DAG:    addvl   sp, sp, #-32
; CHECKO0-DAG:    addvl   sp, sp, #-32
; CHECKO0-DAG:    addvl   sp, sp, #-32
; CHECKO0-DAG:    addvl   sp, sp, #-32
; CHECKO0-DAG:    addvl   sp, sp, #-32
; CHECKO0-DAG:    addvl   sp, sp, #-32
; CHECKO0-DAG:    str     x28, [sp, #-16]!
; CHECKO0-DAG:    sub    sp, sp, #16
  %p0 = alloca [ 256 x %ptype ]
  %v0 = alloca %vtype
  %i0 = alloca i64

  ; Store at least one vector CSR
  %1 = load volatile %vtype , %vtype *@vread
  %2 = load volatile %vtype , %vtype *@vread
  %3 = load volatile %vtype , %vtype *@vread
  %4 = load volatile %vtype , %vtype *@vread
  %5 = load volatile %vtype , %vtype *@vread
  %6 = load volatile %vtype , %vtype *@vread
  %7 = load volatile %vtype , %vtype *@vread
  %8 = load volatile %vtype , %vtype *@vread
  %9 = load volatile %vtype , %vtype *@vread
  %10 = load volatile %vtype , %vtype *@vread
  %11 = load volatile %vtype , %vtype *@vread
  %12 = load volatile %vtype , %vtype *@vread
  %13 = load volatile %vtype , %vtype *@vread
  %14 = load volatile %vtype , %vtype *@vread
  %15 = load volatile %vtype , %vtype *@vread
  %16 = load volatile %vtype , %vtype *@vread
  %17 = load volatile %vtype , %vtype *@vread
  %18 = load volatile %vtype , %vtype *@vread
  %19 = load volatile %vtype , %vtype *@vread
  %20 = load volatile %vtype , %vtype *@vread
  %21 = load volatile %vtype , %vtype *@vread
  %22 = load volatile %vtype , %vtype *@vread
  %23 = load volatile %vtype , %vtype *@vread
  %24 = load volatile %vtype , %vtype *@vread
  %25 = load volatile %vtype , %vtype *@vread
  store volatile %vtype %1, %vtype* @vwrite
  store volatile %vtype %2, %vtype* @vwrite
  store volatile %vtype %3, %vtype* @vwrite
  store volatile %vtype %4, %vtype* @vwrite
  store volatile %vtype %5, %vtype* @vwrite
  store volatile %vtype %6, %vtype* @vwrite
  store volatile %vtype %7, %vtype* @vwrite
  store volatile %vtype %8, %vtype* @vwrite
  store volatile %vtype %9, %vtype* @vwrite
  store volatile %vtype %10, %vtype* @vwrite
  store volatile %vtype %11, %vtype* @vwrite
  store volatile %vtype %12, %vtype* @vwrite
  store volatile %vtype %13, %vtype* @vwrite
  store volatile %vtype %14, %vtype* @vwrite
  store volatile %vtype %15, %vtype* @vwrite
  store volatile %vtype %16, %vtype* @vwrite
  store volatile %vtype %17, %vtype* @vwrite
  store volatile %vtype %18, %vtype* @vwrite
  store volatile %vtype %19, %vtype* @vwrite
  store volatile %vtype %20, %vtype* @vwrite
  store volatile %vtype %21, %vtype* @vwrite
  store volatile %vtype %22, %vtype* @vwrite
  store volatile %vtype %23, %vtype* @vwrite
  store volatile %vtype %24, %vtype* @vwrite
  store volatile %vtype %25, %vtype* @vwrite

; CHECKO0-DAG: adrp    [[BASE:x[0-9]+]], vread
; CHECKO0-DAG: add     [[BASE]], [[BASE]], :lo12:vread
; CHECKO0-DAG: ld1h    {[[VAL:z[0-9]+]].h}, {{p[0-9]+}}/z, {{\[}}[[BASE]]
; CHECKO0-DAG: add     [[BP:x[0-9]+]], sp, #32
; CHECKO0-DAG: addvl   [[TMP1:x[0-9]+]], [[BP]], #31
; CHECKO0-DAG: addvl   [[TMP2:x[0-9]+]], [[TMP1]], #31
; CHECKO0-DAG: addvl   [[TMP3:x[0-9]+]], [[TMP2]], #31
; CHECKO0-DAG: addvl   [[TMP4:x[0-9]+]], [[TMP3]], #31
; CHECKO0-DAG: addvl   [[TMP5:x[0-9]+]], [[TMP4]], #31
; CHECKO0-DAG: addvl   [[TMP6:x[0-9]+]], [[TMP5]], #31
; CHECKO0-DAG: addvl   [[TMP7:x[0-9]+]], [[TMP6]], #31
; CHECKO0-DAG: addvl   [[TMP8:x[0-9]+]], [[TMP7]], #31
; CHECKO0-DAG: addvl   [[TMP9:x[0-9]+]], [[TMP8]], #1
; CHECKO0-DAG: st1h    {[[VAL]].h}, {{p[0-9]+}}, {{\[}}[[TMP9]], #7, mul vl]
  %26 = load %vtype, %vtype* @vread
  store %vtype %26, %vtype* %v0

  %27 = load i64, i64* @iread
  store i64 %27, i64* %i0

; CHECKO0-DAG: add     sp, sp, #16
; CHECKO0-DAG: addvl   [[TMP2:x[0-9]+]], sp, #31
; CHECKO0-DAG: addvl   [[TMP2:x[0-9]+]], [[TMP2]], #31
; CHECKO0-DAG: addvl   [[TMP2:x[0-9]+]], [[TMP2]], #31
; CHECKO0-DAG: addvl   [[TMP2:x[0-9]+]], [[TMP2]], #31
; CHECKO0-DAG: addvl   [[TMP2:x[0-9]+]], [[TMP2]], #31
; CHECKO0-DAG: addvl   [[TMP2:x[0-9]+]], [[TMP2]], #31
; CHECKO0-DAG: addvl   [[TMP2:x[0-9]+]], [[TMP2]], #31
; CHECKO0-DAG: addvl   [[TMP2:x[0-9]+]], [[TMP2]], #31
; CHECKO0-DAG: addvl   [[TMP2:x[0-9]+]], [[TMP2]], #26
; CHECKO0-DAG: ldr     [[REGSAVE]], {{\[}}[[TMP2]], #-1, mul vl]
; CHECKO0-DAG: mov     sp, [[TMP2]]
; CHECKO0-DAG: ret
  ret %vtype %26
}

;========================================================================
; DESCRIPTION:
; Test layout of SP addressable regions together w/ non-SVE locals:
;   [prev_frame][VEC, PRED][Non-SVE]
;                                  ^
;                                  SP
; VARIANT:
; o  4 Locals (1 predicate, 1 vector, 2 non-SVE)
; o  2 extra non-SVE callee saved registers are spilled for register
;    scavenging
; o  SVE Region is SP Addressable
; o  No Framepointer
;
; o (SVE Vector) V0 is allocated at offset
;       '1 (#Vectors) + 32 bytes' from SP
; o (Pred  Vector) P0 is allocated at offset
;       '0 (#Predicates) + 32 bytes' from SP
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
define void @spillfill_1p1v2i_sp_nofp_nosaves() {
; CHECK-LABEL: spillfill_1p1v2i_sp_nofp_nosaves
; CHECK: addvl  sp, sp, #-2
; CHECK: str    x28, [sp, #-16]!
; CHECK: sub    sp, sp, #16
  %p0 = alloca %ptype
  %v0 = alloca %vtype
  %i0 = alloca i64
  %i1 = alloca i64

; CHECK-DAG: add [[SVE_BASE:x[0-9]+]], sp, #32
; CHECK-DAG: adrp [[VLDADDR:x[0-9]+]], vread
; CHECK-DAG: ld1h {[[VLD:z[0-9]+]].h}, {{p[0-9]+}}/z, {{\[}}[[VLDADDR]]
; CHECK-DAG: st1h {[[VLD]].h}, {{p[0-9]+}}, {{\[}}[[SVE_BASE]], #1, mul vl]
  %1 = load %vtype, %vtype* @vread
  store %vtype %1, %vtype* %v0

; CHECK-DAG: adrp [[PLDADDR:x[0-9]+]], pread
; CHECK-DAG: ldr [[PLD:p[0-9]+]], {{\[}}[[PLDADDR]]]
; CHECK-DAG: str [[PLD]], {{\[x[0-9]+}}]
  %2 = load %ptype, %ptype* @pread
  store %ptype %2, %ptype* %p0

  %3 = load i64, i64* @iread
  store i64 %3, i64* %i0

  %4 = load i64, i64* @iread
  store i64 %4, i64* %i1

; CHECK: str	{{x[0-9]+}}, [sp, #24]
; CHECK: str	{{x[0-9]+}}, [sp, #8]
; CHECK: ldr    x28, [sp], #16
; CHECK: addvl  sp, sp, #2
; CHECK: ret
  ret void
}

;========================================================================
; DESCRIPTION:
; Test the access of arguments coming in on stack in combination with
; SVE regions and the lack of a FramePointer. This requires calculating
; the address of IN_ARG being a combination of an ADDVL (jumping over
; SVE Region), addition of Non-SVE Stack Size and the offset of the
; argument.
;
;   [prev_frame][IN_ARGS][VEC, PRED][Non-SVE]
;                                           ^
;                                           SP
;
; VARIANT:
; o  3 locals (1 vector, 1 predicate, 1 non-SVE)
; o  SVE Region is SP Addressable
; o  Argument on stack is SP Addressable
; o  No Framepointer
; o  2 scalar callee register saves to get extra scratch register for
;    scavenging
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
define void @spillfill_1p1v_1stackarg_sp(i64 %a1, i64 %a2, i64 %a3, i64 %a4,
                                         i64 %a5, i64 %a6, i64 %a7, i64 %a8,
                                         i64 %a9) {
; CHECKO0-LABEL: spillfill_1p1v_1stackarg_sp
; CHECKO0-DAG: addvl   sp, sp, #-[[SVESIZE:[0-9]+]]
  %i0 = alloca i64
  %v0 = alloca %vtype
  %p0 = alloca %ptype

  %1 = load %vtype, %vtype* @vread
  store %vtype %1, %vtype* %v0

  %2 = load %ptype, %ptype* @pread
  store %ptype %2, %ptype* %p0

; CHECKO0-DAG: addvl  [[BASEADDR_A9:x[0-9]+]], sp, #[[SVESIZE]]
; CHECKO0-DAG: ldr    [[LD_A9:x[0-9]+]], {{\[}}[[BASEADDR_A9]], #{{[0-9]+}}]
; CHECKO0-DAG: str    [[LD_A9]], [sp,
  store i64 %a9, i64* %i0

; CHECK00: ret
  ret void
}

;========================================================================
; DESCRIPTION:
; Test the access of arguments coming in on stack in combination with
; SVE regions and a FramePointer. This requires calculating
; the address of IN_ARG being a combination of an ADDVL (jumping over
; SVE Region), addition of Non-SVE Stack Size and the offset of the
; argument.
;
;   [prev_frame][IN_ARGS][VEC, PRED][Non-SVE]
;                         ^^^^^^^^^         ^
;                         includes          SP
;                         framerecord
;
; VARIANT:
; o  3 locals (1 vector, 1 predicate, 1 non-SVE)
; o  SVE Region is FP Addressable
; o  Argument on stack is SP Addressable
; o  No Framepointer
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
declare i8* @llvm.frameaddress(i32)
define i8* @spillfill_1p1v_1stackarg_fp(i64 %a1, i64 %a2, i64 %a3, i64 %a4,
                                         i64 %a5, i64 %a6, i64 %a7, i64 %a8,
                                         i64 %a9) #0 {
; CHECKO0-LABEL: spillfill_1p1v_1stackarg_fp
; CHECKO0-DAG: addvl   sp, sp, #-[[SVESIZE:[0-9]+]]
  %i0 = alloca i64
  %v0 = alloca %vtype
  %p0 = alloca %ptype

  %1 = load %vtype, %vtype* @vread
  store %vtype %1, %vtype* %v0

  %2 = load %ptype, %ptype* @pread
  store %ptype %2, %ptype* %p0

; CHECKO0-DAG: addvl  [[BASEADDR_A9:x[0-9]+]], x29, #[[SVESIZE]]
; CHECKO0-DAG: ldr    [[LD_A9:x[0-9]+]], {{\[}}[[BASEADDR_A9]]]
; CHECKO0-DAG: str    [[LD_A9]], [sp,
  store i64 %a9, i64* %i0

  %fa = call i8* @llvm.frameaddress(i32 0)

; CHECK00: ret
  ret i8* %fa
}

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" }

;========================================================================
; DESCRIPTION:
; Test layout of SP addressable regions together w/ non-SVE locals,
; when a FramePointer is available.
;
;   [prev_frame][VEC, PRED][Non-SVE]
;                          ^
;                          FP
; VARIANT:
; o  5 Locals (1 predicate, 1 vector, 2 non-SVE)
; o  SVE Region is FP Addressable
; o  Non-SVE region is FP Addressable
; o  No Register Saves
;
; o (SVE Vector) V0 is allocated at offset '2 (#Vectors)' from FP
; o (Pred  Vector) P0 is allocated at offset '8 (#Preds)' from FP
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
define void @spillfill_1p1v2i_sp_fp_nosaves() {
; CHECK-LABEL: spillfill_1p1v2i_sp_fp_nosaves
; CHECK: addvl sp,  sp, #-3
; CHECK: {{(add|mov)\ +x29, sp[, #0-9]*}}
  %p0 = alloca %ptype
  %v0 = alloca %vtype
  %ip = alloca i8*
  %i1 = alloca [ 512 x i64 ]

; CHECK-DAG: adrp [[VLDADDR:x[0-9]+]], vread
; CHECK-DAG: ld1h {[[VLD:z[0-9]+]].h}, {{p[0-9]+}}/z, {{\[}}[[VLDADDR]]
; CHECK-DAG: st1h {[[VLD]].h}, {{p[0-9]+}}, [x29, #2, mul vl]
  %1 = load %vtype, %vtype* @vread
  store %vtype %1, %vtype* %v0

; CHECK-DAG: adrp [[PLDADDR:x[0-9]+]], pread
; CHECK-DAG: ldr [[PLD:p[0-9]+]], {{\[}}[[PLDADDR]]]
; CHECK-DAG: str [[PLD]], [x29, #8, mul vl]
  %2 = load %ptype, %ptype* @pread
  store %ptype %2, %ptype* %p0

; Calculate address &i1[42] from FP
; CHECK-DAG: adrp [[IADDR:x[0-9]+]], iread
; CHECK-DAG: ldr  [[IVAL:x[0-9]+]], {{\[}}[[IADDR]], :lo12:iread]
; CHECK-DAG: str [[IVAL]], [sp, #336]
  %3 = load i64, i64* @iread
  %some.addr = getelementptr [512 x i64], [512 x i64]* %i1, i32 0, i32 42
  store i64 %3, i64* %some.addr

; CHECK-DAG: stur x29, [x29, #-8]
  %4 = call i8* @llvm.frameaddress(i32 0)
  store i8* %4, i8** %ip

; CHECK: addvl sp, sp, #3
; CHECK: ret
  ret void
}

;========================================================================
; DESCRIPTION:
; Test the offsets of multiple Vector and Predicates in the light of the
; (static) alignment of the predicate frame. The latter is difficult to
; test at the moment, see NOTE.
;
;   [prev_frame][VEC, PRED]
;                         ^
;                         SP
; VARIANT:
; o  9 Locals (8 predicate, 1 vector)
; o  SVE Region is SP Addressable
; o  No Framepointer
; o  No Register Saves
;
; o (SVE Vector) V0 is allocated at offset '8  (#Vectors)' from SP
; o (Pred  Vector) P0 is allocated at offset '0  (#Predicates)' from SP
; o (Pred  Vector) P0 is allocated at offset '56 (#Predicates)' from SP
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
define void @spillfill_8p1v_sp_nofp_nosaves() {
; CHECK-LABEL: spillfill_8p1v_sp_nofp_nosaves
; CHECK: addvl sp, sp, #-9
; CHECK-NOT:   sub sp,
  %p0 = alloca %ptype
  %p1 = alloca %ptype
  %p2 = alloca %ptype
  %p3 = alloca %ptype
  %p4 = alloca %ptype
  %p5 = alloca %ptype
  %p6 = alloca %ptype
  %p7 = alloca %ptype
  %v0 = alloca %vtype

; CHECK-DAG: adrp [[VLDADDR:x[0-9]+]], vread
; CHECK-DAG: ld1h {[[VLD:z[0-9]+]].h}, {{p[0-9]+}}/z, {{\[}}[[VLDADDR]]
; CHECK-DAG: addvl [[TMP:x[0-9]+]], sp, #1
; CHECK-DAG: st1h {[[VLD]].h}, {{p[0-9]+}}, {{\[}}[[TMP]], #7, mul vl]
  %1 = load %vtype, %vtype* @vread
  store %vtype %1, %vtype* %v0

; CHECK-DAG: adrp [[PLDADDR:x[0-9]+]], pread
; CHECK-DAG: ldr [[PLD:p[0-9]+]], {{\[}}[[PLDADDR]]]
; CHECK-DAG: str [[PLD]], [sp]
  %2 = load %ptype, %ptype* @pread
  store %ptype %2, %ptype* %p0

; CHECK-DAG: str [[PLD2:p[0-9]+]], [sp, #56, mul vl]
  %3 = load %ptype, %ptype* @pread
  store %ptype %3, %ptype* %p7

; CHECK: addvl sp, sp, #9
; CHECK: ret
  ret void
}

;========================================================================
; DESCRIPTION:
; Test the prologue of the SVE region, in specific the use of the ADDVL
; immediate field of 6 bits, leading to 1 ADDVL to allocate, and 2 ADDVL
; to deallocate.
;
;   [prev_frame][VEC, PRED]
;                         ^
;                         SP
;
; VARIANT:
; o  32 Locals (32 vectors) requiring 1 ADDVL instruction to subtract
;    (range up to -32), and two ADDVL instructions to add
;    (range up to 31 -> ADDVL 31 + ADDVL 1).
; o  SVE Region is SP Addressable
; o  No Framepointer
; o  No Register Saves
; o  Callee save spills for reg scavenging because #VL > 31
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
define void @spillfill_0p32v_sp_nosaves() {
; CHECK-LABEL: spillfill_0p32v_sp_nosaves
; CHECK: addvl sp, sp, #-32
  %v0 = alloca %vtype
  %v1 = alloca %vtype
  %v2 = alloca %vtype
  %v3 = alloca %vtype
  %v4 = alloca %vtype
  %v5 = alloca %vtype
  %v6 = alloca %vtype
  %v7 = alloca %vtype
  %v8 = alloca %vtype
  %v9 = alloca %vtype
  %v10 = alloca %vtype
  %v11 = alloca %vtype
  %v12 = alloca %vtype
  %v13 = alloca %vtype
  %v14 = alloca %vtype
  %v15 = alloca %vtype
  %v16 = alloca %vtype
  %v17 = alloca %vtype
  %v18 = alloca %vtype
  %v19 = alloca %vtype
  %v20 = alloca %vtype
  %v21 = alloca %vtype
  %v22 = alloca %vtype
  %v23 = alloca %vtype
  %v24 = alloca %vtype
  %v25 = alloca %vtype
  %v26 = alloca %vtype
  %v27 = alloca %vtype
  %v28 = alloca %vtype
  %v29 = alloca %vtype
  %v30 = alloca %vtype
  %v31 = alloca %vtype

; CHECK-DAG: adrp [[VLDADDR:x[0-9]+]], vread
; CHECK-DAG: ld1h {[[VLD:z[0-9]+]].h}, {{p[0-9]+}}/z, {{\[}}[[VLDADDR]]
; CHECK-DAG: add [[TMP:x[0-9]+]], sp, #16
; CHECK-DAG: st1h {[[VLD]].h}, {{p[0-9]+}}, {{\[}}[[TMP]]]
  %1 = load %vtype, %vtype* @vread
  store %vtype %1, %vtype* %v0

; CHECK: addvl sp, sp, #31
; CHECK: addvl sp, sp, #1
; CHECK: ret
  ret void
}

;========================================================================
; DESCRIPTION:
; Test the prologue of the SVE region, in specific the use of the ADDVL
; immediate field of 6 bits, requiring 2 ADDVL instructions to subtract
; (range up to -32), but 3 ADDVL instructions to deallocate (does not fit
; in 2ADDVL instructions because the range goes up to 31).
;
;   [prev_frame][VEC, PRED]
;                         ^
;                         SP
;
; VARIANT:
; o  64 Locals (64 vectors)
; o  SVE Region is SP Addressable
; o  No Framepointer
; o  No Register Saves
; o  Callee save spills for reg scavenging because #VL > 31
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
define void @spillfill_0p64v_sp_nosaves() {
; CHECK-LABEL: spillfill_0p64v_sp_nosaves
; CHECK: addvl sp, sp, #-32
; CHECK: addvl sp, sp, #-32
  %v0 = alloca %vtype
  %v1 = alloca %vtype
  %v2 = alloca %vtype
  %v3 = alloca %vtype
  %v4 = alloca %vtype
  %v5 = alloca %vtype
  %v6 = alloca %vtype
  %v7 = alloca %vtype
  %v8 = alloca %vtype
  %v9 = alloca %vtype
  %v10 = alloca %vtype
  %v11 = alloca %vtype
  %v12 = alloca %vtype
  %v13 = alloca %vtype
  %v14 = alloca %vtype
  %v15 = alloca %vtype
  %v16 = alloca %vtype
  %v17 = alloca %vtype
  %v18 = alloca %vtype
  %v19 = alloca %vtype
  %v20 = alloca %vtype
  %v21 = alloca %vtype
  %v22 = alloca %vtype
  %v23 = alloca %vtype
  %v24 = alloca %vtype
  %v25 = alloca %vtype
  %v26 = alloca %vtype
  %v27 = alloca %vtype
  %v28 = alloca %vtype
  %v29 = alloca %vtype
  %v30 = alloca %vtype
  %v31 = alloca %vtype
  %v32 = alloca %vtype
  %v33 = alloca %vtype
  %v34 = alloca %vtype
  %v35 = alloca %vtype
  %v36 = alloca %vtype
  %v37 = alloca %vtype
  %v38 = alloca %vtype
  %v39 = alloca %vtype
  %v40 = alloca %vtype
  %v41 = alloca %vtype
  %v42 = alloca %vtype
  %v43 = alloca %vtype
  %v44 = alloca %vtype
  %v45 = alloca %vtype
  %v46 = alloca %vtype
  %v47 = alloca %vtype
  %v48 = alloca %vtype
  %v49 = alloca %vtype
  %v50 = alloca %vtype
  %v51 = alloca %vtype
  %v52 = alloca %vtype
  %v53 = alloca %vtype
  %v54 = alloca %vtype
  %v55 = alloca %vtype
  %v56 = alloca %vtype
  %v57 = alloca %vtype
  %v58 = alloca %vtype
  %v59 = alloca %vtype
  %v60 = alloca %vtype
  %v61 = alloca %vtype
  %v62 = alloca %vtype
  %v63 = alloca %vtype

; CHECK-DAG: adrp [[VLDADDR:x[0-9]+]], vread
; CHECK-DAG: ld1h {[[VLD:z[0-9]+]].h}, {{p[0-9]+}}/z, {{\[}}[[VLDADDR]]
; CHECK-DAG: add [[TMP:x[0-9]+]], sp, #16
; CHECK-DAG: st1h {[[VLD]].h}, {{p[0-9]+}}, {{\[}}[[TMP]]]
  %1 = load %vtype, %vtype* @vread
  store %vtype %1, %vtype* %v0

; CHECK-DAG: addvl   sp, sp, #31
; CHECK-DAG: addvl   sp, sp, #31
; CHECK-DAG: addvl   sp, sp, #2
; CHECK: ret
  ret void
}

;========================================================================
; DESCRIPTION:
; Test layout of regions in combination with VLAs
;
;   [prev_frame][PRED, VEC][FR][VLA]
;                              ^   ^
;                              FP  SP
;
; VARIANT:
; o  2 Locals (1 predicate, 1 vector)
; o  SVE Region is FP Addressable
;
; Predicates are padded so that the total SVE region is a multiple of
; 8 predicate elements in size, leading to a static alignment.
;
; o (SVE Vector) V0 is allocated at offset '1' (#Vectors) from FP+16.
; o (Pred  Vector) P0 is allocated at offset '0' (#Predicates) from FP+16.
; o The 16 byte offset from FP is to jump over the Frame Record (FR).
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
declare i8* @llvm.stacksave() #1
declare void @llvm.stackrestore(i8*) #1
define void @spillfill_1p1v_bp_nosaves(i64 %len) {
; CHECK-LABEL: spillfill_1p1v_bp_nosaves

  ; Force BP to be used
  %saved_stack = alloca i8*
  %1 = call i8* @llvm.stacksave()
  store i8* %1, i8** %saved_stack
  %blob = alloca i32, i64 %len, align 16

; CHECK: addvl sp, sp, #-3
  %p0 = alloca %ptype
  %v0 = alloca %vtype

; CHECK-DAG: adrp [[VLDADDR:x[0-9]+]], vread
; CHECK-DAG: ld1h {[[VLD:z[0-9]+]].h}, {{p[0-9]+}}/z, {{\[}}[[VLDADDR]]
; CHECK-DAG: st1h {[[VLD]].h}, {{p[0-9]+}}, [x29, #2, mul vl]
  %2 = load %vtype, %vtype* @vread
  store %vtype %2, %vtype* %v0

; CHECK-DAG: adrp [[PLDADDR:x[0-9]+]], pread
; CHECK-DAG: ldr [[PLD:p[0-9]+]], {{\[}}[[PLDADDR]]]
; CHECK-DAG: str [[PLD]], [x29, #8, mul vl]
  %3 = load %ptype, %ptype* @pread
  store %ptype %3, %ptype* %p0

  %4 = load i8*, i8** %saved_stack
  call void @llvm.stackrestore(i8* %4)

; CHECK: addvl sp, sp, #3
; CHECK: ret
  ret void
}

;========================================================================
; DESCRIPTION:
; Test the saving of Register Allocation Spilling of SVE types together
; with saving of Callee Saved registers.
;
;   [prev_frame][{VEC_SV:VEC_LOC:VEC_REGSP}, {PRED_SV:PRED_LOC:PREV_REGSP}]
;                                                                        ^
;                                                                        SP
;
; VARIANT:
; o  11 Vectors    (1 local, ABI 8 reg saves, 2 reg spills)
; o  11 Predicates (1 local, ABI 8 reg saves, 2 reg spills)
;    where the 8 reg saves fit into 1 Vector,
;    and 2 reg spills fit into 1 vector (see NOTE below).
; o  High register pressure (long liferanges so that 1 reg needs spilling)
; o  SVE Region is SP Addressable
; o  No Framepointer
; o  Full register saves because all Callee Saved registers will be used.
; o  Two step allocation (predicate and vector), one step deallocation.
;
; During stack frame setup (relative):
; o  Vector saves are allocated at offsets '3..12' (#Vectors) from SP
;    Vector reg spills are allocated at offsets '1..2' from SP
;    Vector local is allocated at offset 0 from SP.
; o  <SP update>
; o  Pred  saves are allocated at offsets '16..23' (#Predicates) from SP
;    Pred reg spills are allocated at offsets '8..15' from SP
;    Pred local is allocated at offset 0 from SP.
; o  Absolute offsets can be achieved by adding '3' to all vector offsets.
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue. For this test specifically, this means that predicate reg-saves
; are N*2 bytes each, whereas predicate locals are N*16 bytes each.
;========================================================================
define %vtype @spillfill_1p1v_1pregspill_1vregspill_sp_saves() {
  %v0 = alloca %vtype
  %p0 = alloca %ptype

; CHECK-LABEL: spillfill_1p1v_1pregspill_1vregspill_sp_saves:
; CHECKO0-LABEL: spillfill_1p1v_1pregspill_1vregspill_sp_saves:
; CHECKO0: addvl   sp, sp, #-27
; CHECKO0: str z8, [sp, #26, mul vl]
; CHECKO0: str z9, [sp, #25, mul vl]
; CHECKO0: str z10, [sp, #24, mul vl]
; CHECKO0: str z11, [sp, #23, mul vl]
; CHECKO0: str z12, [sp, #22, mul vl]
; CHECKO0: str z13, [sp, #21, mul vl]
; CHECKO0: str z14, [sp, #20, mul vl]
; CHECKO0: str z15, [sp, #19, mul vl]
; CHECKO0: str z16, [sp, #18, mul vl]
; CHECKO0: str z17, [sp, #17, mul vl]
; CHECKO0: str z18, [sp, #16, mul vl]
; CHECKO0: str z19, [sp, #15, mul vl]
; CHECKO0: str z20, [sp, #14, mul vl]
; CHECKO0: str z21, [sp, #13, mul vl]
; CHECKO0: str z22, [sp, #12, mul vl]
; CHECKO0: str z23, [sp, #11, mul vl]
; CHECKO0: str z24, [sp, #10, mul vl]
; CHECKO0: str z25, [sp, #9, mul vl]
; CHECKO0: str z26, [sp, #8, mul vl]
; CHECKO0: str z27, [sp, #7, mul vl]
; CHECKO0: str z28, [sp, #6, mul vl]
; CHECKO0: str z29, [sp, #5, mul vl]
; CHECKO0: str z30, [sp, #4, mul vl]
; CHECKO0: str z31, [sp, #3, mul vl]
; CHECKO0: addvl sp, sp, #-3
          ;FIXME change to '-2', see note on SC-306
          ;May be ok with -3 after SC-1265
; CHECKO0: str p4, [sp, #23, mul vl]
; CHECKO0: str p5, [sp, #22, mul vl]
; CHECKO0: str p6, [sp, #21, mul vl]
; CHECKO0: str p7, [sp, #20, mul vl]
; CHECKO0: str p8, [sp, #19, mul vl]
; CHECKO0: str p9, [sp, #18, mul vl]
; CHECKO0: str p10, [sp, #17, mul vl]
; CHECKO0: str p11, [sp, #16, mul vl]
; CHECKO0: str p12, [sp, #15, mul vl]
; CHECKO0: str p13, [sp, #14, mul vl]
; CHECKO0: str p14, [sp, #13, mul vl]
; CHECKO0: str p15, [sp, #12, mul vl]


  ; Regalloc Spill/reload one vector
  %1 = load volatile %vtype , %vtype *@vread
  %2 = load volatile %vtype , %vtype *@vread
  %3 = load volatile %vtype , %vtype *@vread
  %4 = load volatile %vtype , %vtype *@vread
  %5 = load volatile %vtype , %vtype *@vread
  %6 = load volatile %vtype , %vtype *@vread
  %7 = load volatile %vtype , %vtype *@vread
  %8 = load volatile %vtype , %vtype *@vread
  %9 = load volatile %vtype , %vtype *@vread
  %10 = load volatile %vtype , %vtype *@vread
  %11 = load volatile %vtype , %vtype *@vread
  %12 = load volatile %vtype , %vtype *@vread
  %13 = load volatile %vtype , %vtype *@vread
  %14 = load volatile %vtype , %vtype *@vread
  %15 = load volatile %vtype , %vtype *@vread
  %16 = load volatile %vtype , %vtype *@vread
  %17 = load volatile %vtype , %vtype *@vread
  %18 = load volatile %vtype , %vtype *@vread
  %19 = load volatile %vtype , %vtype *@vread
  %20 = load volatile %vtype , %vtype *@vread
  %21 = load volatile %vtype , %vtype *@vread
  %22 = load volatile %vtype , %vtype *@vread
  %23 = load volatile %vtype , %vtype *@vread
  %24 = load volatile %vtype , %vtype *@vread
  %25 = load volatile %vtype , %vtype *@vread
  %26 = load volatile %vtype , %vtype *@vread
  %27 = load volatile %vtype , %vtype *@vread
  %28 = load volatile %vtype , %vtype *@vread
  %29 = load volatile %vtype , %vtype *@vread
  %30 = load volatile %vtype , %vtype *@vread
  %31 = load volatile %vtype , %vtype *@vread
  %32 = load volatile %vtype , %vtype *@vread
  %33 = load volatile %vtype , %vtype *@vread
  store volatile %vtype %1, %vtype* @vwrite
  store volatile %vtype %2, %vtype* @vwrite
  store volatile %vtype %3, %vtype* @vwrite
  store volatile %vtype %4, %vtype* @vwrite
  store volatile %vtype %5, %vtype* @vwrite
  store volatile %vtype %6, %vtype* @vwrite
  store volatile %vtype %7, %vtype* @vwrite
  store volatile %vtype %8, %vtype* @vwrite
  store volatile %vtype %9, %vtype* @vwrite
  store volatile %vtype %10, %vtype* @vwrite
  store volatile %vtype %11, %vtype* @vwrite
  store volatile %vtype %12, %vtype* @vwrite
  store volatile %vtype %13, %vtype* @vwrite
  store volatile %vtype %14, %vtype* @vwrite
  store volatile %vtype %15, %vtype* @vwrite
  store volatile %vtype %16, %vtype* @vwrite
  store volatile %vtype %17, %vtype* @vwrite
  store volatile %vtype %18, %vtype* @vwrite
  store volatile %vtype %19, %vtype* @vwrite
  store volatile %vtype %20, %vtype* @vwrite
  store volatile %vtype %21, %vtype* @vwrite
  store volatile %vtype %22, %vtype* @vwrite
  store volatile %vtype %23, %vtype* @vwrite
  store volatile %vtype %24, %vtype* @vwrite
  store volatile %vtype %25, %vtype* @vwrite
  store volatile %vtype %26, %vtype* @vwrite
  store volatile %vtype %27, %vtype* @vwrite
  store volatile %vtype %28, %vtype* @vwrite
  store volatile %vtype %29, %vtype* @vwrite
  store volatile %vtype %30, %vtype* @vwrite
  store volatile %vtype %31, %vtype* @vwrite
  store volatile %vtype %32, %vtype* @vwrite
  store volatile %vtype %33, %vtype* @vwrite
; CHECK-DAG: adrp [[VREAD:x[0-9]+]], vread
; CHECK-DAG: str [[VSPILL:z[0-9]+]], {{\[}}sp, #[[VSPILLOFFSET:[0-9]+]], mul vl]
; CHECK-DAG: ld1h {[[VSPILL]].h}, {{p[0-9]+}}/z, {{\[}}[[VREAD]]
; CHECK-DAG: adrp [[VWRITE:x[0-9]+]], vwrite
; CHECK-DAG: ldr [[VRELOAD:z[0-9]+]], {{\[}}sp, #[[VSPILLOFFSET]], mul vl]
; CHECK-DAG: st1h {[[VRELOAD]].h}, {{p[0-9]+}}, {{\[}}[[VWRITE]]

  ; Regalloc Spill/reload two predicates
  %34 = load volatile %ptype , %ptype *@pread
  %35 = load volatile %ptype , %ptype *@pread
  %36 = load volatile %ptype , %ptype *@pread
  %37 = load volatile %ptype , %ptype *@pread
  %38 = load volatile %ptype , %ptype *@pread
  %39 = load volatile %ptype , %ptype *@pread
  %40 = load volatile %ptype , %ptype *@pread
  %41 = load volatile %ptype , %ptype *@pread
  %42 = load volatile %ptype , %ptype *@pread
  %43 = load volatile %ptype , %ptype *@pread
  %44 = load volatile %ptype , %ptype *@pread
  %45 = load volatile %ptype , %ptype *@pread
  %46 = load volatile %ptype , %ptype *@pread
  %47 = load volatile %ptype , %ptype *@pread
  %48 = load volatile %ptype , %ptype *@pread
  %49 = load volatile %ptype , %ptype *@pread
  %50 = load volatile %ptype , %ptype *@pread

  store volatile %ptype %34, %ptype* @pwrite
  store volatile %ptype %35, %ptype* @pwrite
  store volatile %ptype %36, %ptype* @pwrite
  store volatile %ptype %37, %ptype* @pwrite
  store volatile %ptype %38, %ptype* @pwrite
  store volatile %ptype %39, %ptype* @pwrite
  store volatile %ptype %40, %ptype* @pwrite
  store volatile %ptype %41, %ptype* @pwrite
  store volatile %ptype %42, %ptype* @pwrite
  store volatile %ptype %43, %ptype* @pwrite
  store volatile %ptype %44, %ptype* @pwrite
  store volatile %ptype %45, %ptype* @pwrite
  store volatile %ptype %46, %ptype* @pwrite
  store volatile %ptype %47, %ptype* @pwrite
  store volatile %ptype %48, %ptype* @pwrite
  store volatile %ptype %49, %ptype* @pwrite
  store volatile %ptype %50, %ptype* @pwrite
; CHECK-DAG: adrp [[PREAD:x[0-9]+]], pread
; CHECK-DAG: str [[PSPILL:p[0-9]+]], {{\[}}sp, #[[PSPILLOFFSET:[0-9]+]], mul vl]
; CHECK-DAG: ldr [[PSPILL]], {{\[}}[[PREAD]]]
; CHECK-DAG: adrp [[PWRITE:x[0-9]+]], pwrite
; CHECK-DAG: ldr [[PRELOAD:p[0-9]+]], {{\[}}sp, #[[PSPILLOFFSET]], mul vl]
; CHECK-DAG: str [[PRELOAD]], {{\[}}[[PWRITE]]]

  %51 = load %vtype, %vtype* @vread
  store %vtype %51, %vtype* %v0

  %52 = load %ptype, %ptype* @pread
  store %ptype %52, %ptype* %p0

; Restore CSRs
; CHECKO0: ldr p4, [sp, #23, mul vl]
; CHECKO0: ldr p5, [sp, #22, mul vl]
; CHECKO0: ldr p6, [sp, #21, mul vl]
; CHECKO0: ldr p7, [sp, #20, mul vl]
; CHECKO0: ldr p8, [sp, #19, mul vl]
; CHECKO0: ldr p9, [sp, #18, mul vl]
; CHECKO0: ldr p10, [sp, #17, mul vl]
; CHECKO0: ldr p11, [sp, #16, mul vl]
; CHECKO0: ldr p12, [sp, #15, mul vl]
; CHECKO0: ldr p13, [sp, #14, mul vl]
; CHECKO0: ldr p14, [sp, #13, mul vl]
; CHECKO0: ldr p15, [sp, #12, mul vl]
; CHECKO0: ldr z8, [sp, #29, mul vl]
; CHECKO0: ldr z9, [sp, #28, mul vl]
; CHECKO0: ldr z10, [sp, #27, mul vl]
; CHECKO0: ldr z11, [sp, #26, mul vl]
; CHECKO0: ldr z12, [sp, #25, mul vl]
; CHECKO0: ldr z13, [sp, #24, mul vl]
; CHECKO0: ldr z14, [sp, #23, mul vl]
; CHECKO0: ldr z15, [sp, #22, mul vl]
; CHECKO0: ldr z16, [sp, #21, mul vl]
; CHECKO0: ldr z17, [sp, #20, mul vl]
; CHECKO0: ldr z18, [sp, #19, mul vl]
; CHECKO0: ldr z19, [sp, #18, mul vl]
; CHECKO0: ldr z20, [sp, #17, mul vl]
; CHECKO0: ldr z21, [sp, #16, mul vl]
; CHECKO0: ldr z22, [sp, #15, mul vl]
; CHECKO0: ldr z23, [sp, #14, mul vl]
; CHECKO0: ldr z24, [sp, #13, mul vl]
; CHECKO0: ldr z25, [sp, #12, mul vl]
; CHECKO0: ldr z26, [sp, #11, mul vl]
; CHECKO0: ldr z27, [sp, #10, mul vl]
; CHECKO0: ldr z28, [sp, #9, mul vl]
; CHECKO0: ldr z29, [sp, #8, mul vl]
; CHECKO0: ldr z30, [sp, #7, mul vl]
; CHECKO0: ldr z31, [sp, #6, mul vl]


; CHECKO0: addvl   sp, sp, #30

  ret %vtype %33    ; trigger SVE AAPCS
}

;========================================================================
; DESCRIPTION:
; Test that stackslot coloring does not overlay slots from different
; stack regions.
;
;   [prev_frame][Pred|Vec][FR][Non-SVE][VLA]
;                             ^        ^   ^
;                             FP       BP  SP
;
; VARIANT:
; o  2 Vectors    (1 local, 1 reg spill)
; o  2 Predicates (1 local, 1 reg spill)
; o  1 Non-SVE reg spill
; o  High register pressure (long liferanges so that 1 reg needs spilling)
; o  SVE Region is FP Addressable
;
; If StackSlot coloring is enabled on -O2 the spill slots of vector,
; predicate and non-SVE (integer) region should not be merged into
; a single stack slot. We can check this by making sure that the non-SVE
; reg spill is accessed at negative offset from FP, whereas the predicate-
; and vector regspills are accessed at (distinct) positive offsets from BP.
;
; NOTE: As described SC-306, LLVM currently does not pack vector
; types correctly, leading to a 1 SVE Vector to be allocated for every
; SVE Predicate Vector. Offsets need to be changed after solving this
; issue.
;========================================================================
define void @spillfill_1p1v_1intspill_1pregspill_1vregspill_bp_coloring(i64 %len) {
; CHECK-LABEL: spillfill_1p1v_1intspill_1pregspill_1vregspill_bp_coloring

  ; Force BP to be used
  %saved_stack = alloca i8*
  %ss1 = call i8* @llvm.stacksave()
  store i8* %ss1, i8** %saved_stack
  %blob = alloca i32, i64 %len, align 16

  ; Stack Objects
  %v0 = alloca %vtype
  %p0 = alloca %ptype

  ; Regalloc Spill/reload one integer
  %i1 = load volatile %itype , %itype *@iread
  %i2 = load volatile %itype , %itype *@iread
  %i3 = load volatile %itype , %itype *@iread
  %i4 = load volatile %itype , %itype *@iread
  %i5 = load volatile %itype , %itype *@iread
  %i6 = load volatile %itype , %itype *@iread
  %i7 = load volatile %itype , %itype *@iread
  %i8 = load volatile %itype , %itype *@iread
  %i9 = load volatile %itype , %itype *@iread
  %i10 = load volatile %itype , %itype *@iread
  %i11 = load volatile %itype , %itype *@iread
  %i12 = load volatile %itype , %itype *@iread
  %i13 = load volatile %itype , %itype *@iread
  %i14 = load volatile %itype , %itype *@iread
  %i15 = load volatile %itype , %itype *@iread
  %i16 = load volatile %itype , %itype *@iread
  %i17 = load volatile %itype , %itype *@iread
  %i18 = load volatile %itype , %itype *@iread
  %i19 = load volatile %itype , %itype *@iread
  %i20 = load volatile %itype , %itype *@iread
  %i21 = load volatile %itype , %itype *@iread
  %i22 = load volatile %itype , %itype *@iread
  %i23 = load volatile %itype , %itype *@iread
  %i24 = load volatile %itype , %itype *@iread
  %i25 = load volatile %itype , %itype *@iread
  %i26 = load volatile %itype , %itype *@iread
  %i27 = load volatile %itype , %itype *@iread
  %i28 = load volatile %itype , %itype *@iread
  %i29 = load volatile %itype , %itype *@iread
  store volatile %itype %i1, %itype* @iwrite
  store volatile %itype %i2, %itype* @iwrite
  store volatile %itype %i3, %itype* @iwrite
  store volatile %itype %i4, %itype* @iwrite
  store volatile %itype %i5, %itype* @iwrite
  store volatile %itype %i6, %itype* @iwrite
  store volatile %itype %i7, %itype* @iwrite
  store volatile %itype %i8, %itype* @iwrite
  store volatile %itype %i9, %itype* @iwrite
  store volatile %itype %i10, %itype* @iwrite
  store volatile %itype %i11, %itype* @iwrite
  store volatile %itype %i12, %itype* @iwrite
  store volatile %itype %i13, %itype* @iwrite
  store volatile %itype %i14, %itype* @iwrite
  store volatile %itype %i15, %itype* @iwrite
  store volatile %itype %i16, %itype* @iwrite
  store volatile %itype %i17, %itype* @iwrite
  store volatile %itype %i18, %itype* @iwrite
  store volatile %itype %i19, %itype* @iwrite
  store volatile %itype %i20, %itype* @iwrite
  store volatile %itype %i21, %itype* @iwrite
  store volatile %itype %i22, %itype* @iwrite
  store volatile %itype %i23, %itype* @iwrite
  store volatile %itype %i24, %itype* @iwrite
  store volatile %itype %i25, %itype* @iwrite
  store volatile %itype %i26, %itype* @iwrite
  store volatile %itype %i27, %itype* @iwrite
  store volatile %itype %i28, %itype* @iwrite
  store volatile %itype %i29, %itype* @iwrite
; CHECK-DAG: adrp [[IWRITE:x[0-9]+]], iwrite
; CHECK-DAG: stur [[ISPILL:x[0-9]+]], {{\[}}x29[[TRAIL:[-, #]+[0-9]+]]{{\].*Spill}}
; CHECK-DAG: ldur [[IRELOAD:x[0-9]+]], {{\[}}x29[[TRAIL]]{{\].*Reload}}
; CHECK-DAG: str [[IRELOAD]], {{\[}}[[IWRITE]], :lo12:iwrite]

  ; Regalloc Spill/reload one vector
  %1 = load volatile %vtype , %vtype *@vread
  %2 = load volatile %vtype , %vtype *@vread
  %3 = load volatile %vtype , %vtype *@vread
  %4 = load volatile %vtype , %vtype *@vread
  %5 = load volatile %vtype , %vtype *@vread
  %6 = load volatile %vtype , %vtype *@vread
  %7 = load volatile %vtype , %vtype *@vread
  %8 = load volatile %vtype , %vtype *@vread
  %9 = load volatile %vtype , %vtype *@vread
  %10 = load volatile %vtype , %vtype *@vread
  %11 = load volatile %vtype , %vtype *@vread
  %12 = load volatile %vtype , %vtype *@vread
  %13 = load volatile %vtype , %vtype *@vread
  %14 = load volatile %vtype , %vtype *@vread
  %15 = load volatile %vtype , %vtype *@vread
  %16 = load volatile %vtype , %vtype *@vread
  %17 = load volatile %vtype , %vtype *@vread
  %18 = load volatile %vtype , %vtype *@vread
  %19 = load volatile %vtype , %vtype *@vread
  %20 = load volatile %vtype , %vtype *@vread
  %21 = load volatile %vtype , %vtype *@vread
  %22 = load volatile %vtype , %vtype *@vread
  %23 = load volatile %vtype , %vtype *@vread
  %24 = load volatile %vtype , %vtype *@vread
  %25 = load volatile %vtype , %vtype *@vread
  %26 = load volatile %vtype , %vtype *@vread
  %27 = load volatile %vtype , %vtype *@vread
  %28 = load volatile %vtype , %vtype *@vread
  %29 = load volatile %vtype , %vtype *@vread
  %30 = load volatile %vtype , %vtype *@vread
  %31 = load volatile %vtype , %vtype *@vread
  %32 = load volatile %vtype , %vtype *@vread
  %33 = load volatile %vtype , %vtype *@vread
  store volatile %vtype %1, %vtype* @vwrite
  store volatile %vtype %2, %vtype* @vwrite
  store volatile %vtype %3, %vtype* @vwrite
  store volatile %vtype %4, %vtype* @vwrite
  store volatile %vtype %5, %vtype* @vwrite
  store volatile %vtype %6, %vtype* @vwrite
  store volatile %vtype %7, %vtype* @vwrite
  store volatile %vtype %8, %vtype* @vwrite
  store volatile %vtype %9, %vtype* @vwrite
  store volatile %vtype %10, %vtype* @vwrite
  store volatile %vtype %11, %vtype* @vwrite
  store volatile %vtype %12, %vtype* @vwrite
  store volatile %vtype %13, %vtype* @vwrite
  store volatile %vtype %14, %vtype* @vwrite
  store volatile %vtype %15, %vtype* @vwrite
  store volatile %vtype %16, %vtype* @vwrite
  store volatile %vtype %17, %vtype* @vwrite
  store volatile %vtype %18, %vtype* @vwrite
  store volatile %vtype %19, %vtype* @vwrite
  store volatile %vtype %20, %vtype* @vwrite
  store volatile %vtype %21, %vtype* @vwrite
  store volatile %vtype %22, %vtype* @vwrite
  store volatile %vtype %23, %vtype* @vwrite
  store volatile %vtype %24, %vtype* @vwrite
  store volatile %vtype %25, %vtype* @vwrite
  store volatile %vtype %26, %vtype* @vwrite
  store volatile %vtype %27, %vtype* @vwrite
  store volatile %vtype %28, %vtype* @vwrite
  store volatile %vtype %29, %vtype* @vwrite
  store volatile %vtype %30, %vtype* @vwrite
  store volatile %vtype %31, %vtype* @vwrite
  store volatile %vtype %32, %vtype* @vwrite
  store volatile %vtype %33, %vtype* @vwrite
; CHECK-DAG: adrp [[VREAD:x[0-9]+]], vread
; CHECK-DAG: ld1h {[[VSPILL]].h}, {{p[0-9]+}}/z, {{\[}}[[VREAD]]
; CHECK-DAG: str [[VSPILL:z[0-9]+]], [x29, #[[VSPILLOFFSET:[0-9]+]], mul vl]
; CHECK-DAG: adrp [[VWRITE:x[0-9]+]], vwrite
; CHECK-DAG: ldr [[VRELOAD:z[0-9]+]], [x29, #[[VSPILLOFFSET]], mul vl]
; CHECK-DAG: st1h {[[VRELOAD]].h}, {{p[0-9]+}}, {{\[}}[[VWRITE]]

  ; Regalloc Spill/reload two predicates
  %34 = load volatile %ptype , %ptype *@pread
  %35 = load volatile %ptype , %ptype *@pread
  %36 = load volatile %ptype , %ptype *@pread
  %37 = load volatile %ptype , %ptype *@pread
  %38 = load volatile %ptype , %ptype *@pread
  %39 = load volatile %ptype , %ptype *@pread
  %40 = load volatile %ptype , %ptype *@pread
  %41 = load volatile %ptype , %ptype *@pread
  %42 = load volatile %ptype , %ptype *@pread
  %43 = load volatile %ptype , %ptype *@pread
  %44 = load volatile %ptype , %ptype *@pread
  %45 = load volatile %ptype , %ptype *@pread
  %46 = load volatile %ptype , %ptype *@pread
  %47 = load volatile %ptype , %ptype *@pread
  %48 = load volatile %ptype , %ptype *@pread
  %49 = load volatile %ptype , %ptype *@pread
  %50 = load volatile %ptype , %ptype *@pread

  store volatile %ptype %34, %ptype* @pwrite
  store volatile %ptype %35, %ptype* @pwrite
  store volatile %ptype %36, %ptype* @pwrite
  store volatile %ptype %37, %ptype* @pwrite
  store volatile %ptype %38, %ptype* @pwrite
  store volatile %ptype %39, %ptype* @pwrite
  store volatile %ptype %40, %ptype* @pwrite
  store volatile %ptype %41, %ptype* @pwrite
  store volatile %ptype %42, %ptype* @pwrite
  store volatile %ptype %43, %ptype* @pwrite
  store volatile %ptype %44, %ptype* @pwrite
  store volatile %ptype %45, %ptype* @pwrite
  store volatile %ptype %46, %ptype* @pwrite
  store volatile %ptype %47, %ptype* @pwrite
  store volatile %ptype %48, %ptype* @pwrite
  store volatile %ptype %49, %ptype* @pwrite
  store volatile %ptype %50, %ptype* @pwrite
; CHECK-DAG: adrp [[PREAD:x[0-9]+]], pread
; CHECK-DAG: ldr [[PSPILL]], {{\[}}[[PREAD]]]
; CHECK-DAG: str [[PSPILL:p[0-9]+]], [x29, #[[PSPILLOFFSET:[0-9]+]], mul vl]
; CHECK-DAG: adrp [[PWRITE:x[0-9]+]], pwrite
; CHECK-DAG: ldr [[PRELOAD:p[0-9]+]], [x29, #[[PSPILLOFFSET]], mul vl]
; CHECK-DAG: str [[PRELOAD]], {{\[}}[[PWRITE]]]


; Some use of v0 to prevent it being removed
  %51 = load %vtype, %vtype* @vread
  store %vtype %51, %vtype* %v0

; Some use of p0 to prevent it being removed
  %52 = load %ptype, %ptype* @pread
  store %ptype %52, %ptype* %p0

; Deallocate VLA
  %stack_restore = load i8*, i8** %saved_stack
  call void @llvm.stackrestore(i8* %stack_restore)

  ret void
}

;========================================================================
; DESCRIPTION:
; Test that the register scavenger has to use an emergency spillslot
; to calculcate an address for one of the vectors on the stack.
; First the 'base' of the SVE region needs to be calculated, after which
; the offset is multiplied by the VL. This also tests that an emergency
; slot is available, which would not be created if there wasn't any SVE.
;
;   [prev_frame][-----Vec-----][Non-SVE]
;                             ^        ^
;                            VBase     SP
;
; VARIANT:
; o  1 array of SVE vectors on stack, 1 non-SVE local.
; o  Unknown offset into vector array following from volatile load,
;    this forces the compiler to calculate 'on the spot' (rather than
;    precalculating, which is needed since we want to do it whilst having
;    high register pressure)
; o  High register pressure (long liferanges so that 1 reg needs spilling)
; o  SVE Region is SP Addressable
;
; Amidst high register pressure, calculating address for 'v0' will
; require a register the scavenger doesn't have, forcing it to spill a
; register to the emergency spill slot being saved to [sp].
;
; TODO: THIS TEST IS CURRENTLY DISABLED BECAUSE I DONT KNOW HOW TO
;       REQUIRE AN EMERGENCY SPILLSLOT AFTER IMPROVING REGSCAVENGER
;========================================================================
define i64 @spillfill_Nv1i_sp_emergencyspillslot(i64 %arg0, i64 %arg1) {
; CHECK-LABEL: spillfill_Nv1i_sp_emergencyspillslot
  ; Stack Objects
  %v0 = alloca [ 100 x %vtype ]
  %i0 = alloca i64

  ; Regalloc Spill/reload one integer
  %i1 = load volatile %itype, %itype *@iread
  %i2 = load volatile %itype, %itype *@iread
  %i3 = load volatile %itype, %itype *@iread
  %i4 = load volatile %itype, %itype *@iread
  %i5 = load volatile %itype, %itype *@iread
  %i6 = load volatile %itype, %itype *@iread
  %i7 = load volatile %itype, %itype *@iread
  %i8 = load volatile %itype, %itype *@iread
  %i9 = load volatile %itype, %itype *@iread
  %i10 = load volatile %itype, %itype *@iread
  %i11 = load volatile %itype, %itype *@iread
  %i12 = load volatile %itype, %itype *@iread
  %i13 = load volatile %itype, %itype *@iread
  %i14 = load volatile %itype, %itype *@iread
  %i15 = load volatile %itype, %itype *@iread
  %i16 = load volatile %itype, %itype *@iread
  %i17 = load volatile %itype, %itype *@iread
  %i18 = load volatile %itype, %itype *@iread
  %i19 = load volatile %itype, %itype *@iread
  %i20 = load volatile %itype, %itype *@iread
  %i21 = load volatile %itype, %itype *@iread
  %i22 = load volatile %itype, %itype *@iread
  %i23 = load volatile %itype, %itype *@iread
  %i24 = load volatile %itype, %itype *@iread
  %i25 = load volatile %itype, %itype *@iread
  %i26 = load volatile %itype, %itype *@iread
  %i27 = load volatile %itype, %itype *@iread
  %i28 = load volatile %itype, %itype *@iread
  %i29 = load volatile %itype, %itype *@iread
  %i30 = load volatile %itype, %itype *@iread
  %i31 = load volatile %itype, %itype *@iread
  %i32 = load volatile %itype, %itype *@iread
  %i33 = load volatile %itype, %itype *@iread

; DISABLED-CHECK-DAG:  ldr [[OFFSET:x9]], {{\[x[0-9]+}}, :lo12:iread]
; DISABLED-CHECK-DAG:  ld1h {[[ZVALUE:z[0-9]+]].h},
; DISABLED-CHECK-DAG:  cnth [[CNT:x[0-9]+]]
; DISABLED-CHECK-DAG:  mul  [[ELEM:x[0-9]+]], [[CNT]], [[OFFSET]]
; DISABLED-CHECK-DAG:  str  [[SPILL:x[0-9]+]], {{\[sp\]}}
; DISABLED-CHECK-DAG:  add  [[SPILL]], sp, #160
; DISABLED-CHECK-DAG:  add  [[BASE:x[0-9]+]], [[SPILL]], #0
; DISABLED-CHECK-DAG:  st1h {[[ZVALUE]].h}, {{p[0-9]+}}, {{\[}}[[BASE]], [[ELEM]], lsl #1]
  %offset = load volatile %itype, %itype* @iread
  %somevalue = load volatile %vtype, %vtype* @vread
  %v0.addr = getelementptr [100 x %vtype], [ 100 x %vtype ]* %v0, i32 0, i64 %offset
  store volatile %vtype %somevalue, %vtype* %v0.addr

  store volatile %itype %i1, %itype* @iwrite
  store volatile %itype %i2, %itype* @iwrite
  store volatile %itype %i3, %itype* @iwrite
  store volatile %itype %i4, %itype* @iwrite
  store volatile %itype %i5, %itype* @iwrite
  store volatile %itype %i6, %itype* @iwrite
  store volatile %itype %i7, %itype* @iwrite
  store volatile %itype %i8, %itype* @iwrite
  store volatile %itype %i9, %itype* @iwrite
  store volatile %itype %i10, %itype* @iwrite
  store volatile %itype %i11, %itype* @iwrite
  store volatile %itype %i12, %itype* @iwrite
  store volatile %itype %i13, %itype* @iwrite
  store volatile %itype %i14, %itype* @iwrite
  store volatile %itype %i15, %itype* @iwrite
  store volatile %itype %i16, %itype* @iwrite
  store volatile %itype %i17, %itype* @iwrite
  store volatile %itype %i18, %itype* @iwrite
  store volatile %itype %i19, %itype* @iwrite
  store volatile %itype %i20, %itype* @iwrite
  store volatile %itype %i21, %itype* @iwrite
  store volatile %itype %i22, %itype* @iwrite
  store volatile %itype %i23, %itype* @iwrite
  store volatile %itype %i24, %itype* @iwrite
  store volatile %itype %i25, %itype* @iwrite
  store volatile %itype %i26, %itype* @iwrite
  store volatile %itype %i27, %itype* @iwrite
  store volatile %itype %i28, %itype* @iwrite
  store volatile %itype %i29, %itype* @iwrite
  store volatile %itype %i30, %itype* @iwrite
  store volatile %itype %i31, %itype* @iwrite
  store volatile %itype %i32, %itype* @iwrite
  store volatile %itype %i33, %itype* @iwrite

  %somevalue2 = load %itype, %itype* @iread
  store %itype %somevalue2, %itype* %i0

  ret i64 %arg0
}

;========================================================================
; DESCRIPTION:
; Test layout of call frames together with SVE/non-SVE locals when a
; FramePointer is available.
;
; This tests SP is correct at the point of a function call and those
; parameters that cannot be passed by register are stored to the stack
; after the call frame has been allocated.
;
;                            Allocated together
;                            during frame setup
;                          |_____________________|
;   [prev_frame][VEC, PRED][Non-SVE][call_frame]
;                                              ^
;                                              SP
;========================================================================
declare void @llvm.many_params(i32,i32,i32,i32,i32,i32,i32,i32,i32)

define i64 @spillfill_1p1v2i_sp_fp_nosaves_call9params() #1 {
; CHECK-LABEL: spillfill_1p1v2i_sp_fp_nosaves_call9params
; CHECK: addvl sp,  sp, #-3
; CHECK: {{(add|mov)\ +x29, sp[, #0-9]*}}
  %p0 = alloca %ptype
  %v0 = alloca %vtype
  %ip = alloca i8*
  %i1 = alloca [ 512 x i64 ]

; CHECK: str w8, [sp, #-16]!
; CHECK: bl llvm.many_params
  call void @llvm.many_params(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8)
; CHECK-NOT: add sp, sp, #16

; CHECK: add sp, sp, #1, lsl #12
; CHECK: addvl sp, sp, #3
; CHECK: ret
  ret i64 0
}

attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" }

;========================================================================
; DESCRIPTION:
; Test predicate register is correctly retained after calling a function,
; by spilling it before the call and restoring it right after.
;
;   [prev_frame][VEC, PRED][FR][call_frame]
;                              ^          ^
;                              FP         SP
;========================================================================
declare <n x 8 x i16> @llvm.masked.load.nxv8i16(<n x 8 x i16>*, i32, <n x 8 x i1>, <n x 8 x i16>)
declare void @llvm.masked.store.nxv8i16(<n x 8 x i16>, <n x 8 x i16>*, i32, <n x 8 x i1>)
define i64 @spillfill_1p1v2i_sp_fp_nosaves_call9params_callersave_pred(<n x 8 x i1> *%a, <n x 8 x i16> *%b) #2 {
; CHECK-LABEL: spillfill_1p1v2i_sp_fp_nosaves_call9params_callersave_pred
  %pred = load volatile <n x 8 x i1>, <n x 8 x i1> *%a
  %cond = extractelement <n x 8 x i1> %pred, i64 0
  br i1 %cond, label %do_work, label %do_no_work

do_work:
; CHECK-DAG: ldr  [[PLD:p[0-9]+]], [x0]
; CHECK-DAG: str  [[PLD]], [x29, #8, mul vl]
; CHECK:     bl   llvm.many_params
  call void @llvm.many_params(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8)
; CHECK-DAG: ldr  [[PRLD:p[0-9]+]], [x29, #8, mul vl]

; CHECK-DAG: ld1h {[[ZLD:z[0-9]+]].h}, [[PRLD]]/z,
  %data = call <n x 8 x i16> @llvm.masked.load.nxv8i16(<n x 8 x i16>* %b, i32 2, <n x 8 x i1> %pred, <n x 8 x i16> undef)
; CHECK-DAG: st1h {[[ZLD]].h}, [[PRLD]],
  call void @llvm.masked.store.nxv8i16(<n x 8 x i16> %data, <n x 8 x i16>* %b, i32 2, <n x 8 x i1> %pred)
  br label %do_no_work

do_no_work:
  ret i64 0
}

attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" }

;========================================================================
; DESCRIPTION:
; Load an SVE vector from an array of non-SVE objects on the stack
; without using predication.
;
;========================================================================
define void @spillfill_store_nonsve(<n x 4 x i32> %a) {
; CHECK-LABEL: spillfill_store_nonsve
; CHECK: sub  sp, sp, #256
  %v0 = alloca [ 32 x i32 ]
  %v1 = alloca [ 32 x i32 ]

; CHECK: add  [[BASE:x[0-9]+]], sp, #128
; CHECK: st1w  {z0.s}, {{p[0-9]+}}, {{\[}}[[BASE]]{{\]}}
  %tmp0 = bitcast [32 x i32]* %v0 to <n x 4 x i32>*
  store volatile <n x 4 x i32> %a, <n x 4 x i32>* %tmp0

; CHECK: st1w  {z0.s}, {{p[0-9]+}}, [sp]
  %tmp1 = bitcast [32 x i32]* %v1 to <n x 4 x i32>*
  store volatile <n x 4 x i32> %a, <n x 4 x i32>* %tmp1

; CHECK: add  sp, sp, #256
  ret void
}

;========================================================================
; DESCRIPTION:
; Check alloca's of SVE structures are assigned to an SVE stack region.
;========================================================================
define %svint32x2_t @spillfill_sve_struct(%svint32x2_t %a) {
; CHECK-LABEL: spillfill_sve_struct
; CHECK:       addvl sp, sp, #-2
  %v0 = alloca %svint32x2_t
; CHECK-DAG:   mov  x[[BASE:[0-9]+]], sp
; CHECK-DAG:   st1w {z0.s}, {{p[0-9]+}}, [sp]
; CHECK-DAG:   st1w {z1.s}, {{p[0-9]+}}, [x[[BASE]], #1, mul vl]
  store %svint32x2_t %a, %svint32x2_t* %v0

  %res = load %svint32x2_t, %svint32x2_t* %v0
  ret %svint32x2_t %res
}

;========================================================================
; DESCRIPTION:
; Check that when a predicate fill/spill offset cannot be packed into
; a fill/spill instruction we maintain the remainder's 16-byte alignment
; so that it can be constructed using addvl instructions only.
;
; PL = (2 * N)
; VL = (16 * N)
; Offset = 32 * VL
;        = 32 * 16 * N
;        = 256 * 2 * N
;        = (255 * PL) + PL
; or
;        = (248 * PL) + (8 * PL)
;        = (248 * PL) + VL
;========================================================================
define %ptype @spillfill_sve_predicate_offset_range(%ptype %a) {
; CHECK-LABEL: spillfill_sve_predicate_offset_range
; CHECK:     str   p0, [{{x[0-9]+}}, #248, mul vl]
; CHECK:     ldr   p0, [{{x[0-9]+}}, #248, mul vl]

  ; allocate space to saturate the offset range of the STR_PRI instruction
  %v0 = alloca [ 255 x %ptype ]

  ; use all predicate registers to force %a (in p0) to be spilt
  %p0 = load volatile %ptype, %ptype *@pread
  %p1 = load volatile %ptype, %ptype *@pread
  %p2 = load volatile %ptype, %ptype *@pread
  %p3 = load volatile %ptype, %ptype *@pread
  %p4 = load volatile %ptype, %ptype *@pread
  %p5 = load volatile %ptype, %ptype *@pread
  %p6 = load volatile %ptype, %ptype *@pread
  %p7 = load volatile %ptype, %ptype *@pread
  %p8 = load volatile %ptype, %ptype *@pread
  %p9 = load volatile %ptype, %ptype *@pread
  %p10 = load volatile %ptype, %ptype *@pread
  %p11 = load volatile %ptype, %ptype *@pread
  %p12 = load volatile %ptype, %ptype *@pread
  %p13 = load volatile %ptype, %ptype *@pread
  %p14 = load volatile %ptype, %ptype *@pread
  %p15 = load volatile %ptype, %ptype *@pread

  store volatile %ptype %p0, %ptype* @pwrite
  store volatile %ptype %p1, %ptype* @pwrite
  store volatile %ptype %p2, %ptype* @pwrite
  store volatile %ptype %p3, %ptype* @pwrite
  store volatile %ptype %p4, %ptype* @pwrite
  store volatile %ptype %p5, %ptype* @pwrite
  store volatile %ptype %p6, %ptype* @pwrite
  store volatile %ptype %p7, %ptype* @pwrite
  store volatile %ptype %p8, %ptype* @pwrite
  store volatile %ptype %p9, %ptype* @pwrite
  store volatile %ptype %p10, %ptype* @pwrite
  store volatile %ptype %p11, %ptype* @pwrite
  store volatile %ptype %p12, %ptype* @pwrite
  store volatile %ptype %p13, %ptype* @pwrite
  store volatile %ptype %p14, %ptype* @pwrite
  store volatile %ptype %p15, %ptype* @pwrite

  ; use the alloca region to stop it being deadcoded
  %some.addr = bitcast [ 255 x %ptype ]* %v0 to %ptype*
  store volatile %ptype %p15, %ptype* %some.addr
  ret %ptype %a
}

;========================================================================
; DESCRIPTION:
; Getting the explicit address of a SVE stack object, and use it
; e.g. as parameter to a memcpy.
;
; Added some non-SVE objects and two SVE vectors as 'padding',
; to make the address calculation more interesting:
;
;   [prev_frame][vecs,vpad1,vpad0][ints]
;                    ^                 ^
;                    x1                SP
;
;========================================================================
define void @spillfill_sve_stackobjects_by_reference(i8* %dst, i64 %len) {
; CHECK-LABEL: spillfill_sve_stackobjects_by_reference
; CHECK-DAG: add   [[VECBASE:x[0-9]+]], sp
; CHECK-DAG: addvl x1, [[VECBASE]], #2
  %ints = alloca [ 16 x i32 ]

  %vpad0 = alloca %vtype
  %vpad1 = alloca %vtype
  %vecs = alloca [ 3 x %vtype ]

  %vecsi8 = bitcast [ 3 x %vtype ]* %vecs to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %dst, i8* %vecsi8, i64 %len, i32 1, i1 true)

  ret void
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1)

;========================================================================
; DESCRIPTION:
; For two distinct stack arrays of the same size with non-overlapping
; life ranges, test that they are not unified by checking for
; an ADDVL (to setup SVE region) and 'sub sp, sp, #256' for the
; fixed width vectors.
;========================================================================
define void @spillfill_sve_stackcoloring() {
entry:
; CHECK-LABEL: spillfill_sve_stackcoloring
; CHECK: addvl
; CHECK: sub sp, sp, #256
  %b1 = alloca [16 x <4 x i32>], align 4
  %b2 = alloca [16 x <n x 4 x i32>], align 4
  %0 = bitcast [16 x <4 x i32>]* %b1 to i8*
  call void @llvm.lifetime.start(i64 64, i8* nonnull %0) #3
  %arraydecay = getelementptr inbounds [16 x <4 x i32>], [16 x <4 x i32>]* %b1, i64 0, i64 0
  call void @fill_fixedvl_buffer(<4 x i32>* nonnull %arraydecay) #3
  call void @use_fixedvl_buffer(<4 x i32>* nonnull %arraydecay) #3
  call void @llvm.lifetime.end(i64 64, i8* nonnull %0) #3
  %1 = bitcast [16 x <n x 4 x i32>]* %b2 to i8*
  call void @llvm.lifetime.start(i64 64, i8* nonnull %1) #3
  %arraydecay2 = getelementptr inbounds [16 x <n x 4 x i32>], [16 x <n x 4 x i32>]* %b2, i64 0, i64 0
  call void @fill_varvl_buffer(<n x 4 x i32>* nonnull %arraydecay2) #3
  call void @use_varvl_buffer(<n x 4 x i32>* nonnull %arraydecay2) #3
  call void @llvm.lifetime.end(i64 64, i8* nonnull %1) #3
  ret void
}


;========================================================================
; DESCRIPTION:
; Check that when there are no SVE stack objects, but only SVE callee
; saves, that the FrameRecord (FP+LR) is still correctly overlaid with
; a dummy SVE object.
;========================================================================
declare %vtype @dummyfn()
define %vtype @spillfill_0p0v_fp_1calleesave(i8** %fa) #4 {
entry:
  %tmp = call i8* @llvm.frameaddress(i32 0)
  store i8* %tmp, i8** %fa
; CHECK-LABEL: spillfill_0p0v_fp_1calleesave
; CHECK: addvl sp, sp, #-2
; CHECK: str   z8, [sp, #1, mul vl]
; CHECK: str   x28, [sp, #-16]!
; CHECK: stp   x29, x30, [sp, #16]
; CHECK: add   x29, sp, #16

  %z0 = load volatile %vtype , %vtype *@vread
  %z1 = load volatile %vtype , %vtype *@vread
  %z2 = load volatile %vtype , %vtype *@vread
  %z3 = load volatile %vtype , %vtype *@vread
  %z4 = load volatile %vtype , %vtype *@vread
  %z5 = load volatile %vtype , %vtype *@vread
  %z6 = load volatile %vtype , %vtype *@vread
  %z7 = load volatile %vtype , %vtype *@vread
  %z8 = load volatile %vtype , %vtype *@vread ; needs to be callee saved

  store volatile %vtype %z0, %vtype* @vwrite
  store volatile %vtype %z1, %vtype* @vwrite
  store volatile %vtype %z2, %vtype* @vwrite
  store volatile %vtype %z3, %vtype* @vwrite
  store volatile %vtype %z4, %vtype* @vwrite
  store volatile %vtype %z5, %vtype* @vwrite
  store volatile %vtype %z6, %vtype* @vwrite
  store volatile %vtype %z7, %vtype* @vwrite
  store volatile %vtype %z8, %vtype* @vwrite

  ; Call some SVE function so it will have to spill z8
  %zd = call %vtype @dummyfn()

  ret %vtype %zd
}
attributes #4 = { noinline nounwind "no-frame-pointer-elim"="true" }

declare void @fill_fixedvl_buffer(<4 x i32>*) local_unnamed_addr #2
declare void @use_fixedvl_buffer(<4 x i32>*) local_unnamed_addr #2
declare void @fill_varvl_buffer(<n x 4 x i32>*) local_unnamed_addr #2
declare void @use_varvl_buffer(<n x 4 x i32>*) local_unnamed_addr #2

declare void @llvm.lifetime.start(i64, i8* nocapture) #3
declare void @llvm.lifetime.end(i64, i8* nocapture) #3
attributes #3 = { argmemonly nounwind }
