// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
cpy z23.d, p8/m, d26
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: cpy z23.d, p8/m, d26
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cpy z21.s, p8/m, s23
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: cpy z21.s, p8/m, s23
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cpy z30.h, p8/m, h22
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: cpy z30.h, p8/m, h22
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z15.h, p5/m, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z15.h, p5/m, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z4.h, p6/m, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z4.h, p6/m, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z4.h, p11/m, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z4.h, p11/m, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z6.h, p12/m, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z6.h, p12/m, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z7.h, p13/m, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z7.h, p13/m, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z16.h, p4/m, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z16.h, p4/m, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z29.h, p13/z, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z29.h, p13/z, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z24.h, p1/z, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z24.h, p1/z, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z10.h, p13/z, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z10.h, p13/z, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z5.h, p2/z, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z5.h, p2/z, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z1.h, p11/z, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z1.h, p11/z, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z15.h, p5/z, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z15.h, p5/z, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z15.s, p14/m, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z15.s, p14/m, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z25.s, p3/m, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z25.s, p3/m, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z29.s, p6/m, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z29.s, p6/m, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z19.s, p7/m, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z19.s, p7/m, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z14.s, p11/m, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z14.s, p11/m, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z27.s, p13/m, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z27.s, p13/m, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z7.s, p0/z, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z7.s, p0/z, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z6.s, p2/z, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z6.s, p2/z, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z14.s, p14/z, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z14.s, p14/z, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z10.s, p6/z, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z10.s, p6/z, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z17.s, p10/z, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z17.s, p10/z, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z14.s, p0/z, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z14.s, p0/z, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z24.d, p13/m, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z24.d, p13/m, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z17.d, p4/m, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z17.d, p4/m, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z3.d, p6/m, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z3.d, p6/m, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z1.d, p14/m, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z1.d, p14/m, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z4.d, p9/m, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z4.d, p9/m, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z27.d, p9/m, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z27.d, p9/m, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z29.d, p6/z, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z29.d, p6/z, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z8.d, p6/z, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z8.d, p6/z, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z7.d, p0/z, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z7.d, p0/z, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z7.d, p9/z, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z7.d, p9/z, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z11.d, p1/z, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z11.d, p1/z, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z0.d, p4/z, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: cpy z0.d, p4/z, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z8.b, p2/m, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: cpy z8.b, p2/m, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z12.b, p2/m, #256
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: cpy z12.b, p2/m, #256
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z8.b, p5/m, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: cpy z8.b, p5/m, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z6.b, p8/m, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: cpy z6.b, p8/m, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z3.b, p10/m, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: cpy z3.b, p10/m, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z28.b, p8/z, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: cpy z28.b, p8/z, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z0.b, p11/z, #256
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: cpy z0.b, p11/z, #256
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z17.b, p10/z, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: cpy z17.b, p10/z, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z2.b, p8/z, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: cpy z2.b, p8/z, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
cpy z19.b, p12/z, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: cpy z19.b, p12/z, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cpy z28.h, p8/m, w27
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: cpy z28.h, p8/m, w27
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cpy z7.s, p8/m, w9
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: cpy z7.s, p8/m, w9
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cpy z26.d, p8/m, x16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: cpy z26.d, p8/m, x16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cpy z22.b, p8/m, w28
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: cpy z22.b, p8/m, w28
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

