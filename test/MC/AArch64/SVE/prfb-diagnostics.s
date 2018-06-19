// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 31].
prfb #14, p2, [z17.s, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: prfb #14, p2, [z17.s, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 31].
prfb #7, p1, [z23.s, #32]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: prfb #7, p1, [z23.s, #32]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfb pldl2strm, p8, [x12, z26.s, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfb pldl2strm, p8, [x12, z26.s, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfb pldl3keep, p8, [x25, z0.s, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfb pldl3keep, p8, [x25, z0.s, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfb pstl3strm, p8, [x26, z17.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfb pstl3strm, p8, [x26, z17.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfb pldl1strm, p8, [z1.d, #5]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfb pldl1strm, p8, [z1.d, #5]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 31].
prfb #6, p6, [z21.d, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: prfb #6, p6, [z21.d, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 31].
prfb pldl2keep, p6, [z20.d, #32]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: prfb pldl2keep, p6, [z20.d, #32]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfb pstl3keep, p8, [x29, z3.d, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfb pstl3keep, p8, [x29, z3.d, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfb pldl2keep, p8, [x9, z18.d, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfb pldl2keep, p8, [x9, z18.d, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfb pldl2keep, p8, [x18, x3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfb pldl2keep, p8, [x18, x3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
prfb pstl3strm, p6, [x15, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: prfb pstl3strm, p6, [x15, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfb pstl2keep, p8, [x13, #3, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfb pstl2keep, p8, [x13, #3, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 31].
prfb pldl1strm, p2, [x4, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-32, 31].
// CHECK-NEXT: prfb pldl1strm, p2, [x4, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 31].
prfb pldl2keep, p3, [x3, #32, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-32, 31].
// CHECK-NEXT: prfb pldl2keep, p3, [x3, #32, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

