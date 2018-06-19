// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// Wrong immediate type for second operand (should only allow predicate pattern)

sqdecb z13.b, mul #2
// CHECK: error: invalid operand for instruction
sqdech z23.h, mul #3, mul #3
// CHECK: error: invalid operand for instruction
sqdecw z20.s, mul #4, mul #2
// CHECK: error: invalid operand for instruction
sqdecd z30.d, mul #5
// CHECK: error: invalid operand for instruction

sqincb z13.b, mul #2
// CHECK: error: invalid operand for instruction
sqinch z23.h, MUL #3, mul #3
// CHECK: error: invalid operand for instruction
sqincw z20.s, mul #4, MUL #2
// CHECK: error: invalid operand for instruction
sqincd z30.d, mul #5
// CHECK: error: invalid operand for instruction

sqdecb x1, w1, mul #2
// CHECK: error: invalid operand for instruction
sqdech x3, w3, mul #3, mul #3
// CHECK: error: invalid operand for instruction
sqdecw x5, w5, mul #4, mul #2
// CHECK: error: invalid operand for instruction
sqdecd x7, w7, mul #5
// CHECK: error: invalid operand for instruction

sqincb x1, w1, mul #2
// CHECK: error: invalid operand for instruction
sqinch x3, w3, mul #3, mul #3
// CHECK: error: invalid operand for instruction
sqincw x5, w5, mul #4, mul #2
// CHECK: error: invalid operand for instruction
sqincd x7, w7, mul #5
// CHECK: error: invalid operand for instruction

sqdecb x1, mul #2
// CHECK: error: invalid operand for instruction
sqdech x3, mul #3, mul #3
// CHECK: error: invalid operand for instruction
sqdecw x5, mul #4, mul #2
// CHECK: error: invalid operand for instruction
sqdecd x7, mul #5
// CHECK: error: invalid operand for instruction

sqincb x1, mul #2
// CHECK: error: invalid operand for instruction
sqinch x3, mul #3, mul #3
// CHECK: error: invalid operand for instruction
sqincw x5, mul #4, mul #2
// CHECK: error: invalid operand for instruction
sqincd x7, mul #5
// CHECK: error: invalid operand for instruction

uqdecb z13.b, mul #2
// CHECK: error: invalid operand for instruction
uqdech z23.h, mul #3, mul #3
// CHECK: error: invalid operand for instruction
uqdecw z20.s, mul #4, mul #2
// CHECK: error: invalid operand for instruction
uqdecd z30.d, mul #5
// CHECK: error: invalid operand for instruction

uqincb z13.b, mul #2
// CHECK: error: invalid operand for instruction
uqinch z23.h, MUL #3, mul #3
// CHECK: error: invalid operand for instruction
uqincw z20.s, mul #4, MUL #2
// CHECK: error: invalid operand for instruction
uqincd z30.d, mul #5
// CHECK: error: invalid operand for instruction

uqdecb w1, mul #2
// CHECK: error: invalid operand for instruction
uqdech w3, mul #3, mul #3
// CHECK: error: invalid operand for instruction
uqdecw w5, mul #4, mul #2
// CHECK: error: invalid operand for instruction
uqdecd w7, mul #5
// CHECK: error: invalid operand for instruction

uqincb w1, mul #2
// CHECK: error: invalid operand for instruction
uqinch w3, mul #3, mul #3
// CHECK: error: invalid operand for instruction
uqincw w5, mul #4, mul #2
// CHECK: error: invalid operand for instruction
uqincd w7, mul #5
// CHECK: error: invalid operand for instruction

uqdecb x1, mul #2
// CHECK: error: invalid operand for instruction
uqdech x3, mul #3, mul #3
// CHECK: error: invalid operand for instruction
uqdecw x5, mul #4, mul #2
// CHECK: error: invalid operand for instruction
uqdecd x7, mul #5
// CHECK: error: invalid operand for instruction

uqincb x1, mul #2
// CHECK: error: invalid operand for instruction
uqinch x3, mul #3, mul #3
// CHECK: error: invalid operand for instruction
uqincw x5, mul #4, mul #2
// CHECK: error: invalid operand for instruction
uqincd x7, mul #5
// CHECK: error: invalid operand for instruction
