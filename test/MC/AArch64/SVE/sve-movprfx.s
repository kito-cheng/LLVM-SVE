// RUN: llvm-mc -triple=aarch64-none-linux-gnu -mattr=+sve -show-encoding < %s | FileCheck %s

// Test we can prefix instructions. (Only covers SVE-ML additions)
// TODO: Autogenerate a version that includes all prefixable instructions.

movprfx z2, z18
fcadd z2.d, p5/m, z2.d, z7.d, #90
// CHECK: movprfx z2, z18
// CHECK: fcadd z2.d, p5/m, z2.d, z7.d, #90

movprfx z2.d, p5/m, z18.d
fcadd z2.d, p5/m, z2.d, z7.d, #90
// CHECK: movprfx z2.d, p5/m, z18.d
// CHECK: fcadd z2.d, p5/m, z2.d, z7.d, #90

movprfx z2.s, p5/z, z18.s
fcadd z2.s, p5/m, z2.s, z7.s, #270
// CHECK: movprfx z2.s, p5/z, z18.s
// CHECK: fcadd z2.s, p5/m, z2.s, z7.s, #270

movprfx z2, z18
fcmla z2.d, p2/m, z3.d, z7.d, #0
// CHECK: movprfx z2, z18
// CHECK: fcmla z2.d, p2/m, z3.d, z7.d, #0

movprfx z2.d, p5/m, z18.d
fcmla z2.d, p5/m, z3.d, z7.d, #90
// CHECK: movprfx z2.d, p5/m, z18.d
// CHECK: fcmla z2.d, p5/m, z3.d, z7.d, #90

movprfx z2.s, p5/z, z18.s
fcmla z2.s, p5/m, z3.s, z7.s, #180
// CHECK: movprfx z2.s, p5/z, z18.s
// CHECK: fcmla z2.s, p5/m, z3.s, z7.s, #180

movprfx z2, z18
fcmla z2.h, z24.h, z7.h[3], #90
// CHECK: movprfx z2, z18
// CHECK: fcmla z2.h, z24.h, z7.h[3], #90

movprfx z2, z18
fmla z2.d, z24.d, z7.d[0]
// CHECK: movprfx z2, z18
// CHECK: fmla z2.d, z24.d, z7.d[0]

movprfx z2, z18
fmls z2.d, z24.d, z7.d[1]
// CHECK: movprfx z2, z18
// CHECK: fmls z2.d, z24.d, z7.d[1]

movprfx z2, z18
ftmad z2.d, z2.d, z24.d, #3
// CHECK: movprfx z2, z18
// CHECK: ftmad z2.d, z2.d, z24.d, #3

movprfx z2, z18
sdot z2.d, z24.h, z14.h
// CHECK: movprfx z2, z18
// CHECK: sdot z2.d, z24.h, z14.h

movprfx z2, z18
sdot z2.d, z24.h, z14.h[0]
// CHECK: movprfx z2, z18
// CHECK: sdot z2.d, z24.h, z14.h[0]

movprfx z2, z18
udot z2.d, z24.h, z14.h
// CHECK: movprfx z2, z18
// CHECK: udot z2.d, z24.h, z14.h

movprfx z2, z18
udot z2.d, z24.h, z14.h[1]
// CHECK: movprfx z2, z18
// CHECK: udot z2.d, z24.h, z14.h[1]
