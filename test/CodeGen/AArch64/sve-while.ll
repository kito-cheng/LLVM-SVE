; RUN: llc -O3 -mtriple=aarch64--linux-gnu -mattr=+sve -aarch64-sve-postvec < %s | FileCheck %s

define void @while_ult_b(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_b:
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.b, x{{[0-9]+}}, x1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 16 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 16 x i64> %0, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %1 = insertelement <n x 16 x i1> undef, i1 true, i32 0
  %ptrue = shufflevector <n x 16 x i1> %1, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 16 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]
  %index.next = add nuw i64 %index, mul (i64 vscale, i64 16)
  %2 = insertelement <n x 16 x i64> undef, i64 1, i32 0
  %3 = shufflevector <n x 16 x i64> %2, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %4 = mul <n x 16 x i64> %3, stepvector
  %5 = insertelement <n x 16 x i64> undef, i64 %index.next, i32 0
  %6 = shufflevector <n x 16 x i64> %5, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %index.wide = add <n x 16 x i64> %6, %4
  %cmp = icmp ult <n x 16 x i64> %index.wide, %end.wide
  %pred.next = call <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1> %predicate, <n x 16 x i1> %cmp)
  %cond = extractelement <n x 16 x i1> %pred.next, i64 0
  br i1 %cond, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

define void @while_ult_h(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_h:
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.h, x{{[0-9]+}}, x1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 8 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 8 x i64> %0, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %1 = insertelement <n x 8 x i1> undef, i1 true, i32 0
  %ptrue = shufflevector <n x 8 x i1> %1, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 8 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]
  %index.next = add nuw i64 %index, mul (i64 vscale, i64 8)
  %2 = insertelement <n x 8 x i64> undef, i64 1, i32 0
  %3 = shufflevector <n x 8 x i64> %2, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %4 = mul <n x 8 x i64> %3, stepvector
  %5 = insertelement <n x 8 x i64> undef, i64 %index.next, i32 0
  %6 = shufflevector <n x 8 x i64> %5, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %index.wide = add <n x 8 x i64> %6, %4
  %cmp = icmp ult <n x 8 x i64> %index.wide, %end.wide
  %pred.next = call <n x 8 x i1> @llvm.propff.nxv8i1(<n x 8 x i1> %predicate, <n x 8 x i1> %cmp)
  %cond = extractelement <n x 8 x i1> %pred.next, i64 0
  br i1 %cond, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

define void @while_ult_s(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_s:
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.s, x{{[0-9]+}}, x1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 4 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 4 x i64> %0, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %1 = insertelement <n x 4 x i1> undef, i1 true, i32 0
  %ptrue = shufflevector <n x 4 x i1> %1, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 4 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]
  %index.next = add nuw i64 %index, mul (i64 vscale, i64 4)
  %2 = insertelement <n x 4 x i64> undef, i64 1, i32 0
  %3 = shufflevector <n x 4 x i64> %2, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %4 = mul <n x 4 x i64> %3, stepvector
  %5 = insertelement <n x 4 x i64> undef, i64 %index.next, i32 0
  %6 = shufflevector <n x 4 x i64> %5, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %index.wide = add <n x 4 x i64> %6, %4
  %cmp = icmp ult <n x 4 x i64> %index.wide, %end.wide
  %pred.next = call <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1> %predicate, <n x 4 x i1> %cmp)
  %cond = extractelement <n x 4 x i1> %pred.next, i64 0
  br i1 %cond, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

define void @while_ult_d(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_d:
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.d, x{{[0-9]+}}, x1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 2 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 2 x i64> %0, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i1> undef, i1 true, i32 0
  %ptrue = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 2 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]
  %index.next = add nuw i64 %index, mul (i64 vscale, i64 2)
  %2 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %3 = shufflevector <n x 2 x i64> %2, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %4 = mul <n x 2 x i64> %3, stepvector
  %5 = insertelement <n x 2 x i64> undef, i64 %index.next, i32 0
  %6 = shufflevector <n x 2 x i64> %5, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %index.wide = add <n x 2 x i64> %6, %4
  %cmp = icmp ult <n x 2 x i64> %index.wide, %end.wide
  %pred.next = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %predicate, <n x 2 x i1> %cmp)
  %cond = extractelement <n x 2 x i1> %pred.next, i64 0
  br i1 %cond, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

