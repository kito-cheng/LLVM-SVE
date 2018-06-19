; RUN: opt  -mtriple aarch64-linux-generic -march=armv8-a -mattr=+sve -S < %s -basicaa -sve-loop-vectorize -force-scalable-vectorization -force-vector-predication  2>&1 | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-generic-linux"

declare double @mean(fp128*, i64, i64)

;; The following test makes sure that the ordered reduction detected
;; on %add.i.i does not get vectorized as the TTI cannot find the
;; correct ordered reduction instrinsic for 128-bit FP data.

; Function Attrs: nounwind
define double @func(fp128* %data, i64 %stride, i64 %n) {
; CHECK-LABEL: @func(
; CHECK-NOT: <n x
entry:
  %call = tail call double @mean(fp128* %data, i64 %stride, i64 %n)
  %cmp10.i.i = icmp eq i64 %n, 0
  br i1 %cmp10.i.i, label %func.exit, label %for.body.lr.ph.i.i

for.body.lr.ph.i.i:                               ; preds = %entry
  %conv.i.i = fpext double %call to fp128
  br label %for.body.i.i

for.body.i.i:                                     ; preds = %for.body.i.i, %for.body.lr.ph.i.i
  %tss.012.i.i = phi fp128 [ 0xL00000000000000000000000000000000, %for.body.lr.ph.i.i ], [ %add.i.i, %for.body.i.i ]
  %i.011.i.i = phi i64 [ 0, %for.body.lr.ph.i.i ], [ %inc.i.i, %for.body.i.i ]
  %mul.i.i = mul i64 %i.011.i.i, %stride
  %arrayidx.i.i = getelementptr inbounds fp128, fp128* %data, i64 %mul.i.i
  %0 = load fp128, fp128* %arrayidx.i.i, align 16
  %sub.i.i = fsub fp128 %0, %conv.i.i
  %mul1.i.i = fmul fp128 %sub.i.i, %sub.i.i
  %add.i.i = fadd fp128 %tss.012.i.i, %mul1.i.i
  %inc.i.i = add nuw i64 %i.011.i.i, 1
  %exitcond.i.i = icmp eq i64 %inc.i.i, %n
  br i1 %exitcond.i.i, label %for.end.loopexit.i.i, label %for.body.i.i

for.end.loopexit.i.i:                             ; preds = %for.body.i.i
  %add.i.i.lcssa = phi fp128 [ %add.i.i, %for.body.i.i ]
  %phitmp.i.i = fptrunc fp128 %add.i.i.lcssa to double
  br label %func.exit

func.exit:                 ; preds = %entry, %for.end.loopexit.i.i
  %tss.0.lcssa.i.i = phi double [ 0.000000e+00, %entry ], [ %phitmp.i.i, %for.end.loopexit.i.i ]
  ret double %tss.0.lcssa.i.i
}
