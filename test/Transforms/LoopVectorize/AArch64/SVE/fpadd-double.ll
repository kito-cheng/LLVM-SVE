; RUN: opt -mtriple aarch64-linux-generic -march=armv8-a -mattr=+sve -O3 -disable-loop-vectorization -sve-loop-vectorize -force-scalable-vectorization -force-vector-width=2 -S < %s | FileCheck %s
; ModuleID = 'fpadd.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnueabi"

; void vadd(double* dst, double* op1, double* op2, int count) {
;   for (int i = 0; i < count; ++i) {
;     dst[i] = op1[i] + op2[i];
;   }
; }

define void @vaddd(double* %dst, double* %op1, double* %op2, i32 %count) #0 {
entry:
  %dst.addr = alloca double*, align 8
  %op1.addr = alloca double*, align 8
  %op2.addr = alloca double*, align 8
  %count.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store double* %dst, double** %dst.addr, align 8
  store double* %op1, double** %op1.addr, align 8
  store double* %op2, double** %op2.addr, align 8
  store i32 %count, i32* %count.addr, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* %count.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end
;CHECK-LABEL: vector.body:
;CHECK: load <n x 2 x double>
;CHECK: load <n x 2 x double>
;CHECK: fadd <n x 2 x double>
;CHECK: store <n x 2 x double>
for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4
  %idxprom = sext i32 %2 to i64
  %3 = load double*, double** %op1.addr, align 8
  %arrayidx = getelementptr inbounds double, double* %3, i64 %idxprom
  %4 = load double, double* %arrayidx, align 4
  %5 = load i32, i32* %i, align 4
  %idxprom1 = sext i32 %5 to i64
  %6 = load double*, double** %op2.addr, align 8
  %arrayidx2 = getelementptr inbounds double, double* %6, i64 %idxprom1
  %7 = load double, double* %arrayidx2, align 4
  %add = fadd double %4, %7
  %8 = load i32, i32* %i, align 4
  %idxprom3 = sext i32 %8 to i64
  %9 = load double*, double** %dst.addr, align 8
  %arrayidx4 = getelementptr inbounds double, double* %9, i64 %idxprom3
  store double %add, double* %arrayidx4, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %10 = load i32, i32* %i, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}
