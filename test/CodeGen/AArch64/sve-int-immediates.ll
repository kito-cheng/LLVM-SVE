; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Arithmetic                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
; ADD
;

define <n x 16 x i8> @add_b_lowimm(<n x 16 x i8> %a) {
; CHECK-LABEL: add_b_lowimm:
; CHECK: add z0.b, z0.b, #27
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 27, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = add <n x 16 x i8> %a, %splat
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @add_h_lowimm(<n x 8 x i16> %a) {
; CHECK-LABEL: add_h_lowimm:
; CHECK: add z0.h, z0.h, #43
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 43, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = add <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @add_h_highimm(<n x 8 x i16> %a) {
; CHECK-LABEL: add_h_highimm:
; CHECK: add z0.h, z0.h, #2048
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2048, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = add <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @add_s_lowimm(<n x 4 x i32> %a) {
; CHECK-LABEL: add_s_lowimm:
; CHECK: add z0.s, z0.s, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = add <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @add_s_highimm(<n x 4 x i32> %a) {
; CHECK-LABEL: add_s_highimm:
; CHECK: add z0.s, z0.s, #8192
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 8192, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = add <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @add_d_lowimm(<n x 2 x i64> %a) {
; CHECK-LABEL: add_d_lowimm:
; CHECK: add z0.d, z0.d, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 255, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = add <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @add_d_highimm(<n x 2 x i64> %a) {
; CHECK-LABEL: add_d_highimm:
; CHECK: add z0.d, z0.d, #65280
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 65280, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = add <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

;
; SUB
;

define <n x 16 x i8> @sub_b_lowimm(<n x 16 x i8> %a) {
; CHECK-LABEL: sub_b_lowimm:
; CHECK: sub z0.b, z0.b, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 255, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = sub <n x 16 x i8> %a, %splat
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sub_h_lowimm(<n x 8 x i16> %a) {
; CHECK-LABEL: sub_h_lowimm:
; CHECK: sub z0.h, z0.h, #103
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 103, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = sub <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @sub_h_highimm(<n x 8 x i16> %a) {
; CHECK-LABEL: sub_h_highimm:
; CHECK: sub z0.h, z0.h, #2304
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2304, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = sub <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sub_s_lowimm(<n x 4 x i32> %a) {
; CHECK-LABEL: sub_s_lowimm:
; CHECK: sub z0.s, z0.s, #87
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 87, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = sub <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @sub_s_highimm(<n x 4 x i32> %a) {
; CHECK-LABEL: sub_s_highimm:
; CHECK: sub z0.s, z0.s, #16384
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 16384, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = sub <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sub_d_lowimm(<n x 2 x i64> %a) {
; CHECK-LABEL: sub_d_lowimm:
; CHECK: sub z0.d, z0.d, #190
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 190, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = sub <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @sub_d_highimm(<n x 2 x i64> %a) {
; CHECK-LABEL: sub_d_highimm:
; CHECK: sub z0.d, z0.d, #32768
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 32768, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = sub <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

;
; SQADD
;

define <n x 16 x i8> @sqadd_b_lowimm(<n x 16 x i8> %a) {
; CHECK-LABEL: sqadd_b_lowimm:
; CHECK: sqadd z0.b, z0.b, #27
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 27, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.sqadd.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sqadd_h_lowimm(<n x 8 x i16> %a) {
; CHECK-LABEL: sqadd_h_lowimm:
; CHECK: sqadd z0.h, z0.h, #43
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 43, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @sqadd_h_highimm(<n x 8 x i16> %a) {
; CHECK-LABEL: sqadd_h_highimm:
; CHECK: sqadd z0.h, z0.h, #2048
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2048, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sqadd_s_lowimm(<n x 4 x i32> %a) {
; CHECK-LABEL: sqadd_s_lowimm:
; CHECK: sqadd z0.s, z0.s, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @sqadd_s_highimm(<n x 4 x i32> %a) {
; CHECK-LABEL: sqadd_s_highimm:
; CHECK: sqadd z0.s, z0.s, #8192
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 8192, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sqadd_d_lowimm(<n x 2 x i64> %a) {
; CHECK-LABEL: sqadd_d_lowimm:
; CHECK: sqadd z0.d, z0.d, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 255, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqadd.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @sqadd_d_highimm(<n x 2 x i64> %a) {
; CHECK-LABEL: sqadd_d_highimm:
; CHECK: sqadd z0.d, z0.d, #65280
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

define <n x 16 x i8> @sqsub_b_lowimm(<n x 16 x i8> %a) {
; CHECK-LABEL: sqsub_b_lowimm:
; CHECK: sqsub z0.b, z0.b, #27
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 27, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.sqsub.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sqsub_h_lowimm(<n x 8 x i16> %a) {
; CHECK-LABEL: sqsub_h_lowimm:
; CHECK: sqsub z0.h, z0.h, #43
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 43, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqsub.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @sqsub_h_highimm(<n x 8 x i16> %a) {
; CHECK-LABEL: sqsub_h_highimm:
; CHECK: sqsub z0.h, z0.h, #2048
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2048, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqsub.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sqsub_s_lowimm(<n x 4 x i32> %a) {
; CHECK-LABEL: sqsub_s_lowimm:
; CHECK: sqsub z0.s, z0.s, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqsub.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @sqsub_s_highimm(<n x 4 x i32> %a) {
; CHECK-LABEL: sqsub_s_highimm:
; CHECK: sqsub z0.s, z0.s, #8192
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 8192, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqsub.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sqsub_d_lowimm(<n x 2 x i64> %a) {
; CHECK-LABEL: sqsub_d_lowimm:
; CHECK: sqsub z0.d, z0.d, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 255, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqsub.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @sqsub_d_highimm(<n x 2 x i64> %a) {
; CHECK-LABEL: sqsub_d_highimm:
; CHECK: sqsub z0.d, z0.d, #65280
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

define <n x 16 x i8> @uqadd_b_lowimm(<n x 16 x i8> %a) {
; CHECK-LABEL: uqadd_b_lowimm:
; CHECK: uqadd z0.b, z0.b, #27
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 27, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.uqadd.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @uqadd_h_lowimm(<n x 8 x i16> %a) {
; CHECK-LABEL: uqadd_h_lowimm:
; CHECK: uqadd z0.h, z0.h, #43
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 43, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @uqadd_h_highimm(<n x 8 x i16> %a) {
; CHECK-LABEL: uqadd_h_highimm:
; CHECK: uqadd z0.h, z0.h, #2048
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2048, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uqadd_s_lowimm(<n x 4 x i32> %a) {
; CHECK-LABEL: uqadd_s_lowimm:
; CHECK: uqadd z0.s, z0.s, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @uqadd_s_highimm(<n x 4 x i32> %a) {
; CHECK-LABEL: uqadd_s_highimm:
; CHECK: uqadd z0.s, z0.s, #8192
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 8192, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uqadd_d_lowimm(<n x 2 x i64> %a) {
; CHECK-LABEL: uqadd_d_lowimm:
; CHECK: uqadd z0.d, z0.d, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 255, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqadd.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @uqadd_d_highimm(<n x 2 x i64> %a) {
; CHECK-LABEL: uqadd_d_highimm:
; CHECK: uqadd z0.d, z0.d, #65280
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

define <n x 16 x i8> @uqsub_b_lowimm(<n x 16 x i8> %a) {
; CHECK-LABEL: uqsub_b_lowimm:
; CHECK: uqsub z0.b, z0.b, #27
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 27, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.uqsub.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @uqsub_h_lowimm(<n x 8 x i16> %a) {
; CHECK-LABEL: uqsub_h_lowimm:
; CHECK: uqsub z0.h, z0.h, #43
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 43, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqsub.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @uqsub_h_highimm(<n x 8 x i16> %a) {
; CHECK-LABEL: uqsub_h_highimm:
; CHECK: uqsub z0.h, z0.h, #2048
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 2048, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqsub.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uqsub_s_lowimm(<n x 4 x i32> %a) {
; CHECK-LABEL: uqsub_s_lowimm:
; CHECK: uqsub z0.s, z0.s, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqsub.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @uqsub_s_highimm(<n x 4 x i32> %a) {
; CHECK-LABEL: uqsub_s_highimm:
; CHECK: uqsub z0.s, z0.s, #8192
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 8192, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqsub.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uqsub_d_lowimm(<n x 2 x i64> %a) {
; CHECK-LABEL: uqsub_d_lowimm:
; CHECK: uqsub z0.d, z0.d, #255
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 255, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqsub.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @uqsub_d_highimm(<n x 2 x i64> %a) {
; CHECK-LABEL: uqsub_d_highimm:
; CHECK: uqsub z0.d, z0.d, #65280
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 65280, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqsub.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 Shifts                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <n x 16 x i8> @unpred_asr_b(<n x 16 x i8> %a) {
; CHECK-LABEL: unpred_asr_b:
; CHECK: asr z0.b, z0.b, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 1, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out   = ashr <n x 16 x i8> %a, %splat
  ret <n x 16 x i8> %out
}

define <n x 16 x i8> @pred_asr_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: pred_asr_b:
; CHECK: asr z0.b, p0/m, z0.b, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 1, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.asr.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 16 x i8> @wide_asr_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_asr_b:
; CHECK: asr z0.b, p0/m, z0.b, #1
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.asr.wide.nxv16i8(<n x 16 x i1> %pg,
                                                               <n x 16 x i8> %a,
                                                               <n x 2 x i64> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @unpred_asr_h(<n x 8 x i16> %a) {
; CHECK-LABEL: unpred_asr_h:
; CHECK: asr z0.h, z0.h, #8
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 8, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out   = ashr <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @pred_asr_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: pred_asr_h:
; CHECK: asr z0.h, p0/m, z0.h, #8
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 8, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.asr.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @wide_asr_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_asr_h:
; CHECK: asr z0.h, p0/m, z0.h, #8
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 8, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.asr.wide.nxv8i16(<n x 8 x i1> %pg,
                                                               <n x 8 x i16> %a,
                                                               <n x 2 x i64> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @unpred_asr_s(<n x 4 x i32> %a) {
; CHECK-LABEL: unpred_asr_s:
; CHECK: asr z0.s, z0.s, #16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 16, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out   = ashr <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @pred_asr_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: pred_asr_s:
; CHECK: asr z0.s, p0/m, z0.s, #16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 16, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.asr.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @wide_asr_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_asr_s:
; CHECK: asr z0.s, p0/m, z0.s, #16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 16, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.asr.wide.nxv4i32(<n x 4 x i1> %pg,
                                                               <n x 4 x i32> %a,
                                                               <n x 2 x i64> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @unpred_asr_d(<n x 2 x i64> %a) {
; CHECK-LABEL: unpred_asr_d:
; CHECK: asr z0.d, z0.d, #33
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 33, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out   = ashr <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @pred_asr_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: pred_asr_d:
; CHECK: asr z0.d, p0/m, z0.d, #33
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 33, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.asr.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

define <n x 16 x i8> @unpred_lsr_b(<n x 16 x i8> %a) {
; CHECK-LABEL: unpred_lsr_b:
; CHECK: lsr z0.b, z0.b, #8
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 8, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out   = lshr <n x 16 x i8> %a, %splat
  ret <n x 16 x i8> %out
}

define <n x 16 x i8> @pred_lsr_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: pred_lsr_b:
; CHECK: lsr z0.b, p0/m, z0.b, #8
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 8, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.lsr.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 16 x i8> @wide_lsr_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_lsr_b:
; CHECK: lsr z0.b, p0/m, z0.b, #8
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 8, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<n x 16 x i1> %pg,
                                                               <n x 16 x i8> %a,
                                                               <n x 2 x i64> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @unpred_lsr_h(<n x 8 x i16> %a) {
; CHECK-LABEL: unpred_lsr_h:
; CHECK: lsr z0.h, z0.h, #16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out   = lshr <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @pred_lsr_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: pred_lsr_h:
; CHECK: lsr z0.h, p0/m, z0.h, #16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.lsr.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @wide_lsr_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_lsr_h:
; CHECK: lsr z0.h, p0/m, z0.h, #16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 16, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<n x 8 x i1> %pg,
                                                               <n x 8 x i16> %a,
                                                               <n x 2 x i64> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @unpred_lsr_s(<n x 4 x i32> %a) {
; CHECK-LABEL: unpred_lsr_s:
; CHECK: lsr z0.s, z0.s, #32
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 32, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out   = lshr <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @pred_lsr_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: pred_lsr_s:
; CHECK: lsr z0.s, p0/m, z0.s, #32
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 32, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.lsr.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @wide_lsr_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_lsr_s:
; CHECK: lsr z0.s, p0/m, z0.s, #32
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 32, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<n x 4 x i1> %pg,
                                                               <n x 4 x i32> %a,
                                                               <n x 2 x i64> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @unpred_lsr_d(<n x 2 x i64> %a) {
; CHECK-LABEL: unpred_lsr_d:
; CHECK: lsr z0.d, z0.d, #64
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 64, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out   = lshr <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @pred_lsr_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: pred_lsr_d:
; CHECK: lsr z0.d, p0/m, z0.d, #64
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 64, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.lsr.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

define <n x 16 x i8> @unpred_lsl_b(<n x 16 x i8> %a) {
; CHECK-LABEL: unpred_lsl_b:
; CHECK: lsl z0.b, z0.b, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 0, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out   = shl <n x 16 x i8> %a, %splat
  ret <n x 16 x i8> %out
}

define <n x 16 x i8> @pred_lsl_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: pred_lsl_b:
; CHECK: lsl z0.b, p0/m, z0.b, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 0, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.lsl.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %splat)
  ret <n x 16 x i8> %out
}

define <n x 16 x i8> @wide_lsl_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_lsl_b:
; CHECK: lsl z0.b, p0/m, z0.b, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i8> @llvm.aarch64.sve.lsl.wide.nxv16i8(<n x 16 x i1> %pg,
                                                               <n x 16 x i8> %a,
                                                               <n x 2 x i64> %splat)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @unpred_lsl_h(<n x 8 x i16> %a) {
; CHECK-LABEL: unpred_lsl_h:
; CHECK: lsl z0.h, z0.h, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 15, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out   = shl <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @pred_lsl_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: pred_lsl_h:
; CHECK: lsl z0.h, p0/m, z0.h, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 15, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.lsl.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %splat)
  ret <n x 8 x i16> %out
}

define <n x 8 x i16> @wide_lsl_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_lsl_h:
; CHECK: lsl z0.h, p0/m, z0.h, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 15, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i16> @llvm.aarch64.sve.lsl.wide.nxv8i16(<n x 8 x i1> %pg,
                                                               <n x 8 x i16> %a,
                                                               <n x 2 x i64> %splat)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @unpred_lsl_s(<n x 4 x i32> %a) {
; CHECK-LABEL: unpred_lsl_s:
; CHECK: lsl z0.s, z0.s, #31
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 31, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out   = shl <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @pred_lsl_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: pred_lsl_s:
; CHECK: lsl z0.s, p0/m, z0.s, #31
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 31, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.lsl.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %splat)
  ret <n x 4 x i32> %out
}

define <n x 4 x i32> @wide_lsl_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_lsl_s:
; CHECK: lsl z0.s, p0/m, z0.s, #31
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 31, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i32> @llvm.aarch64.sve.lsl.wide.nxv4i32(<n x 4 x i1> %pg,
                                                               <n x 4 x i32> %a,
                                                               <n x 2 x i64> %splat)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @unpred_lsl_d(<n x 2 x i64> %a) {
; CHECK-LABEL: unpred_lsl_d:
; CHECK: lsl z0.d, z0.d, #63
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 63, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out   = shl <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

define <n x 2 x i64> @pred_lsl_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: pred_lsl_d:
; CHECK: lsl z0.d, p0/m, z0.d, #63
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 63, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 2 x i64> @llvm.aarch64.sve.lsl.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %splat)
  ret <n x 2 x i64> %out
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               Logical Ops                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
; AND
;

define <n x 16 x i8> @and_b(<n x 16 x i8> %a) {
; CHECK-LABEL: and_b:
; CHECK: and z0.b, z0.b, #0xf
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 15, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = and <n x 16 x i8> %a, %splat
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @and_h(<n x 8 x i16> %a) {
; CHECK-LABEL: and_h:
; CHECK: and z0.h, z0.h, #0xfc07
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 64519, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = and <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @and_s(<n x 4 x i32> %a) {
; CHECK-LABEL: and_s:
; CHECK: and z0.s, z0.s, #0xffff00
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 16776960, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = and <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @and_d(<n x 2 x i64> %a) {
; CHECK-LABEL: and_d:
; CHECK: and z0.d, z0.d, #0xfffc000000000000
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 18445618173802708992, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = and <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

;
; EOR
;

define <n x 16 x i8> @eor_b(<n x 16 x i8> %a) {
; CHECK-LABEL: eor_b:
; CHECK: eor z0.b, z0.b, #0xf
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 15, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = xor <n x 16 x i8> %a, %splat
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @eor_h(<n x 8 x i16> %a) {
; CHECK-LABEL: eor_h:
; CHECK: eor z0.h, z0.h, #0xfc07
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 64519, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = xor <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @eor_s(<n x 4 x i32> %a) {
; CHECK-LABEL: eor_s:
; CHECK: eor z0.s, z0.s, #0xffff00
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 16776960, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = xor <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @eor_d(<n x 2 x i64> %a) {
; CHECK-LABEL: eor_d:
; CHECK: eor z0.d, z0.d, #0xfffc000000000000
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 18445618173802708992, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = xor <n x 2 x i64> %a, %splat
  ret <n x 2 x i64> %out
}

;
; ORR
;

define <n x 16 x i8> @orr_b(<n x 16 x i8> %a) {
; CHECK-LABEL: orr_b:
; CHECK: orr z0.b, z0.b, #0xf
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 15, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i8> zeroinitializer
  %out = or <n x 16 x i8> %a, %splat
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @orr_h(<n x 8 x i16> %a) {
; CHECK-LABEL: orr_h:
; CHECK: orr z0.h, z0.h, #0xfc07
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 64519, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i16> zeroinitializer
  %out = or <n x 8 x i16> %a, %splat
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @orr_s(<n x 4 x i32> %a) {
; CHECK-LABEL: orr_s:
; CHECK: orr z0.s, z0.s, #0xffff00
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 16776960, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = or <n x 4 x i32> %a, %splat
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @orr_d(<n x 2 x i64> %a) {
; CHECK-LABEL: orr_d:
; CHECK: orr z0.d, z0.d, #0xfffc000000000000
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 18445618173802708992, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = or <n x 2 x i64> %a, %splat
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

declare <n x 16 x i8> @llvm.aarch64.sve.asr.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.asr.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.asr.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.asr.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.asr.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i16> @llvm.aarch64.sve.asr.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i32> @llvm.aarch64.sve.asr.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.lsr.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.lsr.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.lsr.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.lsr.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.lsr.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i16> @llvm.aarch64.sve.lsr.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i32> @llvm.aarch64.sve.lsr.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.lsl.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.lsl.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.lsl.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.lsl.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.lsl.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i16> @llvm.aarch64.sve.lsl.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i32> @llvm.aarch64.sve.lsl.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)
