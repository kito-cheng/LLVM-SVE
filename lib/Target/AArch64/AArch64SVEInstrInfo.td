//=- AArch64SVEInstrInfo.td -  AArch64 SVE Instructions -*- tablegen -*-----=//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// AArch64 Scalable Vector Extension (SVE) Instruction definitions.
//
//===----------------------------------------------------------------------===//

def SVEAddrModeRegReg8  : ComplexPattern<i64, 2, "SelectSVERegRegAddrMode<0>", []>;
def SVEAddrModeRegReg16 : ComplexPattern<i64, 2, "SelectSVERegRegAddrMode<1>", []>;
def SVEAddrModeRegReg32 : ComplexPattern<i64, 2, "SelectSVERegRegAddrMode<2>", []>;
def SVEAddrModeRegReg64 : ComplexPattern<i64, 2, "SelectSVERegRegAddrMode<3>", []>;

def nxv2i64LslBy1 :ComplexPattern<nxv2i64, 1, "SelectVectorLslImm<1>", []>;
def nxv2i64LslBy2 :ComplexPattern<nxv2i64, 1, "SelectVectorLslImm<2>", []>;
def nxv2i64LslBy3 :ComplexPattern<nxv2i64, 1, "SelectVectorLslImm<3>", []>;

def SVE8BitLslImm : ComplexPattern<i32, 2, "Select8BitLslImm", [imm]>;

def nxv2i64UxtwLslBy3 :ComplexPattern<nxv2i64, 1, "SelectVectorUxtwLslImm<3>", []>;

def SVEUIntArithImm8 : ComplexPattern<i32, 2, "SelectSVEUIntArithImm<MVT::i8>", []>;
def SVEUIntArithImm16 : ComplexPattern<i32, 2, "SelectSVEUIntArithImm<MVT::i16>", []>;
def SVEUIntArithImm32 : ComplexPattern<i32, 2, "SelectSVEUIntArithImm<MVT::i32>", []>;
def SVEUIntArithImm64 : ComplexPattern<i32, 2, "SelectSVEUIntArithImm<MVT::i64>", []>;

def SVELogicalImm8 : ComplexPattern<i64, 1, "SelectSVELogicalImm<MVT::i8>", []>;
def SVELogicalImm16 : ComplexPattern<i64, 1, "SelectSVELogicalImm<MVT::i16>", []>;
def SVELogicalImm32 : ComplexPattern<i64, 1, "SelectSVELogicalImm<MVT::i32>", []>;
def SVELogicalImm64 : ComplexPattern<i64, 1, "SelectSVELogicalImm<MVT::i64>", []>;

def SVELShiftImm64 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<0, 64>", []>;
def SVERShiftImm64 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<1, 65>", []>;

// Wide pseudo-immediates for pattern matching to shift-by-immediate
def SVEWideLShiftImm8  : ComplexPattern<i32, 1, "SelectSVEShiftImm64<0,7>", []>;
def SVEWideLShiftImm16 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<0,15>", []>;
def SVEWideLShiftImm32 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<0,31>", []>;

def SVEWideRShiftImm8  : ComplexPattern<i32, 1, "SelectSVEShiftImm64<1,8>", []>;
def SVEWideRShiftImm16 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<1,16>", []>;
def SVEWideRShiftImm32 : ComplexPattern<i32, 1, "SelectSVEShiftImm64<1,32>", []>;

def SVELD1RQImm : ComplexPattern<i64, 1, "ShiftSVELD1RQImm<-128, 112>", []>;

// SVE CNT/INC/RDVL
def sve_rdvl_imm : ComplexPattern<i32, 1, "SelectRDVLImm<-32, 31, 16>">;
def sve_cnth_imm : ComplexPattern<i32, 1, "SelectRDVLImm<1, 16, 8>">;
def sve_cntw_imm : ComplexPattern<i32, 1, "SelectRDVLImm<1, 16, 4>">;
def sve_cntd_imm : ComplexPattern<i32, 1, "SelectRDVLImm<1, 16, 2>">;

// SVE DEC
def sve_cnth_imm_neg : ComplexPattern<i32, 1, "SelectRDVLImm<1, 16, -8>">;
def sve_cntw_imm_neg : ComplexPattern<i32, 1, "SelectRDVLImm<1, 16, -4>">;
def sve_cntd_imm_neg : ComplexPattern<i32, 1, "SelectRDVLImm<1, 16, -2>">;

let AddedComplexity = 1 in {
 class LD1RPat<ValueType vt, SDPatternOperator operator,
               Instruction load, Instruction ptrue, ValueType index_vt, ComplexPattern CP, Operand immtype> :
       Pat<(vt (AArch64dup (index_vt (operator (CP GPR64:$base, immtype:$offset))))),
           (load (ptrue 31), GPR64:$base, immtype:$offset)>;
}

multiclass SVETruncStore<ValueType vt, SDPatternOperator operator,
                         Instruction store, Instruction store_imm,
                         Instruction ptrue, ComplexPattern CP> {
  def : Pat<(operator (vt ZPR:$val), (CP GPR64:$base, GPR64:$offset)),
            (store ZPR:$val, (ptrue 31), GPR64:$base, GPR64:$offset)>;
  def : Pat<(operator (vt ZPR:$val), GPR64:$base),
            (store_imm ZPR:$val, (ptrue 31), GPR64:$base, (i64 0))>;
}

def SDT_AArch64DUP_PRED  : SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCisSameAs<0,1>, SDTCisVec<2>, SDTCVecEltisVT<2,i1>]>;
def AArch64dup_pred : SDNode<"AArch64ISD::DUP_PRED", SDT_AArch64DUP_PRED>;

def SDT_AArch64Insr  : SDTypeProfile<1, 2, [SDTCisVec<0>]>;
def AArch64insr      : SDNode<"AArch64ISD::INSR", SDT_AArch64Insr>;

def SDT_AArch64PTest : SDTypeProfile<0, 2, [SDTCisVec<0>, SDTCisSameAs<0,1>]>;
def AArch64ptest     : SDNode<"AArch64ISD::PTEST", SDT_AArch64PTest>;

def SDT_AArch64RDFFR : SDTypeProfile<1, 0, [SDTCisVec<0>, SDTCVecEltisVT<0,i1>]>;
def AArch64rdffr     : SDNode<"AArch64ISD::RDFFR", SDT_AArch64RDFFR, [SDNPHasChain]>;

def SDT_AArch64RDFFR_PRED : SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisSameAs<0,1>, SDTCVecEltisVT<0,i1>]>;
def AArch64rdffr_pred     : SDNode<"AArch64ISD::RDFFR_PRED", SDT_AArch64RDFFR_PRED, [SDNPHasChain]>;

def SDT_AArch64WRFFR : SDTypeProfile<0, 1, [SDTCisVT<0, nxv16i1>]>;
def AArch64wrffr     : SDNode<"AArch64ISD::WRFFR", SDT_AArch64WRFFR, [SDNPHasChain, SDNPOutGlue]>;

def SDT_AArch64SETFFR : SDTypeProfile<0, 0, []>;
def AArch64setffr     : SDNode<"AArch64ISD::SETFFR", SDT_AArch64SETFFR, [SDNPHasChain, SDNPOutGlue]>;

def SDT_AArch64Rev   : SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisSameAs<0,1>]>;
def AArch64rev       : SDNode<"AArch64ISD::REV", SDT_AArch64Rev>;

def SDT_AArch64BRKA  : SDTypeProfile<1, 2, [SDTCisVec<0>, SDTCisSameAs<0,1>,
                                            SDTCisSameAs<0,2>, SDTCVecEltisVT<0,i1>]>;
def AArch64brka      : SDNode<"AArch64ISD::BRKA", SDT_AArch64BRKA>;

def reinterpret_cast : SDNode<"AArch64ISD::REINTERPRET_CAST", SDTUnaryOp>;

def SDT_AArch64ReduceWithInit : SDTypeProfile<1, 3, [SDTCisVec<1>, SDTCisVec<3>]>;
def AArch64clasta_n   : SDNode<"AArch64ISD::CLASTA_N",   SDT_AArch64ReduceWithInit>;
def AArch64clastb_n   : SDNode<"AArch64ISD::CLASTB_N",   SDT_AArch64ReduceWithInit>;
def AArch64fadda_pred : SDNode<"AArch64ISD::FADDA_PRED", SDT_AArch64ReduceWithInit>;

def SDT_AArch64Reduce : SDTypeProfile<1, 2, [SDTCisVec<1>, SDTCisVec<2>]>;
def AArch64andv_pred    : SDNode<"AArch64ISD::ANDV_PRED",    SDT_AArch64Reduce>;
def AArch64eorv_pred    : SDNode<"AArch64ISD::EORV_PRED",    SDT_AArch64Reduce>;
def AArch64faddv_pred   : SDNode<"AArch64ISD::FADDV_PRED",   SDT_AArch64Reduce>;
def AArch64fmaxv_pred   : SDNode<"AArch64ISD::FMAXV_PRED",   SDT_AArch64Reduce>;
def AArch64fmaxnmv_pred : SDNode<"AArch64ISD::FMAXNMV_PRED", SDT_AArch64Reduce>;
def AArch64fminv_pred   : SDNode<"AArch64ISD::FMINV_PRED",   SDT_AArch64Reduce>;
def AArch64fminnmv_pred : SDNode<"AArch64ISD::FMINNMV_PRED", SDT_AArch64Reduce>;
def AArch64lasta        : SDNode<"AArch64ISD::LASTA",        SDT_AArch64Reduce>;
def AArch64lastb        : SDNode<"AArch64ISD::LASTB",        SDT_AArch64Reduce>;
def AArch64orv_pred     : SDNode<"AArch64ISD::ORV_PRED",     SDT_AArch64Reduce>;
def AArch64saddv_pred   : SDNode<"AArch64ISD::SADDV_PRED",   SDT_AArch64Reduce>;
def AArch64smaxv_pred   : SDNode<"AArch64ISD::SMAXV_PRED",   SDT_AArch64Reduce>;
def AArch64sminv_pred   : SDNode<"AArch64ISD::SMINV_PRED",   SDT_AArch64Reduce>;
def AArch64uaddv_pred   : SDNode<"AArch64ISD::UADDV_PRED",   SDT_AArch64Reduce>;
def AArch64umaxv_pred   : SDNode<"AArch64ISD::UMAXV_PRED",   SDT_AArch64Reduce>;
def AArch64uminv_pred   : SDNode<"AArch64ISD::UMINV_PRED",   SDT_AArch64Reduce>;

def SDT_AArch64FMinMax :SDTypeProfile<1, 3, [SDTCisVec<1>, SDTCisVec<2>,
                                             SDTCisSameAs<2, 3>]>;
def AArch64fmin_pred    : SDNode<"AArch64ISD::FMIN_PRED", SDT_AArch64FMinMax>;
def AArch64fminnm_pred  : SDNode<"AArch64ISD::FMINNM_PRED", SDT_AArch64FMinMax>;
def AArch64fmax_pred    : SDNode<"AArch64ISD::FMAX_PRED", SDT_AArch64FMinMax>;
def AArch64fmaxnm_pred  : SDNode<"AArch64ISD::FMAXNM_PRED", SDT_AArch64FMinMax>;

def SDTFPToIntOpInreg : SDTypeProfile<1, 2, [
  SDTCisInt<0>, SDTCisFP<1>, SDTCisVT<2, OtherVT>,
  SDTCisVTSmallerThanOp<2, 0>
]>;
def fp_to_sint_inreg : SDNode<"AArch64ISD::FP_TO_SINT_INREG" , SDTFPToIntOpInreg>;
def fp_to_uint_inreg : SDNode<"AArch64ISD::FP_TO_UINT_INREG" , SDTFPToIntOpInreg>;

def SDT_AArch64_LDFF1 : SDTypeProfile<1, 3, [
  SDTCisVec<0>, SDTCisVec<1>, SDTCisPtrTy<2>,
  SDTCVecEltisVT<1,i1>, SDTCisSameNumEltsAs<0,1>
]>;

def SDT_AArch64_GLDFF1 : SDTypeProfile<1, 4, [
  SDTCisVec<0>, SDTCisVec<1>, SDTCisPtrTy<2>, SDTCisVec<3>,
  SDTCVecEltisVT<1,i1>, SDTCisSameNumEltsAs<0,1>
]>;

