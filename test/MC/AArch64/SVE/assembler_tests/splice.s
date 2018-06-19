// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
splice  z23.b, p3, z23.b, z13.b  // 00000101-00101100-10001101-10110111
// CHECK: splice  z23.b, p3, z23.b, z13.b // encoding: [0xb7,0x8d,0x2c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101100-10001101-10110111
SPLICE  Z23.B, P3, Z23.B, Z13.B  // 00000101-00101100-10001101-10110111
// CHECK: splice  z23.b, p3, z23.b, z13.b // encoding: [0xb7,0x8d,0x2c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101100-10001101-10110111
splice  z21.d, p5, z21.d, z10.d  // 00000101-11101100-10010101-01010101
// CHECK: splice  z21.d, p5, z21.d, z10.d // encoding: [0x55,0x95,0xec,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101100-10010101-01010101
SPLICE  Z21.D, P5, Z21.D, Z10.D  // 00000101-11101100-10010101-01010101
// CHECK: splice  z21.d, p5, z21.d, z10.d // encoding: [0x55,0x95,0xec,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101100-10010101-01010101
splice  z0.b, p0, z0.b, z0.b  // 00000101-00101100-10000000-00000000
// CHECK: splice  z0.b, p0, z0.b, z0.b // encoding: [0x00,0x80,0x2c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101100-10000000-00000000
SPLICE  Z0.B, P0, Z0.B, Z0.B  // 00000101-00101100-10000000-00000000
// CHECK: splice  z0.b, p0, z0.b, z0.b // encoding: [0x00,0x80,0x2c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101100-10000000-00000000
splice  z31.d, p7, z31.d, z31.d  // 00000101-11101100-10011111-11111111
// CHECK: splice  z31.d, p7, z31.d, z31.d // encoding: [0xff,0x9f,0xec,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101100-10011111-11111111
SPLICE  Z31.D, P7, Z31.D, Z31.D  // 00000101-11101100-10011111-11111111
// CHECK: splice  z31.d, p7, z31.d, z31.d // encoding: [0xff,0x9f,0xec,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101100-10011111-11111111
splice  z23.s, p3, z23.s, z13.s  // 00000101-10101100-10001101-10110111
// CHECK: splice  z23.s, p3, z23.s, z13.s // encoding: [0xb7,0x8d,0xac,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101100-10001101-10110111
SPLICE  Z23.S, P3, Z23.S, Z13.S  // 00000101-10101100-10001101-10110111
// CHECK: splice  z23.s, p3, z23.s, z13.s // encoding: [0xb7,0x8d,0xac,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101100-10001101-10110111
splice  z0.d, p0, z0.d, z0.d  // 00000101-11101100-10000000-00000000
// CHECK: splice  z0.d, p0, z0.d, z0.d // encoding: [0x00,0x80,0xec,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101100-10000000-00000000
SPLICE  Z0.D, P0, Z0.D, Z0.D  // 00000101-11101100-10000000-00000000
// CHECK: splice  z0.d, p0, z0.d, z0.d // encoding: [0x00,0x80,0xec,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101100-10000000-00000000
splice  z31.b, p7, z31.b, z31.b  // 00000101-00101100-10011111-11111111
// CHECK: splice  z31.b, p7, z31.b, z31.b // encoding: [0xff,0x9f,0x2c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101100-10011111-11111111
SPLICE  Z31.B, P7, Z31.B, Z31.B  // 00000101-00101100-10011111-11111111
// CHECK: splice  z31.b, p7, z31.b, z31.b // encoding: [0xff,0x9f,0x2c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101100-10011111-11111111
splice  z0.h, p0, z0.h, z0.h  // 00000101-01101100-10000000-00000000
// CHECK: splice  z0.h, p0, z0.h, z0.h // encoding: [0x00,0x80,0x6c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101100-10000000-00000000
SPLICE  Z0.H, P0, Z0.H, Z0.H  // 00000101-01101100-10000000-00000000
// CHECK: splice  z0.h, p0, z0.h, z0.h // encoding: [0x00,0x80,0x6c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101100-10000000-00000000
splice  z21.s, p5, z21.s, z10.s  // 00000101-10101100-10010101-01010101
// CHECK: splice  z21.s, p5, z21.s, z10.s // encoding: [0x55,0x95,0xac,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101100-10010101-01010101
SPLICE  Z21.S, P5, Z21.S, Z10.S  // 00000101-10101100-10010101-01010101
// CHECK: splice  z21.s, p5, z21.s, z10.s // encoding: [0x55,0x95,0xac,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101100-10010101-01010101
splice  z31.s, p7, z31.s, z31.s  // 00000101-10101100-10011111-11111111
// CHECK: splice  z31.s, p7, z31.s, z31.s // encoding: [0xff,0x9f,0xac,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101100-10011111-11111111
SPLICE  Z31.S, P7, Z31.S, Z31.S  // 00000101-10101100-10011111-11111111
// CHECK: splice  z31.s, p7, z31.s, z31.s // encoding: [0xff,0x9f,0xac,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101100-10011111-11111111
splice  z21.b, p5, z21.b, z10.b  // 00000101-00101100-10010101-01010101
// CHECK: splice  z21.b, p5, z21.b, z10.b // encoding: [0x55,0x95,0x2c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101100-10010101-01010101
SPLICE  Z21.B, P5, Z21.B, Z10.B  // 00000101-00101100-10010101-01010101
// CHECK: splice  z21.b, p5, z21.b, z10.b // encoding: [0x55,0x95,0x2c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101100-10010101-01010101
splice  z0.s, p0, z0.s, z0.s  // 00000101-10101100-10000000-00000000
// CHECK: splice  z0.s, p0, z0.s, z0.s // encoding: [0x00,0x80,0xac,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101100-10000000-00000000
SPLICE  Z0.S, P0, Z0.S, Z0.S  // 00000101-10101100-10000000-00000000
// CHECK: splice  z0.s, p0, z0.s, z0.s // encoding: [0x00,0x80,0xac,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101100-10000000-00000000
splice  z23.h, p3, z23.h, z13.h  // 00000101-01101100-10001101-10110111
// CHECK: splice  z23.h, p3, z23.h, z13.h // encoding: [0xb7,0x8d,0x6c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101100-10001101-10110111
SPLICE  Z23.H, P3, Z23.H, Z13.H  // 00000101-01101100-10001101-10110111
// CHECK: splice  z23.h, p3, z23.h, z13.h // encoding: [0xb7,0x8d,0x6c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101100-10001101-10110111
splice  z21.h, p5, z21.h, z10.h  // 00000101-01101100-10010101-01010101
// CHECK: splice  z21.h, p5, z21.h, z10.h // encoding: [0x55,0x95,0x6c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101100-10010101-01010101
SPLICE  Z21.H, P5, Z21.H, Z10.H  // 00000101-01101100-10010101-01010101
// CHECK: splice  z21.h, p5, z21.h, z10.h // encoding: [0x55,0x95,0x6c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101100-10010101-01010101
splice  z31.h, p7, z31.h, z31.h  // 00000101-01101100-10011111-11111111
// CHECK: splice  z31.h, p7, z31.h, z31.h // encoding: [0xff,0x9f,0x6c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101100-10011111-11111111
SPLICE  Z31.H, P7, Z31.H, Z31.H  // 00000101-01101100-10011111-11111111
// CHECK: splice  z31.h, p7, z31.h, z31.h // encoding: [0xff,0x9f,0x6c,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101100-10011111-11111111
splice  z23.d, p3, z23.d, z13.d  // 00000101-11101100-10001101-10110111
// CHECK: splice  z23.d, p3, z23.d, z13.d // encoding: [0xb7,0x8d,0xec,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101100-10001101-10110111
SPLICE  Z23.D, P3, Z23.D, Z13.D  // 00000101-11101100-10001101-10110111
// CHECK: splice  z23.d, p3, z23.d, z13.d // encoding: [0xb7,0x8d,0xec,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101100-10001101-10110111
