// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
rdffrs  p7.b, p13/z  // 00100101-01011000-11110001-10100111
// CHECK: rdffrs  p7.b, p13/z // encoding: [0xa7,0xf1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11110001-10100111
RDFFRS  P7.B, P13/Z  // 00100101-01011000-11110001-10100111
// CHECK: rdffrs  p7.b, p13/z // encoding: [0xa7,0xf1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11110001-10100111
rdffrs  p15.b, p15/z  // 00100101-01011000-11110001-11101111
// CHECK: rdffrs  p15.b, p15/z // encoding: [0xef,0xf1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11110001-11101111
RDFFRS  P15.B, P15/Z  // 00100101-01011000-11110001-11101111
// CHECK: rdffrs  p15.b, p15/z // encoding: [0xef,0xf1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11110001-11101111
rdffrs  p5.b, p10/z  // 00100101-01011000-11110001-01000101
// CHECK: rdffrs  p5.b, p10/z // encoding: [0x45,0xf1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11110001-01000101
RDFFRS  P5.B, P10/Z  // 00100101-01011000-11110001-01000101
// CHECK: rdffrs  p5.b, p10/z // encoding: [0x45,0xf1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11110001-01000101
rdffrs  p0.b, p0/z  // 00100101-01011000-11110000-00000000
// CHECK: rdffrs  p0.b, p0/z // encoding: [0x00,0xf0,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11110000-00000000
RDFFRS  P0.B, P0/Z  // 00100101-01011000-11110000-00000000
// CHECK: rdffrs  p0.b, p0/z // encoding: [0x00,0xf0,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11110000-00000000
