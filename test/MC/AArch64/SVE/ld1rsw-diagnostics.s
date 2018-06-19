// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 252].
ld1rsw z30.d, p3/z, [x14, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 252].
// CHECK-NEXT: ld1rsw z30.d, p3/z, [x14, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 252].
ld1rsw z29.d, p2/z, [x22, #253]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 252].
// CHECK-NEXT: ld1rsw z29.d, p2/z, [x22, #253]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

