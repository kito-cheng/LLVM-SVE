// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqincw  x0, pow2  // 00000100-10110000-11110100-00000000
// CHECK: uqincw  x0, pow2 // encoding: [0x00,0xf4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11110100-00000000
UQINCW  X0, POW2  // 00000100-10110000-11110100-00000000
// CHECK: uqincw  x0, pow2 // encoding: [0x00,0xf4,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11110100-00000000
uqincw  w21, vl32, mul #6  // 00000100-10100101-11110101-01010101
// CHECK: uqincw  w21, vl32, mul #6 // encoding: [0x55,0xf5,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11110101-01010101
UQINCW  W21, VL32, MUL #6  // 00000100-10100101-11110101-01010101
// CHECK: uqincw  w21, vl32, mul #6 // encoding: [0x55,0xf5,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11110101-01010101
uqincw  z31.s, all, mul #16  // 00000100-10101111-11000111-11111111
// CHECK: uqincw  z31.s, all, mul #16 // encoding: [0xff,0xc7,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11000111-11111111
UQINCW  Z31.S, ALL, MUL #16  // 00000100-10101111-11000111-11111111
// CHECK: uqincw  z31.s, all, mul #16 // encoding: [0xff,0xc7,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11000111-11111111
uqincw  x23, vl256, mul #9  // 00000100-10111000-11110101-10110111
// CHECK: uqincw  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11110101-10110111
UQINCW  X23, VL256, MUL #9  // 00000100-10111000-11110101-10110111
// CHECK: uqincw  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11110101-10110111
uqincw  w23, vl256, mul #9  // 00000100-10101000-11110101-10110111
// CHECK: uqincw  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11110101-10110111
UQINCW  W23, VL256, MUL #9  // 00000100-10101000-11110101-10110111
// CHECK: uqincw  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11110101-10110111
uqincw  xzr, all, mul #16  // 00000100-10111111-11110111-11111111
// CHECK: uqincw  xzr, all, mul #16 // encoding: [0xff,0xf7,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11110111-11111111
UQINCW  XZR, ALL, MUL #16  // 00000100-10111111-11110111-11111111
// CHECK: uqincw  xzr, all, mul #16 // encoding: [0xff,0xf7,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11110111-11111111
uqincw  z21.s, vl32, mul #6  // 00000100-10100101-11000101-01010101
// CHECK: uqincw  z21.s, vl32, mul #6 // encoding: [0x55,0xc5,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11000101-01010101
UQINCW  Z21.S, VL32, MUL #6  // 00000100-10100101-11000101-01010101
// CHECK: uqincw  z21.s, vl32, mul #6 // encoding: [0x55,0xc5,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11000101-01010101
uqincw  z0.s, pow2  // 00000100-10100000-11000100-00000000
// CHECK: uqincw  z0.s, pow2 // encoding: [0x00,0xc4,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11000100-00000000
UQINCW  Z0.S, POW2  // 00000100-10100000-11000100-00000000
// CHECK: uqincw  z0.s, pow2 // encoding: [0x00,0xc4,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11000100-00000000
uqincw  x21, vl32, mul #6  // 00000100-10110101-11110101-01010101
// CHECK: uqincw  x21, vl32, mul #6 // encoding: [0x55,0xf5,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11110101-01010101
UQINCW  X21, VL32, MUL #6  // 00000100-10110101-11110101-01010101
// CHECK: uqincw  x21, vl32, mul #6 // encoding: [0x55,0xf5,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11110101-01010101
uqincw  z23.s, vl256, mul #9  // 00000100-10101000-11000101-10110111
// CHECK: uqincw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc5,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11000101-10110111
UQINCW  Z23.S, VL256, MUL #9  // 00000100-10101000-11000101-10110111
// CHECK: uqincw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc5,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11000101-10110111
uqincw  w0, pow2  // 00000100-10100000-11110100-00000000
// CHECK: uqincw  w0, pow2 // encoding: [0x00,0xf4,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11110100-00000000
UQINCW  W0, POW2  // 00000100-10100000-11110100-00000000
// CHECK: uqincw  w0, pow2 // encoding: [0x00,0xf4,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11110100-00000000
uqincw  wzr, all, mul #16  // 00000100-10101111-11110111-11111111
// CHECK: uqincw  wzr, all, mul #16 // encoding: [0xff,0xf7,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11110111-11111111
UQINCW  WZR, ALL, MUL #16  // 00000100-10101111-11110111-11111111
// CHECK: uqincw  wzr, all, mul #16 // encoding: [0xff,0xf7,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11110111-11111111
