// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
fcmlt p0.h, p8/z, z23.h, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmlt p0.h, p8/z, z23.h, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fcmlt p11.s, p8/z, z27.s, #0.0
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmlt p11.s, p8/z, z27.s, #0.0
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

