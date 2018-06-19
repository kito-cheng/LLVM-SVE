; Check instruction combining for masked load and store SVE instructions
; Tests make sure that instructions are properly simplified and eliminated

; RUN: opt < %s -instcombine -S | FileCheck %s

declare void @llvm.masked.store.nxv2i64(<n x 2 x i64>, <n x 2 x i64>*, i32, <n x 2 x i1>)
declare <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64>*, i32, <n x 2 x i1>, <n x 2 x i64>)

; CHECK-LABEL: @masked_loads_mask_one
; CHECK-NEXT:  %unmaskedload = load <n x 2 x i64>, <n x 2 x i64>* %a, align 8
; CHECK-NEXT:  ret <n x 2 x i64> %unmaskedload
define <n x 2 x i64> @masked_loads_mask_one(<n x 2 x i64> *%a, <n x 2 x i64> %passthru) {
  %1 = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %2 = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %A = call <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64> *%a, i32 8, <n x 2 x i1> %2, <n x 2 x i64> %passthru)
  ret <n x 2 x i64> %A
}

; CHECK-LABEL: @masked_loads_mask_all_zero
; CHECK-NEXT:  ret <n x 2 x i64> %passthru
define <n x 2 x i64> @masked_loads_mask_all_zero(<n x 2 x i64> *%a, <n x 2 x i64> %passthru) {
  %1 = insertelement <n x 2 x i1> undef, i1 0, i32 0
  %2 = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %A = call <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64> *%a, i32 8, <n x 2 x i1> %2, <n x 2 x i64> %passthru)
  ret <n x 2 x i64> %A
}

; CHECK-LABEL: @masked_loads_mask_all_undef
; CHECK-NEXT:  ret <n x 2 x i64> %passthru
define <n x 2 x i64> @masked_loads_mask_all_undef(<n x 2 x i64> *%a, <n x 2 x i64> %passthru) {
  %1 = insertelement <n x 2 x i1> undef, i1 undef, i32 0
  %2 = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %A = call <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64> *%a, i32 8, <n x 2 x i1> %2, <n x 2 x i64> %passthru)
  ret <n x 2 x i64> %A
}

; CHECK-LABEL: @masked_store_mask_all_zero
; CHECK-NEXT:  ret void
define void @masked_store_mask_all_zero(<n x 2 x i64> *%ptr, <n x 2 x i64> %val ) {
  %1 = insertelement <n x 2 x i1> undef, i1 0, i32 0
  %2 = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %val, <n x 2 x i64> *%ptr, i32 8, <n x 2 x i1> %2)
  ret void
}

; CHECK-LABEL: @masked_store_mask_all_one
; CHECK-NEXT:  store <n x 2 x i64> %val, <n x 2 x i64>* %ptr, align 8
; CHECK-NEXT:  ret void
define void @masked_store_mask_all_one(<n x 2 x i64> *%ptr, <n x 2 x i64> %val ) {
  %1 = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %2 = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %val, <n x 2 x i64> *%ptr, i32 8, <n x 2 x i1> %2)
  ret void
}

; CHECK-LABEL: @masked_store_mask_all_undef
; CHECK-NEXT:  ret void
define void @masked_store_mask_all_undef(<n x 2 x i64> *%ptr, <n x 2 x i64> %val ) {
  %1 = insertelement <n x 2 x i1> undef, i1 undef, i32 0
  %2 = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %val, <n x 2 x i64> *%ptr, i32 8, <n x 2 x i1> %2)
  ret void
}

; CHECK-LABEL: @unmasked_loads_stores
; CHECK-NEXT:  %in_vals = load <n x 2 x i64>, <n x 2 x i64>* %a, align 16
; CHECK-NEXT:  %out_vals2 = shl <n x 2 x i64> %in_vals, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 2, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
; CHECK-NEXT:  store <n x 2 x i64> %out_vals2, <n x 2 x i64>* %a, align 16
; CHECK-NEXT:  ret void
define void @unmasked_loads_stores(<n x 2 x i64> *%a) {
  %in_vals = load <n x 2 x i64>, <n x 2 x i64>* %a
  %out_vals = add <n x 2 x i64> %in_vals, %in_vals
  store <n x 2 x i64> %out_vals,  <n x 2 x i64>* %a
  %in_vals2 = load <n x 2 x i64>, <n x 2 x i64>* %a
  %out_vals2 = add <n x 2 x i64> %in_vals2, %in_vals2
  store <n x 2 x i64> %out_vals2,  <n x 2 x i64>* %a
  ret void
}

; CHECK-LABEL: @masked_loads_stores
; CHECK-NEXT:  %unmaskedload = load <n x 2 x i64>, <n x 2 x i64>* %a, align 8
; CHECK-NEXT:  %out_vals2 = shl <n x 2 x i64> %unmaskedload, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 2, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
; CHECK-NEXT:  store <n x 2 x i64> %out_vals2, <n x 2 x i64>* %a, align 8
; CHECK-NEXT:  ret void
define void @masked_loads_stores(<n x 2 x i64> *%a) {
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %in_vals = call <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64> *%a, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  %out_vals = add <n x 2 x i64> %in_vals, %in_vals
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %out_vals, <n x 2 x i64> *%a, i32 8, <n x 2 x i1> %mask)
  %in_vals2 = call <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64> *%a, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  %out_vals2 = add <n x 2 x i64> %in_vals2, %in_vals2
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %out_vals2, <n x 2 x i64> *%a, i32 8, <n x 2 x i1> %mask)
  ret void
}
