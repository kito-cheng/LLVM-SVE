; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; AND
;

define <n x 16 x i1> @and_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: and_b8:
; CHECK: and p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.and.z.nxv16i1(<n x 16 x i1> %pg,
                                                            <n x 16 x i1> %a,
                                                            <n x 16 x i1> %b)
  ret <n x 16 x i1> %out
}

;
; BIC
;

define <n x 16 x i1> @bic_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: bic_b8:
; CHECK: bic p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.bic.z.nxv16i1(<n x 16 x i1> %pg,
                                                            <n x 16 x i1> %a,
                                                            <n x 16 x i1> %b)
  ret <n x 16 x i1> %out
}

;
; BRKA
;

define <n x 16 x i1> @brka_m_b8(<n x 16 x i1> %inactive, <n x 16 x i1> %pg, <n x 16 x i1> %a) {
; CHECK-LABEL: brka_m_b8:
; CHECK: brka p0.b, p1/m, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.brka.nxv16i1(<n x 16 x i1> %inactive,
                                                           <n x 16 x i1> %pg,
                                                           <n x 16 x i1> %a)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @brka_z_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a) {
; CHECK-LABEL: brka_z_b8:
; CHECK: brka p0.b, p0/z, p1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.brka.z.nxv16i1(<n x 16 x i1> %pg,
                                                             <n x 16 x i1> %a)
  ret <n x 16 x i1> %out
}

;
; BRKB
;

define <n x 16 x i1> @brkb_m_b8(<n x 16 x i1> %inactive, <n x 16 x i1> %pg, <n x 16 x i1> %a) {
; CHECK-LABEL: brkb_m_b8:
; CHECK: brkb p0.b, p1/m, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.brkb.nxv16i1(<n x 16 x i1> %inactive,
                                                           <n x 16 x i1> %pg,
                                                           <n x 16 x i1> %a)
  ret <n x 16 x i1> %out
}

define <n x 16 x i1> @brkb_z_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a) {
; CHECK-LABEL: brkb_z_b8:
; CHECK: brkb p0.b, p0/z, p1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.brkb.z.nxv16i1(<n x 16 x i1> %pg,
                                                             <n x 16 x i1> %a)
  ret <n x 16 x i1> %out
}

;
; BRKN
;

define <n x 16 x i1> @brkn_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: brkn_b8:
; CHECK: brkn p2.b, p0/z, p1.b, p2.b
; CHECK-NEXT: mov p0.b, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.brkn.z.nxv16i1(<n x 16 x i1> %pg,
                                                             <n x 16 x i1> %a,
                                                             <n x 16 x i1> %b)
  ret <n x 16 x i1> %out
}

;
; BRKPA
;

define <n x 16 x i1> @brkpa_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: brkpa_b8:
; CHECK: brkpa p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.brkpa.z.nxv16i1(<n x 16 x i1> %pg,
                                                              <n x 16 x i1> %a,
                                                              <n x 16 x i1> %b)
  ret <n x 16 x i1> %out
}

;
; BRKPB
;

define <n x 16 x i1> @brkpb_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: brkpb_b8:
; CHECK: brkpb p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.brkpb.z.nxv16i1(<n x 16 x i1> %pg,
                                                              <n x 16 x i1> %a,
                                                              <n x 16 x i1> %b)
  ret <n x 16 x i1> %out
}

;
; EOR
;

define <n x 16 x i1> @eor_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: eor_b8:
; CHECK: eor p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.eor.z.nxv16i1(<n x 16 x i1> %pg,
                                                            <n x 16 x i1> %a,
                                                            <n x 16 x i1> %b)
  ret <n x 16 x i1> %out
}

;
; NAND
;

define <n x 16 x i1> @nand_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: nand_b8:
; CHECK: nand p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.nand.z.nxv16i1(<n x 16 x i1> %pg,
                                                             <n x 16 x i1> %a,
                                                             <n x 16 x i1> %b)
  ret <n x 16 x i1> %out
}

;
; NOR
;

define <n x 16 x i1> @nor_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: nor_b8:
; CHECK: nor p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.nor.z.nxv16i1(<n x 16 x i1> %pg,
                                                            <n x 16 x i1> %a,
                                                            <n x 16 x i1> %b)
  ret <n x 16 x i1> %out
}

;
; ORN
;

define <n x 16 x i1> @orn_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: orn_b8:
; CHECK: orn p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.orn.z.nxv16i1(<n x 16 x i1> %pg,
                                                            <n x 16 x i1> %a,
                                                            <n x 16 x i1> %b)
  ret <n x 16 x i1> %out
}

;
; ORR
;

define <n x 16 x i1> @orr_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: orr_b8:
; CHECK: orr p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.orr.z.nxv16i1(<n x 16 x i1> %pg,
                                                            <n x 16 x i1> %a,
                                                            <n x 16 x i1> %b)
  ret <n x 16 x i1> %out
}

