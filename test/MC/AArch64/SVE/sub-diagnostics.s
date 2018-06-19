// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
sub z19.h, z19.h, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z19.h, z19.h, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z20.h, z20.h, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z20.h, z20.h, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z16.h, z16.h, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z16.h, z16.h, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z15.h, z15.h, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z15.h, z15.h, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sub z11.h, z12.h, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sub z11.h, z12.h, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
sub z14.h, p8/m, z14.h, z18.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: sub z14.h, p8/m, z14.h, z18.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sub z29.h, p6/m, z30.h, z20.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sub z29.h, p6/m, z30.h, z20.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Register z32 does not exist.
sub z3.h, z26.h, z32.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: sub z3.h, z26.h, z32.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Invalid element kind.
sub z4.h, z27.h, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: sub z4.h, z27.h, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
sub z0.h, z8.h, z8.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: sub z0.h, z8.h, z8.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z11.s, z11.s, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z11.s, z11.s, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z26.s, z26.s, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z26.s, z26.s, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z1.s, z1.s, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z1.s, z1.s, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z13.s, z13.s, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z13.s, z13.s, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z24.s, z24.s, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z24.s, z24.s, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sub z15.s, z16.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sub z15.s, z16.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
sub z30.s, p8/m, z30.s, z23.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: sub z30.s, p8/m, z30.s, z23.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sub z14.s, p2/m, z15.s, z21.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sub z14.s, p2/m, z15.s, z21.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z8.d, z8.d, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z8.d, z8.d, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z12.d, z12.d, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z12.d, z12.d, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z12.d, z12.d, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z12.d, z12.d, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z29.d, z29.d, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z29.d, z29.d, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z7.d, z7.d, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z7.d, z7.d, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sub z11.d, z12.d, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sub z11.d, z12.d, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
sub z8.d, p8/m, z8.d, z27.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: sub z8.d, p8/m, z8.d, z27.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sub z8.d, p5/m, z9.d, z26.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sub z8.d, p5/m, z9.d, z26.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z6.b, z6.b, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z6.b, z6.b, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z30.b, z30.b, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z30.b, z30.b, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z17.b, z17.b, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z17.b, z17.b, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z22.b, z22.b, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z22.b, z22.b, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
sub z15.b, z15.b, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: sub z15.b, z15.b, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sub z27.b, z28.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sub z27.b, z28.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
sub z5.b, p8/m, z5.b, z18.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: sub z5.b, p8/m, z5.b, z18.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
sub z22.b, p0/m, z23.b, z29.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: sub z22.b, p0/m, z23.b, z29.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

