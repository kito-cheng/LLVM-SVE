// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clastb  z0.b, p0, z0.b, z0.b  // 00000101-00101001-10000000-00000000
// CHECK: clastb  z0.b, p0, z0.b, z0.b // encoding: [0x00,0x80,0x29,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101001-10000000-00000000
CLASTB  Z0.B, P0, Z0.B, Z0.B  // 00000101-00101001-10000000-00000000
// CHECK: clastb  z0.b, p0, z0.b, z0.b // encoding: [0x00,0x80,0x29,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101001-10000000-00000000
clastb  z21.b, p5, z21.b, z10.b  // 00000101-00101001-10010101-01010101
// CHECK: clastb  z21.b, p5, z21.b, z10.b // encoding: [0x55,0x95,0x29,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101001-10010101-01010101
CLASTB  Z21.B, P5, Z21.B, Z10.B  // 00000101-00101001-10010101-01010101
// CHECK: clastb  z21.b, p5, z21.b, z10.b // encoding: [0x55,0x95,0x29,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101001-10010101-01010101
clastb  z21.d, p5, z21.d, z10.d  // 00000101-11101001-10010101-01010101
// CHECK: clastb  z21.d, p5, z21.d, z10.d // encoding: [0x55,0x95,0xe9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101001-10010101-01010101
CLASTB  Z21.D, P5, Z21.D, Z10.D  // 00000101-11101001-10010101-01010101
// CHECK: clastb  z21.d, p5, z21.d, z10.d // encoding: [0x55,0x95,0xe9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101001-10010101-01010101
clastb  wzr, p7, wzr, z31.h  // 00000101-01110001-10111111-11111111
// CHECK: clastb  wzr, p7, wzr, z31.h // encoding: [0xff,0xbf,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-10111111-11111111
CLASTB  WZR, P7, WZR, Z31.H  // 00000101-01110001-10111111-11111111
// CHECK: clastb  wzr, p7, wzr, z31.h // encoding: [0xff,0xbf,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-10111111-11111111
clastb  b23, p3, b23, z13.b  // 00000101-00101011-10001101-10110111
// CHECK: clastb  b23, p3, b23, z13.b // encoding: [0xb7,0x8d,0x2b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101011-10001101-10110111
CLASTB  B23, P3, B23, Z13.B  // 00000101-00101011-10001101-10110111
// CHECK: clastb  b23, p3, b23, z13.b // encoding: [0xb7,0x8d,0x2b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101011-10001101-10110111
clastb  z21.h, p5, z21.h, z10.h  // 00000101-01101001-10010101-01010101
// CHECK: clastb  z21.h, p5, z21.h, z10.h // encoding: [0x55,0x95,0x69,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101001-10010101-01010101
CLASTB  Z21.H, P5, Z21.H, Z10.H  // 00000101-01101001-10010101-01010101
// CHECK: clastb  z21.h, p5, z21.h, z10.h // encoding: [0x55,0x95,0x69,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101001-10010101-01010101
clastb  z31.d, p7, z31.d, z31.d  // 00000101-11101001-10011111-11111111
// CHECK: clastb  z31.d, p7, z31.d, z31.d // encoding: [0xff,0x9f,0xe9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101001-10011111-11111111
CLASTB  Z31.D, P7, Z31.D, Z31.D  // 00000101-11101001-10011111-11111111
// CHECK: clastb  z31.d, p7, z31.d, z31.d // encoding: [0xff,0x9f,0xe9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101001-10011111-11111111
clastb  b0, p0, b0, z0.b  // 00000101-00101011-10000000-00000000
// CHECK: clastb  b0, p0, b0, z0.b // encoding: [0x00,0x80,0x2b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101011-10000000-00000000
CLASTB  B0, P0, B0, Z0.B  // 00000101-00101011-10000000-00000000
// CHECK: clastb  b0, p0, b0, z0.b // encoding: [0x00,0x80,0x2b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101011-10000000-00000000
clastb  h23, p3, h23, z13.h  // 00000101-01101011-10001101-10110111
// CHECK: clastb  h23, p3, h23, z13.h // encoding: [0xb7,0x8d,0x6b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101011-10001101-10110111
CLASTB  H23, P3, H23, Z13.H  // 00000101-01101011-10001101-10110111
// CHECK: clastb  h23, p3, h23, z13.h // encoding: [0xb7,0x8d,0x6b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101011-10001101-10110111
clastb  s31, p7, s31, z31.s  // 00000101-10101011-10011111-11111111
// CHECK: clastb  s31, p7, s31, z31.s // encoding: [0xff,0x9f,0xab,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101011-10011111-11111111
CLASTB  S31, P7, S31, Z31.S  // 00000101-10101011-10011111-11111111
// CHECK: clastb  s31, p7, s31, z31.s // encoding: [0xff,0x9f,0xab,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101011-10011111-11111111
clastb  d0, p0, d0, z0.d  // 00000101-11101011-10000000-00000000
// CHECK: clastb  d0, p0, d0, z0.d // encoding: [0x00,0x80,0xeb,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101011-10000000-00000000
CLASTB  D0, P0, D0, Z0.D  // 00000101-11101011-10000000-00000000
// CHECK: clastb  d0, p0, d0, z0.d // encoding: [0x00,0x80,0xeb,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101011-10000000-00000000
clastb  w0, p0, w0, z0.s  // 00000101-10110001-10100000-00000000
// CHECK: clastb  w0, p0, w0, z0.s // encoding: [0x00,0xa0,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-10100000-00000000
CLASTB  W0, P0, W0, Z0.S  // 00000101-10110001-10100000-00000000
// CHECK: clastb  w0, p0, w0, z0.s // encoding: [0x00,0xa0,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-10100000-00000000
clastb  x23, p3, x23, z13.d  // 00000101-11110001-10101101-10110111
// CHECK: clastb  x23, p3, x23, z13.d // encoding: [0xb7,0xad,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-10101101-10110111
CLASTB  X23, P3, X23, Z13.D  // 00000101-11110001-10101101-10110111
// CHECK: clastb  x23, p3, x23, z13.d // encoding: [0xb7,0xad,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-10101101-10110111
clastb  w21, p5, w21, z10.b  // 00000101-00110001-10110101-01010101
// CHECK: clastb  w21, p5, w21, z10.b // encoding: [0x55,0xb5,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-10110101-01010101
CLASTB  W21, P5, W21, Z10.B  // 00000101-00110001-10110101-01010101
// CHECK: clastb  w21, p5, w21, z10.b // encoding: [0x55,0xb5,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-10110101-01010101
clastb  z31.b, p7, z31.b, z31.b  // 00000101-00101001-10011111-11111111
// CHECK: clastb  z31.b, p7, z31.b, z31.b // encoding: [0xff,0x9f,0x29,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101001-10011111-11111111
CLASTB  Z31.B, P7, Z31.B, Z31.B  // 00000101-00101001-10011111-11111111
// CHECK: clastb  z31.b, p7, z31.b, z31.b // encoding: [0xff,0x9f,0x29,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101001-10011111-11111111
clastb  x0, p0, x0, z0.d  // 00000101-11110001-10100000-00000000
// CHECK: clastb  x0, p0, x0, z0.d // encoding: [0x00,0xa0,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-10100000-00000000
CLASTB  X0, P0, X0, Z0.D  // 00000101-11110001-10100000-00000000
// CHECK: clastb  x0, p0, x0, z0.d // encoding: [0x00,0xa0,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-10100000-00000000
clastb  h21, p5, h21, z10.h  // 00000101-01101011-10010101-01010101
// CHECK: clastb  h21, p5, h21, z10.h // encoding: [0x55,0x95,0x6b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101011-10010101-01010101
CLASTB  H21, P5, H21, Z10.H  // 00000101-01101011-10010101-01010101
// CHECK: clastb  h21, p5, h21, z10.h // encoding: [0x55,0x95,0x6b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101011-10010101-01010101
clastb  s0, p0, s0, z0.s  // 00000101-10101011-10000000-00000000
// CHECK: clastb  s0, p0, s0, z0.s // encoding: [0x00,0x80,0xab,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101011-10000000-00000000
CLASTB  S0, P0, S0, Z0.S  // 00000101-10101011-10000000-00000000
// CHECK: clastb  s0, p0, s0, z0.s // encoding: [0x00,0x80,0xab,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101011-10000000-00000000
clastb  w23, p3, w23, z13.s  // 00000101-10110001-10101101-10110111
// CHECK: clastb  w23, p3, w23, z13.s // encoding: [0xb7,0xad,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-10101101-10110111
CLASTB  W23, P3, W23, Z13.S  // 00000101-10110001-10101101-10110111
// CHECK: clastb  w23, p3, w23, z13.s // encoding: [0xb7,0xad,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-10101101-10110111
clastb  z23.h, p3, z23.h, z13.h  // 00000101-01101001-10001101-10110111
// CHECK: clastb  z23.h, p3, z23.h, z13.h // encoding: [0xb7,0x8d,0x69,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101001-10001101-10110111
CLASTB  Z23.H, P3, Z23.H, Z13.H  // 00000101-01101001-10001101-10110111
// CHECK: clastb  z23.h, p3, z23.h, z13.h // encoding: [0xb7,0x8d,0x69,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101001-10001101-10110111
clastb  z23.b, p3, z23.b, z13.b  // 00000101-00101001-10001101-10110111
// CHECK: clastb  z23.b, p3, z23.b, z13.b // encoding: [0xb7,0x8d,0x29,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101001-10001101-10110111
CLASTB  Z23.B, P3, Z23.B, Z13.B  // 00000101-00101001-10001101-10110111
// CHECK: clastb  z23.b, p3, z23.b, z13.b // encoding: [0xb7,0x8d,0x29,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101001-10001101-10110111
clastb  xzr, p7, xzr, z31.d  // 00000101-11110001-10111111-11111111
// CHECK: clastb  xzr, p7, xzr, z31.d // encoding: [0xff,0xbf,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-10111111-11111111
CLASTB  XZR, P7, XZR, Z31.D  // 00000101-11110001-10111111-11111111
// CHECK: clastb  xzr, p7, xzr, z31.d // encoding: [0xff,0xbf,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-10111111-11111111
clastb  z31.h, p7, z31.h, z31.h  // 00000101-01101001-10011111-11111111
// CHECK: clastb  z31.h, p7, z31.h, z31.h // encoding: [0xff,0x9f,0x69,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101001-10011111-11111111
CLASTB  Z31.H, P7, Z31.H, Z31.H  // 00000101-01101001-10011111-11111111
// CHECK: clastb  z31.h, p7, z31.h, z31.h // encoding: [0xff,0x9f,0x69,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101001-10011111-11111111
clastb  z21.s, p5, z21.s, z10.s  // 00000101-10101001-10010101-01010101
// CHECK: clastb  z21.s, p5, z21.s, z10.s // encoding: [0x55,0x95,0xa9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101001-10010101-01010101
CLASTB  Z21.S, P5, Z21.S, Z10.S  // 00000101-10101001-10010101-01010101
// CHECK: clastb  z21.s, p5, z21.s, z10.s // encoding: [0x55,0x95,0xa9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101001-10010101-01010101
clastb  d23, p3, d23, z13.d  // 00000101-11101011-10001101-10110111
// CHECK: clastb  d23, p3, d23, z13.d // encoding: [0xb7,0x8d,0xeb,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101011-10001101-10110111
CLASTB  D23, P3, D23, Z13.D  // 00000101-11101011-10001101-10110111
// CHECK: clastb  d23, p3, d23, z13.d // encoding: [0xb7,0x8d,0xeb,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101011-10001101-10110111
clastb  w23, p3, w23, z13.b  // 00000101-00110001-10101101-10110111
// CHECK: clastb  w23, p3, w23, z13.b // encoding: [0xb7,0xad,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-10101101-10110111
CLASTB  W23, P3, W23, Z13.B  // 00000101-00110001-10101101-10110111
// CHECK: clastb  w23, p3, w23, z13.b // encoding: [0xb7,0xad,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-10101101-10110111
clastb  s21, p5, s21, z10.s  // 00000101-10101011-10010101-01010101
// CHECK: clastb  s21, p5, s21, z10.s // encoding: [0x55,0x95,0xab,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101011-10010101-01010101
CLASTB  S21, P5, S21, Z10.S  // 00000101-10101011-10010101-01010101
// CHECK: clastb  s21, p5, s21, z10.s // encoding: [0x55,0x95,0xab,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101011-10010101-01010101
clastb  x21, p5, x21, z10.d  // 00000101-11110001-10110101-01010101
// CHECK: clastb  x21, p5, x21, z10.d // encoding: [0x55,0xb5,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-10110101-01010101
CLASTB  X21, P5, X21, Z10.D  // 00000101-11110001-10110101-01010101
// CHECK: clastb  x21, p5, x21, z10.d // encoding: [0x55,0xb5,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-10110101-01010101
clastb  z0.d, p0, z0.d, z0.d  // 00000101-11101001-10000000-00000000
// CHECK: clastb  z0.d, p0, z0.d, z0.d // encoding: [0x00,0x80,0xe9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101001-10000000-00000000
CLASTB  Z0.D, P0, Z0.D, Z0.D  // 00000101-11101001-10000000-00000000
// CHECK: clastb  z0.d, p0, z0.d, z0.d // encoding: [0x00,0x80,0xe9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101001-10000000-00000000
clastb  z0.s, p0, z0.s, z0.s  // 00000101-10101001-10000000-00000000
// CHECK: clastb  z0.s, p0, z0.s, z0.s // encoding: [0x00,0x80,0xa9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101001-10000000-00000000
CLASTB  Z0.S, P0, Z0.S, Z0.S  // 00000101-10101001-10000000-00000000
// CHECK: clastb  z0.s, p0, z0.s, z0.s // encoding: [0x00,0x80,0xa9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101001-10000000-00000000
clastb  z23.s, p3, z23.s, z13.s  // 00000101-10101001-10001101-10110111
// CHECK: clastb  z23.s, p3, z23.s, z13.s // encoding: [0xb7,0x8d,0xa9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101001-10001101-10110111
CLASTB  Z23.S, P3, Z23.S, Z13.S  // 00000101-10101001-10001101-10110111
// CHECK: clastb  z23.s, p3, z23.s, z13.s // encoding: [0xb7,0x8d,0xa9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101001-10001101-10110111
clastb  wzr, p7, wzr, z31.b  // 00000101-00110001-10111111-11111111
// CHECK: clastb  wzr, p7, wzr, z31.b // encoding: [0xff,0xbf,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-10111111-11111111
CLASTB  WZR, P7, WZR, Z31.B  // 00000101-00110001-10111111-11111111
// CHECK: clastb  wzr, p7, wzr, z31.b // encoding: [0xff,0xbf,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-10111111-11111111
clastb  w21, p5, w21, z10.h  // 00000101-01110001-10110101-01010101
// CHECK: clastb  w21, p5, w21, z10.h // encoding: [0x55,0xb5,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-10110101-01010101
CLASTB  W21, P5, W21, Z10.H  // 00000101-01110001-10110101-01010101
// CHECK: clastb  w21, p5, w21, z10.h // encoding: [0x55,0xb5,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-10110101-01010101
clastb  d21, p5, d21, z10.d  // 00000101-11101011-10010101-01010101
// CHECK: clastb  d21, p5, d21, z10.d // encoding: [0x55,0x95,0xeb,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101011-10010101-01010101
CLASTB  D21, P5, D21, Z10.D  // 00000101-11101011-10010101-01010101
// CHECK: clastb  d21, p5, d21, z10.d // encoding: [0x55,0x95,0xeb,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101011-10010101-01010101
clastb  w0, p0, w0, z0.h  // 00000101-01110001-10100000-00000000
// CHECK: clastb  w0, p0, w0, z0.h // encoding: [0x00,0xa0,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-10100000-00000000
CLASTB  W0, P0, W0, Z0.H  // 00000101-01110001-10100000-00000000
// CHECK: clastb  w0, p0, w0, z0.h // encoding: [0x00,0xa0,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-10100000-00000000
clastb  s23, p3, s23, z13.s  // 00000101-10101011-10001101-10110111
// CHECK: clastb  s23, p3, s23, z13.s // encoding: [0xb7,0x8d,0xab,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101011-10001101-10110111
CLASTB  S23, P3, S23, Z13.S  // 00000101-10101011-10001101-10110111
// CHECK: clastb  s23, p3, s23, z13.s // encoding: [0xb7,0x8d,0xab,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101011-10001101-10110111
clastb  d31, p7, d31, z31.d  // 00000101-11101011-10011111-11111111
// CHECK: clastb  d31, p7, d31, z31.d // encoding: [0xff,0x9f,0xeb,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101011-10011111-11111111
CLASTB  D31, P7, D31, Z31.D  // 00000101-11101011-10011111-11111111
// CHECK: clastb  d31, p7, d31, z31.d // encoding: [0xff,0x9f,0xeb,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101011-10011111-11111111
clastb  z23.d, p3, z23.d, z13.d  // 00000101-11101001-10001101-10110111
// CHECK: clastb  z23.d, p3, z23.d, z13.d // encoding: [0xb7,0x8d,0xe9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101001-10001101-10110111
CLASTB  Z23.D, P3, Z23.D, Z13.D  // 00000101-11101001-10001101-10110111
// CHECK: clastb  z23.d, p3, z23.d, z13.d // encoding: [0xb7,0x8d,0xe9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101001-10001101-10110111
clastb  w23, p3, w23, z13.h  // 00000101-01110001-10101101-10110111
// CHECK: clastb  w23, p3, w23, z13.h // encoding: [0xb7,0xad,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-10101101-10110111
CLASTB  W23, P3, W23, Z13.H  // 00000101-01110001-10101101-10110111
// CHECK: clastb  w23, p3, w23, z13.h // encoding: [0xb7,0xad,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-10101101-10110111
clastb  b21, p5, b21, z10.b  // 00000101-00101011-10010101-01010101
// CHECK: clastb  b21, p5, b21, z10.b // encoding: [0x55,0x95,0x2b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101011-10010101-01010101
CLASTB  B21, P5, B21, Z10.B  // 00000101-00101011-10010101-01010101
// CHECK: clastb  b21, p5, b21, z10.b // encoding: [0x55,0x95,0x2b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101011-10010101-01010101
clastb  w21, p5, w21, z10.s  // 00000101-10110001-10110101-01010101
// CHECK: clastb  w21, p5, w21, z10.s // encoding: [0x55,0xb5,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-10110101-01010101
CLASTB  W21, P5, W21, Z10.S  // 00000101-10110001-10110101-01010101
// CHECK: clastb  w21, p5, w21, z10.s // encoding: [0x55,0xb5,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-10110101-01010101
clastb  z31.s, p7, z31.s, z31.s  // 00000101-10101001-10011111-11111111
// CHECK: clastb  z31.s, p7, z31.s, z31.s // encoding: [0xff,0x9f,0xa9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101001-10011111-11111111
CLASTB  Z31.S, P7, Z31.S, Z31.S  // 00000101-10101001-10011111-11111111
// CHECK: clastb  z31.s, p7, z31.s, z31.s // encoding: [0xff,0x9f,0xa9,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101001-10011111-11111111
clastb  z0.h, p0, z0.h, z0.h  // 00000101-01101001-10000000-00000000
// CHECK: clastb  z0.h, p0, z0.h, z0.h // encoding: [0x00,0x80,0x69,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101001-10000000-00000000
CLASTB  Z0.H, P0, Z0.H, Z0.H  // 00000101-01101001-10000000-00000000
// CHECK: clastb  z0.h, p0, z0.h, z0.h // encoding: [0x00,0x80,0x69,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101001-10000000-00000000
clastb  wzr, p7, wzr, z31.s  // 00000101-10110001-10111111-11111111
// CHECK: clastb  wzr, p7, wzr, z31.s // encoding: [0xff,0xbf,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-10111111-11111111
CLASTB  WZR, P7, WZR, Z31.S  // 00000101-10110001-10111111-11111111
// CHECK: clastb  wzr, p7, wzr, z31.s // encoding: [0xff,0xbf,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-10111111-11111111
clastb  h0, p0, h0, z0.h  // 00000101-01101011-10000000-00000000
// CHECK: clastb  h0, p0, h0, z0.h // encoding: [0x00,0x80,0x6b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101011-10000000-00000000
CLASTB  H0, P0, H0, Z0.H  // 00000101-01101011-10000000-00000000
// CHECK: clastb  h0, p0, h0, z0.h // encoding: [0x00,0x80,0x6b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101011-10000000-00000000
clastb  w0, p0, w0, z0.b  // 00000101-00110001-10100000-00000000
// CHECK: clastb  w0, p0, w0, z0.b // encoding: [0x00,0xa0,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-10100000-00000000
CLASTB  W0, P0, W0, Z0.B  // 00000101-00110001-10100000-00000000
// CHECK: clastb  w0, p0, w0, z0.b // encoding: [0x00,0xa0,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-10100000-00000000
clastb  b31, p7, b31, z31.b  // 00000101-00101011-10011111-11111111
// CHECK: clastb  b31, p7, b31, z31.b // encoding: [0xff,0x9f,0x2b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101011-10011111-11111111
CLASTB  B31, P7, B31, Z31.B  // 00000101-00101011-10011111-11111111
// CHECK: clastb  b31, p7, b31, z31.b // encoding: [0xff,0x9f,0x2b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101011-10011111-11111111
clastb  h31, p7, h31, z31.h  // 00000101-01101011-10011111-11111111
// CHECK: clastb  h31, p7, h31, z31.h // encoding: [0xff,0x9f,0x6b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101011-10011111-11111111
CLASTB  H31, P7, H31, Z31.H  // 00000101-01101011-10011111-11111111
// CHECK: clastb  h31, p7, h31, z31.h // encoding: [0xff,0x9f,0x6b,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101011-10011111-11111111
