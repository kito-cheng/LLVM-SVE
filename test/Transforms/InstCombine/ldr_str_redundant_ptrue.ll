; Check instruction combining for masked load ans store SVE instruction when the mask is a call

; RUN: opt < %s -instcombine -S | FileCheck %s

declare void @llvm.masked.store.2i64(<2 x i64>, <2 x i64>*, i32, <2 x i1>)
declare <2 x i64> @llvm.masked.load.2i64(<2 x i64>*, i32, <2 x i1>, <2 x i64>)

; Test with loads and stores using the same mask and pass undef
; CHECK-LABEL: @redundant_masked_load_store
; CHECK-NEXT:  call <2 x i64> @llvm.masked.load
; CHECK-NEXT:  add
; CHECK-NEXT:  call void @llvm.masked.store
; CHECK-NEXT:  ret void
define void @redundant_masked_load_store(<2 x i64> *%ptr, <2 x i1> %pg){
  %in_vals = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%ptr, i32 8, <2 x i1> %pg, <2 x i64> undef)
  %out_vals = add <2 x i64> %in_vals, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals, <2 x i64> *%ptr, i32 8, <2 x i1> %pg)
  %in_vals2 = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%ptr, i32 8, <2 x i1> %pg, <2 x i64> undef)
  %out_vals2 = add <2 x i64> %in_vals2, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals2, <2 x i64> *%ptr, i32 8, <2 x i1> %pg)
  ret void
}

; Test elimination of additional load and store when using different pointers
; CHECK-LABEL: @redundant_masked_load_store_ptr_a_b
; CHECK-NEXT:  call <2 x i64> @llvm.masked.load
; CHECK-NEXT:  add
; CHECK-NEXT:  call void @llvm.masked.store
; CHECK-NEXT:  ret void
define void @redundant_masked_load_store_ptr_a_b(<2 x i64> *%a, <2 x i64> *%b, <2 x i1> %pg){
  %in_vals = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%a, i32 8, <2 x i1> %pg, <2 x i64> undef)
  %out_vals = add <2 x i64> %in_vals, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals, <2 x i64> *%b, i32 8, <2 x i1> %pg)
  %in_vals2 = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%b, i32 8, <2 x i1> %pg, <2 x i64> undef)
  %out_vals2 = add <2 x i64> %in_vals2, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals2, <2 x i64> *%b, i32 8, <2 x i1> %pg)
  ret void
}

; Test with loads and stores using the different masks (negative test).
; CHECK-LABEL: @load_store_unequal_masks
; CHECK-NEXT:  call <2 x i64> @llvm.masked.load
; CHECK-NEXT:  add
; CHECK-NEXT:  call void @llvm.masked.store
; CHECK-NEXT:  call <2 x i64> @llvm.masked.load
; CHECK-NEXT:  add
; CHECK-NEXT:  call void @llvm.masked.store
; CHECK-NEXT:  ret void
define void @load_store_unequal_masks(<2 x i64> *%ptr, <2 x i1> %pg0, <2 x i1> %pg1){
  %in_vals = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%ptr, i32 8, <2 x i1> %pg0, <2 x i64> undef)
  %out_vals = add <2 x i64> %in_vals, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals, <2 x i64> *%ptr, i32 8, <2 x i1> %pg0)
  %in_vals2 = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%ptr, i32 8, <2 x i1> %pg1, <2 x i64> undef)
  %out_vals2 = add <2 x i64> %in_vals2, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals2, <2 x i64> *%ptr, i32 8, <2 x i1> %pg1)
  ret void
}

; Test masked reload of a value that has been loaded in full before.
; CHECK-LABEL: @redundant_masked_load
; CHECK-NEXT:  load <2 x i64>
; CHECK-NEXT:  add
; CHECK-NEXT:  store <2 x i64>
; CHECK-NEXT:  add
; CHECK-NEXT:  call void @llvm.masked.store
; CHECK-NEXT:  ret void
define void @redundant_masked_load(<2 x i64> *%ptr, <2 x i64> %pass, <2 x i1> %pg){
  %in_vals = load <2 x i64>, <2 x i64> *%ptr
  %out_vals = add <2 x i64> %in_vals, <i64 1, i64 1>
  store <2 x i64> %out_vals, <2 x i64> *%ptr
  %in_vals2 = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%ptr, i32 8, <2 x i1> %pg, <2 x i64> undef)
  %out_vals2 = add <2 x i64> %in_vals2, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals2, <2 x i64> *%ptr, i32 8, <2 x i1> %pg)
  ret void
}

