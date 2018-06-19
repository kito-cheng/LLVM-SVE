// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [-128, 112].
ld1rqb z10.b, p3/z, [x19, #-129]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 16 in range [-128, 112].
// CHECK-NEXT: ld1rqb z10.b, p3/z, [x19, #-129]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 112].
ld1rqb z7.b, p3/z, [x28, #113]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 16 in range [-128, 112].
// CHECK-NEXT: ld1rqb z7.b, p3/z, [x28, #113]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rqb z17.b, p8/z, [x0, x5]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rqb z17.b, p8/z, [x0, x5]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
ld1rqb z17.b, p2/z, [x22, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1rqb z17.b, p2/z, [x22, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

