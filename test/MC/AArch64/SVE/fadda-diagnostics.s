// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Source and Destination Registers must match
fadda d27, p1, d28, z21.d
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fadda d27, p1, d28, z21.d
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fadda h22, p8, h22, z18.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fadda h22, p8, h22, z18.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fadda h12, p0, h13, z22.h
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fadda h12, p0, h13, z22.h
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
fadda s23, p8, s23, z30.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: fadda s23, p8, s23, z30.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Source and Destination Registers must match
fadda s18, p3, s19, z29.s
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: operand must match destination register
// CHECK-NEXT: fadda s18, p3, s19, z29.s
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

