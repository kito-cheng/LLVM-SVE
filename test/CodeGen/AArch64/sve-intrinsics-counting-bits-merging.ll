; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; CLS
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 16 x i8> @cls_i8(<n x 16 x i8> %unused, <n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: cls_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: cls z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.cls.nxv16i8(<n x 16 x i8> zeroinitializer,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @cls_i16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: cls_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: cls z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.cls.nxv8i16(<n x 8 x i16> zeroinitializer,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @cls_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: cls_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: cls z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.cls.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @cls_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: cls_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: cls z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.cls.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; CLZ
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 16 x i8> @clz_i8(<n x 16 x i8> %unused, <n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: clz_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: clz z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.clz.nxv16i8(<n x 16 x i8> zeroinitializer,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @clz_i16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: clz_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: clz z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.clz.nxv8i16(<n x 8 x i16> zeroinitializer,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @clz_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: clz_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: clz z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.clz.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @clz_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: clz_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: clz z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.clz.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; CNT
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 16 x i8> @cnt_i8(<n x 16 x i8> %unused, <n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: cnt_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: cnt z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.cnt.nxv16i8(<n x 16 x i8> zeroinitializer,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @cnt_i16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: cnt_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: cnt z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.cnt.nxv8i16(<n x 8 x i16> zeroinitializer,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @cnt_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: cnt_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: cnt z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.cnt.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @cnt_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: cnt_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: cnt z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.cnt.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

define <n x 8 x i16> @cnt_f16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: cnt_f16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: cnt z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.cnt.nxv8f16(<n x 8 x i16> zeroinitializer,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x half> %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @cnt_f32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: cnt_f32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: cnt z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.cnt.nxv4f32(<n x 4 x i32> zeroinitializer,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x float> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @cnt_f64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: cnt_f64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: cnt z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.cnt.nxv2f64(<n x 2 x i64> zeroinitializer,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x double> %a)
  ret <n x 2 x i64> %out
}

declare <n x 16 x i8> @llvm.aarch64.sve.cls.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.cls.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.cls.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.cls.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.clz.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.clz.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.clz.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.clz.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.cnt.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.cnt.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.cnt.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.cnt.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 8 x i16> @llvm.aarch64.sve.cnt.nxv8f16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x i32> @llvm.aarch64.sve.cnt.nxv4f32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x i64> @llvm.aarch64.sve.cnt.nxv2f64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x double>)
