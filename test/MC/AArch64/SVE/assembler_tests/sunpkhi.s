// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sunpkhi z0.h, z0.b  // 00000101-01110001-00111000-00000000
// CHECK: sunpkhi z0.h, z0.b // encoding: [0x00,0x38,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-00111000-00000000
SUNPKHI Z0.H, Z0.B  // 00000101-01110001-00111000-00000000
// CHECK: sunpkhi z0.h, z0.b // encoding: [0x00,0x38,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-00111000-00000000
sunpkhi z31.d, z31.s  // 00000101-11110001-00111011-11111111
// CHECK: sunpkhi z31.d, z31.s // encoding: [0xff,0x3b,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-00111011-11111111
SUNPKHI Z31.D, Z31.S  // 00000101-11110001-00111011-11111111
// CHECK: sunpkhi z31.d, z31.s // encoding: [0xff,0x3b,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-00111011-11111111
sunpkhi z23.d, z13.s  // 00000101-11110001-00111001-10110111
// CHECK: sunpkhi z23.d, z13.s // encoding: [0xb7,0x39,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-00111001-10110111
SUNPKHI Z23.D, Z13.S  // 00000101-11110001-00111001-10110111
// CHECK: sunpkhi z23.d, z13.s // encoding: [0xb7,0x39,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-00111001-10110111
sunpkhi z21.s, z10.h  // 00000101-10110001-00111001-01010101
// CHECK: sunpkhi z21.s, z10.h // encoding: [0x55,0x39,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-00111001-01010101
SUNPKHI Z21.S, Z10.H  // 00000101-10110001-00111001-01010101
// CHECK: sunpkhi z21.s, z10.h // encoding: [0x55,0x39,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-00111001-01010101
sunpkhi z23.s, z13.h  // 00000101-10110001-00111001-10110111
// CHECK: sunpkhi z23.s, z13.h // encoding: [0xb7,0x39,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-00111001-10110111
SUNPKHI Z23.S, Z13.H  // 00000101-10110001-00111001-10110111
// CHECK: sunpkhi z23.s, z13.h // encoding: [0xb7,0x39,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-00111001-10110111
sunpkhi z0.d, z0.s  // 00000101-11110001-00111000-00000000
// CHECK: sunpkhi z0.d, z0.s // encoding: [0x00,0x38,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-00111000-00000000
SUNPKHI Z0.D, Z0.S  // 00000101-11110001-00111000-00000000
// CHECK: sunpkhi z0.d, z0.s // encoding: [0x00,0x38,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-00111000-00000000
sunpkhi z31.s, z31.h  // 00000101-10110001-00111011-11111111
// CHECK: sunpkhi z31.s, z31.h // encoding: [0xff,0x3b,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-00111011-11111111
SUNPKHI Z31.S, Z31.H  // 00000101-10110001-00111011-11111111
// CHECK: sunpkhi z31.s, z31.h // encoding: [0xff,0x3b,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-00111011-11111111
sunpkhi z31.h, z31.b  // 00000101-01110001-00111011-11111111
// CHECK: sunpkhi z31.h, z31.b // encoding: [0xff,0x3b,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-00111011-11111111
SUNPKHI Z31.H, Z31.B  // 00000101-01110001-00111011-11111111
// CHECK: sunpkhi z31.h, z31.b // encoding: [0xff,0x3b,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-00111011-11111111
sunpkhi z21.h, z10.b  // 00000101-01110001-00111001-01010101
// CHECK: sunpkhi z21.h, z10.b // encoding: [0x55,0x39,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-00111001-01010101
SUNPKHI Z21.H, Z10.B  // 00000101-01110001-00111001-01010101
// CHECK: sunpkhi z21.h, z10.b // encoding: [0x55,0x39,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-00111001-01010101
sunpkhi z21.d, z10.s  // 00000101-11110001-00111001-01010101
// CHECK: sunpkhi z21.d, z10.s // encoding: [0x55,0x39,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-00111001-01010101
SUNPKHI Z21.D, Z10.S  // 00000101-11110001-00111001-01010101
// CHECK: sunpkhi z21.d, z10.s // encoding: [0x55,0x39,0xf1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110001-00111001-01010101
sunpkhi z23.h, z13.b  // 00000101-01110001-00111001-10110111
// CHECK: sunpkhi z23.h, z13.b // encoding: [0xb7,0x39,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-00111001-10110111
SUNPKHI Z23.H, Z13.B  // 00000101-01110001-00111001-10110111
// CHECK: sunpkhi z23.h, z13.b // encoding: [0xb7,0x39,0x71,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110001-00111001-10110111
sunpkhi z0.s, z0.h  // 00000101-10110001-00111000-00000000
// CHECK: sunpkhi z0.s, z0.h // encoding: [0x00,0x38,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-00111000-00000000
SUNPKHI Z0.S, Z0.H  // 00000101-10110001-00111000-00000000
// CHECK: sunpkhi z0.s, z0.h // encoding: [0x00,0x38,0xb1,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110001-00111000-00000000
