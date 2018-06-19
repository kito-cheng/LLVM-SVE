// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cnth    x0, pow2  // 00000100-01100000-11100000-00000000
// CHECK: cnth    x0, pow2 // encoding: [0x00,0xe0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11100000-00000000
CNTH    X0, POW2  // 00000100-01100000-11100000-00000000
// CHECK: cnth    x0, pow2 // encoding: [0x00,0xe0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-11100000-00000000
cnth    x21, vl32, mul #6  // 00000100-01100101-11100001-01010101
// CHECK: cnth    x21, vl32, mul #6 // encoding: [0x55,0xe1,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11100001-01010101
CNTH    X21, VL32, MUL #6  // 00000100-01100101-11100001-01010101
// CHECK: cnth    x21, vl32, mul #6 // encoding: [0x55,0xe1,0x65,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100101-11100001-01010101
cnth    xzr, all, mul #16  // 00000100-01101111-11100011-11111111
// CHECK: cnth    xzr, all, mul #16 // encoding: [0xff,0xe3,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11100011-11111111
CNTH    XZR, ALL, MUL #16  // 00000100-01101111-11100011-11111111
// CHECK: cnth    xzr, all, mul #16 // encoding: [0xff,0xe3,0x6f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101111-11100011-11111111
cnth    x23, vl256, mul #9  // 00000100-01101000-11100001-10110111
// CHECK: cnth    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11100001-10110111
CNTH    X23, VL256, MUL #9  // 00000100-01101000-11100001-10110111
// CHECK: cnth    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-11100001-10110111
