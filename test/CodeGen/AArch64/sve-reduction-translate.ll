; RUN: llc -O1 -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64"

; Function Attrs: norecurse nounwind readonly
define i32 @sadd_i32(<n x 4 x i32> %vec) {
; CHECK-LABEL: sadd_i32
; CHECK: uaddv   d0, p0, z0.s
  %rdx = call i32 @llvm.experimental.vector.reduce.add.i32.nxv4i32(<n x 4 x i32> %vec)
  ret i32 %rdx
}

; Function Attrs: norecurse nounwind readonly
define i16 @umin_i16(<n x 8 x i16> %vec) {
; CHECK-LABEL: umin_i16
; CHECK: ptrue [[PTRUE:p[0-9]+]].h
; CHECK: uminv   h0, [[PTRUE]], z0.h
  %rdx = call i16 @llvm.experimental.vector.reduce.umin.i16.nxv8i16(<n x 8 x i16> %vec)
  ret i16 %rdx
}

; Function Attrs: norecurse nounwind readonly
define i64 @smin_i64(<n x 2 x i64> %vec) {
; CHECK-LABEL: smin_i64
; CHECK: ptrue [[PTRUE:p[0-9]+]].d
; CHECK: sminv   d0, [[PTRUE]], z0.d
  %rdx = call i64 @llvm.experimental.vector.reduce.smin.i64.nxv2i64(<n x 2 x i64> %vec)
  ret i64 %rdx
}

; Function Attrs: norecurse nounwind readonly
define i16 @umax_i16(<n x 8 x i16> %vec) {
; CHECK-LABEL: umax_i16
; CHECK: ptrue [[PTRUE:p[0-9]+]].h
; CHECK: umaxv   h0, [[PTRUE]], z0.h
  %rdx = call i16 @llvm.experimental.vector.reduce.umax.i16.nxv8i16(<n x 8 x i16> %vec)
  ret i16 %rdx
}

; Function Attrs: norecurse nounwind readonly
define i64 @smax_i64(<n x 2 x i64> %vec) {
; CHECK-LABEL: smax_i64
; CHECK: ptrue [[PTRUE:p[0-9]+]].d
; CHECK: smaxv   d0, [[PTRUE]], z0.d
  %rdx = call i64 @llvm.experimental.vector.reduce.smax.i64.nxv2i64(<n x 2 x i64> %vec)
  ret i64 %rdx
}

; Function Attrs: norecurse nounwind readonly
define i16 @and_i16(<n x 8 x i16> %vec) {
; CHECK-LABEL: and_i16
; CHECK: ptrue [[PTRUE:p[0-9]+]].h
; CHECK: andv   h0, [[PTRUE]], z0.h
  %rdx = call i16 @llvm.experimental.vector.reduce.and.i16.nxv8i16(<n x 8 x i16> %vec)
  ret i16 %rdx
}

; Function Attrs: norecurse nounwind readonly
define i32 @or_i32(<n x 4 x i32> %vec) {
; CHECK-LABEL: or_i32
; CHECK: ptrue [[PTRUE:p[0-9]+]].s
; CHECK: orv   s0, [[PTRUE]], z0.s
  %rdx = call i32 @llvm.experimental.vector.reduce.or.i32.nxv4i32(<n x 4 x i32> %vec)
  ret i32 %rdx
}

; Function Attrs: norecurse nounwind readonly
define i64 @xor_i64(<n x 2 x i64> %vec) {
; CHECK-LABEL: xor_i64
; CHECK: ptrue [[PTRUE:p[0-9]+]].d
; CHECK: eorv   d0, [[PTRUE]], z0.d
  %rdx = call i64 @llvm.experimental.vector.reduce.xor.i64.nxv2i64(<n x 2 x i64> %vec)
  ret i64 %rdx
}

; Function Attrs: norecurse nounwind readonly
define float @f32_add(<n x 4 x float> %vec) #0 {
; CHECK-LABEL: f32_add
; CHECK: ptrue [[PTRUE:p[0-9]+]].s
; CHECK: faddv   s0, [[PTRUE]], z0.s
  %rdx = call fast float @llvm.experimental.vector.reduce.fadd.f32.f32.nxv4f32(float undef, <n x 4 x float> %vec)
  ret float %rdx
}

