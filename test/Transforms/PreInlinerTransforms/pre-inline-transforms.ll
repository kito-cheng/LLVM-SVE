; RUN: opt -S -preinliner-transforms -gvn < %s | FileCheck %s

define void @foo_split_branch_ne(i32* %ptrarg) {
entry:
; CHECK-LABEL: foo_split_branch_ne
; CHECK: call void @bar(i32* null)
; CHECK: call void @bar(i32* %ptrarg)
  %tobool = icmp ne i32* %ptrarg, null
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %arrayidx = getelementptr inbounds i32, i32* %ptrarg, i64 42
  %0 = load i32, i32* %arrayidx, align 4
  %tobool1 = icmp ne i32 %0, 0
  br i1 %tobool1, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  call void @bar(i32* %ptrarg)
  br label %if.end

if.end:                                           ; preds = %if.then, %lor.lhs.false
  ret void
}

define void @foo_split_branch_eq(i32* %ptrarg) {
entry:
; CHECK-LABEL: foo_split_branch_eq
; CHECK: call void @bar(i32* null)
; CHECK: call void @bar(i32* %ptrarg)
  %tobool = icmp eq i32* %ptrarg, null
  br i1 %tobool, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %arrayidx = getelementptr inbounds i32, i32* %ptrarg, i64 42
  %0 = load i32, i32* %arrayidx, align 4
  %tobool1 = icmp ne i32 %0, 0
  br i1 %tobool1, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  call void @bar(i32* %ptrarg)
  br label %if.end

if.end:                                           ; preds = %if.then, %lor.lhs.false
  ret void
}

define void @foo_split_branch_ne_and(i32 %arg1) {
entry:
; CHECK-LABEL: foo_split_branch_ne_and
; CHECK: call void @bari(i32 %arg1)
; CHECK: call void @bari(i32 18)
  %tobool  = icmp ne i32 %arg1, 0
  %tobool2 = icmp ne i32 %arg1, 42
  %tobool3 = and i1 %tobool, %tobool2
  br i1 %tobool3, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %tobool4 = icmp ne i32 %arg1, 18
  br i1 %tobool4, label %if.end, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  call void @bari(i32 %arg1)
  br label %if.end

if.end:                                           ; preds = %if.then, %lor.lhs.false
  ret void
}

; Instructions before a call that will be pushed to its predecessors
; with uses after the callsite, must be patched up as PHI nodes in
; the join block.
define i32* @foo_split_branch_phi(i32* %ptrarg) {
entry:
; CHECK-LABEL: foo_split_branch_phi
; CHECK: call void @bar(i32* null)
; CHECK: br label %if.then
; CHECK: %[[V1:somepointer[0-9]+]] = getelementptr i32, i32* %ptrarg, i64 18
; CHECK: call void @bar(i32* %ptrarg)
; CHECK: br label %if.then
; CHECK: if.then:
; CHECK: phi i32* [ %[[V1]], %lor.lhs.false.split ], [ inttoptr (i64 72 to i32*), %entry.split ]
  %tobool = icmp ne i32* %ptrarg, null
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %arrayidx = getelementptr inbounds i32, i32* %ptrarg, i64 42
  %0 = load i32, i32* %arrayidx, align 4
  %tobool1 = icmp ne i32 %0, 0
  br i1 %tobool1, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  %somepointer = getelementptr i32, i32* %ptrarg, i64 18
  call void @bar(i32* %ptrarg)
  br label %if.end

if.end:                                           ; preds = %if.then, %lor.lhs.false
  %somepointerphi = phi i32* [ %somepointer, %if.then ], [ null, %lor.lhs.false ]
  ret i32* %somepointerphi
}

define void @foo_loop(i32* %ptrarg, i32* %ptrarg2) {
entry:
; CHECK-LABEL: foo_loop
; CHECK-NOT: call void @bar(i32* null)
; CHECK: call void @bar(i32* %ptrarg)
  %tobool = icmp ne i32* %ptrarg, null
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %arrayidx = getelementptr inbounds i32, i32* %ptrarg, i64 42
  %0 = load i32, i32* %arrayidx, align 4
  %tobool1 = icmp ne i32 %0, 0
  br i1 %tobool1, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  call void @bar(i32* %ptrarg)
  %tobool2 = icmp ne i32* %ptrarg, %ptrarg2
  br i1 %tobool2, label %if.then, label %if.end

if.end:                                           ; preds = %if.then, %lor.lhs.false
  ret void
}



declare void @bar(i32*)
declare void @bari(i32)


