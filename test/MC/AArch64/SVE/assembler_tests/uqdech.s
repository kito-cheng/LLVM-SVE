// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdech  w21, vl32, mul #6  // 00000100-01100101-11111101-01010101
// CHECK: uqdech  w21, vl32, mul #6 // encoding: [0x55,0xfd,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11111101-01010101
UQDECH  W21, VL32, MUL #6  // 00000100-01100101-11111101-01010101
// CHECK: uqdech  w21, vl32, mul #6 // encoding: [0x55,0xfd,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11111101-01010101
uqdech  z21.h, vl32, mul #6  // 00000100-01100101-11001101-01010101
// CHECK: uqdech  z21.h, vl32, mul #6 // encoding: [0x55,0xcd,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11001101-01010101
UQDECH  Z21.H, VL32, MUL #6  // 00000100-01100101-11001101-01010101
// CHECK: uqdech  z21.h, vl32, mul #6 // encoding: [0x55,0xcd,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11001101-01010101
uqdech  w0, pow2  // 00000100-01100000-11111100-00000000
// CHECK: uqdech  w0, pow2 // encoding: [0x00,0xfc,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11111100-00000000
UQDECH  W0, POW2  // 00000100-01100000-11111100-00000000
// CHECK: uqdech  w0, pow2 // encoding: [0x00,0xfc,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11111100-00000000
uqdech  xzr, all, mul #16  // 00000100-01111111-11111111-11111111
// CHECK: uqdech  xzr, all, mul #16 // encoding: [0xff,0xff,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11111111-11111111
UQDECH  XZR, ALL, MUL #16  // 00000100-01111111-11111111-11111111
// CHECK: uqdech  xzr, all, mul #16 // encoding: [0xff,0xff,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11111111-11111111
uqdech  x0, pow2  // 00000100-01110000-11111100-00000000
// CHECK: uqdech  x0, pow2 // encoding: [0x00,0xfc,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11111100-00000000
UQDECH  X0, POW2  // 00000100-01110000-11111100-00000000
// CHECK: uqdech  x0, pow2 // encoding: [0x00,0xfc,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11111100-00000000
uqdech  z31.h, all, mul #16  // 00000100-01101111-11001111-11111111
// CHECK: uqdech  z31.h, all, mul #16 // encoding: [0xff,0xcf,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11001111-11111111
UQDECH  Z31.H, ALL, MUL #16  // 00000100-01101111-11001111-11111111
// CHECK: uqdech  z31.h, all, mul #16 // encoding: [0xff,0xcf,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11001111-11111111
uqdech  w23, vl256, mul #9  // 00000100-01101000-11111101-10110111
// CHECK: uqdech  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11111101-10110111
UQDECH  W23, VL256, MUL #9  // 00000100-01101000-11111101-10110111
// CHECK: uqdech  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11111101-10110111
uqdech  x21, vl32, mul #6  // 00000100-01110101-11111101-01010101
// CHECK: uqdech  x21, vl32, mul #6 // encoding: [0x55,0xfd,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11111101-01010101
UQDECH  X21, VL32, MUL #6  // 00000100-01110101-11111101-01010101
// CHECK: uqdech  x21, vl32, mul #6 // encoding: [0x55,0xfd,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11111101-01010101
uqdech  z23.h, vl256, mul #9  // 00000100-01101000-11001101-10110111
// CHECK: uqdech  z23.h, vl256, mul #9 // encoding: [0xb7,0xcd,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11001101-10110111
UQDECH  Z23.H, VL256, MUL #9  // 00000100-01101000-11001101-10110111
// CHECK: uqdech  z23.h, vl256, mul #9 // encoding: [0xb7,0xcd,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11001101-10110111
uqdech  x23, vl256, mul #9  // 00000100-01111000-11111101-10110111
// CHECK: uqdech  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11111101-10110111
UQDECH  X23, VL256, MUL #9  // 00000100-01111000-11111101-10110111
// CHECK: uqdech  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11111101-10110111
uqdech  z0.h, pow2  // 00000100-01100000-11001100-00000000
// CHECK: uqdech  z0.h, pow2 // encoding: [0x00,0xcc,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11001100-00000000
UQDECH  Z0.H, POW2  // 00000100-01100000-11001100-00000000
// CHECK: uqdech  z0.h, pow2 // encoding: [0x00,0xcc,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11001100-00000000
uqdech  wzr, all, mul #16  // 00000100-01101111-11111111-11111111
// CHECK: uqdech  wzr, all, mul #16 // encoding: [0xff,0xff,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11111111-11111111
UQDECH  WZR, ALL, MUL #16  // 00000100-01101111-11111111-11111111
// CHECK: uqdech  wzr, all, mul #16 // encoding: [0xff,0xff,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11111111-11111111