; As above but with 32bit scalars.
define void @while4_ult_d(i32 %start, i32 %end) {
; CHECK-LABEL: while4_ult_d:
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.d, w{{[0-9]+}}, w1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 2 x i32> undef, i32 %end, i32 0
  %end.wide = shufflevector <n x 2 x i32> %0, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i1> undef, i1 true, i32 0
  %ptrue = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %index = phi i32 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 2 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]
  %index.next = add nuw i32 %index, mul (i32 vscale, i32 2)
  %2 = insertelement <n x 2 x i32> undef, i32 1, i32 0
  %3 = shufflevector <n x 2 x i32> %2, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %4 = mul <n x 2 x i32> %3, stepvector
  %5 = insertelement <n x 2 x i32> undef, i32 %index.next, i32 0
  %6 = shufflevector <n x 2 x i32> %5, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %index.wide = add <n x 2 x i32> %6, %4
  %cmp = icmp ult <n x 2 x i32> %index.wide, %end.wide
  %pred.next = call <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1> %predicate, <n x 2 x i1> %cmp)
  %cond = extractelement <n x 2 x i1> %pred.next, i64 0
  br i1 %cond, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

; As while_lt_b but check that we still use WHILE when the first operand of a
; propff contains more than just ptrue and itself.
define void @while_ult_b_complex(i64 %start, i64 %end, <n x 16 x i1>* %ptr) {
; CHECK-LABEL: while_ult_b_complex:
; CHECK: whilelo {{p[0-9]+}}.b, x{{[0-9]+}}, x1
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.b, x{{[0-9]+}}, x1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 16 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 16 x i64> %0, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %1 = insertelement <n x 16 x i1> undef, i1 true, i32 0
  %ptrue = shufflevector <n x 16 x i1> %1, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  %2 = insertelement <n x 16 x i64> undef, i64 1, i32 0
  %3 = shufflevector <n x 16 x i64> %2, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %4 = mul <n x 16 x i64> %3, stepvector
  %5 = insertelement <n x 16 x i64> undef, i64 %start, i32 0
  %6 = shufflevector <n x 16 x i64> %5, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %start.wide = add <n x 16 x i64> %6, %4
  %cmp.first = icmp ult <n x 16 x i64> %start.wide, %end.wide
  %pred.first = call <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1> %ptrue, <n x 16 x i1> %cmp.first)
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 16 x i1> [ %pred.first, %entry ], [ %pred.next, %for.body ]
  store <n x 16 x i1> %predicate, <n x 16 x i1>* %ptr
  %index.next = add nuw i64 %index, mul (i64 vscale, i64 16)
  %7 = insertelement <n x 16 x i64> undef, i64 1, i32 0
  %8 = shufflevector <n x 16 x i64> %7, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %9 = mul <n x 16 x i64> %8, stepvector
  %10 = insertelement <n x 16 x i64> undef, i64 %index.next, i32 0
  %11 = shufflevector <n x 16 x i64> %10, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %index.wide = add <n x 16 x i64> %11, %9
  %cmp.next = icmp ult <n x 16 x i64> %index.wide, %end.wide
  %pred.next = call <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1> %predicate, <n x 16 x i1> %cmp.next)
  %cond = extractelement <n x 16 x i1> %pred.next, i64 0
  br i1 %cond, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

; As while_lt_b but ensures we still use WHILE when we cannot guarantee the
; calculation of %index.next doesn't wrap.
define void @while_ult_b_wrap(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_b_wrap:
; CHECK-NOT: not
; CHECK-NOT: brkb
; CHECK: whilelo [[COND:p[0-9]+]].b, x{{[0-9]+}}, x1
; CHECK-NOT: not
; CHECK-NOT: brkb
; CHECK: brkns {{p[0-9]+}}.b, {{p[0-9]+}}/z, {{p[0-9]+}}.b, [[COND]].b
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 16 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 16 x i64> %0, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %1 = insertelement <n x 16 x i1> undef, i1 true, i32 0
  %ptrue = shufflevector <n x 16 x i1> %1, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 16 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]
  %index.next = add i64 %index, mul (i64 vscale, i64 16)
  %2 = insertelement <n x 16 x i64> undef, i64 1, i32 0
  %3 = shufflevector <n x 16 x i64> %2, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %4 = mul <n x 16 x i64> %3, stepvector
  %5 = insertelement <n x 16 x i64> undef, i64 %index.next, i32 0
  %6 = shufflevector <n x 16 x i64> %5, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %index.wide = add <n x 16 x i64> %6, %4
  %cmp = icmp ult <n x 16 x i64> %index.wide, %end.wide
  %pred.next = call <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1> %predicate, <n x 16 x i1> %cmp)
  %cond = extractelement <n x 16 x i1> %pred.next, i64 0
  br i1 %cond, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

declare <n x 16 x i1> @llvm.propff.nxv16i1(<n x 16 x i1>, <n x 16 x i1>)
declare <n x 8 x i1> @llvm.propff.nxv8i1(<n x 8 x i1>, <n x 8 x i1>)
declare <n x 4 x i1> @llvm.propff.nxv4i1(<n x 4 x i1>, <n x 4 x i1>)
declare <n x 2 x i1> @llvm.propff.nxv2i1(<n x 2 x i1>, <n x 2 x i1>)
