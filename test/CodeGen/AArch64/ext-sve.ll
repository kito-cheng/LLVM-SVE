; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

; Load normal vectors, do some arithmetic on them, then extend to double
; the width.  The idea is to test extensions that cannot be folded into
; a load.
;
; Only match the first store to %a, since it's difficult to match all
; of them without forcing a particular order.

define void @sext_b_to_h(<n x 16 x i16> *%a, <n x 16 x i8> *%b,
                         <n x 16 x i8> *%c) {
; CHECK-LABEL: sext_b_to_h:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK-DAG: sunpklo [[LO:z[0-9]+]].h, [[RES]].b
; CHECK-DAG: sunpkhi [[HI:z[0-9]+]].h, [[RES]].b
; CHECK: st1h {[[LO]].h},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %add = sub <n x 16 x i8> %in0, %in1
  %ext = sext <n x 16 x i8> %add to <n x 16 x i16>
  store <n x 16 x i16> %ext, <n x 16 x i16> *%a
  ret void
}

define void @zext_b_to_h(<n x 16 x i16> *%a, <n x 16 x i8> *%b,
                         <n x 16 x i8> *%c) {
; CHECK-LABEL: zext_b_to_h:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].h, [[RES]].b
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].h, [[RES]].b
; CHECK: st1h {[[LO]].h},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %add = sub <n x 16 x i8> %in0, %in1
  %ext = zext <n x 16 x i8> %add to <n x 16 x i16>
  store <n x 16 x i16> %ext, <n x 16 x i16> *%a
  ret void
}

define void @sext_h_to_s(<n x 8 x i32> *%a, <n x 8 x i16> *%b,
                         <n x 8 x i16> *%c) {
; CHECK-LABEL: sext_h_to_s:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].h, [[IN0]].h, [[IN1]].h
; CHECK-DAG: sunpklo [[LO:z[0-9]+]].s, [[RES]].h
; CHECK-DAG: sunpkhi [[HI:z[0-9]+]].s, [[RES]].h
; CHECK: st1w {[[LO]].s},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %add = sub <n x 8 x i16> %in0, %in1
  %ext = sext <n x 8 x i16> %add to <n x 8 x i32>
  store <n x 8 x i32> %ext, <n x 8 x i32> *%a
  ret void
}

define void @zext_h_to_s(<n x 8 x i32> *%a, <n x 8 x i16> *%b,
                         <n x 8 x i16> *%c) {
; CHECK-LABEL: zext_h_to_s:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].h, [[IN0]].h, [[IN1]].h
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].s, [[RES]].h
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].s, [[RES]].h
; CHECK: st1w {[[LO]].s},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %add = sub <n x 8 x i16> %in0, %in1
  %ext = zext <n x 8 x i16> %add to <n x 8 x i32>
  store <n x 8 x i32> %ext, <n x 8 x i32> *%a
  ret void
}

define void @sext_s_to_d(<n x 4 x i64> *%a, <n x 4 x i32> *%b,
                         <n x 4 x i32> *%c) {
; CHECK-LABEL: sext_s_to_d:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK-DAG: sunpklo [[LO:z[0-9]+]].d, [[RES]].s
; CHECK-DAG: sunpkhi [[HI:z[0-9]+]].d, [[RES]].s
; CHECK: st1d {[[LO]].d},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %add = sub <n x 4 x i32> %in0, %in1
  %ext = sext <n x 4 x i32> %add to <n x 4 x i64>
  store <n x 4 x i64> %ext, <n x 4 x i64> *%a
  ret void
}

define void @zext_s_to_d(<n x 4 x i64> *%a, <n x 4 x i32> *%b,
                         <n x 4 x i32> *%c) {
; CHECK-LABEL: zext_s_to_d:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].d, [[RES]].s
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].d, [[RES]].s
; CHECK: st1d {[[LO]].d},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %add = sub <n x 4 x i32> %in0, %in1
  %ext = zext <n x 4 x i32> %add to <n x 4 x i64>
  store <n x 4 x i64> %ext, <n x 4 x i64> *%a
  ret void
}

; Same again with quad-width vectors

