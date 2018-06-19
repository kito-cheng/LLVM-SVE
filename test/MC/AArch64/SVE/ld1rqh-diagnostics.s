// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [-128, 112].
ld1rqh z1.h, p4/z, [x7, #-129]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 16 in range [-128, 112].
// CHECK-NEXT: ld1rqh z1.h, p4/z, [x7, #-129]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 112].
ld1rqh z29.h, p0/z, [x24, #113]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 16 in range [-128, 112].
// CHECK-NEXT: ld1rqh z29.h, p0/z, [x24, #113]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rqh z26.h, p8/z, [x21, x27, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rqh z26.h, p8/z, [x21, x27, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
ld1rqh z25.h, p0/z, [x0, xzr, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1rqh z25.h, p0/z, [x0, xzr, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

