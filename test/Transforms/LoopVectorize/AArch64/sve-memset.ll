; RUN: opt -mtriple aarch64-none-linux-gnu -mattr=+sve -O3 -disable-loop-vectorization -sve-loop-vectorize \
; RUN:      -force-scalable-vectorization -force-vector-predication \
; RUN:      -vectorize-memset -S < %s | FileCheck %s

; RUN: opt -mtriple aarch64-none-linux-gnu -mattr=+sve -O3 -disable-loop-vectorization -sve-loop-vectorize \
; RUN:     -force-scalable-vectorization -force-vector-predication \
; RUN:     -vectorize-memset -vectorize-memset-threshold=9 -S < %s | FileCheck --check-prefix=THRESHOLD %s

; RUN: opt -mtriple aarch64-none-linux-gnu -mattr=+neon -O3 -loop-vectorize \
; RUN:      -vectorize-memset -S < %s | FileCheck %s --check-prefix=NEON

; clang -target aarch64-linux-gnu    -march=armv8-a+sve memset.c -c -S -emit-llvm -o - -O3 -fno-vectorize --sysroot=/opt/aarch64-newlib/aarch64-elf/ > ../organic-llvm/test/Transforms/LoopVectorize/AArch64/memset2.ll
;
; //-- memset.c
; #include <string.h>
; // Vectorizes because of the restrict qualifiers.
; void non_contiguous_multiple(float * restrict a, int * restrict b, unsigned N) {
;   int i;
;   for (int i=0; i < N; ++i) {
;     memset(a + b[i], 0, 4 * sizeof(float));
;   }
; }
; Does not vectorize becase the size of the write is unknown.
; void non_contiguous_multiple_non_constant_length(float * restrict a, int * restrict b, unsigned N, unsigned size) {
;   int i;
;   for (int i=0; i < N; ++i) {
;     memset(a + b[i], 0, size);
;   }
; }
; // Does not vectorize because the restrict qualifiers are missing.
; void non_contiguous_multiple_alias(float * a, int * b, unsigned N) {
;   int i;
;   for (int i=0; i < N; ++i) {
;     memset(a + b[i], 0, 4 * sizeof(float));
;   }
; }
; // Vectorizes only if -vectorize-memset-threshold >= 9
; void non_contiguous_multiple_threshold(float * restrict a, int * restrict b, unsigned N) {
;   int i;
;   for (int i=0; i < N; ++i) {
;     memset(a + b[i], 0, 9 * sizeof(float));
;   }
; }
; // Demonstrate vectorization even with non-zero values.
; void non_contiguous_multiple_non_zero(float * restrict a, int * restrict b, unsigned N, char %val) {
;   int i;
;   for (int i=0; i < N; ++i) {
;     memset(a + b[i], val, 4 * sizeof(float));
;   }
; }

; // Demonstrate vectorization even with non-zero constant values.
; void non_contiguous_multiple_non_zero_constant(float * restrict a, int * restrict b, unsigned N, char %val) {
;   int i;
;   for (int i=0; i < N; ++i) {
;     memset(a + b[i], val, 4 * sizeof(float));
;   }
; }

; ModuleID = '../memset.c'
source_filename = "../memset.c"
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

