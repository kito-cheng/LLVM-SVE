// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sxtb    z23.h, p3/m, z13.h  // 00000100-01010000-10101101-10110111
// CHECK: sxtb    z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-10101101-10110111
SXTB    Z23.H, P3/M, Z13.H  // 00000100-01010000-10101101-10110111
// CHECK: sxtb    z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-10101101-10110111
sxtb    z31.h, p7/m, z31.h  // 00000100-01010000-10111111-11111111
// CHECK: sxtb    z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-10111111-11111111
SXTB    Z31.H, P7/M, Z31.H  // 00000100-01010000-10111111-11111111
// CHECK: sxtb    z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-10111111-11111111
sxtb    z21.d, p5/m, z10.d  // 00000100-11010000-10110101-01010101
// CHECK: sxtb    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-10110101-01010101
SXTB    Z21.D, P5/M, Z10.D  // 00000100-11010000-10110101-01010101
// CHECK: sxtb    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-10110101-01010101
sxtb    z21.h, p5/m, z10.h  // 00000100-01010000-10110101-01010101
// CHECK: sxtb    z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-10110101-01010101
SXTB    Z21.H, P5/M, Z10.H  // 00000100-01010000-10110101-01010101
// CHECK: sxtb    z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-10110101-01010101
sxtb    z31.s, p7/m, z31.s  // 00000100-10010000-10111111-11111111
// CHECK: sxtb    z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-10111111-11111111
SXTB    Z31.S, P7/M, Z31.S  // 00000100-10010000-10111111-11111111
// CHECK: sxtb    z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-10111111-11111111
sxtb    z0.s, p0/m, z0.s  // 00000100-10010000-10100000-00000000
// CHECK: sxtb    z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-10100000-00000000
SXTB    Z0.S, P0/M, Z0.S  // 00000100-10010000-10100000-00000000
// CHECK: sxtb    z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-10100000-00000000
sxtb    z0.h, p0/m, z0.h  // 00000100-01010000-10100000-00000000
// CHECK: sxtb    z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-10100000-00000000
SXTB    Z0.H, P0/M, Z0.H  // 00000100-01010000-10100000-00000000
// CHECK: sxtb    z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-10100000-00000000
sxtb    z23.d, p3/m, z13.d  // 00000100-11010000-10101101-10110111
// CHECK: sxtb    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-10101101-10110111
SXTB    Z23.D, P3/M, Z13.D  // 00000100-11010000-10101101-10110111
// CHECK: sxtb    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-10101101-10110111
sxtb    z23.s, p3/m, z13.s  // 00000100-10010000-10101101-10110111
// CHECK: sxtb    z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-10101101-10110111
SXTB    Z23.S, P3/M, Z13.S  // 00000100-10010000-10101101-10110111
// CHECK: sxtb    z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-10101101-10110111
sxtb    z0.d, p0/m, z0.d  // 00000100-11010000-10100000-00000000
// CHECK: sxtb    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-10100000-00000000
SXTB    Z0.D, P0/M, Z0.D  // 00000100-11010000-10100000-00000000
// CHECK: sxtb    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-10100000-00000000
sxtb    z21.s, p5/m, z10.s  // 00000100-10010000-10110101-01010101
// CHECK: sxtb    z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-10110101-01010101
SXTB    Z21.S, P5/M, Z10.S  // 00000100-10010000-10110101-01010101
// CHECK: sxtb    z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-10110101-01010101
sxtb    z31.d, p7/m, z31.d  // 00000100-11010000-10111111-11111111
// CHECK: sxtb    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-10111111-11111111
SXTB    Z31.D, P7/M, Z31.D  // 00000100-11010000-10111111-11111111
// CHECK: sxtb    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-10111111-11111111
