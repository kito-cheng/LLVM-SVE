; RUN: opt -instcombine -S < %s | FileCheck %s
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

; This test makes sure that these instructions are properly eliminated.

target datalayout = "e-m:e-p:64:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @test1(i8* %x, i8* %a, i8* %b, i8* %c) {
; Check that we canonicalize loads which are only stored to use integer types
; when there is a valid integer type.
; CHECK-LABEL: @test1(
; CHECK: %[[L1:.*]] = load i32, i32*
; CHECK-NOT: load
; CHECK: store i32 %[[L1]], i32*
; CHECK: store i32 %[[L1]], i32*
; CHECK-NOT: store
; CHECK: %[[L1:.*]] = load i32, i32*
; CHECK-NOT: load
; CHECK: store i32 %[[L1]], i32*
; CHECK: store i32 %[[L1]], i32*
; CHECK-NOT: store
; CHECK: ret

  %x.cast = bitcast i8* %x to <4 x i8>*
  %a.cast = bitcast i8* %a to <4 x i8>*
  %b.cast = bitcast i8* %b to <4 x i8>*
  %c.cast = bitcast i8* %c to i32*

  %x1 = load <4 x i8>, <4 x i8>* %x.cast
  store <4 x i8> %x1, <4 x i8>* %a.cast
  store <4 x i8> %x1, <4 x i8>* %b.cast

  %x2 = load <4 x i8>, <4 x i8>* %x.cast
  store <4 x i8> %x2, <4 x i8>* %b.cast
  %x2.cast = bitcast <4 x i8> %x2 to i32
  store i32 %x2.cast, i32* %c.cast

  ret void
}

define void @test2(i8* %x, i8* %a, i8* %b, i8* %c) {
; Check that in cases similar to @test1 we don't try to rewrite a load when
; its datatype is compile time scalable.
;
; CHECK-LABEL: @test2(
; CHECK: %[[L1:.*]] = load <n x 4 x i8>, <n x 4 x i8>*
; CHECK-NOT: load
; CHECK: store <n x 4 x i8> %[[L1]], <n x 4 x i8>*
; CHECK: store <n x 4 x i8> %[[L1]], <n x 4 x i8>*
; CHECK-NOT: store
; CHECK: %[[L1:.*]] = load <n x 4 x i8>, <n x 4 x i8>*
; CHECK-NOT: load
; CHECK: store <n x 4 x i8> %[[L1]], <n x 4 x i8>*
; CHECK: store <n x 4 x i8> %[[L1]], <n x 4 x i8>*
; CHECK-NOT: store
; CHECK: ret

  %x.cast = bitcast i8* %x to <n x 4 x i8>*
  %a.cast = bitcast i8* %a to <n x 4 x i8>*
  %b.cast = bitcast i8* %b to <n x 4 x i8>*
  %c.cast = bitcast i8* %c to i32*

  %x1 = load <n x 4 x i8>, <n x 4 x i8>* %x.cast
  store <n x 4 x i8> %x1, <n x 4 x i8>* %a.cast
  store <n x 4 x i8> %x1, <n x 4 x i8>* %b.cast

  %x2 = load <n x 4 x i8>, <n x 4 x i8>* %x.cast
  store <n x 4 x i8> %x2, <n x 4 x i8>* %b.cast
  %x2.cast = bitcast <n x 4 x i8> %x2 to i32
  store i32 %x2.cast, i32* %c.cast

  ret void
}

define <n x 4 x i8> @test3(i8* %x, <4 x i8> %fixedwidth) {
; Check that the compiler does not try to optimize the scalable-vector
; load from %x by replacing it with a 'bitcast <4 x i8> %fixedwidth to <n x 4 x i8>'
  %fixed.cast = bitcast i8* %x to <4 x i8>*
  %scaled.cast = bitcast i8* %x to <n x 4 x i8>*

; CHECK-LABEL: @test3
; CHECK: store <4 x i8> %fixedwidth, <4 x i8>* %fixed.cast
; CHECK-NOT: bitcast
; CHECK: load <n x 4 x i8>, <n x 4 x i8>* %scaled.cast
  store <4 x i8> %fixedwidth, <4 x i8>* %fixed.cast
  %scaled = load <n x 4 x i8>, <n x 4 x i8>* %scaled.cast
  ret <n x 4 x i8> %scaled
}
