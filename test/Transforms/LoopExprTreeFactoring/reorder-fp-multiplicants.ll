; RUN: opt < %s -licm -loop-factor-expr-trees -dce -early-cse -S | FileCheck %s

; // Test that the expression below is rewritten to:
; //  (x0 * x1) * (a[i] + b[i] + c[i])
; // So that the invariant 'x0 * x1' can be hoisted out.
; float foo(float * restrict a, float *b, float *c, float *constants, int N) {
;   float x0 = constants[0];
;   float x1 = constants[1];
;   float sum = 0.0;
;   for (int i=0; i<N; ++i)
;     sum += x0 * a[i] * x1 +
;            x0 * b[i] * x1 +
;            x0 * c[i] * x1;
;   return sum;
; }
define float @test_reorder(float* noalias nocapture readonly,
                           float* nocapture readonly,
                           float* nocapture readonly,
                           float* nocapture readonly,
                           i32) {
; CHECK-LABEL: test_reorder
; CHECK-DAG: %[[GEPA:[0-9]+]] = getelementptr inbounds float, float* %0
; CHECK-DAG: %[[LDA:[0-9]+]] = load float, float* %[[GEPA]]
; CHECK-DAG: %[[GEPB:[0-9]+]] = getelementptr inbounds float, float* %1
; CHECK-DAG: %[[LDB:[0-9]+]] = load float, float* %[[GEPB]]
; CHECK-DAG: %[[GEPC:[0-9]+]] = getelementptr inbounds float, float* %2
; CHECK-DAG: %[[LDC:[0-9]+]] = load float, float* %[[GEPC]]
; CHECK-DAG: %[[ADD1:[0-9]+]] = fadd fast float %[[LDA]], %[[LDB]]
; CHECK-DAG: %[[ADD2:[0-9]+]] = fadd fast float %[[ADD1]], %[[LDC]]
; CHECK-DAG: %[[MULINV:[0-9]+]] = fmul fast float
; CHECK-DAG: %[[MUL:[0-9]+]] = fmul fast float %[[MULINV]], %[[ADD2]]
  %6 = load float, float* %3, align 4, !tbaa !1
  %7 = getelementptr inbounds float, float* %3, i64 1
  %8 = load float, float* %7, align 4, !tbaa !1
  %9 = icmp sgt i32 %4, 0
  br i1 %9, label %10, label %13

; <label>:10:                                     ; preds = %5
  %11 = zext i32 %4 to i64
  br label %15

; <label>:12:                                     ; preds = %15
  br label %13

; <label>:13:                                     ; preds = %12, %5
  %14 = phi float [ 0.000000e+00, %5 ], [ %32, %12 ]
  ret float %14

; <label>:15:                                     ; preds = %10, %15
  %16 = phi i64 [ %33, %15 ], [ 0, %10 ]
; CHECK-DAG: %[[PHI:[0-9]+]] = phi float {{.*%15}}
  %17 = phi float [ %32, %15 ], [ 0.000000e+00, %10 ]
  %18 = getelementptr inbounds float, float* %0, i64 %16
  %19 = load float, float* %18, align 4, !tbaa !1
  %20 = fmul fast float %6, %19
  %21 = fmul fast float %8, %20
  %22 = getelementptr inbounds float, float* %1, i64 %16
  %23 = load float, float* %22, align 4, !tbaa !1
  %24 = fmul fast float %6, %23
  %25 = fmul fast float %8, %24
  %26 = fadd fast float %21, %25
  %27 = getelementptr inbounds float, float* %2, i64 %16
  %28 = load float, float* %27, align 4, !tbaa !1
  %29 = fmul fast float %6, %28
  %30 = fmul fast float %8, %29
  %31 = fadd fast float %26, %30
  %32 = fadd fast float %17, %31
  %33 = add nuw nsw i64 %16, 1
  %34 = icmp eq i64 %33, %11
  br i1 %34, label %12, label %15
}

