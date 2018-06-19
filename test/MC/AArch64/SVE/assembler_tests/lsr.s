// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsr     z31.h, p7/m, z31.h, z31.h  // 00000100-01010001-10011111-11111111
// CHECK: lsr     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10011111-11111111
LSR     Z31.H, P7/M, Z31.H, Z31.H  // 00000100-01010001-10011111-11111111
// CHECK: lsr     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10011111-11111111
lsr     z23.h, z13.h, #8  // 00000100-00111000-10010101-10110111
// CHECK: lsr     z23.h, z13.h, #8 // encoding: [0xb7,0x95,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-10010101-10110111
LSR     Z23.H, Z13.H, #8  // 00000100-00111000-10010101-10110111
// CHECK: lsr     z23.h, z13.h, #8 // encoding: [0xb7,0x95,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-10010101-10110111
lsr     z31.d, p7/m, z31.d, z31.d  // 00000100-11010001-10011111-11111111
// CHECK: lsr     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10011111-11111111
LSR     Z31.D, P7/M, Z31.D, Z31.D  // 00000100-11010001-10011111-11111111
// CHECK: lsr     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10011111-11111111
lsr     z0.s, p0/m, z0.s, #32  // 00000100-01000001-10000000-00000000
// CHECK: lsr     z0.s, p0/m, z0.s, #32 // encoding: [0x00,0x80,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-10000000-00000000
LSR     Z0.S, P0/M, Z0.S, #32  // 00000100-01000001-10000000-00000000
// CHECK: lsr     z0.s, p0/m, z0.s, #32 // encoding: [0x00,0x80,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-10000000-00000000
lsr     z0.d, p0/m, z0.d, #64  // 00000100-10000001-10000000-00000000
// CHECK: lsr     z0.d, p0/m, z0.d, #64 // encoding: [0x00,0x80,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000001-10000000-00000000
LSR     Z0.D, P0/M, Z0.D, #64  // 00000100-10000001-10000000-00000000
// CHECK: lsr     z0.d, p0/m, z0.d, #64 // encoding: [0x00,0x80,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000001-10000000-00000000
lsr     z23.h, p3/m, z23.h, z13.h  // 00000100-01010001-10001101-10110111
// CHECK: lsr     z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10001101-10110111
LSR     Z23.H, P3/M, Z23.H, Z13.H  // 00000100-01010001-10001101-10110111
// CHECK: lsr     z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10001101-10110111
lsr     z0.s, p0/m, z0.s, z0.s  // 00000100-10010001-10000000-00000000
// CHECK: lsr     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10000000-00000000
LSR     Z0.S, P0/M, Z0.S, Z0.S  // 00000100-10010001-10000000-00000000
// CHECK: lsr     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10000000-00000000
lsr     z0.b, z0.b, z0.d  // 00000100-00100000-10000100-00000000
// CHECK: lsr     z0.b, z0.b, z0.d // encoding: [0x00,0x84,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10000100-00000000
LSR     Z0.B, Z0.B, Z0.D  // 00000100-00100000-10000100-00000000
// CHECK: lsr     z0.b, z0.b, z0.d // encoding: [0x00,0x84,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10000100-00000000
lsr     z31.b, p7/m, z31.b, #1  // 00000100-00000001-10011101-11111111
// CHECK: lsr     z31.b, p7/m, z31.b, #1 // encoding: [0xff,0x9d,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10011101-11111111
LSR     Z31.B, P7/M, Z31.B, #1  // 00000100-00000001-10011101-11111111
// CHECK: lsr     z31.b, p7/m, z31.b, #1 // encoding: [0xff,0x9d,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10011101-11111111
lsr     z0.b, p0/m, z0.b, #8  // 00000100-00000001-10000001-00000000
// CHECK: lsr     z0.b, p0/m, z0.b, #8 // encoding: [0x00,0x81,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10000001-00000000
LSR     Z0.B, P0/M, Z0.B, #8  // 00000100-00000001-10000001-00000000
// CHECK: lsr     z0.b, p0/m, z0.b, #8 // encoding: [0x00,0x81,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10000001-00000000
lsr     z23.b, z13.b, #8  // 00000100-00101000-10010101-10110111
// CHECK: lsr     z23.b, z13.b, #8 // encoding: [0xb7,0x95,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10010101-10110111
LSR     Z23.B, Z13.B, #8  // 00000100-00101000-10010101-10110111
// CHECK: lsr     z23.b, z13.b, #8 // encoding: [0xb7,0x95,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10010101-10110111
lsr     z31.b, p7/m, z31.b, z31.b  // 00000100-00010001-10011111-11111111
// CHECK: lsr     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x9f,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-10011111-11111111
LSR     Z31.B, P7/M, Z31.B, Z31.B  // 00000100-00010001-10011111-11111111
// CHECK: lsr     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x9f,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-10011111-11111111
lsr     z21.d, z10.d, #11  // 00000100-11110101-10010101-01010101
// CHECK: lsr     z21.d, z10.d, #11 // encoding: [0x55,0x95,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10010101-01010101
LSR     Z21.D, Z10.D, #11  // 00000100-11110101-10010101-01010101
// CHECK: lsr     z21.d, z10.d, #11 // encoding: [0x55,0x95,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10010101-01010101
lsr     z23.d, p3/m, z23.d, z13.d  // 00000100-11010001-10001101-10110111
// CHECK: lsr     z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10001101-10110111
LSR     Z23.D, P3/M, Z23.D, Z13.D  // 00000100-11010001-10001101-10110111
// CHECK: lsr     z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10001101-10110111
lsr     z31.h, p7/m, z31.h, #1  // 00000100-00000001-10011111-11111111
// CHECK: lsr     z31.h, p7/m, z31.h, #1 // encoding: [0xff,0x9f,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10011111-11111111
LSR     Z31.H, P7/M, Z31.H, #1  // 00000100-00000001-10011111-11111111
// CHECK: lsr     z31.h, p7/m, z31.h, #1 // encoding: [0xff,0x9f,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10011111-11111111
lsr     z23.d, z13.d, #24  // 00000100-11101000-10010101-10110111
// CHECK: lsr     z23.d, z13.d, #24 // encoding: [0xb7,0x95,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10010101-10110111
LSR     Z23.D, Z13.D, #24  // 00000100-11101000-10010101-10110111
// CHECK: lsr     z23.d, z13.d, #24 // encoding: [0xb7,0x95,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10010101-10110111
lsr     z0.h, z0.h, z0.d  // 00000100-01100000-10000100-00000000
// CHECK: lsr     z0.h, z0.h, z0.d // encoding: [0x00,0x84,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10000100-00000000
LSR     Z0.H, Z0.H, Z0.D  // 00000100-01100000-10000100-00000000
// CHECK: lsr     z0.h, z0.h, z0.d // encoding: [0x00,0x84,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10000100-00000000
lsr     z21.d, p5/m, z21.d, #22  // 00000100-11000001-10010101-01010101
// CHECK: lsr     z21.d, p5/m, z21.d, #22 // encoding: [0x55,0x95,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-10010101-01010101
LSR     Z21.D, P5/M, Z21.D, #22  // 00000100-11000001-10010101-01010101
// CHECK: lsr     z21.d, p5/m, z21.d, #22 // encoding: [0x55,0x95,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-10010101-01010101
lsr     z21.h, z10.h, #11  // 00000100-00110101-10010101-01010101
// CHECK: lsr     z21.h, z10.h, #11 // encoding: [0x55,0x95,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10010101-01010101
LSR     Z21.H, Z10.H, #11  // 00000100-00110101-10010101-01010101
// CHECK: lsr     z21.h, z10.h, #11 // encoding: [0x55,0x95,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10010101-01010101
lsr     z0.d, z0.d, #64  // 00000100-10100000-10010100-00000000
// CHECK: lsr     z0.d, z0.d, #64 // encoding: [0x00,0x94,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10010100-00000000
LSR     Z0.D, Z0.D, #64  // 00000100-10100000-10010100-00000000
// CHECK: lsr     z0.d, z0.d, #64 // encoding: [0x00,0x94,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10010100-00000000
lsr     z21.b, p5/m, z21.b, z10.b  // 00000100-00010001-10010101-01010101
// CHECK: lsr     z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x95,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-10010101-01010101
LSR     Z21.B, P5/M, Z21.B, Z10.B  // 00000100-00010001-10010101-01010101
// CHECK: lsr     z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x95,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-10010101-01010101
lsr     z21.h, z10.h, z21.d  // 00000100-01110101-10000101-01010101
// CHECK: lsr     z21.h, z10.h, z21.d // encoding: [0x55,0x85,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10000101-01010101
LSR     Z21.H, Z10.H, Z21.D  // 00000100-01110101-10000101-01010101
// CHECK: lsr     z21.h, z10.h, z21.d // encoding: [0x55,0x85,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10000101-01010101
lsr     z23.h, p3/m, z23.h, #3  // 00000100-00000001-10001111-10110111
// CHECK: lsr     z23.h, p3/m, z23.h, #3 // encoding: [0xb7,0x8f,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10001111-10110111
LSR     Z23.H, P3/M, Z23.H, #3  // 00000100-00000001-10001111-10110111
// CHECK: lsr     z23.h, p3/m, z23.h, #3 // encoding: [0xb7,0x8f,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10001111-10110111
lsr     z21.d, p5/m, z21.d, z10.d  // 00000100-11010001-10010101-01010101
// CHECK: lsr     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10010101-01010101
LSR     Z21.D, P5/M, Z21.D, Z10.D  // 00000100-11010001-10010101-01010101
// CHECK: lsr     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10010101-01010101
lsr     z23.s, p3/m, z23.s, z13.s  // 00000100-10010001-10001101-10110111
// CHECK: lsr     z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10001101-10110111
LSR     Z23.S, P3/M, Z23.S, Z13.S  // 00000100-10010001-10001101-10110111
// CHECK: lsr     z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10001101-10110111
lsr     z23.b, z13.b, z8.d  // 00000100-00101000-10000101-10110111
// CHECK: lsr     z23.b, z13.b, z8.d // encoding: [0xb7,0x85,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10000101-10110111
LSR     Z23.B, Z13.B, Z8.D  // 00000100-00101000-10000101-10110111
// CHECK: lsr     z23.b, z13.b, z8.d // encoding: [0xb7,0x85,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10000101-10110111
lsr     z23.s, p3/m, z23.s, #19  // 00000100-01000001-10001101-10110111
// CHECK: lsr     z23.s, p3/m, z23.s, #19 // encoding: [0xb7,0x8d,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-10001101-10110111
LSR     Z23.S, P3/M, Z23.S, #19  // 00000100-01000001-10001101-10110111
// CHECK: lsr     z23.s, p3/m, z23.s, #19 // encoding: [0xb7,0x8d,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-10001101-10110111
lsr     z0.s, z0.s, #32  // 00000100-01100000-10010100-00000000
// CHECK: lsr     z0.s, z0.s, #32 // encoding: [0x00,0x94,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10010100-00000000
LSR     Z0.S, Z0.S, #32  // 00000100-01100000-10010100-00000000
// CHECK: lsr     z0.s, z0.s, #32 // encoding: [0x00,0x94,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10010100-00000000
lsr     z0.h, p0/m, z0.h, z0.d  // 00000100-01011001-10000000-00000000
// CHECK: lsr     z0.h, p0/m, z0.h, z0.d // encoding: [0x00,0x80,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10000000-00000000
LSR     Z0.H, P0/M, Z0.H, Z0.D  // 00000100-01011001-10000000-00000000
// CHECK: lsr     z0.h, p0/m, z0.h, z0.d // encoding: [0x00,0x80,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10000000-00000000
lsr     z31.b, z31.b, z31.d  // 00000100-00111111-10000111-11111111
// CHECK: lsr     z31.b, z31.b, z31.d // encoding: [0xff,0x87,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10000111-11111111
LSR     Z31.B, Z31.B, Z31.D  // 00000100-00111111-10000111-11111111
// CHECK: lsr     z31.b, z31.b, z31.d // encoding: [0xff,0x87,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10000111-11111111
lsr     z31.s, z31.s, #1  // 00000100-01111111-10010111-11111111
// CHECK: lsr     z31.s, z31.s, #1 // encoding: [0xff,0x97,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10010111-11111111
LSR     Z31.S, Z31.S, #1  // 00000100-01111111-10010111-11111111
// CHECK: lsr     z31.s, z31.s, #1 // encoding: [0xff,0x97,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10010111-11111111
lsr     z23.d, p3/m, z23.d, #19  // 00000100-11000001-10001101-10110111
// CHECK: lsr     z23.d, p3/m, z23.d, #19 // encoding: [0xb7,0x8d,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-10001101-10110111
LSR     Z23.D, P3/M, Z23.D, #19  // 00000100-11000001-10001101-10110111
// CHECK: lsr     z23.d, p3/m, z23.d, #19 // encoding: [0xb7,0x8d,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-10001101-10110111
lsr     z21.b, p5/m, z21.b, z10.d  // 00000100-00011001-10010101-01010101
// CHECK: lsr     z21.b, p5/m, z21.b, z10.d // encoding: [0x55,0x95,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10010101-01010101
LSR     Z21.B, P5/M, Z21.B, Z10.D  // 00000100-00011001-10010101-01010101
// CHECK: lsr     z21.b, p5/m, z21.b, z10.d // encoding: [0x55,0x95,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10010101-01010101
lsr     z21.s, z10.s, #11  // 00000100-01110101-10010101-01010101
// CHECK: lsr     z21.s, z10.s, #11 // encoding: [0x55,0x95,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10010101-01010101
LSR     Z21.S, Z10.S, #11  // 00000100-01110101-10010101-01010101
// CHECK: lsr     z21.s, z10.s, #11 // encoding: [0x55,0x95,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10010101-01010101
lsr     z21.b, z10.b, z21.d  // 00000100-00110101-10000101-01010101
// CHECK: lsr     z21.b, z10.b, z21.d // encoding: [0x55,0x85,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10000101-01010101
LSR     Z21.B, Z10.B, Z21.D  // 00000100-00110101-10000101-01010101
// CHECK: lsr     z21.b, z10.b, z21.d // encoding: [0x55,0x85,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10000101-01010101
lsr     z0.b, p0/m, z0.b, z0.d  // 00000100-00011001-10000000-00000000
// CHECK: lsr     z0.b, p0/m, z0.b, z0.d // encoding: [0x00,0x80,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10000000-00000000
LSR     Z0.B, P0/M, Z0.B, Z0.D  // 00000100-00011001-10000000-00000000
// CHECK: lsr     z0.b, p0/m, z0.b, z0.d // encoding: [0x00,0x80,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10000000-00000000
lsr     z31.d, z31.d, #1  // 00000100-11111111-10010111-11111111
// CHECK: lsr     z31.d, z31.d, #1 // encoding: [0xff,0x97,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10010111-11111111
LSR     Z31.D, Z31.D, #1  // 00000100-11111111-10010111-11111111
// CHECK: lsr     z31.d, z31.d, #1 // encoding: [0xff,0x97,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10010111-11111111
lsr     z31.h, p7/m, z31.h, z31.d  // 00000100-01011001-10011111-11111111
// CHECK: lsr     z31.h, p7/m, z31.h, z31.d // encoding: [0xff,0x9f,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10011111-11111111
LSR     Z31.H, P7/M, Z31.H, Z31.D  // 00000100-01011001-10011111-11111111
// CHECK: lsr     z31.h, p7/m, z31.h, z31.d // encoding: [0xff,0x9f,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10011111-11111111
lsr     z21.h, p5/m, z21.h, #6  // 00000100-00000001-10010111-01010101
// CHECK: lsr     z21.h, p5/m, z21.h, #6 // encoding: [0x55,0x97,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10010111-01010101
LSR     Z21.H, P5/M, Z21.H, #6  // 00000100-00000001-10010111-01010101
// CHECK: lsr     z21.h, p5/m, z21.h, #6 // encoding: [0x55,0x97,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10010111-01010101
lsr     z0.b, p0/m, z0.b, z0.b  // 00000100-00010001-10000000-00000000
// CHECK: lsr     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x80,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-10000000-00000000
LSR     Z0.B, P0/M, Z0.B, Z0.B  // 00000100-00010001-10000000-00000000
// CHECK: lsr     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x80,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-10000000-00000000
lsr     z0.h, p0/m, z0.h, z0.h  // 00000100-01010001-10000000-00000000
// CHECK: lsr     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10000000-00000000
LSR     Z0.H, P0/M, Z0.H, Z0.H  // 00000100-01010001-10000000-00000000
// CHECK: lsr     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10000000-00000000
lsr     z31.s, p7/m, z31.s, #1  // 00000100-01000001-10011111-11111111
// CHECK: lsr     z31.s, p7/m, z31.s, #1 // encoding: [0xff,0x9f,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-10011111-11111111
LSR     Z31.S, P7/M, Z31.S, #1  // 00000100-01000001-10011111-11111111
// CHECK: lsr     z31.s, p7/m, z31.s, #1 // encoding: [0xff,0x9f,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-10011111-11111111
lsr     z21.s, p5/m, z21.s, #22  // 00000100-01000001-10010101-01010101
// CHECK: lsr     z21.s, p5/m, z21.s, #22 // encoding: [0x55,0x95,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-10010101-01010101
LSR     Z21.S, P5/M, Z21.S, #22  // 00000100-01000001-10010101-01010101
// CHECK: lsr     z21.s, p5/m, z21.s, #22 // encoding: [0x55,0x95,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-10010101-01010101
lsr     z23.s, z13.s, z8.d  // 00000100-10101000-10000101-10110111
// CHECK: lsr     z23.s, z13.s, z8.d // encoding: [0xb7,0x85,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10000101-10110111
LSR     Z23.S, Z13.S, Z8.D  // 00000100-10101000-10000101-10110111
// CHECK: lsr     z23.s, z13.s, z8.d // encoding: [0xb7,0x85,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10000101-10110111
lsr     z21.h, p5/m, z21.h, z10.h  // 00000100-01010001-10010101-01010101
// CHECK: lsr     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10010101-01010101
LSR     Z21.H, P5/M, Z21.H, Z10.H  // 00000100-01010001-10010101-01010101
// CHECK: lsr     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10010101-01010101
lsr     z21.s, p5/m, z21.s, z10.s  // 00000100-10010001-10010101-01010101
// CHECK: lsr     z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10010101-01010101
LSR     Z21.S, P5/M, Z21.S, Z10.S  // 00000100-10010001-10010101-01010101
// CHECK: lsr     z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10010101-01010101
lsr     z21.s, z10.s, z21.d  // 00000100-10110101-10000101-01010101
// CHECK: lsr     z21.s, z10.s, z21.d // encoding: [0x55,0x85,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10000101-01010101
LSR     Z21.S, Z10.S, Z21.D  // 00000100-10110101-10000101-01010101
// CHECK: lsr     z21.s, z10.s, z21.d // encoding: [0x55,0x85,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10000101-01010101
lsr     z0.h, p0/m, z0.h, #16  // 00000100-00000001-10000010-00000000
// CHECK: lsr     z0.h, p0/m, z0.h, #16 // encoding: [0x00,0x82,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10000010-00000000
LSR     Z0.H, P0/M, Z0.H, #16  // 00000100-00000001-10000010-00000000
// CHECK: lsr     z0.h, p0/m, z0.h, #16 // encoding: [0x00,0x82,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10000010-00000000
lsr     z21.s, p5/m, z21.s, z10.d  // 00000100-10011001-10010101-01010101
// CHECK: lsr     z21.s, p5/m, z21.s, z10.d // encoding: [0x55,0x95,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10010101-01010101
LSR     Z21.S, P5/M, Z21.S, Z10.D  // 00000100-10011001-10010101-01010101
// CHECK: lsr     z21.s, p5/m, z21.s, z10.d // encoding: [0x55,0x95,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10010101-01010101
lsr     z31.h, z31.h, z31.d  // 00000100-01111111-10000111-11111111
// CHECK: lsr     z31.h, z31.h, z31.d // encoding: [0xff,0x87,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10000111-11111111
LSR     Z31.H, Z31.H, Z31.D  // 00000100-01111111-10000111-11111111
// CHECK: lsr     z31.h, z31.h, z31.d // encoding: [0xff,0x87,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10000111-11111111
lsr     z23.h, z13.h, z8.d  // 00000100-01101000-10000101-10110111
// CHECK: lsr     z23.h, z13.h, z8.d // encoding: [0xb7,0x85,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10000101-10110111
LSR     Z23.H, Z13.H, Z8.D  // 00000100-01101000-10000101-10110111
// CHECK: lsr     z23.h, z13.h, z8.d // encoding: [0xb7,0x85,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10000101-10110111
lsr     z31.s, p7/m, z31.s, z31.s  // 00000100-10010001-10011111-11111111
// CHECK: lsr     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10011111-11111111
LSR     Z31.S, P7/M, Z31.S, Z31.S  // 00000100-10010001-10011111-11111111
// CHECK: lsr     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10011111-11111111
lsr     z31.h, z31.h, #1  // 00000100-00111111-10010111-11111111
// CHECK: lsr     z31.h, z31.h, #1 // encoding: [0xff,0x97,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10010111-11111111
LSR     Z31.H, Z31.H, #1  // 00000100-00111111-10010111-11111111
// CHECK: lsr     z31.h, z31.h, #1 // encoding: [0xff,0x97,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10010111-11111111
lsr     z23.b, p3/m, z23.b, z13.b  // 00000100-00010001-10001101-10110111
// CHECK: lsr     z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x8d,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-10001101-10110111
LSR     Z23.B, P3/M, Z23.B, Z13.B  // 00000100-00010001-10001101-10110111
// CHECK: lsr     z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x8d,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-10001101-10110111
lsr     z23.s, p3/m, z23.s, z13.d  // 00000100-10011001-10001101-10110111
// CHECK: lsr     z23.s, p3/m, z23.s, z13.d // encoding: [0xb7,0x8d,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10001101-10110111
LSR     Z23.S, P3/M, Z23.S, Z13.D  // 00000100-10011001-10001101-10110111
// CHECK: lsr     z23.s, p3/m, z23.s, z13.d // encoding: [0xb7,0x8d,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10001101-10110111
lsr     z0.h, z0.h, #16  // 00000100-00110000-10010100-00000000
// CHECK: lsr     z0.h, z0.h, #16 // encoding: [0x00,0x94,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-10010100-00000000
LSR     Z0.H, Z0.H, #16  // 00000100-00110000-10010100-00000000
// CHECK: lsr     z0.h, z0.h, #16 // encoding: [0x00,0x94,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-10010100-00000000
lsr     z23.s, z13.s, #24  // 00000100-01101000-10010101-10110111
// CHECK: lsr     z23.s, z13.s, #24 // encoding: [0xb7,0x95,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10010101-10110111
LSR     Z23.S, Z13.S, #24  // 00000100-01101000-10010101-10110111
// CHECK: lsr     z23.s, z13.s, #24 // encoding: [0xb7,0x95,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10010101-10110111
lsr     z23.b, p3/m, z23.b, #3  // 00000100-00000001-10001101-10110111
// CHECK: lsr     z23.b, p3/m, z23.b, #3 // encoding: [0xb7,0x8d,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10001101-10110111
LSR     Z23.B, P3/M, Z23.B, #3  // 00000100-00000001-10001101-10110111
// CHECK: lsr     z23.b, p3/m, z23.b, #3 // encoding: [0xb7,0x8d,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10001101-10110111
lsr     z31.b, p7/m, z31.b, z31.d  // 00000100-00011001-10011111-11111111
// CHECK: lsr     z31.b, p7/m, z31.b, z31.d // encoding: [0xff,0x9f,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10011111-11111111
LSR     Z31.B, P7/M, Z31.B, Z31.D  // 00000100-00011001-10011111-11111111
// CHECK: lsr     z31.b, p7/m, z31.b, z31.d // encoding: [0xff,0x9f,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10011111-11111111
lsr     z23.h, p3/m, z23.h, z13.d  // 00000100-01011001-10001101-10110111
// CHECK: lsr     z23.h, p3/m, z23.h, z13.d // encoding: [0xb7,0x8d,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10001101-10110111
LSR     Z23.H, P3/M, Z23.H, Z13.D  // 00000100-01011001-10001101-10110111
// CHECK: lsr     z23.h, p3/m, z23.h, z13.d // encoding: [0xb7,0x8d,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10001101-10110111
lsr     z0.s, z0.s, z0.d  // 00000100-10100000-10000100-00000000
// CHECK: lsr     z0.s, z0.s, z0.d // encoding: [0x00,0x84,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10000100-00000000
LSR     Z0.S, Z0.S, Z0.D  // 00000100-10100000-10000100-00000000
// CHECK: lsr     z0.s, z0.s, z0.d // encoding: [0x00,0x84,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10000100-00000000
lsr     z21.b, p5/m, z21.b, #6  // 00000100-00000001-10010101-01010101
// CHECK: lsr     z21.b, p5/m, z21.b, #6 // encoding: [0x55,0x95,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10010101-01010101
LSR     Z21.B, P5/M, Z21.B, #6  // 00000100-00000001-10010101-01010101
// CHECK: lsr     z21.b, p5/m, z21.b, #6 // encoding: [0x55,0x95,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-10010101-01010101
lsr     z31.s, z31.s, z31.d  // 00000100-10111111-10000111-11111111
// CHECK: lsr     z31.s, z31.s, z31.d // encoding: [0xff,0x87,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10000111-11111111
LSR     Z31.S, Z31.S, Z31.D  // 00000100-10111111-10000111-11111111
// CHECK: lsr     z31.s, z31.s, z31.d // encoding: [0xff,0x87,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10000111-11111111
lsr     z31.d, p7/m, z31.d, #1  // 00000100-11000001-10011111-11111111
// CHECK: lsr     z31.d, p7/m, z31.d, #1 // encoding: [0xff,0x9f,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-10011111-11111111
LSR     Z31.D, P7/M, Z31.D, #1  // 00000100-11000001-10011111-11111111
// CHECK: lsr     z31.d, p7/m, z31.d, #1 // encoding: [0xff,0x9f,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-10011111-11111111
lsr     z0.b, z0.b, #8  // 00000100-00101000-10010100-00000000
// CHECK: lsr     z0.b, z0.b, #8 // encoding: [0x00,0x94,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10010100-00000000
LSR     Z0.B, Z0.B, #8  // 00000100-00101000-10010100-00000000
// CHECK: lsr     z0.b, z0.b, #8 // encoding: [0x00,0x94,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10010100-00000000
lsr     z23.b, p3/m, z23.b, z13.d  // 00000100-00011001-10001101-10110111
// CHECK: lsr     z23.b, p3/m, z23.b, z13.d // encoding: [0xb7,0x8d,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10001101-10110111
LSR     Z23.B, P3/M, Z23.B, Z13.D  // 00000100-00011001-10001101-10110111
// CHECK: lsr     z23.b, p3/m, z23.b, z13.d // encoding: [0xb7,0x8d,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10001101-10110111
lsr     z21.b, z10.b, #3  // 00000100-00101101-10010101-01010101
// CHECK: lsr     z21.b, z10.b, #3 // encoding: [0x55,0x95,0x2d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101101-10010101-01010101
LSR     Z21.B, Z10.B, #3  // 00000100-00101101-10010101-01010101
// CHECK: lsr     z21.b, z10.b, #3 // encoding: [0x55,0x95,0x2d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101101-10010101-01010101
lsr     z31.b, z31.b, #1  // 00000100-00101111-10010111-11111111
// CHECK: lsr     z31.b, z31.b, #1 // encoding: [0xff,0x97,0x2f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101111-10010111-11111111
LSR     Z31.B, Z31.B, #1  // 00000100-00101111-10010111-11111111
// CHECK: lsr     z31.b, z31.b, #1 // encoding: [0xff,0x97,0x2f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101111-10010111-11111111
lsr     z0.d, p0/m, z0.d, z0.d  // 00000100-11010001-10000000-00000000
// CHECK: lsr     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10000000-00000000
LSR     Z0.D, P0/M, Z0.D, Z0.D  // 00000100-11010001-10000000-00000000
// CHECK: lsr     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10000000-00000000
lsr     z0.s, p0/m, z0.s, z0.d  // 00000100-10011001-10000000-00000000
// CHECK: lsr     z0.s, p0/m, z0.s, z0.d // encoding: [0x00,0x80,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10000000-00000000
LSR     Z0.S, P0/M, Z0.S, Z0.D  // 00000100-10011001-10000000-00000000
// CHECK: lsr     z0.s, p0/m, z0.s, z0.d // encoding: [0x00,0x80,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10000000-00000000
lsr     z31.s, p7/m, z31.s, z31.d  // 00000100-10011001-10011111-11111111
// CHECK: lsr     z31.s, p7/m, z31.s, z31.d // encoding: [0xff,0x9f,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10011111-11111111
LSR     Z31.S, P7/M, Z31.S, Z31.D  // 00000100-10011001-10011111-11111111
// CHECK: lsr     z31.s, p7/m, z31.s, z31.d // encoding: [0xff,0x9f,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10011111-11111111
lsr     z21.h, p5/m, z21.h, z10.d  // 00000100-01011001-10010101-01010101
// CHECK: lsr     z21.h, p5/m, z21.h, z10.d // encoding: [0x55,0x95,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10010101-01010101
LSR     Z21.H, P5/M, Z21.H, Z10.D  // 00000100-01011001-10010101-01010101
// CHECK: lsr     z21.h, p5/m, z21.h, z10.d // encoding: [0x55,0x95,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10010101-01010101
