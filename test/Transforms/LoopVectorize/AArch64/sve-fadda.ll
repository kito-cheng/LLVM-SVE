; RUN: opt -S < %s -O3 -basicaa -disable-loop-vectorization -sve-loop-vectorize -instcombine -early-cse -force-scalable-vectorization -force-vector-predication -force-vector-interleave=2 2>&1 | FileCheck %s

; ModuleID = 'test.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-generic-linux"

; clang -O3 -emit-llvm -S -target aarch64-generic-linux -march=armv8-a+sve -c
; float reduce_float(float *a, int len, float startvalue) {
;   float sum = startvalue;
;   for (int i = 0; i < len; ++i) {
;     sum += a[i];
;   }
;   return sum;
; }

; Function Attrs: norecurse nounwind readonly
define float @reduce_float(float* nocapture readonly %a, i32 %len, float %startvalue) #0 {
; CHECK-LABEL: @reduce_float
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
; CHECK-LABEL: min.iters.checked:
; CHECK: %predicate.entry = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> shufflevector
; CHECK: %predicate.entry[[NEXT:[0-9]+]] = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %predicate.entry,

; CHECK-LABEL: vector.body:
; CHECK:  %predicate = phi <n x 4 x i1> [ %predicate.entry, %min.iters.checked ],
; CHECK:  %predicate[[PNEXT:[0-9]+]] = phi <n x 4 x i1> [ %predicate.entry[[NEXT]], %min.iters.checked ],
; CHECK: %vec.phi = phi float [ %startvalue, %min.iters.checked ], [ %[[CALL2:[0-9]+]], %vector.body ]
; CHECK: %[[CALL:[0-9]+]] = call float @llvm.experimental.vector.reduce.fadd.f32.f32.nxv4f32(float %vec.phi
; CHECK: %[[CALL2]] = call float @llvm.experimental.vector.reduce.fadd.f32.f32.nxv4f32
; CHECK-SAME: %[[CALL]]
for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %sum.07 = phi float [ %add, %for.body ], [ %startvalue, %for.body.preheader ]
  %arrayidx = getelementptr inbounds float, float* %a, i64 %indvars.iv
  %0 = load float, float* %arrayidx, align 8, !tbaa !1
  %add = fadd float %sum.07, %0
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %len
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

; clang -O3 -emit-llvm -S -target aarch64-generic-linux -march=armv8-a+sve -c
; double reduce_double(double *a, int len, double startvalue) {
;   double sum = startvalue;
;   for (int i = 0; i < len; ++i) {
;     sum += a[i];
;   }
;   return sum;
; }

; Function Attrs: norecurse nounwind readonly
define double @reduce_double(double* nocapture readonly %a, i32 %len, double %startvalue) #0 {
; CHECK-LABEL: @reduce_double
entry:
  %cmp.6 = icmp sgt i32 %len, 0
  br i1 %cmp.6, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  %add.lcssa = phi double [ %add, %for.body ]
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %sum.0.lcssa = phi double [ %startvalue, %entry ], [ %add.lcssa, %for.cond.cleanup.loopexit ]
  ret double %sum.0.lcssa
; CHECK-LABEL: min.iters.checked:
; CHECK: %predicate.entry = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> shufflevector
; CHECK: %predicate.entry[[NEXT:[0-9]+]] = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %predicate.entry,

; CHECK-LABEL: vector.body:
; CHECK:  %predicate = phi <n x 2 x i1> [ %predicate.entry, %min.iters.checked ],
; CHECK:  %predicate[[PNEXT:[0-9]+]] = phi <n x 2 x i1> [ %predicate.entry[[NEXT]], %min.iters.checked ],
; CHECK: %vec.phi = phi double [ %startvalue, %min.iters.checked ], [ %[[CALL2:[0-9]+]], %vector.body ]
; CHECK: %[[CALL:[0-9]+]] = call double @llvm.experimental.vector.reduce.fadd.f64.f64.nxv2f64(double %vec.phi
; CHECK: %[[CALL2]] = call double @llvm.experimental.vector.reduce.fadd.f64.f64.nxv2f64
; CHECK-SAME: %[[CALL]]
for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %sum.07 = phi double [ %add, %for.body ], [ %startvalue, %for.body.preheader ]
  %arrayidx = getelementptr inbounds double, double* %a, i64 %indvars.iv
  %0 = load double, double* %arrayidx, align 8, !tbaa !1
  %add = fadd double %sum.07, %0
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %len
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body

}

; double reduce_predicated(double *a, double *p, int len, double startvalue) {
;   double sum = startvalue;
;   for (int i = 0; i < len; ++i) {
;     if (p[i] > 42.)
;       sum += a[i];
;   }
;   return sum;
; }
define double @reduce_predicated(double* %a, double* %p, i32 %len, double %startvalue) #0 {
; CHECK-LABEL: @reduce_predicated
; CHECK: %predicate.entry = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> shufflevector
; CHECK: %predicate.entry[[NEXT:[0-9]+]] = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %predicate.entry,

; CHECK-LABEL: vector.body:
; CHECK:  %predicate = phi <n x 2 x i1> [ %predicate.entry, %min.iters.checked ],
; CHECK:  %predicate[[PNEXT:[0-9]+]] = phi <n x 2 x i1> [ %predicate.entry[[NEXT]], %min.iters.checked ],
; CHECK: %vec.phi = phi double [ %startvalue, %min.iters.checked ], [ %[[CALL2:[0-9]+]], %vector.body ]
; CHECK: %[[PFIRST:[0-9]+]] = and <n x 2 x i1> %{{.*}}, %predicate
; CHECK: %wide.masked.load[[LDFIRST:[0-9]+]] = call <n x 2 x double> @llvm.masked.load.nxv2f64
; CHECK-SAME: %[[PFIRST]]
; CHECK-DAG: %[[MASKED1:[0-9]+]] = select <n x 2 x i1> %[[PFIRST]], <n x 2 x double> %wide.masked.load[[LDFIRST]], <n x 2 x double> zeroinitializer
; CHECK-DAG: %[[PSECOND:[0-9]+]] = and <n x 2 x i1> %{{.*}}, %predicate[[PNEXT]]
; CHECK-DAG: %wide.masked.load[[LDSECOND:[0-9]+]] = call <n x 2 x double> @llvm.masked.load.nxv2f64
; CHECK: %[[CALL:[0-9]+]] = call double @llvm.experimental.vector.reduce.fadd.f64.f64.nxv2f64(double %vec.phi, <n x 2 x double> %[[MASKED1]])
; CHECK-DAG: %[[MASKED2:[0-9]+]] = select <n x 2 x i1> %[[PSECOND]], <n x 2 x double> %wide.masked.load[[LDSECOND]], <n x 2 x double> zeroinitializer
; CHECK: %[[CALL2:[0-9]+]] = call double @llvm.experimental.vector.reduce.fadd.f64.f64.nxv2f64(double %[[CALL]], <n x 2 x double> %[[MASKED2]])
entry:
  %a.addr = alloca double*, align 8
  %p.addr = alloca double*, align 8
  %len.addr = alloca i32, align 4
  %startvalue.addr = alloca double, align 8
  %sum = alloca double, align 8
  %i = alloca i32, align 4
  store double* %a, double** %a.addr, align 8
  store double* %p, double** %p.addr, align 8
  store i32 %len, i32* %len.addr, align 4
  store double %startvalue, double* %startvalue.addr, align 8
  %0 = load double, double* %startvalue.addr, align 8
  store double %0, double* %sum, align 8
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
  %4 = load double*, double** %p.addr, align 8
  %arrayidx = getelementptr inbounds double, double* %4, i64 %idxprom
  %5 = load double, double* %arrayidx, align 8
  %cmp1 = fcmp ogt double %5, 4.200000e+01
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %6 = load i32, i32* %i, align 4
  %idxprom2 = sext i32 %6 to i64
  %7 = load double*, double** %a.addr, align 8
  %arrayidx3 = getelementptr inbounds double, double* %7, i64 %idxprom2
  %8 = load double, double* %arrayidx3, align 8
  %9 = load double, double* %sum, align 8
  %add = fadd double %9, %8
  store double %add, double* %sum, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %10 = load i32, i32* %i, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %11 = load double, double* %sum, align 8
  ret double %11
}

attributes #0 = { norecurse nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"double", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
