# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x41,0x64
# CHECK: fcadd   z31.h, p7/m, z31.h, z31.h, #270 // encoding: [0xff,0x9f,0x41,0x64]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0x40,0x64
# CHECK: fcadd   z0.h, p0/m, z0.h, z0.h, #90 // encoding: [0x00,0x80,0x40,0x64]
# CHECK-ERROR: invalid instruction encoding
0x55,0x95,0x41,0x64
# CHECK: fcadd   z21.h, p5/m, z21.h, z10.h, #270 // encoding: [0x55,0x95,0x41,0x64]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x8d,0x40,0x64
# CHECK: fcadd   z23.h, p3/m, z23.h, z13.h, #90 // encoding: [0xb7,0x8d,0x40,0x64]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x8d,0xc0,0x64
# CHECK: fcadd   z23.d, p3/m, z23.d, z13.d, #90 // encoding: [0xb7,0x8d,0xc0,0x64]
# CHECK-ERROR: invalid instruction encoding
0xff,0x9f,0x81,0x64
# CHECK: fcadd   z31.s, p7/m, z31.s, z31.s, #270 // encoding: [0xff,0x9f,0x81,0x64]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x8d,0x80,0x64
# CHECK: fcadd   z23.s, p3/m, z23.s, z13.s, #90 // encoding: [0xb7,0x8d,0x80,0x64]
# CHECK-ERROR: invalid instruction encoding
0x55,0x95,0xc1,0x64
# CHECK: fcadd   z21.d, p5/m, z21.d, z10.d, #270 // encoding: [0x55,0x95,0xc1,0x64]
# CHECK-ERROR: invalid instruction encoding
0x55,0x95,0x81,0x64
# CHECK: fcadd   z21.s, p5/m, z21.s, z10.s, #270 // encoding: [0x55,0x95,0x81,0x64]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0xc0,0x64
# CHECK: fcadd   z0.d, p0/m, z0.d, z0.d, #90 // encoding: [0x00,0x80,0xc0,0x64]
# CHECK-ERROR: invalid instruction encoding
0xff,0x9f,0xc1,0x64
# CHECK: fcadd   z31.d, p7/m, z31.d, z31.d, #270 // encoding: [0xff,0x9f,0xc1,0x64]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0x80,0x64
# CHECK: fcadd   z0.s, p0/m, z0.s, z0.s, #90 // encoding: [0x00,0x80,0x80,0x64]
# CHECK-ERROR: invalid instruction encoding
