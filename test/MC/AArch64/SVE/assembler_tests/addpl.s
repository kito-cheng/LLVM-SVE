// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
addpl   x21, x21, #-22  // 00000100-01110101-01010101-01010101
// CHECK: addpl   x21, x21, #-22 // encoding: [0x55,0x55,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-01010101-01010101
ADDPL   X21, X21, #-22  // 00000100-01110101-01010101-01010101
// CHECK: addpl   x21, x21, #-22 // encoding: [0x55,0x55,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-01010101-01010101
addpl   x23, x8, #-19  // 00000100-01101000-01010101-10110111
// CHECK: addpl   x23, x8, #-19 // encoding: [0xb7,0x55,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-01010101-10110111
ADDPL   X23, X8, #-19  // 00000100-01101000-01010101-10110111
// CHECK: addpl   x23, x8, #-19 // encoding: [0xb7,0x55,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-01010101-10110111
addpl   sp, sp, #-1  // 00000100-01111111-01010111-11111111
// CHECK: addpl   sp, sp, #-1 // encoding: [0xff,0x57,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-01010111-11111111
ADDPL   SP, SP, #-1  // 00000100-01111111-01010111-11111111
// CHECK: addpl   sp, sp, #-1 // encoding: [0xff,0x57,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-01010111-11111111
addpl   x0, x0, #0  // 00000100-01100000-01010000-00000000
// CHECK: addpl   x0, x0, #0 // encoding: [0x00,0x50,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-01010000-00000000
ADDPL   X0, X0, #0  // 00000100-01100000-01010000-00000000
// CHECK: addpl   x0, x0, #0 // encoding: [0x00,0x50,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-01010000-00000000
