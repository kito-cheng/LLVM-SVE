// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmphs   p15.h, p7/z, z31.h, z31.h  // 00100100-01011111-00011111-11101111
// CHECK: cmphs   p15.h, p7/z, z31.h, z31.h // encoding: [0xef,0x1f,0x5f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01011111-00011111-11101111
CMPHS   P15.H, P7/Z, Z31.H, Z31.H  // 00100100-01011111-00011111-11101111
// CHECK: cmphs   p15.h, p7/z, z31.h, z31.h // encoding: [0xef,0x1f,0x5f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01011111-00011111-11101111
cmphs   p7.s, p3/z, z13.s, z8.s  // 00100100-10001000-00001101-10100111
// CHECK: cmphs   p7.s, p3/z, z13.s, z8.s // encoding: [0xa7,0x0d,0x88,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10001000-00001101-10100111
CMPHS   P7.S, P3/Z, Z13.S, Z8.S  // 00100100-10001000-00001101-10100111
// CHECK: cmphs   p7.s, p3/z, z13.s, z8.s // encoding: [0xa7,0x0d,0x88,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10001000-00001101-10100111
cmphs   p7.h, p3/z, z13.h, #35  // 00100100-01101000-11001101-10100111
// CHECK: cmphs   p7.h, p3/z, z13.h, #35 // encoding: [0xa7,0xcd,0x68,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01101000-11001101-10100111
CMPHS   P7.H, P3/Z, Z13.H, #35  // 00100100-01101000-11001101-10100111
// CHECK: cmphs   p7.h, p3/z, z13.h, #35 // encoding: [0xa7,0xcd,0x68,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01101000-11001101-10100111
cmphs   p0.h, p0/z, z0.h, z0.d  // 00100100-01000000-11000000-00000000
// CHECK: cmphs   p0.h, p0/z, z0.h, z0.d // encoding: [0x00,0xc0,0x40,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01000000-11000000-00000000
CMPHS   P0.H, P0/Z, Z0.H, Z0.D  // 00100100-01000000-11000000-00000000
// CHECK: cmphs   p0.h, p0/z, z0.h, z0.d // encoding: [0x00,0xc0,0x40,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01000000-11000000-00000000
cmphs   p7.b, p3/z, z13.b, z8.b  // 00100100-00001000-00001101-10100111
// CHECK: cmphs   p7.b, p3/z, z13.b, z8.b // encoding: [0xa7,0x0d,0x08,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00001000-00001101-10100111
CMPHS   P7.B, P3/Z, Z13.B, Z8.B  // 00100100-00001000-00001101-10100111
// CHECK: cmphs   p7.b, p3/z, z13.b, z8.b // encoding: [0xa7,0x0d,0x08,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00001000-00001101-10100111
cmphs   p0.d, p0/z, z0.d, #0  // 00100100-11100000-00000000-00000000
// CHECK: cmphs   p0.d, p0/z, z0.d, #0 // encoding: [0x00,0x00,0xe0,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11100000-00000000-00000000
CMPHS   P0.D, P0/Z, Z0.D, #0  // 00100100-11100000-00000000-00000000
// CHECK: cmphs   p0.d, p0/z, z0.d, #0 // encoding: [0x00,0x00,0xe0,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11100000-00000000-00000000
cmphs   p15.h, p7/z, z31.h, z31.d  // 00100100-01011111-11011111-11101111
// CHECK: cmphs   p15.h, p7/z, z31.h, z31.d // encoding: [0xef,0xdf,0x5f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01011111-11011111-11101111
CMPHS   P15.H, P7/Z, Z31.H, Z31.D  // 00100100-01011111-11011111-11101111
// CHECK: cmphs   p15.h, p7/z, z31.h, z31.d // encoding: [0xef,0xdf,0x5f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01011111-11011111-11101111
cmphs   p15.b, p7/z, z31.b, z31.b  // 00100100-00011111-00011111-11101111
// CHECK: cmphs   p15.b, p7/z, z31.b, z31.b // encoding: [0xef,0x1f,0x1f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00011111-00011111-11101111
CMPHS   P15.B, P7/Z, Z31.B, Z31.B  // 00100100-00011111-00011111-11101111
// CHECK: cmphs   p15.b, p7/z, z31.b, z31.b // encoding: [0xef,0x1f,0x1f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00011111-00011111-11101111
cmphs   p7.s, p3/z, z13.s, z8.d  // 00100100-10001000-11001101-10100111
// CHECK: cmphs   p7.s, p3/z, z13.s, z8.d // encoding: [0xa7,0xcd,0x88,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10001000-11001101-10100111
CMPHS   P7.S, P3/Z, Z13.S, Z8.D  // 00100100-10001000-11001101-10100111
// CHECK: cmphs   p7.s, p3/z, z13.s, z8.d // encoding: [0xa7,0xcd,0x88,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10001000-11001101-10100111
cmphs   p5.s, p5/z, z10.s, #85  // 00100100-10110101-01010101-01000101
// CHECK: cmphs   p5.s, p5/z, z10.s, #85 // encoding: [0x45,0x55,0xb5,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10110101-01010101-01000101
CMPHS   P5.S, P5/Z, Z10.S, #85  // 00100100-10110101-01010101-01000101
// CHECK: cmphs   p5.s, p5/z, z10.s, #85 // encoding: [0x45,0x55,0xb5,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10110101-01010101-01000101
cmphs   p5.b, p5/z, z10.b, z21.d  // 00100100-00010101-11010101-01000101
// CHECK: cmphs   p5.b, p5/z, z10.b, z21.d // encoding: [0x45,0xd5,0x15,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00010101-11010101-01000101
CMPHS   P5.B, P5/Z, Z10.B, Z21.D  // 00100100-00010101-11010101-01000101
// CHECK: cmphs   p5.b, p5/z, z10.b, z21.d // encoding: [0x45,0xd5,0x15,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00010101-11010101-01000101
cmphs   p0.s, p0/z, z0.s, z0.s  // 00100100-10000000-00000000-00000000
// CHECK: cmphs   p0.s, p0/z, z0.s, z0.s // encoding: [0x00,0x00,0x80,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10000000-00000000-00000000
CMPHS   P0.S, P0/Z, Z0.S, Z0.S  // 00100100-10000000-00000000-00000000
// CHECK: cmphs   p0.s, p0/z, z0.s, z0.s // encoding: [0x00,0x00,0x80,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10000000-00000000-00000000
cmphs   p7.b, p3/z, z13.b, z8.d  // 00100100-00001000-11001101-10100111
// CHECK: cmphs   p7.b, p3/z, z13.b, z8.d // encoding: [0xa7,0xcd,0x08,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00001000-11001101-10100111
CMPHS   P7.B, P3/Z, Z13.B, Z8.D  // 00100100-00001000-11001101-10100111
// CHECK: cmphs   p7.b, p3/z, z13.b, z8.d // encoding: [0xa7,0xcd,0x08,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00001000-11001101-10100111
cmphs   p5.h, p5/z, z10.h, z21.d  // 00100100-01010101-11010101-01000101
// CHECK: cmphs   p5.h, p5/z, z10.h, z21.d // encoding: [0x45,0xd5,0x55,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01010101-11010101-01000101
CMPHS   P5.H, P5/Z, Z10.H, Z21.D  // 00100100-01010101-11010101-01000101
// CHECK: cmphs   p5.h, p5/z, z10.h, z21.d // encoding: [0x45,0xd5,0x55,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01010101-11010101-01000101
cmphs   p15.s, p7/z, z31.s, z31.d  // 00100100-10011111-11011111-11101111
// CHECK: cmphs   p15.s, p7/z, z31.s, z31.d // encoding: [0xef,0xdf,0x9f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10011111-11011111-11101111
CMPHS   P15.S, P7/Z, Z31.S, Z31.D  // 00100100-10011111-11011111-11101111
// CHECK: cmphs   p15.s, p7/z, z31.s, z31.d // encoding: [0xef,0xdf,0x9f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10011111-11011111-11101111
cmphs   p0.s, p0/z, z0.s, #0  // 00100100-10100000-00000000-00000000
// CHECK: cmphs   p0.s, p0/z, z0.s, #0 // encoding: [0x00,0x00,0xa0,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10100000-00000000-00000000
CMPHS   P0.S, P0/Z, Z0.S, #0  // 00100100-10100000-00000000-00000000
// CHECK: cmphs   p0.s, p0/z, z0.s, #0 // encoding: [0x00,0x00,0xa0,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10100000-00000000-00000000
cmphs   p5.b, p5/z, z10.b, z21.b  // 00100100-00010101-00010101-01000101
// CHECK: cmphs   p5.b, p5/z, z10.b, z21.b // encoding: [0x45,0x15,0x15,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00010101-00010101-01000101
CMPHS   P5.B, P5/Z, Z10.B, Z21.B  // 00100100-00010101-00010101-01000101
// CHECK: cmphs   p5.b, p5/z, z10.b, z21.b // encoding: [0x45,0x15,0x15,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00010101-00010101-01000101
cmphs   p5.s, p5/z, z10.s, z21.s  // 00100100-10010101-00010101-01000101
// CHECK: cmphs   p5.s, p5/z, z10.s, z21.s // encoding: [0x45,0x15,0x95,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10010101-00010101-01000101
CMPHS   P5.S, P5/Z, Z10.S, Z21.S  // 00100100-10010101-00010101-01000101
// CHECK: cmphs   p5.s, p5/z, z10.s, z21.s // encoding: [0x45,0x15,0x95,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10010101-00010101-01000101
cmphs   p15.s, p7/z, z31.s, z31.s  // 00100100-10011111-00011111-11101111
// CHECK: cmphs   p15.s, p7/z, z31.s, z31.s // encoding: [0xef,0x1f,0x9f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10011111-00011111-11101111
CMPHS   P15.S, P7/Z, Z31.S, Z31.S  // 00100100-10011111-00011111-11101111
// CHECK: cmphs   p15.s, p7/z, z31.s, z31.s // encoding: [0xef,0x1f,0x9f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10011111-00011111-11101111
cmphs   p15.s, p7/z, z31.s, #127  // 00100100-10111111-11011111-11101111
// CHECK: cmphs   p15.s, p7/z, z31.s, #127 // encoding: [0xef,0xdf,0xbf,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10111111-11011111-11101111
CMPHS   P15.S, P7/Z, Z31.S, #127  // 00100100-10111111-11011111-11101111
// CHECK: cmphs   p15.s, p7/z, z31.s, #127 // encoding: [0xef,0xdf,0xbf,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10111111-11011111-11101111
cmphs   p0.b, p0/z, z0.b, z0.d  // 00100100-00000000-11000000-00000000
// CHECK: cmphs   p0.b, p0/z, z0.b, z0.d // encoding: [0x00,0xc0,0x00,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00000000-11000000-00000000
CMPHS   P0.B, P0/Z, Z0.B, Z0.D  // 00100100-00000000-11000000-00000000
// CHECK: cmphs   p0.b, p0/z, z0.b, z0.d // encoding: [0x00,0xc0,0x00,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00000000-11000000-00000000
cmphs   p15.d, p7/z, z31.d, z31.d  // 00100100-11011111-00011111-11101111
// CHECK: cmphs   p15.d, p7/z, z31.d, z31.d // encoding: [0xef,0x1f,0xdf,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11011111-00011111-11101111
CMPHS   P15.D, P7/Z, Z31.D, Z31.D  // 00100100-11011111-00011111-11101111
// CHECK: cmphs   p15.d, p7/z, z31.d, z31.d // encoding: [0xef,0x1f,0xdf,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11011111-00011111-11101111
cmphs   p5.d, p5/z, z10.d, z21.d  // 00100100-11010101-00010101-01000101
// CHECK: cmphs   p5.d, p5/z, z10.d, z21.d // encoding: [0x45,0x15,0xd5,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11010101-00010101-01000101
CMPHS   P5.D, P5/Z, Z10.D, Z21.D  // 00100100-11010101-00010101-01000101
// CHECK: cmphs   p5.d, p5/z, z10.d, z21.d // encoding: [0x45,0x15,0xd5,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11010101-00010101-01000101
cmphs   p15.b, p7/z, z31.b, z31.d  // 00100100-00011111-11011111-11101111
// CHECK: cmphs   p15.b, p7/z, z31.b, z31.d // encoding: [0xef,0xdf,0x1f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00011111-11011111-11101111
CMPHS   P15.B, P7/Z, Z31.B, Z31.D  // 00100100-00011111-11011111-11101111
// CHECK: cmphs   p15.b, p7/z, z31.b, z31.d // encoding: [0xef,0xdf,0x1f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00011111-11011111-11101111
cmphs   p7.d, p3/z, z13.d, #35  // 00100100-11101000-11001101-10100111
// CHECK: cmphs   p7.d, p3/z, z13.d, #35 // encoding: [0xa7,0xcd,0xe8,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11101000-11001101-10100111
CMPHS   P7.D, P3/Z, Z13.D, #35  // 00100100-11101000-11001101-10100111
// CHECK: cmphs   p7.d, p3/z, z13.d, #35 // encoding: [0xa7,0xcd,0xe8,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11101000-11001101-10100111
cmphs   p5.s, p5/z, z10.s, z21.d  // 00100100-10010101-11010101-01000101
// CHECK: cmphs   p5.s, p5/z, z10.s, z21.d // encoding: [0x45,0xd5,0x95,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10010101-11010101-01000101
CMPHS   P5.S, P5/Z, Z10.S, Z21.D  // 00100100-10010101-11010101-01000101
// CHECK: cmphs   p5.s, p5/z, z10.s, z21.d // encoding: [0x45,0xd5,0x95,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10010101-11010101-01000101
cmphs   p5.d, p5/z, z10.d, #85  // 00100100-11110101-01010101-01000101
// CHECK: cmphs   p5.d, p5/z, z10.d, #85 // encoding: [0x45,0x55,0xf5,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11110101-01010101-01000101
CMPHS   P5.D, P5/Z, Z10.D, #85  // 00100100-11110101-01010101-01000101
// CHECK: cmphs   p5.d, p5/z, z10.d, #85 // encoding: [0x45,0x55,0xf5,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11110101-01010101-01000101
cmphs   p5.b, p5/z, z10.b, #85  // 00100100-00110101-01010101-01000101
// CHECK: cmphs   p5.b, p5/z, z10.b, #85 // encoding: [0x45,0x55,0x35,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00110101-01010101-01000101
CMPHS   P5.B, P5/Z, Z10.B, #85  // 00100100-00110101-01010101-01000101
// CHECK: cmphs   p5.b, p5/z, z10.b, #85 // encoding: [0x45,0x55,0x35,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00110101-01010101-01000101
cmphs   p0.d, p0/z, z0.d, z0.d  // 00100100-11000000-00000000-00000000
// CHECK: cmphs   p0.d, p0/z, z0.d, z0.d // encoding: [0x00,0x00,0xc0,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11000000-00000000-00000000
CMPHS   P0.D, P0/Z, Z0.D, Z0.D  // 00100100-11000000-00000000-00000000
// CHECK: cmphs   p0.d, p0/z, z0.d, z0.d // encoding: [0x00,0x00,0xc0,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11000000-00000000-00000000
cmphs   p5.h, p5/z, z10.h, #85  // 00100100-01110101-01010101-01000101
// CHECK: cmphs   p5.h, p5/z, z10.h, #85 // encoding: [0x45,0x55,0x75,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01110101-01010101-01000101
CMPHS   P5.H, P5/Z, Z10.H, #85  // 00100100-01110101-01010101-01000101
// CHECK: cmphs   p5.h, p5/z, z10.h, #85 // encoding: [0x45,0x55,0x75,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01110101-01010101-01000101
cmphs   p15.h, p7/z, z31.h, #127  // 00100100-01111111-11011111-11101111
// CHECK: cmphs   p15.h, p7/z, z31.h, #127 // encoding: [0xef,0xdf,0x7f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01111111-11011111-11101111
CMPHS   P15.H, P7/Z, Z31.H, #127  // 00100100-01111111-11011111-11101111
// CHECK: cmphs   p15.h, p7/z, z31.h, #127 // encoding: [0xef,0xdf,0x7f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01111111-11011111-11101111
cmphs   p0.h, p0/z, z0.h, z0.h  // 00100100-01000000-00000000-00000000
// CHECK: cmphs   p0.h, p0/z, z0.h, z0.h // encoding: [0x00,0x00,0x40,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01000000-00000000-00000000
CMPHS   P0.H, P0/Z, Z0.H, Z0.H  // 00100100-01000000-00000000-00000000
// CHECK: cmphs   p0.h, p0/z, z0.h, z0.h // encoding: [0x00,0x00,0x40,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01000000-00000000-00000000
cmphs   p7.h, p3/z, z13.h, z8.h  // 00100100-01001000-00001101-10100111
// CHECK: cmphs   p7.h, p3/z, z13.h, z8.h // encoding: [0xa7,0x0d,0x48,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01001000-00001101-10100111
CMPHS   P7.H, P3/Z, Z13.H, Z8.H  // 00100100-01001000-00001101-10100111
// CHECK: cmphs   p7.h, p3/z, z13.h, z8.h // encoding: [0xa7,0x0d,0x48,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01001000-00001101-10100111
cmphs   p7.s, p3/z, z13.s, #35  // 00100100-10101000-11001101-10100111
// CHECK: cmphs   p7.s, p3/z, z13.s, #35 // encoding: [0xa7,0xcd,0xa8,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10101000-11001101-10100111
CMPHS   P7.S, P3/Z, Z13.S, #35  // 00100100-10101000-11001101-10100111
// CHECK: cmphs   p7.s, p3/z, z13.s, #35 // encoding: [0xa7,0xcd,0xa8,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10101000-11001101-10100111
cmphs   p0.b, p0/z, z0.b, #0  // 00100100-00100000-00000000-00000000
// CHECK: cmphs   p0.b, p0/z, z0.b, #0 // encoding: [0x00,0x00,0x20,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00100000-00000000-00000000
CMPHS   P0.B, P0/Z, Z0.B, #0  // 00100100-00100000-00000000-00000000
// CHECK: cmphs   p0.b, p0/z, z0.b, #0 // encoding: [0x00,0x00,0x20,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00100000-00000000-00000000
cmphs   p7.h, p3/z, z13.h, z8.d  // 00100100-01001000-11001101-10100111
// CHECK: cmphs   p7.h, p3/z, z13.h, z8.d // encoding: [0xa7,0xcd,0x48,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01001000-11001101-10100111
CMPHS   P7.H, P3/Z, Z13.H, Z8.D  // 00100100-01001000-11001101-10100111
// CHECK: cmphs   p7.h, p3/z, z13.h, z8.d // encoding: [0xa7,0xcd,0x48,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01001000-11001101-10100111
cmphs   p0.s, p0/z, z0.s, z0.d  // 00100100-10000000-11000000-00000000
// CHECK: cmphs   p0.s, p0/z, z0.s, z0.d // encoding: [0x00,0xc0,0x80,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10000000-11000000-00000000
CMPHS   P0.S, P0/Z, Z0.S, Z0.D  // 00100100-10000000-11000000-00000000
// CHECK: cmphs   p0.s, p0/z, z0.s, z0.d // encoding: [0x00,0xc0,0x80,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10000000-11000000-00000000
cmphs   p0.b, p0/z, z0.b, z0.b  // 00100100-00000000-00000000-00000000
// CHECK: cmphs   p0.b, p0/z, z0.b, z0.b // encoding: [0x00,0x00,0x00,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00000000-00000000-00000000
CMPHS   P0.B, P0/Z, Z0.B, Z0.B  // 00100100-00000000-00000000-00000000
// CHECK: cmphs   p0.b, p0/z, z0.b, z0.b // encoding: [0x00,0x00,0x00,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00000000-00000000-00000000
cmphs   p0.h, p0/z, z0.h, #0  // 00100100-01100000-00000000-00000000
// CHECK: cmphs   p0.h, p0/z, z0.h, #0 // encoding: [0x00,0x00,0x60,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01100000-00000000-00000000
CMPHS   P0.H, P0/Z, Z0.H, #0  // 00100100-01100000-00000000-00000000
// CHECK: cmphs   p0.h, p0/z, z0.h, #0 // encoding: [0x00,0x00,0x60,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01100000-00000000-00000000
cmphs   p5.h, p5/z, z10.h, z21.h  // 00100100-01010101-00010101-01000101
// CHECK: cmphs   p5.h, p5/z, z10.h, z21.h // encoding: [0x45,0x15,0x55,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01010101-00010101-01000101
CMPHS   P5.H, P5/Z, Z10.H, Z21.H  // 00100100-01010101-00010101-01000101
// CHECK: cmphs   p5.h, p5/z, z10.h, z21.h // encoding: [0x45,0x15,0x55,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01010101-00010101-01000101
cmphs   p15.d, p7/z, z31.d, #127  // 00100100-11111111-11011111-11101111
// CHECK: cmphs   p15.d, p7/z, z31.d, #127 // encoding: [0xef,0xdf,0xff,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11111111-11011111-11101111
CMPHS   P15.D, P7/Z, Z31.D, #127  // 00100100-11111111-11011111-11101111
// CHECK: cmphs   p15.d, p7/z, z31.d, #127 // encoding: [0xef,0xdf,0xff,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11111111-11011111-11101111
cmphs   p7.b, p3/z, z13.b, #35  // 00100100-00101000-11001101-10100111
// CHECK: cmphs   p7.b, p3/z, z13.b, #35 // encoding: [0xa7,0xcd,0x28,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00101000-11001101-10100111
CMPHS   P7.B, P3/Z, Z13.B, #35  // 00100100-00101000-11001101-10100111
// CHECK: cmphs   p7.b, p3/z, z13.b, #35 // encoding: [0xa7,0xcd,0x28,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00101000-11001101-10100111
cmphs   p15.b, p7/z, z31.b, #127  // 00100100-00111111-11011111-11101111
// CHECK: cmphs   p15.b, p7/z, z31.b, #127 // encoding: [0xef,0xdf,0x3f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00111111-11011111-11101111
CMPHS   P15.B, P7/Z, Z31.B, #127  // 00100100-00111111-11011111-11101111
// CHECK: cmphs   p15.b, p7/z, z31.b, #127 // encoding: [0xef,0xdf,0x3f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00111111-11011111-11101111
cmphs   p7.d, p3/z, z13.d, z8.d  // 00100100-11001000-00001101-10100111
// CHECK: cmphs   p7.d, p3/z, z13.d, z8.d // encoding: [0xa7,0x0d,0xc8,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11001000-00001101-10100111
CMPHS   P7.D, P3/Z, Z13.D, Z8.D  // 00100100-11001000-00001101-10100111
// CHECK: cmphs   p7.d, p3/z, z13.d, z8.d // encoding: [0xa7,0x0d,0xc8,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11001000-00001101-10100111
