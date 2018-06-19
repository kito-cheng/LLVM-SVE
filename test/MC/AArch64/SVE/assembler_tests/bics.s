// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
bics    p0.b, p0/z, p0.b, p0.b  // 00100101-01000000-01000000-00010000
// CHECK: bics    p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x40,0x40,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000000-01000000-00010000
BICS    P0.B, P0/Z, P0.B, P0.B  // 00100101-01000000-01000000-00010000
// CHECK: bics    p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x40,0x40,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000000-01000000-00010000
bics    p5.b, p5/z, p10.b, p5.b  // 00100101-01000101-01010101-01010101
// CHECK: bics    p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x55,0x45,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000101-01010101-01010101
BICS    P5.B, P5/Z, P10.B, P5.B  // 00100101-01000101-01010101-01010101
// CHECK: bics    p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x55,0x45,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000101-01010101-01010101
bics    p15.b, p15/z, p15.b, p15.b  // 00100101-01001111-01111101-11111111
// CHECK: bics    p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7d,0x4f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001111-01111101-11111111
BICS    P15.B, P15/Z, P15.B, P15.B  // 00100101-01001111-01111101-11111111
// CHECK: bics    p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7d,0x4f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001111-01111101-11111111
bics    p7.b, p11/z, p13.b, p8.b  // 00100101-01001000-01101101-10110111
// CHECK: bics    p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6d,0x48,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001000-01101101-10110111
BICS    P7.B, P11/Z, P13.B, P8.B  // 00100101-01001000-01101101-10110111
// CHECK: bics    p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6d,0x48,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001000-01101101-10110111
