// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
not     z0.d, p0/m, z0.d  // 00000100-11011110-10100000-00000000
// CHECK: not     z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xde,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011110-10100000-00000000
NOT     Z0.D, P0/M, Z0.D  // 00000100-11011110-10100000-00000000
// CHECK: not     z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xde,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011110-10100000-00000000
not     z21.d, p5/m, z10.d  // 00000100-11011110-10110101-01010101
// CHECK: not     z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xde,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011110-10110101-01010101
NOT     Z21.D, P5/M, Z10.D  // 00000100-11011110-10110101-01010101
// CHECK: not     z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xde,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011110-10110101-01010101
not     z31.d, p7/m, z31.d  // 00000100-11011110-10111111-11111111
// CHECK: not     z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xde,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011110-10111111-11111111
NOT     Z31.D, P7/M, Z31.D  // 00000100-11011110-10111111-11111111
// CHECK: not     z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xde,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011110-10111111-11111111
not     z23.h, p3/m, z13.h  // 00000100-01011110-10101101-10110111
// CHECK: not     z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x5e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011110-10101101-10110111
NOT     Z23.H, P3/M, Z13.H  // 00000100-01011110-10101101-10110111
// CHECK: not     z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x5e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011110-10101101-10110111
not     z23.s, p3/m, z13.s  // 00000100-10011110-10101101-10110111
// CHECK: not     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x9e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011110-10101101-10110111
NOT     Z23.S, P3/M, Z13.S  // 00000100-10011110-10101101-10110111
// CHECK: not     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x9e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011110-10101101-10110111
not     z0.b, p0/m, z0.b  // 00000100-00011110-10100000-00000000
// CHECK: not     z0.b, p0/m, z0.b // encoding: [0x00,0xa0,0x1e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011110-10100000-00000000
NOT     Z0.B, P0/M, Z0.B  // 00000100-00011110-10100000-00000000
// CHECK: not     z0.b, p0/m, z0.b // encoding: [0x00,0xa0,0x1e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011110-10100000-00000000
not     z23.b, p3/m, z13.b  // 00000100-00011110-10101101-10110111
// CHECK: not     z23.b, p3/m, z13.b // encoding: [0xb7,0xad,0x1e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011110-10101101-10110111
NOT     Z23.B, P3/M, Z13.B  // 00000100-00011110-10101101-10110111
// CHECK: not     z23.b, p3/m, z13.b // encoding: [0xb7,0xad,0x1e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011110-10101101-10110111
not     z31.s, p7/m, z31.s  // 00000100-10011110-10111111-11111111
// CHECK: not     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x9e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011110-10111111-11111111
NOT     Z31.S, P7/M, Z31.S  // 00000100-10011110-10111111-11111111
// CHECK: not     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x9e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011110-10111111-11111111
not     p5.b, p5/z, p10.b  // 00100101-00000101-01010111-01000101
// CHECK: not     p5.b, p5/z, p10.b // encoding: [0x45,0x57,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-01010111-01000101
NOT     P5.B, P5/Z, P10.B  // 00100101-00000101-01010111-01000101
// CHECK: not     p5.b, p5/z, p10.b // encoding: [0x45,0x57,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-01010111-01000101
not     z0.s, p0/m, z0.s  // 00000100-10011110-10100000-00000000
// CHECK: not     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x9e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011110-10100000-00000000
NOT     Z0.S, P0/M, Z0.S  // 00000100-10011110-10100000-00000000
// CHECK: not     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x9e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011110-10100000-00000000
not     z23.d, p3/m, z13.d  // 00000100-11011110-10101101-10110111
// CHECK: not     z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xde,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011110-10101101-10110111
NOT     Z23.D, P3/M, Z13.D  // 00000100-11011110-10101101-10110111
// CHECK: not     z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xde,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011110-10101101-10110111
not     z0.h, p0/m, z0.h  // 00000100-01011110-10100000-00000000
// CHECK: not     z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x5e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011110-10100000-00000000
NOT     Z0.H, P0/M, Z0.H  // 00000100-01011110-10100000-00000000
// CHECK: not     z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x5e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011110-10100000-00000000
not     p0.b, p0/z, p0.b  // 00100101-00000000-01000010-00000000
// CHECK: not     p0.b, p0/z, p0.b // encoding: [0x00,0x42,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-01000010-00000000
NOT     P0.B, P0/Z, P0.B  // 00100101-00000000-01000010-00000000
// CHECK: not     p0.b, p0/z, p0.b // encoding: [0x00,0x42,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-01000010-00000000
not     z21.b, p5/m, z10.b  // 00000100-00011110-10110101-01010101
// CHECK: not     z21.b, p5/m, z10.b // encoding: [0x55,0xb5,0x1e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011110-10110101-01010101
NOT     Z21.B, P5/M, Z10.B  // 00000100-00011110-10110101-01010101
// CHECK: not     z21.b, p5/m, z10.b // encoding: [0x55,0xb5,0x1e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011110-10110101-01010101
not     z31.b, p7/m, z31.b  // 00000100-00011110-10111111-11111111
// CHECK: not     z31.b, p7/m, z31.b // encoding: [0xff,0xbf,0x1e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011110-10111111-11111111
NOT     Z31.B, P7/M, Z31.B  // 00000100-00011110-10111111-11111111
// CHECK: not     z31.b, p7/m, z31.b // encoding: [0xff,0xbf,0x1e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011110-10111111-11111111
not     p15.b, p15/z, p15.b  // 00100101-00001111-01111111-11101111
// CHECK: not     p15.b, p15/z, p15.b // encoding: [0xef,0x7f,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-01111111-11101111
NOT     P15.B, P15/Z, P15.B  // 00100101-00001111-01111111-11101111
// CHECK: not     p15.b, p15/z, p15.b // encoding: [0xef,0x7f,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-01111111-11101111
not     z31.h, p7/m, z31.h  // 00000100-01011110-10111111-11111111
// CHECK: not     z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x5e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011110-10111111-11111111
NOT     Z31.H, P7/M, Z31.H  // 00000100-01011110-10111111-11111111
// CHECK: not     z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x5e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011110-10111111-11111111
not     z21.h, p5/m, z10.h  // 00000100-01011110-10110101-01010101
// CHECK: not     z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x5e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011110-10110101-01010101
NOT     Z21.H, P5/M, Z10.H  // 00000100-01011110-10110101-01010101
// CHECK: not     z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x5e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011110-10110101-01010101
not     z21.s, p5/m, z10.s  // 00000100-10011110-10110101-01010101
// CHECK: not     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x9e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011110-10110101-01010101
NOT     Z21.S, P5/M, Z10.S  // 00000100-10011110-10110101-01010101
// CHECK: not     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x9e,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011110-10110101-01010101
