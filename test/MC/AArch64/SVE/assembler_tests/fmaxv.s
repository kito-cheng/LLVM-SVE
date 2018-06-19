// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmaxv   s0, p0, z0.s  // 01100101-10000110-00100000-00000000
// CHECK: fmaxv   s0, p0, z0.s // encoding: [0x00,0x20,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-00100000-00000000
FMAXV   S0, P0, Z0.S  // 01100101-10000110-00100000-00000000
// CHECK: fmaxv   s0, p0, z0.s // encoding: [0x00,0x20,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-00100000-00000000
fmaxv   s31, p7, z31.s  // 01100101-10000110-00111111-11111111
// CHECK: fmaxv   s31, p7, z31.s // encoding: [0xff,0x3f,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-00111111-11111111
FMAXV   S31, P7, Z31.S  // 01100101-10000110-00111111-11111111
// CHECK: fmaxv   s31, p7, z31.s // encoding: [0xff,0x3f,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-00111111-11111111
fmaxv   s21, p5, z10.s  // 01100101-10000110-00110101-01010101
// CHECK: fmaxv   s21, p5, z10.s // encoding: [0x55,0x35,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-00110101-01010101
FMAXV   S21, P5, Z10.S  // 01100101-10000110-00110101-01010101
// CHECK: fmaxv   s21, p5, z10.s // encoding: [0x55,0x35,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-00110101-01010101
fmaxv   d23, p3, z13.d  // 01100101-11000110-00101101-10110111
// CHECK: fmaxv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-00101101-10110111
FMAXV   D23, P3, Z13.D  // 01100101-11000110-00101101-10110111
// CHECK: fmaxv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-00101101-10110111
fmaxv   h31, p7, z31.h  // 01100101-01000110-00111111-11111111
// CHECK: fmaxv   h31, p7, z31.h // encoding: [0xff,0x3f,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-00111111-11111111
FMAXV   H31, P7, Z31.H  // 01100101-01000110-00111111-11111111
// CHECK: fmaxv   h31, p7, z31.h // encoding: [0xff,0x3f,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-00111111-11111111
fmaxv   d0, p0, z0.d  // 01100101-11000110-00100000-00000000
// CHECK: fmaxv   d0, p0, z0.d // encoding: [0x00,0x20,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-00100000-00000000
FMAXV   D0, P0, Z0.D  // 01100101-11000110-00100000-00000000
// CHECK: fmaxv   d0, p0, z0.d // encoding: [0x00,0x20,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-00100000-00000000
fmaxv   s23, p3, z13.s  // 01100101-10000110-00101101-10110111
// CHECK: fmaxv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-00101101-10110111
FMAXV   S23, P3, Z13.S  // 01100101-10000110-00101101-10110111
// CHECK: fmaxv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-00101101-10110111
fmaxv   h0, p0, z0.h  // 01100101-01000110-00100000-00000000
// CHECK: fmaxv   h0, p0, z0.h // encoding: [0x00,0x20,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-00100000-00000000
FMAXV   H0, P0, Z0.H  // 01100101-01000110-00100000-00000000
// CHECK: fmaxv   h0, p0, z0.h // encoding: [0x00,0x20,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-00100000-00000000
fmaxv   h23, p3, z13.h  // 01100101-01000110-00101101-10110111
// CHECK: fmaxv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-00101101-10110111
FMAXV   H23, P3, Z13.H  // 01100101-01000110-00101101-10110111
// CHECK: fmaxv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-00101101-10110111
fmaxv   d31, p7, z31.d  // 01100101-11000110-00111111-11111111
// CHECK: fmaxv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-00111111-11111111
FMAXV   D31, P7, Z31.D  // 01100101-11000110-00111111-11111111
// CHECK: fmaxv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-00111111-11111111
fmaxv   d21, p5, z10.d  // 01100101-11000110-00110101-01010101
// CHECK: fmaxv   d21, p5, z10.d // encoding: [0x55,0x35,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-00110101-01010101
FMAXV   D21, P5, Z10.D  // 01100101-11000110-00110101-01010101
// CHECK: fmaxv   d21, p5, z10.d // encoding: [0x55,0x35,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-00110101-01010101
fmaxv   h21, p5, z10.h  // 01100101-01000110-00110101-01010101
// CHECK: fmaxv   h21, p5, z10.h // encoding: [0x55,0x35,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-00110101-01010101
FMAXV   H21, P5, Z10.H  // 01100101-01000110-00110101-01010101
// CHECK: fmaxv   h21, p5, z10.h // encoding: [0x55,0x35,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-00110101-01010101
