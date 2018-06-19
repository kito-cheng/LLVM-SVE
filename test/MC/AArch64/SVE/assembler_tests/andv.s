// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
andv    s23, p3, z13.s  // 00000100-10011010-00101101-10110111
// CHECK: andv    s23, p3, z13.s // encoding: [0xb7,0x2d,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00101101-10110111
ANDV    S23, P3, Z13.S  // 00000100-10011010-00101101-10110111
// CHECK: andv    s23, p3, z13.s // encoding: [0xb7,0x2d,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00101101-10110111
andv    d0, p0, z0.d  // 00000100-11011010-00100000-00000000
// CHECK: andv    d0, p0, z0.d // encoding: [0x00,0x20,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00100000-00000000
ANDV    D0, P0, Z0.D  // 00000100-11011010-00100000-00000000
// CHECK: andv    d0, p0, z0.d // encoding: [0x00,0x20,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00100000-00000000
andv    d21, p5, z10.d  // 00000100-11011010-00110101-01010101
// CHECK: andv    d21, p5, z10.d // encoding: [0x55,0x35,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00110101-01010101
ANDV    D21, P5, Z10.D  // 00000100-11011010-00110101-01010101
// CHECK: andv    d21, p5, z10.d // encoding: [0x55,0x35,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00110101-01010101
andv    h31, p7, z31.h  // 00000100-01011010-00111111-11111111
// CHECK: andv    h31, p7, z31.h // encoding: [0xff,0x3f,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00111111-11111111
ANDV    H31, P7, Z31.H  // 00000100-01011010-00111111-11111111
// CHECK: andv    h31, p7, z31.h // encoding: [0xff,0x3f,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00111111-11111111
andv    b0, p0, z0.b  // 00000100-00011010-00100000-00000000
// CHECK: andv    b0, p0, z0.b // encoding: [0x00,0x20,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00100000-00000000
ANDV    B0, P0, Z0.B  // 00000100-00011010-00100000-00000000
// CHECK: andv    b0, p0, z0.b // encoding: [0x00,0x20,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00100000-00000000
andv    h23, p3, z13.h  // 00000100-01011010-00101101-10110111
// CHECK: andv    h23, p3, z13.h // encoding: [0xb7,0x2d,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00101101-10110111
ANDV    H23, P3, Z13.H  // 00000100-01011010-00101101-10110111
// CHECK: andv    h23, p3, z13.h // encoding: [0xb7,0x2d,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00101101-10110111
andv    b21, p5, z10.b  // 00000100-00011010-00110101-01010101
// CHECK: andv    b21, p5, z10.b // encoding: [0x55,0x35,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00110101-01010101
ANDV    B21, P5, Z10.B  // 00000100-00011010-00110101-01010101
// CHECK: andv    b21, p5, z10.b // encoding: [0x55,0x35,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00110101-01010101
andv    b31, p7, z31.b  // 00000100-00011010-00111111-11111111
// CHECK: andv    b31, p7, z31.b // encoding: [0xff,0x3f,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00111111-11111111
ANDV    B31, P7, Z31.B  // 00000100-00011010-00111111-11111111
// CHECK: andv    b31, p7, z31.b // encoding: [0xff,0x3f,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00111111-11111111
andv    d31, p7, z31.d  // 00000100-11011010-00111111-11111111
// CHECK: andv    d31, p7, z31.d // encoding: [0xff,0x3f,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00111111-11111111
ANDV    D31, P7, Z31.D  // 00000100-11011010-00111111-11111111
// CHECK: andv    d31, p7, z31.d // encoding: [0xff,0x3f,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00111111-11111111
andv    s21, p5, z10.s  // 00000100-10011010-00110101-01010101
// CHECK: andv    s21, p5, z10.s // encoding: [0x55,0x35,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00110101-01010101
ANDV    S21, P5, Z10.S  // 00000100-10011010-00110101-01010101
// CHECK: andv    s21, p5, z10.s // encoding: [0x55,0x35,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00110101-01010101
andv    s31, p7, z31.s  // 00000100-10011010-00111111-11111111
// CHECK: andv    s31, p7, z31.s // encoding: [0xff,0x3f,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00111111-11111111
ANDV    S31, P7, Z31.S  // 00000100-10011010-00111111-11111111
// CHECK: andv    s31, p7, z31.s // encoding: [0xff,0x3f,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00111111-11111111
andv    b23, p3, z13.b  // 00000100-00011010-00101101-10110111
// CHECK: andv    b23, p3, z13.b // encoding: [0xb7,0x2d,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00101101-10110111
ANDV    B23, P3, Z13.B  // 00000100-00011010-00101101-10110111
// CHECK: andv    b23, p3, z13.b // encoding: [0xb7,0x2d,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00101101-10110111
andv    s0, p0, z0.s  // 00000100-10011010-00100000-00000000
// CHECK: andv    s0, p0, z0.s // encoding: [0x00,0x20,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00100000-00000000
ANDV    S0, P0, Z0.S  // 00000100-10011010-00100000-00000000
// CHECK: andv    s0, p0, z0.s // encoding: [0x00,0x20,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00100000-00000000
andv    h0, p0, z0.h  // 00000100-01011010-00100000-00000000
// CHECK: andv    h0, p0, z0.h // encoding: [0x00,0x20,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00100000-00000000
ANDV    H0, P0, Z0.H  // 00000100-01011010-00100000-00000000
// CHECK: andv    h0, p0, z0.h // encoding: [0x00,0x20,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00100000-00000000
andv    h21, p5, z10.h  // 00000100-01011010-00110101-01010101
// CHECK: andv    h21, p5, z10.h // encoding: [0x55,0x35,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00110101-01010101
ANDV    H21, P5, Z10.H  // 00000100-01011010-00110101-01010101
// CHECK: andv    h21, p5, z10.h // encoding: [0x55,0x35,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00110101-01010101
andv    d23, p3, z13.d  // 00000100-11011010-00101101-10110111
// CHECK: andv    d23, p3, z13.d // encoding: [0xb7,0x2d,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00101101-10110111
ANDV    D23, P3, Z13.D  // 00000100-11011010-00101101-10110111
// CHECK: andv    d23, p3, z13.d // encoding: [0xb7,0x2d,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00101101-10110111
