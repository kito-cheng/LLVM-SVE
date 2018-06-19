// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
lsl     z0.b, z0.b, z0.d  // 00000100-00100000-10001100-00000000
// CHECK: lsl     z0.b, z0.b, z0.d // encoding: [0x00,0x8c,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10001100-00000000
LSL     Z0.B, Z0.B, Z0.D  // 00000100-00100000-10001100-00000000
// CHECK: lsl     z0.b, z0.b, z0.d // encoding: [0x00,0x8c,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10001100-00000000
lsl     z0.h, p0/m, z0.h, z0.h  // 00000100-01010011-10000000-00000000
// CHECK: lsl     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x53,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010011-10000000-00000000
LSL     Z0.H, P0/M, Z0.H, Z0.H  // 00000100-01010011-10000000-00000000
// CHECK: lsl     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x53,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010011-10000000-00000000
lsl     z23.h, p3/m, z23.h, z13.d  // 00000100-01011011-10001101-10110111
// CHECK: lsl     z23.h, p3/m, z23.h, z13.d // encoding: [0xb7,0x8d,0x5b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011011-10001101-10110111
LSL     Z23.H, P3/M, Z23.H, Z13.D  // 00000100-01011011-10001101-10110111
// CHECK: lsl     z23.h, p3/m, z23.h, z13.d // encoding: [0xb7,0x8d,0x5b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011011-10001101-10110111
lsl     z23.h, z13.h, #8  // 00000100-00111000-10011101-10110111
// CHECK: lsl     z23.h, z13.h, #8 // encoding: [0xb7,0x9d,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-10011101-10110111
LSL     Z23.H, Z13.H, #8  // 00000100-00111000-10011101-10110111
// CHECK: lsl     z23.h, z13.h, #8 // encoding: [0xb7,0x9d,0x38,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111000-10011101-10110111
lsl     z23.d, p3/m, z23.d, #45  // 00000100-11000011-10001101-10110111
// CHECK: lsl     z23.d, p3/m, z23.d, #45 // encoding: [0xb7,0x8d,0xc3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000011-10001101-10110111
LSL     Z23.D, P3/M, Z23.D, #45  // 00000100-11000011-10001101-10110111
// CHECK: lsl     z23.d, p3/m, z23.d, #45 // encoding: [0xb7,0x8d,0xc3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000011-10001101-10110111
lsl     z21.d, z10.d, #53  // 00000100-11110101-10011101-01010101
// CHECK: lsl     z21.d, z10.d, #53 // encoding: [0x55,0x9d,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10011101-01010101
LSL     Z21.D, Z10.D, #53  // 00000100-11110101-10011101-01010101
// CHECK: lsl     z21.d, z10.d, #53 // encoding: [0x55,0x9d,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10011101-01010101
lsl     z23.b, p3/m, z23.b, z13.d  // 00000100-00011011-10001101-10110111
// CHECK: lsl     z23.b, p3/m, z23.b, z13.d // encoding: [0xb7,0x8d,0x1b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011011-10001101-10110111
LSL     Z23.B, P3/M, Z23.B, Z13.D  // 00000100-00011011-10001101-10110111
// CHECK: lsl     z23.b, p3/m, z23.b, z13.d // encoding: [0xb7,0x8d,0x1b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011011-10001101-10110111
lsl     z31.h, p7/m, z31.h, z31.h  // 00000100-01010011-10011111-11111111
// CHECK: lsl     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x53,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010011-10011111-11111111
LSL     Z31.H, P7/M, Z31.H, Z31.H  // 00000100-01010011-10011111-11111111
// CHECK: lsl     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x53,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010011-10011111-11111111
lsl     z21.s, p5/m, z21.s, z10.d  // 00000100-10011011-10010101-01010101
// CHECK: lsl     z21.s, p5/m, z21.s, z10.d // encoding: [0x55,0x95,0x9b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011011-10010101-01010101
LSL     Z21.S, P5/M, Z21.S, Z10.D  // 00000100-10011011-10010101-01010101
// CHECK: lsl     z21.s, p5/m, z21.s, z10.d // encoding: [0x55,0x95,0x9b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011011-10010101-01010101
lsl     z21.b, p5/m, z21.b, #2  // 00000100-00000011-10010101-01010101
// CHECK: lsl     z21.b, p5/m, z21.b, #2 // encoding: [0x55,0x95,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10010101-01010101
LSL     Z21.B, P5/M, Z21.B, #2  // 00000100-00000011-10010101-01010101
// CHECK: lsl     z21.b, p5/m, z21.b, #2 // encoding: [0x55,0x95,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10010101-01010101
lsl     z31.h, p7/m, z31.h, z31.d  // 00000100-01011011-10011111-11111111
// CHECK: lsl     z31.h, p7/m, z31.h, z31.d // encoding: [0xff,0x9f,0x5b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011011-10011111-11111111
LSL     Z31.H, P7/M, Z31.H, Z31.D  // 00000100-01011011-10011111-11111111
// CHECK: lsl     z31.h, p7/m, z31.h, z31.d // encoding: [0xff,0x9f,0x5b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011011-10011111-11111111
lsl     z31.b, p7/m, z31.b, #7  // 00000100-00000011-10011101-11111111
// CHECK: lsl     z31.b, p7/m, z31.b, #7 // encoding: [0xff,0x9d,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10011101-11111111
LSL     Z31.B, P7/M, Z31.B, #7  // 00000100-00000011-10011101-11111111
// CHECK: lsl     z31.b, p7/m, z31.b, #7 // encoding: [0xff,0x9d,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10011101-11111111
lsl     z31.b, z31.b, #7  // 00000100-00101111-10011111-11111111
// CHECK: lsl     z31.b, z31.b, #7 // encoding: [0xff,0x9f,0x2f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101111-10011111-11111111
LSL     Z31.B, Z31.B, #7  // 00000100-00101111-10011111-11111111
// CHECK: lsl     z31.b, z31.b, #7 // encoding: [0xff,0x9f,0x2f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101111-10011111-11111111
lsl     z31.h, z31.h, #15  // 00000100-00111111-10011111-11111111
// CHECK: lsl     z31.h, z31.h, #15 // encoding: [0xff,0x9f,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10011111-11111111
LSL     Z31.H, Z31.H, #15  // 00000100-00111111-10011111-11111111
// CHECK: lsl     z31.h, z31.h, #15 // encoding: [0xff,0x9f,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10011111-11111111
lsl     z0.s, z0.s, #0  // 00000100-01100000-10011100-00000000
// CHECK: lsl     z0.s, z0.s, #0 // encoding: [0x00,0x9c,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10011100-00000000
LSL     Z0.S, Z0.S, #0  // 00000100-01100000-10011100-00000000
// CHECK: lsl     z0.s, z0.s, #0 // encoding: [0x00,0x9c,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10011100-00000000
lsl     z23.b, p3/m, z23.b, z13.b  // 00000100-00010011-10001101-10110111
// CHECK: lsl     z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x8d,0x13,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010011-10001101-10110111
LSL     Z23.B, P3/M, Z23.B, Z13.B  // 00000100-00010011-10001101-10110111
// CHECK: lsl     z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x8d,0x13,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010011-10001101-10110111
lsl     z0.d, z0.d, #0  // 00000100-10100000-10011100-00000000
// CHECK: lsl     z0.d, z0.d, #0 // encoding: [0x00,0x9c,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10011100-00000000
LSL     Z0.D, Z0.D, #0  // 00000100-10100000-10011100-00000000
// CHECK: lsl     z0.d, z0.d, #0 // encoding: [0x00,0x9c,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10011100-00000000
lsl     z31.b, p7/m, z31.b, z31.d  // 00000100-00011011-10011111-11111111
// CHECK: lsl     z31.b, p7/m, z31.b, z31.d // encoding: [0xff,0x9f,0x1b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011011-10011111-11111111
LSL     Z31.B, P7/M, Z31.B, Z31.D  // 00000100-00011011-10011111-11111111
// CHECK: lsl     z31.b, p7/m, z31.b, z31.d // encoding: [0xff,0x9f,0x1b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011011-10011111-11111111
lsl     z21.b, p5/m, z21.b, z10.d  // 00000100-00011011-10010101-01010101
// CHECK: lsl     z21.b, p5/m, z21.b, z10.d // encoding: [0x55,0x95,0x1b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011011-10010101-01010101
LSL     Z21.B, P5/M, Z21.B, Z10.D  // 00000100-00011011-10010101-01010101
// CHECK: lsl     z21.b, p5/m, z21.b, z10.d // encoding: [0x55,0x95,0x1b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011011-10010101-01010101
lsl     z0.b, p0/m, z0.b, z0.b  // 00000100-00010011-10000000-00000000
// CHECK: lsl     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x80,0x13,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010011-10000000-00000000
LSL     Z0.B, P0/M, Z0.B, Z0.B  // 00000100-00010011-10000000-00000000
// CHECK: lsl     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x80,0x13,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010011-10000000-00000000
lsl     z21.h, p5/m, z21.h, #10  // 00000100-00000011-10010111-01010101
// CHECK: lsl     z21.h, p5/m, z21.h, #10 // encoding: [0x55,0x97,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10010111-01010101
LSL     Z21.H, P5/M, Z21.H, #10  // 00000100-00000011-10010111-01010101
// CHECK: lsl     z21.h, p5/m, z21.h, #10 // encoding: [0x55,0x97,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10010111-01010101
lsl     z31.s, p7/m, z31.s, #31  // 00000100-01000011-10011111-11111111
// CHECK: lsl     z31.s, p7/m, z31.s, #31 // encoding: [0xff,0x9f,0x43,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000011-10011111-11111111
LSL     Z31.S, P7/M, Z31.S, #31  // 00000100-01000011-10011111-11111111
// CHECK: lsl     z31.s, p7/m, z31.s, #31 // encoding: [0xff,0x9f,0x43,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000011-10011111-11111111
lsl     z23.s, p3/m, z23.s, z13.d  // 00000100-10011011-10001101-10110111
// CHECK: lsl     z23.s, p3/m, z23.s, z13.d // encoding: [0xb7,0x8d,0x9b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011011-10001101-10110111
LSL     Z23.S, P3/M, Z23.S, Z13.D  // 00000100-10011011-10001101-10110111
// CHECK: lsl     z23.s, p3/m, z23.s, z13.d // encoding: [0xb7,0x8d,0x9b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011011-10001101-10110111
lsl     z21.h, p5/m, z21.h, z10.h  // 00000100-01010011-10010101-01010101
// CHECK: lsl     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x53,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010011-10010101-01010101
LSL     Z21.H, P5/M, Z21.H, Z10.H  // 00000100-01010011-10010101-01010101
// CHECK: lsl     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x53,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010011-10010101-01010101
lsl     z31.h, z31.h, z31.d  // 00000100-01111111-10001111-11111111
// CHECK: lsl     z31.h, z31.h, z31.d // encoding: [0xff,0x8f,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10001111-11111111
LSL     Z31.H, Z31.H, Z31.D  // 00000100-01111111-10001111-11111111
// CHECK: lsl     z31.h, z31.h, z31.d // encoding: [0xff,0x8f,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10001111-11111111
lsl     z0.b, z0.b, #0  // 00000100-00101000-10011100-00000000
// CHECK: lsl     z0.b, z0.b, #0 // encoding: [0x00,0x9c,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10011100-00000000
LSL     Z0.B, Z0.B, #0  // 00000100-00101000-10011100-00000000
// CHECK: lsl     z0.b, z0.b, #0 // encoding: [0x00,0x9c,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10011100-00000000
lsl     z21.d, p5/m, z21.d, z10.d  // 00000100-11010011-10010101-01010101
// CHECK: lsl     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xd3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010011-10010101-01010101
LSL     Z21.D, P5/M, Z21.D, Z10.D  // 00000100-11010011-10010101-01010101
// CHECK: lsl     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xd3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010011-10010101-01010101
lsl     z23.s, p3/m, z23.s, #13  // 00000100-01000011-10001101-10110111
// CHECK: lsl     z23.s, p3/m, z23.s, #13 // encoding: [0xb7,0x8d,0x43,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000011-10001101-10110111
LSL     Z23.S, P3/M, Z23.S, #13  // 00000100-01000011-10001101-10110111
// CHECK: lsl     z23.s, p3/m, z23.s, #13 // encoding: [0xb7,0x8d,0x43,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000011-10001101-10110111
lsl     z23.s, z13.s, z8.d  // 00000100-10101000-10001101-10110111
// CHECK: lsl     z23.s, z13.s, z8.d // encoding: [0xb7,0x8d,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10001101-10110111
LSL     Z23.S, Z13.S, Z8.D  // 00000100-10101000-10001101-10110111
// CHECK: lsl     z23.s, z13.s, z8.d // encoding: [0xb7,0x8d,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10001101-10110111
lsl     z0.h, z0.h, z0.d  // 00000100-01100000-10001100-00000000
// CHECK: lsl     z0.h, z0.h, z0.d // encoding: [0x00,0x8c,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10001100-00000000
LSL     Z0.H, Z0.H, Z0.D  // 00000100-01100000-10001100-00000000
// CHECK: lsl     z0.h, z0.h, z0.d // encoding: [0x00,0x8c,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10001100-00000000
lsl     z31.b, p7/m, z31.b, z31.b  // 00000100-00010011-10011111-11111111
// CHECK: lsl     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x9f,0x13,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010011-10011111-11111111
LSL     Z31.B, P7/M, Z31.B, Z31.B  // 00000100-00010011-10011111-11111111
// CHECK: lsl     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x9f,0x13,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010011-10011111-11111111
lsl     z23.h, p3/m, z23.h, #13  // 00000100-00000011-10001111-10110111
// CHECK: lsl     z23.h, p3/m, z23.h, #13 // encoding: [0xb7,0x8f,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10001111-10110111
LSL     Z23.H, P3/M, Z23.H, #13  // 00000100-00000011-10001111-10110111
// CHECK: lsl     z23.h, p3/m, z23.h, #13 // encoding: [0xb7,0x8f,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10001111-10110111
lsl     z21.s, p5/m, z21.s, z10.s  // 00000100-10010011-10010101-01010101
// CHECK: lsl     z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x93,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010011-10010101-01010101
LSL     Z21.S, P5/M, Z21.S, Z10.S  // 00000100-10010011-10010101-01010101
// CHECK: lsl     z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x93,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010011-10010101-01010101
lsl     z31.d, z31.d, #63  // 00000100-11111111-10011111-11111111
// CHECK: lsl     z31.d, z31.d, #63 // encoding: [0xff,0x9f,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10011111-11111111
LSL     Z31.D, Z31.D, #63  // 00000100-11111111-10011111-11111111
// CHECK: lsl     z31.d, z31.d, #63 // encoding: [0xff,0x9f,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10011111-11111111
lsl     z21.b, p5/m, z21.b, z10.b  // 00000100-00010011-10010101-01010101
// CHECK: lsl     z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x95,0x13,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010011-10010101-01010101
LSL     Z21.B, P5/M, Z21.B, Z10.B  // 00000100-00010011-10010101-01010101
// CHECK: lsl     z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x95,0x13,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010011-10010101-01010101
lsl     z23.b, z13.b, z8.d  // 00000100-00101000-10001101-10110111
// CHECK: lsl     z23.b, z13.b, z8.d // encoding: [0xb7,0x8d,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10001101-10110111
LSL     Z23.B, Z13.B, Z8.D  // 00000100-00101000-10001101-10110111
// CHECK: lsl     z23.b, z13.b, z8.d // encoding: [0xb7,0x8d,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10001101-10110111
lsl     z23.d, p3/m, z23.d, z13.d  // 00000100-11010011-10001101-10110111
// CHECK: lsl     z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xd3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010011-10001101-10110111
LSL     Z23.D, P3/M, Z23.D, Z13.D  // 00000100-11010011-10001101-10110111
// CHECK: lsl     z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xd3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010011-10001101-10110111
lsl     z23.h, z13.h, z8.d  // 00000100-01101000-10001101-10110111
// CHECK: lsl     z23.h, z13.h, z8.d // encoding: [0xb7,0x8d,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10001101-10110111
LSL     Z23.H, Z13.H, Z8.D  // 00000100-01101000-10001101-10110111
// CHECK: lsl     z23.h, z13.h, z8.d // encoding: [0xb7,0x8d,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10001101-10110111
lsl     z21.s, z10.s, z21.d  // 00000100-10110101-10001101-01010101
// CHECK: lsl     z21.s, z10.s, z21.d // encoding: [0x55,0x8d,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10001101-01010101
LSL     Z21.S, Z10.S, Z21.D  // 00000100-10110101-10001101-01010101
// CHECK: lsl     z21.s, z10.s, z21.d // encoding: [0x55,0x8d,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10001101-01010101
lsl     z31.s, p7/m, z31.s, z31.s  // 00000100-10010011-10011111-11111111
// CHECK: lsl     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x93,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010011-10011111-11111111
LSL     Z31.S, P7/M, Z31.S, Z31.S  // 00000100-10010011-10011111-11111111
// CHECK: lsl     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x93,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010011-10011111-11111111
lsl     z23.d, z13.d, #40  // 00000100-11101000-10011101-10110111
// CHECK: lsl     z23.d, z13.d, #40 // encoding: [0xb7,0x9d,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10011101-10110111
LSL     Z23.D, Z13.D, #40  // 00000100-11101000-10011101-10110111
// CHECK: lsl     z23.d, z13.d, #40 // encoding: [0xb7,0x9d,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10011101-10110111
lsl     z0.h, z0.h, #0  // 00000100-00110000-10011100-00000000
// CHECK: lsl     z0.h, z0.h, #0 // encoding: [0x00,0x9c,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-10011100-00000000
LSL     Z0.H, Z0.H, #0  // 00000100-00110000-10011100-00000000
// CHECK: lsl     z0.h, z0.h, #0 // encoding: [0x00,0x9c,0x30,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110000-10011100-00000000
lsl     z31.s, z31.s, #31  // 00000100-01111111-10011111-11111111
// CHECK: lsl     z31.s, z31.s, #31 // encoding: [0xff,0x9f,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10011111-11111111
LSL     Z31.S, Z31.S, #31  // 00000100-01111111-10011111-11111111
// CHECK: lsl     z31.s, z31.s, #31 // encoding: [0xff,0x9f,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10011111-11111111
lsl     z31.d, p7/m, z31.d, z31.d  // 00000100-11010011-10011111-11111111
// CHECK: lsl     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xd3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010011-10011111-11111111
LSL     Z31.D, P7/M, Z31.D, Z31.D  // 00000100-11010011-10011111-11111111
// CHECK: lsl     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xd3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010011-10011111-11111111
lsl     z23.s, p3/m, z23.s, z13.s  // 00000100-10010011-10001101-10110111
// CHECK: lsl     z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x93,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010011-10001101-10110111
LSL     Z23.S, P3/M, Z23.S, Z13.S  // 00000100-10010011-10001101-10110111
// CHECK: lsl     z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x93,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010011-10001101-10110111
lsl     z31.s, p7/m, z31.s, z31.d  // 00000100-10011011-10011111-11111111
// CHECK: lsl     z31.s, p7/m, z31.s, z31.d // encoding: [0xff,0x9f,0x9b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011011-10011111-11111111
LSL     Z31.S, P7/M, Z31.S, Z31.D  // 00000100-10011011-10011111-11111111
// CHECK: lsl     z31.s, p7/m, z31.s, z31.d // encoding: [0xff,0x9f,0x9b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011011-10011111-11111111
lsl     z31.h, p7/m, z31.h, #15  // 00000100-00000011-10011111-11111111
// CHECK: lsl     z31.h, p7/m, z31.h, #15 // encoding: [0xff,0x9f,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10011111-11111111
LSL     Z31.H, P7/M, Z31.H, #15  // 00000100-00000011-10011111-11111111
// CHECK: lsl     z31.h, p7/m, z31.h, #15 // encoding: [0xff,0x9f,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10011111-11111111
lsl     z23.h, p3/m, z23.h, z13.h  // 00000100-01010011-10001101-10110111
// CHECK: lsl     z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x53,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010011-10001101-10110111
LSL     Z23.H, P3/M, Z23.H, Z13.H  // 00000100-01010011-10001101-10110111
// CHECK: lsl     z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x53,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010011-10001101-10110111
lsl     z0.b, p0/m, z0.b, z0.d  // 00000100-00011011-10000000-00000000
// CHECK: lsl     z0.b, p0/m, z0.b, z0.d // encoding: [0x00,0x80,0x1b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011011-10000000-00000000
LSL     Z0.B, P0/M, Z0.B, Z0.D  // 00000100-00011011-10000000-00000000
// CHECK: lsl     z0.b, p0/m, z0.b, z0.d // encoding: [0x00,0x80,0x1b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011011-10000000-00000000
lsl     z0.d, p0/m, z0.d, #0  // 00000100-10000011-10000000-00000000
// CHECK: lsl     z0.d, p0/m, z0.d, #0 // encoding: [0x00,0x80,0x83,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000011-10000000-00000000
LSL     Z0.D, P0/M, Z0.D, #0  // 00000100-10000011-10000000-00000000
// CHECK: lsl     z0.d, p0/m, z0.d, #0 // encoding: [0x00,0x80,0x83,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000011-10000000-00000000
lsl     z23.b, z13.b, #0  // 00000100-00101000-10011101-10110111
// CHECK: lsl     z23.b, z13.b, #0 // encoding: [0xb7,0x9d,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10011101-10110111
LSL     Z23.B, Z13.B, #0  // 00000100-00101000-10011101-10110111
// CHECK: lsl     z23.b, z13.b, #0 // encoding: [0xb7,0x9d,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10011101-10110111
lsl     z0.h, p0/m, z0.h, z0.d  // 00000100-01011011-10000000-00000000
// CHECK: lsl     z0.h, p0/m, z0.h, z0.d // encoding: [0x00,0x80,0x5b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011011-10000000-00000000
LSL     Z0.H, P0/M, Z0.H, Z0.D  // 00000100-01011011-10000000-00000000
// CHECK: lsl     z0.h, p0/m, z0.h, z0.d // encoding: [0x00,0x80,0x5b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011011-10000000-00000000
lsl     z23.s, z13.s, #8  // 00000100-01101000-10011101-10110111
// CHECK: lsl     z23.s, z13.s, #8 // encoding: [0xb7,0x9d,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10011101-10110111
LSL     Z23.S, Z13.S, #8  // 00000100-01101000-10011101-10110111
// CHECK: lsl     z23.s, z13.s, #8 // encoding: [0xb7,0x9d,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10011101-10110111
lsl     z21.b, z10.b, z21.d  // 00000100-00110101-10001101-01010101
// CHECK: lsl     z21.b, z10.b, z21.d // encoding: [0x55,0x8d,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10001101-01010101
LSL     Z21.B, Z10.B, Z21.D  // 00000100-00110101-10001101-01010101
// CHECK: lsl     z21.b, z10.b, z21.d // encoding: [0x55,0x8d,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10001101-01010101
lsl     z21.b, z10.b, #5  // 00000100-00101101-10011101-01010101
// CHECK: lsl     z21.b, z10.b, #5 // encoding: [0x55,0x9d,0x2d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101101-10011101-01010101
LSL     Z21.B, Z10.B, #5  // 00000100-00101101-10011101-01010101
// CHECK: lsl     z21.b, z10.b, #5 // encoding: [0x55,0x9d,0x2d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101101-10011101-01010101
lsl     z0.b, p0/m, z0.b, #0  // 00000100-00000011-10000001-00000000
// CHECK: lsl     z0.b, p0/m, z0.b, #0 // encoding: [0x00,0x81,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10000001-00000000
LSL     Z0.B, P0/M, Z0.B, #0  // 00000100-00000011-10000001-00000000
// CHECK: lsl     z0.b, p0/m, z0.b, #0 // encoding: [0x00,0x81,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10000001-00000000
lsl     z21.h, z10.h, z21.d  // 00000100-01110101-10001101-01010101
// CHECK: lsl     z21.h, z10.h, z21.d // encoding: [0x55,0x8d,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10001101-01010101
LSL     Z21.H, Z10.H, Z21.D  // 00000100-01110101-10001101-01010101
// CHECK: lsl     z21.h, z10.h, z21.d // encoding: [0x55,0x8d,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10001101-01010101
lsl     z21.h, z10.h, #5  // 00000100-00110101-10011101-01010101
// CHECK: lsl     z21.h, z10.h, #5 // encoding: [0x55,0x9d,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10011101-01010101
LSL     Z21.H, Z10.H, #5  // 00000100-00110101-10011101-01010101
// CHECK: lsl     z21.h, z10.h, #5 // encoding: [0x55,0x9d,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10011101-01010101
lsl     z21.h, p5/m, z21.h, z10.d  // 00000100-01011011-10010101-01010101
// CHECK: lsl     z21.h, p5/m, z21.h, z10.d // encoding: [0x55,0x95,0x5b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011011-10010101-01010101
LSL     Z21.H, P5/M, Z21.H, Z10.D  // 00000100-01011011-10010101-01010101
// CHECK: lsl     z21.h, p5/m, z21.h, z10.d // encoding: [0x55,0x95,0x5b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011011-10010101-01010101
lsl     z23.b, p3/m, z23.b, #5  // 00000100-00000011-10001101-10110111
// CHECK: lsl     z23.b, p3/m, z23.b, #5 // encoding: [0xb7,0x8d,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10001101-10110111
LSL     Z23.B, P3/M, Z23.B, #5  // 00000100-00000011-10001101-10110111
// CHECK: lsl     z23.b, p3/m, z23.b, #5 // encoding: [0xb7,0x8d,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10001101-10110111
lsl     z0.s, p0/m, z0.s, z0.s  // 00000100-10010011-10000000-00000000
// CHECK: lsl     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x93,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010011-10000000-00000000
LSL     Z0.S, P0/M, Z0.S, Z0.S  // 00000100-10010011-10000000-00000000
// CHECK: lsl     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x93,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010011-10000000-00000000
lsl     z31.b, z31.b, z31.d  // 00000100-00111111-10001111-11111111
// CHECK: lsl     z31.b, z31.b, z31.d // encoding: [0xff,0x8f,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10001111-11111111
LSL     Z31.B, Z31.B, Z31.D  // 00000100-00111111-10001111-11111111
// CHECK: lsl     z31.b, z31.b, z31.d // encoding: [0xff,0x8f,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10001111-11111111
lsl     z0.s, z0.s, z0.d  // 00000100-10100000-10001100-00000000
// CHECK: lsl     z0.s, z0.s, z0.d // encoding: [0x00,0x8c,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10001100-00000000
LSL     Z0.S, Z0.S, Z0.D  // 00000100-10100000-10001100-00000000
// CHECK: lsl     z0.s, z0.s, z0.d // encoding: [0x00,0x8c,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10001100-00000000
lsl     z31.s, z31.s, z31.d  // 00000100-10111111-10001111-11111111
// CHECK: lsl     z31.s, z31.s, z31.d // encoding: [0xff,0x8f,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10001111-11111111
LSL     Z31.S, Z31.S, Z31.D  // 00000100-10111111-10001111-11111111
// CHECK: lsl     z31.s, z31.s, z31.d // encoding: [0xff,0x8f,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10001111-11111111
lsl     z0.s, p0/m, z0.s, z0.d  // 00000100-10011011-10000000-00000000
// CHECK: lsl     z0.s, p0/m, z0.s, z0.d // encoding: [0x00,0x80,0x9b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011011-10000000-00000000
LSL     Z0.S, P0/M, Z0.S, Z0.D  // 00000100-10011011-10000000-00000000
// CHECK: lsl     z0.s, p0/m, z0.s, z0.d // encoding: [0x00,0x80,0x9b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011011-10000000-00000000
lsl     z0.d, p0/m, z0.d, z0.d  // 00000100-11010011-10000000-00000000
// CHECK: lsl     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xd3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010011-10000000-00000000
LSL     Z0.D, P0/M, Z0.D, Z0.D  // 00000100-11010011-10000000-00000000
// CHECK: lsl     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xd3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010011-10000000-00000000
lsl     z31.d, p7/m, z31.d, #63  // 00000100-11000011-10011111-11111111
// CHECK: lsl     z31.d, p7/m, z31.d, #63 // encoding: [0xff,0x9f,0xc3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000011-10011111-11111111
LSL     Z31.D, P7/M, Z31.D, #63  // 00000100-11000011-10011111-11111111
// CHECK: lsl     z31.d, p7/m, z31.d, #63 // encoding: [0xff,0x9f,0xc3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000011-10011111-11111111
lsl     z21.s, p5/m, z21.s, #10  // 00000100-01000011-10010101-01010101
// CHECK: lsl     z21.s, p5/m, z21.s, #10 // encoding: [0x55,0x95,0x43,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000011-10010101-01010101
LSL     Z21.S, P5/M, Z21.S, #10  // 00000100-01000011-10010101-01010101
// CHECK: lsl     z21.s, p5/m, z21.s, #10 // encoding: [0x55,0x95,0x43,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000011-10010101-01010101
lsl     z0.h, p0/m, z0.h, #0  // 00000100-00000011-10000010-00000000
// CHECK: lsl     z0.h, p0/m, z0.h, #0 // encoding: [0x00,0x82,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10000010-00000000
LSL     Z0.H, P0/M, Z0.H, #0  // 00000100-00000011-10000010-00000000
// CHECK: lsl     z0.h, p0/m, z0.h, #0 // encoding: [0x00,0x82,0x03,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000011-10000010-00000000
lsl     z0.s, p0/m, z0.s, #0  // 00000100-01000011-10000000-00000000
// CHECK: lsl     z0.s, p0/m, z0.s, #0 // encoding: [0x00,0x80,0x43,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000011-10000000-00000000
LSL     Z0.S, P0/M, Z0.S, #0  // 00000100-01000011-10000000-00000000
// CHECK: lsl     z0.s, p0/m, z0.s, #0 // encoding: [0x00,0x80,0x43,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000011-10000000-00000000
lsl     z21.d, p5/m, z21.d, #42  // 00000100-11000011-10010101-01010101
// CHECK: lsl     z21.d, p5/m, z21.d, #42 // encoding: [0x55,0x95,0xc3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000011-10010101-01010101
LSL     Z21.D, P5/M, Z21.D, #42  // 00000100-11000011-10010101-01010101
// CHECK: lsl     z21.d, p5/m, z21.d, #42 // encoding: [0x55,0x95,0xc3,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000011-10010101-01010101
lsl     z21.s, z10.s, #21  // 00000100-01110101-10011101-01010101
// CHECK: lsl     z21.s, z10.s, #21 // encoding: [0x55,0x9d,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10011101-01010101
LSL     Z21.S, Z10.S, #21  // 00000100-01110101-10011101-01010101
// CHECK: lsl     z21.s, z10.s, #21 // encoding: [0x55,0x9d,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10011101-01010101
