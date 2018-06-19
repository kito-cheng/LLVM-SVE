# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0xce,0x90,0xa4
# CHECK: ldnt1h  {z5.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0xce,0x90,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0x85,0xa4
# CHECK: ldnt1h  {z21.h}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x85,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe0,0x80,0xa4
# CHECK: ldnt1h  {z0.h}, p0/z, [x0] // encoding: [0x00,0xe0,0x80,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0x8f,0xa4
# CHECK: ldnt1h  {z31.h}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x8f,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xcd,0x88,0xa4
# CHECK: ldnt1h  {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0xcd,0x88,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xd5,0x95,0xa4
# CHECK: ldnt1h  {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0xd5,0x95,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0x88,0xa4
# CHECK: ldnt1h  {z23.h}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x88,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0xc0,0x80,0xa4
# CHECK: ldnt1h  {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0x80,0xa4]
# CHECK-ERROR: invalid instruction encoding
