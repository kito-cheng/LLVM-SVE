// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
tbl     z23.d, {z13.d}, z8.d  // 00000101-11101000-00110001-10110111
// CHECK: tbl     z23.d, {z13.d}, z8.d // encoding: [0xb7,0x31,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-00110001-10110111
TBL     Z23.D, {Z13.D}, Z8.D  // 00000101-11101000-00110001-10110111
// CHECK: tbl     z23.d, {z13.d}, z8.d // encoding: [0xb7,0x31,0xe8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11101000-00110001-10110111
tbl     z21.h, {z10.h}, z21.h  // 00000101-01110101-00110001-01010101
// CHECK: tbl     z21.h, {z10.h}, z21.h // encoding: [0x55,0x31,0x75,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110101-00110001-01010101
TBL     Z21.H, {Z10.H}, Z21.H  // 00000101-01110101-00110001-01010101
// CHECK: tbl     z21.h, {z10.h}, z21.h // encoding: [0x55,0x31,0x75,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01110101-00110001-01010101
tbl     z0.b, {z0.b}, z0.b  // 00000101-00100000-00110000-00000000
// CHECK: tbl     z0.b, {z0.b}, z0.b // encoding: [0x00,0x30,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00110000-00000000
TBL     Z0.B, {Z0.B}, Z0.B  // 00000101-00100000-00110000-00000000
// CHECK: tbl     z0.b, {z0.b}, z0.b // encoding: [0x00,0x30,0x20,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00100000-00110000-00000000
tbl     z23.s, {z13.s}, z8.s  // 00000101-10101000-00110001-10110111
// CHECK: tbl     z23.s, {z13.s}, z8.s // encoding: [0xb7,0x31,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-00110001-10110111
TBL     Z23.S, {Z13.S}, Z8.S  // 00000101-10101000-00110001-10110111
// CHECK: tbl     z23.s, {z13.s}, z8.s // encoding: [0xb7,0x31,0xa8,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10101000-00110001-10110111
tbl     z21.s, {z10.s}, z21.s  // 00000101-10110101-00110001-01010101
// CHECK: tbl     z21.s, {z10.s}, z21.s // encoding: [0x55,0x31,0xb5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110101-00110001-01010101
TBL     Z21.S, {Z10.S}, Z21.S  // 00000101-10110101-00110001-01010101
// CHECK: tbl     z21.s, {z10.s}, z21.s // encoding: [0x55,0x31,0xb5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10110101-00110001-01010101
tbl     z0.s, {z0.s}, z0.s  // 00000101-10100000-00110000-00000000
// CHECK: tbl     z0.s, {z0.s}, z0.s // encoding: [0x00,0x30,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-00110000-00000000
TBL     Z0.S, {Z0.S}, Z0.S  // 00000101-10100000-00110000-00000000
// CHECK: tbl     z0.s, {z0.s}, z0.s // encoding: [0x00,0x30,0xa0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10100000-00110000-00000000
tbl     z0.h, {z0.h}, z0.h  // 00000101-01100000-00110000-00000000
// CHECK: tbl     z0.h, {z0.h}, z0.h // encoding: [0x00,0x30,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-00110000-00000000
TBL     Z0.H, {Z0.H}, Z0.H  // 00000101-01100000-00110000-00000000
// CHECK: tbl     z0.h, {z0.h}, z0.h // encoding: [0x00,0x30,0x60,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01100000-00110000-00000000
tbl     z0.d, {z0.d}, z0.d  // 00000101-11100000-00110000-00000000
// CHECK: tbl     z0.d, {z0.d}, z0.d // encoding: [0x00,0x30,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-00110000-00000000
TBL     Z0.D, {Z0.D}, Z0.D  // 00000101-11100000-00110000-00000000
// CHECK: tbl     z0.d, {z0.d}, z0.d // encoding: [0x00,0x30,0xe0,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11100000-00110000-00000000
tbl     z23.h, {z13.h}, z8.h  // 00000101-01101000-00110001-10110111
// CHECK: tbl     z23.h, {z13.h}, z8.h // encoding: [0xb7,0x31,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-00110001-10110111
TBL     Z23.H, {Z13.H}, Z8.H  // 00000101-01101000-00110001-10110111
// CHECK: tbl     z23.h, {z13.h}, z8.h // encoding: [0xb7,0x31,0x68,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01101000-00110001-10110111
tbl     z31.d, {z31.d}, z31.d  // 00000101-11111111-00110011-11111111
// CHECK: tbl     z31.d, {z31.d}, z31.d // encoding: [0xff,0x33,0xff,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111111-00110011-11111111
TBL     Z31.D, {Z31.D}, Z31.D  // 00000101-11111111-00110011-11111111
// CHECK: tbl     z31.d, {z31.d}, z31.d // encoding: [0xff,0x33,0xff,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11111111-00110011-11111111
tbl     z21.d, {z10.d}, z21.d  // 00000101-11110101-00110001-01010101
// CHECK: tbl     z21.d, {z10.d}, z21.d // encoding: [0x55,0x31,0xf5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110101-00110001-01010101
TBL     Z21.D, {Z10.D}, Z21.D  // 00000101-11110101-00110001-01010101
// CHECK: tbl     z21.d, {z10.d}, z21.d // encoding: [0x55,0x31,0xf5,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-11110101-00110001-01010101
tbl     z31.b, {z31.b}, z31.b  // 00000101-00111111-00110011-11111111
// CHECK: tbl     z31.b, {z31.b}, z31.b // encoding: [0xff,0x33,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00111111-00110011-11111111
TBL     Z31.B, {Z31.B}, Z31.B  // 00000101-00111111-00110011-11111111
// CHECK: tbl     z31.b, {z31.b}, z31.b // encoding: [0xff,0x33,0x3f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00111111-00110011-11111111
tbl     z21.b, {z10.b}, z21.b  // 00000101-00110101-00110001-01010101
// CHECK: tbl     z21.b, {z10.b}, z21.b // encoding: [0x55,0x31,0x35,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110101-00110001-01010101
TBL     Z21.B, {Z10.B}, Z21.B  // 00000101-00110101-00110001-01010101
// CHECK: tbl     z21.b, {z10.b}, z21.b // encoding: [0x55,0x31,0x35,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00110101-00110001-01010101
tbl     z31.s, {z31.s}, z31.s  // 00000101-10111111-00110011-11111111
// CHECK: tbl     z31.s, {z31.s}, z31.s // encoding: [0xff,0x33,0xbf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10111111-00110011-11111111
TBL     Z31.S, {Z31.S}, Z31.S  // 00000101-10111111-00110011-11111111
// CHECK: tbl     z31.s, {z31.s}, z31.s // encoding: [0xff,0x33,0xbf,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-10111111-00110011-11111111
tbl     z23.b, {z13.b}, z8.b  // 00000101-00101000-00110001-10110111
// CHECK: tbl     z23.b, {z13.b}, z8.b // encoding: [0xb7,0x31,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-00110001-10110111
TBL     Z23.B, {Z13.B}, Z8.B  // 00000101-00101000-00110001-10110111
// CHECK: tbl     z23.b, {z13.b}, z8.b // encoding: [0xb7,0x31,0x28,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-00101000-00110001-10110111
tbl     z31.h, {z31.h}, z31.h  // 00000101-01111111-00110011-11111111
// CHECK: tbl     z31.h, {z31.h}, z31.h // encoding: [0xff,0x33,0x7f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01111111-00110011-11111111
TBL     Z31.H, {Z31.H}, Z31.H  // 00000101-01111111-00110011-11111111
// CHECK: tbl     z31.h, {z31.h}, z31.h // encoding: [0xff,0x33,0x7f,0x05]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000101-01111111-00110011-11111111
