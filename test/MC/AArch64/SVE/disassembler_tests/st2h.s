# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x6d,0xa8,0xe4
# CHECK: st2h    {z23.h, z24.h}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0xa8,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe0,0xb0,0xe4
# CHECK: st2h    {z0.h, z1.h}, p0, [x0] // encoding: [0x00,0xe0,0xb0,0xe4]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0xbf,0xe4
# CHECK: st2h    {z31.h, z0.h}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xbf,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x00,0x60,0xa0,0xe4
# CHECK: st2h    {z0.h, z1.h}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x60,0xa0,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x55,0x75,0xb5,0xe4
# CHECK: st2h    {z21.h, z22.h}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x75,0xb5,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0xb5,0xe4
# CHECK: st2h    {z21.h, z22.h}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xb5,0xe4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0xb8,0xe4
# CHECK: st2h    {z23.h, z24.h}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xb8,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x25,0x6e,0xb0,0xe4
# CHECK: st2h    {z5.h, z6.h}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x6e,0xb0,0xe4]
# CHECK-ERROR: invalid instruction encoding
