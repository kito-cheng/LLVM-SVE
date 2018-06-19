// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cntd    x0, pow2  // 00000100-11100000-11100000-00000000
// CHECK: cntd    x0, pow2 // encoding: [0x00,0xe0,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11100000-00000000
CNTD    X0, POW2  // 00000100-11100000-11100000-00000000
// CHECK: cntd    x0, pow2 // encoding: [0x00,0xe0,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-11100000-00000000
cntd    x21, vl32, mul #6  // 00000100-11100101-11100001-01010101
// CHECK: cntd    x21, vl32, mul #6 // encoding: [0x55,0xe1,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11100001-01010101
CNTD    X21, VL32, MUL #6  // 00000100-11100101-11100001-01010101
// CHECK: cntd    x21, vl32, mul #6 // encoding: [0x55,0xe1,0xe5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100101-11100001-01010101
cntd    xzr, all, mul #16  // 00000100-11101111-11100011-11111111
// CHECK: cntd    xzr, all, mul #16 // encoding: [0xff,0xe3,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11100011-11111111
CNTD    XZR, ALL, MUL #16  // 00000100-11101111-11100011-11111111
// CHECK: cntd    xzr, all, mul #16 // encoding: [0xff,0xe3,0xef,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101111-11100011-11111111
cntd    x23, vl256, mul #9  // 00000100-11101000-11100001-10110111
// CHECK: cntd    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11100001-10110111
CNTD    X23, VL256, MUL #9  // 00000100-11101000-11100001-10110111
// CHECK: cntd    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-11100001-10110111
