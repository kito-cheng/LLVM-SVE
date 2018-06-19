// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqinch  x21, vl32, mul #6  // 00000100-01110101-11110101-01010101
// CHECK: uqinch  x21, vl32, mul #6 // encoding: [0x55,0xf5,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11110101-01010101
UQINCH  X21, VL32, MUL #6  // 00000100-01110101-11110101-01010101
// CHECK: uqinch  x21, vl32, mul #6 // encoding: [0x55,0xf5,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11110101-01010101
uqinch  wzr, all, mul #16  // 00000100-01101111-11110111-11111111
// CHECK: uqinch  wzr, all, mul #16 // encoding: [0xff,0xf7,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11110111-11111111
UQINCH  WZR, ALL, MUL #16  // 00000100-01101111-11110111-11111111
// CHECK: uqinch  wzr, all, mul #16 // encoding: [0xff,0xf7,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11110111-11111111
uqinch  x0, pow2  // 00000100-01110000-11110100-00000000
// CHECK: uqinch  x0, pow2 // encoding: [0x00,0xf4,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11110100-00000000
UQINCH  X0, POW2  // 00000100-01110000-11110100-00000000
// CHECK: uqinch  x0, pow2 // encoding: [0x00,0xf4,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11110100-00000000
uqinch  x23, vl256, mul #9  // 00000100-01111000-11110101-10110111
// CHECK: uqinch  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11110101-10110111
UQINCH  X23, VL256, MUL #9  // 00000100-01111000-11110101-10110111
// CHECK: uqinch  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11110101-10110111
uqinch  w21, vl32, mul #6  // 00000100-01100101-11110101-01010101
// CHECK: uqinch  w21, vl32, mul #6 // encoding: [0x55,0xf5,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11110101-01010101
UQINCH  W21, VL32, MUL #6  // 00000100-01100101-11110101-01010101
// CHECK: uqinch  w21, vl32, mul #6 // encoding: [0x55,0xf5,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11110101-01010101
uqinch  xzr, all, mul #16  // 00000100-01111111-11110111-11111111
// CHECK: uqinch  xzr, all, mul #16 // encoding: [0xff,0xf7,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11110111-11111111
UQINCH  XZR, ALL, MUL #16  // 00000100-01111111-11110111-11111111
// CHECK: uqinch  xzr, all, mul #16 // encoding: [0xff,0xf7,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11110111-11111111
uqinch  z31.h, all, mul #16  // 00000100-01101111-11000111-11111111
// CHECK: uqinch  z31.h, all, mul #16 // encoding: [0xff,0xc7,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11000111-11111111
UQINCH  Z31.H, ALL, MUL #16  // 00000100-01101111-11000111-11111111
// CHECK: uqinch  z31.h, all, mul #16 // encoding: [0xff,0xc7,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11000111-11111111
uqinch  w0, pow2  // 00000100-01100000-11110100-00000000
// CHECK: uqinch  w0, pow2 // encoding: [0x00,0xf4,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11110100-00000000
UQINCH  W0, POW2  // 00000100-01100000-11110100-00000000
// CHECK: uqinch  w0, pow2 // encoding: [0x00,0xf4,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11110100-00000000
uqinch  z23.h, vl256, mul #9  // 00000100-01101000-11000101-10110111
// CHECK: uqinch  z23.h, vl256, mul #9 // encoding: [0xb7,0xc5,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11000101-10110111
UQINCH  Z23.H, VL256, MUL #9  // 00000100-01101000-11000101-10110111
// CHECK: uqinch  z23.h, vl256, mul #9 // encoding: [0xb7,0xc5,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11000101-10110111
uqinch  z0.h, pow2  // 00000100-01100000-11000100-00000000
// CHECK: uqinch  z0.h, pow2 // encoding: [0x00,0xc4,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11000100-00000000
UQINCH  Z0.H, POW2  // 00000100-01100000-11000100-00000000
// CHECK: uqinch  z0.h, pow2 // encoding: [0x00,0xc4,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11000100-00000000
uqinch  z21.h, vl32, mul #6  // 00000100-01100101-11000101-01010101
// CHECK: uqinch  z21.h, vl32, mul #6 // encoding: [0x55,0xc5,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11000101-01010101
UQINCH  Z21.H, VL32, MUL #6  // 00000100-01100101-11000101-01010101
// CHECK: uqinch  z21.h, vl32, mul #6 // encoding: [0x55,0xc5,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11000101-01010101
uqinch  w23, vl256, mul #9  // 00000100-01101000-11110101-10110111
// CHECK: uqinch  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11110101-10110111
UQINCH  W23, VL256, MUL #9  // 00000100-01101000-11110101-10110111
// CHECK: uqinch  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11110101-10110111
