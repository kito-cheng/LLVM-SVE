// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
fnmad z23.h, p8/m, z26.h, z10.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fnmad z23.h, p8/m, z26.h, z10.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fnmad z27.s, p8/m, z21.s, z29.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fnmad z27.s, p8/m, z21.s, z29.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

