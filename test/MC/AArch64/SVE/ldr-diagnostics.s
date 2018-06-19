// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [-256, 255].
ldr p7, [x18, #256, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-256, 255].
// CHECK-NEXT: ldr p7, [x18, #256, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-256, 255].
ldr z29, [x30, #-257, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-256, 255].
// CHECK-NEXT: ldr z29, [x30, #-257, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-256, 255].
ldr z15, [x8, #256, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-256, 255].
// CHECK-NEXT: ldr z15, [x8, #256, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

