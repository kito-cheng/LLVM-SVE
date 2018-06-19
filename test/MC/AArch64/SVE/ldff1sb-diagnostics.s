// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
ldff1sb z19.s, p8/z, [x18, x10]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sb z19.s, p8/z, [x18, x10]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1sb z13.s, p8/z, [z19.s, #8]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sb z13.s, p8/z, [z19.s, #8]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 31].
ldff1sb z23.s, p1/z, [z19.s, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: ldff1sb z23.s, p1/z, [z19.s, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 31].
ldff1sb z0.s, p4/z, [z26.s, #32]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: ldff1sb z0.s, p4/z, [z26.s, #32]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1sb z6.s, p8/z, [x15, z24.s, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sb z6.s, p8/z, [x15, z24.s, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1sb z9.s, p8/z, [x18, z9.s, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sb z9.s, p8/z, [x18, z9.s, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1sb z16.d, p8/z, [x27, x15]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sb z16.d, p8/z, [x27, x15]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1sb z7.d, p8/z, [z12.d, #11]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sb z7.d, p8/z, [z12.d, #11]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 31].
ldff1sb z24.d, p4/z, [z19.d, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: ldff1sb z24.d, p4/z, [z19.d, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 31].
ldff1sb z11.d, p0/z, [z5.d, #32]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: immediate must be an integer in range [0, 31].
// CHECK-NEXT: ldff1sb z11.d, p0/z, [z5.d, #32]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1sb z6.d, p8/z, [x5, z6.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sb z6.d, p8/z, [x5, z6.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1sb z9.d, p8/z, [x2, z15.d, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sb z9.d, p8/z, [x2, z15.d, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1sb z23.d, p8/z, [x5, z2.d, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1sb z23.d, p8/z, [x5, z2.d, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

