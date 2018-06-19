// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Invalid element kind.
tbl z8.h, z15.h, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: tbl z8.h, z15.h, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
tbl z24.h, z21.h, z18.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: tbl z24.h, z21.h, z18.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

