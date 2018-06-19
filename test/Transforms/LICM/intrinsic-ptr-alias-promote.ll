; RUN: opt -basicaa -licm -S < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; This test checks that vector intrinsics don't cause AliasSetTracker to miss
; pointers used in vector loops, which can illegally trigger store promotion
; across the loop.

%struct.anon = type { [7 x i32], i32, double, double }

@num_q_paths = common global i32 0, align 4
@q_paths = common global [688 x %struct.anon] zeroinitializer, align 8
@num_basic_paths = common global i32 0, align 4
@path_num = common global [6 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define i32 @test_promote_alias(i32* nocapture readonly %basic_vec, i32 %length, double %coeff) #0 {
entry:
  %pp = alloca [8 x i32], align 4
  %vec = alloca [7 x i32], align 4
  %0 = bitcast [8 x i32]* %pp to i8*
  call void @llvm.lifetime.start.p0i8(i64 32, i8* %0) #2
  %1 = bitcast [7 x i32]* %vec to i8*
  call void @llvm.lifetime.start.p0i8(i64 28, i8* %1) #2
  %2 = load i32, i32* @num_q_paths, align 4, !tbaa !1
  %cmp20.54 = icmp sgt i32 %2, 0
  %arraydecay = getelementptr inbounds [7 x i32], [7 x i32]* %vec, i64 0, i64 0
  %arrayidx.1.i = getelementptr inbounds [7 x i32], [7 x i32]* %vec, i64 0, i64 1
  %arrayidx.2.i = getelementptr inbounds [7 x i32], [7 x i32]* %vec, i64 0, i64 2
  %arrayidx.3.i = getelementptr inbounds [7 x i32], [7 x i32]* %vec, i64 0, i64 3
  %arrayidx.4.i = getelementptr inbounds [7 x i32], [7 x i32]* %vec, i64 0, i64 4
  %arrayidx.5.i = getelementptr inbounds [7 x i32], [7 x i32]* %vec, i64 0, i64 5
  %arrayidx.6.i = getelementptr inbounds [7 x i32], [7 x i32]* %vec, i64 0, i64 6
  br i1 %cmp20.54, label %for.cond.1.preheader.us.preheader, label %min.iters.checked

min.iters.checked:                                ; preds = %entry
  %predicate.entry = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), <n x 2 x i1> icmp ult (<n x 2 x i64> stepvector, <n x 2 x i64> shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 42, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)))
  %3 = getelementptr inbounds [8 x i32], [8 x i32]* %pp, i64 0, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %min.iters.checked
  %index = phi i64 [ 0, %min.iters.checked ], [ %index.next, %vector.body ]
  %predicate = phi <n x 2 x i1> [ %predicate.entry, %min.iters.checked ], [ %predicate.next, %vector.body ]
  %4 = icmp ult i64 %index, 42
  call void @llvm.assume(i1 %4)
  %5 = getelementptr inbounds i32, i32* %basic_vec, i64 %index
  %6 = bitcast i32* %5 to <n x 2 x i32>*
  %wide.masked.load = call <n x 2 x i32> @llvm.masked.load.nxv2i32.p0nxv2i32(<n x 2 x i32>* %6, i32 4, <n x 2 x i1> %predicate, <n x 2 x i32> undef), !tbaa !1
  %7 = sext <n x 2 x i32> %wide.masked.load to <n x 2 x i64>
  %8 = getelementptr i32, i32* %3, <n x 2 x i64> %7
  %9 = call <n x 2 x i32> @llvm.masked.gather.nxv2i32.nxv2p0i32(<n x 2 x i32*> %8, i32 4, <n x 2 x i1> %predicate, <n x 2 x i32> undef), !tbaa !1
  %10 = getelementptr inbounds [7 x i32], [7 x i32]* %vec, i64 0, i64 %index
  %11 = bitcast i32* %10 to <n x 2 x i32>*
  call void @llvm.masked.store.nxv2i32.p0nxv2i32(<n x 2 x i32> %9, <n x 2 x i32>* %11, i32 4, <n x 2 x i1> %predicate), !tbaa !1
  %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 2)
  %12 = add nuw nsw i64 %index, mul (i64 vscale, i64 2)
  %13 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %14 = shufflevector <n x 2 x i64> %13, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %15 = mul <n x 2 x i64> %14, stepvector
  %16 = insertelement <n x 2 x i64> undef, i64 %12, i32 0
  %17 = shufflevector <n x 2 x i64> %16, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %18 = add <n x 2 x i64> %17, %15
  %19 = icmp ult <n x 2 x i64> %18, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 42, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  %predicate.next = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %predicate, <n x 2 x i1> %19)
  %20 = extractelement <n x 2 x i1> %predicate.next, i64 0
  br i1 %20, label %vector.body, label %if.then.loopexit92, !llvm.loop !5

