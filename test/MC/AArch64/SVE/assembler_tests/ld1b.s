// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1b    {z23.d}, p3/z, [x13, z8.d, uxtw]  // 11000100-00001000-01001101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x4d,0x08,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00001000-01001101-10110111
LD1B    {Z23.D}, P3/Z, [X13, Z8.D, UXTW]  // 11000100-00001000-01001101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x4d,0x08,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00001000-01001101-10110111
ld1b    {z0.d}, p0/z, [x0]  // 10100100-01100000-10100000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x60,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100000-10100000-00000000
LD1B    {Z0.D}, P0/Z, [X0]  // 10100100-01100000-10100000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x60,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100000-10100000-00000000
ld1b    {z23.s}, p3/z, [x13, z8.s, sxtw]  // 10000100-01001000-01001101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x4d,0x48,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01001000-01001101-10110111
LD1B    {Z23.S}, P3/Z, [X13, Z8.S, SXTW]  // 10000100-01001000-01001101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x4d,0x48,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01001000-01001101-10110111
ld1b    {z23.d}, p3/z, [z13.d, #8]  // 11000100-00101000-11001101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [z13.d, #8] // encoding: [0xb7,0xcd,0x28,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00101000-11001101-10110111
LD1B    {Z23.D}, P3/Z, [Z13.D, #8]  // 11000100-00101000-11001101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [z13.d, #8] // encoding: [0xb7,0xcd,0x28,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00101000-11001101-10110111
ld1b    {z23.s}, p3/z, [x13, #-8, mul vl]  // 10100100-01001000-10101101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x48,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01001000-10101101-10110111
LD1B    {Z23.S}, P3/Z, [X13, #-8, MUL VL]  // 10100100-01001000-10101101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x48,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01001000-10101101-10110111
ld1b    {z23.d}, p3/z, [x13, x8]  // 10100100-01101000-01001101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x68,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101000-01001101-10110111
LD1B    {Z23.D}, P3/Z, [X13, X8]  // 10100100-01101000-01001101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x68,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101000-01001101-10110111
ld1b    {z21.h}, p5/z, [x10, x21]  // 10100100-00110101-01010101-01010101
// CHECK: ld1b    {z21.h}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x35,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00110101-01010101-01010101
LD1B    {Z21.H}, P5/Z, [X10, X21]  // 10100100-00110101-01010101-01010101
// CHECK: ld1b    {z21.h}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x35,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00110101-01010101-01010101
ld1b    {z23.s}, p3/z, [z13.s, #8]  // 10000100-00101000-11001101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [z13.s, #8] // encoding: [0xb7,0xcd,0x28,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00101000-11001101-10110111
LD1B    {Z23.S}, P3/Z, [Z13.S, #8]  // 10000100-00101000-11001101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [z13.s, #8] // encoding: [0xb7,0xcd,0x28,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00101000-11001101-10110111
ld1b    {z5.s}, p3/z, [x17, x16]  // 10100100-01010000-01001110-00100101
// CHECK: ld1b    {z5.s}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x50,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01010000-01001110-00100101
LD1B    {Z5.S}, P3/Z, [X17, X16]  // 10100100-01010000-01001110-00100101
// CHECK: ld1b    {z5.s}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x50,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01010000-01001110-00100101
ld1b    {z31.d}, p7/z, [z31.d, #31]  // 11000100-00111111-11011111-11111111
// CHECK: ld1b    {z31.d}, p7/z, [z31.d, #31] // encoding: [0xff,0xdf,0x3f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00111111-11011111-11111111
LD1B    {Z31.D}, P7/Z, [Z31.D, #31]  // 11000100-00111111-11011111-11111111
// CHECK: ld1b    {z31.d}, p7/z, [z31.d, #31] // encoding: [0xff,0xdf,0x3f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00111111-11011111-11111111
ld1b    {z31.d}, p7/z, [sp, z31.d, sxtw]  // 11000100-01011111-01011111-11111111
// CHECK: ld1b    {z31.d}, p7/z, [sp, z31.d, sxtw] // encoding: [0xff,0x5f,0x5f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01011111-01011111-11111111
LD1B    {Z31.D}, P7/Z, [SP, Z31.D, SXTW]  // 11000100-01011111-01011111-11111111
// CHECK: ld1b    {z31.d}, p7/z, [sp, z31.d, sxtw] // encoding: [0xff,0x5f,0x5f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01011111-01011111-11111111
ld1b    {z31.s}, p7/z, [sp, z31.s, uxtw]  // 10000100-00011111-01011111-11111111
// CHECK: ld1b    {z31.s}, p7/z, [sp, z31.s, uxtw] // encoding: [0xff,0x5f,0x1f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00011111-01011111-11111111
LD1B    {Z31.S}, P7/Z, [SP, Z31.S, UXTW]  // 10000100-00011111-01011111-11111111
// CHECK: ld1b    {z31.s}, p7/z, [sp, z31.s, uxtw] // encoding: [0xff,0x5f,0x1f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00011111-01011111-11111111
ld1b    {z21.d}, p5/z, [x10, z21.d]  // 11000100-01010101-11010101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xd5,0x55,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01010101-11010101-01010101
LD1B    {Z21.D}, P5/Z, [X10, Z21.D]  // 11000100-01010101-11010101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xd5,0x55,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01010101-11010101-01010101
ld1b    {z23.b}, p3/z, [x13, #-8, mul vl]  // 10100100-00001000-10101101-10110111
// CHECK: ld1b    {z23.b}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-10101101-10110111
LD1B    {Z23.B}, P3/Z, [X13, #-8, MUL VL]  // 10100100-00001000-10101101-10110111
// CHECK: ld1b    {z23.b}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-10101101-10110111
ld1b    {z21.s}, p5/z, [z10.s, #21]  // 10000100-00110101-11010101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [z10.s, #21] // encoding: [0x55,0xd5,0x35,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00110101-11010101-01010101
LD1B    {Z21.S}, P5/Z, [Z10.S, #21]  // 10000100-00110101-11010101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [z10.s, #21] // encoding: [0x55,0xd5,0x35,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00110101-11010101-01010101
ld1b    {z0.s}, p0/z, [x0, x0]  // 10100100-01000000-01000000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x40,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01000000-01000000-00000000
LD1B    {Z0.S}, P0/Z, [X0, X0]  // 10100100-01000000-01000000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x40,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01000000-01000000-00000000
ld1b    {z23.h}, p3/z, [x13, #-8, mul vl]  // 10100100-00101000-10101101-10110111
// CHECK: ld1b    {z23.h}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x28,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00101000-10101101-10110111
LD1B    {Z23.H}, P3/Z, [X13, #-8, MUL VL]  // 10100100-00101000-10101101-10110111
// CHECK: ld1b    {z23.h}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x28,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00101000-10101101-10110111
ld1b    {z31.h}, p7/z, [sp, #-1, mul vl]  // 10100100-00101111-10111111-11111111
// CHECK: ld1b    {z31.h}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x2f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00101111-10111111-11111111
LD1B    {Z31.H}, P7/Z, [SP, #-1, MUL VL]  // 10100100-00101111-10111111-11111111
// CHECK: ld1b    {z31.h}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x2f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00101111-10111111-11111111
ld1b    {z31.d}, p7/z, [sp, #-1, mul vl]  // 10100100-01101111-10111111-11111111
// CHECK: ld1b    {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x6f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101111-10111111-11111111
LD1B    {Z31.D}, P7/Z, [SP, #-1, MUL VL]  // 10100100-01101111-10111111-11111111
// CHECK: ld1b    {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x6f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101111-10111111-11111111
ld1b    {z21.s}, p5/z, [x10, z21.s, sxtw]  // 10000100-01010101-01010101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x55,0x55,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01010101-01010101-01010101
LD1B    {Z21.S}, P5/Z, [X10, Z21.S, SXTW]  // 10000100-01010101-01010101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x55,0x55,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01010101-01010101-01010101
ld1b    {z21.d}, p5/z, [x10, #5, mul vl]  // 10100100-01100101-10110101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x65,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100101-10110101-01010101
LD1B    {Z21.D}, P5/Z, [X10, #5, MUL VL]  // 10100100-01100101-10110101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x65,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100101-10110101-01010101
ld1b    {z5.h}, p3/z, [x17, x16]  // 10100100-00110000-01001110-00100101
// CHECK: ld1b    {z5.h}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x30,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00110000-01001110-00100101
LD1B    {Z5.H}, P3/Z, [X17, X16]  // 10100100-00110000-01001110-00100101
// CHECK: ld1b    {z5.h}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x30,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00110000-01001110-00100101
ld1b    {z5.b}, p3/z, [x17, x16]  // 10100100-00010000-01001110-00100101
// CHECK: ld1b    {z5.b}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x10,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010000-01001110-00100101
LD1B    {Z5.B}, P3/Z, [X17, X16]  // 10100100-00010000-01001110-00100101
// CHECK: ld1b    {z5.b}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x10,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010000-01001110-00100101
ld1b    {z0.s}, p0/z, [x0]  // 10100100-01000000-10100000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0x40,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01000000-10100000-00000000
LD1B    {Z0.S}, P0/Z, [X0]  // 10100100-01000000-10100000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0x40,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01000000-10100000-00000000
ld1b    {z0.d}, p0/z, [x0, z0.d]  // 11000100-01000000-11000000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xc0,0x40,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01000000-11000000-00000000
LD1B    {Z0.D}, P0/Z, [X0, Z0.D]  // 11000100-01000000-11000000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xc0,0x40,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01000000-11000000-00000000
ld1b    {z5.d}, p3/z, [x17, x16]  // 10100100-01110000-01001110-00100101
// CHECK: ld1b    {z5.d}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x70,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110000-01001110-00100101
LD1B    {Z5.D}, P3/Z, [X17, X16]  // 10100100-01110000-01001110-00100101
// CHECK: ld1b    {z5.d}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0x70,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110000-01001110-00100101
ld1b    {z21.d}, p5/z, [x10, z21.d, sxtw]  // 11000100-01010101-01010101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [x10, z21.d, sxtw] // encoding: [0x55,0x55,0x55,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01010101-01010101-01010101
LD1B    {Z21.D}, P5/Z, [X10, Z21.D, SXTW]  // 11000100-01010101-01010101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [x10, z21.d, sxtw] // encoding: [0x55,0x55,0x55,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01010101-01010101-01010101
ld1b    {z0.b}, p0/z, [x0, x0]  // 10100100-00000000-01000000-00000000
// CHECK: ld1b    {z0.b}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-01000000-00000000
LD1B    {Z0.B}, P0/Z, [X0, X0]  // 10100100-00000000-01000000-00000000
// CHECK: ld1b    {z0.b}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-01000000-00000000
ld1b    {z0.d}, p0/z, [x0, z0.d, uxtw]  // 11000100-00000000-01000000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x40,0x00,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00000000-01000000-00000000
LD1B    {Z0.D}, P0/Z, [X0, Z0.D, UXTW]  // 11000100-00000000-01000000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x40,0x00,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00000000-01000000-00000000
ld1b    {z0.s}, p0/z, [x0, z0.s, sxtw]  // 10000100-01000000-01000000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x40,0x40,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01000000-01000000-00000000
LD1B    {Z0.S}, P0/Z, [X0, Z0.S, SXTW]  // 10000100-01000000-01000000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x40,0x40,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01000000-01000000-00000000
ld1b    {z0.h}, p0/z, [x0, x0]  // 10100100-00100000-01000000-00000000
// CHECK: ld1b    {z0.h}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x20,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00100000-01000000-00000000
LD1B    {Z0.H}, P0/Z, [X0, X0]  // 10100100-00100000-01000000-00000000
// CHECK: ld1b    {z0.h}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x20,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00100000-01000000-00000000
ld1b    {z31.s}, p7/z, [sp, #-1, mul vl]  // 10100100-01001111-10111111-11111111
// CHECK: ld1b    {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x4f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01001111-10111111-11111111
LD1B    {Z31.S}, P7/Z, [SP, #-1, MUL VL]  // 10100100-01001111-10111111-11111111
// CHECK: ld1b    {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x4f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01001111-10111111-11111111
ld1b    {z21.b}, p5/z, [x10, #5, mul vl]  // 10100100-00000101-10110101-01010101
// CHECK: ld1b    {z21.b}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x05,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000101-10110101-01010101
LD1B    {Z21.B}, P5/Z, [X10, #5, MUL VL]  // 10100100-00000101-10110101-01010101
// CHECK: ld1b    {z21.b}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x05,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000101-10110101-01010101
ld1b    {z23.d}, p3/z, [x13, z8.d]  // 11000100-01001000-11001101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xcd,0x48,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01001000-11001101-10110111
LD1B    {Z23.D}, P3/Z, [X13, Z8.D]  // 11000100-01001000-11001101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xcd,0x48,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01001000-11001101-10110111
ld1b    {z0.d}, p0/z, [x0, z0.d, sxtw]  // 11000100-01000000-01000000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [x0, z0.d, sxtw] // encoding: [0x00,0x40,0x40,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01000000-01000000-00000000
LD1B    {Z0.D}, P0/Z, [X0, Z0.D, SXTW]  // 11000100-01000000-01000000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [x0, z0.d, sxtw] // encoding: [0x00,0x40,0x40,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01000000-01000000-00000000
ld1b    {z23.b}, p3/z, [x13, x8]  // 10100100-00001000-01001101-10110111
// CHECK: ld1b    {z23.b}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-01001101-10110111
LD1B    {Z23.B}, P3/Z, [X13, X8]  // 10100100-00001000-01001101-10110111
// CHECK: ld1b    {z23.b}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-01001101-10110111
ld1b    {z0.h}, p0/z, [x0]  // 10100100-00100000-10100000-00000000
// CHECK: ld1b    {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0x20,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00100000-10100000-00000000
LD1B    {Z0.H}, P0/Z, [X0]  // 10100100-00100000-10100000-00000000
// CHECK: ld1b    {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0x20,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00100000-10100000-00000000
ld1b    {z21.h}, p5/z, [x10, #5, mul vl]  // 10100100-00100101-10110101-01010101
// CHECK: ld1b    {z21.h}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x25,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00100101-10110101-01010101
LD1B    {Z21.H}, P5/Z, [X10, #5, MUL VL]  // 10100100-00100101-10110101-01010101
// CHECK: ld1b    {z21.h}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x25,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00100101-10110101-01010101
ld1b    {z0.s}, p0/z, [x0, z0.s, uxtw]  // 10000100-00000000-01000000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [x0, z0.s, uxtw] // encoding: [0x00,0x40,0x00,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00000000-01000000-00000000
LD1B    {Z0.S}, P0/Z, [X0, Z0.S, UXTW]  // 10000100-00000000-01000000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [x0, z0.s, uxtw] // encoding: [0x00,0x40,0x00,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00000000-01000000-00000000
ld1b    {z23.s}, p3/z, [x13, x8]  // 10100100-01001000-01001101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x48,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01001000-01001101-10110111
LD1B    {Z23.S}, P3/Z, [X13, X8]  // 10100100-01001000-01001101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x48,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01001000-01001101-10110111
ld1b    {z21.s}, p5/z, [x10, #5, mul vl]  // 10100100-01000101-10110101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x45,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01000101-10110101-01010101
LD1B    {Z21.S}, P5/Z, [X10, #5, MUL VL]  // 10100100-01000101-10110101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x45,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01000101-10110101-01010101
ld1b    {z31.d}, p7/z, [sp, z31.d, uxtw]  // 11000100-00011111-01011111-11111111
// CHECK: ld1b    {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x5f,0x1f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00011111-01011111-11111111
LD1B    {Z31.D}, P7/Z, [SP, Z31.D, UXTW]  // 11000100-00011111-01011111-11111111
// CHECK: ld1b    {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x5f,0x1f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00011111-01011111-11111111
ld1b    {z23.h}, p3/z, [x13, x8]  // 10100100-00101000-01001101-10110111
// CHECK: ld1b    {z23.h}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x28,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00101000-01001101-10110111
LD1B    {Z23.H}, P3/Z, [X13, X8]  // 10100100-00101000-01001101-10110111
// CHECK: ld1b    {z23.h}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0x28,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00101000-01001101-10110111
ld1b    {z31.s}, p7/z, [sp, z31.s, sxtw]  // 10000100-01011111-01011111-11111111
// CHECK: ld1b    {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x5f,0x5f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01011111-01011111-11111111
LD1B    {Z31.S}, P7/Z, [SP, Z31.S, SXTW]  // 10000100-01011111-01011111-11111111
// CHECK: ld1b    {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x5f,0x5f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01011111-01011111-11111111
ld1b    {z0.b}, p0/z, [x0]  // 10100100-00000000-10100000-00000000
// CHECK: ld1b    {z0.b}, p0/z, [x0] // encoding: [0x00,0xa0,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-10100000-00000000
LD1B    {Z0.B}, P0/Z, [X0]  // 10100100-00000000-10100000-00000000
// CHECK: ld1b    {z0.b}, p0/z, [x0] // encoding: [0x00,0xa0,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-10100000-00000000
ld1b    {z23.d}, p3/z, [x13, z8.d, sxtw]  // 11000100-01001000-01001101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [x13, z8.d, sxtw] // encoding: [0xb7,0x4d,0x48,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01001000-01001101-10110111
LD1B    {Z23.D}, P3/Z, [X13, Z8.D, SXTW]  // 11000100-01001000-01001101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [x13, z8.d, sxtw] // encoding: [0xb7,0x4d,0x48,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01001000-01001101-10110111
ld1b    {z21.d}, p5/z, [x10, z21.d, uxtw]  // 11000100-00010101-01010101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x55,0x15,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00010101-01010101-01010101
LD1B    {Z21.D}, P5/Z, [X10, Z21.D, UXTW]  // 11000100-00010101-01010101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x55,0x15,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00010101-01010101-01010101
ld1b    {z23.s}, p3/z, [x13, z8.s, uxtw]  // 10000100-00001000-01001101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [x13, z8.s, uxtw] // encoding: [0xb7,0x4d,0x08,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00001000-01001101-10110111
LD1B    {Z23.S}, P3/Z, [X13, Z8.S, UXTW]  // 10000100-00001000-01001101-10110111
// CHECK: ld1b    {z23.s}, p3/z, [x13, z8.s, uxtw] // encoding: [0xb7,0x4d,0x08,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00001000-01001101-10110111
ld1b    {z0.s}, p0/z, [z0.s]  // 10000100-00100000-11000000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [z0.s] // encoding: [0x00,0xc0,0x20,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00100000-11000000-00000000
LD1B    {Z0.S}, P0/Z, [Z0.S]  // 10000100-00100000-11000000-00000000
// CHECK: ld1b    {z0.s}, p0/z, [z0.s] // encoding: [0x00,0xc0,0x20,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00100000-11000000-00000000
ld1b    {z31.s}, p7/z, [z31.s, #31]  // 10000100-00111111-11011111-11111111
// CHECK: ld1b    {z31.s}, p7/z, [z31.s, #31] // encoding: [0xff,0xdf,0x3f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00111111-11011111-11111111
LD1B    {Z31.S}, P7/Z, [Z31.S, #31]  // 10000100-00111111-11011111-11111111
// CHECK: ld1b    {z31.s}, p7/z, [z31.s, #31] // encoding: [0xff,0xdf,0x3f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00111111-11011111-11111111
ld1b    {z21.d}, p5/z, [x10, x21]  // 10100100-01110101-01010101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x75,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110101-01010101-01010101
LD1B    {Z21.D}, P5/Z, [X10, X21]  // 10100100-01110101-01010101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x75,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110101-01010101-01010101
ld1b    {z21.s}, p5/z, [x10, x21]  // 10100100-01010101-01010101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x55,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01010101-01010101-01010101
LD1B    {Z21.S}, P5/Z, [X10, X21]  // 10100100-01010101-01010101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x55,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01010101-01010101-01010101
ld1b    {z21.d}, p5/z, [z10.d, #21]  // 11000100-00110101-11010101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [z10.d, #21] // encoding: [0x55,0xd5,0x35,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00110101-11010101-01010101
LD1B    {Z21.D}, P5/Z, [Z10.D, #21]  // 11000100-00110101-11010101-01010101
// CHECK: ld1b    {z21.d}, p5/z, [z10.d, #21] // encoding: [0x55,0xd5,0x35,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00110101-11010101-01010101
ld1b    {z31.b}, p7/z, [sp, #-1, mul vl]  // 10100100-00001111-10111111-11111111
// CHECK: ld1b    {z31.b}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x0f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001111-10111111-11111111
LD1B    {Z31.B}, P7/Z, [SP, #-1, MUL VL]  // 10100100-00001111-10111111-11111111
// CHECK: ld1b    {z31.b}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x0f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001111-10111111-11111111
ld1b    {z0.d}, p0/z, [x0, x0]  // 10100100-01100000-01000000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x60,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100000-01000000-00000000
LD1B    {Z0.D}, P0/Z, [X0, X0]  // 10100100-01100000-01000000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [x0, x0] // encoding: [0x00,0x40,0x60,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100000-01000000-00000000
ld1b    {z31.d}, p7/z, [sp, z31.d]  // 11000100-01011111-11011111-11111111
// CHECK: ld1b    {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xdf,0x5f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01011111-11011111-11111111
LD1B    {Z31.D}, P7/Z, [SP, Z31.D]  // 11000100-01011111-11011111-11111111
// CHECK: ld1b    {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xdf,0x5f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01011111-11011111-11111111
ld1b    {z21.b}, p5/z, [x10, x21]  // 10100100-00010101-01010101-01010101
// CHECK: ld1b    {z21.b}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x15,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010101-01010101-01010101
LD1B    {Z21.B}, P5/Z, [X10, X21]  // 10100100-00010101-01010101-01010101
// CHECK: ld1b    {z21.b}, p5/z, [x10, x21] // encoding: [0x55,0x55,0x15,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010101-01010101-01010101
ld1b    {z23.d}, p3/z, [x13, #-8, mul vl]  // 10100100-01101000-10101101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x68,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101000-10101101-10110111
LD1B    {Z23.D}, P3/Z, [X13, #-8, MUL VL]  // 10100100-01101000-10101101-10110111
// CHECK: ld1b    {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x68,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101000-10101101-10110111
ld1b    {z21.s}, p5/z, [x10, z21.s, uxtw]  // 10000100-00010101-01010101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [x10, z21.s, uxtw] // encoding: [0x55,0x55,0x15,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00010101-01010101-01010101
LD1B    {Z21.S}, P5/Z, [X10, Z21.S, UXTW]  // 10000100-00010101-01010101-01010101
// CHECK: ld1b    {z21.s}, p5/z, [x10, z21.s, uxtw] // encoding: [0x55,0x55,0x15,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00010101-01010101-01010101
ld1b    {z0.d}, p0/z, [z0.d]  // 11000100-00100000-11000000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xc0,0x20,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00100000-11000000-00000000
LD1B    {Z0.D}, P0/Z, [Z0.D]  // 11000100-00100000-11000000-00000000
// CHECK: ld1b    {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xc0,0x20,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00100000-11000000-00000000
