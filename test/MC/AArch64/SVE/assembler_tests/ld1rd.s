// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rd   {z0.d}, p0/z, [x0]  // 10000101-11000000-11100000-00000000
// CHECK: ld1rd   {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11000000-11100000-00000000
LD1RD   {Z0.D}, P0/Z, [X0]  // 10000101-11000000-11100000-00000000
// CHECK: ld1rd   {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11000000-11100000-00000000
ld1rd   {z23.d}, p3/z, [x13, #64]  // 10000101-11001000-11101101-10110111
// CHECK: ld1rd   {z23.d}, p3/z, [x13, #64] // encoding: [0xb7,0xed,0xc8,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11001000-11101101-10110111
LD1RD   {Z23.D}, P3/Z, [X13, #64]  // 10000101-11001000-11101101-10110111
// CHECK: ld1rd   {z23.d}, p3/z, [x13, #64] // encoding: [0xb7,0xed,0xc8,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11001000-11101101-10110111
ld1rd   {z31.d}, p7/z, [sp, #504]  // 10000101-11111111-11111111-11111111
// CHECK: ld1rd   {z31.d}, p7/z, [sp, #504] // encoding: [0xff,0xff,0xff,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11111111-11111111-11111111
LD1RD   {Z31.D}, P7/Z, [SP, #504]  // 10000101-11111111-11111111-11111111
// CHECK: ld1rd   {z31.d}, p7/z, [sp, #504] // encoding: [0xff,0xff,0xff,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11111111-11111111-11111111
ld1rd   {z21.d}, p5/z, [x10, #168]  // 10000101-11010101-11110101-01010101
// CHECK: ld1rd   {z21.d}, p5/z, [x10, #168] // encoding: [0x55,0xf5,0xd5,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11010101-11110101-01010101
LD1RD   {Z21.D}, P5/Z, [X10, #168]  // 10000101-11010101-11110101-01010101
// CHECK: ld1rd   {z21.d}, p5/z, [x10, #168] // encoding: [0x55,0xf5,0xd5,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-11010101-11110101-01010101
