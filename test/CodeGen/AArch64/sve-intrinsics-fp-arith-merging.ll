; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; FABD
;

define <n x 8 x half> @fabd_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fabd_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fabd z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.abd.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fabd_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fabd_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fabd z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.abd.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fabd_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fabd_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fabd z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.abd.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FABS
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @fabs_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fabs_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fabs z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.abs.nxv8f16(<n x 8 x half> zeroinitializer,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fabs_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fabs_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fabs z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.abs.nxv4f32(<n x 4 x float> zeroinitializer,
                                                            <n x 4 x i1> %pg,
                                                            <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fabs_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fabs_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fabs z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.abs.nxv2f64(<n x 2 x double> zeroinitializer,
                                                             <n x 2 x i1> %pg,
                                                             <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FADD
;

define <n x 8 x half> @fadd_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fadd_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fadd z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.add.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fadd_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fadd_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fadd z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fadd_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fadd_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fadd z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.add.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FDIV
;

define <n x 8 x half> @fdiv_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fdiv_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fdiv z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.div.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fdiv_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fdiv_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fdiv z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fdiv_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fdiv_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fdiv z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.div.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FDIVR
;

define <n x 8 x half> @fdivr_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fdivr_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fdivr z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.divr.nxv8f16(<n x 8 x i1> %pg,
                                                            <n x 8 x half> %a_z,
                                                            <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fdivr_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fdivr_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fdivr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.divr.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a_z,
                                                             <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fdivr_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fdivr_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fdivr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.divr.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a_z,
                                                              <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FMAD
;

define <n x 8 x half> @fmad_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b, <n x 8 x half> %c) {
; CHECK-LABEL: fmad_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fmad z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.mad.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b,
                                                           <n x 8 x half> %c)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmad_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c) {
; CHECK-LABEL: fmad_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmad z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.mad.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b,
                                                            <n x 4 x float> %c)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmad_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c) {
; CHECK-LABEL: fmad_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmad z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.mad.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b,
                                                             <n x 2 x double> %c)
  ret <n x 2 x double> %out
}


;
; FMAX
;

define <n x 8 x half> @fmax_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fmax_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fmax z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.max.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmax_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmax_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmax z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.max.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmax_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmax_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmax z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.max.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FMAXNM
;

define <n x 8 x half> @fmaxnm_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fmaxnm_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fmaxnm z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.maxnm.nxv8f16(<n x 8 x i1> %pg,
                                                             <n x 8 x half> %a_z,
                                                             <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmaxnm_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmaxnm_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmaxnm z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.maxnm.nxv4f32(<n x 4 x i1> %pg,
                                                              <n x 4 x float> %a_z,
                                                              <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmaxnm_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmaxnm_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmaxnm z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.maxnm.nxv2f64(<n x 2 x i1> %pg,
                                                               <n x 2 x double> %a_z,
                                                               <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FMIN
;

define <n x 8 x half> @fmin_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fmin_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fmin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.min.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmin_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmin_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmin z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.min.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmin_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmin_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmin z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.min.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FMINNM
;

define <n x 8 x half> @fminnm_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fminnm_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fminnm z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.minnm.nxv8f16(<n x 8 x i1> %pg,
                                                             <n x 8 x half> %a_z,
                                                             <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fminnm_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fminnm_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fminnm z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.minnm.nxv4f32(<n x 4 x i1> %pg,
                                                              <n x 4 x float> %a_z,
                                                              <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fminnm_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fminnm_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fminnm z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.minnm.nxv2f64(<n x 2 x i1> %pg,
                                                               <n x 2 x double> %a_z,
                                                               <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FMLA
;

define <n x 8 x half> @fmla_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b, <n x 8 x half> %c) {
; CHECK-LABEL: fmla_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fmla z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.mla.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b,
                                                           <n x 8 x half> %c)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmla_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c) {
; CHECK-LABEL: fmla_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmla z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.mla.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b,
                                                            <n x 4 x float> %c)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmla_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c) {
; CHECK-LABEL: fmla_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmla z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.mla.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b,
                                                             <n x 2 x double> %c)
  ret <n x 2 x double> %out
}

;
; FMLS
;

define <n x 8 x half> @fmls_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b, <n x 8 x half> %c) {
; CHECK-LABEL: fmls_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fmls z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.mls.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b,
                                                           <n x 8 x half> %c)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmls_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c) {
; CHECK-LABEL: fmls_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmls z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.mls.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b,
                                                            <n x 4 x float> %c)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmls_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c) {
; CHECK-LABEL: fmls_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmls z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.mls.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b,
                                                             <n x 2 x double> %c)
  ret <n x 2 x double> %out
}

