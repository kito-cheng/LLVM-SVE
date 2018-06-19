// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
ldff1d z12.d, p8/z, [x16, z8.d, lsl #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1d z12.d, p8/z, [x16, z8.d, lsl #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1d z12.d, p8/z, [z6.d, #27]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1d z12.d, p8/z, [z6.d, #27]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 248].
ldff1d z7.d, p1/z, [z11.d, #-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 8 in range [0, 248].
// CHECK-NEXT: ldff1d z7.d, p1/z, [z11.d, #-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 248].
ldff1d z13.d, p5/z, [z8.d, #249]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 8 in range [0, 248].
// CHECK-NEXT: ldff1d z13.d, p5/z, [z8.d, #249]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1d z23.d, p8/z, [x8, z17.d]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1d z23.d, p8/z, [x8, z17.d]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1d z28.d, p8/z, [x3, z3.d, sxtw #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1d z28.d, p8/z, [x3, z3.d, sxtw #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1d z22.d, p8/z, [x26, z10.d, sxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1d z22.d, p8/z, [x26, z10.d, sxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1d z21.d, p8/z, [x19, z23.d, uxtw #3]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1d z21.d, p8/z, [x19, z23.d, uxtw #3]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldff1d z15.d, p8/z, [x29, z4.d, uxtw]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldff1d z15.d, p8/z, [x29, z4.d, uxtw]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

