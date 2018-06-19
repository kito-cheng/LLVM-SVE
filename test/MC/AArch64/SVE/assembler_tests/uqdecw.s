// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdecw  w21, vl32, mul #6  // 00000100-10100101-11111101-01010101
// CHECK: uqdecw  w21, vl32, mul #6 // encoding: [0x55,0xfd,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11111101-01010101
UQDECW  W21, VL32, MUL #6  // 00000100-10100101-11111101-01010101
// CHECK: uqdecw  w21, vl32, mul #6 // encoding: [0x55,0xfd,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11111101-01010101
uqdecw  w23, vl256, mul #9  // 00000100-10101000-11111101-10110111
// CHECK: uqdecw  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11111101-10110111
UQDECW  W23, VL256, MUL #9  // 00000100-10101000-11111101-10110111
// CHECK: uqdecw  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11111101-10110111
uqdecw  z0.s, pow2  // 00000100-10100000-11001100-00000000
// CHECK: uqdecw  z0.s, pow2 // encoding: [0x00,0xcc,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11001100-00000000
UQDECW  Z0.S, POW2  // 00000100-10100000-11001100-00000000
// CHECK: uqdecw  z0.s, pow2 // encoding: [0x00,0xcc,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11001100-00000000
uqdecw  x23, vl256, mul #9  // 00000100-10111000-11111101-10110111
// CHECK: uqdecw  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11111101-10110111
UQDECW  X23, VL256, MUL #9  // 00000100-10111000-11111101-10110111
// CHECK: uqdecw  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0xb8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111000-11111101-10110111
uqdecw  x21, vl32, mul #6  // 00000100-10110101-11111101-01010101
// CHECK: uqdecw  x21, vl32, mul #6 // encoding: [0x55,0xfd,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11111101-01010101
UQDECW  X21, VL32, MUL #6  // 00000100-10110101-11111101-01010101
// CHECK: uqdecw  x21, vl32, mul #6 // encoding: [0x55,0xfd,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-11111101-01010101
uqdecw  w0, pow2  // 00000100-10100000-11111100-00000000
// CHECK: uqdecw  w0, pow2 // encoding: [0x00,0xfc,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11111100-00000000
UQDECW  W0, POW2  // 00000100-10100000-11111100-00000000
// CHECK: uqdecw  w0, pow2 // encoding: [0x00,0xfc,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11111100-00000000
uqdecw  z31.s, all, mul #16  // 00000100-10101111-11001111-11111111
// CHECK: uqdecw  z31.s, all, mul #16 // encoding: [0xff,0xcf,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11001111-11111111
UQDECW  Z31.S, ALL, MUL #16  // 00000100-10101111-11001111-11111111
// CHECK: uqdecw  z31.s, all, mul #16 // encoding: [0xff,0xcf,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11001111-11111111
uqdecw  x0, pow2  // 00000100-10110000-11111100-00000000
// CHECK: uqdecw  x0, pow2 // encoding: [0x00,0xfc,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11111100-00000000
UQDECW  X0, POW2  // 00000100-10110000-11111100-00000000
// CHECK: uqdecw  x0, pow2 // encoding: [0x00,0xfc,0xb0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110000-11111100-00000000
uqdecw  z23.s, vl256, mul #9  // 00000100-10101000-11001101-10110111
// CHECK: uqdecw  z23.s, vl256, mul #9 // encoding: [0xb7,0xcd,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11001101-10110111
UQDECW  Z23.S, VL256, MUL #9  // 00000100-10101000-11001101-10110111
// CHECK: uqdecw  z23.s, vl256, mul #9 // encoding: [0xb7,0xcd,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11001101-10110111
uqdecw  wzr, all, mul #16  // 00000100-10101111-11111111-11111111
// CHECK: uqdecw  wzr, all, mul #16 // encoding: [0xff,0xff,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11111111-11111111
UQDECW  WZR, ALL, MUL #16  // 00000100-10101111-11111111-11111111
// CHECK: uqdecw  wzr, all, mul #16 // encoding: [0xff,0xff,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11111111-11111111
uqdecw  xzr, all, mul #16  // 00000100-10111111-11111111-11111111
// CHECK: uqdecw  xzr, all, mul #16 // encoding: [0xff,0xff,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11111111-11111111
UQDECW  XZR, ALL, MUL #16  // 00000100-10111111-11111111-11111111
// CHECK: uqdecw  xzr, all, mul #16 // encoding: [0xff,0xff,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-11111111-11111111
uqdecw  z21.s, vl32, mul #6  // 00000100-10100101-11001101-01010101
// CHECK: uqdecw  z21.s, vl32, mul #6 // encoding: [0x55,0xcd,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11001101-01010101
UQDECW  Z21.S, VL32, MUL #6  // 00000100-10100101-11001101-01010101
// CHECK: uqdecw  z21.s, vl32, mul #6 // encoding: [0x55,0xcd,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11001101-01010101
