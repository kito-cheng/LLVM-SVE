// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldr     p15, [sp, #-1, mul vl]  // 10000101-10111111-00011111-11101111
// CHECK: ldr     p15, [sp, #-1, mul vl] // encoding: [0xef,0x1f,0xbf,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10111111-00011111-11101111
LDR     P15, [SP, #-1, MUL VL]  // 10000101-10111111-00011111-11101111
// CHECK: ldr     p15, [sp, #-1, mul vl] // encoding: [0xef,0x1f,0xbf,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10111111-00011111-11101111
ldr     p7, [x13, #67, mul vl]  // 10000101-10001000-00001101-10100111
// CHECK: ldr     p7, [x13, #67, mul vl] // encoding: [0xa7,0x0d,0x88,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10001000-00001101-10100111
LDR     P7, [X13, #67, MUL VL]  // 10000101-10001000-00001101-10100111
// CHECK: ldr     p7, [x13, #67, mul vl] // encoding: [0xa7,0x0d,0x88,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10001000-00001101-10100111
ldr     p5, [x10, #173, mul vl]  // 10000101-10010101-00010101-01000101
// CHECK: ldr     p5, [x10, #173, mul vl] // encoding: [0x45,0x15,0x95,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10010101-00010101-01000101
LDR     P5, [X10, #173, MUL VL]  // 10000101-10010101-00010101-01000101
// CHECK: ldr     p5, [x10, #173, mul vl] // encoding: [0x45,0x15,0x95,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10010101-00010101-01000101
ldr     z31, [sp, #-1, mul vl]  // 10000101-10111111-01011111-11111111
// CHECK: ldr     z31, [sp, #-1, mul vl] // encoding: [0xff,0x5f,0xbf,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10111111-01011111-11111111
LDR     Z31, [SP, #-1, MUL VL]  // 10000101-10111111-01011111-11111111
// CHECK: ldr     z31, [sp, #-1, mul vl] // encoding: [0xff,0x5f,0xbf,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10111111-01011111-11111111
ldr     p0, [x0]  // 10000101-10000000-00000000-00000000
// CHECK: ldr     p0, [x0] // encoding: [0x00,0x00,0x80,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10000000-00000000-00000000
LDR     P0, [X0]  // 10000101-10000000-00000000-00000000
// CHECK: ldr     p0, [x0] // encoding: [0x00,0x00,0x80,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10000000-00000000-00000000
ldr     z0, [x0]  // 10000101-10000000-01000000-00000000
// CHECK: ldr     z0, [x0] // encoding: [0x00,0x40,0x80,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10000000-01000000-00000000
LDR     Z0, [X0]  // 10000101-10000000-01000000-00000000
// CHECK: ldr     z0, [x0] // encoding: [0x00,0x40,0x80,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10000000-01000000-00000000
ldr     z21, [x10, #173, mul vl]  // 10000101-10010101-01010101-01010101
// CHECK: ldr     z21, [x10, #173, mul vl] // encoding: [0x55,0x55,0x95,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10010101-01010101-01010101
LDR     Z21, [X10, #173, MUL VL]  // 10000101-10010101-01010101-01010101
// CHECK: ldr     z21, [x10, #173, mul vl] // encoding: [0x55,0x55,0x95,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10010101-01010101-01010101
ldr     z23, [x13, #67, mul vl]  // 10000101-10001000-01001101-10110111
// CHECK: ldr     z23, [x13, #67, mul vl] // encoding: [0xb7,0x4d,0x88,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10001000-01001101-10110111
LDR     Z23, [X13, #67, MUL VL]  // 10000101-10001000-01001101-10110111
// CHECK: ldr     z23, [x13, #67, mul vl] // encoding: [0xb7,0x4d,0x88,0x85]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 10000101-10001000-01001101-10110111
