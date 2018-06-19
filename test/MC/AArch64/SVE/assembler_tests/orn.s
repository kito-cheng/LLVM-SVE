// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
orn     z0.s, z0.s, #0xfffffffe  // 00000101-00000000-00000000-00000000
// CHECK: orr     z0.s, z0.s, #0x1 // encoding: [0x00,0x00,0x00,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00000000-00000000-00000000
ORN     Z0.S, Z0.S, #0xFFFFFFFE  // 00000101-00000000-00000000-00000000
// CHECK: orr     z0.s, z0.s, #0x1 // encoding: [0x00,0x00,0x00,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00000000-00000000-00000000
orn     p5.b, p5/z, p10.b, p5.b  // 00100101-10000101-01010101-01010101
// CHECK: orn     p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x55,0x85,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000101-01010101-01010101
ORN     P5.B, P5/Z, P10.B, P5.B  // 00100101-10000101-01010101-01010101
// CHECK: orn     p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x55,0x85,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000101-01010101-01010101
orn     z21.h, z21.h, #0x3e  // 00000101-00000001-01010101-01010101
// CHECK: orr     z21.h, z21.h, #0xffc1 // encoding: [0x55,0x55,0x00,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00000001-01010101-01010101
ORN     Z21.H, Z21.H, #0x3E  // 00000101-00000001-01010101-01010101
// CHECK: orr     z21.h, z21.h, #0xffc1 // encoding: [0x55,0x55,0x00,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00000001-01010101-01010101
orn     z5.b, z5.b, #0x7e  // 00000101-00000000-00001110-00100101
// CHECK: orr     z5.b, z5.b, #0x81 // encoding: [0x25,0x0e,0x00,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00000000-00001110-00100101
ORN     Z5.B, Z5.B, #0x7E  // 00000101-00000000-00001110-00100101
// CHECK: orr     z5.b, z5.b, #0x81 // encoding: [0x25,0x0e,0x00,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00000000-00001110-00100101
orn     p15.b, p15/z, p15.b, p15.b  // 00100101-10001111-01111101-11111111
// CHECK: orn     p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7d,0x8f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001111-01111101-11111111
ORN     P15.B, P15/Z, P15.B, P15.B  // 00100101-10001111-01111101-11111111
// CHECK: orn     p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7d,0x8f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001111-01111101-11111111
orn     p0.b, p0/z, p0.b, p0.b  // 00100101-10000000-01000000-00010000
// CHECK: orn     p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x40,0x80,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000000-01000000-00010000
ORN     P0.B, P0/Z, P0.B, P0.B  // 00100101-10000000-01000000-00010000
// CHECK: orn     p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x40,0x80,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000000-01000000-00010000
orn     z23.h, z23.h, #0x6  // 00000101-00000000-11101101-10110111
// CHECK: orr     z23.h, z23.h, #0xfff9 // encoding: [0xb7,0x6d,0x00,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00000000-11101101-10110111
ORN     Z23.H, Z23.H, #0x6  // 00000101-00000000-11101101-10110111
// CHECK: orr     z23.h, z23.h, #0xfff9 // encoding: [0xb7,0x6d,0x00,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00000000-11101101-10110111
orn     p7.b, p11/z, p13.b, p8.b  // 00100101-10001000-01101101-10110111
// CHECK: orn     p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6d,0x88,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001000-01101101-10110111
ORN     P7.B, P11/Z, P13.B, P8.B  // 00100101-10001000-01101101-10110111
// CHECK: orn     p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6d,0x88,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001000-01101101-10110111
