; RUN: llc < %s -mtriple=aarch64--linux-gnu -mattr=+sve | FileCheck %s

define <n x 16 x i8> @splat_i8(i8 %val) {
; CHECK-LABEL: splat_i8:
; CHECK: mov z0.b, w0
; CHECK-NEXT: ret
  %1 = insertelement <n x 16 x i8> undef, i8 %val, i32 0
  %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  ret <n x 16 x i8> %2
}

define <n x 16 x i8> @splat_i8_imm() {
; CHECK-LABEL: splat_i8_imm:
; CHECK: mov z0.b, #33
; CHECK-NEXT: ret
  %1 = insertelement <n x 16 x i8> undef, i8 33, i32 0
  %2 = shufflevector <n x 16 x i8> %1, <n x 16 x i8> undef, <n x 16 x i32> zeroinitializer
  ret <n x 16 x i8> %2
}

define <n x 8 x i16> @splat_i16(i16 %val) {
; CHECK-LABEL: splat_i16:
; CHECK: mov z0.h, w0
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i16> undef, i16 %val, i32 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  ret <n x 8 x i16> %2
}

define <n x 8 x i16> @splat_i16_imm() {
; CHECK-LABEL: splat_i16_imm:
; CHECK: mov z0.h, #-32768
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i16> undef, i16 -32768, i32 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  ret <n x 8 x i16> %2
}

define <n x 8 x i16> @splat_i16_imm_invalid() {
; CHECK-LABEL: splat_i16_imm_invalid:
; CHECK: mov z0.h, w{{[0-9]+}}
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i16> undef, i16 -32767, i32 0
  %2 = shufflevector <n x 8 x i16> %1, <n x 8 x i16> undef, <n x 8 x i32> zeroinitializer
  ret <n x 8 x i16> %2
}

define <n x 4 x i32> @splat_i32(i32 %val) {
; CHECK-LABEL: splat_i32:
; CHECK: mov z0.s, w0
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i32> undef, i32 %val, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %2
}

define <n x 4 x i32> @splat_i32_imm() {
; CHECK-LABEL: splat_i32_imm:
; CHECK: mov z0.s, #-32768
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i32> undef, i32 -32768, i32 0
  %2 = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %2
}

define <n x 2 x i64> @splat_i64(i64 %val) {
; CHECK-LABEL: splat_i64:
; CHECK: mov z0.d, x0
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i64> undef, i64 %val, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  ret <n x 2 x i64> %2
}

define <n x 2 x i64> @splat_i64_imm() {
; CHECK-LABEL: splat_i64_imm:
; CHECK: mov z0.d, #-32512
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i64> undef, i64 -32512, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  ret <n x 2 x i64> %2
}

define <n x 2 x i64> @splat_i64_imm_invalid() {
; CHECK-LABEL: splat_i64_imm_invalid:
; CHECK: mov z0.d, x{{[0-9]+}}
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i64> undef, i64 32513, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  ret <n x 2 x i64> %2
}

define <n x 8 x half> @splat_half(half %val) {
; CHECK-LABEL: splat_half:
; CHECK: mov z0.h, h0
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x half> undef, half %val, i32 0
  %2 = shufflevector <n x 8 x half> %1, <n x 8 x half> undef, <n x 8 x i32> zeroinitializer
  ret <n x 8 x half> %2
}

define <n x 4 x float> @splat_float(float %val) {
; CHECK-LABEL: splat_float:
; CHECK: mov z0.s, s0
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x float> undef, float %val, i32 0
  %2 = shufflevector <n x 4 x float> %1, <n x 4 x float> undef, <n x 4 x i32> zeroinitializer
  ret <n x 4 x float> %2
}

define <n x 2 x double> @splat_double(double %val) {
; CHECK-LABEL: splat_double:
; CHECK: mov z0.d, d0
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x double> undef, double %val, i32 0
  %2 = shufflevector <n x 2 x double> %1, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  ret <n x 2 x double> %2
}

define <n x 2 x i1> @splat_i1x2(i1 %val) {
; CHECK-LABEL: splat_i1x2:
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].d, [[VAL:x[0-9]+]]
; CHECK-DAG: lsl [[TRUNC:z[0-9]+]].d, [[SPLAT:z[0-9]+]].d, #63
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK: cmpne p0.d, [[PG]]/z, [[TRUNC:z[0-9]+]].d, #0
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i1> undef, i1 %val, i32 0
  %2 = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  ret <n x 2 x i1> %2
}

define <n x 4 x i1> @splat_i1x4(i1 %val) {
; CHECK-LABEL: splat_i1x4:
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].s, w0
; CHECK-DAG: lsl [[TRUNC:z[0-9]+]].s, [[SPLAT:z[0-9]+]].s, #31
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK: cmpne p0.s, [[PG]]/z, [[TRUNC:z[0-9]+]].s, #0
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i1> undef, i1 %val, i32 0
  %2 = shufflevector <n x 4 x i1> %1, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i1> %2
}

define <n x 8 x i1> @splat_i1x8(i1 %val) {
; CHECK-LABEL: splat_i1x8:
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].h, w0
; CHECK-DAG: lsl [[TRUNC:z[0-9]+]].h, [[SPLAT:z[0-9]+]].h, #15
; CHECK-DAG: ptrue [[PG:p[0-9]+]].h
; CHECK: cmpne p0.h, [[PG]]/z, [[TRUNC:z[0-9]+]].h, #0
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i1> undef, i1 %val, i32 0
  %2 = shufflevector <n x 8 x i1> %1, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  ret <n x 8 x i1> %2
}

