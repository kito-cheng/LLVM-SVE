// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// error: restricted predicate has range [0, 7].
ldnt1h z10.h, p8/z, [x8, #9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldnt1h z10.h, p8/z, [x8, #9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ldnt1h z3.h, p6/z, [x7, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ldnt1h z3.h, p6/z, [x7, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ldnt1h z20.h, p0/z, [x18, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ldnt1h z20.h, p0/z, [x18, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

