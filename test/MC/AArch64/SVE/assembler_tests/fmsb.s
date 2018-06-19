// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmsb    z31.s, p7/m, z31.s, z31.s  // 01100101-10111111-10111111-11111111
// CHECK: fmsb    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0xbf,0xbf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10111111-10111111-11111111
FMSB    Z31.S, P7/M, Z31.S, Z31.S  // 01100101-10111111-10111111-11111111
// CHECK: fmsb    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0xbf,0xbf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10111111-10111111-11111111
fmsb    z23.d, p3/m, z13.d, z8.d  // 01100101-11101000-10101101-10110111
// CHECK: fmsb    z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0xad,0xe8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11101000-10101101-10110111
FMSB    Z23.D, P3/M, Z13.D, Z8.D  // 01100101-11101000-10101101-10110111
// CHECK: fmsb    z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0xad,0xe8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11101000-10101101-10110111
fmsb    z0.d, p0/m, z0.d, z0.d  // 01100101-11100000-10100000-00000000
// CHECK: fmsb    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0xa0,0xe0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11100000-10100000-00000000
FMSB    Z0.D, P0/M, Z0.D, Z0.D  // 01100101-11100000-10100000-00000000
// CHECK: fmsb    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0xa0,0xe0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11100000-10100000-00000000
fmsb    z21.h, p5/m, z10.h, z21.h  // 01100101-01110101-10110101-01010101
// CHECK: fmsb    z21.h, p5/m, z10.h, z21.h // encoding: [0x55,0xb5,0x75,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01110101-10110101-01010101
FMSB    Z21.H, P5/M, Z10.H, Z21.H  // 01100101-01110101-10110101-01010101
// CHECK: fmsb    z21.h, p5/m, z10.h, z21.h // encoding: [0x55,0xb5,0x75,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01110101-10110101-01010101
fmsb    z31.d, p7/m, z31.d, z31.d  // 01100101-11111111-10111111-11111111
// CHECK: fmsb    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0xbf,0xff,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11111111-10111111-11111111
FMSB    Z31.D, P7/M, Z31.D, Z31.D  // 01100101-11111111-10111111-11111111
// CHECK: fmsb    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0xbf,0xff,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11111111-10111111-11111111
fmsb    z0.h, p0/m, z0.h, z0.h  // 01100101-01100000-10100000-00000000
// CHECK: fmsb    z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0xa0,0x60,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01100000-10100000-00000000
FMSB    Z0.H, P0/M, Z0.H, Z0.H  // 01100101-01100000-10100000-00000000
// CHECK: fmsb    z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0xa0,0x60,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01100000-10100000-00000000
fmsb    z23.s, p3/m, z13.s, z8.s  // 01100101-10101000-10101101-10110111
// CHECK: fmsb    z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0xad,0xa8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10101000-10101101-10110111
FMSB    Z23.S, P3/M, Z13.S, Z8.S  // 01100101-10101000-10101101-10110111
// CHECK: fmsb    z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0xad,0xa8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10101000-10101101-10110111
fmsb    z23.h, p3/m, z13.h, z8.h  // 01100101-01101000-10101101-10110111
// CHECK: fmsb    z23.h, p3/m, z13.h, z8.h // encoding: [0xb7,0xad,0x68,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01101000-10101101-10110111
FMSB    Z23.H, P3/M, Z13.H, Z8.H  // 01100101-01101000-10101101-10110111
// CHECK: fmsb    z23.h, p3/m, z13.h, z8.h // encoding: [0xb7,0xad,0x68,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01101000-10101101-10110111
fmsb    z21.s, p5/m, z10.s, z21.s  // 01100101-10110101-10110101-01010101
// CHECK: fmsb    z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0xb5,0xb5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10110101-10110101-01010101
FMSB    Z21.S, P5/M, Z10.S, Z21.S  // 01100101-10110101-10110101-01010101
// CHECK: fmsb    z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0xb5,0xb5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10110101-10110101-01010101
fmsb    z21.d, p5/m, z10.d, z21.d  // 01100101-11110101-10110101-01010101
// CHECK: fmsb    z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0xb5,0xf5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11110101-10110101-01010101
FMSB    Z21.D, P5/M, Z10.D, Z21.D  // 01100101-11110101-10110101-01010101
// CHECK: fmsb    z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0xb5,0xf5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11110101-10110101-01010101
fmsb    z31.h, p7/m, z31.h, z31.h  // 01100101-01111111-10111111-11111111
// CHECK: fmsb    z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0xbf,0x7f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01111111-10111111-11111111
FMSB    Z31.H, P7/M, Z31.H, Z31.H  // 01100101-01111111-10111111-11111111
// CHECK: fmsb    z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0xbf,0x7f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01111111-10111111-11111111
fmsb    z0.s, p0/m, z0.s, z0.s  // 01100101-10100000-10100000-00000000
// CHECK: fmsb    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0xa0,0xa0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10100000-10100000-00000000
FMSB    Z0.S, P0/M, Z0.S, Z0.S  // 01100101-10100000-10100000-00000000
// CHECK: fmsb    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0xa0,0xa0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10100000-10100000-00000000
