// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
punpkhi p15.h, p15.b  // 00000101-00110001-01000001-11101111
// CHECK: punpkhi p15.h, p15.b // encoding: [0xef,0x41,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-01000001-11101111
PUNPKHI P15.H, P15.B  // 00000101-00110001-01000001-11101111
// CHECK: punpkhi p15.h, p15.b // encoding: [0xef,0x41,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-01000001-11101111
punpkhi p0.h, p0.b  // 00000101-00110001-01000000-00000000
// CHECK: punpkhi p0.h, p0.b // encoding: [0x00,0x40,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-01000000-00000000
PUNPKHI P0.H, P0.B  // 00000101-00110001-01000000-00000000
// CHECK: punpkhi p0.h, p0.b // encoding: [0x00,0x40,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-01000000-00000000
punpkhi p5.h, p10.b  // 00000101-00110001-01000001-01000101
// CHECK: punpkhi p5.h, p10.b // encoding: [0x45,0x41,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-01000001-01000101
PUNPKHI P5.H, P10.B  // 00000101-00110001-01000001-01000101
// CHECK: punpkhi p5.h, p10.b // encoding: [0x45,0x41,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-01000001-01000101
punpkhi p7.h, p13.b  // 00000101-00110001-01000001-10100111
// CHECK: punpkhi p7.h, p13.b // encoding: [0xa7,0x41,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-01000001-10100111
PUNPKHI P7.H, P13.B  // 00000101-00110001-01000001-10100111
// CHECK: punpkhi p7.h, p13.b // encoding: [0xa7,0x41,0x31,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110001-01000001-10100111
