// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of upper bound [0, 1].
fmls z23.d, z28.d, z9.d[2]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 1].
// CHECK-NEXT: fmls z23.d, z28.d, z9.d[2]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fmls z9.d, p8/m, z30.d, z13.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fmls z9.d, p8/m, z30.d, z13.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 7].
fmls z28.h, z22.h, z2.h[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 7].
// CHECK-NEXT: fmls z28.h, z22.h, z2.h[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 7].
fmls z9.h, z23.h, z2.h[8]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 7].
// CHECK-NEXT: fmls z9.h, z23.h, z2.h[8]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fmls z15.h, p8/m, z16.h, z30.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fmls z15.h, p8/m, z16.h, z30.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [0, 3].
fmls z16.s, z14.s, z1.s[-1]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 3].
// CHECK-NEXT: fmls z16.s, z14.s, z1.s[-1]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [0, 3].
fmls z8.s, z3.s, z6.s[4]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: vector lane must be an integer in range [0, 3].
// CHECK-NEXT: fmls z8.s, z3.s, z6.s[4]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fmls z2.s, p8/m, z6.s, z29.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fmls z2.s, p8/m, z6.s, z29.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

