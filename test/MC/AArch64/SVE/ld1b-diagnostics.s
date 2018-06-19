// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld1b z14.h, p4/z, [x14, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1b z14.h, p4/z, [x14, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z9.h, p8/z, [x25, #9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z9.h, p8/z, [x25, #9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ld1b z21.h, p4/z, [x17, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1b z21.h, p4/z, [x17, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ld1b z10.h, p5/z, [x16, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1b z10.h, p5/z, [x16, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z27.s, p8/z, [x18, x29]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z27.s, p8/z, [x18, x29]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
ld1b z23.s, p1/z, [x17, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1b z23.s, p1/z, [x17, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z12.s, p8/z, [x13, #2, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z12.s, p8/z, [x13, #2, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ld1b z30.s, p6/z, [x25, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1b z30.s, p6/z, [x25, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ld1b z29.s, p5/z, [x15, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1b z29.s, p5/z, [x15, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z5.s, p8/z, [z22.s, #24]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z5.s, p8/z, [z22.s, #24]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 31].
ld1b z20.s, p6/z, [z3.s, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: ld1b z20.s, p6/z, [z3.s, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 31].
ld1b z20.s, p4/z, [z9.s, #32]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: ld1b z20.s, p4/z, [z9.s, #32]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z12.s, p8/z, [x3, z13.s, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z12.s, p8/z, [x3, z13.s, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z24.s, p8/z, [x21, z20.s, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z24.s, p8/z, [x21, z20.s, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z9.d, p8/z, [x25, x14]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z9.d, p8/z, [x25, x14]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
ld1b z17.d, p2/z, [x27, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1b z17.d, p2/z, [x27, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z4.d, p8/z, [x11, #2, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z4.d, p8/z, [x11, #2, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ld1b z28.d, p2/z, [x28, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1b z28.d, p2/z, [x28, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ld1b z27.d, p1/z, [x26, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1b z27.d, p1/z, [x26, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z29.d, p8/z, [z10.d, #24]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z29.d, p8/z, [z10.d, #24]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 31].
ld1b z23.d, p5/z, [z6.d, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: ld1b z23.d, p5/z, [z6.d, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 31].
ld1b z9.d, p4/z, [z13.d, #32]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: ld1b z9.d, p4/z, [z13.d, #32]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z17.d, p8/z, [x3, z14.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z17.d, p8/z, [x3, z14.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z29.d, p8/z, [x15, z4.d, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z29.d, p8/z, [x15, z4.d, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z9.d, p8/z, [x9, z3.d, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z9.d, p8/z, [x9, z3.d, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z9.b, p8/z, [x23, x6]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z9.b, p8/z, [x23, x6]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
ld1b z29.b, p6/z, [x3, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1b z29.b, p6/z, [x3, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1b z3.b, p8/z, [x7, #11, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1b z3.b, p8/z, [x7, #11, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ld1b z20.b, p5/z, [x8, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1b z20.b, p5/z, [x8, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ld1b z25.b, p3/z, [x11, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1b z25.b, p3/z, [x11, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

