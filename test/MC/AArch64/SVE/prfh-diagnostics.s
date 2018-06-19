// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
prfh #14, p5, [x20, xzr, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: prfh #14, p5, [x20, xzr, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfh pstl2strm, p8, [x22, #58, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfh pstl2strm, p8, [x22, #58, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 31].
prfh pldl1strm, p6, [x21, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-32, 31].
// CHECK-NEXT: prfh pldl1strm, p6, [x21, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 31].
prfh #7, p3, [x7, #32, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-32, 31].
// CHECK-NEXT: prfh #7, p3, [x7, #32, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfh pldl1strm, p8, [z11.s, #0]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfh pldl1strm, p8, [z11.s, #0]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 62].
prfh pldl1strm, p3, [z19.s, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 62].
// CHECK-NEXT: prfh pldl1strm, p3, [z19.s, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 62].
prfh pstl3keep, p1, [z2.s, #63]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 62].
// CHECK-NEXT: prfh pstl3keep, p1, [z2.s, #63]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfh #15, p8, [x8, z0.s, sxtw #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfh #15, p8, [x8, z0.s, sxtw #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfh pstl3strm, p8, [x6, z2.s, uxtw #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfh pstl3strm, p8, [x6, z2.s, uxtw #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfh pstl1keep, p8, [x27, z1.d, lsl #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfh pstl1keep, p8, [x27, z1.d, lsl #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfh pldl2keep, p8, [z8.d, #5]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfh pldl2keep, p8, [z8.d, #5]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 62].
prfh #15, p3, [z4.d, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 62].
// CHECK-NEXT: prfh #15, p3, [z4.d, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 62].
prfh #7, p5, [z23.d, #63]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 2 in range [0, 62].
// CHECK-NEXT: prfh #7, p5, [z23.d, #63]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfh pldl2keep, p8, [x11, z26.d, sxtw #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfh pldl2keep, p8, [x11, z26.d, sxtw #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfh pldl1strm, p8, [x13, z29.d, uxtw #1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfh pldl1strm, p8, [x13, z29.d, uxtw #1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

