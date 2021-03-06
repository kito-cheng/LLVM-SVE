# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xc1,0xe8,0x04
# CHECK: sqincd  z23.d, vl256, mul #9 // encoding: [0xb7,0xc1,0xe8,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xf0,0xf0,0x04
# CHECK: sqincd  x0, pow2 // encoding: [0x00,0xf0,0xf0,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xc0,0xe0,0x04
# CHECK: sqincd  z0.d, pow2 // encoding: [0x00,0xc0,0xe0,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xf3,0xef,0x04
# CHECK: sqincd  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0xef,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xf0,0xe0,0x04
# CHECK: sqincd  x0, w0, pow2 // encoding: [0x00,0xf0,0xe0,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xf1,0xf8,0x04
# CHECK: sqincd  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0xf8,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf1,0xf5,0x04
# CHECK: sqincd  x21, vl32, mul #6 // encoding: [0x55,0xf1,0xf5,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xc3,0xef,0x04
# CHECK: sqincd  z31.d, all, mul #16 // encoding: [0xff,0xc3,0xef,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xf1,0xe8,0x04
# CHECK: sqincd  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0xe8,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xf3,0xff,0x04
# CHECK: sqincd  xzr, all, mul #16 // encoding: [0xff,0xf3,0xff,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0xc1,0xe5,0x04
# CHECK: sqincd  z21.d, vl32, mul #6 // encoding: [0x55,0xc1,0xe5,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf1,0xe5,0x04
# CHECK: sqincd  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0xe5,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb5,0xf2,0xe0,0x04
# CHECK: sqincd  x21, w21, #21  // encoding: [0xb5,0xf2,0xe0,0x04]
# CHECK-ERROR: invalid instruction encoding
0xd6,0xf1,0xe2,0x04
# CHECK: sqincd  x22, w22, #14, mul #3   // encoding: [0xd6,0xf1,0xe2,0x04]
# CHECK-ERROR: invalid instruction encoding
