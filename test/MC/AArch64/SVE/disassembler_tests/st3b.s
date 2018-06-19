# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0x50,0xe4
# CHECK: st3b    {z0.b, z1.b, z2.b}, p0, [x0] // encoding: [0x00,0xe0,0x50,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x00,0x60,0x40,0xe4
# CHECK: st3b    {z0.b, z1.b, z2.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x40,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0x55,0xe4
# CHECK: st3b    {z21.b, z22.b, z23.b}, p5, [x10, #15, mul vl] // encoding: [0x55,0xf5,0x55,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x25,0x6e,0x50,0xe4
# CHECK: st3b    {z5.b, z6.b, z7.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x50,0xe4]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0x5f,0xe4
# CHECK: st3b    {z31.b, z0.b, z1.b}, p7, [sp, #-3, mul vl] // encoding: [0xff,0xff,0x5f,0xe4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x6d,0x48,0xe4
# CHECK: st3b    {z23.b, z24.b, z25.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x48,0xe4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0x58,0xe4
# CHECK: st3b    {z23.b, z24.b, z25.b}, p3, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0x58,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x55,0x75,0x55,0xe4
# CHECK: st3b    {z21.b, z22.b, z23.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x55,0xe4]
# CHECK-ERROR: invalid instruction encoding
