// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rqb  {z23.b}, p3/z, [x13, x8]  // 10100100-00001000-00001101-10110111
// CHECK: ld1rqb  {z23.b}, p3/z, [x13, x8] // encoding: [0xb7,0x0d,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-00001101-10110111
LD1RQB  {Z23.B}, P3/Z, [X13, X8]  // 10100100-00001000-00001101-10110111
// CHECK: ld1rqb  {z23.b}, p3/z, [x13, x8] // encoding: [0xb7,0x0d,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-00001101-10110111
ld1rqb  {z23.b}, p3/z, [x13, #-128]  // 10100100-00001000-00101101-10110111
// CHECK: ld1rqb  {z23.b}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-00101101-10110111
LD1RQB  {Z23.B}, P3/Z, [X13, #-128]  // 10100100-00001000-00101101-10110111
// CHECK: ld1rqb  {z23.b}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-00101101-10110111
ld1rqb  {z21.b}, p5/z, [x10, #80]  // 10100100-00000101-00110101-01010101
// CHECK: ld1rqb  {z21.b}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x05,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000101-00110101-01010101
LD1RQB  {Z21.B}, P5/Z, [X10, #80]  // 10100100-00000101-00110101-01010101
// CHECK: ld1rqb  {z21.b}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x05,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000101-00110101-01010101
ld1rqb  {z31.b}, p7/z, [sp, #-16]  // 10100100-00001111-00111111-11111111
// CHECK: ld1rqb  {z31.b}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x0f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001111-00111111-11111111
LD1RQB  {Z31.B}, P7/Z, [SP, #-16]  // 10100100-00001111-00111111-11111111
// CHECK: ld1rqb  {z31.b}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x0f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001111-00111111-11111111
ld1rqb  {z0.b}, p0/z, [x0]  // 10100100-00000000-00100000-00000000
// CHECK: ld1rqb  {z0.b}, p0/z, [x0] // encoding: [0x00,0x20,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-00100000-00000000
LD1RQB  {Z0.B}, P0/Z, [X0]  // 10100100-00000000-00100000-00000000
// CHECK: ld1rqb  {z0.b}, p0/z, [x0] // encoding: [0x00,0x20,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-00100000-00000000
ld1rqb  {z0.b}, p0/z, [x0, x0]  // 10100100-00000000-00000000-00000000
// CHECK: ld1rqb  {z0.b}, p0/z, [x0, x0] // encoding: [0x00,0x00,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-00000000-00000000
LD1RQB  {Z0.B}, P0/Z, [X0, X0]  // 10100100-00000000-00000000-00000000
// CHECK: ld1rqb  {z0.b}, p0/z, [x0, x0] // encoding: [0x00,0x00,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-00000000-00000000
ld1rqb  {z5.b}, p3/z, [x17, x16]  // 10100100-00010000-00001110-00100101
// CHECK: ld1rqb  {z5.b}, p3/z, [x17, x16] // encoding: [0x25,0x0e,0x10,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010000-00001110-00100101
LD1RQB  {Z5.B}, P3/Z, [X17, X16]  // 10100100-00010000-00001110-00100101
// CHECK: ld1rqb  {z5.b}, p3/z, [x17, x16] // encoding: [0x25,0x0e,0x10,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010000-00001110-00100101
ld1rqb  {z21.b}, p5/z, [x10, x21]  // 10100100-00010101-00010101-01010101
// CHECK: ld1rqb  {z21.b}, p5/z, [x10, x21] // encoding: [0x55,0x15,0x15,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010101-00010101-01010101
LD1RQB  {Z21.B}, P5/Z, [X10, X21]  // 10100100-00010101-00010101-01010101
// CHECK: ld1rqb  {z21.b}, p5/z, [x10, x21] // encoding: [0x55,0x15,0x15,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010101-00010101-01010101
