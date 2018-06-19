// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1w    {z31.d}, p7, [sp, z31.d, uxtw]  // 11100101-00011111-10011111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x1f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00011111-10011111-11111111
ST1W    {Z31.D}, P7, [SP, Z31.D, UXTW]  // 11100101-00011111-10011111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x1f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00011111-10011111-11111111
st1w    {z21.s}, p5, [x10, z21.s, sxtw]  // 11100101-01010101-11010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, sxtw] // encoding: [0x55,0xd5,0x55,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01010101-11010101-01010101
ST1W    {Z21.S}, P5, [X10, Z21.S, SXTW]  // 11100101-01010101-11010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, sxtw] // encoding: [0x55,0xd5,0x55,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01010101-11010101-01010101
st1w    {z21.s}, p5, [x10, #5, mul vl]  // 11100101-01000101-11110101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x45,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000101-11110101-01010101
ST1W    {Z21.S}, P5, [X10, #5, MUL VL]  // 11100101-01000101-11110101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x45,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000101-11110101-01010101
st1w    {z31.d}, p7, [sp, z31.d, sxtw]  // 11100101-00011111-11011111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x1f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00011111-11011111-11111111
ST1W    {Z31.D}, P7, [SP, Z31.D, SXTW]  // 11100101-00011111-11011111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x1f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00011111-11011111-11111111
st1w    {z21.s}, p5, [z10.s, #84]  // 11100101-01110101-10110101-01010101
// CHECK: st1w    {z21.s}, p5, [z10.s, #84] // encoding: [0x55,0xb5,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-10110101-01010101
ST1W    {Z21.S}, P5, [Z10.S, #84]  // 11100101-01110101-10110101-01010101
// CHECK: st1w    {z21.s}, p5, [z10.s, #84] // encoding: [0x55,0xb5,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-10110101-01010101
st1w    {z21.s}, p5, [x10, z21.s, uxtw]  // 11100101-01010101-10010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, uxtw] // encoding: [0x55,0x95,0x55,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01010101-10010101-01010101
ST1W    {Z21.S}, P5, [X10, Z21.S, UXTW]  // 11100101-01010101-10010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, uxtw] // encoding: [0x55,0x95,0x55,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01010101-10010101-01010101
st1w    {z0.d}, p0, [x0, z0.d, sxtw #2]  // 11100101-00100000-11000000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d, sxtw #2] // encoding: [0x00,0xc0,0x20,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00100000-11000000-00000000
ST1W    {Z0.D}, P0, [X0, Z0.D, SXTW #2]  // 11100101-00100000-11000000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d, sxtw #2] // encoding: [0x00,0xc0,0x20,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00100000-11000000-00000000
st1w    {z0.d}, p0, [x0, z0.d, uxtw]  // 11100101-00000000-10000000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x00,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00000000-10000000-00000000
ST1W    {Z0.D}, P0, [X0, Z0.D, UXTW]  // 11100101-00000000-10000000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x00,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00000000-10000000-00000000
st1w    {z21.d}, p5, [x10, z21.d]  // 11100101-00010101-10110101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d] // encoding: [0x55,0xb5,0x15,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00010101-10110101-01010101
ST1W    {Z21.D}, P5, [X10, Z21.D]  // 11100101-00010101-10110101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d] // encoding: [0x55,0xb5,0x15,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00010101-10110101-01010101
st1w    {z31.d}, p7, [sp, z31.d, lsl #2]  // 11100101-00111111-10111111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d, lsl #2] // encoding: [0xff,0xbf,0x3f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00111111-10111111-11111111
ST1W    {Z31.D}, P7, [SP, Z31.D, LSL #2]  // 11100101-00111111-10111111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d, lsl #2] // encoding: [0xff,0xbf,0x3f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00111111-10111111-11111111
st1w    {z0.s}, p0, [x0, z0.s, sxtw #2]  // 11100101-01100000-11000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, sxtw #2] // encoding: [0x00,0xc0,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-11000000-00000000
ST1W    {Z0.S}, P0, [X0, Z0.S, SXTW #2]  // 11100101-01100000-11000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, sxtw #2] // encoding: [0x00,0xc0,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-11000000-00000000
st1w    {z31.d}, p7, [sp, z31.d]  // 11100101-00011111-10111111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d] // encoding: [0xff,0xbf,0x1f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00011111-10111111-11111111
ST1W    {Z31.D}, P7, [SP, Z31.D]  // 11100101-00011111-10111111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d] // encoding: [0xff,0xbf,0x1f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00011111-10111111-11111111
st1w    {z23.s}, p3, [z13.s, #32]  // 11100101-01101000-10101101-10110111
// CHECK: st1w    {z23.s}, p3, [z13.s, #32] // encoding: [0xb7,0xad,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-10101101-10110111
ST1W    {Z23.S}, P3, [Z13.S, #32]  // 11100101-01101000-10101101-10110111
// CHECK: st1w    {z23.s}, p3, [z13.s, #32] // encoding: [0xb7,0xad,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-10101101-10110111
st1w    {z23.d}, p3, [z13.d, #32]  // 11100101-01001000-10101101-10110111
// CHECK: st1w    {z23.d}, p3, [z13.d, #32] // encoding: [0xb7,0xad,0x48,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001000-10101101-10110111
ST1W    {Z23.D}, P3, [Z13.D, #32]  // 11100101-01001000-10101101-10110111
// CHECK: st1w    {z23.d}, p3, [z13.d, #32] // encoding: [0xb7,0xad,0x48,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001000-10101101-10110111
st1w    {z0.s}, p0, [x0, z0.s, uxtw]  // 11100101-01000000-10000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x80,0x40,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000000-10000000-00000000
ST1W    {Z0.S}, P0, [X0, Z0.S, UXTW]  // 11100101-01000000-10000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x80,0x40,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000000-10000000-00000000
st1w    {z0.d}, p0, [x0, z0.d, lsl #2]  // 11100101-00100000-10100000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d, lsl #2] // encoding: [0x00,0xa0,0x20,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00100000-10100000-00000000
ST1W    {Z0.D}, P0, [X0, Z0.D, LSL #2]  // 11100101-00100000-10100000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d, lsl #2] // encoding: [0x00,0xa0,0x20,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00100000-10100000-00000000
st1w    {z0.s}, p0, [x0, z0.s, uxtw #2]  // 11100101-01100000-10000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, uxtw #2] // encoding: [0x00,0x80,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-10000000-00000000
ST1W    {Z0.S}, P0, [X0, Z0.S, UXTW #2]  // 11100101-01100000-10000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, uxtw #2] // encoding: [0x00,0x80,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-10000000-00000000
st1w    {z23.s}, p3, [x13, x8, lsl #2]  // 11100101-01001000-01001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x4d,0x48,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001000-01001101-10110111
ST1W    {Z23.S}, P3, [X13, X8, LSL #2]  // 11100101-01001000-01001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x4d,0x48,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001000-01001101-10110111
st1w    {z31.s}, p7, [sp, z31.s, uxtw]  // 11100101-01011111-10011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, uxtw] // encoding: [0xff,0x9f,0x5f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01011111-10011111-11111111
ST1W    {Z31.S}, P7, [SP, Z31.S, UXTW]  // 11100101-01011111-10011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, uxtw] // encoding: [0xff,0x9f,0x5f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01011111-10011111-11111111
st1w    {z23.d}, p3, [x13, z8.d, sxtw]  // 11100101-00001000-11001101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x08,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00001000-11001101-10110111
ST1W    {Z23.D}, P3, [X13, Z8.D, SXTW]  // 11100101-00001000-11001101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x08,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00001000-11001101-10110111
st1w    {z0.d}, p0, [x0, z0.d, uxtw #2]  // 11100101-00100000-10000000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d, uxtw #2] // encoding: [0x00,0x80,0x20,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00100000-10000000-00000000
ST1W    {Z0.D}, P0, [X0, Z0.D, UXTW #2]  // 11100101-00100000-10000000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d, uxtw #2] // encoding: [0x00,0x80,0x20,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00100000-10000000-00000000
st1w    {z0.s}, p0, [x0, z0.s, sxtw]  // 11100101-01000000-11000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, sxtw] // encoding: [0x00,0xc0,0x40,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000000-11000000-00000000
ST1W    {Z0.S}, P0, [X0, Z0.S, SXTW]  // 11100101-01000000-11000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, z0.s, sxtw] // encoding: [0x00,0xc0,0x40,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000000-11000000-00000000
st1w    {z21.d}, p5, [x10, z21.d, sxtw #2]  // 11100101-00110101-11010101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d, sxtw #2] // encoding: [0x55,0xd5,0x35,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110101-11010101-01010101
ST1W    {Z21.D}, P5, [X10, Z21.D, SXTW #2]  // 11100101-00110101-11010101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d, sxtw #2] // encoding: [0x55,0xd5,0x35,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110101-11010101-01010101
st1w    {z23.d}, p3, [x13, x8, lsl #2]  // 11100101-01101000-01001101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x4d,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-01001101-10110111
ST1W    {Z23.D}, P3, [X13, X8, LSL #2]  // 11100101-01101000-01001101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x4d,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-01001101-10110111
st1w    {z21.d}, p5, [x10, x21, lsl #2]  // 11100101-01110101-01010101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x55,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-01010101-01010101
ST1W    {Z21.D}, P5, [X10, X21, LSL #2]  // 11100101-01110101-01010101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x55,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-01010101-01010101
st1w    {z0.s}, p0, [z0.s]  // 11100101-01100000-10100000-00000000
// CHECK: st1w    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-10100000-00000000
ST1W    {Z0.S}, P0, [Z0.S]  // 11100101-01100000-10100000-00000000
// CHECK: st1w    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-10100000-00000000
st1w    {z21.d}, p5, [z10.d, #84]  // 11100101-01010101-10110101-01010101
// CHECK: st1w    {z21.d}, p5, [z10.d, #84] // encoding: [0x55,0xb5,0x55,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01010101-10110101-01010101
ST1W    {Z21.D}, P5, [Z10.D, #84]  // 11100101-01010101-10110101-01010101
// CHECK: st1w    {z21.d}, p5, [z10.d, #84] // encoding: [0x55,0xb5,0x55,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01010101-10110101-01010101
st1w    {z23.s}, p3, [x13, z8.s, sxtw #2]  // 11100101-01101000-11001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, sxtw #2] // encoding: [0xb7,0xcd,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-11001101-10110111
ST1W    {Z23.S}, P3, [X13, Z8.S, SXTW #2]  // 11100101-01101000-11001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, sxtw #2] // encoding: [0xb7,0xcd,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-11001101-10110111
st1w    {z31.d}, p7, [z31.d, #124]  // 11100101-01011111-10111111-11111111
// CHECK: st1w    {z31.d}, p7, [z31.d, #124] // encoding: [0xff,0xbf,0x5f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01011111-10111111-11111111
ST1W    {Z31.D}, P7, [Z31.D, #124]  // 11100101-01011111-10111111-11111111
// CHECK: st1w    {z31.d}, p7, [z31.d, #124] // encoding: [0xff,0xbf,0x5f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01011111-10111111-11111111
st1w    {z31.s}, p7, [sp, z31.s, sxtw #2]  // 11100101-01111111-11011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, sxtw #2] // encoding: [0xff,0xdf,0x7f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01111111-11011111-11111111
ST1W    {Z31.S}, P7, [SP, Z31.S, SXTW #2]  // 11100101-01111111-11011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, sxtw #2] // encoding: [0xff,0xdf,0x7f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01111111-11011111-11111111
st1w    {z5.s}, p3, [x17, x16, lsl #2]  // 11100101-01010000-01001110-00100101
// CHECK: st1w    {z5.s}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x4e,0x50,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01010000-01001110-00100101
ST1W    {Z5.S}, P3, [X17, X16, LSL #2]  // 11100101-01010000-01001110-00100101
// CHECK: st1w    {z5.s}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x4e,0x50,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01010000-01001110-00100101
st1w    {z31.d}, p7, [sp, z31.d, uxtw #2]  // 11100101-00111111-10011111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d, uxtw #2] // encoding: [0xff,0x9f,0x3f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00111111-10011111-11111111
ST1W    {Z31.D}, P7, [SP, Z31.D, UXTW #2]  // 11100101-00111111-10011111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d, uxtw #2] // encoding: [0xff,0x9f,0x3f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00111111-10011111-11111111
st1w    {z21.s}, p5, [x10, x21, lsl #2]  // 11100101-01010101-01010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x55,0x55,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01010101-01010101-01010101
ST1W    {Z21.S}, P5, [X10, X21, LSL #2]  // 11100101-01010101-01010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x55,0x55,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01010101-01010101-01010101
st1w    {z23.s}, p3, [x13, z8.s, uxtw]  // 11100101-01001000-10001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, uxtw] // encoding: [0xb7,0x8d,0x48,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001000-10001101-10110111
ST1W    {Z23.S}, P3, [X13, Z8.S, UXTW]  // 11100101-01001000-10001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, uxtw] // encoding: [0xb7,0x8d,0x48,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001000-10001101-10110111
st1w    {z31.s}, p7, [sp, #-1, mul vl]  // 11100101-01001111-11111111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x4f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001111-11111111-11111111
ST1W    {Z31.S}, P7, [SP, #-1, MUL VL]  // 11100101-01001111-11111111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x4f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001111-11111111-11111111
st1w    {z23.d}, p3, [x13, #-8, mul vl]  // 11100101-01101000-11101101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-11101101-10110111
ST1W    {Z23.D}, P3, [X13, #-8, MUL VL]  // 11100101-01101000-11101101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-11101101-10110111
st1w    {z0.d}, p0, [x0, z0.d]  // 11100101-00000000-10100000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d] // encoding: [0x00,0xa0,0x00,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00000000-10100000-00000000
ST1W    {Z0.D}, P0, [X0, Z0.D]  // 11100101-00000000-10100000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d] // encoding: [0x00,0xa0,0x00,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00000000-10100000-00000000
st1w    {z31.s}, p7, [sp, z31.s, uxtw #2]  // 11100101-01111111-10011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, uxtw #2] // encoding: [0xff,0x9f,0x7f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01111111-10011111-11111111
ST1W    {Z31.S}, P7, [SP, Z31.S, UXTW #2]  // 11100101-01111111-10011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, uxtw #2] // encoding: [0xff,0x9f,0x7f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01111111-10011111-11111111
st1w    {z21.s}, p5, [x10, z21.s, sxtw #2]  // 11100101-01110101-11010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, sxtw #2] // encoding: [0x55,0xd5,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-11010101-01010101
ST1W    {Z21.S}, P5, [X10, Z21.S, SXTW #2]  // 11100101-01110101-11010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, sxtw #2] // encoding: [0x55,0xd5,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-11010101-01010101
st1w    {z23.s}, p3, [x13, z8.s, uxtw #2]  // 11100101-01101000-10001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, uxtw #2] // encoding: [0xb7,0x8d,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-10001101-10110111
ST1W    {Z23.S}, P3, [X13, Z8.S, UXTW #2]  // 11100101-01101000-10001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, uxtw #2] // encoding: [0xb7,0x8d,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-10001101-10110111
st1w    {z23.d}, p3, [x13, z8.d]  // 11100101-00001000-10101101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d] // encoding: [0xb7,0xad,0x08,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00001000-10101101-10110111
ST1W    {Z23.D}, P3, [X13, Z8.D]  // 11100101-00001000-10101101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d] // encoding: [0xb7,0xad,0x08,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00001000-10101101-10110111
st1w    {z31.s}, p7, [sp, z31.s, sxtw]  // 11100101-01011111-11011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, sxtw] // encoding: [0xff,0xdf,0x5f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01011111-11011111-11111111
ST1W    {Z31.S}, P7, [SP, Z31.S, SXTW]  // 11100101-01011111-11011111-11111111
// CHECK: st1w    {z31.s}, p7, [sp, z31.s, sxtw] // encoding: [0xff,0xdf,0x5f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01011111-11011111-11111111
st1w    {z21.d}, p5, [x10, #5, mul vl]  // 11100101-01100101-11110101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x65,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100101-11110101-01010101
ST1W    {Z21.D}, P5, [X10, #5, MUL VL]  // 11100101-01100101-11110101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x65,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100101-11110101-01010101
st1w    {z0.s}, p0, [x0, x0, lsl #2]  // 11100101-01000000-01000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x40,0x40,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000000-01000000-00000000
ST1W    {Z0.S}, P0, [X0, X0, LSL #2]  // 11100101-01000000-01000000-00000000
// CHECK: st1w    {z0.s}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x40,0x40,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000000-01000000-00000000
st1w    {z23.d}, p3, [x13, z8.d, uxtw]  // 11100101-00001000-10001101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x08,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00001000-10001101-10110111
ST1W    {Z23.D}, P3, [X13, Z8.D, UXTW]  // 11100101-00001000-10001101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x08,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00001000-10001101-10110111
st1w    {z31.d}, p7, [sp, z31.d, sxtw #2]  // 11100101-00111111-11011111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d, sxtw #2] // encoding: [0xff,0xdf,0x3f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00111111-11011111-11111111
ST1W    {Z31.D}, P7, [SP, Z31.D, SXTW #2]  // 11100101-00111111-11011111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, z31.d, sxtw #2] // encoding: [0xff,0xdf,0x3f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00111111-11011111-11111111
st1w    {z23.s}, p3, [x13, #-8, mul vl]  // 11100101-01001000-11101101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x48,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001000-11101101-10110111
ST1W    {Z23.S}, P3, [X13, #-8, MUL VL]  // 11100101-01001000-11101101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x48,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001000-11101101-10110111
st1w    {z21.d}, p5, [x10, z21.d, uxtw #2]  // 11100101-00110101-10010101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d, uxtw #2] // encoding: [0x55,0x95,0x35,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110101-10010101-01010101
ST1W    {Z21.D}, P5, [X10, Z21.D, UXTW #2]  // 11100101-00110101-10010101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d, uxtw #2] // encoding: [0x55,0x95,0x35,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110101-10010101-01010101
st1w    {z21.d}, p5, [x10, z21.d, uxtw]  // 11100101-00010101-10010101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x15,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00010101-10010101-01010101
ST1W    {Z21.D}, P5, [X10, Z21.D, UXTW]  // 11100101-00010101-10010101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x15,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00010101-10010101-01010101
st1w    {z21.d}, p5, [x10, z21.d, sxtw]  // 11100101-00010101-11010101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x15,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00010101-11010101-01010101
ST1W    {Z21.D}, P5, [X10, Z21.D, SXTW]  // 11100101-00010101-11010101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x15,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00010101-11010101-01010101
st1w    {z23.d}, p3, [x13, z8.d, uxtw #2]  // 11100101-00101000-10001101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d, uxtw #2] // encoding: [0xb7,0x8d,0x28,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00101000-10001101-10110111
ST1W    {Z23.D}, P3, [X13, Z8.D, UXTW #2]  // 11100101-00101000-10001101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d, uxtw #2] // encoding: [0xb7,0x8d,0x28,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00101000-10001101-10110111
st1w    {z21.s}, p5, [x10, z21.s, uxtw #2]  // 11100101-01110101-10010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, uxtw #2] // encoding: [0x55,0x95,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-10010101-01010101
ST1W    {Z21.S}, P5, [X10, Z21.S, UXTW #2]  // 11100101-01110101-10010101-01010101
// CHECK: st1w    {z21.s}, p5, [x10, z21.s, uxtw #2] // encoding: [0x55,0x95,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-10010101-01010101
st1w    {z23.d}, p3, [x13, z8.d, lsl #2]  // 11100101-00101000-10101101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d, lsl #2] // encoding: [0xb7,0xad,0x28,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00101000-10101101-10110111
ST1W    {Z23.D}, P3, [X13, Z8.D, LSL #2]  // 11100101-00101000-10101101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d, lsl #2] // encoding: [0xb7,0xad,0x28,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00101000-10101101-10110111
st1w    {z31.s}, p7, [z31.s, #124]  // 11100101-01111111-10111111-11111111
// CHECK: st1w    {z31.s}, p7, [z31.s, #124] // encoding: [0xff,0xbf,0x7f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01111111-10111111-11111111
ST1W    {Z31.S}, P7, [Z31.S, #124]  // 11100101-01111111-10111111-11111111
// CHECK: st1w    {z31.s}, p7, [z31.s, #124] // encoding: [0xff,0xbf,0x7f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01111111-10111111-11111111
st1w    {z21.d}, p5, [x10, z21.d, lsl #2]  // 11100101-00110101-10110101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d, lsl #2] // encoding: [0x55,0xb5,0x35,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110101-10110101-01010101
ST1W    {Z21.D}, P5, [X10, Z21.D, LSL #2]  // 11100101-00110101-10110101-01010101
// CHECK: st1w    {z21.d}, p5, [x10, z21.d, lsl #2] // encoding: [0x55,0xb5,0x35,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110101-10110101-01010101
st1w    {z0.d}, p0, [z0.d]  // 11100101-01000000-10100000-00000000
// CHECK: st1w    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0x40,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000000-10100000-00000000
ST1W    {Z0.D}, P0, [Z0.D]  // 11100101-01000000-10100000-00000000
// CHECK: st1w    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0x40,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000000-10100000-00000000
st1w    {z0.d}, p0, [x0]  // 11100101-01100000-11100000-00000000
// CHECK: st1w    {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-11100000-00000000
ST1W    {Z0.D}, P0, [X0]  // 11100101-01100000-11100000-00000000
// CHECK: st1w    {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-11100000-00000000
st1w    {z0.d}, p0, [x0, z0.d, sxtw]  // 11100101-00000000-11000000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x00,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00000000-11000000-00000000
ST1W    {Z0.D}, P0, [X0, Z0.D, SXTW]  // 11100101-00000000-11000000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x00,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00000000-11000000-00000000
st1w    {z5.d}, p3, [x17, x16, lsl #2]  // 11100101-01110000-01001110-00100101
// CHECK: st1w    {z5.d}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x4e,0x70,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110000-01001110-00100101
ST1W    {Z5.D}, P3, [X17, X16, LSL #2]  // 11100101-01110000-01001110-00100101
// CHECK: st1w    {z5.d}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x4e,0x70,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110000-01001110-00100101
st1w    {z23.d}, p3, [x13, z8.d, sxtw #2]  // 11100101-00101000-11001101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d, sxtw #2] // encoding: [0xb7,0xcd,0x28,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00101000-11001101-10110111
ST1W    {Z23.D}, P3, [X13, Z8.D, SXTW #2]  // 11100101-00101000-11001101-10110111
// CHECK: st1w    {z23.d}, p3, [x13, z8.d, sxtw #2] // encoding: [0xb7,0xcd,0x28,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00101000-11001101-10110111
st1w    {z0.d}, p0, [x0, x0, lsl #2]  // 11100101-01100000-01000000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x40,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-01000000-00000000
ST1W    {Z0.D}, P0, [X0, X0, LSL #2]  // 11100101-01100000-01000000-00000000
// CHECK: st1w    {z0.d}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x40,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-01000000-00000000
st1w    {z23.s}, p3, [x13, z8.s, sxtw]  // 11100101-01001000-11001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, sxtw] // encoding: [0xb7,0xcd,0x48,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001000-11001101-10110111
ST1W    {Z23.S}, P3, [X13, Z8.S, SXTW]  // 11100101-01001000-11001101-10110111
// CHECK: st1w    {z23.s}, p3, [x13, z8.s, sxtw] // encoding: [0xb7,0xcd,0x48,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01001000-11001101-10110111
st1w    {z0.s}, p0, [x0]  // 11100101-01000000-11100000-00000000
// CHECK: st1w    {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0x40,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000000-11100000-00000000
ST1W    {Z0.S}, P0, [X0]  // 11100101-01000000-11100000-00000000
// CHECK: st1w    {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0x40,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01000000-11100000-00000000
st1w    {z31.d}, p7, [sp, #-1, mul vl]  // 11100101-01101111-11111111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x6f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101111-11111111-11111111
ST1W    {Z31.D}, P7, [SP, #-1, MUL VL]  // 11100101-01101111-11111111-11111111
// CHECK: st1w    {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x6f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101111-11111111-11111111
