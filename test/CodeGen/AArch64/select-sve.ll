; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -verify-machineinstrs < %s | FileCheck %s

define <n x 16 x i8> @select_nxv16i8(i1 %cond, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: select_nxv16i8:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: and [[COND:w[0-9]+]], w0, #0x1
; CHECK-DAG: mov [[VCOND:z[0-9]+]].s, [[COND]]
; CHECK: cmpne [[PRED:p[0-9]+]].s, [[PG]]/z, [[VCOND]].s, #0
; CHECK: sel z0.s, [[PRED]], z0.s, z1.s
; CHECK: ret
  %res = select i1 %cond, <n x 16 x i8> %a, <n x 16 x i8> %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @select_nxv8i16(i1 %cond, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: select_nxv8i16:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: and [[COND:w[0-9]+]], w0, #0x1
; CHECK-DAG: mov [[VCOND:z[0-9]+]].s, [[COND]]
; CHECK: cmpne [[PRED:p[0-9]+]].s, [[PG]]/z, [[VCOND]].s, #0
; CHECK: sel z0.s, [[PRED]], z0.s, z1.s
; CHECK: ret
  %res = select i1 %cond, <n x 8 x i16> %a, <n x 8 x i16> %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @select_nxv4i32(i1 %cond, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: select_nxv4i32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: and [[COND:w[0-9]+]], w0, #0x1
; CHECK-DAG: mov [[VCOND:z[0-9]+]].s, [[COND]]
; CHECK: cmpne [[PRED:p[0-9]+]].s, [[PG]]/z, [[VCOND]].s, #0
; CHECK: sel z0.s, [[PRED]], z0.s, z1.s
; CHECK: ret
  %res = select i1 %cond, <n x 4 x i32> %a, <n x 4 x i32> %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @select_nxv2i64(i1 %cond, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: select_nxv2i64:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: and [[COND:w[0-9]+]], w0, #0x1
; CHECK-DAG: mov [[VCOND:z[0-9]+]].s, [[COND]]
; CHECK: cmpne [[PRED:p[0-9]+]].s, [[PG]]/z, [[VCOND]].s, #0
; CHECK: sel z0.s, [[PRED]], z0.s, z1.s
; CHECK: ret
  %res = select i1 %cond, <n x 2 x i64> %a, <n x 2 x i64> %b
  ret <n x 2 x i64> %res
}

define <n x 16 x i1> @select_nxv16i1(i1 %cond, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: select_nxv16i1:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: and [[COND:w[0-9]+]], w0, #0x1
; CHECK-DAG: mov [[VCOND:z[0-9]+]].b, [[COND]]
; CHECK: cmpne [[PRED:p[0-9]+]].b, [[PG]]/z, [[VCOND]].b, #0
; CHECK: sel p0.b, [[PRED]], p0.b, p1.b
; CHECK: ret
  %res = select i1 %cond, <n x 16 x i1> %a, <n x 16 x i1> %b
  ret <n x 16 x i1> %res
}

define <n x 8 x i1> @select_nxv8i1(i1 %cond, <n x 8 x i1> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: select_nxv8i1:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: and [[COND:w[0-9]+]], w0, #0x1
; CHECK-DAG: mov [[VCOND:z[0-9]+]].b, [[COND]]
; CHECK: cmpne [[PRED:p[0-9]+]].b, [[PG]]/z, [[VCOND]].b, #0
; CHECK: sel p0.b, [[PRED]], p0.b, p1.b
; CHECK: ret
  %res = select i1 %cond, <n x 8 x i1> %a, <n x 8 x i1> %b
  ret <n x 8 x i1> %res
}

define <n x 4 x i1> @select_nxv4i1(i1 %cond, <n x 4 x i1> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: select_nxv4i1:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: and [[COND:w[0-9]+]], w0, #0x1
; CHECK-DAG: mov [[VCOND:z[0-9]+]].b, [[COND]]
; CHECK: cmpne [[PRED:p[0-9]+]].b, [[PG]]/z, [[VCOND]].b, #0
; CHECK: sel p0.b, [[PRED]], p0.b, p1.b
; CHECK: ret
  %res = select i1 %cond, <n x 4 x i1> %a, <n x 4 x i1> %b
  ret <n x 4 x i1> %res
}

define <n x 2 x i1> @select_nxv2i1(i1 %cond, <n x 2 x i1> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: select_nxv2i1:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: and [[COND:w[0-9]+]], w0, #0x1
; CHECK-DAG: mov [[VCOND:z[0-9]+]].b, [[COND]]
; CHECK: cmpne [[PRED:p[0-9]+]].b, [[PG]]/z, [[VCOND]].b, #0
; CHECK: sel p0.b, [[PRED]], p0.b, p1.b
; CHECK: ret
  %res = select i1 %cond, <n x 2 x i1> %a, <n x 2 x i1> %b
  ret <n x 2 x i1> %res
}

define <n x 16 x i8> @vselect_nxv16i8(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: vselect_nxv16i8:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK: cmpgt [[PRED:p[0-9]+]].b, [[PG]]/z, z0.b, z1.b
; CHECK: sel z0.b, [[PRED]], z0.b, z1.b
; CHECK: ret
  %cmp = icmp sgt <n x 16 x i8> %a, %b
  %res = select <n x 16 x i1> %cmp, <n x 16 x i8> %a, <n x 16 x i8> %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @vselect_nxv8i16(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: vselect_nxv8i16:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK: cmpgt [[PRED:p[0-9]+]].h, [[PG]]/z, z0.h, z1.h
; CHECK: sel z0.h, [[PRED]], z0.h, z1.h
; CHECK: ret
  %cmp = icmp sgt <n x 8 x i16> %a, %b
  %res = select <n x 8 x i1> %cmp, <n x 8 x i16> %a, <n x 8 x i16> %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @vselect_nxv4i32(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: vselect_nxv4i32:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: cmpgt [[PRED:p[0-9]+]].s, [[PG]]/z, z0.s, z1.s
; CHECK: sel z0.s, [[PRED]], z0.s, z1.s
; CHECK: ret
  %cmp = icmp sgt <n x 4 x i32> %a, %b
  %res = select <n x 4 x i1> %cmp, <n x 4 x i32> %a, <n x 4 x i32> %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @vselect_nxv2i64(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: vselect_nxv2i64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: cmpgt [[PRED:p[0-9]+]].d, [[PG]]/z, z0.d, z1.d
; CHECK: sel z0.d, [[PRED]], z0.d, z1.d
; CHECK: ret
  %cmp = icmp sgt <n x 2 x i64> %a, %b
  %res = select <n x 2 x i1> %cmp, <n x 2 x i64> %a, <n x 2 x i64> %b
  ret <n x 2 x i64> %res
}

define <n x 16 x i1> @vselect_nxv16i1(<n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: vselect_nxv16i1:
; CHECK: sel p0.b, p0, p0.b, p1.b
; CHECK: ret
  %res = select <n x 16 x i1> %a, <n x 16 x i1> %a, <n x 16 x i1> %b
  ret <n x 16 x i1> %res
}

define <n x 8 x i1> @vselect_nxv8i1(<n x 8 x i1> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: vselect_nxv8i1:
; CHECK: sel p0.b, p0, p0.b, p1.b
; CHECK: ret
  %res = select <n x 8 x i1> %a, <n x 8 x i1> %a, <n x 8 x i1> %b
  ret <n x 8 x i1> %res
}

define <n x 4 x i1> @vselect_nxv4i1(<n x 4 x i1> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: vselect_nxv4i1:
; CHECK: sel p0.b, p0, p0.b, p1.b
; CHECK: ret
  %res = select <n x 4 x i1> %a, <n x 4 x i1> %a, <n x 4 x i1> %b
  ret <n x 4 x i1> %res
}

define <n x 2 x i1> @vselect_nxv2i1(<n x 2 x i1> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: vselect_nxv2i1:
; CHECK: sel p0.b, p0, p0.b, p1.b
; CHECK: ret
  %res = select <n x 2 x i1> %a, <n x 2 x i1> %a, <n x 2 x i1> %b
  ret <n x 2 x i1> %res
}
