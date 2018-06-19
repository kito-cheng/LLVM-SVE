; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define i8 @andv_nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a) {
; CHECK-LABEL: andv_nxv2i8:
; CHECK: andv b[[REDUCE:[0-9]+]], p0, z0.b
; CHECK-NEXT: umov w0, v[[REDUCE]].b[0]
; CHECK-NEXT: ret
  %res = call i8 @llvm.aarch64.sve.andv.nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a)
  ret i8 %res
}

define i8 @eorv_nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a) {
; CHECK-LABEL: eorv_nxv2i8:
; CHECK: eorv b[[REDUCE:[0-9]+]], p0, z0.b
; CHECK-NEXT: umov w0, v[[REDUCE]].b[0]
; CHECK-NEXT: ret
  %res = call i8 @llvm.aarch64.sve.eorv.nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a)
  ret i8 %res
}

define i8 @orv_nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a) {
; CHECK-LABEL: orv_nxv2i8:
; CHECK: orv b[[REDUCE:[0-9]+]], p0, z0.b
; CHECK-NEXT: umov w0, v[[REDUCE]].b[0]
; CHECK-NEXT: ret
  %res = call i8 @llvm.aarch64.sve.orv.nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a)
  ret i8 %res
}

define i64 @sadd_nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a) {
; CHECK-LABEL: sadd_nxv2i8:
; CHECK: saddv d[[REDUCE:[0-9]+]], p0, z0.b
; CHECK-NEXT: fmov x0, d[[REDUCE]]
; CHECK-NEXT: ret
  %res = call i64 @llvm.aarch64.sve.saddv.nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a)
  ret i64 %res
}

define i8 @smaxv_nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a) {
; CHECK-LABEL: smaxv_nxv2i8:
; CHECK: smaxv b[[REDUCE:[0-9]+]], p0, z0.b
; CHECK-NEXT: umov w0, v[[REDUCE]].b[0]
; CHECK-NEXT: ret
  %res = call i8 @llvm.aarch64.sve.smaxv.nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a)
  ret i8 %res
}

define i8 @sminv_nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a) {
; CHECK-LABEL: sminv_nxv2i8:
; CHECK: sminv b[[REDUCE:[0-9]+]], p0, z0.b
; CHECK-NEXT: umov w0, v[[REDUCE]].b[0]
; CHECK-NEXT: ret
  %res = call i8 @llvm.aarch64.sve.sminv.nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a)
  ret i8 %res
}

define i64 @uadd_nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a) {
; CHECK-LABEL: uadd_nxv2i8:
; CHECK: uaddv d[[REDUCE:[0-9]+]], p0, z0.b
; CHECK-NEXT: fmov x0, d[[REDUCE]]
; CHECK-NEXT: ret
  %res = call i64 @llvm.aarch64.sve.uaddv.nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a)
  ret i64 %res
}

define i8 @umaxv_nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a) {
; CHECK-LABEL: umaxv_nxv2i8:
; CHECK: umaxv b[[REDUCE:[0-9]+]], p0, z0.b
; CHECK-NEXT: umov w0, v[[REDUCE]].b[0]
; CHECK-NEXT: ret
  %res = call i8 @llvm.aarch64.sve.umaxv.nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a)
  ret i8 %res
}

define i8 @uminv_nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a) {
; CHECK-LABEL: uminv_nxv2i8:
; CHECK: uminv b[[REDUCE:[0-9]+]], p0, z0.b
; CHECK-NEXT: umov w0, v[[REDUCE]].b[0]
; CHECK-NEXT: ret
  %res = call i8 @llvm.aarch64.sve.uminv.nxv2i8(<n x 2 x i1> %pg, <n x 2 x i8> %a)
  ret i8 %res
}

declare i8 @llvm.aarch64.sve.andv.nxv2i8(<n x 2 x i1>, <n x 2 x i8>)
declare i8 @llvm.aarch64.sve.eorv.nxv2i8(<n x 2 x i1>, <n x 2 x i8>)
declare i8 @llvm.aarch64.sve.orv.nxv2i8(<n x 2 x i1>, <n x 2 x i8>)
declare i64 @llvm.aarch64.sve.saddv.nxv2i8(<n x 2 x i1>, <n x 2 x i8>)
declare i8 @llvm.aarch64.sve.smaxv.nxv2i8(<n x 2 x i1>, <n x 2 x i8>)
declare i8 @llvm.aarch64.sve.sminv.nxv2i8(<n x 2 x i1>, <n x 2 x i8>)
declare i64 @llvm.aarch64.sve.uaddv.nxv2i8(<n x 2 x i1>, <n x 2 x i8>)
declare i8 @llvm.aarch64.sve.umaxv.nxv2i8(<n x 2 x i1>, <n x 2 x i8>)
declare i8 @llvm.aarch64.sve.uminv.nxv2i8(<n x 2 x i1>, <n x 2 x i8>)
