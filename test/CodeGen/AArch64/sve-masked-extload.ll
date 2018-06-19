; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

;; Masked Signed Loads - nx2xT

declare <n x 2 x i8> @llvm.masked.load.nxv2i8(<n x 2 x i8>*, i32, <n x 2 x i1>, <n x 2 x i8>)
declare <n x 2 x i16> @llvm.masked.load.nxv2i16(<n x 2 x i16>*, i32, <n x 2 x i1>, <n x 2 x i16>)
declare <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32>*, i32, <n x 2 x i1>, <n x 2 x i32>)

declare void @llvm.masked.store.nxv2i64(<n x 2 x i64>, <n x 2 x i64>*, i32, <n x 2 x i1>)

define void @masked_sload_nxv2i8(<n x 2 x i8> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: masked_sload_nxv2i8:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: ld1sb {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK-NEXT: st1d {[[IN]].d}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %in_vals = call <n x 2 x i8> @llvm.masked.load.nxv2i8(<n x 2 x i8> *%a, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  %out_vals = sext <n x 2 x i8> %in_vals to <n x 2 x i64>
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %out_vals, <n x 2 x i64> *%b, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_sload_nxv2i8_two_regs(i8 *%a, <n x 2 x i64> *%b, i64 %idx) {
; CHECK-LABEL: masked_sload_nxv2i8_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: ld1sb {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, x2]
; CHECK-NEXT: st1d {[[IN]].d}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %addr = getelementptr i8, i8* %a, i64 %idx
  %vaddr = bitcast i8 * %addr to <n x 2 x i8> *
  %in_vals = call <n x 2 x i8> @llvm.masked.load.nxv2i8(<n x 2 x i8> *%vaddr, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  %out_vals = sext <n x 2 x i8> %in_vals to <n x 2 x i64>
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %out_vals, <n x 2 x i64> *%b, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_sload_nxv2i16(<n x 2 x i16> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: masked_sload_nxv2i16:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: ld1sh {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK-NEXT: st1d {[[IN]].d}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %in_vals = call <n x 2 x i16> @llvm.masked.load.nxv2i16(<n x 2 x i16> *%a, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  %out_vals = sext <n x 2 x i16> %in_vals to <n x 2 x i64>
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %out_vals, <n x 2 x i64> *%b, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_sload_nxv2i16_two_regs(i16 *%a, <n x 2 x i64> *%b, i64 %idx) {
; CHECK-LABEL: masked_sload_nxv2i16_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: ld1sh {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, x2, lsl #1]
; CHECK-NEXT: st1d {[[IN]].d}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %addr = getelementptr i16, i16* %a, i64 %idx
  %vaddr = bitcast i16 * %addr to <n x 2 x i16> *
  %in_vals = call <n x 2 x i16> @llvm.masked.load.nxv2i16(<n x 2 x i16> *%vaddr, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  %out_vals = sext <n x 2 x i16> %in_vals to <n x 2 x i64>
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %out_vals, <n x 2 x i64> *%b, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_sload_nxv2i32(<n x 2 x i32> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: masked_sload_nxv2i32:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: ld1sw {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0]
; CHECK-NEXT: st1d {[[IN]].d}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %in_vals = call <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32> *%a, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  %out_vals = sext <n x 2 x i32> %in_vals to <n x 2 x i64>
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %out_vals, <n x 2 x i64> *%b, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_sload_nxv2i32_two_regs(i32 *%a, <n x 2 x i64> *%b, i64 %idx) {
; CHECK-LABEL: masked_sload_nxv2i32_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: ld1sw {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, x2, lsl #2]
; CHECK-NEXT: st1d {[[IN]].d}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %addr = getelementptr i32, i32* %a, i64 %idx
  %vaddr = bitcast i32 * %addr to <n x 2 x i32> *
  %in_vals = call <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32> *%vaddr, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  %out_vals = sext <n x 2 x i32> %in_vals to <n x 2 x i64>
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %out_vals, <n x 2 x i64> *%b, i32 8, <n x 2 x i1> %mask)
  ret void
}

;; Masked Signed - nx4xT

declare <n x 4 x i8> @llvm.masked.load.nxv4i8(<n x 4 x i8>*, i32, <n x 4 x i1>, <n x 4 x i8>)
declare <n x 4 x i16> @llvm.masked.load.nxv4i16(<n x 4 x i16>*, i32, <n x 4 x i1>, <n x 4 x i16>)

declare void @llvm.masked.store.nxv4i32(<n x 4 x i32>, <n x 4 x i32>*, i32, <n x 4 x i1>)

define void @masked_sload_nxv4i8(<n x 4 x i8> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: masked_sload_nxv4i8:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: ld1sb {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK-NEXT: st1w {[[IN]].s}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %in_vals = call <n x 4 x i8> @llvm.masked.load.nxv4i8(<n x 4 x i8> *%a, i32 4, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  %out_vals = sext <n x 4 x i8> %in_vals to <n x 4 x i32>
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %out_vals, <n x 4 x i32> *%b, i32 4, <n x 4 x i1> %mask)
  ret void
}

define void @masked_sload_nxv4i8_two_regs(i8*%a, <n x 4 x i32> *%b, i64 %idx) {
; CHECK-LABEL: masked_sload_nxv4i8_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: ld1sb {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0, x2]
; CHECK-NEXT: st1w {[[IN]].s}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %addr = getelementptr i8, i8* %a, i64 %idx
  %vaddr = bitcast i8 * %addr to <n x 4 x i8> *
  %in_vals = call <n x 4 x i8> @llvm.masked.load.nxv4i8(<n x 4 x i8> *%vaddr, i32 4, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  %out_vals = sext <n x 4 x i8> %in_vals to <n x 4 x i32>
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %out_vals, <n x 4 x i32> *%b, i32 4, <n x 4 x i1> %mask)
  ret void
}

define void @masked_sload_nxv4i16(<n x 4 x i16> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: masked_sload_nxv4i16:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: ld1sh {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0]
; CHECK-NEXT: st1w {[[IN]].s}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %in_vals = call <n x 4 x i16> @llvm.masked.load.nxv4i16(<n x 4 x i16> *%a, i32 4, <n x 4 x i1> %mask, <n x 4 x i16> undef)
  %out_vals = sext <n x 4 x i16> %in_vals to <n x 4 x i32>
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %out_vals, <n x 4 x i32> *%b, i32 4, <n x 4 x i1> %mask)  ret void
}

define void @masked_sload_nxv4i16_two_regs(i16 *%a, <n x 4 x i32> *%b, i64 %idx) {
; CHECK-LABEL: masked_sload_nxv4i16_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: ld1sh {[[IN:z[0-9]+]].s}, [[PG]]/z, [x0, x2, lsl #1]
; CHECK-NEXT: st1w {[[IN]].s}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %addr = getelementptr i16, i16* %a, i64 %idx
  %vaddr = bitcast i16 * %addr to <n x 4 x i16> *
  %in_vals = call <n x 4 x i16> @llvm.masked.load.nxv4i16(<n x 4 x i16> *%vaddr, i32 4, <n x 4 x i1> %mask, <n x 4 x i16> undef)
  %out_vals = sext <n x 4 x i16> %in_vals to <n x 4 x i32>
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %out_vals, <n x 4 x i32> *%b, i32 4, <n x 4 x i1> %mask)  ret void
}

;; Masked Signed Loads - nx8xT

declare <n x 8 x i8> @llvm.masked.load.nxv8i8(<n x 8 x i8>*, i32, <n x 8 x i1>, <n x 8 x i8>)
declare <n x 8 x i16> @llvm.masked.load.nxv8i16(<n x 8 x i16>*, i32, <n x 8 x i1>, <n x 8 x i16>)

declare void @llvm.masked.store.nxv8i16(<n x 8 x i16>, <n x 8 x i16>*, i32, <n x 8 x i1>)

define void @masked_sload_nxv8i8(<n x 8 x i8> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: masked_sload_nxv8i8:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: ld1sb {[[IN:z[0-9]+]].h}, [[PG]]/z, [x0]
; CHECK-NEXT: st1h {[[IN]].h}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %in_vals = call <n x 8 x i8> @llvm.masked.load.nxv8i8(<n x 8 x i8> *%a, i32 2, <n x 8 x i1> %mask, <n x 8 x i8> undef)
  %out_vals = sext <n x 8 x i8> %in_vals to <n x 8 x i16>
  call void @llvm.masked.store.nxv8i16(<n x 8 x i16> %out_vals, <n x 8 x i16> *%b, i32 2, <n x 8 x i1> %mask)
  ret void
}

define void @masked_sload_nxv8i8_two_regs(i8 *%a, <n x 8 x i16> *%b, i64 %idx) {
; CHECK-LABEL: masked_sload_nxv8i8_two_regs:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: ld1sb {[[IN:z[0-9]+]].h}, [[PG]]/z, [x0, x2]
; CHECK-NEXT: st1h {[[IN]].h}, [[PG]], [x1]
; CHECK-NEXT: ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %addr = getelementptr i8, i8* %a, i64 %idx
  %vaddr = bitcast i8 * %addr to <n x 8 x i8> *
  %in_vals = call <n x 8 x i8> @llvm.masked.load.nxv8i8(<n x 8 x i8> *%vaddr, i32 2, <n x 8 x i1> %mask, <n x 8 x i8> undef)
  %out_vals = sext <n x 8 x i8> %in_vals to <n x 8 x i16>
  call void @llvm.masked.store.nxv8i16(<n x 8 x i16> %out_vals, <n x 8 x i16> *%b, i32 2, <n x 8 x i1> %mask)
  ret void
}

;; Check zero-extended loads also get folded away instead of emitting 'and' instructions
;; to mask the result of a sign-extended load.

define <n x 2 x i64> @masked_zload_nxv2i8(<n x 2 x i8>* %src, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_zload_nxv2i8:
; CHECK-NOT: ld1sb
; CHECK: ld1b {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %vals = call <n x 2 x i8> @llvm.masked.load.nxv2i8(<n x 2 x i8>* %src, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef)
  %zvals = zext <n x 2 x i8> %vals to <n x 2 x i64>
  ret <n x 2 x i64> %zvals
}

define <n x 4 x i32> @masked_zload_nxv4i8(<n x 4 x i8>* %src, <n x 4 x i1> %mask) {
; CHECK-LABEL: masked_zload_nxv4i8:
; CHECK-NOT: ld1sb
; CHECK: ld1b {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %vals = call <n x 4 x i8> @llvm.masked.load.nxv4i8(<n x 4 x i8>* %src, i32 1, <n x 4 x i1> %mask, <n x 4 x i8> undef)
  %zvals = zext <n x 4 x i8> %vals to <n x 4 x i32>
  ret <n x 4 x i32> %zvals
}

define <n x 8 x i16> @masked_zload_nxv8i8(<n x 8 x i8>* %src, <n x 8 x i1> %mask) {
; CHECK-LABEL: masked_zload_nxv8i8:
; CHECK-NOT: ld1sb
; CHECK: ld1b {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %vals = call <n x 8 x i8> @llvm.masked.load.nxv8i8(<n x 8 x i8>* %src, i32 1, <n x 8 x i1> %mask, <n x 8 x i8> undef)
  %zvals = zext <n x 8 x i8> %vals to <n x 8 x i16>
  ret <n x 8 x i16> %zvals
}

define <n x 2 x i64> @masked_zload_nxv2i16(<n x 2 x i16>* %src, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_zload_nxv2i16:
; CHECK-NOT: ld1sh
; CHECK: ld1h {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %vals = call <n x 2 x i16> @llvm.masked.load.nxv2i16(<n x 2 x i16>* %src, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  %zvals = zext <n x 2 x i16> %vals to <n x 2 x i64>
  ret <n x 2 x i64> %zvals
}

define <n x 4 x i32> @masked_zload_nxv4i16(<n x 4 x i16>* %src, <n x 4 x i1> %mask) {
; CHECK-LABEL: masked_zload_nxv4i16:
; CHECK-NOT: ld1sh
; CHECK: ld1h {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %vals = call <n x 4 x i16> @llvm.masked.load.nxv4i16(<n x 4 x i16>* %src, i32 2, <n x 4 x i1> %mask, <n x 4 x i16> undef)
  %zvals = zext <n x 4 x i16> %vals to <n x 4 x i32>
  ret <n x 4 x i32> %zvals
}

define <n x 2 x i64> @masked_zload_nxv2i32(<n x 2 x i32>* %src, <n x 2 x i1> %mask) {
; CHECK-LABEL: masked_zload_nxv2i32:
; CHECK-NOT: ld1sw
; CHECK: ld1w {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %vals = call <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32>* %src, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  %zvals = zext <n x 2 x i32> %vals to <n x 2 x i64>
  ret <n x 2 x i64> %zvals
}
