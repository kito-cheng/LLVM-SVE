; RUN: llc -mtriple=aarch64 -O3 -sve-lower-gather-scatter-to-interleaved=true -mattr=+sve < %s | FileCheck %s
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; This test checks that the SVE post-vectorize pass can re-order scatters by sinking them
; below gathers to form scatter groups using alias analysis.
; In order to generate interleaved accesses it also requires that the GEPs are transformed
; from addressing using a struct type as the basis to instead use the first element type.

%struct.dcomplex = type { double, double }

@main.u1 = external hidden global [128 x %struct.dcomplex], align 8

; Function Attrs: nounwind
define void @test_reorder([128 x %struct.dcomplex]* nocapture %xout) unnamed_addr #0 {
; CHECK-LABEL: test_reorder:
entry:
  %y03 = alloca [128 x %struct.dcomplex], align 8
  %y14 = alloca [128 x %struct.dcomplex], align 8
  %wide.end.idx.splatinsert52 = insertelement <n x 2 x i64> undef, i64 42, i32 0
  %wide.end.idx.splat53 = shufflevector <n x 2 x i64> %wide.end.idx.splatinsert52, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %vecidx = icmp ugt <n x 2 x i64> %wide.end.idx.splat53, stepvector
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %scevgep62 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* @main.u1, i64 0, i64 0
  %scevgep63 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %y03, i64 0, i64 0
  %scevgep64 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* @main.u1, i64 0, i64 0, i32 1
  %scevgep65 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %y03, i64 0, i64 0, i32 1
  %predicate.entry54 = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), <n x 2 x i1> %vecidx)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
; CHECK: ld2d
; CHECK: st2d
  %index55 = phi i64 [ 0, %vector.ph ], [ %index.next68, %vector.body ]
  %predicate56 = phi <n x 2 x i1> [ %predicate.entry54, %vector.ph ], [ %predicate.next69, %vector.body ]
  %a13 = icmp ult i64 %index55, 4294967296
  call void @llvm.assume(i1 %a13)
  %0 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %1 = shufflevector <n x 2 x i64> %0, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %2 = mul <n x 2 x i64> %1, stepvector
  %3 = insertelement <n x 2 x i64> undef, i64 %index55, i32 0
  %4 = shufflevector <n x 2 x i64> %3, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a14 = add <n x 2 x i64> %4, %2
  %a15 = getelementptr %struct.dcomplex, %struct.dcomplex* %scevgep62, <n x 2 x i64> %a14
  %a16 = bitcast <n x 2 x %struct.dcomplex*> %a15 to <n x 2 x i64*>
  %a17 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %a16, i32 8, <n x 2 x i1> %predicate56, <n x 2 x i64> undef), !tbaa !1
  %5 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %6 = shufflevector <n x 2 x i64> %5, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %7 = mul <n x 2 x i64> %6, stepvector
  %8 = insertelement <n x 2 x i64> undef, i64 %index55, i32 0
  %9 = shufflevector <n x 2 x i64> %8, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a18 = add <n x 2 x i64> %9, %7
  %a19 = getelementptr %struct.dcomplex, %struct.dcomplex* %scevgep63, <n x 2 x i64> %a18
  %a20 = bitcast <n x 2 x %struct.dcomplex*> %a19 to <n x 2 x i64*>
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %a17, <n x 2 x i64*> %a20, i32 8, <n x 2 x i1> %predicate56), !tbaa !1
  %a21 = shl nuw i64 %index55, 1
  %10 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %11 = shufflevector <n x 2 x i64> %10, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %12 = mul <n x 2 x i64> %11, stepvector
  %13 = insertelement <n x 2 x i64> undef, i64 %a21, i32 0
  %14 = shufflevector <n x 2 x i64> %13, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a22 = add <n x 2 x i64> %14, %12
  %a23 = getelementptr double, double* %scevgep64, <n x 2 x i64> %a22
  %a24 = bitcast <n x 2 x double*> %a23 to <n x 2 x i64*>
  %a25 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %a24, i32 8, <n x 2 x i1> %predicate56, <n x 2 x i64> undef), !tbaa !6
  %a26 = shl nuw i64 %index55, 1
  %15 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %16 = shufflevector <n x 2 x i64> %15, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %17 = mul <n x 2 x i64> %16, stepvector
  %18 = insertelement <n x 2 x i64> undef, i64 %a26, i32 0
  %19 = shufflevector <n x 2 x i64> %18, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a27 = add <n x 2 x i64> %19, %17
  %a28 = getelementptr double, double* %scevgep65, <n x 2 x i64> %a27
  %a29 = bitcast <n x 2 x double*> %a28 to <n x 2 x i64*>
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %a25, <n x 2 x i64*> %a29, i32 8, <n x 2 x i1> %predicate56), !tbaa !6
  %index.next68 = add nuw nsw i64 %index55, mul (i64 vscale, i64 2)
  %a30 = add nuw nsw i64 %index55, mul (i64 vscale, i64 2)
  %20 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %21 = shufflevector <n x 2 x i64> %20, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %22 = mul <n x 2 x i64> %21, stepvector
  %23 = insertelement <n x 2 x i64> undef, i64 %a30, i32 0
  %24 = shufflevector <n x 2 x i64> %23, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a31 = add <n x 2 x i64> %24, %22
  %a32 = icmp ult <n x 2 x i64> %a31, %wide.end.idx.splat53
  %predicate.next69 = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %predicate56, <n x 2 x i1> %a32)
  %a33 = extractelement <n x 2 x i1> %predicate.next69, i64 0
  br i1 %a33, label %vector.body, label %vec.loopexit, !llvm.loop !7

