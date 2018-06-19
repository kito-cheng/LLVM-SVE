// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uaddv   d0, p0, z0.d  // 00000100-11000001-00100000-00000000
// CHECK: uaddv   d0, p0, z0.d // encoding: [0x00,0x20,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-00100000-00000000
UADDV   D0, P0, Z0.D  // 00000100-11000001-00100000-00000000
// CHECK: uaddv   d0, p0, z0.d // encoding: [0x00,0x20,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-00100000-00000000
uaddv   d31, p7, z31.d  // 00000100-11000001-00111111-11111111
// CHECK: uaddv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-00111111-11111111
UADDV   D31, P7, Z31.D  // 00000100-11000001-00111111-11111111
// CHECK: uaddv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-00111111-11111111
uaddv   d0, p0, z0.h  // 00000100-01000001-00100000-00000000
// CHECK: uaddv   d0, p0, z0.h // encoding: [0x00,0x20,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-00100000-00000000
UADDV   D0, P0, Z0.H  // 00000100-01000001-00100000-00000000
// CHECK: uaddv   d0, p0, z0.h // encoding: [0x00,0x20,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-00100000-00000000
uaddv   d23, p3, z13.b  // 00000100-00000001-00101101-10110111
// CHECK: uaddv   d23, p3, z13.b // encoding: [0xb7,0x2d,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-00101101-10110111
UADDV   D23, P3, Z13.B  // 00000100-00000001-00101101-10110111
// CHECK: uaddv   d23, p3, z13.b // encoding: [0xb7,0x2d,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-00101101-10110111
uaddv   d21, p5, z10.s  // 00000100-10000001-00110101-01010101
// CHECK: uaddv   d21, p5, z10.s // encoding: [0x55,0x35,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000001-00110101-01010101
UADDV   D21, P5, Z10.S  // 00000100-10000001-00110101-01010101
// CHECK: uaddv   d21, p5, z10.s // encoding: [0x55,0x35,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000001-00110101-01010101
uaddv   d21, p5, z10.d  // 00000100-11000001-00110101-01010101
// CHECK: uaddv   d21, p5, z10.d // encoding: [0x55,0x35,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-00110101-01010101
UADDV   D21, P5, Z10.D  // 00000100-11000001-00110101-01010101
// CHECK: uaddv   d21, p5, z10.d // encoding: [0x55,0x35,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-00110101-01010101
uaddv   d31, p7, z31.b  // 00000100-00000001-00111111-11111111
// CHECK: uaddv   d31, p7, z31.b // encoding: [0xff,0x3f,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-00111111-11111111
UADDV   D31, P7, Z31.B  // 00000100-00000001-00111111-11111111
// CHECK: uaddv   d31, p7, z31.b // encoding: [0xff,0x3f,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-00111111-11111111
uaddv   d31, p7, z31.h  // 00000100-01000001-00111111-11111111
// CHECK: uaddv   d31, p7, z31.h // encoding: [0xff,0x3f,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-00111111-11111111
UADDV   D31, P7, Z31.H  // 00000100-01000001-00111111-11111111
// CHECK: uaddv   d31, p7, z31.h // encoding: [0xff,0x3f,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-00111111-11111111
uaddv   d23, p3, z13.h  // 00000100-01000001-00101101-10110111
// CHECK: uaddv   d23, p3, z13.h // encoding: [0xb7,0x2d,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-00101101-10110111
UADDV   D23, P3, Z13.H  // 00000100-01000001-00101101-10110111
// CHECK: uaddv   d23, p3, z13.h // encoding: [0xb7,0x2d,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-00101101-10110111
uaddv   d0, p0, z0.b  // 00000100-00000001-00100000-00000000
// CHECK: uaddv   d0, p0, z0.b // encoding: [0x00,0x20,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-00100000-00000000
UADDV   D0, P0, Z0.B  // 00000100-00000001-00100000-00000000
// CHECK: uaddv   d0, p0, z0.b // encoding: [0x00,0x20,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-00100000-00000000
uaddv   d21, p5, z10.b  // 00000100-00000001-00110101-01010101
// CHECK: uaddv   d21, p5, z10.b // encoding: [0x55,0x35,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-00110101-01010101
UADDV   D21, P5, Z10.B  // 00000100-00000001-00110101-01010101
// CHECK: uaddv   d21, p5, z10.b // encoding: [0x55,0x35,0x01,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00000001-00110101-01010101
uaddv   d23, p3, z13.d  // 00000100-11000001-00101101-10110111
// CHECK: uaddv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-00101101-10110111
UADDV   D23, P3, Z13.D  // 00000100-11000001-00101101-10110111
// CHECK: uaddv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11000001-00101101-10110111
uaddv   d21, p5, z10.h  // 00000100-01000001-00110101-01010101
// CHECK: uaddv   d21, p5, z10.h // encoding: [0x55,0x35,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-00110101-01010101
UADDV   D21, P5, Z10.H  // 00000100-01000001-00110101-01010101
// CHECK: uaddv   d21, p5, z10.h // encoding: [0x55,0x35,0x41,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01000001-00110101-01010101
uaddv   d23, p3, z13.s  // 00000100-10000001-00101101-10110111
// CHECK: uaddv   d23, p3, z13.s // encoding: [0xb7,0x2d,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000001-00101101-10110111
UADDV   D23, P3, Z13.S  // 00000100-10000001-00101101-10110111
// CHECK: uaddv   d23, p3, z13.s // encoding: [0xb7,0x2d,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000001-00101101-10110111
uaddv   d0, p0, z0.s  // 00000100-10000001-00100000-00000000
// CHECK: uaddv   d0, p0, z0.s // encoding: [0x00,0x20,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000001-00100000-00000000
UADDV   D0, P0, Z0.S  // 00000100-10000001-00100000-00000000
// CHECK: uaddv   d0, p0, z0.s // encoding: [0x00,0x20,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000001-00100000-00000000
uaddv   d31, p7, z31.s  // 00000100-10000001-00111111-11111111
// CHECK: uaddv   d31, p7, z31.s // encoding: [0xff,0x3f,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000001-00111111-11111111
UADDV   D31, P7, Z31.S  // 00000100-10000001-00111111-11111111
// CHECK: uaddv   d31, p7, z31.s // encoding: [0xff,0x3f,0x81,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10000001-00111111-11111111
