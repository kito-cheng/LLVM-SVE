// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
pfalse  p0.b  // 00100101-00011000-11100100-00000000
// CHECK: pfalse  p0.b // encoding: [0x00,0xe4,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11100100-00000000
PFALSE  P0.B  // 00100101-00011000-11100100-00000000
// CHECK: pfalse  p0.b // encoding: [0x00,0xe4,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11100100-00000000
pfalse  p7.b  // 00100101-00011000-11100100-00000111
// CHECK: pfalse  p7.b // encoding: [0x07,0xe4,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11100100-00000111
PFALSE  P7.B  // 00100101-00011000-11100100-00000111
// CHECK: pfalse  p7.b // encoding: [0x07,0xe4,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11100100-00000111
pfalse  p5.b  // 00100101-00011000-11100100-00000101
// CHECK: pfalse  p5.b // encoding: [0x05,0xe4,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11100100-00000101
PFALSE  P5.B  // 00100101-00011000-11100100-00000101
// CHECK: pfalse  p5.b // encoding: [0x05,0xe4,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11100100-00000101
pfalse  p15.b  // 00100101-00011000-11100100-00001111
// CHECK: pfalse  p15.b // encoding: [0x0f,0xe4,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11100100-00001111
PFALSE  P15.B  // 00100101-00011000-11100100-00001111
// CHECK: pfalse  p15.b // encoding: [0x0f,0xe4,0x18,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00011000-11100100-00001111
