// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 504].
ld1rd z3.d, p4/z, [x8, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 8 in range [0, 504].
// CHECK-NEXT: ld1rd z3.d, p4/z, [x8, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 504].
ld1rd z19.d, p1/z, [x4, #505]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 8 in range [0, 504].
// CHECK-NEXT: ld1rd z19.d, p1/z, [x4, #505]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

