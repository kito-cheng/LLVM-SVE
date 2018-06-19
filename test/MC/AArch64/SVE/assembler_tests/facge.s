// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
facge   p7.s, p3/z, z13.s, z8.s  // 01100101-10001000-11001101-10110111
// CHECK: facge   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0xcd,0x88,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001000-11001101-10110111
FACGE   P7.S, P3/Z, Z13.S, Z8.S  // 01100101-10001000-11001101-10110111
// CHECK: facge   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0xcd,0x88,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001000-11001101-10110111
facge   p7.h, p3/z, z13.h, z8.h  // 01100101-01001000-11001101-10110111
// CHECK: facge   p7.h, p3/z, z13.h, z8.h // encoding: [0xb7,0xcd,0x48,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001000-11001101-10110111
FACGE   P7.H, P3/Z, Z13.H, Z8.H  // 01100101-01001000-11001101-10110111
// CHECK: facge   p7.h, p3/z, z13.h, z8.h // encoding: [0xb7,0xcd,0x48,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001000-11001101-10110111
facge   p0.h, p0/z, z0.h, z0.h  // 01100101-01000000-11000000-00010000
// CHECK: facge   p0.h, p0/z, z0.h, z0.h // encoding: [0x10,0xc0,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-11000000-00010000
FACGE   P0.H, P0/Z, Z0.H, Z0.H  // 01100101-01000000-11000000-00010000
// CHECK: facge   p0.h, p0/z, z0.h, z0.h // encoding: [0x10,0xc0,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-11000000-00010000
facge   p5.h, p5/z, z10.h, z21.h  // 01100101-01010101-11010101-01010101
// CHECK: facge   p5.h, p5/z, z10.h, z21.h // encoding: [0x55,0xd5,0x55,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010101-11010101-01010101
FACGE   P5.H, P5/Z, Z10.H, Z21.H  // 01100101-01010101-11010101-01010101
// CHECK: facge   p5.h, p5/z, z10.h, z21.h // encoding: [0x55,0xd5,0x55,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010101-11010101-01010101
facge   p15.h, p7/z, z31.h, z31.h  // 01100101-01011111-11011111-11111111
// CHECK: facge   p15.h, p7/z, z31.h, z31.h // encoding: [0xff,0xdf,0x5f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011111-11011111-11111111
FACGE   P15.H, P7/Z, Z31.H, Z31.H  // 01100101-01011111-11011111-11111111
// CHECK: facge   p15.h, p7/z, z31.h, z31.h // encoding: [0xff,0xdf,0x5f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011111-11011111-11111111
facge   p5.s, p5/z, z10.s, z21.s  // 01100101-10010101-11010101-01010101
// CHECK: facge   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0xd5,0x95,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010101-11010101-01010101
FACGE   P5.S, P5/Z, Z10.S, Z21.S  // 01100101-10010101-11010101-01010101
// CHECK: facge   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0xd5,0x95,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010101-11010101-01010101
facge   p0.d, p0/z, z0.d, z0.d  // 01100101-11000000-11000000-00010000
// CHECK: facge   p0.d, p0/z, z0.d, z0.d // encoding: [0x10,0xc0,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-11000000-00010000
FACGE   P0.D, P0/Z, Z0.D, Z0.D  // 01100101-11000000-11000000-00010000
// CHECK: facge   p0.d, p0/z, z0.d, z0.d // encoding: [0x10,0xc0,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-11000000-00010000
facge   p15.d, p7/z, z31.d, z31.d  // 01100101-11011111-11011111-11111111
// CHECK: facge   p15.d, p7/z, z31.d, z31.d // encoding: [0xff,0xdf,0xdf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011111-11011111-11111111
FACGE   P15.D, P7/Z, Z31.D, Z31.D  // 01100101-11011111-11011111-11111111
// CHECK: facge   p15.d, p7/z, z31.d, z31.d // encoding: [0xff,0xdf,0xdf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011111-11011111-11111111
facge   p15.s, p7/z, z31.s, z31.s  // 01100101-10011111-11011111-11111111
// CHECK: facge   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0xdf,0x9f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011111-11011111-11111111
FACGE   P15.S, P7/Z, Z31.S, Z31.S  // 01100101-10011111-11011111-11111111
// CHECK: facge   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0xdf,0x9f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011111-11011111-11111111
facge   p0.s, p0/z, z0.s, z0.s  // 01100101-10000000-11000000-00010000
// CHECK: facge   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0xc0,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-11000000-00010000
FACGE   P0.S, P0/Z, Z0.S, Z0.S  // 01100101-10000000-11000000-00010000
// CHECK: facge   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0xc0,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-11000000-00010000
facge   p5.d, p5/z, z10.d, z21.d  // 01100101-11010101-11010101-01010101
// CHECK: facge   p5.d, p5/z, z10.d, z21.d // encoding: [0x55,0xd5,0xd5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010101-11010101-01010101
FACGE   P5.D, P5/Z, Z10.D, Z21.D  // 01100101-11010101-11010101-01010101
// CHECK: facge   p5.d, p5/z, z10.d, z21.d // encoding: [0x55,0xd5,0xd5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010101-11010101-01010101
facge   p7.d, p3/z, z13.d, z8.d  // 01100101-11001000-11001101-10110111
// CHECK: facge   p7.d, p3/z, z13.d, z8.d // encoding: [0xb7,0xcd,0xc8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001000-11001101-10110111
FACGE   P7.D, P3/Z, Z13.D, Z8.D  // 01100101-11001000-11001101-10110111
// CHECK: facge   p7.d, p3/z, z13.d, z8.d // encoding: [0xb7,0xcd,0xc8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001000-11001101-10110111
