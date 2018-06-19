// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld2w {z10.s, z11.s}, p6/z, [x8, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld2w {z10.s, z11.s}, p6/z, [x8, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld2w {z4.s, z5.s}, p8/z, [x7, #2, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld2w {z4.s, z5.s}, p8/z, [x7, #2, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 14].
ld2w {z8.s, z9.s}, p4/z, [x26, #-17, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: ld2w {z8.s, z9.s}, p4/z, [x26, #-17, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 14].
ld2w {z6.s, z7.s}, p1/z, [x22, #15, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: ld2w {z6.s, z7.s}, p1/z, [x22, #15, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

