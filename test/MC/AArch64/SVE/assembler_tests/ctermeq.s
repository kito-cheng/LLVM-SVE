// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ctermeq w0, w0  // 00100101-10100000-00100000-00000000
// CHECK: ctermeq w0, w0 // encoding: [0x00,0x20,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-00100000-00000000
CTERMEQ W0, W0  // 00100101-10100000-00100000-00000000
// CHECK: ctermeq w0, w0 // encoding: [0x00,0x20,0xa0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10100000-00100000-00000000
ctermeq xzr, xzr  // 00100101-11111111-00100011-11100000
// CHECK: ctermeq xzr, xzr // encoding: [0xe0,0x23,0xff,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111111-00100011-11100000
CTERMEQ XZR, XZR  // 00100101-11111111-00100011-11100000
// CHECK: ctermeq xzr, xzr // encoding: [0xe0,0x23,0xff,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11111111-00100011-11100000
ctermeq w13, w8  // 00100101-10101000-00100001-10100000
// CHECK: ctermeq w13, w8 // encoding: [0xa0,0x21,0xa8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10101000-00100001-10100000
CTERMEQ W13, W8  // 00100101-10101000-00100001-10100000
// CHECK: ctermeq w13, w8 // encoding: [0xa0,0x21,0xa8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10101000-00100001-10100000
ctermeq x13, x8  // 00100101-11101000-00100001-10100000
// CHECK: ctermeq x13, x8 // encoding: [0xa0,0x21,0xe8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11101000-00100001-10100000
CTERMEQ X13, X8  // 00100101-11101000-00100001-10100000
// CHECK: ctermeq x13, x8 // encoding: [0xa0,0x21,0xe8,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11101000-00100001-10100000
ctermeq x0, x0  // 00100101-11100000-00100000-00000000
// CHECK: ctermeq x0, x0 // encoding: [0x00,0x20,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-00100000-00000000
CTERMEQ X0, X0  // 00100101-11100000-00100000-00000000
// CHECK: ctermeq x0, x0 // encoding: [0x00,0x20,0xe0,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11100000-00100000-00000000
ctermeq w10, w21  // 00100101-10110101-00100001-01000000
// CHECK: ctermeq w10, w21 // encoding: [0x40,0x21,0xb5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10110101-00100001-01000000
CTERMEQ W10, W21  // 00100101-10110101-00100001-01000000
// CHECK: ctermeq w10, w21 // encoding: [0x40,0x21,0xb5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10110101-00100001-01000000
ctermeq wzr, wzr  // 00100101-10111111-00100011-11100000
// CHECK: ctermeq wzr, wzr // encoding: [0xe0,0x23,0xbf,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111111-00100011-11100000
CTERMEQ WZR, WZR  // 00100101-10111111-00100011-11100000
// CHECK: ctermeq wzr, wzr // encoding: [0xe0,0x23,0xbf,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-10111111-00100011-11100000
ctermeq x10, x21  // 00100101-11110101-00100001-01000000
// CHECK: ctermeq x10, x21 // encoding: [0x40,0x21,0xf5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11110101-00100001-01000000
CTERMEQ X10, X21  // 00100101-11110101-00100001-01000000
// CHECK: ctermeq x10, x21 // encoding: [0x40,0x21,0xf5,0x25]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00100101-11110101-00100001-01000000
