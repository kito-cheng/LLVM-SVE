// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld1w z28.s, p6/z, [x10, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1w z28.s, p6/z, [x10, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z25.s, p8/z, [x29, #11, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z25.s, p8/z, [x29, #11, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ld1w z30.s, p2/z, [x5, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1w z30.s, p2/z, [x5, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ld1w z6.s, p1/z, [x9, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1w z6.s, p1/z, [x9, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z10.s, p8/z, [x6, z8.s, uxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z10.s, p8/z, [x6, z8.s, uxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z14.s, p8/z, [z14.s, #29]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z14.s, p8/z, [z14.s, #29]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 124].
ld1w z28.s, p2/z, [z9.s, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 124].
// CHECK-NEXT: ld1w z28.s, p2/z, [z9.s, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 124].
ld1w z29.s, p6/z, [z1.s, #125]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 124].
// CHECK-NEXT: ld1w z29.s, p6/z, [z1.s, #125]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z9.s, p8/z, [x7, z26.s, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z9.s, p8/z, [x7, z26.s, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z2.s, p8/z, [x1, z20.s, sxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z2.s, p8/z, [x1, z20.s, sxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z25.s, p8/z, [x27, z4.s, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z25.s, p8/z, [x27, z4.s, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z0.d, p8/z, [x26, x1, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z0.d, p8/z, [x26, x1, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
ld1w z8.d, p3/z, [x6, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1w z8.d, p3/z, [x6, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z27.d, p8/z, [x16, #1, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z27.d, p8/z, [x16, #1, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ld1w z16.d, p6/z, [x7, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1w z16.d, p6/z, [x7, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ld1w z8.d, p3/z, [x28, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1w z8.d, p3/z, [x28, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z6.d, p8/z, [x21, z14.d, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z6.d, p8/z, [x21, z14.d, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z0.d, p8/z, [z16.d, #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z0.d, p8/z, [z16.d, #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 124].
ld1w z9.d, p1/z, [z16.d, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 124].
// CHECK-NEXT: ld1w z9.d, p1/z, [z16.d, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 124].
ld1w z20.d, p2/z, [z29.d, #125]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 124].
// CHECK-NEXT: ld1w z20.d, p2/z, [z29.d, #125]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z9.d, p8/z, [x14, z22.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z9.d, p8/z, [x14, z22.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z27.d, p8/z, [x13, z25.d, sxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z27.d, p8/z, [x13, z25.d, sxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z15.d, p8/z, [x28, z24.d, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z15.d, p8/z, [x28, z24.d, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z9.d, p8/z, [x10, z17.d, uxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z9.d, p8/z, [x10, z17.d, uxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1w z17.d, p8/z, [x6, z27.d, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1w z17.d, p8/z, [x6, z27.d, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