;
; FMSB
;

define <n x 8 x half> @fmsb_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b, <n x 8 x half> %c) {
; CHECK-LABEL: fmsb_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fmsb z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.msb.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b,
                                                           <n x 8 x half> %c)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmsb_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c) {
; CHECK-LABEL: fmsb_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmsb z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.msb.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b,
                                                            <n x 4 x float> %c)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmsb_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c) {
; CHECK-LABEL: fmsb_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmsb z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.msb.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b,
                                                             <n x 2 x double> %c)
  ret <n x 2 x double> %out
}

;
; FMUL
;

define <n x 8 x half> @fmul_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fmul_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fmul z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.mul.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmul_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmul_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmul z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.mul.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmul_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmul_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmul z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.mul.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FMULX
;

define <n x 8 x half> @fmulx_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fmulx_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fmulx z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.mulx.nxv8f16(<n x 8 x i1> %pg,
                                                            <n x 8 x half> %a_z,
                                                            <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fmulx_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fmulx_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fmulx z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.mulx.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a_z,
                                                             <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fmulx_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fmulx_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fmulx z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.mulx.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a_z,
                                                              <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FNEG
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @fneg_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fneg_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fneg z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.neg.nxv8f16(<n x 8 x half> zeroinitializer,
                                                           <n x 8 x i1> %pg,
                                                           <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fneg_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fneg_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fneg z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.neg.nxv4f32(<n x 4 x float> zeroinitializer,
                                                            <n x 4 x i1> %pg,
                                                            <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fneg_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fneg_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fneg z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.neg.nxv2f64(<n x 2 x double> zeroinitializer,
                                                             <n x 2 x i1> %pg,
                                                             <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FNMAD
;

define <n x 8 x half> @fnmad_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b, <n x 8 x half> %c) {
; CHECK-LABEL: fnmad_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fnmad z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.nmad.nxv8f16(<n x 8 x i1> %pg,
                                                            <n x 8 x half> %a_z,
                                                            <n x 8 x half> %b,
                                                            <n x 8 x half> %c)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fnmad_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c) {
; CHECK-LABEL: fnmad_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fnmad z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.nmad.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a_z,
                                                             <n x 4 x float> %b,
                                                             <n x 4 x float> %c)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fnmad_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c) {
; CHECK-LABEL: fnmad_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fnmad z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.nmad.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a_z,
                                                              <n x 2 x double> %b,
                                                              <n x 2 x double> %c)
  ret <n x 2 x double> %out
}

;
; FNMLA
;

define <n x 8 x half> @fnmla_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b, <n x 8 x half> %c) {
; CHECK-LABEL: fnmla_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fnmla z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.nmla.nxv8f16(<n x 8 x i1> %pg,
                                                            <n x 8 x half> %a_z,
                                                            <n x 8 x half> %b,
                                                            <n x 8 x half> %c)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fnmla_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c) {
; CHECK-LABEL: fnmla_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fnmla z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.nmla.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a_z,
                                                             <n x 4 x float> %b,
                                                             <n x 4 x float> %c)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fnmla_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c) {
; CHECK-LABEL: fnmla_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fnmla z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.nmla.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a_z,
                                                              <n x 2 x double> %b,
                                                              <n x 2 x double> %c)
  ret <n x 2 x double> %out
}

;
; FNMLS
;

