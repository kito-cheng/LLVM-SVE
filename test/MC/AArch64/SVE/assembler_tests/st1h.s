// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1h    {z23.d}, p3, [x13, z8.d, sxtw #1]  // 11100100-10101000-11001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, sxtw #1] // encoding: [0xb7,0xcd,0xa8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101000-11001101-10110111
ST1H    {Z23.D}, P3, [X13, Z8.D, SXTW #1]  // 11100100-10101000-11001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, sxtw #1] // encoding: [0xb7,0xcd,0xa8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101000-11001101-10110111
st1h    {z21.h}, p5, [x10, #5, mul vl]  // 11100100-10100101-11110101-01010101
// CHECK: st1h    {z21.h}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xa5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100101-11110101-01010101
ST1H    {Z21.H}, P5, [X10, #5, MUL VL]  // 11100100-10100101-11110101-01010101
// CHECK: st1h    {z21.h}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xa5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100101-11110101-01010101
st1h    {z31.s}, p7, [z31.s, #62]  // 11100100-11111111-10111111-11111111
// CHECK: st1h    {z31.s}, p7, [z31.s, #62] // encoding: [0xff,0xbf,0xff,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11111111-10111111-11111111
ST1H    {Z31.S}, P7, [Z31.S, #62]  // 11100100-11111111-10111111-11111111
// CHECK: st1h    {z31.s}, p7, [z31.s, #62] // encoding: [0xff,0xbf,0xff,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11111111-10111111-11111111
st1h    {z21.s}, p5, [x10, x21, lsl #1]  // 11100100-11010101-01010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xd5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11010101-01010101-01010101
ST1H    {Z21.S}, P5, [X10, X21, LSL #1]  // 11100100-11010101-01010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xd5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11010101-01010101-01010101
st1h    {z0.s}, p0, [x0, x0, lsl #1]  // 11100100-11000000-01000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xc0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000000-01000000-00000000
ST1H    {Z0.S}, P0, [X0, X0, LSL #1]  // 11100100-11000000-01000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xc0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000000-01000000-00000000
st1h    {z23.h}, p3, [x13, x8, lsl #1]  // 11100100-10101000-01001101-10110111
// CHECK: st1h    {z23.h}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xa8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101000-01001101-10110111
ST1H    {Z23.H}, P3, [X13, X8, LSL #1]  // 11100100-10101000-01001101-10110111
// CHECK: st1h    {z23.h}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xa8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101000-01001101-10110111
st1h    {z23.d}, p3, [x13, x8, lsl #1]  // 11100100-11101000-01001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-01001101-10110111
ST1H    {Z23.D}, P3, [X13, X8, LSL #1]  // 11100100-11101000-01001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-01001101-10110111
st1h    {z0.d}, p0, [x0, z0.d, lsl #1]  // 11100100-10100000-10100000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, lsl #1] // encoding: [0x00,0xa0,0xa0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100000-10100000-00000000
ST1H    {Z0.D}, P0, [X0, Z0.D, LSL #1]  // 11100100-10100000-10100000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, lsl #1] // encoding: [0x00,0xa0,0xa0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100000-10100000-00000000
st1h    {z31.d}, p7, [sp, z31.d, sxtw]  // 11100100-10011111-11011111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x9f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10011111-11011111-11111111
ST1H    {Z31.D}, P7, [SP, Z31.D, SXTW]  // 11100100-10011111-11011111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x9f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10011111-11011111-11111111
st1h    {z21.s}, p5, [z10.s, #42]  // 11100100-11110101-10110101-01010101
// CHECK: st1h    {z21.s}, p5, [z10.s, #42] // encoding: [0x55,0xb5,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-10110101-01010101
ST1H    {Z21.S}, P5, [Z10.S, #42]  // 11100100-11110101-10110101-01010101
// CHECK: st1h    {z21.s}, p5, [z10.s, #42] // encoding: [0x55,0xb5,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-10110101-01010101
st1h    {z0.d}, p0, [x0, z0.d, sxtw #1]  // 11100100-10100000-11000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, sxtw #1] // encoding: [0x00,0xc0,0xa0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100000-11000000-00000000
ST1H    {Z0.D}, P0, [X0, Z0.D, SXTW #1]  // 11100100-10100000-11000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, sxtw #1] // encoding: [0x00,0xc0,0xa0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100000-11000000-00000000
st1h    {z31.d}, p7, [sp, z31.d, uxtw #1]  // 11100100-10111111-10011111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, uxtw #1] // encoding: [0xff,0x9f,0xbf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10111111-10011111-11111111
ST1H    {Z31.D}, P7, [SP, Z31.D, UXTW #1]  // 11100100-10111111-10011111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, uxtw #1] // encoding: [0xff,0x9f,0xbf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10111111-10011111-11111111
st1h    {z23.d}, p3, [z13.d, #16]  // 11100100-11001000-10101101-10110111
// CHECK: st1h    {z23.d}, p3, [z13.d, #16] // encoding: [0xb7,0xad,0xc8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001000-10101101-10110111
ST1H    {Z23.D}, P3, [Z13.D, #16]  // 11100100-11001000-10101101-10110111
// CHECK: st1h    {z23.d}, p3, [z13.d, #16] // encoding: [0xb7,0xad,0xc8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001000-10101101-10110111
st1h    {z31.d}, p7, [sp, z31.d]  // 11100100-10011111-10111111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d] // encoding: [0xff,0xbf,0x9f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10011111-10111111-11111111
ST1H    {Z31.D}, P7, [SP, Z31.D]  // 11100100-10011111-10111111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d] // encoding: [0xff,0xbf,0x9f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10011111-10111111-11111111
st1h    {z0.d}, p0, [x0, z0.d, uxtw #1]  // 11100100-10100000-10000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, uxtw #1] // encoding: [0x00,0x80,0xa0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100000-10000000-00000000
ST1H    {Z0.D}, P0, [X0, Z0.D, UXTW #1]  // 11100100-10100000-10000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, uxtw #1] // encoding: [0x00,0x80,0xa0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100000-10000000-00000000
st1h    {z5.s}, p3, [x17, x16, lsl #1]  // 11100100-11010000-01001110-00100101
// CHECK: st1h    {z5.s}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xd0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11010000-01001110-00100101
ST1H    {Z5.S}, P3, [X17, X16, LSL #1]  // 11100100-11010000-01001110-00100101
// CHECK: st1h    {z5.s}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xd0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11010000-01001110-00100101
st1h    {z31.s}, p7, [sp, #-1, mul vl]  // 11100100-11001111-11111111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xcf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001111-11111111-11111111
ST1H    {Z31.S}, P7, [SP, #-1, MUL VL]  // 11100100-11001111-11111111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xcf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001111-11111111-11111111
st1h    {z21.h}, p5, [x10, x21, lsl #1]  // 11100100-10110101-01010101-01010101
// CHECK: st1h    {z21.h}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xb5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10110101-01010101-01010101
ST1H    {Z21.H}, P5, [X10, X21, LSL #1]  // 11100100-10110101-01010101-01010101
// CHECK: st1h    {z21.h}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xb5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10110101-01010101-01010101
st1h    {z0.h}, p0, [x0, x0, lsl #1]  // 11100100-10100000-01000000-00000000
// CHECK: st1h    {z0.h}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xa0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100000-01000000-00000000
ST1H    {Z0.H}, P0, [X0, X0, LSL #1]  // 11100100-10100000-01000000-00000000
// CHECK: st1h    {z0.h}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xa0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100000-01000000-00000000
st1h    {z21.s}, p5, [x10, z21.s, sxtw #1]  // 11100100-11110101-11010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, z21.s, sxtw #1] // encoding: [0x55,0xd5,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-11010101-01010101
ST1H    {Z21.S}, P5, [X10, Z21.S, SXTW #1]  // 11100100-11110101-11010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, z21.s, sxtw #1] // encoding: [0x55,0xd5,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-11010101-01010101
st1h    {z23.d}, p3, [x13, #-8, mul vl]  // 11100100-11101000-11101101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-11101101-10110111
ST1H    {Z23.D}, P3, [X13, #-8, MUL VL]  // 11100100-11101000-11101101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-11101101-10110111
st1h    {z23.s}, p3, [z13.s, #16]  // 11100100-11101000-10101101-10110111
// CHECK: st1h    {z23.s}, p3, [z13.s, #16] // encoding: [0xb7,0xad,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-10101101-10110111
ST1H    {Z23.S}, P3, [Z13.S, #16]  // 11100100-11101000-10101101-10110111
// CHECK: st1h    {z23.s}, p3, [z13.s, #16] // encoding: [0xb7,0xad,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-10101101-10110111
st1h    {z23.d}, p3, [x13, z8.d, uxtw #1]  // 11100100-10101000-10001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, uxtw #1] // encoding: [0xb7,0x8d,0xa8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101000-10001101-10110111
ST1H    {Z23.D}, P3, [X13, Z8.D, UXTW #1]  // 11100100-10101000-10001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, uxtw #1] // encoding: [0xb7,0x8d,0xa8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101000-10001101-10110111
st1h    {z31.d}, p7, [sp, z31.d, uxtw]  // 11100100-10011111-10011111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x9f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10011111-10011111-11111111
ST1H    {Z31.D}, P7, [SP, Z31.D, UXTW]  // 11100100-10011111-10011111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x9f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10011111-10011111-11111111
st1h    {z23.h}, p3, [x13, #-8, mul vl]  // 11100100-10101000-11101101-10110111
// CHECK: st1h    {z23.h}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xa8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101000-11101101-10110111
ST1H    {Z23.H}, P3, [X13, #-8, MUL VL]  // 11100100-10101000-11101101-10110111
// CHECK: st1h    {z23.h}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xa8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101000-11101101-10110111
st1h    {z21.d}, p5, [x10, x21, lsl #1]  // 11100100-11110101-01010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-01010101-01010101
ST1H    {Z21.D}, P5, [X10, X21, LSL #1]  // 11100100-11110101-01010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-01010101-01010101
st1h    {z5.d}, p3, [x17, x16, lsl #1]  // 11100100-11110000-01001110-00100101
// CHECK: st1h    {z5.d}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xf0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110000-01001110-00100101
ST1H    {Z5.D}, P3, [X17, X16, LSL #1]  // 11100100-11110000-01001110-00100101
// CHECK: st1h    {z5.d}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xf0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110000-01001110-00100101
st1h    {z21.d}, p5, [x10, z21.d, sxtw #1]  // 11100100-10110101-11010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, sxtw #1] // encoding: [0x55,0xd5,0xb5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10110101-11010101-01010101
ST1H    {Z21.D}, P5, [X10, Z21.D, SXTW #1]  // 11100100-10110101-11010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, sxtw #1] // encoding: [0x55,0xd5,0xb5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10110101-11010101-01010101
st1h    {z0.d}, p0, [x0, z0.d]  // 11100100-10000000-10100000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d] // encoding: [0x00,0xa0,0x80,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10000000-10100000-00000000
ST1H    {Z0.D}, P0, [X0, Z0.D]  // 11100100-10000000-10100000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d] // encoding: [0x00,0xa0,0x80,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10000000-10100000-00000000
st1h    {z21.s}, p5, [x10, z21.s, uxtw]  // 11100100-11010101-10010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, z21.s, uxtw] // encoding: [0x55,0x95,0xd5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11010101-10010101-01010101
ST1H    {Z21.S}, P5, [X10, Z21.S, UXTW]  // 11100100-11010101-10010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, z21.s, uxtw] // encoding: [0x55,0x95,0xd5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11010101-10010101-01010101
st1h    {z23.s}, p3, [x13, x8, lsl #1]  // 11100100-11001000-01001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xc8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001000-01001101-10110111
ST1H    {Z23.S}, P3, [X13, X8, LSL #1]  // 11100100-11001000-01001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xc8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001000-01001101-10110111
st1h    {z23.d}, p3, [x13, z8.d, uxtw]  // 11100100-10001000-10001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x88,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10001000-10001101-10110111
ST1H    {Z23.D}, P3, [X13, Z8.D, UXTW]  // 11100100-10001000-10001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x88,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10001000-10001101-10110111
st1h    {z31.s}, p7, [sp, z31.s, sxtw #1]  // 11100100-11111111-11011111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, z31.s, sxtw #1] // encoding: [0xff,0xdf,0xff,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11111111-11011111-11111111
ST1H    {Z31.S}, P7, [SP, Z31.S, SXTW #1]  // 11100100-11111111-11011111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, z31.s, sxtw #1] // encoding: [0xff,0xdf,0xff,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11111111-11011111-11111111
st1h    {z21.s}, p5, [x10, z21.s, sxtw]  // 11100100-11010101-11010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, z21.s, sxtw] // encoding: [0x55,0xd5,0xd5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11010101-11010101-01010101
ST1H    {Z21.S}, P5, [X10, Z21.S, SXTW]  // 11100100-11010101-11010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, z21.s, sxtw] // encoding: [0x55,0xd5,0xd5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11010101-11010101-01010101
st1h    {z21.d}, p5, [x10, z21.d, lsl #1]  // 11100100-10110101-10110101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, lsl #1] // encoding: [0x55,0xb5,0xb5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10110101-10110101-01010101
ST1H    {Z21.D}, P5, [X10, Z21.D, LSL #1]  // 11100100-10110101-10110101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, lsl #1] // encoding: [0x55,0xb5,0xb5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10110101-10110101-01010101
st1h    {z31.d}, p7, [sp, z31.d, sxtw #1]  // 11100100-10111111-11011111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, sxtw #1] // encoding: [0xff,0xdf,0xbf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10111111-11011111-11111111
ST1H    {Z31.D}, P7, [SP, Z31.D, SXTW #1]  // 11100100-10111111-11011111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, sxtw #1] // encoding: [0xff,0xdf,0xbf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10111111-11011111-11111111
st1h    {z0.s}, p0, [x0, z0.s, sxtw #1]  // 11100100-11100000-11000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, z0.s, sxtw #1] // encoding: [0x00,0xc0,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-11000000-00000000
ST1H    {Z0.S}, P0, [X0, Z0.S, SXTW #1]  // 11100100-11100000-11000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, z0.s, sxtw #1] // encoding: [0x00,0xc0,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-11000000-00000000
st1h    {z31.s}, p7, [sp, z31.s, uxtw]  // 11100100-11011111-10011111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, z31.s, uxtw] // encoding: [0xff,0x9f,0xdf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11011111-10011111-11111111
ST1H    {Z31.S}, P7, [SP, Z31.S, UXTW]  // 11100100-11011111-10011111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, z31.s, uxtw] // encoding: [0xff,0x9f,0xdf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11011111-10011111-11111111
st1h    {z21.d}, p5, [x10, z21.d, uxtw #1]  // 11100100-10110101-10010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, uxtw #1] // encoding: [0x55,0x95,0xb5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10110101-10010101-01010101
ST1H    {Z21.D}, P5, [X10, Z21.D, UXTW #1]  // 11100100-10110101-10010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, uxtw #1] // encoding: [0x55,0x95,0xb5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10110101-10010101-01010101
st1h    {z0.s}, p0, [x0, z0.s, uxtw]  // 11100100-11000000-10000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x80,0xc0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000000-10000000-00000000
ST1H    {Z0.S}, P0, [X0, Z0.S, UXTW]  // 11100100-11000000-10000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x80,0xc0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000000-10000000-00000000
st1h    {z0.d}, p0, [x0, z0.d, sxtw]  // 11100100-10000000-11000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x80,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10000000-11000000-00000000
ST1H    {Z0.D}, P0, [X0, Z0.D, SXTW]  // 11100100-10000000-11000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x80,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10000000-11000000-00000000
st1h    {z21.d}, p5, [x10, z21.d]  // 11100100-10010101-10110101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d] // encoding: [0x55,0xb5,0x95,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10010101-10110101-01010101
ST1H    {Z21.D}, P5, [X10, Z21.D]  // 11100100-10010101-10110101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d] // encoding: [0x55,0xb5,0x95,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10010101-10110101-01010101
st1h    {z23.d}, p3, [x13, z8.d, sxtw]  // 11100100-10001000-11001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x88,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10001000-11001101-10110111
ST1H    {Z23.D}, P3, [X13, Z8.D, SXTW]  // 11100100-10001000-11001101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x88,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10001000-11001101-10110111
st1h    {z23.s}, p3, [x13, z8.s, uxtw #1]  // 11100100-11101000-10001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, z8.s, uxtw #1] // encoding: [0xb7,0x8d,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-10001101-10110111
ST1H    {Z23.S}, P3, [X13, Z8.S, UXTW #1]  // 11100100-11101000-10001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, z8.s, uxtw #1] // encoding: [0xb7,0x8d,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-10001101-10110111
st1h    {z0.d}, p0, [x0, x0, lsl #1]  // 11100100-11100000-01000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-01000000-00000000
ST1H    {Z0.D}, P0, [X0, X0, LSL #1]  // 11100100-11100000-01000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-01000000-00000000
st1h    {z21.s}, p5, [x10, #5, mul vl]  // 11100100-11000101-11110101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xc5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000101-11110101-01010101
ST1H    {Z21.S}, P5, [X10, #5, MUL VL]  // 11100100-11000101-11110101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xc5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000101-11110101-01010101
st1h    {z31.s}, p7, [sp, z31.s, sxtw]  // 11100100-11011111-11011111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, z31.s, sxtw] // encoding: [0xff,0xdf,0xdf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11011111-11011111-11111111
ST1H    {Z31.S}, P7, [SP, Z31.S, SXTW]  // 11100100-11011111-11011111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, z31.s, sxtw] // encoding: [0xff,0xdf,0xdf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11011111-11011111-11111111
st1h    {z21.d}, p5, [x10, z21.d, uxtw]  // 11100100-10010101-10010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x95,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10010101-10010101-01010101
ST1H    {Z21.D}, P5, [X10, Z21.D, UXTW]  // 11100100-10010101-10010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x95,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10010101-10010101-01010101
st1h    {z31.d}, p7, [sp, z31.d, lsl #1]  // 11100100-10111111-10111111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, lsl #1] // encoding: [0xff,0xbf,0xbf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10111111-10111111-11111111
ST1H    {Z31.D}, P7, [SP, Z31.D, LSL #1]  // 11100100-10111111-10111111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, z31.d, lsl #1] // encoding: [0xff,0xbf,0xbf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10111111-10111111-11111111
st1h    {z0.d}, p0, [x0, z0.d, uxtw]  // 11100100-10000000-10000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x80,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10000000-10000000-00000000
ST1H    {Z0.D}, P0, [X0, Z0.D, UXTW]  // 11100100-10000000-10000000-00000000
// CHECK: st1h    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x80,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10000000-10000000-00000000
st1h    {z0.d}, p0, [x0]  // 11100100-11100000-11100000-00000000
// CHECK: st1h    {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-11100000-00000000
ST1H    {Z0.D}, P0, [X0]  // 11100100-11100000-11100000-00000000
// CHECK: st1h    {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-11100000-00000000
st1h    {z0.s}, p0, [x0, z0.s, sxtw]  // 11100100-11000000-11000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, z0.s, sxtw] // encoding: [0x00,0xc0,0xc0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000000-11000000-00000000
ST1H    {Z0.S}, P0, [X0, Z0.S, SXTW]  // 11100100-11000000-11000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, z0.s, sxtw] // encoding: [0x00,0xc0,0xc0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000000-11000000-00000000
st1h    {z0.s}, p0, [z0.s]  // 11100100-11100000-10100000-00000000
// CHECK: st1h    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-10100000-00000000
ST1H    {Z0.S}, P0, [Z0.S]  // 11100100-11100000-10100000-00000000
// CHECK: st1h    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-10100000-00000000
st1h    {z23.s}, p3, [x13, z8.s, sxtw]  // 11100100-11001000-11001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, z8.s, sxtw] // encoding: [0xb7,0xcd,0xc8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001000-11001101-10110111
ST1H    {Z23.S}, P3, [X13, Z8.S, SXTW]  // 11100100-11001000-11001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, z8.s, sxtw] // encoding: [0xb7,0xcd,0xc8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001000-11001101-10110111
st1h    {z23.s}, p3, [x13, #-8, mul vl]  // 11100100-11001000-11101101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xc8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001000-11101101-10110111
ST1H    {Z23.S}, P3, [X13, #-8, MUL VL]  // 11100100-11001000-11101101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xc8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001000-11101101-10110111
st1h    {z23.s}, p3, [x13, z8.s, sxtw #1]  // 11100100-11101000-11001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, z8.s, sxtw #1] // encoding: [0xb7,0xcd,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-11001101-10110111
ST1H    {Z23.S}, P3, [X13, Z8.S, SXTW #1]  // 11100100-11101000-11001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, z8.s, sxtw #1] // encoding: [0xb7,0xcd,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-11001101-10110111
st1h    {z31.s}, p7, [sp, z31.s, uxtw #1]  // 11100100-11111111-10011111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, z31.s, uxtw #1] // encoding: [0xff,0x9f,0xff,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11111111-10011111-11111111
ST1H    {Z31.S}, P7, [SP, Z31.S, UXTW #1]  // 11100100-11111111-10011111-11111111
// CHECK: st1h    {z31.s}, p7, [sp, z31.s, uxtw #1] // encoding: [0xff,0x9f,0xff,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11111111-10011111-11111111
st1h    {z21.d}, p5, [x10, #5, mul vl]  // 11100100-11100101-11110101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xe5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100101-11110101-01010101
ST1H    {Z21.D}, P5, [X10, #5, MUL VL]  // 11100100-11100101-11110101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xe5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100101-11110101-01010101
st1h    {z31.d}, p7, [sp, #-1, mul vl]  // 11100100-11101111-11111111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xef,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101111-11111111-11111111
ST1H    {Z31.D}, P7, [SP, #-1, MUL VL]  // 11100100-11101111-11111111-11111111
// CHECK: st1h    {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xef,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101111-11111111-11111111
st1h    {z0.s}, p0, [x0]  // 11100100-11000000-11100000-00000000
// CHECK: st1h    {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0xc0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000000-11100000-00000000
ST1H    {Z0.S}, P0, [X0]  // 11100100-11000000-11100000-00000000
// CHECK: st1h    {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0xc0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000000-11100000-00000000
st1h    {z31.d}, p7, [z31.d, #62]  // 11100100-11011111-10111111-11111111
// CHECK: st1h    {z31.d}, p7, [z31.d, #62] // encoding: [0xff,0xbf,0xdf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11011111-10111111-11111111
ST1H    {Z31.D}, P7, [Z31.D, #62]  // 11100100-11011111-10111111-11111111
// CHECK: st1h    {z31.d}, p7, [z31.d, #62] // encoding: [0xff,0xbf,0xdf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11011111-10111111-11111111
st1h    {z23.d}, p3, [x13, z8.d, lsl #1]  // 11100100-10101000-10101101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, lsl #1] // encoding: [0xb7,0xad,0xa8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101000-10101101-10110111
ST1H    {Z23.D}, P3, [X13, Z8.D, LSL #1]  // 11100100-10101000-10101101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d, lsl #1] // encoding: [0xb7,0xad,0xa8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101000-10101101-10110111
st1h    {z21.d}, p5, [x10, z21.d, sxtw]  // 11100100-10010101-11010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x95,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10010101-11010101-01010101
ST1H    {Z21.D}, P5, [X10, Z21.D, SXTW]  // 11100100-10010101-11010101-01010101
// CHECK: st1h    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x95,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10010101-11010101-01010101
st1h    {z0.d}, p0, [z0.d]  // 11100100-11000000-10100000-00000000
// CHECK: st1h    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0xc0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000000-10100000-00000000
ST1H    {Z0.D}, P0, [Z0.D]  // 11100100-11000000-10100000-00000000
// CHECK: st1h    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0xc0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11000000-10100000-00000000
st1h    {z23.s}, p3, [x13, z8.s, uxtw]  // 11100100-11001000-10001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, z8.s, uxtw] // encoding: [0xb7,0x8d,0xc8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001000-10001101-10110111
ST1H    {Z23.S}, P3, [X13, Z8.S, UXTW]  // 11100100-11001000-10001101-10110111
// CHECK: st1h    {z23.s}, p3, [x13, z8.s, uxtw] // encoding: [0xb7,0x8d,0xc8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11001000-10001101-10110111
st1h    {z23.d}, p3, [x13, z8.d]  // 11100100-10001000-10101101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d] // encoding: [0xb7,0xad,0x88,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10001000-10101101-10110111
ST1H    {Z23.D}, P3, [X13, Z8.D]  // 11100100-10001000-10101101-10110111
// CHECK: st1h    {z23.d}, p3, [x13, z8.d] // encoding: [0xb7,0xad,0x88,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10001000-10101101-10110111
st1h    {z0.h}, p0, [x0]  // 11100100-10100000-11100000-00000000
// CHECK: st1h    {z0.h}, p0, [x0] // encoding: [0x00,0xe0,0xa0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100000-11100000-00000000
ST1H    {Z0.H}, P0, [X0]  // 11100100-10100000-11100000-00000000
// CHECK: st1h    {z0.h}, p0, [x0] // encoding: [0x00,0xe0,0xa0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10100000-11100000-00000000
st1h    {z5.h}, p3, [x17, x16, lsl #1]  // 11100100-10110000-01001110-00100101
// CHECK: st1h    {z5.h}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xb0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10110000-01001110-00100101
ST1H    {Z5.H}, P3, [X17, X16, LSL #1]  // 11100100-10110000-01001110-00100101
// CHECK: st1h    {z5.h}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xb0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10110000-01001110-00100101
st1h    {z21.d}, p5, [z10.d, #42]  // 11100100-11010101-10110101-01010101
// CHECK: st1h    {z21.d}, p5, [z10.d, #42] // encoding: [0x55,0xb5,0xd5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11010101-10110101-01010101
ST1H    {Z21.D}, P5, [Z10.D, #42]  // 11100100-11010101-10110101-01010101
// CHECK: st1h    {z21.d}, p5, [z10.d, #42] // encoding: [0x55,0xb5,0xd5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11010101-10110101-01010101
st1h    {z21.s}, p5, [x10, z21.s, uxtw #1]  // 11100100-11110101-10010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, z21.s, uxtw #1] // encoding: [0x55,0x95,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-10010101-01010101
ST1H    {Z21.S}, P5, [X10, Z21.S, UXTW #1]  // 11100100-11110101-10010101-01010101
// CHECK: st1h    {z21.s}, p5, [x10, z21.s, uxtw #1] // encoding: [0x55,0x95,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-10010101-01010101
st1h    {z31.h}, p7, [sp, #-1, mul vl]  // 11100100-10101111-11111111-11111111
// CHECK: st1h    {z31.h}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xaf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101111-11111111-11111111
ST1H    {Z31.H}, P7, [SP, #-1, MUL VL]  // 11100100-10101111-11111111-11111111
// CHECK: st1h    {z31.h}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xaf,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-10101111-11111111-11111111
st1h    {z0.s}, p0, [x0, z0.s, uxtw #1]  // 11100100-11100000-10000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, z0.s, uxtw #1] // encoding: [0x00,0x80,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-10000000-00000000
ST1H    {Z0.S}, P0, [X0, Z0.S, UXTW #1]  // 11100100-11100000-10000000-00000000
// CHECK: st1h    {z0.s}, p0, [x0, z0.s, uxtw #1] // encoding: [0x00,0x80,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-10000000-00000000
