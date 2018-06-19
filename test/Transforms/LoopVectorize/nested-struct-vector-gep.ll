; RUN: opt -S -mtriple=aarch64-linux-gnu -mattr=+sve -sve-loop-vectorize -instcombine -use-sve-vectorizer -force-scalable-vectorization -force-vector-predication < %s | FileCheck %s
; ModuleID = 'test.cpp'
source_filename = "test.cpp"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

%"sty1" = type { %"sty2" }
%"sty2" = type { %"sty3" }
%"sty3" = type { %"sty4" }
%"sty4" = type { %"sty5", i64 }
%"sty5" = type { %"sty5"*, %"sty5"* }

define void @testfn() {
entry:
; CHECK-LABEL: @testfn
; CHECK: %next.gep = getelementptr [64 x %sty1], [64 x %sty1]* %__tmp, i64 0, i64 %index
; CHECK: %vector.gep = getelementptr %sty1, %sty1* %next.gep, <n x 2 x i64> stepvector
; CHECK: bitcast <n x 2 x %sty1*> %vector.gep to <n x 2 x %sty5*>
  %__carry = alloca %"sty1", align 8
  %__tmp = alloca [64 x %"sty1"], align 8
  %array.begin = getelementptr inbounds [64 x %"sty1"], [64 x %"sty1"]* %__tmp, i64 0, i64 0
  %arrayctor.end = getelementptr inbounds [64 x %"sty1"], [64 x %"sty1"]* %__tmp, i64 0, i64 64
  br label %loop

loop:
  %arraycur = phi %"sty1"* [ %array.begin, %entry ], [ %array.next, %loop ]
  %storeval_ptrvec = getelementptr inbounds %"sty1", %"sty1"* %arraycur, i64 0, i32 0, i32 0, i32 0, i32 0
  %storedest = getelementptr inbounds %"sty1", %"sty1"* %arraycur, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0
  store %"sty5"* %storeval_ptrvec, %"sty5"** %storedest, align 8
  %array.next = getelementptr inbounds %"sty1", %"sty1"* %arraycur, i64 1
  %array.done = icmp eq %"sty1"* %array.next, %arrayctor.end
  br i1 %array.done, label %cont, label %loop

cont:
  ret void
}

