// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cpy     z31.d, p15/m, #-1, lsl #8  // 00000101-11011111-01111111-11111111
// CHECK: mov     z31.d, p15/m, #-256 // encoding: [0xff,0x7f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01111111-11111111
CPY     Z31.D, P15/M, #-1, LSL #8  // 00000101-11011111-01111111-11111111
// CHECK: mov     z31.d, p15/m, #-256 // encoding: [0xff,0x7f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01111111-11111111
cpy     z31.d, p15/m, #-256  // 00000101-11011111-01111111-11111111
// CHECK: mov     z31.d, p15/m, #-256 // encoding: [0xff,0x7f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01111111-11111111
CPY     Z31.D, P15/M, #-256  // 00000101-11011111-01111111-11111111
// CHECK: mov     z31.d, p15/m, #-256 // encoding: [0xff,0x7f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01111111-11111111
cpy     z0.s, p0/m, w0  // 00000101-10101000-10100000-00000000
// CHECK: mov     z0.s, p0/m, w0 // encoding: [0x00,0xa0,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10100000-00000000
CPY     Z0.S, P0/M, W0  // 00000101-10101000-10100000-00000000
// CHECK: mov     z0.s, p0/m, w0 // encoding: [0x00,0xa0,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10100000-00000000
cpy     z21.s, p5/m, s10  // 00000101-10100000-10010101-01010101
// CHECK: mov     z21.s, p5/m, s10 // encoding: [0x55,0x95,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10010101-01010101
CPY     Z21.S, P5/M, S10  // 00000101-10100000-10010101-01010101
// CHECK: mov     z21.s, p5/m, s10 // encoding: [0x55,0x95,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10010101-01010101
cpy     z31.s, p7/m, s31  // 00000101-10100000-10011111-11111111
// CHECK: mov     z31.s, p7/m, s31 // encoding: [0xff,0x9f,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10011111-11111111
CPY     Z31.S, P7/M, S31  // 00000101-10100000-10011111-11111111
// CHECK: mov     z31.s, p7/m, s31 // encoding: [0xff,0x9f,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10011111-11111111
cpy     z31.d, p15/m, #0  // 00000101-11011111-01000000-00011111
// CHECK: mov     z31.d, p15/m, #0 // encoding: [0x1f,0x40,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01000000-00011111
CPY     Z31.D, P15/M, #0  // 00000101-11011111-01000000-00011111
// CHECK: mov     z31.d, p15/m, #0 // encoding: [0x1f,0x40,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01000000-00011111
cpy     z23.s, p8/m, #0  // 00000101-10011000-01000000-00010111
// CHECK: mov     z23.s, p8/m, #0 // encoding: [0x17,0x40,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01000000-00010111
CPY     Z23.S, P8/M, #0  // 00000101-10011000-01000000-00010111
// CHECK: mov     z23.s, p8/m, #0 // encoding: [0x17,0x40,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01000000-00010111
cpy     z5.b, p0/z, #113  // 00000101-00010000-00001110-00100101
// CHECK: mov     z5.b, p0/z, #113 // encoding: [0x25,0x0e,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-00001110-00100101
CPY     Z5.B, P0/Z, #113  // 00000101-00010000-00001110-00100101
// CHECK: mov     z5.b, p0/z, #113 // encoding: [0x25,0x0e,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-00001110-00100101
cpy     z0.s, p0/m, #0  // 00000101-10010000-01000000-00000000
// CHECK: mov     z0.s, p0/m, #0 // encoding: [0x00,0x40,0x90,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010000-01000000-00000000
CPY     Z0.S, P0/M, #0  // 00000101-10010000-01000000-00000000
// CHECK: mov     z0.s, p0/m, #0 // encoding: [0x00,0x40,0x90,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010000-01000000-00000000
cpy     z5.b, p0/m, #113  // 00000101-00010000-01001110-00100101
// CHECK: mov     z5.b, p0/m, #113 // encoding: [0x25,0x4e,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-01001110-00100101
CPY     Z5.B, P0/M, #113  // 00000101-00010000-01001110-00100101
// CHECK: mov     z5.b, p0/m, #113 // encoding: [0x25,0x4e,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-01001110-00100101
cpy     z31.h, p15/m, #-1, lsl #8  // 00000101-01011111-01111111-11111111
// CHECK: mov     z31.h, p15/m, #-256 // encoding: [0xff,0x7f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01111111-11111111
CPY     Z31.H, P15/M, #-1, LSL #8  // 00000101-01011111-01111111-11111111
// CHECK: mov     z31.h, p15/m, #-256 // encoding: [0xff,0x7f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01111111-11111111
cpy     z31.h, p15/m, #-256  // 00000101-01011111-01111111-11111111
// CHECK: mov     z31.h, p15/m, #-256 // encoding: [0xff,0x7f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01111111-11111111
CPY     Z31.H, P15/M, #-256  // 00000101-01011111-01111111-11111111
// CHECK: mov     z31.h, p15/m, #-256 // encoding: [0xff,0x7f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01111111-11111111
cpy     z21.s, p5/m, w10  // 00000101-10101000-10110101-01010101
// CHECK: mov     z21.s, p5/m, w10 // encoding: [0x55,0xb5,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10110101-01010101
CPY     Z21.S, P5/M, W10  // 00000101-10101000-10110101-01010101
// CHECK: mov     z21.s, p5/m, w10 // encoding: [0x55,0xb5,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10110101-01010101
cpy     z21.h, p5/m, #-86  // 00000101-01010101-01010101-01010101
// CHECK: mov     z21.h, p5/m, #-86 // encoding: [0x55,0x55,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-01010101-01010101
CPY     Z21.H, P5/M, #-86  // 00000101-01010101-01010101-01010101
// CHECK: mov     z21.h, p5/m, #-86 // encoding: [0x55,0x55,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-01010101-01010101
cpy     z31.s, p7/m, wsp  // 00000101-10101000-10111111-11111111
// CHECK: mov     z31.s, p7/m, wsp // encoding: [0xff,0xbf,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10111111-11111111
CPY     Z31.S, P7/M, WSP  // 00000101-10101000-10111111-11111111
// CHECK: mov     z31.s, p7/m, wsp // encoding: [0xff,0xbf,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10111111-11111111
cpy     z31.h, p7/m, wsp  // 00000101-01101000-10111111-11111111
// CHECK: mov     z31.h, p7/m, wsp // encoding: [0xff,0xbf,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10111111-11111111
CPY     Z31.H, P7/M, WSP  // 00000101-01101000-10111111-11111111
// CHECK: mov     z31.h, p7/m, wsp // encoding: [0xff,0xbf,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10111111-11111111
cpy     z31.b, p7/m, wsp  // 00000101-00101000-10111111-11111111
// CHECK: mov     z31.b, p7/m, wsp // encoding: [0xff,0xbf,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10111111-11111111
CPY     Z31.B, P7/M, WSP  // 00000101-00101000-10111111-11111111
// CHECK: mov     z31.b, p7/m, wsp // encoding: [0xff,0xbf,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10111111-11111111
cpy     z23.h, p3/m, w13  // 00000101-01101000-10101101-10110111
// CHECK: mov     z23.h, p3/m, w13 // encoding: [0xb7,0xad,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10101101-10110111
CPY     Z23.H, P3/M, W13  // 00000101-01101000-10101101-10110111
// CHECK: mov     z23.h, p3/m, w13 // encoding: [0xb7,0xad,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10101101-10110111
cpy     z21.d, p5/m, d10  // 00000101-11100000-10010101-01010101
// CHECK: mov     z21.d, p5/m, d10 // encoding: [0x55,0x95,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10010101-01010101
CPY     Z21.D, P5/M, D10  // 00000101-11100000-10010101-01010101
// CHECK: mov     z21.d, p5/m, d10 // encoding: [0x55,0x95,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10010101-01010101
cpy     z23.h, p3/m, h13  // 00000101-01100000-10001101-10110111
// CHECK: mov     z23.h, p3/m, h13 // encoding: [0xb7,0x8d,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10001101-10110111
CPY     Z23.H, P3/M, H13  // 00000101-01100000-10001101-10110111
// CHECK: mov     z23.h, p3/m, h13 // encoding: [0xb7,0x8d,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10001101-10110111
cpy     z23.s, p8/z, #109, lsl #8  // 00000101-10011000-00101101-10110111
// CHECK: mov     z23.s, p8/z, #27904 // encoding: [0xb7,0x2d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-00101101-10110111
CPY     Z23.S, P8/Z, #109, LSL #8  // 00000101-10011000-00101101-10110111
// CHECK: mov     z23.s, p8/z, #27904 // encoding: [0xb7,0x2d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-00101101-10110111
cpy     z23.s, p8/z, #27904  // 00000101-10011000-00101101-10110111
// CHECK: mov     z23.s, p8/z, #27904 // encoding: [0xb7,0x2d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-00101101-10110111
CPY     Z23.S, P8/Z, #27904  // 00000101-10011000-00101101-10110111
// CHECK: mov     z23.s, p8/z, #27904 // encoding: [0xb7,0x2d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-00101101-10110111
cpy     z21.d, p5/m, #-86  // 00000101-11010101-01010101-01010101
// CHECK: mov     z21.d, p5/m, #-86 // encoding: [0x55,0x55,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-01010101-01010101
CPY     Z21.D, P5/M, #-86  // 00000101-11010101-01010101-01010101
// CHECK: mov     z21.d, p5/m, #-86 // encoding: [0x55,0x55,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-01010101-01010101
cpy     z21.h, p5/z, #-86  // 00000101-01010101-00010101-01010101
// CHECK: mov     z21.h, p5/z, #-86 // encoding: [0x55,0x15,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-00010101-01010101
CPY     Z21.H, P5/Z, #-86  // 00000101-01010101-00010101-01010101
// CHECK: mov     z21.h, p5/z, #-86 // encoding: [0x55,0x15,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-00010101-01010101
cpy     z1.b, p14/z, #33  // 00000101-00011110-00000100-00100001
// CHECK: mov     z1.b, p14/z, #33 // encoding: [0x21,0x04,0x1e,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00011110-00000100-00100001
CPY     Z1.B, P14/Z, #33  // 00000101-00011110-00000100-00100001
// CHECK: mov     z1.b, p14/z, #33 // encoding: [0x21,0x04,0x1e,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00011110-00000100-00100001
cpy     z0.h, p0/m, w0  // 00000101-01101000-10100000-00000000
// CHECK: mov     z0.h, p0/m, w0 // encoding: [0x00,0xa0,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10100000-00000000
CPY     Z0.H, P0/M, W0  // 00000101-01101000-10100000-00000000
// CHECK: mov     z0.h, p0/m, w0 // encoding: [0x00,0xa0,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10100000-00000000
cpy     z31.b, p7/m, b31  // 00000101-00100000-10011111-11111111
// CHECK: mov     z31.b, p7/m, b31 // encoding: [0xff,0x9f,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10011111-11111111
CPY     Z31.B, P7/M, B31  // 00000101-00100000-10011111-11111111
// CHECK: mov     z31.b, p7/m, b31 // encoding: [0xff,0x9f,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10011111-11111111
cpy     z23.d, p3/m, x13  // 00000101-11101000-10101101-10110111
// CHECK: mov     z23.d, p3/m, x13 // encoding: [0xb7,0xad,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10101101-10110111
CPY     Z23.D, P3/M, X13  // 00000101-11101000-10101101-10110111
// CHECK: mov     z23.d, p3/m, x13 // encoding: [0xb7,0xad,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10101101-10110111
cpy     z0.d, p0/z, #0  // 00000101-11010000-00000000-00000000
// CHECK: mov     z0.d, p0/z, #0 // encoding: [0x00,0x00,0xd0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010000-00000000-00000000
CPY     Z0.D, P0/Z, #0  // 00000101-11010000-00000000-00000000
// CHECK: mov     z0.d, p0/z, #0 // encoding: [0x00,0x00,0xd0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010000-00000000-00000000
cpy     z21.s, p5/m, #-86  // 00000101-10010101-01010101-01010101
// CHECK: mov     z21.s, p5/m, #-86 // encoding: [0x55,0x55,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-01010101-01010101
CPY     Z21.S, P5/M, #-86  // 00000101-10010101-01010101-01010101
// CHECK: mov     z21.s, p5/m, #-86 // encoding: [0x55,0x55,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-01010101-01010101
cpy     z21.b, p5/m, b10  // 00000101-00100000-10010101-01010101
// CHECK: mov     z21.b, p5/m, b10 // encoding: [0x55,0x95,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10010101-01010101
CPY     Z21.B, P5/M, B10  // 00000101-00100000-10010101-01010101
// CHECK: mov     z21.b, p5/m, b10 // encoding: [0x55,0x95,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10010101-01010101
cpy     z0.s, p0/z, #0  // 00000101-10010000-00000000-00000000
// CHECK: mov     z0.s, p0/z, #0 // encoding: [0x00,0x00,0x90,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010000-00000000-00000000
CPY     Z0.S, P0/Z, #0  // 00000101-10010000-00000000-00000000
// CHECK: mov     z0.s, p0/z, #0 // encoding: [0x00,0x00,0x90,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010000-00000000-00000000
cpy     z31.d, p7/m, d31  // 00000101-11100000-10011111-11111111
// CHECK: mov     z31.d, p7/m, d31 // encoding: [0xff,0x9f,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10011111-11111111
CPY     Z31.D, P7/M, D31  // 00000101-11100000-10011111-11111111
// CHECK: mov     z31.d, p7/m, d31 // encoding: [0xff,0x9f,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10011111-11111111
cpy     z23.d, p8/m, #109, lsl #8  // 00000101-11011000-01101101-10110111
// CHECK: mov     z23.d, p8/m, #27904 // encoding: [0xb7,0x6d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01101101-10110111
CPY     Z23.D, P8/M, #109, LSL #8  // 00000101-11011000-01101101-10110111
// CHECK: mov     z23.d, p8/m, #27904 // encoding: [0xb7,0x6d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01101101-10110111
cpy     z23.d, p8/m, #27904  // 00000101-11011000-01101101-10110111
// CHECK: mov     z23.d, p8/m, #27904 // encoding: [0xb7,0x6d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01101101-10110111
CPY     Z23.D, P8/M, #27904  // 00000101-11011000-01101101-10110111
// CHECK: mov     z23.d, p8/m, #27904 // encoding: [0xb7,0x6d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01101101-10110111
cpy     z23.d, p8/m, #0  // 00000101-11011000-01000000-00010111
// CHECK: mov     z23.d, p8/m, #0 // encoding: [0x17,0x40,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01000000-00010111
CPY     Z23.D, P8/M, #0  // 00000101-11011000-01000000-00010111
// CHECK: mov     z23.d, p8/m, #0 // encoding: [0x17,0x40,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01000000-00010111
cpy     z31.d, p15/z, #-1, lsl #8  // 00000101-11011111-00111111-11111111
// CHECK: mov     z31.d, p15/z, #-256 // encoding: [0xff,0x3f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-00111111-11111111
CPY     Z31.D, P15/Z, #-1, LSL #8  // 00000101-11011111-00111111-11111111
// CHECK: mov     z31.d, p15/z, #-256 // encoding: [0xff,0x3f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-00111111-11111111
cpy     z31.d, p15/z, #-256  // 00000101-11011111-00111111-11111111
// CHECK: mov     z31.d, p15/z, #-256 // encoding: [0xff,0x3f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-00111111-11111111
CPY     Z31.D, P15/Z, #-256  // 00000101-11011111-00111111-11111111
// CHECK: mov     z31.d, p15/z, #-256 // encoding: [0xff,0x3f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-00111111-11111111
cpy     z21.b, p5/m, #-86  // 00000101-00010101-01010101-01010101
// CHECK: mov     z21.b, p5/m, #-86 // encoding: [0x55,0x55,0x15,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010101-01010101-01010101
CPY     Z21.B, P5/M, #-86  // 00000101-00010101-01010101-01010101
// CHECK: mov     z21.b, p5/m, #-86 // encoding: [0x55,0x55,0x15,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010101-01010101-01010101
cpy     z23.h, p8/m, #0  // 00000101-01011000-01000000-00010111
// CHECK: mov     z23.h, p8/m, #0 // encoding: [0x17,0x40,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01000000-00010111
CPY     Z23.H, P8/M, #0  // 00000101-01011000-01000000-00010111
// CHECK: mov     z23.h, p8/m, #0 // encoding: [0x17,0x40,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01000000-00010111
cpy     z21.b, p5/m, w10  // 00000101-00101000-10110101-01010101
// CHECK: mov     z21.b, p5/m, w10 // encoding: [0x55,0xb5,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10110101-01010101
CPY     Z21.B, P5/M, W10  // 00000101-00101000-10110101-01010101
// CHECK: mov     z21.b, p5/m, w10 // encoding: [0x55,0xb5,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10110101-01010101
cpy     z0.b, p0/m, b0  // 00000101-00100000-10000000-00000000
// CHECK: mov     z0.b, p0/m, b0 // encoding: [0x00,0x80,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10000000-00000000
CPY     Z0.B, P0/M, B0  // 00000101-00100000-10000000-00000000
// CHECK: mov     z0.b, p0/m, b0 // encoding: [0x00,0x80,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10000000-00000000
cpy     z31.h, p7/m, h31  // 00000101-01100000-10011111-11111111
// CHECK: mov     z31.h, p7/m, h31 // encoding: [0xff,0x9f,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10011111-11111111
CPY     Z31.H, P7/M, H31  // 00000101-01100000-10011111-11111111
// CHECK: mov     z31.h, p7/m, h31 // encoding: [0xff,0x9f,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10011111-11111111
cpy     z0.h, p0/m, #0  // 00000101-01010000-01000000-00000000
// CHECK: mov     z0.h, p0/m, #0 // encoding: [0x00,0x40,0x50,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010000-01000000-00000000
CPY     Z0.H, P0/M, #0  // 00000101-01010000-01000000-00000000
// CHECK: mov     z0.h, p0/m, #0 // encoding: [0x00,0x40,0x50,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010000-01000000-00000000
cpy     z21.h, p5/m, h10  // 00000101-01100000-10010101-01010101
// CHECK: mov     z21.h, p5/m, h10 // encoding: [0x55,0x95,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10010101-01010101
CPY     Z21.H, P5/M, H10  // 00000101-01100000-10010101-01010101
// CHECK: mov     z21.h, p5/m, h10 // encoding: [0x55,0x95,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10010101-01010101
cpy     z23.s, p3/m, w13  // 00000101-10101000-10101101-10110111
// CHECK: mov     z23.s, p3/m, w13 // encoding: [0xb7,0xad,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10101101-10110111
CPY     Z23.S, P3/M, W13  // 00000101-10101000-10101101-10110111
// CHECK: mov     z23.s, p3/m, w13 // encoding: [0xb7,0xad,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10101101-10110111
cpy     z23.d, p3/m, d13  // 00000101-11100000-10001101-10110111
// CHECK: mov     z23.d, p3/m, d13 // encoding: [0xb7,0x8d,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10001101-10110111
CPY     Z23.D, P3/M, D13  // 00000101-11100000-10001101-10110111
// CHECK: mov     z23.d, p3/m, d13 // encoding: [0xb7,0x8d,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10001101-10110111
cpy     z31.d, p7/m, sp  // 00000101-11101000-10111111-11111111
// CHECK: mov     z31.d, p7/m, sp // encoding: [0xff,0xbf,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10111111-11111111
CPY     Z31.D, P7/M, SP  // 00000101-11101000-10111111-11111111
// CHECK: mov     z31.d, p7/m, sp // encoding: [0xff,0xbf,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10111111-11111111
cpy     z0.s, p0/m, s0  // 00000101-10100000-10000000-00000000
// CHECK: mov     z0.s, p0/m, s0 // encoding: [0x00,0x80,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10000000-00000000
CPY     Z0.S, P0/M, S0  // 00000101-10100000-10000000-00000000
// CHECK: mov     z0.s, p0/m, s0 // encoding: [0x00,0x80,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10000000-00000000
cpy     z31.h, p15/z, #-1, lsl #8  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
CPY     Z31.H, P15/Z, #-1, LSL #8  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
cpy     z31.h, p15/z, #-256  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
CPY     Z31.H, P15/Z, #-256  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
cpy     z31.s, p15/m, #-1, lsl #8  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
CPY     Z31.S, P15/M, #-1, LSL #8  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
cpy     z31.s, p15/m, #-256  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
CPY     Z31.S, P15/M, #-256  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
cpy     z21.s, p5/z, #-86  // 00000101-10010101-00010101-01010101
// CHECK: mov     z21.s, p5/z, #-86 // encoding: [0x55,0x15,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-00010101-01010101
CPY     Z21.S, P5/Z, #-86  // 00000101-10010101-00010101-01010101
// CHECK: mov     z21.s, p5/z, #-86 // encoding: [0x55,0x15,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-00010101-01010101
cpy     z21.d, p5/m, x10  // 00000101-11101000-10110101-01010101
// CHECK: mov     z21.d, p5/m, x10 // encoding: [0x55,0xb5,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10110101-01010101
CPY     Z21.D, P5/M, X10  // 00000101-11101000-10110101-01010101
// CHECK: mov     z21.d, p5/m, x10 // encoding: [0x55,0xb5,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10110101-01010101
cpy     z0.d, p0/m, #0  // 00000101-11010000-01000000-00000000
// CHECK: mov     z0.d, p0/m, #0 // encoding: [0x00,0x40,0xd0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010000-01000000-00000000
CPY     Z0.D, P0/M, #0  // 00000101-11010000-01000000-00000000
// CHECK: mov     z0.d, p0/m, #0 // encoding: [0x00,0x40,0xd0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010000-01000000-00000000
cpy     z21.h, p5/m, w10  // 00000101-01101000-10110101-01010101
// CHECK: mov     z21.h, p5/m, w10 // encoding: [0x55,0xb5,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10110101-01010101
CPY     Z21.H, P5/M, W10  // 00000101-01101000-10110101-01010101
// CHECK: mov     z21.h, p5/m, w10 // encoding: [0x55,0xb5,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10110101-01010101
cpy     z21.b, p5/z, #-86  // 00000101-00010101-00010101-01010101
// CHECK: mov     z21.b, p5/z, #-86 // encoding: [0x55,0x15,0x15,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010101-00010101-01010101
CPY     Z21.B, P5/Z, #-86  // 00000101-00010101-00010101-01010101
// CHECK: mov     z21.b, p5/z, #-86 // encoding: [0x55,0x15,0x15,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010101-00010101-01010101
cpy     z31.h, p15/m, #0  // 00000101-01011111-01000000-00011111
// CHECK: mov     z31.h, p15/m, #0 // encoding: [0x1f,0x40,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01000000-00011111
CPY     Z31.H, P15/M, #0  // 00000101-01011111-01000000-00011111
// CHECK: mov     z31.h, p15/m, #0 // encoding: [0x1f,0x40,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01000000-00011111
cpy     z21.d, p5/m, #0  // 00000101-11010101-01000000-00010101
// CHECK: mov     z21.d, p5/m, #0 // encoding: [0x15,0x40,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-01000000-00010101
CPY     Z21.D, P5/M, #0  // 00000101-11010101-01000000-00010101
// CHECK: mov     z21.d, p5/m, #0 // encoding: [0x15,0x40,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-01000000-00010101
cpy     z0.d, p0/m, d0  // 00000101-11100000-10000000-00000000
// CHECK: mov     z0.d, p0/m, d0 // encoding: [0x00,0x80,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10000000-00000000
CPY     Z0.D, P0/M, D0  // 00000101-11100000-10000000-00000000
// CHECK: mov     z0.d, p0/m, d0 // encoding: [0x00,0x80,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10000000-00000000
cpy     z23.s, p8/m, #109, lsl #8  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
CPY     Z23.S, P8/M, #109, LSL #8  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
cpy     z23.s, p8/m, #27904  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
CPY     Z23.S, P8/M, #27904  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
cpy     z0.b, p0/m, w0  // 00000101-00101000-10100000-00000000
// CHECK: mov     z0.b, p0/m, w0 // encoding: [0x00,0xa0,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10100000-00000000
CPY     Z0.B, P0/M, W0  // 00000101-00101000-10100000-00000000
// CHECK: mov     z0.b, p0/m, w0 // encoding: [0x00,0xa0,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10100000-00000000
cpy     z31.s, p15/z, #-1, lsl #8  // 00000101-10011111-00111111-11111111
// CHECK: mov     z31.s, p15/z, #-256 // encoding: [0xff,0x3f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-00111111-11111111
CPY     Z31.S, P15/Z, #-1, LSL #8  // 00000101-10011111-00111111-11111111
// CHECK: mov     z31.s, p15/z, #-256 // encoding: [0xff,0x3f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-00111111-11111111
cpy     z31.s, p15/z, #-256  // 00000101-10011111-00111111-11111111
// CHECK: mov     z31.s, p15/z, #-256 // encoding: [0xff,0x3f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-00111111-11111111
CPY     Z31.S, P15/Z, #-256  // 00000101-10011111-00111111-11111111
// CHECK: mov     z31.s, p15/z, #-256 // encoding: [0xff,0x3f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-00111111-11111111
cpy     z23.d, p8/z, #109, lsl #8  // 00000101-11011000-00101101-10110111
// CHECK: mov     z23.d, p8/z, #27904 // encoding: [0xb7,0x2d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-00101101-10110111
CPY     Z23.D, P8/Z, #109, LSL #8  // 00000101-11011000-00101101-10110111
// CHECK: mov     z23.d, p8/z, #27904 // encoding: [0xb7,0x2d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-00101101-10110111
cpy     z23.d, p8/z, #27904  // 00000101-11011000-00101101-10110111
// CHECK: mov     z23.d, p8/z, #27904 // encoding: [0xb7,0x2d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-00101101-10110111
CPY     Z23.D, P8/Z, #27904  // 00000101-11011000-00101101-10110111
// CHECK: mov     z23.d, p8/z, #27904 // encoding: [0xb7,0x2d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-00101101-10110111
cpy     z0.h, p0/z, #0  // 00000101-01010000-00000000-00000000
// CHECK: mov     z0.h, p0/z, #0 // encoding: [0x00,0x00,0x50,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010000-00000000-00000000
CPY     Z0.H, P0/Z, #0  // 00000101-01010000-00000000-00000000
// CHECK: mov     z0.h, p0/z, #0 // encoding: [0x00,0x00,0x50,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010000-00000000-00000000
cpy     z21.h, p5/m, #0  // 00000101-01010101-01000000-00010101
// CHECK: mov     z21.h, p5/m, #0 // encoding: [0x15,0x40,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-01000000-00010101
CPY     Z21.H, P5/M, #0  // 00000101-01010101-01000000-00010101
// CHECK: mov     z21.h, p5/m, #0 // encoding: [0x15,0x40,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-01000000-00010101
cpy     z1.b, p14/m, #33  // 00000101-00011110-01000100-00100001
// CHECK: mov     z1.b, p14/m, #33 // encoding: [0x21,0x44,0x1e,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00011110-01000100-00100001
CPY     Z1.B, P14/M, #33  // 00000101-00011110-01000100-00100001
// CHECK: mov     z1.b, p14/m, #33 // encoding: [0x21,0x44,0x1e,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00011110-01000100-00100001
cpy     z23.b, p3/m, w13  // 00000101-00101000-10101101-10110111
// CHECK: mov     z23.b, p3/m, w13 // encoding: [0xb7,0xad,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10101101-10110111
CPY     Z23.B, P3/M, W13  // 00000101-00101000-10101101-10110111
// CHECK: mov     z23.b, p3/m, w13 // encoding: [0xb7,0xad,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10101101-10110111
cpy     z0.h, p0/m, h0  // 00000101-01100000-10000000-00000000
// CHECK: mov     z0.h, p0/m, h0 // encoding: [0x00,0x80,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10000000-00000000
CPY     Z0.H, P0/M, H0  // 00000101-01100000-10000000-00000000
// CHECK: mov     z0.h, p0/m, h0 // encoding: [0x00,0x80,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10000000-00000000
cpy     z23.h, p8/m, #109, lsl #8  // 00000101-01011000-01101101-10110111
// CHECK: mov     z23.h, p8/m, #27904 // encoding: [0xb7,0x6d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01101101-10110111
CPY     Z23.H, P8/M, #109, LSL #8  // 00000101-01011000-01101101-10110111
// CHECK: mov     z23.h, p8/m, #27904 // encoding: [0xb7,0x6d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01101101-10110111
cpy     z23.h, p8/m, #27904  // 00000101-01011000-01101101-10110111
// CHECK: mov     z23.h, p8/m, #27904 // encoding: [0xb7,0x6d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01101101-10110111
CPY     Z23.H, P8/M, #27904  // 00000101-01011000-01101101-10110111
// CHECK: mov     z23.h, p8/m, #27904 // encoding: [0xb7,0x6d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01101101-10110111
cpy     z0.d, p0/m, x0  // 00000101-11101000-10100000-00000000
// CHECK: mov     z0.d, p0/m, x0 // encoding: [0x00,0xa0,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10100000-00000000
CPY     Z0.D, P0/M, X0  // 00000101-11101000-10100000-00000000
// CHECK: mov     z0.d, p0/m, x0 // encoding: [0x00,0xa0,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10100000-00000000
cpy     z0.b, p0/z, #0  // 00000101-00010000-00000000-00000000
// CHECK: mov     z0.b, p0/z, #0 // encoding: [0x00,0x00,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-00000000-00000000
CPY     Z0.B, P0/Z, #0  // 00000101-00010000-00000000-00000000
// CHECK: mov     z0.b, p0/z, #0 // encoding: [0x00,0x00,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-00000000-00000000
cpy     z31.s, p15/m, #0  // 00000101-10011111-01000000-00011111
// CHECK: mov     z31.s, p15/m, #0 // encoding: [0x1f,0x40,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01000000-00011111
CPY     Z31.S, P15/M, #0  // 00000101-10011111-01000000-00011111
// CHECK: mov     z31.s, p15/m, #0 // encoding: [0x1f,0x40,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01000000-00011111
cpy     z21.d, p5/z, #-86  // 00000101-11010101-00010101-01010101
// CHECK: mov     z21.d, p5/z, #-86 // encoding: [0x55,0x15,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-00010101-01010101
CPY     Z21.D, P5/Z, #-86  // 00000101-11010101-00010101-01010101
// CHECK: mov     z21.d, p5/z, #-86 // encoding: [0x55,0x15,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-00010101-01010101
cpy     z21.s, p5/m, #0  // 00000101-10010101-01000000-00010101
// CHECK: mov     z21.s, p5/m, #0 // encoding: [0x15,0x40,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-01000000-00010101
CPY     Z21.S, P5/M, #0  // 00000101-10010101-01000000-00010101
// CHECK: mov     z21.s, p5/m, #0 // encoding: [0x15,0x40,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-01000000-00010101
cpy     z23.s, p3/m, s13  // 00000101-10100000-10001101-10110111
// CHECK: mov     z23.s, p3/m, s13 // encoding: [0xb7,0x8d,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10001101-10110111
CPY     Z23.S, P3/M, S13  // 00000101-10100000-10001101-10110111
// CHECK: mov     z23.s, p3/m, s13 // encoding: [0xb7,0x8d,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10001101-10110111
cpy     z23.h, p8/z, #109, lsl #8  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
CPY     Z23.H, P8/Z, #109, LSL #8  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
cpy     z23.h, p8/z, #27904  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
CPY     Z23.H, P8/Z, #27904  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
cpy     z0.b, p0/m, #0  // 00000101-00010000-01000000-00000000
// CHECK: mov     z0.b, p0/m, #0 // encoding: [0x00,0x40,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-01000000-00000000
CPY     Z0.B, P0/M, #0  // 00000101-00010000-01000000-00000000
// CHECK: mov     z0.b, p0/m, #0 // encoding: [0x00,0x40,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-01000000-00000000
cpy     z23.b, p3/m, b13  // 00000101-00100000-10001101-10110111
// CHECK: mov     z23.b, p3/m, b13 // encoding: [0xb7,0x8d,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10001101-10110111
CPY     Z23.B, P3/M, B13  // 00000101-00100000-10001101-10110111
// CHECK: mov     z23.b, p3/m, b13 // encoding: [0xb7,0x8d,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10001101-10110111
