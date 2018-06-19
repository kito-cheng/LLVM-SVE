; RUN: llc -march=aarch64 -mattr=+sve -fp-contract=fast < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-none--elf"

define <n x 4 x float> @use_fma(<n x 4 x float> %a, <n x 4 x float> %b, <n x 4 x float> %c) {
; CHECK: fmad
  %mul = fmul fast <n x 4 x float> %a, %b
  %res = fadd fast <n x 4 x float> %mul, %c
  ret <n x 4 x float> %res
}

