// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st1b    {z5.s}, p3, [x17, x16]  // 11100100-01010000-01001110-00100101
// CHECK: st1b    {z5.s}, p3, [x17, x16] // encoding: [0x25,0x4e,0x50,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01010000-01001110-00100101
ST1B    {Z5.S}, P3, [X17, X16]  // 11100100-01010000-01001110-00100101
// CHECK: st1b    {z5.s}, p3, [x17, x16] // encoding: [0x25,0x4e,0x50,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01010000-01001110-00100101
st1b    {z21.d}, p5, [x10, z21.d, sxtw]  // 11100100-00010101-11010101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x15,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00010101-11010101-01010101
ST1B    {Z21.D}, P5, [X10, Z21.D, SXTW]  // 11100100-00010101-11010101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x15,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00010101-11010101-01010101
st1b    {z31.d}, p7, [sp, z31.d, uxtw]  // 11100100-00011111-10011111-11111111
// CHECK: st1b    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x1f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00011111-10011111-11111111
ST1B    {Z31.D}, P7, [SP, Z31.D, UXTW]  // 11100100-00011111-10011111-11111111
// CHECK: st1b    {z31.d}, p7, [sp, z31.d, uxtw] // encoding: [0xff,0x9f,0x1f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00011111-10011111-11111111
st1b    {z21.d}, p5, [x10, x21]  // 11100100-01110101-01010101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, x21] // encoding: [0x55,0x55,0x75,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01110101-01010101-01010101
ST1B    {Z21.D}, P5, [X10, X21]  // 11100100-01110101-01010101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, x21] // encoding: [0x55,0x55,0x75,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01110101-01010101-01010101
st1b    {z5.d}, p3, [x17, x16]  // 11100100-01110000-01001110-00100101
// CHECK: st1b    {z5.d}, p3, [x17, x16] // encoding: [0x25,0x4e,0x70,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01110000-01001110-00100101
ST1B    {Z5.D}, P3, [X17, X16]  // 11100100-01110000-01001110-00100101
// CHECK: st1b    {z5.d}, p3, [x17, x16] // encoding: [0x25,0x4e,0x70,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01110000-01001110-00100101
st1b    {z21.d}, p5, [x10, #5, mul vl]  // 11100100-01100101-11110101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x65,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01100101-11110101-01010101
ST1B    {Z21.D}, P5, [X10, #5, MUL VL]  // 11100100-01100101-11110101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x65,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01100101-11110101-01010101
st1b    {z31.d}, p7, [z31.d, #31]  // 11100100-01011111-10111111-11111111
// CHECK: st1b    {z31.d}, p7, [z31.d, #31] // encoding: [0xff,0xbf,0x5f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01011111-10111111-11111111
ST1B    {Z31.D}, P7, [Z31.D, #31]  // 11100100-01011111-10111111-11111111
// CHECK: st1b    {z31.d}, p7, [z31.d, #31] // encoding: [0xff,0xbf,0x5f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01011111-10111111-11111111
st1b    {z23.d}, p3, [z13.d, #8]  // 11100100-01001000-10101101-10110111
// CHECK: st1b    {z23.d}, p3, [z13.d, #8] // encoding: [0xb7,0xad,0x48,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001000-10101101-10110111
ST1B    {Z23.D}, P3, [Z13.D, #8]  // 11100100-01001000-10101101-10110111
// CHECK: st1b    {z23.d}, p3, [z13.d, #8] // encoding: [0xb7,0xad,0x48,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001000-10101101-10110111
st1b    {z0.d}, p0, [x0, z0.d, uxtw]  // 11100100-00000000-10000000-00000000
// CHECK: st1b    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000000-10000000-00000000
ST1B    {Z0.D}, P0, [X0, Z0.D, UXTW]  // 11100100-00000000-10000000-00000000
// CHECK: st1b    {z0.d}, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x80,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000000-10000000-00000000
st1b    {z5.h}, p3, [x17, x16]  // 11100100-00110000-01001110-00100101
// CHECK: st1b    {z5.h}, p3, [x17, x16] // encoding: [0x25,0x4e,0x30,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110000-01001110-00100101
ST1B    {Z5.H}, P3, [X17, X16]  // 11100100-00110000-01001110-00100101
// CHECK: st1b    {z5.h}, p3, [x17, x16] // encoding: [0x25,0x4e,0x30,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110000-01001110-00100101
st1b    {z23.h}, p3, [x13, #-8, mul vl]  // 11100100-00101000-11101101-10110111
// CHECK: st1b    {z23.h}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x28,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00101000-11101101-10110111
ST1B    {Z23.H}, P3, [X13, #-8, MUL VL]  // 11100100-00101000-11101101-10110111
// CHECK: st1b    {z23.h}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x28,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00101000-11101101-10110111
st1b    {z23.s}, p3, [x13, #-8, mul vl]  // 11100100-01001000-11101101-10110111
// CHECK: st1b    {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x48,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001000-11101101-10110111
ST1B    {Z23.S}, P3, [X13, #-8, MUL VL]  // 11100100-01001000-11101101-10110111
// CHECK: st1b    {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x48,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001000-11101101-10110111
st1b    {z23.s}, p3, [x13, z8.s, sxtw]  // 11100100-01001000-11001101-10110111
// CHECK: st1b    {z23.s}, p3, [x13, z8.s, sxtw] // encoding: [0xb7,0xcd,0x48,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001000-11001101-10110111
ST1B    {Z23.S}, P3, [X13, Z8.S, SXTW]  // 11100100-01001000-11001101-10110111
// CHECK: st1b    {z23.s}, p3, [x13, z8.s, sxtw] // encoding: [0xb7,0xcd,0x48,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001000-11001101-10110111
st1b    {z0.d}, p0, [z0.d]  // 11100100-01000000-10100000-00000000
// CHECK: st1b    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0x40,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000000-10100000-00000000
ST1B    {Z0.D}, P0, [Z0.D]  // 11100100-01000000-10100000-00000000
// CHECK: st1b    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0x40,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000000-10100000-00000000
st1b    {z31.s}, p7, [sp, z31.s, uxtw]  // 11100100-01011111-10011111-11111111
// CHECK: st1b    {z31.s}, p7, [sp, z31.s, uxtw] // encoding: [0xff,0x9f,0x5f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01011111-10011111-11111111
ST1B    {Z31.S}, P7, [SP, Z31.S, UXTW]  // 11100100-01011111-10011111-11111111
// CHECK: st1b    {z31.s}, p7, [sp, z31.s, uxtw] // encoding: [0xff,0x9f,0x5f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01011111-10011111-11111111
st1b    {z21.s}, p5, [x10, #5, mul vl]  // 11100100-01000101-11110101-01010101
// CHECK: st1b    {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x45,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000101-11110101-01010101
ST1B    {Z21.S}, P5, [X10, #5, MUL VL]  // 11100100-01000101-11110101-01010101
// CHECK: st1b    {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x45,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000101-11110101-01010101
st1b    {z21.s}, p5, [x10, z21.s, sxtw]  // 11100100-01010101-11010101-01010101
// CHECK: st1b    {z21.s}, p5, [x10, z21.s, sxtw] // encoding: [0x55,0xd5,0x55,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01010101-11010101-01010101
ST1B    {Z21.S}, P5, [X10, Z21.S, SXTW]  // 11100100-01010101-11010101-01010101
// CHECK: st1b    {z21.s}, p5, [x10, z21.s, sxtw] // encoding: [0x55,0xd5,0x55,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01010101-11010101-01010101
st1b    {z0.d}, p0, [x0, z0.d]  // 11100100-00000000-10100000-00000000
// CHECK: st1b    {z0.d}, p0, [x0, z0.d] // encoding: [0x00,0xa0,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000000-10100000-00000000
ST1B    {Z0.D}, P0, [X0, Z0.D]  // 11100100-00000000-10100000-00000000
// CHECK: st1b    {z0.d}, p0, [x0, z0.d] // encoding: [0x00,0xa0,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000000-10100000-00000000
st1b    {z31.s}, p7, [z31.s, #31]  // 11100100-01111111-10111111-11111111
// CHECK: st1b    {z31.s}, p7, [z31.s, #31] // encoding: [0xff,0xbf,0x7f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01111111-10111111-11111111
ST1B    {Z31.S}, P7, [Z31.S, #31]  // 11100100-01111111-10111111-11111111
// CHECK: st1b    {z31.s}, p7, [z31.s, #31] // encoding: [0xff,0xbf,0x7f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01111111-10111111-11111111
st1b    {z23.d}, p3, [x13, z8.d]  // 11100100-00001000-10101101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, z8.d] // encoding: [0xb7,0xad,0x08,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001000-10101101-10110111
ST1B    {Z23.D}, P3, [X13, Z8.D]  // 11100100-00001000-10101101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, z8.d] // encoding: [0xb7,0xad,0x08,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001000-10101101-10110111
st1b    {z21.b}, p5, [x10, x21]  // 11100100-00010101-01010101-01010101
// CHECK: st1b    {z21.b}, p5, [x10, x21] // encoding: [0x55,0x55,0x15,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00010101-01010101-01010101
ST1B    {Z21.B}, P5, [X10, X21]  // 11100100-00010101-01010101-01010101
// CHECK: st1b    {z21.b}, p5, [x10, x21] // encoding: [0x55,0x55,0x15,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00010101-01010101-01010101
st1b    {z0.s}, p0, [x0]  // 11100100-01000000-11100000-00000000
// CHECK: st1b    {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0x40,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000000-11100000-00000000
ST1B    {Z0.S}, P0, [X0]  // 11100100-01000000-11100000-00000000
// CHECK: st1b    {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0x40,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000000-11100000-00000000
st1b    {z31.b}, p7, [sp, #-1, mul vl]  // 11100100-00001111-11111111-11111111
// CHECK: st1b    {z31.b}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x0f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001111-11111111-11111111
ST1B    {Z31.B}, P7, [SP, #-1, MUL VL]  // 11100100-00001111-11111111-11111111
// CHECK: st1b    {z31.b}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x0f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001111-11111111-11111111
st1b    {z0.s}, p0, [x0, x0]  // 11100100-01000000-01000000-00000000
// CHECK: st1b    {z0.s}, p0, [x0, x0] // encoding: [0x00,0x40,0x40,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000000-01000000-00000000
ST1B    {Z0.S}, P0, [X0, X0]  // 11100100-01000000-01000000-00000000
// CHECK: st1b    {z0.s}, p0, [x0, x0] // encoding: [0x00,0x40,0x40,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000000-01000000-00000000
st1b    {z0.h}, p0, [x0]  // 11100100-00100000-11100000-00000000
// CHECK: st1b    {z0.h}, p0, [x0] // encoding: [0x00,0xe0,0x20,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00100000-11100000-00000000
ST1B    {Z0.H}, P0, [X0]  // 11100100-00100000-11100000-00000000
// CHECK: st1b    {z0.h}, p0, [x0] // encoding: [0x00,0xe0,0x20,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00100000-11100000-00000000
st1b    {z23.b}, p3, [x13, #-8, mul vl]  // 11100100-00001000-11101101-10110111
// CHECK: st1b    {z23.b}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x08,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001000-11101101-10110111
ST1B    {Z23.B}, P3, [X13, #-8, MUL VL]  // 11100100-00001000-11101101-10110111
// CHECK: st1b    {z23.b}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x08,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001000-11101101-10110111
st1b    {z23.h}, p3, [x13, x8]  // 11100100-00101000-01001101-10110111
// CHECK: st1b    {z23.h}, p3, [x13, x8] // encoding: [0xb7,0x4d,0x28,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00101000-01001101-10110111
ST1B    {Z23.H}, P3, [X13, X8]  // 11100100-00101000-01001101-10110111
// CHECK: st1b    {z23.h}, p3, [x13, x8] // encoding: [0xb7,0x4d,0x28,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00101000-01001101-10110111
st1b    {z21.s}, p5, [z10.s, #21]  // 11100100-01110101-10110101-01010101
// CHECK: st1b    {z21.s}, p5, [z10.s, #21] // encoding: [0x55,0xb5,0x75,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01110101-10110101-01010101
ST1B    {Z21.S}, P5, [Z10.S, #21]  // 11100100-01110101-10110101-01010101
// CHECK: st1b    {z21.s}, p5, [z10.s, #21] // encoding: [0x55,0xb5,0x75,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01110101-10110101-01010101
st1b    {z21.d}, p5, [x10, z21.d, uxtw]  // 11100100-00010101-10010101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x15,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00010101-10010101-01010101
ST1B    {Z21.D}, P5, [X10, Z21.D, UXTW]  // 11100100-00010101-10010101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, z21.d, uxtw] // encoding: [0x55,0x95,0x15,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00010101-10010101-01010101
st1b    {z0.s}, p0, [x0, z0.s, uxtw]  // 11100100-01000000-10000000-00000000
// CHECK: st1b    {z0.s}, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x80,0x40,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000000-10000000-00000000
ST1B    {Z0.S}, P0, [X0, Z0.S, UXTW]  // 11100100-01000000-10000000-00000000
// CHECK: st1b    {z0.s}, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x80,0x40,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000000-10000000-00000000
st1b    {z23.s}, p3, [x13, z8.s, uxtw]  // 11100100-01001000-10001101-10110111
// CHECK: st1b    {z23.s}, p3, [x13, z8.s, uxtw] // encoding: [0xb7,0x8d,0x48,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001000-10001101-10110111
ST1B    {Z23.S}, P3, [X13, Z8.S, UXTW]  // 11100100-01001000-10001101-10110111
// CHECK: st1b    {z23.s}, p3, [x13, z8.s, uxtw] // encoding: [0xb7,0x8d,0x48,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001000-10001101-10110111
st1b    {z31.h}, p7, [sp, #-1, mul vl]  // 11100100-00101111-11111111-11111111
// CHECK: st1b    {z31.h}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x2f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00101111-11111111-11111111
ST1B    {Z31.H}, P7, [SP, #-1, MUL VL]  // 11100100-00101111-11111111-11111111
// CHECK: st1b    {z31.h}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x2f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00101111-11111111-11111111
st1b    {z0.h}, p0, [x0, x0]  // 11100100-00100000-01000000-00000000
// CHECK: st1b    {z0.h}, p0, [x0, x0] // encoding: [0x00,0x40,0x20,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00100000-01000000-00000000
ST1B    {Z0.H}, P0, [X0, X0]  // 11100100-00100000-01000000-00000000
// CHECK: st1b    {z0.h}, p0, [x0, x0] // encoding: [0x00,0x40,0x20,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00100000-01000000-00000000
st1b    {z23.b}, p3, [x13, x8]  // 11100100-00001000-01001101-10110111
// CHECK: st1b    {z23.b}, p3, [x13, x8] // encoding: [0xb7,0x4d,0x08,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001000-01001101-10110111
ST1B    {Z23.B}, P3, [X13, X8]  // 11100100-00001000-01001101-10110111
// CHECK: st1b    {z23.b}, p3, [x13, x8] // encoding: [0xb7,0x4d,0x08,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001000-01001101-10110111
st1b    {z21.d}, p5, [z10.d, #21]  // 11100100-01010101-10110101-01010101
// CHECK: st1b    {z21.d}, p5, [z10.d, #21] // encoding: [0x55,0xb5,0x55,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01010101-10110101-01010101
ST1B    {Z21.D}, P5, [Z10.D, #21]  // 11100100-01010101-10110101-01010101
// CHECK: st1b    {z21.d}, p5, [z10.d, #21] // encoding: [0x55,0xb5,0x55,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01010101-10110101-01010101
st1b    {z21.s}, p5, [x10, z21.s, uxtw]  // 11100100-01010101-10010101-01010101
// CHECK: st1b    {z21.s}, p5, [x10, z21.s, uxtw] // encoding: [0x55,0x95,0x55,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01010101-10010101-01010101
ST1B    {Z21.S}, P5, [X10, Z21.S, UXTW]  // 11100100-01010101-10010101-01010101
// CHECK: st1b    {z21.s}, p5, [x10, z21.s, uxtw] // encoding: [0x55,0x95,0x55,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01010101-10010101-01010101
st1b    {z0.d}, p0, [x0, x0]  // 11100100-01100000-01000000-00000000
// CHECK: st1b    {z0.d}, p0, [x0, x0] // encoding: [0x00,0x40,0x60,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01100000-01000000-00000000
ST1B    {Z0.D}, P0, [X0, X0]  // 11100100-01100000-01000000-00000000
// CHECK: st1b    {z0.d}, p0, [x0, x0] // encoding: [0x00,0x40,0x60,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01100000-01000000-00000000
st1b    {z21.h}, p5, [x10, x21]  // 11100100-00110101-01010101-01010101
// CHECK: st1b    {z21.h}, p5, [x10, x21] // encoding: [0x55,0x55,0x35,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110101-01010101-01010101
ST1B    {Z21.H}, P5, [X10, X21]  // 11100100-00110101-01010101-01010101
// CHECK: st1b    {z21.h}, p5, [x10, x21] // encoding: [0x55,0x55,0x35,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110101-01010101-01010101
st1b    {z5.b}, p3, [x17, x16]  // 11100100-00010000-01001110-00100101
// CHECK: st1b    {z5.b}, p3, [x17, x16] // encoding: [0x25,0x4e,0x10,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00010000-01001110-00100101
ST1B    {Z5.B}, P3, [X17, X16]  // 11100100-00010000-01001110-00100101
// CHECK: st1b    {z5.b}, p3, [x17, x16] // encoding: [0x25,0x4e,0x10,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00010000-01001110-00100101
st1b    {z21.h}, p5, [x10, #5, mul vl]  // 11100100-00100101-11110101-01010101
// CHECK: st1b    {z21.h}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x25,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00100101-11110101-01010101
ST1B    {Z21.H}, P5, [X10, #5, MUL VL]  // 11100100-00100101-11110101-01010101
// CHECK: st1b    {z21.h}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x25,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00100101-11110101-01010101
st1b    {z21.d}, p5, [x10, z21.d]  // 11100100-00010101-10110101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, z21.d] // encoding: [0x55,0xb5,0x15,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00010101-10110101-01010101
ST1B    {Z21.D}, P5, [X10, Z21.D]  // 11100100-00010101-10110101-01010101
// CHECK: st1b    {z21.d}, p5, [x10, z21.d] // encoding: [0x55,0xb5,0x15,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00010101-10110101-01010101
st1b    {z31.d}, p7, [sp, z31.d]  // 11100100-00011111-10111111-11111111
// CHECK: st1b    {z31.d}, p7, [sp, z31.d] // encoding: [0xff,0xbf,0x1f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00011111-10111111-11111111
ST1B    {Z31.D}, P7, [SP, Z31.D]  // 11100100-00011111-10111111-11111111
// CHECK: st1b    {z31.d}, p7, [sp, z31.d] // encoding: [0xff,0xbf,0x1f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00011111-10111111-11111111
st1b    {z0.d}, p0, [x0]  // 11100100-01100000-11100000-00000000
// CHECK: st1b    {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0x60,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01100000-11100000-00000000
ST1B    {Z0.D}, P0, [X0]  // 11100100-01100000-11100000-00000000
// CHECK: st1b    {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0x60,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01100000-11100000-00000000
st1b    {z23.s}, p3, [z13.s, #8]  // 11100100-01101000-10101101-10110111
// CHECK: st1b    {z23.s}, p3, [z13.s, #8] // encoding: [0xb7,0xad,0x68,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01101000-10101101-10110111
ST1B    {Z23.S}, P3, [Z13.S, #8]  // 11100100-01101000-10101101-10110111
// CHECK: st1b    {z23.s}, p3, [z13.s, #8] // encoding: [0xb7,0xad,0x68,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01101000-10101101-10110111
st1b    {z21.b}, p5, [x10, #5, mul vl]  // 11100100-00000101-11110101-01010101
// CHECK: st1b    {z21.b}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x05,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000101-11110101-01010101
ST1B    {Z21.B}, P5, [X10, #5, MUL VL]  // 11100100-00000101-11110101-01010101
// CHECK: st1b    {z21.b}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x05,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000101-11110101-01010101
st1b    {z21.s}, p5, [x10, x21]  // 11100100-01010101-01010101-01010101
// CHECK: st1b    {z21.s}, p5, [x10, x21] // encoding: [0x55,0x55,0x55,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01010101-01010101-01010101
ST1B    {Z21.S}, P5, [X10, X21]  // 11100100-01010101-01010101-01010101
// CHECK: st1b    {z21.s}, p5, [x10, x21] // encoding: [0x55,0x55,0x55,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01010101-01010101-01010101
st1b    {z0.b}, p0, [x0, x0]  // 11100100-00000000-01000000-00000000
// CHECK: st1b    {z0.b}, p0, [x0, x0] // encoding: [0x00,0x40,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000000-01000000-00000000
ST1B    {Z0.B}, P0, [X0, X0]  // 11100100-00000000-01000000-00000000
// CHECK: st1b    {z0.b}, p0, [x0, x0] // encoding: [0x00,0x40,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000000-01000000-00000000
st1b    {z23.d}, p3, [x13, x8]  // 11100100-01101000-01001101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, x8] // encoding: [0xb7,0x4d,0x68,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01101000-01001101-10110111
ST1B    {Z23.D}, P3, [X13, X8]  // 11100100-01101000-01001101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, x8] // encoding: [0xb7,0x4d,0x68,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01101000-01001101-10110111
st1b    {z23.d}, p3, [x13, z8.d, uxtw]  // 11100100-00001000-10001101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x08,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001000-10001101-10110111
ST1B    {Z23.D}, P3, [X13, Z8.D, UXTW]  // 11100100-00001000-10001101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, z8.d, uxtw] // encoding: [0xb7,0x8d,0x08,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001000-10001101-10110111
st1b    {z0.s}, p0, [x0, z0.s, sxtw]  // 11100100-01000000-11000000-00000000
// CHECK: st1b    {z0.s}, p0, [x0, z0.s, sxtw] // encoding: [0x00,0xc0,0x40,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000000-11000000-00000000
ST1B    {Z0.S}, P0, [X0, Z0.S, SXTW]  // 11100100-01000000-11000000-00000000
// CHECK: st1b    {z0.s}, p0, [x0, z0.s, sxtw] // encoding: [0x00,0xc0,0x40,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01000000-11000000-00000000
st1b    {z31.s}, p7, [sp, z31.s, sxtw]  // 11100100-01011111-11011111-11111111
// CHECK: st1b    {z31.s}, p7, [sp, z31.s, sxtw] // encoding: [0xff,0xdf,0x5f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01011111-11011111-11111111
ST1B    {Z31.S}, P7, [SP, Z31.S, SXTW]  // 11100100-01011111-11011111-11111111
// CHECK: st1b    {z31.s}, p7, [sp, z31.s, sxtw] // encoding: [0xff,0xdf,0x5f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01011111-11011111-11111111
st1b    {z31.d}, p7, [sp, z31.d, sxtw]  // 11100100-00011111-11011111-11111111
// CHECK: st1b    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x1f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00011111-11011111-11111111
ST1B    {Z31.D}, P7, [SP, Z31.D, SXTW]  // 11100100-00011111-11011111-11111111
// CHECK: st1b    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x1f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00011111-11011111-11111111
st1b    {z23.d}, p3, [x13, #-8, mul vl]  // 11100100-01101000-11101101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x68,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01101000-11101101-10110111
ST1B    {Z23.D}, P3, [X13, #-8, MUL VL]  // 11100100-01101000-11101101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x68,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01101000-11101101-10110111
st1b    {z0.d}, p0, [x0, z0.d, sxtw]  // 11100100-00000000-11000000-00000000
// CHECK: st1b    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000000-11000000-00000000
ST1B    {Z0.D}, P0, [X0, Z0.D, SXTW]  // 11100100-00000000-11000000-00000000
// CHECK: st1b    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000000-11000000-00000000
st1b    {z31.d}, p7, [sp, #-1, mul vl]  // 11100100-01101111-11111111-11111111
// CHECK: st1b    {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x6f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01101111-11111111-11111111
ST1B    {Z31.D}, P7, [SP, #-1, MUL VL]  // 11100100-01101111-11111111-11111111
// CHECK: st1b    {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x6f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01101111-11111111-11111111
st1b    {z0.s}, p0, [z0.s]  // 11100100-01100000-10100000-00000000
// CHECK: st1b    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0x60,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01100000-10100000-00000000
ST1B    {Z0.S}, P0, [Z0.S]  // 11100100-01100000-10100000-00000000
// CHECK: st1b    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0x60,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01100000-10100000-00000000
st1b    {z31.s}, p7, [sp, #-1, mul vl]  // 11100100-01001111-11111111-11111111
// CHECK: st1b    {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x4f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001111-11111111-11111111
ST1B    {Z31.S}, P7, [SP, #-1, MUL VL]  // 11100100-01001111-11111111-11111111
// CHECK: st1b    {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x4f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001111-11111111-11111111
st1b    {z23.s}, p3, [x13, x8]  // 11100100-01001000-01001101-10110111
// CHECK: st1b    {z23.s}, p3, [x13, x8] // encoding: [0xb7,0x4d,0x48,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001000-01001101-10110111
ST1B    {Z23.S}, P3, [X13, X8]  // 11100100-01001000-01001101-10110111
// CHECK: st1b    {z23.s}, p3, [x13, x8] // encoding: [0xb7,0x4d,0x48,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-01001000-01001101-10110111
st1b    {z23.d}, p3, [x13, z8.d, sxtw]  // 11100100-00001000-11001101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x08,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001000-11001101-10110111
ST1B    {Z23.D}, P3, [X13, Z8.D, SXTW]  // 11100100-00001000-11001101-10110111
// CHECK: st1b    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x08,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00001000-11001101-10110111
st1b    {z0.b}, p0, [x0]  // 11100100-00000000-11100000-00000000
// CHECK: st1b    {z0.b}, p0, [x0] // encoding: [0x00,0xe0,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000000-11100000-00000000
ST1B    {Z0.B}, P0, [X0]  // 11100100-00000000-11100000-00000000
// CHECK: st1b    {z0.b}, p0, [x0] // encoding: [0x00,0xe0,0x00,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00000000-11100000-00000000
