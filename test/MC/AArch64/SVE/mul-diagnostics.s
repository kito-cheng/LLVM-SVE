// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [-128, 127].
mul z3.h, z3.h, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: mul z3.h, z3.h, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
mul z7.h, z8.h, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: mul z7.h, z8.h, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mul z4.h, p8/m, z4.h, z7.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: mul z4.h, p8/m, z4.h, z7.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
mul z29.h, p3/m, z30.h, z20.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: mul z29.h, p3/m, z30.h, z20.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-128, 127].
mul z30.s, z30.s, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: mul z30.s, z30.s, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 127].
mul z19.s, z19.s, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: mul z19.s, z19.s, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
mul z10.s, z11.s, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: mul z10.s, z11.s, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mul z6.s, p8/m, z6.s, z22.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: mul z6.s, p8/m, z6.s, z22.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
mul z24.s, p0/m, z25.s, z25.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: mul z24.s, p0/m, z25.s, z25.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-128, 127].
mul z27.d, z27.d, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: mul z27.d, z27.d, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 127].
mul z30.d, z30.d, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: mul z30.d, z30.d, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
mul z8.d, z9.d, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: mul z8.d, z9.d, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mul z17.d, p8/m, z17.d, z17.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: mul z17.d, p8/m, z17.d, z17.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
mul z6.d, p6/m, z7.d, z11.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: mul z6.d, p6/m, z7.d, z11.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-128, 127].
mul z11.b, z11.b, #-129
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: mul z11.b, z11.b, #-129
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 127].
mul z23.b, z23.b, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-128, 127].
// CHECK-NEXT: mul z23.b, z23.b, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
mul z4.b, z5.b, #-128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: mul z4.b, z5.b, #-128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
mul z25.b, p8/m, z25.b, z9.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: mul z25.b, p8/m, z25.b, z9.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
mul z21.b, p5/m, z22.b, z30.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: mul z21.b, p5/m, z22.b, z30.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

