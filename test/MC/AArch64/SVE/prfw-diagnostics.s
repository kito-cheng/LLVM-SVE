// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
prfw pstl3keep, p0, [x21, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: prfw pstl3keep, p0, [x21, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfw pstl1keep, p8, [x7, #24, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfw pstl1keep, p8, [x7, #24, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 31].
prfw pldl2strm, p1, [x0, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-32, 31].
// CHECK-NEXT: prfw pldl2strm, p1, [x0, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 31].
prfw pstl2keep, p0, [x28, #32, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-32, 31].
// CHECK-NEXT: prfw pstl2keep, p0, [x28, #32, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfw pldl3strm, p8, [z6.s, #25]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfw pldl3strm, p8, [z6.s, #25]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 124].
prfw #6, p0, [z10.s, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 124].
// CHECK-NEXT: prfw #6, p0, [z10.s, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 124].
prfw pstl1keep, p1, [z0.s, #125]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 124].
// CHECK-NEXT: prfw pstl1keep, p1, [z0.s, #125]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfw pstl2strm, p8, [x23, z8.s, sxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfw pstl2strm, p8, [x23, z8.s, sxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfw pstl2keep, p8, [x5, z25.s, uxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfw pstl2keep, p8, [x5, z25.s, uxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfw pldl1strm, p8, [x27, z20.d, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfw pldl1strm, p8, [x27, z20.d, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfw pldl2keep, p8, [z10.d, #25]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfw pldl2keep, p8, [z10.d, #25]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 124].
prfw pldl2strm, p2, [z16.d, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 124].
// CHECK-NEXT: prfw pldl2strm, p2, [z16.d, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 124].
prfw pldl3keep, p6, [z11.d, #125]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 124].
// CHECK-NEXT: prfw pldl3keep, p6, [z11.d, #125]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfw #15, p8, [x4, z16.d, sxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfw #15, p8, [x4, z16.d, sxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfw #6, p8, [x5, z11.d, uxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfw #6, p8, [x5, z11.d, uxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

