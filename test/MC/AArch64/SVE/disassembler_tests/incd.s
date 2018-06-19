# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xe3,0xff,0x04
# CHECK: incd    xzr, all, mul #16 // encoding: [0xff,0xe3,0xff,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xc3,0xff,0x04
# CHECK: incd    z31.d, all, mul #16 // encoding: [0xff,0xc3,0xff,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe0,0xf0,0x04
# CHECK: incd    x0, pow2 // encoding: [0x00,0xe0,0xf0,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0xe1,0xf5,0x04
# CHECK: incd    x21, vl32, mul #6 // encoding: [0x55,0xe1,0xf5,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xc0,0xf0,0x04
# CHECK: incd    z0.d, pow2 // encoding: [0x00,0xc0,0xf0,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xc1,0xf8,0x04
# CHECK: incd    z23.d, vl256, mul #9 // encoding: [0xb7,0xc1,0xf8,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0xc1,0xf5,0x04
# CHECK: incd    z21.d, vl32, mul #6 // encoding: [0x55,0xc1,0xf5,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xe1,0xf8,0x04
# CHECK: incd    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0xf8,0x04]
# CHECK-ERROR: invalid instruction encoding
