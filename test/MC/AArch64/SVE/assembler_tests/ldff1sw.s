// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldff1sw {z21.d}, p5/z, [x10, z21.d, sxtw #2]  // 11000101-01110101-00110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, sxtw #2] // encoding: [0x55,0x35,0x75,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01110101-00110101-01010101
LDFF1SW {Z21.D}, P5/Z, [X10, Z21.D, SXTW #2]  // 11000101-01110101-00110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, sxtw #2] // encoding: [0x55,0x35,0x75,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01110101-00110101-01010101
ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw]  // 11000101-00000000-00100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x20,0x00,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00000000-00100000-00000000
LDFF1SW {Z0.D}, P0/Z, [X0, Z0.D, UXTW]  // 11000101-00000000-00100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x20,0x00,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00000000-00100000-00000000
ldff1sw {z23.d}, p3/z, [x13, z8.d, uxtw #2]  // 11000101-00101000-00101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, uxtw #2] // encoding: [0xb7,0x2d,0x28,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00101000-00101101-10110111
LDFF1SW {Z23.D}, P3/Z, [X13, Z8.D, UXTW #2]  // 11000101-00101000-00101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, uxtw #2] // encoding: [0xb7,0x2d,0x28,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00101000-00101101-10110111
ldff1sw {z0.d}, p0/z, [x0, x0, lsl #2]  // 10100100-10000000-01100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0x60,0x80,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10000000-01100000-00000000
LDFF1SW {Z0.D}, P0/Z, [X0, X0, LSL #2]  // 10100100-10000000-01100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0x60,0x80,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10000000-01100000-00000000
ldff1sw {z23.d}, p3/z, [z13.d, #32]  // 11000101-00101000-10101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [z13.d, #32] // encoding: [0xb7,0xad,0x28,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00101000-10101101-10110111
LDFF1SW {Z23.D}, P3/Z, [Z13.D, #32]  // 11000101-00101000-10101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [z13.d, #32] // encoding: [0xb7,0xad,0x28,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00101000-10101101-10110111
ldff1sw {z0.d}, p0/z, [z0.d]  // 11000101-00100000-10100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xa0,0x20,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00100000-10100000-00000000
LDFF1SW {Z0.D}, P0/Z, [Z0.D]  // 11000101-00100000-10100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xa0,0x20,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00100000-10100000-00000000
ldff1sw {z31.d}, p7/z, [sp, z31.d, sxtw]  // 11000101-01011111-00111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, sxtw] // encoding: [0xff,0x3f,0x5f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01011111-00111111-11111111
LDFF1SW {Z31.D}, P7/Z, [SP, Z31.D, SXTW]  // 11000101-01011111-00111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, sxtw] // encoding: [0xff,0x3f,0x5f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01011111-00111111-11111111
ldff1sw {z23.d}, p3/z, [x13, z8.d, uxtw]  // 11000101-00001000-00101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x2d,0x08,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00001000-00101101-10110111
LDFF1SW {Z23.D}, P3/Z, [X13, Z8.D, UXTW]  // 11000101-00001000-00101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x2d,0x08,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00001000-00101101-10110111
ldff1sw {z31.d}, p7/z, [z31.d, #124]  // 11000101-00111111-10111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [z31.d, #124] // encoding: [0xff,0xbf,0x3f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00111111-10111111-11111111
LDFF1SW {Z31.D}, P7/Z, [Z31.D, #124]  // 11000101-00111111-10111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [z31.d, #124] // encoding: [0xff,0xbf,0x3f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00111111-10111111-11111111
ldff1sw {z21.d}, p5/z, [x10, z21.d, uxtw]  // 11000101-00010101-00110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x35,0x15,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00010101-00110101-01010101
LDFF1SW {Z21.D}, P5/Z, [X10, Z21.D, UXTW]  // 11000101-00010101-00110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x35,0x15,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00010101-00110101-01010101
ldff1sw {z31.d}, p7/z, [sp]  // 10100100-10011111-01111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp] // encoding: [0xff,0x7f,0x9f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10011111-01111111-11111111
LDFF1SW {Z31.D}, P7/Z, [SP]  // 10100100-10011111-01111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp] // encoding: [0xff,0x7f,0x9f,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10011111-01111111-11111111
ldff1sw {z23.d}, p3/z, [x13, z8.d, sxtw]  // 11000101-01001000-00101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, sxtw] // encoding: [0xb7,0x2d,0x48,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01001000-00101101-10110111
LDFF1SW {Z23.D}, P3/Z, [X13, Z8.D, SXTW]  // 11000101-01001000-00101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, sxtw] // encoding: [0xb7,0x2d,0x48,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01001000-00101101-10110111
ldff1sw {z21.d}, p5/z, [x10, z21.d, uxtw #2]  // 11000101-00110101-00110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, uxtw #2] // encoding: [0x55,0x35,0x35,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00110101-00110101-01010101
LDFF1SW {Z21.D}, P5/Z, [X10, Z21.D, UXTW #2]  // 11000101-00110101-00110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, uxtw #2] // encoding: [0x55,0x35,0x35,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00110101-00110101-01010101
ldff1sw {z23.d}, p3/z, [x13, z8.d]  // 11000101-01001000-10101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xad,0x48,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01001000-10101101-10110111
LDFF1SW {Z23.D}, P3/Z, [X13, Z8.D]  // 11000101-01001000-10101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0xad,0x48,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01001000-10101101-10110111
ldff1sw {z31.d}, p7/z, [sp, z31.d, uxtw #2]  // 11000101-00111111-00111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, uxtw #2] // encoding: [0xff,0x3f,0x3f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00111111-00111111-11111111
LDFF1SW {Z31.D}, P7/Z, [SP, Z31.D, UXTW #2]  // 11000101-00111111-00111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, uxtw #2] // encoding: [0xff,0x3f,0x3f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00111111-00111111-11111111
ldff1sw {z0.d}, p0/z, [x0, z0.d, lsl #2]  // 11000101-01100000-10100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, lsl #2] // encoding: [0x00,0xa0,0x60,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01100000-10100000-00000000
LDFF1SW {Z0.D}, P0/Z, [X0, Z0.D, LSL #2]  // 11000101-01100000-10100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, lsl #2] // encoding: [0x00,0xa0,0x60,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01100000-10100000-00000000
ldff1sw {z21.d}, p5/z, [x10, z21.d, lsl #2]  // 11000101-01110101-10110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, lsl #2] // encoding: [0x55,0xb5,0x75,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01110101-10110101-01010101
LDFF1SW {Z21.D}, P5/Z, [X10, Z21.D, LSL #2]  // 11000101-01110101-10110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, lsl #2] // encoding: [0x55,0xb5,0x75,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01110101-10110101-01010101
ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw #2]  // 11000101-01100000-00100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw #2] // encoding: [0x00,0x20,0x60,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01100000-00100000-00000000
LDFF1SW {Z0.D}, P0/Z, [X0, Z0.D, SXTW #2]  // 11000101-01100000-00100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw #2] // encoding: [0x00,0x20,0x60,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01100000-00100000-00000000
ldff1sw {z23.d}, p3/z, [x13, x8, lsl #2]  // 10100100-10001000-01101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0x6d,0x88,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10001000-01101101-10110111
LDFF1SW {Z23.D}, P3/Z, [X13, X8, LSL #2]  // 10100100-10001000-01101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0x6d,0x88,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10001000-01101101-10110111
ldff1sw {z31.d}, p7/z, [sp, z31.d]  // 11000101-01011111-10111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xbf,0x5f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01011111-10111111-11111111
LDFF1SW {Z31.D}, P7/Z, [SP, Z31.D]  // 11000101-01011111-10111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0xbf,0x5f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01011111-10111111-11111111
ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw #2]  // 11000101-00100000-00100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw #2] // encoding: [0x00,0x20,0x20,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00100000-00100000-00000000
LDFF1SW {Z0.D}, P0/Z, [X0, Z0.D, UXTW #2]  // 11000101-00100000-00100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw #2] // encoding: [0x00,0x20,0x20,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00100000-00100000-00000000
ldff1sw {z0.d}, p0/z, [x0, z0.d]  // 11000101-01000000-10100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xa0,0x40,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01000000-10100000-00000000
LDFF1SW {Z0.D}, P0/Z, [X0, Z0.D]  // 11000101-01000000-10100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0xa0,0x40,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01000000-10100000-00000000
ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw]  // 11000101-01000000-00100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw] // encoding: [0x00,0x20,0x40,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01000000-00100000-00000000
LDFF1SW {Z0.D}, P0/Z, [X0, Z0.D, SXTW]  // 11000101-01000000-00100000-00000000
// CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw] // encoding: [0x00,0x20,0x40,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01000000-00100000-00000000
ldff1sw {z21.d}, p5/z, [x10, x21, lsl #2]  // 10100100-10010101-01110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0x75,0x95,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10010101-01110101-01010101
LDFF1SW {Z21.D}, P5/Z, [X10, X21, LSL #2]  // 10100100-10010101-01110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0x75,0x95,0xa4]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10100100-10010101-01110101-01010101
ldff1sw {z31.d}, p7/z, [sp, z31.d, uxtw]  // 11000101-00011111-00111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x3f,0x1f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00011111-00111111-11111111
LDFF1SW {Z31.D}, P7/Z, [SP, Z31.D, UXTW]  // 11000101-00011111-00111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x3f,0x1f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00011111-00111111-11111111
ldff1sw {z31.d}, p7/z, [sp, z31.d, lsl #2]  // 11000101-01111111-10111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, lsl #2] // encoding: [0xff,0xbf,0x7f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01111111-10111111-11111111
LDFF1SW {Z31.D}, P7/Z, [SP, Z31.D, LSL #2]  // 11000101-01111111-10111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, lsl #2] // encoding: [0xff,0xbf,0x7f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01111111-10111111-11111111
ldff1sw {z31.d}, p7/z, [sp, z31.d, sxtw #2]  // 11000101-01111111-00111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, sxtw #2] // encoding: [0xff,0x3f,0x7f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01111111-00111111-11111111
LDFF1SW {Z31.D}, P7/Z, [SP, Z31.D, SXTW #2]  // 11000101-01111111-00111111-11111111
// CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, sxtw #2] // encoding: [0xff,0x3f,0x7f,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01111111-00111111-11111111
ldff1sw {z21.d}, p5/z, [x10, z21.d, sxtw]  // 11000101-01010101-00110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, sxtw] // encoding: [0x55,0x35,0x55,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01010101-00110101-01010101
LDFF1SW {Z21.D}, P5/Z, [X10, Z21.D, SXTW]  // 11000101-01010101-00110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, sxtw] // encoding: [0x55,0x35,0x55,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01010101-00110101-01010101
ldff1sw {z21.d}, p5/z, [z10.d, #84]  // 11000101-00110101-10110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [z10.d, #84] // encoding: [0x55,0xb5,0x35,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00110101-10110101-01010101
LDFF1SW {Z21.D}, P5/Z, [Z10.D, #84]  // 11000101-00110101-10110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [z10.d, #84] // encoding: [0x55,0xb5,0x35,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-00110101-10110101-01010101
ldff1sw {z23.d}, p3/z, [x13, z8.d, sxtw #2]  // 11000101-01101000-00101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, sxtw #2] // encoding: [0xb7,0x2d,0x68,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01101000-00101101-10110111
LDFF1SW {Z23.D}, P3/Z, [X13, Z8.D, SXTW #2]  // 11000101-01101000-00101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, sxtw #2] // encoding: [0xb7,0x2d,0x68,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01101000-00101101-10110111
ldff1sw {z21.d}, p5/z, [x10, z21.d]  // 11000101-01010101-10110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xb5,0x55,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01010101-10110101-01010101
LDFF1SW {Z21.D}, P5/Z, [X10, Z21.D]  // 11000101-01010101-10110101-01010101
// CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0xb5,0x55,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01010101-10110101-01010101
ldff1sw {z23.d}, p3/z, [x13, z8.d, lsl #2]  // 11000101-01101000-10101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, lsl #2] // encoding: [0xb7,0xad,0x68,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01101000-10101101-10110111
LDFF1SW {Z23.D}, P3/Z, [X13, Z8.D, LSL #2]  // 11000101-01101000-10101101-10110111
// CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, lsl #2] // encoding: [0xb7,0xad,0x68,0xc5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11000101-01101000-10101101-10110111
