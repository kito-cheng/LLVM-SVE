// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
wrffr   p10.b  // 00100101-00101000-10010001-01000000
// CHECK: wrffr   p10.b // encoding: [0x40,0x91,0x28,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00101000-10010001-01000000
WRFFR   P10.B  // 00100101-00101000-10010001-01000000
// CHECK: wrffr   p10.b // encoding: [0x40,0x91,0x28,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00101000-10010001-01000000
wrffr   p15.b  // 00100101-00101000-10010001-11100000
// CHECK: wrffr   p15.b // encoding: [0xe0,0x91,0x28,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00101000-10010001-11100000
WRFFR   P15.B  // 00100101-00101000-10010001-11100000
// CHECK: wrffr   p15.b // encoding: [0xe0,0x91,0x28,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00101000-10010001-11100000
wrffr   p13.b  // 00100101-00101000-10010001-10100000
// CHECK: wrffr   p13.b // encoding: [0xa0,0x91,0x28,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00101000-10010001-10100000
WRFFR   P13.B  // 00100101-00101000-10010001-10100000
// CHECK: wrffr   p13.b // encoding: [0xa0,0x91,0x28,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00101000-10010001-10100000
wrffr   p0.b  // 00100101-00101000-10010000-00000000
// CHECK: wrffr   p0.b // encoding: [0x00,0x90,0x28,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00101000-10010000-00000000
WRFFR   P0.B  // 00100101-00101000-10010000-00000000
// CHECK: wrffr   p0.b // encoding: [0x00,0x90,0x28,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00101000-10010000-00000000
