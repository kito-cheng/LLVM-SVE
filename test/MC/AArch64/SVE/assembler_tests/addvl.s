// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
addvl   x21, x21, #-22  // 00000100-00110101-01010101-01010101
// CHECK: addvl   x21, x21, #-22 // encoding: [0x55,0x55,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-01010101-01010101
ADDVL   X21, X21, #-22  // 00000100-00110101-01010101-01010101
// CHECK: addvl   x21, x21, #-22 // encoding: [0x55,0x55,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-01010101-01010101
addvl   x23, x8, #-19  // 00000100-00101000-01010101-10110111
// CHECK: addvl   x23, x8, #-19 // encoding: [0xb7,0x55,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-01010101-10110111
ADDVL   X23, X8, #-19  // 00000100-00101000-01010101-10110111
// CHECK: addvl   x23, x8, #-19 // encoding: [0xb7,0x55,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-01010101-10110111
addvl   sp, sp, #-1  // 00000100-00111111-01010111-11111111
// CHECK: addvl   sp, sp, #-1 // encoding: [0xff,0x57,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-01010111-11111111
ADDVL   SP, SP, #-1  // 00000100-00111111-01010111-11111111
// CHECK: addvl   sp, sp, #-1 // encoding: [0xff,0x57,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-01010111-11111111
addvl   x0, x0, #0  // 00000100-00100000-01010000-00000000
// CHECK: addvl   x0, x0, #0 // encoding: [0x00,0x50,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-01010000-00000000
ADDVL   X0, X0, #0  // 00000100-00100000-01010000-00000000
// CHECK: addvl   x0, x0, #0 // encoding: [0x00,0x50,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-01010000-00000000
