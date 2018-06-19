// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqincd  z23.d, vl256, mul #9  // 00000100-11101000-11000001-10110111
// CHECK: sqincd  z23.d, vl256, mul #9 // encoding: [0xb7,0xc1,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11000001-10110111
SQINCD  Z23.D, VL256, MUL #9  // 00000100-11101000-11000001-10110111
// CHECK: sqincd  z23.d, vl256, mul #9 // encoding: [0xb7,0xc1,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11000001-10110111
sqincd  x0, pow2  // 00000100-11110000-11110000-00000000
// CHECK: sqincd  x0, pow2 // encoding: [0x00,0xf0,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11110000-00000000
SQINCD  X0, POW2  // 00000100-11110000-11110000-00000000
// CHECK: sqincd  x0, pow2 // encoding: [0x00,0xf0,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11110000-00000000
sqincd  z0.d, pow2  // 00000100-11100000-11000000-00000000
// CHECK: sqincd  z0.d, pow2 // encoding: [0x00,0xc0,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11000000-00000000
SQINCD  Z0.D, POW2  // 00000100-11100000-11000000-00000000
// CHECK: sqincd  z0.d, pow2 // encoding: [0x00,0xc0,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11000000-00000000
sqincd  xzr, wzr, all, mul #16  // 00000100-11101111-11110011-11111111
// CHECK: sqincd  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11110011-11111111
SQINCD  XZR, WZR, ALL, MUL #16  // 00000100-11101111-11110011-11111111
// CHECK: sqincd  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11110011-11111111
sqincd  x0, w0, pow2  // 00000100-11100000-11110000-00000000
// CHECK: sqincd  x0, w0, pow2 // encoding: [0x00,0xf0,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11110000-00000000
SQINCD  X0, W0, POW2  // 00000100-11100000-11110000-00000000
// CHECK: sqincd  x0, w0, pow2 // encoding: [0x00,0xf0,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11110000-00000000
sqincd  x23, vl256, mul #9  // 00000100-11111000-11110001-10110111
// CHECK: sqincd  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11110001-10110111
SQINCD  X23, VL256, MUL #9  // 00000100-11111000-11110001-10110111
// CHECK: sqincd  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11110001-10110111
sqincd  x21, vl32, mul #6  // 00000100-11110101-11110001-01010101
// CHECK: sqincd  x21, vl32, mul #6 // encoding: [0x55,0xf1,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11110001-01010101
SQINCD  X21, VL32, MUL #6  // 00000100-11110101-11110001-01010101
// CHECK: sqincd  x21, vl32, mul #6 // encoding: [0x55,0xf1,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11110001-01010101
sqincd  z31.d, all, mul #16  // 00000100-11101111-11000011-11111111
// CHECK: sqincd  z31.d, all, mul #16 // encoding: [0xff,0xc3,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11000011-11111111
SQINCD  Z31.D, ALL, MUL #16  // 00000100-11101111-11000011-11111111
// CHECK: sqincd  z31.d, all, mul #16 // encoding: [0xff,0xc3,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11000011-11111111
sqincd  x23, w23, vl256, mul #9  // 00000100-11101000-11110001-10110111
// CHECK: sqincd  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11110001-10110111
SQINCD  X23, W23, VL256, MUL #9  // 00000100-11101000-11110001-10110111
// CHECK: sqincd  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11110001-10110111
sqincd  xzr, all, mul #16  // 00000100-11111111-11110011-11111111
// CHECK: sqincd  xzr, all, mul #16 // encoding: [0xff,0xf3,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11110011-11111111
SQINCD  XZR, ALL, MUL #16  // 00000100-11111111-11110011-11111111
// CHECK: sqincd  xzr, all, mul #16 // encoding: [0xff,0xf3,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11110011-11111111
sqincd  z21.d, vl32, mul #6  // 00000100-11100101-11000001-01010101
// CHECK: sqincd  z21.d, vl32, mul #6 // encoding: [0x55,0xc1,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11000001-01010101
SQINCD  Z21.D, VL32, MUL #6  // 00000100-11100101-11000001-01010101
// CHECK: sqincd  z21.d, vl32, mul #6 // encoding: [0x55,0xc1,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11000001-01010101
sqincd  x21, w21, vl32, mul #6  // 00000100-11100101-11110001-01010101
// CHECK: sqincd  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11110001-01010101
SQINCD  X21, W21, VL32, MUL #6  // 00000100-11100101-11110001-01010101
// CHECK: sqincd  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11110001-01010101
