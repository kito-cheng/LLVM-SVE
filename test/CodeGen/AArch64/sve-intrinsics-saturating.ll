; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -asm-verbose=0 < %s | FileCheck %s

;
; SQDECH (vector)
;

define <n x 8 x i16> @sqdech(<n x 8 x i16> %a) {
; CHECK-LABEL: sqdech:
; CHECK: sqdech z0.h, pow2
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqdech.nxv8i16(<n x 8 x i16> %a,
                                                             i32 0, i32 1)
  ret <n x 8 x i16> %out
}

;
; SQDECW (vector)
;

define <n x 4 x i32> @sqdecw(<n x 4 x i32> %a) {
; CHECK-LABEL: sqdecw:
; CHECK: sqdecw z0.s, vl1, mul #2
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqdecw.nxv4i32(<n x 4 x i32> %a,
                                                             i32 1, i32 2)
  ret <n x 4 x i32> %out
}

;
; SQDECD (vector)
;

define <n x 2 x i64> @sqdecd(<n x 2 x i64> %a) {
; CHECK-LABEL: sqdecd:
; CHECK: sqdecd z0.d, vl2, mul #3
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqdecd.nxv2i64(<n x 2 x i64> %a,
                                                             i32 2, i32 3)
  ret <n x 2 x i64> %out
}

;
; SQDECP (vector)
;

