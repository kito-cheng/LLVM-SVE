// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
stnt1d  {z23.d}, p3, [x13, #-8, mul vl]  // 11100101-10011000-11101101-10110111
// CHECK: stnt1d  {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x98,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10011000-11101101-10110111
STNT1D  {Z23.D}, P3, [X13, #-8, MUL VL]  // 11100101-10011000-11101101-10110111
// CHECK: stnt1d  {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x98,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10011000-11101101-10110111
stnt1d  {z0.d}, p0, [x0, x0, lsl #3]  // 11100101-10000000-01100000-00000000
// CHECK: stnt1d  {z0.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x60,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-01100000-00000000
STNT1D  {Z0.D}, P0, [X0, X0, LSL #3]  // 11100101-10000000-01100000-00000000
// CHECK: stnt1d  {z0.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x60,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-01100000-00000000
stnt1d  {z0.d}, p0, [x0]  // 11100101-10010000-11100000-00000000
// CHECK: stnt1d  {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0x90,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010000-11100000-00000000
STNT1D  {Z0.D}, P0, [X0]  // 11100101-10010000-11100000-00000000
// CHECK: stnt1d  {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0x90,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010000-11100000-00000000
stnt1d  {z5.d}, p3, [x17, x16, lsl #3]  // 11100101-10010000-01101110-00100101
// CHECK: stnt1d  {z5.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x6e,0x90,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010000-01101110-00100101
STNT1D  {Z5.D}, P3, [X17, X16, LSL #3]  // 11100101-10010000-01101110-00100101
// CHECK: stnt1d  {z5.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x6e,0x90,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010000-01101110-00100101
stnt1d  {z21.d}, p5, [x10, #5, mul vl]  // 11100101-10010101-11110101-01010101
// CHECK: stnt1d  {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-11110101-01010101
STNT1D  {Z21.D}, P5, [X10, #5, MUL VL]  // 11100101-10010101-11110101-01010101
// CHECK: stnt1d  {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-11110101-01010101
stnt1d  {z23.d}, p3, [x13, x8, lsl #3]  // 11100101-10001000-01101101-10110111
// CHECK: stnt1d  {z23.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x6d,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-01101101-10110111
STNT1D  {Z23.D}, P3, [X13, X8, LSL #3]  // 11100101-10001000-01101101-10110111
// CHECK: stnt1d  {z23.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x6d,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-01101101-10110111
stnt1d  {z31.d}, p7, [sp, #-1, mul vl]  // 11100101-10011111-11111111-11111111
// CHECK: stnt1d  {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x9f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10011111-11111111-11111111
STNT1D  {Z31.D}, P7, [SP, #-1, MUL VL]  // 11100101-10011111-11111111-11111111
// CHECK: stnt1d  {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x9f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10011111-11111111-11111111
stnt1d  {z21.d}, p5, [x10, x21, lsl #3]  // 11100101-10010101-01110101-01010101
// CHECK: stnt1d  {z21.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x75,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-01110101-01010101
STNT1D  {Z21.D}, P5, [X10, X21, LSL #3]  // 11100101-10010101-01110101-01010101
// CHECK: stnt1d  {z21.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x75,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-01110101-01010101
