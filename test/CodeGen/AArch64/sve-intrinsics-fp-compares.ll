; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; FACGE
;

define <n x 8 x i1> @facge_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: facge_h:
; CHECK: facge p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.acge.nxv8f16(<n x 8 x i1> %pg,
                                                          <n x 8 x half> %a,
                                                          <n x 8 x half> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @facge_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: facge_s:
; CHECK: facge p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.acge.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a,
                                                          <n x 4 x float> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @facge_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: facge_d:
; CHECK: facge p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.acge.nxv2f64(<n x 2 x i1> %pg,
                                                          <n x 2 x double> %a,
                                                          <n x 2 x double> %b)
  ret <n x 2 x i1> %out
}

;
; FACGT
;

define <n x 8 x i1> @facgt_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: facgt_h:
; CHECK: facgt p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.acgt.nxv8f16(<n x 8 x i1> %pg,
                                                          <n x 8 x half> %a,
                                                          <n x 8 x half> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @facgt_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: facgt_s:
; CHECK: facgt p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.acgt.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a,
                                                          <n x 4 x float> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @facgt_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: facgt_d:
; CHECK: facgt p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.acgt.nxv2f64(<n x 2 x i1> %pg,
                                                          <n x 2 x double> %a,
                                                          <n x 2 x double> %b)
  ret <n x 2 x i1> %out
}

;
; FCMEQ
;

define <n x 8 x i1> @fcmeq_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fcmeq_h:
; CHECK: fcmeq p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpeq.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmeq_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fcmeq_s:
; CHECK: fcmeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpeq.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %a,
                                                           <n x 4 x float> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmeq_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fcmeq_d:
; CHECK: fcmeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpeq.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %a,
                                                           <n x 2 x double> %b)
  ret <n x 2 x i1> %out
}

;
; FCMGE
;

define <n x 8 x i1> @fcmge_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fcmge_h:
; CHECK: fcmge p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpge.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmge_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fcmge_s:
; CHECK: fcmge p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpge.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %a,
                                                           <n x 4 x float> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmge_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fcmge_d:
; CHECK: fcmge p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpge.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %a,
                                                           <n x 2 x double> %b)
  ret <n x 2 x i1> %out
}

;
; FCMGT
;

define <n x 8 x i1> @fcmgt_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fcmgt_h:
; CHECK: fcmgt p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpgt.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmgt_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fcmgt_s:
; CHECK: fcmgt p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpgt.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %a,
                                                           <n x 4 x float> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmgt_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fcmgt_d:
; CHECK: fcmgt p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpgt.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %a,
                                                           <n x 2 x double> %b)
  ret <n x 2 x i1> %out
}

;
; FCMNE
;

define <n x 8 x i1> @fcmne_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fcmne_h:
; CHECK: fcmne p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpne.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmne_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fcmne_s:
; CHECK: fcmne p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpne.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %a,
                                                           <n x 4 x float> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmne_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fcmne_d:
; CHECK: fcmne p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpne.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %a,
                                                           <n x 2 x double> %b)
  ret <n x 2 x i1> %out
}

;
; FCMPUO
;

define <n x 8 x i1> @fcmuo_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fcmuo_h:
; CHECK: fcmuo p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpuo.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmuo_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fcmuo_s:
; CHECK: fcmuo p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpuo.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %a,
                                                           <n x 4 x float> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmuo_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fcmuo_d:
; CHECK: fcmuo p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpuo.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %a,
                                                           <n x 2 x double> %b)
  ret <n x 2 x i1> %out
}

declare <n x 8 x i1> @llvm.aarch64.sve.acge.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.acge.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.acge.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x i1> @llvm.aarch64.sve.acgt.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.acgt.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.acgt.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x i1> @llvm.aarch64.sve.cmpeq.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpeq.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpeq.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x i1> @llvm.aarch64.sve.cmpge.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpge.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpge.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x i1> @llvm.aarch64.sve.cmpgt.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpgt.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpgt.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x i1> @llvm.aarch64.sve.cmpne.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpne.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpne.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x i1> @llvm.aarch64.sve.cmpuo.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpuo.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpuo.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)
