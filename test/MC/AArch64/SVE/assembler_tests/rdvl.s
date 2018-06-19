// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
rdvl    x0, #0  // 00000100-10111111-01010000-00000000
// CHECK: rdvl    x0, #0 // encoding: [0x00,0x50,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-01010000-00000000
RDVL    X0, #0  // 00000100-10111111-01010000-00000000
// CHECK: rdvl    x0, #0 // encoding: [0x00,0x50,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-01010000-00000000
rdvl    x21, #-22  // 00000100-10111111-01010101-01010101
// CHECK: rdvl    x21, #-22 // encoding: [0x55,0x55,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-01010101-01010101
RDVL    X21, #-22  // 00000100-10111111-01010101-01010101
// CHECK: rdvl    x21, #-22 // encoding: [0x55,0x55,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-01010101-01010101
rdvl    xzr, #-1  // 00000100-10111111-01010111-11111111
// CHECK: rdvl    xzr, #-1 // encoding: [0xff,0x57,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-01010111-11111111
RDVL    XZR, #-1  // 00000100-10111111-01010111-11111111
// CHECK: rdvl    xzr, #-1 // encoding: [0xff,0x57,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-01010111-11111111
rdvl    x23, #-19  // 00000100-10111111-01010101-10110111
// CHECK: rdvl    x23, #-19 // encoding: [0xb7,0x55,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-01010101-10110111
RDVL    X23, #-19  // 00000100-10111111-01010101-10110111
// CHECK: rdvl    x23, #-19 // encoding: [0xb7,0x55,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-01010101-10110111
