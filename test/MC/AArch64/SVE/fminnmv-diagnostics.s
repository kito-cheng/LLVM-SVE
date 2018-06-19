// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
fminnmv h14, p8, z19.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fminnmv h14, p8, z19.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fminnmv s14, p8, z11.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fminnmv s14, p8, z11.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