define void @sext_b_to_s(<n x 16 x i32> *%a, <n x 16 x i8> *%b,
                         <n x 16 x i8> *%c) {
; CHECK-LABEL: sext_b_to_s:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK-DAG: sunpklo [[LO:z[0-9]+]].h, [[RES]].b
; CHECK-DAG: sunpkhi [[HI:z[0-9]+]].h, [[RES]].b
; CHECK-DAG: sunpklo [[LOLO:z[0-9]+]].s, [[LO]].h
; CHECK-DAG: sunpkhi {{z[0-9]+}}.s, [[LO]].h
; CHECK-DAG: sunpklo {{z[0-9]+}}.s, [[HI]].h
; CHECK-DAG: sunpkhi {{z[0-9]+}}.s, [[HI]].h
; CHECK: st1w {[[LOLO]].s},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %add = sub <n x 16 x i8> %in0, %in1
  %ext = sext <n x 16 x i8> %add to <n x 16 x i32>
  store <n x 16 x i32> %ext, <n x 16 x i32> *%a
  ret void
}

define void @zext_b_to_s(<n x 16 x i32> *%a, <n x 16 x i8> *%b,
                         <n x 16 x i8> *%c) {
; CHECK-LABEL: zext_b_to_s:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].h, [[RES]].b
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].h, [[RES]].b
; CHECK-DAG: uunpklo [[LOLO:z[0-9]+]].s, [[LO]].h
; CHECK-DAG: uunpkhi {{z[0-9]+}}.s, [[LO]].h
; CHECK-DAG: uunpklo {{z[0-9]+}}.s, [[HI]].h
; CHECK-DAG: uunpkhi {{z[0-9]+}}.s, [[HI]].h
; CHECK: st1w {[[LOLO]].s},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %add = sub <n x 16 x i8> %in0, %in1
  %ext = zext <n x 16 x i8> %add to <n x 16 x i32>
  store <n x 16 x i32> %ext, <n x 16 x i32> *%a
  ret void
}

define void @sext_h_to_d(<n x 8 x i64> *%a, <n x 8 x i16> *%b,
                         <n x 8 x i16> *%c) {
; CHECK-LABEL: sext_h_to_d:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].h, [[IN0]].h, [[IN1]].h
; CHECK-DAG: sunpklo [[LO:z[0-9]+]].s, [[RES]].h
; CHECK-DAG: sunpkhi [[HI:z[0-9]+]].s, [[RES]].h
; CHECK-DAG: sunpklo [[LOLO:z[0-9]+]].d, [[LO]].s
; CHECK-DAG: sunpkhi {{z[0-9]+}}.d, [[LO]].s
; CHECK-DAG: sunpklo {{z[0-9]+}}.d, [[HI]].s
; CHECK-DAG: sunpkhi {{z[0-9]+}}.d, [[HI]].s
; CHECK: st1d {[[LOLO]].d},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %add = sub <n x 8 x i16> %in0, %in1
  %ext = sext <n x 8 x i16> %add to <n x 8 x i64>
  store <n x 8 x i64> %ext, <n x 8 x i64> *%a
  ret void
}

define void @zext_h_to_d(<n x 8 x i64> *%a, <n x 8 x i16> *%b,
                         <n x 8 x i16> *%c) {
; CHECK-LABEL: zext_h_to_d:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].h, [[IN0]].h, [[IN1]].h
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].s, [[RES]].h
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].s, [[RES]].h
; CHECK-DAG: uunpklo [[LOLO:z[0-9]+]].d, [[LO]].s
; CHECK-DAG: uunpkhi {{z[0-9]+}}.d, [[LO]].s
; CHECK-DAG: uunpklo {{z[0-9]+}}.d, [[HI]].s
; CHECK-DAG: uunpkhi {{z[0-9]+}}.d, [[HI]].s
; CHECK: st1d {[[LOLO]].d},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %add = sub <n x 8 x i16> %in0, %in1
  %ext = zext <n x 8 x i16> %add to <n x 8 x i64>
  store <n x 8 x i64> %ext, <n x 8 x i64> *%a
  ret void
}

; And now with octo-width.

