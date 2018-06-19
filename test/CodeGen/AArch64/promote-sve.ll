; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define void @sext_b_to_h(<n x 8 x i16> *%a, <n x 8 x i8> *%b) {
; CHECK-LABEL: sext_b_to_h:
; CHECK: ptrue [[PRED:p[0-9]+]].h
; CHECK: ld1sb {[[IN:z[0-9]+]].h}, [[PRED]]/z, [x1]
; CHECK: st1h {[[IN]].h},
; CHECK: ret
  %in = load <n x 8 x i8> , <n x 8 x i8> *%b
  %res = sext <n x 8 x i8> %in to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @sext_b_to_s(<n x 4 x i32> *%a, <n x 4 x i8> *%b) {
; CHECK-LABEL: sext_b_to_s:
; CHECK: ptrue [[PRED:p[0-9]+]].s
; CHECK: ld1sb {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK: st1w {[[IN]].s},
; CHECK: ret
  %in = load <n x 4 x i8> , <n x 4 x i8> *%b
  %res = sext <n x 4 x i8> %in to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @sext_b_to_d(<n x 2 x i64> *%a, <n x 2 x i8> *%b) {
; CHECK-LABEL: sext_b_to_d:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK: ld1sb {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1d {[[IN]].d},
; CHECK: ret
  %in = load <n x 2 x i8> , <n x 2 x i8> *%b
  %res = sext <n x 2 x i8> %in to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @sext_h_to_s(<n x 4 x i32> *%a, <n x 4 x i16> *%b) {
; CHECK-LABEL: sext_h_to_s:
; CHECK: ptrue [[PRED:p[0-9]+]].s
; CHECK: ld1sh {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK: st1w {[[IN]].s},
; CHECK: ret
  %in = load <n x 4 x i16> , <n x 4 x i16> *%b
  %res = sext <n x 4 x i16> %in to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @sext_h_to_d(<n x 2 x i64> *%a, <n x 2 x i16> *%b) {
; CHECK-LABEL: sext_h_to_d:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK: ld1sh {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1d {[[IN]].d},
; CHECK: ret
  %in = load <n x 2 x i16> , <n x 2 x i16> *%b
  %res = sext <n x 2 x i16> %in to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @sext_s_to_d(<n x 2 x i64> *%a, <n x 2 x i32> *%b) {
; CHECK-LABEL: sext_s_to_d:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK: ld1sw {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1d {[[IN]].d},
; CHECK: ret
  %in = load <n x 2 x i32> , <n x 2 x i32> *%b
  %res = sext <n x 2 x i32> %in to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @zext_b_to_h(<n x 8 x i16> *%a, <n x 8 x i8> *%b) {
; CHECK-LABEL: zext_b_to_h:
; CHECK: ptrue [[PRED:p[0-9]+]].h
; CHECK: ld1b {[[IN:z[0-9]+]].h}, [[PRED]]/z, [x1]
; CHECK: st1h {[[IN]].h},
; CHECK: ret
  %in = load <n x 8 x i8> , <n x 8 x i8> *%b
  %res = zext <n x 8 x i8> %in to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @zext_b_to_s(<n x 4 x i32> *%a, <n x 4 x i8> *%b) {
; CHECK-LABEL: zext_b_to_s:
; CHECK: ptrue [[PRED:p[0-9]+]].s
; CHECK: ld1b {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK: st1w {[[IN]].s},
; CHECK: ret
  %in = load <n x 4 x i8> , <n x 4 x i8> *%b
  %res = zext <n x 4 x i8> %in to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @zext_b_to_d(<n x 2 x i64> *%a, <n x 2 x i8> *%b) {
; CHECK-LABEL: zext_b_to_d:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK: ld1b {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1d {[[IN]].d},
; CHECK: ret
  %in = load <n x 2 x i8> , <n x 2 x i8> *%b
  %res = zext <n x 2 x i8> %in to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @zext_h_to_s(<n x 4 x i32> *%a, <n x 4 x i16> *%b) {
; CHECK-LABEL: zext_h_to_s:
; CHECK: ptrue [[PRED:p[0-9]+]].s
; CHECK: ld1h {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK: st1w {[[IN]].s},
; CHECK: ret
  %in = load <n x 4 x i16> , <n x 4 x i16> *%b
  %res = zext <n x 4 x i16> %in to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @zext_h_to_d(<n x 2 x i64> *%a, <n x 2 x i16> *%b) {
; CHECK-LABEL: zext_h_to_d:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK: ld1h {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1d {[[IN]].d},
; CHECK: ret
  %in = load <n x 2 x i16> , <n x 2 x i16> *%b
  %res = zext <n x 2 x i16> %in to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @zext_s_to_d(<n x 2 x i64> *%a, <n x 2 x i32> *%b) {
; CHECK-LABEL: zext_s_to_d:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1w {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1d {[[IN]].d},
; CHECK: ret
  %in = load <n x 2 x i32> , <n x 2 x i32> *%b
  %res = zext <n x 2 x i32> %in to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @trunc_h_to_b(<n x 8 x i8> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: trunc_h_to_b:
; CHECK: ptrue [[PRED:p[0-9]+]].h
; CHECK: ld1h {[[IN:z[0-9]+]].h}, [[PRED]]/z, [x1]
; CHECK: st1b {[[IN]].h}, [[PRED]], [x0]
; CHECK: ret
  %in = load <n x 8 x i16> , <n x 8 x i16> *%b
  %res = trunc <n x 8 x i16> %in to <n x 8 x i8>
  store <n x 8 x i8> %res, <n x 8 x i8> *%a
  ret void
}

define void @trunc_s_to_b(<n x 4 x i8> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: trunc_s_to_b:
; CHECK: ptrue [[PRED:p[0-9]+]].s
; CHECK: ld1w {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK: st1b {[[IN]].s}, [[PRED]], [x0]
; CHECK: ret
  %in = load <n x 4 x i32> , <n x 4 x i32> *%b
  %res = trunc <n x 4 x i32> %in to <n x 4 x i8>
  store <n x 4 x i8> %res, <n x 4 x i8> *%a
  ret void
}

define void @trunc_d_to_b(<n x 2 x i8> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: trunc_d_to_b:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1b {[[IN]].d}, [[PRED]], [x0]
; CHECK: ret
  %in = load <n x 2 x i64> , <n x 2 x i64> *%b
  %res = trunc <n x 2 x i64> %in to <n x 2 x i8>
  store <n x 2 x i8> %res, <n x 2 x i8> *%a
  ret void
}

define void @trunc_s_to_h(<n x 4 x i16> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: trunc_s_to_h:
; CHECK: ptrue [[PRED:p[0-9]+]].s
; CHECK: ld1w {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK: st1h {[[IN]].s}, [[PRED]], [x0]
; CHECK: ret
  %in = load <n x 4 x i32> , <n x 4 x i32> *%b
  %res = trunc <n x 4 x i32> %in to <n x 4 x i16>
  store <n x 4 x i16> %res, <n x 4 x i16> *%a
  ret void
}

define void @trunc_d_to_h(<n x 2 x i16> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: trunc_d_to_h:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1h {[[IN]].d}, [[PRED]], [x0]
; CHECK: ret
  %in = load <n x 2 x i64> , <n x 2 x i64> *%b
  %res = trunc <n x 2 x i64> %in to <n x 2 x i16>
  store <n x 2 x i16> %res, <n x 2 x i16> *%a
  ret void
}

define void @trunc_d_to_s(<n x 2 x i32> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: trunc_d_to_s:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1w {[[IN]].d}, [[PRED]], [x0]
; CHECK: ret
  %in = load <n x 2 x i64> , <n x 2 x i64> *%b
  %res = trunc <n x 2 x i64> %in to <n x 2 x i32>
  store <n x 2 x i32> %res, <n x 2 x i32> *%a
  ret void
}

define void @promote_8b(<n x 8 x i8> *%a, <n x 8 x i8> *%b, <n x 8 x i8> *%c) {
; CHECK-LABEL: promote_8b:
; CHECK: ptrue [[PRED:p[0-9]+]].h
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].h}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].h}, [[PRED]]/z, [x2]
; CHECK: add [[RES:z[0-9]+]].h, [[IN0]].h, [[IN1]].h
; CHECK: st1b {[[RES]].h}, [[PRED]], [x0]
; CHECK: ret
  %in0 = load <n x 8 x i8> , <n x 8 x i8> *%b
  %in1 = load <n x 8 x i8> , <n x 8 x i8> *%c
  %res = add <n x 8 x i8> %in0, %in1
  store <n x 8 x i8> %res, <n x 8 x i8> *%a
  ret void
}

define void @promote_4b(<n x 4 x i8> *%a, <n x 4 x i8> *%b, <n x 4 x i8> *%c) {
; CHECK-LABEL: promote_4b:
; CHECK: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].s}, [[PRED]]/z, [x2]
; CHECK: add [[RES:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK: st1b {[[RES]].s}, [[PRED]], [x0]
; CHECK: ret
  %in0 = load <n x 4 x i8> , <n x 4 x i8> *%b
  %in1 = load <n x 4 x i8> , <n x 4 x i8> *%c
  %res = add <n x 4 x i8> %in0, %in1
  store <n x 4 x i8> %res, <n x 4 x i8> *%a
  ret void
}

define void @promote_2b(<n x 2 x i8> *%a, <n x 2 x i8> *%b, <n x 2 x i8> *%c) {
; CHECK-LABEL: promote_2b:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].d}, [[PRED]]/z, [x2]
; CHECK: add [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1b {[[RES]].d}, [[PRED]], [x0]
; CHECK: ret
  %in0 = load <n x 2 x i8> , <n x 2 x i8> *%b
  %in1 = load <n x 2 x i8> , <n x 2 x i8> *%c
  %res = add <n x 2 x i8> %in0, %in1
  store <n x 2 x i8> %res, <n x 2 x i8> *%a
  ret void
}

define void @promote_4h(<n x 4 x i16> *%a, <n x 4 x i16> *%b,
                        <n x 4 x i16> *%c) {
; CHECK-LABEL: promote_4h:
; CHECK: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].s}, [[PRED]]/z, [x2]
; CHECK: add [[RES:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK: st1h {[[RES]].s}, [[PRED]], [x0]
; CHECK: ret
  %in0 = load <n x 4 x i16> , <n x 4 x i16> *%b
  %in1 = load <n x 4 x i16> , <n x 4 x i16> *%c
  %res = add <n x 4 x i16> %in0, %in1
  store <n x 4 x i16> %res, <n x 4 x i16> *%a
  ret void
}

define void @promote_2h(<n x 2 x i16> *%a, <n x 2 x i16> *%b,
                        <n x 2 x i16> *%c) {
; CHECK-LABEL: promote_2h:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].d}, [[PRED]]/z, [x2]
; CHECK: add [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1h {[[RES]].d}, [[PRED]], [x0]
; CHECK: ret
  %in0 = load <n x 2 x i16> , <n x 2 x i16> *%b
  %in1 = load <n x 2 x i16> , <n x 2 x i16> *%c
  %res = add <n x 2 x i16> %in0, %in1
  store <n x 2 x i16> %res, <n x 2 x i16> *%a
  ret void
}

define void @promote_2s(<n x 2 x i32> *%a, <n x 2 x i32> *%b,
                        <n x 2 x i32> *%c) {
; CHECK-LABEL: promote_2s:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].d}, [[PRED]]/z, [x2]
; CHECK: add [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1w {[[RES]].d}, [[PRED]], [x0]
; CHECK: ret
  %in0 = load <n x 2 x i32> , <n x 2 x i32> *%b
  %in1 = load <n x 2 x i32> , <n x 2 x i32> *%c
  %res = add <n x 2 x i32> %in0, %in1
  store <n x 2 x i32> %res, <n x 2 x i32> *%a
  ret void
}
