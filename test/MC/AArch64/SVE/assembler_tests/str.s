// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
str     p5, [x10, #173, mul vl]  // 11100101-10010101-00010101-01000101
// CHECK: str     p5, [x10, #173, mul vl] // encoding: [0x45,0x15,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-00010101-01000101
STR     P5, [X10, #173, MUL VL]  // 11100101-10010101-00010101-01000101
// CHECK: str     p5, [x10, #173, mul vl] // encoding: [0x45,0x15,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-00010101-01000101
str     z21, [x10, #173, mul vl]  // 11100101-10010101-01010101-01010101
// CHECK: str     z21, [x10, #173, mul vl] // encoding: [0x55,0x55,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-01010101-01010101
STR     Z21, [X10, #173, MUL VL]  // 11100101-10010101-01010101-01010101
// CHECK: str     z21, [x10, #173, mul vl] // encoding: [0x55,0x55,0x95,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10010101-01010101-01010101
str     p7, [x13, #67, mul vl]  // 11100101-10001000-00001101-10100111
// CHECK: str     p7, [x13, #67, mul vl] // encoding: [0xa7,0x0d,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-00001101-10100111
STR     P7, [X13, #67, MUL VL]  // 11100101-10001000-00001101-10100111
// CHECK: str     p7, [x13, #67, mul vl] // encoding: [0xa7,0x0d,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-00001101-10100111
str     z31, [sp, #-1, mul vl]  // 11100101-10111111-01011111-11111111
// CHECK: str     z31, [sp, #-1, mul vl] // encoding: [0xff,0x5f,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-01011111-11111111
STR     Z31, [SP, #-1, MUL VL]  // 11100101-10111111-01011111-11111111
// CHECK: str     z31, [sp, #-1, mul vl] // encoding: [0xff,0x5f,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-01011111-11111111
str     p0, [x0]  // 11100101-10000000-00000000-00000000
// CHECK: str     p0, [x0] // encoding: [0x00,0x00,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-00000000-00000000
STR     P0, [X0]  // 11100101-10000000-00000000-00000000
// CHECK: str     p0, [x0] // encoding: [0x00,0x00,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-00000000-00000000
str     p15, [sp, #-1, mul vl]  // 11100101-10111111-00011111-11101111
// CHECK: str     p15, [sp, #-1, mul vl] // encoding: [0xef,0x1f,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-00011111-11101111
STR     P15, [SP, #-1, MUL VL]  // 11100101-10111111-00011111-11101111
// CHECK: str     p15, [sp, #-1, mul vl] // encoding: [0xef,0x1f,0xbf,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10111111-00011111-11101111
str     z23, [x13, #67, mul vl]  // 11100101-10001000-01001101-10110111
// CHECK: str     z23, [x13, #67, mul vl] // encoding: [0xb7,0x4d,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-01001101-10110111
STR     Z23, [X13, #67, MUL VL]  // 11100101-10001000-01001101-10110111
// CHECK: str     z23, [x13, #67, mul vl] // encoding: [0xb7,0x4d,0x88,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10001000-01001101-10110111
str     z0, [x0]  // 11100101-10000000-01000000-00000000
// CHECK: str     z0, [x0] // encoding: [0x00,0x40,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-01000000-00000000
STR     Z0, [X0]  // 11100101-10000000-01000000-00000000
// CHECK: str     z0, [x0] // encoding: [0x00,0x40,0x80,0xe5]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 11100101-10000000-01000000-00000000
