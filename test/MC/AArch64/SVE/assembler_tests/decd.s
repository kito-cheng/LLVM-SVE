// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
decd    z21.d, vl32, mul #6  // 00000100-11110101-11000101-01010101
// CHECK: decd    z21.d, vl32, mul #6 // encoding: [0x55,0xc5,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11000101-01010101
DECD    Z21.D, VL32, MUL #6  // 00000100-11110101-11000101-01010101
// CHECK: decd    z21.d, vl32, mul #6 // encoding: [0x55,0xc5,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11000101-01010101
decd    z0.d, pow2  // 00000100-11110000-11000100-00000000
// CHECK: decd    z0.d, pow2 // encoding: [0x00,0xc4,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11000100-00000000
DECD    Z0.D, POW2  // 00000100-11110000-11000100-00000000
// CHECK: decd    z0.d, pow2 // encoding: [0x00,0xc4,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11000100-00000000
decd    z31.d, all, mul #16  // 00000100-11111111-11000111-11111111
// CHECK: decd    z31.d, all, mul #16 // encoding: [0xff,0xc7,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11000111-11111111
DECD    Z31.D, ALL, MUL #16  // 00000100-11111111-11000111-11111111
// CHECK: decd    z31.d, all, mul #16 // encoding: [0xff,0xc7,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11000111-11111111
decd    x23, vl256, mul #9  // 00000100-11111000-11100101-10110111
// CHECK: decd    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11100101-10110111
DECD    X23, VL256, MUL #9  // 00000100-11111000-11100101-10110111
// CHECK: decd    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11100101-10110111
decd    z23.d, vl256, mul #9  // 00000100-11111000-11000101-10110111
// CHECK: decd    z23.d, vl256, mul #9 // encoding: [0xb7,0xc5,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11000101-10110111
DECD    Z23.D, VL256, MUL #9  // 00000100-11111000-11000101-10110111
// CHECK: decd    z23.d, vl256, mul #9 // encoding: [0xb7,0xc5,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11000101-10110111
decd    xzr, all, mul #16  // 00000100-11111111-11100111-11111111
// CHECK: decd    xzr, all, mul #16 // encoding: [0xff,0xe7,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11100111-11111111
DECD    XZR, ALL, MUL #16  // 00000100-11111111-11100111-11111111
// CHECK: decd    xzr, all, mul #16 // encoding: [0xff,0xe7,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11100111-11111111
decd    x21, vl32, mul #6  // 00000100-11110101-11100101-01010101
// CHECK: decd    x21, vl32, mul #6 // encoding: [0x55,0xe5,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11100101-01010101
DECD    X21, VL32, MUL #6  // 00000100-11110101-11100101-01010101
// CHECK: decd    x21, vl32, mul #6 // encoding: [0x55,0xe5,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11100101-01010101
decd    x0, pow2  // 00000100-11110000-11100100-00000000
// CHECK: decd    x0, pow2 // encoding: [0x00,0xe4,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11100100-00000000
DECD    X0, POW2  // 00000100-11110000-11100100-00000000
// CHECK: decd    x0, pow2 // encoding: [0x00,0xe4,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11100100-00000000
