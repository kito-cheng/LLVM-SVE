; RUN: opt < %s -sve-loop-vectorize -mtriple=aarch64-none-linux-gnu -mattr=+sve -force-vector-predication -force-scalable-vectorization -S | FileCheck %s

%struct.str = type { i32, float }

; Function Attrs: norecurse nounwind
define void @foo(float* noalias nocapture %a, %struct.str* nocapture readonly %b, i32 %n) #0 {
; CHECK-LABEL: vector.body:
; CHECK-NOT: load float, float* %needscloning
; CHECK-LABEL: for.body:
; CHECK:     load float, float* %needscloning

entry:
  %cmp4 = icmp sgt i32 %n, 0
  br i1 %cmp4, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
      ; if %needscloning is not hoisted out, but is invariant, it needs to be cloned
  %needscloning = getelementptr inbounds %struct.str, %struct.str* %b, i64 0, i32 1
  %x = load float, float* %needscloning, align 4, !tbaa !1
  %add = fadd float %x, 4.200000e+01
  %arrayidx = getelementptr inbounds float, float* %a, i64 %indvars.iv
  store float %add, float* %arrayidx, align 4, !tbaa !7
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

attributes #0 = { norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0"}
!1 = !{!2, !6, i64 4}
!2 = !{!"", !3, i64 0, !6, i64 4}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!"float", !4, i64 0}
!7 = !{!6, !6, i64 0}
