// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldnf1w  {z0.s}, p0/z, [x0]  // 10100101-01010000-10100000-00000000
// CHECK: ldnf1w  {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0x50,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01010000-10100000-00000000
LDNF1W  {Z0.S}, P0/Z, [X0]  // 10100101-01010000-10100000-00000000
// CHECK: ldnf1w  {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0x50,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01010000-10100000-00000000
ldnf1w  {z21.d}, p5/z, [x10, #5, mul vl]  // 10100101-01110101-10110101-01010101
// CHECK: ldnf1w  {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x75,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01110101-10110101-01010101
LDNF1W  {Z21.D}, P5/Z, [X10, #5, MUL VL]  // 10100101-01110101-10110101-01010101
// CHECK: ldnf1w  {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x75,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01110101-10110101-01010101
ldnf1w  {z23.d}, p3/z, [x13, #-8, mul vl]  // 10100101-01111000-10101101-10110111
// CHECK: ldnf1w  {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x78,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01111000-10101101-10110111
LDNF1W  {Z23.D}, P3/Z, [X13, #-8, MUL VL]  // 10100101-01111000-10101101-10110111
// CHECK: ldnf1w  {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x78,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01111000-10101101-10110111
ldnf1w  {z23.s}, p3/z, [x13, #-8, mul vl]  // 10100101-01011000-10101101-10110111
// CHECK: ldnf1w  {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x58,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01011000-10101101-10110111
LDNF1W  {Z23.S}, P3/Z, [X13, #-8, MUL VL]  // 10100101-01011000-10101101-10110111
// CHECK: ldnf1w  {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x58,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01011000-10101101-10110111
ldnf1w  {z0.d}, p0/z, [x0]  // 10100101-01110000-10100000-00000000
// CHECK: ldnf1w  {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x70,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01110000-10100000-00000000
LDNF1W  {Z0.D}, P0/Z, [X0]  // 10100101-01110000-10100000-00000000
// CHECK: ldnf1w  {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x70,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01110000-10100000-00000000
ldnf1w  {z31.d}, p7/z, [sp, #-1, mul vl]  // 10100101-01111111-10111111-11111111
// CHECK: ldnf1w  {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x7f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01111111-10111111-11111111
LDNF1W  {Z31.D}, P7/Z, [SP, #-1, MUL VL]  // 10100101-01111111-10111111-11111111
// CHECK: ldnf1w  {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x7f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01111111-10111111-11111111
ldnf1w  {z31.s}, p7/z, [sp, #-1, mul vl]  // 10100101-01011111-10111111-11111111
// CHECK: ldnf1w  {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x5f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01011111-10111111-11111111
LDNF1W  {Z31.S}, P7/Z, [SP, #-1, MUL VL]  // 10100101-01011111-10111111-11111111
// CHECK: ldnf1w  {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x5f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01011111-10111111-11111111
ldnf1w  {z21.s}, p5/z, [x10, #5, mul vl]  // 10100101-01010101-10110101-01010101
// CHECK: ldnf1w  {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x55,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01010101-10110101-01010101
LDNF1W  {Z21.S}, P5/Z, [X10, #5, MUL VL]  // 10100101-01010101-10110101-01010101
// CHECK: ldnf1w  {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x55,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-01010101-10110101-01010101
