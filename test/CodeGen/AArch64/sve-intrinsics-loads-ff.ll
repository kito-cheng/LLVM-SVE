; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; LDFF1B (contiguous)
;

define <n x 16 x i8> @ldff1b(<n x 16 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldff1b:
; CHECK: ldff1b {z0.b}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 16 x i8> @llvm.aarch64.sve.ldff1.nxv16i8(<n x 16 x i1> %pg, i8* %a)
  ret <n x 16 x i8> %load
}

define <n x 16 x i8> @ldff1b_unscaled(<n x 16 x i1> %pg, i8* %a, i64 %b) {
; CHECK-LABEL: ldff1b_unscaled:
; CHECK: ldff1b {z0.b}, p0/z, [x0, x1]
; CHECK-NEXT: ret
  %base = getelementptr i8, i8* %a, i64 %b
  %load = call <n x 16 x i8> @llvm.aarch64.sve.ldff1.nxv16i8(<n x 16 x i1> %pg, i8* %base)
  ret <n x 16 x i8> %load
}

define <n x 8 x i16> @ldff1b_h(<n x 8 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldff1b_h:
; CHECK: ldff1b {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<n x 8 x i1> %pg, i8* %a)
  %res = zext <n x 8 x i8> %load to <n x 8 x i16>
  ret <n x 8 x i16> %res
}

