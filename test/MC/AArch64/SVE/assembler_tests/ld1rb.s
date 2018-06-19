// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rb   {z21.d}, p5/z, [x10, #21]  // 10000100-01010101-11110101-01010101
// CHECK: ld1rb   {z21.d}, p5/z, [x10, #21] // encoding: [0x55,0xf5,0x55,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01010101-11110101-01010101
LD1RB   {Z21.D}, P5/Z, [X10, #21]  // 10000100-01010101-11110101-01010101
// CHECK: ld1rb   {z21.d}, p5/z, [x10, #21] // encoding: [0x55,0xf5,0x55,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01010101-11110101-01010101
ld1rb   {z31.s}, p7/z, [sp, #63]  // 10000100-01111111-11011111-11111111
// CHECK: ld1rb   {z31.s}, p7/z, [sp, #63] // encoding: [0xff,0xdf,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-11011111-11111111
LD1RB   {Z31.S}, P7/Z, [SP, #63]  // 10000100-01111111-11011111-11111111
// CHECK: ld1rb   {z31.s}, p7/z, [sp, #63] // encoding: [0xff,0xdf,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-11011111-11111111
ld1rb   {z0.d}, p0/z, [x0]  // 10000100-01000000-11100000-00000000
// CHECK: ld1rb   {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0x40,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01000000-11100000-00000000
LD1RB   {Z0.D}, P0/Z, [X0]  // 10000100-01000000-11100000-00000000
// CHECK: ld1rb   {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0x40,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01000000-11100000-00000000
ld1rb   {z23.s}, p3/z, [x13, #8]  // 10000100-01001000-11001101-10110111
// CHECK: ld1rb   {z23.s}, p3/z, [x13, #8] // encoding: [0xb7,0xcd,0x48,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01001000-11001101-10110111
LD1RB   {Z23.S}, P3/Z, [X13, #8]  // 10000100-01001000-11001101-10110111
// CHECK: ld1rb   {z23.s}, p3/z, [x13, #8] // encoding: [0xb7,0xcd,0x48,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01001000-11001101-10110111
ld1rb   {z23.b}, p3/z, [x13, #8]  // 10000100-01001000-10001101-10110111
// CHECK: ld1rb   {z23.b}, p3/z, [x13, #8] // encoding: [0xb7,0x8d,0x48,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01001000-10001101-10110111
LD1RB   {Z23.B}, P3/Z, [X13, #8]  // 10000100-01001000-10001101-10110111
// CHECK: ld1rb   {z23.b}, p3/z, [x13, #8] // encoding: [0xb7,0x8d,0x48,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01001000-10001101-10110111
ld1rb   {z0.h}, p0/z, [x0]  // 10000100-01000000-10100000-00000000
// CHECK: ld1rb   {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0x40,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01000000-10100000-00000000
LD1RB   {Z0.H}, P0/Z, [X0]  // 10000100-01000000-10100000-00000000
// CHECK: ld1rb   {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0x40,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01000000-10100000-00000000
ld1rb   {z31.d}, p7/z, [sp, #63]  // 10000100-01111111-11111111-11111111
// CHECK: ld1rb   {z31.d}, p7/z, [sp, #63] // encoding: [0xff,0xff,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-11111111-11111111
LD1RB   {Z31.D}, P7/Z, [SP, #63]  // 10000100-01111111-11111111-11111111
// CHECK: ld1rb   {z31.d}, p7/z, [sp, #63] // encoding: [0xff,0xff,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-11111111-11111111
ld1rb   {z31.h}, p7/z, [sp, #63]  // 10000100-01111111-10111111-11111111
// CHECK: ld1rb   {z31.h}, p7/z, [sp, #63] // encoding: [0xff,0xbf,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-10111111-11111111
LD1RB   {Z31.H}, P7/Z, [SP, #63]  // 10000100-01111111-10111111-11111111
// CHECK: ld1rb   {z31.h}, p7/z, [sp, #63] // encoding: [0xff,0xbf,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-10111111-11111111
ld1rb   {z23.d}, p3/z, [x13, #8]  // 10000100-01001000-11101101-10110111
// CHECK: ld1rb   {z23.d}, p3/z, [x13, #8] // encoding: [0xb7,0xed,0x48,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01001000-11101101-10110111
LD1RB   {Z23.D}, P3/Z, [X13, #8]  // 10000100-01001000-11101101-10110111
// CHECK: ld1rb   {z23.d}, p3/z, [x13, #8] // encoding: [0xb7,0xed,0x48,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01001000-11101101-10110111
ld1rb   {z21.b}, p5/z, [x10, #21]  // 10000100-01010101-10010101-01010101
// CHECK: ld1rb   {z21.b}, p5/z, [x10, #21] // encoding: [0x55,0x95,0x55,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01010101-10010101-01010101
LD1RB   {Z21.B}, P5/Z, [X10, #21]  // 10000100-01010101-10010101-01010101
// CHECK: ld1rb   {z21.b}, p5/z, [x10, #21] // encoding: [0x55,0x95,0x55,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01010101-10010101-01010101
ld1rb   {z21.s}, p5/z, [x10, #21]  // 10000100-01010101-11010101-01010101
// CHECK: ld1rb   {z21.s}, p5/z, [x10, #21] // encoding: [0x55,0xd5,0x55,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01010101-11010101-01010101
LD1RB   {Z21.S}, P5/Z, [X10, #21]  // 10000100-01010101-11010101-01010101
// CHECK: ld1rb   {z21.s}, p5/z, [x10, #21] // encoding: [0x55,0xd5,0x55,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01010101-11010101-01010101
ld1rb   {z23.h}, p3/z, [x13, #8]  // 10000100-01001000-10101101-10110111
// CHECK: ld1rb   {z23.h}, p3/z, [x13, #8] // encoding: [0xb7,0xad,0x48,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01001000-10101101-10110111
LD1RB   {Z23.H}, P3/Z, [X13, #8]  // 10000100-01001000-10101101-10110111
// CHECK: ld1rb   {z23.h}, p3/z, [x13, #8] // encoding: [0xb7,0xad,0x48,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01001000-10101101-10110111
ld1rb   {z21.h}, p5/z, [x10, #21]  // 10000100-01010101-10110101-01010101
// CHECK: ld1rb   {z21.h}, p5/z, [x10, #21] // encoding: [0x55,0xb5,0x55,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01010101-10110101-01010101
LD1RB   {Z21.H}, P5/Z, [X10, #21]  // 10000100-01010101-10110101-01010101
// CHECK: ld1rb   {z21.h}, p5/z, [x10, #21] // encoding: [0x55,0xb5,0x55,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01010101-10110101-01010101
ld1rb   {z0.s}, p0/z, [x0]  // 10000100-01000000-11000000-00000000
// CHECK: ld1rb   {z0.s}, p0/z, [x0] // encoding: [0x00,0xc0,0x40,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01000000-11000000-00000000
LD1RB   {Z0.S}, P0/Z, [X0]  // 10000100-01000000-11000000-00000000
// CHECK: ld1rb   {z0.s}, p0/z, [x0] // encoding: [0x00,0xc0,0x40,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01000000-11000000-00000000
ld1rb   {z0.b}, p0/z, [x0]  // 10000100-01000000-10000000-00000000
// CHECK: ld1rb   {z0.b}, p0/z, [x0] // encoding: [0x00,0x80,0x40,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01000000-10000000-00000000
LD1RB   {Z0.B}, P0/Z, [X0]  // 10000100-01000000-10000000-00000000
// CHECK: ld1rb   {z0.b}, p0/z, [x0] // encoding: [0x00,0x80,0x40,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01000000-10000000-00000000
ld1rb   {z31.b}, p7/z, [sp, #63]  // 10000100-01111111-10011111-11111111
// CHECK: ld1rb   {z31.b}, p7/z, [sp, #63] // encoding: [0xff,0x9f,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-10011111-11111111
LD1RB   {Z31.B}, P7/Z, [SP, #63]  // 10000100-01111111-10011111-11111111
// CHECK: ld1rb   {z31.b}, p7/z, [sp, #63] // encoding: [0xff,0x9f,0x7f,0x84]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000100-01111111-10011111-11111111
