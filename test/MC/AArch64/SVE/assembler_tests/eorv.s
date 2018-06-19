// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
eorv    s31, p7, z31.s  // 00000100-10011001-00111111-11111111
// CHECK: eorv    s31, p7, z31.s // encoding: [0xff,0x3f,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-00111111-11111111
EORV    S31, P7, Z31.S  // 00000100-10011001-00111111-11111111
// CHECK: eorv    s31, p7, z31.s // encoding: [0xff,0x3f,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-00111111-11111111
eorv    b0, p0, z0.b  // 00000100-00011001-00100000-00000000
// CHECK: eorv    b0, p0, z0.b // encoding: [0x00,0x20,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-00100000-00000000
EORV    B0, P0, Z0.B  // 00000100-00011001-00100000-00000000
// CHECK: eorv    b0, p0, z0.b // encoding: [0x00,0x20,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-00100000-00000000
eorv    b21, p5, z10.b  // 00000100-00011001-00110101-01010101
// CHECK: eorv    b21, p5, z10.b // encoding: [0x55,0x35,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-00110101-01010101
EORV    B21, P5, Z10.B  // 00000100-00011001-00110101-01010101
// CHECK: eorv    b21, p5, z10.b // encoding: [0x55,0x35,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-00110101-01010101
eorv    h0, p0, z0.h  // 00000100-01011001-00100000-00000000
// CHECK: eorv    h0, p0, z0.h // encoding: [0x00,0x20,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-00100000-00000000
EORV    H0, P0, Z0.H  // 00000100-01011001-00100000-00000000
// CHECK: eorv    h0, p0, z0.h // encoding: [0x00,0x20,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-00100000-00000000
eorv    d23, p3, z13.d  // 00000100-11011001-00101101-10110111
// CHECK: eorv    d23, p3, z13.d // encoding: [0xb7,0x2d,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-00101101-10110111
EORV    D23, P3, Z13.D  // 00000100-11011001-00101101-10110111
// CHECK: eorv    d23, p3, z13.d // encoding: [0xb7,0x2d,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-00101101-10110111
eorv    s0, p0, z0.s  // 00000100-10011001-00100000-00000000
// CHECK: eorv    s0, p0, z0.s // encoding: [0x00,0x20,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-00100000-00000000
EORV    S0, P0, Z0.S  // 00000100-10011001-00100000-00000000
// CHECK: eorv    s0, p0, z0.s // encoding: [0x00,0x20,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-00100000-00000000
eorv    d21, p5, z10.d  // 00000100-11011001-00110101-01010101
// CHECK: eorv    d21, p5, z10.d // encoding: [0x55,0x35,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-00110101-01010101
EORV    D21, P5, Z10.D  // 00000100-11011001-00110101-01010101
// CHECK: eorv    d21, p5, z10.d // encoding: [0x55,0x35,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-00110101-01010101
eorv    d31, p7, z31.d  // 00000100-11011001-00111111-11111111
// CHECK: eorv    d31, p7, z31.d // encoding: [0xff,0x3f,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-00111111-11111111
EORV    D31, P7, Z31.D  // 00000100-11011001-00111111-11111111
// CHECK: eorv    d31, p7, z31.d // encoding: [0xff,0x3f,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-00111111-11111111
eorv    s23, p3, z13.s  // 00000100-10011001-00101101-10110111
// CHECK: eorv    s23, p3, z13.s // encoding: [0xb7,0x2d,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-00101101-10110111
EORV    S23, P3, Z13.S  // 00000100-10011001-00101101-10110111
// CHECK: eorv    s23, p3, z13.s // encoding: [0xb7,0x2d,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-00101101-10110111
eorv    d0, p0, z0.d  // 00000100-11011001-00100000-00000000
// CHECK: eorv    d0, p0, z0.d // encoding: [0x00,0x20,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-00100000-00000000
EORV    D0, P0, Z0.D  // 00000100-11011001-00100000-00000000
// CHECK: eorv    d0, p0, z0.d // encoding: [0x00,0x20,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-00100000-00000000
eorv    h23, p3, z13.h  // 00000100-01011001-00101101-10110111
// CHECK: eorv    h23, p3, z13.h // encoding: [0xb7,0x2d,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-00101101-10110111
EORV    H23, P3, Z13.H  // 00000100-01011001-00101101-10110111
// CHECK: eorv    h23, p3, z13.h // encoding: [0xb7,0x2d,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-00101101-10110111
eorv    s21, p5, z10.s  // 00000100-10011001-00110101-01010101
// CHECK: eorv    s21, p5, z10.s // encoding: [0x55,0x35,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-00110101-01010101
EORV    S21, P5, Z10.S  // 00000100-10011001-00110101-01010101
// CHECK: eorv    s21, p5, z10.s // encoding: [0x55,0x35,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-00110101-01010101
eorv    b23, p3, z13.b  // 00000100-00011001-00101101-10110111
// CHECK: eorv    b23, p3, z13.b // encoding: [0xb7,0x2d,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-00101101-10110111
EORV    B23, P3, Z13.B  // 00000100-00011001-00101101-10110111
// CHECK: eorv    b23, p3, z13.b // encoding: [0xb7,0x2d,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-00101101-10110111
eorv    h21, p5, z10.h  // 00000100-01011001-00110101-01010101
// CHECK: eorv    h21, p5, z10.h // encoding: [0x55,0x35,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-00110101-01010101
EORV    H21, P5, Z10.H  // 00000100-01011001-00110101-01010101
// CHECK: eorv    h21, p5, z10.h // encoding: [0x55,0x35,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-00110101-01010101
eorv    h31, p7, z31.h  // 00000100-01011001-00111111-11111111
// CHECK: eorv    h31, p7, z31.h // encoding: [0xff,0x3f,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-00111111-11111111
EORV    H31, P7, Z31.H  // 00000100-01011001-00111111-11111111
// CHECK: eorv    h31, p7, z31.h // encoding: [0xff,0x3f,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-00111111-11111111
eorv    b31, p7, z31.b  // 00000100-00011001-00111111-11111111
// CHECK: eorv    b31, p7, z31.b // encoding: [0xff,0x3f,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-00111111-11111111
EORV    B31, P7, Z31.B  // 00000100-00011001-00111111-11111111
// CHECK: eorv    b31, p7, z31.b // encoding: [0xff,0x3f,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-00111111-11111111
