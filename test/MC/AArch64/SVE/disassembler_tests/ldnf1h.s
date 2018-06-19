# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xb5,0xf5,0xa4
# CHECK: ldnf1h  {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xf5,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xad,0xd8,0xa4
# CHECK: ldnf1h  {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xd8,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xb5,0xd5,0xa4
# CHECK: ldnf1h  {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xd5,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xff,0xbf,0xdf,0xa4
# CHECK: ldnf1h  {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xdf,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0xa0,0xd0,0xa4
# CHECK: ldnf1h  {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0xd0,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xff,0xbf,0xff,0xa4
# CHECK: ldnf1h  {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xff,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xad,0xb8,0xa4
# CHECK: ldnf1h  {z23.h}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xb8,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xad,0xf8,0xa4
# CHECK: ldnf1h  {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xf8,0xa4]
# CHECK-ERROR: invalid instruction encoding
0xff,0xbf,0xbf,0xa4
# CHECK: ldnf1h  {z31.h}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xbf,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0xa0,0xf0,0xa4
# CHECK: ldnf1h  {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0xf0,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xb5,0xb5,0xa4
# CHECK: ldnf1h  {z21.h}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xb5,0xa4]
# CHECK-ERROR: invalid instruction encoding
0x00,0xa0,0xb0,0xa4
# CHECK: ldnf1h  {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0xb0,0xa4]
# CHECK-ERROR: invalid instruction encoding
