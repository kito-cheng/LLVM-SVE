// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 127].
cmplo p6.h, p0/z, z11.h, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmplo p6.h, p0/z, z11.h, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmplo p11.h, p6/z, z4.h, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmplo p11.h, p6/z, z4.h, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplo p9.h, p8/z, z19.h, z25.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplo p9.h, p8/z, z19.h, z25.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplo p12.s, p8/z, z27.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplo p12.s, p8/z, z27.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmplo p7.s, p2/z, z29.s, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmplo p7.s, p2/z, z29.s, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmplo p4.s, p1/z, z3.s, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmplo p4.s, p1/z, z3.s, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplo p11.s, p8/z, z24.s, z28.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplo p11.s, p8/z, z24.s, z28.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplo p11.d, p8/z, z2.d, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplo p11.d, p8/z, z2.d, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmplo p4.d, p6/z, z16.d, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmplo p4.d, p6/z, z16.d, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmplo p0.d, p3/z, z24.d, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmplo p0.d, p3/z, z24.d, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplo p14.b, p8/z, z24.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplo p14.b, p8/z, z24.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmplo p11.b, p6/z, z4.b, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmplo p11.b, p6/z, z4.b, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmplo p4.b, p2/z, z19.b, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmplo p4.b, p2/z, z19.b, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplo p5.b, p8/z, z21.b, z11.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplo p5.b, p8/z, z21.b, z11.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

