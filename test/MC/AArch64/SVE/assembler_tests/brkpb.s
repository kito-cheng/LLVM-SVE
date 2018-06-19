// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
brkpb   p5.b, p5/z, p10.b, p5.b  // 00100101-00000101-11010101-01010101
// CHECK: brkpb   p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0xd5,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-11010101-01010101
BRKPB   P5.B, P5/Z, P10.B, P5.B  // 00100101-00000101-11010101-01010101
// CHECK: brkpb   p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0xd5,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-11010101-01010101
brkpb   p7.b, p11/z, p13.b, p8.b  // 00100101-00001000-11101101-10110111
// CHECK: brkpb   p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0xed,0x08,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001000-11101101-10110111
BRKPB   P7.B, P11/Z, P13.B, P8.B  // 00100101-00001000-11101101-10110111
// CHECK: brkpb   p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0xed,0x08,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001000-11101101-10110111
brkpb   p0.b, p0/z, p0.b, p0.b  // 00100101-00000000-11000000-00010000
// CHECK: brkpb   p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0xc0,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-11000000-00010000
BRKPB   P0.B, P0/Z, P0.B, P0.B  // 00100101-00000000-11000000-00010000
// CHECK: brkpb   p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0xc0,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-11000000-00010000
brkpb   p15.b, p15/z, p15.b, p15.b  // 00100101-00001111-11111101-11111111
// CHECK: brkpb   p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0xfd,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-11111101-11111111
BRKPB   P15.B, P15/Z, P15.B, P15.B  // 00100101-00001111-11111101-11111111
// CHECK: brkpb   p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0xfd,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-11111101-11111111
