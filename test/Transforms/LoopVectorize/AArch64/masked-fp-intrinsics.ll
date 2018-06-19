; RUN: opt -mtriple aarch64-linux-generic -mattr=+sve -O3 -use-sve-vectorizer -force-scalable-vectorization -force-vector-predication -force-vector-width=4 -S < %s | FileCheck %s
; ModuleID = 'tests.c'
source_filename = "tests.c"
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; Function Attrs: nounwind
define void @gen_pow(float* noalias %a, float* noalias %b) #0 {
; CHECK-LABEL: gen_pow
; CHECK: call fast <n x 4 x float> @llvm.masked.pow.nxv4f32
entry:
  %a.addr = alloca float*, align 8
  %b.addr = alloca float*, align 8
  %i = alloca i32, align 4
  store float* %a, float** %a.addr, align 8
  store float* %b, float** %b.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 256
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4
  %idxprom = sext i32 %1 to i64
  %2 = load float*, float** %b.addr, align 8
  %arrayidx = getelementptr inbounds float, float* %2, i64 %idxprom
  %3 = load float, float* %arrayidx, align 4
  %4 = call fast float @llvm.pow.f32(float %3, float 0x40091EB860000000)
  %5 = load i32, i32* %i, align 4
  %idxprom1 = sext i32 %5 to i64
  %6 = load float*, float** %a.addr, align 8
  %arrayidx2 = getelementptr inbounds float, float* %6, i64 %idxprom1
  store float %4, float* %arrayidx2, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %7 = load i32, i32* %i, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond, !llvm.loop !1

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind readnone
declare float @llvm.pow.f32(float, float) #1

; Function Attrs: nounwind
define void @gen_sin(float* noalias %a, float* noalias %b) #0 {
; CHECK-LABEL: gen_sin
; CHECK: call fast <n x 4 x float> @llvm.masked.sin.nxv4f32
entry:
  %a.addr = alloca float*, align 8
  %b.addr = alloca float*, align 8
  %i = alloca i32, align 4
  store float* %a, float** %a.addr, align 8
  store float* %b, float** %b.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 256
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4
  %idxprom = sext i32 %1 to i64
  %2 = load float*, float** %b.addr, align 8
  %arrayidx = getelementptr inbounds float, float* %2, i64 %idxprom
  %3 = load float, float* %arrayidx, align 4
  %call = call fast float @sinf(float %3) #1
  %4 = load i32, i32* %i, align 4
  %idxprom1 = sext i32 %4 to i64
  %5 = load float*, float** %a.addr, align 8
  %arrayidx2 = getelementptr inbounds float, float* %5, i64 %idxprom1
  store float %call, float* %arrayidx2, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32, i32* %i, align 4
  %inc = add nsw i32 %6, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond, !llvm.loop !3

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nounwind readnone
declare float @sinf(float) #2

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0"}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.vectorize.enable", i1 true}
!3 = distinct !{!3, !2}
