// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld3h {z21.h, z22.h, z23.h}, p0/z, [x4, xzr, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld3h {z21.h, z22.h, z23.h}, p0/z, [x4, xzr, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld3h {z28.h, z29.h, z30.h}, p8/z, [x16, #5, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld3h {z28.h, z29.h, z30.h}, p8/z, [x16, #5, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-24, 21].
ld3h {z23.h, z24.h, z25.h}, p0/z, [x17, #-25, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: ld3h {z23.h, z24.h, z25.h}, p0/z, [x17, #-25, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-24, 21].
ld3h {z23.h, z24.h, z25.h}, p2/z, [x9, #22, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: ld3h {z23.h, z24.h, z25.h}, p2/z, [x9, #22, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

