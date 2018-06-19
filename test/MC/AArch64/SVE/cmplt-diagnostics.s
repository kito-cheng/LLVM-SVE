// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [-16, 15].
cmplt p5.h, p1/z, z27.h, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmplt p5.h, p1/z, z27.h, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplt p4.h, p8/z, z22.h, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplt p4.h, p8/z, z22.h, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplt p14.h, p8/z, z20.h, z26.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplt p14.h, p8/z, z20.h, z26.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
cmplt p8.s, p6/z, z12.s, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmplt p8.s, p6/z, z12.s, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
cmplt p10.s, p1/z, z0.s, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmplt p10.s, p1/z, z0.s, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplt p2.s, p8/z, z12.s, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplt p2.s, p8/z, z12.s, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplt p8.s, p8/z, z18.s, z5.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplt p8.s, p8/z, z18.s, z5.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
cmplt p11.d, p6/z, z14.d, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmplt p11.d, p6/z, z14.d, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
cmplt p12.d, p3/z, z8.d, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmplt p12.d, p3/z, z8.d, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplt p8.d, p8/z, z21.d, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplt p8.d, p8/z, z21.d, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 15].
cmplt p14.b, p2/z, z21.b, #-17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmplt p14.b, p2/z, z21.b, #-17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 15].
cmplt p13.b, p5/z, z28.b, #16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-16, 15].
// CHECK-NEXT: cmplt p13.b, p5/z, z28.b, #16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplt p10.b, p8/z, z29.b, #-16
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplt p10.b, p8/z, z29.b, #-16
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
cmplt p11.b, p8/z, z29.b, z15.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: cmplt p11.b, p8/z, z29.b, z15.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

