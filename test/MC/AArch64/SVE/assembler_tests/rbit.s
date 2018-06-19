// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
rbit    z31.h, p7/m, z31.h  // 00000101-01100111-10011111-11111111
// CHECK: rbit    z31.h, p7/m, z31.h // encoding: [0xff,0x9f,0x67,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100111-10011111-11111111
RBIT    Z31.H, P7/M, Z31.H  // 00000101-01100111-10011111-11111111
// CHECK: rbit    z31.h, p7/m, z31.h // encoding: [0xff,0x9f,0x67,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100111-10011111-11111111
rbit    z31.s, p7/m, z31.s  // 00000101-10100111-10011111-11111111
// CHECK: rbit    z31.s, p7/m, z31.s // encoding: [0xff,0x9f,0xa7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100111-10011111-11111111
RBIT    Z31.S, P7/M, Z31.S  // 00000101-10100111-10011111-11111111
// CHECK: rbit    z31.s, p7/m, z31.s // encoding: [0xff,0x9f,0xa7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100111-10011111-11111111
rbit    z21.h, p5/m, z10.h  // 00000101-01100111-10010101-01010101
// CHECK: rbit    z21.h, p5/m, z10.h // encoding: [0x55,0x95,0x67,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100111-10010101-01010101
RBIT    Z21.H, P5/M, Z10.H  // 00000101-01100111-10010101-01010101
// CHECK: rbit    z21.h, p5/m, z10.h // encoding: [0x55,0x95,0x67,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100111-10010101-01010101
rbit    z23.h, p3/m, z13.h  // 00000101-01100111-10001101-10110111
// CHECK: rbit    z23.h, p3/m, z13.h // encoding: [0xb7,0x8d,0x67,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100111-10001101-10110111
RBIT    Z23.H, P3/M, Z13.H  // 00000101-01100111-10001101-10110111
// CHECK: rbit    z23.h, p3/m, z13.h // encoding: [0xb7,0x8d,0x67,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100111-10001101-10110111
rbit    z31.d, p7/m, z31.d  // 00000101-11100111-10011111-11111111
// CHECK: rbit    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100111-10011111-11111111
RBIT    Z31.D, P7/M, Z31.D  // 00000101-11100111-10011111-11111111
// CHECK: rbit    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100111-10011111-11111111
rbit    z23.d, p3/m, z13.d  // 00000101-11100111-10001101-10110111
// CHECK: rbit    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100111-10001101-10110111
RBIT    Z23.D, P3/M, Z13.D  // 00000101-11100111-10001101-10110111
// CHECK: rbit    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100111-10001101-10110111
rbit    z21.b, p5/m, z10.b  // 00000101-00100111-10010101-01010101
// CHECK: rbit    z21.b, p5/m, z10.b // encoding: [0x55,0x95,0x27,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100111-10010101-01010101
RBIT    Z21.B, P5/M, Z10.B  // 00000101-00100111-10010101-01010101
// CHECK: rbit    z21.b, p5/m, z10.b // encoding: [0x55,0x95,0x27,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100111-10010101-01010101
rbit    z23.s, p3/m, z13.s  // 00000101-10100111-10001101-10110111
// CHECK: rbit    z23.s, p3/m, z13.s // encoding: [0xb7,0x8d,0xa7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100111-10001101-10110111
RBIT    Z23.S, P3/M, Z13.S  // 00000101-10100111-10001101-10110111
// CHECK: rbit    z23.s, p3/m, z13.s // encoding: [0xb7,0x8d,0xa7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100111-10001101-10110111
rbit    z0.d, p0/m, z0.d  // 00000101-11100111-10000000-00000000
// CHECK: rbit    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100111-10000000-00000000
RBIT    Z0.D, P0/M, Z0.D  // 00000101-11100111-10000000-00000000
// CHECK: rbit    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100111-10000000-00000000
rbit    z0.h, p0/m, z0.h  // 00000101-01100111-10000000-00000000
// CHECK: rbit    z0.h, p0/m, z0.h // encoding: [0x00,0x80,0x67,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100111-10000000-00000000
RBIT    Z0.H, P0/M, Z0.H  // 00000101-01100111-10000000-00000000
// CHECK: rbit    z0.h, p0/m, z0.h // encoding: [0x00,0x80,0x67,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100111-10000000-00000000
rbit    z0.b, p0/m, z0.b  // 00000101-00100111-10000000-00000000
// CHECK: rbit    z0.b, p0/m, z0.b // encoding: [0x00,0x80,0x27,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100111-10000000-00000000
RBIT    Z0.B, P0/M, Z0.B  // 00000101-00100111-10000000-00000000
// CHECK: rbit    z0.b, p0/m, z0.b // encoding: [0x00,0x80,0x27,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100111-10000000-00000000
rbit    z31.b, p7/m, z31.b  // 00000101-00100111-10011111-11111111
// CHECK: rbit    z31.b, p7/m, z31.b // encoding: [0xff,0x9f,0x27,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100111-10011111-11111111
RBIT    Z31.B, P7/M, Z31.B  // 00000101-00100111-10011111-11111111
// CHECK: rbit    z31.b, p7/m, z31.b // encoding: [0xff,0x9f,0x27,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100111-10011111-11111111
rbit    z21.s, p5/m, z10.s  // 00000101-10100111-10010101-01010101
// CHECK: rbit    z21.s, p5/m, z10.s // encoding: [0x55,0x95,0xa7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100111-10010101-01010101
RBIT    Z21.S, P5/M, Z10.S  // 00000101-10100111-10010101-01010101
// CHECK: rbit    z21.s, p5/m, z10.s // encoding: [0x55,0x95,0xa7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100111-10010101-01010101
rbit    z23.b, p3/m, z13.b  // 00000101-00100111-10001101-10110111
// CHECK: rbit    z23.b, p3/m, z13.b // encoding: [0xb7,0x8d,0x27,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100111-10001101-10110111
RBIT    Z23.B, P3/M, Z13.B  // 00000101-00100111-10001101-10110111
// CHECK: rbit    z23.b, p3/m, z13.b // encoding: [0xb7,0x8d,0x27,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100111-10001101-10110111
rbit    z21.d, p5/m, z10.d  // 00000101-11100111-10010101-01010101
// CHECK: rbit    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100111-10010101-01010101
RBIT    Z21.D, P5/M, Z10.D  // 00000101-11100111-10010101-01010101
// CHECK: rbit    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100111-10010101-01010101
rbit    z0.s, p0/m, z0.s  // 00000101-10100111-10000000-00000000
// CHECK: rbit    z0.s, p0/m, z0.s // encoding: [0x00,0x80,0xa7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100111-10000000-00000000
RBIT    Z0.S, P0/M, Z0.S  // 00000101-10100111-10000000-00000000
// CHECK: rbit    z0.s, p0/m, z0.s // encoding: [0x00,0x80,0xa7,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100111-10000000-00000000
