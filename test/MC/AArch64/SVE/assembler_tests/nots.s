// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
nots    p0.b, p0/z, p0.b  // 00100101-01000000-01000010-00000000
// CHECK: nots    p0.b, p0/z, p0.b // encoding: [0x00,0x42,0x40,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000000-01000010-00000000
NOTS    P0.B, P0/Z, P0.B  // 00100101-01000000-01000010-00000000
// CHECK: nots    p0.b, p0/z, p0.b // encoding: [0x00,0x42,0x40,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000000-01000010-00000000
nots    p15.b, p15/z, p15.b  // 00100101-01001111-01111111-11101111
// CHECK: nots    p15.b, p15/z, p15.b // encoding: [0xef,0x7f,0x4f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001111-01111111-11101111
NOTS    P15.B, P15/Z, P15.B  // 00100101-01001111-01111111-11101111
// CHECK: nots    p15.b, p15/z, p15.b // encoding: [0xef,0x7f,0x4f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001111-01111111-11101111
nots    p5.b, p5/z, p10.b  // 00100101-01000101-01010111-01000101
// CHECK: nots    p5.b, p5/z, p10.b // encoding: [0x45,0x57,0x45,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000101-01010111-01000101
NOTS    P5.B, P5/Z, P10.B  // 00100101-01000101-01010111-01000101
// CHECK: nots    p5.b, p5/z, p10.b // encoding: [0x45,0x57,0x45,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000101-01010111-01000101
