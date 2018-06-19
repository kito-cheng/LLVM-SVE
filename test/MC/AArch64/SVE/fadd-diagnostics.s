// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
fadd z12.d, p1/m, z13.d, #0.5
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fadd z12.d, p1/m, z13.d, #0.5
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fadd z12.d, p8/m, z12.d, z22.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fadd z12.d, p8/m, z12.d, z22.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fadd z29.d, p2/m, z30.d, z8.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fadd z29.d, p2/m, z30.d, z8.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Register z32 does not exist.
fadd z19.d, z9.d, z32.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: fadd z19.d, z9.d, z32.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Invalid element kind.
fadd z25.d, z26.d, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: fadd z25.d, z26.d, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
fadd z13.d, z20.d, z10.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: fadd z13.d, z20.d, z10.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fadd z27.h, p8/m, z27.h, #0.5
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fadd z27.h, p8/m, z27.h, #0.5
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fadd z24.h, p4/m, z25.h, #0.5
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fadd z24.h, p4/m, z25.h, #0.5
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fadd z28.h, p8/m, z28.h, z9.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fadd z28.h, p8/m, z28.h, z9.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fadd z10.h, p6/m, z11.h, z24.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fadd z10.h, p6/m, z11.h, z24.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fadd z27.s, p8/m, z27.s, #0.5
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fadd z27.s, p8/m, z27.s, #0.5
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fadd z9.s, p0/m, z10.s, #0.5
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fadd z9.s, p0/m, z10.s, #0.5
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fadd z25.s, p8/m, z25.s, z23.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fadd z25.s, p8/m, z25.s, z23.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fadd z19.s, p6/m, z20.s, z6.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fadd z19.s, p6/m, z20.s, z6.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

