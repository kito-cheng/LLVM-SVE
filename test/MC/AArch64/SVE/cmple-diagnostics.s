// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [-16, 15].
cmple p8.h, p0/z, z24.h, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmple p8.h, p0/z, z24.h, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmple p0.h, p8/z, z14.h, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmple p0.h, p8/z, z14.h, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmple p10.h, p8/z, z6.h, z15.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmple p10.h, p8/z, z6.h, z15.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
cmple p4.s, p6/z, z3.s, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmple p4.s, p6/z, z3.s, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
cmple p1.s, p1/z, z15.s, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmple p1.s, p1/z, z15.s, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmple p5.s, p8/z, z13.s, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmple p5.s, p8/z, z13.s, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmple p0.s, p8/z, z7.s, z9.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmple p0.s, p8/z, z7.s, z9.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
cmple p13.d, p3/z, z29.d, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmple p13.d, p3/z, z29.d, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
cmple p2.d, p4/z, z4.d, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmple p2.d, p4/z, z4.d, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmple p7.d, p8/z, z24.d, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmple p7.d, p8/z, z24.d, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
cmple p11.b, p4/z, z27.b, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmple p11.b, p4/z, z27.b, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
cmple p6.b, p1/z, z12.b, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmple p6.b, p1/z, z12.b, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmple p0.b, p8/z, z11.b, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmple p0.b, p8/z, z11.b, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmple p11.b, p8/z, z7.b, z1.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmple p11.b, p8/z, z7.b, z1.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

