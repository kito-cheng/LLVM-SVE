# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x40,0x40,0x25
# CHECK: movs    p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x40,0x25]
# CHECK-ERROR: invalid instruction encoding
0x00,0x40,0xc0,0x25
# CHECK: movs    p0.b, p0.b // encoding: [0x00,0x40,0xc0,0x25]
# CHECK-ERROR: invalid instruction encoding
0xef,0x7d,0xcf,0x25
# CHECK: movs    p15.b, p15.b // encoding: [0xef,0x7d,0xcf,0x25]
# CHECK-ERROR: invalid instruction encoding
0xef,0x7d,0x4f,0x25
# CHECK: movs    p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x4f,0x25]
# CHECK-ERROR: invalid instruction encoding
