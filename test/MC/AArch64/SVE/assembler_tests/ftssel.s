// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ftssel  z23.d, z13.d, z8.d  // 00000100-11101000-10110001-10110111
// CHECK: ftssel  z23.d, z13.d, z8.d // encoding: [0xb7,0xb1,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10110001-10110111
FTSSEL  Z23.D, Z13.D, Z8.D  // 00000100-11101000-10110001-10110111
// CHECK: ftssel  z23.d, z13.d, z8.d // encoding: [0xb7,0xb1,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10110001-10110111
ftssel  z31.s, z31.s, z31.s  // 00000100-10111111-10110011-11111111
// CHECK: ftssel  z31.s, z31.s, z31.s // encoding: [0xff,0xb3,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10110011-11111111
FTSSEL  Z31.S, Z31.S, Z31.S  // 00000100-10111111-10110011-11111111
// CHECK: ftssel  z31.s, z31.s, z31.s // encoding: [0xff,0xb3,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10110011-11111111
ftssel  z0.s, z0.s, z0.s  // 00000100-10100000-10110000-00000000
// CHECK: ftssel  z0.s, z0.s, z0.s // encoding: [0x00,0xb0,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10110000-00000000
FTSSEL  Z0.S, Z0.S, Z0.S  // 00000100-10100000-10110000-00000000
// CHECK: ftssel  z0.s, z0.s, z0.s // encoding: [0x00,0xb0,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10110000-00000000
ftssel  z0.d, z0.d, z0.d  // 00000100-11100000-10110000-00000000
// CHECK: ftssel  z0.d, z0.d, z0.d // encoding: [0x00,0xb0,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10110000-00000000
FTSSEL  Z0.D, Z0.D, Z0.D  // 00000100-11100000-10110000-00000000
// CHECK: ftssel  z0.d, z0.d, z0.d // encoding: [0x00,0xb0,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10110000-00000000
ftssel  z0.h, z0.h, z0.h  // 00000100-01100000-10110000-00000000
// CHECK: ftssel  z0.h, z0.h, z0.h // encoding: [0x00,0xb0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10110000-00000000
FTSSEL  Z0.H, Z0.H, Z0.H  // 00000100-01100000-10110000-00000000
// CHECK: ftssel  z0.h, z0.h, z0.h // encoding: [0x00,0xb0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10110000-00000000
ftssel  z23.h, z13.h, z8.h  // 00000100-01101000-10110001-10110111
// CHECK: ftssel  z23.h, z13.h, z8.h // encoding: [0xb7,0xb1,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10110001-10110111
FTSSEL  Z23.H, Z13.H, Z8.H  // 00000100-01101000-10110001-10110111
// CHECK: ftssel  z23.h, z13.h, z8.h // encoding: [0xb7,0xb1,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10110001-10110111
ftssel  z31.d, z31.d, z31.d  // 00000100-11111111-10110011-11111111
// CHECK: ftssel  z31.d, z31.d, z31.d // encoding: [0xff,0xb3,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10110011-11111111
FTSSEL  Z31.D, Z31.D, Z31.D  // 00000100-11111111-10110011-11111111
// CHECK: ftssel  z31.d, z31.d, z31.d // encoding: [0xff,0xb3,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10110011-11111111
ftssel  z21.s, z10.s, z21.s  // 00000100-10110101-10110001-01010101
// CHECK: ftssel  z21.s, z10.s, z21.s // encoding: [0x55,0xb1,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10110001-01010101
FTSSEL  Z21.S, Z10.S, Z21.S  // 00000100-10110101-10110001-01010101
// CHECK: ftssel  z21.s, z10.s, z21.s // encoding: [0x55,0xb1,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10110001-01010101
ftssel  z31.h, z31.h, z31.h  // 00000100-01111111-10110011-11111111
// CHECK: ftssel  z31.h, z31.h, z31.h // encoding: [0xff,0xb3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10110011-11111111
FTSSEL  Z31.H, Z31.H, Z31.H  // 00000100-01111111-10110011-11111111
// CHECK: ftssel  z31.h, z31.h, z31.h // encoding: [0xff,0xb3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10110011-11111111
ftssel  z21.h, z10.h, z21.h  // 00000100-01110101-10110001-01010101
// CHECK: ftssel  z21.h, z10.h, z21.h // encoding: [0x55,0xb1,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10110001-01010101
FTSSEL  Z21.H, Z10.H, Z21.H  // 00000100-01110101-10110001-01010101
// CHECK: ftssel  z21.h, z10.h, z21.h // encoding: [0x55,0xb1,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10110001-01010101
ftssel  z21.d, z10.d, z21.d  // 00000100-11110101-10110001-01010101
// CHECK: ftssel  z21.d, z10.d, z21.d // encoding: [0x55,0xb1,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10110001-01010101
FTSSEL  Z21.D, Z10.D, Z21.D  // 00000100-11110101-10110001-01010101
// CHECK: ftssel  z21.d, z10.d, z21.d // encoding: [0x55,0xb1,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10110001-01010101
ftssel  z23.s, z13.s, z8.s  // 00000100-10101000-10110001-10110111
// CHECK: ftssel  z23.s, z13.s, z8.s // encoding: [0xb7,0xb1,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10110001-10110111
FTSSEL  Z23.S, Z13.S, Z8.S  // 00000100-10101000-10110001-10110111
// CHECK: ftssel  z23.s, z13.s, z8.s // encoding: [0xb7,0xb1,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10110001-10110111
