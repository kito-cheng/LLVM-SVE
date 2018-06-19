// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfd    pldl1keep, p0, [x0, z0.d, sxtw #3]  // 11000100-01100000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.d, sxtw #3] // encoding: [0x00,0x60,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-01100000-00000000
PRFD    PLDL1KEEP, P0, [X0, Z0.D, SXTW #3]  // 11000100-01100000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.d, sxtw #3] // encoding: [0x00,0x60,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-01100000-00000000
prfd    pldl1keep, p0, [z0.s]  // 10000101-10000000-11100000-00000000
// CHECK: prfd    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x80,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10000000-11100000-00000000
PRFD    PLDL1KEEP, P0, [Z0.S]  // 10000101-10000000-11100000-00000000
// CHECK: prfd    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x80,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10000000-11100000-00000000
prfd    pldl1keep, p0, [x0, z0.s, uxtw #3]  // 10000100-00100000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.s, uxtw #3] // encoding: [0x00,0x60,0x20,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00100000-01100000-00000000
PRFD    PLDL1KEEP, P0, [X0, Z0.S, UXTW #3]  // 10000100-00100000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.s, uxtw #3] // encoding: [0x00,0x60,0x20,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00100000-01100000-00000000
prfd    pldl3strm, p5, [x10, x21, lsl #3]  // 10000101-10010101-11010101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, x21, lsl #3] // encoding: [0x45,0xd5,0x95,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10010101-11010101-01000101
PRFD    PLDL3STRM, P5, [X10, X21, LSL #3]  // 10000101-10010101-11010101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, x21, lsl #3] // encoding: [0x45,0xd5,0x95,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10010101-11010101-01000101
prfd    #15, p7, [sp, z31.d, uxtw #3]  // 11000100-00111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.d, uxtw #3] // encoding: [0xef,0x7f,0x3f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00111111-01111111-11101111
PRFD    #15, P7, [SP, Z31.D, UXTW #3]  // 11000100-00111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.d, uxtw #3] // encoding: [0xef,0x7f,0x3f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00111111-01111111-11101111
prfd    #7, p3, [x13, x8, lsl #3]  // 10000101-10001000-11001101-10100111
// CHECK: prfd    #7, p3, [x13, x8, lsl #3] // encoding: [0xa7,0xcd,0x88,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10001000-11001101-10100111
PRFD    #7, P3, [X13, X8, LSL #3]  // 10000101-10001000-11001101-10100111
// CHECK: prfd    #7, p3, [x13, x8, lsl #3] // encoding: [0xa7,0xcd,0x88,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10001000-11001101-10100111
prfd    #15, p7, [sp, z31.s, sxtw #3]  // 10000100-01111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.s, sxtw #3] // encoding: [0xef,0x7f,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-01111111-11101111
PRFD    #15, P7, [SP, Z31.S, SXTW #3]  // 10000100-01111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.s, sxtw #3] // encoding: [0xef,0x7f,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-01111111-11101111
prfd    pldl3strm, p5, [x10, z21.d, sxtw #3]  // 11000100-01110101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.d, sxtw #3] // encoding: [0x45,0x75,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-01110101-01000101
PRFD    PLDL3STRM, P5, [X10, Z21.D, SXTW #3]  // 11000100-01110101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.d, sxtw #3] // encoding: [0x45,0x75,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-01110101-01000101
prfd    pldl3strm, p5, [x10, z21.s, uxtw #3]  // 10000100-00110101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.s, uxtw #3] // encoding: [0x45,0x75,0x35,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00110101-01110101-01000101
PRFD    PLDL3STRM, P5, [X10, Z21.S, UXTW #3]  // 10000100-00110101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.s, uxtw #3] // encoding: [0x45,0x75,0x35,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00110101-01110101-01000101
prfd    pldl1keep, p0, [x0, z0.d, lsl #3]  // 11000100-01100000-11100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.d, lsl #3] // encoding: [0x00,0xe0,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-11100000-00000000
PRFD    PLDL1KEEP, P0, [X0, Z0.D, LSL #3]  // 11000100-01100000-11100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.d, lsl #3] // encoding: [0x00,0xe0,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-11100000-00000000
prfd    #7, p3, [x13, z8.d, sxtw #3]  // 11000100-01101000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.d, sxtw #3] // encoding: [0xa7,0x6d,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-01101101-10100111
PRFD    #7, P3, [X13, Z8.D, SXTW #3]  // 11000100-01101000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.d, sxtw #3] // encoding: [0xa7,0x6d,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-01101101-10100111
prfd    #7, p3, [x13, z8.s, uxtw #3]  // 10000100-00101000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.s, uxtw #3] // encoding: [0xa7,0x6d,0x28,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00101000-01101101-10100111
PRFD    #7, P3, [X13, Z8.S, UXTW #3]  // 10000100-00101000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.s, uxtw #3] // encoding: [0xa7,0x6d,0x28,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00101000-01101101-10100111
prfd    #15, p7, [z31.s, #248]  // 10000101-10011111-11111111-11101111
// CHECK: prfd    #15, p7, [z31.s, #248] // encoding: [0xef,0xff,0x9f,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10011111-11111111-11101111
PRFD    #15, P7, [Z31.S, #248]  // 10000101-10011111-11111111-11101111
// CHECK: prfd    #15, p7, [z31.s, #248] // encoding: [0xef,0xff,0x9f,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10011111-11111111-11101111
prfd    pldl3strm, p5, [x10, #21, mul vl]  // 10000101-11010101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x75,0xd5,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11010101-01110101-01000101
PRFD    PLDL3STRM, P5, [X10, #21, MUL VL]  // 10000101-11010101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x75,0xd5,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11010101-01110101-01000101
prfd    #7, p3, [x13, #8, mul vl]  // 10000101-11001000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x6d,0xc8,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11001000-01101101-10100111
PRFD    #7, P3, [X13, #8, MUL VL]  // 10000101-11001000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x6d,0xc8,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11001000-01101101-10100111
prfd    #15, p7, [sp, z31.d, sxtw #3]  // 11000100-01111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.d, sxtw #3] // encoding: [0xef,0x7f,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-01111111-11101111
PRFD    #15, P7, [SP, Z31.D, SXTW #3]  // 11000100-01111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.d, sxtw #3] // encoding: [0xef,0x7f,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-01111111-11101111
prfd    #15, p7, [sp, z31.s, uxtw #3]  // 10000100-00111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.s, uxtw #3] // encoding: [0xef,0x7f,0x3f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00111111-01111111-11101111
PRFD    #15, P7, [SP, Z31.S, UXTW #3]  // 10000100-00111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.s, uxtw #3] // encoding: [0xef,0x7f,0x3f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00111111-01111111-11101111
prfd    #7, p3, [z13.s, #64]  // 10000101-10001000-11101101-10100111
// CHECK: prfd    #7, p3, [z13.s, #64] // encoding: [0xa7,0xed,0x88,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10001000-11101101-10100111
PRFD    #7, P3, [Z13.S, #64]  // 10000101-10001000-11101101-10100111
// CHECK: prfd    #7, p3, [z13.s, #64] // encoding: [0xa7,0xed,0x88,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10001000-11101101-10100111
prfd    pldl1keep, p0, [z0.d]  // 11000101-10000000-11100000-00000000
// CHECK: prfd    pldl1keep, p0, [z0.d] // encoding: [0x00,0xe0,0x80,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10000000-11100000-00000000
PRFD    PLDL1KEEP, P0, [Z0.D]  // 11000101-10000000-11100000-00000000
// CHECK: prfd    pldl1keep, p0, [z0.d] // encoding: [0x00,0xe0,0x80,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10000000-11100000-00000000
prfd    pldl3strm, p5, [x10, z21.d, uxtw #3]  // 11000100-00110101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.d, uxtw #3] // encoding: [0x45,0x75,0x35,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00110101-01110101-01000101
PRFD    PLDL3STRM, P5, [X10, Z21.D, UXTW #3]  // 11000100-00110101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.d, uxtw #3] // encoding: [0x45,0x75,0x35,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00110101-01110101-01000101
prfd    #7, p3, [z13.d, #64]  // 11000101-10001000-11101101-10100111
// CHECK: prfd    #7, p3, [z13.d, #64] // encoding: [0xa7,0xed,0x88,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10001000-11101101-10100111
PRFD    #7, P3, [Z13.D, #64]  // 11000101-10001000-11101101-10100111
// CHECK: prfd    #7, p3, [z13.d, #64] // encoding: [0xa7,0xed,0x88,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10001000-11101101-10100111
prfd    pldl3strm, p5, [x10, z21.s, sxtw #3]  // 10000100-01110101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.s, sxtw #3] // encoding: [0x45,0x75,0x75,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01110101-01110101-01000101
PRFD    PLDL3STRM, P5, [X10, Z21.S, SXTW #3]  // 10000100-01110101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.s, sxtw #3] // encoding: [0x45,0x75,0x75,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01110101-01110101-01000101
prfd    pldl1keep, p0, [x0]  // 10000101-11000000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0] // encoding: [0x00,0x60,0xc0,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11000000-01100000-00000000
PRFD    PLDL1KEEP, P0, [X0]  // 10000101-11000000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0] // encoding: [0x00,0x60,0xc0,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11000000-01100000-00000000
prfd    pldl1keep, p0, [x0, z0.d, uxtw #3]  // 11000100-00100000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.d, uxtw #3] // encoding: [0x00,0x60,0x20,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00100000-01100000-00000000
PRFD    PLDL1KEEP, P0, [X0, Z0.D, UXTW #3]  // 11000100-00100000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.d, uxtw #3] // encoding: [0x00,0x60,0x20,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00100000-01100000-00000000
prfd    pldl1keep, p0, [x0, z0.s, sxtw #3]  // 10000100-01100000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.s, sxtw #3] // encoding: [0x00,0x60,0x60,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01100000-01100000-00000000
PRFD    PLDL1KEEP, P0, [X0, Z0.S, SXTW #3]  // 10000100-01100000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.s, sxtw #3] // encoding: [0x00,0x60,0x60,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01100000-01100000-00000000
prfd    pldl3strm, p5, [z10.d, #168]  // 11000101-10010101-11110101-01000101
// CHECK: prfd    pldl3strm, p5, [z10.d, #168] // encoding: [0x45,0xf5,0x95,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10010101-11110101-01000101
PRFD    PLDL3STRM, P5, [Z10.D, #168]  // 11000101-10010101-11110101-01000101
// CHECK: prfd    pldl3strm, p5, [z10.d, #168] // encoding: [0x45,0xf5,0x95,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10010101-11110101-01000101
prfd    pldl3strm, p3, [x17, x16, lsl #3]  // 10000101-10010000-11001110-00100101
// CHECK: prfd    pldl3strm, p3, [x17, x16, lsl #3] // encoding: [0x25,0xce,0x90,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10010000-11001110-00100101
PRFD    PLDL3STRM, P3, [X17, X16, LSL #3]  // 10000101-10010000-11001110-00100101
// CHECK: prfd    pldl3strm, p3, [x17, x16, lsl #3] // encoding: [0x25,0xce,0x90,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10010000-11001110-00100101
prfd    #15, p7, [sp, z31.d, lsl #3]  // 11000100-01111111-11111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.d, lsl #3] // encoding: [0xef,0xff,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-11111111-11101111
PRFD    #15, P7, [SP, Z31.D, LSL #3]  // 11000100-01111111-11111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.d, lsl #3] // encoding: [0xef,0xff,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-11111111-11101111
prfd    pldl1keep, p0, [x0, x0, lsl #3]  // 10000101-10000000-11000000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0x80,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10000000-11000000-00000000
PRFD    PLDL1KEEP, P0, [X0, X0, LSL #3]  // 10000101-10000000-11000000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0x80,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10000000-11000000-00000000
prfd    pldl3strm, p5, [z10.s, #168]  // 10000101-10010101-11110101-01000101
// CHECK: prfd    pldl3strm, p5, [z10.s, #168] // encoding: [0x45,0xf5,0x95,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10010101-11110101-01000101
PRFD    PLDL3STRM, P5, [Z10.S, #168]  // 10000101-10010101-11110101-01000101
// CHECK: prfd    pldl3strm, p5, [z10.s, #168] // encoding: [0x45,0xf5,0x95,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10010101-11110101-01000101
prfd    #15, p7, [sp, #-1, mul vl]  // 10000101-11111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x7f,0xff,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11111111-01111111-11101111
PRFD    #15, P7, [SP, #-1, MUL VL]  // 10000101-11111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x7f,0xff,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11111111-01111111-11101111
prfd    #7, p3, [x13, z8.d, lsl #3]  // 11000100-01101000-11101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.d, lsl #3] // encoding: [0xa7,0xed,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-11101101-10100111
PRFD    #7, P3, [X13, Z8.D, LSL #3]  // 11000100-01101000-11101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.d, lsl #3] // encoding: [0xa7,0xed,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-11101101-10100111
prfd    pldl3strm, p5, [x10, z21.d, lsl #3]  // 11000100-01110101-11110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.d, lsl #3] // encoding: [0x45,0xf5,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-11110101-01000101
PRFD    PLDL3STRM, P5, [X10, Z21.D, LSL #3]  // 11000100-01110101-11110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.d, lsl #3] // encoding: [0x45,0xf5,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-11110101-01000101
prfd    #7, p3, [x13, z8.d, uxtw #3]  // 11000100-00101000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.d, uxtw #3] // encoding: [0xa7,0x6d,0x28,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00101000-01101101-10100111
PRFD    #7, P3, [X13, Z8.D, UXTW #3]  // 11000100-00101000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.d, uxtw #3] // encoding: [0xa7,0x6d,0x28,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00101000-01101101-10100111
prfd    #7, p3, [x13, z8.s, sxtw #3]  // 10000100-01101000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.s, sxtw #3] // encoding: [0xa7,0x6d,0x68,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01101000-01101101-10100111
PRFD    #7, P3, [X13, Z8.S, SXTW #3]  // 10000100-01101000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.s, sxtw #3] // encoding: [0xa7,0x6d,0x68,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01101000-01101101-10100111
prfd    #15, p7, [z31.d, #248]  // 11000101-10011111-11111111-11101111
// CHECK: prfd    #15, p7, [z31.d, #248] // encoding: [0xef,0xff,0x9f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10011111-11111111-11101111
PRFD    #15, P7, [Z31.D, #248]  // 11000101-10011111-11111111-11101111
// CHECK: prfd    #15, p7, [z31.d, #248] // encoding: [0xef,0xff,0x9f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-10011111-11111111-11101111
