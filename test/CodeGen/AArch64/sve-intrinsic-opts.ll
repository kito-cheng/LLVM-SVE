; RUN: llc -O3 -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s
; RUN: opt -S -sve-intrinsicopts -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck --check-prefix CHECK-PTEST %s
; RUN: opt -S -sve-intrinsicopts -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck --check-prefix CHECK-ELIDE-REINTERPRETS %s

define i8 @add_cntb(i8 %base) {
; CHECK-LABEL: add_cntb
; CHECK: and w[[REG:[0-9]+]], w0, #0xff
; CHECK: addvl x0, x[[REG]], #1
  %cnt = tail call i64 @llvm.aarch64.sve.cntb(i32 31)
  %ext = sext i8 %base to i64
  %add = add i64 %cnt, %ext
  %conv = trunc i64 %add to i8
  ret i8 %conv
}

define i32 @add_cntb_i32(i32 %base) {
; CHECK-LABEL: add_cntb_i32
; CHECK: addvl x0, x[[REG:[0-9]+]], #1
  %cnt = tail call i64 @llvm.aarch64.sve.cntb(i32 31)
  %ext = sext i32 %base to i64
  %add = add i64 %cnt, %ext
  %conv = trunc i64 %add to i32
  ret i32 %conv
}

define i16 @add_cnth(i16 %base) {
; CHECK-LABEL: add_cnth
; CHECK: and w[[REG:[0-9]+]], w0, #0xffff
; CHECK: inch x[[REG]]
  %cnt = tail call i64 @llvm.aarch64.sve.cnth(i32 31)
  %ext = sext i16 %base to i64
  %add = add i64 %cnt, %ext
  %conv = trunc i64 %add to i16
  ret i16 %conv
}

define i32 @add_cnth_i32(i32 %base) {
; CHECK-LABEL: add_cnth_i32
; CHECK: inch x[[REG:[0-9]+]]
  %cnt = tail call i64 @llvm.aarch64.sve.cnth(i32 31)
  %ext = sext i32 %base to i64
  %add = add i64 %cnt, %ext
  %conv = trunc i64 %add to i32
  ret i32 %conv
}

define i32 @add_cntw(i32 %base) {
; CHECK-LABEL: add_cntw
; CHECK: incw
  %cnt = tail call i64 @llvm.aarch64.sve.cntw(i32 31)
  %ext = sext i32 %base to i64
  %add = add i64 %cnt, %ext
  %conv = trunc i64 %add to i32
  ret i32 %conv
}

define i32 @add_cntd_i32(i32 %base) {
; CHECK-LABEL: add_cntd_i32
; CHECK: incd x[[REG:[0-9]+]]
  %cnt = tail call i64 @llvm.aarch64.sve.cntd(i32 31)
  %ext = sext i32 %base to i64
  %add = add i64 %cnt, %ext
  %conv = trunc i64 %add to i32
  ret i32 %conv
}

; Function Attrs: nounwind
define void @acle_loop(i32* %a, i32* %b, i32 %c) {
; CHECK-LABEL: acle_loop
; CHECK-NOT: and
; CHECK-NOT: ptest
; CHECK: incw
entry:
  %0 = tail call <n x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %1 = tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv4i1(<n x 4 x i1> %0)
  %2 = tail call i64 @llvm.aarch64.sve.cntw(i32 31)
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %conv27, %do.body ]
  %3 = tail call <n x 4 x i1> @llvm.aarch64.sve.whilelt.nxv4i1.i32(i32 %i.0, i32 %c)
  %4 = tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv4i1(<n x 4 x i1> %3)
  %idx.ext = sext i32 %i.0 to i64
  %add.ptr3 = getelementptr inbounds i32, i32* %a, i64 %idx.ext
  %5 = tail call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1> %4)
  %6 = bitcast i32* %add.ptr3 to <n x 4 x i32>*
  %7 = tail call <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>* %6, i32 1, <n x 4 x i1> %5, <n x 4 x i32> zeroinitializer)
  tail call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %7, <n x 4 x i32>* %6, i32 1, <n x 4 x i1> %5)
  %add = add i64 %2, %idx.ext
  %conv27 = trunc i64 %add to i32
  %8 = tail call <n x 4 x i1> @llvm.aarch64.sve.whilelt.nxv4i1.i32(i32 %conv27, i32 %c)
  %9 = tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv4i1(<n x 4 x i1> %8)
  %10 = and <n x 16 x i1> %9, %1
  %11 = extractelement <n x 16 x i1> %10, i64 0
  br i1 %11, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret void
}

