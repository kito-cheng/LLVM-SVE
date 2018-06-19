; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 16 x i8>* @gep_base_idx32(<n x 16 x i8> *%base, i32 %index) {
; CHECK-LABEL: gep_base_idx32:
; CHECK: sxtw x[[IDX:[0-9]+]], w1
; CHECK: rdvl x[[NUM_BYTES:[0-9]+]], #1
; CHECK: madd x0, x[[NUM_BYTES]], x[[IDX]], x0
; CHECK-NEXT: ret
  %res = getelementptr <n x 16 x i8>, <n x 16 x i8>* %base, i32 %index
  ret <n x 16 x i8>* %res
}

define <n x 16 x i8>* @gep_base_idx64(<n x 16 x i8> *%base, i64 %index) {
; CHECK-LABEL: gep_base_idx64:
; CHECK: rdvl x[[NUM_BYTES:[0-9]+]], #1
; CHECK-NEXT: madd x0, x[[NUM_BYTES]], x1, x0
; CHECK-NEXT: ret
  %res = getelementptr <n x 16 x i8>, <n x 16 x i8>* %base, i64 %index
  ret <n x 16 x i8>* %res
}

define <n x 16 x i8>* @gep_addvl(<n x 16 x i8> *%base) {
; CHECK-LABEL: gep_addvl:
; CHECK: addvl x0, x0, #31
; CHECK-NEXT: ret
  %res = getelementptr <n x 16 x i8>, <n x 16 x i8>* %base, i32 31
  ret <n x 16 x i8>* %res
}

define <n x 16 x i8>* @gep_addvl_neg(<n x 16 x i8> *%base) {
; CHECK-LABEL: gep_addvl_neg:
; CHECK: addvl x0, x0, #-32
; CHECK-NEXT: ret
  %res = getelementptr <n x 16 x i8>, <n x 16 x i8>* %base, i32 -32
  ret <n x 16 x i8>* %res
}

define <n x 8 x i8>* @gep_inch(<n x 8 x i8> *%base) {
; CHECK-LABEL: gep_inch:
; CHECK: inch x0
; CHECK-NEXT: ret
  %res = getelementptr <n x 8 x i8>, <n x 8 x i8>* %base, i32 1
  ret <n x 8 x i8>* %res
}

define <n x 8 x i8>* @gep_dech(<n x 8 x i8> *%base) {
; CHECK-LABEL: gep_dech:
; CHECK: dech x0
; CHECK-NEXT: ret
  %res = getelementptr <n x 8 x i8>, <n x 8 x i8>* %base, i32 -1
  ret <n x 8 x i8>* %res
}

define <n x 4 x i8>* @gep_incw(<n x 4 x i8> *%base) {
; CHECK-LABEL: gep_incw:
; CHECK: incw x0
; CHECK-NEXT: ret
  %res = getelementptr <n x 4 x i8>, <n x 4 x i8>* %base, i32 1
  ret <n x 4 x i8>* %res
}

define <n x 4 x i8>* @gep_decw(<n x 4 x i8> *%base) {
; CHECK-LABEL: gep_decw:
; CHECK: decw x0
; CHECK-NEXT: ret
  %res = getelementptr <n x 4 x i8>, <n x 4 x i8>* %base, i32 -1
  ret <n x 4 x i8>* %res
}

define <n x 2 x i8>* @gep_incd(<n x 2 x i8> *%base) {
; CHECK-LABEL: gep_incd:
; CHECK: incd x0
; CHECK-NEXT: ret
  %res = getelementptr <n x 2 x i8>, <n x 2 x i8>* %base, i32 1
  ret <n x 2 x i8>* %res
}

define <n x 2 x i8>* @gep_decd(<n x 2 x i8> *%base) {
; CHECK-LABEL: gep_decd:
; CHECK: decd x0
; CHECK-NEXT: ret
  %res = getelementptr <n x 2 x i8>, <n x 2 x i8>* %base, i32 -1
  ret <n x 2 x i8>* %res
}

define <n x 2 x i8*> @gep_gather_scalar_index(<n x 2 x i8*> %ptrs, i64 %idx) {
; CHECK-LABEL: gep_gather_scalar_index:
; CHECK: mov z[[OFFSET:[0-9]+]].d, x0
; CHECK-NEXT: add z0.d, z0.d, z[[OFFSET]].d
; CHECK-NEXT: ret
  %res = getelementptr i8, <n x 2 x i8*> %ptrs, i64 %idx
  ret <n x 2 x i8*> %res
}

