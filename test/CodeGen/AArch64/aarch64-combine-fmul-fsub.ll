; RUN: llc < %s -mtriple=aarch64-linux-gnu -O3 -fp-contract=fast | FileCheck %s

; Check that (fsub (fmul a b) c) -> (fmla a b (fneg c)) works as expected with <2 x float> types.
define <2 x float> @f1_2s(<2 x float>, <2 x float>, <2 x float>) local_unnamed_addr {
; CHECK-LABEL: %entry
; CHECK: fneg [[VR:v[0-9].2s]], v2.2s
; CHECK: fmla [[VR]], v0.2s, v1.2s
; CHECK: ret
  entry:
    %3 = fmul fast <2 x float> %0, %1
    %4 = fsub fast <2 x float> %3, %2
    ret <2 x float> %4
}

; Check that (fsub (fmul a b) c) -> (fmla a b (fneg c)) works as expected with <4 x float> types.
define <4 x float> @f1_4s(<4 x float>, <4 x float>, <4 x float>) local_unnamed_addr {
; CHECK-LABEL: %entry
; CHECK: fneg [[VR:v[0-9].4s]], v2.4s
; CHECK: fmla [[VR]], v0.4s, v1.4s
; CHECK: ret
  entry:
    %3 = fmul fast <4 x float> %0, %1
    %4 = fsub fast <4 x float> %3, %2
    ret <4 x float> %4
}

; Check that (fsub (fmul a b) c) -> (fmla a b (fneg c)) works as expected with <2 x double> types.
define <2 x double> @f1_2d(<2 x double>, <2 x double>, <2 x double>) local_unnamed_addr {
; CHECK-LABEL: %entry
; CHECK: fneg [[VR:v[0-9].2d]], v2.2d
; CHECK: fmla [[VR]], v0.2d, v1.2d
; CHECK: ret
  entry:
    %3 = fmul fast <2 x double> %0, %1
    %4 = fsub fast <2 x double> %3, %2
    ret <2 x double> %4
}
