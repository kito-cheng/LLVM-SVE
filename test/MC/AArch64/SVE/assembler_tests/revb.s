// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
revb    z0.s, p0/m, z0.s  // 00000101-10100100-10000000-00000000
// CHECK: revb    z0.s, p0/m, z0.s // encoding: [0x00,0x80,0xa4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100100-10000000-00000000
REVB    Z0.S, P0/M, Z0.S  // 00000101-10100100-10000000-00000000
// CHECK: revb    z0.s, p0/m, z0.s // encoding: [0x00,0x80,0xa4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100100-10000000-00000000
revb    z0.d, p0/m, z0.d  // 00000101-11100100-10000000-00000000
// CHECK: revb    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100100-10000000-00000000
REVB    Z0.D, P0/M, Z0.D  // 00000101-11100100-10000000-00000000
// CHECK: revb    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100100-10000000-00000000
revb    z23.h, p3/m, z13.h  // 00000101-01100100-10001101-10110111
// CHECK: revb    z23.h, p3/m, z13.h // encoding: [0xb7,0x8d,0x64,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100100-10001101-10110111
REVB    Z23.H, P3/M, Z13.H  // 00000101-01100100-10001101-10110111
// CHECK: revb    z23.h, p3/m, z13.h // encoding: [0xb7,0x8d,0x64,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100100-10001101-10110111
revb    z23.d, p3/m, z13.d  // 00000101-11100100-10001101-10110111
// CHECK: revb    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100100-10001101-10110111
REVB    Z23.D, P3/M, Z13.D  // 00000101-11100100-10001101-10110111
// CHECK: revb    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100100-10001101-10110111
revb    z31.h, p7/m, z31.h  // 00000101-01100100-10011111-11111111
// CHECK: revb    z31.h, p7/m, z31.h // encoding: [0xff,0x9f,0x64,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100100-10011111-11111111
REVB    Z31.H, P7/M, Z31.H  // 00000101-01100100-10011111-11111111
// CHECK: revb    z31.h, p7/m, z31.h // encoding: [0xff,0x9f,0x64,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100100-10011111-11111111
revb    z31.s, p7/m, z31.s  // 00000101-10100100-10011111-11111111
// CHECK: revb    z31.s, p7/m, z31.s // encoding: [0xff,0x9f,0xa4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100100-10011111-11111111
REVB    Z31.S, P7/M, Z31.S  // 00000101-10100100-10011111-11111111
// CHECK: revb    z31.s, p7/m, z31.s // encoding: [0xff,0x9f,0xa4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100100-10011111-11111111
revb    z23.s, p3/m, z13.s  // 00000101-10100100-10001101-10110111
// CHECK: revb    z23.s, p3/m, z13.s // encoding: [0xb7,0x8d,0xa4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100100-10001101-10110111
REVB    Z23.S, P3/M, Z13.S  // 00000101-10100100-10001101-10110111
// CHECK: revb    z23.s, p3/m, z13.s // encoding: [0xb7,0x8d,0xa4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100100-10001101-10110111
revb    z0.h, p0/m, z0.h  // 00000101-01100100-10000000-00000000
// CHECK: revb    z0.h, p0/m, z0.h // encoding: [0x00,0x80,0x64,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100100-10000000-00000000
REVB    Z0.H, P0/M, Z0.H  // 00000101-01100100-10000000-00000000
// CHECK: revb    z0.h, p0/m, z0.h // encoding: [0x00,0x80,0x64,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100100-10000000-00000000
revb    z21.s, p5/m, z10.s  // 00000101-10100100-10010101-01010101
// CHECK: revb    z21.s, p5/m, z10.s // encoding: [0x55,0x95,0xa4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100100-10010101-01010101
REVB    Z21.S, P5/M, Z10.S  // 00000101-10100100-10010101-01010101
// CHECK: revb    z21.s, p5/m, z10.s // encoding: [0x55,0x95,0xa4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100100-10010101-01010101
revb    z31.d, p7/m, z31.d  // 00000101-11100100-10011111-11111111
// CHECK: revb    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100100-10011111-11111111
REVB    Z31.D, P7/M, Z31.D  // 00000101-11100100-10011111-11111111
// CHECK: revb    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100100-10011111-11111111
revb    z21.d, p5/m, z10.d  // 00000101-11100100-10010101-01010101
// CHECK: revb    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100100-10010101-01010101
REVB    Z21.D, P5/M, Z10.D  // 00000101-11100100-10010101-01010101
// CHECK: revb    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe4,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100100-10010101-01010101
revb    z21.h, p5/m, z10.h  // 00000101-01100100-10010101-01010101
// CHECK: revb    z21.h, p5/m, z10.h // encoding: [0x55,0x95,0x64,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100100-10010101-01010101
REVB    Z21.H, P5/M, Z10.H  // 00000101-01100100-10010101-01010101
// CHECK: revb    z21.h, p5/m, z10.h // encoding: [0x55,0x95,0x64,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100100-10010101-01010101
