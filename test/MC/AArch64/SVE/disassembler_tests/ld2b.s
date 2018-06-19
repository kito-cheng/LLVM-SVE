# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0x20,0xa4
# CHECK: ld2b    {z0.b, z1.b}, p0/z, [x0, x0] // encoding: [0x00,0xc0,0x20,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xcd,0x28,0xa4
# CHECK: ld2b    {z23.b, z24.b}, p3/z, [x13, x8] // encoding: [0xb7,0xcd,0x28,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0x25,0xa4
# CHECK: ld2b    {z21.b, z22.b}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x25,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0x2f,0xa4
# CHECK: ld2b    {z31.b, z0.b}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x2f,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x25,0xce,0x30,0xa4
# CHECK: ld2b    {z5.b, z6.b}, p3/z, [x17, x16] // encoding: [0x25,0xce,0x30,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe0,0x20,0xa4
# CHECK: ld2b    {z0.b, z1.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x20,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xd5,0x35,0xa4
# CHECK: ld2b    {z21.b, z22.b}, p5/z, [x10, x21] // encoding: [0x55,0xd5,0x35,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0x28,0xa4
# CHECK: ld2b    {z23.b, z24.b}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x28,0xa4]
# CHECK-ERROR: invalid instruction encoding
