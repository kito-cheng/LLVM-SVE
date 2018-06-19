# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x0d,0x08,0xa4
# CHECK: ld1rqb  {z23.b}, p3/z, [x13, x8] // encoding: [0xb7,0x0d,0x08,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x2d,0x08,0xa4
# CHECK: ld1rqb  {z23.b}, p3/z, [x13, #-128] // encoding: [0xb7,0x2d,0x08,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0x35,0x05,0xa4
# CHECK: ld1rqb  {z21.b}, p5/z, [x10, #80] // encoding: [0x55,0x35,0x05,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xff,0x3f,0x0f,0xa4
# CHECK: ld1rqb  {z31.b}, p7/z, [sp, #-16] // encoding: [0xff,0x3f,0x0f,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0x20,0x00,0xa4
# CHECK: ld1rqb  {z0.b}, p0/z, [x0] // encoding: [0x00,0x20,0x00,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0x00,0x00,0xa4
# CHECK: ld1rqb  {z0.b}, p0/z, [x0, x0] // encoding: [0x00,0x00,0x00,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x25,0x0e,0x10,0xa4
# CHECK: ld1rqb  {z5.b}, p3/z, [x17, x16] // encoding: [0x25,0x0e,0x10,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0x15,0x15,0xa4
# CHECK: ld1rqb  {z21.b}, p5/z, [x10, x21] // encoding: [0x55,0x15,0x15,0xa4]
# CHECK-ERROR: invalid instruction encoding
