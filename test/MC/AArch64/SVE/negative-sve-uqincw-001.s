// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// Invalid SVE patterns.
uqincw x9, #356.0000222, mul #14
// CHECK: error: invalid operand
uqincw x9, #-26.0, mul #14
// CHECK: error: invalid operand
uqincw w31, #-0.90625, mul #12
// CHECK: error: invalid operand
