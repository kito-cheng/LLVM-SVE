// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1d    {z31.d}, p7/z, [sp, z31.d]  // 11000101-11011111-11011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xdf,0xdf,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11011111-11011111-11111111
LD1D    {Z31.D}, P7/Z, [SP, Z31.D]  // 11000101-11011111-11011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xdf,0xdf,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11011111-11011111-11111111
ld1d    {z0.d}, p0/z, [x0, x0, lsl #3]  // 10100101-11100000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0x40,0xe0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11100000-01000000-00000000
LD1D    {Z0.D}, P0/Z, [X0, X0, LSL #3]  // 10100101-11100000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0x40,0xe0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11100000-01000000-00000000
ld1d    {z5.d}, p3/z, [x17, x16, lsl #3]  // 10100101-11110000-01001110-00100101
// CHECK: ld1d    {z5.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0x4e,0xf0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11110000-01001110-00100101
LD1D    {Z5.D}, P3/Z, [X17, X16, LSL #3]  // 10100101-11110000-01001110-00100101
// CHECK: ld1d    {z5.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0x4e,0xf0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11110000-01001110-00100101
ld1d    {z21.d}, p5/z, [z10.d, #168]  // 11000101-10110101-11010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [z10.d, #168] // encoding: [0x55,0xd5,0xb5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10110101-11010101-01010101
LD1D    {Z21.D}, P5/Z, [Z10.D, #168]  // 11000101-10110101-11010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [z10.d, #168] // encoding: [0x55,0xd5,0xb5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10110101-11010101-01010101
ld1d    {z0.d}, p0/z, [z0.d]  // 11000101-10100000-11000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xc0,0xa0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10100000-11000000-00000000
LD1D    {Z0.D}, P0/Z, [Z0.D]  // 11000101-10100000-11000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xc0,0xa0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10100000-11000000-00000000
ld1d    {z31.d}, p7/z, [sp, z31.d, sxtw]  // 11000101-11011111-01011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, sxtw] // encoding: [0xff,0x5f,0xdf,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11011111-01011111-11111111
LD1D    {Z31.D}, P7/Z, [SP, Z31.D, SXTW]  // 11000101-11011111-01011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, sxtw] // encoding: [0xff,0x5f,0xdf,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11011111-01011111-11111111
ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw]  // 11000101-10011111-01011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x5f,0x9f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10011111-01011111-11111111
LD1D    {Z31.D}, P7/Z, [SP, Z31.D, UXTW]  // 11000101-10011111-01011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x5f,0x9f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10011111-01011111-11111111
ld1d    {z21.d}, p5/z, [x10, #5, mul vl]  // 10100101-11100101-10110101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xe5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11100101-10110101-01010101
LD1D    {Z21.D}, P5/Z, [X10, #5, MUL VL]  // 10100101-11100101-10110101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xe5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11100101-10110101-01010101
ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw #3]  // 11000101-10110101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw #3] // encoding: [0x55,0x55,0xb5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10110101-01010101-01010101
LD1D    {Z21.D}, P5/Z, [X10, Z21.D, UXTW #3]  // 11000101-10110101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw #3] // encoding: [0x55,0x55,0xb5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10110101-01010101-01010101
ld1d    {z23.d}, p3/z, [x13, z8.d, sxtw #3]  // 11000101-11101000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, sxtw #3] // encoding: [0xb7,0x4d,0xe8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11101000-01001101-10110111
LD1D    {Z23.D}, P3/Z, [X13, Z8.D, SXTW #3]  // 11000101-11101000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, sxtw #3] // encoding: [0xb7,0x4d,0xe8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11101000-01001101-10110111
ld1d    {z0.d}, p0/z, [x0]  // 10100101-11100000-10100000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0xe0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11100000-10100000-00000000
LD1D    {Z0.D}, P0/Z, [X0]  // 10100101-11100000-10100000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0xe0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11100000-10100000-00000000
ld1d    {z21.d}, p5/z, [x10, z21.d, sxtw #3]  // 11000101-11110101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, sxtw #3] // encoding: [0x55,0x55,0xf5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11110101-01010101-01010101
LD1D    {Z21.D}, P5/Z, [X10, Z21.D, SXTW #3]  // 11000101-11110101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, sxtw #3] // encoding: [0x55,0x55,0xf5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11110101-01010101-01010101
ld1d    {z31.d}, p7/z, [sp, z31.d, sxtw #3]  // 11000101-11111111-01011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, sxtw #3] // encoding: [0xff,0x5f,0xff,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11111111-01011111-11111111
LD1D    {Z31.D}, P7/Z, [SP, Z31.D, SXTW #3]  // 11000101-11111111-01011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, sxtw #3] // encoding: [0xff,0x5f,0xff,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11111111-01011111-11111111
ld1d    {z0.d}, p0/z, [x0, z0.d, sxtw]  // 11000101-11000000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, sxtw] // encoding: [0x00,0x40,0xc0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11000000-01000000-00000000
LD1D    {Z0.D}, P0/Z, [X0, Z0.D, SXTW]  // 11000101-11000000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, sxtw] // encoding: [0x00,0x40,0xc0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11000000-01000000-00000000
ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw]  // 11000101-10001000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x4d,0x88,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10001000-01001101-10110111
LD1D    {Z23.D}, P3/Z, [X13, Z8.D, UXTW]  // 11000101-10001000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x4d,0x88,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10001000-01001101-10110111
ld1d    {z21.d}, p5/z, [x10, z21.d]  // 11000101-11010101-11010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xd5,0xd5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11010101-11010101-01010101
LD1D    {Z21.D}, P5/Z, [X10, Z21.D]  // 11000101-11010101-11010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xd5,0xd5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11010101-11010101-01010101
ld1d    {z0.d}, p0/z, [x0, z0.d]  // 11000101-11000000-11000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xc0,0xc0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11000000-11000000-00000000
LD1D    {Z0.D}, P0/Z, [X0, Z0.D]  // 11000101-11000000-11000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xc0,0xc0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11000000-11000000-00000000
ld1d    {z31.d}, p7/z, [sp, #-1, mul vl]  // 10100101-11101111-10111111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xef,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11101111-10111111-11111111
LD1D    {Z31.D}, P7/Z, [SP, #-1, MUL VL]  // 10100101-11101111-10111111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xef,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11101111-10111111-11111111
ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw #3]  // 11000101-10111111-01011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw #3] // encoding: [0xff,0x5f,0xbf,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10111111-01011111-11111111
LD1D    {Z31.D}, P7/Z, [SP, Z31.D, UXTW #3]  // 11000101-10111111-01011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw #3] // encoding: [0xff,0x5f,0xbf,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10111111-01011111-11111111
ld1d    {z31.d}, p7/z, [z31.d, #248]  // 11000101-10111111-11011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [z31.d, #248] // encoding: [0xff,0xdf,0xbf,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10111111-11011111-11111111
LD1D    {Z31.D}, P7/Z, [Z31.D, #248]  // 11000101-10111111-11011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [z31.d, #248] // encoding: [0xff,0xdf,0xbf,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10111111-11011111-11111111
ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw]  // 11000101-10000000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x40,0x80,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10000000-01000000-00000000
LD1D    {Z0.D}, P0/Z, [X0, Z0.D, UXTW]  // 11000101-10000000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x40,0x80,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10000000-01000000-00000000
ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw]  // 11000101-10010101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x55,0x95,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10010101-01010101-01010101
LD1D    {Z21.D}, P5/Z, [X10, Z21.D, UXTW]  // 11000101-10010101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x55,0x95,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10010101-01010101-01010101
ld1d    {z23.d}, p3/z, [z13.d, #64]  // 11000101-10101000-11001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [z13.d, #64] // encoding: [0xb7,0xcd,0xa8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10101000-11001101-10110111
LD1D    {Z23.D}, P3/Z, [Z13.D, #64]  // 11000101-10101000-11001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [z13.d, #64] // encoding: [0xb7,0xcd,0xa8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10101000-11001101-10110111
ld1d    {z23.d}, p3/z, [x13, z8.d]  // 11000101-11001000-11001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xcd,0xc8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11001000-11001101-10110111
LD1D    {Z23.D}, P3/Z, [X13, Z8.D]  // 11000101-11001000-11001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xcd,0xc8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11001000-11001101-10110111
ld1d    {z23.d}, p3/z, [x13, z8.d, sxtw]  // 11000101-11001000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, sxtw] // encoding: [0xb7,0x4d,0xc8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11001000-01001101-10110111
LD1D    {Z23.D}, P3/Z, [X13, Z8.D, SXTW]  // 11000101-11001000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, sxtw] // encoding: [0xb7,0x4d,0xc8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11001000-01001101-10110111
ld1d    {z23.d}, p3/z, [x13, z8.d, lsl #3]  // 11000101-11101000-11001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, lsl #3] // encoding: [0xb7,0xcd,0xe8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11101000-11001101-10110111
LD1D    {Z23.D}, P3/Z, [X13, Z8.D, LSL #3]  // 11000101-11101000-11001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, lsl #3] // encoding: [0xb7,0xcd,0xe8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11101000-11001101-10110111
ld1d    {z0.d}, p0/z, [x0, z0.d, sxtw #3]  // 11000101-11100000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, sxtw #3] // encoding: [0x00,0x40,0xe0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11100000-01000000-00000000
LD1D    {Z0.D}, P0/Z, [X0, Z0.D, SXTW #3]  // 11000101-11100000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, sxtw #3] // encoding: [0x00,0x40,0xe0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11100000-01000000-00000000
ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw #3]  // 11000101-10101000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw #3] // encoding: [0xb7,0x4d,0xa8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10101000-01001101-10110111
LD1D    {Z23.D}, P3/Z, [X13, Z8.D, UXTW #3]  // 11000101-10101000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw #3] // encoding: [0xb7,0x4d,0xa8,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10101000-01001101-10110111
ld1d    {z23.d}, p3/z, [x13, #-8, mul vl]  // 10100101-11101000-10101101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xe8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11101000-10101101-10110111
LD1D    {Z23.D}, P3/Z, [X13, #-8, MUL VL]  // 10100101-11101000-10101101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xe8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11101000-10101101-10110111
ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw #3]  // 11000101-10100000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw #3] // encoding: [0x00,0x40,0xa0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10100000-01000000-00000000
LD1D    {Z0.D}, P0/Z, [X0, Z0.D, UXTW #3]  // 11000101-10100000-01000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw #3] // encoding: [0x00,0x40,0xa0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10100000-01000000-00000000
ld1d    {z23.d}, p3/z, [x13, x8, lsl #3]  // 10100101-11101000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0x4d,0xe8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11101000-01001101-10110111
LD1D    {Z23.D}, P3/Z, [X13, X8, LSL #3]  // 10100101-11101000-01001101-10110111
// CHECK: ld1d    {z23.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0x4d,0xe8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11101000-01001101-10110111
ld1d    {z0.d}, p0/z, [x0, z0.d, lsl #3]  // 11000101-11100000-11000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, lsl #3] // encoding: [0x00,0xc0,0xe0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11100000-11000000-00000000
LD1D    {Z0.D}, P0/Z, [X0, Z0.D, LSL #3]  // 11000101-11100000-11000000-00000000
// CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, lsl #3] // encoding: [0x00,0xc0,0xe0,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11100000-11000000-00000000
ld1d    {z21.d}, p5/z, [x10, z21.d, sxtw]  // 11000101-11010101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, sxtw] // encoding: [0x55,0x55,0xd5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11010101-01010101-01010101
LD1D    {Z21.D}, P5/Z, [X10, Z21.D, SXTW]  // 11000101-11010101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, sxtw] // encoding: [0x55,0x55,0xd5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11010101-01010101-01010101
ld1d    {z21.d}, p5/z, [x10, x21, lsl #3]  // 10100101-11110101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0x55,0xf5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11110101-01010101-01010101
LD1D    {Z21.D}, P5/Z, [X10, X21, LSL #3]  // 10100101-11110101-01010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0x55,0xf5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11110101-01010101-01010101
ld1d    {z31.d}, p7/z, [sp, z31.d, lsl #3]  // 11000101-11111111-11011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, lsl #3] // encoding: [0xff,0xdf,0xff,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11111111-11011111-11111111
LD1D    {Z31.D}, P7/Z, [SP, Z31.D, LSL #3]  // 11000101-11111111-11011111-11111111
// CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, lsl #3] // encoding: [0xff,0xdf,0xff,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11111111-11011111-11111111
ld1d    {z21.d}, p5/z, [x10, z21.d, lsl #3]  // 11000101-11110101-11010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, lsl #3] // encoding: [0x55,0xd5,0xf5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11110101-11010101-01010101
LD1D    {Z21.D}, P5/Z, [X10, Z21.D, LSL #3]  // 11000101-11110101-11010101-01010101
// CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, lsl #3] // encoding: [0x55,0xd5,0xf5,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-11110101-11010101-01010101
