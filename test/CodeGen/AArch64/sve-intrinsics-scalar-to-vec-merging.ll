; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; DUP
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 16 x i8> @dup_i8(<n x 16 x i8> %unused, <n x 16 x i1> %pg, i8 %a) {
; CHECK-LABEL: dup_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: mov z0.b, p0/m, w0
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.dup.nxv16i8(<n x 16 x i8> zeroinitializer,
                                                          <n x 16 x i1> %pg,
                                                          i8 %a)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @dup_i16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, i16 %a) {
; CHECK-LABEL: dup_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: mov z0.h, p0/m, w0
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.dup.nxv8i16(<n x 8 x i16> zeroinitializer,
                                                          <n x 8 x i1> %pg,
                                                          i16 %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @dup_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, i32 %a) {
; CHECK-LABEL: dup_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: mov z0.s, p0/m, w0
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.dup.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                          <n x 4 x i1> %pg,
                                                          i32 %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @dup_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, i64 %a) {
; CHECK-LABEL: dup_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: mov z0.d, p0/m, x0
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.dup.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                          <n x 2 x i1> %pg,
                                                          i64 %a)
  ret <n x 2 x i64> %out
}

define <n x 8 x half> @dup_f16(<n x 8 x half> %unused, <n x 8 x i1> %pg, half %a) {
; CHECK-LABEL: dup_f16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: mov z0.h, p0/m, h1
; CHECK-NEXT: ret
  %out = call <n x 8 x half> @llvm.aarch64.sve.dup.nxv8f16(<n x 8 x half> zeroinitializer,
                                                           <n x 8 x i1> %pg,
                                                           half %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @dup_f32(<n x 4 x float> %unused, <n x 4 x i1> %pg, float %a) {
; CHECK-LABEL: dup_f32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: mov z0.s, p0/m, s1
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.dup.nxv4f32(<n x 4 x float> zeroinitializer,
                                                            <n x 4 x i1> %pg,
                                                            float %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @dup_f64(<n x 2 x double> %unused, <n x 2 x i1> %pg, double %a) {
; CHECK-LABEL: dup_f64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: mov z0.d, p0/m, d1
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.dup.nxv2f64(<n x 2 x double> zeroinitializer,
                                                             <n x 2 x i1> %pg,
                                                             double %a)
  ret <n x 2 x double> %out
}

declare <n x 16 x i8> @llvm.aarch64.sve.dup.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, i8)
declare <n x 8 x i16> @llvm.aarch64.sve.dup.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, i16)
declare <n x 4 x i32> @llvm.aarch64.sve.dup.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, i32)
declare <n x 2 x i64> @llvm.aarch64.sve.dup.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, i64)
declare <n x 8 x half> @llvm.aarch64.sve.dup.nxv8f16(<n x 8 x half>, <n x 8 x i1>, half)
declare <n x 4 x float> @llvm.aarch64.sve.dup.nxv4f32(<n x 4 x float>, <n x 4 x i1>, float)
declare <n x 2 x double> @llvm.aarch64.sve.dup.nxv2f64(<n x 2 x double>, <n x 2 x i1>, double)
