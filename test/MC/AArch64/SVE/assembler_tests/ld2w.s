// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld2w    {z23.s, z24.s}, p3/z, [x13, x8, lsl #2]  // 10100101-00101000-11001101-10110111
// CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0xcd,0x28,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00101000-11001101-10110111
LD2W    {Z23.S, Z24.S}, P3/Z, [X13, X8, LSL #2]  // 10100101-00101000-11001101-10110111
// CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0xcd,0x28,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00101000-11001101-10110111
ld2w    {z0.s, z1.s}, p0/z, [x0]  // 10100101-00100000-11100000-00000000
// CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0] // encoding: [0x00,0xe0,0x20,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00100000-11100000-00000000
LD2W    {Z0.S, Z1.S}, P0/Z, [X0]  // 10100101-00100000-11100000-00000000
// CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0] // encoding: [0x00,0xe0,0x20,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00100000-11100000-00000000
ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl]  // 10100101-00101111-11111111-11111111
// CHECK: ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x2f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00101111-11111111-11111111
LD2W    {Z31.S, Z0.S}, P7/Z, [SP, #-2, MUL VL]  // 10100101-00101111-11111111-11111111
// CHECK: ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x2f,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00101111-11111111-11111111
ld2w    {z5.s, z6.s}, p3/z, [x17, x16, lsl #2]  // 10100101-00110000-11001110-00100101
// CHECK: ld2w    {z5.s, z6.s}, p3/z, [x17, x16, lsl #2] // encoding: [0x25,0xce,0x30,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00110000-11001110-00100101
LD2W    {Z5.S, Z6.S}, P3/Z, [X17, X16, LSL #2]  // 10100101-00110000-11001110-00100101
// CHECK: ld2w    {z5.s, z6.s}, p3/z, [x17, x16, lsl #2] // encoding: [0x25,0xce,0x30,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00110000-11001110-00100101
ld2w    {z0.s, z1.s}, p0/z, [x0, x0, lsl #2]  // 10100101-00100000-11000000-00000000
// CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0xc0,0x20,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00100000-11000000-00000000
LD2W    {Z0.S, Z1.S}, P0/Z, [X0, X0, LSL #2]  // 10100101-00100000-11000000-00000000
// CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0xc0,0x20,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00100000-11000000-00000000
ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl]  // 10100101-00100101-11110101-01010101
// CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x25,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00100101-11110101-01010101
LD2W    {Z21.S, Z22.S}, P5/Z, [X10, #10, MUL VL]  // 10100101-00100101-11110101-01010101
// CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x25,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00100101-11110101-01010101
ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl]  // 10100101-00101000-11101101-10110111
// CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x28,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00101000-11101101-10110111
LD2W    {Z23.S, Z24.S}, P3/Z, [X13, #-16, MUL VL]  // 10100101-00101000-11101101-10110111
// CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x28,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00101000-11101101-10110111
ld2w    {z21.s, z22.s}, p5/z, [x10, x21, lsl #2]  // 10100101-00110101-11010101-01010101
// CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0xd5,0x35,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00110101-11010101-01010101
LD2W    {Z21.S, Z22.S}, P5/Z, [X10, X21, LSL #2]  // 10100101-00110101-11010101-01010101
// CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0xd5,0x35,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-00110101-11010101-01010101
