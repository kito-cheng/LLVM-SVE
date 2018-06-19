; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define void @sext_b_to_h(<n x 8 x i16> *%a, i8 *%b, i32 %idx) {
; CHECK-LABEL: sext_b_to_h:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].h
; CHECK-DAG: ld1sb {[[IN:z[0-9]+]].h}, [[PRED]]/z, [x1, [[OFF]]]
; CHECK-DAG: st1h  {[[IN]].h},
; CHECK: ret
 %b.addr = getelementptr i8, i8 *%b, i32 %idx
 %b.vaddr = bitcast i8 *%b.addr to <n x 8 x i8>*
 %in = load <n x 8 x i8> , <n x 8 x i8> *%b.vaddr
 %res = sext <n x 8 x i8> %in to <n x 8 x i16>
 store <n x 8 x i16> %res, <n x 8 x i16> *%a
 ret void
}

define void @sext_b_to_s(<n x 4 x i32> *%a, i8 *%b, i32 %idx) {
; CHECK-LABEL: sext_b_to_s:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1sb {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1, [[OFF]]]
; CHECK-DAG: st1w {[[IN]].s},
; CHECK: ret
 %b.addr = getelementptr i8, i8 *%b, i32 %idx
 %b.vaddr = bitcast i8 *%b.addr to <n x 4 x i8>*
 %in = load <n x 4 x i8> , <n x 4 x i8> *%b.vaddr
 %res = sext <n x 4 x i8> %in to <n x 4 x i32>
 store <n x 4 x i32> %res, <n x 4 x i32> *%a
 ret void
}

define void @sext_b_to_d(<n x 2 x i64> *%a, i8 *%b, i32 %idx) {
; CHECK-LABEL: sext_b_to_d:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1sb {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1, [[OFF]]]
; CHECK-DAG: st1d  {[[IN]].d},
; CHECK: ret
 %b.addr = getelementptr i8, i8 *%b, i32 %idx
 %b.vaddr = bitcast i8 *%b.addr to <n x 2 x i8>*
 %in = load <n x 2 x i8> , <n x 2 x i8> *%b.vaddr
 %res = sext <n x 2 x i8> %in to <n x 2 x i64>
 store <n x 2 x i64> %res, <n x 2 x i64> *%a
 ret void
}

