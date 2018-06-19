; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; This test checks an assertion doesn't fire due to incorrect live-interval information.
; Function Attrs: norecurse nounwind
define void @test_ec() local_unnamed_addr #0 {
; CHECK-LABEL: test_ec
; CHECK-DAG: mov     [[VEC:z[0-9]+]].d, #0
; CHECK-DAG: ptrue [[PTRUE:p[0-9]+]].d
; CHECK: movprfx [[VEC2:z[0-9]+]], [[VEC]]
; CHECK-NEXT: fmla    [[VEC2]].d, [[PTRUE]]/m, [[VEC]].d, [[VEC]].d
L.entry:
  %0 = fmul fast <n x 2 x double> zeroinitializer, zeroinitializer
  %1 = fadd fast <n x 2 x double> %0, zeroinitializer
  call void @llvm.aarch64.sve.st2.nxv2f64(<n x 2 x double> %1, <n x 2 x double> zeroinitializer, <n x 2 x i1> undef, <n x 2 x double>* undef)
  unreachable
}

; Function Attrs: norecurse nounwind
define void @test_ec2(<n x 2 x double> %in) local_unnamed_addr #0 {
; CHECK-LABEL: test_ec2
; CHECK-DAG: ptrue [[PTRUE:p[0-9]+]].d
; CHECK: movprfx [[VEC:z[0-9]+]], z0
; CHECK-NEXT: fmla    [[VEC]].d, [[PTRUE]]/m, z0.d, z0.d
L.entry:
  %0 = fmul fast <n x 2 x double> %in, %in
  %1 = fadd fast <n x 2 x double> %0, %in
  call void @llvm.aarch64.sve.st2.nxv2f64(<n x 2 x double> %1, <n x 2 x double> zeroinitializer, <n x 2 x i1> undef, <n x 2 x double>* undef)
  unreachable
}

; Function Attrs: argmemonly nounwind
declare void @llvm.aarch64.sve.st2.nxv2f64(<n x 2 x double>, <n x 2 x double>, <n x 2 x i1>, <n x 2 x double>* nocapture) #1

attributes #0 = { norecurse nounwind "no-frame-pointer-elim-non-leaf" "target-features"="+sve" }
attributes #1 = { argmemonly nounwind }

!llvm.module.flags = !{!0}

!0 = !{i32 1, !"Debug Info Version", i32 3}
