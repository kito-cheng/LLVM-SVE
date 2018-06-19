// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// FIXME: This test is XFAILed because the test for 'z31.x' gives the wrong
// diagnostic ('invalid operand') rather than the specific error.

// Immediate not compatible with encode/decode function.
mov z18.b, b15, #64
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z18.b, b15, #64
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mov z23.b, p8/m, b14
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z23.b, p8/m, b14
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z26.d, d1, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z26.d, d1, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z25.d, d4, #64
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z25.d, d4, #64
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mov z28.d, p8/m, d25
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z28.d, p8/m, d25
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z6.s, s9, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z6.s, s9, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z22.s, s20, #64
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z22.s, s20, #64
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mov z14.s, p8/m, s26
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z14.s, p8/m, s26
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z10.h, h8, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z10.h, h8, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z18.h, h4, #64
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z18.h, h4, #64
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mov z13.h, p8/m, h6
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z13.h, p8/m, h6
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z28.q, q7, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z28.q, q7, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z27.q, q29, #64
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z27.q, q29, #64
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z9.h, #-130
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z9.h, #-130
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z17.h, #129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z17.h, #129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z8.h, #253
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z8.h, #253
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z20.h, #258
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z20.h, #258
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z28.h, #-32770
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z28.h, #-32770
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z22.h, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z22.h, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z29.h, p0/m, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z29.h, p0/m, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z4.h, p0/m, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z4.h, p0/m, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z16.h, p2/m, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z16.h, p2/m, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z18.h, p4/m, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z18.h, p4/m, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z26.h, p14/m, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z26.h, p14/m, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z18.h, p12/m, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z18.h, p12/m, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z5.h, p7/z, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z5.h, p7/z, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z13.h, p13/z, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z13.h, p13/z, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z10.h, p1/z, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z10.h, p1/z, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z27.h, p13/z, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z27.h, p13/z, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z23.h, p5/z, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z23.h, p5/z, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z15.h, p3/z, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z15.h, p3/z, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z3.s, #-130
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z3.s, #-130
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z19.s, #129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z19.s, #129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z21.s, #253
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z21.s, #253
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z18.s, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z18.s, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z10.s, #-32770
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z10.s, #-32770
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z0.s, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z0.s, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z21.s, p6/m, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z21.s, p6/m, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z22.s, p11/m, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z22.s, p11/m, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z12.s, p14/m, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z12.s, p14/m, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z24.s, p4/m, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z24.s, p4/m, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z24.s, p7/m, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z24.s, p7/m, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z10.s, p7/m, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z10.s, p7/m, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z20.s, p3/z, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z20.s, p3/z, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z29.s, p7/z, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z29.s, p7/z, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z1.s, p6/z, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z1.s, p6/z, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z30.s, p8/z, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z30.s, p8/z, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z3.s, p7/z, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z3.s, p7/z, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z12.s, p4/z, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z12.s, p4/z, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z5.d, #-130
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z5.d, #-130
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z9.d, #129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z9.d, #129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z16.d, #253
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z16.d, #253
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z19.d, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z19.d, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z19.d, #-32770
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z19.d, #-32770
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z17.d, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z17.d, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z24.d, p6/m, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z24.d, p6/m, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z8.d, p8/m, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z8.d, p8/m, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z30.d, p9/m, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z30.d, p9/m, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z22.d, p1/m, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z22.d, p1/m, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z27.d, p8/m, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z27.d, p8/m, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z12.d, p14/m, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z12.d, p14/m, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z13.d, p5/z, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z13.d, p5/z, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z19.d, p8/z, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z19.d, p8/z, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z10.d, p9/z, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z10.d, p9/z, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z25.d, p11/z, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z25.d, p11/z, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z22.d, p0/z, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z22.d, p0/z, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z8.d, p4/z, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z8.d, p4/z, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z25.d, #4010
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z25.d, #4010
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z29.d, #3008
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z29.d, #3008
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z4.d, #3520
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z4.d, #3520
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z26.d, #3776
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z26.d, #3776
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z6.d, #3904
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: mov z6.d, #3904
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z4.b, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z4.b, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z0.b, #256
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z0.b, #256
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z8.b, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z8.b, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z4.b, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z4.b, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z13.b, p13/m, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z13.b, p13/m, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z7.b, p12/m, #256
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z7.b, p12/m, #256
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z23.b, p13/m, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z23.b, p13/m, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z15.b, p12/m, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z15.b, p12/m, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z6.b, p9/z, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z6.b, p9/z, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z21.b, p14/z, #256
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z21.b, p14/z, #256
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z3.b, p7/z, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z3.b, p7/z, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z24.b, p9/z, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: mov z24.b, p9/z, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z17.q, z24.q[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 3].
// CHECK-NEXT: mov z17.q, z24.q[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z1.q, z23.q[16]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 3].
// CHECK-NEXT: mov z1.q, z23.q[16]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mov z29.h, p8/m, w8
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z29.h, p8/m, w8
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z26.h, z23.h[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 31].
// CHECK-NEXT: mov z26.h, z23.h[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z30.h, z20.h[128]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 31].
// CHECK-NEXT: mov z30.h, z20.h[128]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mov z0.s, p8/m, w30
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z0.s, p8/m, w30
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z24.s, z20.s[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 15].
// CHECK-NEXT: mov z24.s, z20.s[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z5.s, z30.s[64]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 15].
// CHECK-NEXT: mov z5.s, z30.s[64]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mov z0.d, p8/m, x15
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z0.d, p8/m, x15
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z16.d, z0.d[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 7].
// CHECK-NEXT: mov z16.d, z0.d[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z17.d, z26.d[32]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 7].
// CHECK-NEXT: mov z17.d, z26.d[32]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mov z28.b, p8/m, w26
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: mov z28.b, p8/m, w26
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z30.b, z15.b[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 63].
// CHECK-NEXT: mov z30.b, z15.b[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
mov z4.b, z25.b[256]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 63].
// CHECK-NEXT: mov z4.b, z25.b[256]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

