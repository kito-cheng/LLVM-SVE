// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fmov    z31.h, #-1.9375  // 00100101-01111001-11011111-11111111
// CHECK: fmov    z31.h, #-1.9375{{0*}} // encoding: [0xff,0xdf,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11011111-11111111
FMOV    Z31.H, #-1.9375  // 00100101-01111001-11011111-11111111
// CHECK: fmov    z31.h, #-1.9375{{0*}} // encoding: [0xff,0xdf,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11011111-11111111
fmov    z31.d, p15/m, #0.0  // 00000101-11011111-01000000-00011111
// CHECK: mov     z31.d, p15/m, #0 // encoding: [0x1f,0x40,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01000000-00011111
FMOV    Z31.D, P15/M, #0.0  // 00000101-11011111-01000000-00011111
// CHECK: mov     z31.d, p15/m, #0 // encoding: [0x1f,0x40,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-01000000-00011111
fmov    z23.s, p8/m, #0.0  // 00000101-10011000-01000000-00010111
// CHECK: mov     z23.s, p8/m, #0 // encoding: [0x17,0x40,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01000000-00010111
FMOV    Z23.S, P8/M, #0.0  // 00000101-10011000-01000000-00010111
// CHECK: mov     z23.s, p8/m, #0 // encoding: [0x17,0x40,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-01000000-00010111
fmov    z21.s, #-13.0  // 00100101-10111001-11010101-01010101
// CHECK: fmov    z21.s, #-13.0{{0*}} // encoding: [0x55,0xd5,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11010101-01010101
FMOV    Z21.S, #-13.0  // 00100101-10111001-11010101-01010101
// CHECK: fmov    z21.s, #-13.0{{0*}} // encoding: [0x55,0xd5,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11010101-01010101
fmov    z21.h, p5/m, #-13.0  // 00000101-01010101-11010101-01010101
// CHECK: fmov    z21.h, p5/m, #-13.0{{0*}} // encoding: [0x55,0xd5,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-11010101-01010101
FMOV    Z21.H, P5/M, #-13.0  // 00000101-01010101-11010101-01010101
// CHECK: fmov    z21.h, p5/m, #-13.0{{0*}} // encoding: [0x55,0xd5,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-11010101-01010101
fmov    z21.s, p5/m, #-13.0  // 00000101-10010101-11010101-01010101
// CHECK: fmov    z21.s, p5/m, #-13.0{{0*}} // encoding: [0x55,0xd5,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-11010101-01010101
FMOV    Z21.S, P5/M, #-13.0  // 00000101-10010101-11010101-01010101
// CHECK: fmov    z21.s, p5/m, #-13.0{{0*}} // encoding: [0x55,0xd5,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-11010101-01010101
fmov    z23.s, #0.90625  // 00100101-10111001-11001101-10110111
// CHECK: fmov    z23.s, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11001101-10110111
FMOV    Z23.S, #0.90625  // 00100101-10111001-11001101-10110111
// CHECK: fmov    z23.s, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11001101-10110111
fmov    z21.h, #0.0  // 00100101-01111000-11000000-00010101
// CHECK: mov     z21.h, #0 // encoding: [0x15,0xc0,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11000000-00010101
FMOV    Z21.H, #0.0  // 00100101-01111000-11000000-00010101
// CHECK: mov     z21.h, #0 // encoding: [0x15,0xc0,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11000000-00010101
fmov    z23.d, p8/m, #0.90625  // 00000101-11011000-11001101-10110111
// CHECK: fmov    z23.d, p8/m, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-11001101-10110111
FMOV    Z23.D, P8/M, #0.90625  // 00000101-11011000-11001101-10110111
// CHECK: fmov    z23.d, p8/m, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-11001101-10110111
fmov    z0.d, #2.0  // 00100101-11111001-11000000-00000000
// CHECK: fmov    z0.d, #2.0{{0*}} // encoding: [0x00,0xc0,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11000000-00000000
FMOV    Z0.D, #2.0  // 00100101-11111001-11000000-00000000
// CHECK: fmov    z0.d, #2.0{{0*}} // encoding: [0x00,0xc0,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11000000-00000000
fmov    z21.d, p5/m, #-13.0  // 00000101-11010101-11010101-01010101
// CHECK: fmov    z21.d, p5/m, #-13.0{{0*}} // encoding: [0x55,0xd5,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-11010101-01010101
FMOV    Z21.D, P5/M, #-13.0  // 00000101-11010101-11010101-01010101
// CHECK: fmov    z21.d, p5/m, #-13.0{{0*}} // encoding: [0x55,0xd5,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-11010101-01010101
fmov    z23.h, p8/m, #0.90625  // 00000101-01011000-11001101-10110111
// CHECK: fmov    z23.h, p8/m, #0.90625{{0*}} // encoding: [0xb7,0xcd,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-11001101-10110111
FMOV    Z23.H, P8/M, #0.90625  // 00000101-01011000-11001101-10110111
// CHECK: fmov    z23.h, p8/m, #0.90625{{0*}} // encoding: [0xb7,0xcd,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-11001101-10110111
fmov    z21.s, #0.0  // 00100101-10111000-11000000-00010101
// CHECK: mov     z21.s, #0 // encoding: [0x15,0xc0,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11000000-00010101
FMOV    Z21.S, #0.0  // 00100101-10111000-11000000-00010101
// CHECK: mov     z21.s, #0 // encoding: [0x15,0xc0,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11000000-00010101
fmov    z23.d, #0.0  // 00100101-11111000-11000000-00010111
// CHECK: mov     z23.d, #0 // encoding: [0x17,0xc0,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11000000-00010111
FMOV    Z23.D, #0.0  // 00100101-11111000-11000000-00010111
// CHECK: mov     z23.d, #0 // encoding: [0x17,0xc0,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11000000-00010111
fmov    z31.h, #0.0  // 00100101-01111000-11000000-00011111
// CHECK: mov     z31.h, #0 // encoding: [0x1f,0xc0,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11000000-00011111
FMOV    Z31.H, #0.0  // 00100101-01111000-11000000-00011111
// CHECK: mov     z31.h, #0 // encoding: [0x1f,0xc0,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11000000-00011111
fmov    z23.d, p8/m, #0.0  // 00000101-11011000-01000000-00010111
// CHECK: mov     z23.d, p8/m, #0 // encoding: [0x17,0x40,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01000000-00010111
FMOV    Z23.D, P8/M, #0.0  // 00000101-11011000-01000000-00010111
// CHECK: mov     z23.d, p8/m, #0 // encoding: [0x17,0x40,0xd8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011000-01000000-00010111
fmov    z23.h, p8/m, #0.0  // 00000101-01011000-01000000-00010111
// CHECK: mov     z23.h, p8/m, #0 // encoding: [0x17,0x40,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01000000-00010111
FMOV    Z23.H, P8/M, #0.0  // 00000101-01011000-01000000-00010111
// CHECK: mov     z23.h, p8/m, #0 // encoding: [0x17,0x40,0x58,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011000-01000000-00010111
fmov    z0.h, p0/m, #2.0  // 00000101-01010000-11000000-00000000
// CHECK: fmov    z0.h, p0/m, #2.0{{0*}} // encoding: [0x00,0xc0,0x50,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010000-11000000-00000000
FMOV    Z0.H, P0/M, #2.0  // 00000101-01010000-11000000-00000000
// CHECK: fmov    z0.h, p0/m, #2.0{{0*}} // encoding: [0x00,0xc0,0x50,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010000-11000000-00000000
fmov    z31.s, p15/m, #-1.9375  // 00000101-10011111-11011111-11111111
// CHECK: fmov    z31.s, p15/m, #-1.9375{{0*}} // encoding: [0xff,0xdf,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-11011111-11111111
FMOV    Z31.S, P15/M, #-1.9375  // 00000101-10011111-11011111-11111111
// CHECK: fmov    z31.s, p15/m, #-1.9375{{0*}} // encoding: [0xff,0xdf,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-11011111-11111111
fmov    z31.s, #0.0  // 00100101-10111000-11000000-00011111
// CHECK: mov     z31.s, #0 // encoding: [0x1f,0xc0,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11000000-00011111
FMOV    Z31.S, #0.0  // 00100101-10111000-11000000-00011111
// CHECK: mov     z31.s, #0 // encoding: [0x1f,0xc0,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11000000-00011111
fmov    z0.s, p0/m, #2.0  // 00000101-10010000-11000000-00000000
// CHECK: fmov    z0.s, p0/m, #2.0{{0*}} // encoding: [0x00,0xc0,0x90,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010000-11000000-00000000
FMOV    Z0.S, P0/M, #2.0  // 00000101-10010000-11000000-00000000
// CHECK: fmov    z0.s, p0/m, #2.0{{0*}} // encoding: [0x00,0xc0,0x90,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010000-11000000-00000000
fmov    z23.d, #0.90625  // 00100101-11111001-11001101-10110111
// CHECK: fmov    z23.d, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11001101-10110111
FMOV    Z23.D, #0.90625  // 00100101-11111001-11001101-10110111
// CHECK: fmov    z23.d, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11001101-10110111
fmov    z31.h, p15/m, #0.0  // 00000101-01011111-01000000-00011111
// CHECK: mov     z31.h, p15/m, #0 // encoding: [0x1f,0x40,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01000000-00011111
FMOV    Z31.H, P15/M, #0.0  // 00000101-01011111-01000000-00011111
// CHECK: mov     z31.h, p15/m, #0 // encoding: [0x1f,0x40,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-01000000-00011111
fmov    z21.d, p5/m, #0.0  // 00000101-11010101-01000000-00010101
// CHECK: mov     z21.d, p5/m, #0 // encoding: [0x15,0x40,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-01000000-00010101
FMOV    Z21.D, P5/M, #0.0  // 00000101-11010101-01000000-00010101
// CHECK: mov     z21.d, p5/m, #0 // encoding: [0x15,0x40,0xd5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010101-01000000-00010101
fmov    z31.d, #0.0  // 00100101-11111000-11000000-00011111
// CHECK: mov     z31.d, #0 // encoding: [0x1f,0xc0,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11000000-00011111
FMOV    Z31.D, #0.0  // 00100101-11111000-11000000-00011111
// CHECK: mov     z31.d, #0 // encoding: [0x1f,0xc0,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11000000-00011111
fmov    z21.d, #-13.0  // 00100101-11111001-11010101-01010101
// CHECK: fmov    z21.d, #-13.0{{0*}} // encoding: [0x55,0xd5,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11010101-01010101
FMOV    Z21.D, #-13.0  // 00100101-11111001-11010101-01010101
// CHECK: fmov    z21.d, #-13.0{{0*}} // encoding: [0x55,0xd5,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11010101-01010101
fmov    z31.d, #-1.9375  // 00100101-11111001-11011111-11111111
// CHECK: fmov    z31.d, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11011111-11111111
FMOV    Z31.D, #-1.9375  // 00100101-11111001-11011111-11111111
// CHECK: fmov    z31.d, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xf9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111001-11011111-11111111
fmov    z23.h, #0.0  // 00100101-01111000-11000000-00010111
// CHECK: mov     z23.h, #0 // encoding: [0x17,0xc0,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11000000-00010111
FMOV    Z23.H, #0.0  // 00100101-01111000-11000000-00010111
// CHECK: mov     z23.h, #0 // encoding: [0x17,0xc0,0x78,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111000-11000000-00010111
fmov    z0.h, #2.0  // 00100101-01111001-11000000-00000000
// CHECK: fmov    z0.h, #2.0{{0*}} // encoding: [0x00,0xc0,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11000000-00000000
FMOV    Z0.H, #2.0  // 00100101-01111001-11000000-00000000
// CHECK: fmov    z0.h, #2.0{{0*}} // encoding: [0x00,0xc0,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11000000-00000000
fmov    z23.s, p8/m, #0.90625  // 00000101-10011000-11001101-10110111
// CHECK: fmov    z23.s, p8/m, #0.90625{{0*}} // encoding: [0xb7,0xcd,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-11001101-10110111
FMOV    Z23.S, P8/M, #0.90625  // 00000101-10011000-11001101-10110111
// CHECK: fmov    z23.s, p8/m, #0.90625{{0*}} // encoding: [0xb7,0xcd,0x98,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011000-11001101-10110111
fmov    z31.s, #-1.9375  // 00100101-10111001-11011111-11111111
// CHECK: fmov    z31.s, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11011111-11111111
FMOV    Z31.S, #-1.9375  // 00100101-10111001-11011111-11111111
// CHECK: fmov    z31.s, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11011111-11111111
fmov    z23.h, #0.90625  // 00100101-01111001-11001101-10110111
// CHECK: fmov    z23.h, #0.90625{{0*}} // encoding: [0xb7,0xcd,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11001101-10110111
FMOV    Z23.H, #0.90625  // 00100101-01111001-11001101-10110111
// CHECK: fmov    z23.h, #0.90625{{0*}} // encoding: [0xb7,0xcd,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11001101-10110111
fmov    z21.h, p5/m, #0.0  // 00000101-01010101-01000000-00010101
// CHECK: mov     z21.h, p5/m, #0 // encoding: [0x15,0x40,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-01000000-00010101
FMOV    Z21.H, P5/M, #0.0  // 00000101-01010101-01000000-00010101
// CHECK: mov     z21.h, p5/m, #0 // encoding: [0x15,0x40,0x55,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01010101-01000000-00010101
fmov    z23.s, #0.0  // 00100101-10111000-11000000-00010111
// CHECK: mov     z23.s, #0 // encoding: [0x17,0xc0,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11000000-00010111
FMOV    Z23.S, #0.0  // 00100101-10111000-11000000-00010111
// CHECK: mov     z23.s, #0 // encoding: [0x17,0xc0,0xb8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111000-11000000-00010111
fmov    z31.d, p15/m, #-1.9375  // 00000101-11011111-11011111-11111111
// CHECK: fmov    z31.d, p15/m, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-11011111-11111111
FMOV    Z31.D, P15/M, #-1.9375  // 00000101-11011111-11011111-11111111
// CHECK: fmov    z31.d, p15/m, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xdf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11011111-11011111-11111111
fmov    z21.d, #0.0  // 00100101-11111000-11000000-00010101
// CHECK: mov     z21.d, #0 // encoding: [0x15,0xc0,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11000000-00010101
FMOV    Z21.D, #0.0  // 00100101-11111000-11000000-00010101
// CHECK: mov     z21.d, #0 // encoding: [0x15,0xc0,0xf8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111000-11000000-00010101
fmov    z21.h, #-13.0  // 00100101-01111001-11010101-01010101
// CHECK: fmov    z21.h, #-13.0{{0*}} // encoding: [0x55,0xd5,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11010101-01010101
FMOV    Z21.H, #-13.0  // 00100101-01111001-11010101-01010101
// CHECK: fmov    z21.h, #-13.0{{0*}} // encoding: [0x55,0xd5,0x79,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-01111001-11010101-01010101
fmov    z31.s, p15/m, #0.0  // 00000101-10011111-01000000-00011111
// CHECK: mov     z31.s, p15/m, #0 // encoding: [0x1f,0x40,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01000000-00011111
FMOV    Z31.S, P15/M, #0.0  // 00000101-10011111-01000000-00011111
// CHECK: mov     z31.s, p15/m, #0 // encoding: [0x1f,0x40,0x9f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10011111-01000000-00011111
fmov    z21.s, p5/m, #0.0  // 00000101-10010101-01000000-00010101
// CHECK: mov     z21.s, p5/m, #0 // encoding: [0x15,0x40,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-01000000-00010101
FMOV    Z21.S, P5/M, #0.0  // 00000101-10010101-01000000-00010101
// CHECK: mov     z21.s, p5/m, #0 // encoding: [0x15,0x40,0x95,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10010101-01000000-00010101
fmov    z31.h, p15/m, #-1.9375  // 00000101-01011111-11011111-11111111
// CHECK: fmov    z31.h, p15/m, #-1.9375{{0*}} // encoding: [0xff,0xdf,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-11011111-11111111
FMOV    Z31.H, P15/M, #-1.9375  // 00000101-01011111-11011111-11111111
// CHECK: fmov    z31.h, p15/m, #-1.9375{{0*}} // encoding: [0xff,0xdf,0x5f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01011111-11011111-11111111
fmov    z0.s, #2.0  // 00100101-10111001-11000000-00000000
// CHECK: fmov    z0.s, #2.0{{0*}} // encoding: [0x00,0xc0,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11000000-00000000
FMOV    Z0.S, #2.0  // 00100101-10111001-11000000-00000000
// CHECK: fmov    z0.s, #2.0{{0*}} // encoding: [0x00,0xc0,0xb9,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111001-11000000-00000000
fmov    z0.d, p0/m, #2.0  // 00000101-11010000-11000000-00000000
// CHECK: fmov    z0.d, p0/m, #2.0{{0*}} // encoding: [0x00,0xc0,0xd0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010000-11000000-00000000
FMOV    Z0.D, P0/M, #2.0  // 00000101-11010000-11000000-00000000
// CHECK: fmov    z0.d, p0/m, #2.0{{0*}} // encoding: [0x00,0xc0,0xd0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11010000-11000000-00000000
