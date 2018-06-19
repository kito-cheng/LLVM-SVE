// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
st2b    {z0.b, z1.b}, p0, [x0]  // 11100100-00110000-11100000-00000000
// CHECK: st2b    {z0.b, z1.b}, p0, [x0] // encoding: [0x00,0xe0,0x30,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110000-11100000-00000000
ST2B    {Z0.B, Z1.B}, P0, [X0]  // 11100100-00110000-11100000-00000000
// CHECK: st2b    {z0.b, z1.b}, p0, [x0] // encoding: [0x00,0xe0,0x30,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110000-11100000-00000000
st2b    {z5.b, z6.b}, p3, [x17, x16]  // 11100100-00110000-01101110-00100101
// CHECK: st2b    {z5.b, z6.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x30,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110000-01101110-00100101
ST2B    {Z5.B, Z6.B}, P3, [X17, X16]  // 11100100-00110000-01101110-00100101
// CHECK: st2b    {z5.b, z6.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x30,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110000-01101110-00100101
st2b    {z23.b, z24.b}, p3, [x13, x8]  // 11100100-00101000-01101101-10110111
// CHECK: st2b    {z23.b, z24.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x28,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00101000-01101101-10110111
ST2B    {Z23.B, Z24.B}, P3, [X13, X8]  // 11100100-00101000-01101101-10110111
// CHECK: st2b    {z23.b, z24.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x28,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00101000-01101101-10110111
st2b    {z21.b, z22.b}, p5, [x10, #10, mul vl]  // 11100100-00110101-11110101-01010101
// CHECK: st2b    {z21.b, z22.b}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x35,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110101-11110101-01010101
ST2B    {Z21.B, Z22.B}, P5, [X10, #10, MUL VL]  // 11100100-00110101-11110101-01010101
// CHECK: st2b    {z21.b, z22.b}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x35,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110101-11110101-01010101
st2b    {z0.b, z1.b}, p0, [x0, x0]  // 11100100-00100000-01100000-00000000
// CHECK: st2b    {z0.b, z1.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x20,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00100000-01100000-00000000
ST2B    {Z0.B, Z1.B}, P0, [X0, X0]  // 11100100-00100000-01100000-00000000
// CHECK: st2b    {z0.b, z1.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x20,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00100000-01100000-00000000
st2b    {z31.b, z0.b}, p7, [sp, #-2, mul vl]  // 11100100-00111111-11111111-11111111
// CHECK: st2b    {z31.b, z0.b}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x3f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00111111-11111111-11111111
ST2B    {Z31.B, Z0.B}, P7, [SP, #-2, MUL VL]  // 11100100-00111111-11111111-11111111
// CHECK: st2b    {z31.b, z0.b}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x3f,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00111111-11111111-11111111
st2b    {z21.b, z22.b}, p5, [x10, x21]  // 11100100-00110101-01110101-01010101
// CHECK: st2b    {z21.b, z22.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x35,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110101-01110101-01010101
ST2B    {Z21.B, Z22.B}, P5, [X10, X21]  // 11100100-00110101-01110101-01010101
// CHECK: st2b    {z21.b, z22.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x35,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00110101-01110101-01010101
st2b    {z23.b, z24.b}, p3, [x13, #-16, mul vl]  // 11100100-00111000-11101101-10110111
// CHECK: st2b    {z23.b, z24.b}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x38,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00111000-11101101-10110111
ST2B    {Z23.B, Z24.B}, P3, [X13, #-16, MUL VL]  // 11100100-00111000-11101101-10110111
// CHECK: st2b    {z23.b, z24.b}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x38,0xe4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100100-00111000-11101101-10110111