; Test that reloading a value that was loaded in full before, but with
; a passthru value != undef, is not optimized (negative test).
; CHECK-LABEL: @masked_load
; CHECK-NEXT:  load <2 x i64>
; CHECK-NEXT:  add
; CHECK-NEXT:  store <2 x i64>
; CHECK-NEXT:  call <2 x i64> @llvm.masked.load
; CHECK-NEXT:  add
; CHECK-NEXT:  call void @llvm.masked.store
; CHECK-NEXT:  ret void
define void @masked_load_store_unmasked_masked(<2 x i64> *%ptr, <2 x i64> %pass, <2 x i1> %pg){
  %in_vals = load <2 x i64>, <2 x i64> *%ptr
  %out_vals = add <2 x i64> %in_vals, <i64 1, i64 1>
  store <2 x i64> %out_vals, <2 x i64> *%ptr
  %in_vals2 = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%ptr, i32 8, <2 x i1> %pg, <2 x i64> %pass)
  %out_vals2 = add <2 x i64> %in_vals2, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals2, <2 x i64> *%ptr, i32 8, <2 x i1> %pg)
  ret void
}

; Test with loads using passthru value that is not undef (negative test).
; CHECK-LABEL: @masked_load_store_non_undef_passthrough
; CHECK-NEXT:  call <2 x i64> @llvm.masked.load
; CHECK-NEXT:  add
; CHECK-NEXT:  call void @llvm.masked.store
; CHECK-NEXT:  call <2 x i64> @llvm.masked.load
; CHECK-NEXT:  add
; CHECK-NEXT:  call void @llvm.masked.store
; CHECK-NEXT:  ret void
define void @masked_load_store_non_undef_passthrough(<2 x i64> *%ptr, <2 x i1> %pg, <2 x i64> %pass){
  %in_vals = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%ptr, i32 8, <2 x i1> %pg, <2 x i64> %pass)
  %out_vals = add <2 x i64> %in_vals, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals, <2 x i64> *%ptr, i32 8, <2 x i1> %pg)
  %in_vals2 = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%ptr, i32 8, <2 x i1> %pg, <2 x i64> %pass)
  %out_vals2 = add <2 x i64> %in_vals2, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals2, <2 x i64> *%ptr, i32 8, <2 x i1> %pg)
  ret void
}

; Test elimination of masked store when followed by unmasked store to same location.
; CHECK-LABEL: redundant_store
; CHECK-NEXT: store <2 x i64> <i64 42, i64 42>
define void @redundant_store(<2 x i64> *%ptr, <2 x i64> %pass, <2 x i1> %pg){
  %in_vals = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%ptr, i32 8, <2 x i1> %pg, <2 x i64> undef)
  %out_vals = add <2 x i64> %in_vals, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals, <2 x i64> *%ptr, i32 8, <2 x i1> %pg)
  store <2 x i64> <i64 42, i64 42>, <2 x i64> *%ptr
  ret void
}

; Test that masked store is not removed when followed by masked store to same location.
; CHECK-LABEL: masked_store_store
; CHECK-NEXT:  call <2 x i64> @llvm.masked.load
; CHECK-NEXT:  add
; CHECK-NEXT:  call void @llvm.masked.store
; CHECK-NEXT:  call void @llvm.masked.store
define void @masked_store_store(<2 x i64> *%ptr, <2 x i64> %pass, <2 x i1> %pg,  <2 x i1> %pg2){
  %in_vals = call <2 x i64> @llvm.masked.load.2i64(<2 x i64> *%ptr, i32 8, <2 x i1> %pg, <2 x i64> undef)
  %out_vals = add <2 x i64> %in_vals, <i64 1, i64 1>
  call void @llvm.masked.store.2i64(<2 x i64> %out_vals, <2 x i64> *%ptr, i32 8, <2 x i1> %pg)
  call void @llvm.masked.store.2i64(<2 x i64> <i64 42, i64 42>, <2 x i64> *%ptr, i32 8, <2 x i1> %pg2)
  ret void
}
