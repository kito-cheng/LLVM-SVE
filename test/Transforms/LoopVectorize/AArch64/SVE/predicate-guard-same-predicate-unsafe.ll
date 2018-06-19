; RUN: opt -mtriple=aarch64--linux-gnu -mattr=+sve < %s  -S -O3 -insert-superword-control-flow -stats -o - 2>&1 | FileCheck %s
; REQUIRES: asserts

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; Function Attrs: norecurse nounwind
define void @foo(i32* nocapture readonly %a, float* noalias nocapture %b, float* noalias nocapture %c, i32 %n) #0 {
entry:
  %predicate.entry = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> shufflevector (<n x 4 x i1> insertelement (<n x 4 x i1> undef, i1 true, i32 0), <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i1> icmp ult (<n x 4 x i64> stepvector, <n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 1024, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer)))
  br label %vector.body

; CHECK-LABEL: vector.body:
; CHECK: guarded.block
; CHECK: unconditional.block
; CHECK: guarded.block
; CHECK: unconditional.block
vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %predicate = phi <n x 4 x i1> [ %predicate.entry, %entry ], [ %predicate.next, %vector.body ]
  %0 = icmp ult i64 %index, 1024
  call void @llvm.assume(i1 %0)
  %1 = getelementptr inbounds i32, i32* %a, i64 %index
  %2 = bitcast i32* %1 to <n x 4 x i32>*
  %wide.masked.load = call <n x 4 x i32> @llvm.masked.load.nxv4i32.p0nxv4i32(<n x 4 x i32>* %2, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1
  %3 = icmp slt <n x 4 x i32> %wide.masked.load, shufflevector (<n x 4 x i32> insertelement (<n x 4 x i32> undef, i32 10, i32 0), <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer)
  %4 = getelementptr inbounds float, float* %c, i64 %index
  %5 = xor <n x 4 x i1> %3, shufflevector (<n x 4 x i1> insertelement (<n x 4 x i1> undef, i1 true, i32 0), <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer)
  %6 = bitcast float* %4 to <n x 4 x float>*
  %7 = and <n x 4 x i1> %5, %predicate
  %wide.masked.load13 = call <n x 4 x float> @llvm.masked.load.nxv4f32.p0nxv4f32(<n x 4 x float>* %6, i32 4, <n x 4 x i1> %7, <n x 4 x float> undef), !tbaa !5
  %8 = fadd <n x 4 x float> %wide.masked.load13, shufflevector (<n x 4 x float> insertelement (<n x 4 x float> undef, float 1.000000e+00, i32 0), <n x 4 x float> undef, <n x 4 x i32> zeroinitializer)
  %9 = bitcast float* %4 to <n x 4 x float>*
  %10 = and <n x 4 x i1> %5, %predicate
  call void @llvm.masked.store.nxv4f32.p0nxv4f32(<n x 4 x float> %8, <n x 4 x float>* %9, i32 4, <n x 4 x i1> %10), !tbaa !5
  %11 = getelementptr inbounds float, float* %c, i64 %index
  %12 = bitcast float* %11 to <n x 4 x float>*
  %13 = and <n x 4 x i1> %3, %predicate
  %wide.masked.load14 = call <n x 4 x float> @llvm.masked.load.nxv4f32.p0nxv4f32(<n x 4 x float>* %12, i32 4, <n x 4 x i1> %13, <n x 4 x float> undef), !tbaa !5
  %14 = fadd <n x 4 x float> %wide.masked.load14, shufflevector (<n x 4 x float> insertelement (<n x 4 x float> undef, float 1.000000e+00, i32 0), <n x 4 x float> undef, <n x 4 x i32> zeroinitializer)
  %15 = bitcast float* %11 to <n x 4 x float>*
  call void @llvm.masked.store.nxv4f32.p0nxv4f32(<n x 4 x float> %14, <n x 4 x float>* %15, i32 4, <n x 4 x i1> %10), !tbaa !5
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %16 = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %17 = insertelement <n x 4 x i64> undef, i64 1, i32 0
  %18 = shufflevector <n x 4 x i64> %17, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %19 = mul <n x 4 x i64> %18, stepvector
  %20 = insertelement <n x 4 x i64> undef, i64 %16, i32 0
  %21 = shufflevector <n x 4 x i64> %20, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %22 = add <n x 4 x i64> %21, %19
  %23 = icmp ult <n x 4 x i64> %22, shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 1024, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer)
  %predicate.next = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %predicate, <n x 4 x i1> %23)
  %24 = extractelement <n x 4 x i1> %predicate.next, i64 0
  br i1 %24, label %vector.body, label %for.cond.cleanup, !llvm.loop !7

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

; Function Attrs: nounwind
declare void @llvm.assume(i1) #1

; Function Attrs: nounwind readnone
declare <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1>, <n x 4 x i1>) #2

; Function Attrs: argmemonly nounwind readonly
declare <n x 4 x i32> @llvm.masked.load.nxv4i32.p0nxv4i32(<n x 4 x i32>*, i32, <n x 4 x i1>, <n x 4 x i32>) #3

; Function Attrs: argmemonly nounwind readonly
declare <n x 4 x float> @llvm.masked.load.nxv4f32.p0nxv4f32(<n x 4 x float>*, i32, <n x 4 x i1>, <n x 4 x float>) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.masked.store.nxv4f32.p0nxv4f32(<n x 4 x float>, <n x 4 x float>*, i32, <n x 4 x i1>) #4

attributes #0 = { norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind readnone }
attributes #3 = { argmemonly nounwind readonly }
attributes #4 = { argmemonly nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"float", !3, i64 0}
!7 = distinct !{!7, !8, !9}
!8 = !{!"llvm.loop.vectorize.width", i32 1}
!9 = !{!"llvm.loop.interleave.count", i32 1}

; The masked store uses the main loop predicate, we don't want to generate additional control flow for this case.
; CHECK-LABEL: Statistics Collected
; CHECK:  2 boscc - Number of guarded blocks generated
; CHECK:  2 boscc - Number of masked stores that
