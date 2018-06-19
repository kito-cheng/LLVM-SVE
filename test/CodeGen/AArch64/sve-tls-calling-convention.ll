; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -relocation-model=pic -aarch64-elf-ldtls-generation=1 -verify-machineinstrs < %s | FileCheck %s

@general_dynamic_var = external thread_local global i32

; ensure we don't try to preserve any vector register
define i32 @test1() {
; CHECK-LABEL: test1:

  %val = load i32, i32* @general_dynamic_var
  ret i32 %val

; CHECK-NOT: stp d{{[0-9]+}}
; CHECK-NOT: str d{{[0-9]+}}
; CHECK-NOT: str p{{[0-9]+}}
; CHECK-NOT: str z{{[0-9]+}}
; CHECK: adrp x[[TLSDESC_HI:[0-9]+]], :tlsdesc:general_dynamic_var
; CHECK-NEXT: ldr [[CALLEE:x[0-9]+]], [x[[TLSDESC_HI]], :tlsdesc_lo12:general_dynamic_var]
; CHECK-NEXT: add x0, x[[TLSDESC_HI]], :tlsdesc_lo12:general_dynamic_var
; CHECK-NEXT: .tlsdesccall general_dynamic_var
; CHECK-NEXT: blr [[CALLEE]]

}

; ensure we enforce the SVE calling convention because that use by the
; tls's custom api will only preserve the bottom 128-bits of Z0-Z31

define i32 @test2(<n x 2 x i64> %a) {
; CHECK-LABEL: test2:

  %val = load i32, i32* @general_dynamic_var
  ret i32 %val

; CHECK: str z8, [sp
; CHECK-NEXT: str z9, [sp
; CHECK-NEXT: str z10, [sp
; CHECK-NEXT: str z11, [sp
; CHECK-NEXT: str z12, [sp
; CHECK-NEXT: str z13, [sp
; CHECK-NEXT: str z14, [sp
; CHECK-NEXT: str z15, [sp
; CHECK-NEXT: str z16, [sp
; CHECK-NEXT: str z17, [sp
; CHECK-NEXT: str z18, [sp
; CHECK-NEXT: str z19, [sp
; CHECK-NEXT: str z20, [sp
; CHECK-NEXT: str z21, [sp
; CHECK-NEXT: str z22, [sp
; CHECK-NEXT: str z23, [sp
; CHECK-NEXT: str z24, [sp
; CHECK-NEXT: str z25, [sp
; CHECK-NEXT: str z26, [sp
; CHECK-NEXT: str z27, [sp
; CHECK-NEXT: str z28, [sp
; CHECK-NEXT: str z29, [sp
; CHECK-NEXT: str z30, [sp
; CHECK-NEXT: str z31, [sp
; CHECK: str p4, [sp
; CHECK-NEXT: str p5, [sp
; CHECK-NEXT: str p6, [sp
; CHECK-NEXT: str p7, [sp
; CHECK-NEXT: str p8, [sp
; CHECK-NEXT: str p9, [sp
; CHECK-NEXT: str p10, [sp
; CHECK-NEXT: str p11, [sp
; CHECK-NEXT: str p12, [sp
; CHECK-NEXT: str p13, [sp
; CHECK-NEXT: str p14, [sp
; CHECK-NEXT: str p15, [sp
; CHECK: adrp x[[TLSDESC_HI:[0-9]+]], :tlsdesc:general_dynamic_var
; CHECK-NEXT: ldr [[CALLEE:x[0-9]+]], [x[[TLSDESC_HI]], :tlsdesc_lo12:general_dynamic_var]
; CHECK-NEXT: add x0, x[[TLSDESC_HI]], :tlsdesc_lo12:general_dynamic_var
; CHECK-NEXT: .tlsdesccall general_dynamic_var
; CHECK-NEXT: blr [[CALLEE]]
}

; ensure we preserve any live SVE state because that use by the
; tls's custom api will only preserve the bottom 128-bits of Z0-Z31

define i32 @test3(<n x 4 x i32>* %ptr) {
; CHECK-LABEL: test3:

  %a = load volatile <n x 4 x i32>, <n x 4 x i32>* %ptr
  %val = load volatile i32, i32* @general_dynamic_var

; CHECK-NOT: stp d{{[0-9]+}}
; CHECK-NOT: str d{{[0-9]+}}
; CHECK-NOT: str p{{[0-9]+}}
; CHECK: str z{{[0-9]+}}
; CHECK-NOT: stp d{{[0-9]+}}
; CHECK-NOT: str d{{[0-9]+}}
; CHECK-NOT: str p{{[0-9]+}}
; CHECK-NOT: str z{{[0-9]+}}
; CHECK: adrp x[[TLSDESC_HI:[0-9]+]], :tlsdesc:general_dynamic_var
; CHECK-NEXT: ldr [[CALLEE:x[0-9]+]], [x[[TLSDESC_HI]], :tlsdesc_lo12:general_dynamic_var]
; CHECK-NEXT: add x0, x[[TLSDESC_HI]], :tlsdesc_lo12:general_dynamic_var
; CHECK-NEXT: .tlsdesccall general_dynamic_var
; CHECK-NEXT: blr [[CALLEE]]

  %b = icmp eq <n x 4 x i32> %a, zeroinitializer
  %c = call i32 @llvm.aarch64.sve.lasta.nxv4i32(<n x 4 x i1> %b, <n x 4 x i32> %a)
  %add = add i32 %val, %c
  ret i32 %add
}

declare i32 @llvm.aarch64.sve.lasta.nxv4i32(<n x 4 x i1>, <n x 4 x i32>)

