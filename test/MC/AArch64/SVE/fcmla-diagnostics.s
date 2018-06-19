// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 3].
fcmla z6.h, z29.h, z5.h[-1], #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 3].
// CHECK-NEXT: fcmla z6.h, z29.h, z5.h[-1], #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 3].
fcmla z9.h, z8.h, z5.h[4], #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 3].
// CHECK-NEXT: fcmla z9.h, z8.h, z5.h[4], #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fcmla z12.h, p8/m, z18.h, z14.h, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmla z12.h, p8/m, z18.h, z14.h, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 1].
fcmla z21.s, z12.s, z12.s[-1], #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 1].
// CHECK-NEXT: fcmla z21.s, z12.s, z12.s[-1], #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 1].
fcmla z18.s, z2.s, z4.s[2], #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 1].
// CHECK-NEXT: fcmla z18.s, z2.s, z4.s[2], #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fcmla z21.s, p8/m, z1.s, z24.s, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmla z21.s, p8/m, z1.s, z24.s, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

