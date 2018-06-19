; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

; fpext half to float
define <n x 2 x float> @fcvts_nx2xf16(<n x 2 x half> %a) {
; CHECK-LABEL: fcvts_nx2xf16:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvt z0.s, [[PG]]/m, z0.h
; CHECK: ret
  %res = fpext <n x 2 x half> %a to <n x 2 x float>
  ret <n x 2 x float> %res
}

; fpext half to float
define <n x 4 x float> @fcvts_nx4xf16(<n x 4 x half> %a) {
; CHECK-LABEL: fcvts_nx4xf16:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: fcvt z0.s, [[PG]]/m, z0.h
; CHECK: ret
  %res = fpext <n x 4 x half> %a to <n x 4 x float>
  ret <n x 4 x float> %res
}

; fpext half to float
define <n x 8 x float> @fcvts_nx8xf16(<n x 8 x half> %a) {
; CHECK-LABEL: fcvts_nx8xf16:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: zip1 [[LO:z[0-9]+]].h, z0.h, z0.h
; CHECK-DAG: zip2 [[HI:z[0-9]+]].h, z0.h, z0.h
; CHECK-DAG: fcvt z0.s, [[PG]]/m, [[LO]].h
; CHECK-DAG: fcvt z1.s, [[PG]]/m, [[HI]].h
; CHECK: ret
  %res = fpext <n x 8 x half> %a to <n x 8 x float>
  ret <n x 8 x float> %res
}

; fpext half to double
define <n x 2 x double> @fcvtd_nx2xf16(<n x 2 x half> %a) {
; CHECK-LABEL: fcvtd_nx2xf16:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvt z0.d, [[PG]]/m, z0.h
; CHECK: ret
  %res = fpext <n x 2 x half> %a to <n x 2 x double>
  ret <n x 2 x double> %res
}

; fpext half to double
define <n x 4 x double> @fcvtd_nx4xf16(<n x 4 x half> %a) {
; CHECK-LABEL: fcvtd_nx4xf16:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: zip1 [[LO:z[0-9]+]].s, z0.s, z0.s
; CHECK-DAG: zip2 [[HI:z[0-9]+]].s, z0.s, z0.s
; CHECK-DAG: fcvt z0.d, [[PG]]/m, [[LO]].h
; CHECK-DAG: fcvt z1.d, [[PG]]/m, [[HI]].h
; CHECK: ret
  %res = fpext <n x 4 x half> %a to <n x 4 x double>
  ret <n x 4 x double> %res
}

; fpext half to double
define <n x 8 x double> @fcvtd_nx8xf16(<n x 8 x half> %a) {
; CHECK-LABEL: fcvtd_nx8xf16:
; CHECK-DAG: fcvt z0.d, {{p[0-9]+}}/m, {{z[0-9]+}}.h
; CHECK-DAG: fcvt z1.d, {{p[0-9]+}}/m, {{z[0-9]+}}.h
; CHECK-DAG: fcvt z2.d, {{p[0-9]+}}/m, {{z[0-9]+}}.h
; CHECK-DAG: fcvt z3.d, {{p[0-9]+}}/m, {{z[0-9]+}}.h
; CHECK: ret
  %res = fpext <n x 8 x half> %a to <n x 8 x double>
  ret <n x 8 x double> %res
}

; fpext float to double
define <n x 2 x double> @fcvtd_nx2xf32(<n x 2 x float> %a) {
; CHECK-LABEL: fcvtd_nx2xf32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvt z0.d, [[PG]]/m, z0.s
; CHECK: ret
  %res = fpext <n x 2 x float> %a to <n x 2 x double>
  ret <n x 2 x double> %res
}

; fpext float to double
define <n x 4 x double> @fcvtd_nx4xf32(<n x 4 x float> %a) {
; CHECK-LABEL: fcvtd_nx4xf32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: zip1 [[LO:z[0-9]+]].s, z0.s, z0.s
; CHECK-DAG: zip2 [[HI:z[0-9]+]].s, z0.s, z0.s
; CHECK-DAG: fcvt z0.d, [[PG]]/m, [[LO]].s
; CHECK-DAG: fcvt z1.d, [[PG]]/m, [[HI]].s
; CHECK: ret
  %res = fpext <n x 4 x float> %a to <n x 4 x double>
  ret <n x 4 x double> %res
}

