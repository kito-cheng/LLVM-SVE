// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmaxnm  z31.s, p7/m, z31.s, z31.s  // 01100101-10000100-10011111-11111111
// CHECK: fmaxnm  z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-10011111-11111111
FMAXNM  Z31.S, P7/M, Z31.S, Z31.S  // 01100101-10000100-10011111-11111111
// CHECK: fmaxnm  z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-10011111-11111111
fmaxnm  z31.d, p7/m, z31.d, z31.d  // 01100101-11000100-10011111-11111111
// CHECK: fmaxnm  z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-10011111-11111111
FMAXNM  Z31.D, P7/M, Z31.D, Z31.D  // 01100101-11000100-10011111-11111111
// CHECK: fmaxnm  z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-10011111-11111111
fmaxnm  z31.h, p7/m, z31.h, #1.0  // 01100101-01011100-10011100-00111111
// CHECK: fmaxnm  z31.h, p7/m, z31.h, #1.0{{0*}} // encoding: [0x3f,0x9c,0x5c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011100-10011100-00111111
FMAXNM  Z31.H, P7/M, Z31.H, #1.0  // 01100101-01011100-10011100-00111111
// CHECK: fmaxnm  z31.h, p7/m, z31.h, #1.0{{0*}} // encoding: [0x3f,0x9c,0x5c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011100-10011100-00111111
fmaxnm  z23.s, p3/m, z23.s, #1.0  // 01100101-10011100-10001100-00110111
// CHECK: fmaxnm  z23.s, p3/m, z23.s, #1.0{{0*}} // encoding: [0x37,0x8c,0x9c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011100-10001100-00110111
FMAXNM  Z23.S, P3/M, Z23.S, #1.0  // 01100101-10011100-10001100-00110111
// CHECK: fmaxnm  z23.s, p3/m, z23.s, #1.0{{0*}} // encoding: [0x37,0x8c,0x9c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011100-10001100-00110111
fmaxnm  z23.s, p3/m, z23.s, z13.s  // 01100101-10000100-10001101-10110111
// CHECK: fmaxnm  z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-10001101-10110111
FMAXNM  Z23.S, P3/M, Z23.S, Z13.S  // 01100101-10000100-10001101-10110111
// CHECK: fmaxnm  z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-10001101-10110111
fmaxnm  z0.h, p0/m, z0.h, z0.h  // 01100101-01000100-10000000-00000000
// CHECK: fmaxnm  z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-10000000-00000000
FMAXNM  Z0.H, P0/M, Z0.H, Z0.H  // 01100101-01000100-10000000-00000000
// CHECK: fmaxnm  z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-10000000-00000000
fmaxnm  z0.s, p0/m, z0.s, z0.s  // 01100101-10000100-10000000-00000000
// CHECK: fmaxnm  z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-10000000-00000000
FMAXNM  Z0.S, P0/M, Z0.S, Z0.S  // 01100101-10000100-10000000-00000000
// CHECK: fmaxnm  z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-10000000-00000000
fmaxnm  z21.d, p5/m, z21.d, #0.0  // 01100101-11011100-10010100-00010101
// CHECK: fmaxnm  z21.d, p5/m, z21.d, #0.0{{0*}} // encoding: [0x15,0x94,0xdc,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011100-10010100-00010101
FMAXNM  Z21.D, P5/M, Z21.D, #0.0  // 01100101-11011100-10010100-00010101
// CHECK: fmaxnm  z21.d, p5/m, z21.d, #0.0{{0*}} // encoding: [0x15,0x94,0xdc,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011100-10010100-00010101
fmaxnm  z21.d, p5/m, z21.d, z10.d  // 01100101-11000100-10010101-01010101
// CHECK: fmaxnm  z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-10010101-01010101
FMAXNM  Z21.D, P5/M, Z21.D, Z10.D  // 01100101-11000100-10010101-01010101
// CHECK: fmaxnm  z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-10010101-01010101
fmaxnm  z21.h, p5/m, z21.h, #0.0  // 01100101-01011100-10010100-00010101
// CHECK: fmaxnm  z21.h, p5/m, z21.h, #0.0{{0*}} // encoding: [0x15,0x94,0x5c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011100-10010100-00010101
FMAXNM  Z21.H, P5/M, Z21.H, #0.0  // 01100101-01011100-10010100-00010101
// CHECK: fmaxnm  z21.h, p5/m, z21.h, #0.0{{0*}} // encoding: [0x15,0x94,0x5c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011100-10010100-00010101
fmaxnm  z21.s, p5/m, z21.s, #0.0  // 01100101-10011100-10010100-00010101
// CHECK: fmaxnm  z21.s, p5/m, z21.s, #0.0{{0*}} // encoding: [0x15,0x94,0x9c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011100-10010100-00010101
FMAXNM  Z21.S, P5/M, Z21.S, #0.0  // 01100101-10011100-10010100-00010101
// CHECK: fmaxnm  z21.s, p5/m, z21.s, #0.0{{0*}} // encoding: [0x15,0x94,0x9c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011100-10010100-00010101
fmaxnm  z31.d, p7/m, z31.d, #1.0  // 01100101-11011100-10011100-00111111
// CHECK: fmaxnm  z31.d, p7/m, z31.d, #1.0{{0*}} // encoding: [0x3f,0x9c,0xdc,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011100-10011100-00111111
FMAXNM  Z31.D, P7/M, Z31.D, #1.0  // 01100101-11011100-10011100-00111111
// CHECK: fmaxnm  z31.d, p7/m, z31.d, #1.0{{0*}} // encoding: [0x3f,0x9c,0xdc,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011100-10011100-00111111
fmaxnm  z21.h, p5/m, z21.h, z10.h  // 01100101-01000100-10010101-01010101
// CHECK: fmaxnm  z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-10010101-01010101
FMAXNM  Z21.H, P5/M, Z21.H, Z10.H  // 01100101-01000100-10010101-01010101
// CHECK: fmaxnm  z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-10010101-01010101
fmaxnm  z31.s, p7/m, z31.s, #1.0  // 01100101-10011100-10011100-00111111
// CHECK: fmaxnm  z31.s, p7/m, z31.s, #1.0{{0*}} // encoding: [0x3f,0x9c,0x9c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011100-10011100-00111111
FMAXNM  Z31.S, P7/M, Z31.S, #1.0  // 01100101-10011100-10011100-00111111
// CHECK: fmaxnm  z31.s, p7/m, z31.s, #1.0{{0*}} // encoding: [0x3f,0x9c,0x9c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011100-10011100-00111111
fmaxnm  z31.h, p7/m, z31.h, z31.h  // 01100101-01000100-10011111-11111111
// CHECK: fmaxnm  z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-10011111-11111111
FMAXNM  Z31.H, P7/M, Z31.H, Z31.H  // 01100101-01000100-10011111-11111111
// CHECK: fmaxnm  z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-10011111-11111111
fmaxnm  z21.s, p5/m, z21.s, z10.s  // 01100101-10000100-10010101-01010101
// CHECK: fmaxnm  z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-10010101-01010101
FMAXNM  Z21.S, P5/M, Z21.S, Z10.S  // 01100101-10000100-10010101-01010101
// CHECK: fmaxnm  z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-10010101-01010101
fmaxnm  z0.s, p0/m, z0.s, #0.0  // 01100101-10011100-10000000-00000000
// CHECK: fmaxnm  z0.s, p0/m, z0.s, #0.0{{0*}} // encoding: [0x00,0x80,0x9c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011100-10000000-00000000
FMAXNM  Z0.S, P0/M, Z0.S, #0.0  // 01100101-10011100-10000000-00000000
// CHECK: fmaxnm  z0.s, p0/m, z0.s, #0.0{{0*}} // encoding: [0x00,0x80,0x9c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011100-10000000-00000000
fmaxnm  z23.d, p3/m, z23.d, z13.d  // 01100101-11000100-10001101-10110111
// CHECK: fmaxnm  z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-10001101-10110111
FMAXNM  Z23.D, P3/M, Z23.D, Z13.D  // 01100101-11000100-10001101-10110111
// CHECK: fmaxnm  z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-10001101-10110111
fmaxnm  z0.d, p0/m, z0.d, z0.d  // 01100101-11000100-10000000-00000000
// CHECK: fmaxnm  z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-10000000-00000000
FMAXNM  Z0.D, P0/M, Z0.D, Z0.D  // 01100101-11000100-10000000-00000000
// CHECK: fmaxnm  z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-10000000-00000000
fmaxnm  z0.h, p0/m, z0.h, #0.0  // 01100101-01011100-10000000-00000000
// CHECK: fmaxnm  z0.h, p0/m, z0.h, #0.0{{0*}} // encoding: [0x00,0x80,0x5c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011100-10000000-00000000
FMAXNM  Z0.H, P0/M, Z0.H, #0.0  // 01100101-01011100-10000000-00000000
// CHECK: fmaxnm  z0.h, p0/m, z0.h, #0.0{{0*}} // encoding: [0x00,0x80,0x5c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011100-10000000-00000000
fmaxnm  z23.h, p3/m, z23.h, z13.h  // 01100101-01000100-10001101-10110111
// CHECK: fmaxnm  z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-10001101-10110111
FMAXNM  Z23.H, P3/M, Z23.H, Z13.H  // 01100101-01000100-10001101-10110111
// CHECK: fmaxnm  z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-10001101-10110111
fmaxnm  z23.h, p3/m, z23.h, #1.0  // 01100101-01011100-10001100-00110111
// CHECK: fmaxnm  z23.h, p3/m, z23.h, #1.0{{0*}} // encoding: [0x37,0x8c,0x5c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011100-10001100-00110111
FMAXNM  Z23.H, P3/M, Z23.H, #1.0  // 01100101-01011100-10001100-00110111
// CHECK: fmaxnm  z23.h, p3/m, z23.h, #1.0{{0*}} // encoding: [0x37,0x8c,0x5c,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011100-10001100-00110111
fmaxnm  z23.d, p3/m, z23.d, #1.0  // 01100101-11011100-10001100-00110111
// CHECK: fmaxnm  z23.d, p3/m, z23.d, #1.0{{0*}} // encoding: [0x37,0x8c,0xdc,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011100-10001100-00110111
FMAXNM  Z23.D, P3/M, Z23.D, #1.0  // 01100101-11011100-10001100-00110111
// CHECK: fmaxnm  z23.d, p3/m, z23.d, #1.0{{0*}} // encoding: [0x37,0x8c,0xdc,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011100-10001100-00110111
fmaxnm  z0.d, p0/m, z0.d, #0.0  // 01100101-11011100-10000000-00000000
// CHECK: fmaxnm  z0.d, p0/m, z0.d, #0.0{{0*}} // encoding: [0x00,0x80,0xdc,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011100-10000000-00000000
FMAXNM  Z0.D, P0/M, Z0.D, #0.0  // 01100101-11011100-10000000-00000000
// CHECK: fmaxnm  z0.d, p0/m, z0.d, #0.0{{0*}} // encoding: [0x00,0x80,0xdc,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011100-10000000-00000000
