// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqincb  xzr, all, mul #16  // 00000100-00111111-11110011-11111111
// CHECK: sqincb  xzr, all, mul #16 // encoding: [0xff,0xf3,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-11110011-11111111
SQINCB  XZR, ALL, MUL #16  // 00000100-00111111-11110011-11111111
// CHECK: sqincb  xzr, all, mul #16 // encoding: [0xff,0xf3,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-11110011-11111111
sqincb  x21, w21, vl32, mul #6  // 00000100-00100101-11110001-01010101
// CHECK: sqincb  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0x25,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100101-11110001-01010101
SQINCB  X21, W21, VL32, MUL #6  // 00000100-00100101-11110001-01010101
// CHECK: sqincb  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0x25,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100101-11110001-01010101
sqincb  x23, w23, vl256, mul #9  // 00000100-00101000-11110001-10110111
// CHECK: sqincb  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-11110001-10110111
SQINCB  X23, W23, VL256, MUL #9  // 00000100-00101000-11110001-10110111
// CHECK: sqincb  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-11110001-10110111
sqincb  xzr, wzr, all, mul #16  // 00000100-00101111-11110011-11111111
// CHECK: sqincb  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0x2f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101111-11110011-11111111
SQINCB  XZR, WZR, ALL, MUL #16  // 00000100-00101111-11110011-11111111
// CHECK: sqincb  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0x2f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101111-11110011-11111111
sqincb  x0, w0, pow2  // 00000100-00100000-11110000-00000000
// CHECK: sqincb  x0, w0, pow2 // encoding: [0x00,0xf0,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-11110000-00000000
SQINCB  X0, W0, POW2  // 00000100-00100000-11110000-00000000
// CHECK: sqincb  x0, w0, pow2 // encoding: [0x00,0xf0,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-11110000-00000000
sqincb  x21, vl32, mul #6  // 00000100-00110101-11110001-01010101
// CHECK: sqincb  x21, vl32, mul #6 // encoding: [0x55,0xf1,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-11110001-01010101
SQINCB  X21, VL32, MUL #6  // 00000100-00110101-11110001-01010101
// CHECK: sqincb  x21, vl32, mul #6 // encoding: [0x55,0xf1,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-11110001-01010101
sqincb  x23, vl256, mul #9  // 00000100-00111000-11110001-10110111
// CHECK: sqincb  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-11110001-10110111
SQINCB  X23, VL256, MUL #9  // 00000100-00111000-11110001-10110111
// CHECK: sqincb  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-11110001-10110111
sqincb  x0, pow2  // 00000100-00110000-11110000-00000000
// CHECK: sqincb  x0, pow2 // encoding: [0x00,0xf0,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-11110000-00000000
SQINCB  X0, POW2  // 00000100-00110000-11110000-00000000
// CHECK: sqincb  x0, pow2 // encoding: [0x00,0xf0,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-11110000-00000000
