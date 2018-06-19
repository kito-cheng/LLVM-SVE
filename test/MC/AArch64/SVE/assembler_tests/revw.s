// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
revw    z31.d, p7/m, z31.d  // 00000101-11100110-10011111-11111111
// CHECK: revw    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe6,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100110-10011111-11111111
REVW    Z31.D, P7/M, Z31.D  // 00000101-11100110-10011111-11111111
// CHECK: revw    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe6,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100110-10011111-11111111
revw    z23.d, p3/m, z13.d  // 00000101-11100110-10001101-10110111
// CHECK: revw    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe6,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100110-10001101-10110111
REVW    Z23.D, P3/M, Z13.D  // 00000101-11100110-10001101-10110111
// CHECK: revw    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe6,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100110-10001101-10110111
revw    z21.d, p5/m, z10.d  // 00000101-11100110-10010101-01010101
// CHECK: revw    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe6,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100110-10010101-01010101
REVW    Z21.D, P5/M, Z10.D  // 00000101-11100110-10010101-01010101
// CHECK: revw    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe6,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100110-10010101-01010101
revw    z0.d, p0/m, z0.d  // 00000101-11100110-10000000-00000000
// CHECK: revw    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe6,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100110-10000000-00000000
REVW    Z0.D, P0/M, Z0.D  // 00000101-11100110-10000000-00000000
// CHECK: revw    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe6,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100110-10000000-00000000
