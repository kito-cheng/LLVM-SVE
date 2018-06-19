// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rqw  {z0.s}, p0/z, [x0, x0, lsl #2]  // 10100101-00000000-00000000-00000000
// CHECK: ld1rqw  {z0.s}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0x00,0x00,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00000000-00000000-00000000
LD1RQW  {Z0.S}, P0/Z, [X0, X0, LSL #2]  // 10100101-00000000-00000000-00000000
// CHECK: ld1rqw  {z0.s}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0x00,0x00,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00000000-00000000-00000000
ld1rqw  {z31.s}, p7/z, [sp, #-16]  // 10100101-00001111-00111111-11111111
// CHECK: ld1rqw  {z31.s}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x0f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00001111-00111111-11111111
LD1RQW  {Z31.S}, P7/Z, [SP, #-16]  // 10100101-00001111-00111111-11111111
// CHECK: ld1rqw  {z31.s}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x0f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00001111-00111111-11111111
ld1rqw  {z21.s}, p5/z, [x10, x21, lsl #2]  // 10100101-00010101-00010101-01010101
// CHECK: ld1rqw  {z21.s}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0x15,0x15,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00010101-00010101-01010101
LD1RQW  {Z21.S}, P5/Z, [X10, X21, LSL #2]  // 10100101-00010101-00010101-01010101
// CHECK: ld1rqw  {z21.s}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0x15,0x15,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00010101-00010101-01010101
ld1rqw  {z23.s}, p3/z, [x13, x8, lsl #2]  // 10100101-00001000-00001101-10110111
// CHECK: ld1rqw  {z23.s}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0x0d,0x08,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00001000-00001101-10110111
LD1RQW  {Z23.S}, P3/Z, [X13, X8, LSL #2]  // 10100101-00001000-00001101-10110111
// CHECK: ld1rqw  {z23.s}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0x0d,0x08,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00001000-00001101-10110111
ld1rqw  {z5.s}, p3/z, [x17, x16, lsl #2]  // 10100101-00010000-00001110-00100101
// CHECK: ld1rqw  {z5.s}, p3/z, [x17, x16, lsl #2] // encoding: [0x25,0x0e,0x10,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00010000-00001110-00100101
LD1RQW  {Z5.S}, P3/Z, [X17, X16, LSL #2]  // 10100101-00010000-00001110-00100101
// CHECK: ld1rqw  {z5.s}, p3/z, [x17, x16, lsl #2] // encoding: [0x25,0x0e,0x10,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00010000-00001110-00100101
ld1rqw  {z0.s}, p0/z, [x0]  // 10100101-00000000-00100000-00000000
// CHECK: ld1rqw  {z0.s}, p0/z, [x0] // encoding: [0x00,0x20,0x00,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00000000-00100000-00000000
LD1RQW  {Z0.S}, P0/Z, [X0]  // 10100101-00000000-00100000-00000000
// CHECK: ld1rqw  {z0.s}, p0/z, [x0] // encoding: [0x00,0x20,0x00,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00000000-00100000-00000000
ld1rqw  {z23.s}, p3/z, [x13, #-128]  // 10100101-00001000-00101101-10110111
// CHECK: ld1rqw  {z23.s}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x08,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00001000-00101101-10110111
LD1RQW  {Z23.S}, P3/Z, [X13, #-128]  // 10100101-00001000-00101101-10110111
// CHECK: ld1rqw  {z23.s}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x08,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00001000-00101101-10110111
ld1rqw  {z21.s}, p5/z, [x10, #80]  // 10100101-00000101-00110101-01010101
// CHECK: ld1rqw  {z21.s}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x05,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00000101-00110101-01010101
LD1RQW  {Z21.S}, P5/Z, [X10, #80]  // 10100101-00000101-00110101-01010101
// CHECK: ld1rqw  {z21.s}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x05,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00000101-00110101-01010101
