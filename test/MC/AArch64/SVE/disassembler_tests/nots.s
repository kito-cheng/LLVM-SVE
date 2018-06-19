# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x42,0x40,0x25
# CHECK: nots    p0.b, p0/z, p0.b // encoding: [0x00,0x42,0x40,0x25]
# CHECK-ERROR: invalid instruction encoding
0xef,0x7f,0x4f,0x25
# CHECK: nots    p15.b, p15/z, p15.b // encoding: [0xef,0x7f,0x4f,0x25]
# CHECK-ERROR: invalid instruction encoding
0x45,0x57,0x45,0x25
# CHECK: nots    p5.b, p5/z, p10.b // encoding: [0x45,0x57,0x45,0x25]
# CHECK-ERROR: invalid instruction encoding
