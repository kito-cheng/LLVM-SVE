# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x60,0x20,0xe5
# CHECK: st2w    {z0.s, z1.s}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x60,0x20,0xe5]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe0,0x30,0xe5
# CHECK: st2w    {z0.s, z1.s}, p0, [x0] // encoding: [0x00,0xe0,0x30,0xe5]
# CHECK-ERROR: invalid instruction encoding
0x55,0x75,0x35,0xe5
# CHECK: st2w    {z21.s, z22.s}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x75,0x35,0xe5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x6d,0x28,0xe5
# CHECK: st2w    {z23.s, z24.s}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x6d,0x28,0xe5]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0x35,0xe5
# CHECK: st2w    {z21.s, z22.s}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x35,0xe5]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0x3f,0xe5
# CHECK: st2w    {z31.s, z0.s}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x3f,0xe5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0x38,0xe5
# CHECK: st2w    {z23.s, z24.s}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x38,0xe5]
# CHECK-ERROR: invalid instruction encoding
0x25,0x6e,0x30,0xe5
# CHECK: st2w    {z5.s, z6.s}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x6e,0x30,0xe5]
# CHECK-ERROR: invalid instruction encoding
