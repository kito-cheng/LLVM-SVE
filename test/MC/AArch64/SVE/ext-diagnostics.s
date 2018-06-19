// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [0, 255].
ext z12.b, z12.b, z21.b, #256
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 255].
// CHECK-NEXT: ext z12.b, z12.b, z21.b, #256
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
ext z17.b, z18.b, z21.b, #0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: ext z17.b, z18.b, z21.b, #0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

