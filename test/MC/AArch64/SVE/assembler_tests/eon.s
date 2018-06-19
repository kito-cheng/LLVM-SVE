// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
eon     z23.h, z23.h, #0x6  // 00000101-01000000-11101101-10110111
// CHECK: eor     z23.h, z23.h, #0xfff9 // encoding: [0xb7,0x6d,0x40,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01000000-11101101-10110111
EON     Z23.H, Z23.H, #0x6  // 00000101-01000000-11101101-10110111
// CHECK: eor     z23.h, z23.h, #0xfff9 // encoding: [0xb7,0x6d,0x40,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01000000-11101101-10110111
eon     z5.b, z5.b, #0x7e  // 00000101-01000000-00001110-00100101
// CHECK: eor     z5.b, z5.b, #0x81 // encoding: [0x25,0x0e,0x40,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01000000-00001110-00100101
EON     Z5.B, Z5.B, #0x7E  // 00000101-01000000-00001110-00100101
// CHECK: eor     z5.b, z5.b, #0x81 // encoding: [0x25,0x0e,0x40,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01000000-00001110-00100101
eon     z21.h, z21.h, #0x3e  // 00000101-01000001-01010101-01010101
// CHECK: eor     z21.h, z21.h, #0xffc1 // encoding: [0x55,0x55,0x40,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01000001-01010101-01010101
EON     Z21.H, Z21.H, #0x3E  // 00000101-01000001-01010101-01010101
// CHECK: eor     z21.h, z21.h, #0xffc1 // encoding: [0x55,0x55,0x40,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01000001-01010101-01010101
eon     z0.s, z0.s, #0xfffffffe  // 00000101-01000000-00000000-00000000
// CHECK: eor     z0.s, z0.s, #0x1 // encoding: [0x00,0x00,0x40,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01000000-00000000-00000000
EON     Z0.S, Z0.S, #0xFFFFFFFE  // 00000101-01000000-00000000-00000000
// CHECK: eor     z0.s, z0.s, #0x1 // encoding: [0x00,0x00,0x40,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01000000-00000000-00000000
