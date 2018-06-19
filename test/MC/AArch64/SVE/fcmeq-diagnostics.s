// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
fcmeq p7.d, p8/z, z22.d, z0.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmeq p7.d, p8/z, z22.d, z0.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fcmeq p7.h, p8/z, z3.h, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmeq p7.h, p8/z, z3.h, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fcmeq p6.h, p8/z, z29.h, z21.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmeq p6.h, p8/z, z29.h, z21.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fcmeq p9.s, p8/z, z28.s, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmeq p9.s, p8/z, z28.s, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fcmeq p3.s, p8/z, z23.s, z22.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmeq p3.s, p8/z, z23.s, z22.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