; Function Attrs: norecurse nounwind readonly
define float @f32_min_nnan(<n x 4 x float> %vec) #0 {
; CHECK-LABEL: f32_min_nnan
; CHECK: ptrue [[PTRUE:p[0-9]+]].s
; CHECK: fminnmv   s0, [[PTRUE]], z0.s
  %rdx = call nnan float @llvm.experimental.vector.reduce.fmin.f32.nxv4f32(<n x 4 x float> %vec)
  ret float %rdx
}

; Function Attrs: norecurse nounwind readonly
define double @f64_max_nnan(<n x 2 x double> %vec) #0 {
; CHECK-LABEL: f64_max_nnan
; CHECK: ptrue [[PTRUE:p[0-9]+]].d
; CHECK: fmaxnmv   d0, [[PTRUE]], z0.d
  %rdx = call nnan double @llvm.experimental.vector.reduce.fmax.f64.nxv2f64(<n x 2 x double> %vec)
  ret double %rdx
}

; Function Attrs: norecurse nounwind readonly
define float @f32_min(<n x 4 x float> %vec) #0 {
; CHECK-LABEL: f32_min
; CHECK: ptrue [[PTRUE:p[0-9]+]].s
; CHECK: fminv   s0, [[PTRUE]], z0.s
  %rdx = call float @llvm.experimental.vector.reduce.fmin.f32.nxv4f32(<n x 4 x float> %vec)
  ret float %rdx
}

; Function Attrs: norecurse nounwind readonly
define double @f64_max(<n x 2 x double> %vec) #0 {
; CHECK-LABEL: f64_max
; CHECK: ptrue [[PTRUE:p[0-9]+]].d
; CHECK: fmaxv   d0, [[PTRUE]], z0.d
  %rdx = call double @llvm.experimental.vector.reduce.fmax.f64.nxv2f64(<n x 2 x double> %vec)
  ret double %rdx
}

define float @f32_add_masked(float %scalar, <n x 4 x float> %vec, <n x 4 x i1> %mask) #0 {
; CHECK-LABEL: f32_add_masked
; CHECK-NOT: ptrue
; CHECK: fadda   s0, p0, s0, z1.s
  %masked_vec = select <n x 4 x i1> %mask, <n x 4 x float> %vec, <n x 4 x float> zeroinitializer
  %rdx = call float @llvm.experimental.vector.reduce.fadd.f32.f32.nxv4f32(float %scalar, <n x 4 x float> %masked_vec)
  ret float %rdx
}

; Function Attrs: nounwind readnone
declare i32 @llvm.experimental.vector.reduce.add.i32.nxv4i32(<n x 4 x i32>) #1
; Function Attrs: nounwind readnone
declare i16 @llvm.experimental.vector.reduce.umin.i16.nxv8i16(<n x 8 x i16>) #1
; Function Attrs: nounwind readnone
declare i64 @llvm.experimental.vector.reduce.smin.i64.nxv2i64(<n x 2 x i64>) #1
; Function Attrs: nounwind readnone
declare i16 @llvm.experimental.vector.reduce.umax.i16.nxv8i16(<n x 8 x i16>) #1
; Function Attrs: nounwind readnone
declare i64 @llvm.experimental.vector.reduce.smax.i64.nxv2i64(<n x 2 x i64>) #1
; Function Attrs: nounwind readnone
declare i16 @llvm.experimental.vector.reduce.and.i16.nxv8i16(<n x 8 x i16>) #1
; Function Attrs: nounwind readnone
declare i32 @llvm.experimental.vector.reduce.or.i32.nxv4i32(<n x 4 x i32>) #1
; Function Attrs: nounwind readnone
declare i64 @llvm.experimental.vector.reduce.xor.i64.nxv2i64(<n x 2 x i64>) #1
; Function Attrs: nounwind readnone
declare float @llvm.experimental.vector.reduce.fadd.f32.f32.nxv4f32(float, <n x 4 x float>) #1
; Function Attrs: nounwind readnone
declare float @llvm.experimental.vector.reduce.fmin.f32.nxv4f32(<n x 4 x float>) #1
; Function Attrs: nounwind readnone
declare double @llvm.experimental.vector.reduce.fmax.f64.nxv2f64(<n x 2 x double>) #1

attributes #0 = { norecurse nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { argmemonly nounwind readonly }
attributes #3 = { nounwind }
