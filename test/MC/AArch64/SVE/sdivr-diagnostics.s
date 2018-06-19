// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
sdivr z19.s, p2/m, z20.s, z7.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sdivr z19.s, p2/m, z20.s, z7.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
sdivr z10.d, p8/m, z10.d, z25.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: sdivr z10.d, p8/m, z10.d, z25.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sdivr z20.d, p4/m, z21.d, z23.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sdivr z20.d, p4/m, z21.d, z23.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

