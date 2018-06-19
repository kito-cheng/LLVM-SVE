// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ext     z0.b, z0.b, z0.b, #0  // 00000101-00100000-00000000-00000000
// CHECK: ext     z0.b, z0.b, z0.b, #0 // encoding: [0x00,0x00,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00000000-00000000
EXT     Z0.B, Z0.B, Z0.B, #0  // 00000101-00100000-00000000-00000000
// CHECK: ext     z0.b, z0.b, z0.b, #0 // encoding: [0x00,0x00,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00000000-00000000
ext     z31.b, z31.b, z31.b, #255  // 00000101-00111111-00011111-11111111
// CHECK: ext     z31.b, z31.b, z31.b, #255 // encoding: [0xff,0x1f,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00111111-00011111-11111111
EXT     Z31.B, Z31.B, Z31.B, #255  // 00000101-00111111-00011111-11111111
// CHECK: ext     z31.b, z31.b, z31.b, #255 // encoding: [0xff,0x1f,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00111111-00011111-11111111
ext     z21.b, z21.b, z10.b, #173  // 00000101-00110101-00010101-01010101
// CHECK: ext     z21.b, z21.b, z10.b, #173 // encoding: [0x55,0x15,0x35,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110101-00010101-01010101
EXT     Z21.B, Z21.B, Z10.B, #173  // 00000101-00110101-00010101-01010101
// CHECK: ext     z21.b, z21.b, z10.b, #173 // encoding: [0x55,0x15,0x35,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110101-00010101-01010101
ext     z23.b, z23.b, z13.b, #67  // 00000101-00101000-00001101-10110111
// CHECK: ext     z23.b, z23.b, z13.b, #67 // encoding: [0xb7,0x0d,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-00001101-10110111
EXT     Z23.B, Z23.B, Z13.B, #67  // 00000101-00101000-00001101-10110111
// CHECK: ext     z23.b, z23.b, z13.b, #67 // encoding: [0xb7,0x0d,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-00001101-10110111
