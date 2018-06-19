; RUN: llvm-link %p/sc-1730-elementcount.ll %p/Inputs/sc-1730-elementcount.ll -S -o - | FileCheck %s

%struct.bar = type { i32, float }

; CHECK: define void @foo(<n x 2 x
; CHECK: define void @foo2(<n x 2 x
define void @foo(<n x 2 x %struct.bar*> %arg) {
  ret void
}
