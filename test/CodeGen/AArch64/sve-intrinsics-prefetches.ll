; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; Testing prfop encodings
;
define void @test_svprf_pldl1strm(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pldl1strm
; CHECK: prfb pldl1strm, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 1)
  ret void
}

define void @test_svprf_pldl2keep(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pldl2keep
; CHECK: prfb pldl2keep, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 2)
  ret void
}

define void @test_svprf_pldl2strm(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pldl2strm
; CHECK: prfb pldl2strm, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 3)
  ret void
}

define void @test_svprf_pldl3keep(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pldl3keep
; CHECK: prfb pldl3keep, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 4)
  ret void
}

define void @test_svprf_pldl3strm(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pldl3strm
; CHECK: prfb pldl3strm, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 5)
  ret void
}

define void @test_svprf_pstl1keep(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pstl1keep
; CHECK: prfb pstl1keep, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 8)
  ret void
}

define void @test_svprf_pstl1strm(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pstl1strm
; CHECK: prfb pstl1strm, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 9)
  ret void
}

define void @test_svprf_pstl2keep(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pstl2keep
; CHECK: prfb pstl2keep, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 10)
  ret void
}

define void @test_svprf_pstl2strm(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pstl2strm
; CHECK: prfb pstl2strm, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 11)
  ret void
}

define void @test_svprf_pstl3keep(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pstl3keep
; CHECK: prfb pstl3keep, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 12)
  ret void
}

define void @test_svprf_pstl3strm(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprf_pstl3strm
; CHECK: prfb pstl3strm, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 13)
  ret void
}

;
; Testing imm limits of SI form
;

define void @test_svprf_vnum_under(<n x 16 x i1> %pg, <n x 16 x i8>* %base) {
; CHECK-LABEL: test_svprf_vnum_under
; CHECK-NOT: prfb pstl3strm, p0, [x0, #-33, mul vl]
entry:
  %gep = getelementptr inbounds <n x 16 x i8>, <n x 16 x i8>* %base, i64 -33, i64 0
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %gep, i32 13)
  ret void
}

define void @test_svprf_vnum_min(<n x 16 x i1> %pg, <n x 16 x i8>* %base) {
; CHECK-LABEL: test_svprf_vnum_min
; CHECK: prfb pstl3strm, p0, [x0, #-32, mul vl]
entry:
  %gep = getelementptr inbounds <n x 16 x i8>, <n x 16 x i8>* %base, i64 -32, i64 0
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %gep, i32 13)
  ret void
}

define void @test_svprf_vnum_over(<n x 16 x i1> %pg, <n x 16 x i8>* %base) {
; CHECK-LABEL: test_svprf_vnum_over
; CHECK-NOT: prfb pstl3strm, p0, [x0, #32, mul vl]
entry:
  %gep = getelementptr inbounds <n x 16 x i8>, <n x 16 x i8>* %base, i64 32, i64 0
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %gep, i32 13)
  ret void
}

define void @test_svprf_vnum_max(<n x 16 x i1> %pg, <n x 16 x i8>* %base) {
; CHECK-LABEL: test_svprf_vnum_max
; CHECK: prfb pstl3strm, p0, [x0, #31, mul vl]
entry:
  %gep = getelementptr inbounds <n x 16 x i8>, <n x 16 x i8>* %base, i64 31, i64 0
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %gep, i32 13)
  ret void
}

;
; scalar contiguous
;

define void @test_svprfb(<n x 16 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprfb
; CHECK: prfb pldl1keep, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %base, i32 0)
  ret void
}

define void @test_svprfh(<n x 8 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprfh
; CHECK: prfh pldl1keep, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv8i1(<n x 8 x i1> %pg, i8* %base, i32 0)
  ret void
}

define void @test_svprfw(<n x 4 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprfw
; CHECK: prfw pldl1keep, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv4i1(<n x 4 x i1> %pg, i8* %base, i32 0)
  ret void
}

