// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mla     z21.h, p5/m, z10.h, z21.h  // 00000100-01010101-01010101-01010101
// CHECK: mla     z21.h, p5/m, z10.h, z21.h // encoding: [0x55,0x55,0x55,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010101-01010101-01010101
MLA     Z21.H, P5/M, Z10.H, Z21.H  // 00000100-01010101-01010101-01010101
// CHECK: mla     z21.h, p5/m, z10.h, z21.h // encoding: [0x55,0x55,0x55,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010101-01010101-01010101
mla     z23.b, p3/m, z13.b, z8.b  // 00000100-00001000-01001101-10110111
// CHECK: mla     z23.b, p3/m, z13.b, z8.b // encoding: [0xb7,0x4d,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-01001101-10110111
MLA     Z23.B, P3/M, Z13.B, Z8.B  // 00000100-00001000-01001101-10110111
// CHECK: mla     z23.b, p3/m, z13.b, z8.b // encoding: [0xb7,0x4d,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-01001101-10110111
mla     z23.h, p3/m, z13.h, z8.h  // 00000100-01001000-01001101-10110111
// CHECK: mla     z23.h, p3/m, z13.h, z8.h // encoding: [0xb7,0x4d,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-01001101-10110111
MLA     Z23.H, P3/M, Z13.H, Z8.H  // 00000100-01001000-01001101-10110111
// CHECK: mla     z23.h, p3/m, z13.h, z8.h // encoding: [0xb7,0x4d,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-01001101-10110111
mla     z31.s, p7/m, z31.s, z31.s  // 00000100-10011111-01011111-11111111
// CHECK: mla     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x5f,0x9f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011111-01011111-11111111
MLA     Z31.S, P7/M, Z31.S, Z31.S  // 00000100-10011111-01011111-11111111
// CHECK: mla     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x5f,0x9f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011111-01011111-11111111
mla     z0.b, p0/m, z0.b, z0.b  // 00000100-00000000-01000000-00000000
// CHECK: mla     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x40,0x00,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000000-01000000-00000000
MLA     Z0.B, P0/M, Z0.B, Z0.B  // 00000100-00000000-01000000-00000000
// CHECK: mla     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x40,0x00,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000000-01000000-00000000
mla     z0.h, p0/m, z0.h, z0.h  // 00000100-01000000-01000000-00000000
// CHECK: mla     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x40,0x40,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000000-01000000-00000000
MLA     Z0.H, P0/M, Z0.H, Z0.H  // 00000100-01000000-01000000-00000000
// CHECK: mla     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x40,0x40,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000000-01000000-00000000
mla     z31.d, p7/m, z31.d, z31.d  // 00000100-11011111-01011111-11111111
// CHECK: mla     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x5f,0xdf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011111-01011111-11111111
MLA     Z31.D, P7/M, Z31.D, Z31.D  // 00000100-11011111-01011111-11111111
// CHECK: mla     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x5f,0xdf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011111-01011111-11111111
mla     z21.s, p5/m, z10.s, z21.s  // 00000100-10010101-01010101-01010101
// CHECK: mla     z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0x55,0x95,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010101-01010101-01010101
MLA     Z21.S, P5/M, Z10.S, Z21.S  // 00000100-10010101-01010101-01010101
// CHECK: mla     z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0x55,0x95,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010101-01010101-01010101
mla     z23.s, p3/m, z13.s, z8.s  // 00000100-10001000-01001101-10110111
// CHECK: mla     z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0x4d,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-01001101-10110111
MLA     Z23.S, P3/M, Z13.S, Z8.S  // 00000100-10001000-01001101-10110111
// CHECK: mla     z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0x4d,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-01001101-10110111
mla     z23.d, p3/m, z13.d, z8.d  // 00000100-11001000-01001101-10110111
// CHECK: mla     z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x4d,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-01001101-10110111
MLA     Z23.D, P3/M, Z13.D, Z8.D  // 00000100-11001000-01001101-10110111
// CHECK: mla     z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x4d,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-01001101-10110111
mla     z21.d, p5/m, z10.d, z21.d  // 00000100-11010101-01010101-01010101
// CHECK: mla     z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x55,0xd5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010101-01010101-01010101
MLA     Z21.D, P5/M, Z10.D, Z21.D  // 00000100-11010101-01010101-01010101
// CHECK: mla     z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x55,0xd5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010101-01010101-01010101
mla     z31.b, p7/m, z31.b, z31.b  // 00000100-00011111-01011111-11111111
// CHECK: mla     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x5f,0x1f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011111-01011111-11111111
MLA     Z31.B, P7/M, Z31.B, Z31.B  // 00000100-00011111-01011111-11111111
// CHECK: mla     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x5f,0x1f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011111-01011111-11111111
mla     z21.b, p5/m, z10.b, z21.b  // 00000100-00010101-01010101-01010101
// CHECK: mla     z21.b, p5/m, z10.b, z21.b // encoding: [0x55,0x55,0x15,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010101-01010101-01010101
MLA     Z21.B, P5/M, Z10.B, Z21.B  // 00000100-00010101-01010101-01010101
// CHECK: mla     z21.b, p5/m, z10.b, z21.b // encoding: [0x55,0x55,0x15,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010101-01010101-01010101
mla     z0.s, p0/m, z0.s, z0.s  // 00000100-10000000-01000000-00000000
// CHECK: mla     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x40,0x80,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000000-01000000-00000000
MLA     Z0.S, P0/M, Z0.S, Z0.S  // 00000100-10000000-01000000-00000000
// CHECK: mla     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x40,0x80,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000000-01000000-00000000
mla     z31.h, p7/m, z31.h, z31.h  // 00000100-01011111-01011111-11111111
// CHECK: mla     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x5f,0x5f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011111-01011111-11111111
MLA     Z31.H, P7/M, Z31.H, Z31.H  // 00000100-01011111-01011111-11111111
// CHECK: mla     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x5f,0x5f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011111-01011111-11111111
mla     z0.d, p0/m, z0.d, z0.d  // 00000100-11000000-01000000-00000000
// CHECK: mla     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x40,0xc0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000000-01000000-00000000
MLA     Z0.D, P0/M, Z0.D, Z0.D  // 00000100-11000000-01000000-00000000
// CHECK: mla     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x40,0xc0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000000-01000000-00000000