for.cond.1.preheader.us.preheader:                ; preds = %entry
  %21 = sext i32 %2 to i64
  %arrayidx.us.1 = getelementptr inbounds [8 x i32], [8 x i32]* %pp, i64 0, i64 1
  %arrayidx.us.2 = getelementptr inbounds [8 x i32], [8 x i32]* %pp, i64 0, i64 2
  %arrayidx.us.3 = getelementptr inbounds [8 x i32], [8 x i32]* %pp, i64 0, i64 3
  %22 = getelementptr inbounds [8 x i32], [8 x i32]* %pp, i64 0, i64 0
  br label %for.cond.1.preheader.us

for.cond.1.preheader.us:                          ; preds = %for.cond.us, %for.cond.1.preheader.us.preheader
; CHECK-LABEL: for.cond.1.preheader.us
; CHECK: store i32 %add.us.1, i32* %arrayidx.us.1
  %23 = phi i32 [ %add.us.3, %for.cond.us ], [ undef, %for.cond.1.preheader.us.preheader ]
  %24 = phi i32 [ %add.us.2, %for.cond.us ], [ undef, %for.cond.1.preheader.us.preheader ]
  %25 = phi i32 [ %add.us.1, %for.cond.us ], [ undef, %for.cond.1.preheader.us.preheader ]
  %x.056.us = phi i32 [ %inc30.us, %for.cond.us ], [ 0, %for.cond.1.preheader.us.preheader ]
  %add.us.1 = add nsw i32 %25, 1
  store i32 %add.us.1, i32* %arrayidx.us.1, align 4, !tbaa !1
  %add.us.2 = add nsw i32 %24, 2
  store i32 %add.us.2, i32* %arrayidx.us.2, align 4, !tbaa !1
  %add.us.3 = add nsw i32 %23, 3
  store i32 %add.us.3, i32* %arrayidx.us.3, align 4, !tbaa !1
  %predicate.entry81 = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), <n x 2 x i1> icmp ult (<n x 2 x i64> stepvector, <n x 2 x i64> shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 42, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)))
  br label %vector.body75

vector.body75:                                    ; preds = %vector.body75, %for.cond.1.preheader.us
  %index82 = phi i64 [ 0, %for.cond.1.preheader.us ], [ %index.next90, %vector.body75 ]
  %predicate83 = phi <n x 2 x i1> [ %predicate.entry81, %for.cond.1.preheader.us ], [ %predicate.next91, %vector.body75 ]
  %26 = icmp ult i64 %index82, 42
  call void @llvm.assume(i1 %26)
  %27 = getelementptr inbounds i32, i32* %basic_vec, i64 %index82
  %28 = bitcast i32* %27 to <n x 2 x i32>*
  %wide.masked.load.87 = call <n x 2 x i32> @llvm.masked.load.nxv2i32.p0nxv2i32(<n x 2 x i32>* %28, i32 4, <n x 2 x i1> %predicate83, <n x 2 x i32> undef), !tbaa !1
  %29 = sext <n x 2 x i32> %wide.masked.load.87 to <n x 2 x i64>
  %30 = getelementptr i32, i32* %22, <n x 2 x i64> %29
  %31 = call <n x 2 x i32> @llvm.masked.gather.nxv2i32.nxv2p0i32(<n x 2 x i32*> %30, i32 4, <n x 2 x i1> %predicate83, <n x 2 x i32> undef), !tbaa !1
  %32 = getelementptr inbounds [7 x i32], [7 x i32]* %vec, i64 0, i64 %index82
  %33 = bitcast i32* %32 to <n x 2 x i32>*
  call void @llvm.masked.store.nxv2i32.p0nxv2i32(<n x 2 x i32> %31, <n x 2 x i32>* %33, i32 4, <n x 2 x i1> %predicate83), !tbaa !1
  %index.next90 = add nuw nsw i64 %index82, mul (i64 vscale, i64 2)
  %34 = add nuw nsw i64 %index82, mul (i64 vscale, i64 2)
  %35 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %36 = shufflevector <n x 2 x i64> %35, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %37 = mul <n x 2 x i64> %36, stepvector
  %38 = insertelement <n x 2 x i64> undef, i64 %34, i32 0
  %39 = shufflevector <n x 2 x i64> %38, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %40 = add <n x 2 x i64> %39, %37
  %41 = icmp ult <n x 2 x i64> %40, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 42, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  %predicate.next91 = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %predicate83, <n x 2 x i1> %41)
  %42 = extractelement <n x 2 x i1> %predicate.next91, i64 0
  br i1 %42, label %vector.body75, label %for.body.21.lr.ph.us, !llvm.loop !8

