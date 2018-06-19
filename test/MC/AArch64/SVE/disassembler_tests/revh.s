# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0xa5,0x05
# CHECK: revh    z21.s, p5/m, z10.s // encoding: [0x55,0x95,0xa5,0x05]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x8d,0xe5,0x05
# CHECK: revh    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe5,0x05]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0xa5,0x05
# CHECK: revh    z0.s, p0/m, z0.s // encoding: [0x00,0x80,0xa5,0x05]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x8d,0xa5,0x05
# CHECK: revh    z23.s, p3/m, z13.s // encoding: [0xb7,0x8d,0xa5,0x05]
# CHECK-ERROR: invalid instruction encoding
0xff,0x9f,0xa5,0x05
# CHECK: revh    z31.s, p7/m, z31.s // encoding: [0xff,0x9f,0xa5,0x05]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0xe5,0x05
# CHECK: revh    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe5,0x05]
# CHECK-ERROR: invalid instruction encoding
0x55,0x95,0xe5,0x05
# CHECK: revh    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe5,0x05]
# CHECK-ERROR: invalid instruction encoding
0xff,0x9f,0xe5,0x05
# CHECK: revh    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe5,0x05]
# CHECK-ERROR: invalid instruction encoding
