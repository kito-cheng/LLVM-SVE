# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0x57,0xc5,0x25
# CHECK: nors    p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x57,0xc5,0x25]
# CHECK-ERROR: invalid instruction encoding
0xa7,0x6f,0xc8,0x25
# CHECK: nors    p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0x6f,0xc8,0x25]
# CHECK-ERROR: invalid instruction encoding
0xef,0x7f,0xcf,0x25
# CHECK: nors    p15.b, p15/z, p15.b, p15.b // encoding: [0xef,0x7f,0xcf,0x25]
# CHECK-ERROR: invalid instruction encoding
0x00,0x42,0xc0,0x25
# CHECK: nors    p0.b, p0/z, p0.b, p0.b // encoding: [0x00,0x42,0xc0,0x25]
# CHECK-ERROR: invalid instruction encoding
