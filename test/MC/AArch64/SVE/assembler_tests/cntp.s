// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cntp    x23, p11, p13.s  // 00100101-10100000-10101101-10110111
// CHECK: cntp    x23, p11, p13.s // encoding: [0xb7,0xad,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-10101101-10110111
CNTP    X23, P11, P13.S  // 00100101-10100000-10101101-10110111
// CHECK: cntp    x23, p11, p13.s // encoding: [0xb7,0xad,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-10101101-10110111
cntp    x0, p0, p0.s  // 00100101-10100000-10000000-00000000
// CHECK: cntp    x0, p0, p0.s // encoding: [0x00,0x80,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-10000000-00000000
CNTP    X0, P0, P0.S  // 00100101-10100000-10000000-00000000
// CHECK: cntp    x0, p0, p0.s // encoding: [0x00,0x80,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-10000000-00000000
cntp    x0, p0, p0.h  // 00100101-01100000-10000000-00000000
// CHECK: cntp    x0, p0, p0.h // encoding: [0x00,0x80,0x60,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01100000-10000000-00000000
CNTP    X0, P0, P0.H  // 00100101-01100000-10000000-00000000
// CHECK: cntp    x0, p0, p0.h // encoding: [0x00,0x80,0x60,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01100000-10000000-00000000
cntp    xzr, p15, p15.d  // 00100101-11100000-10111101-11111111
// CHECK: cntp    xzr, p15, p15.d // encoding: [0xff,0xbd,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-10111101-11111111
CNTP    XZR, P15, P15.D  // 00100101-11100000-10111101-11111111
// CHECK: cntp    xzr, p15, p15.d // encoding: [0xff,0xbd,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-10111101-11111111
cntp    x21, p5, p10.h  // 00100101-01100000-10010101-01010101
// CHECK: cntp    x21, p5, p10.h // encoding: [0x55,0x95,0x60,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01100000-10010101-01010101
CNTP    X21, P5, P10.H  // 00100101-01100000-10010101-01010101
// CHECK: cntp    x21, p5, p10.h // encoding: [0x55,0x95,0x60,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01100000-10010101-01010101
cntp    x23, p11, p13.d  // 00100101-11100000-10101101-10110111
// CHECK: cntp    x23, p11, p13.d // encoding: [0xb7,0xad,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-10101101-10110111
CNTP    X23, P11, P13.D  // 00100101-11100000-10101101-10110111
// CHECK: cntp    x23, p11, p13.d // encoding: [0xb7,0xad,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-10101101-10110111
cntp    xzr, p15, p15.b  // 00100101-00100000-10111101-11111111
// CHECK: cntp    xzr, p15, p15.b // encoding: [0xff,0xbd,0x20,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00100000-10111101-11111111
CNTP    XZR, P15, P15.B  // 00100101-00100000-10111101-11111111
// CHECK: cntp    xzr, p15, p15.b // encoding: [0xff,0xbd,0x20,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00100000-10111101-11111111
cntp    x0, p0, p0.b  // 00100101-00100000-10000000-00000000
// CHECK: cntp    x0, p0, p0.b // encoding: [0x00,0x80,0x20,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00100000-10000000-00000000
CNTP    X0, P0, P0.B  // 00100101-00100000-10000000-00000000
// CHECK: cntp    x0, p0, p0.b // encoding: [0x00,0x80,0x20,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00100000-10000000-00000000
cntp    xzr, p15, p15.h  // 00100101-01100000-10111101-11111111
// CHECK: cntp    xzr, p15, p15.h // encoding: [0xff,0xbd,0x60,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01100000-10111101-11111111
CNTP    XZR, P15, P15.H  // 00100101-01100000-10111101-11111111
// CHECK: cntp    xzr, p15, p15.h // encoding: [0xff,0xbd,0x60,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01100000-10111101-11111111
cntp    x23, p11, p13.b  // 00100101-00100000-10101101-10110111
// CHECK: cntp    x23, p11, p13.b // encoding: [0xb7,0xad,0x20,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00100000-10101101-10110111
CNTP    X23, P11, P13.B  // 00100101-00100000-10101101-10110111
// CHECK: cntp    x23, p11, p13.b // encoding: [0xb7,0xad,0x20,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00100000-10101101-10110111
cntp    x21, p5, p10.b  // 00100101-00100000-10010101-01010101
// CHECK: cntp    x21, p5, p10.b // encoding: [0x55,0x95,0x20,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00100000-10010101-01010101
CNTP    X21, P5, P10.B  // 00100101-00100000-10010101-01010101
// CHECK: cntp    x21, p5, p10.b // encoding: [0x55,0x95,0x20,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-00100000-10010101-01010101
cntp    xzr, p15, p15.s  // 00100101-10100000-10111101-11111111
// CHECK: cntp    xzr, p15, p15.s // encoding: [0xff,0xbd,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-10111101-11111111
CNTP    XZR, P15, P15.S  // 00100101-10100000-10111101-11111111
// CHECK: cntp    xzr, p15, p15.s // encoding: [0xff,0xbd,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-10111101-11111111
cntp    x21, p5, p10.s  // 00100101-10100000-10010101-01010101
// CHECK: cntp    x21, p5, p10.s // encoding: [0x55,0x95,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-10010101-01010101
CNTP    X21, P5, P10.S  // 00100101-10100000-10010101-01010101
// CHECK: cntp    x21, p5, p10.s // encoding: [0x55,0x95,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-10010101-01010101
cntp    x0, p0, p0.d  // 00100101-11100000-10000000-00000000
// CHECK: cntp    x0, p0, p0.d // encoding: [0x00,0x80,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-10000000-00000000
CNTP    X0, P0, P0.D  // 00100101-11100000-10000000-00000000
// CHECK: cntp    x0, p0, p0.d // encoding: [0x00,0x80,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-10000000-00000000
cntp    x21, p5, p10.d  // 00100101-11100000-10010101-01010101
// CHECK: cntp    x21, p5, p10.d // encoding: [0x55,0x95,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-10010101-01010101
CNTP    X21, P5, P10.D  // 00100101-11100000-10010101-01010101
// CHECK: cntp    x21, p5, p10.d // encoding: [0x55,0x95,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-10010101-01010101
cntp    x23, p11, p13.h  // 00100101-01100000-10101101-10110111
// CHECK: cntp    x23, p11, p13.h // encoding: [0xb7,0xad,0x60,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01100000-10101101-10110111
CNTP    X23, P11, P13.H  // 00100101-01100000-10101101-10110111
// CHECK: cntp    x23, p11, p13.h // encoding: [0xb7,0xad,0x60,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01100000-10101101-10110111
