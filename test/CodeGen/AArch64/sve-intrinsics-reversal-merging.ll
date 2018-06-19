; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; RBIT
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 16 x i8> @rbit_i8(<n x 16 x i8> %unused, <n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: rbit_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: rbit z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.rbit.nxv16i8(<n x 16 x i8> zeroinitializer,
                                                           <n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @rbit_i16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: rbit_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: rbit z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.rbit.nxv8i16(<n x 8 x i16> zeroinitializer,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @rbit_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: rbit_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: rbit z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.rbit.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @rbit_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: rbit_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: rbit z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.rbit.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; REVB
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x i16> @revb_i16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: revb_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: revb z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.revb.nxv8i16(<n x 8 x i16> zeroinitializer,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @revb_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: revb_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: revb z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.revb.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @revb_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: revb_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: revb z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.revb.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; REVH
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 4 x i32> @revh_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: revh_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: revh z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.revh.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @revh_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: revh_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: revh z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.revh.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; REVW
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 2 x i64> @revw_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: revw_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: revw z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.revw.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

declare <n x 16 x i8> @llvm.aarch64.sve.rbit.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.rbit.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.rbit.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.rbit.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 8 x i16> @llvm.aarch64.sve.revb.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.revb.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.revb.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.revh.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.revh.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 2 x i64> @llvm.aarch64.sve.revw.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)
