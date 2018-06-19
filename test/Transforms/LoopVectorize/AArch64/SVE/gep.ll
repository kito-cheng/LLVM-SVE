; RUN: opt -mtriple aarch64-linux-generic -march=armv8-a -mattr=+sve -O3 -disable-loop-vectorization -sve-loop-vectorize -force-scalable-vectorization -enable-non-consecutive-stride-ind-vars -force-vector-width=4 -disable-loop-unrolling -S < %s | FileCheck %s

; ModuleID = 'tbreak.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

@reg_names = external global [0 x i8*]

; Function Attrs: nounwind
define void @foo() #0 {
; CHECK-LABEL: foo
entry:
  %i = alloca i32, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 38
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
; CHECK-DAG: %[[LOAD:[a-zA-Z0-9.]+]] = load <n x 4 x i8*>, <n x 4 x i8*>*
; CHECK-DAG: %[[PTRTOINT:[0-9]+]] = ptrtoint <n x 4 x i8*> %[[LOAD]] to <n x 4 x i64>
; CHECK-DAG: %[[ARITH:[0-9]+]]    = add <n x 4 x i64> %[[PTRTOINT]], shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 -1, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer)
; CHECK-DAG: %[[INTTOPTR:[0-9]+]] = inttoptr <n x 4 x i64> %[[ARITH]] to <n x 4 x i8*>
; CHECK-DAG: store <n x 4 x i8*> %[[INTTOPTR]], <n x 4 x i8*>* %{{[0-9]+}}, align 8
  %1 = load i32, i32* %i, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds [0 x i8*], [0 x i8*]* @reg_names, i32 0, i64 %idxprom
  %2 = load i8*, i8** %arrayidx, align 8
  %incdec.ptr = getelementptr inbounds i8, i8* %2, i32 -1
  store i8* %incdec.ptr, i8** %arrayidx, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

%struct.foo = type { i32, i32, [100 x %struct.bar] }
%struct.bar = type { i32, i32, [100 x i32] }
@in = external global [0 x %struct.foo*]
@out = external global [0 x i32*]

; Function Attrs: nounwind
define void @foo2() #0 {
; CHECK-LABEL: foo2
entry:
  %i = alloca i32, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 38
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
; CHECK-DAG: %[[LOAD:[a-zA-Z0-9.]+]] = load <n x 4 x %struct.foo*>, <n x 4 x %struct.foo*>*
; CHECK-DAG: %[[PTRTOINT:[0-9]+]] = ptrtoint <n x 4 x %struct.foo*> %[[LOAD]] to <n x 4 x i64>
; CHECK-DAG: %[[ARITH:[0-9]+]]    = add <n x 4 x i64> %[[PTRTOINT]], shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 17472, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer)
; CHECK-DAG: %[[INTTOPTR:[0-9]+]] = inttoptr <n x 4 x i64> %[[ARITH]] to <n x 4 x i32*>
; CHECK-DAG: store <n x 4 x i32*> %[[INTTOPTR]], <n x 4 x i32*>* %{{[0-9]+}}, align 8
  %1 = load i32, i32* %i, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds [0 x %struct.foo*], [0 x %struct.foo*]* @in, i32 0, i64 %idxprom
  %2 = load %struct.foo*, %struct.foo** %arrayidx, align 8
  %c = getelementptr inbounds %struct.foo, %struct.foo* %2, i32 0, i32 2
  %arrayidx1 = getelementptr inbounds [100 x %struct.bar], [100 x %struct.bar]* %c, i32 0, i64 42
  %c2 = getelementptr inbounds %struct.bar, %struct.bar* %arrayidx1, i32 0, i32 2
  %arrayidx3 = getelementptr inbounds [100 x i32], [100 x i32]* %c2, i32 0, i64 80
  %3 = load i32, i32* %i, align 4
  %idxprom4 = sext i32 %3 to i64
  %arrayidx5 = getelementptr inbounds [0 x i32*], [0 x i32*]* @out, i32 0, i64 %idxprom4
  store i32* %arrayidx3, i32** %arrayidx5, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4
  %inc = add nsw i32 %4, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}
attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}
!0 = !{!"clang version 3.7.0"}