for.body.21.us:                                   ; preds = %for.body.21.lr.ph.us, %is_path_equal.exit.us
  %indvars.iv62 = phi i64 [ 0, %for.body.21.lr.ph.us ], [ %indvars.iv.next63, %is_path_equal.exit.us ]
  %arraydecay24.us = getelementptr inbounds [688 x %struct.anon], [688 x %struct.anon]* @q_paths, i64 0, i64 %indvars.iv62, i32 0, i64 0
  %43 = load i32, i32* %arraydecay24.us, align 8, !tbaa !1
  %cmp3.i.us = icmp eq i32 %50, %43
  br i1 %cmp3.i.us, label %for.cond.i.us, label %is_path_equal.exit.us

for.cond.i.us:                                    ; preds = %for.body.21.us
  %arrayidx2.1.i.us = getelementptr inbounds [688 x %struct.anon], [688 x %struct.anon]* @q_paths, i64 0, i64 %indvars.iv62, i32 0, i64 1
  %44 = load i32, i32* %arrayidx2.1.i.us, align 4, !tbaa !1
  %cmp3.1.i.us = icmp eq i32 %51, %44
  br i1 %cmp3.1.i.us, label %for.cond.1.i.us, label %is_path_equal.exit.us

for.cond.1.i.us:                                  ; preds = %for.cond.i.us
  %arrayidx2.2.i.us = getelementptr inbounds [688 x %struct.anon], [688 x %struct.anon]* @q_paths, i64 0, i64 %indvars.iv62, i32 0, i64 2
  %45 = load i32, i32* %arrayidx2.2.i.us, align 8, !tbaa !1
  %cmp3.2.i.us = icmp eq i32 %52, %45
  br i1 %cmp3.2.i.us, label %for.cond.2.i.us, label %is_path_equal.exit.us

for.cond.2.i.us:                                  ; preds = %for.cond.1.i.us
  %arrayidx2.3.i.us = getelementptr inbounds [688 x %struct.anon], [688 x %struct.anon]* @q_paths, i64 0, i64 %indvars.iv62, i32 0, i64 3
  %46 = load i32, i32* %arrayidx2.3.i.us, align 4, !tbaa !1
  %cmp3.3.i.us = icmp eq i32 %53, %46
  br i1 %cmp3.3.i.us, label %for.cond.3.i.us, label %is_path_equal.exit.us

for.cond.3.i.us:                                  ; preds = %for.cond.2.i.us
  %arrayidx2.4.i.us = getelementptr inbounds [688 x %struct.anon], [688 x %struct.anon]* @q_paths, i64 0, i64 %indvars.iv62, i32 0, i64 4
  %47 = load i32, i32* %arrayidx2.4.i.us, align 8, !tbaa !1
  %cmp3.4.i.us = icmp eq i32 %54, %47
  br i1 %cmp3.4.i.us, label %for.cond.4.i.us, label %is_path_equal.exit.us

for.cond.4.i.us:                                  ; preds = %for.cond.3.i.us
  %arrayidx2.5.i.us = getelementptr inbounds [688 x %struct.anon], [688 x %struct.anon]* @q_paths, i64 0, i64 %indvars.iv62, i32 0, i64 5
  %48 = load i32, i32* %arrayidx2.5.i.us, align 4, !tbaa !1
  %cmp3.5.i.us = icmp eq i32 %55, %48
  br i1 %cmp3.5.i.us, label %for.cond.5.i.us, label %is_path_equal.exit.us

for.cond.5.i.us:                                  ; preds = %for.cond.4.i.us
  %arrayidx2.6.i.us = getelementptr inbounds [688 x %struct.anon], [688 x %struct.anon]* @q_paths, i64 0, i64 %indvars.iv62, i32 0, i64 6
  %49 = load i32, i32* %arrayidx2.6.i.us, align 8, !tbaa !1
  %cmp3.6.i.us = icmp eq i32 %56, %49
  %..i.us = zext i1 %cmp3.6.i.us to i32
  br label %is_path_equal.exit.us

