// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
nor     p15.b, p15/z, p15.b, p15.b  // 00100101-10001111-01111111-11101111
// CHECK: nor     p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0x7f,0x8f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001111-01111111-11101111
NOR     P15.B, P15/Z, P15.B, P15.B  // 00100101-10001111-01111111-11101111
// CHECK: nor     p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0x7f,0x8f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001111-01111111-11101111
nor     p5.b, p5/z, p10.b, p5.b  // 00100101-10000101-01010111-01000101
// CHECK: nor     p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x57,0x85,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000101-01010111-01000101
NOR     P5.B, P5/Z, P10.B, P5.B  // 00100101-10000101-01010111-01000101
// CHECK: nor     p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x57,0x85,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000101-01010111-01000101
nor     p7.b, p11/z, p13.b, p8.b  // 00100101-10001000-01101111-10100111
// CHECK: nor     p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0x6f,0x88,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001000-01101111-10100111
NOR     P7.B, P11/Z, P13.B, P8.B  // 00100101-10001000-01101111-10100111
// CHECK: nor     p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0x6f,0x88,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10001000-01101111-10100111
nor     p0.b, p0/z, p0.b, p0.b  // 00100101-10000000-01000010-00000000
// CHECK: nor     p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0x42,0x80,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000000-01000010-00000000
NOR     P0.B, P0/Z, P0.B, P0.B  // 00100101-10000000-01000010-00000000
// CHECK: nor     p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0x42,0x80,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10000000-01000010-00000000
