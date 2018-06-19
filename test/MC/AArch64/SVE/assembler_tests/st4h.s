// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, #20, mul vl]  // 11100100-11110101-11110101-01010101
// CHECK: st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, #20, mul vl] // encoding: [0x55,0xf5,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-11110101-01010101
ST4H    {Z21.H, Z22.H, Z23.H, Z24.H}, P5, [X10, #20, MUL VL]  // 11100100-11110101-11110101-01010101
// CHECK: st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, #20, mul vl] // encoding: [0x55,0xf5,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-11110101-01010101
st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0]  // 11100100-11110000-11100000-00000000
// CHECK: st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0] // encoding: [0x00,0xe0,0xf0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110000-11100000-00000000
ST4H    {Z0.H, Z1.H, Z2.H, Z3.H}, P0, [X0]  // 11100100-11110000-11100000-00000000
// CHECK: st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0] // encoding: [0x00,0xe0,0xf0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110000-11100000-00000000
st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, x21, lsl #1]  // 11100100-11110101-01110101-01010101
// CHECK: st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x75,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-01110101-01010101
ST4H    {Z21.H, Z22.H, Z23.H, Z24.H}, P5, [X10, X21, LSL #1]  // 11100100-11110101-01110101-01010101
// CHECK: st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x75,0xf5,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110101-01110101-01010101
st4h    {z31.h, z0.h, z1.h, z2.h}, p7, [sp, #-4, mul vl]  // 11100100-11111111-11111111-11111111
// CHECK: st4h    {z31.h, z0.h, z1.h, z2.h}, p7, [sp, #-4, mul vl] // encoding: [0xff,0xff,0xff,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11111111-11111111-11111111
ST4H    {Z31.H, Z0.H, Z1.H, Z2.H}, P7, [SP, #-4, MUL VL]  // 11100100-11111111-11111111-11111111
// CHECK: st4h    {z31.h, z0.h, z1.h, z2.h}, p7, [sp, #-4, mul vl] // encoding: [0xff,0xff,0xff,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11111111-11111111-11111111
st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, x8, lsl #1]  // 11100100-11101000-01101101-10110111
// CHECK: st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-01101101-10110111
ST4H    {Z23.H, Z24.H, Z25.H, Z26.H}, P3, [X13, X8, LSL #1]  // 11100100-11101000-01101101-10110111
// CHECK: st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0xe8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11101000-01101101-10110111
st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, #-32, mul vl]  // 11100100-11111000-11101101-10110111
// CHECK: st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0xf8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11111000-11101101-10110111
ST4H    {Z23.H, Z24.H, Z25.H, Z26.H}, P3, [X13, #-32, MUL VL]  // 11100100-11111000-11101101-10110111
// CHECK: st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0xf8,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11111000-11101101-10110111
st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0, x0, lsl #1]  // 11100100-11100000-01100000-00000000
// CHECK: st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x60,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-01100000-00000000
ST4H    {Z0.H, Z1.H, Z2.H, Z3.H}, P0, [X0, X0, LSL #1]  // 11100100-11100000-01100000-00000000
// CHECK: st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x60,0xe0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11100000-01100000-00000000
st4h    {z5.h, z6.h, z7.h, z8.h}, p3, [x17, x16, lsl #1]  // 11100100-11110000-01101110-00100101
// CHECK: st4h    {z5.h, z6.h, z7.h, z8.h}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x6e,0xf0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110000-01101110-00100101
ST4H    {Z5.H, Z6.H, Z7.H, Z8.H}, P3, [X17, X16, LSL #1]  // 11100100-11110000-01101110-00100101
// CHECK: st4h    {z5.h, z6.h, z7.h, z8.h}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x6e,0xf0,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-11110000-01101110-00100101
