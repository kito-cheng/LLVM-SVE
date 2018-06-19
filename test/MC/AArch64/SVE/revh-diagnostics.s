// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
revh z28.d, p8/m, z29.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: revh z28.d, p8/m, z29.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

