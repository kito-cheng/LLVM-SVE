// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
fmsb z18.h, p8/m, z1.h, z7.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fmsb z18.h, p8/m, z1.h, z7.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fmsb z3.s, p8/m, z21.s, z8.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fmsb z3.s, p8/m, z21.s, z8.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