; fpext float to double
define <n x 8 x double> @fcvtd_nx8xf32(<n x 8 x float> %a) {
; CHECK-LABEL: fcvtd_nx8xf32:
; CHECK-DAG: fcvt z0.d, {{p[0-9]+}}/m, {{z[0-9]+}}.s
; CHECK-DAG: fcvt z1.d, {{p[0-9]+}}/m, {{z[0-9]+}}.s
; CHECK-DAG: fcvt z2.d, {{p[0-9]+}}/m, {{z[0-9]+}}.s
; CHECK-DAG: fcvt z3.d, {{p[0-9]+}}/m, {{z[0-9]+}}.s
; CHECK: ret
  %res = fpext <n x 8 x float> %a to <n x 8 x double>
  ret <n x 8 x double> %res
}

; fptrunc float to half
define <n x 2 x half> @fcvth_nx2xf32(<n x 2 x float> %a) {
; CHECK-LABEL: fcvth_nx2xf32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvt z0.h, [[PG]]/m, z0.s
; CHECK: ret
  %res = fptrunc <n x 2 x float> %a to <n x 2 x half>
  ret <n x 2 x half> %res
}

; fptrunc float to half
define <n x 4 x half> @fcvth_nx4xf32(<n x 4 x float> %a) {
; CHECK-LABEL: fcvth_nx4xf32:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: fcvt z0.h, [[PG]]/m, z0.s
; CHECK: ret
  %res = fptrunc <n x 4 x float> %a to <n x 4 x half>
  ret <n x 4 x half> %res
}

; fptrunc float to half
define <n x 8 x half> @fcvth_nx8xf32(<n x 8 x float> %a) {
; CHECK-LABEL: fcvth_nx8xf32:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: fcvt [[HI:z[0-9]+]].h, [[PG]]/m, z1.s
; CHECK-DAG: fcvt [[LO:z[0-9]+]].h, [[PG]]/m, z0.s
; CHECK: uzp1 z0.h, [[LO]].h, [[HI]].h
; CHECK: ret
  %res = fptrunc <n x 8 x float> %a to <n x 8 x half>
  ret <n x 8 x half> %res
}

; fptrunc double to half
define <n x 2 x half> @fcvth_nx2xf64(<n x 2 x double> %a) {
; CHECK-LABEL: fcvth_nx2xf64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvt z0.h, [[PG]]/m, z0.d
; CHECK: ret
  %res = fptrunc <n x 2 x double> %a to <n x 2 x half>
  ret <n x 2 x half> %res
}

; fptrunc double to half
define <n x 4 x half> @fcvth_nx4xf64(<n x 4 x double> %a) {
; CHECK-LABEL: fcvth_nx4xf64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvt z0.h, [[PG]]/m, z0.d
; CHECK: ret
  %res = fptrunc <n x 4 x double> %a to <n x 4 x half>
  ret <n x 4 x half> %res
}

; fptrunc double to half
define <n x 8 x half> @fcvth_nx8xf64(<n x 8 x double> %a) {
; CHECK-LABEL: fcvth_nx8xf64:
; CHECK-DAG: fcvt {{z[0-9]+}}.h, {{p[0-9]+}}/m, z3.d
; CHECK-DAG: fcvt {{z[0-9]+}}.h, {{p[0-9]+}}/m, z2.d
; CHECK-DAG: fcvt {{z[0-9]+}}.h, {{p[0-9]+}}/m, z1.d
; CHECK-DAG: fcvt {{z[0-9]+}}.h, {{p[0-9]+}}/m, z0.d
; CHECK: ret
  %res = fptrunc <n x 8 x double> %a to <n x 8 x half>
  ret <n x 8 x half> %res
}
; fptrunc double to float
define <n x 2 x float> @fcvts_nx2xf64(<n x 2 x double> %a) {
; CHECK-LABEL: fcvts_nx2xf64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvt z0.s, [[PG]]/m, z0.d
; CHECK: ret
  %res = fptrunc <n x 2 x double> %a to <n x 2 x float>
  ret <n x 2 x float> %res
}

