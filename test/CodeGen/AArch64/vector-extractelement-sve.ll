; RUN: llc < %s -mtriple=aarch64--linux-gnu -mattr=+sve | FileCheck %s

define i8 @extract_nxv16i8_imm(<n x 16 x i8> *%vp1, <n x 16 x i8> *%vp2) {
; CHECK-LABEL: extract_nxv16i8_imm:
  %v1 = load <n x 16 x i8> , <n x 16 x i8> *%vp1
  %v2 = load <n x 16 x i8> , <n x 16 x i8> *%vp2
  %v = add <n x 16 x i8> %v1, %v2
; CHECK: add z[[VREG:[0-9]+]].b, z{{[0-9]+}}.b, z{{[0-9]+}}.b
  %res0 = extractelement <n x 16 x i8> %v, i32 0
; CHECK-DAG: mov z[[VREG0:[0-9]+]].b, b0
; CHECK-DAG: fmov w[[REG0:[0-9]+]], s[[VREG0]]
  %res1 = extractelement <n x 16 x i8> %v, i32 1
; CHECK-DAG: mov z[[VREG1:[0-9]+]].b, z[[VREG]].b[1]
; CHECK-DAG: fmov w[[REG1:[0-9]+]], s[[VREG1]]
  %res2 = extractelement <n x 16 x i8> %v, i32 2
; CHECK-DAG: mov z[[VREG2:[0-9]+]].b, z[[VREG]].b[2]
; CHECK-DAG: fmov w[[REG2:[0-9]+]], s[[VREG2]]
  %res3 = extractelement <n x 16 x i8> %v, i32 3
; CHECK-DAG: mov z[[VREG3:[0-9]+]].b, z[[VREG]].b[3]
; CHECK-DAG: fmov w[[REG3:[0-9]+]], s[[VREG3]]
  %res01 = sub i8 %res0, %res1
; CHECK: sub w{{[0-9]+}}, w[[REG0]], w[[REG1]]
  %res23 = sub i8 %res2, %res3
; CHECK: sub w{{[0-9]+}}, w[[REG2]], w[[REG3]]
  %res = add i8 %res01, %res23
  ret i8 %res
}

define i16 @extract_nxv8i16_imm(<n x 8 x i16> *%vp1, <n x 8 x i16> *%vp2) {
; CHECK-LABEL: extract_nxv8i16_imm:
  %v1 = load <n x 8 x i16> , <n x 8 x i16> *%vp1
  %v2 = load <n x 8 x i16> , <n x 8 x i16> *%vp2
  %v = add <n x 8 x i16> %v1, %v2
; CHECK: add z[[VREG:[0-9]+]].h, z{{[0-9]+}}.h, z{{[0-9]+}}.h
  %res0 = extractelement <n x 8 x i16> %v, i32 0
; CHECK-DAG: mov z[[VREG0:[0-9]+]].h, h0
; CHECK-DAG: fmov w[[REG0:[0-9]+]], s[[VREG0]]
  %res1 = extractelement <n x 8 x i16> %v, i32 1
; CHECK-DAG: mov z[[VREG1:[0-9]+]].h, z[[VREG]].h[1]
; CHECK-DAG: fmov w[[REG1:[0-9]+]], s[[VREG1]]
  %res2 = extractelement <n x 8 x i16> %v, i32 2
; CHECK-DAG: mov z[[VREG2:[0-9]+]].h, z[[VREG]].h[2]
; CHECK-DAG: fmov w[[REG2:[0-9]+]], s[[VREG2]]
  %res3 = extractelement <n x 8 x i16> %v, i32 3
; CHECK-DAG: mov z[[VREG3:[0-9]+]].h, z[[VREG]].h[3]
; CHECK-DAG: fmov w[[REG3:[0-9]+]], s[[VREG3]]
  %res01 = sub i16 %res0, %res1
; CHECK: sub w{{[0-9]+}}, w[[REG0]], w[[REG1]]
  %res23 = sub i16 %res2, %res3
; CHECK: sub w{{[0-9]+}}, w[[REG2]], w[[REG3]]
  %res = add i16 %res01, %res23
  ret i16 %res
}

