// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
incd    xzr, all, mul #16  // 00000100-11111111-11100011-11111111
// CHECK: incd    xzr, all, mul #16 // encoding: [0xff,0xe3,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11100011-11111111
INCD    XZR, ALL, MUL #16  // 00000100-11111111-11100011-11111111
// CHECK: incd    xzr, all, mul #16 // encoding: [0xff,0xe3,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11100011-11111111
incd    z31.d, all, mul #16  // 00000100-11111111-11000011-11111111
// CHECK: incd    z31.d, all, mul #16 // encoding: [0xff,0xc3,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11000011-11111111
INCD    Z31.D, ALL, MUL #16  // 00000100-11111111-11000011-11111111
// CHECK: incd    z31.d, all, mul #16 // encoding: [0xff,0xc3,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11000011-11111111
incd    x0, pow2  // 00000100-11110000-11100000-00000000
// CHECK: incd    x0, pow2 // encoding: [0x00,0xe0,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11100000-00000000
INCD    X0, POW2  // 00000100-11110000-11100000-00000000
// CHECK: incd    x0, pow2 // encoding: [0x00,0xe0,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11100000-00000000
incd    x21, vl32, mul #6  // 00000100-11110101-11100001-01010101
// CHECK: incd    x21, vl32, mul #6 // encoding: [0x55,0xe1,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11100001-01010101
INCD    X21, VL32, MUL #6  // 00000100-11110101-11100001-01010101
// CHECK: incd    x21, vl32, mul #6 // encoding: [0x55,0xe1,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11100001-01010101
incd    z0.d, pow2  // 00000100-11110000-11000000-00000000
// CHECK: incd    z0.d, pow2 // encoding: [0x00,0xc0,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11000000-00000000
INCD    Z0.D, POW2  // 00000100-11110000-11000000-00000000
// CHECK: incd    z0.d, pow2 // encoding: [0x00,0xc0,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11000000-00000000
incd    z23.d, vl256, mul #9  // 00000100-11111000-11000001-10110111
// CHECK: incd    z23.d, vl256, mul #9 // encoding: [0xb7,0xc1,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11000001-10110111
INCD    Z23.D, VL256, MUL #9  // 00000100-11111000-11000001-10110111
// CHECK: incd    z23.d, vl256, mul #9 // encoding: [0xb7,0xc1,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11000001-10110111
incd    z21.d, vl32, mul #6  // 00000100-11110101-11000001-01010101
// CHECK: incd    z21.d, vl32, mul #6 // encoding: [0x55,0xc1,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11000001-01010101
INCD    Z21.D, VL32, MUL #6  // 00000100-11110101-11000001-01010101
// CHECK: incd    z21.d, vl32, mul #6 // encoding: [0x55,0xc1,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11000001-01010101
incd    x23, vl256, mul #9  // 00000100-11111000-11100001-10110111
// CHECK: incd    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11100001-10110111
INCD    X23, VL256, MUL #9  // 00000100-11111000-11100001-10110111
// CHECK: incd    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11100001-10110111
