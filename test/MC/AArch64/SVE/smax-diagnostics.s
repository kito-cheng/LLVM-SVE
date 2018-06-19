// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [-128, 127].
smax z8.h, z8.h, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smax z8.h, z8.h, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smax z11.h, z12.h, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smax z11.h, z12.h, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
smax z4.h, p8/m, z4.h, z18.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: smax z4.h, p8/m, z4.h, z18.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smax z6.h, p0/m, z7.h, z18.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smax z6.h, p0/m, z7.h, z18.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-128, 127].
smax z17.s, z17.s, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smax z17.s, z17.s, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 127].
smax z13.s, z13.s, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smax z13.s, z13.s, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smax z16.s, z17.s, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smax z16.s, z17.s, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
smax z15.s, p8/m, z15.s, z14.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: smax z15.s, p8/m, z15.s, z14.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smax z1.s, p5/m, z2.s, z26.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smax z1.s, p5/m, z2.s, z26.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-128, 127].
smax z1.d, z1.d, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smax z1.d, z1.d, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 127].
smax z12.d, z12.d, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smax z12.d, z12.d, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smax z17.d, z18.d, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smax z17.d, z18.d, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
smax z8.d, p8/m, z8.d, z27.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: smax z8.d, p8/m, z8.d, z27.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smax z23.d, p2/m, z24.d, z18.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smax z23.d, p2/m, z24.d, z18.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-128, 127].
smax z2.b, z2.b, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smax z2.b, z2.b, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 127].
smax z14.b, z14.b, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: smax z14.b, z14.b, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smax z9.b, z10.b, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smax z9.b, z10.b, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
smax z3.b, p8/m, z3.b, z4.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: smax z3.b, p8/m, z3.b, z4.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
smax z29.b, p3/m, z30.b, z27.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: smax z29.b, p3/m, z30.b, z27.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

