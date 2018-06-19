// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldnt1b  {z31.b}, p7/z, [sp, #-1, mul vl]  // 10100100-00001111-11111111-11111111
// CHECK: ldnt1b  {z31.b}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x0f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001111-11111111-11111111
LDNT1B  {Z31.B}, P7/Z, [SP, #-1, MUL VL]  // 10100100-00001111-11111111-11111111
// CHECK: ldnt1b  {z31.b}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x0f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001111-11111111-11111111
ldnt1b  {z21.b}, p5/z, [x10, x21]  // 10100100-00010101-11010101-01010101
// CHECK: ldnt1b  {z21.b}, p5/z, [x10, x21] // encoding: [0x55,0xd5,0x15,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010101-11010101-01010101
LDNT1B  {Z21.B}, P5/Z, [X10, X21]  // 10100100-00010101-11010101-01010101
// CHECK: ldnt1b  {z21.b}, p5/z, [x10, x21] // encoding: [0x55,0xd5,0x15,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010101-11010101-01010101
ldnt1b  {z0.b}, p0/z, [x0]  // 10100100-00000000-11100000-00000000
// CHECK: ldnt1b  {z0.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-11100000-00000000
LDNT1B  {Z0.B}, P0/Z, [X0]  // 10100100-00000000-11100000-00000000
// CHECK: ldnt1b  {z0.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-11100000-00000000
ldnt1b  {z23.b}, p3/z, [x13, #-8, mul vl]  // 10100100-00001000-11101101-10110111
// CHECK: ldnt1b  {z23.b}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-11101101-10110111
LDNT1B  {Z23.B}, P3/Z, [X13, #-8, MUL VL]  // 10100100-00001000-11101101-10110111
// CHECK: ldnt1b  {z23.b}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-11101101-10110111
ldnt1b  {z21.b}, p5/z, [x10, #5, mul vl]  // 10100100-00000101-11110101-01010101
// CHECK: ldnt1b  {z21.b}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x05,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000101-11110101-01010101
LDNT1B  {Z21.B}, P5/Z, [X10, #5, MUL VL]  // 10100100-00000101-11110101-01010101
// CHECK: ldnt1b  {z21.b}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x05,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000101-11110101-01010101
ldnt1b  {z5.b}, p3/z, [x17, x16]  // 10100100-00010000-11001110-00100101
// CHECK: ldnt1b  {z5.b}, p3/z, [x17, x16] // encoding: [0x25,0xce,0x10,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010000-11001110-00100101
LDNT1B  {Z5.B}, P3/Z, [X17, X16]  // 10100100-00010000-11001110-00100101
// CHECK: ldnt1b  {z5.b}, p3/z, [x17, x16] // encoding: [0x25,0xce,0x10,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00010000-11001110-00100101
ldnt1b  {z23.b}, p3/z, [x13, x8]  // 10100100-00001000-11001101-10110111
// CHECK: ldnt1b  {z23.b}, p3/z, [x13, x8] // encoding: [0xb7,0xcd,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-11001101-10110111
LDNT1B  {Z23.B}, P3/Z, [X13, X8]  // 10100100-00001000-11001101-10110111
// CHECK: ldnt1b  {z23.b}, p3/z, [x13, x8] // encoding: [0xb7,0xcd,0x08,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00001000-11001101-10110111
ldnt1b  {z0.b}, p0/z, [x0, x0]  // 10100100-00000000-11000000-00000000
// CHECK: ldnt1b  {z0.b}, p0/z, [x0, x0] // encoding: [0x00,0xc0,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-11000000-00000000
LDNT1B  {Z0.B}, P0/Z, [X0, X0]  // 10100100-00000000-11000000-00000000
// CHECK: ldnt1b  {z0.b}, p0/z, [x0, x0] // encoding: [0x00,0xc0,0x00,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-00000000-11000000-00000000
