// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
nand    p0.b, p0/z, p0.b, p0.b  // 00100101-10000000-01000010-00010000
// CHECK: nand    p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x42,0x80,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000000-01000010-00010000
NAND    P0.B, P0/Z, P0.B, P0.B  // 00100101-10000000-01000010-00010000
// CHECK: nand    p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x42,0x80,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000000-01000010-00010000
nand    p7.b, p11/z, p13.b, p8.b  // 00100101-10001000-01101111-10110111
// CHECK: nand    p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6f,0x88,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001000-01101111-10110111
NAND    P7.B, P11/Z, P13.B, P8.B  // 00100101-10001000-01101111-10110111
// CHECK: nand    p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6f,0x88,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001000-01101111-10110111
nand    p15.b, p15/z, p15.b, p15.b  // 00100101-10001111-01111111-11111111
// CHECK: nand    p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7f,0x8f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001111-01111111-11111111
NAND    P15.B, P15/Z, P15.B, P15.B  // 00100101-10001111-01111111-11111111
// CHECK: nand    p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7f,0x8f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001111-01111111-11111111
nand    p5.b, p5/z, p10.b, p5.b  // 00100101-10000101-01010111-01010101
// CHECK: nand    p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x57,0x85,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000101-01010111-01010101
NAND    P5.B, P5/Z, P10.B, P5.B  // 00100101-10000101-01010111-01010101
// CHECK: nand    p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x57,0x85,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000101-01010111-01010101
