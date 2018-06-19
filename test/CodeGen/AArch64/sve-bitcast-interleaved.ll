; RUN: llc -mtriple=aarch64 -O3 -sve-lower-gather-scatter-to-interleaved=true -mattr=+sve < %s | FileCheck %s
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; This test checks that the SVE interleaved-gather-scatter pass can replace a gather group consisting of
; gathers of different types with an ldN by suitable bitcasting.

; Function Attrs: norecurse nounwind
define void @test_gather(i32 %start, i32 %end, [2 x float]* nocapture readonly %x, [2 x float]* nocapture %buf, [2 x float]* nocapture %f, [2 x float]* nocapture readonly %v) local_unnamed_addr #0 {
entry:
  %cmp41 = icmp slt i32 %start, %end
  br i1 %cmp41, label %for.cond1.preheader.preheader, label %for.end24

for.cond1.preheader.preheader:                    ; preds = %entry
  %0 = sext i32 %start to i64
  %wide.trip.count = sext i32 %end to i64
  %scevgep = getelementptr [2 x float], [2 x float]* %f, i64 %0, i64 0
  %scevgep45 = getelementptr [2 x float], [2 x float]* %f, i64 %wide.trip.count, i64 0
  %scevgep47 = getelementptr [2 x float], [2 x float]* %buf, i64 %0, i64 0
  %scevgep49 = getelementptr [2 x float], [2 x float]* %buf, i64 %wide.trip.count, i64 0
  %scevgep51 = getelementptr [2 x float], [2 x float]* %x, i64 %0, i64 0
  %scevgep53 = getelementptr [2 x float], [2 x float]* %x, i64 %wide.trip.count, i64 0
  %scevgep55 = getelementptr [2 x float], [2 x float]* %v, i64 %0, i64 0
  %scevgep57 = getelementptr [2 x float], [2 x float]* %v, i64 %wide.trip.count, i64 0
  %bound0 = icmp ult float* %scevgep, %scevgep49
  %bound1 = icmp ult float* %scevgep47, %scevgep45
  %found.conflict = and i1 %bound0, %bound1
  %bound059 = icmp ult float* %scevgep, %scevgep53
  %bound160 = icmp ult float* %scevgep51, %scevgep45
  %found.conflict61 = and i1 %bound059, %bound160
  %conflict.rdx = or i1 %found.conflict, %found.conflict61
  %bound062 = icmp ult float* %scevgep, %scevgep57
  %bound163 = icmp ult float* %scevgep55, %scevgep45
  %found.conflict64 = and i1 %bound062, %bound163
  %conflict.rdx65 = or i1 %conflict.rdx, %found.conflict64
  %bound066 = icmp ult float* %scevgep47, %scevgep53
  %bound167 = icmp ult float* %scevgep51, %scevgep49
  %found.conflict68 = and i1 %bound066, %bound167
  %conflict.rdx69 = or i1 %conflict.rdx65, %found.conflict68
  %bound070 = icmp ult float* %scevgep47, %scevgep57
  %bound171 = icmp ult float* %scevgep55, %scevgep49
  %found.conflict72 = and i1 %bound070, %bound171
  %conflict.rdx73 = or i1 %conflict.rdx69, %found.conflict72
  br i1 %conflict.rdx73, label %for.cond1.preheader.preheader105, label %vector.ph

for.cond1.preheader.preheader105:                 ; preds = %for.cond1.preheader.preheader
  br label %for.cond1.preheader