define <n x 8 x i16> @sqdecp_b16(<n x 8 x i16> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: sqdecp_b16:
; CHECK: sqdecp z0.h, p0
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqdecp.nxv8i16(<n x 8 x i16> %a,
                                                             <n x 8 x i1> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sqdecp_b32(<n x 4 x i32> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: sqdecp_b32:
; CHECK: sqdecp z0.s, p0
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqdecp.nxv4i32(<n x 4 x i32> %a,
                                                             <n x 4 x i1> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sqdecp_b64(<n x 2 x i64> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: sqdecp_b64:
; CHECK: sqdecp z0.d, p0
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqdecp.nxv2i64(<n x 2 x i64> %a,
                                                             <n x 2 x i1> %b)
  ret <n x 2 x i64> %out
}

;
; SQDECB (scalar)
;

define i32 @sqdecb_n32(i32 %a) {
; CHECK-LABEL: sqdecb_n32:
; CHECK: sqdecb x0, w0, vl3, mul #4
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqdecb.n32(i32 %a, i32 3, i32 4)
  ret i32 %out
}

define i64 @sqdecb_n64(i64 %a) {
; CHECK-LABEL: sqdecb_n64:
; CHECK: sqdecb x0, vl4, mul #5
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqdecb.n64(i64 %a, i32 4, i32 5)
  ret i64 %out
}

;
; SQDECH (scalar)
;

define i32 @sqdech_n32(i32 %a) {
; CHECK-LABEL: sqdech_n32:
; CHECK: sqdech x0, w0, vl5, mul #6
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqdech.n32(i32 %a, i32 5, i32 6)
  ret i32 %out
}

define i64 @sqdech_n64(i64 %a) {
; CHECK-LABEL: sqdech_n64:
; CHECK: sqdech x0, vl6, mul #7
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqdech.n64(i64 %a, i32 6, i32 7)
  ret i64 %out
}

;
; SQDECW (scalar)
;

define i32 @sqdecw_n32(i32 %a) {
; CHECK-LABEL: sqdecw_n32:
; CHECK: sqdecw x0, w0, vl7, mul #8
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqdecw.n32(i32 %a, i32 7, i32 8)
  ret i32 %out
}

define i64 @sqdecw_n64(i64 %a) {
; CHECK-LABEL: sqdecw_n64:
; CHECK: sqdecw x0, vl8, mul #9
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqdecw.n64(i64 %a, i32 8, i32 9)
  ret i64 %out
}

;
; SQDECD (scalar)
;

define i32 @sqdecd_n32(i32 %a) {
; CHECK-LABEL: sqdecd_n32:
; CHECK: sqdecd x0, w0, vl16, mul #10
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqdecd.n32(i32 %a, i32 9, i32 10)
  ret i32 %out
}

define i64 @sqdecd_n64(i64 %a) {
; CHECK-LABEL: sqdecd_n64:
; CHECK: sqdecd x0, vl32, mul #11
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqdecd.n64(i64 %a, i32 10, i32 11)
  ret i64 %out
}

;
; SQDECP (scalar)
;

define i32 @sqdecp_n32_b8(i32 %a, <n x 16 x i1> %b) {
; CHECK-LABEL: sqdecp_n32_b8:
; CHECK: sqdecp x0, p0.b, w0
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv16i1(i32 %a, <n x 16 x i1> %b)
  ret i32 %out
}

define i32 @sqdecp_n32_b16(i32 %a, <n x 8 x i1> %b) {
; CHECK-LABEL: sqdecp_n32_b16:
; CHECK: sqdecp x0, p0.h, w0
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv8i1(i32 %a, <n x 8 x i1> %b)
  ret i32 %out
}

define i32 @sqdecp_n32_b32(i32 %a, <n x 4 x i1> %b) {
; CHECK-LABEL: sqdecp_n32_b32:
; CHECK: sqdecp x0, p0.s, w0
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv4i1(i32 %a, <n x 4 x i1> %b)
  ret i32 %out
}

define i32 @sqdecp_n32_b64(i32 %a, <n x 2 x i1> %b) {
; CHECK-LABEL: sqdecp_n32_b64:
; CHECK: sqdecp x0, p0.d, w0
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqdecp.n32.nxv2i1(i32 %a, <n x 2 x i1> %b)
  ret i32 %out
}

define i64 @sqdecp_n64_b8(i64 %a, <n x 16 x i1> %b) {
; CHECK-LABEL: sqdecp_n64_b8:
; CHECK: sqdecp x0, p0.b
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv16i1(i64 %a, <n x 16 x i1> %b)
  ret i64 %out
}

define i64 @sqdecp_n64_b16(i64 %a, <n x 8 x i1> %b) {
; CHECK-LABEL: sqdecp_n64_b16:
; CHECK: sqdecp x0, p0.h
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv8i1(i64 %a, <n x 8 x i1> %b)
  ret i64 %out
}

define i64 @sqdecp_n64_b32(i64 %a, <n x 4 x i1> %b) {
; CHECK-LABEL: sqdecp_n64_b32:
; CHECK: sqdecp x0, p0.s
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv4i1(i64 %a, <n x 4 x i1> %b)
  ret i64 %out
}

define i64 @sqdecp_n64_b64(i64 %a, <n x 2 x i1> %b) {
; CHECK-LABEL: sqdecp_n64_b64:
; CHECK: sqdecp x0, p0.d
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqdecp.n64.nxv2i1(i64 %a, <n x 2 x i1> %b)
  ret i64 %out
}

;
; SQINCH (vector)
;

define <n x 8 x i16> @sqinch(<n x 8 x i16> %a) {
; CHECK-LABEL: sqinch:
; CHECK: sqinch z0.h, pow2
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqinch.nxv8i16(<n x 8 x i16> %a,
                                                             i32 0, i32 1)
  ret <n x 8 x i16> %out
}

;
; SQINCW (vector)
;

define <n x 4 x i32> @sqincw(<n x 4 x i32> %a) {
; CHECK-LABEL: sqincw:
; CHECK: sqincw z0.s, vl1, mul #2
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqincw.nxv4i32(<n x 4 x i32> %a,
                                                             i32 1, i32 2)
  ret <n x 4 x i32> %out
}

;
; SQINCD (vector)
;

define <n x 2 x i64> @sqincd(<n x 2 x i64> %a) {
; CHECK-LABEL: sqincd:
; CHECK: sqincd z0.d, vl2, mul #3
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqincd.nxv2i64(<n x 2 x i64> %a,
                                                             i32 2, i32 3)
  ret <n x 2 x i64> %out
}

;
; SQINCP (vector)
;

define <n x 8 x i16> @sqincp_b16(<n x 8 x i16> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: sqincp_b16:
; CHECK: sqincp z0.h, p0
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqincp.nxv8i16(<n x 8 x i16> %a,
                                                             <n x 8 x i1> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sqincp_b32(<n x 4 x i32> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: sqincp_b32:
; CHECK: sqincp z0.s, p0
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqincp.nxv4i32(<n x 4 x i32> %a,
                                                             <n x 4 x i1> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sqincp_b64(<n x 2 x i64> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: sqincp_b64:
; CHECK: sqincp z0.d, p0
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqincp.nxv2i64(<n x 2 x i64> %a,
                                                             <n x 2 x i1> %b)
  ret <n x 2 x i64> %out
}

;
; SQINCB (scalar)
;

define i32 @sqincb_n32(i32 %a) {
; CHECK-LABEL: sqincb_n32:
; CHECK: sqincb x0, w0, vl3, mul #4
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqincb.n32(i32 %a, i32 3, i32 4)
  ret i32 %out
}

define i64 @sqincb_n64(i64 %a) {
; CHECK-LABEL: sqincb_n64:
; CHECK: sqincb x0, vl4, mul #5
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqincb.n64(i64 %a, i32 4, i32 5)
  ret i64 %out
}

;
; SQINCH (scalar)
;

define i32 @sqinch_n32(i32 %a) {
; CHECK-LABEL: sqinch_n32:
; CHECK: sqinch x0, w0, vl5, mul #6
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqinch.n32(i32 %a, i32 5, i32 6)
  ret i32 %out
}

define i64 @sqinch_n64(i64 %a) {
; CHECK-LABEL: sqinch_n64:
; CHECK: sqinch x0, vl6, mul #7
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqinch.n64(i64 %a, i32 6, i32 7)
  ret i64 %out
}

;
; SQINCW (scalar)
;

define i32 @sqincw_n32(i32 %a) {
; CHECK-LABEL: sqincw_n32:
; CHECK: sqincw x0, w0, vl7, mul #8
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqincw.n32(i32 %a, i32 7, i32 8)
  ret i32 %out
}

define i64 @sqincw_n64(i64 %a) {
; CHECK-LABEL: sqincw_n64:
; CHECK: sqincw x0, vl8, mul #9
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqincw.n64(i64 %a, i32 8, i32 9)
  ret i64 %out
}

;
; SQINCD (scalar)
;

define i32 @sqincd_n32(i32 %a) {
; CHECK-LABEL: sqincd_n32:
; CHECK: sqincd x0, w0, vl16, mul #10
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqincd.n32(i32 %a, i32 9, i32 10)
  ret i32 %out
}

define i64 @sqincd_n64(i64 %a) {
; CHECK-LABEL: sqincd_n64:
; CHECK: sqincd x0, vl32, mul #11
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqincd.n64(i64 %a, i32 10, i32 11)
  ret i64 %out
}

;
; SQINCP (scalar)
;

define i32 @sqincp_n32_b8(i32 %a, <n x 16 x i1> %b) {
; CHECK-LABEL: sqincp_n32_b8:
; CHECK: sqincp x0, p0.b, w0
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqincp.n32.nxv16i1(i32 %a, <n x 16 x i1> %b)
  ret i32 %out
}

define i32 @sqincp_n32_b16(i32 %a, <n x 8 x i1> %b) {
; CHECK-LABEL: sqincp_n32_b16:
; CHECK: sqincp x0, p0.h, w0
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqincp.n32.nxv8i1(i32 %a, <n x 8 x i1> %b)
  ret i32 %out
}

define i32 @sqincp_n32_b32(i32 %a, <n x 4 x i1> %b) {
; CHECK-LABEL: sqincp_n32_b32:
; CHECK: sqincp x0, p0.s, w0
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqincp.n32.nxv4i1(i32 %a, <n x 4 x i1> %b)
  ret i32 %out
}

define i32 @sqincp_n32_b64(i32 %a, <n x 2 x i1> %b) {
; CHECK-LABEL: sqincp_n32_b64:
; CHECK: sqincp x0, p0.d, w0
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.sqincp.n32.nxv2i1(i32 %a, <n x 2 x i1> %b)
  ret i32 %out
}

define i64 @sqincp_n64_b8(i64 %a, <n x 16 x i1> %b) {
; CHECK-LABEL: sqincp_n64_b8:
; CHECK: sqincp x0, p0.b
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqincp.n64.nxv16i1(i64 %a, <n x 16 x i1> %b)
  ret i64 %out
}

define i64 @sqincp_n64_b16(i64 %a, <n x 8 x i1> %b) {
; CHECK-LABEL: sqincp_n64_b16:
; CHECK: sqincp x0, p0.h
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqincp.n64.nxv8i1(i64 %a, <n x 8 x i1> %b)
  ret i64 %out
}

define i64 @sqincp_n64_b32(i64 %a, <n x 4 x i1> %b) {
; CHECK-LABEL: sqincp_n64_b32:
; CHECK: sqincp x0, p0.s
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqincp.n64.nxv4i1(i64 %a, <n x 4 x i1> %b)
  ret i64 %out
}

define i64 @sqincp_n64_b64(i64 %a, <n x 2 x i1> %b) {
; CHECK-LABEL: sqincp_n64_b64:
; CHECK: sqincp x0, p0.d
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.sqincp.n64.nxv2i1(i64 %a, <n x 2 x i1> %b)
  ret i64 %out
}

;
; UQDECH (vector)
;

define <n x 8 x i16> @uqdech(<n x 8 x i16> %a) {
; CHECK-LABEL: uqdech:
; CHECK: uqdech z0.h, pow2
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqdech.nxv8i16(<n x 8 x i16> %a,
                                                             i32 0, i32 1)
  ret <n x 8 x i16> %out
}

;
; UQDECW (vector)
;

define <n x 4 x i32> @uqdecw(<n x 4 x i32> %a) {
; CHECK-LABEL: uqdecw:
; CHECK: uqdecw z0.s, vl1, mul #2
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqdecw.nxv4i32(<n x 4 x i32> %a,
                                                             i32 1, i32 2)
  ret <n x 4 x i32> %out
}

;
; UQDECD (vector)
;

define <n x 2 x i64> @uqdecd(<n x 2 x i64> %a) {
; CHECK-LABEL: uqdecd:
; CHECK: uqdecd z0.d, vl2, mul #3
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqdecd.nxv2i64(<n x 2 x i64> %a,
                                                             i32 2, i32 3)
  ret <n x 2 x i64> %out
}

;
; UQDECP (vector)
;

define <n x 8 x i16> @uqdecp_b16(<n x 8 x i16> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: uqdecp_b16:
; CHECK: uqdecp z0.h, p0
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqdecp.nxv8i16(<n x 8 x i16> %a,
                                                             <n x 8 x i1> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uqdecp_b32(<n x 4 x i32> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: uqdecp_b32:
; CHECK: uqdecp z0.s, p0
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqdecp.nxv4i32(<n x 4 x i32> %a,
                                                             <n x 4 x i1> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uqdecp_b64(<n x 2 x i64> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: uqdecp_b64:
; CHECK: uqdecp z0.d, p0
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqdecp.nxv2i64(<n x 2 x i64> %a,
                                                             <n x 2 x i1> %b)
  ret <n x 2 x i64> %out
}

;
; UQDECB (scalar)
;

define i32 @uqdecb_n32(i32 %a) {
; CHECK-LABEL: uqdecb_n32:
; CHECK: uqdecb w0, vl3, mul #4
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqdecb.n32(i32 %a, i32 3, i32 4)
  ret i32 %out
}

define i64 @uqdecb_n64(i64 %a) {
; CHECK-LABEL: uqdecb_n64:
; CHECK: uqdecb x0, vl4, mul #5
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqdecb.n64(i64 %a, i32 4, i32 5)
  ret i64 %out
}

;
; UQDECH (scalar)
;

define i32 @uqdech_n32(i32 %a) {
; CHECK-LABEL: uqdech_n32:
; CHECK: uqdech w0, vl5, mul #6
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqdech.n32(i32 %a, i32 5, i32 6)
  ret i32 %out
}

define i64 @uqdech_n64(i64 %a) {
; CHECK-LABEL: uqdech_n64:
; CHECK: uqdech x0, vl6, mul #7
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqdech.n64(i64 %a, i32 6, i32 7)
  ret i64 %out
}

;
; UQDECW (scalar)
;

define i32 @uqdecw_n32(i32 %a) {
; CHECK-LABEL: uqdecw_n32:
; CHECK: uqdecw w0, vl7, mul #8
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqdecw.n32(i32 %a, i32 7, i32 8)
  ret i32 %out
}

define i64 @uqdecw_n64(i64 %a) {
; CHECK-LABEL: uqdecw_n64:
; CHECK: uqdecw x0, vl8, mul #9
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqdecw.n64(i64 %a, i32 8, i32 9)
  ret i64 %out
}

;
; UQDECD (scalar)
;

define i32 @uqdecd_n32(i32 %a) {
; CHECK-LABEL: uqdecd_n32:
; CHECK: uqdecd w0, vl16, mul #10
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqdecd.n32(i32 %a, i32 9, i32 10)
  ret i32 %out
}

define i64 @uqdecd_n64(i64 %a) {
; CHECK-LABEL: uqdecd_n64:
; CHECK: uqdecd x0, vl32, mul #11
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqdecd.n64(i64 %a, i32 10, i32 11)
  ret i64 %out
}

;
; UQDECP (scalar)
;

define i32 @uqdecp_n32_b8(i32 %a, <n x 16 x i1> %b) {
; CHECK-LABEL: uqdecp_n32_b8:
; CHECK: uqdecp w0, p0.b
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv16i1(i32 %a, <n x 16 x i1> %b)
  ret i32 %out
}

define i32 @uqdecp_n32_b16(i32 %a, <n x 8 x i1> %b) {
; CHECK-LABEL: uqdecp_n32_b16:
; CHECK: uqdecp w0, p0.h
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv8i1(i32 %a, <n x 8 x i1> %b)
  ret i32 %out
}

define i32 @uqdecp_n32_b32(i32 %a, <n x 4 x i1> %b) {
; CHECK-LABEL: uqdecp_n32_b32:
; CHECK: uqdecp w0, p0.s
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv4i1(i32 %a, <n x 4 x i1> %b)
  ret i32 %out
}

define i32 @uqdecp_n32_b64(i32 %a, <n x 2 x i1> %b) {
; CHECK-LABEL: uqdecp_n32_b64:
; CHECK: uqdecp w0, p0.d
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqdecp.n32.nxv2i1(i32 %a, <n x 2 x i1> %b)
  ret i32 %out
}

define i64 @uqdecp_n64_b8(i64 %a, <n x 16 x i1> %b) {
; CHECK-LABEL: uqdecp_n64_b8:
; CHECK: uqdecp x0, p0.b
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv16i1(i64 %a, <n x 16 x i1> %b)
  ret i64 %out
}

define i64 @uqdecp_n64_b16(i64 %a, <n x 8 x i1> %b) {
; CHECK-LABEL: uqdecp_n64_b16:
; CHECK: uqdecp x0, p0.h
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv8i1(i64 %a, <n x 8 x i1> %b)
  ret i64 %out
}

define i64 @uqdecp_n64_b32(i64 %a, <n x 4 x i1> %b) {
; CHECK-LABEL: uqdecp_n64_b32:
; CHECK: uqdecp x0, p0.s
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv4i1(i64 %a, <n x 4 x i1> %b)
  ret i64 %out
}

define i64 @uqdecp_n64_b64(i64 %a, <n x 2 x i1> %b) {
; CHECK-LABEL: uqdecp_n64_b64:
; CHECK: uqdecp x0, p0.d
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqdecp.n64.nxv2i1(i64 %a, <n x 2 x i1> %b)
  ret i64 %out
}

;
; UQINCH (vector)
;

define <n x 8 x i16> @uqinch(<n x 8 x i16> %a) {
; CHECK-LABEL: uqinch:
; CHECK: uqinch z0.h, pow2
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqinch.nxv8i16(<n x 8 x i16> %a,
                                                             i32 0, i32 1)
  ret <n x 8 x i16> %out
}

;
; UQINCW (vector)
;

define <n x 4 x i32> @uqincw(<n x 4 x i32> %a) {
; CHECK-LABEL: uqincw:
; CHECK: uqincw z0.s, vl1, mul #2
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqincw.nxv4i32(<n x 4 x i32> %a,
                                                             i32 1, i32 2)
  ret <n x 4 x i32> %out
}

;
; UQINCD (vector)
;

define <n x 2 x i64> @uqincd(<n x 2 x i64> %a) {
; CHECK-LABEL: uqincd:
; CHECK: uqincd z0.d, vl2, mul #3
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqincd.nxv2i64(<n x 2 x i64> %a,
                                                             i32 2, i32 3)
  ret <n x 2 x i64> %out
}

;
; UQINCP (vector)
;

define <n x 8 x i16> @uqincp_b16(<n x 8 x i16> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: uqincp_b16:
; CHECK: uqincp z0.h, p0
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqincp.nxv8i16(<n x 8 x i16> %a,
                                                             <n x 8 x i1> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uqincp_b32(<n x 4 x i32> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: uqincp_b32:
; CHECK: uqincp z0.s, p0
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqincp.nxv4i32(<n x 4 x i32> %a,
                                                             <n x 4 x i1> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uqincp_b64(<n x 2 x i64> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: uqincp_b64:
; CHECK: uqincp z0.d, p0
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqincp.nxv2i64(<n x 2 x i64> %a,
                                                             <n x 2 x i1> %b)
  ret <n x 2 x i64> %out
}

;
; UQINCB (scalar)
;

define i32 @uqincb_n32(i32 %a) {
; CHECK-LABEL: uqincb_n32:
; CHECK: uqincb w0, vl3, mul #4
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqincb.n32(i32 %a, i32 3, i32 4)
  ret i32 %out
}

define i64 @uqincb_n64(i64 %a) {
; CHECK-LABEL: uqincb_n64:
; CHECK: uqincb x0, vl4, mul #5
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqincb.n64(i64 %a, i32 4, i32 5)
  ret i64 %out
}

;
; UQINCH (scalar)
;

define i32 @uqinch_n32(i32 %a) {
; CHECK-LABEL: uqinch_n32:
; CHECK: uqinch w0, vl5, mul #6
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqinch.n32(i32 %a, i32 5, i32 6)
  ret i32 %out
}

define i64 @uqinch_n64(i64 %a) {
; CHECK-LABEL: uqinch_n64:
; CHECK: uqinch x0, vl6, mul #7
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqinch.n64(i64 %a, i32 6, i32 7)
  ret i64 %out
}

;
; UQINCW (scalar)
;

define i32 @uqincw_n32(i32 %a) {
; CHECK-LABEL: uqincw_n32:
; CHECK: uqincw w0, vl7, mul #8
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqincw.n32(i32 %a, i32 7, i32 8)
  ret i32 %out
}

define i64 @uqincw_n64(i64 %a) {
; CHECK-LABEL: uqincw_n64:
; CHECK: uqincw x0, vl8, mul #9
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqincw.n64(i64 %a, i32 8, i32 9)
  ret i64 %out
}

;
; UQINCD (scalar)
;

define i32 @uqincd_n32(i32 %a) {
; CHECK-LABEL: uqincd_n32:
; CHECK: uqincd w0, vl16, mul #10
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqincd.n32(i32 %a, i32 9, i32 10)
  ret i32 %out
}

define i64 @uqincd_n64(i64 %a) {
; CHECK-LABEL: uqincd_n64:
; CHECK: uqincd x0, vl32, mul #11
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqincd.n64(i64 %a, i32 10, i32 11)
  ret i64 %out
}

;
; UQINCP (scalar)
;

define i32 @uqincp_n32_b8(i32 %a, <n x 16 x i1> %b) {
; CHECK-LABEL: uqincp_n32_b8:
; CHECK: uqincp w0, p0.b
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqincp.n32.nxv16i1(i32 %a, <n x 16 x i1> %b)
  ret i32 %out
}

define i32 @uqincp_n32_b16(i32 %a, <n x 8 x i1> %b) {
; CHECK-LABEL: uqincp_n32_b16:
; CHECK: uqincp w0, p0.h
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqincp.n32.nxv8i1(i32 %a, <n x 8 x i1> %b)
  ret i32 %out
}

define i32 @uqincp_n32_b32(i32 %a, <n x 4 x i1> %b) {
; CHECK-LABEL: uqincp_n32_b32:
; CHECK: uqincp w0, p0.s
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqincp.n32.nxv4i1(i32 %a, <n x 4 x i1> %b)
  ret i32 %out
}

define i32 @uqincp_n32_b64(i32 %a, <n x 2 x i1> %b) {
; CHECK-LABEL: uqincp_n32_b64:
; CHECK: uqincp w0, p0.d
; CHECK-NEXT: ret
  %out = call i32 @llvm.aarch64.sve.uqincp.n32.nxv2i1(i32 %a, <n x 2 x i1> %b)
  ret i32 %out
}

define i64 @uqincp_n64_b8(i64 %a, <n x 16 x i1> %b) {
; CHECK-LABEL: uqincp_n64_b8:
; CHECK: uqincp x0, p0.b
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqincp.n64.nxv16i1(i64 %a, <n x 16 x i1> %b)
  ret i64 %out
}

define i64 @uqincp_n64_b16(i64 %a, <n x 8 x i1> %b) {
; CHECK-LABEL: uqincp_n64_b16:
; CHECK: uqincp x0, p0.h
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqincp.n64.nxv8i1(i64 %a, <n x 8 x i1> %b)
  ret i64 %out
}

define i64 @uqincp_n64_b32(i64 %a, <n x 4 x i1> %b) {
; CHECK-LABEL: uqincp_n64_b32:
; CHECK: uqincp x0, p0.s
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqincp.n64.nxv4i1(i64 %a, <n x 4 x i1> %b)
  ret i64 %out
}

define i64 @uqincp_n64_b64(i64 %a, <n x 2 x i1> %b) {
; CHECK-LABEL: uqincp_n64_b64:
; CHECK: uqincp x0, p0.d
; CHECK-NEXT: ret
  %out = call i64 @llvm.aarch64.sve.uqincp.n64.nxv2i1(i64 %a, <n x 2 x i1> %b)
  ret i64 %out
}

declare <n x 8 x i16> @llvm.aarch64.sve.sqdech.nxv8i16(<n x 8 x i16>, i32, i32)
declare <n x 4 x i32> @llvm.aarch64.sve.sqdecw.nxv4i32(<n x 4 x i32>, i32, i32)
declare <n x 2 x i64> @llvm.aarch64.sve.sqdecd.nxv2i64(<n x 2 x i64>, i32, i32)

declare <n x 8 x i16> @llvm.aarch64.sve.sqdecp.nxv8i16(<n x 8 x i16>, <n x 8 x i1>)
declare <n x 4 x i32> @llvm.aarch64.sve.sqdecp.nxv4i32(<n x 4 x i32>, <n x 4 x i1>)
declare <n x 2 x i64> @llvm.aarch64.sve.sqdecp.nxv2i64(<n x 2 x i64>, <n x 2 x i1>)

declare i32 @llvm.aarch64.sve.sqdecb.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.sqdecb.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.sqdech.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.sqdech.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.sqdecw.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.sqdecw.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.sqdecd.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.sqdecd.n64(i64, i32, i32)

declare i32 @llvm.aarch64.sve.sqdecp.n32.nxv16i1(i32, <n x 16 x i1>)
declare i32 @llvm.aarch64.sve.sqdecp.n32.nxv8i1(i32, <n x 8 x i1>)
declare i32 @llvm.aarch64.sve.sqdecp.n32.nxv4i1(i32, <n x 4 x i1>)
declare i32 @llvm.aarch64.sve.sqdecp.n32.nxv2i1(i32, <n x 2 x i1>)

declare i64 @llvm.aarch64.sve.sqdecp.n64.nxv16i1(i64, <n x 16 x i1>)
declare i64 @llvm.aarch64.sve.sqdecp.n64.nxv8i1(i64, <n x 8 x i1>)
declare i64 @llvm.aarch64.sve.sqdecp.n64.nxv4i1(i64, <n x 4 x i1>)
declare i64 @llvm.aarch64.sve.sqdecp.n64.nxv2i1(i64, <n x 2 x i1>)

declare <n x 8 x i16> @llvm.aarch64.sve.sqinch.nxv8i16(<n x 8 x i16>, i32, i32)
declare <n x 4 x i32> @llvm.aarch64.sve.sqincw.nxv4i32(<n x 4 x i32>, i32, i32)
declare <n x 2 x i64> @llvm.aarch64.sve.sqincd.nxv2i64(<n x 2 x i64>, i32, i32)

declare <n x 8 x i16> @llvm.aarch64.sve.sqincp.nxv8i16(<n x 8 x i16>, <n x 8 x i1>)
declare <n x 4 x i32> @llvm.aarch64.sve.sqincp.nxv4i32(<n x 4 x i32>, <n x 4 x i1>)
declare <n x 2 x i64> @llvm.aarch64.sve.sqincp.nxv2i64(<n x 2 x i64>, <n x 2 x i1>)

declare i32 @llvm.aarch64.sve.sqincb.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.sqincb.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.sqinch.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.sqinch.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.sqincw.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.sqincw.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.sqincd.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.sqincd.n64(i64, i32, i32)

declare i32 @llvm.aarch64.sve.sqincp.n32.nxv16i1(i32, <n x 16 x i1>)
declare i32 @llvm.aarch64.sve.sqincp.n32.nxv8i1(i32, <n x 8 x i1>)
declare i32 @llvm.aarch64.sve.sqincp.n32.nxv4i1(i32, <n x 4 x i1>)
declare i32 @llvm.aarch64.sve.sqincp.n32.nxv2i1(i32, <n x 2 x i1>)

declare i64 @llvm.aarch64.sve.sqincp.n64.nxv16i1(i64, <n x 16 x i1>)
declare i64 @llvm.aarch64.sve.sqincp.n64.nxv8i1(i64, <n x 8 x i1>)
declare i64 @llvm.aarch64.sve.sqincp.n64.nxv4i1(i64, <n x 4 x i1>)
declare i64 @llvm.aarch64.sve.sqincp.n64.nxv2i1(i64, <n x 2 x i1>)

declare <n x 8 x i16> @llvm.aarch64.sve.uqdech.nxv8i16(<n x 8 x i16>, i32, i32)
declare <n x 4 x i32> @llvm.aarch64.sve.uqdecw.nxv4i32(<n x 4 x i32>, i32, i32)
declare <n x 2 x i64> @llvm.aarch64.sve.uqdecd.nxv2i64(<n x 2 x i64>, i32, i32)

declare <n x 8 x i16> @llvm.aarch64.sve.uqdecp.nxv8i16(<n x 8 x i16>, <n x 8 x i1>)
declare <n x 4 x i32> @llvm.aarch64.sve.uqdecp.nxv4i32(<n x 4 x i32>, <n x 4 x i1>)
declare <n x 2 x i64> @llvm.aarch64.sve.uqdecp.nxv2i64(<n x 2 x i64>, <n x 2 x i1>)

declare i32 @llvm.aarch64.sve.uqdecb.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.uqdecb.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.uqdech.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.uqdech.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.uqdecw.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.uqdecw.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.uqdecd.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.uqdecd.n64(i64, i32, i32)

declare i32 @llvm.aarch64.sve.uqdecp.n32.nxv16i1(i32, <n x 16 x i1>)
declare i32 @llvm.aarch64.sve.uqdecp.n32.nxv8i1(i32, <n x 8 x i1>)
declare i32 @llvm.aarch64.sve.uqdecp.n32.nxv4i1(i32, <n x 4 x i1>)
declare i32 @llvm.aarch64.sve.uqdecp.n32.nxv2i1(i32, <n x 2 x i1>)

declare i64 @llvm.aarch64.sve.uqdecp.n64.nxv16i1(i64, <n x 16 x i1>)
declare i64 @llvm.aarch64.sve.uqdecp.n64.nxv8i1(i64, <n x 8 x i1>)
declare i64 @llvm.aarch64.sve.uqdecp.n64.nxv4i1(i64, <n x 4 x i1>)
declare i64 @llvm.aarch64.sve.uqdecp.n64.nxv2i1(i64, <n x 2 x i1>)

declare <n x 8 x i16> @llvm.aarch64.sve.uqinch.nxv8i16(<n x 8 x i16>, i32, i32)
declare <n x 4 x i32> @llvm.aarch64.sve.uqincw.nxv4i32(<n x 4 x i32>, i32, i32)
declare <n x 2 x i64> @llvm.aarch64.sve.uqincd.nxv2i64(<n x 2 x i64>, i32, i32)

declare <n x 8 x i16> @llvm.aarch64.sve.uqincp.nxv8i16(<n x 8 x i16>, <n x 8 x i1>)
declare <n x 4 x i32> @llvm.aarch64.sve.uqincp.nxv4i32(<n x 4 x i32>, <n x 4 x i1>)
declare <n x 2 x i64> @llvm.aarch64.sve.uqincp.nxv2i64(<n x 2 x i64>, <n x 2 x i1>)

declare i32 @llvm.aarch64.sve.uqincb.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.uqincb.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.uqinch.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.uqinch.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.uqincw.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.uqincw.n64(i64, i32, i32)
declare i32 @llvm.aarch64.sve.uqincd.n32(i32, i32, i32)
declare i64 @llvm.aarch64.sve.uqincd.n64(i64, i32, i32)

declare i32 @llvm.aarch64.sve.uqincp.n32.nxv16i1(i32, <n x 16 x i1>)
declare i32 @llvm.aarch64.sve.uqincp.n32.nxv8i1(i32, <n x 8 x i1>)
declare i32 @llvm.aarch64.sve.uqincp.n32.nxv4i1(i32, <n x 4 x i1>)
declare i32 @llvm.aarch64.sve.uqincp.n32.nxv2i1(i32, <n x 2 x i1>)

declare i64 @llvm.aarch64.sve.uqincp.n64.nxv16i1(i64, <n x 16 x i1>)
declare i64 @llvm.aarch64.sve.uqincp.n64.nxv8i1(i64, <n x 8 x i1>)
declare i64 @llvm.aarch64.sve.uqincp.n64.nxv4i1(i64, <n x 4 x i1>)
declare i64 @llvm.aarch64.sve.uqincp.n64.nxv2i1(i64, <n x 2 x i1>)
