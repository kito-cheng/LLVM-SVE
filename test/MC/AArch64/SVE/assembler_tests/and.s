// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
and     z31.d, p7/m, z31.d, z31.d  // 00000100-11011010-00011111-11111111
// CHECK: and     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x1f,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00011111-11111111
AND     Z31.D, P7/M, Z31.D, Z31.D  // 00000100-11011010-00011111-11111111
// CHECK: and     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x1f,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00011111-11111111
and     z0.d, z0.d, z0.d  // 00000100-00100000-00110000-00000000
// CHECK: and     z0.d, z0.d, z0.d // encoding: [0x00,0x30,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-00110000-00000000
AND     Z0.D, Z0.D, Z0.D  // 00000100-00100000-00110000-00000000
// CHECK: and     z0.d, z0.d, z0.d // encoding: [0x00,0x30,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-00110000-00000000
and     p7.b, p11/z, p13.b, p8.b  // 00100101-00001000-01101101-10100111
// CHECK: and     p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0x6d,0x08,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001000-01101101-10100111
AND     P7.B, P11/Z, P13.B, P8.B  // 00100101-00001000-01101101-10100111
// CHECK: and     p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0x6d,0x08,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001000-01101101-10100111
and     z23.d, z13.d, z8.d  // 00000100-00101000-00110001-10110111
// CHECK: and     z23.d, z13.d, z8.d // encoding: [0xb7,0x31,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-00110001-10110111
AND     Z23.D, Z13.D, Z8.D  // 00000100-00101000-00110001-10110111
// CHECK: and     z23.d, z13.d, z8.d // encoding: [0xb7,0x31,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-00110001-10110111
and     z21.d, z10.d, z21.d  // 00000100-00110101-00110001-01010101
// CHECK: and     z21.d, z10.d, z21.d // encoding: [0x55,0x31,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-00110001-01010101
AND     Z21.D, Z10.D, Z21.D  // 00000100-00110101-00110001-01010101
// CHECK: and     z21.d, z10.d, z21.d // encoding: [0x55,0x31,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-00110001-01010101
and     z31.s, p7/m, z31.s, z31.s  // 00000100-10011010-00011111-11111111
// CHECK: and     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x1f,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00011111-11111111
AND     Z31.S, P7/M, Z31.S, Z31.S  // 00000100-10011010-00011111-11111111
// CHECK: and     z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x1f,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00011111-11111111
and     z23.h, p3/m, z23.h, z13.h  // 00000100-01011010-00001101-10110111
// CHECK: and     z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x0d,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00001101-10110111
AND     Z23.H, P3/M, Z23.H, Z13.H  // 00000100-01011010-00001101-10110111
// CHECK: and     z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x0d,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00001101-10110111
and     z23.h, z23.h, #0xfff9  // 00000101-10000000-11101101-10110111
// CHECK: and     z23.h, z23.h, #0xfff9 // encoding: [0xb7,0x6d,0x80,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10000000-11101101-10110111
AND     Z23.H, Z23.H, #0xFFF9  // 00000101-10000000-11101101-10110111
// CHECK: and     z23.h, z23.h, #0xfff9 // encoding: [0xb7,0x6d,0x80,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10000000-11101101-10110111
and     z21.d, p5/m, z21.d, z10.d  // 00000100-11011010-00010101-01010101
// CHECK: and     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x15,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00010101-01010101
AND     Z21.D, P5/M, Z21.D, Z10.D  // 00000100-11011010-00010101-01010101
// CHECK: and     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x15,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00010101-01010101
and     z23.b, p3/m, z23.b, z13.b  // 00000100-00011010-00001101-10110111
// CHECK: and     z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x0d,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00001101-10110111
AND     Z23.B, P3/M, Z23.B, Z13.B  // 00000100-00011010-00001101-10110111
// CHECK: and     z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x0d,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00001101-10110111
and     z31.h, p7/m, z31.h, z31.h  // 00000100-01011010-00011111-11111111
// CHECK: and     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x1f,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00011111-11111111
AND     Z31.H, P7/M, Z31.H, Z31.H  // 00000100-01011010-00011111-11111111
// CHECK: and     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x1f,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00011111-11111111
and     z21.s, p5/m, z21.s, z10.s  // 00000100-10011010-00010101-01010101
// CHECK: and     z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x15,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00010101-01010101
AND     Z21.S, P5/M, Z21.S, Z10.S  // 00000100-10011010-00010101-01010101
// CHECK: and     z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x15,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00010101-01010101
and     p0.b, p0/z, p0.b, p0.b  // 00100101-00000000-01000000-00000000
// CHECK: mov     p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-01000000-00000000
AND     P0.B, P0/Z, P0.B, P0.B  // 00100101-00000000-01000000-00000000
// CHECK: mov     p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-01000000-00000000
and     z0.s, p0/m, z0.s, z0.s  // 00000100-10011010-00000000-00000000
// CHECK: and     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x00,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00000000-00000000
AND     Z0.S, P0/M, Z0.S, Z0.S  // 00000100-10011010-00000000-00000000
// CHECK: and     z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x00,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00000000-00000000
and     z21.h, p5/m, z21.h, z10.h  // 00000100-01011010-00010101-01010101
// CHECK: and     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x15,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00010101-01010101
AND     Z21.H, P5/M, Z21.H, Z10.H  // 00000100-01011010-00010101-01010101
// CHECK: and     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x15,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00010101-01010101
and     p15.b, p15/z, p15.b, p15.b  // 00100101-00001111-01111101-11101111
// CHECK: mov     p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-01111101-11101111
AND     P15.B, P15/Z, P15.B, P15.B  // 00100101-00001111-01111101-11101111
// CHECK: mov     p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-01111101-11101111
and     p5.b, p5/z, p10.b, p5.b  // 00100101-00000101-01010101-01000101
// CHECK: and     p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x55,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-01010101-01000101
AND     P5.B, P5/Z, P10.B, P5.B  // 00100101-00000101-01010101-01000101
// CHECK: and     p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x55,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-01010101-01000101
and     z31.b, p7/m, z31.b, z31.b  // 00000100-00011010-00011111-11111111
// CHECK: and     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x1f,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00011111-11111111
AND     Z31.B, P7/M, Z31.B, Z31.B  // 00000100-00011010-00011111-11111111
// CHECK: and     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x1f,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00011111-11111111
and     z23.s, p3/m, z23.s, z13.s  // 00000100-10011010-00001101-10110111
// CHECK: and     z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x0d,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00001101-10110111
AND     Z23.S, P3/M, Z23.S, Z13.S  // 00000100-10011010-00001101-10110111
// CHECK: and     z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x0d,0x9a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10011010-00001101-10110111
and     z31.d, z31.d, z31.d  // 00000100-00111111-00110011-11111111
// CHECK: and     z31.d, z31.d, z31.d // encoding: [0xff,0x33,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-00110011-11111111
AND     Z31.D, Z31.D, Z31.D  // 00000100-00111111-00110011-11111111
// CHECK: and     z31.d, z31.d, z31.d // encoding: [0xff,0x33,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-00110011-11111111
and     z23.d, p3/m, z23.d, z13.d  // 00000100-11011010-00001101-10110111
// CHECK: and     z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x0d,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00001101-10110111
AND     Z23.D, P3/M, Z23.D, Z13.D  // 00000100-11011010-00001101-10110111
// CHECK: and     z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x0d,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00001101-10110111
and     z0.h, p0/m, z0.h, z0.h  // 00000100-01011010-00000000-00000000
// CHECK: and     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x00,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00000000-00000000
AND     Z0.H, P0/M, Z0.H, Z0.H  // 00000100-01011010-00000000-00000000
// CHECK: and     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x00,0x5a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01011010-00000000-00000000
and     z0.d, p0/m, z0.d, z0.d  // 00000100-11011010-00000000-00000000
// CHECK: and     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x00,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00000000-00000000
AND     Z0.D, P0/M, Z0.D, Z0.D  // 00000100-11011010-00000000-00000000
// CHECK: and     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x00,0xda,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11011010-00000000-00000000
and     z21.h, z21.h, #0xffc1  // 00000101-10000001-01010101-01010101
// CHECK: and     z21.h, z21.h, #0xffc1 // encoding: [0x55,0x55,0x80,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10000001-01010101-01010101
AND     Z21.H, Z21.H, #0xFFC1  // 00000101-10000001-01010101-01010101
// CHECK: and     z21.h, z21.h, #0xffc1 // encoding: [0x55,0x55,0x80,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10000001-01010101-01010101
and     z0.b, p0/m, z0.b, z0.b  // 00000100-00011010-00000000-00000000
// CHECK: and     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x00,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00000000-00000000
AND     Z0.B, P0/M, Z0.B, Z0.B  // 00000100-00011010-00000000-00000000
// CHECK: and     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x00,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00000000-00000000
and     z5.b, z5.b, #0x81  // 00000101-10000000-00001110-00100101
// CHECK: and     z5.b, z5.b, #0x81 // encoding: [0x25,0x0e,0x80,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10000000-00001110-00100101
AND     Z5.B, Z5.B, #0x81  // 00000101-10000000-00001110-00100101
// CHECK: and     z5.b, z5.b, #0x81 // encoding: [0x25,0x0e,0x80,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10000000-00001110-00100101
and     z0.s, z0.s, #0x1  // 00000101-10000000-00000000-00000000
// CHECK: and     z0.s, z0.s, #0x1 // encoding: [0x00,0x00,0x80,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10000000-00000000-00000000
AND     Z0.S, Z0.S, #0x1  // 00000101-10000000-00000000-00000000
// CHECK: and     z0.s, z0.s, #0x1 // encoding: [0x00,0x00,0x80,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10000000-00000000-00000000
and     z21.b, p5/m, z21.b, z10.b  // 00000100-00011010-00010101-01010101
// CHECK: and     z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x15,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00010101-01010101
AND     Z21.B, P5/M, Z21.B, Z10.B  // 00000100-00011010-00010101-01010101
// CHECK: and     z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x15,0x1a,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00011010-00010101-01010101
