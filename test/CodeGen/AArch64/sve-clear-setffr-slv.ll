; RUN: llc < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-none-linux-gnu"

;; Derived from the SearchVals function in the following c code.
;;#include <stdio.h>
;;#include <stdlib.h>
;;#include <unistd.h>
;;#include <stdint.h>
;;
;;#define NUM_VALS (14)
;;
;;int Vals[NUM_VALS] = { 1, 4, 13, 40, 121, 364, 1093, 3280,
;;                       9841, 29524, 88573, 265720, 797161, 2391484 };
;;
;;__attribute__ ((noinline))
;;int SearchVals(int *restrict Array1, int *restrict Array2, int UBound, int BreakVal) {
;;  int Idx = 0;
;;
;;  for (Idx = 0; Idx <= UBound; ++Idx)
;;    if(Array1[Idx] >= BreakVal || Array2[Idx] >= BreakVal)
;;      break;
;;
;;  return Idx;
;;}
;;
;;int main(int argc, char *argv[]) {
;;  int BreakVal = 80000;
;;  int Idx = SearchVals(Vals, NUM_VALS, BreakVal);
;;  printf("BreakVal = %d, Idx = %d\n", BreakVal, Idx);
;;  return EXIT_SUCCESS;
;;}

; Function Attrs: norecurse nounwind readonly
define i32 @SearchVals(i32* noalias nocapture readonly %Array1, i32* noalias nocapture readonly %Array2, i32 %UBound, i32 %BreakVal) #0 {
entry:
  %cmp.6 = icmp slt i32 %UBound, 0
  br i1 %cmp.6, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  %0 = sext i32 %UBound to i64
  br i1 false, label %scalar.ph, label %overflow.checked

overflow.checked:                                 ; preds = %for.body.preheader
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %overflow.checked
; CHECK: for.body.preheader
; CHECK: setffr
; CHECK: ldff1w
; CHECK-NOT: rdffr
; CHECK-NOT: setffr
; CHECK: ldff1w
; CHECK: rdffr [[RDFFR:p[0-9]+]].b
; CHECK: and {{p[0-9]+}}.b, {{p[0-9]+}}/z, {{p[0-9]+}}.b, [[RDFFR]].b
  %broadcast.splatinsert = insertelement <n x 4 x i64> undef, i64 %0, i32 0
  %broadcast.splat = shufflevector <n x 4 x i64> %broadcast.splatinsert, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %1 = icmp sgt <n x 4 x i64> %broadcast.splat, stepvector
  %2 = bitcast i32* %Array1 to <n x 4 x i32>*
  %wide.masked.specload = call { <n x 4 x i32>, <n x 4 x i1> } @llvm.masked.spec.load.nxv4i32(<n x 4 x i32>* %2, i32 4, <n x 4 x i1> %1, <n x 4 x i32> undef)
  %3 = extractvalue { <n x 4 x i32>, <n x 4 x i1> } %wide.masked.specload, 1
  %4 = extractvalue { <n x 4 x i32>, <n x 4 x i1> } %wide.masked.specload, 0
  %broadcast.splatinsert3 = insertelement <n x 4 x i32> undef, i32 %BreakVal, i32 0
  %broadcast.splat4 = shufflevector <n x 4 x i32> %broadcast.splatinsert3, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %5 = icmp sgt <n x 4 x i32> %4, %broadcast.splat4
  %6 = bitcast i32* %Array2 to <n x 4 x i32>*
  %wide.masked.specload7 = call { <n x 4 x i32>, <n x 4 x i1> } @llvm.masked.spec.load.nxv4i32(<n x 4 x i32>* %6, i32 4, <n x 4 x i1> %1, <n x 4 x i32> undef)
  %7 = extractvalue { <n x 4 x i32>, <n x 4 x i1> } %wide.masked.specload7, 1
  %8 = extractvalue { <n x 4 x i32>, <n x 4 x i1> } %wide.masked.specload7, 0
  %9 = icmp sgt <n x 4 x i32> %8, %broadcast.splat4
  %10 = or <n x 4 x i1> %5, %9
  %11 = xor <n x 4 x i1> %10, shufflevector (<n x 4 x i1> insertelement (<n x 4 x i1> undef, i1 true, i32 0), <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer)
  %12 = and <n x 4 x i1> %1, %11
  %13 = and <n x 4 x i1> %3, %7
  %14 = and <n x 4 x i1> %12, %13
  %splatins = insertelement <n x 4 x i1> undef, i1 true, i32 0
  %ptrue = shufflevector <n x 4 x i1> %splatins, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %fullvectorbody = call i1 @llvm.aarch64.sve.andv.nxv4i1(<n x 4 x i1> %ptrue, <n x 4 x i1> %14)
  br i1 %fullvectorbody, label %vector.body.unpred, label %vector.tail

