// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// Immediate not compatible with encode/decode function.
dupm z30.d, #3008
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or logical immediate
// CHECK-NEXT: dupm z30.d, #3008
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dupm z0.d, #3520
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or logical immediate
// CHECK-NEXT: dupm z0.d, #3520
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dupm z12.d, #3776
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or logical immediate
// CHECK-NEXT: dupm z12.d, #3776
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

// Immediate not compatible with encode/decode function.
dupm z20.d, #3904
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: expected compatible register or logical immediate
// CHECK-NEXT: dupm z20.d, #3904
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:

