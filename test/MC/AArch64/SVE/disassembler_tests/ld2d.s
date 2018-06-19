# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0xa5,0xa5
# CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xa5,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe0,0xa0,0xa5
# CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xa0,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0xa8,0xa5
# CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xa8,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x25,0xce,0xb0,0xa5
# CHECK: ld2d    {z5.d, z6.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0xce,0xb0,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0xc0,0xa0,0xa5
# CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0xa0,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xcd,0xa8,0xa5
# CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0xcd,0xa8,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0xaf,0xa5
# CHECK: ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xaf,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x55,0xd5,0xb5,0xa5
# CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0xd5,0xb5,0xa5]
# CHECK-ERROR: invalid instruction encoding
