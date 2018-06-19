// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqinch  z0.h, pow2  // 00000100-01100000-11000000-00000000
// CHECK: sqinch  z0.h, pow2 // encoding: [0x00,0xc0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11000000-00000000
SQINCH  Z0.H, POW2  // 00000100-01100000-11000000-00000000
// CHECK: sqinch  z0.h, pow2 // encoding: [0x00,0xc0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11000000-00000000
sqinch  z31.h, all, mul #16  // 00000100-01101111-11000011-11111111
// CHECK: sqinch  z31.h, all, mul #16 // encoding: [0xff,0xc3,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11000011-11111111
SQINCH  Z31.H, ALL, MUL #16  // 00000100-01101111-11000011-11111111
// CHECK: sqinch  z31.h, all, mul #16 // encoding: [0xff,0xc3,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11000011-11111111
sqinch  x21, vl32, mul #6  // 00000100-01110101-11110001-01010101
// CHECK: sqinch  x21, vl32, mul #6 // encoding: [0x55,0xf1,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11110001-01010101
SQINCH  X21, VL32, MUL #6  // 00000100-01110101-11110001-01010101
// CHECK: sqinch  x21, vl32, mul #6 // encoding: [0x55,0xf1,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11110001-01010101
sqinch  xzr, wzr, all, mul #16  // 00000100-01101111-11110011-11111111
// CHECK: sqinch  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11110011-11111111
SQINCH  XZR, WZR, ALL, MUL #16  // 00000100-01101111-11110011-11111111
// CHECK: sqinch  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11110011-11111111
sqinch  x23, w23, vl256, mul #9  // 00000100-01101000-11110001-10110111
// CHECK: sqinch  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11110001-10110111
SQINCH  X23, W23, VL256, MUL #9  // 00000100-01101000-11110001-10110111
// CHECK: sqinch  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11110001-10110111
sqinch  x21, w21, vl32, mul #6  // 00000100-01100101-11110001-01010101
// CHECK: sqinch  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11110001-01010101
SQINCH  X21, W21, VL32, MUL #6  // 00000100-01100101-11110001-01010101
// CHECK: sqinch  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11110001-01010101
sqinch  x0, w0, pow2  // 00000100-01100000-11110000-00000000
// CHECK: sqinch  x0, w0, pow2 // encoding: [0x00,0xf0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11110000-00000000
SQINCH  X0, W0, POW2  // 00000100-01100000-11110000-00000000
// CHECK: sqinch  x0, w0, pow2 // encoding: [0x00,0xf0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11110000-00000000
sqinch  xzr, all, mul #16  // 00000100-01111111-11110011-11111111
// CHECK: sqinch  xzr, all, mul #16 // encoding: [0xff,0xf3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11110011-11111111
SQINCH  XZR, ALL, MUL #16  // 00000100-01111111-11110011-11111111
// CHECK: sqinch  xzr, all, mul #16 // encoding: [0xff,0xf3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11110011-11111111
sqinch  z21.h, vl32, mul #6  // 00000100-01100101-11000001-01010101
// CHECK: sqinch  z21.h, vl32, mul #6 // encoding: [0x55,0xc1,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11000001-01010101
SQINCH  Z21.H, VL32, MUL #6  // 00000100-01100101-11000001-01010101
// CHECK: sqinch  z21.h, vl32, mul #6 // encoding: [0x55,0xc1,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11000001-01010101
sqinch  x0, pow2  // 00000100-01110000-11110000-00000000
// CHECK: sqinch  x0, pow2 // encoding: [0x00,0xf0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11110000-00000000
SQINCH  X0, POW2  // 00000100-01110000-11110000-00000000
// CHECK: sqinch  x0, pow2 // encoding: [0x00,0xf0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11110000-00000000
sqinch  z23.h, vl256, mul #9  // 00000100-01101000-11000001-10110111
// CHECK: sqinch  z23.h, vl256, mul #9 // encoding: [0xb7,0xc1,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11000001-10110111
SQINCH  Z23.H, VL256, MUL #9  // 00000100-01101000-11000001-10110111
// CHECK: sqinch  z23.h, vl256, mul #9 // encoding: [0xb7,0xc1,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11000001-10110111
sqinch  x23, vl256, mul #9  // 00000100-01111000-11110001-10110111
// CHECK: sqinch  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11110001-10110111
SQINCH  X23, VL256, MUL #9  // 00000100-01111000-11110001-10110111
// CHECK: sqinch  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11110001-10110111
