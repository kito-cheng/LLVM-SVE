; RUN: llc -mtriple=aarch64 -mattr=+sve < %s | FileCheck %s

; Check for no crash.
; CHECK-LABEL: setcc_test
define <n x 4 x i32> @setcc_test(<n x 4 x i1> %predicate, <n x 4 x i32> %vec1, <n x 4 x i32> %vec2) {
  %cmp = icmp eq <n x 4 x i32> %vec1, %vec2
  %v1 = zext <n x 4 x i1> %cmp to <n x 4 x i32>
  %killbits = zext <n x 4 x i1> %predicate to <n x 4 x i32>
  %v2 = and <n x 4 x i32> %v1, %killbits
  %v3 = select <n x 4 x i1> %predicate, <n x 4 x i32> %v2, <n x 4 x i32> %vec2
  ret <n x 4 x i32> %v3
}
