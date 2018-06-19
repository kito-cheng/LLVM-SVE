// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, #-24, mul vl]  // 10100101-11001000-11101101-10110111
// CHECK: ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xc8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11001000-11101101-10110111
LD3D    {Z23.D, Z24.D, Z25.D}, P3/Z, [X13, #-24, MUL VL]  // 10100101-11001000-11101101-10110111
// CHECK: ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xc8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11001000-11101101-10110111
ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, x21, lsl #3]  // 10100101-11010101-11010101-01010101
// CHECK: ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0xd5,0xd5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11010101-11010101-01010101
LD3D    {Z21.D, Z22.D, Z23.D}, P5/Z, [X10, X21, LSL #3]  // 10100101-11010101-11010101-01010101
// CHECK: ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0xd5,0xd5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11010101-11010101-01010101
ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, #15, mul vl]  // 10100101-11000101-11110101-01010101
// CHECK: ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xc5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11000101-11110101-01010101
LD3D    {Z21.D, Z22.D, Z23.D}, P5/Z, [X10, #15, MUL VL]  // 10100101-11000101-11110101-01010101
// CHECK: ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xc5,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11000101-11110101-01010101
ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0, x0, lsl #3]  // 10100101-11000000-11000000-00000000
// CHECK: ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0xc0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11000000-11000000-00000000
LD3D    {Z0.D, Z1.D, Z2.D}, P0/Z, [X0, X0, LSL #3]  // 10100101-11000000-11000000-00000000
// CHECK: ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0xc0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11000000-11000000-00000000
ld3d    {z5.d, z6.d, z7.d}, p3/z, [x17, x16, lsl #3]  // 10100101-11010000-11001110-00100101
// CHECK: ld3d    {z5.d, z6.d, z7.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0xce,0xd0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11010000-11001110-00100101
LD3D    {Z5.D, Z6.D, Z7.D}, P3/Z, [X17, X16, LSL #3]  // 10100101-11010000-11001110-00100101
// CHECK: ld3d    {z5.d, z6.d, z7.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0xce,0xd0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11010000-11001110-00100101
ld3d    {z31.d, z0.d, z1.d}, p7/z, [sp, #-3, mul vl]  // 10100101-11001111-11111111-11111111
// CHECK: ld3d    {z31.d, z0.d, z1.d}, p7/z, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xcf,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11001111-11111111-11111111
LD3D    {Z31.D, Z0.D, Z1.D}, P7/Z, [SP, #-3, MUL VL]  // 10100101-11001111-11111111-11111111
// CHECK: ld3d    {z31.d, z0.d, z1.d}, p7/z, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xcf,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11001111-11111111-11111111
ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, x8, lsl #3]  // 10100101-11001000-11001101-10110111
// CHECK: ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0xcd,0xc8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11001000-11001101-10110111
LD3D    {Z23.D, Z24.D, Z25.D}, P3/Z, [X13, X8, LSL #3]  // 10100101-11001000-11001101-10110111
// CHECK: ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0xcd,0xc8,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11001000-11001101-10110111
ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0]  // 10100101-11000000-11100000-00000000
// CHECK: ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11000000-11100000-00000000
LD3D    {Z0.D, Z1.D, Z2.D}, P0/Z, [X0]  // 10100101-11000000-11100000-00000000
// CHECK: ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0xa5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100101-11000000-11100000-00000000
