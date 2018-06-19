// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rh   {z31.h}, p7/z, [sp, #126]  // 10000100-11111111-10111111-11111111
// CHECK: ld1rh   {z31.h}, p7/z, [sp, #126] // encoding: [0xff,0xbf,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-10111111-11111111
LD1RH   {Z31.H}, P7/Z, [SP, #126]  // 10000100-11111111-10111111-11111111
// CHECK: ld1rh   {z31.h}, p7/z, [sp, #126] // encoding: [0xff,0xbf,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-10111111-11111111
ld1rh   {z23.d}, p3/z, [x13, #16]  // 10000100-11001000-11101101-10110111
// CHECK: ld1rh   {z23.d}, p3/z, [x13, #16] // encoding: [0xb7,0xed,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-11101101-10110111
LD1RH   {Z23.D}, P3/Z, [X13, #16]  // 10000100-11001000-11101101-10110111
// CHECK: ld1rh   {z23.d}, p3/z, [x13, #16] // encoding: [0xb7,0xed,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-11101101-10110111
ld1rh   {z21.d}, p5/z, [x10, #42]  // 10000100-11010101-11110101-01010101
// CHECK: ld1rh   {z21.d}, p5/z, [x10, #42] // encoding: [0x55,0xf5,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-11110101-01010101
LD1RH   {Z21.D}, P5/Z, [X10, #42]  // 10000100-11010101-11110101-01010101
// CHECK: ld1rh   {z21.d}, p5/z, [x10, #42] // encoding: [0x55,0xf5,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-11110101-01010101
ld1rh   {z21.h}, p5/z, [x10, #42]  // 10000100-11010101-10110101-01010101
// CHECK: ld1rh   {z21.h}, p5/z, [x10, #42] // encoding: [0x55,0xb5,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-10110101-01010101
LD1RH   {Z21.H}, P5/Z, [X10, #42]  // 10000100-11010101-10110101-01010101
// CHECK: ld1rh   {z21.h}, p5/z, [x10, #42] // encoding: [0x55,0xb5,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-10110101-01010101
ld1rh   {z23.h}, p3/z, [x13, #16]  // 10000100-11001000-10101101-10110111
// CHECK: ld1rh   {z23.h}, p3/z, [x13, #16] // encoding: [0xb7,0xad,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-10101101-10110111
LD1RH   {Z23.H}, P3/Z, [X13, #16]  // 10000100-11001000-10101101-10110111
// CHECK: ld1rh   {z23.h}, p3/z, [x13, #16] // encoding: [0xb7,0xad,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-10101101-10110111
ld1rh   {z31.d}, p7/z, [sp, #126]  // 10000100-11111111-11111111-11111111
// CHECK: ld1rh   {z31.d}, p7/z, [sp, #126] // encoding: [0xff,0xff,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-11111111-11111111
LD1RH   {Z31.D}, P7/Z, [SP, #126]  // 10000100-11111111-11111111-11111111
// CHECK: ld1rh   {z31.d}, p7/z, [sp, #126] // encoding: [0xff,0xff,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-11111111-11111111
ld1rh   {z21.s}, p5/z, [x10, #42]  // 10000100-11010101-11010101-01010101
// CHECK: ld1rh   {z21.s}, p5/z, [x10, #42] // encoding: [0x55,0xd5,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-11010101-01010101
LD1RH   {Z21.S}, P5/Z, [X10, #42]  // 10000100-11010101-11010101-01010101
// CHECK: ld1rh   {z21.s}, p5/z, [x10, #42] // encoding: [0x55,0xd5,0xd5,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11010101-11010101-01010101
ld1rh   {z0.d}, p0/z, [x0]  // 10000100-11000000-11100000-00000000
// CHECK: ld1rh   {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-11100000-00000000
LD1RH   {Z0.D}, P0/Z, [X0]  // 10000100-11000000-11100000-00000000
// CHECK: ld1rh   {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-11100000-00000000
ld1rh   {z23.s}, p3/z, [x13, #16]  // 10000100-11001000-11001101-10110111
// CHECK: ld1rh   {z23.s}, p3/z, [x13, #16] // encoding: [0xb7,0xcd,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-11001101-10110111
LD1RH   {Z23.S}, P3/Z, [X13, #16]  // 10000100-11001000-11001101-10110111
// CHECK: ld1rh   {z23.s}, p3/z, [x13, #16] // encoding: [0xb7,0xcd,0xc8,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11001000-11001101-10110111
ld1rh   {z0.h}, p0/z, [x0]  // 10000100-11000000-10100000-00000000
// CHECK: ld1rh   {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-10100000-00000000
LD1RH   {Z0.H}, P0/Z, [X0]  // 10000100-11000000-10100000-00000000
// CHECK: ld1rh   {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-10100000-00000000
ld1rh   {z31.s}, p7/z, [sp, #126]  // 10000100-11111111-11011111-11111111
// CHECK: ld1rh   {z31.s}, p7/z, [sp, #126] // encoding: [0xff,0xdf,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-11011111-11111111
LD1RH   {Z31.S}, P7/Z, [SP, #126]  // 10000100-11111111-11011111-11111111
// CHECK: ld1rh   {z31.s}, p7/z, [sp, #126] // encoding: [0xff,0xdf,0xff,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11111111-11011111-11111111
ld1rh   {z0.s}, p0/z, [x0]  // 10000100-11000000-11000000-00000000
// CHECK: ld1rh   {z0.s}, p0/z, [x0] // encoding: [0x00,0xc0,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-11000000-00000000
LD1RH   {Z0.S}, P0/Z, [X0]  // 10000100-11000000-11000000-00000000
// CHECK: ld1rh   {z0.s}, p0/z, [x0] // encoding: [0x00,0xc0,0xc0,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-11000000-11000000-00000000
