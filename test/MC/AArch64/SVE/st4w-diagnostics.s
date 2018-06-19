// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
st4w {z18.s, z19.s, z20.s, z21.s}, p6, [x18, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: st4w {z18.s, z19.s, z20.s, z21.s}, p6, [x18, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
st4w {z17.s, z18.s, z19.s, z20.s}, p8, [x24, #12, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st4w {z17.s, z18.s, z19.s, z20.s}, p8, [x24, #12, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 28].
st4w {z4.s, z5.s, z6.s, z7.s}, p6, [x1, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: st4w {z4.s, z5.s, z6.s, z7.s}, p6, [x1, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 28].
st4w {z27.s, z28.s, z29.s, z30.s}, p4, [x3, #29, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: st4w {z27.s, z28.s, z29.s, z30.s}, p4, [x3, #29, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

