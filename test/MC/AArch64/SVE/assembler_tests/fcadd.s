// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcadd   z31.h, p7/m, z31.h, z31.h, #270  // 01100100-01000001-10011111-11111111
// CHECK: fcadd   z31.h, p7/m, z31.h, z31.h, #270 // encoding: [0xff,0x9f,0x41,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01000001-10011111-11111111
FCADD   Z31.H, P7/M, Z31.H, Z31.H, #270  // 01100100-01000001-10011111-11111111
// CHECK: fcadd   z31.h, p7/m, z31.h, z31.h, #270 // encoding: [0xff,0x9f,0x41,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01000001-10011111-11111111
fcadd   z0.h, p0/m, z0.h, z0.h, #90  // 01100100-01000000-10000000-00000000
// CHECK: fcadd   z0.h, p0/m, z0.h, z0.h, #90 // encoding: [0x00,0x80,0x40,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01000000-10000000-00000000
FCADD   Z0.H, P0/M, Z0.H, Z0.H, #90  // 01100100-01000000-10000000-00000000
// CHECK: fcadd   z0.h, p0/m, z0.h, z0.h, #90 // encoding: [0x00,0x80,0x40,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01000000-10000000-00000000
fcadd   z21.h, p5/m, z21.h, z10.h, #270  // 01100100-01000001-10010101-01010101
// CHECK: fcadd   z21.h, p5/m, z21.h, z10.h, #270 // encoding: [0x55,0x95,0x41,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01000001-10010101-01010101
FCADD   Z21.H, P5/M, Z21.H, Z10.H, #270  // 01100100-01000001-10010101-01010101
// CHECK: fcadd   z21.h, p5/m, z21.h, z10.h, #270 // encoding: [0x55,0x95,0x41,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01000001-10010101-01010101
fcadd   z23.h, p3/m, z23.h, z13.h, #90  // 01100100-01000000-10001101-10110111
// CHECK: fcadd   z23.h, p3/m, z23.h, z13.h, #90 // encoding: [0xb7,0x8d,0x40,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01000000-10001101-10110111
FCADD   Z23.H, P3/M, Z23.H, Z13.H, #90  // 01100100-01000000-10001101-10110111
// CHECK: fcadd   z23.h, p3/m, z23.h, z13.h, #90 // encoding: [0xb7,0x8d,0x40,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01000000-10001101-10110111
fcadd   z23.d, p3/m, z23.d, z13.d, #90  // 01100100-11000000-10001101-10110111
// CHECK: fcadd   z23.d, p3/m, z23.d, z13.d, #90 // encoding: [0xb7,0x8d,0xc0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11000000-10001101-10110111
FCADD   Z23.D, P3/M, Z23.D, Z13.D, #90  // 01100100-11000000-10001101-10110111
// CHECK: fcadd   z23.d, p3/m, z23.d, z13.d, #90 // encoding: [0xb7,0x8d,0xc0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11000000-10001101-10110111
fcadd   z31.s, p7/m, z31.s, z31.s, #270  // 01100100-10000001-10011111-11111111
// CHECK: fcadd   z31.s, p7/m, z31.s, z31.s, #270 // encoding: [0xff,0x9f,0x81,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10000001-10011111-11111111
FCADD   Z31.S, P7/M, Z31.S, Z31.S, #270  // 01100100-10000001-10011111-11111111
// CHECK: fcadd   z31.s, p7/m, z31.s, z31.s, #270 // encoding: [0xff,0x9f,0x81,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10000001-10011111-11111111
fcadd   z23.s, p3/m, z23.s, z13.s, #90  // 01100100-10000000-10001101-10110111
// CHECK: fcadd   z23.s, p3/m, z23.s, z13.s, #90 // encoding: [0xb7,0x8d,0x80,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10000000-10001101-10110111
FCADD   Z23.S, P3/M, Z23.S, Z13.S, #90  // 01100100-10000000-10001101-10110111
// CHECK: fcadd   z23.s, p3/m, z23.s, z13.s, #90 // encoding: [0xb7,0x8d,0x80,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10000000-10001101-10110111
fcadd   z21.d, p5/m, z21.d, z10.d, #270  // 01100100-11000001-10010101-01010101
// CHECK: fcadd   z21.d, p5/m, z21.d, z10.d, #270 // encoding: [0x55,0x95,0xc1,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11000001-10010101-01010101
FCADD   Z21.D, P5/M, Z21.D, Z10.D, #270  // 01100100-11000001-10010101-01010101
// CHECK: fcadd   z21.d, p5/m, z21.d, z10.d, #270 // encoding: [0x55,0x95,0xc1,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11000001-10010101-01010101
fcadd   z21.s, p5/m, z21.s, z10.s, #270  // 01100100-10000001-10010101-01010101
// CHECK: fcadd   z21.s, p5/m, z21.s, z10.s, #270 // encoding: [0x55,0x95,0x81,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10000001-10010101-01010101
FCADD   Z21.S, P5/M, Z21.S, Z10.S, #270  // 01100100-10000001-10010101-01010101
// CHECK: fcadd   z21.s, p5/m, z21.s, z10.s, #270 // encoding: [0x55,0x95,0x81,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10000001-10010101-01010101
fcadd   z0.d, p0/m, z0.d, z0.d, #90  // 01100100-11000000-10000000-00000000
// CHECK: fcadd   z0.d, p0/m, z0.d, z0.d, #90 // encoding: [0x00,0x80,0xc0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11000000-10000000-00000000
FCADD   Z0.D, P0/M, Z0.D, Z0.D, #90  // 01100100-11000000-10000000-00000000
// CHECK: fcadd   z0.d, p0/m, z0.d, z0.d, #90 // encoding: [0x00,0x80,0xc0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11000000-10000000-00000000
fcadd   z31.d, p7/m, z31.d, z31.d, #270  // 01100100-11000001-10011111-11111111
// CHECK: fcadd   z31.d, p7/m, z31.d, z31.d, #270 // encoding: [0xff,0x9f,0xc1,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11000001-10011111-11111111
FCADD   Z31.D, P7/M, Z31.D, Z31.D, #270  // 01100100-11000001-10011111-11111111
// CHECK: fcadd   z31.d, p7/m, z31.d, z31.d, #270 // encoding: [0xff,0x9f,0xc1,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11000001-10011111-11111111
fcadd   z0.s, p0/m, z0.s, z0.s, #90  // 01100100-10000000-10000000-00000000
// CHECK: fcadd   z0.s, p0/m, z0.s, z0.s, #90 // encoding: [0x00,0x80,0x80,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10000000-10000000-00000000
FCADD   Z0.S, P0/M, Z0.S, Z0.S, #90  // 01100100-10000000-10000000-00000000
// CHECK: fcadd   z0.s, p0/m, z0.s, z0.s, #90 // encoding: [0x00,0x80,0x80,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10000000-10000000-00000000
