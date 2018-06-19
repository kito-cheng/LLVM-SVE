# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0x58,0x25
# CHECK: pfirst  p0.b, p0, p0.b // encoding: [0x00,0xc0,0x58,0x25]
# CHECK-ERROR: invalid instruction encoding
0xef,0xc1,0x58,0x25
# CHECK: pfirst  p15.b, p15, p15.b // encoding: [0xef,0xc1,0x58,0x25]
# CHECK-ERROR: invalid instruction encoding
0xa7,0xc1,0x58,0x25
# CHECK: pfirst  p7.b, p13, p7.b // encoding: [0xa7,0xc1,0x58,0x25]
# CHECK-ERROR: invalid instruction encoding
0x45,0xc1,0x58,0x25
# CHECK: pfirst  p5.b, p10, p5.b // encoding: [0x45,0xc1,0x58,0x25]
# CHECK-ERROR: invalid instruction encoding
