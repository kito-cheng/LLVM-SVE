; RUN: opt -mtriple aarch64-linux-generic -mattr=+sve -sve-loop-vectorize \
; RUN: -force-scalable-vectorization -force-vector-predication \
; RUN: -force-vector-width=4 -S < %s | FileCheck %s

; OCT-237: Ensure an invariant getelementptr within a loop doesn't assert.
define i32 @invariant_gep_in_loop(i64 %n, i32* %A, i32 %idx) {
; CHECK-LABEL: invariant_gep_in_loop
; CHECK <n x 4 x i32>
  %1 = icmp sgt i64 %n, 0
  br i1 %1, label %.loop, label %.end

.loop:
  %ind = phi i64 [ %ind.next, %.loop ], [ 0, %0 ]
  %sum = phi i32 [ %sum.next, %.loop ], [ 0, %0 ]
  %2 = getelementptr inbounds i32, i32* %A, i32 %idx
  %3 = getelementptr inbounds i32, i32* %2, i64 %ind
  %4 = load i32, i32* %3, align 4
  %sum.next = add i32 %sum, %4
  %ind.next = add i64 %ind, 1
  %exitcond = icmp eq i64 %ind.next, %n
  br i1 %exitcond, label %.end, label %.loop

.end:
  %res = phi i32 [ 0, %0 ], [ %sum.next, %.loop ]
  ret i32 %res
}