define <n x 8 x half> @fnmls_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b, <n x 8 x half> %c) {
; CHECK-LABEL: fnmls_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fnmls z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.nmls.nxv8f16(<n x 8 x i1> %pg,
                                                            <n x 8 x half> %a_z,
                                                            <n x 8 x half> %b,
                                                            <n x 8 x half> %c)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fnmls_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c) {
; CHECK-LABEL: fnmls_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fnmls z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.nmls.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a_z,
                                                             <n x 4 x float> %b,
                                                             <n x 4 x float> %c)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fnmls_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c) {
; CHECK-LABEL: fnmls_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fnmls z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.nmls.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a_z,
                                                              <n x 2 x double> %b,
                                                              <n x 2 x double> %c)
  ret <n x 2 x double> %out
}

;
; FNMSB
;

define <n x 8 x half> @fnmsb_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b, <n x 8 x half> %c) {
; CHECK-LABEL: fnmsb_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fnmsb z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.nmsb.nxv8f16(<n x 8 x i1> %pg,
                                                            <n x 8 x half> %a_z,
                                                            <n x 8 x half> %b,
                                                            <n x 8 x half> %c)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fnmsb_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c) {
; CHECK-LABEL: fnmsb_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fnmsb z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.nmsb.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a_z,
                                                             <n x 4 x float> %b,
                                                             <n x 4 x float> %c)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fnmsb_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b, <n x 2 x double> %c) {
; CHECK-LABEL: fnmsb_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fnmsb z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.nmsb.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a_z,
                                                              <n x 2 x double> %b,
                                                              <n x 2 x double> %c)
  ret <n x 2 x double> %out
}

