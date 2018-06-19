// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
fsub z23.d, p0/m, z24.d, #0.5
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fsub z23.d, p0/m, z24.d, #0.5
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fsub z15.d, p8/m, z15.d, z8.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fsub z15.d, p8/m, z15.d, z8.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fsub z14.d, p3/m, z15.d, z14.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fsub z14.d, p3/m, z15.d, z14.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Register z32 does not exist.
fsub z2.d, z11.d, z32.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: fsub z2.d, z11.d, z32.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Invalid element kind.
fsub z29.d, z18.d, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: fsub z29.d, z18.d, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
fsub z12.d, z3.d, z9.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: fsub z12.d, z3.d, z9.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fsub z28.h, p8/m, z28.h, #0.5
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fsub z28.h, p8/m, z28.h, #0.5
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fsub z26.h, p3/m, z27.h, #0.5
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fsub z26.h, p3/m, z27.h, #0.5
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fsub z29.h, p8/m, z29.h, z17.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fsub z29.h, p8/m, z29.h, z17.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fsub z21.h, p2/m, z22.h, z27.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fsub z21.h, p2/m, z22.h, z27.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fsub z29.s, p8/m, z29.s, #0.5
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fsub z29.s, p8/m, z29.s, #0.5
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fsub z24.s, p0/m, z25.s, #0.5
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fsub z24.s, p0/m, z25.s, #0.5
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fsub z4.s, p8/m, z4.s, z18.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fsub z4.s, p8/m, z4.s, z18.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fsub z17.s, p6/m, z18.s, z30.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fsub z17.s, p6/m, z18.s, z30.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

