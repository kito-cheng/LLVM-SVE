; RUN: opt -mtriple aarch64-linux-generic -march=armv8-a -mattr=+sve -O3 -disable-loop-vectorization -sve-loop-vectorize -force-scalable-vectorization -force-vector-width=2 -S < %s | FileCheck %s
; ModuleID = 'ex07.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnueabi"

;#include <math.h>
;
;void loop(double * restrict in, double * restrict out, unsigned count) {
;  for (unsigned i = 0; i < count; ++i)
;    out[i] = sqrtf(in[i]);
;}

declare double @llvm.sqrt.f64(double)

define void @loop(double* %in, double* %out, i32 %count) #0 {
entry:
  %cmp6 = icmp eq i32 %count, 0
  br i1 %cmp6, label %for.end, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %0 = add i32 %count, -1
  br label %for.body

;CHECK-LABEL: vector.body:
;CHECK call <n x 2 x double> @llvm.sqrt.nxv2f64(<n x 2 x double>
;CHECK call <n x 2 x double> @llvm.sqrt.nxv2f64(<n x 2 x double>

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds double, double* %in, i64 %indvars.iv
  %1 = load double, double* %arrayidx, align 4
  %2 = tail call double @llvm.sqrt.f64(double %1)
  %arrayidx2 = getelementptr inbounds double, double* %out, i64 %indvars.iv
  store double %2, double* %arrayidx2, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %0
  br i1 %exitcond, label %for.end.loopexit, label %for.body

for.end.loopexit:                                 ; preds = %for.body
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  ret void
}
