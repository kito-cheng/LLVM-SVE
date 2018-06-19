// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rqd  {z31.d}, p7/z, [sp, #-16]  // 10100101-10001111-00111111-11111111
// CHECK: ld1rqd  {z31.d}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x8f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001111-00111111-11111111
LD1RQD  {Z31.D}, P7/Z, [SP, #-16]  // 10100101-10001111-00111111-11111111
// CHECK: ld1rqd  {z31.d}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x8f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001111-00111111-11111111
ld1rqd  {z0.d}, p0/z, [x0, x0, lsl #3]  // 10100101-10000000-00000000-00000000
// CHECK: ld1rqd  {z0.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0x00,0x80,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000000-00000000-00000000
LD1RQD  {Z0.D}, P0/Z, [X0, X0, LSL #3]  // 10100101-10000000-00000000-00000000
// CHECK: ld1rqd  {z0.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0x00,0x80,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000000-00000000-00000000
ld1rqd  {z23.d}, p3/z, [x13, #-128]  // 10100101-10001000-00101101-10110111
// CHECK: ld1rqd  {z23.d}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x88,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001000-00101101-10110111
LD1RQD  {Z23.D}, P3/Z, [X13, #-128]  // 10100101-10001000-00101101-10110111
// CHECK: ld1rqd  {z23.d}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x88,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001000-00101101-10110111
ld1rqd  {z21.d}, p5/z, [x10, #80]  // 10100101-10000101-00110101-01010101
// CHECK: ld1rqd  {z21.d}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x85,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000101-00110101-01010101
LD1RQD  {Z21.D}, P5/Z, [X10, #80]  // 10100101-10000101-00110101-01010101
// CHECK: ld1rqd  {z21.d}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x85,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000101-00110101-01010101
ld1rqd  {z0.d}, p0/z, [x0]  // 10100101-10000000-00100000-00000000
// CHECK: ld1rqd  {z0.d}, p0/z, [x0] // encoding: [0x00,0x20,0x80,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000000-00100000-00000000
LD1RQD  {Z0.D}, P0/Z, [X0]  // 10100101-10000000-00100000-00000000
// CHECK: ld1rqd  {z0.d}, p0/z, [x0] // encoding: [0x00,0x20,0x80,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10000000-00100000-00000000
ld1rqd  {z5.d}, p3/z, [x17, x16, lsl #3]  // 10100101-10010000-00001110-00100101
// CHECK: ld1rqd  {z5.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0x0e,0x90,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10010000-00001110-00100101
LD1RQD  {Z5.D}, P3/Z, [X17, X16, LSL #3]  // 10100101-10010000-00001110-00100101
// CHECK: ld1rqd  {z5.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0x0e,0x90,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10010000-00001110-00100101
ld1rqd  {z23.d}, p3/z, [x13, x8, lsl #3]  // 10100101-10001000-00001101-10110111
// CHECK: ld1rqd  {z23.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0x0d,0x88,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001000-00001101-10110111
LD1RQD  {Z23.D}, P3/Z, [X13, X8, LSL #3]  // 10100101-10001000-00001101-10110111
// CHECK: ld1rqd  {z23.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0x0d,0x88,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10001000-00001101-10110111
ld1rqd  {z21.d}, p5/z, [x10, x21, lsl #3]  // 10100101-10010101-00010101-01010101
// CHECK: ld1rqd  {z21.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0x15,0x95,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10010101-00010101-01010101
LD1RQD  {Z21.D}, P5/Z, [X10, X21, LSL #3]  // 10100101-10010101-00010101-01010101
// CHECK: ld1rqd  {z21.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0x15,0x95,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10010101-00010101-01010101
