// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
fcmuo p13.h, p8/z, z9.h, z27.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmuo p13.h, p8/z, z9.h, z27.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fcmuo p9.s, p8/z, z30.s, z15.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fcmuo p9.s, p8/z, z30.s, z15.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

