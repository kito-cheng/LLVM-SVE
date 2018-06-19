// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
inch    x23, vl256, mul #9  // 00000100-01111000-11100001-10110111
// CHECK: inch    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11100001-10110111
INCH    X23, VL256, MUL #9  // 00000100-01111000-11100001-10110111
// CHECK: inch    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11100001-10110111
inch    x0, pow2  // 00000100-01110000-11100000-00000000
// CHECK: inch    x0, pow2 // encoding: [0x00,0xe0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11100000-00000000
INCH    X0, POW2  // 00000100-01110000-11100000-00000000
// CHECK: inch    x0, pow2 // encoding: [0x00,0xe0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11100000-00000000
inch    z23.h, vl256, mul #9  // 00000100-01111000-11000001-10110111
// CHECK: inch    z23.h, vl256, mul #9 // encoding: [0xb7,0xc1,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11000001-10110111
INCH    Z23.H, VL256, MUL #9  // 00000100-01111000-11000001-10110111
// CHECK: inch    z23.h, vl256, mul #9 // encoding: [0xb7,0xc1,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11000001-10110111
inch    z31.h, all, mul #16  // 00000100-01111111-11000011-11111111
// CHECK: inch    z31.h, all, mul #16 // encoding: [0xff,0xc3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11000011-11111111
INCH    Z31.H, ALL, MUL #16  // 00000100-01111111-11000011-11111111
// CHECK: inch    z31.h, all, mul #16 // encoding: [0xff,0xc3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11000011-11111111
inch    z21.h, vl32, mul #6  // 00000100-01110101-11000001-01010101
// CHECK: inch    z21.h, vl32, mul #6 // encoding: [0x55,0xc1,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11000001-01010101
INCH    Z21.H, VL32, MUL #6  // 00000100-01110101-11000001-01010101
// CHECK: inch    z21.h, vl32, mul #6 // encoding: [0x55,0xc1,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11000001-01010101
inch    x21, vl32, mul #6  // 00000100-01110101-11100001-01010101
// CHECK: inch    x21, vl32, mul #6 // encoding: [0x55,0xe1,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11100001-01010101
INCH    X21, VL32, MUL #6  // 00000100-01110101-11100001-01010101
// CHECK: inch    x21, vl32, mul #6 // encoding: [0x55,0xe1,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11100001-01010101
inch    z0.h, pow2  // 00000100-01110000-11000000-00000000
// CHECK: inch    z0.h, pow2 // encoding: [0x00,0xc0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11000000-00000000
INCH    Z0.H, POW2  // 00000100-01110000-11000000-00000000
// CHECK: inch    z0.h, pow2 // encoding: [0x00,0xc0,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11000000-00000000
inch    xzr, all, mul #16  // 00000100-01111111-11100011-11111111
// CHECK: inch    xzr, all, mul #16 // encoding: [0xff,0xe3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11100011-11111111
INCH    XZR, ALL, MUL #16  // 00000100-01111111-11100011-11111111
// CHECK: inch    xzr, all, mul #16 // encoding: [0xff,0xe3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11100011-11111111
