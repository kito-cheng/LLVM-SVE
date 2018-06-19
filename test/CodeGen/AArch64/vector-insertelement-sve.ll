; RUN: llc < %s -mtriple=aarch64--linux-gnu -mattr=+sve -asm-verbose=0 | FileCheck %s

define void @insert_nxv16i8_gpr(<n x 16 x i8> *%vp1, <n x 16 x i8> *%vp2, i8 %val, i32 %index) {
; CHECK-LABEL: insert_nxv16i8_gpr:
; CHECK: ptrue [[TRUE:p[0-9]+]].b
  %v1 = load <n x 16 x i8> , <n x 16 x i8> *%vp1
; CHECK: ld1b {[[LOAD1:z[0-9]+]].b}, {{p[0-9]+}}/z, [x0]
  %v2 = load <n x 16 x i8> , <n x 16 x i8> *%vp2
; CHECK: ld1b {[[LOAD2:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
  %v = add <n x 16 x i8> %v1, %v2
; CHECK-DAG: add [[RES:z[0-9]+]].b, [[LOAD1]].b, [[LOAD2]].b
  %res = insertelement <n x 16 x i8> %v, i8 %val, i32 %index
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].b, #0, #1
; CHECK-DAG: mov [[SPLAT_INDEX:z[0-9]+]].b, {{w[0-9]+}}
; CHECK: cmpeq [[INDEX_PRED:p[0-9]+]].b, [[TRUE]]/z, [[ZERO_TO_N]].b, [[SPLAT_INDEX]].b
; CHECK: mov [[RES]].b, [[INDEX_PRED]]/m, w2
  store <n x 16 x i8> %res, <n x 16 x i8> *%vp1
; CHECK: st1b {[[RES]].b},
  ret void
}

define void @insert_nxv8i16_gpr(<n x 8 x i16> *%vp1, <n x 8 x i16> *%vp2, i16 %val, i32 %index) {
; CHECK-LABEL: insert_nxv8i16_gpr:
; CHECK: ptrue [[TRUE:p[0-9]+]].h
  %v1 = load <n x 8 x i16> , <n x 8 x i16> *%vp1
; CHECK: ld1h {[[LOAD1:z[0-9]+]].h}, {{p[0-9]+}}/z, [x0]
  %v2 = load <n x 8 x i16> , <n x 8 x i16> *%vp2
; CHECK: ld1h {[[LOAD2:z[0-9]+]].h}, {{p[0-9]+}}/z, [x1]
  %v = add <n x 8 x i16> %v1, %v2
; CHECK-DAG: add [[RES:z[0-9]+]].h, [[LOAD1]].h, [[LOAD2]].h
  %res = insertelement <n x 8 x i16> %v, i16 %val, i32 %index
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].h, #0, #1
; CHECK-DAG: mov [[SPLAT_INDEX:z[0-9]+]].h, {{w[0-9]+}}
; CHECK: cmpeq [[INDEX_PRED:p[0-9]+]].h, [[TRUE]]/z, [[ZERO_TO_N]].h, [[SPLAT_INDEX]].h
; CHECK: mov [[RES]].h, [[INDEX_PRED]]/m, w2
  store <n x 8 x i16> %res, <n x 8 x i16> *%vp1
; CHECK: st1h {[[RES]].h},
  ret void
}

define void @insert_nxv4i32_gpr(<n x 4 x i32> *%vp1, <n x 4 x i32> *%vp2, i32 %val, i32 %index) {
; CHECK-LABEL: insert_nxv4i32_gpr:
; CHECK: ptrue [[TRUE:p[0-9]+]].s
  %v1 = load <n x 4 x i32> , <n x 4 x i32> *%vp1
; CHECK: ld1w {[[LOAD1:z[0-9]+]].s}, {{p[0-9]+}}/z, [x0]
  %v2 = load <n x 4 x i32> , <n x 4 x i32> *%vp2
; CHECK: ld1w {[[LOAD2:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
  %v = add <n x 4 x i32> %v1, %v2
; CHECK-DAG: add [[RES:z[0-9]+]].s, [[LOAD1]].s, [[LOAD2]].s
  %res = insertelement <n x 4 x i32> %v, i32 %val, i32 %index
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].s, #0, #1
; CHECK-DAG: mov [[SPLAT_INDEX:z[0-9]+]].s, {{w[0-9]+}}
; CHECK: cmpeq [[INDEX_PRED:p[0-9]+]].s, [[TRUE]]/z, [[ZERO_TO_N]].s, [[SPLAT_INDEX]].s
; CHECK: mov [[RES]].s, [[INDEX_PRED]]/m, w2
  store <n x 4 x i32> %res, <n x 4 x i32> *%vp1
; CHECK: st1w {[[RES]].s},
  ret void
}

define void @insert_nxv2i64_gpr(<n x 2 x i64> *%vp1, <n x 2 x i64> *%vp2, i64 %val, i32 %index) {
; CHECK-LABEL: insert_nxv2i64_gpr:
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
  %v1 = load <n x 2 x i64> , <n x 2 x i64> *%vp1
; CHECK-DAG: ld1d {[[LOAD1:z[0-9]+]].d}, {{p[0-9]+}}/z, [x0]
  %v2 = load <n x 2 x i64> , <n x 2 x i64> *%vp2
; CHECK-DAG: ld1d {[[LOAD2:z[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
  %v = add <n x 2 x i64> %v1, %v2
; CHECK-DAG: add [[RES:z[0-9]+]].d, [[LOAD1]].d, [[LOAD2]].d
  %res = insertelement <n x 2 x i64> %v, i64 %val, i32 %index
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].d, #0, #1
; CHECK-DAG: sxtw [[INDEX:x[0-9]+]], w3
; CHECK-DAG: mov [[SPLAT_INDEX:z[0-9]+]].d, [[INDEX]]
; CHECK-DAG: cmpeq [[INDEX_PRED:p[0-9]+]].d, [[TRUE]]/z, [[ZERO_TO_N]].d, [[SPLAT_INDEX]].d
; CHECK-DAG: mov [[RES]].d, [[INDEX_PRED]]/m, x2
  store <n x 2 x i64> %res, <n x 2 x i64> *%vp1
; CHECK: st1d {[[RES]].d},
  ret void
}

define <n x 4 x i64> @insert_nxv4i64_gpr(<n x 4 x i64> %vp1, <n x 4 x i64> %vp2, i64 %val, i32 %index) {
; CHECK-LABEL: insert_nxv4i64_gpr:
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
  %v = add <n x 4 x i64> %vp1, %vp2
; CHECK-DAG: add z0.d, z0.d, z2.d
; CHECK-DAG: add z1.d, z1.d, z3.d
  %res = insertelement <n x 4 x i64> %v, i64 %val, i32 %index
; CHECK-DAG: sxtw  [[IDX:x[0-9]+]], w1
; CHECK-DAG: mov [[SPLAT_IDX:z[0-9]+]].d, [[IDX]]
; CHECK-DAG: mov [[SPLAT_VAL:z[0-9]+]].d, x0
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].d, #0, #1
; CHECK-DAG: cntd  [[EC:x[0-9]+]]
; CHECK-DAG: index [[EC_TO_N:z[0-9]+]].d, [[EC]], #1
; CHECK-DAG: cmpeq [[INDEX_PREDA:p[0-9]+]].d, [[TRUE]]/z, [[SPLAT_IDX]].d, [[ZERO_TO_N]].d
; CHECK-DAG: cmpeq [[INDEX_PREDB:p[0-9]+]].d, [[TRUE]]/z, [[SPLAT_IDX]].d, [[EC_TO_N]].d
; CHECK-DAG: mov   z0.d, [[INDEX_PREDA]]/m, [[SPLAT_VAL]].d
; CHECK-DAG: mov   z1.d, p{{[0-9]+}}/m, [[SPLAT_VAL]].d
  ret <n x 4 x i64> %res
}

define <n x 4 x double> @insert_nxv4f64_fpr(<n x 4 x double> %vp1, <n x 4 x double> %vp2, double %val, i32 %index) {
; CHECK-LABEL: insert_nxv4f64_fpr:
; CHECK: fmov [[SPLAT_INS:x[0-9]+]], d4
; CHECK: mov [[SPLAT_VAL:z[0-9]+]].d, [[SPLAT_INS]]
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
  %v = fadd <n x 4 x double> %vp1, %vp2
; CHECK-DAG: fadd z0.d, z0.d, z2.d
; CHECK-DAG: fadd z1.d, z1.d, z3.d
  %res = insertelement <n x 4 x double> %v, double %val, i32 %index
; CHECK-DAG: sxtw  [[IDX:x[0-9]+]], w0
; CHECK-DAG: mov [[SPLAT_IDX:z[0-9]+]].d, [[IDX]]
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].d, #0, #1
; CHECK-DAG: cntd  [[EC:x[0-9]+]]
; CHECK-DAG: index [[EC_TO_N:z[0-9]+]].d, [[EC]], #1
; CHECK-DAG: cmpeq [[INDEX_PREDA:p[0-9]+]].d, [[TRUE]]/z, [[SPLAT_IDX]].d, [[ZERO_TO_N]].d
; CHECK-DAG: cmpeq [[INDEX_PREDB:p[0-9]+]].d, [[TRUE]]/z, [[SPLAT_IDX]].d, [[EC_TO_N]].d
; CHECK-DAG: mov   z0.d, [[INDEX_PREDA]]/m, [[SPLAT_VAL]].d
; CHECK-DAG: mov   z1.d, p{{[0-9]+}}/m, [[SPLAT_VAL]].d
  ret <n x 4 x double> %res
}

define <n x 8 x i64> @insert_nxv8i64_gpr(<n x 8 x i64> %vp1, <n x 8 x i64> %vp2, i64 %val, i32 %index) {
; CHECK-LABEL: insert_nxv8i64_gpr:
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
  %v = add <n x 8 x i64> %vp1, %vp2
; CHECK-DAG: add z2.d, z2.d, z6.d
; CHECK-DAG: add z0.d, z0.d, z4.d
; CHECK-DAG: add z3.d, z3.d, z7.d
; CHECK-DAG: add z1.d, z1.d, z5.d
  %res = insertelement <n x 8 x i64> %v, i64 %val, i32 %index
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].d, #0, #1
; CHECK-DAG: cmpeq [[INDEX_PRED1:p[0-9]+]].d, [[TRUE]]/z, {{z[0-9]+}}.d, [[ZERO_TO_N]].d
; CHECK-DAG: mov   z0.d, [[INDEX_PRED1]]/m
; CHECK-DAG: cntd  [[TWO:x[0-9]+]]
; CHECK-DAG: index [[TWO_TO_N:z[0-9]+]].d, [[TWO]], #1
; CHECK-DAG: cmpeq [[INDEX_PRED2:p[0-9]+]].d, [[TRUE]]/z, {{z[0-9]+}}.d, [[TWO_TO_N]].d
; CHECK-DAG: mov   z1.d, [[INDEX_PRED2]]/m
; CHECK-DAG: cntw  [[FOUR:x[0-9]+]]
; CHECK-DAG: index [[FOUR_TO_N:z[0-9]+]].d, [[FOUR]], #1
; CHECK-DAG: cmpeq [[INDEX_PRED3:p[0-9]+]].d, [[TRUE]]/z, {{z[0-9]+}}.d, [[FOUR_TO_N]].d
; CHECK-DAG: mov   z2.d, [[INDEX_PRED3]]/m
; CHECK-DAG: incd  [[FOUR]]
; CHECK-DAG: cmpeq [[INDEX_PRED4:p[0-9]+]].d, [[TRUE]]/z, {{z[0-9]+}}.d, [[FOUR_TO_N]].d
; CHECK-DAG: mov   z2.d,
  ret <n x 8 x i64> %res
}

define void @insert_nxv4f32_fpr(<n x 4 x float> *%vp1, <n x 4 x float> *%vp2, float %val, i32 %index) {
; CHECK-LABEL: insert_nxv4f32_fpr:
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].s
  %v1 = load <n x 4 x float> , <n x 4 x float> *%vp1
; CHECK-DAG: ld1w {[[LOAD1:z[0-9]+]].s}, {{p[0-9]+}}/z, [x0]
  %v2 = load <n x 4 x float> , <n x 4 x float> *%vp2
; CHECK-DAG: ld1w {[[LOAD2:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
  %v = fadd <n x 4 x float> %v1, %v2
; CHECK-DAG: fadd [[RES:z[0-9]+]].s, [[LOAD1]].s, [[LOAD2]].s
  %res = insertelement <n x 4 x float> %v, float %val, i32 %index
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].s, #0, #1
; CHECK-DAG: mov [[SPLAT_INDEX:z[0-9]+]].s, {{w[0-9]+}}
; CHECK: cmpeq [[INDEX_PRED:p[0-9]+]].s, [[TRUE]]/z, [[ZERO_TO_N]].s, [[SPLAT_INDEX]].s
; CHECK: mov [[RES]].s, [[INDEX_PRED]]/m, s0
  store <n x 4 x float> %res, <n x 4 x float> *%vp1
; CHECK: st1w {[[RES]].s},
  ret void
}

define void @insert_nxv2f64_fpr(<n x 2 x double> *%vp1, <n x 2 x double> *%vp2, double %val, i32 %index) {
; CHECK-LABEL: insert_nxv2f64_fpr:
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
  %v1 = load <n x 2 x double> , <n x 2 x double> *%vp1
; CHECK-DAG: ld1d {[[LOAD1:z[0-9]+]].d}, {{p[0-9]+}}/z, [x0]
  %v2 = load <n x 2 x double> , <n x 2 x double> *%vp2
; CHECK-DAG: ld1d {[[LOAD2:z[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
  %v = fadd <n x 2 x double> %v1, %v2
; CHECK-DAG: fadd [[RES:z[0-9]+]].d, [[LOAD1]].d, [[LOAD2]].d
  %res = insertelement <n x 2 x double> %v, double %val, i32 %index
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].d, #0, #1
; CHECK-DAG: sxtw [[INDEX:x[0-9]+]], w2
; CHECK-DAG: mov [[SPLAT_INDEX:z[0-9]+]].d, [[INDEX]]
; CHECK: cmpeq [[INDEX_PRED:p[0-9]+]].d, [[TRUE]]/z, [[ZERO_TO_N]].d, [[SPLAT_INDEX]].d
; CHECK: mov [[RES]].d, [[INDEX_PRED]]/m, d0
  store <n x 2 x double> %res, <n x 2 x double> *%vp1
; CHECK: st1d {[[RES]].d},
  ret void
}

define void @insert_nxv2f32_fpr(<n x 2 x float> *%vp1, <n x 2 x float> *%vp2, float %val, i32 %index) {
; CHECK-LABEL: insert_nxv2f32_fpr:
; CHECK: ptrue [[TRUE:p[0-9]+]].d
  %v1 = load <n x 2 x float> , <n x 2 x float> *%vp1
; CHECK: ld1w {[[LOAD1:z[0-9]+]].d}, [[TRUE]]/z, [x0]
  %v2 = load <n x 2 x float> , <n x 2 x float> *%vp2
; CHECK: ld1w {[[LOAD2:z[0-9]+]].d}, [[TRUE]]/z, [x1]
  %v = fadd <n x 2 x float> %v1, %v2
; CHECK-DAG: fadd [[RES:z[0-9]+]].s, [[LOAD1]].s, [[LOAD2]].s
  %res = insertelement <n x 2 x float> %v, float %val, i32 %index
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].d, #0, #1
; CHECK-DAG: sxtw [[INDEX:x[0-9]+]], w2
; CHECK-DAG: mov [[SPLAT_INDEX:z[0-9]+]].d, [[INDEX]]
; CHECK: cmpeq [[INDEX_PRED:p[0-9]+]].d, [[TRUE]]/z, [[ZERO_TO_N]].d, [[SPLAT_INDEX]].d
; CHECK: mov [[RES]].s, [[INDEX_PRED]]/m, s0
  store <n x 2 x float> %res, <n x 2 x float> *%vp1
; CHECK: st1w {[[RES]].d}, [[TRUE]], [x0]
  ret void
}

define <n x 16 x i1> @insert_nxv16i1_gpr(<n x 16 x i1> %in, i1 %val, i64 %index) {
; CHECK-LABEL: insert_nxv16i1_gpr:
; CHECK-DAG: mov   [[IN:z[0-9]+]].b, p0/z, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].b
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].b, #0, #1
; CHECK-DAG: mov   [[SPLAT_INDEX:z[0-9]+]].b, w1
; CHECK-DAG: cmpeq [[INDEX_PRED:p[0-9]+]].b, [[TRUE]]/z, [[ZERO_TO_N]].b, [[SPLAT_INDEX]].b
; CHECK:     mov   [[IN]].b, [[INDEX_PRED]]/m, w0
; CHECK:     lsl   [[OUT:z[0-9]+]].b, [[IN]].b, #7
; CHECK:     cmpne p0.b, [[TRUE]]/z, [[OUT]].b, #0
; CHECK:     ret
  %res = insertelement <n x 16 x i1> %in, i1 %val, i64 %index
  ret <n x 16 x i1> %res
}

define <n x 8 x i1> @insert_nxv8i1_gpr(<n x 8 x i1> %in, i1 %val, i64 %index) {
; CHECK-LABEL: insert_nxv8i1_gpr:
; CHECK-DAG: mov   [[IN:z[0-9]+]].h, p0/z, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].h
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].h, #0, #1
; CHECK-DAG: mov   [[SPLAT_INDEX:z[0-9]+]].h, w1
; CHECK-DAG: cmpeq [[INDEX_PRED:p[0-9]+]].h, [[TRUE]]/z, [[ZERO_TO_N]].h, [[SPLAT_INDEX]].h
; CHECK:     mov   [[IN]].h, [[INDEX_PRED]]/m, w0
; CHECK:     lsl   [[OUT:z[0-9]+]].h, [[IN]].h, #15
; CHECK:     cmpne p0.h, [[TRUE]]/z, [[OUT]].h, #0
; CHECK:     ret
  %res = insertelement <n x 8 x i1> %in, i1 %val, i64 %index
  ret <n x 8 x i1> %res
}

define <n x 4 x i1> @insert_nxv4i1_gpr(<n x 4 x i1> %in, i1 %val, i64 %index) {
; CHECK-LABEL: insert_nxv4i1_gpr:
; CHECK-DAG: mov   [[IN:z[0-9]+]].s, p0/z, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].s
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].s, #0, #1
; CHECK-DAG: mov   [[SPLAT_INDEX:z[0-9]+]].s, w1
; CHECK-DAG: cmpeq [[INDEX_PRED:p[0-9]+]].s, [[TRUE]]/z, [[ZERO_TO_N]].s, [[SPLAT_INDEX]].s
; CHECK:     mov   [[IN]].s, [[INDEX_PRED]]/m, w0
; CHECK:     lsl   [[OUT:z[0-9]+]].s, [[IN]].s, #31
; CHECK:     cmpne p0.s, [[TRUE]]/z, [[OUT]].s, #0
; CHECK:     ret
  %res = insertelement <n x 4 x i1> %in, i1 %val, i64 %index
  ret <n x 4 x i1> %res
}

