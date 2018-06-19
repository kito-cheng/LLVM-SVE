// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
decw    z21.s, vl32, mul #6  // 00000100-10110101-11000101-01010101
// CHECK: decw    z21.s, vl32, mul #6 // encoding: [0x55,0xc5,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11000101-01010101
DECW    Z21.S, VL32, MUL #6  // 00000100-10110101-11000101-01010101
// CHECK: decw    z21.s, vl32, mul #6 // encoding: [0x55,0xc5,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11000101-01010101
decw    z31.s, all, mul #16  // 00000100-10111111-11000111-11111111
// CHECK: decw    z31.s, all, mul #16 // encoding: [0xff,0xc7,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11000111-11111111
DECW    Z31.S, ALL, MUL #16  // 00000100-10111111-11000111-11111111
// CHECK: decw    z31.s, all, mul #16 // encoding: [0xff,0xc7,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11000111-11111111
decw    x0, pow2  // 00000100-10110000-11100100-00000000
// CHECK: decw    x0, pow2 // encoding: [0x00,0xe4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11100100-00000000
DECW    X0, POW2  // 00000100-10110000-11100100-00000000
// CHECK: decw    x0, pow2 // encoding: [0x00,0xe4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11100100-00000000
decw    x23, vl256, mul #9  // 00000100-10111000-11100101-10110111
// CHECK: decw    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11100101-10110111
DECW    X23, VL256, MUL #9  // 00000100-10111000-11100101-10110111
// CHECK: decw    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11100101-10110111
decw    xzr, all, mul #16  // 00000100-10111111-11100111-11111111
// CHECK: decw    xzr, all, mul #16 // encoding: [0xff,0xe7,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11100111-11111111
DECW    XZR, ALL, MUL #16  // 00000100-10111111-11100111-11111111
// CHECK: decw    xzr, all, mul #16 // encoding: [0xff,0xe7,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11100111-11111111
decw    z0.s, pow2  // 00000100-10110000-11000100-00000000
// CHECK: decw    z0.s, pow2 // encoding: [0x00,0xc4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11000100-00000000
DECW    Z0.S, POW2  // 00000100-10110000-11000100-00000000
// CHECK: decw    z0.s, pow2 // encoding: [0x00,0xc4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11000100-00000000
decw    z23.s, vl256, mul #9  // 00000100-10111000-11000101-10110111
// CHECK: decw    z23.s, vl256, mul #9 // encoding: [0xb7,0xc5,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11000101-10110111
DECW    Z23.S, VL256, MUL #9  // 00000100-10111000-11000101-10110111
// CHECK: decw    z23.s, vl256, mul #9 // encoding: [0xb7,0xc5,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11000101-10110111
decw    x21, vl32, mul #6  // 00000100-10110101-11100101-01010101
// CHECK: decw    x21, vl32, mul #6 // encoding: [0x55,0xe5,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11100101-01010101
DECW    X21, VL32, MUL #6  // 00000100-10110101-11100101-01010101
// CHECK: decw    x21, vl32, mul #6 // encoding: [0x55,0xe5,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11100101-01010101
