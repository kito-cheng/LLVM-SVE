; RUN: opt -S < %s -basicaa -sve-loop-vectorize -force-scalable-vectorization -force-vector-predication -force-vector-interleave=2 2>&1 | FileCheck %s

; This tests make sure that subtraction is not misintepreted as an
; ordered reduction (it prevents LNT failures).

; clang -O3 -emit-llvm -S -target aarch64-generic-linux -march=armv8-a+sve -c reduce.c -o -
;
; float reduce(int **restrict a, int len, float startvalue) {
;   float sum = startvalue;
;   for (int i = 0; i < len; ++i) {
;     for (int j = 0; j < len; ++j) {
;       sum = sum - a[i][j];
;     }
;   }
;   return sum;
; }

; ModuleID = 'reduce.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-generic-linux"

; Function Attrs: norecurse nounwind readonly
; CHECK-LABEL: @reduce
; CHECK-NOT: vector.body
; CHECK-NOT: @llvm.aarch64.sve.fadda.
; CHECK: ret
define float @reduce(i32** noalias nocapture readonly %a, i32 %len, float %startvalue) #0 {
entry:
  %cmp.22 = icmp sgt i32 %len, 0
  br i1 %cmp.22, label %for.body.4.lr.ph.us.preheader, label %for.cond.cleanup

for.body.4.lr.ph.us.preheader:                    ; preds = %entry
  br label %for.body.4.lr.ph.us

for.body.4.us:                                    ; preds = %for.body.4.us, %for.body.4.lr.ph.us
  %indvars.iv = phi i64 [ 0, %for.body.4.lr.ph.us ], [ %indvars.iv.next, %for.body.4.us ]
  %sum.120.us = phi float [ %sum.023.us, %for.body.4.lr.ph.us ], [ %sub.us, %for.body.4.us ]
  %arrayidx6.us = getelementptr inbounds i32, i32* %1, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx6.us, align 4, !tbaa !1
  %conv.us = sitofp i32 %0 to float
  %sub.us = fsub float %sum.120.us, %conv.us
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %len
  br i1 %exitcond, label %for.cond.1.for.cond.cleanup.3_crit_edge.us, label %for.body.4.us

for.body.4.lr.ph.us:                              ; preds = %for.body.4.lr.ph.us.preheader, %for.cond.1.for.cond.cleanup.3_crit_edge.us
  %indvars.iv26 = phi i64 [ %indvars.iv.next27, %for.cond.1.for.cond.cleanup.3_crit_edge.us ], [ 0, %for.body.4.lr.ph.us.preheader ]
  %sum.023.us = phi float [ %sub.us.lcssa, %for.cond.1.for.cond.cleanup.3_crit_edge.us ], [ %startvalue, %for.body.4.lr.ph.us.preheader ]
  %arrayidx.us = getelementptr inbounds i32*, i32** %a, i64 %indvars.iv26
  %1 = load i32*, i32** %arrayidx.us, align 8, !tbaa !5
  br label %for.body.4.us

for.cond.1.for.cond.cleanup.3_crit_edge.us:       ; preds = %for.body.4.us
  %sub.us.lcssa = phi float [ %sub.us, %for.body.4.us ]
  %indvars.iv.next27 = add nuw nsw i64 %indvars.iv26, 1
  %lftr.wideiv28 = trunc i64 %indvars.iv.next27 to i32
  %exitcond29 = icmp eq i32 %lftr.wideiv28, %len
  br i1 %exitcond29, label %for.cond.cleanup.loopexit, label %for.body.4.lr.ph.us

for.cond.cleanup.loopexit:                        ; preds = %for.cond.1.for.cond.cleanup.3_crit_edge.us
  %sub.us.lcssa.lcssa = phi float [ %sub.us.lcssa, %for.cond.1.for.cond.cleanup.3_crit_edge.us ]
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %sum.0.lcssa = phi float [ %startvalue, %entry ], [ %sub.us.lcssa.lcssa, %for.cond.cleanup.loopexit ]
  ret float %sum.0.lcssa
}

attributes #0 = { norecurse nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"any pointer", !3, i64 0}