vector.ph:                                        ; preds = %for.cond1.preheader.preheader
  %1 = sub nsw i64 %wide.trip.count, %0
  %wide.end.idx.splatinsert = insertelement <n x 4 x i64> undef, i64 %1, i32 0
  %wide.end.idx.splat = shufflevector <n x 4 x i64> %wide.end.idx.splatinsert, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %2 = icmp ugt <n x 4 x i64> %wide.end.idx.splat, stepvector
  %predicate.entry = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> shufflevector (<n x 4 x i1> insertelement (<n x 4 x i1> undef, i1 true, i32 0), <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i1> %2)
  %scevgep74 = getelementptr [2 x float], [2 x float]* %x, i64 %0, i64 0
  %scevgep75 = getelementptr [2 x float], [2 x float]* %f, i64 %0, i64 0
  %scevgep79 = getelementptr [2 x float], [2 x float]* %v, i64 %0, i64 0
  %scevgep83 = getelementptr [2 x float], [2 x float]* %buf, i64 %0, i64 0
  %scevgep86 = getelementptr [2 x float], [2 x float]* %x, i64 %0, i64 1
  %scevgep90 = getelementptr [2 x float], [2 x float]* %f, i64 %0, i64 1
  %scevgep94 = getelementptr [2 x float], [2 x float]* %v, i64 %0, i64 1
  %scevgep98 = getelementptr [2 x float], [2 x float]* %buf, i64 %0, i64 1
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %predicate = phi <n x 4 x i1> [ %predicate.entry, %vector.ph ], [ %predicate.next, %vector.body ]
  %3 = icmp ult i64 %index, 4294967295
  call void @llvm.assume(i1 %3)
  %4 = shl nuw i64 %index, 1
  %.splatinsert = insertelement <n x 4 x i64> undef, i64 %4, i32 0
  %.splat = shufflevector <n x 4 x i64> %.splatinsert, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %5 = add <n x 4 x i64> %.splat, mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 2, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
  %6 = getelementptr float, float* %scevgep74, <n x 4 x i64> %5
  %7 = bitcast <n x 4 x float*> %6 to <n x 4 x i32*>
  %wide.masked.gather = call <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*> %7, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1, !alias.scope !5
  %8 = shl nuw i64 %index, 1
  %.splatinsert76 = insertelement <n x 4 x i64> undef, i64 %8, i32 0
  %.splat77 = shufflevector <n x 4 x i64> %.splatinsert76, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %9 = add <n x 4 x i64> %.splat77, mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 2, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
  %10 = getelementptr float, float* %scevgep75, <n x 4 x i64> %9
  %11 = bitcast <n x 4 x float*> %10 to <n x 4 x i32*>
  call void @llvm.masked.scatter.nxv4i32(<n x 4 x i32> %wide.masked.gather, <n x 4 x i32*> %11, i32 4, <n x 4 x i1> %predicate), !tbaa !1, !alias.scope !8, !noalias !10
  %wide.masked.gather78 = call <n x 4 x float> @llvm.masked.gather.nxv4f32(<n x 4 x float*> %6, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef), !tbaa !1, !alias.scope !5
  %12 = shl nuw i64 %index, 1
  %.splatinsert80 = insertelement <n x 4 x i64> undef, i64 %12, i32 0
  %.splat81 = shufflevector <n x 4 x i64> %.splatinsert80, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %13 = add <n x 4 x i64> %.splat81, mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 2, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
  %14 = getelementptr float, float* %scevgep79, <n x 4 x i64> %13
  %wide.masked.gather82 = call <n x 4 x float> @llvm.masked.gather.nxv4f32(<n x 4 x float*> %14, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef), !tbaa !1, !alias.scope !13
  %15 = fadd fast <n x 4 x float> %wide.masked.gather82, %wide.masked.gather78
  %16 = shl nuw i64 %index, 1
  %.splatinsert84 = insertelement <n x 4 x i64> undef, i64 %16, i32 0
  %.splat85 = shufflevector <n x 4 x i64> %.splatinsert84, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %17 = add <n x 4 x i64> %.splat85, mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 2, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
  %18 = getelementptr float, float* %scevgep83, <n x 4 x i64> %17
  call void @llvm.masked.scatter.nxv4f32(<n x 4 x float> %15, <n x 4 x float*> %18, i32 4, <n x 4 x i1> %predicate), !tbaa !1, !alias.scope !14, !noalias !15
  %19 = shl nuw i64 %index, 1
  %.splatinsert87 = insertelement <n x 4 x i64> undef, i64 %19, i32 0
  %.splat88 = shufflevector <n x 4 x i64> %.splatinsert87, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %20 = add <n x 4 x i64> %.splat88, mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 2, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
  %21 = getelementptr float, float* %scevgep86, <n x 4 x i64> %20
  %22 = bitcast <n x 4 x float*> %21 to <n x 4 x i32*>
  %wide.masked.gather89 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*> %22, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1, !alias.scope !5
  %23 = shl nuw i64 %index, 1
  %.splatinsert91 = insertelement <n x 4 x i64> undef, i64 %23, i32 0
  %.splat92 = shufflevector <n x 4 x i64> %.splatinsert91, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %24 = add <n x 4 x i64> %.splat92, mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 2, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
  %25 = getelementptr float, float* %scevgep90, <n x 4 x i64> %24
  %26 = bitcast <n x 4 x float*> %25 to <n x 4 x i32*>
  call void @llvm.masked.scatter.nxv4i32(<n x 4 x i32> %wide.masked.gather89, <n x 4 x i32*> %26, i32 4, <n x 4 x i1> %predicate), !tbaa !1, !alias.scope !8, !noalias !10
  %wide.masked.gather93 = call <n x 4 x float> @llvm.masked.gather.nxv4f32(<n x 4 x float*> %21, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef), !tbaa !1, !alias.scope !5
  %27 = shl nuw i64 %index, 1
  %.splatinsert95 = insertelement <n x 4 x i64> undef, i64 %27, i32 0
  %.splat96 = shufflevector <n x 4 x i64> %.splatinsert95, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %28 = add <n x 4 x i64> %.splat96, mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 2, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
  %29 = getelementptr float, float* %scevgep94, <n x 4 x i64> %28
  %wide.masked.gather97 = call <n x 4 x float> @llvm.masked.gather.nxv4f32(<n x 4 x float*> %29, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef), !tbaa !1, !alias.scope !13
  %30 = fadd fast <n x 4 x float> %wide.masked.gather97, %wide.masked.gather93
  %31 = shl nuw i64 %index, 1
  %.splatinsert99 = insertelement <n x 4 x i64> undef, i64 %31, i32 0
  %.splat100 = shufflevector <n x 4 x i64> %.splatinsert99, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %32 = add <n x 4 x i64> %.splat100, mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 2, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
  %33 = getelementptr float, float* %scevgep98, <n x 4 x i64> %32
  call void @llvm.masked.scatter.nxv4f32(<n x 4 x float> %30, <n x 4 x float*> %33, i32 4, <n x 4 x i1> %predicate), !tbaa !1, !alias.scope !14, !noalias !15
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %34 = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
  %.splatinsert103 = insertelement <n x 4 x i64> undef, i64 %34, i32 0
  %.splat104 = shufflevector <n x 4 x i64> %.splatinsert103, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %35 = add <n x 4 x i64> %.splat104, stepvector
  %36 = icmp ult <n x 4 x i64> %35, %wide.end.idx.splat
  %predicate.next = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %predicate, <n x 4 x i1> %36)
  %37 = extractelement <n x 4 x i1> %predicate.next, i64 0
  br i1 %37, label %vector.body, label %for.end24.loopexit106, !llvm.loop !16

