// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld4h {z28.h, z29.h, z30.h, z31.h}, p0/z, [x15, xzr, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld4h {z28.h, z29.h, z30.h, z31.h}, p0/z, [x15, xzr, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld4h {z22.h, z23.h, z24.h, z25.h}, p8/z, [x13, #0, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld4h {z22.h, z23.h, z24.h, z25.h}, p8/z, [x13, #0, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 28].
ld4h {z10.h, z11.h, z12.h, z13.h}, p0/z, [x27, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: ld4h {z10.h, z11.h, z12.h, z13.h}, p0/z, [x27, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 28].
ld4h {z14.h, z15.h, z16.h, z17.h}, p2/z, [x29, #29, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: ld4h {z14.h, z15.h, z16.h, z17.h}, p2/z, [x29, #29, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

