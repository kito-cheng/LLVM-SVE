// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfb    pldl3strm, p3, [x17, x16]  // 10000100-00010000-11001110-00100101
// CHECK: prfb    pldl3strm, p3, [x17, x16] // encoding: [0x25,0xce,0x10,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00010000-11001110-00100101
PRFB    PLDL3STRM, P3, [X17, X16]  // 10000100-00010000-11001110-00100101
// CHECK: prfb    pldl3strm, p3, [x17, x16] // encoding: [0x25,0xce,0x10,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00010000-11001110-00100101
prfb    #15, p7, [z31.s, #31]  // 10000100-00011111-11111111-11101111
// CHECK: prfb    #15, p7, [z31.s, #31] // encoding: [0xef,0xff,0x1f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00011111-11111111-11101111
PRFB    #15, P7, [Z31.S, #31]  // 10000100-00011111-11111111-11101111
// CHECK: prfb    #15, p7, [z31.s, #31] // encoding: [0xef,0xff,0x1f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00011111-11111111-11101111
prfb    pldl1keep, p0, [x0, z0.d, sxtw]  // 11000100-01100000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.d, sxtw] // encoding: [0x00,0x00,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-00000000-00000000
PRFB    PLDL1KEEP, P0, [X0, Z0.D, SXTW]  // 11000100-01100000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.d, sxtw] // encoding: [0x00,0x00,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-00000000-00000000
prfb    #15, p7, [z31.d, #31]  // 11000100-00011111-11111111-11101111
// CHECK: prfb    #15, p7, [z31.d, #31] // encoding: [0xef,0xff,0x1f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00011111-11111111-11101111
PRFB    #15, P7, [Z31.D, #31]  // 11000100-00011111-11111111-11101111
// CHECK: prfb    #15, p7, [z31.d, #31] // encoding: [0xef,0xff,0x1f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00011111-11111111-11101111
prfb    pldl3strm, p5, [x10, z21.d]  // 11000100-01110101-10010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.d] // encoding: [0x45,0x95,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-10010101-01000101
PRFB    PLDL3STRM, P5, [X10, Z21.D]  // 11000100-01110101-10010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.d] // encoding: [0x45,0x95,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-10010101-01000101
prfb    #7, p3, [z13.d, #8]  // 11000100-00001000-11101101-10100111
// CHECK: prfb    #7, p3, [z13.d, #8] // encoding: [0xa7,0xed,0x08,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00001000-11101101-10100111
PRFB    #7, P3, [Z13.D, #8]  // 11000100-00001000-11101101-10100111
// CHECK: prfb    #7, p3, [z13.d, #8] // encoding: [0xa7,0xed,0x08,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00001000-11101101-10100111
prfb    pldl1keep, p0, [x0, z0.s, uxtw]  // 10000100-00100000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x00,0x20,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00100000-00000000-00000000
PRFB    PLDL1KEEP, P0, [X0, Z0.S, UXTW]  // 10000100-00100000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x00,0x20,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00100000-00000000-00000000
prfb    #15, p7, [sp, #-1, mul vl]  // 10000101-11111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x1f,0xff,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11111111-00011111-11101111
PRFB    #15, P7, [SP, #-1, MUL VL]  // 10000101-11111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x1f,0xff,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11111111-00011111-11101111
prfb    pldl3strm, p5, [x10, z21.d, sxtw]  // 11000100-01110101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.d, sxtw] // encoding: [0x45,0x15,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-00010101-01000101
PRFB    PLDL3STRM, P5, [X10, Z21.D, SXTW]  // 11000100-01110101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.d, sxtw] // encoding: [0x45,0x15,0x75,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01110101-00010101-01000101
prfb    #15, p7, [sp, z31.d, sxtw]  // 11000100-01111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.d, sxtw] // encoding: [0xef,0x1f,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-00011111-11101111
PRFB    #15, P7, [SP, Z31.D, SXTW]  // 11000100-01111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.d, sxtw] // encoding: [0xef,0x1f,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-00011111-11101111
prfb    pldl1keep, p0, [z0.d]  // 11000100-00000000-11100000-00000000
// CHECK: prfb    pldl1keep, p0, [z0.d] // encoding: [0x00,0xe0,0x00,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00000000-11100000-00000000
PRFB    PLDL1KEEP, P0, [Z0.D]  // 11000100-00000000-11100000-00000000
// CHECK: prfb    pldl1keep, p0, [z0.d] // encoding: [0x00,0xe0,0x00,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00000000-11100000-00000000
prfb    pldl3strm, p5, [x10, z21.s, uxtw]  // 10000100-00110101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.s, uxtw] // encoding: [0x45,0x15,0x35,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00110101-00010101-01000101
PRFB    PLDL3STRM, P5, [X10, Z21.S, UXTW]  // 10000100-00110101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.s, uxtw] // encoding: [0x45,0x15,0x35,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00110101-00010101-01000101
prfb    #15, p7, [sp, z31.s, uxtw]  // 10000100-00111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.s, uxtw] // encoding: [0xef,0x1f,0x3f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00111111-00011111-11101111
PRFB    #15, P7, [SP, Z31.S, UXTW]  // 10000100-00111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.s, uxtw] // encoding: [0xef,0x1f,0x3f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00111111-00011111-11101111
prfb    pldl1keep, p0, [x0, z0.d, uxtw]  // 11000100-00100000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x00,0x20,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00100000-00000000-00000000
PRFB    PLDL1KEEP, P0, [X0, Z0.D, UXTW]  // 11000100-00100000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x00,0x20,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00100000-00000000-00000000
prfb    pldl1keep, p0, [x0, z0.s, sxtw]  // 10000100-01100000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.s, sxtw] // encoding: [0x00,0x00,0x60,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01100000-00000000-00000000
PRFB    PLDL1KEEP, P0, [X0, Z0.S, SXTW]  // 10000100-01100000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.s, sxtw] // encoding: [0x00,0x00,0x60,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01100000-00000000-00000000
prfb    pldl1keep, p0, [x0, z0.d]  // 11000100-01100000-10000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.d] // encoding: [0x00,0x80,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-10000000-00000000
PRFB    PLDL1KEEP, P0, [X0, Z0.D]  // 11000100-01100000-10000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.d] // encoding: [0x00,0x80,0x60,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01100000-10000000-00000000
prfb    pldl3strm, p5, [x10, #21, mul vl]  // 10000101-11010101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x15,0xd5,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11010101-00010101-01000101
PRFB    PLDL3STRM, P5, [X10, #21, MUL VL]  // 10000101-11010101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x15,0xd5,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11010101-00010101-01000101
prfb    #7, p3, [x13, z8.d, uxtw]  // 11000100-00101000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.d, uxtw] // encoding: [0xa7,0x0d,0x28,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00101000-00001101-10100111
PRFB    #7, P3, [X13, Z8.D, UXTW]  // 11000100-00101000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.d, uxtw] // encoding: [0xa7,0x0d,0x28,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00101000-00001101-10100111
prfb    pldl1keep, p0, [z0.s]  // 10000100-00000000-11100000-00000000
// CHECK: prfb    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x00,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00000000-11100000-00000000
PRFB    PLDL1KEEP, P0, [Z0.S]  // 10000100-00000000-11100000-00000000
// CHECK: prfb    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x00,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00000000-11100000-00000000
prfb    #15, p7, [sp, z31.d]  // 11000100-01111111-10011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.d] // encoding: [0xef,0x9f,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-10011111-11101111
PRFB    #15, P7, [SP, Z31.D]  // 11000100-01111111-10011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.d] // encoding: [0xef,0x9f,0x7f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01111111-10011111-11101111
prfb    #7, p3, [x13, x8]  // 10000100-00001000-11001101-10100111
// CHECK: prfb    #7, p3, [x13, x8] // encoding: [0xa7,0xcd,0x08,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00001000-11001101-10100111
PRFB    #7, P3, [X13, X8]  // 10000100-00001000-11001101-10100111
// CHECK: prfb    #7, p3, [x13, x8] // encoding: [0xa7,0xcd,0x08,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00001000-11001101-10100111
prfb    #7, p3, [z13.s, #8]  // 10000100-00001000-11101101-10100111
// CHECK: prfb    #7, p3, [z13.s, #8] // encoding: [0xa7,0xed,0x08,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00001000-11101101-10100111
PRFB    #7, P3, [Z13.S, #8]  // 10000100-00001000-11101101-10100111
// CHECK: prfb    #7, p3, [z13.s, #8] // encoding: [0xa7,0xed,0x08,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00001000-11101101-10100111
prfb    pldl1keep, p0, [x0]  // 10000101-11000000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0] // encoding: [0x00,0x00,0xc0,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11000000-00000000-00000000
PRFB    PLDL1KEEP, P0, [X0]  // 10000101-11000000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0] // encoding: [0x00,0x00,0xc0,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11000000-00000000-00000000
prfb    pldl1keep, p0, [x0, x0]  // 10000100-00000000-11000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, x0] // encoding: [0x00,0xc0,0x00,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00000000-11000000-00000000
PRFB    PLDL1KEEP, P0, [X0, X0]  // 10000100-00000000-11000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, x0] // encoding: [0x00,0xc0,0x00,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00000000-11000000-00000000
prfb    pldl3strm, p5, [x10, z21.d, uxtw]  // 11000100-00110101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.d, uxtw] // encoding: [0x45,0x15,0x35,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00110101-00010101-01000101
PRFB    PLDL3STRM, P5, [X10, Z21.D, UXTW]  // 11000100-00110101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.d, uxtw] // encoding: [0x45,0x15,0x35,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00110101-00010101-01000101
prfb    #7, p3, [x13, #8, mul vl]  // 10000101-11001000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x0d,0xc8,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11001000-00001101-10100111
PRFB    #7, P3, [X13, #8, MUL VL]  // 10000101-11001000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x0d,0xc8,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11001000-00001101-10100111
prfb    pldl3strm, p5, [x10, z21.s, sxtw]  // 10000100-01110101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.s, sxtw] // encoding: [0x45,0x15,0x75,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01110101-00010101-01000101
PRFB    PLDL3STRM, P5, [X10, Z21.S, SXTW]  // 10000100-01110101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.s, sxtw] // encoding: [0x45,0x15,0x75,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01110101-00010101-01000101
prfb    #7, p3, [x13, z8.d]  // 11000100-01101000-10001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.d] // encoding: [0xa7,0x8d,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-10001101-10100111
PRFB    #7, P3, [X13, Z8.D]  // 11000100-01101000-10001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.d] // encoding: [0xa7,0x8d,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-10001101-10100111
prfb    #15, p7, [sp, z31.d, uxtw]  // 11000100-00111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.d, uxtw] // encoding: [0xef,0x1f,0x3f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00111111-00011111-11101111
PRFB    #15, P7, [SP, Z31.D, UXTW]  // 11000100-00111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.d, uxtw] // encoding: [0xef,0x1f,0x3f,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00111111-00011111-11101111
prfb    #15, p7, [sp, z31.s, sxtw]  // 10000100-01111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.s, sxtw] // encoding: [0xef,0x1f,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-00011111-11101111
PRFB    #15, P7, [SP, Z31.S, SXTW]  // 10000100-01111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.s, sxtw] // encoding: [0xef,0x1f,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-00011111-11101111
prfb    #7, p3, [x13, z8.d, sxtw]  // 11000100-01101000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.d, sxtw] // encoding: [0xa7,0x0d,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-00001101-10100111
PRFB    #7, P3, [X13, Z8.D, SXTW]  // 11000100-01101000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.d, sxtw] // encoding: [0xa7,0x0d,0x68,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-01101000-00001101-10100111
prfb    pldl3strm, p5, [x10, x21]  // 10000100-00010101-11010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, x21] // encoding: [0x45,0xd5,0x15,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00010101-11010101-01000101
PRFB    PLDL3STRM, P5, [X10, X21]  // 10000100-00010101-11010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, x21] // encoding: [0x45,0xd5,0x15,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00010101-11010101-01000101
prfb    #7, p3, [x13, z8.s, sxtw]  // 10000100-01101000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.s, sxtw] // encoding: [0xa7,0x0d,0x68,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01101000-00001101-10100111
PRFB    #7, P3, [X13, Z8.S, SXTW]  // 10000100-01101000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.s, sxtw] // encoding: [0xa7,0x0d,0x68,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01101000-00001101-10100111
prfb    #7, p3, [x13, z8.s, uxtw]  // 10000100-00101000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.s, uxtw] // encoding: [0xa7,0x0d,0x28,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00101000-00001101-10100111
PRFB    #7, P3, [X13, Z8.S, UXTW]  // 10000100-00101000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.s, uxtw] // encoding: [0xa7,0x0d,0x28,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00101000-00001101-10100111
prfb    pldl3strm, p5, [z10.s, #21]  // 10000100-00010101-11110101-01000101
// CHECK: prfb    pldl3strm, p5, [z10.s, #21] // encoding: [0x45,0xf5,0x15,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00010101-11110101-01000101
PRFB    PLDL3STRM, P5, [Z10.S, #21]  // 10000100-00010101-11110101-01000101
// CHECK: prfb    pldl3strm, p5, [z10.s, #21] // encoding: [0x45,0xf5,0x15,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-00010101-11110101-01000101
prfb    pldl3strm, p5, [z10.d, #21]  // 11000100-00010101-11110101-01000101
// CHECK: prfb    pldl3strm, p5, [z10.d, #21] // encoding: [0x45,0xf5,0x15,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00010101-11110101-01000101
PRFB    PLDL3STRM, P5, [Z10.D, #21]  // 11000100-00010101-11110101-01000101
// CHECK: prfb    pldl3strm, p5, [z10.d, #21] // encoding: [0x45,0xf5,0x15,0xc4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000100-00010101-11110101-01000101
