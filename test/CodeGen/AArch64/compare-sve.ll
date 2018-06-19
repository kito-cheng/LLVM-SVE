; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define void @icmp_eq_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_eq_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpeq [[PD:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp eq <n x 16 x i8> %in0, %in1
  %res = sext <n x 16 x i1> %cmp to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_eq_b_i1(<n x 32 x i1> *%a, <n x 32 x i8> *%b, <n x 32 x i8> *%c) {
; CHECK-LABEL: icmp_eq_b_i1:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[Z0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[Z2:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK-DAG: ld1b {[[Z1:z[0-9]+]].b}, [[PG]]/z, [x1, #1, mul vl]
; CHECK-DAG: ld1b {[[Z3:z[0-9]+]].b}, [[PG]]/z, [x2, #1, mul vl]
; CHECK-DAG: cmpeq [[RES0:p[0-9]+]].b, [[PG]]/z, [[Z0]].b, [[Z2]].b
; CHECK-DAG: cmpeq [[RES1:p[0-9]+]].b, [[PG]]/z, [[Z1]].b, [[Z3]].b
; CHECK-DAG: str [[RES0]], [x0]
; CHECK-DAG: str [[RES1]], [x8]
; CHECK: ret
  %in0 = load <n x 32 x i8> , <n x 32 x i8> *%b
  %in1 = load <n x 32 x i8> , <n x 32 x i8> *%c
  %res = icmp eq <n x 32 x i8> %in0, %in1
  store <n x 32 x i1> %res, <n x 32 x i1> *%a
  ret void
}

define void @icmp_eq_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_eq_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpeq [[PD:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp eq <n x 8 x i16> %in0, %in1
  %res = sext <n x 8 x i1> %cmp to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_eq_h_i1(<n x 16 x i1> *%a, <n x 16 x i16> *%b, <n x 16 x i16> *%c) {
; CHECK-LABEL: icmp_eq_h_i1:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[Z0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[Z1:z[0-9]+]].h}, [[PG]]/z, [x1, #1, mul vl]
; CHECK-DAG: ld1h {[[Z2:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK-DAG: ld1h {[[Z3:z[0-9]+]].h}, [[PG]]/z, [x2, #1, mul vl]
; CHECK-DAG: cmpeq [[P0:p[0-9]+]].h, [[PG]]/z, [[Z0]].h, [[Z2]].h
; CHECK-DAG: cmpeq [[P1:p[0-9]+]].h, [[PG]]/z, [[Z1]].h, [[Z3]].h
; CHECK: uzp1 [[RES:p[0-9]+]].b, [[P0]].b, [[P1]].b
; CHECK: str [[RES]], [x0]
; CHECK: ret
  %in0 = load <n x 16 x i16> , <n x 16 x i16> *%b
  %in1 = load <n x 16 x i16> , <n x 16 x i16> *%c
  %res = icmp eq <n x 16 x i16> %in0, %in1
  store <n x 16 x i1> %res, <n x 16 x i1> *%a
  ret void
}

define void @icmp_eq_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_eq_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpeq [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp eq <n x 4 x i32> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_eq_s_i1(<n x 8 x i1> *%a, <n x 8 x i32> *%b, <n x 8 x i32> *%c) {
; CHECK-LABEL: icmp_eq_s_i1:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[Z0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[Z1:z[0-9]+]].s}, [[PG]]/z, [x1, #1, mul vl]
; CHECK-DAG: ld1w {[[Z2:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK-DAG: ld1w {[[Z3:z[0-9]+]].s}, [[PG]]/z, [x2, #1, mul vl]
; CHECK-DAG: cmpeq [[P1:p[0-9]+]].s, [[PG]]/z, [[Z0]].s, [[Z2]].s
; CHECK-DAG: cmpeq [[P2:p[0-9]+]].s, [[PG]]/z, [[Z1]].s, [[Z3]].s
; CHECK: uzp1 [[RES:p[0-9]+]].h, [[P1]].h, [[P2]].h
; CHECK: str [[RES]], [x0]
; CHECK: ret
  %in0 = load <n x 8 x i32> , <n x 8 x i32> *%b
  %in1 = load <n x 8 x i32> , <n x 8 x i32> *%c
  %res = icmp eq <n x 8 x i32> %in0, %in1
  store <n x 8 x i1> %res, <n x 8 x i1> *%a
  ret void
}

define void @icmp_eq_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_eq_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpeq [[PD:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp eq <n x 2 x i64> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_eq_d_i1(<n x 4 x i1> *%a, <n x 4 x i64> *%b, <n x 4 x i64> *%c) {
; CHECK-LABEL: icmp_eq_d_i1:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[Z0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[Z1:z[0-9]+]].d}, [[PG]]/z, [x1, #1, mul vl]
; CHECK-DAG: ld1d {[[Z2:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK-DAG: ld1d {[[Z3:z[0-9]+]].d}, [[PG]]/z, [x2, #1, mul vl]
; CHECK-DAG: cmpeq [[P1:p[0-9]+]].d, [[PG]]/z, [[Z0]].d, [[Z2]].d
; CHECK-DAG: cmpeq [[P2:p[0-9]+]].d, [[PG]]/z, [[Z1]].d, [[Z3]].d
; CHECK: uzp1 [[RES:p[0-9]+]].s, [[P1]].s, [[P2]].s
; CHECK: str [[RES]], [x0]
; CHECK: ret
  %in0 = load <n x 4 x i64> , <n x 4 x i64> *%b
  %in1 = load <n x 4 x i64> , <n x 4 x i64> *%c
  %res = icmp eq <n x 4 x i64> %in0, %in1
  store <n x 4 x i1> %res, <n x 4 x i1> *%a
  ret void
}

define void @icmp_ne_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_ne_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpne [[PD:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp ne <n x 16 x i8> %in0, %in1
  %res = sext <n x 16 x i1> %cmp to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_ne_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_ne_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpne [[PD:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp ne <n x 8 x i16> %in0, %in1
  %res = sext <n x 8 x i1> %cmp to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_ne_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_ne_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpne [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp ne <n x 4 x i32> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_ne_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_ne_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpne [[PD:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp ne <n x 2 x i64> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_sge_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_sge_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpge [[PD:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp sge <n x 16 x i8> %in0, %in1
  %res = sext <n x 16 x i1> %cmp to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_sge_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_sge_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpge [[PD:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp sge <n x 8 x i16> %in0, %in1
  %res = sext <n x 8 x i1> %cmp to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_sge_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_sge_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpge [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp sge <n x 4 x i32> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_sge_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_sge_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpge [[PD:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp sge <n x 2 x i64> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_sgt_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_sgt_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PD:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp sgt <n x 16 x i8> %in0, %in1
  %res = sext <n x 16 x i1> %cmp to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_sgt_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_sgt_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PD:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp sgt <n x 8 x i16> %in0, %in1
  %res = sext <n x 8 x i1> %cmp to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_sgt_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_sgt_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_sgt_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_sgt_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PD:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp sgt <n x 2 x i64> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_sle_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_sle_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpge [[PD:p[0-9]+]].b, [[PG]]/z, [[IN1]].b, [[IN0]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp sle <n x 16 x i8> %in0, %in1
  %res = sext <n x 16 x i1> %cmp to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_sle_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_sle_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpge [[PD:p[0-9]+]].h, [[PG]]/z, [[IN1]].h, [[IN0]].h
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp sle <n x 8 x i16> %in0, %in1
  %res = sext <n x 8 x i1> %cmp to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_sle_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_sle_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpge [[PD:p[0-9]+]].s, [[PG]]/z, [[IN1]].s, [[IN0]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp sle <n x 4 x i32> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_sle_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_sle_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpge [[PD:p[0-9]+]].d, [[PG]]/z, [[IN1]].d, [[IN0]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp sle <n x 2 x i64> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_slt_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_slt_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PD:p[0-9]+]].b, [[PG]]/z, [[IN1]].b, [[IN0]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp slt <n x 16 x i8> %in0, %in1
  %res = sext <n x 16 x i1> %cmp to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_slt_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_slt_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PD:p[0-9]+]].h, [[PG]]/z, [[IN1]].h, [[IN0]].h
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp slt <n x 8 x i16> %in0, %in1
  %res = sext <n x 8 x i1> %cmp to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_slt_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_slt_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PD:p[0-9]+]].s, [[PG]]/z, [[IN1]].s, [[IN0]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp slt <n x 4 x i32> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_slt_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_slt_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PD:p[0-9]+]].d, [[PG]]/z, [[IN1]].d, [[IN0]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp slt <n x 2 x i64> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_uge_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_uge_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmphs [[PD:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp uge <n x 16 x i8> %in0, %in1
  %res = sext <n x 16 x i1> %cmp to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_uge_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_uge_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmphs [[PD:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp uge <n x 8 x i16> %in0, %in1
  %res = sext <n x 8 x i1> %cmp to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_uge_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_uge_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmphs [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp uge <n x 4 x i32> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_uge_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_uge_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmphs [[PD:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp uge <n x 2 x i64> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_ugt_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_ugt_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmphi [[PD:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp ugt <n x 16 x i8> %in0, %in1
  %res = sext <n x 16 x i1> %cmp to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_ugt_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_ugt_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmphi [[PD:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp ugt <n x 8 x i16> %in0, %in1
  %res = sext <n x 8 x i1> %cmp to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_ugt_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_ugt_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmphi [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp ugt <n x 4 x i32> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_ugt_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_ugt_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmphi [[PD:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp ugt <n x 2 x i64> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_ule_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_ule_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmphs [[PD:p[0-9]+]].b, [[PG]]/z, [[IN1]].b, [[IN0]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp ule <n x 16 x i8> %in0, %in1
  %res = sext <n x 16 x i1> %cmp to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_ule_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_ule_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmphs [[PD:p[0-9]+]].h, [[PG]]/z, [[IN1]].h, [[IN0]].h
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp ule <n x 8 x i16> %in0, %in1
  %res = sext <n x 8 x i1> %cmp to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_ule_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_ule_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmphs [[PD:p[0-9]+]].s, [[PG]]/z, [[IN1]].s, [[IN0]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp ule <n x 4 x i32> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_ule_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_ule_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmphs [[PD:p[0-9]+]].d, [[PG]]/z, [[IN1]].d, [[IN0]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp ule <n x 2 x i64> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_ult_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_ult_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmphi [[PD:p[0-9]+]].b, [[PG]]/z, [[IN1]].b, [[IN0]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp ult <n x 16 x i8> %in0, %in1
  %res = sext <n x 16 x i1> %cmp to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_ult_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_ult_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmphi [[PD:p[0-9]+]].h, [[PG]]/z, [[IN1]].h, [[IN0]].h
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp ult <n x 8 x i16> %in0, %in1
  %res = sext <n x 8 x i1> %cmp to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_ult_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_ult_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmphi [[PD:p[0-9]+]].s, [[PG]]/z, [[IN1]].s, [[IN0]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp ult <n x 4 x i32> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_ult_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_ult_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmphi [[PD:p[0-9]+]].d, [[PG]]/z, [[IN1]].d, [[IN0]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp ult <n x 2 x i64> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

; Verify general predicate is folded into the compare
define void @predicated_icmp_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b,
                               <n x 4 x i1> *%pred) {
; CHECK-LABEL: predicated_icmp_s
; CHECK: ldr [[PG:p[0-9]+]], [x2
; CHECK: cmpgt {{p[0-9]+}}.s, [[PG]]/z
  %gp = load <n x 4 x i1> , <n x 4 x i1> *%pred
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %pred_cmp = and <n x 4 x i1> %gp, %cmp
  %res = sext <n x 4 x i1> %pred_cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}
