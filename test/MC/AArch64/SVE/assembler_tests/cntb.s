// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cntb    x21, vl32, mul #6  // 00000100-00100101-11100001-01010101
// CHECK: cntb    x21, vl32, mul #6 // encoding: [0x55,0xe1,0x25,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100101-11100001-01010101
CNTB    X21, VL32, MUL #6  // 00000100-00100101-11100001-01010101
// CHECK: cntb    x21, vl32, mul #6 // encoding: [0x55,0xe1,0x25,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100101-11100001-01010101
cntb    x0, pow2  // 00000100-00100000-11100000-00000000
// CHECK: cntb    x0, pow2 // encoding: [0x00,0xe0,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-11100000-00000000
CNTB    X0, POW2  // 00000100-00100000-11100000-00000000
// CHECK: cntb    x0, pow2 // encoding: [0x00,0xe0,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-11100000-00000000
cntb    x23, vl256, mul #9  // 00000100-00101000-11100001-10110111
// CHECK: cntb    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-11100001-10110111
CNTB    X23, VL256, MUL #9  // 00000100-00101000-11100001-10110111
// CHECK: cntb    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-11100001-10110111
cntb    xzr, all, mul #16  // 00000100-00101111-11100011-11111111
// CHECK: cntb    xzr, all, mul #16 // encoding: [0xff,0xe3,0x2f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101111-11100011-11111111
CNTB    XZR, ALL, MUL #16  // 00000100-00101111-11100011-11111111
// CHECK: cntb    xzr, all, mul #16 // encoding: [0xff,0xe3,0x2f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101111-11100011-11111111
