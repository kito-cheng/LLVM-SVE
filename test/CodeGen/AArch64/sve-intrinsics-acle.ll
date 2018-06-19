; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 4 x float> @faddz_s_dop_same_src_dst_zeroing(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: faddz_s_dop_same_src_dst_zeroing
; CHECK:      movprfx z1.s, p0/z, z0.s
; CHECK-NEXT: fadd    z1.s, p0/m, z1.s, z0.s
; CHECK-NEXT: mov     z0.d, z1.d
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %1 = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a_z,
                                                          <n x 4 x float> %a)
  ret <n x 4 x float> %1
}

define <n x 4 x float> @fmla_s_dop_same_src_dst_zeroing(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmla_s_dop_same_src_dst_zeroing:
; CHECK:      movprfx z1.s, p0/z, z0.s
; CHECK-NEXT: fmla    z1.s, p0/m, z0.s, z0.s
; CHECK-NEXT: mov     z0.d, z1.d
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.mla.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @faddz_s_dop_all_distinct(<n x 4 x i1> %pg, <n x 4 x float> %_, <n x 4 x float> %b, <n x 4 x float> %c) {
entry:
; CHECK-LABEL: faddz_s_dop_all_distinct
; CHECK: fadd     z1.s, p0/m, z1.s, z2.s
; CHECK: mov
  %0 = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %b,
                                                          <n x 4 x float> %c)
  ret <n x 4 x float> %0
}

define <n x 4 x float> @fdivz_s_dop_1st_arg(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
entry:
; CHECK-LABEL: fdivz_s_dop_1st_arg
; CHECK:     fdiv    z0.s, p0/m, z0.s, z1.s
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a,
                                                          <n x 4 x float> %b)
  ret <n x 4 x float> %0
}

define <n x 4 x float> @fdivz_s_dop_2nd_arg(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
entry:
; CHECK-LABEL: fdivz_s_dop_2nd_arg
; CHECK-NOT: fdivr
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %b,
                                                          <n x 4 x float> %a)
  ret <n x 4 x float> %0
}

define <n x 4 x float> @fdivz_s_dop_1st_arg_merge_zero(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
entry:
; CHECK-LABEL: fdivz_s_dop_1st_arg_merge_zero
; CHECK:     movprfx z0.s, p0/z, z0.s
; CHECK:     fdiv    z0.s, p0/m, z0.s, z1.s
; CHECK-NOT: mov     {{z[0-9]+}}.s, #0
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a_z,
                                                          <n x 4 x float> %b)
  ret <n x 4 x float> %0
}

define <n x 4 x float> @fdivz_s_dop_2nd_merge_zero(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
entry:
; CHECK-LABEL: fdivz_s_dop_2nd_merge_zero
; CHECK:     movprfx  z0.s, p0/z, z0.s
; CHECK:     fdivr    z0.s, p0/m, z0.s, z1.s
; CHECK-NOT: mov     {{z[0-9]+}}.s, #0
  %b_z = select <n x 4 x i1> %pg, <n x 4 x float> %b, <n x 4 x float> zeroinitializer
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %b_z,
                                                          <n x 4 x float> %a)
  ret <n x 4 x float> %0
}

; [Note]
; If the first operand needs to be retained (the operation being
; non-destructive, even though the instruction is), it chooses
; a commutative operation where it selects the other operand to be
; destructive. Here, %a will be in z0 (by definition of PCS), and z1 can
; be clobbered. This is why it chooses the commutative operation (fdivr)
; that clobbers z1.
define <n x 4 x float> @fdivz_s_retain_1st(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float>* %ptr) {
entry:
; CHECK-LABEL: fdivz_s_retain_1st
; CHECK-NOT: movprfx
; CHECK-NOT: fdivr
; CHECK: st1w {z0.s}
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a,
                                                          <n x 4 x float> %b)
  store <n x 4 x float> %a, <n x 4 x float>* %ptr
  ret <n x 4 x float> %0
}

