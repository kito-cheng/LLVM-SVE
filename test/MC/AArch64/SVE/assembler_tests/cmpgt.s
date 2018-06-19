// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmpgt   p0.d, p0/z, z0.d, z0.d  // 00100100-11000000-10000000-00010000
// CHECK: cmpgt   p0.d, p0/z, z0.d, z0.d // encoding: [0x10,0x80,0xc0,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11000000-10000000-00010000
CMPGT   P0.D, P0/Z, Z0.D, Z0.D  // 00100100-11000000-10000000-00010000
// CHECK: cmpgt   p0.d, p0/z, z0.d, z0.d // encoding: [0x10,0x80,0xc0,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11000000-10000000-00010000
cmpgt   p5.h, p5/z, z10.h, z21.h  // 00100100-01010101-10010101-01010101
// CHECK: cmpgt   p5.h, p5/z, z10.h, z21.h // encoding: [0x55,0x95,0x55,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01010101-10010101-01010101
CMPGT   P5.H, P5/Z, Z10.H, Z21.H  // 00100100-01010101-10010101-01010101
// CHECK: cmpgt   p5.h, p5/z, z10.h, z21.h // encoding: [0x55,0x95,0x55,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01010101-10010101-01010101
cmpgt   p5.b, p5/z, z10.b, z21.d  // 00100100-00010101-01010101-01010101
// CHECK: cmpgt   p5.b, p5/z, z10.b, z21.d // encoding: [0x55,0x55,0x15,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00010101-01010101-01010101
CMPGT   P5.B, P5/Z, Z10.B, Z21.D  // 00100100-00010101-01010101-01010101
// CHECK: cmpgt   p5.b, p5/z, z10.b, z21.d // encoding: [0x55,0x55,0x15,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00010101-01010101-01010101
cmpgt   p0.h, p0/z, z0.h, #0  // 00100101-01000000-00000000-00010000
// CHECK: cmpgt   p0.h, p0/z, z0.h, #0 // encoding: [0x10,0x00,0x40,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000000-00000000-00010000
CMPGT   P0.H, P0/Z, Z0.H, #0  // 00100101-01000000-00000000-00010000
// CHECK: cmpgt   p0.h, p0/z, z0.h, #0 // encoding: [0x10,0x00,0x40,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000000-00000000-00010000
cmpgt   p7.b, p3/z, z13.b, #8  // 00100101-00001000-00001101-10110111
// CHECK: cmpgt   p7.b, p3/z, z13.b, #8 // encoding: [0xb7,0x0d,0x08,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001000-00001101-10110111
CMPGT   P7.B, P3/Z, Z13.B, #8  // 00100101-00001000-00001101-10110111
// CHECK: cmpgt   p7.b, p3/z, z13.b, #8 // encoding: [0xb7,0x0d,0x08,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001000-00001101-10110111
cmpgt   p0.s, p0/z, z0.s, z0.d  // 00100100-10000000-01000000-00010000
// CHECK: cmpgt   p0.s, p0/z, z0.s, z0.d // encoding: [0x10,0x40,0x80,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10000000-01000000-00010000
CMPGT   P0.S, P0/Z, Z0.S, Z0.D  // 00100100-10000000-01000000-00010000
// CHECK: cmpgt   p0.s, p0/z, z0.s, z0.d // encoding: [0x10,0x40,0x80,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10000000-01000000-00010000
cmpgt   p15.h, p7/z, z31.h, #-1  // 00100101-01011111-00011111-11111111
// CHECK: cmpgt   p15.h, p7/z, z31.h, #-1 // encoding: [0xff,0x1f,0x5f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011111-00011111-11111111
CMPGT   P15.H, P7/Z, Z31.H, #-1  // 00100101-01011111-00011111-11111111
// CHECK: cmpgt   p15.h, p7/z, z31.h, #-1 // encoding: [0xff,0x1f,0x5f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011111-00011111-11111111
cmpgt   p0.b, p0/z, z0.b, z0.b  // 00100100-00000000-10000000-00010000
// CHECK: cmpgt   p0.b, p0/z, z0.b, z0.b // encoding: [0x10,0x80,0x00,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00000000-10000000-00010000
CMPGT   P0.B, P0/Z, Z0.B, Z0.B  // 00100100-00000000-10000000-00010000
// CHECK: cmpgt   p0.b, p0/z, z0.b, z0.b // encoding: [0x10,0x80,0x00,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00000000-10000000-00010000
cmpgt   p15.s, p7/z, z31.s, z31.s  // 00100100-10011111-10011111-11111111
// CHECK: cmpgt   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0x9f,0x9f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10011111-10011111-11111111
CMPGT   P15.S, P7/Z, Z31.S, Z31.S  // 00100100-10011111-10011111-11111111
// CHECK: cmpgt   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0x9f,0x9f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10011111-10011111-11111111
cmpgt   p5.b, p5/z, z10.b, #-11  // 00100101-00010101-00010101-01010101
// CHECK: cmpgt   p5.b, p5/z, z10.b, #-11 // encoding: [0x55,0x15,0x15,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00010101-00010101-01010101
CMPGT   P5.B, P5/Z, Z10.B, #-11  // 00100101-00010101-00010101-01010101
// CHECK: cmpgt   p5.b, p5/z, z10.b, #-11 // encoding: [0x55,0x15,0x15,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00010101-00010101-01010101
cmpgt   p0.h, p0/z, z0.h, z0.h  // 00100100-01000000-10000000-00010000
// CHECK: cmpgt   p0.h, p0/z, z0.h, z0.h // encoding: [0x10,0x80,0x40,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01000000-10000000-00010000
CMPGT   P0.H, P0/Z, Z0.H, Z0.H  // 00100100-01000000-10000000-00010000
// CHECK: cmpgt   p0.h, p0/z, z0.h, z0.h // encoding: [0x10,0x80,0x40,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01000000-10000000-00010000
cmpgt   p0.d, p0/z, z0.d, #0  // 00100101-11000000-00000000-00010000
// CHECK: cmpgt   p0.d, p0/z, z0.d, #0 // encoding: [0x10,0x00,0xc0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11000000-00000000-00010000
CMPGT   P0.D, P0/Z, Z0.D, #0  // 00100101-11000000-00000000-00010000
// CHECK: cmpgt   p0.d, p0/z, z0.d, #0 // encoding: [0x10,0x00,0xc0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11000000-00000000-00010000
cmpgt   p15.s, p7/z, z31.s, #-1  // 00100101-10011111-00011111-11111111
// CHECK: cmpgt   p15.s, p7/z, z31.s, #-1 // encoding: [0xff,0x1f,0x9f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011111-00011111-11111111
CMPGT   P15.S, P7/Z, Z31.S, #-1  // 00100101-10011111-00011111-11111111
// CHECK: cmpgt   p15.s, p7/z, z31.s, #-1 // encoding: [0xff,0x1f,0x9f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011111-00011111-11111111
cmpgt   p7.b, p3/z, z13.b, z8.d  // 00100100-00001000-01001101-10110111
// CHECK: cmpgt   p7.b, p3/z, z13.b, z8.d // encoding: [0xb7,0x4d,0x08,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00001000-01001101-10110111
CMPGT   P7.B, P3/Z, Z13.B, Z8.D  // 00100100-00001000-01001101-10110111
// CHECK: cmpgt   p7.b, p3/z, z13.b, z8.d // encoding: [0xb7,0x4d,0x08,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00001000-01001101-10110111
cmpgt   p15.d, p7/z, z31.d, z31.d  // 00100100-11011111-10011111-11111111
// CHECK: cmpgt   p15.d, p7/z, z31.d, z31.d // encoding: [0xff,0x9f,0xdf,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11011111-10011111-11111111
CMPGT   P15.D, P7/Z, Z31.D, Z31.D  // 00100100-11011111-10011111-11111111
// CHECK: cmpgt   p15.d, p7/z, z31.d, z31.d // encoding: [0xff,0x9f,0xdf,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11011111-10011111-11111111
cmpgt   p15.b, p7/z, z31.b, #-1  // 00100101-00011111-00011111-11111111
// CHECK: cmpgt   p15.b, p7/z, z31.b, #-1 // encoding: [0xff,0x1f,0x1f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011111-00011111-11111111
CMPGT   P15.B, P7/Z, Z31.B, #-1  // 00100101-00011111-00011111-11111111
// CHECK: cmpgt   p15.b, p7/z, z31.b, #-1 // encoding: [0xff,0x1f,0x1f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011111-00011111-11111111
cmpgt   p5.d, p5/z, z10.d, z21.d  // 00100100-11010101-10010101-01010101
// CHECK: cmpgt   p5.d, p5/z, z10.d, z21.d // encoding: [0x55,0x95,0xd5,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11010101-10010101-01010101
CMPGT   P5.D, P5/Z, Z10.D, Z21.D  // 00100100-11010101-10010101-01010101
// CHECK: cmpgt   p5.d, p5/z, z10.d, z21.d // encoding: [0x55,0x95,0xd5,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11010101-10010101-01010101
cmpgt   p7.s, p3/z, z13.s, z8.s  // 00100100-10001000-10001101-10110111
// CHECK: cmpgt   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0x8d,0x88,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10001000-10001101-10110111
CMPGT   P7.S, P3/Z, Z13.S, Z8.S  // 00100100-10001000-10001101-10110111
// CHECK: cmpgt   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0x8d,0x88,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10001000-10001101-10110111
cmpgt   p15.h, p7/z, z31.h, z31.d  // 00100100-01011111-01011111-11111111
// CHECK: cmpgt   p15.h, p7/z, z31.h, z31.d // encoding: [0xff,0x5f,0x5f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01011111-01011111-11111111
CMPGT   P15.H, P7/Z, Z31.H, Z31.D  // 00100100-01011111-01011111-11111111
// CHECK: cmpgt   p15.h, p7/z, z31.h, z31.d // encoding: [0xff,0x5f,0x5f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01011111-01011111-11111111
cmpgt   p5.d, p5/z, z10.d, #-11  // 00100101-11010101-00010101-01010101
// CHECK: cmpgt   p5.d, p5/z, z10.d, #-11 // encoding: [0x55,0x15,0xd5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11010101-00010101-01010101
CMPGT   P5.D, P5/Z, Z10.D, #-11  // 00100101-11010101-00010101-01010101
// CHECK: cmpgt   p5.d, p5/z, z10.d, #-11 // encoding: [0x55,0x15,0xd5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11010101-00010101-01010101
cmpgt   p7.h, p3/z, z13.h, z8.h  // 00100100-01001000-10001101-10110111
// CHECK: cmpgt   p7.h, p3/z, z13.h, z8.h // encoding: [0xb7,0x8d,0x48,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01001000-10001101-10110111
CMPGT   P7.H, P3/Z, Z13.H, Z8.H  // 00100100-01001000-10001101-10110111
// CHECK: cmpgt   p7.h, p3/z, z13.h, z8.h // encoding: [0xb7,0x8d,0x48,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01001000-10001101-10110111
cmpgt   p5.h, p5/z, z10.h, #-11  // 00100101-01010101-00010101-01010101
// CHECK: cmpgt   p5.h, p5/z, z10.h, #-11 // encoding: [0x55,0x15,0x55,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01010101-00010101-01010101
CMPGT   P5.H, P5/Z, Z10.H, #-11  // 00100101-01010101-00010101-01010101
// CHECK: cmpgt   p5.h, p5/z, z10.h, #-11 // encoding: [0x55,0x15,0x55,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01010101-00010101-01010101
cmpgt   p0.s, p0/z, z0.s, #0  // 00100101-10000000-00000000-00010000
// CHECK: cmpgt   p0.s, p0/z, z0.s, #0 // encoding: [0x10,0x00,0x80,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000000-00000000-00010000
CMPGT   P0.S, P0/Z, Z0.S, #0  // 00100101-10000000-00000000-00010000
// CHECK: cmpgt   p0.s, p0/z, z0.s, #0 // encoding: [0x10,0x00,0x80,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000000-00000000-00010000
cmpgt   p5.s, p5/z, z10.s, z21.s  // 00100100-10010101-10010101-01010101
// CHECK: cmpgt   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0x95,0x95,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10010101-10010101-01010101
CMPGT   P5.S, P5/Z, Z10.S, Z21.S  // 00100100-10010101-10010101-01010101
// CHECK: cmpgt   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0x95,0x95,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10010101-10010101-01010101
cmpgt   p15.h, p7/z, z31.h, z31.h  // 00100100-01011111-10011111-11111111
// CHECK: cmpgt   p15.h, p7/z, z31.h, z31.h // encoding: [0xff,0x9f,0x5f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01011111-10011111-11111111
CMPGT   P15.H, P7/Z, Z31.H, Z31.H  // 00100100-01011111-10011111-11111111
// CHECK: cmpgt   p15.h, p7/z, z31.h, z31.h // encoding: [0xff,0x9f,0x5f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01011111-10011111-11111111
cmpgt   p15.b, p7/z, z31.b, z31.b  // 00100100-00011111-10011111-11111111
// CHECK: cmpgt   p15.b, p7/z, z31.b, z31.b // encoding: [0xff,0x9f,0x1f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00011111-10011111-11111111
CMPGT   P15.B, P7/Z, Z31.B, Z31.B  // 00100100-00011111-10011111-11111111
// CHECK: cmpgt   p15.b, p7/z, z31.b, z31.b // encoding: [0xff,0x9f,0x1f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00011111-10011111-11111111
cmpgt   p7.h, p3/z, z13.h, #8  // 00100101-01001000-00001101-10110111
// CHECK: cmpgt   p7.h, p3/z, z13.h, #8 // encoding: [0xb7,0x0d,0x48,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001000-00001101-10110111
CMPGT   P7.H, P3/Z, Z13.H, #8  // 00100101-01001000-00001101-10110111
// CHECK: cmpgt   p7.h, p3/z, z13.h, #8 // encoding: [0xb7,0x0d,0x48,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001000-00001101-10110111
cmpgt   p5.s, p5/z, z10.s, z21.d  // 00100100-10010101-01010101-01010101
// CHECK: cmpgt   p5.s, p5/z, z10.s, z21.d // encoding: [0x55,0x55,0x95,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10010101-01010101-01010101
CMPGT   P5.S, P5/Z, Z10.S, Z21.D  // 00100100-10010101-01010101-01010101
// CHECK: cmpgt   p5.s, p5/z, z10.s, z21.d // encoding: [0x55,0x55,0x95,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10010101-01010101-01010101
cmpgt   p0.h, p0/z, z0.h, z0.d  // 00100100-01000000-01000000-00010000
// CHECK: cmpgt   p0.h, p0/z, z0.h, z0.d // encoding: [0x10,0x40,0x40,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01000000-01000000-00010000
CMPGT   P0.H, P0/Z, Z0.H, Z0.D  // 00100100-01000000-01000000-00010000
// CHECK: cmpgt   p0.h, p0/z, z0.h, z0.d // encoding: [0x10,0x40,0x40,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01000000-01000000-00010000
cmpgt   p5.s, p5/z, z10.s, #-11  // 00100101-10010101-00010101-01010101
// CHECK: cmpgt   p5.s, p5/z, z10.s, #-11 // encoding: [0x55,0x15,0x95,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10010101-00010101-01010101
CMPGT   P5.S, P5/Z, Z10.S, #-11  // 00100101-10010101-00010101-01010101
// CHECK: cmpgt   p5.s, p5/z, z10.s, #-11 // encoding: [0x55,0x15,0x95,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10010101-00010101-01010101
cmpgt   p5.b, p5/z, z10.b, z21.b  // 00100100-00010101-10010101-01010101
// CHECK: cmpgt   p5.b, p5/z, z10.b, z21.b // encoding: [0x55,0x95,0x15,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00010101-10010101-01010101
CMPGT   P5.B, P5/Z, Z10.B, Z21.B  // 00100100-00010101-10010101-01010101
// CHECK: cmpgt   p5.b, p5/z, z10.b, z21.b // encoding: [0x55,0x95,0x15,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00010101-10010101-01010101
cmpgt   p7.s, p3/z, z13.s, #8  // 00100101-10001000-00001101-10110111
// CHECK: cmpgt   p7.s, p3/z, z13.s, #8 // encoding: [0xb7,0x0d,0x88,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001000-00001101-10110111
CMPGT   P7.S, P3/Z, Z13.S, #8  // 00100101-10001000-00001101-10110111
// CHECK: cmpgt   p7.s, p3/z, z13.s, #8 // encoding: [0xb7,0x0d,0x88,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001000-00001101-10110111
cmpgt   p15.b, p7/z, z31.b, z31.d  // 00100100-00011111-01011111-11111111
// CHECK: cmpgt   p15.b, p7/z, z31.b, z31.d // encoding: [0xff,0x5f,0x1f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00011111-01011111-11111111
CMPGT   P15.B, P7/Z, Z31.B, Z31.D  // 00100100-00011111-01011111-11111111
// CHECK: cmpgt   p15.b, p7/z, z31.b, z31.d // encoding: [0xff,0x5f,0x1f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00011111-01011111-11111111
cmpgt   p7.d, p3/z, z13.d, z8.d  // 00100100-11001000-10001101-10110111
// CHECK: cmpgt   p7.d, p3/z, z13.d, z8.d // encoding: [0xb7,0x8d,0xc8,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11001000-10001101-10110111
CMPGT   P7.D, P3/Z, Z13.D, Z8.D  // 00100100-11001000-10001101-10110111
// CHECK: cmpgt   p7.d, p3/z, z13.d, z8.d // encoding: [0xb7,0x8d,0xc8,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-11001000-10001101-10110111
cmpgt   p15.s, p7/z, z31.s, z31.d  // 00100100-10011111-01011111-11111111
// CHECK: cmpgt   p15.s, p7/z, z31.s, z31.d // encoding: [0xff,0x5f,0x9f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10011111-01011111-11111111
CMPGT   P15.S, P7/Z, Z31.S, Z31.D  // 00100100-10011111-01011111-11111111
// CHECK: cmpgt   p15.s, p7/z, z31.s, z31.d // encoding: [0xff,0x5f,0x9f,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10011111-01011111-11111111
cmpgt   p15.d, p7/z, z31.d, #-1  // 00100101-11011111-00011111-11111111
// CHECK: cmpgt   p15.d, p7/z, z31.d, #-1 // encoding: [0xff,0x1f,0xdf,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011111-00011111-11111111
CMPGT   P15.D, P7/Z, Z31.D, #-1  // 00100101-11011111-00011111-11111111
// CHECK: cmpgt   p15.d, p7/z, z31.d, #-1 // encoding: [0xff,0x1f,0xdf,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011111-00011111-11111111
cmpgt   p7.s, p3/z, z13.s, z8.d  // 00100100-10001000-01001101-10110111
// CHECK: cmpgt   p7.s, p3/z, z13.s, z8.d // encoding: [0xb7,0x4d,0x88,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10001000-01001101-10110111
CMPGT   P7.S, P3/Z, Z13.S, Z8.D  // 00100100-10001000-01001101-10110111
// CHECK: cmpgt   p7.s, p3/z, z13.s, z8.d // encoding: [0xb7,0x4d,0x88,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10001000-01001101-10110111
cmpgt   p7.b, p3/z, z13.b, z8.b  // 00100100-00001000-10001101-10110111
// CHECK: cmpgt   p7.b, p3/z, z13.b, z8.b // encoding: [0xb7,0x8d,0x08,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00001000-10001101-10110111
CMPGT   P7.B, P3/Z, Z13.B, Z8.B  // 00100100-00001000-10001101-10110111
// CHECK: cmpgt   p7.b, p3/z, z13.b, z8.b // encoding: [0xb7,0x8d,0x08,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00001000-10001101-10110111
cmpgt   p0.s, p0/z, z0.s, z0.s  // 00100100-10000000-10000000-00010000
// CHECK: cmpgt   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0x80,0x80,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10000000-10000000-00010000
CMPGT   P0.S, P0/Z, Z0.S, Z0.S  // 00100100-10000000-10000000-00010000
// CHECK: cmpgt   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0x80,0x80,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-10000000-10000000-00010000
cmpgt   p7.d, p3/z, z13.d, #8  // 00100101-11001000-00001101-10110111
// CHECK: cmpgt   p7.d, p3/z, z13.d, #8 // encoding: [0xb7,0x0d,0xc8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11001000-00001101-10110111
CMPGT   P7.D, P3/Z, Z13.D, #8  // 00100101-11001000-00001101-10110111
// CHECK: cmpgt   p7.d, p3/z, z13.d, #8 // encoding: [0xb7,0x0d,0xc8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11001000-00001101-10110111
cmpgt   p5.h, p5/z, z10.h, z21.d  // 00100100-01010101-01010101-01010101
// CHECK: cmpgt   p5.h, p5/z, z10.h, z21.d // encoding: [0x55,0x55,0x55,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01010101-01010101-01010101
CMPGT   P5.H, P5/Z, Z10.H, Z21.D  // 00100100-01010101-01010101-01010101
// CHECK: cmpgt   p5.h, p5/z, z10.h, z21.d // encoding: [0x55,0x55,0x55,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01010101-01010101-01010101
cmpgt   p7.h, p3/z, z13.h, z8.d  // 00100100-01001000-01001101-10110111
// CHECK: cmpgt   p7.h, p3/z, z13.h, z8.d // encoding: [0xb7,0x4d,0x48,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01001000-01001101-10110111
CMPGT   P7.H, P3/Z, Z13.H, Z8.D  // 00100100-01001000-01001101-10110111
// CHECK: cmpgt   p7.h, p3/z, z13.h, z8.d // encoding: [0xb7,0x4d,0x48,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-01001000-01001101-10110111
cmpgt   p0.b, p0/z, z0.b, #0  // 00100101-00000000-00000000-00010000
// CHECK: cmpgt   p0.b, p0/z, z0.b, #0 // encoding: [0x10,0x00,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-00000000-00010000
CMPGT   P0.B, P0/Z, Z0.B, #0  // 00100101-00000000-00000000-00010000
// CHECK: cmpgt   p0.b, p0/z, z0.b, #0 // encoding: [0x10,0x00,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-00000000-00010000
cmpgt   p0.b, p0/z, z0.b, z0.d  // 00100100-00000000-01000000-00010000
// CHECK: cmpgt   p0.b, p0/z, z0.b, z0.d // encoding: [0x10,0x40,0x00,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00000000-01000000-00010000
CMPGT   P0.B, P0/Z, Z0.B, Z0.D  // 00100100-00000000-01000000-00010000
// CHECK: cmpgt   p0.b, p0/z, z0.b, z0.d // encoding: [0x10,0x40,0x00,0x24]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100100-00000000-01000000-00010000
