// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
brkpas  p7.b, p11/z, p13.b, p8.b  // 00100101-01001000-11101101-10100111
// CHECK: brkpas  p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0xed,0x48,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001000-11101101-10100111
BRKPAS  P7.B, P11/Z, P13.B, P8.B  // 00100101-01001000-11101101-10100111
// CHECK: brkpas  p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0xed,0x48,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001000-11101101-10100111
brkpas  p15.b, p15/z, p15.b, p15.b  // 00100101-01001111-11111101-11101111
// CHECK: brkpas  p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0xfd,0x4f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001111-11111101-11101111
BRKPAS  P15.B, P15/Z, P15.B, P15.B  // 00100101-01001111-11111101-11101111
// CHECK: brkpas  p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0xfd,0x4f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001111-11111101-11101111
brkpas  p0.b, p0/z, p0.b, p0.b  // 00100101-01000000-11000000-00000000
// CHECK: brkpas  p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0xc0,0x40,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000000-11000000-00000000
BRKPAS  P0.B, P0/Z, P0.B, P0.B  // 00100101-01000000-11000000-00000000
// CHECK: brkpas  p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0xc0,0x40,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000000-11000000-00000000
brkpas  p5.b, p5/z, p10.b, p5.b  // 00100101-01000101-11010101-01000101
// CHECK: brkpas  p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0xd5,0x45,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000101-11010101-01000101
BRKPAS  P5.B, P5/Z, P10.B, P5.B  // 00100101-01000101-11010101-01000101
// CHECK: brkpas  p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0xd5,0x45,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000101-11010101-01000101
