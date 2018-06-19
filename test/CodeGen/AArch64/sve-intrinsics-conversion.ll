; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; SXTB
;

define <n x 8 x i16> @sxtb_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: sxtb_i16:
; CHECK: sxtb z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sxtb.nxv8i16(<n x 8 x i16> %a,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sxtb_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: sxtb_i32:
; CHECK: sxtb z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sxtb.nxv4i32(<n x 4 x i32> %a,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sxtb_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: sxtb_i64:
; CHECK: sxtb z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sxtb.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; SXTH
;

define <n x 4 x i32> @sxth_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: sxth_i32:
; CHECK: sxth z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sxth.nxv4i32(<n x 4 x i32> %a,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sxth_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: sxth_i64:
; CHECK: sxth z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sxth.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; SXTW
;

define <n x 2 x i64> @sxtw_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: sxtw_i64:
; CHECK: sxtw z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sxtw.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; UXTB
;

define <n x 8 x i16> @uxtb_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: uxtb_i16:
; CHECK: uxtb z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uxtb.nxv8i16(<n x 8 x i16> %a,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uxtb_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: uxtb_i32:
; CHECK: uxtb z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uxtb.nxv4i32(<n x 4 x i32> %a,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uxtb_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: uxtb_i64:
; CHECK: uxtb z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uxtb.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; UXTH
;

define <n x 4 x i32> @uxth_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: uxth_i32:
; CHECK: uxth z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uxth.nxv4i32(<n x 4 x i32> %a,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uxth_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: uxth_i64:
; CHECK: uxth z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uxth.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; UXTW
;

define <n x 2 x i64> @uxtw_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: uxtw_i64:
; CHECK: uxtw z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uxtw.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %b)
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
