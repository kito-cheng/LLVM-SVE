// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
adr     z31.s, [z31.s, z31.s, lsl #1]  // 00000100-10111111-10100111-11111111
// CHECK: adr     z31.s, [z31.s, z31.s, lsl #1] // encoding: [0xff,0xa7,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10100111-11111111
ADR     Z31.S, [Z31.S, Z31.S, LSL #1]  // 00000100-10111111-10100111-11111111
// CHECK: adr     z31.s, [z31.s, z31.s, lsl #1] // encoding: [0xff,0xa7,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10100111-11111111
adr     z0.s, [z0.s, z0.s, lsl #1]  // 00000100-10100000-10100100-00000000
// CHECK: adr     z0.s, [z0.s, z0.s, lsl #1] // encoding: [0x00,0xa4,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10100100-00000000
ADR     Z0.S, [Z0.S, Z0.S, LSL #1]  // 00000100-10100000-10100100-00000000
// CHECK: adr     z0.s, [z0.s, z0.s, lsl #1] // encoding: [0x00,0xa4,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10100100-00000000
adr     z0.d, [z0.d, z0.d, sxtw #2]  // 00000100-00100000-10101000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, sxtw #2] // encoding: [0x00,0xa8,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10101000-00000000
ADR     Z0.D, [Z0.D, Z0.D, SXTW #2]  // 00000100-00100000-10101000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, sxtw #2] // encoding: [0x00,0xa8,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10101000-00000000
adr     z31.s, [z31.s, z31.s]  // 00000100-10111111-10100011-11111111
// CHECK: adr     z31.s, [z31.s, z31.s] // encoding: [0xff,0xa3,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10100011-11111111
ADR     Z31.S, [Z31.S, Z31.S]  // 00000100-10111111-10100011-11111111
// CHECK: adr     z31.s, [z31.s, z31.s] // encoding: [0xff,0xa3,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10100011-11111111
adr     z23.d, [z13.d, z8.d, lsl #2]  // 00000100-11101000-10101001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, lsl #2] // encoding: [0xb7,0xa9,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10101001-10110111
ADR     Z23.D, [Z13.D, Z8.D, LSL #2]  // 00000100-11101000-10101001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, lsl #2] // encoding: [0xb7,0xa9,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10101001-10110111
adr     z0.d, [z0.d, z0.d, uxtw #3]  // 00000100-01100000-10101100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, uxtw #3] // encoding: [0x00,0xac,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10101100-00000000
ADR     Z0.D, [Z0.D, Z0.D, UXTW #3]  // 00000100-01100000-10101100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, uxtw #3] // encoding: [0x00,0xac,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10101100-00000000
adr     z0.s, [z0.s, z0.s]  // 00000100-10100000-10100000-00000000
// CHECK: adr     z0.s, [z0.s, z0.s] // encoding: [0x00,0xa0,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10100000-00000000
ADR     Z0.S, [Z0.S, Z0.S]  // 00000100-10100000-10100000-00000000
// CHECK: adr     z0.s, [z0.s, z0.s] // encoding: [0x00,0xa0,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10100000-00000000
adr     z21.d, [z10.d, z21.d]  // 00000100-11110101-10100001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d] // encoding: [0x55,0xa1,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10100001-01010101
ADR     Z21.D, [Z10.D, Z21.D]  // 00000100-11110101-10100001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d] // encoding: [0x55,0xa1,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10100001-01010101
adr     z23.s, [z13.s, z8.s, lsl #2]  // 00000100-10101000-10101001-10110111
// CHECK: adr     z23.s, [z13.s, z8.s, lsl #2] // encoding: [0xb7,0xa9,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10101001-10110111
ADR     Z23.S, [Z13.S, Z8.S, LSL #2]  // 00000100-10101000-10101001-10110111
// CHECK: adr     z23.s, [z13.s, z8.s, lsl #2] // encoding: [0xb7,0xa9,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10101001-10110111
adr     z0.d, [z0.d, z0.d, lsl #1]  // 00000100-11100000-10100100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, lsl #1] // encoding: [0x00,0xa4,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10100100-00000000
ADR     Z0.D, [Z0.D, Z0.D, LSL #1]  // 00000100-11100000-10100100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, lsl #1] // encoding: [0x00,0xa4,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10100100-00000000
adr     z31.d, [z31.d, z31.d]  // 00000100-11111111-10100011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d] // encoding: [0xff,0xa3,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10100011-11111111
ADR     Z31.D, [Z31.D, Z31.D]  // 00000100-11111111-10100011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d] // encoding: [0xff,0xa3,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10100011-11111111
adr     z31.s, [z31.s, z31.s, lsl #3]  // 00000100-10111111-10101111-11111111
// CHECK: adr     z31.s, [z31.s, z31.s, lsl #3] // encoding: [0xff,0xaf,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10101111-11111111
ADR     Z31.S, [Z31.S, Z31.S, LSL #3]  // 00000100-10111111-10101111-11111111
// CHECK: adr     z31.s, [z31.s, z31.s, lsl #3] // encoding: [0xff,0xaf,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10101111-11111111
adr     z21.d, [z10.d, z21.d, uxtw]  // 00000100-01110101-10100001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, uxtw] // encoding: [0x55,0xa1,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10100001-01010101
ADR     Z21.D, [Z10.D, Z21.D, UXTW]  // 00000100-01110101-10100001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, uxtw] // encoding: [0x55,0xa1,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10100001-01010101
adr     z23.d, [z13.d, z8.d, sxtw #2]  // 00000100-00101000-10101001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, sxtw #2] // encoding: [0xb7,0xa9,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10101001-10110111
ADR     Z23.D, [Z13.D, Z8.D, SXTW #2]  // 00000100-00101000-10101001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, sxtw #2] // encoding: [0xb7,0xa9,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10101001-10110111
adr     z0.d, [z0.d, z0.d, sxtw #3]  // 00000100-00100000-10101100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, sxtw #3] // encoding: [0x00,0xac,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10101100-00000000
ADR     Z0.D, [Z0.D, Z0.D, SXTW #3]  // 00000100-00100000-10101100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, sxtw #3] // encoding: [0x00,0xac,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10101100-00000000
adr     z0.s, [z0.s, z0.s, lsl #3]  // 00000100-10100000-10101100-00000000
// CHECK: adr     z0.s, [z0.s, z0.s, lsl #3] // encoding: [0x00,0xac,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10101100-00000000
ADR     Z0.S, [Z0.S, Z0.S, LSL #3]  // 00000100-10100000-10101100-00000000
// CHECK: adr     z0.s, [z0.s, z0.s, lsl #3] // encoding: [0x00,0xac,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10101100-00000000
adr     z23.s, [z13.s, z8.s, lsl #1]  // 00000100-10101000-10100101-10110111
// CHECK: adr     z23.s, [z13.s, z8.s, lsl #1] // encoding: [0xb7,0xa5,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10100101-10110111
ADR     Z23.S, [Z13.S, Z8.S, LSL #1]  // 00000100-10101000-10100101-10110111
// CHECK: adr     z23.s, [z13.s, z8.s, lsl #1] // encoding: [0xb7,0xa5,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10100101-10110111
adr     z23.d, [z13.d, z8.d, sxtw #1]  // 00000100-00101000-10100101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, sxtw #1] // encoding: [0xb7,0xa5,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10100101-10110111
ADR     Z23.D, [Z13.D, Z8.D, SXTW #1]  // 00000100-00101000-10100101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, sxtw #1] // encoding: [0xb7,0xa5,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10100101-10110111
adr     z21.d, [z10.d, z21.d, lsl #1]  // 00000100-11110101-10100101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, lsl #1] // encoding: [0x55,0xa5,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10100101-01010101
ADR     Z21.D, [Z10.D, Z21.D, LSL #1]  // 00000100-11110101-10100101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, lsl #1] // encoding: [0x55,0xa5,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10100101-01010101
adr     z23.s, [z13.s, z8.s, lsl #3]  // 00000100-10101000-10101101-10110111
// CHECK: adr     z23.s, [z13.s, z8.s, lsl #3] // encoding: [0xb7,0xad,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10101101-10110111
ADR     Z23.S, [Z13.S, Z8.S, LSL #3]  // 00000100-10101000-10101101-10110111
// CHECK: adr     z23.s, [z13.s, z8.s, lsl #3] // encoding: [0xb7,0xad,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10101101-10110111
adr     z23.s, [z13.s, z8.s]  // 00000100-10101000-10100001-10110111
// CHECK: adr     z23.s, [z13.s, z8.s] // encoding: [0xb7,0xa1,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10100001-10110111
ADR     Z23.S, [Z13.S, Z8.S]  // 00000100-10101000-10100001-10110111
// CHECK: adr     z23.s, [z13.s, z8.s] // encoding: [0xb7,0xa1,0xa8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10101000-10100001-10110111
adr     z21.d, [z10.d, z21.d, lsl #3]  // 00000100-11110101-10101101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, lsl #3] // encoding: [0x55,0xad,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10101101-01010101
ADR     Z21.D, [Z10.D, Z21.D, LSL #3]  // 00000100-11110101-10101101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, lsl #3] // encoding: [0x55,0xad,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10101101-01010101
adr     z21.d, [z10.d, z21.d, lsl #2]  // 00000100-11110101-10101001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, lsl #2] // encoding: [0x55,0xa9,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10101001-01010101
ADR     Z21.D, [Z10.D, Z21.D, LSL #2]  // 00000100-11110101-10101001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, lsl #2] // encoding: [0x55,0xa9,0xf5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11110101-10101001-01010101
adr     z21.d, [z10.d, z21.d, uxtw #3]  // 00000100-01110101-10101101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, uxtw #3] // encoding: [0x55,0xad,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10101101-01010101
ADR     Z21.D, [Z10.D, Z21.D, UXTW #3]  // 00000100-01110101-10101101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, uxtw #3] // encoding: [0x55,0xad,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10101101-01010101
adr     z31.d, [z31.d, z31.d, sxtw]  // 00000100-00111111-10100011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, sxtw] // encoding: [0xff,0xa3,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10100011-11111111
ADR     Z31.D, [Z31.D, Z31.D, SXTW]  // 00000100-00111111-10100011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, sxtw] // encoding: [0xff,0xa3,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10100011-11111111
adr     z23.d, [z13.d, z8.d, lsl #3]  // 00000100-11101000-10101101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, lsl #3] // encoding: [0xb7,0xad,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10101101-10110111
ADR     Z23.D, [Z13.D, Z8.D, LSL #3]  // 00000100-11101000-10101101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, lsl #3] // encoding: [0xb7,0xad,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10101101-10110111
adr     z21.s, [z10.s, z21.s, lsl #2]  // 00000100-10110101-10101001-01010101
// CHECK: adr     z21.s, [z10.s, z21.s, lsl #2] // encoding: [0x55,0xa9,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10101001-01010101
ADR     Z21.S, [Z10.S, Z21.S, LSL #2]  // 00000100-10110101-10101001-01010101
// CHECK: adr     z21.s, [z10.s, z21.s, lsl #2] // encoding: [0x55,0xa9,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10101001-01010101
adr     z21.s, [z10.s, z21.s, lsl #1]  // 00000100-10110101-10100101-01010101
// CHECK: adr     z21.s, [z10.s, z21.s, lsl #1] // encoding: [0x55,0xa5,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10100101-01010101
ADR     Z21.S, [Z10.S, Z21.S, LSL #1]  // 00000100-10110101-10100101-01010101
// CHECK: adr     z21.s, [z10.s, z21.s, lsl #1] // encoding: [0x55,0xa5,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10100101-01010101
adr     z23.d, [z13.d, z8.d, uxtw #3]  // 00000100-01101000-10101101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, uxtw #3] // encoding: [0xb7,0xad,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10101101-10110111
ADR     Z23.D, [Z13.D, Z8.D, UXTW #3]  // 00000100-01101000-10101101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, uxtw #3] // encoding: [0xb7,0xad,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10101101-10110111
adr     z21.d, [z10.d, z21.d, sxtw #3]  // 00000100-00110101-10101101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, sxtw #3] // encoding: [0x55,0xad,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10101101-01010101
ADR     Z21.D, [Z10.D, Z21.D, SXTW #3]  // 00000100-00110101-10101101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, sxtw #3] // encoding: [0x55,0xad,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10101101-01010101
adr     z31.d, [z31.d, z31.d, uxtw #3]  // 00000100-01111111-10101111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, uxtw #3] // encoding: [0xff,0xaf,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10101111-11111111
ADR     Z31.D, [Z31.D, Z31.D, UXTW #3]  // 00000100-01111111-10101111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, uxtw #3] // encoding: [0xff,0xaf,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10101111-11111111
adr     z0.d, [z0.d, z0.d, uxtw]  // 00000100-01100000-10100000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, uxtw] // encoding: [0x00,0xa0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10100000-00000000
ADR     Z0.D, [Z0.D, Z0.D, UXTW]  // 00000100-01100000-10100000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, uxtw] // encoding: [0x00,0xa0,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10100000-00000000
adr     z31.s, [z31.s, z31.s, lsl #2]  // 00000100-10111111-10101011-11111111
// CHECK: adr     z31.s, [z31.s, z31.s, lsl #2] // encoding: [0xff,0xab,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10101011-11111111
ADR     Z31.S, [Z31.S, Z31.S, LSL #2]  // 00000100-10111111-10101011-11111111
// CHECK: adr     z31.s, [z31.s, z31.s, lsl #2] // encoding: [0xff,0xab,0xbf,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10111111-10101011-11111111
adr     z21.d, [z10.d, z21.d, sxtw #2]  // 00000100-00110101-10101001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, sxtw #2] // encoding: [0x55,0xa9,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10101001-01010101
ADR     Z21.D, [Z10.D, Z21.D, SXTW #2]  // 00000100-00110101-10101001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, sxtw #2] // encoding: [0x55,0xa9,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10101001-01010101
adr     z0.d, [z0.d, z0.d, uxtw #1]  // 00000100-01100000-10100100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, uxtw #1] // encoding: [0x00,0xa4,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10100100-00000000
ADR     Z0.D, [Z0.D, Z0.D, UXTW #1]  // 00000100-01100000-10100100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, uxtw #1] // encoding: [0x00,0xa4,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10100100-00000000
adr     z31.d, [z31.d, z31.d, uxtw]  // 00000100-01111111-10100011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, uxtw] // encoding: [0xff,0xa3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10100011-11111111
ADR     Z31.D, [Z31.D, Z31.D, UXTW]  // 00000100-01111111-10100011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, uxtw] // encoding: [0xff,0xa3,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10100011-11111111
adr     z23.d, [z13.d, z8.d, sxtw]  // 00000100-00101000-10100001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, sxtw] // encoding: [0xb7,0xa1,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10100001-10110111
ADR     Z23.D, [Z13.D, Z8.D, SXTW]  // 00000100-00101000-10100001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, sxtw] // encoding: [0xb7,0xa1,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10100001-10110111
adr     z0.d, [z0.d, z0.d, uxtw #2]  // 00000100-01100000-10101000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, uxtw #2] // encoding: [0x00,0xa8,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10101000-00000000
ADR     Z0.D, [Z0.D, Z0.D, UXTW #2]  // 00000100-01100000-10101000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, uxtw #2] // encoding: [0x00,0xa8,0x60,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01100000-10101000-00000000
adr     z31.d, [z31.d, z31.d, uxtw #2]  // 00000100-01111111-10101011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, uxtw #2] // encoding: [0xff,0xab,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10101011-11111111
ADR     Z31.D, [Z31.D, Z31.D, UXTW #2]  // 00000100-01111111-10101011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, uxtw #2] // encoding: [0xff,0xab,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10101011-11111111
adr     z0.d, [z0.d, z0.d, lsl #2]  // 00000100-11100000-10101000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, lsl #2] // encoding: [0x00,0xa8,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10101000-00000000
ADR     Z0.D, [Z0.D, Z0.D, LSL #2]  // 00000100-11100000-10101000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, lsl #2] // encoding: [0x00,0xa8,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10101000-00000000
adr     z0.s, [z0.s, z0.s, lsl #2]  // 00000100-10100000-10101000-00000000
// CHECK: adr     z0.s, [z0.s, z0.s, lsl #2] // encoding: [0x00,0xa8,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10101000-00000000
ADR     Z0.S, [Z0.S, Z0.S, LSL #2]  // 00000100-10100000-10101000-00000000
// CHECK: adr     z0.s, [z0.s, z0.s, lsl #2] // encoding: [0x00,0xa8,0xa0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10100000-10101000-00000000
adr     z23.d, [z13.d, z8.d, sxtw #3]  // 00000100-00101000-10101101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, sxtw #3] // encoding: [0xb7,0xad,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10101101-10110111
ADR     Z23.D, [Z13.D, Z8.D, SXTW #3]  // 00000100-00101000-10101101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, sxtw #3] // encoding: [0xb7,0xad,0x28,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00101000-10101101-10110111
adr     z31.d, [z31.d, z31.d, sxtw #2]  // 00000100-00111111-10101011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, sxtw #2] // encoding: [0xff,0xab,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10101011-11111111
ADR     Z31.D, [Z31.D, Z31.D, SXTW #2]  // 00000100-00111111-10101011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, sxtw #2] // encoding: [0xff,0xab,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10101011-11111111
adr     z23.d, [z13.d, z8.d, uxtw #2]  // 00000100-01101000-10101001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, uxtw #2] // encoding: [0xb7,0xa9,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10101001-10110111
ADR     Z23.D, [Z13.D, Z8.D, UXTW #2]  // 00000100-01101000-10101001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, uxtw #2] // encoding: [0xb7,0xa9,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10101001-10110111
adr     z23.d, [z13.d, z8.d, uxtw #1]  // 00000100-01101000-10100101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, uxtw #1] // encoding: [0xb7,0xa5,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10100101-10110111
ADR     Z23.D, [Z13.D, Z8.D, UXTW #1]  // 00000100-01101000-10100101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, uxtw #1] // encoding: [0xb7,0xa5,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10100101-10110111
adr     z21.d, [z10.d, z21.d, sxtw #1]  // 00000100-00110101-10100101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, sxtw #1] // encoding: [0x55,0xa5,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10100101-01010101
ADR     Z21.D, [Z10.D, Z21.D, SXTW #1]  // 00000100-00110101-10100101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, sxtw #1] // encoding: [0x55,0xa5,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10100101-01010101
adr     z0.d, [z0.d, z0.d, lsl #3]  // 00000100-11100000-10101100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, lsl #3] // encoding: [0x00,0xac,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10101100-00000000
ADR     Z0.D, [Z0.D, Z0.D, LSL #3]  // 00000100-11100000-10101100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, lsl #3] // encoding: [0x00,0xac,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10101100-00000000
adr     z31.d, [z31.d, z31.d, lsl #2]  // 00000100-11111111-10101011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, lsl #2] // encoding: [0xff,0xab,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10101011-11111111
ADR     Z31.D, [Z31.D, Z31.D, LSL #2]  // 00000100-11111111-10101011-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, lsl #2] // encoding: [0xff,0xab,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10101011-11111111
adr     z23.d, [z13.d, z8.d]  // 00000100-11101000-10100001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d] // encoding: [0xb7,0xa1,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10100001-10110111
ADR     Z23.D, [Z13.D, Z8.D]  // 00000100-11101000-10100001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d] // encoding: [0xb7,0xa1,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10100001-10110111
adr     z21.d, [z10.d, z21.d, uxtw #1]  // 00000100-01110101-10100101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, uxtw #1] // encoding: [0x55,0xa5,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10100101-01010101
ADR     Z21.D, [Z10.D, Z21.D, UXTW #1]  // 00000100-01110101-10100101-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, uxtw #1] // encoding: [0x55,0xa5,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10100101-01010101
adr     z23.d, [z13.d, z8.d, uxtw]  // 00000100-01101000-10100001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, uxtw] // encoding: [0xb7,0xa1,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10100001-10110111
ADR     Z23.D, [Z13.D, Z8.D, UXTW]  // 00000100-01101000-10100001-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, uxtw] // encoding: [0xb7,0xa1,0x68,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01101000-10100001-10110111
adr     z21.s, [z10.s, z21.s, lsl #3]  // 00000100-10110101-10101101-01010101
// CHECK: adr     z21.s, [z10.s, z21.s, lsl #3] // encoding: [0x55,0xad,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10101101-01010101
ADR     Z21.S, [Z10.S, Z21.S, LSL #3]  // 00000100-10110101-10101101-01010101
// CHECK: adr     z21.s, [z10.s, z21.s, lsl #3] // encoding: [0x55,0xad,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10101101-01010101
adr     z31.d, [z31.d, z31.d, lsl #1]  // 00000100-11111111-10100111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, lsl #1] // encoding: [0xff,0xa7,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10100111-11111111
ADR     Z31.D, [Z31.D, Z31.D, LSL #1]  // 00000100-11111111-10100111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, lsl #1] // encoding: [0xff,0xa7,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10100111-11111111
adr     z31.d, [z31.d, z31.d, sxtw #3]  // 00000100-00111111-10101111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, sxtw #3] // encoding: [0xff,0xaf,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10101111-11111111
ADR     Z31.D, [Z31.D, Z31.D, SXTW #3]  // 00000100-00111111-10101111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, sxtw #3] // encoding: [0xff,0xaf,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10101111-11111111
adr     z0.d, [z0.d, z0.d]  // 00000100-11100000-10100000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d] // encoding: [0x00,0xa0,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10100000-00000000
ADR     Z0.D, [Z0.D, Z0.D]  // 00000100-11100000-10100000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d] // encoding: [0x00,0xa0,0xe0,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11100000-10100000-00000000
adr     z31.d, [z31.d, z31.d, uxtw #1]  // 00000100-01111111-10100111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, uxtw #1] // encoding: [0xff,0xa7,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10100111-11111111
ADR     Z31.D, [Z31.D, Z31.D, UXTW #1]  // 00000100-01111111-10100111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, uxtw #1] // encoding: [0xff,0xa7,0x7f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01111111-10100111-11111111
adr     z23.d, [z13.d, z8.d, lsl #1]  // 00000100-11101000-10100101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, lsl #1] // encoding: [0xb7,0xa5,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10100101-10110111
ADR     Z23.D, [Z13.D, Z8.D, LSL #1]  // 00000100-11101000-10100101-10110111
// CHECK: adr     z23.d, [z13.d, z8.d, lsl #1] // encoding: [0xb7,0xa5,0xe8,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11101000-10100101-10110111
adr     z0.d, [z0.d, z0.d, sxtw #1]  // 00000100-00100000-10100100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, sxtw #1] // encoding: [0x00,0xa4,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10100100-00000000
ADR     Z0.D, [Z0.D, Z0.D, SXTW #1]  // 00000100-00100000-10100100-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, sxtw #1] // encoding: [0x00,0xa4,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10100100-00000000
adr     z21.s, [z10.s, z21.s]  // 00000100-10110101-10100001-01010101
// CHECK: adr     z21.s, [z10.s, z21.s] // encoding: [0x55,0xa1,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10100001-01010101
ADR     Z21.S, [Z10.S, Z21.S]  // 00000100-10110101-10100001-01010101
// CHECK: adr     z21.s, [z10.s, z21.s] // encoding: [0x55,0xa1,0xb5,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-10110101-10100001-01010101
adr     z21.d, [z10.d, z21.d, sxtw]  // 00000100-00110101-10100001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, sxtw] // encoding: [0x55,0xa1,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10100001-01010101
ADR     Z21.D, [Z10.D, Z21.D, SXTW]  // 00000100-00110101-10100001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, sxtw] // encoding: [0x55,0xa1,0x35,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00110101-10100001-01010101
adr     z21.d, [z10.d, z21.d, uxtw #2]  // 00000100-01110101-10101001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, uxtw #2] // encoding: [0x55,0xa9,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10101001-01010101
ADR     Z21.D, [Z10.D, Z21.D, UXTW #2]  // 00000100-01110101-10101001-01010101
// CHECK: adr     z21.d, [z10.d, z21.d, uxtw #2] // encoding: [0x55,0xa9,0x75,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-01110101-10101001-01010101
adr     z31.d, [z31.d, z31.d, lsl #3]  // 00000100-11111111-10101111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, lsl #3] // encoding: [0xff,0xaf,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10101111-11111111
ADR     Z31.D, [Z31.D, Z31.D, LSL #3]  // 00000100-11111111-10101111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, lsl #3] // encoding: [0xff,0xaf,0xff,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-11111111-10101111-11111111
adr     z31.d, [z31.d, z31.d, sxtw #1]  // 00000100-00111111-10100111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, sxtw #1] // encoding: [0xff,0xa7,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10100111-11111111
ADR     Z31.D, [Z31.D, Z31.D, SXTW #1]  // 00000100-00111111-10100111-11111111
// CHECK: adr     z31.d, [z31.d, z31.d, sxtw #1] // encoding: [0xff,0xa7,0x3f,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00111111-10100111-11111111
adr     z0.d, [z0.d, z0.d, sxtw]  // 00000100-00100000-10100000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, sxtw] // encoding: [0x00,0xa0,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10100000-00000000
ADR     Z0.D, [Z0.D, Z0.D, SXTW]  // 00000100-00100000-10100000-00000000
// CHECK: adr     z0.d, [z0.d, z0.d, sxtw] // encoding: [0x00,0xa0,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-ERROR-NEXT: 00000100-00100000-10100000-00000000
