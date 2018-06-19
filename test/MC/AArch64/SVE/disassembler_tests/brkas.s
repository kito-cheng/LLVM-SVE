# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x6d,0x50,0x25
# CHECK: brkas   p7.b, p11/z, p13.b // encoding: [0xa7,0x6d,0x50,0x25]
# CHECK-ERROR: invalid instruction encoding
0x00,0x40,0x50,0x25
# CHECK: brkas   p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x50,0x25]
# CHECK-ERROR: invalid instruction encoding
0x45,0x55,0x50,0x25
# CHECK: brkas   p5.b, p5/z, p10.b // encoding: [0x45,0x55,0x50,0x25]
# CHECK-ERROR: invalid instruction encoding
0xef,0x7d,0x50,0x25
# CHECK: brkas   p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x50,0x25]
# CHECK-ERROR: invalid instruction encoding
