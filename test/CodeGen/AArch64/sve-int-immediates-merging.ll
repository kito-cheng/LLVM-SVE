; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Arithmetic                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
; ADD
;

define <n x 16 x i8> @add_b_lowimm(<n x 16 x i8> %_, <n x 16 x i8> %a) {
; CHECK-LABEL: add_b_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: add z0.b, z0.b, #27
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 27, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = add <n x 16 x i8> %a, %splat
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @add_h_lowimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: add_h_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: add z0.h, z0.h, #43
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 43, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = add <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @add_h_highimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: add_h_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: add z0.h, z0.h, #2048
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2048, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = add <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @add_s_lowimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: add_s_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: add z0.s, z0.s, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = add <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @add_s_highimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: add_s_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: add z0.s, z0.s, #8192
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 8192, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = add <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @add_d_lowimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: add_d_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: add z0.d, z0.d, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 255, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = add <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @add_d_highimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: add_d_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: add z0.d, z0.d, #65280
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 65280, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = add <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

;
; SUB
;

define <n x 16 x i8> @sub_b_lowimm(<n x 16 x i8> %_, <n x 16 x i8> %a) {
; CHECK-LABEL: sub_b_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sub z0.b, z0.b, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 255, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = sub <n x 16 x i8> %a, %splat
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sub_h_lowimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: sub_h_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sub z0.h, z0.h, #103
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 103, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = sub <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @sub_h_highimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: sub_h_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sub z0.h, z0.h, #2304
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2304, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = sub <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sub_s_lowimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: sub_s_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sub z0.s, z0.s, #87
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 87, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = sub <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @sub_s_highimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: sub_s_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sub z0.s, z0.s, #16384
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 16384, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = sub <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sub_d_lowimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: sub_d_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sub z0.d, z0.d, #190
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 190, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = sub <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @sub_d_highimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: sub_d_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sub z0.d, z0.d, #32768
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 32768, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = sub <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

;
; SQADD
;

define <n x 16 x i8> @sqadd_b_lowimm(<n x 16 x i8> %_, <n x 16 x i8> %a) {
; CHECK-LABEL: sqadd_b_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqadd z0.b, z0.b, #27
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 27, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.sqadd.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sqadd_h_lowimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: sqadd_h_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqadd z0.h, z0.h, #43
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 43, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @sqadd_h_highimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: sqadd_h_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqadd z0.h, z0.h, #2048
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2048, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sqadd_s_lowimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: sqadd_s_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqadd z0.s, z0.s, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @sqadd_s_highimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: sqadd_s_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqadd z0.s, z0.s, #8192
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 8192, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sqadd_d_lowimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: sqadd_d_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqadd z0.d, z0.d, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 255, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqadd.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @sqadd_d_highimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: sqadd_d_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqadd z0.d, z0.d, #65280
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 65280, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqadd.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

;
; SQSUB
;

define <n x 16 x i8> @sqsub_b_lowimm(<n x 16 x i8> %_, <n x 16 x i8> %a) {
; CHECK-LABEL: sqsub_b_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqsub z0.b, z0.b, #27
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 27, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.sqsub.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sqsub_h_lowimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: sqsub_h_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqsub z0.h, z0.h, #43
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 43, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqsub.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @sqsub_h_highimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: sqsub_h_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqsub z0.h, z0.h, #2048
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2048, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqsub.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sqsub_s_lowimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: sqsub_s_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqsub z0.s, z0.s, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqsub.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @sqsub_s_highimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: sqsub_s_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqsub z0.s, z0.s, #8192
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 8192, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqsub.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sqsub_d_lowimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: sqsub_d_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqsub z0.d, z0.d, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 255, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqsub.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @sqsub_d_highimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: sqsub_d_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: sqsub z0.d, z0.d, #65280
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 65280, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqsub.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

;
; UQADD
;

define <n x 16 x i8> @uqadd_b_lowimm(<n x 16 x i8> %_, <n x 16 x i8> %a) {
; CHECK-LABEL: uqadd_b_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqadd z0.b, z0.b, #27
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 27, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.uqadd.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @uqadd_h_lowimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: uqadd_h_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqadd z0.h, z0.h, #43
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 43, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @uqadd_h_highimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: uqadd_h_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqadd z0.h, z0.h, #2048
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2048, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uqadd_s_lowimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: uqadd_s_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqadd z0.s, z0.s, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @uqadd_s_highimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: uqadd_s_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqadd z0.s, z0.s, #8192
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 8192, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uqadd_d_lowimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: uqadd_d_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqadd z0.d, z0.d, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 255, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqadd.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @uqadd_d_highimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: uqadd_d_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqadd z0.d, z0.d, #65280
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 65280, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqadd.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

;
; UQSUB
;

define <n x 16 x i8> @uqsub_b_lowimm(<n x 16 x i8> %_, <n x 16 x i8> %a) {
; CHECK-LABEL: uqsub_b_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqsub z0.b, z0.b, #27
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 27, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.uqsub.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @uqsub_h_lowimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: uqsub_h_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqsub z0.h, z0.h, #43
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 43, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqsub.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @uqsub_h_highimm(<n x 16 x i8> %_, <n x 8 x i16> %a) {
; CHECK-LABEL: uqsub_h_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqsub z0.h, z0.h, #2048
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2048, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqsub.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uqsub_s_lowimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: uqsub_s_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqsub z0.s, z0.s, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqsub.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @uqsub_s_highimm(<n x 16 x i8> %_, <n x 4 x i32> %a) {
; CHECK-LABEL: uqsub_s_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqsub z0.s, z0.s, #8192
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 8192, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqsub.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uqsub_d_lowimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: uqsub_d_lowimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqsub z0.d, z0.d, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 255, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqsub.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @uqsub_d_highimm(<n x 16 x i8> %_, <n x 2 x i64> %a) {
; CHECK-LABEL: uqsub_d_highimm:
; CHECK:      movprfx z0, z1
; CHECK-NEXT: uqsub z0.d, z0.d, #65280
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 65280, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqsub.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

declare <n x 16 x i8> @llvm.aarch64.sve.sqadd.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sqadd.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.sqsub.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.sqsub.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sqsub.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sqsub.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.uqadd.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.uqadd.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.uqsub.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.uqsub.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.uqsub.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.uqsub.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)
