// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqdecd  w0, pow2  // 00000100-11100000-11111100-00000000
// CHECK: uqdecd  w0, pow2 // encoding: [0x00,0xfc,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11111100-00000000
UQDECD  W0, POW2  // 00000100-11100000-11111100-00000000
// CHECK: uqdecd  w0, pow2 // encoding: [0x00,0xfc,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11111100-00000000
uqdecd  w21, vl32, mul #6  // 00000100-11100101-11111101-01010101
// CHECK: uqdecd  w21, vl32, mul #6 // encoding: [0x55,0xfd,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11111101-01010101
UQDECD  W21, VL32, MUL #6  // 00000100-11100101-11111101-01010101
// CHECK: uqdecd  w21, vl32, mul #6 // encoding: [0x55,0xfd,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11111101-01010101
uqdecd  w23, vl256, mul #9  // 00000100-11101000-11111101-10110111
// CHECK: uqdecd  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11111101-10110111
UQDECD  W23, VL256, MUL #9  // 00000100-11101000-11111101-10110111
// CHECK: uqdecd  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11111101-10110111
uqdecd  z31.d, all, mul #16  // 00000100-11101111-11001111-11111111
// CHECK: uqdecd  z31.d, all, mul #16 // encoding: [0xff,0xcf,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11001111-11111111
UQDECD  Z31.D, ALL, MUL #16  // 00000100-11101111-11001111-11111111
// CHECK: uqdecd  z31.d, all, mul #16 // encoding: [0xff,0xcf,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11001111-11111111
uqdecd  wzr, all, mul #16  // 00000100-11101111-11111111-11111111
// CHECK: uqdecd  wzr, all, mul #16 // encoding: [0xff,0xff,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11111111-11111111
UQDECD  WZR, ALL, MUL #16  // 00000100-11101111-11111111-11111111
// CHECK: uqdecd  wzr, all, mul #16 // encoding: [0xff,0xff,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11111111-11111111
uqdecd  x21, vl32, mul #6  // 00000100-11110101-11111101-01010101
// CHECK: uqdecd  x21, vl32, mul #6 // encoding: [0x55,0xfd,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11111101-01010101
UQDECD  X21, VL32, MUL #6  // 00000100-11110101-11111101-01010101
// CHECK: uqdecd  x21, vl32, mul #6 // encoding: [0x55,0xfd,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-11111101-01010101
uqdecd  x0, pow2  // 00000100-11110000-11111100-00000000
// CHECK: uqdecd  x0, pow2 // encoding: [0x00,0xfc,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11111100-00000000
UQDECD  X0, POW2  // 00000100-11110000-11111100-00000000
// CHECK: uqdecd  x0, pow2 // encoding: [0x00,0xfc,0xf0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110000-11111100-00000000
uqdecd  z21.d, vl32, mul #6  // 00000100-11100101-11001101-01010101
// CHECK: uqdecd  z21.d, vl32, mul #6 // encoding: [0x55,0xcd,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11001101-01010101
UQDECD  Z21.D, VL32, MUL #6  // 00000100-11100101-11001101-01010101
// CHECK: uqdecd  z21.d, vl32, mul #6 // encoding: [0x55,0xcd,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11001101-01010101
uqdecd  x23, vl256, mul #9  // 00000100-11111000-11111101-10110111
// CHECK: uqdecd  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11111101-10110111
UQDECD  X23, VL256, MUL #9  // 00000100-11111000-11111101-10110111
// CHECK: uqdecd  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0xf8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111000-11111101-10110111
uqdecd  z23.d, vl256, mul #9  // 00000100-11101000-11001101-10110111
// CHECK: uqdecd  z23.d, vl256, mul #9 // encoding: [0xb7,0xcd,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11001101-10110111
UQDECD  Z23.D, VL256, MUL #9  // 00000100-11101000-11001101-10110111
// CHECK: uqdecd  z23.d, vl256, mul #9 // encoding: [0xb7,0xcd,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11001101-10110111
uqdecd  xzr, all, mul #16  // 00000100-11111111-11111111-11111111
// CHECK: uqdecd  xzr, all, mul #16 // encoding: [0xff,0xff,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11111111-11111111
UQDECD  XZR, ALL, MUL #16  // 00000100-11111111-11111111-11111111
// CHECK: uqdecd  xzr, all, mul #16 // encoding: [0xff,0xff,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-11111111-11111111
uqdecd  z0.d, pow2  // 00000100-11100000-11001100-00000000
// CHECK: uqdecd  z0.d, pow2 // encoding: [0x00,0xcc,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11001100-00000000
UQDECD  Z0.D, POW2  // 00000100-11100000-11001100-00000000
// CHECK: uqdecd  z0.d, pow2 // encoding: [0x00,0xcc,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11001100-00000000