def AArch64ldff1                    : SDNode<"AArch64ISD::LDFF1",              SDT_AArch64_LDFF1,  [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldnf1                    : SDNode<"AArch64ISD::LDNF1",              SDT_AArch64_LDFF1,  [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1_gather             : SDNode<"AArch64ISD::GLDFF1",             SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1_gather_scaled      : SDNode<"AArch64ISD::GLDFF1_SCALED",      SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1_gather_sxtw        : SDNode<"AArch64ISD::GLDFF1_SXTW",        SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1_gather_uxtw        : SDNode<"AArch64ISD::GLDFF1_UXTW",        SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1_gather_sxtw_scaled : SDNode<"AArch64ISD::GLDFF1_SXTW_SCALED", SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1_gather_uxtw_scaled : SDNode<"AArch64ISD::GLDFF1_UXTW_SCALED", SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;

def AArch64ldff1s                    : SDNode<"AArch64ISD::LDFF1S",              SDT_AArch64_LDFF1,  [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldnf1s                    : SDNode<"AArch64ISD::LDNF1S",              SDT_AArch64_LDFF1,  [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1s_gather             : SDNode<"AArch64ISD::GLDFF1S",             SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1s_gather_scaled      : SDNode<"AArch64ISD::GLDFF1S_SCALED",      SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1s_gather_sxtw        : SDNode<"AArch64ISD::GLDFF1S_SXTW",        SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1s_gather_uxtw        : SDNode<"AArch64ISD::GLDFF1S_UXTW",        SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1s_gather_sxtw_scaled : SDNode<"AArch64ISD::GLDFF1S_SXTW_SCALED", SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;
def AArch64ldff1s_gather_uxtw_scaled : SDNode<"AArch64ISD::GLDFF1S_UXTW_SCALED", SDT_AArch64_GLDFF1, [SDNPHasChain, SDNPMayLoad, SDNPOptInGlue]>;

def SDT_AArch64_LD1RQ : SDTypeProfile<1, 2, [
  SDTCisVec<0>, SDTCisVec<1>, SDTCisPtrTy<2>,
  SDTCVecEltisVT<1,i1>, SDTCisSameNumEltsAs<0,1>
]>;
def AArch64ld1rq  : SDNode<"AArch64ISD::LD1RQ",  SDT_AArch64_LD1RQ, [SDNPHasChain, SDNPMayLoad]>;

def SDT_AArch64_LDNT1 : SDTypeProfile<1, 3, [
  SDTCisVec<0>, SDTCisPtrTy<1>, SDTCisVec<2>, SDTCisSameAs<0,3>,
  SDTCVecEltisVT<2,i1>, SDTCisSameNumEltsAs<0,2>
]>;
def AArch64ldnt1  : SDNode<"AArch64ISD::LDNT1",  SDT_AArch64_LDNT1, [SDNPHasChain, SDNPMayLoad]>;

def SDT_AArch64_STNT1 : SDTypeProfile<0, 3, [
  SDTCisPtrTy<0>, SDTCisVec<1>, SDTCisVec<2>,
  SDTCVecEltisVT<1,i1>, SDTCisSameNumEltsAs<1,2>
]>;
def AArch64stnt1 : SDNode<"AArch64ISD::STNT1", SDT_AArch64_STNT1, [SDNPHasChain, SDNPMayStore]>;

def SDT_AArch64_GPRF : SDTypeProfile< 0, 5, [
  SDTCisVec<0>, SDTCisPtrTy<1>, SDTCisVec<2>, SDTCisInt<3>,
  SDTCVecEltisVT<0,i1>, SDTCisSameNumEltsAs<0, 2>
]>;

def AArch64prf_gather_s_imm         : SDNode<"AArch64ISD::GPRF_S_IMM",         SDT_AArch64_GPRF, [SDNPHasChain, SDNPMayLoad]>;
def AArch64prf_gather_d_imm         : SDNode<"AArch64ISD::GPRF_D_IMM",         SDT_AArch64_GPRF, [SDNPHasChain, SDNPMayLoad]>;
def AArch64prf_gather_d_scaled      : SDNode<"AArch64ISD::GPRF_D_SCALED",      SDT_AArch64_GPRF, [SDNPHasChain, SDNPMayLoad]>;
def AArch64prf_gather_s_sxtw_scaled : SDNode<"AArch64ISD::GPRF_S_SXTW_SCALED", SDT_AArch64_GPRF, [SDNPHasChain, SDNPMayLoad]>;
def AArch64prf_gather_s_uxtw_scaled : SDNode<"AArch64ISD::GPRF_S_UXTW_SCALED", SDT_AArch64_GPRF, [SDNPHasChain, SDNPMayLoad]>;
def AArch64prf_gather_d_sxtw_scaled : SDNode<"AArch64ISD::GPRF_D_SXTW_SCALED", SDT_AArch64_GPRF, [SDNPHasChain, SDNPMayLoad]>;
def AArch64prf_gather_d_uxtw_scaled : SDNode<"AArch64ISD::GPRF_D_UXTW_SCALED", SDT_AArch64_GPRF, [SDNPHasChain, SDNPMayLoad]>;

let Predicates = [HasSVE] in {
  defm ADD_ZZZ   : sve_int_bin_cons_arit_0<0b000, "add", add>;
  defm SUB_ZZZ   : sve_int_bin_cons_arit_0<0b001, "sub", sub>;
  defm SQADD_ZZZ : sve_int_bin_cons_arit_0<0b100, "sqadd", int_aarch64_sve_sqadd>;
  defm UQADD_ZZZ : sve_int_bin_cons_arit_0<0b101, "uqadd", int_aarch64_sve_uqadd>;
  defm SQSUB_ZZZ : sve_int_bin_cons_arit_0<0b110, "sqsub", int_aarch64_sve_sqsub>;
  defm UQSUB_ZZZ : sve_int_bin_cons_arit_0<0b111, "uqsub", int_aarch64_sve_uqsub>;

  defm ADD_ZI   : sve_int_arith_imm0<0b000, "ADD_ZZI", "add">;
  defm SUB_ZI   : sve_int_arith_imm0<0b001, "SUB_ZZI", "sub">;
  defm SUBR_ZI  : sve_int_arith_imm0<0b011, "SUBR_ZZI", "subr">;
  defm SQADD_ZI : sve_int_arith_imm0<0b100, "SQADD_ZZI", "sqadd">;
  defm UQADD_ZI : sve_int_arith_imm0<0b101, "UQADD_ZZI", "uqadd">;
  defm SQSUB_ZI : sve_int_arith_imm0<0b110, "SQSUB_ZZI", "sqsub">;
  defm UQSUB_ZI : sve_int_arith_imm0<0b111, "UQSUB_ZZI", "uqsub">;

  defm ADD_ZZI   : sve_int_arith_imm0_zzi;
  defm SUB_ZZI   : sve_int_arith_imm0_zzi;
  defm SUBR_ZZI  : sve_int_arith_imm0_zzi;
  defm SQADD_ZZI : sve_int_arith_imm0_zzi;
  defm UQADD_ZZI : sve_int_arith_imm0_zzi;
  defm SQSUB_ZZI : sve_int_arith_imm0_zzi;
  defm UQSUB_ZZI : sve_int_arith_imm0_zzi;

  multiclass sve_int_arith_immediates<string I, SDPatternOperator op> {
    def : Pat<(nxv16i8 (op (nxv16i8 ZPR:$Zs1),
                           (nxv16i8 (AArch64dup (i32 (SVEUIntArithImm8 i32:$imm, i32:$shift)))))),
              (!cast<Instruction>(I # "_B") ZPR:$Zs1, i32:$imm, i32:$shift)>;
    def : Pat<(nxv8i16 (op (nxv8i16 ZPR:$Zs1),
                           (nxv8i16 (AArch64dup (i32 (SVEUIntArithImm16 i32:$imm, i32:$shift)))))),
              (!cast<Instruction>(I # "_H") ZPR:$Zs1, i32:$imm, i32:$shift)>;
    def : Pat<(nxv4i32 (op (nxv4i32 ZPR:$Zs1),
                           (nxv4i32 (AArch64dup (i32 (SVEUIntArithImm32 i32:$imm, i32:$shift)))))),
              (!cast<Instruction>(I # "_S") ZPR:$Zs1, i32:$imm, i32:$shift)>;
    def : Pat<(nxv2i64 (op (nxv2i64 ZPR:$Zs1),
                           (nxv2i64 (AArch64dup (i64 (SVEUIntArithImm64 i32:$imm, i32:$shift)))))),
              (!cast<Instruction>(I # "_D") ZPR:$Zs1, i32:$imm, i32:$shift)>;
  }

  defm : sve_int_arith_immediates<"ADD_ZZI", add>;
  defm : sve_int_arith_immediates<"SUB_ZZI", sub>;
  // Skipping subr?
  defm : sve_int_arith_immediates<"SQADD_ZZI", int_aarch64_sve_sqadd>;
  defm : sve_int_arith_immediates<"SQSUB_ZZI", int_aarch64_sve_sqsub>;
  defm : sve_int_arith_immediates<"UQADD_ZZI", int_aarch64_sve_uqadd>;
  defm : sve_int_arith_immediates<"UQSUB_ZZI", int_aarch64_sve_uqsub>;


  // TODO: simm8 gives a slightly odd error message
  defm SMAX_ZI   : sve_int_arith_imm1<0b000, "smax", simm8>;
  defm SMIN_ZI   : sve_int_arith_imm1<0b010, "smin", simm8>;
  defm UMAX_ZI   : sve_int_arith_imm1<0b001, "umax", imm0_255dec>;
  defm UMIN_ZI   : sve_int_arith_imm1<0b011, "umin", imm0_255dec>;

  defm MUL_ZI    : sve_int_arith_imm2<0b000, "mul">;

  def AND_ZZZ : sve_int_bin_cons_log<0b00100, "and">;
  def ORR_ZZZ : sve_int_bin_cons_log<0b01100, "orr">;
  def EOR_ZZZ : sve_int_bin_cons_log<0b10100, "eor">;
  def BIC_ZZZ : sve_int_bin_cons_log<0b11100, "bic">;


  // TODO: Binopfrag?
  def : Pat<(and (nxv16i8 ZPR:$Zs1), (xor (nxv16i8 ZPR:$Zs2),
                                          (nxv16i8 (AArch64dup (i32 -1))))),
            (BIC_ZZZ ZPR:$Zs1, ZPR:$Zs2)>;

  def : Pat<(and (nxv8i16 ZPR:$Zs1), (xor (nxv8i16 ZPR:$Zs2),
                                          (nxv8i16 (AArch64dup (i32 -1))))),
            (BIC_ZZZ ZPR:$Zs1, ZPR:$Zs2)>;

  def : Pat<(and (nxv4i32 ZPR:$Zs1), (xor (nxv4i32 ZPR:$Zs2),
                                          (nxv4i32 (AArch64dup (i32 -1))))),
            (BIC_ZZZ ZPR:$Zs1, ZPR:$Zs2)>;

  def : Pat<(and (nxv2i64 ZPR:$Zs1), (xor (nxv2i64 ZPR:$Zs2),
                                          (nxv2i64 (AArch64dup (i64 -1))))),
            (BIC_ZZZ ZPR:$Zs1, ZPR:$Zs2)>;


  defm ORR_ZI : sve_int_log_imm<0b00, "orr", or,  "orn">;
  defm EOR_ZI : sve_int_log_imm<0b01, "eor", xor, "eon">;
  defm AND_ZI : sve_int_log_imm<0b10, "and", and, "bic">;

  multiclass sve_int_logical_immediates<Instruction Inst, SDPatternOperator op> {
    def : Pat<(nxv16i8 (op (nxv16i8 ZPR:$Zs1),
                           (nxv16i8 (AArch64dup (i32 (SVELogicalImm8 i64:$imm)))))),
              (Inst ZPR:$Zs1, i64:$imm)>;
    def : Pat<(nxv8i16 (op (nxv8i16 ZPR:$Zs1),
                           (nxv8i16 (AArch64dup (i32 (SVELogicalImm16 i64:$imm)))))),
              (Inst ZPR:$Zs1, i64:$imm)>;
    def : Pat<(nxv4i32 (op (nxv4i32 ZPR:$Zs1),
                           (nxv4i32 (AArch64dup (i32 (SVELogicalImm32 i64:$imm)))))),
              (Inst ZPR:$Zs1, i64:$imm)>;
    def : Pat<(nxv2i64 (op (nxv2i64 ZPR:$Zs1),
                           (nxv2i64 (AArch64dup (i64 (SVELogicalImm64 i64:$imm)))))),
              (Inst ZPR:$Zs1, i64:$imm)>;
  }

  defm : sve_int_logical_immediates<AND_ZI, and>;
  defm : sve_int_logical_immediates<EOR_ZI, xor>;
  defm : sve_int_logical_immediates<ORR_ZI, or>;

  defm ORR_ZPmZ : sve_int_bin_pred_log<0b000, "orr", "ORR_ZPZZ", int_aarch64_sve_orr, DestructiveBinaryComm>;
  defm EOR_ZPmZ : sve_int_bin_pred_log<0b001, "eor", "EOR_ZPZZ", int_aarch64_sve_eor, DestructiveBinaryComm>;
  defm AND_ZPmZ : sve_int_bin_pred_log<0b010, "and", "AND_ZPZZ", int_aarch64_sve_and, DestructiveBinaryComm>;
  defm BIC_ZPmZ : sve_int_bin_pred_log<0b011, "bic", "BIC_ZPZZ", int_aarch64_sve_bic, DestructiveBinary>;

  defm ORR_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_orr>;
  defm EOR_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_eor>;
  defm AND_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_and>;
  defm BIC_ZPZZ : sve_int_bin_pred_noncomm_zx<int_aarch64_sve_bic>;

  defm SXTB_ZPmZ : sve_int_un_pred_arit_0_h<0b000, "sxtb", int_aarch64_sve_sxtb>;
  defm UXTB_ZPmZ : sve_int_un_pred_arit_0_h<0b001, "uxtb", int_aarch64_sve_uxtb>;
  defm SXTH_ZPmZ : sve_int_un_pred_arit_0_w<0b010, "sxth", int_aarch64_sve_sxth>;
  defm UXTH_ZPmZ : sve_int_un_pred_arit_0_w<0b011, "uxth", int_aarch64_sve_uxth>;
  defm SXTW_ZPmZ : sve_int_un_pred_arit_0_d<0b100, "sxtw", int_aarch64_sve_sxtw>;
  defm UXTW_ZPmZ : sve_int_un_pred_arit_0_d<0b101, "uxtw", int_aarch64_sve_uxtw>;
  defm ABS_ZPmZ  : sve_int_un_pred_arit_0<  0b110, "abs",  int_aarch64_sve_abs>;
  defm NEG_ZPmZ  : sve_int_un_pred_arit_0<  0b111, "neg",  int_aarch64_sve_neg>;

  def : Pat<(sext_inreg (nxv2i64 ZPR:$Zs), nxv2i32), (SXTW_ZPmZ_D (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(sext_inreg (nxv2i64 ZPR:$Zs), nxv2i16), (SXTH_ZPmZ_D (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(sext_inreg (nxv2i64 ZPR:$Zs), nxv2i8),  (SXTB_ZPmZ_D (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(sext_inreg (nxv4i32 ZPR:$Zs), nxv4i16), (SXTH_ZPmZ_S (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(sext_inreg (nxv4i32 ZPR:$Zs), nxv4i8),  (SXTB_ZPmZ_S (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(sext_inreg (nxv8i16 ZPR:$Zs), nxv8i8),  (SXTB_ZPmZ_H (IMPLICIT_DEF), (PTRUE_H 31), ZPR:$Zs)>;

  // zext_inreg - 8,16,32 -> 64 // NOTE: covered by general AND of immediate
  def : Pat<(and (nxv2i64 ZPR:$Zs), (nxv2i64 (AArch64dup (i64 logical_imm64:$imms1)))),
            (AND_ZI ZPR:$Zs, logical_imm64:$imms1)>;

  // zext_inreg - 16 -> 32
  def : Pat<(and (nxv4i32 ZPR:$Zs), (nxv4i32 (AArch64dup (i32 0xFFFF)))),
            (AND_ZI ZPR:$Zs, (logical_imm64_XFORM (i64 0x0000FFFF0000FFFF)))>;

  // zext_inreg - 8 -> 32
  def : Pat<(and (nxv4i32 ZPR:$Zs), (nxv4i32 (AArch64dup (i32 0xFF)))),
            (AND_ZI ZPR:$Zs, (logical_imm64_XFORM (i64 0x000000FF000000FF)))>;

  // zext_inreg - 8 -> 16
  def : Pat<(and (nxv8i16 ZPR:$Zs), (nxv8i16 (AArch64dup (i32 0xFF)))),
            (AND_ZI ZPR:$Zs, (logical_imm64_XFORM (i64 0x00FF00FF00FF00FF)))>;

  defm ADD_ZPmZ  : sve_int_bin_pred_arit_0<0b000, "add",  "ADD_ZPZZ", int_aarch64_sve_add, DestructiveBinaryComm>;
  defm SUB_ZPmZ  : sve_int_bin_pred_arit_0<0b001, "sub",  "SUB_ZPZZ", int_aarch64_sve_sub, DestructiveBinaryCommWithRev, "SUBR_ZPmZ", 1>;
  defm SUBR_ZPmZ : sve_int_bin_pred_arit_0<0b011, "subr", "SUBR_ZPZZ", int_aarch64_sve_subr, DestructiveBinaryCommWithRev, "SUB_ZPmZ", 0>;

  defm ADD_ZPZZ  : sve_int_bin_pred_zx<int_aarch64_sve_add>;
  defm SUB_ZPZZ  : sve_int_bin_pred_zx<int_aarch64_sve_sub>;
  defm SUBR_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_subr>;

  class AddSubFoldPattern<ValueType Zty, ValueType PTy, ValueType ITy,
                          SDNode op, string I, string size>
    : Pat<(op (Zty ZPR:$Za),
              (vselect (PTy PPR:$gp), (Zty ZPR:$Zb), (SVEDup0))),
          (!cast<Instruction>(I # "_ZPmZ_" # size) PPR:$gp, ZPR:$Za, ZPR:$Zb)>;
  multiclass add_sub_folds<SDNode Op, string I> {
  def : AddSubFoldPattern<nxv16i8, nxv16i1, i32, Op, I, "B">;
  def : AddSubFoldPattern<nxv8i16, nxv8i1, i32, Op, I, "H">;
  def : AddSubFoldPattern<nxv4i32, nxv4i1, i32, Op, I, "S">;
  def : AddSubFoldPattern<nxv2i64, nxv2i1, i64, Op, I, "D">;
  }
  defm : add_sub_folds<add, "ADD">;
  defm : add_sub_folds<sub, "SUB">;

  defm SMAX_ZPmZ : sve_int_bin_pred_arit_1<0b000, "smax", "SMAX_ZPZZ", int_aarch64_sve_smax>;
  defm UMAX_ZPmZ : sve_int_bin_pred_arit_1<0b001, "umax", "UMAX_ZPZZ", int_aarch64_sve_umax>;
  defm SMIN_ZPmZ : sve_int_bin_pred_arit_1<0b010, "smin", "SMIN_ZPZZ", int_aarch64_sve_smin>;
  defm UMIN_ZPmZ : sve_int_bin_pred_arit_1<0b011, "umin", "UMIN_ZPZZ", int_aarch64_sve_umin>;
  defm SABD_ZPmZ : sve_int_bin_pred_arit_1<0b100, "sabd", "SABD_ZPZZ", int_aarch64_sve_sabd>;
  defm UABD_ZPmZ : sve_int_bin_pred_arit_1<0b101, "uabd", "UABD_ZPZZ", int_aarch64_sve_uabd>;

  defm SMAX_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_smax>;
  defm UMAX_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_umax>;
  defm SMIN_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_smin>;
  defm UMIN_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_umin>;
  defm SABD_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_sabd>;
  defm UABD_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_uabd>;

  // min and max fold like this:
  // select($gp AND ($a > $b), $a, $b) => max($gp, $b, $a)
  class MinMaxFoldPattern1<ValueType ZTy, ValueType PTy, CondCode Op, string I,
                          string size>
    : Pat<(ZTy (vselect (and (PTy PPR:$gp),
                             (setcc (ZTy ZPR:$Zs1), (ZTy ZPR:$Zs2), Op)),
                        (ZTy ZPR:$Zs1), (ZTy ZPR:$Zs2))),
           (!cast<Instruction>(I # "_ZPmZ_" # size) PPR:$gp, ZPR:$Zs2, ZPR:$Zs1)>;
  // Same as above but for inverted operands and condition code.
  class MinMaxFoldPattern2<ValueType ZTy, ValueType PTy, CondCode Op, string I,
                          string size>
    : Pat<(ZTy (vselect (and (PTy PPR:$gp),
                             (setcc (ZTy ZPR:$Zs1), (ZTy ZPR:$Zs2), Op)),
                        (ZTy ZPR:$Zs2), (ZTy ZPR:$Zs1))),
           (!cast<Instruction>(I # "_ZPmZ_" # size) PPR:$gp, ZPR:$Zs1, ZPR:$Zs2)>;
  multiclass min_max_folds<CondCode Op1, CondCode Op2, string I> {
  def : MinMaxFoldPattern1<nxv16i8, nxv16i1, Op1, I, "B">;
  def : MinMaxFoldPattern1<nxv8i16, nxv8i1, Op1, I, "H">;
  def : MinMaxFoldPattern1<nxv4i32, nxv4i1, Op1, I, "S">;
  def : MinMaxFoldPattern1<nxv2i64, nxv2i1, Op1, I, "D">;
  def : MinMaxFoldPattern2<nxv16i8, nxv16i1, Op2, I, "B">;
  def : MinMaxFoldPattern2<nxv8i16, nxv8i1, Op2, I, "H">;
  def : MinMaxFoldPattern2<nxv4i32, nxv4i1, Op2, I, "S">;
  def : MinMaxFoldPattern2<nxv2i64, nxv2i1, Op2, I, "D">;
  }
  defm : min_max_folds<SETGT, SETLT, "SMAX">;
  defm : min_max_folds<SETUGT, SETULT, "UMAX">;
  defm : min_max_folds<SETLT, SETGT, "SMIN">;
  defm : min_max_folds<SETULT, SETUGT, "UMIN">;

  defm ASR_ZPmI  : sve_int_bin_pred_shift_0_right<0b000, "asr", "ASR_ZPZI">;
  defm LSR_ZPmI  : sve_int_bin_pred_shift_0_right<0b001, "lsr", "LSR_ZPZI">;
  defm LSL_ZPmI  : sve_int_bin_pred_shift_0_left< 0b011, "lsl">;
  defm ASRD_ZPmI : sve_int_bin_pred_shift_0_right<0b100, "asrd", "ASRD_ZPZI", int_aarch64_sve_asrd>;
  defm ASRD_ZPZI : sve_int_bin_pred_shift_0_right_zx<int_aarch64_sve_asrd>;

  defm ASR_ZPmZ  : sve_int_bin_pred_shift_1<0b000, "asr", "ASR_ZPZZ", int_aarch64_sve_asr, "ASRR_ZPmZ", 1>;
  defm LSR_ZPmZ  : sve_int_bin_pred_shift_1<0b001, "lsr", "LSR_ZPZZ", int_aarch64_sve_lsr, "LSRR_ZPmZ", 1>;
  defm LSL_ZPmZ  : sve_int_bin_pred_shift_1<0b011, "lsl", "LSL_ZPZZ", int_aarch64_sve_lsl, "LSLR_ZPmZ", 1>;
  defm ASRR_ZPmZ : sve_int_bin_pred_shift_1<0b100, "asrr", "ASRR_ZPZZ", null_frag, "ASR_ZPmZ", 0>;
  defm LSRR_ZPmZ : sve_int_bin_pred_shift_1<0b101, "lsrr", "LSRR_ZPZZ", null_frag, "LSR_ZPmZ", 0>;
  defm LSLR_ZPmZ : sve_int_bin_pred_shift_1<0b111, "lslr", "LSLR_ZPZZ", null_frag, "LSL_ZPmZ", 0>;

  defm ASR_ZPZZ  : sve_int_bin_pred_zx<int_aarch64_sve_asr>;
  defm LSR_ZPZZ  : sve_int_bin_pred_zx<int_aarch64_sve_lsr>;
  defm LSL_ZPZZ  : sve_int_bin_pred_zx<int_aarch64_sve_lsl>;

  defm ASR_WIDE_ZPmZ : sve_int_bin_pred_shift_2<0b000, "asr", int_aarch64_sve_asr_wide>;
  defm LSR_WIDE_ZPmZ : sve_int_bin_pred_shift_2<0b001, "lsr", int_aarch64_sve_lsr_wide>;
  defm LSL_WIDE_ZPmZ : sve_int_bin_pred_shift_2<0b011, "lsl", int_aarch64_sve_lsl_wide>;

  defm ASR_WIDE_ZZZ : sve_int_bin_cons_shift_a<0b00, "asr">;
  defm LSR_WIDE_ZZZ : sve_int_bin_cons_shift_a<0b01, "lsr">;
  defm LSL_WIDE_ZZZ : sve_int_bin_cons_shift_a<0b11, "lsl">;

  defm MUL_ZPmZ   : sve_int_bin_pred_arit_2<0b000, "mul",   "MUL_ZPZZ", int_aarch64_sve_mul>;
  defm SMULH_ZPmZ : sve_int_bin_pred_arit_2<0b010, "smulh", "SMULH_ZPZZ", int_aarch64_sve_smulh>;
  defm UMULH_ZPmZ : sve_int_bin_pred_arit_2<0b011, "umulh", "UMULH_ZPZZ", int_aarch64_sve_umulh>;

  defm MUL_ZPZZ   : sve_int_bin_pred_zx<int_aarch64_sve_mul>;
  defm SMULH_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_smulh>;
  defm UMULH_ZPZZ : sve_int_bin_pred_zx<int_aarch64_sve_umulh>;

  // SVE predicated integer multiply add/sub
  defm MAD_ZPmZZ : sve_int_mladdsub_vvv_pred<0b0, "mad", "MAD_ZPZZZ", int_aarch64_sve_mad, "MLA_ZPmZZ", 1>;
  defm MSB_ZPmZZ : sve_int_mladdsub_vvv_pred<0b1, "msb", "MSB_ZPZZZ", int_aarch64_sve_msb, "MLS_ZPmZZ", 1>;
  defm MLA_ZPmZZ : sve_int_mlas_vvv_pred<0b0, "mla", "MLA_ZPZZZ", int_aarch64_sve_mla, "MAD_ZPmZZ", 0>;
  defm MLS_ZPmZZ : sve_int_mlas_vvv_pred<0b1, "mls", "MLS_ZPZZZ", int_aarch64_sve_mls, "MSB_ZPmZZ", 0>;

  defm MAD_ZPZZZ : sve_int_ternary_pred_zx<int_aarch64_sve_mad>;
  defm MSB_ZPZZZ : sve_int_ternary_pred_zx<int_aarch64_sve_msb>;
  defm MLA_ZPZZZ : sve_int_ternary_pred_zx<int_aarch64_sve_mla>;
  defm MLS_ZPZZZ : sve_int_ternary_pred_zx<int_aarch64_sve_mls>;

  class MLASPattern<ValueType ZTy, SDNode op, string I, string size>
    : Pat<(ZTy (op (ZTy ZPR:$Zs3), (mul (ZTy ZPR:$Zs1), (ZTy ZPR:$Zs2)))),
          (!cast<Instruction>(I # size)
                (!cast<Instruction>("PTRUE_" ## size) 31), ZPR:$Zs3, ZPR:$Zs1, ZPR:$Zs2)>;
  multiclass mlas_folds<SDNode op, string I> {
  def : MLASPattern<nxv16i8, op, I, "B">;
  def : MLASPattern<nxv8i16, op, I, "H">;
  def : MLASPattern<nxv4i32, op, I, "S">;
  def : MLASPattern<nxv2i64, op, I, "D">;
  }
  defm : mlas_folds<add, "MLA_ZPZZZ_UNDEF_">;
  defm : mlas_folds<sub, "MLS_ZPZZZ_UNDEF_">;

  // SVE predicated integer reductions.
  defm SADDV_VPZ : sve_int_reduce_0_saddv<0b000, "saddv", AArch64saddv_pred>;
  defm UADDV_VPZ : sve_int_reduce_0<0b001, "uaddv", AArch64uaddv_pred>;
  defm SMAXV_VPZ : sve_int_reduce_1<0b000, "smaxv", AArch64smaxv_pred>;
  defm UMAXV_VPZ : sve_int_reduce_1<0b001, "umaxv", AArch64umaxv_pred>;
  defm SMINV_VPZ : sve_int_reduce_1<0b010, "sminv", AArch64sminv_pred>;
  defm UMINV_VPZ : sve_int_reduce_1<0b011, "uminv", AArch64uminv_pred>;
  defm ORV_VPZ   : sve_int_reduce_2<0b000, "orv",   AArch64orv_pred>;
  defm EORV_VPZ  : sve_int_reduce_2<0b001, "eorv",  AArch64eorv_pred>;
  defm ANDV_VPZ  : sve_int_reduce_2<0b010, "andv",  AArch64andv_pred>;

  def EXT_ZZI : sve_int_perm_extract_i<"ext", AArch64ext>;

  // SVE floating point reductions.
  defm FADDA_VPZ   : sve_fp_2op_p_vd<0b000, "fadda",   AArch64fadda_pred>;
  defm FADDV_VPZ   : sve_fp_fast_red<0b000, "faddv",   AArch64faddv_pred>;
  defm FMAXNMV_VPZ : sve_fp_fast_red<0b100, "fmaxnmv", AArch64fmaxnmv_pred>;
  defm FMINNMV_VPZ : sve_fp_fast_red<0b101, "fminnmv", AArch64fminnmv_pred>;
  defm FMAXV_VPZ   : sve_fp_fast_red<0b110, "fmaxv",   AArch64fmaxv_pred>;
  defm FMINV_VPZ   : sve_fp_fast_red<0b111, "fminv",   AArch64fminv_pred>;

  def CTERMEQ_WW : sve_int_cterm<0b0, 0b0, "ctermeq", GPR32>;
  def CTERMNE_WW : sve_int_cterm<0b0, 0b1, "ctermne", GPR32>;
  def CTERMEQ_XX : sve_int_cterm<0b1, 0b0, "ctermeq", GPR64>;
  def CTERMNE_XX : sve_int_cterm<0b1, 0b1, "ctermne", GPR64>;

  defm WHILELT_PWW : sve_int_while4_rr<0b010, "whilelt", int_aarch64_sve_whilelt>;
  defm WHILELE_PWW : sve_int_while4_rr<0b011, "whilele", int_aarch64_sve_whilele>;
  defm WHILELO_PWW : sve_int_while4_rr<0b110, "whilelo", int_aarch64_sve_whilelo>;
  defm WHILELS_PWW : sve_int_while4_rr<0b111, "whilels", int_aarch64_sve_whilels>;

  defm WHILELT_PXX : sve_int_while8_rr<0b010, "whilelt", int_aarch64_sve_whilelt>;
  defm WHILELE_PXX : sve_int_while8_rr<0b011, "whilele", int_aarch64_sve_whilele>;
  defm WHILELO_PXX : sve_int_while8_rr<0b110, "whilelo", int_aarch64_sve_whilelo>;
  defm WHILELS_PXX : sve_int_while8_rr<0b111, "whilels", int_aarch64_sve_whilels>;

  multiclass unpred_from_pred_two_op<SDNode N, string I> {
  def : Pat<(nxv16i8 (N (nxv16i8 ZPR:$Zs1), (nxv16i8 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_B") (PTRUE_B 31), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv8i16 (N (nxv8i16 ZPR:$Zs1), (nxv8i16 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_H") (PTRUE_H 31), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv4i32 (N (nxv4i32 ZPR:$Zs1), (nxv4i32 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_S") (PTRUE_S 31), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2i64 (N (nxv2i64 ZPR:$Zs1), (nxv2i64 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_D") (PTRUE_D 31), ZPR:$Zs1, ZPR:$Zs2)>;
  }
  defm : unpred_from_pred_two_op<mul,  "MUL_ZPZZ_UNDEF">;
  defm : unpred_from_pred_two_op<shl,  "LSL_ZPZZ_UNDEF">;
  defm : unpred_from_pred_two_op<sra,  "ASR_ZPZZ_UNDEF">;
  defm : unpred_from_pred_two_op<srl,  "LSR_ZPZZ_UNDEF">;

  defm SDIV_ZPmZ  : sve_int_bin_pred_arit_2_div<0b100, "sdiv",  "SDIV_ZPZZ", int_aarch64_sve_sdiv, "SDIVR_ZPmZ", 1>;
  defm UDIV_ZPmZ  : sve_int_bin_pred_arit_2_div<0b101, "udiv",  "UDIV_ZPZZ", int_aarch64_sve_udiv, "UDIVR_ZPmZ", 1>;
  defm SDIVR_ZPmZ : sve_int_bin_pred_arit_2_div<0b110, "sdivr", "SDIVR_ZPZZ", int_aarch64_sve_sdivr, "SDIV_ZPmZ", 0>;
  defm UDIVR_ZPmZ : sve_int_bin_pred_arit_2_div<0b111, "udivr", "UDIVR_ZPZZ", int_aarch64_sve_udivr, "UDIV_ZPmZ", 0>;

  defm SDIV_ZPZZ  : sve_int_bin_pred_arit_2_div_zx<int_aarch64_sve_sdiv>;
  defm UDIV_ZPZZ  : sve_int_bin_pred_arit_2_div_zx<int_aarch64_sve_udiv>;
  defm SDIVR_ZPZZ : sve_int_bin_pred_arit_2_div_zx<int_aarch64_sve_sdivr>;
  defm UDIVR_ZPZZ : sve_int_bin_pred_arit_2_div_zx<int_aarch64_sve_udivr>;

  multiclass unpred_from_pred_two_op_div<SDNode N, string I> {
  def : Pat<(nxv4i32 (N (nxv4i32 ZPR:$Zs1), (nxv4i32 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_S") (PTRUE_S 31), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2i64 (N (nxv2i64 ZPR:$Zs1), (nxv2i64 ZPR:$Zs2))),
            (!cast<Instruction>(I # "_D") (PTRUE_D 31), ZPR:$Zs1, ZPR:$Zs2)>;
  }
  defm : unpred_from_pred_two_op_div<sdiv, "SDIV_ZPZZ_UNDEF">;
  defm : unpred_from_pred_two_op_div<udiv, "UDIV_ZPZZ_UNDEF">;

  defm LDR_ZXI : sve_mem_32b_fill<"ldr">;
  defm STR_ZXI : sve_mem_spill<"str">;

  // Pseudo instructions representing unpredicated LDR and STR for ZPR2,3,4.
  // These later get expanded to PTRUE of ST2/LD2 etc
  let mayLoad = 1, hasSideEffects = 0 in {
  def LDR_ZZXI   : Pseudo<(outs   ZZ_b:$Zd), (ins GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  def LDR_ZZZXI  : Pseudo<(outs  ZZZ_b:$Zd), (ins GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  def LDR_ZZZZXI : Pseudo<(outs ZZZZ_b:$Zd), (ins GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  }
  let mayStore = 1, hasSideEffects = 0 in {
  def STR_ZZXI   : Pseudo<(outs), (ins   ZZ_b:$Zs, GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  def STR_ZZZXI  : Pseudo<(outs), (ins  ZZZ_b:$Zs, GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  def STR_ZZZZXI : Pseudo<(outs), (ins ZZZZ_b:$Zs, GPR64sp:$sp, simm4:$offset),[]>, Sched<[]>;
  }

  foreach type = ["nxv16i8", "nxv8i16", "nxv4i32", "nxv2i64"] in {
    def : Pat<(and (!cast<ValueType>(type) ZPR:$src1),
                   (!cast<ValueType>(type) ZPR:$src2)),
              (AND_ZZZ ZPR:$src1, ZPR:$src2)>;
    def : Pat<(or (!cast<ValueType>(type) ZPR:$src1),
                  (!cast<ValueType>(type) ZPR:$src2)),
              (ORR_ZZZ ZPR:$src1, ZPR:$src2)>;
    def : Pat<(xor (!cast<ValueType>(type) ZPR:$src1),
                   (!cast<ValueType>(type) ZPR:$src2)),
              (EOR_ZZZ ZPR:$src1, ZPR:$src2)>;
  }

  // LD1B...
  defm LD1B    : sve_mem_cld_ss<0b0000, "ld1b",  Z_b, ZPR8,  GPR64NoXZRshifted8>;
  defm LD1B_H  : sve_mem_cld_ss<0b0001, "ld1b",  Z_h, ZPR16, GPR64NoXZRshifted8>;
  defm LD1B_S  : sve_mem_cld_ss<0b0010, "ld1b",  Z_s, ZPR32, GPR64NoXZRshifted8>;
  defm LD1B_D  : sve_mem_cld_ss<0b0011, "ld1b",  Z_d, ZPR64, GPR64NoXZRshifted8>;
  defm LD1SW_D : sve_mem_cld_ss<0b0100, "ld1sw", Z_d, ZPR64, GPR64NoXZRshifted32>;
  defm LD1H    : sve_mem_cld_ss<0b0101, "ld1h",  Z_h, ZPR16, GPR64NoXZRshifted16>;
  defm LD1H_S  : sve_mem_cld_ss<0b0110, "ld1h",  Z_s, ZPR32, GPR64NoXZRshifted16>;
  defm LD1H_D  : sve_mem_cld_ss<0b0111, "ld1h",  Z_d, ZPR64, GPR64NoXZRshifted16>;
  defm LD1SH_D : sve_mem_cld_ss<0b1000, "ld1sh", Z_d, ZPR64, GPR64NoXZRshifted16>;
  defm LD1SH_S : sve_mem_cld_ss<0b1001, "ld1sh", Z_s, ZPR32, GPR64NoXZRshifted16>;
  defm LD1W    : sve_mem_cld_ss<0b1010, "ld1w",  Z_s, ZPR32, GPR64NoXZRshifted32>;
  defm LD1W_D  : sve_mem_cld_ss<0b1011, "ld1w",  Z_d, ZPR64, GPR64NoXZRshifted32>;
  defm LD1SB_D : sve_mem_cld_ss<0b1100, "ld1sb", Z_d, ZPR64, GPR64NoXZRshifted8>;
  defm LD1SB_S : sve_mem_cld_ss<0b1101, "ld1sb", Z_s, ZPR32, GPR64NoXZRshifted8>;
  defm LD1SB_H : sve_mem_cld_ss<0b1110, "ld1sb", Z_h, ZPR16, GPR64NoXZRshifted8>;
  defm LD1D    : sve_mem_cld_ss<0b1111, "ld1d",  Z_d, ZPR64, GPR64NoXZRshifted64>;

  // continuous load with reg+immediate
  defm LD1B_IMM    : sve_mem_cld_si<0b0000, "ld1b",  Z_b, ZPR8>;
  defm LD1B_H_IMM  : sve_mem_cld_si<0b0001, "ld1b",  Z_h, ZPR16>;
  defm LD1B_S_IMM  : sve_mem_cld_si<0b0010, "ld1b",  Z_s, ZPR32>;
  defm LD1B_D_IMM  : sve_mem_cld_si<0b0011, "ld1b",  Z_d, ZPR64>;
  defm LD1SB_H_IMM : sve_mem_cld_si<0b1110, "ld1sb", Z_h, ZPR16>;
  defm LD1SB_S_IMM : sve_mem_cld_si<0b1101, "ld1sb", Z_s, ZPR32>;
  defm LD1SB_D_IMM : sve_mem_cld_si<0b1100, "ld1sb", Z_d, ZPR64>;
  defm LD1H_IMM    : sve_mem_cld_si<0b0101, "ld1h",  Z_h, ZPR16>;
  defm LD1H_S_IMM  : sve_mem_cld_si<0b0110, "ld1h",  Z_s, ZPR32>;
  defm LD1H_D_IMM  : sve_mem_cld_si<0b0111, "ld1h",  Z_d, ZPR64>;
  defm LD1SH_S_IMM : sve_mem_cld_si<0b1001, "ld1sh", Z_s, ZPR32>;
  defm LD1SH_D_IMM : sve_mem_cld_si<0b1000, "ld1sh", Z_d, ZPR64>;
  defm LD1W_IMM    : sve_mem_cld_si<0b1010, "ld1w",  Z_s, ZPR32>;
  defm LD1W_D_IMM  : sve_mem_cld_si<0b1011, "ld1w",  Z_d, ZPR64>;
  defm LD1SW_D_IMM : sve_mem_cld_si<0b0100, "ld1sw", Z_d, ZPR64>;
  defm LD1D_IMM    : sve_mem_cld_si<0b1111, "ld1d",  Z_d, ZPR64>;

  // non-faulting continuous load with reg+immediate
  defm LDNF1B_IMM    : sve_mem_cldnf_si<0b0000, "ldnf1b",  Z_b, ZPR8>;
  defm LDNF1B_H_IMM  : sve_mem_cldnf_si<0b0001, "ldnf1b",  Z_h, ZPR16>;
  defm LDNF1B_S_IMM  : sve_mem_cldnf_si<0b0010, "ldnf1b",  Z_s, ZPR32>;
  defm LDNF1B_D_IMM  : sve_mem_cldnf_si<0b0011, "ldnf1b",  Z_d, ZPR64>;
  defm LDNF1SB_H_IMM : sve_mem_cldnf_si<0b1110, "ldnf1sb", Z_h, ZPR16>;
  defm LDNF1SB_S_IMM : sve_mem_cldnf_si<0b1101, "ldnf1sb", Z_s, ZPR32>;
  defm LDNF1SB_D_IMM : sve_mem_cldnf_si<0b1100, "ldnf1sb", Z_d, ZPR64>;
  defm LDNF1H_IMM    : sve_mem_cldnf_si<0b0101, "ldnf1h",  Z_h, ZPR16>;
  defm LDNF1H_S_IMM  : sve_mem_cldnf_si<0b0110, "ldnf1h",  Z_s, ZPR32>;
  defm LDNF1H_D_IMM  : sve_mem_cldnf_si<0b0111, "ldnf1h",  Z_d, ZPR64>;
  defm LDNF1SH_S_IMM : sve_mem_cldnf_si<0b1001, "ldnf1sh", Z_s, ZPR32>;
  defm LDNF1SH_D_IMM : sve_mem_cldnf_si<0b1000, "ldnf1sh", Z_d, ZPR64>;
  defm LDNF1W_IMM    : sve_mem_cldnf_si<0b1010, "ldnf1w",  Z_s, ZPR32>;
  defm LDNF1W_D_IMM  : sve_mem_cldnf_si<0b1011, "ldnf1w",  Z_d, ZPR64>;
  defm LDNF1SW_D_IMM : sve_mem_cldnf_si<0b0100, "ldnf1sw", Z_d, ZPR64>;
  defm LDNF1D_IMM    : sve_mem_cldnf_si<0b1111, "ldnf1d",  Z_d, ZPR64>;

  // LD1R loads (splat scalar to vector)
  defm LD1RB_IMM    : sve_mem_ld_dup<0b00, 0b00, "ld1rb",  Z_b, ZPR8, uimm6b>;
  defm LD1RB_H_IMM  : sve_mem_ld_dup<0b00, 0b01, "ld1rb",  Z_h, ZPR16, uimm6b>;
  defm LD1RB_S_IMM  : sve_mem_ld_dup<0b00, 0b10, "ld1rb",  Z_s, ZPR32, uimm6b>;
  defm LD1RB_D_IMM  : sve_mem_ld_dup<0b00, 0b11, "ld1rb",  Z_d, ZPR64, uimm6b>;
  defm LD1RSB_H_IMM : sve_mem_ld_dup<0b11, 0b10, "ld1rsb", Z_h, ZPR16, uimm6b>;
  defm LD1RSB_S_IMM : sve_mem_ld_dup<0b11, 0b01, "ld1rsb", Z_s, ZPR32, uimm6b>;
  defm LD1RSB_D_IMM : sve_mem_ld_dup<0b11, 0b00, "ld1rsb", Z_d, ZPR64, uimm6b>;
  defm LD1RH_IMM    : sve_mem_ld_dup<0b01, 0b01, "ld1rh",  Z_h, ZPR16, uimm6h>;
  defm LD1RH_S_IMM  : sve_mem_ld_dup<0b01, 0b10, "ld1rh",  Z_s, ZPR32, uimm6h>;
  defm LD1RH_D_IMM  : sve_mem_ld_dup<0b01, 0b11, "ld1rh",  Z_d, ZPR64, uimm6h>;
  defm LD1RSH_S_IMM : sve_mem_ld_dup<0b10, 0b01, "ld1rsh", Z_s, ZPR32, uimm6h>;
  defm LD1RSH_D_IMM : sve_mem_ld_dup<0b10, 0b00, "ld1rsh", Z_d, ZPR64, uimm6h>;
  defm LD1RW_IMM    : sve_mem_ld_dup<0b10, 0b10, "ld1rw",  Z_s, ZPR32, uimm6w>;
  defm LD1RW_D_IMM  : sve_mem_ld_dup<0b10, 0b11, "ld1rw",  Z_d, ZPR64, uimm6w>;
  defm LD1RSW_IMM   : sve_mem_ld_dup<0b01, 0b00, "ld1rsw", Z_d, ZPR64, uimm6w>;
  defm LD1RD_IMM    : sve_mem_ld_dup<0b11, 0b11, "ld1rd",  Z_d, ZPR64, uimm6d>;
  defm LD1RQ_B_IMM  : sve_mem_ldqr_si<0b00, "ld1rqb", Z_b, ZPR8>;
  defm LD1RQ_H_IMM  : sve_mem_ldqr_si<0b01, "ld1rqh", Z_h, ZPR16>;
  defm LD1RQ_W_IMM  : sve_mem_ldqr_si<0b10, "ld1rqw", Z_s, ZPR32>;
  defm LD1RQ_D_IMM  : sve_mem_ldqr_si<0b11, "ld1rqd", Z_d, ZPR64>;
  defm LD1RQ_B      : sve_mem_ldqr_ss<0b00, "ld1rqb", Z_b, ZPR8,  GPR64NoXZRshifted8>;
  defm LD1RQ_H      : sve_mem_ldqr_ss<0b01, "ld1rqh", Z_h, ZPR16, GPR64NoXZRshifted16>;
  defm LD1RQ_W      : sve_mem_ldqr_ss<0b10, "ld1rqw", Z_s, ZPR32, GPR64NoXZRshifted32>;
  defm LD1RQ_D      : sve_mem_ldqr_ss<0b11, "ld1rqd", Z_d, ZPR64, GPR64NoXZRshifted64>;

  // LDR1 of 8-bit data
  def : LD1RPat<nxv16i8, azextloadi8, LD1RB_IMM,    PTRUE_B, i32, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv8i16, azextloadi8, LD1RB_H_IMM,  PTRUE_H, i32, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv4i32, azextloadi8, LD1RB_S_IMM,  PTRUE_S, i32, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv2i64, azextloadi8, LD1RB_D_IMM,  PTRUE_D, i64, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv8i16, sextloadi8,  LD1RSB_H_IMM, PTRUE_H, i32, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv4i32, sextloadi8,  LD1RSB_S_IMM, PTRUE_S, i32, am_indexed8_6b, uimm6b>;
  def : LD1RPat<nxv2i64, sextloadi8,  LD1RSB_D_IMM, PTRUE_D, i64, am_indexed8_6b, uimm6b>;

  // LDR1 of 16-bit data
  def : LD1RPat<nxv8i16, azextloadi16, LD1RH_IMM,    PTRUE_H, i32, am_indexed16_6b, uimm6h>;
  def : LD1RPat<nxv4i32, azextloadi16, LD1RH_S_IMM,  PTRUE_S, i32, am_indexed16_6b, uimm6h>;
  def : LD1RPat<nxv2i64, azextloadi16, LD1RH_D_IMM,  PTRUE_D, i64, am_indexed16_6b, uimm6h>;
  def : LD1RPat<nxv4i32, sextloadi16,  LD1RSH_S_IMM, PTRUE_S, i32, am_indexed16_6b, uimm6h>;
  def : LD1RPat<nxv2i64, sextloadi16,  LD1RSH_D_IMM, PTRUE_D, i64, am_indexed16_6b, uimm6h>;

  // LDR1 of 32-bit data
  def : LD1RPat<nxv4i32, load,         LD1RW_IMM,   PTRUE_S, i32, am_indexed32_6b, uimm6w>;
  def : LD1RPat<nxv2i64, azextloadi32, LD1RW_D_IMM, PTRUE_D, i64, am_indexed32_6b, uimm6w>;
  def : LD1RPat<nxv2i64, sextloadi32,  LD1RSW_IMM,  PTRUE_D, i64, am_indexed32_6b, uimm6w>;

  // LDR1 of 64-bit data
  def : LD1RPat<nxv2i64, load, LD1RD_IMM, PTRUE_D, i64, am_indexed64_6b, uimm6d>;

  // LD1R of FP data
  def : Pat<(nxv4f32 (AArch64dup (f32 (load (am_indexed32_6b GPR64:$Rn, uimm6w:$offset))))),
            (LD1RW_IMM (PTRUE_S 31), GPR64:$Rn, uimm6w:$offset)>;
  def : Pat<(nxv2f32 (AArch64dup (f32 (load (am_indexed32_6b GPR64:$Rn, uimm6w:$offset))))),
            (LD1RW_D_IMM (PTRUE_D 31), GPR64:$Rn, uimm6w:$offset)>;
  def : Pat<(nxv2f64 (AArch64dup (f64 (load (am_indexed64_6b GPR64:$Rn, uimm6d:$offset))))),
            (LD1RD_IMM (PTRUE_D 31), GPR64:$Rn, uimm6d:$offset)>;

  // LD1R of 128-bit masked data
  def : Pat<(nxv16i8 (AArch64ld1rq PPR:$gp, GPR64:$base)),
            (LD1RQ_B_IMM $gp, $base, (i64 0))>;
  def : Pat<(nxv8i16 (AArch64ld1rq PPR:$gp, GPR64:$base)),
            (LD1RQ_H_IMM $gp, $base, (i64 0))>;
  def : Pat<(nxv4i32 (AArch64ld1rq PPR:$gp, GPR64:$base)),
            (LD1RQ_W_IMM $gp, $base, (i64 0))>;
  def : Pat<(nxv2i64 (AArch64ld1rq PPR:$gp, GPR64:$base)),
            (LD1RQ_D_IMM $gp, $base, (i64 0))>;

  def : Pat<(nxv16i8 (AArch64ld1rq PPR:$gp, (add GPR64:$base, (SVELD1RQImm i64:$imm)))),
            (LD1RQ_B_IMM $gp, $base, (simm4s16:$imm))>;
  def : Pat<(nxv8i16 (AArch64ld1rq PPR:$gp, (add GPR64:$base, (SVELD1RQImm i64:$imm)))),
            (LD1RQ_H_IMM $gp, $base, (simm4s16:$imm))>;
  def : Pat<(nxv4i32 (AArch64ld1rq PPR:$gp, (add GPR64:$base, (SVELD1RQImm i64:$imm)))),
            (LD1RQ_W_IMM $gp, $base, (simm4s16:$imm))>;
  def : Pat<(nxv2i64 (AArch64ld1rq PPR:$gp, (add GPR64:$base, (SVELD1RQImm i64:$imm)))),
            (LD1RQ_D_IMM $gp, $base, (simm4s16:$imm))>;

  // LDFF1B...
  defm LDFF1B    : sve_mem_cldff_ss<0b0000, "ldff1b",  Z_b, ZPR8,  GPR64shifted8>;
  defm LDFF1B_H  : sve_mem_cldff_ss<0b0001, "ldff1b",  Z_h, ZPR16, GPR64shifted8>;
  defm LDFF1B_S  : sve_mem_cldff_ss<0b0010, "ldff1b",  Z_s, ZPR32, GPR64shifted8>;
  defm LDFF1B_D  : sve_mem_cldff_ss<0b0011, "ldff1b",  Z_d, ZPR64, GPR64shifted8>;
  defm LDFF1SW_D : sve_mem_cldff_ss<0b0100, "ldff1sw", Z_d, ZPR64, GPR64shifted32>;
  defm LDFF1H    : sve_mem_cldff_ss<0b0101, "ldff1h",  Z_h, ZPR16, GPR64shifted16>;
  defm LDFF1H_S  : sve_mem_cldff_ss<0b0110, "ldff1h",  Z_s, ZPR32, GPR64shifted16>;
  defm LDFF1H_D  : sve_mem_cldff_ss<0b0111, "ldff1h",  Z_d, ZPR64, GPR64shifted16>;
  defm LDFF1SH_D : sve_mem_cldff_ss<0b1000, "ldff1sh", Z_d, ZPR64, GPR64shifted16>;
  defm LDFF1SH_S : sve_mem_cldff_ss<0b1001, "ldff1sh", Z_s, ZPR32, GPR64shifted16>;
  defm LDFF1W    : sve_mem_cldff_ss<0b1010, "ldff1w",  Z_s, ZPR32, GPR64shifted32>;
  defm LDFF1W_D  : sve_mem_cldff_ss<0b1011, "ldff1w",  Z_d, ZPR64, GPR64shifted32>;
  defm LDFF1SB_D : sve_mem_cldff_ss<0b1100, "ldff1sb", Z_d, ZPR64, GPR64shifted8>;
  defm LDFF1SB_S : sve_mem_cldff_ss<0b1101, "ldff1sb", Z_s, ZPR32, GPR64shifted8>;
  defm LDFF1SB_H : sve_mem_cldff_ss<0b1110, "ldff1sb", Z_h, ZPR16, GPR64shifted8>;
  defm LDFF1D    : sve_mem_cldff_ss<0b1111, "ldff1d",  Z_d, ZPR64, GPR64shifted64>;

  // LD{2,3,4}{B,H,W,D} with reg+immediate
  defm LD2B_IMM : sve_mem_eld_si<0b00, 0b01, ZZ_b,   "ld2b", simm4Scale2MulVl>;
  defm LD2H_IMM : sve_mem_eld_si<0b01, 0b01, ZZ_h,   "ld2h", simm4Scale2MulVl>;
  defm LD2W_IMM : sve_mem_eld_si<0b10, 0b01, ZZ_s,   "ld2w", simm4Scale2MulVl>;
  defm LD2D_IMM : sve_mem_eld_si<0b11, 0b01, ZZ_d,   "ld2d", simm4Scale2MulVl>;
  defm LD3B_IMM : sve_mem_eld_si<0b00, 0b10, ZZZ_b,  "ld3b", simm4Scale3MulVl>;
  defm LD3H_IMM : sve_mem_eld_si<0b01, 0b10, ZZZ_h,  "ld3h", simm4Scale3MulVl>;
  defm LD3W_IMM : sve_mem_eld_si<0b10, 0b10, ZZZ_s,  "ld3w", simm4Scale3MulVl>;
  defm LD3D_IMM : sve_mem_eld_si<0b11, 0b10, ZZZ_d,  "ld3d", simm4Scale3MulVl>;
  defm LD4B_IMM : sve_mem_eld_si<0b00, 0b11, ZZZZ_b, "ld4b", simm4Scale4MulVl>;
  defm LD4H_IMM : sve_mem_eld_si<0b01, 0b11, ZZZZ_h, "ld4h", simm4Scale4MulVl>;
  defm LD4W_IMM : sve_mem_eld_si<0b10, 0b11, ZZZZ_s, "ld4w", simm4Scale4MulVl>;
  defm LD4D_IMM : sve_mem_eld_si<0b11, 0b11, ZZZZ_d, "ld4d", simm4Scale4MulVl>;

  // LD{2,3,4}{B,H,W,D} with reg+reg
  def LD2B : sve_mem_eld_ss<0b00, 0b01, ZZ_b,   "ld2b", GPR64NoXZRshifted8>;
  def LD2H : sve_mem_eld_ss<0b01, 0b01, ZZ_h,   "ld2h", GPR64NoXZRshifted16>;
  def LD2W : sve_mem_eld_ss<0b10, 0b01, ZZ_s,   "ld2w", GPR64NoXZRshifted32>;
  def LD2D : sve_mem_eld_ss<0b11, 0b01, ZZ_d,   "ld2d", GPR64NoXZRshifted64>;
  def LD3B : sve_mem_eld_ss<0b00, 0b10, ZZZ_b,  "ld3b", GPR64NoXZRshifted8>;
  def LD3H : sve_mem_eld_ss<0b01, 0b10, ZZZ_h,  "ld3h", GPR64NoXZRshifted16>;
  def LD3W : sve_mem_eld_ss<0b10, 0b10, ZZZ_s,  "ld3w", GPR64NoXZRshifted32>;
  def LD3D : sve_mem_eld_ss<0b11, 0b10, ZZZ_d,  "ld3d", GPR64NoXZRshifted64>;
  def LD4B : sve_mem_eld_ss<0b00, 0b11, ZZZZ_b, "ld4b", GPR64NoXZRshifted8>;
  def LD4H : sve_mem_eld_ss<0b01, 0b11, ZZZZ_h, "ld4h", GPR64NoXZRshifted16>;
  def LD4W : sve_mem_eld_ss<0b10, 0b11, ZZZZ_s, "ld4w", GPR64NoXZRshifted32>;
  def LD4D : sve_mem_eld_ss<0b11, 0b11, ZZZZ_d, "ld4d", GPR64NoXZRshifted64>;

  // GLD1B_S_UXTW, GLD1B_S_SXTW...
  defm GLD1SB_S   : sve_mem_32b_gld_vs_32_unscaled<0b0000, "ld1sb",   null_frag,                 null_frag,                 ZPR32ExtSXTW8, ZPR32ExtUXTW8, nxv4i8>;
  defm GLDFF1SB_S : sve_mem_32b_gld_vs_32_unscaled<0b0001, "ldff1sb", AArch64ldff1s_gather_sxtw, AArch64ldff1s_gather_uxtw, ZPR32ExtSXTW8, ZPR32ExtUXTW8, nxv4i8>;
  defm GLD1B_S    : sve_mem_32b_gld_vs_32_unscaled<0b0010, "ld1b",    null_frag,                 null_frag,                 ZPR32ExtSXTW8, ZPR32ExtUXTW8, nxv4i8>;
  defm GLDFF1B_S  : sve_mem_32b_gld_vs_32_unscaled<0b0011, "ldff1b",  AArch64ldff1_gather_sxtw,  AArch64ldff1_gather_uxtw,  ZPR32ExtSXTW8, ZPR32ExtUXTW8, nxv4i8>;
  defm GLD1SH_S   : sve_mem_32b_gld_vs_32_unscaled<0b0100, "ld1sh",   null_frag,                 null_frag,                 ZPR32ExtSXTW8, ZPR32ExtUXTW8, nxv4i16>;
  defm GLDFF1SH_S : sve_mem_32b_gld_vs_32_unscaled<0b0101, "ldff1sh", AArch64ldff1s_gather_sxtw, AArch64ldff1s_gather_uxtw, ZPR32ExtSXTW8, ZPR32ExtUXTW8, nxv4i16>;
  defm GLD1H_S    : sve_mem_32b_gld_vs_32_unscaled<0b0110, "ld1h",    null_frag,                 null_frag,                 ZPR32ExtSXTW8, ZPR32ExtUXTW8, nxv4i16>;
  defm GLDFF1H_S  : sve_mem_32b_gld_vs_32_unscaled<0b0111, "ldff1h",  AArch64ldff1_gather_sxtw,  AArch64ldff1_gather_uxtw,  ZPR32ExtSXTW8, ZPR32ExtUXTW8, nxv4i16>;
  defm GLD1W      : sve_mem_32b_gld_vs_32_unscaled<0b1010, "ld1w",    null_frag,                 null_frag,                 ZPR32ExtSXTW8, ZPR32ExtUXTW8, nxv4i32>;
  defm GLDFF1W    : sve_mem_32b_gld_vs_32_unscaled<0b1011, "ldff1w",  AArch64ldff1_gather_sxtw,  AArch64ldff1_gather_uxtw,  ZPR32ExtSXTW8, ZPR32ExtUXTW8, nxv4i32>;

  // GLD1B_S_UXTW_SCALED, GLD1B_S_SXTW_SCALED...
  defm GLD1SH_S   : sve_mem_32b_gld_sv_32_scaled<0b0100, "ld1sh",   null_frag,                        null_frag,                        ZPR32ExtSXTW16, ZPR32ExtUXTW16, nxv4i16>;
  defm GLDFF1SH_S : sve_mem_32b_gld_sv_32_scaled<0b0101, "ldff1sh", AArch64ldff1s_gather_sxtw_scaled, AArch64ldff1s_gather_uxtw_scaled, ZPR32ExtSXTW16, ZPR32ExtUXTW16, nxv4i16>;
  defm GLD1H_S    : sve_mem_32b_gld_sv_32_scaled<0b0110, "ld1h",    null_frag,                        null_frag,                        ZPR32ExtSXTW16, ZPR32ExtUXTW16, nxv4i16>;
  defm GLDFF1H_S  : sve_mem_32b_gld_sv_32_scaled<0b0111, "ldff1h",  AArch64ldff1_gather_sxtw_scaled,  AArch64ldff1_gather_uxtw_scaled,  ZPR32ExtSXTW16, ZPR32ExtUXTW16, nxv4i16>;
  defm GLD1W      : sve_mem_32b_gld_sv_32_scaled<0b1010, "ld1w",    null_frag,                        null_frag,                        ZPR32ExtSXTW32, ZPR32ExtUXTW32, nxv4i32>;
  defm GLDFF1W    : sve_mem_32b_gld_sv_32_scaled<0b1011, "ldff1w",  AArch64ldff1_gather_sxtw_scaled,  AArch64ldff1_gather_uxtw_scaled,  ZPR32ExtSXTW32, ZPR32ExtUXTW32, nxv4i32>;

  // GLD1SB_S_IMM...
  defm GLD1SB_S   : sve_mem_32b_gld_vi_32_ptrs<0b0000, "ld1sb",   imm0_31, null_frag,                 nxv4i8>;
  defm GLDFF1SB_S : sve_mem_32b_gld_vi_32_ptrs<0b0001, "ldff1sb", imm0_31, AArch64ldff1s_gather_uxtw, nxv4i8>;
  defm GLD1B_S    : sve_mem_32b_gld_vi_32_ptrs<0b0010, "ld1b",    imm0_31, null_frag,                 nxv4i8>;
  defm GLDFF1B_S  : sve_mem_32b_gld_vi_32_ptrs<0b0011, "ldff1b",  imm0_31, AArch64ldff1_gather_uxtw,  nxv4i8>;
  defm GLD1SH_S   : sve_mem_32b_gld_vi_32_ptrs<0b0100, "ld1sh",   uimm5s2, null_frag,                 nxv4i16>;
  defm GLDFF1SH_S : sve_mem_32b_gld_vi_32_ptrs<0b0101, "ldff1sh", uimm5s2, AArch64ldff1s_gather_uxtw, nxv4i16>;
  defm GLD1H_S    : sve_mem_32b_gld_vi_32_ptrs<0b0110, "ld1h",    uimm5s2, null_frag,                 nxv4i16>;
  defm GLDFF1H_S  : sve_mem_32b_gld_vi_32_ptrs<0b0111, "ldff1h",  uimm5s2, AArch64ldff1_gather_uxtw,  nxv4i16>;
  defm GLD1W      : sve_mem_32b_gld_vi_32_ptrs<0b1010, "ld1w",    uimm5s4, null_frag,                 nxv4i32>;
  defm GLDFF1W    : sve_mem_32b_gld_vi_32_ptrs<0b1011, "ldff1w",  uimm5s4, AArch64ldff1_gather_uxtw,  nxv4i32>;

  // GLD1B_D...
  defm GLD1SB_D   : sve_mem_64b_gld_vs2_64_unscaled<0b0000, "ld1sb",   null_frag,            nxv2i8>;
  defm GLDFF1SB_D : sve_mem_64b_gld_vs2_64_unscaled<0b0001, "ldff1sb", AArch64ldff1s_gather, nxv2i8>;
  defm GLD1B_D    : sve_mem_64b_gld_vs2_64_unscaled<0b0010, "ld1b",    null_frag,            nxv2i8>;
  defm GLDFF1B_D  : sve_mem_64b_gld_vs2_64_unscaled<0b0011, "ldff1b",  AArch64ldff1_gather,  nxv2i8>;
  defm GLD1SH_D   : sve_mem_64b_gld_vs2_64_unscaled<0b0100, "ld1sh",   null_frag,            nxv2i16>;
  defm GLDFF1SH_D : sve_mem_64b_gld_vs2_64_unscaled<0b0101, "ldff1sh", AArch64ldff1s_gather, nxv2i16>;
  defm GLD1H_D    : sve_mem_64b_gld_vs2_64_unscaled<0b0110, "ld1h",    null_frag,            nxv2i16>;
  defm GLDFF1H_D  : sve_mem_64b_gld_vs2_64_unscaled<0b0111, "ldff1h",  AArch64ldff1_gather,  nxv2i16>;
  defm GLD1SW_D   : sve_mem_64b_gld_vs2_64_unscaled<0b1000, "ld1sw",   null_frag,            nxv2i32>;
  defm GLDFF1SW_D : sve_mem_64b_gld_vs2_64_unscaled<0b1001, "ldff1sw", AArch64ldff1s_gather, nxv2i32>;
  defm GLD1W_D    : sve_mem_64b_gld_vs2_64_unscaled<0b1010, "ld1w",    null_frag,            nxv2i32>;
  defm GLDFF1W_D  : sve_mem_64b_gld_vs2_64_unscaled<0b1011, "ldff1w",  AArch64ldff1_gather,  nxv2i32>;
  defm GLD1D      : sve_mem_64b_gld_vs2_64_unscaled<0b1110, "ld1d",    null_frag,            nxv2i64>;
  defm GLDFF1D    : sve_mem_64b_gld_vs2_64_unscaled<0b1111, "ldff1d",  AArch64ldff1_gather,  nxv2i64>;

  // GLD1SH_D_SCALED...
  defm GLD1SH_D   : sve_mem_64b_gld_sv2_64_scaled<0b0100, "ld1sh",   null_frag,                   ZPR64ExtLSL16, nxv2i16>;
  defm GLDFF1SH_D : sve_mem_64b_gld_sv2_64_scaled<0b0101, "ldff1sh", AArch64ldff1s_gather_scaled, ZPR64ExtLSL16, nxv2i16>;
  defm GLD1H_D    : sve_mem_64b_gld_sv2_64_scaled<0b0110, "ld1h",    null_frag,                   ZPR64ExtLSL16, nxv2i16>;
  defm GLDFF1H_D  : sve_mem_64b_gld_sv2_64_scaled<0b0111, "ldff1h",  AArch64ldff1_gather_scaled,  ZPR64ExtLSL16, nxv2i16>;
  defm GLD1SW_D   : sve_mem_64b_gld_sv2_64_scaled<0b1000, "ld1sw",   null_frag,                   ZPR64ExtLSL32, nxv2i32>;
  defm GLDFF1SW_D : sve_mem_64b_gld_sv2_64_scaled<0b1001, "ldff1sw", AArch64ldff1s_gather_scaled, ZPR64ExtLSL32, nxv2i32>;
  defm GLD1W_D    : sve_mem_64b_gld_sv2_64_scaled<0b1010, "ld1w",    null_frag,                   ZPR64ExtLSL32, nxv2i32>;
  defm GLDFF1W_D  : sve_mem_64b_gld_sv2_64_scaled<0b1011, "ldff1w",  AArch64ldff1_gather_scaled,  ZPR64ExtLSL32, nxv2i32>;
  defm GLD1D      : sve_mem_64b_gld_sv2_64_scaled<0b1110, "ld1d",    null_frag,                   ZPR64ExtLSL64, nxv2i64>;
  defm GLDFF1D    : sve_mem_64b_gld_sv2_64_scaled<0b1111, "ldff1d",  AArch64ldff1_gather_scaled,  ZPR64ExtLSL64, nxv2i64>;

  // GLD1B_D_SXTW, GLD1B_D_UXTW...
  defm GLD1SB_D   : sve_mem_64b_gld_vs_32_unscaled<0b0000, "ld1sb",   null_frag,            ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i8>;
  defm GLDFF1SB_D : sve_mem_64b_gld_vs_32_unscaled<0b0001, "ldff1sb", AArch64ldff1s_gather, ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i8>;
  defm GLD1B_D    : sve_mem_64b_gld_vs_32_unscaled<0b0010, "ld1b",    null_frag,            ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i8>;
  defm GLDFF1B_D  : sve_mem_64b_gld_vs_32_unscaled<0b0011, "ldff1b",  AArch64ldff1_gather,  ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i8>;
  defm GLD1SH_D   : sve_mem_64b_gld_vs_32_unscaled<0b0100, "ld1sh",   null_frag,            ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i16>;
  defm GLDFF1SH_D : sve_mem_64b_gld_vs_32_unscaled<0b0101, "ldff1sh", AArch64ldff1s_gather, ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i16>;
  defm GLD1H_D    : sve_mem_64b_gld_vs_32_unscaled<0b0110, "ld1h",    null_frag,            ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i16>;
  defm GLDFF1H_D  : sve_mem_64b_gld_vs_32_unscaled<0b0111, "ldff1h",  AArch64ldff1_gather,  ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i16>;
  defm GLD1SW_D   : sve_mem_64b_gld_vs_32_unscaled<0b1000, "ld1sw",   null_frag,            ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i32>;
  defm GLDFF1SW_D : sve_mem_64b_gld_vs_32_unscaled<0b1001, "ldff1sw", AArch64ldff1s_gather, ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i32>;
  defm GLD1W_D    : sve_mem_64b_gld_vs_32_unscaled<0b1010, "ld1w",    null_frag,            ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i32>;
  defm GLDFF1W_D  : sve_mem_64b_gld_vs_32_unscaled<0b1011, "ldff1w",  AArch64ldff1_gather,  ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i32>;
  defm GLD1D      : sve_mem_64b_gld_vs_32_unscaled<0b1110, "ld1d",    null_frag,            ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i64>;
  defm GLDFF1D    : sve_mem_64b_gld_vs_32_unscaled<0b1111, "ldff1d",  AArch64ldff1_gather,  ZPR64ExtSXTW8, ZPR64ExtUXTW8, nxv2i64>;

  // GLD1SH_D_SXTW_SCALED, GLD1SH_D_UXTW_SCALED...
  defm GLD1SH_D   : sve_mem_64b_gld_sv_32_scaled<0b0100, "ld1sh",  null_frag,                   ZPR64ExtSXTW16, ZPR64ExtUXTW16, nxv2i16>;
  defm GLDFF1SH_D : sve_mem_64b_gld_sv_32_scaled<0b0101, "ldff1sh",AArch64ldff1s_gather_scaled, ZPR64ExtSXTW16, ZPR64ExtUXTW16, nxv2i16>;
  defm GLD1H_D    : sve_mem_64b_gld_sv_32_scaled<0b0110, "ld1h",   null_frag,                   ZPR64ExtSXTW16, ZPR64ExtUXTW16, nxv2i16>;
  defm GLDFF1H_D  : sve_mem_64b_gld_sv_32_scaled<0b0111, "ldff1h", AArch64ldff1_gather_scaled,  ZPR64ExtSXTW16, ZPR64ExtUXTW16, nxv2i16>;
  defm GLD1SW_D   : sve_mem_64b_gld_sv_32_scaled<0b1000, "ld1sw",  null_frag,                   ZPR64ExtSXTW32, ZPR64ExtUXTW32, nxv2i32>;
  defm GLDFF1SW_D : sve_mem_64b_gld_sv_32_scaled<0b1001, "ldff1sw",AArch64ldff1s_gather_scaled, ZPR64ExtSXTW32, ZPR64ExtUXTW32, nxv2i32>;
  defm GLD1W_D    : sve_mem_64b_gld_sv_32_scaled<0b1010, "ld1w",   null_frag,                   ZPR64ExtSXTW32, ZPR64ExtUXTW32, nxv2i32>;
  defm GLDFF1W_D  : sve_mem_64b_gld_sv_32_scaled<0b1011, "ldff1w", AArch64ldff1_gather_scaled,  ZPR64ExtSXTW32, ZPR64ExtUXTW32, nxv2i32>;
  defm GLD1D      : sve_mem_64b_gld_sv_32_scaled<0b1110, "ld1d",   null_frag,                   ZPR64ExtSXTW64, ZPR64ExtUXTW64, nxv2i64>;
  defm GLDFF1D    : sve_mem_64b_gld_sv_32_scaled<0b1111, "ldff1d", AArch64ldff1_gather_scaled,  ZPR64ExtSXTW64, ZPR64ExtUXTW64, nxv2i64>;

  // GLD1SB_D_IMM...
  defm GLD1SB_D   : sve_mem_64b_gld_vi_64_ptrs<0b0000, "ld1sb",   imm0_31, null_frag,            nxv2i8>;
  defm GLDFF1SB_D : sve_mem_64b_gld_vi_64_ptrs<0b0001, "ldff1sb", imm0_31, AArch64ldff1s_gather, nxv2i8>;
  defm GLD1B_D    : sve_mem_64b_gld_vi_64_ptrs<0b0010, "ld1b",    imm0_31, null_frag,            nxv2i8>;
  defm GLDFF1B_D  : sve_mem_64b_gld_vi_64_ptrs<0b0011, "ldff1b",  imm0_31, AArch64ldff1_gather,  nxv2i8>;
  defm GLD1SH_D   : sve_mem_64b_gld_vi_64_ptrs<0b0100, "ld1sh",   uimm5s2, null_frag,            nxv2i16>;
  defm GLDFF1SH_D : sve_mem_64b_gld_vi_64_ptrs<0b0101, "ldff1sh", uimm5s2, AArch64ldff1s_gather, nxv2i16>;
  defm GLD1H_D    : sve_mem_64b_gld_vi_64_ptrs<0b0110, "ld1h",    uimm5s2, null_frag,            nxv2i16>;
  defm GLDFF1H_D  : sve_mem_64b_gld_vi_64_ptrs<0b0111, "ldff1h",  uimm5s2, AArch64ldff1_gather,  nxv2i16>;
  defm GLD1SW_D   : sve_mem_64b_gld_vi_64_ptrs<0b1000, "ld1sw",   uimm5s4, null_frag,            nxv2i32>;
  defm GLDFF1SW_D : sve_mem_64b_gld_vi_64_ptrs<0b1001, "ldff1sw", uimm5s4, AArch64ldff1s_gather, nxv2i32>;
  defm GLD1W_D    : sve_mem_64b_gld_vi_64_ptrs<0b1010, "ld1w",    uimm5s4, null_frag,            nxv2i32>;
  defm GLDFF1W_D  : sve_mem_64b_gld_vi_64_ptrs<0b1011, "ldff1w",  uimm5s4, AArch64ldff1_gather,  nxv2i32>;
  defm GLD1D      : sve_mem_64b_gld_vi_64_ptrs<0b1110, "ld1d",    uimm5s8, null_frag,            nxv2i64>;
  defm GLDFF1D    : sve_mem_64b_gld_vi_64_ptrs<0b1111, "ldff1d",  uimm5s8, AArch64ldff1_gather,  nxv2i64>;

  // ST1B...
  defm ST1B   : sve_mem_cst_ss<0b0000, 1, "st1b", Z_b, ZPR8,  GPR64NoXZRshifted8>;
  defm ST1B_H : sve_mem_cst_ss<0b0001, 1, "st1b", Z_h, ZPR16, GPR64NoXZRshifted8>;
  defm ST1B_S : sve_mem_cst_ss<0b0010, 1, "st1b", Z_s, ZPR32, GPR64NoXZRshifted8>;
  defm ST1B_D : sve_mem_cst_ss<0b0011, 1, "st1b", Z_d, ZPR64, GPR64NoXZRshifted8>;
  defm ST1H   : sve_mem_cst_ss<0b0101, 1, "st1h", Z_h, ZPR16, GPR64NoXZRshifted16>;
  defm ST1H_S : sve_mem_cst_ss<0b0110, 1, "st1h", Z_s, ZPR32, GPR64NoXZRshifted16>;
  defm ST1H_D : sve_mem_cst_ss<0b0111, 1, "st1h", Z_d, ZPR64, GPR64NoXZRshifted16>;
  defm ST1W   : sve_mem_cst_ss<0b1010, 1, "st1w", Z_s, ZPR32, GPR64NoXZRshifted32>;
  defm ST1W_D : sve_mem_cst_ss<0b1011, 1, "st1w", Z_d, ZPR64, GPR64NoXZRshifted32>;
  defm ST1D   : sve_mem_cst_ss<0b1111, 1, "st1d", Z_d, ZPR64, GPR64NoXZRshifted64>;

  // continuous store with immediates
  defm ST1B_IMM   : sve_mem_cst_si<0b00, 0b00, "st1b", Z_b, ZPR8>;
  defm ST1B_H_IMM : sve_mem_cst_si<0b00, 0b01, "st1b", Z_h, ZPR16>;
  defm ST1B_S_IMM : sve_mem_cst_si<0b00, 0b10, "st1b", Z_s, ZPR32>;
  defm ST1B_D_IMM : sve_mem_cst_si<0b00, 0b11, "st1b", Z_d, ZPR64>;
  defm ST1H_IMM   : sve_mem_cst_si<0b01, 0b01, "st1h", Z_h, ZPR16>;
  defm ST1H_S_IMM : sve_mem_cst_si<0b01, 0b10, "st1h", Z_s, ZPR32>;
  defm ST1H_D_IMM : sve_mem_cst_si<0b01, 0b11, "st1h", Z_d, ZPR64>;
  defm ST1W_IMM   : sve_mem_cst_si<0b10, 0b10, "st1w", Z_s, ZPR32>;
  defm ST1W_D_IMM : sve_mem_cst_si<0b10, 0b11, "st1w", Z_d, ZPR64>;
  defm ST1D_IMM   : sve_mem_cst_si<0b11, 0b11, "st1d", Z_d, ZPR64>;

  // SST1B_D_SXTW, SST1B_D_UXTW...
  defm SST1B_D : sve_mem_sst_vs_32_unscaled<0b000, "st1b", Z_d, ZPR64, ZPR64ExtSXTW8, ZPR64ExtUXTW8>;
  defm SST1B_S : sve_mem_sst_vs_32_unscaled<0b001, "st1b", Z_s, ZPR32, ZPR32ExtSXTW8, ZPR32ExtUXTW8>;
  defm SST1H_D : sve_mem_sst_vs_32_unscaled<0b010, "st1h", Z_d, ZPR64, ZPR64ExtSXTW8, ZPR64ExtUXTW8>;
  defm SST1H_S : sve_mem_sst_vs_32_unscaled<0b011, "st1h", Z_s, ZPR32, ZPR32ExtSXTW8, ZPR32ExtUXTW8>;
  defm SST1W_D : sve_mem_sst_vs_32_unscaled<0b100, "st1w", Z_d, ZPR64, ZPR64ExtSXTW8, ZPR64ExtUXTW8>;
  defm SST1W   : sve_mem_sst_vs_32_unscaled<0b101, "st1w", Z_s, ZPR32, ZPR32ExtSXTW8, ZPR32ExtUXTW8>;
  defm SST1D   : sve_mem_sst_vs_32_unscaled<0b110, "st1d", Z_d, ZPR64, ZPR64ExtSXTW8, ZPR64ExtUXTW8>;

  // SST1B_D_SXTW_SCALED, SST1B_D_UXTW_SCALED...
  defm SST1H_D : sve_mem_sst_sv_32_scaled<0b010, "st1h", Z_d, ZPR64, ZPR64ExtSXTW16, ZPR64ExtUXTW16>;
  defm SST1H_S : sve_mem_sst_sv_32_scaled<0b011, "st1h", Z_s, ZPR32, ZPR32ExtSXTW16, ZPR32ExtUXTW16>;
  defm SST1W_D : sve_mem_sst_sv_32_scaled<0b100, "st1w", Z_d, ZPR64, ZPR64ExtSXTW32, ZPR64ExtUXTW32>;
  defm SST1W   : sve_mem_sst_sv_32_scaled<0b101, "st1w", Z_s, ZPR32, ZPR32ExtSXTW32, ZPR32ExtUXTW32>;
  defm SST1D   : sve_mem_sst_sv_32_scaled<0b110, "st1d", Z_d, ZPR64, ZPR64ExtSXTW64, ZPR64ExtUXTW64>;

  // SST1B_D...
  defm SST1B_D : sve_mem_sst_vs2_64_unscaled<0b00, "st1b">;
  defm SST1H_D : sve_mem_sst_vs2_64_unscaled<0b01, "st1h">;
  defm SST1W_D : sve_mem_sst_vs2_64_unscaled<0b10, "st1w">;
  defm SST1D   : sve_mem_sst_vs2_64_unscaled<0b11, "st1d">;

  // SST1H_D_SCALED...
  defm SST1H_D_SCALED : sve_mem_sst_sv2_64_scaled<0b01, "st1h", ZPR64ExtLSL16>;
  defm SST1W_D_SCALED : sve_mem_sst_sv2_64_scaled<0b10, "st1w", ZPR64ExtLSL32>;
  defm SST1D_SCALED   : sve_mem_sst_sv2_64_scaled<0b11, "st1d", ZPR64ExtLSL64>;

  // SST1B_D_IMM...
  defm SST1B_D : sve_mem_sst_vi_ptrs<0b000, "st1b", Z_d, ZPR64, imm0_31>;
  defm SST1B_S : sve_mem_sst_vi_ptrs<0b001, "st1b", Z_s, ZPR32, imm0_31>;
  defm SST1H_D : sve_mem_sst_vi_ptrs<0b010, "st1h", Z_d, ZPR64, uimm5s2>;
  defm SST1H_S : sve_mem_sst_vi_ptrs<0b011, "st1h", Z_s, ZPR32, uimm5s2>;
  defm SST1W_D : sve_mem_sst_vi_ptrs<0b100, "st1w", Z_d, ZPR64, uimm5s4>;
  defm SST1W   : sve_mem_sst_vi_ptrs<0b101, "st1w", Z_s, ZPR32, uimm5s4>;
  defm SST1D   : sve_mem_sst_vi_ptrs<0b110, "st1d", Z_d, ZPR64, uimm5s8>;

  // ST{2,3,4}{B,H,W,D} with immediate
  defm ST2B_IMM : sve_mem_est_si<0b00, 0b01, ZZ_b,   "st2b", simm4Scale2MulVl>;
  defm ST2H_IMM : sve_mem_est_si<0b01, 0b01, ZZ_h,   "st2h", simm4Scale2MulVl>;
  defm ST2W_IMM : sve_mem_est_si<0b10, 0b01, ZZ_s,   "st2w", simm4Scale2MulVl>;
  defm ST2D_IMM : sve_mem_est_si<0b11, 0b01, ZZ_d,   "st2d", simm4Scale2MulVl>;
  defm ST3B_IMM : sve_mem_est_si<0b00, 0b10, ZZZ_b,  "st3b", simm4Scale3MulVl>;
  defm ST3H_IMM : sve_mem_est_si<0b01, 0b10, ZZZ_h,  "st3h", simm4Scale3MulVl>;
  defm ST3W_IMM : sve_mem_est_si<0b10, 0b10, ZZZ_s,  "st3w", simm4Scale3MulVl>;
  defm ST3D_IMM : sve_mem_est_si<0b11, 0b10, ZZZ_d,  "st3d", simm4Scale3MulVl>;
  defm ST4B_IMM : sve_mem_est_si<0b00, 0b11, ZZZZ_b, "st4b", simm4Scale4MulVl>;
  defm ST4H_IMM : sve_mem_est_si<0b01, 0b11, ZZZZ_h, "st4h", simm4Scale4MulVl>;
  defm ST4W_IMM : sve_mem_est_si<0b10, 0b11, ZZZZ_s, "st4w", simm4Scale4MulVl>;
  defm ST4D_IMM : sve_mem_est_si<0b11, 0b11, ZZZZ_d, "st4d", simm4Scale4MulVl>;

  // ST{2,3,4}{B,H,W,D} with reg+reg
  def ST2B : sve_mem_est_ss<0b00, 0b01, ZZ_b,   "st2b", GPR64NoXZRshifted8>;
  def ST2H : sve_mem_est_ss<0b01, 0b01, ZZ_h,   "st2h", GPR64NoXZRshifted16>;
  def ST2W : sve_mem_est_ss<0b10, 0b01, ZZ_s,   "st2w", GPR64NoXZRshifted32>;
  def ST2D : sve_mem_est_ss<0b11, 0b01, ZZ_d,   "st2d", GPR64NoXZRshifted64>;
  def ST3B : sve_mem_est_ss<0b00, 0b10, ZZZ_b,  "st3b", GPR64NoXZRshifted8>;
  def ST3H : sve_mem_est_ss<0b01, 0b10, ZZZ_h,  "st3h", GPR64NoXZRshifted16>;
  def ST3W : sve_mem_est_ss<0b10, 0b10, ZZZ_s,  "st3w", GPR64NoXZRshifted32>;
  def ST3D : sve_mem_est_ss<0b11, 0b10, ZZZ_d,  "st3d", GPR64NoXZRshifted64>;
  def ST4B : sve_mem_est_ss<0b00, 0b11, ZZZZ_b, "st4b", GPR64NoXZRshifted8>;
  def ST4H : sve_mem_est_ss<0b01, 0b11, ZZZZ_h, "st4h", GPR64NoXZRshifted16>;
  def ST4W : sve_mem_est_ss<0b10, 0b11, ZZZZ_s, "st4w", GPR64NoXZRshifted32>;
  def ST4D : sve_mem_est_ss<0b11, 0b11, ZZZZ_d, "st4d", GPR64NoXZRshifted64>;

  defm : SVETruncStore<nxv8i16, truncstorevi8,  ST1B_H, ST1B_H_IMM, PTRUE_H, SVEAddrModeRegReg8>;
  defm : SVETruncStore<nxv4i32, truncstorevi8,  ST1B_S, ST1B_S_IMM, PTRUE_S, SVEAddrModeRegReg8>;
  defm : SVETruncStore<nxv2i64, truncstorevi8,  ST1B_D, ST1B_D_IMM, PTRUE_D, SVEAddrModeRegReg8>;
  defm : SVETruncStore<nxv4i32, truncstorevi16, ST1H_S, ST1H_S_IMM, PTRUE_S, SVEAddrModeRegReg16>;
  defm : SVETruncStore<nxv2i64, truncstorevi16, ST1H_D, ST1H_D_IMM, PTRUE_D, SVEAddrModeRegReg16>;
  defm : SVETruncStore<nxv2i64, truncstorevi32, ST1W_D, ST1W_D_IMM, PTRUE_D, SVEAddrModeRegReg32>;

  defm TBL_ZZZ  : sve_int_perm_tbl<"tbl", AArch64TBL>;
  defm ZIP1_ZZZ : sve_int_perm_bin_perm_zz<0b000, "zip1", AArch64zip1>;
  defm ZIP2_ZZZ : sve_int_perm_bin_perm_zz<0b001, "zip2", AArch64zip2>;
  defm UZP1_ZZZ : sve_int_perm_bin_perm_zz<0b010, "uzp1", AArch64uzp1>;
  defm UZP2_ZZZ : sve_int_perm_bin_perm_zz<0b011, "uzp2", AArch64uzp2>;
  defm TRN1_ZZZ : sve_int_perm_bin_perm_zz<0b100, "trn1", AArch64trn1>;
  defm TRN2_ZZZ : sve_int_perm_bin_perm_zz<0b101, "trn2", AArch64trn2>;

  defm ZIP1_PPP : sve_int_perm_bin_perm_pp<0b000, "zip1", AArch64zip1>;
  defm ZIP2_PPP : sve_int_perm_bin_perm_pp<0b001, "zip2", AArch64zip2>;
  defm UZP1_PPP : sve_int_perm_bin_perm_pp<0b010, "uzp1", AArch64uzp1>;
  defm UZP2_PPP : sve_int_perm_bin_perm_pp<0b011, "uzp2", AArch64uzp2>;
  defm TRN1_PPP : sve_int_perm_bin_perm_pp<0b100, "trn1", AArch64trn1>;
  defm TRN2_PPP : sve_int_perm_bin_perm_pp<0b101, "trn2", AArch64trn2>;

  defm CPY_ZPmR : sve_int_perm_cpy_r<"cpy", AArch64dup_pred>;
  defm CPY_ZPmV : sve_int_perm_cpy_v<"cpy", AArch64dup_pred>;

  defm CPY_ZPmI : sve_int_dup_imm_pred_merge<"cpy">;
  defm CPY_ZPzI : sve_int_dup_imm_pred_zero<"cpy">;

  defm FDUP_ZI   : sve_int_dup_fpimm<0b000, "fdup">;
  defm FCPY_ZPmI : sve_int_dup_fpimm_pred<"fcpy">;

  defm COMPACT_ZPZ : sve_int_perm_compact<"compact", int_aarch64_sve_compact>;

  defm DUP_ZR  : sve_int_perm_dup_r<"dup">;
  defm DUP_ZZI : sve_int_perm_dup_i<"dup">;
  defm DUP_ZI  : sve_int_dup_imm<0b00, "dup">;

  // Create variants of DUP_ZZI (I=0) that can be used without INSERT_SUBREG.
  def DUP_ZV_H : Pseudo<(outs ZPR16:$Zd), (ins FPR16:$Vn), []>, Sched<[]>;
  def DUP_ZV_S : Pseudo<(outs ZPR32:$Zd), (ins FPR32:$Vn), []>, Sched<[]>;
  def DUP_ZV_D : Pseudo<(outs ZPR64:$Zd), (ins FPR64:$Vn), []>, Sched<[]>;

  defm DUPM_ZI : sve_int_dup_mask_imm<"dupm">;
  def : Pat<(nxv2i64 (AArch64dup (i64 logical_imm64:$imms1))),
            (DUPM_ZI logical_imm64:$imms1)>;

  defm CLASTA_RPZ : sve_int_perm_clast_rz<0, "clasta", AArch64clasta_n>;
  defm CLASTB_RPZ : sve_int_perm_clast_rz<1, "clastb", AArch64clastb_n>;
  defm CLASTA_VPZ : sve_int_perm_clast_vz<0, "clasta", AArch64clasta_n>;
  defm CLASTB_VPZ : sve_int_perm_clast_vz<1, "clastb", AArch64clastb_n>;
  defm CLASTA_ZPZ : sve_int_perm_clast_zz<0, "clasta", int_aarch64_sve_clasta>;
  defm CLASTB_ZPZ : sve_int_perm_clast_zz<1, "clastb", int_aarch64_sve_clastb>;

  defm LASTA_RPZ : sve_int_perm_last_r<0, "lasta", AArch64lasta>;
  defm LASTB_RPZ : sve_int_perm_last_r<1, "lastb", AArch64lastb>;
  defm LASTA_VPZ : sve_int_perm_last_v<0, "lasta", AArch64lasta>;
  defm LASTB_VPZ : sve_int_perm_last_v<1, "lastb", AArch64lastb>;

  def RDVLI_XI  : sve_int_read_vl_a<0b011111, "rdvl">;
  def ADDVL_XXI : sve_int_arith_vl<0b0, "addvl">;
  def ADDPL_XXI : sve_int_arith_vl<0b1, "addpl">;

  defm CNTB_XPiI : sve_int_count<0b000, "cntb", int_aarch64_sve_cntb>;
  defm CNTH_XPiI : sve_int_count<0b010, "cnth", int_aarch64_sve_cnth>;
  defm CNTW_XPiI : sve_int_count<0b100, "cntw", int_aarch64_sve_cntw>;
  defm CNTD_XPiI : sve_int_count<0b110, "cntd", int_aarch64_sve_cntd>;

  defm SQINCH_ZPiI : sve_int_countvlv<0b01000, "sqinch", ZPR16, int_aarch64_sve_sqinch, nxv8i16>;
  defm UQINCH_ZPiI : sve_int_countvlv<0b01001, "uqinch", ZPR16, int_aarch64_sve_uqinch, nxv8i16>;
  defm SQDECH_ZPiI : sve_int_countvlv<0b01010, "sqdech", ZPR16, int_aarch64_sve_sqdech, nxv8i16>;
  defm UQDECH_ZPiI : sve_int_countvlv<0b01011, "uqdech", ZPR16, int_aarch64_sve_uqdech, nxv8i16>;
  defm INCH_ZPiI   : sve_int_countvlv<0b01100, "inch",   ZPR16>;
  defm DECH_ZPiI   : sve_int_countvlv<0b01101, "dech",   ZPR16>;
  defm SQINCW_ZPiI : sve_int_countvlv<0b10000, "sqincw", ZPR32, int_aarch64_sve_sqincw, nxv4i32>;
  defm UQINCW_ZPiI : sve_int_countvlv<0b10001, "uqincw", ZPR32, int_aarch64_sve_uqincw, nxv4i32>;
  defm SQDECW_ZPiI : sve_int_countvlv<0b10010, "sqdecw", ZPR32, int_aarch64_sve_sqdecw, nxv4i32>;
  defm UQDECW_ZPiI : sve_int_countvlv<0b10011, "uqdecw", ZPR32, int_aarch64_sve_uqdecw, nxv4i32>;
  defm INCW_ZPiI   : sve_int_countvlv<0b10100, "incw",   ZPR32>;
  defm DECW_ZPiI   : sve_int_countvlv<0b10101, "decw",   ZPR32>;
  defm SQINCD_ZPiI : sve_int_countvlv<0b11000, "sqincd", ZPR64, int_aarch64_sve_sqincd, nxv2i64>;
  defm UQINCD_ZPiI : sve_int_countvlv<0b11001, "uqincd", ZPR64, int_aarch64_sve_uqincd, nxv2i64>;
  defm SQDECD_ZPiI : sve_int_countvlv<0b11010, "sqdecd", ZPR64, int_aarch64_sve_sqdecd, nxv2i64>;
  defm UQDECD_ZPiI : sve_int_countvlv<0b11011, "uqdecd", ZPR64, int_aarch64_sve_uqdecd, nxv2i64>;
  defm INCD_ZPiI   : sve_int_countvlv<0b11100, "incd",   ZPR64>;
  defm DECD_ZPiI   : sve_int_countvlv<0b11101, "decd",   ZPR64>;

  defm INCB_XPiI : sve_int_pred_pattern_a<0b000, "incb">;
  defm DECB_XPiI : sve_int_pred_pattern_a<0b001, "decb">;
  defm INCH_XPiI : sve_int_pred_pattern_a<0b010, "inch">;
  defm DECH_XPiI : sve_int_pred_pattern_a<0b011, "dech">;
  defm INCW_XPiI : sve_int_pred_pattern_a<0b100, "incw">;
  defm DECW_XPiI : sve_int_pred_pattern_a<0b101, "decw">;
  defm INCD_XPiI : sve_int_pred_pattern_a<0b110, "incd">;
  defm DECD_XPiI : sve_int_pred_pattern_a<0b111, "decd">;

  defm SQINCB_XPiWdI : sve_int_pred_pattern_b_s32<0b00000, "sqincb", int_aarch64_sve_sqincb_n32>;
  defm UQINCB_WPiI   : sve_int_pred_pattern_b_u32<0b00001, "uqincb", int_aarch64_sve_uqincb_n32>;
  defm SQDECB_XPiWdI : sve_int_pred_pattern_b_s32<0b00010, "sqdecb", int_aarch64_sve_sqdecb_n32>;
  defm UQDECB_WPiI   : sve_int_pred_pattern_b_u32<0b00011, "uqdecb", int_aarch64_sve_uqdecb_n32>;
  defm SQINCB_XPiI   : sve_int_pred_pattern_b_x64<0b00100, "sqincb", int_aarch64_sve_sqincb_n64>;
  defm UQINCB_XPiI   : sve_int_pred_pattern_b_x64<0b00101, "uqincb", int_aarch64_sve_uqincb_n64>;
  defm SQDECB_XPiI   : sve_int_pred_pattern_b_x64<0b00110, "sqdecb", int_aarch64_sve_sqdecb_n64>;
  defm UQDECB_XPiI   : sve_int_pred_pattern_b_x64<0b00111, "uqdecb", int_aarch64_sve_uqdecb_n64>;

  defm SQINCH_XPiWdI : sve_int_pred_pattern_b_s32<0b01000, "sqinch", int_aarch64_sve_sqinch_n32>;
  defm UQINCH_WPiI   : sve_int_pred_pattern_b_u32<0b01001, "uqinch", int_aarch64_sve_uqinch_n32>;
  defm SQDECH_XPiWdI : sve_int_pred_pattern_b_s32<0b01010, "sqdech", int_aarch64_sve_sqdech_n32>;
  defm UQDECH_WPiI   : sve_int_pred_pattern_b_u32<0b01011, "uqdech", int_aarch64_sve_uqdech_n32>;
  defm SQINCH_XPiI   : sve_int_pred_pattern_b_x64<0b01100, "sqinch", int_aarch64_sve_sqinch_n64>;
  defm UQINCH_XPiI   : sve_int_pred_pattern_b_x64<0b01101, "uqinch", int_aarch64_sve_uqinch_n64>;
  defm SQDECH_XPiI   : sve_int_pred_pattern_b_x64<0b01110, "sqdech", int_aarch64_sve_sqdech_n64>;
  defm UQDECH_XPiI   : sve_int_pred_pattern_b_x64<0b01111, "uqdech", int_aarch64_sve_uqdech_n64>;

  defm SQINCW_XPiWdI : sve_int_pred_pattern_b_s32<0b10000, "sqincw", int_aarch64_sve_sqincw_n32>;
  defm UQINCW_WPiI   : sve_int_pred_pattern_b_u32<0b10001, "uqincw", int_aarch64_sve_uqincw_n32>;
  defm SQDECW_XPiWdI : sve_int_pred_pattern_b_s32<0b10010, "sqdecw", int_aarch64_sve_sqdecw_n32>;
  defm UQDECW_WPiI   : sve_int_pred_pattern_b_u32<0b10011, "uqdecw", int_aarch64_sve_uqdecw_n32>;
  defm SQINCW_XPiI   : sve_int_pred_pattern_b_x64<0b10100, "sqincw", int_aarch64_sve_sqincw_n64>;
  defm UQINCW_XPiI   : sve_int_pred_pattern_b_x64<0b10101, "uqincw", int_aarch64_sve_uqincw_n64>;
  defm SQDECW_XPiI   : sve_int_pred_pattern_b_x64<0b10110, "sqdecw", int_aarch64_sve_sqdecw_n64>;
  defm UQDECW_XPiI   : sve_int_pred_pattern_b_x64<0b10111, "uqdecw", int_aarch64_sve_uqdecw_n64>;

  defm SQINCD_XPiWdI : sve_int_pred_pattern_b_s32<0b11000, "sqincd", int_aarch64_sve_sqincd_n32>;
  defm UQINCD_WPiI   : sve_int_pred_pattern_b_u32<0b11001, "uqincd", int_aarch64_sve_uqincd_n32>;
  defm SQDECD_XPiWdI : sve_int_pred_pattern_b_s32<0b11010, "sqdecd", int_aarch64_sve_sqdecd_n32>;
  defm UQDECD_WPiI   : sve_int_pred_pattern_b_u32<0b11011, "uqdecd", int_aarch64_sve_uqdecd_n32>;
  defm SQINCD_XPiI   : sve_int_pred_pattern_b_x64<0b11100, "sqincd", int_aarch64_sve_sqincd_n64>;
  defm UQINCD_XPiI   : sve_int_pred_pattern_b_x64<0b11101, "uqincd", int_aarch64_sve_uqincd_n64>;
  defm SQDECD_XPiI   : sve_int_pred_pattern_b_x64<0b11110, "sqdecd", int_aarch64_sve_sqdecd_n64>;
  defm UQDECD_XPiI   : sve_int_pred_pattern_b_x64<0b11111, "uqdecd", int_aarch64_sve_uqdecd_n64>;

  defm SQINCP_XPWd : sve_int_count_r_s32<0b00000, "sqincp", int_aarch64_sve_sqincp_n32>;
  defm SQINCP_XP   : sve_int_count_r_x64<0b00010, "sqincp", int_aarch64_sve_sqincp_n64>;
  defm UQINCP_WP   : sve_int_count_r_u32<0b00100, "uqincp", int_aarch64_sve_uqincp_n32>;
  defm UQINCP_XP   : sve_int_count_r_x64<0b00110, "uqincp", int_aarch64_sve_uqincp_n64>;
  defm SQDECP_XPWd : sve_int_count_r_s32<0b01000, "sqdecp", int_aarch64_sve_sqdecp_n32>;
  defm SQDECP_XP   : sve_int_count_r_x64<0b01010, "sqdecp", int_aarch64_sve_sqdecp_n64>;
  defm UQDECP_WP   : sve_int_count_r_u32<0b01100, "uqdecp", int_aarch64_sve_uqdecp_n32>;
  defm UQDECP_XP   : sve_int_count_r_x64<0b01110, "uqdecp", int_aarch64_sve_uqdecp_n64>;
  defm INCP_XP     : sve_int_count_r_x64<0b10000, "incp">;
  defm DECP_XP     : sve_int_count_r_x64<0b10100, "decp">;

  defm SQINCP_ZP   : sve_int_count_v<0b00000, "sqincp", int_aarch64_sve_sqincp>;
  defm UQINCP_ZP   : sve_int_count_v<0b00100, "uqincp", int_aarch64_sve_uqincp>;
  defm SQDECP_ZP   : sve_int_count_v<0b01000, "sqdecp", int_aarch64_sve_sqdecp>;
  defm UQDECP_ZP   : sve_int_count_v<0b01100, "uqdecp", int_aarch64_sve_uqdecp>;
  defm INCP_ZP     : sve_int_count_v<0b10000, "incp">;
  defm DECP_ZP     : sve_int_count_v<0b10100, "decp">;

  defm INSR_ZR : sve_int_perm_insrs<"insr", AArch64insr>;
  defm INSR_ZV : sve_int_perm_insrv<"insr", AArch64insr>;

  defm PUNPKLO_PP : sve_int_perm_punpk<0b0, "punpklo", int_aarch64_sve_punpklo>;
  defm PUNPKHI_PP : sve_int_perm_punpk<0b1, "punpkhi", int_aarch64_sve_punpkhi>;

  defm REV_PP : sve_int_perm_reverse_p<"rev", AArch64rev>;
  defm REV_ZZ : sve_int_perm_reverse_z<"rev", AArch64rev>;

  defm RBIT_ZPmZ : sve_int_perm_rev_rbit<"rbit", int_aarch64_sve_rbit>;
  defm REVB_ZPmZ : sve_int_perm_rev_revb<"revb", int_aarch64_sve_revb, bswap>;
  defm REVH_ZPmZ : sve_int_perm_rev_revh<"revh", int_aarch64_sve_revh>;
  defm REVW_ZPmZ : sve_int_perm_rev_revw<"revw", int_aarch64_sve_revw>;

  defm SPLICE_ZPZ : sve_int_perm_splice<"splice", int_aarch64_sve_splice>;

  defm SUNPKLO_ZZ : sve_int_perm_unpk<0b00, "sunpklo", AArch64sunpklo>;
  defm SUNPKHI_ZZ : sve_int_perm_unpk<0b01, "sunpkhi", AArch64sunpkhi>;
  defm UUNPKLO_ZZ : sve_int_perm_unpk<0b10, "uunpklo", AArch64uunpklo>;
  defm UUNPKHI_ZZ : sve_int_perm_unpk<0b11, "uunpkhi", AArch64uunpkhi>;

  defm SEL_ZPZZ : sve_int_sel_vvv<"sel", vselect>;

  defm INDEX_RR : sve_int_index_rr<"index", series_vector>;
  defm INDEX_IR : sve_int_index_ir<"index", series_vector>;
  defm INDEX_RI : sve_int_index_ri<"index", series_vector>;
  defm INDEX_II : sve_int_index_ii<"index", series_vector>;

  defm CNTP_XPP : sve_int_pcount_pred<0b0000, "cntp", int_aarch64_sve_cntp, int_ctvpop>;
  def : Pat<(i64 (add GPR64:$Xd, (int_ctvpop (nxv16i1 PPR:$Ps)))),
            (INCP_XP_B $Ps, $Xd)>;

  // General case that we ideally never want to match.
  def : Pat<(vscale GPR64:$scale), (MADDXrrr (UBFMXri (RDVLI_XI 1), 4, 63), $scale, XZR)>;

let AddedComplexity = 5 in {
  def : Pat<(vscale (sve_rdvl_imm i32:$imm)), (RDVLI_XI $imm)>;
  def : Pat<(vscale (sve_cnth_imm i32:$imm)), (CNTH_XPiI 31, $imm)>;
  def : Pat<(vscale (sve_cntw_imm i32:$imm)), (CNTW_XPiI 31, $imm)>;
  def : Pat<(vscale (sve_cntd_imm i32:$imm)), (CNTD_XPiI 31, $imm)>;

  def : Pat<(vscale (sve_cnth_imm_neg i32:$imm)), (SUBXrs XZR, (CNTH_XPiI 31, $imm), 0)>;
  def : Pat<(vscale (sve_cntw_imm_neg i32:$imm)), (SUBXrs XZR, (CNTW_XPiI 31, $imm), 0)>;
  def : Pat<(vscale (sve_cntd_imm_neg i32:$imm)), (SUBXrs XZR, (CNTD_XPiI 31, $imm), 0)>;

  def : Pat<(add GPR64:$op, (vscale (sve_rdvl_imm i32:$imm))),
            (ADDVL_XXI GPR64:$op, $imm)>;
  def : Pat<(add GPR64:$op, (vscale (sve_cnth_imm i32:$imm))),
            (INCH_XPiI GPR64:$op, 31, $imm)>;
  def : Pat<(add GPR64:$op, (vscale (sve_cntw_imm i32:$imm))),
            (INCW_XPiI GPR64:$op, 31, $imm)>;
  def : Pat<(add GPR64:$op, (vscale (sve_cntd_imm i32:$imm))),
            (INCD_XPiI GPR64:$op, 31, $imm)>;

  def : Pat<(add GPR64:$op, (vscale (sve_cnth_imm_neg i32:$imm))),
            (DECH_XPiI GPR64:$op, 31, $imm)>;
  def : Pat<(add GPR64:$op, (vscale (sve_cntw_imm_neg i32:$imm))),
            (DECW_XPiI GPR64:$op, 31, $imm)>;
  def : Pat<(add GPR64:$op, (vscale (sve_cntd_imm_neg i32:$imm))),
            (DECD_XPiI GPR64:$op, 31, $imm)>;

  def : Pat<(add GPR32:$op, (i32 (trunc (vscale (sve_rdvl_imm i32:$imm))))),
            (i32 (EXTRACT_SUBREG (ADDVL_XXI (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
                                             GPR32:$op, sub_32), $imm),
                                  sub_32))>;
  def : Pat<(add GPR32:$op, (i32 (trunc (vscale (sve_cnth_imm i32:$imm))))),
            (i32 (EXTRACT_SUBREG (INCH_XPiI (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
                                             GPR32:$op, sub_32), 31, $imm),
                                  sub_32))>;
  def : Pat<(add GPR32:$op, (i32 (trunc (vscale (sve_cntw_imm i32:$imm))))),
            (i32 (EXTRACT_SUBREG (INCW_XPiI (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
                                             GPR32:$op, sub_32), 31, $imm),
                                  sub_32))>;
  def : Pat<(add GPR32:$op, (i32 (trunc (vscale (sve_cntd_imm i32:$imm))))),
            (i32 (EXTRACT_SUBREG (INCD_XPiI (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
                                             GPR32:$op, sub_32), 31, $imm),
                                  sub_32))>;
}

  defm LDR_PXI : sve_mem_32b_pfill<"ldr">;
  defm STR_PXI : sve_mem_pspill<"str">;

  defm CMPHS_PPzZZ : sve_int_cmp_0<0b000, "cmphs", int_aarch64_sve_cmphs, SETUGE>;
  defm CMPHI_PPzZZ : sve_int_cmp_0<0b001, "cmphi", int_aarch64_sve_cmphi, SETUGT>;
  defm CMPGE_PPzZZ : sve_int_cmp_0<0b100, "cmpge", int_aarch64_sve_cmpge, SETGE>;
  defm CMPGT_PPzZZ : sve_int_cmp_0<0b101, "cmpgt", int_aarch64_sve_cmpgt, SETGT>;
  defm CMPEQ_PPzZZ : sve_int_cmp_0<0b110, "cmpeq", int_aarch64_sve_cmpeq, SETEQ>;
  defm CMPNE_PPzZZ : sve_int_cmp_0<0b111, "cmpne", int_aarch64_sve_cmpne, SETNE>;

  defm CMPEQ_WIDE_PPzZZ : sve_int_cmp_0_wide<0b010, "cmpeq", int_aarch64_sve_cmpeq_wide>;
  defm CMPNE_WIDE_PPzZZ : sve_int_cmp_0_wide<0b011, "cmpne", int_aarch64_sve_cmpne_wide>;
  defm CMPGE_WIDE_PPzZZ : sve_int_cmp_1_wide<0b000, "cmpge", int_aarch64_sve_cmpge_wide>;
  defm CMPGT_WIDE_PPzZZ : sve_int_cmp_1_wide<0b001, "cmpgt", int_aarch64_sve_cmpgt_wide>;
  defm CMPLT_WIDE_PPzZZ : sve_int_cmp_1_wide<0b010, "cmplt", int_aarch64_sve_cmplt_wide>;
  defm CMPLE_WIDE_PPzZZ : sve_int_cmp_1_wide<0b011, "cmple", int_aarch64_sve_cmple_wide>;
  defm CMPHS_WIDE_PPzZZ : sve_int_cmp_1_wide<0b100, "cmphs", int_aarch64_sve_cmphs_wide>;
  defm CMPHI_WIDE_PPzZZ : sve_int_cmp_1_wide<0b101, "cmphi", int_aarch64_sve_cmphi_wide>;
  defm CMPLO_WIDE_PPzZZ : sve_int_cmp_1_wide<0b110, "cmplo", int_aarch64_sve_cmplo_wide>;
  defm CMPLS_WIDE_PPzZZ : sve_int_cmp_1_wide<0b111, "cmpls", int_aarch64_sve_cmpls_wide>;

  defm CMPGE_PPzZI : sve_int_scmp_vi<0b000, "cmpge", SETGE, int_aarch64_sve_cmpge>;
  defm CMPGT_PPzZI : sve_int_scmp_vi<0b001, "cmpgt", SETGT, int_aarch64_sve_cmpgt>;
  defm CMPLT_PPzZI : sve_int_scmp_vi<0b010, "cmplt", SETLT, null_frag, int_aarch64_sve_cmpgt>;
  defm CMPLE_PPzZI : sve_int_scmp_vi<0b011, "cmple", SETLE, null_frag, int_aarch64_sve_cmpge>;
  defm CMPEQ_PPzZI : sve_int_scmp_vi<0b100, "cmpeq", SETEQ, int_aarch64_sve_cmpeq>;
  defm CMPNE_PPzZI : sve_int_scmp_vi<0b101, "cmpne", SETNE, int_aarch64_sve_cmpne>;
  defm CMPHS_PPzZI : sve_int_ucmp_vi<0b00, "cmphs", SETUGE, int_aarch64_sve_cmphs>;
  defm CMPHI_PPzZI : sve_int_ucmp_vi<0b01, "cmphi", SETUGT, int_aarch64_sve_cmphi>;
  defm CMPLO_PPzZI : sve_int_ucmp_vi<0b10, "cmplo", SETULT, null_frag, int_aarch64_sve_cmphi>;
  defm CMPLS_PPzZI : sve_int_ucmp_vi<0b11, "cmpls", SETULE, null_frag, int_aarch64_sve_cmphs>;

  def  PFIRST : sve_int_pfirst_next<0b01, 0b00000, "pfirst", PPR8, nxv16i1, int_aarch64_sve_pfirst>;
  defm PNEXT  : sve_int_pfirst_next<0b00110, "pnext", int_aarch64_sve_pnext>;

  def PFALSE : sve_int_pfalse<0b000000, "pfalse">;

  def RDFFR_PPz  : sve_int_rdffr<0b0000000, "rdffr">;
  def RDFFRS_PPz : sve_int_rdffr<0b0100000, "rdffrs">;
  def : Pat<(nxv16i1 (AArch64rdffr_pred (nxv16i1 PPR:$Pg))), (RDFFR_PPz PPR:$Pg)>;
  def : Pat<(nxv8i1  (AArch64rdffr_pred (nxv8i1  PPR:$Pg))), (RDFFR_PPz PPR:$Pg)>;
  def : Pat<(nxv4i1  (AArch64rdffr_pred (nxv4i1  PPR:$Pg))), (RDFFR_PPz PPR:$Pg)>;
  def : Pat<(nxv2i1  (AArch64rdffr_pred (nxv2i1  PPR:$Pg))), (RDFFR_PPz PPR:$Pg)>;

  defm RDFFR_P : sve_int_rdffr_2<0b000000, "rdffr", AArch64rdffr>;

  def SETFFR : sve_int_setffr<"setffr", AArch64setffr>;

  def WRFFR : sve_int_wrffr<"wrffr", AArch64wrffr>;

  def PTEST_PP : sve_int_ptest<0b010000, "ptest">;

  defm BRKA_PPzP  : sve_int_break_z<0b000000, "brka",  int_aarch64_sve_brka_z>;
  defm BRKA_PPmP  : sve_int_break_m<0b000001, "brka",  int_aarch64_sve_brka>;
  defm BRKAS_PPzP : sve_int_break_z<0b010000, "brkas", null_frag>;
  defm BRKB_PPzP  : sve_int_break_z<0b100000, "brkb",  int_aarch64_sve_brkb_z>;
  defm BRKB_PPmP  : sve_int_break_m<0b100001, "brkb",  int_aarch64_sve_brkb>;
  defm BRKBS_PPzP : sve_int_break_z<0b110000, "brkbs", null_frag>;

  defm BRKN_PPzP  : sve_int_brkn<0b0000000, "brkn",  int_aarch64_sve_brkn_z>;
  defm BRKNS_PPzP : sve_int_brkn<0b0100000, "brkns", null_frag>;

  defm BRKPA_PPzPP  : sve_int_brkp<0b0000, "brkpa",  int_aarch64_sve_brkpa_z>;
  defm BRKPAS_PPzPP : sve_int_brkp<0b0100, "brkpas", null_frag>;
  defm BRKPB_PPzPP  : sve_int_brkp<0b0001, "brkpb",  int_aarch64_sve_brkpb_z>;
  defm BRKPBS_PPzPP : sve_int_brkp<0b0101, "brkpbs", null_frag>;

  defm AND_PPzPP   : sve_int_pred_log<0b0000, "and",  int_aarch64_sve_and_z>;
  defm BIC_PPzPP   : sve_int_pred_log<0b0001, "bic",  int_aarch64_sve_bic_z>;
  defm EOR_PPzPP   : sve_int_pred_log<0b0010, "eor",  int_aarch64_sve_eor_z>;
  defm SEL_PPPP    : sve_int_pred_log<0b0011, "sel",  vselect>;
  defm ANDS_PPzPP  : sve_int_pred_log<0b0100, "ands">;
  defm BICS_PPzPP  : sve_int_pred_log<0b0101, "bics">;
  defm EORS_PPzPP  : sve_int_pred_log<0b0110, "eors">;
  defm ORR_PPzPP   : sve_int_pred_log<0b1000, "orr",  int_aarch64_sve_orr_z>;
  defm ORN_PPzPP   : sve_int_pred_log<0b1001, "orn",  int_aarch64_sve_orn_z>;
  defm NOR_PPzPP   : sve_int_pred_log<0b1010, "nor",  int_aarch64_sve_nor_z>;
  defm NAND_PPzPP  : sve_int_pred_log<0b1011, "nand", int_aarch64_sve_nand_z>;
  defm ORRS_PPzPP  : sve_int_pred_log<0b1100, "orrs">;
  defm ORNS_PPzPP  : sve_int_pred_log<0b1101, "orns">;
  defm NORS_PPzPP  : sve_int_pred_log<0b1110, "nors">;
  defm NANDS_PPzPP : sve_int_pred_log<0b1111, "nands">;

  multiclass unpred_from_pred_one_op<SDNode N, string I> {
  def : Pat<(nxv16i8 (N (nxv16i8 ZPR:$Zs))),
            (!cast<Instruction>(I # "_B") (IMPLICIT_DEF), (PTRUE_B 31), ZPR:$Zs)>;
  def : Pat<(nxv8i16 (N (nxv8i16 ZPR:$Zs))),
            (!cast<Instruction>(I # "_H") (IMPLICIT_DEF), (PTRUE_H 31), ZPR:$Zs)>;
  def : Pat<(nxv4i32 (N (nxv4i32 ZPR:$Zs))),
            (!cast<Instruction>(I # "_S") (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (N (nxv2i64 ZPR:$Zs))),
            (!cast<Instruction>(I # "_D") (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  }
  defm CLS_ZPmZ  : sve_int_un_pred_arit_1<   0b000, "cls",  int_aarch64_sve_cls>;
  defm CLZ_ZPmZ  : sve_int_un_pred_arit_1<   0b001, "clz",  int_aarch64_sve_clz>;
  defm CNT_ZPmZ  : sve_int_un_pred_arit_1<   0b010, "cnt",  int_aarch64_sve_cnt>;
  defm CNOT_ZPmZ : sve_int_un_pred_arit_1<   0b011, "cnot", int_aarch64_sve_cnot>;
  defm NOT_ZPmZ  : sve_int_un_pred_arit_1<   0b110, "not",  int_aarch64_sve_not>;
  defm FABS_ZPmZ : sve_int_un_pred_arit_1_fp<0b100, "fabs", int_aarch64_sve_abs>;
  defm FNEG_ZPmZ : sve_int_un_pred_arit_1_fp<0b101, "fneg", int_aarch64_sve_neg>;

  defm : unpred_from_pred_one_op<ctpop,   "CNT_ZPmZ">;
  defm : unpred_from_pred_one_op<ctlz,    "CLZ_ZPmZ">;

  def : Pat<(nxv16i8 (cttz (nxv16i8 ZPR:$Zs))),
            (CLZ_ZPmZ_B (IMPLICIT_DEF), (PTRUE_B 31), (RBIT_ZPmZ_B (IMPLICIT_DEF), (PTRUE_B 31), ZPR:$Zs))>;
  def : Pat<(nxv8i16 (cttz (nxv8i16 ZPR:$Zs))),
            (CLZ_ZPmZ_H (IMPLICIT_DEF), (PTRUE_H 31), (RBIT_ZPmZ_H (IMPLICIT_DEF), (PTRUE_H 31), ZPR:$Zs))>;
  def : Pat<(nxv4i32 (cttz (nxv4i32 ZPR:$Zs))),
            (CLZ_ZPmZ_S (IMPLICIT_DEF), (PTRUE_S 31), (RBIT_ZPmZ_S (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs))>;
  def : Pat<(nxv2i64 (cttz (nxv2i64 ZPR:$Zs))),
            (CLZ_ZPmZ_D (IMPLICIT_DEF), (PTRUE_D 31), (RBIT_ZPmZ_D (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs))>;

  def : SVE_3_Op_Pat<nxv8i16, int_aarch64_sve_cnt, nxv8i16, nxv8i1, nxv8f16, CNT_ZPmZ_H>;
  def : SVE_3_Op_Pat<nxv4i32, int_aarch64_sve_cnt, nxv4i32, nxv4i1, nxv4f32, CNT_ZPmZ_S>;
  def : SVE_3_Op_Pat<nxv2i64, int_aarch64_sve_cnt, nxv2i64, nxv2i1, nxv2f64, CNT_ZPmZ_D>;

  defm FRINTN_ZPmZ : sve_fp_2op_p_zd_HSD<0b00000, "frintn", int_aarch64_sve_rintn>;
  defm FRINTP_ZPmZ : sve_fp_2op_p_zd_HSD<0b00001, "frintp", int_aarch64_sve_rintp>;
  defm FRINTM_ZPmZ : sve_fp_2op_p_zd_HSD<0b00010, "frintm", int_aarch64_sve_rintm>;
  defm FRINTZ_ZPmZ : sve_fp_2op_p_zd_HSD<0b00011, "frintz", int_aarch64_sve_rintz>;
  defm FRINTA_ZPmZ : sve_fp_2op_p_zd_HSD<0b00100, "frinta", int_aarch64_sve_rinta>;
  defm FRINTX_ZPmZ : sve_fp_2op_p_zd_HSD<0b00110, "frintx", int_aarch64_sve_rintx>;
  defm FRINTI_ZPmZ : sve_fp_2op_p_zd_HSD<0b00111, "frinti", int_aarch64_sve_rinti>;
  defm FRECPX_ZPmZ : sve_fp_2op_p_zd_HSD<0b01100, "frecpx", int_aarch64_sve_recpx>;
  defm FSQRT_ZPmZ  : sve_fp_2op_p_zd_HSD<0b01101, "fsqrt",  int_aarch64_sve_sqrt>;

  defm FCVT_ZPmZ_StoH   : sve_fp_2op_p_zd<0b1001000, "fcvt",   ZPR32, ZPR16, int_aarch64_sve_fcvt_f16f32,    nxv8f16, nxv16i1, nxv4f32, ElementSizeS>;
  defm FCVT_ZPmZ_HtoS   : sve_fp_2op_p_zd<0b1001001, "fcvt",   ZPR16, ZPR32, int_aarch64_sve_fcvt_f32f16,    nxv4f32, nxv16i1, nxv8f16, ElementSizeS>;
  defm SCVTF_ZPmZ_HtoH  : sve_fp_2op_p_zd<0b0110010, "scvtf",  ZPR16, ZPR16, int_aarch64_sve_scvtf,          nxv8f16, nxv8i1,  nxv8i16, ElementSizeH>;
  defm SCVTF_ZPmZ_StoS  : sve_fp_2op_p_zd<0b1010100, "scvtf",  ZPR32, ZPR32, int_aarch64_sve_scvtf,          nxv4f32, nxv4i1,  nxv4i32, ElementSizeS>;
  defm UCVTF_ZPmZ_StoS  : sve_fp_2op_p_zd<0b1010101, "ucvtf",  ZPR32, ZPR32, int_aarch64_sve_ucvtf,          nxv4f32, nxv4i1,  nxv4i32, ElementSizeS>;
  defm UCVTF_ZPmZ_HtoH  : sve_fp_2op_p_zd<0b0110011, "ucvtf",  ZPR16, ZPR16, int_aarch64_sve_ucvtf,          nxv8f16, nxv8i1,  nxv8i16, ElementSizeH>;
  defm FCVTZS_ZPmZ_HtoH : sve_fp_2op_p_zd<0b0111010, "fcvtzs", ZPR16, ZPR16, int_aarch64_sve_fcvtzs,         nxv8i16, nxv8i1,  nxv8f16, ElementSizeH>;
  defm FCVTZS_ZPmZ_StoS : sve_fp_2op_p_zd<0b1011100, "fcvtzs", ZPR32, ZPR32, int_aarch64_sve_fcvtzs,         nxv4i32, nxv4i1,  nxv4f32, ElementSizeS>;
  defm FCVTZU_ZPmZ_HtoH : sve_fp_2op_p_zd<0b0111011, "fcvtzu", ZPR16, ZPR16, int_aarch64_sve_fcvtzu,         nxv8i16, nxv8i1,  nxv8f16, ElementSizeH>;
  defm FCVTZU_ZPmZ_StoS : sve_fp_2op_p_zd<0b1011101, "fcvtzu", ZPR32, ZPR32, int_aarch64_sve_fcvtzu,         nxv4i32, nxv4i1,  nxv4f32, ElementSizeS>;
  defm FCVT_ZPmZ_DtoH   : sve_fp_2op_p_zd<0b1101000, "fcvt",   ZPR64, ZPR16, int_aarch64_sve_fcvt_f16f64,    nxv8f16, nxv16i1, nxv2f64, ElementSizeD>;
  defm FCVT_ZPmZ_HtoD   : sve_fp_2op_p_zd<0b1101001, "fcvt",   ZPR16, ZPR64, int_aarch64_sve_fcvt_f64f16,    nxv2f64, nxv16i1, nxv8f16, ElementSizeD>;
  defm FCVT_ZPmZ_DtoS   : sve_fp_2op_p_zd<0b1101010, "fcvt",   ZPR64, ZPR32, int_aarch64_sve_fcvt_f32f64,    nxv4f32, nxv16i1, nxv2f64, ElementSizeD>;
  defm FCVT_ZPmZ_StoD   : sve_fp_2op_p_zd<0b1101011, "fcvt",   ZPR32, ZPR64, int_aarch64_sve_fcvt_f64f32,    nxv2f64, nxv16i1, nxv4f32, ElementSizeD>;
  defm SCVTF_ZPmZ_StoD  : sve_fp_2op_p_zd<0b1110000, "scvtf",  ZPR32, ZPR64, int_aarch64_sve_scvtf_f64i32,   nxv2f64, nxv16i1, nxv4i32, ElementSizeD>;
  defm UCVTF_ZPmZ_StoD  : sve_fp_2op_p_zd<0b1110001, "ucvtf",  ZPR32, ZPR64, int_aarch64_sve_ucvtf_f64i32,   nxv2f64, nxv16i1, nxv4i32, ElementSizeD>;
  defm UCVTF_ZPmZ_StoH  : sve_fp_2op_p_zd<0b0110101, "ucvtf",  ZPR32, ZPR16, int_aarch64_sve_ucvtf_f16i32,   nxv8f16, nxv16i1, nxv4i32, ElementSizeS>;
  defm SCVTF_ZPmZ_DtoS  : sve_fp_2op_p_zd<0b1110100, "scvtf",  ZPR64, ZPR32, int_aarch64_sve_scvtf_f32i64,   nxv4f32, nxv16i1, nxv2i64, ElementSizeD>;
  defm SCVTF_ZPmZ_StoH  : sve_fp_2op_p_zd<0b0110100, "scvtf",  ZPR32, ZPR16, int_aarch64_sve_scvtf_f16i32,   nxv8f16, nxv16i1, nxv4i32, ElementSizeS>;
  defm SCVTF_ZPmZ_DtoH  : sve_fp_2op_p_zd<0b0110110, "scvtf",  ZPR64, ZPR16, int_aarch64_sve_scvtf_f16i64,   nxv8f16, nxv16i1, nxv2i64, ElementSizeD>;
  defm UCVTF_ZPmZ_DtoS  : sve_fp_2op_p_zd<0b1110101, "ucvtf",  ZPR64, ZPR32, int_aarch64_sve_ucvtf_f32i64,   nxv4f32, nxv16i1, nxv2i64, ElementSizeD>;
  defm UCVTF_ZPmZ_DtoH  : sve_fp_2op_p_zd<0b0110111, "ucvtf",  ZPR64, ZPR16, int_aarch64_sve_ucvtf_f16i64,   nxv8f16, nxv16i1, nxv2i64, ElementSizeD>;
  defm SCVTF_ZPmZ_DtoD  : sve_fp_2op_p_zd<0b1110110, "scvtf",  ZPR64, ZPR64, int_aarch64_sve_scvtf,          nxv2f64, nxv2i1,  nxv2i64, ElementSizeD>;
  defm UCVTF_ZPmZ_DtoD  : sve_fp_2op_p_zd<0b1110111, "ucvtf",  ZPR64, ZPR64, int_aarch64_sve_ucvtf,          nxv2f64, nxv2i1,  nxv2i64, ElementSizeD>;
  defm FCVTZS_ZPmZ_DtoS : sve_fp_2op_p_zd<0b1111000, "fcvtzs", ZPR64, ZPR32, int_aarch64_sve_fcvtzs_i32f64,  nxv4i32, nxv16i1, nxv2f64, ElementSizeD>;
  defm FCVTZU_ZPmZ_DtoS : sve_fp_2op_p_zd<0b1111001, "fcvtzu", ZPR64, ZPR32, int_aarch64_sve_fcvtzu_i32f64,  nxv4i32, nxv16i1, nxv2f64, ElementSizeD>;
  defm FCVTZS_ZPmZ_StoD : sve_fp_2op_p_zd<0b1111100, "fcvtzs", ZPR32, ZPR64, int_aarch64_sve_fcvtzs_i64f32,  nxv2i64, nxv16i1, nxv4f32, ElementSizeD>;
  defm FCVTZS_ZPmZ_HtoS : sve_fp_2op_p_zd<0b0111100, "fcvtzs", ZPR16, ZPR32, int_aarch64_sve_fcvtzs_i32f16,  nxv4i32, nxv16i1, nxv8f16, ElementSizeS>;
  defm FCVTZS_ZPmZ_HtoD : sve_fp_2op_p_zd<0b0111110, "fcvtzs", ZPR16, ZPR64, int_aarch64_sve_fcvtzs_i64f16,  nxv2i64, nxv16i1, nxv8f16, ElementSizeD>;
  defm FCVTZU_ZPmZ_HtoS : sve_fp_2op_p_zd<0b0111101, "fcvtzu", ZPR16, ZPR32, int_aarch64_sve_fcvtzu_i32f16,  nxv4i32, nxv16i1, nxv8f16, ElementSizeS>;
  defm FCVTZU_ZPmZ_HtoD : sve_fp_2op_p_zd<0b0111111, "fcvtzu", ZPR16, ZPR64, int_aarch64_sve_fcvtzu_i64f16,  nxv2i64, nxv16i1, nxv8f16, ElementSizeD>;
  defm FCVTZU_ZPmZ_StoD : sve_fp_2op_p_zd<0b1111101, "fcvtzu", ZPR32, ZPR64, int_aarch64_sve_fcvtzu_i64f32,  nxv2i64, nxv16i1, nxv4f32, ElementSizeD>;
  defm FCVTZS_ZPmZ_DtoD : sve_fp_2op_p_zd<0b1111110, "fcvtzs", ZPR64, ZPR64, int_aarch64_sve_fcvtzs,         nxv2i64, nxv2i1,  nxv2f64, ElementSizeD>;
  defm FCVTZU_ZPmZ_DtoD : sve_fp_2op_p_zd<0b1111111, "fcvtzu", ZPR64, ZPR64, int_aarch64_sve_fcvtzu,         nxv2i64, nxv2i1,  nxv2f64, ElementSizeD>;

  defm FADD_ZZZ    : sve_fp_3op_u_zd<0b000, "fadd", fadd>;
  defm FSUB_ZZZ    : sve_fp_3op_u_zd<0b001, "fsub", fsub>;
  defm FMUL_ZZZ    : sve_fp_3op_u_zd<0b010, "fmul", fmul>;
  defm FTSMUL_ZZZ  : sve_fp_3op_u_zd_ftsmul<0b011, "ftsmul", int_aarch64_sve_tsmul>;
  defm FRECPS_ZZZ  : sve_fp_3op_u_zd<0b110, "frecps", int_aarch64_sve_recps>;
  defm FRSQRTS_ZZZ : sve_fp_3op_u_zd<0b111, "frsqrts", int_aarch64_sve_rsqrts>;

  def : Pat<(nxv4f32 (AArch64frecps (nxv4f32 ZPR:$Zs1), (nxv4f32 ZPR:$Zs2))),
            (FRECPS_ZZZ_S ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2f64 (AArch64frecps (nxv2f64 ZPR:$Zs1), (nxv2f64 ZPR:$Zs2))),
            (FRECPS_ZZZ_D ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv4f32 (AArch64frsqrts (nxv4f32 ZPR:$Zs1), (nxv4f32 ZPR:$Zs2))),
            (FRSQRTS_ZZZ_S ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2f64 (AArch64frsqrts (nxv2f64 ZPR:$Zs1), (nxv2f64 ZPR:$Zs2))),
            (FRSQRTS_ZZZ_D ZPR:$Zs1, ZPR:$Zs2)>;

  defm FMLA_ZPmZZ  : sve_fp_3op_p_zds_a<0b00, "fmla",  "FMLA_ZPZZZ", int_aarch64_sve_mla, "FMAD_ZPmZZ", 1>;
  defm FMLS_ZPmZZ  : sve_fp_3op_p_zds_a<0b01, "fmls",  "FMLS_ZPZZZ", int_aarch64_sve_mls, "FMSB_ZPmZZ", 1>;
  defm FNMLA_ZPmZZ : sve_fp_3op_p_zds_a<0b10, "fnmla", "FNMLA_ZPZZZ", int_aarch64_sve_nmla, "FNMAD_ZPmZZ", 1>;
  defm FNMLS_ZPmZZ : sve_fp_3op_p_zds_a<0b11, "fnmls", "FNMLS_ZPZZZ", int_aarch64_sve_nmls, "FNMSB_ZPmZZ", 1>;

  defm FMLA_ZPZZZ  : sve_fp_3op_p_zds_zx<int_aarch64_sve_mla>;
  defm FMLS_ZPZZZ  : sve_fp_3op_p_zds_zx<int_aarch64_sve_mls>;
  defm FNMLA_ZPZZZ : sve_fp_3op_p_zds_zx<int_aarch64_sve_nmla>;
  defm FNMLS_ZPZZZ : sve_fp_3op_p_zds_zx<int_aarch64_sve_nmls>;

  defm FMLA_ZPmZZI : sve_fp_fma_by_indexed_elem<0b0, "fmla", int_aarch64_sve_mla_lane>;
  defm FMLS_ZPmZZI : sve_fp_fma_by_indexed_elem<0b1, "fmls", int_aarch64_sve_mls_lane>;

  defm FMUL_ZZZI   : sve_fp_fmul_by_indexed_elem<"fmul", int_aarch64_sve_mul_lane>;

  defm FMAD_ZPmZZ  : sve_fp_3op_p_zds_b<0b00, "fmad",  "FMAD_ZPZZZ", int_aarch64_sve_mad, "FMLA_ZPmZZ", 0>;
  defm FMSB_ZPmZZ  : sve_fp_3op_p_zds_b<0b01, "fmsb",  "FMSB_ZPZZZ", int_aarch64_sve_msb, "FMLS_ZPmZZ", 0>;
  defm FNMAD_ZPmZZ : sve_fp_3op_p_zds_b<0b10, "fnmad", "FNMAD_ZPZZZ", int_aarch64_sve_nmad, "FNMLA_ZPmZZ", 0>;
  defm FNMSB_ZPmZZ : sve_fp_3op_p_zds_b<0b11, "fnmsb", "FNMSB_ZPZZZ", int_aarch64_sve_nmsb, "FNMLS_ZPmZZ", 0>;

  defm FMAD_ZPZZZ  : sve_fp_3op_p_zds_zx<int_aarch64_sve_mad>;
  defm FMSB_ZPZZZ  : sve_fp_3op_p_zds_zx<int_aarch64_sve_msb>;
  defm FNMAD_ZPZZZ : sve_fp_3op_p_zds_zx<int_aarch64_sve_nmad>;
  defm FNMSB_ZPZZZ : sve_fp_3op_p_zds_zx<int_aarch64_sve_nmsb>;

  defm FADD_ZPmI    : sve_fp_2op_i_p_zds<0b000, "fadd", "FADD_ZPZI", sve_fpimm_half_one>;
  defm FSUB_ZPmI    : sve_fp_2op_i_p_zds<0b001, "fsub", "FSUB_ZPZI", sve_fpimm_half_one>;
  defm FMUL_ZPmI    : sve_fp_2op_i_p_zds<0b010, "fmul", "FMUL_ZPZI", sve_fpimm_half_two>;
  defm FSUBR_ZPmI   : sve_fp_2op_i_p_zds<0b011, "fsubr", "FSUBR_ZPZI", sve_fpimm_half_one>;
  defm FMAXNM_ZPmI  : sve_fp_2op_i_p_zds<0b100, "fmaxnm", "FMAXNM_ZPZI", sve_fpimm_zero_one>;
  defm FMINNM_ZPmI  : sve_fp_2op_i_p_zds<0b101, "fminnm", "FMINNM_ZPZI", sve_fpimm_zero_one>;
  defm FMAX_ZPmI    : sve_fp_2op_i_p_zds<0b110, "fmax", "FMAX_ZPZI", sve_fpimm_zero_one>;
  defm FMIN_ZPmI    : sve_fp_2op_i_p_zds<0b111, "fmin", "FMIN_ZPZI", sve_fpimm_zero_one>;

  defm FADD_ZPZI    : sve_fp_2op_i_p_zds_zx<sve_fpimm_half_one>;
  defm FSUB_ZPZI    : sve_fp_2op_i_p_zds_zx<sve_fpimm_half_one>;
  defm FMUL_ZPZI    : sve_fp_2op_i_p_zds_zx<sve_fpimm_half_two>;
  defm FSUBR_ZPZI   : sve_fp_2op_i_p_zds_zx<sve_fpimm_half_one>;
  defm FMAXNM_ZPZI  : sve_fp_2op_i_p_zds_zx<sve_fpimm_zero_one>;
  defm FMINNM_ZPZI  : sve_fp_2op_i_p_zds_zx<sve_fpimm_zero_one>;
  defm FMAX_ZPZI    : sve_fp_2op_i_p_zds_zx<sve_fpimm_zero_one>;
  defm FMIN_ZPZI    : sve_fp_2op_i_p_zds_zx<sve_fpimm_zero_one>;

  defm FADD_ZPmZ   : sve_fp_2op_p_zds<0b0000, "fadd", "FADD_ZPZZ", int_aarch64_sve_add, DestructiveBinaryComm>;
  defm FSUB_ZPmZ   : sve_fp_2op_p_zds<0b0001, "fsub", "FSUB_ZPZZ", int_aarch64_sve_sub, DestructiveBinaryCommWithRev, "FSUBR_ZPmZ", 1>;
  defm FMUL_ZPmZ   : sve_fp_2op_p_zds<0b0010, "fmul", "FMUL_ZPZZ", int_aarch64_sve_mul, DestructiveBinaryComm>;
  defm FSUBR_ZPmZ  : sve_fp_2op_p_zds<0b0011, "fsubr", "FSUBR_ZPZZ", int_aarch64_sve_subr, DestructiveBinaryCommWithRev, "FSUB_ZPmZ", 0>;
  defm FMAXNM_ZPmZ : sve_fp_2op_p_zds<0b0100, "fmaxnm", "FMAXNM_ZPZZ", AArch64fmaxnm_pred, DestructiveBinaryComm>;
  defm FMINNM_ZPmZ : sve_fp_2op_p_zds<0b0101, "fminnm", "FMINNM_ZPZZ", AArch64fminnm_pred, DestructiveBinaryComm>;
  defm FMAX_ZPmZ   : sve_fp_2op_p_zds<0b0110, "fmax", "FMAX_ZPZZ", AArch64fmax_pred, DestructiveBinaryComm>;
  defm FMIN_ZPmZ   : sve_fp_2op_p_zds<0b0111, "fmin", "FMIN_ZPZZ", AArch64fmin_pred, DestructiveBinaryComm>;
  defm FABD_ZPmZ   : sve_fp_2op_p_zds<0b1000, "fabd", "FABD_ZPZZ", int_aarch64_sve_abd, DestructiveBinaryComm>;
  defm FSCALE_ZPmZ : sve_fp_2op_p_zds_fscale<0b1001, "fscale", "FSCALE_ZPZZ", int_aarch64_sve_scale>;
  defm FMULX_ZPmZ  : sve_fp_2op_p_zds<0b1010, "fmulx", "FMULX_ZPZZ", int_aarch64_sve_mulx, DestructiveBinaryComm>;
  defm FDIVR_ZPmZ  : sve_fp_2op_p_zds<0b1100, "fdivr", "FDIVR_ZPZZ", int_aarch64_sve_divr, DestructiveBinaryCommWithRev, "FDIV_ZPmZ", 0>;
  defm FDIV_ZPmZ   : sve_fp_2op_p_zds<0b1101, "fdiv", "FDIV_ZPZZ", int_aarch64_sve_div, DestructiveBinaryCommWithRev, "FDIVR_ZPmZ", 1>;

  defm FADD_ZPZZ   : sve_fp_2op_p_zds_zx<int_aarch64_sve_add>;
  defm FSUB_ZPZZ   : sve_fp_2op_p_zds_zx<int_aarch64_sve_sub>;
  defm FMUL_ZPZZ   : sve_fp_2op_p_zds_zx<int_aarch64_sve_mul>;
  defm FSUBR_ZPZZ  : sve_fp_2op_p_zds_zx<int_aarch64_sve_subr>;
  defm FMAXNM_ZPZZ : sve_fp_2op_p_zds_zx<AArch64fmaxnm_pred>;
  defm FMINNM_ZPZZ : sve_fp_2op_p_zds_zx<AArch64fminnm_pred>;
  defm FMAX_ZPZZ   : sve_fp_2op_p_zds_zx<AArch64fmax_pred>;
  defm FMIN_ZPZZ   : sve_fp_2op_p_zds_zx<AArch64fmin_pred>;
  defm FABD_ZPZZ   : sve_fp_2op_p_zds_zx<int_aarch64_sve_abd>;
  defm FSCALE_ZPZZ : sve_fp_2op_p_zds_fscale_zx<int_aarch64_sve_scale>;
  defm FMULX_ZPZZ  : sve_fp_2op_p_zds_zx<int_aarch64_sve_mulx>;
  defm FDIVR_ZPZZ  : sve_fp_2op_p_zds_zx<int_aarch64_sve_divr>;
  defm FDIV_ZPZZ   : sve_fp_2op_p_zds_zx<int_aarch64_sve_div>;

  defm FCADD_ZPmZ : sve_fp_fcadd<"fcadd", int_aarch64_sve_cadd>;
  defm FCMLA_ZPmZZ : sve_fp_fcmla<"fcmla", int_aarch64_sve_cmla>;
  defm FCMLA_ZZZI : sve_fp_fcmla_by_indexed_elem<"fcmla", int_aarch64_sve_cmla_lane>;

  defm SDOT_ZZZ : sve_intx_dot<0b0, "sdot", int_aarch64_sve_sdot>;
  defm UDOT_ZZZ : sve_intx_dot<0b1, "udot", int_aarch64_sve_udot>;

  defm SDOT_ZZZI : sve_intx_dot_by_indexed_elem<0b0, "sdot", int_aarch64_sve_sdot_lane>;
  defm UDOT_ZZZI : sve_intx_dot_by_indexed_elem<0b1, "udot", int_aarch64_sve_udot_lane>;

  let hasNoSchedulingInfo = 1 in {
    class PredSelZeroOpPseudo<ZPRRegOp zprty>
    : Pseudo<(outs zprty:$Zd), (ins PPR3bAny:$Pg, zprty:$Zs1, zprty:$Zs2), []>;
  }

  multiclass selzero {
    def _B : PredSelZeroOpPseudo<ZPR8>;
    def _H : PredSelZeroOpPseudo<ZPR16>;
    def _S : PredSelZeroOpPseudo<ZPR32>;
    def _D : PredSelZeroOpPseudo<ZPR64>;

    def : Pat<(vselect nxv16i1:$Op1, nxv16i8:$Op2, (nxv16i8 (AArch64dup (i32 0)))),
              (!cast<Pseudo>(NAME # "_B") $Op1, $Op2, (DUP_ZI_B 0, 0))>;
    def : Pat<(vselect nxv8i1:$Op1, nxv8i16:$Op2, (nxv8i16 (AArch64dup (i32 0)))),
              (!cast<Pseudo>(NAME # "_H") $Op1, $Op2, (DUP_ZI_H 0, 0))>;
    def : Pat<(vselect nxv4i1:$Op1, nxv4i32:$Op2, (nxv4i32 (AArch64dup (i32 0)))),
              (!cast<Pseudo>(NAME # "_S") $Op1, $Op2, (DUP_ZI_S 0, 0))>;
    def : Pat<(vselect nxv2i1:$Op1, nxv2i64:$Op2, (nxv2i64 (AArch64dup (i64 0)))),
              (!cast<Pseudo>(NAME # "_D") $Op1, $Op2, (DUP_ZI_D 0, 0))>;
    def : Pat<(vselect nxv8i1:$Op1, nxv8f16:$Op2, (nxv8f16 (AArch64dup (f16 fpimm0)))),
              (!cast<Pseudo>(NAME # "_H") $Op1, $Op2, (DUP_ZI_H 0, 0))>;
    def : Pat<(vselect nxv4i1:$Op1, nxv4f32:$Op2, (nxv4f32 (AArch64dup (f32 fpimm0)))),
              (!cast<Pseudo>(NAME # "_S") $Op1, $Op2, (DUP_ZI_S 0, 0))>;
    def : Pat<(vselect nxv2i1:$Op1, nxv2f64:$Op2, (nxv2f64 (AArch64dup (f64 fpimm0)))),
              (!cast<Pseudo>(NAME # "_D") $Op1, $Op2, (DUP_ZI_D 0, 0))>;
  }

  defm SELZERO : selzero;

  multiclass unpred_from_pred_2op_destructive_fp<SDNode N, string I> {
    def : Pat<(nxv2f32 (N (nxv2f32 ZPR:$Zs1), (nxv2f32 ZPR:$Zs2))),
              (!cast<Instruction>(I # "_S") (PTRUE_D 31), ZPR:$Zs1, ZPR:$Zs2)>;
    def : Pat<(nxv4f32 (N (nxv4f32 ZPR:$Zs1), (nxv4f32 ZPR:$Zs2))),
              (!cast<Instruction>(I # "_S") (PTRUE_S 31), ZPR:$Zs1, ZPR:$Zs2)>;
    def : Pat<(nxv2f64 (N (nxv2f64 ZPR:$Zs1), (nxv2f64 ZPR:$Zs2))),
              (!cast<Instruction>(I # "_D") (PTRUE_D 31), ZPR:$Zs1, ZPR:$Zs2)>;
  }

  defm : unpred_from_pred_2op_destructive_fp<fdiv, "FDIV_ZPZZ_UNDEF">;

  defm FTMAD_ZZI : sve_fp_ftmad<"ftmad", int_aarch64_sve_tmad>;

  defm MOVPRFX_ZPzZ : sve_int_movprfx_pred_zero<0b000, "movprfx">;
  defm MOVPRFX_ZPmZ : sve_int_movprfx_pred_merge<0b001, "movprfx">;

  defm FTSSEL_ZZZ : sve_int_bin_cons_misc_0_b<"ftssel", int_aarch64_sve_tssel>;

  def MOVPRFX_ZZ : sve_int_bin_cons_misc_0_c<0b00000001, "movprfx", ZPRAny>;
  def FEXPA_ZZ_H : sve_int_bin_cons_misc_0_c<0b01000000, "fexpa", ZPR16>;
  def FEXPA_ZZ_S : sve_int_bin_cons_misc_0_c<0b10000000, "fexpa", ZPR32>;
  def FEXPA_ZZ_D : sve_int_bin_cons_misc_0_c<0b11000000, "fexpa", ZPR64>;
  def : SVE_1_Op_Pat<nxv8f16, int_aarch64_sve_expa, nxv8i16, FEXPA_ZZ_H>;
  def : SVE_1_Op_Pat<nxv4f32, int_aarch64_sve_expa, nxv4i32, FEXPA_ZZ_S>;
  def : SVE_1_Op_Pat<nxv2f64, int_aarch64_sve_expa, nxv2i64, FEXPA_ZZ_D>;

  defm FRECPE_ZZ  : sve_fp_2op_u_zd<0b110, "frecpe", int_aarch64_sve_recpe>;
  defm FRSQRTE_ZZ : sve_fp_2op_u_zd<0b111, "frsqrte", int_aarch64_sve_rsqrte>;

  def : Pat<(nxv4f32 (AArch64frecpe (nxv4f32 ZPR:$Zs))),
            (FRECPE_ZZ_S ZPR:$Zs)>;
  def : Pat<(nxv2f64 (AArch64frecpe (nxv2f64 ZPR:$Zs))),
            (FRECPE_ZZ_D ZPR:$Zs)>;
  def : Pat<(nxv4f32 (AArch64frsqrte (nxv4f32 ZPR:$Zs))),
            (FRSQRTE_ZZ_S ZPR:$Zs)>;
  def : Pat<(nxv2f64 (AArch64frsqrte (nxv2f64 ZPR:$Zs))),
            (FRSQRTE_ZZ_D ZPR:$Zs)>;

  multiclass unpred_from_pred_one_op_fp<SDNode N, string I> {
  def : Pat<(nxv2f32 (N (nxv2f32 ZPR:$Zs))),
            (!cast<Instruction>(I # "_S") (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv4f32 (N (nxv4f32 ZPR:$Zs))),
            (!cast<Instruction>(I # "_S") (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (N (nxv2f64 ZPR:$Zs))),
            (!cast<Instruction>(I # "_D") (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  }
  defm : unpred_from_pred_one_op_fp<fabs,       "FABS_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<fceil,      "FRINTP_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<ffloor,     "FRINTM_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<ftrunc,     "FRINTZ_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<fnearbyint, "FRINTI_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<fneg,       "FNEG_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<frint,      "FRINTX_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<fround,     "FRINTA_ZPmZ">;
  defm : unpred_from_pred_one_op_fp<fsqrt,      "FSQRT_ZPmZ">;

  // Use the standard packed operations on our unpacked types
  // TODO: if/when we care about FP exceptions these must use predication
  def : Pat<(nxv2f16 (fadd (nxv2f16 ZPR:$Zs1), (nxv2f16 ZPR:$Zs2))),
            (FADD_ZZZ_H ZPR:$Zs1, ZPR:$Zs2)>;

  def : Pat<(nxv2f32 (fadd (nxv2f32 ZPR:$Zs1), (nxv2f32 ZPR:$Zs2))),
            (FADD_ZZZ_S ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2f32 (fsub (nxv2f32 ZPR:$Zs1), (nxv2f32 ZPR:$Zs2))),
            (FSUB_ZZZ_S ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2f32 (fmul (nxv2f32 ZPR:$Zs1), (nxv2f32 ZPR:$Zs2))),
            (FMUL_ZZZ_S ZPR:$Zs1, ZPR:$Zs2)>;

  // Zd = Za + Zn * Zm
  def : Pat<(nxv4f32 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)),
            (FMLA_ZPZZZ_UNDEF_S (PTRUE_S 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f32 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)),
            (FMLA_ZPZZZ_UNDEF_S (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f64 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)),
            (FMLA_ZPZZZ_UNDEF_D (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // Zd = Za + -Zn * Zm
  def : Pat<(nxv4f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)),
            (FMLS_ZPZZZ_UNDEF_S (PTRUE_S 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)),
            (FMLS_ZPZZZ_UNDEF_S (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f64 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)),
            (FMLS_ZPZZZ_UNDEF_D (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // Zd = -Za + Zn * Zm
  def : Pat<(nxv4f32 (fma ZPR:$Zn, ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLS_ZPZZZ_UNDEF_S (PTRUE_S 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f32 (fma ZPR:$Zn, ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLS_ZPZZZ_UNDEF_S (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f64 (fma ZPR:$Zn, ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLS_ZPZZZ_UNDEF_D (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // Zd = -Za + -Zn * Zm
  def : Pat<(nxv4f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLA_ZPZZZ_UNDEF_S (PTRUE_S 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLA_ZPZZZ_UNDEF_S (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(nxv2f64 (fma (fneg ZPR:$Zn), ZPR:$Zm, (fneg ZPR:$Za))),
            (FNMLA_ZPZZZ_UNDEF_D (PTRUE_D 31), ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // Zda = Zda + Zn * Zm
  def : Pat<(vselect (nxv4i1 PPR:$Pg), (nxv4f32 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLA_ZPmZZ_S PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(vselect (nxv2i1 PPR:$Pg), (nxv2f32 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLA_ZPmZZ_S PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(vselect (nxv2i1 PPR:$Pg), (nxv2f64 (fma ZPR:$Zn, ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLA_ZPmZZ_D PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // Zda = Zda + -Zn * Zm
  def : Pat<(vselect (nxv4i1 PPR:$Pg), (nxv4f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLS_ZPmZZ_S PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(vselect (nxv2i1 PPR:$Pg), (nxv2f32 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLS_ZPmZZ_S PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;
  def : Pat<(vselect (nxv2i1 PPR:$Pg), (nxv2f64 (fma (fneg ZPR:$Zn), ZPR:$Zm, ZPR:$Za)), ZPR:$Za),
            (FMLS_ZPmZZ_D PPR:$Pg, ZPR:$Za, ZPR:$Zn, ZPR:$Zm)>;

  // as above but with the resulting compare operands switched
  multiclass SVEInvCmpPat<CondCode IN_CMP, string OUT_CMP > {
    def : Pat<(nxv16i8 (setcc (nxv16i8 ZPR:$Zs1), (nxv16i8 ZPR:$Zs2), IN_CMP)),
              (CPY_ZPzI_B (!cast<Instruction>(!strconcat(OUT_CMP, "_B"))
                          (PTRUE_B 31), ZPR:$Zs2, ZPR:$Zs1), -1, 0)>;

    def : Pat<(nxv8i16 (setcc (nxv8i16 ZPR:$Zs1), (nxv8i16 ZPR:$Zs2), IN_CMP)),
              (CPY_ZPzI_H (!cast<Instruction>(!strconcat(OUT_CMP, "_H"))
                          (PTRUE_H 31), ZPR:$Zs2, ZPR:$Zs1), -1, 0)>;

    def : Pat<(nxv4i32 (setcc (nxv4i32 ZPR:$Zs1), (nxv4i32 ZPR:$Zs2), IN_CMP)),
              (CPY_ZPzI_S (!cast<Instruction>(!strconcat(OUT_CMP, "_S"))
                          (PTRUE_S 31), ZPR:$Zs2, ZPR:$Zs1), -1, 0)>;

    def : Pat<(nxv2i64 (setcc (nxv2i64 ZPR:$Zs1), (nxv2i64 ZPR:$Zs2), IN_CMP)),
              (CPY_ZPzI_D (!cast<Instruction>(!strconcat(OUT_CMP, "_D"))
                          (PTRUE_D 31), ZPR:$Zs2, ZPR:$Zs1), -1, 0)>;

    def : Pat<(nxv16i1 (setcc (nxv16i8 ZPR:$Zs1), (nxv16i8 ZPR:$Zs2), IN_CMP)),
              (!cast<Instruction>(!strconcat(OUT_CMP, "_B"))
               (PTRUE_B 31), ZPR:$Zs2, ZPR:$Zs1)>;

    def : Pat<(nxv8i1 (setcc (nxv8i16 ZPR:$Zs1), (nxv8i16 ZPR:$Zs2), IN_CMP)),
              (!cast<Instruction>(!strconcat(OUT_CMP, "_H"))
               (PTRUE_H 31), ZPR:$Zs2, ZPR:$Zs1)>;

    def : Pat<(nxv4i1 (setcc (nxv4i32 ZPR:$Zs1), (nxv4i32 ZPR:$Zs2), IN_CMP)),
              (!cast<Instruction>(!strconcat(OUT_CMP, "_S"))
               (PTRUE_S 31), ZPR:$Zs2, ZPR:$Zs1)>;

    def : Pat<(nxv2i1 (setcc (nxv2i64 ZPR:$Zs1), (nxv2i64 ZPR:$Zs2), IN_CMP)),
              (!cast<Instruction>(!strconcat(OUT_CMP, "_D"))
               (PTRUE_D 31), ZPR:$Zs2, ZPR:$Zs1)>;
  }

  // FUTURE: find out why this happens and stop it?
  def : Pat<(nxv16i8 (vselect (nxv16i8 ZPR:$P), ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_B (CMPNE_PPzZI_B (PTRUE_B 31), ZPR:$P, 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv8i16 (vselect (nxv8i16 ZPR:$P), ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_H (CMPNE_PPzZI_H (PTRUE_H 31), ZPR:$P, 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv4i32 (vselect (nxv4i32 ZPR:$P), ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), ZPR:$P, 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2i64 (vselect (nxv2i64 ZPR:$P), ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_D (CMPNE_PPzZI_D (PTRUE_D 31), ZPR:$P, 0), ZPR:$Zs1, ZPR:$Zs2)>;

  // Whole vector selects.
  def : Pat<(nxv16i8 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv8i16 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv4i32 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2i64 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2f32 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv4f32 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2f64 (select GPR32:$cond, ZPR:$Zs1, ZPR:$Zs2)),
            (SEL_ZPZZ_S (CMPNE_PPzZI_S (PTRUE_S 31), (DUP_ZR_S $cond), 0), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv16i1 (select GPR32:$cond, PPR:$Ps1, PPR:$Ps2)),
            (SEL_PPPP (CMPNE_PPzZI_B (PTRUE_B 31), (DUP_ZR_B $cond), 0), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv8i1 (select GPR32:$cond, PPR:$Ps1, PPR:$Ps2)),
            (SEL_PPPP (CMPNE_PPzZI_B (PTRUE_B 31), (DUP_ZR_B $cond), 0), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv4i1 (select GPR32:$cond, PPR:$Ps1, PPR:$Ps2)),
            (SEL_PPPP (CMPNE_PPzZI_B (PTRUE_B 31), (DUP_ZR_B $cond), 0), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv2i1 (select GPR32:$cond, PPR:$Ps1, PPR:$Ps2)),
            (SEL_PPPP (CMPNE_PPzZI_B (PTRUE_B 31), (DUP_ZR_B $cond), 0), PPR:$Ps1, PPR:$Ps2)>;

  // Extract element from vector with immediate index
  def : Pat<(i32 (vector_extract (nxv16i8 ZPR:$vec), sve_elm_idx_extdup_b:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_B ZPR:$vec, sve_elm_idx_extdup_b:$index), ssub)>;
  def : Pat<(i32 (vector_extract (nxv8i16 ZPR:$vec), sve_elm_idx_extdup_h:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_H ZPR:$vec, sve_elm_idx_extdup_h:$index), ssub)>;
  def : Pat<(i32 (vector_extract (nxv4i32 ZPR:$vec), sve_elm_idx_extdup_s:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_S ZPR:$vec, sve_elm_idx_extdup_s:$index), ssub)>;
  def : Pat<(i64 (vector_extract (nxv2i64 ZPR:$vec), sve_elm_idx_extdup_d:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_D ZPR:$vec, sve_elm_idx_extdup_d:$index), dsub)>;
  def : Pat<(f32 (vector_extract (nxv4f32 ZPR:$vec), sve_elm_idx_extdup_s:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_S ZPR:$vec, sve_elm_idx_extdup_s:$index), ssub)>;
  def : Pat<(f64 (vector_extract (nxv2f64 ZPR:$vec), sve_elm_idx_extdup_d:$index)),
            (EXTRACT_SUBREG (DUP_ZZI_D ZPR:$vec, sve_elm_idx_extdup_d:$index), dsub)>;

  // Extract element from vector with scalar index
  def : Pat<(i32 (vector_extract (nxv16i8 ZPR:$vec), GPR64:$index)),
            (LASTB_RPZ_B (CMPEQ_PPzZZ_B (PTRUE_B 31),
                                        (INDEX_II_B 0, 1),
                                        (DUP_ZR_B (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                         ZPR:$vec)>;
  def : Pat<(i32 (vector_extract (nxv8i16 ZPR:$vec), GPR64:$index)),
            (LASTB_RPZ_H (CMPEQ_PPzZZ_H (PTRUE_H 31),
                                        (INDEX_II_H 0, 1),
                                        (DUP_ZR_H (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                         ZPR:$vec)>;
  def : Pat<(i32 (vector_extract (nxv4i32 ZPR:$vec), GPR64:$index)),
            (LASTB_RPZ_S (CMPEQ_PPzZZ_S (PTRUE_S 31),
                                        (INDEX_II_S 0, 1),
                                        (DUP_ZR_S (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                         ZPR:$vec)>;
  def : Pat<(i64 (vector_extract (nxv2i64 ZPR:$vec), GPR64:$index)),
            (LASTB_RPZ_D (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                        (INDEX_II_D 0, 1),
                                        (DUP_ZR_D GPR64:$index)),
                         ZPR:$vec)>;

  def : Pat<(f32 (vector_extract (nxv4f32 ZPR:$vec), GPR64:$index)),
            (LASTB_VPZ_S (CMPEQ_PPzZZ_S (PTRUE_S 31),
                                        (INDEX_II_S 0, 1),
                                        (DUP_ZR_S (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                         ZPR:$vec)>;
  def : Pat<(f64 (vector_extract (nxv2f64 ZPR:$vec), GPR64:$index)),
            (LASTB_VPZ_D (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                        (INDEX_II_D 0, 1),
                                        (DUP_ZR_D $index)),
                         ZPR:$vec)>;
  def : Pat<(f32 (vector_extract (nxv2f32 ZPR:$vec), GPR64:$index)),
            (LASTB_VPZ_S (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                        (INDEX_II_D 0, 1),
                                        (DUP_ZR_D $index)),
                         ZPR:$vec)>;

  defm ASR_ZZI : sve_int_bin_cons_shift_b_right<0b00, "asr", sra>;
  defm LSR_ZZI : sve_int_bin_cons_shift_b_right<0b01, "lsr", srl>;
  defm LSL_ZZI : sve_int_bin_cons_shift_b_left< 0b11, "lsl", shl>;

  // Shift by immediate patterns. Allowed immediate range is different for right
  // vs. left shifts, so the patterns have to be different.
  def : Pat<(nxv16i8 (shl (nxv16i8 ZPR:$Zs1),
                          (nxv16i8 (AArch64dup (vecshiftL8:$imm))))),
            (LSL_ZZI_B ZPR:$Zs1, vecshiftL8:$imm)>;
  def : Pat<(nxv8i16 (shl (nxv8i16 ZPR:$Zs1),
                          (nxv8i16 (AArch64dup (vecshiftL16:$imm))))),
            (LSL_ZZI_H ZPR:$Zs1, vecshiftL16:$imm)>;
  def : Pat<(nxv4i32 (shl (nxv4i32 ZPR:$Zs1),
                          (nxv4i32 (AArch64dup (vecshiftL32:$imm))))),
            (LSL_ZZI_S ZPR:$Zs1, vecshiftL32:$imm)>;
  def : Pat<(nxv2i64 (shl (nxv2i64 ZPR:$Zs1),
                          (nxv2i64 (AArch64dup (i64 (SVELShiftImm64 i32:$imm)))))),
            (LSL_ZZI_D ZPR:$Zs1, vecshiftL64:$imm)>;

  def : Pat<(nxv16i8 (int_aarch64_sve_lsl (nxv16i1 PPR_3b:$Pg),
                                          (nxv16i8 ZPR:$Zs1),
                                          (nxv16i8 (AArch64dup (vecshiftL8:$imm))))),
            (LSL_ZPmI_B PPR_3b:$Pg, ZPR:$Zs1, vecshiftL8:$imm)>;
  def : Pat<(nxv8i16 (int_aarch64_sve_lsl (nxv8i1 PPR_3b:$Pg),
                                          (nxv8i16 ZPR:$Zs1),
                                          (nxv8i16 (AArch64dup (vecshiftL16:$imm))))),
            (LSL_ZPmI_H PPR_3b:$Pg, ZPR:$Zs1, vecshiftL16:$imm)>;
  def : Pat<(nxv4i32 (int_aarch64_sve_lsl (nxv4i1 PPR_3b:$Pg),
                                          (nxv4i32 ZPR:$Zs1),
                                          (nxv4i32 (AArch64dup (vecshiftL32:$imm))))),
            (LSL_ZPmI_S PPR_3b:$Pg, ZPR:$Zs1, vecshiftL32:$imm)>;
  def : Pat<(nxv2i64 (int_aarch64_sve_lsl (nxv2i1 PPR_3b:$Pg),
                                          (nxv2i64 ZPR:$Zs1),
                                          (nxv2i64 (AArch64dup (i64 (SVELShiftImm64 i32:$imm)))))),
            (LSL_ZPmI_D PPR_3b:$Pg, ZPR:$Zs1, vecshiftL64:$imm)>;

  // Wide shifts
  def : Pat<(nxv16i8 (int_aarch64_sve_lsl_wide (nxv16i1 PPR_3b:$Pg),
                                               (nxv16i8 ZPR:$Zs1),
                                               (nxv2i64 (AArch64dup (i64 (SVEWideLShiftImm8 i32:$imm)))))),
            (LSL_ZPmI_B PPR_3b:$Pg, ZPR:$Zs1, vecshiftL8:$imm)>;
  def : Pat<(nxv8i16 (int_aarch64_sve_lsl_wide (nxv8i1 PPR_3b:$Pg),
                                               (nxv8i16 ZPR:$Zs1),
                                               (nxv2i64 (AArch64dup (i64 (SVEWideLShiftImm16 i32:$imm)))))),
            (LSL_ZPmI_H PPR_3b:$Pg, ZPR:$Zs1, vecshiftL16:$imm)>;
  def : Pat<(nxv4i32 (int_aarch64_sve_lsl_wide (nxv4i1 PPR_3b:$Pg),
                                               (nxv4i32 ZPR:$Zs1),
                                               (nxv2i64 (AArch64dup (i64 (SVEWideLShiftImm32 i32:$imm)))))),
            (LSL_ZPmI_S PPR_3b:$Pg, ZPR:$Zs1, vecshiftL32:$imm)>;

  multiclass sve_unpred_rshift_immediates<string ir_inst, string int_inst,
                                          SDPatternOperator ir_op,
                                          SDPatternOperator int_op,
                                          SDPatternOperator wide_op> {
    def : Pat<(nxv16i8 (ir_op (nxv16i8 ZPR:$Zs1),
                              (nxv16i8 (AArch64dup (vecshiftR8:$imm))))),
              (!cast<Instruction>(ir_inst # "_B") ZPR:$Zs1, vecshiftR8:$imm)>;
    def : Pat<(nxv8i16 (ir_op (nxv8i16 ZPR:$Zs1),
                              (nxv8i16 (AArch64dup (vecshiftR16:$imm))))),
              (!cast<Instruction>(ir_inst # "_H") ZPR:$Zs1, vecshiftR16:$imm)>;
    def : Pat<(nxv4i32 (ir_op (nxv4i32 ZPR:$Zs1),
                              (nxv4i32 (AArch64dup (vecshiftR32:$imm))))),
              (!cast<Instruction>(ir_inst # "_S") ZPR:$Zs1, vecshiftR32:$imm)>;
    def : Pat<(nxv2i64 (ir_op (nxv2i64 ZPR:$Zs1),
                              (nxv2i64 (AArch64dup (i64 (SVERShiftImm64 i32:$imm)))))),
              (!cast<Instruction>(ir_inst # "_D") ZPR:$Zs1, vecshiftR64:$imm)>;

    def : Pat<(nxv16i8 (int_op (nxv16i1 PPR_3b:$Pg),
                               (nxv16i8 ZPR:$Zs1),
                               (nxv16i8 (AArch64dup (vecshiftR8:$imm))))),
              (!cast<Instruction>(int_inst # "_B") PPR_3b:$Pg, ZPR:$Zs1, vecshiftR8:$imm)>;
    def : Pat<(nxv8i16 (int_op (nxv8i1 PPR_3b:$Pg),
                               (nxv8i16 ZPR:$Zs1),
                               (nxv8i16 (AArch64dup (vecshiftR16:$imm))))),
              (!cast<Instruction>(int_inst # "_H") PPR_3b:$Pg, ZPR:$Zs1, vecshiftR16:$imm)>;
    def : Pat<(nxv4i32 (int_op (nxv4i1 PPR_3b:$Pg),
                               (nxv4i32 ZPR:$Zs1),
                               (nxv4i32 (AArch64dup (vecshiftR32:$imm))))),
              (!cast<Instruction>(int_inst # "_S") PPR_3b:$Pg, ZPR:$Zs1, vecshiftR32:$imm)>;
    def : Pat<(nxv2i64 (int_op (nxv2i1 PPR_3b:$Pg),
                               (nxv2i64 ZPR:$Zs1),
                               (nxv2i64 (AArch64dup (i64 (SVERShiftImm64 i32:$imm)))))),
              (!cast<Instruction>(int_inst # "_D") PPR_3b:$Pg, ZPR:$Zs1, vecshiftR64:$imm)>;

    // Wide shifts
    def : Pat<(nxv16i8 (wide_op (nxv16i1 PPR_3b:$Pg),
                                (nxv16i8 ZPR:$Zs1),
                                (nxv2i64 (AArch64dup (i64 (SVEWideRShiftImm8 i32:$imm)))))),
              (!cast<Instruction>(int_inst # "_B") PPR_3b:$Pg, ZPR:$Zs1, vecshiftR8:$imm)>;
    def : Pat<(nxv8i16 (wide_op (nxv8i1 PPR_3b:$Pg),
                                (nxv8i16 ZPR:$Zs1),
                                (nxv2i64 (AArch64dup (i64 (SVEWideRShiftImm16 i32:$imm)))))),
              (!cast<Instruction>(int_inst # "_H") PPR_3b:$Pg, ZPR:$Zs1, vecshiftR16:$imm)>;
    def : Pat<(nxv4i32 (wide_op (nxv4i1 PPR_3b:$Pg),
                                (nxv4i32 ZPR:$Zs1),
                                (nxv2i64 (AArch64dup (i64 (SVEWideRShiftImm32 i32:$imm)))))),
              (!cast<Instruction>(int_inst # "_S") PPR_3b:$Pg, ZPR:$Zs1, vecshiftR32:$imm)>;
  }

  defm : sve_unpred_rshift_immediates<"ASR_ZZI", "ASR_ZPmI", sra, int_aarch64_sve_asr, int_aarch64_sve_asr_wide>;
  defm : sve_unpred_rshift_immediates<"LSR_ZZI", "LSR_ZPmI", srl, int_aarch64_sve_lsr, int_aarch64_sve_lsr_wide>;

  def : Pat<(nxv16i1 (trunc (nxv16i8 ZPR:$Zs))),
            (CMPNE_PPzZI_B (PTRUE_B 31), (LSL_ZZI_B ZPR:$Zs, 7), 0)>;
  def : Pat<(nxv8i1 (trunc (nxv8i16 ZPR:$Zs))),
            (CMPNE_PPzZI_H (PTRUE_H 31), (LSL_ZZI_H ZPR:$Zs, 15), 0)>;
  def : Pat<(nxv4i1 (trunc (nxv4i32 ZPR:$Zs))),
            (CMPNE_PPzZI_S (PTRUE_S 31), (LSL_ZZI_S ZPR:$Zs, 31), 0)>;
  def : Pat<(nxv2i1 (trunc (nxv2i64 ZPR:$Zs))),
            (CMPNE_PPzZI_D (PTRUE_D 31), (LSL_ZZI_D ZPR:$Zs, 63), 0)>;

  def : Pat<(nxv16i1 (and (trunc (nxv16i8 ZPR:$Zs1)), PPR:$Ps2)),
            (CMPNE_PPzZI_B PPR:$Ps2, (LSL_ZZI_B ZPR:$Zs1, 7), 0)>;
  def : Pat<(nxv8i1 (and (trunc (nxv8i16 ZPR:$Zs1)), PPR:$Ps2)),
            (CMPNE_PPzZI_H PPR:$Ps2, (LSL_ZZI_H ZPR:$Zs1, 15), 0)>;
  def : Pat<(nxv4i1 (and (trunc (nxv4i32 ZPR:$Zs1)), PPR:$Ps2)),
            (CMPNE_PPzZI_S PPR:$Ps2, (LSL_ZZI_S ZPR:$Zs1, 31), 0)>;
  def : Pat<(nxv2i1 (and (trunc (nxv2i64 ZPR:$Zs1)), PPR:$Ps2)),
            (CMPNE_PPzZI_D PPR:$Ps2, (LSL_ZZI_D ZPR:$Zs1, 63), 0)>;

  defm : SVEInvCmpPat<SETLE,  "CMPGE_PPzZZ">;
  defm : SVEInvCmpPat<SETLT,  "CMPGT_PPzZZ">;
  defm : SVEInvCmpPat<SETULT, "CMPHI_PPzZZ">;
  defm : SVEInvCmpPat<SETULE, "CMPHS_PPzZZ">;

  // per-element any extend
  def : Pat<(nxv16i8 (anyext (nxv16i1 PPR:$Ps1))),
            (CPY_ZPzI_B PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv8i16 (anyext (nxv8i1 PPR:$Ps1))),
            (CPY_ZPzI_H PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv4i32 (anyext (nxv4i1 PPR:$Ps1))),
            (CPY_ZPzI_S PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv2i64 (anyext (nxv2i1 PPR:$Ps1))),
            (CPY_ZPzI_D PPR:$Ps1, 0x1, 0)>;

  // per-element sign extend
  def : Pat<(nxv16i8 (sext (nxv16i1 PPR:$Ps1))),
            (CPY_ZPzI_B PPR:$Ps1, -1, 0)>;
  def : Pat<(nxv8i16 (sext (nxv8i1 PPR:$Ps1))),
            (CPY_ZPzI_H PPR:$Ps1, -1, 0)>;
  def : Pat<(nxv4i32 (sext (nxv4i1 PPR:$Ps1))),
            (CPY_ZPzI_S PPR:$Ps1, -1, 0)>;
  def : Pat<(nxv2i64 (sext (nxv2i1 PPR:$Ps1))),
            (CPY_ZPzI_D PPR:$Ps1, -1, 0)>;

  // per-element zero extend
  def : Pat<(nxv16i8 (zext (nxv16i1 PPR:$Ps1))),
            (CPY_ZPzI_B PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv8i16 (zext (nxv8i1 PPR:$Ps1))),
            (CPY_ZPzI_H PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv4i32 (zext (nxv4i1 PPR:$Ps1))),
            (CPY_ZPzI_S PPR:$Ps1, 0x1, 0)>;
  def : Pat<(nxv2i64 (zext (nxv2i1 PPR:$Ps1))),
            (CPY_ZPzI_D PPR:$Ps1, 0x1, 0)>;

  // propff patterns
  def : Pat<(nxv16i1 (prop_first_zero (nxv16i1 PPR:$src1), (nxv16i1 PPR:$src2))),
            (BRKPB_PPzPP (PTRUE_B 31),
                         (BRKB_PPzP (PTRUE_B 31), (NOR_PPzPP (PTRUE_B 31), PPR:$src1, PPR:$src1)),
                         (NOR_PPzPP (PTRUE_B 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv8i1 (prop_first_zero (nxv8i1 PPR:$src1), (nxv8i1 PPR:$src2))),
            (BRKPB_PPzPP (PTRUE_H 31),
                         (BRKB_PPzP (PTRUE_H 31), (NOR_PPzPP (PTRUE_H 31), PPR:$src1, PPR:$src1)),
                         (NOR_PPzPP (PTRUE_H 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv4i1 (prop_first_zero (nxv4i1 PPR:$src1), (nxv4i1 PPR:$src2))),
            (BRKPB_PPzPP (PTRUE_S 31),
                         (BRKB_PPzP (PTRUE_S 31), (NOR_PPzPP (PTRUE_S 31), PPR:$src1, PPR:$src1)),
                         (NOR_PPzPP (PTRUE_S 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv2i1 (prop_first_zero (nxv2i1 PPR:$src1), (nxv2i1 PPR:$src2))),
            (BRKPB_PPzPP (PTRUE_D 31),
                         (BRKB_PPzP (PTRUE_D 31), (NOR_PPzPP (PTRUE_D 31), PPR:$src1, PPR:$src1)),
                         (NOR_PPzPP (PTRUE_D 31), PPR:$src2, PPR:$src2))>;

  // optimized propff
  def : Pat<(nxv16i1 (prop_first_zero (nxv16i1 (AArch64ptrue 31)), (nxv16i1 PPR:$src2))),
            (BRKB_PPzP (PTRUE_B 31), (NOR_PPzPP (PTRUE_B 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv8i1 (prop_first_zero (nxv8i1 (AArch64ptrue 31)), (nxv8i1 PPR:$src2))),
            (BRKB_PPzP (PTRUE_H 31), (NOR_PPzPP (PTRUE_H 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv4i1 (prop_first_zero (nxv4i1 (AArch64ptrue 31)), (nxv4i1 PPR:$src2))),
            (BRKB_PPzP (PTRUE_S 31), (NOR_PPzPP (PTRUE_S 31), PPR:$src2, PPR:$src2))>;
  def : Pat<(nxv2i1 (prop_first_zero (nxv2i1 (AArch64ptrue 31)), (nxv2i1 PPR:$src2))),
            (BRKB_PPzP (PTRUE_D 31), (NOR_PPzPP (PTRUE_D 31), PPR:$src2, PPR:$src2))>;

  // brka
  def : Pat<(nxv16i1 (AArch64brka (nxv16i1 PPR:$Pg), (nxv16i1 PPR:$Src1))),
            (BRKA_PPzP $Pg, $Src1)>;
  def : Pat<(nxv8i1 (AArch64brka (nxv8i1 PPR:$Pg), (nxv8i1 PPR:$Src1))),
            (BRKA_PPzP $Pg, $Src1)>;
  def : Pat<(nxv4i1 (AArch64brka (nxv4i1 PPR:$Pg), (nxv4i1 PPR:$Src1))),
            (BRKA_PPzP $Pg, $Src1)>;
  def : Pat<(nxv2i1 (AArch64brka (nxv2i1 PPR:$Pg), (nxv2i1 PPR:$Src1))),
            (BRKA_PPzP $Pg, $Src1)>;

let AddedComplexity = 1 in {
  def : Pat<(nxv16i1 (prop_first_zero (nxv16i1 PPR:$src1),
                 (nxv16i1 (int_aarch64_sve_whilelo GPR32:$Rs1, GPR32:$Rs2)))),
            (BRKN_PPzP (PTRUE_B 31),
                        (BRKB_PPzP (PTRUE_B 31), (NOR_PPzPP (PTRUE_B 31), PPR:$src1, PPR:$src1)),
                        (WHILELO_PWW_B GPR32:$Rs1, GPR32:$Rs2))>;
  def : Pat<(nxv8i1  (prop_first_zero (nxv8i1 PPR:$src1),
                 (nxv8i1 (int_aarch64_sve_whilelo GPR32:$Rs1, GPR32:$Rs2)))),
            (BRKN_PPzP (PTRUE_H 31),
                       (BRKB_PPzP (PTRUE_H 31), (NOR_PPzPP (PTRUE_H 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PWW_H GPR32:$Rs1, GPR32:$Rs2))>;
  def : Pat<(nxv4i1  (prop_first_zero (nxv4i1 PPR:$src1),
                 (nxv4i1 (int_aarch64_sve_whilelo GPR32:$Rs1, GPR32:$Rs2)))),
            (BRKN_PPzP (PTRUE_S 31),
                       (BRKB_PPzP (PTRUE_S 31), (NOR_PPzPP (PTRUE_S 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PWW_S GPR32:$Rs1, GPR32:$Rs2))>;
  def : Pat<(nxv2i1  (prop_first_zero (nxv2i1 PPR:$src1),
                 (nxv2i1 (int_aarch64_sve_whilelo GPR32:$Rs1, GPR32:$Rs2)))),
            (BRKN_PPzP (PTRUE_D 31),
                       (BRKB_PPzP (PTRUE_D 31), (NOR_PPzPP (PTRUE_D 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PWW_D GPR32:$Rs1, GPR32:$Rs2))>;
  def : Pat<(nxv16i1 (prop_first_zero (nxv16i1 PPR:$src1),
                 (nxv16i1 (int_aarch64_sve_whilelo GPR64:$Rs1, GPR64:$Rs2)))),
            (BRKN_PPzP (PTRUE_B 31),
                       (BRKB_PPzP (PTRUE_B 31), (NOR_PPzPP (PTRUE_B 31), PPR:$src1, PPR:$src1)),
                        (WHILELO_PXX_B GPR64:$Rs1, GPR64:$Rs2))>;
  def : Pat<(nxv8i1  (prop_first_zero (nxv8i1 PPR:$src1),
                 (nxv8i1 (int_aarch64_sve_whilelo GPR64:$Rs1, GPR64:$Rs2)))),
            (BRKN_PPzP (PTRUE_H 31),
                       (BRKB_PPzP (PTRUE_H 31), (NOR_PPzPP (PTRUE_H 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PXX_H GPR64:$Rs1, GPR64:$Rs2))>;
  def : Pat<(nxv4i1  (prop_first_zero (nxv4i1 PPR:$src1),
                 (nxv4i1 (int_aarch64_sve_whilelo GPR64:$Rs1, GPR64:$Rs2)))),
            (BRKN_PPzP (PTRUE_S 31),
                       (BRKB_PPzP (PTRUE_S 31), (NOR_PPzPP (PTRUE_S 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PXX_S GPR64:$Rs1, GPR64:$Rs2))>;
  def : Pat<(nxv2i1  (prop_first_zero (nxv2i1 PPR:$src1),
                 (nxv2i1 (int_aarch64_sve_whilelo GPR64:$Rs1, GPR64:$Rs2)))),
            (BRKN_PPzP (PTRUE_D 31),
                       (BRKB_PPzP (PTRUE_D 31), (NOR_PPzPP(PTRUE_D 31), PPR:$src1, PPR:$src1)),
                       (WHILELO_PXX_D GPR64:$Rs1, GPR64:$Rs2))>;
}

  def : Pat<(nxv16i8 (scalar_to_vector (i32 FPR32:$src))),
            (INSERT_SUBREG (nxv16i8 (IMPLICIT_DEF)), FPR32:$src, ssub)>;

  def : Pat<(nxv8i16 (scalar_to_vector (i32 FPR32:$src))),
            (INSERT_SUBREG (nxv8i16 (IMPLICIT_DEF)), FPR32:$src, ssub)>;

  def : Pat<(nxv4i32 (scalar_to_vector (i32 FPR32:$src))),
            (INSERT_SUBREG (nxv4i32 (IMPLICIT_DEF)), FPR32:$src, ssub)>;

  def : Pat<(nxv2i64 (scalar_to_vector (i64 FPR64:$src))),
            (INSERT_SUBREG (nxv2i64 (IMPLICIT_DEF)), FPR64:$src, dsub)>;

  def : Pat<(nxv4f32 (scalar_to_vector (f32 FPR32:$src))),
            (INSERT_SUBREG (nxv4f32 (IMPLICIT_DEF)), FPR32:$src, ssub)>;

  def : Pat<(nxv2f64 (scalar_to_vector (f64 FPR64:$src))),
            (INSERT_SUBREG (nxv2f64 (IMPLICIT_DEF)), FPR64:$src, dsub)>;

  def : Pat<(nxv2f32 (scalar_to_vector (f32 FPR32:$src))),
            (INSERT_SUBREG (nxv2f32 (IMPLICIT_DEF)), FPR32:$src, ssub)>;

  def : Pat<(nxv16i1 (scalar_to_vector GPR32:$src)),
            (CMPNE_PPzZI_B (PTRUE_B 31), (LSL_ZZI_B (DUP_ZR_B $src), 7), 0)>;

  def : Pat<(nxv8i1 (scalar_to_vector GPR32:$src)),
            (CMPNE_PPzZI_H (PTRUE_H 31), (LSL_ZZI_H (DUP_ZR_H $src), 15), 0)>;

  def : Pat<(nxv4i1 (scalar_to_vector GPR32:$src)),
            (CMPNE_PPzZI_S (PTRUE_S 31), (LSL_ZZI_S (DUP_ZR_S $src), 31), 0)>;

  def : Pat<(nxv2i1 (scalar_to_vector GPR32:$src)),
            (CMPNE_PPzZI_D (PTRUE_D 31), (LSL_ZZI_S (DUP_ZR_S $src), 31), 0)>;

  // Insert scalar into vector[0]
  def : Pat<(nxv16i8 (vector_insert (nxv16i8 (undef)), (i32 FPR32:$src), 0)),
            (INSERT_SUBREG (nxv16i8 (IMPLICIT_DEF)), FPR32:$src, ssub)>;
  def : Pat<(nxv8i16 (vector_insert (nxv8i16 (undef)), (i32 FPR32:$src), 0)),
            (INSERT_SUBREG (nxv8i16 (IMPLICIT_DEF)), FPR32:$src, ssub)>;
  def : Pat<(nxv4i32 (vector_insert (nxv4i32 (undef)), (i32 FPR32:$src), 0)),
            (INSERT_SUBREG (nxv4i32 (IMPLICIT_DEF)), FPR32:$src, ssub)>;
  def : Pat<(nxv2i64 (vector_insert (nxv2i64 (undef)), (i64 FPR64:$src), 0)),
            (INSERT_SUBREG (nxv2i64 (IMPLICIT_DEF)), FPR64:$src, dsub)>;

  def : Pat<(nxv16i8 (vector_insert (nxv16i8 ZPR:$vec), (i32 GPR32:$src), 0)),
            (CPY_ZPmR_B ZPR:$vec, (PTRUE_B 1), GPR32:$src)>;
  def : Pat<(nxv8i16 (vector_insert (nxv8i16 ZPR:$vec), (i32 GPR32:$src), 0)),
            (CPY_ZPmR_H ZPR:$vec, (PTRUE_H 1), GPR32:$src)>;
  def : Pat<(nxv4i32 (vector_insert (nxv4i32 ZPR:$vec), (i32 GPR32:$src), 0)),
            (CPY_ZPmR_S ZPR:$vec, (PTRUE_S 1), GPR32:$src)>;
  def : Pat<(nxv2i64 (vector_insert (nxv2i64 ZPR:$vec), (i64 GPR64:$src), 0)),
            (CPY_ZPmR_D ZPR:$vec, (PTRUE_D 1), GPR64:$src)>;

  def : Pat<(nxv4f32 (vector_insert (nxv4f32 ZPR:$vec), (f32 FPR32:$src), 0)),
            (SEL_ZPZZ_S (PTRUE_S 1), (INSERT_SUBREG (IMPLICIT_DEF), FPR32:$src, ssub), ZPR:$vec)>;
  def : Pat<(nxv2f64 (vector_insert (nxv2f64 ZPR:$vec), (f64 FPR64:$src), 0)),
            (SEL_ZPZZ_D (PTRUE_D 1), (INSERT_SUBREG (IMPLICIT_DEF), FPR64:$src, dsub), ZPR:$vec)>;

  // Insert scalar into vector with scalar index
  def : Pat<(nxv16i8 (vector_insert (nxv16i8 ZPR:$vec), GPR32:$src, GPR64:$index)),
            (CPY_ZPmR_B ZPR:$vec,
                        (CMPEQ_PPzZZ_B (PTRUE_B 31),
                                       (INDEX_II_B 0, 1),
                                       (DUP_ZR_B (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                        GPR32:$src)>;
  def : Pat<(nxv8i16 (vector_insert (nxv8i16 ZPR:$vec), GPR32:$src, GPR64:$index)),
            (CPY_ZPmR_H ZPR:$vec,
                        (CMPEQ_PPzZZ_H (PTRUE_H 31),
                                       (INDEX_II_H 0, 1),
                                       (DUP_ZR_H (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                        GPR32:$src)>;
  def : Pat<(nxv4i32 (vector_insert (nxv4i32 ZPR:$vec), GPR32:$src, GPR64:$index)),
            (CPY_ZPmR_S ZPR:$vec,
                        (CMPEQ_PPzZZ_S (PTRUE_S 31),
                                       (INDEX_II_S 0, 1),
                                       (DUP_ZR_S (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                        GPR32:$src)>;
  def : Pat<(nxv2i64 (vector_insert (nxv2i64 ZPR:$vec), GPR64:$src, GPR64:$index)),
            (CPY_ZPmR_D ZPR:$vec,
                        (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                       (INDEX_II_D 0, 1),
                                       (DUP_ZR_D GPR64:$index)),
                        GPR64:$src)>;

  // Insert FP scalar into vector with scalar index
  def : Pat<(nxv4f32 (vector_insert (nxv4f32 ZPR:$vec), (f32 FPR32:$src), GPR64:$index)),
            (CPY_ZPmV_S ZPR:$vec,
                        (CMPEQ_PPzZZ_S (PTRUE_S 31),
                                       (INDEX_II_S 0, 1),
                                       (DUP_ZR_S (i32 (EXTRACT_SUBREG GPR64:$index, sub_32)))),
                        $src)>;
  def : Pat<(nxv2f64 (vector_insert (nxv2f64 ZPR:$vec), (f64 FPR64:$src), GPR64:$index)),
            (CPY_ZPmV_D ZPR:$vec,
                        (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                       (INDEX_II_D 0, 1),
                                       (DUP_ZR_D $index)),
                        $src)>;
  def : Pat<(nxv2f32 (vector_insert (nxv2f32 ZPR:$vec), (f32 FPR32:$src), GPR64:$index)),
            (CPY_ZPmV_S ZPR:$vec,
                        (CMPEQ_PPzZZ_D (PTRUE_D 31),
                                       (INDEX_II_D 0, 1),
                                       (DUP_ZR_D $index)),
                        $src)>;

  // Duplicate FP scalar into all vector elements
  def : Pat<(nxv8f16 (AArch64dup (f16 FPR16:$src))), (DUP_ZV_H $src)>;
  def : Pat<(nxv4f32 (AArch64dup (f32 FPR32:$src))), (DUP_ZV_S $src)>;
  def : Pat<(nxv2f32 (AArch64dup (f32 FPR32:$src))), (DUP_ZV_S $src)>;
  def : Pat<(nxv2f64 (AArch64dup (f64 FPR64:$src))), (DUP_ZV_D $src)>;

  // Duplicate +0.0 into all vector elements
  def : Pat<(nxv8f16 (AArch64dup (f16 fpimm0))), (DUP_ZI_H 0, 0)>;
  def : Pat<(nxv4f32 (AArch64dup (f32 fpimm0))), (DUP_ZI_S 0, 0)>;
  def : Pat<(nxv2f32 (AArch64dup (f32 fpimm0))), (DUP_ZI_S 0, 0)>;
  def : Pat<(nxv2f64 (AArch64dup (f64 fpimm0))), (DUP_ZI_D 0, 0)>;

  // Duplicate immediate in all vector elements
  def : Pat<(nxv16i8 (AArch64dup (i32 (SVE8BitLslImm i32:$a, i32:$b)))),
            (DUP_ZI_B $a, $b)>;
  def : Pat<(nxv8i16 (AArch64dup (i32 (SVE8BitLslImm i32:$a, i32:$b)))),
            (DUP_ZI_H $a, $b)>;
  def : Pat<(nxv4i32 (AArch64dup (i32 (SVE8BitLslImm i32:$a, i32:$b)))),
            (DUP_ZI_S $a, $b)>;
  def : Pat<(nxv2i64 (AArch64dup (i64 (SVE8BitLslImm i64:$a, i64:$b)))),
            (DUP_ZI_D $a, $b)>;

  // Duplicate GPR in all vector elements
  def : Pat<(nxv16i8 (AArch64dup GPR32:$a)), (DUP_ZR_B $a)>;
  def : Pat<(nxv8i16 (AArch64dup GPR32:$a)), (DUP_ZR_H $a)>;
  def : Pat<(nxv4i32 (AArch64dup GPR32:$a)), (DUP_ZR_S $a)>;
  def : Pat<(nxv2i64 (AArch64dup GPR64:$a)), (DUP_ZR_D $a)>;

  // Dup of fp immediate pattern.
  let AddedComplexity = 2 in {
    def : Pat<(nxv8f16 (AArch64dup sve_fpimm16:$imm8)),
              (FDUP_ZI_H sve_fpimm16:$imm8)>;
    def : Pat<(nxv4f32 (AArch64dup sve_fpimm32:$imm8)),
              (FDUP_ZI_S sve_fpimm32:$imm8)>;
    def : Pat<(nxv2f32 (AArch64dup sve_fpimm32:$imm8)),
              (FDUP_ZI_S sve_fpimm32:$imm8)>;
    def : Pat<(nxv2f64 (AArch64dup sve_fpimm64:$imm8)),
              (FDUP_ZI_D sve_fpimm64:$imm8)>;
  }

  /// Compact single bit fp immediates
  multiclass intrinsic_compact_fp_immediates<string I, string IZ, string IX,
                    PatLeaf A, PatLeaf B,
                    SDPatternOperator op, SDPatternOperator ir_op = null_frag> {
    def : Pat<(nxv8f16 (op (nxv8i1 PPR_3b:$Pg),
                           (nxv8f16 ZPR:$Zs1),
                           (nxv8f16 (AArch64dup (f16 A))))),
              (!cast<Instruction>(I # "_H") PPR_3b:$Pg, ZPR:$Zs1, 0)>;
    def : Pat<(nxv8f16 (op (nxv8i1 PPR_3b:$Pg),
                           (nxv8f16 ZPR:$Zs1),
                           (nxv8f16 (AArch64dup (f16 B))))),
              (!cast<Instruction>(I # "_H") PPR_3b:$Pg, ZPR:$Zs1, 1)>;
    def : Pat<(nxv4f32 (op (nxv4i1 PPR_3b:$Pg),
                           (nxv4f32 ZPR:$Zs1),
                           (nxv4f32 (AArch64dup (f32 A))))),
              (!cast<Instruction>(I # "_S") PPR_3b:$Pg, ZPR:$Zs1, 0)>;
    def : Pat<(nxv4f32 (op (nxv4i1 PPR_3b:$Pg),
                           (nxv4f32 ZPR:$Zs1),
                           (nxv4f32 (AArch64dup (f32 B))))),
              (!cast<Instruction>(I # "_S") PPR_3b:$Pg, ZPR:$Zs1, 1)>;
    def : Pat<(nxv2f64 (op (nxv2i1 PPR_3b:$Pg),
                           (nxv2f64 ZPR:$Zs1),
                           (nxv2f64 (AArch64dup (f64 A))))),
              (!cast<Instruction>(I # "_D") PPR_3b:$Pg, ZPR:$Zs1, 0)>;
    def : Pat<(nxv2f64 (op (nxv2i1 PPR_3b:$Pg),
                           (nxv2f64 ZPR:$Zs1),
                           (nxv2f64 (AArch64dup (f64 B))))),
              (!cast<Instruction>(I # "_D") PPR_3b:$Pg, ZPR:$Zs1, 1)>;

    def : Pat<(nxv8f16 (ir_op (nxv8f16 ZPR:$Zs1),
                              (nxv8f16 (AArch64dup (f16 A))))),
              (!cast<Instruction>(IX # "_H") (PTRUE_H 31), ZPR:$Zs1, 0)>;
    def : Pat<(nxv8f16 (ir_op (nxv8f16 ZPR:$Zs1),
                              (nxv8f16 (AArch64dup (f16 B))))),
              (!cast<Instruction>(IX # "_H") (PTRUE_H 31), ZPR:$Zs1, 1)>;
    def : Pat<(nxv4f32 (ir_op (nxv4f32 ZPR:$Zs1),
                              (nxv4f32 (AArch64dup (f32 A))))),
              (!cast<Instruction>(IX # "_S") (PTRUE_S 31), ZPR:$Zs1, 0)>;
    def : Pat<(nxv4f32 (ir_op (nxv4f32 ZPR:$Zs1),
                              (nxv4f32 (AArch64dup (f32 B))))),
              (!cast<Instruction>(IX # "_S") (PTRUE_S 31), ZPR:$Zs1, 1)>;
    def : Pat<(nxv2f64 (ir_op (nxv2f64 ZPR:$Zs1),
                              (nxv2f64 (AArch64dup (f64 A))))),
              (!cast<Instruction>(IX # "_D") (PTRUE_D 31), ZPR:$Zs1, 0)>;
    def : Pat<(nxv2f64 (ir_op (nxv2f64 ZPR:$Zs1),
                              (nxv2f64 (AArch64dup (f64 B))))),
              (!cast<Instruction>(IX # "_D") (PTRUE_D 31), ZPR:$Zs1, 1)>;

    let AddedComplexity = 2 in {
    // When Intrinsic combined with SELECT
    def : Pat<(nxv8f16 (op nxv8i1:$Pg,
                           (vselect nxv8i1:$Pg, nxv8f16:$Zs1, (SVEDup0)),
                           (nxv8f16 (AArch64dup (f16 A))))),
              (!cast<Instruction>(IZ # "_H") $Pg, $Zs1, 0)>;
    def : Pat<(nxv8f16 (op nxv8i1:$Pg,
                           (vselect nxv8i1:$Pg, nxv8f16:$Zs1, (SVEDup0)),
                           (nxv8f16 (AArch64dup (f16 B))))),
              (!cast<Instruction>(IZ # "_H") $Pg, $Zs1, 1)>;
    def : Pat<(nxv4f32 (op nxv4i1:$Pg,
                           (vselect nxv4i1:$Pg, nxv4f32:$Zs1, (SVEDup0)),
                           (nxv4f32 (AArch64dup (f32 A))))),
              (!cast<Instruction>(IZ # "_S") $Pg, $Zs1, 0)>;
    def : Pat<(nxv4f32 (op nxv4i1:$Pg,
                           (vselect nxv4i1:$Pg, nxv4f32:$Zs1, (SVEDup0)),
                           (nxv4f32 (AArch64dup (f32 B))))),
              (!cast<Instruction>(IZ # "_S") $Pg, $Zs1, 1)>;
    def : Pat<(nxv2f64 (op nxv2i1:$Pg,
                           (vselect nxv2i1:$Pg, nxv2f64:$Zs1, (SVEDup0)),
                           (nxv2f64 (AArch64dup (f64 A))))),
              (!cast<Instruction>(IZ # "_D") $Pg, $Zs1, 0)>;
    def : Pat<(nxv2f64 (op nxv2i1:$Pg,
                           (vselect nxv2i1:$Pg, nxv2f64:$Zs1, (SVEDup0)),
                           (nxv2f64 (AArch64dup (f64 B))))),
              (!cast<Instruction>(IZ # "_D") $Pg, $Zs1, 1)>;
    }
  }

  defm : intrinsic_compact_fp_immediates<"FADD_ZPmI",  "FADD_ZPZI_ZERO",  "FADD_ZPZI_UNDEF",   fpimm_half, fpimm_one, int_aarch64_sve_add, fadd>;
  defm : intrinsic_compact_fp_immediates<"FSUB_ZPmI",  "FSUB_ZPZI_ZERO",  "FSUB_ZPZI_UNDEF",   fpimm_half, fpimm_one, int_aarch64_sve_sub, fsub>;
  defm : intrinsic_compact_fp_immediates<"FSUBR_ZPmI", "FSUBR_ZPZI_ZERO", "FSUBR_ZPZI_UNDEF",  fpimm_half, fpimm_one, int_aarch64_sve_subr>;
  defm : intrinsic_compact_fp_immediates<"FMUL_ZPmI",  "FMUL_ZPZI_ZERO",  "FMUL_ZPZI_UNDEF",   fpimm_half, fpimm_two, int_aarch64_sve_mul, fmul>;
  defm : intrinsic_compact_fp_immediates<"FMAX_ZPmI",  "FMAX_ZPZI_ZERO",  "FMAX_ZPZI_UNDEF",   fpimm0, fpimm_one, AArch64fmax_pred>;
  defm : intrinsic_compact_fp_immediates<"FMIN_ZPmI",  "FMIN_ZPZI_ZERO",  "FMIN_ZPZI_UNDEF",   fpimm0, fpimm_one, AArch64fmin_pred>;
  defm : intrinsic_compact_fp_immediates<"FMAXNM_ZPmI","FMAXNM_ZPZI_ZERO","FMAXNM_ZPZI_UNDEF", fpimm0, fpimm_one, AArch64fmaxnm_pred>;
  defm : intrinsic_compact_fp_immediates<"FMINNM_ZPmI","FMINNM_ZPZI_ZERO","FMINNM_ZPZI_UNDEF", fpimm0, fpimm_one, AArch64fminnm_pred>;

  foreach type = ["nxv16i1", "nxv8i1", "nxv4i1", "nxv2i1"] in {
    def : Pat< (!cast<ValueType>(type)
                         (load (am_sve_pred GPR64sp:$base, simm9:$offset))),
                (LDR_PXI GPR64sp:$base, simm9:$offset)>;
    def : Pat<(store (!cast<ValueType>(type) PPR:$val),
                         (am_sve_pred GPR64sp:$base, simm9:$offset)),
               (STR_PXI PPR:$val, GPR64sp:$base, simm9:$offset)>;
  }

  def : Pat<(nxv2f32 (fpextend (nxv2f16 ZPR:$Zs))),
            (FCVT_ZPmZ_HtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv4f32 (fpextend (nxv4f16 ZPR:$Zs))),
            (FCVT_ZPmZ_HtoS (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (fpextend (nxv2f16 ZPR:$Zs))),
            (FCVT_ZPmZ_HtoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (fpextend (nxv2f32 ZPR:$Zs))),
            (FCVT_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(nxv2f16 (fpround  (nxv2f32 ZPR:$Zs))),
            (FCVT_ZPmZ_StoH (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv4f16 (fpround  (nxv4f32 ZPR:$Zs))),
            (FCVT_ZPmZ_StoH (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2f16 (fpround  (nxv2f64 ZPR:$Zs))),
            (FCVT_ZPmZ_DtoH (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f32 (fpround  (nxv2f64 ZPR:$Zs))),
            (FCVT_ZPmZ_DtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(nxv4i32 (fp_to_sint (nxv4f32 ZPR:$Zs))),
            (FCVTZS_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_sint (nxv2f32 ZPR:$Zs))),
            (FCVTZS_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_sint (nxv2f64 ZPR:$Zs))),
            (FCVTZS_ZPmZ_DtoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_sint_inreg (nxv2f32 ZPR:$Zs), nxv2i32)),
            (FCVTZS_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_sint_inreg (nxv2f64 ZPR:$Zs), nxv2i32)),
            (FCVTZS_ZPmZ_DtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(nxv4i32 (fp_to_uint (nxv4f32 ZPR:$Zs))),
            (FCVTZU_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_uint (nxv2f32 ZPR:$Zs))),
            (FCVTZU_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_uint (nxv2f64 ZPR:$Zs))),
            (FCVTZU_ZPmZ_DtoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_uint_inreg (nxv2f32 ZPR:$Zs), nxv2i32)),
            (FCVTZU_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2i64 (fp_to_uint_inreg (nxv2f64 ZPR:$Zs), nxv2i32)),
            (FCVTZU_ZPmZ_DtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(nxv2f32 (sint_to_fp (sext_inreg (nxv2i64 ZPR:$Zs), nxv2i32))),
            (SCVTF_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f32 (sint_to_fp (nxv2i64 ZPR:$Zs))),
            (SCVTF_ZPmZ_DtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv4f32 (sint_to_fp (nxv4i32 ZPR:$Zs))),
            (SCVTF_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (sint_to_fp (sext_inreg (nxv2i64 ZPR:$Zs), nxv2i32))),
            (SCVTF_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (sint_to_fp (nxv2i64 ZPR:$Zs))),
            (SCVTF_ZPmZ_DtoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(nxv2f32 (uint_to_fp (and (nxv2i64 ZPR:$Zs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))))),
            (UCVTF_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f32 (uint_to_fp (nxv2i64 ZPR:$Zs))),
            (UCVTF_ZPmZ_DtoS (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv4f32 (uint_to_fp (nxv4i32 ZPR:$Zs))),
            (UCVTF_ZPmZ_StoS (IMPLICIT_DEF), (PTRUE_S 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (uint_to_fp (and (nxv2i64 ZPR:$Zs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))))),
            (UCVTF_ZPmZ_StoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;
  def : Pat<(nxv2f64 (uint_to_fp (nxv2i64 ZPR:$Zs))),
            (UCVTF_ZPmZ_DtoD (IMPLICIT_DEF), (PTRUE_D 31), ZPR:$Zs)>;

  def : Pat<(AArch64ptest (nxv16i1 PPR:$pg), (nxv16i1 PPR:$src)),
            (PTEST_PP PPR:$pg, PPR:$src)>;
  def : Pat<(AArch64ptest (nxv8i1 PPR:$pg), (nxv8i1 PPR:$src)),
            (PTEST_PP PPR:$pg, PPR:$src)>;
  def : Pat<(AArch64ptest (nxv4i1 PPR:$pg), (nxv4i1 PPR:$src)),
            (PTEST_PP PPR:$pg, PPR:$src)>;
  def : Pat<(AArch64ptest (nxv2i1 PPR:$pg), (nxv2i1 PPR:$src)),
            (PTEST_PP PPR:$pg, PPR:$src)>;

  def : Pat<(AArch64not (nxv16i1 PPR:$src)),
            (NOR_PPzPP (PTRUE_B 31), PPR:$src, PPR:$src)>;
  def : Pat<(AArch64not (nxv8i1 PPR:$src)),
            (NOR_PPzPP (PTRUE_H 31), PPR:$src, PPR:$src)>;
  def : Pat<(AArch64not (nxv4i1 PPR:$src)),
            (NOR_PPzPP (PTRUE_S 31), PPR:$src, PPR:$src)>;
  def : Pat<(AArch64not (nxv2i1 PPR:$src)),
            (NOR_PPzPP (PTRUE_D 31), PPR:$src, PPR:$src)>;

  def : Pat<(nxv16i8 (bitconvert (nxv8i16 ZPR:$src))), (nxv16i8 ZPR:$src)>;
  def : Pat<(nxv16i8 (bitconvert (nxv4i32 ZPR:$src))), (nxv16i8 ZPR:$src)>;
  def : Pat<(nxv16i8 (bitconvert (nxv2i64 ZPR:$src))), (nxv16i8 ZPR:$src)>;
  def : Pat<(nxv16i8 (bitconvert (nxv8f16 ZPR:$src))), (nxv16i8 ZPR:$src)>;
  def : Pat<(nxv16i8 (bitconvert (nxv4f32 ZPR:$src))), (nxv16i8 ZPR:$src)>;
  def : Pat<(nxv16i8 (bitconvert (nxv2f64 ZPR:$src))), (nxv16i8 ZPR:$src)>;

  def : Pat<(nxv8i16 (bitconvert (nxv16i8 ZPR:$src))), (nxv8i16 ZPR:$src)>;
  def : Pat<(nxv8i16 (bitconvert (nxv4i32 ZPR:$src))), (nxv8i16 ZPR:$src)>;
  def : Pat<(nxv8i16 (bitconvert (nxv2i64 ZPR:$src))), (nxv8i16 ZPR:$src)>;
  def : Pat<(nxv8i16 (bitconvert (nxv8f16 ZPR:$src))), (nxv8i16 ZPR:$src)>;
  def : Pat<(nxv8i16 (bitconvert (nxv4f32 ZPR:$src))), (nxv8i16 ZPR:$src)>;
  def : Pat<(nxv8i16 (bitconvert (nxv2f64 ZPR:$src))), (nxv8i16 ZPR:$src)>;

  def : Pat<(nxv4i32 (bitconvert (nxv16i8 ZPR:$src))), (nxv4i32 ZPR:$src)>;
  def : Pat<(nxv4i32 (bitconvert (nxv8i16 ZPR:$src))), (nxv4i32 ZPR:$src)>;
  def : Pat<(nxv4i32 (bitconvert (nxv2i64 ZPR:$src))), (nxv4i32 ZPR:$src)>;
  def : Pat<(nxv4i32 (bitconvert (nxv8f16 ZPR:$src))), (nxv4i32 ZPR:$src)>;
  def : Pat<(nxv4i32 (bitconvert (nxv4f32 ZPR:$src))), (nxv4i32 ZPR:$src)>;
  def : Pat<(nxv4i32 (bitconvert (nxv2f64 ZPR:$src))), (nxv4i32 ZPR:$src)>;

  def : Pat<(nxv2i64 (bitconvert (nxv16i8 ZPR:$src))), (nxv2i64 ZPR:$src)>;
  def : Pat<(nxv2i64 (bitconvert (nxv8i16 ZPR:$src))), (nxv2i64 ZPR:$src)>;
  def : Pat<(nxv2i64 (bitconvert (nxv4i32 ZPR:$src))), (nxv2i64 ZPR:$src)>;
  def : Pat<(nxv2i64 (bitconvert (nxv8f16 ZPR:$src))), (nxv2i64 ZPR:$src)>;
  def : Pat<(nxv2i64 (bitconvert (nxv4f32 ZPR:$src))), (nxv2i64 ZPR:$src)>;
  def : Pat<(nxv2i64 (bitconvert (nxv2f64 ZPR:$src))), (nxv2i64 ZPR:$src)>;

  def : Pat<(nxv8f16 (bitconvert (nxv16i8 ZPR:$src))), (nxv8f16 ZPR:$src)>;
  def : Pat<(nxv8f16 (bitconvert (nxv8i16 ZPR:$src))), (nxv8f16 ZPR:$src)>;
  def : Pat<(nxv8f16 (bitconvert (nxv4i32 ZPR:$src))), (nxv8f16 ZPR:$src)>;
  def : Pat<(nxv8f16 (bitconvert (nxv2i64 ZPR:$src))), (nxv8f16 ZPR:$src)>;
  def : Pat<(nxv8f16 (bitconvert (nxv4f32 ZPR:$src))), (nxv8f16 ZPR:$src)>;
  def : Pat<(nxv8f16 (bitconvert (nxv2f64 ZPR:$src))), (nxv8f16 ZPR:$src)>;

  def : Pat<(nxv4f32 (bitconvert (nxv16i8 ZPR:$src))), (nxv4f32 ZPR:$src)>;
  def : Pat<(nxv4f32 (bitconvert (nxv8i16 ZPR:$src))), (nxv4f32 ZPR:$src)>;
  def : Pat<(nxv4f32 (bitconvert (nxv4i32 ZPR:$src))), (nxv4f32 ZPR:$src)>;
  def : Pat<(nxv4f32 (bitconvert (nxv2i64 ZPR:$src))), (nxv4f32 ZPR:$src)>;
  def : Pat<(nxv4f32 (bitconvert (nxv8f16 ZPR:$src))), (nxv4f32 ZPR:$src)>;
  def : Pat<(nxv4f32 (bitconvert (nxv2f64 ZPR:$src))), (nxv4f32 ZPR:$src)>;

  def : Pat<(nxv2f64 (bitconvert (nxv16i8 ZPR:$src))), (nxv2f64 ZPR:$src)>;
  def : Pat<(nxv2f64 (bitconvert (nxv8i16 ZPR:$src))), (nxv2f64 ZPR:$src)>;
  def : Pat<(nxv2f64 (bitconvert (nxv4i32 ZPR:$src))), (nxv2f64 ZPR:$src)>;
  def : Pat<(nxv2f64 (bitconvert (nxv2i64 ZPR:$src))), (nxv2f64 ZPR:$src)>;
  def : Pat<(nxv2f64 (bitconvert (nxv8f16 ZPR:$src))), (nxv2f64 ZPR:$src)>;
  def : Pat<(nxv2f64 (bitconvert (nxv4f32 ZPR:$src))), (nxv2f64 ZPR:$src)>;

  // These are effectively bitconvert for predicates but due to the differently
  // sized input/ouput ValueTypes we cannot simply return $src.
  def : Pat<(nxv16i1 (reinterpret_cast (nxv8i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv16i1 (reinterpret_cast (nxv4i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv16i1 (reinterpret_cast (nxv2i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv8i1 (reinterpret_cast (nxv16i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv8i1 (reinterpret_cast  (nxv4i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv8i1 (reinterpret_cast  (nxv2i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv4i1 (reinterpret_cast (nxv16i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv4i1 (reinterpret_cast  (nxv8i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv4i1 (reinterpret_cast  (nxv2i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv2i1 (reinterpret_cast (nxv16i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv2i1 (reinterpret_cast  (nxv8i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;
  def : Pat<(nxv2i1 (reinterpret_cast  (nxv4i1 PPR:$src))), (COPY_TO_REGCLASS PPR:$src, PPR)>;

  // These allow bitcasts between unpacked_fp and packed_int datatypes.
  def : Pat<(nxv2f16 (reinterpret_cast (nxv2i64 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;
  def : Pat<(nxv2i64 (reinterpret_cast (nxv2f16 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;
  def : Pat<(nxv4f16 (reinterpret_cast (nxv4i32 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;
  def : Pat<(nxv4i32 (reinterpret_cast (nxv4f16 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;
  def : Pat<(nxv2f32 (reinterpret_cast (nxv2i64 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;
  def : Pat<(nxv2i64 (reinterpret_cast (nxv2f32 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;

  // These allow bitcasts between unpacked_fp datatypes.
  def : Pat<(nxv2f16 (reinterpret_cast (nxv4f16 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;
  def : Pat<(nxv4f16 (reinterpret_cast (nxv2f16 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;
  def : Pat<(nxv4f16 (reinterpret_cast (nxv8f16 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;
  def : Pat<(nxv8f16 (reinterpret_cast (nxv4f16 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;
  def : Pat<(nxv2f32 (reinterpret_cast (nxv4f32 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;
  def : Pat<(nxv4f32 (reinterpret_cast (nxv2f32 ZPR:$src))), (COPY_TO_REGCLASS ZPR:$src, ZPR)>;

  multiclass unpred_load<ValueType Ty, SDPatternOperator Load,
                         Instruction RegRegInst, Instruction RegImmInst,
                         ComplexPattern AddrCP, Instruction PTrue> {
    // reg + reg
    let AddedComplexity = 1 in {
      def _reg_reg : Pat<(Ty (Load  (AddrCP GPR64sp:$base, GPR64:$offset))),
                         (RegRegInst (PTrue 31), GPR64sp:$base, GPR64:$offset)>;
    }
    // reg + imm
    let AddedComplexity = 2 in {
      def _reg_imm : Pat<(Ty (Load  (am_sve_indexed_s4 GPR64sp:$base, simm4:$offset))),
                         (RegImmInst (PTrue 31), GPR64sp:$base, simm4:$offset)>;
    }
    // default fallback
    def _default : Pat<(Ty (Load  GPR64sp:$base)),
                       (RegImmInst (PTrue 31), GPR64sp:$base, (i64 0))>;
  }

  defm : unpred_load<nxv16i8, load, LD1B, LD1B_IMM, SVEAddrModeRegReg8,  PTRUE_B>;
  defm : unpred_load<nxv8i16, load, LD1H, LD1H_IMM, SVEAddrModeRegReg16, PTRUE_H>;
  defm : unpred_load<nxv4i32, load, LD1W, LD1W_IMM, SVEAddrModeRegReg32, PTRUE_S>;
  defm : unpred_load<nxv2i64, load, LD1D, LD1D_IMM, SVEAddrModeRegReg64, PTRUE_D>;
  defm : unpred_load<nxv8f16, load, LD1H, LD1H_IMM, SVEAddrModeRegReg16, PTRUE_H>;
  defm : unpred_load<nxv4f32, load, LD1W, LD1W_IMM, SVEAddrModeRegReg32, PTRUE_S>;
  defm : unpred_load<nxv2f64, load, LD1D, LD1D_IMM, SVEAddrModeRegReg64, PTRUE_D>;

  defm : unpred_load<nxv8i16, sextloadvi8,  LD1SB_H, LD1SB_H_IMM, SVEAddrModeRegReg8, PTRUE_H>;
  defm : unpred_load<nxv4i32, sextloadvi8,  LD1SB_S, LD1SB_S_IMM, SVEAddrModeRegReg8, PTRUE_S>;
  defm : unpred_load<nxv2i64, sextloadvi8,  LD1SB_D, LD1SB_D_IMM, SVEAddrModeRegReg8, PTRUE_D>;
  defm : unpred_load<nxv4i32, sextloadvi16, LD1SH_S, LD1SH_S_IMM, SVEAddrModeRegReg16, PTRUE_S>;
  defm : unpred_load<nxv2i64, sextloadvi16, LD1SH_D, LD1SH_D_IMM, SVEAddrModeRegReg16, PTRUE_D>;
  defm : unpred_load<nxv2i64, sextloadvi32, LD1SW_D, LD1SW_D_IMM, SVEAddrModeRegReg32, PTRUE_D>;

  defm : unpred_load<nxv8i16, azextloadvi8,  LD1B_H, LD1B_H_IMM, SVEAddrModeRegReg8, PTRUE_H>;
  defm : unpred_load<nxv4i32, azextloadvi8,  LD1B_S, LD1B_S_IMM, SVEAddrModeRegReg8, PTRUE_S>;
  defm : unpred_load<nxv2i64, azextloadvi8,  LD1B_D, LD1B_D_IMM, SVEAddrModeRegReg8, PTRUE_D>;
  defm : unpred_load<nxv4i32, azextloadvi16, LD1H_S, LD1H_S_IMM, SVEAddrModeRegReg16, PTRUE_S>;
  defm : unpred_load<nxv2i64, azextloadvi16, LD1H_D, LD1H_D_IMM, SVEAddrModeRegReg16, PTRUE_D>;
  defm : unpred_load<nxv2i64, azextloadvi32, LD1W_D, LD1W_D_IMM, SVEAddrModeRegReg32, PTRUE_D>;

  multiclass pred_load<ValueType Ty, ValueType PredTy, SDPatternOperator Load,
                       Instruction RegRegInst, Instruction RegImmInst,
                       ComplexPattern AddrCP> {
    // reg + reg
    let AddedComplexity = 1 in {
      def _reg_reg_z : Pat<(Ty (Load (AddrCP GPR64:$base, GPR64:$offset), (PredTy PPR:$gp), (SVEDup0Undef))),
                         (RegRegInst PPR:$gp, GPR64:$base, GPR64:$offset)>;
    }
    // reg + imm
    let AddedComplexity = 2 in {
      def _reg_imm_z : Pat<(Ty (Load (am_sve_indexed_s4 GPR64sp:$base, simm4:$offset), (PredTy PPR:$gp), (SVEDup0Undef))),
                           (RegImmInst PPR:$gp, GPR64:$base, simm4:$offset)>;
    }
    // default fallback
    def _default_z : Pat<(Ty (Load  GPR64:$base, (PredTy PPR:$gp), (SVEDup0Undef))),
                         (RegImmInst PPR:$gp, GPR64:$base, (i64 0))>;
  }

  // 2-element contiguous loads
  defm : pred_load<nxv2i64, nxv2i1, zext_masked_load_i8,  LD1B_D,  LD1B_D_IMM,  SVEAddrModeRegReg8>;
  defm : pred_load<nxv2i64, nxv2i1, sext_masked_load_i8,  LD1SB_D, LD1SB_D_IMM, SVEAddrModeRegReg8>;
  defm : pred_load<nxv2i64, nxv2i1, zext_masked_load_i16, LD1H_D,  LD1H_D_IMM,  SVEAddrModeRegReg16>;
  defm : pred_load<nxv2i64, nxv2i1, sext_masked_load_i16, LD1SH_D, LD1SH_D_IMM, SVEAddrModeRegReg16>;
  defm : pred_load<nxv2i64, nxv2i1, zext_masked_load_i32, LD1W_D,  LD1W_D_IMM,  SVEAddrModeRegReg32>;
  defm : pred_load<nxv2i64, nxv2i1, sext_masked_load_i32, LD1SW_D, LD1SW_D_IMM, SVEAddrModeRegReg32>;
  defm : pred_load<nxv2i64, nxv2i1, nonext_masked_load,   LD1D,    LD1D_IMM,    SVEAddrModeRegReg64>;
  defm : pred_load<nxv2f16, nxv2i1, nonext_masked_load,   LD1H_D,  LD1H_D_IMM,  SVEAddrModeRegReg16>;
  defm : pred_load<nxv2f32, nxv2i1, nonext_masked_load,   LD1W_D,  LD1W_D_IMM,  SVEAddrModeRegReg32>;
  defm : pred_load<nxv2f64, nxv2i1, nonext_masked_load,   LD1D,    LD1D_IMM,    SVEAddrModeRegReg64>;

  // 4-element contiguous loads
  defm : pred_load<nxv4i32, nxv4i1, zext_masked_load_i8,  LD1B_S,  LD1B_S_IMM,  SVEAddrModeRegReg8>;
  defm : pred_load<nxv4i32, nxv4i1, sext_masked_load_i8,  LD1SB_S, LD1SB_S_IMM, SVEAddrModeRegReg8>;
  defm : pred_load<nxv4i32, nxv4i1, zext_masked_load_i16, LD1H_S,  LD1H_S_IMM,  SVEAddrModeRegReg16>;
  defm : pred_load<nxv4i32, nxv4i1, sext_masked_load_i16, LD1SH_S, LD1SH_S_IMM, SVEAddrModeRegReg16>;
  defm : pred_load<nxv4i32, nxv4i1, nonext_masked_load,   LD1W,    LD1W_IMM,    SVEAddrModeRegReg32>;
  defm : pred_load<nxv4f16, nxv4i1, nonext_masked_load,   LD1H_S,  LD1H_S_IMM,  SVEAddrModeRegReg16>;
  defm : pred_load<nxv4f32, nxv4i1, nonext_masked_load,   LD1W,    LD1W_IMM,    SVEAddrModeRegReg32>;

  // 8-element contiguous loads
  defm : pred_load<nxv8i16, nxv8i1, zext_masked_load_i8,  LD1B_H,  LD1B_H_IMM,  SVEAddrModeRegReg8>;
  defm : pred_load<nxv8i16, nxv8i1, sext_masked_load_i8,  LD1SB_H, LD1SB_H_IMM, SVEAddrModeRegReg8>;
  defm : pred_load<nxv8i16, nxv8i1, nonext_masked_load,   LD1H,    LD1H_IMM,    SVEAddrModeRegReg16>;
  defm : pred_load<nxv8f16, nxv8i1, nonext_masked_load,   LD1H,    LD1H_IMM,    SVEAddrModeRegReg16>;

  // 16-element contiguous loads
  defm : pred_load<nxv16i8, nxv16i1, nonext_masked_load,  LD1B,    LD1B_IMM,    SVEAddrModeRegReg8>;

  multiclass ldff1<Instruction I, ValueType Ty, SDPatternOperator Load, ValueType PredTy, ComplexPattern AddrCP, ValueType MemVT> {
    // base + index
    def : Pat<(Ty (Load (PredTy PPR:$gp), (AddrCP GPR64sp:$base, GPR64:$offset), MemVT)),
              (I PPR:$gp, GPR64sp:$base, GPR64:$offset)>;
    // base
    def : Pat<(Ty (Load  (PredTy PPR:$gp), GPR64:$base, MemVT)),
              (I PPR:$gp, GPR64sp:$base, XZR)>;
  }

  // 2-element contiguous first faulting loads
  defm : ldff1<LDFF1B_D,  nxv2i64, AArch64ldff1,  nxv2i1, SVEAddrModeRegReg8,  nxv2i8>;
  defm : ldff1<LDFF1SB_D, nxv2i64, AArch64ldff1s, nxv2i1, SVEAddrModeRegReg8,  nxv2i8>;
  defm : ldff1<LDFF1H_D,  nxv2i64, AArch64ldff1,  nxv2i1, SVEAddrModeRegReg16, nxv2i16>;
  defm : ldff1<LDFF1SH_D, nxv2i64, AArch64ldff1s, nxv2i1, SVEAddrModeRegReg16, nxv2i16>;
  defm : ldff1<LDFF1W_D,  nxv2i64, AArch64ldff1,  nxv2i1, SVEAddrModeRegReg32, nxv2i32>;
  defm : ldff1<LDFF1SW_D, nxv2i64, AArch64ldff1s, nxv2i1, SVEAddrModeRegReg32, nxv2i32>;
  defm : ldff1<LDFF1D,    nxv2i64, AArch64ldff1,  nxv2i1, SVEAddrModeRegReg64, nxv2i64>;
  defm : ldff1<LDFF1W_D,  nxv2f32, AArch64ldff1,  nxv2i1, SVEAddrModeRegReg32, nxv2f32>;
  defm : ldff1<LDFF1D,    nxv2f64, AArch64ldff1,  nxv2i1, SVEAddrModeRegReg64, nxv2f64>;

  // 4-element contiguous first faulting loads
  defm : ldff1<LDFF1B_S,  nxv4i32, AArch64ldff1,  nxv4i1, SVEAddrModeRegReg8,  nxv4i8>;
  defm : ldff1<LDFF1SB_S, nxv4i32, AArch64ldff1s, nxv4i1, SVEAddrModeRegReg8,  nxv4i8>;
  defm : ldff1<LDFF1H_S,  nxv4i32, AArch64ldff1,  nxv4i1, SVEAddrModeRegReg16, nxv4i16>;
  defm : ldff1<LDFF1SH_S, nxv4i32, AArch64ldff1s, nxv4i1, SVEAddrModeRegReg16, nxv4i16>;
  defm : ldff1<LDFF1W,    nxv4i32, AArch64ldff1,  nxv4i1, SVEAddrModeRegReg32, nxv4i32>;
  defm : ldff1<LDFF1W,    nxv4f32, AArch64ldff1,  nxv4i1, SVEAddrModeRegReg32, nxv4f32>;

  // 8-element contiguous first faulting loads
  defm : ldff1<LDFF1B_H,  nxv8i16, AArch64ldff1,  nxv8i1, SVEAddrModeRegReg8,  nxv8i8>;
  defm : ldff1<LDFF1SB_H, nxv8i16, AArch64ldff1s, nxv8i1, SVEAddrModeRegReg8,  nxv8i8>;
  defm : ldff1<LDFF1H,    nxv8i16, AArch64ldff1,  nxv8i1, SVEAddrModeRegReg16, nxv8i16>;
  defm : ldff1<LDFF1H,    nxv8f16, AArch64ldff1,  nxv8i1, SVEAddrModeRegReg16, nxv8f16>;

  // 16-element contiguous first faulting loads
  defm : ldff1<LDFF1B, nxv16i8, AArch64ldff1, nxv16i1, SVEAddrModeRegReg8,  nxv16i8>;

  // 2-element gather first faulting loads
  // TODO: Handle floating point loads within DAGCombine
  def : Pat<(nxv2f64 (AArch64ldff1_gather (nxv2i1 PPR:$gp), GPR64sp:$base, (nxv2i64 ZPR:$offsets), nxv2f64)),
            (GLDFF1D PPR:$gp, GPR64sp:$base, ZPR:$offsets)>;

  def : Pat<(nxv2f64 (AArch64ldff1_gather (nxv2i1 PPR:$gp), uimm5s8:$index, (nxv2i64 ZPR:$ptrs), nxv2f64)),
            (GLDFF1D_IMM PPR:$gp, ZPR:$ptrs, uimm5s8:$index)>;

  def : Pat<(nxv2f64 (AArch64ldff1_gather_scaled (nxv2i1 PPR:$gp), GPR64sp:$base, (nxv2i64 ZPR:$indices), nxv2f64)),
            (GLDFF1D_SCALED PPR:$gp, GPR64sp:$base, ZPR:$indices)>;

  def : Pat<(nxv2f64 (AArch64ldff1_gather (nxv2i1 PPR:$gp), GPR64sp:$base, (sext_inreg (nxv2i64 ZPR:$offsets), nxv2i32), nxv2f64)),
            (GLDFF1D_SXTW PPR:$gp, GPR64sp:$base, ZPR:$offsets)>;

  def : Pat<(nxv2f64 (AArch64ldff1_gather_scaled (nxv2i1 PPR:$gp), GPR64sp:$base, (sext_inreg (nxv2i64 ZPR:$indices), nxv2i32), nxv2f64)),
            (GLDFF1D_SXTW_SCALED PPR:$gp, GPR64sp:$base, ZPR:$indices)>;

  def : Pat<(nxv2f64 (AArch64ldff1_gather (nxv2i1 PPR:$gp), GPR64sp:$base, (and (nxv2i64 ZPR:$offsets), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))), nxv2f64)),
            (GLDFF1D_UXTW PPR:$gp, GPR64sp:$base, ZPR:$offsets)>;

  def : Pat<(nxv2f64 (AArch64ldff1_gather_scaled (nxv2i1 PPR:$gp), GPR64sp:$base, (and (nxv2i64 ZPR:$indices), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))), nxv2f64)),
            (GLDFF1D_UXTW_SCALED PPR:$gp, GPR64sp:$base, ZPR:$indices)>;

  // 4-element gather first faulting loads
  // TODO: Handle floating point loads within DAGCombine
  def : Pat<(nxv4f32 (AArch64ldff1_gather_uxtw (nxv4i1 PPR:$gp), uimm5s4:$index, (nxv4i32 ZPR:$ptrs), nxv4f32)),
            (GLDFF1W_IMM PPR:$gp, ZPR:$ptrs, uimm5s4:$index)>;

  def : Pat<(nxv4f32 (AArch64ldff1_gather_sxtw (nxv4i1 PPR:$gp), GPR64sp:$base, (nxv4i32 ZPR:$offsets), nxv4f32)),
            (GLDFF1W_SXTW PPR:$gp, GPR64sp:$base, ZPR:$offsets)>;

  def : Pat<(nxv4f32 (AArch64ldff1_gather_sxtw_scaled (nxv4i1 PPR:$gp), GPR64sp:$base, (nxv4i32 ZPR:$indices), nxv4f32)),
            (GLDFF1W_SXTW_SCALED PPR:$gp, GPR64sp:$base, ZPR:$indices)>;

  def : Pat<(nxv4f32 (AArch64ldff1_gather_uxtw (nxv4i1 PPR:$gp), GPR64sp:$base, (nxv4i32 ZPR:$offsets), nxv4f32)),
            (GLDFF1W_UXTW PPR:$gp, GPR64sp:$base, ZPR:$offsets)>;

  def : Pat<(nxv4f32 (AArch64ldff1_gather_uxtw_scaled (nxv4i1 PPR:$gp), GPR64sp:$base, (nxv4i32 ZPR:$indices), nxv4f32)),
            (GLDFF1W_UXTW_SCALED PPR:$gp, GPR64sp:$base, ZPR:$indices)>;

  multiclass sve_masked_gather_x2<ValueType vt, SDPatternOperator load, string I, Operand imm_ty, string SCALED> {
    // vector of pointers
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), 0, (nxv2i64 ZPR:$ptrs))),
              (!cast<Instruction>(I # "_IMM") PPR:$gp, ZPR:$ptrs, 0)>;
    // vector of pointers + immediate offset
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), 0, (add (nxv2i64 ZPR:$ptrs), (nxv2i64 (AArch64dup (i64 imm_ty:$imm)))))),
              (!cast<Instruction>(I # "_IMM") PPR:$gp, ZPR:$ptrs, imm_ty:$imm)>;
    // vector of pointers + scalar offset
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), 0, (add (nxv2i64 ZPR:$ptrs), (nxv2i64 (AArch64dup GPR64:$offset))))),
              (!cast<Instruction>(I) PPR:$gp, GPR64:$offset, ZPR:$ptrs)>;
    // base + vector of scaled offsets
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), GPR64:$base, (nxv2i64 ZPR:$offs))),
              (!cast<Instruction>(I # SCALED) PPR:$gp, GPR64:$base, ZPR:$offs)>;
    // base + vector of signed 32bit scaled offsets
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), GPR64:$base, (sext_inreg (nxv2i64 ZPR:$offs), nxv2i32))),
              (!cast<Instruction>(I # "_SXTW" # SCALED) PPR:$gp, GPR64:$base, ZPR:$offs)>;
    // base + vector of unsigned 32bit scaled offsets
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), GPR64:$base, (and (nxv2i64 ZPR:$offs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))))),
              (!cast<Instruction>(I # "_UXTW" # SCALED) PPR:$gp, GPR64:$base, ZPR:$offs)>;
    // base + vector of signed 32bit offsets
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), 0, (add (nxv2i64 (AArch64dup GPR64:$base)), (sext_inreg (nxv2i64 ZPR:$offs), nxv2i32)))),
              (!cast<Instruction>(I # "_SXTW") PPR:$gp, GPR64:$base, ZPR:$offs)>;
    // base + vector of unsigned 32bit offsets
    def : Pat<(vt (load undef, (nxv2i1 PPR:$gp), 0, (add (nxv2i64 (AArch64dup GPR64:$base)), (and (nxv2i64 ZPR:$offs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF))))))),
              (!cast<Instruction>(I # "_UXTW") PPR:$gp, GPR64:$base, ZPR:$offs)>;
  }

  multiclass sve_masked_gather_x4<ValueType vt, SDPatternOperator load, Instruction I> {
    def : Pat<(vt (load undef, (nxv4i1 PPR:$gp), GPR64:$base, (nxv4i32 ZPR:$offs))),
              (I PPR:$gp, GPR64:$base, ZPR:$offs)>;
  }

  defm : sve_masked_gather_x2<nxv2i64, zext_masked_gather_signed_scaled_i8,  "GLD1B_D" , imm0_31, "">;
  defm : sve_masked_gather_x2<nxv2i64, sext_masked_gather_signed_scaled_i8,  "GLD1SB_D", imm0_31, "">;
  defm : sve_masked_gather_x2<nxv2i64, zext_masked_gather_signed_scaled_i16, "GLD1H_D",  uimm5s2, "_SCALED">;
  defm : sve_masked_gather_x2<nxv2i64, sext_masked_gather_signed_scaled_i16, "GLD1SH_D", uimm5s2, "_SCALED">;
  defm : sve_masked_gather_x2<nxv2i64, zext_masked_gather_signed_scaled_i32, "GLD1W_D",  uimm5s4, "_SCALED">;
  defm : sve_masked_gather_x2<nxv2i64, sext_masked_gather_signed_scaled_i32, "GLD1SW_D", uimm5s4, "_SCALED">;
  defm : sve_masked_gather_x2<nxv2i64, nonext_masked_gather_signed_scaled,   "GLD1D",    uimm5s8, "_SCALED">;
  defm : sve_masked_gather_x2<nxv2f16, nonext_masked_gather_signed_scaled,   "GLD1H_D",  uimm5s2, "_SCALED">;
  defm : sve_masked_gather_x2<nxv2f32, nonext_masked_gather_signed_scaled,   "GLD1W_D",  uimm5s4, "_SCALED">;
  defm : sve_masked_gather_x2<nxv2f64, nonext_masked_gather_signed_scaled,   "GLD1D",    uimm5s8, "_SCALED">;

  defm : sve_masked_gather_x4<nxv4i32, zext_masked_gather_signed_scaled_i8,  GLD1B_S_SXTW>;
  defm : sve_masked_gather_x4<nxv4i32, sext_masked_gather_signed_scaled_i8,  GLD1SB_S_SXTW>;
  defm : sve_masked_gather_x4<nxv4i32, zext_masked_gather_signed_scaled_i16, GLD1H_S_SXTW_SCALED>;
  defm : sve_masked_gather_x4<nxv4i32, sext_masked_gather_signed_scaled_i16, GLD1SH_S_SXTW_SCALED>;
  defm : sve_masked_gather_x4<nxv4i32, nonext_masked_gather_signed_scaled,   GLD1W_SXTW_SCALED>;
  defm : sve_masked_gather_x4<nxv4f16, nonext_masked_gather_signed_scaled,   GLD1H_S_SXTW_SCALED>;
  defm : sve_masked_gather_x4<nxv4f32, nonext_masked_gather_signed_scaled,   GLD1W_SXTW_SCALED>;

  defm : sve_masked_gather_x4<nxv4i32, zext_masked_gather_signed_unscaled_i8,  GLD1B_S_SXTW>;
  defm : sve_masked_gather_x4<nxv4i32, sext_masked_gather_signed_unscaled_i8,  GLD1SB_S_SXTW>;
  defm : sve_masked_gather_x4<nxv4i32, zext_masked_gather_signed_unscaled_i16, GLD1H_S_SXTW>;
  defm : sve_masked_gather_x4<nxv4i32, sext_masked_gather_signed_unscaled_i16, GLD1SH_S_SXTW>;
  defm : sve_masked_gather_x4<nxv4i32, nonext_masked_gather_signed_unscaled,   GLD1W_SXTW>;
  defm : sve_masked_gather_x4<nxv4f16, nonext_masked_gather_signed_unscaled,   GLD1H_S_SXTW>;
  defm : sve_masked_gather_x4<nxv4f32, nonext_masked_gather_signed_unscaled,   GLD1W_SXTW>;

  defm : sve_masked_gather_x4<nxv4i32, zext_masked_gather_unsigned_scaled_i8,  GLD1B_S_UXTW>;
  defm : sve_masked_gather_x4<nxv4i32, sext_masked_gather_unsigned_scaled_i8,  GLD1SB_S_UXTW>;
  defm : sve_masked_gather_x4<nxv4i32, zext_masked_gather_unsigned_scaled_i16, GLD1H_S_UXTW_SCALED>;
  defm : sve_masked_gather_x4<nxv4i32, sext_masked_gather_unsigned_scaled_i16, GLD1SH_S_UXTW_SCALED>;
  defm : sve_masked_gather_x4<nxv4i32, nonext_masked_gather_unsigned_scaled,   GLD1W_UXTW_SCALED>;
  defm : sve_masked_gather_x4<nxv4f16, nonext_masked_gather_unsigned_scaled,   GLD1H_S_UXTW_SCALED>;
  defm : sve_masked_gather_x4<nxv4f32, nonext_masked_gather_unsigned_scaled,   GLD1W_UXTW_SCALED>;

  defm : sve_masked_gather_x4<nxv4i32, zext_masked_gather_unsigned_unscaled_i8,  GLD1B_S_UXTW>;
  defm : sve_masked_gather_x4<nxv4i32, sext_masked_gather_unsigned_unscaled_i8,  GLD1SB_S_UXTW>;
  defm : sve_masked_gather_x4<nxv4i32, zext_masked_gather_unsigned_unscaled_i16, GLD1H_S_UXTW>;
  defm : sve_masked_gather_x4<nxv4i32, sext_masked_gather_unsigned_unscaled_i16, GLD1SH_S_UXTW>;
  defm : sve_masked_gather_x4<nxv4i32, nonext_masked_gather_unsigned_unscaled,   GLD1W_UXTW>;
  defm : sve_masked_gather_x4<nxv4f16, nonext_masked_gather_unsigned_unscaled,   GLD1H_S_UXTW>;
  defm : sve_masked_gather_x4<nxv4f32, nonext_masked_gather_unsigned_unscaled,   GLD1W_UXTW>;

  multiclass ldnf1<Instruction I, ValueType Ty, SDPatternOperator Load, ValueType PredTy, ValueType MemVT> {
    // base + offset_mul_vl
    def : Pat<(Ty (Load (PredTy PPR:$gp), (am_sve_indexed_s4 GPR64sp:$base, simm4:$offset), MemVT)),
              (I PPR:$gp, GPR64sp:$base, simm4:$offset)>;
    // base
    def : Pat<(Ty (Load  (PredTy PPR:$gp), GPR64:$base, MemVT)),
              (I PPR:$gp, GPR64sp:$base, (i64 0))>;
  }

  // 2-element contiguous non-faulting loads
  defm : ldnf1<LDNF1B_D_IMM,  nxv2i64, AArch64ldnf1,  nxv2i1, nxv2i8>;
  defm : ldnf1<LDNF1SB_D_IMM, nxv2i64, AArch64ldnf1s, nxv2i1, nxv2i8>;
  defm : ldnf1<LDNF1H_D_IMM,  nxv2i64, AArch64ldnf1,  nxv2i1, nxv2i16>;
  defm : ldnf1<LDNF1SH_D_IMM, nxv2i64, AArch64ldnf1s, nxv2i1, nxv2i16>;
  defm : ldnf1<LDNF1W_D_IMM,  nxv2i64, AArch64ldnf1,  nxv2i1, nxv2i32>;
  defm : ldnf1<LDNF1SW_D_IMM, nxv2i64, AArch64ldnf1s, nxv2i1, nxv2i32>;
  defm : ldnf1<LDNF1D_IMM,    nxv2i64, AArch64ldnf1,  nxv2i1, nxv2i64>;
  defm : ldnf1<LDNF1D_IMM,    nxv2f64, AArch64ldnf1,  nxv2i1, nxv2f64>;

  // 4-element contiguous non-faulting loads
  defm : ldnf1<LDNF1B_S_IMM,  nxv4i32, AArch64ldnf1,  nxv4i1, nxv4i8>;
  defm : ldnf1<LDNF1SB_S_IMM, nxv4i32, AArch64ldnf1s, nxv4i1, nxv4i8>;
  defm : ldnf1<LDNF1H_S_IMM,  nxv4i32, AArch64ldnf1,  nxv4i1, nxv4i16>;
  defm : ldnf1<LDNF1SH_S_IMM, nxv4i32, AArch64ldnf1s, nxv4i1, nxv4i16>;
  defm : ldnf1<LDNF1W_IMM,    nxv4i32, AArch64ldnf1,  nxv4i1, nxv4i32>;
  defm : ldnf1<LDNF1W_IMM,    nxv4f32, AArch64ldnf1,  nxv4i1, nxv4f32>;

  // 8-element contiguous non-faulting loads
  defm : ldnf1<LDNF1B_H_IMM,  nxv8i16, AArch64ldnf1,  nxv8i1, nxv8i8>;
  defm : ldnf1<LDNF1SB_H_IMM, nxv8i16, AArch64ldnf1s, nxv8i1, nxv8i8>;
  defm : ldnf1<LDNF1H_IMM,    nxv8i16, AArch64ldnf1,  nxv8i1, nxv8i16>;
  defm : ldnf1<LDNF1H_IMM,    nxv8f16, AArch64ldnf1,  nxv8i1, nxv8f16>;

  // 16-element contiguous non-faulting loads
  defm : ldnf1<LDNF1B_IMM,    nxv16i8, AArch64ldnf1, nxv16i1, nxv16i8>;

  multiclass unpred_store<ValueType Ty, Instruction RegRegInst, Instruction RegImmInst, ComplexPattern AddrCP, Instruction PTrue> {
    // reg + reg
    let AddedComplexity = 1 in {
      def _reg_reg : Pat<(store (Ty ZPR:$val), (AddrCP GPR64sp:$base, GPR64:$offset)),
                         (RegRegInst ZPR:$val, (PTrue 31), GPR64sp:$base, GPR64:$offset)>;
    // reg + imm
    }
    let AddedComplexity = 2 in {
      def _reg_imm : Pat<(store (Ty ZPR:$val), (am_sve_indexed_s4 GPR64sp:$base, simm4:$offset)),
                         (RegImmInst ZPR:$val, (PTrue 31), GPR64sp:$base, simm4:$offset)>;
    }
    // default fallback
    def _default : Pat<(store (Ty ZPR:$val),  GPR64sp:$base),
                       (RegImmInst ZPR:$val, (PTrue 31), GPR64sp:$base, (i64 0))>;
  }

  defm Pat_ST1B        : unpred_store<nxv16i8, ST1B, ST1B_IMM, SVEAddrModeRegReg8,  PTRUE_B>;
  defm Pat_ST1H        : unpred_store<nxv8i16, ST1H, ST1H_IMM, SVEAddrModeRegReg16, PTRUE_H>;
  defm Pat_ST1W        : unpred_store<nxv4i32, ST1W, ST1W_IMM, SVEAddrModeRegReg32, PTRUE_S>;
  defm Pat_ST1D        : unpred_store<nxv2i64, ST1D, ST1D_IMM, SVEAddrModeRegReg64, PTRUE_D>;
  defm Pat_ST1H_float16: unpred_store<nxv8f16, ST1H, ST1H_IMM, SVEAddrModeRegReg16, PTRUE_H>;
  defm Pat_ST1W_float  : unpred_store<nxv4f32, ST1W, ST1W_IMM, SVEAddrModeRegReg32, PTRUE_S>;
  defm Pat_ST1D_double : unpred_store<nxv2f64, ST1D, ST1D_IMM, SVEAddrModeRegReg64, PTRUE_D>;


  multiclass pred_store<ValueType Ty, ValueType PredTy, SDPatternOperator Store, Instruction RegRegInst, Instruction RegImmInst, ComplexPattern AddrCP> {
    // reg + reg
    let AddedComplexity = 1 in {
      def _reg_reg : Pat<(Store (AddrCP GPR64:$base, GPR64:$offset), (PredTy PPR:$gp), (Ty ZPR:$vec)),
                         (RegRegInst ZPR:$vec, PPR:$gp, GPR64:$base, GPR64:$offset)>;
    }
    // reg + imm
    let AddedComplexity = 2 in {
    // TODO: write LL test for this pattern
      def _reg_imm : Pat<(Store (am_sve_indexed_s4 GPR64sp:$base, simm4:$offset), (PredTy PPR:$gp), (Ty ZPR:$vec)),
                         (RegImmInst ZPR:$vec, PPR:$gp, GPR64:$base, simm4:$offset)>;
    }
    // default fallback
    def _default : Pat<(Store GPR64:$base, (PredTy PPR:$gp), (Ty ZPR:$vec)),
                       (RegImmInst ZPR:$vec, PPR:$gp, GPR64:$base, (i64 0))>;
  }

  // 2-element contiguous stores
  defm : pred_store<nxv2i64, nxv2i1, trunc_masked_store_i8,  ST1B_D, ST1B_D_IMM, SVEAddrModeRegReg8>;
  defm : pred_store<nxv2i64, nxv2i1, trunc_masked_store_i16, ST1H_D, ST1H_D_IMM, SVEAddrModeRegReg16>;
  defm : pred_store<nxv2i64, nxv2i1, trunc_masked_store_i32, ST1W_D, ST1W_D_IMM, SVEAddrModeRegReg32>;
  defm : pred_store<nxv2i64, nxv2i1, nontrunc_masked_store,  ST1D,   ST1D_IMM,   SVEAddrModeRegReg64>;
  defm : pred_store<nxv2f16, nxv2i1, nontrunc_masked_store,  ST1H_D, ST1H_D_IMM, SVEAddrModeRegReg16>;
  defm : pred_store<nxv2f32, nxv2i1, nontrunc_masked_store,  ST1W_D, ST1W_D_IMM, SVEAddrModeRegReg32>;
  defm : pred_store<nxv2f64, nxv2i1, nontrunc_masked_store,  ST1D,   ST1D_IMM,   SVEAddrModeRegReg64>;

  // 4-element contiguous stores
  defm : pred_store<nxv4i32, nxv4i1, trunc_masked_store_i8,  ST1B_S, ST1B_S_IMM, SVEAddrModeRegReg8>;
  defm : pred_store<nxv4i32, nxv4i1, trunc_masked_store_i16, ST1H_S, ST1H_S_IMM, SVEAddrModeRegReg16>;
  defm : pred_store<nxv4i32, nxv4i1, nontrunc_masked_store,  ST1W,   ST1W_IMM,   SVEAddrModeRegReg32>;
  defm : pred_store<nxv4f16, nxv4i1, nontrunc_masked_store,  ST1H_S, ST1H_S_IMM, SVEAddrModeRegReg16>;
  defm : pred_store<nxv4f32, nxv4i1, nontrunc_masked_store,  ST1W,   ST1W_IMM,   SVEAddrModeRegReg32>;

  // 8-element contiguous stores
  defm : pred_store<nxv8i16, nxv8i1, trunc_masked_store_i8,  ST1B_H, ST1B_H_IMM, SVEAddrModeRegReg8>;
  defm : pred_store<nxv8i16, nxv8i1, nontrunc_masked_store,  ST1H,   ST1H_IMM,   SVEAddrModeRegReg16>;
  defm : pred_store<nxv8f16, nxv8i1, nontrunc_masked_store,  ST1H,   ST1H_IMM,   SVEAddrModeRegReg16>;

  // 16-element contiguous stores
  defm : pred_store<nxv16i8, nxv16i1, nontrunc_masked_store, ST1B,   ST1B_IMM, SVEAddrModeRegReg8>;

  multiclass sve_masked_scatter_x2<ValueType vt, SDPatternOperator store, string I, Operand imm_ty, string SCALED> {
    // vector of pointers
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), 0, (nxv2i64 ZPR:$ptrs)),
              (!cast<Instruction>(I # "_IMM") ZPR:$vec, PPR:$gp, ZPR:$ptrs, 0)>;
    // vector of pointers + immediate offset
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), 0, (add (nxv2i64 ZPR:$ptrs), (nxv2i64 (AArch64dup (i64 imm_ty:$imm))))),
              (!cast<Instruction>(I # "_IMM") ZPR:$vec, PPR:$gp, ZPR:$ptrs, imm_ty:$imm)>;
    // vector of pointers + scalar offset
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), 0, (add (nxv2i64 ZPR:$ptrs), (nxv2i64 (AArch64dup GPR64:$offset)))),
              (!cast<Instruction>(I) ZPR:$vec, PPR:$gp, GPR64:$offset, ZPR:$ptrs)>;
    // base + vector of scaled offsets
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), GPR64:$base, (nxv2i64 ZPR:$offs)),
              (!cast<Instruction>(I # SCALED) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$offs)>;
    // base + vector of signed 32bit scaled offsets
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), GPR64:$base, (sext_inreg (nxv2i64 ZPR:$offs), nxv2i32)),
              (!cast<Instruction>(I # "_SXTW" # SCALED) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$offs)>;
    // base + vector of unsigned 32bit scaled offsets
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), GPR64:$base, (and (nxv2i64 ZPR:$offs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF))))),
              (!cast<Instruction>(I # "_UXTW" # SCALED) ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$offs)>;
    // base + vector of signed 32bit offsets
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), 0, (add (nxv2i64 (AArch64dup GPR64:$base)), (sext_inreg (nxv2i64 ZPR:$offs), nxv2i32))),
              (!cast<Instruction>(I # "_SXTW") ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$offs)>;
    // base + vector of unsigned 32bit offsets
    def : Pat<(store (vt ZPR:$vec), (nxv2i1 PPR:$gp), 0, (add (nxv2i64 (AArch64dup GPR64:$base)), (and (nxv2i64 ZPR:$offs), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))))),
              (!cast<Instruction>(I # "_UXTW") ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$offs)>;
  }

  multiclass sve_masked_scatter_x4<ValueType vt, SDPatternOperator store, Instruction I> {
    def : Pat<(store (vt ZPR:$vec), (nxv4i1 PPR:$gp), GPR64:$base, (nxv4i32 ZPR:$offs)),
              (I ZPR:$vec, PPR:$gp, GPR64:$base, ZPR:$offs)>;
  }

  defm : sve_masked_scatter_x2<nxv2i64, trunc_masked_scatter_signed_scaled_i8,  "SST1B_D", imm0_31, "">;
  defm : sve_masked_scatter_x2<nxv2i64, trunc_masked_scatter_signed_scaled_i16, "SST1H_D", uimm5s2, "_SCALED">;
  defm : sve_masked_scatter_x2<nxv2i64, trunc_masked_scatter_signed_scaled_i32, "SST1W_D", uimm5s4, "_SCALED">;
  defm : sve_masked_scatter_x2<nxv2i64, nontrunc_masked_scatter_signed_scaled,  "SST1D",   uimm5s8, "_SCALED">;
  defm : sve_masked_scatter_x2<nxv2f16, nontrunc_masked_scatter_signed_scaled,  "SST1H_D", uimm5s2, "_SCALED">;
  defm : sve_masked_scatter_x2<nxv2f32, nontrunc_masked_scatter_signed_scaled,  "SST1W_D", uimm5s4, "_SCALED">;
  defm : sve_masked_scatter_x2<nxv2f64, nontrunc_masked_scatter_signed_scaled,  "SST1D",   uimm5s8, "_SCALED">;

  defm : sve_masked_scatter_x4<nxv4i32, trunc_masked_scatter_signed_scaled_i8,  SST1B_S_SXTW>;
  defm : sve_masked_scatter_x4<nxv4i32, trunc_masked_scatter_signed_scaled_i16, SST1H_S_SXTW_SCALED>;
  defm : sve_masked_scatter_x4<nxv4i32, nontrunc_masked_scatter_signed_scaled,  SST1W_SXTW_SCALED>;
  defm : sve_masked_scatter_x4<nxv4f16, nontrunc_masked_scatter_signed_scaled,  SST1H_S_SXTW_SCALED>;
  defm : sve_masked_scatter_x4<nxv4f32, nontrunc_masked_scatter_signed_scaled,  SST1W_SXTW_SCALED>;

  defm : sve_masked_scatter_x4<nxv4i32, trunc_masked_scatter_signed_unscaled_i8,  SST1B_S_SXTW>;
  defm : sve_masked_scatter_x4<nxv4i32, trunc_masked_scatter_signed_unscaled_i16, SST1H_S_SXTW>;
  defm : sve_masked_scatter_x4<nxv4i32, nontrunc_masked_scatter_signed_unscaled,  SST1W_SXTW>;
  defm : sve_masked_scatter_x4<nxv4f16, nontrunc_masked_scatter_signed_unscaled,  SST1H_S_SXTW>;
  defm : sve_masked_scatter_x4<nxv4f32, nontrunc_masked_scatter_signed_unscaled,  SST1W_SXTW>;

  defm : sve_masked_scatter_x4<nxv4i32, trunc_masked_scatter_unsigned_scaled_i8,  SST1B_S_UXTW>;
  defm : sve_masked_scatter_x4<nxv4i32, trunc_masked_scatter_unsigned_scaled_i16, SST1H_S_UXTW_SCALED>;
  defm : sve_masked_scatter_x4<nxv4i32, nontrunc_masked_scatter_unsigned_scaled,  SST1W_UXTW_SCALED>;
  defm : sve_masked_scatter_x4<nxv4f16, nontrunc_masked_scatter_unsigned_scaled,  SST1H_S_UXTW_SCALED>;
  defm : sve_masked_scatter_x4<nxv4f32, nontrunc_masked_scatter_unsigned_scaled,  SST1W_UXTW_SCALED>;

  defm : sve_masked_scatter_x4<nxv4i32, trunc_masked_scatter_unsigned_unscaled_i8,  SST1B_S_UXTW>;
  defm : sve_masked_scatter_x4<nxv4i32, trunc_masked_scatter_unsigned_unscaled_i16, SST1H_S_UXTW>;
  defm : sve_masked_scatter_x4<nxv4i32, nontrunc_masked_scatter_unsigned_unscaled,  SST1W_UXTW>;
  defm : sve_masked_scatter_x4<nxv4f16, nontrunc_masked_scatter_unsigned_unscaled,  SST1H_S_UXTW>;
  defm : sve_masked_scatter_x4<nxv4f32, nontrunc_masked_scatter_unsigned_unscaled,  SST1W_UXTW>;

  // Unpacked floating point loads
  def : Pat<(nxv2f32 (load (i64 GPR64:$base))),
            (LD1W_D_IMM (PTRUE_D 31), GPR64:$base, (i64 0))>;

  // Unpacked floating point stores
  def : Pat<(store (nxv2f32 ZPR:$Zs), (i64 GPR64:$base)),
            (ST1W_D_IMM ZPR:$Zs, (PTRUE_D 31), GPR64:$base, (i64 0))>;


  def : Pat<(nxv16i1 (and PPR:$Ps1, PPR:$Ps2)),
            (AND_PPzPP (PTRUE_B 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv8i1 (and PPR:$Ps1, PPR:$Ps2)),
            (AND_PPzPP (PTRUE_H 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv4i1 (and PPR:$Ps1, PPR:$Ps2)),
            (AND_PPzPP (PTRUE_S 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv2i1 (and PPR:$Ps1, PPR:$Ps2)),
            (AND_PPzPP (PTRUE_D 31), PPR:$Ps1, PPR:$Ps2)>;

  def : Pat<(nxv2i1 (and (nxv2i1 (and PPR:$Ps1, PPR:$Ps2)), PPR:$Ps3)),
            (AND_PPzPP PPR:$Ps1, PPR:$Ps2, PPR:$Ps3)>;
  def : Pat<(nxv2i1 (and PPR:$Ps1, (nxv2i1 (and PPR:$Ps2, PPR:$Ps3)))),
            (AND_PPzPP PPR:$Ps1, PPR:$Ps2, PPR:$Ps3)>;

  def : Pat<(nxv16i1 (or PPR:$Ps1, PPR:$Ps2)),
            (ORR_PPzPP (PTRUE_B 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv8i1 (or PPR:$Ps1, PPR:$Ps2)),
            (ORR_PPzPP (PTRUE_H 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv4i1 (or PPR:$Ps1, PPR:$Ps2)),
            (ORR_PPzPP (PTRUE_S 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv2i1 (or PPR:$Ps1, PPR:$Ps2)),
            (ORR_PPzPP (PTRUE_D 31), PPR:$Ps1, PPR:$Ps2)>;

  def : Pat<(nxv16i1 (xor PPR:$Ps1, PPR:$Ps2)),
            (EOR_PPzPP (PTRUE_B 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv8i1 (xor PPR:$Ps1, PPR:$Ps2)),
            (EOR_PPzPP (PTRUE_H 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv4i1 (xor PPR:$Ps1, PPR:$Ps2)),
            (EOR_PPzPP (PTRUE_S 31), PPR:$Ps1, PPR:$Ps2)>;
  def : Pat<(nxv2i1 (xor PPR:$Ps1, PPR:$Ps2)),
            (EOR_PPzPP (PTRUE_D 31), PPR:$Ps1, PPR:$Ps2)>;

  // Floating point compares
  defm FCMGE_PPzZZ : sve_fp_3op_p_pd<0b000, "fcmge", int_aarch64_sve_cmpge, AArch64fcmge>;
  defm FCMGT_PPzZZ : sve_fp_3op_p_pd<0b001, "fcmgt", int_aarch64_sve_cmpgt, AArch64fcmgt>;
  defm FCMEQ_PPzZZ : sve_fp_3op_p_pd<0b010, "fcmeq", int_aarch64_sve_cmpeq, AArch64fcmeq>;
  defm FCMNE_PPzZZ : sve_fp_3op_p_pd<0b011, "fcmne", int_aarch64_sve_cmpne>;
  defm FCMUO_PPzZZ : sve_fp_3op_p_pd<0b100, "fcmuo", int_aarch64_sve_cmpuo>;
  defm FACGE_PPzZZ : sve_fp_3op_p_pd<0b101, "facge", int_aarch64_sve_acge>;
  defm FACGT_PPzZZ : sve_fp_3op_p_pd<0b111, "facgt", int_aarch64_sve_acgt>;

  defm FCMGE_PPzZ0 : sve_fp_2op_p_pd<0b000, "fcmge", int_aarch64_sve_cmpge, AArch64fcmge>;
  defm FCMGT_PPzZ0 : sve_fp_2op_p_pd<0b001, "fcmgt", int_aarch64_sve_cmpgt, AArch64fcmgt>;
  defm FCMLT_PPzZ0 : sve_fp_2op_p_pd<0b010, "fcmlt", null_frag, null_frag, int_aarch64_sve_cmpgt, AArch64fcmgt>;
  defm FCMLE_PPzZ0 : sve_fp_2op_p_pd<0b011, "fcmle", null_frag, null_frag, int_aarch64_sve_cmpge, AArch64fcmge>;
  defm FCMEQ_PPzZ0 : sve_fp_2op_p_pd<0b100, "fcmeq", int_aarch64_sve_cmpeq, AArch64fcmeq>;
  defm FCMNE_PPzZ0 : sve_fp_2op_p_pd<0b110, "fcmne", int_aarch64_sve_cmpne>;

  // UNE compares
  def : Pat<(nxv4i1 (AArch64not (AArch64fcmeq (nxv4f32 ZPR:$Zs1), (nxv4f32 ZPR:$Zs2)))),
            (FCMNE_PPzZZ_S (PTRUE_S 31), ZPR:$Zs1, ZPR:$Zs2)>;
  def : Pat<(nxv2i1 (AArch64not (AArch64fcmeq (nxv2f64 ZPR:$Zs1), (nxv2f64 ZPR:$Zs2)))),
            (FCMNE_PPzZZ_D (PTRUE_D 31), ZPR:$Zs1, ZPR:$Zs2)>;

  // Extract lo/hi halves of legal predicate types.
  def : Pat<(nxv2i1 (extract_subvector (nxv4i1 PPR:$Ps), (i64 0))),
            (ZIP1_PPP_S PPR:$Ps, (PFALSE))>;
  def : Pat<(nxv2i1 (extract_subvector (nxv4i1 PPR:$Ps), (i64 2))),
            (ZIP2_PPP_S PPR:$Ps, (PFALSE))>;
  def : Pat<(nxv4i1 (extract_subvector (nxv8i1 PPR:$Ps), (i64 0))),
            (ZIP1_PPP_H PPR:$Ps, (PFALSE))>;
  def : Pat<(nxv4i1 (extract_subvector (nxv8i1 PPR:$Ps), (i64 4))),
            (ZIP2_PPP_H PPR:$Ps, (PFALSE))>;
  def : Pat<(nxv8i1 (extract_subvector (nxv16i1 PPR:$Ps), (i64 0))),
            (ZIP1_PPP_B PPR:$Ps, (PFALSE))>;
  def : Pat<(nxv8i1 (extract_subvector (nxv16i1 PPR:$Ps), (i64 8))),
            (ZIP2_PPP_B PPR:$Ps, (PFALSE))>;

  def : Pat<(nxv4f16 (extract_subvector (nxv8f16 ZPR:$Zs), (i64 0))),
            (UUNPKLO_ZZ_S ZPR:$Zs)>;
  def : Pat<(nxv4f16 (extract_subvector (nxv8f16 ZPR:$Zs), (i64 4))),
            (UUNPKHI_ZZ_S ZPR:$Zs)>;

  def : Pat<(nxv2f16 (extract_subvector (nxv4f16 ZPR:$Zs), (i64 0))),
            (UUNPKLO_ZZ_D ZPR:$Zs)>;
  def : Pat<(nxv2f16 (extract_subvector (nxv4f16 ZPR:$Zs), (i64 2))),
            (UUNPKHI_ZZ_D ZPR:$Zs)>;
  def : Pat<(nxv2f32 (extract_subvector (nxv4f32 ZPR:$Zs), (i64 0))),
            (UUNPKLO_ZZ_D ZPR:$Zs)>;
  def : Pat<(nxv2f32 (extract_subvector (nxv4f32 ZPR:$Zs), (i64 2))),
            (UUNPKHI_ZZ_D ZPR:$Zs)>;

  defm ADR_SXTW_ZZZ_D : sve_int_bin_cons_misc_0_a_sxtw<0b00, "adr">;
  defm ADR_UXTW_ZZZ_D : sve_int_bin_cons_misc_0_a_uxtw<0b01, "adr">;
  defm ADR_LSL_ZZZ_S  : sve_int_bin_cons_misc_0_a_32_lsl<0b10, "adr">;
  defm ADR_LSL_ZZZ_D  : sve_int_bin_cons_misc_0_a_64_lsl<0b11, "adr">;

  def : Pat<(nxv2i64 (add (nxv2i64 ZPR:$Zn), (nxv2i64LslBy3 (nxv2i64 ZPR:$Zm)))),
            (ADR_LSL_ZZZ_D ZPR:$Zn, ZPR:$Zm, 3)>;
  def : Pat<(nxv2i64 (add (nxv2i64LslBy3 (nxv2i64 ZPR:$Zm)), (nxv2i64 ZPR:$Zn))),
            (ADR_LSL_ZZZ_D ZPR:$Zn, ZPR:$Zm, 3)>;

  // Contiguous SVE prefetches
  multiclass sve_prefetch<SDPatternOperator prefetch, ValueType PredTy, Instruction RegImmInst, Instruction RegRegInst, int scale, ComplexPattern AddrCP> {
    // reg + imm
    let AddedComplexity = 2 in {
      def _reg_imm : Pat<(prefetch (PredTy PPR_3b:$gp), (am_sve_indexed_s6 GPR64sp:$base, simm6:$offset), (i32 sve_prfop:$prfop)),
                         (RegImmInst sve_prfop:$prfop, PPR_3b:$gp, GPR64:$base, simm6:$offset)>;
    }

    let AddedComplexity = 1 in {
      def _reg_reg : Pat<(prefetch (PredTy PPR_3b:$gp), (AddrCP GPR64sp:$base, GPR64:$index), (i32 sve_prfop:$prfop)),
                         (RegRegInst sve_prfop:$prfop, PPR_3b:$gp, GPR64:$base, GPR64:$index)>;
    }

    // default fallback
    def _default : Pat<(prefetch  (PredTy PPR_3b:$gp), GPR64:$base, (i32 sve_prfop:$prfop)),
                       (RegImmInst sve_prfop:$prfop, PPR_3b:$gp, GPR64:$base, (i64 0))>;
  }

  defm PRFB_PRI : sve_mem_prfm_si<0b00, "prfb">;
  defm PRFH_PRI : sve_mem_prfm_si<0b01, "prfh">;
  defm PRFW_PRI : sve_mem_prfm_si<0b10, "prfw">;
  defm PRFD_PRI : sve_mem_prfm_si<0b11, "prfd">;

  def PRFB_PRR : sve_mem_prfm_ss<0b001, "prfb", GPR64NoXZRshifted8>;
  def PRFH_PRR : sve_mem_prfm_ss<0b011, "prfh", GPR64NoXZRshifted16>;
  def PRFS_PRR : sve_mem_prfm_ss<0b101, "prfw", GPR64NoXZRshifted32>;
  def PRFD_PRR : sve_mem_prfm_ss<0b111, "prfd", GPR64NoXZRshifted64>;

  defm : sve_prefetch<int_aarch64_sve_prf, nxv16i1, PRFB_PRI, PRFB_PRR, 0, SVEAddrModeRegReg8>;
  defm : sve_prefetch<int_aarch64_sve_prf, nxv8i1,  PRFH_PRI, PRFH_PRR, 1, SVEAddrModeRegReg16>;
  defm : sve_prefetch<int_aarch64_sve_prf, nxv4i1,  PRFW_PRI, PRFS_PRR, 2, SVEAddrModeRegReg32>;
  defm : sve_prefetch<int_aarch64_sve_prf, nxv2i1,  PRFD_PRI, PRFD_PRR, 3, SVEAddrModeRegReg64>;

  // sve_mem_32b_prfm_sv
  // GPRF_S_UXTW_SCALED, GPRF_S_SXTW_SCALED
  defm PRFB_S : sve_mem_32b_prfm_sv_scaled<0b00, "prfb", AArch64prf_gather_s_sxtw_scaled, AArch64prf_gather_s_uxtw_scaled, ZPR32ExtSXTW8,  ZPR32ExtUXTW8 , i8>;
  defm PRFH_S : sve_mem_32b_prfm_sv_scaled<0b01, "prfh", AArch64prf_gather_s_sxtw_scaled, AArch64prf_gather_s_uxtw_scaled, ZPR32ExtSXTW16, ZPR32ExtUXTW16, i16>;
  defm PRFW_S : sve_mem_32b_prfm_sv_scaled<0b10, "prfw", AArch64prf_gather_s_sxtw_scaled, AArch64prf_gather_s_uxtw_scaled, ZPR32ExtSXTW32, ZPR32ExtUXTW32, i32>;
  defm PRFD_S : sve_mem_32b_prfm_sv_scaled<0b11, "prfd", AArch64prf_gather_s_sxtw_scaled, AArch64prf_gather_s_uxtw_scaled, ZPR32ExtSXTW64, ZPR32ExtUXTW64, i64>;

  // sve_mem_64b_prfm_sv
  // GPRF_D_UXTW_SCALED, GPRF_D_SXTW_SCALED
  defm PRFB_D : sve_mem_64b_prfm_sv_scaled<0b00, "prfb", AArch64prf_gather_d_sxtw_scaled, AArch64prf_gather_d_uxtw_scaled, ZPR64ExtSXTW8, ZPR64ExtUXTW8, i8>;
  defm PRFH_D : sve_mem_64b_prfm_sv_scaled<0b01, "prfh", AArch64prf_gather_d_sxtw_scaled, AArch64prf_gather_d_uxtw_scaled, ZPR64ExtSXTW16, ZPR64ExtUXTW16, i16>;
  defm PRFW_D : sve_mem_64b_prfm_sv_scaled<0b10, "prfw", AArch64prf_gather_d_sxtw_scaled, AArch64prf_gather_d_uxtw_scaled, ZPR64ExtSXTW32, ZPR64ExtUXTW32, i32>;
  defm PRFD_D : sve_mem_64b_prfm_sv_scaled<0b11, "prfd", AArch64prf_gather_d_sxtw_scaled, AArch64prf_gather_d_uxtw_scaled, ZPR64ExtSXTW64, ZPR64ExtUXTW64, i64>;

  // sve_mem_64b_prfm_sv2
  // GPRF_D_SCALED
  defm PRFB_D_SCALED : sve_mem_64b_prfm_sv2_vt<0b00, "prfb", AArch64prf_gather_d_scaled, ZPR64ExtLSL8,  i8>;
  defm PRFH_D_SCALED : sve_mem_64b_prfm_sv2_vt<0b01, "prfh", AArch64prf_gather_d_scaled, ZPR64ExtLSL16, i16>;
  defm PRFW_D_SCALED : sve_mem_64b_prfm_sv2_vt<0b10, "prfw", AArch64prf_gather_d_scaled, ZPR64ExtLSL32, i32>;
  defm PRFD_D_SCALED : sve_mem_64b_prfm_sv2_vt<0b11, "prfd", AArch64prf_gather_d_scaled, ZPR64ExtLSL64, i64>;

  // sve_mem_64b_prfm_vi
  // GPRF_S_IMM
  // GPRF_D_IMM
  defm PRFB_S_PZI : sve_mem_32b_prfm_vi<0b00, "prfb", imm0_31, AArch64prf_gather_s_imm, i8>;
  defm PRFH_S_PZI : sve_mem_32b_prfm_vi<0b01, "prfh", uimm5s2, AArch64prf_gather_s_imm, i16>;
  defm PRFW_S_PZI : sve_mem_32b_prfm_vi<0b10, "prfw", uimm5s4, AArch64prf_gather_s_imm, i32>;
  defm PRFD_S_PZI : sve_mem_32b_prfm_vi<0b11, "prfd", uimm5s8, AArch64prf_gather_s_imm, i64>;

  defm PRFB_D_PZI : sve_mem_64b_prfm_vi<0b00, "prfb", imm0_31, AArch64prf_gather_d_imm, i8>;
  defm PRFH_D_PZI : sve_mem_64b_prfm_vi<0b01, "prfh", uimm5s2, AArch64prf_gather_d_imm, i16>;
  defm PRFW_D_PZI : sve_mem_64b_prfm_vi<0b10, "prfw", uimm5s4, AArch64prf_gather_d_imm, i32>;
  defm PRFD_D_PZI : sve_mem_64b_prfm_vi<0b11, "prfd", uimm5s8, AArch64prf_gather_d_imm, i64>;

  defm LDNT1B_ZRI : sve_mem_cldnt_si<0b00, "ldnt1b", Z_b, ZPR8>;
  defm LDNT1H_ZRI : sve_mem_cldnt_si<0b01, "ldnt1h", Z_h, ZPR16>;
  defm LDNT1W_ZRI : sve_mem_cldnt_si<0b10, "ldnt1w", Z_s, ZPR32>;
  defm LDNT1D_ZRI : sve_mem_cldnt_si<0b11, "ldnt1d", Z_d, ZPR64>;

  defm LDNT1B_ZRR : sve_mem_cldnt_ss<0b001, "ldnt1b", Z_b, ZPR8,  GPR64NoXZRshifted8>;
  defm LDNT1H_ZRR : sve_mem_cldnt_ss<0b011, "ldnt1h", Z_h, ZPR16, GPR64NoXZRshifted16>;
  defm LDNT1W_ZRR : sve_mem_cldnt_ss<0b101, "ldnt1w", Z_s, ZPR32, GPR64NoXZRshifted32>;
  defm LDNT1D_ZRR : sve_mem_cldnt_ss<0b111, "ldnt1d", Z_d, ZPR64, GPR64NoXZRshifted64>;

  defm STNT1B_ZRI : sve_mem_cstnt_si<0b00, "stnt1b", Z_b, ZPR8>;
  defm STNT1H_ZRI : sve_mem_cstnt_si<0b01, "stnt1h", Z_h, ZPR16>;
  defm STNT1W_ZRI : sve_mem_cstnt_si<0b10, "stnt1w", Z_s, ZPR32>;
  defm STNT1D_ZRI : sve_mem_cstnt_si<0b11, "stnt1d", Z_d, ZPR64>;

  defm STNT1B_ZRR : sve_mem_cstnt_ss<0b001, "stnt1b", Z_b, ZPR8, GPR64NoXZRshifted8>;
  defm STNT1H_ZRR : sve_mem_cstnt_ss<0b011, "stnt1h", Z_h, ZPR16, GPR64NoXZRshifted16>;
  defm STNT1W_ZRR : sve_mem_cstnt_ss<0b101, "stnt1w", Z_s, ZPR32, GPR64NoXZRshifted32>;
  defm STNT1D_ZRR : sve_mem_cstnt_ss<0b111, "stnt1d", Z_d, ZPR64, GPR64NoXZRshifted64>;

  defm : pred_load<nxv16i8, nxv16i1, AArch64ldnt1, LDNT1B_ZRR, LDNT1B_ZRI, SVEAddrModeRegReg8>;
  defm : pred_load<nxv8i16,  nxv8i1, AArch64ldnt1, LDNT1H_ZRR, LDNT1H_ZRI, SVEAddrModeRegReg16>;
  defm : pred_load<nxv4i32,  nxv4i1, AArch64ldnt1, LDNT1W_ZRR, LDNT1W_ZRI, SVEAddrModeRegReg32>;
  defm : pred_load<nxv2i64,  nxv2i1, AArch64ldnt1, LDNT1D_ZRR, LDNT1D_ZRI, SVEAddrModeRegReg64>;

  defm : pred_store<nxv16i8, nxv16i1, AArch64stnt1, STNT1B_ZRR, STNT1B_ZRI, SVEAddrModeRegReg8>;
  defm : pred_store<nxv8i16,  nxv8i1, AArch64stnt1, STNT1H_ZRR, STNT1H_ZRI, SVEAddrModeRegReg16>;
  defm : pred_store<nxv4i32,  nxv4i1, AArch64stnt1, STNT1W_ZRR, STNT1W_ZRI, SVEAddrModeRegReg32>;
  defm : pred_store<nxv2i64,  nxv2i1, AArch64stnt1, STNT1D_ZRR, STNT1D_ZRI, SVEAddrModeRegReg64>;

  def : InstAlias<"cmple $Zd, $Pg/z, $Zm, $Zn",
                  (CMPGE_PPzZZ_B PPR8:$Zd, PPR3bAny:$Pg, ZPR8:$Zn, ZPR8:$Zm), 0>;
  def : InstAlias<"cmple $Zd, $Pg/z, $Zm, $Zn",
                  (CMPGE_PPzZZ_H PPR16:$Zd, PPR3bAny:$Pg, ZPR16:$Zn, ZPR16:$Zm), 0>;
  def : InstAlias<"cmple $Zd, $Pg/z, $Zm, $Zn",
                  (CMPGE_PPzZZ_S PPR32:$Zd, PPR3bAny:$Pg, ZPR32:$Zn, ZPR32:$Zm), 0>;
  def : InstAlias<"cmple $Zd, $Pg/z, $Zm, $Zn",
                  (CMPGE_PPzZZ_D PPR64:$Zd, PPR3bAny:$Pg, ZPR64:$Zn, ZPR64:$Zm), 0>;

  def : InstAlias<"cmplo $Zd, $Pg/z, $Zm, $Zn",
                  (CMPHI_PPzZZ_B PPR8:$Zd, PPR3bAny:$Pg, ZPR8:$Zn, ZPR8:$Zm), 0>;
  def : InstAlias<"cmplo $Zd, $Pg/z, $Zm, $Zn",
                  (CMPHI_PPzZZ_H PPR16:$Zd, PPR3bAny:$Pg, ZPR16:$Zn, ZPR16:$Zm), 0>;
  def : InstAlias<"cmplo $Zd, $Pg/z, $Zm, $Zn",
                  (CMPHI_PPzZZ_S PPR32:$Zd, PPR3bAny:$Pg, ZPR32:$Zn, ZPR32:$Zm), 0>;
  def : InstAlias<"cmplo $Zd, $Pg/z, $Zm, $Zn",
                  (CMPHI_PPzZZ_D PPR64:$Zd, PPR3bAny:$Pg, ZPR64:$Zn, ZPR64:$Zm), 0>;

  def : InstAlias<"cmpls $Zd, $Pg/z, $Zm, $Zn",
                  (CMPHS_PPzZZ_B PPR8:$Zd, PPR3bAny:$Pg, ZPR8:$Zn, ZPR8:$Zm), 0>;
  def : InstAlias<"cmpls $Zd, $Pg/z, $Zm, $Zn",
                  (CMPHS_PPzZZ_H PPR16:$Zd, PPR3bAny:$Pg, ZPR16:$Zn, ZPR16:$Zm), 0>;
  def : InstAlias<"cmpls $Zd, $Pg/z, $Zm, $Zn",
                  (CMPHS_PPzZZ_S PPR32:$Zd, PPR3bAny:$Pg, ZPR32:$Zn, ZPR32:$Zm), 0>;
  def : InstAlias<"cmpls $Zd, $Pg/z, $Zm, $Zn",
                  (CMPHS_PPzZZ_D PPR64:$Zd, PPR3bAny:$Pg, ZPR64:$Zn, ZPR64:$Zm), 0>;

  def : InstAlias<"cmplt $Zd, $Pg/z, $Zm, $Zn",
                  (CMPGT_PPzZZ_B PPR8:$Zd, PPR3bAny:$Pg, ZPR8:$Zn, ZPR8:$Zm), 0>;
  def : InstAlias<"cmplt $Zd, $Pg/z, $Zm, $Zn",
                  (CMPGT_PPzZZ_H PPR16:$Zd, PPR3bAny:$Pg, ZPR16:$Zn, ZPR16:$Zm), 0>;
  def : InstAlias<"cmplt $Zd, $Pg/z, $Zm, $Zn",
                  (CMPGT_PPzZZ_S PPR32:$Zd, PPR3bAny:$Pg, ZPR32:$Zn, ZPR32:$Zm), 0>;
  def : InstAlias<"cmplt $Zd, $Pg/z, $Zm, $Zn",
                  (CMPGT_PPzZZ_D PPR64:$Zd, PPR3bAny:$Pg, ZPR64:$Zn, ZPR64:$Zm), 0>;

  def : InstAlias<"mov $Zd, $Zn",
                  (ORR_ZZZ ZPR64:$Zd, ZPR64:$Zn, ZPR64:$Zn), 1>;

  def : InstAlias<"mov $Pd, $Pn",
                  (ORR_PPzPP PPR8:$Pd, PPR8:$Pn, PPR8:$Pn, PPR8:$Pn), 1>;
  def : InstAlias<"mov $Pd, $Pg/z, $Pn",
                  (AND_PPzPP PPR8:$Pd, PPRAny:$Pg, PPR8:$Pn, PPR8:$Pn), 1>;
  def : InstAlias<"mov $Pd, $Pg/m, $Pn",
                  (SEL_PPPP PPR8:$Pd, PPRAny:$Pg, PPR8:$Pn, PPR8:$Pd), 1>;

  def : InstAlias<"movs $Pd, $Pn",
                  (ORRS_PPzPP PPR8:$Pd, PPR8:$Pn, PPR8:$Pn, PPR8:$Pn), 1>;
  def : InstAlias<"movs $Pd, $Pg/z, $Pn",
                  (ANDS_PPzPP PPR8:$Pd, PPRAny:$Pg, PPR8:$Pn, PPR8:$Pn), 1>;

  def : InstAlias<"not $Pd, $Pg/z, $Pn",
                  (EOR_PPzPP PPR8:$Pd, PPRAny:$Pg, PPR8:$Pn, PPRAny:$Pg), 1>;

  def : InstAlias<"nots $Pd, $Pg/z, $Pn",
                  (EORS_PPzPP PPR8:$Pd, PPRAny:$Pg, PPR8:$Pn, PPRAny:$Pg), 1>;

  def : InstAlias<"facle $Zd, $Pg/z, $Zm, $Zn",
                  (FACGE_PPzZZ_H PPR16:$Zd, PPR3bAny:$Pg, ZPR16:$Zn, ZPR16:$Zm), 0>;
  def : InstAlias<"facle $Zd, $Pg/z, $Zm, $Zn",
                  (FACGE_PPzZZ_S PPR32:$Zd, PPR3bAny:$Pg, ZPR32:$Zn, ZPR32:$Zm), 0>;
  def : InstAlias<"facle $Zd, $Pg/z, $Zm, $Zn",
                  (FACGE_PPzZZ_D PPR64:$Zd, PPR3bAny:$Pg, ZPR64:$Zn, ZPR64:$Zm), 0>;

  def : InstAlias<"faclt $Zd, $Pg/z, $Zm, $Zn",
                  (FACGT_PPzZZ_H PPR16:$Zd, PPR3bAny:$Pg, ZPR16:$Zn, ZPR16:$Zm), 0>;
  def : InstAlias<"faclt $Zd, $Pg/z, $Zm, $Zn",
                  (FACGT_PPzZZ_S PPR32:$Zd, PPR3bAny:$Pg, ZPR32:$Zn, ZPR32:$Zm), 0>;
  def : InstAlias<"faclt $Zd, $Pg/z, $Zm, $Zn",
                  (FACGT_PPzZZ_D PPR64:$Zd, PPR3bAny:$Pg, ZPR64:$Zn, ZPR64:$Zm), 0>;

  def : InstAlias<"fcmle $Zd, $Pg/z, $Zm, $Zn",
                  (FCMGE_PPzZZ_H PPR16:$Zd, PPR3bAny:$Pg, ZPR16:$Zn, ZPR16:$Zm), 0>;
  def : InstAlias<"fcmle $Zd, $Pg/z, $Zm, $Zn",
                  (FCMGE_PPzZZ_S PPR32:$Zd, PPR3bAny:$Pg, ZPR32:$Zn, ZPR32:$Zm), 0>;
  def : InstAlias<"fcmle $Zd, $Pg/z, $Zm, $Zn",
                  (FCMGE_PPzZZ_D PPR64:$Zd, PPR3bAny:$Pg, ZPR64:$Zn, ZPR64:$Zm), 0>;

  def : InstAlias<"fcmlt $Zd, $Pg/z, $Zm, $Zn",
                  (FCMGT_PPzZZ_H PPR16:$Zd, PPR3bAny:$Pg, ZPR16:$Zn, ZPR16:$Zm), 0>;
  def : InstAlias<"fcmlt $Zd, $Pg/z, $Zm, $Zn",
                  (FCMGT_PPzZZ_S PPR32:$Zd, PPR3bAny:$Pg, ZPR32:$Zn, ZPR32:$Zm), 0>;
  def : InstAlias<"fcmlt $Zd, $Pg/z, $Zm, $Zn",
                  (FCMGT_PPzZZ_D PPR64:$Zd, PPR3bAny:$Pg, ZPR64:$Zn, ZPR64:$Zm), 0>;

} // Predicates = [HasSVE]
