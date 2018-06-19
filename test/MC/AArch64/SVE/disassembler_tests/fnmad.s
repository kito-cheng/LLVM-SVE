# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0xb5,0x65
# CHECK: fnmad   z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0xd5,0xb5,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0xd5,0xf5,0x65
# CHECK: fnmad   z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0xd5,0xf5,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xcd,0xe8,0x65
# CHECK: fnmad   z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0xcd,0xe8,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0xc0,0xa0,0x65
# CHECK: fnmad   z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0xc0,0xa0,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0xdf,0xbf,0x65
# CHECK: fnmad   z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0xdf,0xbf,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0xc0,0x60,0x65
# CHECK: fnmad   z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0xc0,0x60,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xcd,0x68,0x65
# CHECK: fnmad   z23.h, p3/m, z13.h, z8.h // encoding: [0xb7,0xcd,0x68,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0xdf,0x7f,0x65
# CHECK: fnmad   z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0xdf,0x7f,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0xdf,0xff,0x65
# CHECK: fnmad   z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0xdf,0xff,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0xc0,0xe0,0x65
# CHECK: fnmad   z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0xc0,0xe0,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0xd5,0x75,0x65
# CHECK: fnmad   z21.h, p5/m, z10.h, z21.h // encoding: [0x55,0xd5,0x75,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xcd,0xa8,0x65
# CHECK: fnmad   z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0xcd,0xa8,0x65]
# CHECK-ERROR: invalid instruction encoding