define i32 @extract_nxv4i32_imm(<n x 4 x i32> *%vp1, <n x 4 x i32> *%vp2) {
; CHECK-LABEL: extract_nxv4i32_imm:
  %v1 = load <n x 4 x i32> , <n x 4 x i32> *%vp1
  %v2 = load <n x 4 x i32> , <n x 4 x i32> *%vp2
  %v = add <n x 4 x i32> %v1, %v2
; CHECK: add z[[VREG:[0-9]+]].s, z{{[0-9]+}}.s, z{{[0-9]+}}.s
  %res0 = extractelement <n x 4 x i32> %v, i32 0
; CHECK-DAG: fmov w[[REG0:[0-9]+]], s[[VREG]]
  %res1 = extractelement <n x 4 x i32> %v, i32 1
; CHECK-DAG: mov z[[VREG1:[0-9]+]].s, z[[VREG]].s[1]
; CHECK-DAG: fmov w[[REG1:[0-9]+]], s[[VREG1]]
  %res2 = extractelement <n x 4 x i32> %v, i32 2
; CHECK-DAG: mov z[[VREG2:[0-9]+]].s, z[[VREG]].s[2]
; CHECK-DAG: fmov w[[REG2:[0-9]+]], s[[VREG2]]
  %res3 = extractelement <n x 4 x i32> %v, i32 3
; CHECK-DAG: mov z[[VREG3:[0-9]+]].s, z[[VREG]].s[3]
; CHECK-DAG: fmov w[[REG3:[0-9]+]], s[[VREG3]]
  %res01 = sub i32 %res0, %res1
; CHECK: sub w{{[0-9]+}}, w[[REG0]], w[[REG1]]
  %res23 = sub i32 %res2, %res3
; CHECK: sub w{{[0-9]+}}, w[[REG2]], w[[REG3]]
  %res = add i32 %res01, %res23
  ret i32 %res
}

define i64 @extract_nxv2i64_imm(<n x 2 x i64> *%vp1, <n x 2 x i64> *%vp2) {
; CHECK-LABEL: extract_nxv2i64_imm:
  %v1 = load <n x 2 x i64> , <n x 2 x i64> *%vp1
  %v2 = load <n x 2 x i64> , <n x 2 x i64> *%vp2
  %v = add <n x 2 x i64> %v1, %v2
; CHECK: add z[[VREG:[0-9]+]].d, z{{[0-9]+}}.d, z{{[0-9]+}}.d
  %res0 = extractelement <n x 2 x i64> %v, i32 0
; CHECK-DAG: fmov x[[REG0:[0-9]+]], d[[VREG]]
  %res1 = extractelement <n x 2 x i64> %v, i32 1
; CHECK-DAG: mov z[[VREG1:[0-9]+]].d, z[[VREG]].d[1]
; CHECK-DAG: fmov x[[REG1:[0-9]+]], d[[VREG1]]
  %res = sub i64 %res0, %res1
; CHECK: sub x{{[0-9]+}}, x[[REG0]], x[[REG1]]
  ret i64 %res
}

define float @extract_nxv4f32_imm(<n x 4 x float> *%vp1, <n x 4 x float> *%vp2) {
; CHECK-LABEL: extract_nxv4f32_imm:
  %v1 = load <n x 4 x float> , <n x 4 x float> *%vp1
  %v2 = load <n x 4 x float> , <n x 4 x float> *%vp2
  %v = fadd <n x 4 x float> %v1, %v2
; CHECK: fadd z[[VREG:[0-9]+]].s, z{{[0-9]+}}.s, z{{[0-9]+}}.s
  %res0 = extractelement <n x 4 x float> %v, i32 0
; nop
  %res1 = extractelement <n x 4 x float> %v, i32 1
; CHECK-DAG: mov z[[VREG1:[0-9]+]].s, z[[VREG]].s[1]
  %res2 = extractelement <n x 4 x float> %v, i32 2
; CHECK-DAG: mov z[[VREG2:[0-9]+]].s, z[[VREG]].s[2]
  %res3 = extractelement <n x 4 x float> %v, i32 3
; CHECK-DAG: mov z[[VREG3:[0-9]+]].s, z[[VREG]].s[3]
  %res01 = fsub float %res0, %res1
; CHECK: fsub s{{[0-9]+}}, s[[VREG]], s[[VREG1]]
  %res23 = fsub float %res2, %res3
; CHECK: fsub s{{[0-9]+}}, s[[VREG2]], s[[VREG3]]
  %res = fadd float %res01, %res23
  ret float %res
}

