// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1h    {z31.d}, p7/z, [sp, #-1, mul vl]  // 10100100-11101111-10111111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xef,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11101111-10111111-11111111
LD1H    {Z31.D}, P7/Z, [SP, #-1, MUL VL]  // 10100100-11101111-10111111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xef,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11101111-10111111-11111111
ld1h    {z23.d}, p3/z, [x13, z8.d, uxtw]  // 11000100-10001000-01001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x4d,0x88,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10001000-01001101-10110111
LD1H    {Z23.D}, P3/Z, [X13, Z8.D, UXTW]  // 11000100-10001000-01001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x4d,0x88,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10001000-01001101-10110111
ld1h    {z0.d}, p0/z, [x0, z0.d, uxtw]  // 11000100-10000000-01000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x40,0x80,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10000000-01000000-00000000
LD1H    {Z0.D}, P0/Z, [X0, Z0.D, UXTW]  // 11000100-10000000-01000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x40,0x80,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10000000-01000000-00000000
ld1h    {z21.s}, p5/z, [x10, z21.s, sxtw]  // 10000100-11010101-01010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x55,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-01010101-01010101
LD1H    {Z21.S}, P5/Z, [X10, Z21.S, SXTW]  // 10000100-11010101-01010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x55,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-01010101-01010101
ld1h    {z0.s}, p0/z, [x0, z0.s, sxtw]  // 10000100-11000000-01000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x40,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-01000000-00000000
LD1H    {Z0.S}, P0/Z, [X0, Z0.S, SXTW]  // 10000100-11000000-01000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x40,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-01000000-00000000
ld1h    {z21.d}, p5/z, [x10, x21, lsl #1]  // 10100100-11110101-01010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xf5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11110101-01010101-01010101
LD1H    {Z21.D}, P5/Z, [X10, X21, LSL #1]  // 10100100-11110101-01010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xf5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11110101-01010101-01010101
ld1h    {z23.d}, p3/z, [x13, z8.d, lsl #1]  // 11000100-11101000-11001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, lsl #1] // encoding: [0xb7,0xcd,0xe8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11101000-11001101-10110111
LD1H    {Z23.D}, P3/Z, [X13, Z8.D, LSL #1]  // 11000100-11101000-11001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, lsl #1] // encoding: [0xb7,0xcd,0xe8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11101000-11001101-10110111
ld1h    {z21.d}, p5/z, [x10, z21.d, uxtw]  // 11000100-10010101-01010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x55,0x95,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10010101-01010101-01010101
LD1H    {Z21.D}, P5/Z, [X10, Z21.D, UXTW]  // 11000100-10010101-01010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x55,0x95,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10010101-01010101-01010101
ld1h    {z0.s}, p0/z, [x0, z0.s, sxtw #1]  // 10000100-11100000-01000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, sxtw #1] // encoding: [0x00,0x40,0xe0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11100000-01000000-00000000
LD1H    {Z0.S}, P0/Z, [X0, Z0.S, SXTW #1]  // 10000100-11100000-01000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, sxtw #1] // encoding: [0x00,0x40,0xe0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11100000-01000000-00000000
ld1h    {z21.h}, p5/z, [x10, #5, mul vl]  // 10100100-10100101-10110101-01010101
// CHECK: ld1h    {z21.h}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xa5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10100101-10110101-01010101
LD1H    {Z21.H}, P5/Z, [X10, #5, MUL VL]  // 10100100-10100101-10110101-01010101
// CHECK: ld1h    {z21.h}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xa5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10100101-10110101-01010101
ld1h    {z23.s}, p3/z, [x13, #-8, mul vl]  // 10100100-11001000-10101101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xc8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001000-10101101-10110111
LD1H    {Z23.S}, P3/Z, [X13, #-8, MUL VL]  // 10100100-11001000-10101101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xc8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001000-10101101-10110111
ld1h    {z0.d}, p0/z, [x0]  // 10100100-11100000-10100000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0xe0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11100000-10100000-00000000
LD1H    {Z0.D}, P0/Z, [X0]  // 10100100-11100000-10100000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0xe0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11100000-10100000-00000000
ld1h    {z0.d}, p0/z, [x0, z0.d, lsl #1]  // 11000100-11100000-11000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, lsl #1] // encoding: [0x00,0xc0,0xe0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11100000-11000000-00000000
LD1H    {Z0.D}, P0/Z, [X0, Z0.D, LSL #1]  // 11000100-11100000-11000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, lsl #1] // encoding: [0x00,0xc0,0xe0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11100000-11000000-00000000
ld1h    {z23.h}, p3/z, [x13, #-8, mul vl]  // 10100100-10101000-10101101-10110111
// CHECK: ld1h    {z23.h}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xa8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10101000-10101101-10110111
LD1H    {Z23.H}, P3/Z, [X13, #-8, MUL VL]  // 10100100-10101000-10101101-10110111
// CHECK: ld1h    {z23.h}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xa8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10101000-10101101-10110111
ld1h    {z0.h}, p0/z, [x0]  // 10100100-10100000-10100000-00000000
// CHECK: ld1h    {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0xa0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10100000-10100000-00000000
LD1H    {Z0.H}, P0/Z, [X0]  // 10100100-10100000-10100000-00000000
// CHECK: ld1h    {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0xa0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10100000-10100000-00000000
ld1h    {z21.s}, p5/z, [x10, z21.s, uxtw]  // 10000100-10010101-01010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, uxtw] // encoding: [0x55,0x55,0x95,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10010101-01010101-01010101
LD1H    {Z21.S}, P5/Z, [X10, Z21.S, UXTW]  // 10000100-10010101-01010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, uxtw] // encoding: [0x55,0x55,0x95,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10010101-01010101-01010101
ld1h    {z0.s}, p0/z, [z0.s]  // 10000100-10100000-11000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [z0.s] // encoding: [0x00,0xc0,0xa0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10100000-11000000-00000000
LD1H    {Z0.S}, P0/Z, [Z0.S]  // 10000100-10100000-11000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [z0.s] // encoding: [0x00,0xc0,0xa0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10100000-11000000-00000000
ld1h    {z23.d}, p3/z, [x13, z8.d, sxtw]  // 11000100-11001000-01001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, sxtw] // encoding: [0xb7,0x4d,0xc8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11001000-01001101-10110111
LD1H    {Z23.D}, P3/Z, [X13, Z8.D, SXTW]  // 11000100-11001000-01001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, sxtw] // encoding: [0xb7,0x4d,0xc8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11001000-01001101-10110111
ld1h    {z0.d}, p0/z, [x0, z0.d, uxtw #1]  // 11000100-10100000-01000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, uxtw #1] // encoding: [0x00,0x40,0xa0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10100000-01000000-00000000
LD1H    {Z0.D}, P0/Z, [X0, Z0.D, UXTW #1]  // 11000100-10100000-01000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, uxtw #1] // encoding: [0x00,0x40,0xa0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10100000-01000000-00000000
ld1h    {z21.d}, p5/z, [x10, z21.d, sxtw]  // 11000100-11010101-01010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, sxtw] // encoding: [0x55,0x55,0xd5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11010101-01010101-01010101
LD1H    {Z21.D}, P5/Z, [X10, Z21.D, SXTW]  // 11000100-11010101-01010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, sxtw] // encoding: [0x55,0x55,0xd5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11010101-01010101-01010101
ld1h    {z23.d}, p3/z, [x13, #-8, mul vl]  // 10100100-11101000-10101101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xe8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11101000-10101101-10110111
LD1H    {Z23.D}, P3/Z, [X13, #-8, MUL VL]  // 10100100-11101000-10101101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xe8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11101000-10101101-10110111
ld1h    {z21.h}, p5/z, [x10, x21, lsl #1]  // 10100100-10110101-01010101-01010101
// CHECK: ld1h    {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xb5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10110101-01010101-01010101
LD1H    {Z21.H}, P5/Z, [X10, X21, LSL #1]  // 10100100-10110101-01010101-01010101
// CHECK: ld1h    {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xb5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10110101-01010101-01010101
ld1h    {z23.d}, p3/z, [z13.d, #16]  // 11000100-10101000-11001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [z13.d, #16] // encoding: [0xb7,0xcd,0xa8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10101000-11001101-10110111
LD1H    {Z23.D}, P3/Z, [Z13.D, #16]  // 11000100-10101000-11001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [z13.d, #16] // encoding: [0xb7,0xcd,0xa8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10101000-11001101-10110111
ld1h    {z21.d}, p5/z, [x10, z21.d, lsl #1]  // 11000100-11110101-11010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, lsl #1] // encoding: [0x55,0xd5,0xf5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11110101-11010101-01010101
LD1H    {Z21.D}, P5/Z, [X10, Z21.D, LSL #1]  // 11000100-11110101-11010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, lsl #1] // encoding: [0x55,0xd5,0xf5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11110101-11010101-01010101
ld1h    {z0.d}, p0/z, [x0, x0, lsl #1]  // 10100100-11100000-01000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xe0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11100000-01000000-00000000
LD1H    {Z0.D}, P0/Z, [X0, X0, LSL #1]  // 10100100-11100000-01000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xe0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11100000-01000000-00000000
ld1h    {z31.d}, p7/z, [sp, z31.d, uxtw #1]  // 11000100-10111111-01011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, uxtw #1] // encoding: [0xff,0x5f,0xbf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10111111-01011111-11111111
LD1H    {Z31.D}, P7/Z, [SP, Z31.D, UXTW #1]  // 11000100-10111111-01011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, uxtw #1] // encoding: [0xff,0x5f,0xbf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10111111-01011111-11111111
ld1h    {z31.s}, p7/z, [sp, z31.s, sxtw #1]  // 10000100-11111111-01011111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, sxtw #1] // encoding: [0xff,0x5f,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-01011111-11111111
LD1H    {Z31.S}, P7/Z, [SP, Z31.S, SXTW #1]  // 10000100-11111111-01011111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, sxtw #1] // encoding: [0xff,0x5f,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-01011111-11111111
ld1h    {z31.d}, p7/z, [sp, z31.d, lsl #1]  // 11000100-11111111-11011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, lsl #1] // encoding: [0xff,0xdf,0xff,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11111111-11011111-11111111
LD1H    {Z31.D}, P7/Z, [SP, Z31.D, LSL #1]  // 11000100-11111111-11011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, lsl #1] // encoding: [0xff,0xdf,0xff,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11111111-11011111-11111111
ld1h    {z21.d}, p5/z, [z10.d, #42]  // 11000100-10110101-11010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [z10.d, #42] // encoding: [0x55,0xd5,0xb5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10110101-11010101-01010101
LD1H    {Z21.D}, P5/Z, [Z10.D, #42]  // 11000100-10110101-11010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [z10.d, #42] // encoding: [0x55,0xd5,0xb5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10110101-11010101-01010101
ld1h    {z0.s}, p0/z, [x0]  // 10100100-11000000-10100000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0xc0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000000-10100000-00000000
LD1H    {Z0.S}, P0/Z, [X0]  // 10100100-11000000-10100000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0xc0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000000-10100000-00000000
ld1h    {z21.d}, p5/z, [x10, z21.d]  // 11000100-11010101-11010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xd5,0xd5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11010101-11010101-01010101
LD1H    {Z21.D}, P5/Z, [X10, Z21.D]  // 11000100-11010101-11010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xd5,0xd5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11010101-11010101-01010101
ld1h    {z31.s}, p7/z, [z31.s, #62]  // 10000100-10111111-11011111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [z31.s, #62] // encoding: [0xff,0xdf,0xbf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10111111-11011111-11111111
LD1H    {Z31.S}, P7/Z, [Z31.S, #62]  // 10000100-10111111-11011111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [z31.s, #62] // encoding: [0xff,0xdf,0xbf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10111111-11011111-11111111
ld1h    {z21.s}, p5/z, [x10, x21, lsl #1]  // 10100100-11010101-01010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xd5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11010101-01010101-01010101
LD1H    {Z21.S}, P5/Z, [X10, X21, LSL #1]  // 10100100-11010101-01010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xd5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11010101-01010101-01010101
ld1h    {z31.s}, p7/z, [sp, z31.s, uxtw]  // 10000100-10011111-01011111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, uxtw] // encoding: [0xff,0x5f,0x9f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10011111-01011111-11111111
LD1H    {Z31.S}, P7/Z, [SP, Z31.S, UXTW]  // 10000100-10011111-01011111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, uxtw] // encoding: [0xff,0x5f,0x9f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10011111-01011111-11111111
ld1h    {z23.s}, p3/z, [x13, z8.s, uxtw #1]  // 10000100-10101000-01001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, uxtw #1] // encoding: [0xb7,0x4d,0xa8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10101000-01001101-10110111
LD1H    {Z23.S}, P3/Z, [X13, Z8.S, UXTW #1]  // 10000100-10101000-01001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, uxtw #1] // encoding: [0xb7,0x4d,0xa8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10101000-01001101-10110111
ld1h    {z31.h}, p7/z, [sp, #-1, mul vl]  // 10100100-10101111-10111111-11111111
// CHECK: ld1h    {z31.h}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xaf,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10101111-10111111-11111111
LD1H    {Z31.H}, P7/Z, [SP, #-1, MUL VL]  // 10100100-10101111-10111111-11111111
// CHECK: ld1h    {z31.h}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xaf,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10101111-10111111-11111111
ld1h    {z21.s}, p5/z, [x10, #5, mul vl]  // 10100100-11000101-10110101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xc5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000101-10110101-01010101
LD1H    {Z21.S}, P5/Z, [X10, #5, MUL VL]  // 10100100-11000101-10110101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xc5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000101-10110101-01010101
ld1h    {z31.s}, p7/z, [sp, z31.s, sxtw]  // 10000100-11011111-01011111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x5f,0xdf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11011111-01011111-11111111
LD1H    {Z31.S}, P7/Z, [SP, Z31.S, SXTW]  // 10000100-11011111-01011111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x5f,0xdf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11011111-01011111-11111111
ld1h    {z31.d}, p7/z, [sp, z31.d]  // 11000100-11011111-11011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xdf,0xdf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11011111-11011111-11111111
LD1H    {Z31.D}, P7/Z, [SP, Z31.D]  // 11000100-11011111-11011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xdf,0xdf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11011111-11011111-11111111
ld1h    {z31.d}, p7/z, [z31.d, #62]  // 11000100-10111111-11011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [z31.d, #62] // encoding: [0xff,0xdf,0xbf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10111111-11011111-11111111
LD1H    {Z31.D}, P7/Z, [Z31.D, #62]  // 11000100-10111111-11011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [z31.d, #62] // encoding: [0xff,0xdf,0xbf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10111111-11011111-11111111
ld1h    {z0.d}, p0/z, [x0, z0.d, sxtw]  // 11000100-11000000-01000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, sxtw] // encoding: [0x00,0x40,0xc0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11000000-01000000-00000000
LD1H    {Z0.D}, P0/Z, [X0, Z0.D, SXTW]  // 11000100-11000000-01000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, sxtw] // encoding: [0x00,0x40,0xc0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11000000-01000000-00000000
ld1h    {z21.d}, p5/z, [x10, #5, mul vl]  // 10100100-11100101-10110101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xe5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11100101-10110101-01010101
LD1H    {Z21.D}, P5/Z, [X10, #5, MUL VL]  // 10100100-11100101-10110101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xe5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11100101-10110101-01010101
ld1h    {z0.d}, p0/z, [x0, z0.d, sxtw #1]  // 11000100-11100000-01000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, sxtw #1] // encoding: [0x00,0x40,0xe0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11100000-01000000-00000000
LD1H    {Z0.D}, P0/Z, [X0, Z0.D, SXTW #1]  // 11000100-11100000-01000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, sxtw #1] // encoding: [0x00,0x40,0xe0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11100000-01000000-00000000
ld1h    {z23.d}, p3/z, [x13, x8, lsl #1]  // 10100100-11101000-01001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xe8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11101000-01001101-10110111
LD1H    {Z23.D}, P3/Z, [X13, X8, LSL #1]  // 10100100-11101000-01001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xe8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11101000-01001101-10110111
ld1h    {z0.d}, p0/z, [x0, z0.d]  // 11000100-11000000-11000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xc0,0xc0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11000000-11000000-00000000
LD1H    {Z0.D}, P0/Z, [X0, Z0.D]  // 11000100-11000000-11000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xc0,0xc0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11000000-11000000-00000000
ld1h    {z23.d}, p3/z, [x13, z8.d]  // 11000100-11001000-11001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xcd,0xc8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11001000-11001101-10110111
LD1H    {Z23.D}, P3/Z, [X13, Z8.D]  // 11000100-11001000-11001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xcd,0xc8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11001000-11001101-10110111
ld1h    {z0.d}, p0/z, [z0.d]  // 11000100-10100000-11000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xc0,0xa0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10100000-11000000-00000000
LD1H    {Z0.D}, P0/Z, [Z0.D]  // 11000100-10100000-11000000-00000000
// CHECK: ld1h    {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xc0,0xa0,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10100000-11000000-00000000
ld1h    {z21.s}, p5/z, [z10.s, #42]  // 10000100-10110101-11010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [z10.s, #42] // encoding: [0x55,0xd5,0xb5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10110101-11010101-01010101
LD1H    {Z21.S}, P5/Z, [Z10.S, #42]  // 10000100-10110101-11010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [z10.s, #42] // encoding: [0x55,0xd5,0xb5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10110101-11010101-01010101
ld1h    {z31.s}, p7/z, [sp, z31.s, uxtw #1]  // 10000100-10111111-01011111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, uxtw #1] // encoding: [0xff,0x5f,0xbf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10111111-01011111-11111111
LD1H    {Z31.S}, P7/Z, [SP, Z31.S, UXTW #1]  // 10000100-10111111-01011111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, uxtw #1] // encoding: [0xff,0x5f,0xbf,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10111111-01011111-11111111
ld1h    {z23.s}, p3/z, [x13, x8, lsl #1]  // 10100100-11001000-01001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xc8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001000-01001101-10110111
LD1H    {Z23.S}, P3/Z, [X13, X8, LSL #1]  // 10100100-11001000-01001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xc8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001000-01001101-10110111
ld1h    {z31.s}, p7/z, [sp, #-1, mul vl]  // 10100100-11001111-10111111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xcf,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001111-10111111-11111111
LD1H    {Z31.S}, P7/Z, [SP, #-1, MUL VL]  // 10100100-11001111-10111111-11111111
// CHECK: ld1h    {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xcf,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001111-10111111-11111111
ld1h    {z21.s}, p5/z, [x10, z21.s, sxtw #1]  // 10000100-11110101-01010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, sxtw #1] // encoding: [0x55,0x55,0xf5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11110101-01010101-01010101
LD1H    {Z21.S}, P5/Z, [X10, Z21.S, SXTW #1]  // 10000100-11110101-01010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, sxtw #1] // encoding: [0x55,0x55,0xf5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11110101-01010101-01010101
ld1h    {z31.d}, p7/z, [sp, z31.d, uxtw]  // 11000100-10011111-01011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x5f,0x9f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10011111-01011111-11111111
LD1H    {Z31.D}, P7/Z, [SP, Z31.D, UXTW]  // 11000100-10011111-01011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x5f,0x9f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10011111-01011111-11111111
ld1h    {z23.s}, p3/z, [x13, z8.s, uxtw]  // 10000100-10001000-01001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, uxtw] // encoding: [0xb7,0x4d,0x88,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10001000-01001101-10110111
LD1H    {Z23.S}, P3/Z, [X13, Z8.S, UXTW]  // 10000100-10001000-01001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, uxtw] // encoding: [0xb7,0x4d,0x88,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10001000-01001101-10110111
ld1h    {z23.s}, p3/z, [x13, z8.s, sxtw #1]  // 10000100-11101000-01001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, sxtw #1] // encoding: [0xb7,0x4d,0xe8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11101000-01001101-10110111
LD1H    {Z23.S}, P3/Z, [X13, Z8.S, SXTW #1]  // 10000100-11101000-01001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, sxtw #1] // encoding: [0xb7,0x4d,0xe8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11101000-01001101-10110111
ld1h    {z5.h}, p3/z, [x17, x16, lsl #1]  // 10100100-10110000-01001110-00100101
// CHECK: ld1h    {z5.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xb0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10110000-01001110-00100101
LD1H    {Z5.H}, P3/Z, [X17, X16, LSL #1]  // 10100100-10110000-01001110-00100101
// CHECK: ld1h    {z5.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xb0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10110000-01001110-00100101
ld1h    {z21.s}, p5/z, [x10, z21.s, uxtw #1]  // 10000100-10110101-01010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, uxtw #1] // encoding: [0x55,0x55,0xb5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10110101-01010101-01010101
LD1H    {Z21.S}, P5/Z, [X10, Z21.S, UXTW #1]  // 10000100-10110101-01010101-01010101
// CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, uxtw #1] // encoding: [0x55,0x55,0xb5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10110101-01010101-01010101
ld1h    {z0.s}, p0/z, [x0, x0, lsl #1]  // 10100100-11000000-01000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xc0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000000-01000000-00000000
LD1H    {Z0.S}, P0/Z, [X0, X0, LSL #1]  // 10100100-11000000-01000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xc0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000000-01000000-00000000
ld1h    {z31.d}, p7/z, [sp, z31.d, sxtw]  // 11000100-11011111-01011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, sxtw] // encoding: [0xff,0x5f,0xdf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11011111-01011111-11111111
LD1H    {Z31.D}, P7/Z, [SP, Z31.D, SXTW]  // 11000100-11011111-01011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, sxtw] // encoding: [0xff,0x5f,0xdf,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11011111-01011111-11111111
ld1h    {z23.h}, p3/z, [x13, x8, lsl #1]  // 10100100-10101000-01001101-10110111
// CHECK: ld1h    {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xa8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10101000-01001101-10110111
LD1H    {Z23.H}, P3/Z, [X13, X8, LSL #1]  // 10100100-10101000-01001101-10110111
// CHECK: ld1h    {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xa8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10101000-01001101-10110111
ld1h    {z21.d}, p5/z, [x10, z21.d, uxtw #1]  // 11000100-10110101-01010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, uxtw #1] // encoding: [0x55,0x55,0xb5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10110101-01010101-01010101
LD1H    {Z21.D}, P5/Z, [X10, Z21.D, UXTW #1]  // 11000100-10110101-01010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, uxtw #1] // encoding: [0x55,0x55,0xb5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10110101-01010101-01010101
ld1h    {z23.d}, p3/z, [x13, z8.d, sxtw #1]  // 11000100-11101000-01001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, sxtw #1] // encoding: [0xb7,0x4d,0xe8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11101000-01001101-10110111
LD1H    {Z23.D}, P3/Z, [X13, Z8.D, SXTW #1]  // 11000100-11101000-01001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, sxtw #1] // encoding: [0xb7,0x4d,0xe8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11101000-01001101-10110111
ld1h    {z0.s}, p0/z, [x0, z0.s, uxtw #1]  // 10000100-10100000-01000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, uxtw #1] // encoding: [0x00,0x40,0xa0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10100000-01000000-00000000
LD1H    {Z0.S}, P0/Z, [X0, Z0.S, UXTW #1]  // 10000100-10100000-01000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, uxtw #1] // encoding: [0x00,0x40,0xa0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10100000-01000000-00000000
ld1h    {z0.h}, p0/z, [x0, x0, lsl #1]  // 10100100-10100000-01000000-00000000
// CHECK: ld1h    {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xa0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10100000-01000000-00000000
LD1H    {Z0.H}, P0/Z, [X0, X0, LSL #1]  // 10100100-10100000-01000000-00000000
// CHECK: ld1h    {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xa0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10100000-01000000-00000000
ld1h    {z23.d}, p3/z, [x13, z8.d, uxtw #1]  // 11000100-10101000-01001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, uxtw #1] // encoding: [0xb7,0x4d,0xa8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10101000-01001101-10110111
LD1H    {Z23.D}, P3/Z, [X13, Z8.D, UXTW #1]  // 11000100-10101000-01001101-10110111
// CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, uxtw #1] // encoding: [0xb7,0x4d,0xa8,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-10101000-01001101-10110111
ld1h    {z23.s}, p3/z, [x13, z8.s, sxtw]  // 10000100-11001000-01001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x4d,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-01001101-10110111
LD1H    {Z23.S}, P3/Z, [X13, Z8.S, SXTW]  // 10000100-11001000-01001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x4d,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-01001101-10110111
ld1h    {z31.d}, p7/z, [sp, z31.d, sxtw #1]  // 11000100-11111111-01011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, sxtw #1] // encoding: [0xff,0x5f,0xff,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11111111-01011111-11111111
LD1H    {Z31.D}, P7/Z, [SP, Z31.D, SXTW #1]  // 11000100-11111111-01011111-11111111
// CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, sxtw #1] // encoding: [0xff,0x5f,0xff,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11111111-01011111-11111111
ld1h    {z23.s}, p3/z, [z13.s, #16]  // 10000100-10101000-11001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [z13.s, #16] // encoding: [0xb7,0xcd,0xa8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10101000-11001101-10110111
LD1H    {Z23.S}, P3/Z, [Z13.S, #16]  // 10000100-10101000-11001101-10110111
// CHECK: ld1h    {z23.s}, p3/z, [z13.s, #16] // encoding: [0xb7,0xcd,0xa8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10101000-11001101-10110111
ld1h    {z5.s}, p3/z, [x17, x16, lsl #1]  // 10100100-11010000-01001110-00100101
// CHECK: ld1h    {z5.s}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xd0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11010000-01001110-00100101
LD1H    {Z5.S}, P3/Z, [X17, X16, LSL #1]  // 10100100-11010000-01001110-00100101
// CHECK: ld1h    {z5.s}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xd0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11010000-01001110-00100101
ld1h    {z5.d}, p3/z, [x17, x16, lsl #1]  // 10100100-11110000-01001110-00100101
// CHECK: ld1h    {z5.d}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xf0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11110000-01001110-00100101
LD1H    {Z5.D}, P3/Z, [X17, X16, LSL #1]  // 10100100-11110000-01001110-00100101
// CHECK: ld1h    {z5.d}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xf0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11110000-01001110-00100101
ld1h    {z0.s}, p0/z, [x0, z0.s, uxtw]  // 10000100-10000000-01000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, uxtw] // encoding: [0x00,0x40,0x80,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10000000-01000000-00000000
LD1H    {Z0.S}, P0/Z, [X0, Z0.S, UXTW]  // 10000100-10000000-01000000-00000000
// CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, uxtw] // encoding: [0x00,0x40,0x80,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-10000000-01000000-00000000
ld1h    {z21.d}, p5/z, [x10, z21.d, sxtw #1]  // 11000100-11110101-01010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, sxtw #1] // encoding: [0x55,0x55,0xf5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11110101-01010101-01010101
LD1H    {Z21.D}, P5/Z, [X10, Z21.D, SXTW #1]  // 11000100-11110101-01010101-01010101
// CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, sxtw #1] // encoding: [0x55,0x55,0xf5,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-11110101-01010101-01010101
