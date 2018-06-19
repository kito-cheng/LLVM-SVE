// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clz     z23.d, p3/m, z13.d  // 00000100-11011001-10101101-10110111
// CHECK: clz     z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-10101101-10110111
CLZ     Z23.D, P3/M, Z13.D  // 00000100-11011001-10101101-10110111
// CHECK: clz     z23.d, p3/m, z13.d // encoding: [0xb7,0xad,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-10101101-10110111
clz     z23.b, p3/m, z13.b  // 00000100-00011001-10101101-10110111
// CHECK: clz     z23.b, p3/m, z13.b // encoding: [0xb7,0xad,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10101101-10110111
CLZ     Z23.B, P3/M, Z13.B  // 00000100-00011001-10101101-10110111
// CHECK: clz     z23.b, p3/m, z13.b // encoding: [0xb7,0xad,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10101101-10110111
clz     z31.s, p7/m, z31.s  // 00000100-10011001-10111111-11111111
// CHECK: clz     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10111111-11111111
CLZ     Z31.S, P7/M, Z31.S  // 00000100-10011001-10111111-11111111
// CHECK: clz     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10111111-11111111
clz     z0.h, p0/m, z0.h  // 00000100-01011001-10100000-00000000
// CHECK: clz     z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10100000-00000000
CLZ     Z0.H, P0/M, Z0.H  // 00000100-01011001-10100000-00000000
// CHECK: clz     z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10100000-00000000
clz     z31.d, p7/m, z31.d  // 00000100-11011001-10111111-11111111
// CHECK: clz     z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-10111111-11111111
CLZ     Z31.D, P7/M, Z31.D  // 00000100-11011001-10111111-11111111
// CHECK: clz     z31.d, p7/m, z31.d // encoding: [0xff,0xbf,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-10111111-11111111
clz     z23.s, p3/m, z13.s  // 00000100-10011001-10101101-10110111
// CHECK: clz     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10101101-10110111
CLZ     Z23.S, P3/M, Z13.S  // 00000100-10011001-10101101-10110111
// CHECK: clz     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10101101-10110111
clz     z21.s, p5/m, z10.s  // 00000100-10011001-10110101-01010101
// CHECK: clz     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10110101-01010101
CLZ     Z21.S, P5/M, Z10.S  // 00000100-10011001-10110101-01010101
// CHECK: clz     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10110101-01010101
clz     z21.b, p5/m, z10.b  // 00000100-00011001-10110101-01010101
// CHECK: clz     z21.b, p5/m, z10.b // encoding: [0x55,0xb5,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10110101-01010101
CLZ     Z21.B, P5/M, Z10.B  // 00000100-00011001-10110101-01010101
// CHECK: clz     z21.b, p5/m, z10.b // encoding: [0x55,0xb5,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10110101-01010101
clz     z21.d, p5/m, z10.d  // 00000100-11011001-10110101-01010101
// CHECK: clz     z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-10110101-01010101
CLZ     Z21.D, P5/M, Z10.D  // 00000100-11011001-10110101-01010101
// CHECK: clz     z21.d, p5/m, z10.d // encoding: [0x55,0xb5,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-10110101-01010101
clz     z0.s, p0/m, z0.s  // 00000100-10011001-10100000-00000000
// CHECK: clz     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10100000-00000000
CLZ     Z0.S, P0/M, Z0.S  // 00000100-10011001-10100000-00000000
// CHECK: clz     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x99,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011001-10100000-00000000
clz     z0.b, p0/m, z0.b  // 00000100-00011001-10100000-00000000
// CHECK: clz     z0.b, p0/m, z0.b // encoding: [0x00,0xa0,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10100000-00000000
CLZ     Z0.B, P0/M, Z0.B  // 00000100-00011001-10100000-00000000
// CHECK: clz     z0.b, p0/m, z0.b // encoding: [0x00,0xa0,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10100000-00000000
clz     z0.d, p0/m, z0.d  // 00000100-11011001-10100000-00000000
// CHECK: clz     z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-10100000-00000000
CLZ     Z0.D, P0/M, Z0.D  // 00000100-11011001-10100000-00000000
// CHECK: clz     z0.d, p0/m, z0.d // encoding: [0x00,0xa0,0xd9,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011001-10100000-00000000
clz     z23.h, p3/m, z13.h  // 00000100-01011001-10101101-10110111
// CHECK: clz     z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10101101-10110111
CLZ     Z23.H, P3/M, Z13.H  // 00000100-01011001-10101101-10110111
// CHECK: clz     z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10101101-10110111
clz     z21.h, p5/m, z10.h  // 00000100-01011001-10110101-01010101
// CHECK: clz     z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10110101-01010101
CLZ     Z21.H, P5/M, Z10.H  // 00000100-01011001-10110101-01010101
// CHECK: clz     z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10110101-01010101
clz     z31.b, p7/m, z31.b  // 00000100-00011001-10111111-11111111
// CHECK: clz     z31.b, p7/m, z31.b // encoding: [0xff,0xbf,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10111111-11111111
CLZ     Z31.B, P7/M, Z31.B  // 00000100-00011001-10111111-11111111
// CHECK: clz     z31.b, p7/m, z31.b // encoding: [0xff,0xbf,0x19,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011001-10111111-11111111
clz     z31.h, p7/m, z31.h  // 00000100-01011001-10111111-11111111
// CHECK: clz     z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10111111-11111111
CLZ     Z31.H, P7/M, Z31.H  // 00000100-01011001-10111111-11111111
// CHECK: clz     z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x59,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011001-10111111-11111111
