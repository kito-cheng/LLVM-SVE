# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0x40,0x05
# CHECK: eor     z23.h, z23.h, #0xfff9 // encoding: [0xb7,0xed,0x40,0x05]
# CHECK-ERROR: invalid instruction encoding
0x25,0x0e,0x40,0x05
# CHECK: eor     z5.b, z5.b, #0x81 // encoding: [0x25,0x0e,0x40,0x05]
# CHECK-ERROR: invalid instruction encoding
0x55,0x55,0x41,0x05
# CHECK: eor     z21.h, z21.h, #0xffc1 // encoding: [0x55,0x55,0x41,0x05]
# CHECK-ERROR: invalid instruction encoding
0x00,0x00,0x40,0x05
# CHECK: eor     z0.s, z0.s, #0x1 // encoding: [0x00,0x00,0x40,0x05]
# CHECK-ERROR: invalid instruction encoding
