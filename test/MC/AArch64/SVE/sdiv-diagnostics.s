// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
sdiv z12.s, p4/m, z13.s, z11.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sdiv z12.s, p4/m, z13.s, z11.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
sdiv z29.d, p8/m, z29.d, z4.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: sdiv z29.d, p8/m, z29.d, z4.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sdiv z23.d, p5/m, z24.d, z27.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sdiv z23.d, p5/m, z24.d, z27.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

