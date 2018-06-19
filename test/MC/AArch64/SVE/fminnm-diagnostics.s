// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
fminnm z11.d, p3/m, z12.d, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fminnm z11.d, p3/m, z12.d, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fminnm z13.d, p8/m, z13.d, z11.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fminnm z13.d, p8/m, z13.d, z11.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fminnm z25.d, p0/m, z26.d, z3.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fminnm z25.d, p0/m, z26.d, z3.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fminnm z0.h, p8/m, z0.h, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fminnm z0.h, p8/m, z0.h, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fminnm z26.h, p2/m, z27.h, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fminnm z26.h, p2/m, z27.h, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fminnm z18.h, p8/m, z18.h, z18.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fminnm z18.h, p8/m, z18.h, z18.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fminnm z26.h, p4/m, z27.h, z29.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fminnm z26.h, p4/m, z27.h, z29.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fminnm z12.s, p8/m, z12.s, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fminnm z12.s, p8/m, z12.s, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fminnm z9.s, p6/m, z10.s, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fminnm z9.s, p6/m, z10.s, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fminnm z4.s, p8/m, z4.s, z1.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fminnm z4.s, p8/m, z4.s, z1.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fminnm z6.s, p2/m, z7.s, z17.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fminnm z6.s, p2/m, z7.s, z17.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

