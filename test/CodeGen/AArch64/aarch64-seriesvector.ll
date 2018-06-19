; RUN: llc -verify-machineinstrs -o - %s -mtriple=aarch64 -mattr=+sve | FileCheck %s --check-prefix=CHECK


;; Integer + Integer variants

@B = global i8 1
@H = global i16 1
@S = global i32 1
@D = global i64 1

define void @seriesvec_b(<n x 16 x i8>* %addr) {
; CHECK-LABEL: seriesvec_b:
; CHECK: index [[RES:z[0-9]+]].b, [[INIT:w[0-9]+]], #1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %bb = load i8, i8* @B
  %1 = insertelement <n x 16 x i8> undef, i8 1, i32 0
  %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i8> %2, stepvector
  %4 = insertelement <n x 16 x i8> undef, i8 %bb, i32 0
  %5 = shufflevector <n x 16 x i8> %4, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %index = add <n x 16 x i8> %5, %3
  store <n x 16 x i8> %index, <n x 16 x i8>* %addr
  ret void
}

define void @seriesvec_h(<n x 8 x i16>* %addr) {
; CHECK-LABEL: seriesvec_h:
; CHECK: index [[RES:z[0-9]+]].h, [[INIT:w[0-9]+]], #8
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %hh = load i16, i16* @H
  %1 = insertelement <n x 8 x i16> undef, i16 8, i32 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i16> %2, stepvector
  %4 = insertelement <n x 8 x i16> undef, i16 %hh, i32 0
  %5 = shufflevector <n x 8 x i16> %4, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %index = add <n x 8 x i16> %5, %3
  store <n x 8 x i16> %index, <n x 8 x i16>* %addr
  ret void
}

define void @seriesvec_s(<n x 4 x i32>* %addr) {
; CHECK-LABEL: seriesvec_s:
; CHECK: index [[RES:z[0-9]+]].s, [[INIT:w[0-9]+]], [[STEP:w[0-9]+]]
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %ss = load i32, i32* @S
  %1 = insertelement <n x 4 x i32> undef, i32 -40, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 %ss, i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %index = add <n x 4 x i32> %5, %3
  store <n x 4 x i32> %index, <n x 4 x i32>* %addr
  ret void
}

define void @seriesvec_d(<n x 2 x i64>* %addr) {
; CHECK-LABEL: seriesvec_d:
; CHECK: index [[RES:z[0-9]+]].d, [[INIT:x[0-9]+]], [[STEP:x[0-9]+]]
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %dd = load i64, i64* @D
  %1 = insertelement <n x 2 x i64> undef, i64 404, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %dd, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %index = add <n x 2 x i64> %5, %3
  store <n x 2 x i64> %index, <n x 2 x i64>* %addr
  ret void
}

;; Zeros

; Zeros are represented as SERIES_VECTORs at the DAG level.

define void @zero_p(<n x 16 x i1> *%addr) {
; CHECK-LABEL: zero_p:
; CHECK: pfalse [[RES:p[0-9]+]].b
; CHECK: str [[RES]],
; CHECK: ret
  store <n x 16 x i1> zeroinitializer, <n x 16 x i1> *%addr

  ret void
}

define void @zero_b(<n x 16 x i8> *%addr) {
; CHECK-LABEL: zero_b:
; CHECK: mov [[RES:z[0-9]+]].b, #0
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  store <n x 16 x i8> zeroinitializer, <n x 16 x i8> *%addr

  ret void
}

define void @zero_h(<n x 8 x i16> *%addr) {
; CHECK-LABEL: zero_h:
; CHECK: mov [[RES:z[0-9]+]].h, #0
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  store <n x 8 x i16> zeroinitializer, <n x 8 x i16> *%addr

  ret void
}

define void @zero_s(<n x 4 x i32> *%addr) {
; CHECK-LABEL: zero_s:
; CHECK: mov [[RES:z[0-9]+]].s, #0
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  store <n x 4 x i32> zeroinitializer, <n x 4 x i32> *%addr

  ret void
}

define void @zero_d(<n x 2 x i64> *%addr) {
; CHECK-LABEL: zero_d:
; CHECK: mov [[RES:z[0-9]+]].d, #0
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  store <n x 2 x i64> zeroinitializer, <n x 2 x i64> *%addr

  ret void
}

define void @zero_ptr(<n x 2 x i8*> *%addr) {
; CHECK-LABEL: zero_ptr:
; CHECK: mov [[RES:z[0-9]+]].d, #0
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  store <n x 2 x i8*> zeroinitializer, <n x 2 x i8*> *%addr

  ret void
}

; Splits of wide vectors into SVE-sized vectors.

