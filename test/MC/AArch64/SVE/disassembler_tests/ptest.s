# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0x50,0x25
# CHECK: ptest   p0, p0.b // encoding: [0x00,0xc0,0x50,0x25]
# CHECK-ERROR: invalid instruction encoding
0x40,0xd5,0x50,0x25
# CHECK: ptest   p5, p10.b // encoding: [0x40,0xd5,0x50,0x25]
# CHECK-ERROR: invalid instruction encoding
0xa0,0xed,0x50,0x25
# CHECK: ptest   p11, p13.b // encoding: [0xa0,0xed,0x50,0x25]
# CHECK-ERROR: invalid instruction encoding
0xe0,0xfd,0x50,0x25
# CHECK: ptest   p15, p15.b // encoding: [0xe0,0xfd,0x50,0x25]
# CHECK-ERROR: invalid instruction encoding
