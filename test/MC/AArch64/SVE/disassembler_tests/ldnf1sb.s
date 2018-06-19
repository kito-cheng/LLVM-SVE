# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0x98,0xa5
# CHECK: ldnf1sb {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x98,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xff,0xbf,0xbf,0xa5
# CHECK: ldnf1sb {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xbf,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x55,0xb5,0xd5,0xa5
# CHECK: ldnf1sb {z21.h}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xd5,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x55,0xb5,0x95,0xa5
# CHECK: ldnf1sb {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x95,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xff,0xbf,0xdf,0xa5
# CHECK: ldnf1sb {z31.h}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xdf,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xad,0xd8,0xa5
# CHECK: ldnf1sb {z23.h}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xd8,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0xa0,0x90,0xa5
# CHECK: ldnf1sb {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x90,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x55,0xb5,0xb5,0xa5
# CHECK: ldnf1sb {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xb5,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0xa0,0xd0,0xa5
# CHECK: ldnf1sb {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0xd0,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xad,0xb8,0xa5
# CHECK: ldnf1sb {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xb8,0xa5]
# CHECK-ERROR: invalid instruction encoding
0x00,0xa0,0xb0,0xa5
# CHECK: ldnf1sb {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0xb0,0xa5]
# CHECK-ERROR: invalid instruction encoding
0xff,0xbf,0x9f,0xa5
# CHECK: ldnf1sb {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x9f,0xa5]
# CHECK-ERROR: invalid instruction encoding
