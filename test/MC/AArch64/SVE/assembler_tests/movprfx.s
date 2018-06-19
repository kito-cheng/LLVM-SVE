// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
movprfx z23.d, p3/m, z13.d  // 00000100-11010001-00101101-10110111
add z23.d, p3/m, z23.d, z24.d
// CHECK: movprfx z23.d, p3/m, z13.d // encoding: [0xb7,0x2d,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-00101101-10110111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z23.D, P3/M, Z13.D  // 00000100-11010001-00101101-10110111
add z23.d, p3/m, z23.d, z24.d
// CHECK: movprfx z23.d, p3/m, z13.d // encoding: [0xb7,0x2d,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-00101101-10110111
// CHECK-ERROR: instruction requires: sve
movprfx z31.s, p7/m, z31.s  // 00000100-10010001-00111111-11111111
add z31.s, p7/m, z31.s, z1.s
// CHECK: movprfx z31.s, p7/m, z31.s // encoding: [0xff,0x3f,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-00111111-11111111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z31.S, P7/M, Z31.S  // 00000100-10010001-00111111-11111111
add z31.s, p7/m, z31.s, z1.s
// CHECK: movprfx z31.s, p7/m, z31.s // encoding: [0xff,0x3f,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-00111111-11111111
// CHECK-ERROR: instruction requires: sve
movprfx z21.h, p5/z, z10.h  // 00000100-01010000-00110101-01010101
add z21.h, p5/m, z21.h, z22.h
// CHECK: movprfx z21.h, p5/z, z10.h // encoding: [0x55,0x35,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-00110101-01010101
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z21.H, P5/Z, Z10.H  // 00000100-01010000-00110101-01010101
add z21.h, p5/m, z21.h, z22.h
// CHECK: movprfx z21.h, p5/z, z10.h // encoding: [0x55,0x35,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-00110101-01010101
// CHECK-ERROR: instruction requires: sve
movprfx z23.b, p3/m, z13.b  // 00000100-00010001-00101101-10110111
add z23.b, p3/m, z23.b, z24.b
// CHECK: movprfx z23.b, p3/m, z13.b // encoding: [0xb7,0x2d,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-00101101-10110111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z23.B, P3/M, Z13.B  // 00000100-00010001-00101101-10110111
add z23.b, p3/m, z23.b, z24.b
// CHECK: movprfx z23.b, p3/m, z13.b // encoding: [0xb7,0x2d,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-00101101-10110111
// CHECK-ERROR: instruction requires: sve
movprfx z21.b, p5/z, z10.b  // 00000100-00010000-00110101-01010101
add z21.b, p5/m, z21.b, z22.b
// CHECK: movprfx z21.b, p5/z, z10.b // encoding: [0x55,0x35,0x10,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010000-00110101-01010101
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z21.B, P5/Z, Z10.B  // 00000100-00010000-00110101-01010101
add z21.b, p5/m, z21.b, z22.b
// CHECK: movprfx z21.b, p5/z, z10.b // encoding: [0x55,0x35,0x10,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010000-00110101-01010101
// CHECK-ERROR: instruction requires: sve
movprfx z0.s, p0/z, z0.s  // 00000100-10010000-00100000-00000000
add z0.s, p0/m, z0.s, z1.s
// CHECK: movprfx z0.s, p0/z, z0.s // encoding: [0x00,0x20,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-00100000-00000000
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z0.S, P0/Z, Z0.S  // 00000100-10010000-00100000-00000000
add z0.s, p0/m, z0.s, z1.s
// CHECK: movprfx z0.s, p0/z, z0.s // encoding: [0x00,0x20,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-00100000-00000000
// CHECK-ERROR: instruction requires: sve
movprfx z21.s, p5/m, z10.s  // 00000100-10010001-00110101-01010101
add z21.s, p5/m, z21.s, z22.s
// CHECK: movprfx z21.s, p5/m, z10.s // encoding: [0x55,0x35,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-00110101-01010101
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z21.S, P5/M, Z10.S  // 00000100-10010001-00110101-01010101
add z21.s, p5/m, z21.s, z22.s
// CHECK: movprfx z21.s, p5/m, z10.s // encoding: [0x55,0x35,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-00110101-01010101
// CHECK-ERROR: instruction requires: sve
movprfx z23.h, p3/z, z13.h  // 00000100-01010000-00101101-10110111
add z23.h, p3/m, z23.h, z24.h
// CHECK: movprfx z23.h, p3/z, z13.h // encoding: [0xb7,0x2d,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-00101101-10110111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z23.H, P3/Z, Z13.H  // 00000100-01010000-00101101-10110111
add z23.h, p3/m, z23.h, z24.h
// CHECK: movprfx z23.h, p3/z, z13.h // encoding: [0xb7,0x2d,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-00101101-10110111
// CHECK-ERROR: instruction requires: sve
movprfx z31.h, p7/m, z31.h  // 00000100-01010001-00111111-11111111
add z31.h, p7/m, z31.h, z1.h
// CHECK: movprfx z31.h, p7/m, z31.h // encoding: [0xff,0x3f,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-00111111-11111111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z31.H, P7/M, Z31.H  // 00000100-01010001-00111111-11111111
add z31.h, p7/m, z31.h, z1.h
// CHECK: movprfx z31.h, p7/m, z31.h // encoding: [0xff,0x3f,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-00111111-11111111
// CHECK-ERROR: instruction requires: sve
movprfx z0.h, p0/m, z0.h  // 00000100-01010001-00100000-00000000
add z0.h, p0/m, z0.h, z1.h
// CHECK: movprfx z0.h, p0/m, z0.h // encoding: [0x00,0x20,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-00100000-00000000
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z0.H, P0/M, Z0.H  // 00000100-01010001-00100000-00000000
add z0.h, p0/m, z0.h, z1.h
// CHECK: movprfx z0.h, p0/m, z0.h // encoding: [0x00,0x20,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-00100000-00000000
// CHECK-ERROR: instruction requires: sve
movprfx z0.b, p0/z, z0.b  // 00000100-00010000-00100000-00000000
add z0.b, p0/m, z0.b, z1.b
// CHECK: movprfx z0.b, p0/z, z0.b // encoding: [0x00,0x20,0x10,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010000-00100000-00000000
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z0.B, P0/Z, Z0.B  // 00000100-00010000-00100000-00000000
add z0.b, p0/m, z0.b, z1.b
// CHECK: movprfx z0.b, p0/z, z0.b // encoding: [0x00,0x20,0x10,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010000-00100000-00000000
// CHECK-ERROR: instruction requires: sve
movprfx z31.s, p7/z, z31.s  // 00000100-10010000-00111111-11111111
add z31.s, p7/m, z31.s, z1.s
// CHECK: movprfx z31.s, p7/z, z31.s // encoding: [0xff,0x3f,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-00111111-11111111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z31.S, P7/Z, Z31.S  // 00000100-10010000-00111111-11111111
add z31.s, p7/m, z31.s, z1.s
// CHECK: movprfx z31.s, p7/z, z31.s // encoding: [0xff,0x3f,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-00111111-11111111
// CHECK-ERROR: instruction requires: sve
movprfx z0.b, p0/m, z0.b  // 00000100-00010001-00100000-00000000
add z0.b, p0/m, z0.b, z1.b
// CHECK: movprfx z0.b, p0/m, z0.b // encoding: [0x00,0x20,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-00100000-00000000
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z0.B, P0/M, Z0.B  // 00000100-00010001-00100000-00000000
add z0.b, p0/m, z0.b, z1.b
// CHECK: movprfx z0.b, p0/m, z0.b // encoding: [0x00,0x20,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-00100000-00000000
// CHECK-ERROR: instruction requires: sve
movprfx z21.b, p5/m, z10.b  // 00000100-00010001-00110101-01010101
add z21.b, p5/m, z21.b, z22.b
// CHECK: movprfx z21.b, p5/m, z10.b // encoding: [0x55,0x35,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-00110101-01010101
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z21.B, P5/M, Z10.B  // 00000100-00010001-00110101-01010101
add z21.b, p5/m, z21.b, z22.b
// CHECK: movprfx z21.b, p5/m, z10.b // encoding: [0x55,0x35,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-00110101-01010101
// CHECK-ERROR: instruction requires: sve
movprfx z21.d, p5/m, z10.d  // 00000100-11010001-00110101-01010101
add z21.d, p5/m, z21.d, z22.d
// CHECK: movprfx z21.d, p5/m, z10.d // encoding: [0x55,0x35,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-00110101-01010101
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z21.D, P5/M, Z10.D  // 00000100-11010001-00110101-01010101
add z21.d, p5/m, z21.d, z22.d
// CHECK: movprfx z21.d, p5/m, z10.d // encoding: [0x55,0x35,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-00110101-01010101
// CHECK-ERROR: instruction requires: sve
movprfx z31.d, p7/m, z31.d  // 00000100-11010001-00111111-11111111
add z31.d, p7/m, z31.d, z1.d
// CHECK: movprfx z31.d, p7/m, z31.d // encoding: [0xff,0x3f,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-00111111-11111111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z31.D, P7/M, Z31.D  // 00000100-11010001-00111111-11111111
add z31.d, p7/m, z31.d, z1.d
// CHECK: movprfx z31.d, p7/m, z31.d // encoding: [0xff,0x3f,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-00111111-11111111
// CHECK-ERROR: instruction requires: sve
movprfx z23, z13  // 00000100-00100000-10111101-10110111
add z23.s, p0/m, z23.s, z24.s
// CHECK: movprfx z23, z13 // encoding: [0xb7,0xbd,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10111101-10110111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z23, Z13  // 00000100-00100000-10111101-10110111
add z23.s, p0/m, z23.s, z24.s
// CHECK: movprfx z23, z13 // encoding: [0xb7,0xbd,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10111101-10110111
// CHECK-ERROR: instruction requires: sve
movprfx z23.d, p3/z, z13.d  // 00000100-11010000-00101101-10110111
add z23.d, p3/m, z23.d, z24.d
// CHECK: movprfx z23.d, p3/z, z13.d // encoding: [0xb7,0x2d,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-00101101-10110111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z23.D, P3/Z, Z13.D  // 00000100-11010000-00101101-10110111
add z23.d, p3/m, z23.d, z24.d
// CHECK: movprfx z23.d, p3/z, z13.d // encoding: [0xb7,0x2d,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-00101101-10110111
// CHECK-ERROR: instruction requires: sve
movprfx z31.d, p7/z, z31.d  // 00000100-11010000-00111111-11111111
add z31.d, p7/m, z31.d, z1.d
// CHECK: movprfx z31.d, p7/z, z31.d // encoding: [0xff,0x3f,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-00111111-11111111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z31.D, P7/Z, Z31.D  // 00000100-11010000-00111111-11111111
add z31.d, p7/m, z31.d, z1.d
// CHECK: movprfx z31.d, p7/z, z31.d // encoding: [0xff,0x3f,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-00111111-11111111
// CHECK-ERROR: instruction requires: sve
movprfx z31.b, p7/z, z31.b  // 00000100-00010000-00111111-11111111
add z31.b, p7/m, z31.b, z1.b
// CHECK: movprfx z31.b, p7/z, z31.b // encoding: [0xff,0x3f,0x10,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010000-00111111-11111111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z31.B, P7/Z, Z31.B  // 00000100-00010000-00111111-11111111
add z31.b, p7/m, z31.b, z1.b
// CHECK: movprfx z31.b, p7/z, z31.b // encoding: [0xff,0x3f,0x10,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010000-00111111-11111111
// CHECK-ERROR: instruction requires: sve
movprfx z23.s, p3/z, z13.s  // 00000100-10010000-00101101-10110111
add z23.s, p3/m, z23.s, z24.s
// CHECK: movprfx z23.s, p3/z, z13.s // encoding: [0xb7,0x2d,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-00101101-10110111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z23.S, P3/Z, Z13.S  // 00000100-10010000-00101101-10110111
add z23.s, p3/m, z23.s, z24.s
// CHECK: movprfx z23.s, p3/z, z13.s // encoding: [0xb7,0x2d,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-00101101-10110111
// CHECK-ERROR: instruction requires: sve
movprfx z21.d, p5/z, z10.d  // 00000100-11010000-00110101-01010101
add z21.d, p5/m, z21.d, z22.d
// CHECK: movprfx z21.d, p5/z, z10.d // encoding: [0x55,0x35,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-00110101-01010101
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z21.D, P5/Z, Z10.D  // 00000100-11010000-00110101-01010101
add z21.d, p5/m, z21.d, z22.d
// CHECK: movprfx z21.d, p5/z, z10.d // encoding: [0x55,0x35,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-00110101-01010101
// CHECK-ERROR: instruction requires: sve
movprfx z31, z31  // 00000100-00100000-10111111-11111111
add z31.s, p0/m, z31.s, z1.s
// CHECK: movprfx z31, z31 // encoding: [0xff,0xbf,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10111111-11111111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z31, Z31  // 00000100-00100000-10111111-11111111
add z31.s, p0/m, z31.s, z1.s
// CHECK: movprfx z31, z31 // encoding: [0xff,0xbf,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10111111-11111111
// CHECK-ERROR: instruction requires: sve
movprfx z0.h, p0/z, z0.h  // 00000100-01010000-00100000-00000000
add z0.h, p0/m, z0.h, z1.h
// CHECK: movprfx z0.h, p0/z, z0.h // encoding: [0x00,0x20,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-00100000-00000000
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z0.H, P0/Z, Z0.H  // 00000100-01010000-00100000-00000000
add z0.h, p0/m, z0.h, z1.h
// CHECK: movprfx z0.h, p0/z, z0.h // encoding: [0x00,0x20,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-00100000-00000000
// CHECK-ERROR: instruction requires: sve
movprfx z0.d, p0/m, z0.d  // 00000100-11010001-00100000-00000000
add z0.d, p0/m, z0.d, z1.d
// CHECK: movprfx z0.d, p0/m, z0.d // encoding: [0x00,0x20,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-00100000-00000000
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z0.D, P0/M, Z0.D  // 00000100-11010001-00100000-00000000
add z0.d, p0/m, z0.d, z1.d
// CHECK: movprfx z0.d, p0/m, z0.d // encoding: [0x00,0x20,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010001-00100000-00000000
// CHECK-ERROR: instruction requires: sve
movprfx z31.h, p7/z, z31.h  // 00000100-01010000-00111111-11111111
add z31.h, p7/m, z31.h, z1.h
// CHECK: movprfx z31.h, p7/z, z31.h // encoding: [0xff,0x3f,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-00111111-11111111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z31.H, P7/Z, Z31.H  // 00000100-01010000-00111111-11111111
add z31.h, p7/m, z31.h, z1.h
// CHECK: movprfx z31.h, p7/z, z31.h // encoding: [0xff,0x3f,0x50,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010000-00111111-11111111
// CHECK-ERROR: instruction requires: sve
movprfx z21.s, p5/z, z10.s  // 00000100-10010000-00110101-01010101
add z21.s, p5/m, z21.s, z22.s
// CHECK: movprfx z21.s, p5/z, z10.s // encoding: [0x55,0x35,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-00110101-01010101
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z21.S, P5/Z, Z10.S  // 00000100-10010000-00110101-01010101
add z21.s, p5/m, z21.s, z22.s
// CHECK: movprfx z21.s, p5/z, z10.s // encoding: [0x55,0x35,0x90,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010000-00110101-01010101
// CHECK-ERROR: instruction requires: sve
movprfx z23.h, p3/m, z13.h  // 00000100-01010001-00101101-10110111
add z23.h, p3/m, z23.h, z24.h
// CHECK: movprfx z23.h, p3/m, z13.h // encoding: [0xb7,0x2d,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-00101101-10110111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z23.H, P3/M, Z13.H  // 00000100-01010001-00101101-10110111
add z23.h, p3/m, z23.h, z24.h
// CHECK: movprfx z23.h, p3/m, z13.h // encoding: [0xb7,0x2d,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-00101101-10110111
// CHECK-ERROR: instruction requires: sve
movprfx z0, z0  // 00000100-00100000-10111100-00000000
add z0.s, p0/m, z0.s, z1.s
// CHECK: movprfx z0, z0 // encoding: [0x00,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10111100-00000000
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z0, Z0  // 00000100-00100000-10111100-00000000
add z0.s, p0/m, z0.s, z1.s
// CHECK: movprfx z0, z0 // encoding: [0x00,0xbc,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10111100-00000000
// CHECK-ERROR: instruction requires: sve
movprfx z21.h, p5/m, z10.h  // 00000100-01010001-00110101-01010101
add z21.h, p5/m, z21.h, z22.h
// CHECK: movprfx z21.h, p5/m, z10.h // encoding: [0x55,0x35,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-00110101-01010101
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z21.H, P5/M, Z10.H  // 00000100-01010001-00110101-01010101
add z21.h, p5/m, z21.h, z22.h
// CHECK: movprfx z21.h, p5/m, z10.h // encoding: [0x55,0x35,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01010001-00110101-01010101
// CHECK-ERROR: instruction requires: sve
movprfx z0.s, p0/m, z0.s  // 00000100-10010001-00100000-00000000
add z0.s, p0/m, z0.s, z1.s
// CHECK: movprfx z0.s, p0/m, z0.s // encoding: [0x00,0x20,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-00100000-00000000
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z0.S, P0/M, Z0.S  // 00000100-10010001-00100000-00000000
add z0.s, p0/m, z0.s, z1.s
// CHECK: movprfx z0.s, p0/m, z0.s // encoding: [0x00,0x20,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-00100000-00000000
// CHECK-ERROR: instruction requires: sve
movprfx z31.b, p7/m, z31.b  // 00000100-00010001-00111111-11111111
add z31.b, p7/m, z31.b, z1.b
// CHECK: movprfx z31.b, p7/m, z31.b // encoding: [0xff,0x3f,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-00111111-11111111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z31.B, P7/M, Z31.B  // 00000100-00010001-00111111-11111111
add z31.b, p7/m, z31.b, z1.b
// CHECK: movprfx z31.b, p7/m, z31.b // encoding: [0xff,0x3f,0x11,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010001-00111111-11111111
// CHECK-ERROR: instruction requires: sve
movprfx z21, z10  // 00000100-00100000-10111101-01010101
add z21.s, p0/m, z21.s, z22.s
// CHECK: movprfx z21, z10 // encoding: [0x55,0xbd,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10111101-01010101
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z21, Z10  // 00000100-00100000-10111101-01010101
add z21.s, p0/m, z21.s, z22.s
// CHECK: movprfx z21, z10 // encoding: [0x55,0xbd,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10111101-01010101
// CHECK-ERROR: instruction requires: sve
movprfx z0.d, p0/z, z0.d  // 00000100-11010000-00100000-00000000
add z0.d, p0/m, z0.d, z1.d
// CHECK: movprfx z0.d, p0/z, z0.d // encoding: [0x00,0x20,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-00100000-00000000
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z0.D, P0/Z, Z0.D  // 00000100-11010000-00100000-00000000
add z0.d, p0/m, z0.d, z1.d
// CHECK: movprfx z0.d, p0/z, z0.d // encoding: [0x00,0x20,0xd0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11010000-00100000-00000000
// CHECK-ERROR: instruction requires: sve
movprfx z23.b, p3/z, z13.b  // 00000100-00010000-00101101-10110111
add z23.b, p3/m, z23.b, z24.b
// CHECK: movprfx z23.b, p3/z, z13.b // encoding: [0xb7,0x2d,0x10,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010000-00101101-10110111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z23.B, P3/Z, Z13.B  // 00000100-00010000-00101101-10110111
add z23.b, p3/m, z23.b, z24.b
// CHECK: movprfx z23.b, p3/z, z13.b // encoding: [0xb7,0x2d,0x10,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00010000-00101101-10110111
// CHECK-ERROR: instruction requires: sve
movprfx z23.s, p3/m, z13.s  // 00000100-10010001-00101101-10110111
add z23.s, p3/m, z23.s, z24.s
// CHECK: movprfx z23.s, p3/m, z13.s // encoding: [0xb7,0x2d,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-00101101-10110111
// CHECK-ERROR: instruction requires: sve
MOVPRFX Z23.S, P3/M, Z13.S  // 00000100-10010001-00101101-10110111
add z23.s, p3/m, z23.s, z24.s
// CHECK: movprfx z23.s, p3/m, z13.s // encoding: [0xb7,0x2d,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10010001-00101101-10110111
// CHECK-ERROR: instruction requires: sve
