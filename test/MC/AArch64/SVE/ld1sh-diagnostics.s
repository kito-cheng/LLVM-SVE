// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld1sh z30.s, p4/z, [x5, xzr, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1sh z30.s, p4/z, [x5, xzr, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z27.s, p8/z, [x2, #0, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z27.s, p8/z, [x2, #0, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ld1sh z3.s, p3/z, [x15, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1sh z3.s, p3/z, [x15, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ld1sh z14.s, p3/z, [x22, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1sh z14.s, p3/z, [x22, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z7.s, p8/z, [x3, z18.s, uxtw #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z7.s, p8/z, [x3, z18.s, uxtw #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z0.s, p8/z, [z15.s, #28]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z0.s, p8/z, [z15.s, #28]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 62].
ld1sh z9.s, p4/z, [z2.s, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 62].
// CHECK-NEXT: ld1sh z9.s, p4/z, [z2.s, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 62].
ld1sh z8.s, p4/z, [z23.s, #63]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 62].
// CHECK-NEXT: ld1sh z8.s, p4/z, [z23.s, #63]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z11.s, p8/z, [x23, z21.s, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z11.s, p8/z, [x23, z21.s, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z19.s, p8/z, [x26, z28.s, sxtw #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z19.s, p8/z, [x26, z28.s, sxtw #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z13.s, p8/z, [x12, z13.s, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z13.s, p8/z, [x12, z13.s, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z14.d, p8/z, [x21, x28, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z14.d, p8/z, [x21, x28, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
ld1sh z22.d, p4/z, [x3, xzr, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1sh z22.d, p4/z, [x3, xzr, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z6.d, p8/z, [x3, #2, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z6.d, p8/z, [x3, #2, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ld1sh z17.d, p1/z, [x11, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1sh z17.d, p1/z, [x11, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ld1sh z5.d, p4/z, [x21, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1sh z5.d, p4/z, [x21, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z10.d, p8/z, [x20, z26.d, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z10.d, p8/z, [x20, z26.d, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z20.d, p8/z, [z12.d, #17]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z20.d, p8/z, [z12.d, #17]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 62].
ld1sh z5.d, p4/z, [z30.d, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 62].
// CHECK-NEXT: ld1sh z5.d, p4/z, [z30.d, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 62].
ld1sh z25.d, p4/z, [z21.d, #63]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 62].
// CHECK-NEXT: ld1sh z25.d, p4/z, [z21.d, #63]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z30.d, p8/z, [x2, z25.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z30.d, p8/z, [x2, z25.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z4.d, p8/z, [x17, z29.d, sxtw #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z4.d, p8/z, [x17, z29.d, sxtw #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z19.d, p8/z, [x9, z25.d, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z19.d, p8/z, [x9, z25.d, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z11.d, p8/z, [x16, z1.d, uxtw #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z11.d, p8/z, [x16, z1.d, uxtw #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sh z3.d, p8/z, [x12, z25.d, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sh z3.d, p8/z, [x12, z25.d, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

