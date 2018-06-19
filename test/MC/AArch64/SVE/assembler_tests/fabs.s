// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fabs    z0.d, p0/m, z0.d  // 00000100-11011100-10100000-00000000
// CHECK: fabs    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xdc,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011100-10100000-00000000
FABS    Z0.D, P0/M, Z0.D  // 00000100-11011100-10100000-00000000
// CHECK: fabs    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xdc,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011100-10100000-00000000
fabs    z21.h, p5/m, z10.h  // 00000100-01011100-10110101-01010101
// CHECK: fabs    z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x5c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011100-10110101-01010101
FABS    Z21.H, P5/M, Z10.H  // 00000100-01011100-10110101-01010101
// CHECK: fabs    z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x5c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011100-10110101-01010101
fabs    z21.s, p5/m, z10.s  // 00000100-10011100-10110101-01010101
// CHECK: fabs    z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x9c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011100-10110101-01010101
FABS    Z21.S, P5/M, Z10.S  // 00000100-10011100-10110101-01010101
// CHECK: fabs    z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x9c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011100-10110101-01010101
fabs    z0.h, p0/m, z0.h  // 00000100-01011100-10100000-00000000
// CHECK: fabs    z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x5c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011100-10100000-00000000
FABS    Z0.H, P0/M, Z0.H  // 00000100-01011100-10100000-00000000
// CHECK: fabs    z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x5c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011100-10100000-00000000
fabs    z23.h, p3/m, z13.h  // 00000100-01011100-10101101-10110111
// CHECK: fabs    z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x5c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011100-10101101-10110111
FABS    Z23.H, P3/M, Z13.H  // 00000100-01011100-10101101-10110111
// CHECK: fabs    z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x5c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011100-10101101-10110111
fabs    z23.d, p3/m, z13.d  // 00000100-11011100-10101101-10110111
// CHECK: fabs    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xdc,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011100-10101101-10110111
FABS    Z23.D, P3/M, Z13.D  // 00000100-11011100-10101101-10110111
// CHECK: fabs    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xdc,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011100-10101101-10110111
fabs    z0.s, p0/m, z0.s  // 00000100-10011100-10100000-00000000
// CHECK: fabs    z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x9c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011100-10100000-00000000
FABS    Z0.S, P0/M, Z0.S  // 00000100-10011100-10100000-00000000
// CHECK: fabs    z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x9c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011100-10100000-00000000
fabs    z23.s, p3/m, z13.s  // 00000100-10011100-10101101-10110111
// CHECK: fabs    z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x9c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011100-10101101-10110111
FABS    Z23.S, P3/M, Z13.S  // 00000100-10011100-10101101-10110111
// CHECK: fabs    z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x9c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011100-10101101-10110111
fabs    z31.d, p7/m, z31.d  // 00000100-11011100-10111111-11111111
// CHECK: fabs    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xdc,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011100-10111111-11111111
FABS    Z31.D, P7/M, Z31.D  // 00000100-11011100-10111111-11111111
// CHECK: fabs    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xdc,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011100-10111111-11111111
fabs    z21.d, p5/m, z10.d  // 00000100-11011100-10110101-01010101
// CHECK: fabs    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xdc,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011100-10110101-01010101
FABS    Z21.D, P5/M, Z10.D  // 00000100-11011100-10110101-01010101
// CHECK: fabs    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xdc,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011100-10110101-01010101
fabs    z31.s, p7/m, z31.s  // 00000100-10011100-10111111-11111111
// CHECK: fabs    z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x9c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011100-10111111-11111111
FABS    Z31.S, P7/M, Z31.S  // 00000100-10011100-10111111-11111111
// CHECK: fabs    z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x9c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011100-10111111-11111111
fabs    z31.h, p7/m, z31.h  // 00000100-01011100-10111111-11111111
// CHECK: fabs    z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x5c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011100-10111111-11111111
FABS    Z31.H, P7/M, Z31.H  // 00000100-01011100-10111111-11111111
// CHECK: fabs    z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x5c,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011100-10111111-11111111
