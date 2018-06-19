// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// TODO: Although the errors are genuine the messages are not that helpful.

adr     z31.s, [z31.s, z31.s, lsl #4]
// CHECK: error: invalid operand for instruction

adr     z31.d, [z31.d, z31.d, lsl #5]
// CHECK: error: invalid operand for instruction

adr     z31.d, [z31.d, z31.d, sxtw #6]
// CHECK: error: invalid operand for instruction

adr     z31.d, [z31.d, z31.d, uxtw #-1]
// CHECK: error: expected integer shift amount
