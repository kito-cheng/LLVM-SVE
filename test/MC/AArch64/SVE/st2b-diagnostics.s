// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
st2b {z20.b, z21.b}, p2, [x28, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: st2b {z20.b, z21.b}, p2, [x28, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
st2b {z24.b, z25.b}, p8, [x29, #0, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st2b {z24.b, z25.b}, p8, [x29, #0, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 14].
st2b {z15.b, z16.b}, p3, [x27, #-17, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: st2b {z15.b, z16.b}, p3, [x27, #-17, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 14].
st2b {z1.b, z2.b}, p6, [x16, #15, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: st2b {z1.b, z2.b}, p6, [x16, #15, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

