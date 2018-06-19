// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
frecps  z0.h, z0.h, z0.h  // 01100101-01000000-00011000-00000000
// CHECK: frecps  z0.h, z0.h, z0.h // encoding: [0x00,0x18,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00011000-00000000
FRECPS  Z0.H, Z0.H, Z0.H  // 01100101-01000000-00011000-00000000
// CHECK: frecps  z0.h, z0.h, z0.h // encoding: [0x00,0x18,0x40,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000000-00011000-00000000
frecps  z21.h, z10.h, z21.h  // 01100101-01010101-00011001-01010101
// CHECK: frecps  z21.h, z10.h, z21.h // encoding: [0x55,0x19,0x55,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010101-00011001-01010101
FRECPS  Z21.H, Z10.H, Z21.H  // 01100101-01010101-00011001-01010101
// CHECK: frecps  z21.h, z10.h, z21.h // encoding: [0x55,0x19,0x55,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01010101-00011001-01010101
frecps  z21.s, z10.s, z21.s  // 01100101-10010101-00011001-01010101
// CHECK: frecps  z21.s, z10.s, z21.s // encoding: [0x55,0x19,0x95,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010101-00011001-01010101
FRECPS  Z21.S, Z10.S, Z21.S  // 01100101-10010101-00011001-01010101
// CHECK: frecps  z21.s, z10.s, z21.s // encoding: [0x55,0x19,0x95,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10010101-00011001-01010101
frecps  z23.d, z13.d, z8.d  // 01100101-11001000-00011001-10110111
// CHECK: frecps  z23.d, z13.d, z8.d // encoding: [0xb7,0x19,0xc8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001000-00011001-10110111
FRECPS  Z23.D, Z13.D, Z8.D  // 01100101-11001000-00011001-10110111
// CHECK: frecps  z23.d, z13.d, z8.d // encoding: [0xb7,0x19,0xc8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001000-00011001-10110111
frecps  z31.s, z31.s, z31.s  // 01100101-10011111-00011011-11111111
// CHECK: frecps  z31.s, z31.s, z31.s // encoding: [0xff,0x1b,0x9f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011111-00011011-11111111
FRECPS  Z31.S, Z31.S, Z31.S  // 01100101-10011111-00011011-11111111
// CHECK: frecps  z31.s, z31.s, z31.s // encoding: [0xff,0x1b,0x9f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10011111-00011011-11111111
frecps  z31.d, z31.d, z31.d  // 01100101-11011111-00011011-11111111
// CHECK: frecps  z31.d, z31.d, z31.d // encoding: [0xff,0x1b,0xdf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011111-00011011-11111111
FRECPS  Z31.D, Z31.D, Z31.D  // 01100101-11011111-00011011-11111111
// CHECK: frecps  z31.d, z31.d, z31.d // encoding: [0xff,0x1b,0xdf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11011111-00011011-11111111
frecps  z0.d, z0.d, z0.d  // 01100101-11000000-00011000-00000000
// CHECK: frecps  z0.d, z0.d, z0.d // encoding: [0x00,0x18,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00011000-00000000
FRECPS  Z0.D, Z0.D, Z0.D  // 01100101-11000000-00011000-00000000
// CHECK: frecps  z0.d, z0.d, z0.d // encoding: [0x00,0x18,0xc0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000000-00011000-00000000
frecps  z23.s, z13.s, z8.s  // 01100101-10001000-00011001-10110111
// CHECK: frecps  z23.s, z13.s, z8.s // encoding: [0xb7,0x19,0x88,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001000-00011001-10110111
FRECPS  Z23.S, Z13.S, Z8.S  // 01100101-10001000-00011001-10110111
// CHECK: frecps  z23.s, z13.s, z8.s // encoding: [0xb7,0x19,0x88,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001000-00011001-10110111
frecps  z23.h, z13.h, z8.h  // 01100101-01001000-00011001-10110111
// CHECK: frecps  z23.h, z13.h, z8.h // encoding: [0xb7,0x19,0x48,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001000-00011001-10110111
FRECPS  Z23.H, Z13.H, Z8.H  // 01100101-01001000-00011001-10110111
// CHECK: frecps  z23.h, z13.h, z8.h // encoding: [0xb7,0x19,0x48,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001000-00011001-10110111
frecps  z31.h, z31.h, z31.h  // 01100101-01011111-00011011-11111111
// CHECK: frecps  z31.h, z31.h, z31.h // encoding: [0xff,0x1b,0x5f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011111-00011011-11111111
FRECPS  Z31.H, Z31.H, Z31.H  // 01100101-01011111-00011011-11111111
// CHECK: frecps  z31.h, z31.h, z31.h // encoding: [0xff,0x1b,0x5f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01011111-00011011-11111111
frecps  z0.s, z0.s, z0.s  // 01100101-10000000-00011000-00000000
// CHECK: frecps  z0.s, z0.s, z0.s // encoding: [0x00,0x18,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00011000-00000000
FRECPS  Z0.S, Z0.S, Z0.S  // 01100101-10000000-00011000-00000000
// CHECK: frecps  z0.s, z0.s, z0.s // encoding: [0x00,0x18,0x80,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000000-00011000-00000000
frecps  z21.d, z10.d, z21.d  // 01100101-11010101-00011001-01010101
// CHECK: frecps  z21.d, z10.d, z21.d // encoding: [0x55,0x19,0xd5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010101-00011001-01010101
FRECPS  Z21.D, Z10.D, Z21.D  // 01100101-11010101-00011001-01010101
// CHECK: frecps  z21.d, z10.d, z21.d // encoding: [0x55,0x19,0xd5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11010101-00011001-01010101
