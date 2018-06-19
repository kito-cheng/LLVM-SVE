// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uqincb  x21, vl32, mul #6  // 00000100-00110101-11110101-01010101
// CHECK: uqincb  x21, vl32, mul #6 // encoding: [0x55,0xf5,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-11110101-01010101
UQINCB  X21, VL32, MUL #6  // 00000100-00110101-11110101-01010101
// CHECK: uqincb  x21, vl32, mul #6 // encoding: [0x55,0xf5,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-11110101-01010101
uqincb  wzr, all, mul #16  // 00000100-00101111-11110111-11111111
// CHECK: uqincb  wzr, all, mul #16 // encoding: [0xff,0xf7,0x2f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101111-11110111-11111111
UQINCB  WZR, ALL, MUL #16  // 00000100-00101111-11110111-11111111
// CHECK: uqincb  wzr, all, mul #16 // encoding: [0xff,0xf7,0x2f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101111-11110111-11111111
uqincb  x0, pow2  // 00000100-00110000-11110100-00000000
// CHECK: uqincb  x0, pow2 // encoding: [0x00,0xf4,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-11110100-00000000
UQINCB  X0, POW2  // 00000100-00110000-11110100-00000000
// CHECK: uqincb  x0, pow2 // encoding: [0x00,0xf4,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-11110100-00000000
uqincb  w23, vl256, mul #9  // 00000100-00101000-11110101-10110111
// CHECK: uqincb  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-11110101-10110111
UQINCB  W23, VL256, MUL #9  // 00000100-00101000-11110101-10110111
// CHECK: uqincb  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-11110101-10110111
uqincb  x23, vl256, mul #9  // 00000100-00111000-11110101-10110111
// CHECK: uqincb  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-11110101-10110111
UQINCB  X23, VL256, MUL #9  // 00000100-00111000-11110101-10110111
// CHECK: uqincb  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-11110101-10110111
uqincb  w0, pow2  // 00000100-00100000-11110100-00000000
// CHECK: uqincb  w0, pow2 // encoding: [0x00,0xf4,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-11110100-00000000
UQINCB  W0, POW2  // 00000100-00100000-11110100-00000000
// CHECK: uqincb  w0, pow2 // encoding: [0x00,0xf4,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-11110100-00000000
uqincb  w21, vl32, mul #6  // 00000100-00100101-11110101-01010101
// CHECK: uqincb  w21, vl32, mul #6 // encoding: [0x55,0xf5,0x25,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100101-11110101-01010101
UQINCB  W21, VL32, MUL #6  // 00000100-00100101-11110101-01010101
// CHECK: uqincb  w21, vl32, mul #6 // encoding: [0x55,0xf5,0x25,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100101-11110101-01010101
uqincb  xzr, all, mul #16  // 00000100-00111111-11110111-11111111
// CHECK: uqincb  xzr, all, mul #16 // encoding: [0xff,0xf7,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-11110111-11111111
UQINCB  XZR, ALL, MUL #16  // 00000100-00111111-11110111-11111111
// CHECK: uqincb  xzr, all, mul #16 // encoding: [0xff,0xf7,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-11110111-11111111
