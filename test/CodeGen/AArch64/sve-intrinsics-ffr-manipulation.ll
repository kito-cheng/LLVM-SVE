; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; RDFFR
;

define <n x 16 x i1> @rdffr() {
; CHECK-LABEL: rdffr:
; CHECK: rdffr p0.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.rdffr()
  ret <n x 16 x i1> %out
}

;
; SETFFR
;

define void @set_ffr() {
; CHECK-LABEL: set_ffr:
; CHECK: setffr
; CHECK-NEXT: ret
  call void @llvm.aarch64.sve.setffr()
  ret void
}

;
; WRFFR
;

define void @wrffr(<n x 16 x i1> %a) {
; CHECK-LABEL: wrffr:
; CHECK: wrffr p0.b
; CHECK-NEXT: ret
  call void @llvm.aarch64.sve.wrffr(<n x 16 x i1> %a)
  ret void
}

declare <n x 16 x i1> @llvm.aarch64.sve.rdffr()
declare void @llvm.aarch64.sve.setffr()
declare void @llvm.aarch64.sve.wrffr(<n x 16 x i1>)
