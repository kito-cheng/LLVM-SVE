# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0x90,0x65
# CHECK: ftmad   z0.s, z0.s, z0.s, #0 // encoding: [0x00,0x80,0x90,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0x81,0x55,0x65
# CHECK: ftmad   z21.h, z21.h, z10.h, #5 // encoding: [0x55,0x81,0x55,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x81,0x50,0x65
# CHECK: ftmad   z23.h, z23.h, z13.h, #0 // encoding: [0xb7,0x81,0x50,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0x83,0xd7,0x65
# CHECK: ftmad   z31.d, z31.d, z31.d, #7 // encoding: [0xff,0x83,0xd7,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x81,0x90,0x65
# CHECK: ftmad   z23.s, z23.s, z13.s, #0 // encoding: [0xb7,0x81,0x90,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0x81,0xd5,0x65
# CHECK: ftmad   z21.d, z21.d, z10.d, #5 // encoding: [0x55,0x81,0xd5,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0x50,0x65
# CHECK: ftmad   z0.h, z0.h, z0.h, #0 // encoding: [0x00,0x80,0x50,0x65]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x81,0xd0,0x65
# CHECK: ftmad   z23.d, z23.d, z13.d, #0 // encoding: [0xb7,0x81,0xd0,0x65]
# CHECK-ERROR: invalid instruction encoding
0x00,0x80,0xd0,0x65
# CHECK: ftmad   z0.d, z0.d, z0.d, #0 // encoding: [0x00,0x80,0xd0,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0x83,0x57,0x65
# CHECK: ftmad   z31.h, z31.h, z31.h, #7 // encoding: [0xff,0x83,0x57,0x65]
# CHECK-ERROR: invalid instruction encoding
0xff,0x83,0x97,0x65
# CHECK: ftmad   z31.s, z31.s, z31.s, #7 // encoding: [0xff,0x83,0x97,0x65]
# CHECK-ERROR: invalid instruction encoding
0x55,0x81,0x95,0x65
# CHECK: ftmad   z21.s, z21.s, z10.s, #5 // encoding: [0x55,0x81,0x95,0x65]
# CHECK-ERROR: invalid instruction encoding
