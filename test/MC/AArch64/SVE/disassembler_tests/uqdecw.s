# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xfd,0xa5,0x04
# CHECK: uqdecw  w21, vl32, mul #6 // encoding: [0x55,0xfd,0xa5,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xfd,0xa8,0x04
# CHECK: uqdecw  w23, vl256, mul #9 // encoding: [0xb7,0xfd,0xa8,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xcc,0xa0,0x04
# CHECK: uqdecw  z0.s, pow2 // encoding: [0x00,0xcc,0xa0,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xfd,0xb8,0x04
# CHECK: uqdecw  x23, vl256, mul #9 // encoding: [0xb7,0xfd,0xb8,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0xfd,0xb5,0x04
# CHECK: uqdecw  x21, vl32, mul #6 // encoding: [0x55,0xfd,0xb5,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xfc,0xa0,0x04
# CHECK: uqdecw  w0, pow2 // encoding: [0x00,0xfc,0xa0,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xcf,0xaf,0x04
# CHECK: uqdecw  z31.s, all, mul #16 // encoding: [0xff,0xcf,0xaf,0x04]
# CHECK-ERROR: invalid instruction encoding
0x00,0xfc,0xb0,0x04
# CHECK: uqdecw  x0, pow2 // encoding: [0x00,0xfc,0xb0,0x04]
# CHECK-ERROR: invalid instruction encoding
0xb7,0xcd,0xa8,0x04
# CHECK: uqdecw  z23.s, vl256, mul #9 // encoding: [0xb7,0xcd,0xa8,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0xaf,0x04
# CHECK: uqdecw  wzr, all, mul #16 // encoding: [0xff,0xff,0xaf,0x04]
# CHECK-ERROR: invalid instruction encoding
0xff,0xff,0xbf,0x04
# CHECK: uqdecw  xzr, all, mul #16 // encoding: [0xff,0xff,0xbf,0x04]
# CHECK-ERROR: invalid instruction encoding
0x55,0xcd,0xa5,0x04
# CHECK: uqdecw  z21.s, vl32, mul #6 // encoding: [0x55,0xcd,0xa5,0x04]
# CHECK-ERROR: invalid instruction encoding
