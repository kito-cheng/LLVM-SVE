// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 126].
ld1rh z27.h, p3/z, [x23, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 126].
// CHECK-NEXT: ld1rh z27.h, p3/z, [x23, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 126].
ld1rh z9.h, p4/z, [x1, #127]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 126].
// CHECK-NEXT: ld1rh z9.h, p4/z, [x1, #127]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rh z0.s, p8/z, [x5, #49]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rh z0.s, p8/z, [x5, #49]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 126].
ld1rh z22.s, p5/z, [x16, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 126].
// CHECK-NEXT: ld1rh z22.s, p5/z, [x16, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 126].
ld1rh z30.s, p2/z, [x8, #127]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 126].
// CHECK-NEXT: ld1rh z30.s, p2/z, [x8, #127]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rh z23.d, p8/z, [x10, #61]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rh z23.d, p8/z, [x10, #61]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 126].
ld1rh z20.d, p1/z, [x18, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 126].
// CHECK-NEXT: ld1rh z20.d, p1/z, [x18, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 126].
ld1rh z7.d, p1/z, [x5, #127]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 126].
// CHECK-NEXT: ld1rh z7.d, p1/z, [x5, #127]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