; fptrunc double to float
define <n x 4 x float> @fcvts_nx4xf64(<n x 4 x double> %a) {
; CHECK-LABEL: fcvts_nx4xf64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: fcvt [[HI:z[0-9]+]].s, [[PG]]/m, z1.d
; CHECK-DAG: fcvt [[LO:z[0-9]+]].s, [[PG]]/m, z0.d
; CHECK: uzp1 z0.s, [[LO]].s, [[HI]].s
; CHECK: ret
  %res = fptrunc <n x 4 x double> %a to <n x 4 x float>
  ret <n x 4 x float> %res
}

define <n x 2 x i32> @fcvtzs_s_nx2xf32(<n x 2 x float> %a) {
; CHECK-LABEL: fcvtzs_s_nx2xf32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvtzs z0.s, [[PG]]/m, z0.s
; CHECK: ret
  %res = fptosi <n x 2 x float> %a to <n x 2 x i32>
  ret <n x 2 x i32> %res
}

define <n x 2 x i32> @fcvtzs_s_nx2xf64(<n x 2 x double> %a) {
; CHECK-LABEL: fcvtzs_s_nx2xf64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvtzs z0.s, [[PG]]/m, z0.d
; CHECK: ret
  %res = fptosi <n x 2 x double> %a to <n x 2 x i32>
  ret <n x 2 x i32> %res
}

