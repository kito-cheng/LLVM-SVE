// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
brkpa   p15.b, p15/z, p15.b, p15.b  // 00100101-00001111-11111101-11101111
// CHECK: brkpa   p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0xfd,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-11111101-11101111
BRKPA   P15.B, P15/Z, P15.B, P15.B  // 00100101-00001111-11111101-11101111
// CHECK: brkpa   p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0xfd,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-11111101-11101111
brkpa   p5.b, p5/z, p10.b, p5.b  // 00100101-00000101-11010101-01000101
// CHECK: brkpa   p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0xd5,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-11010101-01000101
BRKPA   P5.B, P5/Z, P10.B, P5.B  // 00100101-00000101-11010101-01000101
// CHECK: brkpa   p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0xd5,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-11010101-01000101
brkpa   p0.b, p0/z, p0.b, p0.b  // 00100101-00000000-11000000-00000000
// CHECK: brkpa   p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0xc0,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-11000000-00000000
BRKPA   P0.B, P0/Z, P0.B, P0.B  // 00100101-00000000-11000000-00000000
// CHECK: brkpa   p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0xc0,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-11000000-00000000
brkpa   p7.b, p11/z, p13.b, p8.b  // 00100101-00001000-11101101-10100111
// CHECK: brkpa   p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0xed,0x08,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001000-11101101-10100111
BRKPA   P7.B, P11/Z, P13.B, P8.B  // 00100101-00001000-11101101-10100111
// CHECK: brkpa   p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0xed,0x08,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001000-11101101-10100111
