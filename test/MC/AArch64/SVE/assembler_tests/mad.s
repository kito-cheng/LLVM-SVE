// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mad     z0.d, p0/m, z0.d, z0.d  // 00000100-11000000-11000000-00000000
// CHECK: mad     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0xc0,0xc0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000000-11000000-00000000
MAD     Z0.D, P0/M, Z0.D, Z0.D  // 00000100-11000000-11000000-00000000
// CHECK: mad     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0xc0,0xc0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000000-11000000-00000000
mad     z23.h, p3/m, z8.h, z13.h  // 00000100-01001000-11001101-10110111
// CHECK: mad     z23.h, p3/m, z8.h, z13.h // encoding: [0xb7,0xcd,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-11001101-10110111
MAD     Z23.H, P3/M, Z8.H, Z13.H  // 00000100-01001000-11001101-10110111
// CHECK: mad     z23.h, p3/m, z8.h, z13.h // encoding: [0xb7,0xcd,0x48,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01001000-11001101-10110111
mad     z21.b, p5/m, z21.b, z10.b  // 00000100-00010101-11010101-01010101
// CHECK: mad     z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0xd5,0x15,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010101-11010101-01010101
MAD     Z21.B, P5/M, Z21.B, Z10.B  // 00000100-00010101-11010101-01010101
// CHECK: mad     z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0xd5,0x15,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010101-11010101-01010101
mad     z31.h, p7/m, z31.h, z31.h  // 00000100-01011111-11011111-11111111
// CHECK: mad     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0xdf,0x5f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011111-11011111-11111111
MAD     Z31.H, P7/M, Z31.H, Z31.H  // 00000100-01011111-11011111-11111111
// CHECK: mad     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0xdf,0x5f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011111-11011111-11111111
mad     z23.d, p3/m, z8.d, z13.d  // 00000100-11001000-11001101-10110111
// CHECK: mad     z23.d, p3/m, z8.d, z13.d // encoding: [0xb7,0xcd,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-11001101-10110111
MAD     Z23.D, P3/M, Z8.D, Z13.D  // 00000100-11001000-11001101-10110111
// CHECK: mad     z23.d, p3/m, z8.d, z13.d // encoding: [0xb7,0xcd,0xc8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11001000-11001101-10110111
mad     z31.d, p7/m, z31.d, z31.d  // 00000100-11011111-11011111-11111111
// CHECK: mad     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0xdf,0xdf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011111-11011111-11111111
MAD     Z31.D, P7/M, Z31.D, Z31.D  // 00000100-11011111-11011111-11111111
// CHECK: mad     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0xdf,0xdf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011111-11011111-11111111
mad     z0.s, p0/m, z0.s, z0.s  // 00000100-10000000-11000000-00000000
// CHECK: mad     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0xc0,0x80,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000000-11000000-00000000
MAD     Z0.S, P0/M, Z0.S, Z0.S  // 00000100-10000000-11000000-00000000
// CHECK: mad     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0xc0,0x80,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000000-11000000-00000000
mad     z23.b, p3/m, z8.b, z13.b  // 00000100-00001000-11001101-10110111
// CHECK: mad     z23.b, p3/m, z8.b, z13.b // encoding: [0xb7,0xcd,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-11001101-10110111
MAD     Z23.B, P3/M, Z8.B, Z13.B  // 00000100-00001000-11001101-10110111
// CHECK: mad     z23.b, p3/m, z8.b, z13.b // encoding: [0xb7,0xcd,0x08,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00001000-11001101-10110111
mad     z0.h, p0/m, z0.h, z0.h  // 00000100-01000000-11000000-00000000
// CHECK: mad     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0xc0,0x40,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000000-11000000-00000000
MAD     Z0.H, P0/M, Z0.H, Z0.H  // 00000100-01000000-11000000-00000000
// CHECK: mad     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0xc0,0x40,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000000-11000000-00000000
mad     z31.b, p7/m, z31.b, z31.b  // 00000100-00011111-11011111-11111111
// CHECK: mad     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0xdf,0x1f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011111-11011111-11111111
MAD     Z31.B, P7/M, Z31.B, Z31.B  // 00000100-00011111-11011111-11111111
// CHECK: mad     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0xdf,0x1f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011111-11011111-11111111
mad     z21.d, p5/m, z21.d, z10.d  // 00000100-11010101-11010101-01010101
// CHECK: mad     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0xd5,0xd5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010101-11010101-01010101
MAD     Z21.D, P5/M, Z21.D, Z10.D  // 00000100-11010101-11010101-01010101
// CHECK: mad     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0xd5,0xd5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010101-11010101-01010101
mad     z21.h, p5/m, z21.h, z10.h  // 00000100-01010101-11010101-01010101
// CHECK: mad     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0xd5,0x55,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010101-11010101-01010101
MAD     Z21.H, P5/M, Z21.H, Z10.H  // 00000100-01010101-11010101-01010101
// CHECK: mad     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0xd5,0x55,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010101-11010101-01010101
mad     z23.s, p3/m, z8.s, z13.s  // 00000100-10001000-11001101-10110111
// CHECK: mad     z23.s, p3/m, z8.s, z13.s // encoding: [0xb7,0xcd,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-11001101-10110111
MAD     Z23.S, P3/M, Z8.S, Z13.S  // 00000100-10001000-11001101-10110111
// CHECK: mad     z23.s, p3/m, z8.s, z13.s // encoding: [0xb7,0xcd,0x88,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10001000-11001101-10110111
mad     z21.s, p5/m, z21.s, z10.s  // 00000100-10010101-11010101-01010101
// CHECK: mad     z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0xd5,0x95,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010101-11010101-01010101
MAD     Z21.S, P5/M, Z21.S, Z10.S  // 00000100-10010101-11010101-01010101
// CHECK: mad     z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0xd5,0x95,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010101-11010101-01010101
mad     z0.b, p0/m, z0.b, z0.b  // 00000100-00000000-11000000-00000000
// CHECK: mad     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0xc0,0x00,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000000-11000000-00000000
MAD     Z0.B, P0/M, Z0.B, Z0.B  // 00000100-00000000-11000000-00000000
// CHECK: mad     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0xc0,0x00,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000000-11000000-00000000
mad     z31.s, p7/m, z31.s, z31.s  // 00000100-10011111-11011111-11111111
// CHECK: mad     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0xdf,0x9f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011111-11011111-11111111
MAD     Z31.S, P7/M, Z31.S, Z31.S  // 00000100-10011111-11011111-11111111
// CHECK: mad     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0xdf,0x9f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011111-11011111-11111111
