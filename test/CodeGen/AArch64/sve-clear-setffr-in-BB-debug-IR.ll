; RUN: llc --aarch64-setffr-optimize < %s | FileCheck %s

; This tests makes sure that debug information don't mess up with the 'aarch64-setffr-optimise' pass.
; The C code used is a simplified version of the loop in function mcRandom of monteCarlo benchmark.

;clang -O3 -S -emit-llvm -target aarch64-generic-linux -march=armv8-a+sve -c ../sample.c -o ../sample.debug.ll -mllvm -debug-only=loop-vec-analysis -mllvm -enable-laa-uncounted-loops -mllvm -sl-enable-lv-uncounted-loops -mllvm -vectorize-search-loops -mllvm -sl-force-scalable-vectorization -Ofast -g
;
; void mcRandom(double *x, int *restrict  d,
;               double *restrict q, int UBound) {
;   int j;
;   for (j = 0; j < UBound; j++) {
;     x[0] += q[j];
;
;     if (d[j] < UBound)
;       break;
;
;       x[0] -= q[j-1];
;   }
;
; }

; XFAIL: *

; ModuleID = '../sample.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-generic-linux"

; Function Attrs: norecurse nounwind
define void @mcRandom(double* nocapture %x, i32* noalias nocapture readonly %d, double* noalias nocapture readonly %q, i32 %UBound) #0 !dbg !4 {
entry:
  tail call void @llvm.dbg.value(metadata double* %x, i64 0, metadata !14, metadata !22), !dbg !23
  tail call void @llvm.dbg.value(metadata i32* %d, i64 0, metadata !15, metadata !22), !dbg !24
  tail call void @llvm.dbg.value(metadata double* %q, i64 0, metadata !16, metadata !22), !dbg !26
  tail call void @llvm.dbg.value(metadata i32 %UBound, i64 0, metadata !17, metadata !22), !dbg !27
  tail call void @llvm.dbg.value(metadata i32 0, i64 0, metadata !18, metadata !22), !dbg !28
  %cmp.17 = icmp sgt i32 %UBound, 0, !dbg !29
  br i1 %cmp.17, label %for.body.lr.ph, label %for.end, !dbg !33

for.body.lr.ph:                                   ; preds = %entry
  %x.promoted = load double, double* %x, align 8, !dbg !34, !tbaa !36
  %0 = sext i32 %UBound to i64, !dbg !33
  %backedge.overflow = icmp eq i32 %UBound, 0
  br i1 %backedge.overflow, label %for.body.preheader, label %overflow.checked

for.body.preheader:                               ; preds = %for.body.lr.ph
  %1 = getelementptr double, double* %q, i64 -1, !dbg !40
  br label %for.body, !dbg !41

overflow.checked:                                 ; preds = %for.body.lr.ph
  %2 = sext i32 %UBound to i64, !dbg !33
  %3 = insertelement <n x 2 x double> zeroinitializer, double %x.promoted, i32 0
  %wide.end.idx.splatinsert = insertelement <n x 2 x i64> undef, i64 %2, i32 0, !dbg !41
  %wide.end.idx.splat = shufflevector <n x 2 x i64> %wide.end.idx.splatinsert, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer, !dbg !41
  %4 = icmp sgt <n x 2 x i64> %wide.end.idx.splat, seriesvector (i64 0, i64 1), !dbg !41
  %predicate.entry = propff <n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), %4, !dbg !41
  %broadcast.splatinsert26 = insertelement <n x 2 x i32> undef, i32 %UBound, i32 0, !dbg !33
  %broadcast.splat27 = shufflevector <n x 2 x i32> %broadcast.splatinsert26, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer, !dbg !33
  %5 = getelementptr double, double* %q, i64 -1, !dbg !40
  br label %vector.body, !dbg !33

vector.body:                                      ; preds = %vector.body, %overflow.checked
  %index = phi i64 [ 0, %overflow.checked ], [ %index.next, %vector.body ], !dbg !41
  %predicate = phi <n x 2 x i1> [ %predicate.entry, %overflow.checked ], [ %predicate.next, %vector.body ], !dbg !41
  %vec.phi = phi <n x 2 x double> [ %3, %overflow.checked ], [ %32, %vector.body ]
  %6 = getelementptr inbounds i32, i32* %d, i64 %index, !dbg !42
  %7 = bitcast i32* %6 to <n x 2 x i32>*, !dbg !42
