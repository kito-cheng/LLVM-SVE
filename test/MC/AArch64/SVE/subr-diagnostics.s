// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
subr z19.h, z19.h, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z19.h, z19.h, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z0.h, z0.h, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z0.h, z0.h, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z24.h, z24.h, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z24.h, z24.h, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z4.h, z4.h, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z4.h, z4.h, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
subr z8.h, z9.h, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: subr z8.h, z9.h, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
subr z7.h, p8/m, z7.h, z18.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: subr z7.h, p8/m, z7.h, z18.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
subr z22.h, p6/m, z23.h, z1.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: subr z22.h, p6/m, z23.h, z1.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z23.s, z23.s, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z23.s, z23.s, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z26.s, z26.s, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z26.s, z26.s, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z4.s, z4.s, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z4.s, z4.s, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z27.s, z27.s, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z27.s, z27.s, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z13.s, z13.s, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z13.s, z13.s, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
subr z18.s, z19.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: subr z18.s, z19.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
subr z21.s, p8/m, z21.s, z4.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: subr z21.s, p8/m, z21.s, z4.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
subr z21.s, p4/m, z22.s, z11.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: subr z21.s, p4/m, z22.s, z11.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z29.d, z29.d, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z29.d, z29.d, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z14.d, z14.d, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z14.d, z14.d, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z9.d, z9.d, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z9.d, z9.d, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z28.d, z28.d, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z28.d, z28.d, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z8.d, z8.d, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z8.d, z8.d, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
subr z21.d, z22.d, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: subr z21.d, z22.d, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
subr z26.d, p8/m, z26.d, z28.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: subr z26.d, p8/m, z26.d, z28.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
subr z0.d, p6/m, z1.d, z8.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: subr z0.d, p6/m, z1.d, z8.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z20.b, z20.b, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z20.b, z20.b, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z4.b, z4.b, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z4.b, z4.b, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z24.b, z24.b, #511
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z24.b, z24.b, #511
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z3.b, z3.b, #300
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z3.b, z3.b, #300
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
subr z22.b, z22.b, #65281
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
// CHECK-NEXT: subr z22.b, z22.b, #65281
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
subr z21.b, z22.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: subr z21.b, z22.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
subr z14.b, p8/m, z14.b, z11.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: subr z14.b, p8/m, z14.b, z11.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
subr z11.b, p5/m, z12.b, z18.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: subr z11.b, p5/m, z12.b, z18.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

