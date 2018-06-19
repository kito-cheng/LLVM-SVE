// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmaxnmv d31, p7, z31.d  // 01100101-11000100-00111111-11111111
// CHECK: fmaxnmv d31, p7, z31.d // encoding: [0xff,0x3f,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-00111111-11111111
FMAXNMV D31, P7, Z31.D  // 01100101-11000100-00111111-11111111
// CHECK: fmaxnmv d31, p7, z31.d // encoding: [0xff,0x3f,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-00111111-11111111
fmaxnmv h23, p3, z13.h  // 01100101-01000100-00101101-10110111
// CHECK: fmaxnmv h23, p3, z13.h // encoding: [0xb7,0x2d,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-00101101-10110111
FMAXNMV H23, P3, Z13.H  // 01100101-01000100-00101101-10110111
// CHECK: fmaxnmv h23, p3, z13.h // encoding: [0xb7,0x2d,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-00101101-10110111
fmaxnmv s0, p0, z0.s  // 01100101-10000100-00100000-00000000
// CHECK: fmaxnmv s0, p0, z0.s // encoding: [0x00,0x20,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-00100000-00000000
FMAXNMV S0, P0, Z0.S  // 01100101-10000100-00100000-00000000
// CHECK: fmaxnmv s0, p0, z0.s // encoding: [0x00,0x20,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-00100000-00000000
fmaxnmv h0, p0, z0.h  // 01100101-01000100-00100000-00000000
// CHECK: fmaxnmv h0, p0, z0.h // encoding: [0x00,0x20,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-00100000-00000000
FMAXNMV H0, P0, Z0.H  // 01100101-01000100-00100000-00000000
// CHECK: fmaxnmv h0, p0, z0.h // encoding: [0x00,0x20,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-00100000-00000000
fmaxnmv s21, p5, z10.s  // 01100101-10000100-00110101-01010101
// CHECK: fmaxnmv s21, p5, z10.s // encoding: [0x55,0x35,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-00110101-01010101
FMAXNMV S21, P5, Z10.S  // 01100101-10000100-00110101-01010101
// CHECK: fmaxnmv s21, p5, z10.s // encoding: [0x55,0x35,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-00110101-01010101
fmaxnmv h21, p5, z10.h  // 01100101-01000100-00110101-01010101
// CHECK: fmaxnmv h21, p5, z10.h // encoding: [0x55,0x35,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-00110101-01010101
FMAXNMV H21, P5, Z10.H  // 01100101-01000100-00110101-01010101
// CHECK: fmaxnmv h21, p5, z10.h // encoding: [0x55,0x35,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-00110101-01010101
fmaxnmv d0, p0, z0.d  // 01100101-11000100-00100000-00000000
// CHECK: fmaxnmv d0, p0, z0.d // encoding: [0x00,0x20,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-00100000-00000000
FMAXNMV D0, P0, Z0.D  // 01100101-11000100-00100000-00000000
// CHECK: fmaxnmv d0, p0, z0.d // encoding: [0x00,0x20,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-00100000-00000000
fmaxnmv s31, p7, z31.s  // 01100101-10000100-00111111-11111111
// CHECK: fmaxnmv s31, p7, z31.s // encoding: [0xff,0x3f,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-00111111-11111111
FMAXNMV S31, P7, Z31.S  // 01100101-10000100-00111111-11111111
// CHECK: fmaxnmv s31, p7, z31.s // encoding: [0xff,0x3f,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-00111111-11111111
fmaxnmv h31, p7, z31.h  // 01100101-01000100-00111111-11111111
// CHECK: fmaxnmv h31, p7, z31.h // encoding: [0xff,0x3f,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-00111111-11111111
FMAXNMV H31, P7, Z31.H  // 01100101-01000100-00111111-11111111
// CHECK: fmaxnmv h31, p7, z31.h // encoding: [0xff,0x3f,0x44,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000100-00111111-11111111
fmaxnmv d23, p3, z13.d  // 01100101-11000100-00101101-10110111
// CHECK: fmaxnmv d23, p3, z13.d // encoding: [0xb7,0x2d,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-00101101-10110111
FMAXNMV D23, P3, Z13.D  // 01100101-11000100-00101101-10110111
// CHECK: fmaxnmv d23, p3, z13.d // encoding: [0xb7,0x2d,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-00101101-10110111
fmaxnmv d21, p5, z10.d  // 01100101-11000100-00110101-01010101
// CHECK: fmaxnmv d21, p5, z10.d // encoding: [0x55,0x35,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-00110101-01010101
FMAXNMV D21, P5, Z10.D  // 01100101-11000100-00110101-01010101
// CHECK: fmaxnmv d21, p5, z10.d // encoding: [0x55,0x35,0xc4,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000100-00110101-01010101
fmaxnmv s23, p3, z13.s  // 01100101-10000100-00101101-10110111
// CHECK: fmaxnmv s23, p3, z13.s // encoding: [0xb7,0x2d,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-00101101-10110111
FMAXNMV S23, P3, Z13.S  // 01100101-10000100-00101101-10110111
// CHECK: fmaxnmv s23, p3, z13.s // encoding: [0xb7,0x2d,0x84,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000100-00101101-10110111
