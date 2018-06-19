// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
fcpy z17.d, p8/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z17.d, p8/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z12.d, p4/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z12.d, p4/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z22.d, p13/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z22.d, p13/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z19.d, p11/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z19.d, p11/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z3.d, p7/m, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z3.d, p7/m, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z2.d, p1/m, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z2.d, p1/m, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z25.d, p12/m, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z25.d, p12/m, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z10.d, p14/m, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z10.d, p14/m, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z14.d, p8/m, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z14.d, p8/m, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z6.h, p1/m, #0.1128125
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z6.h, p1/m, #0.1128125
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z22.h, p8/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z22.h, p8/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z27.h, p10/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z27.h, p10/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z4.h, p9/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z4.h, p9/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z13.h, p7/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z13.h, p7/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z26.h, p7/m, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z26.h, p7/m, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z2.h, p11/m, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z2.h, p11/m, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z22.h, p5/m, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z22.h, p5/m, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z21.h, p0/m, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z21.h, p0/m, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z3.h, p9/m, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z3.h, p9/m, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z28.s, p4/m, #0.1128125
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z28.s, p4/m, #0.1128125
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z28.s, p12/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z28.s, p12/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z1.s, p11/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z1.s, p11/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z8.s, p14/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z8.s, p14/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z28.s, p10/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z28.s, p10/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z21.s, p3/m, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z21.s, p3/m, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z25.s, p2/m, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z25.s, p2/m, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z8.s, p8/m, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z8.s, p8/m, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z26.s, p5/m, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z26.s, p5/m, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fcpy z7.s, p9/m, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fcpy z7.s, p9/m, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

