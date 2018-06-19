// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ctermne w0, w0  // 00100101-10100000-00100000-00010000
// CHECK: ctermne w0, w0 // encoding: [0x10,0x20,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-00100000-00010000
CTERMNE W0, W0  // 00100101-10100000-00100000-00010000
// CHECK: ctermne w0, w0 // encoding: [0x10,0x20,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-00100000-00010000
ctermne xzr, xzr  // 00100101-11111111-00100011-11110000
// CHECK: ctermne xzr, xzr // encoding: [0xf0,0x23,0xff,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111111-00100011-11110000
CTERMNE XZR, XZR  // 00100101-11111111-00100011-11110000
// CHECK: ctermne xzr, xzr // encoding: [0xf0,0x23,0xff,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111111-00100011-11110000
ctermne x13, x8  // 00100101-11101000-00100001-10110000
// CHECK: ctermne x13, x8 // encoding: [0xb0,0x21,0xe8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11101000-00100001-10110000
CTERMNE X13, X8  // 00100101-11101000-00100001-10110000
// CHECK: ctermne x13, x8 // encoding: [0xb0,0x21,0xe8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11101000-00100001-10110000
ctermne wzr, wzr  // 00100101-10111111-00100011-11110000
// CHECK: ctermne wzr, wzr // encoding: [0xf0,0x23,0xbf,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111111-00100011-11110000
CTERMNE WZR, WZR  // 00100101-10111111-00100011-11110000
// CHECK: ctermne wzr, wzr // encoding: [0xf0,0x23,0xbf,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111111-00100011-11110000
ctermne w10, w21  // 00100101-10110101-00100001-01010000
// CHECK: ctermne w10, w21 // encoding: [0x50,0x21,0xb5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10110101-00100001-01010000
CTERMNE W10, W21  // 00100101-10110101-00100001-01010000
// CHECK: ctermne w10, w21 // encoding: [0x50,0x21,0xb5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10110101-00100001-01010000
ctermne x10, x21  // 00100101-11110101-00100001-01010000
// CHECK: ctermne x10, x21 // encoding: [0x50,0x21,0xf5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11110101-00100001-01010000
CTERMNE X10, X21  // 00100101-11110101-00100001-01010000
// CHECK: ctermne x10, x21 // encoding: [0x50,0x21,0xf5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11110101-00100001-01010000
ctermne x0, x0  // 00100101-11100000-00100000-00010000
// CHECK: ctermne x0, x0 // encoding: [0x10,0x20,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-00100000-00010000
CTERMNE X0, X0  // 00100101-11100000-00100000-00010000
// CHECK: ctermne x0, x0 // encoding: [0x10,0x20,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-00100000-00010000
ctermne w13, w8  // 00100101-10101000-00100001-10110000
// CHECK: ctermne w13, w8 // encoding: [0xb0,0x21,0xa8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10101000-00100001-10110000
CTERMNE W13, W8  // 00100101-10101000-00100001-10110000
// CHECK: ctermne w13, w8 // encoding: [0xb0,0x21,0xa8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10101000-00100001-10110000
