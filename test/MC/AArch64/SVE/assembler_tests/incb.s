// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
incb    x21, vl32, mul #6  // 00000100-00110101-11100001-01010101
// CHECK: incb    x21, vl32, mul #6 // encoding: [0x55,0xe1,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-11100001-01010101
INCB    X21, VL32, MUL #6  // 00000100-00110101-11100001-01010101
// CHECK: incb    x21, vl32, mul #6 // encoding: [0x55,0xe1,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-11100001-01010101
incb    xzr, all, mul #16  // 00000100-00111111-11100011-11111111
// CHECK: incb    xzr, all, mul #16 // encoding: [0xff,0xe3,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-11100011-11111111
INCB    XZR, ALL, MUL #16  // 00000100-00111111-11100011-11111111
// CHECK: incb    xzr, all, mul #16 // encoding: [0xff,0xe3,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-11100011-11111111
incb    x23, vl256, mul #9  // 00000100-00111000-11100001-10110111
// CHECK: incb    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-11100001-10110111
INCB    X23, VL256, MUL #9  // 00000100-00111000-11100001-10110111
// CHECK: incb    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-11100001-10110111
incb    x0, pow2  // 00000100-00110000-11100000-00000000
// CHECK: incb    x0, pow2 // encoding: [0x00,0xe0,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-11100000-00000000
INCB    X0, POW2  // 00000100-00110000-11100000-00000000
// CHECK: incb    x0, pow2 // encoding: [0x00,0xe0,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-11100000-00000000
