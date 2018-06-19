// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
smaxv   d31, p7, z31.d  // 00000100-11001000-00111111-11111111
// CHECK: smaxv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-00111111-11111111
SMAXV   D31, P7, Z31.D  // 00000100-11001000-00111111-11111111
// CHECK: smaxv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-00111111-11111111
smaxv   b0, p0, z0.b  // 00000100-00001000-00100000-00000000
// CHECK: smaxv   b0, p0, z0.b // encoding: [0x00,0x20,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-00100000-00000000
SMAXV   B0, P0, Z0.B  // 00000100-00001000-00100000-00000000
// CHECK: smaxv   b0, p0, z0.b // encoding: [0x00,0x20,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-00100000-00000000
smaxv   d21, p5, z10.d  // 00000100-11001000-00110101-01010101
// CHECK: smaxv   d21, p5, z10.d // encoding: [0x55,0x35,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-00110101-01010101
SMAXV   D21, P5, Z10.D  // 00000100-11001000-00110101-01010101
// CHECK: smaxv   d21, p5, z10.d // encoding: [0x55,0x35,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-00110101-01010101
smaxv   h21, p5, z10.h  // 00000100-01001000-00110101-01010101
// CHECK: smaxv   h21, p5, z10.h // encoding: [0x55,0x35,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-00110101-01010101
SMAXV   H21, P5, Z10.H  // 00000100-01001000-00110101-01010101
// CHECK: smaxv   h21, p5, z10.h // encoding: [0x55,0x35,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-00110101-01010101
smaxv   s23, p3, z13.s  // 00000100-10001000-00101101-10110111
// CHECK: smaxv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-00101101-10110111
SMAXV   S23, P3, Z13.S  // 00000100-10001000-00101101-10110111
// CHECK: smaxv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-00101101-10110111
smaxv   b21, p5, z10.b  // 00000100-00001000-00110101-01010101
// CHECK: smaxv   b21, p5, z10.b // encoding: [0x55,0x35,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-00110101-01010101
SMAXV   B21, P5, Z10.B  // 00000100-00001000-00110101-01010101
// CHECK: smaxv   b21, p5, z10.b // encoding: [0x55,0x35,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-00110101-01010101
smaxv   s31, p7, z31.s  // 00000100-10001000-00111111-11111111
// CHECK: smaxv   s31, p7, z31.s // encoding: [0xff,0x3f,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-00111111-11111111
SMAXV   S31, P7, Z31.S  // 00000100-10001000-00111111-11111111
// CHECK: smaxv   s31, p7, z31.s // encoding: [0xff,0x3f,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-00111111-11111111
smaxv   s21, p5, z10.s  // 00000100-10001000-00110101-01010101
// CHECK: smaxv   s21, p5, z10.s // encoding: [0x55,0x35,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-00110101-01010101
SMAXV   S21, P5, Z10.S  // 00000100-10001000-00110101-01010101
// CHECK: smaxv   s21, p5, z10.s // encoding: [0x55,0x35,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-00110101-01010101
smaxv   h0, p0, z0.h  // 00000100-01001000-00100000-00000000
// CHECK: smaxv   h0, p0, z0.h // encoding: [0x00,0x20,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-00100000-00000000
SMAXV   H0, P0, Z0.H  // 00000100-01001000-00100000-00000000
// CHECK: smaxv   h0, p0, z0.h // encoding: [0x00,0x20,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-00100000-00000000
smaxv   b23, p3, z13.b  // 00000100-00001000-00101101-10110111
// CHECK: smaxv   b23, p3, z13.b // encoding: [0xb7,0x2d,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-00101101-10110111
SMAXV   B23, P3, Z13.B  // 00000100-00001000-00101101-10110111
// CHECK: smaxv   b23, p3, z13.b // encoding: [0xb7,0x2d,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-00101101-10110111
smaxv   d0, p0, z0.d  // 00000100-11001000-00100000-00000000
// CHECK: smaxv   d0, p0, z0.d // encoding: [0x00,0x20,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-00100000-00000000
SMAXV   D0, P0, Z0.D  // 00000100-11001000-00100000-00000000
// CHECK: smaxv   d0, p0, z0.d // encoding: [0x00,0x20,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-00100000-00000000
smaxv   h23, p3, z13.h  // 00000100-01001000-00101101-10110111
// CHECK: smaxv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-00101101-10110111
SMAXV   H23, P3, Z13.H  // 00000100-01001000-00101101-10110111
// CHECK: smaxv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-00101101-10110111
smaxv   d23, p3, z13.d  // 00000100-11001000-00101101-10110111
// CHECK: smaxv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-00101101-10110111
SMAXV   D23, P3, Z13.D  // 00000100-11001000-00101101-10110111
// CHECK: smaxv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-00101101-10110111
smaxv   b31, p7, z31.b  // 00000100-00001000-00111111-11111111
// CHECK: smaxv   b31, p7, z31.b // encoding: [0xff,0x3f,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-00111111-11111111
SMAXV   B31, P7, Z31.B  // 00000100-00001000-00111111-11111111
// CHECK: smaxv   b31, p7, z31.b // encoding: [0xff,0x3f,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-00111111-11111111
smaxv   s0, p0, z0.s  // 00000100-10001000-00100000-00000000
// CHECK: smaxv   s0, p0, z0.s // encoding: [0x00,0x20,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-00100000-00000000
SMAXV   S0, P0, Z0.S  // 00000100-10001000-00100000-00000000
// CHECK: smaxv   s0, p0, z0.s // encoding: [0x00,0x20,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-00100000-00000000
smaxv   h31, p7, z31.h  // 00000100-01001000-00111111-11111111
// CHECK: smaxv   h31, p7, z31.h // encoding: [0xff,0x3f,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-00111111-11111111
SMAXV   H31, P7, Z31.H  // 00000100-01001000-00111111-11111111
// CHECK: smaxv   h31, p7, z31.h // encoding: [0xff,0x3f,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-00111111-11111111
