// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
fdup z8.d, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z8.d, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z8.d, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z8.d, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z5.d, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z5.d, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z2.d, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z2.d, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z5.d, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z5.d, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z11.d, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z11.d, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z16.d, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z16.d, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z0.d, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z0.d, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z1.d, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z1.d, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z4.h, #0.1128125
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z4.h, #0.1128125
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z3.h, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z3.h, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z13.h, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z13.h, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z22.h, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z22.h, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z15.h, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z15.h, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z18.h, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z18.h, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z22.h, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z22.h, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z9.h, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z9.h, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z29.h, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z29.h, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z1.h, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z1.h, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z18.s, #0.1128125
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z18.s, #0.1128125
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z12.s, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z12.s, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z24.s, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z24.s, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z15.s, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z15.s, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z26.s, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z26.s, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z11.s, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z11.s, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z16.s, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z16.s, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z27.s, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z27.s, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z19.s, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z19.s, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fdup z5.s, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fdup z5.s, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

