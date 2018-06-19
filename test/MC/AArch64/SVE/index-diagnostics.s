// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [-16, 15].
index z8.h, #16, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z8.h, #16, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z21.h, #-16, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z21.h, #-16, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z28.h, #-16, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z28.h, #-16, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z17.h, #-17, w18
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z17.h, #-17, w18
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z25.h, #16, w11
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z25.h, #16, w11
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z24.h, w19, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z24.h, w19, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z9.h, w17, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z9.h, w17, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z16.s, #-17, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z16.s, #-17, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z30.s, #16, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z30.s, #16, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z20.s, #-16, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z20.s, #-16, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z20.s, #-16, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z20.s, #-16, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z13.s, #-17, w9
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z13.s, #-17, w9
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z13.s, #16, w20
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z13.s, #16, w20
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z24.s, w5, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z24.s, w5, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z2.s, w18, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z2.s, w18, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z15.d, #-17, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z15.d, #-17, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z23.d, #16, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z23.d, #16, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z28.d, #-16, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z28.d, #-16, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z28.d, #-16, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z28.d, #-16, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z10.d, #-17, x6
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z10.d, #-17, x6
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z6.d, #16, x4
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z6.d, #16, x4
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z3.d, x24, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z3.d, x24, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z5.d, x0, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z5.d, x0, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z27.b, #-17, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z27.b, #-17, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z19.b, #16, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z19.b, #16, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z11.b, #-16, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z11.b, #-16, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z2.b, #-16, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z2.b, #-16, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z4.b, #-17, w28
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z4.b, #-17, w28
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z9.b, #16, w23
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z9.b, #16, w23
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
index z3.b, w10, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z3.b, w10, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
index z17.b, w9, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: index z17.b, w9, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

