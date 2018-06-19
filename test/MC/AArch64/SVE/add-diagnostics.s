// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
add z21.h, z21.h, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z21.h, z21.h, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z22.h, z22.h, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z22.h, z22.h, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z13.h, z13.h, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z13.h, z13.h, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z9.h, z9.h, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z9.h, z9.h, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
add z21.h, z22.h, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: add z21.h, z22.h, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
add z22.h, p8/m, z22.h, z6.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: add z22.h, p8/m, z22.h, z6.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
add z9.h, p3/m, z10.h, z28.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: add z9.h, p3/m, z10.h, z28.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Register z32 does not exist.
add z22.h, z10.h, z32.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: add z22.h, z10.h, z32.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Invalid element kind.
add z20.h, z2.h, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: add z20.h, z2.h, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
add z27.h, z11.h, z27.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: add z27.h, z11.h, z27.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z29.s, z29.s, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z29.s, z29.s, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z19.s, z19.s, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z19.s, z19.s, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z29.s, z29.s, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z29.s, z29.s, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z9.s, z9.s, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z9.s, z9.s, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z23.s, z23.s, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z23.s, z23.s, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
add z19.s, z20.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: add z19.s, z20.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
add z30.s, p8/m, z30.s, z13.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: add z30.s, p8/m, z30.s, z13.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
add z5.s, p3/m, z6.s, z18.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: add z5.s, p3/m, z6.s, z18.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z16.d, z16.d, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z16.d, z16.d, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z16.d, z16.d, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z16.d, z16.d, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z0.d, z0.d, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z0.d, z0.d, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z27.d, z27.d, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z27.d, z27.d, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z27.d, z27.d, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z27.d, z27.d, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
add z3.d, z4.d, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: add z3.d, z4.d, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
add z29.d, p8/m, z29.d, z8.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: add z29.d, p8/m, z29.d, z8.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
add z9.d, p4/m, z10.d, z7.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: add z9.d, p4/m, z10.d, z7.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z27.b, z27.b, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z27.b, z27.b, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z20.b, z20.b, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z20.b, z20.b, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z8.b, z8.b, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z8.b, z8.b, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z20.b, z20.b, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z20.b, z20.b, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
add z22.b, z22.b, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: add z22.b, z22.b, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
add z27.b, z28.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: add z27.b, z28.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
add z28.b, p8/m, z28.b, z4.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: add z28.b, p8/m, z28.b, z4.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
add z27.b, p3/m, z28.b, z29.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: add z27.b, p3/m, z28.b, z29.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

