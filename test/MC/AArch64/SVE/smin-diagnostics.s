// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [-128, 127].
smin z7.h, z7.h, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smin z7.h, z7.h, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smin z19.h, z20.h, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smin z19.h, z20.h, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
smin z16.h, p8/m, z16.h, z8.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: smin z16.h, p8/m, z16.h, z8.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smin z12.h, p1/m, z13.h, z22.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smin z12.h, p1/m, z13.h, z22.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-128, 127].
smin z30.s, z30.s, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smin z30.s, z30.s, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 127].
smin z2.s, z2.s, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smin z2.s, z2.s, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smin z18.s, z19.s, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smin z18.s, z19.s, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
smin z10.s, p8/m, z10.s, z15.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: smin z10.s, p8/m, z10.s, z15.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smin z24.s, p6/m, z25.s, z18.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smin z24.s, p6/m, z25.s, z18.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-128, 127].
smin z29.d, z29.d, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smin z29.d, z29.d, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 127].
smin z15.d, z15.d, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smin z15.d, z15.d, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smin z26.d, z27.d, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smin z26.d, z27.d, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
smin z27.d, p8/m, z27.d, z16.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: smin z27.d, p8/m, z27.d, z16.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smin z2.d, p4/m, z3.d, z17.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smin z2.d, p4/m, z3.d, z17.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-128, 127].
smin z9.b, z9.b, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smin z9.b, z9.b, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 127].
smin z19.b, z19.b, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smin z19.b, z19.b, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smin z7.b, z8.b, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smin z7.b, z8.b, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
smin z14.b, p8/m, z14.b, z11.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: smin z14.b, p8/m, z14.b, z11.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smin z7.b, p5/m, z8.b, z0.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smin z7.b, p5/m, z8.b, z0.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

