// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
frecpe  z31.d, z31.d  // 01100101-11001110-00110011-11111111
// CHECK: frecpe  z31.d, z31.d // encoding: [0xff,0x33,0xce,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001110-00110011-11111111
FRECPE  Z31.D, Z31.D  // 01100101-11001110-00110011-11111111
// CHECK: frecpe  z31.d, z31.d // encoding: [0xff,0x33,0xce,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001110-00110011-11111111
frecpe  z31.h, z31.h  // 01100101-01001110-00110011-11111111
// CHECK: frecpe  z31.h, z31.h // encoding: [0xff,0x33,0x4e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001110-00110011-11111111
FRECPE  Z31.H, Z31.H  // 01100101-01001110-00110011-11111111
// CHECK: frecpe  z31.h, z31.h // encoding: [0xff,0x33,0x4e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001110-00110011-11111111
frecpe  z31.s, z31.s  // 01100101-10001110-00110011-11111111
// CHECK: frecpe  z31.s, z31.s // encoding: [0xff,0x33,0x8e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001110-00110011-11111111
FRECPE  Z31.S, Z31.S  // 01100101-10001110-00110011-11111111
// CHECK: frecpe  z31.s, z31.s // encoding: [0xff,0x33,0x8e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001110-00110011-11111111
frecpe  z21.h, z10.h  // 01100101-01001110-00110001-01010101
// CHECK: frecpe  z21.h, z10.h // encoding: [0x55,0x31,0x4e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001110-00110001-01010101
FRECPE  Z21.H, Z10.H  // 01100101-01001110-00110001-01010101
// CHECK: frecpe  z21.h, z10.h // encoding: [0x55,0x31,0x4e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001110-00110001-01010101
frecpe  z0.h, z0.h  // 01100101-01001110-00110000-00000000
// CHECK: frecpe  z0.h, z0.h // encoding: [0x00,0x30,0x4e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001110-00110000-00000000
FRECPE  Z0.H, Z0.H  // 01100101-01001110-00110000-00000000
// CHECK: frecpe  z0.h, z0.h // encoding: [0x00,0x30,0x4e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001110-00110000-00000000
frecpe  z23.s, z13.s  // 01100101-10001110-00110001-10110111
// CHECK: frecpe  z23.s, z13.s // encoding: [0xb7,0x31,0x8e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001110-00110001-10110111
FRECPE  Z23.S, Z13.S  // 01100101-10001110-00110001-10110111
// CHECK: frecpe  z23.s, z13.s // encoding: [0xb7,0x31,0x8e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001110-00110001-10110111
frecpe  z0.s, z0.s  // 01100101-10001110-00110000-00000000
// CHECK: frecpe  z0.s, z0.s // encoding: [0x00,0x30,0x8e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001110-00110000-00000000
FRECPE  Z0.S, Z0.S  // 01100101-10001110-00110000-00000000
// CHECK: frecpe  z0.s, z0.s // encoding: [0x00,0x30,0x8e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001110-00110000-00000000
frecpe  z21.s, z10.s  // 01100101-10001110-00110001-01010101
// CHECK: frecpe  z21.s, z10.s // encoding: [0x55,0x31,0x8e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001110-00110001-01010101
FRECPE  Z21.S, Z10.S  // 01100101-10001110-00110001-01010101
// CHECK: frecpe  z21.s, z10.s // encoding: [0x55,0x31,0x8e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-10001110-00110001-01010101
frecpe  z21.d, z10.d  // 01100101-11001110-00110001-01010101
// CHECK: frecpe  z21.d, z10.d // encoding: [0x55,0x31,0xce,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001110-00110001-01010101
FRECPE  Z21.D, Z10.D  // 01100101-11001110-00110001-01010101
// CHECK: frecpe  z21.d, z10.d // encoding: [0x55,0x31,0xce,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001110-00110001-01010101
frecpe  z23.h, z13.h  // 01100101-01001110-00110001-10110111
// CHECK: frecpe  z23.h, z13.h // encoding: [0xb7,0x31,0x4e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001110-00110001-10110111
FRECPE  Z23.H, Z13.H  // 01100101-01001110-00110001-10110111
// CHECK: frecpe  z23.h, z13.h // encoding: [0xb7,0x31,0x4e,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-01001110-00110001-10110111
frecpe  z23.d, z13.d  // 01100101-11001110-00110001-10110111
// CHECK: frecpe  z23.d, z13.d // encoding: [0xb7,0x31,0xce,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001110-00110001-10110111
FRECPE  Z23.D, Z13.D  // 01100101-11001110-00110001-10110111
// CHECK: frecpe  z23.d, z13.d // encoding: [0xb7,0x31,0xce,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001110-00110001-10110111
frecpe  z0.d, z0.d  // 01100101-11001110-00110000-00000000
// CHECK: frecpe  z0.d, z0.d // encoding: [0x00,0x30,0xce,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001110-00110000-00000000
FRECPE  Z0.D, Z0.D  // 01100101-11001110-00110000-00000000
// CHECK: frecpe  z0.d, z0.d // encoding: [0x00,0x30,0xce,0x65]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 01100101-11001110-00110000-00000000
