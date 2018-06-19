// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [-256, 255].
str p0, [x12, #256, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-256, 255].
// CHECK-NEXT: str p0, [x12, #256, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-256, 255].
str z20, [x23, #-257, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-256, 255].
// CHECK-NEXT: str z20, [x23, #-257, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-256, 255].
str z27, [x7, #256, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-256, 255].
// CHECK-NEXT: str z27, [x7, #256, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

