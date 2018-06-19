# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x55,0x75,0x04
# CHECK: addpl   x21, x21, #-22 // encoding: [0x55,0x55,0x75,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x55,0x68,0x04
# CHECK: addpl   x23, x8, #-19 // encoding: [0xb7,0x55,0x68,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0x57,0x7f,0x04
# CHECK: addpl   sp, sp, #-1 // encoding: [0xff,0x57,0x7f,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0x50,0x60,0x04
# CHECK: addpl   x0, x0, #0 // encoding: [0x00,0x50,0x60,0x04]
# CHECK-ERROR: invalid instruction encoding
