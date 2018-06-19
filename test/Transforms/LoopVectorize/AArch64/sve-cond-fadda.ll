; RUN: opt -S -O3 -basicaa -disable-loop-vectorization --sve-loop-vectorize -force-scalable-vectorization -force-vector-predication < %s 2>&1 | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; Check we can vectorise conditional ordered reductions. Note the following
; loop contains a mixture of normal and reducing adds, which check only the
; reducing add is matched as an ordered instruction.

; clang -O3 -emit-llvm -S -target aarch64-generic-linux -march=armv8-a+sve -c
; float func(float* restrict a, float* restrict b, int count) {
;   float res = 0.0f;
;   for (int i = 0; i < count; ++i)
;     if (a[1] > 0.5f)
;       res += a[i] + b[i];
;   return res;
; }

; CHECK-LABEL: vector.body:
; CHECK: fadd
; CHECK: call float @llvm.experimental.vector.reduce.fadd.f32.f32.nxv4f32(float %

; Function Attrs: norecurse nounwind readonly
define float @func(float* noalias nocapture readonly %a, float* noalias nocapture readonly %b, i32 %count) #0 {
entry:
  %cmp13 = icmp sgt i32 %count, 0
  br i1 %cmp13, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %arrayidx = getelementptr inbounds float, float* %a, i64 1
  %0 = load float, float* %arrayidx, align 4, !tbaa !1
  %cmp1 = fcmp ogt float %0, 5.000000e-01
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.inc
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %res.0.lcssa = phi float [ 0.000000e+00, %entry ], [ %res.1, %for.cond.cleanup.loopexit ]
  ret float %res.0.lcssa

for.body:                                         ; preds = %for.inc, %for.body.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %res.014 = phi float [ 0.000000e+00, %for.body.lr.ph ], [ %res.1, %for.inc ]
  br i1 %cmp1, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %arrayidx2 = getelementptr inbounds float, float* %a, i64 %indvars.iv
  %1 = load float, float* %arrayidx2, align 4, !tbaa !1
  %arrayidx4 = getelementptr inbounds float, float* %b, i64 %indvars.iv
  %2 = load float, float* %arrayidx4, align 4, !tbaa !1
  %add = fadd float %1, %2
  %add5 = fadd float %res.014, %add
  br label %for.inc

for.inc:                                          ; preds = %for.body, %if.then
  %res.1 = phi float [ %add5, %if.then ], [ %res.014, %for.body ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %count
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

attributes #0 = { norecurse nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"float", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
