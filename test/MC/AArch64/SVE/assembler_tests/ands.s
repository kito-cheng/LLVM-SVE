// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ands    p0.b, p0/z, p0.b, p0.b  // 00100101-01000000-01000000-00000000
// CHECK: movs    p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x40,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000000-01000000-00000000
ANDS    P0.B, P0/Z, P0.B, P0.B  // 00100101-01000000-01000000-00000000
// CHECK: movs    p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x40,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000000-01000000-00000000
ands    p5.b, p5/z, p10.b, p5.b  // 00100101-01000101-01010101-01000101
// CHECK: ands    p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x55,0x45,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000101-01010101-01000101
ANDS    P5.B, P5/Z, P10.B, P5.B  // 00100101-01000101-01010101-01000101
// CHECK: ands    p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x55,0x45,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01000101-01010101-01000101
ands    p7.b, p11/z, p13.b, p8.b  // 00100101-01001000-01101101-10100111
// CHECK: ands    p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0x6d,0x48,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001000-01101101-10100111
ANDS    P7.B, P11/Z, P13.B, P8.B  // 00100101-01001000-01101101-10100111
// CHECK: ands    p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0x6d,0x48,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001000-01101101-10100111
ands    p15.b, p15/z, p15.b, p15.b  // 00100101-01001111-01111101-11101111
// CHECK: movs    p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x4f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001111-01111101-11101111
ANDS    P15.B, P15/Z, P15.B, P15.B  // 00100101-01001111-01111101-11101111
// CHECK: movs    p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x4f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01001111-01111101-11101111
