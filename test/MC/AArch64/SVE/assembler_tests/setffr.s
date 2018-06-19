// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
setffr    // 00100101-00101100-10010000-00000000
// CHECK: setffr   // encoding: [0x00,0x90,0x2c,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00101100-10010000-00000000
SETFFR    // 00100101-00101100-10010000-00000000
// CHECK: setffr   // encoding: [0x00,0x90,0x2c,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00101100-10010000-00000000
