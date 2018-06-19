// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
facgt p3.h, p8/z, z11.h, z11.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: facgt p3.h, p8/z, z11.h, z11.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
facgt p13.s, p8/z, z15.s, z19.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: facgt p13.s, p8/z, z15.s, z19.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

