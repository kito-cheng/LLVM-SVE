# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xe1,0x25,0x04
# CHECK: cntb    x21, vl32, mul #6 // encoding: [0x55,0xe1,0x25,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xe0,0x20,0x04
# CHECK: cntb    x0, pow2 // encoding: [0x00,0xe0,0x20,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xe1,0x28,0x04
# CHECK: cntb    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0x28,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xe3,0x2f,0x04
# CHECK: cntb    xzr, all, mul #16 // encoding: [0xff,0xe3,0x2f,0x04]
# CHECK-ERROR: invalid instruction encoding
