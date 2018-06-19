// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, #20, mul vl]  // 10100100-01100101-11110101-01010101
// CHECK: ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, #20, mul vl] // encoding: [0x55,0xf5,0x65,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100101-11110101-01010101
LD4B    {Z21.B, Z22.B, Z23.B, Z24.B}, P5/Z, [X10, #20, MUL VL]  // 10100100-01100101-11110101-01010101
// CHECK: ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, #20, mul vl] // encoding: [0x55,0xf5,0x65,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100101-11110101-01010101
ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, x21]  // 10100100-01110101-11010101-01010101
// CHECK: ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, x21] // encoding: [0x55,0xd5,0x75,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110101-11010101-01010101
LD4B    {Z21.B, Z22.B, Z23.B, Z24.B}, P5/Z, [X10, X21]  // 10100100-01110101-11010101-01010101
// CHECK: ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, x21] // encoding: [0x55,0xd5,0x75,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110101-11010101-01010101
ld4b    {z5.b, z6.b, z7.b, z8.b}, p3/z, [x17, x16]  // 10100100-01110000-11001110-00100101
// CHECK: ld4b    {z5.b, z6.b, z7.b, z8.b}, p3/z, [x17, x16] // encoding: [0x25,0xce,0x70,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110000-11001110-00100101
LD4B    {Z5.B, Z6.B, Z7.B, Z8.B}, P3/Z, [X17, X16]  // 10100100-01110000-11001110-00100101
// CHECK: ld4b    {z5.b, z6.b, z7.b, z8.b}, p3/z, [x17, x16] // encoding: [0x25,0xce,0x70,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01110000-11001110-00100101
ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0]  // 10100100-01100000-11100000-00000000
// CHECK: ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x60,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100000-11100000-00000000
LD4B    {Z0.B, Z1.B, Z2.B, Z3.B}, P0/Z, [X0]  // 10100100-01100000-11100000-00000000
// CHECK: ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x60,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100000-11100000-00000000
ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, x8]  // 10100100-01101000-11001101-10110111
// CHECK: ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, x8] // encoding: [0xb7,0xcd,0x68,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101000-11001101-10110111
LD4B    {Z23.B, Z24.B, Z25.B, Z26.B}, P3/Z, [X13, X8]  // 10100100-01101000-11001101-10110111
// CHECK: ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, x8] // encoding: [0xb7,0xcd,0x68,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101000-11001101-10110111
ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, #-32, mul vl]  // 10100100-01101000-11101101-10110111
// CHECK: ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0x68,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101000-11101101-10110111
LD4B    {Z23.B, Z24.B, Z25.B, Z26.B}, P3/Z, [X13, #-32, MUL VL]  // 10100100-01101000-11101101-10110111
// CHECK: ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0x68,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101000-11101101-10110111
ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0, x0]  // 10100100-01100000-11000000-00000000
// CHECK: ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0, x0] // encoding: [0x00,0xc0,0x60,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100000-11000000-00000000
LD4B    {Z0.B, Z1.B, Z2.B, Z3.B}, P0/Z, [X0, X0]  // 10100100-01100000-11000000-00000000
// CHECK: ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0, x0] // encoding: [0x00,0xc0,0x60,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01100000-11000000-00000000
ld4b    {z31.b, z0.b, z1.b, z2.b}, p7/z, [sp, #-4, mul vl]  // 10100100-01101111-11111111-11111111
// CHECK: ld4b    {z31.b, z0.b, z1.b, z2.b}, p7/z, [sp, #-4, mul vl] // encoding: [0xff,0xff,0x6f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101111-11111111-11111111
LD4B    {Z31.B, Z0.B, Z1.B, Z2.B}, P7/Z, [SP, #-4, MUL VL]  // 10100100-01101111-11111111-11111111
// CHECK: ld4b    {z31.b, z0.b, z1.b, z2.b}, p7/z, [sp, #-4, mul vl] // encoding: [0xff,0xff,0x6f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-01101111-11111111-11111111
