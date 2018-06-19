// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uzp2    z31.b, z31.b, z31.b  // 00000101-00111111-01101111-11111111
// CHECK: uzp2    z31.b, z31.b, z31.b // encoding: [0xff,0x6f,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00111111-01101111-11111111
UZP2    Z31.B, Z31.B, Z31.B  // 00000101-00111111-01101111-11111111
// CHECK: uzp2    z31.b, z31.b, z31.b // encoding: [0xff,0x6f,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00111111-01101111-11111111
uzp2    p7.s, p13.s, p8.s  // 00000101-10101000-01001101-10100111
// CHECK: uzp2    p7.s, p13.s, p8.s // encoding: [0xa7,0x4d,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-01001101-10100111
UZP2    P7.S, P13.S, P8.S  // 00000101-10101000-01001101-10100111
// CHECK: uzp2    p7.s, p13.s, p8.s // encoding: [0xa7,0x4d,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-01001101-10100111
uzp2    z31.h, z31.h, z31.h  // 00000101-01111111-01101111-11111111
// CHECK: uzp2    z31.h, z31.h, z31.h // encoding: [0xff,0x6f,0x7f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01111111-01101111-11111111
UZP2    Z31.H, Z31.H, Z31.H  // 00000101-01111111-01101111-11111111
// CHECK: uzp2    z31.h, z31.h, z31.h // encoding: [0xff,0x6f,0x7f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01111111-01101111-11111111
uzp2    z23.h, z13.h, z8.h  // 00000101-01101000-01101101-10110111
// CHECK: uzp2    z23.h, z13.h, z8.h // encoding: [0xb7,0x6d,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-01101101-10110111
UZP2    Z23.H, Z13.H, Z8.H  // 00000101-01101000-01101101-10110111
// CHECK: uzp2    z23.h, z13.h, z8.h // encoding: [0xb7,0x6d,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-01101101-10110111
uzp2    z21.h, z10.h, z21.h  // 00000101-01110101-01101101-01010101
// CHECK: uzp2    z21.h, z10.h, z21.h // encoding: [0x55,0x6d,0x75,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110101-01101101-01010101
UZP2    Z21.H, Z10.H, Z21.H  // 00000101-01110101-01101101-01010101
// CHECK: uzp2    z21.h, z10.h, z21.h // encoding: [0x55,0x6d,0x75,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110101-01101101-01010101
uzp2    p15.s, p15.s, p15.s  // 00000101-10101111-01001101-11101111
// CHECK: uzp2    p15.s, p15.s, p15.s // encoding: [0xef,0x4d,0xaf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101111-01001101-11101111
UZP2    P15.S, P15.S, P15.S  // 00000101-10101111-01001101-11101111
// CHECK: uzp2    p15.s, p15.s, p15.s // encoding: [0xef,0x4d,0xaf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101111-01001101-11101111
uzp2    z0.s, z0.s, z0.s  // 00000101-10100000-01101100-00000000
// CHECK: uzp2    z0.s, z0.s, z0.s // encoding: [0x00,0x6c,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-01101100-00000000
UZP2    Z0.S, Z0.S, Z0.S  // 00000101-10100000-01101100-00000000
// CHECK: uzp2    z0.s, z0.s, z0.s // encoding: [0x00,0x6c,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-01101100-00000000
uzp2    z21.b, z10.b, z21.b  // 00000101-00110101-01101101-01010101
// CHECK: uzp2    z21.b, z10.b, z21.b // encoding: [0x55,0x6d,0x35,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110101-01101101-01010101
UZP2    Z21.B, Z10.B, Z21.B  // 00000101-00110101-01101101-01010101
// CHECK: uzp2    z21.b, z10.b, z21.b // encoding: [0x55,0x6d,0x35,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110101-01101101-01010101
uzp2    z0.b, z0.b, z0.b  // 00000101-00100000-01101100-00000000
// CHECK: uzp2    z0.b, z0.b, z0.b // encoding: [0x00,0x6c,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-01101100-00000000
UZP2    Z0.B, Z0.B, Z0.B  // 00000101-00100000-01101100-00000000
// CHECK: uzp2    z0.b, z0.b, z0.b // encoding: [0x00,0x6c,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-01101100-00000000
uzp2    p7.h, p13.h, p8.h  // 00000101-01101000-01001101-10100111
// CHECK: uzp2    p7.h, p13.h, p8.h // encoding: [0xa7,0x4d,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-01001101-10100111
UZP2    P7.H, P13.H, P8.H  // 00000101-01101000-01001101-10100111
// CHECK: uzp2    p7.h, p13.h, p8.h // encoding: [0xa7,0x4d,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-01001101-10100111
uzp2    p5.h, p10.h, p5.h  // 00000101-01100101-01001101-01000101
// CHECK: uzp2    p5.h, p10.h, p5.h // encoding: [0x45,0x4d,0x65,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100101-01001101-01000101
UZP2    P5.H, P10.H, P5.H  // 00000101-01100101-01001101-01000101
// CHECK: uzp2    p5.h, p10.h, p5.h // encoding: [0x45,0x4d,0x65,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100101-01001101-01000101
uzp2    p0.s, p0.s, p0.s  // 00000101-10100000-01001100-00000000
// CHECK: uzp2    p0.s, p0.s, p0.s // encoding: [0x00,0x4c,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-01001100-00000000
UZP2    P0.S, P0.S, P0.S  // 00000101-10100000-01001100-00000000
// CHECK: uzp2    p0.s, p0.s, p0.s // encoding: [0x00,0x4c,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-01001100-00000000
uzp2    z31.d, z31.d, z31.d  // 00000101-11111111-01101111-11111111
// CHECK: uzp2    z31.d, z31.d, z31.d // encoding: [0xff,0x6f,0xff,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111111-01101111-11111111
UZP2    Z31.D, Z31.D, Z31.D  // 00000101-11111111-01101111-11111111
// CHECK: uzp2    z31.d, z31.d, z31.d // encoding: [0xff,0x6f,0xff,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111111-01101111-11111111
uzp2    z23.s, z13.s, z8.s  // 00000101-10101000-01101101-10110111
// CHECK: uzp2    z23.s, z13.s, z8.s // encoding: [0xb7,0x6d,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-01101101-10110111
UZP2    Z23.S, Z13.S, Z8.S  // 00000101-10101000-01101101-10110111
// CHECK: uzp2    z23.s, z13.s, z8.s // encoding: [0xb7,0x6d,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-01101101-10110111
uzp2    z21.s, z10.s, z21.s  // 00000101-10110101-01101101-01010101
// CHECK: uzp2    z21.s, z10.s, z21.s // encoding: [0x55,0x6d,0xb5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110101-01101101-01010101
UZP2    Z21.S, Z10.S, Z21.S  // 00000101-10110101-01101101-01010101
// CHECK: uzp2    z21.s, z10.s, z21.s // encoding: [0x55,0x6d,0xb5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110101-01101101-01010101
uzp2    p0.b, p0.b, p0.b  // 00000101-00100000-01001100-00000000
// CHECK: uzp2    p0.b, p0.b, p0.b // encoding: [0x00,0x4c,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-01001100-00000000
UZP2    P0.B, P0.B, P0.B  // 00000101-00100000-01001100-00000000
// CHECK: uzp2    p0.b, p0.b, p0.b // encoding: [0x00,0x4c,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-01001100-00000000
uzp2    p15.h, p15.h, p15.h  // 00000101-01101111-01001101-11101111
// CHECK: uzp2    p15.h, p15.h, p15.h // encoding: [0xef,0x4d,0x6f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101111-01001101-11101111
UZP2    P15.H, P15.H, P15.H  // 00000101-01101111-01001101-11101111
// CHECK: uzp2    p15.h, p15.h, p15.h // encoding: [0xef,0x4d,0x6f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101111-01001101-11101111
uzp2    p7.b, p13.b, p8.b  // 00000101-00101000-01001101-10100111
// CHECK: uzp2    p7.b, p13.b, p8.b // encoding: [0xa7,0x4d,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-01001101-10100111
UZP2    P7.B, P13.B, P8.B  // 00000101-00101000-01001101-10100111
// CHECK: uzp2    p7.b, p13.b, p8.b // encoding: [0xa7,0x4d,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-01001101-10100111
uzp2    z21.d, z10.d, z21.d  // 00000101-11110101-01101101-01010101
// CHECK: uzp2    z21.d, z10.d, z21.d // encoding: [0x55,0x6d,0xf5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110101-01101101-01010101
UZP2    Z21.D, Z10.D, Z21.D  // 00000101-11110101-01101101-01010101
// CHECK: uzp2    z21.d, z10.d, z21.d // encoding: [0x55,0x6d,0xf5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110101-01101101-01010101
uzp2    z23.b, z13.b, z8.b  // 00000101-00101000-01101101-10110111
// CHECK: uzp2    z23.b, z13.b, z8.b // encoding: [0xb7,0x6d,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-01101101-10110111
UZP2    Z23.B, Z13.B, Z8.B  // 00000101-00101000-01101101-10110111
// CHECK: uzp2    z23.b, z13.b, z8.b // encoding: [0xb7,0x6d,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-01101101-10110111
uzp2    p5.s, p10.s, p5.s  // 00000101-10100101-01001101-01000101
// CHECK: uzp2    p5.s, p10.s, p5.s // encoding: [0x45,0x4d,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100101-01001101-01000101
UZP2    P5.S, P10.S, P5.S  // 00000101-10100101-01001101-01000101
// CHECK: uzp2    p5.s, p10.s, p5.s // encoding: [0x45,0x4d,0xa5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100101-01001101-01000101
uzp2    z23.d, z13.d, z8.d  // 00000101-11101000-01101101-10110111
// CHECK: uzp2    z23.d, z13.d, z8.d // encoding: [0xb7,0x6d,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-01101101-10110111
UZP2    Z23.D, Z13.D, Z8.D  // 00000101-11101000-01101101-10110111
// CHECK: uzp2    z23.d, z13.d, z8.d // encoding: [0xb7,0x6d,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-01101101-10110111
uzp2    p5.b, p10.b, p5.b  // 00000101-00100101-01001101-01000101
// CHECK: uzp2    p5.b, p10.b, p5.b // encoding: [0x45,0x4d,0x25,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100101-01001101-01000101
UZP2    P5.B, P10.B, P5.B  // 00000101-00100101-01001101-01000101
// CHECK: uzp2    p5.b, p10.b, p5.b // encoding: [0x45,0x4d,0x25,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100101-01001101-01000101
uzp2    p15.d, p15.d, p15.d  // 00000101-11101111-01001101-11101111
// CHECK: uzp2    p15.d, p15.d, p15.d // encoding: [0xef,0x4d,0xef,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101111-01001101-11101111
UZP2    P15.D, P15.D, P15.D  // 00000101-11101111-01001101-11101111
// CHECK: uzp2    p15.d, p15.d, p15.d // encoding: [0xef,0x4d,0xef,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101111-01001101-11101111
uzp2    z0.h, z0.h, z0.h  // 00000101-01100000-01101100-00000000
// CHECK: uzp2    z0.h, z0.h, z0.h // encoding: [0x00,0x6c,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-01101100-00000000
UZP2    Z0.H, Z0.H, Z0.H  // 00000101-01100000-01101100-00000000
// CHECK: uzp2    z0.h, z0.h, z0.h // encoding: [0x00,0x6c,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-01101100-00000000
uzp2    z31.s, z31.s, z31.s  // 00000101-10111111-01101111-11111111
// CHECK: uzp2    z31.s, z31.s, z31.s // encoding: [0xff,0x6f,0xbf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10111111-01101111-11111111
UZP2    Z31.S, Z31.S, Z31.S  // 00000101-10111111-01101111-11111111
// CHECK: uzp2    z31.s, z31.s, z31.s // encoding: [0xff,0x6f,0xbf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10111111-01101111-11111111
uzp2    z0.d, z0.d, z0.d  // 00000101-11100000-01101100-00000000
// CHECK: uzp2    z0.d, z0.d, z0.d // encoding: [0x00,0x6c,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-01101100-00000000
UZP2    Z0.D, Z0.D, Z0.D  // 00000101-11100000-01101100-00000000
// CHECK: uzp2    z0.d, z0.d, z0.d // encoding: [0x00,0x6c,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-01101100-00000000
uzp2    p0.d, p0.d, p0.d  // 00000101-11100000-01001100-00000000
// CHECK: uzp2    p0.d, p0.d, p0.d // encoding: [0x00,0x4c,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-01001100-00000000
UZP2    P0.D, P0.D, P0.D  // 00000101-11100000-01001100-00000000
// CHECK: uzp2    p0.d, p0.d, p0.d // encoding: [0x00,0x4c,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-01001100-00000000
uzp2    p0.h, p0.h, p0.h  // 00000101-01100000-01001100-00000000
// CHECK: uzp2    p0.h, p0.h, p0.h // encoding: [0x00,0x4c,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-01001100-00000000
UZP2    P0.H, P0.H, P0.H  // 00000101-01100000-01001100-00000000
// CHECK: uzp2    p0.h, p0.h, p0.h // encoding: [0x00,0x4c,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-01001100-00000000
uzp2    p5.d, p10.d, p5.d  // 00000101-11100101-01001101-01000101
// CHECK: uzp2    p5.d, p10.d, p5.d // encoding: [0x45,0x4d,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100101-01001101-01000101
UZP2    P5.D, P10.D, P5.D  // 00000101-11100101-01001101-01000101
// CHECK: uzp2    p5.d, p10.d, p5.d // encoding: [0x45,0x4d,0xe5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100101-01001101-01000101
uzp2    p15.b, p15.b, p15.b  // 00000101-00101111-01001101-11101111
// CHECK: uzp2    p15.b, p15.b, p15.b // encoding: [0xef,0x4d,0x2f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101111-01001101-11101111
UZP2    P15.B, P15.B, P15.B  // 00000101-00101111-01001101-11101111
// CHECK: uzp2    p15.b, p15.b, p15.b // encoding: [0xef,0x4d,0x2f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101111-01001101-11101111
uzp2    p7.d, p13.d, p8.d  // 00000101-11101000-01001101-10100111
// CHECK: uzp2    p7.d, p13.d, p8.d // encoding: [0xa7,0x4d,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-01001101-10100111
UZP2    P7.D, P13.D, P8.D  // 00000101-11101000-01001101-10100111
// CHECK: uzp2    p7.d, p13.d, p8.d // encoding: [0xa7,0x4d,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-01001101-10100111
