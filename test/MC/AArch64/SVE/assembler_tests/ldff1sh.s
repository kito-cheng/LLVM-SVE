// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldff1sh {z23.s}, p3/z, [z13.s, #16]  // 10000100-10101000-10101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [z13.s, #16] // encoding: [0xb7,0xad,0xa8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10101000-10101101-10110111
LDFF1SH {Z23.S}, P3/Z, [Z13.S, #16]  // 10000100-10101000-10101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [z13.s, #16] // encoding: [0xb7,0xad,0xa8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10101000-10101101-10110111
ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw]  // 11000100-10010101-00110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x35,0x95,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10010101-00110101-01010101
LDFF1SH {Z21.D}, P5/Z, [X10, Z21.D, UXTW]  // 11000100-10010101-00110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x35,0x95,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10010101-00110101-01010101
ldff1sh {z23.s}, p3/z, [x13, x8, lsl #1]  // 10100101-00101000-01101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0x28,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00101000-01101101-10110111
LDFF1SH {Z23.S}, P3/Z, [X13, X8, LSL #1]  // 10100101-00101000-01101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0x28,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00101000-01101101-10110111
ldff1sh {z31.s}, p7/z, [sp]  // 10100101-00111111-01111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [sp] // encoding: [0xff,0x7f,0x3f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00111111-01111111-11111111
LDFF1SH {Z31.S}, P7/Z, [SP]  // 10100101-00111111-01111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [sp] // encoding: [0xff,0x7f,0x3f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00111111-01111111-11111111
ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw #1]  // 11000100-10100000-00100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw #1] // encoding: [0x00,0x20,0xa0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10100000-00100000-00000000
LDFF1SH {Z0.D}, P0/Z, [X0, Z0.D, UXTW #1]  // 11000100-10100000-00100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw #1] // encoding: [0x00,0x20,0xa0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10100000-00100000-00000000
ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw #1]  // 10000100-10111111-00111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw #1] // encoding: [0xff,0x3f,0xbf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10111111-00111111-11111111
LDFF1SH {Z31.S}, P7/Z, [SP, Z31.S, UXTW #1]  // 10000100-10111111-00111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw #1] // encoding: [0xff,0x3f,0xbf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10111111-00111111-11111111
ldff1sh {z21.d}, p5/z, [x10, z21.d, lsl #1]  // 11000100-11110101-10110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, lsl #1] // encoding: [0x55,0xb5,0xf5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11110101-10110101-01010101
LDFF1SH {Z21.D}, P5/Z, [X10, Z21.D, LSL #1]  // 11000100-11110101-10110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, lsl #1] // encoding: [0x55,0xb5,0xf5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11110101-10110101-01010101
ldff1sh {z0.d}, p0/z, [x0, x0, lsl #1]  // 10100101-00000000-01100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x60,0x00,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00000000-01100000-00000000
LDFF1SH {Z0.D}, P0/Z, [X0, X0, LSL #1]  // 10100101-00000000-01100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x60,0x00,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00000000-01100000-00000000
ldff1sh {z0.s}, p0/z, [x0, x0, lsl #1]  // 10100101-00100000-01100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x60,0x20,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00100000-01100000-00000000
LDFF1SH {Z0.S}, P0/Z, [X0, X0, LSL #1]  // 10100101-00100000-01100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x60,0x20,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00100000-01100000-00000000
ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw #1]  // 10000100-11101000-00101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw #1] // encoding: [0xb7,0x2d,0xe8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11101000-00101101-10110111
LDFF1SH {Z23.S}, P3/Z, [X13, Z8.S, SXTW #1]  // 10000100-11101000-00101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw #1] // encoding: [0xb7,0x2d,0xe8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11101000-00101101-10110111
ldff1sh {z31.s}, p7/z, [z31.s, #62]  // 10000100-10111111-10111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [z31.s, #62] // encoding: [0xff,0xbf,0xbf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10111111-10111111-11111111
LDFF1SH {Z31.S}, P7/Z, [Z31.S, #62]  // 10000100-10111111-10111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [z31.s, #62] // encoding: [0xff,0xbf,0xbf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10111111-10111111-11111111
ldff1sh {z31.d}, p7/z, [sp]  // 10100101-00011111-01111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp] // encoding: [0xff,0x7f,0x1f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00011111-01111111-11111111
LDFF1SH {Z31.D}, P7/Z, [SP]  // 10100101-00011111-01111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp] // encoding: [0xff,0x7f,0x1f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00011111-01111111-11111111
ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw]  // 11000100-10011111-00111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x3f,0x9f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10011111-00111111-11111111
LDFF1SH {Z31.D}, P7/Z, [SP, Z31.D, UXTW]  // 11000100-10011111-00111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x3f,0x9f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10011111-00111111-11111111
ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw]  // 10000100-10001000-00101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw] // encoding: [0xb7,0x2d,0x88,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10001000-00101101-10110111
LDFF1SH {Z23.S}, P3/Z, [X13, Z8.S, UXTW]  // 10000100-10001000-00101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw] // encoding: [0xb7,0x2d,0x88,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10001000-00101101-10110111
ldff1sh {z21.d}, p5/z, [x10, x21, lsl #1]  // 10100101-00010101-01110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x75,0x15,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00010101-01110101-01010101
LDFF1SH {Z21.D}, P5/Z, [X10, X21, LSL #1]  // 10100101-00010101-01110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x75,0x15,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00010101-01110101-01010101
ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw #1]  // 10000100-11100000-00100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw #1] // encoding: [0x00,0x20,0xe0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11100000-00100000-00000000
LDFF1SH {Z0.S}, P0/Z, [X0, Z0.S, SXTW #1]  // 10000100-11100000-00100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw #1] // encoding: [0x00,0x20,0xe0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11100000-00100000-00000000
ldff1sh {z31.d}, p7/z, [sp, z31.d, lsl #1]  // 11000100-11111111-10111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, lsl #1] // encoding: [0xff,0xbf,0xff,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11111111-10111111-11111111
LDFF1SH {Z31.D}, P7/Z, [SP, Z31.D, LSL #1]  // 11000100-11111111-10111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, lsl #1] // encoding: [0xff,0xbf,0xff,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11111111-10111111-11111111
ldff1sh {z0.d}, p0/z, [z0.d]  // 11000100-10100000-10100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xa0,0xa0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10100000-10100000-00000000
LDFF1SH {Z0.D}, P0/Z, [Z0.D]  // 11000100-10100000-10100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xa0,0xa0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10100000-10100000-00000000
ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw]  // 11000100-11001000-00101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw] // encoding: [0xb7,0x2d,0xc8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11001000-00101101-10110111
LDFF1SH {Z23.D}, P3/Z, [X13, Z8.D, SXTW]  // 11000100-11001000-00101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw] // encoding: [0xb7,0x2d,0xc8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11001000-00101101-10110111
ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw #1]  // 10000100-11110101-00110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw #1] // encoding: [0x55,0x35,0xf5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11110101-00110101-01010101
LDFF1SH {Z21.S}, P5/Z, [X10, Z21.S, SXTW #1]  // 10000100-11110101-00110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw #1] // encoding: [0x55,0x35,0xf5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11110101-00110101-01010101
ldff1sh {z31.d}, p7/z, [sp, z31.d]  // 11000100-11011111-10111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xbf,0xdf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11011111-10111111-11111111
LDFF1SH {Z31.D}, P7/Z, [SP, Z31.D]  // 11000100-11011111-10111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xbf,0xdf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11011111-10111111-11111111
ldff1sh {z21.d}, p5/z, [x10, z21.d]  // 11000100-11010101-10110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xb5,0xd5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11010101-10110101-01010101
LDFF1SH {Z21.D}, P5/Z, [X10, Z21.D]  // 11000100-11010101-10110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xb5,0xd5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11010101-10110101-01010101
ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw #1]  // 10000100-10100000-00100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw #1] // encoding: [0x00,0x20,0xa0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10100000-00100000-00000000
LDFF1SH {Z0.S}, P0/Z, [X0, Z0.S, UXTW #1]  // 10000100-10100000-00100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw #1] // encoding: [0x00,0x20,0xa0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10100000-00100000-00000000
ldff1sh {z23.d}, p3/z, [z13.d, #16]  // 11000100-10101000-10101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [z13.d, #16] // encoding: [0xb7,0xad,0xa8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10101000-10101101-10110111
LDFF1SH {Z23.D}, P3/Z, [Z13.D, #16]  // 11000100-10101000-10101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [z13.d, #16] // encoding: [0xb7,0xad,0xa8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10101000-10101101-10110111
ldff1sh {z31.d}, p7/z, [z31.d, #62]  // 11000100-10111111-10111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [z31.d, #62] // encoding: [0xff,0xbf,0xbf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10111111-10111111-11111111
LDFF1SH {Z31.D}, P7/Z, [Z31.D, #62]  // 11000100-10111111-10111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [z31.d, #62] // encoding: [0xff,0xbf,0xbf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10111111-10111111-11111111
ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw #1]  // 11000100-11101000-00101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw #1] // encoding: [0xb7,0x2d,0xe8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11101000-00101101-10110111
LDFF1SH {Z23.D}, P3/Z, [X13, Z8.D, SXTW #1]  // 11000100-11101000-00101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw #1] // encoding: [0xb7,0x2d,0xe8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11101000-00101101-10110111
ldff1sh {z21.d}, p5/z, [z10.d, #42]  // 11000100-10110101-10110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [z10.d, #42] // encoding: [0x55,0xb5,0xb5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10110101-10110101-01010101
LDFF1SH {Z21.D}, P5/Z, [Z10.D, #42]  // 11000100-10110101-10110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [z10.d, #42] // encoding: [0x55,0xb5,0xb5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10110101-10110101-01010101
ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw #1]  // 10000100-10110101-00110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw #1] // encoding: [0x55,0x35,0xb5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10110101-00110101-01010101
LDFF1SH {Z21.S}, P5/Z, [X10, Z21.S, UXTW #1]  // 10000100-10110101-00110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw #1] // encoding: [0x55,0x35,0xb5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10110101-00110101-01010101
ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw]  // 11000100-10000000-00100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x20,0x80,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10000000-00100000-00000000
LDFF1SH {Z0.D}, P0/Z, [X0, Z0.D, UXTW]  // 11000100-10000000-00100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x20,0x80,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10000000-00100000-00000000
ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw #1]  // 11000100-11111111-00111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw #1] // encoding: [0xff,0x3f,0xff,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11111111-00111111-11111111
LDFF1SH {Z31.D}, P7/Z, [SP, Z31.D, SXTW #1]  // 11000100-11111111-00111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw #1] // encoding: [0xff,0x3f,0xff,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11111111-00111111-11111111
ldff1sh {z23.d}, p3/z, [x13, x8, lsl #1]  // 10100101-00001000-01101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0x08,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00001000-01101101-10110111
LDFF1SH {Z23.D}, P3/Z, [X13, X8, LSL #1]  // 10100101-00001000-01101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0x08,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00001000-01101101-10110111
ldff1sh {z23.d}, p3/z, [x13, z8.d]  // 11000100-11001000-10101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xad,0xc8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11001000-10101101-10110111
LDFF1SH {Z23.D}, P3/Z, [X13, Z8.D]  // 11000100-11001000-10101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xad,0xc8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11001000-10101101-10110111
ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw #1]  // 11000100-11100000-00100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw #1] // encoding: [0x00,0x20,0xe0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11100000-00100000-00000000
LDFF1SH {Z0.D}, P0/Z, [X0, Z0.D, SXTW #1]  // 11000100-11100000-00100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw #1] // encoding: [0x00,0x20,0xe0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11100000-00100000-00000000
ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw #1]  // 11000100-10110101-00110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw #1] // encoding: [0x55,0x35,0xb5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10110101-00110101-01010101
LDFF1SH {Z21.D}, P5/Z, [X10, Z21.D, UXTW #1]  // 11000100-10110101-00110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw #1] // encoding: [0x55,0x35,0xb5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10110101-00110101-01010101
ldff1sh {z0.d}, p0/z, [x0, z0.d, lsl #1]  // 11000100-11100000-10100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, lsl #1] // encoding: [0x00,0xa0,0xe0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11100000-10100000-00000000
LDFF1SH {Z0.D}, P0/Z, [X0, Z0.D, LSL #1]  // 11000100-11100000-10100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, lsl #1] // encoding: [0x00,0xa0,0xe0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11100000-10100000-00000000
ldff1sh {z21.s}, p5/z, [x10, x21, lsl #1]  // 10100101-00110101-01110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x75,0x35,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00110101-01110101-01010101
LDFF1SH {Z21.S}, P5/Z, [X10, X21, LSL #1]  // 10100101-00110101-01110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x75,0x35,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00110101-01110101-01010101
ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw]  // 11000100-10001000-00101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x2d,0x88,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10001000-00101101-10110111
LDFF1SH {Z23.D}, P3/Z, [X13, Z8.D, UXTW]  // 11000100-10001000-00101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x2d,0x88,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10001000-00101101-10110111
ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw]  // 10000100-11010101-00110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x35,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-00110101-01010101
LDFF1SH {Z21.S}, P5/Z, [X10, Z21.S, SXTW]  // 10000100-11010101-00110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x35,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-00110101-01010101
ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw]  // 10000100-11001000-00101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x2d,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-00101101-10110111
LDFF1SH {Z23.S}, P3/Z, [X13, Z8.S, SXTW]  // 10000100-11001000-00101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x2d,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-00101101-10110111
ldff1sh {z21.s}, p5/z, [z10.s, #42]  // 10000100-10110101-10110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [z10.s, #42] // encoding: [0x55,0xb5,0xb5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10110101-10110101-01010101
LDFF1SH {Z21.S}, P5/Z, [Z10.S, #42]  // 10000100-10110101-10110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [z10.s, #42] // encoding: [0x55,0xb5,0xb5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10110101-10110101-01010101
ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw #1]  // 10000100-11111111-00111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw #1] // encoding: [0xff,0x3f,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-00111111-11111111
LDFF1SH {Z31.S}, P7/Z, [SP, Z31.S, SXTW #1]  // 10000100-11111111-00111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw #1] // encoding: [0xff,0x3f,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-00111111-11111111
ldff1sh {z0.s}, p0/z, [z0.s]  // 10000100-10100000-10100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [z0.s] // encoding: [0x00,0xa0,0xa0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10100000-10100000-00000000
LDFF1SH {Z0.S}, P0/Z, [Z0.S]  // 10000100-10100000-10100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [z0.s] // encoding: [0x00,0xa0,0xa0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10100000-10100000-00000000
ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw]  // 10000100-10011111-00111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw] // encoding: [0xff,0x3f,0x9f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10011111-00111111-11111111
LDFF1SH {Z31.S}, P7/Z, [SP, Z31.S, UXTW]  // 10000100-10011111-00111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw] // encoding: [0xff,0x3f,0x9f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10011111-00111111-11111111
ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw #1]  // 11000100-10111111-00111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw #1] // encoding: [0xff,0x3f,0xbf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10111111-00111111-11111111
LDFF1SH {Z31.D}, P7/Z, [SP, Z31.D, UXTW #1]  // 11000100-10111111-00111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw #1] // encoding: [0xff,0x3f,0xbf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10111111-00111111-11111111
ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw #1]  // 11000100-10101000-00101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw #1] // encoding: [0xb7,0x2d,0xa8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10101000-00101101-10110111
LDFF1SH {Z23.D}, P3/Z, [X13, Z8.D, UXTW #1]  // 11000100-10101000-00101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw #1] // encoding: [0xb7,0x2d,0xa8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10101000-00101101-10110111
ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw]  // 11000100-11000000-00100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw] // encoding: [0x00,0x20,0xc0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11000000-00100000-00000000
LDFF1SH {Z0.D}, P0/Z, [X0, Z0.D, SXTW]  // 11000100-11000000-00100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw] // encoding: [0x00,0x20,0xc0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11000000-00100000-00000000
ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw]  // 11000100-11011111-00111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw] // encoding: [0xff,0x3f,0xdf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11011111-00111111-11111111
LDFF1SH {Z31.D}, P7/Z, [SP, Z31.D, SXTW]  // 11000100-11011111-00111111-11111111
// CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw] // encoding: [0xff,0x3f,0xdf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11011111-00111111-11111111
ldff1sh {z0.d}, p0/z, [x0, z0.d]  // 11000100-11000000-10100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xa0,0xc0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11000000-10100000-00000000
LDFF1SH {Z0.D}, P0/Z, [X0, Z0.D]  // 11000100-11000000-10100000-00000000
// CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xa0,0xc0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11000000-10100000-00000000
ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw #1]  // 10000100-10101000-00101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw #1] // encoding: [0xb7,0x2d,0xa8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10101000-00101101-10110111
LDFF1SH {Z23.S}, P3/Z, [X13, Z8.S, UXTW #1]  // 10000100-10101000-00101101-10110111
// CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw #1] // encoding: [0xb7,0x2d,0xa8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10101000-00101101-10110111
ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw]  // 10000100-11011111-00111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x3f,0xdf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11011111-00111111-11111111
LDFF1SH {Z31.S}, P7/Z, [SP, Z31.S, SXTW]  // 10000100-11011111-00111111-11111111
// CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x3f,0xdf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11011111-00111111-11111111
ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw]  // 10000100-10010101-00110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw] // encoding: [0x55,0x35,0x95,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10010101-00110101-01010101
LDFF1SH {Z21.S}, P5/Z, [X10, Z21.S, UXTW]  // 10000100-10010101-00110101-01010101
// CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw] // encoding: [0x55,0x35,0x95,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10010101-00110101-01010101
ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw]  // 10000100-11000000-00100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x20,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-00100000-00000000
LDFF1SH {Z0.S}, P0/Z, [X0, Z0.S, SXTW]  // 10000100-11000000-00100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x20,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-00100000-00000000
ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw]  // 11000100-11010101-00110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw] // encoding: [0x55,0x35,0xd5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11010101-00110101-01010101
LDFF1SH {Z21.D}, P5/Z, [X10, Z21.D, SXTW]  // 11000100-11010101-00110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw] // encoding: [0x55,0x35,0xd5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11010101-00110101-01010101
ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw]  // 10000100-10000000-00100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw] // encoding: [0x00,0x20,0x80,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10000000-00100000-00000000
LDFF1SH {Z0.S}, P0/Z, [X0, Z0.S, UXTW]  // 10000100-10000000-00100000-00000000
// CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw] // encoding: [0x00,0x20,0x80,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10000000-00100000-00000000
ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw #1]  // 11000100-11110101-00110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw #1] // encoding: [0x55,0x35,0xf5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11110101-00110101-01010101
LDFF1SH {Z21.D}, P5/Z, [X10, Z21.D, SXTW #1]  // 11000100-11110101-00110101-01010101
// CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw #1] // encoding: [0x55,0x35,0xf5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11110101-00110101-01010101
ldff1sh {z23.d}, p3/z, [x13, z8.d, lsl #1]  // 11000100-11101000-10101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, lsl #1] // encoding: [0xb7,0xad,0xe8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11101000-10101101-10110111
LDFF1SH {Z23.D}, P3/Z, [X13, Z8.D, LSL #1]  // 11000100-11101000-10101101-10110111
// CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, lsl #1] // encoding: [0xb7,0xad,0xe8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11101000-10101101-10110111
