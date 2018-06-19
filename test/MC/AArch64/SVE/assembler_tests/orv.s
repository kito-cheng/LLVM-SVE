// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
orv     h31, p7, z31.h  // 00000100-01011000-00111111-11111111
// CHECK: orv     h31, p7, z31.h // encoding: [0xff,0x3f,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-00111111-11111111
ORV     H31, P7, Z31.H  // 00000100-01011000-00111111-11111111
// CHECK: orv     h31, p7, z31.h // encoding: [0xff,0x3f,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-00111111-11111111
orv     b0, p0, z0.b  // 00000100-00011000-00100000-00000000
// CHECK: orv     b0, p0, z0.b // encoding: [0x00,0x20,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-00100000-00000000
ORV     B0, P0, Z0.B  // 00000100-00011000-00100000-00000000
// CHECK: orv     b0, p0, z0.b // encoding: [0x00,0x20,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-00100000-00000000
orv     b23, p3, z13.b  // 00000100-00011000-00101101-10110111
// CHECK: orv     b23, p3, z13.b // encoding: [0xb7,0x2d,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-00101101-10110111
ORV     B23, P3, Z13.B  // 00000100-00011000-00101101-10110111
// CHECK: orv     b23, p3, z13.b // encoding: [0xb7,0x2d,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-00101101-10110111
orv     d31, p7, z31.d  // 00000100-11011000-00111111-11111111
// CHECK: orv     d31, p7, z31.d // encoding: [0xff,0x3f,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-00111111-11111111
ORV     D31, P7, Z31.D  // 00000100-11011000-00111111-11111111
// CHECK: orv     d31, p7, z31.d // encoding: [0xff,0x3f,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-00111111-11111111
orv     b21, p5, z10.b  // 00000100-00011000-00110101-01010101
// CHECK: orv     b21, p5, z10.b // encoding: [0x55,0x35,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-00110101-01010101
ORV     B21, P5, Z10.B  // 00000100-00011000-00110101-01010101
// CHECK: orv     b21, p5, z10.b // encoding: [0x55,0x35,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-00110101-01010101
orv     d21, p5, z10.d  // 00000100-11011000-00110101-01010101
// CHECK: orv     d21, p5, z10.d // encoding: [0x55,0x35,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-00110101-01010101
ORV     D21, P5, Z10.D  // 00000100-11011000-00110101-01010101
// CHECK: orv     d21, p5, z10.d // encoding: [0x55,0x35,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-00110101-01010101
orv     b31, p7, z31.b  // 00000100-00011000-00111111-11111111
// CHECK: orv     b31, p7, z31.b // encoding: [0xff,0x3f,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-00111111-11111111
ORV     B31, P7, Z31.B  // 00000100-00011000-00111111-11111111
// CHECK: orv     b31, p7, z31.b // encoding: [0xff,0x3f,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-00111111-11111111
orv     h0, p0, z0.h  // 00000100-01011000-00100000-00000000
// CHECK: orv     h0, p0, z0.h // encoding: [0x00,0x20,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-00100000-00000000
ORV     H0, P0, Z0.H  // 00000100-01011000-00100000-00000000
// CHECK: orv     h0, p0, z0.h // encoding: [0x00,0x20,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-00100000-00000000
orv     h21, p5, z10.h  // 00000100-01011000-00110101-01010101
// CHECK: orv     h21, p5, z10.h // encoding: [0x55,0x35,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-00110101-01010101
ORV     H21, P5, Z10.H  // 00000100-01011000-00110101-01010101
// CHECK: orv     h21, p5, z10.h // encoding: [0x55,0x35,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-00110101-01010101
orv     s31, p7, z31.s  // 00000100-10011000-00111111-11111111
// CHECK: orv     s31, p7, z31.s // encoding: [0xff,0x3f,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-00111111-11111111
ORV     S31, P7, Z31.S  // 00000100-10011000-00111111-11111111
// CHECK: orv     s31, p7, z31.s // encoding: [0xff,0x3f,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-00111111-11111111
orv     s21, p5, z10.s  // 00000100-10011000-00110101-01010101
// CHECK: orv     s21, p5, z10.s // encoding: [0x55,0x35,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-00110101-01010101
ORV     S21, P5, Z10.S  // 00000100-10011000-00110101-01010101
// CHECK: orv     s21, p5, z10.s // encoding: [0x55,0x35,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-00110101-01010101
orv     d0, p0, z0.d  // 00000100-11011000-00100000-00000000
// CHECK: orv     d0, p0, z0.d // encoding: [0x00,0x20,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-00100000-00000000
ORV     D0, P0, Z0.D  // 00000100-11011000-00100000-00000000
// CHECK: orv     d0, p0, z0.d // encoding: [0x00,0x20,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-00100000-00000000
orv     s23, p3, z13.s  // 00000100-10011000-00101101-10110111
// CHECK: orv     s23, p3, z13.s // encoding: [0xb7,0x2d,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-00101101-10110111
ORV     S23, P3, Z13.S  // 00000100-10011000-00101101-10110111
// CHECK: orv     s23, p3, z13.s // encoding: [0xb7,0x2d,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-00101101-10110111
orv     d23, p3, z13.d  // 00000100-11011000-00101101-10110111
// CHECK: orv     d23, p3, z13.d // encoding: [0xb7,0x2d,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-00101101-10110111
ORV     D23, P3, Z13.D  // 00000100-11011000-00101101-10110111
// CHECK: orv     d23, p3, z13.d // encoding: [0xb7,0x2d,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-00101101-10110111
orv     h23, p3, z13.h  // 00000100-01011000-00101101-10110111
// CHECK: orv     h23, p3, z13.h // encoding: [0xb7,0x2d,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-00101101-10110111
ORV     H23, P3, Z13.H  // 00000100-01011000-00101101-10110111
// CHECK: orv     h23, p3, z13.h // encoding: [0xb7,0x2d,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-00101101-10110111
orv     s0, p0, z0.s  // 00000100-10011000-00100000-00000000
// CHECK: orv     s0, p0, z0.s // encoding: [0x00,0x20,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-00100000-00000000
ORV     S0, P0, Z0.S  // 00000100-10011000-00100000-00000000
// CHECK: orv     s0, p0, z0.s // encoding: [0x00,0x20,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-00100000-00000000
