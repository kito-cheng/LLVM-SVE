; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; CMPEQ
;

define <n x 16 x i1> @cmpeq_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: cmpeq_b:
; CHECK: cmpeq p0.b, p0/z, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpeq.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmpeq_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: cmpeq_h:
; CHECK: cmpeq p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpeq.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmpeq_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: cmpeq_s:
; CHECK: cmpeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpeq.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @cmpeq_d(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpeq_d:
; CHECK: cmpeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpeq.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i1> %out
}

define <n x 16 x i1> @cmpeq_wide_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpeq_wide_b:
; CHECK: cmpeq p0.b, p0/z, z0.b, z1.d
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpeq.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmpeq_wide_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpeq_wide_h:
; CHECK: cmpeq p0.h, p0/z, z0.h, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpeq.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmpeq_wide_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpeq_wide_s:
; CHECK: cmpeq p0.s, p0/z, z0.s, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpeq.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 4 x i1> %out
}

;
; CMPGE
;

define <n x 16 x i1> @cmpge_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: cmpge_b:
; CHECK: cmpge p0.b, p0/z, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpge.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmpge_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: cmpge_h:
; CHECK: cmpge p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpge.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmpge_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: cmpge_s:
; CHECK: cmpge p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpge.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @cmpge_d(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpge_d:
; CHECK: cmpge p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpge.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i1> %out
}

define <n x 16 x i1> @cmpge_wide_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpge_wide_b:
; CHECK: cmpge p0.b, p0/z, z0.b, z1.d
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpge.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmpge_wide_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpge_wide_h:
; CHECK: cmpge p0.h, p0/z, z0.h, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpge.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmpge_wide_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpge_wide_s:
; CHECK: cmpge p0.s, p0/z, z0.s, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpge.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 4 x i1> %out
}

;
; CMPGT
;

define <n x 16 x i1> @cmpgt_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: cmpgt_b:
; CHECK: cmpgt p0.b, p0/z, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpgt.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmpgt_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: cmpgt_h:
; CHECK: cmpgt p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpgt.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmpgt_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: cmpgt_s:
; CHECK: cmpgt p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpgt.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @cmpgt_d(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpgt_d:
; CHECK: cmpgt p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpgt.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i1> %out
}

define <n x 16 x i1> @cmpgt_wide_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpgt_wide_b:
; CHECK: cmpgt p0.b, p0/z, z0.b, z1.d
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpgt.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmpgt_wide_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpgt_wide_h:
; CHECK: cmpgt p0.h, p0/z, z0.h, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpgt.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmpgt_wide_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpgt_wide_s:
; CHECK: cmpgt p0.s, p0/z, z0.s, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpgt.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 4 x i1> %out
}

;
; CMPHI
;

define <n x 16 x i1> @cmphi_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: cmphi_b:
; CHECK: cmphi p0.b, p0/z, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmphi.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmphi_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: cmphi_h:
; CHECK: cmphi p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmphi.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmphi_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: cmphi_s:
; CHECK: cmphi p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmphi.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @cmphi_d(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmphi_d:
; CHECK: cmphi p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmphi.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i1> %out
}

define <n x 16 x i1> @cmphi_wide_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmphi_wide_b:
; CHECK: cmphi p0.b, p0/z, z0.b, z1.d
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmphi.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmphi_wide_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmphi_wide_h:
; CHECK: cmphi p0.h, p0/z, z0.h, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmphi.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmphi_wide_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmphi_wide_s:
; CHECK: cmphi p0.s, p0/z, z0.s, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmphi.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 4 x i1> %out
}

;
; CMPHS
;

define <n x 16 x i1> @cmphs_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: cmphs_b:
; CHECK: cmphs p0.b, p0/z, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmphs.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmphs_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: cmphs_h:
; CHECK: cmphs p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmphs.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmphs_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: cmphs_s:
; CHECK: cmphs p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmphs.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @cmphs_d(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmphs_d:
; CHECK: cmphs p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmphs.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i1> %out
}

define <n x 16 x i1> @cmphs_wide_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmphs_wide_b:
; CHECK: cmphs p0.b, p0/z, z0.b, z1.d
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmphs.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmphs_wide_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmphs_wide_h:
; CHECK: cmphs p0.h, p0/z, z0.h, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmphs.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmphs_wide_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmphs_wide_s:
; CHECK: cmphs p0.s, p0/z, z0.s, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmphs.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 4 x i1> %out
}

;
; CMPLE
;

define <n x 16 x i1> @cmple_wide_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmple_wide_b:
; CHECK: cmple p0.b, p0/z, z0.b, z1.d
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmple.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmple_wide_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmple_wide_h:
; CHECK: cmple p0.h, p0/z, z0.h, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmple.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmple_wide_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmple_wide_s:
; CHECK: cmple p0.s, p0/z, z0.s, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmple.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 4 x i1> %out
}

;
; CMPLO
;


define <n x 16 x i1> @cmplo_wide_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmplo_wide_b:
; CHECK: cmplo p0.b, p0/z, z0.b, z1.d
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmplo.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmplo_wide_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmplo_wide_h:
; CHECK: cmplo p0.h, p0/z, z0.h, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmplo.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmplo_wide_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmplo_wide_s:
; CHECK: cmplo p0.s, p0/z, z0.s, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmplo.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 4 x i1> %out
}

;
; CMPLS
;

define <n x 16 x i1> @cmpls_wide_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpls_wide_b:
; CHECK: cmpls p0.b, p0/z, z0.b, z1.d
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpls.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmpls_wide_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpls_wide_h:
; CHECK: cmpls p0.h, p0/z, z0.h, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpls.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmpls_wide_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpls_wide_s:
; CHECK: cmpls p0.s, p0/z, z0.s, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpls.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 4 x i1> %out
}

;
; CMPLT
;

define <n x 16 x i1> @cmplt_wide_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmplt_wide_b:
; CHECK: cmplt p0.b, p0/z, z0.b, z1.d
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmplt.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmplt_wide_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmplt_wide_h:
; CHECK: cmplt p0.h, p0/z, z0.h, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmplt.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmplt_wide_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmplt_wide_s:
; CHECK: cmplt p0.s, p0/z, z0.s, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmplt.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 4 x i1> %out
}

;
; CMPNE
;

define <n x 16 x i1> @cmpne_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: cmpne_b:
; CHECK: cmpne p0.b, p0/z, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpne.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmpne_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: cmpne_h:
; CHECK: cmpne p0.h, p0/z, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpne.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmpne_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: cmpne_s:
; CHECK: cmpne p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpne.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @cmpne_d(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpne_d:
; CHECK: cmpne p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpne.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i1> %out
}

define <n x 16 x i1> @cmpne_wide_b(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpne_wide_b:
; CHECK: cmpne p0.b, p0/z, z0.b, z1.d
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.cmpne.wide.nxv16i8(<n x 16 x i1> %pg,
                                                                 <n x 16 x i8> %a,
                                                                 <n x 2 x i64> %b)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @cmpne_wide_h(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpne_wide_h:
; CHECK: cmpne p0.h, p0/z, z0.h, z1.d
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpne.wide.nxv8i16(<n x 8 x i1> %pg,
                                                                <n x 8 x i16> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @cmpne_wide_s(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: cmpne_wide_s:
; CHECK: cmpne p0.s, p0/z, z0.s, z1.d
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpne.wide.nxv4i32(<n x 4 x i1> %pg,
                                                                <n x 4 x i32> %a,
                                                                <n x 2 x i64> %b)
  ret <n x 4 x i1> %out
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
