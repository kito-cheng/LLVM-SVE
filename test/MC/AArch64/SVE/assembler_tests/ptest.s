// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ptest   p0, p0.b  // 00100101-01010000-11000000-00000000
// CHECK: ptest   p0, p0.b // encoding: [0x00,0xc0,0x50,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01010000-11000000-00000000
PTEST   P0, P0.B  // 00100101-01010000-11000000-00000000
// CHECK: ptest   p0, p0.b // encoding: [0x00,0xc0,0x50,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01010000-11000000-00000000
ptest   p5, p10.b  // 00100101-01010000-11010101-01000000
// CHECK: ptest   p5, p10.b // encoding: [0x40,0xd5,0x50,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01010000-11010101-01000000
PTEST   P5, P10.B  // 00100101-01010000-11010101-01000000
// CHECK: ptest   p5, p10.b // encoding: [0x40,0xd5,0x50,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01010000-11010101-01000000
ptest   p11, p13.b  // 00100101-01010000-11101101-10100000
// CHECK: ptest   p11, p13.b // encoding: [0xa0,0xed,0x50,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01010000-11101101-10100000
PTEST   P11, P13.B  // 00100101-01010000-11101101-10100000
// CHECK: ptest   p11, p13.b // encoding: [0xa0,0xed,0x50,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01010000-11101101-10100000
ptest   p15, p15.b  // 00100101-01010000-11111101-11100000
// CHECK: ptest   p15, p15.b // encoding: [0xe0,0xfd,0x50,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01010000-11111101-11100000
PTEST   P15, P15.B  // 00100101-01010000-11111101-11100000
// CHECK: ptest   p15, p15.b // encoding: [0xe0,0xfd,0x50,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01010000-11111101-11100000
