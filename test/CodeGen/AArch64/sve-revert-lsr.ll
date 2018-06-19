; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -disable-lsr < %s | FileCheck %s

; ModuleID = '../llvm/tmini2.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; LSR loop variable starting at 'K' rather than 0
define void @lsr_non_zero_start(i32* noalias nocapture readonly %ptr, i32* noalias nocapture %ptr2, i64 %K, i64 %N) #0 {
; CHECK-LABEL: lsr_non_zero_start
; CHECK-DAG: add  [[OFFSET_IV:x[0-9]+]], {{x[0-9]+}}, [[IV:x[0-9]+]]
; CHECK-DAG: ld1w {[[VAL:z[0-9]+]].s}, {{p[0-9]+}}/z, {{\[x[0-9]+,}} [[OFFSET_IV]], lsl #2]
; CHECK-DAG: add  [[VAL]].s, [[VAL]].s, #42
; CHECK-DAG: st1w {[[VAL]].s}, {{p[0-9]+}}, {{\[x[0-9]+}}, [[OFFSET_IV]], lsl #2]
; CHECK-DAG: incw [[IV]]
; CHECK: ret
entry:
  %p = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 %K, i64 %N)
  br label %vector.body

vector.body:
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ %K, %entry ]
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %predicate = phi <n x 4 x i1> [ %p, %entry ], [ %4, %vector.body ]
  %0 = bitcast i32* %ptr to i8*
  %1 = bitcast i32* %ptr2 to i8*
  %uglygep1 = getelementptr i8, i8* %0, i64 %lsr.iv
  %uglygep2 = bitcast i8* %uglygep1 to <n x 4 x i32>*
  %wide.masked.load = call <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>* %uglygep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %2 = add nsw <n x 4 x i32> %wide.masked.load, shufflevector (<n x 4 x i32> insertelement (<n x 4 x i32> undef, i32 42, i32 0), <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer)
  %uglygep3 = getelementptr i8, i8* %1, i64 %lsr.iv
  %uglygep4 = bitcast i8* %uglygep3 to <n x 4 x i32>*
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %2, <n x 4 x i32>* %uglygep4, i32 4, <n x 4 x i1> %predicate)
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %3 = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %4 = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 %3, i64 %N)
  %5 = extractelement <n x 4 x i1> %4, i64 0
  %lsr.iv.next = add i64 %lsr.iv, mul (i64 vscale, i64 16)
  br i1 %5, label %vector.body, label %exit

exit:
  ret void
}

; LSR loop variable starting at constant '4' rather than 0
define void @lsr_non_zero_cst_start(i32* noalias nocapture readonly %ptr, i32* noalias nocapture %ptr2, i64 %N) #0 {
; CHECK-LABEL: lsr_non_zero_cst_start
; CHECK-DAG: add  [[OFFSET_LD:x[0-9]+]], x0, #4
; CHECK-DAG: add  [[OFFSET_ST:x[0-9]+]], x1, #4
; CHECK: %vector.body
; CHECK-DAG: ld1w {[[VAL:z[0-9]+]].s}, {{p[0-9]+}}/z, {{\[}}[[OFFSET_LD]], [[IV:x[0-9]+]], lsl #2]
; CHECK-DAG: add  [[VAL]].s, [[VAL]].s, #42
; CHECK-DAG: st1w {[[VAL]].s}, {{p[0-9]+}}, {{\[}}[[OFFSET_ST]], [[IV]], lsl #2]
; CHECK-DAG: incw [[IV]]
; CHECK: ret
entry:
  %p = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 4, i64 %N)
  br label %vector.body

vector.body:
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ 4, %entry ]
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %predicate = phi <n x 4 x i1> [ %p, %entry ], [ %4, %vector.body ]
  %0 = bitcast i32* %ptr to i8*
  %1 = bitcast i32* %ptr2 to i8*
  %uglygep1 = getelementptr i8, i8* %0, i64 %lsr.iv
  %uglygep2 = bitcast i8* %uglygep1 to <n x 4 x i32>*
  %wide.masked.load = call <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>* %uglygep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %2 = add nsw <n x 4 x i32> %wide.masked.load, shufflevector (<n x 4 x i32> insertelement (<n x 4 x i32> undef, i32 42, i32 0), <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer)
  %uglygep3 = getelementptr i8, i8* %1, i64 %lsr.iv
  %uglygep4 = bitcast i8* %uglygep3 to <n x 4 x i32>*
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %2, <n x 4 x i32>* %uglygep4, i32 4, <n x 4 x i1> %predicate)
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %3 = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %4 = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 %3, i64 %N)
  %5 = extractelement <n x 4 x i1> %4, i64 0
  %lsr.iv.next = add i64 %lsr.iv, mul (i64 vscale, i64 16)
  br i1 %5, label %vector.body, label %exit

