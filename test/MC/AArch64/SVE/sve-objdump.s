//RUN:llvm-mc -triple=aarch64-none-linux-gnu -mattr=+sve -filetype=obj < %s | llvm-objdump -triple=aarch64-none-linux-gnu  -mattr=+sve -d - | FileCheck %s
uunpklo z21.d, z10.s
//CHECK: uunpklo z21.d, z10.s
cmpne   p5.b, p5/z, z10.b, #-11
//CHECK: cmpne   p5.b, p5/z, z10.b, #-11
ptrues  p5.d, vl32
//CHECK: ptrues  p5.d, vl32
sqincp  x21, p10.s, w21
//CHECK: sqincp  x21, p10.s, w21
mov     z31.d, p15/m, #-1, lsl #8
//CHECK: mov     z31.d, p15/m, #-256
ld1w    {z31.d}, p7/z, [sp, z31.d]
//CHECK: ld1w    {z31.d}, p7/z, [sp, z31.d]
mov     z0.s, p0/m, w0
//CHECK: mov     z0.s, p0/m, w0
uqdech  w21, vl32, mul #6
//CHECK: uqdech  w21, vl32, mul #6
ldff1sb {z23.d}, p3/z, [x13, x8]
//CHECK: ldff1sb {z23.d}, p3/z, [x13, x8]
st2w    {z0.s, z1.s}, p0, [x0, x0, lsl #2]
//CHECK: st2w    {z0.s, z1.s}, p0, [x0, x0, lsl #2]
ldr     p15, [sp, #-1, mul vl]
//CHECK: ldr     p15, [sp, #-1, mul vl]
uqdecp  w0, p0.h
//CHECK: uqdecp  w0, p0.h
uqincw  x0, pow2
//CHECK: uqincw  x0, pow2
fcvt    z31.h, p7/m, z31.d
//CHECK: fcvt    z31.h, p7/m, z31.d
cmpge   p7.h, p3/z, z13.h, #8
//CHECK: cmpge   p7.h, p3/z, z13.h, #8
sqdecp  x21, p10.s, w21
//CHECK: sqdecp  x21, p10.s, w21
zip1    z21.d, z10.d, z21.d
//CHECK: zip1    z21.d, z10.d, z21.d
fminnm  z0.h, p0/m, z0.h, #0.0
//CHECK: fminnm  z0.h, p0/m, z0.h, #0.0
sqdecp  x0, p0.b, w0
//CHECK: sqdecp  x0, p0.b, w0
ld1d    {z31.d}, p7/z, [sp, z31.d]
//CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d]
uqinch  x21, vl32, mul #6
//CHECK: uqinch  x21, vl32, mul #6
frintm  z21.s, p5/m, z10.s
//CHECK: frintm  z21.s, p5/m, z10.s
ld1b    {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ld1b    {z23.d}, p3/z, [x13, z8.d, uxtw]
uqadd   z0.d, z0.d, z0.d
//CHECK: uqadd   z0.d, z0.d, z0.d
incp    z0.d, p0
//CHECK: incp    z0.d, p0
cmpge   p7.s, p3/z, z13.s, z8.d
//CHECK: cmpge   p7.s, p3/z, z13.s, z8.d
whilelo p0.d, x0, x0
//CHECK: whilelo p0.d, x0, x0
fcmla   z21.h, z10.h, z5.h[2], #90
//CHECK: fcmla   z21.h, z10.h, z5.h[2], #90
umin    z23.d, p3/m, z23.d, z13.d
//CHECK: umin    z23.d, p3/m, z23.d, z13.d
ldff1b  {z0.b}, p0/z, [x0, x0]
//CHECK: ldff1b  {z0.b}, p0/z, [x0, x0]
subr    z23.d, z23.d, #109, lsl #8
//CHECK: subr    z23.d, z23.d, #27904
ldnf1w  {z0.s}, p0/z, [x0]
//CHECK: ldnf1w  {z0.s}, p0/z, [x0]
cntd    x0, pow2
//CHECK: cntd    x0, pow2
ld1sw   {z0.d}, p0/z, [x0, z0.d, lsl #2]
//CHECK: ld1sw   {z0.d}, p0/z, [x0, z0.d, lsl #2]
fexpa   z23.d, z13.d
//CHECK: fexpa   z23.d, z13.d
ptrues  p5.h, vl32
//CHECK: ptrues  p5.h, vl32
sqincp  x23, p13.b, w23
//CHECK: sqincp  x23, p13.b, w23
ld4h    {z31.h, z0.h, z1.h, z2.h}, p7/z, [sp, #-4, mul vl]
//CHECK: ld4h    {z31.h, z0.h, z1.h, z2.h}, p7/z, [sp, #-4, mul vl]
fminv   d23, p3, z13.d
//CHECK: fminv   d23, p3, z13.d
mls     z23.d, p3/m, z13.d, z8.d
//CHECK: mls     z23.d, p3/m, z13.d, z8.d
cmpeq   p7.h, p3/z, z13.h, z8.h
//CHECK: cmpeq   p7.h, p3/z, z13.h, z8.h
ldff1sb {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ldff1sb {z23.d}, p3/z, [x13, z8.d, sxtw]
add     z31.s, z31.s, z31.s
//CHECK: add     z31.s, z31.s, z31.s
uzp2    z31.b, z31.b, z31.b
//CHECK: uzp2    z31.b, z31.b, z31.b
whilelo p15.s, xzr, xzr
//CHECK: whilelo p15.s, xzr, xzr
ldnt1w  {z0.s}, p0/z, [x0]
//CHECK: ldnt1w  {z0.s}, p0/z, [x0]
ld4d    {z21.d, z22.d, z23.d, z24.d}, p5/z, [x10, x21, lsl #3]
//CHECK: ld4d    {z21.d, z22.d, z23.d, z24.d}, p5/z, [x10, x21, lsl #3]
ld1b    {z0.d}, p0/z, [x0]
//CHECK: ld1b    {z0.d}, p0/z, [x0]
sxth    z23.s, p3/m, z13.s
//CHECK: sxth    z23.s, p3/m, z13.s
ld1h    {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1h    {z31.d}, p7/z, [sp, #-1, mul vl]
sqinch  z0.h, pow2
//CHECK: sqinch  z0.h, pow2
rdffr   p0.b
//CHECK: rdffr   p0.b
adr     z31.s, [z31.s, z31.s, lsl #1]
//CHECK: adr     z31.s, [z31.s, z31.s, lsl #1]
ldnt1b  {z31.b}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnt1b  {z31.b}, p7/z, [sp, #-1, mul vl]
and     z31.d, p7/m, z31.d, z31.d
//CHECK: and     z31.d, p7/m, z31.d, z31.d
eorv    s31, p7, z31.s
//CHECK: eorv    s31, p7, z31.s
uqincp  w23, p13.b
//CHECK: uqincp  w23, p13.b
subr    z23.d, p3/m, z23.d, z13.d
//CHECK: subr    z23.d, p3/m, z23.d, z13.d
rev     p0.d, p0.d
//CHECK: rev     p0.d, p0.d
umax    z21.s, z21.s, #170
//CHECK: umax    z21.s, z21.s, #170
mov     z21.s, p5/m, s10
//CHECK: mov     z21.s, p5/m, s10
uzp2    p7.s, p13.s, p8.s
//CHECK: uzp2    p7.s, p13.s, p8.s
ldff1sb {z21.s}, p5/z, [x10, x21]
//CHECK: ldff1sb {z21.s}, p5/z, [x10, x21]
fmls    z21.h, p5/m, z10.h, z21.h
//CHECK: fmls    z21.h, p5/m, z10.h, z21.h
smax    z0.b, p0/m, z0.b, z0.b
//CHECK: smax    z0.b, p0/m, z0.b, z0.b
sqdech  x21, vl32, mul #6
//CHECK: sqdech  x21, vl32, mul #6
uqdecp  w21, p10.s
//CHECK: uqdecp  w21, p10.s
orr     p7.b, p11/z, p13.b, p8.b
//CHECK: orr     p7.b, p11/z, p13.b, p8.b
uqadd   z31.s, z31.s, z31.s
//CHECK: uqadd   z31.s, z31.s, z31.s
ld1w    {z21.s}, p5/z, [x10, x21, lsl #2]
//CHECK: ld1w    {z21.s}, p5/z, [x10, x21, lsl #2]
fcvtzs  z31.d, p7/m, z31.s
//CHECK: fcvtzs  z31.d, p7/m, z31.s
fadd    z21.h, p5/m, z21.h, #0.5
//CHECK: fadd    z21.h, p5/m, z21.h, #0.5
fmaxv   s0, p0, z0.s
//CHECK: fmaxv   s0, p0, z0.s
scvtf   z0.h, p0/m, z0.s
//CHECK: scvtf   z0.h, p0/m, z0.s
clasta  d0, p0, d0, z0.d
//CHECK: clasta  d0, p0, d0, z0.d
whilels p15.d, xzr, xzr
//CHECK: whilels p15.d, xzr, xzr
trn1    p0.b, p0.b, p0.b
//CHECK: trn1    p0.b, p0.b, p0.b
fminnm  z31.s, p7/m, z31.s, #1.0
//CHECK: fminnm  z31.s, p7/m, z31.s, #1.0
subr    z23.s, z23.s, #109, lsl #8
//CHECK: subr    z23.s, z23.s, #27904
ldr     p7, [x13, #67, mul vl]
//CHECK: ldr     p7, [x13, #67, mul vl]
cmple   p15.h, p7/z, z31.h, #-1
//CHECK: cmple   p15.h, p7/z, z31.h, #-1
movprfx z23.d, p3/m, z13.d
//CHECK: movprfx z23.d, p3/m, z13.d
add     z23.d, p3/m, z23.d, z24.d
//CHECK: add z23.d, p3/m, z23.d, z24.d
fmaxnm  z31.s, p7/m, z31.s, z31.s
//CHECK: fmaxnm  z31.s, p7/m, z31.s, z31.s
ld1sw   {z0.d}, p0/z, [x0, z0.d]
//CHECK: ld1sw   {z0.d}, p0/z, [x0, z0.d]
dech    z0.h, pow2
//CHECK: dech    z0.h, pow2
uqdecp  x0, p0.h
//CHECK: uqdecp  x0, p0.h
movs    p0.b, p0/z, p0.b
//CHECK: movs    p0.b, p0/z, p0.b
frintn  z21.d, p5/m, z10.d
//CHECK: frintn  z21.d, p5/m, z10.d
lsr     z31.h, p7/m, z31.h, z31.h
//CHECK: lsr     z31.h, p7/m, z31.h, z31.h
st4d    {z0.d, z1.d, z2.d, z3.d}, p0, [x0]
//CHECK: st4d    {z0.d, z1.d, z2.d, z3.d}, p0, [x0]
brkb    p0.b, p0/m, p0.b
//CHECK: brkb    p0.b, p0/m, p0.b
sqincb  xzr, all, mul #16
//CHECK: sqincb  xzr, all, mul #16
mov     z31.s, p7/m, s31
//CHECK: mov     z31.s, p7/m, s31
msb     z0.s, p0/m, z0.s, z0.s
//CHECK: msb     z0.s, p0/m, z0.s, z0.s
fminnmv h21, p5, z10.h
//CHECK: fminnmv h21, p5, z10.h
uminv   h23, p3, z13.h
//CHECK: uminv   h23, p3, z13.h
splice  z23.b, p3, z23.b, z13.b
//CHECK: splice  z23.b, p3, z23.b, z13.b
cntp    x23, p11, p13.s
//CHECK: cntp    x23, p11, p13.s
udivr   z0.d, p0/m, z0.d, z0.d
//CHECK: udivr   z0.d, p0/m, z0.d, z0.d
sminv   b23, p3, z13.b
//CHECK: sminv   b23, p3, z13.b
whilelt p7.h, x13, x8
//CHECK: whilelt p7.h, x13, x8
ld1rh   {z31.h}, p7/z, [sp, #126]
//CHECK: ld1rh   {z31.h}, p7/z, [sp, #126]
st1d    {z31.d}, p7, [z31.d, #248]
//CHECK: st1d    {z31.d}, p7, [z31.d, #248]
uqincw  w21, vl32, mul #6
//CHECK: uqincw  w21, vl32, mul #6
incd    xzr, all, mul #16
//CHECK: incd    xzr, all, mul #16
fneg    z21.s, p5/m, z10.s
//CHECK: fneg    z21.s, p5/m, z10.s
ldnf1sw {z0.d}, p0/z, [x0]
//CHECK: ldnf1sw {z0.d}, p0/z, [x0]
st1b    {z5.s}, p3, [x17, x16]
//CHECK: st1b    {z5.s}, p3, [x17, x16]
fmov    z31.h, #-1.9375
//CHECK: fmov    z31.h, #-1.9375
abs     z0.b, p0/m, z0.b
//CHECK: abs     z0.b, p0/m, z0.b
uxtw    z23.d, p3/m, z13.d
//CHECK: uxtw    z23.d, p3/m, z13.d
ld1sh   {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ld1sh   {z21.d}, p5/z, [x10, #5, mul vl]
asr     z31.b, p7/m, z31.b, z31.d
//CHECK: asr     z31.b, p7/m, z31.b, z31.d
ld1rsw  {z0.d}, p0/z, [x0]
//CHECK: ld1rsw  {z0.d}, p0/z, [x0]
asr     z31.s, p7/m, z31.s, z31.d
//CHECK: asr     z31.s, p7/m, z31.s, z31.d
abs     z21.b, p5/m, z10.b
//CHECK: abs     z21.b, p5/m, z10.b
ldff1w  {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ldff1w  {z31.d}, p7/z, [sp, z31.d, sxtw]
ldff1sb {z31.s}, p7/z, [sp, xzr]
//CHECK: ldff1sb {z31.s}, p7/z, [sp]
uqinch  wzr, all, mul #16
//CHECK: uqinch  wzr, all, mul #16
uqadd   z0.b, z0.b, z0.b
//CHECK: uqadd   z0.b, z0.b, z0.b
eor     z0.d, p0/m, z0.d, z0.d
//CHECK: eor     z0.d, p0/m, z0.d, z0.d
sqincb  x21, w21, vl32, mul #6
//CHECK: sqincb  x21, w21, vl32, mul #6
ld1w    {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1w    {z31.d}, p7/z, [sp, #-1, mul vl]
ld1sw   {z23.d}, p3/z, [x13, x8, lsl #2]
//CHECK: ld1sw   {z23.d}, p3/z, [x13, x8, lsl #2]
adr     z0.s, [z0.s, z0.s, lsl #1]
//CHECK: adr     z0.s, [z0.s, z0.s, lsl #1]
clastb  z0.b, p0, z0.b, z0.b
//CHECK: clastb  z0.b, p0, z0.b, z0.b
umin    z0.d, p0/m, z0.d, z0.d
//CHECK: umin    z0.d, p0/m, z0.d, z0.d
uqincd  w0, pow2
//CHECK: uqincd  w0, pow2
asr     z23.b, z13.b, z8.d
//CHECK: asr     z23.b, z13.b, z8.d
fcvtzu  z23.d, p3/m, z13.s
//CHECK: fcvtzu  z23.d, p3/m, z13.s
uqadd   z21.b, z21.b, #170
//CHECK: uqadd   z21.b, z21.b, #170
ldff1sh {z23.s}, p3/z, [z13.s, #16]
//CHECK: ldff1sh {z23.s}, p3/z, [z13.s, #16]
clastb  z21.b, p5, z21.b, z10.b
//CHECK: clastb  z21.b, p5, z21.b, z10.b
mla     z21.h, p5/m, z10.h, z21.h
//CHECK: mla     z21.h, p5/m, z10.h, z21.h
fsub    z0.s, p0/m, z0.s, z0.s
//CHECK: fsub    z0.s, p0/m, z0.s, z0.s
brka    p15.b, p15/m, p15.b
//CHECK: brka    p15.b, p15/m, p15.b
ldff1d  {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ldff1d  {z31.d}, p7/z, [sp, z31.d, sxtw]
tbl     z23.d, {z13.d}, z8.d
//CHECK: tbl     z23.d, {z13.d}, z8.d
st4d    {z5.d, z6.d, z7.d, z8.d}, p3, [x17, x16, lsl #3]
//CHECK: st4d    {z5.d, z6.d, z7.d, z8.d}, p3, [x17, x16, lsl #3]
sqadd   z21.h, z10.h, z21.h
//CHECK: sqadd   z21.h, z10.h, z21.h
lastb   s23, p3, z13.s
//CHECK: lastb   s23, p3, z13.s
whilele p15.b, xzr, xzr
//CHECK: whilele p15.b, xzr, xzr
fcmeq   p0.h, p0/z, z0.h, #0.0
//CHECK: fcmeq   p0.h, p0/z, z0.h, #0.0
ld1rw   {z23.d}, p3/z, [x13, #32]
//CHECK: ld1rw   {z23.d}, p3/z, [x13, #32]
ldff1sb {z31.h}, p7/z, [sp, xzr]
//CHECK: ldff1sb {z31.h}, p7/z, [sp]
fdivr   z0.s, p0/m, z0.s, z0.s
//CHECK: fdivr   z0.s, p0/m, z0.s, z0.s
ld1b    {z23.s}, p3/z, [x13, z8.s, sxtw]
//CHECK: ld1b    {z23.s}, p3/z, [x13, z8.s, sxtw]
st1h    {z23.d}, p3, [x13, z8.d, sxtw #1]
//CHECK: st1h    {z23.d}, p3, [x13, z8.d, sxtw #1]
st4d    {z21.d, z22.d, z23.d, z24.d}, p5, [x10, x21, lsl #3]
//CHECK: st4d    {z21.d, z22.d, z23.d, z24.d}, p5, [x10, x21, lsl #3]
ldff1sw {z21.d}, p5/z, [x10, z21.d, sxtw #2]
//CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, sxtw #2]
frintp  z21.d, p5/m, z10.d
//CHECK: frintp  z21.d, p5/m, z10.d
ld1sh   {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ld1sh   {z23.d}, p3/z, [x13, z8.d, sxtw]
cntp    x0, p0, p0.s
//CHECK: cntp    x0, p0, p0.s
uunpkhi z21.d, z10.s
//CHECK: uunpkhi z21.d, z10.s
sunpklo z21.d, z10.s
//CHECK: sunpklo z21.d, z10.s
sqadd   z1.b, z1.b, #33
//CHECK: sqadd   z1.b, z1.b, #33
ldff1d  {z31.d}, p7/z, [sp, z31.d]
//CHECK: ldff1d  {z31.d}, p7/z, [sp, z31.d]
frintz  z0.d, p0/m, z0.d
//CHECK: frintz  z0.d, p0/m, z0.d
whilele p5.s, w10, w21
//CHECK: whilele p5.s, w10, w21
orr     z31.d, p7/m, z31.d, z31.d
//CHECK: orr     z31.d, p7/m, z31.d, z31.d
incp    x0, p0.s
//CHECK: incp    x0, p0.s
ldff1d  {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ldff1d  {z31.d}, p7/z, [sp, z31.d, uxtw]
uzp1    z31.b, z31.b, z31.b
//CHECK: uzp1    z31.b, z31.b, z31.b
st2h    {z23.h, z24.h}, p3, [x13, x8, lsl #1]
//CHECK: st2h    {z23.h, z24.h}, p3, [x13, x8, lsl #1]
subr    z31.s, z31.s, #255, lsl #8
//CHECK: subr    z31.s, z31.s, #65280
not     z0.d, p0/m, z0.d
//CHECK: not     z0.d, p0/m, z0.d
uxth    z31.s, p7/m, z31.s
//CHECK: uxth    z31.s, p7/m, z31.s
fmaxnm  z31.d, p7/m, z31.d, z31.d
//CHECK: fmaxnm  z31.d, p7/m, z31.d, z31.d
sdot    z31.s, z31.b, z7.b[3]
//CHECK: sdot    z31.s, z31.b, z7.b[3]
fmad    z31.h, p7/m, z31.h, z31.h
//CHECK: fmad    z31.h, p7/m, z31.h, z31.h
rdvl    x0, #0
//CHECK: rdvl    x0, #0
fmad    z0.h, p0/m, z0.h, z0.h
//CHECK: fmad    z0.h, p0/m, z0.h, z0.h
ldff1d  {z31.d}, p7/z, [sp, xzr, lsl #3]
//CHECK: ldff1d  {z31.d}, p7/z, [sp]
fmin    z31.s, p7/m, z31.s, z31.s
//CHECK: fmin    z31.s, p7/m, z31.s, z31.s
movprfx z31.s, p7/m, z31.s
//CHECK: movprfx z31.s, p7/m, z31.s
add     z31.s, p7/m, z31.s, z0.s
//CHECK: add z31.s, p7/m, z31.s, z0.s
prfh    #15, p7, [z31.d, #62]
//CHECK: prfh    #15, p7, [z31.d, #62]
st1w    {z31.d}, p7, [sp, z31.d, uxtw]
//CHECK: st1w    {z31.d}, p7, [sp, z31.d, uxtw]
fsub    z23.h, p3/m, z23.h, z13.h
//CHECK: fsub    z23.h, p3/m, z23.h, z13.h
cmphi   p7.b, p3/z, z13.b, z8.d
//CHECK: cmphi   p7.b, p3/z, z13.b, z8.d
lasta   x23, p3, z13.d
//CHECK: lasta   x23, p3, z13.d
lsl     z0.b, z0.b, z0.d
//CHECK: lsl     z0.b, z0.b, z0.d
udiv    z31.s, p7/m, z31.s, z31.s
//CHECK: udiv    z31.s, p7/m, z31.s, z31.s
st1d    {z21.d}, p5, [z10.d, #168]
//CHECK: st1d    {z21.d}, p5, [z10.d, #168]
ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw]
st1w    {z21.s}, p5, [x10, z21.s, sxtw]
//CHECK: st1w    {z21.s}, p5, [x10, z21.s, sxtw]
cmpeq   p5.b, p5/z, z10.b, z21.b
//CHECK: cmpeq   p5.b, p5/z, z10.b, z21.b
fadd    z0.h, z0.h, z0.h
//CHECK: fadd    z0.h, z0.h, z0.h
fneg    z31.s, p7/m, z31.s
//CHECK: fneg    z31.s, p7/m, z31.s
fmaxnm  z31.h, p7/m, z31.h, #1.0
//CHECK: fmaxnm  z31.h, p7/m, z31.h, #1.0
fmulx   z31.d, p7/m, z31.d, z31.d
//CHECK: fmulx   z31.d, p7/m, z31.d, z31.d
ldff1sh {z23.s}, p3/z, [x13, x8, lsl #1]
//CHECK: ldff1sh {z23.s}, p3/z, [x13, x8, lsl #1]
fabd    z0.d, p0/m, z0.d, z0.d
//CHECK: fabd    z0.d, p0/m, z0.d, z0.d
clasta  z0.b, p0, z0.b, z0.b
//CHECK: clasta  z0.b, p0, z0.b, z0.b
smaxv   d31, p7, z31.d
//CHECK: smaxv   d31, p7, z31.d
brkas   p7.b, p11/z, p13.b
//CHECK: brkas   p7.b, p11/z, p13.b
sminv   b0, p0, z0.b
//CHECK: sminv   b0, p0, z0.b
sqadd   z21.d, z21.d, #170
//CHECK: sqadd   z21.d, z21.d, #170
lsl     z0.h, p0/m, z0.h, z0.h
//CHECK: lsl     z0.h, p0/m, z0.h, z0.h
prfb    pldl3strm, p3, [x17, x16]
//CHECK: prfb    pldl3strm, p3, [x17, x16]
incd    z31.d, all, mul #16
//CHECK: incd    z31.d, all, mul #16
uzp2    z31.h, z31.h, z31.h
//CHECK: uzp2    z31.h, z31.h, z31.h
uqdecd  w0, pow2
//CHECK: uqdecd  w0, pow2
whilele p7.h, w13, w8
//CHECK: whilele p7.h, w13, w8
uqsub   z31.h, z31.h, #255, lsl #8
//CHECK: uqsub   z31.h, z31.h, #65280
cmpeq   p7.s, p3/z, z13.s, z8.d
//CHECK: cmpeq   p7.s, p3/z, z13.s, z8.d
rbit    z31.h, p7/m, z31.h
//CHECK: rbit    z31.h, p7/m, z31.h
st2d    {z23.d, z24.d}, p3, [x13, x8, lsl #3]
//CHECK: st2d    {z23.d, z24.d}, p3, [x13, x8, lsl #3]
asr     z23.s, p3/m, z23.s, #19
//CHECK: asr     z23.s, p3/m, z23.s, #19
fcvt    z31.h, p7/m, z31.s
//CHECK: fcvt    z31.h, p7/m, z31.s
ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw]
insr    z21.d, d10
//CHECK: insr    z21.d, d10
sdot    z0.d, z0.h, z0.h
//CHECK: sdot    z0.d, z0.h, z0.h
ldff1sh {z31.s}, p7/z, [sp, xzr, lsl #1]
//CHECK: ldff1sh {z31.s}, p7/z, [sp]
sub     z0.h, z0.h, z0.h
//CHECK: sub     z0.h, z0.h, z0.h
lsl     z23.h, p3/m, z23.h, z13.d
//CHECK: lsl     z23.h, p3/m, z23.h, z13.d
ldff1h  {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ldff1h  {z0.d}, p0/z, [x0, z0.d, sxtw]
uqdech  z21.h, vl32, mul #6
//CHECK: uqdech  z21.h, vl32, mul #6
whilels p15.d, wzr, wzr
//CHECK: whilels p15.d, wzr, wzr
ftmad   z0.s, z0.s, z0.s, #0
//CHECK: ftmad   z0.s, z0.s, z0.s, #0
whilels p15.b, wzr, wzr
//CHECK: whilels p15.b, wzr, wzr
sqdecp  z0.h, p0
//CHECK: sqdecp  z0.h, p0
cnt     z31.d, p7/m, z31.d
//CHECK: cnt     z31.d, p7/m, z31.d
ptrue   p0.b, pow2
//CHECK: ptrue   p0.b, pow2
st1d    {z23.d}, p3, [x13, z8.d, lsl #3]
//CHECK: st1d    {z23.d}, p3, [x13, z8.d, lsl #3]
ldff1d  {z31.d}, p7/z, [sp, z31.d, uxtw #3]
//CHECK: ldff1d  {z31.d}, p7/z, [sp, z31.d, uxtw #3]
mul     z31.s, p7/m, z31.s, z31.s
//CHECK: mul     z31.s, p7/m, z31.s, z31.s
fcvtzs  z31.h, p7/m, z31.h
//CHECK: fcvtzs  z31.h, p7/m, z31.h
mov     z23.s, w13
//CHECK: mov     z23.s, w13
lastb   wzr, p7, z31.h
//CHECK: lastb   wzr, p7, z31.h
prfb    #15, p7, [z31.s, #31]
//CHECK: prfb    #15, p7, [z31.s, #31]
asr     z31.h, p7/m, z31.h, z31.h
//CHECK: asr     z31.h, p7/m, z31.h, z31.h
uqinch  x0, pow2
//CHECK: uqinch  x0, pow2
fminnm  z23.s, p3/m, z23.s, z13.s
//CHECK: fminnm  z23.s, p3/m, z23.s, z13.s
incp    x0, p0.b
//CHECK: incp    x0, p0.b
lasta   w21, p5, z10.h
//CHECK: lasta   w21, p5, z10.h
ld1sh   {z31.s}, p7/z, [sp, z31.s, uxtw #1]
//CHECK: ld1sh   {z31.s}, p7/z, [sp, z31.s, uxtw #1]
fmax    z31.h, p7/m, z31.h, z31.h
//CHECK: fmax    z31.h, p7/m, z31.h, z31.h
incp    z23.d, p13
//CHECK: incp    z23.d, p13
adr     z0.d, [z0.d, z0.d, sxtw #2]
//CHECK: adr     z0.d, [z0.d, z0.d, sxtw #2]
ld1sh   {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1sh   {z23.d}, p3/z, [x13, #-8, mul vl]
ldff1w  {z21.s}, p5/z, [x10, z21.s, sxtw]
//CHECK: ldff1w  {z21.s}, p5/z, [x10, z21.s, sxtw]
andv    s23, p3, z13.s
//CHECK: andv    s23, p3, z13.s
uqadd   z31.s, z31.s, #255, lsl #8
//CHECK: uqadd   z31.s, z31.s, #65280
trn2    p7.d, p13.d, p8.d
//CHECK: trn2    p7.d, p13.d, p8.d
cmphs   p7.h, p3/z, z13.h, #35
//CHECK: cmphs   p7.h, p3/z, z13.h, #35
whilele p15.s, xzr, xzr
//CHECK: whilele p15.s, xzr, xzr
cls     z0.d, p0/m, z0.d
//CHECK: cls     z0.d, p0/m, z0.d
ld4w    {z31.s, z0.s, z1.s, z2.s}, p7/z, [sp, #-4, mul vl]
//CHECK: ld4w    {z31.s, z0.s, z1.s, z2.s}, p7/z, [sp, #-4, mul vl]
mov     z0.h, h0
//CHECK: mov     z0.h, h0
msb     z0.h, p0/m, z0.h, z0.h
//CHECK: msb     z0.h, p0/m, z0.h, z0.h
prfw    pldl3strm, p5, [z10.d, #84]
//CHECK: prfw    pldl3strm, p5, [z10.d, #84]
uxth    z21.d, p5/m, z10.d
//CHECK: uxth    z21.d, p5/m, z10.d
frintx  z0.d, p0/m, z0.d
//CHECK: frintx  z0.d, p0/m, z0.d
ftsmul  z21.h, z10.h, z21.h
//CHECK: ftsmul  z21.h, z10.h, z21.h
orv     h31, p7, z31.h
//CHECK: orv     h31, p7, z31.h
mul     z0.s, p0/m, z0.s, z0.s
//CHECK: mul     z0.s, p0/m, z0.s, z0.s
ldff1sw {z23.d}, p3/z, [x13, z8.d, uxtw #2]
//CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, uxtw #2]
fmsb    z31.s, p7/m, z31.s, z31.s
//CHECK: fmsb    z31.s, p7/m, z31.s, z31.s
ldff1sb {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ldff1sb {z23.d}, p3/z, [x13, z8.d, uxtw]
lsr     z23.h, z13.h, #8
//CHECK: lsr     z23.h, z13.h, #8
bic     z31.b, p7/m, z31.b, z31.b
//CHECK: bic     z31.b, p7/m, z31.b, z31.b
sqincp  x0, p0.d
//CHECK: sqincp  x0, p0.d
decb    x21, vl32, mul #6
//CHECK: decb    x21, vl32, mul #6
ctermeq w0, w0
//CHECK: ctermeq w0, w0
mov     z31.h, p15/m, z31.h
//CHECK: mov     z31.h, p15/m, z31.h
sunpkhi z0.h, z0.b
//CHECK: sunpkhi z0.h, z0.b
incb    x21, vl32, mul #6
//CHECK: incb    x21, vl32, mul #6
udiv    z21.s, p5/m, z21.s, z10.s
//CHECK: udiv    z21.s, p5/m, z21.s, z10.s
cmphs   p0.h, p0/z, z0.h, z0.d
//CHECK: cmphs   p0.h, p0/z, z0.h, z0.d
ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0, x0, lsl #1]
//CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0, x0, lsl #1]
frintx  z21.s, p5/m, z10.s
//CHECK: frintx  z21.s, p5/m, z10.s
ld1rw   {z21.d}, p5/z, [x10, #84]
//CHECK: ld1rw   {z21.d}, p5/z, [x10, #84]
orr     z23.d, z13.d, z8.d
//CHECK: orr     z23.d, z13.d, z8.d
pnext   p5.s, p10, p5.s
//CHECK: pnext   p5.s, p10, p5.s
mov     z31.s, #-1, lsl #8
//CHECK: mov     z31.s, #-256
ldff1h  {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ldff1h  {z31.d}, p7/z, [sp, z31.d, uxtw]
uabd    z23.s, p3/m, z23.s, z13.s
//CHECK: uabd    z23.s, p3/m, z23.s, z13.s
fcvtzu  z23.s, p3/m, z13.d
//CHECK: fcvtzu  z23.s, p3/m, z13.d
uqdecw  w21, vl32, mul #6
//CHECK: uqdecw  w21, vl32, mul #6
lsl     z23.h, z13.h, #8
//CHECK: lsl     z23.h, z13.h, #8
frinti  z31.s, p7/m, z31.s
//CHECK: frinti  z31.s, p7/m, z31.s
ld1b    {z23.d}, p3/z, [z13.d, #8]
//CHECK: ld1b    {z23.d}, p3/z, [z13.d, #8]
prfw    pldl1keep, p0, [x0, x0, lsl #2]
//CHECK: prfw    pldl1keep, p0, [x0, x0, lsl #2]
frsqrts z31.h, z31.h, z31.h
//CHECK: frsqrts z31.h, z31.h, z31.h
fcmge   p15.d, p7/z, z31.d, #0.0
//CHECK: fcmge   p15.d, p7/z, z31.d, #0.0
sqdecw  x21, w21, vl32, mul #6
//CHECK: sqdecw  x21, w21, vl32, mul #6
st1d    {z31.d}, p7, [sp, z31.d, sxtw #3]
//CHECK: st1d    {z31.d}, p7, [sp, z31.d, sxtw #3]
umin    z21.h, p5/m, z21.h, z10.h
//CHECK: umin    z21.h, p5/m, z21.h, z10.h
andv    d0, p0, z0.d
//CHECK: andv    d0, p0, z0.d
adr     z31.s, [z31.s, z31.s]
//CHECK: adr     z31.s, [z31.s, z31.s]
lsl     z23.d, p3/m, z23.d, #45
//CHECK: lsl     z23.d, p3/m, z23.d, #45
sqadd   z0.d, z0.d, #0
//CHECK: sqadd   z0.d, z0.d, #0
fmls    z21.s, z10.s, z5.s[2]
//CHECK: fmls    z21.s, z10.s, z5.s[2]
mov     z21.d, #-86
//CHECK: mov     z21.d, #-86
ld1d    {z0.d}, p0/z, [x0, x0, lsl #3]
//CHECK: ld1d    {z0.d}, p0/z, [x0, x0, lsl #3]
fadd    z21.d, p5/m, z21.d, #0.5
//CHECK: fadd    z21.d, p5/m, z21.d, #0.5
uzp2    z23.h, z13.h, z8.h
//CHECK: uzp2    z23.h, z13.h, z8.h
sqincp  xzr, p15.h, wzr
//CHECK: sqincp  xzr, p15.h, wzr
fadda   d23, p3, d23, z13.d
//CHECK: fadda   d23, p3, d23, z13.d
sqincb  x23, w23, vl256, mul #9
//CHECK: sqincb  x23, w23, vl256, mul #9
cmpne   p0.d, p0/z, z0.d, #0
//CHECK: cmpne   p0.d, p0/z, z0.d, #0
ld1h    {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, uxtw]
cmplt   p15.s, p7/z, z31.s, #-1
//CHECK: cmplt   p15.s, p7/z, z31.s, #-1
fcvtzs  z21.h, p5/m, z10.h
//CHECK: fcvtzs  z21.h, p5/m, z10.h
frecpe  z31.d, z31.d
//CHECK: frecpe  z31.d, z31.d
ld1w    {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ld1w    {z31.d}, p7/z, [sp, z31.d, uxtw]
orr     z0.s, p0/m, z0.s, z0.s
//CHECK: orr     z0.s, p0/m, z0.s, z0.s
ld1b    {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1b    {z23.s}, p3/z, [x13, #-8, mul vl]
ld1h    {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, uxtw]
uqdecp  w21, p10.h
//CHECK: uqdecp  w21, p10.h
rbit    z31.s, p7/m, z31.s
//CHECK: rbit    z31.s, p7/m, z31.s
umax    z21.d, p5/m, z21.d, z10.d
//CHECK: umax    z21.d, p5/m, z21.d, z10.d
ucvtf   z21.h, p5/m, z10.d
//CHECK: ucvtf   z21.h, p5/m, z10.d
mov     z5.b, p0/z, #113
//CHECK: mov     z5.b, p0/z, #113
ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw #1]
//CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw #1]
mov     p15.b, p15/m, p15.b
//CHECK: mov     p15.b, p15/m, p15.b
ld1rqw  {z0.s}, p0/z, [x0, x0, lsl #2]
//CHECK: ld1rqw  {z0.s}, p0/z, [x0, x0, lsl #2]
ld1sh   {z0.s}, p0/z, [z0.s]
//CHECK: ld1sh   {z0.s}, p0/z, [z0.s]
fmaxnmv d31, p7, z31.d
//CHECK: fmaxnmv d31, p7, z31.d
cmpeq   p0.b, p0/z, z0.b, #0
//CHECK: cmpeq   p0.b, p0/z, z0.b, #0
nand    p0.b, p0/z, p0.b, p0.b
//CHECK: nand    p0.b, p0/z, p0.b, p0.b
dupm    z23.h, #0xfff9
//CHECK: dupm    z23.h, #0xfff9
lsl     z21.d, z10.d, #53
//CHECK: lsl     z21.d, z10.d, #53
fminnmv s31, p7, z31.s
//CHECK: fminnmv s31, p7, z31.s
smax    z23.h, p3/m, z23.h, z13.h
//CHECK: smax    z23.h, p3/m, z23.h, z13.h
st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, x8]
//CHECK: st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, x8]
uaddv   d0, p0, z0.d
//CHECK: uaddv   d0, p0, z0.d
fnmls   z21.s, p5/m, z10.s, z21.s
//CHECK: fnmls   z21.s, p5/m, z10.s, z21.s
index   z31.b, wzr, #-1
//CHECK: index   z31.b, wzr, #-1
frintm  z23.d, p3/m, z13.d
//CHECK: frintm  z23.d, p3/m, z13.d
mov     z0.s, p0/m, #0
//CHECK: mov     z0.s, p0/m, #0
sqdecb  x23, vl256, mul #9
//CHECK: sqdecb  x23, vl256, mul #9
sunpklo z31.d, z31.s
//CHECK: sunpklo z31.d, z31.s
cls     z0.b, p0/m, z0.b
//CHECK: cls     z0.b, p0/m, z0.b
ucvtf   z31.s, p7/m, z31.d
//CHECK: ucvtf   z31.s, p7/m, z31.d
fmls    z31.d, z31.d, z15.d[1]
//CHECK: fmls    z31.d, z31.d, z15.d[1]
sub     z21.b, z10.b, z21.b
//CHECK: sub     z21.b, z10.b, z21.b
mov     z5.b, p0/m, #113
//CHECK: mov     z5.b, p0/m, #113
fnmsb   z31.d, p7/m, z31.d, z31.d
//CHECK: fnmsb   z31.d, p7/m, z31.d, z31.d
ldnf1sb {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1sb {z23.d}, p3/z, [x13, #-8, mul vl]
ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw #1]
//CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw #1]
umax    z31.b, p7/m, z31.b, z31.b
//CHECK: umax    z31.b, p7/m, z31.b, z31.b
lslr    z0.d, p0/m, z0.d, z0.d
//CHECK: lslr    z0.d, p0/m, z0.d, z0.d
insr    z21.b, b10
//CHECK: insr    z21.b, b10
st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0, x0]
//CHECK: st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0, x0]
adr     z23.d, [z13.d, z8.d, lsl #2]
//CHECK: adr     z23.d, [z13.d, z8.d, lsl #2]
ld4h    {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0, x0, lsl #1]
//CHECK: ld4h    {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0, x0, lsl #1]
fcmle   p0.h, p0/z, z0.h, #0.0
//CHECK: fcmle   p0.h, p0/z, z0.h, #0.0
adr     z0.d, [z0.d, z0.d, uxtw #3]
//CHECK: adr     z0.d, [z0.d, z0.d, uxtw #3]
st2h    {z0.h, z1.h}, p0, [x0]
//CHECK: st2h    {z0.h, z1.h}, p0, [x0]
ldff1sb {z23.s}, p3/z, [x13, z8.s, sxtw]
//CHECK: ldff1sb {z23.s}, p3/z, [x13, z8.s, sxtw]
ld1sh   {z0.s}, p0/z, [x0, z0.s, sxtw #1]
//CHECK: ld1sh   {z0.s}, p0/z, [x0, z0.s, sxtw #1]
cmpge   p5.s, p5/z, z10.s, #-11
//CHECK: cmpge   p5.s, p5/z, z10.s, #-11
punpkhi p15.h, p15.b
//CHECK: punpkhi p15.h, p15.b
ld1d    {z5.d}, p3/z, [x17, x16, lsl #3]
//CHECK: ld1d    {z5.d}, p3/z, [x17, x16, lsl #3]
prfd    pldl1keep, p0, [x0, z0.d, sxtw #3]
//CHECK: prfd    pldl1keep, p0, [x0, z0.d, sxtw #3]
ld1rqb  {z23.b}, p3/z, [x13, x8]
//CHECK: ld1rqb  {z23.b}, p3/z, [x13, x8]
sqdecd  x0, pow2
//CHECK: sqdecd  x0, pow2
cnot    z21.s, p5/m, z10.s
//CHECK: cnot    z21.s, p5/m, z10.s
cmplo   p7.s, p3/z, z13.s, z8.d
//CHECK: cmplo   p7.s, p3/z, z13.s, z8.d
subr    z23.h, z23.h, #109, lsl #8
//CHECK: subr    z23.h, z23.h, #27904
whilelo p5.b, x10, x21
//CHECK: whilelo p5.b, x10, x21
umin    z21.h, z21.h, #170
//CHECK: umin    z21.h, z21.h, #170
cmplo   p5.s, p5/z, z10.s, z21.d
//CHECK: cmplo   p5.s, p5/z, z10.s, z21.d
bics    p0.b, p0/z, p0.b, p0.b
//CHECK: bics    p0.b, p0/z, p0.b, p0.b
st1h    {z21.h}, p5, [x10, #5, mul vl]
//CHECK: st1h    {z21.h}, p5, [x10, #5, mul vl]
fmul    z31.s, p7/m, z31.s, #2.0
//CHECK: fmul    z31.s, p7/m, z31.s, #2.0
ldff1sh {z21.d}, p5/z, [x10, z21.d, lsl #1]
//CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, lsl #1]
fmul    z0.d, p0/m, z0.d, z0.d
//CHECK: fmul    z0.d, p0/m, z0.d, z0.d
frsqrts z0.s, z0.s, z0.s
//CHECK: frsqrts z0.s, z0.s, z0.s
clasta  z23.s, p3, z23.s, z13.s
//CHECK: clasta  z23.s, p3, z23.s, z13.s
uminv   d0, p0, z0.d
//CHECK: uminv   d0, p0, z0.d
ldff1w  {z31.s}, p7/z, [sp, z31.s, sxtw]
//CHECK: ldff1w  {z31.s}, p7/z, [sp, z31.s, sxtw]
ld1sb   {z21.d}, p5/z, [x10, z21.d]
//CHECK: ld1sb   {z21.d}, p5/z, [x10, z21.d]
uunpkhi z23.d, z13.s
//CHECK: uunpkhi z23.d, z13.s
cmplt   p0.h, p0/z, z0.h, z0.d
//CHECK: cmplt   p0.h, p0/z, z0.h, z0.d
mul     z21.d, p5/m, z21.d, z10.d
//CHECK: mul     z21.d, p5/m, z21.d, z10.d
umaxv   s0, p0, z0.s
//CHECK: umaxv   s0, p0, z0.s
fcmeq   p7.d, p3/z, z13.d, #0.0
//CHECK: fcmeq   p7.d, p3/z, z13.d, #0.0
frinta  z0.d, p0/m, z0.d
//CHECK: frinta  z0.d, p0/m, z0.d
lsl     z23.b, p3/m, z23.b, z13.d
//CHECK: lsl     z23.b, p3/m, z23.b, z13.d
index   z31.d, #-1, xzr
//CHECK: index   z31.d, #-1, xzr
ldff1h  {z0.s}, p0/z, [x0, z0.s, sxtw]
//CHECK: ldff1h  {z0.s}, p0/z, [x0, z0.s, sxtw]
incp    z31.h, p15
//CHECK: incp    z31.h, p15
cmpne   p0.d, p0/z, z0.d, z0.d
//CHECK: cmpne   p0.d, p0/z, z0.d, z0.d
fcmla   z21.d, p5/m, z10.d, z21.d, #180
//CHECK: fcmla   z21.d, p5/m, z10.d, z21.d, #180
and     z0.d, z0.d, z0.d
//CHECK: and     z0.d, z0.d, z0.d
fcmne   p5.h, p5/z, z10.h, z21.h
//CHECK: fcmne   p5.h, p5/z, z10.h, z21.h
orv     b0, p0, z0.b
//CHECK: orv     b0, p0, z0.b
fmul    z31.h, p7/m, z31.h, #2.0
//CHECK: fmul    z31.h, p7/m, z31.h, #2.0
ld1sw   {z21.d}, p5/z, [z10.d, #84]
//CHECK: ld1sw   {z21.d}, p5/z, [z10.d, #84]
fsubr   z0.h, p0/m, z0.h, z0.h
//CHECK: fsubr   z0.h, p0/m, z0.h, z0.h
eorv    b0, p0, z0.b
//CHECK: eorv    b0, p0, z0.b
ldff1h  {z31.d}, p7/z, [sp, z31.d, uxtw #1]
//CHECK: ldff1h  {z31.d}, p7/z, [sp, z31.d, uxtw #1]
mov     z0.d, p0/m, z0.d
//CHECK: mov     z0.d, p0/m, z0.d
fmls    z21.d, p5/m, z10.d, z21.d
//CHECK: fmls    z21.d, p5/m, z10.d, z21.d
cmpne   p15.s, p7/z, z31.s, z31.s
//CHECK: cmpne   p15.s, p7/z, z31.s, z31.s
ldff1b  {z23.s}, p3/z, [z13.s, #8]
//CHECK: ldff1b  {z23.s}, p3/z, [z13.s, #8]
sqincp  z21.s, p10
//CHECK: sqincp  z21.s, p10
zip1    z0.d, z0.d, z0.d
//CHECK: zip1    z0.d, z0.d, z0.d
sub     z31.d, p7/m, z31.d, z31.d
//CHECK: sub     z31.d, p7/m, z31.d, z31.d
eorv    b21, p5, z10.b
//CHECK: eorv    b21, p5, z10.b
lastb   d23, p3, z13.d
//CHECK: lastb   d23, p3, z13.d
umax    z0.d, p0/m, z0.d, z0.d
//CHECK: umax    z0.d, p0/m, z0.d, z0.d
sminv   h23, p3, z13.h
//CHECK: sminv   h23, p3, z13.h
mov     z31.d, z31.d[7]
//CHECK: mov     z31.d, z31.d[7]
ld1rqw  {z31.s}, p7/z, [sp, #-16]
//CHECK: ld1rqw  {z31.s}, p7/z, [sp, #-16]
ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, #-24, mul vl]
//CHECK: ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, #-24, mul vl]
mov     z31.h, p15/m, #-1, lsl #8
//CHECK: mov     z31.h, p15/m, #-256
umax    z0.b, z0.b, #0
//CHECK: umax    z0.b, z0.b, #0
trn1    p5.h, p10.h, p5.h
//CHECK: trn1    p5.h, p10.h, p5.h
index   z23.d, x13, #8
//CHECK: index   z23.d, x13, #8
faddv   d31, p7, z31.d
//CHECK: faddv   d31, p7, z31.d
lsrr    z21.h, p5/m, z21.h, z10.h
//CHECK: lsrr    z21.h, p5/m, z21.h, z10.h
ld1rw   {z21.s}, p5/z, [x10, #84]
//CHECK: ld1rw   {z21.s}, p5/z, [x10, #84]
cmpge   p0.s, p0/z, z0.s, z0.d
//CHECK: cmpge   p0.s, p0/z, z0.s, z0.d
adr     z0.s, [z0.s, z0.s]
//CHECK: adr     z0.s, [z0.s, z0.s]
prfw    pldl3strm, p5, [x10, z21.d, uxtw #2]
//CHECK: prfw    pldl3strm, p5, [x10, z21.d, uxtw #2]
st1h    {z31.s}, p7, [z31.s, #62]
//CHECK: st1h    {z31.s}, p7, [z31.s, #62]
whilelo p15.s, wzr, wzr
//CHECK: whilelo p15.s, wzr, wzr
ld1h    {z21.s}, p5/z, [x10, z21.s, sxtw]
//CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, sxtw]
subr    z0.s, p0/m, z0.s, z0.s
//CHECK: subr    z0.s, p0/m, z0.s, z0.s
index   z23.s, w13, #8
//CHECK: index   z23.s, w13, #8
fcmge   p5.d, p5/z, z10.d, #0.0
//CHECK: fcmge   p5.d, p5/z, z10.d, #0.0
fcmne   p5.d, p5/z, z10.d, #0.0
//CHECK: fcmne   p5.d, p5/z, z10.d, #0.0
sub     z23.h, p3/m, z23.h, z13.h
//CHECK: sub     z23.h, p3/m, z23.h, z13.h
uqincp  w21, p10.b
//CHECK: uqincp  w21, p10.b
uzp1    z23.d, z13.d, z8.d
//CHECK: uzp1    z23.d, z13.d, z8.d
zip1    z23.s, z13.s, z8.s
//CHECK: zip1    z23.s, z13.s, z8.s
fmul    z21.s, p5/m, z21.s, #0.5
//CHECK: fmul    z21.s, p5/m, z21.s, #0.5
ld1h    {z0.s}, p0/z, [x0, z0.s, sxtw]
//CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, sxtw]
asr     z31.b, p7/m, z31.b, #1
//CHECK: asr     z31.b, p7/m, z31.b, #1
fcvt    z0.s, p0/m, z0.h
//CHECK: fcvt    z0.s, p0/m, z0.h
st1b    {z21.d}, p5, [x10, z21.d, sxtw]
//CHECK: st1b    {z21.d}, p5, [x10, z21.d, sxtw]
ld1w    {z0.s}, p0/z, [x0, z0.s, uxtw]
//CHECK: ld1w    {z0.s}, p0/z, [x0, z0.s, uxtw]
sqdecp  xzr, p15.d
//CHECK: sqdecp  xzr, p15.d
fsubr   z0.h, p0/m, z0.h, #0.5
//CHECK: fsubr   z0.h, p0/m, z0.h, #0.5
fminv   s0, p0, z0.s
//CHECK: fminv   s0, p0, z0.s
fmls    z23.h, p3/m, z13.h, z8.h
//CHECK: fmls    z23.h, p3/m, z13.h, z8.h
lsr     z31.d, p7/m, z31.d, z31.d
//CHECK: lsr     z31.d, p7/m, z31.d, z31.d
prfw    #15, p7, [z31.d, #124]
//CHECK: prfw    #15, p7, [z31.d, #124]
add     z23.d, z13.d, z8.d
//CHECK: add     z23.d, z13.d, z8.d
adr     z21.d, [z10.d, z21.d]
//CHECK: adr     z21.d, [z10.d, z21.d]
fmls    z23.s, z13.s, z0.s[1]
//CHECK: fmls    z23.s, z13.s, z0.s[1]
smin    z0.h, p0/m, z0.h, z0.h
//CHECK: smin    z0.h, p0/m, z0.h, z0.h
clz     z23.d, p3/m, z13.d
//CHECK: clz     z23.d, p3/m, z13.d
incp    xzr, p15.h
//CHECK: incp    xzr, p15.h
prfd    pldl1keep, p0, [z0.s]
//CHECK: prfd    pldl1keep, p0, [z0.s]
uqincp  z0.s, p0
//CHECK: uqincp  z0.s, p0
prfb    pldl1keep, p0, [x0, z0.d, sxtw]
//CHECK: prfb    pldl1keep, p0, [x0, z0.d, sxtw]
prfb    #15, p7, [z31.d, #31]
//CHECK: prfb    #15, p7, [z31.d, #31]
ldff1h  {z21.s}, p5/z, [x10, z21.s, sxtw]
//CHECK: ldff1h  {z21.s}, p5/z, [x10, z21.s, sxtw]
ldff1b  {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ldff1b  {z31.d}, p7/z, [sp, z31.d, sxtw]
smulh   z0.s, p0/m, z0.s, z0.s
//CHECK: smulh   z0.s, p0/m, z0.s, z0.s
frintz  z0.h, p0/m, z0.h
//CHECK: frintz  z0.h, p0/m, z0.h
frintn  z23.s, p3/m, z13.s
//CHECK: frintn  z23.s, p3/m, z13.s
frecpx  z21.d, p5/m, z10.d
//CHECK: frecpx  z21.d, p5/m, z10.d
whilelt p5.h, w10, w21
//CHECK: whilelt p5.h, w10, w21
fnmla   z31.d, p7/m, z31.d, z31.d
//CHECK: fnmla   z31.d, p7/m, z31.d, z31.d
clastb  z21.d, p5, z21.d, z10.d
//CHECK: clastb  z21.d, p5, z21.d, z10.d
ld3b    {z23.b, z24.b, z25.b}, p3/z, [x13, #-24, mul vl]
//CHECK: ld3b    {z23.b, z24.b, z25.b}, p3/z, [x13, #-24, mul vl]
sabd    z23.s, p3/m, z23.s, z13.s
//CHECK: sabd    z23.s, p3/m, z23.s, z13.s
cls     z21.b, p5/m, z10.b
//CHECK: cls     z21.b, p5/m, z10.b
lsr     z0.s, p0/m, z0.s, #32
//CHECK: lsr     z0.s, p0/m, z0.s, #32
prfd    pldl1keep, p0, [x0, z0.s, uxtw #3]
//CHECK: prfd    pldl1keep, p0, [x0, z0.s, uxtw #3]
prfd    pldl3strm, p5, [x10, x21, lsl #3]
//CHECK: prfd    pldl3strm, p5, [x10, x21, lsl #3]
sqdecw  x21, vl32, mul #6
//CHECK: sqdecw  x21, vl32, mul #6
decb    x23, vl256, mul #9
//CHECK: decb    x23, vl256, mul #9
prfd    #15, p7, [sp, z31.d, uxtw #3]
//CHECK: prfd    #15, p7, [sp, z31.d, uxtw #3]
ldff1w  {z31.d}, p7/z, [z31.d, #124]
//CHECK: ldff1w  {z31.d}, p7/z, [z31.d, #124]
cmpne   p7.s, p3/z, z13.s, z8.s
//CHECK: cmpne   p7.s, p3/z, z13.s, z8.s
cmpeq   p5.h, p5/z, z10.h, #-11
//CHECK: cmpeq   p5.h, p5/z, z10.h, #-11
cmphs   p0.d, p0/z, z0.d, #0
//CHECK: cmphs   p0.d, p0/z, z0.d, #0
st2b    {z0.b, z1.b}, p0, [x0]
//CHECK: st2b    {z0.b, z1.b}, p0, [x0]
fminv   s23, p3, z13.s
//CHECK: fminv   s23, p3, z13.s
st1h    {z21.s}, p5, [x10, x21, lsl #1]
//CHECK: st1h    {z21.s}, p5, [x10, x21, lsl #1]
fabd    z23.s, p3/m, z23.s, z13.s
//CHECK: fabd    z23.s, p3/m, z23.s, z13.s
uqdecp  xzr, p15.s
//CHECK: uqdecp  xzr, p15.s
smaxv   b0, p0, z0.b
//CHECK: smaxv   b0, p0, z0.b
ld1sw   {z0.d}, p0/z, [z0.d]
//CHECK: ld1sw   {z0.d}, p0/z, [z0.d]
zip2    p5.d, p10.d, p5.d
//CHECK: zip2    p5.d, p10.d, p5.d
ld1b    {z23.d}, p3/z, [x13, x8]
//CHECK: ld1b    {z23.d}, p3/z, [x13, x8]
st1d    {z21.d}, p5, [x10, z21.d]
//CHECK: st1d    {z21.d}, p5, [x10, z21.d]
pnext   p7.b, p13, p7.b
//CHECK: pnext   p7.b, p13, p7.b
faddv   d0, p0, z0.d
//CHECK: faddv   d0, p0, z0.d
ldff1w  {z21.d}, p5/z, [x10, z21.d]
//CHECK: ldff1w  {z21.d}, p5/z, [x10, z21.d]
ld1b    {z21.h}, p5/z, [x10, x21]
//CHECK: ld1b    {z21.h}, p5/z, [x10, x21]
rbit    z21.h, p5/m, z10.h
//CHECK: rbit    z21.h, p5/m, z10.h
cmphs   p15.h, p7/z, z31.h, z31.d
//CHECK: cmphs   p15.h, p7/z, z31.h, z31.d
scvtf   z31.h, p7/m, z31.s
//CHECK: scvtf   z31.h, p7/m, z31.s
sabd    z31.h, p7/m, z31.h, z31.h
//CHECK: sabd    z31.h, p7/m, z31.h, z31.h
asr     z21.d, p5/m, z21.d, z10.d
//CHECK: asr     z21.d, p5/m, z21.d, z10.d
prfb    pldl3strm, p5, [x10, z21.d]
//CHECK: prfb    pldl3strm, p5, [x10, z21.d]
ucvtf   z21.s, p5/m, z10.s
//CHECK: ucvtf   z21.s, p5/m, z10.s
lsl     z31.h, p7/m, z31.h, z31.h
//CHECK: lsl     z31.h, p7/m, z31.h, z31.h
sqdech  xzr, all, mul #16
//CHECK: sqdech  xzr, all, mul #16
ldff1sb {z31.d}, p7/z, [sp, z31.d]
//CHECK: ldff1sb {z31.d}, p7/z, [sp, z31.d]
st3w    {z23.s, z24.s, z25.s}, p3, [x13, #-24, mul vl]
//CHECK: st3w    {z23.s, z24.s, z25.s}, p3, [x13, #-24, mul vl]
punpkhi p0.h, p0.b
//CHECK: punpkhi p0.h, p0.b
sqinch  z31.h, all, mul #16
//CHECK: sqinch  z31.h, all, mul #16
brkns   p15.b, p15/z, p15.b, p15.b
//CHECK: brkns   p15.b, p15/z, p15.b, p15.b
clasta  w21, p5, w21, z10.h
//CHECK: clasta  w21, p5, w21, z10.h
ldff1d  {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ldff1d  {z21.d}, p5/z, [x10, z21.d, sxtw]
sxtb    z23.h, p3/m, z13.h
//CHECK: sxtb    z23.h, p3/m, z13.h
sqdech  x21, w21, vl32, mul #6
//CHECK: sqdech  x21, w21, vl32, mul #6
uqincp  xzr, p15.d
//CHECK: uqincp  xzr, p15.d
sub     z31.h, z31.h, z31.h
//CHECK: sub     z31.h, z31.h, z31.h
subr    z31.h, p7/m, z31.h, z31.h
//CHECK: subr    z31.h, p7/m, z31.h, z31.h
uqadd   z23.h, z23.h, #109, lsl #8
//CHECK: uqadd   z23.h, z23.h, #27904
and     p7.b, p11/z, p13.b, p8.b
//CHECK: and     p7.b, p11/z, p13.b, p8.b
sqdech  z31.h, all, mul #16
//CHECK: sqdech  z31.h, all, mul #16
fadd    z21.h, z10.h, z21.h
//CHECK: fadd    z21.h, z10.h, z21.h
uqsub   z0.h, z0.h, #0
//CHECK: uqsub   z0.h, z0.h, #0
cmpgt   p5.b, p5/z, z10.b, z21.d
//CHECK: cmpgt   p5.b, p5/z, z10.b, z21.d
ld1sh   {z0.s}, p0/z, [x0, z0.s, sxtw]
//CHECK: ld1sh   {z0.s}, p0/z, [x0, z0.s, sxtw]
fmaxv   s31, p7, z31.s
//CHECK: fmaxv   s31, p7, z31.s
ld3b    {z0.b, z1.b, z2.b}, p0/z, [x0, x0]
//CHECK: ld3b    {z0.b, z1.b, z2.b}, p0/z, [x0, x0]
fminnm  z31.h, p7/m, z31.h, #1.0
//CHECK: fminnm  z31.h, p7/m, z31.h, #1.0
scvtf   z23.s, p3/m, z13.s
//CHECK: scvtf   z23.s, p3/m, z13.s
fcmla   z21.s, p5/m, z10.s, z21.s, #180
//CHECK: fcmla   z21.s, p5/m, z10.s, z21.s, #180
sqincp  x23, p13.s
//CHECK: sqincp  x23, p13.s
ld1w    {z23.d}, p3/z, [z13.d, #32]
//CHECK: ld1w    {z23.d}, p3/z, [z13.d, #32]
ldff1b  {z21.s}, p5/z, [z10.s, #21]
//CHECK: ldff1b  {z21.s}, p5/z, [z10.s, #21]
ld1b    {z23.s}, p3/z, [z13.s, #8]
//CHECK: ld1b    {z23.s}, p3/z, [z13.s, #8]
umax    z21.h, p5/m, z21.h, z10.h
//CHECK: umax    z21.h, p5/m, z21.h, z10.h
lsl     z21.s, p5/m, z21.s, z10.d
//CHECK: lsl     z21.s, p5/m, z21.s, z10.d
cmpls   p0.d, p0/z, z0.d, #0
//CHECK: cmpls   p0.d, p0/z, z0.d, #0
eor     z23.d, p3/m, z23.d, z13.d
//CHECK: eor     z23.d, p3/m, z23.d, z13.d
cntb    x21, vl32, mul #6
//CHECK: cntb    x21, vl32, mul #6
nors    p5.b, p5/z, p10.b, p5.b
//CHECK: nors    p5.b, p5/z, p10.b, p5.b
pfalse  p0.b
//CHECK: pfalse  p0.b
sqadd   z31.d, z31.d, z31.d
//CHECK: sqadd   z31.d, z31.d, z31.d
clastb  wzr, p7, wzr, z31.h
//CHECK: clastb  wzr, p7, wzr, z31.h
ld1h    {z21.d}, p5/z, [x10, x21, lsl #1]
//CHECK: ld1h    {z21.d}, p5/z, [x10, x21, lsl #1]
zip1    z0.s, z0.s, z0.s
//CHECK: zip1    z0.s, z0.s, z0.s
sqincd  z23.d, vl256, mul #9
//CHECK: sqincd  z23.d, vl256, mul #9
nands   p0.b, p0/z, p0.b, p0.b
//CHECK: nands   p0.b, p0/z, p0.b, p0.b
whilele p15.b, wzr, wzr
//CHECK: whilele p15.b, wzr, wzr
sqdecb  x23, w23, vl256, mul #9
//CHECK: sqdecb  x23, w23, vl256, mul #9
ldff1b  {z23.h}, p3/z, [x13, x8]
//CHECK: ldff1b  {z23.h}, p3/z, [x13, x8]
ldff1sw {z0.d}, p0/z, [x0, x0, lsl #2]
//CHECK: ldff1sw {z0.d}, p0/z, [x0, x0, lsl #2]
lslr    z0.h, p0/m, z0.h, z0.h
//CHECK: lslr    z0.h, p0/m, z0.h, z0.h
ldnf1d  {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1d  {z21.d}, p5/z, [x10, #5, mul vl]
prfw    pldl3strm, p5, [x10, z21.s, sxtw #2]
//CHECK: prfw    pldl3strm, p5, [x10, z21.s, sxtw #2]
frecps  z0.h, z0.h, z0.h
//CHECK: frecps  z0.h, z0.h, z0.h
ld1sh   {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ld1sh   {z23.d}, p3/z, [x13, z8.d, uxtw]
lslr    z31.s, p7/m, z31.s, z31.s
//CHECK: lslr    z31.s, p7/m, z31.s, z31.s
bic     z23.b, p3/m, z23.b, z13.b
//CHECK: bic     z23.b, p3/m, z23.b, z13.b
asr     z21.s, p5/m, z21.s, #22
//CHECK: asr     z21.s, p5/m, z21.s, #22
ucvtf   z23.h, p3/m, z13.s
//CHECK: ucvtf   z23.h, p3/m, z13.s
adr     z23.s, [z13.s, z8.s, lsl #2]
//CHECK: adr     z23.s, [z13.s, z8.s, lsl #2]
orr     z31.h, p7/m, z31.h, z31.h
//CHECK: orr     z31.h, p7/m, z31.h, z31.h
fmin    z0.s, p0/m, z0.s, z0.s
//CHECK: fmin    z0.s, p0/m, z0.s, z0.s
smax    z23.d, z23.d, #109
//CHECK: smax    z23.d, z23.d, #109
whilelo p5.d, x10, x21
//CHECK: whilelo p5.d, x10, x21
prfb    #7, p3, [z13.d, #8]
//CHECK: prfb    #7, p3, [z13.d, #8]
fexpa   z0.d, z0.d
//CHECK: fexpa   z0.d, z0.d
ldff1w  {z23.d}, p3/z, [x13, x8, lsl #2]
//CHECK: ldff1w  {z23.d}, p3/z, [x13, x8, lsl #2]
frintz  z21.d, p5/m, z10.d
//CHECK: frintz  z21.d, p5/m, z10.d
brkpb   p5.b, p5/z, p10.b, p5.b
//CHECK: brkpb   p5.b, p5/z, p10.b, p5.b
st1h    {z0.s}, p0, [x0, x0, lsl #1]
//CHECK: st1h    {z0.s}, p0, [x0, x0, lsl #1]
prfd    #7, p3, [x13, x8, lsl #3]
//CHECK: prfd    #7, p3, [x13, x8, lsl #3]
cmplt   p7.b, p3/z, z13.b, #8
//CHECK: cmplt   p7.b, p3/z, z13.b, #8
uqdecb  x23, vl256, mul #9
//CHECK: uqdecb  x23, vl256, mul #9
st1b    {z31.d}, p7, [sp, z31.d, uxtw]
//CHECK: st1b    {z31.d}, p7, [sp, z31.d, uxtw]
sub     z23.h, z23.h, #109, lsl #8
//CHECK: sub     z23.h, z23.h, #27904
fmul    z23.h, p3/m, z23.h, z13.h
//CHECK: fmul    z23.h, p3/m, z23.h, z13.h
cmphs   p7.s, p3/z, z13.s, z8.d
//CHECK: cmphs   p7.s, p3/z, z13.s, z8.d
prfb    pldl1keep, p0, [x0, z0.s, uxtw]
//CHECK: prfb    pldl1keep, p0, [x0, z0.s, uxtw]
ld1rqd  {z31.d}, p7/z, [sp, #-16]
//CHECK: ld1rqd  {z31.d}, p7/z, [sp, #-16]
frinti  z21.s, p5/m, z10.s
//CHECK: frinti  z21.s, p5/m, z10.s
ldff1b  {z31.s}, p7/z, [sp, z31.s, uxtw]
//CHECK: ldff1b  {z31.s}, p7/z, [sp, z31.s, uxtw]
uzp1    p5.b, p10.b, p5.b
//CHECK: uzp1    p5.b, p10.b, p5.b
ld1h    {z23.d}, p3/z, [x13, z8.d, lsl #1]
//CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, lsl #1]
lslr    z23.h, p3/m, z23.h, z13.h
//CHECK: lslr    z23.h, p3/m, z23.h, z13.h
smaxv   d21, p5, z10.d
//CHECK: smaxv   d21, p5, z10.d
mls     z23.b, p3/m, z13.b, z8.b
//CHECK: mls     z23.b, p3/m, z13.b, z8.b
st1h    {z23.h}, p3, [x13, x8, lsl #1]
//CHECK: st1h    {z23.h}, p3, [x13, x8, lsl #1]
mov     z21.s, p5/m, w10
//CHECK: mov     z21.s, p5/m, w10
uzp1    z21.h, z10.h, z21.h
//CHECK: uzp1    z21.h, z10.h, z21.h
prfw    #15, p7, [sp, z31.d, lsl #2]
//CHECK: prfw    #15, p7, [sp, z31.d, lsl #2]
fmulx   z21.d, p5/m, z21.d, z10.d
//CHECK: fmulx   z21.d, p5/m, z21.d, z10.d
ldff1h  {z0.s}, p0/z, [x0, z0.s, uxtw #1]
//CHECK: ldff1h  {z0.s}, p0/z, [x0, z0.s, uxtw #1]
ldff1h  {z23.s}, p3/z, [z13.s, #16]
//CHECK: ldff1h  {z23.s}, p3/z, [z13.s, #16]
ld1sw   {z31.d}, p7/z, [sp, z31.d]
//CHECK: ld1sw   {z31.d}, p7/z, [sp, z31.d]
ld1b    {z5.s}, p3/z, [x17, x16]
//CHECK: ld1b    {z5.s}, p3/z, [x17, x16]
frintp  z23.h, p3/m, z13.h
//CHECK: frintp  z23.h, p3/m, z13.h
rdvl    x21, #-22
//CHECK: rdvl    x21, #-22
ldff1h  {z21.d}, p5/z, [x10, x21, lsl #1]
//CHECK: ldff1h  {z21.d}, p5/z, [x10, x21, lsl #1]
fnmsb   z23.d, p3/m, z13.d, z8.d
//CHECK: fnmsb   z23.d, p3/m, z13.d, z8.d
uqdecp  z31.d, p15
//CHECK: uqdecp  z31.d, p15
and     z23.d, z13.d, z8.d
//CHECK: and     z23.d, z13.d, z8.d
prfd    #15, p7, [sp, z31.s, sxtw #3]
//CHECK: prfd    #15, p7, [sp, z31.s, sxtw #3]
frinti  z0.h, p0/m, z0.h
//CHECK: frinti  z0.h, p0/m, z0.h
rev     z21.b, z10.b
//CHECK: rev     z21.b, z10.b
fdiv    z0.d, p0/m, z0.d, z0.d
//CHECK: fdiv    z0.d, p0/m, z0.d, z0.d
fscale  z0.s, p0/m, z0.s, z0.s
//CHECK: fscale  z0.s, p0/m, z0.s, z0.s
adr     z0.d, [z0.d, z0.d, lsl #1]
//CHECK: adr     z0.d, [z0.d, z0.d, lsl #1]
uzp1    z31.s, z31.s, z31.s
//CHECK: uzp1    z31.s, z31.s, z31.s
cmpge   p7.s, p3/z, z13.s, #8
//CHECK: cmpge   p7.s, p3/z, z13.s, #8
fneg    z31.d, p7/m, z31.d
//CHECK: fneg    z31.d, p7/m, z31.d
index   z23.b, #13, #8
//CHECK: index   z23.b, #13, #8
index   z0.s, #0, #0
//CHECK: index   z0.s, #0, #0
prfh    pldl1keep, p0, [x0, z0.d, lsl #1]
//CHECK: prfh    pldl1keep, p0, [x0, z0.d, lsl #1]
ldff1w  {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ldff1w  {z23.d}, p3/z, [x13, z8.d, uxtw]
st1h    {z23.d}, p3, [x13, x8, lsl #1]
//CHECK: st1h    {z23.d}, p3, [x13, x8, lsl #1]
cmplt   p0.b, p0/z, z0.b, z0.d
//CHECK: cmplt   p0.b, p0/z, z0.b, z0.d
ld1h    {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, uxtw]
ldnf1sh {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1sh {z31.s}, p7/z, [sp, #-1, mul vl]
orr     z31.s, p7/m, z31.s, z31.s
//CHECK: orr     z31.s, p7/m, z31.s, z31.s
trn1    z21.d, z10.d, z21.d
//CHECK: trn1    z21.d, z10.d, z21.d
lslr    z0.s, p0/m, z0.s, z0.s
//CHECK: lslr    z0.s, p0/m, z0.s, z0.s
mov     z21.h, p5/m, #-86
//CHECK: mov     z21.h, p5/m, #-86
udot    z23.s, z13.b, z0.b[1]
//CHECK: udot    z23.s, z13.b, z0.b[1]
fcvtzu  z23.s, p3/m, z13.h
//CHECK: fcvtzu  z23.s, p3/m, z13.h
fcvtzu  z21.s, p5/m, z10.d
//CHECK: fcvtzu  z21.s, p5/m, z10.d
fmla    z23.d, p3/m, z13.d, z8.d
//CHECK: fmla    z23.d, p3/m, z13.d, z8.d
whilele p0.h, x0, x0
//CHECK: whilele p0.h, x0, x0
st1w    {z21.s}, p5, [x10, #5, mul vl]
//CHECK: st1w    {z21.s}, p5, [x10, #5, mul vl]
ld1sb   {z5.s}, p3/z, [x17, x16]
//CHECK: ld1sb   {z5.s}, p3/z, [x17, x16]
sqdecp  z31.h, p15
//CHECK: sqdecp  z31.h, p15
whilele p15.d, wzr, wzr
//CHECK: whilele p15.d, wzr, wzr
prfb    #15, p7, [sp, #-1, mul vl]
//CHECK: prfb    #15, p7, [sp, #-1, mul vl]
ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, x21, lsl #3]
//CHECK: ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, x21, lsl #3]
uqincp  z23.h, p13
//CHECK: uqincp  z23.h, p13
fmax    z0.h, p0/m, z0.h, #0.0
//CHECK: fmax    z0.h, p0/m, z0.h, #0.0
sqdecp  x23, p13.h
//CHECK: sqdecp  x23, p13.h
ucvtf   z23.s, p3/m, z13.d
//CHECK: ucvtf   z23.s, p3/m, z13.d
sqdecw  x23, vl256, mul #9
//CHECK: sqdecw  x23, vl256, mul #9
uqdech  w0, pow2
//CHECK: uqdech  w0, pow2
sqincp  x23, p13.h
//CHECK: sqincp  x23, p13.h
ldnf1h  {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1h  {z21.d}, p5/z, [x10, #5, mul vl]
clasta  wzr, p7, wzr, z31.b
//CHECK: clasta  wzr, p7, wzr, z31.b
uqdecw  w23, vl256, mul #9
//CHECK: uqdecw  w23, vl256, mul #9
ld1b    {z31.d}, p7/z, [z31.d, #31]
//CHECK: ld1b    {z31.d}, p7/z, [z31.d, #31]
fnmad   z21.s, p5/m, z10.s, z21.s
//CHECK: fnmad   z21.s, p5/m, z10.s, z21.s
fcmgt   p15.s, p7/z, z31.s, #0.0
//CHECK: fcmgt   p15.s, p7/z, z31.s, #0.0
zip2    p5.b, p10.b, p5.b
//CHECK: zip2    p5.b, p10.b, p5.b
whilelo p7.s, x13, x8
//CHECK: whilelo p7.s, x13, x8
frsqrts z23.s, z13.s, z8.s
//CHECK: frsqrts z23.s, z13.s, z8.s
frsqrts z0.d, z0.d, z0.d
//CHECK: frsqrts z0.d, z0.d, z0.d
whilelt p15.s, xzr, xzr
//CHECK: whilelt p15.s, xzr, xzr
asrd    z23.d, p3/m, z23.d, #19
//CHECK: asrd    z23.d, p3/m, z23.d, #19
sqdecp  z31.d, p15
//CHECK: sqdecp  z31.d, p15
lsl     z21.b, p5/m, z21.b, #2
//CHECK: lsl     z21.b, p5/m, z21.b, #2
brkpa   p15.b, p15/z, p15.b, p15.b
//CHECK: brkpa   p15.b, p15/z, p15.b, p15.b
cmphs   p5.s, p5/z, z10.s, #85
//CHECK: cmphs   p5.s, p5/z, z10.s, #85
mov     z31.s, p7/m, wsp
//CHECK: mov     z31.s, p7/m, wsp
ld1rsb  {z21.d}, p5/z, [x10, #21]
//CHECK: ld1rsb  {z21.d}, p5/z, [x10, #21]
adr     z31.d, [z31.d, z31.d]
//CHECK: adr     z31.d, [z31.d, z31.d]
ldff1sh {z0.d}, p0/z, [x0, x0, lsl #1]
//CHECK: ldff1sh {z0.d}, p0/z, [x0, x0, lsl #1]
zip1    p5.s, p10.s, p5.s
//CHECK: zip1    p5.s, p10.s, p5.s
cmpeq   p15.b, p7/z, z31.b, #-1
//CHECK: cmpeq   p15.b, p7/z, z31.b, #-1
fdiv    z23.d, p3/m, z23.d, z13.d
//CHECK: fdiv    z23.d, p3/m, z23.d, z13.d
revb    z0.s, p0/m, z0.s
//CHECK: revb    z0.s, p0/m, z0.s
ldff1b  {z31.b}, p7/z, [sp, xzr]
//CHECK: ldff1b  {z31.b}, p7/z, [sp]
ld1d    {z21.d}, p5/z, [z10.d, #168]
//CHECK: ld1d    {z21.d}, p5/z, [z10.d, #168]
fdivr   z31.s, p7/m, z31.s, z31.s
//CHECK: fdivr   z31.s, p7/m, z31.s, z31.s
ld1sb   {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ld1sb   {z0.d}, p0/z, [x0, z0.d, uxtw]
fsub    z0.h, p0/m, z0.h, z0.h
//CHECK: fsub    z0.h, p0/m, z0.h, z0.h
index   z0.b, #0, w0
//CHECK: index   z0.b, #0, w0
ld2b    {z0.b, z1.b}, p0/z, [x0, x0]
//CHECK: ld2b    {z0.b, z1.b}, p0/z, [x0, x0]
fsub    z21.s, p5/m, z21.s, z10.s
//CHECK: fsub    z21.s, p5/m, z21.s, z10.s
uqdecw  z0.s, pow2
//CHECK: uqdecw  z0.s, pow2
ld1h    {z0.s}, p0/z, [x0, z0.s, sxtw #1]
//CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, sxtw #1]
uqadd   z23.h, z13.h, z8.h
//CHECK: uqadd   z23.h, z13.h, z8.h
uminv   b23, p3, z13.b
//CHECK: uminv   b23, p3, z13.b
umulh   z21.s, p5/m, z21.s, z10.s
//CHECK: umulh   z21.s, p5/m, z21.s, z10.s
brkpbs  p0.b, p0/z, p0.b, p0.b
//CHECK: brkpbs  p0.b, p0/z, p0.b, p0.b
trn2    z0.h, z0.h, z0.h
//CHECK: trn2    z0.h, z0.h, z0.h
whilelt p7.b, w13, w8
//CHECK: whilelt p7.b, w13, w8
uzp2    z21.h, z10.h, z21.h
//CHECK: uzp2    z21.h, z10.h, z21.h
smaxv   h21, p5, z10.h
//CHECK: smaxv   h21, p5, z10.h
compact z0.d, p0, z0.d
//CHECK: compact z0.d, p0, z0.d
ld2w    {z23.s, z24.s}, p3/z, [x13, x8, lsl #2]
//CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, x8, lsl #2]
mov     z31.h, p7/m, wsp
//CHECK: mov     z31.h, p7/m, wsp
index   z31.s, wzr, wzr
//CHECK: index   z31.s, wzr, wzr
rev     p5.b, p10.b
//CHECK: rev     p5.b, p10.b
st1b    {z21.d}, p5, [x10, x21]
//CHECK: st1b    {z21.d}, p5, [x10, x21]
add     z31.d, z31.d, #255, lsl #8
//CHECK: add     z31.d, z31.d, #65280
add     z23.b, p3/m, z23.b, z13.b
//CHECK: add     z23.b, p3/m, z23.b, z13.b
frintz  z0.s, p0/m, z0.s
//CHECK: frintz  z0.s, p0/m, z0.s
trn1    p0.d, p0.d, p0.d
//CHECK: trn1    p0.d, p0.d, p0.d
sqsub   z31.h, z31.h, z31.h
//CHECK: sqsub   z31.h, z31.h, z31.h
lsrr    z23.d, p3/m, z23.d, z13.d
//CHECK: lsrr    z23.d, p3/m, z23.d, z13.d
uunpkhi z31.h, z31.b
//CHECK: uunpkhi z31.h, z31.b
ldff1b  {z23.d}, p3/z, [z13.d, #8]
//CHECK: ldff1b  {z23.d}, p3/z, [z13.d, #8]
asr     z23.s, p3/m, z23.s, z13.s
//CHECK: asr     z23.s, p3/m, z23.s, z13.s
revb    z0.d, p0/m, z0.d
//CHECK: revb    z0.d, p0/m, z0.d
brkn    p5.b, p5/z, p10.b, p5.b
//CHECK: brkn    p5.b, p5/z, p10.b, p5.b
mla     z23.b, p3/m, z13.b, z8.b
//CHECK: mla     z23.b, p3/m, z13.b, z8.b
fcmla   z23.d, p3/m, z13.d, z8.d, #270
//CHECK: fcmla   z23.d, p3/m, z13.d, z8.d, #270
clasta  d23, p3, d23, z13.d
//CHECK: clasta  d23, p3, d23, z13.d
lsl     z31.h, p7/m, z31.h, z31.d
//CHECK: lsl     z31.h, p7/m, z31.h, z31.d
lsl     z31.b, p7/m, z31.b, #7
//CHECK: lsl     z31.b, p7/m, z31.b, #7
uqincb  x21, vl32, mul #6
//CHECK: uqincb  x21, vl32, mul #6
ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl]
//CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl]
lsr     z0.d, p0/m, z0.d, #64
//CHECK: lsr     z0.d, p0/m, z0.d, #64
st2b    {z5.b, z6.b}, p3, [x17, x16]
//CHECK: st2b    {z5.b, z6.b}, p3, [x17, x16]
fdiv    z21.s, p5/m, z21.s, z10.s
//CHECK: fdiv    z21.s, p5/m, z21.s, z10.s
clasta  h31, p7, h31, z31.h
//CHECK: clasta  h31, p7, h31, z31.h
ld1rb   {z21.d}, p5/z, [x10, #21]
//CHECK: ld1rb   {z21.d}, p5/z, [x10, #21]
tbl     z21.h, {z10.h}, z21.h
//CHECK: tbl     z21.h, {z10.h}, z21.h
ftsmul  z0.s, z0.s, z0.s
//CHECK: ftsmul  z0.s, z0.s, z0.s
inch    x23, vl256, mul #9
//CHECK: inch    x23, vl256, mul #9
abs     z23.h, p3/m, z13.h
//CHECK: abs     z23.h, p3/m, z13.h
cnot    z23.d, p3/m, z13.d
//CHECK: cnot    z23.d, p3/m, z13.d
fcmgt   p7.h, p3/z, z13.h, #0.0
//CHECK: fcmgt   p7.h, p3/z, z13.h, #0.0
lsr     z23.h, p3/m, z23.h, z13.h
//CHECK: lsr     z23.h, p3/m, z23.h, z13.h
ldff1sb {z0.s}, p0/z, [z0.s]
//CHECK: ldff1sb {z0.s}, p0/z, [z0.s]
fsubr   z31.s, p7/m, z31.s, z31.s
//CHECK: fsubr   z31.s, p7/m, z31.s, z31.s
lasta   w0, p0, z0.b
//CHECK: lasta   w0, p0, z0.b
fminnmv d23, p3, z13.d
//CHECK: fminnmv d23, p3, z13.d
lslr    z21.b, p5/m, z21.b, z10.b
//CHECK: lslr    z21.b, p5/m, z21.b, z10.b
ldff1sw {z23.d}, p3/z, [z13.d, #32]
//CHECK: ldff1sw {z23.d}, p3/z, [z13.d, #32]
mla     z23.h, p3/m, z13.h, z8.h
//CHECK: mla     z23.h, p3/m, z13.h, z8.h
cmplo   p15.s, p7/z, z31.s, #127
//CHECK: cmplo   p15.s, p7/z, z31.s, #127
not     z21.d, p5/m, z10.d
//CHECK: not     z21.d, p5/m, z10.d
trn2    z31.h, z31.h, z31.h
//CHECK: trn2    z31.h, z31.h, z31.h
fabd    z31.s, p7/m, z31.s, z31.s
//CHECK: fabd    z31.s, p7/m, z31.s, z31.s
uxtb    z23.s, p3/m, z13.s
//CHECK: uxtb    z23.s, p3/m, z13.s
uqincd  w23, vl256, mul #9
//CHECK: uqincd  w23, vl256, mul #9
brkb    p5.b, p5/z, p10.b
//CHECK: brkb    p5.b, p5/z, p10.b
uqdech  xzr, all, mul #16
//CHECK: uqdech  xzr, all, mul #16
fadd    z31.d, p7/m, z31.d, #1.0
//CHECK: fadd    z31.d, p7/m, z31.d, #1.0
eor     z21.s, p5/m, z21.s, z10.s
//CHECK: eor     z21.s, p5/m, z21.s, z10.s
mov     z5.b, #113
//CHECK: mov     z5.b, #113
insr    z21.h, w10
//CHECK: insr    z21.h, w10
ld1rd   {z0.d}, p0/z, [x0]
//CHECK: ld1rd   {z0.d}, p0/z, [x0]
lsr     z0.s, p0/m, z0.s, z0.s
//CHECK: lsr     z0.s, p0/m, z0.s, z0.s
ldff1sb {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ldff1sb {z31.d}, p7/z, [sp, z31.d, uxtw]
fcvt    z23.d, p3/m, z13.h
//CHECK: fcvt    z23.d, p3/m, z13.h
abs     z0.d, p0/m, z0.d
//CHECK: abs     z0.d, p0/m, z0.d
lastb   b21, p5, z10.b
//CHECK: lastb   b21, p5, z10.b
fmaxnm  z23.s, p3/m, z23.s, #1.0
//CHECK: fmaxnm  z23.s, p3/m, z23.s, #1.0
whilelo p15.h, wzr, wzr
//CHECK: whilelo p15.h, wzr, wzr
st3h    {z5.h, z6.h, z7.h}, p3, [x17, x16, lsl #1]
//CHECK: st3h    {z5.h, z6.h, z7.h}, p3, [x17, x16, lsl #1]
mul     z31.d, z31.d, #-1
//CHECK: mul     z31.d, z31.d, #-1
add     z0.s, z0.s, z0.s
//CHECK: add     z0.s, z0.s, z0.s
umax    z21.b, p5/m, z21.b, z10.b
//CHECK: umax    z21.b, p5/m, z21.b, z10.b
mov     z21.b, p5/m, z10.b
//CHECK: mov     z21.b, p5/m, z10.b
fcmge   p5.s, p5/z, z10.s, #0.0
//CHECK: fcmge   p5.s, p5/z, z10.s, #0.0
trn1    z0.h, z0.h, z0.h
//CHECK: trn1    z0.h, z0.h, z0.h
fmls    z0.h, p0/m, z0.h, z0.h
//CHECK: fmls    z0.h, p0/m, z0.h, z0.h
fcvtzu  z31.s, p7/m, z31.s
//CHECK: fcvtzu  z31.s, p7/m, z31.s
ctermne w0, w0
//CHECK: ctermne w0, w0
udot    z23.d, z13.h, z8.h
//CHECK: udot    z23.d, z13.h, z8.h
sxtb    z31.h, p7/m, z31.h
//CHECK: sxtb    z31.h, p7/m, z31.h
uxtw    z21.d, p5/m, z10.d
//CHECK: uxtw    z21.d, p5/m, z10.d
clastb  b23, p3, b23, z13.b
//CHECK: clastb  b23, p3, b23, z13.b
ld1rb   {z31.s}, p7/z, [sp, #63]
//CHECK: ld1rb   {z31.s}, p7/z, [sp, #63]
mov     z31.b, p7/m, wsp
//CHECK: mov     z31.b, p7/m, wsp
ld1h    {z21.h}, p5/z, [x10, #5, mul vl]
//CHECK: ld1h    {z21.h}, p5/z, [x10, #5, mul vl]
sub     z23.d, z23.d, #109, lsl #8
//CHECK: sub     z23.d, z23.d, #27904
cmpge   p15.b, p7/z, z31.b, #-1
//CHECK: cmpge   p15.b, p7/z, z31.b, #-1
sminv   h21, p5, z10.h
//CHECK: sminv   h21, p5, z10.h
fsub    z0.h, p0/m, z0.h, #0.5
//CHECK: fsub    z0.h, p0/m, z0.h, #0.5
st1w    {z31.d}, p7, [sp, z31.d, sxtw]
//CHECK: st1w    {z31.d}, p7, [sp, z31.d, sxtw]
ld1rqh  {z0.h}, p0/z, [x0]
//CHECK: ld1rqh  {z0.h}, p0/z, [x0]
udot    z21.s, z10.b, z21.b
//CHECK: udot    z21.s, z10.b, z21.b
fcvtzu  z31.s, p7/m, z31.h
//CHECK: fcvtzu  z31.s, p7/m, z31.h
lslr    z23.d, p3/m, z23.d, z13.d
//CHECK: lslr    z23.d, p3/m, z23.d, z13.d
prfh    pldl1keep, p0, [z0.d]
//CHECK: prfh    pldl1keep, p0, [z0.d]
ucvtf   z0.h, p0/m, z0.d
//CHECK: ucvtf   z0.h, p0/m, z0.d
uqdecp  z21.d, p10
//CHECK: uqdecp  z21.d, p10
ldnf1sb {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1sb {z31.s}, p7/z, [sp, #-1, mul vl]
mul     z23.b, p3/m, z23.b, z13.b
//CHECK: mul     z23.b, p3/m, z23.b, z13.b
ld1sb   {z31.s}, p7/z, [z31.s, #31]
//CHECK: ld1sb   {z31.s}, p7/z, [z31.s, #31]
uqsub   z23.h, z23.h, #109, lsl #8
//CHECK: uqsub   z23.h, z23.h, #27904
prfh    pldl3strm, p5, [x10, z21.d, uxtw #1]
//CHECK: prfh    pldl3strm, p5, [x10, z21.d, uxtw #1]
cntp    x0, p0, p0.h
//CHECK: cntp    x0, p0, p0.h
ld1b    {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ld1b    {z31.d}, p7/z, [sp, z31.d, sxtw]
frecpe  z31.h, z31.h
//CHECK: frecpe  z31.h, z31.h
st1d    {z21.d}, p5, [x10, x21, lsl #3]
//CHECK: st1d    {z21.d}, p5, [x10, x21, lsl #3]
index   z23.b, w13, #8
//CHECK: index   z23.b, w13, #8
sqincp  z23.s, p13
//CHECK: sqincp  z23.s, p13
cnt     z21.s, p5/m, z10.s
//CHECK: cnt     z21.s, p5/m, z10.s
ldff1b  {z23.s}, p3/z, [x13, x8]
//CHECK: ldff1b  {z23.s}, p3/z, [x13, x8]
index   z21.b, #10, w21
//CHECK: index   z21.b, #10, w21
cmplo   p15.h, p7/z, z31.h, #127
//CHECK: cmplo   p15.h, p7/z, z31.h, #127
uqincd  w21, vl32, mul #6
//CHECK: uqincd  w21, vl32, mul #6
ldff1b  {z31.d}, p7/z, [sp, xzr]
//CHECK: ldff1b  {z31.d}, p7/z, [sp]
ld1sb   {z0.s}, p0/z, [x0, z0.s, sxtw]
//CHECK: ld1sb   {z0.s}, p0/z, [x0, z0.s, sxtw]
ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, #20, mul vl]
//CHECK: ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, #20, mul vl]
decp    x23, p13.d
//CHECK: decp    x23, p13.d
lsr     z0.b, z0.b, z0.d
//CHECK: lsr     z0.b, z0.b, z0.d
uunpkhi z0.d, z0.s
//CHECK: uunpkhi z0.d, z0.s
st2h    {z31.h, z0.h}, p7, [sp, #-2, mul vl]
//CHECK: st2h    {z31.h, z0.h}, p7, [sp, #-2, mul vl]
lslr    z31.b, p7/m, z31.b, z31.b
//CHECK: lslr    z31.b, p7/m, z31.b, z31.b
zip1    p5.b, p10.b, p5.b
//CHECK: zip1    p5.b, p10.b, p5.b
cmphi   p0.b, p0/z, z0.b, #0
//CHECK: cmphi   p0.b, p0/z, z0.b, #0
prfd    pldl3strm, p5, [x10, z21.d, sxtw #3]
//CHECK: prfd    pldl3strm, p5, [x10, z21.d, sxtw #3]
ldff1sh {z0.s}, p0/z, [x0, x0, lsl #1]
//CHECK: ldff1sh {z0.s}, p0/z, [x0, x0, lsl #1]
cls     z23.h, p3/m, z13.h
//CHECK: cls     z23.h, p3/m, z13.h
ftssel  z23.d, z13.d, z8.d
//CHECK: ftssel  z23.d, z13.d, z8.d
fmaxnmv h23, p3, z13.h
//CHECK: fmaxnmv h23, p3, z13.h
fneg    z0.h, p0/m, z0.h
//CHECK: fneg    z0.h, p0/m, z0.h
fcmeq   p5.d, p5/z, z10.d, z21.d
//CHECK: fcmeq   p5.d, p5/z, z10.d, z21.d
st1h    {z0.d}, p0, [x0, z0.d, lsl #1]
//CHECK: st1h    {z0.d}, p0, [x0, z0.d, lsl #1]
cmphi   p0.b, p0/z, z0.b, z0.d
//CHECK: cmphi   p0.b, p0/z, z0.b, z0.d
not     z31.d, p7/m, z31.d
//CHECK: not     z31.d, p7/m, z31.d
fcmeq   p5.h, p5/z, z10.h, #0.0
//CHECK: fcmeq   p5.h, p5/z, z10.h, #0.0
cmpls   p7.d, p3/z, z13.d, #35
//CHECK: cmpls   p7.d, p3/z, z13.d, #35
whilelo p7.s, w13, w8
//CHECK: whilelo p7.s, w13, w8
fcmgt   p0.d, p0/z, z0.d, #0.0
//CHECK: fcmgt   p0.d, p0/z, z0.d, #0.0
orv     b23, p3, z13.b
//CHECK: orv     b23, p3, z13.b
sub     z31.h, z31.h, #255, lsl #8
//CHECK: sub     z31.h, z31.h, #65280
sqincp  x23, p13.b
//CHECK: sqincp  x23, p13.b
mla     z31.s, p7/m, z31.s, z31.s
//CHECK: mla     z31.s, p7/m, z31.s, z31.s
insr    z0.d, x0
//CHECK: insr    z0.d, x0
index   z31.h, wzr, wzr
//CHECK: index   z31.h, wzr, wzr
frecps  z21.h, z10.h, z21.h
//CHECK: frecps  z21.h, z10.h, z21.h
ldff1w  {z23.d}, p3/z, [x13, z8.d, uxtw #2]
//CHECK: ldff1w  {z23.d}, p3/z, [x13, z8.d, uxtw #2]
sub     z1.b, z1.b, #33
//CHECK: sub     z1.b, z1.b, #33
cmpne   p0.b, p0/z, z0.b, #0
//CHECK: cmpne   p0.b, p0/z, z0.b, #0
mov     z5.q, z17.q[3]
//CHECK: mov     z5.q, z17.q[3]
ext     z0.b, z0.b, z0.b, #0
//CHECK: ext     z0.b, z0.b, z0.b, #0
whilelo p7.b, w13, w8
//CHECK: whilelo p7.b, w13, w8
ldff1d  {z23.d}, p3/z, [x13, x8, lsl #3]
//CHECK: ldff1d  {z23.d}, p3/z, [x13, x8, lsl #3]
cmpgt   p0.h, p0/z, z0.h, #0
//CHECK: cmpgt   p0.h, p0/z, z0.h, #0
ucvtf   z0.d, p0/m, z0.s
//CHECK: ucvtf   z0.d, p0/m, z0.s
umin    z0.d, z0.d, #0
//CHECK: umin    z0.d, z0.d, #0
clastb  z21.h, p5, z21.h, z10.h
//CHECK: clastb  z21.h, p5, z21.h, z10.h
fabs    z0.d, p0/m, z0.d
//CHECK: fabs    z0.d, p0/m, z0.d
eor     z0.h, p0/m, z0.h, z0.h
//CHECK: eor     z0.h, p0/m, z0.h, z0.h
cmphs   p5.b, p5/z, z10.b, z21.d
//CHECK: cmphs   p5.b, p5/z, z10.b, z21.d
uqincp  x21, p10.s
//CHECK: uqincp  x21, p10.s
sqincp  x23, p13.d, w23
//CHECK: sqincp  x23, p13.d, w23
clastb  z31.d, p7, z31.d, z31.d
//CHECK: clastb  z31.d, p7, z31.d, z31.d
cmpgt   p7.b, p3/z, z13.b, #8
//CHECK: cmpgt   p7.b, p3/z, z13.b, #8
ldff1h  {z23.s}, p3/z, [x13, z8.s, uxtw]
//CHECK: ldff1h  {z23.s}, p3/z, [x13, z8.s, uxtw]
ld1h    {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1h    {z23.s}, p3/z, [x13, #-8, mul vl]
cmpeq   p15.b, p7/z, z31.b, z31.d
//CHECK: cmpeq   p15.b, p7/z, z31.b, z31.d
incp    x0, p0.h
//CHECK: incp    x0, p0.h
fmov    z21.s, #-13.0
//CHECK: fmov    z21.s, #-13.0
zip2    z0.s, z0.s, z0.s
//CHECK: zip2    z0.s, z0.s, z0.s
ptrues  p7.b, vl256
//CHECK: ptrues  p7.b, vl256
ld4w    {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0, x0, lsl #2]
//CHECK: ld4w    {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0, x0, lsl #2]
umax    z31.h, z31.h, #255
//CHECK: umax    z31.h, z31.h, #255
st1h    {z31.d}, p7, [sp, z31.d, sxtw]
//CHECK: st1h    {z31.d}, p7, [sp, z31.d, sxtw]
trn2    z21.d, z10.d, z21.d
//CHECK: trn2    z21.d, z10.d, z21.d
ld1h    {z0.d}, p0/z, [x0]
//CHECK: ld1h    {z0.d}, p0/z, [x0]
ldff1sw {z0.d}, p0/z, [z0.d]
//CHECK: ldff1sw {z0.d}, p0/z, [z0.d]
ptrue   p7.s, vl256
//CHECK: ptrue   p7.s, vl256
stnt1h  {z23.h}, p3, [x13, #-8, mul vl]
//CHECK: stnt1h  {z23.h}, p3, [x13, #-8, mul vl]
sabd    z21.b, p5/m, z21.b, z10.b
//CHECK: sabd    z21.b, p5/m, z21.b, z10.b
sqdecp  z31.s, p15
//CHECK: sqdecp  z31.s, p15
ldff1sb {z31.s}, p7/z, [sp, z31.s, sxtw]
//CHECK: ldff1sb {z31.s}, p7/z, [sp, z31.s, sxtw]
lsl     z31.b, z31.b, #7
//CHECK: lsl     z31.b, z31.b, #7
ld1rsh  {z21.s}, p5/z, [x10, #42]
//CHECK: ld1rsh  {z21.s}, p5/z, [x10, #42]
trn1    z0.b, z0.b, z0.b
//CHECK: trn1    z0.b, z0.b, z0.b
stnt1b  {z0.b}, p0, [x0]
//CHECK: stnt1b  {z0.b}, p0, [x0]
st1h    {z21.s}, p5, [z10.s, #42]
//CHECK: st1h    {z21.s}, p5, [z10.s, #42]
ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw #1]
//CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw #1]
frintm  z21.d, p5/m, z10.d
//CHECK: frintm  z21.d, p5/m, z10.d
sqdecp  z21.d, p10
//CHECK: sqdecp  z21.d, p10
frintn  z23.h, p3/m, z13.h
//CHECK: frintn  z23.h, p3/m, z13.h
sqincp  x0, p0.s
//CHECK: sqincp  x0, p0.s
sqdecb  x0, pow2
//CHECK: sqdecb  x0, pow2
ucvtf   z31.s, p7/m, z31.s
//CHECK: ucvtf   z31.s, p7/m, z31.s
lastb   w0, p0, z0.s
//CHECK: lastb   w0, p0, z0.s
trn1    p15.s, p15.s, p15.s
//CHECK: trn1    p15.s, p15.s, p15.s
pnext   p5.d, p10, p5.d
//CHECK: pnext   p5.d, p10, p5.d
fcvt    z31.s, p7/m, z31.h
//CHECK: fcvt    z31.s, p7/m, z31.h
fmax    z23.h, p3/m, z23.h, #1.0
//CHECK: fmax    z23.h, p3/m, z23.h, #1.0
st3d    {z31.d, z0.d, z1.d}, p7, [sp, #-3, mul vl]
//CHECK: st3d    {z31.d, z0.d, z1.d}, p7, [sp, #-3, mul vl]
ld1sb   {z0.s}, p0/z, [x0, z0.s, uxtw]
//CHECK: ld1sb   {z0.s}, p0/z, [x0, z0.s, uxtw]
ldff1w  {z21.s}, p5/z, [z10.s, #84]
//CHECK: ldff1w  {z21.s}, p5/z, [z10.s, #84]
subr    z31.s, p7/m, z31.s, z31.s
//CHECK: subr    z31.s, p7/m, z31.s, z31.s
addpl   x21, x21, #-22
//CHECK: addpl   x21, x21, #-22
ldff1w  {z31.s}, p7/z, [z31.s, #124]
//CHECK: ldff1w  {z31.s}, p7/z, [z31.s, #124]
ld1d    {z0.d}, p0/z, [z0.d]
//CHECK: ld1d    {z0.d}, p0/z, [z0.d]
prfh    #15, p7, [z31.s, #62]
//CHECK: prfh    #15, p7, [z31.s, #62]
mla     z0.b, p0/m, z0.b, z0.b
//CHECK: mla     z0.b, p0/m, z0.b, z0.b
ldff1sw {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, sxtw]
smin    z23.h, p3/m, z23.h, z13.h
//CHECK: smin    z23.h, p3/m, z23.h, z13.h
cls     z0.h, p0/m, z0.h
//CHECK: cls     z0.h, p0/m, z0.h
ptrues  p7.d, vl256
//CHECK: ptrues  p7.d, vl256
ldnt1d  {z21.d}, p5/z, [x10, x21, lsl #3]
//CHECK: ldnt1d  {z21.d}, p5/z, [x10, x21, lsl #3]
uqdecp  z0.d, p0
//CHECK: uqdecp  z0.d, p0
prfh    pldl3strm, p5, [x10, z21.s, sxtw #1]
//CHECK: prfh    pldl3strm, p5, [x10, z21.s, sxtw #1]
ld1sb   {z23.d}, p3/z, [x13, x8]
//CHECK: ld1sb   {z23.d}, p3/z, [x13, x8]
ucvtf   z23.d, p3/m, z13.s
//CHECK: ucvtf   z23.d, p3/m, z13.s
ld1b    {z31.s}, p7/z, [sp, z31.s, uxtw]
//CHECK: ld1b    {z31.s}, p7/z, [sp, z31.s, uxtw]
ld2b    {z23.b, z24.b}, p3/z, [x13, x8]
//CHECK: ld2b    {z23.b, z24.b}, p3/z, [x13, x8]
fmaxnm  z23.s, p3/m, z23.s, z13.s
//CHECK: fmaxnm  z23.s, p3/m, z23.s, z13.s
frintm  z31.d, p7/m, z31.d
//CHECK: frintm  z31.d, p7/m, z31.d
rbit    z23.h, p3/m, z13.h
//CHECK: rbit    z23.h, p3/m, z13.h
lsl     z31.h, z31.h, #15
//CHECK: lsl     z31.h, z31.h, #15
ldff1w  {z23.s}, p3/z, [x13, x8, lsl #2]
//CHECK: ldff1w  {z23.s}, p3/z, [x13, x8, lsl #2]
uaddv   d31, p7, z31.d
//CHECK: uaddv   d31, p7, z31.d
ld1rw   {z23.s}, p3/z, [x13, #32]
//CHECK: ld1rw   {z23.s}, p3/z, [x13, #32]
cmpne   p5.s, p5/z, z10.s, z21.d
//CHECK: cmpne   p5.s, p5/z, z10.s, z21.d
fminnm  z0.s, p0/m, z0.s, #0.0
//CHECK: fminnm  z0.s, p0/m, z0.s, #0.0
ld1sh   {z5.s}, p3/z, [x17, x16, lsl #1]
//CHECK: ld1sh   {z5.s}, p3/z, [x17, x16, lsl #1]
ldff1sw {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, uxtw]
fmla    z0.h, p0/m, z0.h, z0.h
//CHECK: fmla    z0.h, p0/m, z0.h, z0.h
fcmuo   p7.d, p3/z, z13.d, z8.d
//CHECK: fcmuo   p7.d, p3/z, z13.d, z8.d
ftsmul  z31.s, z31.s, z31.s
//CHECK: ftsmul  z31.s, z31.s, z31.s
ld4w    {z21.s, z22.s, z23.s, z24.s}, p5/z, [x10, #20, mul vl]
//CHECK: ld4w    {z21.s, z22.s, z23.s, z24.s}, p5/z, [x10, #20, mul vl]
prfd    pldl3strm, p5, [x10, z21.s, uxtw #3]
//CHECK: prfd    pldl3strm, p5, [x10, z21.s, uxtw #3]
fsubr   z23.h, p3/m, z23.h, z13.h
//CHECK: fsubr   z23.h, p3/m, z23.h, z13.h
cmpls   p7.s, p3/z, z13.s, z8.d
//CHECK: cmpls   p7.s, p3/z, z13.s, z8.d
sqincp  z31.d, p15
//CHECK: sqincp  z31.d, p15
cmpne   p7.h, p3/z, z13.h, #8
//CHECK: cmpne   p7.h, p3/z, z13.h, #8
add     z31.d, z31.d, z31.d
//CHECK: add     z31.d, z31.d, z31.d
ld1w    {z31.s}, p7/z, [sp, z31.s, sxtw]
//CHECK: ld1w    {z31.s}, p7/z, [sp, z31.s, sxtw]
ld1rsw  {z23.d}, p3/z, [x13, #32]
//CHECK: ld1rsw  {z23.d}, p3/z, [x13, #32]
sabd    z0.b, p0/m, z0.b, z0.b
//CHECK: sabd    z0.b, p0/m, z0.b, z0.b
eor     z21.d, p5/m, z21.d, z10.d
//CHECK: eor     z21.d, p5/m, z21.d, z10.d
brkpas  p7.b, p11/z, p13.b, p8.b
//CHECK: brkpas  p7.b, p11/z, p13.b, p8.b
zip2    p0.h, p0.h, p0.h
//CHECK: zip2    p0.h, p0.h, p0.h
uqdecd  w21, vl32, mul #6
//CHECK: uqdecd  w21, vl32, mul #6
mov     p0.b, p0/m, p0.b
//CHECK: mov     p0.b, p0/m, p0.b
fcmla   z23.s, z13.s, z8.s[0], #270
//CHECK: fcmla   z23.s, z13.s, z8.s[0], #270
bic     z0.d, z0.d, z0.d
//CHECK: bic     z0.d, z0.d, z0.d
fcvt    z23.h, p3/m, z13.s
//CHECK: fcvt    z23.h, p3/m, z13.s
nands   p7.b, p11/z, p13.b, p8.b
//CHECK: nands   p7.b, p11/z, p13.b, p8.b
cnot    z23.s, p3/m, z13.s
//CHECK: cnot    z23.s, p3/m, z13.s
eor     z31.s, p7/m, z31.s, z31.s
//CHECK: eor     z31.s, p7/m, z31.s, z31.s
st3w    {z21.s, z22.s, z23.s}, p5, [x10, #15, mul vl]
//CHECK: st3w    {z21.s, z22.s, z23.s}, p5, [x10, #15, mul vl]
cmple   p5.h, p5/z, z10.h, #-11
//CHECK: cmple   p5.h, p5/z, z10.h, #-11
insr    z0.d, d0
//CHECK: insr    z0.d, d0
frecps  z21.s, z10.s, z21.s
//CHECK: frecps  z21.s, z10.s, z21.s
st1b    {z5.d}, p3, [x17, x16]
//CHECK: st1b    {z5.d}, p3, [x17, x16]
st1w    {z21.s}, p5, [z10.s, #84]
//CHECK: st1w    {z21.s}, p5, [z10.s, #84]
uqadd   z0.d, z0.d, #0
//CHECK: uqadd   z0.d, z0.d, #0
st1h    {z0.d}, p0, [x0, z0.d, sxtw #1]
//CHECK: st1h    {z0.d}, p0, [x0, z0.d, sxtw #1]
clastb  b0, p0, b0, z0.b
//CHECK: clastb  b0, p0, b0, z0.b
ldff1b  {z31.h}, p7/z, [sp, xzr]
//CHECK: ldff1b  {z31.h}, p7/z, [sp]
sqdech  z0.h, pow2
//CHECK: sqdech  z0.h, pow2
cntw    x23, vl256, mul #9
//CHECK: cntw    x23, vl256, mul #9
ld1b    {z21.d}, p5/z, [x10, z21.d]
//CHECK: ld1b    {z21.d}, p5/z, [x10, z21.d]
fcmeq   p0.s, p0/z, z0.s, #0.0
//CHECK: fcmeq   p0.s, p0/z, z0.s, #0.0
ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, #15, mul vl]
//CHECK: ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, #15, mul vl]
ldff1sb {z23.s}, p3/z, [x13, z8.s, uxtw]
//CHECK: ldff1sb {z23.s}, p3/z, [x13, z8.s, uxtw]
prfb    pldl3strm, p5, [x10, z21.d, sxtw]
//CHECK: prfb    pldl3strm, p5, [x10, z21.d, sxtw]
smin    z31.d, z31.d, #-1
//CHECK: smin    z31.d, z31.d, #-1
sel     z23.s, p11, z13.s, z8.s
//CHECK: sel     z23.s, p11, z13.s, z8.s
sqsub   z23.s, z13.s, z8.s
//CHECK: sqsub   z23.s, z13.s, z8.s
ldnf1h  {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1h  {z23.s}, p3/z, [x13, #-8, mul vl]
uqadd   z21.h, z21.h, #170
//CHECK: uqadd   z21.h, z21.h, #170
whilelt p7.s, w13, w8
//CHECK: whilelt p7.s, w13, w8
cmphi   p5.d, p5/z, z10.d, #85
//CHECK: cmphi   p5.d, p5/z, z10.d, #85
ld1h    {z0.d}, p0/z, [x0, z0.d, lsl #1]
//CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, lsl #1]
compact z31.s, p7, z31.s
//CHECK: compact z31.s, p7, z31.s
ld1b    {z23.b}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1b    {z23.b}, p3/z, [x13, #-8, mul vl]
uabd    z0.b, p0/m, z0.b, z0.b
//CHECK: uabd    z0.b, p0/m, z0.b, z0.b
asr     z23.b, z13.b, #8
//CHECK: asr     z23.b, z13.b, #8
bic     z21.d, z10.d, z21.d
//CHECK: bic     z21.d, z10.d, z21.d
st1h    {z31.d}, p7, [sp, z31.d, uxtw #1]
//CHECK: st1h    {z31.d}, p7, [sp, z31.d, uxtw #1]
orv     d31, p7, z31.d
//CHECK: orv     d31, p7, z31.d
prfb    #15, p7, [sp, z31.d, sxtw]
//CHECK: prfb    #15, p7, [sp, z31.d, sxtw]
adr     z31.s, [z31.s, z31.s, lsl #3]
//CHECK: adr     z31.s, [z31.s, z31.s, lsl #3]
asr     z23.b, p3/m, z23.b, #3
//CHECK: asr     z23.b, p3/m, z23.b, #3
lastb   w0, p0, z0.h
//CHECK: lastb   w0, p0, z0.h
st4d    {z0.d, z1.d, z2.d, z3.d}, p0, [x0, x0, lsl #3]
//CHECK: st4d    {z0.d, z1.d, z2.d, z3.d}, p0, [x0, x0, lsl #3]
ld1rqb  {z23.b}, p3/z, [x13, #-128]
//CHECK: ld1rqb  {z23.b}, p3/z, [x13, #-128]
mov     z23.s, #109, lsl #8
//CHECK: mov     z23.s, #27904
mov     z0.d, x0
//CHECK: mov     z0.d, x0
fcvtzs  z21.d, p5/m, z10.h
//CHECK: fcvtzs  z21.d, p5/m, z10.h
sdiv    z23.d, p3/m, z23.d, z13.d
//CHECK: sdiv    z23.d, p3/m, z23.d, z13.d
cnt     z21.b, p5/m, z10.b
//CHECK: cnt     z21.b, p5/m, z10.b
rev     z31.d, z31.d
//CHECK: rev     z31.d, z31.d
clastb  h23, p3, h23, z13.h
//CHECK: clastb  h23, p3, h23, z13.h
frinti  z0.d, p0/m, z0.d
//CHECK: frinti  z0.d, p0/m, z0.d
mla     z0.h, p0/m, z0.h, z0.h
//CHECK: mla     z0.h, p0/m, z0.h, z0.h
ld1rsw  {z31.d}, p7/z, [sp, #252]
//CHECK: ld1rsw  {z31.d}, p7/z, [sp, #252]
ld4h    {z23.h, z24.h, z25.h, z26.h}, p3/z, [x13, #-32, mul vl]
//CHECK: ld4h    {z23.h, z24.h, z25.h, z26.h}, p3/z, [x13, #-32, mul vl]
ld1w    {z23.s}, p3/z, [x13, z8.s, sxtw #2]
//CHECK: ld1w    {z23.s}, p3/z, [x13, z8.s, sxtw #2]
rdffr   p15.b, p15/z
//CHECK: rdffr   p15.b, p15/z
prfb    pldl1keep, p0, [z0.d]
//CHECK: prfb    pldl1keep, p0, [z0.d]
frinti  z23.s, p3/m, z13.s
//CHECK: frinti  z23.s, p3/m, z13.s
ld1rsb  {z23.s}, p3/z, [x13, #8]
//CHECK: ld1rsb  {z23.s}, p3/z, [x13, #8]
ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0, x0, lsl #3]
//CHECK: ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0, x0, lsl #3]
sqincw  z21.s, vl32, mul #6
//CHECK: sqincw  z21.s, vl32, mul #6
movprfx z21.h, p5/z, z10.h
//CHECK: movprfx z21.h, p5/z, z10.h
add     z21.h, p5/m, z21.h, z22.h
//CHECK: add z21.h, p5/m, z21.h, z22.h
whilelo p5.s, x10, x21
//CHECK: whilelo p5.s, x10, x21
fmax    z31.d, p7/m, z31.d, z31.d
//CHECK: fmax    z31.d, p7/m, z31.d, z31.d
lsrr    z23.h, p3/m, z23.h, z13.h
//CHECK: lsrr    z23.h, p3/m, z23.h, z13.h
cnot    z23.b, p3/m, z13.b
//CHECK: cnot    z23.b, p3/m, z13.b
st3b    {z0.b, z1.b, z2.b}, p0, [x0]
//CHECK: st3b    {z0.b, z1.b, z2.b}, p0, [x0]
cmplt   p0.s, p0/z, z0.s, z0.d
//CHECK: cmplt   p0.s, p0/z, z0.s, z0.d
sabd    z31.d, p7/m, z31.d, z31.d
//CHECK: sabd    z31.d, p7/m, z31.d, z31.d
eorv    h0, p0, z0.h
//CHECK: eorv    h0, p0, z0.h
ld1h    {z23.h}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1h    {z23.h}, p3/z, [x13, #-8, mul vl]
zip2    p7.d, p13.d, p8.d
//CHECK: zip2    p7.d, p13.d, p8.d
mov     z23.h, p3/m, w13
//CHECK: mov     z23.h, p3/m, w13
cntp    xzr, p15, p15.d
//CHECK: cntp    xzr, p15, p15.d
sqadd   z21.b, z10.b, z21.b
//CHECK: sqadd   z21.b, z10.b, z21.b
clastb  s31, p7, s31, z31.s
//CHECK: clastb  s31, p7, s31, z31.s
st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, #20, mul vl]
//CHECK: st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, #20, mul vl]
splice  z21.d, p5, z21.d, z10.d
//CHECK: splice  z21.d, p5, z21.d, z10.d
sxtb    z21.d, p5/m, z10.d
//CHECK: sxtb    z21.d, p5/m, z10.d
ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, x21]
//CHECK: ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, x21]
splice  z0.b, p0, z0.b, z0.b
//CHECK: splice  z0.b, p0, z0.b, z0.b
uqsub   z21.d, z21.d, #170
//CHECK: uqsub   z21.d, z21.d, #170
fmad    z23.s, p3/m, z13.s, z8.s
//CHECK: fmad    z23.s, p3/m, z13.s, z8.s
prfh    #7, p3, [x13, #8, mul vl]
//CHECK: prfh    #7, p3, [x13, #8, mul vl]
fnmls   z0.h, p0/m, z0.h, z0.h
//CHECK: fnmls   z0.h, p0/m, z0.h, z0.h
ldff1sh {z31.s}, p7/z, [z31.s, #62]
//CHECK: ldff1sh {z31.s}, p7/z, [z31.s, #62]
prfh    #15, p7, [sp, z31.d, uxtw #1]
//CHECK: prfh    #15, p7, [sp, z31.d, uxtw #1]
ld1w    {z0.s}, p0/z, [z0.s]
//CHECK: ld1w    {z0.s}, p0/z, [z0.s]
ld1h    {z0.h}, p0/z, [x0]
//CHECK: ld1h    {z0.h}, p0/z, [x0]
whilele p5.h, w10, w21
//CHECK: whilele p5.h, w10, w21
uxtw    z31.d, p7/m, z31.d
//CHECK: uxtw    z31.d, p7/m, z31.d
frinta  z31.s, p7/m, z31.s
//CHECK: frinta  z31.s, p7/m, z31.s
adr     z21.d, [z10.d, z21.d, uxtw]
//CHECK: adr     z21.d, [z10.d, z21.d, uxtw]
sel     z23.d, p11, z13.d, z8.d
//CHECK: sel     z23.d, p11, z13.d, z8.d
brkas   p0.b, p0/z, p0.b
//CHECK: brkas   p0.b, p0/z, p0.b
rbit    z31.d, p7/m, z31.d
//CHECK: rbit    z31.d, p7/m, z31.d
ld1h    {z21.s}, p5/z, [x10, z21.s, uxtw]
//CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, uxtw]
splice  z31.d, p7, z31.d, z31.d
//CHECK: splice  z31.d, p7, z31.d, z31.d
whilels p5.h, x10, x21
//CHECK: whilels p5.h, x10, x21
and     z21.d, z10.d, z21.d
//CHECK: and     z21.d, z10.d, z21.d
ldff1b  {z0.d}, p0/z, [z0.d]
//CHECK: ldff1b  {z0.d}, p0/z, [z0.d]
fadd    z31.s, p7/m, z31.s, z31.s
//CHECK: fadd    z31.s, p7/m, z31.s, z31.s
ld1b    {z21.s}, p5/z, [z10.s, #21]
//CHECK: ld1b    {z21.s}, p5/z, [z10.s, #21]
ld1sh   {z23.s}, p3/z, [x13, z8.s, sxtw]
//CHECK: ld1sh   {z23.s}, p3/z, [x13, z8.s, sxtw]
cmple   p15.h, p7/z, z31.h, z31.d
//CHECK: cmple   p15.h, p7/z, z31.h, z31.d
frintp  z31.s, p7/m, z31.s
//CHECK: frintp  z31.s, p7/m, z31.s
ld3d    {z5.d, z6.d, z7.d}, p3/z, [x17, x16, lsl #3]
//CHECK: ld3d    {z5.d, z6.d, z7.d}, p3/z, [x17, x16, lsl #3]
ldff1b  {z0.d}, p0/z, [x0, z0.d]
//CHECK: ldff1b  {z0.d}, p0/z, [x0, z0.d]
cmpgt   p0.s, p0/z, z0.s, z0.d
//CHECK: cmpgt   p0.s, p0/z, z0.s, z0.d
uqadd   z31.d, z31.d, z31.d
//CHECK: uqadd   z31.d, z31.d, z31.d
whilelo p7.h, w13, w8
//CHECK: whilelo p7.h, w13, w8
clastb  d0, p0, d0, z0.d
//CHECK: clastb  d0, p0, d0, z0.d
cmpls   p5.s, p5/z, z10.s, #85
//CHECK: cmpls   p5.s, p5/z, z10.s, #85
stnt1w  {z0.s}, p0, [x0]
//CHECK: stnt1w  {z0.s}, p0, [x0]
cmpls   p5.s, p5/z, z10.s, z21.d
//CHECK: cmpls   p5.s, p5/z, z10.s, z21.d
cmphi   p7.s, p3/z, z13.s, z8.d
//CHECK: cmphi   p7.s, p3/z, z13.s, z8.d
ldnt1h  {z5.h}, p3/z, [x17, x16, lsl #1]
//CHECK: ldnt1h  {z5.h}, p3/z, [x17, x16, lsl #1]
sqdecb  xzr, all, mul #16
//CHECK: sqdecb  xzr, all, mul #16
prfh    #15, p7, [sp, #-1, mul vl]
//CHECK: prfh    #15, p7, [sp, #-1, mul vl]
movprfx z23.b, p3/m, z13.b
//CHECK: movprfx z23.b, p3/m, z13.b
add     z23.b, p3/m, z23.b, z24.b
//CHECK: add z23.b, p3/m, z23.b, z24.b
uqdecd  w23, vl256, mul #9
//CHECK: uqdecd  w23, vl256, mul #9
fcvt    z0.d, p0/m, z0.s
//CHECK: fcvt    z0.d, p0/m, z0.s
fcmeq   p5.d, p5/z, z10.d, #0.0
//CHECK: fcmeq   p5.d, p5/z, z10.d, #0.0
frintm  z23.h, p3/m, z13.h
//CHECK: frintm  z23.h, p3/m, z13.h
insr    z23.b, w13
//CHECK: insr    z23.b, w13
clasta  z31.h, p7, z31.h, z31.h
//CHECK: clasta  z31.h, p7, z31.h, z31.h
smaxv   s23, p3, z13.s
//CHECK: smaxv   s23, p3, z13.s
umax    z21.h, z21.h, #170
//CHECK: umax    z21.h, z21.h, #170
cmphi   p0.h, p0/z, z0.h, #0
//CHECK: cmphi   p0.h, p0/z, z0.h, #0
umaxv   d21, p5, z10.d
//CHECK: umaxv   d21, p5, z10.d
fmax    z21.h, p5/m, z21.h, #0.0
//CHECK: fmax    z21.h, p5/m, z21.h, #0.0
sub     z21.h, z10.h, z21.h
//CHECK: sub     z21.h, z10.h, z21.h
fnmad   z21.d, p5/m, z10.d, z21.d
//CHECK: fnmad   z21.d, p5/m, z10.d, z21.d
decp    xzr, p15.h
//CHECK: decp    xzr, p15.h
cmpgt   p15.h, p7/z, z31.h, #-1
//CHECK: cmpgt   p15.h, p7/z, z31.h, #-1
asr     z23.d, p3/m, z23.d, #19
//CHECK: asr     z23.d, p3/m, z23.d, #19
prfw    pldl1keep, p0, [z0.d]
//CHECK: prfw    pldl1keep, p0, [z0.d]
ld1d    {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, sxtw]
fmaxnm  z0.h, p0/m, z0.h, z0.h
//CHECK: fmaxnm  z0.h, p0/m, z0.h, z0.h
fcmle   p15.s, p7/z, z31.s, #0.0
//CHECK: fcmle   p15.s, p7/z, z31.s, #0.0
ld1h    {z0.s}, p0/z, [z0.s]
//CHECK: ld1h    {z0.s}, p0/z, [z0.s]
st1b    {z21.d}, p5, [x10, #5, mul vl]
//CHECK: st1b    {z21.d}, p5, [x10, #5, mul vl]
cmple   p7.s, p3/z, z13.s, #8
//CHECK: cmple   p7.s, p3/z, z13.s, #8
andv    d21, p5, z10.d
//CHECK: andv    d21, p5, z10.d
fcmlt   p5.h, p5/z, z10.h, #0.0
//CHECK: fcmlt   p5.h, p5/z, z10.h, #0.0
prfb    pldl3strm, p5, [x10, z21.s, uxtw]
//CHECK: prfb    pldl3strm, p5, [x10, z21.s, uxtw]
bic     z0.b, p0/m, z0.b, z0.b
//CHECK: bic     z0.b, p0/m, z0.b, z0.b
fmaxv   s21, p5, z10.s
//CHECK: fmaxv   s21, p5, z10.s
fmsb    z23.d, p3/m, z13.d, z8.d
//CHECK: fmsb    z23.d, p3/m, z13.d, z8.d
index   z21.h, #10, w21
//CHECK: index   z21.h, #10, w21
cmpne   p0.h, p0/z, z0.h, #0
//CHECK: cmpne   p0.h, p0/z, z0.h, #0
fmaxnmv s0, p0, z0.s
//CHECK: fmaxnmv s0, p0, z0.s
ld1h    {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, sxtw]
ld1rqh  {z23.h}, p3/z, [x13, x8, lsl #1]
//CHECK: ld1rqh  {z23.h}, p3/z, [x13, x8, lsl #1]
st3d    {z23.d, z24.d, z25.d}, p3, [x13, #-24, mul vl]
//CHECK: st3d    {z23.d, z24.d, z25.d}, p3, [x13, #-24, mul vl]
uqdecw  x23, vl256, mul #9
//CHECK: uqdecw  x23, vl256, mul #9
prfb    #15, p7, [sp, z31.s, uxtw]
//CHECK: prfb    #15, p7, [sp, z31.s, uxtw]
index   z0.d, x0, x0
//CHECK: index   z0.d, x0, x0
fmin    z31.d, p7/m, z31.d, z31.d
//CHECK: fmin    z31.d, p7/m, z31.d, z31.d
asr     z23.b, p3/m, z23.b, z13.b
//CHECK: asr     z23.b, p3/m, z23.b, z13.b
not     z23.h, p3/m, z13.h
//CHECK: not     z23.h, p3/m, z13.h
fminnmv d0, p0, z0.d
//CHECK: fminnmv d0, p0, z0.d
ld1b    {z0.s}, p0/z, [x0, x0]
//CHECK: ld1b    {z0.s}, p0/z, [x0, x0]
fcvt    z21.s, p5/m, z10.d
//CHECK: fcvt    z21.s, p5/m, z10.d
umulh   z23.h, p3/m, z23.h, z13.h
//CHECK: umulh   z23.h, p3/m, z23.h, z13.h
sub     z31.b, z31.b, z31.b
//CHECK: sub     z31.b, z31.b, z31.b
lsl     z0.s, z0.s, #0
//CHECK: lsl     z0.s, z0.s, #0
st3w    {z5.s, z6.s, z7.s}, p3, [x17, x16, lsl #2]
//CHECK: st3w    {z5.s, z6.s, z7.s}, p3, [x17, x16, lsl #2]
index   z31.d, xzr, #-1
//CHECK: index   z31.d, xzr, #-1
andv    h31, p7, z31.h
//CHECK: andv    h31, p7, z31.h
umin    z23.b, z23.b, #109
//CHECK: umin    z23.b, z23.b, #109
uxtb    z21.h, p5/m, z10.h
//CHECK: uxtb    z21.h, p5/m, z10.h
whilels p7.b, x13, x8
//CHECK: whilels p7.b, x13, x8
ldnf1h  {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1h  {z21.s}, p5/z, [x10, #5, mul vl]
ld3w    {z21.s, z22.s, z23.s}, p5/z, [x10, x21, lsl #2]
//CHECK: ld3w    {z21.s, z22.s, z23.s}, p5/z, [x10, x21, lsl #2]
uqincd  x21, vl32, mul #6
//CHECK: uqincd  x21, vl32, mul #6
ld1rb   {z0.d}, p0/z, [x0]
//CHECK: ld1rb   {z0.d}, p0/z, [x0]
fmul    z0.h, p0/m, z0.h, #0.5
//CHECK: fmul    z0.h, p0/m, z0.h, #0.5
cmphs   p7.b, p3/z, z13.b, z8.d
//CHECK: cmphs   p7.b, p3/z, z13.b, z8.d
smulh   z0.d, p0/m, z0.d, z0.d
//CHECK: smulh   z0.d, p0/m, z0.d, z0.d
uqincd  xzr, all, mul #16
//CHECK: uqincd  xzr, all, mul #16
zip2    z0.h, z0.h, z0.h
//CHECK: zip2    z0.h, z0.h, z0.h
fcvt    z31.s, p7/m, z31.d
//CHECK: fcvt    z31.s, p7/m, z31.d
ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw]
ldnf1sb {z21.h}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1sb {z21.h}, p5/z, [x10, #5, mul vl]
ld1sb   {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ld1sb   {z31.d}, p7/z, [sp, z31.d, uxtw]
uqadd   z0.s, z0.s, #0
//CHECK: uqadd   z0.s, z0.s, #0
ld1sw   {z21.d}, p5/z, [x10, x21, lsl #2]
//CHECK: ld1sw   {z21.d}, p5/z, [x10, x21, lsl #2]
st1b    {z31.d}, p7, [z31.d, #31]
//CHECK: st1b    {z31.d}, p7, [z31.d, #31]
frecps  z23.d, z13.d, z8.d
//CHECK: frecps  z23.d, z13.d, z8.d
uzp1    z23.h, z13.h, z8.h
//CHECK: uzp1    z23.h, z13.h, z8.h
st3d    {z21.d, z22.d, z23.d}, p5, [x10, #15, mul vl]
//CHECK: st3d    {z21.d, z22.d, z23.d}, p5, [x10, #15, mul vl]
revw    z31.d, p7/m, z31.d
//CHECK: revw    z31.d, p7/m, z31.d
umax    z23.s, z23.s, #109
//CHECK: umax    z23.s, z23.s, #109
fminnm  z23.h, p3/m, z23.h, #1.0
//CHECK: fminnm  z23.h, p3/m, z23.h, #1.0
fabd    z21.s, p5/m, z21.s, z10.s
//CHECK: fabd    z21.s, p5/m, z21.s, z10.s
fmax    z31.s, p7/m, z31.s, #1.0
//CHECK: fmax    z31.s, p7/m, z31.s, #1.0
st1d    {z23.d}, p3, [z13.d, #64]
//CHECK: st1d    {z23.d}, p3, [z13.d, #64]
frsqrte z21.s, z10.s
//CHECK: frsqrte z21.s, z10.s
lsl     z23.b, p3/m, z23.b, z13.b
//CHECK: lsl     z23.b, p3/m, z23.b, z13.b
tbl     z0.b, {z0.b}, z0.b
//CHECK: tbl     z0.b, {z0.b}, z0.b
fcmne   p0.s, p0/z, z0.s, #0.0
//CHECK: fcmne   p0.s, p0/z, z0.s, #0.0
prfh    #15, p7, [sp, z31.s, sxtw #1]
//CHECK: prfh    #15, p7, [sp, z31.s, sxtw #1]
whilelt p0.b, x0, x0
//CHECK: whilelt p0.b, x0, x0
index   z21.s, w10, #-11
//CHECK: index   z21.s, w10, #-11
ldnf1sh {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1sh {z31.d}, p7/z, [sp, #-1, mul vl]
ldff1sb {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ldff1sb {z0.d}, p0/z, [x0, z0.d, sxtw]
ld1rh   {z23.d}, p3/z, [x13, #16]
//CHECK: ld1rh   {z23.d}, p3/z, [x13, #16]
cmplo   p7.h, p3/z, z13.h, #35
//CHECK: cmplo   p7.h, p3/z, z13.h, #35
asr     z31.d, p7/m, z31.d, #1
//CHECK: asr     z31.d, p7/m, z31.d, #1
ldff1sh {z31.d}, p7/z, [sp, xzr, lsl #1]
//CHECK: ldff1sh {z31.d}, p7/z, [sp]
ldff1h  {z31.s}, p7/z, [z31.s, #62]
//CHECK: ldff1h  {z31.s}, p7/z, [z31.s, #62]
smin    z21.d, z21.d, #-86
//CHECK: smin    z21.d, z21.d, #-86
brkas   p5.b, p5/z, p10.b
//CHECK: brkas   p5.b, p5/z, p10.b
ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw]
uqdecp  x21, p10.h
//CHECK: uqdecp  x21, p10.h
saddv   d21, p5, z10.s
//CHECK: saddv   d21, p5, z10.s
zip1    z31.h, z31.h, z31.h
//CHECK: zip1    z31.h, z31.h, z31.h
abs     z23.s, p3/m, z13.s
//CHECK: abs     z23.s, p3/m, z13.s
ld1h    {z0.d}, p0/z, [x0, z0.d, uxtw #1]
//CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, uxtw #1]
frinta  z31.h, p7/m, z31.h
//CHECK: frinta  z31.h, p7/m, z31.h
ldff1sb {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ldff1sb {z21.d}, p5/z, [x10, z21.d, uxtw]
sxtb    z21.h, p5/m, z10.h
//CHECK: sxtb    z21.h, p5/m, z10.h
cmpne   p7.d, p3/z, z13.d, #8
//CHECK: cmpne   p7.d, p3/z, z13.d, #8
fcmne   p0.s, p0/z, z0.s, z0.s
//CHECK: fcmne   p0.s, p0/z, z0.s, z0.s
fmla    z21.d, p5/m, z10.d, z21.d
//CHECK: fmla    z21.d, p5/m, z10.d, z21.d
uzp2    p15.s, p15.s, p15.s
//CHECK: uzp2    p15.s, p15.s, p15.s
cmplt   p0.s, p0/z, z0.s, #0
//CHECK: cmplt   p0.s, p0/z, z0.s, #0
ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw]
//CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw]
sqincp  z31.h, p15
//CHECK: sqincp  z31.h, p15
sub     z5.b, z5.b, #113
//CHECK: sub     z5.b, z5.b, #113
ld1sb   {z23.d}, p3/z, [x13, z8.d]
//CHECK: ld1sb   {z23.d}, p3/z, [x13, z8.d]
whilele p7.b, w13, w8
//CHECK: whilele p7.b, w13, w8
lsr     z31.b, p7/m, z31.b, #1
//CHECK: lsr     z31.b, p7/m, z31.b, #1
cmplo   p15.b, p7/z, z31.b, z31.d
//CHECK: cmplo   p15.b, p7/z, z31.b, z31.d
frintz  z31.h, p7/m, z31.h
//CHECK: frintz  z31.h, p7/m, z31.h
brkpbs  p5.b, p5/z, p10.b, p5.b
//CHECK: brkpbs  p5.b, p5/z, p10.b, p5.b
frintx  z0.h, p0/m, z0.h
//CHECK: frintx  z0.h, p0/m, z0.h
ldff1sh {z21.d}, p5/z, [x10, x21, lsl #1]
//CHECK: ldff1sh {z21.d}, p5/z, [x10, x21, lsl #1]
mov     z0.b, b0
//CHECK: mov     z0.b, b0
ucvtf   z0.s, p0/m, z0.d
//CHECK: ucvtf   z0.s, p0/m, z0.d
whilels p15.s, wzr, wzr
//CHECK: whilels p15.s, wzr, wzr
asr     z0.b, p0/m, z0.b, #8
//CHECK: asr     z0.b, p0/m, z0.b, #8
fsub    z31.d, p7/m, z31.d, z31.d
//CHECK: fsub    z31.d, p7/m, z31.d, z31.d
uzp1    p5.s, p10.s, p5.s
//CHECK: uzp1    p5.s, p10.s, p5.s
frinta  z21.d, p5/m, z10.d
//CHECK: frinta  z21.d, p5/m, z10.d
cnt     z0.s, p0/m, z0.s
//CHECK: cnt     z0.s, p0/m, z0.s
sqsub   z23.d, z13.d, z8.d
//CHECK: sqsub   z23.d, z13.d, z8.d
smin    z31.s, p7/m, z31.s, z31.s
//CHECK: smin    z31.s, p7/m, z31.s, z31.s
prfd    pldl1keep, p0, [x0, z0.d, lsl #3]
//CHECK: prfd    pldl1keep, p0, [x0, z0.d, lsl #3]
st3h    {z0.h, z1.h, z2.h}, p0, [x0]
//CHECK: st3h    {z0.h, z1.h, z2.h}, p0, [x0]
fmin    z31.d, p7/m, z31.d, #1.0
//CHECK: fmin    z31.d, p7/m, z31.d, #1.0
frecps  z31.s, z31.s, z31.s
//CHECK: frecps  z31.s, z31.s, z31.s
cmphs   p5.h, p5/z, z10.h, z21.d
//CHECK: cmphs   p5.h, p5/z, z10.h, z21.d
ld4b    {z5.b, z6.b, z7.b, z8.b}, p3/z, [x17, x16]
//CHECK: ld4b    {z5.b, z6.b, z7.b, z8.b}, p3/z, [x17, x16]
uqincw  z31.s, all, mul #16
//CHECK: uqincw  z31.s, all, mul #16
st1w    {z21.s}, p5, [x10, z21.s, uxtw]
//CHECK: st1w    {z21.s}, p5, [x10, z21.s, uxtw]
adr     z23.d, [z13.d, z8.d, sxtw #2]
//CHECK: adr     z23.d, [z13.d, z8.d, sxtw #2]
prfd    #7, p3, [x13, z8.d, sxtw #3]
//CHECK: prfd    #7, p3, [x13, z8.d, sxtw #3]
uzp1    p15.b, p15.b, p15.b
//CHECK: uzp1    p15.b, p15.b, p15.b
sqsub   z21.h, z10.h, z21.h
//CHECK: sqsub   z21.h, z10.h, z21.h
fcadd   z31.h, p7/m, z31.h, z31.h, #270
//CHECK: fcadd   z31.h, p7/m, z31.h, z31.h, #270
sxtw    z31.d, p7/m, z31.d
//CHECK: sxtw    z31.d, p7/m, z31.d
lasta   b23, p3, z13.b
//CHECK: lasta   b23, p3, z13.b
incp    x21, p10.h
//CHECK: incp    x21, p10.h
ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw #1]
//CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw #1]
st1w    {z0.d}, p0, [x0, z0.d, sxtw #2]
//CHECK: st1w    {z0.d}, p0, [x0, z0.d, sxtw #2]
adr     z0.d, [z0.d, z0.d, sxtw #3]
//CHECK: adr     z0.d, [z0.d, z0.d, sxtw #3]
bic     p5.b, p5/z, p10.b, p5.b
//CHECK: bic     p5.b, p5/z, p10.b, p5.b
st1d    {z21.d}, p5, [x10, z21.d, sxtw #3]
//CHECK: st1d    {z21.d}, p5, [x10, z21.d, sxtw #3]
uqdech  x0, pow2
//CHECK: uqdech  x0, pow2
fcmeq   p5.s, p5/z, z10.s, #0.0
//CHECK: fcmeq   p5.s, p5/z, z10.s, #0.0
st1b    {z23.d}, p3, [z13.d, #8]
//CHECK: st1b    {z23.d}, p3, [z13.d, #8]
fmls    z0.h, z0.h, z0.h[0]
//CHECK: fmls    z0.h, z0.h, z0.h[0]
smulh   z31.b, p7/m, z31.b, z31.b
//CHECK: smulh   z31.b, p7/m, z31.b, z31.b
sqsub   z0.b, z0.b, z0.b
//CHECK: sqsub   z0.b, z0.b, z0.b
asr     z23.s, p3/m, z23.s, z13.d
//CHECK: asr     z23.s, p3/m, z23.s, z13.d
trn1    z23.h, z13.h, z8.h
//CHECK: trn1    z23.h, z13.h, z8.h
lsr     z0.b, p0/m, z0.b, #8
//CHECK: lsr     z0.b, p0/m, z0.b, #8
ld3w    {z0.s, z1.s, z2.s}, p0/z, [x0]
//CHECK: ld3w    {z0.s, z1.s, z2.s}, p0/z, [x0]
st2w    {z0.s, z1.s}, p0, [x0]
//CHECK: st2w    {z0.s, z1.s}, p0, [x0]
cmpeq   p0.b, p0/z, z0.b, z0.d
//CHECK: cmpeq   p0.b, p0/z, z0.b, z0.d
fminnm  z0.s, p0/m, z0.s, z0.s
//CHECK: fminnm  z0.s, p0/m, z0.s, z0.s
st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0]
//CHECK: st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0]
ld1rh   {z21.d}, p5/z, [x10, #42]
//CHECK: ld1rh   {z21.d}, p5/z, [x10, #42]
subr    z0.h, p0/m, z0.h, z0.h
//CHECK: subr    z0.h, p0/m, z0.h, z0.h
cntp    x21, p5, p10.h
//CHECK: cntp    x21, p5, p10.h
mul     z0.s, z0.s, #0
//CHECK: mul     z0.s, z0.s, #0
fmla    z31.h, z31.h, z7.h[7]
//CHECK: fmla    z31.h, z31.h, z7.h[7]
st1d    {z31.d}, p7, [sp, z31.d, uxtw #3]
//CHECK: st1d    {z31.d}, p7, [sp, z31.d, uxtw #3]
mov     z0.h, h12
//CHECK: mov     z0.h, h12
adr     z0.s, [z0.s, z0.s, lsl #3]
//CHECK: adr     z0.s, [z0.s, z0.s, lsl #3]
frsqrts z0.h, z0.h, z0.h
//CHECK: frsqrts z0.h, z0.h, z0.h
fmaxnmv h0, p0, z0.h
//CHECK: fmaxnmv h0, p0, z0.h
adr     z23.s, [z13.s, z8.s, lsl #1]
//CHECK: adr     z23.s, [z13.s, z8.s, lsl #1]
orv     b21, p5, z10.b
//CHECK: orv     b21, p5, z10.b
tbl     z23.s, {z13.s}, z8.s
//CHECK: tbl     z23.s, {z13.s}, z8.s
mov     z21.d, p5/m, d10
//CHECK: mov     z21.d, p5/m, d10
brkbs   p0.b, p0/z, p0.b
//CHECK: brkbs   p0.b, p0/z, p0.b
fmla    z21.d, z10.d, z5.d[1]
//CHECK: fmla    z21.d, z10.d, z5.d[1]
uabd    z0.h, p0/m, z0.h, z0.h
//CHECK: uabd    z0.h, p0/m, z0.h, z0.h
frintp  z21.s, p5/m, z10.s
//CHECK: frintp  z21.s, p5/m, z10.s
uqdecp  w23, p13.d
//CHECK: uqdecp  w23, p13.d
movprfx z21.b, p5/z, z10.b
//CHECK: movprfx z21.b, p5/z, z10.b
add     z21.b, p5/m, z21.b, z22.b
//CHECK: add z21.b, p5/m, z21.b, z22.b
sqdecd  x0, w0, pow2
//CHECK: sqdecd  x0, w0, pow2
cmphs   p15.s, p7/z, z31.s, z31.d
//CHECK: cmphs   p15.s, p7/z, z31.s, z31.d
fminnm  z21.s, p5/m, z21.s, z10.s
//CHECK: fminnm  z21.s, p5/m, z21.s, z10.s
index   z0.s, w0, #0
//CHECK: index   z0.s, w0, #0
sunpklo z0.h, z0.b
//CHECK: sunpklo z0.h, z0.b
mov     p15.b, p15.b
//CHECK: mov     p15.b, p15.b
whilels p5.d, w10, w21
//CHECK: whilels p5.d, w10, w21
smax    z23.d, p3/m, z23.d, z13.d
//CHECK: smax    z23.d, p3/m, z23.d, z13.d
frecpe  z31.s, z31.s
//CHECK: frecpe  z31.s, z31.s
ld1sb   {z31.s}, p7/z, [sp, z31.s, sxtw]
//CHECK: ld1sb   {z31.s}, p7/z, [sp, z31.s, sxtw]
ptrues  p15.h
//CHECK: ptrues  p15.h
fnmsb   z0.h, p0/m, z0.h, z0.h
//CHECK: fnmsb   z0.h, p0/m, z0.h, z0.h
sunpklo z21.s, z10.h
//CHECK: sunpklo z21.s, z10.h
ptest   p0, p0.b
//CHECK: ptest   p0, p0.b
ldff1sw {z31.d}, p7/z, [z31.d, #124]
//CHECK: ldff1sw {z31.d}, p7/z, [z31.d, #124]
not     z23.s, p3/m, z13.s
//CHECK: not     z23.s, p3/m, z13.s
scvtf   z23.s, p3/m, z13.d
//CHECK: scvtf   z23.s, p3/m, z13.d
st1w    {z0.d}, p0, [x0, z0.d, uxtw]
//CHECK: st1w    {z0.d}, p0, [x0, z0.d, uxtw]
fmsb    z0.d, p0/m, z0.d, z0.d
//CHECK: fmsb    z0.d, p0/m, z0.d, z0.d
fsubr   z0.d, p0/m, z0.d, #0.5
//CHECK: fsubr   z0.d, p0/m, z0.d, #0.5
asr     z31.s, z31.s, #1
//CHECK: asr     z31.s, z31.s, #1
sdot    z31.d, z31.h, z31.h
//CHECK: sdot    z31.d, z31.h, z31.h
pnext   p7.d, p13, p7.d
//CHECK: pnext   p7.d, p13, p7.d
cmpeq   p0.s, p0/z, z0.s, z0.s
//CHECK: cmpeq   p0.s, p0/z, z0.s, z0.s
st3d    {z0.d, z1.d, z2.d}, p0, [x0]
//CHECK: st3d    {z0.d, z1.d, z2.d}, p0, [x0]
asr     z21.b, p5/m, z21.b, z10.d
//CHECK: asr     z21.b, p5/m, z21.b, z10.d
asrr    z0.h, p0/m, z0.h, z0.h
//CHECK: asrr    z0.h, p0/m, z0.h, z0.h
whilele p7.s, w13, w8
//CHECK: whilele p7.s, w13, w8
cmpeq   p7.h, p3/z, z13.h, z8.d
//CHECK: cmpeq   p7.h, p3/z, z13.h, z8.d
sunpkhi z31.d, z31.s
//CHECK: sunpkhi z31.d, z31.s
ldff1sb {z0.s}, p0/z, [x0, z0.s, uxtw]
//CHECK: ldff1sb {z0.s}, p0/z, [x0, z0.s, uxtw]
cmphi   p5.h, p5/z, z10.h, #85
//CHECK: cmphi   p5.h, p5/z, z10.h, #85
ld1b    {z23.h}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1b    {z23.h}, p3/z, [x13, #-8, mul vl]
and     z31.s, p7/m, z31.s, z31.s
//CHECK: and     z31.s, p7/m, z31.s, z31.s
fmov    z21.h, p5/m, #-13.0
//CHECK: fmov    z21.h, p5/m, #-13.0
mls     z31.b, p7/m, z31.b, z31.b
//CHECK: mls     z31.b, p7/m, z31.b, z31.b
ld1rh   {z21.h}, p5/z, [x10, #42]
//CHECK: ld1rh   {z21.h}, p5/z, [x10, #42]
adr     z23.d, [z13.d, z8.d, sxtw #1]
//CHECK: adr     z23.d, [z13.d, z8.d, sxtw #1]
fmaxnm  z0.s, p0/m, z0.s, z0.s
//CHECK: fmaxnm  z0.s, p0/m, z0.s, z0.s
ldff1sw {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, uxtw]
asrr    z0.d, p0/m, z0.d, z0.d
//CHECK: asrr    z0.d, p0/m, z0.d, z0.d
ldff1sb {z21.s}, p5/z, [x10, z21.s, sxtw]
//CHECK: ldff1sb {z21.s}, p5/z, [x10, z21.s, sxtw]
ldff1sh {z31.d}, p7/z, [sp, z31.d, lsl #1]
//CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, lsl #1]
lsr     z23.b, z13.b, #8
//CHECK: lsr     z23.b, z13.b, #8
fcvtzs  z21.d, p5/m, z10.s
//CHECK: fcvtzs  z21.d, p5/m, z10.s
fcmgt   p0.h, p0/z, z0.h, #0.0
//CHECK: fcmgt   p0.h, p0/z, z0.h, #0.0
st2w    {z21.s, z22.s}, p5, [x10, x21, lsl #2]
//CHECK: st2w    {z21.s, z22.s}, p5, [x10, x21, lsl #2]
movprfx z0.s, p0/z, z0.s
//CHECK: movprfx z0.s, p0/z, z0.s
add     z0.s, p0/m, z0.s, z1.s
//CHECK: add z0.s, p0/m, z0.s, z1.s
st1h    {z23.d}, p3, [z13.d, #16]
//CHECK: st1h    {z23.d}, p3, [z13.d, #16]
st1d    {z0.d}, p0, [x0, z0.d, sxtw]
//CHECK: st1d    {z0.d}, p0, [x0, z0.d, sxtw]
st1b    {z0.d}, p0, [x0, z0.d, uxtw]
//CHECK: st1b    {z0.d}, p0, [x0, z0.d, uxtw]
ldnt1h  {z21.h}, p5/z, [x10, #5, mul vl]
//CHECK: ldnt1h  {z21.h}, p5/z, [x10, #5, mul vl]
cntw    x0, pow2
//CHECK: cntw    x0, pow2
eor     z31.h, p7/m, z31.h, z31.h
//CHECK: eor     z31.h, p7/m, z31.h, z31.h
ld1w    {z23.d}, p3/z, [x13, x8, lsl #2]
//CHECK: ld1w    {z23.d}, p3/z, [x13, x8, lsl #2]
asr     z21.b, z10.b, #3
//CHECK: asr     z21.b, z10.b, #3
lsl     z0.d, z0.d, #0
//CHECK: lsl     z0.d, z0.d, #0
lasta   w0, p0, z0.h
//CHECK: lasta   w0, p0, z0.h
mov     z23.h, p3/m, h13
//CHECK: mov     z23.h, p3/m, h13
ldr     p5, [x10, #173, mul vl]
//CHECK: ldr     p5, [x10, #173, mul vl]
ldff1sh {z0.d}, p0/z, [z0.d]
//CHECK: ldff1sh {z0.d}, p0/z, [z0.d]
mov     z0.b, w0
//CHECK: mov     z0.b, w0
ldff1h  {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ldff1h  {z21.d}, p5/z, [x10, z21.d, uxtw]
fscale  z0.h, p0/m, z0.h, z0.h
//CHECK: fscale  z0.h, p0/m, z0.h, z0.h
ftsmul  z31.h, z31.h, z31.h
//CHECK: ftsmul  z31.h, z31.h, z31.h
whilels p7.s, w13, w8
//CHECK: whilels p7.s, w13, w8
cmple   p0.h, p0/z, z0.h, #0
//CHECK: cmple   p0.h, p0/z, z0.h, #0
index   z23.s, #13, #8
//CHECK: index   z23.s, #13, #8
lsr     z31.b, p7/m, z31.b, z31.b
//CHECK: lsr     z31.b, p7/m, z31.b, z31.b
fdivr   z21.d, p5/m, z21.d, z10.d
//CHECK: fdivr   z21.d, p5/m, z21.d, z10.d
whilele p15.h, wzr, wzr
//CHECK: whilele p15.h, wzr, wzr
ld1b    {z31.h}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1b    {z31.h}, p7/z, [sp, #-1, mul vl]
ldff1b  {z0.s}, p0/z, [z0.s]
//CHECK: ldff1b  {z0.s}, p0/z, [z0.s]
faddv   h0, p0, z0.h
//CHECK: faddv   h0, p0, z0.h
fmls    z23.d, z13.d, z8.d[0]
//CHECK: fmls    z23.d, z13.d, z8.d[0]
frecps  z31.d, z31.d, z31.d
//CHECK: frecps  z31.d, z31.d, z31.d
lasta   w21, p5, z10.b
//CHECK: lasta   w21, p5, z10.b
ld2h    {z23.h, z24.h}, p3/z, [x13, x8, lsl #1]
//CHECK: ld2h    {z23.h, z24.h}, p3/z, [x13, x8, lsl #1]
ldff1sw {z31.d}, p7/z, [sp, xzr, lsl #2]
//CHECK: ldff1sw {z31.d}, p7/z, [sp]
fmax    z23.d, p3/m, z23.d, z13.d
//CHECK: fmax    z23.d, p3/m, z23.d, z13.d
st1w    {z21.d}, p5, [x10, z21.d]
//CHECK: st1w    {z21.d}, p5, [x10, z21.d]
smax    z21.b, p5/m, z21.b, z10.b
//CHECK: smax    z21.b, p5/m, z21.b, z10.b
sqdecd  z21.d, vl32, mul #6
//CHECK: sqdecd  z21.d, vl32, mul #6
prfd    #7, p3, [x13, z8.s, uxtw #3]
//CHECK: prfd    #7, p3, [x13, z8.s, uxtw #3]
bic     z0.s, p0/m, z0.s, z0.s
//CHECK: bic     z0.s, p0/m, z0.s, z0.s
lsl     z31.b, p7/m, z31.b, z31.d
//CHECK: lsl     z31.b, p7/m, z31.b, z31.d
mov     z0.s, w0
//CHECK: mov     z0.s, w0
fsubr   z21.s, p5/m, z21.s, z10.s
//CHECK: fsubr   z21.s, p5/m, z21.s, z10.s
stnt1w  {z21.s}, p5, [x10, #5, mul vl]
//CHECK: stnt1w  {z21.s}, p5, [x10, #5, mul vl]
frecpx  z21.h, p5/m, z10.h
//CHECK: frecpx  z21.h, p5/m, z10.h
decw    z21.s, vl32, mul #6
//CHECK: decw    z21.s, vl32, mul #6
whilels p0.d, x0, x0
//CHECK: whilels p0.d, x0, x0
eorv    d23, p3, z13.d
//CHECK: eorv    d23, p3, z13.d
sabd    z23.b, p3/m, z23.b, z13.b
//CHECK: sabd    z23.b, p3/m, z23.b, z13.b
orr     z21.d, p5/m, z21.d, z10.d
//CHECK: orr     z21.d, p5/m, z21.d, z10.d
st1w    {z31.d}, p7, [sp, z31.d, lsl #2]
//CHECK: st1w    {z31.d}, p7, [sp, z31.d, lsl #2]
fmul    z21.s, z10.s, z21.s
//CHECK: fmul    z21.s, z10.s, z21.s
uunpklo z31.s, z31.h
//CHECK: uunpklo z31.s, z31.h
clasta  x23, p3, x23, z13.d
//CHECK: clasta  x23, p3, x23, z13.d
clastb  w0, p0, w0, z0.s
//CHECK: clastb  w0, p0, w0, z0.s
frintp  z31.h, p7/m, z31.h
//CHECK: frintp  z31.h, p7/m, z31.h
udiv    z23.s, p3/m, z23.s, z13.s
//CHECK: udiv    z23.s, p3/m, z23.s, z13.s
st1h    {z31.d}, p7, [sp, z31.d]
//CHECK: st1h    {z31.d}, p7, [sp, z31.d]
ld1b    {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1b    {z31.d}, p7/z, [sp, #-1, mul vl]
fcadd   z0.h, p0/m, z0.h, z0.h, #90
//CHECK: fcadd   z0.h, p0/m, z0.h, z0.h, #90
scvtf   z31.d, p7/m, z31.s
//CHECK: scvtf   z31.d, p7/m, z31.s
ctermne xzr, xzr
//CHECK: ctermne xzr, xzr
movprfx z21.s, p5/m, z10.s
//CHECK: movprfx z21.s, p5/m, z10.s
add     z21.s, p5/m, z21.s, z22.s
//CHECK: add z21.s, p5/m, z21.s, z22.s
fmulx   z31.s, p7/m, z31.s, z31.s
//CHECK: fmulx   z31.s, p7/m, z31.s, z31.s
wrffr   p10.b
//CHECK: wrffr   p10.b
st1h    {z0.d}, p0, [x0, z0.d, uxtw #1]
//CHECK: st1h    {z0.d}, p0, [x0, z0.d, uxtw #1]
rbit    z23.d, p3/m, z13.d
//CHECK: rbit    z23.d, p3/m, z13.d
fcmne   p7.s, p3/z, z13.s, #0.0
//CHECK: fcmne   p7.s, p3/z, z13.s, #0.0
st1w    {z0.s}, p0, [x0, z0.s, sxtw #2]
//CHECK: st1w    {z0.s}, p0, [x0, z0.s, sxtw #2]
rev     z0.b, z0.b
//CHECK: rev     z0.b, z0.b
ld1rqd  {z0.d}, p0/z, [x0, x0, lsl #3]
//CHECK: ld1rqd  {z0.d}, p0/z, [x0, x0, lsl #3]
ld1w    {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1w    {z31.s}, p7/z, [sp, #-1, mul vl]
lsr     z21.d, z10.d, #11
//CHECK: lsr     z21.d, z10.d, #11
fminnm  z21.h, p5/m, z21.h, #0.0
//CHECK: fminnm  z21.h, p5/m, z21.h, #0.0
sunpklo z0.s, z0.h
//CHECK: sunpklo z0.s, z0.h
add     z23.d, z23.d, #109, lsl #8
//CHECK: add     z23.d, z23.d, #27904
mov     z21.q, z10.q[1]
//CHECK: mov     z21.q, z10.q[1]
fcvtzu  z31.h, p7/m, z31.h
//CHECK: fcvtzu  z31.h, p7/m, z31.h
frsqrts z31.d, z31.d, z31.d
//CHECK: frsqrts z31.d, z31.d, z31.d
fadd    z23.h, p3/m, z23.h, z13.h
//CHECK: fadd    z23.h, p3/m, z23.h, z13.h
brkas   p15.b, p15/z, p15.b
//CHECK: brkas   p15.b, p15/z, p15.b
fsub    z23.d, z13.d, z8.d
//CHECK: fsub    z23.d, z13.d, z8.d
frintx  z31.d, p7/m, z31.d
//CHECK: frintx  z31.d, p7/m, z31.d
sqdecp  x21, p10.d
//CHECK: sqdecp  x21, p10.d
st2d    {z21.d, z22.d}, p5, [x10, #10, mul vl]
//CHECK: st2d    {z21.d, z22.d}, p5, [x10, #10, mul vl]
uqincp  w23, p13.s
//CHECK: uqincp  w23, p13.s
ldff1w  {z31.d}, p7/z, [sp, z31.d, uxtw #2]
//CHECK: ldff1w  {z31.d}, p7/z, [sp, z31.d, uxtw #2]
sqincp  xzr, p15.d, wzr
//CHECK: sqincp  xzr, p15.d, wzr
ld4h    {z23.h, z24.h, z25.h, z26.h}, p3/z, [x13, x8, lsl #1]
//CHECK: ld4h    {z23.h, z24.h, z25.h, z26.h}, p3/z, [x13, x8, lsl #1]
adr     z21.d, [z10.d, z21.d, lsl #1]
//CHECK: adr     z21.d, [z10.d, z21.d, lsl #1]
cnth    x0, pow2
//CHECK: cnth    x0, pow2
fmul    z0.d, p0/m, z0.d, #0.5
//CHECK: fmul    z0.d, p0/m, z0.d, #0.5
uqinch  x23, vl256, mul #9
//CHECK: uqinch  x23, vl256, mul #9
ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, x21, lsl #1]
//CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, x21, lsl #1]
uqsub   z23.d, z23.d, #109, lsl #8
//CHECK: uqsub   z23.d, z23.d, #27904
ld1h    {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, sxtw]
ldnt1d  {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnt1d  {z31.d}, p7/z, [sp, #-1, mul vl]
ld1b    {z21.s}, p5/z, [x10, z21.s, sxtw]
//CHECK: ld1b    {z21.s}, p5/z, [x10, z21.s, sxtw]
smulh   z23.h, p3/m, z23.h, z13.h
//CHECK: smulh   z23.h, p3/m, z23.h, z13.h
smax    z21.h, z21.h, #-86
//CHECK: smax    z21.h, z21.h, #-86
frintp  z21.h, p5/m, z10.h
//CHECK: frintp  z21.h, p5/m, z10.h
ld3b    {z5.b, z6.b, z7.b}, p3/z, [x17, x16]
//CHECK: ld3b    {z5.b, z6.b, z7.b}, p3/z, [x17, x16]
sqsub   z21.b, z21.b, #170
//CHECK: sqsub   z21.b, z21.b, #170
ld1sb   {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1sb   {z31.d}, p7/z, [sp, #-1, mul vl]
asrr    z21.b, p5/m, z21.b, z10.b
//CHECK: asrr    z21.b, p5/m, z21.b, z10.b
mov     z23.s, p8/z, #109, lsl #8
//CHECK: mov     z23.s, p8/z, #27904
uqincd  z0.d, pow2
//CHECK: uqincd  z0.d, pow2
cmpne   p5.b, p5/z, z10.b, z21.b
//CHECK: cmpne   p5.b, p5/z, z10.b, z21.b
cmphi   p15.b, p7/z, z31.b, #127
//CHECK: cmphi   p15.b, p7/z, z31.b, #127
sqdecp  z23.s, p13
//CHECK: sqdecp  z23.s, p13
ldff1d  {z23.d}, p3/z, [x13, z8.d]
//CHECK: ldff1d  {z23.d}, p3/z, [x13, z8.d]
clz     z23.b, p3/m, z13.b
//CHECK: clz     z23.b, p3/m, z13.b
umin    z23.s, z23.s, #109
//CHECK: umin    z23.s, z23.s, #109
cmpne   p7.b, p3/z, z13.b, #8
//CHECK: cmpne   p7.b, p3/z, z13.b, #8
index   z31.b, #-1, wzr
//CHECK: index   z31.b, #-1, wzr
whilelt p15.s, wzr, wzr
//CHECK: whilelt p15.s, wzr, wzr
and     z23.h, p3/m, z23.h, z13.h
//CHECK: and     z23.h, p3/m, z23.h, z13.h
fdivr   z0.d, p0/m, z0.d, z0.d
//CHECK: fdivr   z0.d, p0/m, z0.d, z0.d
uzp1    p0.s, p0.s, p0.s
//CHECK: uzp1    p0.s, p0.s, p0.s
lsl     z21.b, p5/m, z21.b, z10.d
//CHECK: lsl     z21.b, p5/m, z21.b, z10.d
frinti  z23.h, p3/m, z13.h
//CHECK: frinti  z23.h, p3/m, z13.h
cnt     z31.s, p7/m, z31.s
//CHECK: cnt     z31.s, p7/m, z31.s
lasta   wzr, p7, z31.s
//CHECK: lasta   wzr, p7, z31.s
st2w    {z23.s, z24.s}, p3, [x13, x8, lsl #2]
//CHECK: st2w    {z23.s, z24.s}, p3, [x13, x8, lsl #2]
st3w    {z0.s, z1.s, z2.s}, p0, [x0]
//CHECK: st3w    {z0.s, z1.s, z2.s}, p0, [x0]
sqdecp  x21, p10.b, w21
//CHECK: sqdecp  x21, p10.b, w21
mov     z0.s, p0/m, z0.s
//CHECK: mov     z0.s, p0/m, z0.s
cmpne   p15.h, p7/z, z31.h, z31.h
//CHECK: cmpne   p15.h, p7/z, z31.h, z31.h
cmplo   p15.h, p7/z, z31.h, z31.d
//CHECK: cmplo   p15.h, p7/z, z31.h, z31.d
prfw    pldl1keep, p0, [x0, z0.d, sxtw #2]
//CHECK: prfw    pldl1keep, p0, [x0, z0.d, sxtw #2]
rdffr   p0.b, p0/z
//CHECK: rdffr   p0.b, p0/z
ld1b    {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ld1b    {z21.d}, p5/z, [x10, #5, mul vl]
setffr  
//CHECK: setffr  
subr    z21.s, z21.s, #170
//CHECK: subr    z21.s, z21.s, #170
sdivr   z0.s, p0/m, z0.s, z0.s
//CHECK: sdivr   z0.s, p0/m, z0.s, z0.s
sqdecp  x0, p0.s, w0
//CHECK: sqdecp  x0, p0.s, w0
nors    p7.b, p11/z, p13.b, p8.b
//CHECK: nors    p7.b, p11/z, p13.b, p8.b
pfirst  p0.b, p0, p0.b
//CHECK: pfirst  p0.b, p0, p0.b
brkn    p0.b, p0/z, p0.b, p0.b
//CHECK: brkn    p0.b, p0/z, p0.b, p0.b
cmphs   p0.s, p0/z, z0.s, #0
//CHECK: cmphs   p0.s, p0/z, z0.s, #0
asr     z0.s, z0.s, z0.d
//CHECK: asr     z0.s, z0.s, z0.d
decp    z21.h, p10
//CHECK: decp    z21.h, p10
saddv   d23, p3, z13.h
//CHECK: saddv   d23, p3, z13.h
ld1sh   {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1sh   {z31.s}, p7/z, [sp, #-1, mul vl]
uqincd  z21.d, vl32, mul #6
//CHECK: uqincd  z21.d, vl32, mul #6
asr     z0.b, z0.b, z0.d
//CHECK: asr     z0.b, z0.b, z0.d
scvtf   z23.d, p3/m, z13.d
//CHECK: scvtf   z23.d, p3/m, z13.d
mov     z21.d, p5/m, #-86
//CHECK: mov     z21.d, p5/m, #-86
saddv   d21, p5, z10.b
//CHECK: saddv   d21, p5, z10.b
rdffr   p5.b
//CHECK: rdffr   p5.b
umax    z0.d, z0.d, #0
//CHECK: umax    z0.d, z0.d, #0
fmov    z21.s, p5/m, #-13.0
//CHECK: fmov    z21.s, p5/m, #-13.0
lsrr    z23.b, p3/m, z23.b, z13.b
//CHECK: lsrr    z23.b, p3/m, z23.b, z13.b
smax    z0.h, z0.h, #0
//CHECK: smax    z0.h, z0.h, #0
frecpx  z0.h, p0/m, z0.h
//CHECK: frecpx  z0.h, p0/m, z0.h
lsl     z0.b, p0/m, z0.b, z0.b
//CHECK: lsl     z0.b, p0/m, z0.b, z0.b
ld1h    {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1h    {z23.d}, p3/z, [x13, #-8, mul vl]
ld1sb   {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1sb   {z23.d}, p3/z, [x13, #-8, mul vl]
fmov    z23.s, #0.90625
//CHECK: fmov    z23.s, #0.90625
zip2    z21.d, z10.d, z21.d
//CHECK: zip2    z21.d, z10.d, z21.d
str     p5, [x10, #173, mul vl]
//CHECK: str     p5, [x10, #173, mul vl]
sub     z0.s, z0.s, z0.s
//CHECK: sub     z0.s, z0.s, z0.s
fmax    z23.d, p3/m, z23.d, #1.0
//CHECK: fmax    z23.d, p3/m, z23.d, #1.0
frintm  z0.s, p0/m, z0.s
//CHECK: frintm  z0.s, p0/m, z0.s
movprfx z23.h, p3/z, z13.h
//CHECK: movprfx z23.h, p3/z, z13.h
add     z23.h, p3/m, z23.h, z24.h
//CHECK: add z23.h, p3/m, z23.h, z24.h
fcvt    z21.d, p5/m, z10.h
//CHECK: fcvt    z21.d, p5/m, z10.h
smax    z31.b, z31.b, #-1
//CHECK: smax    z31.b, z31.b, #-1
st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, x21, lsl #2]
//CHECK: st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, x21, lsl #2]
decw    z31.s, all, mul #16
//CHECK: decw    z31.s, all, mul #16
clasta  z23.h, p3, z23.h, z13.h
//CHECK: clasta  z23.h, p3, z23.h, z13.h
movprfx z31.h, p7/m, z31.h
//CHECK: movprfx z31.h, p7/m, z31.h
add     z31.h, p7/m, z31.h, z0.h
//CHECK: add z31.h, p7/m, z31.h, z0.h
orn     p5.b, p5/z, p10.b, p5.b
//CHECK: orn     p5.b, p5/z, p10.b, p5.b
cmplt   p5.s, p5/z, z10.s, z21.d
//CHECK: cmplt   p5.s, p5/z, z10.s, z21.d
ld4d    {z21.d, z22.d, z23.d, z24.d}, p5/z, [x10, #20, mul vl]
//CHECK: ld4d    {z21.d, z22.d, z23.d, z24.d}, p5/z, [x10, #20, mul vl]
umax    z31.b, z31.b, #255
//CHECK: umax    z31.b, z31.b, #255
uqincp  x23, p13.d
//CHECK: uqincp  x23, p13.d
cmpne   p0.h, p0/z, z0.h, z0.d
//CHECK: cmpne   p0.h, p0/z, z0.h, z0.d
ptrues  p5.s, vl32
//CHECK: ptrues  p5.s, vl32
fcvtzs  z23.d, p3/m, z13.d
//CHECK: fcvtzs  z23.d, p3/m, z13.d
trn2    p15.b, p15.b, p15.b
//CHECK: trn2    p15.b, p15.b, p15.b
eor     z0.b, p0/m, z0.b, z0.b
//CHECK: eor     z0.b, p0/m, z0.b, z0.b
cmplo   p15.d, p7/z, z31.d, #127
//CHECK: cmplo   p15.d, p7/z, z31.d, #127
add     z21.b, z10.b, z21.b
//CHECK: add     z21.b, z10.b, z21.b
umax    z21.s, p5/m, z21.s, z10.s
//CHECK: umax    z21.s, p5/m, z21.s, z10.s
uunpklo z21.s, z10.h
//CHECK: uunpklo z21.s, z10.h
sqincd  x0, pow2
//CHECK: sqincd  x0, pow2
cmplt   p7.b, p3/z, z13.b, z8.d
//CHECK: cmplt   p7.b, p3/z, z13.b, z8.d
lsl     z21.h, p5/m, z21.h, #10
//CHECK: lsl     z21.h, p5/m, z21.h, #10
sqsub   z23.s, z23.s, #109, lsl #8
//CHECK: sqsub   z23.s, z23.s, #27904
whilelo p5.h, w10, w21
//CHECK: whilelo p5.h, w10, w21
index   z0.b, #0, #0
//CHECK: index   z0.b, #0, #0
ld1b    {z5.h}, p3/z, [x17, x16]
//CHECK: ld1b    {z5.h}, p3/z, [x17, x16]
uabd    z21.s, p5/m, z21.s, z10.s
//CHECK: uabd    z21.s, p5/m, z21.s, z10.s
smulh   z0.h, p0/m, z0.h, z0.h
//CHECK: smulh   z0.h, p0/m, z0.h, z0.h
umin    z31.s, z31.s, #255
//CHECK: umin    z31.s, z31.s, #255
index   z31.b, #-1, #-1
//CHECK: index   z31.b, #-1, #-1
smaxv   b21, p5, z10.b
//CHECK: smaxv   b21, p5, z10.b
st1w    {z31.d}, p7, [sp, z31.d]
//CHECK: st1w    {z31.d}, p7, [sp, z31.d]
trn2    p15.s, p15.s, p15.s
//CHECK: trn2    p15.s, p15.s, p15.s
ldff1sw {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, sxtw]
adr     z23.s, [z13.s, z8.s, lsl #3]
//CHECK: adr     z23.s, [z13.s, z8.s, lsl #3]
sqdech  x0, pow2
//CHECK: sqdech  x0, pow2
uqdecp  x21, p10.s
//CHECK: uqdecp  x21, p10.s
ptrue   p0.h, pow2
//CHECK: ptrue   p0.h, pow2
sminv   s23, p3, z13.s
//CHECK: sminv   s23, p3, z13.s
fmax    z31.h, p7/m, z31.h, #1.0
//CHECK: fmax    z31.h, p7/m, z31.h, #1.0
not     z0.b, p0/m, z0.b
//CHECK: not     z0.b, p0/m, z0.b
mul     z23.h, z23.h, #109
//CHECK: mul     z23.h, z23.h, #109
ld1h    {z21.h}, p5/z, [x10, x21, lsl #1]
//CHECK: ld1h    {z21.h}, p5/z, [x10, x21, lsl #1]
fcmgt   p7.s, p3/z, z13.s, #0.0
//CHECK: fcmgt   p7.s, p3/z, z13.s, #0.0
ldff1sw {z21.d}, p5/z, [x10, z21.d, uxtw #2]
//CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, uxtw #2]
fmls    z23.s, p3/m, z13.s, z8.s
//CHECK: fmls    z23.s, p3/m, z13.s, z8.s
whilelt p7.s, x13, x8
//CHECK: whilelt p7.s, x13, x8
mov     z21.h, p5/z, #-86
//CHECK: mov     z21.h, p5/z, #-86
ld1d    {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ld1d    {z21.d}, p5/z, [x10, #5, mul vl]
incp    z31.s, p15
//CHECK: incp    z31.s, p15
uzp2    z0.s, z0.s, z0.s
//CHECK: uzp2    z0.s, z0.s, z0.s
uqdecb  x0, pow2
//CHECK: uqdecb  x0, pow2
clz     z31.s, p7/m, z31.s
//CHECK: clz     z31.s, p7/m, z31.s
st1d    {z21.d}, p5, [x10, z21.d, uxtw]
//CHECK: st1d    {z21.d}, p5, [x10, z21.d, uxtw]
fminnmv d21, p5, z10.d
//CHECK: fminnmv d21, p5, z10.d
asr     z0.d, z0.d, #64
//CHECK: asr     z0.d, z0.d, #64
mov     z1.b, p14/z, #33
//CHECK: mov     z1.b, p14/z, #33
sqinch  x21, vl32, mul #6
//CHECK: sqinch  x21, vl32, mul #6
cmple   p0.b, p0/z, z0.b, #0
//CHECK: cmple   p0.b, p0/z, z0.b, #0
ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw]
ld3w    {z23.s, z24.s, z25.s}, p3/z, [x13, #-24, mul vl]
//CHECK: ld3w    {z23.s, z24.s, z25.s}, p3/z, [x13, #-24, mul vl]
clastb  x23, p3, x23, z13.d
//CHECK: clastb  x23, p3, x23, z13.d
ld1b    {z5.b}, p3/z, [x17, x16]
//CHECK: ld1b    {z5.b}, p3/z, [x17, x16]
fcvtzs  z23.s, p3/m, z13.s
//CHECK: fcvtzs  z23.s, p3/m, z13.s
mad     z0.d, p0/m, z0.d, z0.d
//CHECK: mad     z0.d, p0/m, z0.d, z0.d
sqadd   z21.h, z21.h, #170
//CHECK: sqadd   z21.h, z21.h, #170
sqadd   z21.s, z10.s, z21.s
//CHECK: sqadd   z21.s, z10.s, z21.s
fneg    z0.s, p0/m, z0.s
//CHECK: fneg    z0.s, p0/m, z0.s
scvtf   z23.h, p3/m, z13.s
//CHECK: scvtf   z23.h, p3/m, z13.s
index   z21.s, w10, w21
//CHECK: index   z21.s, w10, w21
sqdecp  x0, p0.s
//CHECK: sqdecp  x0, p0.s
ldnt1b  {z21.b}, p5/z, [x10, x21]
//CHECK: ldnt1b  {z21.b}, p5/z, [x10, x21]
st1w    {z23.s}, p3, [z13.s, #32]
//CHECK: st1w    {z23.s}, p3, [z13.s, #32]
uqdecp  wzr, p15.b
//CHECK: uqdecp  wzr, p15.b
asrd    z0.d, p0/m, z0.d, #64
//CHECK: asrd    z0.d, p0/m, z0.d, #64
ld1rsh  {z23.d}, p3/z, [x13, #16]
//CHECK: ld1rsh  {z23.d}, p3/z, [x13, #16]
st1b    {z5.h}, p3, [x17, x16]
//CHECK: st1b    {z5.h}, p3, [x17, x16]
uunpkhi z0.s, z0.h
//CHECK: uunpkhi z0.s, z0.h
movprfx z0.h, p0/m, z0.h
//CHECK: movprfx z0.h, p0/m, z0.h
add     z0.h, p0/m, z0.h, z1.h
//CHECK: add z0.h, p0/m, z0.h, z1.h
prfw    pldl1keep, p0, [x0, z0.s, uxtw #2]
//CHECK: prfw    pldl1keep, p0, [x0, z0.s, uxtw #2]
fnmsb   z21.s, p5/m, z10.s, z21.s
//CHECK: fnmsb   z21.s, p5/m, z10.s, z21.s
frsqrte z23.s, z13.s
//CHECK: frsqrte z23.s, z13.s
fsqrt   z21.s, p5/m, z10.s
//CHECK: fsqrt   z21.s, p5/m, z10.s
ldff1w  {z0.d}, p0/z, [x0, x0, lsl #2]
//CHECK: ldff1w  {z0.d}, p0/z, [x0, x0, lsl #2]
ld1rqh  {z23.h}, p3/z, [x13, #-128]
//CHECK: ld1rqh  {z23.h}, p3/z, [x13, #-128]
index   z31.d, xzr, xzr
//CHECK: index   z31.d, xzr, xzr
lsl     z31.s, p7/m, z31.s, #31
//CHECK: lsl     z31.s, p7/m, z31.s, #31
uqadd   z0.h, z0.h, #0
//CHECK: uqadd   z0.h, z0.h, #0
adr     z23.s, [z13.s, z8.s]
//CHECK: adr     z23.s, [z13.s, z8.s]
prfw    #7, p3, [x13, x8, lsl #2]
//CHECK: prfw    #7, p3, [x13, x8, lsl #2]
cntp    x23, p11, p13.d
//CHECK: cntp    x23, p11, p13.d
mov     z0.h, p0/m, w0
//CHECK: mov     z0.h, p0/m, w0
cmphi   p0.s, p0/z, z0.s, z0.d
//CHECK: cmphi   p0.s, p0/z, z0.s, z0.d
cmplo   p0.d, p0/z, z0.d, #0
//CHECK: cmplo   p0.d, p0/z, z0.d, #0
fsubr   z21.h, p5/m, z21.h, #0.5
//CHECK: fsubr   z21.h, p5/m, z21.h, #0.5
fmul    z21.h, z10.h, z5.h[6]
//CHECK: fmul    z21.h, z10.h, z5.h[6]
ld1sw   {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1sw   {z23.d}, p3/z, [x13, #-8, mul vl]
index   z31.h, #-1, wzr
//CHECK: index   z31.h, #-1, wzr
st3h    {z23.h, z24.h, z25.h}, p3, [x13, x8, lsl #1]
//CHECK: st3h    {z23.h, z24.h, z25.h}, p3, [x13, x8, lsl #1]
umin    z31.d, z31.d, #255
//CHECK: umin    z31.d, z31.d, #255
uqincp  w0, p0.h
//CHECK: uqincp  w0, p0.h
scvtf   z21.d, p5/m, z10.s
//CHECK: scvtf   z21.d, p5/m, z10.s
asrd    z31.s, p7/m, z31.s, #1
//CHECK: asrd    z31.s, p7/m, z31.s, #1
fminnm  z23.h, p3/m, z23.h, z13.h
//CHECK: fminnm  z23.h, p3/m, z23.h, z13.h
st1b    {z23.h}, p3, [x13, #-8, mul vl]
//CHECK: st1b    {z23.h}, p3, [x13, #-8, mul vl]
mul     z31.s, z31.s, #-1
//CHECK: mul     z31.s, z31.s, #-1
trn2    z21.b, z10.b, z21.b
//CHECK: trn2    z21.b, z10.b, z21.b
whilelo p0.h, w0, w0
//CHECK: whilelo p0.h, w0, w0
zip1    p0.d, p0.d, p0.d
//CHECK: zip1    p0.d, p0.d, p0.d
insr    z23.b, b13
//CHECK: insr    z23.b, b13
ld1h    {z23.d}, p3/z, [z13.d, #16]
//CHECK: ld1h    {z23.d}, p3/z, [z13.d, #16]
lsl     z23.s, p3/m, z23.s, z13.d
//CHECK: lsl     z23.s, p3/m, z23.s, z13.d
adr     z21.d, [z10.d, z21.d, lsl #3]
//CHECK: adr     z21.d, [z10.d, z21.d, lsl #3]
fmls    z23.h, z13.h, z0.h[5]
//CHECK: fmls    z23.h, z13.h, z0.h[5]
fcmge   p15.h, p7/z, z31.h, #0.0
//CHECK: fcmge   p15.h, p7/z, z31.h, #0.0
index   z21.d, #10, #-11
//CHECK: index   z21.d, #10, #-11
ld1w    {z23.s}, p3/z, [z13.s, #32]
//CHECK: ld1w    {z23.s}, p3/z, [z13.s, #32]
fmad    z31.s, p7/m, z31.s, z31.s
//CHECK: fmad    z31.s, p7/m, z31.s, z31.s
sqadd   z5.b, z5.b, #113
//CHECK: sqadd   z5.b, z5.b, #113
rbit    z21.b, p5/m, z10.b
//CHECK: rbit    z21.b, p5/m, z10.b
adr     z21.d, [z10.d, z21.d, lsl #2]
//CHECK: adr     z21.d, [z10.d, z21.d, lsl #2]
abs     z0.s, p0/m, z0.s
//CHECK: abs     z0.s, p0/m, z0.s
sqadd   z0.d, z0.d, z0.d
//CHECK: sqadd   z0.d, z0.d, z0.d
cmphi   p5.s, p5/z, z10.s, z21.d
//CHECK: cmphi   p5.s, p5/z, z10.s, z21.d
uqdecw  x21, vl32, mul #6
//CHECK: uqdecw  x21, vl32, mul #6
incp    x0, p0.d
//CHECK: incp    x0, p0.d
index   z0.s, w0, w0
//CHECK: index   z0.s, w0, w0
uqdecw  w0, pow2
//CHECK: uqdecw  w0, pow2
fdiv    z23.h, p3/m, z23.h, z13.h
//CHECK: fdiv    z23.h, p3/m, z23.h, z13.h
incd    x0, pow2
//CHECK: incd    x0, pow2
cmple   p15.s, p7/z, z31.s, z31.d
//CHECK: cmple   p15.s, p7/z, z31.s, z31.d
ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0]
//CHECK: ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0]
umax    z21.b, z21.b, #170
//CHECK: umax    z21.b, z21.b, #170
eorv    s0, p0, z0.s
//CHECK: eorv    s0, p0, z0.s
sqdech  z23.h, vl256, mul #9
//CHECK: sqdech  z23.h, vl256, mul #9
ldff1d  {z0.d}, p0/z, [x0, z0.d, uxtw #3]
//CHECK: ldff1d  {z0.d}, p0/z, [x0, z0.d, uxtw #3]
clastb  w21, p5, w21, z10.b
//CHECK: clastb  w21, p5, w21, z10.b
uqincw  x23, vl256, mul #9
//CHECK: uqincw  x23, vl256, mul #9
st1h    {z5.s}, p3, [x17, x16, lsl #1]
//CHECK: st1h    {z5.s}, p3, [x17, x16, lsl #1]
ld1sh   {z21.d}, p5/z, [x10, z21.d, uxtw #1]
//CHECK: ld1sh   {z21.d}, p5/z, [x10, z21.d, uxtw #1]
cmpne   p7.b, p3/z, z13.b, z8.d
//CHECK: cmpne   p7.b, p3/z, z13.b, z8.d
asr     z21.b, z10.b, z21.d
//CHECK: asr     z21.b, z10.b, z21.d
ldnf1b  {z0.b}, p0/z, [x0]
//CHECK: ldnf1b  {z0.b}, p0/z, [x0]
st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0, x0, lsl #2]
//CHECK: st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0, x0, lsl #2]
and     z21.d, p5/m, z21.d, z10.d
//CHECK: and     z21.d, p5/m, z21.d, z10.d
revh    z21.s, p5/m, z10.s
//CHECK: revh    z21.s, p5/m, z10.s
ldff1sw {z23.d}, p3/z, [x13, z8.d]
//CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d]
lasta   wzr, p7, z31.h
//CHECK: lasta   wzr, p7, z31.h
trn2    p5.d, p10.d, p5.d
//CHECK: trn2    p5.d, p10.d, p5.d
umaxv   h31, p7, z31.h
//CHECK: umaxv   h31, p7, z31.h
subr    z31.b, p7/m, z31.b, z31.b
//CHECK: subr    z31.b, p7/m, z31.b, z31.b
st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0]
//CHECK: st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0]
clasta  w23, p3, w23, z13.h
//CHECK: clasta  w23, p3, w23, z13.h
ftmad   z21.h, z21.h, z10.h, #5
//CHECK: ftmad   z21.h, z21.h, z10.h, #5
incd    x21, vl32, mul #6
//CHECK: incd    x21, vl32, mul #6
sxth    z31.d, p7/m, z31.d
//CHECK: sxth    z31.d, p7/m, z31.d
uqincp  x21, p10.d
//CHECK: uqincp  x21, p10.d
clasta  z21.s, p5, z21.s, z10.s
//CHECK: clasta  z21.s, p5, z21.s, z10.s
ldff1h  {z0.s}, p0/z, [z0.s]
//CHECK: ldff1h  {z0.s}, p0/z, [z0.s]
lastb   h31, p7, z31.h
//CHECK: lastb   h31, p7, z31.h
mls     z21.d, p5/m, z10.d, z21.d
//CHECK: mls     z21.d, p5/m, z10.d, z21.d
eorv    d21, p5, z10.d
//CHECK: eorv    d21, p5, z10.d
cmple   p7.h, p3/z, z13.h, z8.d
//CHECK: cmple   p7.h, p3/z, z13.h, z8.d
trn1    z31.b, z31.b, z31.b
//CHECK: trn1    z31.b, z31.b, z31.b
fcmeq   p5.s, p5/z, z10.s, z21.s
//CHECK: fcmeq   p5.s, p5/z, z10.s, z21.s
fnmla   z23.d, p3/m, z13.d, z8.d
//CHECK: fnmla   z23.d, p3/m, z13.d, z8.d
smulh   z23.s, p3/m, z23.s, z13.s
//CHECK: smulh   z23.s, p3/m, z23.s, z13.s
fcvtzu  z0.s, p0/m, z0.h
//CHECK: fcvtzu  z0.s, p0/m, z0.h
clasta  z31.b, p7, z31.b, z31.b
//CHECK: clasta  z31.b, p7, z31.b, z31.b
orr     z23.b, p3/m, z23.b, z13.b
//CHECK: orr     z23.b, p3/m, z23.b, z13.b
fmla    z31.s, z31.s, z7.s[3]
//CHECK: fmla    z31.s, z31.s, z7.s[3]
clasta  z31.s, p7, z31.s, z31.s
//CHECK: clasta  z31.s, p7, z31.s, z31.s
st1h    {z31.s}, p7, [sp, #-1, mul vl]
//CHECK: st1h    {z31.s}, p7, [sp, #-1, mul vl]
mls     z21.h, p5/m, z10.h, z21.h
//CHECK: mls     z21.h, p5/m, z10.h, z21.h
asr     z31.d, p7/m, z31.d, z31.d
//CHECK: asr     z31.d, p7/m, z31.d, z31.d
uqdecp  xzr, p15.h
//CHECK: uqdecp  xzr, p15.h
ld1b    {z0.s}, p0/z, [x0]
//CHECK: ld1b    {z0.s}, p0/z, [x0]
fmin    z0.s, p0/m, z0.s, #0.0
//CHECK: fmin    z0.s, p0/m, z0.s, #0.0
faddv   h31, p7, z31.h
//CHECK: faddv   h31, p7, z31.h
trn2    p5.b, p10.b, p5.b
//CHECK: trn2    p5.b, p10.b, p5.b
cntp    xzr, p15, p15.b
//CHECK: cntp    xzr, p15, p15.b
pfirst  p15.b, p15, p15.b
//CHECK: pfirst  p15.b, p15, p15.b
adr     z21.d, [z10.d, z21.d, uxtw #3]
//CHECK: adr     z21.d, [z10.d, z21.d, uxtw #3]
uminv   d23, p3, z13.d
//CHECK: uminv   d23, p3, z13.d
bic     z23.s, p3/m, z23.s, z13.s
//CHECK: bic     z23.s, p3/m, z23.s, z13.s
st2h    {z0.h, z1.h}, p0, [x0, x0, lsl #1]
//CHECK: st2h    {z0.h, z1.h}, p0, [x0, x0, lsl #1]
lasta   x21, p5, z10.d
//CHECK: lasta   x21, p5, z10.d
trn1    p5.d, p10.d, p5.d
//CHECK: trn1    p5.d, p10.d, p5.d
ldnf1sh {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1sh {z21.d}, p5/z, [x10, #5, mul vl]
mov     z23.h, z13.h[10]
//CHECK: mov     z23.h, z13.h[10]
fmaxnm  z21.d, p5/m, z21.d, #0.0
//CHECK: fmaxnm  z21.d, p5/m, z21.d, #0.0
ldnt1h  {z0.h}, p0/z, [x0]
//CHECK: ldnt1h  {z0.h}, p0/z, [x0]
ldff1h  {z0.d}, p0/z, [x0, z0.d, sxtw #1]
//CHECK: ldff1h  {z0.d}, p0/z, [x0, z0.d, sxtw #1]
fcmuo   p5.s, p5/z, z10.s, z21.s
//CHECK: fcmuo   p5.s, p5/z, z10.s, z21.s
and     z23.b, p3/m, z23.b, z13.b
//CHECK: and     z23.b, p3/m, z23.b, z13.b
cmplo   p5.d, p5/z, z10.d, #85
//CHECK: cmplo   p5.d, p5/z, z10.d, #85
ldnf1b  {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1b  {z23.s}, p3/z, [x13, #-8, mul vl]
lsl     z21.h, p5/m, z21.h, z10.h
//CHECK: lsl     z21.h, p5/m, z21.h, z10.h
st1b    {z23.s}, p3, [x13, #-8, mul vl]
//CHECK: st1b    {z23.s}, p3, [x13, #-8, mul vl]
ldff1w  {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ldff1w  {z23.d}, p3/z, [x13, z8.d, sxtw]
and     z31.h, p7/m, z31.h, z31.h
//CHECK: and     z31.h, p7/m, z31.h, z31.h
st1w    {z23.d}, p3, [z13.d, #32]
//CHECK: st1w    {z23.d}, p3, [z13.d, #32]
uqincp  wzr, p15.d
//CHECK: uqincp  wzr, p15.d
ld1rsh  {z21.d}, p5/z, [x10, #42]
//CHECK: ld1rsh  {z21.d}, p5/z, [x10, #42]
fcadd   z21.h, p5/m, z21.h, z10.h, #270
//CHECK: fcadd   z21.h, p5/m, z21.h, z10.h, #270
ld1sb   {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1sb   {z23.s}, p3/z, [x13, #-8, mul vl]
whilele p0.b, x0, x0
//CHECK: whilele p0.b, x0, x0
mov     z31.b, p7/m, b31
//CHECK: mov     z31.b, p7/m, b31
fsub    z0.d, z0.d, z0.d
//CHECK: fsub    z0.d, z0.d, z0.d
mov     z31.s, p15/m, z31.s
//CHECK: mov     z31.s, p15/m, z31.s
sub     z23.s, p3/m, z23.s, z13.s
//CHECK: sub     z23.s, p3/m, z23.s, z13.s
asrd    z31.h, p7/m, z31.h, #1
//CHECK: asrd    z31.h, p7/m, z31.h, #1
udot    z31.d, z31.h, z15.h[1]
//CHECK: udot    z31.d, z31.h, z15.h[1]
fmul    z0.d, z0.d, z0.d[0]
//CHECK: fmul    z0.d, z0.d, z0.d[0]
lsl     z31.h, z31.h, z31.d
//CHECK: lsl     z31.h, z31.h, z31.d
ldff1w  {z31.s}, p7/z, [sp, z31.s, uxtw]
//CHECK: ldff1w  {z31.s}, p7/z, [sp, z31.s, uxtw]
brkbs   p7.b, p11/z, p13.b
//CHECK: brkbs   p7.b, p11/z, p13.b
fcvtzu  z0.d, p0/m, z0.d
//CHECK: fcvtzu  z0.d, p0/m, z0.d
smulh   z23.d, p3/m, z23.d, z13.d
//CHECK: smulh   z23.d, p3/m, z23.d, z13.d
ftssel  z31.s, z31.s, z31.s
//CHECK: ftssel  z31.s, z31.s, z31.s
ld1w    {z0.d}, p0/z, [x0, z0.d, sxtw #2]
//CHECK: ld1w    {z0.d}, p0/z, [x0, z0.d, sxtw #2]
sdot    z21.d, z10.h, z21.h
//CHECK: sdot    z21.d, z10.h, z21.h
cmpgt   p5.b, p5/z, z10.b, #-11
//CHECK: cmpgt   p5.b, p5/z, z10.b, #-11
fmax    z31.d, p7/m, z31.d, #1.0
//CHECK: fmax    z31.d, p7/m, z31.d, #1.0
cmpge   p7.b, p3/z, z13.b, z8.d
//CHECK: cmpge   p7.b, p3/z, z13.b, z8.d
ld1sw   {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ld1sw   {z31.d}, p7/z, [sp, z31.d, uxtw]
mov     z23.d, p3/m, x13
//CHECK: mov     z23.d, p3/m, x13
dupm    z5.b, #0x81
//CHECK: dupm    z5.b, #0x81
st3w    {z0.s, z1.s, z2.s}, p0, [x0, x0, lsl #2]
//CHECK: st3w    {z0.s, z1.s, z2.s}, p0, [x0, x0, lsl #2]
st2b    {z23.b, z24.b}, p3, [x13, x8]
//CHECK: st2b    {z23.b, z24.b}, p3, [x13, x8]
cmpge   p7.h, p3/z, z13.h, z8.d
//CHECK: cmpge   p7.h, p3/z, z13.h, z8.d
zip2    p0.s, p0.s, p0.s
//CHECK: zip2    p0.s, p0.s, p0.s
brka    p0.b, p0/z, p0.b
//CHECK: brka    p0.b, p0/z, p0.b
ldff1sb {z0.h}, p0/z, [x0, x0]
//CHECK: ldff1sb {z0.h}, p0/z, [x0, x0]
ldff1h  {z23.d}, p3/z, [z13.d, #16]
//CHECK: ldff1h  {z23.d}, p3/z, [z13.d, #16]
uabd    z0.d, p0/m, z0.d, z0.d
//CHECK: uabd    z0.d, p0/m, z0.d, z0.d
smax    z23.s, p3/m, z23.s, z13.s
//CHECK: smax    z23.s, p3/m, z23.s, z13.s
fmad    z31.d, p7/m, z31.d, z31.d
//CHECK: fmad    z31.d, p7/m, z31.d, z31.d
asr     z21.s, z10.s, z21.d
//CHECK: asr     z21.s, z10.s, z21.d
fadd    z31.h, p7/m, z31.h, #1.0
//CHECK: fadd    z31.h, p7/m, z31.h, #1.0
andv    b0, p0, z0.b
//CHECK: andv    b0, p0, z0.b
fcmge   p7.h, p3/z, z13.h, #0.0
//CHECK: fcmge   p7.h, p3/z, z13.h, #0.0
whilels p5.s, x10, x21
//CHECK: whilels p5.s, x10, x21
st1h    {z21.h}, p5, [x10, x21, lsl #1]
//CHECK: st1h    {z21.h}, p5, [x10, x21, lsl #1]
whilelo p5.b, w10, w21
//CHECK: whilelo p5.b, w10, w21
sqincp  x23, p13.d
//CHECK: sqincp  x23, p13.d
mov     z5.s, z17.s[14]
//CHECK: mov     z5.s, z17.s[14]
decb    x0, pow2
//CHECK: decb    x0, pow2
ldff1d  {z21.d}, p5/z, [x10, z21.d, sxtw #3]
//CHECK: ldff1d  {z21.d}, p5/z, [x10, z21.d, sxtw #3]
cmphi   p15.h, p7/z, z31.h, #127
//CHECK: cmphi   p15.h, p7/z, z31.h, #127
trn2    z21.s, z10.s, z21.s
//CHECK: trn2    z21.s, z10.s, z21.s
ld2w    {z0.s, z1.s}, p0/z, [x0]
//CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0]
eor     z0.d, z0.d, z0.d
//CHECK: eor     z0.d, z0.d, z0.d
fcvtzs  z23.s, p3/m, z13.h
//CHECK: fcvtzs  z23.s, p3/m, z13.h
fmaxnm  z21.d, p5/m, z21.d, z10.d
//CHECK: fmaxnm  z21.d, p5/m, z21.d, z10.d
fsqrt   z23.h, p3/m, z13.h
//CHECK: fsqrt   z23.h, p3/m, z13.h
ldnf1b  {z31.b}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1b  {z31.b}, p7/z, [sp, #-1, mul vl]
cmpeq   p0.d, p0/z, z0.d, z0.d
//CHECK: cmpeq   p0.d, p0/z, z0.d, z0.d
zip1    p7.d, p13.d, p8.d
//CHECK: zip1    p7.d, p13.d, p8.d
scvtf   z21.d, p5/m, z10.d
//CHECK: scvtf   z21.d, p5/m, z10.d
revb    z23.h, p3/m, z13.h
//CHECK: revb    z23.h, p3/m, z13.h
smin    z23.b, p3/m, z23.b, z13.b
//CHECK: smin    z23.b, p3/m, z23.b, z13.b
lsl     z0.b, z0.b, #0
//CHECK: lsl     z0.b, z0.b, #0
st1h    {z0.h}, p0, [x0, x0, lsl #1]
//CHECK: st1h    {z0.h}, p0, [x0, x0, lsl #1]
decp    z31.s, p15
//CHECK: decp    z31.s, p15
fcvtzu  z23.d, p3/m, z13.d
//CHECK: fcvtzu  z23.d, p3/m, z13.d
fadd    z23.h, z13.h, z8.h
//CHECK: fadd    z23.h, z13.h, z8.h
cmple   p5.s, p5/z, z10.s, #-11
//CHECK: cmple   p5.s, p5/z, z10.s, #-11
st3h    {z0.h, z1.h, z2.h}, p0, [x0, x0, lsl #1]
//CHECK: st3h    {z0.h, z1.h, z2.h}, p0, [x0, x0, lsl #1]
st2h    {z21.h, z22.h}, p5, [x10, x21, lsl #1]
//CHECK: st2h    {z21.h, z22.h}, p5, [x10, x21, lsl #1]
fminnm  z21.s, p5/m, z21.s, #0.0
//CHECK: fminnm  z21.s, p5/m, z21.s, #0.0
ld1sh   {z21.s}, p5/z, [x10, z21.s, uxtw #1]
//CHECK: ld1sh   {z21.s}, p5/z, [x10, z21.s, uxtw #1]
fcmgt   p5.d, p5/z, z10.d, #0.0
//CHECK: fcmgt   p5.d, p5/z, z10.d, #0.0
ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw #1]
//CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw #1]
sqincw  xzr, wzr, all, mul #16
//CHECK: sqincw  xzr, wzr, all, mul #16
adr     z31.d, [z31.d, z31.d, sxtw]
//CHECK: adr     z31.d, [z31.d, z31.d, sxtw]
uqdecp  x21, p10.b
//CHECK: uqdecp  x21, p10.b
scvtf   z21.h, p5/m, z10.s
//CHECK: scvtf   z21.h, p5/m, z10.s
ldnf1sh {z0.d}, p0/z, [x0]
//CHECK: ldnf1sh {z0.d}, p0/z, [x0]
sqincp  x0, p0.b
//CHECK: sqincp  x0, p0.b
ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw #3]
//CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw #3]
uminv   s0, p0, z0.s
//CHECK: uminv   s0, p0, z0.s
cmpne   p7.d, p3/z, z13.d, z8.d
//CHECK: cmpne   p7.d, p3/z, z13.d, z8.d
st3b    {z0.b, z1.b, z2.b}, p0, [x0, x0]
//CHECK: st3b    {z0.b, z1.b, z2.b}, p0, [x0, x0]
fscale  z23.h, p3/m, z23.h, z13.h
//CHECK: fscale  z23.h, p3/m, z23.h, z13.h
frintx  z0.s, p0/m, z0.s
//CHECK: frintx  z0.s, p0/m, z0.s
rbit    z23.s, p3/m, z13.s
//CHECK: rbit    z23.s, p3/m, z13.s
add     z21.d, z21.d, #170
//CHECK: add     z21.d, z21.d, #170
sminv   s31, p7, z31.s
//CHECK: sminv   s31, p7, z31.s
and     z21.s, p5/m, z21.s, z10.s
//CHECK: and     z21.s, p5/m, z21.s, z10.s
fmla    z21.s, p5/m, z10.s, z21.s
//CHECK: fmla    z21.s, p5/m, z10.s, z21.s
mov     z21.s, z10.s[6]
//CHECK: mov     z21.s, z10.s[6]
smin    z21.b, z21.b, #-86
//CHECK: smin    z21.b, z21.b, #-86
uqincb  wzr, all, mul #16
//CHECK: uqincb  wzr, all, mul #16
cmphs   p15.s, p7/z, z31.s, #127
//CHECK: cmphs   p15.s, p7/z, z31.s, #127
fmaxnmv s21, p5, z10.s
//CHECK: fmaxnmv s21, p5, z10.s
ld1rqw  {z21.s}, p5/z, [x10, x21, lsl #2]
//CHECK: ld1rqw  {z21.s}, p5/z, [x10, x21, lsl #2]
fmov    z23.d, p8/m, #0.90625
//CHECK: fmov    z23.d, p8/m, #0.90625
uqsub   z21.s, z10.s, z21.s
//CHECK: uqsub   z21.s, z10.s, z21.s
scvtf   z0.s, p0/m, z0.s
//CHECK: scvtf   z0.s, p0/m, z0.s
lsl     z21.d, p5/m, z21.d, z10.d
//CHECK: lsl     z21.d, p5/m, z21.d, z10.d
whilele p0.s, w0, w0
//CHECK: whilele p0.s, w0, w0
uxtb    z0.s, p0/m, z0.s
//CHECK: uxtb    z0.s, p0/m, z0.s
abs     z31.b, p7/m, z31.b
//CHECK: abs     z31.b, p7/m, z31.b
prfd    #15, p7, [z31.s, #248]
//CHECK: prfd    #15, p7, [z31.s, #248]
tbl     z21.s, {z10.s}, z21.s
//CHECK: tbl     z21.s, {z10.s}, z21.s
ld1rqh  {z31.h}, p7/z, [sp, #-16]
//CHECK: ld1rqh  {z31.h}, p7/z, [sp, #-16]
uqadd   z1.b, z1.b, #33
//CHECK: uqadd   z1.b, z1.b, #33
frintx  z23.d, p3/m, z13.d
//CHECK: frintx  z23.d, p3/m, z13.d
mls     z0.d, p0/m, z0.d, z0.d
//CHECK: mls     z0.d, p0/m, z0.d, z0.d
ld1h    {z21.d}, p5/z, [x10, z21.d, lsl #1]
//CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, lsl #1]
trn2    p7.h, p13.h, p8.h
//CHECK: trn2    p7.h, p13.h, p8.h
fcmne   p0.d, p0/z, z0.d, #0.0
//CHECK: fcmne   p0.d, p0/z, z0.d, #0.0
sxtb    z31.s, p7/m, z31.s
//CHECK: sxtb    z31.s, p7/m, z31.s
mov     z5.h, z17.h[28]
//CHECK: mov     z5.h, z17.h[28]
clastb  z31.b, p7, z31.b, z31.b
//CHECK: clastb  z31.b, p7, z31.b, z31.b
st1w    {z0.s}, p0, [x0, z0.s, uxtw]
//CHECK: st1w    {z0.s}, p0, [x0, z0.s, uxtw]
sqdecp  z0.s, p0
//CHECK: sqdecp  z0.s, p0
mad     z23.h, p3/m, z8.h, z13.h
//CHECK: mad     z23.h, p3/m, z8.h, z13.h
ldnt1w  {z5.s}, p3/z, [x17, x16, lsl #2]
//CHECK: ldnt1w  {z5.s}, p3/z, [x17, x16, lsl #2]
frintn  z0.d, p0/m, z0.d
//CHECK: frintn  z0.d, p0/m, z0.d
uqdecp  z31.h, p15
//CHECK: uqdecp  z31.h, p15
smax    z31.s, z31.s, #-1
//CHECK: smax    z31.s, z31.s, #-1
fmaxv   d23, p3, z13.d
//CHECK: fmaxv   d23, p3, z13.d
uqincp  w21, p10.h
//CHECK: uqincp  w21, p10.h
insr    z0.b, w0
//CHECK: insr    z0.b, w0
revb    z23.d, p3/m, z13.d
//CHECK: revb    z23.d, p3/m, z13.d
sqdecd  z31.d, all, mul #16
//CHECK: sqdecd  z31.d, all, mul #16
zip1    z21.b, z10.b, z21.b
//CHECK: zip1    z21.b, z10.b, z21.b
mov     z0.d, p0/z, #0
//CHECK: mov     z0.d, p0/z, #0
orr     z21.s, p5/m, z21.s, z10.s
//CHECK: orr     z21.s, p5/m, z21.s, z10.s
prfb    pldl1keep, p0, [x0, z0.d, uxtw]
//CHECK: prfb    pldl1keep, p0, [x0, z0.d, uxtw]
clasta  d21, p5, d21, z10.d
//CHECK: clasta  d21, p5, d21, z10.d
eor     z31.d, p7/m, z31.d, z31.d
//CHECK: eor     z31.d, p7/m, z31.d, z31.d
st3b    {z21.b, z22.b, z23.b}, p5, [x10, #15, mul vl]
//CHECK: st3b    {z21.b, z22.b, z23.b}, p5, [x10, #15, mul vl]
sqadd   z31.s, z31.s, #255, lsl #8
//CHECK: sqadd   z31.s, z31.s, #65280
st1b    {z23.s}, p3, [x13, z8.s, sxtw]
//CHECK: st1b    {z23.s}, p3, [x13, z8.s, sxtw]
revb    z31.h, p7/m, z31.h
//CHECK: revb    z31.h, p7/m, z31.h
prfw    #15, p7, [sp, z31.s, uxtw #2]
//CHECK: prfw    #15, p7, [sp, z31.s, uxtw #2]
mov     z21.s, p5/m, #-86
//CHECK: mov     z21.s, p5/m, #-86
decp    z23.d, p13
//CHECK: decp    z23.d, p13
mov     p0.b, p0/z, p0.b
//CHECK: mov     p0.b, p0/z, p0.b
uunpklo z0.d, z0.s
//CHECK: uunpklo z0.d, z0.s
ld1rb   {z23.s}, p3/z, [x13, #8]
//CHECK: ld1rb   {z23.s}, p3/z, [x13, #8]
uqsub   z21.s, z21.s, #170
//CHECK: uqsub   z21.s, z21.s, #170
zip2    p7.b, p13.b, p8.b
//CHECK: zip2    p7.b, p13.b, p8.b
cmplo   p0.s, p0/z, z0.s, #0
//CHECK: cmplo   p0.s, p0/z, z0.s, #0
trn1    z31.d, z31.d, z31.d
//CHECK: trn1    z31.d, z31.d, z31.d
add     z31.s, z31.s, #255, lsl #8
//CHECK: add     z31.s, z31.s, #65280
frsqrte z21.d, z10.d
//CHECK: frsqrte z21.d, z10.d
fsub    z21.d, z10.d, z21.d
//CHECK: fsub    z21.d, z10.d, z21.d
abs     z31.d, p7/m, z31.d
//CHECK: abs     z31.d, p7/m, z31.d
ld4h    {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0]
//CHECK: ld4h    {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0]
ftmad   z23.h, z23.h, z13.h, #0
//CHECK: ftmad   z23.h, z23.h, z13.h, #0
sqincp  z21.d, p10
//CHECK: sqincp  z21.d, p10
sqincb  xzr, wzr, all, mul #16
//CHECK: sqincb  xzr, wzr, all, mul #16
cmpge   p0.h, p0/z, z0.h, z0.d
//CHECK: cmpge   p0.h, p0/z, z0.h, z0.d
zip1    p7.b, p13.b, p8.b
//CHECK: zip1    p7.b, p13.b, p8.b
brkb    p15.b, p15/z, p15.b
//CHECK: brkb    p15.b, p15/z, p15.b
subr    z0.s, z0.s, #0
//CHECK: subr    z0.s, z0.s, #0
eor     z31.d, z31.d, z31.d
//CHECK: eor     z31.d, z31.d, z31.d
st4b    {z5.b, z6.b, z7.b, z8.b}, p3, [x17, x16]
//CHECK: st4b    {z5.b, z6.b, z7.b, z8.b}, p3, [x17, x16]
clastb  x0, p0, x0, z0.d
//CHECK: clastb  x0, p0, x0, z0.d
movprfx z0.b, p0/z, z0.b
//CHECK: movprfx z0.b, p0/z, z0.b
add     z0.b, p0/m, z0.b, z1.b
//CHECK: add z0.b, p0/m, z0.b, z1.b
neg     z0.h, p0/m, z0.h
//CHECK: neg     z0.h, p0/m, z0.h
ldff1b  {z21.d}, p5/z, [x10, x21]
//CHECK: ldff1b  {z21.d}, p5/z, [x10, x21]
umin    z31.d, p7/m, z31.d, z31.d
//CHECK: umin    z31.d, p7/m, z31.d, z31.d
ld1sh   {z31.d}, p7/z, [sp, z31.d, sxtw #1]
//CHECK: ld1sh   {z31.d}, p7/z, [sp, z31.d, sxtw #1]
rev     p0.h, p0.h
//CHECK: rev     p0.h, p0.h
ld1sb   {z0.s}, p0/z, [x0, x0]
//CHECK: ld1sb   {z0.s}, p0/z, [x0, x0]
revb    z31.s, p7/m, z31.s
//CHECK: revb    z31.s, p7/m, z31.s
cmpeq   p7.b, p3/z, z13.b, z8.b
//CHECK: cmpeq   p7.b, p3/z, z13.b, z8.b
sqincw  z0.s, pow2
//CHECK: sqincw  z0.s, pow2
ld1sh   {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1sh   {z31.d}, p7/z, [sp, #-1, mul vl]
fcmlt   p15.s, p7/z, z31.s, #0.0
//CHECK: fcmlt   p15.s, p7/z, z31.s, #0.0
st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, #-32, mul vl]
//CHECK: st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, #-32, mul vl]
fcmlt   p5.s, p5/z, z10.s, #0.0
//CHECK: fcmlt   p5.s, p5/z, z10.s, #0.0
sabd    z23.h, p3/m, z23.h, z13.h
//CHECK: sabd    z23.h, p3/m, z23.h, z13.h
cmple   p5.b, p5/z, z10.b, z21.d
//CHECK: cmple   p5.b, p5/z, z10.b, z21.d
adr     z23.d, [z13.d, z8.d, lsl #3]
//CHECK: adr     z23.d, [z13.d, z8.d, lsl #3]
fminnmv h23, p3, z13.h
//CHECK: fminnmv h23, p3, z13.h
sqdech  z21.h, vl32, mul #6
//CHECK: sqdech  z21.h, vl32, mul #6
fmov    z0.d, #2.0
//CHECK: fmov    z0.d, #2.0
ldff1sw {z31.d}, p7/z, [sp, z31.d, uxtw #2]
//CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, uxtw #2]
fminv   s31, p7, z31.s
//CHECK: fminv   s31, p7, z31.s
fexpa   z21.h, z10.h
//CHECK: fexpa   z21.h, z10.h
ld1sb   {z21.h}, p5/z, [x10, x21]
//CHECK: ld1sb   {z21.h}, p5/z, [x10, x21]
cmphs   p0.b, p0/z, z0.b, z0.d
//CHECK: cmphs   p0.b, p0/z, z0.b, z0.d
mov     z31.q, z31.q[3]
//CHECK: mov     z31.q, z31.q[3]
fnmsb   z31.h, p7/m, z31.h, z31.h
//CHECK: fnmsb   z31.h, p7/m, z31.h, z31.h
ldnf1b  {z23.b}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1b  {z23.b}, p3/z, [x13, #-8, mul vl]
whilele p5.s, x10, x21
//CHECK: whilele p5.s, x10, x21
sqinch  xzr, wzr, all, mul #16
//CHECK: sqinch  xzr, wzr, all, mul #16
uabd    z21.h, p5/m, z21.h, z10.h
//CHECK: uabd    z21.h, p5/m, z21.h, z10.h
ld1w    {z21.d}, p5/z, [x10, x21, lsl #2]
//CHECK: ld1w    {z21.d}, p5/z, [x10, x21, lsl #2]
cmplo   p0.s, p0/z, z0.s, z0.d
//CHECK: cmplo   p0.s, p0/z, z0.s, z0.d
ptrues  p5.b, vl32
//CHECK: ptrues  p5.b, vl32
asrr    z21.h, p5/m, z21.h, z10.h
//CHECK: asrr    z21.h, p5/m, z21.h, z10.h
movprfx z31.s, p7/z, z31.s
//CHECK: movprfx z31.s, p7/z, z31.s
add     z31.s, p7/m, z31.s, z0.s
//CHECK: add z31.s, p7/m, z31.s, z0.s
clastb  h21, p5, h21, z10.h
//CHECK: clastb  h21, p5, h21, z10.h
sqdecp  xzr, p15.s
//CHECK: sqdecp  xzr, p15.s
sqdecp  z21.s, p10
//CHECK: sqdecp  z21.s, p10
uqincb  x0, pow2
//CHECK: uqincb  x0, pow2
fmax    z0.d, p0/m, z0.d, z0.d
//CHECK: fmax    z0.d, p0/m, z0.d, z0.d
st1d    {z0.d}, p0, [x0, z0.d, sxtw #3]
//CHECK: st1d    {z0.d}, p0, [x0, z0.d, sxtw #3]
cmplt   p7.s, p3/z, z13.s, z8.d
//CHECK: cmplt   p7.s, p3/z, z13.s, z8.d
sqdecp  x23, p13.d
//CHECK: sqdecp  x23, p13.d
not     z23.b, p3/m, z13.b
//CHECK: not     z23.b, p3/m, z13.b
uqdecp  z0.s, p0
//CHECK: uqdecp  z0.s, p0
cmpgt   p0.d, p0/z, z0.d, #0
//CHECK: cmpgt   p0.d, p0/z, z0.d, #0
zip2    p7.s, p13.s, p8.s
//CHECK: zip2    p7.s, p13.s, p8.s
fdiv    z31.s, p7/m, z31.s, z31.s
//CHECK: fdiv    z31.s, p7/m, z31.s, z31.s
udot    z31.d, z31.h, z31.h
//CHECK: udot    z31.d, z31.h, z31.h
ld2h    {z23.h, z24.h}, p3/z, [x13, #-16, mul vl]
//CHECK: ld2h    {z23.h, z24.h}, p3/z, [x13, #-16, mul vl]
uzp2    z21.b, z10.b, z21.b
//CHECK: uzp2    z21.b, z10.b, z21.b
andv    h23, p3, z13.h
//CHECK: andv    h23, p3, z13.h
mov     z21.b, p5/m, b10
//CHECK: mov     z21.b, p5/m, b10
mad     z21.b, p5/m, z21.b, z10.b
//CHECK: mad     z21.b, p5/m, z21.b, z10.b
fcvt    z23.d, p3/m, z13.s
//CHECK: fcvt    z23.d, p3/m, z13.s
uunpkhi z23.s, z13.h
//CHECK: uunpkhi z23.s, z13.h
fmin    z21.h, p5/m, z21.h, z10.h
//CHECK: fmin    z21.h, p5/m, z21.h, z10.h
fcmge   p0.s, p0/z, z0.s, #0.0
//CHECK: fcmge   p0.s, p0/z, z0.s, #0.0
whilele p5.d, w10, w21
//CHECK: whilele p5.d, w10, w21
ctermeq xzr, xzr
//CHECK: ctermeq xzr, xzr
fcmeq   p7.s, p3/z, z13.s, z8.s
//CHECK: fcmeq   p7.s, p3/z, z13.s, z8.s
uzp2    z0.b, z0.b, z0.b
//CHECK: uzp2    z0.b, z0.b, z0.b
brkpb   p7.b, p11/z, p13.b, p8.b
//CHECK: brkpb   p7.b, p11/z, p13.b, p8.b
compact z23.d, p3, z13.d
//CHECK: compact z23.d, p3, z13.d
andv    b21, p5, z10.b
//CHECK: andv    b21, p5, z10.b
uzp1    p0.h, p0.h, p0.h
//CHECK: uzp1    p0.h, p0.h, p0.h
fmla    z23.h, z13.h, z0.h[5]
//CHECK: fmla    z23.h, z13.h, z0.h[5]
clastb  s0, p0, s0, z0.s
//CHECK: clastb  s0, p0, s0, z0.s
ext     z31.b, z31.b, z31.b, #255
//CHECK: ext     z31.b, z31.b, z31.b, #255
fsubr   z21.d, p5/m, z21.d, z10.d
//CHECK: fsubr   z21.d, p5/m, z21.d, z10.d
fcvtzs  z23.d, p3/m, z13.h
//CHECK: fcvtzs  z23.d, p3/m, z13.h
ldff1h  {z0.s}, p0/z, [x0, x0, lsl #1]
//CHECK: ldff1h  {z0.s}, p0/z, [x0, x0, lsl #1]
fminnmv s21, p5, z10.s
//CHECK: fminnmv s21, p5, z10.s
stnt1w  {z23.s}, p3, [x13, x8, lsl #2]
//CHECK: stnt1w  {z23.s}, p3, [x13, x8, lsl #2]
umax    z23.d, z23.d, #109
//CHECK: umax    z23.d, z23.d, #109
prfd    pldl3strm, p5, [x10, #21, mul vl]
//CHECK: prfd    pldl3strm, p5, [x10, #21, mul vl]
fnmls   z31.s, p7/m, z31.s, z31.s
//CHECK: fnmls   z31.s, p7/m, z31.s, z31.s
cmpls   p0.h, p0/z, z0.h, #0
//CHECK: cmpls   p0.h, p0/z, z0.h, #0
index   z31.s, wzr, #-1
//CHECK: index   z31.s, wzr, #-1
rbit    z0.d, p0/m, z0.d
//CHECK: rbit    z0.d, p0/m, z0.d
sminv   b31, p7, z31.b
//CHECK: sminv   b31, p7, z31.b
pnext   p0.s, p0, p0.s
//CHECK: pnext   p0.s, p0, p0.s
ld1w    {z23.s}, p3/z, [x13, x8, lsl #2]
//CHECK: ld1w    {z23.s}, p3/z, [x13, x8, lsl #2]
sub     z23.b, z13.b, z8.b
//CHECK: sub     z23.b, z13.b, z8.b
uqdecp  x23, p13.s
//CHECK: uqdecp  x23, p13.s
ldnt1h  {z31.h}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnt1h  {z31.h}, p7/z, [sp, #-1, mul vl]
uqdecp  w23, p13.h
//CHECK: uqdecp  w23, p13.h
st1d    {z21.d}, p5, [x10, z21.d, sxtw]
//CHECK: st1d    {z21.d}, p5, [x10, z21.d, sxtw]
st2d    {z5.d, z6.d}, p3, [x17, x16, lsl #3]
//CHECK: st2d    {z5.d, z6.d}, p3, [x17, x16, lsl #3]
ldff1b  {z21.d}, p5/z, [z10.d, #21]
//CHECK: ldff1b  {z21.d}, p5/z, [z10.d, #21]
fcmlt   p7.s, p3/z, z13.s, #0.0
//CHECK: fcmlt   p7.s, p3/z, z13.s, #0.0
lsr     z23.d, p3/m, z23.d, z13.d
//CHECK: lsr     z23.d, p3/m, z23.d, z13.d
ld4h    {z5.h, z6.h, z7.h, z8.h}, p3/z, [x17, x16, lsl #1]
//CHECK: ld4h    {z5.h, z6.h, z7.h, z8.h}, p3/z, [x17, x16, lsl #1]
sunpkhi z23.d, z13.s
//CHECK: sunpkhi z23.d, z13.s
smax    z23.b, p3/m, z23.b, z13.b
//CHECK: smax    z23.b, p3/m, z23.b, z13.b
st1h    {z21.s}, p5, [x10, z21.s, sxtw #1]
//CHECK: st1h    {z21.s}, p5, [x10, z21.s, sxtw #1]
cnot    z0.d, p0/m, z0.d
//CHECK: cnot    z0.d, p0/m, z0.d
prfb    pldl1keep, p0, [x0, z0.s, sxtw]
//CHECK: prfb    pldl1keep, p0, [x0, z0.s, sxtw]
rbit    z0.h, p0/m, z0.h
//CHECK: rbit    z0.h, p0/m, z0.h
inch    x0, pow2
//CHECK: inch    x0, pow2
uxth    z23.s, p3/m, z13.s
//CHECK: uxth    z23.s, p3/m, z13.s
ldff1sb {z21.d}, p5/z, [x10, z21.d]
//CHECK: ldff1sb {z21.d}, p5/z, [x10, z21.d]
uqadd   z23.s, z13.s, z8.s
//CHECK: uqadd   z23.s, z13.s, z8.s
mla     z31.d, p7/m, z31.d, z31.d
//CHECK: mla     z31.d, p7/m, z31.d, z31.d
ldff1sb {z21.d}, p5/z, [z10.d, #21]
//CHECK: ldff1sb {z21.d}, p5/z, [z10.d, #21]
fminnmv h31, p7, z31.h
//CHECK: fminnmv h31, p7, z31.h
cntp    x0, p0, p0.b
//CHECK: cntp    x0, p0, p0.b
ftmad   z31.d, z31.d, z31.d, #7
//CHECK: ftmad   z31.d, z31.d, z31.d, #7
frecps  z0.d, z0.d, z0.d
//CHECK: frecps  z0.d, z0.d, z0.d
trn2    z21.h, z10.h, z21.h
//CHECK: trn2    z21.h, z10.h, z21.h
rev     p0.b, p0.b
//CHECK: rev     p0.b, p0.b
stnt1d  {z23.d}, p3, [x13, #-8, mul vl]
//CHECK: stnt1d  {z23.d}, p3, [x13, #-8, mul vl]
fmla    z21.s, z10.s, z5.s[2]
//CHECK: fmla    z21.s, z10.s, z5.s[2]
ld1rsh  {z0.s}, p0/z, [x0]
//CHECK: ld1rsh  {z0.s}, p0/z, [x0]
scvtf   z23.h, p3/m, z13.d
//CHECK: scvtf   z23.h, p3/m, z13.d
uabd    z31.h, p7/m, z31.h, z31.h
//CHECK: uabd    z31.h, p7/m, z31.h, z31.h
fcvt    z23.s, p3/m, z13.h
//CHECK: fcvt    z23.s, p3/m, z13.h
ucvtf   z21.d, p5/m, z10.d
//CHECK: ucvtf   z21.d, p5/m, z10.d
lastb   x21, p5, z10.d
//CHECK: lastb   x21, p5, z10.d
sxth    z23.d, p3/m, z13.d
//CHECK: sxth    z23.d, p3/m, z13.d
mls     z23.s, p3/m, z13.s, z8.s
//CHECK: mls     z23.s, p3/m, z13.s, z8.s
zip1    z23.h, z13.h, z8.h
//CHECK: zip1    z23.h, z13.h, z8.h
lsl     z23.s, p3/m, z23.s, #13
//CHECK: lsl     z23.s, p3/m, z23.s, #13
zip1    p7.h, p13.h, p8.h
//CHECK: zip1    p7.h, p13.h, p8.h
ld1b    {z0.d}, p0/z, [x0, z0.d]
//CHECK: ld1b    {z0.d}, p0/z, [x0, z0.d]
abs     z21.d, p5/m, z10.d
//CHECK: abs     z21.d, p5/m, z10.d
umin    z23.b, p3/m, z23.b, z13.b
//CHECK: umin    z23.b, p3/m, z23.b, z13.b
ldff1h  {z21.s}, p5/z, [x10, z21.s, uxtw]
//CHECK: ldff1h  {z21.s}, p5/z, [x10, z21.s, uxtw]
fcmne   p7.s, p3/z, z13.s, z8.s
//CHECK: fcmne   p7.s, p3/z, z13.s, z8.s
lslr    z31.h, p7/m, z31.h, z31.h
//CHECK: lslr    z31.h, p7/m, z31.h, z31.h
uqincw  w23, vl256, mul #9
//CHECK: uqincw  w23, vl256, mul #9
smax    z23.b, z23.b, #109
//CHECK: smax    z23.b, z23.b, #109
fmaxv   h31, p7, z31.h
//CHECK: fmaxv   h31, p7, z31.h
msb     z0.b, p0/m, z0.b, z0.b
//CHECK: msb     z0.b, p0/m, z0.b, z0.b
whilelo p0.h, x0, x0
//CHECK: whilelo p0.h, x0, x0
ldff1h  {z31.s}, p7/z, [sp, xzr, lsl #1]
//CHECK: ldff1h  {z31.s}, p7/z, [sp]
fcmgt   p7.d, p3/z, z13.d, #0.0
//CHECK: fcmgt   p7.d, p3/z, z13.d, #0.0
ld1w    {z31.d}, p7/z, [sp, z31.d, uxtw #2]
//CHECK: ld1w    {z31.d}, p7/z, [sp, z31.d, uxtw #2]
mov     z21.d, x10
//CHECK: mov     z21.d, x10
clasta  s23, p3, s23, z13.s
//CHECK: clasta  s23, p3, s23, z13.s
brka    p7.b, p11/z, p13.b
//CHECK: brka    p7.b, p11/z, p13.b
lsrr    z0.d, p0/m, z0.d, z0.d
//CHECK: lsrr    z0.d, p0/m, z0.d, z0.d
fminnm  z31.d, p7/m, z31.d, #1.0
//CHECK: fminnm  z31.d, p7/m, z31.d, #1.0
ld1w    {z0.s}, p0/z, [x0, z0.s, sxtw]
//CHECK: ld1w    {z0.s}, p0/z, [x0, z0.s, sxtw]
mla     z21.s, p5/m, z10.s, z21.s
//CHECK: mla     z21.s, p5/m, z10.s, z21.s
sqdecp  x23, p13.b
//CHECK: sqdecp  x23, p13.b
cmpeq   p0.h, p0/z, z0.h, z0.h
//CHECK: cmpeq   p0.h, p0/z, z0.h, z0.h
ldff1d  {z31.d}, p7/z, [sp, z31.d, lsl #3]
//CHECK: ldff1d  {z31.d}, p7/z, [sp, z31.d, lsl #3]
cmpls   p5.h, p5/z, z10.h, #85
//CHECK: cmpls   p5.h, p5/z, z10.h, #85
ld2d    {z0.d, z1.d}, p0/z, [x0]
//CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0]
compact z21.d, p5, z10.d
//CHECK: compact z21.d, p5, z10.d
st1d    {z31.d}, p7, [sp, z31.d]
//CHECK: st1d    {z31.d}, p7, [sp, z31.d]
neg     z31.h, p7/m, z31.h
//CHECK: neg     z31.h, p7/m, z31.h
adr     z21.s, [z10.s, z21.s, lsl #2]
//CHECK: adr     z21.s, [z10.s, z21.s, lsl #2]
andv    b31, p7, z31.b
//CHECK: andv    b31, p7, z31.b
fmax    z0.s, p0/m, z0.s, #0.0
//CHECK: fmax    z0.s, p0/m, z0.s, #0.0
fnmls   z21.h, p5/m, z10.h, z21.h
//CHECK: fnmls   z21.h, p5/m, z10.h, z21.h
umin    z21.b, z21.b, #170
//CHECK: umin    z21.b, z21.b, #170
uqdecp  z31.s, p15
//CHECK: uqdecp  z31.s, p15
ld1h    {z0.d}, p0/z, [x0, x0, lsl #1]
//CHECK: ld1h    {z0.d}, p0/z, [x0, x0, lsl #1]
cnt     z21.h, p5/m, z10.h
//CHECK: cnt     z21.h, p5/m, z10.h
ld1sw   {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ld1sw   {z0.d}, p0/z, [x0, z0.d, uxtw]
rev     p15.d, p15.d
//CHECK: rev     p15.d, p15.d
ld1w    {z5.d}, p3/z, [x17, x16, lsl #2]
//CHECK: ld1w    {z5.d}, p3/z, [x17, x16, lsl #2]
add     z31.b, z31.b, z31.b
//CHECK: add     z31.b, z31.b, z31.b
uzp1    p7.d, p13.d, p8.d
//CHECK: uzp1    p7.d, p13.d, p8.d
fnmsb   z21.d, p5/m, z10.d, z21.d
//CHECK: fnmsb   z21.d, p5/m, z10.d, z21.d
ldff1sh {z31.d}, p7/z, [sp, z31.d]
//CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d]
cmpne   p15.b, p7/z, z31.b, z31.b
//CHECK: cmpne   p15.b, p7/z, z31.b, z31.b
rbit    z0.b, p0/m, z0.b
//CHECK: rbit    z0.b, p0/m, z0.b
smin    z0.s, z0.s, #0
//CHECK: smin    z0.s, z0.s, #0
ld1rd   {z23.d}, p3/z, [x13, #64]
//CHECK: ld1rd   {z23.d}, p3/z, [x13, #64]
asr     z31.b, z31.b, #1
//CHECK: asr     z31.b, z31.b, #1
ldff1b  {z31.d}, p7/z, [sp, z31.d]
//CHECK: ldff1b  {z31.d}, p7/z, [sp, z31.d]
ldff1sh {z21.d}, p5/z, [x10, z21.d]
//CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d]
ldff1w  {z21.s}, p5/z, [x10, z21.s, sxtw #2]
//CHECK: ldff1w  {z21.s}, p5/z, [x10, z21.s, sxtw #2]
eorv    d31, p7, z31.d
//CHECK: eorv    d31, p7, z31.d
subr    z0.d, z0.d, #0
//CHECK: subr    z0.d, z0.d, #0
ldff1h  {z31.s}, p7/z, [sp, z31.s, uxtw]
//CHECK: ldff1h  {z31.s}, p7/z, [sp, z31.s, uxtw]
nots    p0.b, p0/z, p0.b
//CHECK: nots    p0.b, p0/z, p0.b
ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw #1]
//CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw #1]
fcmeq   p15.s, p7/z, z31.s, z31.s
//CHECK: fcmeq   p15.s, p7/z, z31.s, z31.s
ld1rqh  {z0.h}, p0/z, [x0, x0, lsl #1]
//CHECK: ld1rqh  {z0.h}, p0/z, [x0, x0, lsl #1]
incp    x23, p13.b
//CHECK: incp    x23, p13.b
stnt1d  {z0.d}, p0, [x0, x0, lsl #3]
//CHECK: stnt1d  {z0.d}, p0, [x0, x0, lsl #3]
fsubr   z31.d, p7/m, z31.d, #1.0
//CHECK: fsubr   z31.d, p7/m, z31.d, #1.0
faddv   s21, p5, z10.s
//CHECK: faddv   s21, p5, z10.s
insr    z31.h, wzr
//CHECK: insr    z31.h, wzr
uunpkhi z31.s, z31.h
//CHECK: uunpkhi z31.s, z31.h
umaxv   h23, p3, z13.h
//CHECK: umaxv   h23, p3, z13.h
whilelo p7.b, x13, x8
//CHECK: whilelo p7.b, x13, x8
uqadd   z21.d, z21.d, #170
//CHECK: uqadd   z21.d, z21.d, #170
ldff1h  {z23.d}, p3/z, [x13, z8.d, sxtw #1]
//CHECK: ldff1h  {z23.d}, p3/z, [x13, z8.d, sxtw #1]
uaddv   d0, p0, z0.h
//CHECK: uaddv   d0, p0, z0.h
frinti  z0.s, p0/m, z0.s
//CHECK: frinti  z0.s, p0/m, z0.s
ldff1w  {z23.d}, p3/z, [x13, z8.d]
//CHECK: ldff1w  {z23.d}, p3/z, [x13, z8.d]
mov     z0.q, q12
//CHECK: mov     z0.q, q12
brka    p15.b, p15/z, p15.b
//CHECK: brka    p15.b, p15/z, p15.b
lsrr    z21.b, p5/m, z21.b, z10.b
//CHECK: lsrr    z21.b, p5/m, z21.b, z10.b
zip2    p0.d, p0.d, p0.d
//CHECK: zip2    p0.d, p0.d, p0.d
asr     z31.h, z31.h, z31.d
//CHECK: asr     z31.h, z31.h, z31.d
mov     z5.d, z17.d[7]
//CHECK: mov     z5.d, z17.d[7]
uqincd  x23, vl256, mul #9
//CHECK: uqincd  x23, vl256, mul #9
st1b    {z0.d}, p0, [z0.d]
//CHECK: st1b    {z0.d}, p0, [z0.d]
fadda   s23, p3, s23, z13.s
//CHECK: fadda   s23, p3, s23, z13.s
fcvtzs  z31.s, p7/m, z31.d
//CHECK: fcvtzs  z31.s, p7/m, z31.d
ldff1h  {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ldff1h  {z23.d}, p3/z, [x13, z8.d, sxtw]
clasta  z23.d, p3, z23.d, z13.d
//CHECK: clasta  z23.d, p3, z23.d, z13.d
clz     z0.h, p0/m, z0.h
//CHECK: clz     z0.h, p0/m, z0.h
lsr     z31.h, p7/m, z31.h, #1
//CHECK: lsr     z31.h, p7/m, z31.h, #1
cmpeq   p15.d, p7/z, z31.d, #-1
//CHECK: cmpeq   p15.d, p7/z, z31.d, #-1
fcmgt   p5.s, p5/z, z10.s, #0.0
//CHECK: fcmgt   p5.s, p5/z, z10.s, #0.0
ld1rqw  {z23.s}, p3/z, [x13, x8, lsl #2]
//CHECK: ld1rqw  {z23.s}, p3/z, [x13, x8, lsl #2]
smaxv   s31, p7, z31.s
//CHECK: smaxv   s31, p7, z31.s
fcmne   p15.h, p7/z, z31.h, z31.h
//CHECK: fcmne   p15.h, p7/z, z31.h, z31.h
nor     p15.b, p15/z, p15.b, p15.b
//CHECK: nor     p15.b, p15/z, p15.b, p15.b
neg     z0.b, p0/m, z0.b
//CHECK: neg     z0.b, p0/m, z0.b
ldff1h  {z21.d}, p5/z, [x10, z21.d]
//CHECK: ldff1h  {z21.d}, p5/z, [x10, z21.d]
asr     z23.h, z13.h, z8.d
//CHECK: asr     z23.h, z13.h, z8.d
st1h    {z23.d}, p3, [x13, #-8, mul vl]
//CHECK: st1h    {z23.d}, p3, [x13, #-8, mul vl]
tbl     z0.s, {z0.s}, z0.s
//CHECK: tbl     z0.s, {z0.s}, z0.s
orv     d21, p5, z10.d
//CHECK: orv     d21, p5, z10.d
sqsub   z23.h, z23.h, #109, lsl #8
//CHECK: sqsub   z23.h, z23.h, #27904
eorv    s23, p3, z13.s
//CHECK: eorv    s23, p3, z13.s
lsrr    z31.b, p7/m, z31.b, z31.b
//CHECK: lsrr    z31.b, p7/m, z31.b, z31.b
ldff1sw {z0.d}, p0/z, [x0, z0.d, lsl #2]
//CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, lsl #2]
clastb  w23, p3, w23, z13.s
//CHECK: clastb  w23, p3, w23, z13.s
mov     z21.h, w10
//CHECK: mov     z21.h, w10
fcmge   p0.d, p0/z, z0.d, #0.0
//CHECK: fcmge   p0.d, p0/z, z0.d, #0.0
sub     z31.s, z31.s, #255, lsl #8
//CHECK: sub     z31.s, z31.s, #65280
decd    z21.d, vl32, mul #6
//CHECK: decd    z21.d, vl32, mul #6
sqinch  x23, w23, vl256, mul #9
//CHECK: sqinch  x23, w23, vl256, mul #9
asr     z0.s, z0.s, #32
//CHECK: asr     z0.s, z0.s, #32
ld1w    {z21.s}, p5/z, [z10.s, #84]
//CHECK: ld1w    {z21.s}, p5/z, [z10.s, #84]
cmpls   p7.b, p3/z, z13.b, #35
//CHECK: cmpls   p7.b, p3/z, z13.b, #35
fmaxnmv h21, p5, z10.h
//CHECK: fmaxnmv h21, p5, z10.h
whilels p15.h, wzr, wzr
//CHECK: whilels p15.h, wzr, wzr
rev     z0.d, z0.d
//CHECK: rev     z0.d, z0.d
asr     z0.s, p0/m, z0.s, #32
//CHECK: asr     z0.s, p0/m, z0.s, #32
uqsub   z0.s, z0.s, #0
//CHECK: uqsub   z0.s, z0.s, #0
cnth    x21, vl32, mul #6
//CHECK: cnth    x21, vl32, mul #6
cmple   p7.b, p3/z, z13.b, z8.d
//CHECK: cmple   p7.b, p3/z, z13.b, z8.d
and     z0.s, p0/m, z0.s, z0.s
//CHECK: and     z0.s, p0/m, z0.s, z0.s
mul     z0.h, p0/m, z0.h, z0.h
//CHECK: mul     z0.h, p0/m, z0.h, z0.h
cmpgt   p15.s, p7/z, z31.s, #-1
//CHECK: cmpgt   p15.s, p7/z, z31.s, #-1
prfb    pldl1keep, p0, [x0, z0.d]
//CHECK: prfb    pldl1keep, p0, [x0, z0.d]
smin    z0.d, z0.d, #0
//CHECK: smin    z0.d, z0.d, #0
clasta  b21, p5, b21, z10.b
//CHECK: clasta  b21, p5, b21, z10.b
ptrues  p0.s, pow2
//CHECK: ptrues  p0.s, pow2
udivr   z31.s, p7/m, z31.s, z31.s
//CHECK: udivr   z31.s, p7/m, z31.s, z31.s
frinti  z23.d, p3/m, z13.d
//CHECK: frinti  z23.d, p3/m, z13.d
ld1w    {z0.s}, p0/z, [x0, x0, lsl #2]
//CHECK: ld1w    {z0.s}, p0/z, [x0, x0, lsl #2]
cmpls   p7.h, p3/z, z13.h, z8.d
//CHECK: cmpls   p7.h, p3/z, z13.h, z8.d
whilelo p7.h, x13, x8
//CHECK: whilelo p7.h, x13, x8
st1b    {z31.s}, p7, [sp, z31.s, uxtw]
//CHECK: st1b    {z31.s}, p7, [sp, z31.s, uxtw]
lasta   s0, p0, z0.s
//CHECK: lasta   s0, p0, z0.s
mov     z0.s, p0/z, #0
//CHECK: mov     z0.s, p0/z, #0
whilelt p5.b, w10, w21
//CHECK: whilelt p5.b, w10, w21
ldff1w  {z23.s}, p3/z, [x13, z8.s, sxtw]
//CHECK: ldff1w  {z23.s}, p3/z, [x13, z8.s, sxtw]
whilelt p0.d, w0, w0
//CHECK: whilelt p0.d, w0, w0
and     z21.h, p5/m, z21.h, z10.h
//CHECK: and     z21.h, p5/m, z21.h, z10.h
ldff1sh {z23.d}, p3/z, [z13.d, #16]
//CHECK: ldff1sh {z23.d}, p3/z, [z13.d, #16]
ptrues  p0.b, pow2
//CHECK: ptrues  p0.b, pow2
ld1rb   {z23.b}, p3/z, [x13, #8]
//CHECK: ld1rb   {z23.b}, p3/z, [x13, #8]
cmple   p5.d, p5/z, z10.d, #-11
//CHECK: cmple   p5.d, p5/z, z10.d, #-11
mov     z21.b, w10
//CHECK: mov     z21.b, w10
adr     z21.s, [z10.s, z21.s, lsl #1]
//CHECK: adr     z21.s, [z10.s, z21.s, lsl #1]
ld1b    {z5.d}, p3/z, [x17, x16]
//CHECK: ld1b    {z5.d}, p3/z, [x17, x16]
lsr     z23.d, z13.d, #24
//CHECK: lsr     z23.d, z13.d, #24
fsub    z21.s, p5/m, z21.s, #0.5
//CHECK: fsub    z21.s, p5/m, z21.s, #0.5
sqsub   z0.d, z0.d, #0
//CHECK: sqsub   z0.d, z0.d, #0
smulh   z23.b, p3/m, z23.b, z13.b
//CHECK: smulh   z23.b, p3/m, z23.b, z13.b
fnmls   z23.d, p3/m, z13.d, z8.d
//CHECK: fnmls   z23.d, p3/m, z13.d, z8.d
sub     z21.d, z10.d, z21.d
//CHECK: sub     z21.d, z10.d, z21.d
ld1w    {z0.d}, p0/z, [x0, x0, lsl #2]
//CHECK: ld1w    {z0.d}, p0/z, [x0, x0, lsl #2]
fadd    z31.s, p7/m, z31.s, #1.0
//CHECK: fadd    z31.s, p7/m, z31.s, #1.0
st1w    {z0.d}, p0, [x0, z0.d, lsl #2]
//CHECK: st1w    {z0.d}, p0, [x0, z0.d, lsl #2]
lasta   b0, p0, z0.b
//CHECK: lasta   b0, p0, z0.b
movprfx z0.b, p0/m, z0.b
//CHECK: movprfx z0.b, p0/m, z0.b
add     z0.b, p0/m, z0.b, z1.b
//CHECK: add z0.b, p0/m, z0.b, z1.b
whilelt p5.b, x10, x21
//CHECK: whilelt p5.b, x10, x21
ld1d    {z23.d}, p3/z, [x13, z8.d, sxtw #3]
//CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, sxtw #3]
ftmad   z23.s, z23.s, z13.s, #0
//CHECK: ftmad   z23.s, z23.s, z13.s, #0
st1d    {z31.d}, p7, [sp, z31.d, uxtw]
//CHECK: st1d    {z31.d}, p7, [sp, z31.d, uxtw]
sqsub   z0.d, z0.d, z0.d
//CHECK: sqsub   z0.d, z0.d, z0.d
inch    z23.h, vl256, mul #9
//CHECK: inch    z23.h, vl256, mul #9
uqincd  z23.d, vl256, mul #9
//CHECK: uqincd  z23.d, vl256, mul #9
udot    z0.d, z0.h, z0.h[0]
//CHECK: udot    z0.d, z0.h, z0.h[0]
insr    z21.d, x10
//CHECK: insr    z21.d, x10
orv     b31, p7, z31.b
//CHECK: orv     b31, p7, z31.b
fmov    z21.d, p5/m, #-13.0
//CHECK: fmov    z21.d, p5/m, #-13.0
cmphi   p7.s, p3/z, z13.s, #35
//CHECK: cmphi   p7.s, p3/z, z13.s, #35
fsub    z23.s, z13.s, z8.s
//CHECK: fsub    z23.s, z13.s, z8.s
lastb   h23, p3, z13.h
//CHECK: lastb   h23, p3, z13.h
cmple   p15.b, p7/z, z31.b, #-1
//CHECK: cmple   p15.b, p7/z, z31.b, #-1
whilelt p7.h, w13, w8
//CHECK: whilelt p7.h, w13, w8
movprfx z21.b, p5/m, z10.b
//CHECK: movprfx z21.b, p5/m, z10.b
add     z21.b, p5/m, z21.b, z22.b
//CHECK: add z21.b, p5/m, z21.b, z22.b
fcmne   p7.h, p3/z, z13.h, z8.h
//CHECK: fcmne   p7.h, p3/z, z13.h, z8.h
cntp    xzr, p15, p15.h
//CHECK: cntp    xzr, p15, p15.h
index   z23.b, w13, w8
//CHECK: index   z23.b, w13, w8
sqincb  x0, w0, pow2
//CHECK: sqincb  x0, w0, pow2
clz     z31.d, p7/m, z31.d
//CHECK: clz     z31.d, p7/m, z31.d
uqdecp  x0, p0.s
//CHECK: uqdecp  x0, p0.s
fcvtzs  z23.d, p3/m, z13.s
//CHECK: fcvtzs  z23.d, p3/m, z13.s
smaxv   s21, p5, z10.s
//CHECK: smaxv   s21, p5, z10.s
ucvtf   z23.h, p3/m, z13.h
//CHECK: ucvtf   z23.h, p3/m, z13.h
fdivr   z21.h, p5/m, z21.h, z10.h
//CHECK: fdivr   z21.h, p5/m, z21.h, z10.h
prfw    pldl3strm, p5, [z10.s, #84]
//CHECK: prfw    pldl3strm, p5, [z10.s, #84]
prfw    pldl3strm, p5, [x10, z21.d, lsl #2]
//CHECK: prfw    pldl3strm, p5, [x10, z21.d, lsl #2]
rev     p5.h, p10.h
//CHECK: rev     p5.h, p10.h
ld3b    {z23.b, z24.b, z25.b}, p3/z, [x13, x8]
//CHECK: ld3b    {z23.b, z24.b, z25.b}, p3/z, [x13, x8]
st1b    {z21.s}, p5, [x10, #5, mul vl]
//CHECK: st1b    {z21.s}, p5, [x10, #5, mul vl]
ld1b    {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ld1b    {z21.d}, p5/z, [x10, z21.d, sxtw]
lsl     z23.s, z13.s, z8.d
//CHECK: lsl     z23.s, z13.s, z8.d
fnmls   z31.d, p7/m, z31.d, z31.d
//CHECK: fnmls   z31.d, p7/m, z31.d, z31.d
fsubr   z0.s, p0/m, z0.s, #0.5
//CHECK: fsubr   z0.s, p0/m, z0.s, #0.5
mls     z21.s, p5/m, z10.s, z21.s
//CHECK: mls     z21.s, p5/m, z10.s, z21.s
fmax    z21.d, p5/m, z21.d, #0.0
//CHECK: fmax    z21.d, p5/m, z21.d, #0.0
ldff1h  {z21.s}, p5/z, [z10.s, #42]
//CHECK: ldff1h  {z21.s}, p5/z, [z10.s, #42]
ld1sh   {z23.s}, p3/z, [z13.s, #16]
//CHECK: ld1sh   {z23.s}, p3/z, [z13.s, #16]
ptrue   p0.d, pow2
//CHECK: ptrue   p0.d, pow2
uxtb    z21.d, p5/m, z10.d
//CHECK: uxtb    z21.d, p5/m, z10.d
asrd    z0.h, p0/m, z0.h, #16
//CHECK: asrd    z0.h, p0/m, z0.h, #16
fminnm  z23.d, p3/m, z23.d, #1.0
//CHECK: fminnm  z23.d, p3/m, z23.d, #1.0
whilelo p0.d, w0, w0
//CHECK: whilelo p0.d, w0, w0
fabs    z21.h, p5/m, z10.h
//CHECK: fabs    z21.h, p5/m, z10.h
lsr     z0.h, z0.h, z0.d
//CHECK: lsr     z0.h, z0.h, z0.d
fdivr   z23.s, p3/m, z23.s, z13.s
//CHECK: fdivr   z23.s, p3/m, z23.s, z13.s
fcvt    z21.s, p5/m, z10.h
//CHECK: fcvt    z21.s, p5/m, z10.h
cmpeq   p7.d, p3/z, z13.d, #8
//CHECK: cmpeq   p7.d, p3/z, z13.d, #8
str     z21, [x10, #173, mul vl]
//CHECK: str     z21, [x10, #173, mul vl]
uqsub   z23.d, z13.d, z8.d
//CHECK: uqsub   z23.d, z13.d, z8.d
ldff1sh {z31.d}, p7/z, [z31.d, #62]
//CHECK: ldff1sh {z31.d}, p7/z, [z31.d, #62]
st1w    {z0.s}, p0, [x0, z0.s, uxtw #2]
//CHECK: st1w    {z0.s}, p0, [x0, z0.s, uxtw #2]
frintp  z0.s, p0/m, z0.s
//CHECK: frintp  z0.s, p0/m, z0.s
smin    z0.b, p0/m, z0.b, z0.b
//CHECK: smin    z0.b, p0/m, z0.b, z0.b
fcvt    z23.h, p3/m, z13.d
//CHECK: fcvt    z23.h, p3/m, z13.d
sub     z21.s, z10.s, z21.s
//CHECK: sub     z21.s, z10.s, z21.s
mov     z31.h, wsp
//CHECK: mov     z31.h, wsp
cmpge   p5.h, p5/z, z10.h, #-11
//CHECK: cmpge   p5.h, p5/z, z10.h, #-11
revh    z23.d, p3/m, z13.d
//CHECK: revh    z23.d, p3/m, z13.d
fabs    z21.s, p5/m, z10.s
//CHECK: fabs    z21.s, p5/m, z10.s
st1d    {z0.d}, p0, [z0.d]
//CHECK: st1d    {z0.d}, p0, [z0.d]
ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl]
//CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl]
uzp1    z0.s, z0.s, z0.s
//CHECK: uzp1    z0.s, z0.s, z0.s
lasta   w23, p3, z13.s
//CHECK: lasta   w23, p3, z13.s
sminv   s21, p5, z10.s
//CHECK: sminv   s21, p5, z10.s
mov     z31.d, p7/m, d31
//CHECK: mov     z31.d, p7/m, d31
umax    z31.d, p7/m, z31.d, z31.d
//CHECK: umax    z31.d, p7/m, z31.d, z31.d
fcadd   z23.h, p3/m, z23.h, z13.h, #90
//CHECK: fcadd   z23.h, p3/m, z23.h, z13.h, #90
st2b    {z21.b, z22.b}, p5, [x10, #10, mul vl]
//CHECK: st2b    {z21.b, z22.b}, p5, [x10, #10, mul vl]
st1w    {z23.s}, p3, [x13, x8, lsl #2]
//CHECK: st1w    {z23.s}, p3, [x13, x8, lsl #2]
uunpklo z0.h, z0.b
//CHECK: uunpklo z0.h, z0.b
ldff1h  {z0.s}, p0/z, [x0, z0.s, sxtw #1]
//CHECK: ldff1h  {z0.s}, p0/z, [x0, z0.s, sxtw #1]
umin    z31.b, z31.b, #255
//CHECK: umin    z31.b, z31.b, #255
uqadd   z31.h, z31.h, #255, lsl #8
//CHECK: uqadd   z31.h, z31.h, #65280
asrd    z21.h, p5/m, z21.h, #6
//CHECK: asrd    z21.h, p5/m, z21.h, #6
uqdecp  xzr, p15.d
//CHECK: uqdecp  xzr, p15.d
lastb   w23, p3, z13.h
//CHECK: lastb   w23, p3, z13.h
sqincp  x0, p0.s, w0
//CHECK: sqincp  x0, p0.s, w0
ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw #1]
//CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, sxtw #1]
fmov    z23.h, p8/m, #0.90625
//CHECK: fmov    z23.h, p8/m, #0.90625
ld1sb   {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1sb   {z31.s}, p7/z, [sp, #-1, mul vl]
cmpge   p15.b, p7/z, z31.b, z31.d
//CHECK: cmpge   p15.b, p7/z, z31.b, z31.d
prfh    pldl1keep, p0, [x0]
//CHECK: prfh    pldl1keep, p0, [x0]
add     z21.s, z21.s, #170
//CHECK: add     z21.s, z21.s, #170
ld1sb   {z0.s}, p0/z, [z0.s]
//CHECK: ld1sb   {z0.s}, p0/z, [z0.s]
tbl     z0.h, {z0.h}, z0.h
//CHECK: tbl     z0.h, {z0.h}, z0.h
cmpge   p0.h, p0/z, z0.h, #0
//CHECK: cmpge   p0.h, p0/z, z0.h, #0
ucvtf   z23.h, p3/m, z13.d
//CHECK: ucvtf   z23.h, p3/m, z13.d
cmpne   p15.s, p7/z, z31.s, z31.d
//CHECK: cmpne   p15.s, p7/z, z31.s, z31.d
cmpgt   p7.b, p3/z, z13.b, z8.d
//CHECK: cmpgt   p7.b, p3/z, z13.b, z8.d
cmple   p15.s, p7/z, z31.s, #-1
//CHECK: cmple   p15.s, p7/z, z31.s, #-1
clastb  z23.h, p3, z23.h, z13.h
//CHECK: clastb  z23.h, p3, z23.h, z13.h
lsr     z21.d, p5/m, z21.d, #22
//CHECK: lsr     z21.d, p5/m, z21.d, #22
fmul    z0.s, p0/m, z0.s, #0.5
//CHECK: fmul    z0.s, p0/m, z0.s, #0.5
ldff1w  {z0.d}, p0/z, [x0, z0.d]
//CHECK: ldff1w  {z0.d}, p0/z, [x0, z0.d]
subr    z31.h, z31.h, #255, lsl #8
//CHECK: subr    z31.h, z31.h, #65280
ldff1b  {z21.h}, p5/z, [x10, x21]
//CHECK: ldff1b  {z21.h}, p5/z, [x10, x21]
cmpls   p0.b, p0/z, z0.b, #0
//CHECK: cmpls   p0.b, p0/z, z0.b, #0
rev     p7.d, p13.d
//CHECK: rev     p7.d, p13.d
lslr    z0.b, p0/m, z0.b, z0.b
//CHECK: lslr    z0.b, p0/m, z0.b, z0.b
uunpklo z23.s, z13.h
//CHECK: uunpklo z23.s, z13.h
sqadd   z23.d, z13.d, z8.d
//CHECK: sqadd   z23.d, z13.d, z8.d
pfirst  p7.b, p13, p7.b
//CHECK: pfirst  p7.b, p13, p7.b
frsqrts z23.h, z13.h, z8.h
//CHECK: frsqrts z23.h, z13.h, z8.h
lsr     z21.h, z10.h, #11
//CHECK: lsr     z21.h, z10.h, #11
fabs    z0.h, p0/m, z0.h
//CHECK: fabs    z0.h, p0/m, z0.h
uqdecp  w21, p10.b
//CHECK: uqdecp  w21, p10.b
smin    z31.h, z31.h, #-1
//CHECK: smin    z31.h, z31.h, #-1
rbit    z31.b, p7/m, z31.b
//CHECK: rbit    z31.b, p7/m, z31.b
st1h    {z23.s}, p3, [z13.s, #16]
//CHECK: st1h    {z23.s}, p3, [z13.s, #16]
ld1sb   {z23.s}, p3/z, [z13.s, #8]
//CHECK: ld1sb   {z23.s}, p3/z, [z13.s, #8]
msb     z23.h, p3/m, z8.h, z13.h
//CHECK: msb     z23.h, p3/m, z8.h, z13.h
asrr    z31.s, p7/m, z31.s, z31.s
//CHECK: asrr    z31.s, p7/m, z31.s, z31.s
clasta  w0, p0, w0, z0.b
//CHECK: clasta  w0, p0, w0, z0.b
ld1b    {z0.b}, p0/z, [x0, x0]
//CHECK: ld1b    {z0.b}, p0/z, [x0, x0]
ld1sh   {z21.d}, p5/z, [x10, x21, lsl #1]
//CHECK: ld1sh   {z21.d}, p5/z, [x10, x21, lsl #1]
lsl     z0.h, z0.h, z0.d
//CHECK: lsl     z0.h, z0.h, z0.d
lsr     z0.d, z0.d, #64
//CHECK: lsr     z0.d, z0.d, #64
eors    p7.b, p11/z, p13.b, p8.b
//CHECK: eors    p7.b, p11/z, p13.b, p8.b
st1h    {z23.d}, p3, [x13, z8.d, uxtw #1]
//CHECK: st1h    {z23.d}, p3, [x13, z8.d, uxtw #1]
index   z23.s, w13, w8
//CHECK: index   z23.s, w13, w8
fsqrt   z21.h, p5/m, z10.h
//CHECK: fsqrt   z21.h, p5/m, z10.h
udot    z0.d, z0.h, z0.h
//CHECK: udot    z0.d, z0.h, z0.h
ldr     z31, [sp, #-1, mul vl]
//CHECK: ldr     z31, [sp, #-1, mul vl]
fmls    z31.h, p7/m, z31.h, z31.h
//CHECK: fmls    z31.h, p7/m, z31.h, z31.h
sqdecw  z31.s, all, mul #16
//CHECK: sqdecw  z31.s, all, mul #16
frinta  z21.s, p5/m, z10.s
//CHECK: frinta  z21.s, p5/m, z10.s
uzp2    p7.h, p13.h, p8.h
//CHECK: uzp2    p7.h, p13.h, p8.h
ld1rqw  {z5.s}, p3/z, [x17, x16, lsl #2]
//CHECK: ld1rqw  {z5.s}, p3/z, [x17, x16, lsl #2]
fadd    z21.s, p5/m, z21.s, #0.5
//CHECK: fadd    z21.s, p5/m, z21.s, #0.5
cmphi   p7.h, p3/z, z13.h, z8.d
//CHECK: cmphi   p7.h, p3/z, z13.h, z8.d
revb    z23.s, p3/m, z13.s
//CHECK: revb    z23.s, p3/m, z13.s
andv    d31, p7, z31.d
//CHECK: andv    d31, p7, z31.d
cmpls   p15.d, p7/z, z31.d, #127
//CHECK: cmpls   p15.d, p7/z, z31.d, #127
fcvtzs  z21.s, p5/m, z10.s
//CHECK: fcvtzs  z21.s, p5/m, z10.s
decd    z0.d, pow2
//CHECK: decd    z0.d, pow2
fcmeq   p15.d, p7/z, z31.d, #0.0
//CHECK: fcmeq   p15.d, p7/z, z31.d, #0.0
fadd    z0.d, z0.d, z0.d
//CHECK: fadd    z0.d, z0.d, z0.d
whilelo p5.h, x10, x21
//CHECK: whilelo p5.h, x10, x21
ptrue   p5.d, vl32
//CHECK: ptrue   p5.d, vl32
addpl   x23, x8, #-19
//CHECK: addpl   x23, x8, #-19
ldff1d  {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ldff1d  {z21.d}, p5/z, [x10, z21.d, uxtw]
punpklo p0.h, p0.b
//CHECK: punpklo p0.h, p0.b
sabd    z31.s, p7/m, z31.s, z31.s
//CHECK: sabd    z31.s, p7/m, z31.s, z31.s
lasta   s21, p5, z10.s
//CHECK: lasta   s21, p5, z10.s
cmpne   p5.b, p5/z, z10.b, z21.d
//CHECK: cmpne   p5.b, p5/z, z10.b, z21.d
lastb   w21, p5, z10.h
//CHECK: lastb   w21, p5, z10.h
fcmuo   p15.d, p7/z, z31.d, z31.d
//CHECK: fcmuo   p15.d, p7/z, z31.d, z31.d
fmulx   z0.h, p0/m, z0.h, z0.h
//CHECK: fmulx   z0.h, p0/m, z0.h, z0.h
bic     z21.d, p5/m, z21.d, z10.d
//CHECK: bic     z21.d, p5/m, z21.d, z10.d
cnot    z0.b, p0/m, z0.b
//CHECK: cnot    z0.b, p0/m, z0.b
fcvt    z31.d, p7/m, z31.h
//CHECK: fcvt    z31.d, p7/m, z31.h
bic     z0.h, p0/m, z0.h, z0.h
//CHECK: bic     z0.h, p0/m, z0.h, z0.h
st1d    {z21.d}, p5, [x10, #5, mul vl]
//CHECK: st1d    {z21.d}, p5, [x10, #5, mul vl]
cmpne   p0.h, p0/z, z0.h, z0.h
//CHECK: cmpne   p0.h, p0/z, z0.h, z0.h
wrffr   p15.b
//CHECK: wrffr   p15.b
stnt1w  {z21.s}, p5, [x10, x21, lsl #2]
//CHECK: stnt1w  {z21.s}, p5, [x10, x21, lsl #2]
ld1sh   {z21.s}, p5/z, [x10, z21.s, sxtw #1]
//CHECK: ld1sh   {z21.s}, p5/z, [x10, z21.s, sxtw #1]
ld3w    {z21.s, z22.s, z23.s}, p5/z, [x10, #15, mul vl]
//CHECK: ld3w    {z21.s, z22.s, z23.s}, p5/z, [x10, #15, mul vl]
ldff1sh {z21.d}, p5/z, [z10.d, #42]
//CHECK: ldff1sh {z21.d}, p5/z, [z10.d, #42]
fmul    z31.d, p7/m, z31.d, z31.d
//CHECK: fmul    z31.d, p7/m, z31.d, z31.d
lsl     z31.b, p7/m, z31.b, z31.b
//CHECK: lsl     z31.b, p7/m, z31.b, z31.b
ld1sw   {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ld1sw   {z0.d}, p0/z, [x0, z0.d, sxtw]
clasta  z21.h, p5, z21.h, z10.h
//CHECK: clasta  z21.h, p5, z21.h, z10.h
mov     p0.b, p0.b
//CHECK: mov     p0.b, p0.b
uaddv   d23, p3, z13.b
//CHECK: uaddv   d23, p3, z13.b
st1h    {z31.d}, p7, [sp, z31.d, uxtw]
//CHECK: st1h    {z31.d}, p7, [sp, z31.d, uxtw]
uqincp  w0, p0.b
//CHECK: uqincp  w0, p0.b
uunpkhi z21.s, z10.h
//CHECK: uunpkhi z21.s, z10.h
ld1sb   {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ld1sb   {z21.s}, p5/z, [x10, #5, mul vl]
add     z0.h, z0.h, #0
//CHECK: add     z0.h, z0.h, #0
ld1sh   {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ld1sh   {z21.s}, p5/z, [x10, #5, mul vl]
sminv   h0, p0, z0.h
//CHECK: sminv   h0, p0, z0.h
frintz  z23.h, p3/m, z13.h
//CHECK: frintz  z23.h, p3/m, z13.h
ld1w    {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ld1w    {z21.s}, p5/z, [x10, #5, mul vl]
uzp1    p5.h, p10.h, p5.h
//CHECK: uzp1    p5.h, p10.h, p5.h
pfalse  p7.b
//CHECK: pfalse  p7.b
uqsub   z21.b, z21.b, #170
//CHECK: uqsub   z21.b, z21.b, #170
fexpa   z23.h, z13.h
//CHECK: fexpa   z23.h, z13.h
sqincp  x23, p13.h, w23
//CHECK: sqincp  x23, p13.h, w23
index   z0.h, w0, w0
//CHECK: index   z0.h, w0, w0
ld1rsw  {z21.d}, p5/z, [x10, #84]
//CHECK: ld1rsw  {z21.d}, p5/z, [x10, #84]
zip2    z23.b, z13.b, z8.b
//CHECK: zip2    z23.b, z13.b, z8.b
zip1    p0.h, p0.h, p0.h
//CHECK: zip1    p0.h, p0.h, p0.h
ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw #1]
//CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw #1]
ld1w    {z31.s}, p7/z, [sp, z31.s, sxtw #2]
//CHECK: ld1w    {z31.s}, p7/z, [sp, z31.s, sxtw #2]
mul     z0.d, p0/m, z0.d, z0.d
//CHECK: mul     z0.d, p0/m, z0.d, z0.d
addpl   sp, sp, #-1
//CHECK: addpl   sp, sp, #-1
cnt     z31.b, p7/m, z31.b
//CHECK: cnt     z31.b, p7/m, z31.b
lsrr    z31.s, p7/m, z31.s, z31.s
//CHECK: lsrr    z31.s, p7/m, z31.s, z31.s
fadd    z31.d, z31.d, z31.d
//CHECK: fadd    z31.d, z31.d, z31.d
clasta  z23.b, p3, z23.b, z13.b
//CHECK: clasta  z23.b, p3, z23.b, z13.b
brkpas  p15.b, p15/z, p15.b, p15.b
//CHECK: brkpas  p15.b, p15/z, p15.b, p15.b
fminv   h23, p3, z13.h
//CHECK: fminv   h23, p3, z13.h
prfh    #7, p3, [x13, z8.d, lsl #1]
//CHECK: prfh    #7, p3, [x13, z8.d, lsl #1]
fcmla   z23.h, p3/m, z13.h, z8.h, #270
//CHECK: fcmla   z23.h, p3/m, z13.h, z8.h, #270
cntp    x23, p11, p13.b
//CHECK: cntp    x23, p11, p13.b
ld1h    {z31.d}, p7/z, [sp, z31.d, uxtw #1]
//CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, uxtw #1]
fmul    z31.d, z31.d, z31.d
//CHECK: fmul    z31.d, z31.d, z31.d
adr     z23.d, [z13.d, z8.d, uxtw #3]
//CHECK: adr     z23.d, [z13.d, z8.d, uxtw #3]
lsl     z23.h, p3/m, z23.h, #13
//CHECK: lsl     z23.h, p3/m, z23.h, #13
asrd    z31.d, p7/m, z31.d, #1
//CHECK: asrd    z31.d, p7/m, z31.d, #1
subr    z5.b, z5.b, #113
//CHECK: subr    z5.b, z5.b, #113
umax    z0.s, z0.s, #0
//CHECK: umax    z0.s, z0.s, #0
ftssel  z0.s, z0.s, z0.s
//CHECK: ftssel  z0.s, z0.s, z0.s
ldnf1b  {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1b  {z31.d}, p7/z, [sp, #-1, mul vl]
st1b    {z21.s}, p5, [x10, z21.s, sxtw]
//CHECK: st1b    {z21.s}, p5, [x10, z21.s, sxtw]
frintm  z23.s, p3/m, z13.s
//CHECK: frintm  z23.s, p3/m, z13.s
sqincp  x21, p10.d, w21
//CHECK: sqincp  x21, p10.d, w21
mla     z23.s, p3/m, z13.s, z8.s
//CHECK: mla     z23.s, p3/m, z13.s, z8.s
st1w    {z31.s}, p7, [sp, z31.s, uxtw]
//CHECK: st1w    {z31.s}, p7, [sp, z31.s, uxtw]
uzp2    p5.h, p10.h, p5.h
//CHECK: uzp2    p5.h, p10.h, p5.h
uqsub   z23.b, z13.b, z8.b
//CHECK: uqsub   z23.b, z13.b, z8.b
index   z23.d, x13, x8
//CHECK: index   z23.d, x13, x8
rev     z23.s, z13.s
//CHECK: rev     z23.s, z13.s
uqincp  x23, p13.s
//CHECK: uqincp  x23, p13.s
fmaxnm  z21.h, p5/m, z21.h, #0.0
//CHECK: fmaxnm  z21.h, p5/m, z21.h, #0.0
udiv    z31.d, p7/m, z31.d, z31.d
//CHECK: udiv    z31.d, p7/m, z31.d, z31.d
st1w    {z23.d}, p3, [x13, z8.d, sxtw]
//CHECK: st1w    {z23.d}, p3, [x13, z8.d, sxtw]
fcmeq   p15.d, p7/z, z31.d, z31.d
//CHECK: fcmeq   p15.d, p7/z, z31.d, z31.d
fcvt    z31.d, p7/m, z31.s
//CHECK: fcvt    z31.d, p7/m, z31.s
st1d    {z23.d}, p3, [x13, z8.d, uxtw]
//CHECK: st1d    {z23.d}, p3, [x13, z8.d, uxtw]
eor     z23.h, p3/m, z23.h, z13.h
//CHECK: eor     z23.h, p3/m, z23.h, z13.h
cmplo   p7.h, p3/z, z13.h, z8.d
//CHECK: cmplo   p7.h, p3/z, z13.h, z8.d
fadda   h23, p3, h23, z13.h
//CHECK: fadda   h23, p3, h23, z13.h
frinta  z31.d, p7/m, z31.d
//CHECK: frinta  z31.d, p7/m, z31.d
cmpge   p15.s, p7/z, z31.s, z31.d
//CHECK: cmpge   p15.s, p7/z, z31.s, z31.d
mov     z23.d, p8/m, #109, lsl #8
//CHECK: mov     z23.d, p8/m, #27904
uqincd  z31.d, all, mul #16
//CHECK: uqincd  z31.d, all, mul #16
ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl]
//CHECK: ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl]
ftsmul  z0.d, z0.d, z0.d
//CHECK: ftsmul  z0.d, z0.d, z0.d
asrr    z31.d, p7/m, z31.d, z31.d
//CHECK: asrr    z31.d, p7/m, z31.d, z31.d
decw    x0, pow2
//CHECK: decw    x0, pow2
punpklo p7.h, p13.b
//CHECK: punpklo p7.h, p13.b
cmplo   p5.h, p5/z, z10.h, z21.d
//CHECK: cmplo   p5.h, p5/z, z10.h, z21.d
ptrue   p5.s, vl32
//CHECK: ptrue   p5.s, vl32
prfh    pldl3strm, p5, [x10, x21, lsl #1]
//CHECK: prfh    pldl3strm, p5, [x10, x21, lsl #1]
ptrue   p5.b, vl32
//CHECK: ptrue   p5.b, vl32
prfh    pldl3strm, p5, [x10, z21.d, sxtw #1]
//CHECK: prfh    pldl3strm, p5, [x10, z21.d, sxtw #1]
zip2    z21.s, z10.s, z21.s
//CHECK: zip2    z21.s, z10.s, z21.s
sqsub   z0.h, z0.h, #0
//CHECK: sqsub   z0.h, z0.h, #0
asrd    z23.b, p3/m, z23.b, #3
//CHECK: asrd    z23.b, p3/m, z23.b, #3
prfh    #15, p7, [sp, z31.d, lsl #1]
//CHECK: prfh    #15, p7, [sp, z31.d, lsl #1]
ld1sh   {z21.s}, p5/z, [x10, z21.s, sxtw]
//CHECK: ld1sh   {z21.s}, p5/z, [x10, z21.s, sxtw]
mov     p15.b, p15/z, p15.b
//CHECK: mov     p15.b, p15/z, p15.b
ld1h    {z31.s}, p7/z, [sp, z31.s, sxtw #1]
//CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, sxtw #1]
sdiv    z23.s, p3/m, z23.s, z13.s
//CHECK: sdiv    z23.s, p3/m, z23.s, z13.s
umaxv   s23, p3, z13.s
//CHECK: umaxv   s23, p3, z13.s
fcmeq   p0.d, p0/z, z0.d, #0.0
//CHECK: fcmeq   p0.d, p0/z, z0.d, #0.0
frintp  z0.d, p0/m, z0.d
//CHECK: frintp  z0.d, p0/m, z0.d
ldnt1d  {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ldnt1d  {z21.d}, p5/z, [x10, #5, mul vl]
prfh    pldl3strm, p3, [x17, x16, lsl #1]
//CHECK: prfh    pldl3strm, p3, [x17, x16, lsl #1]
sqincb  x21, vl32, mul #6
//CHECK: sqincb  x21, vl32, mul #6
neg     z0.s, p0/m, z0.s
//CHECK: neg     z0.s, p0/m, z0.s
cmpls   p0.s, p0/z, z0.s, z0.d
//CHECK: cmpls   p0.s, p0/z, z0.s, z0.d
ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw]
lsr     z21.b, p5/m, z21.b, z10.b
//CHECK: lsr     z21.b, p5/m, z21.b, z10.b
mls     z0.h, p0/m, z0.h, z0.h
//CHECK: mls     z0.h, p0/m, z0.h, z0.h
rdffr   p7.b, p13/z
//CHECK: rdffr   p7.b, p13/z
cnot    z0.h, p0/m, z0.h
//CHECK: cnot    z0.h, p0/m, z0.h
umulh   z21.d, p5/m, z21.d, z10.d
//CHECK: umulh   z21.d, p5/m, z21.d, z10.d
fmaxnm  z21.s, p5/m, z21.s, #0.0
//CHECK: fmaxnm  z21.s, p5/m, z21.s, #0.0
sdivr   z21.d, p5/m, z21.d, z10.d
//CHECK: sdivr   z21.d, p5/m, z21.d, z10.d
sqsub   z21.d, z10.d, z21.d
//CHECK: sqsub   z21.d, z10.d, z21.d
fexpa   z0.h, z0.h
//CHECK: fexpa   z0.h, z0.h
fcvtzu  z21.d, p5/m, z10.h
//CHECK: fcvtzu  z21.d, p5/m, z10.h
lsl     z21.s, p5/m, z21.s, z10.s
//CHECK: lsl     z21.s, p5/m, z21.s, z10.s
prfh    pldl3strm, p5, [x10, z21.d, lsl #1]
//CHECK: prfh    pldl3strm, p5, [x10, z21.d, lsl #1]
uqincp  z23.s, p13
//CHECK: uqincp  z23.s, p13
add     z31.h, z31.h, #255, lsl #8
//CHECK: add     z31.h, z31.h, #65280
lasta   h0, p0, z0.h
//CHECK: lasta   h0, p0, z0.h
sel     p7.b, p11, p13.b, p8.b
//CHECK: sel     p7.b, p11, p13.b, p8.b
fmax    z0.h, p0/m, z0.h, z0.h
//CHECK: fmax    z0.h, p0/m, z0.h, z0.h
abs     z21.s, p5/m, z10.s
//CHECK: abs     z21.s, p5/m, z10.s
rdffr   p15.b
//CHECK: rdffr   p15.b
tbl     z0.d, {z0.d}, z0.d
//CHECK: tbl     z0.d, {z0.d}, z0.d
fmax    z21.h, p5/m, z21.h, z10.h
//CHECK: fmax    z21.h, p5/m, z21.h, z10.h
ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw #1]
//CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw #1]
incp    z21.s, p10
//CHECK: incp    z21.s, p10
clz     z23.s, p3/m, z13.s
//CHECK: clz     z23.s, p3/m, z13.s
ld1sh   {z21.s}, p5/z, [z10.s, #42]
//CHECK: ld1sh   {z21.s}, p5/z, [z10.s, #42]
cmplo   p7.b, p3/z, z13.b, #35
//CHECK: cmplo   p7.b, p3/z, z13.b, #35
umax    z0.s, p0/m, z0.s, z0.s
//CHECK: umax    z0.s, p0/m, z0.s, z0.s
fsub    z31.s, z31.s, z31.s
//CHECK: fsub    z31.s, z31.s, z31.s
subr    z21.d, p5/m, z21.d, z10.d
//CHECK: subr    z21.d, p5/m, z21.d, z10.d
clasta  wzr, p7, wzr, z31.s
//CHECK: clasta  wzr, p7, wzr, z31.s
sub     z0.b, z0.b, #0
//CHECK: sub     z0.b, z0.b, #0
prfw    pldl3strm, p3, [x17, x16, lsl #2]
//CHECK: prfw    pldl3strm, p3, [x17, x16, lsl #2]
ld1rsb  {z23.d}, p3/z, [x13, #8]
//CHECK: ld1rsb  {z23.d}, p3/z, [x13, #8]
smaxv   h0, p0, z0.h
//CHECK: smaxv   h0, p0, z0.h
fcmla   z31.d, p7/m, z31.d, z31.d, #270
//CHECK: fcmla   z31.d, p7/m, z31.d, z31.d, #270
mov     z21.s, p5/m, z10.s
//CHECK: mov     z21.s, p5/m, z10.s
fminnm  z23.d, p3/m, z23.d, z13.d
//CHECK: fminnm  z23.d, p3/m, z23.d, z13.d
uqincw  xzr, all, mul #16
//CHECK: uqincw  xzr, all, mul #16
ldff1w  {z0.s}, p0/z, [x0, x0, lsl #2]
//CHECK: ldff1w  {z0.s}, p0/z, [x0, x0, lsl #2]
lastb   s21, p5, z10.s
//CHECK: lastb   s21, p5, z10.s
sabd    z0.h, p0/m, z0.h, z0.h
//CHECK: sabd    z0.h, p0/m, z0.h, z0.h
cls     z21.s, p5/m, z10.s
//CHECK: cls     z21.s, p5/m, z10.s
insr    z23.d, d13
//CHECK: insr    z23.d, d13
trn1    z23.d, z13.d, z8.d
//CHECK: trn1    z23.d, z13.d, z8.d
pnext   p0.b, p0, p0.b
//CHECK: pnext   p0.b, p0, p0.b
fcmlt   p15.h, p7/z, z31.h, #0.0
//CHECK: fcmlt   p15.h, p7/z, z31.h, #0.0
subr    z21.d, z21.d, #170
//CHECK: subr    z21.d, z21.d, #170
ld1b    {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ld1b    {z0.d}, p0/z, [x0, z0.d, uxtw]
mov     z0.s, #0
//CHECK: mov     z0.s, #0
subr    z0.h, z0.h, #0
//CHECK: subr    z0.h, z0.h, #0
st1h    {z23.h}, p3, [x13, #-8, mul vl]
//CHECK: st1h    {z23.h}, p3, [x13, #-8, mul vl]
whilelt p15.b, wzr, wzr
//CHECK: whilelt p15.b, wzr, wzr
mul     z31.b, z31.b, #-1
//CHECK: mul     z31.b, z31.b, #-1
ldnf1b  {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1b  {z23.d}, p3/z, [x13, #-8, mul vl]
eorv    d0, p0, z0.d
//CHECK: eorv    d0, p0, z0.d
whilele p5.d, x10, x21
//CHECK: whilele p5.d, x10, x21
rdffrs  p7.b, p13/z
//CHECK: rdffrs  p7.b, p13/z
mul     z31.b, p7/m, z31.b, z31.b
//CHECK: mul     z31.b, p7/m, z31.b, z31.b
ld1w    {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ld1w    {z21.d}, p5/z, [x10, #5, mul vl]
ld1sw   {z0.d}, p0/z, [x0, z0.d, sxtw #2]
//CHECK: ld1sw   {z0.d}, p0/z, [x0, z0.d, sxtw #2]
fdiv    z21.h, p5/m, z21.h, z10.h
//CHECK: fdiv    z21.h, p5/m, z21.h, z10.h
brkb    p7.b, p11/m, p13.b
//CHECK: brkb    p7.b, p11/m, p13.b
smulh   z0.b, p0/m, z0.b, z0.b
//CHECK: smulh   z0.b, p0/m, z0.b, z0.b
fsub    z0.h, z0.h, z0.h
//CHECK: fsub    z0.h, z0.h, z0.h
ctermne x13, x8
//CHECK: ctermne x13, x8
fmul    z31.s, z31.s, z31.s
//CHECK: fmul    z31.s, z31.s, z31.s
ctermne wzr, wzr
//CHECK: ctermne wzr, wzr
zip1    z0.h, z0.h, z0.h
//CHECK: zip1    z0.h, z0.h, z0.h
st4w    {z5.s, z6.s, z7.s, z8.s}, p3, [x17, x16, lsl #2]
//CHECK: st4w    {z5.s, z6.s, z7.s, z8.s}, p3, [x17, x16, lsl #2]
incb    xzr, all, mul #16
//CHECK: incb    xzr, all, mul #16
st1d    {z0.d}, p0, [x0, z0.d, uxtw]
//CHECK: st1d    {z0.d}, p0, [x0, z0.d, uxtw]
ldff1h  {z23.s}, p3/z, [x13, z8.s, sxtw #1]
//CHECK: ldff1h  {z23.s}, p3/z, [x13, z8.s, sxtw #1]
fmin    z0.h, p0/m, z0.h, z0.h
//CHECK: fmin    z0.h, p0/m, z0.h, z0.h
frintz  z23.s, p3/m, z13.s
//CHECK: frintz  z23.s, p3/m, z13.s
st1b    {z0.d}, p0, [x0, z0.d]
//CHECK: st1b    {z0.d}, p0, [x0, z0.d]
asrr    z21.d, p5/m, z21.d, z10.d
//CHECK: asrr    z21.d, p5/m, z21.d, z10.d
asr     z23.h, p3/m, z23.h, z13.d
//CHECK: asr     z23.h, p3/m, z23.h, z13.d
fadda   d0, p0, d0, z0.d
//CHECK: fadda   d0, p0, d0, z0.d
movprfx z21.d, p5/m, z10.d
//CHECK: movprfx z21.d, p5/m, z10.d
add     z21.d, p5/m, z21.d, z22.d
//CHECK: add z21.d, p5/m, z21.d, z22.d
udot    z0.s, z0.b, z0.b
//CHECK: udot    z0.s, z0.b, z0.b
st1w    {z0.d}, p0, [x0, z0.d, uxtw #2]
//CHECK: st1w    {z0.d}, p0, [x0, z0.d, uxtw #2]
ld3d    {z31.d, z0.d, z1.d}, p7/z, [sp, #-3, mul vl]
//CHECK: ld3d    {z31.d, z0.d, z1.d}, p7/z, [sp, #-3, mul vl]
uqinch  w21, vl32, mul #6
//CHECK: uqinch  w21, vl32, mul #6
lastb   h21, p5, z10.h
//CHECK: lastb   h21, p5, z10.h
prfh    pldl3strm, p5, [x10, z21.s, uxtw #1]
//CHECK: prfh    pldl3strm, p5, [x10, z21.s, uxtw #1]
sqdecp  x21, p10.h, w21
//CHECK: sqdecp  x21, p10.h, w21
sxth    z0.d, p0/m, z0.d
//CHECK: sxth    z0.d, p0/m, z0.d
st1b    {z31.s}, p7, [z31.s, #31]
//CHECK: st1b    {z31.s}, p7, [z31.s, #31]
whilels p0.h, x0, x0
//CHECK: whilels p0.h, x0, x0
and     p5.b, p5/z, p10.b, p5.b
//CHECK: and     p5.b, p5/z, p10.b, p5.b
uaddv   d21, p5, z10.s
//CHECK: uaddv   d21, p5, z10.s
umulh   z23.b, p3/m, z23.b, z13.b
//CHECK: umulh   z23.b, p3/m, z23.b, z13.b
ldff1w  {z31.s}, p7/z, [sp, z31.s, uxtw #2]
//CHECK: ldff1w  {z31.s}, p7/z, [sp, z31.s, uxtw #2]
ldnf1sb {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1sb {z21.d}, p5/z, [x10, #5, mul vl]
fcmne   p7.h, p3/z, z13.h, #0.0
//CHECK: fcmne   p7.h, p3/z, z13.h, #0.0
prfh    pldl1keep, p0, [x0, x0, lsl #1]
//CHECK: prfh    pldl1keep, p0, [x0, x0, lsl #1]
uaddv   d21, p5, z10.d
//CHECK: uaddv   d21, p5, z10.d
ldff1d  {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ldff1d  {z0.d}, p0/z, [x0, z0.d, sxtw]
trn2    z31.s, z31.s, z31.s
//CHECK: trn2    z31.s, z31.s, z31.s
st1b    {z23.d}, p3, [x13, z8.d]
//CHECK: st1b    {z23.d}, p3, [x13, z8.d]
uqdecp  z23.d, p13
//CHECK: uqdecp  z23.d, p13
ldff1w  {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ldff1w  {z31.d}, p7/z, [sp, z31.d, uxtw]
fadda   h0, p0, h0, z0.h
//CHECK: fadda   h0, p0, h0, z0.h
whilele p7.s, x13, x8
//CHECK: whilele p7.s, x13, x8
orn     p15.b, p15/z, p15.b, p15.b
//CHECK: orn     p15.b, p15/z, p15.b, p15.b
fneg    z0.d, p0/m, z0.d
//CHECK: fneg    z0.d, p0/m, z0.d
punpkhi p5.h, p10.b
//CHECK: punpkhi p5.h, p10.b
ldff1sh {z23.d}, p3/z, [x13, x8, lsl #1]
//CHECK: ldff1sh {z23.d}, p3/z, [x13, x8, lsl #1]
fnmls   z23.s, p3/m, z13.s, z8.s
//CHECK: fnmls   z23.s, p3/m, z13.s, z8.s
lsl     z31.d, z31.d, #63
//CHECK: lsl     z31.d, z31.d, #63
whilelo p5.s, w10, w21
//CHECK: whilelo p5.s, w10, w21
ld1d    {z0.d}, p0/z, [x0]
//CHECK: ld1d    {z0.d}, p0/z, [x0]
fminv   d0, p0, z0.d
//CHECK: fminv   d0, p0, z0.d
umax    z31.h, p7/m, z31.h, z31.h
//CHECK: umax    z31.h, p7/m, z31.h, z31.h
cmple   p0.s, p0/z, z0.s, #0
//CHECK: cmple   p0.s, p0/z, z0.s, #0
adr     z21.d, [z10.d, z21.d, sxtw #3]
//CHECK: adr     z21.d, [z10.d, z21.d, sxtw #3]
cmpeq   p15.h, p7/z, z31.h, z31.d
//CHECK: cmpeq   p15.h, p7/z, z31.h, z31.d
sqdecd  x23, w23, vl256, mul #9
//CHECK: sqdecd  x23, w23, vl256, mul #9
incw    z0.s, pow2
//CHECK: incw    z0.s, pow2
ldnf1sw {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1sw {z23.d}, p3/z, [x13, #-8, mul vl]
ptrue   p15.h
//CHECK: ptrue   p15.h
sqdecd  x21, vl32, mul #6
//CHECK: sqdecd  x21, vl32, mul #6
ldff1sb {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ldff1sb {z31.d}, p7/z, [sp, z31.d, sxtw]
st1b    {z21.b}, p5, [x10, x21]
//CHECK: st1b    {z21.b}, p5, [x10, x21]
cmpeq   p15.h, p7/z, z31.h, #-1
//CHECK: cmpeq   p15.h, p7/z, z31.h, #-1
st2h    {z21.h, z22.h}, p5, [x10, #10, mul vl]
//CHECK: st2h    {z21.h, z22.h}, p5, [x10, #10, mul vl]
cmplt   p5.b, p5/z, z10.b, z21.d
//CHECK: cmplt   p5.b, p5/z, z10.b, z21.d
st1w    {z0.s}, p0, [x0, z0.s, sxtw]
//CHECK: st1w    {z0.s}, p0, [x0, z0.s, sxtw]
index   z23.d, #13, x8
//CHECK: index   z23.d, #13, x8
st1w    {z21.d}, p5, [x10, z21.d, sxtw #2]
//CHECK: st1w    {z21.d}, p5, [x10, z21.d, sxtw #2]
add     z0.h, p0/m, z0.h, z0.h
//CHECK: add     z0.h, p0/m, z0.h, z0.h
sdot    z23.d, z13.h, z8.h[0]
//CHECK: sdot    z23.d, z13.h, z8.h[0]
umin    z0.h, p0/m, z0.h, z0.h
//CHECK: umin    z0.h, p0/m, z0.h, z0.h
fsub    z31.h, p7/m, z31.h, #1.0
//CHECK: fsub    z31.h, p7/m, z31.h, #1.0
revh    z0.s, p0/m, z0.s
//CHECK: revh    z0.s, p0/m, z0.s
frsqrte z23.d, z13.d
//CHECK: frsqrte z23.d, z13.d
ptrue   p15.s
//CHECK: ptrue   p15.s
fmsb    z21.h, p5/m, z10.h, z21.h
//CHECK: fmsb    z21.h, p5/m, z10.h, z21.h
mov     z31.d, p15/z, #-1, lsl #8
//CHECK: mov     z31.d, p15/z, #-256
uqsub   z0.d, z0.d, #0
//CHECK: uqsub   z0.d, z0.d, #0
cmpeq   p15.s, p7/z, z31.s, #-1
//CHECK: cmpeq   p15.s, p7/z, z31.s, #-1
asrd    z21.d, p5/m, z21.d, #22
//CHECK: asrd    z21.d, p5/m, z21.d, #22
mul     z0.h, z0.h, #0
//CHECK: mul     z0.h, z0.h, #0
abs     z23.b, p3/m, z13.b
//CHECK: abs     z23.b, p3/m, z13.b
st2b    {z0.b, z1.b}, p0, [x0, x0]
//CHECK: st2b    {z0.b, z1.b}, p0, [x0, x0]
cntp    x21, p5, p10.b
//CHECK: cntp    x21, p5, p10.b
whilelt p15.d, wzr, wzr
//CHECK: whilelt p15.d, wzr, wzr
fabd    z21.h, p5/m, z21.h, z10.h
//CHECK: fabd    z21.h, p5/m, z21.h, z10.h
orr     z23.h, p3/m, z23.h, z13.h
//CHECK: orr     z23.h, p3/m, z23.h, z13.h
uqdecp  w21, p10.d
//CHECK: uqdecp  w21, p10.d
ldff1w  {z31.d}, p7/z, [sp, z31.d, sxtw #2]
//CHECK: ldff1w  {z31.d}, p7/z, [sp, z31.d, sxtw #2]
udiv    z0.s, p0/m, z0.s, z0.s
//CHECK: udiv    z0.s, p0/m, z0.s, z0.s
asr     z0.b, p0/m, z0.b, z0.d
//CHECK: asr     z0.b, p0/m, z0.b, z0.d
movprfx z31.d, p7/m, z31.d
//CHECK: movprfx z31.d, p7/m, z31.d
add     z31.d, p7/m, z31.d, z0.d
//CHECK: add z31.d, p7/m, z31.d, z0.d
smaxv   b23, p3, z13.b
//CHECK: smaxv   b23, p3, z13.b
ldff1sw {z21.d}, p5/z, [x10, z21.d, lsl #2]
//CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, lsl #2]
ldnf1b  {z21.h}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1b  {z21.h}, p5/z, [x10, #5, mul vl]
sub     z21.s, p5/m, z21.s, z10.s
//CHECK: sub     z21.s, p5/m, z21.s, z10.s
clastb  z23.b, p3, z23.b, z13.b
//CHECK: clastb  z23.b, p3, z23.b, z13.b
fminnm  z0.d, p0/m, z0.d, #0.0
//CHECK: fminnm  z0.d, p0/m, z0.d, #0.0
umax    z23.d, p3/m, z23.d, z13.d
//CHECK: umax    z23.d, p3/m, z23.d, z13.d
eor     z21.h, p5/m, z21.h, z10.h
//CHECK: eor     z21.h, p5/m, z21.h, z10.h
ld1sb   {z0.s}, p0/z, [x0]
//CHECK: ld1sb   {z0.s}, p0/z, [x0]
sqsub   z31.b, z31.b, z31.b
//CHECK: sqsub   z31.b, z31.b, z31.b
ldff1h  {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ldff1h  {z23.d}, p3/z, [x13, z8.d, uxtw]
sabd    z21.s, p5/m, z21.s, z10.s
//CHECK: sabd    z21.s, p5/m, z21.s, z10.s
orv     h0, p0, z0.h
//CHECK: orv     h0, p0, z0.h
mul     z21.h, z21.h, #-86
//CHECK: mul     z21.h, z21.h, #-86
ld1b    {z0.s}, p0/z, [x0, z0.s, sxtw]
//CHECK: ld1b    {z0.s}, p0/z, [x0, z0.s, sxtw]
fcmne   p5.s, p5/z, z10.s, #0.0
//CHECK: fcmne   p5.s, p5/z, z10.s, #0.0
uaddv   d31, p7, z31.b
//CHECK: uaddv   d31, p7, z31.b
ldff1b  {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ldff1b  {z21.d}, p5/z, [x10, z21.d, sxtw]
fcmge   p15.s, p7/z, z31.s, #0.0
//CHECK: fcmge   p15.s, p7/z, z31.s, #0.0
index   z23.h, w13, w8
//CHECK: index   z23.h, w13, w8
uxth    z23.d, p3/m, z13.d
//CHECK: uxth    z23.d, p3/m, z13.d
sqdech  x23, w23, vl256, mul #9
//CHECK: sqdech  x23, w23, vl256, mul #9
ctermeq w13, w8
//CHECK: ctermeq w13, w8
fmsb    z31.d, p7/m, z31.d, z31.d
//CHECK: fmsb    z31.d, p7/m, z31.d, z31.d
ld1b    {z0.h}, p0/z, [x0, x0]
//CHECK: ld1b    {z0.h}, p0/z, [x0, x0]
cmphs   p15.b, p7/z, z31.b, z31.d
//CHECK: cmphs   p15.b, p7/z, z31.b, z31.d
sqadd   z31.b, z31.b, z31.b
//CHECK: sqadd   z31.b, z31.b, z31.b
uqincb  w23, vl256, mul #9
//CHECK: uqincb  w23, vl256, mul #9
scvtf   z31.d, p7/m, z31.d
//CHECK: scvtf   z31.d, p7/m, z31.d
sxtb    z0.s, p0/m, z0.s
//CHECK: sxtb    z0.s, p0/m, z0.s
ld1w    {z0.d}, p0/z, [z0.d]
//CHECK: ld1w    {z0.d}, p0/z, [z0.d]
fmin    z23.d, p3/m, z23.d, z13.d
//CHECK: fmin    z23.d, p3/m, z23.d, z13.d
cnt     z23.s, p3/m, z13.s
//CHECK: cnt     z23.s, p3/m, z13.s
fcmle   p7.d, p3/z, z13.d, #0.0
//CHECK: fcmle   p7.d, p3/z, z13.d, #0.0
orrs    p7.b, p11/z, p13.b, p8.b
//CHECK: orrs    p7.b, p11/z, p13.b, p8.b
trn1    p15.h, p15.h, p15.h
//CHECK: trn1    p15.h, p15.h, p15.h
zip1    z31.s, z31.s, z31.s
//CHECK: zip1    z31.s, z31.s, z31.s
stnt1w  {z5.s}, p3, [x17, x16, lsl #2]
//CHECK: stnt1w  {z5.s}, p3, [x17, x16, lsl #2]
eor     z23.b, p3/m, z23.b, z13.b
//CHECK: eor     z23.b, p3/m, z23.b, z13.b
mov     z21.b, p5/m, #-86
//CHECK: mov     z21.b, p5/m, #-86
st1h    {z21.d}, p5, [x10, x21, lsl #1]
//CHECK: st1h    {z21.d}, p5, [x10, x21, lsl #1]
decp    x23, p13.b
//CHECK: decp    x23, p13.b
pnext   p15.b, p15, p15.b
//CHECK: pnext   p15.b, p15, p15.b
ld1rb   {z0.h}, p0/z, [x0]
//CHECK: ld1rb   {z0.h}, p0/z, [x0]
frintx  z21.d, p5/m, z10.d
//CHECK: frintx  z21.d, p5/m, z10.d
fsubr   z23.s, p3/m, z23.s, z13.s
//CHECK: fsubr   z23.s, p3/m, z23.s, z13.s
ld1w    {z0.s}, p0/z, [x0]
//CHECK: ld1w    {z0.s}, p0/z, [x0]
zip2    z23.s, z13.s, z8.s
//CHECK: zip2    z23.s, z13.s, z8.s
st1b    {z0.s}, p0, [x0]
//CHECK: st1b    {z0.s}, p0, [x0]
sqincp  z23.h, p13
//CHECK: sqincp  z23.h, p13
ldff1sh {z23.d}, p3/z, [x13, z8.d]
//CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d]
fminv   h21, p5, z10.h
//CHECK: fminv   h21, p5, z10.h
ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, #15, mul vl]
//CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, #15, mul vl]
smulh   z21.b, p5/m, z21.b, z10.b
//CHECK: smulh   z21.b, p5/m, z21.b, z10.b
sqincp  z0.s, p0
//CHECK: sqincp  z0.s, p0
bic     p7.b, p11/z, p13.b, p8.b
//CHECK: bic     p7.b, p11/z, p13.b, p8.b
revw    z23.d, p3/m, z13.d
//CHECK: revw    z23.d, p3/m, z13.d
fcmle   p15.d, p7/z, z31.d, #0.0
//CHECK: fcmle   p15.d, p7/z, z31.d, #0.0
ld4h    {z21.h, z22.h, z23.h, z24.h}, p5/z, [x10, x21, lsl #1]
//CHECK: ld4h    {z21.h, z22.h, z23.h, z24.h}, p5/z, [x10, x21, lsl #1]
st1w    {z23.d}, p3, [x13, x8, lsl #2]
//CHECK: st1w    {z23.d}, p3, [x13, x8, lsl #2]
fcmeq   p0.d, p0/z, z0.d, z0.d
//CHECK: fcmeq   p0.d, p0/z, z0.d, z0.d
frintn  z23.d, p3/m, z13.d
//CHECK: frintn  z23.d, p3/m, z13.d
clasta  wzr, p7, wzr, z31.h
//CHECK: clasta  wzr, p7, wzr, z31.h
frintm  z21.h, p5/m, z10.h
//CHECK: frintm  z21.h, p5/m, z10.h
fmls    z0.s, p0/m, z0.s, z0.s
//CHECK: fmls    z0.s, p0/m, z0.s, z0.s
ld1sh   {z0.s}, p0/z, [x0, x0, lsl #1]
//CHECK: ld1sh   {z0.s}, p0/z, [x0, x0, lsl #1]
uzp1    p0.b, p0.b, p0.b
//CHECK: uzp1    p0.b, p0.b, p0.b
subr    z31.d, p7/m, z31.d, z31.d
//CHECK: subr    z31.d, p7/m, z31.d, z31.d
fabs    z23.h, p3/m, z13.h
//CHECK: fabs    z23.h, p3/m, z13.h
ld1sh   {z21.s}, p5/z, [x10, x21, lsl #1]
//CHECK: ld1sh   {z21.s}, p5/z, [x10, x21, lsl #1]
splice  z23.s, p3, z23.s, z13.s
//CHECK: splice  z23.s, p3, z23.s, z13.s
st1w    {z21.d}, p5, [x10, x21, lsl #2]
//CHECK: st1w    {z21.d}, p5, [x10, x21, lsl #2]
ld1d    {z21.d}, p5/z, [x10, z21.d, sxtw #3]
//CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, sxtw #3]
uqinch  xzr, all, mul #16
//CHECK: uqinch  xzr, all, mul #16
ldff1h  {z23.s}, p3/z, [x13, z8.s, uxtw #1]
//CHECK: ldff1h  {z23.s}, p3/z, [x13, z8.s, uxtw #1]
tbl     z23.h, {z13.h}, z8.h
//CHECK: tbl     z23.h, {z13.h}, z8.h
lasta   wzr, p7, z31.b
//CHECK: lasta   wzr, p7, z31.b
splice  z0.d, p0, z0.d, z0.d
//CHECK: splice  z0.d, p0, z0.d, z0.d
clasta  w21, p5, w21, z10.s
//CHECK: clasta  w21, p5, w21, z10.s
asrd    z21.s, p5/m, z21.s, #22
//CHECK: asrd    z21.s, p5/m, z21.s, #22
dech    z31.h, all, mul #16
//CHECK: dech    z31.h, all, mul #16
mls     z23.h, p3/m, z13.h, z8.h
//CHECK: mls     z23.h, p3/m, z13.h, z8.h
rbit    z21.s, p5/m, z10.s
//CHECK: rbit    z21.s, p5/m, z10.s
insr    z31.s, s31
//CHECK: insr    z31.s, s31
st1h    {z5.d}, p3, [x17, x16, lsl #1]
//CHECK: st1h    {z5.d}, p3, [x17, x16, lsl #1]
ldff1sb {z31.s}, p7/z, [sp, z31.s, uxtw]
//CHECK: ldff1sb {z31.s}, p7/z, [sp, z31.s, uxtw]
ld1sh   {z23.d}, p3/z, [z13.d, #16]
//CHECK: ld1sh   {z23.d}, p3/z, [z13.d, #16]
st1h    {z21.d}, p5, [x10, z21.d, sxtw #1]
//CHECK: st1h    {z21.d}, p5, [x10, z21.d, sxtw #1]
st1d    {z0.d}, p0, [x0, x0, lsl #3]
//CHECK: st1d    {z0.d}, p0, [x0, x0, lsl #3]
ldnt1d  {z23.d}, p3/z, [x13, x8, lsl #3]
//CHECK: ldnt1d  {z23.d}, p3/z, [x13, x8, lsl #3]
fnmad   z23.d, p3/m, z13.d, z8.d
//CHECK: fnmad   z23.d, p3/m, z13.d, z8.d
uxtb    z23.d, p3/m, z13.d
//CHECK: uxtb    z23.d, p3/m, z13.d
ldnt1d  {z0.d}, p0/z, [x0, x0, lsl #3]
//CHECK: ldnt1d  {z0.d}, p0/z, [x0, x0, lsl #3]
st2d    {z21.d, z22.d}, p5, [x10, x21, lsl #3]
//CHECK: st2d    {z21.d, z22.d}, p5, [x10, x21, lsl #3]
uabd    z31.s, p7/m, z31.s, z31.s
//CHECK: uabd    z31.s, p7/m, z31.s, z31.s
ld1w    {z0.d}, p0/z, [x0, z0.d]
//CHECK: ld1w    {z0.d}, p0/z, [x0, z0.d]
smax    z0.s, z0.s, #0
//CHECK: smax    z0.s, z0.s, #0
uqincd  wzr, all, mul #16
//CHECK: uqincd  wzr, all, mul #16
frintn  z31.s, p7/m, z31.s
//CHECK: frintn  z31.s, p7/m, z31.s
cmpls   p15.s, p7/z, z31.s, #127
//CHECK: cmpls   p15.s, p7/z, z31.s, #127
fcmne   p15.s, p7/z, z31.s, #0.0
//CHECK: fcmne   p15.s, p7/z, z31.s, #0.0
cls     z31.h, p7/m, z31.h
//CHECK: cls     z31.h, p7/m, z31.h
eor     z21.d, z10.d, z21.d
//CHECK: eor     z21.d, z10.d, z21.d
st1d    {z23.d}, p3, [x13, z8.d, uxtw #3]
//CHECK: st1d    {z23.d}, p3, [x13, z8.d, uxtw #3]
fdiv    z31.h, p7/m, z31.h, z31.h
//CHECK: fdiv    z31.h, p7/m, z31.h, z31.h
umin    z0.s, z0.s, #0
//CHECK: umin    z0.s, z0.s, #0
lsr     z21.h, z10.h, z21.d
//CHECK: lsr     z21.h, z10.h, z21.d
frintm  z0.h, p0/m, z0.h
//CHECK: frintm  z0.h, p0/m, z0.h
bic     z0.d, p0/m, z0.d, z0.d
//CHECK: bic     z0.d, p0/m, z0.d, z0.d
incp    x23, p13.s
//CHECK: incp    x23, p13.s
clastb  xzr, p7, xzr, z31.d
//CHECK: clastb  xzr, p7, xzr, z31.d
uqincw  z21.s, vl32, mul #6
//CHECK: uqincw  z21.s, vl32, mul #6
fabd    z31.h, p7/m, z31.h, z31.h
//CHECK: fabd    z31.h, p7/m, z31.h, z31.h
ld1sh   {z21.d}, p5/z, [z10.d, #42]
//CHECK: ld1sh   {z21.d}, p5/z, [z10.d, #42]
ld1h    {z31.d}, p7/z, [sp, z31.d, lsl #1]
//CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, lsl #1]
whilele p0.h, w0, w0
//CHECK: whilele p0.h, w0, w0
sqsub   z31.h, z31.h, #255, lsl #8
//CHECK: sqsub   z31.h, z31.h, #65280
clasta  w23, p3, w23, z13.b
//CHECK: clasta  w23, p3, w23, z13.b
umin    z23.d, z23.d, #109
//CHECK: umin    z23.d, z23.d, #109
ldff1w  {z0.s}, p0/z, [x0, z0.s, uxtw]
//CHECK: ldff1w  {z0.s}, p0/z, [x0, z0.s, uxtw]
fmin    z21.d, p5/m, z21.d, #0.0
//CHECK: fmin    z21.d, p5/m, z21.d, #0.0
uabd    z31.b, p7/m, z31.b, z31.b
//CHECK: uabd    z31.b, p7/m, z31.b, z31.b
stnt1w  {z31.s}, p7, [sp, #-1, mul vl]
//CHECK: stnt1w  {z31.s}, p7, [sp, #-1, mul vl]
fmul    z21.h, p5/m, z21.h, #0.5
//CHECK: fmul    z21.h, p5/m, z21.h, #0.5
uqsub   z1.b, z1.b, #33
//CHECK: uqsub   z1.b, z1.b, #33
ld1w    {z31.d}, p7/z, [sp, z31.d, sxtw #2]
//CHECK: ld1w    {z31.d}, p7/z, [sp, z31.d, sxtw #2]
cmpgt   p15.b, p7/z, z31.b, #-1
//CHECK: cmpgt   p15.b, p7/z, z31.b, #-1
zip2    p15.b, p15.b, p15.b
//CHECK: zip2    p15.b, p15.b, p15.b
ldff1b  {z21.s}, p5/z, [x10, z21.s, uxtw]
//CHECK: ldff1b  {z21.s}, p5/z, [x10, z21.s, uxtw]
umulh   z0.s, p0/m, z0.s, z0.s
//CHECK: umulh   z0.s, p0/m, z0.s, z0.s
uqincp  wzr, p15.h
//CHECK: uqincp  wzr, p15.h
cmple   p7.h, p3/z, z13.h, #8
//CHECK: cmple   p7.h, p3/z, z13.h, #8
prfd    #7, p3, [x13, #8, mul vl]
//CHECK: prfd    #7, p3, [x13, #8, mul vl]
uqsub   z31.b, z31.b, z31.b
//CHECK: uqsub   z31.b, z31.b, z31.b
sqincd  z0.d, pow2
//CHECK: sqincd  z0.d, pow2
sminv   d23, p3, z13.d
//CHECK: sminv   d23, p3, z13.d
umin    z31.s, p7/m, z31.s, z31.s
//CHECK: umin    z31.s, p7/m, z31.s, z31.s
st3b    {z5.b, z6.b, z7.b}, p3, [x17, x16]
//CHECK: st3b    {z5.b, z6.b, z7.b}, p3, [x17, x16]
ldff1sb {z23.d}, p3/z, [z13.d, #8]
//CHECK: ldff1sb {z23.d}, p3/z, [z13.d, #8]
brka    p5.b, p5/z, p10.b
//CHECK: brka    p5.b, p5/z, p10.b
ftsmul  z23.h, z13.h, z8.h
//CHECK: ftsmul  z23.h, z13.h, z8.h
st1w    {z0.s}, p0, [z0.s]
//CHECK: st1w    {z0.s}, p0, [z0.s]
ld1b    {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1b    {z31.s}, p7/z, [sp, #-1, mul vl]
smin    z23.h, z23.h, #109
//CHECK: smin    z23.h, z23.h, #109
smaxv   d0, p0, z0.d
//CHECK: smaxv   d0, p0, z0.d
mov     z21.b, p5/m, w10
//CHECK: mov     z21.b, p5/m, w10
ptrues  p15.d
//CHECK: ptrues  p15.d
mov     z21.h, #-86
//CHECK: mov     z21.h, #-86
ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw #1]
//CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw #1]
mov     z21.d, p5/m, z10.d
//CHECK: mov     z21.d, p5/m, z10.d
sqincp  z0.h, p0
//CHECK: sqincp  z0.h, p0
lsr     z23.h, p3/m, z23.h, #3
//CHECK: lsr     z23.h, p3/m, z23.h, #3
lasta   b21, p5, z10.b
//CHECK: lasta   b21, p5, z10.b
fcmle   p5.h, p5/z, z10.h, #0.0
//CHECK: fcmle   p5.h, p5/z, z10.h, #0.0
fcvt    z0.s, p0/m, z0.d
//CHECK: fcvt    z0.s, p0/m, z0.d
fminnm  z21.d, p5/m, z21.d, z10.d
//CHECK: fminnm  z21.d, p5/m, z21.d, z10.d
ld4w    {z5.s, z6.s, z7.s, z8.s}, p3/z, [x17, x16, lsl #2]
//CHECK: ld4w    {z5.s, z6.s, z7.s, z8.s}, p3/z, [x17, x16, lsl #2]
zip2    z0.d, z0.d, z0.d
//CHECK: zip2    z0.d, z0.d, z0.d
st1b    {z31.b}, p7, [sp, #-1, mul vl]
//CHECK: st1b    {z31.b}, p7, [sp, #-1, mul vl]
ftssel  z0.d, z0.d, z0.d
//CHECK: ftssel  z0.d, z0.d, z0.d
st4d    {z21.d, z22.d, z23.d, z24.d}, p5, [x10, #20, mul vl]
//CHECK: st4d    {z21.d, z22.d, z23.d, z24.d}, p5, [x10, #20, mul vl]
clastb  z31.h, p7, z31.h, z31.h
//CHECK: clastb  z31.h, p7, z31.h, z31.h
prfb    pldl3strm, p5, [x10, #21, mul vl]
//CHECK: prfb    pldl3strm, p5, [x10, #21, mul vl]
sminv   b21, p5, z10.b
//CHECK: sminv   b21, p5, z10.b
ldff1b  {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ldff1b  {z21.d}, p5/z, [x10, z21.d, uxtw]
ldff1b  {z0.h}, p0/z, [x0, x0]
//CHECK: ldff1b  {z0.h}, p0/z, [x0, x0]
ld1rsb  {z23.h}, p3/z, [x13, #8]
//CHECK: ld1rsb  {z23.h}, p3/z, [x13, #8]
cmphs   p7.d, p3/z, z13.d, #35
//CHECK: cmphs   p7.d, p3/z, z13.d, #35
cmpeq   p0.b, p0/z, z0.b, z0.b
//CHECK: cmpeq   p0.b, p0/z, z0.b, z0.b
uqdecd  z31.d, all, mul #16
//CHECK: uqdecd  z31.d, all, mul #16
uqdecp  z21.h, p10
//CHECK: uqdecp  z21.h, p10
ld4w    {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0]
//CHECK: ld4w    {z0.s, z1.s, z2.s, z3.s}, p0/z, [x0]
ldff1w  {z21.d}, p5/z, [z10.d, #84]
//CHECK: ldff1w  {z21.d}, p5/z, [z10.d, #84]
sunpklo z0.d, z0.s
//CHECK: sunpklo z0.d, z0.s
orv     h21, p5, z10.h
//CHECK: orv     h21, p5, z10.h
nor     p5.b, p5/z, p10.b, p5.b
//CHECK: nor     p5.b, p5/z, p10.b, p5.b
msb     z31.s, p7/m, z31.s, z31.s
//CHECK: msb     z31.s, p7/m, z31.s, z31.s
fcmne   p0.h, p0/z, z0.h, z0.h
//CHECK: fcmne   p0.h, p0/z, z0.h, z0.h
cmpne   p7.h, p3/z, z13.h, z8.h
//CHECK: cmpne   p7.h, p3/z, z13.h, z8.h
fadd    z23.s, p3/m, z23.s, #1.0
//CHECK: fadd    z23.s, p3/m, z23.s, #1.0
cmple   p0.b, p0/z, z0.b, z0.d
//CHECK: cmple   p0.b, p0/z, z0.b, z0.d
index   z21.h, #10, #-11
//CHECK: index   z21.h, #10, #-11
clasta  w21, p5, w21, z10.b
//CHECK: clasta  w21, p5, w21, z10.b
ldff1w  {z23.d}, p3/z, [x13, z8.d, lsl #2]
//CHECK: ldff1w  {z23.d}, p3/z, [x13, z8.d, lsl #2]
mul     z21.s, z21.s, #-86
//CHECK: mul     z21.s, z21.s, #-86
sub     z31.s, p7/m, z31.s, z31.s
//CHECK: sub     z31.s, p7/m, z31.s, z31.s
ctermne w10, w21
//CHECK: ctermne w10, w21
fnmls   z0.d, p0/m, z0.d, z0.d
//CHECK: fnmls   z0.d, p0/m, z0.d, z0.d
uqdecw  z31.s, all, mul #16
//CHECK: uqdecw  z31.s, all, mul #16
st1w    {z21.d}, p5, [z10.d, #84]
//CHECK: st1w    {z21.d}, p5, [z10.d, #84]
ldnf1b  {z31.h}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1b  {z31.h}, p7/z, [sp, #-1, mul vl]
ld1b    {z21.b}, p5/z, [x10, #5, mul vl]
//CHECK: ld1b    {z21.b}, p5/z, [x10, #5, mul vl]
st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0]
//CHECK: st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0]
uqincp  x21, p10.b
//CHECK: uqincp  x21, p10.b
sminv   d31, p7, z31.d
//CHECK: sminv   d31, p7, z31.d
not     z31.s, p7/m, z31.s
//CHECK: not     z31.s, p7/m, z31.s
uqincp  xzr, p15.b
//CHECK: uqincp  xzr, p15.b
splice  z31.b, p7, z31.b, z31.b
//CHECK: splice  z31.b, p7, z31.b, z31.b
lasta   d0, p0, z0.d
//CHECK: lasta   d0, p0, z0.d
uabd    z31.d, p7/m, z31.d, z31.d
//CHECK: uabd    z31.d, p7/m, z31.d, z31.d
umulh   z31.d, p7/m, z31.d, z31.d
//CHECK: umulh   z31.d, p7/m, z31.d, z31.d
uminv   b0, p0, z0.b
//CHECK: uminv   b0, p0, z0.b
ld1d    {z31.d}, p7/z, [sp, z31.d, sxtw #3]
//CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, sxtw #3]
ld1b    {z23.d}, p3/z, [x13, z8.d]
//CHECK: ld1b    {z23.d}, p3/z, [x13, z8.d]
cntd    x21, vl32, mul #6
//CHECK: cntd    x21, vl32, mul #6
mla     z23.d, p3/m, z13.d, z8.d
//CHECK: mla     z23.d, p3/m, z13.d, z8.d
uzp2    p0.s, p0.s, p0.s
//CHECK: uzp2    p0.s, p0.s, p0.s
prfd    #15, p7, [sp, z31.d, sxtw #3]
//CHECK: prfd    #15, p7, [sp, z31.d, sxtw #3]
ldff1b  {z31.d}, p7/z, [z31.d, #31]
//CHECK: ldff1b  {z31.d}, p7/z, [z31.d, #31]
cmphs   p5.s, p5/z, z10.s, z21.d
//CHECK: cmphs   p5.s, p5/z, z10.s, z21.d
whilele p15.h, xzr, xzr
//CHECK: whilele p15.h, xzr, xzr
ptest   p5, p10.b
//CHECK: ptest   p5, p10.b
add     z0.h, z0.h, z0.h
//CHECK: add     z0.h, z0.h, z0.h
mla     z21.d, p5/m, z10.d, z21.d
//CHECK: mla     z21.d, p5/m, z10.d, z21.d
mov     z0.b, p0/m, b0
//CHECK: mov     z0.b, p0/m, b0
cmpne   p15.d, p7/z, z31.d, #-1
//CHECK: cmpne   p15.d, p7/z, z31.d, #-1
lsr     z21.d, p5/m, z21.d, z10.d
//CHECK: lsr     z21.d, p5/m, z21.d, z10.d
fcmle   p15.h, p7/z, z31.h, #0.0
//CHECK: fcmle   p15.h, p7/z, z31.h, #0.0
st1h    {z0.d}, p0, [x0, z0.d]
//CHECK: st1h    {z0.d}, p0, [x0, z0.d]
ld1w    {z31.s}, p7/z, [z31.s, #124]
//CHECK: ld1w    {z31.s}, p7/z, [z31.s, #124]
zip1    p15.d, p15.d, p15.d
//CHECK: zip1    p15.d, p15.d, p15.d
cnt     z0.d, p0/m, z0.d
//CHECK: cnt     z0.d, p0/m, z0.d
sqdecd  xzr, all, mul #16
//CHECK: sqdecd  xzr, all, mul #16
fnmla   z31.s, p7/m, z31.s, z31.s
//CHECK: fnmla   z31.s, p7/m, z31.s, z31.s
clastb  z21.s, p5, z21.s, z10.s
//CHECK: clastb  z21.s, p5, z21.s, z10.s
ldnf1b  {z0.d}, p0/z, [x0]
//CHECK: ldnf1b  {z0.d}, p0/z, [x0]
fmla    z21.h, z10.h, z5.h[6]
//CHECK: fmla    z21.h, z10.h, z5.h[6]
uzp2    z31.d, z31.d, z31.d
//CHECK: uzp2    z31.d, z31.d, z31.d
st1h    {z21.s}, p5, [x10, z21.s, uxtw]
//CHECK: st1h    {z21.s}, p5, [x10, z21.s, uxtw]
uunpklo z0.s, z0.h
//CHECK: uunpklo z0.s, z0.h
movprfx z23, z13
//CHECK: movprfx z23, z13
add     z23.d, p3/m, z23.d, z24.d
//CHECK: add z23.d, p3/m, z23.d, z24.d
smax    z31.d, p7/m, z31.d, z31.d
//CHECK: smax    z31.d, p7/m, z31.d, z31.d
fnmad   z0.s, p0/m, z0.s, z0.s
//CHECK: fnmad   z0.s, p0/m, z0.s, z0.s
ld2w    {z5.s, z6.s}, p3/z, [x17, x16, lsl #2]
//CHECK: ld2w    {z5.s, z6.s}, p3/z, [x17, x16, lsl #2]
clasta  w0, p0, w0, z0.h
//CHECK: clasta  w0, p0, w0, z0.h
incp    x21, p10.b
//CHECK: incp    x21, p10.b
ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw #2]
//CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw #2]
tbl     z31.d, {z31.d}, z31.d
//CHECK: tbl     z31.d, {z31.d}, z31.d
neg     z31.b, p7/m, z31.b
//CHECK: neg     z31.b, p7/m, z31.b
clastb  d23, p3, d23, z13.d
//CHECK: clastb  d23, p3, d23, z13.d
neg     z23.s, p3/m, z13.s
//CHECK: neg     z23.s, p3/m, z13.s
asr     z31.h, p7/m, z31.h, #1
//CHECK: asr     z31.h, p7/m, z31.h, #1
uminv   s31, p7, z31.s
//CHECK: uminv   s31, p7, z31.s
adr     z31.d, [z31.d, z31.d, uxtw #3]
//CHECK: adr     z31.d, [z31.d, z31.d, uxtw #3]
st1h    {z23.s}, p3, [x13, x8, lsl #1]
//CHECK: st1h    {z23.s}, p3, [x13, x8, lsl #1]
ld1h    {z21.d}, p5/z, [z10.d, #42]
//CHECK: ld1h    {z21.d}, p5/z, [z10.d, #42]
uqsub   z0.b, z0.b, z0.b
//CHECK: uqsub   z0.b, z0.b, z0.b
frsqrts z21.s, z10.s, z21.s
//CHECK: frsqrts z21.s, z10.s, z21.s
not     p5.b, p5/z, p10.b
//CHECK: not     p5.b, p5/z, p10.b
index   z0.h, #0, #0
//CHECK: index   z0.h, #0, #0
faddv   h21, p5, z10.h
//CHECK: faddv   h21, p5, z10.h
ld1rsb  {z21.h}, p5/z, [x10, #21]
//CHECK: ld1rsb  {z21.h}, p5/z, [x10, #21]
subr    z23.b, p3/m, z23.b, z13.b
//CHECK: subr    z23.b, p3/m, z23.b, z13.b
st1b    {z0.s}, p0, [x0, x0]
//CHECK: st1b    {z0.s}, p0, [x0, x0]
ldnf1sh {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1sh {z23.d}, p3/z, [x13, #-8, mul vl]
nor     p7.b, p11/z, p13.b, p8.b
//CHECK: nor     p7.b, p11/z, p13.b, p8.b
ld1sw   {z31.d}, p7/z, [sp, z31.d, uxtw #2]
//CHECK: ld1sw   {z31.d}, p7/z, [sp, z31.d, uxtw #2]
lsl     z21.b, p5/m, z21.b, z10.b
//CHECK: lsl     z21.b, p5/m, z21.b, z10.b
fcmlt   p7.h, p3/z, z13.h, #0.0
//CHECK: fcmlt   p7.h, p3/z, z13.h, #0.0
fadd    z0.s, z0.s, z0.s
//CHECK: fadd    z0.s, z0.s, z0.s
smax    z31.d, z31.d, #-1
//CHECK: smax    z31.d, z31.d, #-1
sdot    z23.s, z13.b, z0.b[1]
//CHECK: sdot    z23.s, z13.b, z0.b[1]
ld1d    {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, sxtw]
fminv   d31, p7, z31.d
//CHECK: fminv   d31, p7, z31.d
uzp1    p15.d, p15.d, p15.d
//CHECK: uzp1    p15.d, p15.d, p15.d
sdivr   z0.d, p0/m, z0.d, z0.d
//CHECK: sdivr   z0.d, p0/m, z0.d, z0.d
brkb    p5.b, p5/m, p10.b
//CHECK: brkb    p5.b, p5/m, p10.b
whilele p0.d, w0, w0
//CHECK: whilele p0.d, w0, w0
uxtb    z0.h, p0/m, z0.h
//CHECK: uxtb    z0.h, p0/m, z0.h
uzp2    z23.s, z13.s, z8.s
//CHECK: uzp2    z23.s, z13.s, z8.s
splice  z0.h, p0, z0.h, z0.h
//CHECK: splice  z0.h, p0, z0.h, z0.h
uzp1    z0.h, z0.h, z0.h
//CHECK: uzp1    z0.h, z0.h, z0.h
ldff1b  {z21.s}, p5/z, [x10, z21.s, sxtw]
//CHECK: ldff1b  {z21.s}, p5/z, [x10, z21.s, sxtw]
udot    z23.d, z13.h, z8.h[0]
//CHECK: udot    z23.d, z13.h, z8.h[0]
ld1sw   {z21.d}, p5/z, [x10, z21.d]
//CHECK: ld1sw   {z21.d}, p5/z, [x10, z21.d]
fmaxnm  z31.d, p7/m, z31.d, #1.0
//CHECK: fmaxnm  z31.d, p7/m, z31.d, #1.0
insr    z0.s, s0
//CHECK: insr    z0.s, s0
st1h    {z23.d}, p3, [x13, z8.d, uxtw]
//CHECK: st1h    {z23.d}, p3, [x13, z8.d, uxtw]
rev     z23.b, z13.b
//CHECK: rev     z23.b, z13.b
orv     s31, p7, z31.s
//CHECK: orv     s31, p7, z31.s
cnot    z31.h, p7/m, z31.h
//CHECK: cnot    z31.h, p7/m, z31.h
ld1b    {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ld1b    {z0.d}, p0/z, [x0, z0.d, sxtw]
fscale  z23.s, p3/m, z23.s, z13.s
//CHECK: fscale  z23.s, p3/m, z23.s, z13.s
frintn  z0.s, p0/m, z0.s
//CHECK: frintn  z0.s, p0/m, z0.s
smax    z0.d, z0.d, #0
//CHECK: smax    z0.d, z0.d, #0
ld1w    {z31.d}, p7/z, [sp, z31.d, lsl #2]
//CHECK: ld1w    {z31.d}, p7/z, [sp, z31.d, lsl #2]
ucvtf   z31.d, p7/m, z31.d
//CHECK: ucvtf   z31.d, p7/m, z31.d
insr    z23.s, s13
//CHECK: insr    z23.s, s13
whilels p5.s, w10, w21
//CHECK: whilels p5.s, w10, w21
movprfx z23.d, p3/z, z13.d
//CHECK: movprfx z23.d, p3/z, z13.d
add     z23.d, p3/m, z23.d, z24.d
//CHECK: add z23.d, p3/m, z23.d, z24.d
sub     z0.d, z0.d, #0
//CHECK: sub     z0.d, z0.d, #0
frecpx  z23.s, p3/m, z13.s
//CHECK: frecpx  z23.s, p3/m, z13.s
uqdech  z31.h, all, mul #16
//CHECK: uqdech  z31.h, all, mul #16
uqdecp  wzr, p15.d
//CHECK: uqdecp  wzr, p15.d
stnt1w  {z23.s}, p3, [x13, #-8, mul vl]
//CHECK: stnt1w  {z23.s}, p3, [x13, #-8, mul vl]
cmpne   p15.h, p7/z, z31.h, #-1
//CHECK: cmpne   p15.h, p7/z, z31.h, #-1
ld4d    {z23.d, z24.d, z25.d, z26.d}, p3/z, [x13, #-32, mul vl]
//CHECK: ld4d    {z23.d, z24.d, z25.d, z26.d}, p3/z, [x13, #-32, mul vl]
umin    z23.h, z23.h, #109
//CHECK: umin    z23.h, z23.h, #109
uqdech  w23, vl256, mul #9
//CHECK: uqdech  w23, vl256, mul #9
ld1b    {z23.b}, p3/z, [x13, x8]
//CHECK: ld1b    {z23.b}, p3/z, [x13, x8]
umax    z0.b, p0/m, z0.b, z0.b
//CHECK: umax    z0.b, p0/m, z0.b, z0.b
mul     z23.h, p3/m, z23.h, z13.h
//CHECK: mul     z23.h, p3/m, z23.h, z13.h
neg     z0.d, p0/m, z0.d
//CHECK: neg     z0.d, p0/m, z0.d
fsubr   z31.d, p7/m, z31.d, z31.d
//CHECK: fsubr   z31.d, p7/m, z31.d, z31.d
ldff1d  {z21.d}, p5/z, [x10, x21, lsl #3]
//CHECK: ldff1d  {z21.d}, p5/z, [x10, x21, lsl #3]
sqsub   z31.d, z31.d, #255, lsl #8
//CHECK: sqsub   z31.d, z31.d, #65280
st1w    {z23.s}, p3, [x13, z8.s, sxtw #2]
//CHECK: st1w    {z23.s}, p3, [x13, z8.s, sxtw #2]
subr    z21.s, p5/m, z21.s, z10.s
//CHECK: subr    z21.s, p5/m, z21.s, z10.s
prfb    #7, p3, [x13, z8.d, uxtw]
//CHECK: prfb    #7, p3, [x13, z8.d, uxtw]
ld1b    {z0.h}, p0/z, [x0]
//CHECK: ld1b    {z0.h}, p0/z, [x0]
ldff1h  {z21.d}, p5/z, [z10.d, #42]
//CHECK: ldff1h  {z21.d}, p5/z, [z10.d, #42]
lsr     z23.s, p3/m, z23.s, z13.s
//CHECK: lsr     z23.s, p3/m, z23.s, z13.s
bic     z31.d, p7/m, z31.d, z31.d
//CHECK: bic     z31.d, p7/m, z31.d, z31.d
fcvtzs  z0.s, p0/m, z0.d
//CHECK: fcvtzs  z0.s, p0/m, z0.d
uabd    z21.d, p5/m, z21.d, z10.d
//CHECK: uabd    z21.d, p5/m, z21.d, z10.d
fcadd   z23.d, p3/m, z23.d, z13.d, #90
//CHECK: fcadd   z23.d, p3/m, z23.d, z13.d, #90
st1d    {z23.d}, p3, [x13, x8, lsl #3]
//CHECK: st1d    {z23.d}, p3, [x13, x8, lsl #3]
asr     z0.h, p0/m, z0.h, z0.d
//CHECK: asr     z0.h, p0/m, z0.h, z0.d
sqincd  xzr, wzr, all, mul #16
//CHECK: sqincd  xzr, wzr, all, mul #16
uminv   d21, p5, z10.d
//CHECK: uminv   d21, p5, z10.d
ld1rsh  {z23.s}, p3/z, [x13, #16]
//CHECK: ld1rsh  {z23.s}, p3/z, [x13, #16]
ldff1sb {z21.s}, p5/z, [z10.s, #21]
//CHECK: ldff1sb {z21.s}, p5/z, [z10.s, #21]
ld1sw   {z23.d}, p3/z, [x13, z8.d, lsl #2]
//CHECK: ld1sw   {z23.d}, p3/z, [x13, z8.d, lsl #2]
lasta   s23, p3, z13.s
//CHECK: lasta   s23, p3, z13.s
prfd    #15, p7, [sp, z31.s, uxtw #3]
//CHECK: prfd    #15, p7, [sp, z31.s, uxtw #3]
st1w    {z31.d}, p7, [z31.d, #124]
//CHECK: st1w    {z31.d}, p7, [z31.d, #124]
ld1rb   {z31.d}, p7/z, [sp, #63]
//CHECK: ld1rb   {z31.d}, p7/z, [sp, #63]
fmaxnmv d0, p0, z0.d
//CHECK: fmaxnmv d0, p0, z0.d
ftssel  z0.h, z0.h, z0.h
//CHECK: ftssel  z0.h, z0.h, z0.h
sqadd   z0.s, z0.s, #0
//CHECK: sqadd   z0.s, z0.s, #0
whilels p0.h, w0, w0
//CHECK: whilels p0.h, w0, w0
fcvtzs  z0.h, p0/m, z0.h
//CHECK: fcvtzs  z0.h, p0/m, z0.h
add     z0.b, p0/m, z0.b, z0.b
//CHECK: add     z0.b, p0/m, z0.b, z0.b
cmpls   p5.b, p5/z, z10.b, #85
//CHECK: cmpls   p5.b, p5/z, z10.b, #85
mad     z31.h, p7/m, z31.h, z31.h
//CHECK: mad     z31.h, p7/m, z31.h, z31.h
ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw]
fmla    z23.s, z13.s, z0.s[1]
//CHECK: fmla    z23.s, z13.s, z0.s[1]
sqdecp  x23, p13.b, w23
//CHECK: sqdecp  x23, p13.b, w23
umax    z21.d, z21.d, #170
//CHECK: umax    z21.d, z21.d, #170
uqincp  w23, p13.d
//CHECK: uqincp  w23, p13.d
ld1w    {z23.d}, p3/z, [x13, z8.d, sxtw #2]
//CHECK: ld1w    {z23.d}, p3/z, [x13, z8.d, sxtw #2]
ldnt1b  {z0.b}, p0/z, [x0]
//CHECK: ldnt1b  {z0.b}, p0/z, [x0]
incp    x21, p10.s
//CHECK: incp    x21, p10.s
st1w    {z31.s}, p7, [sp, z31.s, sxtw #2]
//CHECK: st1w    {z31.s}, p7, [sp, z31.s, sxtw #2]
lsr     z23.b, z13.b, z8.d
//CHECK: lsr     z23.b, z13.b, z8.d
fadd    z21.h, p5/m, z21.h, z10.h
//CHECK: fadd    z21.h, p5/m, z21.h, z10.h
ld1sb   {z21.s}, p5/z, [z10.s, #21]
//CHECK: ld1sb   {z21.s}, p5/z, [z10.s, #21]
sqadd   z31.d, z31.d, #255, lsl #8
//CHECK: sqadd   z31.d, z31.d, #65280
cmpge   p0.s, p0/z, z0.s, #0
//CHECK: cmpge   p0.s, p0/z, z0.s, #0
fadd    z31.s, z31.s, z31.s
//CHECK: fadd    z31.s, z31.s, z31.s
ldff1w  {z0.d}, p0/z, [x0, z0.d, uxtw #2]
//CHECK: ldff1w  {z0.d}, p0/z, [x0, z0.d, uxtw #2]
fcmge   p0.h, p0/z, z0.h, #0.0
//CHECK: fcmge   p0.h, p0/z, z0.h, #0.0
mov     z0.d, #0xe0000000000003ff
//CHECK: mov     z0.d, #0xe0000000000003ff
fcvtzu  z23.s, p3/m, z13.s
//CHECK: fcvtzu  z23.s, p3/m, z13.s
ld1h    {z0.s}, p0/z, [x0]
//CHECK: ld1h    {z0.s}, p0/z, [x0]
sqincd  x0, w0, pow2
//CHECK: sqincd  x0, w0, pow2
ld3h    {z5.h, z6.h, z7.h}, p3/z, [x17, x16, lsl #1]
//CHECK: ld3h    {z5.h, z6.h, z7.h}, p3/z, [x17, x16, lsl #1]
sqincb  x23, vl256, mul #9
//CHECK: sqincb  x23, vl256, mul #9
ld1b    {z21.h}, p5/z, [x10, #5, mul vl]
//CHECK: ld1b    {z21.h}, p5/z, [x10, #5, mul vl]
cmpne   p5.h, p5/z, z10.h, z21.h
//CHECK: cmpne   p5.h, p5/z, z10.h, z21.h
rdffrs  p15.b, p15/z
//CHECK: rdffrs  p15.b, p15/z
fmla    z23.s, p3/m, z13.s, z8.s
//CHECK: fmla    z23.s, p3/m, z13.s, z8.s
ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw #1]
//CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw #1]
zip2    z31.d, z31.d, z31.d
//CHECK: zip2    z31.d, z31.d, z31.d
uminv   s21, p5, z10.s
//CHECK: uminv   s21, p5, z10.s
ldnf1w  {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1w  {z21.d}, p5/z, [x10, #5, mul vl]
fmul    z0.s, p0/m, z0.s, z0.s
//CHECK: fmul    z0.s, p0/m, z0.s, z0.s
st1b    {z0.h}, p0, [x0]
//CHECK: st1b    {z0.h}, p0, [x0]
adr     z0.d, [z0.d, z0.d, uxtw]
//CHECK: adr     z0.d, [z0.d, z0.d, uxtw]
mov     z5.b, z17.b[56]
//CHECK: mov     z5.b, z17.b[56]
frecps  z23.s, z13.s, z8.s
//CHECK: frecps  z23.s, z13.s, z8.s
lsr     z23.s, p3/m, z23.s, #19
//CHECK: lsr     z23.s, p3/m, z23.s, #19
ands    p5.b, p5/z, p10.b, p5.b
//CHECK: ands    p5.b, p5/z, p10.b, p5.b
clastb  w23, p3, w23, z13.b
//CHECK: clastb  w23, p3, w23, z13.b
trn2    z0.b, z0.b, z0.b
//CHECK: trn2    z0.b, z0.b, z0.b
asr     z0.b, z0.b, #8
//CHECK: asr     z0.b, z0.b, #8
uqincp  z31.h, p15
//CHECK: uqincp  z31.h, p15
and     z31.b, p7/m, z31.b, z31.b
//CHECK: and     z31.b, p7/m, z31.b, z31.b
fcmne   p15.d, p7/z, z31.d, #0.0
//CHECK: fcmne   p15.d, p7/z, z31.d, #0.0
asrr    z31.b, p7/m, z31.b, z31.b
//CHECK: asrr    z31.b, p7/m, z31.b, z31.b
orv     s21, p5, z10.s
//CHECK: orv     s21, p5, z10.s
fmad    z0.s, p0/m, z0.s, z0.s
//CHECK: fmad    z0.s, p0/m, z0.s, z0.s
lsl     z23.b, z13.b, z8.d
//CHECK: lsl     z23.b, z13.b, z8.d
cmpeq   p5.b, p5/z, z10.b, z21.d
//CHECK: cmpeq   p5.b, p5/z, z10.b, z21.d
bic     z23.h, p3/m, z23.h, z13.h
//CHECK: bic     z23.h, p3/m, z23.h, z13.h
ldnt1b  {z23.b}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnt1b  {z23.b}, p3/z, [x13, #-8, mul vl]
revh    z23.s, p3/m, z13.s
//CHECK: revh    z23.s, p3/m, z13.s
rev     p15.b, p15.b
//CHECK: rev     p15.b, p15.b
ldff1h  {z0.h}, p0/z, [x0, x0, lsl #1]
//CHECK: ldff1h  {z0.h}, p0/z, [x0, x0, lsl #1]
revb    z0.h, p0/m, z0.h
//CHECK: revb    z0.h, p0/m, z0.h
sunpklo z23.s, z13.h
//CHECK: sunpklo z23.s, z13.h
umaxv   s31, p7, z31.s
//CHECK: umaxv   s31, p7, z31.s
smin    z21.b, p5/m, z21.b, z10.b
//CHECK: smin    z21.b, p5/m, z21.b, z10.b
fadd    z0.h, p0/m, z0.h, z0.h
//CHECK: fadd    z0.h, p0/m, z0.h, z0.h
ld1sh   {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ld1sh   {z31.d}, p7/z, [sp, z31.d, sxtw]
whilels p0.b, w0, w0
//CHECK: whilels p0.b, w0, w0
ldff1h  {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ldff1h  {z0.d}, p0/z, [x0, z0.d, uxtw]
ld1b    {z0.s}, p0/z, [x0, z0.s, uxtw]
//CHECK: ld1b    {z0.s}, p0/z, [x0, z0.s, uxtw]
fnmla   z21.d, p5/m, z10.d, z21.d
//CHECK: fnmla   z21.d, p5/m, z10.d, z21.d
mov     z31.h, p7/m, h31
//CHECK: mov     z31.h, p7/m, h31
cmphi   p7.b, p3/z, z13.b, #35
//CHECK: cmphi   p7.b, p3/z, z13.b, #35
cmpeq   p7.s, p3/z, z13.s, z8.s
//CHECK: cmpeq   p7.s, p3/z, z13.s, z8.s
fmul    z21.h, z10.h, z21.h
//CHECK: fmul    z21.h, z10.h, z21.h
ld1sh   {z31.d}, p7/z, [z31.d, #62]
//CHECK: ld1sh   {z31.d}, p7/z, [z31.d, #62]
adr     z31.s, [z31.s, z31.s, lsl #2]
//CHECK: adr     z31.s, [z31.s, z31.s, lsl #2]
sqincp  xzr, p15.d
//CHECK: sqincp  xzr, p15.d
st2b    {z31.b, z0.b}, p7, [sp, #-2, mul vl]
//CHECK: st2b    {z31.b, z0.b}, p7, [sp, #-2, mul vl]
uqsub   z31.s, z31.s, z31.s
//CHECK: uqsub   z31.s, z31.s, z31.s
cmpgt   p15.h, p7/z, z31.h, z31.d
//CHECK: cmpgt   p15.h, p7/z, z31.h, z31.d
umaxv   b31, p7, z31.b
//CHECK: umaxv   b31, p7, z31.b
fmulx   z23.d, p3/m, z23.d, z13.d
//CHECK: fmulx   z23.d, p3/m, z23.d, z13.d
ld2h    {z0.h, z1.h}, p0/z, [x0, x0, lsl #1]
//CHECK: ld2h    {z0.h, z1.h}, p0/z, [x0, x0, lsl #1]
saddv   d31, p7, z31.b
//CHECK: saddv   d31, p7, z31.b
ld1rw   {z31.d}, p7/z, [sp, #252]
//CHECK: ld1rw   {z31.d}, p7/z, [sp, #252]
ctermeq x13, x8
//CHECK: ctermeq x13, x8
asr     z21.h, p5/m, z21.h, #6
//CHECK: asr     z21.h, p5/m, z21.h, #6
fsub    z0.s, p0/m, z0.s, #0.5
//CHECK: fsub    z0.s, p0/m, z0.s, #0.5
cmplo   p7.b, p3/z, z13.b, z8.d
//CHECK: cmplo   p7.b, p3/z, z13.b, z8.d
sub     z0.d, p0/m, z0.d, z0.d
//CHECK: sub     z0.d, p0/m, z0.d, z0.d
trn1    z0.s, z0.s, z0.s
//CHECK: trn1    z0.s, z0.s, z0.s
incp    z21.h, p10
//CHECK: incp    z21.h, p10
fcmuo   p15.s, p7/z, z31.s, z31.s
//CHECK: fcmuo   p15.s, p7/z, z31.s, z31.s
ldff1h  {z21.s}, p5/z, [x10, x21, lsl #1]
//CHECK: ldff1h  {z21.s}, p5/z, [x10, x21, lsl #1]
st1w    {z5.s}, p3, [x17, x16, lsl #2]
//CHECK: st1w    {z5.s}, p3, [x17, x16, lsl #2]
cmple   p0.h, p0/z, z0.h, z0.d
//CHECK: cmple   p0.h, p0/z, z0.h, z0.d
sqadd   z0.h, z0.h, #0
//CHECK: sqadd   z0.h, z0.h, #0
st1b    {z23.b}, p3, [x13, #-8, mul vl]
//CHECK: st1b    {z23.b}, p3, [x13, #-8, mul vl]
whilelo p15.d, xzr, xzr
//CHECK: whilelo p15.d, xzr, xzr
clasta  b0, p0, b0, z0.b
//CHECK: clasta  b0, p0, b0, z0.b
ldff1b  {z23.b}, p3/z, [x13, x8]
//CHECK: ldff1b  {z23.b}, p3/z, [x13, x8]
ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, x8]
//CHECK: ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, x8]
st1h    {z31.s}, p7, [sp, z31.s, sxtw #1]
//CHECK: st1h    {z31.s}, p7, [sp, z31.s, sxtw #1]
mov     z23.h, w13
//CHECK: mov     z23.h, w13
sqsub   z0.b, z0.b, #0
//CHECK: sqsub   z0.b, z0.b, #0
ldff1w  {z31.s}, p7/z, [sp, xzr, lsl #2]
//CHECK: ldff1w  {z31.s}, p7/z, [sp]
fnmad   z31.s, p7/m, z31.s, z31.s
//CHECK: fnmad   z31.s, p7/m, z31.s, z31.s
fadd    z23.s, z13.s, z8.s
//CHECK: fadd    z23.s, z13.s, z8.s
sub     z0.b, z0.b, z0.b
//CHECK: sub     z0.b, z0.b, z0.b
prfd    #7, p3, [z13.s, #64]
//CHECK: prfd    #7, p3, [z13.s, #64]
ld1rw   {z31.s}, p7/z, [sp, #252]
//CHECK: ld1rw   {z31.s}, p7/z, [sp, #252]
fmul    z23.d, p3/m, z23.d, z13.d
//CHECK: fmul    z23.d, p3/m, z23.d, z13.d
st1w    {z31.d}, p7, [sp, z31.d, uxtw #2]
//CHECK: st1w    {z31.d}, p7, [sp, z31.d, uxtw #2]
fdivr   z21.s, p5/m, z21.s, z10.s
//CHECK: fdivr   z21.s, p5/m, z21.s, z10.s
ldnf1sb {z31.h}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1sb {z31.h}, p7/z, [sp, #-1, mul vl]
cmpeq   p5.s, p5/z, z10.s, z21.d
//CHECK: cmpeq   p5.s, p5/z, z10.s, z21.d
decp    x21, p10.d
//CHECK: decp    x21, p10.d
cmpeq   p15.s, p7/z, z31.s, z31.s
//CHECK: cmpeq   p15.s, p7/z, z31.s, z31.s
clasta  z21.d, p5, z21.d, z10.d
//CHECK: clasta  z21.d, p5, z21.d, z10.d
brkb    p0.b, p0/z, p0.b
//CHECK: brkb    p0.b, p0/z, p0.b
ldff1h  {z31.d}, p7/z, [sp, xzr, lsl #1]
//CHECK: ldff1h  {z31.d}, p7/z, [sp]
sqadd   z0.b, z0.b, #0
//CHECK: sqadd   z0.b, z0.b, #0
ld2h    {z5.h, z6.h}, p3/z, [x17, x16, lsl #1]
//CHECK: ld2h    {z5.h, z6.h}, p3/z, [x17, x16, lsl #1]
fmls    z31.s, z31.s, z7.s[3]
//CHECK: fmls    z31.s, z31.s, z7.s[3]
brkbs   p15.b, p15/z, p15.b
//CHECK: brkbs   p15.b, p15/z, p15.b
decp    x23, p13.h
//CHECK: decp    x23, p13.h
brka    p0.b, p0/m, p0.b
//CHECK: brka    p0.b, p0/m, p0.b
cmplo   p0.h, p0/z, z0.h, #0
//CHECK: cmplo   p0.h, p0/z, z0.h, #0
fnmad   z0.h, p0/m, z0.h, z0.h
//CHECK: fnmad   z0.h, p0/m, z0.h, z0.h
ld1w    {z23.d}, p3/z, [x13, z8.d, lsl #2]
//CHECK: ld1w    {z23.d}, p3/z, [x13, z8.d, lsl #2]
fmaxv   d0, p0, z0.d
//CHECK: fmaxv   d0, p0, z0.d
adr     z21.d, [z10.d, z21.d, sxtw #2]
//CHECK: adr     z21.d, [z10.d, z21.d, sxtw #2]
ld1sb   {z21.s}, p5/z, [x10, x21]
//CHECK: ld1sb   {z21.s}, p5/z, [x10, x21]
cmpeq   p7.s, p3/z, z13.s, #8
//CHECK: cmpeq   p7.s, p3/z, z13.s, #8
ldnf1w  {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1w  {z23.d}, p3/z, [x13, #-8, mul vl]
fcvtzs  z31.s, p7/m, z31.s
//CHECK: fcvtzs  z31.s, p7/m, z31.s
uqincp  xzr, p15.h
//CHECK: uqincp  xzr, p15.h
st1w    {z21.s}, p5, [x10, x21, lsl #2]
//CHECK: st1w    {z21.s}, p5, [x10, x21, lsl #2]
rdffr   p5.b, p10/z
//CHECK: rdffr   p5.b, p10/z
revb    z21.s, p5/m, z10.s
//CHECK: revb    z21.s, p5/m, z10.s
prfw    #7, p3, [x13, z8.s, uxtw #2]
//CHECK: prfw    #7, p3, [x13, z8.s, uxtw #2]
mad     z23.d, p3/m, z8.d, z13.d
//CHECK: mad     z23.d, p3/m, z8.d, z13.d
cmpeq   p5.d, p5/z, z10.d, #-11
//CHECK: cmpeq   p5.d, p5/z, z10.d, #-11
ld1h    {z21.d}, p5/z, [x10, z21.d]
//CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d]
sub     z23.d, z13.d, z8.d
//CHECK: sub     z23.d, z13.d, z8.d
prfw    #15, p7, [sp, z31.s, sxtw #2]
//CHECK: prfw    #15, p7, [sp, z31.s, sxtw #2]
ldnf1w  {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1w  {z23.s}, p3/z, [x13, #-8, mul vl]
st1b    {z23.h}, p3, [x13, x8]
//CHECK: st1b    {z23.h}, p3, [x13, x8]
adr     z0.d, [z0.d, z0.d, uxtw #1]
//CHECK: adr     z0.d, [z0.d, z0.d, uxtw #1]
incw    z21.s, vl32, mul #6
//CHECK: incw    z21.s, vl32, mul #6
ld1h    {z31.s}, p7/z, [z31.s, #62]
//CHECK: ld1h    {z31.s}, p7/z, [z31.s, #62]
sqincp  z23.d, p13
//CHECK: sqincp  z23.d, p13
umaxv   d31, p7, z31.d
//CHECK: umaxv   d31, p7, z31.d
ldff1w  {z0.d}, p0/z, [x0, z0.d, sxtw #2]
//CHECK: ldff1w  {z0.d}, p0/z, [x0, z0.d, sxtw #2]
insr    z0.h, w0
//CHECK: insr    z0.h, w0
lsr     z0.s, z0.s, #32
//CHECK: lsr     z0.s, z0.s, #32
smin    z21.h, z21.h, #-86
//CHECK: smin    z21.h, z21.h, #-86
ld1h    {z21.s}, p5/z, [x10, x21, lsl #1]
//CHECK: ld1h    {z21.s}, p5/z, [x10, x21, lsl #1]
cmphs   p5.d, p5/z, z10.d, #85
//CHECK: cmphs   p5.d, p5/z, z10.d, #85
whilelt p15.d, xzr, xzr
//CHECK: whilelt p15.d, xzr, xzr
fmaxnmv s31, p7, z31.s
//CHECK: fmaxnmv s31, p7, z31.s
lastb   w21, p5, z10.s
//CHECK: lastb   w21, p5, z10.s
fadd    z21.d, p5/m, z21.d, z10.d
//CHECK: fadd    z21.d, p5/m, z21.d, z10.d
sqinch  x21, w21, vl32, mul #6
//CHECK: sqinch  x21, w21, vl32, mul #6
ldff1w  {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ldff1w  {z21.d}, p5/z, [x10, z21.d, uxtw]
ldnf1b  {z0.h}, p0/z, [x0]
//CHECK: ldnf1b  {z0.h}, p0/z, [x0]
mov     z0.h, p0/m, #0
//CHECK: mov     z0.h, p0/m, #0
ld1sw   {z21.d}, p5/z, [x10, z21.d, lsl #2]
//CHECK: ld1sw   {z21.d}, p5/z, [x10, z21.d, lsl #2]
cmpeq   p5.s, p5/z, z10.s, z21.s
//CHECK: cmpeq   p5.s, p5/z, z10.s, z21.s
fcmla   z21.h, p5/m, z10.h, z21.h, #180
//CHECK: fcmla   z21.h, p5/m, z10.h, z21.h, #180
asrr    z0.s, p0/m, z0.s, z0.s
//CHECK: asrr    z0.s, p0/m, z0.s, z0.s
asr     z21.h, z10.h, #11
//CHECK: asr     z21.h, z10.h, #11
ld1d    {z21.d}, p5/z, [x10, z21.d]
//CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d]
fminnmv h0, p0, z0.h
//CHECK: fminnmv h0, p0, z0.h
frinti  z31.h, p7/m, z31.h
//CHECK: frinti  z31.h, p7/m, z31.h
mad     z31.d, p7/m, z31.d, z31.d
//CHECK: mad     z31.d, p7/m, z31.d, z31.d
fmul    z31.h, p7/m, z31.h, z31.h
//CHECK: fmul    z31.h, p7/m, z31.h, z31.h
lsr     z0.h, p0/m, z0.h, z0.d
//CHECK: lsr     z0.h, p0/m, z0.h, z0.d
incp    xzr, p15.d
//CHECK: incp    xzr, p15.d
fcvtzu  z31.d, p7/m, z31.d
//CHECK: fcvtzu  z31.d, p7/m, z31.d
ld1h    {z31.s}, p7/z, [sp, z31.s, uxtw]
//CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, uxtw]
lastb   b23, p3, z13.b
//CHECK: lastb   b23, p3, z13.b
decw    x23, vl256, mul #9
//CHECK: decw    x23, vl256, mul #9
sqsub   z31.d, z31.d, z31.d
//CHECK: sqsub   z31.d, z31.d, z31.d
fcmne   p15.d, p7/z, z31.d, z31.d
//CHECK: fcmne   p15.d, p7/z, z31.d, z31.d
ld1rd   {z31.d}, p7/z, [sp, #504]
//CHECK: ld1rd   {z31.d}, p7/z, [sp, #504]
fsub    z21.h, p5/m, z21.h, z10.h
//CHECK: fsub    z21.h, p5/m, z21.h, z10.h
lsr     z31.b, z31.b, z31.d
//CHECK: lsr     z31.b, z31.b, z31.d
umulh   z31.b, p7/m, z31.b, z31.b
//CHECK: umulh   z31.b, p7/m, z31.b, z31.b
ld1rqd  {z23.d}, p3/z, [x13, #-128]
//CHECK: ld1rqd  {z23.d}, p3/z, [x13, #-128]
st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, x21, lsl #1]
//CHECK: st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, x21, lsl #1]
sxth    z21.s, p5/m, z10.s
//CHECK: sxth    z21.s, p5/m, z10.s
ldff1w  {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ldff1w  {z0.d}, p0/z, [x0, z0.d, uxtw]
lsl     z23.d, p3/m, z23.d, z13.d
//CHECK: lsl     z23.d, p3/m, z23.d, z13.d
ldff1sh {z0.d}, p0/z, [x0, z0.d, lsl #1]
//CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, lsl #1]
uqincw  z0.s, pow2
//CHECK: uqincw  z0.s, pow2
asrr    z23.s, p3/m, z23.s, z13.s
//CHECK: asrr    z23.s, p3/m, z23.s, z13.s
whilelt p5.s, x10, x21
//CHECK: whilelt p5.s, x10, x21
ptrues  p15.s
//CHECK: ptrues  p15.s
cnt     z23.d, p3/m, z13.d
//CHECK: cnt     z23.d, p3/m, z13.d
cmpgt   p5.d, p5/z, z10.d, #-11
//CHECK: cmpgt   p5.d, p5/z, z10.d, #-11
ld1h    {z23.s}, p3/z, [x13, z8.s, uxtw #1]
//CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, uxtw #1]
sqdecp  x0, p0.d
//CHECK: sqdecp  x0, p0.d
fcmeq   p7.h, p3/z, z13.h, #0.0
//CHECK: fcmeq   p7.h, p3/z, z13.h, #0.0
ld1b    {z23.s}, p3/z, [x13, x8]
//CHECK: ld1b    {z23.s}, p3/z, [x13, x8]
ld1sh   {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ld1sh   {z21.d}, p5/z, [x10, z21.d, uxtw]
fcmla   z0.h, z0.h, z0.h[0], #0
//CHECK: fcmla   z0.h, z0.h, z0.h[0], #0
fcmne   p5.d, p5/z, z10.d, z21.d
//CHECK: fcmne   p5.d, p5/z, z10.d, z21.d
fcmeq   p7.s, p3/z, z13.s, #0.0
//CHECK: fcmeq   p7.s, p3/z, z13.s, #0.0
mov     z0.d, d0
//CHECK: mov     z0.d, d0
ld1rqd  {z21.d}, p5/z, [x10, #80]
//CHECK: ld1rqd  {z21.d}, p5/z, [x10, #80]
lasta   d23, p3, z13.d
//CHECK: lasta   d23, p3, z13.d
cmpeq   p5.d, p5/z, z10.d, z21.d
//CHECK: cmpeq   p5.d, p5/z, z10.d, z21.d
fmsb    z0.h, p0/m, z0.h, z0.h
//CHECK: fmsb    z0.h, p0/m, z0.h, z0.h
ld3w    {z31.s, z0.s, z1.s}, p7/z, [sp, #-3, mul vl]
//CHECK: ld3w    {z31.s, z0.s, z1.s}, p7/z, [sp, #-3, mul vl]
fcmne   p0.d, p0/z, z0.d, z0.d
//CHECK: fcmne   p0.d, p0/z, z0.d, z0.d
lsl     z23.h, z13.h, z8.d
//CHECK: lsl     z23.h, z13.h, z8.d
prfh    pldl3strm, p5, [x10, #21, mul vl]
//CHECK: prfh    pldl3strm, p5, [x10, #21, mul vl]
movprfx z31.d, p7/z, z31.d
//CHECK: movprfx z31.d, p7/z, z31.d
add     z31.d, p7/m, z31.d, z0.d
//CHECK: add z31.d, p7/m, z31.d, z0.d
st4d    {z31.d, z0.d, z1.d, z2.d}, p7, [sp, #-4, mul vl]
//CHECK: st4d    {z31.d, z0.d, z1.d, z2.d}, p7, [sp, #-4, mul vl]
fmla    z0.d, z0.d, z0.d[0]
//CHECK: fmla    z0.d, z0.d, z0.d[0]
fcadd   z31.s, p7/m, z31.s, z31.s, #270
//CHECK: fcadd   z31.s, p7/m, z31.s, z31.s, #270
uqdecp  xzr, p15.b
//CHECK: uqdecp  xzr, p15.b
incp    xzr, p15.b
//CHECK: incp    xzr, p15.b
ctermne x10, x21
//CHECK: ctermne x10, x21
uqadd   z0.h, z0.h, z0.h
//CHECK: uqadd   z0.h, z0.h, z0.h
lsr     z31.s, z31.s, #1
//CHECK: lsr     z31.s, z31.s, #1
lastb   d0, p0, z0.d
//CHECK: lastb   d0, p0, z0.d
ld1sw   {z31.d}, p7/z, [z31.d, #124]
//CHECK: ld1sw   {z31.d}, p7/z, [z31.d, #124]
orr     z21.d, z10.d, z21.d
//CHECK: orr     z21.d, z10.d, z21.d
cmphi   p5.b, p5/z, z10.b, z21.d
//CHECK: cmphi   p5.b, p5/z, z10.b, z21.d
uqincb  x23, vl256, mul #9
//CHECK: uqincb  x23, vl256, mul #9
ldff1w  {z0.s}, p0/z, [x0, z0.s, sxtw #2]
//CHECK: ldff1w  {z0.s}, p0/z, [x0, z0.s, sxtw #2]
uqadd   z31.h, z31.h, z31.h
//CHECK: uqadd   z31.h, z31.h, z31.h
addvl   x21, x21, #-22
//CHECK: addvl   x21, x21, #-22
asrr    z31.h, p7/m, z31.h, z31.h
//CHECK: asrr    z31.h, p7/m, z31.h, z31.h
decd    z31.d, all, mul #16
//CHECK: decd    z31.d, all, mul #16
whilelt p7.d, w13, w8
//CHECK: whilelt p7.d, w13, w8
ldnf1h  {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1h  {z31.s}, p7/z, [sp, #-1, mul vl]
uaddv   d31, p7, z31.h
//CHECK: uaddv   d31, p7, z31.h
ldff1w  {z23.d}, p3/z, [z13.d, #32]
//CHECK: ldff1w  {z23.d}, p3/z, [z13.d, #32]
ld1h    {z31.h}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1h    {z31.h}, p7/z, [sp, #-1, mul vl]
ldff1sh {z21.s}, p5/z, [x10, x21, lsl #1]
//CHECK: ldff1sh {z21.s}, p5/z, [x10, x21, lsl #1]
cmpls   p0.h, p0/z, z0.h, z0.d
//CHECK: cmpls   p0.h, p0/z, z0.h, z0.d
mla     z31.b, p7/m, z31.b, z31.b
//CHECK: mla     z31.b, p7/m, z31.b, z31.b
mov     z21.h, p5/m, h10
//CHECK: mov     z21.h, p5/m, h10
fmov    z0.h, p0/m, #2.0
//CHECK: fmov    z0.h, p0/m, #2.0
ld1sh   {z0.d}, p0/z, [x0, z0.d, uxtw #1]
//CHECK: ld1sh   {z0.d}, p0/z, [x0, z0.d, uxtw #1]
clastb  s21, p5, s21, z10.s
//CHECK: clastb  s21, p5, s21, z10.s
fdivr   z31.d, p7/m, z31.d, z31.d
//CHECK: fdivr   z31.d, p7/m, z31.d, z31.d
st1h    {z21.s}, p5, [x10, z21.s, sxtw]
//CHECK: st1h    {z21.s}, p5, [x10, z21.s, sxtw]
ldnf1sw {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1sw {z21.d}, p5/z, [x10, #5, mul vl]
uqincb  w0, pow2
//CHECK: uqincb  w0, pow2
ld1rqb  {z21.b}, p5/z, [x10, #80]
//CHECK: ld1rqb  {z21.b}, p5/z, [x10, #80]
sqdecp  x23, p13.d, w23
//CHECK: sqdecp  x23, p13.d, w23
asr     z21.h, z10.h, z21.d
//CHECK: asr     z21.h, z10.h, z21.d
sqsub   z23.d, z23.d, #109, lsl #8
//CHECK: sqsub   z23.d, z23.d, #27904
adr     z31.d, [z31.d, z31.d, uxtw]
//CHECK: adr     z31.d, [z31.d, z31.d, uxtw]
index   z31.s, #-1, wzr
//CHECK: index   z31.s, #-1, wzr
umax    z0.h, z0.h, #0
//CHECK: umax    z0.h, z0.h, #0
ld2w    {z0.s, z1.s}, p0/z, [x0, x0, lsl #2]
//CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0, x0, lsl #2]
rev     p7.h, p13.h
//CHECK: rev     p7.h, p13.h
fsub    z21.h, z10.h, z21.h
//CHECK: fsub    z21.h, z10.h, z21.h
fmaxnmv h31, p7, z31.h
//CHECK: fmaxnmv h31, p7, z31.h
frecpx  z31.h, p7/m, z31.h
//CHECK: frecpx  z31.h, p7/m, z31.h
fmin    z23.d, p3/m, z23.d, #1.0
//CHECK: fmin    z23.d, p3/m, z23.d, #1.0
udiv    z0.d, p0/m, z0.d, z0.d
//CHECK: udiv    z0.d, p0/m, z0.d, z0.d
lsl     z21.s, z10.s, z21.d
//CHECK: lsl     z21.s, z10.s, z21.d
uqdecp  z23.h, p13
//CHECK: uqdecp  z23.h, p13
sqincp  x0, p0.h, w0
//CHECK: sqincp  x0, p0.h, w0
trn2    p15.h, p15.h, p15.h
//CHECK: trn2    p15.h, p15.h, p15.h
st2w    {z21.s, z22.s}, p5, [x10, #10, mul vl]
//CHECK: st2w    {z21.s, z22.s}, p5, [x10, #10, mul vl]
clastb  x21, p5, x21, z10.d
//CHECK: clastb  x21, p5, x21, z10.d
whilelo p5.d, w10, w21
//CHECK: whilelo p5.d, w10, w21
fmla    z0.s, z0.s, z0.s[0]
//CHECK: fmla    z0.s, z0.s, z0.s[0]
clasta  z0.s, p0, z0.s, z0.s
//CHECK: clasta  z0.s, p0, z0.s, z0.s
cntp    xzr, p15, p15.s
//CHECK: cntp    xzr, p15, p15.s
mul     z0.b, z0.b, #0
//CHECK: mul     z0.b, z0.b, #0
fmul    z23.s, z13.s, z8.s
//CHECK: fmul    z23.s, z13.s, z8.s
add     z0.s, p0/m, z0.s, z0.s
//CHECK: add     z0.s, p0/m, z0.s, z0.s
prfd    pldl1keep, p0, [z0.d]
//CHECK: prfd    pldl1keep, p0, [z0.d]
trn1    z0.d, z0.d, z0.d
//CHECK: trn1    z0.d, z0.d, z0.d
fmaxnmv d23, p3, z13.d
//CHECK: fmaxnmv d23, p3, z13.d
cmple   p15.b, p7/z, z31.b, z31.d
//CHECK: cmple   p15.b, p7/z, z31.b, z31.d
ldff1b  {z0.s}, p0/z, [x0, z0.s, sxtw]
//CHECK: ldff1b  {z0.s}, p0/z, [x0, z0.s, sxtw]
neg     z21.s, p5/m, z10.s
//CHECK: neg     z21.s, p5/m, z10.s
decp    z31.d, p15
//CHECK: decp    z31.d, p15
cmpge   p15.d, p7/z, z31.d, #-1
//CHECK: cmpge   p15.d, p7/z, z31.d, #-1
fmov    z31.s, p15/m, #-1.9375
//CHECK: fmov    z31.s, p15/m, #-1.9375
smulh   z31.h, p7/m, z31.h, z31.h
//CHECK: smulh   z31.h, p7/m, z31.h, z31.h
ld1h    {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ld1h    {z21.s}, p5/z, [x10, #5, mul vl]
neg     z23.d, p3/m, z13.d
//CHECK: neg     z23.d, p3/m, z13.d
ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw]
lsr     z23.d, p3/m, z23.d, #19
//CHECK: lsr     z23.d, p3/m, z23.d, #19
fcmne   p5.h, p5/z, z10.h, #0.0
//CHECK: fcmne   p5.h, p5/z, z10.h, #0.0
fnmla   z23.s, p3/m, z13.s, z8.s
//CHECK: fnmla   z23.s, p3/m, z13.s, z8.s
smaxv   h23, p3, z13.h
//CHECK: smaxv   h23, p3, z13.h
uqdecp  x0, p0.b
//CHECK: uqdecp  x0, p0.b
cmpge   p5.h, p5/z, z10.h, z21.d
//CHECK: cmpge   p5.h, p5/z, z10.h, z21.d
cmple   p5.b, p5/z, z10.b, #-11
//CHECK: cmple   p5.b, p5/z, z10.b, #-11
ld2d    {z5.d, z6.d}, p3/z, [x17, x16, lsl #3]
//CHECK: ld2d    {z5.d, z6.d}, p3/z, [x17, x16, lsl #3]
whilelo p15.h, xzr, xzr
//CHECK: whilelo p15.h, xzr, xzr
tbl     z21.d, {z10.d}, z21.d
//CHECK: tbl     z21.d, {z10.d}, z21.d
subr    z21.h, z21.h, #170
//CHECK: subr    z21.h, z21.h, #170
fmax    z21.s, p5/m, z21.s, z10.s
//CHECK: fmax    z21.s, p5/m, z21.s, z10.s
lsr     z21.b, p5/m, z21.b, z10.d
//CHECK: lsr     z21.b, p5/m, z21.b, z10.d
ld1sh   {z31.s}, p7/z, [sp, z31.s, uxtw]
//CHECK: ld1sh   {z31.s}, p7/z, [sp, z31.s, uxtw]
and     z23.s, p3/m, z23.s, z13.s
//CHECK: and     z23.s, p3/m, z23.s, z13.s
cmplt   p7.h, p3/z, z13.h, #8
//CHECK: cmplt   p7.h, p3/z, z13.h, #8
fmaxnm  z21.h, p5/m, z21.h, z10.h
//CHECK: fmaxnm  z21.h, p5/m, z21.h, z10.h
rev     p15.s, p15.s
//CHECK: rev     p15.s, p15.s
udivr   z21.s, p5/m, z21.s, z10.s
//CHECK: udivr   z21.s, p5/m, z21.s, z10.s
ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw]
//CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw]
eorv    h23, p3, z13.h
//CHECK: eorv    h23, p3, z13.h
fcmla   z31.h, p7/m, z31.h, z31.h, #270
//CHECK: fcmla   z31.h, p7/m, z31.h, z31.h, #270
clastb  z0.d, p0, z0.d, z0.d
//CHECK: clastb  z0.d, p0, z0.d, z0.d
add     z5.b, z5.b, #113
//CHECK: add     z5.b, z5.b, #113
eor     z23.d, z13.d, z8.d
//CHECK: eor     z23.d, z13.d, z8.d
insr    z21.h, h10
//CHECK: insr    z21.h, h10
st1h    {z21.d}, p5, [x10, z21.d, lsl #1]
//CHECK: st1h    {z21.d}, p5, [x10, z21.d, lsl #1]
lastb   xzr, p7, z31.d
//CHECK: lastb   xzr, p7, z31.d
mov     z31.h, #-1, lsl #8
//CHECK: mov     z31.h, #-256
lastb   b0, p0, z0.b
//CHECK: lastb   b0, p0, z0.b
fcmlt   p0.h, p0/z, z0.h, #0.0
//CHECK: fcmlt   p0.h, p0/z, z0.h, #0.0
saddv   d0, p0, z0.h
//CHECK: saddv   d0, p0, z0.h
eor     z21.b, p5/m, z21.b, z10.b
//CHECK: eor     z21.b, p5/m, z21.b, z10.b
fsqrt   z31.d, p7/m, z31.d
//CHECK: fsqrt   z31.d, p7/m, z31.d
frsqrte z0.h, z0.h
//CHECK: frsqrte z0.h, z0.h
ftssel  z23.h, z13.h, z8.h
//CHECK: ftssel  z23.h, z13.h, z8.h
fneg    z23.h, p3/m, z13.h
//CHECK: fneg    z23.h, p3/m, z13.h
zip2    p15.d, p15.d, p15.d
//CHECK: zip2    p15.d, p15.d, p15.d
adr     z23.d, [z13.d, z8.d, sxtw]
//CHECK: adr     z23.d, [z13.d, z8.d, sxtw]
st1w    {z23.s}, p3, [x13, z8.s, uxtw]
//CHECK: st1w    {z23.s}, p3, [x13, z8.s, uxtw]
ld1sb   {z23.h}, p3/z, [x13, x8]
//CHECK: ld1sb   {z23.h}, p3/z, [x13, x8]
stnt1b  {z31.b}, p7, [sp, #-1, mul vl]
//CHECK: stnt1b  {z31.b}, p7, [sp, #-1, mul vl]
fmin    z31.h, p7/m, z31.h, #1.0
//CHECK: fmin    z31.h, p7/m, z31.h, #1.0
ld1h    {z31.s}, p7/z, [sp, z31.s, sxtw]
//CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, sxtw]
adr     z0.d, [z0.d, z0.d, uxtw #2]
//CHECK: adr     z0.d, [z0.d, z0.d, uxtw #2]
trn2    p0.s, p0.s, p0.s
//CHECK: trn2    p0.s, p0.s, p0.s
ctermeq x0, x0
//CHECK: ctermeq x0, x0
fmaxnm  z31.s, p7/m, z31.s, #1.0
//CHECK: fmaxnm  z31.s, p7/m, z31.s, #1.0
ld1sw   {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ld1sw   {z21.d}, p5/z, [x10, #5, mul vl]
add     z23.b, z13.b, z8.b
//CHECK: add     z23.b, z13.b, z8.b
andv    s21, p5, z10.s
//CHECK: andv    s21, p5, z10.s
addvl   x23, x8, #-19
//CHECK: addvl   x23, x8, #-19
frecpe  z21.h, z10.h
//CHECK: frecpe  z21.h, z10.h
ucvtf   z0.s, p0/m, z0.s
//CHECK: ucvtf   z0.s, p0/m, z0.s
cmpls   p15.b, p7/z, z31.b, #127
//CHECK: cmpls   p15.b, p7/z, z31.b, #127
cntw    x21, vl32, mul #6
//CHECK: cntw    x21, vl32, mul #6
prfw    #7, p3, [x13, #8, mul vl]
//CHECK: prfw    #7, p3, [x13, #8, mul vl]
clastb  z0.s, p0, z0.s, z0.s
//CHECK: clastb  z0.s, p0, z0.s, z0.s
fcvtzu  z31.d, p7/m, z31.h
//CHECK: fcvtzu  z31.d, p7/m, z31.h
sqdecb  x21, w21, vl32, mul #6
//CHECK: sqdecb  x21, w21, vl32, mul #6
mad     z0.s, p0/m, z0.s, z0.s
//CHECK: mad     z0.s, p0/m, z0.s, z0.s
ld1w    {z21.s}, p5/z, [x10, z21.s, sxtw #2]
//CHECK: ld1w    {z21.s}, p5/z, [x10, z21.s, sxtw #2]
sdot    z23.d, z13.h, z8.h
//CHECK: sdot    z23.d, z13.h, z8.h
movprfx z31.b, p7/z, z31.b
//CHECK: movprfx z31.b, p7/z, z31.b
add     z31.b, p7/m, z31.b, z0.b
//CHECK: add z31.b, p7/m, z31.b, z0.b
fmulx   z31.h, p7/m, z31.h, z31.h
//CHECK: fmulx   z31.h, p7/m, z31.h, z31.h
smax    z23.s, z23.s, #109
//CHECK: smax    z23.s, z23.s, #109
zip1    p5.d, p10.d, p5.d
//CHECK: zip1    p5.d, p10.d, p5.d
add     z0.d, z0.d, z0.d
//CHECK: add     z0.d, z0.d, z0.d
sub     z23.d, p3/m, z23.d, z13.d
//CHECK: sub     z23.d, p3/m, z23.d, z13.d
uqincb  w21, vl32, mul #6
//CHECK: uqincb  w21, vl32, mul #6
bic     z21.s, p5/m, z21.s, z10.s
//CHECK: bic     z21.s, p5/m, z21.s, z10.s
trn1    z21.s, z10.s, z21.s
//CHECK: trn1    z21.s, z10.s, z21.s
cmphs   p5.b, p5/z, z10.b, #85
//CHECK: cmphs   p5.b, p5/z, z10.b, #85
st1b    {z21.s}, p5, [z10.s, #21]
//CHECK: st1b    {z21.s}, p5, [z10.s, #21]
sdiv    z31.s, p7/m, z31.s, z31.s
//CHECK: sdiv    z31.s, p7/m, z31.s, z31.s
fscale  z0.d, p0/m, z0.d, z0.d
//CHECK: fscale  z0.d, p0/m, z0.d, z0.d
frintz  z21.s, p5/m, z10.s
//CHECK: frintz  z21.s, p5/m, z10.s
ldff1b  {z31.s}, p7/z, [z31.s, #31]
//CHECK: ldff1b  {z31.s}, p7/z, [z31.s, #31]
movprfx z23.s, p3/z, z13.s
//CHECK: movprfx z23.s, p3/z, z13.s
add     z23.s, p3/m, z23.s, z24.s
//CHECK: add z23.s, p3/m, z23.s, z24.s
whilele p15.s, wzr, wzr
//CHECK: whilele p15.s, wzr, wzr
index   z21.d, #10, x21
//CHECK: index   z21.d, #10, x21
ld1w    {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ld1w    {z23.d}, p3/z, [x13, z8.d, sxtw]
scvtf   z0.h, p0/m, z0.h
//CHECK: scvtf   z0.h, p0/m, z0.h
prfb    pldl1keep, p0, [z0.s]
//CHECK: prfb    pldl1keep, p0, [z0.s]
mul     z31.h, p7/m, z31.h, z31.h
//CHECK: mul     z31.h, p7/m, z31.h, z31.h
sqincd  x23, vl256, mul #9
//CHECK: sqincd  x23, vl256, mul #9
lsl     z31.s, p7/m, z31.s, z31.s
//CHECK: lsl     z31.s, p7/m, z31.s, z31.s
asr     z0.s, p0/m, z0.s, z0.s
//CHECK: asr     z0.s, p0/m, z0.s, z0.s
ldnf1sh {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1sh {z21.s}, p5/z, [x10, #5, mul vl]
fadd    z0.d, p0/m, z0.d, #0.5
//CHECK: fadd    z0.d, p0/m, z0.d, #0.5
abs     z0.h, p0/m, z0.h
//CHECK: abs     z0.h, p0/m, z0.h
ld4w    {z23.s, z24.s, z25.s, z26.s}, p3/z, [x13, #-32, mul vl]
//CHECK: ld4w    {z23.s, z24.s, z25.s, z26.s}, p3/z, [x13, #-32, mul vl]
adr     z31.d, [z31.d, z31.d, uxtw #2]
//CHECK: adr     z31.d, [z31.d, z31.d, uxtw #2]
ld1h    {z31.d}, p7/z, [sp, z31.d]
//CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d]
ldff1h  {z21.d}, p5/z, [x10, z21.d, uxtw #1]
//CHECK: ldff1h  {z21.d}, p5/z, [x10, z21.d, uxtw #1]
ld1sh   {z0.d}, p0/z, [x0, z0.d]
//CHECK: ld1sh   {z0.d}, p0/z, [x0, z0.d]
ld1b    {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ld1b    {z21.s}, p5/z, [x10, #5, mul vl]
ldff1h  {z31.s}, p7/z, [sp, z31.s, sxtw #1]
//CHECK: ldff1h  {z31.s}, p7/z, [sp, z31.s, sxtw #1]
ld1h    {z31.d}, p7/z, [z31.d, #62]
//CHECK: ld1h    {z31.d}, p7/z, [z31.d, #62]
sabd    z0.s, p0/m, z0.s, z0.s
//CHECK: sabd    z0.s, p0/m, z0.s, z0.s
mad     z23.b, p3/m, z8.b, z13.b
//CHECK: mad     z23.b, p3/m, z8.b, z13.b
clastb  z23.s, p3, z23.s, z13.s
//CHECK: clastb  z23.s, p3, z23.s, z13.s
movprfx z21.d, p5/z, z10.d
//CHECK: movprfx z21.d, p5/z, z10.d
add     z21.d, p5/m, z21.d, z22.d
//CHECK: add z21.d, p5/m, z21.d, z22.d
smax    z0.b, z0.b, #0
//CHECK: smax    z0.b, z0.b, #0
cmplt   p7.h, p3/z, z13.h, z8.d
//CHECK: cmplt   p7.h, p3/z, z13.h, z8.d
lsr     z21.s, z10.s, #11
//CHECK: lsr     z21.s, z10.s, #11
smax    z21.d, z21.d, #-86
//CHECK: smax    z21.d, z21.d, #-86
sqsub   z5.b, z5.b, #113
//CHECK: sqsub   z5.b, z5.b, #113
st1h    {z31.d}, p7, [sp, z31.d, sxtw #1]
//CHECK: st1h    {z31.d}, p7, [sp, z31.d, sxtw #1]
frsqrte z0.s, z0.s
//CHECK: frsqrte z0.s, z0.s
uminv   b21, p5, z10.b
//CHECK: uminv   b21, p5, z10.b
lsr     z21.b, z10.b, z21.d
//CHECK: lsr     z21.b, z10.b, z21.d
rbit    z23.b, p3/m, z13.b
//CHECK: rbit    z23.b, p3/m, z13.b
fcmlt   p15.d, p7/z, z31.d, #0.0
//CHECK: fcmlt   p15.d, p7/z, z31.d, #0.0
lsr     z0.b, p0/m, z0.b, z0.d
//CHECK: lsr     z0.b, p0/m, z0.b, z0.d
rev     p5.d, p10.d
//CHECK: rev     p5.d, p10.d
umax    z0.h, p0/m, z0.h, z0.h
//CHECK: umax    z0.h, p0/m, z0.h, z0.h
st1d    {z31.d}, p7, [sp, z31.d, lsl #3]
//CHECK: st1d    {z31.d}, p7, [sp, z31.d, lsl #3]
fabs    z23.d, p3/m, z13.d
//CHECK: fabs    z23.d, p3/m, z13.d
ldff1b  {z23.d}, p3/z, [x13, x8]
//CHECK: ldff1b  {z23.d}, p3/z, [x13, x8]
ucvtf   z21.h, p5/m, z10.h
//CHECK: ucvtf   z21.h, p5/m, z10.h
ld4d    {z23.d, z24.d, z25.d, z26.d}, p3/z, [x13, x8, lsl #3]
//CHECK: ld4d    {z23.d, z24.d, z25.d, z26.d}, p3/z, [x13, x8, lsl #3]
prfd    pldl3strm, p5, [x10, z21.d, uxtw #3]
//CHECK: prfd    pldl3strm, p5, [x10, z21.d, uxtw #3]
mov     z31.h, z31.h[31]
//CHECK: mov     z31.h, z31.h[31]
cmpne   p0.s, p0/z, z0.s, z0.d
//CHECK: cmpne   p0.s, p0/z, z0.s, z0.d
clasta  b23, p3, b23, z13.b
//CHECK: clasta  b23, p3, b23, z13.b
index   z21.b, w10, #-11
//CHECK: index   z21.b, w10, #-11
trn2    z23.d, z13.d, z8.d
//CHECK: trn2    z23.d, z13.d, z8.d
ld1sw   {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ld1sw   {z23.d}, p3/z, [x13, z8.d, uxtw]
fnmsb   z31.s, p7/m, z31.s, z31.s
//CHECK: fnmsb   z31.s, p7/m, z31.s, z31.s
lsl     z23.d, z13.d, #40
//CHECK: lsl     z23.d, z13.d, #40
msb     z21.s, p5/m, z21.s, z10.s
//CHECK: msb     z21.s, p5/m, z21.s, z10.s
st4b    {z31.b, z0.b, z1.b, z2.b}, p7, [sp, #-4, mul vl]
//CHECK: st4b    {z31.b, z0.b, z1.b, z2.b}, p7, [sp, #-4, mul vl]
ld1d    {z0.d}, p0/z, [x0, z0.d]
//CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d]
fsubr   z31.s, p7/m, z31.s, #1.0
//CHECK: fsubr   z31.s, p7/m, z31.s, #1.0
lastb   w23, p3, z13.b
//CHECK: lastb   w23, p3, z13.b
ld3w    {z5.s, z6.s, z7.s}, p3/z, [x17, x16, lsl #2]
//CHECK: ld3w    {z5.s, z6.s, z7.s}, p3/z, [x17, x16, lsl #2]
ucvtf   z31.h, p7/m, z31.h
//CHECK: ucvtf   z31.h, p7/m, z31.h
umulh   z31.s, p7/m, z31.s, z31.s
//CHECK: umulh   z31.s, p7/m, z31.s, z31.s
fabd    z0.s, p0/m, z0.s, z0.s
//CHECK: fabd    z0.s, p0/m, z0.s, z0.s
frintn  z31.h, p7/m, z31.h
//CHECK: frintn  z31.h, p7/m, z31.h
ldff1sb {z21.h}, p5/z, [x10, x21]
//CHECK: ldff1sb {z21.h}, p5/z, [x10, x21]
zip1    p15.b, p15.b, p15.b
//CHECK: zip1    p15.b, p15.b, p15.b
ldff1d  {z0.d}, p0/z, [x0, x0, lsl #3]
//CHECK: ldff1d  {z0.d}, p0/z, [x0, x0, lsl #3]
fabd    z23.d, p3/m, z23.d, z13.d
//CHECK: fabd    z23.d, p3/m, z23.d, z13.d
orrs    p5.b, p5/z, p10.b, p5.b
//CHECK: orrs    p5.b, p5/z, p10.b, p5.b
uqincp  w21, p10.s
//CHECK: uqincp  w21, p10.s
ld1rqd  {z0.d}, p0/z, [x0]
//CHECK: ld1rqd  {z0.d}, p0/z, [x0]
sdiv    z21.s, p5/m, z21.s, z10.s
//CHECK: sdiv    z21.s, p5/m, z21.s, z10.s
sunpkhi z21.s, z10.h
//CHECK: sunpkhi z21.s, z10.h
rbit    z21.d, p5/m, z10.d
//CHECK: rbit    z21.d, p5/m, z10.d
uqdech  x21, vl32, mul #6
//CHECK: uqdech  x21, vl32, mul #6
cmpgt   p5.h, p5/z, z10.h, #-11
//CHECK: cmpgt   p5.h, p5/z, z10.h, #-11
clz     z21.s, p5/m, z10.s
//CHECK: clz     z21.s, p5/m, z10.s
ld2d    {z0.d, z1.d}, p0/z, [x0, x0, lsl #3]
//CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0, x0, lsl #3]
umin    z21.d, p5/m, z21.d, z10.d
//CHECK: umin    z21.d, p5/m, z21.d, z10.d
lsl     z0.h, z0.h, #0
//CHECK: lsl     z0.h, z0.h, #0
sub     z23.s, z13.s, z8.s
//CHECK: sub     z23.s, z13.s, z8.s
dech    z21.h, vl32, mul #6
//CHECK: dech    z21.h, vl32, mul #6
sxtb    z0.h, p0/m, z0.h
//CHECK: sxtb    z0.h, p0/m, z0.h
frecpe  z0.h, z0.h
//CHECK: frecpe  z0.h, z0.h
ldff1sb {z23.h}, p3/z, [x13, x8]
//CHECK: ldff1sb {z23.h}, p3/z, [x13, x8]
cnot    z21.h, p5/m, z10.h
//CHECK: cnot    z21.h, p5/m, z10.h
ld1sb   {z0.h}, p0/z, [x0]
//CHECK: ld1sb   {z0.h}, p0/z, [x0]
cmpne   p5.s, p5/z, z10.s, #-11
//CHECK: cmpne   p5.s, p5/z, z10.s, #-11
fmaxv   s23, p3, z13.s
//CHECK: fmaxv   s23, p3, z13.s
index   z31.d, #-1, #-1
//CHECK: index   z31.d, #-1, #-1
cls     z23.d, p3/m, z13.d
//CHECK: cls     z23.d, p3/m, z13.d
cmpne   p5.s, p5/z, z10.s, z21.s
//CHECK: cmpne   p5.s, p5/z, z10.s, z21.s
prfh    #15, p7, [sp, z31.d, sxtw #1]
//CHECK: prfh    #15, p7, [sp, z31.d, sxtw #1]
mul     z31.h, z31.h, #-1
//CHECK: mul     z31.h, z31.h, #-1
uabd    z23.b, p3/m, z23.b, z13.b
//CHECK: uabd    z23.b, p3/m, z23.b, z13.b
st1w    {z31.s}, p7, [sp, #-1, mul vl]
//CHECK: st1w    {z31.s}, p7, [sp, #-1, mul vl]
cmplt   p15.s, p7/z, z31.s, z31.d
//CHECK: cmplt   p15.s, p7/z, z31.s, z31.d
ld1h    {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, sxtw]
prfd    #7, p3, [z13.d, #64]
//CHECK: prfd    #7, p3, [z13.d, #64]
fmulx   z21.h, p5/m, z21.h, z10.h
//CHECK: fmulx   z21.h, p5/m, z21.h, z10.h
prfw    #7, p3, [x13, z8.d, uxtw #2]
//CHECK: prfw    #7, p3, [x13, z8.d, uxtw #2]
decp    x21, p10.h
//CHECK: decp    x21, p10.h
uqincw  x21, vl32, mul #6
//CHECK: uqincw  x21, vl32, mul #6
incw    x21, vl32, mul #6
//CHECK: incw    x21, vl32, mul #6
decp    z23.h, p13
//CHECK: decp    z23.h, p13
ldff1b  {z21.d}, p5/z, [x10, z21.d]
//CHECK: ldff1b  {z21.d}, p5/z, [x10, z21.d]
cntp    x21, p5, p10.s
//CHECK: cntp    x21, p5, p10.s
ldnt1h  {z23.h}, p3/z, [x13, x8, lsl #1]
//CHECK: ldnt1h  {z23.h}, p3/z, [x13, x8, lsl #1]
ldff1sb {z23.d}, p3/z, [x13, z8.d]
//CHECK: ldff1sb {z23.d}, p3/z, [x13, z8.d]
ld1w    {z21.s}, p5/z, [x10, z21.s, uxtw #2]
//CHECK: ld1w    {z21.s}, p5/z, [x10, z21.s, uxtw #2]
stnt1h  {z0.h}, p0, [x0, x0, lsl #1]
//CHECK: stnt1h  {z0.h}, p0, [x0, x0, lsl #1]
zip2    z21.b, z10.b, z21.b
//CHECK: zip2    z21.b, z10.b, z21.b
cmpgt   p0.s, p0/z, z0.s, #0
//CHECK: cmpgt   p0.s, p0/z, z0.s, #0
cmpge   p5.b, p5/z, z10.b, z21.d
//CHECK: cmpge   p5.b, p5/z, z10.b, z21.d
st1b    {z21.d}, p5, [x10, z21.d, uxtw]
//CHECK: st1b    {z21.d}, p5, [x10, z21.d, uxtw]
adr     z0.d, [z0.d, z0.d, lsl #2]
//CHECK: adr     z0.d, [z0.d, z0.d, lsl #2]
ld1d    {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1d    {z31.d}, p7/z, [sp, #-1, mul vl]
lsr     z31.d, z31.d, #1
//CHECK: lsr     z31.d, z31.d, #1
nors    p15.b, p15/z, p15.b, p15.b
//CHECK: nors    p15.b, p15/z, p15.b, p15.b
st1b    {z0.s}, p0, [x0, z0.s, uxtw]
//CHECK: st1b    {z0.s}, p0, [x0, z0.s, uxtw]
nands   p5.b, p5/z, p10.b, p5.b
//CHECK: nands   p5.b, p5/z, p10.b, p5.b
ld1w    {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ld1w    {z0.d}, p0/z, [x0, z0.d, uxtw]
ld1rqh  {z21.h}, p5/z, [x10, x21, lsl #1]
//CHECK: ld1rqh  {z21.h}, p5/z, [x10, x21, lsl #1]
ftmad   z21.d, z21.d, z10.d, #5
//CHECK: ftmad   z21.d, z21.d, z10.d, #5
ldnf1h  {z0.s}, p0/z, [x0]
//CHECK: ldnf1h  {z0.s}, p0/z, [x0]
mul     z31.d, p7/m, z31.d, z31.d
//CHECK: mul     z31.d, p7/m, z31.d, z31.d
clastb  wzr, p7, wzr, z31.b
//CHECK: clastb  wzr, p7, wzr, z31.b
cmphi   p5.h, p5/z, z10.h, z21.d
//CHECK: cmphi   p5.h, p5/z, z10.h, z21.d
clasta  z31.d, p7, z31.d, z31.d
//CHECK: clasta  z31.d, p7, z31.d, z31.d
whilele p5.h, x10, x21
//CHECK: whilele p5.h, x10, x21
cmple   p15.d, p7/z, z31.d, #-1
//CHECK: cmple   p15.d, p7/z, z31.d, #-1
uqinch  z31.h, all, mul #16
//CHECK: uqinch  z31.h, all, mul #16
orn     p0.b, p0/z, p0.b, p0.b
//CHECK: orn     p0.b, p0/z, p0.b, p0.b
not     z0.s, p0/m, z0.s
//CHECK: not     z0.s, p0/m, z0.s
add     z0.d, z0.d, #0
//CHECK: add     z0.d, z0.d, #0
revh    z31.s, p7/m, z31.s
//CHECK: revh    z31.s, p7/m, z31.s
fnmls   z0.s, p0/m, z0.s, z0.s
//CHECK: fnmls   z0.s, p0/m, z0.s, z0.s
prfd    pldl3strm, p5, [x10, z21.s, sxtw #3]
//CHECK: prfd    pldl3strm, p5, [x10, z21.s, sxtw #3]
ld1h    {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ld1h    {z21.d}, p5/z, [x10, #5, mul vl]
fmul    z31.d, p7/m, z31.d, #2.0
//CHECK: fmul    z31.d, p7/m, z31.d, #2.0
uqsub   z31.h, z31.h, z31.h
//CHECK: uqsub   z31.h, z31.h, z31.h
ld1sw   {z31.d}, p7/z, [sp, z31.d, lsl #2]
//CHECK: ld1sw   {z31.d}, p7/z, [sp, z31.d, lsl #2]
mov     z23.s, p3/m, w13
//CHECK: mov     z23.s, p3/m, w13
st1b    {z23.s}, p3, [x13, z8.s, uxtw]
//CHECK: st1b    {z23.s}, p3, [x13, z8.s, uxtw]
st2w    {z31.s, z0.s}, p7, [sp, #-2, mul vl]
//CHECK: st2w    {z31.s, z0.s}, p7, [sp, #-2, mul vl]
faddv   d23, p3, z13.d
//CHECK: faddv   d23, p3, z13.d
frinta  z0.s, p0/m, z0.s
//CHECK: frinta  z0.s, p0/m, z0.s
orv     d0, p0, z0.d
//CHECK: orv     d0, p0, z0.d
decp    x23, p13.s
//CHECK: decp    x23, p13.s
st1w    {z23.d}, p3, [x13, #-8, mul vl]
//CHECK: st1w    {z23.d}, p3, [x13, #-8, mul vl]
fmov    z0.s, p0/m, #2.0
//CHECK: fmov    z0.s, p0/m, #2.0
cmpeq   p7.b, p3/z, z13.b, #8
//CHECK: cmpeq   p7.b, p3/z, z13.b, #8
fcmuo   p5.h, p5/z, z10.h, z21.h
//CHECK: fcmuo   p5.h, p5/z, z10.h, z21.h
mov     z23.d, p3/m, d13
//CHECK: mov     z23.d, p3/m, d13
fmad    z23.h, p3/m, z13.h, z8.h
//CHECK: fmad    z23.h, p3/m, z13.h, z8.h
bic     z21.b, p5/m, z21.b, z10.b
//CHECK: bic     z21.b, p5/m, z21.b, z10.b
sdiv    z31.d, p7/m, z31.d, z31.d
//CHECK: sdiv    z31.d, p7/m, z31.d, z31.d
sqdecp  x23, p13.s, w23
//CHECK: sqdecp  x23, p13.s, w23
st1h    {z0.s}, p0, [x0, z0.s, sxtw #1]
//CHECK: st1h    {z0.s}, p0, [x0, z0.s, sxtw #1]
fmul    z21.h, p5/m, z21.h, z10.h
//CHECK: fmul    z21.h, p5/m, z21.h, z10.h
cmpge   p0.d, p0/z, z0.d, #0
//CHECK: cmpge   p0.d, p0/z, z0.d, #0
ld1h    {z0.d}, p0/z, [x0, z0.d, sxtw #1]
//CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d, sxtw #1]
ldff1h  {z31.d}, p7/z, [sp, z31.d, lsl #1]
//CHECK: ldff1h  {z31.d}, p7/z, [sp, z31.d, lsl #1]
asr     z0.d, p0/m, z0.d, #64
//CHECK: asr     z0.d, p0/m, z0.d, #64
ldff1w  {z21.s}, p5/z, [x10, x21, lsl #2]
//CHECK: ldff1w  {z21.s}, p5/z, [x10, x21, lsl #2]
ldnt1h  {z21.h}, p5/z, [x10, x21, lsl #1]
//CHECK: ldnt1h  {z21.h}, p5/z, [x10, x21, lsl #1]
whilelt p5.d, w10, w21
//CHECK: whilelt p5.d, w10, w21
ldr     p0, [x0]
//CHECK: ldr     p0, [x0]
ld1b    {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ld1b    {z31.d}, p7/z, [sp, z31.d, uxtw]
frintz  z31.s, p7/m, z31.s
//CHECK: frintz  z31.s, p7/m, z31.s
neg     z23.b, p3/m, z13.b
//CHECK: neg     z23.b, p3/m, z13.b
str     p7, [x13, #67, mul vl]
//CHECK: str     p7, [x13, #67, mul vl]
ldff1sw {z23.d}, p3/z, [x13, x8, lsl #2]
//CHECK: ldff1sw {z23.d}, p3/z, [x13, x8, lsl #2]
clastb  w21, p5, w21, z10.h
//CHECK: clastb  w21, p5, w21, z10.h
pnext   p5.b, p10, p5.b
//CHECK: pnext   p5.b, p10, p5.b
asr     z23.h, z13.h, #8
//CHECK: asr     z23.h, z13.h, #8
rdffrs  p5.b, p10/z
//CHECK: rdffrs  p5.b, p10/z
lsl     z31.s, z31.s, #31
//CHECK: lsl     z31.s, z31.s, #31
st1h    {z31.s}, p7, [sp, z31.s, uxtw]
//CHECK: st1h    {z31.s}, p7, [sp, z31.s, uxtw]
mla     z21.b, p5/m, z10.b, z21.b
//CHECK: mla     z21.b, p5/m, z10.b, z21.b
ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw #3]
//CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, uxtw #3]
fcmlt   p7.d, p3/z, z13.d, #0.0
//CHECK: fcmlt   p7.d, p3/z, z13.d, #0.0
uqdecb  xzr, all, mul #16
//CHECK: uqdecb  xzr, all, mul #16
sub     z31.b, p7/m, z31.b, z31.b
//CHECK: sub     z31.b, p7/m, z31.b, z31.b
zip1    z31.d, z31.d, z31.d
//CHECK: zip1    z31.d, z31.d, z31.d
ld1b    {z23.h}, p3/z, [x13, x8]
//CHECK: ld1b    {z23.h}, p3/z, [x13, x8]
cmpls   p5.h, p5/z, z10.h, z21.d
//CHECK: cmpls   p5.h, p5/z, z10.h, z21.d
uzp1    p15.h, p15.h, p15.h
//CHECK: uzp1    p15.h, p15.h, p15.h
orns    p7.b, p11/z, p13.b, p8.b
//CHECK: orns    p7.b, p11/z, p13.b, p8.b
adr     z0.s, [z0.s, z0.s, lsl #2]
//CHECK: adr     z0.s, [z0.s, z0.s, lsl #2]
brkns   p5.b, p5/z, p10.b, p5.b
//CHECK: brkns   p5.b, p5/z, p10.b, p5.b
ucvtf   z31.h, p7/m, z31.d
//CHECK: ucvtf   z31.h, p7/m, z31.d
abs     z31.s, p7/m, z31.s
//CHECK: abs     z31.s, p7/m, z31.s
prfh    #15, p7, [sp, z31.s, uxtw #1]
//CHECK: prfh    #15, p7, [sp, z31.s, uxtw #1]
fnmad   z23.h, p3/m, z13.h, z8.h
//CHECK: fnmad   z23.h, p3/m, z13.h, z8.h
ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw]
//CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw]
fmulx   z0.s, p0/m, z0.s, z0.s
//CHECK: fmulx   z0.s, p0/m, z0.s, z0.s
mov     z21.h, z10.h[13]
//CHECK: mov     z21.h, z10.h[13]
ldff1h  {z31.d}, p7/z, [sp, z31.d, sxtw #1]
//CHECK: ldff1h  {z31.d}, p7/z, [sp, z31.d, sxtw #1]
ldff1h  {z23.d}, p3/z, [x13, z8.d, lsl #1]
//CHECK: ldff1h  {z23.d}, p3/z, [x13, z8.d, lsl #1]
prfw    #7, p3, [x13, z8.s, sxtw #2]
//CHECK: prfw    #7, p3, [x13, z8.s, sxtw #2]
ld2b    {z21.b, z22.b}, p5/z, [x10, #10, mul vl]
//CHECK: ld2b    {z21.b, z22.b}, p5/z, [x10, #10, mul vl]
fcvt    z21.d, p5/m, z10.s
//CHECK: fcvt    z21.d, p5/m, z10.s
ldnf1b  {z23.h}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1b  {z23.h}, p3/z, [x13, #-8, mul vl]
ld1rsb  {z31.s}, p7/z, [sp, #63]
//CHECK: ld1rsb  {z31.s}, p7/z, [sp, #63]
uaddv   d23, p3, z13.h
//CHECK: uaddv   d23, p3, z13.h
mla     z0.s, p0/m, z0.s, z0.s
//CHECK: mla     z0.s, p0/m, z0.s, z0.s
ldff1w  {z21.s}, p5/z, [x10, z21.s, uxtw]
//CHECK: ldff1w  {z21.s}, p5/z, [x10, z21.s, uxtw]
ld1sh   {z0.d}, p0/z, [x0, z0.d, lsl #1]
//CHECK: ld1sh   {z0.d}, p0/z, [x0, z0.d, lsl #1]
movprfx z31, z31
//CHECK: movprfx z31, z31
add     z31.h, p7/m, z31.h, z0.h
//CHECK: add z31.h, p7/m, z31.h, z0.h
orr     z0.h, p0/m, z0.h, z0.h
//CHECK: orr     z0.h, p0/m, z0.h, z0.h
ld1d    {z31.d}, p7/z, [z31.d, #248]
//CHECK: ld1d    {z31.d}, p7/z, [z31.d, #248]
ld1sb   {z0.h}, p0/z, [x0, x0]
//CHECK: ld1sb   {z0.h}, p0/z, [x0, x0]
fdivr   z23.d, p3/m, z23.d, z13.d
//CHECK: fdivr   z23.d, p3/m, z23.d, z13.d
st4h    {z31.h, z0.h, z1.h, z2.h}, p7, [sp, #-4, mul vl]
//CHECK: st4h    {z31.h, z0.h, z1.h, z2.h}, p7, [sp, #-4, mul vl]
ldff1w  {z0.s}, p0/z, [z0.s]
//CHECK: ldff1w  {z0.s}, p0/z, [z0.s]
compact z0.s, p0, z0.s
//CHECK: compact z0.s, p0, z0.s
frinta  z23.s, p3/m, z13.s
//CHECK: frinta  z23.s, p3/m, z13.s
ld1w    {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ld1w    {z31.d}, p7/z, [sp, z31.d, sxtw]
ldff1h  {z31.s}, p7/z, [sp, z31.s, uxtw #1]
//CHECK: ldff1h  {z31.s}, p7/z, [sp, z31.s, uxtw #1]
mov     z0.h, #0
//CHECK: mov     z0.h, #0
st1w    {z0.d}, p0, [x0, z0.d]
//CHECK: st1w    {z0.d}, p0, [x0, z0.d]
uqdecw  x0, pow2
//CHECK: uqdecw  x0, pow2
st1h    {z21.d}, p5, [x10, z21.d, uxtw #1]
//CHECK: st1h    {z21.d}, p5, [x10, z21.d, uxtw #1]
uqsub   z0.s, z0.s, z0.s
//CHECK: uqsub   z0.s, z0.s, z0.s
asr     z23.b, p3/m, z23.b, z13.d
//CHECK: asr     z23.b, p3/m, z23.b, z13.d
st1h    {z0.s}, p0, [x0, z0.s, uxtw]
//CHECK: st1h    {z0.s}, p0, [x0, z0.s, uxtw]
ldnt1h  {z23.h}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnt1h  {z23.h}, p3/z, [x13, #-8, mul vl]
smulh   z21.s, p5/m, z21.s, z10.s
//CHECK: smulh   z21.s, p5/m, z21.s, z10.s
sqincp  xzr, p15.b, wzr
//CHECK: sqincp  xzr, p15.b, wzr
cmphs   p5.h, p5/z, z10.h, #85
//CHECK: cmphs   p5.h, p5/z, z10.h, #85
orr     z21.h, p5/m, z21.h, z10.h
//CHECK: orr     z21.h, p5/m, z21.h, z10.h
adr     z23.d, [z13.d, z8.d, sxtw #3]
//CHECK: adr     z23.d, [z13.d, z8.d, sxtw #3]
mla     z31.h, p7/m, z31.h, z31.h
//CHECK: mla     z31.h, p7/m, z31.h, z31.h
ldnf1h  {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1h  {z31.d}, p7/z, [sp, #-1, mul vl]
inch    z31.h, all, mul #16
//CHECK: inch    z31.h, all, mul #16
fmsb    z23.s, p3/m, z13.s, z8.s
//CHECK: fmsb    z23.s, p3/m, z13.s, z8.s
fsub    z0.d, p0/m, z0.d, z0.d
//CHECK: fsub    z0.d, p0/m, z0.d, z0.d
zip1    p15.h, p15.h, p15.h
//CHECK: zip1    p15.h, p15.h, p15.h
frecpx  z23.h, p3/m, z13.h
//CHECK: frecpx  z23.h, p3/m, z13.h
fsub    z21.d, p5/m, z21.d, z10.d
//CHECK: fsub    z21.d, p5/m, z21.d, z10.d
insr    z31.d, d31
//CHECK: insr    z31.d, d31
cmpne   p5.h, p5/z, z10.h, z21.d
//CHECK: cmpne   p5.h, p5/z, z10.h, z21.d
prfh    #7, p3, [z13.d, #16]
//CHECK: prfh    #7, p3, [z13.d, #16]
frsqrts z23.d, z13.d, z8.d
//CHECK: frsqrts z23.d, z13.d, z8.d
st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, x8, lsl #1]
//CHECK: st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, x8, lsl #1]
adr     z31.d, [z31.d, z31.d, sxtw #2]
//CHECK: adr     z31.d, [z31.d, z31.d, sxtw #2]
fmul    z0.h, z0.h, z0.h
//CHECK: fmul    z0.h, z0.h, z0.h
ld1h    {z23.d}, p3/z, [x13, x8, lsl #1]
//CHECK: ld1h    {z23.d}, p3/z, [x13, x8, lsl #1]
mov     z31.d, p7/m, sp
//CHECK: mov     z31.d, p7/m, sp
fcmge   p7.s, p3/z, z13.s, #0.0
//CHECK: fcmge   p7.s, p3/z, z13.s, #0.0
uqdecd  wzr, all, mul #16
//CHECK: uqdecd  wzr, all, mul #16
mov     z0.h, w0
//CHECK: mov     z0.h, w0
sdivr   z21.s, p5/m, z21.s, z10.s
//CHECK: sdivr   z21.s, p5/m, z21.s, z10.s
st1h    {z0.d}, p0, [x0, z0.d, sxtw]
//CHECK: st1h    {z0.d}, p0, [x0, z0.d, sxtw]
ld1sh   {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ld1sh   {z0.d}, p0/z, [x0, z0.d, sxtw]
ucvtf   z21.s, p5/m, z10.d
//CHECK: ucvtf   z21.s, p5/m, z10.d
fscale  z21.h, p5/m, z21.h, z10.h
//CHECK: fscale  z21.h, p5/m, z21.h, z10.h
mov     z0.s, p0/m, s0
//CHECK: mov     z0.s, p0/m, s0
fsqrt   z21.d, p5/m, z10.d
//CHECK: fsqrt   z21.d, p5/m, z10.d
trn2    z23.s, z13.s, z8.s
//CHECK: trn2    z23.s, z13.s, z8.s
fsubr   z21.h, p5/m, z21.h, z10.h
//CHECK: fsubr   z21.h, p5/m, z21.h, z10.h
ld2b    {z31.b, z0.b}, p7/z, [sp, #-2, mul vl]
//CHECK: ld2b    {z31.b, z0.b}, p7/z, [sp, #-2, mul vl]
whilels p7.d, w13, w8
//CHECK: whilels p7.d, w13, w8
lastb   d31, p7, z31.d
//CHECK: lastb   d31, p7, z31.d
st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, #-32, mul vl]
//CHECK: st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, #-32, mul vl]
uqsub   z23.s, z23.s, #109, lsl #8
//CHECK: uqsub   z23.s, z23.s, #27904
splice  z21.s, p5, z21.s, z10.s
//CHECK: splice  z21.s, p5, z21.s, z10.s
brkpb   p0.b, p0/z, p0.b, p0.b
//CHECK: brkpb   p0.b, p0/z, p0.b, p0.b
str     z31, [sp, #-1, mul vl]
//CHECK: str     z31, [sp, #-1, mul vl]
cmphs   p15.h, p7/z, z31.h, #127
//CHECK: cmphs   p15.h, p7/z, z31.h, #127
prfb    #15, p7, [sp, z31.d]
//CHECK: prfb    #15, p7, [sp, z31.d]
adr     z23.d, [z13.d, z8.d, uxtw #2]
//CHECK: adr     z23.d, [z13.d, z8.d, uxtw #2]
brkpas  p0.b, p0/z, p0.b, p0.b
//CHECK: brkpas  p0.b, p0/z, p0.b, p0.b
fmla    z0.s, p0/m, z0.s, z0.s
//CHECK: fmla    z0.s, p0/m, z0.s, z0.s
lslr    z23.s, p3/m, z23.s, z13.s
//CHECK: lslr    z23.s, p3/m, z23.s, z13.s
asrd    z31.b, p7/m, z31.b, #1
//CHECK: asrd    z31.b, p7/m, z31.b, #1
cmpeq   p5.h, p5/z, z10.h, z21.h
//CHECK: cmpeq   p5.h, p5/z, z10.h, z21.h
cntp    x0, p0, p0.d
//CHECK: cntp    x0, p0, p0.d
ld1w    {z5.s}, p3/z, [x17, x16, lsl #2]
//CHECK: ld1w    {z5.s}, p3/z, [x17, x16, lsl #2]
sqsub   z23.b, z13.b, z8.b
//CHECK: sqsub   z23.b, z13.b, z8.b
ldff1d  {z21.d}, p5/z, [x10, z21.d]
//CHECK: ldff1d  {z21.d}, p5/z, [x10, z21.d]
ldff1b  {z31.s}, p7/z, [sp, xzr]
//CHECK: ldff1b  {z31.s}, p7/z, [sp]
mul     z21.d, z21.d, #-86
//CHECK: mul     z21.d, z21.d, #-86
udivr   z21.d, p5/m, z21.d, z10.d
//CHECK: udivr   z21.d, p5/m, z21.d, z10.d
incp    z23.s, p13
//CHECK: incp    z23.s, p13
fmax    z31.s, p7/m, z31.s, z31.s
//CHECK: fmax    z31.s, p7/m, z31.s, z31.s
lsl     z31.d, p7/m, z31.d, z31.d
//CHECK: lsl     z31.d, p7/m, z31.d, z31.d
ld1b    {z31.s}, p7/z, [sp, z31.s, sxtw]
//CHECK: ld1b    {z31.s}, p7/z, [sp, z31.s, sxtw]
uqdecp  wzr, p15.s
//CHECK: uqdecp  wzr, p15.s
movprfx z0.h, p0/z, z0.h
//CHECK: movprfx z0.h, p0/z, z0.h
add     z0.h, p0/m, z0.h, z1.h
//CHECK: add z0.h, p0/m, z0.h, z1.h
whilele p7.d, w13, w8
//CHECK: whilele p7.d, w13, w8
fadd    z0.d, p0/m, z0.d, z0.d
//CHECK: fadd    z0.d, p0/m, z0.d, z0.d
pnext   p7.h, p13, p7.h
//CHECK: pnext   p7.h, p13, p7.h
sub     z0.h, p0/m, z0.h, z0.h
//CHECK: sub     z0.h, p0/m, z0.h, z0.h
not     z23.d, p3/m, z13.d
//CHECK: not     z23.d, p3/m, z13.d
prfb    #7, p3, [x13, x8]
//CHECK: prfb    #7, p3, [x13, x8]
ldff1b  {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ldff1b  {z31.d}, p7/z, [sp, z31.d, uxtw]
mov     z31.h, p15/z, #-1, lsl #8
//CHECK: mov     z31.h, p15/z, #-256
tbl     z31.b, {z31.b}, z31.b
//CHECK: tbl     z31.b, {z31.b}, z31.b
fnmsb   z0.d, p0/m, z0.d, z0.d
//CHECK: fnmsb   z0.d, p0/m, z0.d, z0.d
lsr     z31.h, p7/m, z31.h, z31.d
//CHECK: lsr     z31.h, p7/m, z31.h, z31.d
cmplo   p15.b, p7/z, z31.b, #127
//CHECK: cmplo   p15.b, p7/z, z31.b, #127
uzp1    p7.s, p13.s, p8.s
//CHECK: uzp1    p7.s, p13.s, p8.s
uxtb    z23.h, p3/m, z13.h
//CHECK: uxtb    z23.h, p3/m, z13.h
ld1rsb  {z31.h}, p7/z, [sp, #63]
//CHECK: ld1rsb  {z31.h}, p7/z, [sp, #63]
ext     z21.b, z21.b, z10.b, #173
//CHECK: ext     z21.b, z21.b, z10.b, #173
uqinch  w0, pow2
//CHECK: uqinch  w0, pow2
fsub    z23.d, p3/m, z23.d, #1.0
//CHECK: fsub    z23.d, p3/m, z23.d, #1.0
whilele p7.b, x13, x8
//CHECK: whilele p7.b, x13, x8
msb     z23.d, p3/m, z8.d, z13.d
//CHECK: msb     z23.d, p3/m, z8.d, z13.d
ldr     z0, [x0]
//CHECK: ldr     z0, [x0]
fcmla   z0.d, p0/m, z0.d, z0.d, #0
//CHECK: fcmla   z0.d, p0/m, z0.d, z0.d, #0
ldff1h  {z23.d}, p3/z, [x13, z8.d, uxtw #1]
//CHECK: ldff1h  {z23.d}, p3/z, [x13, z8.d, uxtw #1]
clastb  d21, p5, d21, z10.d
//CHECK: clastb  d21, p5, d21, z10.d
mov     z31.d, #-1, lsl #8
//CHECK: mov     z31.d, #-256
msb     z21.h, p5/m, z21.h, z10.h
//CHECK: msb     z21.h, p5/m, z21.h, z10.h
umax    z23.b, z23.b, #109
//CHECK: umax    z23.b, z23.b, #109
clastb  w0, p0, w0, z0.h
//CHECK: clastb  w0, p0, w0, z0.h
uqdecw  z23.s, vl256, mul #9
//CHECK: uqdecw  z23.s, vl256, mul #9
msb     z31.h, p7/m, z31.h, z31.h
//CHECK: msb     z31.h, p7/m, z31.h, z31.h
incw    x23, vl256, mul #9
//CHECK: incw    x23, vl256, mul #9
sqincp  xzr, p15.s, wzr
//CHECK: sqincp  xzr, p15.s, wzr
ld3h    {z31.h, z0.h, z1.h}, p7/z, [sp, #-3, mul vl]
//CHECK: ld3h    {z31.h, z0.h, z1.h}, p7/z, [sp, #-3, mul vl]
insr    z31.b, wzr
//CHECK: insr    z31.b, wzr
zip2    z0.b, z0.b, z0.b
//CHECK: zip2    z0.b, z0.b, z0.b
insr    z23.h, h13
//CHECK: insr    z23.h, h13
ld1h    {z0.d}, p0/z, [x0, z0.d]
//CHECK: ld1h    {z0.d}, p0/z, [x0, z0.d]
add     z1.b, z1.b, #33
//CHECK: add     z1.b, z1.b, #33
whilels p0.s, w0, w0
//CHECK: whilels p0.s, w0, w0
mov     z31.s, p15/m, #-1, lsl #8
//CHECK: mov     z31.s, p15/m, #-256
cls     z31.d, p7/m, z31.d
//CHECK: cls     z31.d, p7/m, z31.d
scvtf   z0.d, p0/m, z0.s
//CHECK: scvtf   z0.d, p0/m, z0.s
msb     z31.b, p7/m, z31.b, z31.b
//CHECK: msb     z31.b, p7/m, z31.b, z31.b
sdot    z0.d, z0.h, z0.h[0]
//CHECK: sdot    z0.d, z0.h, z0.h[0]
ldff1w  {z23.s}, p3/z, [x13, z8.s, sxtw #2]
//CHECK: ldff1w  {z23.s}, p3/z, [x13, z8.s, sxtw #2]
cntb    x0, pow2
//CHECK: cntb    x0, pow2
whilelt p0.h, w0, w0
//CHECK: whilelt p0.h, w0, w0
ld1h    {z23.d}, p3/z, [x13, z8.d]
//CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d]
smax    z21.h, p5/m, z21.h, z10.h
//CHECK: smax    z21.h, p5/m, z21.h, z10.h
ldff1sw {z31.d}, p7/z, [sp, z31.d]
//CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d]
frsqrte z31.h, z31.h
//CHECK: frsqrte z31.h, z31.h
fmul    z21.s, z10.s, z5.s[2]
//CHECK: fmul    z21.s, z10.s, z5.s[2]
cmpne   p5.d, p5/z, z10.d, z21.d
//CHECK: cmpne   p5.d, p5/z, z10.d, z21.d
asr     z21.h, p5/m, z21.h, z10.d
//CHECK: asr     z21.h, p5/m, z21.h, z10.d
revh    z0.d, p0/m, z0.d
//CHECK: revh    z0.d, p0/m, z0.d
asr     z0.b, p0/m, z0.b, z0.b
//CHECK: asr     z0.b, p0/m, z0.b, z0.b
ldff1h  {z21.s}, p5/z, [x10, z21.s, uxtw #1]
//CHECK: ldff1h  {z21.s}, p5/z, [x10, z21.s, uxtw #1]
fsubr   z0.s, p0/m, z0.s, z0.s
//CHECK: fsubr   z0.s, p0/m, z0.s, z0.s
fcadd   z23.s, p3/m, z23.s, z13.s, #90
//CHECK: fcadd   z23.s, p3/m, z23.s, z13.s, #90
whilelo p15.b, xzr, xzr
//CHECK: whilelo p15.b, xzr, xzr
ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw]
st1h    {z21.d}, p5, [x10, z21.d]
//CHECK: st1h    {z21.d}, p5, [x10, z21.d]
uqadd   z5.b, z5.b, #113
//CHECK: uqadd   z5.b, z5.b, #113
trn1    z31.h, z31.h, z31.h
//CHECK: trn1    z31.h, z31.h, z31.h
lslr    z21.d, p5/m, z21.d, z10.d
//CHECK: lslr    z21.d, p5/m, z21.d, z10.d
umin    z31.b, p7/m, z31.b, z31.b
//CHECK: umin    z31.b, p7/m, z31.b, z31.b
index   z0.b, w0, #0
//CHECK: index   z0.b, w0, #0
uqincp  x23, p13.b
//CHECK: uqincp  x23, p13.b
decd    x23, vl256, mul #9
//CHECK: decd    x23, vl256, mul #9
add     z0.d, p0/m, z0.d, z0.d
//CHECK: add     z0.d, p0/m, z0.d, z0.d
brkb    p15.b, p15/m, p15.b
//CHECK: brkb    p15.b, p15/m, p15.b
prfd    pldl1keep, p0, [x0]
//CHECK: prfd    pldl1keep, p0, [x0]
ldnt1d  {z5.d}, p3/z, [x17, x16, lsl #3]
//CHECK: ldnt1d  {z5.d}, p3/z, [x17, x16, lsl #3]
brkpb   p15.b, p15/z, p15.b, p15.b
//CHECK: brkpb   p15.b, p15/z, p15.b, p15.b
ldff1h  {z0.d}, p0/z, [z0.d]
//CHECK: ldff1h  {z0.d}, p0/z, [z0.d]
uqadd   z0.b, z0.b, #0
//CHECK: uqadd   z0.b, z0.b, #0
neg     z21.b, p5/m, z10.b
//CHECK: neg     z21.b, p5/m, z10.b
sxtb    z23.d, p3/m, z13.d
//CHECK: sxtb    z23.d, p3/m, z13.d
lsl     z23.s, p3/m, z23.s, z13.s
//CHECK: lsl     z23.s, p3/m, z23.s, z13.s
uxtw    z0.d, p0/m, z0.d
//CHECK: uxtw    z0.d, p0/m, z0.d
st1b    {z31.h}, p7, [sp, #-1, mul vl]
//CHECK: st1b    {z31.h}, p7, [sp, #-1, mul vl]
uminv   h0, p0, z0.h
//CHECK: uminv   h0, p0, z0.h
fmul    z23.d, z13.d, z8.d
//CHECK: fmul    z23.d, z13.d, z8.d
stnt1h  {z23.h}, p3, [x13, x8, lsl #1]
//CHECK: stnt1h  {z23.h}, p3, [x13, x8, lsl #1]
uminv   h21, p5, z10.h
//CHECK: uminv   h21, p5, z10.h
fmul    z23.s, p3/m, z23.s, z13.s
//CHECK: fmul    z23.s, p3/m, z23.s, z13.s
trn2    z23.h, z13.h, z8.h
//CHECK: trn2    z23.h, z13.h, z8.h
rev     p7.s, p13.s
//CHECK: rev     p7.s, p13.s
punpklo p15.h, p15.b
//CHECK: punpklo p15.h, p15.b
st1b    {z0.h}, p0, [x0, x0]
//CHECK: st1b    {z0.h}, p0, [x0, x0]
fmls    z21.h, z10.h, z5.h[6]
//CHECK: fmls    z21.h, z10.h, z5.h[6]
ldff1d  {z31.d}, p7/z, [sp, z31.d, sxtw #3]
//CHECK: ldff1d  {z31.d}, p7/z, [sp, z31.d, sxtw #3]
frecps  z23.h, z13.h, z8.h
//CHECK: frecps  z23.h, z13.h, z8.h
sxtb    z23.s, p3/m, z13.s
//CHECK: sxtb    z23.s, p3/m, z13.s
ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0]
//CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0]
uqdech  z23.h, vl256, mul #9
//CHECK: uqdech  z23.h, vl256, mul #9
lsl     z31.s, p7/m, z31.s, z31.d
//CHECK: lsl     z31.s, p7/m, z31.s, z31.d
st1h    {z23.d}, p3, [x13, z8.d, sxtw]
//CHECK: st1h    {z23.d}, p3, [x13, z8.d, sxtw]
fcvtzs  z0.s, p0/m, z0.s
//CHECK: fcvtzs  z0.s, p0/m, z0.s
frinta  z0.h, p0/m, z0.h
//CHECK: frinta  z0.h, p0/m, z0.h
ldnf1b  {z0.s}, p0/z, [x0]
//CHECK: ldnf1b  {z0.s}, p0/z, [x0]
incp    z0.h, p0
//CHECK: incp    z0.h, p0
fmls    z31.h, z31.h, z7.h[7]
//CHECK: fmls    z31.h, z31.h, z7.h[7]
index   z0.s, #0, w0
//CHECK: index   z0.s, #0, w0
lastb   wzr, p7, z31.s
//CHECK: lastb   wzr, p7, z31.s
fcvtzu  z0.d, p0/m, z0.s
//CHECK: fcvtzu  z0.d, p0/m, z0.s
smaxv   d23, p3, z13.d
//CHECK: smaxv   d23, p3, z13.d
lastb   x0, p0, z0.d
//CHECK: lastb   x0, p0, z0.d
whilels p0.d, w0, w0
//CHECK: whilels p0.d, w0, w0
prfb    #7, p3, [z13.s, #8]
//CHECK: prfb    #7, p3, [z13.s, #8]
fcvtzu  z21.d, p5/m, z10.s
//CHECK: fcvtzu  z21.d, p5/m, z10.s
ldff1b  {z31.s}, p7/z, [sp, z31.s, sxtw]
//CHECK: ldff1b  {z31.s}, p7/z, [sp, z31.s, sxtw]
clastb  s23, p3, s23, z13.s
//CHECK: clastb  s23, p3, s23, z13.s
dech    xzr, all, mul #16
//CHECK: dech    xzr, all, mul #16
lsrr    z23.s, p3/m, z23.s, z13.s
//CHECK: lsrr    z23.s, p3/m, z23.s, z13.s
cmpeq   p5.s, p5/z, z10.s, #-11
//CHECK: cmpeq   p5.s, p5/z, z10.s, #-11
smin    z21.h, p5/m, z21.h, z10.h
//CHECK: smin    z21.h, p5/m, z21.h, z10.h
whilelo p7.d, x13, x8
//CHECK: whilelo p7.d, x13, x8
fnmad   z31.h, p7/m, z31.h, z31.h
//CHECK: fnmad   z31.h, p7/m, z31.h, z31.h
lsl     z31.h, p7/m, z31.h, #15
//CHECK: lsl     z31.h, p7/m, z31.h, #15
fcmgt   p15.d, p7/z, z31.d, #0.0
//CHECK: fcmgt   p15.d, p7/z, z31.d, #0.0
faddv   d21, p5, z10.d
//CHECK: faddv   d21, p5, z10.d
uaddv   d0, p0, z0.b
//CHECK: uaddv   d0, p0, z0.b
fneg    z23.s, p3/m, z13.s
//CHECK: fneg    z23.s, p3/m, z13.s
ld1sh   {z23.s}, p3/z, [x13, z8.s, uxtw #1]
//CHECK: ld1sh   {z23.s}, p3/z, [x13, z8.s, uxtw #1]
st2b    {z21.b, z22.b}, p5, [x10, x21]
//CHECK: st2b    {z21.b, z22.b}, p5, [x10, x21]
ftmad   z0.h, z0.h, z0.h, #0
//CHECK: ftmad   z0.h, z0.h, z0.h, #0
fadda   s31, p7, s31, z31.s
//CHECK: fadda   s31, p7, s31, z31.s
cnt     z0.b, p0/m, z0.b
//CHECK: cnt     z0.b, p0/m, z0.b
pnext   p0.h, p0, p0.h
//CHECK: pnext   p0.h, p0, p0.h
fnmla   z21.s, p5/m, z10.s, z21.s
//CHECK: fnmla   z21.s, p5/m, z10.s, z21.s
ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, uxtw]
ld1rqh  {z5.h}, p3/z, [x17, x16, lsl #1]
//CHECK: ld1rqh  {z5.h}, p3/z, [x17, x16, lsl #1]
cmpne   p15.s, p7/z, z31.s, #-1
//CHECK: cmpne   p15.s, p7/z, z31.s, #-1
asr     z21.s, p5/m, z21.s, z10.s
//CHECK: asr     z21.s, p5/m, z21.s, z10.s
ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl]
//CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl]
lsl     z23.h, p3/m, z23.h, z13.h
//CHECK: lsl     z23.h, p3/m, z23.h, z13.h
cmplt   p15.h, p7/z, z31.h, #-1
//CHECK: cmplt   p15.h, p7/z, z31.h, #-1
ldnf1sh {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1sh {z23.s}, p3/z, [x13, #-8, mul vl]
whilele p0.d, x0, x0
//CHECK: whilele p0.d, x0, x0
nand    p7.b, p11/z, p13.b, p8.b
//CHECK: nand    p7.b, p11/z, p13.b, p8.b
uzp2    z21.s, z10.s, z21.s
//CHECK: uzp2    z21.s, z10.s, z21.s
mad     z0.h, p0/m, z0.h, z0.h
//CHECK: mad     z0.h, p0/m, z0.h, z0.h
sqdecp  x0, p0.d, w0
//CHECK: sqdecp  x0, p0.d, w0
fmul    z0.h, z0.h, z0.h[0]
//CHECK: fmul    z0.h, z0.h, z0.h[0]
subr    z23.s, p3/m, z23.s, z13.s
//CHECK: subr    z23.s, p3/m, z23.s, z13.s
mov     z31.s, wsp
//CHECK: mov     z31.s, wsp
decd    z23.d, vl256, mul #9
//CHECK: decd    z23.d, vl256, mul #9
uunpkhi z23.h, z13.b
//CHECK: uunpkhi z23.h, z13.b
ld1h    {z0.d}, p0/z, [z0.d]
//CHECK: ld1h    {z0.d}, p0/z, [z0.d]
uzp1    p7.h, p13.h, p8.h
//CHECK: uzp1    p7.h, p13.h, p8.h
and     z31.d, z31.d, z31.d
//CHECK: and     z31.d, z31.d, z31.d
frintn  z21.h, p5/m, z10.h
//CHECK: frintn  z21.h, p5/m, z10.h
lsr     z21.h, p5/m, z21.h, #6
//CHECK: lsr     z21.h, p5/m, z21.h, #6
sxtb    z0.d, p0/m, z0.d
//CHECK: sxtb    z0.d, p0/m, z0.d
prfb    pldl1keep, p0, [x0]
//CHECK: prfb    pldl1keep, p0, [x0]
ld1h    {z21.s}, p5/z, [z10.s, #42]
//CHECK: ld1h    {z21.s}, p5/z, [z10.s, #42]
sxtb    z21.s, p5/m, z10.s
//CHECK: sxtb    z21.s, p5/m, z10.s
ld1sh   {z23.d}, p3/z, [x13, z8.d, sxtw #1]
//CHECK: ld1sh   {z23.d}, p3/z, [x13, z8.d, sxtw #1]
ld2b    {z5.b, z6.b}, p3/z, [x17, x16]
//CHECK: ld2b    {z5.b, z6.b}, p3/z, [x17, x16]
fcmlt   p0.s, p0/z, z0.s, #0.0
//CHECK: fcmlt   p0.s, p0/z, z0.s, #0.0
lsr     z0.b, p0/m, z0.b, z0.b
//CHECK: lsr     z0.b, p0/m, z0.b, z0.b
zip2    z31.s, z31.s, z31.s
//CHECK: zip2    z31.s, z31.s, z31.s
ldnt1w  {z0.s}, p0/z, [x0, x0, lsl #2]
//CHECK: ldnt1w  {z0.s}, p0/z, [x0, x0, lsl #2]
fmov    z23.d, #0.90625
//CHECK: fmov    z23.d, #0.90625
st1w    {z31.s}, p7, [sp, z31.s, uxtw #2]
//CHECK: st1w    {z31.s}, p7, [sp, z31.s, uxtw #2]
prfw    pldl3strm, p5, [x10, #21, mul vl]
//CHECK: prfw    pldl3strm, p5, [x10, #21, mul vl]
clasta  x0, p0, x0, z0.d
//CHECK: clasta  x0, p0, x0, z0.d
uqincp  z0.h, p0
//CHECK: uqincp  z0.h, p0
cmpls   p5.b, p5/z, z10.b, z21.d
//CHECK: cmpls   p5.b, p5/z, z10.b, z21.d
uzp1    z0.d, z0.d, z0.d
//CHECK: uzp1    z0.d, z0.d, z0.d
uqdecp  w23, p13.b
//CHECK: uqdecp  w23, p13.b
adr     z23.d, [z13.d, z8.d, uxtw #1]
//CHECK: adr     z23.d, [z13.d, z8.d, uxtw #1]
ld1sh   {z23.s}, p3/z, [x13, z8.s, sxtw #1]
//CHECK: ld1sh   {z23.s}, p3/z, [x13, z8.s, sxtw #1]
ldnf1b  {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1b  {z21.d}, p5/z, [x10, #5, mul vl]
cmpeq   p0.h, p0/z, z0.h, z0.d
//CHECK: cmpeq   p0.h, p0/z, z0.h, z0.d
add     z31.h, z31.h, z31.h
//CHECK: add     z31.h, z31.h, z31.h
ldff1sh {z21.s}, p5/z, [z10.s, #42]
//CHECK: ldff1sh {z21.s}, p5/z, [z10.s, #42]
zip2    p5.h, p10.h, p5.h
//CHECK: zip2    p5.h, p10.h, p5.h
cmpls   p15.s, p7/z, z31.s, z31.d
//CHECK: cmpls   p15.s, p7/z, z31.s, z31.d
uqadd   z23.b, z13.b, z8.b
//CHECK: uqadd   z23.b, z13.b, z8.b
cmpne   p15.d, p7/z, z31.d, z31.d
//CHECK: cmpne   p15.d, p7/z, z31.d, z31.d
st1h    {z23.s}, p3, [x13, z8.s, uxtw #1]
//CHECK: st1h    {z23.s}, p3, [x13, z8.s, uxtw #1]
lsr     z0.h, p0/m, z0.h, z0.h
//CHECK: lsr     z0.h, p0/m, z0.h, z0.h
sqincd  x21, vl32, mul #6
//CHECK: sqincd  x21, vl32, mul #6
clastb  d31, p7, d31, z31.d
//CHECK: clastb  d31, p7, d31, z31.d
fmax    z23.s, p3/m, z23.s, z13.s
//CHECK: fmax    z23.s, p3/m, z23.s, z13.s
trn2    p15.d, p15.d, p15.d
//CHECK: trn2    p15.d, p15.d, p15.d
ld1rsb  {z0.h}, p0/z, [x0]
//CHECK: ld1rsb  {z0.h}, p0/z, [x0]
sdot    z21.s, z10.b, z5.b[2]
//CHECK: sdot    z21.s, z10.b, z5.b[2]
uqdecp  w0, p0.b
//CHECK: uqdecp  w0, p0.b
mov     z21.s, p5/z, #-86
//CHECK: mov     z21.s, p5/z, #-86
ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, x8, lsl #3]
//CHECK: ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, x8, lsl #3]
ldff1h  {z23.s}, p3/z, [x13, x8, lsl #1]
//CHECK: ldff1h  {z23.s}, p3/z, [x13, x8, lsl #1]
insr    z0.h, h0
//CHECK: insr    z0.h, h0
uqincp  z21.d, p10
//CHECK: uqincp  z21.d, p10
st1h    {z0.d}, p0, [x0, x0, lsl #1]
//CHECK: st1h    {z0.d}, p0, [x0, x0, lsl #1]
sabd    z21.d, p5/m, z21.d, z10.d
//CHECK: sabd    z21.d, p5/m, z21.d, z10.d
brka    p7.b, p11/m, p13.b
//CHECK: brka    p7.b, p11/m, p13.b
uqincp  z31.d, p15
//CHECK: uqincp  z31.d, p15
eorv    s21, p5, z10.s
//CHECK: eorv    s21, p5, z10.s
clasta  z0.d, p0, z0.d, z0.d
//CHECK: clasta  z0.d, p0, z0.d, z0.d
compact z23.s, p3, z13.s
//CHECK: compact z23.s, p3, z13.s
cmpne   p0.s, p0/z, z0.s, z0.s
//CHECK: cmpne   p0.s, p0/z, z0.s, z0.s
ld1rsh  {z31.s}, p7/z, [sp, #126]
//CHECK: ld1rsh  {z31.s}, p7/z, [sp, #126]
zip2    z31.b, z31.b, z31.b
//CHECK: zip2    z31.b, z31.b, z31.b
cmphi   p5.b, p5/z, z10.b, #85
//CHECK: cmphi   p5.b, p5/z, z10.b, #85
insr    z0.b, b0
//CHECK: insr    z0.b, b0
lsr     z31.s, p7/m, z31.s, #1
//CHECK: lsr     z31.s, p7/m, z31.s, #1
msb     z23.b, p3/m, z8.b, z13.b
//CHECK: msb     z23.b, p3/m, z8.b, z13.b
sqdecw  x0, pow2
//CHECK: sqdecw  x0, pow2
str     p0, [x0]
//CHECK: str     p0, [x0]
ld1sh   {z23.d}, p3/z, [x13, z8.d, lsl #1]
//CHECK: ld1sh   {z23.d}, p3/z, [x13, z8.d, lsl #1]
fadd    z23.d, z13.d, z8.d
//CHECK: fadd    z23.d, z13.d, z8.d
insr    z21.s, w10
//CHECK: insr    z21.s, w10
zip1    z21.h, z10.h, z21.h
//CHECK: zip1    z21.h, z10.h, z21.h
sqadd   z0.b, z0.b, z0.b
//CHECK: sqadd   z0.b, z0.b, z0.b
fmls    z0.s, z0.s, z0.s[0]
//CHECK: fmls    z0.s, z0.s, z0.s[0]
fcmge   p5.h, p5/z, z10.h, #0.0
//CHECK: fcmge   p5.h, p5/z, z10.h, #0.0
mov     z31.d, z31.d
//CHECK: mov     z31.d, z31.d
uqadd   z21.h, z10.h, z21.h
//CHECK: uqadd   z21.h, z10.h, z21.h
st2h    {z23.h, z24.h}, p3, [x13, #-16, mul vl]
//CHECK: st2h    {z23.h, z24.h}, p3, [x13, #-16, mul vl]
umin    z21.b, p5/m, z21.b, z10.b
//CHECK: umin    z21.b, p5/m, z21.b, z10.b
umaxv   d0, p0, z0.d
//CHECK: umaxv   d0, p0, z0.d
lslr    z21.s, p5/m, z21.s, z10.s
//CHECK: lslr    z21.s, p5/m, z21.s, z10.s
mov     z21.d, p5/m, x10
//CHECK: mov     z21.d, p5/m, x10
ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw #1]
//CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw #1]
sminv   d0, p0, z0.d
//CHECK: sminv   d0, p0, z0.d
fsubr   z31.h, p7/m, z31.h, #1.0
//CHECK: fsubr   z31.h, p7/m, z31.h, #1.0
mov     z0.d, p0/m, #0
//CHECK: mov     z0.d, p0/m, #0
uqsub   z21.d, z10.d, z21.d
//CHECK: uqsub   z21.d, z10.d, z21.d
ld1w    {z31.s}, p7/z, [sp, z31.s, uxtw #2]
//CHECK: ld1w    {z31.s}, p7/z, [sp, z31.s, uxtw #2]
orr     z23.s, p3/m, z23.s, z13.s
//CHECK: orr     z23.s, p3/m, z23.s, z13.s
rev     z21.h, z10.h
//CHECK: rev     z21.h, z10.h
ldff1sb {z31.d}, p7/z, [z31.d, #31]
//CHECK: ldff1sb {z31.d}, p7/z, [z31.d, #31]
uaddv   d21, p5, z10.b
//CHECK: uaddv   d21, p5, z10.b
adr     z21.d, [z10.d, z21.d, sxtw #1]
//CHECK: adr     z21.d, [z10.d, z21.d, sxtw #1]
movprfx z0.d, p0/m, z0.d
//CHECK: movprfx z0.d, p0/m, z0.d
add     z0.d, p0/m, z0.d, z1.d
//CHECK: add z0.d, p0/m, z0.d, z1.d
sdiv    z21.d, p5/m, z21.d, z10.d
//CHECK: sdiv    z21.d, p5/m, z21.d, z10.d
uqdecb  wzr, all, mul #16
//CHECK: uqdecb  wzr, all, mul #16
st1h    {z21.s}, p5, [x10, #5, mul vl]
//CHECK: st1h    {z21.s}, p5, [x10, #5, mul vl]
prfd    pldl1keep, p0, [x0, z0.d, uxtw #3]
//CHECK: prfd    pldl1keep, p0, [x0, z0.d, uxtw #3]
nand    p15.b, p15/z, p15.b, p15.b
//CHECK: nand    p15.b, p15/z, p15.b, p15.b
ldff1d  {z0.d}, p0/z, [x0, z0.d, sxtw #3]
//CHECK: ldff1d  {z0.d}, p0/z, [x0, z0.d, sxtw #3]
uqadd   z21.s, z21.s, #170
//CHECK: uqadd   z21.s, z21.s, #170
ld1b    {z0.b}, p0/z, [x0]
//CHECK: ld1b    {z0.b}, p0/z, [x0]
ld1h    {z31.s}, p7/z, [sp, z31.s, uxtw #1]
//CHECK: ld1h    {z31.s}, p7/z, [sp, z31.s, uxtw #1]
uzp2    p0.b, p0.b, p0.b
//CHECK: uzp2    p0.b, p0.b, p0.b
umax    z23.b, p3/m, z23.b, z13.b
//CHECK: umax    z23.b, p3/m, z23.b, z13.b
cmpls   p5.d, p5/z, z10.d, #85
//CHECK: cmpls   p5.d, p5/z, z10.d, #85
sqdech  xzr, wzr, all, mul #16
//CHECK: sqdech  xzr, wzr, all, mul #16
ld1w    {z0.d}, p0/z, [x0, z0.d, lsl #2]
//CHECK: ld1w    {z0.d}, p0/z, [x0, z0.d, lsl #2]
fmin    z31.h, p7/m, z31.h, z31.h
//CHECK: fmin    z31.h, p7/m, z31.h, z31.h
st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, x21]
//CHECK: st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, x21]
fmaxnm  z31.h, p7/m, z31.h, z31.h
//CHECK: fmaxnm  z31.h, p7/m, z31.h, z31.h
clastb  z23.d, p3, z23.d, z13.d
//CHECK: clastb  z23.d, p3, z23.d, z13.d
ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw #2]
//CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw #2]
stnt1d  {z0.d}, p0, [x0]
//CHECK: stnt1d  {z0.d}, p0, [x0]
st1d    {z31.d}, p7, [sp, z31.d, sxtw]
//CHECK: st1d    {z31.d}, p7, [sp, z31.d, sxtw]
fsqrt   z23.s, p3/m, z13.s
//CHECK: fsqrt   z23.s, p3/m, z13.s
ldff1sw {z0.d}, p0/z, [x0, z0.d]
//CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d]
ld1w    {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ld1w    {z21.d}, p5/z, [x10, z21.d, uxtw]
not     z0.h, p0/m, z0.h
//CHECK: not     z0.h, p0/m, z0.h
uqsub   z21.h, z10.h, z21.h
//CHECK: uqsub   z21.h, z10.h, z21.h
fcvtzs  z31.d, p7/m, z31.d
//CHECK: fcvtzs  z31.d, p7/m, z31.d
ftsmul  z23.d, z13.d, z8.d
//CHECK: ftsmul  z23.d, z13.d, z8.d
fsqrt   z0.h, p0/m, z0.h
//CHECK: fsqrt   z0.h, p0/m, z0.h
ld1w    {z21.d}, p5/z, [x10, z21.d]
//CHECK: ld1w    {z21.d}, p5/z, [x10, z21.d]
sqadd   z31.s, z31.s, z31.s
//CHECK: sqadd   z31.s, z31.s, z31.s
ld1sh   {z0.s}, p0/z, [x0, z0.s, uxtw]
//CHECK: ld1sh   {z0.s}, p0/z, [x0, z0.s, uxtw]
cmpge   p15.s, p7/z, z31.s, #-1
//CHECK: cmpge   p15.s, p7/z, z31.s, #-1
mov     z21.h, p5/m, w10
//CHECK: mov     z21.h, p5/m, w10
sqincw  x23, vl256, mul #9
//CHECK: sqincw  x23, vl256, mul #9
ldnt1b  {z21.b}, p5/z, [x10, #5, mul vl]
//CHECK: ldnt1b  {z21.b}, p5/z, [x10, #5, mul vl]
fcmeq   p15.h, p7/z, z31.h, #0.0
//CHECK: fcmeq   p15.h, p7/z, z31.h, #0.0
lastb   h0, p0, z0.h
//CHECK: lastb   h0, p0, z0.h
mov     z23.b, z13.b[20]
//CHECK: mov     z23.b, z13.b[20]
lsr     z21.s, p5/m, z21.s, #22
//CHECK: lsr     z21.s, p5/m, z21.s, #22
fmul    z31.s, z31.s, z7.s[3]
//CHECK: fmul    z31.s, z31.s, z7.s[3]
ld1rh   {z23.h}, p3/z, [x13, #16]
//CHECK: ld1rh   {z23.h}, p3/z, [x13, #16]
fadda   s21, p5, s21, z10.s
//CHECK: fadda   s21, p5, s21, z10.s
ld1sb   {z23.s}, p3/z, [x13, x8]
//CHECK: ld1sb   {z23.s}, p3/z, [x13, x8]
prfw    pldl3strm, p5, [x10, z21.d, sxtw #2]
//CHECK: prfw    pldl3strm, p5, [x10, z21.d, sxtw #2]
decw    xzr, all, mul #16
//CHECK: decw    xzr, all, mul #16
cmpge   p0.b, p0/z, z0.b, #0
//CHECK: cmpge   p0.b, p0/z, z0.b, #0
decb    xzr, all, mul #16
//CHECK: decb    xzr, all, mul #16
ucvtf   z23.s, p3/m, z13.s
//CHECK: ucvtf   z23.s, p3/m, z13.s
ldnt1w  {z21.s}, p5/z, [x10, x21, lsl #2]
//CHECK: ldnt1w  {z21.s}, p5/z, [x10, x21, lsl #2]
ldff1h  {z21.h}, p5/z, [x10, x21, lsl #1]
//CHECK: ldff1h  {z21.h}, p5/z, [x10, x21, lsl #1]
ftssel  z31.d, z31.d, z31.d
//CHECK: ftssel  z31.d, z31.d, z31.d
ld1d    {z23.d}, p3/z, [z13.d, #64]
//CHECK: ld1d    {z23.d}, p3/z, [z13.d, #64]
incb    x23, vl256, mul #9
//CHECK: incb    x23, vl256, mul #9
sqinch  x0, w0, pow2
//CHECK: sqinch  x0, w0, pow2
fmaxnm  z21.s, p5/m, z21.s, z10.s
//CHECK: fmaxnm  z21.s, p5/m, z21.s, z10.s
mov     z21.b, p5/z, #-86
//CHECK: mov     z21.b, p5/z, #-86
cmple   p5.h, p5/z, z10.h, z21.d
//CHECK: cmple   p5.h, p5/z, z10.h, z21.d
cmpge   p5.b, p5/z, z10.b, #-11
//CHECK: cmpge   p5.b, p5/z, z10.b, #-11
uqinch  z23.h, vl256, mul #9
//CHECK: uqinch  z23.h, vl256, mul #9
fabs    z0.s, p0/m, z0.s
//CHECK: fabs    z0.s, p0/m, z0.s
clastb  w23, p3, w23, z13.h
//CHECK: clastb  w23, p3, w23, z13.h
cmphi   p15.h, p7/z, z31.h, z31.d
//CHECK: cmphi   p15.h, p7/z, z31.h, z31.d
fcadd   z21.d, p5/m, z21.d, z10.d, #270
//CHECK: fcadd   z21.d, p5/m, z21.d, z10.d, #270
decd    xzr, all, mul #16
//CHECK: decd    xzr, all, mul #16
zip1    p5.h, p10.h, p5.h
//CHECK: zip1    p5.h, p10.h, p5.h
scvtf   z0.s, p0/m, z0.d
//CHECK: scvtf   z0.s, p0/m, z0.d
ld3b    {z31.b, z0.b, z1.b}, p7/z, [sp, #-3, mul vl]
//CHECK: ld3b    {z31.b, z0.b, z1.b}, p7/z, [sp, #-3, mul vl]
fminv   d21, p5, z10.d
//CHECK: fminv   d21, p5, z10.d
udot    z0.s, z0.b, z0.b[0]
//CHECK: udot    z0.s, z0.b, z0.b[0]
rev     z31.b, z31.b
//CHECK: rev     z31.b, z31.b
st1w    {z21.s}, p5, [x10, z21.s, sxtw #2]
//CHECK: st1w    {z21.s}, p5, [x10, z21.s, sxtw #2]
st1d    {z5.d}, p3, [x17, x16, lsl #3]
//CHECK: st1d    {z5.d}, p3, [x17, x16, lsl #3]
ld1h    {z23.s}, p3/z, [x13, x8, lsl #1]
//CHECK: ld1h    {z23.s}, p3/z, [x13, x8, lsl #1]
whilels p5.b, w10, w21
//CHECK: whilels p5.b, w10, w21
subr    z0.b, p0/m, z0.b, z0.b
//CHECK: subr    z0.b, p0/m, z0.b, z0.b
smaxv   b31, p7, z31.b
//CHECK: smaxv   b31, p7, z31.b
cmplt   p15.b, p7/z, z31.b, #-1
//CHECK: cmplt   p15.b, p7/z, z31.b, #-1
add     z0.b, z0.b, z0.b
//CHECK: add     z0.b, z0.b, z0.b
mov     z23.h, #109, lsl #8
//CHECK: mov     z23.h, #27904
sub     z23.s, z23.s, #109, lsl #8
//CHECK: sub     z23.s, z23.s, #27904
sqadd   z21.d, z10.d, z21.d
//CHECK: sqadd   z21.d, z10.d, z21.d
ld1sb   {z0.d}, p0/z, [z0.d]
//CHECK: ld1sb   {z0.d}, p0/z, [z0.d]
abs     z23.d, p3/m, z13.d
//CHECK: abs     z23.d, p3/m, z13.d
smin    z31.b, z31.b, #-1
//CHECK: smin    z31.b, z31.b, #-1
ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw]
ld1sh   {z23.s}, p3/z, [x13, z8.s, uxtw]
//CHECK: ld1sh   {z23.s}, p3/z, [x13, z8.s, uxtw]
incp    z31.d, p15
//CHECK: incp    z31.d, p15
ld1sw   {z0.d}, p0/z, [x0, z0.d, uxtw #2]
//CHECK: ld1sw   {z0.d}, p0/z, [x0, z0.d, uxtw #2]
abs     z31.h, p7/m, z31.h
//CHECK: abs     z31.h, p7/m, z31.h
uqincp  w0, p0.d
//CHECK: uqincp  w0, p0.d
fminnm  z21.d, p5/m, z21.d, #0.0
//CHECK: fminnm  z21.d, p5/m, z21.d, #0.0
cnot    z21.d, p5/m, z10.d
//CHECK: cnot    z21.d, p5/m, z10.d
cmpgt   p7.h, p3/z, z13.h, #8
//CHECK: cmpgt   p7.h, p3/z, z13.h, #8
fnmla   z0.s, p0/m, z0.s, z0.s
//CHECK: fnmla   z0.s, p0/m, z0.s, z0.s
clz     z21.b, p5/m, z10.b
//CHECK: clz     z21.b, p5/m, z10.b
clz     z21.d, p5/m, z10.d
//CHECK: clz     z21.d, p5/m, z10.d
ld1w    {z23.d}, p3/z, [x13, z8.d, uxtw #2]
//CHECK: ld1w    {z23.d}, p3/z, [x13, z8.d, uxtw #2]
umax    z23.h, p3/m, z23.h, z13.h
//CHECK: umax    z23.h, p3/m, z23.h, z13.h
pnext   p0.d, p0, p0.d
//CHECK: pnext   p0.d, p0, p0.d
rev     z21.s, z10.s
//CHECK: rev     z21.s, z10.s
clasta  s0, p0, s0, z0.s
//CHECK: clasta  s0, p0, s0, z0.s
st1h    {z31.s}, p7, [sp, z31.s, sxtw]
//CHECK: st1h    {z31.s}, p7, [sp, z31.s, sxtw]
lsl     z0.b, p0/m, z0.b, z0.d
//CHECK: lsl     z0.b, p0/m, z0.b, z0.d
cmpeq   p15.h, p7/z, z31.h, z31.h
//CHECK: cmpeq   p15.h, p7/z, z31.h, z31.h
cmplt   p5.s, p5/z, z10.s, #-11
//CHECK: cmplt   p5.s, p5/z, z10.s, #-11
sqincb  x0, pow2
//CHECK: sqincb  x0, pow2
fabs    z23.s, p3/m, z13.s
//CHECK: fabs    z23.s, p3/m, z13.s
uzp2    p15.h, p15.h, p15.h
//CHECK: uzp2    p15.h, p15.h, p15.h
uminv   d31, p7, z31.d
//CHECK: uminv   d31, p7, z31.d
insr    z21.b, w10
//CHECK: insr    z21.b, w10
ld1sh   {z31.s}, p7/z, [sp, z31.s, sxtw #1]
//CHECK: ld1sh   {z31.s}, p7/z, [sp, z31.s, sxtw #1]
st3d    {z21.d, z22.d, z23.d}, p5, [x10, x21, lsl #3]
//CHECK: st3d    {z21.d, z22.d, z23.d}, p5, [x10, x21, lsl #3]
prfw    pldl3strm, p5, [x10, x21, lsl #2]
//CHECK: prfw    pldl3strm, p5, [x10, x21, lsl #2]
smaxv   s0, p0, z0.s
//CHECK: smaxv   s0, p0, z0.s
ld1sb   {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ld1sb   {z21.d}, p5/z, [x10, z21.d, uxtw]
ldnf1sb {z23.h}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1sb {z23.h}, p3/z, [x13, #-8, mul vl]
index   z0.d, x0, #0
//CHECK: index   z0.d, x0, #0
lsr     z23.s, z13.s, z8.d
//CHECK: lsr     z23.s, z13.s, z8.d
ld1rb   {z31.h}, p7/z, [sp, #63]
//CHECK: ld1rb   {z31.h}, p7/z, [sp, #63]
mul     z23.s, p3/m, z23.s, z13.s
//CHECK: mul     z23.s, p3/m, z23.s, z13.s
prfh    pldl1keep, p0, [x0, z0.d, sxtw #1]
//CHECK: prfh    pldl1keep, p0, [x0, z0.d, sxtw #1]
uzp2    p7.b, p13.b, p8.b
//CHECK: uzp2    p7.b, p13.b, p8.b
whilelt p5.h, x10, x21
//CHECK: whilelt p5.h, x10, x21
ld1rh   {z31.d}, p7/z, [sp, #126]
//CHECK: ld1rh   {z31.d}, p7/z, [sp, #126]
fsqrt   z0.s, p0/m, z0.s
//CHECK: fsqrt   z0.s, p0/m, z0.s
prfd    pldl1keep, p0, [x0, z0.s, sxtw #3]
//CHECK: prfd    pldl1keep, p0, [x0, z0.s, sxtw #3]
fminnm  z0.h, p0/m, z0.h, z0.h
//CHECK: fminnm  z0.h, p0/m, z0.h, z0.h
ld1b    {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ld1b    {z23.d}, p3/z, [x13, z8.d, sxtw]
orv     s23, p3, z13.s
//CHECK: orv     s23, p3, z13.s
ld1sw   {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1sw   {z31.d}, p7/z, [sp, #-1, mul vl]
fcvtzu  z21.s, p5/m, z10.h
//CHECK: fcvtzu  z21.s, p5/m, z10.h
ld4w    {z23.s, z24.s, z25.s, z26.s}, p3/z, [x13, x8, lsl #2]
//CHECK: ld4w    {z23.s, z24.s, z25.s, z26.s}, p3/z, [x13, x8, lsl #2]
ftssel  z21.s, z10.s, z21.s
//CHECK: ftssel  z21.s, z10.s, z21.s
smin    z21.d, p5/m, z21.d, z10.d
//CHECK: smin    z21.d, p5/m, z21.d, z10.d
sqdecp  z0.d, p0
//CHECK: sqdecp  z0.d, p0
ldnf1h  {z23.h}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1h  {z23.h}, p3/z, [x13, #-8, mul vl]
ld1sw   {z0.d}, p0/z, [x0]
//CHECK: ld1sw   {z0.d}, p0/z, [x0]
mad     z31.b, p7/m, z31.b, z31.b
//CHECK: mad     z31.b, p7/m, z31.b, z31.b
fmls    z23.d, p3/m, z13.d, z8.d
//CHECK: fmls    z23.d, p3/m, z13.d, z8.d
sub     z21.s, z21.s, #170
//CHECK: sub     z21.s, z21.s, #170
ld1rsb  {z0.d}, p0/z, [x0]
//CHECK: ld1rsb  {z0.d}, p0/z, [x0]
frecpx  z31.d, p7/m, z31.d
//CHECK: frecpx  z31.d, p7/m, z31.d
sqdecp  z23.h, p13
//CHECK: sqdecp  z23.h, p13
splice  z31.s, p7, z31.s, z31.s
//CHECK: splice  z31.s, p7, z31.s, z31.s
prfw    pldl1keep, p0, [x0, z0.d, lsl #2]
//CHECK: prfw    pldl1keep, p0, [x0, z0.d, lsl #2]
eor     z31.b, p7/m, z31.b, z31.b
//CHECK: eor     z31.b, p7/m, z31.b, z31.b
pnext   p15.d, p15, p15.d
//CHECK: pnext   p15.d, p15, p15.d
fadd    z0.s, p0/m, z0.s, z0.s
//CHECK: fadd    z0.s, p0/m, z0.s, z0.s
ftsmul  z21.s, z10.s, z21.s
//CHECK: ftsmul  z21.s, z10.s, z21.s
ld1rb   {z23.d}, p3/z, [x13, #8]
//CHECK: ld1rb   {z23.d}, p3/z, [x13, #8]
trn1    z23.b, z13.b, z8.b
//CHECK: trn1    z23.b, z13.b, z8.b
mov     z31.d, p15/m, z31.d
//CHECK: mov     z31.d, p15/m, z31.d
cmpne   p7.s, p3/z, z13.s, #8
//CHECK: cmpne   p7.s, p3/z, z13.s, #8
frinta  z23.h, p3/m, z13.h
//CHECK: frinta  z23.h, p3/m, z13.h
asrd    z0.s, p0/m, z0.s, #32
//CHECK: asrd    z0.s, p0/m, z0.s, #32
cls     z21.d, p5/m, z10.d
//CHECK: cls     z21.d, p5/m, z10.d
fnmsb   z21.h, p5/m, z10.h, z21.h
//CHECK: fnmsb   z21.h, p5/m, z10.h, z21.h
fsubr   z21.d, p5/m, z21.d, #0.5
//CHECK: fsubr   z21.d, p5/m, z21.d, #0.5
neg     z31.s, p7/m, z31.s
//CHECK: neg     z31.s, p7/m, z31.s
cmpeq   p15.s, p7/z, z31.s, z31.d
//CHECK: cmpeq   p15.s, p7/z, z31.s, z31.d
mov     z0.d, p0/m, d0
//CHECK: mov     z0.d, p0/m, d0
ld1w    {z23.s}, p3/z, [x13, z8.s, uxtw #2]
//CHECK: ld1w    {z23.s}, p3/z, [x13, z8.s, uxtw #2]
lastb   w21, p5, z10.b
//CHECK: lastb   w21, p5, z10.b
st1b    {z23.b}, p3, [x13, x8]
//CHECK: st1b    {z23.b}, p3, [x13, x8]
ld1w    {z0.d}, p0/z, [x0, z0.d, uxtw #2]
//CHECK: ld1w    {z0.d}, p0/z, [x0, z0.d, uxtw #2]
fdivr   z31.h, p7/m, z31.h, z31.h
//CHECK: fdivr   z31.h, p7/m, z31.h, z31.h
st1w    {z23.s}, p3, [x13, z8.s, uxtw #2]
//CHECK: st1w    {z23.s}, p3, [x13, z8.s, uxtw #2]
cmpeq   p7.b, p3/z, z13.b, z8.d
//CHECK: cmpeq   p7.b, p3/z, z13.b, z8.d
ld1sb   {z21.d}, p5/z, [x10, #5, mul vl]
//CHECK: ld1sb   {z21.d}, p5/z, [x10, #5, mul vl]
uqdecd  x21, vl32, mul #6
//CHECK: uqdecd  x21, vl32, mul #6
fmaxnm  z0.s, p0/m, z0.s, #0.0
//CHECK: fmaxnm  z0.s, p0/m, z0.s, #0.0
ld1sb   {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ld1sb   {z23.d}, p3/z, [x13, z8.d, sxtw]
prfw    pldl3strm, p5, [x10, z21.s, uxtw #2]
//CHECK: prfw    pldl3strm, p5, [x10, z21.s, uxtw #2]
prfh    pldl1keep, p0, [z0.s]
//CHECK: prfh    pldl1keep, p0, [z0.s]
fmin    z21.d, p5/m, z21.d, z10.d
//CHECK: fmin    z21.d, p5/m, z21.d, z10.d
udot    z31.s, z31.b, z7.b[3]
//CHECK: udot    z31.s, z31.b, z7.b[3]
lsl     z0.d, p0/m, z0.d, #0
//CHECK: lsl     z0.d, p0/m, z0.d, #0
ld1h    {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1h    {z31.s}, p7/z, [sp, #-1, mul vl]
ldff1sb {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ldff1sb {z21.d}, p5/z, [x10, z21.d, sxtw]
smin    z31.b, p7/m, z31.b, z31.b
//CHECK: smin    z31.b, p7/m, z31.b, z31.b
ldff1h  {z21.s}, p5/z, [x10, z21.s, sxtw #1]
//CHECK: ldff1h  {z21.s}, p5/z, [x10, z21.s, sxtw #1]
fadd    z21.s, z10.s, z21.s
//CHECK: fadd    z21.s, z10.s, z21.s
sub     z21.b, z21.b, #170
//CHECK: sub     z21.b, z21.b, #170
cmpls   p15.h, p7/z, z31.h, #127
//CHECK: cmpls   p15.h, p7/z, z31.h, #127
lsr     z21.h, p5/m, z21.h, z10.h
//CHECK: lsr     z21.h, p5/m, z21.h, z10.h
umin    z0.h, z0.h, #0
//CHECK: umin    z0.h, z0.h, #0
fadd    z23.h, p3/m, z23.h, #1.0
//CHECK: fadd    z23.h, p3/m, z23.h, #1.0
zip2    p7.h, p13.h, p8.h
//CHECK: zip2    p7.h, p13.h, p8.h
ldff1sh {z0.s}, p0/z, [z0.s]
//CHECK: ldff1sh {z0.s}, p0/z, [z0.s]
insr    z31.s, wzr
//CHECK: insr    z31.s, wzr
sqincd  z31.d, all, mul #16
//CHECK: sqincd  z31.d, all, mul #16
eor     z0.s, p0/m, z0.s, z0.s
//CHECK: eor     z0.s, p0/m, z0.s, z0.s
cmpls   p15.b, p7/z, z31.b, z31.d
//CHECK: cmpls   p15.b, p7/z, z31.b, z31.d
ldff1d  {z23.d}, p3/z, [x13, z8.d, sxtw #3]
//CHECK: ldff1d  {z23.d}, p3/z, [x13, z8.d, sxtw #3]
whilelt p0.h, x0, x0
//CHECK: whilelt p0.h, x0, x0
ldff1b  {z23.d}, p3/z, [x13, z8.d]
//CHECK: ldff1b  {z23.d}, p3/z, [x13, z8.d]
frintz  z23.d, p3/m, z13.d
//CHECK: frintz  z23.d, p3/m, z13.d
ld4d    {z5.d, z6.d, z7.d, z8.d}, p3/z, [x17, x16, lsl #3]
//CHECK: ld4d    {z5.d, z6.d, z7.d, z8.d}, p3/z, [x17, x16, lsl #3]
not     p0.b, p0/z, p0.b
//CHECK: not     p0.b, p0/z, p0.b
insr    z31.b, b31
//CHECK: insr    z31.b, b31
ld1rb   {z21.b}, p5/z, [x10, #21]
//CHECK: ld1rb   {z21.b}, p5/z, [x10, #21]
lsl     z23.b, z13.b, #0
//CHECK: lsl     z23.b, z13.b, #0
scvtf   z23.h, p3/m, z13.h
//CHECK: scvtf   z23.h, p3/m, z13.h
revw    z21.d, p5/m, z10.d
//CHECK: revw    z21.d, p5/m, z10.d
ldnt1w  {z23.s}, p3/z, [x13, x8, lsl #2]
//CHECK: ldnt1w  {z23.s}, p3/z, [x13, x8, lsl #2]
ld1h    {z21.s}, p5/z, [x10, z21.s, sxtw #1]
//CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, sxtw #1]
uxth    z31.d, p7/m, z31.d
//CHECK: uxth    z31.d, p7/m, z31.d
ld1sb   {z21.d}, p5/z, [x10, x21]
//CHECK: ld1sb   {z21.d}, p5/z, [x10, x21]
fsqrt   z23.d, p3/m, z13.d
//CHECK: fsqrt   z23.d, p3/m, z13.d
adr     z0.d, [z0.d, z0.d, lsl #3]
//CHECK: adr     z0.d, [z0.d, z0.d, lsl #3]
fsub    z23.s, p3/m, z23.s, z13.s
//CHECK: fsub    z23.s, p3/m, z23.s, z13.s
cnth    xzr, all, mul #16
//CHECK: cnth    xzr, all, mul #16
fmin    z0.d, p0/m, z0.d, z0.d
//CHECK: fmin    z0.d, p0/m, z0.d, z0.d
fmin    z23.h, p3/m, z23.h, #1.0
//CHECK: fmin    z23.h, p3/m, z23.h, #1.0
prfw    #15, p7, [sp, z31.d, sxtw #2]
//CHECK: prfw    #15, p7, [sp, z31.d, sxtw #2]
ld1h    {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, uxtw]
ldff1d  {z21.d}, p5/z, [z10.d, #168]
//CHECK: ldff1d  {z21.d}, p5/z, [z10.d, #168]
fscale  z31.d, p7/m, z31.d, z31.d
//CHECK: fscale  z31.d, p7/m, z31.d, z31.d
sabd    z31.b, p7/m, z31.b, z31.b
//CHECK: sabd    z31.b, p7/m, z31.b, z31.b
sqincw  x21, vl32, mul #6
//CHECK: sqincw  x21, vl32, mul #6
ld1sb   {z21.s}, p5/z, [x10, z21.s, sxtw]
//CHECK: ld1sb   {z21.s}, p5/z, [x10, z21.s, sxtw]
sunpkhi z23.s, z13.h
//CHECK: sunpkhi z23.s, z13.h
smin    z31.h, p7/m, z31.h, z31.h
//CHECK: smin    z31.h, p7/m, z31.h, z31.h
prfh    pldl1keep, p0, [x0, z0.s, uxtw #1]
//CHECK: prfh    pldl1keep, p0, [x0, z0.s, uxtw #1]
ld1b    {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ld1b    {z21.d}, p5/z, [x10, z21.d, uxtw]
ld1sb   {z0.d}, p0/z, [x0]
//CHECK: ld1sb   {z0.d}, p0/z, [x0]
st1b    {z21.d}, p5, [z10.d, #21]
//CHECK: st1b    {z21.d}, p5, [z10.d, #21]
ld1d    {z23.d}, p3/z, [x13, z8.d]
//CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d]
fcvtzs  z21.s, p5/m, z10.d
//CHECK: fcvtzs  z21.s, p5/m, z10.d
clasta  xzr, p7, xzr, z31.d
//CHECK: clasta  xzr, p7, xzr, z31.d
ld1b    {z23.s}, p3/z, [x13, z8.s, uxtw]
//CHECK: ld1b    {z23.s}, p3/z, [x13, z8.s, uxtw]
sqdecp  x21, p10.b
//CHECK: sqdecp  x21, p10.b
mad     z21.d, p5/m, z21.d, z10.d
//CHECK: mad     z21.d, p5/m, z21.d, z10.d
mov     z23.b, w13
//CHECK: mov     z23.b, w13
revw    z0.d, p0/m, z0.d
//CHECK: revw    z0.d, p0/m, z0.d
ldnf1w  {z0.d}, p0/z, [x0]
//CHECK: ldnf1w  {z0.d}, p0/z, [x0]
movprfx z31.h, p7/z, z31.h
//CHECK: movprfx z31.h, p7/z, z31.h
add     z31.h, p7/m, z31.h, z0.h
//CHECK: add z31.h, p7/m, z31.h, z0.h
add     z21.d, z10.d, z21.d
//CHECK: add     z21.d, z10.d, z21.d
fsub    z21.h, p5/m, z21.h, #0.5
//CHECK: fsub    z21.h, p5/m, z21.h, #0.5
uzp2    z21.d, z10.d, z21.d
//CHECK: uzp2    z21.d, z10.d, z21.d
ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw]
//CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw]
st2w    {z23.s, z24.s}, p3, [x13, #-16, mul vl]
//CHECK: st2w    {z23.s, z24.s}, p3, [x13, #-16, mul vl]
cmphs   p7.s, p3/z, z13.s, #35
//CHECK: cmphs   p7.s, p3/z, z13.s, #35
lastb   d21, p5, z10.d
//CHECK: lastb   d21, p5, z10.d
fcmle   p0.s, p0/z, z0.s, #0.0
//CHECK: fcmle   p0.s, p0/z, z0.s, #0.0
st3h    {z21.h, z22.h, z23.h}, p5, [x10, #15, mul vl]
//CHECK: st3h    {z21.h, z22.h, z23.h}, p5, [x10, #15, mul vl]
st3w    {z21.s, z22.s, z23.s}, p5, [x10, x21, lsl #2]
//CHECK: st3w    {z21.s, z22.s, z23.s}, p5, [x10, x21, lsl #2]
movprfx z21.s, p5/z, z10.s
//CHECK: movprfx z21.s, p5/z, z10.s
add     z21.s, p5/m, z21.s, z22.s
//CHECK: add z21.s, p5/m, z21.s, z22.s
uunpkhi z0.h, z0.b
//CHECK: uunpkhi z0.h, z0.b
ld1b    {z0.s}, p0/z, [z0.s]
//CHECK: ld1b    {z0.s}, p0/z, [z0.s]
tbl     z21.b, {z10.b}, z21.b
//CHECK: tbl     z21.b, {z10.b}, z21.b
ldnf1h  {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1h  {z23.d}, p3/z, [x13, #-8, mul vl]
ld1rqb  {z31.b}, p7/z, [sp, #-16]
//CHECK: ld1rqb  {z31.b}, p7/z, [sp, #-16]
ucvtf   z23.d, p3/m, z13.d
//CHECK: ucvtf   z23.d, p3/m, z13.d
uqincp  wzr, p15.b
//CHECK: uqincp  wzr, p15.b
cls     z23.s, p3/m, z13.s
//CHECK: cls     z23.s, p3/m, z13.s
st1b    {z21.s}, p5, [x10, z21.s, uxtw]
//CHECK: st1b    {z21.s}, p5, [x10, z21.s, uxtw]
fmul    z21.d, p5/m, z21.d, #0.5
//CHECK: fmul    z21.d, p5/m, z21.d, #0.5
whilelo p0.s, w0, w0
//CHECK: whilelo p0.s, w0, w0
st1w    {z23.d}, p3, [x13, z8.d]
//CHECK: st1w    {z23.d}, p3, [x13, z8.d]
fmul    z31.s, p7/m, z31.s, z31.s
//CHECK: fmul    z31.s, p7/m, z31.s, z31.s
ldff1w  {z31.d}, p7/z, [sp, z31.d, lsl #2]
//CHECK: ldff1w  {z31.d}, p7/z, [sp, z31.d, lsl #2]
fmls    z0.d, z0.d, z0.d[0]
//CHECK: fmls    z0.d, z0.d, z0.d[0]
ldff1h  {z31.d}, p7/z, [z31.d, #62]
//CHECK: ldff1h  {z31.d}, p7/z, [z31.d, #62]
uzp2    z23.b, z13.b, z8.b
//CHECK: uzp2    z23.b, z13.b, z8.b
cmpne   p7.s, p3/z, z13.s, z8.d
//CHECK: cmpne   p7.s, p3/z, z13.s, z8.d
ld1b    {z31.s}, p7/z, [z31.s, #31]
//CHECK: ld1b    {z31.s}, p7/z, [z31.s, #31]
lsr     z21.s, p5/m, z21.s, z10.s
//CHECK: lsr     z21.s, p5/m, z21.s, z10.s
ld1rqd  {z5.d}, p3/z, [x17, x16, lsl #3]
//CHECK: ld1rqd  {z5.d}, p3/z, [x17, x16, lsl #3]
fcmuo   p0.h, p0/z, z0.h, z0.h
//CHECK: fcmuo   p0.h, p0/z, z0.h, z0.h
ucvtf   z0.h, p0/m, z0.s
//CHECK: ucvtf   z0.h, p0/m, z0.s
st1w    {z31.s}, p7, [sp, z31.s, sxtw]
//CHECK: st1w    {z31.s}, p7, [sp, z31.s, sxtw]
fcvtzu  z21.h, p5/m, z10.h
//CHECK: fcvtzu  z21.h, p5/m, z10.h
zip2    z23.d, z13.d, z8.d
//CHECK: zip2    z23.d, z13.d, z8.d
ldnf1d  {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1d  {z23.d}, p3/z, [x13, #-8, mul vl]
uabd    z0.s, p0/m, z0.s, z0.s
//CHECK: uabd    z0.s, p0/m, z0.s, z0.s
ld1sb   {z23.s}, p3/z, [x13, z8.s, uxtw]
//CHECK: ld1sb   {z23.s}, p3/z, [x13, z8.s, uxtw]
ucvtf   z21.h, p5/m, z10.s
//CHECK: ucvtf   z21.h, p5/m, z10.s
st1h    {z21.d}, p5, [x10, z21.d, uxtw]
//CHECK: st1h    {z21.d}, p5, [x10, z21.d, uxtw]
uqincw  z23.s, vl256, mul #9
//CHECK: uqincw  z23.s, vl256, mul #9
st2d    {z23.d, z24.d}, p3, [x13, #-16, mul vl]
//CHECK: st2d    {z23.d, z24.d}, p3, [x13, #-16, mul vl]
asr     z23.s, z13.s, z8.d
//CHECK: asr     z23.s, z13.s, z8.d
fcvt    z0.h, p0/m, z0.d
//CHECK: fcvt    z0.h, p0/m, z0.d
ldff1sb {z21.s}, p5/z, [x10, z21.s, uxtw]
//CHECK: ldff1sb {z21.s}, p5/z, [x10, z21.s, uxtw]
cls     z21.h, p5/m, z10.h
//CHECK: cls     z21.h, p5/m, z10.h
fmls    z21.d, z10.d, z5.d[1]
//CHECK: fmls    z21.d, z10.d, z5.d[1]
add     z23.h, p3/m, z23.h, z13.h
//CHECK: add     z23.h, p3/m, z23.h, z13.h
mov     z23.s, p8/m, #109, lsl #8
//CHECK: mov     z23.s, p8/m, #27904
ld1rh   {z21.s}, p5/z, [x10, #42]
//CHECK: ld1rh   {z21.s}, p5/z, [x10, #42]
fadda   h31, p7, h31, z31.h
//CHECK: fadda   h31, p7, h31, z31.h
addpl   x0, x0, #0
//CHECK: addpl   x0, x0, #0
st1w    {z21.d}, p5, [x10, #5, mul vl]
//CHECK: st1w    {z21.d}, p5, [x10, #5, mul vl]
fsubr   z23.d, p3/m, z23.d, #1.0
//CHECK: fsubr   z23.d, p3/m, z23.d, #1.0
ldff1w  {z21.d}, p5/z, [x10, z21.d, sxtw #2]
//CHECK: ldff1w  {z21.d}, p5/z, [x10, z21.d, sxtw #2]
ld1sw   {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ld1sw   {z31.d}, p7/z, [sp, z31.d, sxtw]
fcmne   p7.d, p3/z, z13.d, #0.0
//CHECK: fcmne   p7.d, p3/z, z13.d, #0.0
ptrue   p7.b, vl256
//CHECK: ptrue   p7.b, vl256
ldff1sb {z0.d}, p0/z, [x0, z0.d]
//CHECK: ldff1sb {z0.d}, p0/z, [x0, z0.d]
fneg    z31.h, p7/m, z31.h
//CHECK: fneg    z31.h, p7/m, z31.h
sqdecb  x21, vl32, mul #6
//CHECK: sqdecb  x21, vl32, mul #6
fsub    z31.h, z31.h, z31.h
//CHECK: fsub    z31.h, z31.h, z31.h
fsubr   z23.s, p3/m, z23.s, #1.0
//CHECK: fsubr   z23.s, p3/m, z23.s, #1.0
uaddv   d23, p3, z13.d
//CHECK: uaddv   d23, p3, z13.d
ld1w    {z21.s}, p5/z, [x10, z21.s, uxtw]
//CHECK: ld1w    {z21.s}, p5/z, [x10, z21.s, uxtw]
st1b    {z0.d}, p0, [x0, x0]
//CHECK: st1b    {z0.d}, p0, [x0, x0]
uqdecd  x0, pow2
//CHECK: uqdecd  x0, pow2
ldff1d  {z23.d}, p3/z, [x13, z8.d, uxtw #3]
//CHECK: ldff1d  {z23.d}, p3/z, [x13, z8.d, uxtw #3]
adr     z31.d, [z31.d, z31.d, lsl #2]
//CHECK: adr     z31.d, [z31.d, z31.d, lsl #2]
not     z21.b, p5/m, z10.b
//CHECK: not     z21.b, p5/m, z10.b
ldff1d  {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ldff1d  {z0.d}, p0/z, [x0, z0.d, uxtw]
ld1sw   {z21.d}, p5/z, [x10, z21.d, sxtw #2]
//CHECK: ld1sw   {z21.d}, p5/z, [x10, z21.d, sxtw #2]
uqsub   z23.h, z13.h, z8.h
//CHECK: uqsub   z23.h, z13.h, z8.h
fcmge   p7.d, p3/z, z13.d, #0.0
//CHECK: fcmge   p7.d, p3/z, z13.d, #0.0
cmpeq   p5.h, p5/z, z10.h, z21.d
//CHECK: cmpeq   p5.h, p5/z, z10.h, z21.d
fsubr   z23.d, p3/m, z23.d, z13.d
//CHECK: fsubr   z23.d, p3/m, z23.d, z13.d
ld1rb   {z21.s}, p5/z, [x10, #21]
//CHECK: ld1rb   {z21.s}, p5/z, [x10, #21]
whilelo p15.d, wzr, wzr
//CHECK: whilelo p15.d, wzr, wzr
frintn  z31.d, p7/m, z31.d
//CHECK: frintn  z31.d, p7/m, z31.d
lsr     z21.s, z10.s, z21.d
//CHECK: lsr     z21.s, z10.s, z21.d
fdiv    z31.d, p7/m, z31.d, z31.d
//CHECK: fdiv    z31.d, p7/m, z31.d, z31.d
tbl     z31.s, {z31.s}, z31.s
//CHECK: tbl     z31.s, {z31.s}, z31.s
sunpklo z31.s, z31.h
//CHECK: sunpklo z31.s, z31.h
mul     z23.d, z23.d, #109
//CHECK: mul     z23.d, z23.d, #109
fmulx   z23.s, p3/m, z23.s, z13.s
//CHECK: fmulx   z23.s, p3/m, z23.s, z13.s
fmin    z31.s, p7/m, z31.s, #1.0
//CHECK: fmin    z31.s, p7/m, z31.s, #1.0
cls     z31.s, p7/m, z31.s
//CHECK: cls     z31.s, p7/m, z31.s
uqdecp  z23.s, p13
//CHECK: uqdecp  z23.s, p13
smax    z0.h, p0/m, z0.h, z0.h
//CHECK: smax    z0.h, p0/m, z0.h, z0.h
cmpgt   p5.s, p5/z, z10.s, z21.d
//CHECK: cmpgt   p5.s, p5/z, z10.s, z21.d
uqincp  x23, p13.h
//CHECK: uqincp  x23, p13.h
punpklo p5.h, p10.b
//CHECK: punpklo p5.h, p10.b
fmax    z21.d, p5/m, z21.d, z10.d
//CHECK: fmax    z21.d, p5/m, z21.d, z10.d
clz     z0.s, p0/m, z0.s
//CHECK: clz     z0.s, p0/m, z0.s
sel     z23.h, p11, z13.h, z8.h
//CHECK: sel     z23.h, p11, z13.h, z8.h
lsr     z0.h, p0/m, z0.h, #16
//CHECK: lsr     z0.h, p0/m, z0.h, #16
ldff1b  {z21.s}, p5/z, [x10, x21]
//CHECK: ldff1b  {z21.s}, p5/z, [x10, x21]
fcvtzu  z0.h, p0/m, z0.h
//CHECK: fcvtzu  z0.h, p0/m, z0.h
ld1h    {z23.s}, p3/z, [x13, z8.s, uxtw]
//CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, uxtw]
ldff1w  {z0.d}, p0/z, [x0, z0.d, lsl #2]
//CHECK: ldff1w  {z0.d}, p0/z, [x0, z0.d, lsl #2]
ldff1sb {z31.d}, p7/z, [sp, xzr]
//CHECK: ldff1sb {z31.d}, p7/z, [sp]
sqadd   z23.s, z13.s, z8.s
//CHECK: sqadd   z23.s, z13.s, z8.s
sdivr   z31.s, p7/m, z31.s, z31.s
//CHECK: sdivr   z31.s, p7/m, z31.s, z31.s
mov     z0.b, #0
//CHECK: mov     z0.b, #0
cmpne   p5.d, p5/z, z10.d, #-11
//CHECK: cmpne   p5.d, p5/z, z10.d, #-11
dech    x21, vl32, mul #6
//CHECK: dech    x21, vl32, mul #6
st3w    {z23.s, z24.s, z25.s}, p3, [x13, x8, lsl #2]
//CHECK: st3w    {z23.s, z24.s, z25.s}, p3, [x13, x8, lsl #2]
cmpne   p5.h, p5/z, z10.h, #-11
//CHECK: cmpne   p5.h, p5/z, z10.h, #-11
cmplo   p7.s, p3/z, z13.s, #35
//CHECK: cmplo   p7.s, p3/z, z13.s, #35
revb    z31.d, p7/m, z31.d
//CHECK: revb    z31.d, p7/m, z31.d
cmphs   p0.b, p0/z, z0.b, #0
//CHECK: cmphs   p0.b, p0/z, z0.b, #0
lsr     z21.s, p5/m, z21.s, z10.d
//CHECK: lsr     z21.s, p5/m, z21.s, z10.d
asrd    z0.b, p0/m, z0.b, #8
//CHECK: asrd    z0.b, p0/m, z0.b, #8
ld1sb   {z0.d}, p0/z, [x0, z0.d]
//CHECK: ld1sb   {z0.d}, p0/z, [x0, z0.d]
cntd    xzr, all, mul #16
//CHECK: cntd    xzr, all, mul #16
nor     p0.b, p0/z, p0.b, p0.b
//CHECK: nor     p0.b, p0/z, p0.b, p0.b
uqincd  x0, pow2
//CHECK: uqincd  x0, pow2
st1w    {z0.s}, p0, [x0, x0, lsl #2]
//CHECK: st1w    {z0.s}, p0, [x0, x0, lsl #2]
ftssel  z31.h, z31.h, z31.h
//CHECK: ftssel  z31.h, z31.h, z31.h
sqdecw  x23, w23, vl256, mul #9
//CHECK: sqdecw  x23, w23, vl256, mul #9
asr     z21.b, p5/m, z21.b, z10.b
//CHECK: asr     z21.b, p5/m, z21.b, z10.b
uqincp  x0, p0.b
//CHECK: uqincp  x0, p0.b
mov     z21.s, w10
//CHECK: mov     z21.s, w10
umax    z31.s, p7/m, z31.s, z31.s
//CHECK: umax    z31.s, p7/m, z31.s, z31.s
and     z23.d, p3/m, z23.d, z13.d
//CHECK: and     z23.d, p3/m, z23.d, z13.d
lsl     z0.h, p0/m, z0.h, z0.d
//CHECK: lsl     z0.h, p0/m, z0.h, z0.d
trn1    z21.b, z10.b, z21.b
//CHECK: trn1    z21.b, z10.b, z21.b
cnot    z31.s, p7/m, z31.s
//CHECK: cnot    z31.s, p7/m, z31.s
ldnt1b  {z5.b}, p3/z, [x17, x16]
//CHECK: ldnt1b  {z5.b}, p3/z, [x17, x16]
lsr     z31.h, z31.h, z31.d
//CHECK: lsr     z31.h, z31.h, z31.d
ld1w    {z23.d}, p3/z, [x13, z8.d]
//CHECK: ld1w    {z23.d}, p3/z, [x13, z8.d]
fneg    z21.h, p5/m, z10.h
//CHECK: fneg    z21.h, p5/m, z10.h
saddv   d23, p3, z13.s
//CHECK: saddv   d23, p3, z13.s
uqsub   z0.d, z0.d, z0.d
//CHECK: uqsub   z0.d, z0.d, z0.d
ptrues  p0.h, pow2
//CHECK: ptrues  p0.h, pow2
st1b    {z21.h}, p5, [x10, x21]
//CHECK: st1b    {z21.h}, p5, [x10, x21]
uqinch  z0.h, pow2
//CHECK: uqinch  z0.h, pow2
and     z0.h, p0/m, z0.h, z0.h
//CHECK: and     z0.h, p0/m, z0.h, z0.h
ld1w    {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ld1w    {z21.d}, p5/z, [x10, z21.d, sxtw]
cmpeq   p0.s, p0/z, z0.s, #0
//CHECK: cmpeq   p0.s, p0/z, z0.s, #0
whilelt p15.b, xzr, xzr
//CHECK: whilelt p15.b, xzr, xzr
st1w    {z23.d}, p3, [x13, z8.d, uxtw]
//CHECK: st1w    {z23.d}, p3, [x13, z8.d, uxtw]
ftmad   z23.d, z23.d, z13.d, #0
//CHECK: ftmad   z23.d, z23.d, z13.d, #0
ld1sb   {z5.d}, p3/z, [x17, x16]
//CHECK: ld1sb   {z5.d}, p3/z, [x17, x16]
wrffr   p13.b
//CHECK: wrffr   p13.b
sqincp  x21, p10.b, w21
//CHECK: sqincp  x21, p10.b, w21
whilels p5.b, x10, x21
//CHECK: whilels p5.b, x10, x21
subr    z21.b, p5/m, z21.b, z10.b
//CHECK: subr    z21.b, p5/m, z21.b, z10.b
ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, x8, lsl #1]
//CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, x8, lsl #1]
sqincp  xzr, p15.s
//CHECK: sqincp  xzr, p15.s
add     z23.s, p3/m, z23.s, z13.s
//CHECK: add     z23.s, p3/m, z23.s, z13.s
frecpe  z23.s, z13.s
//CHECK: frecpe  z23.s, z13.s
adr     z23.d, [z13.d, z8.d]
//CHECK: adr     z23.d, [z13.d, z8.d]
fmad    z21.d, p5/m, z10.d, z21.d
//CHECK: fmad    z21.d, p5/m, z10.d, z21.d
fminnm  z31.s, p7/m, z31.s, z31.s
//CHECK: fminnm  z31.s, p7/m, z31.s, z31.s
sqincp  x21, p10.b
//CHECK: sqincp  x21, p10.b
scvtf   z21.h, p5/m, z10.d
//CHECK: scvtf   z21.h, p5/m, z10.d
ftssel  z21.h, z10.h, z21.h
//CHECK: ftssel  z21.h, z10.h, z21.h
ld1h    {z23.s}, p3/z, [x13, z8.s, sxtw #1]
//CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, sxtw #1]
splice  z21.b, p5, z21.b, z10.b
//CHECK: splice  z21.b, p5, z21.b, z10.b
ld1sb   {z23.h}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1sb   {z23.h}, p3/z, [x13, #-8, mul vl]
smax    z21.b, z21.b, #-86
//CHECK: smax    z21.b, z21.b, #-86
mov     z1.d, #0xffff00000003ffff
//CHECK: mov     z1.d, #0xffff00000003ffff
ld1rqb  {z0.b}, p0/z, [x0]
//CHECK: ld1rqb  {z0.b}, p0/z, [x0]
sdivr   z23.d, p3/m, z23.d, z13.d
//CHECK: sdivr   z23.d, p3/m, z23.d, z13.d
uqincp  x0, p0.d
//CHECK: uqincp  x0, p0.d
inch    z21.h, vl32, mul #6
//CHECK: inch    z21.h, vl32, mul #6
ld1rqd  {z23.d}, p3/z, [x13, x8, lsl #3]
//CHECK: ld1rqd  {z23.d}, p3/z, [x13, x8, lsl #3]
ld1h    {z5.h}, p3/z, [x17, x16, lsl #1]
//CHECK: ld1h    {z5.h}, p3/z, [x17, x16, lsl #1]
ld1rw   {z0.d}, p0/z, [x0]
//CHECK: ld1rw   {z0.d}, p0/z, [x0]
ldnf1sb {z0.d}, p0/z, [x0]
//CHECK: ldnf1sb {z0.d}, p0/z, [x0]
fcmeq   p0.s, p0/z, z0.s, z0.s
//CHECK: fcmeq   p0.s, p0/z, z0.s, z0.s
ld1sb   {z5.h}, p3/z, [x17, x16]
//CHECK: ld1sb   {z5.h}, p3/z, [x17, x16]
scvtf   z31.s, p7/m, z31.s
//CHECK: scvtf   z31.s, p7/m, z31.s
mul     z21.b, p5/m, z21.b, z10.b
//CHECK: mul     z21.b, p5/m, z21.b, z10.b
stnt1d  {z5.d}, p3, [x17, x16, lsl #3]
//CHECK: stnt1d  {z5.d}, p3, [x17, x16, lsl #3]
uaddv   d21, p5, z10.h
//CHECK: uaddv   d21, p5, z10.h
st3h    {z31.h, z0.h, z1.h}, p7, [sp, #-3, mul vl]
//CHECK: st3h    {z31.h, z0.h, z1.h}, p7, [sp, #-3, mul vl]
trn2    p0.d, p0.d, p0.d
//CHECK: trn2    p0.d, p0.d, p0.d
sunpklo z31.h, z31.b
//CHECK: sunpklo z31.h, z31.b
cmpge   p7.d, p3/z, z13.d, #8
//CHECK: cmpge   p7.d, p3/z, z13.d, #8
orv     d23, p3, z13.d
//CHECK: orv     d23, p3, z13.d
frsqrts z21.h, z10.h, z21.h
//CHECK: frsqrts z21.h, z10.h, z21.h
cmpgt   p0.h, p0/z, z0.h, z0.d
//CHECK: cmpgt   p0.h, p0/z, z0.h, z0.d
st1b    {z5.b}, p3, [x17, x16]
//CHECK: st1b    {z5.b}, p3, [x17, x16]
lsrr    z31.h, p7/m, z31.h, z31.h
//CHECK: lsrr    z31.h, p7/m, z31.h, z31.h
cmpgt   p5.s, p5/z, z10.s, #-11
//CHECK: cmpgt   p5.s, p5/z, z10.s, #-11
add     z31.s, p7/m, z31.s, z31.s
//CHECK: add     z31.s, p7/m, z31.s, z31.s
brkpa   p5.b, p5/z, p10.b, p5.b
//CHECK: brkpa   p5.b, p5/z, p10.b, p5.b
st1b    {z21.h}, p5, [x10, #5, mul vl]
//CHECK: st1b    {z21.h}, p5, [x10, #5, mul vl]
cmplo   p0.h, p0/z, z0.h, z0.d
//CHECK: cmplo   p0.h, p0/z, z0.h, z0.d
prfw    pldl1keep, p0, [x0, z0.d, uxtw #2]
//CHECK: prfw    pldl1keep, p0, [x0, z0.d, uxtw #2]
fminnm  z31.h, p7/m, z31.h, z31.h
//CHECK: fminnm  z31.h, p7/m, z31.h, z31.h
st1d    {z23.d}, p3, [x13, z8.d, sxtw]
//CHECK: st1d    {z23.d}, p3, [x13, z8.d, sxtw]
whilelt p0.s, x0, x0
//CHECK: whilelt p0.s, x0, x0
rdffr   p7.b
//CHECK: rdffr   p7.b
lsl     z23.s, z13.s, #8
//CHECK: lsl     z23.s, z13.s, #8
uzp1    z23.b, z13.b, z8.b
//CHECK: uzp1    z23.b, z13.b, z8.b
whilelt p15.h, wzr, wzr
//CHECK: whilelt p15.h, wzr, wzr
whilele p5.b, x10, x21
//CHECK: whilele p5.b, x10, x21
asr     z31.b, p7/m, z31.b, z31.b
//CHECK: asr     z31.b, p7/m, z31.b, z31.b
fmov    z21.d, #-13.0
//CHECK: fmov    z21.d, #-13.0
asr     z21.b, p5/m, z21.b, #6
//CHECK: asr     z21.b, p5/m, z21.b, #6
frintx  z23.h, p3/m, z13.h
//CHECK: frintx  z23.h, p3/m, z13.h
uzp2    p5.s, p10.s, p5.s
//CHECK: uzp2    p5.s, p10.s, p5.s
decp    x0, p0.d
//CHECK: decp    x0, p0.d
fminnmv d31, p7, z31.d
//CHECK: fminnmv d31, p7, z31.d
lastb   s0, p0, z0.s
//CHECK: lastb   s0, p0, z0.s
cmphs   p7.h, p3/z, z13.h, z8.d
//CHECK: cmphs   p7.h, p3/z, z13.h, z8.d
ldnf1w  {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1w  {z31.d}, p7/z, [sp, #-1, mul vl]
and     z0.d, p0/m, z0.d, z0.d
//CHECK: and     z0.d, p0/m, z0.d, z0.d
sub     z31.d, z31.d, z31.d
//CHECK: sub     z31.d, z31.d, z31.d
mul     z23.b, z23.b, #109
//CHECK: mul     z23.b, z23.b, #109
sminv   s0, p0, z0.s
//CHECK: sminv   s0, p0, z0.s
mov     z0.b, p0/m, w0
//CHECK: mov     z0.b, p0/m, w0
prfw    #7, p3, [z13.s, #32]
//CHECK: prfw    #7, p3, [z13.s, #32]
uqsub   z31.d, z31.d, #255, lsl #8
//CHECK: uqsub   z31.d, z31.d, #65280
st1w    {z31.d}, p7, [sp, z31.d, sxtw #2]
//CHECK: st1w    {z31.d}, p7, [sp, z31.d, sxtw #2]
ldnt1d  {z0.d}, p0/z, [x0]
//CHECK: ldnt1d  {z0.d}, p0/z, [x0]
scvtf   z31.h, p7/m, z31.d
//CHECK: scvtf   z31.h, p7/m, z31.d
ld1sh   {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ld1sh   {z0.d}, p0/z, [x0, z0.d, uxtw]
ld1sw   {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ld1sw   {z23.d}, p3/z, [x13, z8.d, sxtw]
fmaxnm  z23.d, p3/m, z23.d, z13.d
//CHECK: fmaxnm  z23.d, p3/m, z23.d, z13.d
whilele p0.b, w0, w0
//CHECK: whilele p0.b, w0, w0
fmov    z31.d, #-1.9375
//CHECK: fmov    z31.d, #-1.9375
lsl     z21.b, z10.b, z21.d
//CHECK: lsl     z21.b, z10.b, z21.d
fmla    z31.h, p7/m, z31.h, z31.h
//CHECK: fmla    z31.h, p7/m, z31.h, z31.h
fcmne   p7.d, p3/z, z13.d, z8.d
//CHECK: fcmne   p7.d, p3/z, z13.d, z8.d
uzp2    z23.d, z13.d, z8.d
//CHECK: uzp2    z23.d, z13.d, z8.d
ld1sb   {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ld1sb   {z31.d}, p7/z, [sp, z31.d, sxtw]
st1w    {z23.s}, p3, [x13, #-8, mul vl]
//CHECK: st1w    {z23.s}, p3, [x13, #-8, mul vl]
sqincd  x23, w23, vl256, mul #9
//CHECK: sqincd  x23, w23, vl256, mul #9
trn2    p7.b, p13.b, p8.b
//CHECK: trn2    p7.b, p13.b, p8.b
ld1d    {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, sxtw]
neg     z31.d, p7/m, z31.d
//CHECK: neg     z31.d, p7/m, z31.d
lslr    z23.b, p3/m, z23.b, z13.b
//CHECK: lslr    z23.b, p3/m, z23.b, z13.b
add     z0.s, z0.s, #0
//CHECK: add     z0.s, z0.s, #0
umaxv   b23, p3, z13.b
//CHECK: umaxv   b23, p3, z13.b
prfw    #15, p7, [sp, #-1, mul vl]
//CHECK: prfw    #15, p7, [sp, #-1, mul vl]
st1b    {z21.d}, p5, [x10, z21.d]
//CHECK: st1b    {z21.d}, p5, [x10, z21.d]
cntp    x21, p5, p10.d
//CHECK: cntp    x21, p5, p10.d
sxth    z31.s, p7/m, z31.s
//CHECK: sxth    z31.s, p7/m, z31.s
saddv   d21, p5, z10.h
//CHECK: saddv   d21, p5, z10.h
fsubr   z0.d, p0/m, z0.d, z0.d
//CHECK: fsubr   z0.d, p0/m, z0.d, z0.d
incw    z31.s, all, mul #16
//CHECK: incw    z31.s, all, mul #16
sqsub   z21.d, z21.d, #170
//CHECK: sqsub   z21.d, z21.d, #170
sqadd   z23.d, z23.d, #109, lsl #8
//CHECK: sqadd   z23.d, z23.d, #27904
ldff1d  {z31.d}, p7/z, [z31.d, #248]
//CHECK: ldff1d  {z31.d}, p7/z, [z31.d, #248]
not     z31.b, p7/m, z31.b
//CHECK: not     z31.b, p7/m, z31.b
st1w    {z21.d}, p5, [x10, z21.d, uxtw #2]
//CHECK: st1w    {z21.d}, p5, [x10, z21.d, uxtw #2]
lsr     z23.h, z13.h, z8.d
//CHECK: lsr     z23.h, z13.h, z8.d
frintm  z0.d, p0/m, z0.d
//CHECK: frintm  z0.d, p0/m, z0.d
frsqrts z31.s, z31.s, z31.s
//CHECK: frsqrts z31.s, z31.s, z31.s
uqdecp  z0.h, p0
//CHECK: uqdecp  z0.h, p0
smin    z0.d, p0/m, z0.d, z0.d
//CHECK: smin    z0.d, p0/m, z0.d, z0.d
fcvtzs  z0.s, p0/m, z0.h
//CHECK: fcvtzs  z0.s, p0/m, z0.h
ld1sw   {z23.d}, p3/z, [x13, z8.d, uxtw #2]
//CHECK: ld1sw   {z23.d}, p3/z, [x13, z8.d, uxtw #2]
ld2b    {z0.b, z1.b}, p0/z, [x0]
//CHECK: ld2b    {z0.b, z1.b}, p0/z, [x0]
ld1rsh  {z0.d}, p0/z, [x0]
//CHECK: ld1rsh  {z0.d}, p0/z, [x0]
clasta  h23, p3, h23, z13.h
//CHECK: clasta  h23, p3, h23, z13.h
ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw #1]
//CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw #1]
subr    z21.b, z21.b, #170
//CHECK: subr    z21.b, z21.b, #170
cmple   p0.d, p0/z, z0.d, #0
//CHECK: cmple   p0.d, p0/z, z0.d, #0
fsub    z0.d, p0/m, z0.d, #0.5
//CHECK: fsub    z0.d, p0/m, z0.d, #0.5
fmaxv   h0, p0, z0.h
//CHECK: fmaxv   h0, p0, z0.h
lasta   x0, p0, z0.d
//CHECK: lasta   x0, p0, z0.d
ld1sh   {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ld1sh   {z31.d}, p7/z, [sp, z31.d, uxtw]
decp    z21.s, p10
//CHECK: decp    z21.s, p10
incd    z0.d, pow2
//CHECK: incd    z0.d, pow2
st1d    {z21.d}, p5, [x10, z21.d, lsl #3]
//CHECK: st1d    {z21.d}, p5, [x10, z21.d, lsl #3]
fcmla   z31.s, z31.s, z15.s[1], #270
//CHECK: fcmla   z31.s, z31.s, z15.s[1], #270
scvtf   z31.s, p7/m, z31.d
//CHECK: scvtf   z31.s, p7/m, z31.d
index   z23.h, w13, #8
//CHECK: index   z23.h, w13, #8
mul     z21.s, p5/m, z21.s, z10.s
//CHECK: mul     z21.s, p5/m, z21.s, z10.s
st1w    {z21.d}, p5, [x10, z21.d, uxtw]
//CHECK: st1w    {z21.d}, p5, [x10, z21.d, uxtw]
ld1w    {z31.s}, p7/z, [sp, z31.s, uxtw]
//CHECK: ld1w    {z31.s}, p7/z, [sp, z31.s, uxtw]
lsl     z21.b, z10.b, #5
//CHECK: lsl     z21.b, z10.b, #5
sqdecp  z21.h, p10
//CHECK: sqdecp  z21.h, p10
fcmle   p7.h, p3/z, z13.h, #0.0
//CHECK: fcmle   p7.h, p3/z, z13.h, #0.0
cnt     z23.b, p3/m, z13.b
//CHECK: cnt     z23.b, p3/m, z13.b
index   z0.d, #0, #0
//CHECK: index   z0.d, #0, #0
sqdecp  x23, p13.h, w23
//CHECK: sqdecp  x23, p13.h, w23
decd    x21, vl32, mul #6
//CHECK: decd    x21, vl32, mul #6
uqdecd  z21.d, vl32, mul #6
//CHECK: uqdecd  z21.d, vl32, mul #6
ld1h    {z21.s}, p5/z, [x10, z21.s, uxtw #1]
//CHECK: ld1h    {z21.s}, p5/z, [x10, z21.s, uxtw #1]
eor     p7.b, p11/z, p13.b, p8.b
//CHECK: eor     p7.b, p11/z, p13.b, p8.b
splice  z0.s, p0, z0.s, z0.s
//CHECK: splice  z0.s, p0, z0.s, z0.s
mul     z21.b, z21.b, #-86
//CHECK: mul     z21.b, z21.b, #-86
st1w    {z21.d}, p5, [x10, z21.d, sxtw]
//CHECK: st1w    {z21.d}, p5, [x10, z21.d, sxtw]
fmov    z0.h, #2.0
//CHECK: fmov    z0.h, #2.0
eor     z23.s, p3/m, z23.s, z13.s
//CHECK: eor     z23.s, p3/m, z23.s, z13.s
cmplt   p0.h, p0/z, z0.h, #0
//CHECK: cmplt   p0.h, p0/z, z0.h, #0
fmsb    z23.h, p3/m, z13.h, z8.h
//CHECK: fmsb    z23.h, p3/m, z13.h, z8.h
ptrue   p15.d
//CHECK: ptrue   p15.d
ldnf1b  {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1b  {z31.s}, p7/z, [sp, #-1, mul vl]
umulh   z23.s, p3/m, z23.s, z13.s
//CHECK: umulh   z23.s, p3/m, z23.s, z13.s
st1h    {z31.d}, p7, [sp, z31.d, lsl #1]
//CHECK: st1h    {z31.d}, p7, [sp, z31.d, lsl #1]
udiv    z21.d, p5/m, z21.d, z10.d
//CHECK: udiv    z21.d, p5/m, z21.d, z10.d
ctermne x0, x0
//CHECK: ctermne x0, x0
prfb    pldl1keep, p0, [x0, x0]
//CHECK: prfb    pldl1keep, p0, [x0, x0]
prfb    pldl3strm, p5, [x10, z21.d, uxtw]
//CHECK: prfb    pldl3strm, p5, [x10, z21.d, uxtw]
ld1sh   {z31.s}, p7/z, [z31.s, #62]
//CHECK: ld1sh   {z31.s}, p7/z, [z31.s, #62]
ldff1w  {z21.d}, p5/z, [x10, x21, lsl #2]
//CHECK: ldff1w  {z21.d}, p5/z, [x10, x21, lsl #2]
index   z23.s, #13, w8
//CHECK: index   z23.s, #13, w8
mov     z31.s, p15/z, #-1, lsl #8
//CHECK: mov     z31.s, p15/z, #-256
ucvtf   z31.d, p7/m, z31.s
//CHECK: ucvtf   z31.d, p7/m, z31.s
decp    z21.d, p10
//CHECK: decp    z21.d, p10
prfw    pldl1keep, p0, [x0, z0.s, sxtw #2]
//CHECK: prfw    pldl1keep, p0, [x0, z0.s, sxtw #2]
asr     z21.d, z10.d, #11
//CHECK: asr     z21.d, z10.d, #11
ld3b    {z21.b, z22.b, z23.b}, p5/z, [x10, x21]
//CHECK: ld3b    {z21.b, z22.b, z23.b}, p5/z, [x10, x21]
ld1w    {z0.s}, p0/z, [x0, z0.s, uxtw #2]
//CHECK: ld1w    {z0.s}, p0/z, [x0, z0.s, uxtw #2]
sqdecd  x21, w21, vl32, mul #6
//CHECK: sqdecd  x21, w21, vl32, mul #6
add     z21.h, z10.h, z21.h
//CHECK: add     z21.h, z10.h, z21.h
incw    xzr, all, mul #16
//CHECK: incw    xzr, all, mul #16
st2d    {z31.d, z0.d}, p7, [sp, #-2, mul vl]
//CHECK: st2d    {z31.d, z0.d}, p7, [sp, #-2, mul vl]
mov     z31.d, sp
//CHECK: mov     z31.d, sp
fsqrt   z0.d, p0/m, z0.d
//CHECK: fsqrt   z0.d, p0/m, z0.d
fsubr   z23.h, p3/m, z23.h, #1.0
//CHECK: fsubr   z23.h, p3/m, z23.h, #1.0
ldff1h  {z23.d}, p3/z, [x13, z8.d]
//CHECK: ldff1h  {z23.d}, p3/z, [x13, z8.d]
ldnf1sb {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1sb {z21.s}, p5/z, [x10, #5, mul vl]
add     z21.h, z21.h, #170
//CHECK: add     z21.h, z21.h, #170
fmaxnm  z0.d, p0/m, z0.d, z0.d
//CHECK: fmaxnm  z0.d, p0/m, z0.d, z0.d
and     z0.b, p0/m, z0.b, z0.b
//CHECK: and     z0.b, p0/m, z0.b, z0.b
smax    z31.h, z31.h, #-1
//CHECK: smax    z31.h, z31.h, #-1
clastb  b21, p5, b21, z10.b
//CHECK: clastb  b21, p5, b21, z10.b
ftsmul  z21.d, z10.d, z21.d
//CHECK: ftsmul  z21.d, z10.d, z21.d
udivr   z0.s, p0/m, z0.s, z0.s
//CHECK: udivr   z0.s, p0/m, z0.s, z0.s
saddv   d31, p7, z31.h
//CHECK: saddv   d31, p7, z31.h
ld3w    {z23.s, z24.s, z25.s}, p3/z, [x13, x8, lsl #2]
//CHECK: ld3w    {z23.s, z24.s, z25.s}, p3/z, [x13, x8, lsl #2]
mov     z23.d, #109, lsl #8
//CHECK: mov     z23.d, #27904
ld1sw   {z31.d}, p7/z, [sp, z31.d, sxtw #2]
//CHECK: ld1sw   {z31.d}, p7/z, [sp, z31.d, sxtw #2]
fcmlt   p5.d, p5/z, z10.d, #0.0
//CHECK: fcmlt   p5.d, p5/z, z10.d, #0.0
uqincw  w0, pow2
//CHECK: uqincw  w0, pow2
ld1rsb  {z31.d}, p7/z, [sp, #63]
//CHECK: ld1rsb  {z31.d}, p7/z, [sp, #63]
fsubr   z21.s, p5/m, z21.s, #0.5
//CHECK: fsubr   z21.s, p5/m, z21.s, #0.5
ld1sw   {z23.d}, p3/z, [z13.d, #32]
//CHECK: ld1sw   {z23.d}, p3/z, [z13.d, #32]
uqdecp  x23, p13.d
//CHECK: uqdecp  x23, p13.d
whilelt p0.s, w0, w0
//CHECK: whilelt p0.s, w0, w0
stnt1d  {z21.d}, p5, [x10, #5, mul vl]
//CHECK: stnt1d  {z21.d}, p5, [x10, #5, mul vl]
asrr    z23.d, p3/m, z23.d, z13.d
//CHECK: asrr    z23.d, p3/m, z23.d, z13.d
fnmla   z0.d, p0/m, z0.d, z0.d
//CHECK: fnmla   z0.d, p0/m, z0.d, z0.d
fcmeq   p5.h, p5/z, z10.h, z21.h
//CHECK: fcmeq   p5.h, p5/z, z10.h, z21.h
ldff1h  {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ldff1h  {z21.d}, p5/z, [x10, z21.d, sxtw]
movprfx z23.h, p3/m, z13.h
//CHECK: movprfx z23.h, p3/m, z13.h
add     z23.h, p3/m, z23.h, z24.h
//CHECK: add z23.h, p3/m, z23.h, z24.h
lsr     z31.s, p7/m, z31.s, z31.s
//CHECK: lsr     z31.s, p7/m, z31.s, z31.s
trn1    p0.h, p0.h, p0.h
//CHECK: trn1    p0.h, p0.h, p0.h
mul     z21.h, p5/m, z21.h, z10.h
//CHECK: mul     z21.h, p5/m, z21.h, z10.h
prfb    #7, p3, [x13, #8, mul vl]
//CHECK: prfb    #7, p3, [x13, #8, mul vl]
lasta   s31, p7, z31.s
//CHECK: lasta   s31, p7, z31.s
fneg    z23.d, p3/m, z13.d
//CHECK: fneg    z23.d, p3/m, z13.d
ldnf1d  {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1d  {z31.d}, p7/z, [sp, #-1, mul vl]
zip1    p7.s, p13.s, p8.s
//CHECK: zip1    p7.s, p13.s, p8.s
lsrr    z31.d, p7/m, z31.d, z31.d
//CHECK: lsrr    z31.d, p7/m, z31.d, z31.d
fmls    z31.s, p7/m, z31.s, z31.s
//CHECK: fmls    z31.s, p7/m, z31.s, z31.s
ld1sb   {z31.s}, p7/z, [sp, z31.s, uxtw]
//CHECK: ld1sb   {z31.s}, p7/z, [sp, z31.s, uxtw]
lsl     z0.b, p0/m, z0.b, #0
//CHECK: lsl     z0.b, p0/m, z0.b, #0
scvtf   z0.d, p0/m, z0.d
//CHECK: scvtf   z0.d, p0/m, z0.d
ld1sw   {z5.d}, p3/z, [x17, x16, lsl #2]
//CHECK: ld1sw   {z5.d}, p3/z, [x17, x16, lsl #2]
ldnf1h  {z31.h}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1h  {z31.h}, p7/z, [sp, #-1, mul vl]
fmul    z23.h, z13.h, z0.h[5]
//CHECK: fmul    z23.h, z13.h, z0.h[5]
insr    z21.s, s10
//CHECK: insr    z21.s, s10
ptest   p11, p13.b
//CHECK: ptest   p11, p13.b
smin    z0.h, z0.h, #0
//CHECK: smin    z0.h, z0.h, #0
uzp1    p15.s, p15.s, p15.s
//CHECK: uzp1    p15.s, p15.s, p15.s
uqsub   z0.h, z0.h, z0.h
//CHECK: uqsub   z0.h, z0.h, z0.h
ld1h    {z0.s}, p0/z, [x0, x0, lsl #1]
//CHECK: ld1h    {z0.s}, p0/z, [x0, x0, lsl #1]
fadd    z21.d, z10.d, z21.d
//CHECK: fadd    z21.d, z10.d, z21.d
st1h    {z0.d}, p0, [x0, z0.d, uxtw]
//CHECK: st1h    {z0.d}, p0, [x0, z0.d, uxtw]
fnmad   z31.d, p7/m, z31.d, z31.d
//CHECK: fnmad   z31.d, p7/m, z31.d, z31.d
scvtf   z21.s, p5/m, z10.s
//CHECK: scvtf   z21.s, p5/m, z10.s
st1w    {z23.d}, p3, [x13, z8.d, uxtw #2]
//CHECK: st1w    {z23.d}, p3, [x13, z8.d, uxtw #2]
uqdecw  wzr, all, mul #16
//CHECK: uqdecw  wzr, all, mul #16
uqsub   z5.b, z5.b, #113
//CHECK: uqsub   z5.b, z5.b, #113
decp    z0.h, p0
//CHECK: decp    z0.h, p0
mls     z31.s, p7/m, z31.s, z31.s
//CHECK: mls     z31.s, p7/m, z31.s, z31.s
trn1    p0.s, p0.s, p0.s
//CHECK: trn1    p0.s, p0.s, p0.s
str     p15, [sp, #-1, mul vl]
//CHECK: str     p15, [sp, #-1, mul vl]
fsub    z31.d, p7/m, z31.d, #1.0
//CHECK: fsub    z31.d, p7/m, z31.d, #1.0
frinti  z31.d, p7/m, z31.d
//CHECK: frinti  z31.d, p7/m, z31.d
umaxv   d23, p3, z13.d
//CHECK: umaxv   d23, p3, z13.d
st1h    {z0.d}, p0, [x0]
//CHECK: st1h    {z0.d}, p0, [x0]
cmphi   p0.h, p0/z, z0.h, z0.d
//CHECK: cmphi   p0.h, p0/z, z0.h, z0.d
uqdecw  xzr, all, mul #16
//CHECK: uqdecw  xzr, all, mul #16
cmple   p7.s, p3/z, z13.s, z8.d
//CHECK: cmple   p7.s, p3/z, z13.s, z8.d
prfw    #15, p7, [sp, z31.d, uxtw #2]
//CHECK: prfw    #15, p7, [sp, z31.d, uxtw #2]
frsqrte z23.h, z13.h
//CHECK: frsqrte z23.h, z13.h
smulh   z31.d, p7/m, z31.d, z31.d
//CHECK: smulh   z31.d, p7/m, z31.d, z31.d
udivr   z23.s, p3/m, z23.s, z13.s
//CHECK: udivr   z23.s, p3/m, z23.s, z13.s
umulh   z0.b, p0/m, z0.b, z0.b
//CHECK: umulh   z0.b, p0/m, z0.b, z0.b
cmpeq   p0.h, p0/z, z0.h, #0
//CHECK: cmpeq   p0.h, p0/z, z0.h, #0
st1w    {z21.s}, p5, [x10, z21.s, uxtw #2]
//CHECK: st1w    {z21.s}, p5, [x10, z21.s, uxtw #2]
fcmeq   p7.h, p3/z, z13.h, z8.h
//CHECK: fcmeq   p7.h, p3/z, z13.h, z8.h
ld1d    {z23.d}, p3/z, [x13, z8.d, lsl #3]
//CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, lsl #3]
scvtf   z31.h, p7/m, z31.h
//CHECK: scvtf   z31.h, p7/m, z31.h
frintz  z21.h, p5/m, z10.h
//CHECK: frintz  z21.h, p5/m, z10.h
lasta   b31, p7, z31.b
//CHECK: lasta   b31, p7, z31.b
ldnf1sh {z0.s}, p0/z, [x0]
//CHECK: ldnf1sh {z0.s}, p0/z, [x0]
uzp2    p5.b, p10.b, p5.b
//CHECK: uzp2    p5.b, p10.b, p5.b
not     p15.b, p15/z, p15.b
//CHECK: not     p15.b, p15/z, p15.b
ld2d    {z23.d, z24.d}, p3/z, [x13, x8, lsl #3]
//CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, x8, lsl #3]
fexpa   z23.s, z13.s
//CHECK: fexpa   z23.s, z13.s
st3b    {z31.b, z0.b, z1.b}, p7, [sp, #-3, mul vl]
//CHECK: st3b    {z31.b, z0.b, z1.b}, p7, [sp, #-3, mul vl]
adr     z21.d, [z10.d, z21.d, uxtw #1]
//CHECK: adr     z21.d, [z10.d, z21.d, uxtw #1]
st1b    {z31.d}, p7, [sp, z31.d]
//CHECK: st1b    {z31.d}, p7, [sp, z31.d]
fminnmv s23, p3, z13.s
//CHECK: fminnmv s23, p3, z13.s
bic     z31.d, z31.d, z31.d
//CHECK: bic     z31.d, z31.d, z31.d
clz     z0.b, p0/m, z0.b
//CHECK: clz     z0.b, p0/m, z0.b
pnext   p5.h, p10, p5.h
//CHECK: pnext   p5.h, p10, p5.h
add     z21.b, z21.b, #170
//CHECK: add     z21.b, z21.b, #170
faddv   s0, p0, z0.s
//CHECK: faddv   s0, p0, z0.s
st1b    {z0.d}, p0, [x0]
//CHECK: st1b    {z0.d}, p0, [x0]
ldnf1w  {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1w  {z31.s}, p7/z, [sp, #-1, mul vl]
sqincp  z31.s, p15
//CHECK: sqincp  z31.s, p15
addvl   sp, sp, #-1
//CHECK: addvl   sp, sp, #-1
decp    x0, p0.s
//CHECK: decp    x0, p0.s
fcvt    z0.h, p0/m, z0.s
//CHECK: fcvt    z0.h, p0/m, z0.s
ptest   p15, p15.b
//CHECK: ptest   p15, p15.b
fcvt    z21.h, p5/m, z10.s
//CHECK: fcvt    z21.h, p5/m, z10.s
ftssel  z21.d, z10.d, z21.d
//CHECK: ftssel  z21.d, z10.d, z21.d
udivr   z31.d, p7/m, z31.d, z31.d
//CHECK: udivr   z31.d, p7/m, z31.d, z31.d
prfb    pldl3strm, p5, [x10, z21.s, sxtw]
//CHECK: prfb    pldl3strm, p5, [x10, z21.s, sxtw]
fmin    z23.h, p3/m, z23.h, z13.h
//CHECK: fmin    z23.h, p3/m, z23.h, z13.h
frsqrts z21.d, z10.d, z21.d
//CHECK: frsqrts z21.d, z10.d, z21.d
clasta  s21, p5, s21, z10.s
//CHECK: clasta  s21, p5, s21, z10.s
cmphi   p0.s, p0/z, z0.s, #0
//CHECK: cmphi   p0.s, p0/z, z0.s, #0
sel     z23.b, p11, z13.b, z8.b
//CHECK: sel     z23.b, p11, z13.b, z8.b
uzp1    z21.s, z10.s, z21.s
//CHECK: uzp1    z21.s, z10.s, z21.s
ldnf1h  {z0.d}, p0/z, [x0]
//CHECK: ldnf1h  {z0.d}, p0/z, [x0]
cmpne   p0.s, p0/z, z0.s, #0
//CHECK: cmpne   p0.s, p0/z, z0.s, #0
abs     z21.h, p5/m, z10.h
//CHECK: abs     z21.h, p5/m, z10.h
asr     z0.h, p0/m, z0.h, z0.h
//CHECK: asr     z0.h, p0/m, z0.h, z0.h
andv    s31, p7, z31.s
//CHECK: andv    s31, p7, z31.s
dupm    z21.h, #0xffc1
//CHECK: dupm    z21.h, #0xffc1
cntb    x23, vl256, mul #9
//CHECK: cntb    x23, vl256, mul #9
cmpge   p5.s, p5/z, z10.s, z21.d
//CHECK: cmpge   p5.s, p5/z, z10.s, z21.d
asr     z21.h, p5/m, z21.h, z10.h
//CHECK: asr     z21.h, p5/m, z21.h, z10.h
fadda   d21, p5, d21, z10.d
//CHECK: fadda   d21, p5, d21, z10.d
uqincp  xzr, p15.s
//CHECK: uqincp  xzr, p15.s
fcmlt   p0.d, p0/z, z0.d, #0.0
//CHECK: fcmlt   p0.d, p0/z, z0.d, #0.0
cmplo   p7.d, p3/z, z13.d, #35
//CHECK: cmplo   p7.d, p3/z, z13.d, #35
cmpgt   p7.s, p3/z, z13.s, #8
//CHECK: cmpgt   p7.s, p3/z, z13.s, #8
rev     z0.s, z0.s
//CHECK: rev     z0.s, z0.s
stnt1d  {z23.d}, p3, [x13, x8, lsl #3]
//CHECK: stnt1d  {z23.d}, p3, [x13, x8, lsl #3]
frsqrte z31.s, z31.s
//CHECK: frsqrte z31.s, z31.s
st2d    {z0.d, z1.d}, p0, [x0, x0, lsl #3]
//CHECK: st2d    {z0.d, z1.d}, p0, [x0, x0, lsl #3]
sub     z31.h, p7/m, z31.h, z31.h
//CHECK: sub     z31.h, p7/m, z31.h, z31.h
ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw #1]
//CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw #1]
movprfx z0, z0
//CHECK: movprfx z0, z0
add     z0.s, p0/m, z0.s, z1.s
//CHECK: add z0.s, p0/m, z0.s, z1.s
uminv   b31, p7, z31.b
//CHECK: uminv   b31, p7, z31.b
sqdecd  z23.d, vl256, mul #9
//CHECK: sqdecd  z23.d, vl256, mul #9
sub     z23.h, z13.h, z8.h
//CHECK: sub     z23.h, z13.h, z8.h
fcvtzu  z23.d, p3/m, z13.h
//CHECK: fcvtzu  z23.d, p3/m, z13.h
frintx  z31.h, p7/m, z31.h
//CHECK: frintx  z31.h, p7/m, z31.h
fcmeq   p15.h, p7/z, z31.h, z31.h
//CHECK: fcmeq   p15.h, p7/z, z31.h, z31.h
index   z23.h, #13, #8
//CHECK: index   z23.h, #13, #8
fcmla   z23.s, p3/m, z13.s, z8.s, #270
//CHECK: fcmla   z23.s, p3/m, z13.s, z8.s, #270
ldnf1sb {z0.h}, p0/z, [x0]
//CHECK: ldnf1sb {z0.h}, p0/z, [x0]
ftsmul  z23.s, z13.s, z8.s
//CHECK: ftsmul  z23.s, z13.s, z8.s
ldnf1h  {z21.h}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1h  {z21.h}, p5/z, [x10, #5, mul vl]
fnmsb   z0.s, p0/m, z0.s, z0.s
//CHECK: fnmsb   z0.s, p0/m, z0.s, z0.s
index   z21.h, w10, w21
//CHECK: index   z21.h, w10, w21
lsr     z31.h, z31.h, #1
//CHECK: lsr     z31.h, z31.h, #1
ftsmul  z31.d, z31.d, z31.d
//CHECK: ftsmul  z31.d, z31.d, z31.d
incp    x23, p13.d
//CHECK: incp    x23, p13.d
addvl   x0, x0, #0
//CHECK: addvl   x0, x0, #0
clastb  w21, p5, w21, z10.s
//CHECK: clastb  w21, p5, w21, z10.s
whilelt p15.h, xzr, xzr
//CHECK: whilelt p15.h, xzr, xzr
sqincp  z21.h, p10
//CHECK: sqincp  z21.h, p10
whilele p7.h, x13, x8
//CHECK: whilele p7.h, x13, x8
orv     h23, p3, z13.h
//CHECK: orv     h23, p3, z13.h
uqincp  z31.s, p15
//CHECK: uqincp  z31.s, p15
ld1rqw  {z0.s}, p0/z, [x0]
//CHECK: ld1rqw  {z0.s}, p0/z, [x0]
ld1rqw  {z23.s}, p3/z, [x13, #-128]
//CHECK: ld1rqw  {z23.s}, p3/z, [x13, #-128]
uqincp  x21, p10.h
//CHECK: uqincp  x21, p10.h
sqadd   z31.h, z31.h, z31.h
//CHECK: sqadd   z31.h, z31.h, z31.h
sqincp  xzr, p15.b
//CHECK: sqincp  xzr, p15.b
decp    x0, p0.b
//CHECK: decp    x0, p0.b
orr     z31.b, p7/m, z31.b, z31.b
//CHECK: orr     z31.b, p7/m, z31.b, z31.b
movs    p0.b, p0.b
//CHECK: movs    p0.b, p0.b
ldnf1w  {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1w  {z21.s}, p5/z, [x10, #5, mul vl]
ldff1h  {z23.h}, p3/z, [x13, x8, lsl #1]
//CHECK: ldff1h  {z23.h}, p3/z, [x13, x8, lsl #1]
smin    z31.d, p7/m, z31.d, z31.d
//CHECK: smin    z31.d, p7/m, z31.d, z31.d
whilele p0.s, x0, x0
//CHECK: whilele p0.s, x0, x0
cmpge   p0.b, p0/z, z0.b, z0.d
//CHECK: cmpge   p0.b, p0/z, z0.b, z0.d
fcvtzu  z23.h, p3/m, z13.h
//CHECK: fcvtzu  z23.h, p3/m, z13.h
clasta  w23, p3, w23, z13.s
//CHECK: clasta  w23, p3, w23, z13.s
sqdecw  z21.s, vl32, mul #6
//CHECK: sqdecw  z21.s, vl32, mul #6
ld4h    {z21.h, z22.h, z23.h, z24.h}, p5/z, [x10, #20, mul vl]
//CHECK: ld4h    {z21.h, z22.h, z23.h, z24.h}, p5/z, [x10, #20, mul vl]
sub     z0.h, z0.h, #0
//CHECK: sub     z0.h, z0.h, #0
cmplt   p5.h, p5/z, z10.h, z21.d
//CHECK: cmplt   p5.h, p5/z, z10.h, z21.d
udot    z21.s, z10.b, z5.b[2]
//CHECK: udot    z21.s, z10.b, z5.b[2]
fminnmv s0, p0, z0.s
//CHECK: fminnmv s0, p0, z0.s
ftmad   z0.d, z0.d, z0.d, #0
//CHECK: ftmad   z0.d, z0.d, z0.d, #0
fmla    z31.d, p7/m, z31.d, z31.d
//CHECK: fmla    z31.d, p7/m, z31.d, z31.d
sub     z21.h, z21.h, #170
//CHECK: sub     z21.h, z21.h, #170
fmov    z23.s, p8/m, #0.90625
//CHECK: fmov    z23.s, p8/m, #0.90625
st1w    {z23.d}, p3, [x13, z8.d, lsl #2]
//CHECK: st1w    {z23.d}, p3, [x13, z8.d, lsl #2]
cmpeq   p0.s, p0/z, z0.s, z0.d
//CHECK: cmpeq   p0.s, p0/z, z0.s, z0.d
sqincd  xzr, all, mul #16
//CHECK: sqincd  xzr, all, mul #16
fsub    z31.s, p7/m, z31.s, #1.0
//CHECK: fsub    z31.s, p7/m, z31.s, #1.0
fscale  z21.d, p5/m, z21.d, z10.d
//CHECK: fscale  z21.d, p5/m, z21.d, z10.d
clastb  z31.s, p7, z31.s, z31.s
//CHECK: clastb  z31.s, p7, z31.s, z31.s
lasta   w21, p5, z10.s
//CHECK: lasta   w21, p5, z10.s
lsr     z23.b, p3/m, z23.b, z13.b
//CHECK: lsr     z23.b, p3/m, z23.b, z13.b
prfh    pldl3strm, p5, [z10.s, #42]
//CHECK: prfh    pldl3strm, p5, [z10.s, #42]
bic     p15.b, p15/z, p15.b, p15.b
//CHECK: bic     p15.b, p15/z, p15.b, p15.b
fmin    z21.s, p5/m, z21.s, #0.0
//CHECK: fmin    z21.s, p5/m, z21.s, #0.0
ld1sh   {z31.s}, p7/z, [sp, z31.s, sxtw]
//CHECK: ld1sh   {z31.s}, p7/z, [sp, z31.s, sxtw]
st1w    {z31.s}, p7, [z31.s, #124]
//CHECK: st1w    {z31.s}, p7, [z31.s, #124]
stnt1h  {z21.h}, p5, [x10, #5, mul vl]
//CHECK: stnt1h  {z21.h}, p5, [x10, #5, mul vl]
fscale  z31.h, p7/m, z31.h, z31.h
//CHECK: fscale  z31.h, p7/m, z31.h, z31.h
cmpgt   p15.b, p7/z, z31.b, z31.d
//CHECK: cmpgt   p15.b, p7/z, z31.b, z31.d
uqdecp  x23, p13.b
//CHECK: uqdecp  x23, p13.b
zip2    z21.h, z10.h, z21.h
//CHECK: zip2    z21.h, z10.h, z21.h
fcmla   z0.s, z0.s, z0.s[0], #0
//CHECK: fcmla   z0.s, z0.s, z0.s[0], #0
mov     z31.b, wsp
//CHECK: mov     z31.b, wsp
fminv   s21, p5, z10.s
//CHECK: fminv   s21, p5, z10.s
index   z21.s, #10, #-11
//CHECK: index   z21.s, #10, #-11
sub     z21.b, p5/m, z21.b, z10.b
//CHECK: sub     z21.b, p5/m, z21.b, z10.b
frecpe  z0.s, z0.s
//CHECK: frecpe  z0.s, z0.s
uqsub   z0.b, z0.b, #0
//CHECK: uqsub   z0.b, z0.b, #0
clastb  z0.h, p0, z0.h, z0.h
//CHECK: clastb  z0.h, p0, z0.h, z0.h
revb    z21.d, p5/m, z10.d
//CHECK: revb    z21.d, p5/m, z10.d
cmpls   p7.h, p3/z, z13.h, #35
//CHECK: cmpls   p7.h, p3/z, z13.h, #35
ldff1d  {z23.d}, p3/z, [z13.d, #64]
//CHECK: ldff1d  {z23.d}, p3/z, [z13.d, #64]
lsr     z23.s, p3/m, z23.s, z13.d
//CHECK: lsr     z23.s, p3/m, z23.s, z13.d
ldff1d  {z21.d}, p5/z, [x10, z21.d, uxtw #3]
//CHECK: ldff1d  {z21.d}, p5/z, [x10, z21.d, uxtw #3]
rev     p0.s, p0.s
//CHECK: rev     p0.s, p0.s
cmphs   p0.s, p0/z, z0.s, z0.d
//CHECK: cmphs   p0.s, p0/z, z0.s, z0.d
ld1sh   {z23.d}, p3/z, [x13, z8.d]
//CHECK: ld1sh   {z23.d}, p3/z, [x13, z8.d]
ld1sw   {z23.d}, p3/z, [x13, z8.d]
//CHECK: ld1sw   {z23.d}, p3/z, [x13, z8.d]
subr    z31.d, z31.d, #255, lsl #8
//CHECK: subr    z31.d, z31.d, #65280
st1b    {z23.s}, p3, [z13.s, #8]
//CHECK: st1b    {z23.s}, p3, [z13.s, #8]
prfw    pldl1keep, p0, [z0.s]
//CHECK: prfw    pldl1keep, p0, [z0.s]
st4d    {z23.d, z24.d, z25.d, z26.d}, p3, [x13, #-32, mul vl]
//CHECK: st4d    {z23.d, z24.d, z25.d, z26.d}, p3, [x13, #-32, mul vl]
ld1h    {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, sxtw]
ldff1d  {z0.d}, p0/z, [z0.d]
//CHECK: ldff1d  {z0.d}, p0/z, [z0.d]
st1h    {z0.s}, p0, [x0, z0.s, sxtw]
//CHECK: st1h    {z0.s}, p0, [x0, z0.s, sxtw]
ld1sh   {z31.d}, p7/z, [sp, z31.d]
//CHECK: ld1sh   {z31.d}, p7/z, [sp, z31.d]
cmpls   p0.s, p0/z, z0.s, #0
//CHECK: cmpls   p0.s, p0/z, z0.s, #0
msb     z23.s, p3/m, z8.s, z13.s
//CHECK: msb     z23.s, p3/m, z8.s, z13.s
udot    z23.s, z13.b, z8.b
//CHECK: udot    z23.s, z13.b, z8.b
uxtb    z21.s, p5/m, z10.s
//CHECK: uxtb    z21.s, p5/m, z10.s
cmphi   p15.s, p7/z, z31.s, z31.d
//CHECK: cmphi   p15.s, p7/z, z31.s, z31.d
udot    z21.d, z10.h, z5.h[1]
//CHECK: udot    z21.d, z10.h, z5.h[1]
index   z0.h, #0, w0
//CHECK: index   z0.h, #0, w0
uqadd   z0.s, z0.s, z0.s
//CHECK: uqadd   z0.s, z0.s, z0.s
frintz  z31.d, p7/m, z31.d
//CHECK: frintz  z31.d, p7/m, z31.d
decp    xzr, p15.d
//CHECK: decp    xzr, p15.d
ldnf1sb {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnf1sb {z23.s}, p3/z, [x13, #-8, mul vl]
ld1w    {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1w    {z23.d}, p3/z, [x13, #-8, mul vl]
sunpkhi z0.d, z0.s
//CHECK: sunpkhi z0.d, z0.s
cmpeq   p0.d, p0/z, z0.d, #0
//CHECK: cmpeq   p0.d, p0/z, z0.d, #0
sqdecd  z0.d, pow2
//CHECK: sqdecd  z0.d, pow2
uabd    z23.h, p3/m, z23.h, z13.h
//CHECK: uabd    z23.h, p3/m, z23.h, z13.h
orr     z0.b, p0/m, z0.b, z0.b
//CHECK: orr     z0.b, p0/m, z0.b, z0.b
sqsub   z31.s, z31.s, z31.s
//CHECK: sqsub   z31.s, z31.s, z31.s
ld1rsh  {z31.d}, p7/z, [sp, #126]
//CHECK: ld1rsh  {z31.d}, p7/z, [sp, #126]
fcvtzs  z23.s, p3/m, z13.d
//CHECK: fcvtzs  z23.s, p3/m, z13.d
lsrr    z21.d, p5/m, z21.d, z10.d
//CHECK: lsrr    z21.d, p5/m, z21.d, z10.d
ldff1h  {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ldff1h  {z31.d}, p7/z, [sp, z31.d, sxtw]
zip2    p5.s, p10.s, p5.s
//CHECK: zip2    p5.s, p10.s, p5.s
ld1rb   {z23.h}, p3/z, [x13, #8]
//CHECK: ld1rb   {z23.h}, p3/z, [x13, #8]
ldnt1w  {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ldnt1w  {z21.s}, p5/z, [x10, #5, mul vl]
decd    x0, pow2
//CHECK: decd    x0, pow2
ldff1sw {z21.d}, p5/z, [x10, x21, lsl #2]
//CHECK: ldff1sw {z21.d}, p5/z, [x10, x21, lsl #2]
frsqrte z0.d, z0.d
//CHECK: frsqrte z0.d, z0.d
ldff1w  {z0.d}, p0/z, [z0.d]
//CHECK: ldff1w  {z0.d}, p0/z, [z0.d]
mov     z0.b, p0/m, z0.b
//CHECK: mov     z0.b, p0/m, z0.b
zip2    p0.b, p0.b, p0.b
//CHECK: zip2    p0.b, p0.b, p0.b
cnt     z21.d, p5/m, z10.d
//CHECK: cnt     z21.d, p5/m, z10.d
ldnf1sb {z0.s}, p0/z, [x0]
//CHECK: ldnf1sb {z0.s}, p0/z, [x0]
lasta   w23, p3, z13.b
//CHECK: lasta   w23, p3, z13.b
rdvl    xzr, #-1
//CHECK: rdvl    xzr, #-1
ucvtf   z0.d, p0/m, z0.d
//CHECK: ucvtf   z0.d, p0/m, z0.d
trn2    p5.s, p10.s, p5.s
//CHECK: trn2    p5.s, p10.s, p5.s
ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl]
//CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl]
ld1rh   {z0.d}, p0/z, [x0]
//CHECK: ld1rh   {z0.d}, p0/z, [x0]
st1d    {z23.d}, p3, [x13, z8.d]
//CHECK: st1d    {z23.d}, p3, [x13, z8.d]
cmpls   p7.s, p3/z, z13.s, #35
//CHECK: cmpls   p7.s, p3/z, z13.s, #35
sqincw  z31.s, all, mul #16
//CHECK: sqincw  z31.s, all, mul #16
prfh    #7, p3, [x13, z8.d, uxtw #1]
//CHECK: prfh    #7, p3, [x13, z8.d, uxtw #1]
ld1w    {z21.d}, p5/z, [x10, z21.d, sxtw #2]
//CHECK: ld1w    {z21.d}, p5/z, [x10, z21.d, sxtw #2]
andv    b23, p3, z13.b
//CHECK: andv    b23, p3, z13.b
ld1sh   {z31.d}, p7/z, [sp, z31.d, uxtw #1]
//CHECK: ld1sh   {z31.d}, p7/z, [sp, z31.d, uxtw #1]
adr     z23.d, [z13.d, z8.d, uxtw]
//CHECK: adr     z23.d, [z13.d, z8.d, uxtw]
fmin    z23.s, p3/m, z23.s, z13.s
//CHECK: fmin    z23.s, p3/m, z23.s, z13.s
fnmla   z31.h, p7/m, z31.h, z31.h
//CHECK: fnmla   z31.h, p7/m, z31.h, z31.h
st3d    {z0.d, z1.d, z2.d}, p0, [x0, x0, lsl #3]
//CHECK: st3d    {z0.d, z1.d, z2.d}, p0, [x0, x0, lsl #3]
ld1rqb  {z0.b}, p0/z, [x0, x0]
//CHECK: ld1rqb  {z0.b}, p0/z, [x0, x0]
cmphi   p7.d, p3/z, z13.d, #35
//CHECK: cmphi   p7.d, p3/z, z13.d, #35
mov     z31.b, z31.b[63]
//CHECK: mov     z31.b, z31.b[63]
sqadd   z23.b, z13.b, z8.b
//CHECK: sqadd   z23.b, z13.b, z8.b
incw    x0, pow2
//CHECK: incw    x0, pow2
prfd    pldl3strm, p5, [z10.d, #168]
//CHECK: prfd    pldl3strm, p5, [z10.d, #168]
fcvt    z21.h, p5/m, z10.d
//CHECK: fcvt    z21.h, p5/m, z10.d
mov     z21.h, p5/m, z10.h
//CHECK: mov     z21.h, p5/m, z10.h
st1w    {z21.d}, p5, [x10, z21.d, lsl #2]
//CHECK: st1w    {z21.d}, p5, [x10, z21.d, lsl #2]
umin    z0.b, p0/m, z0.b, z0.b
//CHECK: umin    z0.b, p0/m, z0.b, z0.b
prfb    #7, p3, [x13, z8.d]
//CHECK: prfb    #7, p3, [x13, z8.d]
fmaxnm  z0.h, p0/m, z0.h, #0.0
//CHECK: fmaxnm  z0.h, p0/m, z0.h, #0.0
smulh   z21.h, p5/m, z21.h, z10.h
//CHECK: smulh   z21.h, p5/m, z21.h, z10.h
neg     z23.h, p3/m, z13.h
//CHECK: neg     z23.h, p3/m, z13.h
nand    p5.b, p5/z, p10.b, p5.b
//CHECK: nand    p5.b, p5/z, p10.b, p5.b
st1h    {z0.s}, p0, [z0.s]
//CHECK: st1h    {z0.s}, p0, [z0.s]
lslr    z21.h, p5/m, z21.h, z10.h
//CHECK: lslr    z21.h, p5/m, z21.h, z10.h
cmplo   p0.b, p0/z, z0.b, z0.d
//CHECK: cmplo   p0.b, p0/z, z0.b, z0.d
ld1h    {z23.h}, p3/z, [x13, x8, lsl #1]
//CHECK: ld1h    {z23.h}, p3/z, [x13, x8, lsl #1]
frecpe  z21.s, z10.s
//CHECK: frecpe  z21.s, z10.s
lastb   w23, p3, z13.s
//CHECK: lastb   w23, p3, z13.s
cnt     z31.h, p7/m, z31.h
//CHECK: cnt     z31.h, p7/m, z31.h
whilels p7.d, x13, x8
//CHECK: whilels p7.d, x13, x8
lsl     z21.h, z10.h, z21.d
//CHECK: lsl     z21.h, z10.h, z21.d
fmov    z31.s, #-1.9375
//CHECK: fmov    z31.s, #-1.9375
mad     z21.h, p5/m, z21.h, z10.h
//CHECK: mad     z21.h, p5/m, z21.h, z10.h
revh    z21.d, p5/m, z10.d
//CHECK: revh    z21.d, p5/m, z10.d
splice  z23.h, p3, z23.h, z13.h
//CHECK: splice  z23.h, p3, z23.h, z13.h
uqdecd  x23, vl256, mul #9
//CHECK: uqdecd  x23, vl256, mul #9
fexpa   z21.d, z10.d
//CHECK: fexpa   z21.d, z10.d
insr    z31.h, h31
//CHECK: insr    z31.h, h31
ld1b    {z21.d}, p5/z, [x10, x21]
//CHECK: ld1b    {z21.d}, p5/z, [x10, x21]
ld1rd   {z21.d}, p5/z, [x10, #168]
//CHECK: ld1rd   {z21.d}, p5/z, [x10, #168]
movprfx z21.h, p5/m, z10.h
//CHECK: movprfx z21.h, p5/m, z10.h
add     z21.h, p5/m, z21.h, z22.h
//CHECK: add z21.h, p5/m, z21.h, z22.h
fcmne   p15.h, p7/z, z31.h, #0.0
//CHECK: fcmne   p15.h, p7/z, z31.h, #0.0
ld4w    {z21.s, z22.s, z23.s, z24.s}, p5/z, [x10, x21, lsl #2]
//CHECK: ld4w    {z21.s, z22.s, z23.s, z24.s}, p5/z, [x10, x21, lsl #2]
fmad    z21.s, p5/m, z10.s, z21.s
//CHECK: fmad    z21.s, p5/m, z10.s, z21.s
st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, #20, mul vl]
//CHECK: st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, #20, mul vl]
brkns   p0.b, p0/z, p0.b, p0.b
//CHECK: brkns   p0.b, p0/z, p0.b, p0.b
lsr     z0.h, z0.h, #16
//CHECK: lsr     z0.h, z0.h, #16
st4w    {z31.s, z0.s, z1.s, z2.s}, p7, [sp, #-4, mul vl]
//CHECK: st4w    {z31.s, z0.s, z1.s, z2.s}, p7, [sp, #-4, mul vl]
uqincp  z23.d, p13
//CHECK: uqincp  z23.d, p13
ld3b    {z0.b, z1.b, z2.b}, p0/z, [x0]
//CHECK: ld3b    {z0.b, z1.b, z2.b}, p0/z, [x0]
eorv    b23, p3, z13.b
//CHECK: eorv    b23, p3, z13.b
stnt1d  {z31.d}, p7, [sp, #-1, mul vl]
//CHECK: stnt1d  {z31.d}, p7, [sp, #-1, mul vl]
frecpe  z21.d, z10.d
//CHECK: frecpe  z21.d, z10.d
uqinch  z21.h, vl32, mul #6
//CHECK: uqinch  z21.h, vl32, mul #6
ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw]
uunpklo z31.h, z31.b
//CHECK: uunpklo z31.h, z31.b
asr     z31.h, p7/m, z31.h, z31.d
//CHECK: asr     z31.h, p7/m, z31.h, z31.d
fcmeq   p0.h, p0/z, z0.h, z0.h
//CHECK: fcmeq   p0.h, p0/z, z0.h, z0.h
cnot    z31.b, p7/m, z31.b
//CHECK: cnot    z31.b, p7/m, z31.b
st1h    {z23.s}, p3, [x13, z8.s, sxtw]
//CHECK: st1h    {z23.s}, p3, [x13, z8.s, sxtw]
fmax    z23.h, p3/m, z23.h, z13.h
//CHECK: fmax    z23.h, p3/m, z23.h, z13.h
adr     z21.s, [z10.s, z21.s, lsl #3]
//CHECK: adr     z21.s, [z10.s, z21.s, lsl #3]
uqdecp  x23, p13.h
//CHECK: uqdecp  x23, p13.h
bic     z31.s, p7/m, z31.s, z31.s
//CHECK: bic     z31.s, p7/m, z31.s, z31.s
lasta   h23, p3, z13.h
//CHECK: lasta   h23, p3, z13.h
ldr     z21, [x10, #173, mul vl]
//CHECK: ldr     z21, [x10, #173, mul vl]
mul     z23.s, z23.s, #109
//CHECK: mul     z23.s, z23.s, #109
sqdecp  xzr, p15.h
//CHECK: sqdecp  xzr, p15.h
dech    x0, pow2
//CHECK: dech    x0, pow2
saddv   d0, p0, z0.s
//CHECK: saddv   d0, p0, z0.s
mov     z23.d, p8/z, #109, lsl #8
//CHECK: mov     z23.d, p8/z, #27904
ldff1h  {z21.d}, p5/z, [x10, z21.d, lsl #1]
//CHECK: ldff1h  {z21.d}, p5/z, [x10, z21.d, lsl #1]
sdot    z0.s, z0.b, z0.b
//CHECK: sdot    z0.s, z0.b, z0.b
fmsb    z21.s, p5/m, z10.s, z21.s
//CHECK: fmsb    z21.s, p5/m, z10.s, z21.s
zip1    z23.b, z13.b, z8.b
//CHECK: zip1    z23.b, z13.b, z8.b
zip1    p0.s, p0.s, p0.s
//CHECK: zip1    p0.s, p0.s, p0.s
ldnf1sb {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1sb {z31.d}, p7/z, [sp, #-1, mul vl]
whilelt p5.d, x10, x21
//CHECK: whilelt p5.d, x10, x21
mad     z23.s, p3/m, z8.s, z13.s
//CHECK: mad     z23.s, p3/m, z8.s, z13.s
sub     z31.d, z31.d, #255, lsl #8
//CHECK: sub     z31.d, z31.d, #65280
ldff1h  {z0.d}, p0/z, [x0, z0.d, lsl #1]
//CHECK: ldff1h  {z0.d}, p0/z, [x0, z0.d, lsl #1]
fmla    z0.h, z0.h, z0.h[0]
//CHECK: fmla    z0.h, z0.h, z0.h[0]
cmpls   p15.h, p7/z, z31.h, z31.d
//CHECK: cmpls   p15.h, p7/z, z31.h, z31.d
fmaxnmv d21, p5, z10.d
//CHECK: fmaxnmv d21, p5, z10.d
fadda   s0, p0, s0, z0.s
//CHECK: fadda   s0, p0, s0, z0.s
clasta  h0, p0, h0, z0.h
//CHECK: clasta  h0, p0, h0, z0.h
cmpge   p15.h, p7/z, z31.h, z31.d
//CHECK: cmpge   p15.h, p7/z, z31.h, z31.d
ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, #-32, mul vl]
//CHECK: ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, #-32, mul vl]
ld1h    {z21.d}, p5/z, [x10, z21.d, uxtw #1]
//CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, uxtw #1]
cmple   p7.d, p3/z, z13.d, #8
//CHECK: cmple   p7.d, p3/z, z13.d, #8
uqadd   z23.d, z23.d, #109, lsl #8
//CHECK: uqadd   z23.d, z23.d, #27904
cmpne   p15.b, p7/z, z31.b, #-1
//CHECK: cmpne   p15.b, p7/z, z31.b, #-1
lastb   wzr, p7, z31.b
//CHECK: lastb   wzr, p7, z31.b
ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw]
//CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, sxtw]
mov     z21.b, z10.b[26]
//CHECK: mov     z21.b, z10.b[26]
lslr    z31.d, p7/m, z31.d, z31.d
//CHECK: lslr    z31.d, p7/m, z31.d, z31.d
sxth    z21.d, p5/m, z10.d
//CHECK: sxth    z21.d, p5/m, z10.d
ld1sb   {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ld1sb   {z0.d}, p0/z, [x0, z0.d, sxtw]
smaxv   h31, p7, z31.h
//CHECK: smaxv   h31, p7, z31.h
insr    z31.d, xzr
//CHECK: insr    z31.d, xzr
brkn    p7.b, p11/z, p13.b, p7.b
//CHECK: brkn    p7.b, p11/z, p13.b, p7.b
lsl     z21.h, z10.h, #5
//CHECK: lsl     z21.h, z10.h, #5
uxth    z21.s, p5/m, z10.s
//CHECK: uxth    z21.s, p5/m, z10.s
fminnm  z23.s, p3/m, z23.s, #1.0
//CHECK: fminnm  z23.s, p3/m, z23.s, #1.0
clasta  b31, p7, b31, z31.b
//CHECK: clasta  b31, p7, b31, z31.b
decw    z0.s, pow2
//CHECK: decw    z0.s, pow2
mov     z0.q, q0
//CHECK: mov     z0.q, q0
uqadd   z21.s, z10.s, z21.s
//CHECK: uqadd   z21.s, z10.s, z21.s
decp    x21, p10.b
//CHECK: decp    x21, p10.b
rev     z23.d, z13.d
//CHECK: rev     z23.d, z13.d
uxtb    z31.d, p7/m, z31.d
//CHECK: uxtb    z31.d, p7/m, z31.d
ldff1w  {z21.d}, p5/z, [x10, z21.d, lsl #2]
//CHECK: ldff1w  {z21.d}, p5/z, [x10, z21.d, lsl #2]
ld1rb   {z21.h}, p5/z, [x10, #21]
//CHECK: ld1rb   {z21.h}, p5/z, [x10, #21]
prfh    #7, p3, [x13, z8.s, sxtw #1]
//CHECK: prfh    #7, p3, [x13, z8.s, sxtw #1]
add     z23.d, p3/m, z23.d, z13.d
//CHECK: add     z23.d, p3/m, z23.d, z13.d
adr     z31.d, [z31.d, z31.d, lsl #1]
//CHECK: adr     z31.d, [z31.d, z31.d, lsl #1]
subr    z0.b, z0.b, #0
//CHECK: subr    z0.b, z0.b, #0
ptrues  p7.s, vl256
//CHECK: ptrues  p7.s, vl256
st1h    {z23.s}, p3, [x13, #-8, mul vl]
//CHECK: st1h    {z23.s}, p3, [x13, #-8, mul vl]
decp    xzr, p15.s
//CHECK: decp    xzr, p15.s
ld1sw   {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ld1sw   {z21.d}, p5/z, [x10, z21.d, sxtw]
sunpkhi z31.s, z31.h
//CHECK: sunpkhi z31.s, z31.h
ld1w    {z21.d}, p5/z, [x10, z21.d, uxtw #2]
//CHECK: ld1w    {z21.d}, p5/z, [x10, z21.d, uxtw #2]
fsub    z21.s, z10.s, z21.s
//CHECK: fsub    z21.s, z10.s, z21.s
ld1h    {z23.d}, p3/z, [x13, z8.d, sxtw #1]
//CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, sxtw #1]
frecpx  z0.d, p0/m, z0.d
//CHECK: frecpx  z0.d, p0/m, z0.d
inch    x21, vl32, mul #6
//CHECK: inch    x21, vl32, mul #6
uaddv   d23, p3, z13.s
//CHECK: uaddv   d23, p3, z13.s
ldnf1h  {z0.h}, p0/z, [x0]
//CHECK: ldnf1h  {z0.h}, p0/z, [x0]
fmov    z23.h, #0.90625
//CHECK: fmov    z23.h, #0.90625
fcvtzs  z31.s, p7/m, z31.h
//CHECK: fcvtzs  z31.s, p7/m, z31.h
mad     z21.s, p5/m, z21.s, z10.s
//CHECK: mad     z21.s, p5/m, z21.s, z10.s
udot    z31.s, z31.b, z31.b
//CHECK: udot    z31.s, z31.b, z31.b
ld1sh   {z5.d}, p3/z, [x17, x16, lsl #1]
//CHECK: ld1sh   {z5.d}, p3/z, [x17, x16, lsl #1]
uqdecp  x0, p0.d
//CHECK: uqdecp  x0, p0.d
uunpklo z31.d, z31.s
//CHECK: uunpklo z31.d, z31.s
uxtb    z0.d, p0/m, z0.d
//CHECK: uxtb    z0.d, p0/m, z0.d
uqsub   z23.s, z13.s, z8.s
//CHECK: uqsub   z23.s, z13.s, z8.s
st1w    {z0.d}, p0, [z0.d]
//CHECK: st1w    {z0.d}, p0, [z0.d]
fcvtzs  z31.d, p7/m, z31.h
//CHECK: fcvtzs  z31.d, p7/m, z31.h
sxth    z0.s, p0/m, z0.s
//CHECK: sxth    z0.s, p0/m, z0.s
fcmne   p15.s, p7/z, z31.s, z31.s
//CHECK: fcmne   p15.s, p7/z, z31.s, z31.s
ld1w    {z21.d}, p5/z, [x10, z21.d, lsl #2]
//CHECK: ld1w    {z21.d}, p5/z, [x10, z21.d, lsl #2]
ldff1sb {z21.d}, p5/z, [x10, x21]
//CHECK: ldff1sb {z21.d}, p5/z, [x10, x21]
cntd    x23, vl256, mul #9
//CHECK: cntd    x23, vl256, mul #9
st1d    {z0.d}, p0, [x0, z0.d, uxtw #3]
//CHECK: st1d    {z0.d}, p0, [x0, z0.d, uxtw #3]
faddv   h23, p3, z13.h
//CHECK: faddv   h23, p3, z13.h
ld1d    {z0.d}, p0/z, [x0, z0.d, sxtw #3]
//CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, sxtw #3]
fdivr   z0.h, p0/m, z0.h, z0.h
//CHECK: fdivr   z0.h, p0/m, z0.h, z0.h
st1b    {z21.b}, p5, [x10, #5, mul vl]
//CHECK: st1b    {z21.b}, p5, [x10, #5, mul vl]
asrd    z23.h, p3/m, z23.h, #3
//CHECK: asrd    z23.h, p3/m, z23.h, #3
fsub    z21.d, p5/m, z21.d, #0.5
//CHECK: fsub    z21.d, p5/m, z21.d, #0.5
ld1rh   {z23.s}, p3/z, [x13, #16]
//CHECK: ld1rh   {z23.s}, p3/z, [x13, #16]
asrd    z23.s, p3/m, z23.s, #19
//CHECK: asrd    z23.s, p3/m, z23.s, #19
whilels p15.b, xzr, xzr
//CHECK: whilels p15.b, xzr, xzr
uxtb    z31.s, p7/m, z31.s
//CHECK: uxtb    z31.s, p7/m, z31.s
ld1b    {z21.s}, p5/z, [x10, x21]
//CHECK: ld1b    {z21.s}, p5/z, [x10, x21]
uqdech  x23, vl256, mul #9
//CHECK: uqdech  x23, vl256, mul #9
st1h    {z23.s}, p3, [x13, z8.s, sxtw #1]
//CHECK: st1h    {z23.s}, p3, [x13, z8.s, sxtw #1]
ld1sw   {z23.d}, p3/z, [x13, z8.d, sxtw #2]
//CHECK: ld1sw   {z23.d}, p3/z, [x13, z8.d, sxtw #2]
ucvtf   z0.h, p0/m, z0.h
//CHECK: ucvtf   z0.h, p0/m, z0.h
ld1h    {z0.s}, p0/z, [x0, z0.s, uxtw #1]
//CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, uxtw #1]
ldff1b  {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ldff1b  {z0.d}, p0/z, [x0, z0.d, uxtw]
cmpgt   p15.s, p7/z, z31.s, z31.d
//CHECK: cmpgt   p15.s, p7/z, z31.s, z31.d
fmul    z23.h, p3/m, z23.h, #2.0
//CHECK: fmul    z23.h, p3/m, z23.h, #2.0
fadd    z23.d, p3/m, z23.d, #1.0
//CHECK: fadd    z23.d, p3/m, z23.d, #1.0
ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, #-24, mul vl]
//CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, #-24, mul vl]
frecps  z31.h, z31.h, z31.h
//CHECK: frecps  z31.h, z31.h, z31.h
whilele p15.d, xzr, xzr
//CHECK: whilele p15.d, xzr, xzr
lastb   x23, p3, z13.d
//CHECK: lastb   x23, p3, z13.d
asr     z0.h, z0.h, z0.d
//CHECK: asr     z0.h, z0.h, z0.d
lsl     z21.h, p5/m, z21.h, z10.d
//CHECK: lsl     z21.h, p5/m, z21.h, z10.d
sqincw  x0, w0, pow2
//CHECK: sqincw  x0, w0, pow2
mov     z0.h, p0/z, #0
//CHECK: mov     z0.h, p0/z, #0
ldff1sb {z0.d}, p0/z, [x0, z0.d, uxtw]
//CHECK: ldff1sb {z0.d}, p0/z, [x0, z0.d, uxtw]
ld1sb   {z31.d}, p7/z, [sp, z31.d]
//CHECK: ld1sb   {z31.d}, p7/z, [sp, z31.d]
zip2    p15.s, p15.s, p15.s
//CHECK: zip2    p15.s, p15.s, p15.s
wrffr   p0.b
//CHECK: wrffr   p0.b
cmphi   p0.d, p0/z, z0.d, #0
//CHECK: cmphi   p0.d, p0/z, z0.d, #0
orr     z0.d, p0/m, z0.d, z0.d
//CHECK: orr     z0.d, p0/m, z0.d, z0.d
mls     z0.b, p0/m, z0.b, z0.b
//CHECK: mls     z0.b, p0/m, z0.b, z0.b
sub     z21.d, p5/m, z21.d, z10.d
//CHECK: sub     z21.d, p5/m, z21.d, z10.d
mov     z21.s, #-86
//CHECK: mov     z21.s, #-86
umin    z21.d, z21.d, #170
//CHECK: umin    z21.d, z21.d, #170
sqsub   z21.b, z10.b, z21.b
//CHECK: sqsub   z21.b, z10.b, z21.b
st1d    {z23.d}, p3, [x13, #-8, mul vl]
//CHECK: st1d    {z23.d}, p3, [x13, #-8, mul vl]
stnt1b  {z0.b}, p0, [x0, x0]
//CHECK: stnt1b  {z0.b}, p0, [x0, x0]
bic     p0.b, p0/z, p0.b, p0.b
//CHECK: bic     p0.b, p0/z, p0.b, p0.b
fmla    z23.d, z13.d, z8.d[0]
//CHECK: fmla    z23.d, z13.d, z8.d[0]
uqincp  w0, p0.s
//CHECK: uqincp  w0, p0.s
ldff1sh {z0.d}, p0/z, [x0, z0.d]
//CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d]
ld1sh   {z21.d}, p5/z, [x10, z21.d]
//CHECK: ld1sh   {z21.d}, p5/z, [x10, z21.d]
ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw #1]
//CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw #1]
brka    p5.b, p5/m, p10.b
//CHECK: brka    p5.b, p5/m, p10.b
add     z21.d, p5/m, z21.d, z10.d
//CHECK: add     z21.d, p5/m, z21.d, z10.d
movprfx z0.s, p0/m, z0.s
//CHECK: movprfx z0.s, p0/m, z0.s
add     z0.s, p0/m, z0.s, z1.s
//CHECK: add z0.s, p0/m, z0.s, z1.s
insr    z23.d, x13
//CHECK: insr    z23.d, x13
sdot    z31.s, z31.b, z31.b
//CHECK: sdot    z31.s, z31.b, z31.b
smulh   z21.d, p5/m, z21.d, z10.d
//CHECK: smulh   z21.d, p5/m, z21.d, z10.d
index   z0.h, w0, #0
//CHECK: index   z0.h, w0, #0
ld1rsb  {z0.s}, p0/z, [x0]
//CHECK: ld1rsb  {z0.s}, p0/z, [x0]
ldff1w  {z21.s}, p5/z, [x10, z21.s, uxtw #2]
//CHECK: ldff1w  {z21.s}, p5/z, [x10, z21.s, uxtw #2]
st1h    {z31.s}, p7, [sp, z31.s, uxtw #1]
//CHECK: st1h    {z31.s}, p7, [sp, z31.s, uxtw #1]
uzp2    p15.d, p15.d, p15.d
//CHECK: uzp2    p15.d, p15.d, p15.d
movs    p15.b, p15.b
//CHECK: movs    p15.b, p15.b
frinti  z21.h, p5/m, z10.h
//CHECK: frinti  z21.h, p5/m, z10.h
mad     z0.b, p0/m, z0.b, z0.b
//CHECK: mad     z0.b, p0/m, z0.b, z0.b
whilels p7.h, w13, w8
//CHECK: whilels p7.h, w13, w8
fcvtzu  z0.s, p0/m, z0.s
//CHECK: fcvtzu  z0.s, p0/m, z0.s
zip1    p0.b, p0.b, p0.b
//CHECK: zip1    p0.b, p0.b, p0.b
ld1h    {z0.h}, p0/z, [x0, x0, lsl #1]
//CHECK: ld1h    {z0.h}, p0/z, [x0, x0, lsl #1]
frecpe  z23.h, z13.h
//CHECK: frecpe  z23.h, z13.h
frinti  z21.d, p5/m, z10.d
//CHECK: frinti  z21.d, p5/m, z10.d
fcvtzu  z0.s, p0/m, z0.d
//CHECK: fcvtzu  z0.s, p0/m, z0.d
rdvl    x23, #-19
//CHECK: rdvl    x23, #-19
msb     z31.d, p7/m, z31.d, z31.d
//CHECK: msb     z31.d, p7/m, z31.d, z31.d
fcvtzs  z0.d, p0/m, z0.h
//CHECK: fcvtzs  z0.d, p0/m, z0.h
uminv   s23, p3, z13.s
//CHECK: uminv   s23, p3, z13.s
index   z31.b, wzr, wzr
//CHECK: index   z31.b, wzr, wzr
fmaxnm  z23.h, p3/m, z23.h, z13.h
//CHECK: fmaxnm  z23.h, p3/m, z23.h, z13.h
adr     z31.d, [z31.d, z31.d, sxtw #3]
//CHECK: adr     z31.d, [z31.d, z31.d, sxtw #3]
decp    z31.h, p15
//CHECK: decp    z31.h, p15
st1d    {z0.d}, p0, [x0, z0.d, lsl #3]
//CHECK: st1d    {z0.d}, p0, [x0, z0.d, lsl #3]
ld1sh   {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ld1sh   {z21.d}, p5/z, [x10, z21.d, sxtw]
st1b    {z21.s}, p5, [x10, x21]
//CHECK: st1b    {z21.s}, p5, [x10, x21]
sqdecp  x21, p10.s
//CHECK: sqdecp  x21, p10.s
uqdecp  x21, p10.d
//CHECK: uqdecp  x21, p10.d
not     z31.h, p7/m, z31.h
//CHECK: not     z31.h, p7/m, z31.h
trn1    p7.h, p13.h, p8.h
//CHECK: trn1    p7.h, p13.h, p8.h
punpkhi p7.h, p13.b
//CHECK: punpkhi p7.h, p13.b
fadd    z0.s, p0/m, z0.s, #0.5
//CHECK: fadd    z0.s, p0/m, z0.s, #0.5
st1d    {z0.d}, p0, [x0]
//CHECK: st1d    {z0.d}, p0, [x0]
brkpas  p5.b, p5/z, p10.b, p5.b
//CHECK: brkpas  p5.b, p5/z, p10.b, p5.b
cmplo   p5.b, p5/z, z10.b, z21.d
//CHECK: cmplo   p5.b, p5/z, z10.b, z21.d
sqincp  xzr, p15.h
//CHECK: sqincp  xzr, p15.h
ldff1d  {z0.d}, p0/z, [x0, z0.d]
//CHECK: ldff1d  {z0.d}, p0/z, [x0, z0.d]
umulh   z21.b, p5/m, z21.b, z10.b
//CHECK: umulh   z21.b, p5/m, z21.b, z10.b
fmaxnm  z23.h, p3/m, z23.h, #1.0
//CHECK: fmaxnm  z23.h, p3/m, z23.h, #1.0
ldff1b  {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ldff1b  {z23.d}, p3/z, [x13, z8.d, sxtw]
ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0, x0]
//CHECK: ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0, x0]
rev     p7.b, p13.b
//CHECK: rev     p7.b, p13.b
cmplo   p5.b, p5/z, z10.b, #85
//CHECK: cmplo   p5.b, p5/z, z10.b, #85
scvtf   z21.s, p5/m, z10.d
//CHECK: scvtf   z21.s, p5/m, z10.d
ld1w    {z23.s}, p3/z, [x13, z8.s, sxtw]
//CHECK: ld1w    {z23.s}, p3/z, [x13, z8.s, sxtw]
cmphi   p15.b, p7/z, z31.b, z31.d
//CHECK: cmphi   p15.b, p7/z, z31.b, z31.d
umax    z23.s, p3/m, z23.s, z13.s
//CHECK: umax    z23.s, p3/m, z23.s, z13.s
sqdecd  x23, vl256, mul #9
//CHECK: sqdecd  x23, vl256, mul #9
frintx  z21.h, p5/m, z10.h
//CHECK: frintx  z21.h, p5/m, z10.h
ldff1sw {z31.d}, p7/z, [sp, z31.d, uxtw]
//CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, uxtw]
sxtw    z21.d, p5/m, z10.d
//CHECK: sxtw    z21.d, p5/m, z10.d
sqdecp  x23, p13.s
//CHECK: sqdecp  x23, p13.s
frintm  z31.s, p7/m, z31.s
//CHECK: frintm  z31.s, p7/m, z31.s
sqdecp  x21, p10.h
//CHECK: sqdecp  x21, p10.h
st3d    {z23.d, z24.d, z25.d}, p3, [x13, x8, lsl #3]
//CHECK: st3d    {z23.d, z24.d, z25.d}, p3, [x13, x8, lsl #3]
uqdecb  x21, vl32, mul #6
//CHECK: uqdecb  x21, vl32, mul #6
uzp1    p5.d, p10.d, p5.d
//CHECK: uzp1    p5.d, p10.d, p5.d
clastb  wzr, p7, wzr, z31.s
//CHECK: clastb  wzr, p7, wzr, z31.s
cnot    z21.b, p5/m, z10.b
//CHECK: cnot    z21.b, p5/m, z10.b
ld1b    {z21.d}, p5/z, [z10.d, #21]
//CHECK: ld1b    {z21.d}, p5/z, [z10.d, #21]
fmul    z23.h, z13.h, z8.h
//CHECK: fmul    z23.h, z13.h, z8.h
ldff1d  {z23.d}, p3/z, [x13, z8.d, sxtw]
//CHECK: ldff1d  {z23.d}, p3/z, [x13, z8.d, sxtw]
cmpeq   p15.b, p7/z, z31.b, z31.b
//CHECK: cmpeq   p15.b, p7/z, z31.b, z31.b
ld1b    {z31.b}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1b    {z31.b}, p7/z, [sp, #-1, mul vl]
cntw    xzr, all, mul #16
//CHECK: cntw    xzr, all, mul #16
uzp2    z0.h, z0.h, z0.h
//CHECK: uzp2    z0.h, z0.h, z0.h
st1h    {z21.d}, p5, [x10, #5, mul vl]
//CHECK: st1h    {z21.d}, p5, [x10, #5, mul vl]
add     z21.b, p5/m, z21.b, z10.b
//CHECK: add     z21.b, p5/m, z21.b, z10.b
fcadd   z21.s, p5/m, z21.s, z10.s, #270
//CHECK: fcadd   z21.s, p5/m, z21.s, z10.s, #270
st1h    {z31.d}, p7, [sp, #-1, mul vl]
//CHECK: st1h    {z31.d}, p7, [sp, #-1, mul vl]
ld1sb   {z21.d}, p5/z, [z10.d, #21]
//CHECK: ld1sb   {z21.d}, p5/z, [z10.d, #21]
rev     z0.h, z0.h
//CHECK: rev     z0.h, z0.h
lsr     z23.s, z13.s, #24
//CHECK: lsr     z23.s, z13.s, #24
ld2b    {z21.b, z22.b}, p5/z, [x10, x21]
//CHECK: ld2b    {z21.b, z22.b}, p5/z, [x10, x21]
prfd    pldl3strm, p3, [x17, x16, lsl #3]
//CHECK: prfd    pldl3strm, p3, [x17, x16, lsl #3]
cmphs   p0.h, p0/z, z0.h, #0
//CHECK: cmphs   p0.h, p0/z, z0.h, #0
sqsub   z31.s, z31.s, #255, lsl #8
//CHECK: sqsub   z31.s, z31.s, #65280
sqincw  z23.s, vl256, mul #9
//CHECK: sqincw  z23.s, vl256, mul #9
ld1h    {z23.d}, p3/z, [x13, z8.d, uxtw #1]
//CHECK: ld1h    {z23.d}, p3/z, [x13, z8.d, uxtw #1]
index   z31.h, #-1, #-1
//CHECK: index   z31.h, #-1, #-1
clastb  h0, p0, h0, z0.h
//CHECK: clastb  h0, p0, h0, z0.h
udiv    z23.d, p3/m, z23.d, z13.d
//CHECK: udiv    z23.d, p3/m, z23.d, z13.d
whilelt p0.d, x0, x0
//CHECK: whilelt p0.d, x0, x0
ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw]
//CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw]
zip1    z23.d, z13.d, z8.d
//CHECK: zip1    z23.d, z13.d, z8.d
stnt1h  {z0.h}, p0, [x0]
//CHECK: stnt1h  {z0.h}, p0, [x0]
uqincp  z21.s, p10
//CHECK: uqincp  z21.s, p10
frsqrte z31.d, z31.d
//CHECK: frsqrte z31.d, z31.d
ldff1sb {z0.s}, p0/z, [x0, z0.s, sxtw]
//CHECK: ldff1sb {z0.s}, p0/z, [x0, z0.s, sxtw]
cmpne   p0.b, p0/z, z0.b, z0.d
//CHECK: cmpne   p0.b, p0/z, z0.b, z0.d
fcmgt   p5.h, p5/z, z10.h, #0.0
//CHECK: fcmgt   p5.h, p5/z, z10.h, #0.0
cmpeq   p7.h, p3/z, z13.h, #8
//CHECK: cmpeq   p7.h, p3/z, z13.h, #8
pnext   p15.h, p15, p15.h
//CHECK: pnext   p15.h, p15, p15.h
lsr     z23.b, p3/m, z23.b, #3
//CHECK: lsr     z23.b, p3/m, z23.b, #3
trn2    p0.b, p0.b, p0.b
//CHECK: trn2    p0.b, p0.b, p0.b
prfh    pldl3strm, p5, [z10.d, #42]
//CHECK: prfh    pldl3strm, p5, [z10.d, #42]
st1h    {z0.s}, p0, [x0]
//CHECK: st1h    {z0.s}, p0, [x0]
adr     z0.d, [z0.d, z0.d]
//CHECK: adr     z0.d, [z0.d, z0.d]
fnmls   z21.d, p5/m, z10.d, z21.d
//CHECK: fnmls   z21.d, p5/m, z10.d, z21.d
mov     z0.d, #0
//CHECK: mov     z0.d, #0
fcadd   z0.d, p0/m, z0.d, z0.d, #90
//CHECK: fcadd   z0.d, p0/m, z0.d, z0.d, #90
mov     z31.s, z31.s[15]
//CHECK: mov     z31.s, z31.s[15]
ldff1d  {z21.d}, p5/z, [x10, z21.d, lsl #3]
//CHECK: ldff1d  {z21.d}, p5/z, [x10, z21.d, lsl #3]
ldff1w  {z31.d}, p7/z, [sp, z31.d]
//CHECK: ldff1w  {z31.d}, p7/z, [sp, z31.d]
uqadd   z31.b, z31.b, z31.b
//CHECK: uqadd   z31.b, z31.b, z31.b
uqdecb  w23, vl256, mul #9
//CHECK: uqdecb  w23, vl256, mul #9
prfd    #15, p7, [sp, z31.d, lsl #3]
//CHECK: prfd    #15, p7, [sp, z31.d, lsl #3]
ftmad   z31.h, z31.h, z31.h, #7
//CHECK: ftmad   z31.h, z31.h, z31.h, #7
orn     p7.b, p11/z, p13.b, p8.b
//CHECK: orn     p7.b, p11/z, p13.b, p8.b
lsr     z31.b, p7/m, z31.b, z31.d
//CHECK: lsr     z31.b, p7/m, z31.b, z31.d
index   z21.d, x10, #-11
//CHECK: index   z21.d, x10, #-11
lsr     z23.h, p3/m, z23.h, z13.d
//CHECK: lsr     z23.h, p3/m, z23.h, z13.d
sqdecp  z23.d, p13
//CHECK: sqdecp  z23.d, p13
sunpklo z23.h, z13.b
//CHECK: sunpklo z23.h, z13.b
ptrue   p7.h, vl256
//CHECK: ptrue   p7.h, vl256
cmpne   p15.h, p7/z, z31.h, z31.d
//CHECK: cmpne   p15.h, p7/z, z31.h, z31.d
msb     z21.b, p5/m, z21.b, z10.b
//CHECK: msb     z21.b, p5/m, z21.b, z10.b
sxtw    z0.d, p0/m, z0.d
//CHECK: sxtw    z0.d, p0/m, z0.d
lastb   s31, p7, z31.s
//CHECK: lastb   s31, p7, z31.s
stnt1d  {z21.d}, p5, [x10, x21, lsl #3]
//CHECK: stnt1d  {z21.d}, p5, [x10, x21, lsl #3]
andv    s0, p0, z0.s
//CHECK: andv    s0, p0, z0.s
ld1w    {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1w    {z23.s}, p3/z, [x13, #-8, mul vl]
cmplt   p15.b, p7/z, z31.b, z31.d
//CHECK: cmplt   p15.b, p7/z, z31.b, z31.d
fadd    z31.d, p7/m, z31.d, z31.d
//CHECK: fadd    z31.d, p7/m, z31.d, z31.d
fnmad   z0.d, p0/m, z0.d, z0.d
//CHECK: fnmad   z0.d, p0/m, z0.d, z0.d
subr    z23.h, p3/m, z23.h, z13.h
//CHECK: subr    z23.h, p3/m, z23.h, z13.h
index   z23.h, #13, w8
//CHECK: index   z23.h, #13, w8
cmpgt   p15.d, p7/z, z31.d, #-1
//CHECK: cmpgt   p15.d, p7/z, z31.d, #-1
uzp1    z23.s, z13.s, z8.s
//CHECK: uzp1    z23.s, z13.s, z8.s
asr     z31.s, p7/m, z31.s, z31.s
//CHECK: asr     z31.s, p7/m, z31.s, z31.s
frecpx  z31.s, p7/m, z31.s
//CHECK: frecpx  z31.s, p7/m, z31.s
cnt     z23.h, p3/m, z13.h
//CHECK: cnt     z23.h, p3/m, z13.h
cmpgt   p7.s, p3/z, z13.s, z8.d
//CHECK: cmpgt   p7.s, p3/z, z13.s, z8.d
fabs    z31.d, p7/m, z31.d
//CHECK: fabs    z31.d, p7/m, z31.d
whilele p7.d, x13, x8
//CHECK: whilele p7.d, x13, x8
ld3b    {z21.b, z22.b, z23.b}, p5/z, [x10, #15, mul vl]
//CHECK: ld3b    {z21.b, z22.b, z23.b}, p5/z, [x10, #15, mul vl]
not     z21.h, p5/m, z10.h
//CHECK: not     z21.h, p5/m, z10.h
sqinch  xzr, all, mul #16
//CHECK: sqinch  xzr, all, mul #16
fcvtzs  z21.d, p5/m, z10.d
//CHECK: fcvtzs  z21.d, p5/m, z10.d
whilels p15.h, xzr, xzr
//CHECK: whilels p15.h, xzr, xzr
ld1w    {z0.d}, p0/z, [x0]
//CHECK: ld1w    {z0.d}, p0/z, [x0]
ld1b    {z0.d}, p0/z, [x0, x0]
//CHECK: ld1b    {z0.d}, p0/z, [x0, x0]
fadd    z0.h, p0/m, z0.h, #0.5
//CHECK: fadd    z0.h, p0/m, z0.h, #0.5
ands    p7.b, p11/z, p13.b, p8.b
//CHECK: ands    p7.b, p11/z, p13.b, p8.b
fmul    z31.h, z31.h, z7.h[7]
//CHECK: fmul    z31.h, z31.h, z7.h[7]
sqsub   z23.h, z13.h, z8.h
//CHECK: sqsub   z23.h, z13.h, z8.h
frintp  z0.h, p0/m, z0.h
//CHECK: frintp  z0.h, p0/m, z0.h
uzp1    p7.b, p13.b, p8.b
//CHECK: uzp1    p7.b, p13.b, p8.b
ldff1b  {z23.s}, p3/z, [x13, z8.s, uxtw]
//CHECK: ldff1b  {z23.s}, p3/z, [x13, z8.s, uxtw]
frecpx  z0.s, p0/m, z0.s
//CHECK: frecpx  z0.s, p0/m, z0.s
sdot    z31.d, z31.h, z15.h[1]
//CHECK: sdot    z31.d, z31.h, z15.h[1]
trn1    z23.s, z13.s, z8.s
//CHECK: trn1    z23.s, z13.s, z8.s
ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw #3]
//CHECK: ld1d    {z23.d}, p3/z, [x13, z8.d, uxtw #3]
umax    z31.d, z31.d, #255
//CHECK: umax    z31.d, z31.d, #255
cmplo   p5.s, p5/z, z10.s, #85
//CHECK: cmplo   p5.s, p5/z, z10.s, #85
uunpkhi z21.h, z10.b
//CHECK: uunpkhi z21.h, z10.b
mov     z0.d, d12
//CHECK: mov     z0.d, d12
fabd    z31.d, p7/m, z31.d, z31.d
//CHECK: fabd    z31.d, p7/m, z31.d, z31.d
umulh   z0.d, p0/m, z0.d, z0.d
//CHECK: umulh   z0.d, p0/m, z0.d, z0.d
sqdecp  x0, p0.h
//CHECK: sqdecp  x0, p0.h
rdffrs  p0.b, p0/z
//CHECK: rdffrs  p0.b, p0/z
ctermeq w10, w21
//CHECK: ctermeq w10, w21
index   z0.d, #0, x0
//CHECK: index   z0.d, #0, x0
ldff1b  {z0.s}, p0/z, [x0, z0.s, uxtw]
//CHECK: ldff1b  {z0.s}, p0/z, [x0, z0.s, uxtw]
st1w    {z0.d}, p0, [x0]
//CHECK: st1w    {z0.d}, p0, [x0]
ftsmul  z0.h, z0.h, z0.h
//CHECK: ftsmul  z0.h, z0.h, z0.h
adr     z31.d, [z31.d, z31.d, uxtw #1]
//CHECK: adr     z31.d, [z31.d, z31.d, uxtw #1]
st1h    {z31.d}, p7, [z31.d, #62]
//CHECK: st1h    {z31.d}, p7, [z31.d, #62]
fmax    z0.d, p0/m, z0.d, #0.0
//CHECK: fmax    z0.d, p0/m, z0.d, #0.0
fcadd   z31.d, p7/m, z31.d, z31.d, #270
//CHECK: fcadd   z31.d, p7/m, z31.d, z31.d, #270
cnot    z0.s, p0/m, z0.s
//CHECK: cnot    z0.s, p0/m, z0.s
asr     z31.h, z31.h, #1
//CHECK: asr     z31.h, z31.h, #1
movs    p15.b, p15/z, p15.b
//CHECK: movs    p15.b, p15/z, p15.b
smin    z23.s, z23.s, #109
//CHECK: smin    z23.s, z23.s, #109
ld1rqd  {z21.d}, p5/z, [x10, x21, lsl #3]
//CHECK: ld1rqd  {z21.d}, p5/z, [x10, x21, lsl #3]
mov     z21.d, z10.d[3]
//CHECK: mov     z21.d, z10.d[3]
ptrues  p0.d, pow2
//CHECK: ptrues  p0.d, pow2
sqsub   z21.s, z10.s, z21.s
//CHECK: sqsub   z21.s, z10.s, z21.s
ldff1w  {z0.s}, p0/z, [x0, z0.s, sxtw]
//CHECK: ldff1w  {z0.s}, p0/z, [x0, z0.s, sxtw]
uqincp  w21, p10.d
//CHECK: uqincp  w21, p10.d
movprfx z31.b, p7/m, z31.b
//CHECK: movprfx z31.b, p7/m, z31.b
add     z31.b, p7/m, z31.b, z0.b
//CHECK: add z31.b, p7/m, z31.b, z0.b
cmplt   p5.b, p5/z, z10.b, #-11
//CHECK: cmplt   p5.b, p5/z, z10.b, #-11
cmplt   p7.s, p3/z, z13.s, #8
//CHECK: cmplt   p7.s, p3/z, z13.s, #8
add     z23.s, z23.s, #109, lsl #8
//CHECK: add     z23.s, z23.s, #27904
revh    z31.d, p7/m, z31.d
//CHECK: revh    z31.d, p7/m, z31.d
orns    p0.b, p0/z, p0.b, p0.b
//CHECK: orns    p0.b, p0/z, p0.b, p0.b
mov     z23.d, z13.d[2]
//CHECK: mov     z23.d, z13.d[2]
sqdecp  xzr, p15.b, wzr
//CHECK: sqdecp  xzr, p15.b, wzr
cls     z31.b, p7/m, z31.b
//CHECK: cls     z31.b, p7/m, z31.b
ld1w    {z21.d}, p5/z, [z10.d, #84]
//CHECK: ld1w    {z21.d}, p5/z, [z10.d, #84]
fmaxnmv s23, p3, z13.s
//CHECK: fmaxnmv s23, p3, z13.s
sdot    z21.s, z10.b, z21.b
//CHECK: sdot    z21.s, z10.b, z21.b
ldff1h  {z23.d}, p3/z, [x13, x8, lsl #1]
//CHECK: ldff1h  {z23.d}, p3/z, [x13, x8, lsl #1]
uzp2    z31.s, z31.s, z31.s
//CHECK: uzp2    z31.s, z31.s, z31.s
trn2    z31.b, z31.b, z31.b
//CHECK: trn2    z31.b, z31.b, z31.b
fcmuo   p5.d, p5/z, z10.d, z21.d
//CHECK: fcmuo   p5.d, p5/z, z10.d, z21.d
fcmle   p5.d, p5/z, z10.d, #0.0
//CHECK: fcmle   p5.d, p5/z, z10.d, #0.0
fmls    z21.s, p5/m, z10.s, z21.s
//CHECK: fmls    z21.s, p5/m, z10.s, z21.s
fmul    z31.h, z31.h, z31.h
//CHECK: fmul    z31.h, z31.h, z31.h
ld1sh   {z21.s}, p5/z, [x10, z21.s, uxtw]
//CHECK: ld1sh   {z21.s}, p5/z, [x10, z21.s, uxtw]
fcvtzu  z0.d, p0/m, z0.h
//CHECK: fcvtzu  z0.d, p0/m, z0.h
mov     z1.b, p14/m, #33
//CHECK: mov     z1.b, p14/m, #33
incp    z23.h, p13
//CHECK: incp    z23.h, p13
mov     z23.b, p3/m, w13
//CHECK: mov     z23.b, p3/m, w13
fcvtzu  z31.s, p7/m, z31.d
//CHECK: fcvtzu  z31.s, p7/m, z31.d
cmphs   p15.d, p7/z, z31.d, #127
//CHECK: cmphs   p15.d, p7/z, z31.d, #127
pfalse  p5.b
//CHECK: pfalse  p5.b
ld1d    {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1d    {z23.d}, p3/z, [x13, #-8, mul vl]
ld1rsb  {z21.s}, p5/z, [x10, #21]
//CHECK: ld1rsb  {z21.s}, p5/z, [x10, #21]
bics    p5.b, p5/z, p10.b, p5.b
//CHECK: bics    p5.b, p5/z, p10.b, p5.b
adr     z23.d, [z13.d, z8.d, lsl #1]
//CHECK: adr     z23.d, [z13.d, z8.d, lsl #1]
orv     s0, p0, z0.s
//CHECK: orv     s0, p0, z0.s
prfd    pldl1keep, p0, [x0, x0, lsl #3]
//CHECK: prfd    pldl1keep, p0, [x0, x0, lsl #3]
lsl     z23.b, p3/m, z23.b, #5
//CHECK: lsl     z23.b, p3/m, z23.b, #5
fmax    z21.s, p5/m, z21.s, #0.0
//CHECK: fmax    z21.s, p5/m, z21.s, #0.0
whilels p0.b, x0, x0
//CHECK: whilels p0.b, x0, x0
cntp    x23, p11, p13.h
//CHECK: cntp    x23, p11, p13.h
lsrr    z0.h, p0/m, z0.h, z0.h
//CHECK: lsrr    z0.h, p0/m, z0.h, z0.h
fcmne   p0.h, p0/z, z0.h, #0.0
//CHECK: fcmne   p0.h, p0/z, z0.h, #0.0
sqincp  x23, p13.s, w23
//CHECK: sqincp  x23, p13.s, w23
mls     z31.h, p7/m, z31.h, z31.h
//CHECK: mls     z31.h, p7/m, z31.h, z31.h
frecpe  z23.d, z13.d
//CHECK: frecpe  z23.d, z13.d
brkpa   p0.b, p0/z, p0.b, p0.b
//CHECK: brkpa   p0.b, p0/z, p0.b, p0.b
lsl     z0.s, p0/m, z0.s, z0.s
//CHECK: lsl     z0.s, p0/m, z0.s, z0.s
sqincw  x21, w21, vl32, mul #6
//CHECK: sqincw  x21, w21, vl32, mul #6
st1h    {z23.d}, p3, [x13, z8.d, lsl #1]
//CHECK: st1h    {z23.d}, p3, [x13, z8.d, lsl #1]
index   z21.b, w10, w21
//CHECK: index   z21.b, w10, w21
st1w    {z0.d}, p0, [x0, z0.d, sxtw]
//CHECK: st1w    {z0.d}, p0, [x0, z0.d, sxtw]
uqdecp  w0, p0.d
//CHECK: uqdecp  w0, p0.d
fmls    z31.d, p7/m, z31.d, z31.d
//CHECK: fmls    z31.d, p7/m, z31.d, z31.d
ld2w    {z21.s, z22.s}, p5/z, [x10, x21, lsl #2]
//CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, x21, lsl #2]
ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw]
//CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw]
lsl     z31.b, z31.b, z31.d
//CHECK: lsl     z31.b, z31.b, z31.d
fscale  z21.s, p5/m, z21.s, z10.s
//CHECK: fscale  z21.s, p5/m, z21.s, z10.s
zip1    z0.b, z0.b, z0.b
//CHECK: zip1    z0.b, z0.b, z0.b
fmsb    z21.d, p5/m, z10.d, z21.d
//CHECK: fmsb    z21.d, p5/m, z10.d, z21.d
asr     z0.h, p0/m, z0.h, #16
//CHECK: asr     z0.h, p0/m, z0.h, #16
cmphs   p7.b, p3/z, z13.b, #35
//CHECK: cmphs   p7.b, p3/z, z13.b, #35
st1h    {z21.d}, p5, [x10, z21.d, sxtw]
//CHECK: st1h    {z21.d}, p5, [x10, z21.d, sxtw]
fexpa   z31.h, z31.h
//CHECK: fexpa   z31.h, z31.h
fnmsb   z23.s, p3/m, z13.s, z8.s
//CHECK: fnmsb   z23.s, p3/m, z13.s, z8.s
uqincp  z21.h, p10
//CHECK: uqincp  z21.h, p10
cmplt   p15.h, p7/z, z31.h, z31.d
//CHECK: cmplt   p15.h, p7/z, z31.h, z31.d
trn1    p7.d, p13.d, p8.d
//CHECK: trn1    p7.d, p13.d, p8.d
ldff1w  {z23.s}, p3/z, [x13, z8.s, uxtw]
//CHECK: ldff1w  {z23.s}, p3/z, [x13, z8.s, uxtw]
sqincp  x21, p10.s
//CHECK: sqincp  x21, p10.s
ld1sh   {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1sh   {z23.s}, p3/z, [x13, #-8, mul vl]
decp    x0, p0.h
//CHECK: decp    x0, p0.h
fcvt    z0.d, p0/m, z0.h
//CHECK: fcvt    z0.d, p0/m, z0.h
umin    z31.h, z31.h, #255
//CHECK: umin    z31.h, z31.h, #255
st2h    {z5.h, z6.h}, p3, [x17, x16, lsl #1]
//CHECK: st2h    {z5.h, z6.h}, p3, [x17, x16, lsl #1]
sdot    z21.d, z10.h, z5.h[1]
//CHECK: sdot    z21.d, z10.h, z5.h[1]
fsub    z31.d, z31.d, z31.d
//CHECK: fsub    z31.d, z31.d, z31.d
whilelo p0.b, w0, w0
//CHECK: whilelo p0.b, w0, w0
st1d    {z23.d}, p3, [x13, z8.d, sxtw #3]
//CHECK: st1d    {z23.d}, p3, [x13, z8.d, sxtw #3]
sqadd   z23.h, z23.h, #109, lsl #8
//CHECK: sqadd   z23.h, z23.h, #27904
lasta   w23, p3, z13.h
//CHECK: lasta   w23, p3, z13.h
pnext   p7.s, p13, p7.s
//CHECK: pnext   p7.s, p13, p7.s
rev     p15.h, p15.h
//CHECK: rev     p15.h, p15.h
brkns   p7.b, p11/z, p13.b, p7.b
//CHECK: brkns   p7.b, p11/z, p13.b, p7.b
smax    z31.b, p7/m, z31.b, z31.b
//CHECK: smax    z31.b, p7/m, z31.b, z31.b
cmplt   p0.d, p0/z, z0.d, #0
//CHECK: cmplt   p0.d, p0/z, z0.d, #0
orr     p5.b, p5/z, p10.b, p5.b
//CHECK: orr     p5.b, p5/z, p10.b, p5.b
cmple   p5.s, p5/z, z10.s, z21.d
//CHECK: cmple   p5.s, p5/z, z10.s, z21.d
fmov    z31.d, p15/m, #-1.9375
//CHECK: fmov    z31.d, p15/m, #-1.9375
ld1b    {z31.d}, p7/z, [sp, z31.d]
//CHECK: ld1b    {z31.d}, p7/z, [sp, z31.d]
uxth    z0.d, p0/m, z0.d
//CHECK: uxth    z0.d, p0/m, z0.d
fcmla   z0.s, p0/m, z0.s, z0.s, #0
//CHECK: fcmla   z0.s, p0/m, z0.s, z0.s, #0
sdot    z0.s, z0.b, z0.b[0]
//CHECK: sdot    z0.s, z0.b, z0.b[0]
ftmad   z31.s, z31.s, z31.s, #7
//CHECK: ftmad   z31.s, z31.s, z31.s, #7
trn1    z21.h, z10.h, z21.h
//CHECK: trn1    z21.h, z10.h, z21.h
mov     z0.h, p0/m, h0
//CHECK: mov     z0.h, p0/m, h0
fadd    z23.s, p3/m, z23.s, z13.s
//CHECK: fadd    z23.s, p3/m, z23.s, z13.s
movprfx z21, z10
//CHECK: movprfx z21, z10
add     z21.h, p5/m, z21.h, z22.h
//CHECK: add z21.h, p5/m, z21.h, z22.h
fneg    z21.d, p5/m, z10.d
//CHECK: fneg    z21.d, p5/m, z10.d
stnt1h  {z5.h}, p3, [x17, x16, lsl #1]
//CHECK: stnt1h  {z5.h}, p3, [x17, x16, lsl #1]
add     z23.h, z23.h, #109, lsl #8
//CHECK: add     z23.h, z23.h, #27904
nots    p15.b, p15/z, p15.b
//CHECK: nots    p15.b, p15/z, p15.b
uqdecb  w0, pow2
//CHECK: uqdecb  w0, pow2
whilels p5.h, w10, w21
//CHECK: whilels p5.h, w10, w21
cmpne   p7.h, p3/z, z13.h, z8.d
//CHECK: cmpne   p7.h, p3/z, z13.h, z8.d
ext     z23.b, z23.b, z13.b, #67
//CHECK: ext     z23.b, z23.b, z13.b, #67
ld1sb   {z0.d}, p0/z, [x0, x0]
//CHECK: ld1sb   {z0.d}, p0/z, [x0, x0]
lsrr    z21.s, p5/m, z21.s, z10.s
//CHECK: lsrr    z21.s, p5/m, z21.s, z10.s
ldff1b  {z21.b}, p5/z, [x10, x21]
//CHECK: ldff1b  {z21.b}, p5/z, [x10, x21]
clasta  d31, p7, d31, z31.d
//CHECK: clasta  d31, p7, d31, z31.d
smin    z23.d, z23.d, #109
//CHECK: smin    z23.d, z23.d, #109
nors    p0.b, p0/z, p0.b, p0.b
//CHECK: nors    p0.b, p0/z, p0.b, p0.b
mov     p5.b, p5/m, p10.b
//CHECK: mov     p5.b, p5/m, p10.b
uxtb    z31.h, p7/m, z31.h
//CHECK: uxtb    z31.h, p7/m, z31.h
asrr    z23.h, p3/m, z23.h, z13.h
//CHECK: asrr    z23.h, p3/m, z23.h, z13.h
whilelo p15.b, wzr, wzr
//CHECK: whilelo p15.b, wzr, wzr
umax    z23.h, z23.h, #109
//CHECK: umax    z23.h, z23.h, #109
mov     z23.h, p8/m, #109, lsl #8
//CHECK: mov     z23.h, p8/m, #27904
sqsub   z0.s, z0.s, #0
//CHECK: sqsub   z0.s, z0.s, #0
whilelt p0.b, w0, w0
//CHECK: whilelt p0.b, w0, w0
lsr     z0.s, z0.s, z0.d
//CHECK: lsr     z0.s, z0.s, z0.d
st3b    {z23.b, z24.b, z25.b}, p3, [x13, x8]
//CHECK: st3b    {z23.b, z24.b, z25.b}, p3, [x13, x8]
sqdecw  xzr, wzr, all, mul #16
//CHECK: sqdecw  xzr, wzr, all, mul #16
prfb    #15, p7, [sp, z31.d, uxtw]
//CHECK: prfb    #15, p7, [sp, z31.d, uxtw]
stnt1h  {z31.h}, p7, [sp, #-1, mul vl]
//CHECK: stnt1h  {z31.h}, p7, [sp, #-1, mul vl]
ldff1sb {z23.s}, p3/z, [x13, x8]
//CHECK: ldff1sb {z23.s}, p3/z, [x13, x8]
fabs    z21.d, p5/m, z10.d
//CHECK: fabs    z21.d, p5/m, z10.d
ld1sh   {z21.d}, p5/z, [x10, z21.d, lsl #1]
//CHECK: ld1sh   {z21.d}, p5/z, [x10, z21.d, lsl #1]
sqincw  xzr, all, mul #16
//CHECK: sqincw  xzr, all, mul #16
st1w    {z5.d}, p3, [x17, x16, lsl #2]
//CHECK: st1w    {z5.d}, p3, [x17, x16, lsl #2]
ptrue   p0.s, pow2
//CHECK: ptrue   p0.s, pow2
cmpne   p7.b, p3/z, z13.b, z8.b
//CHECK: cmpne   p7.b, p3/z, z13.b, z8.b
fscale  z31.s, p7/m, z31.s, z31.s
//CHECK: fscale  z31.s, p7/m, z31.s, z31.s
mov     z0.d, p0/m, x0
//CHECK: mov     z0.d, p0/m, x0
sqsub   z0.h, z0.h, z0.h
//CHECK: sqsub   z0.h, z0.h, z0.h
cmpgt   p7.d, p3/z, z13.d, #8
//CHECK: cmpgt   p7.d, p3/z, z13.d, #8
uqincp  wzr, p15.s
//CHECK: uqincp  wzr, p15.s
fnmls   z23.h, p3/m, z13.h, z8.h
//CHECK: fnmls   z23.h, p3/m, z13.h, z8.h
ld1w    {z21.s}, p5/z, [x10, z21.s, sxtw]
//CHECK: ld1w    {z21.s}, p5/z, [x10, z21.s, sxtw]
fadda   d31, p7, d31, z31.d
//CHECK: fadda   d31, p7, d31, z31.d
fmov    z21.h, #-13.0
//CHECK: fmov    z21.h, #-13.0
fmaxv   h23, p3, z13.h
//CHECK: fmaxv   h23, p3, z13.h
clasta  x21, p5, x21, z10.d
//CHECK: clasta  x21, p5, x21, z10.d
mov     z21.b, #-86
//CHECK: mov     z21.b, #-86
ldff1w  {z31.s}, p7/z, [sp, z31.s, sxtw #2]
//CHECK: ldff1w  {z31.s}, p7/z, [sp, z31.s, sxtw #2]
st1d    {z0.d}, p0, [x0, z0.d]
//CHECK: st1d    {z0.d}, p0, [x0, z0.d]
incd    z23.d, vl256, mul #9
//CHECK: incd    z23.d, vl256, mul #9
st1h    {z0.d}, p0, [z0.d]
//CHECK: st1h    {z0.d}, p0, [z0.d]
ftmad   z21.s, z21.s, z10.s, #5
//CHECK: ftmad   z21.s, z21.s, z10.s, #5
uqadd   z23.d, z13.d, z8.d
//CHECK: uqadd   z23.d, z13.d, z8.d
msb     z0.d, p0/m, z0.d, z0.d
//CHECK: msb     z0.d, p0/m, z0.d, z0.d
fcvtzs  z0.d, p0/m, z0.d
//CHECK: fcvtzs  z0.d, p0/m, z0.d
orns    p15.b, p15/z, p15.b, p15.b
//CHECK: orns    p15.b, p15/z, p15.b, p15.b
ld1w    {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ld1w    {z0.d}, p0/z, [x0, z0.d, sxtw]
lsrr    z0.s, p0/m, z0.s, z0.s
//CHECK: lsrr    z0.s, p0/m, z0.s, z0.s
fminv   h31, p7, z31.h
//CHECK: fminv   h31, p7, z31.h
tbl     z23.b, {z13.b}, z8.b
//CHECK: tbl     z23.b, {z13.b}, z8.b
fnmla   z0.h, p0/m, z0.h, z0.h
//CHECK: fnmla   z0.h, p0/m, z0.h, z0.h
dech    x23, vl256, mul #9
//CHECK: dech    x23, vl256, mul #9
sdivr   z23.s, p3/m, z23.s, z13.s
//CHECK: sdivr   z23.s, p3/m, z23.s, z13.s
ldff1w  {z23.d}, p3/z, [x13, z8.d, sxtw #2]
//CHECK: ldff1w  {z23.d}, p3/z, [x13, z8.d, sxtw #2]
cmphi   p7.h, p3/z, z13.h, #35
//CHECK: cmphi   p7.h, p3/z, z13.h, #35
ldff1w  {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ldff1w  {z21.d}, p5/z, [x10, z21.d, sxtw]
fmaxnm  z23.d, p3/m, z23.d, #1.0
//CHECK: fmaxnm  z23.d, p3/m, z23.d, #1.0
st1b    {z0.b}, p0, [x0, x0]
//CHECK: st1b    {z0.b}, p0, [x0, x0]
fcvtzs  z23.h, p3/m, z13.h
//CHECK: fcvtzs  z23.h, p3/m, z13.h
fadd    z21.s, p5/m, z21.s, z10.s
//CHECK: fadd    z21.s, p5/m, z21.s, z10.s
fabd    z21.d, p5/m, z21.d, z10.d
//CHECK: fabd    z21.d, p5/m, z21.d, z10.d
ld1sh   {z0.d}, p0/z, [x0, z0.d, sxtw #1]
//CHECK: ld1sh   {z0.d}, p0/z, [x0, z0.d, sxtw #1]
sqadd   z23.h, z13.h, z8.h
//CHECK: sqadd   z23.h, z13.h, z8.h
ld1sw   {z21.d}, p5/z, [x10, z21.d, uxtw]
//CHECK: ld1sw   {z21.d}, p5/z, [x10, z21.d, uxtw]
cmplt   p15.d, p7/z, z31.d, #-1
//CHECK: cmplt   p15.d, p7/z, z31.d, #-1
fcmla   z0.h, p0/m, z0.h, z0.h, #0
//CHECK: fcmla   z0.h, p0/m, z0.h, z0.h, #0
ld1sb   {z23.d}, p3/z, [z13.d, #8]
//CHECK: ld1sb   {z23.d}, p3/z, [z13.d, #8]
whilels p7.h, x13, x8
//CHECK: whilels p7.h, x13, x8
fcmla   z31.h, z31.h, z7.h[3], #270
//CHECK: fcmla   z31.h, z31.h, z7.h[3], #270
sqincp  z0.d, p0
//CHECK: sqincp  z0.d, p0
uqadd   z23.s, z23.s, #109, lsl #8
//CHECK: uqadd   z23.s, z23.s, #27904
cmplt   p7.d, p3/z, z13.d, #8
//CHECK: cmplt   p7.d, p3/z, z13.d, #8
fmla    z21.h, p5/m, z10.h, z21.h
//CHECK: fmla    z21.h, p5/m, z10.h, z21.h
sqdecb  x0, w0, pow2
//CHECK: sqdecb  x0, w0, pow2
ldff1h  {z31.h}, p7/z, [sp, xzr, lsl #1]
//CHECK: ldff1h  {z31.h}, p7/z, [sp]
whilels p15.s, xzr, xzr
//CHECK: whilels p15.s, xzr, xzr
sub     z0.d, z0.d, z0.d
//CHECK: sub     z0.d, z0.d, z0.d
ldff1sw {z31.d}, p7/z, [sp, z31.d, lsl #2]
//CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, lsl #2]
mov     z0.b, p0/z, #0
//CHECK: mov     z0.b, p0/z, #0
lsr     z21.b, p5/m, z21.b, #6
//CHECK: lsr     z21.b, p5/m, z21.b, #6
asr     z23.d, p3/m, z23.d, z13.d
//CHECK: asr     z23.d, p3/m, z23.d, z13.d
splice  z21.h, p5, z21.h, z10.h
//CHECK: splice  z21.h, p5, z21.h, z10.h
adr     z0.d, [z0.d, z0.d, sxtw #1]
//CHECK: adr     z0.d, [z0.d, z0.d, sxtw #1]
lsl     z0.s, z0.s, z0.d
//CHECK: lsl     z0.s, z0.s, z0.d
ld1sh   {z23.d}, p3/z, [x13, z8.d, uxtw #1]
//CHECK: ld1sh   {z23.d}, p3/z, [x13, z8.d, uxtw #1]
stnt1h  {z21.h}, p5, [x10, x21, lsl #1]
//CHECK: stnt1h  {z21.h}, p5, [x10, x21, lsl #1]
ctermeq wzr, wzr
//CHECK: ctermeq wzr, wzr
ldnt1d  {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnt1d  {z23.d}, p3/z, [x13, #-8, mul vl]
lsr     z31.s, z31.s, z31.d
//CHECK: lsr     z31.s, z31.s, z31.d
frintp  z23.s, p3/m, z13.s
//CHECK: frintp  z23.s, p3/m, z13.s
prfh    #7, p3, [z13.s, #16]
//CHECK: prfh    #7, p3, [z13.s, #16]
fcmla   z31.s, p7/m, z31.s, z31.s, #270
//CHECK: fcmla   z31.s, p7/m, z31.s, z31.s, #270
trn2    z23.b, z13.b, z8.b
//CHECK: trn2    z23.b, z13.b, z8.b
fabs    z31.s, p7/m, z31.s
//CHECK: fabs    z31.s, p7/m, z31.s
sqdecp  xzr, p15.s, wzr
//CHECK: sqdecp  xzr, p15.s, wzr
cmplt   p5.h, p5/z, z10.h, #-11
//CHECK: cmplt   p5.h, p5/z, z10.h, #-11
inch    z0.h, pow2
//CHECK: inch    z0.h, pow2
fmad    z21.h, p5/m, z10.h, z21.h
//CHECK: fmad    z21.h, p5/m, z10.h, z21.h
add     z21.s, z10.s, z21.s
//CHECK: add     z21.s, z10.s, z21.s
uunpklo z23.h, z13.b
//CHECK: uunpklo z23.h, z13.b
ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl]
//CHECK: ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl]
fmul    z31.d, z31.d, z15.d[1]
//CHECK: fmul    z31.d, z31.d, z15.d[1]
asr     z23.h, p3/m, z23.h, #3
//CHECK: asr     z23.h, p3/m, z23.h, #3
stnt1b  {z5.b}, p3, [x17, x16]
//CHECK: stnt1b  {z5.b}, p3, [x17, x16]
cmpge   p5.d, p5/z, z10.d, #-11
//CHECK: cmpge   p5.d, p5/z, z10.d, #-11
lsr     z31.d, p7/m, z31.d, #1
//CHECK: lsr     z31.d, p7/m, z31.d, #1
fmul    z21.d, z10.d, z5.d[1]
//CHECK: fmul    z21.d, z10.d, z5.d[1]
uqadd   z31.d, z31.d, #255, lsl #8
//CHECK: uqadd   z31.d, z31.d, #65280
ldff1sw {z31.d}, p7/z, [sp, z31.d, sxtw #2]
//CHECK: ldff1sw {z31.d}, p7/z, [sp, z31.d, sxtw #2]
fabs    z31.h, p7/m, z31.h
//CHECK: fabs    z31.h, p7/m, z31.h
fcmuo   p7.s, p3/z, z13.s, z8.s
//CHECK: fcmuo   p7.s, p3/z, z13.s, z8.s
fmul    z21.s, p5/m, z21.s, z10.s
//CHECK: fmul    z21.s, p5/m, z21.s, z10.s
ldff1w  {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ldff1w  {z0.d}, p0/z, [x0, z0.d, sxtw]
uzp1    z31.h, z31.h, z31.h
//CHECK: uzp1    z31.h, z31.h, z31.h
splice  z31.h, p7, z31.h, z31.h
//CHECK: splice  z31.h, p7, z31.h, z31.h
ld4d    {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0]
//CHECK: ld4d    {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0]
smulh   z31.s, p7/m, z31.s, z31.s
//CHECK: smulh   z31.s, p7/m, z31.s, z31.s
subr    z1.b, z1.b, #33
//CHECK: subr    z1.b, z1.b, #33
asr     z21.d, p5/m, z21.d, #22
//CHECK: asr     z21.d, p5/m, z21.d, #22
ld1h    {z23.s}, p3/z, [x13, z8.s, sxtw]
//CHECK: ld1h    {z23.s}, p3/z, [x13, z8.s, sxtw]
uminv   h31, p7, z31.h
//CHECK: uminv   h31, p7, z31.h
decp    z23.s, p13
//CHECK: decp    z23.s, p13
fminv   h0, p0, z0.h
//CHECK: fminv   h0, p0, z0.h
ld1rw   {z0.s}, p0/z, [x0]
//CHECK: ld1rw   {z0.s}, p0/z, [x0]
ld1rqw  {z21.s}, p5/z, [x10, #80]
//CHECK: ld1rqw  {z21.s}, p5/z, [x10, #80]
ld1w    {z0.s}, p0/z, [x0, z0.s, sxtw #2]
//CHECK: ld1w    {z0.s}, p0/z, [x0, z0.s, sxtw #2]
cls     z0.s, p0/m, z0.s
//CHECK: cls     z0.s, p0/m, z0.s
ld1h    {z31.d}, p7/z, [sp, z31.d, sxtw #1]
//CHECK: ld1h    {z31.d}, p7/z, [sp, z31.d, sxtw #1]
mov     z23.s, z13.s[5]
//CHECK: mov     z23.s, z13.s[5]
uzp2    z0.d, z0.d, z0.d
//CHECK: uzp2    z0.d, z0.d, z0.d
sqincp  x0, p0.h
//CHECK: sqincp  x0, p0.h
uqincp  z0.d, p0
//CHECK: uqincp  z0.d, p0
fsub    z23.s, p3/m, z23.s, #1.0
//CHECK: fsub    z23.s, p3/m, z23.s, #1.0
fsqrt   z31.h, p7/m, z31.h
//CHECK: fsqrt   z31.h, p7/m, z31.h
fcmgt   p0.s, p0/z, z0.s, #0.0
//CHECK: fcmgt   p0.s, p0/z, z0.s, #0.0
prfb    #15, p7, [sp, z31.s, sxtw]
//CHECK: prfb    #15, p7, [sp, z31.s, sxtw]
ld1sh   {z0.s}, p0/z, [x0]
//CHECK: ld1sh   {z0.s}, p0/z, [x0]
asr     z31.d, z31.d, #1
//CHECK: asr     z31.d, z31.d, #1
fcvtzu  z31.d, p7/m, z31.s
//CHECK: fcvtzu  z31.d, p7/m, z31.s
fcmne   p5.s, p5/z, z10.s, z21.s
//CHECK: fcmne   p5.s, p5/z, z10.s, z21.s
adr     z21.s, [z10.s, z21.s]
//CHECK: adr     z21.s, [z10.s, z21.s]
smin    z31.s, z31.s, #-1
//CHECK: smin    z31.s, z31.s, #-1
st1b    {z23.d}, p3, [x13, x8]
//CHECK: st1b    {z23.d}, p3, [x13, x8]
mul     z23.d, p3/m, z23.d, z13.d
//CHECK: mul     z23.d, p3/m, z23.d, z13.d
uabd    z23.d, p3/m, z23.d, z13.d
//CHECK: uabd    z23.d, p3/m, z23.d, z13.d
fdiv    z21.d, p5/m, z21.d, z10.d
//CHECK: fdiv    z21.d, p5/m, z21.d, z10.d
umulh   z21.h, p5/m, z21.h, z10.h
//CHECK: umulh   z21.h, p5/m, z21.h, z10.h
ld1h    {z23.s}, p3/z, [z13.s, #16]
//CHECK: ld1h    {z23.s}, p3/z, [z13.s, #16]
frecpe  z0.d, z0.d
//CHECK: frecpe  z0.d, z0.d
mls     z31.d, p7/m, z31.d, z31.d
//CHECK: mls     z31.d, p7/m, z31.d, z31.d
ld1rqb  {z5.b}, p3/z, [x17, x16]
//CHECK: ld1rqb  {z5.b}, p3/z, [x17, x16]
fminnm  z31.d, p7/m, z31.d, z31.d
//CHECK: fminnm  z31.d, p7/m, z31.d, z31.d
prfw    #7, p3, [x13, z8.d, sxtw #2]
//CHECK: prfw    #7, p3, [x13, z8.d, sxtw #2]
umaxv   s21, p5, z10.s
//CHECK: umaxv   s21, p5, z10.s
sunpkhi z31.h, z31.b
//CHECK: sunpkhi z31.h, z31.b
movprfx z0.d, p0/z, z0.d
//CHECK: movprfx z0.d, p0/z, z0.d
add     z0.d, p0/m, z0.d, z1.d
//CHECK: add z0.d, p0/m, z0.d, z1.d
st1b    {z23.d}, p3, [x13, z8.d, uxtw]
//CHECK: st1b    {z23.d}, p3, [x13, z8.d, uxtw]
sqsub   z21.s, z21.s, #170
//CHECK: sqsub   z21.s, z21.s, #170
ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw]
//CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw]
st1b    {z0.s}, p0, [x0, z0.s, sxtw]
//CHECK: st1b    {z0.s}, p0, [x0, z0.s, sxtw]
ldnf1b  {z21.b}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1b  {z21.b}, p5/z, [x10, #5, mul vl]
uqincp  x0, p0.h
//CHECK: uqincp  x0, p0.h
lsr     z0.b, z0.b, #8
//CHECK: lsr     z0.b, z0.b, #8
trn1    z31.s, z31.s, z31.s
//CHECK: trn1    z31.s, z31.s, z31.s
cmphs   p15.b, p7/z, z31.b, #127
//CHECK: cmphs   p15.b, p7/z, z31.b, #127
umin    z0.b, z0.b, #0
//CHECK: umin    z0.b, z0.b, #0
fcmeq   p7.d, p3/z, z13.d, z8.d
//CHECK: fcmeq   p7.d, p3/z, z13.d, z8.d
index   z31.s, #-1, #-1
//CHECK: index   z31.s, #-1, #-1
mul     z0.d, z0.d, #0
//CHECK: mul     z0.d, z0.d, #0
add     z21.h, p5/m, z21.h, z10.h
//CHECK: add     z21.h, p5/m, z21.h, z10.h
ld1b    {z21.b}, p5/z, [x10, x21]
//CHECK: ld1b    {z21.b}, p5/z, [x10, x21]
clastb  w0, p0, w0, z0.b
//CHECK: clastb  w0, p0, w0, z0.b
ldff1b  {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ldff1b  {z23.d}, p3/z, [x13, z8.d, uxtw]
whilels p5.d, x10, x21
//CHECK: whilels p5.d, x10, x21
uqadd   z21.b, z10.b, z21.b
//CHECK: uqadd   z21.b, z10.b, z21.b
mov     z21.d, p5/z, #-86
//CHECK: mov     z21.d, p5/z, #-86
whilelo p0.s, x0, x0
//CHECK: whilelo p0.s, x0, x0
fmla    z31.s, p7/m, z31.s, z31.s
//CHECK: fmla    z31.s, p7/m, z31.s, z31.s
orns    p5.b, p5/z, p10.b, p5.b
//CHECK: orns    p5.b, p5/z, p10.b, p5.b
asrr    z21.s, p5/m, z21.s, z10.s
//CHECK: asrr    z21.s, p5/m, z21.s, z10.s
st1b    {z31.s}, p7, [sp, z31.s, sxtw]
//CHECK: st1b    {z31.s}, p7, [sp, z31.s, sxtw]
fmul    z0.s, z0.s, z0.s[0]
//CHECK: fmul    z0.s, z0.s, z0.s[0]
sqdecp  xzr, p15.d, wzr
//CHECK: sqdecp  xzr, p15.d, wzr
uaddv   d0, p0, z0.s
//CHECK: uaddv   d0, p0, z0.s
ldff1h  {z23.s}, p3/z, [x13, z8.s, sxtw]
//CHECK: ldff1h  {z23.s}, p3/z, [x13, z8.s, sxtw]
udot    z21.d, z10.h, z21.h
//CHECK: udot    z21.d, z10.h, z21.h
fmla    z31.d, z31.d, z15.d[1]
//CHECK: fmla    z31.d, z31.d, z15.d[1]
fmul    z0.s, z0.s, z0.s
//CHECK: fmul    z0.s, z0.s, z0.s
faddv   s31, p7, z31.s
//CHECK: faddv   s31, p7, z31.s
ldff1h  {z0.s}, p0/z, [x0, z0.s, uxtw]
//CHECK: ldff1h  {z0.s}, p0/z, [x0, z0.s, uxtw]
ld1b    {z23.d}, p3/z, [x13, #-8, mul vl]
//CHECK: ld1b    {z23.d}, p3/z, [x13, #-8, mul vl]
lsr     z23.b, p3/m, z23.b, z13.d
//CHECK: lsr     z23.b, p3/m, z23.b, z13.d
clastb  b31, p7, b31, z31.b
//CHECK: clastb  b31, p7, b31, z31.b
fcvtzs  z21.s, p5/m, z10.h
//CHECK: fcvtzs  z21.s, p5/m, z10.h
fnmla   z21.h, p5/m, z10.h, z21.h
//CHECK: fnmla   z21.h, p5/m, z10.h, z21.h
cmple   p0.s, p0/z, z0.s, z0.d
//CHECK: cmple   p0.s, p0/z, z0.s, z0.d
ldff1sw {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d, sxtw]
add     z31.h, p7/m, z31.h, z31.h
//CHECK: add     z31.h, p7/m, z31.h, z31.h
insr    z23.s, w13
//CHECK: insr    z23.s, w13
fmin    z0.d, p0/m, z0.d, #0.0
//CHECK: fmin    z0.d, p0/m, z0.d, #0.0
asr     z31.s, z31.s, z31.d
//CHECK: asr     z31.s, z31.s, z31.d
incp    x21, p10.d
//CHECK: incp    x21, p10.d
lasta   d21, p5, z10.d
//CHECK: lasta   d21, p5, z10.d
add     z23.h, z13.h, z8.h
//CHECK: add     z23.h, z13.h, z8.h
st1b    {z31.d}, p7, [sp, z31.d, sxtw]
//CHECK: st1b    {z31.d}, p7, [sp, z31.d, sxtw]
fmulx   z23.h, p3/m, z23.h, z13.h
//CHECK: fmulx   z23.h, p3/m, z23.h, z13.h
brkpa   p7.b, p11/z, p13.b, p8.b
//CHECK: brkpa   p7.b, p11/z, p13.b, p8.b
trn1    p7.b, p13.b, p8.b
//CHECK: trn1    p7.b, p13.b, p8.b
insr    z0.s, w0
//CHECK: insr    z0.s, w0
mad     z31.s, p7/m, z31.s, z31.s
//CHECK: mad     z31.s, p7/m, z31.s, z31.s
cmpeq   p5.b, p5/z, z10.b, #-11
//CHECK: cmpeq   p5.b, p5/z, z10.b, #-11
umin    z21.s, p5/m, z21.s, z10.s
//CHECK: umin    z21.s, p5/m, z21.s, z10.s
trn1    p5.s, p10.s, p5.s
//CHECK: trn1    p5.s, p10.s, p5.s
umin    z23.s, p3/m, z23.s, z13.s
//CHECK: umin    z23.s, p3/m, z23.s, z13.s
frintx  z31.s, p7/m, z31.s
//CHECK: frintx  z31.s, p7/m, z31.s
trn2    z0.s, z0.s, z0.s
//CHECK: trn2    z0.s, z0.s, z0.s
sqadd   z0.h, z0.h, z0.h
//CHECK: sqadd   z0.h, z0.h, z0.h
ldff1d  {z23.d}, p3/z, [x13, z8.d, lsl #3]
//CHECK: ldff1d  {z23.d}, p3/z, [x13, z8.d, lsl #3]
fcmla   z21.s, z10.s, z5.s[1], #90
//CHECK: fcmla   z21.s, z10.s, z5.s[1], #90
ld1sh   {z31.d}, p7/z, [sp, z31.d, lsl #1]
//CHECK: ld1sh   {z31.d}, p7/z, [sp, z31.d, lsl #1]
sxtw    z23.d, p3/m, z13.d
//CHECK: sxtw    z23.d, p3/m, z13.d
fcmuo   p15.h, p7/z, z31.h, z31.h
//CHECK: fcmuo   p15.h, p7/z, z31.h, z31.h
st1b    {z23.d}, p3, [x13, #-8, mul vl]
//CHECK: st1b    {z23.d}, p3, [x13, #-8, mul vl]
sqdecb  xzr, wzr, all, mul #16
//CHECK: sqdecb  xzr, wzr, all, mul #16
fnmad   z21.h, p5/m, z10.h, z21.h
//CHECK: fnmad   z21.h, p5/m, z10.h, z21.h
sunpklo z21.h, z10.b
//CHECK: sunpklo z21.h, z10.b
ldff1b  {z0.d}, p0/z, [x0, x0]
//CHECK: ldff1b  {z0.d}, p0/z, [x0, x0]
frintn  z21.s, p5/m, z10.s
//CHECK: frintn  z21.s, p5/m, z10.s
fminnm  z0.d, p0/m, z0.d, z0.d
//CHECK: fminnm  z0.d, p0/m, z0.d, z0.d
asrr    z0.b, p0/m, z0.b, z0.b
//CHECK: asrr    z0.b, p0/m, z0.b, z0.b
uqincp  x0, p0.s
//CHECK: uqincp  x0, p0.s
brkb    p7.b, p11/z, p13.b
//CHECK: brkb    p7.b, p11/z, p13.b
ld1h    {z5.s}, p3/z, [x17, x16, lsl #1]
//CHECK: ld1h    {z5.s}, p3/z, [x17, x16, lsl #1]
andv    h0, p0, z0.h
//CHECK: andv    h0, p0, z0.h
cmpgt   p5.h, p5/z, z10.h, z21.d
//CHECK: cmpgt   p5.h, p5/z, z10.h, z21.d
ldff1h  {z31.d}, p7/z, [sp, z31.d]
//CHECK: ldff1h  {z31.d}, p7/z, [sp, z31.d]
fexpa   z0.s, z0.s
//CHECK: fexpa   z0.s, z0.s
smax    z31.s, p7/m, z31.s, z31.s
//CHECK: smax    z31.s, p7/m, z31.s, z31.s
ld1b    {z21.s}, p5/z, [x10, z21.s, uxtw]
//CHECK: ld1b    {z21.s}, p5/z, [x10, z21.s, uxtw]
st1b    {z0.d}, p0, [x0, z0.d, sxtw]
//CHECK: st1b    {z0.d}, p0, [x0, z0.d, sxtw]
andv    h21, p5, z10.h
//CHECK: andv    h21, p5, z10.h
ptrues  p7.h, vl256
//CHECK: ptrues  p7.h, vl256
uunpklo z21.h, z10.b
//CHECK: uunpklo z21.h, z10.b
add     z31.d, p7/m, z31.d, z31.d
//CHECK: add     z31.d, p7/m, z31.d, z31.d
compact z21.s, p5, z10.s
//CHECK: compact z21.s, p5, z10.s
fmul    z21.d, p5/m, z21.d, z10.d
//CHECK: fmul    z21.d, p5/m, z21.d, z10.d
ld1sb   {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ld1sb   {z21.d}, p5/z, [x10, z21.d, sxtw]
sub     z31.s, z31.s, z31.s
//CHECK: sub     z31.s, z31.s, z31.s
lsr     z21.b, z10.b, #3
//CHECK: lsr     z21.b, z10.b, #3
st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, #20, mul vl]
//CHECK: st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, #20, mul vl]
st1b    {z31.d}, p7, [sp, #-1, mul vl]
//CHECK: st1b    {z31.d}, p7, [sp, #-1, mul vl]
fmad    z0.d, p0/m, z0.d, z0.d
//CHECK: fmad    z0.d, p0/m, z0.d, z0.d
sqdecp  x0, p0.b
//CHECK: sqdecp  x0, p0.b
prfw    #7, p3, [z13.d, #32]
//CHECK: prfw    #7, p3, [z13.d, #32]
fminnm  z21.h, p5/m, z21.h, z10.h
//CHECK: fminnm  z21.h, p5/m, z21.h, z10.h
sxtb    z31.d, p7/m, z31.d
//CHECK: sxtb    z31.d, p7/m, z31.d
uqdecw  z21.s, vl32, mul #6
//CHECK: uqdecw  z21.s, vl32, mul #6
ldff1w  {z23.s}, p3/z, [z13.s, #32]
//CHECK: ldff1w  {z23.s}, p3/z, [z13.s, #32]
ld1sh   {z0.d}, p0/z, [z0.d]
//CHECK: ld1sh   {z0.d}, p0/z, [z0.d]
ldff1h  {z0.d}, p0/z, [x0, x0, lsl #1]
//CHECK: ldff1h  {z0.d}, p0/z, [x0, x0, lsl #1]
lsr     z31.b, z31.b, #1
//CHECK: lsr     z31.b, z31.b, #1
str     z23, [x13, #67, mul vl]
//CHECK: str     z23, [x13, #67, mul vl]
lsl     z31.s, z31.s, z31.d
//CHECK: lsl     z31.s, z31.s, z31.d
fabd    z0.h, p0/m, z0.h, z0.h
//CHECK: fabd    z0.h, p0/m, z0.h, z0.h
ld1sh   {z0.s}, p0/z, [x0, z0.s, uxtw #1]
//CHECK: ld1sh   {z0.s}, p0/z, [x0, z0.s, uxtw #1]
saddv   d0, p0, z0.b
//CHECK: saddv   d0, p0, z0.b
dupm    z0.s, #0x1
//CHECK: dupm    z0.s, #0x1
decp    x21, p10.s
//CHECK: decp    x21, p10.s
asr     z21.s, p5/m, z21.s, z10.d
//CHECK: asr     z21.s, p5/m, z21.s, z10.d
lsrr    z0.b, p0/m, z0.b, z0.b
//CHECK: lsrr    z0.b, p0/m, z0.b, z0.b
whilelt p5.s, w10, w21
//CHECK: whilelt p5.s, w10, w21
frintp  z23.d, p3/m, z13.d
//CHECK: frintp  z23.d, p3/m, z13.d
uqincp  w23, p13.h
//CHECK: uqincp  w23, p13.h
trn2    p0.h, p0.h, p0.h
//CHECK: trn2    p0.h, p0.h, p0.h
bic     z21.h, p5/m, z21.h, z10.h
//CHECK: bic     z21.h, p5/m, z21.h, z10.h
fmulx   z0.d, p0/m, z0.d, z0.d
//CHECK: fmulx   z0.d, p0/m, z0.d, z0.d
lsr     z0.d, p0/m, z0.d, z0.d
//CHECK: lsr     z0.d, p0/m, z0.d, z0.d
asr     z23.s, z13.s, #24
//CHECK: asr     z23.s, z13.s, #24
adr     z21.d, [z10.d, z21.d, sxtw]
//CHECK: adr     z21.d, [z10.d, z21.d, sxtw]
add     z21.s, p5/m, z21.s, z10.s
//CHECK: add     z21.s, p5/m, z21.s, z10.s
sqincp  x21, p10.d
//CHECK: sqincp  x21, p10.d
fnmsb   z23.h, p3/m, z13.h, z8.h
//CHECK: fnmsb   z23.h, p3/m, z13.h, z8.h
smin    z0.b, z0.b, #0
//CHECK: smin    z0.b, z0.b, #0
uzp2    p0.d, p0.d, p0.d
//CHECK: uzp2    p0.d, p0.d, p0.d
fcvtzu  z21.s, p5/m, z10.s
//CHECK: fcvtzu  z21.s, p5/m, z10.s
ld1sw   {z0.d}, p0/z, [x0, x0, lsl #2]
//CHECK: ld1sw   {z0.d}, p0/z, [x0, x0, lsl #2]
ld1rqb  {z21.b}, p5/z, [x10, x21]
//CHECK: ld1rqb  {z21.b}, p5/z, [x10, x21]
umin    z0.s, p0/m, z0.s, z0.s
//CHECK: umin    z0.s, p0/m, z0.s, z0.s
cmphi   p15.d, p7/z, z31.d, #127
//CHECK: cmphi   p15.d, p7/z, z31.d, #127
mov     z23.s, p3/m, s13
//CHECK: mov     z23.s, p3/m, s13
sqdecd  xzr, wzr, all, mul #16
//CHECK: sqdecd  xzr, wzr, all, mul #16
rev     z31.s, z31.s
//CHECK: rev     z31.s, z31.s
mov     z23.h, p8/z, #109, lsl #8
//CHECK: mov     z23.h, p8/z, #27904
fexpa   z31.s, z31.s
//CHECK: fexpa   z31.s, z31.s
frecpx  z23.d, p3/m, z13.d
//CHECK: frecpx  z23.d, p3/m, z13.d
ptrues  p15.b
//CHECK: ptrues  p15.b
prfb    #7, p3, [x13, z8.d, sxtw]
//CHECK: prfb    #7, p3, [x13, z8.d, sxtw]
ldff1b  {z23.s}, p3/z, [x13, z8.s, sxtw]
//CHECK: ldff1b  {z23.s}, p3/z, [x13, z8.s, sxtw]
sub     z21.d, z21.d, #170
//CHECK: sub     z21.d, z21.d, #170
orr     z21.b, p5/m, z21.b, z10.b
//CHECK: orr     z21.b, p5/m, z21.b, z10.b
ld1h    {z5.d}, p3/z, [x17, x16, lsl #1]
//CHECK: ld1h    {z5.d}, p3/z, [x17, x16, lsl #1]
sminv   d21, p5, z10.d
//CHECK: sminv   d21, p5, z10.d
incd    z21.d, vl32, mul #6
//CHECK: incd    z21.d, vl32, mul #6
st3b    {z23.b, z24.b, z25.b}, p3, [x13, #-24, mul vl]
//CHECK: st3b    {z23.b, z24.b, z25.b}, p3, [x13, #-24, mul vl]
lastb   w0, p0, z0.b
//CHECK: lastb   w0, p0, z0.b
ldff1sw {z21.d}, p5/z, [z10.d, #84]
//CHECK: ldff1sw {z21.d}, p5/z, [z10.d, #84]
fdiv    z23.s, p3/m, z23.s, z13.s
//CHECK: fdiv    z23.s, p3/m, z23.s, z13.s
inch    xzr, all, mul #16
//CHECK: inch    xzr, all, mul #16
fmov    z31.h, p15/m, #-1.9375
//CHECK: fmov    z31.h, p15/m, #-1.9375
asr     z0.h, z0.h, #16
//CHECK: asr     z0.h, z0.h, #16
fmin    z0.h, p0/m, z0.h, #0.0
//CHECK: fmin    z0.h, p0/m, z0.h, #0.0
smax    z0.s, p0/m, z0.s, z0.s
//CHECK: smax    z0.s, p0/m, z0.s, z0.s
neg     z21.d, p5/m, z10.d
//CHECK: neg     z21.d, p5/m, z10.d
sqdecp  x0, p0.h, w0
//CHECK: sqdecp  x0, p0.h, w0
ptrue   p15.b
//CHECK: ptrue   p15.b
fmul    z0.h, p0/m, z0.h, z0.h
//CHECK: fmul    z0.h, p0/m, z0.h, z0.h
fdivr   z23.h, p3/m, z23.h, z13.h
//CHECK: fdivr   z23.h, p3/m, z23.h, z13.h
trn2    z0.d, z0.d, z0.d
//CHECK: trn2    z0.d, z0.d, z0.d
prfb    pldl3strm, p5, [x10, x21]
//CHECK: prfb    pldl3strm, p5, [x10, x21]
uqsub   z31.d, z31.d, z31.d
//CHECK: uqsub   z31.d, z31.d, z31.d
st1d    {z21.d}, p5, [x10, z21.d, uxtw #3]
//CHECK: st1d    {z21.d}, p5, [x10, z21.d, uxtw #3]
rev     p5.s, p10.s
//CHECK: rev     p5.s, p10.s
ld1sb   {z31.h}, p7/z, [sp, #-1, mul vl]
//CHECK: ld1sb   {z31.h}, p7/z, [sp, #-1, mul vl]
smin    z0.s, p0/m, z0.s, z0.s
//CHECK: smin    z0.s, p0/m, z0.s, z0.s
whilelt p7.d, x13, x8
//CHECK: whilelt p7.d, x13, x8
decw    z23.s, vl256, mul #9
//CHECK: decw    z23.s, vl256, mul #9
st1w    {z23.d}, p3, [x13, z8.d, sxtw #2]
//CHECK: st1w    {z23.d}, p3, [x13, z8.d, sxtw #2]
fmaxv   d31, p7, z31.d
//CHECK: fmaxv   d31, p7, z31.d
smin    z21.s, p5/m, z21.s, z10.s
//CHECK: smin    z21.s, p5/m, z21.s, z10.s
ldff1h  {z31.s}, p7/z, [sp, z31.s, sxtw]
//CHECK: ldff1h  {z31.s}, p7/z, [sp, z31.s, sxtw]
ldnt1b  {z23.b}, p3/z, [x13, x8]
//CHECK: ldnt1b  {z23.b}, p3/z, [x13, x8]
ld1w    {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ld1w    {z23.d}, p3/z, [x13, z8.d, uxtw]
uxth    z0.s, p0/m, z0.s
//CHECK: uxth    z0.s, p0/m, z0.s
lasta   w0, p0, z0.s
//CHECK: lasta   w0, p0, z0.s
prfh    #7, p3, [x13, z8.d, sxtw #1]
//CHECK: prfh    #7, p3, [x13, z8.d, sxtw #1]
st1b    {z0.s}, p0, [z0.s]
//CHECK: st1b    {z0.s}, p0, [z0.s]
lsl     z0.s, p0/m, z0.s, z0.d
//CHECK: lsl     z0.s, p0/m, z0.s, z0.d
mov     z1.b, #33
//CHECK: mov     z1.b, #33
asr     z31.b, z31.b, z31.d
//CHECK: asr     z31.b, z31.b, z31.d
cnot    z31.d, p7/m, z31.d
//CHECK: cnot    z31.d, p7/m, z31.d
mov     z24.q, q19
//CHECK: mov     z24.q, q19
trn1    p5.b, p10.b, p5.b
//CHECK: trn1    p5.b, p10.b, p5.b
sqadd   z23.s, z23.s, #109, lsl #8
//CHECK: sqadd   z23.s, z23.s, #27904
fmul    z23.d, p3/m, z23.d, #2.0
//CHECK: fmul    z23.d, p3/m, z23.d, #2.0
mov     z0.s, s12
//CHECK: mov     z0.s, s12
clastb  h31, p7, h31, z31.h
//CHECK: clastb  h31, p7, h31, z31.h
lsl     z0.d, p0/m, z0.d, z0.d
//CHECK: lsl     z0.d, p0/m, z0.d, z0.d
ldff1d  {z0.d}, p0/z, [x0, z0.d, lsl #3]
//CHECK: ldff1d  {z0.d}, p0/z, [x0, z0.d, lsl #3]
lsl     z31.d, p7/m, z31.d, #63
//CHECK: lsl     z31.d, p7/m, z31.d, #63
ldff1sb {z0.d}, p0/z, [x0, x0]
//CHECK: ldff1sb {z0.d}, p0/z, [x0, x0]
frecpx  z21.s, p5/m, z10.s
//CHECK: frecpx  z21.s, p5/m, z10.s
uzp1    z31.d, z31.d, z31.d
//CHECK: uzp1    z31.d, z31.d, z31.d
sqadd   z21.b, z21.b, #170
//CHECK: sqadd   z21.b, z21.b, #170
stnt1b  {z21.b}, p5, [x10, x21]
//CHECK: stnt1b  {z21.b}, p5, [x10, x21]
ld1rh   {z0.h}, p0/z, [x0]
//CHECK: ld1rh   {z0.h}, p0/z, [x0]
fcmle   p5.s, p5/z, z10.s, #0.0
//CHECK: fcmle   p5.s, p5/z, z10.s, #0.0
sqincp  x0, p0.d, w0
//CHECK: sqincp  x0, p0.d, w0
frecps  z0.s, z0.s, z0.s
//CHECK: frecps  z0.s, z0.s, z0.s
ld1h    {z0.s}, p0/z, [x0, z0.s, uxtw]
//CHECK: ld1h    {z0.s}, p0/z, [x0, z0.s, uxtw]
zip1    p15.s, p15.s, p15.s
//CHECK: zip1    p15.s, p15.s, p15.s
sqincw  x0, pow2
//CHECK: sqincw  x0, pow2
fnmls   z31.h, p7/m, z31.h, z31.h
//CHECK: fnmls   z31.h, p7/m, z31.h, z31.h
sqdecw  x0, w0, pow2
//CHECK: sqdecw  x0, w0, pow2
eorv    h21, p5, z10.h
//CHECK: eorv    h21, p5, z10.h
prfb    #7, p3, [x13, z8.s, sxtw]
//CHECK: prfb    #7, p3, [x13, z8.s, sxtw]
ld1sb   {z21.s}, p5/z, [x10, z21.s, uxtw]
//CHECK: ld1sb   {z21.s}, p5/z, [x10, z21.s, uxtw]
sqincp  x0, p0.b, w0
//CHECK: sqincp  x0, p0.b, w0
fmls    z0.d, p0/m, z0.d, z0.d
//CHECK: fmls    z0.d, p0/m, z0.d, z0.d
sunpkhi z21.h, z10.b
//CHECK: sunpkhi z21.h, z10.b
cnt     z0.h, p0/m, z0.h
//CHECK: cnt     z0.h, p0/m, z0.h
ld1w    {z31.d}, p7/z, [z31.d, #124]
//CHECK: ld1w    {z31.d}, p7/z, [z31.d, #124]
uunpklo z23.d, z13.s
//CHECK: uunpklo z23.d, z13.s
ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw #3]
//CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, uxtw #3]
ld2h    {z21.h, z22.h}, p5/z, [x10, #10, mul vl]
//CHECK: ld2h    {z21.h, z22.h}, p5/z, [x10, #10, mul vl]
index   z31.h, wzr, #-1
//CHECK: index   z31.h, wzr, #-1
add     z31.b, p7/m, z31.b, z31.b
//CHECK: add     z31.b, p7/m, z31.b, z31.b
whilelo p7.d, w13, w8
//CHECK: whilelo p7.d, w13, w8
fmov    z0.s, #2.0
//CHECK: fmov    z0.s, #2.0
clasta  z21.b, p5, z21.b, z10.b
//CHECK: clasta  z21.b, p5, z21.b, z10.b
adr     z21.d, [z10.d, z21.d, uxtw #2]
//CHECK: adr     z21.d, [z10.d, z21.d, uxtw #2]
sdot    z23.s, z13.b, z8.b
//CHECK: sdot    z23.s, z13.b, z8.b
ucvtf   z21.d, p5/m, z10.s
//CHECK: ucvtf   z21.d, p5/m, z10.s
cmpeq   p7.d, p3/z, z13.d, z8.d
//CHECK: cmpeq   p7.d, p3/z, z13.d, z8.d
dech    z23.h, vl256, mul #9
//CHECK: dech    z23.h, vl256, mul #9
fsub    z23.h, z13.h, z8.h
//CHECK: fsub    z23.h, z13.h, z8.h
clasta  h21, p5, h21, z10.h
//CHECK: clasta  h21, p5, h21, z10.h
ldff1sw {z23.d}, p3/z, [x13, z8.d, sxtw #2]
//CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, sxtw #2]
sabd    z21.h, p5/m, z21.h, z10.h
//CHECK: sabd    z21.h, p5/m, z21.h, z10.h
movprfx z23.b, p3/z, z13.b
//CHECK: movprfx z23.b, p3/z, z13.b
add     z23.b, p3/m, z23.b, z24.b
//CHECK: add z23.b, p3/m, z23.b, z24.b
ldff1w  {z21.d}, p5/z, [x10, z21.d, uxtw #2]
//CHECK: ldff1w  {z21.d}, p5/z, [x10, z21.d, uxtw #2]
ld1rb   {z0.s}, p0/z, [x0]
//CHECK: ld1rb   {z0.s}, p0/z, [x0]
ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw]
prfh    pldl1keep, p0, [x0, z0.d, uxtw #1]
//CHECK: prfh    pldl1keep, p0, [x0, z0.d, uxtw #1]
lasta   d31, p7, z31.d
//CHECK: lasta   d31, p7, z31.d
ld1rh   {z31.s}, p7/z, [sp, #126]
//CHECK: ld1rh   {z31.s}, p7/z, [sp, #126]
ld1d    {z23.d}, p3/z, [x13, x8, lsl #3]
//CHECK: ld1d    {z23.d}, p3/z, [x13, x8, lsl #3]
prfd    pldl3strm, p5, [z10.s, #168]
//CHECK: prfd    pldl3strm, p5, [z10.s, #168]
st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0, x0, lsl #1]
//CHECK: st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0, x0, lsl #1]
uqinch  w23, vl256, mul #9
//CHECK: uqinch  w23, vl256, mul #9
fcvtzs  z0.d, p0/m, z0.s
//CHECK: fcvtzs  z0.d, p0/m, z0.s
ld1d    {z0.d}, p0/z, [x0, z0.d, lsl #3]
//CHECK: ld1d    {z0.d}, p0/z, [x0, z0.d, lsl #3]
prfb    #7, p3, [x13, z8.s, uxtw]
//CHECK: prfb    #7, p3, [x13, z8.s, uxtw]
cmple   p7.b, p3/z, z13.b, #8
//CHECK: cmple   p7.b, p3/z, z13.b, #8
ldff1w  {z0.s}, p0/z, [x0, z0.s, uxtw #2]
//CHECK: ldff1w  {z0.s}, p0/z, [x0, z0.s, uxtw #2]
ld1rqh  {z21.h}, p5/z, [x10, #80]
//CHECK: ld1rqh  {z21.h}, p5/z, [x10, #80]
msb     z21.d, p5/m, z21.d, z10.d
//CHECK: msb     z21.d, p5/m, z21.d, z10.d
index   z21.h, w10, #-11
//CHECK: index   z21.h, w10, #-11
fmin    z21.h, p5/m, z21.h, #0.0
//CHECK: fmin    z21.h, p5/m, z21.h, #0.0
zip2    z31.h, z31.h, z31.h
//CHECK: zip2    z31.h, z31.h, z31.h
st1b    {z31.s}, p7, [sp, #-1, mul vl]
//CHECK: st1b    {z31.s}, p7, [sp, #-1, mul vl]
frintm  z31.h, p7/m, z31.h
//CHECK: frintm  z31.h, p7/m, z31.h
ld1d    {z21.d}, p5/z, [x10, z21.d, sxtw]
//CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, sxtw]
trn2    p5.h, p10.h, p5.h
//CHECK: trn2    p5.h, p10.h, p5.h
sabd    z0.d, p0/m, z0.d, z0.d
//CHECK: sabd    z0.d, p0/m, z0.d, z0.d
cmpne   p15.b, p7/z, z31.b, z31.d
//CHECK: cmpne   p15.b, p7/z, z31.b, z31.d
lsr     z0.s, p0/m, z0.s, z0.d
//CHECK: lsr     z0.s, p0/m, z0.s, z0.d
trn1    p15.b, p15.b, p15.b
//CHECK: trn1    p15.b, p15.b, p15.b
sunpkhi z21.d, z10.s
//CHECK: sunpkhi z21.d, z10.s
umin    z23.h, p3/m, z23.h, z13.h
//CHECK: umin    z23.h, p3/m, z23.h, z13.h
cmpgt   p7.h, p3/z, z13.h, z8.d
//CHECK: cmpgt   p7.h, p3/z, z13.h, z8.d
asrd    z21.b, p5/m, z21.b, #6
//CHECK: asrd    z21.b, p5/m, z21.b, #6
lsr     z31.s, p7/m, z31.s, z31.d
//CHECK: lsr     z31.s, p7/m, z31.s, z31.d
stnt1b  {z23.b}, p3, [x13, x8]
//CHECK: stnt1b  {z23.b}, p3, [x13, x8]
eorv    h31, p7, z31.h
//CHECK: eorv    h31, p7, z31.h
sqadd   z31.h, z31.h, #255, lsl #8
//CHECK: sqadd   z31.h, z31.h, #65280
ldff1b  {z0.s}, p0/z, [x0, x0]
//CHECK: ldff1b  {z0.s}, p0/z, [x0, x0]
frinta  z21.h, p5/m, z10.h
//CHECK: frinta  z21.h, p5/m, z10.h
ctermne w13, w8
//CHECK: ctermne w13, w8
uqdecb  w21, vl32, mul #6
//CHECK: uqdecb  w21, vl32, mul #6
st1w    {z0.d}, p0, [x0, x0, lsl #2]
//CHECK: st1w    {z0.d}, p0, [x0, x0, lsl #2]
zip2    p15.h, p15.h, p15.h
//CHECK: zip2    p15.h, p15.h, p15.h
st2b    {z23.b, z24.b}, p3, [x13, #-16, mul vl]
//CHECK: st2b    {z23.b, z24.b}, p3, [x13, #-16, mul vl]
asr     z23.d, z13.d, #24
//CHECK: asr     z23.d, z13.d, #24
whilelt p7.b, x13, x8
//CHECK: whilelt p7.b, x13, x8
fmla    z0.d, p0/m, z0.d, z0.d
//CHECK: fmla    z0.d, p0/m, z0.d, z0.d
stnt1w  {z0.s}, p0, [x0, x0, lsl #2]
//CHECK: stnt1w  {z0.s}, p0, [x0, x0, lsl #2]
clz     z0.d, p0/m, z0.d
//CHECK: clz     z0.d, p0/m, z0.d
smax    z21.s, p5/m, z21.s, z10.s
//CHECK: smax    z21.s, p5/m, z21.s, z10.s
cmplo   p0.b, p0/z, z0.b, #0
//CHECK: cmplo   p0.b, p0/z, z0.b, #0
cnot    z23.h, p3/m, z13.h
//CHECK: cnot    z23.h, p3/m, z13.h
prfw    pldl1keep, p0, [x0]
//CHECK: prfw    pldl1keep, p0, [x0]
prfh    #7, p3, [x13, z8.s, uxtw #1]
//CHECK: prfh    #7, p3, [x13, z8.s, uxtw #1]
fsubr   z31.h, p7/m, z31.h, z31.h
//CHECK: fsubr   z31.h, p7/m, z31.h, z31.h
bic     z23.d, z13.d, z8.d
//CHECK: bic     z23.d, z13.d, z8.d
sqadd   z0.s, z0.s, z0.s
//CHECK: sqadd   z0.s, z0.s, z0.s
umin    z21.s, z21.s, #170
//CHECK: umin    z21.s, z21.s, #170
st1h    {z23.s}, p3, [x13, z8.s, uxtw]
//CHECK: st1h    {z23.s}, p3, [x13, z8.s, uxtw]
sqdech  x0, w0, pow2
//CHECK: sqdech  x0, w0, pow2
uqdecp  wzr, p15.h
//CHECK: uqdecp  wzr, p15.h
smax    z31.h, p7/m, z31.h, z31.h
//CHECK: smax    z31.h, p7/m, z31.h, z31.h
ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw]
//CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw]
ldff1sb {z0.d}, p0/z, [z0.d]
//CHECK: ldff1sb {z0.d}, p0/z, [z0.d]
cmplo   p15.s, p7/z, z31.s, z31.d
//CHECK: cmplo   p15.s, p7/z, z31.s, z31.d
fcmuo   p0.d, p0/z, z0.d, z0.d
//CHECK: fcmuo   p0.d, p0/z, z0.d, z0.d
sabd    z23.d, p3/m, z23.d, z13.d
//CHECK: sabd    z23.d, p3/m, z23.d, z13.d
cmpeq   p15.d, p7/z, z31.d, z31.d
//CHECK: cmpeq   p15.d, p7/z, z31.d, z31.d
incp    x23, p13.h
//CHECK: incp    x23, p13.h
st1d    {z31.d}, p7, [sp, #-1, mul vl]
//CHECK: st1d    {z31.d}, p7, [sp, #-1, mul vl]
pnext   p15.s, p15, p15.s
//CHECK: pnext   p15.s, p15, p15.s
fsub    z0.s, z0.s, z0.s
//CHECK: fsub    z0.s, z0.s, z0.s
whilelo p0.b, x0, x0
//CHECK: whilelo p0.b, x0, x0
ld1sh   {z0.d}, p0/z, [x0, x0, lsl #1]
//CHECK: ld1sh   {z0.d}, p0/z, [x0, x0, lsl #1]
uzp1    z0.b, z0.b, z0.b
//CHECK: uzp1    z0.b, z0.b, z0.b
adr     z31.d, [z31.d, z31.d, lsl #3]
//CHECK: adr     z31.d, [z31.d, z31.d, lsl #3]
ld4d    {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0, x0, lsl #3]
//CHECK: ld4d    {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0, x0, lsl #3]
cmplo   p5.h, p5/z, z10.h, #85
//CHECK: cmplo   p5.h, p5/z, z10.h, #85
st1w    {z23.s}, p3, [x13, z8.s, sxtw]
//CHECK: st1w    {z23.s}, p3, [x13, z8.s, sxtw]
stnt1b  {z23.b}, p3, [x13, #-8, mul vl]
//CHECK: stnt1b  {z23.b}, p3, [x13, #-8, mul vl]
fadd    z31.h, p7/m, z31.h, z31.h
//CHECK: fadd    z31.h, p7/m, z31.h, z31.h
fcmle   p7.s, p3/z, z13.s, #0.0
//CHECK: fcmle   p7.s, p3/z, z13.s, #0.0
fmax    z23.s, p3/m, z23.s, #1.0
//CHECK: fmax    z23.s, p3/m, z23.s, #1.0
orr     z23.d, p3/m, z23.d, z13.d
//CHECK: orr     z23.d, p3/m, z23.d, z13.d
fsqrt   z31.s, p7/m, z31.s
//CHECK: fsqrt   z31.s, p7/m, z31.s
subr    z0.d, p0/m, z0.d, z0.d
//CHECK: subr    z0.d, p0/m, z0.d, z0.d
incb    x0, pow2
//CHECK: incb    x0, pow2
ld1sb   {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ld1sb   {z23.d}, p3/z, [x13, z8.d, uxtw]
sqincp  x21, p10.h
//CHECK: sqincp  x21, p10.h
fcmgt   p15.h, p7/z, z31.h, #0.0
//CHECK: fcmgt   p15.h, p7/z, z31.h, #0.0
sqadd   z21.s, z21.s, #170
//CHECK: sqadd   z21.s, z21.s, #170
index   z21.s, #10, w21
//CHECK: index   z21.s, #10, w21
decp    xzr, p15.b
//CHECK: decp    xzr, p15.b
ld1rh   {z0.s}, p0/z, [x0]
//CHECK: ld1rh   {z0.s}, p0/z, [x0]
smin    z23.s, p3/m, z23.s, z13.s
//CHECK: smin    z23.s, p3/m, z23.s, z13.s
movprfx z23.s, p3/m, z13.s
//CHECK: movprfx z23.s, p3/m, z13.s
add     z23.s, p3/m, z23.s, z24.s
//CHECK: add z23.s, p3/m, z23.s, z24.s
smax    z21.d, p5/m, z21.d, z10.d
//CHECK: smax    z21.d, p5/m, z21.d, z10.d
whilels p7.s, x13, x8
//CHECK: whilels p7.s, x13, x8
fadd    z23.d, p3/m, z23.d, z13.d
//CHECK: fadd    z23.d, p3/m, z23.d, z13.d
not     z21.s, p5/m, z10.s
//CHECK: not     z21.s, p5/m, z10.s
fmin    z21.s, p5/m, z21.s, z10.s
//CHECK: fmin    z21.s, p5/m, z21.s, z10.s
sqincp  x21, p10.h, w21
//CHECK: sqincp  x21, p10.h, w21
cnth    x23, vl256, mul #9
//CHECK: cnth    x23, vl256, mul #9
ld1sb   {z31.d}, p7/z, [z31.d, #31]
//CHECK: ld1sb   {z31.d}, p7/z, [z31.d, #31]
asr     z0.d, p0/m, z0.d, z0.d
//CHECK: asr     z0.d, p0/m, z0.d, z0.d
scvtf   z0.h, p0/m, z0.d
//CHECK: scvtf   z0.h, p0/m, z0.d
sqinch  z21.h, vl32, mul #6
//CHECK: sqinch  z21.h, vl32, mul #6
uqdech  z0.h, pow2
//CHECK: uqdech  z0.h, pow2
lsl     z21.s, p5/m, z21.s, #10
//CHECK: lsl     z21.s, p5/m, z21.s, #10
brkpbs  p15.b, p15/z, p15.b, p15.b
//CHECK: brkpbs  p15.b, p15/z, p15.b, p15.b
scvtf   z23.d, p3/m, z13.s
//CHECK: scvtf   z23.d, p3/m, z13.s
ldr     z23, [x13, #67, mul vl]
//CHECK: ldr     z23, [x13, #67, mul vl]
index   z23.b, #13, w8
//CHECK: index   z23.b, #13, w8
index   z21.d, x10, x21
//CHECK: index   z21.d, x10, x21
ldnf1b  {z21.s}, p5/z, [x10, #5, mul vl]
//CHECK: ldnf1b  {z21.s}, p5/z, [x10, #5, mul vl]
mov     z23.q, z13.q[1]
//CHECK: mov     z23.q, z13.q[1]
scvtf   z21.h, p5/m, z10.h
//CHECK: scvtf   z21.h, p5/m, z10.h
fcmuo   p7.h, p3/z, z13.h, z8.h
//CHECK: fcmuo   p7.h, p3/z, z13.h, z8.h
fadda   h21, p5, h21, z10.h
//CHECK: fadda   h21, p5, h21, z10.h
lasta   h31, p7, z31.h
//CHECK: lasta   h31, p7, z31.h
uqdech  wzr, all, mul #16
//CHECK: uqdech  wzr, all, mul #16
ld1sh   {z23.s}, p3/z, [x13, x8, lsl #1]
//CHECK: ld1sh   {z23.s}, p3/z, [x13, x8, lsl #1]
lastb   b31, p7, z31.b
//CHECK: lastb   b31, p7, z31.b
ld2h    {z31.h, z0.h}, p7/z, [sp, #-2, mul vl]
//CHECK: ld2h    {z31.h, z0.h}, p7/z, [sp, #-2, mul vl]
asr     z31.s, p7/m, z31.s, #1
//CHECK: asr     z31.s, p7/m, z31.s, #1
prfd    #15, p7, [sp, #-1, mul vl]
//CHECK: prfd    #15, p7, [sp, #-1, mul vl]
prfd    #7, p3, [x13, z8.d, lsl #3]
//CHECK: prfd    #7, p3, [x13, z8.d, lsl #3]
st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, #-32, mul vl]
//CHECK: st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, #-32, mul vl]
ld1rb   {z0.b}, p0/z, [x0]
//CHECK: ld1rb   {z0.b}, p0/z, [x0]
uzp2    p0.h, p0.h, p0.h
//CHECK: uzp2    p0.h, p0.h, p0.h
prfd    pldl3strm, p5, [x10, z21.d, lsl #3]
//CHECK: prfd    pldl3strm, p5, [x10, z21.d, lsl #3]
prfh    pldl1keep, p0, [x0, z0.s, sxtw #1]
//CHECK: prfh    pldl1keep, p0, [x0, z0.s, sxtw #1]
uzp1    z21.b, z10.b, z21.b
//CHECK: uzp1    z21.b, z10.b, z21.b
prfd    #7, p3, [x13, z8.d, uxtw #3]
//CHECK: prfd    #7, p3, [x13, z8.d, uxtw #3]
neg     z21.h, p5/m, z10.h
//CHECK: neg     z21.h, p5/m, z10.h
smin    z23.d, p3/m, z23.d, z13.d
//CHECK: smin    z23.d, p3/m, z23.d, z13.d
fexpa   z31.d, z31.d
//CHECK: fexpa   z31.d, z31.d
mov     z0.s, s0
//CHECK: mov     z0.s, s0
subr    z21.h, p5/m, z21.h, z10.h
//CHECK: subr    z21.h, p5/m, z21.h, z10.h
frintp  z31.d, p7/m, z31.d
//CHECK: frintp  z31.d, p7/m, z31.d
ldff1h  {z0.d}, p0/z, [x0, z0.d, uxtw #1]
//CHECK: ldff1h  {z0.d}, p0/z, [x0, z0.d, uxtw #1]
clz     z23.h, p3/m, z13.h
//CHECK: clz     z23.h, p3/m, z13.h
lsl     z0.h, p0/m, z0.h, #0
//CHECK: lsl     z0.h, p0/m, z0.h, #0
fmaxv   d21, p5, z10.d
//CHECK: fmaxv   d21, p5, z10.d
mls     z0.s, p0/m, z0.s, z0.s
//CHECK: mls     z0.s, p0/m, z0.s, z0.s
cntb    xzr, all, mul #16
//CHECK: cntb    xzr, all, mul #16
fmul    z23.d, z13.d, z8.d[0]
//CHECK: fmul    z23.d, z13.d, z8.d[0]
smax    z0.d, p0/m, z0.d, z0.d
//CHECK: smax    z0.d, p0/m, z0.d, z0.d
saddv   d31, p7, z31.s
//CHECK: saddv   d31, p7, z31.s
fmax    z0.s, p0/m, z0.s, z0.s
//CHECK: fmax    z0.s, p0/m, z0.s, z0.s
zip2    z23.h, z13.h, z8.h
//CHECK: zip2    z23.h, z13.h, z8.h
rbit    z0.s, p0/m, z0.s
//CHECK: rbit    z0.s, p0/m, z0.s
incw    z23.s, vl256, mul #9
//CHECK: incw    z23.s, vl256, mul #9
smin    z21.s, z21.s, #-86
//CHECK: smin    z21.s, z21.s, #-86
ld1d    {z21.d}, p5/z, [x10, x21, lsl #3]
//CHECK: ld1d    {z21.d}, p5/z, [x10, x21, lsl #3]
umulh   z0.h, p0/m, z0.h, z0.h
//CHECK: umulh   z0.h, p0/m, z0.h, z0.h
ld1d    {z31.d}, p7/z, [sp, z31.d, lsl #3]
//CHECK: ld1d    {z31.d}, p7/z, [sp, z31.d, lsl #3]
ld3w    {z0.s, z1.s, z2.s}, p0/z, [x0, x0, lsl #2]
//CHECK: ld3w    {z0.s, z1.s, z2.s}, p0/z, [x0, x0, lsl #2]
ld1sh   {z23.d}, p3/z, [x13, x8, lsl #1]
//CHECK: ld1sh   {z23.d}, p3/z, [x13, x8, lsl #1]
index   z21.b, #10, #-11
//CHECK: index   z21.b, #10, #-11
fmov    z0.d, p0/m, #2.0
//CHECK: fmov    z0.d, p0/m, #2.0
sqdech  x23, vl256, mul #9
//CHECK: sqdech  x23, vl256, mul #9
prfb    pldl3strm, p5, [z10.s, #21]
//CHECK: prfb    pldl3strm, p5, [z10.s, #21]
asrr    z23.b, p3/m, z23.b, z13.b
//CHECK: asrr    z23.b, p3/m, z23.b, z13.b
uzp2    p5.d, p10.d, p5.d
//CHECK: uzp2    p5.d, p10.d, p5.d
umulh   z23.d, p3/m, z23.d, z13.d
//CHECK: umulh   z23.d, p3/m, z23.d, z13.d
umaxv   h21, p5, z10.h
//CHECK: umaxv   h21, p5, z10.h
st3d    {z5.d, z6.d, z7.d}, p3, [x17, x16, lsl #3]
//CHECK: st3d    {z5.d, z6.d, z7.d}, p3, [x17, x16, lsl #3]
rev     z21.d, z10.d
//CHECK: rev     z21.d, z10.d
ldnt1w  {z23.s}, p3/z, [x13, #-8, mul vl]
//CHECK: ldnt1w  {z23.s}, p3/z, [x13, #-8, mul vl]
faddv   s23, p3, z13.s
//CHECK: faddv   s23, p3, z13.s
st3w    {z31.s, z0.s, z1.s}, p7, [sp, #-3, mul vl]
//CHECK: st3w    {z31.s, z0.s, z1.s}, p7, [sp, #-3, mul vl]
fmaxnm  z0.d, p0/m, z0.d, #0.0
//CHECK: fmaxnm  z0.d, p0/m, z0.d, #0.0
decw    x21, vl32, mul #6
//CHECK: decw    x21, vl32, mul #6
stnt1b  {z21.b}, p5, [x10, #5, mul vl]
//CHECK: stnt1b  {z21.b}, p5, [x10, #5, mul vl]
index   z23.d, #13, #8
//CHECK: index   z23.d, #13, #8
st1b    {z23.s}, p3, [x13, x8]
//CHECK: st1b    {z23.s}, p3, [x13, x8]
sqdecw  z23.s, vl256, mul #9
//CHECK: sqdecw  z23.s, vl256, mul #9
ld1sh   {z21.d}, p5/z, [x10, z21.d, sxtw #1]
//CHECK: ld1sh   {z21.d}, p5/z, [x10, z21.d, sxtw #1]
ldnt1b  {z0.b}, p0/z, [x0, x0]
//CHECK: ldnt1b  {z0.b}, p0/z, [x0, x0]
zip1    z31.b, z31.b, z31.b
//CHECK: zip1    z31.b, z31.b, z31.b
tbl     z31.h, {z31.h}, z31.h
//CHECK: tbl     z31.h, {z31.h}, z31.h
ld4d    {z31.d, z0.d, z1.d, z2.d}, p7/z, [sp, #-4, mul vl]
//CHECK: ld4d    {z31.d, z0.d, z1.d, z2.d}, p7/z, [sp, #-4, mul vl]
incp    xzr, p15.s
//CHECK: incp    xzr, p15.s
cmpgt   p0.b, p0/z, z0.b, #0
//CHECK: cmpgt   p0.b, p0/z, z0.b, #0
splice  z23.d, p3, z23.d, z13.d
//CHECK: splice  z23.d, p3, z23.d, z13.d
sub     z0.s, z0.s, #0
//CHECK: sub     z0.s, z0.s, #0
whilele p5.b, w10, w21
//CHECK: whilele p5.b, w10, w21
index   z0.b, w0, w0
//CHECK: index   z0.b, w0, w0
st4h    {z5.h, z6.h, z7.h, z8.h}, p3, [x17, x16, lsl #1]
//CHECK: st4h    {z5.h, z6.h, z7.h, z8.h}, p3, [x17, x16, lsl #1]
saddv   d23, p3, z13.b
//CHECK: saddv   d23, p3, z13.b
cmplt   p5.d, p5/z, z10.d, #-11
//CHECK: cmplt   p5.d, p5/z, z10.d, #-11
ldnf1d  {z0.d}, p0/z, [x0]
//CHECK: ldnf1d  {z0.d}, p0/z, [x0]
sqincd  z21.d, vl32, mul #6
//CHECK: sqincd  z21.d, vl32, mul #6
ld1w    {z23.s}, p3/z, [x13, z8.s, uxtw]
//CHECK: ld1w    {z23.s}, p3/z, [x13, z8.s, uxtw]
fexpa   z21.s, z10.s
//CHECK: fexpa   z21.s, z10.s
rev     z31.h, z31.h
//CHECK: rev     z31.h, z31.h
lasta   h21, p5, z10.h
//CHECK: lasta   h21, p5, z10.h
lasta   xzr, p7, z31.d
//CHECK: lasta   xzr, p7, z31.d
ldff1d  {z23.d}, p3/z, [x13, z8.d, uxtw]
//CHECK: ldff1d  {z23.d}, p3/z, [x13, z8.d, uxtw]
sqsub   z1.b, z1.b, #33
//CHECK: sqsub   z1.b, z1.b, #33
uqdecp  w23, p13.s
//CHECK: uqdecp  w23, p13.s
ucvtf   z31.h, p7/m, z31.s
//CHECK: ucvtf   z31.h, p7/m, z31.s
uqsub   z21.h, z21.h, #170
//CHECK: uqsub   z21.h, z21.h, #170
incd    x23, vl256, mul #9
//CHECK: incd    x23, vl256, mul #9
ld1d    {z21.d}, p5/z, [x10, z21.d, lsl #3]
//CHECK: ld1d    {z21.d}, p5/z, [x10, z21.d, lsl #3]
ldnt1w  {z31.s}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnt1w  {z31.s}, p7/z, [sp, #-1, mul vl]
sqdecp  xzr, p15.b
//CHECK: sqdecp  xzr, p15.b
ld1sb   {z23.s}, p3/z, [x13, z8.s, sxtw]
//CHECK: ld1sb   {z23.s}, p3/z, [x13, z8.s, sxtw]
cmpne   p0.b, p0/z, z0.b, z0.b
//CHECK: cmpne   p0.b, p0/z, z0.b, z0.b
insr    z23.h, w13
//CHECK: insr    z23.h, w13
lsl     z0.s, p0/m, z0.s, #0
//CHECK: lsl     z0.s, p0/m, z0.s, #0
mla     z0.d, p0/m, z0.d, z0.d
//CHECK: mla     z0.d, p0/m, z0.d, z0.d
clasta  s31, p7, s31, z31.s
//CHECK: clasta  s31, p7, s31, z31.s
uzp1    p0.d, p0.d, p0.d
//CHECK: uzp1    p0.d, p0.d, p0.d
sqsub   z21.h, z21.h, #170
//CHECK: sqsub   z21.h, z21.h, #170
fmsb    z31.h, p7/m, z31.h, z31.h
//CHECK: fmsb    z31.h, p7/m, z31.h, z31.h
ld1rb   {z31.b}, p7/z, [sp, #63]
//CHECK: ld1rb   {z31.b}, p7/z, [sp, #63]
uzp2    p15.b, p15.b, p15.b
//CHECK: uzp2    p15.b, p15.b, p15.b
st1h    {z23.d}, p3, [x13, z8.d]
//CHECK: st1h    {z23.d}, p3, [x13, z8.d]
prfh    #7, p3, [x13, x8, lsl #1]
//CHECK: prfh    #7, p3, [x13, x8, lsl #1]
ftssel  z23.s, z13.s, z8.s
//CHECK: ftssel  z23.s, z13.s, z8.s
smax    z21.s, z21.s, #-86
//CHECK: smax    z21.s, z21.s, #-86
cmpge   p7.b, p3/z, z13.b, #8
//CHECK: cmpge   p7.b, p3/z, z13.b, #8
asr     z21.s, z10.s, #11
//CHECK: asr     z21.s, z10.s, #11
frintn  z0.h, p0/m, z0.h
//CHECK: frintn  z0.h, p0/m, z0.h
incp    z21.d, p10
//CHECK: incp    z21.d, p10
sunpkhi z23.h, z13.b
//CHECK: sunpkhi z23.h, z13.b
fmulx   z21.s, p5/m, z21.s, z10.s
//CHECK: fmulx   z21.s, p5/m, z21.s, z10.s
uzp1    z21.d, z10.d, z21.d
//CHECK: uzp1    z21.d, z10.d, z21.d
bic     z23.d, p3/m, z23.d, z13.d
//CHECK: bic     z23.d, p3/m, z23.d, z13.d
st1h    {z0.h}, p0, [x0]
//CHECK: st1h    {z0.h}, p0, [x0]
clasta  w0, p0, w0, z0.s
//CHECK: clasta  w0, p0, w0, z0.s
uqsub   z21.b, z10.b, z21.b
//CHECK: uqsub   z21.b, z10.b, z21.b
trn2    z31.d, z31.d, z31.d
//CHECK: trn2    z31.d, z31.d, z31.d
sqincw  x23, w23, vl256, mul #9
//CHECK: sqincw  x23, w23, vl256, mul #9
mov     z31.b, p15/m, z31.b
//CHECK: mov     z31.b, p15/m, z31.b
st1h    {z5.h}, p3, [x17, x16, lsl #1]
//CHECK: st1h    {z5.h}, p3, [x17, x16, lsl #1]
ld1h    {z21.d}, p5/z, [x10, z21.d, sxtw #1]
//CHECK: ld1h    {z21.d}, p5/z, [x10, z21.d, sxtw #1]
fsub    z31.h, p7/m, z31.h, z31.h
//CHECK: fsub    z31.h, p7/m, z31.h, z31.h
mov     z0.h, p0/m, z0.h
//CHECK: mov     z0.h, p0/m, z0.h
cmpge   p15.h, p7/z, z31.h, #-1
//CHECK: cmpge   p15.h, p7/z, z31.h, #-1
st1h    {z21.d}, p5, [z10.d, #42]
//CHECK: st1h    {z21.d}, p5, [z10.d, #42]
fcmuo   p0.s, p0/z, z0.s, z0.s
//CHECK: fcmuo   p0.s, p0/z, z0.s, z0.s
prfd    #7, p3, [x13, z8.s, sxtw #3]
//CHECK: prfd    #7, p3, [x13, z8.s, sxtw #3]
pfirst  p5.b, p10, p5.b
//CHECK: pfirst  p5.b, p10, p5.b
bics    p15.b, p15/z, p15.b, p15.b
//CHECK: bics    p15.b, p15/z, p15.b, p15.b
fsub    z31.s, p7/m, z31.s, z31.s
//CHECK: fsub    z31.s, p7/m, z31.s, z31.s
cmphi   p15.s, p7/z, z31.s, #127
//CHECK: cmphi   p15.s, p7/z, z31.s, #127
uqdecd  z23.d, vl256, mul #9
//CHECK: uqdecd  z23.d, vl256, mul #9
fmaxv   h21, p5, z10.h
//CHECK: fmaxv   h21, p5, z10.h
zip1    z21.s, z10.s, z21.s
//CHECK: zip1    z21.s, z10.s, z21.s
fmsb    z0.s, p0/m, z0.s, z0.s
//CHECK: fmsb    z0.s, p0/m, z0.s, z0.s
ld2d    {z21.d, z22.d}, p5/z, [x10, x21, lsl #3]
//CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, x21, lsl #3]
fdiv    z0.h, p0/m, z0.h, z0.h
//CHECK: fdiv    z0.h, p0/m, z0.h, z0.h
ldff1h  {z0.d}, p0/z, [x0, z0.d]
//CHECK: ldff1h  {z0.d}, p0/z, [x0, z0.d]
st1w    {z0.s}, p0, [x0]
//CHECK: st1w    {z0.s}, p0, [x0]
fmul    z23.s, p3/m, z23.s, #2.0
//CHECK: fmul    z23.s, p3/m, z23.s, #2.0
sqincd  x21, w21, vl32, mul #6
//CHECK: sqincd  x21, w21, vl32, mul #6
fmad    z23.d, p3/m, z13.d, z8.d
//CHECK: fmad    z23.d, p3/m, z13.d, z8.d
st1b    {z23.d}, p3, [x13, z8.d, sxtw]
//CHECK: st1b    {z23.d}, p3, [x13, z8.d, sxtw]
incp    z0.s, p0
//CHECK: incp    z0.s, p0
fcmeq   p15.s, p7/z, z31.s, #0.0
//CHECK: fcmeq   p15.s, p7/z, z31.s, #0.0
fcmla   z23.h, z13.h, z0.h[1], #270
//CHECK: fcmla   z23.h, z13.h, z0.h[1], #270
ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw #1]
//CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, sxtw #1]
ldnt1h  {z0.h}, p0/z, [x0, x0, lsl #1]
//CHECK: ldnt1h  {z0.h}, p0/z, [x0, x0, lsl #1]
st1h    {z21.s}, p5, [x10, z21.s, uxtw #1]
//CHECK: st1h    {z21.s}, p5, [x10, z21.s, uxtw #1]
asr     z23.h, p3/m, z23.h, z13.h
//CHECK: asr     z23.h, p3/m, z23.h, z13.h
fcvtzu  z21.d, p5/m, z10.d
//CHECK: fcvtzu  z21.d, p5/m, z10.d
ld1sw   {z21.d}, p5/z, [x10, z21.d, uxtw #2]
//CHECK: ld1sw   {z21.d}, p5/z, [x10, z21.d, uxtw #2]
eorv    b31, p7, z31.b
//CHECK: eorv    b31, p7, z31.b
st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, x8, lsl #2]
//CHECK: st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, x8, lsl #2]
ld1sh   {z0.d}, p0/z, [x0]
//CHECK: ld1sh   {z0.d}, p0/z, [x0]
sqdecw  xzr, all, mul #16
//CHECK: sqdecw  xzr, all, mul #16
sunpklo z23.d, z13.s
//CHECK: sunpklo z23.d, z13.s
sqsub   z0.s, z0.s, z0.s
//CHECK: sqsub   z0.s, z0.s, z0.s
bic     z31.h, p7/m, z31.h, z31.h
//CHECK: bic     z31.h, p7/m, z31.h, z31.h
andv    d23, p3, z13.d
//CHECK: andv    d23, p3, z13.d
lsl     z21.d, p5/m, z21.d, #42
//CHECK: lsl     z21.d, p5/m, z21.d, #42
fabd    z23.h, p3/m, z23.h, z13.h
//CHECK: fabd    z23.h, p3/m, z23.h, z13.h
ldff1w  {z23.s}, p3/z, [x13, z8.s, uxtw #2]
//CHECK: ldff1w  {z23.s}, p3/z, [x13, z8.s, uxtw #2]
umaxv   h0, p0, z0.h
//CHECK: umaxv   h0, p0, z0.h
ldff1sb {z0.s}, p0/z, [x0, x0]
//CHECK: ldff1sb {z0.s}, p0/z, [x0, x0]
asr     z0.s, p0/m, z0.s, z0.d
//CHECK: asr     z0.s, p0/m, z0.s, z0.d
ldff1h  {z21.d}, p5/z, [x10, z21.d, sxtw #1]
//CHECK: ldff1h  {z21.d}, p5/z, [x10, z21.d, sxtw #1]
fcvt    z23.s, p3/m, z13.d
//CHECK: fcvt    z23.s, p3/m, z13.d
ldff1sb {z31.s}, p7/z, [z31.s, #31]
//CHECK: ldff1sb {z31.s}, p7/z, [z31.s, #31]
ld2h    {z21.h, z22.h}, p5/z, [x10, x21, lsl #1]
//CHECK: ld2h    {z21.h, z22.h}, p5/z, [x10, x21, lsl #1]
umaxv   b21, p5, z10.b
//CHECK: umaxv   b21, p5, z10.b
nots    p5.b, p5/z, p10.b
//CHECK: nots    p5.b, p5/z, p10.b
ldff1sw {z21.d}, p5/z, [x10, z21.d]
//CHECK: ldff1sw {z21.d}, p5/z, [x10, z21.d]
sdivr   z31.d, p7/m, z31.d, z31.d
//CHECK: sdivr   z31.d, p7/m, z31.d, z31.d
whilels p7.b, w13, w8
//CHECK: whilels p7.b, w13, w8
cmpls   p7.b, p3/z, z13.b, z8.d
//CHECK: cmpls   p7.b, p3/z, z13.b, z8.d
smax    z23.h, z23.h, #109
//CHECK: smax    z23.h, z23.h, #109
fcmle   p0.d, p0/z, z0.d, #0.0
//CHECK: fcmle   p0.d, p0/z, z0.d, #0.0
uqdecp  z21.s, p10
//CHECK: uqdecp  z21.s, p10
lsr     z21.h, p5/m, z21.h, z10.d
//CHECK: lsr     z21.h, p5/m, z21.h, z10.d
ld4b    {z31.b, z0.b, z1.b, z2.b}, p7/z, [sp, #-4, mul vl]
//CHECK: ld4b    {z31.b, z0.b, z1.b, z2.b}, p7/z, [sp, #-4, mul vl]
whilels p0.s, x0, x0
//CHECK: whilels p0.s, x0, x0
uqincw  wzr, all, mul #16
//CHECK: uqincw  wzr, all, mul #16
decp    z0.d, p0
//CHECK: decp    z0.d, p0
umin    z31.h, p7/m, z31.h, z31.h
//CHECK: umin    z31.h, p7/m, z31.h, z31.h
fnmad   z23.s, p3/m, z13.s, z8.s
//CHECK: fnmad   z23.s, p3/m, z13.s, z8.s
rev     z23.h, z13.h
//CHECK: rev     z23.h, z13.h
clz     z21.h, p5/m, z10.h
//CHECK: clz     z21.h, p5/m, z10.h
sqinch  x0, pow2
//CHECK: sqinch  x0, pow2
sub     z0.b, p0/m, z0.b, z0.b
//CHECK: sub     z0.b, p0/m, z0.b, z0.b
uzp2    p7.d, p13.d, p8.d
//CHECK: uzp2    p7.d, p13.d, p8.d
mov     z23.d, x13
//CHECK: mov     z23.d, x13
st1h    {z31.h}, p7, [sp, #-1, mul vl]
//CHECK: st1h    {z31.h}, p7, [sp, #-1, mul vl]
uqsub   z31.s, z31.s, #255, lsl #8
//CHECK: uqsub   z31.s, z31.s, #65280
ptrue   p5.h, vl32
//CHECK: ptrue   p5.h, vl32
prfw    #15, p7, [z31.s, #124]
//CHECK: prfw    #15, p7, [z31.s, #124]
fsub    z23.h, p3/m, z23.h, #1.0
//CHECK: fsub    z23.h, p3/m, z23.h, #1.0
st1b    {z0.b}, p0, [x0]
//CHECK: st1b    {z0.b}, p0, [x0]
ldnf1sw {z31.d}, p7/z, [sp, #-1, mul vl]
//CHECK: ldnf1sw {z31.d}, p7/z, [sp, #-1, mul vl]
frintx  z23.s, p3/m, z13.s
//CHECK: frintx  z23.s, p3/m, z13.s
udivr   z23.d, p3/m, z23.d, z13.d
//CHECK: udivr   z23.d, p3/m, z23.d, z13.d
clz     z31.b, p7/m, z31.b
//CHECK: clz     z31.b, p7/m, z31.b
pfalse  p15.b
//CHECK: pfalse  p15.b
fmin    z23.s, p3/m, z23.s, #1.0
//CHECK: fmin    z23.s, p3/m, z23.s, #1.0
fcadd   z0.s, p0/m, z0.s, z0.s, #90
//CHECK: fcadd   z0.s, p0/m, z0.s, z0.s, #90
add     z23.s, z13.s, z8.s
//CHECK: add     z23.s, z13.s, z8.s
st2d    {z0.d, z1.d}, p0, [x0]
//CHECK: st2d    {z0.d, z1.d}, p0, [x0]
mls     z21.b, p5/m, z10.b, z21.b
//CHECK: mls     z21.b, p5/m, z10.b, z21.b
prfd    #15, p7, [z31.d, #248]
//CHECK: prfd    #15, p7, [z31.d, #248]
st4d    {z23.d, z24.d, z25.d, z26.d}, p3, [x13, x8, lsl #3]
//CHECK: st4d    {z23.d, z24.d, z25.d, z26.d}, p3, [x13, x8, lsl #3]
sunpkhi z0.s, z0.h
//CHECK: sunpkhi z0.s, z0.h
ldff1sw {z23.d}, p3/z, [x13, z8.d, lsl #2]
//CHECK: ldff1sw {z23.d}, p3/z, [x13, z8.d, lsl #2]
uqincb  xzr, all, mul #16
//CHECK: uqincb  xzr, all, mul #16
sdiv    z0.s, p0/m, z0.s, z0.s
//CHECK: sdiv    z0.s, p0/m, z0.s, z0.s
trn2    p7.s, p13.s, p8.s
//CHECK: trn2    p7.s, p13.s, p8.s
cmplt   p0.b, p0/z, z0.b, #0
//CHECK: cmplt   p0.b, p0/z, z0.b, #0
umaxv   b0, p0, z0.b
//CHECK: umaxv   b0, p0, z0.b
ld1b    {z0.d}, p0/z, [z0.d]
//CHECK: ld1b    {z0.d}, p0/z, [z0.d]
brkn    p15.b, p15/z, p15.b, p15.b
//CHECK: brkn    p15.b, p15/z, p15.b, p15.b
ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0]
//CHECK: ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0]
adr     z31.d, [z31.d, z31.d, sxtw #1]
//CHECK: adr     z31.d, [z31.d, z31.d, sxtw #1]
decp    z0.s, p0
//CHECK: decp    z0.s, p0
uunpkhi z31.d, z31.s
//CHECK: uunpkhi z31.d, z31.s
fadd    z31.h, z31.h, z31.h
//CHECK: fadd    z31.h, z31.h, z31.h
clasta  z0.h, p0, z0.h, z0.h
//CHECK: clasta  z0.h, p0, z0.h, z0.h
prfb    pldl3strm, p5, [z10.d, #21]
//CHECK: prfb    pldl3strm, p5, [z10.d, #21]
mov     z0.b, p0/m, #0
//CHECK: mov     z0.b, p0/m, #0
mov     z23.b, p3/m, b13
//CHECK: mov     z23.b, p3/m, b13
ld1sb   {z21.h}, p5/z, [x10, #5, mul vl]
//CHECK: ld1sb   {z21.h}, p5/z, [x10, #5, mul vl]
add     z0.b, z0.b, #0
//CHECK: add     z0.b, z0.b, #0
st3b    {z21.b, z22.b, z23.b}, p5, [x10, x21]
//CHECK: st3b    {z21.b, z22.b, z23.b}, p5, [x10, x21]
fmul    z23.s, z13.s, z0.s[1]
//CHECK: fmul    z23.s, z13.s, z0.s[1]
fdiv    z0.s, p0/m, z0.s, z0.s
//CHECK: fdiv    z0.s, p0/m, z0.s, z0.s
cmpgt   p0.b, p0/z, z0.b, z0.d
//CHECK: cmpgt   p0.b, p0/z, z0.b, z0.d
smin    z23.b, z23.b, #109
//CHECK: smin    z23.b, z23.b, #109
st1h    {z0.s}, p0, [x0, z0.s, uxtw #1]
//CHECK: st1h    {z0.s}, p0, [x0, z0.s, uxtw #1]
cmpls   p0.b, p0/z, z0.b, z0.d
//CHECK: cmpls   p0.b, p0/z, z0.b, z0.d
prfw    #7, p3, [x13, z8.d, lsl #2]
//CHECK: prfw    #7, p3, [x13, z8.d, lsl #2]
compact z31.d, p7, z31.d
//CHECK: compact z31.d, p7, z31.d
sqdecw  z0.s, pow2
//CHECK: sqdecw  z0.s, pow2
fsub    z23.d, p3/m, z23.d, z13.d
//CHECK: fsub    z23.d, p3/m, z23.d, z13.d
ldff1sh {z23.d}, p3/z, [x13, z8.d, lsl #1]
//CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, lsl #1]
sdiv    z0.d, p0/m, z0.d, z0.d
//CHECK: sdiv    z0.d, p0/m, z0.d, z0.d
trn1    p7.s, p13.s, p8.s
//CHECK: trn1    p7.s, p13.s, p8.s
bics    p7.b, p11/z, p13.b, p8.b
//CHECK: bics    p7.b, p11/z, p13.b, p8.b
uqdecd  xzr, all, mul #16
//CHECK: uqdecd  xzr, all, mul #16
st3h    {z23.h, z24.h, z25.h}, p3, [x13, #-24, mul vl]
//CHECK: st3h    {z23.h, z24.h, z25.h}, p3, [x13, #-24, mul vl]
uabd    z21.b, p5/m, z21.b, z10.b
//CHECK: uabd    z21.b, p5/m, z21.b, z10.b
sqdecp  x21, p10.d, w21
//CHECK: sqdecp  x21, p10.d, w21
ld2h    {z0.h, z1.h}, p0/z, [x0]
//CHECK: ld2h    {z0.h, z1.h}, p0/z, [x0]
sminv   h31, p7, z31.h
//CHECK: sminv   h31, p7, z31.h
uqdecd  z0.d, pow2
//CHECK: uqdecd  z0.d, pow2
ldff1b  {z0.d}, p0/z, [x0, z0.d, sxtw]
//CHECK: ldff1b  {z0.d}, p0/z, [x0, z0.d, sxtw]
umax    z31.s, z31.s, #255
//CHECK: umax    z31.s, z31.s, #255
ld2b    {z23.b, z24.b}, p3/z, [x13, #-16, mul vl]
//CHECK: ld2b    {z23.b, z24.b}, p3/z, [x13, #-16, mul vl]
sub     z0.s, p0/m, z0.s, z0.s
//CHECK: sub     z0.s, p0/m, z0.s, z0.s
mov     z0.d, z0.d
//CHECK: mov     z0.d, z0.d
sqdecp  xzr, p15.h, wzr
//CHECK: sqdecp  xzr, p15.h, wzr
fnmla   z23.h, p3/m, z13.h, z8.h
//CHECK: fnmla   z23.h, p3/m, z13.h, z8.h
lsl     z21.s, z10.s, #21
//CHECK: lsl     z21.s, z10.s, #21
fmul    z21.d, z10.d, z21.d
//CHECK: fmul    z21.d, z10.d, z21.d
uqdecp  w0, p0.s
//CHECK: uqdecp  w0, p0.s
sub     z21.h, p5/m, z21.h, z10.h
//CHECK: sub     z21.h, p5/m, z21.h, z10.h
sub     z23.b, p3/m, z23.b, z13.b
//CHECK: sub     z23.b, p3/m, z23.b, z13.b
ptrue   p7.d, vl256
//CHECK: ptrue   p7.d, vl256
and     z21.b, p5/m, z21.b, z10.b
//CHECK: and     z21.b, p5/m, z21.b, z10.b
ldff1sb {z23.s}, p3/z, [z13.s, #8]
//CHECK: ldff1sb {z23.s}, p3/z, [z13.s, #8]
brkbs   p5.b, p5/z, p10.b
//CHECK: brkbs   p5.b, p5/z, p10.b
nands   p15.b, p15/z, p15.b, p15.b
//CHECK: nands   p15.b, p15/z, p15.b, p15.b
st1w    {z31.d}, p7, [sp, #-1, mul vl]
//CHECK: st1w    {z31.d}, p7, [sp, #-1, mul vl]
sqinch  z23.h, vl256, mul #9
//CHECK: sqinch  z23.h, vl256, mul #9
fmla    z23.h, p3/m, z13.h, z8.h
//CHECK: fmla    z23.h, p3/m, z13.h, z8.h
frsqrte z21.h, z10.h
//CHECK: frsqrte z21.h, z10.h
ctermeq x10, x21
//CHECK: ctermeq x10, x21
revb    z21.h, p5/m, z10.h
//CHECK: revb    z21.h, p5/m, z10.h
uqadd   z21.d, z10.d, z21.d
//CHECK: uqadd   z21.d, z10.d, z21.d
st2w    {z5.s, z6.s}, p3, [x17, x16, lsl #2]
//CHECK: st2w    {z5.s, z6.s}, p3, [x17, x16, lsl #2]
fscale  z23.d, p3/m, z23.d, z13.d
//CHECK: fscale  z23.d, p3/m, z23.d, z13.d
sqinch  x23, vl256, mul #9
//CHECK: sqinch  x23, vl256, mul #9
frinta  z23.d, p3/m, z13.d
//CHECK: frinta  z23.d, p3/m, z13.d
uaddv   d31, p7, z31.s
//CHECK: uaddv   d31, p7, z31.s
frecps  z21.d, z10.d, z21.d
//CHECK: frecps  z21.d, z10.d, z21.d
cls     z23.b, p3/m, z13.b
//CHECK: cls     z23.b, p3/m, z13.b
str     z0, [x0]
//CHECK: str     z0, [x0]
adr     z0.d, [z0.d, z0.d, sxtw]
//CHECK: adr     z0.d, [z0.d, z0.d, sxtw]
brkpbs  p7.b, p11/z, p13.b, p8.b
//CHECK: brkpbs  p7.b, p11/z, p13.b, p8.b
st3h    {z21.h, z22.h, z23.h}, p5, [x10, x21, lsl #1]
//CHECK: st3h    {z21.h, z22.h, z23.h}, p5, [x10, x21, lsl #1]
fmul    z0.d, z0.d, z0.d
//CHECK: fmul    z0.d, z0.d, z0.d
trn1    p15.d, p15.d, p15.d
//CHECK: trn1    p15.d, p15.d, p15.d
clz     z31.h, p7/m, z31.h
//CHECK: clz     z31.h, p7/m, z31.h
ldff1w  {z31.d}, p7/z, [sp, xzr, lsl #2]
//CHECK: ldff1w  {z31.d}, p7/z, [sp]
umulh   z31.h, p7/m, z31.h, z31.h
//CHECK: umulh   z31.h, p7/m, z31.h, z31.h
cmphi   p5.s, p5/z, z10.s, #85
//CHECK: cmphi   p5.s, p5/z, z10.s, #85
mul     z0.b, p0/m, z0.b, z0.b
//CHECK: mul     z0.b, p0/m, z0.b, z0.b
