// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqincd  w0, pow2  // 00000100-11100000-11110100-00000000
// CHECK: uqincd  w0, pow2 // encoding: [0x00,0xf4,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11110100-00000000
UQINCD  W0, POW2  // 00000100-11100000-11110100-00000000
// CHECK: uqincd  w0, pow2 // encoding: [0x00,0xf4,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11110100-00000000
uqincd  w23, vl256, mul #9  // 00000100-11101000-11110101-10110111
// CHECK: uqincd  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11110101-10110111
UQINCD  W23, VL256, MUL #9  // 00000100-11101000-11110101-10110111
// CHECK: uqincd  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11110101-10110111
uqincd  w21, vl32, mul #6  // 00000100-11100101-11110101-01010101
// CHECK: uqincd  w21, vl32, mul #6 // encoding: [0x55,0xf5,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11110101-01010101
UQINCD  W21, VL32, MUL #6  // 00000100-11100101-11110101-01010101
// CHECK: uqincd  w21, vl32, mul #6 // encoding: [0x55,0xf5,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11110101-01010101
uqincd  x21, vl32, mul #6  // 00000100-11110101-11110101-01010101
// CHECK: uqincd  x21, vl32, mul #6 // encoding: [0x55,0xf5,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11110101-01010101
UQINCD  X21, VL32, MUL #6  // 00000100-11110101-11110101-01010101
// CHECK: uqincd  x21, vl32, mul #6 // encoding: [0x55,0xf5,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11110101-01010101
uqincd  xzr, all, mul #16  // 00000100-11111111-11110111-11111111
// CHECK: uqincd  xzr, all, mul #16 // encoding: [0xff,0xf7,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11110111-11111111
UQINCD  XZR, ALL, MUL #16  // 00000100-11111111-11110111-11111111
// CHECK: uqincd  xzr, all, mul #16 // encoding: [0xff,0xf7,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11110111-11111111
uqincd  z0.d, pow2  // 00000100-11100000-11000100-00000000
// CHECK: uqincd  z0.d, pow2 // encoding: [0x00,0xc4,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11000100-00000000
UQINCD  Z0.D, POW2  // 00000100-11100000-11000100-00000000
// CHECK: uqincd  z0.d, pow2 // encoding: [0x00,0xc4,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11000100-00000000
uqincd  z21.d, vl32, mul #6  // 00000100-11100101-11000101-01010101
// CHECK: uqincd  z21.d, vl32, mul #6 // encoding: [0x55,0xc5,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11000101-01010101
UQINCD  Z21.D, VL32, MUL #6  // 00000100-11100101-11000101-01010101
// CHECK: uqincd  z21.d, vl32, mul #6 // encoding: [0x55,0xc5,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11000101-01010101
uqincd  x23, vl256, mul #9  // 00000100-11111000-11110101-10110111
// CHECK: uqincd  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11110101-10110111
UQINCD  X23, VL256, MUL #9  // 00000100-11111000-11110101-10110111
// CHECK: uqincd  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11110101-10110111
uqincd  z23.d, vl256, mul #9  // 00000100-11101000-11000101-10110111
// CHECK: uqincd  z23.d, vl256, mul #9 // encoding: [0xb7,0xc5,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11000101-10110111
UQINCD  Z23.D, VL256, MUL #9  // 00000100-11101000-11000101-10110111
// CHECK: uqincd  z23.d, vl256, mul #9 // encoding: [0xb7,0xc5,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11000101-10110111
uqincd  z31.d, all, mul #16  // 00000100-11101111-11000111-11111111
// CHECK: uqincd  z31.d, all, mul #16 // encoding: [0xff,0xc7,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11000111-11111111
UQINCD  Z31.D, ALL, MUL #16  // 00000100-11101111-11000111-11111111
// CHECK: uqincd  z31.d, all, mul #16 // encoding: [0xff,0xc7,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11000111-11111111
uqincd  wzr, all, mul #16  // 00000100-11101111-11110111-11111111
// CHECK: uqincd  wzr, all, mul #16 // encoding: [0xff,0xf7,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11110111-11111111
UQINCD  WZR, ALL, MUL #16  // 00000100-11101111-11110111-11111111
// CHECK: uqincd  wzr, all, mul #16 // encoding: [0xff,0xf7,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11110111-11111111
uqincd  x0, pow2  // 00000100-11110000-11110100-00000000
// CHECK: uqincd  x0, pow2 // encoding: [0x00,0xf4,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11110100-00000000
UQINCD  X0, POW2  // 00000100-11110000-11110100-00000000
// CHECK: uqincd  x0, pow2 // encoding: [0x00,0xf4,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11110100-00000000
