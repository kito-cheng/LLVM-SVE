// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqincw  z21.s, vl32, mul #6  // 00000100-10100101-11000001-01010101
// CHECK: sqincw  z21.s, vl32, mul #6 // encoding: [0x55,0xc1,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11000001-01010101
SQINCW  Z21.S, VL32, MUL #6  // 00000100-10100101-11000001-01010101
// CHECK: sqincw  z21.s, vl32, mul #6 // encoding: [0x55,0xc1,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11000001-01010101
sqincw  xzr, wzr, all, mul #16  // 00000100-10101111-11110011-11111111
// CHECK: sqincw  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11110011-11111111
SQINCW  XZR, WZR, ALL, MUL #16  // 00000100-10101111-11110011-11111111
// CHECK: sqincw  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11110011-11111111
sqincw  z0.s, pow2  // 00000100-10100000-11000000-00000000
// CHECK: sqincw  z0.s, pow2 // encoding: [0x00,0xc0,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11000000-00000000
SQINCW  Z0.S, POW2  // 00000100-10100000-11000000-00000000
// CHECK: sqincw  z0.s, pow2 // encoding: [0x00,0xc0,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11000000-00000000
sqincw  x23, vl256, mul #9  // 00000100-10111000-11110001-10110111
// CHECK: sqincw  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11110001-10110111
SQINCW  X23, VL256, MUL #9  // 00000100-10111000-11110001-10110111
// CHECK: sqincw  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11110001-10110111
sqincw  x21, vl32, mul #6  // 00000100-10110101-11110001-01010101
// CHECK: sqincw  x21, vl32, mul #6 // encoding: [0x55,0xf1,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11110001-01010101
SQINCW  X21, VL32, MUL #6  // 00000100-10110101-11110001-01010101
// CHECK: sqincw  x21, vl32, mul #6 // encoding: [0x55,0xf1,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11110001-01010101
sqincw  z31.s, all, mul #16  // 00000100-10101111-11000011-11111111
// CHECK: sqincw  z31.s, all, mul #16 // encoding: [0xff,0xc3,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11000011-11111111
SQINCW  Z31.S, ALL, MUL #16  // 00000100-10101111-11000011-11111111
// CHECK: sqincw  z31.s, all, mul #16 // encoding: [0xff,0xc3,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11000011-11111111
sqincw  x0, w0, pow2  // 00000100-10100000-11110000-00000000
// CHECK: sqincw  x0, w0, pow2 // encoding: [0x00,0xf0,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11110000-00000000
SQINCW  X0, W0, POW2  // 00000100-10100000-11110000-00000000
// CHECK: sqincw  x0, w0, pow2 // encoding: [0x00,0xf0,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11110000-00000000
sqincw  z23.s, vl256, mul #9  // 00000100-10101000-11000001-10110111
// CHECK: sqincw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc1,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11000001-10110111
SQINCW  Z23.S, VL256, MUL #9  // 00000100-10101000-11000001-10110111
// CHECK: sqincw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc1,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11000001-10110111
sqincw  x21, w21, vl32, mul #6  // 00000100-10100101-11110001-01010101
// CHECK: sqincw  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11110001-01010101
SQINCW  X21, W21, VL32, MUL #6  // 00000100-10100101-11110001-01010101
// CHECK: sqincw  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11110001-01010101
sqincw  xzr, all, mul #16  // 00000100-10111111-11110011-11111111
// CHECK: sqincw  xzr, all, mul #16 // encoding: [0xff,0xf3,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11110011-11111111
SQINCW  XZR, ALL, MUL #16  // 00000100-10111111-11110011-11111111
// CHECK: sqincw  xzr, all, mul #16 // encoding: [0xff,0xf3,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11110011-11111111
sqincw  x0, pow2  // 00000100-10110000-11110000-00000000
// CHECK: sqincw  x0, pow2 // encoding: [0x00,0xf0,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11110000-00000000
SQINCW  X0, POW2  // 00000100-10110000-11110000-00000000
// CHECK: sqincw  x0, pow2 // encoding: [0x00,0xf0,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11110000-00000000
sqincw  x23, w23, vl256, mul #9  // 00000100-10101000-11110001-10110111
// CHECK: sqincw  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11110001-10110111
SQINCW  X23, W23, VL256, MUL #9  // 00000100-10101000-11110001-10110111
// CHECK: sqincw  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11110001-10110111
