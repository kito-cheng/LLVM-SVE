// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld1sw z24.d, p3/z, [x17, xzr, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld1sw z24.d, p3/z, [x17, xzr, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sw z23.d, p8/z, [x26, #9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sw z23.d, p8/z, [x26, #9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ld1sw z21.d, p4/z, [x21, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1sw z21.d, p4/z, [x21, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ld1sw z23.d, p4/z, [x12, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ld1sw z23.d, p4/z, [x12, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sw z16.d, p8/z, [x29, z3.d, lsl #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sw z16.d, p8/z, [x29, z3.d, lsl #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sw z22.d, p8/z, [z2.d, #9]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sw z22.d, p8/z, [z2.d, #9]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 124].
ld1sw z19.d, p1/z, [z28.d, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 124].
// CHECK-NEXT: ld1sw z19.d, p1/z, [z28.d, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 124].
ld1sw z26.d, p0/z, [z25.d, #125]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [0, 124].
// CHECK-NEXT: ld1sw z26.d, p0/z, [z25.d, #125]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sw z5.d, p8/z, [x15, z21.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sw z5.d, p8/z, [x15, z21.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sw z17.d, p8/z, [x7, z1.d, sxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sw z17.d, p8/z, [x7, z1.d, sxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sw z13.d, p8/z, [x16, z22.d, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sw z13.d, p8/z, [x16, z22.d, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sw z24.d, p8/z, [x14, z9.d, uxtw #2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sw z24.d, p8/z, [x14, z9.d, uxtw #2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld1sw z16.d, p8/z, [x29, z7.d, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld1sw z16.d, p8/z, [x29, z7.d, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

