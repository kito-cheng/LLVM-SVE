// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 126].
ld1rsh z2.s, p5/z, [x13, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 126].
// CHECK-NEXT: ld1rsh z2.s, p5/z, [x13, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 126].
ld1rsh z2.s, p3/z, [x4, #127]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 126].
// CHECK-NEXT: ld1rsh z2.s, p3/z, [x4, #127]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rsh z9.d, p8/z, [x6, #34]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rsh z9.d, p8/z, [x6, #34]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 126].
ld1rsh z11.d, p5/z, [x0, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 126].
// CHECK-NEXT: ld1rsh z11.d, p5/z, [x0, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 126].
ld1rsh z3.d, p5/z, [x4, #127]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 126].
// CHECK-NEXT: ld1rsh z3.d, p5/z, [x4, #127]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

