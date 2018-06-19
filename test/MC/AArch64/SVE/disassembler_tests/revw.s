# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0xe6,0x05
# CHECK: revw    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe6,0x05]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x8d,0xe6,0x05
# CHECK: revw    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe6,0x05]
# CHECK-ERROR: invalid instruction encoding
0x55,0x95,0xe6,0x05
# CHECK: revw    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe6,0x05]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0xe6,0x05
# CHECK: revw    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe6,0x05]
# CHECK-ERROR: invalid instruction encoding
