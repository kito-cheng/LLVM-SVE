// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cls     z0.d, p0/m, z0.d  // 00000100-11011000-10100000-00000000
// CHECK: cls     z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-10100000-00000000
CLS     Z0.D, P0/M, Z0.D  // 00000100-11011000-10100000-00000000
// CHECK: cls     z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-10100000-00000000
cls     z0.b, p0/m, z0.b  // 00000100-00011000-10100000-00000000
// CHECK: cls     z0.b, p0/m, z0.b // encoding: [0x00,0xa0,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-10100000-00000000
CLS     Z0.B, P0/M, Z0.B  // 00000100-00011000-10100000-00000000
// CHECK: cls     z0.b, p0/m, z0.b // encoding: [0x00,0xa0,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-10100000-00000000
cls     z21.b, p5/m, z10.b  // 00000100-00011000-10110101-01010101
// CHECK: cls     z21.b, p5/m, z10.b // encoding: [0x55,0xb5,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-10110101-01010101
CLS     Z21.B, P5/M, Z10.B  // 00000100-00011000-10110101-01010101
// CHECK: cls     z21.b, p5/m, z10.b // encoding: [0x55,0xb5,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-10110101-01010101
cls     z23.h, p3/m, z13.h  // 00000100-01011000-10101101-10110111
// CHECK: cls     z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-10101101-10110111
CLS     Z23.H, P3/M, Z13.H  // 00000100-01011000-10101101-10110111
// CHECK: cls     z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-10101101-10110111
cls     z0.h, p0/m, z0.h  // 00000100-01011000-10100000-00000000
// CHECK: cls     z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-10100000-00000000
CLS     Z0.H, P0/M, Z0.H  // 00000100-01011000-10100000-00000000
// CHECK: cls     z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-10100000-00000000
cls     z21.s, p5/m, z10.s  // 00000100-10011000-10110101-01010101
// CHECK: cls     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-10110101-01010101
CLS     Z21.S, P5/M, Z10.S  // 00000100-10011000-10110101-01010101
// CHECK: cls     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-10110101-01010101
cls     z31.h, p7/m, z31.h  // 00000100-01011000-10111111-11111111
// CHECK: cls     z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-10111111-11111111
CLS     Z31.H, P7/M, Z31.H  // 00000100-01011000-10111111-11111111
// CHECK: cls     z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-10111111-11111111
cls     z23.d, p3/m, z13.d  // 00000100-11011000-10101101-10110111
// CHECK: cls     z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-10101101-10110111
CLS     Z23.D, P3/M, Z13.D  // 00000100-11011000-10101101-10110111
// CHECK: cls     z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-10101101-10110111
cls     z31.d, p7/m, z31.d  // 00000100-11011000-10111111-11111111
// CHECK: cls     z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-10111111-11111111
CLS     Z31.D, P7/M, Z31.D  // 00000100-11011000-10111111-11111111
// CHECK: cls     z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-10111111-11111111
cls     z21.d, p5/m, z10.d  // 00000100-11011000-10110101-01010101
// CHECK: cls     z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-10110101-01010101
CLS     Z21.D, P5/M, Z10.D  // 00000100-11011000-10110101-01010101
// CHECK: cls     z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011000-10110101-01010101
cls     z23.s, p3/m, z13.s  // 00000100-10011000-10101101-10110111
// CHECK: cls     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-10101101-10110111
CLS     Z23.S, P3/M, Z13.S  // 00000100-10011000-10101101-10110111
// CHECK: cls     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-10101101-10110111
cls     z21.h, p5/m, z10.h  // 00000100-01011000-10110101-01010101
// CHECK: cls     z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-10110101-01010101
CLS     Z21.H, P5/M, Z10.H  // 00000100-01011000-10110101-01010101
// CHECK: cls     z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x58,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011000-10110101-01010101
cls     z31.s, p7/m, z31.s  // 00000100-10011000-10111111-11111111
// CHECK: cls     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-10111111-11111111
CLS     Z31.S, P7/M, Z31.S  // 00000100-10011000-10111111-11111111
// CHECK: cls     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-10111111-11111111
cls     z31.b, p7/m, z31.b  // 00000100-00011000-10111111-11111111
// CHECK: cls     z31.b, p7/m, z31.b // encoding: [0xff,0xbf,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-10111111-11111111
CLS     Z31.B, P7/M, Z31.B  // 00000100-00011000-10111111-11111111
// CHECK: cls     z31.b, p7/m, z31.b // encoding: [0xff,0xbf,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-10111111-11111111
cls     z0.s, p0/m, z0.s  // 00000100-10011000-10100000-00000000
// CHECK: cls     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-10100000-00000000
CLS     Z0.S, P0/M, Z0.S  // 00000100-10011000-10100000-00000000
// CHECK: cls     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x98,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011000-10100000-00000000
cls     z23.b, p3/m, z13.b  // 00000100-00011000-10101101-10110111
// CHECK: cls     z23.b, p3/m, z13.b // encoding: [0xb7,0xad,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-10101101-10110111
CLS     Z23.B, P3/M, Z13.B  // 00000100-00011000-10101101-10110111
// CHECK: cls     z23.b, p3/m, z13.b // encoding: [0xb7,0xad,0x18,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011000-10101101-10110111
