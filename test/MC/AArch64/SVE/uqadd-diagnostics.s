// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
uqadd z25.h, z25.h, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z25.h, z25.h, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z10.h, z10.h, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z10.h, z10.h, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z29.h, z29.h, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z29.h, z29.h, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z24.h, z24.h, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z24.h, z24.h, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
uqadd z24.h, z25.h, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: uqadd z24.h, z25.h, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Register z32 does not exist.
uqadd z3.h, z8.h, z32.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: uqadd z3.h, z8.h, z32.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Invalid element kind.
uqadd z15.h, z27.h, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: uqadd z15.h, z27.h, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
uqadd z28.h, z28.h, z25.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: uqadd z28.h, z28.h, z25.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z10.s, z10.s, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z10.s, z10.s, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z26.s, z26.s, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z26.s, z26.s, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z8.s, z8.s, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z8.s, z8.s, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z25.s, z25.s, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z25.s, z25.s, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z14.s, z14.s, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z14.s, z14.s, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
uqadd z27.s, z28.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: uqadd z27.s, z28.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z24.d, z24.d, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z24.d, z24.d, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z8.d, z8.d, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z8.d, z8.d, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z3.d, z3.d, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z3.d, z3.d, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z9.d, z9.d, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z9.d, z9.d, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z29.d, z29.d, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z29.d, z29.d, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
uqadd z16.d, z17.d, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: uqadd z16.d, z17.d, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z11.b, z11.b, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z11.b, z11.b, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z19.b, z19.b, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z19.b, z19.b, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z27.b, z27.b, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z27.b, z27.b, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z7.b, z7.b, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z7.b, z7.b, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
uqadd z22.b, z22.b, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: uqadd z22.b, z22.b, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
uqadd z8.b, z9.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: uqadd z8.b, z9.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

