// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st2w    {z0.s, z1.s}, p0, [x0, x0, lsl #2]  // 11100101-00100000-01100000-00000000
// CHECK: st2w    {z0.s, z1.s}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x60,0x20,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00100000-01100000-00000000
ST2W    {Z0.S, Z1.S}, P0, [X0, X0, LSL #2]  // 11100101-00100000-01100000-00000000
// CHECK: st2w    {z0.s, z1.s}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x60,0x20,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00100000-01100000-00000000
st2w    {z0.s, z1.s}, p0, [x0]  // 11100101-00110000-11100000-00000000
// CHECK: st2w    {z0.s, z1.s}, p0, [x0] // encoding: [0x00,0xe0,0x30,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110000-11100000-00000000
ST2W    {Z0.S, Z1.S}, P0, [X0]  // 11100101-00110000-11100000-00000000
// CHECK: st2w    {z0.s, z1.s}, p0, [x0] // encoding: [0x00,0xe0,0x30,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110000-11100000-00000000
st2w    {z21.s, z22.s}, p5, [x10, x21, lsl #2]  // 11100101-00110101-01110101-01010101
// CHECK: st2w    {z21.s, z22.s}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x75,0x35,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110101-01110101-01010101
ST2W    {Z21.S, Z22.S}, P5, [X10, X21, LSL #2]  // 11100101-00110101-01110101-01010101
// CHECK: st2w    {z21.s, z22.s}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x75,0x35,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110101-01110101-01010101
st2w    {z23.s, z24.s}, p3, [x13, x8, lsl #2]  // 11100101-00101000-01101101-10110111
// CHECK: st2w    {z23.s, z24.s}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x6d,0x28,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00101000-01101101-10110111
ST2W    {Z23.S, Z24.S}, P3, [X13, X8, LSL #2]  // 11100101-00101000-01101101-10110111
// CHECK: st2w    {z23.s, z24.s}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x6d,0x28,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00101000-01101101-10110111
st2w    {z21.s, z22.s}, p5, [x10, #10, mul vl]  // 11100101-00110101-11110101-01010101
// CHECK: st2w    {z21.s, z22.s}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x35,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110101-11110101-01010101
ST2W    {Z21.S, Z22.S}, P5, [X10, #10, MUL VL]  // 11100101-00110101-11110101-01010101
// CHECK: st2w    {z21.s, z22.s}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x35,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110101-11110101-01010101
st2w    {z31.s, z0.s}, p7, [sp, #-2, mul vl]  // 11100101-00111111-11111111-11111111
// CHECK: st2w    {z31.s, z0.s}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x3f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00111111-11111111-11111111
ST2W    {Z31.S, Z0.S}, P7, [SP, #-2, MUL VL]  // 11100101-00111111-11111111-11111111
// CHECK: st2w    {z31.s, z0.s}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x3f,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00111111-11111111-11111111
st2w    {z23.s, z24.s}, p3, [x13, #-16, mul vl]  // 11100101-00111000-11101101-10110111
// CHECK: st2w    {z23.s, z24.s}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x38,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00111000-11101101-10110111
ST2W    {Z23.S, Z24.S}, P3, [X13, #-16, MUL VL]  // 11100101-00111000-11101101-10110111
// CHECK: st2w    {z23.s, z24.s}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x38,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00111000-11101101-10110111
st2w    {z5.s, z6.s}, p3, [x17, x16, lsl #2]  // 11100101-00110000-01101110-00100101
// CHECK: st2w    {z5.s, z6.s}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x6e,0x30,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110000-01101110-00100101
ST2W    {Z5.S, Z6.S}, P3, [X17, X16, LSL #2]  // 11100101-00110000-01101110-00100101
// CHECK: st2w    {z5.s, z6.s}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x6e,0x30,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-00110000-01101110-00100101
