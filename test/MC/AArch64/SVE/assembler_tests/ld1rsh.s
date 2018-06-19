// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1rsh  {z21.s}, p5/z, [x10, #42]  // 10000101-01010101-10110101-01010101
// CHECK: ld1rsh  {z21.s}, p5/z, [x10, #42] // encoding: [0x55,0xb5,0x55,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01010101-10110101-01010101
LD1RSH  {Z21.S}, P5/Z, [X10, #42]  // 10000101-01010101-10110101-01010101
// CHECK: ld1rsh  {z21.s}, p5/z, [x10, #42] // encoding: [0x55,0xb5,0x55,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01010101-10110101-01010101
ld1rsh  {z23.d}, p3/z, [x13, #16]  // 10000101-01001000-10001101-10110111
// CHECK: ld1rsh  {z23.d}, p3/z, [x13, #16] // encoding: [0xb7,0x8d,0x48,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01001000-10001101-10110111
LD1RSH  {Z23.D}, P3/Z, [X13, #16]  // 10000101-01001000-10001101-10110111
// CHECK: ld1rsh  {z23.d}, p3/z, [x13, #16] // encoding: [0xb7,0x8d,0x48,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01001000-10001101-10110111
ld1rsh  {z21.d}, p5/z, [x10, #42]  // 10000101-01010101-10010101-01010101
// CHECK: ld1rsh  {z21.d}, p5/z, [x10, #42] // encoding: [0x55,0x95,0x55,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01010101-10010101-01010101
LD1RSH  {Z21.D}, P5/Z, [X10, #42]  // 10000101-01010101-10010101-01010101
// CHECK: ld1rsh  {z21.d}, p5/z, [x10, #42] // encoding: [0x55,0x95,0x55,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01010101-10010101-01010101
ld1rsh  {z0.s}, p0/z, [x0]  // 10000101-01000000-10100000-00000000
// CHECK: ld1rsh  {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0x40,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01000000-10100000-00000000
LD1RSH  {Z0.S}, P0/Z, [X0]  // 10000101-01000000-10100000-00000000
// CHECK: ld1rsh  {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0x40,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01000000-10100000-00000000
ld1rsh  {z23.s}, p3/z, [x13, #16]  // 10000101-01001000-10101101-10110111
// CHECK: ld1rsh  {z23.s}, p3/z, [x13, #16] // encoding: [0xb7,0xad,0x48,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01001000-10101101-10110111
LD1RSH  {Z23.S}, P3/Z, [X13, #16]  // 10000101-01001000-10101101-10110111
// CHECK: ld1rsh  {z23.s}, p3/z, [x13, #16] // encoding: [0xb7,0xad,0x48,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01001000-10101101-10110111
ld1rsh  {z31.s}, p7/z, [sp, #126]  // 10000101-01111111-10111111-11111111
// CHECK: ld1rsh  {z31.s}, p7/z, [sp, #126] // encoding: [0xff,0xbf,0x7f,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01111111-10111111-11111111
LD1RSH  {Z31.S}, P7/Z, [SP, #126]  // 10000101-01111111-10111111-11111111
// CHECK: ld1rsh  {z31.s}, p7/z, [sp, #126] // encoding: [0xff,0xbf,0x7f,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01111111-10111111-11111111
ld1rsh  {z0.d}, p0/z, [x0]  // 10000101-01000000-10000000-00000000
// CHECK: ld1rsh  {z0.d}, p0/z, [x0] // encoding: [0x00,0x80,0x40,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01000000-10000000-00000000
LD1RSH  {Z0.D}, P0/Z, [X0]  // 10000101-01000000-10000000-00000000
// CHECK: ld1rsh  {z0.d}, p0/z, [x0] // encoding: [0x00,0x80,0x40,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01000000-10000000-00000000
ld1rsh  {z31.d}, p7/z, [sp, #126]  // 10000101-01111111-10011111-11111111
// CHECK: ld1rsh  {z31.d}, p7/z, [sp, #126] // encoding: [0xff,0x9f,0x7f,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01111111-10011111-11111111
LD1RSH  {Z31.D}, P7/Z, [SP, #126]  // 10000101-01111111-10011111-11111111
// CHECK: ld1rsh  {z31.d}, p7/z, [sp, #126] // encoding: [0xff,0x9f,0x7f,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-01111111-10011111-11111111
