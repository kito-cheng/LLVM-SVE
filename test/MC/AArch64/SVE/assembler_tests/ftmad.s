// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ftmad   z0.s, z0.s, z0.s, #0  // 01100101-10010000-10000000-00000000
// CHECK: ftmad   z0.s, z0.s, z0.s, #0 // encoding: [0x00,0x80,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-10000000-00000000
FTMAD   Z0.S, Z0.S, Z0.S, #0  // 01100101-10010000-10000000-00000000
// CHECK: ftmad   z0.s, z0.s, z0.s, #0 // encoding: [0x00,0x80,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-10000000-00000000
ftmad   z21.h, z21.h, z10.h, #5  // 01100101-01010101-10000001-01010101
// CHECK: ftmad   z21.h, z21.h, z10.h, #5 // encoding: [0x55,0x81,0x55,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010101-10000001-01010101
FTMAD   Z21.H, Z21.H, Z10.H, #5  // 01100101-01010101-10000001-01010101
// CHECK: ftmad   z21.h, z21.h, z10.h, #5 // encoding: [0x55,0x81,0x55,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010101-10000001-01010101
ftmad   z23.h, z23.h, z13.h, #0  // 01100101-01010000-10000001-10110111
// CHECK: ftmad   z23.h, z23.h, z13.h, #0 // encoding: [0xb7,0x81,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-10000001-10110111
FTMAD   Z23.H, Z23.H, Z13.H, #0  // 01100101-01010000-10000001-10110111
// CHECK: ftmad   z23.h, z23.h, z13.h, #0 // encoding: [0xb7,0x81,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-10000001-10110111
ftmad   z31.d, z31.d, z31.d, #7  // 01100101-11010111-10000011-11111111
// CHECK: ftmad   z31.d, z31.d, z31.d, #7 // encoding: [0xff,0x83,0xd7,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010111-10000011-11111111
FTMAD   Z31.D, Z31.D, Z31.D, #7  // 01100101-11010111-10000011-11111111
// CHECK: ftmad   z31.d, z31.d, z31.d, #7 // encoding: [0xff,0x83,0xd7,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010111-10000011-11111111
ftmad   z23.s, z23.s, z13.s, #0  // 01100101-10010000-10000001-10110111
// CHECK: ftmad   z23.s, z23.s, z13.s, #0 // encoding: [0xb7,0x81,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-10000001-10110111
FTMAD   Z23.S, Z23.S, Z13.S, #0  // 01100101-10010000-10000001-10110111
// CHECK: ftmad   z23.s, z23.s, z13.s, #0 // encoding: [0xb7,0x81,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-10000001-10110111
ftmad   z21.d, z21.d, z10.d, #5  // 01100101-11010101-10000001-01010101
// CHECK: ftmad   z21.d, z21.d, z10.d, #5 // encoding: [0x55,0x81,0xd5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010101-10000001-01010101
FTMAD   Z21.D, Z21.D, Z10.D, #5  // 01100101-11010101-10000001-01010101
// CHECK: ftmad   z21.d, z21.d, z10.d, #5 // encoding: [0x55,0x81,0xd5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010101-10000001-01010101
ftmad   z0.h, z0.h, z0.h, #0  // 01100101-01010000-10000000-00000000
// CHECK: ftmad   z0.h, z0.h, z0.h, #0 // encoding: [0x00,0x80,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-10000000-00000000
FTMAD   Z0.H, Z0.H, Z0.H, #0  // 01100101-01010000-10000000-00000000
// CHECK: ftmad   z0.h, z0.h, z0.h, #0 // encoding: [0x00,0x80,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-10000000-00000000
ftmad   z23.d, z23.d, z13.d, #0  // 01100101-11010000-10000001-10110111
// CHECK: ftmad   z23.d, z23.d, z13.d, #0 // encoding: [0xb7,0x81,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-10000001-10110111
FTMAD   Z23.D, Z23.D, Z13.D, #0  // 01100101-11010000-10000001-10110111
// CHECK: ftmad   z23.d, z23.d, z13.d, #0 // encoding: [0xb7,0x81,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-10000001-10110111
ftmad   z0.d, z0.d, z0.d, #0  // 01100101-11010000-10000000-00000000
// CHECK: ftmad   z0.d, z0.d, z0.d, #0 // encoding: [0x00,0x80,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-10000000-00000000
FTMAD   Z0.D, Z0.D, Z0.D, #0  // 01100101-11010000-10000000-00000000
// CHECK: ftmad   z0.d, z0.d, z0.d, #0 // encoding: [0x00,0x80,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-10000000-00000000
ftmad   z31.h, z31.h, z31.h, #7  // 01100101-01010111-10000011-11111111
// CHECK: ftmad   z31.h, z31.h, z31.h, #7 // encoding: [0xff,0x83,0x57,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010111-10000011-11111111
FTMAD   Z31.H, Z31.H, Z31.H, #7  // 01100101-01010111-10000011-11111111
// CHECK: ftmad   z31.h, z31.h, z31.h, #7 // encoding: [0xff,0x83,0x57,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010111-10000011-11111111
ftmad   z31.s, z31.s, z31.s, #7  // 01100101-10010111-10000011-11111111
// CHECK: ftmad   z31.s, z31.s, z31.s, #7 // encoding: [0xff,0x83,0x97,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010111-10000011-11111111
FTMAD   Z31.S, Z31.S, Z31.S, #7  // 01100101-10010111-10000011-11111111
// CHECK: ftmad   z31.s, z31.s, z31.s, #7 // encoding: [0xff,0x83,0x97,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010111-10000011-11111111
ftmad   z21.s, z21.s, z10.s, #5  // 01100101-10010101-10000001-01010101
// CHECK: ftmad   z21.s, z21.s, z10.s, #5 // encoding: [0x55,0x81,0x95,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010101-10000001-01010101
FTMAD   Z21.S, Z21.S, Z10.S, #5  // 01100101-10010101-10000001-01010101
// CHECK: ftmad   z21.s, z21.s, z10.s, #5 // encoding: [0x55,0x81,0x95,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010101-10000001-01010101
