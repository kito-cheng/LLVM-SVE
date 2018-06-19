// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqdecd  x0, pow2  // 00000100-11110000-11111000-00000000
// CHECK: sqdecd  x0, pow2 // encoding: [0x00,0xf8,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11111000-00000000
SQDECD  X0, POW2  // 00000100-11110000-11111000-00000000
// CHECK: sqdecd  x0, pow2 // encoding: [0x00,0xf8,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11111000-00000000
sqdecd  x0, w0, pow2  // 00000100-11100000-11111000-00000000
// CHECK: sqdecd  x0, w0, pow2 // encoding: [0x00,0xf8,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11111000-00000000
SQDECD  X0, W0, POW2  // 00000100-11100000-11111000-00000000
// CHECK: sqdecd  x0, w0, pow2 // encoding: [0x00,0xf8,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11111000-00000000
sqdecd  z21.d, vl32, mul #6  // 00000100-11100101-11001001-01010101
// CHECK: sqdecd  z21.d, vl32, mul #6 // encoding: [0x55,0xc9,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11001001-01010101
SQDECD  Z21.D, VL32, MUL #6  // 00000100-11100101-11001001-01010101
// CHECK: sqdecd  z21.d, vl32, mul #6 // encoding: [0x55,0xc9,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11001001-01010101
sqdecd  z31.d, all, mul #16  // 00000100-11101111-11001011-11111111
// CHECK: sqdecd  z31.d, all, mul #16 // encoding: [0xff,0xcb,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11001011-11111111
SQDECD  Z31.D, ALL, MUL #16  // 00000100-11101111-11001011-11111111
// CHECK: sqdecd  z31.d, all, mul #16 // encoding: [0xff,0xcb,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11001011-11111111
sqdecd  x23, w23, vl256, mul #9  // 00000100-11101000-11111001-10110111
// CHECK: sqdecd  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf9,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11111001-10110111
SQDECD  X23, W23, VL256, MUL #9  // 00000100-11101000-11111001-10110111
// CHECK: sqdecd  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf9,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11111001-10110111
sqdecd  x21, vl32, mul #6  // 00000100-11110101-11111001-01010101
// CHECK: sqdecd  x21, vl32, mul #6 // encoding: [0x55,0xf9,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11111001-01010101
SQDECD  X21, VL32, MUL #6  // 00000100-11110101-11111001-01010101
// CHECK: sqdecd  x21, vl32, mul #6 // encoding: [0x55,0xf9,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11111001-01010101
sqdecd  xzr, all, mul #16  // 00000100-11111111-11111011-11111111
// CHECK: sqdecd  xzr, all, mul #16 // encoding: [0xff,0xfb,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11111011-11111111
SQDECD  XZR, ALL, MUL #16  // 00000100-11111111-11111011-11111111
// CHECK: sqdecd  xzr, all, mul #16 // encoding: [0xff,0xfb,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11111011-11111111
sqdecd  x21, w21, vl32, mul #6  // 00000100-11100101-11111001-01010101
// CHECK: sqdecd  x21, w21, vl32, mul #6 // encoding: [0x55,0xf9,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11111001-01010101
SQDECD  X21, W21, VL32, MUL #6  // 00000100-11100101-11111001-01010101
// CHECK: sqdecd  x21, w21, vl32, mul #6 // encoding: [0x55,0xf9,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11111001-01010101
sqdecd  z23.d, vl256, mul #9  // 00000100-11101000-11001001-10110111
// CHECK: sqdecd  z23.d, vl256, mul #9 // encoding: [0xb7,0xc9,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11001001-10110111
SQDECD  Z23.D, VL256, MUL #9  // 00000100-11101000-11001001-10110111
// CHECK: sqdecd  z23.d, vl256, mul #9 // encoding: [0xb7,0xc9,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11001001-10110111
sqdecd  z0.d, pow2  // 00000100-11100000-11001000-00000000
// CHECK: sqdecd  z0.d, pow2 // encoding: [0x00,0xc8,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11001000-00000000
SQDECD  Z0.D, POW2  // 00000100-11100000-11001000-00000000
// CHECK: sqdecd  z0.d, pow2 // encoding: [0x00,0xc8,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11001000-00000000
sqdecd  x23, vl256, mul #9  // 00000100-11111000-11111001-10110111
// CHECK: sqdecd  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11111001-10110111
SQDECD  X23, VL256, MUL #9  // 00000100-11111000-11111001-10110111
// CHECK: sqdecd  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11111001-10110111
sqdecd  xzr, wzr, all, mul #16  // 00000100-11101111-11111011-11111111
// CHECK: sqdecd  xzr, wzr, all, mul #16 // encoding: [0xff,0xfb,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11111011-11111111
SQDECD  XZR, WZR, ALL, MUL #16  // 00000100-11101111-11111011-11111111
// CHECK: sqdecd  xzr, wzr, all, mul #16 // encoding: [0xff,0xfb,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11111011-11111111