is_path_equal.exit.us:                            ; preds = %for.cond.5.i.us, %for.cond.4.i.us, %for.cond.3.i.us, %for.cond.2.i.us, %for.cond.1.i.us, %for.cond.i.us, %for.body.21.us
  %call51.us = phi i32 [ %..i.us, %for.cond.5.i.us ], [ 0, %for.cond.4.i.us ], [ 0, %for.cond.3.i.us ], [ 0, %for.cond.2.i.us ], [ 0, %for.cond.1.i.us ], [ 0, %for.cond.i.us ], [ 0, %for.body.21.us ]
  %indvars.iv.next63 = add nuw nsw i64 %indvars.iv62, 1
  %cmp20.us = icmp slt i64 %indvars.iv.next63, %21
  br i1 %cmp20.us, label %for.body.21.us, label %for.cond.19.for.end.27_crit_edge.us

for.cond.us:                                      ; preds = %for.cond.19.for.end.27_crit_edge.us
  %cmp.us = icmp slt i32 %inc30.us, 64
  br i1 %cmp.us, label %for.cond.1.preheader.us, label %for.cond.cleanup

for.body.21.lr.ph.us:                             ; preds = %vector.body75
  %50 = load i32, i32* %arraydecay, align 4, !tbaa !1
  %51 = load i32, i32* %arrayidx.1.i, align 4, !tbaa !1
  %52 = load i32, i32* %arrayidx.2.i, align 4, !tbaa !1
  %53 = load i32, i32* %arrayidx.3.i, align 4, !tbaa !1
  %54 = load i32, i32* %arrayidx.4.i, align 4, !tbaa !1
  %55 = load i32, i32* %arrayidx.5.i, align 4, !tbaa !1
  %56 = load i32, i32* %arrayidx.6.i, align 4, !tbaa !1
  br label %for.body.21.us

for.cond.19.for.end.27_crit_edge.us:              ; preds = %is_path_equal.exit.us
  %call51.us.lcssa = phi i32 [ %call51.us, %is_path_equal.exit.us ]
  %cmp28.us = icmp eq i32 %call51.us.lcssa, 0
  %inc30.us = add nuw nsw i32 %x.056.us, 1
  br i1 %cmp28.us, label %if.then.loopexit, label %for.cond.us

for.cond.cleanup:                                 ; preds = %for.cond.us
; CHECK-LABEL: for.cond.cleanup:
; CHECK-NOT: store i32 %add.us.1.lcssa1, i32* %arrayidx.us.1
  %57 = load i32, i32* @num_basic_paths, align 4, !tbaa !1
  %inc32 = add nsw i32 %57, 1
  store i32 %inc32, i32* @num_basic_paths, align 4, !tbaa !1
  call void @llvm.lifetime.end.p0i8(i64 28, i8* %1) #2
  call void @llvm.lifetime.end.p0i8(i64 32, i8* %0) #2
  ret i32 0

if.then.loopexit:                                 ; preds = %for.cond.19.for.end.27_crit_edge.us
; CHECK-LABEL: if.then.loopexit
; CHECK-NOT: store i32 %add.us.1.lcssa1, i32* %arrayidx.us.1
  br label %if.then

if.then.loopexit92:                               ; preds = %vector.body
  br label %if.then

if.then:                                          ; preds = %if.then.loopexit92, %if.then.loopexit
  tail call void @exit(i32 0) #7
  unreachable
}

; Function Attrs: noreturn nounwind
declare void @exit(i32) #1

; Function Attrs: nounwind
declare void @llvm.assume(i1) #2

; Function Attrs: nounwind readnone
declare <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1>, <n x 2 x i1>) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #4

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #4

; Function Attrs: argmemonly nounwind readonly
declare <n x 2 x i32> @llvm.masked.load.nxv2i32.p0nxv2i32(<n x 2 x i32>*, i32, <n x 2 x i1>, <n x 2 x i32>) #5

; Function Attrs: nounwind readonly
declare <n x 2 x i32> @llvm.masked.gather.nxv2i32.nxv2p0i32(<n x 2 x i32*>, i32, <n x 2 x i1>, <n x 2 x i32>) #6

; Function Attrs: argmemonly nounwind
declare void @llvm.masked.store.nxv2i32.p0nxv2i32(<n x 2 x i32>, <n x 2 x i32>*, i32, <n x 2 x i1>) #4

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind readnone }
attributes #4 = { argmemonly nounwind }
attributes #5 = { argmemonly nounwind readonly }
attributes #6 = { nounwind readonly }
attributes #7 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.vectorize.width", i32 1}
!7 = !{!"llvm.loop.interleave.count", i32 1}
!8 = distinct !{!8, !6, !7}
