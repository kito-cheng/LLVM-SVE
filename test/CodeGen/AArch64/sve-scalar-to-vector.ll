; RUN: llc < %s -mtriple=aarch64--linux-gnu -mattr=+sve | FileCheck %s

define void @scalar_to_vector_float(<n x 4 x float> *%out, float *%in) {
; CHECK-LABEL: scalar_to_vector_float:
; CHECK: ldr s[[VAL:[0-9]+]], [x1]
; CHECK: st1w {z[[VAL]].s},
; CHECK: ret
  %1 = load float , float *%in
  %2 = insertelement <n x 4 x float> undef, float %1, i32 0
  store <n x 4 x float> %2, <n x 4 x float> *%out
  ret void
}

define void @scalar_to_vector_double(<n x 2 x double> *%out, double *%in) {
; CHECK-LABEL: scalar_to_vector_double:
; CHECK: ldr d[[VAL:[0-9]+]], [x1]
; CHECK: st1d {z[[VAL]].d},
; CHECK: ret
  %1 = load double , double *%in
  %2 = insertelement <n x 2 x double> undef, double %1, i32 0
  store <n x 2 x double> %2, <n x 2 x double> *%out
  ret void
}

define void @scalar_to_vector_float_unpacked(<n x 2 x float> *%out, float *%in) {
; CHECK-LABEL: scalar_to_vector_float_unpacked:
; CHECK: ldr s[[VAL:[0-9]+]], [x1]
; CHECK: st1w {z[[VAL]].d},
; CHECK: ret
  %1 = load float, float *%in
  %2 = insertelement <n x 2 x float> undef, float %1, i32 0
  store <n x 2 x float> %2, <n x 2 x float> *%out
  ret void
}

define <n x 2 x i1> @insert_element_pred_2_lanes(i1 %x) {
; CHECK-LABEL: insert_element_pred_2_lanes:
; CHECK: cmpne p0.d, p{{[0-9]}}/z, z{{[0-9]}}.d, #0
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i1> undef, i1 %x, i32 0
  ret <n x 2 x i1> %1
}

define <n x 4 x i1> @insert_element_pred_4_lanes(i1 %x) {
; CHECK-LABEL: insert_element_pred_4_lanes:
; CHECK: cmpne p0.s, p{{[0-9]}}/z, z{{[0-9]}}.s, #0
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i1> undef, i1 %x, i32 1
  ret <n x 4 x i1> %1
}

define <n x 8 x i1> @insert_element_pred_8_lanes(i1 %x) {
; CHECK-LABEL: insert_element_pred_8_lanes:
; CHECK: cmpne p0.h, p{{[0-9]}}/z, z{{[0-9]}}.h, #0
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i1> undef, i1 %x, i32 2
  ret <n x 8 x i1> %1
}

define <n x 16 x i1> @insert_element_pred_16_lanes(i1 %x) {
; CHECK-LABEL: insert_element_pred_16_lanes:
; CHECK: cmpne p0.b, p{{[0-9]}}/z, z{{[0-9]}}.b, #0
; CHECK-NEXT: ret
  %1 = insertelement <n x 16 x i1> undef, i1 %x, i32 2
  ret <n x 16 x i1> %1
}
