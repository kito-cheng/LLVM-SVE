// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Invalid element kind.
frecps z13.d, z7.d, z31.x
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: Invalid SVE element size qualifier
// CHECK-NEXT: frecps z13.d, z7.d, z31.x
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Element size specifiers should match.
frecps z24.d, z19.d, z1.b
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: invalid operand
// CHECK-NEXT: frecps z24.d, z19.d, z1.b
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

