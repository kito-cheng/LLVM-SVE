// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s | FileCheck %s

// CHECK: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
movprfx z0, z1
add z0.d, z0.d, z0.d

// CHECK: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
movprfx z0.b, p0/m, z1.b
add z0.b, z0.b, z0.b

// CHECK: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
movprfx z0.b, p0/z, z1.b
add z0.b, z0.b, z0.b

// CHECK: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
movprfx z0.h, p0/m, z1.h
add z0.h, z0.h, z0.h

// CHECK: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
movprfx z0.h, p0/z, z1.h
add z0.h, z0.h, z0.h

// CHECK: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
movprfx z0.s, p0/m, z1.s
add z0.s, z0.s, z0.s

// CHECK: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
movprfx z0.s, p0/z, z1.s
add z0.s, z0.d, z0.s

// CHECK: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
movprfx z0.d, p0/m, z1.d
add z0.d, z0.d, z0.d

// CHECK: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
movprfx z0.d, p0/z, z1.d
add z0.d, z0.d, z0.d




// CHECK: error: instruction is unpredictable when following a movprfx writing to a different destination
movprfx z0, z1
add z1.d, z1.d, #1

// CHECK: error: instruction is unpredictable when following a movprfx writing to a different destination
movprfx z0.d, p0/m, z1.d
add z1.d, p0/m, z1.d, z2.d

// CHECK: error: instruction is unpredictable when following a movprfx writing to a different destination
movprfx z0.d, p0/z, z1.d
mla z2.d, p0/m, z3.d, z4.d




// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
abs z0.d, p0/m, z0.d

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
add z0.d, p0/m, z0.d, z0.d

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
asr z0.s, p0/m, z0.s, z0.d

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
mla z0.d, p0/m, z0.d, z2.d

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
mla z0.d, p0/m, z2.d, z0.d

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
mov z0.b, p1/m, b0

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
mov z0.h, p1/m, h0

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
mov z0.s, p1/m, s0

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
mov z0.d, p1/m, d0

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
ext z0.b, z0.b, z0.b, #1

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
insr z0.b, b0

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
insr z0.h, h0

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
insr z0.s, s0

// CHECK: error: instruction is unpredictable when following a movprfx and destination also used as non-destructive source
movprfx z0, z1
insr z0.d, d0




// CHECK: error: instruction is unpredictable when following a predicated movprfx, suggest using unpredicated movprfx
movprfx z0.d, p0/m, z1.d
add z0.d, z0.d, #1




// CHECK: error: instruction is unpredictable when following a predicated movprfx using a different general predicate
movprfx z0.d, p0/m, z1.d
neg z0.d, p1/m, z1.d

// CHECK: error: instruction is unpredictable when following a predicated movprfx using a different general predicate
movprfx z0.d, p0/m, z1.d
add z0.d, p1/m, z0.d, z2.d

// CHECK: error: instruction is unpredictable when following a predicated movprfx using a different general predicate
movprfx z0.d, p0/m, z1.d
cpy z0.d, p1/m, #0

// CHECK: error: instruction is unpredictable when following a predicated movprfx using a different general predicate
movprfx z0.d, p0/m, z1.d
cpy z0.d, p1/z, #0




// CHECK: error: instruction is unpredictable when following a predicated movprfx with a different element size
movprfx z0.s, p0/m, z1.s
add z0.d, p0/m, z0.d, z2.d

// CHECK: error: instruction is unpredictable when following a predicated movprfx with a different element size
movprfx z0.s, p0/m, z1.s
fcvt z0.s, p0/m, z2.d

// CHECK: error: instruction is unpredictable when following a predicated movprfx with a different element size
movprfx z0.s, p0/m, z1.s
fcvt z0.d, p0/m, z2.s




; ensure we don't try to apply a prefix to subsequent instructions upon failure
// CHECK: error: instruction is unpredictable when following a movprfx, suggest replacing movprfx with mov
// CHECK-NOT: error
movprfx z0, z1
add z0.d, z0.d, z0.d
add z0.d, z0.d, z0.d
