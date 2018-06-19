// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
faddv   d31, p7, z31.d  // 01100101-11000000-00111111-11111111
// CHECK: faddv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00111111-11111111
FADDV   D31, P7, Z31.D  // 01100101-11000000-00111111-11111111
// CHECK: faddv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00111111-11111111
faddv   d0, p0, z0.d  // 01100101-11000000-00100000-00000000
// CHECK: faddv   d0, p0, z0.d // encoding: [0x00,0x20,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00100000-00000000
FADDV   D0, P0, Z0.D  // 01100101-11000000-00100000-00000000
// CHECK: faddv   d0, p0, z0.d // encoding: [0x00,0x20,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00100000-00000000
faddv   h0, p0, z0.h  // 01100101-01000000-00100000-00000000
// CHECK: faddv   h0, p0, z0.h // encoding: [0x00,0x20,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00100000-00000000
FADDV   H0, P0, Z0.H  // 01100101-01000000-00100000-00000000
// CHECK: faddv   h0, p0, z0.h // encoding: [0x00,0x20,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00100000-00000000
faddv   h31, p7, z31.h  // 01100101-01000000-00111111-11111111
// CHECK: faddv   h31, p7, z31.h // encoding: [0xff,0x3f,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00111111-11111111
FADDV   H31, P7, Z31.H  // 01100101-01000000-00111111-11111111
// CHECK: faddv   h31, p7, z31.h // encoding: [0xff,0x3f,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00111111-11111111
faddv   s21, p5, z10.s  // 01100101-10000000-00110101-01010101
// CHECK: faddv   s21, p5, z10.s // encoding: [0x55,0x35,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00110101-01010101
FADDV   S21, P5, Z10.S  // 01100101-10000000-00110101-01010101
// CHECK: faddv   s21, p5, z10.s // encoding: [0x55,0x35,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00110101-01010101
faddv   h21, p5, z10.h  // 01100101-01000000-00110101-01010101
// CHECK: faddv   h21, p5, z10.h // encoding: [0x55,0x35,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00110101-01010101
FADDV   H21, P5, Z10.H  // 01100101-01000000-00110101-01010101
// CHECK: faddv   h21, p5, z10.h // encoding: [0x55,0x35,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00110101-01010101
faddv   d23, p3, z13.d  // 01100101-11000000-00101101-10110111
// CHECK: faddv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00101101-10110111
FADDV   D23, P3, Z13.D  // 01100101-11000000-00101101-10110111
// CHECK: faddv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00101101-10110111
faddv   d21, p5, z10.d  // 01100101-11000000-00110101-01010101
// CHECK: faddv   d21, p5, z10.d // encoding: [0x55,0x35,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00110101-01010101
FADDV   D21, P5, Z10.D  // 01100101-11000000-00110101-01010101
// CHECK: faddv   d21, p5, z10.d // encoding: [0x55,0x35,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00110101-01010101
faddv   s0, p0, z0.s  // 01100101-10000000-00100000-00000000
// CHECK: faddv   s0, p0, z0.s // encoding: [0x00,0x20,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00100000-00000000
FADDV   S0, P0, Z0.S  // 01100101-10000000-00100000-00000000
// CHECK: faddv   s0, p0, z0.s // encoding: [0x00,0x20,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00100000-00000000
faddv   h23, p3, z13.h  // 01100101-01000000-00101101-10110111
// CHECK: faddv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00101101-10110111
FADDV   H23, P3, Z13.H  // 01100101-01000000-00101101-10110111
// CHECK: faddv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00101101-10110111
faddv   s31, p7, z31.s  // 01100101-10000000-00111111-11111111
// CHECK: faddv   s31, p7, z31.s // encoding: [0xff,0x3f,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00111111-11111111
FADDV   S31, P7, Z31.S  // 01100101-10000000-00111111-11111111
// CHECK: faddv   s31, p7, z31.s // encoding: [0xff,0x3f,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00111111-11111111
faddv   s23, p3, z13.s  // 01100101-10000000-00101101-10110111
// CHECK: faddv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00101101-10110111
FADDV   S23, P3, Z13.S  // 01100101-10000000-00101101-10110111
// CHECK: faddv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00101101-10110111
