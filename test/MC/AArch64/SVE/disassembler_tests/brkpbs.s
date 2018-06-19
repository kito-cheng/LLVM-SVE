# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x10,0xc0,0x40,0x25
# CHECK: brkpbs  p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0xc0,0x40,0x25]
# CHECK-ERROR: invalid instruction encoding
0x55,0xd5,0x45,0x25
# CHECK: brkpbs  p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0xd5,0x45,0x25]
# CHECK-ERROR: invalid instruction encoding
0xff,0xfd,0x4f,0x25
# CHECK: brkpbs  p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0xfd,0x4f,0x25]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0x48,0x25
# CHECK: brkpbs  p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0xed,0x48,0x25]
# CHECK-ERROR: invalid instruction encoding