define <n x 8 x i16> @ldff1b_h_unscaled(<n x 8 x i1> %pg, i8* %a, i64 %b) {
; CHECK-LABEL: ldff1b_h_unscaled:
; CHECK: ldff1b {z0.h}, p0/z, [x0, x1]
; CHECK-NEXT: ret
  %base = getelementptr i8, i8* %a, i64 %b
  %load = call <n x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<n x 8 x i1> %pg, i8* %base)
  %res = zext <n x 8 x i8> %load to <n x 8 x i16>
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @ldff1b_s(<n x 4 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldff1b_s:
; CHECK: ldff1b {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<n x 4 x i1> %pg, i8* %a)
  %res = zext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @ldff1b_s_unscaled(<n x 4 x i1> %pg, i8* %a, i64 %b) {
; CHECK-LABEL: ldff1b_s_unscaled:
; CHECK: ldff1b {z0.s}, p0/z, [x0, x1]
; CHECK-NEXT: ret
  %base = getelementptr i8, i8* %a, i64 %b
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<n x 4 x i1> %pg, i8* %base)
  %res = zext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @ldff1b_d(<n x 2 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldff1b_d:
; CHECK: ldff1b {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<n x 2 x i1> %pg, i8* %a)
  %res = zext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @ldff1b_d_unscaled(<n x 2 x i1> %pg, i8* %a, i64 %b) {
; CHECK-LABEL: ldff1b_d_unscaled:
; CHECK: ldff1b {z0.d}, p0/z, [x0, x1]
; CHECK-NEXT: ret
  %base = getelementptr i8, i8* %a, i64 %b
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<n x 2 x i1> %pg, i8* %base)
  %res = zext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDFF1B (gather)
;

define <n x 4 x i32> @gldff1b_s_imm(<n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1b_s_imm:
; CHECK: ldff1b {z0.s}, p0/z, [z0.s, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i8*
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldff1.gather.nxv4i8(<n x 4 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 4 x i64> %b.zext)
  %res = zext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1b_s_sxtw(<n x 4 x i1> %pg, i8* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1b_s_sxtw:
; CHECK: ldff1b {z0.s}, p0/z, [x0, z0.s, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldff1.gather.nxv4i8(<n x 4 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 4 x i64> %b.sext)
  %res = zext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1b_s_uxtw(<n x 4 x i1> %pg, i8* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1b_s_uxtw:
; CHECK: ldff1b {z0.s}, p0/z, [x0, z0.s, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldff1.gather.nxv4i8(<n x 4 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 4 x i64> %b.zext)
  %res = zext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @gldff1b_d(<n x 2 x i1> %pg, i8* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1b_d:
; CHECK: ldff1b {z0.d}, p0/z, [x0, z0.d]
; CHECK-NEXT: ret
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<n x 2 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 2 x i64> %b)
  %res = zext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1b_d_imm(<n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1b_d_imm:
; CHECK: ldff1b {z0.d}, p0/z, [z0.d, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i8*
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<n x 2 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 2 x i64> %b)
  %res = zext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1b_d_sxtw(<n x 2 x i1> %pg, i8* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1b_d_sxtw:
; CHECK: ldff1b {z0.d}, p0/z, [x0, z0.d, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<n x 2 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 2 x i64> %b.sext)
  %res = zext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1b_d_uxtw(<n x 2 x i1> %pg, i8* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1b_d_uxtw:
; CHECK: ldff1b {z0.d}, p0/z, [x0, z0.d, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<n x 2 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 2 x i64> %b.zext)
  %res = zext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDFF1H (contiguous)
;

define <n x 8 x i16> @ldff1h(<n x 8 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldff1h:
; CHECK: ldff1h {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 8 x i16> @llvm.aarch64.sve.ldff1.nxv8i16(<n x 8 x i1> %pg, i16* %a)
  ret <n x 8 x i16> %load
}

define <n x 8 x i16> @ldff1h_scaled(<n x 8 x i1> %pg, i16* %a, i64 %b) {
; CHECK-LABEL: ldff1h_scaled:
; CHECK: ldff1h {z0.h}, p0/z, [x0, x1, lsl #1]
; CHECK-NEXT: ret
  %base = getelementptr i16, i16* %a, i64 %b
  %load = call <n x 8 x i16> @llvm.aarch64.sve.ldff1.nxv8i16(<n x 8 x i1> %pg, i16* %base)
  ret <n x 8 x i16> %load
}

define <n x 4 x i32> @ldff1h_s(<n x 4 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldff1h_s:
; CHECK: ldff1h {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.nxv4i16(<n x 4 x i1> %pg, i16* %a)
  %res = zext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @ldff1h_s_scaled(<n x 4 x i1> %pg, i16* %a, i64 %b) {
; CHECK-LABEL: ldff1h_s_scaled:
; CHECK: ldff1h {z0.s}, p0/z, [x0, x1, lsl #1]
; CHECK-NEXT: ret
  %base = getelementptr i16, i16* %a, i64 %b
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.nxv4i16(<n x 4 x i1> %pg, i16* %base)
  %res = zext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @ldff1h_d(<n x 2 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldff1h_d:
; CHECK: ldff1h {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.nxv2i16(<n x 2 x i1> %pg, i16* %a)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @ldff1h_d_scaled(<n x 2 x i1> %pg, i16* %a, i64 %b) {
; CHECK-LABEL: ldff1h_d_scaled:
; CHECK: ldff1h {z0.d}, p0/z, [x0, x1, lsl #1]
; CHECK-NEXT: ret
  %base = getelementptr i16, i16* %a, i64 %b
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.nxv2i16(<n x 2 x i1> %pg, i16* %base)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDFF1H (contiguous, floating point)
;

define <n x 8 x half> @ldff1h_f16(<n x 8 x i1> %pg, half* %a) {
; CHECK-LABEL: ldff1h_f16:
; CHECK: ldff1h {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 8 x half> @llvm.aarch64.sve.ldff1.nxv8f16(<n x 8 x i1> %pg, half* %a)
  ret <n x 8 x half> %load
}

define <n x 8 x half> @ldff1h_f16_scaled(<n x 8 x i1> %pg, half* %a, i64 %b) {
; CHECK-LABEL: ldff1h_f16_scaled:
; CHECK: ldff1h {z0.h}, p0/z, [x0, x1, lsl #1]
; CHECK-NEXT: ret
  %base = getelementptr half, half* %a, i64 %b
  %load = call <n x 8 x half> @llvm.aarch64.sve.ldff1.nxv8f16(<n x 8 x i1> %pg, half* %base)
  ret <n x 8 x half> %load
}

;
; LDFF1H (gather)
;

define <n x 4 x i32> @gldff1h_s_imm(<n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1h_s_imm:
; CHECK: ldff1h {z0.s}, p0/z, [z0.s, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i16*
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 4 x i64> %b.zext)
  %res = zext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1h_s_sxtw(<n x 4 x i1> %pg, i16* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1h_s_sxtw:
; CHECK: ldff1h {z0.s}, p0/z, [x0, z0.s, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 4 x i64> %b.sext)
  %res = zext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1h_s_sxtw_scaled(<n x 4 x i1> %pg, i16* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1h_s_sxtw_scaled:
; CHECK: ldff1h {z0.s}, p0/z, [x0, z0.s, sxtw #1]
; CHECK-NEXT: ret
  %scale = insertelement <n x 4 x i64> undef, i64 1, i32 0
  %vscale = shufflevector <n x 4 x i64> %scale, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer

  %b.sext = sext <n x 4 x i32> %b to <n x 4 x i64>
  %b.sext.scaled = shl <n x 4 x i64> %b.sext, %vscale
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 4 x i64> %b.sext.scaled)
  %res = zext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1h_s_uxtw(<n x 4 x i1> %pg, i16* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1h_s_uxtw:
; CHECK: ldff1h {z0.s}, p0/z, [x0, z0.s, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 4 x i64> %b.zext)
  %res = zext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1h_s_uxtw_scaled(<n x 4 x i1> %pg, i16* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1h_s_uxtw_scaled:
; CHECK: ldff1h {z0.s}, p0/z, [x0, z0.s, uxtw #1]
; CHECK-NEXT: ret
  %scale = insertelement <n x 4 x i64> undef, i64 1, i32 0
  %vscale = shufflevector <n x 4 x i64> %scale, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer

  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %b.zext.scaled = shl <n x 4 x i64> %b.zext, %vscale
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 4 x i64> %b.zext.scaled)
  %res = zext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @gldff1h_d(<n x 2 x i1> %pg, i16* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1h_d:
; CHECK: ldff1h {z0.d}, p0/z, [x0, z0.d]
; CHECK-NEXT: ret
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1h_d_imm(<n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1h_d_imm:
; CHECK: ldff1h {z0.d}, p0/z, [z0.d, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i16*
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1h_d_scaled(<n x 2 x i1> %pg, i16* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1h_d_scaled:
; CHECK: ldff1h {z0.d}, p0/z, [x0, z0.d, lsl #1]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.scaled = shl <n x 2 x i64> %b, %vscale
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b.scaled)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1h_d_sxtw(<n x 2 x i1> %pg, i16* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1h_d_sxtw:
; CHECK: ldff1h {z0.d}, p0/z, [x0, z0.d, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b.sext)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1h_d_sxtw_scaled(<n x 2 x i1> %pg, i16* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1h_d_sxtw_scaled:
; CHECK: ldff1h {z0.d}, p0/z, [x0, z0.d, sxtw #1]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %b.sext.scaled = shl <n x 2 x i64> %b.sext, %vscale
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b.sext.scaled)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1h_d_uxtw(<n x 2 x i1> %pg, i16* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1h_d_uxtw:
; CHECK: ldff1h {z0.d}, p0/z, [x0, z0.d, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b.zext)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1h_d_uxtw_scaled(<n x 2 x i1> %pg, i16* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1h_d_uxtw_scaled:
; CHECK: ldff1h {z0.d}, p0/z, [x0, z0.d, uxtw #1]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %b.zext.scaled = shl <n x 2 x i64> %b.zext, %vscale
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b.zext.scaled)
  %res = zext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDFF1W (contiguous)
;

define <n x 4 x i32> @ldff1w(<n x 4 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldff1w:
; CHECK: ldff1w {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x i32> @llvm.aarch64.sve.ldff1.nxv4i32(<n x 4 x i1> %pg, i32* %a)
  ret <n x 4 x i32> %load
}

define <n x 4 x i32> @ldff1w_scaled(<n x 4 x i1> %pg, i32* %a, i64 %b) {
; CHECK-LABEL: ldff1w_scaled:
; CHECK: ldff1w {z0.s}, p0/z, [x0, x1, lsl #2]
; CHECK-NEXT: ret
  %base = getelementptr i32, i32* %a, i64 %b
  %load = call <n x 4 x i32> @llvm.aarch64.sve.ldff1.nxv4i32(<n x 4 x i1> %pg, i32* %base)
  ret <n x 4 x i32> %load
}

define <n x 2 x i64> @ldff1w_d(<n x 2 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldff1w_d:
; CHECK: ldff1w {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.nxv2i32(<n x 2 x i1> %pg, i32* %a)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @ldff1w_d_scaled(<n x 2 x i1> %pg, i32* %a, i64 %b) {
; CHECK-LABEL: ldff1w_d_scaled:
; CHECK: ldff1w {z0.d}, p0/z, [x0, x1, lsl #2]
; CHECK-NEXT: ret
  %base = getelementptr i32, i32* %a, i64 %b
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.nxv2i32(<n x 2 x i1> %pg, i32* %base)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDFF1W (contiguous, floating point)
;

define <n x 4 x float> @ldff1w_f32(<n x 4 x i1> %pg, float* %a) {
; CHECK-LABEL: ldff1w_f32:
; CHECK: ldff1w {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x float> @llvm.aarch64.sve.ldff1.nxv4f32(<n x 4 x i1> %pg, float* %a)
  ret <n x 4 x float> %load
}

define <n x 4 x float> @ldff1w_f32_scaled(<n x 4 x i1> %pg, float* %a, i64 %b) {
; CHECK-LABEL: ldff1w_f32_scaled:
; CHECK: ldff1w {z0.s}, p0/z, [x0, x1, lsl #2]
; CHECK-NEXT: ret
  %base = getelementptr float, float* %a, i64 %b
  %load = call <n x 4 x float> @llvm.aarch64.sve.ldff1.nxv4f32(<n x 4 x i1> %pg, float* %base)
  ret <n x 4 x float> %load
}

;
; LDFF1W (gather)
;

define <n x 4 x i32> @gldff1w_imm(<n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1w_imm:
; CHECK: ldff1w {z0.s}, p0/z, [z0.s, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i32*
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i32> @llvm.aarch64.sve.ldff1.gather.nxv4i32(<n x 4 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 4 x i64> %b.zext)
  ret <n x 4 x i32> %load
}

define <n x 4 x i32> @gldff1w_sxtw(<n x 4 x i1> %pg, i32* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1w_sxtw:
; CHECK: ldff1w {z0.s}, p0/z, [x0, z0.s, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i32> @llvm.aarch64.sve.ldff1.gather.nxv4i32(<n x 4 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 4 x i64> %b.sext)
  ret <n x 4 x i32> %load
}

define <n x 4 x i32> @gldff1w_sxtw_scaled(<n x 4 x i1> %pg, i32* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1w_sxtw_scaled:
; CHECK: ldff1w {z0.s}, p0/z, [x0, z0.s, sxtw #2]
; CHECK-NEXT: ret
  %scale = insertelement <n x 4 x i64> undef, i64 2, i32 0
  %vscale = shufflevector <n x 4 x i64> %scale, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer

  %b.sext = sext <n x 4 x i32> %b to <n x 4 x i64>
  %b.sext.scaled = shl <n x 4 x i64> %b.sext, %vscale
  %load = call <n x 4 x i32> @llvm.aarch64.sve.ldff1.gather.nxv4i32(<n x 4 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 4 x i64> %b.sext.scaled)
  ret <n x 4 x i32> %load
}

define <n x 4 x i32> @gldff1w_uxtw(<n x 4 x i1> %pg, i32* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1w_uxtw:
; CHECK: ldff1w {z0.s}, p0/z, [x0, z0.s, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i32> @llvm.aarch64.sve.ldff1.gather.nxv4i32(<n x 4 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 4 x i64> %b.zext)
  ret <n x 4 x i32> %load
}

define <n x 4 x i32> @gldff1w_uxtw_scaled(<n x 4 x i1> %pg, i32* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1w_uxtw_scaled:
; CHECK: ldff1w {z0.s}, p0/z, [x0, z0.s, uxtw #2]
; CHECK-NEXT: ret
  %scale = insertelement <n x 4 x i64> undef, i64 2, i32 0
  %vscale = shufflevector <n x 4 x i64> %scale, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer

  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %b.zext.scaled = shl <n x 4 x i64> %b.zext, %vscale
  %load = call <n x 4 x i32> @llvm.aarch64.sve.ldff1.gather.nxv4i32(<n x 4 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 4 x i64> %b.zext.scaled)
  ret <n x 4 x i32> %load
}

define <n x 2 x i64> @gldff1w_d(<n x 2 x i1> %pg, i32* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1w_d:
; CHECK: ldff1w {z0.d}, p0/z, [x0, z0.d]
; CHECK-NEXT: ret
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1w_d_imm(<n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1w_d_imm:
; CHECK: ldff1w {z0.d}, p0/z, [z0.d, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i32*
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1w_d_scaled(<n x 2 x i1> %pg, i32* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1w_d_scaled:
; CHECK: ldff1w {z0.d}, p0/z, [x0, z0.d, lsl #2]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.scaled = shl <n x 2 x i64> %b, %vscale
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b.scaled)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1w_d_sxtw(<n x 2 x i1> %pg, i32* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1w_d_sxtw:
; CHECK: ldff1w {z0.d}, p0/z, [x0, z0.d, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b.sext)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1w_d_sxtw_scaled(<n x 2 x i1> %pg, i32* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1w_d_sxtw_scaled:
; CHECK: ldff1w {z0.d}, p0/z, [x0, z0.d, sxtw #2]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %b.sext.scaled = shl <n x 2 x i64> %b.sext, %vscale
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b.sext.scaled)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1w_d_uxtw(<n x 2 x i1> %pg, i32* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1w_d_uxtw:
; CHECK: ldff1w {z0.d}, p0/z, [x0, z0.d, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b.zext)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1w_d_uxtw_scaled(<n x 2 x i1> %pg, i32* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1w_d_uxtw_scaled:
; CHECK: ldff1w {z0.d}, p0/z, [x0, z0.d, uxtw #2]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %b.zext.scaled = shl <n x 2 x i64> %b.zext, %vscale
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b.zext.scaled)
  %res = zext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDFF1W (gather, floating point)
;

define <n x 4 x float> @gldff1w_f32_imm(<n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1w_f32_imm:
; CHECK: ldff1w {z0.s}, p0/z, [z0.s, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to float*
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x float> @llvm.aarch64.sve.ldff1.gather.nxv4f32(<n x 4 x i1> %pg,
                                                                      float* %a,
                                                                      <n x 4 x i64> %b.zext)
  ret <n x 4 x float> %load
}

define <n x 4 x float> @gldff1w_f32_sxtw(<n x 4 x i1> %pg, float* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1w_f32_sxtw:
; CHECK: ldff1w {z0.s}, p0/z, [x0, z0.s, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x float> @llvm.aarch64.sve.ldff1.gather.nxv4f32(<n x 4 x i1> %pg,
                                                                      float* %a,
                                                                      <n x 4 x i64> %b.sext)
  ret <n x 4 x float> %load
}

define <n x 4 x float> @gldff1w_f32_sxtw_scaled(<n x 4 x i1> %pg, float* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1w_f32_sxtw_scaled:
; CHECK: ldff1w {z0.s}, p0/z, [x0, z0.s, sxtw #2]
; CHECK-NEXT: ret
  %scale = insertelement <n x 4 x i64> undef, i64 2, i32 0
  %vscale = shufflevector <n x 4 x i64> %scale, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer

  %b.sext = sext <n x 4 x i32> %b to <n x 4 x i64>
  %b.sext.scaled = shl <n x 4 x i64> %b.sext, %vscale
  %load = call <n x 4 x float> @llvm.aarch64.sve.ldff1.gather.nxv4f32(<n x 4 x i1> %pg,
                                                                      float* %a,
                                                                      <n x 4 x i64> %b.sext.scaled)
  ret <n x 4 x float> %load
}

define <n x 4 x float> @gldff1w_f32_uxtw(<n x 4 x i1> %pg, float* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1w_f32_uxtw:
; CHECK: ldff1w {z0.s}, p0/z, [x0, z0.s, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x float> @llvm.aarch64.sve.ldff1.gather.nxv4f32(<n x 4 x i1> %pg,
                                                                      float* %a,
                                                                      <n x 4 x i64> %b.zext)
  ret <n x 4 x float> %load
}

define <n x 4 x float> @gldff1w_f32_uxtw_scaled(<n x 4 x i1> %pg, float* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1w_f32_uxtw_scaled:
; CHECK: ldff1w {z0.s}, p0/z, [x0, z0.s, uxtw #2]
; CHECK-NEXT: ret
  %scale = insertelement <n x 4 x i64> undef, i64 2, i32 0
  %vscale = shufflevector <n x 4 x i64> %scale, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer

  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %b.zext.scaled = shl <n x 4 x i64> %b.zext, %vscale
  %load = call <n x 4 x float> @llvm.aarch64.sve.ldff1.gather.nxv4f32(<n x 4 x i1> %pg,
                                                                      float* %a,
                                                                      <n x 4 x i64> %b.zext.scaled)
  ret <n x 4 x float> %load
}

;
; LDFF1D (contiguous)
;

define <n x 2 x i64> @ldff1d(<n x 2 x i1> %pg, i64* %a) {
; CHECK-LABEL: ldff1d:
; CHECK: ldff1d {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldff1.nxv2i64(<n x 2 x i1> %pg, i64* %a)
  ret <n x 2 x i64> %load
}

define <n x 2 x i64> @ldff1d_scaled(<n x 2 x i1> %pg, i64* %a, i64 %b) {
; CHECK-LABEL: ldff1d_scaled:
; CHECK: ldff1d {z0.d}, p0/z, [x0, x1, lsl #3]
; CHECK-NEXT: ret
  %base = getelementptr i64, i64* %a, i64 %b
  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldff1.nxv2i64(<n x 2 x i1> %pg, i64* %base)
  ret <n x 2 x i64> %load
}

;
; LDFF1D (contiguous, floating point)
;

define <n x 2 x double> @ldff1d_f64(<n x 2 x i1> %pg, double* %a) {
; CHECK-LABEL: ldff1d_f64:
; CHECK: ldff1d {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x double> @llvm.aarch64.sve.ldff1.nxv2f64(<n x 2 x i1> %pg, double* %a)
  ret <n x 2 x double> %load
}

define <n x 2 x double> @ldff1d_f64_scaled(<n x 2 x i1> %pg, double* %a, i64 %b) {
; CHECK-LABEL: ldff1d_f64_scaled:
; CHECK: ldff1d {z0.d}, p0/z, [x0, x1, lsl #3]
; CHECK-NEXT: ret
  %base = getelementptr double, double* %a, i64 %b
  %load = call <n x 2 x double> @llvm.aarch64.sve.ldff1.nxv2f64(<n x 2 x i1> %pg, double* %base)
  ret <n x 2 x double> %load
}

;
; LDFF1D (gather)
;

define <n x 2 x i64> @gldff1d(<n x 2 x i1> %pg, i64* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1d:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d]
; CHECK-NEXT: ret
  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldff1.gather.nxv2i64(<n x 2 x i1> %pg,
                                                                    i64* %a,
                                                                    <n x 2 x i64> %b)
  ret <n x 2 x i64> %load
}

define <n x 2 x i64> @gldff1d_imm(<n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1d_imm:
; CHECK: ldff1d {z0.d}, p0/z, [z0.d, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i64*
  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldff1.gather.nxv2i64(<n x 2 x i1> %pg,
                                                                    i64* %a,
                                                                    <n x 2 x i64> %b)
  ret <n x 2 x i64> %load
}

define <n x 2 x i64> @gldff1d_scaled(<n x 2 x i1> %pg, i64* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1d_scaled:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d, lsl #3]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.scaled = shl <n x 2 x i64> %b, %vscale
  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldff1.gather.nxv2i64(<n x 2 x i1> %pg,
                                                                    i64* %a,
                                                                    <n x 2 x i64> %b.scaled)
  ret <n x 2 x i64> %load
}

define <n x 2 x i64> @gldff1d_sxtw(<n x 2 x i1> %pg, i64* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1d_sxtw:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldff1.gather.nxv2i64(<n x 2 x i1> %pg,
                                                                    i64* %a,
                                                                    <n x 2 x i64> %b.sext)
  ret <n x 2 x i64> %load
}

define <n x 2 x i64> @gldff1d_sxtw_scaled(<n x 2 x i1> %pg, i64* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1d_sxtw_scaled:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d, sxtw #3]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %b.sext.scaled = shl <n x 2 x i64> %b.sext, %vscale
  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldff1.gather.nxv2i64(<n x 2 x i1> %pg,
                                                                    i64* %a,
                                                                    <n x 2 x i64> %b.sext.scaled)
  ret <n x 2 x i64> %load
}

define <n x 2 x i64> @gldff1d_uxtw(<n x 2 x i1> %pg, i64* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1d_uxtw:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldff1.gather.nxv2i64(<n x 2 x i1> %pg,
                                                                    i64* %a,
                                                                    <n x 2 x i64> %b.zext)
  ret <n x 2 x i64> %load
}

define <n x 2 x i64> @gldff1d_uxtw_scaled(<n x 2 x i1> %pg, i64* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1d_uxtw_scaled:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d, uxtw #3]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %b.zext.scaled = shl <n x 2 x i64> %b.zext, %vscale
  %load = call <n x 2 x i64> @llvm.aarch64.sve.ldff1.gather.nxv2i64(<n x 2 x i1> %pg,
                                                                    i64* %a,
                                                                    <n x 2 x i64> %b.zext.scaled)
  ret <n x 2 x i64> %load
}

;
; LDFF1D (gather, floating point)
;

define <n x 2 x double> @gldff1d_f64(<n x 2 x i1> %pg, double* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1d_f64:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d]
; CHECK-NEXT: ret
  %load = call <n x 2 x double> @llvm.aarch64.sve.ldff1.gather.nxv2f64(<n x 2 x i1> %pg,
                                                                       double* %a,
                                                                       <n x 2 x i64> %b)
  ret <n x 2 x double> %load
}

define <n x 2 x double> @gldff1d_f64_imm(<n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1d_f64_imm:
; CHECK: ldff1d {z0.d}, p0/z, [z0.d, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to double*
  %load = call <n x 2 x double> @llvm.aarch64.sve.ldff1.gather.nxv2f64(<n x 2 x i1> %pg,
                                                                    double* %a,
                                                                    <n x 2 x i64> %b)
  ret <n x 2 x double> %load
}

define <n x 2 x double> @gldff1d_f64_scaled(<n x 2 x i1> %pg, double* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1d_f64_scaled:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d, lsl #3]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.scaled = shl <n x 2 x i64> %b, %vscale
  %load = call <n x 2 x double> @llvm.aarch64.sve.ldff1.gather.nxv2f64(<n x 2 x i1> %pg,
                                                                       double* %a,
                                                                       <n x 2 x i64> %b.scaled)
  ret <n x 2 x double> %load
}

define <n x 2 x double> @gldff1d_f64_sxtw(<n x 2 x i1> %pg, double* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1d_f64_sxtw:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x double> @llvm.aarch64.sve.ldff1.gather.nxv2f64(<n x 2 x i1> %pg,
                                                                       double* %a,
                                                                       <n x 2 x i64> %b.sext)
  ret <n x 2 x double> %load
}

define <n x 2 x double> @gldff1d_f64_sxtw_scaled(<n x 2 x i1> %pg, double* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1d_f64_sxtw_scaled:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d, sxtw #3]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %b.sext.scaled = shl <n x 2 x i64> %b.sext, %vscale
  %load = call <n x 2 x double> @llvm.aarch64.sve.ldff1.gather.nxv2f64(<n x 2 x i1> %pg,
                                                                       double* %a,
                                                                       <n x 2 x i64> %b.sext.scaled)
  ret <n x 2 x double> %load
}

define <n x 2 x double> @gldff1d_f64_uxtw(<n x 2 x i1> %pg, double* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1d_f64_uxtw:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x double> @llvm.aarch64.sve.ldff1.gather.nxv2f64(<n x 2 x i1> %pg,
                                                                       double* %a,
                                                                       <n x 2 x i64> %b.zext)
  ret <n x 2 x double> %load
}

define <n x 2 x double> @gldff1d_f64_uxtw_scaled(<n x 2 x i1> %pg, double* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1d_f64_uxtw_scaled:
; CHECK: ldff1d {z0.d}, p0/z, [x0, z0.d, uxtw #3]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %b.zext.scaled = shl <n x 2 x i64> %b.zext, %vscale
  %load = call <n x 2 x double> @llvm.aarch64.sve.ldff1.gather.nxv2f64(<n x 2 x i1> %pg,
                                                                       double* %a,
                                                                       <n x 2 x i64> %b.zext.scaled)
  ret <n x 2 x double> %load
}

;
; LDFF1SB (contiguous)
;

define <n x 8 x i16> @ldff1sb_h(<n x 8 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldff1sb_h:
; CHECK: ldff1sb {z0.h}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<n x 8 x i1> %pg, i8* %a)
  %res = sext <n x 8 x i8> %load to <n x 8 x i16>
  ret <n x 8 x i16> %res
}
define <n x 8 x i16> @ldff1sb_h_unscaled(<n x 8 x i1> %pg, i8* %a, i64 %b) {
; CHECK-LABEL: ldff1sb_h_unscaled:
; CHECK: ldff1sb {z0.h}, p0/z, [x0, x1]
; CHECK-NEXT: ret
  %base = getelementptr i8, i8* %a, i64 %b
  %load = call <n x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<n x 8 x i1> %pg, i8* %base)
  %res = sext <n x 8 x i8> %load to <n x 8 x i16>
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @ldff1sb_s(<n x 4 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldff1sb_s:
; CHECK: ldff1sb {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<n x 4 x i1> %pg, i8* %a)
  %res = sext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @ldff1sb_s_unscaled(<n x 4 x i1> %pg, i8* %a, i64 %b) {
; CHECK-LABEL: ldff1sb_s_unscaled:
; CHECK: ldff1sb {z0.s}, p0/z, [x0, x1]
; CHECK-NEXT: ret
  %base = getelementptr i8, i8* %a, i64 %b
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<n x 4 x i1> %pg, i8* %base)
  %res = sext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @ldff1sb_d(<n x 2 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldff1sb_d:
; CHECK: ldff1sb {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<n x 2 x i1> %pg, i8* %a)
  %res = sext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @ldff1sb_d_unscaled(<n x 2 x i1> %pg, i8* %a, i64 %b) {
; CHECK-LABEL: ldff1sb_d_unscaled:
; CHECK: ldff1sb {z0.d}, p0/z, [x0, x1]
; CHECK-NEXT: ret
  %base = getelementptr i8, i8* %a, i64 %b
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<n x 2 x i1> %pg, i8* %base)
  %res = sext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDFF1SB (gather)
;

define <n x 4 x i32> @gldff1sb_s_imm(<n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1sb_s_imm:
; CHECK: ldff1sb {z0.s}, p0/z, [z0.s, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i8*
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldff1.gather.nxv4i8(<n x 4 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 4 x i64> %b.zext)
  %res = sext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1sb_s_sxtw(<n x 4 x i1> %pg, i8* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1sb_s_sxtw:
; CHECK: ldff1sb {z0.s}, p0/z, [x0, z0.s, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldff1.gather.nxv4i8(<n x 4 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 4 x i64> %b.sext)
  %res = sext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1sb_s_uxtw(<n x 4 x i1> %pg, i8* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1sb_s_uxtw:
; CHECK: ldff1sb {z0.s}, p0/z, [x0, z0.s, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i8> @llvm.aarch64.sve.ldff1.gather.nxv4i8(<n x 4 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 4 x i64> %b.zext)
  %res = sext <n x 4 x i8> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @gldff1sb_d(<n x 2 x i1> %pg, i8* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1sb_d:
; CHECK: ldff1sb {z0.d}, p0/z, [x0, z0.d]
; CHECK-NEXT: ret
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<n x 2 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 2 x i64> %b)
  %res = sext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sb_d_imm(<n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1sb_d_imm:
; CHECK: ldff1sb {z0.d}, p0/z, [z0.d, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i8*
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<n x 2 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 2 x i64> %b)
  %res = sext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sb_d_sxtw(<n x 2 x i1> %pg, i8* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1sb_d_sxtw:
; CHECK: ldff1sb {z0.d}, p0/z, [x0, z0.d, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<n x 2 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 2 x i64> %b.sext)
  %res = sext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sb_d_uxtw(<n x 2 x i1> %pg, i8* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1sb_d_uxtw:
; CHECK: ldff1sb {z0.d}, p0/z, [x0, z0.d, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<n x 2 x i1> %pg,
                                                                  i8* %a,
                                                                  <n x 2 x i64> %b.zext)
  %res = sext <n x 2 x i8> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDFF1SH (contiguous)
;

define <n x 4 x i32> @ldff1sh_s(<n x 4 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldff1sh_s:
; CHECK: ldff1sh {z0.s}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.nxv4i16(<n x 4 x i1> %pg, i16* %a)
  %res = sext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @ldff1sh_s_scaled(<n x 4 x i1> %pg, i16* %a, i64 %b) {
; CHECK-LABEL: ldff1sh_s_scaled:
; CHECK: ldff1sh {z0.s}, p0/z, [x0, x1, lsl #1]
; CHECK-NEXT: ret
  %base = getelementptr i16, i16* %a, i64 %b
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.nxv4i16(<n x 4 x i1> %pg, i16* %base)
  %res = sext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @ldff1sh_d(<n x 2 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldff1sh_d:
; CHECK: ldff1sh {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.nxv2i16(<n x 2 x i1> %pg, i16* %a)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @ldff1sh_d_scaled(<n x 2 x i1> %pg, i16* %a, i64 %b) {
; CHECK-LABEL: ldff1sh_d_scaled:
; CHECK: ldff1sh {z0.d}, p0/z, [x0, x1, lsl #1]
; CHECK-NEXT: ret
  %base = getelementptr i16, i16* %a, i64 %b
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.nxv2i16(<n x 2 x i1> %pg, i16* %base)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDFF1SH (gather)
;

define <n x 4 x i32> @gldff1sh_s_imm(<n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1sh_s_imm:
; CHECK: ldff1sh {z0.s}, p0/z, [z0.s, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i16*
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 4 x i64> %b.zext)
  %res = sext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1sh_s_sxtw(<n x 4 x i1> %pg, i16* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1sh_s_sxtw:
; CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 4 x i64> %b.sext)
  %res = sext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1sh_s_sxtw_scaled(<n x 4 x i1> %pg, i16* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1sh_s_sxtw_scaled:
; CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw #1]
; CHECK-NEXT: ret
  %scale = insertelement <n x 4 x i64> undef, i64 1, i32 0
  %vscale = shufflevector <n x 4 x i64> %scale, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer

  %b.sext = sext <n x 4 x i32> %b to <n x 4 x i64>
  %b.sext.scaled = shl <n x 4 x i64> %b.sext, %vscale
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 4 x i64> %b.sext.scaled)
  %res = sext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1sh_s_uxtw(<n x 4 x i1> %pg, i16* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1sh_s_uxtw:
; CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 4 x i64> %b.zext)
  %res = sext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @gldff1sh_s_uxtw_scaled(<n x 4 x i1> %pg, i16* %a, <n x 4 x i32> %b) {
; CHECK-LABEL: gldff1sh_s_uxtw_scaled:
; CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw #1]
; CHECK-NEXT: ret
  %scale = insertelement <n x 4 x i64> undef, i64 1, i32 0
  %vscale = shufflevector <n x 4 x i64> %scale, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer

  %b.zext = zext <n x 4 x i32> %b to <n x 4 x i64>
  %b.zext.scaled = shl <n x 4 x i64> %b.zext, %vscale
  %load = call <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 4 x i64> %b.zext.scaled)
  %res = sext <n x 4 x i16> %load to <n x 4 x i32>
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @gldff1sh_d(<n x 2 x i1> %pg, i16* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1sh_d:
; CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d]
; CHECK-NEXT: ret
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sh_d_imm(<n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1sh_d_imm:
; CHECK: ldff1sh {z0.d}, p0/z, [z0.d, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i16*
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sh_d_scaled(<n x 2 x i1> %pg, i16* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1sh_d_scaled:
; CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, lsl #1]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.scaled = shl <n x 2 x i64> %b, %vscale
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b.scaled)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sh_d_sxtw(<n x 2 x i1> %pg, i16* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1sh_d_sxtw:
; CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b.sext)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sh_d_sxtw_scaled(<n x 2 x i1> %pg, i16* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1sh_d_sxtw_scaled:
; CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, sxtw #1]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %b.sext.scaled = shl <n x 2 x i64> %b.sext, %vscale
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b.sext.scaled)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sh_d_uxtw(<n x 2 x i1> %pg, i16* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1sh_d_uxtw:
; CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b.zext)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sh_d_uxtw_scaled(<n x 2 x i1> %pg, i16* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1sh_d_uxtw_scaled:
; CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw #1]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %b.zext.scaled = shl <n x 2 x i64> %b.zext, %vscale
  %load = call <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1> %pg,
                                                                    i16* %a,
                                                                    <n x 2 x i64> %b.zext.scaled)
  %res = sext <n x 2 x i16> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

; LDFF1SW (contiguous)
;

define <n x 2 x i64> @ldff1sw_d(<n x 2 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldff1sw_d:
; CHECK: ldff1sw {z0.d}, p0/z, [x0]
; CHECK-NEXT: ret
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.nxv2i32(<n x 2 x i1> %pg, i32* %a)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @ldff1sw_d_scaled(<n x 2 x i1> %pg, i32* %a, i64 %b) {
; CHECK-LABEL: ldff1sw_d_scaled:
; CHECK: ldff1sw {z0.d}, p0/z, [x0, x1, lsl #2]
; CHECK-NEXT: ret
  %base = getelementptr i32, i32* %a, i64 %b
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.nxv2i32(<n x 2 x i1> %pg, i32* %base)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

;
; LDFF1SW (gather)
;

define <n x 2 x i64> @gldff1sw_d(<n x 2 x i1> %pg, i32* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1sw_d:
; CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d]
; CHECK-NEXT: ret
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sw_d_imm(<n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1sw_d_imm:
; CHECK: ldff1sw {z0.d}, p0/z, [z0.d, #16]
; CHECK-NEXT: ret
  %a = inttoptr i64 16 to i32*
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sw_d_scaled(<n x 2 x i1> %pg, i32* %a, <n x 2 x i64> %b) {
; CHECK-LABEL: gldff1sw_d_scaled:
; CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, lsl #2]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.scaled = shl <n x 2 x i64> %b, %vscale
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b.scaled)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sw_d_sxtw(<n x 2 x i1> %pg, i32* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1sw_d_sxtw:
; CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw]
; CHECK-NEXT: ret
  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b.sext)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sw_d_sxtw_scaled(<n x 2 x i1> %pg, i32* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1sw_d_sxtw_scaled:
; CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, sxtw #2]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.sext = sext <n x 2 x i32> %b to <n x 2 x i64>
  %b.sext.scaled = shl <n x 2 x i64> %b.sext, %vscale
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b.sext.scaled)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sw_d_uxtw(<n x 2 x i1> %pg, i32* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1sw_d_uxtw:
; CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw]
; CHECK-NEXT: ret
  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b.zext)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

define <n x 2 x i64> @gldff1sw_d_uxtw_scaled(<n x 2 x i1> %pg, i32* %a, <n x 2 x i32> %b) {
; CHECK-LABEL: gldff1sw_d_uxtw_scaled:
; CHECK: ldff1sw {z0.d}, p0/z, [x0, z0.d, uxtw #2]
; CHECK-NEXT: ret
  %scale = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %vscale = shufflevector <n x 2 x i64> %scale, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer

  %b.zext = zext <n x 2 x i32> %b to <n x 2 x i64>
  %b.zext.scaled = shl <n x 2 x i64> %b.zext, %vscale
  %load = call <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1> %pg,
                                                                    i32* %a,
                                                                    <n x 2 x i64> %b.zext.scaled)
  %res = sext <n x 2 x i32> %load to <n x 2 x i64>
  ret <n x 2 x i64> %res
}

declare <n x 16 x i8> @llvm.aarch64.sve.ldff1.nxv16i8(<n x 16 x i1>, i8*)

declare <n x 8 x i8> @llvm.aarch64.sve.ldff1.nxv8i8(<n x 8 x i1>, i8*)
declare <n x 8 x i16> @llvm.aarch64.sve.ldff1.nxv8i16(<n x 8 x i1>, i16*)
declare <n x 8 x half> @llvm.aarch64.sve.ldff1.nxv8f16(<n x 8 x i1>, half*)

declare <n x 4 x i8> @llvm.aarch64.sve.ldff1.nxv4i8(<n x 4 x i1>, i8*)
declare <n x 4 x i16> @llvm.aarch64.sve.ldff1.nxv4i16(<n x 4 x i1>, i16*)
declare <n x 4 x i32> @llvm.aarch64.sve.ldff1.nxv4i32(<n x 4 x i1>, i32*)
declare <n x 4 x float> @llvm.aarch64.sve.ldff1.nxv4f32(<n x 4 x i1>, float*)

declare <n x 2 x i8> @llvm.aarch64.sve.ldff1.nxv2i8(<n x 2 x i1>, i8*)
declare <n x 2 x i16> @llvm.aarch64.sve.ldff1.nxv2i16(<n x 2 x i1>, i16*)
declare <n x 2 x i32> @llvm.aarch64.sve.ldff1.nxv2i32(<n x 2 x i1>, i32*)
declare <n x 2 x i64> @llvm.aarch64.sve.ldff1.nxv2i64(<n x 2 x i1>, i64*)
declare <n x 2 x double> @llvm.aarch64.sve.ldff1.nxv2f64(<n x 2 x i1>, double*)

declare <n x 4 x i8> @llvm.aarch64.sve.ldff1.gather.nxv4i8(<n x 4 x i1>, i8*, <n x 4 x i64>)
declare <n x 4 x i16> @llvm.aarch64.sve.ldff1.gather.nxv4i16(<n x 4 x i1>, i16*, <n x 4 x i64>)
declare <n x 4 x i32> @llvm.aarch64.sve.ldff1.gather.nxv4i32(<n x 4 x i1>, i32*, <n x 4 x i64>)
declare <n x 4 x float> @llvm.aarch64.sve.ldff1.gather.nxv4f32(<n x 4 x i1>, float*, <n x 4 x i64>)

declare <n x 2 x i8> @llvm.aarch64.sve.ldff1.gather.nxv2i8(<n x 2 x i1>, i8*, <n x 2 x i64>)
declare <n x 2 x i16> @llvm.aarch64.sve.ldff1.gather.nxv2i16(<n x 2 x i1>, i16*, <n x 2 x i64>)
declare <n x 2 x i32> @llvm.aarch64.sve.ldff1.gather.nxv2i32(<n x 2 x i1>, i32*, <n x 2 x i64>)
declare <n x 2 x i64> @llvm.aarch64.sve.ldff1.gather.nxv2i64(<n x 2 x i1>, i64*, <n x 2 x i64>)
declare <n x 2 x double> @llvm.aarch64.sve.ldff1.gather.nxv2f64(<n x 2 x i1>, double*, <n x 2 x i64>)
