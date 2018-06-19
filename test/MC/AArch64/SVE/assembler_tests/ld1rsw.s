// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rsw  {z0.d}, p0/z, [x0]  // 10000100-11000000-10000000-00000000
// CHECK: ld1rsw  {z0.d}, p0/z, [x0] // encoding: [0x00,0x80,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-10000000-00000000
LD1RSW  {Z0.D}, P0/Z, [X0]  // 10000100-11000000-10000000-00000000
// CHECK: ld1rsw  {z0.d}, p0/z, [x0] // encoding: [0x00,0x80,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-10000000-00000000
ld1rsw  {z23.d}, p3/z, [x13, #32]  // 10000100-11001000-10001101-10110111
// CHECK: ld1rsw  {z23.d}, p3/z, [x13, #32] // encoding: [0xb7,0x8d,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-10001101-10110111
LD1RSW  {Z23.D}, P3/Z, [X13, #32]  // 10000100-11001000-10001101-10110111
// CHECK: ld1rsw  {z23.d}, p3/z, [x13, #32] // encoding: [0xb7,0x8d,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-10001101-10110111
ld1rsw  {z31.d}, p7/z, [sp, #252]  // 10000100-11111111-10011111-11111111
// CHECK: ld1rsw  {z31.d}, p7/z, [sp, #252] // encoding: [0xff,0x9f,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-10011111-11111111
LD1RSW  {Z31.D}, P7/Z, [SP, #252]  // 10000100-11111111-10011111-11111111
// CHECK: ld1rsw  {z31.d}, p7/z, [sp, #252] // encoding: [0xff,0x9f,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-10011111-11111111
ld1rsw  {z21.d}, p5/z, [x10, #84]  // 10000100-11010101-10010101-01010101
// CHECK: ld1rsw  {z21.d}, p5/z, [x10, #84] // encoding: [0x55,0x95,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-10010101-01010101
LD1RSW  {Z21.D}, P5/Z, [X10, #84]  // 10000100-11010101-10010101-01010101
// CHECK: ld1rsw  {z21.d}, p5/z, [x10, #84] // encoding: [0x55,0x95,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-10010101-01010101
