; RUN: %llc_dwarf %s -filetype=obj -o %t
; RUN: llvm-dwarfdump -debug-dump=info %t | FileCheck %s
; CHECK: DW_TAG_string_type [4]
; REQUIRES: default_triple

declare void @llvm.dbg.declare(metadata, metadata, metadata)
define void @mysub_(i64* %a, i64* %ab, i64* %b, i32 %.U0003.arg, i32 %.U0004.arg, i32 %.U0005.arg) #0 !dbg !26 {
       call void @llvm.dbg.declare (metadata i64* %a, metadata !30, metadata !31), !dbg !29
       ret void, !dbg !38
}
!llvm.module.flags = !{ !1, !2 }
!llvm.dbg.cu = !{ !10 }
!1 = !{ i32 2, !"Dwarf Version", i32 2 }
!2 = !{ i32 1, !"Debug Info Version", i32 3 }
!3 = !DIFile(filename: "dwarf-string-type.f90", directory: "/")
!5 = !{  }
!7 = !{ !26 }
!10 = distinct !DICompileUnit(file: !3, language: DW_LANG_Fortran90, producer: "flang", enums: !5, retainedTypes: !5, globals: !5, emissionKind: FullDebug, imports: !5)
!21 = !DIBasicType(tag: DW_TAG_string_type, name: "character", size: 8, align: 8, encoding: DW_ATE_signed)
!23 = !{ null, !21 }
!24 = !DISubroutineType(types: !23)
!26 = distinct !DISubprogram(file: !3, scope: !10, name: "mysub", line: 10, type: !24, isDefinition: true, unit: !10, variables: !5, scopeLine: 10)
!27 = !DILocation(scope: !26)
!28 = !DILexicalBlock(file: !3, scope: !26, line: 10, column: 1)
!29 = !DILocation(scope: !28)
!30 = !DILocalVariable(scope: !26, name: "a", arg: 1, file: !3, type: !21)
!31 = !DIExpression()
!38 = !DILocation(line: 13, column: 1, scope: !28)