; CHECK: setffr
; CHECK-NEXT: ldff
  %wide.masked.ffload = call { <n x 2 x i32>, <n x 2 x i1> } @llvm.masked.load.ff.nxv2i32(<n x 2 x i32>* %7, i32 4, <n x 2 x i1> %predicate, <n x 2 x i32> undef), !dbg !42
  %8 = extractvalue { <n x 2 x i32>, <n x 2 x i1> } %wide.masked.ffload, 1, !dbg !42
  %9 = and <n x 2 x i1> %predicate, %8, !dbg !42
  %10 = extractvalue { <n x 2 x i32>, <n x 2 x i1> } %wide.masked.ffload, 0, !dbg !42, !tbaa !44
  %11 = icmp slt <n x 2 x i32> %10, %broadcast.splat27, !dbg !46
  %12 = xor <n x 2 x i1> %11, shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), !dbg !46
  %13 = propff <n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), %12, !dbg !46
  %cntp.ee = call i64 @llvm.ctvpop.nxv2i1(<n x 2 x i1> %13), !dbg !46
  %14 = urem i64 %cntp.ee, elementcount (<n x 2 x i64> undef), !dbg !46
  %15 = trunc i64 %14 to i32, !dbg !46
  %16 = insertelement <n x 2 x i1> %13, i1 true, i32 %15, !dbg !46
  %17 = and <n x 2 x i1> %9, %16, !dbg !46
  %18 = propff <n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), %17, !dbg !46
  %19 = getelementptr inbounds double, double* %q, i64 %index, !dbg !41
  %20 = bitcast double* %19 to <n x 2 x double>*, !dbg !41
; CHECK-NOT: setffr
; CHECK: ldff
  %wide.masked.ffload.28 = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.load.ff.nxv2f64(<n x 2 x double>* %20, i32 8, <n x 2 x i1> %18, <n x 2 x double> undef), !dbg !41
  %21 = extractvalue { <n x 2 x double>, <n x 2 x i1> } %wide.masked.ffload.28, 1, !dbg !41
  %22 = and <n x 2 x i1> %18, %21, !dbg !41
  %23 = extractvalue { <n x 2 x double>, <n x 2 x i1> } %wide.masked.ffload.28, 0, !dbg !41, !tbaa !36
  %24 = fadd fast <n x 2 x double> %vec.phi, %23, !dbg !47
  %25 = xor <n x 2 x i1> %11, shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), !dbg !47
  %26 = and <n x 2 x i1> %22, %25, !dbg !47
  %27 = propff <n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), %26, !dbg !47
  %28 = getelementptr double, double* %5, i64 %index, !dbg !40
  %29 = bitcast double* %28 to <n x 2 x double>*, !dbg !40
; CHECK-NOT: setffr
; CHECK: ldff
  %wide.masked.ffload.29 = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.load.ff.nxv2f64(<n x 2 x double>* %29, i32 8, <n x 2 x i1> %27, <n x 2 x double> undef), !dbg !40
  %30 = extractvalue { <n x 2 x double>, <n x 2 x i1> } %wide.masked.ffload.29, 0, !dbg !40, !tbaa !36
  %31 = fsub fast <n x 2 x double> %24, %30, !dbg !34
  %32 = select <n x 2 x i1> %predicate, <n x 2 x double> %31, <n x 2 x double> %vec.phi
  %index.next = add nsw i64 %index, elementcount (<n x 2 x i64> undef), !dbg !41
  %33 = seriesvector i64 %index.next, i64 1 as <n x 2 x i64>, !dbg !41
  %34 = icmp slt <n x 2 x i64> %33, %wide.end.idx.splat, !dbg !41
  %predicate.next = propff <n x 2 x i1> %predicate, %34, !dbg !41
  %35 = test first true <n x 2 x i1> %predicate.next, !dbg !41
  %36 = test all false <n x 2 x i1> %11, !dbg !41
  %37 = and i1 %35, %36, !dbg !41
  br i1 %37, label %vector.body, label %reduction.check, !dbg !41, !llvm.loop !48

