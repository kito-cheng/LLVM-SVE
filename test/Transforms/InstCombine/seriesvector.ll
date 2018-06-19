; Tests to make sure scalar maths is prefered over vector maths.
; RUN: opt < %s -instcombine -S | FileCheck %s

; when adding a scalar to a seriesvector ensure we just recompute the
; original seriesvector's start value
define <n x 4 x i32> @add_sv_sp(i32 %start, i32 %step, i32 %inc) {
; CHECK-LABEL: @add_sv_sp
; CHECK: = add nsw i32
; CHECK: = add {{.*}}<n x
; CHECK-NOT: = add {{.*}}<n x
; CHECK: ret
  %1 = insertelement <n x 4 x i32> undef, i32 %inc, i32 0
  %splat = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %2 = insertelement <n x 4 x i32> undef, i32 %step, i32 0
  %3 = shufflevector <n x 4 x i32> %2, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %4 = mul <n x 4 x i32> %3, stepvector
  %5 = insertelement <n x 4 x i32> undef, i32 %start, i32 0
  %6 = shufflevector <n x 4 x i32> %5, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %stepvec = add <n x 4 x i32> %6, %4
  %add = add nsw <n x 4 x i32> %stepvec, %splat
  ret <n x 4 x i32> %add
}

; as above but with the operands reversed
define <n x 4 x i32> @add_sp_sv(i32 %start, i32 %step, i32 %inc) {
; CHECK-LABEL: @add_sp_sv
; CHECK: = add nsw i32
; CHECK: = add {{.*}}<n x
; CHECK-NOT: = add {{.*}}<n x
; CHECK: ret
  %1 = insertelement <n x 4 x i32> undef, i32 %inc, i32 0
  %splat = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %2 = insertelement <n x 4 x i32> undef, i32 %step, i32 0
  %3 = shufflevector <n x 4 x i32> %2, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %4 = mul <n x 4 x i32> %3, stepvector
  %5 = insertelement <n x 4 x i32> undef, i32 %start, i32 0
  %6 = shufflevector <n x 4 x i32> %5, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %stepvec = add <n x 4 x i32> %6, %4
  %add = add nsw <n x 4 x i32> %splat, %stepvec
  ret <n x 4 x i32> %add
}

; ensure scalars are used when only a single vector element is required
define i32 @extract_sv(i32 %start, i32 %step, i32 %inc) {
; CHECK-LABEL: @extract_sv
; CHECK-NOT: <n x
; CHECK: ret
  %1 = insertelement <n x 4 x i32> undef, i32 %inc, i32 0
  %splat = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %2 = insertelement <n x 4 x i32> undef, i32 %step, i32 0
  %3 = shufflevector <n x 4 x i32> %2, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %4 = mul <n x 4 x i32> %3, stepvector
  %5 = insertelement <n x 4 x i32> undef, i32 %start, i32 0
  %6 = shufflevector <n x 4 x i32> %5, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %stepvec = add <n x 4 x i32> %6, %4
  %add = add nsw <n x 4 x i32> %splat, %stepvec
  %res = extractelement <n x 4 x i32> %add, i32 0
  ret i32 %res
}

; when subtracting a scalar form a seriesvector ensure we just recompute the
; original seriesvector's start value
define <n x 4 x i32> @sub_sv_sp(i32 %start, i32 %step, i32 %inc) {
; CHECK-LABEL: @sub_sv_sp
; CHECK-NOT: = sub {{.*}}<n x
; CHECK: = sub nsw i32 %start, %inc
; CHECK-NOT: = sub {{.*}}<n x
; CHECK: ret
  %1 = insertelement <n x 4 x i32> undef, i32 %inc, i32 0
  %splat = shufflevector <n x 4 x i32> %1, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %2 = insertelement <n x 4 x i32> undef, i32 %step, i32 0
  %3 = shufflevector <n x 4 x i32> %2, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %4 = mul <n x 4 x i32> %3, stepvector
  %5 = insertelement <n x 4 x i32> undef, i32 %start, i32 0
  %6 = shufflevector <n x 4 x i32> %5, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %stepvec = add <n x 4 x i32> %6, %4
  %sub = sub nsw <n x 4 x i32> %stepvec, %splat
  ret <n x 4 x i32> %sub
}

; push truncates down to the original operand if it is beneficial to do so
define <n x 4 x i32> @trunc_sv(i64 %start) {
; CHECK-LABEL: @trunc_sv
; CHECK-NOT: trunc <n x
; CHECK-NOT: trunc (<n x
; CHECK: ret
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %start, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %stepvec = add <n x 4 x i64> %5, %3
  %trunc = trunc <n x 4 x i64> %stepvec to <n x 4 x i32>
  ret <n x 4 x i32> %trunc
}

; binop(splat(s),splat(c1)) <=> splat(binop(s, c1))
define <n x 4 x i32> @fold_binop_splats(i32 %s) {
; CHECK-LABEL: @fold_binop_splats
; CHECK-NEXT: %[[SCALAR:[a-z0-9]+]] = add i32 %s, 21
; CHECK-NEXT: %[[TOVEC:[a-z0-9]+]] = insertelement <n x 4 x i32> undef, i32 %[[SCALAR]], i32 0
; CHECK-NEXT: %[[SPLAT:[a-z0-9]+]] = shufflevector <n x 4 x i32> %[[TOVEC]], <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
; CHECK-NEXT: ret <n x 4 x i32> %[[SPLAT]]
  %tovec = insertelement <n x 4 x i32> undef, i32 %s, i32 0
  %splat = shufflevector <n x 4 x i32> %tovec, <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer
  %add = add <n x 4 x i32> %splat, shufflevector (<n x 4 x i32> insertelement (<n x 4 x i32> undef, i32 21, i32 0), <n x 4 x i32> undef, <n x 4 x i32> zeroinitializer)
  ret <n x 4 x i32> %add
}