define <n x 2 x i1> @insert_nxv2i1_gpr(<n x 2 x i1> %in, i1 %val, i64 %index) {
; CHECK-LABEL: insert_nxv2i1_gpr:
; CHECK-DAG: mov   [[IN:z[0-9]+]].d, p0/z, #1
; CHECK-DAG: ptrue [[TRUE:p[0-9]+]].d
; CHECK-DAG: index [[ZERO_TO_N:z[0-9]+]].d, #0, #1
; CHECK-DAG: mov   [[SPLAT_INDEX:z[0-9]+]].d, x1
; CHECK-DAG: cmpeq [[INDEX_PRED:p[0-9]+]].d, [[TRUE]]/z, [[ZERO_TO_N]].d, [[SPLAT_INDEX]].d
; CHECK:     mov   [[IN]].d, [[INDEX_PRED]]/m, x0
; CHECK:     lsl   [[OUT:z[0-9]+]].d, [[IN]].d, #63
; CHECK:     cmpne p0.d, [[TRUE]]/z, [[OUT]].d, #0
; CHECK:     ret
  %res = insertelement <n x 2 x i1> %in, i1 %val, i64 %index
  ret <n x 2 x i1> %res
}
define void @insert_nxv4f32_fpr_0(<n x 4 x float> *%out, <n x 4 x float> *%in, float %val) {
; CHECK-LABEL: insert_nxv4f32_fpr_0:
; CHECK-DAG: ld1w {[[IN:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ptrue [[PSEL:p[0-9]+]].s, vl1
; CHECK: sel [[OUT:z[0-9]+]].s, [[PSEL]], z0.s, [[IN]].s
; CHECK: st1w {[[OUT]].s},
; CHECK: ret
  %in.load = load <n x 4 x float> , <n x 4 x float> *%in
  %res = insertelement <n x 4 x float> %in.load, float %val, i32 0
  store <n x 4 x float> %res, <n x 4 x float> *%out
  ret void
}

define void @insert_nxv2f64_fpr_0(<n x 2 x double> *%out, <n x 2 x double> *%in, double %val) {
; CHECK-LABEL: insert_nxv2f64_fpr_0:
; CHECK-DAG: ptrue [[PSEL:p[0-9]+]].d, vl1
; CHECK-DAG: ld1d {[[IN:z[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
; CHECK: sel [[OUT:z[0-9]+]].d, [[PSEL]], z0.d, [[IN]].d
; CHECK: st1d {[[OUT]].d},
; CHECK: ret
  %in.load = load <n x 2 x double> , <n x 2 x double> *%in
  %res = insertelement <n x 2 x double> %in.load, double %val, i32 0
  store <n x 2 x double> %res, <n x 2 x double> *%out
  ret void
}

define <n x 16 x i1> @insert_nxv16i1_gpr_0(<n x 16 x i1> %in, i1 %val) {
; CHECK-LABEL: insert_nxv16i1_gpr_0:
; CHECK-DAG: mov   [[IN:z[0-9]+]].b, p0/z, #1
; CHECK-DAG: ptrue [[P_ONE:p[0-9]+]].b, vl1
; CHECK:     mov   [[IN]].b, [[P_ONE]]/m, w0
; CHECK:     lsl   [[OUT:z[0-9]+]].b, [[IN]].b, #7
; CHECK:     ptrue [[P_ALL:p[0-9]+]].b
; CHECK:     cmpne p0.b, [[P_ALL]]/z, [[OUT]].b, #0
; CHECK:     ret
  %res = insertelement <n x 16 x i1> %in, i1 %val, i32 0
  ret <n x 16 x i1> %res
}

define <n x 8 x i1> @insert_nxv8i1_gpr_0(<n x 8 x i1> %in, i1 %val) {
; CHECK-LABEL: insert_nxv8i1_gpr_0:
; CHECK-DAG: mov   [[IN:z[0-9]+]].h, p0/z, #1
; CHECK-DAG: ptrue [[P_ONE:p[0-9]+]].h, vl1
; CHECK:     mov   [[IN]].h, [[P_ONE]]/m, w0
; CHECK:     lsl   [[OUT:z[0-9]+]].h, [[IN]].h, #15
; CHECK:     ptrue [[P_ALL:p[0-9]+]].h
; CHECK:     cmpne p0.h, [[P_ALL]]/z, [[OUT]].h, #0
; CHECK:     ret
  %res = insertelement <n x 8 x i1> %in, i1 %val, i32 0
  ret <n x 8 x i1> %res
}

define <n x 4 x i1> @insert_nxv4i1_gpr_0(<n x 4 x i1> %in, i1 %val) {
; CHECK-LABEL: insert_nxv4i1_gpr_0:
; CHECK-DAG: mov   [[IN:z[0-9]+]].s, p0/z, #1
; CHECK-DAG: ptrue [[P_ONE:p[0-9]+]].s, vl1
; CHECK:     mov   [[IN]].s, [[P_ONE]]/m, w0
; CHECK:     lsl   [[OUT:z[0-9]+]].s, [[IN]].s, #31
; CHECK:     ptrue [[P_ALL:p[0-9]+]].s
; CHECK:     cmpne p0.s, [[P_ALL]]/z, [[OUT]].s, #0
; CHECK:     ret
  %res = insertelement <n x 4 x i1> %in, i1 %val, i32 0
  ret <n x 4 x i1> %res
}

define <n x 2 x i1> @insert_nxv2i1_gpr_0(<n x 2 x i1> %in, i1 %val) {
; CHECK-LABEL: insert_nxv2i1_gpr_0:
; CHECK-DAG: mov   [[IN:z[0-9]+]].d, p0/z, #1
; CHECK-DAG: ptrue [[P_ONE:p[0-9]+]].d, vl1
; CHECK:     mov   [[IN]].d, [[P_ONE]]/m, x0
; CHECK:     lsl   [[OUT:z[0-9]+]].d, [[IN]].d, #63
; CHECK:     ptrue [[P_ALL:p[0-9]+]].d
; CHECK:     cmpne p0.d, [[P_ALL]]/z, [[OUT]].d, #0
; CHECK:     ret
  %res = insertelement <n x 2 x i1> %in, i1 %val, i32 0
  ret <n x 2 x i1> %res
}

declare i64 @llvm.ctvpop.nxv2i1(<n x 2 x i1>)
define <n x 2 x i1> @insert_nxv2i1_ctvpop(<n x 2 x i1> %in) {
; CHECK-LABEL: insert_nxv2i1_ctvpop
; CHECK-DAG: ptrue [[PTRUE:p[0-9]+]].d
; CHECK-DAG: nor   [[NOT:p[0-9]+]].b, [[PTRUE]]/z, p0.b, p0.b
; CHECK-DAG: brka  p0.b, [[PTRUE]]/z, [[NOT]].b
  %true = shufflevector <n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %prop = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %true, <n x 2 x i1> %in)
  %cntp = call i64 @llvm.ctvpop.nxv2i1(<n x 2 x i1> %prop)
  %res = insertelement <n x 2 x i1> %prop, i1 true, i64 %cntp
  ret <n x 2 x i1> %res
}

declare i64 @llvm.ctvpop.nxv4i1(<n x 4 x i1>)
define <n x 4 x i1> @insert_nxv4i1_ctvpop(<n x 4 x i1> %in) {
; CHECK-LABEL: insert_nxv4i1_ctvpop
; CHECK-DAG: ptrue [[PTRUE:p[0-9]+]].s
; CHECK-DAG: nor   [[NOT:p[0-9]+]].b, [[PTRUE]]/z, p0.b, p0.b
; CHECK-DAG: brka  p0.b, [[PTRUE]]/z, [[NOT]].b
  %true = shufflevector <n x 4 x i1> insertelement (<n x 4 x i1> undef, i1 true, i32 0), <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %prop = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %true, <n x 4 x i1> %in)
  %cntp = call i64 @llvm.ctvpop.nxv4i1(<n x 4 x i1> %prop)
  %res = insertelement <n x 4 x i1> %prop, i1 true, i64 %cntp
  ret <n x 4 x i1> %res
}

declare <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1>, <n x 4 x i1>)
declare <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1>, <n x 2 x i1>)
