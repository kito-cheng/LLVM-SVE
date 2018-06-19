; RUN: opt -S -instsimplify < %s | FileCheck %s

declare void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32>, <n x 4 x i32*>, i32, <n x 4 x i1>)

@fooarray = common global [56 x i64] zeroinitializer, align 4

;; This test isn't guarding a transformation -- the result is equivalent to current IR,
;; but we just want to make sure we don't crash when trying to simplify GEPs with
;; a constant base pointer and constant-like seriesvector indices.
define void @gep_constants(<n x 4 x i32> %data, <n x 4 x i1> %mask) {
; CHECK-LABEL: @gep_constants
; CHECK: call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %data, <n x 4 x i32*> getelementptr (i32, i32* bitcast ([56 x i64]* @fooarray to i32*), <n x 4 x i64> sext (<n x 4 x i32> mul (<n x 4 x i32> shufflevector (<n x 4 x i32> insertelement (<n x 4 x i32> undef, i32 2, i32 0), <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer), <n x 4 x i32> stepvector) to <n x 4 x i64>)), i32 4, <n x 4 x i1> %mask)
; CHECK-NEXT: ret void
  %1 = insertelement <n x 4 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %indices = add <n x 4 x i32> %5, %3
  %ptrs = getelementptr i32, i32* bitcast ([56 x i64]* @fooarray to i32*), <n x 4 x i32> %indices
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %data, <n x 4 x i32*> %ptrs, i32 4, <n x 4 x i1> %mask)
  ret void
}
