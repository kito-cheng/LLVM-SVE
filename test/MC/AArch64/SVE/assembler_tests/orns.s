// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
orns    p7.b, p11/z, p13.b, p8.b  // 00100101-11001000-01101101-10110111
// CHECK: orns    p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6d,0xc8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11001000-01101101-10110111
ORNS    P7.B, P11/Z, P13.B, P8.B  // 00100101-11001000-01101101-10110111
// CHECK: orns    p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6d,0xc8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11001000-01101101-10110111
orns    p0.b, p0/z, p0.b, p0.b  // 00100101-11000000-01000000-00010000
// CHECK: orns    p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x40,0xc0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11000000-01000000-00010000
ORNS    P0.B, P0/Z, P0.B, P0.B  // 00100101-11000000-01000000-00010000
// CHECK: orns    p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x40,0xc0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11000000-01000000-00010000
orns    p15.b, p15/z, p15.b, p15.b  // 00100101-11001111-01111101-11111111
// CHECK: orns    p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7d,0xcf,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11001111-01111101-11111111
ORNS    P15.B, P15/Z, P15.B, P15.B  // 00100101-11001111-01111101-11111111
// CHECK: orns    p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7d,0xcf,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11001111-01111101-11111111
orns    p5.b, p5/z, p10.b, p5.b  // 00100101-11000101-01010101-01010101
// CHECK: orns    p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x55,0xc5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11000101-01010101-01010101
ORNS    P5.B, P5/Z, P10.B, P5.B  // 00100101-11000101-01010101-01010101
// CHECK: orns    p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x55,0xc5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11000101-01010101-01010101
