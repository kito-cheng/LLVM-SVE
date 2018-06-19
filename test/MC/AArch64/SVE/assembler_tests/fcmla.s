// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcmla   z21.h, z10.h, z5.h[2], #90  // 01100100-10110101-00010101-01010101
// CHECK: fcmla   z21.h, z10.h, z5.h[2], #90 // encoding: [0x55,0x15,0xb5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10110101-00010101-01010101
FCMLA   Z21.H, Z10.H, Z5.H[2], #90  // 01100100-10110101-00010101-01010101
// CHECK: fcmla   z21.h, z10.h, z5.h[2], #90 // encoding: [0x55,0x15,0xb5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10110101-00010101-01010101
fcmla   z21.d, p5/m, z10.d, z21.d, #180  // 01100100-11010101-01010101-01010101
// CHECK: fcmla   z21.d, p5/m, z10.d, z21.d, #180 // encoding: [0x55,0x55,0xd5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11010101-01010101-01010101
FCMLA   Z21.D, P5/M, Z10.D, Z21.D, #180  // 01100100-11010101-01010101-01010101
// CHECK: fcmla   z21.d, p5/m, z10.d, z21.d, #180 // encoding: [0x55,0x55,0xd5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11010101-01010101-01010101
fcmla   z21.s, p5/m, z10.s, z21.s, #180  // 01100100-10010101-01010101-01010101
// CHECK: fcmla   z21.s, p5/m, z10.s, z21.s, #180 // encoding: [0x55,0x55,0x95,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10010101-01010101-01010101
FCMLA   Z21.S, P5/M, Z10.S, Z21.S, #180  // 01100100-10010101-01010101-01010101
// CHECK: fcmla   z21.s, p5/m, z10.s, z21.s, #180 // encoding: [0x55,0x55,0x95,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10010101-01010101-01010101
fcmla   z23.d, p3/m, z13.d, z8.d, #270  // 01100100-11001000-01101101-10110111
// CHECK: fcmla   z23.d, p3/m, z13.d, z8.d, #270 // encoding: [0xb7,0x6d,0xc8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11001000-01101101-10110111
FCMLA   Z23.D, P3/M, Z13.D, Z8.D, #270  // 01100100-11001000-01101101-10110111
// CHECK: fcmla   z23.d, p3/m, z13.d, z8.d, #270 // encoding: [0xb7,0x6d,0xc8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11001000-01101101-10110111
fcmla   z23.s, z13.s, z8.s[0], #270  // 01100100-11101000-00011101-10110111
// CHECK: fcmla   z23.s, z13.s, z8.s[0], #270 // encoding: [0xb7,0x1d,0xe8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11101000-00011101-10110111
FCMLA   Z23.S, Z13.S, Z8.S[0], #270  // 01100100-11101000-00011101-10110111
// CHECK: fcmla   z23.s, z13.s, z8.s[0], #270 // encoding: [0xb7,0x1d,0xe8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11101000-00011101-10110111
fcmla   z23.h, p3/m, z13.h, z8.h, #270  // 01100100-01001000-01101101-10110111
// CHECK: fcmla   z23.h, p3/m, z13.h, z8.h, #270 // encoding: [0xb7,0x6d,0x48,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01001000-01101101-10110111
FCMLA   Z23.H, P3/M, Z13.H, Z8.H, #270  // 01100100-01001000-01101101-10110111
// CHECK: fcmla   z23.h, p3/m, z13.h, z8.h, #270 // encoding: [0xb7,0x6d,0x48,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01001000-01101101-10110111
fcmla   z31.d, p7/m, z31.d, z31.d, #270  // 01100100-11011111-01111111-11111111
// CHECK: fcmla   z31.d, p7/m, z31.d, z31.d, #270 // encoding: [0xff,0x7f,0xdf,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11011111-01111111-11111111
FCMLA   Z31.D, P7/M, Z31.D, Z31.D, #270  // 01100100-11011111-01111111-11111111
// CHECK: fcmla   z31.d, p7/m, z31.d, z31.d, #270 // encoding: [0xff,0x7f,0xdf,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11011111-01111111-11111111
fcmla   z21.h, p5/m, z10.h, z21.h, #180  // 01100100-01010101-01010101-01010101
// CHECK: fcmla   z21.h, p5/m, z10.h, z21.h, #180 // encoding: [0x55,0x55,0x55,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01010101-01010101-01010101
FCMLA   Z21.H, P5/M, Z10.H, Z21.H, #180  // 01100100-01010101-01010101-01010101
// CHECK: fcmla   z21.h, p5/m, z10.h, z21.h, #180 // encoding: [0x55,0x55,0x55,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01010101-01010101-01010101
fcmla   z0.h, z0.h, z0.h[0], #0  // 01100100-10100000-00010000-00000000
// CHECK: fcmla   z0.h, z0.h, z0.h[0], #0 // encoding: [0x00,0x10,0xa0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10100000-00010000-00000000
FCMLA   Z0.H, Z0.H, Z0.H[0], #0  // 01100100-10100000-00010000-00000000
// CHECK: fcmla   z0.h, z0.h, z0.h[0], #0 // encoding: [0x00,0x10,0xa0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10100000-00010000-00000000
fcmla   z31.h, p7/m, z31.h, z31.h, #270  // 01100100-01011111-01111111-11111111
// CHECK: fcmla   z31.h, p7/m, z31.h, z31.h, #270 // encoding: [0xff,0x7f,0x5f,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01011111-01111111-11111111
FCMLA   Z31.H, P7/M, Z31.H, Z31.H, #270  // 01100100-01011111-01111111-11111111
// CHECK: fcmla   z31.h, p7/m, z31.h, z31.h, #270 // encoding: [0xff,0x7f,0x5f,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01011111-01111111-11111111
fcmla   z0.d, p0/m, z0.d, z0.d, #0  // 01100100-11000000-00000000-00000000
// CHECK: fcmla   z0.d, p0/m, z0.d, z0.d, #0 // encoding: [0x00,0x00,0xc0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11000000-00000000-00000000
FCMLA   Z0.D, P0/M, Z0.D, Z0.D, #0  // 01100100-11000000-00000000-00000000
// CHECK: fcmla   z0.d, p0/m, z0.d, z0.d, #0 // encoding: [0x00,0x00,0xc0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11000000-00000000-00000000
fcmla   z31.s, z31.s, z15.s[1], #270  // 01100100-11111111-00011111-11111111
// CHECK: fcmla   z31.s, z31.s, z15.s[1], #270 // encoding: [0xff,0x1f,0xff,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11111111-00011111-11111111
FCMLA   Z31.S, Z31.S, Z15.S[1], #270  // 01100100-11111111-00011111-11111111
// CHECK: fcmla   z31.s, z31.s, z15.s[1], #270 // encoding: [0xff,0x1f,0xff,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11111111-00011111-11111111
fcmla   z23.s, p3/m, z13.s, z8.s, #270  // 01100100-10001000-01101101-10110111
// CHECK: fcmla   z23.s, p3/m, z13.s, z8.s, #270 // encoding: [0xb7,0x6d,0x88,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10001000-01101101-10110111
FCMLA   Z23.S, P3/M, Z13.S, Z8.S, #270  // 01100100-10001000-01101101-10110111
// CHECK: fcmla   z23.s, p3/m, z13.s, z8.s, #270 // encoding: [0xb7,0x6d,0x88,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10001000-01101101-10110111
fcmla   z0.s, z0.s, z0.s[0], #0  // 01100100-11100000-00010000-00000000
// CHECK: fcmla   z0.s, z0.s, z0.s[0], #0 // encoding: [0x00,0x10,0xe0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11100000-00010000-00000000
FCMLA   Z0.S, Z0.S, Z0.S[0], #0  // 01100100-11100000-00010000-00000000
// CHECK: fcmla   z0.s, z0.s, z0.s[0], #0 // encoding: [0x00,0x10,0xe0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11100000-00010000-00000000
fcmla   z0.s, p0/m, z0.s, z0.s, #0  // 01100100-10000000-00000000-00000000
// CHECK: fcmla   z0.s, p0/m, z0.s, z0.s, #0 // encoding: [0x00,0x00,0x80,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10000000-00000000-00000000
FCMLA   Z0.S, P0/M, Z0.S, Z0.S, #0  // 01100100-10000000-00000000-00000000
// CHECK: fcmla   z0.s, p0/m, z0.s, z0.s, #0 // encoding: [0x00,0x00,0x80,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10000000-00000000-00000000
fcmla   z0.h, p0/m, z0.h, z0.h, #0  // 01100100-01000000-00000000-00000000
// CHECK: fcmla   z0.h, p0/m, z0.h, z0.h, #0 // encoding: [0x00,0x00,0x40,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01000000-00000000-00000000
FCMLA   Z0.H, P0/M, Z0.H, Z0.H, #0  // 01100100-01000000-00000000-00000000
// CHECK: fcmla   z0.h, p0/m, z0.h, z0.h, #0 // encoding: [0x00,0x00,0x40,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01000000-00000000-00000000
fcmla   z31.h, z31.h, z7.h[3], #270  // 01100100-10111111-00011111-11111111
// CHECK: fcmla   z31.h, z31.h, z7.h[3], #270 // encoding: [0xff,0x1f,0xbf,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10111111-00011111-11111111
FCMLA   Z31.H, Z31.H, Z7.H[3], #270  // 01100100-10111111-00011111-11111111
// CHECK: fcmla   z31.h, z31.h, z7.h[3], #270 // encoding: [0xff,0x1f,0xbf,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10111111-00011111-11111111
fcmla   z31.s, p7/m, z31.s, z31.s, #270  // 01100100-10011111-01111111-11111111
// CHECK: fcmla   z31.s, p7/m, z31.s, z31.s, #270 // encoding: [0xff,0x7f,0x9f,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10011111-01111111-11111111
FCMLA   Z31.S, P7/M, Z31.S, Z31.S, #270  // 01100100-10011111-01111111-11111111
// CHECK: fcmla   z31.s, p7/m, z31.s, z31.s, #270 // encoding: [0xff,0x7f,0x9f,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10011111-01111111-11111111
fcmla   z21.s, z10.s, z5.s[1], #90  // 01100100-11110101-00010101-01010101
// CHECK: fcmla   z21.s, z10.s, z5.s[1], #90 // encoding: [0x55,0x15,0xf5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11110101-00010101-01010101
FCMLA   Z21.S, Z10.S, Z5.S[1], #90  // 01100100-11110101-00010101-01010101
// CHECK: fcmla   z21.s, z10.s, z5.s[1], #90 // encoding: [0x55,0x15,0xf5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11110101-00010101-01010101
fcmla   z23.h, z13.h, z0.h[1], #270  // 01100100-10101000-00011101-10110111
// CHECK: fcmla   z23.h, z13.h, z0.h[1], #270 // encoding: [0xb7,0x1d,0xa8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10101000-00011101-10110111
FCMLA   Z23.H, Z13.H, Z0.H[1], #270  // 01100100-10101000-00011101-10110111
// CHECK: fcmla   z23.h, z13.h, z0.h[1], #270 // encoding: [0xb7,0x1d,0xa8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10101000-00011101-10110111
