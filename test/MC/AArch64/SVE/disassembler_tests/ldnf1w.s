# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xa0,0x50,0xa5
# CHECK: ldnf1w  {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0x50,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x55,0xb5,0x75,0xa5
# CHECK: ldnf1w  {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x75,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xad,0x78,0xa5
# CHECK: ldnf1w  {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x78,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xad,0x58,0xa5
# CHECK: ldnf1w  {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x58,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0xa0,0x70,0xa5
# CHECK: ldnf1w  {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x70,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xff,0xbf,0x7f,0xa5
# CHECK: ldnf1w  {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x7f,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xff,0xbf,0x5f,0xa5
# CHECK: ldnf1w  {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x5f,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x55,0xb5,0x55,0xa5
# CHECK: ldnf1w  {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x55,0xa5]
# CHECK-ERROR: invalid instruction encoding
