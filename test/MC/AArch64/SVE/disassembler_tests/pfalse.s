# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe4,0x18,0x25
# CHECK: pfalse  p0.b // encoding: [0x00,0xe4,0x18,0x25]
# CHECK-ERROR: invalid instruction encoding
0x07,0xe4,0x18,0x25
# CHECK: pfalse  p7.b // encoding: [0x07,0xe4,0x18,0x25]
# CHECK-ERROR: invalid instruction encoding
0x05,0xe4,0x18,0x25
# CHECK: pfalse  p5.b // encoding: [0x05,0xe4,0x18,0x25]
# CHECK-ERROR: invalid instruction encoding
0x0f,0xe4,0x18,0x25
# CHECK: pfalse  p15.b // encoding: [0x0f,0xe4,0x18,0x25]
# CHECK-ERROR: invalid instruction encoding
