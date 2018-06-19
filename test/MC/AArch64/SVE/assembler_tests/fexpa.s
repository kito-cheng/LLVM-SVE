// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fexpa   z23.d, z13.d  // 00000100-11100000-10111001-10110111
// CHECK: fexpa   z23.d, z13.d // encoding: [0xb7,0xb9,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10111001-10110111
FEXPA   Z23.D, Z13.D  // 00000100-11100000-10111001-10110111
// CHECK: fexpa   z23.d, z13.d // encoding: [0xb7,0xb9,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10111001-10110111
fexpa   z0.d, z0.d  // 00000100-11100000-10111000-00000000
// CHECK: fexpa   z0.d, z0.d // encoding: [0x00,0xb8,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10111000-00000000
FEXPA   Z0.D, Z0.D  // 00000100-11100000-10111000-00000000
// CHECK: fexpa   z0.d, z0.d // encoding: [0x00,0xb8,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10111000-00000000
fexpa   z21.h, z10.h  // 00000100-01100000-10111001-01010101
// CHECK: fexpa   z21.h, z10.h // encoding: [0x55,0xb9,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10111001-01010101
FEXPA   Z21.H, Z10.H  // 00000100-01100000-10111001-01010101
// CHECK: fexpa   z21.h, z10.h // encoding: [0x55,0xb9,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10111001-01010101
fexpa   z23.h, z13.h  // 00000100-01100000-10111001-10110111
// CHECK: fexpa   z23.h, z13.h // encoding: [0xb7,0xb9,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10111001-10110111
FEXPA   Z23.H, Z13.H  // 00000100-01100000-10111001-10110111
// CHECK: fexpa   z23.h, z13.h // encoding: [0xb7,0xb9,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10111001-10110111
fexpa   z0.h, z0.h  // 00000100-01100000-10111000-00000000
// CHECK: fexpa   z0.h, z0.h // encoding: [0x00,0xb8,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10111000-00000000
FEXPA   Z0.H, Z0.H  // 00000100-01100000-10111000-00000000
// CHECK: fexpa   z0.h, z0.h // encoding: [0x00,0xb8,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10111000-00000000
fexpa   z23.s, z13.s  // 00000100-10100000-10111001-10110111
// CHECK: fexpa   z23.s, z13.s // encoding: [0xb7,0xb9,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10111001-10110111
FEXPA   Z23.S, Z13.S  // 00000100-10100000-10111001-10110111
// CHECK: fexpa   z23.s, z13.s // encoding: [0xb7,0xb9,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10111001-10110111
fexpa   z21.d, z10.d  // 00000100-11100000-10111001-01010101
// CHECK: fexpa   z21.d, z10.d // encoding: [0x55,0xb9,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10111001-01010101
FEXPA   Z21.D, Z10.D  // 00000100-11100000-10111001-01010101
// CHECK: fexpa   z21.d, z10.d // encoding: [0x55,0xb9,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10111001-01010101
fexpa   z31.h, z31.h  // 00000100-01100000-10111011-11111111
// CHECK: fexpa   z31.h, z31.h // encoding: [0xff,0xbb,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10111011-11111111
FEXPA   Z31.H, Z31.H  // 00000100-01100000-10111011-11111111
// CHECK: fexpa   z31.h, z31.h // encoding: [0xff,0xbb,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10111011-11111111
fexpa   z0.s, z0.s  // 00000100-10100000-10111000-00000000
// CHECK: fexpa   z0.s, z0.s // encoding: [0x00,0xb8,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10111000-00000000
FEXPA   Z0.S, Z0.S  // 00000100-10100000-10111000-00000000
// CHECK: fexpa   z0.s, z0.s // encoding: [0x00,0xb8,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10111000-00000000
fexpa   z31.s, z31.s  // 00000100-10100000-10111011-11111111
// CHECK: fexpa   z31.s, z31.s // encoding: [0xff,0xbb,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10111011-11111111
FEXPA   Z31.S, Z31.S  // 00000100-10100000-10111011-11111111
// CHECK: fexpa   z31.s, z31.s // encoding: [0xff,0xbb,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10111011-11111111
fexpa   z31.d, z31.d  // 00000100-11100000-10111011-11111111
// CHECK: fexpa   z31.d, z31.d // encoding: [0xff,0xbb,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10111011-11111111
FEXPA   Z31.D, Z31.D  // 00000100-11100000-10111011-11111111
// CHECK: fexpa   z31.d, z31.d // encoding: [0xff,0xbb,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10111011-11111111
fexpa   z21.s, z10.s  // 00000100-10100000-10111001-01010101
// CHECK: fexpa   z21.s, z10.s // encoding: [0x55,0xb9,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10111001-01010101
FEXPA   Z21.S, Z10.S  // 00000100-10100000-10111001-01010101
// CHECK: fexpa   z21.s, z10.s // encoding: [0x55,0xb9,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10111001-01010101
