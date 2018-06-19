; RUN: llc < %s -verify-machineinstrs -mtriple=arm64-none-linux-gnu -mattr=+sve -fp-contract=fast | FileCheck %s

; The checks in this file are a little more specific than I'd like - they assume
; the stack needs to look like this:
; -   <8 x ZPR register>
; |    <%vld (ZPR2, ZPR3 or ZPR4, depending on the test)>
; |    <8x predicate registers (requiring one vl of space)
; -   <--- pointer from which %vld is offset

; However, the code to calculate the offset is slightly non-trivial, because the
; immediate field for st2,3,4 is very restricted, and it's worth guarding that
; we don't accidentally mess it up

; If the above assumptions about stack layout change, the addvl and offset
; checks below may need to change accordingly

define <n x 4 x i32> @spill.ZPR2Reg(<n x 4 x i32>* %arg1, i32 %arg2, <n x 4 x i1> %gp) {
; CHECK-LABEL: spill.ZPR2Reg:
; CHECK: ld2w {z[[SUB0:[0-9]+]].s, z[[SUB1:[0-9]+]].s}, p0/z, [x0]
; CHECK: addvl sp, sp, #-26
; CHECK: addvl sp, sp, #-2
; CHECK: st2b {z[[SUB0]].b, z[[SUB1]].b}, {{p[0-9+]}}, [{{x[0-9]+|sp}}, #2, mul vl]
; CHECK: ld2b {z{{[0-9]+}}.b, z{{[0-9]+}}.b}, {{p[0-9+]/z}}, [{{x[0-9]+|sp}}
entry:
  %vld = tail call { <n x 4 x i32>, <n x 4 x i32> } @llvm.aarch64.sve.ld2.nxv4i32(<n x 4 x i1> %gp, <n x 4 x i32>* %arg1)
  %cmp = icmp eq i32 %arg2, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @foo()
  br label %if.end

if.end:
  %res = extractvalue { <n x 4 x i32>, <n x 4 x i32> } %vld, 0
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @spill.ZPR3Reg(<n x 4 x i32>* %arg1, i32 %arg2, <n x 4 x i1> %gp) {
; CHECK-LABEL: spill.ZPR3Reg:
; CHECK: ld3w {z[[SUB0:[0-9]+]].s, z[[SUB1:[0-9]+]].s, z[[SUB2:[0-9]+]].s}, p0/z, [x0]
; CHECK: addvl sp, sp, #-28
; CHECK: addvl sp, sp, #-2
; CHECK: st3b {z[[SUB0]].b, z[[SUB1]].b, z[[SUB2]].b}, {{p[0-9+]}}, [{{x[0-9]+|sp}}, #3, mul vl]
; CHECK: ld3b {z{{[0-9]+}}.b, z{{[0-9]+}}.b, z{{[0-9]+}}.b}, {{p[0-9+]/z}}, [{{x[0-9]+|sp}}
entry:
  %vld = tail call { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> } @llvm.aarch64.sve.ld3.nxv4i32(<n x 4 x i1> %gp, <n x 4 x i32>* %arg1)
  %cmp = icmp eq i32 %arg2, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @foo()
  br label %if.end

if.end:
  %res = extractvalue { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> } %vld, 0
  ret <n x 4 x i32> %res
}

; Spill a register to a stack slot that should be '3 VL aligned'
; making sure that the calculated address does not fully fit the
; immediate so that it is split up into a separate 'addvl' and
; an immediate that is still a multiple of 3.
; Layout of frame:
;      +---------------+
;      |vector regsaves| z8-z15
; 27 ->| . . . . . . . |
;      |vector spills  | z1-z3 (at VLx3 aligned offset)
; 24 ->| . . . . . . . |
;      |    padding    |
; 23 ->| . . . . . . . |
;      |   someobjs    | alloca [ 21 x vector ]
;  2 ->+---------------+
;      |predicate saves| p8-p15
;  1 ->| . . . . . . . |
;      |overlap with fr| (x29,x30)
;      +---------------+  <- FP
;      |      x28      |
;      +---------------+
define <n x 4 x i32> @spill.ZPR3RegUnaligned(<n x 4 x i32> %dummy, <n x 4 x i32>* %arg1, i32 %arg2, <n x 4 x i1> %gp) #2 {
; CHECK-LABEL: spill.ZPR3RegUnaligned
; CHECK: ld3w {z[[SUB0:[0-9]+]].s, z[[SUB1:[0-9]+]].s, z[[SUB2:[0-9]+]].s}, p0/z, [x0]
; CHECK: st1w  {z0.s}, {{p[0-9]+}}, [x29, #3, mul vl]
; CHECK: addvl [[BASE:x[0-9]+]], x29, #3
; CHECK: st3b {z[[SUB0]].b, z[[SUB1]].b, z[[SUB2]].b}, {{p[0-9+]}}, {{\[}}[[BASE]], #21, mul vl]
entry:
  %someobjs = alloca [ 21 x <n x 4 x i32> ]
  %vld = tail call { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> } @llvm.aarch64.sve.ld3.nxv4i32(<n x 4 x i1> %gp, <n x 4 x i32>* %arg1)

  ; insert some use of 'someobjs' so its not optimised away
  %someaddr = getelementptr [21 x <n x 4 x i32>], [21 x <n x 4 x i32>]* %someobjs, i64 0, i64 0
  store volatile <n x 4 x i32> %dummy, <n x 4 x i32>* %someaddr

  %cmp = icmp eq i32 %arg2, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @foo()
  br label %if.end

if.end:
  %res = extractvalue { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> } %vld, 0
  ret <n x 4 x i32> %res
}

attributes #2 = { "no-frame-pointer-elim"="true" }

define <n x 4 x i32> @spill.ZPR4Reg(<n x 4 x i32>* %arg1, i32 %arg2, <n x 4 x i1> %gp) {
; CHECK-LABEL: spill.ZPR4Reg:
; CHECK: ld4w {z[[SUB0:[0-9]+]].s, z[[SUB1:[0-9]+]].s, z[[SUB2:[0-9]+]].s, z[[SUB3:[0-9]+]].s}, p0/z, [x0]
; CHECK: addvl sp, sp, #-30
; CHECK: addvl sp, sp, #-2
; CHECK: st4b {z[[SUB0]].b, z[[SUB1]].b, z[[SUB2]].b, z[[SUB3]].b}, {{p[0-9+]}}, [{{x[0-9]+|sp}}, #4, mul vl]
; CHECK: ld4b {z{{[0-9]+}}.b, z{{[0-9]+}}.b, z{{[0-9]+}}.b, z{{[0-9]+}}.b}, {{p[0-9+]/z}}, [{{x[0-9]+|sp}}
entry:
  %vld = tail call { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> } @llvm.aarch64.sve.ld4.nxv4i32(<n x 4 x i1> %gp, <n x 4 x i32>* %arg1)
  %cmp = icmp eq i32 %arg2, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @foo()
  br label %if.end

if.end:
  %res = extractvalue { <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32> } %vld, 0
  ret <n x 4 x i32> %res
}

declare void @foo()

declare {<n x 4 x i32>, <n x 4 x i32>}                               @llvm.aarch64.sve.ld2.nxv4i32(<n x 4 x i1>,  <n x 4 x i32>*)
declare {<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>}                @llvm.aarch64.sve.ld3.nxv4i32(<n x 4 x i1>,  <n x 4 x i32>*)
declare {<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} @llvm.aarch64.sve.ld4.nxv4i32(<n x 4 x i1>,  <n x 4 x i32>*)