define i64 @ptrdiff_rdvl(<n x 16 x i8> *%base) {
; CHECK-LABEL: ptrdiff_rdvl:
; CHECK: rdvl x0
; CHECK-NEXT: ret
  %base2 = getelementptr <n x 16 x i8>, <n x 16 x i8>* %base, i32 1
  %a = ptrtoint <n x 16 x i8> *%base to i64
  %b = ptrtoint <n x 16 x i8> *%base2 to i64
  %res = sub i64 %b, %a
  ret i64 %res
}

define i64 @ptrdiff_rdvl_neg(<n x 16 x i8> *%base) {
; CHECK-LABEL: ptrdiff_rdvl_neg:
; CHECK: rdvl x0, #-1
; CHECK-NEXT: ret
  %base2 = getelementptr <n x 16 x i8>, <n x 16 x i8>* %base, i32 -1
  %a = ptrtoint <n x 16 x i8> *%base to i64
  %b = ptrtoint <n x 16 x i8> *%base2 to i64
  %res = sub i64 %b, %a
  ret i64 %res
}

define i64 @ptrdiff_cnth(<n x 8 x i8> *%base) {
; CHECK-LABEL: ptrdiff_cnth:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %base2 = getelementptr <n x 8 x i8>, <n x 8 x i8>* %base, i32 1
  %a = ptrtoint <n x 8 x i8> *%base to i64
  %b = ptrtoint <n x 8 x i8> *%base2 to i64
  %res = sub i64 %b, %a
  ret i64 %res
}

define i64 @ptrdiff_cnth_neg(<n x 8 x i8> *%base) {
; CHECK-LABEL: ptrdiff_cnth_neg:
; CHECK: cnth [[ABS_DIFF:x[0-9]+]]
; CHECK-NEXT: neg x0, [[ABS_DIFF]]
; CHECK-NEXT: ret
  %base2 = getelementptr <n x 8 x i8>, <n x 8 x i8>* %base, i32 -1
  %a = ptrtoint <n x 8 x i8> *%base to i64
  %b = ptrtoint <n x 8 x i8> *%base2 to i64
  %res = sub i64 %b, %a
  ret i64 %res
}

define i64 @ptrdiff_cntw(<n x 4 x i8> *%base) {
; CHECK-LABEL: ptrdiff_cntw:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %base2 = getelementptr <n x 4 x i8>, <n x 4 x i8>* %base, i32 1
  %a = ptrtoint <n x 4 x i8> *%base to i64
  %b = ptrtoint <n x 4 x i8> *%base2 to i64
  %res = sub i64 %b, %a
  ret i64 %res
}

define i64 @ptrdiff_cntw_neg(<n x 4 x i8> *%base) {
; CHECK-LABEL: ptrdiff_cntw_neg:
; CHECK: cntw [[ABS_DIFF:x[0-9]+]]
; CHECK-NEXT: neg x0, [[ABS_DIFF]]
; CHECK-NEXT: ret
  %base2 = getelementptr <n x 4 x i8>, <n x 4 x i8>* %base, i32 -1
  %a = ptrtoint <n x 4 x i8> *%base to i64
  %b = ptrtoint <n x 4 x i8> *%base2 to i64
  %res = sub i64 %b, %a
  ret i64 %res
}

define i64 @ptrdiff_cntd(<n x 2 x i8> *%base) {
; CHECK-LABEL: ptrdiff_cntd:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %base2 = getelementptr <n x 2 x i8>, <n x 2 x i8>* %base, i32 1
  %a = ptrtoint <n x 2 x i8> *%base to i64
  %b = ptrtoint <n x 2 x i8> *%base2 to i64
  %res = sub i64 %b, %a
  ret i64 %res
}

define i64 @ptrdiff_cntd_neg(<n x 2 x i8> *%base) {
; CHECK-LABEL: ptrdiff_cntd_neg:
; CHECK: cntd [[ABS_DIFF:x[0-9]+]]
; CHECK-NEXT: neg x0, [[ABS_DIFF]]
; CHECK-NEXT: ret
  %base2 = getelementptr <n x 2 x i8>, <n x 2 x i8>* %base, i32 -1
  %a = ptrtoint <n x 2 x i8> *%base to i64
  %b = ptrtoint <n x 2 x i8> *%base2 to i64
  %res = sub i64 %b, %a
  ret i64 %res
}
