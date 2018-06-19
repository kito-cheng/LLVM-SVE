// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldnf1b  {z0.b}, p0/z, [x0]  // 10100100-00010000-10100000-00000000
// CHECK: ldnf1b  {z0.b}, p0/z, [x0] // encoding: [0x00,0xa0,0x10,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010000-10100000-00000000
LDNF1B  {Z0.B}, P0/Z, [X0]  // 10100100-00010000-10100000-00000000
// CHECK: ldnf1b  {z0.b}, p0/z, [x0] // encoding: [0x00,0xa0,0x10,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010000-10100000-00000000
ldnf1b  {z23.s}, p3/z, [x13, #-8, mul vl]  // 10100100-01011000-10101101-10110111
// CHECK: ldnf1b  {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x58,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01011000-10101101-10110111
LDNF1B  {Z23.S}, P3/Z, [X13, #-8, MUL VL]  // 10100100-01011000-10101101-10110111
// CHECK: ldnf1b  {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x58,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01011000-10101101-10110111
ldnf1b  {z31.b}, p7/z, [sp, #-1, mul vl]  // 10100100-00011111-10111111-11111111
// CHECK: ldnf1b  {z31.b}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x1f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00011111-10111111-11111111
LDNF1B  {Z31.B}, P7/Z, [SP, #-1, MUL VL]  // 10100100-00011111-10111111-11111111
// CHECK: ldnf1b  {z31.b}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x1f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00011111-10111111-11111111
ldnf1b  {z23.b}, p3/z, [x13, #-8, mul vl]  // 10100100-00011000-10101101-10110111
// CHECK: ldnf1b  {z23.b}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x18,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00011000-10101101-10110111
LDNF1B  {Z23.B}, P3/Z, [X13, #-8, MUL VL]  // 10100100-00011000-10101101-10110111
// CHECK: ldnf1b  {z23.b}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x18,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00011000-10101101-10110111
ldnf1b  {z31.d}, p7/z, [sp, #-1, mul vl]  // 10100100-01111111-10111111-11111111
// CHECK: ldnf1b  {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x7f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01111111-10111111-11111111
LDNF1B  {Z31.D}, P7/Z, [SP, #-1, MUL VL]  // 10100100-01111111-10111111-11111111
// CHECK: ldnf1b  {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x7f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01111111-10111111-11111111
ldnf1b  {z23.d}, p3/z, [x13, #-8, mul vl]  // 10100100-01111000-10101101-10110111
// CHECK: ldnf1b  {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x78,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01111000-10101101-10110111
LDNF1B  {Z23.D}, P3/Z, [X13, #-8, MUL VL]  // 10100100-01111000-10101101-10110111
// CHECK: ldnf1b  {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x78,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01111000-10101101-10110111
ldnf1b  {z21.h}, p5/z, [x10, #5, mul vl]  // 10100100-00110101-10110101-01010101
// CHECK: ldnf1b  {z21.h}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x35,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00110101-10110101-01010101
LDNF1B  {Z21.H}, P5/Z, [X10, #5, MUL VL]  // 10100100-00110101-10110101-01010101
// CHECK: ldnf1b  {z21.h}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x35,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00110101-10110101-01010101
ldnf1b  {z31.h}, p7/z, [sp, #-1, mul vl]  // 10100100-00111111-10111111-11111111
// CHECK: ldnf1b  {z31.h}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x3f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00111111-10111111-11111111
LDNF1B  {Z31.H}, P7/Z, [SP, #-1, MUL VL]  // 10100100-00111111-10111111-11111111
// CHECK: ldnf1b  {z31.h}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x3f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00111111-10111111-11111111
ldnf1b  {z0.d}, p0/z, [x0]  // 10100100-01110000-10100000-00000000
// CHECK: ldnf1b  {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x70,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110000-10100000-00000000
LDNF1B  {Z0.D}, P0/Z, [X0]  // 10100100-01110000-10100000-00000000
// CHECK: ldnf1b  {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x70,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110000-10100000-00000000
ldnf1b  {z0.h}, p0/z, [x0]  // 10100100-00110000-10100000-00000000
// CHECK: ldnf1b  {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0x30,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00110000-10100000-00000000
LDNF1B  {Z0.H}, P0/Z, [X0]  // 10100100-00110000-10100000-00000000
// CHECK: ldnf1b  {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0x30,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00110000-10100000-00000000
ldnf1b  {z23.h}, p3/z, [x13, #-8, mul vl]  // 10100100-00111000-10101101-10110111
// CHECK: ldnf1b  {z23.h}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x38,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00111000-10101101-10110111
LDNF1B  {Z23.H}, P3/Z, [X13, #-8, MUL VL]  // 10100100-00111000-10101101-10110111
// CHECK: ldnf1b  {z23.h}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x38,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00111000-10101101-10110111
ldnf1b  {z0.s}, p0/z, [x0]  // 10100100-01010000-10100000-00000000
// CHECK: ldnf1b  {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0x50,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01010000-10100000-00000000
LDNF1B  {Z0.S}, P0/Z, [X0]  // 10100100-01010000-10100000-00000000
// CHECK: ldnf1b  {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0x50,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01010000-10100000-00000000
ldnf1b  {z21.d}, p5/z, [x10, #5, mul vl]  // 10100100-01110101-10110101-01010101
// CHECK: ldnf1b  {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x75,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110101-10110101-01010101
LDNF1B  {Z21.D}, P5/Z, [X10, #5, MUL VL]  // 10100100-01110101-10110101-01010101
// CHECK: ldnf1b  {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x75,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110101-10110101-01010101
ldnf1b  {z31.s}, p7/z, [sp, #-1, mul vl]  // 10100100-01011111-10111111-11111111
// CHECK: ldnf1b  {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x5f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01011111-10111111-11111111
LDNF1B  {Z31.S}, P7/Z, [SP, #-1, MUL VL]  // 10100100-01011111-10111111-11111111
// CHECK: ldnf1b  {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x5f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01011111-10111111-11111111
ldnf1b  {z21.b}, p5/z, [x10, #5, mul vl]  // 10100100-00010101-10110101-01010101
// CHECK: ldnf1b  {z21.b}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x15,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010101-10110101-01010101
LDNF1B  {Z21.B}, P5/Z, [X10, #5, MUL VL]  // 10100100-00010101-10110101-01010101
// CHECK: ldnf1b  {z21.b}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x15,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010101-10110101-01010101
ldnf1b  {z21.s}, p5/z, [x10, #5, mul vl]  // 10100100-01010101-10110101-01010101
// CHECK: ldnf1b  {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x55,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01010101-10110101-01010101
LDNF1B  {Z21.S}, P5/Z, [X10, #5, MUL VL]  // 10100100-01010101-10110101-01010101
// CHECK: ldnf1b  {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x55,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01010101-10110101-01010101
