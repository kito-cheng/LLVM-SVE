; RUN: llc < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-generic-linux"

declare { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>*, i32, <n x 2 x i1>, <n x 2 x double>)

define <n x 2 x i1> @foo1(<n x 2 x double> *%A, <n x 2 x double> *%B, <n x 2 x double> *%C, <n x 2 x i1> %Pg) #0 {
; CHECK-LABEL: @foo1
; CHECK: setffr
; CHECK-NEXT: ldff
; CHECK-NEXT: ldff
; CHECK-NEXT: ldff
; CHECK-NEXT: rdffr
; CHECK-NEXT: ret
  %vA_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %A, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vA_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vA_load, 1
  %vB_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %B, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vB_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vB_load, 1
  %vC_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %C, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vC_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vC_load, 1
  %tmp = and <n x 2 x i1> %vB_FFR, %vA_FFR
  %newPg = and <n x 2 x i1> %tmp, %vC_FFR
  ret <n x 2 x i1> %newPg
}

define <n x 2 x i1> @foo1_2(<n x 2 x double> *%A, <n x 2 x double> *%B,  <n x 2 x i1> %Pg) #0 {
; CHECK-LABEL: @foo1_2
; CHECK: setffr
; CHECK-NEXT: ldff
; CHECK-NEXT: ldff
; CHECK-NEXT: rdffr
; CHECK-NEXT: ret
  %vA_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %A, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vA_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vA_load, 1
  %vB_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %B, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vB_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vB_load, 1
  %tmp = and <n x 2 x i1> %vB_FFR, %vA_FFR
  ret <n x 2 x i1> %tmp
}

define <n x 2 x i1> @foo1_4(<n x 2 x double> *%A, <n x 2 x double> *%B, <n x 2 x double> *%C, <n x 2 x double> *%D, <n x 2 x i1> %Pg) #0 {
; CHECK-LABEL: @foo1_4
; CHECK: setffr
; CHECK-NEXT: ldff
; CHECK-NEXT: ldff
; CHECK-NEXT: ldff
; CHECK-NEXT: ldff
; CHECK-NEXT: rdffr
; CHECK-NEXT: ret
  %vA_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %A, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vA_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vA_load, 1
  %vB_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %B, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vB_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vB_load, 1
  %vC_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %C, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vC_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vC_load, 1
  %vD_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %D, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vD_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vD_load, 1
  %tmp = and <n x 2 x i1> %vB_FFR, %vA_FFR
  %tmp2 = and <n x 2 x i1> %tmp, %vC_FFR
  %newPg =  and <n x 2 x i1> %tmp2, %vD_FFR
  ret <n x 2 x i1> %newPg
}

define <n x 2 x i1> @foo1_3(<n x 2 x double> *%A, <n x 2 x double> *%B, <n x 2 x double> *%C, <n x 2 x i1> %Pg, <n x 2 x i1> %Pg2) #0 {
; CHECK-LABEL: @foo1_3
; CHECK: setffr
; CHECK-NEXT: ldff
; CHECK: rdffr
; CHECK: setffr
; CHECK-NEXT: ldff
; CHECK: rdffr
; CHECK: and
; CHECK: ret
  %vA_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %A, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vA_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vA_load, 1
  %vB_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %B, i32 8, <n x 2 x i1> %Pg2, <n x 2 x double> undef)
  %vB_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vB_load, 1
  %tmp = and <n x 2 x i1> %vB_FFR, %vA_FFR
  ret <n x 2 x i1> %tmp
}

; In this tests the FFR of the fist load is used later, so we cannot
; remove any of teh setffr and rdffr planted for teh speculative
; loads.
define <n x 2 x i1> @multiple_use_of_rdffr(<n x 2 x double> *%A, <n x 2 x double> *%B, <n x 2 x double> *%C, <n x 2 x i1> %Pg) #0 {
; CHECK-LABEL: @multiple_use_of_rdffr
; CHECK: setffr
; CHECK: ldff
; CHECK: rdffr
; CHECK: setffr
; CHECK: ldff
; CHECK: rdffr
; CHECK: setffr
; CHECK: ldff
; CHECK: ret
  %vA_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %A, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vA_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vA_load, 1
  %vB_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %B, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vB_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vB_load, 1
  %vC_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %C, i32 8, <n x 2 x i1> %vA_FFR, <n x 2 x double> undef)
  %vC = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vC_load, 0
  store <n x 2 x double> %vC, <n x 2 x double> * %A
  %tmp = and <n x 2 x i1> %vB_FFR, %vA_FFR
  ret <n x 2 x i1> %tmp
}

; This test makes sure that setffr/rdffr optimization doesn't break
; the original chain of loads and store. It does so by making sure
; that the masked store happens before the setffr/ldff/rdff planted by
; the 3rd store.
declare void @llvm.masked.store.nxv2f64(<n x 2 x double>, <n x 2 x double>*, i32, <n x 2 x i1>)
define <n x 2 x i1> @foo_preserve_chain(<n x 2 x double> *%A, <n x 2 x double> *%B, <n x
2 x double> *%C, <n x 2 x i1> %Pg) #0 {
; CHECK-LABEL: @foo_preserve_chain
; CHECK: setffr
; CHECK: ldff
; CHECK: ldff
; CHECK: rdffr
; CHECK: setffr
; CHECK: ldff
; CHECK: rdffr
; CHECK: and
; CHECK: ret
  %vA_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %A, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vA_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vA_load, 1
  %vB_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %B, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)

  %vB = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vB_load, 0 call void @llvm.masked.store.nxv2f64(<n x 2 x double> %vB, <n x 2 x double>* %C, i32 8, <n x 2 x i1> %Pg)

  %vB_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vB_load, 1
  %vC_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %C, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vC_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vC_load, 1
  %tmp = and <n x 2 x i1> %vB_FFR, %vA_FFR
  %newPg = and <n x 2 x i1> %tmp, %vC_FFR
  ret <n x 2 x i1> %newPg
}

attributes #0 = { norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+sve" "unsafe-fp-math"="true" "use-soft-float"="false" }
