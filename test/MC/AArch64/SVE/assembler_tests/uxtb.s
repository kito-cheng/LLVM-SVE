// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uxtb    z23.s, p3/m, z13.s  // 00000100-10010001-10101101-10110111
// CHECK: uxtb    z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10101101-10110111
UXTB    Z23.S, P3/M, Z13.S  // 00000100-10010001-10101101-10110111
// CHECK: uxtb    z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10101101-10110111
uxtb    z21.h, p5/m, z10.h  // 00000100-01010001-10110101-01010101
// CHECK: uxtb    z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10110101-01010101
UXTB    Z21.H, P5/M, Z10.H  // 00000100-01010001-10110101-01010101
// CHECK: uxtb    z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10110101-01010101
uxtb    z0.s, p0/m, z0.s  // 00000100-10010001-10100000-00000000
// CHECK: uxtb    z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10100000-00000000
UXTB    Z0.S, P0/M, Z0.S  // 00000100-10010001-10100000-00000000
// CHECK: uxtb    z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10100000-00000000
uxtb    z21.d, p5/m, z10.d  // 00000100-11010001-10110101-01010101
// CHECK: uxtb    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10110101-01010101
UXTB    Z21.D, P5/M, Z10.D  // 00000100-11010001-10110101-01010101
// CHECK: uxtb    z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10110101-01010101
uxtb    z23.d, p3/m, z13.d  // 00000100-11010001-10101101-10110111
// CHECK: uxtb    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10101101-10110111
UXTB    Z23.D, P3/M, Z13.D  // 00000100-11010001-10101101-10110111
// CHECK: uxtb    z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10101101-10110111
uxtb    z0.h, p0/m, z0.h  // 00000100-01010001-10100000-00000000
// CHECK: uxtb    z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10100000-00000000
UXTB    Z0.H, P0/M, Z0.H  // 00000100-01010001-10100000-00000000
// CHECK: uxtb    z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10100000-00000000
uxtb    z23.h, p3/m, z13.h  // 00000100-01010001-10101101-10110111
// CHECK: uxtb    z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10101101-10110111
UXTB    Z23.H, P3/M, Z13.H  // 00000100-01010001-10101101-10110111
// CHECK: uxtb    z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10101101-10110111
uxtb    z21.s, p5/m, z10.s  // 00000100-10010001-10110101-01010101
// CHECK: uxtb    z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10110101-01010101
UXTB    Z21.S, P5/M, Z10.S  // 00000100-10010001-10110101-01010101
// CHECK: uxtb    z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10110101-01010101
uxtb    z31.d, p7/m, z31.d  // 00000100-11010001-10111111-11111111
// CHECK: uxtb    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10111111-11111111
UXTB    Z31.D, P7/M, Z31.D  // 00000100-11010001-10111111-11111111
// CHECK: uxtb    z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10111111-11111111
uxtb    z0.d, p0/m, z0.d  // 00000100-11010001-10100000-00000000
// CHECK: uxtb    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10100000-00000000
UXTB    Z0.D, P0/M, Z0.D  // 00000100-11010001-10100000-00000000
// CHECK: uxtb    z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-10100000-00000000
uxtb    z31.s, p7/m, z31.s  // 00000100-10010001-10111111-11111111
// CHECK: uxtb    z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10111111-11111111
UXTB    Z31.S, P7/M, Z31.S  // 00000100-10010001-10111111-11111111
// CHECK: uxtb    z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-10111111-11111111
uxtb    z31.h, p7/m, z31.h  // 00000100-01010001-10111111-11111111
// CHECK: uxtb    z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10111111-11111111
UXTB    Z31.H, P7/M, Z31.H  // 00000100-01010001-10111111-11111111
// CHECK: uxtb    z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-10111111-11111111
