// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
uqsub z10.h, z10.h, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z10.h, z10.h, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z28.h, z28.h, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z28.h, z28.h, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z30.h, z30.h, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z30.h, z30.h, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z25.h, z25.h, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z25.h, z25.h, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
uqsub z20.h, z21.h, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: uqsub z20.h, z21.h, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Register z32 does not exist.
uqsub z17.h, z13.h, z32.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: uqsub z17.h, z13.h, z32.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Invalid element kind.
uqsub z9.h, z11.h, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: uqsub z9.h, z11.h, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
uqsub z16.h, z27.h, z12.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: uqsub z16.h, z27.h, z12.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z1.s, z1.s, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z1.s, z1.s, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z1.s, z1.s, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z1.s, z1.s, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z20.s, z20.s, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z20.s, z20.s, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z15.s, z15.s, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z15.s, z15.s, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z5.s, z5.s, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z5.s, z5.s, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
uqsub z11.s, z12.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: uqsub z11.s, z12.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z10.d, z10.d, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z10.d, z10.d, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z5.d, z5.d, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z5.d, z5.d, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z14.d, z14.d, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z14.d, z14.d, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z18.d, z18.d, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z18.d, z18.d, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z17.d, z17.d, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z17.d, z17.d, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
uqsub z15.d, z16.d, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: uqsub z15.d, z16.d, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z29.b, z29.b, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z29.b, z29.b, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z4.b, z4.b, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z4.b, z4.b, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z15.b, z15.b, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z15.b, z15.b, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z18.b, z18.b, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z18.b, z18.b, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqsub z12.b, z12.b, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqsub z12.b, z12.b, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
uqsub z20.b, z21.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: uqsub z20.b, z21.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