;
; FRECPX
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @frecpx_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: frecpx_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: frecpx z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.recpx.nxv8f16(<n x 8 x half> zeroinitializer,
                                                             <n x 8 x i1> %pg,
                                                             <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @frecpx_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: frecpx_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frecpx z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.recpx.nxv4f32(<n x 4 x float> zeroinitializer,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frecpx_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: frecpx_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frecpx z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.recpx.nxv2f64(<n x 2 x double> zeroinitializer,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FRINTA
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @frinta_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: frinta_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: frinta z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.rinta.nxv8f16(<n x 8 x half> zeroinitializer,
                                                             <n x 8 x i1> %pg,
                                                             <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @frinta_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: frinta_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frinta z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.rinta.nxv4f32(<n x 4 x float> zeroinitializer,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frinta_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: frinta_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frinta z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.rinta.nxv2f64(<n x 2 x double> zeroinitializer,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FRINTI
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @frinti_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: frinti_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: frinti z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.rinti.nxv8f16(<n x 8 x half> zeroinitializer,
                                                             <n x 8 x i1> %pg,
                                                             <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @frinti_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: frinti_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frinti z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.rinti.nxv4f32(<n x 4 x float> zeroinitializer,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frinti_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: frinti_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frinti z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.rinti.nxv2f64(<n x 2 x double> zeroinitializer,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FRINTM
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @frintm_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: frintm_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: frintm z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.rintm.nxv8f16(<n x 8 x half> zeroinitializer,
                                                             <n x 8 x i1> %pg,
                                                             <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @frintm_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: frintm_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frintm z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.rintm.nxv4f32(<n x 4 x float> zeroinitializer,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frintm_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: frintm_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frintm z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.rintm.nxv2f64(<n x 2 x double> zeroinitializer,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FRINTN
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @frintn_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: frintn_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: frintn z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.rintn.nxv8f16(<n x 8 x half> zeroinitializer,
                                                             <n x 8 x i1> %pg,
                                                             <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @frintn_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: frintn_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frintn z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.rintn.nxv4f32(<n x 4 x float> zeroinitializer,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frintn_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: frintn_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frintn z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.rintn.nxv2f64(<n x 2 x double> zeroinitializer,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FRINTP
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @frintp_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: frintp_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: frintp z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.rintp.nxv8f16(<n x 8 x half> zeroinitializer,
                                                             <n x 8 x i1> %pg,
                                                             <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @frintp_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: frintp_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frintp z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.rintp.nxv4f32(<n x 4 x float> zeroinitializer,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frintp_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: frintp_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frintp z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.rintp.nxv2f64(<n x 2 x double> zeroinitializer,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FRINTX
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @frintx_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: frintx_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: frintx z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.rintx.nxv8f16(<n x 8 x half> zeroinitializer,
                                                             <n x 8 x i1> %pg,
                                                             <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @frintx_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: frintx_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frintx z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.rintx.nxv4f32(<n x 4 x float> zeroinitializer,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frintx_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: frintx_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frintx z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.rintx.nxv2f64(<n x 2 x double> zeroinitializer,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FRINTZ
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @frintz_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: frintz_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: frintz z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.rintz.nxv8f16(<n x 8 x half> zeroinitializer,
                                                             <n x 8 x i1> %pg,
                                                             <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @frintz_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: frintz_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: frintz z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.rintz.nxv4f32(<n x 4 x float> zeroinitializer,
                                                              <n x 4 x i1> %pg,
                                                              <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @frintz_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: frintz_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: frintz z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.rintz.nxv2f64(<n x 2 x double> zeroinitializer,
                                                               <n x 2 x i1> %pg,
                                                               <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FSCALE
;

define <n x 8 x half> @fscale_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: fscale_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fscale z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.scale.nxv8f16(<n x 8 x i1> %pg,
                                                             <n x 8 x half> %a_z,
                                                             <n x 8 x i16> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fscale_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: fscale_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fscale z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.scale.nxv4f32(<n x 4 x i1> %pg,
                                                              <n x 4 x float> %a_z,
                                                              <n x 4 x i32> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fscale_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: fscale_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fscale z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.scale.nxv2f64(<n x 2 x i1> %pg,
                                                               <n x 2 x double> %a_z,
                                                               <n x 2 x i64> %b)
  ret <n x 2 x double> %out
}

;
; FSQRT
;

; NOTE: The %unused paramter ensures z0 is free, leading to a simpler test.
define <n x 8 x half> @fsqrt_h(<n x 8 x half> %unused, <n x 8 x i1> %pg, <n x 8 x half> %a) {
; CHECK-LABEL: fsqrt_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fsqrt z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.sqrt.nxv8f16(<n x 8 x half> zeroinitializer,
                                                            <n x 8 x i1> %pg,
                                                            <n x 8 x half> %a)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fsqrt_s(<n x 4 x float> %unused, <n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fsqrt_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fsqrt z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %out = call <n x 4 x float> @llvm.aarch64.sve.sqrt.nxv4f32(<n x 4 x float> zeroinitializer,
                                                             <n x 4 x i1> %pg,
                                                             <n x 4 x float> %a)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fsqrt_d(<n x 2 x double> %unused, <n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fsqrt_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fsqrt z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %out = call <n x 2 x double> @llvm.aarch64.sve.sqrt.nxv2f64(<n x 2 x double> zeroinitializer,
                                                              <n x 2 x i1> %pg,
                                                              <n x 2 x double> %a)
  ret <n x 2 x double> %out
}

;
; FSUB
;

define <n x 8 x half> @fsub_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fsub_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fsub z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.sub.nxv8f16(<n x 8 x i1> %pg,
                                                           <n x 8 x half> %a_z,
                                                           <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fsub_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fsub_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fsub z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.sub.nxv4f32(<n x 4 x i1> %pg,
                                                            <n x 4 x float> %a_z,
                                                            <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fsub_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fsub_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fsub z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.sub.nxv2f64(<n x 2 x i1> %pg,
                                                             <n x 2 x double> %a_z,
                                                             <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

;
; FSUBR
;

define <n x 8 x half> @fsubr_h(<n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> %b) {
; CHECK-LABEL: fsubr_h:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fsubr z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %a_z = select <n x 8 x i1> %pg, <n x 8 x half> %a, <n x 8 x half> zeroinitializer
  %out = call <n x 8 x half> @llvm.aarch64.sve.subr.nxv8f16(<n x 8 x i1> %pg,
                                                            <n x 8 x half> %a_z,
                                                            <n x 8 x half> %b)
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fsubr_s(<n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> %b) {
; CHECK-LABEL: fsubr_s:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fsubr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %a_z = select <n x 4 x i1> %pg, <n x 4 x float> %a, <n x 4 x float> zeroinitializer
  %out = call <n x 4 x float> @llvm.aarch64.sve.subr.nxv4f32(<n x 4 x i1> %pg,
                                                             <n x 4 x float> %a_z,
                                                             <n x 4 x float> %b)
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fsubr_d(<n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> %b) {
; CHECK-LABEL: fsubr_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fsubr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %a_z = select <n x 2 x i1> %pg, <n x 2 x double> %a, <n x 2 x double> zeroinitializer
  %out = call <n x 2 x double> @llvm.aarch64.sve.subr.nxv2f64(<n x 2 x i1> %pg,
                                                              <n x 2 x double> %a_z,
                                                              <n x 2 x double> %b)
  ret <n x 2 x double> %out
}

declare <n x 8 x half> @llvm.aarch64.sve.abd.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.abd.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.abd.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.abs.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.abs.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.abs.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.add.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.add.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.add.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.div.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.div.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.div.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.divr.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.divr.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.divr.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.expa.nxv8f16(<n x 8 x i16>)
declare <n x 4 x float> @llvm.aarch64.sve.expa.nxv4f32(<n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.expa.nxv2f64(<n x 2 x i64>)

declare <n x 8 x half> @llvm.aarch64.sve.mad.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.mad.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mad.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

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

declare <n x 8 x half> @llvm.aarch64.sve.mla.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.mla.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mla.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.mls.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.mls.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mls.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.msb.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.msb.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.msb.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.mul.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.mul.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mul.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.mulx.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.mulx.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.mulx.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.neg.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.neg.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.neg.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.nmad.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.nmad.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.nmad.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.nmla.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.nmla.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.nmla.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.nmls.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.nmls.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.nmls.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.nmsb.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.nmsb.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.nmsb.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.recpe.nxv8f16(<n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.recpe.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.recpe.nxv2f64(<n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.recps.nxv8f16(<n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.recps.nxv4f32(<n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.recps.nxv2f64(<n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.recpx.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.recpx.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.recpx.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.rinta.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.rinta.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rinta.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.rinti.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.rinti.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rinti.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.rintm.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.rintm.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rintm.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.rintn.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.rintn.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rintn.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.rintp.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.rintp.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rintp.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.rintx.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.rintx.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rintx.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.rintz.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.rintz.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rintz.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.rsqrte.nxv8f16(<n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.rsqrte.nxv4f32(<n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rsqrte.nxv2f64(<n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.rsqrts.nxv8f16(<n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.rsqrts.nxv4f32(<n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.rsqrts.nxv2f64(<n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.scale.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x i16>)
declare <n x 4 x float> @llvm.aarch64.sve.scale.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.scale.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x i64>)

declare <n x 8 x half> @llvm.aarch64.sve.sqrt.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.sqrt.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.sqrt.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.sub.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.sub.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.sub.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.subr.nxv8f16(<n x 8 x i1>, <n x 8 x half>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.subr.nxv4f32(<n x 4 x i1>, <n x 4 x float>, <n x 4 x float>)
declare <n x 2 x double> @llvm.aarch64.sve.subr.nxv2f64(<n x 2 x i1>, <n x 2 x double>, <n x 2 x double>)

declare <n x 8 x half> @llvm.aarch64.sve.tmad.nxv8f16(<n x 8 x half>, <n x 8 x half>, i32)
declare <n x 4 x float> @llvm.aarch64.sve.tmad.nxv4f32(<n x 4 x float>, <n x 4 x float>, i32)
declare <n x 2 x double> @llvm.aarch64.sve.tmad.nxv2f64(<n x 2 x double>, <n x 2 x double>, i32)

declare <n x 8 x half> @llvm.aarch64.sve.tsmul.nxv8f16(<n x 8 x half>, <n x 8 x i16>)
declare <n x 4 x float> @llvm.aarch64.sve.tsmul.nxv4f32(<n x 4 x float>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.tsmul.nxv2f64(<n x 2 x double>, <n x 2 x i64>)

declare <n x 8 x half> @llvm.aarch64.sve.tssel.nxv8f16(<n x 8 x half>, <n x 8 x i16>)
declare <n x 4 x float> @llvm.aarch64.sve.tssel.nxv4f32(<n x 4 x float>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.tssel.nxv2f64(<n x 2 x double>, <n x 2 x i64>)
