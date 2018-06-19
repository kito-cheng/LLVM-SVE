; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define void @icmp_eq_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_eq_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpeq [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp eq <n x 16 x i8> %in0, %in1
  %tmp = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 16 x i1> %tmp, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  %cmp.ov = call <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1> %ones, <n x 16 x i1> %cmp)
  %res = sext <n x 16 x i1> %cmp.ov to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_eq_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_eq_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpeq [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp eq <n x 8 x i16> %in0, %in1
  %tmp = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 8 x i1> %tmp, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  %cmp.ov = call <n x 8 x i1> @llvm.propff.nxv8i1(<n x 8 x i1> %ones, <n x 8 x i1> %cmp)
  %res = sext <n x 8 x i1> %cmp.ov to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_eq_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_eq_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpeq [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp eq <n x 4 x i32> %in0, %in1
  %tmp = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 4 x i1> %tmp, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %cmp.ov = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %ones, <n x 4 x i1> %cmp)
  %res = sext <n x 4 x i1> %cmp.ov to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_eq_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_eq_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpeq [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp eq <n x 2 x i64> %in0, %in1
  %tmp = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 2 x i1> %tmp, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %cmp.ov = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %ones, <n x 2 x i1> %cmp)
  %res = sext <n x 2 x i1> %cmp.ov to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_sge_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_sge_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpge [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp sge <n x 16 x i8> %in0, %in1
  %tmp = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 16 x i1> %tmp, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  %cmp.ov = call <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1> %ones, <n x 16 x i1> %cmp)
  %res = sext <n x 16 x i1> %cmp.ov to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_sge_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_sge_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpge [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp sge <n x 8 x i16> %in0, %in1
  %tmp = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 8 x i1> %tmp, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  %cmp.ov = call <n x 8 x i1> @llvm.propff.nxv8i1(<n x 8 x i1> %ones, <n x 8 x i1> %cmp)
  %res = sext <n x 8 x i1> %cmp.ov to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_sge_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_sge_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpge [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp sge <n x 4 x i32> %in0, %in1
  %tmp = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 4 x i1> %tmp, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %cmp.ov = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %ones, <n x 4 x i1> %cmp)
  %res = sext <n x 4 x i1> %cmp.ov to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_sge_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_sge_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpge [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp sge <n x 2 x i64> %in0, %in1
  %tmp = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 2 x i1> %tmp, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %cmp.ov = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %ones, <n x 2 x i1> %cmp)
  %res = sext <n x 2 x i1> %cmp.ov to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_sgt_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_sgt_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp sgt <n x 16 x i8> %in0, %in1
  %tmp = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 16 x i1> %tmp, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  %cmp.ov = call <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1> %ones, <n x 16 x i1> %cmp)
  %res = sext <n x 16 x i1> %cmp.ov to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_sgt_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_sgt_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp sgt <n x 8 x i16> %in0, %in1
  %tmp = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 8 x i1> %tmp, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  %cmp.ov = call <n x 8 x i1> @llvm.propff.nxv8i1(<n x 8 x i1> %ones, <n x 8 x i1> %cmp)
  %res = sext <n x 8 x i1> %cmp.ov to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_sgt_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_sgt_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %tmp = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 4 x i1> %tmp, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %cmp.ov = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %ones, <n x 4 x i1> %cmp)
  %res = sext <n x 4 x i1> %cmp.ov to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_sgt_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_sgt_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp sgt <n x 2 x i64> %in0, %in1
  %tmp = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 2 x i1> %tmp, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %cmp.ov = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %ones, <n x 2 x i1> %cmp)
  %res = sext <n x 2 x i1> %cmp.ov to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_ne_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_ne_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpne [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp ne <n x 16 x i8> %in0, %in1
  %tmp = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 16 x i1> %tmp, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  %cmp.ov = call <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1> %ones, <n x 16 x i1> %cmp)
  %res = sext <n x 16 x i1> %cmp.ov to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_ne_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_ne_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpne [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp ne <n x 8 x i16> %in0, %in1
  %tmp = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 8 x i1> %tmp, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  %cmp.ov = call <n x 8 x i1> @llvm.propff.nxv8i1(<n x 8 x i1> %ones, <n x 8 x i1> %cmp)
  %res = sext <n x 8 x i1> %cmp.ov to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_ne_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_ne_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpne [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp ne <n x 4 x i32> %in0, %in1
  %tmp = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 4 x i1> %tmp, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %cmp.ov = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %ones, <n x 4 x i1> %cmp)
  %res = sext <n x 4 x i1> %cmp.ov to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_ne_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_ne_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpne [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp ne <n x 2 x i64> %in0, %in1
  %tmp = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 2 x i1> %tmp, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %cmp.ov = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %ones, <n x 2 x i1> %cmp)
  %res = sext <n x 2 x i1> %cmp.ov to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_sle_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_sle_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpge [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN1]].b, [[IN0]].b
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp sle <n x 16 x i8> %in0, %in1
  %tmp = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 16 x i1> %tmp, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  %cmp.ov = call <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1> %ones, <n x 16 x i1> %cmp)
  %res = sext <n x 16 x i1> %cmp.ov to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_sle_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_sle_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpge [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN1]].h, [[IN0]].h
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp sle <n x 8 x i16> %in0, %in1
  %tmp = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 8 x i1> %tmp, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  %cmp.ov = call <n x 8 x i1> @llvm.propff.nxv8i1(<n x 8 x i1> %ones, <n x 8 x i1> %cmp)
  %res = sext <n x 8 x i1> %cmp.ov to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_sle_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_sle_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpge [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN1]].s, [[IN0]].s
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp sle <n x 4 x i32> %in0, %in1
  %tmp = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 4 x i1> %tmp, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %cmp.ov = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %ones, <n x 4 x i1> %cmp)
  %res = sext <n x 4 x i1> %cmp.ov to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_sle_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_sle_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpge [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN1]].d, [[IN0]].d
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp sle <n x 2 x i64> %in0, %in1
  %tmp = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 2 x i1> %tmp, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %cmp.ov = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %ones, <n x 2 x i1> %cmp)
  %res = sext <n x 2 x i1> %cmp.ov to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

