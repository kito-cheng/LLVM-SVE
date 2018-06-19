// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
brkn    p5.b, p5/z, p10.b, p5.b  // 00100101-00011000-01010101-01000101
// CHECK: brkn    p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x55,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-01010101-01000101
BRKN    P5.B, P5/Z, P10.B, P5.B  // 00100101-00011000-01010101-01000101
// CHECK: brkn    p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x55,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-01010101-01000101
brkn    p0.b, p0/z, p0.b, p0.b  // 00100101-00011000-01000000-00000000
// CHECK: brkn    p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0x40,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-01000000-00000000
BRKN    P0.B, P0/Z, P0.B, P0.B  // 00100101-00011000-01000000-00000000
// CHECK: brkn    p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0x40,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-01000000-00000000
brkn    p7.b, p11/z, p13.b, p7.b  // 00100101-00011000-01101101-10100111
// CHECK: brkn    p7.b, p11/z, p13.b, p7.b // encoding: [0xa7,0x6d,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-01101101-10100111
BRKN    P7.B, P11/Z, P13.B, P7.B  // 00100101-00011000-01101101-10100111
// CHECK: brkn    p7.b, p11/z, p13.b, p7.b // encoding: [0xa7,0x6d,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-01101101-10100111
brkn    p15.b, p15/z, p15.b, p15.b  // 00100101-00011000-01111101-11101111
// CHECK: brkn    p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0x7d,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-01111101-11101111
BRKN    P15.B, P15/Z, P15.B, P15.B  // 00100101-00011000-01111101-11101111
// CHECK: brkn    p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0x7d,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-01111101-11101111
