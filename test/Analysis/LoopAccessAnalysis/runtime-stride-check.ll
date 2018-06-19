; RUN: opt -loop-accesses -analyze < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; This test checks that LoopAccessAnalysis correctly detects strided pointer acccesses
; and generates the correctly grouped runtime checks for a pair of strided accesses to
; the same underlying object.

%struct.dcomplex = type { double, double }

; Function Attrs: nounwind
define void @runtime_stride_check(i32 %i, i32 %lj, i32 %lk, i32 %ny, i32 %ny1, i32 %n1, i32 %ku, %struct.dcomplex* nocapture readonly %u, [18 x %struct.dcomplex]* noalias nocapture readonly %x, [18 x %struct.dcomplex]* noalias nocapture %y) #0 {
entry:
; CHECK:    Check 0:
; CHECK-NEXT:      Comparing group
; CHECK-NEXT:        %imag74.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %y, i64 %13, i64 %indvars.iv, i32 1
; CHECK-NEXT:        %real61.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %y, i64 %13, i64 %indvars.iv, i32 0
; CHECK-NEXT:      Against group
; CHECK-NEXT:        %imag49.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %y, i64 %12, i64 %indvars.iv, i32 1
; CHECK-NEXT:        %real42.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %y, i64 %12, i64 %indvars.iv, i32 0
  %mul = mul nsw i32 %lk, %i
  %mul1 = mul nsw i32 %lj, %i
  %add3 = add nsw i32 %ku, %i
  %idxprom = sext i32 %add3 to i64
  %real = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %u, i64 %idxprom, i32 0
  %0 = load double, double* %real, align 8, !tbaa !1
  %imag = getelementptr inbounds %struct.dcomplex, %struct.dcomplex* %u, i64 %idxprom, i32 1
  %1 = load double, double* %imag, align 8, !tbaa !6
  %cmp.141 = icmp sgt i32 %lk, 0
  %cmp10.139 = icmp sgt i32 %ny, 0
  %or.cond = and i1 %cmp.141, %cmp10.139
  br i1 %or.cond, label %for.cond.9.preheader.lr.ph.split.us, label %for.end.77

for.cond.9.preheader.lr.ph.split.us:              ; preds = %entry
  %add2 = add nsw i32 %mul1, %lk
  %add = add nsw i32 %mul, %n1
  %2 = sext i32 %mul to i64
  %3 = sext i32 %add to i64
  %4 = sext i32 %mul1 to i64
  %5 = sext i32 %add2 to i64
  br label %for.body.11.lr.ph.us

for.inc.75.us:                                    ; preds = %for.body.11.us
  %indvars.iv.next144 = add nuw nsw i64 %indvars.iv143, 1
  %lftr.wideiv149 = trunc i64 %indvars.iv.next144 to i32
  %exitcond150 = icmp eq i32 %lftr.wideiv149, %lk
  br i1 %exitcond150, label %for.end.77.loopexit, label %for.body.11.lr.ph.us

for.body.11.us:                                   ; preds = %for.body.11.us, %for.body.11.lr.ph.us
  %indvars.iv = phi i64 [ 0, %for.body.11.lr.ph.us ], [ %indvars.iv.next, %for.body.11.us ]
  %real17.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %x, i64 %10, i64 %indvars.iv, i32 0
  %6 = load double, double* %real17.us, align 8, !tbaa !1
  %imag23.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %x, i64 %10, i64 %indvars.iv, i32 1
  %7 = load double, double* %imag23.us, align 8, !tbaa !6
  %real29.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %x, i64 %11, i64 %indvars.iv, i32 0
  %8 = load double, double* %real29.us, align 8, !tbaa !1
  %imag35.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %x, i64 %11, i64 %indvars.iv, i32 1
  %9 = load double, double* %imag35.us, align 8, !tbaa !6
  %add36.us = fadd double %6, %8
  %real42.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %y, i64 %12, i64 %indvars.iv, i32 0
  store double %add36.us, double* %real42.us, align 8, !tbaa !1
  %add43.us = fadd double %7, %9
  %imag49.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %y, i64 %12, i64 %indvars.iv, i32 1
  store double %add43.us, double* %imag49.us, align 8, !tbaa !6
  %sub.us = fsub double %6, %8
  %mul51.us = fmul double %0, %sub.us
  %sub53.us = fsub double %7, %9
  %mul54.us = fmul double %1, %sub53.us
  %sub55.us = fsub double %mul51.us, %mul54.us
  %real61.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %y, i64 %13, i64 %indvars.iv, i32 0
  store double %sub55.us, double* %real61.us, align 8, !tbaa !1
  %mul64.us = fmul double %0, %sub53.us
  %mul67.us = fmul double %1, %sub.us
  %add68.us = fadd double %mul67.us, %mul64.us
  %imag74.us = getelementptr inbounds [18 x %struct.dcomplex], [18 x %struct.dcomplex]* %y, i64 %13, i64 %indvars.iv, i32 1
  store double %add68.us, double* %imag74.us, align 8, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %ny
  br i1 %exitcond, label %for.inc.75.us, label %for.body.11.us

for.body.11.lr.ph.us:                             ; preds = %for.cond.9.preheader.lr.ph.split.us, %for.inc.75.us
  %indvars.iv143 = phi i64 [ %indvars.iv.next144, %for.inc.75.us ], [ 0, %for.cond.9.preheader.lr.ph.split.us ]
  %10 = add nsw i64 %indvars.iv143, %2
  %11 = add nsw i64 %3, %indvars.iv143
  %12 = add nsw i64 %indvars.iv143, %4
  %13 = add nsw i64 %5, %indvars.iv143
  br label %for.body.11.us

for.end.77.loopexit:                              ; preds = %for.inc.75.us
  br label %for.end.77

for.end.77:                                       ; preds = %for.end.77.loopexit, %entry
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly argmemonly }
attributes #2 = { nounwind argmemonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = !{!2, !3, i64 0}
!2 = !{!"", !3, i64 0, !3, i64 8}
!3 = !{!"double", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!2, !3, i64 8}
