// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld4w {z14.s, z15.s, z16.s, z17.s}, p0/z, [x5, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld4w {z14.s, z15.s, z16.s, z17.s}, p0/z, [x5, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld4w {z18.s, z19.s, z20.s, z21.s}, p8/z, [x11, #6, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld4w {z18.s, z19.s, z20.s, z21.s}, p8/z, [x11, #6, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 28].
ld4w {z6.s, z7.s, z8.s, z9.s}, p2/z, [x17, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: ld4w {z6.s, z7.s, z8.s, z9.s}, p2/z, [x17, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 28].
ld4w {z11.s, z12.s, z13.s, z14.s}, p0/z, [x18, #29, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: ld4w {z11.s, z12.s, z13.s, z14.s}, p0/z, [x18, #29, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

