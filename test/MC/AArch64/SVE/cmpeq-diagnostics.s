// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [-16, 15].
cmpeq p9.h, p2/z, z15.h, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmpeq p9.h, p2/z, z15.h, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p11.h, p8/z, z10.h, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p11.h, p8/z, z10.h, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p5.h, p8/z, z17.h, z28.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p5.h, p8/z, z17.h, z28.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p14.h, p8/z, z19.h, z24.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p14.h, p8/z, z19.h, z24.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
cmpeq p3.s, p6/z, z13.s, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmpeq p3.s, p6/z, z13.s, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
cmpeq p8.s, p4/z, z8.s, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmpeq p8.s, p4/z, z8.s, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p11.s, p8/z, z1.s, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p11.s, p8/z, z1.s, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p13.s, p8/z, z14.s, z14.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p13.s, p8/z, z14.s, z14.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p2.s, p8/z, z14.s, z19.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p2.s, p8/z, z14.s, z19.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
cmpeq p5.d, p2/z, z26.d, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmpeq p5.d, p2/z, z26.d, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
cmpeq p7.d, p2/z, z10.d, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmpeq p7.d, p2/z, z10.d, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p3.d, p8/z, z7.d, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p3.d, p8/z, z7.d, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p4.d, p8/z, z14.d, z20.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p4.d, p8/z, z14.d, z20.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
cmpeq p5.b, p5/z, z22.b, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmpeq p5.b, p5/z, z22.b, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
cmpeq p3.b, p3/z, z2.b, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmpeq p3.b, p3/z, z2.b, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p10.b, p8/z, z25.b, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p10.b, p8/z, z25.b, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p6.b, p8/z, z17.b, z2.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p6.b, p8/z, z17.b, z2.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmpeq p0.b, p8/z, z28.b, z19.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmpeq p0.b, p8/z, z28.b, z19.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