for.cond1.preheader:                              ; preds = %for.cond1.preheader.preheader105, %for.cond1.preheader
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.cond1.preheader ], [ %0, %for.cond1.preheader.preheader105 ]
  %arrayidx5 = getelementptr inbounds [2 x float], [2 x float]* %x, i64 %indvars.iv, i64 0
  %38 = bitcast float* %arrayidx5 to i32*
  %39 = load i32, i32* %38, align 4, !tbaa !1
  %arrayidx9 = getelementptr inbounds [2 x float], [2 x float]* %f, i64 %indvars.iv, i64 0
  %40 = bitcast float* %arrayidx9 to i32*
  store i32 %39, i32* %40, align 4, !tbaa !1
  %41 = load float, float* %arrayidx5, align 4, !tbaa !1
  %arrayidx17 = getelementptr inbounds [2 x float], [2 x float]* %v, i64 %indvars.iv, i64 0
  %42 = load float, float* %arrayidx17, align 4, !tbaa !1
  %add = fadd fast float %42, %41
  %arrayidx21 = getelementptr inbounds [2 x float], [2 x float]* %buf, i64 %indvars.iv, i64 0
  store float %add, float* %arrayidx21, align 4, !tbaa !1
  %arrayidx5.1 = getelementptr inbounds [2 x float], [2 x float]* %x, i64 %indvars.iv, i64 1
  %43 = bitcast float* %arrayidx5.1 to i32*
  %44 = load i32, i32* %43, align 4, !tbaa !1
  %arrayidx9.1 = getelementptr inbounds [2 x float], [2 x float]* %f, i64 %indvars.iv, i64 1
  %45 = bitcast float* %arrayidx9.1 to i32*
  store i32 %44, i32* %45, align 4, !tbaa !1
  %46 = load float, float* %arrayidx5.1, align 4, !tbaa !1
  %arrayidx17.1 = getelementptr inbounds [2 x float], [2 x float]* %v, i64 %indvars.iv, i64 1
  %47 = load float, float* %arrayidx17.1, align 4, !tbaa !1
  %add.1 = fadd fast float %47, %46
  %arrayidx21.1 = getelementptr inbounds [2 x float], [2 x float]* %buf, i64 %indvars.iv, i64 1
  store float %add.1, float* %arrayidx21.1, align 4, !tbaa !1
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %for.end24.loopexit, label %for.cond1.preheader, !llvm.loop !19

