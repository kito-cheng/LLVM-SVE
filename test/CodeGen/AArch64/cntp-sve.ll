; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s
declare i64 @llvm.ctvpop.nxv16i1(<n x 16 x i1>)
declare i64 @llvm.ctvpop.nxv8i1(<n x 8 x i1>)
declare i64 @llvm.ctvpop.nxv4i1(<n x 4 x i1>)
declare i64 @llvm.ctvpop.nxv2i1(<n x 2 x i1>)

define i64 @sve_cntp_b(i1* %src) {
entry:
; CHECK-LABEL: sve_cntp_b
; CHECK: ldr [[PRED:p[0-9]+]],
; CHECK: cntp x0, [[GP:p[0-9]+]], [[PRED]].b
; CHECK: ret
  %src.vp = bitcast i1* %src to <n x 16 x i1>*
  %src.v = load <n x 16 x i1>, <n x 16 x i1>* %src.vp
  %count = call i64 @llvm.ctvpop.nxv16i1(<n x 16 x i1> %src.v)
  ret i64 %count
}

define i64 @sve_cntp_h(i1* %src) {
entry:
; CHECK-LABEL: sve_cntp_h
; CHECK: ldr [[PRED:p[0-9]+]],
; CHECK: cntp x0, [[GP:p[0-9]+]], [[PRED]].h
; CHECK: ret
  %src.vp = bitcast i1* %src to <n x 8 x i1>*
  %src.v = load <n x 8 x i1>, <n x 8 x i1>* %src.vp
  %count = call i64 @llvm.ctvpop.nxv8i1(<n x 8 x i1> %src.v)
  ret i64 %count
}

define i64 @sve_cntp_s(i1* %src) {
entry:
; CHECK-LABEL: sve_cntp_s
; CHECK: ldr [[PRED:p[0-9]+]],
; CHECK: cntp x0, [[GP:p[0-9]+]], [[PRED]].s
; CHECK: ret
  %src.vp = bitcast i1* %src to <n x 4 x i1>*
  %src.v = load <n x 4 x i1>, <n x 4 x i1>* %src.vp
  %count = call i64 @llvm.ctvpop.nxv4i1(<n x 4 x i1> %src.v)
  ret i64 %count
}

define i64 @sve_cntp_d(i1* %src) {
entry:
; CHECK-LABEL: sve_cntp_d
; CHECK: ldr [[PRED:p[0-9]+]],
; CHECK: cntp x0, [[GP:p[0-9]+]], [[PRED]].d
; CHECK: ret
  %src.vp = bitcast i1* %src to <n x 2 x i1>*
  %src.v = load <n x 2 x i1>, <n x 2 x i1>* %src.vp
  %count = call i64 @llvm.ctvpop.nxv2i1(<n x 2 x i1> %src.v)
  ret i64 %count
}
