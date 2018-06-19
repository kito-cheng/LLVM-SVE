; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve -stop-after aarch64-expand-pseudo < %s 2>&1 | FileCheck %s

define <n x 4 x float> @fadd_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK: name: fadd_s
; CHECK: BUNDLE
; CHECK-NEXT: MOVPRFX_ZPzZ_S
; CHECK-NEXT: FADD_ZPmZ_S
; CHECK-NEXT: }
; CHECK: RET
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fsqrt_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK: name: fsqrt_s
; CHECK: BUNDLE
; CHECK-NEXT: MOVPRFX_ZPzZ_S
; CHECK-NEXT: FSQRT_ZPmZ_S
; CHECK-NEXT: }
; CHECK: RET
  %out = call <n x 4 x float> @llvm.aarch64.sve.sqrt.nxv4f32(<n x 4 x float> zeroinitializer,
                                                             <n x 4 x i1> %pg,
                                                             <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

declare <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 4 x float> @llvm.aarch64.sve.sqrt.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
