// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
st4h {z5.h, z6.h, z7.h, z8.h}, p6, [x20, xzr, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: st4h {z5.h, z6.h, z7.h, z8.h}, p6, [x20, xzr, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
st4h {z8.h, z9.h, z10.h, z11.h}, p8, [x11, #9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st4h {z8.h, z9.h, z10.h, z11.h}, p8, [x11, #9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 28].
st4h {z18.h, z19.h, z20.h, z21.h}, p2, [x13, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: st4h {z18.h, z19.h, z20.h, z21.h}, p2, [x13, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 28].
st4h {z4.h, z5.h, z6.h, z7.h}, p1, [x11, #29, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: st4h {z4.h, z5.h, z6.h, z7.h}, p1, [x11, #29, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