exit:
  ret void
}

; LSR loop variable starting at constant '4' with additional offset
define void @lsr_non_zero_cst_start_with_offset(i32* noalias nocapture readonly %ptr, i32* noalias nocapture %ptr2, i64 %N) #0 {
; CHECK-LABEL: lsr_non_zero_cst_start_with_offset
; CHECK-DAG: add  [[OFFSET_LD:x[0-9]+]], x0, #20
; CHECK-DAG: add  [[OFFSET_ST:x[0-9]+]], x1, #4
; CHECK: %vector.body
; CHECK-DAG: ld1w {[[VAL:z[0-9]+]].s}, {{p[0-9]+}}/z, {{\[}}[[OFFSET_LD]], [[IV:x[0-9]+]], lsl #2]
; CHECK-DAG: add  [[VAL]].s, [[VAL]].s, #42
; CHECK-DAG: st1w {[[VAL]].s}, {{p[0-9]+}}, {{\[}}[[OFFSET_ST]], [[IV]], lsl #2]
; CHECK-DAG: incw [[IV]]
; CHECK: ret
entry:
  %p = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 4, i64 %N)
  br label %vector.body

vector.body:
  %lsr.iv = phi i64 [ %lsr.iv.next, %vector.body ], [ 4, %entry ]
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %predicate = phi <n x 4 x i1> [ %p, %entry ], [ %4, %vector.body ]
  %0 = bitcast i32* %ptr to i8*
  %1 = bitcast i32* %ptr2 to i8*
  %uglygep1 = getelementptr i8, i8* %0, i64 %lsr.iv
  %uglygep1off = getelementptr i8, i8* %uglygep1, i64 16
  %uglygep2 = bitcast i8* %uglygep1off to <n x 4 x i32>*
  %wide.masked.load = call <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>* %uglygep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %2 = add nsw <n x 4 x i32> %wide.masked.load, shufflevector (<n x 4 x i32> insertelement (<n x 4 x i32> undef, i32 42, i32 0), <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer)
  %uglygep3 = getelementptr i8, i8* %1, i64 %lsr.iv
  %uglygep4 = bitcast i8* %uglygep3 to <n x 4 x i32>*
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %2, <n x 4 x i32>* %uglygep4, i32 4, <n x 4 x i1> %predicate)
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %3 = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %4 = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 %3, i64 %N)
  %5 = extractelement <n x 4 x i1> %4, i64 0
  %lsr.iv.next = add i64 %lsr.iv, mul (i64 vscale, i64 16)
  br i1 %5, label %vector.body, label %exit

exit:
  ret void
}

; LSR Running pointer with scalar type
;
define void @lsr_ptr(i32* %ptr, <n x 4 x i32> %val, i64 %N) #0 {
; CHECK-LABEL: lsr_ptr
; CHECK-DAG: st1w    {{{z[-0-9]+}}.s}, {{p[0-9]+}}, [x0, [[IV:x[0-9]+]], lsl #2]
; CHECK-DAG: incw    [[IV]]
; CHECK: ret
entry:
  %p = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 0, i64 %N)
  br label %vector.body

vector.body:
  %lsr = phi i32* [ %ptr, %entry ], [ %3, %vector.body ]
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %predicate = phi <n x 4 x i1> [ %p, %entry ], [ %1, %vector.body ]
  %lsr.use = bitcast i32* %lsr to <n x 4 x i32>*
  %lsr.upd = bitcast i32* %lsr to i1*
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %val, <n x 4 x i32>* %lsr.use, i32 4, <n x 4 x i1> %predicate)
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %0 = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %1 = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 %0, i64 %N)
  %2 = extractelement <n x 4 x i1> %1, i64 0
  %scevgep = getelementptr i1, i1* %lsr.upd, i64 mul (i64 vscale, i64 16)
  %3 = bitcast i1* %scevgep to i32*
  br i1 %2, label %vector.body, label %exit