define double @extract_nxv2f64_imm(<n x 2 x double> *%vp1, <n x 2 x double> *%vp2) {
; CHECK-LABEL: extract_nxv2f64_imm:
  %v1 = load <n x 2 x double> , <n x 2 x double> *%vp1
  %v2 = load <n x 2 x double> , <n x 2 x double> *%vp2
  %v = fadd <n x 2 x double> %v1, %v2
; CHECK: fadd z[[VREG:[0-9]+]].d, z{{[0-9]+}}.d, z{{[0-9]+}}.d
  %res0 = extractelement <n x 2 x double> %v, i32 0
; nop
  %res1 = extractelement <n x 2 x double> %v, i32 1
; CHECK-DAG: mov z[[VREG1:[0-9]+]].d, z[[VREG]].d[1]
  %res = fsub double %res0, %res1
; CHECK: fsub d{{[0-9]+}}, d[[VREG]], d[[VREG1]]
  ret double %res
}

define i8 @extract_nxv16i8_scalar(<n x 16 x i8> *%vp1, <n x 16 x i8> *%vp2,
                                   i32 %index) {
; CHECK-LABEL: extract_nxv16i8_scalar:
  %v1 = load <n x 16 x i8> , <n x 16 x i8> *%vp1
  %v2 = load <n x 16 x i8> , <n x 16 x i8> *%vp2
  %v = add <n x 16 x i8> %v1, %v2
; CHECK-DAG: add [[VSRC:z[0-9]+.b]], {{z[0-9]+.b}}, {{z[0-9]+.b}}
  %res = extractelement <n x 16 x i8> %v, i32 %index
; CHECK-DAG: mov [[SPLAT:z[0-9]+.b]], {{w[0-9]+}}
; CHECK-DAG: index [[INDEX:z[0-9]+.b]], #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].b
; CHECK: cmpeq [[PRED:p[0-9]+]].b, [[TRUE]]/z, [[INDEX]], [[SPLAT]]
; CHECK: lastb w0, [[PRED]], [[VSRC]]
  ret i8 %res
}

define i16 @extract_nxv8i16_scalar(<n x 8 x i16> *%vp1, <n x 8 x i16> *%vp2,
                                   i32 %index) {
; CHECK-LABEL: extract_nxv8i16_scalar:
  %v1 = load <n x 8 x i16> , <n x 8 x i16> *%vp1
  %v2 = load <n x 8 x i16> , <n x 8 x i16> *%vp2
  %v = add <n x 8 x i16> %v1, %v2
; CHECK-DAG: add [[VSRC:z[0-9]+.h]], {{z[0-9]+.h}}, {{z[0-9]+.h}}
  %res = extractelement <n x 8 x i16> %v, i32 %index
; CHECK-DAG: mov [[SPLAT:z[0-9]+.h]], {{w[0-9]+}}
; CHECK-DAG: index [[INDEX:z[0-9]+.h]], #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].h
; CHECK: cmpeq [[PRED:p[0-9]+]].h, [[TRUE]]/z, [[INDEX]], [[SPLAT]]
; CHECK: lastb w0, [[PRED]], [[VSRC]]
  ret i16 %res
}

