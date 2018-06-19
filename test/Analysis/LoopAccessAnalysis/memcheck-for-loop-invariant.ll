; RUN: opt -loop-accesses -analyze < %s | FileCheck %s
; RUN: opt -passes='require<scalar-evolution>,require<aa>,loop(print-access-info)' -disable-output  < %s 2>&1 | FileCheck %s

; Handle memchecks involving loop-invariant addresses:
;
; extern int *A, *b;
; for (i = 0; i < N; ++i) {
;  A[i] = b;
; }

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

; CHECK: function 'f'
; CHECK: Memory dependences are safe with run-time checks
; CHECK: Run-time memory checks:
; CHECK-NEXT: Check 0:
; CHECK-NEXT:   Comparing group ({{.*}}):
; CHECK-NEXT:     %arrayidxA = getelementptr inbounds i32, i32* %a, i64 %ind
; CHECK-NEXT:   Against group ({{.*}}):
; CHECK-NEXT:   i32* %b

define void @f(i32* %a, i32* %b) {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %ind = phi i64 [ 0, %entry ], [ %inc, %for.body ]

  %arrayidxA = getelementptr inbounds i32, i32* %a, i64 %ind

  %loadB = load i32, i32* %b, align 4
  store i32 %loadB, i32* %arrayidxA, align 4

  %inc = add nuw nsw i64 %ind, 1
  %exitcond = icmp eq i64 %inc, 20
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}



; Handle memchecks involving loop-invariant address that
; cannot be hoisted out:
;
; struct {
;   int a[100];
;   int b[100];
;   int c[100];
; } data;
;
; void foo(int n) {
;   for(int i=0 ; i<n ; i++) {
;     data.a[i] = data.b[i] + data.c[42];
;                             ^^^^^^^^^^
;                             overlaps with data.a[i] iff n>241
;   }
; }
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"

%struct.anon = type { [100 x i32], [100 x i32], [100 x i32] }
@data = common global %struct.anon zeroinitializer, align 4

define void @foo(i32 %n) {
; CHECK: function 'foo'
; CHECK: Memory dependences are safe with run-time checks
; CHECK: Run-time memory checks:
; CHECK: Check {{[0-9]+}}:
; CHECK:   Comparing group ({{.*}}):
; CHECK:     {{.*getelementptr}} inbounds %struct.anon, %struct.anon* @data, i64 0, i32 0, i64 %indvars.iv
; CHECK:   Against group ({{.*}}):
; CHECK:     i32* getelementptr inbounds (%struct.anon, %struct.anon* @data, i64 0, i32 2, i64 42)
entry:
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds %struct.anon, %struct.anon* @data, i64 0, i32 1, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4
  %1 = load i32, i32* getelementptr inbounds (%struct.anon, %struct.anon* @data, i64 0, i32 2, i64 42), align 4
  %add = add nsw i32 %1, %0
  %arrayidx2 = getelementptr inbounds %struct.anon, %struct.anon* @data, i64 0, i32 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx2, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

@a = common global [100 x i32] zeroinitializer, align 4
@b = common global [100 x i32] zeroinitializer, align 4

; Should not merge together invariant addresses into the same group
;  int a[100];
;  int b[100];
;
;  void foo(void) {
;    for (int i = 0; i < 100; i++)
;      a[i] = a[50] + b[i];
;      ^^^^   ^^^^^
;      need to belong in a separate group,
;      so that a pointer check is inserted
;  }


define void @needs_check() #0 {
; CHECK: function 'needs_check'
; CHECK: Memory dependences are safe with run-time checks
; CHECK: Run-time memory checks:
; CHECK: Check {{[0-9]+}}:
; CHECK:   Comparing group ({{.*}}):
; CHECK:     {{.*getelementptr}} inbounds [100 x i32], [100 x i32]* @a, i64 0, i64 %indvars.iv
; CHECK:   Against group ({{.*}}):
; CHECK:     i32* getelementptr inbounds ([100 x i32], [100 x i32]* @a, i64 0, i64 50)
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %0 = load i32, i32* getelementptr inbounds ([100 x i32], [100 x i32]* @a, i64 0, i64 50), align 4
  %arrayidx = getelementptr inbounds [100 x i32], [100 x i32]* @b, i64 0, i64 %indvars.iv
  %1 = load i32, i32* %arrayidx, align 4
  %add = add nsw i32 %1, %0
  %arrayidx2 = getelementptr inbounds [100 x i32], [100 x i32]* @a, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx2, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 100
  br i1 %exitcond, label %for.cond.cleanup, label %for.body
}

