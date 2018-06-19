; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; ABS
;

define <n x 16 x i8> @abs_i8(<n x 16 x i8> %a, <n x 16 x i1> %pg, <n x 16 x i8> %b) {
; CHECK-LABEL: abs_i8:
; CHECK: abs z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.abs.nxv16i8(<n x 16 x i8> %a,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @abs_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: abs_i16:
; CHECK: abs z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<n x 8 x i16> %a,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @abs_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: abs_i32:
; CHECK: abs z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.abs.nxv4i32(<n x 4 x i32> %a,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @abs_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: abs_i64:
; CHECK: abs z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.abs.nxv2i64(<n x 2 x i64> %a,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; ADD
;

define <n x 16 x i8> @add_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: add_i8:
; CHECK: add z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.add.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @add_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: add_i16:
; CHECK: add z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.add.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @add_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: add_i32:
; CHECK: add z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.add.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @add_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: add_i64:
; CHECK: add z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.add.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; MAD
;

define <n x 16 x i8> @mad_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> %c) {
; CHECK-LABEL: mad_i8:
; CHECK: mad z0.b, p0/m, z1.b, z2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.mad.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b,
                                                          <n x 16 x i8> %c)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @mad_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b, <n x 8 x i16> %c) {
; CHECK-LABEL: mad_i16:
; CHECK: mad z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.mad.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b,
                                                          <n x 8 x i16> %c)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @mad_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c) {
; CHECK-LABEL: mad_i32:
; CHECK: mad z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.mad.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b,
                                                          <n x 4 x i32> %c)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @mad_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b, <n x 2 x i64> %c) {
; CHECK-LABEL: mad_i64:
; CHECK: mad z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.mad.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b,
                                                          <n x 2 x i64> %c)
  ret <n x 2 x i64> %out
}

;
; MLA
;

define <n x 16 x i8> @mla_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> %c) {
; CHECK-LABEL: mla_i8:
; CHECK: mla z0.b, p0/m, z1.b, z2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.mla.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b,
                                                          <n x 16 x i8> %c)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @mla_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b, <n x 8 x i16> %c) {
; CHECK-LABEL: mla_i16:
; CHECK: mla z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.mla.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b,
                                                          <n x 8 x i16> %c)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @mla_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c) {
; CHECK-LABEL: mla_i32:
; CHECK: mla z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.mla.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b,
                                                          <n x 4 x i32> %c)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @mla_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b, <n x 2 x i64> %c) {
; CHECK-LABEL: mla_i64:
; CHECK: mla z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.mla.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b,
                                                          <n x 2 x i64> %c)
  ret <n x 2 x i64> %out
}

;
; MLS
;

define <n x 16 x i8> @mls_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> %c) {
; CHECK-LABEL: mls_i8:
; CHECK: mls z0.b, p0/m, z1.b, z2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.mls.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b,
                                                          <n x 16 x i8> %c)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @mls_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b, <n x 8 x i16> %c) {
; CHECK-LABEL: mls_i16:
; CHECK: mls z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.mls.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b,
                                                          <n x 8 x i16> %c)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @mls_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c) {
; CHECK-LABEL: mls_i32:
; CHECK: mls z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.mls.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b,
                                                          <n x 4 x i32> %c)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @mls_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b, <n x 2 x i64> %c) {
; CHECK-LABEL: mls_i64:
; CHECK: mls z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.mls.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b,
                                                          <n x 2 x i64> %c)
  ret <n x 2 x i64> %out
}

;
; MSB
;

define <n x 16 x i8> @msb_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> %c) {
; CHECK-LABEL: msb_i8:
; CHECK: msb z0.b, p0/m, z1.b, z2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.msb.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b,
                                                          <n x 16 x i8> %c)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @msb_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b, <n x 8 x i16> %c) {
; CHECK-LABEL: msb_i16:
; CHECK: msb z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.msb.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b,
                                                          <n x 8 x i16> %c)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @msb_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b, <n x 4 x i32> %c) {
; CHECK-LABEL: msb_i32:
; CHECK: msb z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.msb.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b,
                                                          <n x 4 x i32> %c)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @msb_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b, <n x 2 x i64> %c) {
; CHECK-LABEL: msb_i64:
; CHECK: msb z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.msb.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b,
                                                          <n x 2 x i64> %c)
  ret <n x 2 x i64> %out
}

;
; MUL
;

define <n x 16 x i8> @mul_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: mul_i8:
; CHECK: mul z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.mul.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @mul_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: mul_i16:
; CHECK: mul z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.mul.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @mul_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: mul_i32:
; CHECK: mul z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.mul.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @mul_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: mul_i64:
; CHECK: mul z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.mul.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; NEG
;

