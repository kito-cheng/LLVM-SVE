// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 127].
cmphs p0.h, p0/z, z9.h, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphs p0.h, p0/z, z9.h, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmphs p4.h, p4/z, z10.h, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphs p4.h, p4/z, z10.h, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphs p12.h, p8/z, z28.h, z23.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphs p12.h, p8/z, z28.h, z23.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphs p2.h, p8/z, z8.h, z22.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphs p2.h, p8/z, z8.h, z22.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphs p0.s, p8/z, z25.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphs p0.s, p8/z, z25.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmphs p12.s, p5/z, z13.s, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphs p12.s, p5/z, z13.s, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmphs p2.s, p1/z, z25.s, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphs p2.s, p1/z, z25.s, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphs p2.s, p8/z, z25.s, z29.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphs p2.s, p8/z, z25.s, z29.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphs p6.s, p8/z, z10.s, z23.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphs p6.s, p8/z, z10.s, z23.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphs p2.d, p8/z, z8.d, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphs p2.d, p8/z, z8.d, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmphs p9.d, p6/z, z24.d, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphs p9.d, p6/z, z24.d, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmphs p6.d, p6/z, z6.d, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphs p6.d, p6/z, z6.d, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphs p12.d, p8/z, z29.d, z17.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphs p12.d, p8/z, z29.d, z17.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphs p6.b, p8/z, z7.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphs p6.b, p8/z, z7.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 127].
cmphs p14.b, p0/z, z9.b, #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphs p14.b, p0/z, z9.b, #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 127].
cmphs p9.b, p0/z, z26.b, #128
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 127].
// CHECK-NEXT: cmphs p9.b, p0/z, z26.b, #128
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphs p3.b, p8/z, z16.b, z1.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphs p3.b, p8/z, z16.b, z1.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmphs p7.b, p8/z, z17.b, z7.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmphs p7.b, p8/z, z17.b, z7.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

