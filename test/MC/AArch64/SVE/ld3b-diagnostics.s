// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld3b {z17.b, z18.b, z19.b}, p2/z, [x1, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld3b {z17.b, z18.b, z19.b}, p2/z, [x1, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld3b {z2.b, z3.b, z4.b}, p8/z, [x11, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld3b {z2.b, z3.b, z4.b}, p8/z, [x11, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-24, 21].
ld3b {z10.b, z11.b, z12.b}, p6/z, [x15, #-25, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: ld3b {z10.b, z11.b, z12.b}, p6/z, [x15, #-25, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-24, 21].
ld3b {z23.b, z24.b, z25.b}, p6/z, [x5, #22, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: ld3b {z23.b, z24.b, z25.b}, p6/z, [x5, #22, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

