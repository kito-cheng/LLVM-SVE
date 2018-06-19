// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Offset register Rm cannot be xzr
ld4b {z25.b, z26.b, z27.b, z28.b}, p2/z, [x11, xzr]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: {{(error\:\ index\ must\ be\ an\ integer\ in\ range)|(error\:\ index\ must\ be\ a\ multiple\ of)}}
// CHECK-NEXT: ld4b {z25.b, z26.b, z27.b, z28.b}, p2/z, [x11, xzr]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// error: restricted predicate has range [0, 7].
ld4b {z9.b, z10.b, z11.b, z12.b}, p8/z, [x11, #12, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: restricted predicate has range [0, 7].
// CHECK-NEXT: ld4b {z9.b, z10.b, z11.b, z12.b}, p8/z, [x11, #12, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of lower bound [-32, 28].
ld4b {z16.b, z17.b, z18.b, z19.b}, p2/z, [x28, #-33, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: ld4b {z16.b, z17.b, z18.b, z19.b}, p2/z, [x28, #-33, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate out of upper bound [-32, 28].
ld4b {z29.b, z30.b, z31.b, z0.b}, p5/z, [x4, #29, MUL VL]
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: index must be a multiple of 4 in range [-32, 28].
// CHECK-NEXT: ld4b {z29.b, z30.b, z31.b, z0.b}, p5/z, [x4, #29, MUL VL]
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

