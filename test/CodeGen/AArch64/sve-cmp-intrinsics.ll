; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             Signed Comparisons                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
; CMPEQ
;

define <n x 16 x i1> @ir_cmpeq_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ir_cmpeq_b
; CHECK: cmpeq p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = icmp eq <n x 16 x i8> %a, %splat
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @int_cmpeq_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: int_cmpeq_b
; CHECK: cmpeq p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpeq.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @wide_cmpeq_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_cmpeq_b
; CHECK: cmpeq p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpeq.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %splat)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ir_cmpeq_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ir_cmpeq_h
; CHECK: cmpeq p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = icmp eq <n x 8 x i16> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @int_cmpeq_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: int_cmpeq_h
; CHECK: cmpeq p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpeq.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %splat)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @wide_cmpeq_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_cmpeq_h
; CHECK: cmpeq p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 -16, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpeq.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ir_cmpeq_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ir_cmpeq_s
; CHECK: cmpeq p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = icmp eq <n x 4 x i32> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @int_cmpeq_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: int_cmpeq_s
; CHECK: cmpeq p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpeq.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %splat)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @wide_cmpeq_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_cmpeq_s
; CHECK: cmpeq p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 15, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpeq.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ir_cmpeq_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ir_cmpeq_d
; CHECK: cmpeq p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = icmp eq <n x 2 x i64> %a, %splat
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @int_cmpeq_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: int_cmpeq_d
; CHECK: cmpeq p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpeq.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %splat)
  ret <n x 2 x i1> %out
}

;
; CMPGE
;

define <n x 16 x i1> @ir_cmpge_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ir_cmpge_b
; CHECK: cmpge p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = icmp sge <n x 16 x i8> %a, %splat
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @int_cmpge_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: int_cmpge_b
; CHECK: cmpge p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpge.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @wide_cmpge_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_cmpge_b
; CHECK: cmpge p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpge.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %splat)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ir_cmpge_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ir_cmpge_h
; CHECK: cmpge p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = icmp sge <n x 8 x i16> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @int_cmpge_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: int_cmpge_h
; CHECK: cmpge p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpge.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %splat)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @wide_cmpge_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_cmpge_h
; CHECK: cmpge p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 -16, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpge.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ir_cmpge_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ir_cmpge_s
; CHECK: cmpge p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = icmp sge <n x 4 x i32> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @int_cmpge_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: int_cmpge_s
; CHECK: cmpge p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpge.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %splat)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @wide_cmpge_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_cmpge_s
; CHECK: cmpge p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 15, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpge.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ir_cmpge_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ir_cmpge_d
; CHECK: cmpge p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = icmp sge <n x 2 x i64> %a, %splat
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @int_cmpge_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: int_cmpge_d
; CHECK: cmpge p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpge.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %splat)
  ret <n x 2 x i1> %out
}

;
; CMPGT
;

define <n x 16 x i1> @ir_cmpgt_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ir_cmpgt_b
; CHECK: cmpgt p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = icmp sgt <n x 16 x i8> %a, %splat
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @int_cmpgt_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: int_cmpgt_b
; CHECK: cmpgt p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpgt.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @wide_cmpgt_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_cmpgt_b
; CHECK: cmpgt p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpgt.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %splat)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ir_cmpgt_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ir_cmpgt_h
; CHECK: cmpgt p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = icmp sgt <n x 8 x i16> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @int_cmpgt_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: int_cmpgt_h
; CHECK: cmpgt p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpgt.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %splat)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @wide_cmpgt_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_cmpgt_h
; CHECK: cmpgt p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 -16, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpgt.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ir_cmpgt_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ir_cmpgt_s
; CHECK: cmpgt p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = icmp sgt <n x 4 x i32> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @int_cmpgt_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: int_cmpgt_s
; CHECK: cmpgt p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpgt.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %splat)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @wide_cmpgt_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_cmpgt_s
; CHECK: cmpgt p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 15, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpgt.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ir_cmpgt_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ir_cmpgt_d
; CHECK: cmpgt p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = icmp sgt <n x 2 x i64> %a, %splat
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @int_cmpgt_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: int_cmpgt_d
; CHECK: cmpgt p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpgt.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %splat)
  ret <n x 2 x i1> %out
}

;
; CMPLE
;

