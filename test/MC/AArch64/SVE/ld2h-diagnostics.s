// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld2h {z25.h, z26.h}, p6/z, [x4, xzr, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld2h {z25.h, z26.h}, p6/z, [x4, xzr, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld2h {z6.h, z7.h}, p8/z, [x12, #5, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld2h {z6.h, z7.h}, p8/z, [x12, #5, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-16, 14].
ld2h {z1.h, z2.h}, p4/z, [x5, #-17, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: ld2h {z1.h, z2.h}, p4/z, [x5, #-17, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-16, 14].
ld2h {z14.h, z15.h}, p4/z, [x1, #15, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [-16, 14].
// CHECK-NEXT: ld2h {z14.h, z15.h}, p4/z, [x1, #15, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

