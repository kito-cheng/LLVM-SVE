// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cntw    x23, vl256, mul #9  // 00000100-10101000-11100001-10110111
// CHECK: cntw    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11100001-10110111
CNTW    X23, VL256, MUL #9  // 00000100-10101000-11100001-10110111
// CHECK: cntw    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-11100001-10110111
cntw    x0, pow2  // 00000100-10100000-11100000-00000000
// CHECK: cntw    x0, pow2 // encoding: [0x00,0xe0,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11100000-00000000
CNTW    X0, POW2  // 00000100-10100000-11100000-00000000
// CHECK: cntw    x0, pow2 // encoding: [0x00,0xe0,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-11100000-00000000
cntw    x21, vl32, mul #6  // 00000100-10100101-11100001-01010101
// CHECK: cntw    x21, vl32, mul #6 // encoding: [0x55,0xe1,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11100001-01010101
CNTW    X21, VL32, MUL #6  // 00000100-10100101-11100001-01010101
// CHECK: cntw    x21, vl32, mul #6 // encoding: [0x55,0xe1,0xa5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100101-11100001-01010101
cntw    xzr, all, mul #16  // 00000100-10101111-11100011-11111111
// CHECK: cntw    xzr, all, mul #16 // encoding: [0xff,0xe3,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11100011-11111111
CNTW    XZR, ALL, MUL #16  // 00000100-10101111-11100011-11111111
// CHECK: cntw    xzr, all, mul #16 // encoding: [0xff,0xe3,0xaf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101111-11100011-11111111
