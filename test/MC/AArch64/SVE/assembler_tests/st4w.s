// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0]  // 11100101-01110000-11100000-00000000
// CHECK: st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0] // encoding: [0x00,0xe0,0x70,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110000-11100000-00000000
ST4W    {Z0.S, Z1.S, Z2.S, Z3.S}, P0, [X0]  // 11100101-01110000-11100000-00000000
// CHECK: st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0] // encoding: [0x00,0xe0,0x70,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110000-11100000-00000000
st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, x21, lsl #2]  // 11100101-01110101-01110101-01010101
// CHECK: st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x75,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-01110101-01010101
ST4W    {Z21.S, Z22.S, Z23.S, Z24.S}, P5, [X10, X21, LSL #2]  // 11100101-01110101-01110101-01010101
// CHECK: st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x75,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-01110101-01010101
st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0, x0, lsl #2]  // 11100101-01100000-01100000-00000000
// CHECK: st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x60,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-01100000-00000000
ST4W    {Z0.S, Z1.S, Z2.S, Z3.S}, P0, [X0, X0, LSL #2]  // 11100101-01100000-01100000-00000000
// CHECK: st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x60,0x60,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01100000-01100000-00000000
st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, #-32, mul vl]  // 11100101-01111000-11101101-10110111
// CHECK: st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0x78,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01111000-11101101-10110111
ST4W    {Z23.S, Z24.S, Z25.S, Z26.S}, P3, [X13, #-32, MUL VL]  // 11100101-01111000-11101101-10110111
// CHECK: st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0x78,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01111000-11101101-10110111
st4w    {z5.s, z6.s, z7.s, z8.s}, p3, [x17, x16, lsl #2]  // 11100101-01110000-01101110-00100101
// CHECK: st4w    {z5.s, z6.s, z7.s, z8.s}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x6e,0x70,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110000-01101110-00100101
ST4W    {Z5.S, Z6.S, Z7.S, Z8.S}, P3, [X17, X16, LSL #2]  // 11100101-01110000-01101110-00100101
// CHECK: st4w    {z5.s, z6.s, z7.s, z8.s}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x6e,0x70,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110000-01101110-00100101
st4w    {z31.s, z0.s, z1.s, z2.s}, p7, [sp, #-4, mul vl]  // 11100101-01111111-11111111-11111111
// CHECK: st4w    {z31.s, z0.s, z1.s, z2.s}, p7, [sp, #-4, mul vl] // encoding: [0xff,0xff,0x7f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01111111-11111111-11111111
ST4W    {Z31.S, Z0.S, Z1.S, Z2.S}, P7, [SP, #-4, MUL VL]  // 11100101-01111111-11111111-11111111
// CHECK: st4w    {z31.s, z0.s, z1.s, z2.s}, p7, [sp, #-4, mul vl] // encoding: [0xff,0xff,0x7f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01111111-11111111-11111111
st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, #20, mul vl]  // 11100101-01110101-11110101-01010101
// CHECK: st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, #20, mul vl] // encoding: [0x55,0xf5,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-11110101-01010101
ST4W    {Z21.S, Z22.S, Z23.S, Z24.S}, P5, [X10, #20, MUL VL]  // 11100101-01110101-11110101-01010101
// CHECK: st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, #20, mul vl] // encoding: [0x55,0xf5,0x75,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01110101-11110101-01010101
st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, x8, lsl #2]  // 11100101-01101000-01101101-10110111
// CHECK: st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x6d,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-01101101-10110111
ST4W    {Z23.S, Z24.S, Z25.S, Z26.S}, P3, [X13, X8, LSL #2]  // 11100101-01101000-01101101-10110111
// CHECK: st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x6d,0x68,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-01101000-01101101-10110111
