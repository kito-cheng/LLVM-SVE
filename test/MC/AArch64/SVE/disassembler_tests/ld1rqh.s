# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x20,0x80,0xa4
# CHECK: ld1rqh  {z0.h}, p0/z, [x0] // encoding: [0x00,0x20,0x80,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x0d,0x88,0xa4
# CHECK: ld1rqh  {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x0d,0x88,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x2d,0x88,0xa4
# CHECK: ld1rqh  {z23.h}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x88,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xff,0x3f,0x8f,0xa4
# CHECK: ld1rqh  {z31.h}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x8f,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0x00,0x80,0xa4
# CHECK: ld1rqh  {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x00,0x80,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0x15,0x95,0xa4
# CHECK: ld1rqh  {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x15,0x95,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x25,0x0e,0x90,0xa4
# CHECK: ld1rqh  {z5.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0x0e,0x90,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0x35,0x85,0xa4
# CHECK: ld1rqh  {z21.h}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x85,0xa4]
# CHECK-ERROR: invalid instruction encoding
