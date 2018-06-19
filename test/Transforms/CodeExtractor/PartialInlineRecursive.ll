; RUN: opt < %s -partial-inliner -skip-partial-inlining-cost-analysis -S | FileCheck %s

%struct.list = type { %struct.list*, i32, i32* }

; Function Attrs: nounwind readonly uwtable
define i32 @foo(%struct.list* noalias nocapture readonly) local_unnamed_addr #0 {
; CHECK-LABEL:define{{.*}}@foo
; CHECK-NOT:tail call i32 @foo(
; CHECK:call void @foo.{{[0-9]}}_
; CHECK:ret i32
  %2 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 1
  %3 = load i32, i32* %2, align 8
  %4 = icmp slt i32 %3, 2
  br i1 %4, label %25, label %5

; <label>:5:                                      ; preds = %1
  %6 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 2
  %7 = load i32*, i32** %6, align 8
  %8 = load i32, i32* %7, align 4
  %9 = getelementptr inbounds i32, i32* %7, i64 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp eq i32 %8, %10
  br i1 %11, label %25, label %12

; <label>:12:                                     ; preds = %5
  %13 = getelementptr inbounds %struct.list, %struct.list* %0, i64 0, i32 0
  %14 = load %struct.list*, %struct.list** %13, align 8
  %15 = icmp eq %struct.list* %14, null
  br i1 %15, label %25, label %16

; <label>:16:                                     ; preds = %12
  br label %21

; <label>:17:                                     ; preds = %21
  %18 = getelementptr inbounds %struct.list, %struct.list* %22, i64 0, i32 0
  %19 = load %struct.list*, %struct.list** %18, align 8
  %20 = icmp eq %struct.list* %19, null
  br i1 %20, label %25, label %21

; <label>:21:                                     ; preds = %16, %17
  %22 = phi %struct.list* [ %14, %16 ], [ %19, %17 ]
  %23 = tail call i32 @foo(%struct.list* nonnull %22)
  %24 = icmp eq i32 %23, 0
  br i1 %24, label %25, label %17

; <label>:25:                                     ; preds = %17, %21, %12, %5, %1
  %26 = phi i32 [ -1, %1 ], [ 0, %5 ], [ -1, %12 ], [ -1, %17 ], [ 0, %21 ]
  ret i32 %26
}

