// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfw    pldl3strm, p5, [z10.d, #84]  // 11000101-00010101-11110101-01000101
// CHECK: prfw    pldl3strm, p5, [z10.d, #84] // encoding: [0x45,0xf5,0x15,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00010101-11110101-01000101
PRFW    PLDL3STRM, P5, [Z10.D, #84]  // 11000101-00010101-11110101-01000101
// CHECK: prfw    pldl3strm, p5, [z10.d, #84] // encoding: [0x45,0xf5,0x15,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00010101-11110101-01000101
prfw    pldl1keep, p0, [x0, x0, lsl #2]  // 10000101-00000000-11000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, x0, lsl #2] // encoding: [0x00,0xc0,0x00,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00000000-11000000-00000000
PRFW    PLDL1KEEP, P0, [X0, X0, LSL #2]  // 10000101-00000000-11000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, x0, lsl #2] // encoding: [0x00,0xc0,0x00,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00000000-11000000-00000000
prfw    pldl3strm, p5, [x10, z21.d, uxtw #2]  // 11000100-00110101-01010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, z21.d, uxtw #2] // encoding: [0x45,0x55,0x35,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00110101-01010101-01000101
PRFW    PLDL3STRM, P5, [X10, Z21.D, UXTW #2]  // 11000100-00110101-01010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, z21.d, uxtw #2] // encoding: [0x45,0x55,0x35,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00110101-01010101-01000101
prfw    #15, p7, [z31.d, #124]  // 11000101-00011111-11111111-11101111
// CHECK: prfw    #15, p7, [z31.d, #124] // encoding: [0xef,0xff,0x1f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00011111-11111111-11101111
PRFW    #15, P7, [Z31.D, #124]  // 11000101-00011111-11111111-11101111
// CHECK: prfw    #15, p7, [z31.d, #124] // encoding: [0xef,0xff,0x1f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00011111-11111111-11101111
prfw    pldl3strm, p5, [x10, z21.s, sxtw #2]  // 10000100-01110101-01010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, z21.s, sxtw #2] // encoding: [0x45,0x55,0x75,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01110101-01010101-01000101
PRFW    PLDL3STRM, P5, [X10, Z21.S, SXTW #2]  // 10000100-01110101-01010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, z21.s, sxtw #2] // encoding: [0x45,0x55,0x75,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01110101-01010101-01000101
prfw    #15, p7, [sp, z31.d, lsl #2]  // 11000100-01111111-11011111-11101111
// CHECK: prfw    #15, p7, [sp, z31.d, lsl #2] // encoding: [0xef,0xdf,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-11011111-11101111
PRFW    #15, P7, [SP, Z31.D, LSL #2]  // 11000100-01111111-11011111-11101111
// CHECK: prfw    #15, p7, [sp, z31.d, lsl #2] // encoding: [0xef,0xdf,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-11011111-11101111
prfw    pldl1keep, p0, [z0.d]  // 11000101-00000000-11100000-00000000
// CHECK: prfw    pldl1keep, p0, [z0.d] // encoding: [0x00,0xe0,0x00,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00000000-11100000-00000000
PRFW    PLDL1KEEP, P0, [Z0.D]  // 11000101-00000000-11100000-00000000
// CHECK: prfw    pldl1keep, p0, [z0.d] // encoding: [0x00,0xe0,0x00,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00000000-11100000-00000000
prfw    pldl1keep, p0, [x0, z0.d, sxtw #2]  // 11000100-01100000-01000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, z0.d, sxtw #2] // encoding: [0x00,0x40,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-01000000-00000000
PRFW    PLDL1KEEP, P0, [X0, Z0.D, SXTW #2]  // 11000100-01100000-01000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, z0.d, sxtw #2] // encoding: [0x00,0x40,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-01000000-00000000
prfw    pldl1keep, p0, [x0, z0.s, uxtw #2]  // 10000100-00100000-01000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, z0.s, uxtw #2] // encoding: [0x00,0x40,0x20,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00100000-01000000-00000000
PRFW    PLDL1KEEP, P0, [X0, Z0.S, UXTW #2]  // 10000100-00100000-01000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, z0.s, uxtw #2] // encoding: [0x00,0x40,0x20,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00100000-01000000-00000000
prfw    #7, p3, [x13, x8, lsl #2]  // 10000101-00001000-11001101-10100111
// CHECK: prfw    #7, p3, [x13, x8, lsl #2] // encoding: [0xa7,0xcd,0x08,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00001000-11001101-10100111
PRFW    #7, P3, [X13, X8, LSL #2]  // 10000101-00001000-11001101-10100111
// CHECK: prfw    #7, p3, [x13, x8, lsl #2] // encoding: [0xa7,0xcd,0x08,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00001000-11001101-10100111
prfw    #15, p7, [sp, z31.s, uxtw #2]  // 10000100-00111111-01011111-11101111
// CHECK: prfw    #15, p7, [sp, z31.s, uxtw #2] // encoding: [0xef,0x5f,0x3f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00111111-01011111-11101111
PRFW    #15, P7, [SP, Z31.S, UXTW #2]  // 10000100-00111111-01011111-11101111
// CHECK: prfw    #15, p7, [sp, z31.s, uxtw #2] // encoding: [0xef,0x5f,0x3f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00111111-01011111-11101111
prfw    pldl3strm, p5, [z10.s, #84]  // 10000101-00010101-11110101-01000101
// CHECK: prfw    pldl3strm, p5, [z10.s, #84] // encoding: [0x45,0xf5,0x15,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00010101-11110101-01000101
PRFW    PLDL3STRM, P5, [Z10.S, #84]  // 10000101-00010101-11110101-01000101
// CHECK: prfw    pldl3strm, p5, [z10.s, #84] // encoding: [0x45,0xf5,0x15,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00010101-11110101-01000101
prfw    pldl3strm, p5, [x10, z21.d, lsl #2]  // 11000100-01110101-11010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, z21.d, lsl #2] // encoding: [0x45,0xd5,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-11010101-01000101
PRFW    PLDL3STRM, P5, [X10, Z21.D, LSL #2]  // 11000100-01110101-11010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, z21.d, lsl #2] // encoding: [0x45,0xd5,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-11010101-01000101
prfw    pldl3strm, p3, [x17, x16, lsl #2]  // 10000101-00010000-11001110-00100101
// CHECK: prfw    pldl3strm, p3, [x17, x16, lsl #2] // encoding: [0x25,0xce,0x10,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00010000-11001110-00100101
PRFW    PLDL3STRM, P3, [X17, X16, LSL #2]  // 10000101-00010000-11001110-00100101
// CHECK: prfw    pldl3strm, p3, [x17, x16, lsl #2] // encoding: [0x25,0xce,0x10,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00010000-11001110-00100101
prfw    #7, p3, [x13, z8.s, uxtw #2]  // 10000100-00101000-01001101-10100111
// CHECK: prfw    #7, p3, [x13, z8.s, uxtw #2] // encoding: [0xa7,0x4d,0x28,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00101000-01001101-10100111
PRFW    #7, P3, [X13, Z8.S, UXTW #2]  // 10000100-00101000-01001101-10100111
// CHECK: prfw    #7, p3, [x13, z8.s, uxtw #2] // encoding: [0xa7,0x4d,0x28,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00101000-01001101-10100111
prfw    #15, p7, [sp, z31.s, sxtw #2]  // 10000100-01111111-01011111-11101111
// CHECK: prfw    #15, p7, [sp, z31.s, sxtw #2] // encoding: [0xef,0x5f,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-01011111-11101111
PRFW    #15, P7, [SP, Z31.S, SXTW #2]  // 10000100-01111111-01011111-11101111
// CHECK: prfw    #15, p7, [sp, z31.s, sxtw #2] // encoding: [0xef,0x5f,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-01011111-11101111
prfw    #7, p3, [x13, #8, mul vl]  // 10000101-11001000-01001101-10100111
// CHECK: prfw    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x4d,0xc8,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11001000-01001101-10100111
PRFW    #7, P3, [X13, #8, MUL VL]  // 10000101-11001000-01001101-10100111
// CHECK: prfw    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x4d,0xc8,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11001000-01001101-10100111
prfw    #7, p3, [x13, z8.d, uxtw #2]  // 11000100-00101000-01001101-10100111
// CHECK: prfw    #7, p3, [x13, z8.d, uxtw #2] // encoding: [0xa7,0x4d,0x28,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00101000-01001101-10100111
PRFW    #7, P3, [X13, Z8.D, UXTW #2]  // 11000100-00101000-01001101-10100111
// CHECK: prfw    #7, p3, [x13, z8.d, uxtw #2] // encoding: [0xa7,0x4d,0x28,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00101000-01001101-10100111
prfw    #7, p3, [x13, z8.s, sxtw #2]  // 10000100-01101000-01001101-10100111
// CHECK: prfw    #7, p3, [x13, z8.s, sxtw #2] // encoding: [0xa7,0x4d,0x68,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01101000-01001101-10100111
PRFW    #7, P3, [X13, Z8.S, SXTW #2]  // 10000100-01101000-01001101-10100111
// CHECK: prfw    #7, p3, [x13, z8.s, sxtw #2] // encoding: [0xa7,0x4d,0x68,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01101000-01001101-10100111
prfw    pldl3strm, p5, [x10, #21, mul vl]  // 10000101-11010101-01010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x55,0xd5,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11010101-01010101-01000101
PRFW    PLDL3STRM, P5, [X10, #21, MUL VL]  // 10000101-11010101-01010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x55,0xd5,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11010101-01010101-01000101
prfw    pldl3strm, p5, [x10, z21.d, sxtw #2]  // 11000100-01110101-01010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, z21.d, sxtw #2] // encoding: [0x45,0x55,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-01010101-01000101
PRFW    PLDL3STRM, P5, [X10, Z21.D, SXTW #2]  // 11000100-01110101-01010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, z21.d, sxtw #2] // encoding: [0x45,0x55,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-01010101-01000101
prfw    pldl3strm, p5, [x10, x21, lsl #2]  // 10000101-00010101-11010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, x21, lsl #2] // encoding: [0x45,0xd5,0x15,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00010101-11010101-01000101
PRFW    PLDL3STRM, P5, [X10, X21, LSL #2]  // 10000101-00010101-11010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, x21, lsl #2] // encoding: [0x45,0xd5,0x15,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00010101-11010101-01000101
prfw    pldl1keep, p0, [x0, z0.d, lsl #2]  // 11000100-01100000-11000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, z0.d, lsl #2] // encoding: [0x00,0xc0,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-11000000-00000000
PRFW    PLDL1KEEP, P0, [X0, Z0.D, LSL #2]  // 11000100-01100000-11000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, z0.d, lsl #2] // encoding: [0x00,0xc0,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-11000000-00000000
prfw    pldl3strm, p5, [x10, z21.s, uxtw #2]  // 10000100-00110101-01010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, z21.s, uxtw #2] // encoding: [0x45,0x55,0x35,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00110101-01010101-01000101
PRFW    PLDL3STRM, P5, [X10, Z21.S, UXTW #2]  // 10000100-00110101-01010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, z21.s, uxtw #2] // encoding: [0x45,0x55,0x35,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00110101-01010101-01000101
prfw    #15, p7, [sp, z31.d, sxtw #2]  // 11000100-01111111-01011111-11101111
// CHECK: prfw    #15, p7, [sp, z31.d, sxtw #2] // encoding: [0xef,0x5f,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-01011111-11101111
PRFW    #15, P7, [SP, Z31.D, SXTW #2]  // 11000100-01111111-01011111-11101111
// CHECK: prfw    #15, p7, [sp, z31.d, sxtw #2] // encoding: [0xef,0x5f,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-01011111-11101111
prfw    pldl1keep, p0, [x0, z0.d, uxtw #2]  // 11000100-00100000-01000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, z0.d, uxtw #2] // encoding: [0x00,0x40,0x20,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00100000-01000000-00000000
PRFW    PLDL1KEEP, P0, [X0, Z0.D, UXTW #2]  // 11000100-00100000-01000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, z0.d, uxtw #2] // encoding: [0x00,0x40,0x20,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00100000-01000000-00000000
prfw    #7, p3, [z13.s, #32]  // 10000101-00001000-11101101-10100111
// CHECK: prfw    #7, p3, [z13.s, #32] // encoding: [0xa7,0xed,0x08,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00001000-11101101-10100111
PRFW    #7, P3, [Z13.S, #32]  // 10000101-00001000-11101101-10100111
// CHECK: prfw    #7, p3, [z13.s, #32] // encoding: [0xa7,0xed,0x08,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00001000-11101101-10100111
prfw    #15, p7, [sp, #-1, mul vl]  // 10000101-11111111-01011111-11101111
// CHECK: prfw    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x5f,0xff,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11111111-01011111-11101111
PRFW    #15, P7, [SP, #-1, MUL VL]  // 10000101-11111111-01011111-11101111
// CHECK: prfw    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x5f,0xff,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11111111-01011111-11101111
prfw    pldl1keep, p0, [x0, z0.s, sxtw #2]  // 10000100-01100000-01000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, z0.s, sxtw #2] // encoding: [0x00,0x40,0x60,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01100000-01000000-00000000
PRFW    PLDL1KEEP, P0, [X0, Z0.S, SXTW #2]  // 10000100-01100000-01000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, z0.s, sxtw #2] // encoding: [0x00,0x40,0x60,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01100000-01000000-00000000
prfw    #15, p7, [sp, z31.d, uxtw #2]  // 11000100-00111111-01011111-11101111
// CHECK: prfw    #15, p7, [sp, z31.d, uxtw #2] // encoding: [0xef,0x5f,0x3f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00111111-01011111-11101111
PRFW    #15, P7, [SP, Z31.D, UXTW #2]  // 11000100-00111111-01011111-11101111
// CHECK: prfw    #15, p7, [sp, z31.d, uxtw #2] // encoding: [0xef,0x5f,0x3f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00111111-01011111-11101111
prfw    pldl1keep, p0, [z0.s]  // 10000101-00000000-11100000-00000000
// CHECK: prfw    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x00,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00000000-11100000-00000000
PRFW    PLDL1KEEP, P0, [Z0.S]  // 10000101-00000000-11100000-00000000
// CHECK: prfw    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x00,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00000000-11100000-00000000
prfw    #7, p3, [x13, z8.d, sxtw #2]  // 11000100-01101000-01001101-10100111
// CHECK: prfw    #7, p3, [x13, z8.d, sxtw #2] // encoding: [0xa7,0x4d,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-01001101-10100111
PRFW    #7, P3, [X13, Z8.D, SXTW #2]  // 11000100-01101000-01001101-10100111
// CHECK: prfw    #7, p3, [x13, z8.d, sxtw #2] // encoding: [0xa7,0x4d,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-01001101-10100111
prfw    #7, p3, [z13.d, #32]  // 11000101-00001000-11101101-10100111
// CHECK: prfw    #7, p3, [z13.d, #32] // encoding: [0xa7,0xed,0x08,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00001000-11101101-10100111
PRFW    #7, P3, [Z13.D, #32]  // 11000101-00001000-11101101-10100111
// CHECK: prfw    #7, p3, [z13.d, #32] // encoding: [0xa7,0xed,0x08,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00001000-11101101-10100111
prfw    pldl1keep, p0, [x0]  // 10000101-11000000-01000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0] // encoding: [0x00,0x40,0xc0,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11000000-01000000-00000000
PRFW    PLDL1KEEP, P0, [X0]  // 10000101-11000000-01000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0] // encoding: [0x00,0x40,0xc0,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11000000-01000000-00000000
prfw    #15, p7, [z31.s, #124]  // 10000101-00011111-11111111-11101111
// CHECK: prfw    #15, p7, [z31.s, #124] // encoding: [0xef,0xff,0x1f,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00011111-11111111-11101111
PRFW    #15, P7, [Z31.S, #124]  // 10000101-00011111-11111111-11101111
// CHECK: prfw    #15, p7, [z31.s, #124] // encoding: [0xef,0xff,0x1f,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-00011111-11111111-11101111
prfw    #7, p3, [x13, z8.d, lsl #2]  // 11000100-01101000-11001101-10100111
// CHECK: prfw    #7, p3, [x13, z8.d, lsl #2] // encoding: [0xa7,0xcd,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-11001101-10100111
PRFW    #7, P3, [X13, Z8.D, LSL #2]  // 11000100-01101000-11001101-10100111
// CHECK: prfw    #7, p3, [x13, z8.d, lsl #2] // encoding: [0xa7,0xcd,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-11001101-10100111
