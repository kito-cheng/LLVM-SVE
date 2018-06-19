; RUN: opt < %s -loop-simplify -lcssa -loop-speculative-bounds-check -verify-loop-info -verify-dom-info -S | FileCheck %s
; ModuleID = 'GlobalLoadCompare.c'
source_filename = "GlobalLoadCompare.c"
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-none--elf"

@AGlobalVar = common global i32 0, align 4

; Function Attrs: norecurse nounwind
define void @SomeLoopFunc(i32* nocapture %Array1, i32* nocapture readonly %Array2) #0 !dbg !6 {
; CHECK-LABEL: for.body.speculative.bounds.check
; CHECK-LABEL: for.body.specbounds.orig
entry:
  %0 = load i32, i32* @AGlobalVar, align 4, !dbg !8, !tbaa !10
  %cmp7 = icmp sgt i32 %0, 0, !dbg !14
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup, !dbg !15

for.body.preheader:                               ; preds = %entry
  br label %for.body, !dbg !16

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup, !dbg !17

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void, !dbg !17

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, i32* %Array2, i64 %indvars.iv, !dbg !16
  %1 = load i32, i32* %arrayidx, align 4, !dbg !16, !tbaa !10
  %arrayidx2 = getelementptr inbounds i32, i32* %Array1, i64 %indvars.iv, !dbg !18
  %2 = load i32, i32* %arrayidx2, align 4, !tbaa !10
  %add = add nsw i32 %2, %1
  store i32 %add, i32* %arrayidx2, align 4, !tbaa !10
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !15
  %3 = load i32, i32* @AGlobalVar, align 4, !dbg !8, !tbaa !10
  %4 = sext i32 %3 to i64, !dbg !14
  %cmp = icmp slt i64 %indvars.iv.next, %4, !dbg !14
  br i1 %cmp, label %for.body, label %for.cond.cleanup.loopexit, !dbg !15
}

attributes #0 = { norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind readonly }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 3.9.0", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !2)
!1 = !DIFile(filename: "GlobalLoadCompare.c", directory: "/")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 3.9.0"}
!6 = distinct !DISubprogram(name: "SomeLoopFunc", scope: !1, file: !1, line: 9, type: !7, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: true, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !2)
!8 = !DILocation(line: 10, column: 23, scope: !9)
!9 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 1)
!10 = !{!11, !11, i64 0}
!11 = !{!"int", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !DILocation(line: 10, column: 21, scope: !9)
!15 = !DILocation(line: 10, column: 3, scope: !9)
!16 = !DILocation(line: 11, column: 18, scope: !6)
!17 = !DILocation(line: 11, column: 5, scope: !6)
!18 = !DILocation(line: 11, column: 15, scope: !6)
!19 = !{!20}
!20 = distinct !{!20, !21}
!21 = distinct !{!21, !"LVerDomain"}
!22 = !{!23}
!23 = distinct !{!23, !21}
!24 = !{!20, !25}
!25 = distinct !{!25, !21}
!26 = distinct !{!26, !27, !28}
!27 = !{!"llvm.loop.vectorize.width", i32 1}
!28 = !{!"llvm.loop.interleave.count", i32 1}
!29 = !DILocation(line: 13, column: 3, scope: !6)
!30 = distinct !{!30, !27, !28}
