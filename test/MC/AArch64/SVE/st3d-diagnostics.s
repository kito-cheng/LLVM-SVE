// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
st3d {z18.d, z19.d, z20.d}, p5, [x16, xzr, lsl #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: st3d {z18.d, z19.d, z20.d}, p5, [x16, xzr, lsl #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
st3d {z27.d, z28.d, z29.d}, p8, [x30, #0, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st3d {z27.d, z28.d, z29.d}, p8, [x30, #0, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-24, 21].
st3d {z29.d, z30.d, z31.d}, p3, [x17, #-25, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: st3d {z29.d, z30.d, z31.d}, p3, [x17, #-25, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-24, 21].
st3d {z22.d, z23.d, z24.d}, p0, [x1, #22, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: st3d {z22.d, z23.d, z24.d}, p0, [x1, #22, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

