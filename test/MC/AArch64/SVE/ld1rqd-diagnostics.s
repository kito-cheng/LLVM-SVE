// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [-128, 112].
ld1rqd z28.d, p0/z, [x0, #-129]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 16 in range [-128, 112].
// CHECK-NEXT: ld1rqd z28.d, p0/z, [x0, #-129]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 112].
ld1rqd z8.d, p0/z, [x16, #113]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 16 in range [-128, 112].
// CHECK-NEXT: ld1rqd z8.d, p0/z, [x16, #113]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rqd z5.d, p8/z, [x3, x13, lsl #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rqd z5.d, p8/z, [x3, x13, lsl #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
ld1rqd z18.d, p4/z, [x29, xzr, lsl #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1rqd z18.d, p4/z, [x29, xzr, lsl #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

