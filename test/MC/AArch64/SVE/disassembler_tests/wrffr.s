# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x40,0x91,0x28,0x25
# CHECK: wrffr   p10.b // encoding: [0x40,0x91,0x28,0x25]
# CHECK-ERROR: invalid instruction encoding
0xe0,0x91,0x28,0x25
# CHECK: wrffr   p15.b // encoding: [0xe0,0x91,0x28,0x25]
# CHECK-ERROR: invalid instruction encoding
0xa0,0x91,0x28,0x25
# CHECK: wrffr   p13.b // encoding: [0xa0,0x91,0x28,0x25]
# CHECK-ERROR: invalid instruction encoding
0x00,0x90,0x28,0x25
# CHECK: wrffr   p0.b // encoding: [0x00,0x90,0x28,0x25]
# CHECK-ERROR: invalid instruction encoding
