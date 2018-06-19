// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld3w {z25.s, z26.s, z27.s}, p1/z, [x10, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld3w {z25.s, z26.s, z27.s}, p1/z, [x10, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld3w {z8.s, z9.s, z10.s}, p8/z, [x21, #14, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld3w {z8.s, z9.s, z10.s}, p8/z, [x21, #14, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-24, 21].
ld3w {z30.s, z31.s, z0.s}, p2/z, [x18, #-25, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: ld3w {z30.s, z31.s, z0.s}, p2/z, [x18, #-25, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-24, 21].
ld3w {z24.s, z25.s, z26.s}, p3/z, [x9, #22, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 3 in range [-24, 21].
// CHECK-NEXT: ld3w {z24.s, z25.s, z26.s}, p3/z, [x9, #22, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

