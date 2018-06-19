//=- SVEInstrFormats.td -  AArch64 SVE Instructions -*- tablegen -*----------=//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// AArch64 Scalable Vector Extension (SVE) Instruction Binary Formats
//
//===----------------------------------------------------------------------===//

def MulImm4Operand : AsmOperandClass {
  let Name = "MulImm4";
  let DiagnosticType = "InvalidImm1_16";
  let DiagnosticPredicate = DP_IsImm;
  let ParserMethod = "tryParseMulImm4";
  let PredicateMethod = "isImmInRange<1,16>";
  let RenderMethod = "addImmOperands";
}

def sve_incdec_imm : Operand<i32>, ImmLeaf<i32, [{
    return (((uint32_t)Imm) > 0) && (((uint32_t)Imm) < 17);
  }]> {

  let EncoderMethod = "getSVEIncDecImm";
  let DecoderMethod = "DecodeSVEIncDecImm";
  let PrintMethod = "printMulImm4";
  let ParserMatchClass = MulImm4Operand;
}

def SVENamedFPImmOperandHalfOne : AsmOperandClass {
  let Name = "SVENamedFPImmOperandHalfOne";
  let ParserMethod = "tryParseNamedFPImm<AArch64NamedFPImm::half,"
                                        "AArch64NamedFPImm::one>";
  let PredicateMethod = "isImm";
  let RenderMethod = "addImmOperands";
}

def sve_fpimm_half_one : Operand<i32> {
  let PrintMethod = "printNamedFPImm<AArch64NamedFPImm::half,"
                                    "AArch64NamedFPImm::one>";
  let ParserMatchClass = SVENamedFPImmOperandHalfOne;
}

def SVENamedFPImmOperandHalfTwo : AsmOperandClass {
  let Name = "SVENamedFPImmOperandHalfTwo";
  let ParserMethod = "tryParseNamedFPImm<AArch64NamedFPImm::half,"
                                        "AArch64NamedFPImm::two>";
  let PredicateMethod = "isImm";
  let RenderMethod = "addImmOperands";
}

def sve_fpimm_half_two : Operand<i32> {
  let PrintMethod = "printNamedFPImm<AArch64NamedFPImm::half,"
                                    "AArch64NamedFPImm::two>";
  let ParserMatchClass = SVENamedFPImmOperandHalfTwo;
}

def SVENamedFPImmOperandZeroOne : AsmOperandClass {
  let Name = "SVENamedFPImmOperandZeroOne";
  let ParserMethod = "tryParseNamedFPImm<AArch64NamedFPImm::zero,"
                                        "AArch64NamedFPImm::one>";
  let PredicateMethod = "isImm";
  let RenderMethod = "addImmOperands";
}

def sve_fpimm_zero_one : Operand<i32> {
  let PrintMethod = "printNamedFPImm<AArch64NamedFPImm::zero,"
                                    "AArch64NamedFPImm::one>";
  let ParserMatchClass = SVENamedFPImmOperandZeroOne;
}

def SVEPatternOperand : AsmOperandClass {
  let Name = "SVEPattern";
  let ParserMethod = "tryParseSVEPattern";
  let PredicateMethod = "isSVEPattern";
  let RenderMethod = "addImmOperands";
}

def sve_pred_enum : Operand<i32>, ImmLeaf<i32, [{
  return (((uint32_t)Imm) < 32);
  }]> {

  let PrintMethod = "printSVEPattern";
  let ParserMatchClass = SVEPatternOperand;
}

def SVECpyImmOperand : AsmOperandClass {
  let Name = "SVECpyImm";
  let DiagnosticType = "DupCpyImm8Operand";
  let DiagnosticPredicate = DP_IsImm;
  let RenderMethod = "addAddSubImmOperands<8>";
  let ParserMethod = "tryParseAddSubImm";
  let PredicateMethod = "isSVECpyImm";
}

def SVECpyImmByteOperand : AsmOperandClass {
  let Name = "SVECpyImmByte";
  let DiagnosticType = "DupCpyByteImm8Operand";
  let DiagnosticPredicate = DP_IsImm;
  let RenderMethod = "addAddSubImmOperands<8>";
  let ParserMethod = "tryParseAddSubImm";
  let PredicateMethod = "isSVECpyImmByte";
}

class simm8_opt_lsl<int Width, ValueType Ty, Operand Op>
: Operand<Ty>, ImmLeaf<Ty, [{
    return AArch64_AM::isSVECpyImm(Imm);
  }]> {

  let DecoderMethod = "DecodeSImm8OptLsl";
  let EncoderMethod = "getSImm8OptLsl";
  let PrintMethod = "printImm8OptLsl<int" # Width # "_t>";
  let ParserMatchClass = SVECpyImmOperand;
  let MIOperandInfo = (ops Op, Op);
}
def simm8_opt_lsl_i16 : simm8_opt_lsl<16, i32, i32imm>;
def simm8_opt_lsl_i32 : simm8_opt_lsl<32, i32, i32imm>;
def simm8_opt_lsl_i64 : simm8_opt_lsl<64, i64, i64imm>;

// A special case for bytes as they support a slightly different immedite range.
def simm8_opt_lsl_i8 : Operand<i32>, ImmLeaf<i32, [{
    return AArch64_AM::isSVECpyImmByte(Imm);
  }]> {

  let DecoderMethod = "DecodeSImm8OptLslByte";
  let EncoderMethod = "getSImm8OptLsl";
  let PrintMethod = "printImm8OptLsl<int8_t>";
  let ParserMatchClass = SVECpyImmByteOperand;
  let MIOperandInfo = (ops i32imm, i32imm);
}

def AddSubImm8Operand : AddSubImmOperand<8> {
  let DiagnosticType = "AddSubImm8Operand";
  let DiagnosticPredicate = DP_IsConstantImm;
}

class uimm8_opt_lsl<int Width>
: Operand<i32>, ImmLeaf<i32, [{
    return ((uint8_t)Imm == Imm) || ((uint16_t)(Imm & ~0xff) == Imm);
  }]> {

  let DecoderMethod = "DecodeUImm8OptLsl";
  let EncoderMethod = "getAddSubImmOpValue";
  let PrintMethod = "printImm8OptLsl<uint" # Width # "_t>";
  let ParserMatchClass = AddSubImm8Operand;
  let MIOperandInfo = (ops i32imm, i32imm);
}
def uimm8_opt_lsl_i16 : uimm8_opt_lsl<16>;
def uimm8_opt_lsl_i32 : uimm8_opt_lsl<32>;
def uimm8_opt_lsl_i64 : uimm8_opt_lsl<64>;

def uimm8_opt_lsl_i8 : Operand<i32>, ImmLeaf<i32, [{
    return ((uint8_t)Imm == Imm) || ((uint16_t)(Imm & ~0xff) == Imm);
  }]> {

  let DecoderMethod = "DecodeUImm8OptLslByte";
  let EncoderMethod = "getAddSubImmOpValue";
  let PrintMethod = "printImm8OptLsl<uint8_t>";
  let ParserMatchClass = AddSubImm8Operand;
  let MIOperandInfo = (ops i32imm, i32imm);
}

// TODO: As part of a later clean-up we can probably unify these with some
// pre-existing signed immediate classes in AArch64InstrFormats.td. I have left
// these alone for now until we have a clearer idea of what needs doing.
class SImmMulVlOperand<int Bits, int Scale> : AsmOperandClass {
  let Name = "SImm" # Bits # "Scale" # Scale # "MulVl";
  let DiagnosticType = "InvalidMemoryIndexed" # Scale # "SImm" # Bits;
  let PredicateMethod = "isSImmScaled<" # Bits # ", " # Scale # ">";
  let RenderMethod = "addImmScaledOperands<" # Scale # ">";
}

def SImm4MulVlOperand : SImmMulVlOperand<4,1>;
def SImm6MulVlOperand : SImmMulVlOperand<6,1>;
def SImm9MulVlOperand : SImmMulVlOperand<9,1>;
def SImm4Scale2MulVlOperand : SImmMulVlOperand<4,2>;
def SImm4Scale3MulVlOperand : SImmMulVlOperand<4,3>;
def SImm4Scale4MulVlOperand : SImmMulVlOperand<4,4>;

def simm4MulVl : Operand<i64>, ImmLeaf<i64, [{ return Imm >= -8 && Imm < 8; }]> {
  let DecoderMethod = "DecodeSImm<4>";
  let ParserMatchClass = SImm4MulVlOperand;
}

def simm6MulVl : Operand<i64>, ImmLeaf<i64, [{ return Imm >= -32 && Imm < 32; }]> {
  let DecoderMethod = "DecodeSImm<6>";
  let ParserMatchClass = SImm6MulVlOperand;
}

def simm9MulVl : Operand<i64>, ImmLeaf<i64, [{ return Imm >= -256 && Imm < 256; }]> {
  let DecoderMethod = "DecodeSImm<9>";
  let ParserMatchClass = SImm9MulVlOperand;
}

def simm4Scale2MulVl : Operand<i64>, ImmLeaf<i64, [{
    return (Imm >= -16 && Imm <= 14) && ((Imm % 2) == 0x0);
  }]> {
  let DecoderMethod = "DecodeSImm<4>";
  let PrintMethod = "printImmScale<2>";
  let ParserMatchClass = SImm4Scale2MulVlOperand;
}

def simm4Scale3MulVl : Operand<i64>, ImmLeaf<i64, [{
    return (Imm >= -24 && Imm <= 21) && ((Imm % 3) == 0x0);
  }]> {
  let DecoderMethod = "DecodeSImm<4>";
  let PrintMethod = "printImmScale<3>";
  let ParserMatchClass = SImm4Scale3MulVlOperand;
}

def simm4Scale4MulVl : Operand<i64>, ImmLeaf<i64, [{
    return (Imm >= -32 && Imm <= 28) && ((Imm % 4) == 0x0);
  }]> {
  let DecoderMethod = "DecodeSImm<4>";
  let PrintMethod = "printImmScale<4>";
  let ParserMatchClass = SImm4Scale4MulVlOperand;
}

//===----------------------------------------------------------------------===//

def DP_IsVectorIndex : DiagnosticPredicateClass<[{Operand.isVectorIndex()}]>;

// SVE Vector lane operands
class SVEVectorIndex<string Suffix> : AsmOperandClass {
  let Name = "SVEVectorIndex" # Suffix;
  let DiagnosticType = "InvalidSVEVectorIndex" # Suffix;
  let DiagnosticPredicate = DP_IsVectorIndex;
  let RenderMethod = "addVectorIndex";
}

def SVEVectorIndexDOperand : SVEVectorIndex<"D">;
def SVEVectorIndexSOperand : SVEVectorIndex<"S">;
def SVEVectorIndexHOperand : SVEVectorIndex<"H">;

def sve_elm_idx_h : Operand<i32>, ImmLeaf<i32, [{
    return ((uint32_t)Imm) < 8;
  }]> {
  let ParserMatchClass = SVEVectorIndexHOperand;
  let PrintMethod = "printVectorIndex";
}

def sve_elm_idx_s : Operand<i32>, ImmLeaf<i32, [{
    return ((uint32_t)Imm) < 4;
  }]> {
  let ParserMatchClass = SVEVectorIndexSOperand;
  let PrintMethod = "printVectorIndex";
}

def sve_elm_idx_d : Operand<i32>, ImmLeaf<i32, [{
    return ((uint32_t)Imm) < 2;
  }]> {
  let ParserMatchClass = SVEVectorIndexDOperand;
  let PrintMethod = "printVectorIndex";
}

def SVEVectorIndexExtDupBOperand : SVEVectorIndex<"ExtDupB">;
def SVEVectorIndexExtDupHOperand : SVEVectorIndex<"ExtDupH">;
def SVEVectorIndexExtDupSOperand : SVEVectorIndex<"ExtDupS">;
def SVEVectorIndexExtDupDOperand : SVEVectorIndex<"ExtDupD">;
def SVEVectorIndexExtDupQOperand : SVEVectorIndex<"ExtDupQ">;

def sve_elm_idx_extdup_b : Operand<i64>, ImmLeaf<i64, [{
    return ((uint64_t)Imm) < 64;
  }]> {
  let ParserMatchClass = SVEVectorIndexExtDupBOperand;
  let PrintMethod = "printVectorIndex";
}

def sve_elm_idx_extdup_h : Operand<i64>, ImmLeaf<i64, [{
    return ((uint64_t)Imm) < 32;
  }]> {
  let ParserMatchClass = SVEVectorIndexExtDupHOperand;
  let PrintMethod = "printVectorIndex";
}

def sve_elm_idx_extdup_s : Operand<i64>, ImmLeaf<i64, [{
    return ((uint64_t)Imm) < 16;
  }]> {
  let ParserMatchClass = SVEVectorIndexExtDupSOperand;
  let PrintMethod = "printVectorIndex";
}

def sve_elm_idx_extdup_d : Operand<i64>, ImmLeaf<i64, [{
    return ((uint64_t)Imm) < 8;
  }]> {
  let ParserMatchClass = SVEVectorIndexExtDupDOperand;
  let PrintMethod = "printVectorIndex";
}

def sve_elm_idx_extdup_q : Operand<i64>, ImmLeaf<i64, [{
    return ((uint64_t)Imm) < 4;
  }]> {
  let ParserMatchClass = SVEVectorIndexExtDupQOperand;
  let PrintMethod = "printVectorIndex";
}
//===----------------------------------------------------------------------===//

def SVEPrefetchOperand : AsmOperandClass {
  let Name = "SVEPrefetch";
  let ParserMethod = "tryParseSVEPrefetch";
}

def sve_prfop : Operand<i32>, ImmLeaf<i32, [{
    return (((uint32_t)Imm) <= 15);
  }]> {
  let PrintMethod = "printSVEPrefetchOp";
  let ParserMatchClass = SVEPrefetchOperand;
}
//===----------------------------------------------------------------------===//

class SVELogicalImmOperand<int Width> : AsmOperandClass {
  let Name = "SVELogicalImm" # Width;
  let DiagnosticType = "LogicalSecondSource";
  let DiagnosticPredicate = DP_IsImm;
  let PredicateMethod = "isLogicalImm<int" # Width # "_t>";
  let RenderMethod = "addLogicalImmOperands<int" # Width # "_t>";
}

def sve_logical_imm8 : Operand<i64> {
  let ParserMatchClass = SVELogicalImmOperand<8>;
  let PrintMethod = "printLogicalImm<int8_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int8_t>(Val);
  }];
}

def sve_logical_imm16 : Operand<i64> {
  let ParserMatchClass = SVELogicalImmOperand<16>;
  let PrintMethod = "printLogicalImm<int16_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int16_t>(Val);
  }];
}

def sve_logical_imm32 : Operand<i64> {
  let ParserMatchClass = SVELogicalImmOperand<32>;
  let PrintMethod = "printLogicalImm<int32_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int32_t>(Val);
  }];
}

//===----------------------------------------------------------------------===//

class SVELogicalImmNotOperand<int Width> : AsmOperandClass {
  let Name = "SVELogicalImm" # Width # "Not";
  let DiagnosticType = "LogicalSecondSource";
  let DiagnosticPredicate = DP_IsImm;
  let PredicateMethod = "isLogicalImm<int" # Width # "_t>";
  let RenderMethod = "addLogicalImmNotOperands<int" # Width # "_t>";
}

def sve_logical_imm8_not : Operand<i64> {
  let ParserMatchClass = SVELogicalImmNotOperand<8>;
}

def sve_logical_imm16_not : Operand<i64> {
  let ParserMatchClass = SVELogicalImmNotOperand<16>;
}

def sve_logical_imm32_not : Operand<i64> {
  let ParserMatchClass = SVELogicalImmNotOperand<32>;
}

//===----------------------------------------------------------------------===//

class SVEPreferredLogicalImmOperand<int Width> : AsmOperandClass {
  let Name = "SVEPreferredLogicalImm" # Width;
  let PredicateMethod = "isSVEPreferredLogicalImm<int" # Width # "_t>";
  let RenderMethod = "addLogicalImmOperands<int" # Width # "_t>";
}

def sve_preferred_logical_imm16 : Operand<i64> {
  let ParserMatchClass = SVEPreferredLogicalImmOperand<16>;
  let PrintMethod = "printSVELogicalImm<int16_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int16_t>(Val) &&
           AArch64_AM::isSVEMoveMaskPreferredLogicalImmediate(Val);
  }];
}

def sve_preferred_logical_imm32 : Operand<i64> {
  let ParserMatchClass =  SVEPreferredLogicalImmOperand<32>;
  let PrintMethod = "printSVELogicalImm<int32_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int32_t>(Val) &&
           AArch64_AM::isSVEMoveMaskPreferredLogicalImmediate(Val);
  }];
}

def sve_preferred_logical_imm64 : Operand<i64> {
  let ParserMatchClass = SVEPreferredLogicalImmOperand<64>;
  let PrintMethod = "printSVELogicalImm<int64_t>";

  let MCOperandPredicate = [{
    if (!MCOp.isImm())
      return false;
    int64_t Val = AArch64_AM::decodeLogicalImmediate(MCOp.getImm(), 64);
    return AArch64_AM::isSVEMaskOfIdenticalElements<int64_t>(Val) &&
           AArch64_AM::isSVEMoveMaskPreferredLogicalImmediate(Val);
  }];
}

//===----------------------------------------------------------------------===//
def DP_AArch64IsFPImm : DiagnosticPredicateClass<[{Operand.isFPImm()}]>;

// 8-bit floating-point immediate encodings.
def SVEFPImm8Operand : AsmOperandClass {
  let Name = "SVEFPImm8";
  let DiagnosticType = "InvalidFPImm";
  let DiagnosticPredicate = DP_AArch64IsFPImm;
  let ParserMethod = "tryParseFPImm";
  let RenderMethod = "addFPImmOperands";
}

def sve_fpimm16 : Operand<f16>,
                  PatLeaf<(f16 fpimm), [{
      return AArch64_AM::getFP16Imm(N->getValueAPF()) != -1;
    }], SDNodeXForm<fpimm, [{
      APFloat InVal = N->getValueAPF();
      uint32_t enc = AArch64_AM::getFP16Imm(InVal);
      return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i32);
    }]>> {
  let ParserMatchClass = SVEFPImm8Operand;
  let PrintMethod = "printFPImmOperand";
}

def sve_fpimm32 : Operand<f32>,
                  PatLeaf<(f32 fpimm), [{
      return AArch64_AM::getFP32Imm(N->getValueAPF()) != -1;
    }], SDNodeXForm<fpimm, [{
      APFloat InVal = N->getValueAPF();
      uint32_t enc = AArch64_AM::getFP32Imm(InVal);
      return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i32);
    }]>> {
  let ParserMatchClass = SVEFPImm8Operand;
  let PrintMethod = "printFPImmOperand";
}

def sve_fpimm64 : Operand<f64>,
              PatLeaf<(f64 fpimm), [{
      return AArch64_AM::getFP64Imm(N->getValueAPF()) != -1;
    }], SDNodeXForm<fpimm, [{
      APFloat InVal = N->getValueAPF();
      uint32_t enc = AArch64_AM::getFP64Imm(InVal);
      return CurDAG->getTargetConstant(enc, SDLoc(N), MVT::i32);
    }]>> {
  let ParserMatchClass = SVEFPImm8Operand;
  let PrintMethod = "printFPImmOperand";
}

// #0.0
def SVEFPImmZeroOperand : AsmOperandClass {
  let Name = "SVEFPImmZero";
  let DiagnosticType = "InvalidFPImm";
  let DiagnosticPredicate = DP_AArch64IsFPImm;
  let ParserMethod = "tryParseFPImm";
}

class _sve_fpzero<ValueType Ty> : Operand<Ty> {
  let ParserMatchClass = SVEFPImmZeroOperand;
  let PrintMethod = "printFPImmOperand";
}

def sve_fpzero : _sve_fpzero<i32>;
def sve_fpzero_f64 : _sve_fpzero<i64>;

//===----------------------------------------------------------------------===//
// SVE PTrue - These are used extensively throughout the pattern matching so
//             it's important we define them first.
//===----------------------------------------------------------------------===//

class sve_int_ptrue<bits<2> sz8_64, bits<3> opc, string asm, PPRRegOp pprty,
                    ValueType vt, SDPatternOperator op>
: I<(outs pprty:$Pd), (ins sve_pred_enum:$pattern),
  asm, "\t$Pd, $pattern",
  "",
  [(set (vt pprty:$Pd), (op sve_pred_enum:$pattern))]>, Sched<[]> {
  bits<4> Pd;
  bits<5> pattern;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b011;
  let Inst{18-17} = opc{2-1};
  let Inst{16}    = opc{0};
  let Inst{15-10} = 0b111000;
  let Inst{9-5}   = pattern;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pd;

  let Defs = !if(!eq (opc{0}, 1), [NZCV], []);
  let isReMaterializable = 1;
}