define <n x 16 x i1> @ir_cmple_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ir_cmple_b
; CHECK: cmple p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = icmp sle <n x 16 x i8> %a, %splat
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @int_cmple_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: int_cmple_b
; CHECK: cmple p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpge.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %splat,
                                                            <n x 16 x i8> %a)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @wide_cmple_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_cmple_b
; CHECK: cmple p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmple.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %splat)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ir_cmple_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ir_cmple_h
; CHECK: cmple p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = icmp sle <n x 8 x i16> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @int_cmple_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: int_cmple_h
; CHECK: cmple p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpge.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %splat,
                                                           <n x 8 x i16> %a)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @wide_cmple_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_cmple_h
; CHECK: cmple p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 -16, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmple.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ir_cmple_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ir_cmple_s
; CHECK: cmple p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = icmp sle <n x 4 x i32> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @int_cmple_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: int_cmple_s
; CHECK: cmple p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpge.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %splat,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @wide_cmple_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_cmple_s
; CHECK: cmple p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 15, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmple.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ir_cmple_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ir_cmple_d
; CHECK: cmple p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = icmp sle <n x 2 x i64> %a, %splat
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @int_cmple_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: int_cmple_d
; CHECK: cmple p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpge.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %splat,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i1> %out
}

;
; CMPLT
;

define <n x 16 x i1> @ir_cmplt_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ir_cmplt_b
; CHECK: cmplt p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = icmp slt <n x 16 x i8> %a, %splat
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @int_cmplt_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: int_cmplt_b
; CHECK: cmplt p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpgt.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %splat,
                                                            <n x 16 x i8> %a)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @wide_cmplt_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_cmplt_b
; CHECK: cmplt p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmplt.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %splat)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ir_cmplt_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ir_cmplt_h
; CHECK: cmplt p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = icmp slt <n x 8 x i16> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @int_cmplt_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: int_cmplt_h
; CHECK: cmplt p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpgt.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %splat,
                                                           <n x 8 x i16> %a)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @wide_cmplt_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_cmplt_h
; CHECK: cmplt p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 -16, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmplt.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ir_cmplt_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ir_cmplt_s
; CHECK: cmplt p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = icmp slt <n x 4 x i32> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @int_cmplt_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: int_cmplt_s
; CHECK: cmplt p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpgt.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %splat,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @wide_cmplt_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_cmplt_s
; CHECK: cmplt p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 15, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmplt.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ir_cmplt_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ir_cmplt_d
; CHECK: cmplt p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = icmp slt <n x 2 x i64> %a, %splat
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @int_cmplt_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: int_cmplt_d
; CHECK: cmplt p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpgt.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %splat,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i1> %out
}

;
; CMPNE
;

define <n x 16 x i1> @ir_cmpne_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ir_cmpne_b
; CHECK: cmpne p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = icmp ne <n x 16 x i8> %a, %splat
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @int_cmpne_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: int_cmpne_b
; CHECK: cmpne p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpne.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @wide_cmpne_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_cmpne_b
; CHECK: cmpne p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpne.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %splat)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ir_cmpne_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ir_cmpne_h
; CHECK: cmpne p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = icmp ne <n x 8 x i16> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @int_cmpne_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: int_cmpne_h
; CHECK: cmpne p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 -16, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpne.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %splat)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @wide_cmpne_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_cmpne_h
; CHECK: cmpne p0.h, p0/z, z0.h, #-16
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 -16, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpne.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ir_cmpne_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ir_cmpne_s
; CHECK: cmpne p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = icmp ne <n x 4 x i32> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @int_cmpne_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: int_cmpne_s
; CHECK: cmpne p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 15, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpne.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %splat)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @wide_cmpne_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_cmpne_s
; CHECK: cmpne p0.s, p0/z, z0.s, #15
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 15, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpne.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ir_cmpne_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ir_cmpne_d
; CHECK: cmpne p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = icmp ne <n x 2 x i64> %a, %splat
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @int_cmpne_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: int_cmpne_d
; CHECK: cmpne p0.d, p0/z, z0.d, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpne.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %splat)
  ret <n x 2 x i1> %out
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            Unsigned Comparisons                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
; CMPHI
;

define <n x 16 x i1> @ir_cmphi_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ir_cmphi_b
; CHECK: cmphi p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = icmp ugt <n x 16 x i8> %a, %splat
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @int_cmphi_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: int_cmphi_b
; CHECK: cmphi p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmphi.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @wide_cmphi_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_cmphi_b
; CHECK: cmphi p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmphi.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %splat)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ir_cmphi_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ir_cmphi_h
; CHECK: cmphi p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 0, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = icmp ugt <n x 8 x i16> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @int_cmphi_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: int_cmphi_h
; CHECK: cmphi p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 0, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmphi.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %splat)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @wide_cmphi_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_cmphi_h
; CHECK: cmphi p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmphi.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ir_cmphi_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ir_cmphi_s
; CHECK: cmphi p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 68, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = icmp ugt <n x 4 x i32> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @int_cmphi_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: int_cmphi_s
; CHECK: cmphi p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 68, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmphi.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %splat)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @wide_cmphi_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_cmphi_s
; CHECK: cmphi p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 68, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmphi.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ir_cmphi_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ir_cmphi_d
; CHECK: cmphi p0.d, p0/z, z0.d, #127
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 127, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = icmp ugt <n x 2 x i64> %a, %splat
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @int_cmphi_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: int_cmphi_d
; CHECK: cmphi p0.d, p0/z, z0.d, #127
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 127, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmphi.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %splat)
  ret <n x 2 x i1> %out
}

;
; CMPHS
;

define <n x 16 x i1> @ir_cmphs_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ir_cmphs_b
; CHECK: cmphs p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = icmp uge <n x 16 x i8> %a, %splat
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @int_cmphs_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: int_cmphs_b
; CHECK: cmphs p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmphs.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %splat)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @wide_cmphs_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_cmphs_b
; CHECK: cmphs p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmphs.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %splat)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ir_cmphs_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ir_cmphs_h
; CHECK: cmphs p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 0, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = icmp uge <n x 8 x i16> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @int_cmphs_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: int_cmphs_h
; CHECK: cmphs p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 0, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmphs.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %splat)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @wide_cmphs_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_cmphs_h
; CHECK: cmphs p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmphs.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ir_cmphs_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ir_cmphs_s
; CHECK: cmphs p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 68, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = icmp uge <n x 4 x i32> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @int_cmphs_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: int_cmphs_s
; CHECK: cmphs p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 68, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmphs.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %splat)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @wide_cmphs_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_cmphs_s
; CHECK: cmphs p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 68, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmphs.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ir_cmphs_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ir_cmphs_d
; CHECK: cmphs p0.d, p0/z, z0.d, #127
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 127, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = icmp uge <n x 2 x i64> %a, %splat
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @int_cmphs_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: int_cmphs_d
; CHECK: cmphs p0.d, p0/z, z0.d, #127
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 127, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmphs.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %splat)
  ret <n x 2 x i1> %out
}

;
; CMPLO
;

define <n x 16 x i1> @ir_cmplo_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ir_cmplo_b
; CHECK: cmplo p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = icmp ult <n x 16 x i8> %a, %splat
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @int_cmplo_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: int_cmplo_b
; CHECK: cmplo p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmphi.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %splat,
                                                            <n x 16 x i8> %a)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @wide_cmplo_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_cmplo_b
; CHECK: cmplo p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmplo.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %splat)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ir_cmplo_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ir_cmplo_h
; CHECK: cmplo p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 0, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = icmp ult <n x 8 x i16> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @int_cmplo_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: int_cmplo_h
; CHECK: cmplo p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 0, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmphi.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %splat,
                                                           <n x 8 x i16> %a)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @wide_cmplo_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_cmplo_h
; CHECK: cmplo p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmplo.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ir_cmplo_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ir_cmplo_s
; CHECK: cmplo p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 68, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = icmp ult <n x 4 x i32> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @int_cmplo_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: int_cmplo_s
; CHECK: cmplo p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 68, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmphi.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %splat,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @wide_cmplo_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_cmplo_s
; CHECK: cmplo p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 68, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmplo.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ir_cmplo_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ir_cmplo_d
; CHECK: cmplo p0.d, p0/z, z0.d, #127
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 127, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = icmp ult <n x 2 x i64> %a, %splat
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @int_cmplo_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: int_cmplo_d
; CHECK: cmplo p0.d, p0/z, z0.d, #127
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 127, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmphi.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %splat,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i1> %out
}

;
; CMPLS
;

