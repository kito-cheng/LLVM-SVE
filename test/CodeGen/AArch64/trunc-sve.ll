; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 16 x i8> @trunc_h_to_b(<n x 16 x i16> %in) {
; CHECK-LABEL: trunc_h_to_b:
; CHECK: uzp1 z0.b, z0.b, z1.b
; CHECK: ret
  %out = trunc <n x 16 x i16> %in to <n x 16 x i8>
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @trunc_s_to_h(<n x 8 x i32> %in) {
; CHECK-LABEL: trunc_s_to_h:
; CHECK: uzp1 z0.h, z0.h, z1.h
; CHECK: ret
  %out = trunc <n x 8 x i32> %in to <n x 8 x i16>
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @trunc_d_to_s(<n x 4 x i64> %in) {
; CHECK-LABEL: trunc_d_to_s:
; CHECK: uzp1 z0.s, z0.s, z1.s
; CHECK: ret
  %out = trunc <n x 4 x i64> %in to <n x 4 x i32>
  ret <n x 4 x i32> %out
}

; Same again with quad-width vectors

define <n x 16 x i8> @trunc_s_to_b(<n x 16 x i32> %in) {
; CHECK-LABEL: trunc_s_to_b:
; CHECK-DAG: uzp1  [[LO:z[0-9]+]].h, z0.h, z1.h
; CHECK-DAG: uzp1  [[HI:z[0-9]+]].h, z2.h, z3.h
; CHECK:     uzp1  z0.b, [[LO]].b, [[HI]].b
; CHECK:     ret
  %out = trunc <n x 16 x i32> %in to <n x 16 x i8>
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @trunc_d_to_h(<n x 8 x i64> %in) {
; CHECK-LABEL: trunc_d_to_h:
; CHECK-DAG: uzp1  [[LO:z[0-9]+]].s, z0.s, z1.s
; CHECK-DAG: uzp1  [[HI:z[0-9]+]].s, z2.s, z3.s
; CHECK:     uzp1  z0.h, [[LO]].h, [[HI]].h
; CHECK:     ret
  %out = trunc <n x 8 x i64> %in to <n x 8 x i16>
  ret <n x 8 x i16> %out
}

; And now with octo-width.

define <n x 16 x i8> @trunc_d_to_b(<n x 16 x i64> %in) {
; CHECK-LABEL: trunc_d_to_b:
; CHECK-DAG: uzp1  [[S0:z[0-9]+]].s, z0.s, z1.s
; CHECK-DAG: uzp1  [[S1:z[0-9]+]].s, z2.s, z3.s
; CHECK-DAG: uzp1  [[HO:z[0-9]+]].h, [[S0]].h, [[S1]].h
; CHECK-DAG: uzp1  [[S2:z[0-9]+]].s, z4.s, z5.s
; CHECK-DAG: uzp1  [[S3:z[0-9]+]].s, z6.s, z7.s
; CHECK-DAG: uzp1  [[H1:z[0-9]+]].h, [[S2]].h, [[S3]].h
; CHECK:     uzp1  z0.b, [[HO]].b, [[H1]].b
; CHECK:     ret
  %out = trunc <n x 16 x i64> %in to <n x 16 x i8>
  ret <n x 16 x i8> %out
}
