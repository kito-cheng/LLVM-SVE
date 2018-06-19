; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

; CHECK-LABEL: @split_b
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[Z0:z[0-9]+]].b}, [[PG]]/z, [x0]
; CHECK-DAG: ld1b {[[Z1:z[0-9]+]].b}, [[PG]]/z, [x0, #1, mul vl]
; CHECK-DAG: st1b {[[Z0]].b}, [[PG]], [x1]
; CHECK-DAG: st1b {[[Z1]].b}, [[PG]], [x1, #1, mul vl]
define void @split_b(<n x 32 x i8> *%a, <n x 32 x i8> *%b) {
  %in = load <n x 32 x i8> , <n x 32 x i8> *%a
  store <n x 32 x i8> %in, <n x 32 x i8> *%b
  ret void
}

; CHECK-LABEL: @split_h
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[Z0:z[0-9]+]].h}, [[PG]]/z, [x0]
; CHECK-DAG: ld1h {[[Z1:z[0-9]+]].h}, [[PG]]/z, [x0, #1, mul vl]
; CHECK-DAG: st1h {[[Z0]].h}, [[PG]], [x1]
; CHECK-DAG: st1h {[[Z1]].h}, [[PG]], [x1, #1, mul vl]
define void @split_h(<n x 16 x i16> *%a, <n x 16 x i16> *%b) {
  %in = load <n x 16 x i16> , <n x 16 x i16> *%a
  store <n x 16 x i16> %in, <n x 16 x i16> *%b
  ret void
}

; CHECK-LABEL: @split_s
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[Z0:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK-DAG: ld1w {[[Z1:z[0-9]+]].s}, [[PG]]/z, [x0, #1, mul vl]
; CHECK-DAG: st1w {[[Z0]].s}, [[PG]], [x1]
; CHECK-DAG: st1w {[[Z1]].s}, [[PG]], [x1, #1, mul vl]
define void @split_s(<n x 8 x i32> *%a, <n x 8 x i32> *%b) {
  %in = load <n x 8 x i32> , <n x 8 x i32> *%a
  store <n x 8 x i32> %in, <n x 8 x i32> *%b
  ret void
}

; CHECK-LABEL: @split_d
; CHECK-DAG: ld1d {[[Z0:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK-DAG: ld1d {[[Z1:z[0-9]+]].d}, [[PG]]/z, [x0, #1, mul vl]
; CHECK-DAG: st1d {[[Z0]].d}, [[PG]], [x1]
; CHECK-DAG: st1d {[[Z1]].d}, [[PG]], [x1, #1, mul vl]
define void @split_d(<n x 4 x i64> *%a, <n x 4 x i64> *%b) {
  %in = load <n x 4 x i64> , <n x 4 x i64> *%a
  store <n x 4 x i64> %in, <n x 4 x i64> *%b
  ret void
}

; CHECK-LABEL: @split_ss
; TODO: Optimize splitress computation
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[Z0:z[0-9]+]].s}, [[PG]]/z, [x0, #3, mul vl]
; CHECK-DAG: ld1w {[[Z1:z[0-9]+]].s}, [[PG]]/z, [x0, #2, mul vl]
; CHECK-DAG: ld1w {[[Z2:z[0-9]+]].s}, [[PG]]/z, [x0, #1, mul vl]
; CHECK-DAG: ld1w {[[Z3:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK-DAG: st1w {[[Z0]].s}, [[PG]], [x1, #3, mul vl]
; CHECK-DAG: st1w {[[Z1]].s}, [[PG]], [x1, #2, mul vl]
; CHECK-DAG: st1w {[[Z2]].s}, [[PG]], [x1, #1, mul vl]
; CHECK-DAG: st1w {[[Z3]].s}, [[PG]], [x1]
define void @split_ss(<n x 16 x i32> *%a, <n x 16 x i32> *%b) {
  %in = load <n x 16 x i32> , <n x 16 x i32> *%a
  store <n x 16 x i32> %in, <n x 16 x i32> *%b
  ret void
}
