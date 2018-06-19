; RUN: opt < %s -sve-loop-vectorize -mtriple=aarch64-none-linux-gnu -mattr=+sve -force-vector-width=2 -force-scalable-vectorization -S | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"

; Function Attrs: nounwind
define void @func64(i64* noalias nocapture %d, i64 %a, i32 %count) #0 {
; CHECK-LABEL: @func64
; CHECK: store <n x 2 x i64>
; CHECK: ret void
entry:
  %cmp3 = icmp eq i32 %count, 0
  br i1 %cmp3, label %for.end, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %0 = add i32 %count, -1
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i64, i64* %d, i64 %indvars.iv
  store i64 %a, i64* %arrayidx, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %0
  br i1 %exitcond, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  ret void
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
