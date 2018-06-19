; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; SXTB
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x i16> @sxtb_i16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: sxtb_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: sxtb z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sxtb.nxv8i16(<n x 8 x i16> zeroinitializer,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sxtb_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: sxtb_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: sxtb z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sxtb.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sxtb_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: sxtb_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: sxtb z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sxtb.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; SXTH
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 4 x i32> @sxth_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: sxth_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: sxth z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sxth.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sxth_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: sxth_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: sxth z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sxth.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; SXTW
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 2 x i64> @sxtw_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: sxtw_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: sxtw z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sxtw.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; UXTB
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x i16> @uxtb_i16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: uxtb_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: uxtb z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uxtb.nxv8i16(<n x 8 x i16> zeroinitializer,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uxtb_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: uxtb_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: uxtb z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uxtb.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uxtb_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: uxtb_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: uxtb z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uxtb.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; UXTH
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 4 x i32> @uxth_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: uxth_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: uxth z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uxth.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uxth_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: uxth_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: uxth z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uxth.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; UXTW
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 2 x i64> @uxtw_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: uxtw_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: uxtw z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uxtw.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

declare <n x 8 x i16> @llvm.aarch64.sve.sxtb.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sxtb.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sxtb.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.sxth.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sxth.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 2 x i64> @llvm.aarch64.sve.sxtw.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 8 x i16> @llvm.aarch64.sve.uxtb.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.uxtb.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.uxtb.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.uxth.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.uxth.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 2 x i64> @llvm.aarch64.sve.uxtw.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)