define <n x 4 x i32> @fcvtzs_s_nx4xf32(<n x 4 x float> %a) {
; CHECK-LABEL: fcvtzs_s_nx4xf32:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: fcvtzs z0.s, [[PG]]/m, z0.s
; CHECK: ret
  %res = fptosi <n x 4 x float> %a to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @fcvtzs_s_nx4xf64(<n x 4 x double> %a) {
; CHECK-LABEL: fcvtzs_s_nx4xf64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: fcvtzs [[LO:z[0-9]+]].s, [[PG]]/m, z0.d
; CHECK-DAG: fcvtzs [[HI:z[0-9]+]].s, [[PG]]/m, z1.d
; CHECK: uzp1 z0.s, [[LO]].s, [[HI]].s
; CHECK: ret
  %res = fptosi <n x 4 x double> %a to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @fcvtzs_d_nx2xf32(<n x 2 x float> %a) {
; CHECK-LABEL: fcvtzs_d_nx2xf32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvtzs z0.d, [[PG]]/m, z0.s
; CHECK: ret
  %res = fptosi <n x 2 x float> %a to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @fcvtzs_d_nx2xf64(<n x 2 x double> %a) {
; CHECK-LABEL: fcvtzs_d_nx2xf64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvtzs z0.d, [[PG]]/m, z0.d
; CHECK: ret
  %res = fptosi <n x 2 x double> %a to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 4 x i64> @fcvtzs_d_nx4xf32(<n x 4 x float> %a) {
; CHECK-LABEL: fcvtzs_d_nx4xf32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].d, z0.s
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].d, z0.s
; CHECK-DAG: fcvtzs z0.d, [[PG]]/m, [[LO]].s
; CHECK-DAG: fcvtzs z1.d, [[PG]]/m, [[HI]].s
; CHECK: ret
  %res = fptosi <n x 4 x float> %a to <n x 4 x i64>
  ret <n x 4 x i64> %res
}

define <n x 2 x i32> @fcvtzu_s_nx2xf32(<n x 2 x float> %a) {
; CHECK-LABEL: fcvtzu_s_nx2xf32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvtzu z0.s, [[PG]]/m, z0.s
; CHECK: ret
  %res = fptoui <n x 2 x float> %a to <n x 2 x i32>
  ret <n x 2 x i32> %res
}

define <n x 2 x i32> @fcvtzu_s_nx2xf64(<n x 2 x double> %a) {
; CHECK-LABEL: fcvtzu_s_nx2xf64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvtzu z0.s, [[PG]]/m, z0.d
; CHECK: ret
  %res = fptoui <n x 2 x double> %a to <n x 2 x i32>
  ret <n x 2 x i32> %res
}

define <n x 4 x i32> @fcvtzu_s_nx4xf32(<n x 4 x float> %a) {
; CHECK-LABEL: fcvtzu_s_nx4xf32:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: fcvtzu z0.s, [[PG]]/m, z0.s
; CHECK: ret
  %res = fptoui <n x 4 x float> %a to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @fcvtzu_s_nx4xf64(<n x 4 x double> %a) {
; CHECK-LABEL: fcvtzu_s_nx4xf64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: fcvtzu [[LO:z[0-9]+]].s, [[PG]]/m, z0.d
; CHECK-DAG: fcvtzu [[HI:z[0-9]+]].s, [[PG]]/m, z1.d
; CHECK: uzp1 z0.s, [[LO]].s, [[HI]].s
; CHECK: ret
  %res = fptoui <n x 4 x double> %a to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @fcvtzu_d_nx2xf32(<n x 2 x float> %a) {
; CHECK-LABEL: fcvtzu_d_nx2xf32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvtzu z0.d, [[PG]]/m, z0.s
; CHECK: ret
  %res = fptoui <n x 2 x float> %a to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @fcvtzu_d_nx2xf64(<n x 2 x double> %a) {
; CHECK-LABEL: fcvtzu_d_nx2xf64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: fcvtzu z0.d, [[PG]]/m, z0.d
; CHECK: ret
  %res = fptoui <n x 2 x double> %a to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 4 x i64> @fcvtzu_d_nx4xf32(<n x 4 x float> %a) {
; CHECK-LABEL: fcvtzu_d_nx4xf32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].d, z0.s
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].d, z0.s
; CHECK-DAG: fcvtzu z0.d, [[PG]]/m, [[LO]].s
; CHECK-DAG: fcvtzu z1.d, [[PG]]/m, [[HI]].s
; CHECK: ret
  %res = fptoui <n x 4 x float> %a to <n x 4 x i64>
  ret <n x 4 x i64> %res
}

define <n x 2 x float> @scvtf_s_nx2xi1(<n x 2 x i1> %a) {
; CHECK-LABEL: scvtf_s_nx2xi1:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: mov [[IN:z[0-9]+]].d, p0/z, #-1
; CHECK: scvtf z0.s, [[PG]]/m, [[IN]].d
; CHECK: ret
  %res = sitofp <n x 2 x i1> %a to <n x 2 x float>
  ret <n x 2 x float> %res
}

define <n x 2 x float> @scvtf_s_nx2xi32(<n x 2 x i32> %a) {
; CHECK-LABEL: scvtf_s_nx2xi32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: scvtf z0.s, [[PG]]/m, [[IN]].s
; CHECK: ret
  %res = sitofp <n x 2 x i32> %a to <n x 2 x float>
  ret <n x 2 x float> %res
}

define <n x 2 x float> @scvtf_s_nx2xi64(<n x 2 x i64> %a) {
; CHECK-LABEL: scvtf_s_nx2xi64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: scvtf z0.s, [[PG]]/m, z0.d
; CHECK: ret
  %res = sitofp <n x 2 x i64> %a to <n x 2 x float>
  ret <n x 2 x float> %res
}

define <n x 4 x float> @scvtf_s_nx4xi1(<n x 4 x i1> %a) {
; CHECK-LABEL: scvtf_s_nx4xi1:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: mov [[IN:z[0-9]+]].s, p0/z, #-1
; CHECK: scvtf z0.s, [[PG]]/m, [[IN]].s
; CHECK: ret
  %res = sitofp <n x 4 x i1> %a to <n x 4 x float>
  ret <n x 4 x float> %res
}

define <n x 4 x float> @scvtf_s_nx4xi32(<n x 4 x i32> %a) {
; CHECK-LABEL: scvtf_s_nx4xi32:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: scvtf z0.s, [[PG]]/m, z0.s
; CHECK: ret
  %res = sitofp <n x 4 x i32> %a to <n x 4 x float>
  ret <n x 4 x float> %res
}

define <n x 4 x float> @scvtf_s_nx4xi64(<n x 4 x i64> %a) {
; CHECK-LABEL: scvtf_s_nx4xi64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: scvtf [[LO:z[0-9]+]].s, [[PG]]/m, z0.d
; CHECK-DAG: scvtf [[HI:z[0-9]+]].s, [[PG]]/m, z1.d
; CHECK: uzp1 z0.s, [[LO]].s, [[HI]].s
; CHECK: ret
  %res = sitofp <n x 4 x i64> %a to <n x 4 x float>
  ret <n x 4 x float> %res
}

define <n x 2 x double> @scvtf_d_nx2xi1(<n x 2 x i1> %a) {
; CHECK-LABEL: scvtf_d_nx2xi1:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: mov [[IN:z[0-9]+]].d, p0/z, #-1
; CHECK: scvtf z0.d, [[PG]]/m, [[IN]].d
; CHECK: ret
  %res = sitofp <n x 2 x i1> %a to <n x 2 x double>
  ret <n x 2 x double> %res
}

define <n x 2 x double> @scvtf_d_nx2xi32(<n x 2 x i32> %a) {
; CHECK-LABEL: scvtf_d_nx2xi32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: scvtf z0.d, [[PG]]/m, z0.s
; CHECK: ret
  %res = sitofp <n x 2 x i32> %a to <n x 2 x double>
  ret <n x 2 x double> %res
}

define <n x 2 x double> @scvtf_d_nx2xi64(<n x 2 x i64> %a) {
; CHECK-LABEL: scvtf_d_nx2xi64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: scvtf z0.d, [[PG]]/m, z0.d
; CHECK: ret
  %res = sitofp <n x 2 x i64> %a to <n x 2 x double>
  ret <n x 2 x double> %res
}

define <n x 4 x double> @scvtf_d_nx4xi1(<n x 4 x i1> %a) {
; CHECK-LABEL: scvtf_d_nx4xi1:
; CHECK: pfalse [[ZERO:p[0-9]+]].b
; CHECK-DAG: zip1 [[LO_BOOL:p[0-9]+]].s, p0.s, [[ZERO]].s
; CHECK-DAG: zip2 [[HI_BOOL:p[0-9]+]].s, p0.s, [[ZERO]].s
; CHECK-DAG: mov [[LO:z[0-9]+]].d, [[LO_BOOL]]/z, #-1
; CHECK-DAG: mov [[HI:z[0-9]+]].d, [[HI_BOOL]]/z, #-1
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: scvtf z0.d, [[PG]]/m, [[LO]].d
; CHECK-DAG: scvtf z1.d, [[PG]]/m, [[HI]].d
; CHECK: ret
  %res = sitofp <n x 4 x i1> %a to <n x 4 x double>
  ret <n x 4 x double> %res
}

define <n x 4 x double> @scvtf_d_nx4xi32(<n x 4 x i32> %a) {
; CHECK-LABEL: scvtf_d_nx4xi32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].d, z0.s
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].d, z0.s
; CHECK-DAG: scvtf z0.d, [[PG]]/m, [[LO]].s
; CHECK-DAG: scvtf z1.d, [[PG]]/m, [[HI]].s
; CHECK: ret
  %res = sitofp <n x 4 x i32> %a to <n x 4 x double>
  ret <n x 4 x double> %res
}

define <n x 2 x float> @ucvtf_s_nx2xi1(<n x 2 x i1> %a) {
; CHECK-LABEL: ucvtf_s_nx2xi1:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: mov [[IN:z[0-9]+]].d, p0/z, #1
; CHECK: ucvtf z0.s, [[PG]]/m, [[IN]].d
; CHECK: ret
  %res = uitofp <n x 2 x i1> %a to <n x 2 x float>
  ret <n x 2 x float> %res
}

define <n x 2 x float> @ucvtf_s_nx2xi32(<n x 2 x i32> %a) {
; CHECK-LABEL: ucvtf_s_nx2xi32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ucvtf z0.s, [[PG]]/m, [[IN]].s
; CHECK: ret
  %res = uitofp <n x 2 x i32> %a to <n x 2 x float>
  ret <n x 2 x float> %res
}

define <n x 2 x float> @ucvtf_s_nx2xi64(<n x 2 x i64> %a) {
; CHECK-LABEL: ucvtf_s_nx2xi64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ucvtf z0.s, [[PG]]/m, z0.d
; CHECK: ret
  %res = uitofp <n x 2 x i64> %a to <n x 2 x float>
  ret <n x 2 x float> %res
}

define <n x 4 x float> @ucvtf_s_nx4xi1(<n x 4 x i1> %a) {
; CHECK-LABEL: ucvtf_s_nx4xi1:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: mov [[IN:z[0-9]+]].s, p0/z, #1
; CHECK: ucvtf z0.s, [[PG]]/m, [[IN]].s
; CHECK: ret
  %res = uitofp <n x 4 x i1> %a to <n x 4 x float>
  ret <n x 4 x float> %res
}

define <n x 4 x float> @ucvtf_s_nx4xi32(<n x 4 x i32> %a) {
; CHECK-LABEL: ucvtf_s_nx4xi32:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ucvtf z0.s, [[PG]]/m, z0.s
; CHECK: ret
  %res = uitofp <n x 4 x i32> %a to <n x 4 x float>
  ret <n x 4 x float> %res
}

define <n x 4 x float> @ucvtf_s_nx4xi64(<n x 4 x i64> %a) {
; CHECK-LABEL: ucvtf_s_nx4xi64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ucvtf [[LO:z[0-9]+]].s, [[PG]]/m, z0.d
; CHECK-DAG: ucvtf [[HI:z[0-9]+]].s, [[PG]]/m, z1.d
; CHECK: uzp1 z0.s, [[LO]].s, [[HI]].s
; CHECK: ret
  %res = uitofp <n x 4 x i64> %a to <n x 4 x float>
  ret <n x 4 x float> %res
}

define <n x 2 x double> @ucvtf_d_nx2xi1(<n x 2 x i1> %a) {
; CHECK-LABEL: ucvtf_d_nx2xi1:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: mov [[IN:z[0-9]+]].d, p0/z, #1
; CHECK: ucvtf z0.d, [[PG]]/m, [[IN]].d
; CHECK: ret
  %res = uitofp <n x 2 x i1> %a to <n x 2 x double>
  ret <n x 2 x double> %res
}

define <n x 2 x double> @ucvtf_d_nx2xi32(<n x 2 x i32> %a) {
; CHECK-LABEL: ucvtf_d_nx2xi32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ucvtf z0.d, [[PG]]/m, z0.s
; CHECK: ret
  %res = uitofp <n x 2 x i32> %a to <n x 2 x double>
  ret <n x 2 x double> %res
}

define <n x 2 x double> @ucvtf_d_nx2xi64(<n x 2 x i64> %a) {
; CHECK-LABEL: ucvtf_d_nx2xi64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ucvtf z0.d, [[PG]]/m, z0.d
; CHECK: ret
  %res = uitofp <n x 2 x i64> %a to <n x 2 x double>
  ret <n x 2 x double> %res
}

define <n x 4 x double> @ucvtf_d_nx4xi1(<n x 4 x i1> %a) {
; CHECK-LABEL: ucvtf_d_nx4xi1:
; CHECK: pfalse [[ZERO:p[0-9]+]].b
; CHECK-DAG: zip1 [[LO_BOOL:p[0-9]+]].s, p0.s, [[ZERO]].s
; CHECK-DAG: zip2 [[HI_BOOL:p[0-9]+]].s, p0.s, [[ZERO]].s
; CHECK-DAG: mov [[LO:z[0-9]+]].d, [[LO_BOOL]]/z, #1
; CHECK-DAG: mov [[HI:z[0-9]+]].d, [[HI_BOOL]]/z, #1
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ucvtf z0.d, [[PG]]/m, [[LO]].d
; CHECK-DAG: ucvtf z1.d, [[PG]]/m, [[HI]].d
; CHECK: ret
  %res = uitofp <n x 4 x i1> %a to <n x 4 x double>
  ret <n x 4 x double> %res
}

define <n x 4 x double> @ucvtf_d_nx4xi32(<n x 4 x i32> %a) {
; CHECK-LABEL: ucvtf_d_nx4xi32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: uunpklo [[LO:z[0-9]+]].d, z0.s
; CHECK-DAG: uunpkhi [[HI:z[0-9]+]].d, z0.s
; CHECK-DAG: ucvtf z0.d, [[PG]]/m, [[LO]].s
; CHECK-DAG: ucvtf z1.d, [[PG]]/m, [[HI]].s
; CHECK: ret
  %res = uitofp <n x 4 x i32> %a to <n x 4 x double>
  ret <n x 4 x double> %res
}