define void @sext_b_to_d(<n x 16 x i64> *%a, <n x 16 x i8> *%b,
                         <n x 16 x i8> *%c) {
; CHECK-LABEL: sext_b_to_d:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK-DAG: sunpklo [[LO:z[0-9]+]].h, [[RES]].b
; CHECK-DAG: sunpkhi [[HI:z[0-9]+]].h, [[RES]].b
; CHECK-DAG: sunpklo [[LOLO:z[0-9]+]].s, [[LO]].h
; CHECK-DAG: sunpkhi [[HILO:z[0-9]+]].s, [[LO]].h
; CHECK-DAG: sunpklo [[LOHI:z[0-9]+]].s, [[HI]].h
; CHECK-DAG: sunpkhi [[HIHI:z[0-9]+]].s, [[HI]].h
; CHECK-DAG: sunpklo [[LOLOLO:z[0-9]+]].d, [[LOLO]].s
; CHECK-DAG: sunpkhi [[HILOLO:z[0-9]+]].d, [[LOLO]].s
; CHECK-DAG: sunpklo [[LOHILO:z[0-9]+]].d, [[HILO]].s
; CHECK-DAG: sunpkhi [[HIHILO:z[0-9]+]].d, [[HILO]].s
; CHECK-DAG: sunpklo [[LOLOHI:z[0-9]+]].d, [[LOHI]].s
; CHECK-DAG: sunpkhi [[HILOHI:z[0-9]+]].d, [[LOHI]].s
; CHECK-DAG: sunpklo [[LOHIHI:z[0-9]+]].d, [[HIHI]].s
; CHECK-DAG: sunpkhi [[HIHIHI:z[0-9]+]].d, [[HIHI]].s
; CHECK-DAG: st1d {[[LOLOLO]].d},
; CHECK-DAG: st1d {[[HILOLO]].d},
; CHECK-DAG: st1d {[[LOHILO]].d},
; CHECK-DAG: st1d {[[HIHILO]].d},
; CHECK-DAG: st1d {[[LOLOHI]].d},
; CHECK-DAG: st1d {[[HILOHI]].d},
; CHECK-DAG: st1d {[[LOHIHI]].d},
; CHECK-DAG: st1d {[[HIHIHI]].d},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %add = sub <n x 16 x i8> %in0, %in1
  %ext = sext <n x 16 x i8> %add to <n x 16 x i64>
  store <n x 16 x i64> %ext, <n x 16 x i64> *%a
  ret void
}

define void @zext_b_to_d(<n x 16 x i64> *%a, <n x 16 x i8> *%b,
                         <n x 16 x i8> *%c) {
; CHECK-LABEL: zext_b_to_d:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: sub [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].h, [[RES]].b
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].h, [[RES]].b
; CHECK-DAG: uunpklo [[LOLO:z[0-9]+]].s, [[LO]].h
; CHECK-DAG: uunpkhi [[HILO:z[0-9]+]].s, [[LO]].h
; CHECK-DAG: uunpklo [[LOHI:z[0-9]+]].s, [[HI]].h
; CHECK-DAG: uunpkhi [[HIHI:z[0-9]+]].s, [[HI]].h
; CHECK-DAG: uunpklo [[LOLOLO:z[0-9]+]].d, [[LOLO]].s
; CHECK-DAG: uunpkhi [[HILOLO:z[0-9]+]].d, [[LOLO]].s
; CHECK-DAG: uunpklo [[LOHILO:z[0-9]+]].d, [[HILO]].s
; CHECK-DAG: uunpkhi [[HIHILO:z[0-9]+]].d, [[HILO]].s
; CHECK-DAG: uunpklo [[LOLOHI:z[0-9]+]].d, [[LOHI]].s
; CHECK-DAG: uunpkhi [[HILOHI:z[0-9]+]].d, [[LOHI]].s
; CHECK-DAG: uunpklo [[LOHIHI:z[0-9]+]].d, [[HIHI]].s
; CHECK-DAG: uunpkhi [[HIHIHI:z[0-9]+]].d, [[HIHI]].s
; CHECK-DAG: st1d {[[LOLOLO]].d},
; CHECK-DAG: st1d {[[HILOLO]].d},
; CHECK-DAG: st1d {[[LOHILO]].d},
; CHECK-DAG: st1d {[[HIHILO]].d},
; CHECK-DAG: st1d {[[LOLOHI]].d},
; CHECK-DAG: st1d {[[HILOHI]].d},
; CHECK-DAG: st1d {[[LOHIHI]].d},
; CHECK-DAG: st1d {[[HIHIHI]].d},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %add = sub <n x 16 x i8> %in0, %in1
  %ext = zext <n x 16 x i8> %add to <n x 16 x i64>
  store <n x 16 x i64> %ext, <n x 16 x i64> *%a
  ret void
}

