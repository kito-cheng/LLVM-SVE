// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fminv   d23, p3, z13.d  // 01100101-11000111-00101101-10110111
// CHECK: fminv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc7,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000111-00101101-10110111
FMINV   D23, P3, Z13.D  // 01100101-11000111-00101101-10110111
// CHECK: fminv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc7,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000111-00101101-10110111
fminv   s0, p0, z0.s  // 01100101-10000111-00100000-00000000
// CHECK: fminv   s0, p0, z0.s // encoding: [0x00,0x20,0x87,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000111-00100000-00000000
FMINV   S0, P0, Z0.S  // 01100101-10000111-00100000-00000000
// CHECK: fminv   s0, p0, z0.s // encoding: [0x00,0x20,0x87,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000111-00100000-00000000
fminv   s23, p3, z13.s  // 01100101-10000111-00101101-10110111
// CHECK: fminv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x87,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000111-00101101-10110111
FMINV   S23, P3, Z13.S  // 01100101-10000111-00101101-10110111
// CHECK: fminv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x87,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000111-00101101-10110111
fminv   s31, p7, z31.s  // 01100101-10000111-00111111-11111111
// CHECK: fminv   s31, p7, z31.s // encoding: [0xff,0x3f,0x87,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000111-00111111-11111111
FMINV   S31, P7, Z31.S  // 01100101-10000111-00111111-11111111
// CHECK: fminv   s31, p7, z31.s // encoding: [0xff,0x3f,0x87,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000111-00111111-11111111
fminv   h23, p3, z13.h  // 01100101-01000111-00101101-10110111
// CHECK: fminv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x47,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000111-00101101-10110111
FMINV   H23, P3, Z13.H  // 01100101-01000111-00101101-10110111
// CHECK: fminv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x47,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000111-00101101-10110111
fminv   d0, p0, z0.d  // 01100101-11000111-00100000-00000000
// CHECK: fminv   d0, p0, z0.d // encoding: [0x00,0x20,0xc7,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000111-00100000-00000000
FMINV   D0, P0, Z0.D  // 01100101-11000111-00100000-00000000
// CHECK: fminv   d0, p0, z0.d // encoding: [0x00,0x20,0xc7,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000111-00100000-00000000
fminv   h21, p5, z10.h  // 01100101-01000111-00110101-01010101
// CHECK: fminv   h21, p5, z10.h // encoding: [0x55,0x35,0x47,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000111-00110101-01010101
FMINV   H21, P5, Z10.H  // 01100101-01000111-00110101-01010101
// CHECK: fminv   h21, p5, z10.h // encoding: [0x55,0x35,0x47,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000111-00110101-01010101
fminv   d31, p7, z31.d  // 01100101-11000111-00111111-11111111
// CHECK: fminv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc7,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000111-00111111-11111111
FMINV   D31, P7, Z31.D  // 01100101-11000111-00111111-11111111
// CHECK: fminv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc7,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000111-00111111-11111111
fminv   d21, p5, z10.d  // 01100101-11000111-00110101-01010101
// CHECK: fminv   d21, p5, z10.d // encoding: [0x55,0x35,0xc7,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000111-00110101-01010101
FMINV   D21, P5, Z10.D  // 01100101-11000111-00110101-01010101
// CHECK: fminv   d21, p5, z10.d // encoding: [0x55,0x35,0xc7,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000111-00110101-01010101
fminv   s21, p5, z10.s  // 01100101-10000111-00110101-01010101
// CHECK: fminv   s21, p5, z10.s // encoding: [0x55,0x35,0x87,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000111-00110101-01010101
FMINV   S21, P5, Z10.S  // 01100101-10000111-00110101-01010101
// CHECK: fminv   s21, p5, z10.s // encoding: [0x55,0x35,0x87,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000111-00110101-01010101
fminv   h31, p7, z31.h  // 01100101-01000111-00111111-11111111
// CHECK: fminv   h31, p7, z31.h // encoding: [0xff,0x3f,0x47,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000111-00111111-11111111
FMINV   H31, P7, Z31.H  // 01100101-01000111-00111111-11111111
// CHECK: fminv   h31, p7, z31.h // encoding: [0xff,0x3f,0x47,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000111-00111111-11111111
fminv   h0, p0, z0.h  // 01100101-01000111-00100000-00000000
// CHECK: fminv   h0, p0, z0.h // encoding: [0x00,0x20,0x47,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000111-00100000-00000000
FMINV   H0, P0, Z0.H  // 01100101-01000111-00100000-00000000
// CHECK: fminv   h0, p0, z0.h // encoding: [0x00,0x20,0x47,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000111-00100000-00000000