define i32 @extract_nxv4i32_scalar(<n x 4 x i32> *%vp1, <n x 4 x i32> *%vp2,
                                   i32 %index) {
; CHECK-LABEL: extract_nxv4i32_scalar:
  %v1 = load <n x 4 x i32> , <n x 4 x i32> *%vp1
  %v2 = load <n x 4 x i32> , <n x 4 x i32> *%vp2
  %v = add <n x 4 x i32> %v1, %v2
; CHECK-DAG: add [[VSRC:z[0-9]+.s]], {{z[0-9]+.s}}, {{z[0-9]+.s}}
  %res = extractelement <n x 4 x i32> %v, i32 %index
; CHECK-DAG: mov [[SPLAT:z[0-9]+.s]], {{w[0-9]+}}
; CHECK-DAG: index [[INDEX:z[0-9]+.s]], #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].s
; CHECK: cmpeq [[PRED:p[0-9]+]].s, [[TRUE]]/z, [[INDEX]], [[SPLAT]]
; CHECK: lastb w0, [[PRED]], [[VSRC]]
  ret i32 %res
}

define i64 @extract_nxv2i64_scalar(<n x 2 x i64> *%vp1, <n x 2 x i64> *%vp2,
                                   i64 %index) {
; CHECK-LABEL: extract_nxv2i64_scalar:
  %v1 = load <n x 2 x i64> , <n x 2 x i64> *%vp1
  %v2 = load <n x 2 x i64> , <n x 2 x i64> *%vp2
  %v = add <n x 2 x i64> %v1, %v2
; CHECK-DAG: add [[VSRC:z[0-9]+.d]], {{z[0-9]+.d}}, {{z[0-9]+.d}}
  %res = extractelement <n x 2 x i64> %v, i64 %index
; CHECK-DAG: mov [[SPLAT:z[0-9]+.d]], x2
; CHECK-DAG: index [[INDEX:z[0-9]+.d]], #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
; CHECK-DAG: cmpeq [[PRED:p[0-9]+]].d, [[TRUE]]/z, [[INDEX]], [[SPLAT]]
; CHECK: lastb x0, [[PRED]], [[VSRC]]
  ret i64 %res
}

define float @extract_nxv4f32_scalar(<n x 4 x float> *%vp1, <n x 4 x float> *%vp2,
                                     i32 %index) {
; CHECK-LABEL: extract_nxv4f32_scalar:
  %v1 = load <n x 4 x float> , <n x 4 x float> *%vp1
  %v2 = load <n x 4 x float> , <n x 4 x float> *%vp2
  %v = fadd <n x 4 x float> %v1, %v2
; CHECK-DAG: add [[VSRC:z[0-9]+.s]], {{z[0-9]+.s}}, {{z[0-9]+.s}}
  %res = extractelement <n x 4 x float> %v, i32 %index
; CHECK-DAG: mov [[SPLAT:z[0-9]+.s]], {{w[0-9]+}}
; CHECK-DAG: index [[INDEX:z[0-9]+.s]], #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].s
; CHECK: cmpeq [[PRED:p[0-9]+]].s, [[TRUE]]/z, [[INDEX]], [[SPLAT]]
; CHECK: lastb s0, [[PRED]], [[VSRC]]
  ret float %res
}

define double @extract_nxv2f64_scalar(<n x 2 x double> *%vp1, <n x 2 x double> *%vp2,
                                      i64 %index) {
; CHECK-LABEL: extract_nxv2f64_scalar:
  %v1 = load <n x 2 x double> , <n x 2 x double> *%vp1
  %v2 = load <n x 2 x double> , <n x 2 x double> *%vp2
  %v = fadd <n x 2 x double> %v1, %v2
; CHECK-DAG: add [[VSRC:z[0-9]+.d]], {{z[0-9]+.d}}, {{z[0-9]+.d}}
  %res = extractelement <n x 2 x double> %v, i64 %index
; CHECK-DAG: mov [[SPLAT:z[0-9]+.d]], x2
; CHECK-DAG: index [[INDEX:z[0-9]+.d]], #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
; CHECK-DAG: cmpeq [[PRED:p[0-9]+]].d, [[TRUE]]/z, [[INDEX]], [[SPLAT]]
; CHECK: lastb d0, [[PRED]], [[VSRC]]
  ret double %res
}

