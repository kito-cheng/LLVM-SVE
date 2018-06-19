; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 16 x i8> @ashr_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: ashr_b:
; CHECK:       ptrue [[PG:p[0-9]+]].b
; CHECK-NEXT:  asr z0.b, [[PG]]/m, z0.b, z1.b
; CHECK-NEXT:  ret
  %res = ashr <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @ashr_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: ashr_h:
; CHECK:       ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT:  asr z0.h, [[PG]]/m, z0.h, z1.h
; CHECK-NEXT:  ret
  %res = ashr <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @ashr_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: ashr_s:
; CHECK:       ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT:  asr z0.s, [[PG]]/m, z0.s, z1.s
; CHECK-NEXT:  ret
  %res = ashr <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @ashr_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: ashr_d:
; CHECK:       ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT:  asr z0.d, [[PG]]/m, z0.d, z1.d
; CHECK-NEXT:  ret
  %res = ashr <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 16 x i8> @ashr_cpy(<n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> *%ptr) {
; CHECK-LABEL: ashr_cpy:
; CHECK:       ptrue [[PG:p[0-9]+]].b
; CHECK:       asrr z1.b, [[PG]]/m, z1.b, z0.b
; CHECK-NEXT:  st1b {z0.b},
; CHECK-NEXT:  mov z0.d, z1.d
; CHECK-NEXT:  ret
  %res = ashr <n x 16 x i8> %a, %b
  ; keep the original data live
  store volatile <n x 16 x i8> %a, <n x 16 x i8> *%ptr
  ret <n x 16 x i8> %res
}

define <n x 16 x i8> @lshr_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: lshr_b:
; CHECK:      ptrue [[PG:p[0-9]+]].b
; CHECK-NEXT: lsr z0.b, [[PG]]/m, z0.b, z1.b
; CHECK-NEXT: ret
  %res = lshr <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @lshr_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: lshr_h:
; CHECK:      ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: lsr z0.h, [[PG]]/m, z0.h, z1.h
; CHECK-NEXT: ret
  %res = lshr <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @lshr_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: lshr_s:
; CHECK:      ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: lsr z0.s, [[PG]]/m, z0.s, z1.s
; CHECK-NEXT: ret
  %res = lshr <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @lshr_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: lshr_d:
; CHECK:      ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: lsr z0.d, [[PG]]/m, z0.d, z1.d
; CHECK-NEXT: ret
  %res = lshr <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 16 x i8> @lshr_cpy(<n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> *%ptr) {
; CHECK-LABEL: lshr_cpy:
; CHECK:       ptrue [[PG:p[0-9]+]].b
; CHECK:       lsrr z1.b, [[PG]]/m, z1.b, z0.b
; CHECK-NEXT:  st1b {z0.b},
; CHECK-NEXT:  mov z0.d, z1.d
; CHECK-NEXT:  ret
  %res = lshr <n x 16 x i8> %a, %b
  ; keep the original data live
  store volatile <n x 16 x i8> %a, <n x 16 x i8> *%ptr
  ret <n x 16 x i8> %res
}

define <n x 16 x i8> @shl_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: shl_b:
; CHECK:      ptrue [[PG:p[0-9]+]].b
; CHECK-NEXT: lsl z0.b, [[PG]]/m, z0.b, z1.b
; CHECK-NEXT: ret
  %res = shl <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @shl_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: shl_h:
; CHECK:      ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: lsl z0.h, [[PG]]/m, z0.h, z1.h
; CHECK-NEXT: ret
  %res = shl <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @shl_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: shl_s:
; CHECK:      ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: lsl z0.s, [[PG]]/m, z0.s, z1.s
; CHECK-NEXT: ret
  %res = shl <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @shl_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: shl_d:
; CHECK:      ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: lsl z0.d, [[PG]]/m, z0.d, z1.d
; CHECK-NEXT: ret
  %res = shl <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 16 x i8> @shl_cpy(<n x 16 x i8> %a, <n x 16 x i8> %b, <n x 16 x i8> *%ptr) {
; CHECK-LABEL: shl_cpy:
; CHECK:       ptrue [[PG:p[0-9]+]].b
; CHECK:       lslr z1.b, [[PG]]/m, z1.b, z0.b
; CHECK-NEXT:  st1b {z0.b},
; CHECK-NEXT:  mov z0.d, z1.d
; CHECK-NEXT:  ret
  %res = shl <n x 16 x i8> %a, %b
  ; keep the original data live
  store volatile <n x 16 x i8> %a, <n x 16 x i8> *%ptr
  ret <n x 16 x i8> %res
}
