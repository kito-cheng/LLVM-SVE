// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmla    z23.d, p3/m, z13.d, z8.d  // 01100101-11101000-00001101-10110111
// CHECK: fmla    z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x0d,0xe8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11101000-00001101-10110111
FMLA    Z23.D, P3/M, Z13.D, Z8.D  // 01100101-11101000-00001101-10110111
// CHECK: fmla    z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x0d,0xe8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11101000-00001101-10110111
fmla    z0.h, p0/m, z0.h, z0.h  // 01100101-01100000-00000000-00000000
// CHECK: fmla    z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x00,0x60,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01100000-00000000-00000000
FMLA    Z0.H, P0/M, Z0.H, Z0.H  // 01100101-01100000-00000000-00000000
// CHECK: fmla    z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x00,0x60,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01100000-00000000-00000000
fmla    z21.d, p5/m, z10.d, z21.d  // 01100101-11110101-00010101-01010101
// CHECK: fmla    z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x15,0xf5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11110101-00010101-01010101
FMLA    Z21.D, P5/M, Z10.D, Z21.D  // 01100101-11110101-00010101-01010101
// CHECK: fmla    z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x15,0xf5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11110101-00010101-01010101
fmla    z31.h, z31.h, z7.h[7]  // 01100100-01111111-00000011-11111111
// CHECK: fmla    z31.h, z31.h, z7.h[7] // encoding: [0xff,0x03,0x7f,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01111111-00000011-11111111
FMLA    Z31.H, Z31.H, Z7.H[7]  // 01100100-01111111-00000011-11111111
// CHECK: fmla    z31.h, z31.h, z7.h[7] // encoding: [0xff,0x03,0x7f,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01111111-00000011-11111111
fmla    z21.d, z10.d, z5.d[1]  // 01100100-11110101-00000001-01010101
// CHECK: fmla    z21.d, z10.d, z5.d[1] // encoding: [0x55,0x01,0xf5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11110101-00000001-01010101
FMLA    Z21.D, Z10.D, Z5.D[1]  // 01100100-11110101-00000001-01010101
// CHECK: fmla    z21.d, z10.d, z5.d[1] // encoding: [0x55,0x01,0xf5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11110101-00000001-01010101
fmla    z31.s, z31.s, z7.s[3]  // 01100100-10111111-00000011-11111111
// CHECK: fmla    z31.s, z31.s, z7.s[3] // encoding: [0xff,0x03,0xbf,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10111111-00000011-11111111
FMLA    Z31.S, Z31.S, Z7.S[3]  // 01100100-10111111-00000011-11111111
// CHECK: fmla    z31.s, z31.s, z7.s[3] // encoding: [0xff,0x03,0xbf,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10111111-00000011-11111111
fmla    z21.s, p5/m, z10.s, z21.s  // 01100101-10110101-00010101-01010101
// CHECK: fmla    z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0x15,0xb5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10110101-00010101-01010101
FMLA    Z21.S, P5/M, Z10.S, Z21.S  // 01100101-10110101-00010101-01010101
// CHECK: fmla    z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0x15,0xb5,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10110101-00010101-01010101
fmla    z23.h, z13.h, z0.h[5]  // 01100100-01101000-00000001-10110111
// CHECK: fmla    z23.h, z13.h, z0.h[5] // encoding: [0xb7,0x01,0x68,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01101000-00000001-10110111
FMLA    Z23.H, Z13.H, Z0.H[5]  // 01100100-01101000-00000001-10110111
// CHECK: fmla    z23.h, z13.h, z0.h[5] // encoding: [0xb7,0x01,0x68,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01101000-00000001-10110111
fmla    z21.s, z10.s, z5.s[2]  // 01100100-10110101-00000001-01010101
// CHECK: fmla    z21.s, z10.s, z5.s[2] // encoding: [0x55,0x01,0xb5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10110101-00000001-01010101
FMLA    Z21.S, Z10.S, Z5.S[2]  // 01100100-10110101-00000001-01010101
// CHECK: fmla    z21.s, z10.s, z5.s[2] // encoding: [0x55,0x01,0xb5,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10110101-00000001-01010101
fmla    z21.h, z10.h, z5.h[6]  // 01100100-01110101-00000001-01010101
// CHECK: fmla    z21.h, z10.h, z5.h[6] // encoding: [0x55,0x01,0x75,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01110101-00000001-01010101
FMLA    Z21.H, Z10.H, Z5.H[6]  // 01100100-01110101-00000001-01010101
// CHECK: fmla    z21.h, z10.h, z5.h[6] // encoding: [0x55,0x01,0x75,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-01110101-00000001-01010101
fmla    z23.s, z13.s, z0.s[1]  // 01100100-10101000-00000001-10110111
// CHECK: fmla    z23.s, z13.s, z0.s[1] // encoding: [0xb7,0x01,0xa8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10101000-00000001-10110111
FMLA    Z23.S, Z13.S, Z0.S[1]  // 01100100-10101000-00000001-10110111
// CHECK: fmla    z23.s, z13.s, z0.s[1] // encoding: [0xb7,0x01,0xa8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10101000-00000001-10110111
fmla    z23.s, p3/m, z13.s, z8.s  // 01100101-10101000-00001101-10110111
// CHECK: fmla    z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0x0d,0xa8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10101000-00001101-10110111
FMLA    Z23.S, P3/M, Z13.S, Z8.S  // 01100101-10101000-00001101-10110111
// CHECK: fmla    z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0x0d,0xa8,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10101000-00001101-10110111
fmla    z0.d, z0.d, z0.d[0]  // 01100100-11100000-00000000-00000000
// CHECK: fmla    z0.d, z0.d, z0.d[0] // encoding: [0x00,0x00,0xe0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11100000-00000000-00000000
FMLA    Z0.D, Z0.D, Z0.D[0]  // 01100100-11100000-00000000-00000000
// CHECK: fmla    z0.d, z0.d, z0.d[0] // encoding: [0x00,0x00,0xe0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11100000-00000000-00000000
fmla    z0.s, z0.s, z0.s[0]  // 01100100-10100000-00000000-00000000
// CHECK: fmla    z0.s, z0.s, z0.s[0] // encoding: [0x00,0x00,0xa0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10100000-00000000-00000000
FMLA    Z0.S, Z0.S, Z0.S[0]  // 01100100-10100000-00000000-00000000
// CHECK: fmla    z0.s, z0.s, z0.s[0] // encoding: [0x00,0x00,0xa0,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-10100000-00000000-00000000
fmla    z0.s, p0/m, z0.s, z0.s  // 01100101-10100000-00000000-00000000
// CHECK: fmla    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x00,0xa0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10100000-00000000-00000000
FMLA    Z0.S, P0/M, Z0.S, Z0.S  // 01100101-10100000-00000000-00000000
// CHECK: fmla    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x00,0xa0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10100000-00000000-00000000
fmla    z31.h, p7/m, z31.h, z31.h  // 01100101-01111111-00011111-11111111
// CHECK: fmla    z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x1f,0x7f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01111111-00011111-11111111
FMLA    Z31.H, P7/M, Z31.H, Z31.H  // 01100101-01111111-00011111-11111111
// CHECK: fmla    z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x1f,0x7f,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01111111-00011111-11111111
fmla    z31.d, p7/m, z31.d, z31.d  // 01100101-11111111-00011111-11111111
// CHECK: fmla    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x1f,0xff,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11111111-00011111-11111111
FMLA    Z31.D, P7/M, Z31.D, Z31.D  // 01100101-11111111-00011111-11111111
// CHECK: fmla    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x1f,0xff,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11111111-00011111-11111111
fmla    z0.h, z0.h, z0.h[0]  // 01100100-00100000-00000000-00000000
// CHECK: fmla    z0.h, z0.h, z0.h[0] // encoding: [0x00,0x00,0x20,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-00100000-00000000-00000000
FMLA    Z0.H, Z0.H, Z0.H[0]  // 01100100-00100000-00000000-00000000
// CHECK: fmla    z0.h, z0.h, z0.h[0] // encoding: [0x00,0x00,0x20,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-00100000-00000000-00000000
fmla    z23.d, z13.d, z8.d[0]  // 01100100-11101000-00000001-10110111
// CHECK: fmla    z23.d, z13.d, z8.d[0] // encoding: [0xb7,0x01,0xe8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11101000-00000001-10110111
FMLA    Z23.D, Z13.D, Z8.D[0]  // 01100100-11101000-00000001-10110111
// CHECK: fmla    z23.d, z13.d, z8.d[0] // encoding: [0xb7,0x01,0xe8,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11101000-00000001-10110111
fmla    z21.h, p5/m, z10.h, z21.h  // 01100101-01110101-00010101-01010101
// CHECK: fmla    z21.h, p5/m, z10.h, z21.h // encoding: [0x55,0x15,0x75,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01110101-00010101-01010101
FMLA    Z21.H, P5/M, Z10.H, Z21.H  // 01100101-01110101-00010101-01010101
// CHECK: fmla    z21.h, p5/m, z10.h, z21.h // encoding: [0x55,0x15,0x75,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01110101-00010101-01010101
fmla    z31.s, p7/m, z31.s, z31.s  // 01100101-10111111-00011111-11111111
// CHECK: fmla    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x1f,0xbf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10111111-00011111-11111111
FMLA    Z31.S, P7/M, Z31.S, Z31.S  // 01100101-10111111-00011111-11111111
// CHECK: fmla    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x1f,0xbf,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10111111-00011111-11111111
fmla    z31.d, z31.d, z15.d[1]  // 01100100-11111111-00000011-11111111
// CHECK: fmla    z31.d, z31.d, z15.d[1] // encoding: [0xff,0x03,0xff,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11111111-00000011-11111111
FMLA    Z31.D, Z31.D, Z15.D[1]  // 01100100-11111111-00000011-11111111
// CHECK: fmla    z31.d, z31.d, z15.d[1] // encoding: [0xff,0x03,0xff,0x64]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100100-11111111-00000011-11111111
fmla    z0.d, p0/m, z0.d, z0.d  // 01100101-11100000-00000000-00000000
// CHECK: fmla    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x00,0xe0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11100000-00000000-00000000
FMLA    Z0.D, P0/M, Z0.D, Z0.D  // 01100101-11100000-00000000-00000000
// CHECK: fmla    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x00,0xe0,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11100000-00000000-00000000
fmla    z23.h, p3/m, z13.h, z8.h  // 01100101-01101000-00001101-10110111
// CHECK: fmla    z23.h, p3/m, z13.h, z8.h // encoding: [0xb7,0x0d,0x68,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01101000-00001101-10110111
FMLA    Z23.H, P3/M, Z13.H, Z8.H  // 01100101-01101000-00001101-10110111
// CHECK: fmla    z23.h, p3/m, z13.h, z8.h // encoding: [0xb7,0x0d,0x68,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01101000-00001101-10110111
