; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; AND
;

define <n x 16 x i8> @and_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: and_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: and z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %a_z = select <n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.and.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a_z,
                                                          <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @and_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: and_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: and z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.and.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a_z,
                                                          <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @and_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: and_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: and z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.and.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a_z,
                                                          <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @and_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: and_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: and z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.and.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a_z,
                                                          <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; BIC
;

define <n x 16 x i8> @bic_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: bic_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: bic z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %a_z = select <n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.bic.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a_z,
                                                          <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @bic_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: bic_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: bic z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.bic.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a_z,
                                                          <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @bic_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: bic_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: bic z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.bic.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a_z,
                                                          <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @bic_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: bic_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: bic z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.bic.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a_z,
                                                          <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; CNOT
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 16 x i8> @cnot_i8(<n x 16 x i8> %unused, <n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: cnot_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: cnot z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.cnot.nxv16i8(<n x 16 x i8> zeroinitializer,
                                                           <n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @cnot_i16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: cnot_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: cnot z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.cnot.nxv8i16(<n x 8 x i16> zeroinitializer,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @cnot_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: cnot_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: cnot z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.cnot.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                           <n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @cnot_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: cnot_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: cnot z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.cnot.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                           <n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; EOR
;

define <n x 16 x i8> @eor_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: eor_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: eor z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %a_z = select <n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.eor.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a_z,
                                                          <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @eor_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: eor_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: eor z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.eor.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a_z,
                                                          <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @eor_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: eor_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: eor z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.eor.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a_z,
                                                          <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @eor_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: eor_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: eor z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.eor.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a_z,
                                                          <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; NOT
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 16 x i8> @not_i8(<n x 16 x i8> %unused, <n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: not_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: not z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.not.nxv16i8(<n x 16 x i8> zeroinitializer,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @not_i16(<n x 8 x i16> %unused, <n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: not_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: not z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.not.nxv8i16(<n x 8 x i16> zeroinitializer,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @not_i32(<n x 4 x i32> %unused, <n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: not_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: not z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.not.nxv4i32(<n x 4 x i32> zeroinitializer,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @not_i64(<n x 2 x i64> %unused, <n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: not_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: not z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.not.nxv2i64(<n x 2 x i64> zeroinitializer,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a)
  ret <n x 2 x i64> %out
}

;
; ORR
;

define <n x 16 x i8> @orr_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: orr_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: orr z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %a_z = select <n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.orr.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a_z,
                                                          <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @orr_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: orr_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: orr z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.orr.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a_z,
                                                          <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @orr_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: orr_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: orr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.orr.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a_z,
                                                          <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @orr_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: orr_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: orr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.orr.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a_z,
                                                          <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

declare <n x 16 x i8> @llvm.aarch64.sve.and.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.and.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.and.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.and.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.bic.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.bic.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.bic.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.bic.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.cnot.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.cnot.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.cnot.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.cnot.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.eor.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.eor.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.eor.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.eor.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.not.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.not.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.not.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.not.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.orr.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.orr.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.orr.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.orr.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)
