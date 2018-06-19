# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0xf0,0xe5
# CHECK: st4d    {z0.d, z1.d, z2.d, z3.d}, p0, [x0] // encoding: [0x00,0xe0,0xf0,0xe5]
# CHECK-ERROR: invalid instruction encoding
0x25,0x6e,0xf0,0xe5
# CHECK: st4d    {z5.d, z6.d, z7.d, z8.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x6e,0xf0,0xe5]
# CHECK-ERROR: invalid instruction encoding
0x55,0x75,0xf5,0xe5
# CHECK: st4d    {z21.d, z22.d, z23.d, z24.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x75,0xf5,0xe5]
# CHECK-ERROR: invalid instruction encoding
0x00,0x60,0xe0,0xe5
# CHECK: st4d    {z0.d, z1.d, z2.d, z3.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x60,0xe0,0xe5]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0xf5,0xe5
# CHECK: st4d    {z21.d, z22.d, z23.d, z24.d}, p5, [x10, #20, mul vl] // encoding: [0x55,0xf5,0xf5,0xe5]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0xff,0xe5
# CHECK: st4d    {z31.d, z0.d, z1.d, z2.d}, p7, [sp, #-4, mul vl] // encoding: [0xff,0xff,0xff,0xe5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0xf8,0xe5
# CHECK: st4d    {z23.d, z24.d, z25.d, z26.d}, p3, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0xf8,0xe5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x6d,0xe8,0xe5
# CHECK: st4d    {z23.d, z24.d, z25.d, z26.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x6d,0xe8,0xe5]
# CHECK-ERROR: invalid instruction encoding
