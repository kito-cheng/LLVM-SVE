// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
st2w {z29.s, z30.s}, p0, [x6, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: st2w {z29.s, z30.s}, p0, [x6, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
st2w {z9.s, z10.s}, p8, [x19, #3, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: st2w {z9.s, z10.s}, p8, [x19, #3, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 14].
st2w {z2.s, z3.s}, p3, [x17, #-17, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: st2w {z2.s, z3.s}, p3, [x17, #-17, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 14].
st2w {z12.s, z13.s}, p1, [x24, #15, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: st2w {z12.s, z13.s}, p1, [x24, #15, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

