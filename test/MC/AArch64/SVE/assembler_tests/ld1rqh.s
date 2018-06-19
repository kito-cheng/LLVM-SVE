// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rqh  {z0.h}, p0/z, [x0]  // 10100100-10000000-00100000-00000000
// CHECK: ld1rqh  {z0.h}, p0/z, [x0] // encoding: [0x00,0x20,0x80,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10000000-00100000-00000000
LD1RQH  {Z0.H}, P0/Z, [X0]  // 10100100-10000000-00100000-00000000
// CHECK: ld1rqh  {z0.h}, p0/z, [x0] // encoding: [0x00,0x20,0x80,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10000000-00100000-00000000
ld1rqh  {z23.h}, p3/z, [x13, x8, lsl #1]  // 10100100-10001000-00001101-10110111
// CHECK: ld1rqh  {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x0d,0x88,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10001000-00001101-10110111
LD1RQH  {Z23.H}, P3/Z, [X13, X8, LSL #1]  // 10100100-10001000-00001101-10110111
// CHECK: ld1rqh  {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x0d,0x88,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10001000-00001101-10110111
ld1rqh  {z23.h}, p3/z, [x13, #-128]  // 10100100-10001000-00101101-10110111
// CHECK: ld1rqh  {z23.h}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x88,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10001000-00101101-10110111
LD1RQH  {Z23.H}, P3/Z, [X13, #-128]  // 10100100-10001000-00101101-10110111
// CHECK: ld1rqh  {z23.h}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x88,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10001000-00101101-10110111
ld1rqh  {z31.h}, p7/z, [sp, #-16]  // 10100100-10001111-00111111-11111111
// CHECK: ld1rqh  {z31.h}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x8f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10001111-00111111-11111111
LD1RQH  {Z31.H}, P7/Z, [SP, #-16]  // 10100100-10001111-00111111-11111111
// CHECK: ld1rqh  {z31.h}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x8f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10001111-00111111-11111111
ld1rqh  {z0.h}, p0/z, [x0, x0, lsl #1]  // 10100100-10000000-00000000-00000000
// CHECK: ld1rqh  {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x00,0x80,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10000000-00000000-00000000
LD1RQH  {Z0.H}, P0/Z, [X0, X0, LSL #1]  // 10100100-10000000-00000000-00000000
// CHECK: ld1rqh  {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x00,0x80,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10000000-00000000-00000000
ld1rqh  {z21.h}, p5/z, [x10, x21, lsl #1]  // 10100100-10010101-00010101-01010101
// CHECK: ld1rqh  {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x15,0x95,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10010101-00010101-01010101
LD1RQH  {Z21.H}, P5/Z, [X10, X21, LSL #1]  // 10100100-10010101-00010101-01010101
// CHECK: ld1rqh  {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x15,0x95,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10010101-00010101-01010101
ld1rqh  {z5.h}, p3/z, [x17, x16, lsl #1]  // 10100100-10010000-00001110-00100101
// CHECK: ld1rqh  {z5.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0x0e,0x90,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10010000-00001110-00100101
LD1RQH  {Z5.H}, P3/Z, [X17, X16, LSL #1]  // 10100100-10010000-00001110-00100101
// CHECK: ld1rqh  {z5.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0x0e,0x90,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10010000-00001110-00100101
ld1rqh  {z21.h}, p5/z, [x10, #80]  // 10100100-10000101-00110101-01010101
// CHECK: ld1rqh  {z21.h}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x85,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10000101-00110101-01010101
LD1RQH  {Z21.H}, P5/Z, [X10, #80]  // 10100100-10000101-00110101-01010101
// CHECK: ld1rqh  {z21.h}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x85,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10000101-00110101-01010101
