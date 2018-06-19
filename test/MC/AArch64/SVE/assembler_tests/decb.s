// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
decb    x21, vl32, mul #6  // 00000100-00110101-11100101-01010101
// CHECK: decb    x21, vl32, mul #6 // encoding: [0x55,0xe5,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-11100101-01010101
DECB    X21, VL32, MUL #6  // 00000100-00110101-11100101-01010101
// CHECK: decb    x21, vl32, mul #6 // encoding: [0x55,0xe5,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-11100101-01010101
decb    x23, vl256, mul #9  // 00000100-00111000-11100101-10110111
// CHECK: decb    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-11100101-10110111
DECB    X23, VL256, MUL #9  // 00000100-00111000-11100101-10110111
// CHECK: decb    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-11100101-10110111
decb    x0, pow2  // 00000100-00110000-11100100-00000000
// CHECK: decb    x0, pow2 // encoding: [0x00,0xe4,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-11100100-00000000
DECB    X0, POW2  // 00000100-00110000-11100100-00000000
// CHECK: decb    x0, pow2 // encoding: [0x00,0xe4,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-11100100-00000000
decb    xzr, all, mul #16  // 00000100-00111111-11100111-11111111
// CHECK: decb    xzr, all, mul #16 // encoding: [0xff,0xe7,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-11100111-11111111
DECB    XZR, ALL, MUL #16  // 00000100-00111111-11100111-11111111
// CHECK: decb    xzr, all, mul #16 // encoding: [0xff,0xe7,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-11100111-11111111
