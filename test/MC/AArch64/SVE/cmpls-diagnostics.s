// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 127].
cmpls p2.h, p2/z, z3.h, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmpls p2.h, p2/z, z3.h, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmpls p11.h, p3/z, z30.h, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmpls p11.h, p3/z, z30.h, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpls p12.h, p8/z, z0.h, z4.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpls p12.h, p8/z, z0.h, z4.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpls p7.s, p8/z, z17.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpls p7.s, p8/z, z17.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmpls p14.s, p3/z, z12.s, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmpls p14.s, p3/z, z12.s, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmpls p14.s, p5/z, z28.s, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmpls p14.s, p5/z, z28.s, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpls p4.s, p8/z, z30.s, z0.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpls p4.s, p8/z, z30.s, z0.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpls p4.d, p8/z, z3.d, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpls p4.d, p8/z, z3.d, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmpls p11.d, p5/z, z17.d, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmpls p11.d, p5/z, z17.d, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmpls p0.d, p2/z, z3.d, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmpls p0.d, p2/z, z3.d, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpls p10.b, p8/z, z16.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpls p10.b, p8/z, z16.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmpls p9.b, p4/z, z2.b, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmpls p9.b, p4/z, z2.b, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmpls p0.b, p0/z, z26.b, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmpls p0.b, p0/z, z26.b, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpls p5.b, p8/z, z25.b, z8.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpls p5.b, p8/z, z25.b, z8.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

