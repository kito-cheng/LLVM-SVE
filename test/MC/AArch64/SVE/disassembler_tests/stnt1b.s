# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0x10,0xe4
# CHECK: stnt1b  {z0.b}, p0, [x0] // encoding: [0x00,0xe0,0x10,0xe4]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0x1f,0xe4
# CHECK: stnt1b  {z31.b}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x1f,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x00,0x60,0x00,0xe4
# CHECK: stnt1b  {z0.b}, p0, [x0, x0] // encoding: [0x00,0x60,0x00,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x25,0x6e,0x10,0xe4
# CHECK: stnt1b  {z5.b}, p3, [x17, x16] // encoding: [0x25,0x6e,0x10,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x55,0x75,0x15,0xe4
# CHECK: stnt1b  {z21.b}, p5, [x10, x21] // encoding: [0x55,0x75,0x15,0xe4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0x6d,0x08,0xe4
# CHECK: stnt1b  {z23.b}, p3, [x13, x8] // encoding: [0xb7,0x6d,0x08,0xe4]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xed,0x18,0xe4
# CHECK: stnt1b  {z23.b}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x18,0xe4]
# CHECK-ERROR: invalid instruction encoding
0x55,0xf5,0x15,0xe4
# CHECK: stnt1b  {z21.b}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x15,0xe4]
# CHECK-ERROR: invalid instruction encoding
