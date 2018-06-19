// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
fnmsb z7.h, p8/m, z12.h, z8.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fnmsb z7.h, p8/m, z12.h, z8.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fnmsb z30.s, p8/m, z29.s, z11.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fnmsb z30.s, p8/m, z29.s, z11.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

