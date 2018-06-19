// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sqdech  x21, vl32, mul #6  // 00000100-01110101-11111001-01010101
// CHECK: sqdech  x21, vl32, mul #6 // encoding: [0x55,0xf9,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11111001-01010101
SQDECH  X21, VL32, MUL #6  // 00000100-01110101-11111001-01010101
// CHECK: sqdech  x21, vl32, mul #6 // encoding: [0x55,0xf9,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11111001-01010101
sqdech  xzr, all, mul #16  // 00000100-01111111-11111011-11111111
// CHECK: sqdech  xzr, all, mul #16 // encoding: [0xff,0xfb,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11111011-11111111
SQDECH  XZR, ALL, MUL #16  // 00000100-01111111-11111011-11111111
// CHECK: sqdech  xzr, all, mul #16 // encoding: [0xff,0xfb,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11111011-11111111
sqdech  x21, w21, vl32, mul #6  // 00000100-01100101-11111001-01010101
// CHECK: sqdech  x21, w21, vl32, mul #6 // encoding: [0x55,0xf9,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11111001-01010101
SQDECH  X21, W21, VL32, MUL #6  // 00000100-01100101-11111001-01010101
// CHECK: sqdech  x21, w21, vl32, mul #6 // encoding: [0x55,0xf9,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11111001-01010101
sqdech  z31.h, all, mul #16  // 00000100-01101111-11001011-11111111
// CHECK: sqdech  z31.h, all, mul #16 // encoding: [0xff,0xcb,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11001011-11111111
SQDECH  Z31.H, ALL, MUL #16  // 00000100-01101111-11001011-11111111
// CHECK: sqdech  z31.h, all, mul #16 // encoding: [0xff,0xcb,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11001011-11111111
sqdech  z0.h, pow2  // 00000100-01100000-11001000-00000000
// CHECK: sqdech  z0.h, pow2 // encoding: [0x00,0xc8,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11001000-00000000
SQDECH  Z0.H, POW2  // 00000100-01100000-11001000-00000000
// CHECK: sqdech  z0.h, pow2 // encoding: [0x00,0xc8,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11001000-00000000
sqdech  x0, pow2  // 00000100-01110000-11111000-00000000
// CHECK: sqdech  x0, pow2 // encoding: [0x00,0xf8,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11111000-00000000
SQDECH  X0, POW2  // 00000100-01110000-11111000-00000000
// CHECK: sqdech  x0, pow2 // encoding: [0x00,0xf8,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11111000-00000000
sqdech  z23.h, vl256, mul #9  // 00000100-01101000-11001001-10110111
// CHECK: sqdech  z23.h, vl256, mul #9 // encoding: [0xb7,0xc9,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11001001-10110111
SQDECH  Z23.H, VL256, MUL #9  // 00000100-01101000-11001001-10110111
// CHECK: sqdech  z23.h, vl256, mul #9 // encoding: [0xb7,0xc9,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11001001-10110111
sqdech  z21.h, vl32, mul #6  // 00000100-01100101-11001001-01010101
// CHECK: sqdech  z21.h, vl32, mul #6 // encoding: [0x55,0xc9,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11001001-01010101
SQDECH  Z21.H, VL32, MUL #6  // 00000100-01100101-11001001-01010101
// CHECK: sqdech  z21.h, vl32, mul #6 // encoding: [0x55,0xc9,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11001001-01010101
sqdech  x23, w23, vl256, mul #9  // 00000100-01101000-11111001-10110111
// CHECK: sqdech  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf9,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11111001-10110111
SQDECH  X23, W23, VL256, MUL #9  // 00000100-01101000-11111001-10110111
// CHECK: sqdech  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf9,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11111001-10110111
sqdech  xzr, wzr, all, mul #16  // 00000100-01101111-11111011-11111111
// CHECK: sqdech  xzr, wzr, all, mul #16 // encoding: [0xff,0xfb,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11111011-11111111
SQDECH  XZR, WZR, ALL, MUL #16  // 00000100-01101111-11111011-11111111
// CHECK: sqdech  xzr, wzr, all, mul #16 // encoding: [0xff,0xfb,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11111011-11111111
sqdech  x0, w0, pow2  // 00000100-01100000-11111000-00000000
// CHECK: sqdech  x0, w0, pow2 // encoding: [0x00,0xf8,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11111000-00000000
SQDECH  X0, W0, POW2  // 00000100-01100000-11111000-00000000
// CHECK: sqdech  x0, w0, pow2 // encoding: [0x00,0xf8,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11111000-00000000
sqdech  x23, vl256, mul #9  // 00000100-01111000-11111001-10110111
// CHECK: sqdech  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11111001-10110111
SQDECH  X23, VL256, MUL #9  // 00000100-01111000-11111001-10110111
// CHECK: sqdech  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11111001-10110111
