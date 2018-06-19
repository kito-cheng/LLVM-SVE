// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
st3h {z9.h, z10.h, z11.h}, p6, [x16, xzr, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: st3h {z9.h, z10.h, z11.h}, p6, [x16, xzr, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
st3h {z25.h, z26.h, z27.h}, p8, [x18, #2, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st3h {z25.h, z26.h, z27.h}, p8, [x18, #2, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-24, 21].
st3h {z21.h, z22.h, z23.h}, p3, [x0, #-25, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: st3h {z21.h, z22.h, z23.h}, p3, [x0, #-25, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-24, 21].
st3h {z15.h, z16.h, z17.h}, p5, [x1, #22, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: st3h {z15.h, z16.h, z17.h}, p5, [x1, #22, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

