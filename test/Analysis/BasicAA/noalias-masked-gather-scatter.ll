; RUN: opt < %s -basicaa -aa-eval -print-all-alias-modref-info -disable-output 2>&1 | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-none--elf"

;; Verify the number of aliases match what we expect
; CHECK: Alias Analysis Evaluator Report
; CHECK-NEXT: 15 Total Alias Queries Performed
; CHECK-NEXT: 8 no alias responses
; CHECK-NEXT: 3 may alias responses
; CHECK-NEXT: 1 partial alias responses
; CHECK-NEXT: 3 must alias responses

; Function Attrs: nounwind
define void @somefunc(double* nocapture %ptr, i32 %idx1, i32 %idx2) #0 {
entry:
  %local_array = alloca [1024 x double], align 8
  %0 = bitcast [1024 x double]* %local_array to i8*
  call void @llvm.lifetime.start.p0i8(i64 8192, i8* %0) #2
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 8192, i32 8, i1 false)
  %predicate.entry = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), <n x 2 x i1> icmp ult (<n x 2 x i64> stepvector, <n x 2 x i64> shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 342, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)))
  %1 = getelementptr inbounds [1024 x double], [1024 x double]* %local_array, i64 0, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %predicate = phi <n x 2 x i1> [ %predicate.entry, %entry ], [ %predicate.next, %vector.body ]
  %2 = icmp ult i64 %index, 342
  call void @llvm.assume(i1 %2)
  %3 = trunc i64 %index to i32
  %4 = mul nuw nsw i32 %3, 3
  %5 = insertelement <n x 2 x i32> undef, i32 3, i32 0
  %6 = shufflevector <n x 2 x i32> %5, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %7 = mul <n x 2 x i32> %6, stepvector
  %8 = insertelement <n x 2 x i32> undef, i32 %4, i32 0
  %9 = shufflevector <n x 2 x i32> %8, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %10 = add <n x 2 x i32> %9, %7
  %11 = getelementptr double, double* %ptr, <n x 2 x i32> %10
  %12 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %11, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef), !tbaa !1
  %13 = fadd fast <n x 2 x double> %12, shufflevector (<n x 2 x double> insertelement (<n x 2 x double> undef, double 3.000000e+00, i32 0), <n x 2 x double> undef, <n x 2 x i32> zeroinitializer)
  %14 = trunc i64 %index to i32
  %15 = mul nuw nsw i32 %14, 3
  %16 = insertelement <n x 2 x i32> undef, i32 3, i32 0
  %17 = shufflevector <n x 2 x i32> %16, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %18 = mul <n x 2 x i32> %17, stepvector
  %19 = insertelement <n x 2 x i32> undef, i32 %15, i32 0
  %20 = shufflevector <n x 2 x i32> %19, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %21 = add <n x 2 x i32> %20, %18
  %22 = getelementptr double, double* %1, <n x 2 x i32> %21
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %13, <n x 2 x double*> %22, i32 8, <n x 2 x i1> %predicate), !tbaa !1
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 2)
  %23 = add nuw nsw i64 %index, mul (i64 vscale, i64 2)
  %24 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %25 = shufflevector <n x 2 x i64> %24, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %26 = mul <n x 2 x i64> %25, stepvector
  %27 = insertelement <n x 2 x i64> undef, i64 %23, i32 0
  %28 = shufflevector <n x 2 x i64> %27, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %29 = add <n x 2 x i64> %28, %26
  %30 = icmp ult <n x 2 x i64> %29, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 342, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  %predicate.next = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %predicate, <n x 2 x i1> %30)
  %31 = extractelement <n x 2 x i1> %predicate.next, i64 0
  br i1 %31, label %vector.body, label %for.cond.cleanup, !llvm.loop !5

for.cond.cleanup:                                 ; preds = %vector.body
  %idxprom4 = sext i32 %idx2 to i64
  %arrayidx5 = getelementptr inbounds [1024 x double], [1024 x double]* %local_array, i64 0, i64 %idxprom4
  %32 = load double, double* %arrayidx5, align 8, !tbaa !1
  %idxprom6 = sext i32 %idx1 to i64
  %arrayidx7 = getelementptr inbounds double, double* %ptr, i64 %idxprom6
  %33 = load double, double* %arrayidx7, align 8, !tbaa !1
  %add8 = fadd fast double %33, %32
  store double %add8, double* %arrayidx7, align 8, !tbaa !1
  call void @llvm.lifetime.end.p0i8(i64 8192, i8* nonnull %0) #2
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #1

; Function Attrs: nounwind
declare void @llvm.assume(i1) #2

; Function Attrs: nounwind readnone
declare <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1>, <n x 2 x i1>) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

; Function Attrs: nounwind readonly
declare <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*>, i32, <n x 2 x i1>, <n x 2 x double>) #4

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double>, <n x 2 x double*>, i32, <n x 2 x i1>) #2

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind }
attributes #3 = { nounwind readnone }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"double", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.vectorize.width", i32 1}
!7 = !{!"llvm.loop.interleave.count", i32 1}
