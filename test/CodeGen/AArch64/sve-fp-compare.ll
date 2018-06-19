; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

;; Ordered Equal
define void @fcmp_oeq_s(<n x 4 x i32> *%dest, <n x 4 x float> *%src0, <n x 4 x float> *%src1) {
; CHECK-LABEL: fcmp_oeq_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: fcmeq [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x float> , <n x 4 x float> *%src0
  %in1 = load <n x 4 x float> , <n x 4 x float> *%src1
  %cmp = fcmp oeq <n x 4 x float> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%dest
  ret void
}

define void @fcmp_oeq_sx2(<n x 2 x i64> *%dest, <n x 2 x float> *%src0, <n x 2 x float> *%src1) {
; CHECK-LABEL: fcmp_oeq_sx2:
; CHECK:     ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: fcmeq [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x float> , <n x 2 x float> *%src0
  %in1 = load <n x 2 x float> , <n x 2 x float> *%src1
  %cmp = fcmp oeq <n x 2 x float> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%dest
  ret void
}

define void @fcmp_oeq_d(<n x 2 x i64> *%dest, <n x 2 x double> *%src0, <n x 2 x double> *%src1) {
; CHECK-LABEL: fcmp_oeq_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: fcmeq [[PD:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x double> , <n x 2 x double> *%src0
  %in1 = load <n x 2 x double> , <n x 2 x double> *%src1
  %cmp = fcmp oeq <n x 2 x double> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%dest
  ret void
}

;; Ordered Greater Than
define void @fcmp_ogt_s(<n x 4 x i32> *%dest, <n x 4 x float> *%src0, <n x 4 x float> *%src1) {
; CHECK-LABEL: fcmp_ogt_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: fcmgt [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x float> , <n x 4 x float> *%src0
  %in1 = load <n x 4 x float> , <n x 4 x float> *%src1
  %cmp = fcmp ogt <n x 4 x float> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%dest
  ret void
}

define void @fcmp_ogt_sx2(<n x 2 x i64> *%dest, <n x 2 x float> *%src0, <n x 2 x float> *%src1) {
; CHECK-LABEL: fcmp_ogt_sx2:
; CHECK:     ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: fcmgt [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x float> , <n x 2 x float> *%src0
  %in1 = load <n x 2 x float> , <n x 2 x float> *%src1
  %cmp = fcmp ogt <n x 2 x float> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%dest
  ret void
}

define void @fcmp_ogt_d(<n x 2 x i64> *%dest, <n x 2 x double> *%src0, <n x 2 x double> *%src1) {
; CHECK-LABEL: fcmp_ogt_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: fcmgt [[PD:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x double> , <n x 2 x double> *%src0
  %in1 = load <n x 2 x double> , <n x 2 x double> *%src1
  %cmp = fcmp ogt <n x 2 x double> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%dest
  ret void
}

;; Ordered Greater or Equal
define void @fcmp_oge_s(<n x 4 x i32> *%dest, <n x 4 x float> *%src0, <n x 4 x float> *%src1) {
; CHECK-LABEL: fcmp_oge_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: fcmge [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x float> , <n x 4 x float> *%src0
  %in1 = load <n x 4 x float> , <n x 4 x float> *%src1
  %cmp = fcmp oge <n x 4 x float> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%dest
  ret void
}

define void @fcmp_oge_d(<n x 2 x i64> *%dest, <n x 2 x double> *%src0, <n x 2 x double> *%src1) {
; CHECK-LABEL: fcmp_oge_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: fcmge [[PD:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x double> , <n x 2 x double> *%src0
  %in1 = load <n x 2 x double> , <n x 2 x double> *%src1
  %cmp = fcmp oge <n x 2 x double> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%dest
  ret void
}

;; Ordered Less Than
define void @fcmp_olt_s(<n x 4 x i32> *%dest, <n x 4 x float> *%src0, <n x 4 x float> *%src1) {
; CHECK-LABEL: fcmp_olt_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: fcmgt [[PD:p[0-9]+]].s, [[PG]]/z, [[IN1]].s, [[IN0]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x float> , <n x 4 x float> *%src0
  %in1 = load <n x 4 x float> , <n x 4 x float> *%src1
  %cmp = fcmp olt <n x 4 x float> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%dest
  ret void
}

define void @fcmp_olt_d(<n x 2 x i64> *%dest, <n x 2 x double> *%src0, <n x 2 x double> *%src1) {
; CHECK-LABEL: fcmp_olt_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: fcmgt [[PD:p[0-9]+]].d, [[PG]]/z, [[IN1]].d, [[IN0]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x double> , <n x 2 x double> *%src0
  %in1 = load <n x 2 x double> , <n x 2 x double> *%src1
  %cmp = fcmp olt <n x 2 x double> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%dest
  ret void
}

;; Ordered Less Than or Equal
define void @fcmp_ole_s(<n x 4 x i32> *%dest, <n x 4 x float> *%src0, <n x 4 x float> *%src1) {
; CHECK-LABEL: fcmp_ole_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: fcmge [[PD:p[0-9]+]].s, [[PG]]/z, [[IN1]].s, [[IN0]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x float> , <n x 4 x float> *%src0
  %in1 = load <n x 4 x float> , <n x 4 x float> *%src1
  %cmp = fcmp ole <n x 4 x float> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%dest
  ret void
}

define void @fcmp_ole_d(<n x 2 x i64> *%dest, <n x 2 x double> *%src0, <n x 2 x double> *%src1) {
; CHECK-LABEL: fcmp_ole_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: fcmge [[PD:p[0-9]+]].d, [[PG]]/z, [[IN1]].d, [[IN0]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x double> , <n x 2 x double> *%src0
  %in1 = load <n x 2 x double> , <n x 2 x double> *%src1
  %cmp = fcmp ole <n x 2 x double> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%dest
  ret void
}


;; Selects
define void @fselect_s(<n x 4 x float> *%dest, <n x 4 x float> *%a, <n x 4 x float> *%b, <n x 4 x i1> *%c) {
; CHECK-LABEL: fselect_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK-DAG: ldr [[PSEL:p[0-9]+]], [x3]
; CHECK: sel [[RES:z[0-9]+]].s, [[PSEL]], [[IN0]].s, [[IN1]].s
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x float> , <n x 4 x float> *%a
  %in1 = load <n x 4 x float> , <n x 4 x float> *%b
  %mask = load <n x 4 x i1> , <n x 4 x i1> *%c
  %out = select <n x 4 x i1> %mask, <n x 4 x float> %in0, <n x 4 x float> %in1
  store <n x 4 x float> %out, <n x 4 x float> *%dest
  ret void
}

define void @fselect_s_halfsize(<n x 2 x float> *%dest, <n x 2 x float> *%a, <n x 2 x float> *%b, <n x 2 x i1> *%c) {
; CHECK-LABEL: fselect_s_halfsize:
; CHECK: ptrue [[PMEM:p[0-9]+]].d
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].d}, [[PMEM]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].d}, [[PMEM]]/z, [x2]
; CHECK-DAG: ldr [[PSEL:p[0-9]+]], [x3]
; CHECK: sel [[RES:z[0-9]+]].d, [[PSEL]], [[IN0]].d, [[IN1]].d
; CHECK: st1w {[[RES]].d}, [[PMEM]], [x0]
; CHECK: ret
  %in0 = load <n x 2 x float> , <n x 2 x float> *%a
  %in1 = load <n x 2 x float> , <n x 2 x float> *%b
  %mask = load <n x 2 x i1> , <n x 2 x i1> *%c
  %out = select <n x 2 x i1> %mask, <n x 2 x float> %in0, <n x 2 x float> %in1
  store <n x 2 x float> %out, <n x 2 x float> *%dest
  ret void
}

define void @fselect_d(<n x 2 x double> *%dest, <n x 2 x double> *%a, <n x 2 x double> *%b, <n x 2 x i1> *%c) {
; CHECK-LABEL: fselect_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK-DAG: ldr [[PSEL:p[0-9]+]], [x3]
; CHECK: sel [[RES:z[0-9]+]].d, [[PSEL]], [[IN0]].d, [[IN1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x double> , <n x 2 x double> *%a
  %in1 = load <n x 2 x double> , <n x 2 x double> *%b
  %mask = load <n x 2 x i1> , <n x 2 x i1> *%c
  %out = select <n x 2 x i1> %mask, <n x 2 x double> %in0, <n x 2 x double> %in1
  store <n x 2 x double> %out, <n x 2 x double> *%dest
  ret void
}

;; Unordered Not Equal
define void @fcmp_une_s(<n x 4 x i32> *%dest, <n x 4 x float> *%src0, <n x 4 x float> *%src1) {
; CHECK-LABEL: fcmp_une_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: fcmne [[PD:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x float> , <n x 4 x float> *%src0
  %in1 = load <n x 4 x float> , <n x 4 x float> *%src1
  %cmp = fcmp une <n x 4 x float> %in0, %in1
  %res = sext <n x 4 x i1> %cmp to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%dest
  ret void
}

define void @fcmp_une_d(<n x 2 x i64> *%dest, <n x 2 x double> *%src0, <n x 2 x double> *%src1) {
; CHECK-LABEL: fcmp_une_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: fcmne [[PD:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x double> , <n x 2 x double> *%src0
  %in1 = load <n x 2 x double> , <n x 2 x double> *%src1
  %cmp = fcmp une <n x 2 x double> %in0, %in1
  %res = sext <n x 2 x i1> %cmp to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%dest
  ret void
}
