// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1d    {z31.d}, p7, [z31.d, #248]  // 11100101-11011111-10111111-11111111
// CHECK: st1d    {z31.d}, p7, [z31.d, #248] // encoding: [0xff,0xbf,0xdf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11011111-10111111-11111111
ST1D    {Z31.D}, P7, [Z31.D, #248]  // 11100101-11011111-10111111-11111111
// CHECK: st1d    {z31.d}, p7, [z31.d, #248] // encoding: [0xff,0xbf,0xdf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11011111-10111111-11111111
st1d    {z21.d}, p5, [z10.d, #168]  // 11100101-11010101-10110101-01010101
// CHECK: st1d    {z21.d}, p5, [z10.d, #168] // encoding: [0x55,0xb5,0xd5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11010101-10110101-01010101
ST1D    {Z21.D}, P5, [Z10.D, #168]  // 11100101-11010101-10110101-01010101
// CHECK: st1d    {z21.d}, p5, [z10.d, #168] // encoding: [0x55,0xb5,0xd5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11010101-10110101-01010101
st1d    {z23.d}, p3, [x13, z8.d, lsl #3]  // 11100101-10101000-10101101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, lsl #3] // encoding: [0xb7,0xad,0xa8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10101000-10101101-10110111
ST1D    {Z23.D}, P3, [X13, Z8.D, LSL #3]  // 11100101-10101000-10101101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, lsl #3] // encoding: [0xb7,0xad,0xa8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10101000-10101101-10110111
st1d    {z31.d}, p7, [sp, z31.d, sxtw #3]  // 11100101-10111111-11011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, sxtw #3] // encoding: [0xff,0xdf,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-11011111-11111111
ST1D    {Z31.D}, P7, [SP, Z31.D, SXTW #3]  // 11100101-10111111-11011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, sxtw #3] // encoding: [0xff,0xdf,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-11011111-11111111
st1d    {z21.d}, p5, [x10, z21.d]  // 11100101-10010101-10110101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d] // encoding: [0x55,0xb5,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-10110101-01010101
ST1D    {Z21.D}, P5, [X10, Z21.D]  // 11100101-10010101-10110101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d] // encoding: [0x55,0xb5,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-10110101-01010101
st1d    {z21.d}, p5, [x10, x21, lsl #3]  // 11100101-11110101-01010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x55,0xf5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11110101-01010101-01010101
ST1D    {Z21.D}, P5, [X10, X21, LSL #3]  // 11100101-11110101-01010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x55,0xf5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11110101-01010101-01010101
st1d    {z23.d}, p3, [z13.d, #64]  // 11100101-11001000-10101101-10110111
// CHECK: st1d    {z23.d}, p3, [z13.d, #64] // encoding: [0xb7,0xad,0xc8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11001000-10101101-10110111
ST1D    {Z23.D}, P3, [Z13.D, #64]  // 11100101-11001000-10101101-10110111
// CHECK: st1d    {z23.d}, p3, [z13.d, #64] // encoding: [0xb7,0xad,0xc8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11001000-10101101-10110111
st1d    {z21.d}, p5, [x10, z21.d, sxtw #3]  // 11100101-10110101-11010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, sxtw #3] // encoding: [0x55,0xd5,0xb5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110101-11010101-01010101
ST1D    {Z21.D}, P5, [X10, Z21.D, SXTW #3]  // 11100101-10110101-11010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, sxtw #3] // encoding: [0x55,0xd5,0xb5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110101-11010101-01010101
st1d    {z31.d}, p7, [sp, z31.d, uxtw #3]  // 11100101-10111111-10011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, uxtw #3] // encoding: [0xff,0x9f,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-10011111-11111111
ST1D    {Z31.D}, P7, [SP, Z31.D, UXTW #3]  // 11100101-10111111-10011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, uxtw #3] // encoding: [0xff,0x9f,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-10011111-11111111
st1d    {z0.d}, p0, [x0, z0.d, sxtw]  // 11100101-10000000-11000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-11000000-00000000
ST1D    {Z0.D}, P0, [X0, Z0.D, SXTW]  // 11100101-10000000-11000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-11000000-00000000
st1d    {z21.d}, p5, [x10, z21.d, uxtw]  // 11100101-10010101-10010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-10010101-01010101
ST1D    {Z21.D}, P5, [X10, Z21.D, UXTW]  // 11100101-10010101-10010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-10010101-01010101
st1d    {z0.d}, p0, [x0, z0.d, sxtw #3]  // 11100101-10100000-11000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, sxtw #3] // encoding: [0x00,0xc0,0xa0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10100000-11000000-00000000
ST1D    {Z0.D}, P0, [X0, Z0.D, SXTW #3]  // 11100101-10100000-11000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, sxtw #3] // encoding: [0x00,0xc0,0xa0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10100000-11000000-00000000
st1d    {z21.d}, p5, [x10, z21.d, sxtw]  // 11100101-10010101-11010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-11010101-01010101
ST1D    {Z21.D}, P5, [X10, Z21.D, SXTW]  // 11100101-10010101-11010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-11010101-01010101
st1d    {z31.d}, p7, [sp, z31.d]  // 11100101-10011111-10111111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d] // encoding: [0xff,0xbf,0x9f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10011111-10111111-11111111
ST1D    {Z31.D}, P7, [SP, Z31.D]  // 11100101-10011111-10111111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d] // encoding: [0xff,0xbf,0x9f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10011111-10111111-11111111
st1d    {z31.d}, p7, [sp, z31.d, uxtw]  // 11100101-10011111-10011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x9f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10011111-10011111-11111111
ST1D    {Z31.D}, P7, [SP, Z31.D, UXTW]  // 11100101-10011111-10011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x9f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10011111-10011111-11111111
st1d    {z0.d}, p0, [z0.d]  // 11100101-11000000-10100000-00000000
// CHECK: st1d    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0xc0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11000000-10100000-00000000
ST1D    {Z0.D}, P0, [Z0.D]  // 11100101-11000000-10100000-00000000
// CHECK: st1d    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0xc0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11000000-10100000-00000000
st1d    {z21.d}, p5, [x10, #5, mul vl]  // 11100101-11100101-11110101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xe5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11100101-11110101-01010101
ST1D    {Z21.D}, P5, [X10, #5, MUL VL]  // 11100101-11100101-11110101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xe5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11100101-11110101-01010101
st1d    {z23.d}, p3, [x13, z8.d, uxtw]  // 11100101-10001000-10001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-10001101-10110111
ST1D    {Z23.D}, P3, [X13, Z8.D, UXTW]  // 11100101-10001000-10001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-10001101-10110111
st1d    {z0.d}, p0, [x0, z0.d, uxtw]  // 11100101-10000000-10000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-10000000-00000000
ST1D    {Z0.D}, P0, [X0, Z0.D, UXTW]  // 11100101-10000000-10000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-10000000-00000000
st1d    {z0.d}, p0, [x0, x0, lsl #3]  // 11100101-11100000-01000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x40,0xe0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11100000-01000000-00000000
ST1D    {Z0.D}, P0, [X0, X0, LSL #3]  // 11100101-11100000-01000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x40,0xe0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11100000-01000000-00000000
st1d    {z23.d}, p3, [x13, z8.d, uxtw #3]  // 11100101-10101000-10001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, uxtw #3] // encoding: [0xb7,0x8d,0xa8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10101000-10001101-10110111
ST1D    {Z23.D}, P3, [X13, Z8.D, UXTW #3]  // 11100101-10101000-10001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, uxtw #3] // encoding: [0xb7,0x8d,0xa8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10101000-10001101-10110111
st1d    {z23.d}, p3, [x13, x8, lsl #3]  // 11100101-11101000-01001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x4d,0xe8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11101000-01001101-10110111
ST1D    {Z23.D}, P3, [X13, X8, LSL #3]  // 11100101-11101000-01001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x4d,0xe8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11101000-01001101-10110111
st1d    {z31.d}, p7, [sp, z31.d, lsl #3]  // 11100101-10111111-10111111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, lsl #3] // encoding: [0xff,0xbf,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-10111111-11111111
ST1D    {Z31.D}, P7, [SP, Z31.D, LSL #3]  // 11100101-10111111-10111111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, lsl #3] // encoding: [0xff,0xbf,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-10111111-11111111
st1d    {z31.d}, p7, [sp, z31.d, sxtw]  // 11100101-10011111-11011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x9f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10011111-11011111-11111111
ST1D    {Z31.D}, P7, [SP, Z31.D, SXTW]  // 11100101-10011111-11011111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x9f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10011111-11011111-11111111
st1d    {z5.d}, p3, [x17, x16, lsl #3]  // 11100101-11110000-01001110-00100101
// CHECK: st1d    {z5.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x4e,0xf0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11110000-01001110-00100101
ST1D    {Z5.D}, P3, [X17, X16, LSL #3]  // 11100101-11110000-01001110-00100101
// CHECK: st1d    {z5.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x4e,0xf0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11110000-01001110-00100101
st1d    {z23.d}, p3, [x13, z8.d, sxtw]  // 11100101-10001000-11001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-11001101-10110111
ST1D    {Z23.D}, P3, [X13, Z8.D, SXTW]  // 11100101-10001000-11001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-11001101-10110111
st1d    {z21.d}, p5, [x10, z21.d, lsl #3]  // 11100101-10110101-10110101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, lsl #3] // encoding: [0x55,0xb5,0xb5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110101-10110101-01010101
ST1D    {Z21.D}, P5, [X10, Z21.D, LSL #3]  // 11100101-10110101-10110101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, lsl #3] // encoding: [0x55,0xb5,0xb5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110101-10110101-01010101
st1d    {z23.d}, p3, [x13, z8.d]  // 11100101-10001000-10101101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d] // encoding: [0xb7,0xad,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-10101101-10110111
ST1D    {Z23.D}, P3, [X13, Z8.D]  // 11100101-10001000-10101101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d] // encoding: [0xb7,0xad,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-10101101-10110111
st1d    {z0.d}, p0, [x0, z0.d, uxtw #3]  // 11100101-10100000-10000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, uxtw #3] // encoding: [0x00,0x80,0xa0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10100000-10000000-00000000
ST1D    {Z0.D}, P0, [X0, Z0.D, UXTW #3]  // 11100101-10100000-10000000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, uxtw #3] // encoding: [0x00,0x80,0xa0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10100000-10000000-00000000
st1d    {z23.d}, p3, [x13, #-8, mul vl]  // 11100101-11101000-11101101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xe8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11101000-11101101-10110111
ST1D    {Z23.D}, P3, [X13, #-8, MUL VL]  // 11100101-11101000-11101101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xe8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11101000-11101101-10110111
st1d    {z0.d}, p0, [x0, z0.d, lsl #3]  // 11100101-10100000-10100000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, lsl #3] // encoding: [0x00,0xa0,0xa0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10100000-10100000-00000000
ST1D    {Z0.D}, P0, [X0, Z0.D, LSL #3]  // 11100101-10100000-10100000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d, lsl #3] // encoding: [0x00,0xa0,0xa0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10100000-10100000-00000000
st1d    {z0.d}, p0, [x0]  // 11100101-11100000-11100000-00000000
// CHECK: st1d    {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0xe0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11100000-11100000-00000000
ST1D    {Z0.D}, P0, [X0]  // 11100101-11100000-11100000-00000000
// CHECK: st1d    {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0xe0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11100000-11100000-00000000
st1d    {z23.d}, p3, [x13, z8.d, sxtw #3]  // 11100101-10101000-11001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, sxtw #3] // encoding: [0xb7,0xcd,0xa8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10101000-11001101-10110111
ST1D    {Z23.D}, P3, [X13, Z8.D, SXTW #3]  // 11100101-10101000-11001101-10110111
// CHECK: st1d    {z23.d}, p3, [x13, z8.d, sxtw #3] // encoding: [0xb7,0xcd,0xa8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10101000-11001101-10110111
st1d    {z0.d}, p0, [x0, z0.d]  // 11100101-10000000-10100000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d] // encoding: [0x00,0xa0,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-10100000-00000000
ST1D    {Z0.D}, P0, [X0, Z0.D]  // 11100101-10000000-10100000-00000000
// CHECK: st1d    {z0.d}, p0, [x0, z0.d] // encoding: [0x00,0xa0,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-10100000-00000000
st1d    {z21.d}, p5, [x10, z21.d, uxtw #3]  // 11100101-10110101-10010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, uxtw #3] // encoding: [0x55,0x95,0xb5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110101-10010101-01010101
ST1D    {Z21.D}, P5, [X10, Z21.D, UXTW #3]  // 11100101-10110101-10010101-01010101
// CHECK: st1d    {z21.d}, p5, [x10, z21.d, uxtw #3] // encoding: [0x55,0x95,0xb5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110101-10010101-01010101
st1d    {z31.d}, p7, [sp, #-1, mul vl]  // 11100101-11101111-11111111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xef,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11101111-11111111-11111111
ST1D    {Z31.D}, P7, [SP, #-1, MUL VL]  // 11100101-11101111-11111111-11111111
// CHECK: st1d    {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xef,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-11101111-11111111-11111111