define void @ptest_any_propagate_const(i64 %n, double %da, double* %dx, double* %dy) {
; CHECK-LABEL: ptest_any_propagate_const
; CHECK-NOT: orv
; CHECK: b.ne
entry:
  %0 = tail call <n x 2 x i1> @llvm.aarch64.sve.whilelt.nxv2i1.i64(i64 0, i64 %n)
  %1 = tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %0)
  %.splatinsert = insertelement <n x 2 x double> undef, double %da, i32 0
  %.splat = shufflevector <n x 2 x double> %.splatinsert, <n x 2 x double> undef, <n x 2 x i32> zeroinitializer
  %2 = tail call i64 @llvm.aarch64.sve.cntd(i32 31)
  %3 = tail call <n x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %4 = tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %3)
  br label %do.body

do.body:
  %pg.0 = phi <n x 16 x i1> [ %1, %entry ], [ %10, %do.body ]
  %i.0 = phi i64 [ 0, %entry ], [ %add, %do.body ]
  %arrayidx = getelementptr inbounds double, double* %dx, i64 %i.0
  %5 = tail call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg.0)
  %6 = bitcast double* %arrayidx to <n x 2 x double>*
  %7 = tail call <n x 2 x double> @llvm.masked.load.nxv2f64(<n x 2 x double>* %6, i32 1, <n x 2 x i1> %5, <n x 2 x double> zeroinitializer)
  %arrayidx3 = getelementptr inbounds double, double* %dy, i64 %i.0
  %8 = bitcast double* %arrayidx3 to <n x 2 x double>*
  tail call void @llvm.masked.store.nxv2f64(<n x 2 x double> %7, <n x 2 x double>* %8, i32 1, <n x 2 x i1> %5)
  %add = add i64 %2, %i.0
  %9 = tail call <n x 2 x i1> @llvm.aarch64.sve.whilelt.nxv2i1.i64(i64 %add, i64 %n)
  %10 = tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %9)
  %11 = tail call i1 @llvm.aarch64.sve.orv.nxv16i1(<n x 16 x i1> %4, <n x 16 x i1> %10)
  br i1 %11, label %do.body, label %do.end

do.end:
  ret void
}

define i1 @ptest_any1(<n x 2 x i1> %a) {
; CHECK-PTEST-LABEL: ptest_any1
; CHECK-PTEST-NOT: @llvm.aarch64.sve.ptest.any
; CHECK-PTEST: call i1 @llvm.experimental.vector.reduce.or.i1.nxv16i1(<n x 16 x i1> %1)
  %mask = tail call <n x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 31)
  %1 = tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %mask)
  %2 = tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %a)
  %out = call i1 @llvm.aarch64.sve.ptest.any(<n x 16 x i1> %1, <n x 16 x i1> %2)
  ret i1 %out
}

define i1 @ptest_any2(<n x 2 x i1> %a) {
; CHECK-PTEST-LABEL: ptest_any2
; CHECK-PTEST: call i1 @llvm.aarch64.sve.ptest.any(<n x 16 x i1> %1, <n x 16 x i1> %2)
; CHECK-PTEST-NOT: call i1 @llvm.experimental.vector.reduce.or.i1.nxv16i1
  %mask = tail call <n x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32 0)
  %1 = tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %mask)
  %2 = tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %a)
  %out = call i1 @llvm.aarch64.sve.ptest.any(<n x 16 x i1> %1, <n x 16 x i1> %2)
  ret i1 %out
}

define <n x 2 x i1> @reinterpret_reductions(i32 %cond, <n x 2 x i1> %a, <n x 2 x i1> %b, <n x 2 x i1>  %c) {
; CHECK-ELIDE-REINTERPRETS-LABEL: reinterpret_reductions
; CHECK-ELIDE-REINTERPRETS-NOT: reinterpret
; CHECK-ELIDE-REINTERPRETS-NOT: phi <n x 16 x i1>
; CHECK-ELIDE-REINTERPRETS:  phi <n x 2 x i1> [ %a, %br_phi_a ], [ %b, %br_phi_b ], [ %c, %br_phi_c ]
; CHECK-ELIDE-REINTERPRETS-NOT: reinterpret
; CHECK-ELIDE-REINTERPRETS: ret

entry:
  switch i32 %cond, label %br_phi_c [
         i32 43, label %br_phi_a
         i32 45, label %br_phi_b
  ]

br_phi_a:
  %a1 =  tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %a)
  br label %join

br_phi_b:
  %b1 =  tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %b)
  br label %join