define float @extract_nxv2f32_scalar(<n x 2 x float> *%vp1, <n x 2 x float> *%vp2,
                                      i64 %index) {
; CHECK-LABEL: extract_nxv2f32_scalar:
  %v1 = load <n x 2 x float> , <n x 2 x float> *%vp1
  %v2 = load <n x 2 x float> , <n x 2 x float> *%vp2
  %v = fadd <n x 2 x float> %v1, %v2
; CHECK-DAG: add [[VSRC:z[0-9]+.s]], {{z[0-9]+.s}}, {{z[0-9]+.s}}
  %res = extractelement <n x 2 x float> %v, i64 %index
; CHECK-DAG: mov [[SPLAT:z[0-9]+.d]], x2
; CHECK-DAG: index [[INDEX:z[0-9]+.d]], #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
; CHECK-DAG: cmpeq [[PRED:p[0-9]+]].d, [[TRUE]]/z, [[INDEX]], [[SPLAT]]
; CHECK: lastb s0, [[PRED]], [[VSRC]]
  ret float %res
}

define i64 @extract_nxv4i64_scalar(<n x 4 x i64> %v1, <n x 4 x i64> %v2,
                                   i64 %index) {
; CHECK-LABEL: extract_nxv4i64_scalar:
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
; CHECK-DAG: mov [[IDXSPLAT:z[0-9]+]].d, x0
; CHECK-DAG: add   [[ADDLO:z[0-9]+]].d, z0.d, z2.d
; CHECK-DAG: add   [[ADDHI:z[0-9]+]].d, z1.d, z3.d
; CHECK-DAG: uzp1  [[EVEN:z[0-9]+]].s, [[ADDLO]].s, [[ADDHI]].s
; CHECK-DAG: uzp2  [[ODD:z[0-9]+]].s, [[ADDLO]].s, [[ADDHI]].s
; CHECK-DAG: index [[SEQLO:z[0-9]+]].d, #0, #1
; CHECK-DAG: cntd  [[EC:x[0-9]+]]
; CHECK-DAG: cmpeq [[PREDLO:p[0-9]+]].d, [[TRUE]]/z, [[SEQLO]].d, [[IDXSPLAT]].d
; CHECK: index [[SEQHI:z[0-9]+]].d, [[EC]], #1
; CHECK-DAG: cmpeq [[PREDHI:p[0-9]+]].d, [[TRUE]]/z, [[SEQHI]].d, [[IDXSPLAT]].d
; CHECK-DAG: uzp1  [[PRED:p[0-9]+]].s, [[PREDLO]].s, [[PREDHI]].s
; CHECK-DAG: lastb w[[RESHI:[0-9]+]], [[PRED]], [[ODD]].s
; CHECK-DAG: lastb w0, [[PRED]], [[EVEN]].s
; CHECK-DAG: bfi   x0, x[[RESHI]], #32, #32
; CHECK: ret
  %v = add <n x 4 x i64> %v1, %v2
  %res = extractelement <n x 4 x i64> %v, i64 %index
  ret i64 %res
}

; Note: This test only covers the number of lastb instructions which are
; required to lower the nxv8i64 type. The rest of the unzips/orr-ing is
; similar to nxv4i64.
define i64 @extract_nxv8i64_scalar(<n x 8 x i64> %v1, i64 %index) {
; CHECK-LABEL: extract_nxv8i64_scalar:
; CHECK: lastb
; CHECK: lastb
; CHECK: lastb
; CHECK: lastb
; CHECK-NOT: lastb
; CHECK: ret
  %res = extractelement <n x 8 x i64> %v1, i64 %index
  ret i64 %res
}

