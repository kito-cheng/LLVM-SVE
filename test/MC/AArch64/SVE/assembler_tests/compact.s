// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
compact z0.d, p0, z0.d  // 00000101-11100001-10000000-00000000
// CHECK: compact z0.d, p0, z0.d // encoding: [0x00,0x80,0xe1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100001-10000000-00000000
COMPACT Z0.D, P0, Z0.D  // 00000101-11100001-10000000-00000000
// CHECK: compact z0.d, p0, z0.d // encoding: [0x00,0x80,0xe1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100001-10000000-00000000
compact z31.s, p7, z31.s  // 00000101-10100001-10011111-11111111
// CHECK: compact z31.s, p7, z31.s // encoding: [0xff,0x9f,0xa1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100001-10011111-11111111
COMPACT Z31.S, P7, Z31.S  // 00000101-10100001-10011111-11111111
// CHECK: compact z31.s, p7, z31.s // encoding: [0xff,0x9f,0xa1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100001-10011111-11111111
compact z23.d, p3, z13.d  // 00000101-11100001-10001101-10110111
// CHECK: compact z23.d, p3, z13.d // encoding: [0xb7,0x8d,0xe1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100001-10001101-10110111
COMPACT Z23.D, P3, Z13.D  // 00000101-11100001-10001101-10110111
// CHECK: compact z23.d, p3, z13.d // encoding: [0xb7,0x8d,0xe1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100001-10001101-10110111
compact z21.d, p5, z10.d  // 00000101-11100001-10010101-01010101
// CHECK: compact z21.d, p5, z10.d // encoding: [0x55,0x95,0xe1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100001-10010101-01010101
COMPACT Z21.D, P5, Z10.D  // 00000101-11100001-10010101-01010101
// CHECK: compact z21.d, p5, z10.d // encoding: [0x55,0x95,0xe1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100001-10010101-01010101
compact z0.s, p0, z0.s  // 00000101-10100001-10000000-00000000
// CHECK: compact z0.s, p0, z0.s // encoding: [0x00,0x80,0xa1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100001-10000000-00000000
COMPACT Z0.S, P0, Z0.S  // 00000101-10100001-10000000-00000000
// CHECK: compact z0.s, p0, z0.s // encoding: [0x00,0x80,0xa1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100001-10000000-00000000
compact z23.s, p3, z13.s  // 00000101-10100001-10001101-10110111
// CHECK: compact z23.s, p3, z13.s // encoding: [0xb7,0x8d,0xa1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100001-10001101-10110111
COMPACT Z23.S, P3, Z13.S  // 00000101-10100001-10001101-10110111
// CHECK: compact z23.s, p3, z13.s // encoding: [0xb7,0x8d,0xa1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100001-10001101-10110111
compact z21.s, p5, z10.s  // 00000101-10100001-10010101-01010101
// CHECK: compact z21.s, p5, z10.s // encoding: [0x55,0x95,0xa1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100001-10010101-01010101
COMPACT Z21.S, P5, Z10.S  // 00000101-10100001-10010101-01010101
// CHECK: compact z21.s, p5, z10.s // encoding: [0x55,0x95,0xa1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100001-10010101-01010101
compact z31.d, p7, z31.d  // 00000101-11100001-10011111-11111111
// CHECK: compact z31.d, p7, z31.d // encoding: [0xff,0x9f,0xe1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100001-10011111-11111111
COMPACT Z31.D, P7, Z31.D  // 00000101-11100001-10011111-11111111
// CHECK: compact z31.d, p7, z31.d // encoding: [0xff,0x9f,0xe1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100001-10011111-11111111
