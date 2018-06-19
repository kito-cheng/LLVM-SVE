; RUN: opt -mtriple=aarch64-linux-generic -mattr=+sve < %s -O1 -sve-loop-vectorize -constprop -instcombine -early-cse -force-vector-predication -force-vector-width=4 -force-scalable-vectorization -force-vector-interleave=2 -S | FileCheck %s

; int unroll_reduction(int * restrict a, const unsigned n) {
;   unsigned i, s = 0;
;   for (i = 0; i < n; ++i)
;    s += a[i];

;   return s;
; }

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-generic"

; Function Attrs: nounwind readonly
; CHECK-LABEL: @unroll_reduction(
; CHECK-LABEL: min.iters.checked:
; CHECK: [[INITICMP0:%[a-zA-Z0-9]+]] = icmp ugt <n x 4 x i64> %wide.end.idx.splat, stepvector
; [[PREDENTRY:%predicate.entry[0-9]+]] = tail call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> shufflevector (<n x 4 x i1> insertelement (<n x 4 x i1> undef, i1 true, i32 0), <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i1> [[INITICMP0]])
; [[INITICMP1:%[a-zA-Z0-9]+]] = icmp ugt <n x 4 x i64> %wide.end.idx.splat, add (<n x 4 x i64> stepvector, <n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 mul (i64 vscale, i64 4), i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer))
; {{%predicate.entry[0-9]+}} = tail call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> [[PREDENTRY]], <n x 4 x i1> [[INITICMP1]])

; CHECK-LABEL: vector.body:

; Predicate initialization
; CHECK:  %predicate = phi <n x 4 x i1> [ %predicate.entry, %min.iters.checked ], [ %predicate.next, %vector.body ]
; CHECK:  [[P2:%predicate[0-9]+]] = phi <n x 4 x i1> [ %predicate.entry{{[0-9]+}}, %min.iters.checked ], [ [[PNEXT:%predicate.next[0-9]+]], %vector.body ]

; Masked load with correct predicate
; CHECK-DAG:  %wide.masked.load = call <n x 4 x i32> @llvm.masked.load.nxv4i32.p0nxv4i32(<n x 4 x i32>* {{%[0-9]+}}, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1
; CHECK-DAG:  %{{[0-9]+}} = getelementptr <n x 4 x i32>, <n x 4 x i32>* %{{[0-9]+}}, i64 1
; CHECK-DAG:  [[WML:%wide.masked.load[0-9]+]] = call <n x 4 x i32> @llvm.masked.load.nxv4i32.p0nxv4i32(<n x 4 x i32>* {{%[0-9]+}}, i32 4, <n x 4 x i1> [[P2]], <n x 4 x i32> undef), !tbaa !1

; First unrolled chunk predicate update
; CHECK-DAG: [[I_UNROLL_NEXTA:%.+]] = add nuw nsw i64 %index, mul (i64 vscale, i64 8)
; CHECK-DAG: [[TA1:%.+]] = insertelement <n x 4 x i64> undef, i64 [[I_UNROLL_NEXTA]], i32 0
; CHECK-DAG: [[TA2:%.+]] = shufflevector <n x 4 x i64> [[TA1]], <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
; CHECK-DAG: [[TA3:%.+]] = add <n x 4 x i64> [[TA2]], stepvector
; CHECK-DAG: [[TA4:%.+]] = icmp ult <n x 4 x i64> [[TA3]], %wide.end.idx.splat
; CHECK-DAG: %predicate.next = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> [[P2]], <n x 4 x i1> [[TA4]])

; Second unrolled chunk predicate update
; CHECK: [[I_UNROLL_NEXTB:%.+]] = add i64 %index, add (i64 mul (i64 vscale, i64 8), i64 mul (i64 vscale, i64 4))
; CHECK-DAG: [[TB1:%.+]] = insertelement <n x 4 x i64> undef, i64 [[I_UNROLL_NEXTB]], i32 0
; CHECK-DAG: [[TB2:%.+]] = shufflevector <n x 4 x i64> [[TB1]], <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
; CHECK-DAG: [[TB3:%.+]] = add <n x 4 x i64> [[TB2]], stepvector
; CHECK-DAG: [[TB4:%.+]] = icmp ult <n x 4 x i64> [[TB3]], %wide.end.idx.splat
; CHECK: [[PNEXT]] = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %predicate.next, <n x 4 x i1> [[TB4]])

; Block repeat condition
; CHECK: [[EXIT:%[a-zA-Z0-9]+]] = extractelement <n x 4 x i1> %predicate.next, i64 0

; Exit block
; CHECK: br i1 [[EXIT]], label %vector.body, label %middle.block


; CHECK: middle.block:
; CHECK: call i32 @llvm.experimental.vector.reduce.add.i32.nxv4i32
define i32 @unroll_reduction(i32* noalias nocapture readonly %a, i32 %n) #1 {
entry:
  %cmp.6 = icmp eq i32 %n, 0
  br i1 %cmp.6, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %s.08 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %add = add i32 %0, %s.08
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %s.0.lcssa = phi i32 [ 0, %entry ], [ %add, %for.body ]
  ret i32 %s.0.lcssa
}

declare <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1>, <n x 4 x i1>)

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
