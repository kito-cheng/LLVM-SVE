// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
brkbs   p0.b, p0/z, p0.b  // 00100101-11010000-01000000-00000000
// CHECK: brkbs   p0.b, p0/z, p0.b // encoding: [0x00,0x40,0xd0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11010000-01000000-00000000
BRKBS   P0.B, P0/Z, P0.B  // 00100101-11010000-01000000-00000000
// CHECK: brkbs   p0.b, p0/z, p0.b // encoding: [0x00,0x40,0xd0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11010000-01000000-00000000
brkbs   p7.b, p11/z, p13.b  // 00100101-11010000-01101101-10100111
// CHECK: brkbs   p7.b, p11/z, p13.b // encoding: [0xa7,0x6d,0xd0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11010000-01101101-10100111
BRKBS   P7.B, P11/Z, P13.B  // 00100101-11010000-01101101-10100111
// CHECK: brkbs   p7.b, p11/z, p13.b // encoding: [0xa7,0x6d,0xd0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11010000-01101101-10100111
brkbs   p15.b, p15/z, p15.b  // 00100101-11010000-01111101-11101111
// CHECK: brkbs   p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0xd0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11010000-01111101-11101111
BRKBS   P15.B, P15/Z, P15.B  // 00100101-11010000-01111101-11101111
// CHECK: brkbs   p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0xd0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11010000-01111101-11101111
brkbs   p5.b, p5/z, p10.b  // 00100101-11010000-01010101-01000101
// CHECK: brkbs   p5.b, p5/z, p10.b // encoding: [0x45,0x55,0xd0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11010000-01010101-01000101
BRKBS   P5.B, P5/Z, P10.B  // 00100101-11010000-01010101-01000101
// CHECK: brkbs   p5.b, p5/z, p10.b // encoding: [0x45,0x55,0xd0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11010000-01010101-01000101
