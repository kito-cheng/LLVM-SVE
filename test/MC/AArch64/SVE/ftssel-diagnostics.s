// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Invalid element kind.
ftssel z23.d, z29.d, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: ftssel z23.d, z29.d, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
ftssel z22.d, z4.d, z8.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: ftssel z22.d, z4.d, z8.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