define void @test_svprfd(<n x 2 x i1> %pg, i8* %base) {
; CHECK-LABEL: test_svprfd
; CHECK: prfd pldl1keep, p0, [x0]
entry:
  tail call void @llvm.aarch64.sve.prf.nxv2i1(<n x 2 x i1> %pg, i8* %base, i32 0)
  ret void
}

;
; scalar + imm contiguous
;
; imm form of prfb is tested above

define void @test_svprfh_vnum(<n x 8 x i1> %pg, <n x 8 x i16>* %base) {
; CHECK-LABEL: test_svprfh_vnum
; CHECK: prfh pstl3strm, p0, [x0, #31, mul vl]
entry:
  %gep = getelementptr <n x 8 x i16>, <n x 8 x i16>* %base, i64 31
  %addr = bitcast <n x 8 x i16>* %gep to i8*
  tail call void @llvm.aarch64.sve.prf.nxv8i1(<n x 8 x i1> %pg, i8* %addr, i32 13)
  ret void
}

define void @test_svprfw_vnum(<n x 4 x i1> %pg, <n x 4 x i32>* %base) {
; CHECK-LABEL: test_svprfw_vnum
; CHECK: prfw pstl3strm, p0, [x0, #31, mul vl]
entry:
  %gep = getelementptr <n x 4 x i32>, <n x 4 x i32>* %base, i64 31
  %addr = bitcast <n x 4 x i32>* %gep to i8*
  tail call void @llvm.aarch64.sve.prf.nxv4i1(<n x 4 x i1> %pg, i8* %addr, i32 13)
  ret void
}

define void @test_svprfd_vnum(<n x 2 x i1> %pg, <n x 2 x i64>* %base) {
; CHECK-LABEL: test_svprfd_vnum
; CHECK: prfd pstl3strm, p0, [x0, #31, mul vl]
entry:
  %gep = getelementptr <n x 2 x i64>, <n x 2 x i64>* %base, i64 31
  %addr = bitcast <n x 2 x i64>* %gep to i8*
  tail call void @llvm.aarch64.sve.prf.nxv2i1(<n x 2 x i1> %pg, i8* %addr, i32 13)
  ret void
}

;
; scalar + scaled scalar contiguous
;

define void @test_svprfb_ss(<n x 16 x i1> %pg, i8* %base, i64 %offset) {
; CHECK-LABEL: test_svprfb_ss
; CHECK: prfb pstl3strm, p0, [x0, x1]
entry:
  %addr = getelementptr i8, i8* %base, i64 %offset
  tail call void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1> %pg, i8* %addr, i32 13)
  ret void
}

define void @test_svprfh_ss(<n x 8 x i1> %pg, i16* %base, i64 %offset) {
; CHECK-LABEL: test_svprfh_ss
; CHECK: prfh pstl3strm, p0, [x0, x1, lsl #1]
entry:
  %gep = getelementptr i16, i16* %base, i64 %offset
  %addr = bitcast i16* %gep to i8*
  tail call void @llvm.aarch64.sve.prf.nxv8i1(<n x 8 x i1> %pg, i8* %addr, i32 13)
  ret void
}

define void @test_svprfw_ss(<n x 4 x i1> %pg, i32* %base, i64 %offset) {
; CHECK-LABEL: test_svprfw_ss
; CHECK: prfw pstl3strm, p0, [x0, x1, lsl #2]
entry:
  %gep = getelementptr i32, i32* %base, i64 %offset
  %addr = bitcast i32* %gep to i8*
  tail call void @llvm.aarch64.sve.prf.nxv4i1(<n x 4 x i1> %pg, i8* %addr, i32 13)
  ret void
}

define void @test_svprfd_ss(<n x 2 x i1> %pg, i64* %base, i64 %offset) {
; CHECK-LABEL: test_svprfd_ss
; CHECK: prfd pstl3strm, p0, [x0, x1, lsl #3]
entry:
  %gep = getelementptr i64, i64* %base, i64 %offset
  %addr = bitcast i64* %gep to i8*
  tail call void @llvm.aarch64.sve.prf.nxv2i1(<n x 2 x i1> %pg, i8* %addr, i32 13)
  ret void
}


;
; scalar + vector gather - 32-bit scaled offset
;
define void @test_svprfb_u32offset(<n x 4 x i1> %pg, i8* %base, <n x 4 x i32> %offsets) {
; CHECK-LABEL: test_svprfb_u32offset
; CHECK: prfb pstl3strm, p0, [x0, z0.s, uxtw]
entry:
  %i64_offsets = zext <n x 4 x i32> %offsets to <n x 4 x i64>
  tail call void @llvm.aarch64.sve.prfb.gather.nxv4i1(<n x 4 x i1> %pg, i8* %base, <n x 4 x i64> %i64_offsets, i32 13)
  ret void
}

define void @test_svprfh_u32index(<n x 4 x i1> %pg, i8* %base, <n x 4 x i32> %indices) {
; CHECK-LABEL: test_svprfh_u32index
; CHECK: prfh pstl3strm, p0, [x0, z0.s, uxtw #1]
entry:
  %i64_indices = zext <n x 4 x i32> %indices to <n x 4 x i64>
  %offsets = shl <n x 4 x i64> %i64_indices, shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 1, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer)
  tail call void @llvm.aarch64.sve.prfh.gather.nxv4i1(<n x 4 x i1> %pg, i8* %base, <n x 4 x i64> %offsets, i32 13)
  ret void
}

define void @test_svprfw_u32index(<n x 4 x i1> %pg, i8* %base, <n x 4 x i32> %indices) {
; CHECK-LABEL: test_svprfw_u32index
; CHECK: prfw pstl3strm, p0, [x0, z0.s, uxtw #2]
entry:
  %i64_indices = zext <n x 4 x i32> %indices to <n x 4 x i64>
  %offsets = shl <n x 4 x i64> %i64_indices, shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 2, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer)
  tail call void @llvm.aarch64.sve.prfw.gather.nxv4i1(<n x 4 x i1> %pg, i8* %base, <n x 4 x i64> %offsets, i32 13)
  ret void
}

define void @test_svprfd_u32index(<n x 4 x i1> %pg, i8* %base, <n x 4 x i32> %indices) {
; CHECK-LABEL: test_svprfd_u32index
; CHECK: prfd pstl3strm, p0, [x0, z0.s, uxtw #3]
entry:
  %i64_indices = zext <n x 4 x i32> %indices to <n x 4 x i64>
  %offsets = shl <n x 4 x i64> %i64_indices, shufflevector (<n x 4 x i64> insertelement (<n x 4 x i64> undef, i64 3, i32 0), <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer)
  tail call void @llvm.aarch64.sve.prfd.gather.nxv4i1(<n x 4 x i1> %pg, i8* %base, <n x 4 x i64> %offsets, i32 13)
  ret void
}

;
; scalar + vector gather - 32-bit unpacked scaled offset
;
define void @test_svprfb_u32offset_unpacked(<n x 2 x i1> %pg, i8* %base, <n x 2 x i32> %offsets) {
; CHECK-LABEL: test_svprfb_u32offset_unpacked
; CHECK: prfb pstl3strm, p0, [x0, z0.d, uxtw]
entry:
  %i64_offsets = zext <n x 2 x i32> %offsets to <n x 2 x i64>
  tail call void @llvm.aarch64.sve.prfb.gather.nxv2i1(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %i64_offsets, i32 13)
  ret void
}

define void @test_svprfh_u32index_unpacked(<n x 2 x i1> %pg, i8* %base, <n x 2 x i32> %indices) {
; CHECK-LABEL: test_svprfh_u32index_unpacked
; CHECK: prfh pstl3strm, p0, [x0, z0.d, uxtw #1]
entry:
  %i64_indices = zext <n x 2 x i32> %indices to <n x 2 x i64>
  %offsets = shl <n x 2 x i64> %i64_indices, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 1, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  tail call void @llvm.aarch64.sve.prfh.gather.nxv2i1(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %offsets, i32 13)
  ret void
}

define void @test_svprfw_u32index_unpacked(<n x 2 x i1> %pg, i8* %base, <n x 2 x i32> %indices) {
; CHECK-LABEL: test_svprfw_u32index_unpacked
; CHECK: prfw pstl3strm, p0, [x0, z0.d, uxtw #2]
entry:
  %i64_indices = zext <n x 2 x i32> %indices to <n x 2 x i64>
  %offsets = shl <n x 2 x i64> %i64_indices, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 2, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  tail call void @llvm.aarch64.sve.prfw.gather.nxv2i1(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %offsets, i32 13)
  ret void
}

define void @test_svprfd_u32index_unpacked(<n x 2 x i1> %pg, i8* %base, <n x 2 x i32> %indices) {
; CHECK-LABEL: test_svprfd_u32index_unpacked
; CHECK: prfd pstl3strm, p0, [x0, z0.d, uxtw #3]
entry:
  %i64_indices = zext <n x 2 x i32> %indices to <n x 2 x i64>
  %offsets = shl <n x 2 x i64> %i64_indices, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 3, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  tail call void @llvm.aarch64.sve.prfd.gather.nxv2i1(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %offsets, i32 13)
  ret void
}

;
; scalar + vector gather - 64-bit scaled offset
;
define void @test_svprfb_u64offset(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %offsets) {
; CHECK-LABEL: test_svprfb_u64offset
; CHECK: prfb pstl3strm, p0, [x0, z0.d]
entry:
  tail call void @llvm.aarch64.sve.prfb.gather.nxv2i1(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %offsets, i32 13)
  ret void
}

define void @test_svprfh_u64offset(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %indices) {
; CHECK-LABEL: test_svprfh_u64offset
; CHECK: prfh pstl3strm, p0, [x0, z0.d, lsl #1]
entry:
  %offsets = shl <n x 2 x i64> %indices, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 1, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  tail call void @llvm.aarch64.sve.prfh.gather.nxv2i1(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %offsets, i32 13)
  ret void
}

define void @test_svprfw_u64offset(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %indices) {
; CHECK-LABEL: test_svprfw_u64offset
; CHECK: prfw pstl3strm, p0, [x0, z0.d, lsl #2]
entry:
  %offsets = shl <n x 2 x i64> %indices, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 2, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  tail call void @llvm.aarch64.sve.prfw.gather.nxv2i1(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %offsets, i32 13)
  ret void
}

define void @test_svprfd_u64offset(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %indices) {
; CHECK-LABEL: test_svprfd_u64offset
; CHECK: prfd pstl3strm, p0, [x0, z0.d, lsl #3]
entry:
  %offsets = shl <n x 2 x i64> %indices, shufflevector (<n x 2 x i64> insertelement (<n x 2 x i64> undef, i64 3, i32 0), <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer)
  tail call void @llvm.aarch64.sve.prfd.gather.nxv2i1(<n x 2 x i1> %pg, i8* %base, <n x 2 x i64> %offsets, i32 13)
  ret void
}

;
; vector plus imm gather - 32-bit element
;
define void @test_svprfb_u32base_vnum_under(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfb_u32base_vnum_under
; CHECK: mov x[[BASE:[0-9]+]], #-1
; CHECK: prfb pstl3strm, p0, [x[[BASE]], z0.s, uxtw]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 -1 to i8*
  tail call void @llvm.aarch64.sve.prfb.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfb_u32base_vnum_min(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfb_u32base_vnum_min
; CHECK: prfb pstl3strm, p0, [z0.s]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  tail call void @llvm.aarch64.sve.prfb.gather.nxv4i1(<n x 4 x i1> %pg, i8* null, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfb_u32base_vnum_max(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfb_u32base_vnum_max
; CHECK: prfb pstl3strm, p0, [z0.s, #31]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 31 to i8*
  tail call void @llvm.aarch64.sve.prfb.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfb_u32base_vnum_over(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfb_u32base_vnum_over
; CHECK: orr w[[BASE:[0-9]+]], wzr, #0x20
; CHECK: prfb pstl3strm, p0, [x[[BASE]], z0.s, uxtw]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 32 to i8*
  tail call void @llvm.aarch64.sve.prfb.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfh_u32base_vnum_under(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfh_u32base_vnum_under
; CHECK: mov x[[BASE:[0-9]+]], #-1
; CHECK: prfb pstl3strm, p0, [x[[BASE]], z0.s, uxtw]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 -1 to i8*
  tail call void @llvm.aarch64.sve.prfh.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfh_u32base_vnum_min(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfh_u32base_vnum_min
; CHECK: prfh pstl3strm, p0, [z0.s]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  tail call void @llvm.aarch64.sve.prfh.gather.nxv4i1(<n x 4 x i1> %pg, i8* null, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfh_u32base_vnum_max(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfh_u32base_vnum_max
; CHECK: prfh pstl3strm, p0, [z0.s, #62]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 62 to i8*
  tail call void @llvm.aarch64.sve.prfh.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfh_u32base_vnum_over(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfh_u32base_vnum_over
; CHECK: orr w[[BASE:[0-9]+]], wzr, #0x40
; CHECK: prfb pstl3strm, p0, [x[[BASE]], z0.s, uxtw]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 64 to i8*
  tail call void @llvm.aarch64.sve.prfh.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfw_u32base_vnum_under(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfw_u32base_vnum_under
; CHECK: mov x[[BASE:[0-9]+]], #-1
; CHECK: prfb pstl3strm, p0, [x[[BASE]], z0.s, uxtw]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 -1 to i8*
  tail call void @llvm.aarch64.sve.prfw.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfw_u32base_vnum_min(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfw_u32base_vnum_min
; CHECK: prfw pstl3strm, p0, [z0.s]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  tail call void @llvm.aarch64.sve.prfw.gather.nxv4i1(<n x 4 x i1> %pg, i8* null, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfw_u32base_vnum_max(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfw_u32base_vnum_max
; CHECK: prfw pstl3strm, p0, [z0.s, #124]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 124 to i8*
  tail call void @llvm.aarch64.sve.prfw.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}
define void @test_svprfw_u32base_vnum_over(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfw_u32base_vnum_over
; CHECK: orr w[[BASE:[0-9]+]], wzr, #0x80
; CHECK: prfb pstl3strm, p0, [x[[BASE]], z0.s, uxtw]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 128 to i8*
  tail call void @llvm.aarch64.sve.prfw.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfd_u32base_vnum_under(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfd_u32base_vnum_under
; CHECK: mov x[[BASE:[0-9]+]], #-1
; CHECK: prfb pstl3strm, p0, [x[[BASE]], z0.s, uxtw]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 -1 to i8*
  tail call void @llvm.aarch64.sve.prfd.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfd_u32base_vnum_min(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfd_u32base_vnum_min
; CHECK: prfd pstl3strm, p0, [z0.s]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  tail call void @llvm.aarch64.sve.prfd.gather.nxv4i1(<n x 4 x i1> %pg, i8* null, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfd_u32base_vnum_max(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfd_u32base_vnum_max
; CHECK: prfd pstl3strm, p0, [z0.s, #248]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 248 to i8*
  tail call void @llvm.aarch64.sve.prfd.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

define void @test_svprfd_u32base_vnum_over(<n x 4 x i1> %pg, <n x 4 x i32> %bases)
{
; CHECK-LABEL: test_svprfd_u32base_vnum_over
; CHECK: orr w[[BASE:[0-9]+]], wzr, #0x100
; CHECK: prfb pstl3strm, p0, [x[[BASE]], z0.s, uxtw]
entry:
  %i64_bases = zext <n x 4 x i32> %bases to <n x 4 x i64>
  %offset = inttoptr i64 256 to i8*
  tail call void @llvm.aarch64.sve.prfd.gather.nxv4i1(<n x 4 x i1> %pg, i8* %offset, <n x 4 x i64> %i64_bases, i32 13)
  ret void
}

;
; vector plus imm gather - 64-bit element
;
define void @test_svprfb_u64base_vnum_under(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfb_u64base_vnum_under
; CHECK: mov x[[BASE:[0-9]+]], #-1
; CHECK: prfb pstl3strm, p0, [x[[BASE]], z0.d]
entry:
  %offset = inttoptr i64 -1 to i8*
  tail call void @llvm.aarch64.sve.prfb.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfb_u64base_vnum_min(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfb_u64base_vnum_min
; CHECK: prfb pstl3strm, p0, [z0.d]
entry:
  tail call void @llvm.aarch64.sve.prfb.gather.nxv2i1(<n x 2 x i1> %pg, i8* null, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfb_u64base_vnum_max(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfb_u64base_vnum_max
; CHECK: prfb pstl3strm, p0, [z0.d, #31]
entry:
  %offset = inttoptr i64 31 to i8*
  tail call void @llvm.aarch64.sve.prfb.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfb_u64base_vnum_over(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfb_u64base_vnum_over
; CHECK: orr w[[BASE:[0-9]+]], wzr, #0x20
; CHECK: prfb pstl3strm, p0, [x[[BASE]], z0.d]
entry:
  %offset = inttoptr i64 32 to i8*
  tail call void @llvm.aarch64.sve.prfb.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfh_u64base_vnum_under(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfh_u64base_vnum_under
; CHECK: mov z[[SPLAT:[0-9]+]].d, #-1
; CHECK: add z[[ADDR:[0-9]+]].d, z0.d, z[[SPLAT]].d
; CHECK: prfh pstl3strm, p0, [z[[ADDR]].d]
entry:
  %offset = inttoptr i64 -1 to i8*
  tail call void @llvm.aarch64.sve.prfh.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfh_u64base_vnum_min(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfh_u64base_vnum_min
; CHECK: prfh pstl3strm, p0, [z0.d]
entry:
  tail call void @llvm.aarch64.sve.prfh.gather.nxv2i1(<n x 2 x i1> %pg, i8* null, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfh_u64base_vnum_max(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfh_u64base_vnum_max
; CHECK: prfh pstl3strm, p0, [z0.d, #62]
entry:
  %offset = inttoptr i64 62 to i8*
  tail call void @llvm.aarch64.sve.prfh.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfh_u64base_vnum_over(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfh_u64base_vnum_over
; CHECK: add z[[ADDR:[0-9]+]].d, z0.d, #64
; CHECK: prfh pstl3strm, p0, [z[[ADDR]].d]
entry:
  %offset = inttoptr i64 64 to i8*
  tail call void @llvm.aarch64.sve.prfh.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfw_u64base_vnum_under(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfw_u64base_vnum_under
; CHECK: mov z[[SPLAT:[0-9]+]].d, #-1
; CHECK: add z[[ADDR:[0-9]+]].d, z0.d, z[[SPLAT]].d
; CHECK: prfw pstl3strm, p0, [z[[ADDR]].d]
entry:
  %offset = inttoptr i64 -1 to i8*
  tail call void @llvm.aarch64.sve.prfw.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfw_u64base_vnum_min(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfw_u64base_vnum_min
; CHECK: prfw pstl3strm, p0, [z0.d]
entry:
  tail call void @llvm.aarch64.sve.prfw.gather.nxv2i1(<n x 2 x i1> %pg, i8* null, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfw_u64base_vnum_max(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfw_u64base_vnum_max
; CHECK: prfw pstl3strm, p0, [z0.d, #124]
entry:
  %offset = inttoptr i64 124 to i8*
  tail call void @llvm.aarch64.sve.prfw.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfw_u64base_vnum_over(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfw_u64base_vnum_over
; CHECK: add z[[ADDR:[0-9]+]].d, z0.d, #128
; CHECK: prfw pstl3strm, p0, [z[[ADDR]].d]
entry:
  %offset = inttoptr i64 128 to i8*
  tail call void @llvm.aarch64.sve.prfw.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfd_u64base_vnum_under(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfd_u64base_vnum_under
; CHECK: mov z[[SPLAT:[0-9]+]].d, #-1
; CHECK: add z[[ADDR:[0-9]+]].d, z0.d, z[[SPLAT]].d
; CHECK: prfd pstl3strm, p0, [z[[ADDR]].d]
entry:
  %offset = inttoptr i64 -1 to i8*
  tail call void @llvm.aarch64.sve.prfd.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfd_u64base_vnum_min(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfd_u64base_vnum_min
; CHECK: prfd pstl3strm, p0, [z0.d]
entry:
  tail call void @llvm.aarch64.sve.prfd.gather.nxv2i1(<n x 2 x i1> %pg, i8* null, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfd_u64base_vnum_max(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfd_u64base_vnum_max
; CHECK: prfd pstl3strm, p0, [z0.d, #248]
entry:
  %offset = inttoptr i64 248 to i8*
  tail call void @llvm.aarch64.sve.prfd.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}

define void @test_svprfd_u64base_vnum_over(<n x 2 x i1> %pg, <n x 2 x i64> %bases)
{
; CHECK-LABEL: test_svprfd_u64base_vnum_over
; CHECK: add z[[ADDR:[0-9]+]].d, z0.d, #256
; CHECK: prfd pstl3strm, p0, [z[[ADDR]].d]
entry:
  %offset = inttoptr i64 256 to i8*
  tail call void @llvm.aarch64.sve.prfd.gather.nxv2i1(<n x 2 x i1> %pg, i8* %offset, <n x 2 x i64> %bases, i32 13)
  ret void
}



declare void @llvm.aarch64.sve.prf.nxv16i1(<n x 16 x i1>, i8*, i32)
declare void @llvm.aarch64.sve.prf.nxv8i1(<n x 8 x i1>,  i8*, i32)
declare void @llvm.aarch64.sve.prf.nxv4i1(<n x 4 x i1>,  i8*, i32)
declare void @llvm.aarch64.sve.prf.nxv2i1(<n x 2 x i1>,  i8*, i32)
declare void @llvm.aarch64.sve.prfb.gather.nxv4i1(<n x 4 x i1>, i8*, <n x 4 x i64>, i32)
declare void @llvm.aarch64.sve.prfh.gather.nxv4i1(<n x 4 x i1>, i8*, <n x 4 x i64>, i32)
declare void @llvm.aarch64.sve.prfw.gather.nxv4i1(<n x 4 x i1>, i8*, <n x 4 x i64>, i32)
declare void @llvm.aarch64.sve.prfd.gather.nxv4i1(<n x 4 x i1>, i8*, <n x 4 x i64>, i32)
declare void @llvm.aarch64.sve.prfb.gather.nxv2i1(<n x 2 x i1>, i8*, <n x 2 x i64>, i32)
declare void @llvm.aarch64.sve.prfh.gather.nxv2i1(<n x 2 x i1>, i8*, <n x 2 x i64>, i32)
declare void @llvm.aarch64.sve.prfw.gather.nxv2i1(<n x 2 x i1>, i8*, <n x 2 x i64>, i32)
declare void @llvm.aarch64.sve.prfd.gather.nxv2i1(<n x 2 x i1>, i8*, <n x 2 x i64>, i32)
