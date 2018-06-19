// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fcmge   p15.d, p7/z, z31.d, z31.d  // 01100101-11011111-01011111-11101111
// CHECK: fcmge   p15.d, p7/z, z31.d, z31.d // encoding: [0xef,0x5f,0xdf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011111-01011111-11101111
FCMGE   P15.D, P7/Z, Z31.D, Z31.D  // 01100101-11011111-01011111-11101111
// CHECK: fcmge   p15.d, p7/z, z31.d, z31.d // encoding: [0xef,0x5f,0xdf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011111-01011111-11101111
fcmge   p15.d, p7/z, z31.d, #0.0  // 01100101-11010000-00111111-11101111
// CHECK: fcmge   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xef,0x3f,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-00111111-11101111
FCMGE   P15.D, P7/Z, Z31.D, #0.0  // 01100101-11010000-00111111-11101111
// CHECK: fcmge   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xef,0x3f,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-00111111-11101111
fcmge   p5.d, p5/z, z10.d, z21.d  // 01100101-11010101-01010101-01000101
// CHECK: fcmge   p5.d, p5/z, z10.d, z21.d // encoding: [0x45,0x55,0xd5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010101-01010101-01000101
FCMGE   P5.D, P5/Z, Z10.D, Z21.D  // 01100101-11010101-01010101-01000101
// CHECK: fcmge   p5.d, p5/z, z10.d, z21.d // encoding: [0x45,0x55,0xd5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010101-01010101-01000101
fcmge   p5.d, p5/z, z10.d, #0.0  // 01100101-11010000-00110101-01000101
// CHECK: fcmge   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x45,0x35,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-00110101-01000101
FCMGE   P5.D, P5/Z, Z10.D, #0.0  // 01100101-11010000-00110101-01000101
// CHECK: fcmge   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x45,0x35,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-00110101-01000101
fcmge   p5.s, p5/z, z10.s, #0.0  // 01100101-10010000-00110101-01000101
// CHECK: fcmge   p5.s, p5/z, z10.s, #0.0{{0*}} // encoding: [0x45,0x35,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-00110101-01000101
FCMGE   P5.S, P5/Z, Z10.S, #0.0  // 01100101-10010000-00110101-01000101
// CHECK: fcmge   p5.s, p5/z, z10.s, #0.0{{0*}} // encoding: [0x45,0x35,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-00110101-01000101
fcmge   p7.h, p3/z, z13.h, z8.h  // 01100101-01001000-01001101-10100111
// CHECK: fcmge   p7.h, p3/z, z13.h, z8.h // encoding: [0xa7,0x4d,0x48,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001000-01001101-10100111
FCMGE   P7.H, P3/Z, Z13.H, Z8.H  // 01100101-01001000-01001101-10100111
// CHECK: fcmge   p7.h, p3/z, z13.h, z8.h // encoding: [0xa7,0x4d,0x48,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001000-01001101-10100111
fcmge   p7.s, p3/z, z13.s, z8.s  // 01100101-10001000-01001101-10100111
// CHECK: fcmge   p7.s, p3/z, z13.s, z8.s // encoding: [0xa7,0x4d,0x88,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001000-01001101-10100111
FCMGE   P7.S, P3/Z, Z13.S, Z8.S  // 01100101-10001000-01001101-10100111
// CHECK: fcmge   p7.s, p3/z, z13.s, z8.s // encoding: [0xa7,0x4d,0x88,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001000-01001101-10100111
fcmge   p15.h, p7/z, z31.h, #0.0  // 01100101-01010000-00111111-11101111
// CHECK: fcmge   p15.h, p7/z, z31.h, #0.0{{0*}} // encoding: [0xef,0x3f,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-00111111-11101111
FCMGE   P15.H, P7/Z, Z31.H, #0.0  // 01100101-01010000-00111111-11101111
// CHECK: fcmge   p15.h, p7/z, z31.h, #0.0{{0*}} // encoding: [0xef,0x3f,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-00111111-11101111
fcmge   p0.d, p0/z, z0.d, z0.d  // 01100101-11000000-01000000-00000000
// CHECK: fcmge   p0.d, p0/z, z0.d, z0.d // encoding: [0x00,0x40,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-01000000-00000000
FCMGE   P0.D, P0/Z, Z0.D, Z0.D  // 01100101-11000000-01000000-00000000
// CHECK: fcmge   p0.d, p0/z, z0.d, z0.d // encoding: [0x00,0x40,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-01000000-00000000
fcmge   p7.h, p3/z, z13.h, #0.0  // 01100101-01010000-00101101-10100111
// CHECK: fcmge   p7.h, p3/z, z13.h, #0.0{{0*}} // encoding: [0xa7,0x2d,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-00101101-10100111
FCMGE   P7.H, P3/Z, Z13.H, #0.0  // 01100101-01010000-00101101-10100111
// CHECK: fcmge   p7.h, p3/z, z13.h, #0.0{{0*}} // encoding: [0xa7,0x2d,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-00101101-10100111
fcmge   p0.s, p0/z, z0.s, #0.0  // 01100101-10010000-00100000-00000000
// CHECK: fcmge   p0.s, p0/z, z0.s, #0.0{{0*}} // encoding: [0x00,0x20,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-00100000-00000000
FCMGE   P0.S, P0/Z, Z0.S, #0.0  // 01100101-10010000-00100000-00000000
// CHECK: fcmge   p0.s, p0/z, z0.s, #0.0{{0*}} // encoding: [0x00,0x20,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-00100000-00000000
fcmge   p0.d, p0/z, z0.d, #0.0  // 01100101-11010000-00100000-00000000
// CHECK: fcmge   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x00,0x20,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-00100000-00000000
FCMGE   P0.D, P0/Z, Z0.D, #0.0  // 01100101-11010000-00100000-00000000
// CHECK: fcmge   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x00,0x20,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-00100000-00000000
fcmge   p5.h, p5/z, z10.h, z21.h  // 01100101-01010101-01010101-01000101
// CHECK: fcmge   p5.h, p5/z, z10.h, z21.h // encoding: [0x45,0x55,0x55,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010101-01010101-01000101
FCMGE   P5.H, P5/Z, Z10.H, Z21.H  // 01100101-01010101-01010101-01000101
// CHECK: fcmge   p5.h, p5/z, z10.h, z21.h // encoding: [0x45,0x55,0x55,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010101-01010101-01000101
fcmge   p15.s, p7/z, z31.s, #0.0  // 01100101-10010000-00111111-11101111
// CHECK: fcmge   p15.s, p7/z, z31.s, #0.0{{0*}} // encoding: [0xef,0x3f,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-00111111-11101111
FCMGE   P15.S, P7/Z, Z31.S, #0.0  // 01100101-10010000-00111111-11101111
// CHECK: fcmge   p15.s, p7/z, z31.s, #0.0{{0*}} // encoding: [0xef,0x3f,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-00111111-11101111
fcmge   p7.d, p3/z, z13.d, z8.d  // 01100101-11001000-01001101-10100111
// CHECK: fcmge   p7.d, p3/z, z13.d, z8.d // encoding: [0xa7,0x4d,0xc8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001000-01001101-10100111
FCMGE   P7.D, P3/Z, Z13.D, Z8.D  // 01100101-11001000-01001101-10100111
// CHECK: fcmge   p7.d, p3/z, z13.d, z8.d // encoding: [0xa7,0x4d,0xc8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001000-01001101-10100111
fcmge   p0.h, p0/z, z0.h, #0.0  // 01100101-01010000-00100000-00000000
// CHECK: fcmge   p0.h, p0/z, z0.h, #0.0{{0*}} // encoding: [0x00,0x20,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-00100000-00000000
FCMGE   P0.H, P0/Z, Z0.H, #0.0  // 01100101-01010000-00100000-00000000
// CHECK: fcmge   p0.h, p0/z, z0.h, #0.0{{0*}} // encoding: [0x00,0x20,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-00100000-00000000
fcmge   p15.s, p7/z, z31.s, z31.s  // 01100101-10011111-01011111-11101111
// CHECK: fcmge   p15.s, p7/z, z31.s, z31.s // encoding: [0xef,0x5f,0x9f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011111-01011111-11101111
FCMGE   P15.S, P7/Z, Z31.S, Z31.S  // 01100101-10011111-01011111-11101111
// CHECK: fcmge   p15.s, p7/z, z31.s, z31.s // encoding: [0xef,0x5f,0x9f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011111-01011111-11101111
fcmge   p7.s, p3/z, z13.s, #0.0  // 01100101-10010000-00101101-10100111
// CHECK: fcmge   p7.s, p3/z, z13.s, #0.0{{0*}} // encoding: [0xa7,0x2d,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-00101101-10100111
FCMGE   P7.S, P3/Z, Z13.S, #0.0  // 01100101-10010000-00101101-10100111
// CHECK: fcmge   p7.s, p3/z, z13.s, #0.0{{0*}} // encoding: [0xa7,0x2d,0x90,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010000-00101101-10100111
fcmge   p5.h, p5/z, z10.h, #0.0  // 01100101-01010000-00110101-01000101
// CHECK: fcmge   p5.h, p5/z, z10.h, #0.0{{0*}} // encoding: [0x45,0x35,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-00110101-01000101
FCMGE   P5.H, P5/Z, Z10.H, #0.0  // 01100101-01010000-00110101-01000101
// CHECK: fcmge   p5.h, p5/z, z10.h, #0.0{{0*}} // encoding: [0x45,0x35,0x50,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010000-00110101-01000101
fcmge   p5.s, p5/z, z10.s, z21.s  // 01100101-10010101-01010101-01000101
// CHECK: fcmge   p5.s, p5/z, z10.s, z21.s // encoding: [0x45,0x55,0x95,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010101-01010101-01000101
FCMGE   P5.S, P5/Z, Z10.S, Z21.S  // 01100101-10010101-01010101-01000101
// CHECK: fcmge   p5.s, p5/z, z10.s, z21.s // encoding: [0x45,0x55,0x95,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010101-01010101-01000101
fcmge   p7.d, p3/z, z13.d, #0.0  // 01100101-11010000-00101101-10100111
// CHECK: fcmge   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xa7,0x2d,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-00101101-10100111
FCMGE   P7.D, P3/Z, Z13.D, #0.0  // 01100101-11010000-00101101-10100111
// CHECK: fcmge   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xa7,0x2d,0xd0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010000-00101101-10100111
fcmge   p0.h, p0/z, z0.h, z0.h  // 01100101-01000000-01000000-00000000
// CHECK: fcmge   p0.h, p0/z, z0.h, z0.h // encoding: [0x00,0x40,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-01000000-00000000
FCMGE   P0.H, P0/Z, Z0.H, Z0.H  // 01100101-01000000-01000000-00000000
// CHECK: fcmge   p0.h, p0/z, z0.h, z0.h // encoding: [0x00,0x40,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-01000000-00000000
fcmge   p0.s, p0/z, z0.s, z0.s  // 01100101-10000000-01000000-00000000
// CHECK: fcmge   p0.s, p0/z, z0.s, z0.s // encoding: [0x00,0x40,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-01000000-00000000
FCMGE   P0.S, P0/Z, Z0.S, Z0.S  // 01100101-10000000-01000000-00000000
// CHECK: fcmge   p0.s, p0/z, z0.s, z0.s // encoding: [0x00,0x40,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-01000000-00000000
fcmge   p15.h, p7/z, z31.h, z31.h  // 01100101-01011111-01011111-11101111
// CHECK: fcmge   p15.h, p7/z, z31.h, z31.h // encoding: [0xef,0x5f,0x5f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011111-01011111-11101111
FCMGE   P15.H, P7/Z, Z31.H, Z31.H  // 01100101-01011111-01011111-11101111
// CHECK: fcmge   p15.h, p7/z, z31.h, z31.h // encoding: [0xef,0x5f,0x5f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011111-01011111-11101111
