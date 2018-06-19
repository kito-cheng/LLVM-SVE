// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
st3w {z21.s, z22.s, z23.s}, p5, [x21, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: st3w {z21.s, z22.s, z23.s}, p5, [x21, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
st3w {z8.s, z9.s, z10.s}, p8, [x27, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st3w {z8.s, z9.s, z10.s}, p8, [x27, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-24, 21].
st3w {z3.s, z4.s, z5.s}, p4, [x3, #-25, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: st3w {z3.s, z4.s, z5.s}, p4, [x3, #-25, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-24, 21].
st3w {z1.s, z2.s, z3.s}, p5, [x14, #22, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: st3w {z1.s, z2.s, z3.s}, p5, [x14, #22, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

