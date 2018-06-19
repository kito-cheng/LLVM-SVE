// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
udivr z29.s, p3/m, z30.s, z25.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: udivr z29.s, p3/m, z30.s, z25.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
udivr z22.d, p8/m, z22.d, z10.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: udivr z22.d, p8/m, z22.d, z10.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
udivr z8.d, p4/m, z9.d, z0.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: udivr z8.d, p4/m, z9.d, z0.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