reduction.check:                                  ; preds = %vector.body
  %.lcssa40 = phi <n x 2 x double> [ %32, %vector.body ]
  %.lcssa39 = phi <n x 2 x double> [ %24, %vector.body ]
  %.lcssa = phi <n x 2 x i1> [ %11, %vector.body ]
  %index.lcssa = phi i64 [ %index, %vector.body ]
  %38 = xor <n x 2 x i1> %.lcssa, shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), !dbg !33
  %39 = propff <n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), %38, !dbg !33
  %has.ee = test any false <n x 2 x i1> %39, !dbg !33
  %cntp.ee.32 = call i64 @llvm.ctvpop.nxv2i1(<n x 2 x i1> %39), !dbg !33
  %ee.iter = add i64 %index.lcssa, %cntp.ee.32, !dbg !33
  %ee.within.bounds = icmp slt i64 %ee.iter, %2, !dbg !33
  %40 = and i1 %has.ee, %ee.within.bounds, !dbg !33
  %41 = trunc i64 %cntp.ee.32 to i32, !dbg !33
  %42 = insertelement <n x 2 x i1> zeroinitializer, i1 true, i32 %41, !dbg !33
  %ee.lane.merge = select <n x 2 x i1> %42, <n x 2 x double> %.lcssa39, <n x 2 x double> %.lcssa40, !dbg !33
  %rdx.ee.checked = select i1 %40, <n x 2 x double> %ee.lane.merge, <n x 2 x double> %.lcssa40
  %43 = call double @llvm.aarch64.sve.faddv.f64.nxv2i1.nxv2f64(<n x 2 x i1> shufflevector (<n x 2 x i1> insertelement (<n x 2 x i1> undef, i1 true, i32 0), <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer), <n x 2 x double> %rdx.ee.checked), !dbg !34
  br label %for.cond.for.end_crit_edge

for.body:                                         ; preds = %for.body.preheader, %if.end
  %indvars.iv = phi i64 [ %indvars.iv.next, %if.end ], [ 0, %for.body.preheader ], !dbg !41
  %sub819 = phi double [ %sub8, %if.end ], [ %x.promoted, %for.body.preheader ], !dbg !41
  %arrayidx = getelementptr inbounds double, double* %q, i64 %indvars.iv, !dbg !41
  %44 = load double, double* %arrayidx, align 8, !dbg !41, !tbaa !36
  %add = fadd fast double %sub819, %44, !dbg !47
  %arrayidx3 = getelementptr inbounds i32, i32* %d, i64 %indvars.iv, !dbg !42
  %45 = load i32, i32* %arrayidx3, align 4, !dbg !42, !tbaa !44
  %cmp4 = icmp slt i32 %45, %UBound, !dbg !46
  br i1 %cmp4, label %for.body.for.end_crit_edge, label %if.end, !dbg !51

if.end:                                           ; preds = %for.body
  %46 = getelementptr double, double* %1, i64 %indvars.iv, !dbg !40
  %47 = load double, double* %46, align 8, !dbg !40, !tbaa !36
  %sub8 = fsub fast double %add, %47, !dbg !34
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !33
  %cmp = icmp slt i64 %indvars.iv.next, %0, !dbg !29
  br i1 %cmp, label %for.body, label %for.cond.for.end_crit_edge.loopexit, !dbg !33, !llvm.loop !52

for.body.for.end_crit_edge:                       ; preds = %for.body
  %add.lcssa = phi double [ %add, %for.body ]
  store double %add.lcssa, double* %x, align 8, !dbg !34, !tbaa !36
  br label %for.end, !dbg !51

for.cond.for.end_crit_edge.loopexit:              ; preds = %if.end
  %sub8.lcssa38 = phi double [ %sub8, %if.end ]
  br label %for.cond.for.end_crit_edge, !dbg !34

for.cond.for.end_crit_edge:                       ; preds = %for.cond.for.end_crit_edge.loopexit, %reduction.check
  %sub8.lcssa = phi double [ %43, %reduction.check ], [ %sub8.lcssa38, %for.cond.for.end_crit_edge.loopexit ]
  store double %sub8.lcssa, double* %x, align 8, !dbg !34, !tbaa !36
  br label %for.end, !dbg !33

for.end:                                          ; preds = %for.cond.for.end_crit_edge, %for.body.for.end_crit_edge, %entry
  ret void, !dbg !53
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

; Function Attrs: argmemonly nounwind readonly
declare { <n x 2 x i32>, <n x 2 x i1> } @llvm.masked.load.ff.nxv2i32(<n x 2 x i32>*, i32, <n x 2 x i1>, <n x 2 x i32>) #2

