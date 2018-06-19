// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fdup    z31.h, #-1.9375  // 00100101-01111001-11011111-11111111
// CHECK: fmov    z31.h, #-1.9375{{0*}} // encoding: [0xff,0xdf,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11011111-11111111
FDUP    Z31.H, #-1.9375  // 00100101-01111001-11011111-11111111
// CHECK: fmov    z31.h, #-1.9375{{0*}} // encoding: [0xff,0xdf,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11011111-11111111
fdup    z21.s, #-13.0  // 00100101-10111001-11010101-01010101
// CHECK: fmov    z21.s, #-13.0{{0*}} // encoding: [0x55,0xd5,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11010101-01010101
FDUP    Z21.S, #-13.0  // 00100101-10111001-11010101-01010101
// CHECK: fmov    z21.s, #-13.0{{0*}} // encoding: [0x55,0xd5,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11010101-01010101
fdup    z23.s, #0.90625  // 00100101-10111001-11001101-10110111
// CHECK: fmov    z23.s, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11001101-10110111
FDUP    Z23.S, #0.90625  // 00100101-10111001-11001101-10110111
// CHECK: fmov    z23.s, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11001101-10110111
fdup    z0.d, #2.0  // 00100101-11111001-11000000-00000000
// CHECK: fmov    z0.d, #2.0{{0*}} // encoding: [0x00,0xc0,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11000000-00000000
FDUP    Z0.D, #2.0  // 00100101-11111001-11000000-00000000
// CHECK: fmov    z0.d, #2.0{{0*}} // encoding: [0x00,0xc0,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11000000-00000000
fdup    z23.d, #0.90625  // 00100101-11111001-11001101-10110111
// CHECK: fmov    z23.d, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11001101-10110111
FDUP    Z23.D, #0.90625  // 00100101-11111001-11001101-10110111
// CHECK: fmov    z23.d, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11001101-10110111
fdup    z21.d, #-13.0  // 00100101-11111001-11010101-01010101
// CHECK: fmov    z21.d, #-13.0{{0*}} // encoding: [0x55,0xd5,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11010101-01010101
FDUP    Z21.D, #-13.0  // 00100101-11111001-11010101-01010101
// CHECK: fmov    z21.d, #-13.0{{0*}} // encoding: [0x55,0xd5,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11010101-01010101
fdup    z31.d, #-1.9375  // 00100101-11111001-11011111-11111111
// CHECK: fmov    z31.d, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11011111-11111111
FDUP    Z31.D, #-1.9375  // 00100101-11111001-11011111-11111111
// CHECK: fmov    z31.d, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11011111-11111111
fdup    z0.h, #2.0  // 00100101-01111001-11000000-00000000
// CHECK: fmov    z0.h, #2.0{{0*}} // encoding: [0x00,0xc0,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11000000-00000000
FDUP    Z0.H, #2.0  // 00100101-01111001-11000000-00000000
// CHECK: fmov    z0.h, #2.0{{0*}} // encoding: [0x00,0xc0,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11000000-00000000
fdup    z31.s, #-1.9375  // 00100101-10111001-11011111-11111111
// CHECK: fmov    z31.s, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11011111-11111111
FDUP    Z31.S, #-1.9375  // 00100101-10111001-11011111-11111111
// CHECK: fmov    z31.s, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11011111-11111111
fdup    z23.h, #0.90625  // 00100101-01111001-11001101-10110111
// CHECK: fmov    z23.h, #0.90625{{0*}} // encoding: [0xb7,0xcd,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11001101-10110111
FDUP    Z23.H, #0.90625  // 00100101-01111001-11001101-10110111
// CHECK: fmov    z23.h, #0.90625{{0*}} // encoding: [0xb7,0xcd,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11001101-10110111
fdup    z21.h, #-13.0  // 00100101-01111001-11010101-01010101
// CHECK: fmov    z21.h, #-13.0{{0*}} // encoding: [0x55,0xd5,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11010101-01010101
FDUP    Z21.H, #-13.0  // 00100101-01111001-11010101-01010101
// CHECK: fmov    z21.h, #-13.0{{0*}} // encoding: [0x55,0xd5,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11010101-01010101
fdup    z0.s, #2.0  // 00100101-10111001-11000000-00000000
// CHECK: fmov    z0.s, #2.0{{0*}} // encoding: [0x00,0xc0,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11000000-00000000
FDUP    Z0.S, #2.0  // 00100101-10111001-11000000-00000000
// CHECK: fmov    z0.s, #2.0{{0*}} // encoding: [0x00,0xc0,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11000000-00000000
