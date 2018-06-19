// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sminv   b23, p3, z13.b  // 00000100-00001010-00101101-10110111
// CHECK: sminv   b23, p3, z13.b // encoding: [0xb7,0x2d,0x0a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001010-00101101-10110111
SMINV   B23, P3, Z13.B  // 00000100-00001010-00101101-10110111
// CHECK: sminv   b23, p3, z13.b // encoding: [0xb7,0x2d,0x0a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001010-00101101-10110111
sminv   b0, p0, z0.b  // 00000100-00001010-00100000-00000000
// CHECK: sminv   b0, p0, z0.b // encoding: [0x00,0x20,0x0a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001010-00100000-00000000
SMINV   B0, P0, Z0.B  // 00000100-00001010-00100000-00000000
// CHECK: sminv   b0, p0, z0.b // encoding: [0x00,0x20,0x0a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001010-00100000-00000000
sminv   h23, p3, z13.h  // 00000100-01001010-00101101-10110111
// CHECK: sminv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x4a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001010-00101101-10110111
SMINV   H23, P3, Z13.H  // 00000100-01001010-00101101-10110111
// CHECK: sminv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x4a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001010-00101101-10110111
sminv   h21, p5, z10.h  // 00000100-01001010-00110101-01010101
// CHECK: sminv   h21, p5, z10.h // encoding: [0x55,0x35,0x4a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001010-00110101-01010101
SMINV   H21, P5, Z10.H  // 00000100-01001010-00110101-01010101
// CHECK: sminv   h21, p5, z10.h // encoding: [0x55,0x35,0x4a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001010-00110101-01010101
sminv   s23, p3, z13.s  // 00000100-10001010-00101101-10110111
// CHECK: sminv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x8a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001010-00101101-10110111
SMINV   S23, P3, Z13.S  // 00000100-10001010-00101101-10110111
// CHECK: sminv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x8a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001010-00101101-10110111
sminv   s31, p7, z31.s  // 00000100-10001010-00111111-11111111
// CHECK: sminv   s31, p7, z31.s // encoding: [0xff,0x3f,0x8a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001010-00111111-11111111
SMINV   S31, P7, Z31.S  // 00000100-10001010-00111111-11111111
// CHECK: sminv   s31, p7, z31.s // encoding: [0xff,0x3f,0x8a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001010-00111111-11111111
sminv   b31, p7, z31.b  // 00000100-00001010-00111111-11111111
// CHECK: sminv   b31, p7, z31.b // encoding: [0xff,0x3f,0x0a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001010-00111111-11111111
SMINV   B31, P7, Z31.B  // 00000100-00001010-00111111-11111111
// CHECK: sminv   b31, p7, z31.b // encoding: [0xff,0x3f,0x0a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001010-00111111-11111111
sminv   s21, p5, z10.s  // 00000100-10001010-00110101-01010101
// CHECK: sminv   s21, p5, z10.s // encoding: [0x55,0x35,0x8a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001010-00110101-01010101
SMINV   S21, P5, Z10.S  // 00000100-10001010-00110101-01010101
// CHECK: sminv   s21, p5, z10.s // encoding: [0x55,0x35,0x8a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001010-00110101-01010101
sminv   h0, p0, z0.h  // 00000100-01001010-00100000-00000000
// CHECK: sminv   h0, p0, z0.h // encoding: [0x00,0x20,0x4a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001010-00100000-00000000
SMINV   H0, P0, Z0.H  // 00000100-01001010-00100000-00000000
// CHECK: sminv   h0, p0, z0.h // encoding: [0x00,0x20,0x4a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001010-00100000-00000000
sminv   d23, p3, z13.d  // 00000100-11001010-00101101-10110111
// CHECK: sminv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xca,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001010-00101101-10110111
SMINV   D23, P3, Z13.D  // 00000100-11001010-00101101-10110111
// CHECK: sminv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xca,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001010-00101101-10110111
sminv   b21, p5, z10.b  // 00000100-00001010-00110101-01010101
// CHECK: sminv   b21, p5, z10.b // encoding: [0x55,0x35,0x0a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001010-00110101-01010101
SMINV   B21, P5, Z10.B  // 00000100-00001010-00110101-01010101
// CHECK: sminv   b21, p5, z10.b // encoding: [0x55,0x35,0x0a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001010-00110101-01010101
sminv   d31, p7, z31.d  // 00000100-11001010-00111111-11111111
// CHECK: sminv   d31, p7, z31.d // encoding: [0xff,0x3f,0xca,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001010-00111111-11111111
SMINV   D31, P7, Z31.D  // 00000100-11001010-00111111-11111111
// CHECK: sminv   d31, p7, z31.d // encoding: [0xff,0x3f,0xca,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001010-00111111-11111111
sminv   d0, p0, z0.d  // 00000100-11001010-00100000-00000000
// CHECK: sminv   d0, p0, z0.d // encoding: [0x00,0x20,0xca,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001010-00100000-00000000
SMINV   D0, P0, Z0.D  // 00000100-11001010-00100000-00000000
// CHECK: sminv   d0, p0, z0.d // encoding: [0x00,0x20,0xca,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001010-00100000-00000000
sminv   s0, p0, z0.s  // 00000100-10001010-00100000-00000000
// CHECK: sminv   s0, p0, z0.s // encoding: [0x00,0x20,0x8a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001010-00100000-00000000
SMINV   S0, P0, Z0.S  // 00000100-10001010-00100000-00000000
// CHECK: sminv   s0, p0, z0.s // encoding: [0x00,0x20,0x8a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001010-00100000-00000000
sminv   d21, p5, z10.d  // 00000100-11001010-00110101-01010101
// CHECK: sminv   d21, p5, z10.d // encoding: [0x55,0x35,0xca,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001010-00110101-01010101
SMINV   D21, P5, Z10.D  // 00000100-11001010-00110101-01010101
// CHECK: sminv   d21, p5, z10.d // encoding: [0x55,0x35,0xca,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001010-00110101-01010101
sminv   h31, p7, z31.h  // 00000100-01001010-00111111-11111111
// CHECK: sminv   h31, p7, z31.h // encoding: [0xff,0x3f,0x4a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001010-00111111-11111111
SMINV   H31, P7, Z31.H  // 00000100-01001010-00111111-11111111
// CHECK: sminv   h31, p7, z31.h // encoding: [0xff,0x3f,0x4a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001010-00111111-11111111
