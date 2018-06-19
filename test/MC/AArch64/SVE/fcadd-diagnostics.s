// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
fcadd z22.d, p2/m, z23.d, z15.d, #90
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fcadd z22.d, p2/m, z23.d, z15.d, #90
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fcadd z12.h, p8/m, z12.h, z27.h, #90
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcadd z12.h, p8/m, z12.h, z27.h, #90
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fcadd z9.h, p5/m, z10.h, z23.h, #90
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fcadd z9.h, p5/m, z10.h, z23.h, #90
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fcadd z10.s, p8/m, z10.s, z8.s, #90
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcadd z10.s, p8/m, z10.s, z8.s, #90
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fcadd z9.s, p5/m, z10.s, z23.s, #90
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fcadd z9.s, p5/m, z10.s, z23.s, #90
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

