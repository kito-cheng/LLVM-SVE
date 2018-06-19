// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 63].
ld1rb z22.h, p1/z, [x7, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rb z22.h, p1/z, [x7, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 63].
ld1rb z7.h, p6/z, [x2, #64]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rb z7.h, p6/z, [x2, #64]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rb z20.s, p8/z, [x19, #22]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rb z20.s, p8/z, [x19, #22]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 63].
ld1rb z29.s, p3/z, [x29, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rb z29.s, p3/z, [x29, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 63].
ld1rb z5.s, p3/z, [x30, #64]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rb z5.s, p3/z, [x30, #64]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rb z9.d, p8/z, [x23, #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rb z9.d, p8/z, [x23, #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 63].
ld1rb z28.d, p1/z, [x5, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rb z28.d, p1/z, [x5, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 63].
ld1rb z7.d, p2/z, [x8, #64]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rb z7.d, p2/z, [x8, #64]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rb z7.b, p8/z, [x9, #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rb z7.b, p8/z, [x9, #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 63].
ld1rb z4.b, p3/z, [x10, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rb z4.b, p3/z, [x10, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 63].
ld1rb z18.b, p6/z, [x25, #64]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be in range [0, 63].
// CHECK-NEXT: ld1rb z18.b, p6/z, [x25, #64]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

