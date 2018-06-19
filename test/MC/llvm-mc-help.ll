//RUN: llvm-mc -mcpu=help 2>&1 | FileCheck %s
//RUN: llvm-mc -mattr=help 2>&1 | FileCheck %s

; CHECK: Available CPUs for this target
; CHECK: Available features for this target
