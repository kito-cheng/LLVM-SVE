; RUN: opt -S < %s -O3 -basicaa -disable-loop-vectorization -sve-loop-vectorize -force-scalable-vectorization -force-vector-predication 2>&1 | FileCheck %s

; clang -O3 -emit-llvm -S -target aarch64-generic-linux -march=armv8-a+sve -c -ffast-math
; float reduce(float *a, int len, float startvalue) {
;   float sum = startvalue;
;   for (int i = 0; i < len; ++i) {
;     sum += a[i];
;   }
;   return sum;
; }

; This test makes sure that adda reduction intrinsics are not used if
; the reduction exit instruction has an unsafe algebra flag ('fast').

; ModuleID = 'test.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-generic-linux"

; Function Attrs: norecurse nounwind readonly
define float @reduce(float* nocapture readonly %a, i32 %len, float %startvalue) #0 {
; CHECK-LABEL: @reduce
; CHECK: call fast float @llvm.experimental.vector.reduce.fadd.f32.f32.nxv4f32(float undef

entry:
  %cmp.6 = icmp sgt i32 %len, 0
  br i1 %cmp.6, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  %add.lcssa = phi float [ %add, %for.body ]
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %sum.0.lcssa = phi float [ %startvalue, %entry ], [ %add.lcssa, %for.cond.cleanup.loopexit ]
  ret float %sum.0.lcssa
for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %sum.07 = phi float [ %add, %for.body ], [ %startvalue, %for.body.preheader ]
  %arrayidx = getelementptr inbounds float, float* %a, i64 %indvars.iv
  %0 = load float, float* %arrayidx, align 8, !tbaa !1
  %add = fadd fast float %sum.07, %0
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %len
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

; clang -O3 -emit-llvm -S -target aarch64-generic-linux -march=armv8-a+sve -c -ffast-math
; float reduce_predicated(float *a, float *p, int len, float startvalue) {
;   float sum = startvalue;
;   for (int i = 0; i < len; ++i) {
;     if (p[i] > 42.)
;       sum += a[i];
;   }
;   return sum;
; }

; Function Attrs: nounwind
define float @reduce_predicated(float* %a, float* %p, i32 %len, float %startvalue) #0 {
; CHECK-LABEL: @reduce_predicated
; CHECK: call fast float @llvm.experimental.vector.reduce.fadd.f32.f32.nxv4f32(float undef
entry:
  %a.addr = alloca float*, align 8
  %p.addr = alloca float*, align 8
  %len.addr = alloca i32, align 4
  %startvalue.addr = alloca float, align 4
  %sum = alloca float, align 4
  %i = alloca i32, align 4
  store float* %a, float** %a.addr, align 8
  store float* %p, float** %p.addr, align 8
  store i32 %len, i32* %len.addr, align 4
  store float %startvalue, float* %startvalue.addr, align 4
  %0 = load float, float* %startvalue.addr, align 4
  store float %0, float* %sum, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4
  %2 = load i32, i32* %len.addr, align 4
  %cmp = icmp slt i32 %1, %2
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %3 = load i32, i32* %i, align 4
  %idxprom = sext i32 %3 to i64
  %4 = load float*, float** %p.addr, align 8
  %arrayidx = getelementptr inbounds float, float* %4, i64 %idxprom
  %5 = load float, float* %arrayidx, align 4
  %conv = fpext float %5 to double
  %cmp1 = fcmp fast ogt double %conv, 4.200000e+01
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %6 = load i32, i32* %i, align 4
  %idxprom3 = sext i32 %6 to i64
  %7 = load float*, float** %a.addr, align 8
  %arrayidx4 = getelementptr inbounds float, float* %7, i64 %idxprom3
  %8 = load float, float* %arrayidx4, align 4
  %9 = load float, float* %sum, align 4
  %add = fadd fast float %9, %8
  store float %add, float* %sum, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %10 = load i32, i32* %i, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %11 = load float, float* %sum, align 4
  ret float %11
}

attributes #0 = { norecurse nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"float", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