define <n x 16 x i8> @neg_i8(<n x 16 x i8> %a, <n x 16 x i1> %pg, <n x 16 x i8> %b) {
; CHECK-LABEL: neg_i8:
; CHECK: neg z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.neg.nxv16i8(<n x 16 x i8> %a,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @neg_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: neg_i16:
; CHECK: neg z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.neg.nxv8i16(<n x 8 x i16> %a,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @neg_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: neg_i32:
; CHECK: neg z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.neg.nxv4i32(<n x 4 x i32> %a,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @neg_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: neg_i64:
; CHECK: neg z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.neg.nxv2i64(<n x 2 x i64> %a,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; SABD
;

define <n x 16 x i8> @sabd_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: sabd_i8:
; CHECK: sabd z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.sabd.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sabd_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: sabd_i16:
; CHECK: sabd z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sabd.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sabd_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sabd_i32:
; CHECK: sabd z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sabd.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sabd_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sabd_i64:
; CHECK: sabd z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sabd.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

; SDIV

define <n x 4 x i32> @sdiv_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sdiv_i32:
; CHECK: sdiv z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sdiv.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sdiv_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sdiv_i64:
; CHECK: sdiv z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sdiv.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

; SDIVR

define <n x 4 x i32> @sdivr_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sdivr_i32:
; CHECK: sdivr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sdivr.nxv4i32(<n x 4 x i1> %pg,
                                                            <n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sdivr_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sdivr_i64:
; CHECK: sdivr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sdivr.nxv2i64(<n x 2 x i1> %pg,
                                                            <n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

; SDOT

define <n x 4 x i32> @sdot_i32(<n x 4 x i32> %a, <n x 16 x i8> %b, <n x 16 x i8> %c) {
; CHECK-LABEL: sdot_i32:
; CHECK: sdot z0.s, z1.b, z2.b
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sdot.nxv4i32(<n x 4 x i32> %a,
                                                           <n x 16 x i8> %b,
                                                           <n x 16 x i8> %c)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sdot_i64(<n x 2 x i64> %a, <n x 8 x i16> %b, <n x 8 x i16> %c) {
; CHECK-LABEL: sdot_i64:
; CHECK: sdot z0.d, z1.h, z2.h
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sdot.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 8 x i16> %b,
                                                           <n x 8 x i16> %c)
  ret <n x 2 x i64> %out
}

; SDOT (Indexed)

define <n x 4 x i32> @sdot_lane_i32(<n x 4 x i32> %a, <n x 16 x i8> %b, <n x 16 x i8> %c) {
; CHECK-LABEL: sdot_lane_i32:
; CHECK: sdot z0.s, z1.b, z2.b[2]
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sdot.lane.nxv4i32(<n x 4 x i32> %a,
                                                                <n x 16 x i8> %b,
                                                                <n x 16 x i8> %c,
                                                                i32 2)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sdot_lane_i64(<n x 2 x i64> %a, <n x 8 x i16> %b, <n x 8 x i16> %c) {
; CHECK-LABEL: sdot_lane_i64:
; CHECK: sdot z0.d, z1.h, z2.h[1]
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sdot.lane.nxv2i64(<n x 2 x i64> %a,
                                                                <n x 8 x i16> %b,
                                                                <n x 8 x i16> %c,
                                                                i32 1)
  ret <n x 2 x i64> %out
}

;
; SMIN
;

define <n x 16 x i8> @smin_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: smin_i8:
; CHECK: smin z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.smin.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @smin_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: smin_i16:
; CHECK: smin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.smin.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @smin_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: smin_i32:
; CHECK: smin z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.smin.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @smin_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: smin_i64:
; CHECK: smin z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.smin.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; SMAX
;

define <n x 16 x i8> @smax_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: smax_i8:
; CHECK: smax z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.smax.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @smax_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: smax_i16:
; CHECK: smax z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.smax.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @smax_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: smax_i32:
; CHECK: smax z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.smax.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @smax_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: smax_i64:
; CHECK: smax z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.smax.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; SMULH
;

define <n x 16 x i8> @smulh_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: smulh_i8:
; CHECK: smulh z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.smulh.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @smulh_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: smulh_i16:
; CHECK: smulh z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.smulh.nxv8i16(<n x 8 x i1> %pg,
                                                            <n x 8 x i16> %a,
                                                            <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @smulh_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: smulh_i32:
; CHECK: smulh z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.smulh.nxv4i32(<n x 4 x i1> %pg,
                                                            <n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @smulh_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: smulh_i64:
; CHECK: smulh z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.smulh.nxv2i64(<n x 2 x i1> %pg,
                                                            <n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; SQADD
;

define <n x 16 x i8> @sqadd_i8(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: sqadd_i8:
; CHECK: sqadd z0.b, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.sqadd.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sqadd_i16(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: sqadd_i16:
; CHECK: sqadd z0.h, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sqadd_i32(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sqadd_i32:
; CHECK: sqadd z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sqadd_i64(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sqadd_i64:
; CHECK: sqadd z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqadd.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; SQSUB
;

define <n x 16 x i8> @sqsub_i8(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: sqsub_i8:
; CHECK: sqsub z0.b, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.sqsub.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sqsub_i16(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: sqsub_i16:
; CHECK: sqsub z0.h, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sqsub.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sqsub_i32(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sqsub_i32:
; CHECK: sqsub z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sqsub.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sqsub_i64(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sqsub_i64:
; CHECK: sqsub z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sqsub.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; SUB
;

define <n x 16 x i8> @sub_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: sub_i8:
; CHECK: sub z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.sub.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sub_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: sub_i16:
; CHECK: sub z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.sub.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sub_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sub_i32:
; CHECK: sub z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.sub.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sub_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sub_i64:
; CHECK: sub z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.sub.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; SUBR
;

define <n x 16 x i8> @subr_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: subr_i8:
; CHECK: subr z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.subr.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @subr_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: subr_i16:
; CHECK: subr z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.subr.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @subr_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: subr_i32:
; CHECK: subr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.subr.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @subr_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: subr_i64:
; CHECK: subr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.subr.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; UABD
;

define <n x 16 x i8> @uabd_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: uabd_i8:
; CHECK: uabd z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.uabd.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @uabd_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: uabd_i16:
; CHECK: uabd z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uabd.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uabd_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: uabd_i32:
; CHECK: uabd z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uabd.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uabd_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: uabd_i64:
; CHECK: uabd z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uabd.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

; UDIV

define <n x 4 x i32> @udiv_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: udiv_i32:
; CHECK: udiv z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.udiv.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @udiv_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: udiv_i64:
; CHECK: udiv z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.udiv.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

; UDIVR

define <n x 4 x i32> @udivr_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: udivr_i32:
; CHECK: udivr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.udivr.nxv4i32(<n x 4 x i1> %pg,
                                                            <n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @udivr_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: udivr_i64:
; CHECK: udivr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.udivr.nxv2i64(<n x 2 x i1> %pg,
                                                            <n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

; UDOT

define <n x 4 x i32> @udot_i32(<n x 4 x i32> %a, <n x 16 x i8> %b, <n x 16 x i8> %c) {
; CHECK-LABEL: udot_i32:
; CHECK: udot z0.s, z1.b, z2.b
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.udot.nxv4i32(<n x 4 x i32> %a,
                                                           <n x 16 x i8> %b,
                                                           <n x 16 x i8> %c)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @udot_i64(<n x 2 x i64> %a, <n x 8 x i16> %b, <n x 8 x i16> %c) {
; CHECK-LABEL: udot_i64:
; CHECK: udot z0.d, z1.h, z2.h
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.udot.nxv2i64(<n x 2 x i64> %a,
                                                           <n x 8 x i16> %b,
                                                           <n x 8 x i16> %c)
  ret <n x 2 x i64> %out
}

; UDOT (Indexed)

define <n x 4 x i32> @udot_lane_i32(<n x 4 x i32> %a, <n x 16 x i8> %b, <n x 16 x i8> %c) {
; CHECK-LABEL: udot_lane_i32:
; CHECK: udot z0.s, z1.b, z2.b[2]
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.udot.lane.nxv4i32(<n x 4 x i32> %a,
                                                                <n x 16 x i8> %b,
                                                                <n x 16 x i8> %c,
                                                                i32 2)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @udot_lane_i64(<n x 2 x i64> %a, <n x 8 x i16> %b, <n x 8 x i16> %c) {
; CHECK-LABEL: udot_lane_i64:
; CHECK: udot z0.d, z1.h, z2.h[1]
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.udot.lane.nxv2i64(<n x 2 x i64> %a,
                                                                <n x 8 x i16> %b,
                                                                <n x 8 x i16> %c,
                                                                i32 1)
  ret <n x 2 x i64> %out
}

;
; UMIN
;

define <n x 16 x i8> @umin_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: umin_i8:
; CHECK: umin z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.umin.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @umin_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: umin_i16:
; CHECK: umin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.umin.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @umin_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: umin_i32:
; CHECK: umin z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.umin.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @umin_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: umin_i64:
; CHECK: umin z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.umin.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; UMAX
;

define <n x 16 x i8> @umax_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: umax_i8:
; CHECK: umax z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.umax.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @umax_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: umax_i16:
; CHECK: umax z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.umax.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @umax_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: umax_i32:
; CHECK: umax z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.umax.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @umax_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: umax_i64:
; CHECK: umax z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.umax.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; UMULH
;

define <n x 16 x i8> @umulh_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: umulh_i8:
; CHECK: umulh z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.umulh.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @umulh_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: umulh_i16:
; CHECK: umulh z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.umulh.nxv8i16(<n x 8 x i1> %pg,
                                                            <n x 8 x i16> %a,
                                                            <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @umulh_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: umulh_i32:
; CHECK: umulh z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.umulh.nxv4i32(<n x 4 x i1> %pg,
                                                            <n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @umulh_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: umulh_i64:
; CHECK: umulh z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.umulh.nxv2i64(<n x 2 x i1> %pg,
                                                            <n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; UQADD
;

define <n x 16 x i8> @uqadd_i8(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: uqadd_i8:
; CHECK: uqadd z0.b, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.uqadd.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @uqadd_i16(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: uqadd_i16:
; CHECK: uqadd z0.h, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uqadd_i32(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: uqadd_i32:
; CHECK: uqadd z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uqadd_i64(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: uqadd_i64:
; CHECK: uqadd z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqadd.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

;
; UQSUB
;

define <n x 16 x i8> @uqsub_i8(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: uqsub_i8:
; CHECK: uqsub z0.b, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i8> @llvm.aarch64.sve.uqsub.nxv16i8(<n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @uqsub_i16(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: uqsub_i16:
; CHECK: uqsub z0.h, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <n x 8 x i16> @llvm.aarch64.sve.uqsub.nxv8i16(<n x 8 x i16> %a,
                                                            <n x 8 x i16> %b)
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uqsub_i32(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: uqsub_i32:
; CHECK: uqsub z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x i32> @llvm.aarch64.sve.uqsub.nxv4i32(<n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uqsub_i64(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: uqsub_i64:
; CHECK: uqsub z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x i64> @llvm.aarch64.sve.uqsub.nxv2i64(<n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  ret <n x 2 x i64> %out
}

declare <n x 16 x i8> @llvm.aarch64.sve.abs.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.abs.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.abs.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.add.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.add.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.add.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.add.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.mad.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.mad.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.mad.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.mad.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.mla.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.mla.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.mla.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.mla.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.mls.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.mls.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.mls.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.mls.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.msb.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.msb.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.msb.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.msb.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.mul.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.mul.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.mul.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.mul.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.neg.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.neg.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.neg.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.neg.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.sabd.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.sabd.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sabd.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sabd.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.sdot.nxv4i32(<n x 4 x i32>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 2 x i64> @llvm.aarch64.sve.sdot.nxv2i64(<n x 2 x i64>, <n x 8 x i16>, <n x 8 x i16>)

declare <n x 4 x i32> @llvm.aarch64.sve.sdot.lane.nxv4i32(<n x 4 x i32>, <n x 16 x i8>, <n x 16 x i8>, i32)
declare <n x 2 x i64> @llvm.aarch64.sve.sdot.lane.nxv2i64(<n x 2 x i64>, <n x 8 x i16>, <n x 8 x i16>, i32)

declare <n x 4 x i32> @llvm.aarch64.sve.sdiv.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sdiv.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.sdivr.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sdivr.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.smax.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.smax.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.smax.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.smax.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.smin.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.smin.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.smin.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.smin.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.smulh.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.smulh.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.smulh.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.smulh.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.sqadd.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sqadd.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.sqsub.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.sqsub.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sqsub.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sqsub.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.sub.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.sub.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sub.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sub.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.subr.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.subr.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.subr.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.subr.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.uabd.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.uabd.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.uabd.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.uabd.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.udiv.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.udiv.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.udivr.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.udivr.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.udot.nxv4i32(<n x 4 x i32>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 2 x i64> @llvm.aarch64.sve.udot.nxv2i64(<n x 2 x i64>, <n x 8 x i16>, <n x 8 x i16>)

declare <n x 4 x i32> @llvm.aarch64.sve.udot.lane.nxv4i32(<n x 4 x i32>, <n x 16 x i8>, <n x 16 x i8>, i32)
declare <n x 2 x i64> @llvm.aarch64.sve.udot.lane.nxv2i64(<n x 2 x i64>, <n x 8 x i16>, <n x 8 x i16>, i32)

declare <n x 16 x i8> @llvm.aarch64.sve.umax.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.umax.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.umax.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.umax.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.umin.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.umin.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.umin.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.umin.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.umulh.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.umulh.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.umulh.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.umulh.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.uqadd.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.uqadd.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.uqsub.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.uqsub.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.uqsub.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.uqsub.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)
