// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
st4d {z1.d, z2.d, z3.d, z4.d}, p4, [x25, xzr, lsl #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: st4d {z1.d, z2.d, z3.d, z4.d}, p4, [x25, xzr, lsl #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
st4d {z19.d, z20.d, z21.d, z22.d}, p8, [x21, #14, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st4d {z19.d, z20.d, z21.d, z22.d}, p8, [x21, #14, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 28].
st4d {z28.d, z29.d, z30.d, z31.d}, p6, [x12, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: st4d {z28.d, z29.d, z30.d, z31.d}, p6, [x12, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 28].
st4d {z29.d, z30.d, z31.d, z0.d}, p1, [x10, #29, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: st4d {z29.d, z30.d, z31.d, z0.d}, p1, [x10, #29, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

