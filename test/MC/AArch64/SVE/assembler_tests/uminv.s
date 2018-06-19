// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uminv   h23, p3, z13.h  // 00000100-01001011-00101101-10110111
// CHECK: uminv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x4b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001011-00101101-10110111
UMINV   H23, P3, Z13.H  // 00000100-01001011-00101101-10110111
// CHECK: uminv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x4b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001011-00101101-10110111
uminv   d0, p0, z0.d  // 00000100-11001011-00100000-00000000
// CHECK: uminv   d0, p0, z0.d // encoding: [0x00,0x20,0xcb,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001011-00100000-00000000
UMINV   D0, P0, Z0.D  // 00000100-11001011-00100000-00000000
// CHECK: uminv   d0, p0, z0.d // encoding: [0x00,0x20,0xcb,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001011-00100000-00000000
uminv   b23, p3, z13.b  // 00000100-00001011-00101101-10110111
// CHECK: uminv   b23, p3, z13.b // encoding: [0xb7,0x2d,0x0b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001011-00101101-10110111
UMINV   B23, P3, Z13.B  // 00000100-00001011-00101101-10110111
// CHECK: uminv   b23, p3, z13.b // encoding: [0xb7,0x2d,0x0b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001011-00101101-10110111
uminv   d23, p3, z13.d  // 00000100-11001011-00101101-10110111
// CHECK: uminv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xcb,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001011-00101101-10110111
UMINV   D23, P3, Z13.D  // 00000100-11001011-00101101-10110111
// CHECK: uminv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xcb,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001011-00101101-10110111
uminv   s0, p0, z0.s  // 00000100-10001011-00100000-00000000
// CHECK: uminv   s0, p0, z0.s // encoding: [0x00,0x20,0x8b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001011-00100000-00000000
UMINV   S0, P0, Z0.S  // 00000100-10001011-00100000-00000000
// CHECK: uminv   s0, p0, z0.s // encoding: [0x00,0x20,0x8b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001011-00100000-00000000
uminv   b0, p0, z0.b  // 00000100-00001011-00100000-00000000
// CHECK: uminv   b0, p0, z0.b // encoding: [0x00,0x20,0x0b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001011-00100000-00000000
UMINV   B0, P0, Z0.B  // 00000100-00001011-00100000-00000000
// CHECK: uminv   b0, p0, z0.b // encoding: [0x00,0x20,0x0b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001011-00100000-00000000
uminv   s31, p7, z31.s  // 00000100-10001011-00111111-11111111
// CHECK: uminv   s31, p7, z31.s // encoding: [0xff,0x3f,0x8b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001011-00111111-11111111
UMINV   S31, P7, Z31.S  // 00000100-10001011-00111111-11111111
// CHECK: uminv   s31, p7, z31.s // encoding: [0xff,0x3f,0x8b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001011-00111111-11111111
uminv   d21, p5, z10.d  // 00000100-11001011-00110101-01010101
// CHECK: uminv   d21, p5, z10.d // encoding: [0x55,0x35,0xcb,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001011-00110101-01010101
UMINV   D21, P5, Z10.D  // 00000100-11001011-00110101-01010101
// CHECK: uminv   d21, p5, z10.d // encoding: [0x55,0x35,0xcb,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001011-00110101-01010101
uminv   s21, p5, z10.s  // 00000100-10001011-00110101-01010101
// CHECK: uminv   s21, p5, z10.s // encoding: [0x55,0x35,0x8b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001011-00110101-01010101
UMINV   S21, P5, Z10.S  // 00000100-10001011-00110101-01010101
// CHECK: uminv   s21, p5, z10.s // encoding: [0x55,0x35,0x8b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001011-00110101-01010101
uminv   b21, p5, z10.b  // 00000100-00001011-00110101-01010101
// CHECK: uminv   b21, p5, z10.b // encoding: [0x55,0x35,0x0b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001011-00110101-01010101
UMINV   B21, P5, Z10.B  // 00000100-00001011-00110101-01010101
// CHECK: uminv   b21, p5, z10.b // encoding: [0x55,0x35,0x0b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001011-00110101-01010101
uminv   h0, p0, z0.h  // 00000100-01001011-00100000-00000000
// CHECK: uminv   h0, p0, z0.h // encoding: [0x00,0x20,0x4b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001011-00100000-00000000
UMINV   H0, P0, Z0.H  // 00000100-01001011-00100000-00000000
// CHECK: uminv   h0, p0, z0.h // encoding: [0x00,0x20,0x4b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001011-00100000-00000000
uminv   h21, p5, z10.h  // 00000100-01001011-00110101-01010101
// CHECK: uminv   h21, p5, z10.h // encoding: [0x55,0x35,0x4b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001011-00110101-01010101
UMINV   H21, P5, Z10.H  // 00000100-01001011-00110101-01010101
// CHECK: uminv   h21, p5, z10.h // encoding: [0x55,0x35,0x4b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001011-00110101-01010101
uminv   d31, p7, z31.d  // 00000100-11001011-00111111-11111111
// CHECK: uminv   d31, p7, z31.d // encoding: [0xff,0x3f,0xcb,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001011-00111111-11111111
UMINV   D31, P7, Z31.D  // 00000100-11001011-00111111-11111111
// CHECK: uminv   d31, p7, z31.d // encoding: [0xff,0x3f,0xcb,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001011-00111111-11111111
uminv   b31, p7, z31.b  // 00000100-00001011-00111111-11111111
// CHECK: uminv   b31, p7, z31.b // encoding: [0xff,0x3f,0x0b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001011-00111111-11111111
UMINV   B31, P7, Z31.B  // 00000100-00001011-00111111-11111111
// CHECK: uminv   b31, p7, z31.b // encoding: [0xff,0x3f,0x0b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001011-00111111-11111111
uminv   s23, p3, z13.s  // 00000100-10001011-00101101-10110111
// CHECK: uminv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x8b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001011-00101101-10110111
UMINV   S23, P3, Z13.S  // 00000100-10001011-00101101-10110111
// CHECK: uminv   s23, p3, z13.s // encoding: [0xb7,0x2d,0x8b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001011-00101101-10110111
uminv   h31, p7, z31.h  // 00000100-01001011-00111111-11111111
// CHECK: uminv   h31, p7, z31.h // encoding: [0xff,0x3f,0x4b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001011-00111111-11111111
UMINV   H31, P7, Z31.H  // 00000100-01001011-00111111-11111111
// CHECK: uminv   h31, p7, z31.h // encoding: [0xff,0x3f,0x4b,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001011-00111111-11111111