define void @icmp_slt_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b, <n x 16 x i8> *%c) {
; CHECK-LABEL: icmp_slt_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x1]
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN1]].b, [[IN0]].b
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].b, [[PD]]/z, #-1
; CHECK: st1b {[[RES]].b},
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%c
  %cmp = icmp slt <n x 16 x i8> %in0, %in1
  %tmp = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 16 x i1> %tmp, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  %cmp.ov = call <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1> %ones, <n x 16 x i1> %cmp)
  %res = sext <n x 16 x i1> %cmp.ov to <n x 16 x i8>
  store <n x 16 x i8> %res, <n x 16 x i8> *%a
  ret void
}

define void @icmp_slt_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b, <n x 8 x i16> *%c) {
; CHECK-LABEL: icmp_slt_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x1]
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN1]].h, [[IN0]].h
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].h, [[PD]]/z, #-1
; CHECK: st1h {[[RES]].h},
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%c
  %cmp = icmp slt <n x 8 x i16> %in0, %in1
  %tmp = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 8 x i1> %tmp, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  %cmp.ov = call <n x 8 x i1> @llvm.propff.nxv8i1(<n x 8 x i1> %ones, <n x 8 x i1> %cmp)
  %res = sext <n x 8 x i1> %cmp.ov to <n x 8 x i16>
  store <n x 8 x i16> %res, <n x 8 x i16> *%a
  ret void
}

define void @icmp_slt_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b, <n x 4 x i32> *%c) {
; CHECK-LABEL: icmp_slt_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x1]
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN1]].s, [[IN0]].s
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].s, [[PD]]/z, #-1
; CHECK: st1w {[[RES]].s},
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%c
  %cmp = icmp slt <n x 4 x i32> %in0, %in1
  %tmp = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 4 x i1> %tmp, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  %cmp.ov = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %ones, <n x 4 x i1> %cmp)
  %res = sext <n x 4 x i1> %cmp.ov to <n x 4 x i32>
  store <n x 4 x i32> %res, <n x 4 x i32> *%a
  ret void
}

define void @icmp_slt_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b, <n x 2 x i64> *%c) {
; CHECK-LABEL: icmp_slt_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x1]
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x2]
; CHECK: cmpgt [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN1]].d, [[IN0]].d
; CHECK: nor [[PNOT:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: brkb [[PD:p[0-9]+]].b, [[PG]]/z, [[PNOT]].b
; CHECK: mov [[RES:z[0-9]+]].d, [[PD]]/z, #-1
; CHECK: st1d {[[RES]].d},
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%c
  %cmp = icmp slt <n x 2 x i64> %in0, %in1
  %tmp = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %ones = shufflevector <n x 2 x i1> %tmp, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %cmp.ov = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %ones, <n x 2 x i1> %cmp)
  %res = sext <n x 2 x i1> %cmp.ov to <n x 2 x i64>
  store <n x 2 x i64> %res, <n x 2 x i64> *%a
  ret void
}

declare <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1>, <n x 16 x i1>)
declare <n x 8 x i1> @llvm.propff.nxv8i1(<n x 8 x i1>, <n x 8 x i1>)
declare <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1>, <n x 4 x i1>)
declare <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1>, <n x 2 x i1>)
