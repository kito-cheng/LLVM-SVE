# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x00,0x20,0x05
# CHECK: ext     z0.b, z0.b, z0.b, #0 // encoding: [0x00,0x00,0x20,0x05]
# CHECK-ERROR: invalid instruction encoding
0xff,0x1f,0x3f,0x05
# CHECK: ext     z31.b, z31.b, z31.b, #255 // encoding: [0xff,0x1f,0x3f,0x05]
# CHECK-ERROR: invalid instruction encoding
0x55,0x15,0x35,0x05
# CHECK: ext     z21.b, z21.b, z10.b, #173 // encoding: [0x55,0x15,0x35,0x05]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x0d,0x28,0x05
# CHECK: ext     z23.b, z23.b, z13.b, #67 // encoding: [0xb7,0x0d,0x28,0x05]
# CHECK-ERROR: invalid instruction encoding
