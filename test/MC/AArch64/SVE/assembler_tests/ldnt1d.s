// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldnt1d  {z21.d}, p5/z, [x10, x21, lsl #3]  // 10100101-10010101-11010101-01010101
// CHECK: ldnt1d  {z21.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0xd5,0x95,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10010101-11010101-01010101
LDNT1D  {Z21.D}, P5/Z, [X10, X21, LSL #3]  // 10100101-10010101-11010101-01010101
// CHECK: ldnt1d  {z21.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0xd5,0x95,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10010101-11010101-01010101
ldnt1d  {z31.d}, p7/z, [sp, #-1, mul vl]  // 10100101-10001111-11111111-11111111
// CHECK: ldnt1d  {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x8f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001111-11111111-11111111
LDNT1D  {Z31.D}, P7/Z, [SP, #-1, MUL VL]  // 10100101-10001111-11111111-11111111
// CHECK: ldnt1d  {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x8f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001111-11111111-11111111
ldnt1d  {z21.d}, p5/z, [x10, #5, mul vl]  // 10100101-10000101-11110101-01010101
// CHECK: ldnt1d  {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x85,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000101-11110101-01010101
LDNT1D  {Z21.D}, P5/Z, [X10, #5, MUL VL]  // 10100101-10000101-11110101-01010101
// CHECK: ldnt1d  {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x85,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000101-11110101-01010101
ldnt1d  {z23.d}, p3/z, [x13, x8, lsl #3]  // 10100101-10001000-11001101-10110111
// CHECK: ldnt1d  {z23.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0xcd,0x88,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001000-11001101-10110111
LDNT1D  {Z23.D}, P3/Z, [X13, X8, LSL #3]  // 10100101-10001000-11001101-10110111
// CHECK: ldnt1d  {z23.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0xcd,0x88,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001000-11001101-10110111
ldnt1d  {z0.d}, p0/z, [x0, x0, lsl #3]  // 10100101-10000000-11000000-00000000
// CHECK: ldnt1d  {z0.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0x80,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000000-11000000-00000000
LDNT1D  {Z0.D}, P0/Z, [X0, X0, LSL #3]  // 10100101-10000000-11000000-00000000
// CHECK: ldnt1d  {z0.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0x80,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000000-11000000-00000000
ldnt1d  {z5.d}, p3/z, [x17, x16, lsl #3]  // 10100101-10010000-11001110-00100101
// CHECK: ldnt1d  {z5.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0xce,0x90,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10010000-11001110-00100101
LDNT1D  {Z5.D}, P3/Z, [X17, X16, LSL #3]  // 10100101-10010000-11001110-00100101
// CHECK: ldnt1d  {z5.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0xce,0x90,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10010000-11001110-00100101
ldnt1d  {z0.d}, p0/z, [x0]  // 10100101-10000000-11100000-00000000
// CHECK: ldnt1d  {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0x80,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000000-11100000-00000000
LDNT1D  {Z0.D}, P0/Z, [X0]  // 10100101-10000000-11100000-00000000
// CHECK: ldnt1d  {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0x80,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000000-11100000-00000000
ldnt1d  {z23.d}, p3/z, [x13, #-8, mul vl]  // 10100101-10001000-11101101-10110111
// CHECK: ldnt1d  {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x88,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001000-11101101-10110111
LDNT1D  {Z23.D}, P3/Z, [X13, #-8, MUL VL]  // 10100101-10001000-11101101-10110111
// CHECK: ldnt1d  {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x88,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001000-11101101-10110111
