// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
pfirst  p0.b, p0, p0.b  // 00100101-01011000-11000000-00000000
// CHECK: pfirst  p0.b, p0, p0.b // encoding: [0x00,0xc0,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11000000-00000000
PFIRST  P0.B, P0, P0.B  // 00100101-01011000-11000000-00000000
// CHECK: pfirst  p0.b, p0, p0.b // encoding: [0x00,0xc0,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11000000-00000000
pfirst  p15.b, p15, p15.b  // 00100101-01011000-11000001-11101111
// CHECK: pfirst  p15.b, p15, p15.b // encoding: [0xef,0xc1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11000001-11101111
PFIRST  P15.B, P15, P15.B  // 00100101-01011000-11000001-11101111
// CHECK: pfirst  p15.b, p15, p15.b // encoding: [0xef,0xc1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11000001-11101111
pfirst  p7.b, p13, p7.b  // 00100101-01011000-11000001-10100111
// CHECK: pfirst  p7.b, p13, p7.b // encoding: [0xa7,0xc1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11000001-10100111
PFIRST  P7.B, P13, P7.B  // 00100101-01011000-11000001-10100111
// CHECK: pfirst  p7.b, p13, p7.b // encoding: [0xa7,0xc1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11000001-10100111
pfirst  p5.b, p10, p5.b  // 00100101-01011000-11000001-01000101
// CHECK: pfirst  p5.b, p10, p5.b // encoding: [0x45,0xc1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11000001-01000101
PFIRST  P5.B, P10, P5.B  // 00100101-01011000-11000001-01000101
// CHECK: pfirst  p5.b, p10, p5.b // encoding: [0x45,0xc1,0x58,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011000-11000001-01000101