; Function Attrs: nounwind
define void @non_contiguous_multiple(float* noalias nocapture %a, i32* noalias nocapture readonly %b, i32 %N) #2 {
; CHECK-LABEL: @non_contiguous_multiple(
; CHECK-NOT: memset
; CHECK:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; CHECK:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; CHECK:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; CHECK:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; CHECK: ret
; NEON-LABEL: @non_contiguous_multiple(
; NEON-NOT: x {{[0-9]}}>
; NEON: memset
entry:
  %cmp6 = icmp eq i32 %N, 0
  br i1 %cmp6, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %idx.ext = sext i32 %0 to i64
  %add.ptr = getelementptr inbounds float, float* %a, i64 %idx.ext
  %1 = bitcast float* %add.ptr to i8*
  tail call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 16, i32 4, i1 false)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %N
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

; Function Attrs: nounwind
define void @non_contiguous_multiple_non_constant_length(float* noalias nocapture %a, i32* noalias nocapture readonly %b, i32 %N, i64 %size) #2 {
; CHECK-LABEL: @non_contiguous_multiple_non_constant_length(
; CHECK-NOT: llvm.masked.scatter.nxv2i32
; CHECK: memset
; NEON-LABEL: @non_contiguous_multiple_non_constant_length(
; NEON-NOT: x {{[0-9]}}>
; NEON: memset
entry:
  %cmp6 = icmp eq i32 %N, 0
  br i1 %cmp6, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %idx.ext = sext i32 %0 to i64
  %add.ptr = getelementptr inbounds float, float* %a, i64 %idx.ext
  %1 = bitcast float* %add.ptr to i8*
  tail call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 %size, i32 4, i1 false)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %N
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

; Function Attrs: nounwind
define void @non_contiguous_multiple_alias(float* nocapture %a, i32* nocapture readonly %b, i32 %N) #2 {
; CHECK-LABEL: @non_contiguous_multiple_alias(
; CHECK-NOT:  call void @llvm.masked.scatter
; CHECK: memset
; NEON-LABEL: @non_contiguous_multiple_alias(
; NEON-NOT: x {{[0-9]}}>
; NEON: memset
entry:
  %cmp6 = icmp eq i32 %N, 0
  br i1 %cmp6, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %idx.ext = sext i32 %0 to i64
  %add.ptr = getelementptr inbounds float, float* %a, i64 %idx.ext
  %1 = bitcast float* %add.ptr to i8*
  tail call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 16, i32 4, i1 false)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %N
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

define void @non_contiguous_multiple_threshold(float* noalias nocapture %a, i32* noalias nocapture readonly %b, i32 %N) #2 {
; CHECK-LABEL: @non_contiguous_multiple_threshold(
; CHECK-NOT: @llvm.masked.scatter
; CHECK-NOT: <n x
; CHECK: memset
; THRESHOLD-LABEL: @non_contiguous_multiple_threshold(
; THRESHOLD-NOT: memset
; THRESHOLD:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; THRESHOLD:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; THRESHOLD:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; THRESHOLD:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; THRESHOLD:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; THRESHOLD:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; THRESHOLD:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; THRESHOLD:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; THRESHOLD:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> zeroinitializer
; THRESHOLD: ret
; NEON-LABEL: @non_contiguous_multiple_threshold(
; NEON-NOT: x {{[0-9]}}>
; NEON: memset
entry:
  %cmp6 = icmp eq i32 %N, 0
  br i1 %cmp6, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %idx.ext = sext i32 %0 to i64
  %add.ptr = getelementptr inbounds float, float* %a, i64 %idx.ext
  %1 = bitcast float* %add.ptr to i8*
  tail call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 36, i32 4, i1 false)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %N
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

define void @non_contiguous_multiple_non_zero(float* noalias nocapture %a, i32* noalias nocapture readonly %b, i32 %N, i8 %val) #2 {
; CHECK-LABEL: @non_contiguous_multiple_non_zero(
; CHECK-NOT: memset
; CHECK:  %[[IDX0:.+]] = insertelement <n x 16 x i8> undef, i8 %val, i32 0
; CHECK:  %[[IDX1:.+]] = shufflevector <n x 16 x i8> %[[IDX0]], <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
; CHECK:  %[[SPLAT:[0-9]+]] = bitcast <n x 16 x i8> %[[IDX1]] to <n x 4 x i32>
; CHECK:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %[[SPLAT]]
; CHECK:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %[[SPLAT]]
; CHECK:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %[[SPLAT]]
; CHECK:  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %[[SPLAT]]
; CHECK: ret
; NEON-LABEL: @non_contiguous_multiple_non_zero(
; NEON-NOT: x {{[0-9]}}>
; NEON: memset
entry:
  %cmp6 = icmp eq i32 %N, 0
  br i1 %cmp6, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %idx.ext = sext i32 %0 to i64
  %add.ptr = getelementptr inbounds float, float* %a, i64 %idx.ext
  %1 = bitcast float* %add.ptr to i8*
  tail call void @llvm.memset.p0i8.i64(i8* %1, i8 %val, i64 16, i32 4, i1 false)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %N
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

define void @non_contiguous_multiple_non_zero_constant(float* noalias nocapture %a, i32* noalias nocapture readonly %b, i32 %N) #2 {
; CHECK-LABEL: @non_contiguous_multiple_non_zero_constant(
; CHECK-NOT: memset
; CHECK: call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> bitcast (<n x 16 x i8> shufflevector (<n x 16 x i8> insertelement (<n x 16 x i8> undef, i8 1, i32 0), <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer) to <n x 4 x i32>)
; CHECK: call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> bitcast (<n x 16 x i8> shufflevector (<n x 16 x i8> insertelement (<n x 16 x i8> undef, i8 1, i32 0), <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer) to <n x 4 x i32>)
; CHECK: call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> bitcast (<n x 16 x i8> shufflevector (<n x 16 x i8> insertelement (<n x 16 x i8> undef, i8 1, i32 0), <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer) to <n x 4 x i32>)
; CHECK: call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> bitcast (<n x 16 x i8> shufflevector (<n x 16 x i8> insertelement (<n x 16 x i8> undef, i8 1, i32 0), <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer) to <n x 4 x i32>)
; CHECK: ret
; NEON-LABEL: @non_contiguous_multiple_non_zero_constant(
; NEON-NOT: x {{[0-9]}}>
; NEON: memset
entry:
  %cmp6 = icmp eq i32 %N, 0
  br i1 %cmp6, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %idx.ext = sext i32 %0 to i64
  %add.ptr = getelementptr inbounds float, float* %a, i64 %idx.ext
  %1 = bitcast float* %add.ptr to i8*
  tail call void @llvm.memset.p0i8.i64(i8* %1, i8 1, i64 16, i32 4, i1 false)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %N
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

; Check large alignments are clamped to something we can vectorise,
; whilst still remaining in alignment.
define void @non_contiguous_multiple_16byte_aligned(float* noalias nocapture %a, i32* noalias nocapture readonly %b, i32 %N) #2 {
; CHECK-LABEL: @non_contiguous_multiple_16byte_aligned(
; CHECK-NOT: memset
; CHECK:  call void @llvm.masked.scatter.nxv4i64.nxv4p0i64(<n x 4 x i64> zeroinitializer
; CHECK:  call void @llvm.masked.scatter.nxv4i64.nxv4p0i64(<n x 4 x i64> zeroinitializer
; CHECK: ret
; NEON-LABEL: @non_contiguous_multiple_16byte_aligned(
; NEON-NOT: x {{[0-9]}}>
; NEON: memset
entry:
  %cmp6 = icmp eq i32 %N, 0
  br i1 %cmp6, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %idx.ext = sext i32 %0 to i64
  %add.ptr = getelementptr inbounds float, float* %a, i64 %idx.ext
  %1 = bitcast float* %add.ptr to i8*
  ; Note the larger than normal 16byte alignment.
  tail call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 16, i32 16, i1 false)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %N
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

attributes #0 = { norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
