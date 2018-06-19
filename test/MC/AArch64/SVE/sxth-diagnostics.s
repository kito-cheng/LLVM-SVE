// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
sxth z0.d, p8/m, z25.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: sxth z0.d, p8/m, z25.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

