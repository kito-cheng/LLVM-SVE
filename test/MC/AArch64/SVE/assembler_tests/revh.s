// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
revh    z21.s, p5/m, z10.s  // 00000101-10100101-10010101-01010101
// CHECK: revh    z21.s, p5/m, z10.s // encoding: [0x55,0x95,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100101-10010101-01010101
REVH    Z21.S, P5/M, Z10.S  // 00000101-10100101-10010101-01010101
// CHECK: revh    z21.s, p5/m, z10.s // encoding: [0x55,0x95,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100101-10010101-01010101
revh    z23.d, p3/m, z13.d  // 00000101-11100101-10001101-10110111
// CHECK: revh    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100101-10001101-10110111
REVH    Z23.D, P3/M, Z13.D  // 00000101-11100101-10001101-10110111
// CHECK: revh    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100101-10001101-10110111
revh    z0.s, p0/m, z0.s  // 00000101-10100101-10000000-00000000
// CHECK: revh    z0.s, p0/m, z0.s // encoding: [0x00,0x80,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100101-10000000-00000000
REVH    Z0.S, P0/M, Z0.S  // 00000101-10100101-10000000-00000000
// CHECK: revh    z0.s, p0/m, z0.s // encoding: [0x00,0x80,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100101-10000000-00000000
revh    z23.s, p3/m, z13.s  // 00000101-10100101-10001101-10110111
// CHECK: revh    z23.s, p3/m, z13.s // encoding: [0xb7,0x8d,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100101-10001101-10110111
REVH    Z23.S, P3/M, Z13.S  // 00000101-10100101-10001101-10110111
// CHECK: revh    z23.s, p3/m, z13.s // encoding: [0xb7,0x8d,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100101-10001101-10110111
revh    z31.s, p7/m, z31.s  // 00000101-10100101-10011111-11111111
// CHECK: revh    z31.s, p7/m, z31.s // encoding: [0xff,0x9f,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100101-10011111-11111111
REVH    Z31.S, P7/M, Z31.S  // 00000101-10100101-10011111-11111111
// CHECK: revh    z31.s, p7/m, z31.s // encoding: [0xff,0x9f,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100101-10011111-11111111
revh    z0.d, p0/m, z0.d  // 00000101-11100101-10000000-00000000
// CHECK: revh    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100101-10000000-00000000
REVH    Z0.D, P0/M, Z0.D  // 00000101-11100101-10000000-00000000
// CHECK: revh    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100101-10000000-00000000
revh    z21.d, p5/m, z10.d  // 00000101-11100101-10010101-01010101
// CHECK: revh    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100101-10010101-01010101
REVH    Z21.D, P5/M, Z10.D  // 00000101-11100101-10010101-01010101
// CHECK: revh    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100101-10010101-01010101
revh    z31.d, p7/m, z31.d  // 00000101-11100101-10011111-11111111
// CHECK: revh    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100101-10011111-11111111
REVH    Z31.D, P7/M, Z31.D  // 00000101-11100101-10011111-11111111
// CHECK: revh    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100101-10011111-11111111