; [Note]
; In the following case the DUP value (mov z_.s #0) is also used in a store to %ptr.
; The test ensures this mov #0 is not removed when merging with fdiv.
define <n x 4 x float> @fdivz_s_dop_1st_arg_merge_zero_retain_dup(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float>* %ptr) {
entry:
; CHECK-LABEL: fdivz_s_dop_1st_arg_merge_zero_retain_dup
; CHECK-DAG: movprfx [[PRFX:z[0-9]+]].s, p0/z, z0.s
; CHECK-DAG: fdiv    z0.s, p0/m, [[PRFX]].s, z1.s
; CHECK-DAG: mov     [[BLA:z[0-9]+]].s, #0
; CHECK-DAG: st1w    {[[BLA]].s}
  store <n x 4 x float> zeroinitializer, <n x 4 x float>* %ptr
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a_z,
                                                          <n x 4 x float> %b)

  ret <n x 4 x float> %0
}

define <n x 4 x float> @fdivz_s_dop_1st_arg_merge_zero_retain_dup2(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float>* %ptr) {
entry:
; CHECK-LABEL: fdivz_s_dop_1st_arg_merge_zero_retain_dup2
; CHECK-DAG: movprfx [[PRFX:z[0-9]+]].s, p0/z, z0.s
; CHECK-DAG: fdiv    z0.s, p0/m, [[PRFX]].s, z1.s
; CHECK-DAG: mov     [[BLA:z[0-9]+]].s, #0
; CHECK-DAG: st1w    {[[BLA]].s}
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %0 = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %a_z,
                                                          <n x 4 x float> %b)
  store <n x 4 x float> zeroinitializer, <n x 4 x float>* %ptr
  ret <n x 4 x float> %0
}

; Similar to related test for fdiv, but instead of fdivr, fadd is already commutative
define <n x 4 x float> @faddz_s_dop_2nd_merge_zero(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
entry:
; CHECK-LABEL: faddz_s_dop_2nd_merge_zero
; CHECK:     movprfx  z0.s, p0/z, z0.s
; CHECK:     fadd     z0.s, p0/m, z0.s, z1.s
; CHECK-NOT: mov     {{z[0-9]+}}.s, #0
  %b_z = select <n x 4 x i1> %pg, <n x 4 x float> %b, <n x 4 x float> zeroinitializer
  %0 = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                          <n x 4 x float> %b_z,
                                                          <n x 4 x float> %a)

  ret <n x 4 x float> %0
}

; Force the select to reuse its third operand thus ensuring the movprfx
; replacement defines a different regiser than allocated to %tmp1.  This tests
; that when removing the code generating the zero we don't remove the movprfx
; (which will define the same register) and that the add does not use the
; original %tmp1 operand but instead uses the result of the movprfx.
define <n x 4 x float> @test1(<n x 4 x i1> %pg, <n x 4 x float> %unused, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: test1:
; CHECK:      fmax    z1.s, p0/m, z1.s, #0.0
; CHECK-NEXT: movprfx z0.s, p0/z, z1.s
; CHECK-NEXT: fadd z0.s, p0/m, z0.s, z2.s
; CHECK-NEXT: ret
  %tmp1 = call <n x 4 x float> @llvm.aarch64.sve.max.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a,
                                                             <n x 4 x float> zeroinitializer)
  %tmp1_z = select <n x 4 x i1> %pg, <n x 4 x float> %tmp1, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %tmp1_z,
                                                             <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

; As above but for unary operations.
define <n x 4 x float> @test2(<n x 4 x i1> %pg, <n x 4 x float> %unused, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: test2:
; CHECK:      fmax    z1.s, p0/m, z1.s, #0.0
; CHECK-NEXT: movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fneg z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp1 = call <n x 4 x float> @llvm.aarch64.sve.max.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a,
                                                             <n x 4 x float> zeroinitializer)
  %out = call <n x 4 x float> @llvm.aarch64.sve.neg.nxv4f32(<n x 4 x float> zeroinitializer,
                                                            <n x 4 x i1> %pg,
                                                            <n x 4 x float> %tmp1)
  ret <n x 4 x float> %out
}

declare <n x 4 x float> @llvm.aarch64.sve.mla.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 4 x float> @llvm.aarch64.sve.divr.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 4 x float> @llvm.aarch64.sve.max.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 4 x float> @llvm.aarch64.sve.neg.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
