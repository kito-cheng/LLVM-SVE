; RUN: opt -O3 -loop-accesses -debug-only=loop-accesses < %s 2>&1 > /dev/null | FileCheck %s
; REQUIRES: asserts
; For this loop:
;   void foo(float * a, float * b, int N, int X, int Y)
;     for (int j=0; j<N; ++j)
;       a[j] = b[X*Y + j + 2];
;   }
;
; Address b[X*Y + j + 2] should be properly recognized as an affine SCEV
; for which runtime pointer checks can be created. With -O3 the wrapping
; flags should be preserved so that ScalarEvolution knows that no
; wrapping takes place.
define void @foo(float* %a, float* %b, i32 %N, i32 %X, i32 %Y) #0 {
entry:
  %a.addr = alloca float*, align 8
  %b.addr = alloca float*, align 8
  %N.addr = alloca i32, align 4
  %X.addr = alloca i32, align 4
  %Y.addr = alloca i32, align 4
  %j = alloca i32, align 4
  store float* %a, float** %a.addr, align 8
  store float* %b, float** %b.addr, align 8
  store i32 %N, i32* %N.addr, align 4
  store i32 %X, i32* %X.addr, align 4
  store i32 %Y, i32* %Y.addr, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %j, align 4
  %1 = load i32, i32* %N.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

; CHECK:     LAA: Found a loop in foo: for.body
; CHECK:     LAA: No unsafe dependent memory operations in loop.  We need runtime memory checks.
; CHECK-NOT: LAA: Can't find bounds for ptr
for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %X.addr, align 4
  %3 = load i32, i32* %Y.addr, align 4
  %mul = mul nsw i32 %2, %3
  %4 = load i32, i32* %j, align 4
  %add = add nsw i32 %mul, %4
  %add1 = add nsw i32 %add, 2
  %idxprom = sext i32 %add1 to i64
  %5 = load float*, float** %b.addr, align 8
  %arrayidx = getelementptr inbounds float, float* %5, i64 %idxprom
  %6 = load float, float* %arrayidx, align 4
  %7 = load i32, i32* %j, align 4
  %idxprom2 = sext i32 %7 to i64
  %8 = load float*, float** %a.addr, align 8
  %arrayidx3 = getelementptr inbounds float, float* %8, i64 %idxprom2
  store float %6, float* %arrayidx3, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %9 = load i32, i32* %j, align 4
  %inc = add nsw i32 %9, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}