define double @extract_nxv4f64_scalar(<n x 4 x double> %v1, <n x 4 x double> %v2,
                                   i64 %index) {
; CHECK-LABEL: extract_nxv4f64_scalar:
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
; CHECK-DAG: mov [[IDXSPLAT:z[0-9]+]].d, x0
; CHECK-DAG: fadd   [[ADDLO:z[0-9]+]].d, z0.d, z2.d
; CHECK-DAG: fadd   [[ADDHI:z[0-9]+]].d, z1.d, z3.d
; CHECK-DAG: uzp1  [[EVEN:z[0-9]+]].s, [[ADDLO]].s, [[ADDHI]].s
; CHECK-DAG: uzp2  [[ODD:z[0-9]+]].s, [[ADDLO]].s, [[ADDHI]].s
; CHECK-DAG: index [[SEQLO:z[0-9]+]].d, #0, #1
; CHECK-DAG: cntd  [[EC:x[0-9]+]]
; CHECK-DAG: cmpeq [[PREDLO:p[0-9]+]].d, [[TRUE]]/z, [[SEQLO]].d, [[IDXSPLAT]].d
; CHECK: index [[SEQHI:z[0-9]+]].d, [[EC]], #1
; CHECK-DAG: cmpeq [[PREDHI:p[0-9]+]].d, [[TRUE]]/z, [[SEQHI]].d, [[IDXSPLAT]].d
; CHECK-DAG: uzp1  [[PRED:p[0-9]+]].s, [[PREDLO]].s, [[PREDHI]].s
; CHECK-DAG: lastb w[[RESHI:[0-9]+]], [[PRED]], [[ODD]].s
; CHECK-DAG: lastb w[[RESLO:[0-9]+]], [[PRED]], [[EVEN]].s
; CHECK-DAG: bfi   x[[RESLO]], x[[RESHI]], #32, #32
; CHECK-DAG: fmov  d0, x[[RESLO]]
; CHECK: ret
  %v = fadd <n x 4 x double> %v1, %v2
  %res = extractelement <n x 4 x double> %v, i64 %index
  ret double %res
}

; Note: This test only covers the number of lastb instructions which are
; required to lower the nxv8f64 type. The rest of the unzips/orr-ing is
; similar to nxv4f64.
define double @extract_nxv8f64_scalar(<n x 8 x double> %v1, <n x 8 x double> %v2,
                                   i64 %index) {
; CHECK-LABEL: extract_nxv8f64_scalar:
; CHECK: lastb
; CHECK: lastb
; CHECK: lastb
; CHECK: lastb
; CHECK-NOT: lastb
; CHECK: ret
  %v = fadd <n x 8 x double> %v1, %v2
  %res = extractelement <n x 8 x double> %v, i64 %index
  ret double %res
}

define float @extract_nxv8f32_scalar(<n x 8 x float> %v1, <n x 8 x float> %v2,
                                   i64 %index) {
; CHECK-LABEL: extract_nxv8f32_scalar:
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].s
; CHECK-DAG: mov [[IDXSPLAT:z[0-9]+]].s, w0
; CHECK-DAG: fadd  [[ADDLO:z[0-9]+]].s, z0.s, z2.s
; CHECK-DAG: fadd  [[ADDHI:z[0-9]+]].s, z1.s, z3.s
; CHECK-DAG: uzp1  [[EVEN:z[0-9]+]].h, [[ADDLO]].h, [[ADDHI]].h
; CHECK-DAG: uzp2  [[ODD:z[0-9]+]].h, [[ADDLO]].h, [[ADDHI]].h
; CHECK-DAG: index [[SEQLO:z[0-9]+]].s, #0, #1
; CHECK-DAG: cntw  x[[EC:[0-9]+]]
; CHECK-DAG: cmpeq [[PREDLO:p[0-9]+]].s, [[TRUE]]/z, [[SEQLO]].s, [[IDXSPLAT]].s
; CHECK: index [[SEQHI:z[0-9]+]].s, w[[EC]], #1
; CHECK-DAG: cmpeq [[PREDHI:p[0-9]+]].s, [[TRUE]]/z, [[SEQHI]].s, [[IDXSPLAT]].s
; CHECK-DAG: uzp1  [[PRED:p[0-9]+]].h, [[PREDLO]].h, [[PREDHI]].h
; CHECK-DAG: lastb w[[RESHI:[0-9]+]], [[PRED]], [[ODD]].h
; CHECK-DAG: lastb w[[RESLO:[0-9]+]], [[PRED]], [[EVEN]].h
; CHECK-DAG: orr   w[[RES:[0-9]+]], w[[RESLO]], w[[RESHI]], lsl #16
; CHECK-DAG: fmov  s0, w[[RES]]
  %v = fadd <n x 8 x float> %v1, %v2
  %res = extractelement <n x 8 x float> %v, i64 %index
  ret float %res
}

