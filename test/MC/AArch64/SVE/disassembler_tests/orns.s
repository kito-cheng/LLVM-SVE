# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x6d,0xc8,0x25
# CHECK: orns    p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6d,0xc8,0x25]
# CHECK-ERROR: invalid instruction encoding
0x10,0x40,0xc0,0x25
# CHECK: orns    p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x40,0xc0,0x25]
# CHECK-ERROR: invalid instruction encoding
0xff,0x7d,0xcf,0x25
# CHECK: orns    p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7d,0xcf,0x25]
# CHECK-ERROR: invalid instruction encoding
0x55,0x55,0xc5,0x25
# CHECK: orns    p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x55,0xc5,0x25]
# CHECK-ERROR: invalid instruction encoding
