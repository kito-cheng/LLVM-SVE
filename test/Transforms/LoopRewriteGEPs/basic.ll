; RUN: opt < %s -S -rewrite-geps-in-loop | FileCheck %s

; CHECK-LABEL: @test1(
define i32 @test1(i32* %base, i32 %n) {
entry:
  %b1 = getelementptr i32, i32* %base, i32 10052
  %b2 = getelementptr i32, i32* %base, i32 10053
  br label %loop

; CHECK: loop
loop:
  %iv = phi i32 [ 0, %entry], [%iv.next, %loop]
  %sum = phi i32 [ 0, %entry], [%sum.next, %loop]

  ; CHECK: %p1 = getelementptr i32, i32* %b1, i32 %iv
  %p1 = getelementptr i32, i32* %b1, i32 %iv
  ; CHECK-NEXT: %d1 = load i32, i32* %p1
  %d1 = load i32, i32* %p1

  ; CHECK: %[[IDX:.*]] = add i32 %iv, 1
  ; CHECK: %p2 = getelementptr i32, i32* %b1, i32 %[[IDX]]
  %p2 = getelementptr i32, i32* %b2, i32 %iv
  ; CHECK-NEXT: %d2 = load i32, i32* %p2
  %d2 = load i32, i32* %p2

  %add = add i32 %d1, %d2
  %sum.next = add i32 %sum, %add

  %iv.next = add i32 %iv, 1
  %cond = icmp eq i32 %iv.next, %n
  ; CHECK: br i1 %cond
  br i1 %cond, label %exit, label %loop

exit:
  ret i32 %sum
}

