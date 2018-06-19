// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
st3b {z3.b, z4.b, z5.b}, p2, [x13, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: st3b {z3.b, z4.b, z5.b}, p2, [x13, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
st3b {z1.b, z2.b, z3.b}, p8, [x23, #10, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st3b {z1.b, z2.b, z3.b}, p8, [x23, #10, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-24, 21].
st3b {z4.b, z5.b, z6.b}, p4, [x21, #-25, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: st3b {z4.b, z5.b, z6.b}, p4, [x21, #-25, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-24, 21].
st3b {z17.b, z18.b, z19.b}, p1, [x27, #22, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: st3b {z17.b, z18.b, z19.b}, p1, [x27, #22, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

