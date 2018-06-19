; RUN: opt -mtriple aarch64-linux-generic -mattr=+sve -O3 \
; RUN:  -disable-loop-vectorization -sve-loop-vectorize -force-scalable-vectorization \
; RUN:  -S -verify-loop-info -verify-dom-info < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

;; Here we are checking that when vectorising a loop with a data dependency we
;; correctly force the vector width to be no larger than the dependency width,
;; which means disabling scalable vectorisation for small dependencies.
;;
;; For example:
;;   for(;;) a[i+4] = a[i] + C
;;
;; is only safe to vectorise when the vector is restricted to 4 elements.

;CHECK-LABEL: @small_data_dependency(
;CHECK-LABEL: vector.body
;CHECK-NOT: <n x
;CHECK-LABEL: for.body
;CHECK ret

; Function Attrs: nounwind
define void @small_data_dependency(i32* noalias nocapture %d, i32* noalias nocapture readonly %a, i32 %count) #0 {
entry:
  %cmp.11 = icmp sgt i32 %count, 0
  br i1 %cmp.11, label %for.body.lr.ph, label %for.exit

for.body.lr.ph:                                   ; preds = %entry
  %0 = sext i32 %count to i64
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %i.012 = phi i64 [ 0, %for.body.lr.ph ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* %d, i64 %i.012
  %1 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %arrayidx2 = getelementptr inbounds i32, i32* %a, i64 %i.012
  %2 = load i32, i32* %arrayidx2, align 4, !tbaa !1
  %add = add nsw i32 %2, %1
  %add3 = add nuw nsw i64 %i.012, 4
  %arrayidx4 = getelementptr inbounds i32, i32* %d, i64 %add3
  store i32 %add, i32* %arrayidx4, align 4, !tbaa !1
  %inc = add nuw nsw i64 %i.012, 1
  %exitcond = icmp eq i64 %inc, %0
  br i1 %exitcond, label %for.exit, label %for.body

for.exit:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void
}

;; This test is a repeat of the above but for the case when the dependency gap
;; is known to be larger than the target's architected maximum register size
;; and is thus safe to vectorise using scalable types.

;CHECK-LABEL: @large_data_dependency(
;CHECK-LABEL: vector.body
;CHECK-NOT: <{{[0-9]+}} x
;CHECK-LABEL: for.body
;CHECK ret

; Function Attrs: nounwind
define void @large_data_dependency(i32* noalias nocapture %d, i32* noalias nocapture readonly %a, i32 %count) #0 {
entry:
  %cmp.11 = icmp sgt i32 %count, 0
  br i1 %cmp.11, label %for.body.lr.ph, label %for.exit

for.body.lr.ph:                                   ; preds = %entry
  %0 = sext i32 %count to i64
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %i.012 = phi i64 [ 0, %for.body.lr.ph ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* %d, i64 %i.012
  %1 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %arrayidx2 = getelementptr inbounds i32, i32* %a, i64 %i.012
  %2 = load i32, i32* %arrayidx2, align 4, !tbaa !1
  %add = add nsw i32 %2, %1
  %add3 = add nuw nsw i64 %i.012, 64
  %arrayidx4 = getelementptr inbounds i32, i32* %d, i64 %add3
  store i32 %add, i32* %arrayidx4, align 4, !tbaa !1
  %inc = add nuw nsw i64 %i.012, 1
  %exitcond = icmp eq i64 %inc, %0
  br i1 %exitcond, label %for.exit, label %for.body

for.exit:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
