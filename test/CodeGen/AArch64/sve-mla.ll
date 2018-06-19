; RUN: llc -O3 -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define void @mad_b(<n x 16 x i8>* %_a, <n x 16 x i8>* %_b,
                   <n x 16 x i8>* %_c) {
; CHECK-LABEL: mad_b:
; CHECK: mad {{z[0-9]+.b}},
       %a = load <n x 16 x i8>, <n x 16 x i8>* %_a
       %b = load <n x 16 x i8>, <n x 16 x i8>* %_b
       %c = load <n x 16 x i8>, <n x 16 x i8>* %_c
       %tmp1 = mul <n x 16 x i8> %a, %b
       %tmp2 = add <n x 16 x i8> %c, %tmp1
       store <n x 16 x i8> %tmp2, <n x 16 x i8>* %_a
       ret void
}

define void @mad_h(<n x 8 x i16>* %_a, <n x 8 x i16>* %_b,
                   <n x 8 x i16>* %_c) {
; CHECK-LABEL: mad_h:
; CHECK: mad {{z[0-9]+.h}},
       %a = load <n x 8 x i16>, <n x 8 x i16>* %_a
       %b = load <n x 8 x i16>, <n x 8 x i16>* %_b
       %c = load <n x 8 x i16>, <n x 8 x i16>* %_c
       %tmp1 = mul <n x 8 x i16> %a, %b
       %tmp2 = add <n x 8 x i16> %c, %tmp1
       store <n x 8 x i16> %tmp2, <n x 8 x i16>* %_a
       ret void
}

define void @mad_s(<n x 4 x i32>* %_a, <n x 4 x i32>* %_b,
                   <n x 4 x i32>* %_c) {
; CHECK-LABEL: mad_s:
; CHECK: mad {{z[0-9]+.s}},
       %a = load <n x 4 x i32>, <n x 4 x i32>* %_a
       %b = load <n x 4 x i32>, <n x 4 x i32>* %_b
       %c = load <n x 4 x i32>, <n x 4 x i32>* %_c
       %tmp1 = mul <n x 4 x i32> %a, %b
       %tmp2 = add <n x 4 x i32> %c, %tmp1
       store <n x 4 x i32> %tmp2, <n x 4 x i32>* %_a
       ret void
}

define void @mad_d(<n x 2 x i64>* %_a, <n x 2 x i64>* %_b,
                   <n x 2 x i64>* %_c) {
; CHECK-LABEL: mad_d:
; CHECK: mad {{z[0-9]+.d}},
       %a = load <n x 2 x i64>, <n x 2 x i64>* %_a
       %b = load <n x 2 x i64>, <n x 2 x i64>* %_b
       %c = load <n x 2 x i64>, <n x 2 x i64>* %_c
       %tmp1 = mul <n x 2 x i64> %a, %b
       %tmp2 = add <n x 2 x i64> %c, %tmp1
       store <n x 2 x i64> %tmp2, <n x 2 x i64>* %_a
       ret void
}

define void @msb_b(<n x 16 x i8>* %_a, <n x 16 x i8>* %_b,
                   <n x 16 x i8>* %_c) {
; CHECK-LABEL: msb_b:
; CHECK: msb {{z[0-9]+.b}},
       %a = load <n x 16 x i8>, <n x 16 x i8>* %_a
       %b = load <n x 16 x i8>, <n x 16 x i8>* %_b
       %c = load <n x 16 x i8>, <n x 16 x i8>* %_c
       %tmp1 = mul <n x 16 x i8> %a, %b
       %tmp2 = sub <n x 16 x i8> %c, %tmp1
       store <n x 16 x i8> %tmp2, <n x 16 x i8>* %_a
       ret void
}

define void @msb_h(<n x 8 x i16>* %_a, <n x 8 x i16>* %_b,
                   <n x 8 x i16>* %_c) {
; CHECK-LABEL: msb_h:
; CHECK: msb {{z[0-9]+.h}},
       %a = load <n x 8 x i16>, <n x 8 x i16>* %_a
       %b = load <n x 8 x i16>, <n x 8 x i16>* %_b
       %c = load <n x 8 x i16>, <n x 8 x i16>* %_c
       %tmp1 = mul <n x 8 x i16> %a, %b
       %tmp2 = sub <n x 8 x i16> %c, %tmp1
       store <n x 8 x i16> %tmp2, <n x 8 x i16>* %_a
       ret void
}

define void @msb_s(<n x 4 x i32>* %_a, <n x 4 x i32>* %_b,
                   <n x 4 x i32>* %_c) {
; CHECK-LABEL: msb_s:
; CHECK: msb {{z[0-9]+.s}},
       %a = load <n x 4 x i32>, <n x 4 x i32>* %_a
       %b = load <n x 4 x i32>, <n x 4 x i32>* %_b
       %c = load <n x 4 x i32>, <n x 4 x i32>* %_c
       %tmp1 = mul <n x 4 x i32> %a, %b
       %tmp2 = sub <n x 4 x i32> %c, %tmp1
       store <n x 4 x i32> %tmp2, <n x 4 x i32>* %_a
       ret void
}

define void @msb_d(<n x 2 x i64>* %_a, <n x 2 x i64>* %_b,
                   <n x 2 x i64>* %_c) {
; CHECK-LABEL: msb_d:
; CHECK: msb {{z[0-9]+.d}},
       %a = load <n x 2 x i64>, <n x 2 x i64>* %_a
       %b = load <n x 2 x i64>, <n x 2 x i64>* %_b
       %c = load <n x 2 x i64>, <n x 2 x i64>* %_c
       %tmp1 = mul <n x 2 x i64> %a, %b
       %tmp2 = sub <n x 2 x i64> %c, %tmp1
       store <n x 2 x i64> %tmp2, <n x 2 x i64>* %_a
       ret void
}
