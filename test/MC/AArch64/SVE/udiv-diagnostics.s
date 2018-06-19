// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
udiv z3.s, p0/m, z4.s, z19.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: udiv z3.s, p0/m, z4.s, z19.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
udiv z14.d, p8/m, z14.d, z4.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: udiv z14.d, p8/m, z14.d, z4.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
udiv z11.d, p5/m, z12.d, z19.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: udiv z11.d, p5/m, z12.d, z19.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

