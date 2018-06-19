# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0xc0,0xa4
# CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0xc0,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xd5,0xd5,0xa4
# CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0xd5,0xd5,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0xc5,0xa4
# CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xc5,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x25,0xce,0xd0,0xa4
# CHECK: ld3h    {z5.h, z6.h, z7.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0xce,0xd0,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0xcf,0xa4
# CHECK: ld3h    {z31.h, z0.h, z1.h}, p7/z, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xcf,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe0,0xc0,0xa4
# CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xcd,0xc8,0xa4
# CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0xcd,0xc8,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0xc8,0xa4
# CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xc8,0xa4]
# CHECK-ERROR: invalid instruction encoding
