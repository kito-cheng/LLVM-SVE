// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld4d {z0.d, z1.d, z2.d, z3.d}, p3/z, [x15, xzr, lsl #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld4d {z0.d, z1.d, z2.d, z3.d}, p3/z, [x15, xzr, lsl #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld4d {z20.d, z21.d, z22.d, z23.d}, p8/z, [x6, #10, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld4d {z20.d, z21.d, z22.d, z23.d}, p8/z, [x6, #10, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 28].
ld4d {z21.d, z22.d, z23.d, z24.d}, p2/z, [x18, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: ld4d {z21.d, z22.d, z23.d, z24.d}, p2/z, [x18, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 28].
ld4d {z16.d, z17.d, z18.d, z19.d}, p1/z, [x30, #29, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: ld4d {z16.d, z17.d, z18.d, z19.d}, p1/z, [x30, #29, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

