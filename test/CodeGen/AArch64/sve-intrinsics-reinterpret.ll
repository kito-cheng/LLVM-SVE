; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; int_aarch64_sve_reinterpret_bool_b
;

define <n x 16 x i1> @reinterpret_bool_b2b() {
; CHECK-LABEL: reinterpret_bool_b2b:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv16i1(<n x 16 x i1> zeroinitializer)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @reinterpret_bool_h2b() {
; CHECK-LABEL: reinterpret_bool_h2b:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv8i1(<n x 8 x i1> zeroinitializer)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @reinterpret_bool_s2b() {
; CHECK-LABEL: reinterpret_bool_s2b:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv4i1(<n x 4 x i1> zeroinitializer)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @reinterpret_bool_d2b() {
; CHECK-LABEL: reinterpret_bool_d2b:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> zeroinitializer)
  ret <n x 16 x i1> %out
}

;
; int_aarch64_sve_reinterpret_bool_h
;

define <n x 8 x i1> @reinterpret_bool_b2h() {
; CHECK-LABEL: reinterpret_bool_b2h:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv16i1(<n x 16 x i1> zeroinitializer)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @reinterpret_bool_h2h() {
; CHECK-LABEL: reinterpret_bool_h2h:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv8i1(<n x 8 x i1> zeroinitializer)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @reinterpret_bool_s2h() {
; CHECK-LABEL: reinterpret_bool_s2h:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv4i1(<n x 4 x i1> zeroinitializer)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @reinterpret_bool_d2h() {
; CHECK-LABEL: reinterpret_bool_d2h:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv2i1(<n x 2 x i1> zeroinitializer)
  ret <n x 8 x i1> %out
}

;
; int_aarch64_sve_reinterpret_bool_w
;

define <n x 4 x i1> @reinterpret_bool_b2s() {
; CHECK-LABEL: reinterpret_bool_b2s:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1> zeroinitializer)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @reinterpret_bool_h2s() {
; CHECK-LABEL: reinterpret_bool_h2s:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv8i1(<n x 8 x i1> zeroinitializer)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @reinterpret_bool_s2s() {
; CHECK-LABEL: reinterpret_bool_s2s:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv4i1(<n x 4 x i1> zeroinitializer)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @reinterpret_bool_d2s() {
; CHECK-LABEL: reinterpret_bool_d2s:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv2i1(<n x 2 x i1> zeroinitializer)
  ret <n x 4 x i1> %out
}

;
; int_aarch64_sve_reinterpret_bool_d
;

define <n x 2 x i1> @reinterpret_bool_b2d() {
; CHECK-LABEL: reinterpret_bool_b2d:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> zeroinitializer)
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @reinterpret_bool_h2d() {
; CHECK-LABEL: reinterpret_bool_h2d:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv8i1(<n x 8 x i1> zeroinitializer)
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @reinterpret_bool_s2d() {
; CHECK-LABEL: reinterpret_bool_s2d:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv4i1(<n x 4 x i1> zeroinitializer)
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @reinterpret_bool_d2d() {
; CHECK-LABEL: reinterpret_bool_d2d:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv2i1(<n x 2 x i1> zeroinitializer)
  ret <n x 2 x i1> %out
}

declare <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv16i1(<n x 16 x i1>)
declare <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv8i1(<n x 8 x i1>)
declare <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv4i1(<n x 4 x i1>)
declare <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1>)

declare <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv16i1(<n x 16 x i1>)
declare <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv8i1(<n x 8 x i1>)
declare <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv4i1(<n x 4 x i1>)
declare <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv2i1(<n x 2 x i1>)

declare <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1>)
declare <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv8i1(<n x 8 x i1>)
declare <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv4i1(<n x 4 x i1>)
declare <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv2i1(<n x 2 x i1>)

declare <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1>)
declare <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv8i1(<n x 8 x i1>)
declare <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv4i1(<n x 4 x i1>)
declare <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv2i1(<n x 2 x i1>)
