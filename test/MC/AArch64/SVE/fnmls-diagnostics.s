// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
fnmls z19.h, p8/m, z28.h, z27.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fnmls z19.h, p8/m, z28.h, z27.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fnmls z12.s, p8/m, z28.s, z13.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fnmls z12.s, p8/m, z28.s, z13.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

