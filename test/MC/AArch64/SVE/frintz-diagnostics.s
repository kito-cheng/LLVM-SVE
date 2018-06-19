// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
frintz z26.h, p8/m, z4.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: frintz z26.h, p8/m, z4.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
frintz z11.s, p8/m, z5.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: frintz z11.s, p8/m, z5.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

