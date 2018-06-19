# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x0d,0xd4,0x04
# CHECK: sdiv    z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x0d,0xd4,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x0d,0x94,0x04
# CHECK: sdiv    z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x0d,0x94,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0x1f,0x94,0x04
# CHECK: sdiv    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x1f,0x94,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0x15,0x94,0x04
# CHECK: sdiv    z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x15,0x94,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0x1f,0xd4,0x04
# CHECK: sdiv    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x1f,0xd4,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0x15,0xd4,0x04
# CHECK: sdiv    z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x15,0xd4,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0x00,0x94,0x04
# CHECK: sdiv    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x00,0x94,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0x00,0xd4,0x04
# CHECK: sdiv    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x00,0xd4,0x04]
# CHECK-ERROR: invalid instruction encoding
