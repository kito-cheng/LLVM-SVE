// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
dup z4.h, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z4.h, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z0.h, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z0.h, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z21.h, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z21.h, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z16.h, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z16.h, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z29.h, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z29.h, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z21.s, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z21.s, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z15.s, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z15.s, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z28.s, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z28.s, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z30.s, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z30.s, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z30.s, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z30.s, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z10.s, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z10.s, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z14.d, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z14.d, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z7.d, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z7.d, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z9.d, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z9.d, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z21.d, #255
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z21.d, #255
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z10.d, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z10.d, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z14.d, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 127] or a multiple of 256 in range [-32768, 32512]
// CHECK-NEXT: dup z14.d, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z28.b, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: dup z28.b, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z24.b, #256
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: dup z24.b, #256
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z9.b, #257
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: dup z9.b, #257
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z11.b, #-32769
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: dup z11.b, #-32769
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z14.b, #32513
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
// CHECK-NEXT: dup z14.b, #32513
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z22.q, z7.q[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 3].
// CHECK-NEXT: dup z22.q, z7.q[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z24.q, z21.q[16]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 3].
// CHECK-NEXT: dup z24.q, z21.q[16]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z16.h, z30.h[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 31].
// CHECK-NEXT: dup z16.h, z30.h[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z19.h, z23.h[128]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 31].
// CHECK-NEXT: dup z19.h, z23.h[128]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z1.s, z6.s[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 15].
// CHECK-NEXT: dup z1.s, z6.s[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z24.s, z3.s[64]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 15].
// CHECK-NEXT: dup z24.s, z3.s[64]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z5.d, z25.d[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 7].
// CHECK-NEXT: dup z5.d, z25.d[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z12.d, z28.d[32]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 7].
// CHECK-NEXT: dup z12.d, z28.d[32]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z6.b, z14.b[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 63].
// CHECK-NEXT: dup z6.b, z14.b[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dup z22.b, z1.b[256]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 63].
// CHECK-NEXT: dup z22.b, z1.b[256]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

