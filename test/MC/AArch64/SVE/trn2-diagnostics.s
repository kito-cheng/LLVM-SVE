// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Invalid element kind.
trn2 z12.h, z17.h, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: trn2 z12.h, z17.h, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
trn2 z6.h, z16.h, z10.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: trn2 z6.h, z16.h, z10.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

