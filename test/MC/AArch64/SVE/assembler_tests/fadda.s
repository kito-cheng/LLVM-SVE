// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fadda   d23, p3, d23, z13.d  // 01100101-11011000-00101101-10110111
// CHECK: fadda   d23, p3, d23, z13.d // encoding: [0xb7,0x2d,0xd8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011000-00101101-10110111
FADDA   D23, P3, D23, Z13.D  // 01100101-11011000-00101101-10110111
// CHECK: fadda   d23, p3, d23, z13.d // encoding: [0xb7,0x2d,0xd8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011000-00101101-10110111
fadda   s23, p3, s23, z13.s  // 01100101-10011000-00101101-10110111
// CHECK: fadda   s23, p3, s23, z13.s // encoding: [0xb7,0x2d,0x98,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011000-00101101-10110111
FADDA   S23, P3, S23, Z13.S  // 01100101-10011000-00101101-10110111
// CHECK: fadda   s23, p3, s23, z13.s // encoding: [0xb7,0x2d,0x98,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011000-00101101-10110111
fadda   h23, p3, h23, z13.h  // 01100101-01011000-00101101-10110111
// CHECK: fadda   h23, p3, h23, z13.h // encoding: [0xb7,0x2d,0x58,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011000-00101101-10110111
FADDA   H23, P3, H23, Z13.H  // 01100101-01011000-00101101-10110111
// CHECK: fadda   h23, p3, h23, z13.h // encoding: [0xb7,0x2d,0x58,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011000-00101101-10110111
fadda   d0, p0, d0, z0.d  // 01100101-11011000-00100000-00000000
// CHECK: fadda   d0, p0, d0, z0.d // encoding: [0x00,0x20,0xd8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011000-00100000-00000000
FADDA   D0, P0, D0, Z0.D  // 01100101-11011000-00100000-00000000
// CHECK: fadda   d0, p0, d0, z0.d // encoding: [0x00,0x20,0xd8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011000-00100000-00000000
fadda   h0, p0, h0, z0.h  // 01100101-01011000-00100000-00000000
// CHECK: fadda   h0, p0, h0, z0.h // encoding: [0x00,0x20,0x58,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011000-00100000-00000000
FADDA   H0, P0, H0, Z0.H  // 01100101-01011000-00100000-00000000
// CHECK: fadda   h0, p0, h0, z0.h // encoding: [0x00,0x20,0x58,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011000-00100000-00000000
fadda   s31, p7, s31, z31.s  // 01100101-10011000-00111111-11111111
// CHECK: fadda   s31, p7, s31, z31.s // encoding: [0xff,0x3f,0x98,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011000-00111111-11111111
FADDA   S31, P7, S31, Z31.S  // 01100101-10011000-00111111-11111111
// CHECK: fadda   s31, p7, s31, z31.s // encoding: [0xff,0x3f,0x98,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011000-00111111-11111111
fadda   s21, p5, s21, z10.s  // 01100101-10011000-00110101-01010101
// CHECK: fadda   s21, p5, s21, z10.s // encoding: [0x55,0x35,0x98,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011000-00110101-01010101
FADDA   S21, P5, S21, Z10.S  // 01100101-10011000-00110101-01010101
// CHECK: fadda   s21, p5, s21, z10.s // encoding: [0x55,0x35,0x98,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011000-00110101-01010101
fadda   h31, p7, h31, z31.h  // 01100101-01011000-00111111-11111111
// CHECK: fadda   h31, p7, h31, z31.h // encoding: [0xff,0x3f,0x58,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011000-00111111-11111111
FADDA   H31, P7, H31, Z31.H  // 01100101-01011000-00111111-11111111
// CHECK: fadda   h31, p7, h31, z31.h // encoding: [0xff,0x3f,0x58,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011000-00111111-11111111
fadda   d21, p5, d21, z10.d  // 01100101-11011000-00110101-01010101
// CHECK: fadda   d21, p5, d21, z10.d // encoding: [0x55,0x35,0xd8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011000-00110101-01010101
FADDA   D21, P5, D21, Z10.D  // 01100101-11011000-00110101-01010101
// CHECK: fadda   d21, p5, d21, z10.d // encoding: [0x55,0x35,0xd8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011000-00110101-01010101
fadda   s0, p0, s0, z0.s  // 01100101-10011000-00100000-00000000
// CHECK: fadda   s0, p0, s0, z0.s // encoding: [0x00,0x20,0x98,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011000-00100000-00000000
FADDA   S0, P0, S0, Z0.S  // 01100101-10011000-00100000-00000000
// CHECK: fadda   s0, p0, s0, z0.s // encoding: [0x00,0x20,0x98,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011000-00100000-00000000
fadda   d31, p7, d31, z31.d  // 01100101-11011000-00111111-11111111
// CHECK: fadda   d31, p7, d31, z31.d // encoding: [0xff,0x3f,0xd8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011000-00111111-11111111
FADDA   D31, P7, D31, Z31.D  // 01100101-11011000-00111111-11111111
// CHECK: fadda   d31, p7, d31, z31.d // encoding: [0xff,0x3f,0xd8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011000-00111111-11111111
fadda   h21, p5, h21, z10.h  // 01100101-01011000-00110101-01010101
// CHECK: fadda   h21, p5, h21, z10.h // encoding: [0x55,0x35,0x58,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011000-00110101-01010101
FADDA   H21, P5, H21, Z10.H  // 01100101-01011000-00110101-01010101
// CHECK: fadda   h21, p5, h21, z10.h // encoding: [0x55,0x35,0x58,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011000-00110101-01010101
