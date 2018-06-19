// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
pnext p2.s, p11, p3.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: pnext p2.s, p11, p3.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
pnext p12.d, p14, p13.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: pnext p12.d, p14, p13.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
pnext p12.b, p12, p13.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: pnext p12.b, p12, p13.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