for.end24.loopexit:                               ; preds = %for.cond1.preheader
  br label %for.end24

for.end24.loopexit106:                            ; preds = %vector.body
  br label %for.end24

for.end24:                                        ; preds = %for.end24.loopexit106, %for.end24.loopexit, %entry
  ret void
}

; Function Attrs: nounwind readnone
declare <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1>, <n x 4 x i1>) #1

; Function Attrs: nounwind readonly
declare <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*>, i32, <n x 4 x i1>, <n x 4 x i32>) #2

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv4i32(<n x 4 x i32>, <n x 4 x i32*>, i32, <n x 4 x i1>) #3

; Function Attrs: nounwind readonly
declare <n x 4 x float> @llvm.masked.gather.nxv4f32(<n x 4 x float*>, i32, <n x 4 x i1>, <n x 4 x float>) #2

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv4f32(<n x 4 x float>, <n x 4 x float*>, i32, <n x 4 x i1>) #3

; Function Attrs: nounwind
declare void @llvm.assume(i1) #3

attributes #0 = { norecurse nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 5.0.0 (ssh://kircha02@ds-gerrit.euhpc.arm.com:29418/shoji/organic-clang b176d79103a5cc3029d4a3dae0f3f1de1cfa6953) (ssh://kircha02@ds-gerrit.euhpc.arm.com:29418/shoji/organic-llvm 4d46f03c729d3913a8b1a489f0315578cef47f3b)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"float", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6}
!6 = distinct !{!6, !7}
!7 = distinct !{!7, !"LVerDomain"}
!8 = !{!9}
!9 = distinct !{!9, !7}
!10 = !{!11, !6, !12}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = !{!12}
!14 = !{!11}
!15 = !{!6, !12}
!16 = distinct !{!16, !17, !18}
!17 = !{!"llvm.loop.vectorize.width", i32 1}
!18 = !{!"llvm.loop.interleave.count", i32 1}
!19 = distinct !{!19, !17, !18}

; CHECK-LABEL: test_gather:
; CHECK: ld2w