define void @sext_h_to_s(<n x 4 x i32> *%a, i16 *%b, i32 %idx) {
; CHECK-LABEL: sext_h_to_s:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1sh {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1, [[OFF]], lsl #1]
; CHECK-DAG: st1w {[[IN]].s},
; CHECK: ret
 %b.addr = getelementptr i16, i16 *%b, i32 %idx
 %b.vaddr = bitcast i16 *%b.addr to <n x 4 x i16>*
 %in = load <n x 4 x i16> , <n x 4 x i16> *%b.vaddr
 %res = sext <n x 4 x i16> %in to <n x 4 x i32>
 store <n x 4 x i32> %res, <n x 4 x i32> *%a
 ret void
}

define void @sext_h_to_d(<n x 2 x i64> *%a, i16 *%b, i32 %idx) {
; CHECK-LABEL: sext_h_to_d:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1sh {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1, [[OFF]], lsl #1]
; CHECK-DAG: st1d  {[[IN]].d},
; CHECK: ret
 %b.addr = getelementptr i16, i16 *%b, i32 %idx
 %b.vaddr = bitcast i16 *%b.addr to <n x 2 x i16>*
 %in = load <n x 2 x i16> , <n x 2 x i16> *%b.vaddr
 %res = sext <n x 2 x i16> %in to <n x 2 x i64>
 store <n x 2 x i64> %res, <n x 2 x i64> *%a
 ret void
}

define void @sext_s_to_d(<n x 2 x i64> *%a, i32 *%b, i32 %idx) {
; CHECK-LABEL: sext_s_to_d:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1sw {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1, [[OFF]], lsl #2]
; CHECK-DAG: st1d  {[[IN]].d},
; CHECK: ret
 %b.addr = getelementptr i32, i32 *%b, i32 %idx
 %b.vaddr = bitcast i32 *%b.addr to <n x 2 x i32>*
 %in = load <n x 2 x i32> , <n x 2 x i32> *%b.vaddr
 %res = sext <n x 2 x i32> %in to <n x 2 x i64>
 store <n x 2 x i64> %res, <n x 2 x i64> *%a
 ret void
}

define void @zext_b_to_h(<n x 8 x i16> *%a, i8 *%b, i32 %idx) {
; CHECK-LABEL: zext_b_to_h:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].h
; CHECK-DAG: ld1b {[[IN:z[0-9]+]].h}, [[PRED]]/z, [x1, [[OFF]]]
; CHECK-DAG: st1h  {[[IN]].h},
; CHECK: ret
 %b.addr = getelementptr i8, i8 *%b, i32 %idx
 %b.vaddr = bitcast i8 *%b.addr to <n x 8 x i8>*
 %in = load <n x 8 x i8> , <n x 8 x i8> *%b.vaddr
 %res = zext <n x 8 x i8> %in to <n x 8 x i16>
 store <n x 8 x i16> %res, <n x 8 x i16> *%a
 ret void
}

define void @zext_b_to_s(<n x 4 x i32> *%a, i8 *%b, i32 %idx) {
; CHECK-LABEL: zext_b_to_s:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1b {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1, [[OFF]]]
; CHECK-DAG: st1w {[[IN]].s},
; CHECK: ret
 %b.addr = getelementptr i8, i8 *%b, i32 %idx
 %b.vaddr = bitcast i8 *%b.addr to <n x 4 x i8>*
 %in = load <n x 4 x i8> , <n x 4 x i8> *%b.vaddr
 %res = zext <n x 4 x i8> %in to <n x 4 x i32>
 store <n x 4 x i32> %res, <n x 4 x i32> *%a
 ret void
}

define void @zext_b_to_d(<n x 2 x i64> *%a, i8 *%b, i32 %idx) {
; CHECK-LABEL: zext_b_to_d:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1b {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1, [[OFF]]]
; CHECK-DAG: st1d  {[[IN]].d},
; CHECK: ret
 %b.addr = getelementptr i8, i8 *%b, i32 %idx
 %b.vaddr = bitcast i8 *%b.addr to <n x 2 x i8>*
 %in = load <n x 2 x i8> , <n x 2 x i8> *%b.vaddr
 %res = zext <n x 2 x i8> %in to <n x 2 x i64>
 store <n x 2 x i64> %res, <n x 2 x i64> *%a
 ret void
}

define void @zext_h_to_s(<n x 4 x i32> *%a, i16 *%b, i32 %idx) {
; CHECK-LABEL: zext_h_to_s:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1h {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1, [[OFF]], lsl #1]
; CHECK-DAG: st1w {[[IN]].s},
; CHECK: ret
 %b.addr = getelementptr i16, i16 *%b, i32 %idx
 %b.vaddr = bitcast i16 *%b.addr to <n x 4 x i16>*
 %in = load <n x 4 x i16> , <n x 4 x i16> *%b.vaddr
 %res = zext <n x 4 x i16> %in to <n x 4 x i32>
 store <n x 4 x i32> %res, <n x 4 x i32> *%a
 ret void
}

define void @zext_h_to_d(<n x 2 x i64> *%a, i16 *%b, i32 %idx) {
; CHECK-LABEL: zext_h_to_d:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1h {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1, [[OFF]], lsl #1]
; CHECK-DAG: st1d  {[[IN]].d},
; CHECK: ret
 %b.addr = getelementptr i16, i16 *%b, i32 %idx
 %b.vaddr = bitcast i16 *%b.addr to <n x 2 x i16>*
 %in = load <n x 2 x i16> , <n x 2 x i16> *%b.vaddr
 %res = zext <n x 2 x i16> %in to <n x 2 x i64>
 store <n x 2 x i64> %res, <n x 2 x i64> *%a
 ret void
}

define void @zext_s_to_d(<n x 2 x i64> *%a, i32 *%b, i32 %idx) {
; CHECK-LABEL: zext_s_to_d:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1w {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1, [[OFF]], lsl #2]
; CHECK-DAG: st1d  {[[IN]].d},
; CHECK: ret
 %b.addr = getelementptr i32, i32 *%b, i32 %idx
 %b.vaddr = bitcast i32 *%b.addr to <n x 2 x i32>*
 %in = load <n x 2 x i32> , <n x 2 x i32> *%b.vaddr
 %res = zext <n x 2 x i32> %in to <n x 2 x i64>
 store <n x 2 x i64> %res, <n x 2 x i64> *%a
 ret void
}

define void @trunc_h_to_b(i8 *%a, <n x 8 x i16> *%b, i32 %idx) {
; CHECK-LABEL: trunc_h_to_b:
; CHECK-DAG: ld1h {[[IN:z[0-9]+]].h}, [[PRED]]/z, [x1]
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].h
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: st1b {[[IN]].h}, [[PRED]], [x0, [[OFF]]]
; CHECK: ret
 %in = load <n x 8 x i16> , <n x 8 x i16> *%b
 %res = trunc <n x 8 x i16> %in to <n x 8 x i8>
 %a.addr = getelementptr i8, i8 *%a, i32 %idx
 %a.vaddr = bitcast i8 *%a.addr to <n x 8 x i8>*
 store <n x 8 x i8> %res, <n x 8 x i8> *%a.vaddr
 ret void
}

define void @trunc_s_to_b(i8 *%a, <n x 4 x i32> *%b, i32 %idx) {
; CHECK-LABEL: trunc_s_to_b:
; CHECK: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: st1b {[[IN]].s}, [[PRED]], [x0, [[OFF]]]
; CHECK: ret
 %in = load <n x 4 x i32> , <n x 4 x i32> *%b
 %res = trunc <n x 4 x i32> %in to <n x 4 x i8>
 %a.addr = getelementptr i8, i8 *%a, i32 %idx
 %a.vaddr = bitcast i8 *%a.addr to <n x 4 x i8>*
 store <n x 4 x i8> %res, <n x 4 x i8> *%a.vaddr
 ret void
}

define void @trunc_d_to_b(i8 *%a, <n x 2 x i64> *%b, i32 %idx) {
; CHECK-LABEL: trunc_d_to_b:
; CHECK: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: st1b {[[IN]].d}, [[PRED]], [x0, [[OFF]]]
; CHECK: ret
 %in = load <n x 2 x i64> , <n x 2 x i64> *%b
 %res = trunc <n x 2 x i64> %in to <n x 2 x i8>
 %a.addr = getelementptr i8, i8 *%a, i32 %idx
 %a.vaddr = bitcast i8 *%a.addr to <n x 2 x i8>*
 store <n x 2 x i8> %res, <n x 2 x i8> *%a.vaddr
 ret void
}

define void @trunc_s_to_h(i16 *%a, <n x 4 x i32> *%b, i32 %idx) {
; CHECK-LABEL: trunc_s_to_h:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN:z[0-9]+]].s}, [[PRED]]/z, [x1]
; CHECK: st1h {[[IN]].s}, [[PRED]], [x0, [[OFF]], lsl #1]
; CHECK: ret
 %in = load <n x 4 x i32> , <n x 4 x i32> *%b
 %res = trunc <n x 4 x i32> %in to <n x 4 x i16>
 %a.addr = getelementptr i16, i16 *%a, i32 %idx
 %a.vaddr = bitcast i16 *%a.addr to <n x 4 x i16>*
 store <n x 4 x i16> %res, <n x 4 x i16> *%a.vaddr
 ret void
}

define void @trunc_d_to_h(i16 *%a, <n x 2 x i64> *%b, i32 %idx) {
; CHECK-LABEL: trunc_d_to_h:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1h {[[IN]].d}, [[PRED]], [x0, [[OFF]], lsl #1]
; CHECK: ret
 %in = load <n x 2 x i64> , <n x 2 x i64> *%b
 %res = trunc <n x 2 x i64> %in to <n x 2 x i16>
 %a.addr = getelementptr i16, i16 *%a, i32 %idx
 %a.vaddr = bitcast i16 *%a.addr to <n x 2 x i16>*
 store <n x 2 x i16> %res, <n x 2 x i16> *%a.vaddr
 ret void
}

define void @trunc_d_to_s(i32 *%a, <n x 2 x i64> *%b, i32 %idx) {
; CHECK-LABEL: trunc_d_to_s:
; CHECK-DAG: sxtw [[OFF:x[0-9]+]], w2
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1]
; CHECK: st1w {[[IN]].d}, [[PRED]], [x0, [[OFF]], lsl #2]
; CHECK: ret
 %in = load <n x 2 x i64> , <n x 2 x i64> *%b
 %res = trunc <n x 2 x i64> %in to <n x 2 x i32>
 %a.addr = getelementptr i32, i32 *%a, i32 %idx
 %a.vaddr = bitcast i32 *%a.addr to <n x 2 x i32>*
 store <n x 2 x i32> %res, <n x 2 x i32> *%a.vaddr
 ret void
}

define void @promote_8b(<n x 8 x i8> *%a, <n x 8 x i8> *%b,
 <n x 8 x i8> *%c, i32 %idx) {
; CHECK-LABEL: promote_8b:
; CHECK-DAG: sxtw [[OFF1:x[0-9]+]], w3
; CHECK-DAG: cnth [[CNT:x[0-9]+]]
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].h
; CHECK-DAG: mul [[OFF2:x[0-9]+]], [[CNT]], [[OFF1]]
; CHECK-DAG: ld1b {[[Z0:z[0-9]+]].h}, [[PRED]]/z, [x1, [[OFF2]]]
; CHECK-DAG: ld1b {[[Z1:z[0-9]+]].h}, [[PRED]]/z, [x2, [[OFF2]]]
; CHECK-DAG: add [[OUT:z[0-9]+]].h, [[Z0]].h, [[Z1]].h
; CHECK-DAG: st1b {[[OUT]].h}, p0, [x0, [[OFF2]]]
; CHECK: ret
 %a.addr = getelementptr <n x 8 x i8>, <n x 8 x i8> *%a, i32 %idx
 %b.addr = getelementptr <n x 8 x i8>, <n x 8 x i8> *%b, i32 %idx
 %c.addr = getelementptr <n x 8 x i8>, <n x 8 x i8> *%c, i32 %idx
 %in0 = load <n x 8 x i8> , <n x 8 x i8> *%b.addr
 %in1 = load <n x 8 x i8> , <n x 8 x i8> *%c.addr
 %res = add <n x 8 x i8> %in0, %in1
 store <n x 8 x i8> %res, <n x 8 x i8> *%a.addr
 ret void
}

define void @promote_4b(<n x 4 x i8> *%a, <n x 4 x i8> *%b,
 <n x 4 x i8> *%c, i32 %idx) {
; CHECK-LABEL: promote_4b:
; CHECK-DAG: sxtw [[OFF1:x[0-9]+]], w3
; CHECK-DAG: cntw [[CNT:x[0-9]+]]
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: mul [[OFF2:x[0-9]+]], [[CNT]], [[OFF1]]
; CHECK-DAG: ld1b {[[Z0:z[0-9]+]].s}, [[PRED]]/z, [x1, [[OFF2]]]
; CHECK-DAG: ld1b {[[Z1:z[0-9]+]].s}, [[PRED]]/z, [x2, [[OFF2]]]
; CHECK-DAG: add [[OUT:z[0-9]+]].s, [[Z0]].s, [[Z1]].s
; CHECK-DAG: st1b {[[OUT]].s}, p0, [x0, [[OFF2]]]
; CHECK: ret
 %a.addr = getelementptr <n x 4 x i8>, <n x 4 x i8> *%a, i32 %idx
 %b.addr = getelementptr <n x 4 x i8>, <n x 4 x i8> *%b, i32 %idx
 %c.addr = getelementptr <n x 4 x i8>, <n x 4 x i8> *%c, i32 %idx
 %in0 = load <n x 4 x i8> , <n x 4 x i8> *%b.addr
 %in1 = load <n x 4 x i8> , <n x 4 x i8> *%c.addr
 %res = add <n x 4 x i8> %in0, %in1
 store <n x 4 x i8> %res, <n x 4 x i8> *%a.addr
 ret void
}

define void @promote_2b(<n x 2 x i8> *%a, <n x 2 x i8> *%b,
 <n x 2 x i8> *%c, i32 %idx) {
; CHECK-LABEL: promote_2b:
; CHECK-DAG: sxtw [[OFF1:x[0-9]+]], w3
; CHECK-DAG: cntd [[CNT:x[0-9]+]]
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: mul [[OFF2:x[0-9]+]], [[CNT]], [[OFF1]]
; CHECK-DAG: ld1b {[[Z0:z[0-9]+]].d}, [[PRED]]/z, [x1, [[OFF2]]]
; CHECK-DAG: ld1b {[[Z1:z[0-9]+]].d}, [[PRED]]/z, [x2, [[OFF2]]]
; CHECK-DAG: add [[OUT:z[0-9]+]].d, [[Z0]].d, [[Z1]].d
; CHECK-DAG: st1b {[[OUT]].d}, p0, [x0, [[OFF2]]]
; CHECK: ret
 %a.addr = getelementptr <n x 2 x i8>, <n x 2 x i8> *%a, i32 %idx
 %b.addr = getelementptr <n x 2 x i8>, <n x 2 x i8> *%b, i32 %idx
 %c.addr = getelementptr <n x 2 x i8>, <n x 2 x i8> *%c, i32 %idx
 %in0 = load <n x 2 x i8> , <n x 2 x i8> *%b.addr
 %in1 = load <n x 2 x i8> , <n x 2 x i8> *%c.addr
 %res = add <n x 2 x i8> %in0, %in1
 store <n x 2 x i8> %res, <n x 2 x i8> *%a.addr
 ret void
}

define void @promote_4h(<n x 4 x i16> *%a, <n x 4 x i16> *%b,
 <n x 4 x i16> *%c, i32 %idx) {
; CHECK-LABEL: promote_4h:
; CHECK-DAG: sxtw [[OFF1:x[0-9]+]], w3
; CHECK-DAG: cntw [[CNT:x[0-9]+]]
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].s
; CHECK-DAG: mul [[OFF2:x[0-9]+]], [[CNT]], [[OFF1]]
; CHECK-DAG: ld1h {[[Z0:z[0-9]+]].s}, [[PRED]]/z, [x1, [[OFF2]], lsl #1]
; CHECK-DAG: ld1h {[[Z1:z[0-9]+]].s}, [[PRED]]/z, [x2, [[OFF2]], lsl #1]
; CHECK-DAG: add [[OUT:z[0-9]+]].s, [[Z0]].s, [[Z1]].s
; CHECK-DAG: st1h {[[OUT]].s}, p0, [x0, [[OFF2]], lsl #1]
; CHECK: ret
 %a.addr = getelementptr <n x 4 x i16>, <n x 4 x i16> *%a, i32 %idx
 %b.addr = getelementptr <n x 4 x i16>, <n x 4 x i16> *%b, i32 %idx
 %c.addr = getelementptr <n x 4 x i16>, <n x 4 x i16> *%c, i32 %idx
 %in0 = load <n x 4 x i16> , <n x 4 x i16> *%b.addr
 %in1 = load <n x 4 x i16> , <n x 4 x i16> *%c.addr
 %res = add <n x 4 x i16> %in0, %in1
 store <n x 4 x i16> %res, <n x 4 x i16> *%a.addr
 ret void
}

define void @promote_2h(<n x 2 x i16> *%a, <n x 2 x i16> *%b,
 <n x 2 x i16> *%c, i32 %idx) {
; CHECK-LABEL: promote_2h:
; CHECK-DAG: sxtw [[OFF1:x[0-9]+]], w3
; CHECK-DAG: cntd [[CNT:x[0-9]+]]
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: mul [[OFF2:x[0-9]+]], [[CNT]], [[OFF1]]
; CHECK-DAG: ld1h {[[Z0:z[0-9]+]].d}, [[PRED]]/z, [x1, [[OFF2]], lsl #1]
; CHECK-DAG: ld1h {[[Z1:z[0-9]+]].d}, [[PRED]]/z, [x2, [[OFF2]], lsl #1]
; CHECK-DAG: add [[OUT:z[0-9]+]].d, [[Z0]].d, [[Z1]].d
; CHECK-DAG: st1h {[[OUT]].d}, p0, [x0, [[OFF2]], lsl #1]
; CHECK: ret
 %a.addr = getelementptr <n x 2 x i16>, <n x 2 x i16> *%a, i32 %idx
 %b.addr = getelementptr <n x 2 x i16>, <n x 2 x i16> *%b, i32 %idx
 %c.addr = getelementptr <n x 2 x i16>, <n x 2 x i16> *%c, i32 %idx
 %in0 = load <n x 2 x i16> , <n x 2 x i16> *%b.addr
 %in1 = load <n x 2 x i16> , <n x 2 x i16> *%c.addr
 %res = add <n x 2 x i16> %in0, %in1
 store <n x 2 x i16> %res, <n x 2 x i16> *%a.addr
 ret void
}

define void @promote_2s(<n x 2 x i32> *%a, <n x 2 x i32> *%b,
 <n x 2 x i32> *%c, i32 %idx) {
; CHECK-LABEL: promote_2s:
; CHECK-DAG: sxtw [[OFF1:x[0-9]+]], w3
; CHECK-DAG: cntd [[CNT:x[0-9]+]]
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: mul [[OFF2:x[0-9]+]], [[CNT]], [[OFF1]]
; CHECK-DAG: ld1w {[[Z0:z[0-9]+]].d}, [[PRED]]/z, [x1, [[OFF2]], lsl #2]
; CHECK-DAG: ld1w {[[Z1:z[0-9]+]].d}, [[PRED]]/z, [x2, [[OFF2]], lsl #2]
; CHECK-DAG: add [[OUT:z[0-9]+]].d, [[Z0]].d, [[Z1]].d
; CHECK-DAG: st1w {[[OUT]].d}, p0, [x0, [[OFF2]], lsl #2]
; CHECK: ret
 %a.addr = getelementptr <n x 2 x i32>, <n x 2 x i32> *%a, i32 %idx
 %b.addr = getelementptr <n x 2 x i32>, <n x 2 x i32> *%b, i32 %idx
 %c.addr = getelementptr <n x 2 x i32>, <n x 2 x i32> *%c, i32 %idx
 %in0 = load <n x 2 x i32> , <n x 2 x i32> *%b.addr
 %in1 = load <n x 2 x i32> , <n x 2 x i32> *%c.addr
 %res = add <n x 2 x i32> %in0, %in1
 store <n x 2 x i32> %res, <n x 2 x i32> *%a.addr
 ret void
}

; Test we use reg+reg addressing when the index is an immediate
; suitable for scaling and can be generated by a single instruction.
define void @immediate_index(<n x 2 x i64> *%a, i32 *%b) {
; CHECK-LABEL: immediate_index:
; CHECK-DAG: ptrue [[PRED:p[0-9]+]].d
; CHECK-DAG: orr x[[IDX:[0-9]+]], xzr, #0x20
; CHECK: ld1w {[[IN:z[0-9]+]].d}, [[PRED]]/z, [x1, x[[IDX]], lsl #2]
; CHECK: st1d  {[[IN]].d},
; CHECK: ret
 %b.addr = getelementptr i32, i32 *%b, i32 32
 %b.vaddr = bitcast i32 *%b.addr to <n x 2 x i32>*
 %in = load <n x 2 x i32> , <n x 2 x i32> *%b.vaddr
 %res = zext <n x 2 x i32> %in to <n x 2 x i64>
 store <n x 2 x i64> %res, <n x 2 x i64> *%a
 ret void
}

; As above but ensure we don't use reg+reg addressing when scaling
; the original index looses data.
define void @immediate_index_not_to_scale(<n x 2 x i64> *%a, i16 *%b) {
; CHECK-LABEL: immediate_index_not_to_scale:
; CHECK-NOT: ld1w {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}, {{x[0-9]}}
; CHECK: ret
 %b.addr = getelementptr i16, i16 *%b, i32 1
 %b.vaddr = bitcast i16 *%b.addr to <n x 2 x i32>*
 %in = load <n x 2 x i32> , <n x 2 x i32> *%b.vaddr
 %res = zext <n x 2 x i32> %in to <n x 2 x i64>
 store <n x 2 x i64> %res, <n x 2 x i64> *%a
 ret void
}

; As above but ensure we don't use reg+reg addressing if generating
; the immediate requires more than one instruction.
define void @immediate_index_too_big(<n x 2 x i64> *%a, i32 *%b) {
; CHECK-LABEL: immediate_index_too_big:
; CHECK-NOT: ld1w {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}, {{x[0-9]}}
; CHECK: ret
 %b.addr = getelementptr i32, i32 *%b, i32 65536
 %b.vaddr = bitcast i32 *%b.addr to <n x 2 x i32>*
 %in = load <n x 2 x i32> , <n x 2 x i32> *%b.vaddr
 %res = zext <n x 2 x i32> %in to <n x 2 x i64>
 store <n x 2 x i64> %res, <n x 2 x i64> *%a
 ret void
}

define void @fold_multi_use_sve_addr(i64 *%a, i64 %b) {
; CHECK-LABEL: fold_multi_use_sve_addr
; CHECK-NOT: ld1d {z{{[0-9]+}}.d}, p{{[0-9]+}}/z, {{\[x[0-9]+\]}}
 %a.addr = getelementptr i64, i64* %a, i64 %b
 %a.addr2 = bitcast i64* %a.addr to <n x 2 x i64>*
 %in = load <n x 2 x i64>, <n x 2 x i64> *%a.addr2
 %in2 = load <n x 2 x i64>,  <n x 2 x i64> *%a.addr2
 %res = add <n x 2 x i64> %in, %in2
 store <n x 2 x i64> %res, <n x 2 x i64> *%a.addr2
 ret void
}

define i64* @nofold_multi_use_nonaddr(i64 *%a, i64 %b) {
; CHECK-LABEL: nofold_multi_use_nonaddr
; CHECK-NOT: ld1d {z{{[0-9]+}}.d}, p{{[0-9]+}}/z, {{\[x[0-9]+\], x[0-9}+, lsl #3\]}}
 %a.addr = getelementptr i64, i64* %a, i64 %b
 %a.addr2 = bitcast i64* %a.addr to <n x 2 x i64>*
 %in = load <n x 2 x i64>, <n x 2 x i64> *%a.addr2
 %in2 = load <n x 2 x i64>,  <n x 2 x i64> *%a.addr2
 %res = add <n x 2 x i64> %in, %in2
 store <n x 2 x i64> %res, <n x 2 x i64> *%a.addr2
 ret i64* %a.addr
}
