; RUN: opt  -mtriple aarch64-linux-generic -march=armv8-a -mattr=+sve -S < %s  -basicaa -sve-loop-vectorize -force-scalable-vectorization -force-vector-predication --force-vector-interleave=2  -force-vector-width=1 2>&1 | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-generic-linux"

;; The following function is vectorized with the InnerLoopUnroller but
;; not with the InnerLoopVectorizer (notice the fp128 data in the
;; body of the loop). This test makes sure that the ordered reduction
;; detected on %add.i is handled correctly when VF == 1

declare double @fabs(double)
declare double @mean(fp128*, i64, i64) #1

; Function Attrs: nounwind
define double @absdev(fp128* %data, i64 %stride, i64 %n) {
; CHECK: @absdev(
; CHECK-NOT: <n x
entry:
  %call = tail call double @mean(fp128* %data, i64 %stride, i64 %n)
  %cmp11.i = icmp eq i64 %n, 0
  br i1 %cmp11.i, label %absdev.exit, label %for.body.lr.ph.i

for.body.lr.ph.i:                                 ; preds = %entry
  %conv.i = fpext double %call to fp128
  br label %for.body.i

for.body.i:                                       ; preds = %for.body.i, %for.body.lr.ph.i
  %sum.013.i = phi double [ 0.000000e+00, %for.body.lr.ph.i ], [ %add.i, %for.body.i ]
  %i.012.i = phi i64 [ 0, %for.body.lr.ph.i ], [ %inc.i, %for.body.i ]
  %mul.i = mul i64 %i.012.i, %stride
  %arrayidx.i = getelementptr inbounds fp128, fp128* %data, i64 %mul.i
  %0 = load fp128, fp128* %arrayidx.i, align 16
  %sub.i = fsub fp128 %0, %conv.i
  %conv1.i = fptrunc fp128 %sub.i to double
  %call.i = tail call double @fabs(double %conv1.i)
  %add.i = fadd double %sum.013.i, %call.i
  %inc.i = add nuw i64 %i.012.i, 1
  %exitcond.i = icmp eq i64 %inc.i, %n
  br i1 %exitcond.i, label %absdev.exit.loopexit, label %for.body.i

absdev.exit.loopexit:     ; preds = %for.body.i
  %add.i.lcssa = phi double [ %add.i, %for.body.i ]
  br label %absdev.exit

absdev.exit:              ; preds = %absdev.exit.loopexit, %entry
  %sum.0.lcssa.i = phi double [ 0.000000e+00, %entry ], [ %add.i.lcssa, %absdev.exit.loopexit ]
  %conv2.i = uitofp i64 %n to double
  %div.i = fdiv double %sum.0.lcssa.i, %conv2.i
  ret double %div.i
}

