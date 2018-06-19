// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl]  // 10100101-10100101-11110101-01010101
// CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xa5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10100101-11110101-01010101
LD2D    {Z21.D, Z22.D}, P5/Z, [X10, #10, MUL VL]  // 10100101-10100101-11110101-01010101
// CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xa5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10100101-11110101-01010101
ld2d    {z0.d, z1.d}, p0/z, [x0]  // 10100101-10100000-11100000-00000000
// CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xa0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10100000-11100000-00000000
LD2D    {Z0.D, Z1.D}, P0/Z, [X0]  // 10100101-10100000-11100000-00000000
// CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xa0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10100000-11100000-00000000
ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl]  // 10100101-10101000-11101101-10110111
// CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xa8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10101000-11101101-10110111
LD2D    {Z23.D, Z24.D}, P3/Z, [X13, #-16, MUL VL]  // 10100101-10101000-11101101-10110111
// CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xa8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10101000-11101101-10110111
ld2d    {z5.d, z6.d}, p3/z, [x17, x16, lsl #3]  // 10100101-10110000-11001110-00100101
// CHECK: ld2d    {z5.d, z6.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0xce,0xb0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10110000-11001110-00100101
LD2D    {Z5.D, Z6.D}, P3/Z, [X17, X16, LSL #3]  // 10100101-10110000-11001110-00100101
// CHECK: ld2d    {z5.d, z6.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0xce,0xb0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10110000-11001110-00100101
ld2d    {z0.d, z1.d}, p0/z, [x0, x0, lsl #3]  // 10100101-10100000-11000000-00000000
// CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0xa0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10100000-11000000-00000000
LD2D    {Z0.D, Z1.D}, P0/Z, [X0, X0, LSL #3]  // 10100101-10100000-11000000-00000000
// CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0xa0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10100000-11000000-00000000
ld2d    {z23.d, z24.d}, p3/z, [x13, x8, lsl #3]  // 10100101-10101000-11001101-10110111
// CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0xcd,0xa8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10101000-11001101-10110111
LD2D    {Z23.D, Z24.D}, P3/Z, [X13, X8, LSL #3]  // 10100101-10101000-11001101-10110111
// CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0xcd,0xa8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10101000-11001101-10110111
ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl]  // 10100101-10101111-11111111-11111111
// CHECK: ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xaf,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10101111-11111111-11111111
LD2D    {Z31.D, Z0.D}, P7/Z, [SP, #-2, MUL VL]  // 10100101-10101111-11111111-11111111
// CHECK: ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xaf,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10101111-11111111-11111111
ld2d    {z21.d, z22.d}, p5/z, [x10, x21, lsl #3]  // 10100101-10110101-11010101-01010101
// CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0xd5,0xb5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10110101-11010101-01010101
LD2D    {Z21.D, Z22.D}, P5/Z, [X10, X21, LSL #3]  // 10100101-10110101-11010101-01010101
// CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0xd5,0xb5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-10110101-11010101-01010101