; CHECK-LABEL: extract_nxv2i1_scalar:
; CHECK-DAG: mov   [[SPLAT:z[0-9]+]].d, x0
; CHECK-DAG: index [[SEQ:z[0-9]+]].d, #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
; CHECK-DAG: cmpeq [[MASK:p[0-9]+]].d, [[TRUE]]/z, [[SEQ]].d, [[SPLAT]].d
; CHECK-DAG: mov   [[EXT:z[0-9]+]].d, p0/z, #1
; CHECK-DAG: lastb x[[LAST:[0-9]+]], [[MASK]], [[EXT]].d
; CHECK: ret
define i1 @extract_nxv2i1_scalar(<n x 2 x i1> %pred, i64 %index) {
  %p = extractelement <n x 2 x i1> %pred, i64 %index
  ret i1 %p
}

; CHECK-LABEL: extract_nxv4i1_scalar:
; CHECK-DAG: mov   [[SPLAT:z[0-9]+]].s, w0
; CHECK-DAG: index [[SEQ:z[0-9]+]].s, #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].s
; CHECK-DAG: cmpeq [[MASK:p[0-9]+]].s, [[TRUE]]/z, [[SEQ]].s, [[SPLAT]].s
; CHECK-DAG: mov   [[EXT:z[0-9]+]].s, p0/z, #1
; CHECK-DAG: lastb [[LAST:w[0-9]+]], [[MASK]], [[EXT]].s
; CHECK: ret
define i1 @extract_nxv4i1_scalar(<n x 4 x i1> %pred, i64 %index) {
  %p = extractelement <n x 4 x i1> %pred, i64 %index
  ret i1 %p
}

; CHECK-LABEL: extract_nxv8i1_scalar:
; CHECK-DAG: mov   [[SPLAT:z[0-9]+]].h, w0
; CHECK-DAG: index [[SEQ:z[0-9]+]].h, #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].h
; CHECK-DAG: cmpeq [[MASK:p[0-9]+]].h, [[TRUE]]/z, [[SEQ]].h, [[SPLAT]].h
; CHECK-DAG: mov   [[EXT:z[0-9]+]].h, p0/z, #1
; CHECK-DAG: lastb [[LAST:w[0-9]+]], [[MASK]], [[EXT]].h
; CHECK-DAG: and   [[RES:w[0-9]+]], [[LAST]], #0x1
; CHECK: ret
define i1 @extract_nxv8i1_scalar(<n x 8 x i1> %pred, i64 %index) {
  %p = extractelement <n x 8 x i1> %pred, i64 %index
  ret i1 %p
}

; CHECK-LABEL: extract_nxv16i1_scalar:
; CHECK-DAG: mov   [[SPLAT:z[0-9]+]].b, w0
; CHECK-DAG: index [[SEQ:z[0-9]+]].b, #0, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].b
; CHECK-DAG: cmpeq [[MASK:p[0-9]+]].b, [[TRUE]]/z, [[SEQ]].b, [[SPLAT]].b
; CHECK-DAG: mov   [[EXT:z[0-9]+]].b, p0/z, #1
; CHECK-DAG: lastb [[LAST:w[0-9]+]], [[MASK]], [[EXT]].b
; CHECK-DAG: and   [[RES:w[0-9]+]], [[LAST]], #0x1
; CHECK: ret
define i1 @extract_nxv16i1_scalar(<n x 16 x i1> %pred, i64 %index) {
  %p = extractelement <n x 16 x i1> %pred, i64 %index
  ret i1 %p
}
