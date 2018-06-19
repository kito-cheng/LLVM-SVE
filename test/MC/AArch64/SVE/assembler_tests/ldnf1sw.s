// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldnf1sw {z0.d}, p0/z, [x0]  // 10100100-10010000-10100000-00000000
// CHECK: ldnf1sw {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x90,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10010000-10100000-00000000
LDNF1SW {Z0.D}, P0/Z, [X0]  // 10100100-10010000-10100000-00000000
// CHECK: ldnf1sw {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x90,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10010000-10100000-00000000
ldnf1sw {z23.d}, p3/z, [x13, #-8, mul vl]  // 10100100-10011000-10101101-10110111
// CHECK: ldnf1sw {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x98,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10011000-10101101-10110111
LDNF1SW {Z23.D}, P3/Z, [X13, #-8, MUL VL]  // 10100100-10011000-10101101-10110111
// CHECK: ldnf1sw {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x98,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10011000-10101101-10110111
ldnf1sw {z21.d}, p5/z, [x10, #5, mul vl]  // 10100100-10010101-10110101-01010101
// CHECK: ldnf1sw {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x95,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10010101-10110101-01010101
LDNF1SW {Z21.D}, P5/Z, [X10, #5, MUL VL]  // 10100100-10010101-10110101-01010101
// CHECK: ldnf1sw {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x95,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10010101-10110101-01010101
ldnf1sw {z31.d}, p7/z, [sp, #-1, mul vl]  // 10100100-10011111-10111111-11111111
// CHECK: ldnf1sw {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x9f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10011111-10111111-11111111
LDNF1SW {Z31.D}, P7/Z, [SP, #-1, MUL VL]  // 10100100-10011111-10111111-11111111
// CHECK: ldnf1sw {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x9f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10011111-10111111-11111111
