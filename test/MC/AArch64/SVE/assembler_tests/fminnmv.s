// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fminnmv h21, p5, z10.h  // 01100101-01000101-00110101-01010101
// CHECK: fminnmv h21, p5, z10.h // encoding: [0x55,0x35,0x45,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000101-00110101-01010101
FMINNMV H21, P5, Z10.H  // 01100101-01000101-00110101-01010101
// CHECK: fminnmv h21, p5, z10.h // encoding: [0x55,0x35,0x45,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000101-00110101-01010101
fminnmv s31, p7, z31.s  // 01100101-10000101-00111111-11111111
// CHECK: fminnmv s31, p7, z31.s // encoding: [0xff,0x3f,0x85,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000101-00111111-11111111
FMINNMV S31, P7, Z31.S  // 01100101-10000101-00111111-11111111
// CHECK: fminnmv s31, p7, z31.s // encoding: [0xff,0x3f,0x85,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000101-00111111-11111111
fminnmv d23, p3, z13.d  // 01100101-11000101-00101101-10110111
// CHECK: fminnmv d23, p3, z13.d // encoding: [0xb7,0x2d,0xc5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000101-00101101-10110111
FMINNMV D23, P3, Z13.D  // 01100101-11000101-00101101-10110111
// CHECK: fminnmv d23, p3, z13.d // encoding: [0xb7,0x2d,0xc5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000101-00101101-10110111
fminnmv d0, p0, z0.d  // 01100101-11000101-00100000-00000000
// CHECK: fminnmv d0, p0, z0.d // encoding: [0x00,0x20,0xc5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000101-00100000-00000000
FMINNMV D0, P0, Z0.D  // 01100101-11000101-00100000-00000000
// CHECK: fminnmv d0, p0, z0.d // encoding: [0x00,0x20,0xc5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000101-00100000-00000000
fminnmv d21, p5, z10.d  // 01100101-11000101-00110101-01010101
// CHECK: fminnmv d21, p5, z10.d // encoding: [0x55,0x35,0xc5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000101-00110101-01010101
FMINNMV D21, P5, Z10.D  // 01100101-11000101-00110101-01010101
// CHECK: fminnmv d21, p5, z10.d // encoding: [0x55,0x35,0xc5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000101-00110101-01010101
fminnmv h23, p3, z13.h  // 01100101-01000101-00101101-10110111
// CHECK: fminnmv h23, p3, z13.h // encoding: [0xb7,0x2d,0x45,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000101-00101101-10110111
FMINNMV H23, P3, Z13.H  // 01100101-01000101-00101101-10110111
// CHECK: fminnmv h23, p3, z13.h // encoding: [0xb7,0x2d,0x45,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000101-00101101-10110111
fminnmv s21, p5, z10.s  // 01100101-10000101-00110101-01010101
// CHECK: fminnmv s21, p5, z10.s // encoding: [0x55,0x35,0x85,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000101-00110101-01010101
FMINNMV S21, P5, Z10.S  // 01100101-10000101-00110101-01010101
// CHECK: fminnmv s21, p5, z10.s // encoding: [0x55,0x35,0x85,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000101-00110101-01010101
fminnmv h31, p7, z31.h  // 01100101-01000101-00111111-11111111
// CHECK: fminnmv h31, p7, z31.h // encoding: [0xff,0x3f,0x45,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000101-00111111-11111111
FMINNMV H31, P7, Z31.H  // 01100101-01000101-00111111-11111111
// CHECK: fminnmv h31, p7, z31.h // encoding: [0xff,0x3f,0x45,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000101-00111111-11111111
fminnmv h0, p0, z0.h  // 01100101-01000101-00100000-00000000
// CHECK: fminnmv h0, p0, z0.h // encoding: [0x00,0x20,0x45,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000101-00100000-00000000
FMINNMV H0, P0, Z0.H  // 01100101-01000101-00100000-00000000
// CHECK: fminnmv h0, p0, z0.h // encoding: [0x00,0x20,0x45,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000101-00100000-00000000
fminnmv d31, p7, z31.d  // 01100101-11000101-00111111-11111111
// CHECK: fminnmv d31, p7, z31.d // encoding: [0xff,0x3f,0xc5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000101-00111111-11111111
FMINNMV D31, P7, Z31.D  // 01100101-11000101-00111111-11111111
// CHECK: fminnmv d31, p7, z31.d // encoding: [0xff,0x3f,0xc5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000101-00111111-11111111
fminnmv s23, p3, z13.s  // 01100101-10000101-00101101-10110111
// CHECK: fminnmv s23, p3, z13.s // encoding: [0xb7,0x2d,0x85,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000101-00101101-10110111
FMINNMV S23, P3, Z13.S  // 01100101-10000101-00101101-10110111
// CHECK: fminnmv s23, p3, z13.s // encoding: [0xb7,0x2d,0x85,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000101-00101101-10110111
fminnmv s0, p0, z0.s  // 01100101-10000101-00100000-00000000
// CHECK: fminnmv s0, p0, z0.s // encoding: [0x00,0x20,0x85,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000101-00100000-00000000
FMINNMV S0, P0, Z0.S  // 01100101-10000101-00100000-00000000
// CHECK: fminnmv s0, p0, z0.s // encoding: [0x00,0x20,0x85,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000101-00100000-00000000
