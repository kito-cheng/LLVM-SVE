// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
dech    z0.h, pow2  // 00000100-01110000-11000100-00000000
// CHECK: dech    z0.h, pow2 // encoding: [0x00,0xc4,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11000100-00000000
DECH    Z0.H, POW2  // 00000100-01110000-11000100-00000000
// CHECK: dech    z0.h, pow2 // encoding: [0x00,0xc4,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11000100-00000000
dech    z31.h, all, mul #16  // 00000100-01111111-11000111-11111111
// CHECK: dech    z31.h, all, mul #16 // encoding: [0xff,0xc7,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11000111-11111111
DECH    Z31.H, ALL, MUL #16  // 00000100-01111111-11000111-11111111
// CHECK: dech    z31.h, all, mul #16 // encoding: [0xff,0xc7,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11000111-11111111
dech    z21.h, vl32, mul #6  // 00000100-01110101-11000101-01010101
// CHECK: dech    z21.h, vl32, mul #6 // encoding: [0x55,0xc5,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11000101-01010101
DECH    Z21.H, VL32, MUL #6  // 00000100-01110101-11000101-01010101
// CHECK: dech    z21.h, vl32, mul #6 // encoding: [0x55,0xc5,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11000101-01010101
dech    xzr, all, mul #16  // 00000100-01111111-11100111-11111111
// CHECK: dech    xzr, all, mul #16 // encoding: [0xff,0xe7,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11100111-11111111
DECH    XZR, ALL, MUL #16  // 00000100-01111111-11100111-11111111
// CHECK: dech    xzr, all, mul #16 // encoding: [0xff,0xe7,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-11100111-11111111
dech    x21, vl32, mul #6  // 00000100-01110101-11100101-01010101
// CHECK: dech    x21, vl32, mul #6 // encoding: [0x55,0xe5,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11100101-01010101
DECH    X21, VL32, MUL #6  // 00000100-01110101-11100101-01010101
// CHECK: dech    x21, vl32, mul #6 // encoding: [0x55,0xe5,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-11100101-01010101
dech    x0, pow2  // 00000100-01110000-11100100-00000000
// CHECK: dech    x0, pow2 // encoding: [0x00,0xe4,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11100100-00000000
DECH    X0, POW2  // 00000100-01110000-11100100-00000000
// CHECK: dech    x0, pow2 // encoding: [0x00,0xe4,0x70,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110000-11100100-00000000
dech    x23, vl256, mul #9  // 00000100-01111000-11100101-10110111
// CHECK: dech    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11100101-10110111
DECH    X23, VL256, MUL #9  // 00000100-01111000-11100101-10110111
// CHECK: dech    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11100101-10110111
dech    z23.h, vl256, mul #9  // 00000100-01111000-11000101-10110111
// CHECK: dech    z23.h, vl256, mul #9 // encoding: [0xb7,0xc5,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11000101-10110111
DECH    Z23.H, VL256, MUL #9  // 00000100-01111000-11000101-10110111
// CHECK: dech    z23.h, vl256, mul #9 // encoding: [0xb7,0xc5,0x78,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111000-11000101-10110111