; // Test that the expression below is rewritten to:
; //  (x0 * x0) * ( (x0 * a[i]) + b[i] )
; // So that the invariant 'x0 * x0' can be hoisted out.
; float foo(float * restrict a, float *b, float *constants, int N) {
;   float x0 = constants[0];
;   float sum = 0.0;
;   for (int i=0; i<N; ++i)
;     sum += x0 * a[i] * x0 * x0 +
;            x0 * b[i] * x0;
;   return sum;
; }
define float @test_reorder_partial(float* noalias nocapture readonly,
                           float* nocapture readonly,
                           float* nocapture readonly,
                           i32) {
; CHECK-LABEL: test_reorder_partial
; <label>:4:
  %5 = load float, float* %2, align 4, !tbaa !1
  %6 = icmp sgt i32 %3, 0
  br i1 %6, label %7, label %10

; <label>:7:                                     ; preds = %4
  %8 = zext i32 %3 to i64
  br label %12

; <label>:9:                                     ; preds = %11
  br label %10

; <label>:10:                                    ; preds = %9, %4
  %11 = phi float [ 0.000000e+00, %4 ], [ %25, %9 ]
  ret float %11

; <label>:12:                                     ; preds = %7, %12
  %13 = phi i64 [ %26, %12 ], [ 0, %7 ]
  %14 = phi float [ %25, %12 ], [ 0.000000e+00, %7 ]
  %15 = getelementptr inbounds float, float* %0, i64 %13
  %16 = load float, float* %15, align 4, !tbaa !1
  %17 = getelementptr inbounds float, float* %1, i64 %13
  %18 = load float, float* %17, align 4, !tbaa !1

; CHECK-DAG: %[[CST:[0-9]+]] = load float, float* %2, align 4, !tbaa !1
; CHECK-DAG: %[[GEPA:[0-9]+]] = getelementptr inbounds float, float* %0
; CHECK-DAG: %[[LDA:[0-9]+]] = load float, float* %[[GEPA]]
; CHECK-DAG: %[[GEPB:[0-9]+]] = getelementptr inbounds float, float* %1
; CHECK-DAG: %[[LDB:[0-9]+]] = load float, float* %[[GEPB]]

; CHECK-DAG: %[[MUL:[0-9]+]] = fmul fast float %[[CST]], %[[LDA]]
; CHECK-DAG: %[[ADD:[0-9]+]] = fadd fast float %[[MUL]], %[[LDB]]
; CHECK-DAG: %[[X0X0:[0-9]+]] = fmul fast float %[[CST]], %[[CST]]
; CHECK: %[[RES:[0-9]+]] = fmul fast float %[[X0X0]], %[[ADD]]
  %19 = fmul fast float %5, %16
  %20 = fmul fast float %19, %5
  %21 = fmul fast float %20, %5
  %22 = fmul fast float %5, %18
  %23 = fmul fast float %22, %5
  %24 = fadd fast float %21, %23
  %25 = fadd fast float %14, %24
  %26 = add nuw nsw i64 %13, 1
  %27 = icmp eq i64 %26, %8
  br i1 %27, label %9, label %12
}

; Test that it does not happen when fastmath is not specified
; for any multiply instruction in the chain.
define float @test_noreorder(float* noalias nocapture readonly,
                             float* nocapture readonly,
                             float* nocapture readonly,
                             float* nocapture readonly,
                             i32) {
; CHECK-LABEL: test_noreorder
; CHECK-DAG: %[[GEPA:[0-9]+]] = getelementptr inbounds float, float* %0
; CHECK-DAG: %[[LDA:[0-9]+]] = load float, float* %[[GEPA]]
; CHECK-DAG: %[[GEPB:[0-9]+]] = getelementptr inbounds float, float* %1
; CHECK-DAG: %[[LDB:[0-9]+]] = load float, float* %[[GEPB]]
; CHECK-NOT: fadd fast float %[[LDA]], %[[LDB]]
  %6 = load float, float* %3, align 4, !tbaa !1
  %7 = getelementptr inbounds float, float* %3, i64 1
  %8 = load float, float* %7, align 4, !tbaa !1
  %9 = icmp sgt i32 %4, 0
  br i1 %9, label %10, label %13

; <label>:10:                                     ; preds = %5
  %11 = zext i32 %4 to i64
  br label %15

; <label>:12:                                     ; preds = %15
  br label %13

; <label>:13:                                     ; preds = %12, %5
  %14 = phi float [ 0.000000e+00, %5 ], [ %32, %12 ]
  ret float %14

; <label>:15:                                     ; preds = %10, %15
  %16 = phi i64 [ %33, %15 ], [ 0, %10 ]
  %17 = phi float [ %32, %15 ], [ 0.000000e+00, %10 ]
  %18 = getelementptr inbounds float, float* %0, i64 %16
  %19 = load float, float* %18, align 4, !tbaa !1
  %20 = fmul float %6, %19    ; <-- No fast math
  %21 = fmul fast float %8, %20
  %22 = getelementptr inbounds float, float* %1, i64 %16
  %23 = load float, float* %22, align 4, !tbaa !1
  %24 = fmul fast float %6, %23
  %25 = fmul float %8, %24    ; <-- No fast math
  %26 = fadd fast float %21, %25
  %27 = getelementptr inbounds float, float* %2, i64 %16
  %28 = load float, float* %27, align 4, !tbaa !1
  %29 = fmul float %6, %28    ; <-- No fast math
  %30 = fmul fast float %8, %29
  %31 = fadd fast float %26, %30
  %32 = fadd fast float %17, %31
  %33 = add nuw nsw i64 %16, 1
  %34 = icmp eq i64 %33, %11
  br i1 %34, label %12, label %15
}

; Function Attrs: nounwind readnone
declare float @llvm.fmuladd.f32(float, float, float) #0
attributes #0 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = !{!"clang version 5.0.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"float", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
