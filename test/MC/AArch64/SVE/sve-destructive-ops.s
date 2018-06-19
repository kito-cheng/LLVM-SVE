// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -mattr=+sve -show-encoding 2>&1 < %s | FileCheck %s

add   z0.b, z1.b, #0
// CHECK: error: operand must match destination register

add   z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

and   z0.h, z1.h, #0xfff9
// CHECK: error: operand must match destination register

asr   z2.d, p0/m, z1.d, #2
// CHECK: error: operand must match destination register

asr   z2.s, p0/m, z1.s, z3.d
// CHECK: error: operand must match destination register

bic   z0.s, p0/m, z2.s, z3.s
// CHECK: error: operand must match destination register

brkn   p0.b, p1/z, p2.b, p3.b
// CHECK: error: operand must match destination register

brkns   p0.b, p1/z, p2.b, p3.b
// CHECK: error: operand must match destination register

brkn   p0.b, p1/z, p2.b, p3.b
// CHECK: error: operand must match destination register

clasta   x0, p0, x1, z0.d
// CHECK: error: operand must match destination register

clasta   h0, p0, h1, z0.h
// CHECK: error: operand must match destination register

clasta   z0.s, p0, z1.s, z2.s
// CHECK: error: operand must match destination register

clastb   x0, p0, x1, z0.d
// CHECK: error: operand must match destination register

clastb   h0, p0, h1, z0.h
// CHECK: error: operand must match destination register

clastb   z0.s, p0, z1.s, z2.s
// CHECK: error: operand must match destination register

eor   z0.s, z1.s, #1
// CHECK: error: operand must match destination register

eor   z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

ext   z0.b, z1.b, z2.b, #0
// CHECK: error: operand must match destination register

fabd    z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

fadda   s0, p0, s2, z0.s
// CHECK: error: operand must match destination register

fadd    z0.d, p0/m, z1.d, #0.5
// CHECK: error: operand must match destination register

fadd    z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

fdivr   z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

fmaxnm    z0.d, p0/m, z1.d, #0.0
// CHECK: error: operand must match destination register

fmaxnm    z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

fmax    z0.d, p0/m, z1.d, #0.0
// CHECK: error: operand must match destination register

fmax    z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

fminnm    z0.s, p0/m, z1.s, #0.0
// CHECK: error: operand must match destination register

fminnm    z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

fmin    z0.s, p0/m, z1.s, #0.0
// CHECK: error: operand must match destination register

fmin    z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

fmulx   z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

fmul    z0.d, p0/m, z1.d, #0.5
// CHECK: error: operand must match destination register

fmul    z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

fscale  z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

fsubr   z0.d, p0/m, z1.d, #1.0
// CHECK: error: operand must match destination register

fsubr   z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

fsub    z0.d, p0/m, z1.d, #0.5
// CHECK: error: operand must match destination register

fsub    z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

ftmad   z0.s, z1.s, z2.s, #0
// CHECK: error: operand must match destination register

lslr    z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

lsl   z0.h, p0/m, z1.h, z2.d
// CHECK: error: operand must match destination register

lsl   z0.b, p0/m, z1.b, #1
// CHECK: error: operand must match destination register

lsl   z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

lsrr   z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

lsr   z0.h, p0/m, z1.h, z2.d
// CHECK: error: operand must match destination register

lsr   z0.s, p0/m, z1.s, #2
// CHECK: error: operand must match destination register

lsr   z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

mul   z0.s, z1.s, #4
// CHECK: error: operand must match destination register

orr   z0.b, z1.b, #0x81
// CHECK: error: operand must match destination register

orr   z0.b, p0/m, z1.b, z2.b
// CHECK: error: operand must match destination register

pfirst  p0.b, p1, p2.b
// CHECK: error: operand must match destination register

pnext   p0.b, p1, p2.b
// CHECK: error: operand must match destination register

sabd    z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

sdivr   z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

sdiv    z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

smax    z0.h, z1.h, #2
// CHECK: error: operand must match destination register

smax    z0.h, p0/m, z1.h, z2.h
// CHECK: error: operand must match destination register

smin    z0.h, z1.h, #2
// CHECK: error: operand must match destination register

smin    z0.h, p0/m, z1.h, z2.h
// CHECK: error: operand must match destination register

smulh   z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

splice    z0.b, p0, z1.b, z2.b
// CHECK: error: operand must match destination register

sqadd   z0.s, z1.s, #2
// CHECK: error: operand must match destination register

sqsub   z0.s, z1.s, #2
// CHECK: error: operand must match destination register

subr    z0.d, z1.d, #4
// CHECK: error: operand must match destination register

subr    z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

sub   z0.s, z1.s, #2
// CHECK: error: operand must match destination register

sub   z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

uabd    z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

udivr   z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

udiv    z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

umax    z0.s, z1.s, #4
// CHECK: error: operand must match destination register

umax    z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

umin    z0.s, z1.s, #4
// CHECK: error: operand must match destination register

umin    z0.s, p0/m, z1.s, z2.s
// CHECK: error: operand must match destination register

umulh   z0.d, p0/m, z1.d, z2.d
// CHECK: error: operand must match destination register

uqadd   z0.d, z1.d, #2
// CHECK: error: operand must match destination register

uqsub   z0.d, z1.d, #2
// CHECK: error: operand must match destination register

