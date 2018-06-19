// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
sqdecp x16, p10.s, w17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must be 32-bit form of destination register
// CHECK-NEXT: sqdecp x16, p10.s, w17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sqdecp x16, p1.d, w17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must be 32-bit form of destination register
// CHECK-NEXT: sqdecp x16, p1.d, w17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sqdecp x12, p14.b, w13
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must be 32-bit form of destination register
// CHECK-NEXT: sqdecp x12, p14.b, w13
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

