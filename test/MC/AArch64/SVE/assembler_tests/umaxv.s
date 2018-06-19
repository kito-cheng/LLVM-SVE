// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
umaxv   s0, p0, z0.s  // 00000100-10001001-00100000-00000000
// CHECK: umaxv   s0, p0, z0.s // encoding: [0x00,0x20,0x89,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001001-00100000-00000000
UMAXV   S0, P0, Z0.S  // 00000100-10001001-00100000-00000000
// CHECK: umaxv   s0, p0, z0.s // encoding: [0x00,0x20,0x89,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001001-00100000-00000000
umaxv   d21, p5, z10.d  // 00000100-11001001-00110101-01010101
// CHECK: umaxv   d21, p5, z10.d // encoding: [0x55,0x35,0xc9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001001-00110101-01010101
UMAXV   D21, P5, Z10.D  // 00000100-11001001-00110101-01010101
// CHECK: umaxv   d21, p5, z10.d // encoding: [0x55,0x35,0xc9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001001-00110101-01010101
umaxv   h31, p7, z31.h  // 00000100-01001001-00111111-11111111
// CHECK: umaxv   h31, p7, z31.h // encoding: [0xff,0x3f,0x49,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001001-00111111-11111111
UMAXV   H31, P7, Z31.H  // 00000100-01001001-00111111-11111111
// CHECK: umaxv   h31, p7, z31.h // encoding: [0xff,0x3f,0x49,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001001-00111111-11111111
umaxv   h23, p3, z13.h  // 00000100-01001001-00101101-10110111
// CHECK: umaxv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x49,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001001-00101101-10110111
UMAXV   H23, P3, Z13.H  // 00000100-01001001-00101101-10110111
// CHECK: umaxv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x49,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001001-00101101-10110111
umaxv   s23, p3, z13.s  // 00000100-10001001-00101101-10110111
// CHECK: umaxv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x89,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001001-00101101-10110111
UMAXV   S23, P3, Z13.S  // 00000100-10001001-00101101-10110111
// CHECK: umaxv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x89,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001001-00101101-10110111
umaxv   s31, p7, z31.s  // 00000100-10001001-00111111-11111111
// CHECK: umaxv   s31, p7, z31.s // encoding: [0xff,0x3f,0x89,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001001-00111111-11111111
UMAXV   S31, P7, Z31.S  // 00000100-10001001-00111111-11111111
// CHECK: umaxv   s31, p7, z31.s // encoding: [0xff,0x3f,0x89,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001001-00111111-11111111
umaxv   b31, p7, z31.b  // 00000100-00001001-00111111-11111111
// CHECK: umaxv   b31, p7, z31.b // encoding: [0xff,0x3f,0x09,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001001-00111111-11111111
UMAXV   B31, P7, Z31.B  // 00000100-00001001-00111111-11111111
// CHECK: umaxv   b31, p7, z31.b // encoding: [0xff,0x3f,0x09,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001001-00111111-11111111
umaxv   d31, p7, z31.d  // 00000100-11001001-00111111-11111111
// CHECK: umaxv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001001-00111111-11111111
UMAXV   D31, P7, Z31.D  // 00000100-11001001-00111111-11111111
// CHECK: umaxv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001001-00111111-11111111
umaxv   d0, p0, z0.d  // 00000100-11001001-00100000-00000000
// CHECK: umaxv   d0, p0, z0.d // encoding: [0x00,0x20,0xc9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001001-00100000-00000000
UMAXV   D0, P0, Z0.D  // 00000100-11001001-00100000-00000000
// CHECK: umaxv   d0, p0, z0.d // encoding: [0x00,0x20,0xc9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001001-00100000-00000000
umaxv   b23, p3, z13.b  // 00000100-00001001-00101101-10110111
// CHECK: umaxv   b23, p3, z13.b // encoding: [0xb7,0x2d,0x09,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001001-00101101-10110111
UMAXV   B23, P3, Z13.B  // 00000100-00001001-00101101-10110111
// CHECK: umaxv   b23, p3, z13.b // encoding: [0xb7,0x2d,0x09,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001001-00101101-10110111
umaxv   d23, p3, z13.d  // 00000100-11001001-00101101-10110111
// CHECK: umaxv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001001-00101101-10110111
UMAXV   D23, P3, Z13.D  // 00000100-11001001-00101101-10110111
// CHECK: umaxv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001001-00101101-10110111
umaxv   s21, p5, z10.s  // 00000100-10001001-00110101-01010101
// CHECK: umaxv   s21, p5, z10.s // encoding: [0x55,0x35,0x89,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001001-00110101-01010101
UMAXV   S21, P5, Z10.S  // 00000100-10001001-00110101-01010101
// CHECK: umaxv   s21, p5, z10.s // encoding: [0x55,0x35,0x89,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001001-00110101-01010101
umaxv   h21, p5, z10.h  // 00000100-01001001-00110101-01010101
// CHECK: umaxv   h21, p5, z10.h // encoding: [0x55,0x35,0x49,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001001-00110101-01010101
UMAXV   H21, P5, Z10.H  // 00000100-01001001-00110101-01010101
// CHECK: umaxv   h21, p5, z10.h // encoding: [0x55,0x35,0x49,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001001-00110101-01010101
umaxv   h0, p0, z0.h  // 00000100-01001001-00100000-00000000
// CHECK: umaxv   h0, p0, z0.h // encoding: [0x00,0x20,0x49,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001001-00100000-00000000
UMAXV   H0, P0, Z0.H  // 00000100-01001001-00100000-00000000
// CHECK: umaxv   h0, p0, z0.h // encoding: [0x00,0x20,0x49,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001001-00100000-00000000
umaxv   b21, p5, z10.b  // 00000100-00001001-00110101-01010101
// CHECK: umaxv   b21, p5, z10.b // encoding: [0x55,0x35,0x09,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001001-00110101-01010101
UMAXV   B21, P5, Z10.B  // 00000100-00001001-00110101-01010101
// CHECK: umaxv   b21, p5, z10.b // encoding: [0x55,0x35,0x09,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001001-00110101-01010101
umaxv   b0, p0, z0.b  // 00000100-00001001-00100000-00000000
// CHECK: umaxv   b0, p0, z0.b // encoding: [0x00,0x20,0x09,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001001-00100000-00000000
UMAXV   B0, P0, Z0.B  // 00000100-00001001-00100000-00000000
// CHECK: umaxv   b0, p0, z0.b // encoding: [0x00,0x20,0x09,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001001-00100000-00000000
