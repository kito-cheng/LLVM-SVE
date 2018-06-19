; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; FADD
;

define <n x 8 x half> @fadd_h_immhalf(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fadd_h_immhalf:
; CHECK: fadd z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.500000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.add.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @ir_fadd_h_immhalf(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fadd_h_immhalf:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fadd z0.h, [[PG]]/m, z0.h, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.500000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fadd <n x 8 x half> %a, %splat
  ret <n x 8 x half> %out
}

define <n x 8 x half> @fadd_h_immone(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fadd_h_immone:
; CHECK: fadd z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 1.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.add.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @ir_fadd_h_immone(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fadd_h_immone:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fadd z0.h, [[PG]]/m, z0.h, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 1.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fadd <n x 8 x half> %a, %splat
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fadd_s_immhalf(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fadd_s_immhalf:
; CHECK: fadd z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.500000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @ir_fadd_s_immhalf(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fadd_s_immhalf:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fadd z0.s, [[PG]]/m, z0.s, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.500000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fadd <n x 4 x float> %a, %splat
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fadd_s_immone(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fadd_s_immone:
; CHECK: fadd z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 1.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @ir_fadd_s_immone(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fadd_s_immone:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fadd z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 1.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fadd <n x 4 x float> %a, %splat
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fadd_d_immhalf(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fadd_d_immhalf:
; CHECK: fadd z0.d, p0/m, z0.d, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.500000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.add.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @ir_fadd_d_immhalf(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fadd_d_immhalf:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fadd z0.d, [[PG]]/m, z0.d, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.500000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fadd <n x 2 x double> %a, %splat
  ret <n x 2 x double> %out
}

define <n x 2 x double> @fadd_d_immone(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fadd_d_immone:
; CHECK: fadd z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 1.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.add.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @ir_fadd_d_immone(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fadd_d_immone:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fadd z0.d, [[PG]]/m, z0.d, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 1.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fadd <n x 2 x double> %a, %splat
  ret <n x 2 x double> %out
}

;
; FDUP
;

define <n x 8 x half> @fdup_h_immhalf(<n x 8 x half> %a) {
; CHECK-LABEL: fdup_h_immhalf:
; CHECK: fmov z0.h, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.500000e+00, i32 0
  %out = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fdup_s_immhalf(<n x 4 x float> %a) {
; CHECK-LABEL: fdup_s_immhalf:
; CHECK: fmov z0.s, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.500000e+00, i32 0
  %out = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fdup_d_immhalf(<n x 2 x double> %a) {
; CHECK-LABEL: fdup_d_immhalf:
; CHECK: fmov z0.d, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.500000e+00, i32 0
  %out = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FMAX
;

define <n x 8 x half> @fmax_h_immzero(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fmax_h_immzero:
; CHECK: fmax z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.max.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @fmax_h_immone(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fmax_h_immone:
; CHECK: fmax z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 1.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.max.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmax_s_immzero(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmax_s_immzero:
; CHECK: fmax z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.max.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fmax_s_immone(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmax_s_immone:
; CHECK: fmax z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 1.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.max.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmax_d_immzero(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmax_d_immzero:
; CHECK: fmax z0.d, p0/m, z0.d, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.max.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @fmax_d_immone(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmax_d_immone:
; CHECK: fmax z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 1.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.max.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

;
; FMAXNM
;

define <n x 8 x half> @fmaxnm_h_immzero(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fmaxnm_h_immzero:
; CHECK: fmaxnm z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.maxnm.nxv8f16(<n x 8 x i1> %pg,
                                                             <n x 8 x half> %a,
                                                             <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @fmaxnm_h_immone(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fmaxnm_h_immone:
; CHECK: fmaxnm z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 1.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.maxnm.nxv8f16(<n x 8 x i1> %pg,
                                                             <n x 8 x half> %a,
                                                             <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmaxnm_s_immzero(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmaxnm_s_immzero:
; CHECK: fmaxnm z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.maxnm.nxv4f32(<n x 4 x i1> %pg,
                                                              <n x 4 x float> %a,
                                                              <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fmaxnm_s_immone(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmaxnm_s_immone:
; CHECK: fmaxnm z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 1.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.maxnm.nxv4f32(<n x 4 x i1> %pg,
                                                              <n x 4 x float> %a,
                                                              <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmaxnm_d_immzero(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmaxnm_d_immzero:
; CHECK: fmaxnm z0.d, p0/m, z0.d, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.maxnm.nxv2f64(<n x 2 x i1> %pg,
                                                               <n x 2 x double> %a,
                                                               <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @fmaxnm_d_immone(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmaxnm_d_immone:
; CHECK: fmaxnm z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 1.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.maxnm.nxv2f64(<n x 2 x i1> %pg,
                                                               <n x 2 x double> %a,
                                                               <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

;
; FMIN
;

define <n x 8 x half> @fmin_h_immzero(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fmin_h_immzero:
; CHECK: fmin z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.min.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @fmin_h_immone(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fmin_h_immone:
; CHECK: fmin z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 1.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.min.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmin_s_immzero(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmin_s_immzero:
; CHECK: fmin z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.min.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fmin_s_immone(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmin_s_immone:
; CHECK: fmin z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 1.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.min.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmin_d_immzero(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmin_d_immzero:
; CHECK: fmin z0.d, p0/m, z0.d, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.min.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @fmin_d_immone(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmin_d_immone:
; CHECK: fmin z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 1.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.min.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

;
; FMINNM
;

define <n x 8 x half> @fminnm_h_immzero(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fminnm_h_immzero:
; CHECK: fminnm z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.minnm.nxv8f16(<n x 8 x i1> %pg,
                                                             <n x 8 x half> %a,
                                                             <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @fminnm_h_immone(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fminnm_h_immone:
; CHECK: fminnm z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 1.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.minnm.nxv8f16(<n x 8 x i1> %pg,
                                                             <n x 8 x half> %a,
                                                             <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fminnm_s_immzero(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fminnm_s_immzero:
; CHECK: fminnm z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.minnm.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fminnm_s_immone(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fminnm_s_immone:
; CHECK: fminnm z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 1.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.minnm.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fminnm_d_immzero(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fminnm_d_immzero:
; CHECK: fminnm z0.d, p0/m, z0.d, #0.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.minnm.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @fminnm_d_immone(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fminnm_d_immone:
; CHECK: fminnm z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 1.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.minnm.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

;
; FMUL
;

define <n x 8 x half> @fmul_h_immhalf(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fmul_h_immhalf:
; CHECK: fmul z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.500000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.mul.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @ir_fmul_h_immhalf(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fmul_h_immhalf:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fmul z0.h, [[PG]]/m, z0.h, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.500000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fmul <n x 8 x half> %a, %splat
  ret <n x 8 x half> %out
}

define <n x 8 x half> @fmul_h_immtwo(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fmul_h_immtwo:
; CHECK: fmul z0.h, p0/m, z0.h, #2.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 2.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.mul.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @ir_fmul_h_immtwo(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fmul_h_immtwo:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fmul z0.h, [[PG]]/m, z0.h, #2.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 2.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fmul <n x 8 x half> %a, %splat
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmul_s_immhalf(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmul_s_immhalf:
; CHECK: fmul z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.500000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.mul.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @ir_fmul_s_immhalf(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fmul_s_immhalf:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fmul z0.s, [[PG]]/m, z0.s, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.500000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fmul <n x 4 x float> %a, %splat
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fmul_s_immtwo(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmul_s_immtwo:
; CHECK: fmul z0.s, p0/m, z0.s, #2.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 2.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.mul.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @ir_fmul_s_immtwo(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fmul_s_immtwo:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fmul z0.s, [[PG]]/m, z0.s, #2.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 2.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fmul <n x 4 x float> %a, %splat
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmul_d_immhalf(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmul_d_immhalf:
; CHECK: fmul z0.d, p0/m, z0.d, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.500000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.mul.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @ir_fmul_d_immhalf(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fmul_d_immhalf:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fmul z0.d, [[PG]]/m, z0.d, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.500000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fmul <n x 2 x double> %a, %splat
  ret <n x 2 x double> %out
}

define <n x 2 x double> @fmul_d_immtwo(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmul_d_immtwo:
; CHECK: fmul z0.d, p0/m, z0.d, #2.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 2.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.mul.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @ir_fmul_d_immtwo(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fmul_d_immtwo:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fmul z0.d, [[PG]]/m, z0.d, #2.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 2.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fmul <n x 2 x double> %a, %splat
  ret <n x 2 x double> %out
}

;
; FSUB
;

define <n x 8 x half> @fsub_h_immhalf(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fsub_h_immhalf:
; CHECK: fsub z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.500000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.sub.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @ir_fsub_h_immhalf(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fsub_h_immhalf:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fsub z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.500000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fsub <n x 8 x half> %a, %splat
  ret <n x 8 x half> %out
}

define <n x 8 x half> @fsub_h_immone(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fsub_h_immone:
; CHECK: fsub z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 1.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.sub.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @ir_fsub_h_immone(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fsub_h_immone:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fsub z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 1.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fsub <n x 8 x half> %a, %splat
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fsub_s_immhalf(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fsub_s_immhalf:
; CHECK: fsub z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.500000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.sub.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @ir_fsub_s_immhalf(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fsub_s_immhalf:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fsub z0.s, [[PG]]/m, z0.s, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.500000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fsub <n x 4 x float> %a, %splat
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fsub_s_immone(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fsub_s_immone:
; CHECK: fsub z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 1.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.sub.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a,
                                                            <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @ir_fsub_s_immone(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fsub_s_immone:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fsub z0.s, [[PG]]/m, z0.s, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 1.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fsub <n x 4 x float> %a, %splat
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fsub_d_immhalf(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fsub_d_immhalf:
; CHECK: fsub z0.d, p0/m, z0.d, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.500000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.sub.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @ir_fsub_d_immhalf(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fsub_d_immhalf:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fsub z0.d, [[PG]]/m, z0.d, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.500000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fsub <n x 2 x double> %a, %splat
  ret <n x 2 x double> %out
}

define <n x 2 x double> @fsub_d_immone(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fsub_d_immone:
; CHECK: fsub z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 1.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.sub.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a,
                                                             <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @ir_fsub_d_immone(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fsub_d_immone:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fsub z0.d, [[PG]]/m, z0.d, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 1.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fsub <n x 2 x double> %a, %splat
  ret <n x 2 x double> %out
}

;
; FSUBR
;

define <n x 8 x half> @fsubr_h_immhalf(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fsubr_h_immhalf:
; CHECK: fsubr z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 0.500000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.subr.nxv8f16(<n x 8 x i1> %pg,
                                                            <n x 8 x half> %a,
                                                            <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 8 x half> @fsubr_h_immone(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fsubr_h_immone:
; CHECK: fsubr z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 8 x half> undef, half 1.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.subr.nxv8f16(<n x 8 x i1> %pg,
                                                            <n x 8 x half> %a,
                                                            <n x 8 x half> %splat)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fsubr_s_immhalf(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fsubr_s_immhalf:
; CHECK: fsubr z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 0.500000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.subr.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a,
                                                             <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fsubr_s_immone(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fsubr_s_immone:
; CHECK: fsubr z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 4 x float> undef, float 1.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.subr.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a,
                                                             <n x 4 x float> %splat)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fsubr_d_immhalf(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fsubr_d_immhalf:
; CHECK: fsubr z0.d, p0/m, z0.d, #0.5
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 0.500000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.subr.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a,
                                                              <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}

define <n x 2 x double> @fsubr_d_immone(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fsubr_d_immone:
; CHECK: fsubr z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT: ret
  %elt   = insertelement <n x 2 x double> undef, double 1.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.subr.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a,
                                                              <n x 2 x double> %splat)
  ret <n x 2 x double> %out
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                Comparisons                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
; FCMEQ
;

define <n x 8 x i1> @fcmeq_h_zero(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fcmeq_h_zero:
; CHECK: fcmeq p0.h, p0/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpeq.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @ir_fcmeq_h_zero(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fcmeq_h_zero:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fcmeq p0.h, [[PG]]/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fcmp oeq <n x 8 x half> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmeq_s_zero(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fcmeq_s_zero:
; CHECK: fcmeq p0.s, p0/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpeq.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %a,
                                                           <n x 4 x float> %splat)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @ir_fcmeq_s_zero(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fcmeq_s_zero:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fcmeq p0.s, [[PG]]/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fcmp oeq <n x 4 x float> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmeq_d_zero(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fcmeq_d_zero:
; CHECK: fcmeq p0.d, p0/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpeq.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %a,
                                                           <n x 2 x double> %splat)
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @ir_fcmeq_d_zero(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fcmeq_d_zero:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fcmeq p0.d, [[PG]]/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fcmp oeq <n x 2 x double> %a, %splat
  ret <n x 2 x i1> %out
}

;
; FCMNE
;

define <n x 8 x i1> @fcmne_h_zero(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fcmne_h_zero:
; CHECK: fcmne p0.h, p0/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpne.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmne_s_zero(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fcmne_s_zero:
; CHECK: fcmne p0.s, p0/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpne.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %a,
                                                           <n x 4 x float> %splat)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmne_d_zero(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fcmne_d_zero:
; CHECK: fcmne p0.d, p0/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpne.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %a,
                                                           <n x 2 x double> %splat)
  ret <n x 2 x i1> %out
}

;
; FCMGE
;

define <n x 8 x i1> @fcmge_h_zero(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fcmge_h_zero:
; CHECK: fcmge p0.h, p0/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpge.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @ir_fcmge_h_zero(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fcmge_h_zero:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fcmge p0.h, [[PG]]/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fcmp oge <n x 8 x half> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmge_s_zero(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fcmge_s_zero:
; CHECK: fcmge p0.s, p0/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpge.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %a,
                                                           <n x 4 x float> %splat)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @ir_fcmge_s_zero(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fcmge_s_zero:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fcmge p0.s, [[PG]]/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fcmp oge <n x 4 x float> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmge_d_zero(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fcmge_d_zero:
; CHECK: fcmge p0.d, p0/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpge.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %a,
                                                           <n x 2 x double> %splat)
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @ir_fcmge_d_zero(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fcmge_d_zero:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fcmge p0.d, [[PG]]/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fcmp oge <n x 2 x double> %a, %splat
  ret <n x 2 x i1> %out
}

;
; FCMGT
;

define <n x 8 x i1> @fcmgt_h_zero(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fcmgt_h_zero:
; CHECK: fcmgt p0.h, p0/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpgt.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a,
                                                           <n x 8 x half> %splat)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @ir_fcmgt_h_zero(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fcmgt_h_zero:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fcmgt p0.h, [[PG]]/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fcmp ogt <n x 8 x half> %a, %splat
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmgt_s_zero(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fcmgt_s_zero:
; CHECK: fcmgt p0.s, p0/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpgt.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %a,
                                                           <n x 4 x float> %splat)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @ir_fcmgt_s_zero(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fcmgt_s_zero:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fcmgt p0.s, [[PG]]/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fcmp ogt <n x 4 x float> %a, %splat
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmgt_d_zero(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fcmgt_d_zero:
; CHECK: fcmgt p0.d, p0/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpgt.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %a,
                                                           <n x 2 x double> %splat)
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @ir_fcmgt_d_zero(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fcmgt_d_zero:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fcmgt p0.d, [[PG]]/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fcmp ogt <n x 2 x double> %a, %splat
  ret <n x 2 x i1> %out
}

;
; FCMLE
;

define <n x 8 x i1> @fcmle_h_zero(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fcmle_h_zero:
; CHECK: fcmle p0.h, p0/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpge.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %splat,
                                                           <n x 8 x half> %a)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @ir_fcmle_h_zero(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fcmle_h_zero:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fcmle p0.h, [[PG]]/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fcmp oge <n x 8 x half> %splat, %a
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmle_s_zero(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fcmle_s_zero:
; CHECK: fcmle p0.s, p0/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpge.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %splat,
                                                           <n x 4 x float> %a)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @ir_fcmle_s_zero(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fcmle_s_zero:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fcmle p0.s, [[PG]]/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fcmp oge <n x 4 x float> %splat, %a
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmle_d_zero(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fcmle_d_zero:
; CHECK: fcmle p0.d, p0/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpge.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %splat,
                                                           <n x 2 x double> %a)
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @ir_fcmle_d_zero(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fcmle_d_zero:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fcmle p0.d, [[PG]]/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fcmp oge <n x 2 x double> %splat, %a
  ret <n x 2 x i1> %out
}

;
; FCMLT
;

define <n x 8 x i1> @fcmlt_h_zero(<n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fcmlt_h_zero:
; CHECK: fcmlt p0.h, p0/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = call <n x 8 x i1> @llvm.aarch64.sve.cmpgt.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %splat,
                                                           <n x 8 x half> %a)
  ret <n x 8 x i1> %out
}

define <n x 8 x i1> @ir_fcmlt_h_zero(<n x 8 x half> %a) {
; CHECK-LABEL: ir_fcmlt_h_zero:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: fcmlt p0.h, [[PG]]/z, z0.h, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 8 x half> undef, half 0.000000e+00, i32 0
  %splat = shufflevector <n x 8 x half> %elt, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  %out = fcmp ogt <n x 8 x half> %splat, %a
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @fcmlt_s_zero(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fcmlt_s_zero:
; CHECK: fcmlt p0.s, p0/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = call <n x 4 x i1> @llvm.aarch64.sve.cmpgt.nxv4f32(<n x 4 x i1> %pg,
                                                           <n x 4 x float> %splat,
                                                           <n x 4 x float> %a)
  ret <n x 4 x i1> %out
}

define <n x 4 x i1> @ir_fcmlt_s_zero(<n x 4 x float> %a) {
; CHECK-LABEL: ir_fcmlt_s_zero:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: fcmlt p0.s, [[PG]]/z, z0.s, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 4 x float> undef, float 0.000000e+00, i32 0
  %splat = shufflevector <n x 4 x float> %elt, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  %out = fcmp ogt <n x 4 x float> %splat, %a
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @fcmlt_d_zero(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fcmlt_d_zero:
; CHECK: fcmlt p0.d, p0/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = call <n x 2 x i1> @llvm.aarch64.sve.cmpgt.nxv2f64(<n x 2 x i1> %pg,
                                                           <n x 2 x double> %splat,
                                                           <n x 2 x double> %a)
  ret <n x 2 x i1> %out
}

define <n x 2 x i1> @ir_fcmlt_d_zero(<n x 2 x double> %a) {
; CHECK-LABEL: ir_fcmlt_d_zero:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: fcmlt p0.d, [[PG]]/z, z0.d, #0.0
; CHECK-NEXT: ret
  %elt = insertelement <n x 2 x double> undef, double 0.000000e+00, i32 0
  %splat = shufflevector <n x 2 x double> %elt, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %out = fcmp ogt <n x 2 x double> %splat, %a
  ret <n x 2 x i1> %out
}

;; Arithmetic intrinsic declarations

declare <n x 8 x half> @llvm.aarch64.sve.add.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.add.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.max.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.max.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.max.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.maxnm.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.maxnm.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.maxnm.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.min.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.min.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.min.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.minnm.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.minnm.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.minnm.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.mul.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.mul.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mul.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.sub.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.sub.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.sub.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.subr.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.subr.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.subr.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

;; Comparison intrinsic declarations
declare <n x 8 x i1> @llvm.aarch64.sve.cmpeq.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpeq.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpeq.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x i1> @llvm.aarch64.sve.cmpne.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpne.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpne.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x i1> @llvm.aarch64.sve.cmpge.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpge.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpge.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x i1> @llvm.aarch64.sve.cmpgt.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x i1> @llvm.aarch64.sve.cmpgt.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x i1> @llvm.aarch64.sve.cmpgt.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)
