// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ptrues  p5.d, vl32  // 00100101-11011001-11100001-01000101
// CHECK: ptrues  p5.d, vl32 // encoding: [0x45,0xe1,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11100001-01000101
PTRUES  P5.D, VL32  // 00100101-11011001-11100001-01000101
// CHECK: ptrues  p5.d, vl32 // encoding: [0x45,0xe1,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11100001-01000101
ptrues  p5.h, vl32  // 00100101-01011001-11100001-01000101
// CHECK: ptrues  p5.h, vl32 // encoding: [0x45,0xe1,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11100001-01000101
PTRUES  P5.H, VL32  // 00100101-01011001-11100001-01000101
// CHECK: ptrues  p5.h, vl32 // encoding: [0x45,0xe1,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11100001-01000101
ptrues  p7.b, vl256  // 00100101-00011001-11100001-10100111
// CHECK: ptrues  p7.b, vl256 // encoding: [0xa7,0xe1,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11100001-10100111
PTRUES  P7.B, VL256  // 00100101-00011001-11100001-10100111
// CHECK: ptrues  p7.b, vl256 // encoding: [0xa7,0xe1,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11100001-10100111
ptrues  p7.d, vl256  // 00100101-11011001-11100001-10100111
// CHECK: ptrues  p7.d, vl256 // encoding: [0xa7,0xe1,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11100001-10100111
PTRUES  P7.D, VL256  // 00100101-11011001-11100001-10100111
// CHECK: ptrues  p7.d, vl256 // encoding: [0xa7,0xe1,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11100001-10100111
ptrues  p15.h  // 00100101-01011001-11100011-11101111
// CHECK: ptrues  p15.h // encoding: [0xef,0xe3,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11100011-11101111
PTRUES  P15.H  // 00100101-01011001-11100011-11101111
// CHECK: ptrues  p15.h // encoding: [0xef,0xe3,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11100011-11101111
ptrues  p5.s, vl32  // 00100101-10011001-11100001-01000101
// CHECK: ptrues  p5.s, vl32 // encoding: [0x45,0xe1,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11100001-01000101
PTRUES  P5.S, VL32  // 00100101-10011001-11100001-01000101
// CHECK: ptrues  p5.s, vl32 // encoding: [0x45,0xe1,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11100001-01000101
ptrues  p5.b, vl32  // 00100101-00011001-11100001-01000101
// CHECK: ptrues  p5.b, vl32 // encoding: [0x45,0xe1,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11100001-01000101
PTRUES  P5.B, VL32  // 00100101-00011001-11100001-01000101
// CHECK: ptrues  p5.b, vl32 // encoding: [0x45,0xe1,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11100001-01000101
ptrues  p0.s, pow2  // 00100101-10011001-11100000-00000000
// CHECK: ptrues  p0.s, pow2 // encoding: [0x00,0xe0,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11100000-00000000
PTRUES  P0.S, POW2  // 00100101-10011001-11100000-00000000
// CHECK: ptrues  p0.s, pow2 // encoding: [0x00,0xe0,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11100000-00000000
ptrues  p0.b, pow2  // 00100101-00011001-11100000-00000000
// CHECK: ptrues  p0.b, pow2 // encoding: [0x00,0xe0,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11100000-00000000
PTRUES  P0.B, POW2  // 00100101-00011001-11100000-00000000
// CHECK: ptrues  p0.b, pow2 // encoding: [0x00,0xe0,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11100000-00000000
ptrues  p15.d  // 00100101-11011001-11100011-11101111
// CHECK: ptrues  p15.d // encoding: [0xef,0xe3,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11100011-11101111
PTRUES  P15.D  // 00100101-11011001-11100011-11101111
// CHECK: ptrues  p15.d // encoding: [0xef,0xe3,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11100011-11101111
ptrues  p15.s  // 00100101-10011001-11100011-11101111
// CHECK: ptrues  p15.s // encoding: [0xef,0xe3,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11100011-11101111
PTRUES  P15.S  // 00100101-10011001-11100011-11101111
// CHECK: ptrues  p15.s // encoding: [0xef,0xe3,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11100011-11101111
ptrues  p0.h, pow2  // 00100101-01011001-11100000-00000000
// CHECK: ptrues  p0.h, pow2 // encoding: [0x00,0xe0,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11100000-00000000
PTRUES  P0.H, POW2  // 00100101-01011001-11100000-00000000
// CHECK: ptrues  p0.h, pow2 // encoding: [0x00,0xe0,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11100000-00000000
ptrues  p7.s, vl256  // 00100101-10011001-11100001-10100111
// CHECK: ptrues  p7.s, vl256 // encoding: [0xa7,0xe1,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11100001-10100111
PTRUES  P7.S, VL256  // 00100101-10011001-11100001-10100111
// CHECK: ptrues  p7.s, vl256 // encoding: [0xa7,0xe1,0x99,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10011001-11100001-10100111
ptrues  p0.d, pow2  // 00100101-11011001-11100000-00000000
// CHECK: ptrues  p0.d, pow2 // encoding: [0x00,0xe0,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11100000-00000000
PTRUES  P0.D, POW2  // 00100101-11011001-11100000-00000000
// CHECK: ptrues  p0.d, pow2 // encoding: [0x00,0xe0,0xd9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11011001-11100000-00000000
ptrues  p7.h, vl256  // 00100101-01011001-11100001-10100111
// CHECK: ptrues  p7.h, vl256 // encoding: [0xa7,0xe1,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11100001-10100111
PTRUES  P7.H, VL256  // 00100101-01011001-11100001-10100111
// CHECK: ptrues  p7.h, vl256 // encoding: [0xa7,0xe1,0x59,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01011001-11100001-10100111
ptrues  p15.b  // 00100101-00011001-11100011-11101111
// CHECK: ptrues  p15.b // encoding: [0xef,0xe3,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11100011-11101111
PTRUES  P15.B  // 00100101-00011001-11100011-11101111
// CHECK: ptrues  p15.b // encoding: [0xef,0xe3,0x19,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011001-11100011-11101111
