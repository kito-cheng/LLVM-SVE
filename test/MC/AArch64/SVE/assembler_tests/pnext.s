// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
pnext   p5.s, p10, p5.s  // 00100101-10011001-11000101-01000101
// CHECK: pnext   p5.s, p10, p5.s // encoding: [0x45,0xc5,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-01000101
PNEXT   P5.S, P10, P5.S  // 00100101-10011001-11000101-01000101
// CHECK: pnext   p5.s, p10, p5.s // encoding: [0x45,0xc5,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-01000101
pnext   p7.b, p13, p7.b  // 00100101-00011001-11000101-10100111
// CHECK: pnext   p7.b, p13, p7.b // encoding: [0xa7,0xc5,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11000101-10100111
PNEXT   P7.B, P13, P7.B  // 00100101-00011001-11000101-10100111
// CHECK: pnext   p7.b, p13, p7.b // encoding: [0xa7,0xc5,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11000101-10100111
pnext   p5.d, p10, p5.d  // 00100101-11011001-11000101-01000101
// CHECK: pnext   p5.d, p10, p5.d // encoding: [0x45,0xc5,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11000101-01000101
PNEXT   P5.D, P10, P5.D  // 00100101-11011001-11000101-01000101
// CHECK: pnext   p5.d, p10, p5.d // encoding: [0x45,0xc5,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11000101-01000101
pnext   p7.d, p13, p7.d  // 00100101-11011001-11000101-10100111
// CHECK: pnext   p7.d, p13, p7.d // encoding: [0xa7,0xc5,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11000101-10100111
PNEXT   P7.D, P13, P7.D  // 00100101-11011001-11000101-10100111
// CHECK: pnext   p7.d, p13, p7.d // encoding: [0xa7,0xc5,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11000101-10100111
pnext   p0.s, p0, p0.s  // 00100101-10011001-11000100-00000000
// CHECK: pnext   p0.s, p0, p0.s // encoding: [0x00,0xc4,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11000100-00000000
PNEXT   P0.S, P0, P0.S  // 00100101-10011001-11000100-00000000
// CHECK: pnext   p0.s, p0, p0.s // encoding: [0x00,0xc4,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11000100-00000000
pnext   p0.b, p0, p0.b  // 00100101-00011001-11000100-00000000
// CHECK: pnext   p0.b, p0, p0.b // encoding: [0x00,0xc4,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11000100-00000000
PNEXT   P0.B, P0, P0.B  // 00100101-00011001-11000100-00000000
// CHECK: pnext   p0.b, p0, p0.b // encoding: [0x00,0xc4,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11000100-00000000
pnext   p15.b, p15, p15.b  // 00100101-00011001-11000101-11101111
// CHECK: pnext   p15.b, p15, p15.b // encoding: [0xef,0xc5,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11000101-11101111
PNEXT   P15.B, P15, P15.B  // 00100101-00011001-11000101-11101111
// CHECK: pnext   p15.b, p15, p15.b // encoding: [0xef,0xc5,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11000101-11101111
pnext   p5.b, p10, p5.b  // 00100101-00011001-11000101-01000101
// CHECK: pnext   p5.b, p10, p5.b // encoding: [0x45,0xc5,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11000101-01000101
PNEXT   P5.B, P10, P5.B  // 00100101-00011001-11000101-01000101
// CHECK: pnext   p5.b, p10, p5.b // encoding: [0x45,0xc5,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11000101-01000101
pnext   p7.h, p13, p7.h  // 00100101-01011001-11000101-10100111
// CHECK: pnext   p7.h, p13, p7.h // encoding: [0xa7,0xc5,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11000101-10100111
PNEXT   P7.H, P13, P7.H  // 00100101-01011001-11000101-10100111
// CHECK: pnext   p7.h, p13, p7.h // encoding: [0xa7,0xc5,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11000101-10100111
pnext   p0.h, p0, p0.h  // 00100101-01011001-11000100-00000000
// CHECK: pnext   p0.h, p0, p0.h // encoding: [0x00,0xc4,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11000100-00000000
PNEXT   P0.H, P0, P0.H  // 00100101-01011001-11000100-00000000
// CHECK: pnext   p0.h, p0, p0.h // encoding: [0x00,0xc4,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11000100-00000000
pnext   p0.d, p0, p0.d  // 00100101-11011001-11000100-00000000
// CHECK: pnext   p0.d, p0, p0.d // encoding: [0x00,0xc4,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11000100-00000000
PNEXT   P0.D, P0, P0.D  // 00100101-11011001-11000100-00000000
// CHECK: pnext   p0.d, p0, p0.d // encoding: [0x00,0xc4,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11000100-00000000
pnext   p15.d, p15, p15.d  // 00100101-11011001-11000101-11101111
// CHECK: pnext   p15.d, p15, p15.d // encoding: [0xef,0xc5,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11000101-11101111
PNEXT   P15.D, P15, P15.D  // 00100101-11011001-11000101-11101111
// CHECK: pnext   p15.d, p15, p15.d // encoding: [0xef,0xc5,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11000101-11101111
pnext   p5.h, p10, p5.h  // 00100101-01011001-11000101-01000101
// CHECK: pnext   p5.h, p10, p5.h // encoding: [0x45,0xc5,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11000101-01000101
PNEXT   P5.H, P10, P5.H  // 00100101-01011001-11000101-01000101
// CHECK: pnext   p5.h, p10, p5.h // encoding: [0x45,0xc5,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11000101-01000101
pnext   p15.h, p15, p15.h  // 00100101-01011001-11000101-11101111
// CHECK: pnext   p15.h, p15, p15.h // encoding: [0xef,0xc5,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11000101-11101111
PNEXT   P15.H, P15, P15.H  // 00100101-01011001-11000101-11101111
// CHECK: pnext   p15.h, p15, p15.h // encoding: [0xef,0xc5,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11000101-11101111
pnext   p7.s, p13, p7.s  // 00100101-10011001-11000101-10100111
// CHECK: pnext   p7.s, p13, p7.s // encoding: [0xa7,0xc5,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-10100111
PNEXT   P7.S, P13, P7.S  // 00100101-10011001-11000101-10100111
// CHECK: pnext   p7.s, p13, p7.s // encoding: [0xa7,0xc5,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-10100111
pnext   p15.s, p15, p15.s  // 00100101-10011001-11000101-11101111
// CHECK: pnext   p15.s, p15, p15.s // encoding: [0xef,0xc5,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-11101111
PNEXT   P15.S, P15, P15.S  // 00100101-10011001-11000101-11101111
// CHECK: pnext   p15.s, p15, p15.s // encoding: [0xef,0xc5,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11000101-11101111