multiclass sve_int_ptrue<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_ptrue<0b00, opc, asm, PPR8, nxv16i1, op>;
  def _H : sve_int_ptrue<0b01, opc, asm, PPR16, nxv8i1, op>;
  def _S : sve_int_ptrue<0b10, opc, asm, PPR32, nxv4i1, op>;
  def _D : sve_int_ptrue<0b11, opc, asm, PPR64, nxv2i1, op>;

  def : InstAlias<asm # "\t$Pd",
                  (!cast<Instruction>(NAME # _B) PPR8:$Pd, 0b11111), 1>;
  def : InstAlias<asm # "\t$Pd",
                  (!cast<Instruction>(NAME # _H) PPR16:$Pd, 0b11111), 1>;
  def : InstAlias<asm # "\t$Pd",
                  (!cast<Instruction>(NAME # _S) PPR32:$Pd, 0b11111), 1>;
  def : InstAlias<asm # "\t$Pd",
                  (!cast<Instruction>(NAME # _D) PPR64:$Pd, 0b11111), 1>;
}

def SDT_AArch64PTrue : SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisVT<1, i32>]>;
def AArch64ptrue : SDNode<"AArch64ISD::PTRUE", SDT_AArch64PTrue>;

let Predicates = [HasSVE] in {
  defm PTRUE  : sve_int_ptrue<0b000, "ptrue", AArch64ptrue>;
  defm PTRUES : sve_int_ptrue<0b001, "ptrues", null_frag>;
}

//===----------------------------------------------------------------------===//
// SVE pattern match helpers.
//===----------------------------------------------------------------------===//

class SVE_1_Op_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                   Instruction inst>
: Pat<(vtd (op vt1:$Op1)),
      (inst $Op1)>;

class SVE_2_Op_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                   ValueType vt2, Instruction inst>
: Pat<(vtd (op vt1:$Op1, vt2:$Op2)),
      (inst $Op1, $Op2)>;

class SVE_3_Op_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                   ValueType vt2, ValueType vt3, Instruction inst>
: Pat<(vtd (op vt1:$Op1, vt2:$Op2, vt3:$Op3)),
      (inst $Op1, $Op2, $Op3)>;

class SVE_4_Op_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                   ValueType vt2, ValueType vt3, ValueType vt4,
                   Instruction inst>
: Pat<(vtd (op vt1:$Op1, vt2:$Op2, vt3:$Op3, vt4:$Op4)),
      (inst $Op1, $Op2, $Op3, $Op4)>;

def SVEDup0 : ComplexPattern<i64, 0, "SelectDupZero", []>;
def SVEDup0Undef : ComplexPattern<i64, 0, "SelectDupZeroOrUndef", []>;

let AddedComplexity = 1 in {
class SVE_3_Op_Pat_SelZero<ValueType vtd, SDPatternOperator op, ValueType vt1,
                   ValueType vt2, ValueType vt3, Instruction inst>
: Pat<(vtd (vtd (op vt1:$Op1, (vselect vt1:$Op1, vt2:$Op2, (SVEDup0)), vt3:$Op3))),
      (inst $Op1, $Op2, $Op3)>;

class SVE_4_Op_Pat_SelZero<ValueType vtd, SDPatternOperator op, ValueType vt1,
                   ValueType vt2, ValueType vt3, ValueType vt4,
                   Instruction inst>
: Pat<(vtd (op vt1:$Op1, (vselect vt1:$Op1, vt2:$Op2, (SVEDup0)), vt3:$Op3, vt4:$Op4)),
      (inst $Op1, $Op2, $Op3, $Op4)>;
}

//
// Common but less generic patterns.
//

class SVE_1_Op_AllActive_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                             Instruction inst, Instruction ptrue>
: Pat<(vtd (op vt1:$Op1)),
      (inst (IMPLICIT_DEF), (ptrue 31), $Op1)>;

class SVE_2_Op_AllActive_Pat<ValueType vtd, SDPatternOperator op, ValueType vt1,
                             ValueType vt2, Instruction inst, Instruction ptrue>
: Pat<(vtd (op vt1:$Op1, vt2:$Op2)),
      (inst (ptrue 31), $Op1, $Op2)>;

//
// Instruction specific patterns.
//

class SVE_Cmp_Pat0<ValueType pt, ValueType vt, CondCode cc, Instruction inst,
                   Instruction ptrue>
: Pat<(pt (setcc vt:$Zn, vt:$Zm, cc)),
      (inst (ptrue 31), $Zn, $Zm)>;

class SVE_Cmp_Pat1<ValueType pt, ValueType vt, CondCode cc, Instruction inst>
: Pat<(pt (and pt:$Pg, (setcc vt:$Zn, vt:$Zm, cc))),
      (inst $Pg, $Zn, $Zm)>;

//
// Pseudo -> Instruction mappings
//
def getSVEPseudoMap : InstrMapping {
  let FilterClass = "SVEPseudo2Instr";
  let RowFields = ["PseudoName"];
  let ColFields = ["IsInstr"];
  let KeyCol = ["0"];
  let ValueCols = [["1"]];
}

class SVEPseudo2Instr<string name, bit instr> {
  string PseudoName = name;
  bit IsInstr = instr;
}

def getSVERevInstr : InstrMapping {
  let FilterClass = "SVEInstr2Rev";
  let RowFields = ["InstrName"];
  let ColFields = ["IsOrig"];
  let KeyCol = ["1"];
  let ValueCols = [["0"]];
}

def getSVEOrigInstr : InstrMapping {
  let FilterClass = "SVEInstr2Rev";
  let RowFields = ["InstrName"];
  let ColFields = ["IsOrig"];
  let KeyCol = ["0"];
  let ValueCols = [["1"]];
}

class SVEInstr2Rev<string name, string revname, bit nameIsOrig> {
  string InstrName = !if(nameIsOrig, name, revname);
  bit IsOrig = nameIsOrig;
}

//
// Pseudos for destructive operands
//
let hasNoSchedulingInfo = 1 in {
  class UnpredTwoOpImmPseudo<string name, ZPRRegOp zprty, Operand immty,
                             FalseLanesEnum flags = FalseLanesNone>
  : SVEPseudo2Instr<name, 0>,
    Pseudo<(outs zprty:$Zd), (ins zprty:$Zs1, immty:$imm), []> {
    let FalseLanes = flags;
  }

  class PredTwoOpImmPseudo<string name, ZPRRegOp zprty, Operand immty,
                           FalseLanesEnum flags = FalseLanesNone>
  : SVEPseudo2Instr<name, 0>,
    Pseudo<(outs zprty:$Zd), (ins PPR3bAny:$Pg, zprty:$Zs1, immty:$imm), []> {
    let FalseLanes = flags;
  }

  class PredTwoOpPseudo<string name, ZPRRegOp zprty,
                        FalseLanesEnum flags = FalseLanesNone>
  : SVEPseudo2Instr<name, 0>,
    Pseudo<(outs zprty:$Zd), (ins PPR3bAny:$Pg, zprty:$Zs1, zprty:$Zs2), []> {
    let FalseLanes = flags;
  }

  class PredTwoOpConstrainedPseudo<string name, ZPRRegOp zprty,
                                   FalseLanesEnum flags = FalseLanesNone>
  : SVEPseudo2Instr<name, 0>,
    Pseudo<(outs zprty:$Zd), (ins PPR3bAny:$Pg, zprty:$Zs1, zprty:$Zs2), []> {
    let Constraints = "$Zd = $Zs1";
    let FalseLanes = flags;
  }

  class PredThreeOpPseudo<string name, ZPRRegOp zprty,
                          FalseLanesEnum flags = FalseLanesNone>
  : SVEPseudo2Instr<name, 0>,
    Pseudo<(outs zprty:$Zd), (ins PPR3bAny:$Pg, zprty:$Zs1, zprty:$Zs2, zprty:$Zs3), []> {
    let FalseLanes = flags;
  }
}


//===----------------------------------------------------------------------===//
// SVE Floating Point Compare - with Zero Group
//===----------------------------------------------------------------------===//

class sve_fp_2op_p_pd<bits<2> sz, bits<3> opc, string asm, PPRRegOp pprty,
                      ZPRRegOp zprty>
: I<(outs pprty:$Pd), (ins PPR3bAny:$Pg, zprty:$Zn),
  asm, "\t$Pd, $Pg/z, $Zn, #0.0",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zn;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21-18} = 0b0100;
  let Inst{17-16} = opc{2-1};
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;
}

multiclass sve_fp_2op_p_pd<bits<3> opc, string asm,
                           SDPatternOperator int_op = null_frag,
                           SDPatternOperator ir_op = null_frag,
                           SDPatternOperator inv_int_op = null_frag,
                           SDPatternOperator inv_ir_op = null_frag> {
  def _H : sve_fp_2op_p_pd<0b01, opc, asm, PPR16, ZPR16>;
  def _S : sve_fp_2op_p_pd<0b10, opc, asm, PPR32, ZPR32>;
  def _D : sve_fp_2op_p_pd<0b11, opc, asm, PPR64, ZPR64>;

  // Intrinsics
  def : Pat<(nxv8i1 (int_op (nxv8i1 PPR_3b:$Pg),
                            (nxv8f16 ZPR:$Zs1),
                            (nxv8f16 (AArch64dup (f16 fpimm0))))),
            (!cast<Instruction>(NAME # "_H") PPR_3b:$Pg, ZPR:$Zs1)>;
  def : Pat<(nxv4i1 (int_op (nxv4i1 PPR_3b:$Pg),
                            (nxv4f32 ZPR:$Zs1),
                            (nxv4f32 (AArch64dup (f32 fpimm0))))),
            (!cast<Instruction>(NAME # "_S") PPR_3b:$Pg, ZPR:$Zs1)>;
  def : Pat<(nxv2i1 (int_op (nxv2i1 PPR_3b:$Pg),
                            (nxv2f64 ZPR:$Zs1),
                            (nxv2f64 (AArch64dup (f64 fpimm0))))),
            (!cast<Instruction>(NAME # "_D") PPR_3b:$Pg, ZPR:$Zs1)>;

  // IR
  def : Pat<(nxv8i1 (ir_op (nxv8f16 ZPR:$Zs1),
                           (nxv8f16 (AArch64dup (f16 fpimm0))))),
            (!cast<Instruction>(NAME # "_H") (PTRUE_H 31), ZPR:$Zs1)>;
  def : Pat<(nxv4i1 (ir_op (nxv4f32 ZPR:$Zs1),
                           (nxv4f32 (AArch64dup (f32 fpimm0))))),
            (!cast<Instruction>(NAME # "_S") (PTRUE_S 31), ZPR:$Zs1)>;
  def : Pat<(nxv2i1 (ir_op (nxv2f64 ZPR:$Zs1),
                           (nxv2f64 (AArch64dup (f64 fpimm0))))),
            (!cast<Instruction>(NAME # "_D") (PTRUE_D 31), ZPR:$Zs1)>;

  // Inverted Intrinsics (e.g. LT -> GE)
  def : Pat<(nxv8i1 (inv_int_op (nxv8i1 PPR_3b:$Pg),
                                (nxv8f16 (AArch64dup (f16 fpimm0))),
                                (nxv8f16 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_H") PPR_3b:$Pg, ZPR:$Zs1)>;
  def : Pat<(nxv4i1 (inv_int_op (nxv4i1 PPR_3b:$Pg),
                                (nxv4f32 (AArch64dup (f32 fpimm0))),
                                (nxv4f32 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_S") PPR_3b:$Pg, ZPR:$Zs1)>;
  def : Pat<(nxv2i1 (inv_int_op (nxv2i1 PPR_3b:$Pg),
                                (nxv2f64 (AArch64dup (f64 fpimm0))),
                                (nxv2f64 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_D") PPR_3b:$Pg, ZPR:$Zs1)>;

  // Inverted IR
  def : Pat<(nxv8i1 (inv_ir_op (nxv8f16 (AArch64dup (f16 fpimm0))),
                               (nxv8f16 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_H") (PTRUE_H 31), ZPR:$Zs1)>;
  def : Pat<(nxv4i1 (inv_ir_op (nxv4f32 (AArch64dup (f32 fpimm0))),
                               (nxv4f32 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_S") (PTRUE_S 31), ZPR:$Zs1)>;
  def : Pat<(nxv2i1 (inv_ir_op (nxv2f64 (AArch64dup (f64 fpimm0))),
                               (nxv2f64 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_D") (PTRUE_D 31), ZPR:$Zs1)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Misc - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_cons_misc_0_b<bits<2> sz, string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins zprty:$Zn, zprty:$Zm),
  asm, "\t$Zd, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-10} = 0b101100;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_bin_cons_misc_0_b<string asm, SDPatternOperator op> {
  def _H : sve_int_bin_cons_misc_0_b<0b01, asm, ZPR16>;
  def _S : sve_int_bin_cons_misc_0_b<0b10, asm, ZPR32>;
  def _D : sve_int_bin_cons_misc_0_b<0b11, asm, ZPR64>;

  def : SVE_2_Op_Pat<nxv8f16, op, nxv8f16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4f32, op, nxv4f32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2f64, op, nxv2f64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_bin_cons_misc_0_c<bits<8> opc, string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins zprty:$Zn),
  asm, "\t$Zd, $Zn",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{7-6};
  let Inst{21}    = 0b1;
  let Inst{20-16} = opc{5-1};
  let Inst{15-11} = 0b10111;
  let Inst{10}    = opc{0};
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Unary Operations - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_fp_2op_u_zd<bits<2> sz, bits<3> opc, string asm,
                      ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins zprty:$Zn),
  asm, "\t$Zd, $Zn",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21-19} = 0b001;
  let Inst{18-16} = opc;
  let Inst{15-10} = 0b001100;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_fp_2op_u_zd<bits<3> opc, string asm, SDPatternOperator op> {
  def _H : sve_fp_2op_u_zd<0b01, opc, asm, ZPR16>;
  def _S : sve_fp_2op_u_zd<0b10, opc, asm, ZPR32>;
  def _D : sve_fp_2op_u_zd<0b11, opc, asm, ZPR64>;

  def : SVE_1_Op_Pat<nxv8f16, op, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_1_Op_Pat<nxv4f32, op, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_1_Op_Pat<nxv2f64, op, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Multiply-Add Group
//===----------------------------------------------------------------------===//

class sve_int_mladdsub_vvv_pred<bits<2> sz8_64, bits<1> opc, string asm,
                                ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, zprty:$Zm, zprty:$Za),
  asm, "\t$Zdn, $Pg/m, $Zm, $Za",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Za;
  bits<5> Zm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15-14} = 0b11;
  let Inst{13}    = opc;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Za;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_mladdsub_vvv_pred<bits<1> opc, string asm, string Ps,
                                     SDPatternOperator op, string revname,
                                     bit isOrig> {
  let DestructiveInstType = DestructiveTernaryCommWithRev in {
    def _B : sve_int_mladdsub_vvv_pred<0b00, opc, asm, ZPR8>,
             SVEPseudo2Instr<Ps # _B, 1>, SVEInstr2Rev<NAME # _B, revname # _B, isOrig>;
    def _H : sve_int_mladdsub_vvv_pred<0b01, opc, asm, ZPR16>,
             SVEPseudo2Instr<Ps # _H, 1>, SVEInstr2Rev<NAME # _H, revname # _H, isOrig>;
    def _S : sve_int_mladdsub_vvv_pred<0b10, opc, asm, ZPR32>,
             SVEPseudo2Instr<Ps # _S, 1>, SVEInstr2Rev<NAME # _S, revname # _S, isOrig>;
    def _D : sve_int_mladdsub_vvv_pred<0b11, opc, asm, ZPR64>,
             SVEPseudo2Instr<Ps # _D, 1>, SVEInstr2Rev<NAME # _D, revname # _D, isOrig>;
  }

  def : SVE_4_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_4_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_4_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_4_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_mlas_vvv_pred<bits<2> sz8_64, bits<1> opc, string asm,
                            ZPRRegOp zprty>
: I<(outs zprty:$Zda), (ins PPR3bAny:$Pg, zprty:$_Zda, zprty:$Zn, zprty:$Zm),
  asm, "\t$Zda, $Pg/m, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zda;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15-14} = 0b01;
  let Inst{13}    = opc;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zda;

  let Constraints = "$Zda = $_Zda";
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_mlas_vvv_pred<bits<1> opc, string asm, string Ps,
                                 SDPatternOperator op, string revname,
                                 bit isOrig> {
  let DestructiveInstType = DestructiveTernaryCommWithRev in {
    def _B : sve_int_mlas_vvv_pred<0b00, opc, asm, ZPR8>,
             SVEPseudo2Instr<Ps # _B, 1>,
             SVEInstr2Rev<NAME # _B, revname # _B, isOrig>;
    def _H : sve_int_mlas_vvv_pred<0b01, opc, asm, ZPR16>,
             SVEPseudo2Instr<Ps # _H, 1>,
             SVEInstr2Rev<NAME # _H, revname # _H, isOrig>;
    def _S : sve_int_mlas_vvv_pred<0b10, opc, asm, ZPR32>,
             SVEPseudo2Instr<Ps # _S, 1>,
             SVEInstr2Rev<NAME # _S, revname # _S, isOrig>;
    def _D : sve_int_mlas_vvv_pred<0b11, opc, asm, ZPR64>,
             SVEPseudo2Instr<Ps # _D, 1>,
             SVEInstr2Rev<NAME # _D, revname # _D, isOrig>;
  }

  def : SVE_4_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_4_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_4_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_4_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_ternary_pred_zx<SDPatternOperator op> {
  def _UNDEF_B : PredThreeOpPseudo<NAME # _B, ZPR8, FalseLanesUndef>;
  def _UNDEF_H : PredThreeOpPseudo<NAME # _H, ZPR16, FalseLanesUndef>;
  def _UNDEF_S : PredThreeOpPseudo<NAME # _S, ZPR32, FalseLanesUndef>;
  def _UNDEF_D : PredThreeOpPseudo<NAME # _D, ZPR64, FalseLanesUndef>;

  def _ZERO_B : PredThreeOpPseudo<NAME # _B, ZPR8, FalseLanesZero>;
  def _ZERO_H : PredThreeOpPseudo<NAME # _H, ZPR16, FalseLanesZero>;
  def _ZERO_S : PredThreeOpPseudo<NAME # _S, ZPR32, FalseLanesZero>;
  def _ZERO_D : PredThreeOpPseudo<NAME # _D, ZPR64, FalseLanesZero>;

  def : SVE_4_Op_Pat_SelZero<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, nxv16i8, !cast<Pseudo>(NAME # _ZERO_B)>;
  def : SVE_4_Op_Pat_SelZero<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, nxv8i16, !cast<Pseudo>(NAME # _ZERO_H)>;
  def : SVE_4_Op_Pat_SelZero<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, nxv4i32, !cast<Pseudo>(NAME # _ZERO_S)>;
  def : SVE_4_Op_Pat_SelZero<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, nxv2i64, !cast<Pseudo>(NAME # _ZERO_D)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Reduction Group
//===----------------------------------------------------------------------===//

class sve_int_movprfx_pred<bits<2> sz8_32, bits<3> opc, string asm,
                           ZPRRegOp zprty, string pg_suffix, dag iops>
: I<(outs zprty:$Zd), iops,
  asm, "\t$Zd, $Pg"#pg_suffix#", $Zn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_32;
  let Inst{21-19} = 0b010;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;

  let ElementSize = zprty.EltSz;
}

multiclass sve_int_movprfx_pred_merge<bits<3> opc, string asm> {
let Constraints = "$Zd = $_Zd" in {
  def _B : sve_int_movprfx_pred<0b00, opc, asm, ZPR8, "/m", (ins ZPR8:$_Zd, PPR3bAny:$Pg, ZPR8:$Zn)>;
  def _H : sve_int_movprfx_pred<0b01, opc, asm, ZPR16, "/m", (ins ZPR16:$_Zd, PPR3bAny:$Pg, ZPR16:$Zn)>;
  def _S : sve_int_movprfx_pred<0b10, opc, asm, ZPR32, "/m", (ins ZPR32:$_Zd, PPR3bAny:$Pg, ZPR32:$Zn)>;
  def _D : sve_int_movprfx_pred<0b11, opc, asm, ZPR64, "/m", (ins ZPR64:$_Zd, PPR3bAny:$Pg, ZPR64:$Zn)>;
}
}

multiclass sve_int_movprfx_pred_zero<bits<3> opc, string asm> {
  def _B : sve_int_movprfx_pred<0b00, opc, asm, ZPR8, "/z", (ins PPR3bAny:$Pg, ZPR8:$Zn)>;
  def _H : sve_int_movprfx_pred<0b01, opc, asm, ZPR16, "/z", (ins PPR3bAny:$Pg, ZPR16:$Zn)>;
  def _S : sve_int_movprfx_pred<0b10, opc, asm, ZPR32, "/z", (ins PPR3bAny:$Pg, ZPR32:$Zn)>;
  def _D : sve_int_movprfx_pred<0b11, opc, asm, ZPR64, "/z", (ins PPR3bAny:$Pg, ZPR64:$Zn)>;
}

class sve_int_reduce<bits<2> sz8_32, bits<2> fmt, bits<3> opc, string asm,
                     ZPRRegOp zprty, RegisterClass regtype>
: I<(outs regtype:$Vd), (ins PPR3bAny:$Pg, zprty:$Zn),
  asm, "\t$Vd, $Pg, $Zn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Vd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_32;
  let Inst{21}    = 0b0;
  let Inst{20-19} = fmt;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Vd;
}

multiclass sve_int_reduce_0_saddv<bits<3> opc, string asm,
                                  SDPatternOperator op> {
  def _B : sve_int_reduce<0b00, 0b00, opc, asm, ZPR8, FPR64>;
  def _H : sve_int_reduce<0b01, 0b00, opc, asm, ZPR16, FPR64>;
  def _S : sve_int_reduce<0b10, 0b00, opc, asm, ZPR32, FPR64>;

  def : Pat<(v2i64 (op (nxv16i1 PPR3bAny:$Pg), (nxv16i8 ZPR8:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_B) PPR3bAny:$Pg, ZPR8:$Zn), dsub)>;
  def : Pat<(v2i64 (op (nxv8i1 PPR3bAny:$Pg), (nxv8i16 ZPR16:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_H) PPR3bAny:$Pg, ZPR16:$Zn), dsub)>;
  def : Pat<(v2i64 (op (nxv4i1 PPR3bAny:$Pg), (nxv4i32 ZPR32:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_S) PPR3bAny:$Pg, ZPR32:$Zn), dsub)>;
}

multiclass sve_int_reduce_0<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_reduce<0b00, 0b00, opc, asm, ZPR8, FPR64>;
  def _H : sve_int_reduce<0b01, 0b00, opc, asm, ZPR16, FPR64>;
  def _S : sve_int_reduce<0b10, 0b00, opc, asm, ZPR32, FPR64>;
  def _D : sve_int_reduce<0b11, 0b00, opc, asm, ZPR64, FPR64>;

  def : Pat<(v2i64 (op (nxv16i1 PPR3bAny:$Pg), (nxv16i8 ZPR8:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_B) PPR3bAny:$Pg, ZPR8:$Zn), dsub)>;
  def : Pat<(v2i64 (op (nxv8i1 PPR3bAny:$Pg), (nxv8i16 ZPR16:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_H) PPR3bAny:$Pg, ZPR16:$Zn), dsub)>;
  def : Pat<(v2i64 (op (nxv4i1 PPR3bAny:$Pg), (nxv4i32 ZPR32:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_S) PPR3bAny:$Pg, ZPR32:$Zn), dsub)>;
  def : Pat<(v2i64 (op (nxv2i1 PPR3bAny:$Pg), (nxv2i64 ZPR64:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_D) PPR3bAny:$Pg, ZPR64:$Zn), dsub)>;
}

multiclass sve_int_reduce_1<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_reduce<0b00, 0b01, opc, asm, ZPR8, FPR8>;
  def _H : sve_int_reduce<0b01, 0b01, opc, asm, ZPR16, FPR16>;
  def _S : sve_int_reduce<0b10, 0b01, opc, asm, ZPR32, FPR32>;
  def _D : sve_int_reduce<0b11, 0b01, opc, asm, ZPR64, FPR64>;

  def : Pat<(v16i8 (op (nxv16i1 PPR3bAny:$Pg), (nxv16i8 ZPR8:$Zn))),
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_B) PPR3bAny:$Pg, ZPR8:$Zn), bsub)>;
  def : Pat<(v8i16 (op (nxv8i1 PPR3bAny:$Pg), (nxv8i16 ZPR16:$Zn))),
            (INSERT_SUBREG (v8i16 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_H) PPR3bAny:$Pg, ZPR16:$Zn), hsub)>;
  def : Pat<(v4i32 (op (nxv4i1 PPR3bAny:$Pg), (nxv4i32 ZPR32:$Zn))),
            (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_S) PPR3bAny:$Pg, ZPR32:$Zn), ssub)>;
  def : Pat<(v2i64 (op (nxv2i1 PPR3bAny:$Pg), (nxv2i64 ZPR64:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_D) PPR3bAny:$Pg, ZPR64:$Zn), dsub)>;
}

multiclass sve_int_reduce_2<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_reduce<0b00, 0b11, opc, asm, ZPR8, FPR8>;
  def _H : sve_int_reduce<0b01, 0b11, opc, asm, ZPR16, FPR16>;
  def _S : sve_int_reduce<0b10, 0b11, opc, asm, ZPR32, FPR32>;
  def _D : sve_int_reduce<0b11, 0b11, opc, asm, ZPR64, FPR64>;

  def : Pat<(v16i8 (op (nxv16i1 PPR3bAny:$Pg), (nxv16i8 ZPR8:$Zn))),
            (INSERT_SUBREG (v16i8 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_B) PPR3bAny:$Pg, ZPR8:$Zn), bsub)>;
  def : Pat<(v8i16 (op (nxv8i1 PPR3bAny:$Pg), (nxv8i16 ZPR16:$Zn))),
            (INSERT_SUBREG (v8i16 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_H) PPR3bAny:$Pg, ZPR16:$Zn), hsub)>;
  def : Pat<(v4i32 (op (nxv4i1 PPR3bAny:$Pg), (nxv4i32 ZPR32:$Zn))),
            (INSERT_SUBREG (v4i32 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_S) PPR3bAny:$Pg, ZPR32:$Zn), ssub)>;
  def : Pat<(v2i64 (op (nxv2i1 PPR3bAny:$Pg), (nxv2i64 ZPR64:$Zn))),
            (INSERT_SUBREG (v2i64 (IMPLICIT_DEF)), (!cast<Instruction>(NAME#_D) PPR3bAny:$Pg, ZPR64:$Zn), dsub)>;
}

//===----------------------------------------------------------------------===//
// SVE Permute - Extract Group
//===----------------------------------------------------------------------===//

class sve_int_perm_extract_i<string asm, SDPatternOperator op>
: I<(outs ZPR8:$Zdn), (ins ZPR8:$_Zdn, ZPR8:$Zm, imm0_255dec:$imm8),
  asm, "\t$Zdn, $_Zdn, $Zm, $imm8",
  "",
  [(set ZPR8:$Zdn, (nxv16i8 (op (nxv16i8 ZPR8:$_Zdn), (nxv16i8 ZPR8:$Zm), (imm0_255dec:$imm8))))]>, Sched<[]> {
  bits<5> Zdn;
  bits<5> Zm;
  bits<8> imm8;
  let Inst{31-21} = 0b00000101001;
  let Inst{20-16} = imm8{7-3};
  let Inst{15-13} = 0b000;
  let Inst{12-10} = imm8{2-0};
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
}

//===----------------------------------------------------------------------===//
// SVE Permute - Cross Lane Group
//===----------------------------------------------------------------------===//

class sve_int_perm_dup_i<bits<5> tsz, Operand immtype, string asm,
                         ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins zprty:$Zn, immtype:$idx),
  asm, "\t$Zd, $Zn$idx",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  bits<7> idx;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = {?,?}; // imm3h
  let Inst{21}    = 0b1;
  let Inst{20-16} = tsz;
  let Inst{15-10} = 0b001000;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_dup_i<string asm> {
  def _B : sve_int_perm_dup_i<{?,?,?,?,1}, sve_elm_idx_extdup_b, asm, ZPR8> {
    let Inst{23-22} = idx{5-4};
    let Inst{20-17} = idx{3-0};
  }
  def _H : sve_int_perm_dup_i<{?,?,?,1,0}, sve_elm_idx_extdup_h, asm, ZPR16> {
    let Inst{23-22} = idx{4-3};
    let Inst{20-18} = idx{2-0};
  }
  def _S : sve_int_perm_dup_i<{?,?,1,0,0}, sve_elm_idx_extdup_s, asm, ZPR32> {
    let Inst{23-22} = idx{3-2};
    let Inst{20-19}    = idx{1-0};
  }
  def _D : sve_int_perm_dup_i<{?,1,0,0,0}, sve_elm_idx_extdup_d, asm, ZPR64> {
    let Inst{23-22} = idx{2-1};
    let Inst{20}    = idx{0};
  }
  def _Q : sve_int_perm_dup_i<{1,0,0,0,0}, sve_elm_idx_extdup_q, asm, ZPR128> {
    let Inst{23-22} = idx{1-0};
  }

  def : InstAlias<"mov $Zd, $Zn$idx",
                  (!cast<Instruction>(NAME # _B) ZPR8:$Zd, ZPR8:$Zn, sve_elm_idx_extdup_b:$idx), 1>;
  def : InstAlias<"mov $Zd, $Zn$idx",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, ZPR16:$Zn, sve_elm_idx_extdup_h:$idx), 1>;
  def : InstAlias<"mov $Zd, $Zn$idx",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, ZPR32:$Zn, sve_elm_idx_extdup_s:$idx), 1>;
  def : InstAlias<"mov $Zd, $Zn$idx",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, ZPR64:$Zn, sve_elm_idx_extdup_d:$idx), 1>;
  def : InstAlias<"mov $Zd, $Zn$idx",
                  (!cast<Instruction>(NAME # _Q) ZPR128:$Zd, ZPR128:$Zn, sve_elm_idx_extdup_q:$idx), 1>;
  def : InstAlias<"mov $Zd, $Bn",
                  (!cast<Instruction>(NAME # _B) ZPR8:$Zd, FPR8asZPR:$Bn, 0), 2>;
  def : InstAlias<"mov $Zd, $Hn",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, FPR16asZPR:$Hn, 0), 2>;
  def : InstAlias<"mov $Zd, $Sn",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, FPR32asZPR:$Sn, 0), 2>;
  def : InstAlias<"mov $Zd, $Dn",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, FPR64asZPR:$Dn, 0), 2>;
  def : InstAlias<"mov $Zd, $Qn",
                  (!cast<Instruction>(NAME # _Q) ZPR128:$Zd, FPR128asZPR:$Qn, 0), 2>;
}

class sve_int_perm_dup_r<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                         RegisterClass srcRegType>
: I<(outs zprty:$Zd), (ins srcRegType:$Rn),
  asm, "\t$Zd, $Rn",
  "",
  []>, Sched<[]> {
  bits<5> Rn;
  bits<5> Zd;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-10} = 0b100000001110;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_dup_r<string asm> {
  def _B : sve_int_perm_dup_r<0b00, asm, ZPR8, GPR32sp>;
  def _H : sve_int_perm_dup_r<0b01, asm, ZPR16, GPR32sp>;
  def _S : sve_int_perm_dup_r<0b10, asm, ZPR32, GPR32sp>;
  def _D : sve_int_perm_dup_r<0b11, asm, ZPR64, GPR64sp>;

  def : InstAlias<"mov $Zd, $Rn",
                  (!cast<Instruction>(NAME # _B) ZPR8:$Zd, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd, $Rn",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd, $Rn",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd, $Rn",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, GPR64sp:$Rn), 1>;
}

class sve_int_perm_insrs<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                         RegisterClass srcRegType>
: I<(outs zprty:$Zdn), (ins zprty:$_Zdn, srcRegType:$Rm),
  asm, "\t$Zdn, $Rm",
  "",
  []>, Sched<[]> {
  bits<5> Rm;
  bits<5> Zdn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-10} = 0b100100001110;
  let Inst{9-5}   = Rm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_int_perm_insrs<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_insrs<0b00, asm, ZPR8, GPR32>;
  def _H : sve_int_perm_insrs<0b01, asm, ZPR16, GPR32>;
  def _S : sve_int_perm_insrs<0b10, asm, ZPR32, GPR32>;
  def _D : sve_int_perm_insrs<0b11, asm, ZPR64, GPR64>;

  def : SVE_2_Op_Pat<nxv16i8, op, nxv16i8, i32, !cast<Instruction>(NAME # _B)>;
  def : SVE_2_Op_Pat<nxv8i16, op, nxv8i16, i32, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4i32, op, nxv4i32, i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2i64, op, nxv2i64, i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_insrv<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                         RegisterClass srcRegType>
: I<(outs zprty:$Zdn), (ins zprty:$_Zdn, srcRegType:$Vm),
  asm, "\t$Zdn, $Vm",
  "",
  []>, Sched<[]> {
  bits<5> Vm;
  bits<5> Zdn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-10} = 0b110100001110;
  let Inst{9-5}   = Vm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_int_perm_insrv<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_insrv<0b00, asm, ZPR8, FPR8>;
  def _H : sve_int_perm_insrv<0b01, asm, ZPR16, FPR16>;
  def _S : sve_int_perm_insrv<0b10, asm, ZPR32, FPR32>;
  def _D : sve_int_perm_insrv<0b11, asm, ZPR64, FPR64>;

  def : SVE_2_Op_Pat<nxv8f16, op, nxv8f16, f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4f32, op, nxv4f32, f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2f64, op, nxv2f64, f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_reverse_z<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                             ValueType vt, SDPatternOperator op>
: I<(outs zprty:$Zd), (ins zprty:$Zn),
  asm, "\t$Zd, $Zn",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-10} = 0b111000001110;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_reverse_z<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_reverse_z<0b00, asm, ZPR8, nxv16i8, op>;
  def _H : sve_int_perm_reverse_z<0b01, asm, ZPR16, nxv8i16, op>;
  def _S : sve_int_perm_reverse_z<0b10, asm, ZPR32, nxv4i32, op>;
  def _D : sve_int_perm_reverse_z<0b11, asm, ZPR64, nxv2i64, op>;

  def : SVE_1_Op_Pat<nxv16i8, op, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_1_Op_Pat<nxv8i16, op, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_1_Op_Pat<nxv4i32, op, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_1_Op_Pat<nxv2i64, op, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_1_Op_Pat<nxv8f16, op, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_1_Op_Pat<nxv4f32, op, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_1_Op_Pat<nxv2f64, op, nxv2f64, !cast<Instruction>(NAME # _D)>;

  def : SVE_1_Op_Pat<nxv2f32, op, nxv2f32, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_tbl<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                       RegisterOperand VecList, ValueType vt,
                       SDPatternOperator op>
: I<(outs zprty:$Zd), (ins VecList:$Zn, zprty:$Zm),
  asm, "\t$Zd, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-10} = 0b001100;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_tbl<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_tbl<0b00, asm, ZPR8, Z_b, nxv16i8, op>;
  def _H : sve_int_perm_tbl<0b01, asm, ZPR16, Z_h, nxv8i16, op>;
  def _S : sve_int_perm_tbl<0b10, asm, ZPR32, Z_s, nxv4i32, op>;
  def _D : sve_int_perm_tbl<0b11, asm, ZPR64, Z_d, nxv2i64, op>;

  def : InstAlias<asm # "\t$Zd, $Zn, $Zm",
                 (!cast<Instruction>(NAME # _B) ZPR8:$Zd, ZPR8:$Zn, ZPR8:$Zm), 0>;
  def : InstAlias<asm # "\t$Zd, $Zn, $Zm",
                 (!cast<Instruction>(NAME # _H) ZPR16:$Zd, ZPR16:$Zn, ZPR16:$Zm), 0>;
  def : InstAlias<asm # "\t$Zd, $Zn, $Zm",
                 (!cast<Instruction>(NAME # _S) ZPR32:$Zd, ZPR32:$Zn, ZPR32:$Zm), 0>;
  def : InstAlias<asm # "\t$Zd, $Zn, $Zm",
                 (!cast<Instruction>(NAME # _D) ZPR64:$Zd, ZPR64:$Zn, ZPR64:$Zm), 0>;

  def : SVE_2_Op_Pat<nxv16i8, op, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_2_Op_Pat<nxv8i16, op, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4i32, op, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2i64, op, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
  def : SVE_2_Op_Pat<nxv8f16, op, nxv8f16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4f32, op, nxv4f32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2f64, op, nxv2f64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_unpk<bits<2> sz16_64, bits<2> opc, string asm,
                        ZPRRegOp zprty1, ZPRRegOp zprty2,
                        ValueType out_vt, ValueType in_vt, SDPatternOperator op>
: I<(outs zprty1:$Zd), (ins zprty2:$Zn),
  asm, "\t$Zd, $Zn",
  "",
  [(set zprty1:$Zd, (out_vt (op (in_vt zprty2:$Zn))))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz16_64;
  let Inst{21-18} = 0b1100;
  let Inst{17-16} = opc;
  let Inst{15-10} = 0b001110;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_unpk<bits<2> opc, string asm, SDPatternOperator op> {
  def _H : sve_int_perm_unpk<0b01, opc, asm, ZPR16, ZPR8, nxv8i16, nxv16i8, op>;
  def _S : sve_int_perm_unpk<0b10, opc, asm, ZPR32, ZPR16, nxv4i32, nxv8i16, op>;
  def _D : sve_int_perm_unpk<0b11, opc, asm, ZPR64, ZPR32, nxv2i64, nxv4i32, op>;
}

//===----------------------------------------------------------------------===//
// SVE Logical Mask Immediate Group
//===----------------------------------------------------------------------===//

class sve_int_dup_mask_imm<string asm>
: I<(outs ZPR64:$Zd), (ins logical_imm64:$imms),
  asm, "\t$Zd, $imms",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<13> imms;
  let Inst{31-18} = 0b00000101110000;
  let Inst{17-5} = imms;
  let Inst{4-0} = Zd;

  let isReMaterializable = 1;
  let DecoderMethod = "DecodeSVELogicalImmInstruction";
}

multiclass sve_int_dup_mask_imm<string asm> {
  def NAME : sve_int_dup_mask_imm<asm>;

  def : InstAlias<"dupm $Zd, $imm",
                  (!cast<Instruction>(NAME) ZPR8:$Zd, sve_logical_imm8:$imm), 4>;
  def : InstAlias<"dupm $Zd, $imm",
                  (!cast<Instruction>(NAME) ZPR16:$Zd, sve_logical_imm16:$imm), 3>;
  def : InstAlias<"dupm $Zd, $imm",
                  (!cast<Instruction>(NAME) ZPR32:$Zd, sve_logical_imm32:$imm), 2>;

  // NOTE: All Zd.b forms have a CPY/DUP equivalent, hence no byte alias here.
  def : InstAlias<"mov $Zd, $imm",
                  (!cast<Instruction>(NAME) ZPR16:$Zd, sve_preferred_logical_imm16:$imm), 7>;
  def : InstAlias<"mov $Zd, $imm",
                  (!cast<Instruction>(NAME) ZPR32:$Zd, sve_preferred_logical_imm32:$imm), 6>;
  def : InstAlias<"mov $Zd, $imm",
                  (!cast<Instruction>(NAME) ZPR64:$Zd, sve_preferred_logical_imm64:$imm), 5>;
}

class sve_int_log_imm<bits<2> opc, string asm, SDPatternOperator op>
: I<(outs ZPR64:$Zdn), (ins ZPR64:$_Zdn, logical_imm64:$imms13),
  asm, "\t$Zdn, $_Zdn, $imms13",
  "",
  [(set ZPR64:$Zdn, (nxv2i64 (op (nxv2i64 ZPR64:$_Zdn), (logical_imm64:$imms13))))]>,
  Sched<[]> {
  bits<5> Zdn;
  bits<13> imms13;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = opc;
  let Inst{21-18} = 0b0000;
  let Inst{17-5}  = imms13;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
  let DecoderMethod = "DecodeSVELogicalImmInstruction";
}

multiclass sve_int_log_imm<bits<2> opc, string asm, SDPatternOperator op,
                           string alias> {
  def NAME : sve_int_log_imm<opc, asm, op>;

  def : InstAlias<asm # "\t$Zdn, $Zdn, $imm",
                  (!cast<Instruction>(NAME) ZPR8:$Zdn, sve_logical_imm8:$imm), 4>;
  def : InstAlias<asm # "\t$Zdn, $Zdn, $imm",
                  (!cast<Instruction>(NAME) ZPR16:$Zdn, sve_logical_imm16:$imm), 3>;
  def : InstAlias<asm # "\t$Zdn, $Zdn, $imm",
                  (!cast<Instruction>(NAME) ZPR32:$Zdn, sve_logical_imm32:$imm), 2>;

  def : InstAlias<alias # "\t$Zdn, $Zdn, $imm",
                  (!cast<Instruction>(NAME) ZPR8:$Zdn, sve_logical_imm8_not:$imm), 0>;
  def : InstAlias<alias # "\t$Zdn, $Zdn, $imm",
                  (!cast<Instruction>(NAME) ZPR16:$Zdn, sve_logical_imm16_not:$imm), 0>;
  def : InstAlias<alias # "\t$Zdn, $Zdn, $imm",
                  (!cast<Instruction>(NAME) ZPR32:$Zdn, sve_logical_imm32_not:$imm), 0>;
  def : InstAlias<alias # "\t$Zdn, $Zdn, $imm",
                  (!cast<Instruction>(NAME) ZPR64:$Zdn, logical_imm64_not:$imm), 0>;
}

//===----------------------------------------------------------------------===//
// SVE Permute - Predicated Group
//===----------------------------------------------------------------------===//

class sve_int_perm_clast_rz<bits<2> sz8_64, bit ab, string asm,
                            ZPRRegOp zprty, RegisterClass rt>
: I<(outs rt:$Rdn), (ins PPR3bAny:$Pg, rt:$_Rdn, zprty:$Zm),
  asm, "\t$Rdn, $Pg, $_Rdn, $Zm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-17} = 0b11000;
  let Inst{16}    = ab;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Rdn;

  let Constraints = "$Rdn = $_Rdn";
}

multiclass sve_int_perm_clast_rz<bit ab, string asm, SDPatternOperator op> {
  def _B : sve_int_perm_clast_rz<0b00, ab, asm, ZPR8, GPR32>;
  def _H : sve_int_perm_clast_rz<0b01, ab, asm, ZPR16, GPR32>;
  def _S : sve_int_perm_clast_rz<0b10, ab, asm, ZPR32, GPR32>;
  def _D : sve_int_perm_clast_rz<0b11, ab, asm, ZPR64, GPR64>;

  def : SVE_3_Op_Pat<i32, op, nxv16i1, i32, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<i32, op, nxv8i1,  i32, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<i32, op, nxv4i1,  i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<i64, op, nxv2i1,  i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_clast_vz<bits<2> sz8_64, bit ab, string asm,
                            ZPRRegOp zprty, RegisterClass rt>
: I<(outs rt:$Vdn), (ins PPR3bAny:$Pg, rt:$_Vdn, zprty:$Zm),
  asm, "\t$Vdn, $Pg, $_Vdn, $Zm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Vdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-17} = 0b10101;
  let Inst{16}    = ab;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Vdn;

  let Constraints = "$Vdn = $_Vdn";
}

multiclass sve_int_perm_clast_vz<bit ab, string asm, SDPatternOperator op> {
  def _B : sve_int_perm_clast_vz<0b00, ab, asm, ZPR8, FPR8>;
  def _H : sve_int_perm_clast_vz<0b01, ab, asm, ZPR16, FPR16>;
  def _S : sve_int_perm_clast_vz<0b10, ab, asm, ZPR32, FPR32>;
  def _D : sve_int_perm_clast_vz<0b11, ab, asm, ZPR64, FPR64>;

  def : SVE_3_Op_Pat<f16, op, nxv8i1,  f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<f32, op, nxv4i1,  f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<f64, op, nxv2i1,  f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_clast_zz<bits<2> sz8_64, bit ab, string asm,
                            ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, zprty:$Zm),
  asm, "\t$Zdn, $Pg, $_Zdn, $Zm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-17} = 0b10100;
  let Inst{16}    = ab;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_int_perm_clast_zz<bit ab, string asm, SDPatternOperator op> {
  def _B : sve_int_perm_clast_zz<0b00, ab, asm, ZPR8>;
  def _H : sve_int_perm_clast_zz<0b01, ab, asm, ZPR16>;
  def _S : sve_int_perm_clast_zz<0b10, ab, asm, ZPR32>;
  def _D : sve_int_perm_clast_zz<0b11, ab, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8i1, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_compact<bit sz, string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins PPR3bAny:$Pg, zprty:$Zn),
  asm, "\t$Zd, $Pg, $Zn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-23} = 0b000001011;
  let Inst{22}    = sz;
  let Inst{21-13} = 0b100001100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_compact<string asm, SDPatternOperator op> {
  def _S : sve_int_perm_compact<0b0, asm, ZPR32>;
  def _D : sve_int_perm_compact<0b1, asm, ZPR64>;

  def : SVE_2_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, !cast<Instruction>(NAME # _D)>;
  def : SVE_2_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_cpy_r<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                         RegisterClass srcRegType>
: I<(outs zprty:$Zd), (ins zprty:$_Zd, PPR3bAny:$Pg, srcRegType:$Rn),
  asm, "\t$Zd, $Pg/m, $Rn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zd;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-13} = 0b101000101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
  let DestructiveInstType = DestructiveUnary;
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_perm_cpy_r<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_cpy_r<0b00, asm, ZPR8, GPR32sp>;
  def _H : sve_int_perm_cpy_r<0b01, asm, ZPR16, GPR32sp>;
  def _S : sve_int_perm_cpy_r<0b10, asm, ZPR32, GPR32sp>;
  def _D : sve_int_perm_cpy_r<0b11, asm, ZPR64, GPR64sp>;

  def : InstAlias<"mov $Zd, $Pg/m, $Rn",
                  (!cast<Instruction>(NAME # _B) ZPR8:$Zd, PPR3bAny:$Pg, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $Rn",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, PPR3bAny:$Pg, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $Rn",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, PPR3bAny:$Pg, GPR32sp:$Rn), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $Rn",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, PPR3bAny:$Pg, GPR64sp:$Rn), 1>;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i8, nxv16i1, i32, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i16, nxv8i1,  i32, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_cpy_v<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                         RegisterClass srcRegtype>
: I<(outs zprty:$Zd), (ins zprty:$_Zd, PPR3bAny:$Pg, srcRegtype:$Vn),
  asm, "\t$Zd, $Pg/m, $Vn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Vn;
  bits<5> Zd;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-13} = 0b100000100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Vn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
  let DestructiveInstType = DestructiveUnary;
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_perm_cpy_v<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_cpy_v<0b00, asm, ZPR8, FPR8>;
  def _H : sve_int_perm_cpy_v<0b01, asm, ZPR16, FPR16>;
  def _S : sve_int_perm_cpy_v<0b10, asm, ZPR32, FPR32>;
  def _D : sve_int_perm_cpy_v<0b11, asm, ZPR64, FPR64>;

  def : InstAlias<"mov $Zd, $Pg/m, $Vn",
                  (!cast<Instruction>(NAME # _B) ZPR8:$Zd, PPR3bAny:$Pg, FPR8:$Vn), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $Vn",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, PPR3bAny:$Pg, FPR16:$Vn), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $Vn",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, PPR3bAny:$Pg, FPR32:$Vn), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $Vn",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, PPR3bAny:$Pg, FPR64:$Vn), 1>;

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8f16, nxv8i1, f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4f32, nxv4i1, f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f32, op, nxv2f32, nxv2i1, f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2f64, nxv2i1, f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_last_r<bits<2> sz8_64, bit ab, string asm,
                          ZPRRegOp zprty, RegisterClass resultRegType>
: I<(outs resultRegType:$Rd), (ins PPR3bAny:$Pg, zprty:$Zn),
  asm, "\t$Rd, $Pg, $Zn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-17} = 0b10000;
  let Inst{16}    = ab;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Rd;
}

multiclass sve_int_perm_last_r<bit ab, string asm, SDPatternOperator op> {
  def _B : sve_int_perm_last_r<0b00, ab, asm, ZPR8, GPR32>;
  def _H : sve_int_perm_last_r<0b01, ab, asm, ZPR16, GPR32>;
  def _S : sve_int_perm_last_r<0b10, ab, asm, ZPR32, GPR32>;
  def _D : sve_int_perm_last_r<0b11, ab, asm, ZPR64, GPR64>;

  def : SVE_2_Op_Pat<i32, op, nxv16i1, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_2_Op_Pat<i32, op, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<i32, op, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<i64, op, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_last_v<bits<2> sz8_64, bit ab, string asm,
                          ZPRRegOp zprty, RegisterClass dstRegtype>
: I<(outs dstRegtype:$Vd), (ins PPR3bAny:$Pg, zprty:$Zn),
  asm, "\t$Vd, $Pg, $Zn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Vd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-17} = 0b10001;
  let Inst{16}    = ab;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Vd;
}

multiclass sve_int_perm_last_v<bit ab, string asm, SDPatternOperator op> {
  def _B : sve_int_perm_last_v<0b00, ab, asm, ZPR8, FPR8>;
  def _H : sve_int_perm_last_v<0b01, ab, asm, ZPR16, FPR16>;
  def _S : sve_int_perm_last_v<0b10, ab, asm, ZPR32, FPR32>;
  def _D : sve_int_perm_last_v<0b11, ab, asm, ZPR64, FPR64>;

  def : SVE_2_Op_Pat<f16, op, nxv8i1,  nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<f32, op, nxv4i1,  nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<f32, op, nxv2i1,  nxv2f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<f64, op, nxv2i1,  nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_rev<bits<2> sz8_64, bits<2> opc, string asm,
                       ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins zprty:$_Zd, PPR3bAny:$Pg, zprty:$Zn),
  asm, "\t$Zd, $Pg/m, $Zn",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<3> Pg;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-18} = 0b1001;
  let Inst{17-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
  let DestructiveInstType = DestructiveUnary;
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_perm_rev_rbit<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_rev<0b00, 0b11, asm, ZPR8>;
  def _H : sve_int_perm_rev<0b01, 0b11, asm, ZPR16>;
  def _S : sve_int_perm_rev<0b10, 0b11, asm, ZPR32>;
  def _D : sve_int_perm_rev<0b11, 0b11, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i8, nxv16i1, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i16, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_perm_rev_revb<string asm, SDPatternOperator int_op,
                                 SDPatternOperator ir_op> {
  def _H : sve_int_perm_rev<0b01, 0b00, asm, ZPR16>;
  def _S : sve_int_perm_rev<0b10, 0b00, asm, ZPR32>;
  def _D : sve_int_perm_rev<0b11, 0b00, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv8i16, int_op, nxv8i16, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, int_op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, int_op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_1_Op_AllActive_Pat<nxv8i16, ir_op, nxv8i16, !cast<Instruction>(NAME # _H), PTRUE_H>;
  def : SVE_1_Op_AllActive_Pat<nxv4i32, ir_op, nxv4i32, !cast<Instruction>(NAME # _S), PTRUE_S>;
  def : SVE_1_Op_AllActive_Pat<nxv2i64, ir_op, nxv2i64, !cast<Instruction>(NAME # _D), PTRUE_D>;
}

multiclass sve_int_perm_rev_revh<string asm, SDPatternOperator op> {
  def _S : sve_int_perm_rev<0b10, 0b01, asm, ZPR32>;
  def _D : sve_int_perm_rev<0b11, 0b01, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_perm_rev_revw<string asm, SDPatternOperator op> {
  def _D : sve_int_perm_rev<0b11, 0b10, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_perm_splice<bits<2> sz8_64, string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, zprty:$Zm),
  asm, "\t$Zdn, $Pg, $_Zdn, $Zm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-13} = 0b101100100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_int_perm_splice<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_splice<0b00, asm, ZPR8>;
  def _H : sve_int_perm_splice<0b01, asm, ZPR16>;
  def _S : sve_int_perm_splice<0b10, asm, ZPR32>;
  def _D : sve_int_perm_splice<0b11, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8i1, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Stack Allocation Group
//===----------------------------------------------------------------------===//

class sve_int_arith_vl<bit opc, string asm>
: I<(outs GPR64sp:$Rd), (ins GPR64sp:$Rn, simm6_32b:$imm6),
  asm, "\t$Rd, $Rn, $imm6",
  "",
  []>, Sched<[]> {
  bits<5> Rd;
  bits<5> Rn;
  bits<6> imm6;
  let Inst{31-23} = 0b000001000;
  let Inst{22}    = opc;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rn;
  let Inst{15-11} = 0b01010;
  let Inst{10-5}  = imm6;
  let Inst{4-0}   = Rd;
}

class sve_int_read_vl_a<bits<6> opc, string asm>
: I<(outs GPR64:$Rd), (ins simm6_32b:$imm6),
  asm, "\t$Rd, $imm6",
  "",
  []>, Sched<[]> {
  bits<5> Rd;
  bits<6> imm6;
  let Inst{31-23} = 0b000001001;
  let Inst{22}    = opc{5};
  let Inst{21}    = 0b1;
  let Inst{20-16} = opc{4-0};
  let Inst{15-11} = 0b01010;
  let Inst{10-5}  = imm6;
  let Inst{4-0}   = Rd;

  let isReMaterializable = 1;
}

//===----------------------------------------------------------------------===//
// SVE Element Count Group
//===----------------------------------------------------------------------===//

class sve_int_count<bits<3> opc, string asm>
: I<(outs GPR64:$Rd), (ins sve_pred_enum:$pattern, sve_incdec_imm:$imm4),
  asm, "\t$Rd, $pattern, mul $imm4",
  "",
  []>, Sched<[]> {
  bits<5> Rd;
  bits<4> imm4;
  bits<5> pattern;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{2-1};
  let Inst{21-20} = 0b10;
  let Inst{19-16} = imm4;
  let Inst{15-11} = 0b11100;
  let Inst{10}    = opc{0};
  let Inst{9-5}   = pattern;
  let Inst{4-0}   = Rd;

  let isReMaterializable = 1;
}

multiclass sve_int_count<bits<3> opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_count<opc, asm>;

  def : InstAlias<asm # "\t$Rd, $pattern",
                  (!cast<Instruction>(NAME) GPR64:$Rd, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Rd",
                  (!cast<Instruction>(NAME) GPR64:$Rd, 0b11111, 1), 2>;

  def : Pat<(i64 (op sve_pred_enum:$pattern)),
            (!cast<Instruction>(NAME) sve_pred_enum:$pattern, 1)>;
}

class sve_int_countvlv<bits<5> opc, string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins zprty:$_Zdn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4),
  asm, "\t$Zdn, $pattern, mul $imm4",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<5> pattern;
  bits<4> imm4;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{4-3};
  let Inst{21}    = 0b1;
  let Inst{20}    = opc{2};
  let Inst{19-16} = imm4;
  let Inst{15-12} = 0b1100;
  let Inst{11-10} = opc{1-0};
  let Inst{9-5}   = pattern;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_int_countvlv<bits<5> opc, string asm, ZPRRegOp zprty,
                            SDPatternOperator op = null_frag,
                            ValueType vt = OtherVT> {
  def NAME : sve_int_countvlv<opc, asm, zprty>;

  def : InstAlias<asm # "\t$Zdn, $pattern",
                  (!cast<Instruction>(NAME) zprty:$Zdn, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Zdn",
                  (!cast<Instruction>(NAME) zprty:$Zdn, 0b11111, 1), 2>;

  def : Pat<(vt (op (vt zprty:$Zn), (sve_pred_enum:$pattern), (sve_incdec_imm:$imm4))),
            (!cast<Instruction>(NAME) $Zn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4)>;

}

class sve_int_pred_pattern_a<bits<3> opc, string asm>
: I<(outs GPR64:$Rdn), (ins GPR64:$_Rdn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4),
  asm, "\t$Rdn, $pattern, mul $imm4",
  "",
  []>, Sched<[]> {
  bits<5> Rdn;
  bits<5> pattern;
  bits<4> imm4;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{2-1};
  let Inst{21-20} = 0b11;
  let Inst{19-16} = imm4;
  let Inst{15-11} = 0b11100;
  let Inst{10}    = opc{0};
  let Inst{9-5}   = pattern;
  let Inst{4-0}   = Rdn;

  let Constraints = "$Rdn = $_Rdn";
}

multiclass sve_int_pred_pattern_a<bits<3> opc, string asm> {
  def NAME : sve_int_pred_pattern_a<opc, asm>;

  def : InstAlias<asm # "\t$Rdn, $pattern",
                  (!cast<Instruction>(NAME) GPR64:$Rdn, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Rdn",
                  (!cast<Instruction>(NAME) GPR64:$Rdn, 0b11111, 1), 2>;
}

class sve_int_pred_pattern_b<bits<5> opc, string asm, RegisterOperand dt,
                             RegisterOperand st>
: I<(outs dt:$Rdn), (ins st:$_Rdn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4),
  asm, "\t$Rdn, $pattern, mul $imm4",
  "",
  []>, Sched<[]> {
  bits<5> Rdn;
  bits<5> pattern;
  bits<4> imm4;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{4-3};
  let Inst{21}    = 0b1;
  let Inst{20}    = opc{2};
  let Inst{19-16} = imm4;
  let Inst{15-12} = 0b1111;
  let Inst{11-10} = opc{1-0};
  let Inst{9-5}   = pattern;
  let Inst{4-0}   = Rdn;

  // Signed 32bit forms require their GPR operand printed.
  let AsmString = !if(!eq(opc{2,0}, 0b00),
                      !strconcat(asm, "\t$Rdn, $_Rdn, $pattern, mul $imm4"),
                      !strconcat(asm, "\t$Rdn, $pattern, mul $imm4"));

  let AsmMatchConverter = !if(!eq(opc{2,0}, 0b00), "cvtXWPatternImm", "");
  let Constraints = "$Rdn = $_Rdn";
}

multiclass sve_int_pred_pattern_b_s32<bits<5> opc, string asm,
                                      SDPatternOperator op> {
  def NAME : sve_int_pred_pattern_b<opc, asm, GPR64Op, GPR64as32>;

  def : InstAlias<asm # "\t$Rd, $Rn, $pattern",
                  (!cast<Instruction>(NAME) GPR64Op:$Rd, GPR64as32:$Rn, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Rd, $Rn",
                  (!cast<Instruction>(NAME) GPR64Op:$Rd, GPR64as32:$Rn, 0b11111, 1), 2>;

  // NOTE: Register allocation doesn't like tied operands of differing register
  //       class, hence the extra INSERT_SUBREG complication.

  def : Pat<(i32 (op GPR32:$Rn, (sve_pred_enum:$pattern), (sve_incdec_imm:$imm4))),
            (EXTRACT_SUBREG (!cast<Instruction>(NAME) (INSERT_SUBREG (IMPLICIT_DEF), $Rn, sub_32), sve_pred_enum:$pattern, sve_incdec_imm:$imm4), sub_32)>;
}

multiclass sve_int_pred_pattern_b_u32<bits<5> opc, string asm,
                                      SDPatternOperator op> {
  def NAME : sve_int_pred_pattern_b<opc, asm, GPR32Op, GPR32Op>;

  def : InstAlias<asm # "\t$Rdn, $pattern",
                  (!cast<Instruction>(NAME) GPR32Op:$Rdn, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Rdn",
                  (!cast<Instruction>(NAME) GPR32Op:$Rdn, 0b11111, 1), 2>;

  def : Pat<(i32 (op GPR32:$Rn, (sve_pred_enum:$pattern), (sve_incdec_imm:$imm4))),
            (!cast<Instruction>(NAME) $Rn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4)>;
}

multiclass sve_int_pred_pattern_b_x64<bits<5> opc, string asm,
                                      SDPatternOperator op> {
  def NAME : sve_int_pred_pattern_b<opc, asm, GPR64Op, GPR64Op>;

  def : InstAlias<asm # "\t$Rdn, $pattern",
                  (!cast<Instruction>(NAME) GPR64Op:$Rdn, sve_pred_enum:$pattern, 1), 1>;
  def : InstAlias<asm # "\t$Rdn",
                  (!cast<Instruction>(NAME) GPR64Op:$Rdn, 0b11111, 1), 2>;

  def : Pat<(i64 (op GPR64:$Rn, (sve_pred_enum:$pattern), (sve_incdec_imm:$imm4))),
            (!cast<Instruction>(NAME) $Rn, sve_pred_enum:$pattern, sve_incdec_imm:$imm4)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Wide Immediate - Predicated Group
//===----------------------------------------------------------------------===//

class sve_int_dup_fpimm_pred<bits<2> sz, Operand fpimmtype,
                             string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins zprty:$_Zd, PPRAny:$Pg, fpimmtype:$imm8),
  asm, "\t$Zd, $Pg/m, $imm8",
  "",
  []>, Sched<[]> {
  bits<4> Pg;
  bits<5> Zd;
  bits<8> imm8;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz;
  let Inst{21-20} = 0b01;
  let Inst{19-16} = Pg;
  let Inst{15-13} = 0b110;
  let Inst{12-5}  = imm8;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
  let DestructiveInstType = DestructiveOther;
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_dup_fpimm_pred<string asm> {
  def _H : sve_int_dup_fpimm_pred<0b01, sve_fpimm16, asm, ZPR16>;
  def _S : sve_int_dup_fpimm_pred<0b10, sve_fpimm32, asm, ZPR32>;
  def _D : sve_int_dup_fpimm_pred<0b11, sve_fpimm64, asm, ZPR64>;

  def : InstAlias<"fmov $Zd, $Pg/m, $imm8",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, PPRAny:$Pg, sve_fpimm16:$imm8), 1>;
  def : InstAlias<"fmov $Zd, $Pg/m, $imm8",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, PPRAny:$Pg, sve_fpimm32:$imm8), 1>;
  def : InstAlias<"fmov $Zd, $Pg/m, $imm8",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, PPRAny:$Pg, sve_fpimm64:$imm8), 1>;
}

class sve_int_dup_imm_pred<bits<2> sz8_64, bit m, string asm,
                           ZPRRegOp zprty,
                           string pred_qual, dag iops>
: I<(outs zprty:$Zd), iops,
  asm, "\t$Zd, $Pg"#pred_qual#", $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<4> Pg;
  bits<9> imm;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-20} = 0b01;
  let Inst{19-16} = Pg;
  let Inst{15}    = 0b0;
  let Inst{14}    = m;
  let Inst{13}    = imm{8};   // sh
  let Inst{12-5}  = imm{7-0}; // imm8
  let Inst{4-0}   = Zd;

  let DestructiveInstType = DestructiveOther;
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_dup_imm_pred_merge<string asm> {
let Constraints = "$Zd = $_Zd" in {
  def _B : sve_int_dup_imm_pred<0b00, 1, asm, ZPR8, "/m", (ins ZPR8:$_Zd, PPRAny:$Pg, simm8_opt_lsl_i8:$imm)>;
  def _H : sve_int_dup_imm_pred<0b01, 1, asm, ZPR16, "/m", (ins ZPR16:$_Zd, PPRAny:$Pg, simm8_opt_lsl_i16:$imm)>;
  def _S : sve_int_dup_imm_pred<0b10, 1, asm, ZPR32, "/m", (ins ZPR32:$_Zd, PPRAny:$Pg, simm8_opt_lsl_i32:$imm)>;
  def _D : sve_int_dup_imm_pred<0b11, 1, asm, ZPR64, "/m", (ins ZPR64:$_Zd, PPRAny:$Pg, simm8_opt_lsl_i64:$imm)>;
}

  def : InstAlias<"mov $Zd, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _B) ZPR8:$Zd, PPRAny:$Pg, simm8_opt_lsl_i8:$imm), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, PPRAny:$Pg, simm8_opt_lsl_i16:$imm), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, PPRAny:$Pg, simm8_opt_lsl_i32:$imm), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, PPRAny:$Pg, simm8_opt_lsl_i64:$imm), 1>;

  def : InstAlias<"fmov $Zd, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, PPRAny:$Pg, sve_fpzero:$imm), 0>;
  def : InstAlias<"fmov $Zd, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, PPRAny:$Pg, sve_fpzero:$imm), 0>;
  def : InstAlias<"fmov $Zd, $Pg/m, $imm",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, PPRAny:$Pg, sve_fpzero_f64:$imm), 0>;
}

multiclass sve_int_dup_imm_pred_zero<string asm> {
  def _B : sve_int_dup_imm_pred<0b00, 0, asm, ZPR8, "/z", (ins PPRAny:$Pg, simm8_opt_lsl_i8:$imm)>;
  def _H : sve_int_dup_imm_pred<0b01, 0, asm, ZPR16, "/z", (ins PPRAny:$Pg, simm8_opt_lsl_i16:$imm)>;
  def _S : sve_int_dup_imm_pred<0b10, 0, asm, ZPR32, "/z", (ins PPRAny:$Pg, simm8_opt_lsl_i32:$imm)>;
  def _D : sve_int_dup_imm_pred<0b11, 0, asm, ZPR64, "/z", (ins PPRAny:$Pg, simm8_opt_lsl_i64:$imm)>;

  def : InstAlias<"mov $Zd, $Pg/z, $imm",
                  (!cast<Instruction>(NAME # _B) ZPR8:$Zd, PPRAny:$Pg, simm8_opt_lsl_i8:$imm), 1>;
  def : InstAlias<"mov $Zd, $Pg/z, $imm",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, PPRAny:$Pg, simm8_opt_lsl_i16:$imm), 1>;
  def : InstAlias<"mov $Zd, $Pg/z, $imm",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, PPRAny:$Pg, simm8_opt_lsl_i32:$imm), 1>;
  def : InstAlias<"mov $Zd, $Pg/z, $imm",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, PPRAny:$Pg, simm8_opt_lsl_i64:$imm), 1>;
}

//===----------------------------------------------------------------------===//
// SVE Memory - Gather/Scatter 32-bit Group
//===----------------------------------------------------------------------===//

class sve_mem_32b_fill<string asm>
: I<(outs ZPRAny:$Zt), (ins GPR64sp:$Rn, simm9MulVl:$imm9),
  asm, "\t$Zt, [$Rn, $imm9, mul vl]",
  "",
  []>, Sched<[]> {
  bits<5> Rn;
  bits<5> Zt;
  bits<9> imm9;
  let Inst{31-22} = 0b1000010110;
  let Inst{21-16} = imm9{8-3};
  let Inst{15-13} = 0b010;
  let Inst{12-10} = imm9{2-0};
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_32b_fill<string asm> {
  def NAME : sve_mem_32b_fill<asm>;

  def : InstAlias<asm # "\t$Zt, [$Rn]",
                  (!cast<Instruction>(NAME) ZPRAny:$Zt, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_32b_gld_sv<bits<4> opc, bit xs, string asm,
                         RegisterOperand zprext>
: I<(outs Z_s:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = opc{3-2};
  let Inst{22}    = xs;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14-13} = opc{1-0};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
  let Defs = !if(!eq(opc{0}, 1), [FFR], []);
  let Uses = !if(!eq(opc{0}, 1), [FFR], []);
}

multiclass sve_mem_32b_gld_sv_32_scaled<bits<4> opc, string asm,
                                        SDPatternOperator sxtw_op,
                                        SDPatternOperator uxtw_op,
                                        RegisterOperand sxtw_opnd,
                                        RegisterOperand uxtw_opnd,
                                        ValueType vt> {
  def _UXTW_SCALED_REAL : sve_mem_32b_gld_sv<opc, 0, asm, uxtw_opnd>;
  def _SXTW_SCALED_REAL : sve_mem_32b_gld_sv<opc, 1, asm, sxtw_opnd>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Zm]",
                  (!cast<Instruction>(NAME # _UXTW_SCALED_REAL) ZPR32:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Zm]",
                  (!cast<Instruction>(NAME # _SXTW_SCALED_REAL) ZPR32:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm), 0>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def _UXTW_SCALED : Pseudo<(outs Z_s:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm), []>,
                     PseudoInstExpansion<(!cast<Instruction>(NAME # _UXTW_SCALED_REAL) Z_s:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm)>;
  def _SXTW_SCALED : Pseudo<(outs Z_s:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm), []>,
                     PseudoInstExpansion<(!cast<Instruction>(NAME # _SXTW_SCALED_REAL) Z_s:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm)>;
  }

  def : Pat<(nxv4i32 (uxtw_op (nxv4i1 PPR:$gp), GPR64sp:$base, (nxv4i32 ZPR:$indices), vt)),
            (!cast<Instruction>(NAME # _UXTW_SCALED) PPR:$gp, GPR64sp:$base, ZPR:$indices)>;
  def : Pat<(nxv4i32 (sxtw_op (nxv4i1 PPR:$gp), GPR64sp:$base, (nxv4i32 ZPR:$indices), vt)),
            (!cast<Instruction>(NAME # _SXTW_SCALED) PPR:$gp, GPR64sp:$base, ZPR:$indices)>;
}

class sve_mem_32b_gld_vi<bits<4> opc, string asm, Operand imm_ty>
: I<(outs Z_s:$Zt), (ins PPR3bAny:$Pg, ZPR32:$Zn, imm_ty:$imm5),
  asm, "\t$Zt, $Pg/z, [$Zn, $imm5]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zn;
  bits<5> Zt;
  bits<5> imm5;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = opc{3-2};
  let Inst{22-21} = 0b01;
  let Inst{20-16} = imm5;
  let Inst{15}    = 0b1;
  let Inst{14-13} = opc{1-0};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
  let Defs = !if(!eq(opc{0}, 1), [FFR], []);
  let Uses = !if(!eq(opc{0}, 1), [FFR], []);
}

multiclass sve_mem_32b_gld_vi_32_ptrs<bits<4> opc, string asm, Operand imm_ty,
                                      SDPatternOperator op, ValueType vt> {
  def _IMM_REAL : sve_mem_32b_gld_vi<opc, asm, imm_ty>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Zn]",
                  (!cast<Instruction>(NAME # _IMM_REAL) ZPR32:$Zt, PPR3bAny:$Pg, ZPR32:$Zn, 0), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Zn, $imm5]",
                  (!cast<Instruction>(NAME # _IMM_REAL) ZPR32:$Zt, PPR3bAny:$Pg, ZPR32:$Zn, imm_ty:$imm5), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Zn]",
                  (!cast<Instruction>(NAME # _IMM_REAL) Z_s:$Zt, PPR3bAny:$Pg, ZPR32:$Zn, 0), 1>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def _IMM : Pseudo<(outs Z_s:$Zt), (ins PPR3bAny:$Pg, ZPR32:$Zn, imm_ty:$imm5), []>,
             PseudoInstExpansion<(!cast<Instruction>(NAME # _IMM_REAL) Z_s:$Zt, PPR3bAny:$Pg, ZPR32:$Zn, imm_ty:$imm5)>;
  }

  def : Pat<(nxv4i32 (op (nxv4i1 PPR:$gp), imm_ty:$index, (nxv4i32 ZPR:$ptrs), vt)),
            (!cast<Instruction>(NAME # _IMM) PPR:$gp, ZPR:$ptrs, imm_ty:$index)>;
}

class sve_mem_32b_gld_vs<bits<4> opc, bit xs, string asm,
                         RegisterOperand zprext>
: I<(outs Z_s:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = opc{3-2};
  let Inst{22}    = xs;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14-13} = opc{1-0};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
  let Defs = !if(!eq(opc{0}, 1), [FFR], []);
  let Uses = !if(!eq(opc{0}, 1), [FFR], []);
}

multiclass sve_mem_32b_gld_vs_32_unscaled<bits<4> opc, string asm,
                                          SDPatternOperator sxtw_op,
                                          SDPatternOperator uxtw_op,
                                          RegisterOperand sxtw_opnd,
                                          RegisterOperand uxtw_opnd,
                                          ValueType vt> {
  def _UXTW_REAL : sve_mem_32b_gld_vs<opc, 0, asm, uxtw_opnd>;
  def _SXTW_REAL : sve_mem_32b_gld_vs<opc, 1, asm, sxtw_opnd>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Zm]",
                  (!cast<Instruction>(NAME # _UXTW_REAL) ZPR32:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Zm]",
                  (!cast<Instruction>(NAME # _SXTW_REAL) ZPR32:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm), 0>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def _UXTW : Pseudo<(outs Z_s:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm), []>,
              PseudoInstExpansion<(!cast<Instruction>(NAME # _UXTW_REAL) Z_s:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm)>;
  def _SXTW : Pseudo<(outs Z_s:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm), []>,
              PseudoInstExpansion<(!cast<Instruction>(NAME # _SXTW_REAL) Z_s:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm)>;
  }

  def : Pat<(nxv4i32 (uxtw_op (nxv4i1 PPR:$gp), GPR64sp:$base, (nxv4i32 ZPR:$offsets), vt)),
            (!cast<Instruction>(NAME # _UXTW) PPR:$gp, GPR64sp:$base, ZPR:$offsets)>;
  def : Pat<(nxv4i32 (sxtw_op (nxv4i1 PPR:$gp), GPR64sp:$base, (nxv4i32 ZPR:$offsets), vt)),
            (!cast<Instruction>(NAME # _SXTW) PPR:$gp, GPR64sp:$base, ZPR:$offsets)>;
}

class sve_mem_32b_pfill<string asm>
: I<(outs PPRAny:$Pt), (ins GPR64sp:$Rn, simm9MulVl:$imm9),
  asm, "\t$Pt, [$Rn, $imm9, mul vl]",
  "",
  []>, Sched<[]> {
  bits<4> Pt;
  bits<5> Rn;
  bits<9> imm9;
  let Inst{31-22} = 0b1000010110;
  let Inst{21-16} = imm9{8-3};
  let Inst{15-13} = 0b000;
  let Inst{12-10} = imm9{2-0};
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pt;

  let mayLoad = 1;
}

multiclass sve_mem_32b_pfill<string asm> {
  def NAME : sve_mem_32b_pfill<asm>;

  def : InstAlias<asm # "\t$Pt, [$Rn]",
                  (!cast<Instruction>(NAME) PPRAny:$Pt, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_32b_prfm_sv<bits<2> msz, bit xs, string asm,
                          RegisterOperand zprext>
: I<(outs), (ins sve_prfop:$prfop, PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$prfop, $Pg, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<4> prfop;
  let Inst{31-23} = 0b100001000;
  let Inst{22}    = xs;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14-13} = msz;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

multiclass sve_mem_32b_prfm_sv_scaled<bits<2> msz, string asm,
                                      SDPatternOperator sxtw_op,
                                      SDPatternOperator uxtw_op,
                                      RegisterOperand sxtw_opnd,
                                      RegisterOperand uxtw_opnd,
                                      ValueType vt> {
  def _UXTW_SCALED : sve_mem_32b_prfm_sv<msz, 0, asm, uxtw_opnd>;
  def _SXTW_SCALED : sve_mem_32b_prfm_sv<msz, 1, asm, sxtw_opnd>;

  def : Pat<(uxtw_op (nxv4i1 PPR:$gp), GPR64sp:$base, (nxv4i32 ZPR:$indices), (i32 sve_prfop:$prfop), vt),
            (!cast<Instruction>(NAME # _UXTW_SCALED) sve_prfop:$prfop, PPR:$gp, GPR64sp:$base, ZPR:$indices)>;
  def : Pat<(sxtw_op (nxv4i1 PPR:$gp), GPR64sp:$base, (nxv4i32 ZPR:$indices), (i32 sve_prfop:$prfop), vt),
            (!cast<Instruction>(NAME # _SXTW_SCALED) sve_prfop:$prfop, PPR:$gp, GPR64sp:$base, ZPR:$indices)>;
}

class sve_mem_32b_prfm_vi<bits<2> msz, string asm, Operand imm_ty>
: I<(outs), (ins sve_prfop:$prfop, PPR3bAny:$Pg, ZPR32:$Zn, imm_ty:$imm5),
  asm, "\t$prfop, $Pg, [$Zn, $imm5]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zn;
  bits<5> imm5;
  bits<4> prfop;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = msz;
  let Inst{22-21} = 0b00;
  let Inst{20-16} = imm5;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;
}

multiclass sve_mem_32b_prfm_vi<bits<2> msz, string asm, Operand imm_ty,
                               SDPatternOperator prefetch, ValueType vt> {
  def NAME : sve_mem_32b_prfm_vi<msz, asm, imm_ty>;

  def : Pat<(prefetch (nxv4i1 PPR:$gp), (i64 imm_ty:$imm5), (nxv4i32 ZPR:$indices), (i32 sve_prfop:$prfop), vt),
            (!cast<Instruction>(NAME) sve_prfop:$prfop, PPR:$gp, ZPR:$indices, imm_ty:$imm5)>;

  def : InstAlias<asm # "\t$prfop, $Pg, [$Zn]",
                  (!cast<Instruction>(NAME) sve_prfop:$prfop, PPR3bAny:$Pg, ZPR32:$Zn, 0), 1>;
}

class sve_mem_ld_dup<bits<2> dtypeh, bits<2> dtypel, string asm,
                     RegisterOperand VecList, Operand immtype>
: I<(outs VecList:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, immtype:$imm6),
  asm, "\t$Zt, $Pg/z, [$Rn, $imm6]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zt;
  bits<6> imm6;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = dtypeh;
  let Inst{22}    = 1;
  let Inst{21-16} = imm6;
  let Inst{15}    = 0b1;
  let Inst{14-13} = dtypel;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_ld_dup<bits<2> dtypeh, bits<2> dtypel, string asm,
                          RegisterOperand zlistty, ZPRRegOp zprty, Operand immtype> {
  def NAME : sve_mem_ld_dup<dtypeh, dtypel, asm, zlistty, immtype>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $imm6]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, immtype:$imm6), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) zlistty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_prfm_si<bits<2> msz, string asm>
: I<(outs), (ins sve_prfop:$prfop, PPR3bAny:$Pg, GPR64sp:$Rn, simm6MulVl:$imm6),
  asm, "\t$prfop, $Pg, [$Rn, $imm6, mul vl]",
  "",
  []>, Sched<[]> {
  bits<5> Rn;
  bits<3> Pg;
  bits<6> imm6;
  bits<4> prfop;
  let Inst{31-22} = 0b1000010111;
  let Inst{21-16} = imm6;
  let Inst{15}    = 0b0;
  let Inst{14-13} = msz;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

multiclass sve_mem_prfm_si<bits<2> msz, string asm> {
  def NAME : sve_mem_prfm_si<msz, asm>;

  def : InstAlias<asm # "\t$prfop, $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) sve_prfop:$prfop, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_prfm_ss<bits<3> opc, string asm, RegisterOperand gprty>
: I<(outs), (ins sve_prfop:$prfop, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm),
  asm, "\t$prfop, $Pg, [$Rn, $Rm]",
  "",
  []>, Sched<[]> {
  bits<5> Rm;
  bits<5> Rn;
  bits<3> Pg;
  bits<4> prfop;
  let Inst{31-25} = 0b1000010;
  let Inst{24-23} = opc{2-1};
  let Inst{22-21} = 0b00;
  let Inst{20-16} = Rm;
  let Inst{15}    = 0b1;
  let Inst{14}    = opc{0};
  let Inst{13}    = 0b0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

//===----------------------------------------------------------------------===//
// SVE Compute Vector Address Group
//===----------------------------------------------------------------------===//

class sve_int_bin_cons_misc_0_a<bits<2> opc, bits<2> msz, string asm,
                                ZPRRegOp zprty, RegisterOperand zprext>
: I<(outs zprty:$Zd), (ins zprty:$Zn, zprext:$Zm),
  asm, "\t$Zd, [$Zn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-12} = 0b1010;
  let Inst{11-10} = msz;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_bin_cons_misc_0_a_uxtw<bits<2> opc, string asm> {
  def _0 : sve_int_bin_cons_misc_0_a<opc, 0b00, asm, ZPR64, ZPR64ExtUXTW8>;
  def _1 : sve_int_bin_cons_misc_0_a<opc, 0b01, asm, ZPR64, ZPR64ExtUXTW16>;
  def _2 : sve_int_bin_cons_misc_0_a<opc, 0b10, asm, ZPR64, ZPR64ExtUXTW32>;
  def _3 : sve_int_bin_cons_misc_0_a<opc, 0b11, asm, ZPR64, ZPR64ExtUXTW64>;

  def "" : Pseudo<(outs ZPR64:$Zd), (ins ZPR64:$Zn, ZPR64:$Zm, imm0_3:$msz), []>;
}

multiclass sve_int_bin_cons_misc_0_a_sxtw<bits<2> opc, string asm> {
  def _0 : sve_int_bin_cons_misc_0_a<opc, 0b00, asm, ZPR64, ZPR64ExtSXTW8>;
  def _1 : sve_int_bin_cons_misc_0_a<opc, 0b01, asm, ZPR64, ZPR64ExtSXTW16>;
  def _2 : sve_int_bin_cons_misc_0_a<opc, 0b10, asm, ZPR64, ZPR64ExtSXTW32>;
  def _3 : sve_int_bin_cons_misc_0_a<opc, 0b11, asm, ZPR64, ZPR64ExtSXTW64>;

  def "" : Pseudo<(outs ZPR64:$Zd), (ins ZPR64:$Zn, ZPR64:$Zm, imm0_3:$msz), []>;
}

multiclass sve_int_bin_cons_misc_0_a_32_lsl<bits<2> opc, string asm> {
  def _0 : sve_int_bin_cons_misc_0_a<opc, 0b00, asm, ZPR32, ZPR32ExtLSL8>;
  def _1 : sve_int_bin_cons_misc_0_a<opc, 0b01, asm, ZPR32, ZPR32ExtLSL16>;
  def _2 : sve_int_bin_cons_misc_0_a<opc, 0b10, asm, ZPR32, ZPR32ExtLSL32>;
  def _3 : sve_int_bin_cons_misc_0_a<opc, 0b11, asm, ZPR32, ZPR32ExtLSL64>;

  def "" : Pseudo<(outs ZPR32:$Zd), (ins ZPR32:$Zn, ZPR32:$Zm, imm0_3:$msz), []>;
}

multiclass sve_int_bin_cons_misc_0_a_64_lsl<bits<2> opc, string asm> {
  def _0 : sve_int_bin_cons_misc_0_a<opc, 0b00, asm, ZPR64, ZPR64ExtLSL8>;
  def _1 : sve_int_bin_cons_misc_0_a<opc, 0b01, asm, ZPR64, ZPR64ExtLSL16>;
  def _2 : sve_int_bin_cons_misc_0_a<opc, 0b10, asm, ZPR64, ZPR64ExtLSL32>;
  def _3 : sve_int_bin_cons_misc_0_a<opc, 0b11, asm, ZPR64, ZPR64ExtLSL64>;

  def "" : Pseudo<(outs ZPR64:$Zd), (ins ZPR64:$Zn, ZPR64:$Zm, imm0_3:$msz), []>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Arithmetic - Predicated Group
//===----------------------------------------------------------------------===//

class sve_fp_2op_i_p_zds<bits<2> sz, bits<3> opc, string asm,
                         ZPRRegOp zprty,
                         Operand imm_ty>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, imm_ty:$i1),
  asm, "\t$Zdn, $Pg/m, $_Zdn, $i1",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bit i1;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-6}   = 0b0000;
  let Inst{5}     = i1;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let ElementSize = zprty.EltSz;
}

multiclass sve_fp_2op_i_p_zds<bits<3> opc, string asm, string Ps,
                              Operand imm_ty> {
  let DestructiveInstType = DestructiveBinaryImm in {
  def _H : SVEPseudo2Instr<Ps # _H, 1>, sve_fp_2op_i_p_zds<0b01, opc, asm, ZPR16, imm_ty>;
  def _S : SVEPseudo2Instr<Ps # _S, 1>, sve_fp_2op_i_p_zds<0b10, opc, asm, ZPR32, imm_ty>;
  def _D : SVEPseudo2Instr<Ps # _D, 1>, sve_fp_2op_i_p_zds<0b11, opc, asm, ZPR64, imm_ty>;
  }
}

multiclass sve_fp_2op_i_p_zds_zx<Operand imm_ty> {
  def _UNDEF_H : PredTwoOpImmPseudo<NAME # _H, ZPR16, imm_ty, FalseLanesUndef>;
  def _UNDEF_S : PredTwoOpImmPseudo<NAME # _S, ZPR32, imm_ty, FalseLanesUndef>;
  def _UNDEF_D : PredTwoOpImmPseudo<NAME # _D, ZPR64, imm_ty, FalseLanesUndef>;

  def _ZERO_H : PredTwoOpImmPseudo<NAME # _H, ZPR16, imm_ty, FalseLanesZero>;
  def _ZERO_S : PredTwoOpImmPseudo<NAME # _S, ZPR32, imm_ty, FalseLanesZero>;
  def _ZERO_D : PredTwoOpImmPseudo<NAME # _D, ZPR64, imm_ty, FalseLanesZero>;
}

class sve_fp_2op_p_zds<bits<2> sz, bits<4> opc, string asm,
                       ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, zprty:$Zm),
  asm, "\t$Zdn, $Pg/m, $_Zdn, $Zm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21-20} = 0b00;
  let Inst{19-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let ElementSize = zprty.EltSz;
}

multiclass sve_fp_2op_p_zds<bits<4> opc, string asm, string Ps,
                            SDPatternOperator op, DestructiveInstTypeEnum flags,
                            string revname="", bit isOrig=0> {
  let DestructiveInstType = flags in {
  def _H : sve_fp_2op_p_zds<0b01, opc, asm, ZPR16>,
           SVEPseudo2Instr<Ps # _H, 1>, SVEInstr2Rev<NAME # _H, revname # _H, isOrig>;
  def _S : sve_fp_2op_p_zds<0b10, opc, asm, ZPR32>,
           SVEPseudo2Instr<Ps # _S, 1>, SVEInstr2Rev<NAME # _S, revname # _S, isOrig>;
  def _D : sve_fp_2op_p_zds<0b11, opc, asm, ZPR64>,
           SVEPseudo2Instr<Ps # _D, 1>, SVEInstr2Rev<NAME # _D, revname # _D, isOrig>;
  }

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8i1, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_fp_2op_p_zds_fscale<bits<4> opc, string asm,
                                   string Ps, SDPatternOperator op> {
  let DestructiveInstType = DestructiveBinary in {
  def _H : SVEPseudo2Instr<Ps # _H, 1>, sve_fp_2op_p_zds<0b01, opc, asm, ZPR16>;
  def _S : SVEPseudo2Instr<Ps # _S, 1>, sve_fp_2op_p_zds<0b10, opc, asm, ZPR32>;
  def _D : SVEPseudo2Instr<Ps # _D, 1>, sve_fp_2op_p_zds<0b11, opc, asm, ZPR64>;
  }

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8i1, nxv8f16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_fp_2op_p_zds_zx<SDPatternOperator op> {
  def _UNDEF_H : PredTwoOpPseudo<NAME # _H, ZPR16, FalseLanesUndef>;
  def _UNDEF_S : PredTwoOpPseudo<NAME # _S, ZPR32, FalseLanesUndef>;
  def _UNDEF_D : PredTwoOpPseudo<NAME # _D, ZPR64, FalseLanesUndef>;

  def _ZERO_H : PredTwoOpPseudo<NAME # _H, ZPR16, FalseLanesZero>;
  def _ZERO_S : PredTwoOpPseudo<NAME # _S, ZPR32, FalseLanesZero>;
  def _ZERO_D : PredTwoOpPseudo<NAME # _D, ZPR64, FalseLanesZero>;

  def : SVE_3_Op_Pat_SelZero<nxv8f16, op, nxv8i1, nxv8f16, nxv8f16, !cast<Pseudo>(NAME # _ZERO_H)>;
  def : SVE_3_Op_Pat_SelZero<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, !cast<Pseudo>(NAME # _ZERO_S)>;
  def : SVE_3_Op_Pat_SelZero<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, !cast<Pseudo>(NAME # _ZERO_D)>;
}

multiclass sve_fp_2op_p_zds_fscale_zx<SDPatternOperator op> {
  def _ZERO_H : PredTwoOpConstrainedPseudo<NAME # _H, ZPR16, FalseLanesZero>;
  def _ZERO_S : PredTwoOpConstrainedPseudo<NAME # _S, ZPR32, FalseLanesZero>;
  def _ZERO_D : PredTwoOpConstrainedPseudo<NAME # _D, ZPR64, FalseLanesZero>;

  def : SVE_3_Op_Pat_SelZero<nxv8f16, op, nxv8i1, nxv8f16, nxv8i16, !cast<Pseudo>(NAME # _ZERO_H)>;
  def : SVE_3_Op_Pat_SelZero<nxv4f32, op, nxv4i1, nxv4f32, nxv4i32, !cast<Pseudo>(NAME # _ZERO_S)>;
  def : SVE_3_Op_Pat_SelZero<nxv2f64, op, nxv2i1, nxv2f64, nxv2i64, !cast<Pseudo>(NAME # _ZERO_D)>;
}

class sve_fp_ftmad<bits<2> sz, string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins zprty:$_Zdn, zprty:$Zm, imm32_0_7:$imm3),
  asm, "\t$Zdn, $_Zdn, $Zm, $imm3",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<5> Zm;
  bits<3> imm3;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21-19} = 0b010;
  let Inst{18-16} = imm3;
  let Inst{15-10} = 0b100000;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_fp_ftmad<string asm, SDPatternOperator op> {
  def _H : sve_fp_ftmad<0b01, asm, ZPR16>;
  def _S : sve_fp_ftmad<0b10, asm, ZPR32>;
  def _D : sve_fp_ftmad<0b11, asm, ZPR64>;

  def : Pat<(nxv8f16 (op (nxv8f16 ZPR16:$Zn), (nxv8f16 ZPR16:$Zm), (i32 imm32_0_7:$imm))),
            (!cast<Instruction>(NAME # _H) ZPR16:$Zn, ZPR16:$Zm, imm32_0_7:$imm)>;
  def : Pat<(nxv4f32 (op (nxv4f32 ZPR32:$Zn), (nxv4f32 ZPR32:$Zm), (i32 imm32_0_7:$imm))),
            (!cast<Instruction>(NAME # _S) ZPR32:$Zn, ZPR32:$Zm, imm32_0_7:$imm)>;
  def : Pat<(nxv2f64 (op (nxv2f64 ZPR64:$Zn), (nxv2f64 ZPR64:$Zm), (i32 imm32_0_7:$imm))),
            (!cast<Instruction>(NAME # _D) ZPR64:$Zn, ZPR64:$Zm, imm32_0_7:$imm)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Arithmetic - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_cons_arit_0<bits<2> sz8_64, bits<3> opc, string asm,
                              ZPRRegOp zprty, ValueType vt, SDPatternOperator op>
: I<(outs zprty:$Zd), (ins zprty:$Zn, zprty:$Zm),
  asm, "\t$Zd, $Zn, $Zm",
  "",
  [(set (vt zprty:$Zd), (op (vt zprty:$Zn), (vt zprty:$Zm)))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b000;
  let Inst{12-10} = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_bin_cons_arit_0<bits<3> opc, string asm,
                                   SDPatternOperator op> {
  def _B : sve_int_bin_cons_arit_0<0b00, opc, asm, ZPR8, nxv16i8, op>;
  def _H : sve_int_bin_cons_arit_0<0b01, opc, asm, ZPR16, nxv8i16, op>;
  def _S : sve_int_bin_cons_arit_0<0b10, opc, asm, ZPR32, nxv4i32, op>;
  def _D : sve_int_bin_cons_arit_0<0b11, opc, asm, ZPR64, nxv2i64, op>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Fast Reduction Group
//===----------------------------------------------------------------------===//

class sve_fp_fast_red<bits<2> sz, bits<3> opc, string asm,
                      ZPRRegOp zprty, RegisterClass dstRegClass>
: I<(outs dstRegClass:$Vd), (ins PPR3bAny:$Pg, zprty:$Zn),
  asm, "\t$Vd, $Pg, $Zn",
  "",
  []>, Sched<[]> {
  bits<5> Zn;
  bits<5> Vd;
  bits<3> Pg;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21-19} = 0b000;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Vd;
}

multiclass sve_fp_fast_red<bits<3> opc, string asm, SDPatternOperator op> {
  def _H : sve_fp_fast_red<0b01, opc, asm, ZPR16, FPR16>;
  def _S : sve_fp_fast_red<0b10, opc, asm, ZPR32, FPR32>;
  def _D : sve_fp_fast_red<0b11, opc, asm, ZPR64, FPR64>;

  def : SVE_2_Op_Pat<f16, op, nxv8i1, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<f32, op, nxv4i1, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<f32, op, nxv2i1, nxv2f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<f64, op, nxv2i1, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Compare - Vectors Group
//===----------------------------------------------------------------------===//

class sve_fp_3op_p_pd<bits<2> sz, bits<3> opc, string asm, PPRRegOp pprty,
                      ZPRRegOp zprty>
: I<(outs pprty:$Pd), (ins PPR3bAny:$Pg, zprty:$Zn, zprty:$Zm),
  asm, "\t$Pd, $Pg/z, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = opc{2};
  let Inst{14}    = 0b1;
  let Inst{13}    = opc{1};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;
}

multiclass sve_fp_3op_p_pd<bits<3> opc, string asm, SDPatternOperator int_op,
                           SDPatternOperator ir_op = null_frag> {
  def _H : sve_fp_3op_p_pd<0b01, opc, asm, PPR16, ZPR16>;
  def _S : sve_fp_3op_p_pd<0b10, opc, asm, PPR32, ZPR32>;
  def _D : sve_fp_3op_p_pd<0b11, opc, asm, PPR64, ZPR64>;

  def : SVE_3_Op_Pat<nxv8i1, int_op, nxv8i1, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i1, int_op, nxv4i1, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i1, int_op, nxv2i1, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;

  def : SVE_2_Op_AllActive_Pat<nxv4i1, ir_op, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S), PTRUE_S>;
  def : SVE_2_Op_AllActive_Pat<nxv2i1, ir_op, nxv2f32, nxv2f32, !cast<Instruction>(NAME # _S), PTRUE_D>;
  def : SVE_2_Op_AllActive_Pat<nxv2i1, ir_op, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D), PTRUE_D>;
}

//===----------------------------------------------------------------------===//
// SVE Select Vectors Group
//===----------------------------------------------------------------------===//

class sve_int_sel_vvv<bits<2> sz8_64, string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins PPRAny:$Pg, zprty:$Zn, zprty:$Zm),
  asm, "\t$Zd, $Pg, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<4> Pg;
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-14} = 0b11;
  let Inst{13-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_sel_vvv<string asm, SDPatternOperator op> {
  def _B : sve_int_sel_vvv<0b00, asm, ZPR8>;
  def _H : sve_int_sel_vvv<0b01, asm, ZPR16>;
  def _S : sve_int_sel_vvv<0b10, asm, ZPR32>;
  def _D : sve_int_sel_vvv<0b11, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8i1,  nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4i1,  nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f32, op, nxv2i1,  nxv2f32, nxv2f32, !cast<Instruction>(NAME # _D)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2i1,  nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;

  def : InstAlias<"mov $Zd, $Pg/m, $Zn",
                  (!cast<Instruction>(NAME # _B) ZPR8:$Zd, PPRAny:$Pg, ZPR8:$Zn, ZPR8:$Zd), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $Zn",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, PPRAny:$Pg, ZPR16:$Zn, ZPR16:$Zd), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $Zn",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, PPRAny:$Pg, ZPR32:$Zn, ZPR32:$Zd), 1>;
  def : InstAlias<"mov $Zd, $Pg/m, $Zn",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, PPRAny:$Pg, ZPR64:$Zn, ZPR64:$Zd), 1>;
}

//===----------------------------------------------------------------------===//
// SVE Memory - Gather/Scatter 64-bit Group
//===----------------------------------------------------------------------===//

class sve_mem_64b_gld_sv<bits<4> opc, bit xs, string asm,
                         RegisterOperand zprext>
: I<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = opc{3-2};
  let Inst{22}    = xs;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14-13} = opc{1-0};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
  let Defs = !if(!eq(opc{0}, 1), [FFR], []);
  let Uses = !if(!eq(opc{0}, 1), [FFR], []);
}

multiclass sve_mem_64b_gld_sv_32_scaled<bits<4> opc, string asm,
                                        SDPatternOperator op,
                                        RegisterOperand sxtw_opnd,
                                        RegisterOperand uxtw_opnd,
                                        ValueType vt> {
  def _UXTW_SCALED_REAL : sve_mem_64b_gld_sv<opc, 0, asm, uxtw_opnd>;
  def _SXTW_SCALED_REAL : sve_mem_64b_gld_sv<opc, 1, asm, sxtw_opnd>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Zm]",
                  (!cast<Instruction>(NAME # _UXTW_SCALED_REAL) ZPR64:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Zm]",
                  (!cast<Instruction>(NAME # _SXTW_SCALED_REAL) ZPR64:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm), 0>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def _UXTW_SCALED : Pseudo<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm), []>,
                     PseudoInstExpansion<(!cast<Instruction>(NAME # _UXTW_SCALED_REAL) Z_d:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm)>;
  def _SXTW_SCALED : Pseudo<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm), []>,
                     PseudoInstExpansion<(!cast<Instruction>(NAME # _SXTW_SCALED_REAL) Z_d:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm)>;
  }

  def : Pat<(nxv2i64 (op (nxv2i1 PPR:$gp), GPR64sp:$base, (and (nxv2i64 ZPR:$indices), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))), vt)),
            (!cast<Instruction>(NAME # _UXTW_SCALED) PPR:$gp, GPR64sp:$base, ZPR:$indices)>;
  def : Pat<(nxv2i64 (op (nxv2i1 PPR:$gp), GPR64sp:$base, (sext_inreg (nxv2i64 ZPR:$indices), nxv2i32), vt)),
            (!cast<Instruction>(NAME # _SXTW_SCALED) PPR:$gp, GPR64sp:$base, ZPR:$indices)>;
}

class sve_mem_64b_gld_sv2<bits<4> opc, string asm, RegisterOperand zprext>
: I<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = opc{3-2};
  let Inst{22-21} = 0b11;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b1;
  let Inst{14-13} = opc{1-0};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
  let Defs = !if(!eq(opc{0}, 1), [FFR], []);
  let Uses = !if(!eq(opc{0}, 1), [FFR], []);
}

multiclass sve_mem_64b_gld_sv2_64_scaled<bits<4> opc, string asm,
                                         SDPatternOperator op,
                                         RegisterOperand zprext, ValueType vt> {
  def _SCALED_REAL : sve_mem_64b_gld_sv2<opc, asm, zprext>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Zm]",
                  (!cast<Instruction>(NAME # _SCALED_REAL) ZPR64:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm), 0>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def _SCALED : Pseudo<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm), []>,
                PseudoInstExpansion<(!cast<Instruction>(NAME # _SCALED_REAL) Z_d:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm)>;
  }

  def : Pat<(nxv2i64 (op (nxv2i1 PPR:$gp), GPR64sp:$base, (nxv2i64 ZPR:$indices), vt)),
            (!cast<Instruction>(NAME # _SCALED) PPR:$gp, GPR64sp:$base, ZPR:$indices)>;
}

class sve_mem_64b_gld_vi<bits<4> opc, string asm, Operand imm_ty>
: I<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, ZPR64:$Zn, imm_ty:$imm5),
  asm, "\t$Zt, $Pg/z, [$Zn, $imm5]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zn;
  bits<5> Zt;
  bits<5> imm5;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = opc{3-2};
  let Inst{22-21} = 0b01;
  let Inst{20-16} = imm5;
  let Inst{15}    = 0b1;
  let Inst{14-13} = opc{1-0};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
  let Defs = !if(!eq(opc{0}, 1), [FFR], []);
  let Uses = !if(!eq(opc{0}, 1), [FFR], []);
}

multiclass sve_mem_64b_gld_vi_64_ptrs<bits<4> opc, string asm, Operand imm_ty,
                                      SDPatternOperator op, ValueType vt> {
  def _IMM_REAL : sve_mem_64b_gld_vi<opc, asm, imm_ty>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Zn]",
                  (!cast<Instruction>(NAME # _IMM_REAL) ZPR64:$Zt, PPR3bAny:$Pg, ZPR64:$Zn, 0), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Zn, $imm5]",
                 (!cast<Instruction>(NAME # _IMM_REAL) ZPR64:$Zt, PPR3bAny:$Pg, ZPR64:$Zn, imm_ty:$imm5), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Zn]",
                  (!cast<Instruction>(NAME # _IMM_REAL) Z_d:$Zt, PPR3bAny:$Pg, ZPR64:$Zn, 0), 1>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def _IMM : Pseudo<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, ZPR64:$Zn, imm_ty:$imm5), []>,
                  PseudoInstExpansion<(!cast<Instruction>(NAME # _IMM_REAL) Z_d:$Zt, PPR3bAny:$Pg, ZPR64:$Zn, imm_ty:$imm5)>;
  }

  def : Pat<(nxv2i64 (op (nxv2i1 PPR:$gp), imm_ty:$index, (nxv2i64 ZPR:$ptrs), vt)),
            (!cast<Instruction>(NAME # _IMM) PPR:$gp, ZPR:$ptrs, imm_ty:$index)>;
}

class sve_mem_64b_gld_vs<bits<4> opc, bit xs, string asm,
                         RegisterOperand zprext>
: I<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = opc{3-2};
  let Inst{22}    = xs;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14-13} = opc{1-0};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
  let Defs = !if(!eq(opc{0}, 1), [FFR], []);
  let Uses = !if(!eq(opc{0}, 1), [FFR], []);
}

multiclass sve_mem_64b_gld_vs_32_unscaled<bits<4> opc, string asm,
                                          SDPatternOperator op,
                                          RegisterOperand sxtw_opnd,
                                          RegisterOperand uxtw_opnd,
                                          ValueType vt> {
  def _UXTW_REAL : sve_mem_64b_gld_vs<opc, 0, asm, uxtw_opnd>;
  def _SXTW_REAL : sve_mem_64b_gld_vs<opc, 1, asm, sxtw_opnd>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Zm]",
                  (!cast<Instruction>(NAME # _UXTW_REAL) ZPR64:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Zm]",
                  (!cast<Instruction>(NAME # _SXTW_REAL) ZPR64:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm), 0>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def _UXTW : Pseudo<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm), []>,
              PseudoInstExpansion<(!cast<Instruction>(NAME # _UXTW_REAL) Z_d:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm)>;
  def _SXTW : Pseudo<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm), []>,
              PseudoInstExpansion<(!cast<Instruction>(NAME # _SXTW_REAL) Z_d:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm)>;
  }

  def : Pat<(nxv2i64 (op (nxv2i1 PPR:$gp), GPR64sp:$base, (and (nxv2i64 ZPR:$offsets), (nxv2i64 (AArch64dup (i64 0xFFFFFFFF)))), vt)),
            (!cast<Instruction>(NAME # _UXTW) PPR:$gp, GPR64sp:$base, ZPR:$offsets)>;
  def : Pat<(nxv2i64 (op (nxv2i1 PPR:$gp), GPR64sp:$base, (sext_inreg (nxv2i64 ZPR:$offsets), nxv2i32), vt)),
            (!cast<Instruction>(NAME # _SXTW) PPR:$gp, GPR64sp:$base, ZPR:$offsets)>;
}

class sve_mem_64b_gld_vs2<bits<4> opc, string asm>
: I<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, ZPR64ExtLSL8:$Zm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = opc{3-2};
  let Inst{22-21} = 0b10;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b1;
  let Inst{14-13} = opc{1-0};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
  let Defs = !if(!eq(opc{0}, 1), [FFR], []);
  let Uses = !if(!eq(opc{0}, 1), [FFR], []);
}

multiclass sve_mem_64b_gld_vs2_64_unscaled<bits<4> opc, string asm,
                                           SDPatternOperator op, ValueType vt> {
  def _REAL : sve_mem_64b_gld_vs2<opc, asm>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Zm]",
                  (!cast<Instruction>(NAME # _REAL) ZPR64:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, ZPR64ExtLSL8:$Zm), 0>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def "" : Pseudo<(outs Z_d:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, ZPR64ExtLSL8:$Zm), []>,
           PseudoInstExpansion<(!cast<Instruction>(NAME # _REAL) Z_d:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, ZPR64ExtLSL8:$Zm)>;
  }

  def : Pat<(nxv2i64 (op (nxv2i1 PPR:$gp), GPR64sp:$base, (nxv2i64 ZPR:$offsets), vt)),
            (!cast<Instruction>(NAME) PPR:$gp, GPR64sp:$base, ZPR:$offsets)>;
}

class sve_mem_64b_prfm_sv<bits<2> msz, bit xs, string asm,
                          RegisterOperand zprext>
: I<(outs), (ins sve_prfop:$prfop, PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$prfop, $Pg, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<4> prfop;
  let Inst{31-23} = 0b110001000;
  let Inst{22}    = xs;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14-13} = msz;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

multiclass sve_mem_64b_prfm_sv_scaled<bits<2> msz, string asm,
                                      SDPatternOperator sxtw_op,
                                      SDPatternOperator uxtw_op,
                                      RegisterOperand sxtw_opnd,
                                      RegisterOperand uxtw_opnd,
                                      ValueType vt> {
  def _UXTW_SCALED : sve_mem_64b_prfm_sv<msz, 0, asm, uxtw_opnd>;
  def _SXTW_SCALED : sve_mem_64b_prfm_sv<msz, 1, asm, sxtw_opnd>;

  def : Pat<(uxtw_op (nxv2i1 PPR:$gp), GPR64sp:$base, (nxv2i64 ZPR:$indices), (i32 sve_prfop:$prfop), vt),
            (!cast<Instruction>(NAME # _UXTW_SCALED) sve_prfop:$prfop, PPR:$gp, GPR64sp:$base, ZPR:$indices)>;
  def : Pat<(sxtw_op (nxv2i1 PPR:$gp), GPR64sp:$base, (nxv2i64 ZPR:$indices), (i32 sve_prfop:$prfop), vt),
            (!cast<Instruction>(NAME # _SXTW_SCALED) sve_prfop:$prfop, PPR:$gp, GPR64sp:$base, ZPR:$indices)>;
}

class sve_mem_64b_prfm_sv2<bits<2> msz, string asm, RegisterOperand zprext>
: I<(outs), (ins sve_prfop:$prfop, PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$prfop, $Pg, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<4> prfop;
  let Inst{31-21} = 0b11000100011;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b1;
  let Inst{14-13} = msz;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

multiclass sve_mem_64b_prfm_sv2_vt<bits<2> msz, string asm,
                                   SDPatternOperator op,
                                   RegisterOperand zprext, ValueType vt> {
  def NAME : sve_mem_64b_prfm_sv2<msz, asm, zprext>;

  def : Pat<(op (nxv2i1 PPR:$gp), GPR64sp:$base, (nxv2i64 ZPR:$indices),
                (i32 sve_prfop:$prfop), vt),
            (!cast<Instruction>(NAME) sve_prfop:$prfop, PPR:$gp, GPR64sp:$base,
                                      ZPR:$indices)>;
}

class sve_mem_64b_prfm_vi<bits<2> msz, string asm, Operand imm_ty>
: I<(outs), (ins sve_prfop:$prfop, PPR3bAny:$Pg, ZPR64:$Zn, imm_ty:$imm5),
  asm, "\t$prfop, $Pg, [$Zn, $imm5]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zn;
  bits<5> imm5;
  bits<4> prfop;
  let Inst{31-25} = 0b1100010;
  let Inst{24-23} = msz;
  let Inst{22-21} = 0b00;
  let Inst{20-16} = imm5;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = prfop;

  let hasSideEffects = 1;
}

multiclass sve_mem_64b_prfm_vi<bits<2> msz, string asm, Operand imm_ty,
                               SDPatternOperator prefetch, ValueType vt> {
  def NAME : sve_mem_64b_prfm_vi<msz, asm, imm_ty>;

  def : Pat<(prefetch (nxv2i1 PPR:$gp), (i64 imm_ty:$imm5), (nxv2i64 ZPR:$indices), (i32 sve_prfop:$prfop), vt),
            (!cast<Instruction>(NAME) sve_prfop:$prfop, PPR:$gp, ZPR:$indices, imm_ty:$imm5)>;

  def : InstAlias<asm # "\t$prfop, $Pg, [$Zn]",
                  (!cast<Instruction>(NAME) sve_prfop:$prfop, PPR3bAny:$Pg, ZPR64:$Zn, 0), 1>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Arithmetic - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_fp_3op_u_zd<bits<2> sz, bits<3> opc, string asm,
                      ZPRRegOp zprty,
                      ValueType vt, ValueType vt2, SDPatternOperator op>
: I<(outs zprty:$Zd), (ins  zprty:$Zn, zprty:$Zm),
  asm, "\t$Zd, $Zn, $Zm",
  "",
  [(set (vt zprty:$Zd), (op (vt zprty:$Zn), (vt2 zprty:$Zm)))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b000;
  let Inst{12-10} = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_fp_3op_u_zd<bits<3> opc, string asm, SDPatternOperator op> {
  def _H : sve_fp_3op_u_zd<0b01, opc, asm, ZPR16, nxv8f16, nxv8f16, op>;
  def _S : sve_fp_3op_u_zd<0b10, opc, asm, ZPR32, nxv4f32, nxv4f32, op>;
  def _D : sve_fp_3op_u_zd<0b11, opc, asm, ZPR64, nxv2f64, nxv2f64, op>;
}

multiclass sve_fp_3op_u_zd_ftsmul<bits<3> opc, string asm,
                                  SDPatternOperator op> {
  def _H : sve_fp_3op_u_zd<0b01, opc, asm, ZPR16, nxv8f16, nxv8i16, op>;
  def _S : sve_fp_3op_u_zd<0b10, opc, asm, ZPR32, nxv4f32, nxv4i32, op>;
  def _D : sve_fp_3op_u_zd<0b11, opc, asm, ZPR64, nxv2f64, nxv2i64, op>;
}

//===----------------------------------------------------------------------===//
// SVE Permute - In Lane Group
//===----------------------------------------------------------------------===//

class sve_int_perm_bin_perm_zz<bits<3> opc, bits<2> sz8_64, string asm,
                               ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins zprty:$Zn, zprty:$Zm),
  asm, "\t$Zd, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b011;
  let Inst{12-10} = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_perm_bin_perm_zz<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _B : sve_int_perm_bin_perm_zz<opc, 0b00, asm, ZPR8>;
  def _H : sve_int_perm_bin_perm_zz<opc, 0b01, asm, ZPR16>;
  def _S : sve_int_perm_bin_perm_zz<opc, 0b10, asm, ZPR32>;
  def _D : sve_int_perm_bin_perm_zz<opc, 0b11, asm, ZPR64>;

  def : SVE_2_Op_Pat<nxv16i8, op, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_2_Op_Pat<nxv8i16, op, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4i32, op, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2i64, op, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_2_Op_Pat<nxv8f16, op, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4f16, op, nxv4f16, nxv4f16, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv4f32, op, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2f64, op, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Shift by Immediate - Predicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_pred_shift_0<bits<4> tsz8_64, bits<3> opc, string asm,
                               ZPRRegOp zprty, Operand immtype>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, immtype:$imm),
  asm, "\t$Zdn, $Pg/m, $_Zdn, $imm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<6> imm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = tsz8_64{3-2};
  let Inst{21-19} = 0b000;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-8}   = tsz8_64{1-0};
  let Inst{7-5}   = imm{2-0}; // imm3
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_bin_pred_shift_0_left<bits<3> opc, string asm> {
  def _B : sve_int_bin_pred_shift_0<{0,0,0,1}, opc, asm, ZPR8, vecshiftL8>;
  def _H : sve_int_bin_pred_shift_0<{0,0,1,?}, opc, asm, ZPR16, vecshiftL16> {
    let Inst{8} = imm{3};
  }
  def _S : sve_int_bin_pred_shift_0<{0,1,?,?}, opc, asm, ZPR32, vecshiftL32> {
    let Inst{9-8} = imm{4-3};
  }
  def _D : sve_int_bin_pred_shift_0<{1,?,?,?}, opc, asm, ZPR64, vecshiftL64> {
    let Inst{22}  = imm{5};
    let Inst{9-8} = imm{4-3};
  }
}

multiclass sve_int_bin_pred_shift_0_right<bits<3> opc, string asm, string Ps,
                                          SDPatternOperator op = null_frag> {
  let DestructiveInstType = DestructiveBinaryImm in {
  def _B : SVEPseudo2Instr<Ps # _B, 1>,
           sve_int_bin_pred_shift_0<{0,0,0,1}, opc, asm, ZPR8, vecshiftR8>;
  def _H : SVEPseudo2Instr<Ps # _H, 1>,
           sve_int_bin_pred_shift_0<{0,0,1,?}, opc, asm, ZPR16, vecshiftR16> {
    let Inst{8} = imm{3};
  }
  def _S : SVEPseudo2Instr<Ps # _S, 1>,
           sve_int_bin_pred_shift_0<{0,1,?,?}, opc, asm, ZPR32, vecshiftR32> {
    let Inst{9-8} = imm{4-3};
  }
  def _D : SVEPseudo2Instr<Ps # _D, 1>,
           sve_int_bin_pred_shift_0<{1,?,?,?}, opc, asm, ZPR64, vecshiftR64> {
    let Inst{22}  = imm{5};
    let Inst{9-8} = imm{4-3};
  }
  }

  def : Pat<(nxv16i8 (op (nxv16i1 PPR3bAny:$Pg), (nxv16i8 ZPR8:$Zn), (i32 vecshiftR8:$imm))),
            (!cast<Instruction>(NAME # _B) PPR3bAny:$Pg, ZPR8:$Zn, vecshiftR8:$imm)>;
  def : Pat<(nxv8i16 (op (nxv8i1 PPR3bAny:$Pg), (nxv8i16 ZPR16:$Zn), (i32 vecshiftR16:$imm))),
            (!cast<Instruction>(NAME # _H) PPR3bAny:$Pg, ZPR16:$Zn, vecshiftR16:$imm)>;
  def : Pat<(nxv4i32 (op (nxv4i1 PPR3bAny:$Pg), (nxv4i32 ZPR32:$Zn), (i32 vecshiftR32:$imm))),
            (!cast<Instruction>(NAME # _S) PPR3bAny:$Pg, ZPR32:$Zn, vecshiftR32:$imm)>;
  def : Pat<(nxv2i64 (op (nxv2i1 PPR3bAny:$Pg), (nxv2i64 ZPR64:$Zn), (i32 vecshiftR64:$imm))),
            (!cast<Instruction>(NAME # _D) PPR3bAny:$Pg, ZPR64:$Zn, vecshiftR64:$imm)>;
}

let AddedComplexity = 1 in {
class SVE_3_Op_Pat_Shift_Imm_SelZero<ValueType vtd, SDPatternOperator op,
                                     ValueType vt1, ValueType vt2,
                                     Operand vt3, Instruction inst>
: Pat<(vtd (op vt1:$Op1, (vselect vt1:$Op1, vt2:$Op2, (SVEDup0)), (i32 (vt3:$Op3)))),
      (inst $Op1, $Op2, vt3:$Op3)>;
}

multiclass sve_int_bin_pred_shift_0_right_zx<SDPatternOperator op = null_frag> {
  def _ZERO_B : PredTwoOpImmPseudo<NAME # _B, ZPR8, vecshiftR8, FalseLanesZero>;
  def _ZERO_H : PredTwoOpImmPseudo<NAME # _H, ZPR16, vecshiftR16, FalseLanesZero>;
  def _ZERO_S : PredTwoOpImmPseudo<NAME # _S, ZPR32, vecshiftR32, FalseLanesZero>;
  def _ZERO_D : PredTwoOpImmPseudo<NAME # _D, ZPR64, vecshiftR64, FalseLanesZero>;

  def : SVE_3_Op_Pat_Shift_Imm_SelZero<nxv16i8, op, nxv16i1, nxv16i8, vecshiftR8, !cast<Pseudo>(NAME # _ZERO_B)>;
  def : SVE_3_Op_Pat_Shift_Imm_SelZero<nxv8i16, op, nxv8i1, nxv8i16, vecshiftR16, !cast<Pseudo>(NAME # _ZERO_H)>;
  def : SVE_3_Op_Pat_Shift_Imm_SelZero<nxv4i32, op, nxv4i1, nxv4i32, vecshiftR32, !cast<Pseudo>(NAME # _ZERO_S)>;
  def : SVE_3_Op_Pat_Shift_Imm_SelZero<nxv2i64, op, nxv2i1, nxv2i64, vecshiftR64, !cast<Pseudo>(NAME # _ZERO_D)>;
}

class sve_int_bin_pred_shift_1<bits<2> sz8_64, bits<3> opc, string asm,
                               ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, zprty:$Zm),
  asm, "\t$Zdn, $Pg/m, $_Zdn, $Zm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b010;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_bin_pred_shift_1<bits<3> opc, string asm, string Ps,
                                    SDPatternOperator op, string revname, bit isOrig> {
  let DestructiveInstType = DestructiveBinaryCommWithRev in {
  def _B : sve_int_bin_pred_shift_1<0b00, opc, asm, ZPR8>,
           SVEPseudo2Instr<Ps # _B, 1>, SVEInstr2Rev<NAME # _B, revname # _B, isOrig>;
  def _H : sve_int_bin_pred_shift_1<0b01, opc, asm, ZPR16>,
           SVEPseudo2Instr<Ps # _H, 1>, SVEInstr2Rev<NAME # _H, revname # _H, isOrig>;
  def _S : sve_int_bin_pred_shift_1<0b10, opc, asm, ZPR32>,
           SVEPseudo2Instr<Ps # _S, 1>, SVEInstr2Rev<NAME # _S, revname # _S, isOrig>;
  def _D : sve_int_bin_pred_shift_1<0b11, opc, asm, ZPR64>,
           SVEPseudo2Instr<Ps # _D, 1>, SVEInstr2Rev<NAME # _D, revname # _D, isOrig>;
  }

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1,  nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_bin_pred_noncomm_zx<SDPatternOperator op> {
  def _ZERO_B : PredTwoOpConstrainedPseudo<NAME # _B, ZPR8, FalseLanesZero>;
  def _ZERO_H : PredTwoOpConstrainedPseudo<NAME # _H, ZPR16, FalseLanesZero>;
  def _ZERO_S : PredTwoOpConstrainedPseudo<NAME # _S, ZPR32, FalseLanesZero>;
  def _ZERO_D : PredTwoOpConstrainedPseudo<NAME # _D, ZPR64, FalseLanesZero>;

  def : SVE_3_Op_Pat_SelZero<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Pseudo>(NAME # _ZERO_B)>;
  def : SVE_3_Op_Pat_SelZero<nxv8i16, op, nxv8i1, nxv8i16, nxv8i16, !cast<Pseudo>(NAME # _ZERO_H)>;
  def : SVE_3_Op_Pat_SelZero<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Pseudo>(NAME # _ZERO_S)>;
  def : SVE_3_Op_Pat_SelZero<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Pseudo>(NAME # _ZERO_D)>;
}

multiclass sve_int_bin_pred_zx<SDPatternOperator op> {
  def _UNDEF_B : PredTwoOpPseudo<NAME # _B, ZPR8,  FalseLanesUndef>;
  def _UNDEF_H : PredTwoOpPseudo<NAME # _H, ZPR16, FalseLanesUndef>;
  def _UNDEF_S : PredTwoOpPseudo<NAME # _S, ZPR32, FalseLanesUndef>;
  def _UNDEF_D : PredTwoOpPseudo<NAME # _D, ZPR64, FalseLanesUndef>;

  def _ZERO_B : PredTwoOpPseudo<NAME # _B, ZPR8, FalseLanesZero>;
  def _ZERO_H : PredTwoOpPseudo<NAME # _H, ZPR16, FalseLanesZero>;
  def _ZERO_S : PredTwoOpPseudo<NAME # _S, ZPR32, FalseLanesZero>;
  def _ZERO_D : PredTwoOpPseudo<NAME # _D, ZPR64, FalseLanesZero>;

  def : SVE_3_Op_Pat_SelZero<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Pseudo>(NAME # _ZERO_B)>;
  def : SVE_3_Op_Pat_SelZero<nxv8i16, op, nxv8i1, nxv8i16, nxv8i16, !cast<Pseudo>(NAME # _ZERO_H)>;
  def : SVE_3_Op_Pat_SelZero<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Pseudo>(NAME # _ZERO_S)>;
  def : SVE_3_Op_Pat_SelZero<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Pseudo>(NAME # _ZERO_D)>;
}

class sve_int_bin_pred_shift_2<bits<2> sz8_64, bits<3> opc, string asm,
                               ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, ZPR64:$Zm),
  asm, "\t$Zdn, $Pg/m, $_Zdn, $Zm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_bin_pred_shift_2<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _B : sve_int_bin_pred_shift_2<0b00, opc, asm, ZPR8>;
  def _H : sve_int_bin_pred_shift_2<0b01, opc, asm, ZPR16>;
  def _S : sve_int_bin_pred_shift_2<0b10, opc, asm, ZPR32>;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv2i64, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1,  nxv8i16, nxv2i64, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1,  nxv4i32, nxv2i64, !cast<Instruction>(NAME # _S)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Compare - Vectors Group
//===----------------------------------------------------------------------===//

// NOTE: Covers the non-wide instructions within sve_int_cmp_0.
class sve_int_cmp<bits<2> sz8_64, bits<3> opc, string asm, PPRRegOp pprty,
                  ZPRRegOp zprty>
: I<(outs pprty:$Pd), (ins PPR3bAny:$Pg, zprty:$Zn, zprty:$Zm),
  asm, "\t$Pd, $Pg/z, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zn;
  bits<5> Zm;
  let Inst{31-24} = 0b00100100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = opc{2};
  let Inst{14}    = 0b0;
  let Inst{13}    = opc{1};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

// NOTE: Convers wide instructions within sve_int_cmp_0 and sve_int_cmp_1.
class sve_int_cmp_wide<bit cmp_1, bits<2> sz8_64, bits<3> opc, string asm,
                       PPRRegOp pprty, ZPRRegOp zprty>
: I<(outs pprty:$Pd), (ins PPR3bAny:$Pg, zprty:$Zn, ZPR64:$Zm),
  asm, "\t$Pd, $Pg/z, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00100100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = opc{2};
  let Inst{14}    = cmp_1;
  let Inst{13}    = opc{1};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

multiclass sve_int_cmp_0<bits<3> opc, string asm, SDPatternOperator op,
                         CondCode cc> {
  def _B : sve_int_cmp<0b00, opc, asm, PPR8, ZPR8>;
  def _H : sve_int_cmp<0b01, opc, asm, PPR16, ZPR16>;
  def _S : sve_int_cmp<0b10, opc, asm, PPR32, ZPR32>;
  def _D : sve_int_cmp<0b11, opc, asm, PPR64, ZPR64>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i1,  op, nxv2i1,  nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;

  def : SVE_Cmp_Pat0<nxv16i1, nxv16i8, cc, !cast<Instruction>(NAME # _B), PTRUE_B>;
  def : SVE_Cmp_Pat0<nxv8i1,  nxv8i16, cc, !cast<Instruction>(NAME # _H), PTRUE_H>;
  def : SVE_Cmp_Pat0<nxv4i1,  nxv4i32, cc, !cast<Instruction>(NAME # _S), PTRUE_S>;
  def : SVE_Cmp_Pat0<nxv2i1,  nxv2i64, cc, !cast<Instruction>(NAME # _D), PTRUE_D>;

  def : SVE_Cmp_Pat1<nxv16i1, nxv16i8, cc, !cast<Instruction>(NAME # _B)>;
  def : SVE_Cmp_Pat1<nxv8i1,  nxv8i16, cc, !cast<Instruction>(NAME # _H)>;
  def : SVE_Cmp_Pat1<nxv4i1,  nxv4i32, cc, !cast<Instruction>(NAME # _S)>;
  def : SVE_Cmp_Pat1<nxv2i1,  nxv2i64, cc, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_cmp_0_wide<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_cmp_wide<0b0, 0b00, opc, asm, PPR8, ZPR8>;
  def _H : sve_int_cmp_wide<0b0, 0b01, opc, asm, PPR16, ZPR16>;
  def _S : sve_int_cmp_wide<0b0, 0b10, opc, asm, PPR32, ZPR32>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i8, nxv2i64, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i16, nxv2i64, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i32, nxv2i64, !cast<Instruction>(NAME # _S)>;
}

multiclass sve_int_cmp_1_wide<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_cmp_wide<0b1, 0b00, opc, asm, PPR8, ZPR8>;
  def _H : sve_int_cmp_wide<0b1, 0b01, opc, asm, PPR16, ZPR16>;
  def _S : sve_int_cmp_wide<0b1, 0b10, opc, asm, PPR32, ZPR32>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i8, nxv2i64, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i16, nxv2i64, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i32, nxv2i64, !cast<Instruction>(NAME # _S)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Arithmetic - Binary Predicated Group
//===----------------------------------------------------------------------===//
class sve_int_bin_pred_arit_log<bits<2> sz8_64, bits<2> fmt, bits<3> opc,
                                string asm, ZPRRegOp zprty, SDPatternOperator op,
                                ValueType pt, ValueType zt>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, zprty:$Zm),
  asm, "\t$Zdn, $Pg/m, $_Zdn, $Zm", "", []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-19} = fmt;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b000;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_bin_pred_arit_0<bits<3> opc, string asm, string Ps,
                                   SDPatternOperator op,
                                   DestructiveInstTypeEnum flags,
                                   string revname="", bit isOrig=0> {
  let DestructiveInstType = flags in {
  def _B : sve_int_bin_pred_arit_log<0b00, 0b00, opc, asm, ZPR8, op, nxv16i1, nxv16i8>,
             SVEPseudo2Instr<Ps # _B, 1>, SVEInstr2Rev<NAME # _B, revname # _B, isOrig>;
  def _H : sve_int_bin_pred_arit_log<0b01, 0b00, opc, asm, ZPR16, op, nxv8i1, nxv8i16>,
             SVEPseudo2Instr<Ps # _H, 1>, SVEInstr2Rev<NAME # _H, revname # _H, isOrig>;
  def _S : sve_int_bin_pred_arit_log<0b10, 0b00, opc, asm, ZPR32, op, nxv4i1, nxv4i32>,
             SVEPseudo2Instr<Ps # _S, 1>, SVEInstr2Rev<NAME # _S, revname # _S, isOrig>;
  def _D : sve_int_bin_pred_arit_log<0b11, 0b00, opc, asm, ZPR64, op, nxv2i1, nxv2i64>,
             SVEPseudo2Instr<Ps # _D, 1>, SVEInstr2Rev<NAME # _D, revname # _D, isOrig>;
  }

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_bin_pred_arit_1<bits<3> opc, string asm, string Ps,
                                   SDPatternOperator op> {
  let DestructiveInstType = DestructiveBinaryComm in {
  def _B : sve_int_bin_pred_arit_log<0b00, 0b01, opc, asm, ZPR8, op, nxv16i1, nxv16i8>,
           SVEPseudo2Instr<Ps # _B, 1>;
  def _H : sve_int_bin_pred_arit_log<0b01, 0b01, opc, asm, ZPR16, op, nxv8i1, nxv8i16>,
           SVEPseudo2Instr<Ps # _H, 1>;
  def _S : sve_int_bin_pred_arit_log<0b10, 0b01, opc, asm, ZPR32, op, nxv4i1, nxv4i32>,
           SVEPseudo2Instr<Ps # _S, 1>;
  def _D : sve_int_bin_pred_arit_log<0b11, 0b01, opc, asm, ZPR64, op, nxv2i1, nxv2i64>,
           SVEPseudo2Instr<Ps # _D, 1>;
  }

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_bin_pred_arit_2<bits<3> opc, string asm, string Ps,
                                   SDPatternOperator op> {
  let DestructiveInstType = DestructiveBinaryComm in {
  def _B : sve_int_bin_pred_arit_log<0b00, 0b10, opc, asm, ZPR8, op, nxv16i1, nxv16i8>,
           SVEPseudo2Instr<Ps # _B, 1>;
  def _H : sve_int_bin_pred_arit_log<0b01, 0b10, opc, asm, ZPR16, op, nxv8i1, nxv8i16>,
           SVEPseudo2Instr<Ps # _H, 1>;
  def _S : sve_int_bin_pred_arit_log<0b10, 0b10, opc, asm, ZPR32, op, nxv4i1, nxv4i32>,
           SVEPseudo2Instr<Ps # _S, 1>;
  def _D : sve_int_bin_pred_arit_log<0b11, 0b10, opc, asm, ZPR64, op, nxv2i1, nxv2i64>,
           SVEPseudo2Instr<Ps # _D, 1>;
  }

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

// Special case for divides which are not defined for 8b/16b elements.
multiclass sve_int_bin_pred_arit_2_div<bits<3> opc, string asm, string Ps,
                                       SDPatternOperator op, string revname,
                                       bit isOrig> {
  let DestructiveInstType = DestructiveBinaryCommWithRev in {
  def _S : sve_int_bin_pred_arit_log<0b10, 0b10, opc, asm, ZPR32, op, nxv4i1, nxv4i32>,
           SVEPseudo2Instr<Ps # _S, 1>, SVEInstr2Rev<NAME # _S, revname # _S, isOrig>;
  def _D : sve_int_bin_pred_arit_log<0b11, 0b10, opc, asm, ZPR64, op, nxv2i1, nxv2i64>,
           SVEPseudo2Instr<Ps # _D, 1>, SVEInstr2Rev<NAME # _D, revname # _D, isOrig>;
  }

  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_bin_pred_arit_2_div_zx<SDPatternOperator op> {
  def _UNDEF_S : PredTwoOpPseudo<NAME # _S, ZPR32, FalseLanesUndef>;
  def _UNDEF_D : PredTwoOpPseudo<NAME # _D, ZPR64, FalseLanesUndef>;

  def _ZERO_S : PredTwoOpPseudo<NAME # _S, ZPR32, FalseLanesZero>;
  def _ZERO_D : PredTwoOpPseudo<NAME # _D, ZPR64, FalseLanesZero>;

  def : SVE_3_Op_Pat_SelZero<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Pseudo>(NAME # _ZERO_S)>;
  def : SVE_3_Op_Pat_SelZero<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Pseudo>(NAME # _ZERO_D)>;
}

multiclass sve_int_bin_pred_log<bits<3> opc, string asm, string Ps,
                                SDPatternOperator op,
                                DestructiveInstTypeEnum flags> {
  let DestructiveInstType = flags in {
  def _B : sve_int_bin_pred_arit_log<0b00, 0b11, opc, asm, ZPR8, op, nxv16i1, nxv16i8>,
           SVEPseudo2Instr<Ps # _B, 1>;
  def _H : sve_int_bin_pred_arit_log<0b01, 0b11, opc, asm, ZPR16, op, nxv8i1, nxv8i16>,
           SVEPseudo2Instr<Ps # _H, 1>;
  def _S : sve_int_bin_pred_arit_log<0b10, 0b11, opc, asm, ZPR32, op, nxv4i1, nxv4i32>,
           SVEPseudo2Instr<Ps # _S, 1>;
  def _D : sve_int_bin_pred_arit_log<0b11, 0b11, opc, asm, ZPR64, op, nxv2i1, nxv2i64>,
           SVEPseudo2Instr<Ps # _D, 1>;
  }

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i1, nxv16i8, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i1, nxv8i16, nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i1, nxv4i32, nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i1, nxv2i64, nxv2i64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
//SVE Index Generation Group
//===----------------------------------------------------------------------===//

class sve_int_index_ii<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                       Operand imm_ty, ValueType vt, SDPatternOperator op>
: I<(outs zprty:$Zd), (ins imm_ty:$imm5, imm_ty:$imm5b),
  asm, "\t$Zd, $imm5, $imm5b",
  "",
  [(set (vt zprty:$Zd), (op imm_ty:$imm5, imm_ty:$imm5b))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> imm5;
  bits<5> imm5b;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = imm5b;
  let Inst{15-10} = 0b010000;
  let Inst{9-5}   = imm5;
  let Inst{4-0}   = Zd;

  let isReMaterializable = 1;
}

multiclass sve_int_index_ii<string asm, SDPatternOperator op> {
  def _B : sve_int_index_ii<0b00, asm, ZPR8, simm5_32b, nxv16i8, op>;
  def _H : sve_int_index_ii<0b01, asm, ZPR16, simm5_32b, nxv8i16, op>;
  def _S : sve_int_index_ii<0b10, asm, ZPR32, simm5_32b, nxv4i32, op>;
  def _D : sve_int_index_ii<0b11, asm, ZPR64, simm5_64b, nxv2i64, op>;
}

class sve_int_index_ir<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                       RegisterClass srcRegType, Operand imm_ty, ValueType vt,
                       SDPatternOperator op>
: I<(outs zprty:$Zd), (ins imm_ty:$imm5, srcRegType:$Rm),
  asm, "\t$Zd, $imm5, $Rm",
  "",
  [(set (vt zprty:$Zd), (op imm_ty:$imm5, srcRegType:$Rm))]>, Sched<[]> {
  bits<5> Rm;
  bits<5> Zd;
  bits<5> imm5;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rm;
  let Inst{15-10} = 0b010010;
  let Inst{9-5}   = imm5;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_index_ir<string asm, SDPatternOperator op> {
  def _B : sve_int_index_ir<0b00, asm, ZPR8, GPR32, simm5_32b, nxv16i8, op>;
  def _H : sve_int_index_ir<0b01, asm, ZPR16, GPR32, simm5_32b, nxv8i16, op>;
  def _S : sve_int_index_ir<0b10, asm, ZPR32, GPR32, simm5_32b, nxv4i32, op>;
  def _D : sve_int_index_ir<0b11, asm, ZPR64, GPR64, simm5_64b, nxv2i64, op>;
}

class sve_int_index_ri<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                       RegisterClass srcRegType, Operand imm_ty, ValueType vt,
                       SDPatternOperator op>
: I<(outs zprty:$Zd), (ins srcRegType:$Rn, imm_ty:$imm5),
  asm, "\t$Zd, $Rn, $imm5",
  "",
  [(set (vt zprty:$Zd), (op srcRegType:$Rn, imm_ty:$imm5))]>, Sched<[]> {
  bits<5> Rn;
  bits<5> Zd;
  bits<5> imm5;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = imm5;
  let Inst{15-10} = 0b010001;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_index_ri<string asm, SDPatternOperator op> {
  def _B : sve_int_index_ri<0b00, asm, ZPR8, GPR32, simm5_32b, nxv16i8, op>;
  def _H : sve_int_index_ri<0b01, asm, ZPR16, GPR32, simm5_32b, nxv8i16, op>;
  def _S : sve_int_index_ri<0b10, asm, ZPR32, GPR32, simm5_32b, nxv4i32, op>;
  def _D : sve_int_index_ri<0b11, asm, ZPR64, GPR64, simm5_64b, nxv2i64, op>;
}

class sve_int_index_rr<bits<2> sz8_64, string asm, ZPRRegOp zprty,
                       RegisterClass srcRegType, ValueType vt,
                       SDPatternOperator op>
: I<(outs zprty:$Zd), (ins srcRegType:$Rn, srcRegType:$Rm),
  asm, "\t$Zd, $Rn, $Rm",
  "",
  [(set (vt zprty:$Zd), (op srcRegType:$Rn, srcRegType:$Rm))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> Rm;
  bits<5> Rn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rm;
  let Inst{15-10} = 0b010011;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_index_rr<string asm, SDPatternOperator op> {
  def _B : sve_int_index_rr<0b00, asm, ZPR8, GPR32, nxv16i8, op>;
  def _H : sve_int_index_rr<0b01, asm, ZPR16, GPR32, nxv8i16, op>;
  def _S : sve_int_index_rr<0b10, asm, ZPR32, GPR32, nxv4i32, op>;
  def _D : sve_int_index_rr<0b11, asm, ZPR64, GPR64, nxv2i64, op>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Wide Immediate - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_int_arith_imm0<bits<2> sz8_64, bits<3> opc, string asm,
                         ZPRRegOp zprty, Operand immtype>
: I<(outs zprty:$Zdn), (ins zprty:$_Zdn, immtype:$imm),
  asm, "\t$Zdn, $_Zdn, $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<9> imm;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b100;
  let Inst{18-16} = opc;
  let Inst{15-14} = 0b11;
  let Inst{13}    = imm{8};   // sh
  let Inst{12-5}  = imm{7-0}; // imm8
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveBinaryShImmUnpred;
}

multiclass sve_int_arith_imm0<bits<3> opc, string Ps, string asm> {
  def _B : sve_int_arith_imm0<0b00, opc, asm, ZPR8, uimm8_opt_lsl_i8>,
           SVEPseudo2Instr<Ps # _B, 1>;
  def _H : sve_int_arith_imm0<0b01, opc, asm, ZPR16, uimm8_opt_lsl_i16>,
           SVEPseudo2Instr<Ps # _H, 1>;
  def _S : sve_int_arith_imm0<0b10, opc, asm, ZPR32, uimm8_opt_lsl_i32>,
           SVEPseudo2Instr<Ps # _S, 1>;
  def _D : sve_int_arith_imm0<0b11, opc, asm, ZPR64, uimm8_opt_lsl_i64>,
           SVEPseudo2Instr<Ps # _D, 1>;
}

multiclass sve_int_arith_imm0_zzi {
  def _B : UnpredTwoOpImmPseudo<NAME # _B, ZPR8, uimm8_opt_lsl_i8>;
  def _H : UnpredTwoOpImmPseudo<NAME # _H, ZPR16, uimm8_opt_lsl_i16>;
  def _S : UnpredTwoOpImmPseudo<NAME # _S, ZPR32, uimm8_opt_lsl_i32>;
  def _D : UnpredTwoOpImmPseudo<NAME # _D, ZPR64, uimm8_opt_lsl_i64>;
}

class sve_int_arith_imm1<bits<2> sz8_64, bits<3> opc, string asm,
                         ZPRRegOp zprty, Operand immtype>
: I<(outs zprty:$Zdn), (ins zprty:$_Zdn, immtype:$imm),
  asm, "\t$Zdn, $_Zdn, $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<8> imm;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b101;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b110;
  let Inst{12-5} = imm;
  let Inst{4-0} = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_int_arith_imm1<bits<3> opc, string asm, Operand immtype> {
  def _B : sve_int_arith_imm1<0b00, opc, asm, ZPR8, immtype>;
  def _H : sve_int_arith_imm1<0b01, opc, asm, ZPR16, immtype>;
  def _S : sve_int_arith_imm1<0b10, opc, asm, ZPR32, immtype>;
  def _D : sve_int_arith_imm1<0b11, opc, asm, ZPR64, immtype>;
}

class sve_int_arith_imm2<bits<2> sz8_64, bits<3> opc, string asm,
                         ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins zprty:$_Zdn, simm8:$imm),
  asm, "\t$Zdn, $_Zdn, $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<8> imm;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b110;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b110;
  let Inst{12-5} = imm;
  let Inst{4-0} = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_int_arith_imm2<bits<3> opc, string asm> {
  def _B : sve_int_arith_imm2<0b00, opc, asm, ZPR8>;
  def _H : sve_int_arith_imm2<0b01, opc, asm, ZPR16>;
  def _S : sve_int_arith_imm2<0b10, opc, asm, ZPR32>;
  def _D : sve_int_arith_imm2<0b11, opc, asm, ZPR64>;
}

class sve_int_dup_fpimm<bits<2> sz8_64, bits<3> opc, Operand fpimmtype,
                        string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins fpimmtype:$imm8),
  asm, "\t$Zd, $imm8",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<8> imm8;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b111;
  let Inst{18-17} = opc{2-1};
  let Inst{16-14} = 0b111;
  let Inst{13}    = opc{0};
  let Inst{12-5}  = imm8;
  let Inst{4-0}   = Zd;

  let isReMaterializable = 1;
}

multiclass sve_int_dup_fpimm<bits<3> opc, string asm> {
  def _H : sve_int_dup_fpimm<0b01, opc, sve_fpimm16, asm, ZPR16>;
  def _S : sve_int_dup_fpimm<0b10, opc, sve_fpimm32, asm, ZPR32>;
  def _D : sve_int_dup_fpimm<0b11, opc, sve_fpimm64, asm, ZPR64>;

  def : InstAlias<"fmov $Zd, $imm8",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, sve_fpimm16:$imm8), 1>;
  def : InstAlias<"fmov $Zd, $imm8",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, sve_fpimm32:$imm8), 1>;
  def : InstAlias<"fmov $Zd, $imm8",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, sve_fpimm64:$imm8), 1>;
}

class sve_int_dup_imm<bits<2> sz8_64, bits<2> opc, string asm,
                      ZPRRegOp zprty, Operand immtype>
: I<(outs zprty:$Zd), (ins immtype:$imm),
  asm, "\t$Zd, $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<9> imm;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b111;
  let Inst{18-17} = opc;
  let Inst{16-14} = 0b011;
  let Inst{13}    = imm{8};   // sh
  let Inst{12-5}  = imm{7-0}; // imm8
  let Inst{4-0}   = Zd;

  let isReMaterializable = 1;
}

multiclass sve_int_dup_imm<bits<2> opc, string asm> {
  def _B : sve_int_dup_imm<0b00, opc, asm, ZPR8, simm8_opt_lsl_i8>;
  def _H : sve_int_dup_imm<0b01, opc, asm, ZPR16, simm8_opt_lsl_i16>;
  def _S : sve_int_dup_imm<0b10, opc, asm, ZPR32, simm8_opt_lsl_i32>;
  def _D : sve_int_dup_imm<0b11, opc, asm, ZPR64, simm8_opt_lsl_i64>;

  def : InstAlias<"mov $Zd, $imm",
                  (!cast<Instruction>(NAME # _B) ZPR8:$Zd, simm8_opt_lsl_i8:$imm), 1>;
  def : InstAlias<"mov $Zd, $imm",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, simm8_opt_lsl_i16:$imm), 1>;
  def : InstAlias<"mov $Zd, $imm",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, simm8_opt_lsl_i32:$imm), 1>;
  def : InstAlias<"mov $Zd, $imm",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, simm8_opt_lsl_i64:$imm), 1>;

  def : InstAlias<"fmov $Zd, $imm",
                  (!cast<Instruction>(NAME # _H) ZPR16:$Zd, sve_fpzero:$imm), 0>;
  def : InstAlias<"fmov $Zd, $imm",
                  (!cast<Instruction>(NAME # _S) ZPR32:$Zd, sve_fpzero:$imm), 0>;
  def : InstAlias<"fmov $Zd, $imm",
                  (!cast<Instruction>(NAME # _D) ZPR64:$Zd, sve_fpzero_f64:$imm), 0>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Arithmetic - Unary Predicated Group
//===----------------------------------------------------------------------===//

class sve_int_un_pred_arit_0<bits<2> sz8_64, bits<3> opc, string asm,
                             ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins zprty:$_Zd, PPR3bAny:$Pg, zprty:$Zn),
  asm, "\t$Zd, $Pg/m, $Zn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b010;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
  let DestructiveInstType = DestructiveUnary;
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_un_pred_arit_0<bits<3> opc, string asm,
                                  SDPatternOperator op> {
  def _B : sve_int_un_pred_arit_0<0b00, opc, asm, ZPR8>;
  def _H : sve_int_un_pred_arit_0<0b01, opc, asm, ZPR16>;
  def _S : sve_int_un_pred_arit_0<0b10, opc, asm, ZPR32>;
  def _D : sve_int_un_pred_arit_0<0b11, opc, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i8, nxv16i1, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i16, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_un_pred_arit_0_h<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _H : sve_int_un_pred_arit_0<0b01, opc, asm, ZPR16>;
  def _S : sve_int_un_pred_arit_0<0b10, opc, asm, ZPR32>;
  def _D : sve_int_un_pred_arit_0<0b11, opc, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i16, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_un_pred_arit_0_w<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _S : sve_int_un_pred_arit_0<0b10, opc, asm, ZPR32>;
  def _D : sve_int_un_pred_arit_0<0b11, opc, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_un_pred_arit_0_d<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _D : sve_int_un_pred_arit_0<0b11, opc, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

class sve_int_un_pred_arit_1<bits<2> sz8_64, bits<3> opc, string asm,
                             ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins zprty:$_Zd, PPR3bAny:$Pg, zprty:$Zn),
  asm, "\t$Zd, $Pg/m, $Zn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
  let DestructiveInstType = DestructiveUnary;
  let ElementSize = zprty.EltSz;
}

multiclass sve_int_un_pred_arit_1<bits<3> opc, string asm,
                                  SDPatternOperator op> {
  def _B : sve_int_un_pred_arit_1<0b00, opc, asm, ZPR8>;
  def _H : sve_int_un_pred_arit_1<0b01, opc, asm, ZPR16>;
  def _S : sve_int_un_pred_arit_1<0b10, opc, asm, ZPR32>;
  def _D : sve_int_un_pred_arit_1<0b11, opc, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv16i8, op, nxv16i8, nxv16i1, nxv16i8, !cast<Instruction>(NAME # _B)>;
  def : SVE_3_Op_Pat<nxv8i16, op, nxv8i16, nxv8i1,  nxv8i16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32, nxv4i1,  nxv4i32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64, nxv2i1,  nxv2i64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_int_un_pred_arit_1_fp<bits<3> opc, string asm,
                                     SDPatternOperator op> {
  def _H : sve_int_un_pred_arit_1<0b01, opc, asm, ZPR16>;
  def _S : sve_int_un_pred_arit_1<0b10, opc, asm, ZPR32>;
  def _D : sve_int_un_pred_arit_1<0b11, opc, asm, ZPR64>;

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8f16, nxv8i1, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4f32, nxv4i1, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2f64, nxv2i1, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Shift by Immediate - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_cons_shift_a<bits<2> sz8_64, bits<2> opc, string asm,
                               ZPRRegOp zprty>
: I<(outs zprty:$Zd), (ins zprty:$Zn, ZPR64:$Zm),
  asm, "\t$Zd, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-12} = 0b1000;
  let Inst{11-10} = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_bin_cons_shift_a<bits<2> opc, string asm> {
  def _B : sve_int_bin_cons_shift_a<0b00, opc, asm, ZPR8>;
  def _H : sve_int_bin_cons_shift_a<0b01, opc, asm, ZPR16>;
  def _S : sve_int_bin_cons_shift_a<0b10, opc, asm, ZPR32>;
}

class sve_int_bin_cons_shift_b<bits<4> tsz8_64, bits<2> opc, string asm,
                               ZPRRegOp zprty, Operand immtype, ValueType vt,
                               SDPatternOperator op>
: I<(outs zprty:$Zd), (ins zprty:$Zn, immtype:$imm),
  asm, "\t$Zd, $Zn, $imm",
  "",
  [(set (vt zprty:$Zd), (op (vt zprty:$Zn), immtype:$imm))]>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  bits<6> imm;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = tsz8_64{3-2};
  let Inst{21}    = 0b1;
  let Inst{20-19} = tsz8_64{1-0};
  let Inst{18-16} = imm{2-0}; // imm3
  let Inst{15-12} = 0b1001;
  let Inst{11-10} = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_int_bin_cons_shift_b_left<bits<2> opc, string asm,
                                         SDPatternOperator op> {
  def _B : sve_int_bin_cons_shift_b<{0,0,0,1}, opc, asm, ZPR8, vecshiftL8, nxv16i8, op>;
  def _H : sve_int_bin_cons_shift_b<{0,0,1,?}, opc, asm, ZPR16, vecshiftL16, nxv8i16, op> {
    let Inst{19} = imm{3};
  }
  def _S : sve_int_bin_cons_shift_b<{0,1,?,?}, opc, asm, ZPR32, vecshiftL32, nxv4i32, op> {
    let Inst{20-19} = imm{4-3};
  }
  def _D : sve_int_bin_cons_shift_b<{1,?,?,?}, opc, asm, ZPR64, vecshiftL64, nxv2i64, op> {
    let Inst{22}    = imm{5};
    let Inst{20-19} = imm{4-3};
  }
}

multiclass sve_int_bin_cons_shift_b_right<bits<2> opc, string asm,
                                          SDPatternOperator op> {
  def _B : sve_int_bin_cons_shift_b<{0,0,0,1}, opc, asm, ZPR8, vecshiftR8, nxv16i8, op>;
  def _H : sve_int_bin_cons_shift_b<{0,0,1,?}, opc, asm, ZPR16, vecshiftR16, nxv8i16, op> {
    let Inst{19} = imm{3};
  }
  def _S : sve_int_bin_cons_shift_b<{0,1,?,?}, opc, asm, ZPR32, vecshiftR32, nxv4i32, op> {
    let Inst{20-19} = imm{4-3};
  }
  def _D : sve_int_bin_cons_shift_b<{1,?,?,?}, opc, asm, ZPR64, vecshiftR64, nxv2i64, op> {
    let Inst{22}    = imm{5};
    let Inst{20-19} = imm{4-3};
  }
}

//===----------------------------------------------------------------------===//
// SVE Integer Compare - Scalars Group
//===----------------------------------------------------------------------===//

class sve_int_cterm<bit sz, bit opc, string asm, RegisterClass rt>
: I<(outs), (ins rt:$Rn, rt:$Rm),
  asm, "\t$Rn, $Rm",
  "",
  []>, Sched<[]> {
  bits<5> Rm;
  bits<5> Rn;
  let Inst{31-23} = 0b001001011;
  let Inst{22}    = sz;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rm;
  let Inst{15-10} = 0b001000;
  let Inst{9-5}   = Rn;
  let Inst{4}     = opc;
  let Inst{3-0}   = 0b0000;

  let Defs = [NZCV];
}

class sve_int_while4_rr<bits<2> sz8_64, bits<3> opc, string asm, PPRRegOp pprty,
                        ValueType vt, SDPatternOperator op>
: I<(outs pprty:$Pd), (ins GPR32:$Rn, GPR32:$Rm),
  asm, "\t$Pd, $Rn, $Rm",
  "",
  [(set (vt pprty:$Pd), (op GPR32:$Rn, GPR32:$Rm))]>, Sched<[]> {
  bits<4> Pd;
  bits<5> Rm;
  bits<5> Rn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rm;
  let Inst{15-12} = 0b0000;
  let Inst{11-10} = opc{2-1};
  let Inst{9-5}   = Rn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

multiclass sve_int_while4_rr<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_while4_rr<0b00, opc, asm, PPR8, nxv16i1, op>;
  def _H : sve_int_while4_rr<0b01, opc, asm, PPR16, nxv8i1, op>;
  def _S : sve_int_while4_rr<0b10, opc, asm, PPR32, nxv4i1, op>;
  def _D : sve_int_while4_rr<0b11, opc, asm, PPR64, nxv2i1, op>;
}

class sve_int_while8_rr<bits<2> sz8_64, bits<3> opc, string asm, PPRRegOp pprty,
                        ValueType vt, SDPatternOperator op>
: I<(outs pprty:$Pd), (ins GPR64:$Rn, GPR64:$Rm),
  asm, "\t$Pd, $Rn, $Rm",
  "",
  [(set (vt pprty:$Pd), (op GPR64:$Rn, GPR64:$Rm))]>, Sched<[]> {
  bits<4> Pd;
  bits<5> Rm;
  bits<5> Rn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Rm;
  let Inst{15-12} = 0b0001;
  let Inst{11-10} = opc{2-1};
  let Inst{9-5}   = Rn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

multiclass sve_int_while8_rr<bits<3> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_while8_rr<0b00, opc, asm, PPR8, nxv16i1, op>;
  def _H : sve_int_while8_rr<0b01, opc, asm, PPR16, nxv8i1, op>;
  def _S : sve_int_while8_rr<0b10, opc, asm, PPR32, nxv4i1, op>;
  def _D : sve_int_while8_rr<0b11, opc, asm, PPR64, nxv2i1, op>;
}

//===----------------------------------------------------------------------===//
// SVE Memory - Store Group
//===----------------------------------------------------------------------===//

class sve_mem_cst_si<bits<2> msz, bits<2> esz, string asm,
                     RegisterOperand VecList>
: I<(outs), (ins VecList:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4),
  asm, "\t$Zt, $Pg, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zt;
  bits<4> imm4;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = msz;
  let Inst{22-21} = esz;
  let Inst{20}    = 0;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_cst_si<bits<2> msz, bits<2> esz, string asm,
                          RegisterOperand listty, ZPRRegOp zprty>
{
  def NAME : sve_mem_cst_si<msz, esz, asm, listty>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn, $imm4, mul vl]",
                 (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) listty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_est_si<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                     string asm, Operand immtype>
: I<(outs), (ins VecList:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, immtype:$imm4),
  asm, "\t$Zt, $Pg, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zt;
  bits<4> imm4;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = sz;
  let Inst{22-21} = nregs;
  let Inst{20}    = 1;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_est_si<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                          string asm, Operand immtype> {
  def NAME : sve_mem_est_si<sz, nregs, VecList, asm, immtype>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) VecList:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_cst_ss_base<bits<4> dtype, bit l, string asm,
                          RegisterOperand listty, RegisterOperand gprty>
: I<(outs), (ins listty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm),
  asm, "\t$Zt, $Pg, [$Rn, $Rm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-21} = dtype;
  let Inst{20-16} = Rm;
  let Inst{15}    = 0b0;
  let Inst{14}    = l;
  let Inst{13}    = 0b0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_cst_ss<bits<4> dtype, bit l, string asm,
                          RegisterOperand listty, ZPRRegOp zprty,
                          RegisterOperand gprty> {
  def NAME : sve_mem_cst_ss_base<dtype, l, asm, listty, gprty>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn, $Rm]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm), 0>;
}

class sve_mem_est_ss<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                     string asm, RegisterOperand gprty>
: I<(outs), (ins VecList:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm),
  asm, "\t$Zt, $Pg, [$Rn, $Rm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = sz;
  let Inst{22-21} = nregs;
  let Inst{20-16} = Rm;
  let Inst{15-13} = 0b011;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

class sve_mem_cstnt_si<bits<2> msz, string asm, RegisterOperand VecList>
: I<(outs), (ins VecList:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4),
  asm, "\t$Zt, $Pg, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zt;
  bits<4> imm4;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = msz;
  let Inst{22-20} = 0b001;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_cstnt_si<bits<2> msz, string asm, RegisterOperand listty,
                            ZPRRegOp zprty> {
  def NAME : sve_mem_cstnt_si<msz, asm, listty>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn, $imm4, mul vl]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn]",
                  (!cast<Instruction>(NAME) listty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_cstnt_ss_base<bits<3> opc, string asm, RegisterOperand listty,
                            RegisterOperand gprty>
: I<(outs), (ins listty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm),
  asm, "\t$Zt, $Pg, [$Rn, $Rm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = opc{2-1}; // msz
  let Inst{22-21} = 0b00;
  let Inst{20-16} = Rm;
  let Inst{15}    = 0b0;
  let Inst{14}    = opc{0};   // l
  let Inst{13}    = 0b1;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_cstnt_ss<bits<3> opc, string asm, RegisterOperand listty,
                            ZPRRegOp zprty, RegisterOperand gprty> {
  def NAME : sve_mem_cstnt_ss_base<opc, asm, listty, gprty>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn, $Rm]",
                 (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm), 0>;
}

class sve_mem_pspill<string asm>
: I<(outs), (ins PPRAny:$Pt, GPR64sp:$Rn, simm9MulVl:$imm9),
  asm, "\t$Pt, [$Rn, $imm9, mul vl]",
  "",
  []>, Sched<[]> {
  bits<4> Pt;
  bits<5> Rn;
  bits<9> imm9;
  let Inst{31-22} = 0b1110010110;
  let Inst{21-16} = imm9{8-3};
  let Inst{15-13} = 0b000;
  let Inst{12-10} = imm9{2-0};
  let Inst{9-5}   = Rn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pt;

  let mayStore = 1;
}

multiclass sve_mem_pspill<string asm> {
  def NAME : sve_mem_pspill<asm>;

  def : InstAlias<asm # "\t$Pt, [$Rn]",
                  (!cast<Instruction>(NAME) PPRAny:$Pt, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_spill<string asm>
: I<(outs), (ins ZPRAny:$Zt, GPR64sp:$Rn, simm9MulVl:$imm9),
  asm, "\t$Zt, [$Rn, $imm9, mul vl]",
  "",
  []>, Sched<[]> {
  bits<5> Rn;
  bits<5> Zt;
  bits<9> imm9;
  let Inst{31-22} = 0b1110010110;
  let Inst{21-16} = imm9{8-3};
  let Inst{15-13} = 0b010;
  let Inst{12-10} = imm9{2-0};
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_spill<string asm> {
  def NAME : sve_mem_spill<asm>;

  def : InstAlias<asm # "\t$Zt, [$Rn]",
                  (!cast<Instruction>(NAME) ZPRAny:$Zt, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_sst_sv<bits<3> opc, bit xs, string asm,
                     RegisterOperand VecList, RegisterOperand zprext>
: I<(outs), (ins VecList:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$Zt, $Pg, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-22} = opc;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b1;
  let Inst{14}    = xs;
  let Inst{13}    = 0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_sst_sv_32_scaled<bits<3> opc, string asm,
                                    RegisterOperand listty,
                                    ZPRRegOp zprty,
                                    RegisterOperand sxtw_opnd,
                                    RegisterOperand uxtw_opnd > {
  def _UXTW_SCALED : sve_mem_sst_sv<opc, 0, asm, listty, uxtw_opnd>;
  def _SXTW_SCALED : sve_mem_sst_sv<opc, 1, asm, listty, sxtw_opnd>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn, $Zm]",
                 (!cast<Instruction>(NAME # _UXTW_SCALED) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn, $Zm]",
                 (!cast<Instruction>(NAME # _SXTW_SCALED) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm), 0>;
}

class sve_mem_sst_sv2<bits<2> msz, string asm, RegisterOperand zprext>
: I<(outs), (ins Z_d:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$Zt, $Pg, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = msz;
  let Inst{22-21} = 0b01;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_sst_sv2_64_scaled<bits<2> msz, string asm,
                                     RegisterOperand zprext> {
  def "" : sve_mem_sst_sv2<msz, asm, zprext>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn, $Zm]",
                 (!cast<Instruction>(NAME) ZPR64:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm), 0>;

}

class sve_mem_sst_vi<bits<3> opc, string asm, ZPRRegOp zprty,
                     RegisterOperand VecList, Operand imm_ty>
: I<(outs), (ins VecList:$Zt, PPR3bAny:$Pg, zprty:$Zn, imm_ty:$imm5),
  asm, "\t$Zt, $Pg, [$Zn, $imm5]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> imm5;
  bits<5> Zn;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = opc{2-1};
  let Inst{22}    = 0b1;
  let Inst{21}    = opc{0};
  let Inst{20-16} = imm5;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_sst_vi_ptrs<bits<3> opc, string asm, RegisterOperand listty,
                               ZPRRegOp zprty, Operand imm_ty> {
  def _IMM : sve_mem_sst_vi<opc, asm, zprty, listty, imm_ty>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Zn]",
                  (!cast<Instruction>(NAME # _IMM) zprty:$Zt, PPR3bAny:$Pg, zprty:$Zn, 0), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Zn, $imm5]",
                  (!cast<Instruction>(NAME # _IMM) zprty:$Zt, PPR3bAny:$Pg, zprty:$Zn, imm_ty:$imm5), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Zn]",
                  (!cast<Instruction>(NAME # _IMM) listty:$Zt, PPR3bAny:$Pg, zprty:$Zn, 0), 1>;
}

class sve_mem_sst_vs<bits<3> opc, bit xs, string asm,
                     RegisterOperand VecList, RegisterOperand zprext>
: I<(outs), (ins VecList:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, zprext:$Zm),
  asm, "\t$Zt, $Pg, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-22} = opc;
  let Inst{21}    = 0b0;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b1;
  let Inst{14}    = xs;
  let Inst{13}    = 0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_sst_vs_32_unscaled<bits<3> opc, string asm,
                                      RegisterOperand listty,
                                      ZPRRegOp zprty,
                                      RegisterOperand sxtw_opnd,
                                      RegisterOperand uxtw_opnd> {
  def _UXTW : sve_mem_sst_vs<opc, 0, asm, listty, uxtw_opnd>;
  def _SXTW : sve_mem_sst_vs<opc, 1, asm, listty, sxtw_opnd>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn, $Zm]",
                 (!cast<Instruction>(NAME # _UXTW) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, uxtw_opnd:$Zm), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn, $Zm]",
                 (!cast<Instruction>(NAME # _SXTW) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, sxtw_opnd:$Zm), 0>;
}

class sve_mem_sst_vs2<bits<2> msz, string asm>
: I<(outs), (ins Z_d:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, ZPR64ExtLSL8:$Zm),
  asm, "\t$Zt, $Pg, [$Rn, $Zm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zm;
  bits<5> Zt;
  let Inst{31-25} = 0b1110010;
  let Inst{24-23} = msz;
  let Inst{22-21} = 0b00;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayStore = 1;
}

multiclass sve_mem_sst_vs2_64_unscaled<bits<2> msz, string asm> {
  def "" : sve_mem_sst_vs2<msz, asm>;

  def : InstAlias<asm # "\t$Zt, $Pg, [$Rn, $Zm]",
                 (!cast<Instruction>(NAME) ZPR64:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, ZPR64ExtLSL8:$Zm), 0>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Compare - Unsigned Immediate Group
//===----------------------------------------------------------------------===//

class sve_int_ucmp_vi<bits<2> sz8_64, bits<2> opc, string asm, PPRRegOp pprty,
                      ZPRRegOp zprty, Operand immtype>
: I<(outs pprty:$Pd), (ins PPR3bAny:$Pg, zprty:$Zn, immtype:$imm7),
  asm, "\t$Pd, $Pg/z, $Zn, $imm7",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zn;
  bits<7> imm7;
  let Inst{31-24} = 0b00100100;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 1;
  let Inst{20-14} = imm7;
  let Inst{13}    = opc{1};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

multiclass sve_int_ucmp_vi<bits<2> opc, string asm, CondCode cc,
                           SDPatternOperator op = null_frag,
                           SDPatternOperator inv_op = null_frag> {
  def _B : sve_int_ucmp_vi<0b00, opc, asm, PPR8, ZPR8, imm0_127>;
  def _H : sve_int_ucmp_vi<0b01, opc, asm, PPR16, ZPR16, imm0_127>;
  def _S : sve_int_ucmp_vi<0b10, opc, asm, PPR32, ZPR32, imm0_127>;
  def _D : sve_int_ucmp_vi<0b11, opc, asm, PPR64, ZPR64, uimm7_64b>;

  // IR version
  def : Pat<(nxv16i1 (setcc (nxv16i8 ZPR:$Zs1),
                            (nxv16i8 (AArch64dup (imm0_127:$imm))),
                            cc)),
            (!cast<Instruction>(NAME # "_B") (PTRUE_B 31), ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv8i1 (setcc (nxv8i16 ZPR:$Zs1),
                           (nxv8i16 (AArch64dup (imm0_127:$imm))),
                           cc)),
            (!cast<Instruction>(NAME # "_H") (PTRUE_H 31), ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv4i1 (setcc (nxv4i32 ZPR:$Zs1),
                           (nxv4i32 (AArch64dup (imm0_127:$imm))),
                           cc)),
            (!cast<Instruction>(NAME # "_S") (PTRUE_S 31), ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv2i1 (setcc (nxv2i64 ZPR:$Zs1),
                           (nxv2i64 (AArch64dup (uimm7_64b:$imm))),
                           cc)),
            (!cast<Instruction>(NAME # "_D") (PTRUE_D 31), ZPR:$Zs1, uimm7_64b:$imm)>;

  // Intrinsic version
  def : Pat<(nxv16i1 (op (nxv16i1 PPR_3b:$Pg),
                         (nxv16i8 ZPR:$Zs1),
                         (nxv16i8 (AArch64dup (imm0_127:$imm))))),
            (!cast<Instruction>(NAME # "_B") PPR_3b:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv8i1 (op (nxv8i1 PPR_3b:$Pg),
                        (nxv8i16 ZPR:$Zs1),
                        (nxv8i16 (AArch64dup (imm0_127:$imm))))),
            (!cast<Instruction>(NAME # "_H") PPR_3b:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv4i1 (op (nxv4i1 PPR_3b:$Pg),
                        (nxv4i32 ZPR:$Zs1),
                        (nxv4i32 (AArch64dup (imm0_127:$imm))))),
            (!cast<Instruction>(NAME # "_S") PPR_3b:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv2i1 (op (nxv2i1 PPR_3b:$Pg),
                        (nxv2i64 ZPR:$Zs1),
                        (nxv2i64 (AArch64dup (uimm7_64b:$imm))))),
            (!cast<Instruction>(NAME # "_D") PPR_3b:$Pg, ZPR:$Zs1, uimm7_64b:$imm)>;

  // Inverted intrinsic version
  def : Pat<(nxv16i1 (inv_op (nxv16i1 PPR_3b:$Pg),
                             (nxv16i8 (AArch64dup (imm0_127:$imm))),
                             (nxv16i8 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_B") PPR_3b:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv8i1 (inv_op (nxv8i1 PPR_3b:$Pg),
                            (nxv8i16 (AArch64dup (imm0_127:$imm))),
                            (nxv8i16 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_H") PPR_3b:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv4i1 (inv_op (nxv4i1 PPR_3b:$Pg),
                            (nxv4i32 (AArch64dup (imm0_127:$imm))),
                            (nxv4i32 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_S") PPR_3b:$Pg, ZPR:$Zs1, imm0_127:$imm)>;
  def : Pat<(nxv2i1 (inv_op (nxv2i1 PPR_3b:$Pg),
                            (nxv2i64 (AArch64dup (uimm7_64b:$imm))),
                            (nxv2i64 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_D") PPR_3b:$Pg, ZPR:$Zs1, uimm7_64b:$imm)>;
}

//===----------------------------------------------------------------------===//
// SVE Permute - Predicates Group
//===----------------------------------------------------------------------===//

class sve_int_perm_bin_perm_pp<bits<3> opc, bits<2> sz8_64, string asm,
                               PPRRegOp pprty, ValueType vt,
                               SDPatternOperator op>
: I<(outs pprty:$Pd), (ins pprty:$Pn, pprty:$Pm),
  asm, "\t$Pd, $Pn, $Pm",
  "",
  [(set (vt pprty:$Pd), (op (vt pprty:$Pn), (vt pprty:$Pm)))]>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pm;
  bits<4> Pn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-20} = 0b10;
  let Inst{19-16} = Pm;
  let Inst{15-13} = 0b010;
  let Inst{12-10} = opc;
  let Inst{9}     = 0b0;
  let Inst{8-5}   = Pn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pd;
}

multiclass sve_int_perm_bin_perm_pp<bits<3> opc, string asm,
                                    SDPatternOperator op> {
  def _B : sve_int_perm_bin_perm_pp<opc, 0b00, asm, PPR8, nxv16i1, op>;
  def _H : sve_int_perm_bin_perm_pp<opc, 0b01, asm, PPR16, nxv8i1, op>;
  def _S : sve_int_perm_bin_perm_pp<opc, 0b10, asm, PPR32, nxv4i1, op>;
  def _D : sve_int_perm_bin_perm_pp<opc, 0b11, asm, PPR64, nxv2i1, op>;
}

class sve_int_perm_punpk<bit opc, string asm>
: I<(outs PPR16:$Pd), (ins PPR8:$Pn),
  asm, "\t$Pd, $Pn",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pn;
  let Inst{31-17} = 0b000001010011000;
  let Inst{16}    = opc;
  let Inst{15-9}  = 0b0100000;
  let Inst{8-5}   = Pn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pd;
}

multiclass sve_int_perm_punpk<bit opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_perm_punpk<opc, asm>;

  def : SVE_1_Op_Pat<nxv8i1, op, nxv16i1, !cast<Instruction>(NAME)>;
  def : SVE_1_Op_Pat<nxv4i1, op, nxv8i1,  !cast<Instruction>(NAME)>;
  def : SVE_1_Op_Pat<nxv2i1, op, nxv4i1,  !cast<Instruction>(NAME)>;
}

class sve_int_perm_reverse_p<bits<2> sz8_64, string asm, PPRRegOp pprty,
                             ValueType vt, SDPatternOperator op>
: I<(outs pprty:$Pd), (ins pprty:$Pn),
  asm, "\t$Pd, $Pn",
  "",
  [(set pprty:$Pd, (vt (op (vt pprty:$Pn))))]>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pn;
  let Inst{31-24} = 0b00000101;
  let Inst{23-22} = sz8_64;
  let Inst{21-9}  = 0b1101000100000;
  let Inst{8-5}   = Pn;
  let Inst{4}     = 0b0;
  let Inst{3-0}   = Pd;
}

multiclass sve_int_perm_reverse_p<string asm, SDPatternOperator op> {
  def _B : sve_int_perm_reverse_p<0b00, asm, PPR8, nxv16i1, op>;
  def _H : sve_int_perm_reverse_p<0b01, asm, PPR16, nxv8i1, op>;
  def _S : sve_int_perm_reverse_p<0b10, asm, PPR32, nxv4i1, op>;
  def _D : sve_int_perm_reverse_p<0b11, asm, PPR64, nxv2i1, op>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Fused Multiply-Add Group
//===----------------------------------------------------------------------===//

class sve_fp_3op_p_zds_a<bits<2> sz, bits<2> opc, string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zda), (ins PPR3bAny:$Pg, zprty:$_Zda, zprty:$Zn, zprty:$Zm),
  asm, "\t$Zda, $Pg/m, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zda;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0b0;
  let Inst{14-13} = opc;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zda;

  let Constraints = "$Zda = $_Zda";
  let ElementSize = zprty.EltSz;
}

multiclass sve_fp_3op_p_zds_a<bits<2> opc, string asm, string Ps,
                              SDPatternOperator op, string revname="",
                              bit isOrig=0> {
  let DestructiveInstType = DestructiveTernaryCommWithRev in {
  def _H : sve_fp_3op_p_zds_a<0b01, opc, asm, ZPR16>,
           SVEPseudo2Instr<Ps # _H, 1>, SVEInstr2Rev<NAME # _H, revname # _H, isOrig>;
  def _S : sve_fp_3op_p_zds_a<0b10, opc, asm, ZPR32>,
           SVEPseudo2Instr<Ps # _S, 1>, SVEInstr2Rev<NAME # _S, revname # _S, isOrig>;
  def _D : sve_fp_3op_p_zds_a<0b11, opc, asm, ZPR64>,
           SVEPseudo2Instr<Ps # _D, 1>, SVEInstr2Rev<NAME # _D, revname # _D, isOrig>;
  }

  def : SVE_4_Op_Pat<nxv8f16, op, nxv8i1, nxv8f16, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_4_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_4_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

class sve_fp_3op_p_zds_b<bits<2> sz, bits<2> opc, string asm,
                         ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, zprty:$Zm, zprty:$Za),
  asm, "\t$Zdn, $Pg/m, $Zm, $Za",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Za;
  bits<5> Zdn;
  bits<5> Zm;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21}    = 0b1;
  let Inst{20-16} = Za;
  let Inst{15}    = 0b1;
  let Inst{14-13} = opc;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let ElementSize = zprty.EltSz;
}

multiclass sve_fp_3op_p_zds_b<bits<2> opc, string asm, string Ps,
                              SDPatternOperator op, string revname,
                              bit isOrig> {
  let DestructiveInstType = DestructiveTernaryCommWithRev in {
  def _H : sve_fp_3op_p_zds_b<0b01, opc, asm, ZPR16>,
           SVEPseudo2Instr<Ps # _H, 1>, SVEInstr2Rev<NAME # _H, revname # _H, isOrig>;
  def _S : sve_fp_3op_p_zds_b<0b10, opc, asm, ZPR32>,
           SVEPseudo2Instr<Ps # _S, 1>, SVEInstr2Rev<NAME # _S, revname # _S, isOrig>;
  def _D : sve_fp_3op_p_zds_b<0b11, opc, asm, ZPR64>,
           SVEPseudo2Instr<Ps # _D, 1>, SVEInstr2Rev<NAME # _D, revname # _D, isOrig>;
  }

  def : SVE_4_Op_Pat<nxv8f16, op, nxv8i1, nxv8f16, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_4_Op_Pat<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_4_Op_Pat<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

multiclass sve_fp_3op_p_zds_zx<SDPatternOperator op> {
  def _UNDEF_H : PredThreeOpPseudo<NAME # _H, ZPR16, FalseLanesUndef>;
  def _UNDEF_S : PredThreeOpPseudo<NAME # _S, ZPR32, FalseLanesUndef>;
  def _UNDEF_D : PredThreeOpPseudo<NAME # _D, ZPR64, FalseLanesUndef>;

  def _ZERO_H : PredThreeOpPseudo<NAME # _H, ZPR16, FalseLanesZero>;
  def _ZERO_S : PredThreeOpPseudo<NAME # _S, ZPR32, FalseLanesZero>;
  def _ZERO_D : PredThreeOpPseudo<NAME # _D, ZPR64, FalseLanesZero>;

  def : SVE_4_Op_Pat_SelZero<nxv8f16, op, nxv8i1, nxv8f16, nxv8f16, nxv8f16, !cast<Instruction>(NAME # _ZERO_H)>;
  def : SVE_4_Op_Pat_SelZero<nxv4f32, op, nxv4i1, nxv4f32, nxv4f32, nxv4f32, !cast<Instruction>(NAME # _ZERO_S)>;
  def : SVE_4_Op_Pat_SelZero<nxv2f64, op, nxv2i1, nxv2f64, nxv2f64, nxv2f64, !cast<Instruction>(NAME # _ZERO_D)>;
}


//===----------------------------------------------------------------------===//
// SVE Predicate Count Group
//===----------------------------------------------------------------------===//

class sve_int_count_r<bits<2> sz8_64, bits<5> opc, string asm,
                      RegisterOperand dty, PPRRegOp pprty, RegisterOperand sty>
: I<(outs dty:$Rdn), (ins pprty:$Pg, sty:$_Rdn),
  asm, "\t$Rdn, $Pg",
  "",
  []>, Sched<[]> {
  bits<5> Rdn;
  bits<4> Pg;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b101;
  let Inst{18-16} = opc{4-2};
  let Inst{15-11} = 0b10001;
  let Inst{10-9}  = opc{1-0};
  let Inst{8-5}   = Pg;
  let Inst{4-0}   = Rdn;

  // Signed 32bit forms require their GPR operand printed.
  let AsmString = !if(!eq(opc{4,2-0}, 0b0000),
                      !strconcat(asm, "\t$Rdn, $Pg, $_Rdn"),
                      !strconcat(asm, "\t$Rdn, $Pg"));

  let AsmMatchConverter = !if(!eq(opc{4,2-0}, 0b00), "cvtXPredW", "");
  let Constraints = "$Rdn = $_Rdn";
}

multiclass sve_int_count_r_s32<bits<5> opc, string asm,
                               SDPatternOperator op> {
  def _B : sve_int_count_r<0b00, opc, asm, GPR64Op, PPR8, GPR64as32>;
  def _H : sve_int_count_r<0b01, opc, asm, GPR64Op, PPR16, GPR64as32>;
  def _S : sve_int_count_r<0b10, opc, asm, GPR64Op, PPR32, GPR64as32>;
  def _D : sve_int_count_r<0b11, opc, asm, GPR64Op, PPR64, GPR64as32>;

  // NOTE: Register allocation doesn't like tied operands of differing register
  //       class, hence the extra INSERT_SUBREG complication.

  def : Pat<(i32 (op GPR32:$Rn, (nxv16i1 PPRAny:$Pg))),
            (EXTRACT_SUBREG (!cast<Instruction>(NAME # _B) PPRAny:$Pg, (INSERT_SUBREG (IMPLICIT_DEF), $Rn, sub_32)), sub_32)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv8i1 PPRAny:$Pg))),
            (EXTRACT_SUBREG (!cast<Instruction>(NAME # _H) PPRAny:$Pg, (INSERT_SUBREG (IMPLICIT_DEF), $Rn, sub_32)), sub_32)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv4i1 PPRAny:$Pg))),
            (EXTRACT_SUBREG (!cast<Instruction>(NAME # _S) PPRAny:$Pg, (INSERT_SUBREG (IMPLICIT_DEF), $Rn, sub_32)), sub_32)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv2i1 PPRAny:$Pg))),
            (EXTRACT_SUBREG (!cast<Instruction>(NAME # _D) PPRAny:$Pg, (INSERT_SUBREG (IMPLICIT_DEF), $Rn, sub_32)), sub_32)>;
}

multiclass sve_int_count_r_u32<bits<5> opc, string asm,
                               SDPatternOperator op> {
  def _B : sve_int_count_r<0b00, opc, asm, GPR32Op, PPR8, GPR32Op>;
  def _H : sve_int_count_r<0b01, opc, asm, GPR32Op, PPR16, GPR32Op>;
  def _S : sve_int_count_r<0b10, opc, asm, GPR32Op, PPR32, GPR32Op>;
  def _D : sve_int_count_r<0b11, opc, asm, GPR32Op, PPR64, GPR32Op>;

  def : Pat<(i32 (op GPR32:$Rn, (nxv16i1 PPRAny:$Pg))),
            (!cast<Instruction>(NAME # _B) PPRAny:$Pg, $Rn)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv8i1 PPRAny:$Pg))),
            (!cast<Instruction>(NAME # _H) PPRAny:$Pg, $Rn)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv4i1 PPRAny:$Pg))),
            (!cast<Instruction>(NAME # _S) PPRAny:$Pg, $Rn)>;
  def : Pat<(i32 (op GPR32:$Rn, (nxv2i1 PPRAny:$Pg))),
            (!cast<Instruction>(NAME # _D) PPRAny:$Pg, $Rn)>;
}

multiclass sve_int_count_r_x64<bits<5> opc, string asm,
                               SDPatternOperator op = null_frag> {
  def _B : sve_int_count_r<0b00, opc, asm, GPR64Op, PPR8, GPR64Op>;
  def _H : sve_int_count_r<0b01, opc, asm, GPR64Op, PPR16, GPR64Op>;
  def _S : sve_int_count_r<0b10, opc, asm, GPR64Op, PPR32, GPR64Op>;
  def _D : sve_int_count_r<0b11, opc, asm, GPR64Op, PPR64, GPR64Op>;

  def : Pat<(i64 (op GPR64:$Rn, (nxv16i1 PPRAny:$Pg))),
            (!cast<Instruction>(NAME # _B) PPRAny:$Pg, $Rn)>;
  def : Pat<(i64 (op GPR64:$Rn, (nxv8i1 PPRAny:$Pg))),
            (!cast<Instruction>(NAME # _H) PPRAny:$Pg, $Rn)>;
  def : Pat<(i64 (op GPR64:$Rn, (nxv4i1 PPRAny:$Pg))),
            (!cast<Instruction>(NAME # _S) PPRAny:$Pg, $Rn)>;
  def : Pat<(i64 (op GPR64:$Rn, (nxv2i1 PPRAny:$Pg))),
            (!cast<Instruction>(NAME # _D) PPRAny:$Pg, $Rn)>;
}

class sve_int_count_v<bits<2> sz8_64, bits<5> opc, string asm,
                      ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins zprty:$_Zdn, PPRAny:$Pg),
  asm, "\t$Zdn, $Pg",
  "",
  []>, Sched<[]> {
  bits<4> Pg;
  bits<5> Zdn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b101;
  let Inst{18-16} = opc{4-2};
  let Inst{15-11} = 0b10000;
  let Inst{10-9}  = opc{1-0};
  let Inst{8-5}   = Pg;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_int_count_v<bits<5> opc, string asm,
                           SDPatternOperator op = null_frag> {
  def _H : sve_int_count_v<0b01, opc, asm, ZPR16>;
  def _S : sve_int_count_v<0b10, opc, asm, ZPR32>;
  def _D : sve_int_count_v<0b11, opc, asm, ZPR64>;

  def : SVE_2_Op_Pat<nxv8i16, op, nxv8i16,  nxv8i1, !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<nxv4i32, op, nxv4i32,  nxv4i1, !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<nxv2i64, op, nxv2i64,  nxv2i1, !cast<Instruction>(NAME # _D)>;
}

class sve_int_pcount_pred<bits<2> sz8_64, bits<4> opc, string asm,
                          PPRRegOp pprty>
: I<(outs GPR64:$Rd), (ins PPRAny:$Pg, pprty:$Pn),
  asm, "\t$Rd, $Pg, $Pn",
  "",
  []>, Sched<[]> {
  bits<4> Pg;
  bits<4> Pn;
  bits<5> Rd;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b100;
  let Inst{18-16} = opc{3-1};
  let Inst{15-14} = 0b10;
  let Inst{13-10} = Pg;
  let Inst{9}     = opc{0};
  let Inst{8-5}   = Pn;
  let Inst{4-0}   = Rd;
}

multiclass sve_int_pcount_pred<bits<4> opc, string asm,
                               SDPatternOperator int_op,
                               SDPatternOperator ir_op> {
  def _B : sve_int_pcount_pred<0b00, opc, asm, PPR8>;
  def _H : sve_int_pcount_pred<0b01, opc, asm, PPR16>;
  def _S : sve_int_pcount_pred<0b10, opc, asm, PPR32>;
  def _D : sve_int_pcount_pred<0b11, opc, asm, PPR64>;

  def : SVE_2_Op_Pat<i64, int_op, nxv16i1, nxv16i1, !cast<Instruction>(NAME # _B)>;
  def : SVE_2_Op_Pat<i64, int_op, nxv8i1,  nxv8i1,  !cast<Instruction>(NAME # _H)>;
  def : SVE_2_Op_Pat<i64, int_op, nxv4i1,  nxv4i1,  !cast<Instruction>(NAME # _S)>;
  def : SVE_2_Op_Pat<i64, int_op, nxv2i1,  nxv2i1,  !cast<Instruction>(NAME # _D)>;

  def : Pat<(i64 (ir_op (nxv16i1 PPR:$Pn))), (!cast<Instruction>(NAME # _B) (PTRUE_B 31), PPR:$Pn)>;
  def : Pat<(i64 (ir_op (nxv8i1  PPR:$Pn))), (!cast<Instruction>(NAME # _H) (PTRUE_H 31), PPR:$Pn)>;
  def : Pat<(i64 (ir_op (nxv4i1  PPR:$Pn))), (!cast<Instruction>(NAME # _S) (PTRUE_S 31), PPR:$Pn)>;
  def : Pat<(i64 (ir_op (nxv2i1  PPR:$Pn))), (!cast<Instruction>(NAME # _D) (PTRUE_D 31), PPR:$Pn)>;
}

class sve_int_setffr<string asm, SDPatternOperator op>
: I<(outs), (ins),
  asm, "",
  "",
  [(op)]>, Sched<[]> {
  let Inst{31-0} = 0b00100101001011001001000000000000;

  let hasSideEffects = 1;
  let Defs = [FFR];
}

class sve_int_wrffr<string asm, SDPatternOperator op>
: I<(outs), (ins PPR8:$Pn),
  asm, "\t$Pn",
  "",
  [(op (nxv16i1 PPR8:$Pn))]>, Sched<[]> {
  bits<4> Pn;
  let Inst{31-9} = 0b00100101001010001001000;
  let Inst{8-5}  = Pn;
  let Inst{4-0}  = 0b00000;

  let hasSideEffects = 1;
  let Defs = [FFR];
}

//===----------------------------------------------------------------------===//
// SVE Predicate Generation Group
//===----------------------------------------------------------------------===//

class sve_int_break<bits<6> opc, string asm, string suffix, dag iops>
: I<(outs PPR8:$Pd), iops,
  asm, "\t$Pd, $Pg"#suffix#", $Pn",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pg;
  bits<4> Pn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{5-4};
  let Inst{21-19} = 0b010;
  let Inst{18-16} = opc{3-1};
  let Inst{15-14} = 0b01;
  let Inst{13-10} = Pg;
  let Inst{9}     = 0;
  let Inst{8-5}   = Pn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Constraints = !if(!eq (opc{0}, 1), "$Pd = $_Pd", "");
  let Defs = !if(!eq (opc{5}, 1), [NZCV], []);

}

multiclass sve_int_break_m<bits<6> opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_break<opc, asm, "/m", (ins PPR8:$_Pd, PPRAny:$Pg, PPR8:$Pn)>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i1, nxv16i1, !cast<Instruction>(NAME)>;
}

multiclass sve_int_break_z<bits<6> opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_break<opc, asm, "/z", (ins PPRAny:$Pg, PPR8:$Pn)>;

  def : SVE_2_Op_Pat<nxv16i1, op, nxv16i1, nxv16i1, !cast<Instruction>(NAME)>;
}


class sve_int_brkn<bits<7> opc, string asm>
: I<(outs PPR8:$Pdm), (ins PPRAny:$Pg, PPR8:$Pn, PPR8:$_Pdm),
  asm, "\t$Pdm, $Pg/z, $Pn, $_Pdm",
  "",
  []>, Sched<[]> {
  bits<4> Pdm;
  bits<4> Pg;
  bits<4> Pn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{6-5};
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc{4-2};
  let Inst{15-14} = 0b01;
  let Inst{13-10} = Pg;
  let Inst{9}     = opc{1};
  let Inst{8-5}   = Pn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pdm;

  let Constraints = "$Pdm = $_Pdm";
  let Defs = !if(!eq (opc{5}, 1), [NZCV], []);
}

multiclass sve_int_brkn<bits<7> opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_brkn<opc, asm>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i1, nxv16i1, !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i1,  nxv8i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i1,  nxv4i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv2i1,  op, nxv2i1,  nxv2i1,  nxv2i1,  !cast<Instruction>(NAME)>;
}

class sve_int_brkp<bits<4> opc, string asm>
: I<(outs PPR8:$Pd), (ins PPRAny:$Pg, PPR8:$Pn, PPR8:$Pm),
  asm, "\t$Pd, $Pg/z, $Pn, $Pm",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pg;
  bits<4> Pm;
  bits<4> Pn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{3-2};
  let Inst{21-20} = 0b00;
  let Inst{19-16} = Pm;
  let Inst{15-14} = 0b11;
  let Inst{13-10} = Pg;
  let Inst{9}     = opc{1};
  let Inst{8-5}   = Pn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  // SEL has no predication qualifier.
  let AsmString = !if(!eq(opc, 0b0011),
                      !strconcat(asm, "\t$Pd, $Pg, $Pn, $Pm"),
                      !strconcat(asm, "\t$Pd, $Pg/z, $Pn, $Pm"));

  let Defs = !if(!eq (opc{2}, 1), [NZCV], []);
}

multiclass sve_int_brkp<bits<4> opc, string asm, SDPatternOperator op> {
  def NAME : sve_int_brkp<opc, asm>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i1, nxv16i1, !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i1,  nxv8i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i1,  nxv4i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv2i1,  op, nxv2i1,  nxv2i1,  nxv2i1,  !cast<Instruction>(NAME)>;
}

class sve_int_pfalse<bits<6> opc, string asm>
: I<(outs PPR8:$Pd), (ins),
  asm, "\t$Pd",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{5-4};
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc{3-1};
  let Inst{15-10} = 0b111001;
  let Inst{9}     = opc{0};
  let Inst{8-4}   = 0b00000;
  let Inst{3-0}   = Pd;

  let isReMaterializable = 1;
}

class sve_int_pfirst_next<bits<2> sz8_64, bits<5> opc, string asm,
                          PPRRegOp pprty, ValueType vt, SDPatternOperator op>
: I<(outs pprty:$Pdn), (ins PPRAny:$Pg, pprty:$_Pdn),
  asm, "\t$Pdn, $Pg, $_Pdn",
  "",
  [(set (vt pprty:$Pdn), (op (vt PPRAny:$Pg), (vt pprty:$_Pdn)))]>, Sched<[]> {
  bits<4> Pdn;
  bits<4> Pg;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc{4-2};
  let Inst{15-11} = 0b11000;
  let Inst{10-9}  = opc{1-0};
  let Inst{8-5}   = Pg;
  let Inst{4}     = 0;
  let Inst{3-0}   = Pdn;

  let Constraints = "$Pdn = $_Pdn";
  let Defs = [NZCV];
}

multiclass sve_int_pfirst_next<bits<5> opc, string asm, SDPatternOperator op> {
  def _B : sve_int_pfirst_next<0b00, opc, asm, PPR8, nxv16i1, op>;
  def _H : sve_int_pfirst_next<0b01, opc, asm, PPR16, nxv8i1, op>;
  def _S : sve_int_pfirst_next<0b10, opc, asm, PPR32, nxv4i1, op>;
  def _D : sve_int_pfirst_next<0b11, opc, asm, PPR64, nxv2i1, op>;
}

class sve_int_pred_log<bits<4> opc, string asm>
: I<(outs PPR8:$Pd), (ins PPRAny:$Pg, PPR8:$Pn, PPR8:$Pm),
  asm, "\t$Pd, $Pg/z, $Pn, $Pm",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pg;
  bits<4> Pm;
  bits<4> Pn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{3-2};
  let Inst{21-20} = 0b00;
  let Inst{19-16} = Pm;
  let Inst{15-14} = 0b01;
  let Inst{13-10} = Pg;
  let Inst{9}     = opc{1};
  let Inst{8-5}   = Pn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  // SEL has no predication qualifier.
  let AsmString = !if(!eq(opc, 0b0011),
                      !strconcat(asm, "\t$Pd, $Pg, $Pn, $Pm"),
                      !strconcat(asm, "\t$Pd, $Pg/z, $Pn, $Pm"));

  let Defs = !if(!eq (opc{2}, 1), [NZCV], []);
}

multiclass sve_int_pred_log<bits<4> opc, string asm,
                            SDPatternOperator op = null_frag> {
  def NAME : sve_int_pred_log<opc, asm>;

  def : SVE_3_Op_Pat<nxv16i1, op, nxv16i1, nxv16i1, nxv16i1, !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv8i1,  op, nxv8i1,  nxv8i1,  nxv8i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv4i1,  op, nxv4i1,  nxv4i1,  nxv4i1,  !cast<Instruction>(NAME)>;
  def : SVE_3_Op_Pat<nxv2i1,  op, nxv2i1,  nxv2i1,  nxv2i1,  !cast<Instruction>(NAME)>;
}

class sve_int_ptest<bits<6> opc, string asm>
: I<(outs), (ins PPRAny:$Pg, PPR8:$Pn),
  asm, "\t$Pg, $Pn",
  "",
  []>, Sched<[]> {
  bits<4> Pg;
  bits<4> Pn;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{5-4};
  let Inst{21-19} = 0b010;
  let Inst{18-16} = opc{3-1};
  let Inst{15-14} = 0b11;
  let Inst{13-10} = Pg;
  let Inst{9}     = opc{0};
  let Inst{8-5}   = Pn;
  let Inst{4-0}   = 0b00000;

  let Defs = [NZCV];
  let isCompare = 1;
}

class sve_int_rdffr<bits<7> opc, string asm>
: I<(outs PPR8:$Pd), (ins PPRAny:$Pg),
  asm, "\t$Pd, $Pg/z",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<4> Pg;
  let Inst{31-24} = 0b00100101;
  let Inst{23}    = opc{6};
  let Inst{22}    = opc{5};   // s
  let Inst{21-19} = 0b011;
  let Inst{18-17} = opc{4-3};
  let Inst{16-11} = 0b011110;
  let Inst{10-9}  = opc{2-1};
  let Inst{8-5}   = Pg;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = !if(!eq (opc{5}, 1), [NZCV], []);
  let Uses = [FFR];
}

class sve_int_rdffr_2<bits<6> opc, string asm> : I<
  (outs PPR8:$Pd), (ins),
  asm, "\t$Pd",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = opc{5-4};
  let Inst{21-19} = 0b011;
  let Inst{18-17} = opc{3-2};
  let Inst{16-11} = 0b111110;
  let Inst{10-9}  = opc{1-0};
  let Inst{8-4}   = 0b00000;
  let Inst{3-0}   = Pd;

  let Uses = [FFR];
}

multiclass sve_int_rdffr_2<bits<6> opc, string asm, SDPatternOperator op> {
  def _REAL : sve_int_rdffr_2<opc, asm>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def "" : Pseudo<(outs PPR8:$Pd), (ins), [(set (nxv16i1 PPR8:$Pd), (op))]>,
           PseudoInstExpansion<(!cast<Instruction>(NAME # _REAL) PPR8:$Pd)>;
  }
}


//===----------------------------------------------------------------------===//
// SVE Floating Point Accumulating Reduction Group
//===----------------------------------------------------------------------===//

class sve_fp_2op_p_vd<bits<2> sz, bits<3> opc, string asm,
                      ZPRRegOp zprty, RegisterClass dstRegClass>
: I<(outs dstRegClass:$Vdn), (ins PPR3bAny:$Pg, dstRegClass:$_Vdn, zprty:$Zm),
  asm, "\t$Vdn, $Pg, $_Vdn, $Zm",
  "",
  []>,
  Sched<[]> {
  bits<3> Pg;
  bits<5> Vdn;
  bits<5> Zm;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = sz;
  let Inst{21-19} = 0b011;
  let Inst{18-16} = opc;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Vdn;

  let Constraints = "$Vdn = $_Vdn";
}

multiclass sve_fp_2op_p_vd<bits<3> opc, string asm, SDPatternOperator op> {
  def _H : sve_fp_2op_p_vd<0b01, opc, asm, ZPR16, FPR16>;
  def _S : sve_fp_2op_p_vd<0b10, opc, asm, ZPR32, FPR32>;
  def _D : sve_fp_2op_p_vd<0b11, opc, asm, ZPR64, FPR64>;

  def : SVE_3_Op_Pat<f16, op, nxv8i1, f16, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<f32, op, nxv4i1, f32, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<f32, op, nxv2i1, f32, nxv2f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<f64, op, nxv2i1, f64, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Memory - Contiguous Load Group
//===----------------------------------------------------------------------===//

class sve_mem_cld_si_base<bits<4> dtype, bit nf, string asm,
                          RegisterOperand VecList>
: I<(outs VecList:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4),
  asm, "\t$Zt, $Pg/z, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Zt;
  bits<4> imm4;
  let Inst{31-25} = 0b1010010;
  let Inst{24-21} = dtype;
  let Inst{20}    = nf;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
  let Uses = !if(!eq(nf, 1), [FFR], []);
  let Defs = !if(!eq(nf, 1), [FFR], []);
}

multiclass sve_mem_cld_si_base<bits<4> dtype, bit nf, string asm,
                               RegisterOperand listty, ZPRRegOp zprty> {
  def _REAL : sve_mem_cld_si_base<dtype, nf, asm, listty>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME # _REAL) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $imm4, mul vl]",
                  (!cast<Instruction>(NAME # _REAL) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME # _REAL) listty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 1>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def "" : Pseudo<(outs listty:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4), []>,
           PseudoInstExpansion<(!cast<Instruction>(NAME # _REAL) listty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4)>;
  }
}

multiclass sve_mem_cld_si<bits<4> dtype, string asm, RegisterOperand listty,
                          ZPRRegOp zprty>
: sve_mem_cld_si_base<dtype, 0, asm, listty, zprty>;

multiclass sve_mem_cldnf_si<bits<4> dtype, string asm, RegisterOperand listty,
                            ZPRRegOp zprty>
: sve_mem_cld_si_base<dtype, 1, asm, listty, zprty>;

class sve_mem_eld_si<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                     string asm, Operand immtype>
: I<(outs VecList:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, immtype:$imm4),
  asm, "\t$Zt, $Pg/z, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<5> Zt;
  bits<3> Pg;
  bits<5> Rn;
  bits<4> imm4;
  let Inst{31-25} = 0b1010010;
  let Inst{24-23} = sz;
  let Inst{22-21} = nregs;
  let Inst{20}    = 0;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_eld_si<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                          string asm, Operand immtype> {
  def NAME : sve_mem_eld_si<sz, nregs, VecList, asm, immtype>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) VecList:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_ldqr_si<bits<2> sz, string asm, RegisterOperand VecList>
: I<(outs VecList:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, simm4s16:$imm4),
  asm, "\t$Zt, $Pg/z, [$Rn, $imm4]", "", []>, Sched<[]> {
  bits<5> Zt;
  bits<5> Rn;
  bits<3> Pg;
  bits<4> imm4;
  let Inst{31-25} = 0b1010010;
  let Inst{24-23} = sz;
  let Inst{22-20} = 0;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_ldqr_si<bits<2> sz, string asm, RegisterOperand listty,
                           ZPRRegOp zprty> {
  def NAME : sve_mem_ldqr_si<sz, asm, listty>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) listty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 1>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $imm4]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, simm4s16:$imm4), 0>;
}

class sve_mem_ldqr_ss<bits<2> sz, string asm, RegisterOperand VecList,
                      RegisterOperand gprty>
: I<(outs VecList:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Rm]", "", []>, Sched<[]> {
  bits<5> Zt;
  bits<3> Pg;
  bits<5> Rn;
  bits<5> Rm;
  let Inst{31-25} = 0b1010010;
  let Inst{24-23} = sz;
  let Inst{22-21} = 0;
  let Inst{20-16} = Rm;
  let Inst{15-13} = 0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_ldqr_ss<bits<2> sz, string asm, RegisterOperand listty,
                           ZPRRegOp zprty, RegisterOperand gprty> {
  def NAME : sve_mem_ldqr_ss<sz, asm, listty, gprty>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Rm]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm), 0>;
}

class sve_mem_cld_ss_base<bits<4> dtype, bit ff, dag iops, string asm,
                          RegisterOperand VecList>
: I<(outs VecList:$Zt), iops,
  asm, "\t$Zt, $Pg/z, [$Rn, $Rm]",
  "",
  []>, Sched<[]> {
  bits<5> Zt;
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  let Inst{31-25} = 0b1010010;
  let Inst{24-21} = dtype;
  let Inst{20-16} = Rm;
  let Inst{15-14} = 0b01;
  let Inst{13}    = ff;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
  let Uses = !if(!eq(ff, 1), [FFR], []);
  let Defs = !if(!eq(ff, 1), [FFR], []);
}

multiclass sve_mem_cld_ss<bits<4> dtype, string asm, RegisterOperand listty,
                          ZPRRegOp zprty, RegisterOperand gprty> {
  def "" : sve_mem_cld_ss_base<dtype, 0, (ins PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm),
                               asm, listty>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Rm]",
                 (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm), 0>;
}

multiclass sve_mem_cldff_ss<bits<4> dtype, string asm, RegisterOperand listty,
                            ZPRRegOp zprty, RegisterOperand gprty> {
  def _REAL : sve_mem_cld_ss_base<dtype, 1, (ins PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm),
                                  asm, listty>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Rm]",
                 (!cast<Instruction>(NAME # _REAL) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm), 0>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                 (!cast<Instruction>(NAME # _REAL) listty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, XZR), 1>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                 (!cast<Instruction>(NAME # _REAL) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, XZR), 0>;

  // We need a layer of indirection because early machine code passes balk at
  // physical register (i.e. FFR) uses that have no previous definition.
  let hasSideEffects = 1, hasNoSchedulingInfo = 1 in {
  def "" : Pseudo<(outs listty:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm), []>,
           PseudoInstExpansion<(!cast<Instruction>(NAME # _REAL) listty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm)>;
  }
}

class sve_mem_eld_ss<bits<2> sz, bits<2> nregs, RegisterOperand VecList,
                     string asm, RegisterOperand gprty>
: I<(outs VecList:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Rm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  bits<5> Zt;
  let Inst{31-25} = 0b1010010;
  let Inst{24-23} = sz;
  let Inst{22-21} = nregs;
  let Inst{20-16} = Rm;
  let Inst{15-13} = 0b110;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

class sve_mem_cldnt_si_base<bits<2> msz, string asm, RegisterOperand VecList>
: I<(outs VecList:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4),
  asm, "\t$Zt, $Pg/z, [$Rn, $imm4, mul vl]",
  "",
  []>, Sched<[]> {
  bits<5> Zt;
  bits<3> Pg;
  bits<5> Rn;
  bits<4> imm4;
  let Inst{31-25} = 0b1010010;
  let Inst{24-23} = msz;
  let Inst{22-20} = 0b000;
  let Inst{19-16} = imm4;
  let Inst{15-13} = 0b111;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_cldnt_si<bits<2> msz, string asm, RegisterOperand listty,
                            ZPRRegOp zprty> {
  def NAME : sve_mem_cldnt_si_base<msz, asm, listty>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $imm4, mul vl]",
                  (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, simm4MulVl:$imm4), 0>;
  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn]",
                  (!cast<Instruction>(NAME) listty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, 0), 1>;
}

class sve_mem_cldnt_ss_base<bits<3> opc, string asm, RegisterOperand VecList,
                            RegisterOperand gprty>
: I<(outs VecList:$Zt), (ins PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm),
  asm, "\t$Zt, $Pg/z, [$Rn, $Rm]",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Rm;
  bits<5> Rn;
  bits<5> Zt;
  let Inst{31-25} = 0b1010010;
  let Inst{24-23} = opc{2-1}; // msz
  let Inst{22-21} = 0b00;
  let Inst{20-16} = Rm;
  let Inst{15}    = 0b1;
  let Inst{14}    = opc{0};   // l
  let Inst{13}    = 0b0;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Rn;
  let Inst{4-0}   = Zt;

  let mayLoad = 1;
}

multiclass sve_mem_cldnt_ss<bits<3> opc, string asm, RegisterOperand listty,
                            ZPRRegOp zprty, RegisterOperand gprty> {
  def NAME : sve_mem_cldnt_ss_base<opc, asm, listty, gprty>;

  def : InstAlias<asm # "\t$Zt, $Pg/z, [$Rn, $Rm]",
                 (!cast<Instruction>(NAME) zprty:$Zt, PPR3bAny:$Pg, GPR64sp:$Rn, gprty:$Rm), 0>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Unary Operations Group
//===----------------------------------------------------------------------===//

class sve_fp_2op_p_zd<bits<7> opc, string asm, RegisterOperand i_zprtype,
                      RegisterOperand o_zprtype, EltSizeEnum Sz>
: I<(outs o_zprtype:$Zd), (ins i_zprtype:$_Zd, PPR3bAny:$Pg, i_zprtype:$Zn),
  asm, "\t$Zd, $Pg/m, $Zn",
  "",
  []>, Sched<[]> {
  bits<3> Pg;
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b01100101;
  let Inst{23-22} = opc{6-5};
  let Inst{21}    = 0b0;
  let Inst{20-16} = opc{4-0};
  let Inst{15-13} = 0b101;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;

  let Constraints = "$Zd = $_Zd";
  let DestructiveInstType = DestructiveUnary;
  let ElementSize = Sz;
}

multiclass sve_fp_2op_p_zd<bits<7> opc, string asm,
                           RegisterOperand i_zprtype,
                           RegisterOperand o_zprtype,
                           SDPatternOperator op, ValueType vt1,
                           ValueType vt2, ValueType vt3, EltSizeEnum Sz> {
  def NAME : sve_fp_2op_p_zd<opc, asm, i_zprtype, o_zprtype, Sz>;

  def : SVE_3_Op_Pat<vt1, op, vt1, vt2, vt3, !cast<Instruction>(NAME)>;
}

multiclass sve_fp_2op_p_zd_HSD<bits<5> opc, string asm, SDPatternOperator op> {
  def _H : sve_fp_2op_p_zd<{ 0b01, opc }, asm, ZPR16, ZPR16, ElementSizeH>;
  def _S : sve_fp_2op_p_zd<{ 0b10, opc }, asm, ZPR32, ZPR32, ElementSizeS>;
  def _D : sve_fp_2op_p_zd<{ 0b11, opc }, asm, ZPR64, ZPR64, ElementSizeD>;

  def : SVE_3_Op_Pat<nxv8f16, op, nxv8f16, nxv8i1, nxv8f16, !cast<Instruction>(NAME # _H)>;
  def : SVE_3_Op_Pat<nxv4f32, op, nxv4f32, nxv4i1, nxv4f32, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2f64, op, nxv2f64, nxv2i1, nxv2f64, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Logical - Unpredicated Group
//===----------------------------------------------------------------------===//

class sve_int_bin_cons_log<bits<5> opc, string asm>
: I<(outs ZPR64:$Zd), (ins ZPR64:$Zn, ZPR64:$Zm),
  asm, "\t$Zd, $Zn, $Zm",
  "",
  []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zm;
  bits<5> Zn;
  let Inst{31-24} = 0b00000100;
  let Inst{23-22} = opc{4-3};
  let Inst{21}    = 0b1;
  let Inst{20-16} = Zm;
  let Inst{15-13} = 0b001;
  let Inst{12-10} = opc{2-0};
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

//===----------------------------------------------------------------------===//
// SVE Integer Compare - Signed Immediate Group
//===----------------------------------------------------------------------===//

class sve_int_scmp_vi<bits<2> sz8_64, bits<3> opc, string asm, PPRRegOp pprty,
                      ZPRRegOp zprty,
                      Operand immtype>
: I<(outs pprty:$Pd), (ins PPR3bAny:$Pg, zprty:$Zn, immtype:$imm5),
  asm, "\t$Pd, $Pg/z, $Zn, $imm5",
  "",
  []>, Sched<[]> {
  bits<4> Pd;
  bits<3> Pg;
  bits<5> Zn;
  bits<5> imm5;
  let Inst{31-24} = 0b00100101;
  let Inst{23-22} = sz8_64;
  let Inst{21}    = 0b0;
  let Inst{20-16} = imm5;
  let Inst{15}    = opc{2};
  let Inst{14}    = 0b0;
  let Inst{13}    = opc{1};
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4}     = opc{0};
  let Inst{3-0}   = Pd;

  let Defs = [NZCV];
}

multiclass sve_int_scmp_vi<bits<3> opc, string asm, CondCode cc,
                           SDPatternOperator op = null_frag,
                           SDPatternOperator inv_op = null_frag> {
  def _B : sve_int_scmp_vi<0b00, opc, asm, PPR8, ZPR8, simm5_32b>;
  def _H : sve_int_scmp_vi<0b01, opc, asm, PPR16, ZPR16, simm5_32b>;
  def _S : sve_int_scmp_vi<0b10, opc, asm, PPR32, ZPR32, simm5_32b>;
  def _D : sve_int_scmp_vi<0b11, opc, asm, PPR64, ZPR64, simm5_64b>;

  // IR version
  def : Pat<(nxv16i1 (setcc (nxv16i8 ZPR:$Zs1),
                             (nxv16i8 (AArch64dup (simm5_32b:$imm))),
                             cc)),
             (!cast<Instruction>(NAME # "_B") (PTRUE_B 31), ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv8i1 (setcc (nxv8i16 ZPR:$Zs1),
                            (nxv8i16 (AArch64dup (simm5_32b:$imm))),
                            cc)),
             (!cast<Instruction>(NAME # "_H") (PTRUE_H 31), ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv4i1 (setcc (nxv4i32 ZPR:$Zs1),
                            (nxv4i32 (AArch64dup (simm5_32b:$imm))),
                            cc)),
             (!cast<Instruction>(NAME # "_S") (PTRUE_S 31), ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv2i1 (setcc (nxv2i64 ZPR:$Zs1),
                           (nxv2i64 (AArch64dup (simm5_64b:$imm))),
                           cc)),
            (!cast<Instruction>(NAME # "_D") (PTRUE_D 31), ZPR:$Zs1, simm5_64b:$imm)>;

  // Intrinsic version
  def : Pat<(nxv16i1 (op (nxv16i1 PPR_3b:$Pg),
                         (nxv16i8 ZPR:$Zs1),
                         (nxv16i8 (AArch64dup (simm5_32b:$imm))))),
            (!cast<Instruction>(NAME # "_B") PPR_3b:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv8i1 (op (nxv8i1 PPR_3b:$Pg),
                        (nxv8i16 ZPR:$Zs1),
                        (nxv8i16 (AArch64dup (simm5_32b:$imm))))),
            (!cast<Instruction>(NAME # "_H") PPR_3b:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv4i1 (op (nxv4i1 PPR_3b:$Pg),
                        (nxv4i32 ZPR:$Zs1),
                        (nxv4i32 (AArch64dup (simm5_32b:$imm))))),
            (!cast<Instruction>(NAME # "_S") PPR_3b:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv2i1 (op (nxv2i1 PPR_3b:$Pg),
                        (nxv2i64 ZPR:$Zs1),
                        (nxv2i64 (AArch64dup (simm5_64b:$imm))))),
            (!cast<Instruction>(NAME # "_D") PPR_3b:$Pg, ZPR:$Zs1, simm5_64b:$imm)>;

  // Inverted intrinsic version
  def : Pat<(nxv16i1 (inv_op (nxv16i1 PPR_3b:$Pg),
                             (nxv16i8 (AArch64dup (simm5_32b:$imm))),
                             (nxv16i8 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_B") PPR_3b:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv8i1 (inv_op (nxv8i1 PPR_3b:$Pg),
                            (nxv8i16 (AArch64dup (simm5_32b:$imm))),
                            (nxv8i16 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_H") PPR_3b:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv4i1 (inv_op (nxv4i1 PPR_3b:$Pg),
                            (nxv4i32 (AArch64dup (simm5_32b:$imm))),
                            (nxv4i32 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_S") PPR_3b:$Pg, ZPR:$Zs1, simm5_32b:$imm)>;
  def : Pat<(nxv2i1 (inv_op (nxv2i1 PPR_3b:$Pg),
                            (nxv2i64 (AArch64dup (simm5_64b:$imm))),
                            (nxv2i64 ZPR:$Zs1))),
            (!cast<Instruction>(NAME # "_D") PPR_3b:$Pg, ZPR:$Zs1, simm5_64b:$imm)>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Complex Addition Group
//===----------------------------------------------------------------------===//

def fcaddAsmOperand : AsmOperandClass {
  let Name = "FcaddRotImm";
  let RenderMethod = "addImmOperands";
}
def sve_fcadd_rot_imm : Operand<i32>, ImmLeaf<i32, [{
    return Imm == 90 || Imm == 270;
  }]> {
  let EncoderMethod = "getSveFcaddRotImmBits";
  let DecoderMethod = "DecodeSveFcaddRotImmBits";
  let ParserMatchClass = fcaddAsmOperand;
}

class sve_fp_fcadd<bits<2> sz, string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zdn), (ins PPR3bAny:$Pg, zprty:$_Zdn, zprty:$Zm, sve_fcadd_rot_imm:$imm),
  asm, "\t$Zdn, $Pg/m, $_Zdn, $Zm, $imm",
  "",
  []>, Sched<[]> {
  bits<5> Zdn;
  bits<5> Zm;
  bits<3> Pg;
  bit imm;
  let Inst{31-24} = 0b01100100;
  let Inst{23-22} = sz;
  let Inst{21-17} = 0;
  let Inst{16}    = imm;
  let Inst{15-13} = 0b100;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zm;
  let Inst{4-0}   = Zdn;

  let Constraints = "$Zdn = $_Zdn";
  let DestructiveInstType = DestructiveOther;
  let ElementSize = zprty.EltSz;
}

multiclass sve_fp_fcadd<string asm, SDPatternOperator op> {
  def _H : sve_fp_fcadd<0b01, asm, ZPR16>;
  def _S : sve_fp_fcadd<0b10, asm, ZPR32>;
  def _D : sve_fp_fcadd<0b11, asm, ZPR64>;

  def : Pat<(nxv8f16 (op nxv8i1:$Op1, nxv8f16:$Op2, nxv8f16:$Op3, (i32 sve_fcadd_rot_imm:$imm))),
            (!cast<Instruction>(NAME # _H) $Op1, $Op2, $Op3, sve_fcadd_rot_imm:$imm)>;
  def : Pat<(nxv4f32 (op nxv4i1:$Op1, nxv4f32:$Op2, nxv4f32:$Op3, (i32 sve_fcadd_rot_imm:$imm))),
            (!cast<Instruction>(NAME # _S) $Op1, $Op2, $Op3, sve_fcadd_rot_imm:$imm)>;
  def : Pat<(nxv2f64 (op nxv2i1:$Op1, nxv2f64:$Op2, nxv2f64:$Op3, (i32 sve_fcadd_rot_imm:$imm))),
            (!cast<Instruction>(NAME # _D) $Op1, $Op2, $Op3, sve_fcadd_rot_imm:$imm)>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Complex Multiply-Add Group
//===----------------------------------------------------------------------===//

def fcmlaAsmOperand : AsmOperandClass {
  let Name = "FcmlaRotImm";
  let RenderMethod = "addImmOperands";
}
def sve_fcmla_rot_imm : Operand<i32>, ImmLeaf<i32, [{
    return Imm == 0 || Imm == 90 || Imm == 180 || Imm == 270;
  }]>{
  let EncoderMethod = "getSveFcmlaRotImmBits";
  let DecoderMethod = "DecodeSveFcmlaRotImmBits";
  let ParserMatchClass = fcmlaAsmOperand;
}

class sve_fp_fcmla<bits<2> sz, string asm, ZPRRegOp zprty>
: I<(outs zprty:$Zda), (ins PPR3bAny:$Pg, zprty:$_Zda, zprty:$Zn, zprty:$Zm, sve_fcmla_rot_imm:$imm),
  asm, "\t$Zda, $Pg/m, $Zn, $Zm, $imm",
  "", []>, Sched<[]> {
  bits<5> Zda;
  bits<3> Pg;
  bits<5> Zn;
  bits<5> Zm;
  bits<2> imm;
  let Inst{31-24} = 0b01100100;
  let Inst{23-22} = sz;
  let Inst{21}    = 0;
  let Inst{20-16} = Zm;
  let Inst{15}    = 0;
  let Inst{14-13} = imm;
  let Inst{12-10} = Pg;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zda;

  let Constraints = "$Zda = $_Zda";
  let DestructiveInstType = DestructiveOther;
  let ElementSize = zprty.EltSz;
}

multiclass sve_fp_fcmla<string asm, SDPatternOperator op> {
  def _H : sve_fp_fcmla<0b01, asm, ZPR16>;
  def _S : sve_fp_fcmla<0b10, asm, ZPR32>;
  def _D : sve_fp_fcmla<0b11, asm, ZPR64>;

  def : Pat<(nxv8f16 (op nxv8i1:$Op1, nxv8f16:$Op2, nxv8f16:$Op3, nxv8f16:$Op4, (i32 sve_fcmla_rot_imm:$imm))),
            (!cast<Instruction>(NAME # _H) $Op1, $Op2, $Op3, $Op4, sve_fcmla_rot_imm:$imm)>;
  def : Pat<(nxv4f32 (op nxv4i1:$Op1, nxv4f32:$Op2, nxv4f32:$Op3, nxv4f32:$Op4, (i32 sve_fcmla_rot_imm:$imm))),
            (!cast<Instruction>(NAME # _S) $Op1, $Op2, $Op3, $Op4, sve_fcmla_rot_imm:$imm)>;
  def : Pat<(nxv2f64 (op nxv2i1:$Op1, nxv2f64:$Op2, nxv2f64:$Op3, nxv2f64:$Op4, (i32 sve_fcmla_rot_imm:$imm))),
            (!cast<Instruction>(NAME # _D) $Op1, $Op2, $Op3, $Op4, sve_fcmla_rot_imm:$imm)>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Complex Multiply-Add - Indexed Group
//===----------------------------------------------------------------------===//

class sve_fp_fcmla_by_indexed_elem<bits<2> sz, string asm,
                                   ZPRRegOp zprty,
                                   ZPRRegOp zprty2, Operand itype>
: I<(outs zprty:$Zda), (ins zprty:$_Zda, zprty:$Zn, zprty2:$Zm, itype:$iop, sve_fcmla_rot_imm:$imm),
  asm, "\t$Zda, $Zn, $Zm$iop, $imm",
  "", []>, Sched<[]> {
  bits<5> Zda;
  bits<5> Zn;
  bits<2> imm;
  let Inst{31-24} = 0b01100100;
  let Inst{23-22} = sz;
  let Inst{21}    = 0b1;
  let Inst{15-12} = 0b0001;
  let Inst{11-10} = imm;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zda;

  let Constraints = "$Zda = $_Zda";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_fp_fcmla_by_indexed_elem<string asm, SDPatternOperator op> {
  def _H : sve_fp_fcmla_by_indexed_elem<0b10, asm, ZPR16, ZPR3b16, sve_elm_idx_s> {
    bits<3> Zm;
    bits<2> iop;
    let Inst{20-19} = iop;
    let Inst{18-16} = Zm;
  }
  def _S : sve_fp_fcmla_by_indexed_elem<0b11, asm, ZPR32, ZPR4b32, sve_elm_idx_d> {
    bits<4> Zm;
    bits<1> iop;
    let Inst{20} = iop;
    let Inst{19-16} = Zm;
  }

  def : Pat<(nxv8f16 (op nxv8f16:$Op1, nxv8f16:$Op2, nxv8f16:$Op3, (i32 sve_elm_idx_s:$idx), (i32 sve_fcmla_rot_imm:$imm))),
            (!cast<Instruction>(NAME # _H) $Op1, $Op2, $Op3, sve_elm_idx_s:$idx, sve_fcmla_rot_imm:$imm)>;
  def : Pat<(nxv4f32 (op nxv4f32:$Op1, nxv4f32:$Op2, nxv4f32:$Op3, (i32 sve_elm_idx_d:$idx), (i32 sve_fcmla_rot_imm:$imm))),
            (!cast<Instruction>(NAME # _S) $Op1, $Op2, $Op3, sve_elm_idx_d:$idx, sve_fcmla_rot_imm:$imm)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Dot Product Group
//===----------------------------------------------------------------------===//

class sve_intx_dot<bit sz, bit U, string asm, ZPRRegOp zprty1,
                   ZPRRegOp zprty2>
: I<(outs zprty1:$Zda), (ins zprty1:$_Zda, zprty2:$Zn, zprty2:$Zm), asm,
  "\t$Zda, $Zn, $Zm", "", []>, Sched<[]> {
  bits<5> Zda;
  bits<5> Zn;
  bits<5> Zm;
  let Inst{31-23} = 0b010001001;
  let Inst{22}    = sz;
  let Inst{21}    = 0;
  let Inst{20-16} = Zm;
  let Inst{15-11} = 0;
  let Inst{10}    = U;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zda;

  let Constraints = "$Zda = $_Zda";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_intx_dot<bit opc, string asm, SDPatternOperator op> {
  def _S : sve_intx_dot<0b0, opc, asm, ZPR32, ZPR8>;
  def _D : sve_intx_dot<0b1, opc, asm, ZPR64, ZPR16>;

  def : SVE_3_Op_Pat<nxv4i32, op, nxv4i32,  nxv16i8, nxv16i8, !cast<Instruction>(NAME # _S)>;
  def : SVE_3_Op_Pat<nxv2i64, op, nxv2i64,  nxv8i16, nxv8i16, !cast<Instruction>(NAME # _D)>;
}

//===----------------------------------------------------------------------===//
// SVE Integer Dot Product Group - Indexed Group
//===----------------------------------------------------------------------===//

class sve_intx_dot_by_indexed_elem<bit sz, bit U, string asm,
                                   ZPRRegOp zprty1,
                                   ZPRRegOp zprty2,
                                   ZPRRegOp zprty3,
                                   Operand itype>
: I<(outs zprty1:$Zda), (ins zprty1:$_Zda, zprty2:$Zn, zprty3:$Zm, itype:$iop),
  asm, "\t$Zda, $Zn, $Zm$iop",
  "", []>, Sched<[]> {
  bits<5> Zda;
  bits<5> Zn;
  let Inst{31-23} = 0b010001001;
  let Inst{22}    = sz;
  let Inst{21}    = 0b1;
  let Inst{15-11} = 0;
  let Inst{10}    = U;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zda;

  let Constraints = "$Zda = $_Zda";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_intx_dot_by_indexed_elem<bit opc, string asm,
                                        SDPatternOperator op> {
  def _S : sve_intx_dot_by_indexed_elem<0b0, opc, asm, ZPR32, ZPR8, ZPR3b8, sve_elm_idx_s> {
    bits<2> iop;
    bits<3> Zm;
    let Inst{20-19} = iop;
    let Inst{18-16} = Zm;
  }
  def _D : sve_intx_dot_by_indexed_elem<0b1, opc, asm, ZPR64, ZPR16, ZPR4b16, sve_elm_idx_d> {
    bits<1> iop;
    bits<4> Zm;
    let Inst{20} = iop;
    let Inst{19-16} = Zm;
  }

  def : Pat<(nxv4i32 (op nxv4i32:$Op1, nxv16i8:$Op2, nxv16i8:$Op3, (i32 sve_elm_idx_s:$idx))),
            (!cast<Instruction>(NAME # _S) $Op1, $Op2, $Op3, sve_elm_idx_s:$idx)>;
  def : Pat<(nxv2i64 (op nxv2i64:$Op1, nxv8i16:$Op2, nxv8i16:$Op3, (i32 sve_elm_idx_d:$idx))),
            (!cast<Instruction>(NAME # _D) $Op1, $Op2, $Op3, sve_elm_idx_d:$idx)>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Multiply-Add - Indexed Group
//===----------------------------------------------------------------------===//

class sve_fp_fma_by_indexed_elem<bits<2> sz, bit opc, string asm,
                                 ZPRRegOp zprty1,
                                 ZPRRegOp zprty2, Operand itype>
: I<(outs zprty1:$Zda), (ins zprty1:$_Zda, zprty1:$Zn, zprty2:$Zm, itype:$iop),
  asm, "\t$Zda, $Zn, $Zm$iop", "", []>, Sched<[]> {
  bits<5> Zda;
  bits<5> Zn;
  let Inst{31-24} = 0b01100100;
  let Inst{23-22} = sz;
  let Inst{21}    = 0b1;
  let Inst{15-11} = 0;
  let Inst{10}    = opc;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zda;

  let Constraints = "$Zda = $_Zda";
  let DestructiveInstType = DestructiveOther;
}

multiclass sve_fp_fma_by_indexed_elem<bit opc, string asm,
                                      SDPatternOperator op> {
  def _H : sve_fp_fma_by_indexed_elem<{0, ?}, opc, asm, ZPR16, ZPR3b16, sve_elm_idx_h> {
    bits<3> Zm;
    bits<3> iop;
    let Inst{22} = iop{2};
    let Inst{20-19} = iop{1-0};
    let Inst{18-16} = Zm;
  }
  def _S : sve_fp_fma_by_indexed_elem<0b10, opc, asm, ZPR32, ZPR3b32, sve_elm_idx_s> {
    bits<3> Zm;
    bits<2> iop;
    let Inst{20-19} = iop;
    let Inst{18-16} = Zm;
  }
  def _D : sve_fp_fma_by_indexed_elem<0b11, opc, asm, ZPR64, ZPR4b64, sve_elm_idx_d> {
    bits<4> Zm;
    bit iop;
    let Inst{20} = iop;
    let Inst{19-16} = Zm;
  }

  def : Pat<(nxv8f16 (op nxv8f16:$Op1, nxv8f16:$Op2, nxv8f16:$Op3, (i32 sve_elm_idx_h:$idx))),
            (!cast<Instruction>(NAME # _H) $Op1, $Op2, $Op3, sve_elm_idx_h:$idx)>;
  def : Pat<(nxv4f32 (op nxv4f32:$Op1, nxv4f32:$Op2, nxv4f32:$Op3, (i32 sve_elm_idx_s:$idx))),
            (!cast<Instruction>(NAME # _S) $Op1, $Op2, $Op3, sve_elm_idx_s:$idx)>;
  def : Pat<(nxv2f64 (op nxv2f64:$Op1, nxv2f64:$Op2, nxv2f64:$Op3, (i32 sve_elm_idx_d:$idx))),
            (!cast<Instruction>(NAME # _D) $Op1, $Op2, $Op3, sve_elm_idx_d:$idx)>;
}

//===----------------------------------------------------------------------===//
// SVE Floating Point Multiply - Indexed Group
//===----------------------------------------------------------------------===//

class sve_fp_fmul_by_indexed_elem<bits<2> sz, string asm, ZPRRegOp zprty,
                                      ZPRRegOp zprty2, Operand itype>
: I<(outs zprty:$Zd), (ins zprty:$Zn, zprty2:$Zm, itype:$iop),
  asm, "\t$Zd, $Zn, $Zm$iop", "", []>, Sched<[]> {
  bits<5> Zd;
  bits<5> Zn;
  let Inst{31-24} = 0b01100100;
  let Inst{23-22} = sz;
  let Inst{21}    = 0b1;
  let Inst{15-10} = 0b001000;
  let Inst{9-5}   = Zn;
  let Inst{4-0}   = Zd;
}

multiclass sve_fp_fmul_by_indexed_elem<string asm, SDPatternOperator op> {
  def _H : sve_fp_fmul_by_indexed_elem<{0, ?}, asm, ZPR16, ZPR3b16, sve_elm_idx_h> {
    bits<3> Zm;
    bits<3> iop;
    let Inst{22} = iop{2};
    let Inst{20-19} = iop{1-0};
    let Inst{18-16} = Zm;
  }
  def _S : sve_fp_fmul_by_indexed_elem<0b10, asm, ZPR32, ZPR3b32, sve_elm_idx_s> {
    bits<3> Zm;
    bits<2> iop;
    let Inst{20-19} = iop;
    let Inst{18-16} = Zm;
  }
  def _D : sve_fp_fmul_by_indexed_elem<0b11, asm, ZPR64, ZPR4b64, sve_elm_idx_d> {
    bits<4> Zm;
    bit iop;
    let Inst{20} = iop;
    let Inst{19-16} = Zm;
  }

  def : Pat<(nxv8f16 (op nxv8f16:$Op1, nxv8f16:$Op2, (i32 sve_elm_idx_h:$idx))),
            (!cast<Instruction>(NAME # _H) $Op1, $Op2, sve_elm_idx_h:$idx)>;
  def : Pat<(nxv4f32 (op nxv4f32:$Op1, nxv4f32:$Op2, (i32 sve_elm_idx_s:$idx))),
            (!cast<Instruction>(NAME # _S) $Op1, $Op2, sve_elm_idx_s:$idx)>;
  def : Pat<(nxv2f64 (op nxv2f64:$Op1, nxv2f64:$Op2, (i32 sve_elm_idx_d:$idx))),
            (!cast<Instruction>(NAME # _D) $Op1, $Op2, sve_elm_idx_d:$idx)>;
}
