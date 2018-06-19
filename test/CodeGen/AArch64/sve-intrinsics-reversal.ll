; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; RBIT
;

define <n x 16 x i8> @rbit_i8(<n x 16 x i8> %a, <n x 16 x i1> %pg, <n x 16 x i8> %b) {
; CHECK-LABEL: rbit_i8:
; CHECK: rbit z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.rbit.nxv16i8(<n x 16 x i8> %a,
                                                           <n x 16 x i1> %pg,
                                                           <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @rbit_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: rbit_i16:
; CHECK: rbit z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.rbit.nxv8i16(<n x 8 x i16> %a,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @rbit_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: rbit_i32:
; CHECK: rbit z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.rbit.nxv4i32(<n x 4 x i32> %a,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @rbit_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: rbit_i64:
; CHECK: rbit z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.rbit.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; REVB
;

define <n x 8 x i16> @revb_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: revb_i16:
; CHECK: revb z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.revb.nxv8i16(<n x 8 x i16> %a,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @revb_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: revb_i32:
; CHECK: revb z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.revb.nxv4i32(<n x 4 x i32> %a,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @revb_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: revb_i64:
; CHECK: revb z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.revb.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; REVH
;

define <n x 4 x i32> @revh_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: revh_i32:
; CHECK: revh z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.revh.nxv4i32(<n x 4 x i32> %a,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @revh_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: revh_i64:
; CHECK: revh z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.revh.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; REVW
;

define <n x 2 x i64> @revw_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: revw_i64:
; CHECK: revw z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.revw.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %b)
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
