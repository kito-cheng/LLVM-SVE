; RUN: llc -mtriple=aarch64-none-linux-gnu -mattr=+neon < %s | FileCheck %s

; generated from
; __fp16 test(__fp16 a1, __fp16 a2) {
;    __fp16 res0;
;    __asm__("sqrshl %h[__res], %h[__Pg], %h[__Zn]"
;             : [__res] "=w" (res0)
;             : [__Pg] "w" (a1), [__Zn] "w" (a1)
;             :
;             );
;    return res0;
;}

; Function Attrs: nounwind readnone
define half @test(half %a1, half %a2) #0 {
entry:
  ;CHECK: sqrshl {{h[0-9]+}}, {{h[0-9]+}}, {{h[0-9]+}}
  %0 = tail call half asm "sqrshl ${0:h}, ${1:h}, ${2:h}", "=w,w,w"(half %a1, half %a1) #1
  ret half %0
}
