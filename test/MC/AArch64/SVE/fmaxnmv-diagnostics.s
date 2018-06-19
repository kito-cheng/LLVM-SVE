// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
fmaxnmv h21, p8, z21.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fmaxnmv h21, p8, z21.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fmaxnmv s8, p8, z27.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fmaxnmv s8, p8, z27.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

