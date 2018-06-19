// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate out of lower bound [-8, 7].
ldnf1w z15.s, p3/z, [x23, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ldnf1w z15.s, p3/z, [x23, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ldnf1w z2.s, p2/z, [x3, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ldnf1w z2.s, p2/z, [x3, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ldnf1w z25.d, p8/z, [x17, #9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ldnf1w z25.d, p8/z, [x17, #9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-8, 7].
ldnf1w z18.d, p1/z, [x10, #-9, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ldnf1w z18.d, p1/z, [x10, #-9, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-8, 7].
ldnf1w z18.d, p1/z, [x3, #8, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be an integer in range [-8, 7].
// CHECK-NEXT: ldnf1w z18.d, p1/z, [x3, #8, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

