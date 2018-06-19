# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x90,0x2c,0x25
# CHECK: setffr   // encoding: [0x00,0x90,0x2c,0x25]
# CHECK-ERROR: invalid instruction encoding