define <n x 16 x i1> @splat_i1x16(i1 %val) {
; CHECK-LABEL: splat_i1x16:
; CHECK-DAG: mov [[SPLAT:z[0-9]+]].b, w0
; CHECK-DAG: lsl [[TRUNC:z[0-9]+]].b, [[SPLAT:z[0-9]+]].b, #7
; CHECK-DAG: ptrue [[PG:p[0-9]+]].b
; CHECK: cmpne p0.b, [[PG]]/z, [[TRUNC:z[0-9]+]].b, #0
; CHECK-NEXT: ret
  %1 = insertelement <n x 16 x i1> undef, i1 %val, i32 0
  %2 = shufflevector <n x 16 x i1> %1, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  ret <n x 16 x i1> %2
}

define <n x 2 x i1> @splat_false_i1x2() {
; CHECK-LABEL: splat_false_i1x2:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i1> undef, i1 0, i32 0
  %2 = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  ret <n x 2 x i1> %2
}

define <n x 4 x i1> @splat_false_i1x4() {
; CHECK-LABEL: splat_false_i1x4:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i1> undef, i1 0, i32 0
  %2 = shufflevector <n x 4 x i1> %1, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i1> %2
}

define <n x 8 x i1> @splat_false_i1x8() {
; CHECK-LABEL: splat_false_i1x8:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i1> undef, i1 0, i32 0
  %2 = shufflevector <n x 8 x i1> %1, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  ret <n x 8 x i1> %2
}

define <n x 16 x i1> @splat_false_i1x16() {
; CHECK-LABEL: splat_false_i1x16:
; CHECK: pfalse p0.b
; CHECK-NEXT: ret
  %1 = insertelement <n x 16 x i1> undef, i1 0, i32 0
  %2 = shufflevector <n x 16 x i1> %1, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  ret <n x 16 x i1> %2
}

define <n x 2 x i1> @splat_true_i1x2() {
; CHECK-LABEL: splat_true_i1x2:
; CHECK: ptrue p0.d
; CHECK-NEXT: ret
  %1 = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %2 = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  ret <n x 2 x i1> %2
}

define <n x 4 x i1> @splat_true_i1x4() {
; CHECK-LABEL: splat_true_i1x4:
; CHECK: ptrue p0.s
; CHECK-NEXT: ret
  %1 = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %2 = shufflevector <n x 4 x i1> %1, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i1> %2
}

define <n x 8 x i1> @splat_true_i1x8() {
; CHECK-LABEL: splat_true_i1x8:
; CHECK: ptrue p0.h
; CHECK-NEXT: ret
  %1 = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %2 = shufflevector <n x 8 x i1> %1, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  ret <n x 8 x i1> %2
}

define <n x 16 x i1> @splat_true_i1x16() {
; CHECK-LABEL: splat_true_i1x16:
; CHECK: ptrue p0.b
; CHECK-NEXT: ret
  %1 = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %2 = shufflevector <n x 16 x i1> %1, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  ret <n x 16 x i1> %2
}

define <n x 2 x i1> @shuffle_vector_var_pred_64(<n x 2 x i1> %in) {
; CHECK-LABEL: shuffle_vector_var_pred_64:
; Check that predicate is a 64-bit lane predicate
; CHECK: cmpne p0.d, p{{[0-9]}}/z, z{{[0-9]}}.d, #0
; CHECK-NEXT: ret
  %1 = shufflevector <n x 2 x i1> %in, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  ret <n x 2 x i1> %1
}


define <n x 4 x i1> @shuffle_vector_var_pred_32(<n x 4 x i1> %in) {
; CHECK-LABEL: shuffle_vector_var_pred_32:
; Check that predicate is a 32-bit lane predicate
; CHECK: cmpne p0.s, p{{[0-9]}}/z, z{{[0-9]}}.s, #0
; CHECK-NEXT: ret
  %1 = shufflevector <n x 4 x i1> %in, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i1> %1
}

define <n x 8 x i1> @shuffle_vector_var_pred_16(<n x 8 x i1> %in) {
; CHECK-LABEL: shuffle_vector_var_pred_16:
; Check that predicate is a 16-bit lane predicate
; CHECK: cmpne p0.h, p{{[0-9]}}/z, z{{[0-9]}}.h, #0
; CHECK-NEXT: ret
  %1 = shufflevector <n x 8 x i1> %in, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  ret <n x 8 x i1> %1
}

define <n x 16 x i1> @shuffle_vector_var_pred_8(<n x 16 x i1> %in) {
; CHECK-LABEL: shuffle_vector_var_pred_8:
; Check that predicate is a 8-bit lane predicate
; CHECK: cmpne p0.b, p{{[0-9]}}/z, z{{[0-9]}}.b, #0
; CHECK-NEXT: ret
  %1 = shufflevector <n x 16 x i1> %in, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  ret <n x 16 x i1> %1
}

define <n x 32 x i1> @shuffle_vector_var_pred_8x2(<n x 32 x i1> %in) {
; CHECK-LABEL: shuffle_vector_var_pred_8x2:
; Check that predicate is a 8-bit lane predicate
; CHECK: cmpne p0.b, p{{[0-9]}}/z, z{{[0-9]}}.b, #0
; CHECK: mov p1.b, p0.b
; CHECK-NEXT: ret
  %1 = shufflevector <n x 32 x i1> %in, <n x 32 x i1> undef, <n x 32 x i32> zeroinitializer
  ret <n x 32 x i1> %1
}
