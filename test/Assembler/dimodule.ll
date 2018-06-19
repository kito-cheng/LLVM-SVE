; RUN: llvm-as < %s | llvm-dis | llvm-as | llvm-dis | FileCheck %s
; RUN: verify-uselistorder %s

; CHECK: !named = !{!0, !1, !2, !1, !3, !4}
!named = !{!0, !1, !2, !3, !4, !6}

!0 = distinct !{}

; CHECK: !1 = !DIModule(scope: !0, name: "Module")
!1 = !DIModule(scope: !0, name: "Module")

; CHECK: !2 = !DIModule(scope: !0, name: "Module", configMacros: "-DNDEBUG", includePath: "/usr/include", isysroot: "/")
!2 = !DIModule(scope: !0, name: "Module", configMacros: "-DNDEBUG", includePath: "/usr/include", isysroot: "/")

!3 = !DIModule(scope: !0, name: "Module", configMacros: "")

; CHECK: !3 = !DIModule(scope: !0, name: "Module", line: 3)
!4 = !DIModule(scope: !0, name: "Module", line: 3)

!5 = !DIFile(filename: "file.cpp", directory: "/path/to/dir")

; CHECK: !4 = !DIModule(scope: !0, name: "Module", file: !5, line: 3)
!6 = !DIModule(scope: !0, name: "Module", file: !5, line: 3)
