; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define void @fold_xor_allzeros(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: @fold_xor_allzeros
; CHECK-NOT: mov {{[z0-9]+.s}}, #0
; CHECK-NOT: eor
; CHECK: ret
  %lda = load <n x 4 x i32> , <n x 4 x i32>* %a
  %ldb = load <n x 4 x i32> , <n x 4 x i32>* %b
  %xor = xor <n x 4 x i32> %lda, zeroinitializer
  %res = add <n x 4 x i32> %xor, %ldb
  store <n x 4 x i32> %res, <n x 4 x i32>* %a
  ret void
}

define void @nofold_xor_allones(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: @nofold_xor_allones
; CHECK: mov {{[z0-9]+.s}}, #-1
; CHECK: eor
; CHECK: ret
  %lda = load <n x 4 x i32> , <n x 4 x i32>* %a
  %ldb = load <n x 4 x i32> , <n x 4 x i32>* %b
  %allones = shufflevector <n x 4 x i32> insertelement(<n x 4 x i32> undef, i32 -1, i32 0), <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %xor = xor <n x 4 x i32> %lda, %allones
  %res = add <n x 4 x i32> %xor, %ldb
  store <n x 4 x i32> %res, <n x 4 x i32>* %a
  ret void
}

define void @fold_and_allones(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: @fold_and_allones
; CHECK-NOT: mov {{[z0-9]+.s}}, #-1
; CHECK-NOT: and
; CHECK: ret
  %lda = load <n x 4 x i32> , <n x 4 x i32>* %a
  %ldb = load <n x 4 x i32> , <n x 4 x i32>* %b
  %allones = shufflevector <n x 4 x i32> insertelement(<n x 4 x i32> undef, i32 -1, i32 0), <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %and = and <n x 4 x i32> %lda, %allones
  %res = add <n x 4 x i32> %and, %ldb
  store <n x 4 x i32> %res, <n x 4 x i32>* %a
  ret void
}

define void @fold_and_allzeros(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: @fold_and_allzeros
; CHECK-NOT: mov {{[z0-9]+.s}}, #0
; CHECK-NOT: and
; CHECK-NOT: add
; CHECK: ret
  %lda = load <n x 4 x i32> , <n x 4 x i32>* %a
  %ldb = load <n x 4 x i32> , <n x 4 x i32>* %b
  %and = and <n x 4 x i32> %lda, zeroinitializer
  %res = add <n x 4 x i32> %and, %ldb
  store <n x 4 x i32> %res, <n x 4 x i32>* %a
  ret void
}
