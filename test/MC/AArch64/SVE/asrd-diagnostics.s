// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
asrd z9.h, p1/m, z9.h, #17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [1, 16]
// CHECK-NEXT: asrd z9.h, p1/m, z9.h, #17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
asrd z23.h, p8/m, z23.h, #1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: asrd z23.h, p8/m, z23.h, #1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
asrd z9.h, p2/m, z10.h, #1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: asrd z9.h, p2/m, z10.h, #1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
asrd z16.s, p5/m, z16.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [1, 32]
// CHECK-NEXT: asrd z16.s, p5/m, z16.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
asrd z25.s, p4/m, z25.s, #33
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [1, 32]
// CHECK-NEXT: asrd z25.s, p4/m, z25.s, #33
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
asrd z29.s, p8/m, z29.s, #1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: asrd z29.s, p8/m, z29.s, #1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
asrd z28.s, p3/m, z29.s, #1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: asrd z28.s, p3/m, z29.s, #1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
asrd z6.d, p1/m, z6.d, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [1, 64]
// CHECK-NEXT: asrd z6.d, p1/m, z6.d, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
asrd z7.d, p4/m, z7.d, #65
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [1, 64]
// CHECK-NEXT: asrd z7.d, p4/m, z7.d, #65
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
asrd z22.d, p8/m, z22.d, #1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: asrd z22.d, p8/m, z22.d, #1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
asrd z3.d, p5/m, z4.d, #1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: asrd z3.d, p5/m, z4.d, #1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
asrd z8.b, p3/m, z8.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [1, 8]
// CHECK-NEXT: asrd z8.b, p3/m, z8.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
asrd z26.b, p6/m, z26.b, #9
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [1, 8]
// CHECK-NEXT: asrd z26.b, p6/m, z26.b, #9
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
asrd z27.b, p8/m, z27.b, #1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: asrd z27.b, p8/m, z27.b, #1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
asrd z15.b, p6/m, z16.b, #1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: asrd z15.b, p6/m, z16.b, #1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

