// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
rdffr   p0.b  // 00100101-00011001-11110000-00000000
// CHECK: rdffr   p0.b // encoding: [0x00,0xf0,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11110000-00000000
RDFFR   P0.B  // 00100101-00011001-11110000-00000000
// CHECK: rdffr   p0.b // encoding: [0x00,0xf0,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11110000-00000000
rdffr   p15.b, p15/z  // 00100101-00011000-11110001-11101111
// CHECK: rdffr   p15.b, p15/z // encoding: [0xef,0xf1,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11110001-11101111
RDFFR   P15.B, P15/Z  // 00100101-00011000-11110001-11101111
// CHECK: rdffr   p15.b, p15/z // encoding: [0xef,0xf1,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11110001-11101111
rdffr   p0.b, p0/z  // 00100101-00011000-11110000-00000000
// CHECK: rdffr   p0.b, p0/z // encoding: [0x00,0xf0,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11110000-00000000
RDFFR   P0.B, P0/Z  // 00100101-00011000-11110000-00000000
// CHECK: rdffr   p0.b, p0/z // encoding: [0x00,0xf0,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11110000-00000000
rdffr   p5.b  // 00100101-00011001-11110000-00000101
// CHECK: rdffr   p5.b // encoding: [0x05,0xf0,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11110000-00000101
RDFFR   P5.B  // 00100101-00011001-11110000-00000101
// CHECK: rdffr   p5.b // encoding: [0x05,0xf0,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11110000-00000101
rdffr   p7.b, p13/z  // 00100101-00011000-11110001-10100111
// CHECK: rdffr   p7.b, p13/z // encoding: [0xa7,0xf1,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11110001-10100111
RDFFR   P7.B, P13/Z  // 00100101-00011000-11110001-10100111
// CHECK: rdffr   p7.b, p13/z // encoding: [0xa7,0xf1,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11110001-10100111
rdffr   p15.b  // 00100101-00011001-11110000-00001111
// CHECK: rdffr   p15.b // encoding: [0x0f,0xf0,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11110000-00001111
RDFFR   P15.B  // 00100101-00011001-11110000-00001111
// CHECK: rdffr   p15.b // encoding: [0x0f,0xf0,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11110000-00001111
rdffr   p5.b, p10/z  // 00100101-00011000-11110001-01000101
// CHECK: rdffr   p5.b, p10/z // encoding: [0x45,0xf1,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11110001-01000101
RDFFR   P5.B, P10/Z  // 00100101-00011000-11110001-01000101
// CHECK: rdffr   p5.b, p10/z // encoding: [0x45,0xf1,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11110001-01000101
rdffr   p7.b  // 00100101-00011001-11110000-00000111
// CHECK: rdffr   p7.b // encoding: [0x07,0xf0,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11110000-00000111
RDFFR   P7.B  // 00100101-00011001-11110000-00000111
// CHECK: rdffr   p7.b // encoding: [0x07,0xf0,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11110000-00000111
