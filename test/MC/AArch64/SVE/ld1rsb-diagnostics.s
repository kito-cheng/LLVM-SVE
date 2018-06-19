// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 63].
ld1rsb z2.h, p0/z, [x19, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rsb z2.h, p0/z, [x19, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 63].
ld1rsb z1.h, p0/z, [x4, #64]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rsb z1.h, p0/z, [x4, #64]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rsb z27.s, p8/z, [x21, #53]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rsb z27.s, p8/z, [x21, #53]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 63].
ld1rsb z25.s, p5/z, [x14, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rsb z25.s, p5/z, [x14, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 63].
ld1rsb z12.s, p6/z, [x27, #64]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rsb z12.s, p6/z, [x27, #64]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rsb z13.d, p8/z, [x24, #39]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rsb z13.d, p8/z, [x24, #39]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 63].
ld1rsb z9.d, p3/z, [x2, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rsb z9.d, p3/z, [x2, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 63].
ld1rsb z22.d, p6/z, [x11, #64]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rsb z22.d, p6/z, [x11, #64]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