;
; PFIRST
;

define <n x 16 x i1> @pfirst_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a) {
; CHECK-LABEL: pfirst_b8:
; CHECK: pfirst p1.b, p0, p1.b
; CHECK-NEXT: mov p0.b, p1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.pfirst.nxv16i1(<n x 16 x i1> %pg,
                                                             <n x 16 x i1> %a)
  ret <n x 16 x i1> %out
}

;
; PNEXT
;

define <n x 16 x i1> @pnext_b8(<n x 16 x i1> %pg, <n x 16 x i1> %a) {
; CHECK-LABEL: pnext_b8:
; CHECK: pnext p1.b, p0, p1.b
; CHECK-NEXT: mov p0.b, p1.b
; CHECK-NEXT: ret
  %out = call <n x 16 x i1> @llvm.aarch64.sve.pnext.nxv16i1(<n x 16 x i1> %pg,
                                                            <n x 16 x i1> %a)
  ret <n x 16 x i1> %out
}

define <n x 8 x i1> @pnext_b16(<n x 8 x i1> %pg, <n x 8 x i1> %a) {
; CHECK-LABEL: pnext_b16:
; CHECK: pnext p1.h, p0, p1.h
; CHECK-NEXT: mov p0.b, p1.b
; CHECK-NEXT: ret
  %out = call <n x 8 x i1> @llvm.aarch64.sve.pnext.nxv8i1(<n x 8 x i1> %pg,
                                                          <n x 8 x i1> %a)
  ret <n x 8 x i1> %out
}

define <n x 4 x i1> @pnext_b32(<n x 4 x i1> %pg, <n x 4 x i1> %a) {
; CHECK-LABEL: pnext_b32:
; CHECK: pnext p1.s, p0, p1.s
; CHECK-NEXT: mov p0.b, p1.b
; CHECK-NEXT: ret
  %out = call <n x 4 x i1> @llvm.aarch64.sve.pnext.nxv4i1(<n x 4 x i1> %pg,
                                                          <n x 4 x i1> %a)
  ret <n x 4 x i1> %out
}

define <n x 2 x i1> @pnext_b64(<n x 2 x i1> %pg, <n x 2 x i1> %a) {
; CHECK-LABEL: pnext_b64:
; CHECK: pnext p1.d, p0, p1.d
; CHECK-NEXT: mov p0.b, p1.b
; CHECK-NEXT: ret
  %out = call <n x 2 x i1> @llvm.aarch64.sve.pnext.nxv2i1(<n x 2 x i1> %pg,
                                                          <n x 2 x i1> %a)
  ret <n x 2 x i1> %out
}

;
; PUNPKHI

define <n x 8 x i1> @punpkhi_b16(<n x 16 x i1> %a) {
; CHECK-LABEL: punpkhi_b16
; CHECK: punpkhi p0.h, p0.b
; CHECK-NEXT: ret
  %res = call <n x 8 x i1> @llvm.aarch64.sve.punpkhi.nxv8i1(<n x 16 x i1> %a)
  ret <n x 8 x i1> %res
}

;
; PUNPKLO

define <n x 8 x i1> @punpklo_b16(<n x 16 x i1> %a) {
; CHECK-LABEL: punpklo_b16
; CHECK: punpklo p0.h, p0.b
; CHECK-NEXT: ret
  %res = call <n x 8 x i1> @llvm.aarch64.sve.punpklo.nxv8i1(<n x 16 x i1> %a)
  ret <n x 8 x i1> %res
}

declare <n x 16 x i1> @llvm.aarch64.sve.and.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.bic.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.brka.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.brka.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.brkb.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.brkb.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.brkn.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.brkpa.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.brkpb.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.eor.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.nand.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.nor.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.orn.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.orr.z.nxv16i1(<n x 16 x i1>, <n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.pfirst.nxv16i1(<n x 16 x i1>, <n x 16 x i1>)

declare <n x 16 x i1> @llvm.aarch64.sve.pnext.nxv16i1(<n x 16 x i1>, <n x 16 x i1>)
declare <n x 8 x i1> @llvm.aarch64.sve.pnext.nxv8i1(<n x 8 x i1>, <n x 8 x i1>)
declare <n x 4 x i1> @llvm.aarch64.sve.pnext.nxv4i1(<n x 4 x i1>, <n x 4 x i1>)
declare <n x 2 x i1> @llvm.aarch64.sve.pnext.nxv2i1(<n x 2 x i1>, <n x 2 x i1>)

declare <n x 8 x i1> @llvm.aarch64.sve.punpkhi.nxv8i1(<n x 16 x i1>)

declare <n x 8 x i1> @llvm.aarch64.sve.punpklo.nxv8i1(<n x 16 x i1>)
