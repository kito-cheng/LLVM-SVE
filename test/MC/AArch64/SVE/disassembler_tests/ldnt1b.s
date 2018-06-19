# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0x0f,0xa4
# CHECK: ldnt1b  {z31.b}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x0f,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xd5,0x15,0xa4
# CHECK: ldnt1b  {z21.b}, p5/z, [x10, x21] // encoding: [0x55,0xd5,0x15,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe0,0x00,0xa4
# CHECK: ldnt1b  {z0.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x00,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0x08,0xa4
# CHECK: ldnt1b  {z23.b}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x08,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0x05,0xa4
# CHECK: ldnt1b  {z21.b}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x05,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x25,0xce,0x10,0xa4
# CHECK: ldnt1b  {z5.b}, p3/z, [x17, x16] // encoding: [0x25,0xce,0x10,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xcd,0x08,0xa4
# CHECK: ldnt1b  {z23.b}, p3/z, [x13, x8] // encoding: [0xb7,0xcd,0x08,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0xc0,0x00,0xa4
# CHECK: ldnt1b  {z0.b}, p0/z, [x0, x0] // encoding: [0x00,0xc0,0x00,0xa4]
# CHECK-ERROR: invalid instruction encoding
