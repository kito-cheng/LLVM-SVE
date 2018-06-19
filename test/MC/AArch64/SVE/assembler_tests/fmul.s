// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmul    z31.s, p7/m, z31.s, #2.0  // 01100101-10011010-10011100-00111111
// CHECK: fmul    z31.s, p7/m, z31.s, #2.0{{0*}} // encoding: [0x3f,0x9c,0x9a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011010-10011100-00111111
FMUL    Z31.S, P7/M, Z31.S, #2.0  // 01100101-10011010-10011100-00111111
// CHECK: fmul    z31.s, p7/m, z31.s, #2.0{{0*}} // encoding: [0x3f,0x9c,0x9a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011010-10011100-00111111
fmul    z0.d, p0/m, z0.d, z0.d  // 01100101-11000010-10000000-00000000
// CHECK: fmul    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xc2,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000010-10000000-00000000
FMUL    Z0.D, P0/M, Z0.D, Z0.D  // 01100101-11000010-10000000-00000000
// CHECK: fmul    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xc2,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000010-10000000-00000000
fmul    z31.h, p7/m, z31.h, #2.0  // 01100101-01011010-10011100-00111111
// CHECK: fmul    z31.h, p7/m, z31.h, #2.0{{0*}} // encoding: [0x3f,0x9c,0x5a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011010-10011100-00111111
FMUL    Z31.H, P7/M, Z31.H, #2.0  // 01100101-01011010-10011100-00111111
// CHECK: fmul    z31.h, p7/m, z31.h, #2.0{{0*}} // encoding: [0x3f,0x9c,0x5a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011010-10011100-00111111
fmul    z21.s, p5/m, z21.s, #0.5  // 01100101-10011010-10010100-00010101
// CHECK: fmul    z21.s, p5/m, z21.s, #0.5{{0*}} // encoding: [0x15,0x94,0x9a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011010-10010100-00010101
FMUL    Z21.S, P5/M, Z21.S, #0.5  // 01100101-10011010-10010100-00010101
// CHECK: fmul    z21.s, p5/m, z21.s, #0.5{{0*}} // encoding: [0x15,0x94,0x9a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011010-10010100-00010101
fmul    z23.h, p3/m, z23.h, z13.h  // 01100101-01000010-10001101-10110111
// CHECK: fmul    z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x42,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000010-10001101-10110111
FMUL    Z23.H, P3/M, Z23.H, Z13.H  // 01100101-01000010-10001101-10110111
// CHECK: fmul    z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x42,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000010-10001101-10110111
fmul    z0.h, p0/m, z0.h, #0.5  // 01100101-01011010-10000000-00000000
// CHECK: fmul    z0.h, p0/m, z0.h, #0.5{{0*}} // encoding: [0x00,0x80,0x5a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011010-10000000-00000000
FMUL    Z0.H, P0/M, Z0.H, #0.5  // 01100101-01011010-10000000-00000000
// CHECK: fmul    z0.h, p0/m, z0.h, #0.5{{0*}} // encoding: [0x00,0x80,0x5a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011010-10000000-00000000
fmul    z21.s, z10.s, z21.s  // 01100101-10010101-00001001-01010101
// CHECK: fmul    z21.s, z10.s, z21.s // encoding: [0x55,0x09,0x95,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010101-00001001-01010101
FMUL    Z21.S, Z10.S, Z21.S  // 01100101-10010101-00001001-01010101
// CHECK: fmul    z21.s, z10.s, z21.s // encoding: [0x55,0x09,0x95,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010101-00001001-01010101
fmul    z0.d, p0/m, z0.d, #0.5  // 01100101-11011010-10000000-00000000
// CHECK: fmul    z0.d, p0/m, z0.d, #0.5{{0*}} // encoding: [0x00,0x80,0xda,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011010-10000000-00000000
FMUL    Z0.D, P0/M, Z0.D, #0.5  // 01100101-11011010-10000000-00000000
// CHECK: fmul    z0.d, p0/m, z0.d, #0.5{{0*}} // encoding: [0x00,0x80,0xda,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011010-10000000-00000000
fmul    z21.h, z10.h, z5.h[6]  // 01100100-01110101-00100001-01010101
// CHECK: fmul    z21.h, z10.h, z5.h[6] // encoding: [0x55,0x21,0x75,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01110101-00100001-01010101
FMUL    Z21.H, Z10.H, Z5.H[6]  // 01100100-01110101-00100001-01010101
// CHECK: fmul    z21.h, z10.h, z5.h[6] // encoding: [0x55,0x21,0x75,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01110101-00100001-01010101
fmul    z0.d, z0.d, z0.d[0]  // 01100100-11100000-00100000-00000000
// CHECK: fmul    z0.d, z0.d, z0.d[0] // encoding: [0x00,0x20,0xe0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11100000-00100000-00000000
FMUL    Z0.D, Z0.D, Z0.D[0]  // 01100100-11100000-00100000-00000000
// CHECK: fmul    z0.d, z0.d, z0.d[0] // encoding: [0x00,0x20,0xe0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11100000-00100000-00000000
fmul    z0.s, p0/m, z0.s, #0.5  // 01100101-10011010-10000000-00000000
// CHECK: fmul    z0.s, p0/m, z0.s, #0.5{{0*}} // encoding: [0x00,0x80,0x9a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011010-10000000-00000000
FMUL    Z0.S, P0/M, Z0.S, #0.5  // 01100101-10011010-10000000-00000000
// CHECK: fmul    z0.s, p0/m, z0.s, #0.5{{0*}} // encoding: [0x00,0x80,0x9a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011010-10000000-00000000
fmul    z31.d, p7/m, z31.d, z31.d  // 01100101-11000010-10011111-11111111
// CHECK: fmul    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xc2,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000010-10011111-11111111
FMUL    Z31.D, P7/M, Z31.D, Z31.D  // 01100101-11000010-10011111-11111111
// CHECK: fmul    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xc2,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000010-10011111-11111111
fmul    z31.d, z31.d, z31.d  // 01100101-11011111-00001011-11111111
// CHECK: fmul    z31.d, z31.d, z31.d // encoding: [0xff,0x0b,0xdf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011111-00001011-11111111
FMUL    Z31.D, Z31.D, Z31.D  // 01100101-11011111-00001011-11111111
// CHECK: fmul    z31.d, z31.d, z31.d // encoding: [0xff,0x0b,0xdf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011111-00001011-11111111
fmul    z31.s, z31.s, z31.s  // 01100101-10011111-00001011-11111111
// CHECK: fmul    z31.s, z31.s, z31.s // encoding: [0xff,0x0b,0x9f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011111-00001011-11111111
FMUL    Z31.S, Z31.S, Z31.S  // 01100101-10011111-00001011-11111111
// CHECK: fmul    z31.s, z31.s, z31.s // encoding: [0xff,0x0b,0x9f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011111-00001011-11111111
fmul    z21.h, p5/m, z21.h, #0.5  // 01100101-01011010-10010100-00010101
// CHECK: fmul    z21.h, p5/m, z21.h, #0.5{{0*}} // encoding: [0x15,0x94,0x5a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011010-10010100-00010101
FMUL    Z21.H, P5/M, Z21.H, #0.5  // 01100101-01011010-10010100-00010101
// CHECK: fmul    z21.h, p5/m, z21.h, #0.5{{0*}} // encoding: [0x15,0x94,0x5a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011010-10010100-00010101
fmul    z0.s, p0/m, z0.s, z0.s  // 01100101-10000010-10000000-00000000
// CHECK: fmul    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x82,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000010-10000000-00000000
FMUL    Z0.S, P0/M, Z0.S, Z0.S  // 01100101-10000010-10000000-00000000
// CHECK: fmul    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x82,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000010-10000000-00000000
fmul    z21.h, z10.h, z21.h  // 01100101-01010101-00001001-01010101
// CHECK: fmul    z21.h, z10.h, z21.h // encoding: [0x55,0x09,0x55,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010101-00001001-01010101
FMUL    Z21.H, Z10.H, Z21.H  // 01100101-01010101-00001001-01010101
// CHECK: fmul    z21.h, z10.h, z21.h // encoding: [0x55,0x09,0x55,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010101-00001001-01010101
fmul    z23.d, p3/m, z23.d, z13.d  // 01100101-11000010-10001101-10110111
// CHECK: fmul    z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xc2,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000010-10001101-10110111
FMUL    Z23.D, P3/M, Z23.D, Z13.D  // 01100101-11000010-10001101-10110111
// CHECK: fmul    z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xc2,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000010-10001101-10110111
fmul    z31.h, p7/m, z31.h, z31.h  // 01100101-01000010-10011111-11111111
// CHECK: fmul    z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x42,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000010-10011111-11111111
FMUL    Z31.H, P7/M, Z31.H, Z31.H  // 01100101-01000010-10011111-11111111
// CHECK: fmul    z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x42,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000010-10011111-11111111
fmul    z23.s, z13.s, z8.s  // 01100101-10001000-00001001-10110111
// CHECK: fmul    z23.s, z13.s, z8.s // encoding: [0xb7,0x09,0x88,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001000-00001001-10110111
FMUL    Z23.S, Z13.S, Z8.S  // 01100101-10001000-00001001-10110111
// CHECK: fmul    z23.s, z13.s, z8.s // encoding: [0xb7,0x09,0x88,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001000-00001001-10110111
fmul    z31.d, p7/m, z31.d, #2.0  // 01100101-11011010-10011100-00111111
// CHECK: fmul    z31.d, p7/m, z31.d, #2.0{{0*}} // encoding: [0x3f,0x9c,0xda,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011010-10011100-00111111
FMUL    Z31.D, P7/M, Z31.D, #2.0  // 01100101-11011010-10011100-00111111
// CHECK: fmul    z31.d, p7/m, z31.d, #2.0{{0*}} // encoding: [0x3f,0x9c,0xda,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011010-10011100-00111111
fmul    z21.h, p5/m, z21.h, z10.h  // 01100101-01000010-10010101-01010101
// CHECK: fmul    z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x42,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000010-10010101-01010101
FMUL    Z21.H, P5/M, Z21.H, Z10.H  // 01100101-01000010-10010101-01010101
// CHECK: fmul    z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x42,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000010-10010101-01010101
fmul    z0.h, z0.h, z0.h  // 01100101-01000000-00001000-00000000
// CHECK: fmul    z0.h, z0.h, z0.h // encoding: [0x00,0x08,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00001000-00000000
FMUL    Z0.H, Z0.H, Z0.H  // 01100101-01000000-00001000-00000000
// CHECK: fmul    z0.h, z0.h, z0.h // encoding: [0x00,0x08,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00001000-00000000
fmul    z21.s, z10.s, z5.s[2]  // 01100100-10110101-00100001-01010101
// CHECK: fmul    z21.s, z10.s, z5.s[2] // encoding: [0x55,0x21,0xb5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10110101-00100001-01010101
FMUL    Z21.S, Z10.S, Z5.S[2]  // 01100100-10110101-00100001-01010101
// CHECK: fmul    z21.s, z10.s, z5.s[2] // encoding: [0x55,0x21,0xb5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10110101-00100001-01010101
fmul    z23.d, z13.d, z8.d  // 01100101-11001000-00001001-10110111
// CHECK: fmul    z23.d, z13.d, z8.d // encoding: [0xb7,0x09,0xc8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001000-00001001-10110111
FMUL    Z23.D, Z13.D, Z8.D  // 01100101-11001000-00001001-10110111
// CHECK: fmul    z23.d, z13.d, z8.d // encoding: [0xb7,0x09,0xc8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001000-00001001-10110111
fmul    z23.s, p3/m, z23.s, z13.s  // 01100101-10000010-10001101-10110111
// CHECK: fmul    z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x82,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000010-10001101-10110111
FMUL    Z23.S, P3/M, Z23.S, Z13.S  // 01100101-10000010-10001101-10110111
// CHECK: fmul    z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x82,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000010-10001101-10110111
fmul    z0.h, z0.h, z0.h[0]  // 01100100-00100000-00100000-00000000
// CHECK: fmul    z0.h, z0.h, z0.h[0] // encoding: [0x00,0x20,0x20,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-00100000-00100000-00000000
FMUL    Z0.H, Z0.H, Z0.H[0]  // 01100100-00100000-00100000-00000000
// CHECK: fmul    z0.h, z0.h, z0.h[0] // encoding: [0x00,0x20,0x20,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-00100000-00100000-00000000
fmul    z31.s, z31.s, z7.s[3]  // 01100100-10111111-00100011-11111111
// CHECK: fmul    z31.s, z31.s, z7.s[3] // encoding: [0xff,0x23,0xbf,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10111111-00100011-11111111
FMUL    Z31.S, Z31.S, Z7.S[3]  // 01100100-10111111-00100011-11111111
// CHECK: fmul    z31.s, z31.s, z7.s[3] // encoding: [0xff,0x23,0xbf,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10111111-00100011-11111111
fmul    z21.d, p5/m, z21.d, #0.5  // 01100101-11011010-10010100-00010101
// CHECK: fmul    z21.d, p5/m, z21.d, #0.5{{0*}} // encoding: [0x15,0x94,0xda,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011010-10010100-00010101
FMUL    Z21.D, P5/M, Z21.D, #0.5  // 01100101-11011010-10010100-00010101
// CHECK: fmul    z21.d, p5/m, z21.d, #0.5{{0*}} // encoding: [0x15,0x94,0xda,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011010-10010100-00010101
fmul    z31.s, p7/m, z31.s, z31.s  // 01100101-10000010-10011111-11111111
// CHECK: fmul    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x82,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000010-10011111-11111111
FMUL    Z31.S, P7/M, Z31.S, Z31.S  // 01100101-10000010-10011111-11111111
// CHECK: fmul    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x82,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000010-10011111-11111111
fmul    z23.h, z13.h, z0.h[5]  // 01100100-01101000-00100001-10110111
// CHECK: fmul    z23.h, z13.h, z0.h[5] // encoding: [0xb7,0x21,0x68,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01101000-00100001-10110111
FMUL    Z23.H, Z13.H, Z0.H[5]  // 01100100-01101000-00100001-10110111
// CHECK: fmul    z23.h, z13.h, z0.h[5] // encoding: [0xb7,0x21,0x68,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01101000-00100001-10110111
fmul    z23.h, p3/m, z23.h, #2.0  // 01100101-01011010-10001100-00110111
// CHECK: fmul    z23.h, p3/m, z23.h, #2.0{{0*}} // encoding: [0x37,0x8c,0x5a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011010-10001100-00110111
FMUL    Z23.H, P3/M, Z23.H, #2.0  // 01100101-01011010-10001100-00110111
// CHECK: fmul    z23.h, p3/m, z23.h, #2.0{{0*}} // encoding: [0x37,0x8c,0x5a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011010-10001100-00110111
fmul    z23.h, z13.h, z8.h  // 01100101-01001000-00001001-10110111
// CHECK: fmul    z23.h, z13.h, z8.h // encoding: [0xb7,0x09,0x48,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001000-00001001-10110111
FMUL    Z23.H, Z13.H, Z8.H  // 01100101-01001000-00001001-10110111
// CHECK: fmul    z23.h, z13.h, z8.h // encoding: [0xb7,0x09,0x48,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001000-00001001-10110111
fmul    z31.h, z31.h, z7.h[7]  // 01100100-01111111-00100011-11111111
// CHECK: fmul    z31.h, z31.h, z7.h[7] // encoding: [0xff,0x23,0x7f,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01111111-00100011-11111111
FMUL    Z31.H, Z31.H, Z7.H[7]  // 01100100-01111111-00100011-11111111
// CHECK: fmul    z31.h, z31.h, z7.h[7] // encoding: [0xff,0x23,0x7f,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01111111-00100011-11111111
fmul    z31.h, z31.h, z31.h  // 01100101-01011111-00001011-11111111
// CHECK: fmul    z31.h, z31.h, z31.h // encoding: [0xff,0x0b,0x5f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011111-00001011-11111111
FMUL    Z31.H, Z31.H, Z31.H  // 01100101-01011111-00001011-11111111
// CHECK: fmul    z31.h, z31.h, z31.h // encoding: [0xff,0x0b,0x5f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011111-00001011-11111111
fmul    z31.d, z31.d, z15.d[1]  // 01100100-11111111-00100011-11111111
// CHECK: fmul    z31.d, z31.d, z15.d[1] // encoding: [0xff,0x23,0xff,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11111111-00100011-11111111
FMUL    Z31.D, Z31.D, Z15.D[1]  // 01100100-11111111-00100011-11111111
// CHECK: fmul    z31.d, z31.d, z15.d[1] // encoding: [0xff,0x23,0xff,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11111111-00100011-11111111
fmul    z21.d, z10.d, z5.d[1]  // 01100100-11110101-00100001-01010101
// CHECK: fmul    z21.d, z10.d, z5.d[1] // encoding: [0x55,0x21,0xf5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11110101-00100001-01010101
FMUL    Z21.D, Z10.D, Z5.D[1]  // 01100100-11110101-00100001-01010101
// CHECK: fmul    z21.d, z10.d, z5.d[1] // encoding: [0x55,0x21,0xf5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11110101-00100001-01010101
fmul    z21.s, p5/m, z21.s, z10.s  // 01100101-10000010-10010101-01010101
// CHECK: fmul    z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x82,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000010-10010101-01010101
FMUL    Z21.S, P5/M, Z21.S, Z10.S  // 01100101-10000010-10010101-01010101
// CHECK: fmul    z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x82,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000010-10010101-01010101
fmul    z0.s, z0.s, z0.s[0]  // 01100100-10100000-00100000-00000000
// CHECK: fmul    z0.s, z0.s, z0.s[0] // encoding: [0x00,0x20,0xa0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10100000-00100000-00000000
FMUL    Z0.S, Z0.S, Z0.S[0]  // 01100100-10100000-00100000-00000000
// CHECK: fmul    z0.s, z0.s, z0.s[0] // encoding: [0x00,0x20,0xa0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10100000-00100000-00000000
fmul    z0.s, z0.s, z0.s  // 01100101-10000000-00001000-00000000
// CHECK: fmul    z0.s, z0.s, z0.s // encoding: [0x00,0x08,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00001000-00000000
FMUL    Z0.S, Z0.S, Z0.S  // 01100101-10000000-00001000-00000000
// CHECK: fmul    z0.s, z0.s, z0.s // encoding: [0x00,0x08,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00001000-00000000
fmul    z21.d, p5/m, z21.d, z10.d  // 01100101-11000010-10010101-01010101
// CHECK: fmul    z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xc2,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000010-10010101-01010101
FMUL    Z21.D, P5/M, Z21.D, Z10.D  // 01100101-11000010-10010101-01010101
// CHECK: fmul    z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xc2,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000010-10010101-01010101
fmul    z0.h, p0/m, z0.h, z0.h  // 01100101-01000010-10000000-00000000
// CHECK: fmul    z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x42,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000010-10000000-00000000
FMUL    Z0.H, P0/M, Z0.H, Z0.H  // 01100101-01000010-10000000-00000000
// CHECK: fmul    z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x42,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000010-10000000-00000000
fmul    z23.d, p3/m, z23.d, #2.0  // 01100101-11011010-10001100-00110111
// CHECK: fmul    z23.d, p3/m, z23.d, #2.0{{0*}} // encoding: [0x37,0x8c,0xda,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011010-10001100-00110111
FMUL    Z23.D, P3/M, Z23.D, #2.0  // 01100101-11011010-10001100-00110111
// CHECK: fmul    z23.d, p3/m, z23.d, #2.0{{0*}} // encoding: [0x37,0x8c,0xda,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011010-10001100-00110111
fmul    z23.d, z13.d, z8.d[0]  // 01100100-11101000-00100001-10110111
// CHECK: fmul    z23.d, z13.d, z8.d[0] // encoding: [0xb7,0x21,0xe8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11101000-00100001-10110111
FMUL    Z23.D, Z13.D, Z8.D[0]  // 01100100-11101000-00100001-10110111
// CHECK: fmul    z23.d, z13.d, z8.d[0] // encoding: [0xb7,0x21,0xe8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11101000-00100001-10110111
fmul    z23.s, p3/m, z23.s, #2.0  // 01100101-10011010-10001100-00110111
// CHECK: fmul    z23.s, p3/m, z23.s, #2.0{{0*}} // encoding: [0x37,0x8c,0x9a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011010-10001100-00110111
FMUL    Z23.S, P3/M, Z23.S, #2.0  // 01100101-10011010-10001100-00110111
// CHECK: fmul    z23.s, p3/m, z23.s, #2.0{{0*}} // encoding: [0x37,0x8c,0x9a,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011010-10001100-00110111
fmul    z23.s, z13.s, z0.s[1]  // 01100100-10101000-00100001-10110111
// CHECK: fmul    z23.s, z13.s, z0.s[1] // encoding: [0xb7,0x21,0xa8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10101000-00100001-10110111
FMUL    Z23.S, Z13.S, Z0.S[1]  // 01100100-10101000-00100001-10110111
// CHECK: fmul    z23.s, z13.s, z0.s[1] // encoding: [0xb7,0x21,0xa8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10101000-00100001-10110111
fmul    z21.d, z10.d, z21.d  // 01100101-11010101-00001001-01010101
// CHECK: fmul    z21.d, z10.d, z21.d // encoding: [0x55,0x09,0xd5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010101-00001001-01010101
FMUL    Z21.D, Z10.D, Z21.D  // 01100101-11010101-00001001-01010101
// CHECK: fmul    z21.d, z10.d, z21.d // encoding: [0x55,0x09,0xd5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010101-00001001-01010101
fmul    z0.d, z0.d, z0.d  // 01100101-11000000-00001000-00000000
// CHECK: fmul    z0.d, z0.d, z0.d // encoding: [0x00,0x08,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00001000-00000000
FMUL    Z0.D, Z0.D, Z0.D  // 01100101-11000000-00001000-00000000
// CHECK: fmul    z0.d, z0.d, z0.d // encoding: [0x00,0x08,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00001000-00000000
