; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define void @tbl_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: tbl_b:
; CHECK-DAG: ld1b {[[INP:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[MASK:z[0-9]+]].b}, {{p[0-9]+}}/z, [x2]
; CHECK: tbl [[RES:z[0-9]+]].b, {[[INP]].b}, [[MASK]].b
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %inp = load <n x 16 x i8> , <n x 16 x i8> *%b
  %mask = load <n x 16 x i8> , <n x 16 x i8> *%c
  %res = shufflevector <n x 16 x i8> %inp, <n x 16 x i8> undef,
                       <n x 16 x i8> %mask
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @tbl_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: tbl_h:
; CHECK-DAG: ld1h {[[INP:z[0-9]+]].h}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1h {[[MASK:z[0-9]+]].h}, {{p[0-9]+}}/z, [x2]
; CHECK: tbl [[RES:z[0-9]+]].h, {[[INP]].h}, [[MASK]].h
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %inp = load <n x 8 x i16> , <n x 8 x i16> *%b
  %mask = load <n x 8 x i16> , <n x 8 x i16> *%c
  %res = shufflevector <n x 8 x i16> %inp, <n x 8 x i16> undef,
                       <n x 8 x i16> %mask
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @tbl_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: tbl_s:
; CHECK-DAG: ld1w {[[INP:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[MASK:z[0-9]+]].s}, {{p[0-9]+}}/z, [x2]
; CHECK: tbl [[RES:z[0-9]+]].s, {[[INP]].s}, [[MASK]].s
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %inp = load <n x 4 x i32> , <n x 4 x i32> *%b
  %mask = load <n x 4 x i32> , <n x 4 x i32> *%c
  %res = shufflevector <n x 4 x i32> %inp, <n x 4 x i32> undef,
                       <n x 4 x i32> %mask
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @tbl_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: tbl_d:
; CHECK-DAG: ld1d {[[INP:z[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1d {[[MASK:z[0-9]+]].d}, {{p[0-9]+}}/z, [x2]
; CHECK: tbl [[RES:z[0-9]+]].d, {[[INP]].d}, [[MASK]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %inp = load <n x 2 x i64> , <n x 2 x i64> *%b
  %mask = load <n x 2 x i64> , <n x 2 x i64> *%c
  %res = shufflevector <n x 2 x i64> %inp, <n x 2 x i64> undef,
                       <n x 2 x i64> %mask
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

; Uses an i16 mask because i8 might be too small.  It's difficult to
; reliably match the output registers in such a large CHECK-DAG block
; since the same register can be reused, potentially leading to two
; instructions having the same inputs.  That's particularly a problem
; because multiple CHECK-DAGs are allowed to match the same statement.
define void @general_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b,
                       <n x 16 x i8> *%c, <n x 16 x i16> *%d) {
; CHECK-LABEL: general_b:
; CHECK-DAG: ld1b {[[IN0T:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1T:z[0-9]+]].b}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1h {[[MASK0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: cnth x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].h, w[[WIDTH]]
; CHECK-DAG: {{[su]}}unpklo [[IN0:z[0-9]+]].h, [[IN0T]].b
; CHECK-DAG: {{[su]}}unpkhi [[IN1:z[0-9]+]].h, [[IN0T]].b
; CHECK-DAG: {{[su]}}unpklo [[IN2:z[0-9]+]].h, [[IN1T]].b
; CHECK-DAG: {{[su]}}unpkhi [[IN3:z[0-9]+]].h, [[IN1T]].b
; CHECK-DAG: sub {{z[0-9]+}}.h,
; CHECK-DAG: tbl {{z[0-9]+}}.h, {[[IN0]].h}
; CHECK-DAG: tbl {{z[0-9]+}}.h, {[[IN1]].h}
; CHECK-DAG: tbl {{z[0-9]+}}.h, {[[IN2]].h}
; CHECK-DAG: tbl {{z[0-9]+}}.h, {[[IN3]].h}
; CHECK-DAG: orr {{z[0-9]+}}.d,
; CHECK: uzp1 [[RES:z[0-9]+]].b,
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %mask = load <n x 16 x i16> , <n x 16 x i16> *%d
  %res = shufflevector <n x 16 x i8> %in0, <n x 16 x i8> %in1,
                       <n x 16 x i16> %mask
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

; Should be done on i16s.  Just check that and leave the test above
; for the full sequence.
define void @general_b_32(<n x 16 x i8> *%a, <n x 16 x i8> *%b,
                          <n x 16 x i8> *%c, <n x 16 x i32> *%d) {
; CHECK-LABEL: general_b_32:
; CHECK-DAG: ld1b {[[IN0T:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[MASK0L:z[0-9]+]].s}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: uzp1 [[MASK0:z[0-9]+]].h, [[MASK0L]].h,
; CHECK-DAG: {{[su]}}unpklo [[IN0:z[0-9]+]].h, [[IN0T]].b
; CHECK-DAG: tbl {{z[0-9]+}}.h, {[[IN0]].h}, [[MASK0]].h
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %mask = load <n x 16 x i32> , <n x 16 x i32> *%d
  %res = shufflevector <n x 16 x i8> %in0, <n x 16 x i8> %in1,
                       <n x 16 x i32> %mask
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @general_b_64(<n x 16 x i8> *%a, <n x 16 x i8> *%b,
                          <n x 16 x i8> *%c, <n x 16 x i64> *%d) {
; CHECK-LABEL: general_b_64:
; CHECK: ld1b {[[IN0T:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
; CHECK: ld1d {[[MASK0LL:z[0-9]+]].d}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: uzp1 [[MASK0L:z[0-9]+]].s, [[MASK0LL]].s, z
; CHECK-DAG: uzp1 [[MASK0:z[0-9]+]].h, [[MASK0L]].h,
; CHECK-DAG: {{[su]}}unpklo [[IN0:z[0-9]+]].h, [[IN0T]].b
; CHECK-DAG: tbl {{z[0-9]+}}.h, {[[IN0]].h}, [[MASK0]].h
; CHECK: ret

; NOTE: using volatile loads to better anchor the uzp1s
  %in0 = load volatile <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load volatile <n x 16 x i8> , <n x 16 x i8> *%c
  %mask = load <n x 16 x i64> , <n x 16 x i64> *%d
  %res = shufflevector <n x 16 x i8> %in0, <n x 16 x i8> %in1,
                       <n x 16 x i64> %mask
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @general_b_half(<n x 8 x i8> *%a, <n x 8 x i8> *%b,
                            <n x 8 x i8> *%c, <n x 8 x i8> *%d) {
; CHECK-LABEL: general_b_half:
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].h}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1b {[[MASK0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: cnth x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].h, w[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].h, [[MASK0]].h, [[SPLAT]].h
; CHECK-DAG: tbl [[PART0:z[0-9]+]].h, {[[IN0]].h}, [[MASK0]].h
; CHECK-DAG: tbl [[PART1:z[0-9]+]].h, {[[IN1]].h}, [[MASK1]].h
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1b {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i8> , <n x 8 x i8> *%b
  %in1 = load <n x 8 x i8> , <n x 8 x i8> *%c
  %mask = load <n x 8 x i8> , <n x 8 x i8> *%d
  %res = shufflevector <n x 8 x i8> %in0, <n x 8 x i8> %in1,
                       <n x 8 x i8> %mask
  store <n x 8 x i8> %res, <n x 8 x i8> *%a
  ret void
}

define void @general_b_half_16(<n x 8 x i8> *%a, <n x 8 x i8> *%b,
                               <n x 8 x i8> *%c, <n x 8 x i16> *%d) {
; CHECK-LABEL: general_b_half_16:
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].h}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1h {[[MASK0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: cnth x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].h, w[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].h, [[MASK0]].h, [[SPLAT]].h
; CHECK-DAG: tbl [[PART0:z[0-9]+]].h, {[[IN0]].h}, [[MASK0]].h
; CHECK-DAG: tbl [[PART1:z[0-9]+]].h, {[[IN1]].h}, [[MASK1]].h
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1b {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i8> , <n x 8 x i8> *%b
  %in1 = load <n x 8 x i8> , <n x 8 x i8> *%c
  %mask = load <n x 8 x i16> , <n x 8 x i16> *%d
  %res = shufflevector <n x 8 x i8> %in0, <n x 8 x i8> %in1,
                       <n x 8 x i16> %mask
  store <n x 8 x i8> %res, <n x 8 x i8> *%a
  ret void
}

define void @general_b_half_32(<n x 8 x i8> *%a, <n x 8 x i8> *%b,
                               <n x 8 x i8> *%c, <n x 8 x i32> *%d) {
; CHECK-LABEL: general_b_half_32:
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].h}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1w {[[MASK0L:z[0-9]+]].s}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: uzp1 [[MASK0:z[0-9]+]].h, [[MASK0L]].h,
; CHECK-DAG: cnth x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].h, w[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].h, [[MASK0]].h, [[SPLAT]].h
; CHECK-DAG: tbl [[PART0:z[0-9]+]].h, {[[IN0]].h}, [[MASK0]].h
; CHECK-DAG: tbl [[PART1:z[0-9]+]].h, {[[IN1]].h}, [[MASK1]].h
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1b {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i8> , <n x 8 x i8> *%b
  %in1 = load <n x 8 x i8> , <n x 8 x i8> *%c
  %mask = load <n x 8 x i32> , <n x 8 x i32> *%d
  %res = shufflevector <n x 8 x i8> %in0, <n x 8 x i8> %in1,
                       <n x 8 x i32> %mask
  store <n x 8 x i8> %res, <n x 8 x i8> *%a
  ret void
}

define void @general_b_half_64(<n x 8 x i8> *%a, <n x 8 x i8> *%b,
                               <n x 8 x i8> *%c, <n x 8 x i64> *%d) {
; CHECK-LABEL: general_b_half_64:
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].h}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1d {[[MASK0LL:z[0-9]+]].d}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: uzp1 [[MASK0L:z[0-9]+]].s, [[MASK0LL]].s,
; CHECK-DAG: uzp1 [[MASK0:z[0-9]+]].h, [[MASK0L]].h,
; CHECK-DAG: cnth x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].h, w[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].h, [[MASK0]].h, [[SPLAT]].h
; CHECK-DAG: tbl [[PART0:z[0-9]+]].h, {[[IN0]].h}, [[MASK0]].h
; CHECK-DAG: tbl [[PART1:z[0-9]+]].h, {[[IN1]].h}, [[MASK1]].h
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1b {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i8> , <n x 8 x i8> *%b
  %in1 = load <n x 8 x i8> , <n x 8 x i8> *%c
  %mask = load <n x 8 x i64> , <n x 8 x i64> *%d
  %res = shufflevector <n x 8 x i8> %in0, <n x 8 x i8> %in1,
                       <n x 8 x i64> %mask
  store <n x 8 x i8> %res, <n x 8 x i8> *%a
  ret void
}

; Just to check that it compiles -- too painful to match.
define void @general_b_double(<n x 32 x i8> *%a, <n x 32 x i8> *%b,
                              <n x 32 x i8> *%c, <n x 32 x i16> *%d) {
  %in0 = load <n x 32 x i8> , <n x 32 x i8> *%b
  %in1 = load <n x 32 x i8> , <n x 32 x i8> *%c
  %mask = load <n x 32 x i16> , <n x 32 x i16> *%d
  %res = shufflevector <n x 32 x i8> %in0, <n x 32 x i8> %in1,
                       <n x 32 x i16> %mask
  store <n x 32 x i8> %res, <n x 32 x i8> *%a
  ret void
}

define void @general_b_double_32(<n x 32 x i8> *%a, <n x 32 x i8> *%b,
                                 <n x 32 x i8> *%c, <n x 32 x i32> *%d) {
  %in0 = load <n x 32 x i8> , <n x 32 x i8> *%b
  %in1 = load <n x 32 x i8> , <n x 32 x i8> *%c
  %mask = load <n x 32 x i32> , <n x 32 x i32> *%d
  %res = shufflevector <n x 32 x i8> %in0, <n x 32 x i8> %in1,
                       <n x 32 x i32> %mask
  store <n x 32 x i8> %res, <n x 32 x i8> *%a
  ret void
}

define void @general_b_double_64(<n x 32 x i8> *%a, <n x 32 x i8> *%b,
                                 <n x 32 x i8> *%c, <n x 32 x i64> *%d) {
  %in0 = load <n x 32 x i8> , <n x 32 x i8> *%b
  %in1 = load <n x 32 x i8> , <n x 32 x i8> *%c
  %mask = load <n x 32 x i64> , <n x 32 x i64> *%d
  %res = shufflevector <n x 32 x i8> %in0, <n x 32 x i8> %in1,
                       <n x 32 x i64> %mask
  store <n x 32 x i8> %res, <n x 32 x i8> *%a
  ret void
}

define void @general_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b,
                       <n x 8 x i16> *%c, <n x 8 x i16> *%d) {
; CHECK-LABEL: general_h:
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1h {[[MASK0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: cnth x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].h, w[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].h, [[MASK0]].h, [[SPLAT]].h
; CHECK-DAG: tbl [[PART0:z[0-9]+]].h, {[[IN0]].h}, [[MASK0]].h
; CHECK-DAG: tbl [[PART1:z[0-9]+]].h, {[[IN1]].h}, [[MASK1]].h
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %mask = load <n x 8 x i16> , <n x 8 x i16> *%d
  %res = shufflevector <n x 8 x i16> %in0, <n x 8 x i16> %in1,
                       <n x 8 x i16> %mask
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @general_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b,
                       <n x 4 x i32> *%c, <n x 4 x i32> *%d) {
; CHECK-LABEL: general_s:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1w {[[MASK0:z[0-9]+]].s}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: cntw x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].s, w[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].s, [[MASK0]].s, [[SPLAT]].s
; CHECK-DAG: tbl [[PART0:z[0-9]+]].s, {[[IN0]].s}, [[MASK0]].s
; CHECK-DAG: tbl [[PART1:z[0-9]+]].s, {[[IN1]].s}, [[MASK1]].s
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %mask = load <n x 4 x i32> , <n x 4 x i32> *%d
  %res = shufflevector <n x 4 x i32> %in0, <n x 4 x i32> %in1,
                       <n x 4 x i32> %mask
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @general_s_16(<n x 4 x i32> *%a, <n x 4 x i32> *%b,
                          <n x 4 x i32> *%c, <n x 4 x i16> *%d) {
; CHECK-LABEL: general_s_16:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1h {[[MASK0:z[0-9]+]].s}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: cntw x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].s, w[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].s, [[MASK0]].s, [[SPLAT]].s
; CHECK-DAG: tbl [[PART0:z[0-9]+]].s, {[[IN0]].s}, [[MASK0]].s
; CHECK-DAG: tbl [[PART1:z[0-9]+]].s, {[[IN1]].s}, [[MASK1]].s
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %mask = load <n x 4 x i16> , <n x 4 x i16> *%d
  %res = shufflevector <n x 4 x i32> %in0, <n x 4 x i32> %in1,
                       <n x 4 x i16> %mask
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @general_s_64(<n x 4 x i32> *%a, <n x 4 x i32> *%b,
                          <n x 4 x i32> *%c, <n x 4 x i64> *%d) {
; CHECK-LABEL: general_s_64:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1d {[[MASK0L:z[0-9]+]].d}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: uzp1 [[MASK0:z[0-9]+]].s, [[MASK0L]].s,
; CHECK-DAG: cntw x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].s, w[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].s, [[MASK0]].s, [[SPLAT]].s
; CHECK-DAG: tbl [[PART0:z[0-9]+]].s, {[[IN0]].s}, [[MASK0]].s
; CHECK-DAG: tbl [[PART1:z[0-9]+]].s, {[[IN1]].s}, [[MASK1]].s
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %mask = load <n x 4 x i64> , <n x 4 x i64> *%d
  %res = shufflevector <n x 4 x i32> %in0, <n x 4 x i32> %in1,
                       <n x 4 x i64> %mask
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @general_s_half(<n x 2 x i32> *%a, <n x 2 x i32> *%b,
                            <n x 2 x i32> *%c, <n x 2 x i32> *%d) {
; CHECK-LABEL: general_s_half:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].d}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1w {[[MASK0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: cntd x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].d, x[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].d, [[MASK0]].d, [[SPLAT]].d
; CHECK-DAG: tbl [[PART0:z[0-9]+]].d, {[[IN0]].d}, [[MASK0]].d
; CHECK-DAG: tbl [[PART1:z[0-9]+]].d, {[[IN1]].d}, [[MASK1]].d
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1w {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i32> , <n x 2 x i32> *%b
  %in1 = load <n x 2 x i32> , <n x 2 x i32> *%c
  %mask = load <n x 2 x i32> , <n x 2 x i32> *%d
  %res = shufflevector <n x 2 x i32> %in0, <n x 2 x i32> %in1,
                       <n x 2 x i32> %mask
  store <n x 2 x i32> %res, <n x 2 x i32> *%a
  ret void
}

define void @general_s_half_16(<n x 2 x i32> *%a, <n x 2 x i32> *%b,
                               <n x 2 x i32> *%c, <n x 2 x i16> *%d) {
; CHECK-LABEL: general_s_half_16:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].d}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1h {[[MASK0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: cntd x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].d, x[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].d, [[MASK0]].d, [[SPLAT]].d
; CHECK-DAG: tbl [[PART0:z[0-9]+]].d, {[[IN0]].d}, [[MASK0]].d
; CHECK-DAG: tbl [[PART1:z[0-9]+]].d, {[[IN1]].d}, [[MASK1]].d
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1w {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i32> , <n x 2 x i32> *%b
  %in1 = load <n x 2 x i32> , <n x 2 x i32> *%c
  %mask = load <n x 2 x i16> , <n x 2 x i16> *%d
  %res = shufflevector <n x 2 x i32> %in0, <n x 2 x i32> %in1,
                       <n x 2 x i16> %mask
  store <n x 2 x i32> %res, <n x 2 x i32> *%a
  ret void
}

define void @general_s_half_64(<n x 2 x i32> *%a, <n x 2 x i32> *%b,
                               <n x 2 x i32> *%c, <n x 2 x i64> *%d) {
; CHECK-LABEL: general_s_half_64:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].d}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1d {[[MASK0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: cntd x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].d, x[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].d, [[MASK0]].d, [[SPLAT]].d
; CHECK-DAG: tbl [[PART0:z[0-9]+]].d, {[[IN0]].d}, [[MASK0]].d
; CHECK-DAG: tbl [[PART1:z[0-9]+]].d, {[[IN1]].d}, [[MASK1]].d
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1w {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i32> , <n x 2 x i32> *%b
  %in1 = load <n x 2 x i32> , <n x 2 x i32> *%c
  %mask = load <n x 2 x i64> , <n x 2 x i64> *%d
  %res = shufflevector <n x 2 x i32> %in0, <n x 2 x i32> %in1,
                       <n x 2 x i64> %mask
  store <n x 2 x i32> %res, <n x 2 x i32> *%a
  ret void
}

; See comment above general_b for the lack of matching.
define void @general_s_double(<n x 8 x i32> *%a, <n x 8 x i32> *%b,
                              <n x 8 x i32> *%c, <n x 8 x i32> *%d) {
; CHECK-LABEL: general_s_double:
; CHECK-NOT: unpk
; CHECK-NOT: uzp
; CHECK: ret
  %in0 = load <n x 8 x i32> , <n x 8 x i32> *%b
  %in1 = load <n x 8 x i32> , <n x 8 x i32> *%c
  %mask = load <n x 8 x i32> , <n x 8 x i32> *%d
  %res = shufflevector <n x 8 x i32> %in0, <n x 8 x i32> %in1,
                       <n x 8 x i32> %mask
  store <n x 8 x i32> %res, <n x 8 x i32> *%a
  ret void
}

; The mask should be extended to i32s.
define void @general_s_double_16(<n x 8 x i32> *%a, <n x 8 x i32> *%b,
                                 <n x 8 x i32> *%c, <n x 8 x i16> *%d) {
; CHECK-LABEL: general_s_double_16:
; CHECK-NOT: uzp
; CHECK-DAG: uunpklo {{z[0-9]+}}.s,
; CHECK-DAG: uunpkhi {{z[0-9]+}}.s,
; CHECK-NOT: uzp
; CHECK: ret
  %in0 = load <n x 8 x i32> , <n x 8 x i32> *%b
  %in1 = load <n x 8 x i32> , <n x 8 x i32> *%c
  %mask = load <n x 8 x i16> , <n x 8 x i16> *%d
  %res = shufflevector <n x 8 x i32> %in0, <n x 8 x i32> %in1,
                       <n x 8 x i16> %mask
  store <n x 8 x i32> %res, <n x 8 x i32> *%a
  ret void
}

; The mask should be truncated to i32s.
define void @general_s_double_64(<n x 8 x i32> *%a, <n x 8 x i32> *%b,
                                 <n x 8 x i32> *%c, <n x 8 x i64> *%d) {
; CHECK-LABEL: general_s_double_64:
; CHECK-NOT: unpk
; CHECK: uzp1 {{z[0-9]+}}.s,
; CHECK-NOT: unpk
; CHECK: uzp1 {{z[0-9]+}}.s,
; CHECK-NOT: unpk
; CHECK: ret
  %in0 = load <n x 8 x i32> , <n x 8 x i32> *%b
  %in1 = load <n x 8 x i32> , <n x 8 x i32> *%c
  %mask = load <n x 8 x i64> , <n x 8 x i64> *%d
  %res = shufflevector <n x 8 x i32> %in0, <n x 8 x i32> %in1,
                       <n x 8 x i64> %mask
  store <n x 8 x i32> %res, <n x 8 x i32> *%a
  ret void
}

define void @general_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b,
                       <n x 2 x i64> *%c, <n x 2 x i64> *%d) {
; CHECK-LABEL: general_d:
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: ld1d {[[MASK0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x3]
; CHECK-DAG: cntd x[[WIDTH:[0-9]+]]
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].d, x[[WIDTH]]
; CHECK-DAG: sub [[MASK1:z[0-9]+]].d, [[MASK0]].d, [[SPLAT]].d
; CHECK-DAG: tbl [[PART0:z[0-9]+]].d, {[[IN0]].d}, [[MASK0]].d
; CHECK-DAG: tbl [[PART1:z[0-9]+]].d, {[[IN1]].d}, [[MASK1]].d
; CHECK: orr [[RES:z[0-9]+]].d, [[PART0]].d, [[PART1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %mask = load <n x 2 x i64> , <n x 2 x i64> *%d
  %res = shufflevector <n x 2 x i64> %in0, <n x 2 x i64> %in1,
                       <n x 2 x i64> %mask
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @uzp1_b_16(<n x 16 x i8>* %a, <n x 16 x i8>* %b, <n x 16 x i8>* %c) {
; CHECK-LABEL: uzp1_b_16:
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp1 [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8>, <n x 16 x i8>* %b
  %in1 = load <n x 16 x i8>, <n x 16 x i8>* %c
  %1 = insertelement <n x 16 x i16> undef, i16 2, i32 0
  %2 = shufflevector <n x 16 x i16> %1, <n x 16 x i16> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i16> %2, stepvector
  %4 = insertelement <n x 16 x i16> undef, i16 0, i32 0
  %5 = shufflevector <n x 16 x i16> %4, <n x 16 x i16> undef, <n x 16 x i32> zeroinitializer
  %mask = add <n x 16 x i16> %5, %3
  %res = shufflevector <n x 16 x i8> %in0, <n x 16 x i8> %in1, <n x 16 x i16> %mask
  store <n x 16 x i8> %res, <n x 16 x i8>* %a
  ret void
}

define void @uzp1_b_32(<n x 16 x i8>* %a, <n x 16 x i8>* %b, <n x 16 x i8>* %c) {
; CHECK-LABEL: uzp1_b_32:
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp1 [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8>, <n x 16 x i8>* %b
  %in1 = load <n x 16 x i8>, <n x 16 x i8>* %c
  %1 = insertelement <n x 16 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 16 x i32> %1, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i32> %2, stepvector
  %4 = insertelement <n x 16 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 16 x i32> %4, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %mask = add <n x 16 x i32> %5, %3
  %res = shufflevector <n x 16 x i8> %in0, <n x 16 x i8> %in1, <n x 16 x i32> %mask
  store <n x 16 x i8> %res, <n x 16 x i8>* %a
  ret void
}

define void @uzp1_b_64(<n x 16 x i8>* %a, <n x 16 x i8>* %b, <n x 16 x i8>* %c) {
; CHECK-LABEL: uzp1_b_64:
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp1 [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8>, <n x 16 x i8>* %b
  %in1 = load <n x 16 x i8>, <n x 16 x i8>* %c
  %1 = insertelement <n x 16 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 0, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %mask = add <n x 16 x i64> %5, %3
  %res = shufflevector <n x 16 x i8> %in0, <n x 16 x i8> %in1, <n x 16 x i64> %mask
  store <n x 16 x i8> %res, <n x 16 x i8>* %a
  ret void
}

define void @uzp1_h(<n x 8 x i16>* %a, <n x 8 x i16>* %b, <n x 8 x i16>* %c) {
; CHECK-LABEL: uzp1_h:
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp1 [[RES:z[0-9]+]].h, [[IN0]].h, [[IN1]].h
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16>, <n x 8 x i16>* %b
  %in1 = load <n x 8 x i16>, <n x 8 x i16>* %c
  %1 = insertelement <n x 8 x i16> undef, i16 2, i32 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i16> %2, stepvector
  %4 = insertelement <n x 8 x i16> undef, i16 0, i32 0
  %5 = shufflevector <n x 8 x i16> %4, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %mask = add <n x 8 x i16> %5, %3
  %res = shufflevector <n x 8 x i16> %in0, <n x 8 x i16> %in1, <n x 8 x i16> %mask
  store <n x 8 x i16> %res, <n x 8 x i16>* %a
  ret void
}

define void @uzp1_s(<n x 4 x i32>* %a, <n x 4 x i32>* %b, <n x 4 x i32>* %c) {
; CHECK-LABEL: uzp1_s:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp1 [[RES:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32>, <n x 4 x i32>* %b
  %in1 = load <n x 4 x i32>, <n x 4 x i32>* %c
  %1 = insertelement <n x 4 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %mask = add <n x 4 x i32> %5, %3
  %res = shufflevector <n x 4 x i32> %in0, <n x 4 x i32> %in1, <n x 4 x i32> %mask
  store <n x 4 x i32> %res, <n x 4 x i32>* %a
  ret void
}

define void @uzp1_s_double(<n x 8 x i32>* %a, <n x 8 x i32>* %b, <n x 8 x i32>* %c) {
; CHECK-LABEL: uzp1_s_double:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[IN2:z[0-9]+]].s}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: uzp1 [[RES:z[0-9]+]].s, [[IN0]].s,
; CHECK-DAG: uzp1 {{z[0-9]+}}.s, [[IN2]].s,
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 8 x i32>, <n x 8 x i32>* %b
  %in1 = load <n x 8 x i32>, <n x 8 x i32>* %c
  %1 = insertelement <n x 8 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 8 x i32> %1, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i32> %2, stepvector
  %4 = insertelement <n x 8 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 8 x i32> %4, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %mask = add <n x 8 x i32> %5, %3
  %res = shufflevector <n x 8 x i32> %in0, <n x 8 x i32> %in1, <n x 8 x i32> %mask
  store <n x 8 x i32> %res, <n x 8 x i32>* %a
  ret void
}

define void @uzp1_d(<n x 2 x i64>* %a, <n x 2 x i64>* %b, <n x 2 x i64>* %c) {
; CHECK-LABEL: uzp1_d:
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp1 [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64>, <n x 2 x i64>* %b
  %in1 = load <n x 2 x i64>, <n x 2 x i64>* %c
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %mask = add <n x 2 x i64> %5, %3
  %res = shufflevector <n x 2 x i64> %in0, <n x 2 x i64> %in1, <n x 2 x i64> %mask
  store <n x 2 x i64> %res, <n x 2 x i64>* %a
  ret void
}

define void @uzp2_b_16(<n x 16 x i8>* %a, <n x 16 x i8>* %b, <n x 16 x i8>* %c) {
; CHECK-LABEL: uzp2_b_16:
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp2 [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8>, <n x 16 x i8>* %b
  %in1 = load <n x 16 x i8>, <n x 16 x i8>* %c
  %1 = insertelement <n x 16 x i16> undef, i16 2, i32 0
  %2 = shufflevector <n x 16 x i16> %1, <n x 16 x i16> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i16> %2, stepvector
  %4 = insertelement <n x 16 x i16> undef, i16 1, i32 0
  %5 = shufflevector <n x 16 x i16> %4, <n x 16 x i16> undef, <n x 16 x i32> zeroinitializer
  %mask = add <n x 16 x i16> %5, %3
  %res = shufflevector <n x 16 x i8> %in0, <n x 16 x i8> %in1, <n x 16 x i16> %mask
  store <n x 16 x i8> %res, <n x 16 x i8>* %a
  ret void
}

define void @uzp2_b_32(<n x 16 x i8>* %a, <n x 16 x i8>* %b, <n x 16 x i8>* %c) {
; CHECK-LABEL: uzp2_b_32:
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp2 [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8>, <n x 16 x i8>* %b
  %in1 = load <n x 16 x i8>, <n x 16 x i8>* %c
  %1 = insertelement <n x 16 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 16 x i32> %1, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i32> %2, stepvector
  %4 = insertelement <n x 16 x i32> undef, i32 1, i32 0
  %5 = shufflevector <n x 16 x i32> %4, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %mask = add <n x 16 x i32> %5, %3
  %res = shufflevector <n x 16 x i8> %in0, <n x 16 x i8> %in1, <n x 16 x i32> %mask
  store <n x 16 x i8> %res, <n x 16 x i8>* %a
  ret void
}

define void @uzp2_b_64(<n x 16 x i8>* %a, <n x 16 x i8>* %b, <n x 16 x i8>* %c) {
; CHECK-LABEL: uzp2_b_64:
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp2 [[RES:z[0-9]+]].b, [[IN0]].b, [[IN1]].b
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8>, <n x 16 x i8>* %b
  %in1 = load <n x 16 x i8>, <n x 16 x i8>* %c
  %1 = insertelement <n x 16 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 1, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %mask = add <n x 16 x i64> %5, %3
  %res = shufflevector <n x 16 x i8> %in0, <n x 16 x i8> %in1, <n x 16 x i64> %mask
  store <n x 16 x i8> %res, <n x 16 x i8>* %a
  ret void
}

define void @uzp2_h(<n x 8 x i16>* %a, <n x 8 x i16>* %b, <n x 8 x i16>* %c) {
; CHECK-LABEL: uzp2_h:
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp2 [[RES:z[0-9]+]].h, [[IN0]].h, [[IN1]].h
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16>, <n x 8 x i16>* %b
  %in1 = load <n x 8 x i16>, <n x 8 x i16>* %c
  %1 = insertelement <n x 8 x i16> undef, i16 2, i32 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i16> %2, stepvector
  %4 = insertelement <n x 8 x i16> undef, i16 1, i32 0
  %5 = shufflevector <n x 8 x i16> %4, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %mask = add <n x 8 x i16> %5, %3
  %res = shufflevector <n x 8 x i16> %in0, <n x 8 x i16> %in1, <n x 8 x i16> %mask
  store <n x 8 x i16> %res, <n x 8 x i16>* %a
  ret void
}

define void @uzp2_s(<n x 4 x i32>* %a, <n x 4 x i32>* %b, <n x 4 x i32>* %c) {
; CHECK-LABEL: uzp2_s:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp2 [[RES:z[0-9]+]].s, [[IN0]].s, [[IN1]].s
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32>, <n x 4 x i32>* %b
  %in1 = load <n x 4 x i32>, <n x 4 x i32>* %c
  %1 = insertelement <n x 4 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %mask = add <n x 4 x i32> %5, %3
  %res = shufflevector <n x 4 x i32> %in0, <n x 4 x i32> %in1, <n x 4 x i32> %mask
  store <n x 4 x i32> %res, <n x 4 x i32>* %a
  ret void
}

define <n x 4 x float> @uzp2_float(<n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: uzp2_float:
; CHECK: uzp2 z0.s, z0.s, z1.s
; CHECK: ret
  %1 = insertelement <n x 4 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %mask = add <n x 4 x i32> %5, %3
  %res = shufflevector <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x i32> %mask
  ret <n x 4 x float> %res
}

define void @uzp2_s_double(<n x 8 x i32>* %a, <n x 8 x i32>* %b, <n x 8 x i32>* %c) {
; CHECK-LABEL: uzp2_s_double:
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1w {[[IN2:z[0-9]+]].s}, {{p[0-9]+}}/z, [x2]
; CHECK-DAG: uzp2 [[RES:z[0-9]+]].s, [[IN0]].s,
; CHECK-DAG: uzp2 {{z[0-9]+}}.s, [[IN2]].s,
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 8 x i32>, <n x 8 x i32>* %b
  %in1 = load <n x 8 x i32>, <n x 8 x i32>* %c
  %1 = insertelement <n x 8 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 8 x i32> %1, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i32> %2, stepvector
  %4 = insertelement <n x 8 x i32> undef, i32 1, i32 0
  %5 = shufflevector <n x 8 x i32> %4, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %mask = add <n x 8 x i32> %5, %3
  %res = shufflevector <n x 8 x i32> %in0, <n x 8 x i32> %in1, <n x 8 x i32> %mask
  store <n x 8 x i32> %res, <n x 8 x i32>* %a
  ret void
}

define void @uzp2_d(<n x 2 x i64>* %a, <n x 2 x i64>* %b, <n x 2 x i64>* %c) {
; CHECK-LABEL: uzp2_d:
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, {{p[0-9]+}}/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, {{p[0-9]+}}/z, [x2]
; CHECK: uzp2 [[RES:z[0-9]+]].d, [[IN0]].d, [[IN1]].d
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64>, <n x 2 x i64>* %b
  %in1 = load <n x 2 x i64>, <n x 2 x i64>* %c
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %mask = add <n x 2 x i64> %5, %3
  %res = shufflevector <n x 2 x i64> %in0, <n x 2 x i64> %in1, <n x 2 x i64> %mask
  store <n x 2 x i64> %res, <n x 2 x i64>* %a
  ret void
}

; Shuffling predicate vectors requires truncation.
define <n x 2 x i1> @tbl_2i1_trunc(<n x 2 x i1> %a, <n x 2 x i1> %b, <n x 2 x i32> %sel) {
; CHECK-LABEL: tbl_2i1_trunc
; CHECK-DAG: mov [[EXP_PRIN0:z[0-9]+]].d, p0/z, #1
; CHECK-DAG: tbl [[RES0:z[0-9]+]].d, {[[EXP_PRIN0]].d}, z0.d
; CHECK-DAG: sub [[SEL1:z[0-9]+]].d, z0.d, {{z[0-9]+}}.d
; CHECK-DAG: mov [[EXP_PRIN1:z[0-9]+]].d, p1/z, #1
; CHECK: tbl [[RES1:z[0-9]+]].d, {[[EXP_PRIN1:z[0-9]+]].d}, [[SEL1]].d
; CHECK: orr [[RES2:z[0-9]+]].d, [[RES0]].d, [[RES1]].d
; CHECK: lsl [[RES]].d, [[RES2]].d, #63
; CHECK: cmpne p0.d, {{p[0-9]+}}/z, [[RES1]].d, #0
  %res = shufflevector <n x 2 x i1> %a, <n x 2 x i1> %b, <n x 2 x i32> %sel
  ret <n x 2 x i1> %res
}

define <n x 4 x i1> @tbl_4i1_trunc(<n x 4 x i1> %a, <n x 4 x i1> %b, <n x 4 x i32> %sel) {
; CHECK-LABEL: tbl_4i1_trunc
; CHECK-DAG: mov [[EXP_PRIN0:z[0-9]+]].s, p0/z, #1
; CHECK-DAG: tbl [[RES0:z[0-9]+]].s, {[[EXP_PRIN0]].s}, z0.s
; CHECK-DAG: sub [[SEL1:z[0-9]+]].s, z0.s, {{z[0-9]+}}.s
; CHECK-DAG: mov [[EXP_PRIN1:z[0-9]+]].s, p1/z, #1
; CHECK: tbl [[RES1:z[0-9]+]].s, {[[EXP_PRIN1:z[0-9]+]].s}, [[SEL1]].s
; CHECK: orr [[RES2:z[0-9]+]].d, [[RES0]].d, [[RES1]].d
; CHECK: lsl [[RES]].s, [[RES2]].s, #31
; CHECK: cmpne p0.s, {{p[0-9]+}}/z, [[RES1]].s, #0
  %res = shufflevector <n x 4 x i1> %a, <n x 4 x i1> %b, <n x 4 x i32> %sel
  ret <n x 4 x i1> %res
}

define <n x 8 x i1> @tbl_8i1_trunc(<n x 8 x i1> %a, <n x 8 x i1> %b, <n x 8 x i32> %sel) {
; CHECK-LABEL: tbl_8i1_trunc
; CHECK-DAG: mov [[EXP_PRIN0:z[0-9]+]].h, p0/z, #1
; CHECK-DAG: tbl [[RES0:z[0-9]+]].h, {[[EXP_PRIN0]].h}, z0.h
; CHECK-DAG: sub [[SEL1:z[0-9]+]].h, z0.h, {{z[0-9]+}}.h
; CHECK-DAG: mov [[EXP_PRIN1:z[0-9]+]].h, p1/z, #1
; CHECK: tbl [[RES1:z[0-9]+]].h, {[[EXP_PRIN1:z[0-9]+]].h}, [[SEL1]].h
; CHECK: orr [[RES2:z[0-9]+]].d, [[RES0]].d, [[RES1]].d
; CHECK: lsl [[RES]].h, [[RES2]].h, #15
; CHECK: cmpne p0.h, {{p[0-9]+}}/z, [[RES1]].h, #0
  %res = shufflevector <n x 8 x i1> %a, <n x 8 x i1> %b, <n x 8 x i32> %sel
  ret <n x 8 x i1> %res
}

define <n x 16 x i1> @tbl_16i1_trunc(<n x 16 x i1> %a, <n x 16 x i1> %b, <n x 16 x i32> %sel) {
; CHECK-LABEL: tbl_16i1_trunc

; Eight TBL instructions are generated, because we promote i8 to
; i16. The reason for the i16 promotion is that for .b variant of TBL
; the index is not big enough to allow all combinations for
; <n x 32 x i8> (i.e. concat(<n x 16 x i8>, <n x 16 x i8>)).

; CHECK: tbl
; CHECK: tbl
; CHECK: tbl
; CHECK: tbl
; CHECK: tbl
; CHECK: tbl
; CHECK: tbl
; CHECK: tbl
; CHECK: ret
  %res = shufflevector <n x 16 x i1> %a, <n x 16 x i1> %b, <n x 16 x i32> %sel
  ret <n x 16 x i1> %res
}

define void @shuffle_is_splat(<n x 4 x float> * %ptr) {
; CHECK-LABEL: shuffle_is_splat
; CHECK-NOT: sel
; CHECK-NOT: tbl
; CHECK-NOT: udiv
  %dataf32 = load <n x 4 x float>, <n x 4 x float> *%ptr
  %dataf64 = fpext <n x 4 x float> %dataf32 to <n x 4 x double>
  %div = fdiv fast <n x 4 x double> shufflevector (<n x 4 x double> insertelement (<n x 4 x double> undef, double 1.000000e+00, i32 0), <n x 4 x double> undef, <n x 4 x i32> zeroinitializer), %dataf64
  %dataf32.2 = fptrunc <n x 4 x double> %div to <n x 4 x float>
  store <n x 4 x float>  %dataf32.2, <n x 4 x float> * %ptr
  ret void
}

define <n x 2 x i1> @uzp1_nxv2i1(<n x 2 x i1> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: uzp1_nxv2i1
; CHECK: uzp1 p0.d, p0.d, p1.d
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 2 x i32> %1, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i32> %2, stepvector
  %4 = insertelement <n x 2 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 2 x i32> %4, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %mask = add <n x 2 x i32> %5, %3
  %rev = shufflevector <n x 2 x i1> %a, <n x 2 x i1> %b, <n x 2 x i32> %mask
  ret <n x 2 x i1> %rev
}

define <n x 4 x i1> @uzp1_nxv4i1(<n x 4 x i1> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: uzp1_nxv4i1
; CHECK: uzp1 p0.s, p0.s, p1.s
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %mask = add <n x 4 x i32> %5, %3
  %rev = shufflevector <n x 4 x i1> %a, <n x 4 x i1> %b, <n x 4 x i32> %mask
  ret <n x 4 x i1> %rev
}

define <n x 8 x i1> @uzp1_nxv8i1(<n x 8 x i1> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: uzp1_nxv8i1
; CHECK: uzp1 p0.h, p0.h, p1.h
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 8 x i32> %1, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i32> %2, stepvector
  %4 = insertelement <n x 8 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 8 x i32> %4, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %mask = add <n x 8 x i32> %5, %3
  %rev = shufflevector <n x 8 x i1> %a, <n x 8 x i1> %b, <n x 8 x i32> %mask
  ret <n x 8 x i1> %rev
}

define <n x 16 x i1> @uzp1_nxv16i1(<n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: uzp1_nxv16i1
; CHECK: uzp1 p0.b, p0.b, p1.b
; CHECK-NEXT: ret
  %1 = insertelement <n x 16 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 16 x i32> %1, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i32> %2, stepvector
  %4 = insertelement <n x 16 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 16 x i32> %4, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %mask = add <n x 16 x i32> %5, %3
  %rev = shufflevector <n x 16 x i1> %a, <n x 16 x i1> %b, <n x 16 x i32> %mask
  ret <n x 16 x i1> %rev
}

define <n x 2 x i1> @uzp2_nxv2i1(<n x 2 x i1> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: uzp2_nxv2i1
; CHECK: uzp2 p0.d, p0.d, p1.d
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 2 x i32> %1, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i32> %2, stepvector
  %4 = insertelement <n x 2 x i32> undef, i32 1, i32 0
  %5 = shufflevector <n x 2 x i32> %4, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %mask = add <n x 2 x i32> %5, %3
  %rev = shufflevector <n x 2 x i1> %a, <n x 2 x i1> %b, <n x 2 x i32> %mask
  ret <n x 2 x i1> %rev
}

define <n x 4 x i1> @uzp2_nxv4i1(<n x 4 x i1> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: uzp2_nxv4i1
; CHECK: uzp2 p0.s, p0.s, p1.s
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i32> %2, stepvector
  %4 = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %5 = shufflevector <n x 4 x i32> %4, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %mask = add <n x 4 x i32> %5, %3
  %rev = shufflevector <n x 4 x i1> %a, <n x 4 x i1> %b, <n x 4 x i32> %mask
  ret <n x 4 x i1> %rev
}

define <n x 8 x i1> @uzp2_nxv8i1(<n x 8 x i1> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: uzp2_nxv8i1
; CHECK: uzp2 p0.h, p0.h, p1.h
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 8 x i32> %1, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i32> %2, stepvector
  %4 = insertelement <n x 8 x i32> undef, i32 1, i32 0
  %5 = shufflevector <n x 8 x i32> %4, <n x 8 x i32> undef, <n x 8 x i32> zeroinitializer
  %mask = add <n x 8 x i32> %5, %3
  %rev = shufflevector <n x 8 x i1> %a, <n x 8 x i1> %b, <n x 8 x i32> %mask
  ret <n x 8 x i1> %rev
}

define <n x 16 x i1> @uzp2_nxv16i1(<n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: uzp2_nxv16i1
; CHECK: uzp2 p0.b, p0.b, p1.b
; CHECK-NEXT: ret
  %1 = insertelement <n x 16 x i32> undef, i32 2, i32 0
  %2 = shufflevector <n x 16 x i32> %1, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i32> %2, stepvector
  %4 = insertelement <n x 16 x i32> undef, i32 1, i32 0
  %5 = shufflevector <n x 16 x i32> %4, <n x 16 x i32> undef, <n x 16 x i32> zeroinitializer
  %mask = add <n x 16 x i32> %5, %3
  %rev = shufflevector <n x 16 x i1> %a, <n x 16 x i1> %b, <n x 16 x i32> %mask
  ret <n x 16 x i1> %rev
}
