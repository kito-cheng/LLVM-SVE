; RUN: opt < %s -instcombine -S | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; Function Attrs: nounwind
define float @FastmathReduction(float* %Values, i32 %Count) #0 {
; CHECK-LABEL: if.end:
; CHECK: %Result.1 = fadd fast float %Result.0, %.pn
entry:
  br label %for.cond

for.cond:                                         ; preds = %if.end, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %if.end ]
  %Result.0 = phi float [ 0.000000e+00, %entry ], [ %Result.1, %if.end ]
  %cmp = icmp slt i32 %i.0, %Count
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  ret float %Result.0

for.body:                                         ; preds = %for.cond
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds float, float* %Values, i64 %idxprom
  %0 = load float, float* %arrayidx, align 4, !tbaa !1
  %cmp1 = fcmp olt float %0, 2.000000e+00
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %add = fadd fast float %Result.0, %0
  br label %if.end

if.else:                                          ; preds = %for.body
  %mul = fmul fast float %0, 2.000000e+00
  %add2 = fadd fast float %Result.0, %mul
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %Result.1 = phi float [ %add, %if.then ], [ %add2, %if.else ]
  %inc = add nsw i32 %i.0, 1
  br label %for.cond
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-pr
otector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"float", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
