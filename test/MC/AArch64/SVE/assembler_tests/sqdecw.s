// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqdecw  x21, w21, vl32, mul #6  // 00000100-10100101-11111001-01010101
// CHECK: sqdecw  x21, w21, vl32, mul #6 // encoding: [0x55,0xf9,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11111001-01010101
SQDECW  X21, W21, VL32, MUL #6  // 00000100-10100101-11111001-01010101
// CHECK: sqdecw  x21, w21, vl32, mul #6 // encoding: [0x55,0xf9,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11111001-01010101
sqdecw  x21, vl32, mul #6  // 00000100-10110101-11111001-01010101
// CHECK: sqdecw  x21, vl32, mul #6 // encoding: [0x55,0xf9,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11111001-01010101
SQDECW  X21, VL32, MUL #6  // 00000100-10110101-11111001-01010101
// CHECK: sqdecw  x21, vl32, mul #6 // encoding: [0x55,0xf9,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11111001-01010101
sqdecw  x23, vl256, mul #9  // 00000100-10111000-11111001-10110111
// CHECK: sqdecw  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11111001-10110111
SQDECW  X23, VL256, MUL #9  // 00000100-10111000-11111001-10110111
// CHECK: sqdecw  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11111001-10110111
sqdecw  z31.s, all, mul #16  // 00000100-10101111-11001011-11111111
// CHECK: sqdecw  z31.s, all, mul #16 // encoding: [0xff,0xcb,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11001011-11111111
SQDECW  Z31.S, ALL, MUL #16  // 00000100-10101111-11001011-11111111
// CHECK: sqdecw  z31.s, all, mul #16 // encoding: [0xff,0xcb,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11001011-11111111
sqdecw  x0, pow2  // 00000100-10110000-11111000-00000000
// CHECK: sqdecw  x0, pow2 // encoding: [0x00,0xf8,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11111000-00000000
SQDECW  X0, POW2  // 00000100-10110000-11111000-00000000
// CHECK: sqdecw  x0, pow2 // encoding: [0x00,0xf8,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11111000-00000000
sqdecw  x23, w23, vl256, mul #9  // 00000100-10101000-11111001-10110111
// CHECK: sqdecw  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf9,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11111001-10110111
SQDECW  X23, W23, VL256, MUL #9  // 00000100-10101000-11111001-10110111
// CHECK: sqdecw  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf9,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11111001-10110111
sqdecw  z21.s, vl32, mul #6  // 00000100-10100101-11001001-01010101
// CHECK: sqdecw  z21.s, vl32, mul #6 // encoding: [0x55,0xc9,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11001001-01010101
SQDECW  Z21.S, VL32, MUL #6  // 00000100-10100101-11001001-01010101
// CHECK: sqdecw  z21.s, vl32, mul #6 // encoding: [0x55,0xc9,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11001001-01010101
sqdecw  xzr, wzr, all, mul #16  // 00000100-10101111-11111011-11111111
// CHECK: sqdecw  xzr, wzr, all, mul #16 // encoding: [0xff,0xfb,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11111011-11111111
SQDECW  XZR, WZR, ALL, MUL #16  // 00000100-10101111-11111011-11111111
// CHECK: sqdecw  xzr, wzr, all, mul #16 // encoding: [0xff,0xfb,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11111011-11111111
sqdecw  x0, w0, pow2  // 00000100-10100000-11111000-00000000
// CHECK: sqdecw  x0, w0, pow2 // encoding: [0x00,0xf8,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11111000-00000000
SQDECW  X0, W0, POW2  // 00000100-10100000-11111000-00000000
// CHECK: sqdecw  x0, w0, pow2 // encoding: [0x00,0xf8,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11111000-00000000
sqdecw  z23.s, vl256, mul #9  // 00000100-10101000-11001001-10110111
// CHECK: sqdecw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc9,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11001001-10110111
SQDECW  Z23.S, VL256, MUL #9  // 00000100-10101000-11001001-10110111
// CHECK: sqdecw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc9,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11001001-10110111
sqdecw  xzr, all, mul #16  // 00000100-10111111-11111011-11111111
// CHECK: sqdecw  xzr, all, mul #16 // encoding: [0xff,0xfb,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11111011-11111111
SQDECW  XZR, ALL, MUL #16  // 00000100-10111111-11111011-11111111
// CHECK: sqdecw  xzr, all, mul #16 // encoding: [0xff,0xfb,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11111011-11111111
sqdecw  z0.s, pow2  // 00000100-10100000-11001000-00000000
// CHECK: sqdecw  z0.s, pow2 // encoding: [0x00,0xc8,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11001000-00000000
SQDECW  Z0.S, POW2  // 00000100-10100000-11001000-00000000
// CHECK: sqdecw  z0.s, pow2 // encoding: [0x00,0xc8,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11001000-00000000
