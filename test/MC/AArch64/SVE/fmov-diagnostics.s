// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
fmov z18.d, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z18.d, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z21.d, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z21.d, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z21.d, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z21.d, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z1.d, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z1.d, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z24.d, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z24.d, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z10.d, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z10.d, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z17.d, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z17.d, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z12.d, #0.2
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z12.d, #0.2
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z15.d, #0.4
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z15.d, #0.4
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z15.d, p13/m, #0.1128125
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z15.d, p13/m, #0.1128125
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z3.d, p13/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z3.d, p13/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z5.d, p2/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z5.d, p2/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z28.d, p3/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z28.d, p3/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z15.d, p10/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z15.d, p10/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z8.d, p14/m, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z8.d, p14/m, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z11.d, p1/m, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z11.d, p1/m, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z6.d, p9/m, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z6.d, p9/m, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z11.d, p2/m, #0.2
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z11.d, p2/m, #0.2
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z10.d, p3/m, #0.4
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z10.d, p3/m, #0.4
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z12.h, #0.1128125
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z12.h, #0.1128125
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z1.h, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z1.h, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z19.h, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z19.h, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z8.h, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z8.h, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z20.h, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z20.h, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z15.h, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z15.h, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z14.h, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z14.h, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z30.h, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z30.h, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z8.h, #0.2
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z8.h, #0.2
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z1.h, #0.4
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z1.h, #0.4
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z18.h, p12/m, #0.1128125
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z18.h, p12/m, #0.1128125
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z18.h, p5/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z18.h, p5/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z19.h, p14/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z19.h, p14/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z27.h, p2/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z27.h, p2/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z12.h, p1/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z12.h, p1/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z11.h, p5/m, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z11.h, p5/m, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z24.h, p9/m, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z24.h, p9/m, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z25.h, p3/m, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z25.h, p3/m, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z25.h, p10/m, #0.2
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z25.h, p10/m, #0.2
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z7.h, p8/m, #0.4
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z7.h, p8/m, #0.4
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z2.s, #0.1128125
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z2.s, #0.1128125
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z5.s, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z5.s, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z1.s, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z1.s, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z13.s, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z13.s, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z24.s, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z24.s, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z28.s, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z28.s, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z5.s, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z5.s, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z25.s, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z25.s, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z9.s, #0.2
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z9.s, #0.2
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z4.s, #0.4
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z4.s, #0.4
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z12.s, p2/m, #0.1128125
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z12.s, p2/m, #0.1128125
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z20.s, p0/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z20.s, p0/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z8.s, p2/m, #32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z8.s, p2/m, #32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z19.s, p5/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z19.s, p5/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z8.s, p3/m, #-32.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z8.s, p3/m, #-32.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z4.s, p3/m, #-0.11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z4.s, p3/m, #-0.11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z12.s, p7/m, #256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z12.s, p7/m, #256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z27.s, p7/m, #-256.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z27.s, p7/m, #-256.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z7.s, p12/m, #0.2
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z7.s, p12/m, #0.2
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
fmov z0.s, p14/m, #0.4
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or floating-point constant
// CHECK-NEXT: fmov z0.s, p14/m, #0.4
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

