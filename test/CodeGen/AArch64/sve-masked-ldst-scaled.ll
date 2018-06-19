; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

;; Gather Loads/Scatter Stores - nx2xT with 64bit scaled offsets

;;TODO: These test can be simplified when we update to the new getelementptr format

define void @masked_gather_scatter_nxv2i16(i16* %a, <n x 2 x i64>* %b) {
; CHECK-LABEL: masked_gather_scatter_nxv2i16:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: index [[OFFSETS:z[0-9]+]].d, #0, #1
; CHECK: ld1sh {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, [[OFFSETS]].d, lsl #1]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1h {[[OUT]].d}, [[PG]], [x0, [[OFFSETS]].d, lsl #1]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 true, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %indices = add <n x 2 x i64> %5, %3
  %ptrs = getelementptr i16, i16* %a, <n x 2 x i64> %indices
  %in_vals = call <n x 2 x i16> @llvm.masked.gather.nxv2i16.nxv2p0i16(<n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask, <n x 2 x i16> undef)
  %out_vals = add <n x 2 x i16> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2i16.nxv2p0i16(<n x 2 x i16> %out_vals, <n x 2 x i16*> %ptrs, i32 2, <n x 2 x i1> %mask)
  ret void
}

define void @masked_gather_scatter_nxv2i32(i32* %a, <n x 2 x i64>* %b) {
; CHECK-LABEL: masked_gather_scatter_nxv2i32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: index [[OFFSETS:z[0-9]+]].d, #0, #1
; CHECK: ld1sw {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, [[OFFSETS]].d, lsl #2]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1w {[[OUT]].d}, [[PG]], [x0, [[OFFSETS]].d, lsl #2]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 true, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %indices = add <n x 2 x i64> %5, %3
  %ptrs = getelementptr i32, i32* %a, <n x 2 x i64> %indices
  %in_vals = call <n x 2 x i32> @llvm.masked.gather.nxv2i32.nxv2p0i32(<n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x i32> undef)
  %out_vals = add <n x 2 x i32> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2i32.nxv2p0i32(<n x 2 x i32> %out_vals, <n x 2 x i32*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_gather_scatter_nxv2i64(i64* %a, <n x 2 x i64>* %b) {
; CHECK-LABEL: masked_gather_scatter_nxv2i64:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: index [[OFFSETS:z[0-9]+]].d, #0, #1
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, [[OFFSETS]].d, lsl #3]
; CHECK: add [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1d {[[OUT]].d}, [[PG]], [x0, [[OFFSETS]].d, lsl #3]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 true, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %indices = add <n x 2 x i64> %5, %3
  %ptrs = getelementptr i64, i64* %a, <n x 2 x i64> %indices
  %in_vals = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x i64> undef)
  %out_vals = add <n x 2 x i64> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %out_vals, <n x 2 x i64*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

define void @masked_gather_scatter_nxv2f32(float* %a, <n x 2 x i64>* %b) {
; CHECK-LABEL: masked_gather_scatter_nxv2f32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: index [[OFFSETS:z[0-9]+]].d, #0, #1
; CHECK: ld1w {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, [[OFFSETS]].d, lsl #2]
; CHECK: fadd [[OUT:z[0-9]+]].s, [[IN]].s, [[IN]].s
; CHECK: st1w {[[OUT]].d}, [[PG]], [x0, [[OFFSETS]].d, lsl #2]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 true, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %indices = add <n x 2 x i64> %5, %3
  %ptrs = getelementptr float, float* %a, <n x 2 x i64> %indices
  %in_vals = call <n x 2 x float> @llvm.masked.gather.nxv2f32.nxv2p0f32(<n x 2 x float*> %ptrs, i32 4, <n x 2 x i1> %mask, <n x 2 x float> undef)
  %out_vals = fadd <n x 2 x float> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2f32.nxv2p0f32(<n x 2 x float> %out_vals, <n x 2 x float*> %ptrs, i32 4, <n x 2 x i1> %mask)
  ret void
}

define void @masked_gather_scatter_nxv2f64(double* %a, <n x 2 x i64>* %b) {
; CHECK-LABEL: masked_gather_scatter_nxv2f64:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: index [[OFFSETS:z[0-9]+]].d, #0, #1
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, [[OFFSETS]].d, lsl #3]
; CHECK: fadd [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1d {[[OUT]].d}, [[PG]], [x0, [[OFFSETS]].d, lsl #3]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 true, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %indices = add <n x 2 x i64> %5, %3
  %ptrs = getelementptr double, double* %a, <n x 2 x i64> %indices
  %in_vals = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x double> undef)
  %out_vals = fadd <n x 2 x double> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %out_vals, <n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

;; Gather Loads/Scatter Stores - nx2xT with 32bit signed scaled offsets

define void @masked_gather_scatter_nxv2f64_os32(double* %a, <n x 2 x i32>* %b) {
; CHECK-LABEL: masked_gather_scatter_nxv2f64_os32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: index [[OFFSETS:z[0-9]+]].d, #0, #1
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, [[OFFSETS]].d, sxtw #3]
; CHECK: fadd [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1d {[[OUT]].d}, [[PG]], [x0, [[OFFSETS]].d, sxtw #3]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 true, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i32> undef, i32 1, i32 0
  %2 = shufflevector <n x 2 x i32> %1, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i32> %2, stepvector
  %4 = insertelement <n x 2 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 2 x i32> %4, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %indices = add <n x 2 x i32> %5, %3
  %ptrs = getelementptr double, double* %a, <n x 2 x i32> %indices
  %in_vals = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x double> undef)
  %out_vals = fadd <n x 2 x double> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %out_vals, <n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

;; Gather Loads/Scatter Stores - nx2xT with 32bit unsigned scaled offsets

define void @masked_gather_scatter_nxv2f64_ou32(double* %a, <n x 2 x i32>* %b) {
; CHECK-LABEL: masked_gather_scatter_nxv2f64_ou32:
; CHECK-DAG: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: index [[OFFSETS:z[0-9]+]].d, #0, #1
; CHECK: ld1d {[[IN:z[0-9]+]].d}, [[PG]]/z, [x0, [[OFFSETS]].d, uxtw #3]
; CHECK: fadd [[OUT:z[0-9]+]].d, [[IN]].d, [[IN]].d
; CHECK: st1d {[[OUT]].d}, [[PG]], [x0, [[OFFSETS]].d, uxtw #3]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 true, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i32> undef, i32 1, i32 0
  %2 = shufflevector <n x 2 x i32> %1, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i32> %2, stepvector
  %4 = insertelement <n x 2 x i32> undef, i32 0, i32 0
  %5 = shufflevector <n x 2 x i32> %4, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %raw_indices = add <n x 2 x i32> %5, %3
  %indices = zext <n x 2 x i32> %raw_indices to <n x 2 x i64>
  %ptrs = getelementptr double, double* %a, <n x 2 x i64> %indices
  %in_vals = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask, <n x 2 x double> undef)
  %out_vals = fadd <n x 2 x double> %in_vals, %in_vals
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %out_vals, <n x 2 x double*> %ptrs, i32 8, <n x 2 x i1> %mask)
  ret void
}

; Function Attrs: nounwind readonly
declare <n x 2 x i16> @llvm.masked.gather.nxv2i16.nxv2p0i16(<n x 2 x i16*>, i32, <n x 2 x i1>, <n x 2 x i16>) #0

; Function Attrs: nounwind readonly
declare <n x 2 x i32> @llvm.masked.gather.nxv2i32.nxv2p0i32(<n x 2 x i32*>, i32, <n x 2 x i1>, <n x 2 x i32>) #0

; Function Attrs: nounwind readonly
declare <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*>, i32, <n x 2 x i1>, <n x 2 x i64>) #0

; Function Attrs: nounwind readonly
declare <n x 2 x float> @llvm.masked.gather.nxv2f32.nxv2p0f32(<n x 2 x float*>, i32, <n x 2 x i1>, <n x 2 x float>) #0

; Function Attrs: nounwind readonly
declare <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*>, i32, <n x 2 x i1>, <n x 2 x double>) #0

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv2i16.nxv2p0i16(<n x 2 x i16>, <n x 2 x i16*>, i32, <n x 2 x i1>) #1

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv2i32.nxv2p0i32(<n x 2 x i32>, <n x 2 x i32*>, i32, <n x 2 x i1>) #1

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64>, <n x 2 x i64*>, i32, <n x 2 x i1>) #1

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv2f32.nxv2p0f32(<n x 2 x float>, <n x 2 x float*>, i32, <n x 2 x i1>) #1

; Function Attrs: nounwind
declare void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double>, <n x 2 x double*>, i32, <n x 2 x i1>) #1

attributes #0 = { nounwind readonly }
attributes #1 = { nounwind }