define void @split_i8(<n x 32 x i8>* %a, i8 %start, i8 %step) {
; CHECK-LABEL: split_i8:
; CHECK-DAG: index [[LO:z[0-9]+]].b, w1, w2
; CHECK-DAG: st1b {[[LO]].b},
; CHECK-DAG: rdvl x[[SIZE_B:[0-9]+]]
; CHECK-DAG: madd [[HISTART:w[0-9]+]], w[[SIZE_B]], w2, w1
;            ^^ w2, w[[SIZE_B]] would also be OK
; CHECK-DAG: index [[HI:z[0-9]+]].b, [[HISTART]], w2
; CHECK-DAG: st1b {[[HI]].b},
; CHECK: ret
  %1 = insertelement <n x 32 x i8> undef, i8 %step, i32 0
  %2 = shufflevector <n x 32 x i8> %1, <n x 32 x i8> undef, <n x 32 x i32> zeroinitializer
  %3 = mul <n x 32 x i8> %2, stepvector
  %4 = insertelement <n x 32 x i8> undef, i8 %start, i32 0
  %5 = shufflevector <n x 32 x i8> %4, <n x 32 x i8> undef, <n x 32 x i32> zeroinitializer
  %res = add <n x 32 x i8> %5, %3
  store <n x 32 x i8> %res, <n x 32 x i8>* %a
  ret void
}

define void @split_i16(<n x 16 x i16>* %a, i16 %start, i16 %step) {
; CHECK-LABEL: split_i16:
; CHECK-DAG: index [[LO:z[0-9]+]].h, w1, w2
; CHECK-DAG: st1h {[[LO]].h},
; CHECK-DAG: cnth x[[SIZE:[0-9]+]]
; CHECK-DAG: madd [[HISTART:w[0-9]+]], w[[SIZE]], w2, w1
;            ^^ w2, w[[SIZE]] would also be OK
; CHECK-DAG: index [[HI:z[0-9]+]].h, [[HISTART]], w2
; CHECK-DAG: st1h {[[HI]].h},
; CHECK: ret
  %1 = insertelement <n x 16 x i16> undef, i16 %step, i32 0
  %2 = shufflevector <n x 16 x i16> %1, <n x 16 x i16> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i16> %2, stepvector
  %4 = insertelement <n x 16 x i16> undef, i16 %start, i32 0
  %5 = shufflevector <n x 16 x i16> %4, <n x 16 x i16> undef, <n x 16 x i32> zeroinitializer
  %res = add <n x 16 x i16> %5, %3
  store <n x 16 x i16> %res, <n x 16 x i16>* %a
  ret void
}

define void @split_i32(<n x 8 x i32>* %a, i32 %start, i32 %step) {
; CHECK-LABEL: split_i32:
; CHECK-DAG: index [[LO:z[0-9]+]].s, w1, w2
; CHECK-DAG: st1w {[[LO]].s},
; CHECK-DAG: cntw x[[SIZE:[0-9]+]]
; CHECK-DAG: madd [[HISTART:w[0-9]+]], w[[SIZE]], w2, w1
;            ^^ w2, w[[SIZE]] would also be OK
; CHECK-DAG: index [[HI:z[0-9]+]].s, [[HISTART]], w2
; CHECK-DAG: st1w {[[HI]].s},
; CHECK: ret
  %1 = insertelement <n x 8 x i32> undef, i32 %step, i32 0
  %2 = shufflevector <n x 8 x i32> %1, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i32> %2, stepvector
  %4 = insertelement <n x 8 x i32> undef, i32 %start, i32 0
  %5 = shufflevector <n x 8 x i32> %4, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %res = add <n x 8 x i32> %5, %3
  store <n x 8 x i32> %res, <n x 8 x i32>* %a
  ret void
}

define void @split_i64(<n x 4 x i64>* %a, i64 %start, i64 %step) {
; CHECK-LABEL: split_i64:
; CHECK-DAG: index [[LO:z[0-9]+]].d, x1, x2
; CHECK-DAG: st1d {[[LO]].d},
; CHECK-DAG: cntd [[SIZE:x[0-9]+]]
; CHECK-DAG: madd [[HISTART:x[0-9]+]], [[SIZE]], x2, x1
;            ^^ x2, [[SIZE]] would also be OK
; CHECK-DAG: index [[HI:z[0-9]+]].d, [[HISTART]], x2
; CHECK-DAG: st1d {[[HI]].d},
; CHECK: ret
  %1 = insertelement <n x 4 x i64> undef, i64 %step, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %start, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %res = add <n x 4 x i64> %5, %3
  store <n x 4 x i64> %res, <n x 4 x i64>* %a
  ret void
}

define void @split_inc_one(<n x 32 x i8>* %a, i8 %start) {
; CHECK-LABEL: split_inc_one:
; CHECK-DAG: index [[LO:z[0-9]+]].b, w1,
; CHECK-DAG: st1b {[[LO]].b},
; CHECK-DAG: addvl x[[HISTART:[0-9]+]], x1, #1
; CHECK-DAG: index [[HI:z[0-9]+]].b, w[[HISTART]],
; CHECK-DAG: st1b {[[HI]].b},
; CHECK: ret
  %1 = insertelement <n x 32 x i8> undef, i8 1, i32 0
  %2 = shufflevector <n x 32 x i8> %1, <n x 32 x i8> undef, <n x 32 x i32> zeroinitializer
  %3 = mul <n x 32 x i8> %2, stepvector
  %4 = insertelement <n x 32 x i8> undef, i8 %start, i32 0
  %5 = shufflevector <n x 32 x i8> %4, <n x 32 x i8> undef, <n x 32 x i32> zeroinitializer
  %res = add <n x 32 x i8> %5, %3
  store <n x 32 x i8> %res, <n x 32 x i8>* %a
  ret void
}
