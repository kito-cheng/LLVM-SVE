// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld3d {z15.d, z16.d, z17.d}, p4/z, [x20, xzr, lsl #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld3d {z15.d, z16.d, z17.d}, p4/z, [x20, xzr, lsl #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld3d {z20.d, z21.d, z22.d}, p8/z, [x13, #11, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld3d {z20.d, z21.d, z22.d}, p8/z, [x13, #11, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-24, 21].
ld3d {z5.d, z6.d, z7.d}, p2/z, [x22, #-25, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: ld3d {z5.d, z6.d, z7.d}, p2/z, [x22, #-25, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-24, 21].
ld3d {z11.d, z12.d, z13.d}, p2/z, [x9, #22, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: ld3d {z11.d, z12.d, z13.d}, p2/z, [x9, #22, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