br_phi_c:
  %c1 =  tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %c)
  br label %join

join:
  %pg = phi <n x 16 x i1> [ %a1, %br_phi_a ], [ %b1, %br_phi_b ], [ %c1, %br_phi_c ]
  %pg1 = tail call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
  ret <n x 2 x i1> %pg1
}

define <n x 2 x i1> @reinterpret_reductions_1(i32 %cond, <n x 2 x i1> %a, <n x 4 x i1> %b, <n x 2 x i1>  %c) {
; CHECK-ELIDE-REINTERPRETS-LABEL: reinterpret_reductions_1
; CHECK-ELIDE-REINTERPRETS: reinterpret
; CHECK-ELIDE-REINTERPRETS: phi <n x 16 x i1> [ %a1, %br_phi_a ], [ %b1, %br_phi_b ], [ %c1, %br_phi_c ]
; CHECK-ELIDE-REINTERPRETS-NOT:  phi <n x 2 x i1>
; CHECK-ELIDE-REINTERPRETS: tail call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
; CHECK-ELIDE-REINTERPRETS: ret

entry:
  switch i32 %cond, label %br_phi_c [
         i32 43, label %br_phi_a
         i32 45, label %br_phi_b
  ]

br_phi_a:
  %a1 =  tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %a)
  br label %join

br_phi_b:
  %b1 =  tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv4i1(<n x 4 x i1> %b)
  br label %join

br_phi_c:
  %c1 =  tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %c)
  br label %join

join:
  %pg = phi <n x 16 x i1> [ %a1, %br_phi_a ], [ %b1, %br_phi_b ], [ %c1, %br_phi_c ]
  %pg1 = tail call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
  ret <n x 2 x i1> %pg1
}

define <n x 2 x i1> @reinterpret_reductions_2(i32 %cond, <n x 2 x i1> %a, <n x 16 x i1> %b, <n x 2 x i1>  %c) {
; CHECK-ELIDE-REINTERPRETS-LABEL: reinterpret_reductions_2
; CHECK-ELIDE-REINTERPRETS: reinterpret
; CHECK-ELIDE-REINTERPRETS: phi <n x 16 x i1> [ %a1, %br_phi_a ], [ %b, %br_phi_b ], [ %c1, %br_phi_c ]
; CHECK-ELIDE-REINTERPRETS-NOT:  phi <n x 2 x i1>
; CHECK-ELIDE-REINTERPRETS: tail call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
; CHECK-ELIDE-REINTERPRETS: ret

entry:
  switch i32 %cond, label %br_phi_c [
         i32 43, label %br_phi_a
         i32 45, label %br_phi_b
  ]

br_phi_a:
  %a1 =  tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %a)
  br label %join

br_phi_b:
  br label %join

br_phi_c:
  %c1 =  tail call <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1> %c)
  br label %join

join:
  %pg = phi <n x 16 x i1> [ %a1, %br_phi_a ], [ %b, %br_phi_b ], [ %c1, %br_phi_c ]
  %pg1 = tail call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
  ret <n x 2 x i1> %pg1
}


declare <n x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32)
declare <n x 2 x i1> @llvm.aarch64.sve.ptrue.nxv2i1(i32)
declare i1 @llvm.aarch64.sve.ptest.any(<n x 16 x i1>, <n x 16 x i1>)
declare <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv4i1(<n x 4 x i1>)
declare <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1>)
declare <n x 2 x i1> @llvm.aarch64.sve.whilelt.nxv2i1.i64(i64, i64)
declare <n x 4 x i1> @llvm.aarch64.sve.whilelt.nxv4i1.i32(i32, i32)
declare <n x 4 x i32> @llvm.aarch64.sve.mad.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1>)
declare <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1>)
declare <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>*, i32, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.masked.load.nxv2f64(<n x 2 x double>*, i32, <n x 2 x i1>, <n x 2 x double>)
declare void @llvm.masked.store.nxv4i32(<n x 4 x i32>, <n x 4 x i32>*, i32, <n x 4 x i1>)
declare void @llvm.masked.store.nxv2f64(<n x 2 x double>, <n x 2 x double>*, i32, <n x 2 x i1>)
declare i1 @llvm.aarch64.sve.orv.nxv16i1(<n x 16 x i1>, <n x 16 x i1>)

declare i64 @llvm.aarch64.sve.cntb(i32)
declare i64 @llvm.aarch64.sve.cnth(i32)
declare i64 @llvm.aarch64.sve.cntw(i32)
declare i64 @llvm.aarch64.sve.cntd(i32)
