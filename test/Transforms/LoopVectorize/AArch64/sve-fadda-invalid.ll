; RUN: opt -S < %s -basicaa -sve-loop-vectorize -force-scalable-vectorization -force-vector-predication -force-vector-interleave=2 2>&1 | FileCheck %s

;clang -O3 -emit-llvm -S -target aarch64-generic-linux -march=armv8-a+sve -c reduce.c -o - -fno-vectorize
; double reduce_chain(double *a, double *b, int len, double startvalue) {
;   double sum = startvalue;
;   for (int i = 0; i < len; ++i) {
;     sum += a[i];
;     sum += b[i];
;   }
;   return sum;
; }

; Function Attrs: norecurse nounwind readonly
define double @reduce_chain(double* nocapture readonly %a, double* nocapture readonly %b, i32 %len, double %startvalue) #0 {
; CHECK-LABEL: @reduce_chain
; CHECK-NOT: vector.body
; CHECK-NOT: @llvm.aarch64.sve.fadda.f64.nxv2i1.nxv2f64
entry:
  %cmp.11 = icmp sgt i32 %len, 0
  br i1 %cmp.11, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  %add3.lcssa = phi double [ %add3, %for.body ]
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %sum.0.lcssa = phi double [ %startvalue, %entry ], [ %add3.lcssa, %for.cond.cleanup.loopexit ]
  ret double %sum.0.lcssa

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %sum.012 = phi double [ %add3, %for.body ], [ %startvalue, %for.body.preheader ]
  %arrayidx = getelementptr inbounds double, double* %a, i64 %indvars.iv
  %0 = load double, double* %arrayidx, align 8, !tbaa !1
  %add = fadd double %sum.012, %0
  %arrayidx2 = getelementptr inbounds double, double* %b, i64 %indvars.iv
  %1 = load double, double* %arrayidx2, align 8, !tbaa !1
  %add3 = fadd double %add, %1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %len
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}

attributes #0 = { norecurse nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"double", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
