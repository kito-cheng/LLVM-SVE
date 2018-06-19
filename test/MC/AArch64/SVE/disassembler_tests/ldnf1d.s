# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xb5,0xf5,0xa5
# CHECK: ldnf1d  {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xf5,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xad,0xf8,0xa5
# CHECK: ldnf1d  {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xf8,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xff,0xbf,0xff,0xa5
# CHECK: ldnf1d  {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xff,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0xa0,0xf0,0xa5
# CHECK: ldnf1d  {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0xf0,0xa5]
# CHECK-ERROR: invalid instruction encoding