; Function Attrs: nounwind readnone
declare i64 @llvm.ctvpop.nxv2i1(<n x 2 x i1>) #1

; Function Attrs: argmemonly nounwind readonly
declare { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.load.ff.nxv2f64(<n x 2 x double>*, i32, <n x 2 x i1>, <n x 2 x double>) #2

; Function Attrs: nounwind readnone
declare double @llvm.aarch64.sve.faddv.f64.nxv2i1.nxv2f64(<n x 2 x i1>, <n x 2 x double>) #1

attributes #0 = { norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { argmemonly nounwind readonly }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!19, !20}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 3.8.0", isOptimized: true, runtimeVersion: 0, emissionKind: 1, enums: !2, subprograms: !3)
!1 = !DIFile(filename: "../sample.c", directory: "/home/frapet01/projects/organic/build")
!2 = !{}
!3 = !{!4}
!4 = distinct !DISubprogram(name: "mcRandom", scope: !1, file: !1, line: 3, type: !5, isLocal: false, isDefinition: true, scopeLine: 4, flags: DIFlagPrototyped, isOptimized: true, variables: !13)
!5 = !DISubroutineType(types: !6)
!6 = !{null, !7, !9, !12, !11}
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64, align: 64)
!8 = !DIBasicType(name: "double", size: 64, align: 64, encoding: DW_ATE_float)
!9 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !10)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64, align: 64)
!11 = !DIBasicType(name: "int", size: 32, align: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !7)
!13 = !{!14, !15, !16, !17, !18}
!14 = !DILocalVariable(name: "x", arg: 1, scope: !4, file: !1, line: 3, type: !7)
!15 = !DILocalVariable(name: "d", arg: 2, scope: !4, file: !1, line: 3, type: !9)
!16 = !DILocalVariable(name: "q", arg: 3, scope: !4, file: !1, line: 4, type: !12)
!17 = !DILocalVariable(name: "UBound", arg: 4, scope: !4, file: !1, line: 4, type: !11)
!18 = !DILocalVariable(name: "j", scope: !4, file: !1, line: 5, type: !11)
!19 = !{i32 2, !"Dwarf Version", i32 4}
!20 = !{i32 2, !"Debug Info Version", i32 3}
!22 = !DIExpression()
!23 = !DILocation(line: 3, column: 23, scope: !4)
!24 = !DILocation(line: 3, column: 41, scope: !25)
!25 = !DILexicalBlockFile(scope: !4, file: !1, discriminator: 1)
!26 = !DILocation(line: 4, column: 35, scope: !4)
!27 = !DILocation(line: 4, column: 43, scope: !25)
!28 = !DILocation(line: 5, column: 7, scope: !25)
!29 = !DILocation(line: 6, column: 17, scope: !30)
!30 = !DILexicalBlockFile(scope: !31, file: !1, discriminator: 1)
!31 = distinct !DILexicalBlock(scope: !32, file: !1, line: 6, column: 3)
!32 = distinct !DILexicalBlock(scope: !4, file: !1, line: 6, column: 3)
!33 = !DILocation(line: 6, column: 3, scope: !30)
!34 = !DILocation(line: 12, column: 12, scope: !35)
!35 = distinct !DILexicalBlock(scope: !31, file: !1, line: 6, column: 32)
!36 = !{!37, !37, i64 0}
!37 = !{!"double", !38, i64 0}
!38 = !{!"omnipotent char", !39, i64 0}
!39 = !{!"Simple C/C++ TBAA"}
!40 = !DILocation(line: 12, column: 15, scope: !35)
!41 = !DILocation(line: 7, column: 13, scope: !35)
!42 = !DILocation(line: 9, column: 9, scope: !43)
!43 = distinct !DILexicalBlock(scope: !35, file: !1, line: 9, column: 9)
!44 = !{!45, !45, i64 0}
!45 = !{!"int", !38, i64 0}
!46 = !DILocation(line: 9, column: 14, scope: !43)
!47 = !DILocation(line: 7, column: 10, scope: !35)
!48 = distinct !{!48, !49, !50}
!49 = !{!"llvm.loop.vectorize.width", i32 1}
!50 = !{!"llvm.loop.interleave.count", i32 1}
!51 = !DILocation(line: 9, column: 9, scope: !35)
!52 = distinct !{!52, !49, !50}
!53 = !DILocation(line: 15, column: 1, scope: !4)
