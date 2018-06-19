// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
frintx  z0.d, p0/m, z0.d  // 01100101-11000110-10100000-00000000
// CHECK: frintx  z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-10100000-00000000
FRINTX  Z0.D, P0/M, Z0.D  // 01100101-11000110-10100000-00000000
// CHECK: frintx  z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-10100000-00000000
frintx  z21.s, p5/m, z10.s  // 01100101-10000110-10110101-01010101
// CHECK: frintx  z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-10110101-01010101
FRINTX  Z21.S, P5/M, Z10.S  // 01100101-10000110-10110101-01010101
// CHECK: frintx  z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-10110101-01010101
frintx  z0.h, p0/m, z0.h  // 01100101-01000110-10100000-00000000
// CHECK: frintx  z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-10100000-00000000
FRINTX  Z0.H, P0/M, Z0.H  // 01100101-01000110-10100000-00000000
// CHECK: frintx  z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-10100000-00000000
frintx  z31.d, p7/m, z31.d  // 01100101-11000110-10111111-11111111
// CHECK: frintx  z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-10111111-11111111
FRINTX  Z31.D, P7/M, Z31.D  // 01100101-11000110-10111111-11111111
// CHECK: frintx  z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-10111111-11111111
frintx  z0.s, p0/m, z0.s  // 01100101-10000110-10100000-00000000
// CHECK: frintx  z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-10100000-00000000
FRINTX  Z0.S, P0/M, Z0.S  // 01100101-10000110-10100000-00000000
// CHECK: frintx  z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-10100000-00000000
frintx  z23.d, p3/m, z13.d  // 01100101-11000110-10101101-10110111
// CHECK: frintx  z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-10101101-10110111
FRINTX  Z23.D, P3/M, Z13.D  // 01100101-11000110-10101101-10110111
// CHECK: frintx  z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-10101101-10110111
frintx  z21.d, p5/m, z10.d  // 01100101-11000110-10110101-01010101
// CHECK: frintx  z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-10110101-01010101
FRINTX  Z21.D, P5/M, Z10.D  // 01100101-11000110-10110101-01010101
// CHECK: frintx  z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xc6,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11000110-10110101-01010101
frintx  z23.h, p3/m, z13.h  // 01100101-01000110-10101101-10110111
// CHECK: frintx  z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-10101101-10110111
FRINTX  Z23.H, P3/M, Z13.H  // 01100101-01000110-10101101-10110111
// CHECK: frintx  z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-10101101-10110111
frintx  z31.h, p7/m, z31.h  // 01100101-01000110-10111111-11111111
// CHECK: frintx  z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-10111111-11111111
FRINTX  Z31.H, P7/M, Z31.H  // 01100101-01000110-10111111-11111111
// CHECK: frintx  z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-10111111-11111111
frintx  z21.h, p5/m, z10.h  // 01100101-01000110-10110101-01010101
// CHECK: frintx  z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-10110101-01010101
FRINTX  Z21.H, P5/M, Z10.H  // 01100101-01000110-10110101-01010101
// CHECK: frintx  z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x46,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01000110-10110101-01010101
frintx  z31.s, p7/m, z31.s  // 01100101-10000110-10111111-11111111
// CHECK: frintx  z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-10111111-11111111
FRINTX  Z31.S, P7/M, Z31.S  // 01100101-10000110-10111111-11111111
// CHECK: frintx  z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-10111111-11111111
frintx  z23.s, p3/m, z13.s  // 01100101-10000110-10101101-10110111
// CHECK: frintx  z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-10101101-10110111
FRINTX  Z23.S, P3/M, Z13.S  // 01100101-10000110-10101101-10110111
// CHECK: frintx  z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x86,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10000110-10101101-10110111
