// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 127].
cmphi p12.h, p6/z, z30.h, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphi p12.h, p6/z, z30.h, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmphi p13.h, p0/z, z22.h, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphi p13.h, p0/z, z22.h, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphi p11.h, p8/z, z27.h, z21.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphi p11.h, p8/z, z27.h, z21.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphi p5.h, p8/z, z16.h, z22.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphi p5.h, p8/z, z16.h, z22.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphi p14.s, p8/z, z30.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphi p14.s, p8/z, z30.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmphi p6.s, p1/z, z16.s, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphi p6.s, p1/z, z16.s, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmphi p1.s, p2/z, z30.s, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphi p1.s, p2/z, z30.s, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphi p10.s, p8/z, z4.s, z30.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphi p10.s, p8/z, z4.s, z30.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphi p1.s, p8/z, z7.s, z10.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphi p1.s, p8/z, z7.s, z10.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphi p1.d, p8/z, z0.d, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphi p1.d, p8/z, z0.d, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmphi p1.d, p3/z, z0.d, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphi p1.d, p3/z, z0.d, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmphi p1.d, p3/z, z20.d, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphi p1.d, p3/z, z20.d, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphi p5.d, p8/z, z1.d, z22.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphi p5.d, p8/z, z1.d, z22.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphi p0.b, p8/z, z11.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphi p0.b, p8/z, z11.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmphi p12.b, p4/z, z18.b, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphi p12.b, p4/z, z18.b, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmphi p3.b, p6/z, z19.b, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphi p3.b, p6/z, z19.b, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphi p12.b, p8/z, z24.b, z0.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphi p12.b, p8/z, z24.b, z0.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphi p4.b, p8/z, z23.b, z28.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphi p4.b, p8/z, z23.b, z28.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

