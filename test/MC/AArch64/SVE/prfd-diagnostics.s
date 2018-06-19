// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [0, 248].
prfd pldl3strm, p1, [z19.s, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 8 in range [0, 248].
// CHECK-NEXT: prfd pldl3strm, p1, [z19.s, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 248].
prfd pstl2strm, p3, [z9.s, #249]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 8 in range [0, 248].
// CHECK-NEXT: prfd pstl2strm, p3, [z9.s, #249]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfd pldl1strm, p8, [x14, z14.s, sxtw #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfd pldl1strm, p8, [x14, z14.s, sxtw #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfd pldl3keep, p8, [x29, z24.s, uxtw #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfd pldl3keep, p8, [x29, z24.s, uxtw #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfd pldl1keep, p8, [x29, x18, lsl #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfd pldl1keep, p8, [x29, x18, lsl #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Offset register Rm cannot be xzr
prfd pstl1strm, p6, [x21, xzr, lsl #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: prfd pstl1strm, p6, [x21, xzr, lsl #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfd pldl3strm, p8, [x14, #4, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfd pldl3strm, p8, [x14, #4, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 31].
prfd pstl3keep, p3, [x25, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-32, 31].
// CHECK-NEXT: prfd pstl3keep, p3, [x25, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 31].
prfd #14, p1, [x12, #32, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-32, 31].
// CHECK-NEXT: prfd #14, p1, [x12, #32, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfd pldl2strm, p8, [x27, z2.d, lsl #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfd pldl2strm, p8, [x27, z2.d, lsl #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfd pstl3keep, p8, [z21.d, #30]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfd pstl3keep, p8, [z21.d, #30]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 248].
prfd pstl1strm, p1, [z28.d, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 8 in range [0, 248].
// CHECK-NEXT: prfd pstl1strm, p1, [z28.d, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 248].
prfd pldl3strm, p1, [z17.d, #249]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 8 in range [0, 248].
// CHECK-NEXT: prfd pldl3strm, p1, [z17.d, #249]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfd #6, p8, [x25, z28.d, sxtw #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfd #6, p8, [x25, z28.d, sxtw #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
prfd pldl1strm, p8, [x11, z10.d, uxtw #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: prfd pldl1strm, p8, [x11, z10.d, uxtw #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

