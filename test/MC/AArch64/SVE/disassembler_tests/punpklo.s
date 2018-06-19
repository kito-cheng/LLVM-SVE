# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x40,0x30,0x05
# CHECK: punpklo p0.h, p0.b // encoding: [0x00,0x40,0x30,0x05]
# CHECK-ERROR: invalid instruction encoding
0xa7,0x41,0x30,0x05
# CHECK: punpklo p7.h, p13.b // encoding: [0xa7,0x41,0x30,0x05]
# CHECK-ERROR: invalid instruction encoding
0xef,0x41,0x30,0x05
# CHECK: punpklo p15.h, p15.b // encoding: [0xef,0x41,0x30,0x05]
# CHECK-ERROR: invalid instruction encoding
0x45,0x41,0x30,0x05
# CHECK: punpklo p5.h, p10.b // encoding: [0x45,0x41,0x30,0x05]
# CHECK-ERROR: invalid instruction encoding
