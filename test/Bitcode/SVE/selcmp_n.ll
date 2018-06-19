; This test checks that icmp/select combo can be assembled and disassembled

; RUN: llvm-as < %s | llvm-dis | FileCheck %s

define <n x 4 x i16> @selcmp_n(<n x 4 x i16> %a, <n x 4 x i16> %b) {
  %1 = icmp ugt <n x 4 x i16> %a, %b
  %2 = select <n x 4 x i1> %1, <n x 4 x i16> %a, <n x 4 x i16> %b
  ret <n x 4 x i16> %2
}

; CHECK: define <n x 4 x i16> @selcmp_n(<n x 4 x i16> %a, <n x 4 x i16> %b)
; CHECK: %1 = icmp ugt <n x 4 x i16> %a, %b
; CHECK: %2 = select <n x 4 x i1> %1, <n x 4 x i16> %a, <n x 4 x i16> %b
; CHECK: ret <n x 4 x i16> %2
