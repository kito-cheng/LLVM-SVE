// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
st4b {z28.b, z29.b, z30.b, z31.b}, p2, [x26, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: st4b {z28.b, z29.b, z30.b, z31.b}, p2, [x26, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
st4b {z2.b, z3.b, z4.b, z5.b}, p8, [x2, #3, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st4b {z2.b, z3.b, z4.b, z5.b}, p8, [x2, #3, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 28].
st4b {z10.b, z11.b, z12.b, z13.b}, p5, [x25, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: st4b {z10.b, z11.b, z12.b, z13.b}, p5, [x25, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 28].
st4b {z8.b, z9.b, z10.b, z11.b}, p5, [x5, #29, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: st4b {z8.b, z9.b, z10.b, z11.b}, p5, [x5, #29, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