define <n x 16 x i1> @ir_cmpls_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ir_cmpls_b
; CHECK: cmpls p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = icmp ule <n x 16 x i8> %a, %splat
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @int_cmpls_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: int_cmpls_b
; CHECK: cmpls p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 16 x i8> undef, i8 4, i32 0
  %splat = shufflevector <n x 16 x i8> %elt, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmphs.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %splat,
                                                            <n x 16 x i8> %a)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @wide_cmpls_b(<n x 16 x i1> %pg, <n x 16 x i8> %a) {
; CHECK-LABEL: wide_cmpls_b
; CHECK: cmpls p0.b, p0/z, z0.b, #4
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpls.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %splat)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @ir_cmpls_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ir_cmpls_h
; CHECK: cmpls p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 0, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = icmp ule <n x 8 x i16> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @int_cmpls_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: int_cmpls_h
; CHECK: cmpls p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x i16> undef, i16 0, i32 0
  %splat = shufflevector <n x 8 x i16> %elt, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmphs.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %splat,
                                                           <n x 8 x i16> %a)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @wide_cmpls_h(<n x 8 x i1> %pg, <n x 8 x i16> %a) {
; CHECK-LABEL: wide_cmpls_h
; CHECK: cmpls p0.h, p0/z, z0.h, #0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpls.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @ir_cmpls_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ir_cmpls_s
; CHECK: cmpls p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 68, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = icmp ule <n x 4 x i32> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @int_cmpls_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: int_cmpls_s
; CHECK: cmpls p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x i32> undef, i32 68, i32 0
  %splat = shufflevector <n x 4 x i32> %elt, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmphs.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %splat,
                                                           <n x 4 x i32> %a)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @wide_cmpls_s(<n x 4 x i1> %pg, <n x 4 x i32> %a) {
; CHECK-LABEL: wide_cmpls_s
; CHECK: cmpls p0.s, p0/z, z0.s, #68
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 68, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i64> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpls.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @ir_cmpls_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ir_cmpls_d
; CHECK: cmpls p0.d, p0/z, z0.d, #127
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 127, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = icmp ule <n x 2 x i64> %a, %splat
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @int_cmpls_d(<n x 2 x i1> %pg, <n x 2 x i64> %a) {
; CHECK-LABEL: int_cmpls_d
; CHECK: cmpls p0.d, p0/z, z0.d, #127
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x i64> undef, i64 127, i32 0
  %splat = shufflevector <n x 2 x i64> %elt, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmphs.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %splat,
                                                           <n x 2 x i64> %a)
  ret <n x 2 x i1> %out
}

declare <n x 16 x i1> @llvm.aarch64.sve.cmpeq.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmpeq.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpeq.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpeq.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)
declare <n x 16 x i1> @llvm.aarch64.sve.cmpeq.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmpeq.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpeq.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i1> @llvm.aarch64.sve.cmpge.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmpge.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpge.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpge.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)
declare <n x 16 x i1> @llvm.aarch64.sve.cmpge.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmpge.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpge.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i1> @llvm.aarch64.sve.cmpgt.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmpgt.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpgt.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpgt.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)
declare <n x 16 x i1> @llvm.aarch64.sve.cmpgt.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmpgt.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpgt.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i1> @llvm.aarch64.sve.cmphi.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmphi.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmphi.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmphi.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)
declare <n x 16 x i1> @llvm.aarch64.sve.cmphi.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmphi.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmphi.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i1> @llvm.aarch64.sve.cmphs.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmphs.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmphs.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmphs.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)
declare <n x 16 x i1> @llvm.aarch64.sve.cmphs.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmphs.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmphs.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i1> @llvm.aarch64.sve.cmple.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmple.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmple.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i1> @llvm.aarch64.sve.cmplo.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmplo.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmplo.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i1> @llvm.aarch64.sve.cmpls.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmpls.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpls.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i1> @llvm.aarch64.sve.cmplt.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmplt.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmplt.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)

declare <n x 16 x i1> @llvm.aarch64.sve.cmpne.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmpne.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpne.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpne.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)
declare <n x 16 x i1> @llvm.aarch64.sve.cmpne.wide.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 2 x i64>)
declare <n x 8 x i1> @llvm.aarch64.sve.cmpne.wide.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 2 x i64>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpne.wide.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 2 x i64>)
