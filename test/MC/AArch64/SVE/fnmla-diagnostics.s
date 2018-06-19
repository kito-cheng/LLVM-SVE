// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
fnmla z1.h, p8/m, z15.h, z26.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fnmla z1.h, p8/m, z15.h, z26.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fnmla z24.s, p8/m, z6.s, z10.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fnmla z24.s, p8/m, z6.s, z10.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

