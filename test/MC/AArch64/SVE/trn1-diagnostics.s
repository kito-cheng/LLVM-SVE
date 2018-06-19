// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Invalid element kind.
trn1 z23.h, z5.h, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: trn1 z23.h, z5.h, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
trn1 z4.h, z15.h, z23.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: trn1 z4.h, z15.h, z23.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

