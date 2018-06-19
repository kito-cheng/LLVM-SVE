// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fneg    z21.s, p5/m, z10.s  // 00000100-10011101-10110101-01010101
// CHECK: fneg    z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x9d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011101-10110101-01010101
FNEG    Z21.S, P5/M, Z10.S  // 00000100-10011101-10110101-01010101
// CHECK: fneg    z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x9d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011101-10110101-01010101
fneg    z31.s, p7/m, z31.s  // 00000100-10011101-10111111-11111111
// CHECK: fneg    z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x9d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011101-10111111-11111111
FNEG    Z31.S, P7/M, Z31.S  // 00000100-10011101-10111111-11111111
// CHECK: fneg    z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x9d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011101-10111111-11111111
fneg    z31.d, p7/m, z31.d  // 00000100-11011101-10111111-11111111
// CHECK: fneg    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xdd,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011101-10111111-11111111
FNEG    Z31.D, P7/M, Z31.D  // 00000100-11011101-10111111-11111111
// CHECK: fneg    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xdd,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011101-10111111-11111111
fneg    z0.h, p0/m, z0.h  // 00000100-01011101-10100000-00000000
// CHECK: fneg    z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x5d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011101-10100000-00000000
FNEG    Z0.H, P0/M, Z0.H  // 00000100-01011101-10100000-00000000
// CHECK: fneg    z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x5d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011101-10100000-00000000
fneg    z0.s, p0/m, z0.s  // 00000100-10011101-10100000-00000000
// CHECK: fneg    z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x9d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011101-10100000-00000000
FNEG    Z0.S, P0/M, Z0.S  // 00000100-10011101-10100000-00000000
// CHECK: fneg    z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x9d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011101-10100000-00000000
fneg    z0.d, p0/m, z0.d  // 00000100-11011101-10100000-00000000
// CHECK: fneg    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xdd,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011101-10100000-00000000
FNEG    Z0.D, P0/M, Z0.D  // 00000100-11011101-10100000-00000000
// CHECK: fneg    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xdd,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011101-10100000-00000000
fneg    z23.h, p3/m, z13.h  // 00000100-01011101-10101101-10110111
// CHECK: fneg    z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x5d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011101-10101101-10110111
FNEG    Z23.H, P3/M, Z13.H  // 00000100-01011101-10101101-10110111
// CHECK: fneg    z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x5d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011101-10101101-10110111
fneg    z23.s, p3/m, z13.s  // 00000100-10011101-10101101-10110111
// CHECK: fneg    z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x9d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011101-10101101-10110111
FNEG    Z23.S, P3/M, Z13.S  // 00000100-10011101-10101101-10110111
// CHECK: fneg    z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x9d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011101-10101101-10110111
fneg    z31.h, p7/m, z31.h  // 00000100-01011101-10111111-11111111
// CHECK: fneg    z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x5d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011101-10111111-11111111
FNEG    Z31.H, P7/M, Z31.H  // 00000100-01011101-10111111-11111111
// CHECK: fneg    z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x5d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011101-10111111-11111111
fneg    z21.h, p5/m, z10.h  // 00000100-01011101-10110101-01010101
// CHECK: fneg    z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x5d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011101-10110101-01010101
FNEG    Z21.H, P5/M, Z10.H  // 00000100-01011101-10110101-01010101
// CHECK: fneg    z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x5d,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011101-10110101-01010101
fneg    z23.d, p3/m, z13.d  // 00000100-11011101-10101101-10110111
// CHECK: fneg    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xdd,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011101-10101101-10110111
FNEG    Z23.D, P3/M, Z13.D  // 00000100-11011101-10101101-10110111
// CHECK: fneg    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xdd,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011101-10101101-10110111
fneg    z21.d, p5/m, z10.d  // 00000100-11011101-10110101-01010101
// CHECK: fneg    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xdd,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011101-10110101-01010101
FNEG    Z21.D, P5/M, Z10.D  // 00000100-11011101-10110101-01010101
// CHECK: fneg    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xdd,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011101-10110101-01010101
