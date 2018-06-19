// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
udot    z23.s, z13.b, z0.b[1]  // 01000100-10101000-00000101-10110111
// CHECK: udot    z23.s, z13.b, z0.b[1] // encoding: [0xb7,0x05,0xa8,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10101000-00000101-10110111
UDOT    Z23.S, Z13.B, Z0.B[1]  // 01000100-10101000-00000101-10110111
// CHECK: udot    z23.s, z13.b, z0.b[1] // encoding: [0xb7,0x05,0xa8,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10101000-00000101-10110111
udot    z23.d, z13.h, z8.h  // 01000100-11001000-00000101-10110111
// CHECK: udot    z23.d, z13.h, z8.h // encoding: [0xb7,0x05,0xc8,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11001000-00000101-10110111
UDOT    Z23.D, Z13.H, Z8.H  // 01000100-11001000-00000101-10110111
// CHECK: udot    z23.d, z13.h, z8.h // encoding: [0xb7,0x05,0xc8,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11001000-00000101-10110111
udot    z21.s, z10.b, z21.b  // 01000100-10010101-00000101-01010101
// CHECK: udot    z21.s, z10.b, z21.b // encoding: [0x55,0x05,0x95,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10010101-00000101-01010101
UDOT    Z21.S, Z10.B, Z21.B  // 01000100-10010101-00000101-01010101
// CHECK: udot    z21.s, z10.b, z21.b // encoding: [0x55,0x05,0x95,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10010101-00000101-01010101
udot    z31.d, z31.h, z15.h[1]  // 01000100-11111111-00000111-11111111
// CHECK: udot    z31.d, z31.h, z15.h[1] // encoding: [0xff,0x07,0xff,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11111111-00000111-11111111
UDOT    Z31.D, Z31.H, Z15.H[1]  // 01000100-11111111-00000111-11111111
// CHECK: udot    z31.d, z31.h, z15.h[1] // encoding: [0xff,0x07,0xff,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11111111-00000111-11111111
udot    z31.d, z31.h, z31.h  // 01000100-11011111-00000111-11111111
// CHECK: udot    z31.d, z31.h, z31.h // encoding: [0xff,0x07,0xdf,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11011111-00000111-11111111
UDOT    Z31.D, Z31.H, Z31.H  // 01000100-11011111-00000111-11111111
// CHECK: udot    z31.d, z31.h, z31.h // encoding: [0xff,0x07,0xdf,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11011111-00000111-11111111
udot    z0.d, z0.h, z0.h[0]  // 01000100-11100000-00000100-00000000
// CHECK: udot    z0.d, z0.h, z0.h[0] // encoding: [0x00,0x04,0xe0,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11100000-00000100-00000000
UDOT    Z0.D, Z0.H, Z0.H[0]  // 01000100-11100000-00000100-00000000
// CHECK: udot    z0.d, z0.h, z0.h[0] // encoding: [0x00,0x04,0xe0,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11100000-00000100-00000000
udot    z0.d, z0.h, z0.h  // 01000100-11000000-00000100-00000000
// CHECK: udot    z0.d, z0.h, z0.h // encoding: [0x00,0x04,0xc0,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11000000-00000100-00000000
UDOT    Z0.D, Z0.H, Z0.H  // 01000100-11000000-00000100-00000000
// CHECK: udot    z0.d, z0.h, z0.h // encoding: [0x00,0x04,0xc0,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11000000-00000100-00000000
udot    z0.s, z0.b, z0.b  // 01000100-10000000-00000100-00000000
// CHECK: udot    z0.s, z0.b, z0.b // encoding: [0x00,0x04,0x80,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10000000-00000100-00000000
UDOT    Z0.S, Z0.B, Z0.B  // 01000100-10000000-00000100-00000000
// CHECK: udot    z0.s, z0.b, z0.b // encoding: [0x00,0x04,0x80,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10000000-00000100-00000000
udot    z23.d, z13.h, z8.h[0]  // 01000100-11101000-00000101-10110111
// CHECK: udot    z23.d, z13.h, z8.h[0] // encoding: [0xb7,0x05,0xe8,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11101000-00000101-10110111
UDOT    Z23.D, Z13.H, Z8.H[0]  // 01000100-11101000-00000101-10110111
// CHECK: udot    z23.d, z13.h, z8.h[0] // encoding: [0xb7,0x05,0xe8,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11101000-00000101-10110111
udot    z0.s, z0.b, z0.b[0]  // 01000100-10100000-00000100-00000000
// CHECK: udot    z0.s, z0.b, z0.b[0] // encoding: [0x00,0x04,0xa0,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10100000-00000100-00000000
UDOT    Z0.S, Z0.B, Z0.B[0]  // 01000100-10100000-00000100-00000000
// CHECK: udot    z0.s, z0.b, z0.b[0] // encoding: [0x00,0x04,0xa0,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10100000-00000100-00000000
udot    z31.s, z31.b, z7.b[3]  // 01000100-10111111-00000111-11111111
// CHECK: udot    z31.s, z31.b, z7.b[3] // encoding: [0xff,0x07,0xbf,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10111111-00000111-11111111
UDOT    Z31.S, Z31.B, Z7.B[3]  // 01000100-10111111-00000111-11111111
// CHECK: udot    z31.s, z31.b, z7.b[3] // encoding: [0xff,0x07,0xbf,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10111111-00000111-11111111
udot    z21.s, z10.b, z5.b[2]  // 01000100-10110101-00000101-01010101
// CHECK: udot    z21.s, z10.b, z5.b[2] // encoding: [0x55,0x05,0xb5,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10110101-00000101-01010101
UDOT    Z21.S, Z10.B, Z5.B[2]  // 01000100-10110101-00000101-01010101
// CHECK: udot    z21.s, z10.b, z5.b[2] // encoding: [0x55,0x05,0xb5,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10110101-00000101-01010101
udot    z23.s, z13.b, z8.b  // 01000100-10001000-00000101-10110111
// CHECK: udot    z23.s, z13.b, z8.b // encoding: [0xb7,0x05,0x88,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10001000-00000101-10110111
UDOT    Z23.S, Z13.B, Z8.B  // 01000100-10001000-00000101-10110111
// CHECK: udot    z23.s, z13.b, z8.b // encoding: [0xb7,0x05,0x88,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10001000-00000101-10110111
udot    z21.d, z10.h, z5.h[1]  // 01000100-11110101-00000101-01010101
// CHECK: udot    z21.d, z10.h, z5.h[1] // encoding: [0x55,0x05,0xf5,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11110101-00000101-01010101
UDOT    Z21.D, Z10.H, Z5.H[1]  // 01000100-11110101-00000101-01010101
// CHECK: udot    z21.d, z10.h, z5.h[1] // encoding: [0x55,0x05,0xf5,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11110101-00000101-01010101
udot    z31.s, z31.b, z31.b  // 01000100-10011111-00000111-11111111
// CHECK: udot    z31.s, z31.b, z31.b // encoding: [0xff,0x07,0x9f,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10011111-00000111-11111111
UDOT    Z31.S, Z31.B, Z31.B  // 01000100-10011111-00000111-11111111
// CHECK: udot    z31.s, z31.b, z31.b // encoding: [0xff,0x07,0x9f,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-10011111-00000111-11111111
udot    z21.d, z10.h, z21.h  // 01000100-11010101-00000101-01010101
// CHECK: udot    z21.d, z10.h, z21.h // encoding: [0x55,0x05,0xd5,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11010101-00000101-01010101
UDOT    Z21.D, Z10.H, Z21.H  // 01000100-11010101-00000101-01010101
// CHECK: udot    z21.d, z10.h, z21.h // encoding: [0x55,0x05,0xd5,0x44]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01000100-11010101-00000101-01010101
