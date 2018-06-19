// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 252].
ld1rw z23.s, p2/z, [x11, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 252].
// CHECK-NEXT: ld1rw z23.s, p2/z, [x11, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 252].
ld1rw z8.s, p4/z, [x23, #253]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 252].
// CHECK-NEXT: ld1rw z8.s, p4/z, [x23, #253]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rw z25.d, p8/z, [x11, #34]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rw z25.d, p8/z, [x11, #34]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 252].
ld1rw z12.d, p6/z, [x3, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 252].
// CHECK-NEXT: ld1rw z12.d, p6/z, [x3, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 252].
ld1rw z16.d, p0/z, [x7, #253]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 252].
// CHECK-NEXT: ld1rw z16.d, p0/z, [x7, #253]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