; Load partial vectors and sign/zero extend them before storing.
; This should come for free in sve.

define void @sextload_8b_to_8h(<n x 8 x i16> *%a, <n x 8 x i8> *%b) {
; CHECK-LABEL: sextload_8b_to_8h:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].h
; CHECK-DAG: ld1sb {[[LD:z[0-9]+]].h}, [[PRED]]/z, [x1]
; CHECK: st1h  {[[LD]].h},
  %in0 = load <n x 8 x i8> , <n x 8 x i8> *%b
  %ext = sext <n x 8 x i8> %in0 to <n x 8 x i16>
  store <n x 8 x i16> %ext, <n x 8 x i16> *%a
  ret void
}

define void @sextload_4b_to_4s(<n x 4 x i32> *%a, <n x 4 x i8> *%b) {
; CHECK-LABEL: sextload_4b_to_4s:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1sb {[[LD:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK: st1w {[[LD]].s},
  %in0 = load <n x 4 x i8> , <n x 4 x i8> *%b
  %ext = sext <n x 4 x i8> %in0 to <n x 4 x i32>
  store <n x 4 x i32> %ext, <n x 4 x i32> *%a
  ret void
}

define void @sextload_2b_to_2d(<n x 2 x i64> *%a, <n x 2 x i8> *%b) {
; CHECK-LABEL: sextload_2b_to_2d:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1sb {[[LD:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1d {[[LD]].d},
  %in0 = load <n x 2 x i8> , <n x 2 x i8> *%b
  %ext = sext <n x 2 x i8> %in0 to <n x 2 x i64>
  store <n x 2 x i64> %ext, <n x 2 x i64> *%a
  ret void
}

define void @sextload_4h_to_4s(<n x 4 x i32> *%a, <n x 4 x i16> *%b) {
; CHECK-LABEL: sextload_4h_to_4s:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1sh {[[LD:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK: st1w {[[LD]].s},
  %in0 = load <n x 4 x i16> , <n x 4 x i16> *%b
  %ext = sext <n x 4 x i16> %in0 to <n x 4 x i32>
  store <n x 4 x i32> %ext, <n x 4 x i32> *%a
  ret void
}

define void @sextload_2h_to_2d(<n x 2 x i64> *%a, <n x 2 x i16> *%b) {
; CHECK-LABEL: sextload_2h_to_2d:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1sh {[[LD:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1d {[[LD]].d},
  %in0 = load <n x 2 x i16> , <n x 2 x i16> *%b
  %ext = sext <n x 2 x i16> %in0 to <n x 2 x i64>
  store <n x 2 x i64> %ext, <n x 2 x i64> *%a
  ret void
}

define void @sextload_2s_to_2d(<n x 2 x i64> *%a, <n x 2 x i32> *%b) {
; CHECK-LABEL: sextload_2s_to_2d:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1sw {[[LD:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1d {[[LD]].d},
  %in0 = load <n x 2 x i32> , <n x 2 x i32> *%b
  %ext = sext <n x 2 x i32> %in0 to <n x 2 x i64>
  store <n x 2 x i64> %ext, <n x 2 x i64> *%a
  ret void
}

; Load partial vectors, do a mathmatical operation on them and sign/zero
; the result. This should result in an explicit sign/zero extend operation,
; either implemented by the sxt(b|h|s) or 'and' operation for sign and
; zero extension respectively.

define void @sext_8b_to_8h(<n x 8 x i16> *%a, <n x 8 x i8> *%b, <n x 8 x i8> *%c) {
; CHECK-LABEL: sext_8b_to_8h:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].h
; CHECK-DAG: ld1b  {[[IN0:z[0-9]+]].h}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1b  {[[IN1:z[0-9]+]].h}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1h  {[[OUT:z[0-9]+]].h}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].h, [[IN0]].h, [[IN1]].h
; CHECK-DAG: sxtb  [[EXT:z[0-9]+]].h, [[PRED]]/m, [[SUB0]].h
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].h, [[OUT]].h, [[EXT]].h
; CHECK: st1h {[[SUB1]].h},
  %in0 = load <n x 8 x i8> , <n x 8 x i8> *%b
  %in1 = load <n x 8 x i8> , <n x 8 x i8> *%c
  %add = sub <n x 8 x i8> %in0, %in1
  %ext = sext <n x 8 x i8> %add to <n x 8 x i16>
  %in2 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %add2 = sub <n x 8 x i16> %in2, %ext
  store <n x 8 x i16> %add2, <n x 8 x i16> *%a
  ret void
}

define void @zext_8b_to_8h(<n x 8 x i16> *%a, <n x 8 x i8> *%b, <n x 8 x i8> *%c) {
; CHECK-LABEL: zext_8b_to_8h:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].h
; CHECK-DAG: ld1b  {[[IN0:z[0-9]+]].h}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1b  {[[IN1:z[0-9]+]].h}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1h  {[[OUT:z[0-9]+]].h}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].h, [[IN0]].h, [[IN1]].h
; CHECK-DAG: and   [[EXT:z[0-9]+]].h, [[SUB0]].h, #0xff
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].h, [[OUT]].h, [[EXT]].h
; CHECK: st1h {[[SUB1]].h},
  %in0 = load <n x 8 x i8> , <n x 8 x i8> *%b
  %in1 = load <n x 8 x i8> , <n x 8 x i8> *%c
  %add = sub <n x 8 x i8> %in0, %in1
  %ext = zext <n x 8 x i8> %add to <n x 8 x i16>
  %in2 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %add2 = sub <n x 8 x i16> %in2, %ext
  store <n x 8 x i16> %add2, <n x 8 x i16> *%a
  ret void
}

define void @sext_4b_to_4s(<n x 4 x i32> *%a, <n x 4 x i8> *%b, <n x 4 x i8> *%c) {
; CHECK-LABEL: sext_4b_to_4s:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1b  {[[IN0:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1b  {[[IN1:z[0-9]+]].s}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1w  {[[OUT:z[0-9]+]].s}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK-DAG: sxtb  [[EXT:z[0-9]+]].s, [[PRED]]/m, [[SUB0]].s
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].s, [[OUT]].s, [[EXT]].s
; CHECK-DAG: st1w  {[[SUB1]].s},
  %in0 = load <n x 4 x i8> , <n x 4 x i8> *%b
  %in1 = load <n x 4 x i8> , <n x 4 x i8> *%c
  %add = sub <n x 4 x i8> %in0, %in1
  %ext = sext <n x 4 x i8> %add to <n x 4 x i32>
  %in2 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %add2 = sub <n x 4 x i32> %in2, %ext
  store <n x 4 x i32> %add2, <n x 4 x i32> *%a
  ret void
}

define void @zext_4b_to_4s(<n x 4 x i32> *%a, <n x 4 x i8> *%b, <n x 4 x i8> *%c) {
; CHECK-LABEL: zext_4b_to_4s:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1b  {[[IN0:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1b  {[[IN1:z[0-9]+]].s}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1w  {[[OUT:z[0-9]+]].s}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK-DAG: and   [[EXT:z[0-9]+]].s, [[SUB0]].s, #0xff
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].s, [[OUT]].s, [[EXT]].s
; CHECK-DAG: st1w  {[[SUB1]].s},
  %in0 = load <n x 4 x i8> , <n x 4 x i8> *%b
  %in1 = load <n x 4 x i8> , <n x 4 x i8> *%c
  %add = sub <n x 4 x i8> %in0, %in1
  %ext = zext <n x 4 x i8> %add to <n x 4 x i32>
  %in2 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %add2 = sub <n x 4 x i32> %in2, %ext
  store <n x 4 x i32> %add2, <n x 4 x i32> *%a
  ret void
}

define void @sext_2b_to_2d(<n x 2 x i64> *%a, <n x 2 x i8> *%b, <n x 2 x i8> *%c) {
; CHECK-LABEL: sext_2b_to_2d:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1b  {[[IN0:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1b  {[[IN1:z[0-9]+]].d}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1d  {[[OUT:z[0-9]+]].d}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK-DAG: sxtb  [[EXT:z[0-9]+]].d, [[PRED]]/m, [[SUB0]].d
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].d, [[OUT]].d, [[EXT]].d
; CHECK-DAG: st1d  {[[SUB1]].d},
  %in0 = load <n x 2 x i8> , <n x 2 x i8> *%b
  %in1 = load <n x 2 x i8> , <n x 2 x i8> *%c
  %add = sub <n x 2 x i8> %in0, %in1
  %ext = sext <n x 2 x i8> %add to <n x 2 x i64>
  %in2 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %add2 = sub <n x 2 x i64> %in2, %ext
  store <n x 2 x i64> %add2, <n x 2 x i64> *%a
  ret void
}

define void @zext_2b_to_2d(<n x 2 x i64> *%a, <n x 2 x i8> *%b, <n x 2 x i8> *%c) {
; CHECK-LABEL: zext_2b_to_2d:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1b  {[[IN0:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1b  {[[IN1:z[0-9]+]].d}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1d  {[[OUT:z[0-9]+]].d}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK-DAG: and   [[EXT:z[0-9]+]].d, [[SUB0]].d, #0xff
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].d, [[OUT]].d, [[EXT]].d
; CHECK-DAG: st1d  {[[SUB1]].d},
  %in0 = load <n x 2 x i8> , <n x 2 x i8> *%b
  %in1 = load <n x 2 x i8> , <n x 2 x i8> *%c
  %add = sub <n x 2 x i8> %in0, %in1
  %ext = zext <n x 2 x i8> %add to <n x 2 x i64>
  %in2 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %add2 = sub <n x 2 x i64> %in2, %ext
  store <n x 2 x i64> %add2, <n x 2 x i64> *%a
  ret void
}

define void @sext_4h_to_4s(<n x 4 x i32> *%a, <n x 4 x i16> *%b, <n x 4 x i16> *%c) {
; CHECK-LABEL: sext_4h_to_4s:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1h  {[[IN0:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1h  {[[IN1:z[0-9]+]].s}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1w  {[[OUT:z[0-9]+]].s}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK-DAG: sxth  [[EXT:z[0-9]+]].s, [[PRED]]/m, [[SUB0]].s
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].s, [[OUT]].s, [[EXT]].s
; CHECK-DAG: st1w  {[[SUB1]].s},
  %in0 = load <n x 4 x i16> , <n x 4 x i16> *%b
  %in1 = load <n x 4 x i16> , <n x 4 x i16> *%c
  %add = sub <n x 4 x i16> %in0, %in1
  %ext = sext <n x 4 x i16> %add to <n x 4 x i32>
  %in2 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %add2 = sub <n x 4 x i32> %in2, %ext
  store <n x 4 x i32> %add2, <n x 4 x i32> *%a
  ret void
}

define void @zext_4h_to_4s(<n x 4 x i32> *%a, <n x 4 x i16> *%b, <n x 4 x i16> *%c) {
; CHECK-LABEL: zext_4h_to_4s:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1h  {[[IN0:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1h  {[[IN1:z[0-9]+]].s}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1w  {[[OUT:z[0-9]+]].s}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK-DAG: and   [[EXT:z[0-9]+]].s, [[SUB0]].s, #0xffff
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].s, [[OUT]].s, [[EXT]].s
; CHECK-DAG: st1w  {[[SUB1]].s},
  %in0 = load <n x 4 x i16> , <n x 4 x i16> *%b
  %in1 = load <n x 4 x i16> , <n x 4 x i16> *%c
  %add = sub <n x 4 x i16> %in0, %in1
  %ext = zext <n x 4 x i16> %add to <n x 4 x i32>
  %in2 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %add2 = sub <n x 4 x i32> %in2, %ext
  store <n x 4 x i32> %add2, <n x 4 x i32> *%a
  ret void
}

define void @sext_2h_to_2d(<n x 2 x i64> *%a, <n x 2 x i16> *%b, <n x 2 x i16> *%c) {
; CHECK-LABEL: sext_2h_to_2d:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1h  {[[IN0:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1h  {[[IN1:z[0-9]+]].d}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1d  {[[OUT:z[0-9]+]].d}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK-DAG: sxth  [[EXT:z[0-9]+]].d, [[PRED]]/m, [[SUB0]].d
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].d, [[OUT]].d, [[EXT]].d
; CHECK-DAG: st1d  {[[SUB1]].d},
  %in0 = load <n x 2 x i16> , <n x 2 x i16> *%b
  %in1 = load <n x 2 x i16> , <n x 2 x i16> *%c
  %add = sub <n x 2 x i16> %in0, %in1
  %ext = sext <n x 2 x i16> %add to <n x 2 x i64>
  %in2 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %add2 = sub <n x 2 x i64> %in2, %ext
  store <n x 2 x i64> %add2, <n x 2 x i64> *%a
  ret void
}

define void @zext_2h_to_2d(<n x 2 x i64> *%a, <n x 2 x i16> *%b, <n x 2 x i16> *%c) {
; CHECK-LABEL: zext_2h_to_2d:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1h  {[[IN0:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1h  {[[IN1:z[0-9]+]].d}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1d  {[[OUT:z[0-9]+]].d}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK-DAG: and   [[EXT:z[0-9]+]].d, [[SUB0]].d, #0xffff
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].d, [[OUT]].d, [[EXT]].d
; CHECK-DAG: st1d  {[[SUB1]].d},
  %in0 = load <n x 2 x i16> , <n x 2 x i16> *%b
  %in1 = load <n x 2 x i16> , <n x 2 x i16> *%c
  %add = sub <n x 2 x i16> %in0, %in1
  %ext = zext <n x 2 x i16> %add to <n x 2 x i64>
  %in2 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %add2 = sub <n x 2 x i64> %in2, %ext
  store <n x 2 x i64> %add2, <n x 2 x i64> *%a
  ret void
}

define void @sext_2s_to_2d(<n x 2 x i64> *%a, <n x 2 x i32> *%b, <n x 2 x i32> *%c) {
; CHECK-LABEL: sext_2s_to_2d:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1w  {[[IN0:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1w  {[[IN1:z[0-9]+]].d}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1d  {[[OUT:z[0-9]+]].d}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK-DAG: sxtw  [[EXT:z[0-9]+]].d, [[PRED]]/m, [[SUB0]].d
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].d, [[OUT]].d, [[EXT]].d
; CHECK-DAG: st1d  {[[SUB1]].d},
  %in0 = load <n x 2 x i32> , <n x 2 x i32> *%b
  %in1 = load <n x 2 x i32> , <n x 2 x i32> *%c
  %add = sub <n x 2 x i32> %in0, %in1
  %ext = sext <n x 2 x i32> %add to <n x 2 x i64>
  %in2 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %add2 = sub <n x 2 x i64> %in2, %ext
  store <n x 2 x i64> %add2, <n x 2 x i64> *%a
  ret void
}

define void @zext_2s_to_2d(<n x 2 x i64> *%a, <n x 2 x i32> *%b, <n x 2 x i32> *%c) {
; CHECK-LABEL: zext_2s_to_2d:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1w  {[[IN0:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK-DAG: ld1w  {[[IN1:z[0-9]+]].d}, [[PRED]]/z, [x2]
; CHECK-DAG: ld1d  {[[OUT:z[0-9]+]].d}, [[PRED]]/z, [x0]
; CHECK-DAG: sub   [[SUB0:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK-DAG: and   [[EXT:z[0-9]+]].d, [[SUB0]].d, #0xffffffff
; CHECK-DAG: sub   [[SUB1:z[0-9]+]].d, [[OUT]].d, [[EXT]].d
; CHECK-DAG: st1d  {[[SUB1]].d},
  %in0 = load <n x 2 x i32> , <n x 2 x i32> *%b
  %in1 = load <n x 2 x i32> , <n x 2 x i32> *%c
  %add = sub <n x 2 x i32> %in0, %in1
  %ext = zext <n x 2 x i32> %add to <n x 2 x i64>
  %in2 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %add2 = sub <n x 2 x i64> %in2, %ext
  store <n x 2 x i64> %add2, <n x 2 x i64> *%a
  ret void
}

