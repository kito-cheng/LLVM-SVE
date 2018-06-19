; RUN: opt -mtriple=aarch64--linux-gnu -mattr=+sve < %s  -S -O3 -boscc -debug-only=boscc -stats -o - 2>&1 | FileCheck %s
; REQUIRES: asserts

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; Function Attrs: norecurse nounwind
define void @func64(i64* noalias nocapture %d, i64 %a, i32 %count) #0 {
entry:
  %cmp3 = icmp eq i32 %count, 0
  br i1 %cmp3, label %for.end, label %min.iters.checked

min.iters.checked:                                ; preds = %entry
  %0 = add i32 %count, -1
  %1 = zext i32 %0 to i64
  %2 = add nuw nsw i64 %1, 1
  %wide.end.idx.splatinsert = insertelement <n x 2 x i64> undef, i64 %2, i32 0
  %wide.end.idx.splat = shufflevector <n x 2 x i64> %wide.end.idx.splatinsert, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = icmp ugt <n x 2 x i64> %wide.end.idx.splat, stepvector
  %predicate.entry = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), <n x 2 x i1> %3)
  %broadcast.splatinsert3 = insertelement <n x 2 x i64> undef, i64 %a, i32 0
  %broadcast.splat4 = shufflevector <n x 2 x i64> %broadcast.splatinsert3, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  br label %vector.body

; This masked store does not produce a predicated block because it
; uses the main predicate of the loop

; CHECK-LABEL: vector.body:
; CHECK-NOT: guarded.block
; CHECK-NOT: unconditional.block
vector.body:                                      ; preds = %vector.body, %min.iters.checked
  %index = phi i64 [ 0, %min.iters.checked ], [ %index.next, %vector.body ]
  %predicate = phi <n x 2 x i1> [ %predicate.entry, %min.iters.checked ], [ %predicate.next, %vector.body ]
  %4 = icmp ult i64 %index, 4294967296
  call void @llvm.assume(i1 %4)
  %5 = getelementptr inbounds i64, i64* %d, i64 %index
  %6 = bitcast i64* %5 to <n x 2 x i64>*
  call void @llvm.masked.store.nxv2i64.p0nxv2i64(<n x 2 x i64> %broadcast.splat4, <n x 2 x i64>* %6, i32 8, <n x 2 x i1> %predicate)
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 2)
  %7 = add nuw nsw i64 %index, mul (i64 vscale, i64 2)
  %8 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %9 = shufflevector <n x 2 x i64> %8, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %10 = mul <n x 2 x i64> %9, stepvector
  %11 = insertelement <n x 2 x i64> undef, i64 %7, i32 0
  %12 = shufflevector <n x 2 x i64> %11, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %13 = add <n x 2 x i64> %12, %10
  %14 = icmp ult <n x 2 x i64> %13, %wide.end.idx.splat
  %predicate.next = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %predicate, <n x 2 x i1> %14)
  %15 = extractelement <n x 2 x i1> %predicate.next, i64 0
  br i1 %15, label %vector.body, label %for.end.loopexit, !llvm.loop !0

for.end.loopexit:                                 ; preds = %vector.body
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  ret void
}

; Function Attrs: nounwind
declare void @llvm.assume(i1) #1

; Function Attrs: nounwind readnone
declare <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1>, <n x 2 x i1>) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.masked.store.nxv2i64.p0nxv2i64(<n x 2 x i64>, <n x 2 x i64>*, i32, <n x 2 x i1>) #3

attributes #0 = { norecurse nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-features"="+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind readnone }
attributes #3 = { argmemonly nounwind }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}

; The masked store uses the main loop predicate, we don't want to generate additional control flow for this case.
; CHECK-LABEL: Statistics Collected
; CHECK-NOT: loop-pred-blocks
