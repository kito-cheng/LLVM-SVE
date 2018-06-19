; RUN: opt < %s -instcombine -S | FileCheck %s
target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

define i1 @test1(i32 *%x) nounwind {
entry:
; CHECK: test1
; CHECK: ptrtoint i32* %x to i64
	%0 = ptrtoint i32* %x to i1
	ret i1 %0
}

define i32* @test2(i128 %x) nounwind {
entry:
; CHECK: test2
; CHECK: inttoptr i64 %0 to i32*
	%0 = inttoptr i128 %x to i32*
	ret i32* %0
}

; PR3574
; CHECK: f0
; CHECK: %1 = zext i32 %a0 to i64
; CHECK: ret i64 %1
define i64 @f0(i32 %a0) nounwind {
       %t0 = inttoptr i32 %a0 to i8*
       %t1 = ptrtoint i8* %t0 to i64
       ret i64 %t1
}

define <4 x i32> @test4(<4 x i8*> %arg) nounwind {
; CHECK-LABEL: @test4(
; CHECK: ptrtoint <4 x i8*> %arg to <4 x i64>
; CHECK: trunc <4 x i64> %1 to <4 x i32>
  %p1 = ptrtoint <4 x i8*> %arg to <4 x i32>
  ret <4 x i32> %p1
}

define <4 x i128> @test5(<4 x i8*> %arg) nounwind {
; CHECK-LABEL: @test5(
; CHECK: ptrtoint <4 x i8*> %arg to <4 x i64>
; CHECK: zext <4 x i64> %1 to <4 x i128>
  %p1 = ptrtoint <4 x i8*> %arg to <4 x i128>
  ret <4 x i128> %p1
}

define <4 x i8*> @test6(<4 x i32> %arg) nounwind {
; CHECK-LABEL: @test6(
; CHECK: zext <4 x i32> %arg to <4 x i64>
; CHECK: inttoptr <4 x i64> %1 to <4 x i8*>
  %p1 = inttoptr <4 x i32> %arg to <4 x i8*>
  ret <4 x i8*> %p1
}

define <4 x i8*> @test7(<4 x i128> %arg) nounwind {
; CHECK-LABEL: @test7(
; CHECK: trunc <4 x i128> %arg to <4 x i64>
; CHECK: inttoptr <4 x i64> %1 to <4 x i8*>
  %p1 = inttoptr <4 x i128> %arg to <4 x i8*>
  ret <4 x i8*> %p1
}

define <n x 4 x i32*> @test8(i32* %arg, <n x 4 x i64> %idx) nounwind {
; CHECK-LABEL: @test8(
; CHECK: getelementptr i32, i32* %arg, <n x 4 x i64> %idx
  %s0 = insertelement <n x 4 x i32*> undef, i32* %arg, i32 0
  %s1 = shufflevector <n x 4 x i32*> %s0, <n x 4 x i32*> undef, <n x 4 x i32> zeroinitializer
  %t0 = ptrtoint <n x 4 x i32*> %s1 to <n x 4 x i64>
  %t3 = mul <n x 4 x i64> %idx, shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 4, i32 0),
                                               <n x 4 x i64> undef,
                                               <n x 4 x i32> zeroinitializer)
  %t1 = add <n x 4 x i64> %t0, %t3
  %p1 = inttoptr <n x 4 x i64> %t1 to <n x 4 x i32*>
  ret <n x 4 x i32*> %p1
}

define <n x 4 x i16*> @test9(i16* %arg, <n x 4 x i64> %idx) nounwind {
; CHECK-LABEL: @test9(
; CHECK: getelementptr i16, i16* %arg, <n x 4 x i64> %idx
  %s0 = insertelement <n x 4 x i16*> undef, i16* %arg, i32 0
  %s1 = shufflevector <n x 4 x i16*> %s0, <n x 4 x i16*> undef, <n x 4 x i32> zeroinitializer
  %t0 = ptrtoint <n x 4 x i16*> %s1 to <n x 4 x i64>
  %t3 = shl <n x 4 x i64> %idx, shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 1, i32 0),
                                               <n x 4 x i64> undef,
                                               <n x 4 x i32> zeroinitializer)
  %t1 = add <n x 4 x i64> %t0, %t3
  %p1 = inttoptr <n x 4 x i64> %t1 to <n x 4 x i16*>
  ret <n x 4 x i16*> %p1
}

define <n x 4 x i8*> @test10(i8* %arg, <n x 4 x i64> %idx) nounwind {
; CHECK-LABEL: @test10(
; CHECK: getelementptr i8, i8* %arg, <n x 4 x i64> %idx
  %s0 = insertelement <n x 4 x i8*> undef, i8* %arg, i32 0
  %s1 = shufflevector <n x 4 x i8*> %s0, <n x 4 x i8*> undef, <n x 4 x i32> zeroinitializer
  %t0 = ptrtoint <n x 4 x i8*> %s1 to <n x 4 x i64>
  %t1 = add <n x 4 x i64> %t0, %idx
  %p1 = inttoptr <n x 4 x i64> %t1 to <n x 4 x i8*>
  ret <n x 4 x i8*> %p1
}

define <n x 4 x i8*> @test11(<n x 4 x i8*> %ptrs, i64 %idx) nounwind {
; CHECK-LABEL: @test11(
; CHECK: getelementptr i8, <n x 4 x i8*> %ptrs, i64 %idx
  %s0 = insertelement <n x 4 x i64> undef, i64 %idx, i32 0
  %s1 = shufflevector <n x 4 x i64> %s0, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %t0 = ptrtoint <n x 4 x i8*> %ptrs to <n x 4 x i64>
  %t1 = add <n x 4 x i64> %t0, %s1
  %p1 = inttoptr <n x 4 x i64> %t1 to <n x 4 x i8*>
  ret <n x 4 x i8*> %p1
}

define <n x 4 x i32*> @test12(<n x 4 x i32*> %ptrs, i64 %idx) nounwind {
; CHECK-LABEL: @test12(
; CHECK: getelementptr i32, <n x 4 x i32*> %ptrs, i64 %idx
  %s0 = insertelement <n x 4 x i64> undef, i64 %idx, i32 0
  %s1 = shufflevector <n x 4 x i64> %s0, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %s2 = mul <n x 4 x i64> %s1, shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 4, i32 0),
                                              <n x 4 x i64> undef,
                                              <n x 4 x i32> zeroinitializer)
  %t0 = ptrtoint <n x 4 x i32*> %ptrs to <n x 4 x i64>
  %t1 = add <n x 4 x i64> %t0, %s2
  %p1 = inttoptr <n x 4 x i64> %t1 to <n x 4 x i32*>
  ret <n x 4 x i32*> %p1
}
