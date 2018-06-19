// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mov     z31.d, p15/m, #-1, lsl #8  // 00000101-11011111-01111111-11111111
// CHECK: mov     z31.d, p15/m, #-256 // encoding: [0xff,0x7f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01111111-11111111
MOV     Z31.D, P15/M, #-1, LSL #8  // 00000101-11011111-01111111-11111111
// CHECK: mov     z31.d, p15/m, #-256 // encoding: [0xff,0x7f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01111111-11111111
mov     z31.d, p15/m, #-256  // 00000101-11011111-01111111-11111111
// CHECK: mov     z31.d, p15/m, #-256 // encoding: [0xff,0x7f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01111111-11111111
MOV     Z31.D, P15/M, #-256  // 00000101-11011111-01111111-11111111
// CHECK: mov     z31.d, p15/m, #-256 // encoding: [0xff,0x7f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01111111-11111111
mov     z0.s, p0/m, w0  // 00000101-10101000-10100000-00000000
// CHECK: mov     z0.s, p0/m, w0 // encoding: [0x00,0xa0,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10100000-00000000
MOV     Z0.S, P0/M, W0  // 00000101-10101000-10100000-00000000
// CHECK: mov     z0.s, p0/m, w0 // encoding: [0x00,0xa0,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10100000-00000000
mov     z21.s, p5/m, s10  // 00000101-10100000-10010101-01010101
// CHECK: mov     z21.s, p5/m, s10 // encoding: [0x55,0x95,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10010101-01010101
MOV     Z21.S, P5/M, S10  // 00000101-10100000-10010101-01010101
// CHECK: mov     z21.s, p5/m, s10 // encoding: [0x55,0x95,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10010101-01010101
mov     z31.s, p7/m, s31  // 00000101-10100000-10011111-11111111
// CHECK: mov     z31.s, p7/m, s31 // encoding: [0xff,0x9f,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10011111-11111111
MOV     Z31.S, P7/M, S31  // 00000101-10100000-10011111-11111111
// CHECK: mov     z31.s, p7/m, s31 // encoding: [0xff,0x9f,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10011111-11111111
mov     z23.s, w13  // 00000101-10100000-00111001-10110111
// CHECK: mov     z23.s, w13 // encoding: [0xb7,0x39,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-00111001-10110111
MOV     Z23.S, W13  // 00000101-10100000-00111001-10110111
// CHECK: mov     z23.s, w13 // encoding: [0xb7,0x39,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-00111001-10110111
mov     z0.h, h0  // 00000101-00100010-00100000-00000000
// CHECK: mov     z0.h, h0 // encoding: [0x00,0x20,0x22,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100010-00100000-00000000
MOV     Z0.H, H0  // 00000101-00100010-00100000-00000000
// CHECK: mov     z0.h, h0 // encoding: [0x00,0x20,0x22,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100010-00100000-00000000
mov     z31.h, p15/m, z31.h  // 00000101-01111111-11111111-11111111
// CHECK: mov     z31.h, p15/m, z31.h // encoding: [0xff,0xff,0x7f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01111111-11111111-11111111
MOV     Z31.H, P15/M, Z31.H  // 00000101-01111111-11111111-11111111
// CHECK: mov     z31.h, p15/m, z31.h // encoding: [0xff,0xff,0x7f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01111111-11111111-11111111
mov     z31.s, #-1, lsl #8  // 00100101-10111000-11111111-11111111
// CHECK: mov     z31.s, #-256 // encoding: [0xff,0xff,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11111111-11111111
MOV     Z31.S, #-1, LSL #8  // 00100101-10111000-11111111-11111111
// CHECK: mov     z31.s, #-256 // encoding: [0xff,0xff,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11111111-11111111
mov     z31.s, #-256  // 00100101-10111000-11111111-11111111
// CHECK: mov     z31.s, #-256 // encoding: [0xff,0xff,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11111111-11111111
MOV     Z31.S, #-256  // 00100101-10111000-11111111-11111111
// CHECK: mov     z31.s, #-256 // encoding: [0xff,0xff,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11111111-11111111
mov     z21.d, #-86  // 00100101-11111000-11010101-01010101
// CHECK: mov     z21.d, #-86 // encoding: [0x55,0xd5,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11010101-01010101
MOV     Z21.D, #-86  // 00100101-11111000-11010101-01010101
// CHECK: mov     z21.d, #-86 // encoding: [0x55,0xd5,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11010101-01010101
mov     z5.b, p0/z, #113  // 00000101-00010000-00001110-00100101
// CHECK: mov     z5.b, p0/z, #113 // encoding: [0x25,0x0e,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-00001110-00100101
MOV     Z5.B, P0/Z, #113  // 00000101-00010000-00001110-00100101
// CHECK: mov     z5.b, p0/z, #113 // encoding: [0x25,0x0e,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-00001110-00100101
mov     p15.b, p15/m, p15.b  // 00100101-00001111-01111111-11111111
// CHECK: mov     p15.b, p15/m, p15.b // encoding: [0xff,0x7f,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-01111111-11111111
MOV     P15.B, P15/M, P15.B  // 00100101-00001111-01111111-11111111
// CHECK: mov     p15.b, p15/m, p15.b // encoding: [0xff,0x7f,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-01111111-11111111
mov     z0.s, p0/m, #0  // 00000101-10010000-01000000-00000000
// CHECK: mov     z0.s, p0/m, #0 // encoding: [0x00,0x40,0x90,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010000-01000000-00000000
MOV     Z0.S, P0/M, #0  // 00000101-10010000-01000000-00000000
// CHECK: mov     z0.s, p0/m, #0 // encoding: [0x00,0x40,0x90,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010000-01000000-00000000
mov     z5.b, p0/m, #113  // 00000101-00010000-01001110-00100101
// CHECK: mov     z5.b, p0/m, #113 // encoding: [0x25,0x4e,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-01001110-00100101
MOV     Z5.B, P0/M, #113  // 00000101-00010000-01001110-00100101
// CHECK: mov     z5.b, p0/m, #113 // encoding: [0x25,0x4e,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-01001110-00100101
mov     z0.d, p0/m, z0.d  // 00000101-11100000-11000000-00000000
// CHECK: mov     z0.d, p0/m, z0.d // encoding: [0x00,0xc0,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-11000000-00000000
MOV     Z0.D, P0/M, Z0.D  // 00000101-11100000-11000000-00000000
// CHECK: mov     z0.d, p0/m, z0.d // encoding: [0x00,0xc0,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-11000000-00000000
mov     z31.d, z31.d[7]  // 00000101-11111000-00100011-11111111
// CHECK: mov     z31.d, z31.d[7] // encoding: [0xff,0x23,0xf8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111000-00100011-11111111
MOV     Z31.D, Z31.D[7]  // 00000101-11111000-00100011-11111111
// CHECK: mov     z31.d, z31.d[7] // encoding: [0xff,0x23,0xf8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111000-00100011-11111111
mov     z31.h, p15/m, #-1, lsl #8  // 00000101-01011111-01111111-11111111
// CHECK: mov     z31.h, p15/m, #-256 // encoding: [0xff,0x7f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01111111-11111111
MOV     Z31.H, P15/M, #-1, LSL #8  // 00000101-01011111-01111111-11111111
// CHECK: mov     z31.h, p15/m, #-256 // encoding: [0xff,0x7f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01111111-11111111
mov     z31.h, p15/m, #-256  // 00000101-01011111-01111111-11111111
// CHECK: mov     z31.h, p15/m, #-256 // encoding: [0xff,0x7f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01111111-11111111
MOV     Z31.H, P15/M, #-256  // 00000101-01011111-01111111-11111111
// CHECK: mov     z31.h, p15/m, #-256 // encoding: [0xff,0x7f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01111111-11111111
mov     z21.s, p5/m, w10  // 00000101-10101000-10110101-01010101
// CHECK: mov     z21.s, p5/m, w10 // encoding: [0x55,0xb5,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10110101-01010101
MOV     Z21.S, P5/M, W10  // 00000101-10101000-10110101-01010101
// CHECK: mov     z21.s, p5/m, w10 // encoding: [0x55,0xb5,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10110101-01010101
mov     z21.h, p5/m, #-86  // 00000101-01010101-01010101-01010101
// CHECK: mov     z21.h, p5/m, #-86 // encoding: [0x55,0x55,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-01010101-01010101
MOV     Z21.H, P5/M, #-86  // 00000101-01010101-01010101-01010101
// CHECK: mov     z21.h, p5/m, #-86 // encoding: [0x55,0x55,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-01010101-01010101
mov     z31.s, p7/m, wsp  // 00000101-10101000-10111111-11111111
// CHECK: mov     z31.s, p7/m, wsp // encoding: [0xff,0xbf,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10111111-11111111
MOV     Z31.S, P7/M, WSP  // 00000101-10101000-10111111-11111111
// CHECK: mov     z31.s, p7/m, wsp // encoding: [0xff,0xbf,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10111111-11111111
mov     z31.h, p7/m, wsp  // 00000101-01101000-10111111-11111111
// CHECK: mov     z31.h, p7/m, wsp // encoding: [0xff,0xbf,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10111111-11111111
MOV     Z31.H, P7/M, WSP  // 00000101-01101000-10111111-11111111
// CHECK: mov     z31.h, p7/m, wsp // encoding: [0xff,0xbf,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10111111-11111111
mov     z5.b, #113  // 00100101-00111000-11001110-00100101
// CHECK: mov     z5.b, #113 // encoding: [0x25,0xce,0x38,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00111000-11001110-00100101
MOV     Z5.B, #113  // 00100101-00111000-11001110-00100101
// CHECK: mov     z5.b, #113 // encoding: [0x25,0xce,0x38,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00111000-11001110-00100101
mov     z21.b, p5/m, z10.b  // 00000101-00110101-11010101-01010101
// CHECK: mov     z21.b, p5/m, z10.b // encoding: [0x55,0xd5,0x35,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110101-11010101-01010101
MOV     Z21.B, P5/M, Z10.B  // 00000101-00110101-11010101-01010101
// CHECK: mov     z21.b, p5/m, z10.b // encoding: [0x55,0xd5,0x35,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110101-11010101-01010101
mov     z31.b, p7/m, wsp  // 00000101-00101000-10111111-11111111
// CHECK: mov     z31.b, p7/m, wsp // encoding: [0xff,0xbf,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10111111-11111111
MOV     Z31.B, P7/M, WSP  // 00000101-00101000-10111111-11111111
// CHECK: mov     z31.b, p7/m, wsp // encoding: [0xff,0xbf,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10111111-11111111
mov     z5.q, z17.q[3]  // 00000101-11110000-00100010-00100101
// CHECK: mov     z5.q, z17.q[3] // encoding: [0x25,0x22,0xf0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110000-00100010-00100101
MOV     Z5.Q, Z17.Q[3]  // 00000101-11110000-00100010-00100101
// CHECK: mov     z5.q, z17.q[3] // encoding: [0x25,0x22,0xf0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110000-00100010-00100101
mov     p0.b, p0/m, p0.b  // 00100101-00000000-01000010-00010000
// CHECK: mov     p0.b, p0/m, p0.b // encoding: [0x10,0x42,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-01000010-00010000
MOV     P0.B, P0/M, P0.B  // 00100101-00000000-01000010-00010000
// CHECK: mov     p0.b, p0/m, p0.b // encoding: [0x10,0x42,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-01000010-00010000
mov     z23.s, #109, lsl #8  // 00100101-10111000-11101101-10110111
// CHECK: mov     z23.s, #27904 // encoding: [0xb7,0xed,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11101101-10110111
MOV     Z23.S, #109, LSL #8  // 00100101-10111000-11101101-10110111
// CHECK: mov     z23.s, #27904 // encoding: [0xb7,0xed,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11101101-10110111
mov     z23.s, #27904  // 00100101-10111000-11101101-10110111
// CHECK: mov     z23.s, #27904 // encoding: [0xb7,0xed,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11101101-10110111
MOV     Z23.S, #27904  // 00100101-10111000-11101101-10110111
// CHECK: mov     z23.s, #27904 // encoding: [0xb7,0xed,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11101101-10110111
mov     z0.d, x0  // 00000101-11100000-00111000-00000000
// CHECK: mov     z0.d, x0 // encoding: [0x00,0x38,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-00111000-00000000
MOV     Z0.D, X0  // 00000101-11100000-00111000-00000000
// CHECK: mov     z0.d, x0 // encoding: [0x00,0x38,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-00111000-00000000
mov     z23.h, p3/m, w13  // 00000101-01101000-10101101-10110111
// CHECK: mov     z23.h, p3/m, w13 // encoding: [0xb7,0xad,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10101101-10110111
MOV     Z23.H, P3/M, W13  // 00000101-01101000-10101101-10110111
// CHECK: mov     z23.h, p3/m, w13 // encoding: [0xb7,0xad,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10101101-10110111
mov     z0.b, b0  // 00000101-00100001-00100000-00000000
// CHECK: mov     z0.b, b0 // encoding: [0x00,0x20,0x21,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100001-00100000-00000000
MOV     Z0.B, B0  // 00000101-00100001-00100000-00000000
// CHECK: mov     z0.b, b0 // encoding: [0x00,0x20,0x21,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100001-00100000-00000000
mov     z0.h, h12  // 00000101-00100010-00100001-10000000
// CHECK: mov     z0.h, h12 // encoding: [0x80,0x21,0x22,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100010-00100001-10000000
MOV     Z0.H, H12  // 00000101-00100010-00100001-10000000
// CHECK: mov     z0.h, h12 // encoding: [0x80,0x21,0x22,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100010-00100001-10000000
mov     z21.d, p5/m, d10  // 00000101-11100000-10010101-01010101
// CHECK: mov     z21.d, p5/m, d10 // encoding: [0x55,0x95,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10010101-01010101
MOV     Z21.D, P5/M, D10  // 00000101-11100000-10010101-01010101
// CHECK: mov     z21.d, p5/m, d10 // encoding: [0x55,0x95,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10010101-01010101
mov     p15.b, p15.b  // 00100101-10001111-01111101-11101111
// CHECK: mov     p15.b, p15.b // encoding: [0xef,0x7d,0x8f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001111-01111101-11101111
MOV     P15.B, P15.B  // 00100101-10001111-01111101-11101111
// CHECK: mov     p15.b, p15.b // encoding: [0xef,0x7d,0x8f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001111-01111101-11101111
mov     z23.h, p3/m, h13  // 00000101-01100000-10001101-10110111
// CHECK: mov     z23.h, p3/m, h13 // encoding: [0xb7,0x8d,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10001101-10110111
MOV     Z23.H, P3/M, H13  // 00000101-01100000-10001101-10110111
// CHECK: mov     z23.h, p3/m, h13 // encoding: [0xb7,0x8d,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10001101-10110111
mov     z0.b, w0  // 00000101-00100000-00111000-00000000
// CHECK: mov     z0.b, w0 // encoding: [0x00,0x38,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00111000-00000000
MOV     Z0.B, W0  // 00000101-00100000-00111000-00000000
// CHECK: mov     z0.b, w0 // encoding: [0x00,0x38,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00111000-00000000
mov     z0.s, w0  // 00000101-10100000-00111000-00000000
// CHECK: mov     z0.s, w0 // encoding: [0x00,0x38,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-00111000-00000000
MOV     Z0.S, W0  // 00000101-10100000-00111000-00000000
// CHECK: mov     z0.s, w0 // encoding: [0x00,0x38,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-00111000-00000000
mov     z21.q, z10.q[1]  // 00000101-01110000-00100001-01010101
// CHECK: mov     z21.q, z10.q[1] // encoding: [0x55,0x21,0x70,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110000-00100001-01010101
MOV     Z21.Q, Z10.Q[1]  // 00000101-01110000-00100001-01010101
// CHECK: mov     z21.q, z10.q[1] // encoding: [0x55,0x21,0x70,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110000-00100001-01010101
mov     z23.s, p8/z, #109, lsl #8  // 00000101-10011000-00101101-10110111
// CHECK: mov     z23.s, p8/z, #27904 // encoding: [0xb7,0x2d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-00101101-10110111
MOV     Z23.S, P8/Z, #109, LSL #8  // 00000101-10011000-00101101-10110111
// CHECK: mov     z23.s, p8/z, #27904 // encoding: [0xb7,0x2d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-00101101-10110111
mov     z23.s, p8/z, #27904  // 00000101-10011000-00101101-10110111
// CHECK: mov     z23.s, p8/z, #27904 // encoding: [0xb7,0x2d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-00101101-10110111
MOV     Z23.S, P8/Z, #27904  // 00000101-10011000-00101101-10110111
// CHECK: mov     z23.s, p8/z, #27904 // encoding: [0xb7,0x2d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-00101101-10110111
mov     z0.s, p0/m, z0.s  // 00000101-10100000-11000000-00000000
// CHECK: mov     z0.s, p0/m, z0.s // encoding: [0x00,0xc0,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-11000000-00000000
MOV     Z0.S, P0/M, Z0.S  // 00000101-10100000-11000000-00000000
// CHECK: mov     z0.s, p0/m, z0.s // encoding: [0x00,0xc0,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-11000000-00000000
mov     z21.d, p5/m, #-86  // 00000101-11010101-01010101-01010101
// CHECK: mov     z21.d, p5/m, #-86 // encoding: [0x55,0x55,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-01010101-01010101
MOV     Z21.D, P5/M, #-86  // 00000101-11010101-01010101-01010101
// CHECK: mov     z21.d, p5/m, #-86 // encoding: [0x55,0x55,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-01010101-01010101
mov     z21.h, p5/z, #-86  // 00000101-01010101-00010101-01010101
// CHECK: mov     z21.h, p5/z, #-86 // encoding: [0x55,0x15,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-00010101-01010101
MOV     Z21.H, P5/Z, #-86  // 00000101-01010101-00010101-01010101
// CHECK: mov     z21.h, p5/z, #-86 // encoding: [0x55,0x15,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-00010101-01010101
mov     z1.b, p14/z, #33  // 00000101-00011110-00000100-00100001
// CHECK: mov     z1.b, p14/z, #33 // encoding: [0x21,0x04,0x1e,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00011110-00000100-00100001
MOV     Z1.B, P14/Z, #33  // 00000101-00011110-00000100-00100001
// CHECK: mov     z1.b, p14/z, #33 // encoding: [0x21,0x04,0x1e,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00011110-00000100-00100001
mov     z0.h, p0/m, w0  // 00000101-01101000-10100000-00000000
// CHECK: mov     z0.h, p0/m, w0 // encoding: [0x00,0xa0,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10100000-00000000
MOV     Z0.H, P0/M, W0  // 00000101-01101000-10100000-00000000
// CHECK: mov     z0.h, p0/m, w0 // encoding: [0x00,0xa0,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10100000-00000000
mov     z23.h, z13.h[10]  // 00000101-01101010-00100001-10110111
// CHECK: mov     z23.h, z13.h[10] // encoding: [0xb7,0x21,0x6a,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101010-00100001-10110111
MOV     Z23.H, Z13.H[10]  // 00000101-01101010-00100001-10110111
// CHECK: mov     z23.h, z13.h[10] // encoding: [0xb7,0x21,0x6a,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101010-00100001-10110111
mov     z31.b, p7/m, b31  // 00000101-00100000-10011111-11111111
// CHECK: mov     z31.b, p7/m, b31 // encoding: [0xff,0x9f,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10011111-11111111
MOV     Z31.B, P7/M, B31  // 00000101-00100000-10011111-11111111
// CHECK: mov     z31.b, p7/m, b31 // encoding: [0xff,0x9f,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10011111-11111111
mov     z31.s, p15/m, z31.s  // 00000101-10111111-11111111-11111111
// CHECK: mov     z31.s, p15/m, z31.s // encoding: [0xff,0xff,0xbf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10111111-11111111-11111111
MOV     Z31.S, P15/M, Z31.S  // 00000101-10111111-11111111-11111111
// CHECK: mov     z31.s, p15/m, z31.s // encoding: [0xff,0xff,0xbf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10111111-11111111-11111111
mov     z23.d, p3/m, x13  // 00000101-11101000-10101101-10110111
// CHECK: mov     z23.d, p3/m, x13 // encoding: [0xb7,0xad,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10101101-10110111
MOV     Z23.D, P3/M, X13  // 00000101-11101000-10101101-10110111
// CHECK: mov     z23.d, p3/m, x13 // encoding: [0xb7,0xad,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10101101-10110111
mov     z5.s, z17.s[14]  // 00000101-11110100-00100010-00100101
// CHECK: mov     z5.s, z17.s[14] // encoding: [0x25,0x22,0xf4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110100-00100010-00100101
MOV     Z5.S, Z17.S[14]  // 00000101-11110100-00100010-00100101
// CHECK: mov     z5.s, z17.s[14] // encoding: [0x25,0x22,0xf4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110100-00100010-00100101
mov     z21.s, z10.s[6]  // 00000101-01110100-00100001-01010101
// CHECK: mov     z21.s, z10.s[6] // encoding: [0x55,0x21,0x74,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110100-00100001-01010101
MOV     Z21.S, Z10.S[6]  // 00000101-01110100-00100001-01010101
// CHECK: mov     z21.s, z10.s[6] // encoding: [0x55,0x21,0x74,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110100-00100001-01010101
mov     z5.h, z17.h[28]  // 00000101-11110010-00100010-00100101
// CHECK: mov     z5.h, z17.h[28] // encoding: [0x25,0x22,0xf2,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110010-00100010-00100101
MOV     Z5.H, Z17.H[28]  // 00000101-11110010-00100010-00100101
// CHECK: mov     z5.h, z17.h[28] // encoding: [0x25,0x22,0xf2,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110010-00100010-00100101
mov     z0.d, p0/z, #0  // 00000101-11010000-00000000-00000000
// CHECK: mov     z0.d, p0/z, #0 // encoding: [0x00,0x00,0xd0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010000-00000000-00000000
MOV     Z0.D, P0/Z, #0  // 00000101-11010000-00000000-00000000
// CHECK: mov     z0.d, p0/z, #0 // encoding: [0x00,0x00,0xd0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010000-00000000-00000000
mov     z21.s, p5/m, #-86  // 00000101-10010101-01010101-01010101
// CHECK: mov     z21.s, p5/m, #-86 // encoding: [0x55,0x55,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-01010101-01010101
MOV     Z21.S, P5/M, #-86  // 00000101-10010101-01010101-01010101
// CHECK: mov     z21.s, p5/m, #-86 // encoding: [0x55,0x55,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-01010101-01010101
mov     p0.b, p0/z, p0.b  // 00100101-00000000-01000000-00000000
// CHECK: mov     p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-01000000-00000000
MOV     P0.B, P0/Z, P0.B  // 00100101-00000000-01000000-00000000
// CHECK: mov     p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-01000000-00000000
mov     z31.q, z31.q[3]  // 00000101-11110000-00100011-11111111
// CHECK: mov     z31.q, z31.q[3] // encoding: [0xff,0x23,0xf0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110000-00100011-11111111
MOV     Z31.Q, Z31.Q[3]  // 00000101-11110000-00100011-11111111
// CHECK: mov     z31.q, z31.q[3] // encoding: [0xff,0x23,0xf0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110000-00100011-11111111
mov     z21.b, p5/m, b10  // 00000101-00100000-10010101-01010101
// CHECK: mov     z21.b, p5/m, b10 // encoding: [0x55,0x95,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10010101-01010101
MOV     Z21.B, P5/M, B10  // 00000101-00100000-10010101-01010101
// CHECK: mov     z21.b, p5/m, b10 // encoding: [0x55,0x95,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10010101-01010101
mov     z21.d, x10  // 00000101-11100000-00111001-01010101
// CHECK: mov     z21.d, x10 // encoding: [0x55,0x39,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-00111001-01010101
MOV     Z21.D, X10  // 00000101-11100000-00111001-01010101
// CHECK: mov     z21.d, x10 // encoding: [0x55,0x39,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-00111001-01010101
mov     z0.q, q12  // 00000101-00110000-00100001-10000000
// CHECK: mov     z0.q, q12 // encoding: [0x80,0x21,0x30,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110000-00100001-10000000
MOV     Z0.Q, Q12  // 00000101-00110000-00100001-10000000
// CHECK: mov     z0.q, q12 // encoding: [0x80,0x21,0x30,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110000-00100001-10000000
mov     z5.d, z17.d[7]  // 00000101-11111000-00100010-00100101
// CHECK: mov     z5.d, z17.d[7] // encoding: [0x25,0x22,0xf8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111000-00100010-00100101
MOV     Z5.D, Z17.D[7]  // 00000101-11111000-00100010-00100101
// CHECK: mov     z5.d, z17.d[7] // encoding: [0x25,0x22,0xf8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111000-00100010-00100101
mov     z21.h, w10  // 00000101-01100000-00111001-01010101
// CHECK: mov     z21.h, w10 // encoding: [0x55,0x39,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-00111001-01010101
MOV     Z21.H, W10  // 00000101-01100000-00111001-01010101
// CHECK: mov     z21.h, w10 // encoding: [0x55,0x39,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-00111001-01010101
mov     z0.s, p0/z, #0  // 00000101-10010000-00000000-00000000
// CHECK: mov     z0.s, p0/z, #0 // encoding: [0x00,0x00,0x90,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010000-00000000-00000000
MOV     Z0.S, P0/Z, #0  // 00000101-10010000-00000000-00000000
// CHECK: mov     z0.s, p0/z, #0 // encoding: [0x00,0x00,0x90,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010000-00000000-00000000
mov     z21.b, w10  // 00000101-00100000-00111001-01010101
// CHECK: mov     z21.b, w10 // encoding: [0x55,0x39,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00111001-01010101
MOV     Z21.B, W10  // 00000101-00100000-00111001-01010101
// CHECK: mov     z21.b, w10 // encoding: [0x55,0x39,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00111001-01010101
mov     z31.h, wsp  // 00000101-01100000-00111011-11111111
// CHECK: mov     z31.h, wsp // encoding: [0xff,0x3b,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-00111011-11111111
MOV     Z31.H, WSP  // 00000101-01100000-00111011-11111111
// CHECK: mov     z31.h, wsp // encoding: [0xff,0x3b,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-00111011-11111111
mov     z31.d, p7/m, d31  // 00000101-11100000-10011111-11111111
// CHECK: mov     z31.d, p7/m, d31 // encoding: [0xff,0x9f,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10011111-11111111
MOV     Z31.D, P7/M, D31  // 00000101-11100000-10011111-11111111
// CHECK: mov     z31.d, p7/m, d31 // encoding: [0xff,0x9f,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10011111-11111111
mov     p0.b, p0.b  // 00100101-10000000-01000000-00000000
// CHECK: mov     p0.b, p0.b // encoding: [0x00,0x40,0x80,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000000-01000000-00000000
MOV     P0.B, P0.B  // 00100101-10000000-01000000-00000000
// CHECK: mov     p0.b, p0.b // encoding: [0x00,0x40,0x80,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000000-01000000-00000000
mov     z23.d, p8/m, #109, lsl #8  // 00000101-11011000-01101101-10110111
// CHECK: mov     z23.d, p8/m, #27904 // encoding: [0xb7,0x6d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01101101-10110111
MOV     Z23.D, P8/M, #109, LSL #8  // 00000101-11011000-01101101-10110111
// CHECK: mov     z23.d, p8/m, #27904 // encoding: [0xb7,0x6d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01101101-10110111
mov     z23.d, p8/m, #27904  // 00000101-11011000-01101101-10110111
// CHECK: mov     z23.d, p8/m, #27904 // encoding: [0xb7,0x6d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01101101-10110111
MOV     Z23.D, P8/M, #27904  // 00000101-11011000-01101101-10110111
// CHECK: mov     z23.d, p8/m, #27904 // encoding: [0xb7,0x6d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01101101-10110111
mov     p15.b, p15/z, p15.b  // 00100101-00001111-01111101-11101111
// CHECK: mov     p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-01111101-11101111
MOV     P15.B, P15/Z, P15.B  // 00100101-00001111-01111101-11101111
// CHECK: mov     p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-01111101-11101111
mov     z21.s, p5/m, z10.s  // 00000101-10110101-11010101-01010101
// CHECK: mov     z21.s, p5/m, z10.s // encoding: [0x55,0xd5,0xb5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110101-11010101-01010101
MOV     Z21.S, P5/M, Z10.S  // 00000101-10110101-11010101-01010101
// CHECK: mov     z21.s, p5/m, z10.s // encoding: [0x55,0xd5,0xb5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110101-11010101-01010101
mov     z0.s, #0  // 00100101-10111000-11000000-00000000
// CHECK: mov     z0.s, #0 // encoding: [0x00,0xc0,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11000000-00000000
MOV     Z0.S, #0  // 00100101-10111000-11000000-00000000
// CHECK: mov     z0.s, #0 // encoding: [0x00,0xc0,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11000000-00000000
mov     z31.d, p15/z, #-1, lsl #8  // 00000101-11011111-00111111-11111111
// CHECK: mov     z31.d, p15/z, #-256 // encoding: [0xff,0x3f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-00111111-11111111
MOV     Z31.D, P15/Z, #-1, LSL #8  // 00000101-11011111-00111111-11111111
// CHECK: mov     z31.d, p15/z, #-256 // encoding: [0xff,0x3f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-00111111-11111111
mov     z31.d, p15/z, #-256  // 00000101-11011111-00111111-11111111
// CHECK: mov     z31.d, p15/z, #-256 // encoding: [0xff,0x3f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-00111111-11111111
MOV     Z31.D, P15/Z, #-256  // 00000101-11011111-00111111-11111111
// CHECK: mov     z31.d, p15/z, #-256 // encoding: [0xff,0x3f,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-00111111-11111111
mov     z21.b, p5/m, #-86  // 00000101-00010101-01010101-01010101
// CHECK: mov     z21.b, p5/m, #-86 // encoding: [0x55,0x55,0x15,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010101-01010101-01010101
MOV     Z21.B, P5/M, #-86  // 00000101-00010101-01010101-01010101
// CHECK: mov     z21.b, p5/m, #-86 // encoding: [0x55,0x55,0x15,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010101-01010101-01010101
mov     z21.b, p5/m, w10  // 00000101-00101000-10110101-01010101
// CHECK: mov     z21.b, p5/m, w10 // encoding: [0x55,0xb5,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10110101-01010101
MOV     Z21.B, P5/M, W10  // 00000101-00101000-10110101-01010101
// CHECK: mov     z21.b, p5/m, w10 // encoding: [0x55,0xb5,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10110101-01010101
mov     z21.h, #-86  // 00100101-01111000-11010101-01010101
// CHECK: mov     z21.h, #-86 // encoding: [0x55,0xd5,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11010101-01010101
MOV     Z21.H, #-86  // 00100101-01111000-11010101-01010101
// CHECK: mov     z21.h, #-86 // encoding: [0x55,0xd5,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11010101-01010101
mov     z21.d, p5/m, z10.d  // 00000101-11110101-11010101-01010101
// CHECK: mov     z21.d, p5/m, z10.d // encoding: [0x55,0xd5,0xf5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110101-11010101-01010101
MOV     Z21.D, P5/M, Z10.D  // 00000101-11110101-11010101-01010101
// CHECK: mov     z21.d, p5/m, z10.d // encoding: [0x55,0xd5,0xf5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110101-11010101-01010101
mov     z0.b, p0/m, b0  // 00000101-00100000-10000000-00000000
// CHECK: mov     z0.b, p0/m, b0 // encoding: [0x00,0x80,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10000000-00000000
MOV     Z0.B, P0/M, B0  // 00000101-00100000-10000000-00000000
// CHECK: mov     z0.b, p0/m, b0 // encoding: [0x00,0x80,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10000000-00000000
mov     z0.d, #0xe0000000000003ff  // 00000101-11000010-00011001-10000000
// CHECK: mov     z0.d, #0xe0000000000003ff // encoding: [0x80,0x19,0xc2,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11000010-00011001-10000000
MOV     Z0.D, #0xE0000000000003FF  // 00000101-11000010-00011001-10000000
// CHECK: mov     z0.d, #0xe0000000000003ff // encoding: [0x80,0x19,0xc2,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11000010-00011001-10000000
mov     z5.b, z17.b[56]  // 00000101-11110001-00100010-00100101
// CHECK: mov     z5.b, z17.b[56] // encoding: [0x25,0x22,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-00100010-00100101
MOV     Z5.B, Z17.B[56]  // 00000101-11110001-00100010-00100101
// CHECK: mov     z5.b, z17.b[56] // encoding: [0x25,0x22,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-00100010-00100101
mov     z31.h, p7/m, h31  // 00000101-01100000-10011111-11111111
// CHECK: mov     z31.h, p7/m, h31 // encoding: [0xff,0x9f,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10011111-11111111
MOV     Z31.H, P7/M, H31  // 00000101-01100000-10011111-11111111
// CHECK: mov     z31.h, p7/m, h31 // encoding: [0xff,0x9f,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10011111-11111111
mov     z23.h, w13  // 00000101-01100000-00111001-10110111
// CHECK: mov     z23.h, w13 // encoding: [0xb7,0x39,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-00111001-10110111
MOV     Z23.H, W13  // 00000101-01100000-00111001-10110111
// CHECK: mov     z23.h, w13 // encoding: [0xb7,0x39,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-00111001-10110111
mov     z0.h, p0/m, #0  // 00000101-01010000-01000000-00000000
// CHECK: mov     z0.h, p0/m, #0 // encoding: [0x00,0x40,0x50,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010000-01000000-00000000
MOV     Z0.H, P0/M, #0  // 00000101-01010000-01000000-00000000
// CHECK: mov     z0.h, p0/m, #0 // encoding: [0x00,0x40,0x50,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010000-01000000-00000000
mov     z0.d, d0  // 00000101-00101000-00100000-00000000
// CHECK: mov     z0.d, d0 // encoding: [0x00,0x20,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-00100000-00000000
MOV     Z0.D, D0  // 00000101-00101000-00100000-00000000
// CHECK: mov     z0.d, d0 // encoding: [0x00,0x20,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-00100000-00000000
mov     z21.h, p5/m, h10  // 00000101-01100000-10010101-01010101
// CHECK: mov     z21.h, p5/m, h10 // encoding: [0x55,0x95,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10010101-01010101
MOV     Z21.H, P5/M, H10  // 00000101-01100000-10010101-01010101
// CHECK: mov     z21.h, p5/m, h10 // encoding: [0x55,0x95,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10010101-01010101
mov     z31.h, #-1, lsl #8  // 00100101-01111000-11111111-11111111
// CHECK: mov     z31.h, #-256 // encoding: [0xff,0xff,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11111111-11111111
MOV     Z31.H, #-1, LSL #8  // 00100101-01111000-11111111-11111111
// CHECK: mov     z31.h, #-256 // encoding: [0xff,0xff,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11111111-11111111
mov     z31.h, #-256  // 00100101-01111000-11111111-11111111
// CHECK: mov     z31.h, #-256 // encoding: [0xff,0xff,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11111111-11111111
MOV     Z31.H, #-256  // 00100101-01111000-11111111-11111111
// CHECK: mov     z31.h, #-256 // encoding: [0xff,0xff,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11111111-11111111
mov     z31.h, z31.h[31]  // 00000101-11111110-00100011-11111111
// CHECK: mov     z31.h, z31.h[31] // encoding: [0xff,0x23,0xfe,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111110-00100011-11111111
MOV     Z31.H, Z31.H[31]  // 00000101-11111110-00100011-11111111
// CHECK: mov     z31.h, z31.h[31] // encoding: [0xff,0x23,0xfe,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111110-00100011-11111111
mov     z23.s, p3/m, w13  // 00000101-10101000-10101101-10110111
// CHECK: mov     z23.s, p3/m, w13 // encoding: [0xb7,0xad,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10101101-10110111
MOV     Z23.S, P3/M, W13  // 00000101-10101000-10101101-10110111
// CHECK: mov     z23.s, p3/m, w13 // encoding: [0xb7,0xad,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-10101101-10110111
mov     z23.d, p3/m, d13  // 00000101-11100000-10001101-10110111
// CHECK: mov     z23.d, p3/m, d13 // encoding: [0xb7,0x8d,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10001101-10110111
MOV     Z23.D, P3/M, D13  // 00000101-11100000-10001101-10110111
// CHECK: mov     z23.d, p3/m, d13 // encoding: [0xb7,0x8d,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10001101-10110111
mov     z21.h, z10.h[13]  // 00000101-01110110-00100001-01010101
// CHECK: mov     z21.h, z10.h[13] // encoding: [0x55,0x21,0x76,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110110-00100001-01010101
MOV     Z21.H, Z10.H[13]  // 00000101-01110110-00100001-01010101
// CHECK: mov     z21.h, z10.h[13] // encoding: [0x55,0x21,0x76,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110110-00100001-01010101
mov     z0.h, #0  // 00100101-01111000-11000000-00000000
// CHECK: mov     z0.h, #0 // encoding: [0x00,0xc0,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11000000-00000000
MOV     Z0.H, #0  // 00100101-01111000-11000000-00000000
// CHECK: mov     z0.h, #0 // encoding: [0x00,0xc0,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11000000-00000000
mov     z31.d, p7/m, sp  // 00000101-11101000-10111111-11111111
// CHECK: mov     z31.d, p7/m, sp // encoding: [0xff,0xbf,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10111111-11111111
MOV     Z31.D, P7/M, SP  // 00000101-11101000-10111111-11111111
// CHECK: mov     z31.d, p7/m, sp // encoding: [0xff,0xbf,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10111111-11111111
mov     z0.h, w0  // 00000101-01100000-00111000-00000000
// CHECK: mov     z0.h, w0 // encoding: [0x00,0x38,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-00111000-00000000
MOV     Z0.H, W0  // 00000101-01100000-00111000-00000000
// CHECK: mov     z0.h, w0 // encoding: [0x00,0x38,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-00111000-00000000
mov     z0.s, p0/m, s0  // 00000101-10100000-10000000-00000000
// CHECK: mov     z0.s, p0/m, s0 // encoding: [0x00,0x80,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10000000-00000000
MOV     Z0.S, P0/M, S0  // 00000101-10100000-10000000-00000000
// CHECK: mov     z0.s, p0/m, s0 // encoding: [0x00,0x80,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10000000-00000000
mov     z31.h, p15/z, #-1, lsl #8  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
MOV     Z31.H, P15/Z, #-1, LSL #8  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
mov     z31.h, p15/z, #-256  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
MOV     Z31.H, P15/Z, #-256  // 00000101-01011111-00111111-11111111
// CHECK: mov     z31.h, p15/z, #-256 // encoding: [0xff,0x3f,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-00111111-11111111
mov     z31.d, #-1, lsl #8  // 00100101-11111000-11111111-11111111
// CHECK: mov     z31.d, #-256 // encoding: [0xff,0xff,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11111111-11111111
MOV     Z31.D, #-1, LSL #8  // 00100101-11111000-11111111-11111111
// CHECK: mov     z31.d, #-256 // encoding: [0xff,0xff,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11111111-11111111
mov     z31.d, #-256  // 00100101-11111000-11111111-11111111
// CHECK: mov     z31.d, #-256 // encoding: [0xff,0xff,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11111111-11111111
MOV     Z31.D, #-256  // 00100101-11111000-11111111-11111111
// CHECK: mov     z31.d, #-256 // encoding: [0xff,0xff,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11111111-11111111
mov     z31.s, p15/m, #-1, lsl #8  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
MOV     Z31.S, P15/M, #-1, LSL #8  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
mov     z31.s, p15/m, #-256  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
MOV     Z31.S, P15/M, #-256  // 00000101-10011111-01111111-11111111
// CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01111111-11111111
mov     z31.s, wsp  // 00000101-10100000-00111011-11111111
// CHECK: mov     z31.s, wsp // encoding: [0xff,0x3b,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-00111011-11111111
MOV     Z31.S, WSP  // 00000101-10100000-00111011-11111111
// CHECK: mov     z31.s, wsp // encoding: [0xff,0x3b,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-00111011-11111111
mov     z21.s, p5/z, #-86  // 00000101-10010101-00010101-01010101
// CHECK: mov     z21.s, p5/z, #-86 // encoding: [0x55,0x15,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-00010101-01010101
MOV     Z21.S, P5/Z, #-86  // 00000101-10010101-00010101-01010101
// CHECK: mov     z21.s, p5/z, #-86 // encoding: [0x55,0x15,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-00010101-01010101
mov     z31.d, z31.d  // 00000100-01111111-00110011-11111111
// CHECK: mov     z31.d, z31.d // encoding: [0xff,0x33,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-00110011-11111111
MOV     Z31.D, Z31.D  // 00000100-01111111-00110011-11111111
// CHECK: mov     z31.d, z31.d // encoding: [0xff,0x33,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-00110011-11111111
mov     z21.d, p5/m, x10  // 00000101-11101000-10110101-01010101
// CHECK: mov     z21.d, p5/m, x10 // encoding: [0x55,0xb5,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10110101-01010101
MOV     Z21.D, P5/M, X10  // 00000101-11101000-10110101-01010101
// CHECK: mov     z21.d, p5/m, x10 // encoding: [0x55,0xb5,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10110101-01010101
mov     z0.d, p0/m, #0  // 00000101-11010000-01000000-00000000
// CHECK: mov     z0.d, p0/m, #0 // encoding: [0x00,0x40,0xd0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010000-01000000-00000000
MOV     Z0.D, P0/M, #0  // 00000101-11010000-01000000-00000000
// CHECK: mov     z0.d, p0/m, #0 // encoding: [0x00,0x40,0xd0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010000-01000000-00000000
mov     z21.h, p5/m, w10  // 00000101-01101000-10110101-01010101
// CHECK: mov     z21.h, p5/m, w10 // encoding: [0x55,0xb5,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10110101-01010101
MOV     Z21.H, P5/M, W10  // 00000101-01101000-10110101-01010101
// CHECK: mov     z21.h, p5/m, w10 // encoding: [0x55,0xb5,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-10110101-01010101
mov     z23.b, z13.b[20]  // 00000101-01101001-00100001-10110111
// CHECK: mov     z23.b, z13.b[20] // encoding: [0xb7,0x21,0x69,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101001-00100001-10110111
MOV     Z23.B, Z13.B[20]  // 00000101-01101001-00100001-10110111
// CHECK: mov     z23.b, z13.b[20] // encoding: [0xb7,0x21,0x69,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101001-00100001-10110111
mov     z21.b, p5/z, #-86  // 00000101-00010101-00010101-01010101
// CHECK: mov     z21.b, p5/z, #-86 // encoding: [0x55,0x15,0x15,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010101-00010101-01010101
MOV     Z21.B, P5/Z, #-86  // 00000101-00010101-00010101-01010101
// CHECK: mov     z21.b, p5/z, #-86 // encoding: [0x55,0x15,0x15,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010101-00010101-01010101
mov     z23.h, #109, lsl #8  // 00100101-01111000-11101101-10110111
// CHECK: mov     z23.h, #27904 // encoding: [0xb7,0xed,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11101101-10110111
MOV     Z23.H, #109, LSL #8  // 00100101-01111000-11101101-10110111
// CHECK: mov     z23.h, #27904 // encoding: [0xb7,0xed,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11101101-10110111
mov     z23.h, #27904  // 00100101-01111000-11101101-10110111
// CHECK: mov     z23.h, #27904 // encoding: [0xb7,0xed,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11101101-10110111
MOV     Z23.H, #27904  // 00100101-01111000-11101101-10110111
// CHECK: mov     z23.h, #27904 // encoding: [0xb7,0xed,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11101101-10110111
mov     z31.d, p15/m, z31.d  // 00000101-11111111-11111111-11111111
// CHECK: mov     z31.d, p15/m, z31.d // encoding: [0xff,0xff,0xff,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111111-11111111-11111111
MOV     Z31.D, P15/M, Z31.D  // 00000101-11111111-11111111-11111111
// CHECK: mov     z31.d, p15/m, z31.d // encoding: [0xff,0xff,0xff,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111111-11111111-11111111
mov     z0.d, p0/m, d0  // 00000101-11100000-10000000-00000000
// CHECK: mov     z0.d, p0/m, d0 // encoding: [0x00,0x80,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10000000-00000000
MOV     Z0.D, P0/M, D0  // 00000101-11100000-10000000-00000000
// CHECK: mov     z0.d, p0/m, d0 // encoding: [0x00,0x80,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-10000000-00000000
mov     z23.b, w13  // 00000101-00100000-00111001-10110111
// CHECK: mov     z23.b, w13 // encoding: [0xb7,0x39,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00111001-10110111
MOV     Z23.B, W13  // 00000101-00100000-00111001-10110111
// CHECK: mov     z23.b, w13 // encoding: [0xb7,0x39,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00111001-10110111
mov     z23.s, p8/m, #109, lsl #8  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
MOV     Z23.S, P8/M, #109, LSL #8  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
mov     z23.s, p8/m, #27904  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
MOV     Z23.S, P8/M, #27904  // 00000101-10011000-01101101-10110111
// CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01101101-10110111
mov     z0.b, #0  // 00100101-00111000-11000000-00000000
// CHECK: mov     z0.b, #0 // encoding: [0x00,0xc0,0x38,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00111000-11000000-00000000
MOV     Z0.B, #0  // 00100101-00111000-11000000-00000000
// CHECK: mov     z0.b, #0 // encoding: [0x00,0xc0,0x38,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00111000-11000000-00000000
mov     z21.s, w10  // 00000101-10100000-00111001-01010101
// CHECK: mov     z21.s, w10 // encoding: [0x55,0x39,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-00111001-01010101
MOV     Z21.S, W10  // 00000101-10100000-00111001-01010101
// CHECK: mov     z21.s, w10 // encoding: [0x55,0x39,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-00111001-01010101
mov     z1.d, #0xffff00000003ffff  // 00000101-11000010-10000100-00100001
// CHECK: mov     z1.d, #0xffff00000003ffff // encoding: [0x21,0x84,0xc2,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11000010-10000100-00100001
MOV     Z1.D, #0xFFFF00000003FFFF  // 00000101-11000010-10000100-00100001
// CHECK: mov     z1.d, #0xffff00000003ffff // encoding: [0x21,0x84,0xc2,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11000010-10000100-00100001
mov     z0.b, p0/m, w0  // 00000101-00101000-10100000-00000000
// CHECK: mov     z0.b, p0/m, w0 // encoding: [0x00,0xa0,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10100000-00000000
MOV     Z0.B, P0/M, W0  // 00000101-00101000-10100000-00000000
// CHECK: mov     z0.b, p0/m, w0 // encoding: [0x00,0xa0,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10100000-00000000
mov     z31.s, p15/z, #-1, lsl #8  // 00000101-10011111-00111111-11111111
// CHECK: mov     z31.s, p15/z, #-256 // encoding: [0xff,0x3f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-00111111-11111111
MOV     Z31.S, P15/Z, #-1, LSL #8  // 00000101-10011111-00111111-11111111
// CHECK: mov     z31.s, p15/z, #-256 // encoding: [0xff,0x3f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-00111111-11111111
mov     z31.s, p15/z, #-256  // 00000101-10011111-00111111-11111111
// CHECK: mov     z31.s, p15/z, #-256 // encoding: [0xff,0x3f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-00111111-11111111
MOV     Z31.S, P15/Z, #-256  // 00000101-10011111-00111111-11111111
// CHECK: mov     z31.s, p15/z, #-256 // encoding: [0xff,0x3f,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-00111111-11111111
mov     z31.d, sp  // 00000101-11100000-00111011-11111111
// CHECK: mov     z31.d, sp // encoding: [0xff,0x3b,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-00111011-11111111
MOV     Z31.D, SP  // 00000101-11100000-00111011-11111111
// CHECK: mov     z31.d, sp // encoding: [0xff,0x3b,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-00111011-11111111
mov     z23.d, #109, lsl #8  // 00100101-11111000-11101101-10110111
// CHECK: mov     z23.d, #27904 // encoding: [0xb7,0xed,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11101101-10110111
MOV     Z23.D, #109, LSL #8  // 00100101-11111000-11101101-10110111
// CHECK: mov     z23.d, #27904 // encoding: [0xb7,0xed,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11101101-10110111
mov     z23.d, #27904  // 00100101-11111000-11101101-10110111
// CHECK: mov     z23.d, #27904 // encoding: [0xb7,0xed,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11101101-10110111
MOV     Z23.D, #27904  // 00100101-11111000-11101101-10110111
// CHECK: mov     z23.d, #27904 // encoding: [0xb7,0xed,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11101101-10110111
mov     z31.b, wsp  // 00000101-00100000-00111011-11111111
// CHECK: mov     z31.b, wsp // encoding: [0xff,0x3b,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00111011-11111111
MOV     Z31.B, WSP  // 00000101-00100000-00111011-11111111
// CHECK: mov     z31.b, wsp // encoding: [0xff,0x3b,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00111011-11111111
mov     z0.b, p0/m, z0.b  // 00000101-00100000-11000000-00000000
// CHECK: mov     z0.b, p0/m, z0.b // encoding: [0x00,0xc0,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-11000000-00000000
MOV     Z0.B, P0/M, Z0.B  // 00000101-00100000-11000000-00000000
// CHECK: mov     z0.b, p0/m, z0.b // encoding: [0x00,0xc0,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-11000000-00000000
mov     z31.b, z31.b[63]  // 00000101-11111111-00100011-11111111
// CHECK: mov     z31.b, z31.b[63] // encoding: [0xff,0x23,0xff,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111111-00100011-11111111
MOV     Z31.B, Z31.B[63]  // 00000101-11111111-00100011-11111111
// CHECK: mov     z31.b, z31.b[63] // encoding: [0xff,0x23,0xff,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111111-00100011-11111111
mov     z21.h, p5/m, z10.h  // 00000101-01110101-11010101-01010101
// CHECK: mov     z21.h, p5/m, z10.h // encoding: [0x55,0xd5,0x75,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110101-11010101-01010101
MOV     Z21.H, P5/M, Z10.H  // 00000101-01110101-11010101-01010101
// CHECK: mov     z21.h, p5/m, z10.h // encoding: [0x55,0xd5,0x75,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110101-11010101-01010101
mov     z23.d, p8/z, #109, lsl #8  // 00000101-11011000-00101101-10110111
// CHECK: mov     z23.d, p8/z, #27904 // encoding: [0xb7,0x2d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-00101101-10110111
MOV     Z23.D, P8/Z, #109, LSL #8  // 00000101-11011000-00101101-10110111
// CHECK: mov     z23.d, p8/z, #27904 // encoding: [0xb7,0x2d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-00101101-10110111
mov     z23.d, p8/z, #27904  // 00000101-11011000-00101101-10110111
// CHECK: mov     z23.d, p8/z, #27904 // encoding: [0xb7,0x2d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-00101101-10110111
MOV     Z23.D, P8/Z, #27904  // 00000101-11011000-00101101-10110111
// CHECK: mov     z23.d, p8/z, #27904 // encoding: [0xb7,0x2d,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-00101101-10110111
mov     z21.b, z10.b[26]  // 00000101-01110101-00100001-01010101
// CHECK: mov     z21.b, z10.b[26] // encoding: [0x55,0x21,0x75,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110101-00100001-01010101
MOV     Z21.B, Z10.B[26]  // 00000101-01110101-00100001-01010101
// CHECK: mov     z21.b, z10.b[26] // encoding: [0x55,0x21,0x75,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110101-00100001-01010101
mov     z0.q, q0  // 00000101-00110000-00100000-00000000
// CHECK: mov     z0.q, q0 // encoding: [0x00,0x20,0x30,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110000-00100000-00000000
MOV     Z0.Q, Q0  // 00000101-00110000-00100000-00000000
// CHECK: mov     z0.q, q0 // encoding: [0x00,0x20,0x30,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110000-00100000-00000000
mov     z0.h, p0/z, #0  // 00000101-01010000-00000000-00000000
// CHECK: mov     z0.h, p0/z, #0 // encoding: [0x00,0x00,0x50,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010000-00000000-00000000
MOV     Z0.H, P0/Z, #0  // 00000101-01010000-00000000-00000000
// CHECK: mov     z0.h, p0/z, #0 // encoding: [0x00,0x00,0x50,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010000-00000000-00000000
mov     z21.s, #-86  // 00100101-10111000-11010101-01010101
// CHECK: mov     z21.s, #-86 // encoding: [0x55,0xd5,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11010101-01010101
MOV     Z21.S, #-86  // 00100101-10111000-11010101-01010101
// CHECK: mov     z21.s, #-86 // encoding: [0x55,0xd5,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11010101-01010101
mov     z0.d, #0  // 00100101-11111000-11000000-00000000
// CHECK: mov     z0.d, #0 // encoding: [0x00,0xc0,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11000000-00000000
MOV     Z0.D, #0  // 00100101-11111000-11000000-00000000
// CHECK: mov     z0.d, #0 // encoding: [0x00,0xc0,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11000000-00000000
mov     z31.s, z31.s[15]  // 00000101-11111100-00100011-11111111
// CHECK: mov     z31.s, z31.s[15] // encoding: [0xff,0x23,0xfc,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111100-00100011-11111111
MOV     Z31.S, Z31.S[15]  // 00000101-11111100-00100011-11111111
// CHECK: mov     z31.s, z31.s[15] // encoding: [0xff,0x23,0xfc,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111100-00100011-11111111
mov     z0.d, d12  // 00000101-00101000-00100001-10000000
// CHECK: mov     z0.d, d12 // encoding: [0x80,0x21,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-00100001-10000000
MOV     Z0.D, D12  // 00000101-00101000-00100001-10000000
// CHECK: mov     z0.d, d12 // encoding: [0x80,0x21,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-00100001-10000000
mov     z21.d, z10.d[3]  // 00000101-01111000-00100001-01010101
// CHECK: mov     z21.d, z10.d[3] // encoding: [0x55,0x21,0x78,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01111000-00100001-01010101
MOV     Z21.D, Z10.D[3]  // 00000101-01111000-00100001-01010101
// CHECK: mov     z21.d, z10.d[3] // encoding: [0x55,0x21,0x78,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01111000-00100001-01010101
mov     z23.d, z13.d[2]  // 00000101-01101000-00100001-10110111
// CHECK: mov     z23.d, z13.d[2] // encoding: [0xb7,0x21,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-00100001-10110111
MOV     Z23.D, Z13.D[2]  // 00000101-01101000-00100001-10110111
// CHECK: mov     z23.d, z13.d[2] // encoding: [0xb7,0x21,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-00100001-10110111
mov     z1.b, p14/m, #33  // 00000101-00011110-01000100-00100001
// CHECK: mov     z1.b, p14/m, #33 // encoding: [0x21,0x44,0x1e,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00011110-01000100-00100001
MOV     Z1.B, P14/M, #33  // 00000101-00011110-01000100-00100001
// CHECK: mov     z1.b, p14/m, #33 // encoding: [0x21,0x44,0x1e,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00011110-01000100-00100001
mov     z23.b, p3/m, w13  // 00000101-00101000-10101101-10110111
// CHECK: mov     z23.b, p3/m, w13 // encoding: [0xb7,0xad,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10101101-10110111
MOV     Z23.B, P3/M, W13  // 00000101-00101000-10101101-10110111
// CHECK: mov     z23.b, p3/m, w13 // encoding: [0xb7,0xad,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-10101101-10110111
mov     z0.h, p0/m, h0  // 00000101-01100000-10000000-00000000
// CHECK: mov     z0.h, p0/m, h0 // encoding: [0x00,0x80,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10000000-00000000
MOV     Z0.H, P0/M, H0  // 00000101-01100000-10000000-00000000
// CHECK: mov     z0.h, p0/m, h0 // encoding: [0x00,0x80,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-10000000-00000000
mov     p5.b, p5/m, p10.b  // 00100101-00000101-01010111-01010101
// CHECK: mov     p5.b, p5/m, p10.b // encoding: [0x55,0x57,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-01010111-01010101
MOV     P5.B, P5/M, P10.B  // 00100101-00000101-01010111-01010101
// CHECK: mov     p5.b, p5/m, p10.b // encoding: [0x55,0x57,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-01010111-01010101
mov     z23.h, p8/m, #109, lsl #8  // 00000101-01011000-01101101-10110111
// CHECK: mov     z23.h, p8/m, #27904 // encoding: [0xb7,0x6d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01101101-10110111
MOV     Z23.H, P8/M, #109, LSL #8  // 00000101-01011000-01101101-10110111
// CHECK: mov     z23.h, p8/m, #27904 // encoding: [0xb7,0x6d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01101101-10110111
mov     z23.h, p8/m, #27904  // 00000101-01011000-01101101-10110111
// CHECK: mov     z23.h, p8/m, #27904 // encoding: [0xb7,0x6d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01101101-10110111
MOV     Z23.H, P8/M, #27904  // 00000101-01011000-01101101-10110111
// CHECK: mov     z23.h, p8/m, #27904 // encoding: [0xb7,0x6d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01101101-10110111
mov     z0.d, p0/m, x0  // 00000101-11101000-10100000-00000000
// CHECK: mov     z0.d, p0/m, x0 // encoding: [0x00,0xa0,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10100000-00000000
MOV     Z0.D, P0/M, X0  // 00000101-11101000-10100000-00000000
// CHECK: mov     z0.d, p0/m, x0 // encoding: [0x00,0xa0,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-10100000-00000000
mov     z21.b, #-86  // 00100101-00111000-11010101-01010101
// CHECK: mov     z21.b, #-86 // encoding: [0x55,0xd5,0x38,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00111000-11010101-01010101
MOV     Z21.B, #-86  // 00100101-00111000-11010101-01010101
// CHECK: mov     z21.b, #-86 // encoding: [0x55,0xd5,0x38,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00111000-11010101-01010101
mov     z0.b, p0/z, #0  // 00000101-00010000-00000000-00000000
// CHECK: mov     z0.b, p0/z, #0 // encoding: [0x00,0x00,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-00000000-00000000
MOV     Z0.B, P0/Z, #0  // 00000101-00010000-00000000-00000000
// CHECK: mov     z0.b, p0/z, #0 // encoding: [0x00,0x00,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-00000000-00000000
mov     z23.s, z13.s[5]  // 00000101-01101100-00100001-10110111
// CHECK: mov     z23.s, z13.s[5] // encoding: [0xb7,0x21,0x6c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101100-00100001-10110111
MOV     Z23.S, Z13.S[5]  // 00000101-01101100-00100001-10110111
// CHECK: mov     z23.s, z13.s[5] // encoding: [0xb7,0x21,0x6c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101100-00100001-10110111
mov     z21.d, p5/z, #-86  // 00000101-11010101-00010101-01010101
// CHECK: mov     z21.d, p5/z, #-86 // encoding: [0x55,0x15,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-00010101-01010101
MOV     Z21.D, P5/Z, #-86  // 00000101-11010101-00010101-01010101
// CHECK: mov     z21.d, p5/z, #-86 // encoding: [0x55,0x15,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-00010101-01010101
mov     z23.s, p3/m, s13  // 00000101-10100000-10001101-10110111
// CHECK: mov     z23.s, p3/m, s13 // encoding: [0xb7,0x8d,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10001101-10110111
MOV     Z23.S, P3/M, S13  // 00000101-10100000-10001101-10110111
// CHECK: mov     z23.s, p3/m, s13 // encoding: [0xb7,0x8d,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-10001101-10110111
mov     z23.h, p8/z, #109, lsl #8  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
MOV     Z23.H, P8/Z, #109, LSL #8  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
mov     z23.h, p8/z, #27904  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
MOV     Z23.H, P8/Z, #27904  // 00000101-01011000-00101101-10110111
// CHECK: mov     z23.h, p8/z, #27904 // encoding: [0xb7,0x2d,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-00101101-10110111
mov     z1.b, #33  // 00100101-00111000-11000100-00100001
// CHECK: mov     z1.b, #33 // encoding: [0x21,0xc4,0x38,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00111000-11000100-00100001
MOV     Z1.B, #33  // 00100101-00111000-11000100-00100001
// CHECK: mov     z1.b, #33 // encoding: [0x21,0xc4,0x38,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00111000-11000100-00100001
mov     z24.q, q19  // 00000101-00110000-00100010-01111000
// CHECK: mov     z24.q, q19 // encoding: [0x78,0x22,0x30,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110000-00100010-01111000
MOV     Z24.Q, Q19  // 00000101-00110000-00100010-01111000
// CHECK: mov     z24.q, q19 // encoding: [0x78,0x22,0x30,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110000-00100010-01111000
mov     z0.s, s12  // 00000101-00100100-00100001-10000000
// CHECK: mov     z0.s, s12 // encoding: [0x80,0x21,0x24,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100100-00100001-10000000
MOV     Z0.S, S12  // 00000101-00100100-00100001-10000000
// CHECK: mov     z0.s, s12 // encoding: [0x80,0x21,0x24,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100100-00100001-10000000
mov     z23.q, z13.q[1]  // 00000101-01110000-00100001-10110111
// CHECK: mov     z23.q, z13.q[1] // encoding: [0xb7,0x21,0x70,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110000-00100001-10110111
MOV     Z23.Q, Z13.Q[1]  // 00000101-01110000-00100001-10110111
// CHECK: mov     z23.q, z13.q[1] // encoding: [0xb7,0x21,0x70,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110000-00100001-10110111
mov     z0.s, s0  // 00000101-00100100-00100000-00000000
// CHECK: mov     z0.s, s0 // encoding: [0x00,0x20,0x24,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100100-00100000-00000000
MOV     Z0.S, S0  // 00000101-00100100-00100000-00000000
// CHECK: mov     z0.s, s0 // encoding: [0x00,0x20,0x24,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100100-00100000-00000000
mov     z31.b, p15/m, z31.b  // 00000101-00111111-11111111-11111111
// CHECK: mov     z31.b, p15/m, z31.b // encoding: [0xff,0xff,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00111111-11111111-11111111
MOV     Z31.B, P15/M, Z31.B  // 00000101-00111111-11111111-11111111
// CHECK: mov     z31.b, p15/m, z31.b // encoding: [0xff,0xff,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00111111-11111111-11111111
mov     z0.h, p0/m, z0.h  // 00000101-01100000-11000000-00000000
// CHECK: mov     z0.h, p0/m, z0.h // encoding: [0x00,0xc0,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-11000000-00000000
MOV     Z0.H, P0/M, Z0.H  // 00000101-01100000-11000000-00000000
// CHECK: mov     z0.h, p0/m, z0.h // encoding: [0x00,0xc0,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-11000000-00000000
mov     z23.d, x13  // 00000101-11100000-00111001-10110111
// CHECK: mov     z23.d, x13 // encoding: [0xb7,0x39,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-00111001-10110111
MOV     Z23.D, X13  // 00000101-11100000-00111001-10110111
// CHECK: mov     z23.d, x13 // encoding: [0xb7,0x39,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-00111001-10110111
mov     z0.b, p0/m, #0  // 00000101-00010000-01000000-00000000
// CHECK: mov     z0.b, p0/m, #0 // encoding: [0x00,0x40,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-01000000-00000000
MOV     Z0.B, P0/M, #0  // 00000101-00010000-01000000-00000000
// CHECK: mov     z0.b, p0/m, #0 // encoding: [0x00,0x40,0x10,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00010000-01000000-00000000
mov     z23.b, p3/m, b13  // 00000101-00100000-10001101-10110111
// CHECK: mov     z23.b, p3/m, b13 // encoding: [0xb7,0x8d,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10001101-10110111
MOV     Z23.B, P3/M, B13  // 00000101-00100000-10001101-10110111
// CHECK: mov     z23.b, p3/m, b13 // encoding: [0xb7,0x8d,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-10001101-10110111
mov     z0.d, z0.d  // 00000100-01100000-00110000-00000000
// CHECK: mov     z0.d, z0.d // encoding: [0x00,0x30,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-00110000-00000000
MOV     Z0.D, Z0.D  // 00000100-01100000-00110000-00000000
// CHECK: mov     z0.d, z0.d // encoding: [0x00,0x30,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-00110000-00000000
