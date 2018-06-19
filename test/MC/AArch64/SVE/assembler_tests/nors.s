// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
nors    p5.b, p5/z, p10.b, p5.b  // 00100101-11000101-01010111-01000101
// CHECK: nors    p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x57,0xc5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11000101-01010111-01000101
NORS    P5.B, P5/Z, P10.B, P5.B  // 00100101-11000101-01010111-01000101
// CHECK: nors    p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x57,0xc5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11000101-01010111-01000101
nors    p7.b, p11/z, p13.b, p8.b  // 00100101-11001000-01101111-10100111
// CHECK: nors    p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0x6f,0xc8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11001000-01101111-10100111
NORS    P7.B, P11/Z, P13.B, P8.B  // 00100101-11001000-01101111-10100111
// CHECK: nors    p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0x6f,0xc8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11001000-01101111-10100111
nors    p15.b, p15/z, p15.b, p15.b  // 00100101-11001111-01111111-11101111
// CHECK: nors    p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0x7f,0xcf,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11001111-01111111-11101111
NORS    P15.B, P15/Z, P15.B, P15.B  // 00100101-11001111-01111111-11101111
// CHECK: nors    p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0x7f,0xcf,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11001111-01111111-11101111
nors    p0.b, p0/z, p0.b, p0.b  // 00100101-11000000-01000010-00000000
// CHECK: nors    p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0x42,0xc0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11000000-01000010-00000000
NORS    P0.B, P0/Z, P0.B, P0.B  // 00100101-11000000-01000010-00000000
// CHECK: nors    p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0x42,0xc0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11000000-01000010-00000000
