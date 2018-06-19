// RUN: llvm-mc -triple=aarch64-none-linux-gnu -mattr=+sve -show-encoding < %s | FileCheck %s

// Custom tests for aliases not yet covered by automation.

dupm z20.h, #0xff7f
// CHECK: mov z20.h, #-129            // encoding: [0xd4,0x45,0xc0,0x05]
dupm z21.d, #0xff7fff7fff7fff7f
// CHECK: mov z21.h, #-129            // encoding: [0xd5,0x45,0xc0,0x05]
mov z22.h, #-129
// CHECK: mov z22.h, #-129            // encoding: [0xd6,0x45,0xc0,0x05]
dupm z23.h, #255
// CHECK: mov z23.h, #255             // encoding: [0xf7,0x04,0xc0,0x05]
dupm z24.h, #0x7fff
// CHECK: mov z24.h, #32767           // encoding: [0xd8,0x05,0xc0,0x05]
mov z25.h, #-32768
// CHECK: mov z25.h, #-32768          // encoding: [0x19,0xf0,0x78,0x25]
mov z26.h, #-32767
// CHECK: mov z26.h, #-32767          // encoding: [0x3a,0x0c,0xc0,0x05]
mov z27.s, #-32768
// CHECK: mov z27.s, #-32768          // encoding: [0x1b,0xf0,0xb8,0x25]
mov z28.s, #-32767
// CHECK: mov z28.s, #-32767          // encoding: [0x3c,0x8a,0xc0,0x05]
dupm z29.s, #0xffffff7f
// CHECK: mov z29.s, #-129            // encoding: [0xdd,0xc3,0xc0,0x05]
dupm z30.d, #0xffffff7fffffff7f
// CHECK: mov z30.s, #-129            // encoding: [0xde,0xc3,0xc0,0x05]
mov z31.s, #-32769
// CHECK: mov z31.s, #0xffff7fff      // encoding: [0xdf,0x83,0xc0,0x05]
dupm z0.s, #128
// CHECK: mov z0.s, #128              // encoding: [0x00,0xc8,0xc0,0x05]
mov z0.b, #0xf7
// CHECK: mov z0.b, #-9               // encoding: [0xe0,0xde,0x38,0x25]

// Aliases that make the assembler figure out what shift format is required.
add z0.d, z0.d, #256
// CHECK: add z0.d, z0.d, #256        // encoding: [0x20,0xe0,0xe0,0x25]
add z0.d, z0.d, #256, lsl #0
// CHECK: add z0.d, z0.d, #256        // encoding: [0x20,0xe0,0xe0,0x25]
add z0.d, z0.d, #512
// CHECK: add z0.d, z0.d, #512        // encoding: [0x40,0xe0,0xe0,0x25]
add z0.d, z0.d, #512, lsl #0
// CHECK: add z0.d, z0.d, #512        // encoding: [0x40,0xe0,0xe0,0x25]

// Aliases that show {} destination operand wrapping is optional.
ld1rqb {z0.b}, p1/z, [x2, #16]
// CHECK: ld1rqb {z0.b}, p1/z, [x2, #16] // encoding: [0x40,0x24,0x01,0xa4]
ld1rqb z0.b, p1/z, [x2, #16]
// CHECK: ld1rqb {z0.b}, p1/z, [x2, #16] // encoding: [0x40,0x24,0x01,0xa4]
ld1rqd {z0.d}, p1/z, [x2, x3, lsl #3]
// CHECK: ld1rqd {z0.d}, p1/z, [x2, x3, lsl #3] // encoding: [0x40,0x04,0x83,0xa5]
ld1rqd z0.d, p1/z, [x2, x3, lsl #3]
// CHECK: ld1rqd {z0.d}, p1/z, [x2, x3, lsl #3] // encoding: [0x40,0x04,0x83,0xa5]
