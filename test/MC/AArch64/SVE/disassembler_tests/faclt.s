# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0x55,0x65
# CHECK: facgt   p5.h, p5/z, z10.h, z21.h // encoding: [0x55,0xf5,0x55,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0x48,0x65
# CHECK: facgt   p7.h, p3/z, z13.h, z8.h // encoding: [0xb7,0xed,0x48,0x65]
# CHECK-ERROR: invalid instruction encoding
0x10,0xe0,0x40,0x65
# CHECK: facgt   p0.h, p0/z, z0.h, z0.h // encoding: [0x10,0xe0,0x40,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0xd5,0x65
# CHECK: facgt   p5.d, p5/z, z10.d, z21.d // encoding: [0x55,0xf5,0xd5,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0x88,0x65
# CHECK: facgt   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0xed,0x88,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0x9f,0x65
# CHECK: facgt   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0xff,0x9f,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0x5f,0x65
# CHECK: facgt   p15.h, p7/z, z31.h, z31.h // encoding: [0xff,0xff,0x5f,0x65]
# CHECK-ERROR: invalid instruction encoding
0x10,0xe0,0xc0,0x65
# CHECK: facgt   p0.d, p0/z, z0.d, z0.d // encoding: [0x10,0xe0,0xc0,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0xc8,0x65
# CHECK: facgt   p7.d, p3/z, z13.d, z8.d // encoding: [0xb7,0xed,0xc8,0x65]
# CHECK-ERROR: invalid instruction encoding
0x10,0xe0,0x80,0x65
# CHECK: facgt   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0xe0,0x80,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0xdf,0x65
# CHECK: facgt   p15.d, p7/z, z31.d, z31.d // encoding: [0xff,0xff,0xdf,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0x95,0x65
# CHECK: facgt   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0xf5,0x95,0x65]
# CHECK-ERROR: invalid instruction encoding
