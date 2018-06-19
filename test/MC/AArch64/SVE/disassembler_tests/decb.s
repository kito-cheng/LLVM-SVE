# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xe5,0x35,0x04
# CHECK: decb    x21, vl32, mul #6 // encoding: [0x55,0xe5,0x35,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xe5,0x38,0x04
# CHECK: decb    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0x38,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe4,0x30,0x04
# CHECK: decb    x0, pow2 // encoding: [0x00,0xe4,0x30,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xe7,0x3f,0x04
# CHECK: decb    xzr, all, mul #16 // encoding: [0xff,0xe7,0x3f,0x04]
# CHECK-ERROR: invalid instruction encoding
