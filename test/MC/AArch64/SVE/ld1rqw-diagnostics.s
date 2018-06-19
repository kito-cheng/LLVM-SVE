// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [-128, 112].
ld1rqw z12.s, p2/z, [x12, #-129]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 16 in range [-128, 112].
// CHECK-NEXT: ld1rqw z12.s, p2/z, [x12, #-129]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-128, 112].
ld1rqw z21.s, p4/z, [x13, #113]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 16 in range [-128, 112].
// CHECK-NEXT: ld1rqw z21.s, p4/z, [x13, #113]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1rqw z7.s, p8/z, [x13, x10, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1rqw z7.s, p8/z, [x13, x10, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
ld1rqw z4.s, p4/z, [x19, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1rqw z4.s, p4/z, [x19, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

