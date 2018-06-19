# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xc5,0xf5,0x04
# CHECK: decd    z21.d, vl32, mul #6 // encoding: [0x55,0xc5,0xf5,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xc4,0xf0,0x04
# CHECK: decd    z0.d, pow2 // encoding: [0x00,0xc4,0xf0,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xc7,0xff,0x04
# CHECK: decd    z31.d, all, mul #16 // encoding: [0xff,0xc7,0xff,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xe5,0xf8,0x04
# CHECK: decd    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0xf8,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xc5,0xf8,0x04
# CHECK: decd    z23.d, vl256, mul #9 // encoding: [0xb7,0xc5,0xf8,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xe7,0xff,0x04
# CHECK: decd    xzr, all, mul #16 // encoding: [0xff,0xe7,0xff,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0xe5,0xf5,0x04
# CHECK: decd    x21, vl32, mul #6 // encoding: [0x55,0xe5,0xf5,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe4,0xf0,0x04
# CHECK: decd    x0, pow2 // encoding: [0x00,0xe4,0xf0,0x04]
# CHECK-ERROR: invalid instruction encoding
