// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
decw x18, pow2, MUL #17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [1, 16]
// CHECK-NEXT: decw x18, pow2, MUL #17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
decw z8.s, pow2, MUL #-1
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [1, 16]
// CHECK-NEXT: decw z8.s, pow2, MUL #-1
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
decw z14.s, pow2, MUL #17
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [1, 16]
// CHECK-NEXT: decw z14.s, pow2, MUL #17
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

