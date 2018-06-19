// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
asrd    z23.d, p3/m, z23.d, #19  // 00000100-11000100-10001101-10110111
// CHECK: asrd    z23.d, p3/m, z23.d, #19 // encoding: [0xb7,0x8d,0xc4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000100-10001101-10110111
ASRD    Z23.D, P3/M, Z23.D, #19  // 00000100-11000100-10001101-10110111
// CHECK: asrd    z23.d, p3/m, z23.d, #19 // encoding: [0xb7,0x8d,0xc4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000100-10001101-10110111
asrd    z0.d, p0/m, z0.d, #64  // 00000100-10000100-10000000-00000000
// CHECK: asrd    z0.d, p0/m, z0.d, #64 // encoding: [0x00,0x80,0x84,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000100-10000000-00000000
ASRD    Z0.D, P0/M, Z0.D, #64  // 00000100-10000100-10000000-00000000
// CHECK: asrd    z0.d, p0/m, z0.d, #64 // encoding: [0x00,0x80,0x84,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000100-10000000-00000000
asrd    z31.s, p7/m, z31.s, #1  // 00000100-01000100-10011111-11111111
// CHECK: asrd    z31.s, p7/m, z31.s, #1 // encoding: [0xff,0x9f,0x44,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000100-10011111-11111111
ASRD    Z31.S, P7/M, Z31.S, #1  // 00000100-01000100-10011111-11111111
// CHECK: asrd    z31.s, p7/m, z31.s, #1 // encoding: [0xff,0x9f,0x44,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000100-10011111-11111111
asrd    z31.h, p7/m, z31.h, #1  // 00000100-00000100-10011111-11111111
// CHECK: asrd    z31.h, p7/m, z31.h, #1 // encoding: [0xff,0x9f,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10011111-11111111
ASRD    Z31.H, P7/M, Z31.H, #1  // 00000100-00000100-10011111-11111111
// CHECK: asrd    z31.h, p7/m, z31.h, #1 // encoding: [0xff,0x9f,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10011111-11111111
asrd    z0.h, p0/m, z0.h, #16  // 00000100-00000100-10000010-00000000
// CHECK: asrd    z0.h, p0/m, z0.h, #16 // encoding: [0x00,0x82,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10000010-00000000
ASRD    Z0.H, P0/M, Z0.H, #16  // 00000100-00000100-10000010-00000000
// CHECK: asrd    z0.h, p0/m, z0.h, #16 // encoding: [0x00,0x82,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10000010-00000000
asrd    z21.h, p5/m, z21.h, #6  // 00000100-00000100-10010111-01010101
// CHECK: asrd    z21.h, p5/m, z21.h, #6 // encoding: [0x55,0x97,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10010111-01010101
ASRD    Z21.H, P5/M, Z21.H, #6  // 00000100-00000100-10010111-01010101
// CHECK: asrd    z21.h, p5/m, z21.h, #6 // encoding: [0x55,0x97,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10010111-01010101
asrd    z31.d, p7/m, z31.d, #1  // 00000100-11000100-10011111-11111111
// CHECK: asrd    z31.d, p7/m, z31.d, #1 // encoding: [0xff,0x9f,0xc4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000100-10011111-11111111
ASRD    Z31.D, P7/M, Z31.D, #1  // 00000100-11000100-10011111-11111111
// CHECK: asrd    z31.d, p7/m, z31.d, #1 // encoding: [0xff,0x9f,0xc4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000100-10011111-11111111
asrd    z23.b, p3/m, z23.b, #3  // 00000100-00000100-10001101-10110111
// CHECK: asrd    z23.b, p3/m, z23.b, #3 // encoding: [0xb7,0x8d,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10001101-10110111
ASRD    Z23.B, P3/M, Z23.B, #3  // 00000100-00000100-10001101-10110111
// CHECK: asrd    z23.b, p3/m, z23.b, #3 // encoding: [0xb7,0x8d,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10001101-10110111
asrd    z21.d, p5/m, z21.d, #22  // 00000100-11000100-10010101-01010101
// CHECK: asrd    z21.d, p5/m, z21.d, #22 // encoding: [0x55,0x95,0xc4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000100-10010101-01010101
ASRD    Z21.D, P5/M, Z21.D, #22  // 00000100-11000100-10010101-01010101
// CHECK: asrd    z21.d, p5/m, z21.d, #22 // encoding: [0x55,0x95,0xc4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000100-10010101-01010101
asrd    z21.s, p5/m, z21.s, #22  // 00000100-01000100-10010101-01010101
// CHECK: asrd    z21.s, p5/m, z21.s, #22 // encoding: [0x55,0x95,0x44,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000100-10010101-01010101
ASRD    Z21.S, P5/M, Z21.S, #22  // 00000100-01000100-10010101-01010101
// CHECK: asrd    z21.s, p5/m, z21.s, #22 // encoding: [0x55,0x95,0x44,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000100-10010101-01010101
asrd    z31.b, p7/m, z31.b, #1  // 00000100-00000100-10011101-11111111
// CHECK: asrd    z31.b, p7/m, z31.b, #1 // encoding: [0xff,0x9d,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10011101-11111111
ASRD    Z31.B, P7/M, Z31.B, #1  // 00000100-00000100-10011101-11111111
// CHECK: asrd    z31.b, p7/m, z31.b, #1 // encoding: [0xff,0x9d,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10011101-11111111
asrd    z0.s, p0/m, z0.s, #32  // 00000100-01000100-10000000-00000000
// CHECK: asrd    z0.s, p0/m, z0.s, #32 // encoding: [0x00,0x80,0x44,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000100-10000000-00000000
ASRD    Z0.S, P0/M, Z0.S, #32  // 00000100-01000100-10000000-00000000
// CHECK: asrd    z0.s, p0/m, z0.s, #32 // encoding: [0x00,0x80,0x44,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000100-10000000-00000000
asrd    z0.b, p0/m, z0.b, #8  // 00000100-00000100-10000001-00000000
// CHECK: asrd    z0.b, p0/m, z0.b, #8 // encoding: [0x00,0x81,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10000001-00000000
ASRD    Z0.B, P0/M, Z0.B, #8  // 00000100-00000100-10000001-00000000
// CHECK: asrd    z0.b, p0/m, z0.b, #8 // encoding: [0x00,0x81,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10000001-00000000
asrd    z23.h, p3/m, z23.h, #3  // 00000100-00000100-10001111-10110111
// CHECK: asrd    z23.h, p3/m, z23.h, #3 // encoding: [0xb7,0x8f,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10001111-10110111
ASRD    Z23.H, P3/M, Z23.H, #3  // 00000100-00000100-10001111-10110111
// CHECK: asrd    z23.h, p3/m, z23.h, #3 // encoding: [0xb7,0x8f,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10001111-10110111
asrd    z23.s, p3/m, z23.s, #19  // 00000100-01000100-10001101-10110111
// CHECK: asrd    z23.s, p3/m, z23.s, #19 // encoding: [0xb7,0x8d,0x44,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000100-10001101-10110111
ASRD    Z23.S, P3/M, Z23.S, #19  // 00000100-01000100-10001101-10110111
// CHECK: asrd    z23.s, p3/m, z23.s, #19 // encoding: [0xb7,0x8d,0x44,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000100-10001101-10110111
asrd    z21.b, p5/m, z21.b, #6  // 00000100-00000100-10010101-01010101
// CHECK: asrd    z21.b, p5/m, z21.b, #6 // encoding: [0x55,0x95,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10010101-01010101
ASRD    Z21.B, P5/M, Z21.B, #6  // 00000100-00000100-10010101-01010101
// CHECK: asrd    z21.b, p5/m, z21.b, #6 // encoding: [0x55,0x95,0x04,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000100-10010101-01010101
