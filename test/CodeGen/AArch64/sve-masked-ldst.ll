; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

;; Masked Loads & Stores - nx2xT

declare <n x 2 x i8> @llvm.masked.load.nxv2i8(<n x 2 x i8>*, i32, <n x 2 x i1>, <n x 2 x i8>)
declare <n x 2 x i16> @llvm.masked.load.nxv2i16(<n x 2 x i16>*, i32, <n x 2 x i1>, <n x 2 x i16>)
declare <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32>*, i32, <n x 2 x i1>, <n x 2 x i32>)
declare <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64>*, i32, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 2 x half> @llvm.masked.load.nxv2f16(<n x 2 x half>*, i32, <n x 2 x i1>, <n x 2 x half>)
declare <n x 2 x float> @llvm.masked.load.nxv2f32(<n x 2 x float>*, i32, <n x 2 x i1>, <n x 2 x float>)
declare <n x 2 x double> @llvm.masked.load.nxv2f64(<n x 2 x double>*, i32, <n x 2 x i1>, <n x 2 x double>)

declare void @llvm.masked.store.nxv2i8(<n x 2 x i8>, <n x 2 x i8>*,  i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2i16(<n x 2 x i16>, <n x 2 x i16>*, i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2i32(<n x 2 x i32>, <n x 2 x i32>*, i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2i64(<n x 2 x i64>, <n x 2 x i64>*, i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2f16(<n x 2 x half>, <n x 2 x half>*, i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2f32(<n x 2 x float>, <n x 2 x float>*, i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2f64(<n x 2 x double>, <n x 2 x double>*, i32, <n x 2 x i1>)

define void @masked_load_store_nxv2i8(<n x 2 x i8> *%a) {
; CHECK-LABEL: masked_load_store_nxv2i8:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1sb {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1b {[[OUT]].d}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %in_vals = call <n x 2 x i8> @llvm.masked.load.nxv2i8(<n x 2 x i8> *%a, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  %out_vals = add <n x 2 x i8> %in_vals, %in_vals
  call void @llvm.masked.store.nxv2i8(<n x 2 x i8> %out_vals, <n x 2 x i8> *%a, i32 1, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2i8_two_regs(i8 *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv2i8_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1sb {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, x1]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
;
; CHECK: st1b {[[OUT]].d}, [[PG]], [x0, x2]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %addr = getelementptr i8, i8* %a, i64 %idx
  %vaddr = bitcast i8 * %addr to <n x 2 x i8> *
  %in_vals = call <n x 2 x i8> @llvm.masked.load.nxv2i8(<n x 2 x i8> *%vaddr, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  %out_vals = add <n x 2 x i8> %in_vals, %in_vals
  %addr2 = getelementptr i8, i8* %a, i64 %idx2
  %vaddr2 = bitcast i8 * %addr2 to <n x 2 x i8> *
  call void @llvm.masked.store.nxv2i8(<n x 2 x i8> %out_vals, <n x 2 x i8> *%vaddr2, i32 1, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2i16(<n x 2 x i16> *%a) {
; CHECK-LABEL: masked_load_store_nxv2i16:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1sh {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1h {[[OUT]].d}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %in_vals = call <n x 2 x i16> @llvm.masked.load.nxv2i16(<n x 2 x i16> *%a, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  %out_vals = add <n x 2 x i16> %in_vals, %in_vals
  call void @llvm.masked.store.nxv2i16(<n x 2 x i16> %out_vals, <n x 2 x i16> *%a, i32 2, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2i16_two_regs(i16 *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv2i16_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1sh {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, x1, lsl #1]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1h {[[OUT]].d}, [[PG]], [x0, x2, lsl #1]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %addr = getelementptr i16, i16* %a, i64 %idx
  %vaddr = bitcast i16 * %addr to <n x 2 x i16> *
  %in_vals = call <n x 2 x i16> @llvm.masked.load.nxv2i16(<n x 2 x i16> *%vaddr, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  %out_vals = add <n x 2 x i16> %in_vals, %in_vals
  %addr2 = getelementptr i16, i16* %a, i64 %idx2
  %vaddr2 = bitcast i16 * %addr2 to <n x 2 x i16> *
  call void @llvm.masked.store.nxv2i16(<n x 2 x i16> %out_vals, <n x 2 x i16> *%vaddr2, i32 2, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2i32(<n x 2 x i32> *%a) {
; CHECK-LABEL: masked_load_store_nxv2i32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1sw {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1w {[[OUT]].d}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %in_vals = call <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32> *%a, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  %out_vals = add <n x 2 x i32> %in_vals, %in_vals
  call void @llvm.masked.store.nxv2i32(<n x 2 x i32> %out_vals, <n x 2 x i32> *%a, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2i32_two_regs(i32 *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv2i32_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1sw {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, x1, lsl #2]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1w {[[OUT]].d}, [[PG]], [x0, x2, lsl #2]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %addr = getelementptr i32, i32* %a, i64 %idx
  %vaddr = bitcast i32 * %addr to <n x 2 x i32> *
  %in_vals = call <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32> *%vaddr, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  %out_vals = add <n x 2 x i32> %in_vals, %in_vals
  %addr2 = getelementptr i32, i32* %a, i64 %idx2
  %vaddr2 = bitcast i32 * %addr2 to <n x 2 x i32> *
  call void @llvm.masked.store.nxv2i32(<n x 2 x i32> %out_vals, <n x 2 x i32> *%vaddr2, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2i64(<n x 2 x i64> *%a) {
; CHECK-LABEL: masked_load_store_nxv2i64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1d {[[OUT]].d}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %in_vals = call <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64> *%a, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  %out_vals = add <n x 2 x i64> %in_vals, %in_vals
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %out_vals, <n x 2 x i64> *%a, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2i64_two_regs(i64 *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv2i64_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, x1, lsl #3]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1d {[[OUT]].d}, [[PG]], [x0, x2, lsl #3]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %addr = getelementptr i64, i64* %a, i64 %idx
  %vaddr = bitcast i64 * %addr to <n x 2 x i64> *
  %in_vals = call <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64> *%vaddr, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  %out_vals = add <n x 2 x i64> %in_vals, %in_vals
  %addr2 = getelementptr i64, i64* %a, i64 %idx2
  %vaddr2 = bitcast i64 * %addr2 to <n x 2 x i64> *
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %out_vals, <n x 2 x i64> *%vaddr2, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2f16(<n x 2 x half> *%a) {
; CHECK-LABEL: masked_load_store_nxv2f16:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1h {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: fadd [[OUT:z[0-9]+]].h, [[IN]].h, [[IN]].h
; CHECK: st1h {[[OUT]].d}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %in_vals = call <n x 2 x half> @llvm.masked.load.nxv2f16(<n x 2 x half> *%a, i32 2, <n x 2 x i1> %mask, <n x 2 x half> undef)
  %out_vals = fadd <n x 2 x half> %in_vals, %in_vals
  call void @llvm.masked.store.nxv2f16(<n x 2 x half> %out_vals, <n x 2 x half> *%a, i32 2, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2f16_two_regs(half *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv2f16_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1h {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, x1, lsl #1]
; CHECK: fadd [[OUT:z[0-9]+]].h, [[IN]].h, [[IN]].h
; CHECK: st1h {[[OUT]].d}, [[PG]], [x0, x2, lsl #1]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %addr = getelementptr half, half* %a, i64 %idx
  %vaddr = bitcast half * %addr to <n x 2 x half> *
  %in_vals = call <n x 2 x half> @llvm.masked.load.nxv2f16(<n x 2 x half> *%vaddr, i32 2, <n x 2 x i1> %mask, <n x 2 x half> undef)
  %out_vals = fadd <n x 2 x half> %in_vals, %in_vals
  %addr2 = getelementptr half, half* %a, i64 %idx2
  %vaddr2 = bitcast half * %addr2 to <n x 2 x half> *
  call void @llvm.masked.store.nxv2f16(<n x 2 x half> %out_vals, <n x 2 x half> *%vaddr2, i32 2, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2f32(<n x 2 x float> *%a) {
; CHECK-LABEL: masked_load_store_nxv2f32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1w {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: fadd [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1w {[[OUT]].d}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %in_vals = call <n x 2 x float> @llvm.masked.load.nxv2f32(<n x 2 x float> *%a, i32 4, <n x 2 x i1> %mask, <n x 2 x float> undef)
  %out_vals = fadd <n x 2 x float> %in_vals, %in_vals
  call void @llvm.masked.store.nxv2f32(<n x 2 x float> %out_vals, <n x 2 x float> *%a, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2f32_two_regs(float *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv2f32_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1w {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, x1, lsl #2]
; CHECK: fadd [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1w {[[OUT]].d}, [[PG]], [x0, x2, lsl #2]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %addr = getelementptr float, float* %a, i64 %idx
  %vaddr = bitcast float * %addr to <n x 2 x float> *
  %in_vals = call <n x 2 x float> @llvm.masked.load.nxv2f32(<n x 2 x float> *%vaddr, i32 4, <n x 2 x i1> %mask, <n x 2 x float> undef)
  %out_vals = fadd <n x 2 x float> %in_vals, %in_vals
  %addr2 = getelementptr float, float* %a, i64 %idx2
  %vaddr2 = bitcast float * %addr2 to <n x 2 x float> *
  call void @llvm.masked.store.nxv2f32(<n x 2 x float> %out_vals, <n x 2 x float> *%vaddr2, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2f64(<n x 2 x double> *%a) {
; CHECK-LABEL: masked_load_store_nxv2f64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: fadd [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1d {[[OUT]].d}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %in_vals = call <n x 2 x double> @llvm.masked.load.nxv2f64(<n x 2 x double> *%a, i32 8, <n x 2 x i1> %mask, <n x 2 x double> undef)
  %out_vals = fadd <n x 2 x double> %in_vals, %in_vals
  call void @llvm.masked.store.nxv2f64(<n x 2 x double> %out_vals, <n x 2 x double> *%a, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv2f64_two_regs(double *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv2f64_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, x1, lsl #3]
; CHECK: fadd [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1d {[[OUT]].d}, [[PG]], [x0, x2, lsl #3]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %addr = getelementptr double, double* %a, i64 %idx
  %vaddr = bitcast double * %addr to <n x 2 x double> *
  %in_vals = call <n x 2 x double> @llvm.masked.load.nxv2f64(<n x 2 x double> *%vaddr, i32 8, <n x 2 x i1> %mask, <n x 2 x double> undef)
  %out_vals = fadd <n x 2 x double> %in_vals, %in_vals
  %addr2 = getelementptr double, double* %a, i64 %idx2
  %vaddr2 = bitcast double * %addr2 to <n x 2 x double> *
  call void @llvm.masked.store.nxv2f64(<n x 2 x double> %out_vals, <n x 2 x double> *%vaddr2, i32 8, <n x 2 x i1> %mask)
  ret void
}

;; Masked Loads & Stores - nx4xT

declare <n x 4 x i8> @llvm.masked.load.nxv4i8(<n x 4 x i8>*, i32, <n x 4 x i1>, <n x 4 x i8>)
declare <n x 4 x i16> @llvm.masked.load.nxv4i16(<n x 4 x i16>*, i32, <n x 4 x i1>, <n x 4 x i16>)
declare <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>*, i32, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 4 x half> @llvm.masked.load.nxv4f16(<n x 4 x half>*, i32, <n x 4 x i1>, <n x 4 x half>)
declare <n x 4 x float> @llvm.masked.load.nxv4f32(<n x 4 x float>*, i32, <n x 4 x i1>, <n x 4 x float>)

declare void @llvm.masked.store.nxv4i8(<n x 4 x i8>, <n x 4 x i8>*, i32, <n x 4 x i1>)
declare void @llvm.masked.store.nxv4i16(<n x 4 x i16>, <n x 4 x i16>*, i32, <n x 4 x i1>)
declare void @llvm.masked.store.nxv4i32(<n x 4 x i32>, <n x 4 x i32>*, i32, <n x 4 x i1>)
declare void @llvm.masked.store.nxv4f16(<n x 4 x half>, <n x 4 x half>*, i32, <n x 4 x i1>)
declare void @llvm.masked.store.nxv4f32(<n x 4 x float>, <n x 4 x float>*, i32, <n x 4 x i1>)

define void @masked_load_store_nxv4i8(<n x 4 x i8> *%a) {
; CHECK-LABEL: masked_load_store_nxv4i8:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ld1sb {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1b {[[OUT]].s}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %in_vals = call <n x 4 x i8> @llvm.masked.load.nxv4i8(<n x 4 x i8> *%a, i32 4, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  %out_vals = add <n x 4 x i8> %in_vals, %in_vals
  call void @llvm.masked.store.nxv4i8(<n x 4 x i8> %out_vals, <n x 4 x i8> *%a, i32 1, <n x 4 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv4i8_two_regs(i8 *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv4i8_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ld1sb {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0, x1]
; CHECK: add [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1b {[[OUT]].s}, [[PG]], [x0, x2]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %addr = getelementptr i8, i8* %a, i64 %idx
  %vaddr = bitcast i8 * %addr to <n x 4 x i8> *
  %in_vals = call <n x 4 x i8> @llvm.masked.load.nxv4i8(<n x 4 x i8> *%vaddr, i32 4, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  %out_vals = add <n x 4 x i8> %in_vals, %in_vals
  %addr2 = getelementptr i8, i8* %a, i64 %idx2
  %vaddr2 = bitcast i8 * %addr2 to <n x 4 x i8> *
  call void @llvm.masked.store.nxv4i8(<n x 4 x i8> %out_vals, <n x 4 x i8> *%vaddr2, i32 1, <n x 4 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv4i16(<n x 4 x i16> *%a) {
; CHECK-LABEL: masked_load_store_nxv4i16:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ld1sh {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1h {[[OUT]].s}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %in_vals = call <n x 4 x i16> @llvm.masked.load.nxv4i16(<n x 4 x i16> *%a, i32 4, <n x 4 x i1> %mask, <n x 4 x i16> undef)
  %out_vals = add <n x 4 x i16> %in_vals, %in_vals
  call void @llvm.masked.store.nxv4i16(<n x 4 x i16> %out_vals, <n x 4 x i16> *%a, i32 2, <n x 4 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv4i16_two_regs(i16 *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv4i16_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ld1sh {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0, x1, lsl #1]
; CHECK: add [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1h {[[OUT]].s}, [[PG]], [x0, x2, lsl #1]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %addr = getelementptr i16, i16* %a, i64 %idx
  %vaddr = bitcast i16 * %addr to <n x 4 x i16> *
  %in_vals = call <n x 4 x i16> @llvm.masked.load.nxv4i16(<n x 4 x i16> *%vaddr, i32 4, <n x 4 x i1> %mask, <n x 4 x i16> undef)
  %out_vals = add <n x 4 x i16> %in_vals, %in_vals
  %addr2 = getelementptr i16, i16* %a, i64 %idx2
  %vaddr2 = bitcast i16 * %addr2 to <n x 4 x i16> *
  call void @llvm.masked.store.nxv4i16(<n x 4 x i16> %out_vals, <n x 4 x i16> *%vaddr2, i32 2, <n x 4 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv4i32(<n x 4 x i32> *%a) {
; CHECK-LABEL: masked_load_store_nxv4i32:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ld1w {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1w {[[OUT]].s}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %in_vals = call <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32> *%a, i32 4, <n x 4 x i1> %mask, <n x 4 x i32> undef)
  %out_vals = add <n x 4 x i32> %in_vals, %in_vals
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %out_vals, <n x 4 x i32> *%a, i32 4, <n x 4 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv4i32_two_regs(i32 *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv4i32_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ld1w {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0, x1, lsl #2]
; CHECK: add [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1w {[[OUT]].s}, [[PG]], [x0, x2, lsl #2]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %addr = getelementptr i32, i32* %a, i64 %idx
  %vaddr = bitcast i32 * %addr to <n x 4 x i32> *
  %in_vals = call <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32> *%vaddr, i32 4, <n x 4 x i1> %mask, <n x 4 x i32> undef)
  %out_vals = add <n x 4 x i32> %in_vals, %in_vals
  %addr2 = getelementptr i32, i32* %a, i64 %idx2
  %vaddr2 = bitcast i32 * %addr2 to <n x 4 x i32> *
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %out_vals, <n x 4 x i32> *%vaddr2, i32 4, <n x 4 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv4f16(<n x 4 x half> *%a) {
; CHECK-LABEL: masked_load_store_nxv4f16:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ld1h {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK: st1h {[[OUT]].s}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %out_vals = call <n x 4 x half> @llvm.masked.load.nxv4f16(<n x 4 x half> *%a, i32 4, <n x 4 x i1> %mask, <n x 4 x half> undef)
  call void @llvm.masked.store.nxv4f16(<n x 4 x half> %out_vals, <n x 4 x half> *%a, i32 4, <n x 4 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv4f16_two_regs(half *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv4f16_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ld1h {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0, x1, lsl #1]
; CHECK: st1h {[[OUT]].s}, [[PG]], [x0, x2, lsl #1]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %addr = getelementptr half, half* %a, i64 %idx
  %vaddr = bitcast half * %addr to <n x 4 x half> *
  %out_vals = call <n x 4 x half> @llvm.masked.load.nxv4f16(<n x 4 x half> *%vaddr, i32 4, <n x 4 x i1> %mask, <n x 4 x half> undef)
  %addr2 = getelementptr half, half* %a, i64 %idx2
  %vaddr2 = bitcast half * %addr2 to <n x 4 x half> *
  call void @llvm.masked.store.nxv4f16(<n x 4 x half> %out_vals, <n x 4 x half> *%vaddr2, i32 4, <n x 4 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv4f32(<n x 4 x float> *%a) {
; CHECK-LABEL: masked_load_store_nxv4f32:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ld1w {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1w {[[OUT]].s}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %in_vals = call <n x 4 x float> @llvm.masked.load.nxv4f32(<n x 4 x float> *%a, i32 4, <n x 4 x i1> %mask, <n x 4 x float> undef)
  %out_vals = fadd <n x 4 x float> %in_vals, %in_vals
  call void @llvm.masked.store.nxv4f32(<n x 4 x float> %out_vals, <n x 4 x float> *%a, i32 4, <n x 4 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv4f32_two_regs(float *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv4f32_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: ld1w {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0, x1, lsl #2]
; CHECK: add [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1w {[[OUT]].s}, [[PG]], [x0, x2, lsl #2]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %addr = getelementptr float, float* %a, i64 %idx
  %vaddr = bitcast float * %addr to <n x 4 x float> *
  %in_vals = call <n x 4 x float> @llvm.masked.load.nxv4f32(<n x 4 x float> *%vaddr, i32 4, <n x 4 x i1> %mask, <n x 4 x float> undef)
  %out_vals = fadd <n x 4 x float> %in_vals, %in_vals
  %addr2 = getelementptr float, float* %a, i64 %idx2
  %vaddr2 = bitcast float * %addr2 to <n x 4 x float> *
  call void @llvm.masked.store.nxv4f32(<n x 4 x float> %out_vals, <n x 4 x float> *%vaddr2, i32 4, <n x 4 x i1> %mask)
  ret void
}

;; Masked Loads & Stores - nx8xT

declare <n x 8 x i8> @llvm.masked.load.nxv8i8(<n x 8 x i8>*, i32, <n x 8 x i1>, <n x 8 x i8>)
declare <n x 8 x i16> @llvm.masked.load.nxv8i16(<n x 8 x i16>*, i32, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 8 x half> @llvm.masked.load.nxv8f16(<n x 8 x half>*, i32, <n x 8 x i1>, <n x 8 x half>)

declare void @llvm.masked.store.nxv8i8(<n x 8 x i8>, <n x 8 x i8>*, i32, <n x 8 x i1>)
declare void @llvm.masked.store.nxv8i16(<n x 8 x i16>, <n x 8 x i16>*, i32, <n x 8 x i1>)
declare void @llvm.masked.store.nxv8f16(<n x 8 x half>, <n x 8 x half>*, i32, <n x 8 x i1>)

define void @masked_load_store_nxv8i8(<n x 8 x i8> *%a) {
; CHECK-LABEL: masked_load_store_nxv8i8:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK: ld1sb {[[IN:z[0-9]+]].h}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].h, [[IN]].h, [[IN]].h
; CHECK: st1b {[[OUT]].h}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %in_vals = call <n x 8 x i8> @llvm.masked.load.nxv8i8(<n x 8 x i8> *%a, i32 2, <n x 8 x i1> %mask, <n x 8 x i8> undef)
  %out_vals = add <n x 8 x i8> %in_vals, %in_vals
  call void @llvm.masked.store.nxv8i8(<n x 8 x i8> %out_vals, <n x 8 x i8> *%a, i32 1, <n x 8 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv8i8_two_regs(i8 *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv8i8_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK: ld1sb {[[IN:z[0-9]+]].h}, [[PG]]/z, [x0, x1]
; CHECK: add [[OUT:z[0-9]+]].h, [[IN]].h, [[IN]].h
; CHECK: st1b {[[OUT]].h}, [[PG]], [x0, x2]
; CHECK: ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %addr = getelementptr i8, i8* %a, i64 %idx
  %vaddr = bitcast i8 * %addr to <n x 8 x i8> *
  %in_vals = call <n x 8 x i8> @llvm.masked.load.nxv8i8(<n x 8 x i8> *%vaddr, i32 2, <n x 8 x i1> %mask, <n x 8 x i8> undef)
  %out_vals = add <n x 8 x i8> %in_vals, %in_vals
  %addr2 = getelementptr i8, i8* %a, i64 %idx2
  %vaddr2 = bitcast i8 * %addr2 to <n x 8 x i8> *
  call void @llvm.masked.store.nxv8i8(<n x 8 x i8> %out_vals, <n x 8 x i8> *%vaddr2, i32 1, <n x 8 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv8i16(<n x 8 x i16> *%a) {
; CHECK-LABEL: masked_load_store_nxv8i16:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK: ld1h {[[IN:z[0-9]+]].h}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].h, [[IN]].h, [[IN]].h
; CHECK: st1h {[[OUT]].h}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %in_vals = call <n x 8 x i16> @llvm.masked.load.nxv8i16(<n x 8 x i16> *%a, i32 2, <n x 8 x i1> %mask, <n x 8 x i16> undef)
  %out_vals = add <n x 8 x i16> %in_vals, %in_vals
  call void @llvm.masked.store.nxv8i16(<n x 8 x i16> %out_vals, <n x 8 x i16> *%a, i32 2, <n x 8 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv8i16_two_regs(i16*%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv8i16_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK: ld1h {[[IN:z[0-9]+]].h}, [[PG]]/z, [x0, x1, lsl #1]
; CHECK: add [[OUT:z[0-9]+]].h, [[IN]].h, [[IN]].h
; CHECK: st1h {[[OUT]].h}, [[PG]], [x0, x2, lsl #1]
; CHECK: ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %addr = getelementptr i16, i16* %a, i64 %idx
  %vaddr = bitcast i16 * %addr to <n x 8 x i16> *
  %in_vals = call <n x 8 x i16> @llvm.masked.load.nxv8i16(<n x 8 x i16> *%vaddr, i32 2, <n x 8 x i1> %mask, <n x 8 x i16> undef)
  %out_vals = add <n x 8 x i16> %in_vals, %in_vals
  %addr2 = getelementptr i16, i16* %a, i64 %idx2
  %vaddr2 = bitcast i16 * %addr2 to <n x 8 x i16> *
  call void @llvm.masked.store.nxv8i16(<n x 8 x i16> %out_vals, <n x 8 x i16> *%vaddr2, i32 2, <n x 8 x i1> %mask)
  ret void
}

define <n x 8 x half> @masked_load_nxv8f16(<n x 8 x half>* %addr, <n x 8 x i1> %mask) {
; CHECK-LABEL: masked_load_nxv8f16:
; CHECK: ld1h {z0.h}, p0/z, [x0]
  %val = call <n x 8 x half> @llvm.masked.load.nxv8f16(<n x 8 x half>* %addr, i32 1, <n x 8 x i1> %mask, <n x 8 x half> undef)
  ret <n x 8 x half> %val
}

define void @masked_store_nxv8f16(<n x 8 x half> %data, <n x 8 x half>* %addr, <n x 8 x i1> %mask) {
; CHECK-LABEL: masked_store_nxv8f16:
; CHECK: st1h {z0.h}, p0, [x0]
  call void @llvm.masked.store.nxv8f16(<n x 8 x half> %data, <n x 8 x half>* %addr, i32 1, <n x 8 x i1> %mask)
  ret void
}

;; Masked Loads & Stores - nx16xT

declare <n x 16 x i8> @llvm.masked.load.nxv16i8(<n x 16 x i8>*, i32, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 16 x i64> @llvm.masked.load.nxv16i64(<n x 16 x i64>*, i32, <n x 16 x i1>, <n x 16 x i64>)

declare void @llvm.masked.store.nxv16i8(<n x 16 x i8>, <n x 16 x i8>*, i32, <n x 16 x i1>)
declare void @llvm.masked.store.nxv16i64(<n x 16 x i64>, <n x 16 x i64>*, i32, <n x 16 x i1>)

define void @masked_load_store_nxv16i8(<n x 16 x i8> *%a) {
; CHECK-LABEL: masked_load_store_nxv16i8:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK: ld1b {[[IN:z[0-9]+]].b}, [[PG]]/z, [x0]
; CHECK: add [[OUT:z[0-9]+]].b, [[IN]].b, [[IN]].b
; CHECK: st1b {[[OUT]].b}, [[PG]], [x0]
; CHECK: ret
  %bit = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 16 x i1> %bit, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer

  %in_vals = call <n x 16 x i8> @llvm.masked.load.nxv16i8(<n x 16 x i8> *%a, i32 1, <n x 16 x i1> %mask, <n x 16 x i8> undef)
  %out_vals = add <n x 16 x i8> %in_vals, %in_vals
  call void @llvm.masked.store.nxv16i8(<n x 16 x i8> %out_vals, <n x 16 x i8> *%a, i32 1, <n x 16 x i1> %mask)
  ret void
}

define void @masked_load_store_nxv16i8_two_regs(i8 *%a, i64 %idx, i64 %idx2) {
; CHECK-LABEL: masked_load_store_nxv16i8_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK: ld1b {[[IN:z[0-9]+]].b}, [[PG]]/z, [x0, x1]
; CHECK: add [[OUT:z[0-9]+]].b, [[IN]].b, [[IN]].b
; CHECK: st1b {[[OUT]].b}, [[PG]], [x0, x2]
; CHECK: ret
  %bit = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 16 x i1> %bit, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer

  %addr = getelementptr i8, i8* %a, i64 %idx
  %vaddr = bitcast i8 * %addr to <n x 16 x i8> *
  %in_vals = call <n x 16 x i8> @llvm.masked.load.nxv16i8(<n x 16 x i8> *%vaddr, i32 1, <n x 16 x i1> %mask, <n x 16 x i8> undef)
  %out_vals = add <n x 16 x i8> %in_vals, %in_vals
  %addr2 = getelementptr i8, i8* %a, i64 %idx2
  %vaddr2 = bitcast i8 * %addr2 to <n x 16 x i8> *
  call void @llvm.masked.store.nxv16i8(<n x 16 x i8> %out_vals, <n x 16 x i8> *%vaddr2, i32 1, <n x 16 x i1> %mask)
  ret void
}

; TODO: This test has been broke for ages, essentially splitvec type legalisation
; does not work for masked nodes that use scalable vectors.
;
; NOTE: We don't really care about matching the generated code becuase this test
; is more about exercising splitvec legalisation for masked loads and stores.
; REMARK: fix in SC-858!
define void @masked_load_store_nxv16i64(<n x 16 x i64> *%a) {
; CHECK-LABEL: masked_load_store_nxv16i64:
; CHECK-BAD: ld1d {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-BAD: ld1d {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-BAD: ld1d {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-BAD: ld1d {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-BAD: ld1d {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-BAD: ld1d {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-BAD: ld1d {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-BAD: ld1d {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-NOT-BAD: ld1d {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-BAD: st1d {{{z[0-9]+}}.d}, {{p[0-9]+}}, [{{x[0-9]+}}]
; CHECK-BAD: st1d {{{z[0-9]+}}.d}, {{p[0-9]+}}, [{{x[0-9]+}}]
; CHECK-BAD: st1d {{{z[0-9]+}}.d}, {{p[0-9]+}}, [{{x[0-9]+}}]
; CHECK-BAD: st1d {{{z[0-9]+}}.d}, {{p[0-9]+}}, [{{x[0-9]+}}]
; CHECK-BAD: st1d {{{z[0-9]+}}.d}, {{p[0-9]+}}, [{{x[0-9]+}}]
; CHECK-BAD: st1d {{{z[0-9]+}}.d}, {{p[0-9]+}}, [{{x[0-9]+}}]
; CHECK-BAD: st1d {{{z[0-9]+}}.d}, {{p[0-9]+}}, [{{x[0-9]+}}]
; CHECK-BAD: st1d {{{z[0-9]+}}.d}, {{p[0-9]+}}, [{{x[0-9]+}}]
; CHECK-NOT-BAD: st1d {{{z[0-9]+}}.d}, {{p[0-9]+}}, [{{x[0-9]+}}]
; CHECK: ret
  %bit = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 16 x i1> %bit, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer

  %in_vals = call <n x 16 x i64> @llvm.masked.load.nxv16i64(<n x 16 x i64> *%a, i32 1, <n x 16 x i1> %mask, <n x 16 x i64> undef)
  %out_vals = add <n x 16 x i64> %in_vals, %in_vals
  call void @llvm.masked.store.nxv16i64(<n x 16 x i64> %out_vals, <n x 16 x i64> *%a, i32 1, <n x 16 x i1> %mask)
  ret void
}

;; Gather Loads/Scatter Stores - nx2xT with vector of addresses

declare <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*>, i32, <n x 2 x i1>, <n x 2 x i8>)
declare <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*>, i32, <n x 2 x i1>, <n x 2 x i16>)
declare <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*>, i32, <n x 2 x i1>, <n x 2 x i32>)
declare <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*>, i32, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 2 x float> @llvm.masked.gather.nxv2f32(<n x 2 x float*>, i32, <n x 2 x i1>, <n x 2 x float>)
declare <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*>, i32, <n x 2 x i1>, <n x 2 x double>)

declare void @llvm.masked.scatter.nxv2i8(<n x 2 x i8>, <n x 2 x i8*>,  i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2i16(<n x 2 x i16>, <n x 2 x i16*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2i32(<n x 2 x i32>, <n x 2 x i32*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2i64(<n x 2 x i64>, <n x 2 x i64*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2f32(<n x 2 x float>, <n x 2 x float*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv2f64(<n x 2 x double>, <n x 2 x double*>, i32, <n x 2 x i1>)

define void @masked_gather_scatter_nxv2i8(<n x 2 x i8*> *%a) {
; CHECK-LABEL: masked_gather_scatter_nxv2i8:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1d {z[[PTRS:[0-9]+]].d},
; CHECK: ld1sb {[[IN:z[0-9]+]].d}, [[PG]]/z, [z[[PTRS]].d]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1b {[[OUT]].d}, [[PG]], [z[[PTRS]].d]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %ptrs = load <n x 2 x i8*> , <n x 2 x i8*> *%a
  %in_vals = call <n x 2 x i8> @llvm.masked.gather.nxv2i8(<n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  %out_vals = add <n x 2 x i8> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2i8(<n x 2 x i8> %out_vals, <n x 2 x i8*> %ptrs, i32 1, <n x 2 x i1> %mask)
  ret void
}

define void @masked_gather_scatter_nxv2i16(<n x 2 x i16*> *%a) {
; CHECK-LABEL: masked_gather_scatter_nxv2i16:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1d {z[[PTRS:[0-9]+]].d},
; CHECK: ld1sh {[[IN:z[0-9]+]].d}, [[PG]]/z, [z[[PTRS]].d]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1h {[[OUT]].d}, [[PG]], [z[[PTRS]].d]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %ptrs = load <n x 2 x i16*> , <n x 2 x i16*> *%a
  %in_vals = call <n x 2 x i16> @llvm.masked.gather.nxv2i16(<n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  %out_vals = add <n x 2 x i16> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2i16(<n x 2 x i16> %out_vals, <n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask)
  ret void
}

define void @masked_gather_scatter_nxv2i32(<n x 2 x i32*> *%a) {
; CHECK-LABEL: masked_gather_scatter_nxv2i32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1d {z[[PTRS:[0-9]+]].d},
; CHECK: ld1sw {[[IN:z[0-9]+]].d}, [[PG]]/z, [z[[PTRS]].d]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1w {[[OUT]].d}, [[PG]], [z[[PTRS]].d]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %ptrs = load <n x 2 x i32*> , <n x 2 x i32*> *%a
  %in_vals = call <n x 2 x i32> @llvm.masked.gather.nxv2i32(<n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  %out_vals = add <n x 2 x i32> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2i32(<n x 2 x i32> %out_vals, <n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_gather_scatter_nxv2i64(<n x 2 x i64*> *%a) {
; CHECK-LABEL: masked_gather_scatter_nxv2i64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1d {z[[PTRS:[0-9]+]].d},
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PG]]/z, [z[[PTRS]].d]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1d {[[OUT]].d}, [[PG]], [z[[PTRS]].d]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %ptrs = load <n x 2 x i64*> , <n x 2 x i64*> *%a
  %in_vals = call <n x 2 x i64> @llvm.masked.gather.nxv2i64(<n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  %out_vals = add <n x 2 x i64> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2i64(<n x 2 x i64> %out_vals, <n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_gather_scatter_nxv2f32(<n x 2 x float*> *%a) {
; CHECK-LABEL: masked_gather_scatter_nxv2f32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1d {z[[PTRS:[0-9]+]].d},
; CHECK: ld1w {[[IN:z[0-9]+]].d}, [[PG]]/z, [z[[PTRS]].d]
; CHECK: fadd [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1w {[[OUT]].d}, [[PG]], [z[[PTRS]].d]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %ptrs = load <n x 2 x float*> , <n x 2 x float*> *%a
  %in_vals = call <n x 2 x float> @llvm.masked.gather.nxv2f32(<n x 2 x float*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x float> undef)
  %out_vals = fadd <n x 2 x float> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2f32(<n x 2 x float> %out_vals, <n x 2 x float*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_gather_scatter_nxv2f64(<n x 2 x double*> *%a) {
; CHECK-LABEL: masked_gather_scatter_nxv2f64:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: ld1d {z[[PTRS:[0-9]+]].d},
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PG]]/z, [z[[PTRS]].d]
; CHECK: fadd [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1d {[[OUT]].d}, [[PG]], [z[[PTRS]].d]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %ptrs = load <n x 2 x double*> , <n x 2 x double*> *%a
  %in_vals = call <n x 2 x double> @llvm.masked.gather.nxv2f64(<n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x double> undef)
  %out_vals = fadd <n x 2 x double> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2f64(<n x 2 x double> %out_vals, <n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

;; Gather Loads/Scatter Stores - nx4xT with vector of addresses

declare <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*>, i32, <n x 4 x i1>, <n x 4 x i32>)
declare void @llvm.masked.scatter.nxv4i32(<n x 4 x i32>, <n x 4 x i32*>, i32, <n x 4 x i1>)

define void @masked_gather_scatter_nxv4i32(<n x 4 x i32*> *%a) {
; CHECK-LABEL: masked_gather_scatter_nxv4i32:
; CHECK-DAG: ld1d {z[[PTRS_LO:[0-9]+]].d}, {{p[0-9]+}}/z, [x0]
; CHECK-DAG: ld1d {z[[PTRS_HI:[0-9]+]].d}, {{p[0-9]+}}/z, [x0, #1, mul vl]
; CHECK:     zip1 {{p[0-9]+}}
; CHECK-DAG: ld1sw {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_HI]].d]
; CHECK-DAG: ld1sw {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_LO]].d]
; CHECK-NOT: ld1
; CHECK:     add {{z[0-9]+}}
; CHECK-DAG: st1w {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_HI]].d]
; CHECK-DAG: st1w {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_LO]].d]
; CHECK-NOT: st1
; CHECK:     ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %ptrs = load <n x 4 x i32*> , <n x 4 x i32*> *%a
  %in_vals = call <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*> %ptrs, i32 4, <n x 4 x i1> %mask, <n x 4 x i32> undef)
  %out_vals = add <n x 4 x i32> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv4i32(<n x 4 x i32> %out_vals, <n x 4 x i32*> %ptrs, i32 4, <n x 4 x i1> %mask)
  ret void
}

;; Gather Loads/Scatter Stores - nx8xT with vector of addresses

declare <n x 8 x i16> @llvm.masked.gather.nxv8i16(<n x 8 x i16*>, i32, <n x 8 x i1>, <n x 8 x i16>)
declare void @llvm.masked.scatter.nxv8i16(<n x 8 x i16>, <n x 8 x i16*>, i32, <n x 8 x i1>)

define void @masked_gather_scatter_nxv8i16(<n x 8 x i16*> *%a) {
; CHECK-LABEL: masked_gather_scatter_nxv8i16:
; CHECK-DAG: ld1d {z[[PTRS_LOLO:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-DAG: ld1d {z[[PTRS_LOHI:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-DAG: ld1d {z[[PTRS_HILO:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-DAG: ld1d {z[[PTRS_HIHI:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK:     zip1 {{p[0-9]+}}
; CHECK-DAG: ld1sh {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_HIHI]].d]
; CHECK-DAG: ld1sh {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_HILO]].d]
; CHECK-DAG: ld1sh {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_LOHI]].d]
; CHECK-DAG: ld1sh {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_LOLO]].d]
; CHECK-NOT: ld1
; CHECK:     add {{z[0-9]+}}
; CHECK-DAG: st1h {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_HIHI]].d]
; CHECK-DAG: st1h {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_HILO]].d]
; CHECK-DAG: st1h {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_LOHI]].d]
; CHECK-DAG: st1h {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_LOLO]].d]
; CHECK-NOT: st1
; CHECK:     ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %ptrs = load <n x 8 x i16*> , <n x 8 x i16*> *%a
  %in_vals = call <n x 8 x i16> @llvm.masked.gather.nxv8i16(<n x 8 x i16*> %ptrs, i32 2, <n x 8 x i1> %mask, <n x 8 x i16> undef)
  %out_vals = add <n x 8 x i16> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv8i16(<n x 8 x i16> %out_vals, <n x 8 x i16*> %ptrs, i32 2, <n x 8 x i1> %mask)
  ret void
}

;; Gather Loads/Scatter Stores - nx16xT with vector of addresses

declare <n x 16 x i8> @llvm.masked.gather.nxv16i8(<n x 16 x i8*>, i32, <n x 16 x i1>, <n x 16 x i8>)
declare void @llvm.masked.scatter.nxv16i8(<n x 16 x i8>, <n x 16 x i8*>, i32, <n x 16 x i1>)

define void @masked_gather_scatter_nxv16i8(<n x 16 x i8*> *%a) {
; CHECK-LABEL: masked_gather_scatter_nxv16i8:
; CHECK-DAG: ld1d {z[[PTRS_LOLOLO:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-DAG: ld1d {z[[PTRS_LOLOHI:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-DAG: ld1d {z[[PTRS_LOHILO:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-DAG: ld1d {z[[PTRS_LOHIHI:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-DAG: ld1d {z[[PTRS_HILOLO:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-DAG: ld1d {z[[PTRS_HILOHI:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-DAG: ld1d {z[[PTRS_HIHILO:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK-DAG: ld1d {z[[PTRS_HIHIHI:[0-9]+]].d}, {{p[0-9]+}}/z, [{{x[0-9]+}}]
; CHECK:     zip1 {{p[0-9]+}}
; CHECK-DAG: ld1sb {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_HIHIHI]].d]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_HIHILO]].d]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_HILOHI]].d]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_HILOLO]].d]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_LOHIHI]].d]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_LOHILO]].d]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_LOLOHI]].d]
; CHECK-DAG: ld1sb {{{z[0-9]+}}.d}, {{p[0-9]+}}/z, [z[[PTRS_LOLOLO]].d]
; CHECK-NOT: ld1
; CHECK:     add {{z[0-9]+}}
; CHECK-DAG: st1b {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_HIHIHI]].d]
; CHECK-DAG: st1b {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_HIHILO]].d]
; CHECK-DAG: st1b {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_HILOHI]].d]
; CHECK-DAG: st1b {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_HILOLO]].d]
; CHECK-DAG: st1b {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_LOHIHI]].d]
; CHECK-DAG: st1b {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_LOHILO]].d]
; CHECK-DAG: st1b {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_LOLOHI]].d]
; CHECK-DAG: st1b {{{z[0-9]+}}.d}, {{p[0-9]+}}, [z[[PTRS_LOLOLO]].d]
; CHECK-NOT: st1
; CHECK:     ret
  %bit = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 16 x i1> %bit, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer

  %ptrs = load <n x 16 x i8*> , <n x 16 x i8*> *%a
  %in_vals = call <n x 16 x i8> @llvm.masked.gather.nxv16i8(<n x 16 x i8*> %ptrs, i32 1, <n x 16 x i1> %mask, <n x 16 x i8> undef)
  %out_vals = add <n x 16 x i8> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv16i8(<n x 16 x i8> %out_vals, <n x 16 x i8*> %ptrs, i32 1, <n x 16 x i1> %mask)
  ret void
}

;; First Faulting Masked Loads - nx2xT

declare {<n x 2 x i8>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2i8(<n x 2 x i8>*, i32, <n x 2 x i1>, <n x 2 x i8>)
declare {<n x 2 x i16>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2i16(<n x 2 x i16>*, i32, <n x 2 x i1>, <n x 2 x i16>)
declare {<n x 2 x i32>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2i32(<n x 2 x i32>*, i32, <n x 2 x i1>, <n x 2 x i32>)
declare {<n x 2 x i64>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2i64(<n x 2 x i64>*, i32, <n x 2 x i1>, <n x 2 x i64>)
declare {<n x 2 x float>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2f32(<n x 2 x float>*, i32, <n x 2 x i1>, <n x 2 x float>)
declare {<n x 2 x double>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2f64(<n x 2 x double>*, i32, <n x 2 x i1>, <n x 2 x double>)

define void @masked_spec_load_nxv2i8(<n x 2 x i8> *%a, <n x 2 x i8> *%b) {
; CHECK-LABEL: masked_spec_load_nxv2i8:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: setffr
; CHECK: ldff1b {[[DATA:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1b {[[DATA]].d}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %load = call {<n x 2 x i8>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2i8(<n x 2 x i8> *%a, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  %data = extractvalue {<n x 2 x i8>, <n x 2 x i1>} %load, 0
  %data_mask = extractvalue {<n x 2 x i8>, <n x 2 x i1>} %load, 1
  call void @llvm.masked.store.nxv2i8(<n x 2 x i8> %data, <n x 2 x i8> *%b, i32 1, <n x 2 x i1> %data_mask)
  ret void
}

define void @masked_spec_load_nxv2i16(<n x 2 x i16> *%a, <n x 2 x i16> *%b) {
; CHECK-LABEL: masked_spec_load_nxv2i16:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: setffr
; CHECK: ldff1h {[[DATA:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1h {[[DATA]].d}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %load = call {<n x 2 x i16>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2i16(<n x 2 x i16> *%a, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  %data = extractvalue {<n x 2 x i16>, <n x 2 x i1>} %load, 0
  %data_mask = extractvalue {<n x 2 x i16>, <n x 2 x i1>} %load, 1
  call void @llvm.masked.store.nxv2i16(<n x 2 x i16> %data, <n x 2 x i16> *%b, i32 2, <n x 2 x i1> %data_mask)
  ret void
}

define void @masked_spec_load_nxv2i32(<n x 2 x i32> *%a, <n x 2 x i32> *%b) {
; CHECK-LABEL: masked_spec_load_nxv2i32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: setffr
; CHECK: ldff1w {[[DATA:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1w {[[DATA]].d}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %load = call {<n x 2 x i32>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2i32(<n x 2 x i32> *%a, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  %data = extractvalue {<n x 2 x i32>, <n x 2 x i1>} %load, 0
  %data_mask = extractvalue {<n x 2 x i32>, <n x 2 x i1>} %load, 1
  call void @llvm.masked.store.nxv2i32(<n x 2 x i32> %data, <n x 2 x i32> *%b, i32 4, <n x 2 x i1> %data_mask)
  ret void
}

define void @masked_spec_load_nxv2i64(<n x 2 x i64> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: masked_spec_load_nxv2i64:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: setffr
; CHECK: ldff1d {[[DATA:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1d {[[DATA]].d}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %load = call {<n x 2 x i64>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2i64(<n x 2 x i64> *%a, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  %data = extractvalue {<n x 2 x i64>, <n x 2 x i1>} %load, 0
  %data_mask = extractvalue {<n x 2 x i64>, <n x 2 x i1>} %load, 1
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %data, <n x 2 x i64> *%b, i32 8, <n x 2 x i1> %data_mask)
  ret void
}

define void @masked_spec_load_nxv2f32(<n x 2 x float> *%a, <n x 2 x float> *%b) {
; CHECK-LABEL: masked_spec_load_nxv2f32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: setffr
; CHECK: ldff1w {[[DATA:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1w {[[DATA]].d}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %load = call {<n x 2 x float>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2f32(<n x 2 x float> *%a, i32 4, <n x 2 x i1> %mask, <n x 2 x float> undef)
  %data = extractvalue {<n x 2 x float>, <n x 2 x i1>} %load, 0
  %data_mask = extractvalue {<n x 2 x float>, <n x 2 x i1>} %load, 1
  call void @llvm.masked.store.nxv2f32(<n x 2 x float> %data, <n x 2 x float> *%b, i32 4, <n x 2 x i1> %data_mask)
  ret void
}

define void @masked_spec_load_nxv2f64(<n x 2 x double> *%a, <n x 2 x double> *%b) {
; CHECK-LABEL: masked_spec_load_nxv2f64:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: setffr
; CHECK: ldff1d {[[DATA:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1d {[[DATA]].d}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %load = call {<n x 2 x double>, <n x 2 x i1>} @llvm.masked.spec.load.nxv2f64(<n x 2 x double> *%a, i32 8, <n x 2 x i1> %mask, <n x 2 x double> undef)
  %data = extractvalue {<n x 2 x double>, <n x 2 x i1>} %load, 0
  %data_mask = extractvalue {<n x 2 x double>, <n x 2 x i1>} %load, 1
  call void @llvm.masked.store.nxv2f64(<n x 2 x double> %data, <n x 2 x double> *%b, i32 8, <n x 2 x i1> %data_mask)
  ret void
}

;; First Faulting Masked Loads - nx4xT

declare {<n x 4 x i8>, <n x 4 x i1>} @llvm.masked.spec.load.nxv4i8(<n x 4 x i8>*, i32, <n x 4 x i1>, <n x 4 x i8>)
declare {<n x 4 x i16>, <n x 4 x i1>} @llvm.masked.spec.load.nxv4i16(<n x 4 x i16>*, i32, <n x 4 x i1>, <n x 4 x i16>)
declare {<n x 4 x i32>, <n x 4 x i1>} @llvm.masked.spec.load.nxv4i32(<n x 4 x i32>*, i32, <n x 4 x i1>, <n x 4 x i32>)
declare {<n x 4 x float>, <n x 4 x i1>} @llvm.masked.spec.load.nxv4f32(<n x 4 x float>*, i32, <n x 4 x i1>, <n x 4 x float>)

define void @masked_spec_load_nxv4i8(<n x 4 x i8> *%a, <n x 4 x i8> *%b) {
; CHECK-LABEL: masked_spec_load_nxv4i8:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: setffr
; CHECK: ldff1b {[[DATA:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1b {[[DATA]].s}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %load = call {<n x 4 x i8>, <n x 4 x i1>} @llvm.masked.spec.load.nxv4i8(<n x 4 x i8> *%a, i32 1, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  %data = extractvalue {<n x 4 x i8>, <n x 4 x i1>} %load, 0
  %data_mask = extractvalue {<n x 4 x i8>, <n x 4 x i1>} %load, 1
  call void @llvm.masked.store.nxv4i8(<n x 4 x i8> %data, <n x 4 x i8> *%b, i32 1, <n x 4 x i1> %data_mask)
  ret void
}

define void @masked_spec_load_nxv4i16(<n x 4 x i16> *%a, <n x 4 x i16> *%b) {
; CHECK-LABEL: masked_spec_load_nxv4i16:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: setffr
; CHECK: ldff1h {[[DATA:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1h {[[DATA]].s}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %load = call {<n x 4 x i16>, <n x 4 x i1>} @llvm.masked.spec.load.nxv4i16(<n x 4 x i16> *%a, i32 2, <n x 4 x i1> %mask, <n x 4 x i16> undef)
  %data = extractvalue {<n x 4 x i16>, <n x 4 x i1>} %load, 0
  %data_mask = extractvalue {<n x 4 x i16>, <n x 4 x i1>} %load, 1
  call void @llvm.masked.store.nxv4i16(<n x 4 x i16> %data, <n x 4 x i16> *%b, i32 2, <n x 4 x i1> %data_mask)
  ret void
}

define void @masked_spec_load_nxv4i32(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: masked_spec_load_nxv4i32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: setffr
; CHECK: ldff1w {[[DATA:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1w {[[DATA]].s}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %load = call {<n x 4 x i32>, <n x 4 x i1>} @llvm.masked.spec.load.nxv4i32(<n x 4 x i32> *%a, i32 4, <n x 4 x i1> %mask, <n x 4 x i32> undef)
  %data = extractvalue {<n x 4 x i32>, <n x 4 x i1>} %load, 0
  %data_mask = extractvalue {<n x 4 x i32>, <n x 4 x i1>} %load, 1
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %data, <n x 4 x i32> *%b, i32 4, <n x 4 x i1> %data_mask)
  ret void
}

define void @masked_spec_load_nxv4f32(<n x 4 x float> *%a, <n x 4 x float> *%b) {
; CHECK-LABEL: masked_spec_load_nxv4f32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: setffr
; CHECK: ldff1w {[[DATA:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1w {[[DATA]].s}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %load = call {<n x 4 x float>, <n x 4 x i1>} @llvm.masked.spec.load.nxv4f32(<n x 4 x float> *%a, i32 4, <n x 4 x i1> %mask, <n x 4 x float> undef)
  %data = extractvalue {<n x 4 x float>, <n x 4 x i1>} %load, 0
  %data_mask = extractvalue {<n x 4 x float>, <n x 4 x i1>} %load, 1
  call void @llvm.masked.store.nxv4f32(<n x 4 x float> %data, <n x 4 x float> *%b, i32 4, <n x 4 x i1> %data_mask)
  ret void
}

;; First Faulting Masked Loads - nx8xT

declare {<n x 8 x i8>, <n x 8 x i1>} @llvm.masked.spec.load.nxv8i8(<n x 8 x i8>*, i32, <n x 8 x i1>, <n x 8 x i8>)
declare {<n x 8 x i16>, <n x 8 x i1>} @llvm.masked.spec.load.nxv8i16(<n x 8 x i16>*, i32, <n x 8 x i1>, <n x 8 x i16>)

define void @masked_spec_load_nxv8i8(<n x 8 x i8> *%a, <n x 8 x i8> *%b) {
; CHECK-LABEL: masked_spec_load_nxv8i8:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: setffr
; CHECK: ldff1b {[[DATA:z[0-9]+]].h}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1b {[[DATA]].h}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %load = call {<n x 8 x i8>, <n x 8 x i1>} @llvm.masked.spec.load.nxv8i8(<n x 8 x i8> *%a, i32 1, <n x 8 x i1> %mask, <n x 8 x i8> undef)
  %data = extractvalue {<n x 8 x i8>, <n x 8 x i1>} %load, 0
  %data_mask = extractvalue {<n x 8 x i8>, <n x 8 x i1>} %load, 1
  call void @llvm.masked.store.nxv8i8(<n x 8 x i8> %data, <n x 8 x i8> *%b, i32 1, <n x 8 x i1> %data_mask)
  ret void
}

define void @masked_spec_load_nxv8i16(<n x 8 x i16> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: masked_spec_load_nxv8i16:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: setffr
; CHECK: ldff1h {[[DATA:z[0-9]+]].h}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1h {[[DATA]].h}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %load = call {<n x 8 x i16>, <n x 8 x i1>} @llvm.masked.spec.load.nxv8i16(<n x 8 x i16> *%a, i32 2, <n x 8 x i1> %mask, <n x 8 x i16> undef)
  %data = extractvalue {<n x 8 x i16>, <n x 8 x i1>} %load, 0
  %data_mask = extractvalue {<n x 8 x i16>, <n x 8 x i1>} %load, 1
  call void @llvm.masked.store.nxv8i16(<n x 8 x i16> %data, <n x 8 x i16> *%b, i32 2, <n x 8 x i1> %data_mask)
  ret void
}

;; First Faulting Masked Loads - nx16xT

declare {<n x 16 x i8>, <n x 16 x i1>} @llvm.masked.spec.load.nxv16i8(<n x 16 x i8>*, i32, <n x 16 x i1>, <n x 16 x i8>)

define void @masked_spec_load_nxv16i8(<n x 16 x i8> *%a, <n x 16 x i8> *%b) {
; CHECK-LABEL: masked_spec_load_nxv16i8:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: setffr
; CHECK: ldff1b {[[DATA:z[0-9]+]].b}, [[PG]]/z, [x0]
; CHECK: rdffr [[FFR:p[0-9]+]].b, [[PG]]
; CHECK: st1b {[[DATA]].b}, [[FFR]], [x1]
; CHECK: ret
  %bit = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 16 x i1> %bit, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer

  %load = call {<n x 16 x i8>, <n x 16 x i1>} @llvm.masked.spec.load.nxv16i8(<n x 16 x i8> *%a, i32 1, <n x 16 x i1> %mask, <n x 16 x i8> undef)
  %data = extractvalue {<n x 16 x i8>, <n x 16 x i1>} %load, 0
  %data_mask = extractvalue {<n x 16 x i8>, <n x 16 x i1>} %load, 1
  call void @llvm.masked.store.nxv16i8(<n x 16 x i8> %data, <n x 16 x i8> *%b, i32 1, <n x 16 x i1> %data_mask)
  ret void
}


;; First faulting masked load with no predication dependencies (plants
;; 2 setffr to clear the FFR before each load)
declare double @llvm.aarch64.sve.fadda.f64.nxv2i1.nxv2f64(<n x 2 x i1>, double, <n x 2 x double>)

define double @two_loads(<n x 2 x double> *%A, <n x 2 x double> *%B, <n x 2 x i1> *%Pgp) #0 {
; CHECK-LABEL: two_loads
; CHECK: setffr
; CHECK: ldff
; CHECK: setffr
; CHECK: ldff
  %Pg = load <n x 2 x i1>, <n x 2 x i1>* %Pgp
  %vA_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %A, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vA = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vA_load, 0
  %vA_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vA_load, 1
  %predA = and <n x 2 x i1> %Pg, %vA_FFR
  %vB_load = call { <n x 2 x double>, <n x 2 x i1> } @llvm.masked.spec.load.nxv2f64(<n x 2 x double>* %B, i32 8, <n x 2 x i1> %Pg, <n x 2 x double> undef)
  %vB = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vB_load, 0
  %vB_FFR = extractvalue { <n x 2 x double>, <n x 2 x i1> } %vB_load, 1
  %predB = and <n x 2 x i1> %Pg, %vB_FFR
  %sum_A = call double @llvm.aarch64.sve.fadda.f64.nxv2i1.nxv2f64(<n x 2 x i1> %predA, double 0.0, <n x 2 x double> %vA)
  %sum_B = call double @llvm.aarch64.sve.fadda.f64.nxv2i1.nxv2f64(<n x 2 x i1> %predB, double 0.0, <n x 2 x double> %vB)
  %div = fdiv double %sum_A, %sum_B
  ret double %div
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Split of masked loads and stores
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define void @masked_load_store_nxv16i64_split(<n x 16 x i64> *%a, <n x 16 x i64> *%b) {
; CHECK-LABEL: masked_load_store_nxv16i64_split:
; CHECK-DAG: ld1d {[[Z0:z[0-9]+]].d}, [[P0:p[0-9]+]]/z, [x0]
; CHECK-DAG: ld1d {[[Z1:z[0-9]+]].d}, [[P1:p[0-9]+]]/z, [x0, #1, mul vl]
; CHECK-DAG: ld1d {[[Z2:z[0-9]+]].d}, [[P2:p[0-9]+]]/z, [x0, #2, mul vl]
; CHECK-DAG: ld1d {[[Z3:z[0-9]+]].d}, [[P3:p[0-9]+]]/z, [x0, #3, mul vl]
; CHECK-DAG: ld1d {[[Z4:z[0-9]+]].d}, [[P4:p[0-9]+]]/z, [x0, #4, mul vl]
; CHECK-DAG: ld1d {[[Z5:z[0-9]+]].d}, [[P5:p[0-9]+]]/z, [x0, #5, mul vl]
; CHECK-DAG: ld1d {[[Z6:z[0-9]+]].d}, [[P6:p[0-9]+]]/z, [x0, #6, mul vl]
; CHECK-DAG: ld1d {[[Z7:z[0-9]+]].d}, [[P7:p[0-9]+]]/z, [x0, #7, mul vl]
; CHECK-DAG: st1d {[[Z0]].d}, [[P0]], [x1]
; CHECK-DAG: st1d {[[Z1]].d}, [[P1]], [x1, #1, mul vl]
; CHECK-DAG: st1d {[[Z2]].d}, [[P2]], [x1, #2, mul vl]
; CHECK-DAG: st1d {[[Z3]].d}, [[P3]], [x1, #3, mul vl]
; CHECK-DAG: st1d {[[Z4]].d}, [[P4]], [x1, #4, mul vl]
; CHECK-DAG: st1d {[[Z5]].d}, [[P5]], [x1, #5, mul vl]
; CHECK-DAG: st1d {[[Z6]].d}, [[P6]], [x1, #6, mul vl]
; CHECK-DAG: st1d {[[Z7]].d}, [[P7]], [x1, #7, mul vl]
; CHECK-DAG: ret
  %bit = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 16 x i1> %bit, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  %vals = call <n x 16 x i64> @llvm.masked.load.nxv16i64(<n x 16 x i64> *%a, i32 1, <n x 16 x i1> %mask, <n x 16 x i64> undef)
  call void @llvm.masked.store.nxv16i64(<n x 16 x i64> %vals, <n x 16 x i64> *%b, i32 1, <n x 16 x i1> %mask)
  ret void
}

declare void @llvm.masked.store.nxv16i32(<n x 16 x i32> , <n x 16 x i32> *, i32 , <n x 16 x i1>)

define void @masked_load_store_nxv16i64_trunc_split_load(<n x 16 x i64> *%a, <n x 16 x i32> *%b) {
; CHECK-LABEL: masked_load_store_nxv16i64_trunc_split_load:
; CHECK-DAG: ld1d {z{{[0-9]+}}.d}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: ld1d {z{{[0-9]+}}.d}, p{{[0-9]+}}/z, [x0, #1, mul vl]
; CHECK-DAG: ld1d {z{{[0-9]+}}.d}, p{{[0-9]+}}/z, [x0, #2, mul vl]
; CHECK-DAG: ld1d {z{{[0-9]+}}.d}, p{{[0-9]+}}/z, [x0, #3, mul vl]
; CHECK-DAG: ld1d {z{{[0-9]+}}.d}, p{{[0-9]+}}/z, [x0, #4, mul vl]
; CHECK-DAG: ld1d {z{{[0-9]+}}.d}, p{{[0-9]+}}/z, [x0, #5, mul vl]
; CHECK-DAG: ld1d {z{{[0-9]+}}.d}, p{{[0-9]+}}/z, [x0, #6, mul vl]
; CHECK-DAG: ld1d {z{{[0-9]+}}.d}, p{{[0-9]+}}/z, [x0, #7, mul vl]
; CHECK-DAG: st1w {z{{[0-9]+}}.s}, p{{[0-9]+}}, [x1]
; CHECK-DAG: st1w {z{{[0-9]+}}.s}, p{{[0-9]+}}, [x1, #1, mul vl]
; CHECK-DAG: st1w {z{{[0-9]+}}.s}, p{{[0-9]+}}, [x1, #2, mul vl]
; CHECK-DAG: st1w {z{{[0-9]+}}.s}, p{{[0-9]+}}, [x1, #3, mul vl]
; CHECK-DAG: ret
  %bit = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 16 x i1> %bit, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  %vals = call <n x 16 x i64> @llvm.masked.load.nxv16i64(<n x 16 x i64> *%a, i32 1, <n x 16 x i1> %mask, <n x 16 x i64> undef)
  %vals32 = trunc <n x 16 x i64> %vals to <n x 16 x i32>
  call void @llvm.masked.store.nxv16i32(<n x 16 x i32> %vals32, <n x 16 x i32> *%b, i32 1, <n x 16 x i1> %mask)
  ret void
}

declare <n x 16 x i32> @llvm.masked.load.nxv16i32(<n x 16 x i32> *, i32 , <n x 16 x i1> , <n x 16 x i32> )

define void @masked_load_store_nxv16i32_zext_split_load(<n x 16 x i32> *%a, <n x 16 x i64> *%b) {
; CHECK-LABEL: masked_load_store_nxv16i32_zext_split_load:
; CHECK-DAG: ld1w {z{{[0-9]+}}.s}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: ld1w {z{{[0-9]+}}.s}, p{{[0-9]+}}/z, [x0, #1, mul vl]
; CHECK-DAG: ld1w {z{{[0-9]+}}.s}, p{{[0-9]+}}/z, [x0, #2, mul vl]
; CHECK-DAG: ld1w {z{{[0-9]+}}.s}, p{{[0-9]+}}/z, [x0, #3, mul vl]
; CHECK-DAG: st1d {z{{[0-9]+}}.d}, p{{[0-9]+}}, [x1]
; CHECK-DAG: st1d {z{{[0-9]+}}.d}, p{{[0-9]+}}, [x1, #1, mul vl]
; CHECK-DAG: st1d {z{{[0-9]+}}.d}, p{{[0-9]+}}, [x1, #2, mul vl]
; CHECK-DAG: st1d {z{{[0-9]+}}.d}, p{{[0-9]+}}, [x1, #3, mul vl]
; CHECK-DAG: st1d {z{{[0-9]+}}.d}, p{{[0-9]+}}, [x1, #4, mul vl]
; CHECK-DAG: st1d {z{{[0-9]+}}.d}, p{{[0-9]+}}, [x1, #5, mul vl]
; CHECK-DAG: st1d {z{{[0-9]+}}.d}, p{{[0-9]+}}, [x1, #6, mul vl]
; CHECK-DAG: st1d {z{{[0-9]+}}.d}, p{{[0-9]+}}, [x1, #7, mul vl]
; CHECK-DAG: ret
  %bit = insertelement <n x 16 x i1> undef, i1 1, i64 0
  %mask = shufflevector <n x 16 x i1> %bit, <n x 16 x i1> undef, <n x 16 x i64> zeroinitializer
  %vals = call <n x 16 x i32> @llvm.masked.load.nxv16i32(<n x 16 x i32> *%a, i32 1, <n x 16 x i1> %mask, <n x 16 x i32> undef)
  %vals32 = zext <n x 16 x i32> %vals to <n x 16 x i64>
  call void @llvm.masked.store.nxv16i64(<n x 16 x i64> %vals32, <n x 16 x i64> *%b, i32 1, <n x 16 x i1> %mask)
  ret void
}

