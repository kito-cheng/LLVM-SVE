# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x3f,0x9c,0x9a,0x65
# CHECK: fmul    z31.s, p7/m, z31.s, #2.0{{0*}} // encoding: [0x3f,0x9c,0x9a,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0xc2,0x65
# CHECK: fmul    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xc2,0x65]
# CHECK-ERROR: invalid instruction encoding
0x3f,0x9c,0x5a,0x65
# CHECK: fmul    z31.h, p7/m, z31.h, #2.0{{0*}} // encoding: [0x3f,0x9c,0x5a,0x65]
# CHECK-ERROR: invalid instruction encoding
0x15,0x94,0x9a,0x65
# CHECK: fmul    z21.s, p5/m, z21.s, #0.5{{0*}} // encoding: [0x15,0x94,0x9a,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x8d,0x42,0x65
# CHECK: fmul    z23.h, p3/m, z23.h, z13.h // encoding: [0xb7,0x8d,0x42,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0x5a,0x65
# CHECK: fmul    z0.h, p0/m, z0.h, #0.5{{0*}} // encoding: [0x00,0x80,0x5a,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0x09,0x95,0x65
# CHECK: fmul    z21.s, z10.s, z21.s // encoding: [0x55,0x09,0x95,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0xda,0x65
# CHECK: fmul    z0.d, p0/m, z0.d, #0.5{{0*}} // encoding: [0x00,0x80,0xda,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0x21,0x75,0x64
# CHECK: fmul    z21.h, z10.h, z5.h[6] // encoding: [0x55,0x21,0x75,0x64]
# CHECK-ERROR: invalid instruction encoding
0x00,0x20,0xe0,0x64
# CHECK: fmul    z0.d, z0.d, z0.d[0] // encoding: [0x00,0x20,0xe0,0x64]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0x9a,0x65
# CHECK: fmul    z0.s, p0/m, z0.s, #0.5{{0*}} // encoding: [0x00,0x80,0x9a,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0x9f,0xc2,0x65
# CHECK: fmul    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xc2,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0x0b,0xdf,0x65
# CHECK: fmul    z31.d, z31.d, z31.d // encoding: [0xff,0x0b,0xdf,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0x0b,0x9f,0x65
# CHECK: fmul    z31.s, z31.s, z31.s // encoding: [0xff,0x0b,0x9f,0x65]
# CHECK-ERROR: invalid instruction encoding
0x15,0x94,0x5a,0x65
# CHECK: fmul    z21.h, p5/m, z21.h, #0.5{{0*}} // encoding: [0x15,0x94,0x5a,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0x82,0x65
# CHECK: fmul    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x80,0x82,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0x09,0x55,0x65
# CHECK: fmul    z21.h, z10.h, z21.h // encoding: [0x55,0x09,0x55,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x8d,0xc2,0x65
# CHECK: fmul    z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xc2,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0x9f,0x42,0x65
# CHECK: fmul    z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x9f,0x42,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x09,0x88,0x65
# CHECK: fmul    z23.s, z13.s, z8.s // encoding: [0xb7,0x09,0x88,0x65]
# CHECK-ERROR: invalid instruction encoding
0x3f,0x9c,0xda,0x65
# CHECK: fmul    z31.d, p7/m, z31.d, #2.0{{0*}} // encoding: [0x3f,0x9c,0xda,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0x95,0x42,0x65
# CHECK: fmul    z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0x95,0x42,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x08,0x40,0x65
# CHECK: fmul    z0.h, z0.h, z0.h // encoding: [0x00,0x08,0x40,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0x21,0xb5,0x64
# CHECK: fmul    z21.s, z10.s, z5.s[2] // encoding: [0x55,0x21,0xb5,0x64]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x09,0xc8,0x65
# CHECK: fmul    z23.d, z13.d, z8.d // encoding: [0xb7,0x09,0xc8,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x8d,0x82,0x65
# CHECK: fmul    z23.s, p3/m, z23.s, z13.s // encoding: [0xb7,0x8d,0x82,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x20,0x20,0x64
# CHECK: fmul    z0.h, z0.h, z0.h[0] // encoding: [0x00,0x20,0x20,0x64]
# CHECK-ERROR: invalid instruction encoding
0xff,0x23,0xbf,0x64
# CHECK: fmul    z31.s, z31.s, z7.s[3] // encoding: [0xff,0x23,0xbf,0x64]
# CHECK-ERROR: invalid instruction encoding
0x15,0x94,0xda,0x65
# CHECK: fmul    z21.d, p5/m, z21.d, #0.5{{0*}} // encoding: [0x15,0x94,0xda,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0x9f,0x82,0x65
# CHECK: fmul    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x9f,0x82,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x21,0x68,0x64
# CHECK: fmul    z23.h, z13.h, z0.h[5] // encoding: [0xb7,0x21,0x68,0x64]
# CHECK-ERROR: invalid instruction encoding
0x37,0x8c,0x5a,0x65
# CHECK: fmul    z23.h, p3/m, z23.h, #2.0{{0*}} // encoding: [0x37,0x8c,0x5a,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x09,0x48,0x65
# CHECK: fmul    z23.h, z13.h, z8.h // encoding: [0xb7,0x09,0x48,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0x23,0x7f,0x64
# CHECK: fmul    z31.h, z31.h, z7.h[7] // encoding: [0xff,0x23,0x7f,0x64]
# CHECK-ERROR: invalid instruction encoding
0xff,0x0b,0x5f,0x65
# CHECK: fmul    z31.h, z31.h, z31.h // encoding: [0xff,0x0b,0x5f,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0x23,0xff,0x64
# CHECK: fmul    z31.d, z31.d, z15.d[1] // encoding: [0xff,0x23,0xff,0x64]
# CHECK-ERROR: invalid instruction encoding
0x55,0x21,0xf5,0x64
# CHECK: fmul    z21.d, z10.d, z5.d[1] // encoding: [0x55,0x21,0xf5,0x64]
# CHECK-ERROR: invalid instruction encoding
0x55,0x95,0x82,0x65
# CHECK: fmul    z21.s, p5/m, z21.s, z10.s // encoding: [0x55,0x95,0x82,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x20,0xa0,0x64
# CHECK: fmul    z0.s, z0.s, z0.s[0] // encoding: [0x00,0x20,0xa0,0x64]
# CHECK-ERROR: invalid instruction encoding
0x00,0x08,0x80,0x65
# CHECK: fmul    z0.s, z0.s, z0.s // encoding: [0x00,0x08,0x80,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0x95,0xc2,0x65
# CHECK: fmul    z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xc2,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0x42,0x65
# CHECK: fmul    z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x80,0x42,0x65]
# CHECK-ERROR: invalid instruction encoding
0x37,0x8c,0xda,0x65
# CHECK: fmul    z23.d, p3/m, z23.d, #2.0{{0*}} // encoding: [0x37,0x8c,0xda,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x21,0xe8,0x64
# CHECK: fmul    z23.d, z13.d, z8.d[0] // encoding: [0xb7,0x21,0xe8,0x64]
# CHECK-ERROR: invalid instruction encoding
0x37,0x8c,0x9a,0x65
# CHECK: fmul    z23.s, p3/m, z23.s, #2.0{{0*}} // encoding: [0x37,0x8c,0x9a,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x21,0xa8,0x64
# CHECK: fmul    z23.s, z13.s, z0.s[1] // encoding: [0xb7,0x21,0xa8,0x64]
# CHECK-ERROR: invalid instruction encoding
0x55,0x09,0xd5,0x65
# CHECK: fmul    z21.d, z10.d, z21.d // encoding: [0x55,0x09,0xd5,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x08,0xc0,0x65
# CHECK: fmul    z0.d, z0.d, z0.d // encoding: [0x00,0x08,0xc0,0x65]
# CHECK-ERROR: invalid instruction encoding
