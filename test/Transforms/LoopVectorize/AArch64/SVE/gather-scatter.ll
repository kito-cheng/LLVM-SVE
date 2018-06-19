; RUN: opt -mtriple aarch64-linux-generic -mattr=+sve -O3 -disable-loop-vectorization -sve-loop-vectorize -force-scalable-vectorization -force-vector-predication -enable-non-consecutive-stride-ind-vars -force-vector-width=4 -disable-loop-unrolling -S < %s | FileCheck %s
; ModuleID = 'original-loop.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnueabi"

;CHECK-LABEL: @func(

;CHECK-LABEL: vector.body
;CHECK: %[[IDX0:.+]] = shufflevector <n x 4 x i64> %{{.+}}, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
;CHECK: %[[SVC0:.+]] = add <n x 4 x i64> %[[IDX0]], mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 5, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
;CHECK: %[[GEP0:.+]] = getelementptr i32, i32* %{{[0-9]+}}, <n x 4 x i64> %[[SVC0]]
;CHECK: call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %[[GEP0]], i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1

;CHECK: %[[IDX1:.+]] = shufflevector <n x 4 x i64> %{{.+}}, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
;CHECK: %[[SVC1:.+]] = add <n x 4 x i64> %[[IDX1]], mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 5, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
;CHECK: %[[GEP1:.+]] = getelementptr i32, i32* %{{[0-9]+}}, <n x 4 x i64> %[[SVC1]]
;CHECK: call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %[[GEP1]], i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1

;CHECK: %[[IDX2:.+]] = shufflevector <n x 4 x i64> %{{.+}}, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
;CHECK: %[[SVC2:.+]] = add <n x 4 x i64> %[[IDX2]], mul (<n x 4 x i64> shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 5, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i64> stepvector)
;CHECK: %[[GEP2:.+]] = getelementptr i32, i32* %{{[0-9]+}}, <n x 4 x i64> %[[SVC2]]
;CHECK: call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %{{.+}}, <n x 4 x i32*> %[[GEP2]], i32 4, <n x 4 x i1> %predicate), !tbaa !1
;CHECK: br i1

; Function Attrs: nounwind
define void @func(i32* noalias nocapture %d, i32* noalias nocapture readonly %a, i32* noalias nocapture readonly %b, i32 %count) #0 {
entry:
  %cmp10 = icmp sgt i32 %count, 0
  br i1 %cmp10, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %0 = sext i32 %count to i64
  %1 = add nsw i64 %0, -1
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %i.011 = phi i64 [ 0, %for.body.lr.ph ], [ %inc, %for.body ]
  %mul = mul nsw i64 %i.011, 5
  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %mul
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %arrayidx3 = getelementptr inbounds i32, i32* %b, i64 %mul
  %3 = load i32, i32* %arrayidx3, align 4, !tbaa !1
  %add = add nsw i32 %3, %2
  %arrayidx5 = getelementptr inbounds i32, i32* %d, i64 %mul
  store i32 %add, i32* %arrayidx5, align 4, !tbaa !1
  %inc = add nuw nsw i64 %i.011, 1
  %exitcond = icmp eq i64 %i.011, %1
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}


;; Multi-offset GEP + gather load check

%struct.nested_i32 = type { %union.anon_i32, %union.anon_i32.0 }
%union.anon_i32 = type { i32 }
%union.anon_i32.0 = type { i32 }

@data_i32 = common global [1024 x %struct.nested_i32] zeroinitializer, align 4

; Function Attrs: nounwind readonly
define i32 @gep_array_of_struct_of_unions_of_int() #1 {
; CHECK-LABEL: gep_array_of_struct_of_unions_of_int
; CHECK-LABEL: vector.body
; CHECK: %index = phi i64 [ 0, %min.iters.checked ], [ %index.next, %vector.body ]
; CHECK: %predicate = phi <n x 4 x i1> [ %predicate.entry, %min.iters.checked ], [ %predicate.next, %vector.body ]
; CHECK: %vec.phi = phi <n x 4 x i32> [ zeroinitializer, %min.iters.checked ], [ %[[ACC:.+]], %vector.body ]
; CHECK: %[[IDX0:.+]] = trunc i64 %index to i32
; CHECK: %[[IDX1:.+]] = mul i32 %[[IDX0]], 2
; CHECK: %[[IDX2:.+]] = insertelement <n x 4 x i32> undef, i32 %[[IDX1:.+]], i32 0
; CHECK: %[[IDX3:.+]] = shufflevector <n x 4 x i32> %[[IDX2:.+]], <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
; CHECK: %[[OFFS:.+]] = add <n x 4 x i32> %[[IDX3]], mul (<n x 4 x i32> shufflevector (<n x 4 x i32> insertelement (<n x 4 x i32> undef, i32 2, i32 0), <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i32> stepvector)
; CHECK: %[[PTR:.+]] = getelementptr i32, i32* getelementptr inbounds ([1024 x %struct.nested_i32], [1024 x %struct.nested_i32]* @data_i32, i32 0, i32 0, i32 0, i32 0), <n x 4 x i32> %[[OFFS]]
; CHECK: %wide.masked.gather = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %[[PTR]], i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1
; CHECK: %[[ADD:.+]] = add nsw <n x 4 x i32> %wide.masked.gather, %vec.phi
; CHECK: %[[SEL:.+]] = select <n x 4 x i1> %predicate, <n x 4 x i32> %[[ADD]], <n x 4 x i32> %vec.phi
; CHECK: %index.next = add nuw nsw i64 %index, mul (i64 vscale, i64 4)
; CHECK: br i1 %{{.+}}, label %vector.body, label %middle.block
entry:
  br label %while.body

while.body:                                       ; preds = %while.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %while.body ]
  %result.04 = phi i32 [ 0, %entry ], [ %add, %while.body ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %a = getelementptr inbounds [1024 x %struct.nested_i32], [1024 x %struct.nested_i32]* @data_i32, i64 0, i64 %indvars.iv, i32 0, i32 0
  %0 = load i32, i32* %a, align 4, !tbaa !1
  %add = add nsw i32 %0, %result.04
  %exitcond = icmp eq i64 %indvars.iv.next, 128
  br i1 %exitcond, label %while.end, label %while.body

while.end:                                        ; preds = %while.body
  %add.lcssa = phi i32 [ %add, %while.body ]

  ret i32 %add.lcssa
}


attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
