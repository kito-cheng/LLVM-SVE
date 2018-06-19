// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0, x0, lsl #1]  // 10100100-11000000-11000000-00000000
// CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0xc0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000000-11000000-00000000
LD3H    {Z0.H, Z1.H, Z2.H}, P0/Z, [X0, X0, LSL #1]  // 10100100-11000000-11000000-00000000
// CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0xc0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000000-11000000-00000000
ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, x21, lsl #1]  // 10100100-11010101-11010101-01010101
// CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0xd5,0xd5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11010101-11010101-01010101
LD3H    {Z21.H, Z22.H, Z23.H}, P5/Z, [X10, X21, LSL #1]  // 10100100-11010101-11010101-01010101
// CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0xd5,0xd5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11010101-11010101-01010101
ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, #15, mul vl]  // 10100100-11000101-11110101-01010101
// CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xc5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000101-11110101-01010101
LD3H    {Z21.H, Z22.H, Z23.H}, P5/Z, [X10, #15, MUL VL]  // 10100100-11000101-11110101-01010101
// CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xc5,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000101-11110101-01010101
ld3h    {z5.h, z6.h, z7.h}, p3/z, [x17, x16, lsl #1]  // 10100100-11010000-11001110-00100101
// CHECK: ld3h    {z5.h, z6.h, z7.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0xce,0xd0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11010000-11001110-00100101
LD3H    {Z5.H, Z6.H, Z7.H}, P3/Z, [X17, X16, LSL #1]  // 10100100-11010000-11001110-00100101
// CHECK: ld3h    {z5.h, z6.h, z7.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0xce,0xd0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11010000-11001110-00100101
ld3h    {z31.h, z0.h, z1.h}, p7/z, [sp, #-3, mul vl]  // 10100100-11001111-11111111-11111111
// CHECK: ld3h    {z31.h, z0.h, z1.h}, p7/z, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xcf,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001111-11111111-11111111
LD3H    {Z31.H, Z0.H, Z1.H}, P7/Z, [SP, #-3, MUL VL]  // 10100100-11001111-11111111-11111111
// CHECK: ld3h    {z31.h, z0.h, z1.h}, p7/z, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xcf,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001111-11111111-11111111
ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0]  // 10100100-11000000-11100000-00000000
// CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000000-11100000-00000000
LD3H    {Z0.H, Z1.H, Z2.H}, P0/Z, [X0]  // 10100100-11000000-11100000-00000000
// CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11000000-11100000-00000000
ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, x8, lsl #1]  // 10100100-11001000-11001101-10110111
// CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0xcd,0xc8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001000-11001101-10110111
LD3H    {Z23.H, Z24.H, Z25.H}, P3/Z, [X13, X8, LSL #1]  // 10100100-11001000-11001101-10110111
// CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0xcd,0xc8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001000-11001101-10110111
ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, #-24, mul vl]  // 10100100-11001000-11101101-10110111
// CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xc8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001000-11101101-10110111
LD3H    {Z23.H, Z24.H, Z25.H}, P3/Z, [X13, #-24, MUL VL]  // 10100100-11001000-11101101-10110111
// CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xc8,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-11001000-11101101-10110111
