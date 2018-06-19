# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x3f,0x8f,0xa5
# CHECK: ld1rqd  {z31.d}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x8f,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0x00,0x80,0xa5
# CHECK: ld1rqd  {z0.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0x00,0x80,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x2d,0x88,0xa5
# CHECK: ld1rqd  {z23.d}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x88,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x55,0x35,0x85,0xa5
# CHECK: ld1rqd  {z21.d}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x85,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0x20,0x80,0xa5
# CHECK: ld1rqd  {z0.d}, p0/z, [x0] // encoding: [0x00,0x20,0x80,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x25,0x0e,0x90,0xa5
# CHECK: ld1rqd  {z5.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0x0e,0x90,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x0d,0x88,0xa5
# CHECK: ld1rqd  {z23.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0x0d,0x88,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x55,0x15,0x95,0xa5
# CHECK: ld1rqd  {z21.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0x15,0x95,0xa5]
# CHECK-ERROR: invalid instruction encoding
