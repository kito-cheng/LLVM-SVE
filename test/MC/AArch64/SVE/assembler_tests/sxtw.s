// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sxtw    z31.d, p7/m, z31.d  // 00000100-11010100-10111111-11111111
// CHECK: sxtw    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010100-10111111-11111111
SXTW    Z31.D, P7/M, Z31.D  // 00000100-11010100-10111111-11111111
// CHECK: sxtw    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010100-10111111-11111111
sxtw    z21.d, p5/m, z10.d  // 00000100-11010100-10110101-01010101
// CHECK: sxtw    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010100-10110101-01010101
SXTW    Z21.D, P5/M, Z10.D  // 00000100-11010100-10110101-01010101
// CHECK: sxtw    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010100-10110101-01010101
sxtw    z0.d, p0/m, z0.d  // 00000100-11010100-10100000-00000000
// CHECK: sxtw    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010100-10100000-00000000
SXTW    Z0.D, P0/M, Z0.D  // 00000100-11010100-10100000-00000000
// CHECK: sxtw    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010100-10100000-00000000
sxtw    z23.d, p3/m, z13.d  // 00000100-11010100-10101101-10110111
// CHECK: sxtw    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010100-10101101-10110111
SXTW    Z23.D, P3/M, Z13.D  // 00000100-11010100-10101101-10110111
// CHECK: sxtw    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd4,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010100-10101101-10110111