vec.loopexit:                                     ; preds = %vector.body
  br label %vec.ph2

vec.ph2:                                          ; preds = %vec.loopexit
  %wide.end.idx.splatinsert = insertelement <n x 2 x i64> undef, i64 42, i32 0
  %wide.end.idx.splat = shufflevector <n x 2 x i64> %wide.end.idx.splatinsert, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a41 = icmp ugt <n x 2 x i64> %wide.end.idx.splat, stepvector
  %scevgep = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %y03, i64 0, i64 0
  %scevgep40 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %xout, i64 0, i64 0
  %scevgep41 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %y03, i64 0, i64 0, i32 1
  %scevgep42 = getelementptr [128 x %struct.dcomplex], [128 x %struct.dcomplex]* %xout, i64 0, i64 0, i32 1
  %predicate.entry = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), <n x 2 x i1> %a41)
  br label %vector.body2

vector.body2:                                     ; preds = %vector.body2, %vec.ph2
; CHECK: ld2d
; CHECK: st2d
  %index = phi i64 [ 0, %vec.ph2 ], [ %index.next, %vector.body2 ]
  %predicate = phi <n x 2 x i1> [ %predicate.entry, %vec.ph2 ], [ %predicate.next, %vector.body2 ]
  %a42 = icmp ult i64 %index, 4294967296
  call void @llvm.assume(i1 %a42)
  %25 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %26 = shufflevector <n x 2 x i64> %25, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %27 = mul <n x 2 x i64> %26, stepvector
  %28 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %29 = shufflevector <n x 2 x i64> %28, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a43 = add <n x 2 x i64> %29, %27
  %a44 = getelementptr %struct.dcomplex, %struct.dcomplex* %scevgep, <n x 2 x i64> %a43
  %a45 = bitcast <n x 2 x %struct.dcomplex*> %a44 to <n x 2 x i64*>
  %a46 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %a45, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef), !tbaa !1
  %30 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %31 = shufflevector <n x 2 x i64> %30, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %32 = mul <n x 2 x i64> %31, stepvector
  %33 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %34 = shufflevector <n x 2 x i64> %33, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a47 = add <n x 2 x i64> %34, %32
  %a48 = getelementptr %struct.dcomplex, %struct.dcomplex* %scevgep40, <n x 2 x i64> %a47
  %a49 = bitcast <n x 2 x %struct.dcomplex*> %a48 to <n x 2 x i64*>
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %a46, <n x 2 x i64*> %a49, i32 8, <n x 2 x i1> %predicate), !tbaa !1
  %a50 = shl nuw i64 %index, 1
  %35 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %36 = shufflevector <n x 2 x i64> %35, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %37 = mul <n x 2 x i64> %36, stepvector
  %38 = insertelement <n x 2 x i64> undef, i64 %a50, i32 0
  %39 = shufflevector <n x 2 x i64> %38, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a51 = add <n x 2 x i64> %39, %37
  %a52 = getelementptr double, double* %scevgep41, <n x 2 x i64> %a51
  %a53 = bitcast <n x 2 x double*> %a52 to <n x 2 x i64*>
  %a54 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %a53, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef), !tbaa !6
  %a55 = shl nuw i64 %index, 1
  %40 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %41 = shufflevector <n x 2 x i64> %40, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %42 = mul <n x 2 x i64> %41, stepvector
  %43 = insertelement <n x 2 x i64> undef, i64 %a55, i32 0
  %44 = shufflevector <n x 2 x i64> %43, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a56 = add <n x 2 x i64> %44, %42
  %a57 = getelementptr double, double* %scevgep42, <n x 2 x i64> %a56
  %a58 = bitcast <n x 2 x double*> %a57 to <n x 2 x i64*>
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %a54, <n x 2 x i64*> %a58, i32 8, <n x 2 x i1> %predicate), !tbaa !6
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 2)
  %a59 = add nuw nsw i64 %index, mul (i64 vscale, i64 2)
  %45 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %46 = shufflevector <n x 2 x i64> %45, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %47 = mul <n x 2 x i64> %46, stepvector
  %48 = insertelement <n x 2 x i64> undef, i64 %a59, i32 0
  %49 = shufflevector <n x 2 x i64> %48, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %a60 = add <n x 2 x i64> %49, %47
  %a61 = icmp ult <n x 2 x i64> %a60, %wide.end.idx.splat
  %predicate.next = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %predicate, <n x 2 x i1> %a61)
  %a62 = extractelement <n x 2 x i1> %predicate.next, i64 0
  br i1 %a62, label %vector.body2, label %vec.loopexit2, !llvm.loop !10

vec.loopexit2:                                    ; preds = %vector.body2
  br label %end

end:                                              ; preds = %vec.loopexit2
  ret void
}

; Function Attrs: nounwind
declare void @llvm.assume(i1) #1

; Function Attrs: nounwind readnone
declare <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1>, <n x 2 x i1>) #2

; Function Attrs: nounwind readonly
declare <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*>, i32, <n x 2 x i1>, <n x 2 x i64>) #3

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64>, <n x 2 x i64*>, i32, <n x 2 x i1>) #1

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang"}
!1 = !{!2, !3, i64 0}
!2 = !{!"", !3, i64 0, !3, i64 8}
!3 = !{!"double", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!2, !3, i64 8}
!7 = distinct !{!7, !8, !9}
!8 = !{!"llvm.loop.vectorize.width", i32 1}
!9 = !{!"llvm.loop.interleave.count", i32 1}
!10 = distinct !{!10, !8, !9}
