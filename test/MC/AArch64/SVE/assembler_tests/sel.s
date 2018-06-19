// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sel     z31.h, p15, z31.h, z31.h  // 00000101-01111111-11111111-11111111
// CHECK: mov     z31.h, p15/m, z31.h // encoding: [0xff,0xff,0x7f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01111111-11111111-11111111
SEL     Z31.H, P15, Z31.H, Z31.H  // 00000101-01111111-11111111-11111111
// CHECK: mov     z31.h, p15/m, z31.h // encoding: [0xff,0xff,0x7f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01111111-11111111-11111111
sel     p15.b, p15, p15.b, p15.b  // 00100101-00001111-01111111-11111111
// CHECK: mov     p15.b, p15/m, p15.b // encoding: [0xff,0x7f,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-01111111-11111111
SEL     P15.B, P15, P15.B, P15.B  // 00100101-00001111-01111111-11111111
// CHECK: mov     p15.b, p15/m, p15.b // encoding: [0xff,0x7f,0x0f,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001111-01111111-11111111
sel     z0.d, p0, z0.d, z0.d  // 00000101-11100000-11000000-00000000
// CHECK: mov     z0.d, p0/m, z0.d // encoding: [0x00,0xc0,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-11000000-00000000
SEL     Z0.D, P0, Z0.D, Z0.D  // 00000101-11100000-11000000-00000000
// CHECK: mov     z0.d, p0/m, z0.d // encoding: [0x00,0xc0,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-11000000-00000000
sel     z21.b, p5, z10.b, z21.b  // 00000101-00110101-11010101-01010101
// CHECK: mov     z21.b, p5/m, z10.b // encoding: [0x55,0xd5,0x35,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110101-11010101-01010101
SEL     Z21.B, P5, Z10.B, Z21.B  // 00000101-00110101-11010101-01010101
// CHECK: mov     z21.b, p5/m, z10.b // encoding: [0x55,0xd5,0x35,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110101-11010101-01010101
sel     p0.b, p0, p0.b, p0.b  // 00100101-00000000-01000010-00010000
// CHECK: mov     p0.b, p0/m, p0.b // encoding: [0x10,0x42,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-01000010-00010000
SEL     P0.B, P0, P0.B, P0.B  // 00100101-00000000-01000010-00010000
// CHECK: mov     p0.b, p0/m, p0.b // encoding: [0x10,0x42,0x00,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000000-01000010-00010000
sel     z23.s, p11, z13.s, z8.s  // 00000101-10101000-11101101-10110111
// CHECK: sel     z23.s, p11, z13.s, z8.s // encoding: [0xb7,0xed,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-11101101-10110111
SEL     Z23.S, P11, Z13.S, Z8.S  // 00000101-10101000-11101101-10110111
// CHECK: sel     z23.s, p11, z13.s, z8.s // encoding: [0xb7,0xed,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-11101101-10110111
sel     z23.d, p11, z13.d, z8.d  // 00000101-11101000-11101101-10110111
// CHECK: sel     z23.d, p11, z13.d, z8.d // encoding: [0xb7,0xed,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-11101101-10110111
SEL     Z23.D, P11, Z13.D, Z8.D  // 00000101-11101000-11101101-10110111
// CHECK: sel     z23.d, p11, z13.d, z8.d // encoding: [0xb7,0xed,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-11101101-10110111
sel     z0.s, p0, z0.s, z0.s  // 00000101-10100000-11000000-00000000
// CHECK: mov     z0.s, p0/m, z0.s // encoding: [0x00,0xc0,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-11000000-00000000
SEL     Z0.S, P0, Z0.S, Z0.S  // 00000101-10100000-11000000-00000000
// CHECK: mov     z0.s, p0/m, z0.s // encoding: [0x00,0xc0,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-11000000-00000000
sel     z31.s, p15, z31.s, z31.s  // 00000101-10111111-11111111-11111111
// CHECK: mov     z31.s, p15/m, z31.s // encoding: [0xff,0xff,0xbf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10111111-11111111-11111111
SEL     Z31.S, P15, Z31.S, Z31.S  // 00000101-10111111-11111111-11111111
// CHECK: mov     z31.s, p15/m, z31.s // encoding: [0xff,0xff,0xbf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10111111-11111111-11111111
sel     p7.b, p11, p13.b, p8.b  // 00100101-00001000-01101111-10110111
// CHECK: sel     p7.b, p11, p13.b, p8.b // encoding: [0xb7,0x6f,0x08,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001000-01101111-10110111
SEL     P7.B, P11, P13.B, P8.B  // 00100101-00001000-01101111-10110111
// CHECK: sel     p7.b, p11, p13.b, p8.b // encoding: [0xb7,0x6f,0x08,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00001000-01101111-10110111
sel     z21.s, p5, z10.s, z21.s  // 00000101-10110101-11010101-01010101
// CHECK: mov     z21.s, p5/m, z10.s // encoding: [0x55,0xd5,0xb5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110101-11010101-01010101
SEL     Z21.S, P5, Z10.S, Z21.S  // 00000101-10110101-11010101-01010101
// CHECK: mov     z21.s, p5/m, z10.s // encoding: [0x55,0xd5,0xb5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110101-11010101-01010101
sel     z21.d, p5, z10.d, z21.d  // 00000101-11110101-11010101-01010101
// CHECK: mov     z21.d, p5/m, z10.d // encoding: [0x55,0xd5,0xf5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110101-11010101-01010101
SEL     Z21.D, P5, Z10.D, Z21.D  // 00000101-11110101-11010101-01010101
// CHECK: mov     z21.d, p5/m, z10.d // encoding: [0x55,0xd5,0xf5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110101-11010101-01010101
sel     z31.d, p15, z31.d, z31.d  // 00000101-11111111-11111111-11111111
// CHECK: mov     z31.d, p15/m, z31.d // encoding: [0xff,0xff,0xff,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111111-11111111-11111111
SEL     Z31.D, P15, Z31.D, Z31.D  // 00000101-11111111-11111111-11111111
// CHECK: mov     z31.d, p15/m, z31.d // encoding: [0xff,0xff,0xff,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111111-11111111-11111111
sel     z23.h, p11, z13.h, z8.h  // 00000101-01101000-11101101-10110111
// CHECK: sel     z23.h, p11, z13.h, z8.h // encoding: [0xb7,0xed,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-11101101-10110111
SEL     Z23.H, P11, Z13.H, Z8.H  // 00000101-01101000-11101101-10110111
// CHECK: sel     z23.h, p11, z13.h, z8.h // encoding: [0xb7,0xed,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-11101101-10110111
sel     z23.b, p11, z13.b, z8.b  // 00000101-00101000-11101101-10110111
// CHECK: sel     z23.b, p11, z13.b, z8.b // encoding: [0xb7,0xed,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-11101101-10110111
SEL     Z23.B, P11, Z13.B, Z8.B  // 00000101-00101000-11101101-10110111
// CHECK: sel     z23.b, p11, z13.b, z8.b // encoding: [0xb7,0xed,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-11101101-10110111
sel     z0.b, p0, z0.b, z0.b  // 00000101-00100000-11000000-00000000
// CHECK: mov     z0.b, p0/m, z0.b // encoding: [0x00,0xc0,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-11000000-00000000
SEL     Z0.B, P0, Z0.B, Z0.B  // 00000101-00100000-11000000-00000000
// CHECK: mov     z0.b, p0/m, z0.b // encoding: [0x00,0xc0,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-11000000-00000000
sel     z21.h, p5, z10.h, z21.h  // 00000101-01110101-11010101-01010101
// CHECK: mov     z21.h, p5/m, z10.h // encoding: [0x55,0xd5,0x75,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110101-11010101-01010101
SEL     Z21.H, P5, Z10.H, Z21.H  // 00000101-01110101-11010101-01010101
// CHECK: mov     z21.h, p5/m, z10.h // encoding: [0x55,0xd5,0x75,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110101-11010101-01010101
sel     p5.b, p5, p10.b, p5.b  // 00100101-00000101-01010111-01010101
// CHECK: mov     p5.b, p5/m, p10.b // encoding: [0x55,0x57,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-01010111-01010101
SEL     P5.B, P5, P10.B, P5.B  // 00100101-00000101-01010111-01010101
// CHECK: mov     p5.b, p5/m, p10.b // encoding: [0x55,0x57,0x05,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00000101-01010111-01010101
sel     z31.b, p15, z31.b, z31.b  // 00000101-00111111-11111111-11111111
// CHECK: mov     z31.b, p15/m, z31.b // encoding: [0xff,0xff,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00111111-11111111-11111111
SEL     Z31.B, P15, Z31.B, Z31.B  // 00000101-00111111-11111111-11111111
// CHECK: mov     z31.b, p15/m, z31.b // encoding: [0xff,0xff,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00111111-11111111-11111111
sel     z0.h, p0, z0.h, z0.h  // 00000101-01100000-11000000-00000000
// CHECK: mov     z0.h, p0/m, z0.h // encoding: [0x00,0xc0,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-11000000-00000000
SEL     Z0.H, P0, Z0.H, Z0.H  // 00000101-01100000-11000000-00000000
// CHECK: mov     z0.h, p0/m, z0.h // encoding: [0x00,0xc0,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-11000000-00000000
