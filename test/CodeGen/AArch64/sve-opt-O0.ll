; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -O0 < %s | FileCheck %s

; CHECK-LABEL: test_no_expand:
; CHECK-NOT: st1b{{.*z[0-9]+}}
define void @test_no_expand(i32* nocapture readonly %src, i32* noalias nocapture %dst) {
entry:
  %0 = bitcast i32* %dst to i8*
  %1 = bitcast i32* %src to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 128, i32 4, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #0

attributes #0 = { argmemonly nounwind }
