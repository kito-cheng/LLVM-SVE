// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st2d    {z23.d, z24.d}, p3, [x13, x8, lsl #3]  // 11100101-10101000-01101101-10110111
// CHECK: st2d    {z23.d, z24.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x6d,0xa8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10101000-01101101-10110111
ST2D    {Z23.D, Z24.D}, P3, [X13, X8, LSL #3]  // 11100101-10101000-01101101-10110111
// CHECK: st2d    {z23.d, z24.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x6d,0xa8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10101000-01101101-10110111
st2d    {z21.d, z22.d}, p5, [x10, #10, mul vl]  // 11100101-10110101-11110101-01010101
// CHECK: st2d    {z21.d, z22.d}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xb5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110101-11110101-01010101
ST2D    {Z21.D, Z22.D}, P5, [X10, #10, MUL VL]  // 11100101-10110101-11110101-01010101
// CHECK: st2d    {z21.d, z22.d}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xb5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110101-11110101-01010101
st2d    {z5.d, z6.d}, p3, [x17, x16, lsl #3]  // 11100101-10110000-01101110-00100101
// CHECK: st2d    {z5.d, z6.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x6e,0xb0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110000-01101110-00100101
ST2D    {Z5.D, Z6.D}, P3, [X17, X16, LSL #3]  // 11100101-10110000-01101110-00100101
// CHECK: st2d    {z5.d, z6.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x6e,0xb0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110000-01101110-00100101
st2d    {z21.d, z22.d}, p5, [x10, x21, lsl #3]  // 11100101-10110101-01110101-01010101
// CHECK: st2d    {z21.d, z22.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x75,0xb5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110101-01110101-01010101
ST2D    {Z21.D, Z22.D}, P5, [X10, X21, LSL #3]  // 11100101-10110101-01110101-01010101
// CHECK: st2d    {z21.d, z22.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x75,0xb5,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110101-01110101-01010101
st2d    {z23.d, z24.d}, p3, [x13, #-16, mul vl]  // 11100101-10111000-11101101-10110111
// CHECK: st2d    {z23.d, z24.d}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xb8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111000-11101101-10110111
ST2D    {Z23.D, Z24.D}, P3, [X13, #-16, MUL VL]  // 11100101-10111000-11101101-10110111
// CHECK: st2d    {z23.d, z24.d}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xb8,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111000-11101101-10110111
st2d    {z31.d, z0.d}, p7, [sp, #-2, mul vl]  // 11100101-10111111-11111111-11111111
// CHECK: st2d    {z31.d, z0.d}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-11111111-11111111
ST2D    {Z31.D, Z0.D}, P7, [SP, #-2, MUL VL]  // 11100101-10111111-11111111-11111111
// CHECK: st2d    {z31.d, z0.d}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-11111111-11111111
st2d    {z0.d, z1.d}, p0, [x0, x0, lsl #3]  // 11100101-10100000-01100000-00000000
// CHECK: st2d    {z0.d, z1.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x60,0xa0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10100000-01100000-00000000
ST2D    {Z0.D, Z1.D}, P0, [X0, X0, LSL #3]  // 11100101-10100000-01100000-00000000
// CHECK: st2d    {z0.d, z1.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x60,0xa0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10100000-01100000-00000000
st2d    {z0.d, z1.d}, p0, [x0]  // 11100101-10110000-11100000-00000000
// CHECK: st2d    {z0.d, z1.d}, p0, [x0] // encoding: [0x00,0xe0,0xb0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110000-11100000-00000000
ST2D    {Z0.D, Z1.D}, P0, [X0]  // 11100101-10110000-11100000-00000000
// CHECK: st2d    {z0.d, z1.d}, p0, [x0] // encoding: [0x00,0xe0,0xb0,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10110000-11100000-00000000