exit:
  ret void
}


; LSR Running pointer with array type
;
define void @lsr_ptr2d(i32* noalias nocapture readonly %ptr, <n x 4 x i32> %val, i64 %N) #0 {
; CHECK-LABEL: lsr_ptr2d
; CHECK-DAG: mov   [[ARRAYOBJ:x[0-9]+]], sp
; CHECK-DAG: st1w  {{{z[-0-9]+}}.s}, {{p[0-9]+}}, {{\[}}[[ARRAYOBJ]], [[IV:x[0-9]+]], lsl #2]
; CHECK-DAG: incw  [[IV]]
; CHECK: ret
entry:
  %Array = alloca [100 x [100 x i32]], align 4
  %p = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 0, i64 %N)
  br label %vector.body

vector.body:
  %lsr = phi [100 x [100 x i32]]* [ %Array, %entry ], [ %3, %vector.body ]
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %predicate = phi <n x 4 x i1> [ %p, %entry ], [ %1, %vector.body ]
  %lsr.use = bitcast [100 x [100 x i32]]* %lsr to <n x 4 x i32>*
  %lsr.upd = bitcast [100 x [100 x i32]]* %lsr to i1*
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %val, <n x 4 x i32>* %lsr.use, i32 4, <n x 4 x i1> %predicate)
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %0 = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %1 = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 %0, i64 %N)
  %2 = extractelement <n x 4 x i1> %1, i64 0
  %scevgep = getelementptr i1, i1* %lsr.upd, i64 mul (i64 vscale, i64 16)
  %3 = bitcast i1* %scevgep to [100 x [100 x i32]]*
  br i1 %2, label %vector.body, label %exit

exit:
  ret void
}

; LSR two uses for a pointer update (used in both a BC->PHI and directly as PHI)
;
define void @lsr_ptr_update_2uses(i32* noalias %ptr, i32* noalias %ptr2,  <n x 4 x i32> %val, <n x 4 x i32> %val2, i64 %N) {
; CHECK-LABEL: lsr_ptr_update_2uses
; CHECK-NOT: add {{x[0-9]+}}, x0, {{x[0-9]+}}, lsl #2
entry:
  %p = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 0, i64 %N)
  %ptrbc = bitcast i32* %ptr to i1*
  br label %vector.body

vector.body:
  %lsr = phi i32* [ %ptr, %entry ], [ %3, %vector.body ]
  %lsr2 = phi i1* [ %ptrbc, %entry ], [ %scevgep, %vector.body ]
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %predicate = phi <n x 4 x i1> [ %p, %entry ], [ %1, %vector.body ]
  %lsr2.use = bitcast i1* %lsr2 to <n x 4 x i32>*
  %loadval = call <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>* %lsr2.use, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %storegep = getelementptr i32, i32* %ptr2, i64 %index
  %storeptr = bitcast i32* %storegep to <n x 4 x i32>*
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %loadval, <n x 4 x i32>* %storeptr, i32 4, <n x 4 x i1> %predicate)
  %lsr.use = bitcast i32* %lsr to <n x 4 x i32>*
  %lsr.upd = bitcast i32* %lsr to i1*
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %val, <n x 4 x i32>* %lsr.use, i32 4, <n x 4 x i1> %predicate)
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %0 = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %1 = call <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64 %0, i64 %N)
  %2 = extractelement <n x 4 x i1> %1, i64 0
  %scevgep = getelementptr i1, i1* %lsr.upd, i64 mul (i64 vscale, i64 16)
  %3 = bitcast i1* %scevgep to i32*
  br i1 %2, label %vector.body, label %exit

exit:
  ret void
}

; Function Attrs: argmemonly nounwind readonly
declare <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>*, i32, <n x 4 x i1>, <n x 4 x i32>) #1

; Function Attrs: argmemonly nounwind readonly
declare <n x 4 x i1> @llvm.aarch64.sve.whilelo.nxv4i1.i64(i64, i64)

; Function Attrs: argmemonly nounwind
declare void @llvm.masked.store.nxv4i32(<n x 4 x i32>, <n x 4 x i32>*, i32, <n x 4 x i1>) #2

; Function Attrs: nounwind
declare void @llvm.assume(i1) #3

attributes #0 = { norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind readonly }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }
