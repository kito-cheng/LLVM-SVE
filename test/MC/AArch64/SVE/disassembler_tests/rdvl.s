# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x50,0xbf,0x04
# CHECK: rdvl    x0, #0 // encoding: [0x00,0x50,0xbf,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0x55,0xbf,0x04
# CHECK: rdvl    x21, #-22 // encoding: [0x55,0x55,0xbf,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0x57,0xbf,0x04
# CHECK: rdvl    xzr, #-1 // encoding: [0xff,0x57,0xbf,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x55,0xbf,0x04
# CHECK: rdvl    x23, #-19 // encoding: [0xb7,0x55,0xbf,0x04]
# CHECK-ERROR: invalid instruction encoding
