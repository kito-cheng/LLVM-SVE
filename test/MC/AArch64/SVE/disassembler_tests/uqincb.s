# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0x35,0x04
# CHECK: uqincb  x21, vl32, mul #6 // encoding: [0x55,0xf5,0x35,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xf7,0x2f,0x04
# CHECK: uqincb  wzr, all, mul #16 // encoding: [0xff,0xf7,0x2f,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xf4,0x30,0x04
# CHECK: uqincb  x0, pow2 // encoding: [0x00,0xf4,0x30,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xf5,0x28,0x04
# CHECK: uqincb  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0x28,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xf5,0x38,0x04
# CHECK: uqincb  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0x38,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xf4,0x20,0x04
# CHECK: uqincb  w0, pow2 // encoding: [0x00,0xf4,0x20,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0x25,0x04
# CHECK: uqincb  w21, vl32, mul #6 // encoding: [0x55,0xf5,0x25,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xf7,0x3f,0x04
# CHECK: uqincb  xzr, all, mul #16 // encoding: [0xff,0xf7,0x3f,0x04]
# CHECK-ERROR: invalid instruction encoding
