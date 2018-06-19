# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xcd,0x28,0xa5
# CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0xcd,0x28,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe0,0x20,0xa5
# CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0] // encoding: [0x00,0xe0,0x20,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0x2f,0xa5
# CHECK: ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x2f,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x25,0xce,0x30,0xa5
# CHECK: ld2w    {z5.s, z6.s}, p3/z, [x17, x16, lsl #2] // encoding: [0x25,0xce,0x30,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0xc0,0x20,0xa5
# CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0xc0,0x20,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0x25,0xa5
# CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x25,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0x28,0xa5
# CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x28,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x55,0xd5,0x35,0xa5
# CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0xd5,0x35,0xa5]
# CHECK-ERROR: invalid instruction encoding