vector.body.unpred:                               ; preds = %vector.body.unpred, %vector.ph
; CHECK: vector.body.unpred
; CHECK: setffr
; CHECK: ldff1w
; CHECK-NOT: rdffr
; CHECK-NOT: setffr
; CHECK: ldff1w
; CHECK: rdffr [[RDFFR:p[0-9]+]].b
; CHECK: and {{p[0-9]+}}.b, {{p[0-9]+}}/z, {{p[0-9]+}}.b, [[RDFFR]].b
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body.unpred ]
  %broadcast.splatinsert14 = insertelement <n x 4 x i32> undef, i32 %BreakVal, i32 0
  %broadcast.splat15 = shufflevector <n x 4 x i32> %broadcast.splatinsert14, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %broadcast.splatinsert19 = insertelement <n x 4 x i64> undef, i64 %0, i32 0
  %broadcast.splat20 = shufflevector <n x 4 x i64> %broadcast.splatinsert19, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %15 = add i64 %index, mul (i64 vscale, i64 4)
  %16 = insertelement <n x 4 x i64> undef, i64 1, i32 0
  %17 = shufflevector <n x 4 x i64> %16, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %18 = mul <n x 4 x i64> %17, stepvector
  %19 = insertelement <n x 4 x i64> undef, i64 %15, i32 0
  %20 = shufflevector <n x 4 x i64> %19, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %induction23 = add <n x 4 x i64> %20, %18
  %21 = icmp slt <n x 4 x i64> %induction23, %broadcast.splat20
  %22 = add i64 %index, mul (i64 vscale, i64 4)
  %23 = getelementptr inbounds i32, i32* %Array1, i64 %22
  %24 = bitcast i32* %23 to <n x 4 x i32>*
  %wide.masked.specload38 = call { <n x 4 x i32>, <n x 4 x i1> } @llvm.masked.spec.load.nxv4i32(<n x 4 x i32>* %24, i32 4, <n x 4 x i1> %21, <n x 4 x i32> undef)
  %25 = extractvalue { <n x 4 x i32>, <n x 4 x i1> } %wide.masked.specload38, 1
  %26 = extractvalue { <n x 4 x i32>, <n x 4 x i1> } %wide.masked.specload38, 0
  %27 = icmp sgt <n x 4 x i32> %26, %broadcast.splat15
  %28 = getelementptr inbounds i32, i32* %Array2, i64 %22
  %29 = bitcast i32* %28 to <n x 4 x i32>*
  %wide.masked.specload43 = call { <n x 4 x i32>, <n x 4 x i1> } @llvm.masked.spec.load.nxv4i32(<n x 4 x i32>* %29, i32 4, <n x 4 x i1> %21, <n x 4 x i32> undef)
  %30 = extractvalue { <n x 4 x i32>, <n x 4 x i1> } %wide.masked.specload43, 1
  %31 = extractvalue { <n x 4 x i32>, <n x 4 x i1> } %wide.masked.specload43, 0
  %32 = icmp sgt <n x 4 x i32> %31, %broadcast.splat15
  %33 = or <n x 4 x i1> %27, %32
  %34 = xor <n x 4 x i1> %33, shufflevector (<n x 4 x i1> insertelement (<n x 4 x i1> undef, i1 true, i32 0), <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer)
  %35 = and <n x 4 x i1> %21, %34
  %36 = and <n x 4 x i1> %25, %30
  %37 = and <n x 4 x i1> %35, %36
  %has.exit = call i1 @llvm.aarch64.sve.andv.nxv4i1(<n x 4 x i1> %ptrue, <n x 4 x i1> %37)
  br i1 %has.exit, label %vector.body.unpred, label %vector.tail, !llvm.loop !1

vector.tail:                                      ; preds = %vector.body.unpred, %vector.ph
  %38 = phi <n x 4 x i1> [ %14, %vector.ph ], [ %37, %vector.body.unpred ]
  %39 = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body.unpred ]
  %40 = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> shufflevector (<n x 4 x i1> insertelement (<n x 4 x i1> undef, i1 true, i32 0), <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i1> %38)
  %grn.cnt = call i64 @llvm.ctvpop.nxv4i1(<n x 4 x i1> %40)
  %41 = add i64 %39, %grn.cnt
  %42 = trunc i64 %41 to i32
  br label %reduction.loop

reduction.loop:                                   ; preds = %vector.tail
  br label %reduction.loop.ret

reduction.loop.ret:                               ; preds = %reduction.loop
  br label %for.end.loopexit

scalar.ph:                                        ; preds = %overflow.checked, %for.body.preheader
  br label %for.body

for.body:                                         ; preds = %for.inc, %scalar.ph
  br i1 undef, label %for.end.loopexit, label %for.inc

for.inc:                                          ; preds = %for.body
  br i1 undef, label %for.body, label %for.end.loopexit, !llvm.loop !4

for.end.loopexit:                                 ; preds = %for.inc, %for.body, %reduction.loop.ret
  %Idx.0.lcssa.ph = phi i32 [ undef, %for.body ], [ undef, %for.inc ], [ %42, %reduction.loop.ret ]
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %Idx.0.lcssa = phi i32 [ 0, %entry ], [ %Idx.0.lcssa.ph, %for.end.loopexit ]
  ret i32 %Idx.0.lcssa
}

; Function Attrs: argmemonly nounwind readonly
declare { <n x 4 x i32>, <n x 4 x i1> } @llvm.masked.spec.load.nxv4i32(<n x 4 x i32>*, i32, <n x 4 x i1>, <n x 4 x i32>) #1

; Function Attrs: nounwind readnone speculatable
declare i64 @llvm.ctvpop.nxv4i1(<n x 4 x i1>) #2

; Function Attrs: nounwind readnone
declare i1 @llvm.aarch64.sve.andv.nxv4i1(<n x 4 x i1>, <n x 4 x i1>) #3

; Function Attrs: nounwind readnone
declare <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1>, <n x 4 x i1>) #3

; Function Attrs: argmemonly nounwind readonly
declare <n x 4 x i32> @llvm.masked.load.nxv4i32.p0nxv4i32(<n x 4 x i32>*, i32, <n x 4 x i1>, <n x 4 x i32>) #1

attributes #0 = { norecurse nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+sve" }
attributes #1 = { argmemonly nounwind readonly }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = distinct !{!1, !2, !3}
!2 = !{!"llvm.loop.vectorize.width", i32 1}
!3 = !{!"llvm.loop.interleave.count", i32 1}
!4 = distinct !{!4, !2, !3}
