// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
sqincp x29, p9.s, w30
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must be 32-bit form of destination register
// CHECK-NEXT: sqincp x29, p9.s, w30
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sqincp x19, p11.d, w20
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must be 32-bit form of destination register
// CHECK-NEXT: sqincp x19, p11.d, w20
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sqincp x14, p13.b, w15
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must be 32-bit form of destination register
// CHECK-NEXT: sqincp x14, p13.b, w15
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

