// SVE include file for AArch64ISelLowering.cpp
// These are new additional functions added to the lowering code separated out
// to reduce the impact of merge conflicts.

static EVT getDoubleWidthHalfCountVectorVT(SelectionDAG &DAG, EVT VT) {
  unsigned EltBits = VT.getVectorElementType().getSizeInBits();
  EVT EltVT = EVT::getIntegerVT(*DAG.getContext(), EltBits * 2);
  auto HalfEC = VT.getVectorElementCount() / 2;
  return EVT::getVectorVT(*DAG.getContext(), EltVT, HalfEC);
}

static EVT getHalfWidthDoubleCountVectorVT(SelectionDAG &DAG, EVT VT) {
  unsigned EltBits = VT.getVectorElementType().getSizeInBits();
  EVT EltVT = EVT::getIntegerVT(*DAG.getContext(), EltBits / 2);
  auto DoubleEC = VT.getVectorElementCount() * 2;
  return EVT::getVectorVT(*DAG.getContext(), EltVT, DoubleEC);
}

static inline EVT getNaturalIntSVETypeWithMatchingElementCount(EVT VT) {
  if (!VT.isScalableVector())
    return EVT();

  switch (VT.getVectorNumElements()) {
    default: return EVT();
    case 16: return VT.changeVectorElementType(MVT::i8);
    case 8:  return VT.changeVectorElementType(MVT::i16);
    case 4:  return VT.changeVectorElementType(MVT::i32);
    case 2:  return VT.changeVectorElementType(MVT::i64);
  }
}

static inline EVT getNaturalIntSVETypeWithMatchingElementType(EVT VT) {
  if (!VT.isScalableVector())
    return EVT();

  switch (VT.getVectorElementType().getSimpleVT().SimpleTy) {
    default: return EVT();
    case MVT::i8:  return MVT::nxv16i8;
    case MVT::i16: return MVT::nxv8i16;
    case MVT::i32: return MVT::nxv4i32;
    case MVT::i64: return MVT::nxv2i64;
  }
}

static inline EVT getNaturalPredSVETypeWithMatchingElementType(EVT VT) {
  if (!VT.isScalableVector())
    return EVT();

  switch (VT.getVectorElementType().getSimpleVT().SimpleTy) {
    default: return EVT();
    case MVT::i8:  return MVT::nxv16i1;
    case MVT::i16: return MVT::nxv8i1;
    case MVT::i32: return MVT::nxv4i1;
    case MVT::i64: return MVT::nxv2i1;
  }
}

static inline SDValue getPTrue(SelectionDAG &DAG, SDLoc DL, EVT VT,
                               int Pattern) {
  return DAG.getNode(AArch64ISD::PTRUE, DL, VT,
                     DAG.getConstant(Pattern, DL, MVT::i32));
}

/// changeTestCCToAArch64CC - Convert a DAG test condition code to an AArch64
/// CC
static AArch64CC::CondCode changeTestCCToAArch64CC(ISD::TestCode CC) {
  switch (CC) {
  default:
    llvm_unreachable("Unknown condition code!");
  case ISD::TEST_ALL_FALSE:
    return AArch64CC::EQ;
  case ISD::TEST_ANY_TRUE:
    return AArch64CC::NE;
  case ISD::TEST_FIRST_FALSE:
    return AArch64CC::PL;
  case ISD::TEST_FIRST_TRUE:
    return AArch64CC::MI;
  case ISD::TEST_LAST_FALSE:
    return AArch64CC::HS;
  case ISD::TEST_LAST_TRUE:
    return AArch64CC::LO;
  }
}

SDValue AArch64TargetLowering::LowerINTRINSIC_W_CHAIN(SDValue Op,
                                                      SelectionDAG &DAG) const {
  SDLoc dl(Op);
  SmallVector<SDValue, 3> Results;

  ConstantSDNode *CN = cast<ConstantSDNode>(Op->getOperand(1));
  Intrinsic::ID IntID = static_cast<Intrinsic::ID>(CN->getZExtValue());
  switch (IntID) {
  default:
    return SDValue();

  case Intrinsic::masked_spec_load:
    ReplaceMaskedSpecLoadResults(Op.getNode(), Results, DAG);
    if (Results.size())
      return DAG.getMergeValues(Results, dl);
    else
      return SDValue();
    break;
  }

  return SDValue();
}

static SDValue LowerDIV(SDValue Op, SelectionDAG &DAG) {
  assert(Op.getOpcode() == ISD::SDIV || Op.getOpcode() == ISD::UDIV);

  EVT VT = Op.getValueType();
  if ((VT != MVT::nxv16i8) && (VT != MVT::nxv8i16))
    return SDValue();

  SDLoc DL(Op);
  bool isSigned = Op.getOpcode() == ISD::SDIV;
  unsigned ExtHiOpc = isSigned ? AArch64ISD::SUNPKHI : AArch64ISD::UUNPKHI;
  unsigned ExtLoOpc = isSigned ? AArch64ISD::SUNPKLO : AArch64ISD::UUNPKLO;

  // Factors required to perform the operation using 32bit type (i.e. nxv4i32).
  unsigned MaxFactor = VT.getVectorNumElements() / 4;

  SmallVector<SDValue, 16> Res(MaxFactor);
  SmallVector<SDValue, 16> Op0(MaxFactor);
  SmallVector<SDValue, 16> Op1(MaxFactor);

  unsigned Factors = 1;
  Op0[0] = Op.getOperand(0);
  Op1[0] = Op.getOperand(1);

  // Extend the operands until suitable for the operation.
  for (; Factors < MaxFactor; Factors *= 2) {
    VT = getDoubleWidthHalfCountVectorVT(DAG, VT);

    for (unsigned i = Factors; i > 0; --i) {
      Op0[2*i-1] = DAG.getNode(ExtHiOpc, DL, VT, Op0[i-1]);
      Op0[2*i-2] = DAG.getNode(ExtLoOpc, DL, VT, Op0[i-1]);
      Op1[2*i-1] = DAG.getNode(ExtHiOpc, DL, VT, Op1[i-1]);
      Op1[2*i-2] = DAG.getNode(ExtLoOpc, DL, VT, Op1[i-1]);
    }
  }

  // Perform the operation using extended operands.
  for (unsigned i = 0; i < Factors; ++i)
    Res[i] = DAG.getNode(Op.getOpcode(), DL, VT, Op0[i], Op1[i]);

  // Truncate the result.
  for (; Factors > 1; Factors /= 2) {
    VT = getHalfWidthDoubleCountVectorVT(DAG, VT);

    for (unsigned i = 0; i < Factors; i += 2)
      Res[i/2] = DAG.getNode(AArch64ISD::UZP1, DL, VT, Res[i], Res[i+1]);
  }

  assert(Factors == 1);
  return Res[0];
}

static SDValue LowerREM(SDValue Op, SelectionDAG &DAG) {
  assert(Op.getOpcode() == ISD::SREM || Op.getOpcode() == ISD::UREM);
  SDLoc DL(Op);
  EVT VT = Op.getValueType();
  unsigned DivOp = Op.getOpcode() == ISD::SREM ? ISD::SDIV : ISD::UDIV;

  SDValue Div = DAG.getNode(DivOp, DL, VT, Op.getOperand(0), Op.getOperand(1));
  SDValue Mul = DAG.getNode(ISD::MUL, DL, VT, Div, Op.getOperand(1));
  SDValue Rem = DAG.getNode(ISD::SUB, DL, VT, Op.getOperand(0), Mul);
  return Rem;
}

bool AArch64TargetLowering::isVectorLoadExtDesirable(SDValue ExtVal) const {
  if (ExtVal.getValueType().isScalableVector())
    return true;
  return false;
}

// Lowering of LASTA and LASTB
// Recursively perform:
//              { 1,  1,  1,  1,   1,   1,  0,  0 }
//              {ab, cd, ef, gh }{ ij, kl, mn, op }
//    uzp_lo => { b,  d,  f,  h,   j,   l,  n,  p}
//    uzp_hi => { a,  c,  e,  g,   i,   k,  m,  o}
//    lastb_lo => l
//    lastb_hi => k
//    result => (lastb_hi << 8) | lastb_lo => kl
SDValue AArch64TargetLowering::LowerLASTX(SDValue Op, SelectionDAG &DAG) const {
  SDLoc DL(Op);
  SDValue Pred = Op.getOperand(0);
  SDValue InVec = Op.getOperand(1);

  if (isTypeLegal(InVec.getValueType()))
    return Op;

  EVT VT = Op.getValueType();
  if (VT.isFloatingPoint()) {
    EVT IntResVT = VT.changeTypeToInteger();
    EVT IntVecVT = InVec.getValueType().changeVectorElementTypeToInteger();
    SDValue IntInVec = DAG.getNode(ISD::BITCAST, DL, IntVecVT, InVec);
    SDValue Res = DAG.getNode(Op.getOpcode(), DL, IntResVT, Pred, IntInVec);
    return DAG.getNode(ISD::BITCAST, DL, VT, Res);
  }

  assert(isTypeLegal(Pred.getValueType()) && "Need a legal predicate type");

  // Type #elements stays the same
  EVT EltVT = InVec.getValueType().getVectorElementType();
  EVT NewEltVT = EVT::getIntegerVT(*DAG.getContext(), EltVT.getSizeInBits()/2);
  EVT SplitVT = InVec.getValueType().changeVectorElementType(NewEltVT);

  // Split sequence
  SDValue InVecLo, InVecHi;
  std::tie(InVecLo, InVecHi) = DAG.SplitVector(InVec, DL);

  // Bitcast to different type
  InVecLo = DAG.getNode(ISD::BITCAST, DL, SplitVT, InVecLo);
  InVecHi = DAG.getNode(ISD::BITCAST, DL, SplitVT, InVecHi);

  // Unzip (because #elements is same, it splits up elements in two parts)
  SDValue Zero = DAG.getConstant(0, DL, MVT::i32);
  SDValue One  = DAG.getConstant(1, DL, MVT::i32);
  SDValue Step  = DAG.getConstant(2, DL, MVT::i32);
  SDValue SVEven = DAG.getNode(ISD::SERIES_VECTOR, DL, SplitVT, Zero, Step);
  SDValue SVOdd = DAG.getNode(ISD::SERIES_VECTOR, DL, SplitVT, One, Step);

  SDValue Even = DAG.getNode(ISD::VECTOR_SHUFFLE_VAR, DL, SplitVT,
                             InVecLo, InVecHi, SVEven);
  SDValue Odd  = DAG.getNode(ISD::VECTOR_SHUFFLE_VAR, DL, SplitVT,
                             InVecLo, InVecHi, SVOdd);

  // Do a LAST(A|B) for even and uneven
  SDValue ResEven = DAG.getNode(Op.getOpcode(), DL, MVT::i32, Pred, Even);
  SDValue ResOdd  = DAG.getNode(Op.getOpcode(), DL, MVT::i32, Pred, Odd);

  // Possibly extend to i64 type to do the final combine
  if (VT != MVT::i32) {
    ResEven = DAG.getNode(ISD::ZERO_EXTEND, DL, VT, ResEven);
    ResOdd = DAG.getNode(ISD::ANY_EXTEND, DL, VT, ResOdd);
  }

  SDValue NewEltBits = DAG.getConstant(NewEltVT.getSizeInBits(), DL, MVT::i32);
  SDValue Res = DAG.getNode(ISD::SHL, DL, VT, ResOdd, NewEltBits);
  Res = DAG.getNode(ISD::OR, DL, VT, Res, ResEven);

  return Res;
}

// Use SVE to implement fixed-width masked loads.
static SDValue LowerMLOAD(SDValue Op, SelectionDAG &DAG) {
  auto MLN = cast<MaskedLoadSDNode>(Op.getNode());
  SDValue Mask = MLN->getMask();
  SDValue Src0 = MLN->getSrc0();

  EVT VT = Op.getValueType();
  if (!DAG.getTargetLoweringInfo().isTypeLegal(VT) ||
      VT.isScalableVector())
    return SDValue();

  SDLoc DL(Op);
  EVT DataVT, MaskVT;

  switch (VT.getVectorElementType().getSimpleVT().SimpleTy) {
  default: return SDValue();
  case MVT::i8:  DataVT = MVT::nxv16i8; MaskVT = MVT::nxv16i8; break;
  case MVT::i16: DataVT = MVT::nxv8i16; MaskVT = MVT::nxv8i16; break;
  case MVT::i32: DataVT = MVT::nxv4i32; MaskVT = MVT::nxv4i32; break;
  case MVT::f32: DataVT = MVT::nxv4f32; MaskVT = MVT::nxv4i32; break;
  case MVT::i64: DataVT = MVT::nxv2i64; MaskVT = MVT::nxv2i64; break;
  case MVT::f64: DataVT = MVT::nxv2f64; MaskVT = MVT::nxv2i64; break;
  }

  // TODO: Rather than mask InsertSubReg with a fixed length predicate we could
  // just insert the original mask into a zero'd register.
  int PgPattern;
  switch (VT.getVectorNumElements()) {
    default: return SDValue();
    case 16: PgPattern = AArch64SVEPredPattern::vl16; break;
    case  8: PgPattern = AArch64SVEPredPattern::vl8; break;
    case  4: PgPattern = AArch64SVEPredPattern::vl4; break;
    case  2: PgPattern = AArch64SVEPredPattern::vl2; break;
  }

  // Widen the NEON operands to SVE.
  int Idx = VT.is64BitVector() ? AArch64::dsub : AArch64::zsub;
  Mask = DAG.getTargetInsertSubreg(Idx, DL, MaskVT, DAG.getUNDEF(MaskVT), Mask);
  Src0 = DAG.getTargetInsertSubreg(Idx, DL, DataVT, DAG.getUNDEF(DataVT), Src0);

  // Create a predicate restricted to the size of the NEON input.
  //
  // For the case of v2i32/v2f32, this works due to the fact the
  // load is contiguous and doesn't need to expand to unpacked
  // types like the gather lowering below.
  EVT PredVT = MaskVT.changeVectorElementType(MVT::i1);
  SDValue Pg = getPTrue(DAG, DL, PredVT, PgPattern);
  Mask = DAG.getNode(ISD::TRUNCATE, DL, PredVT, Mask);
  Mask = DAG.getNode(ISD::AND, DL, PredVT, Mask, Pg);

  SDValue MLoad = DAG.getMaskedLoad(DataVT, DL, MLN->getChain(),
                                    MLN->getBasePtr(), Mask, Src0,
                                    MLN->getMemoryVT(), MLN->getMemOperand(),
                                    MLN->getExtensionType());

  SDValue Res = DAG.getTargetExtractSubreg(Idx, DL, VT, MLoad.getValue(0));
  return DAG.getMergeValues({ Res, MLoad.getValue(1) }, DL);
}

// Use SVE to implement fixed-width masked stores.
static SDValue LowerMSTORE(SDValue Op, SelectionDAG &DAG) {
  auto MSN = cast<MaskedStoreSDNode>(Op.getNode());
  SDValue Mask = MSN->getMask();
  SDValue Data = MSN->getValue();

  EVT VT = Data.getValueType();
  if (!DAG.getTargetLoweringInfo().isTypeLegal(VT) ||
      VT.isScalableVector())
    return SDValue();

  SDLoc DL(Op);
  EVT DataVT, MaskVT;

  switch (VT.getVectorElementType().getSimpleVT().SimpleTy) {
  default: return SDValue();
  case MVT::i8:  DataVT = MVT::nxv16i8; MaskVT = MVT::nxv16i8; break;
  case MVT::i16: DataVT = MVT::nxv8i16; MaskVT = MVT::nxv8i16; break;
  case MVT::i32: DataVT = MVT::nxv4i32; MaskVT = MVT::nxv4i32; break;
  case MVT::f32: DataVT = MVT::nxv4f32; MaskVT = MVT::nxv4i32; break;
  case MVT::i64: DataVT = MVT::nxv2i64; MaskVT = MVT::nxv2i64; break;
  case MVT::f64: DataVT = MVT::nxv2f64; MaskVT = MVT::nxv2i64; break;
  }

  // TODO: Rather than mask InsertSubReg with a fixed length predicate we could
  // just insert the original into a zero'd register.
  int PgPattern;
  switch (VT.getVectorNumElements()) {
    default: return SDValue();
    case 16: PgPattern = AArch64SVEPredPattern::vl16; break;
    case  8: PgPattern = AArch64SVEPredPattern::vl8; break;
    case  4: PgPattern = AArch64SVEPredPattern::vl4; break;
    case  2: PgPattern = AArch64SVEPredPattern::vl2; break;
  }

  // Widen the NEON operands to SVE.
  int Idx = VT.is64BitVector() ? AArch64::dsub : AArch64::zsub;
  Mask = DAG.getTargetInsertSubreg(Idx, DL, MaskVT, DAG.getUNDEF(MaskVT), Mask);
  Data = DAG.getTargetInsertSubreg(Idx, DL, DataVT, DAG.getUNDEF(DataVT), Data);

  // Create a predicate restricted to the size of the NEON input.
  EVT PredVT = MaskVT.changeVectorElementType(MVT::i1);
  SDValue Pg = getPTrue(DAG, DL, PredVT, PgPattern);
  Mask = DAG.getNode(ISD::TRUNCATE, DL, PredVT, Mask);
  Mask = DAG.getNode(ISD::AND, DL, PredVT, Mask, Pg);

  return DAG.getMaskedStore(MSN->getChain(), DL, Data, MSN->getBasePtr(), Mask,
                            MSN->getMemoryVT(), MSN->getMemOperand(),
                            MSN->isTruncatingStore());
}

// Use SVE to implement fixed-width masked gathers.
static SDValue LowerMGATHER(SDValue Op, SelectionDAG &DAG) {
  const TargetLowering &TLI = DAG.getTargetLoweringInfo();
  auto MGN = cast<MaskedGatherSDNode>(Op.getNode());
  SDValue Mask = MGN->getMask();
  SDValue Src0 = MGN->getSrc0();
  SDValue Idxs = MGN->getIndex();

  EVT VT = Op.getValueType();
  if (!TLI.isTypeLegal(VT) || VT.isScalableVector())
    return SDValue();

  SDLoc DL(Op);
  unsigned NumEls = VT.getVectorNumElements();
  EVT SveVT  = (NumEls == 2) ? MVT::nxv2i64 : MVT::nxv4i32;
  EVT NeonVT = (NumEls == 2) ? MVT::v2i64   : MVT::v4i32;
  SDValue Undef = DAG.getUNDEF(SveVT);

  // We don't care about the actual data, just the number of bits.
  if (VT.isFloatingPoint())
    Src0 = DAG.getNode(ISD::BITCAST, DL, VT.changeTypeToInteger(), Src0);

  // Promote all vectors to 128bit...
  Src0 = DAG.getNode(ISD::ANY_EXTEND, DL, NeonVT, Src0);
  Mask = DAG.getNode(ISD::ANY_EXTEND, DL, NeonVT, Mask);
  Idxs = DAG.getNode(ISD::SIGN_EXTEND, DL, NeonVT, Idxs);

  // ...then make them scalable.
  Src0 = DAG.getTargetInsertSubreg(AArch64::zsub, DL, SveVT, Undef, Src0);
  Mask = DAG.getTargetInsertSubreg(AArch64::zsub, DL, SveVT, Undef, Mask);
  Idxs = DAG.getTargetInsertSubreg(AArch64::zsub, DL, SveVT, Undef, Idxs);

  // Convert the mask to a real predicate.
  EVT PredVT = SveVT.changeVectorElementType(MVT::i1);
  SDValue Pg = getPTrue(DAG, DL, PredVT, (NumEls == 2)
                ? AArch64SVEPredPattern::vl2
                : AArch64SVEPredPattern::vl4);
  Mask = DAG.getNode(ISD::TRUNCATE, DL, PredVT, Mask);
  Mask = DAG.getNode(ISD::AND, DL, PredVT, Mask, Pg);

  // Extension is introduced when we promote the data operand.
  EVT MemVT = MGN->getMemoryVT().changeTypeToInteger();
  ISD::LoadExtType Ext = MGN->getExtensionType();
  if ((Ext == ISD::NON_EXTLOAD) && (MemVT != NeonVT))
    Ext = ISD::SEXTLOAD;

  SDValue Ops[] = { MGN->getChain(), Src0, Mask, MGN->getBasePtr(), Idxs };
  SDValue MGather = DAG.getMaskedGather(DAG.getVTList(SveVT, MVT::Other),
                                        MemVT, DL, Ops, MGN->getMemOperand(),
                                        Ext, MGN->getIndexType());

  // Convert load data back into a fixed-width type...
  SDValue Data = MGather.getValue(0);
  Data = DAG.getTargetExtractSubreg(AArch64::zsub, DL, NeonVT, Data);
  Data = DAG.getNode(ISD::TRUNCATE, DL, VT.changeTypeToInteger(), Data);

  // ...of the correct denomination.
  if (VT.isFloatingPoint())
    Data = DAG.getNode(ISD::BITCAST, DL, VT, Data);

  return DAG.getMergeValues({ Data, MGather.getValue(1) }, DL);
}

// Use SVE to implement fixed-width masked scatters.
static SDValue LowerMSCATTER(SDValue Op, SelectionDAG &DAG) {
  const TargetLowering &TLI = DAG.getTargetLoweringInfo();
  auto MSN = cast<MaskedScatterSDNode>(Op.getNode());
  SDValue Mask = MSN->getMask();
  SDValue Data = MSN->getValue();
  SDValue Idxs = MSN->getIndex();

  EVT VT = Data.getValueType();
  if (!TLI.isTypeLegal(VT) || VT.isScalableVector())
    return SDValue();

  SDLoc DL(Op);
  unsigned NumEls = VT.getVectorNumElements();
  EVT SveVT  = (NumEls == 2) ? MVT::nxv2i64 : MVT::nxv4i32;
  EVT NeonVT = (NumEls == 2) ? MVT::v2i64   : MVT::v4i32;
  SDValue Undef = DAG.getUNDEF(SveVT);

  // We don't care about the actual data, just the number of bits.
  if (VT.isFloatingPoint())
    Data = DAG.getNode(ISD::BITCAST, DL, VT.changeTypeToInteger(), Data);

  // Promote all vectors to 128bit...
  Data = DAG.getNode(ISD::ANY_EXTEND, DL, NeonVT, Data);
  Mask = DAG.getNode(ISD::ANY_EXTEND, DL, NeonVT, Mask);
  Idxs = DAG.getNode(ISD::SIGN_EXTEND, DL, NeonVT, Idxs);

  // ...then make them scalable.
  Data = DAG.getTargetInsertSubreg(AArch64::zsub, DL, SveVT, Undef, Data);
  Mask = DAG.getTargetInsertSubreg(AArch64::zsub, DL, SveVT, Undef, Mask);
  Idxs = DAG.getTargetInsertSubreg(AArch64::zsub, DL, SveVT, Undef, Idxs);

  // Convert the mask to a real predicate.
  EVT PredVT = SveVT.changeVectorElementType(MVT::i1);
  SDValue Pg = getPTrue(DAG, DL, PredVT, (NumEls == 2)
                  ? AArch64SVEPredPattern::vl2
                  : AArch64SVEPredPattern::vl4);
  Mask = DAG.getNode(ISD::TRUNCATE, DL, PredVT, Mask);
  Mask = DAG.getNode(ISD::AND, DL, PredVT, Mask, Pg);

  // Truncation is introduced when we promote the data operand.
  EVT MemVT = MSN->getMemoryVT().changeTypeToInteger();
  bool isTrunc = (MemVT != NeonVT);

  SDValue Ops[] = { MSN->getChain(), Data, Mask, MSN->getBasePtr(), Idxs };
  return DAG.getMaskedScatter(DAG.getVTList(MVT::Other), MemVT, DL, Ops,
                              MSN->getMemOperand(), isTrunc,
                              MSN->getIndexType());
}

static SDValue getElementCountVector(SelectionDAG &DAG, SDLoc dl, EVT ResVT,
                                     EVT VecVT) {
  EVT EltType = ResVT.getVectorElementType();
  if (EltType.getSizeInBits() < 32)
    EltType = MVT::i32;
  SDValue EltCount = DAG.getVScale(dl, MVT::i64, VecVT.getVectorNumElements());
  EltCount = DAG.getZExtOrTrunc(EltCount, dl, EltType);
  return DAG.getNode(AArch64ISD::DUP, dl, ResVT, EltCount);
}

// Use Opcode to join consecutive vector operands in Ops together,
// then use CONCAT_VECTORS to join the results into a single vector.
static SDValue getSVEChainShuffle(unsigned Opcode, ArrayRef<SDValue> Ops,
                                    unsigned Factor, SelectionDAG &DAG,
                                    SDLoc dl, EVT VT, bool reverse = false) {
  SmallVector<SDValue, 8> Nodes(Factor);
  if (!reverse) {
    for (unsigned i = 0; i < Factor; ++i) {
      SDValue Op0 = Ops[i * 2];
      SDValue Op1 = Ops[i * 2 + 1];
      Nodes[i] = DAG.getNode(Opcode, dl, Op0.getValueType(), Op0, Op1);
    }
  } else {
    for (unsigned i = 0; i < Factor; ++i) {
      SDValue Op0 = Ops[i];
      Nodes[Factor-1-i] = DAG.getNode(Opcode, dl, Op0.getValueType(), Op0);
    }
  }
  return DAG.getNode(ISD::CONCAT_VECTORS, dl, VT, Nodes);
}

// Lower a VECTOR_SHUFFLE_VAR node that operates on vectors that are Factor
// times wider than a legal SVE vector by using smaller shuffles of type
// NewVT.
SDValue AArch64TargetLowering::LowerVECTOR_SHUFFLE_VAR(
    SDValue Op, SelectionDAG &DAG, unsigned Factor, EVT NewVT) const {
  SDLoc dl(Op);
  EVT VT = Op.getValueType();
  SDValue Op0 = Op.getOperand(0);
  SDValue Op1 = Op.getOperand(1);
  SDValue Sel = Op.getOperand(2);
  auto NewEltCnt = NewVT.getVectorElementCount();

  // Divide concat(Op0, Op1) into NewVT pieces.
  SmallVector<SDValue, 16> Ops(Factor * 2);
  if (Factor == 1) {
    Ops[0] = Op0;
    Ops[1] = Op1;
  } else {
    for (unsigned i = 0; i < Factor; ++i) {
      SDValue Index = DAG.getConstant(i * NewEltCnt.Min, dl, MVT::i32);
      Ops[i] = DAG.getNode(ISD::EXTRACT_SUBVECTOR, dl, NewVT, Op0, Index);
      Ops[i + Factor] = DAG.getNode(ISD::EXTRACT_SUBVECTOR, dl, NewVT,
                                    Op1, Index);
    }
  }

  if (Sel.getOpcode() == ISD::SPLAT_VECTOR) {
    // Check for a splat of a vector insert.
    auto CSplatElt = dyn_cast<ConstantSDNode>(Sel.getOperand(0));
    if (CSplatElt && CSplatElt->getZExtValue() == 0) {
      if (Op0.getOpcode() == ISD::SCALAR_TO_VECTOR)
        return DAG.getNode(ISD::SPLAT_VECTOR, dl, VT, Op0.getOperand(0));
      else if (Op0.getOpcode() == ISD::ZERO_EXTEND &&
               Op0.getOperand(0).getOpcode() == ISD::SCALAR_TO_VECTOR) {
        SDValue Scalar = Op0.getOperand(0).getOperand(0);
        EVT SplatVT = Op0.getOperand(0).getValueType();
        SDValue Splat = DAG.getNode(ISD::SPLAT_VECTOR, dl, SplatVT, Scalar);
        return DAG.getNode(ISD::ZERO_EXTEND, dl, VT, Splat);
      }
    }
  }

  if (Sel.getOpcode() == ISD::SERIES_VECTOR) {
    // Look for patterns that have SVE instructions associated with them.
    SDValue Start = Sel.getOperand(0);
    SDValue Step = Sel.getOperand(1);
    if (isa<ConstantSDNode>(Start) && isa<ConstantSDNode>(Step)) {
      uint64_t CStart = cast<ConstantSDNode>(Start)->getZExtValue();
      uint64_t CStep = cast<ConstantSDNode>(Step)->getZExtValue();
      if (CStart == 0 && CStep == 2)
        return getSVEChainShuffle(AArch64ISD::UZP1, Ops, Factor, DAG, dl, VT);
      if (CStart == 1 && CStep == 2)
        return getSVEChainShuffle(AArch64ISD::UZP2, Ops, Factor, DAG, dl, VT);
      // Look for a splat.
      if (CStart == 0 && CStep == 0 &&
          Op0.getOpcode() == ISD::SCALAR_TO_VECTOR) {
        return DAG.getNode(ISD::SPLAT_VECTOR, dl, VT, Op0.getOperand(0));
      }
      // Look for a zero-extended splat.
      if (CStart == 0 && CStep == 0 &&
          Op0.getOpcode() == ISD::ZERO_EXTEND &&
          Op0.getOperand(0).getOpcode() == ISD::SCALAR_TO_VECTOR) {
        SDValue Scalar = Op0.getOperand(0).getOperand(0);
        EVT SplatVT = Op0.getOperand(0).getValueType();
        SDValue Splat = DAG.getNode(ISD::SPLAT_VECTOR, dl, SplatVT, Scalar);
        return DAG.getNode(ISD::ZERO_EXTEND, dl, VT, Splat);
      }
    } else {
      //   seriesvector((vscale * NumElts) - 1, -1)
      if ((Start.getOpcode() == ISD::ADD) &&
          (Start.getOperand(0).getOpcode() == ISD::VSCALE) &&
          (isa<ConstantSDNode>(Start.getOperand(1))) &&
          (isa<ConstantSDNode>(Step))) {
        SDValue VSImm = Start.getOperand(0).getOperand(0);
        int64_t NumElts = Sel.getValueType().getVectorNumElements();

        if ((cast<ConstantSDNode>(VSImm)->getSExtValue() == NumElts) &&
            (cast<ConstantSDNode>(Start.getOperand(1))->getSExtValue() == -1) &&
            (cast<ConstantSDNode>(Step)->getSExtValue() == -1)) {
          return getSVEChainShuffle(AArch64ISD::REV, Ops, Factor, DAG, dl, VT,
                                    true);
        }
      }
    }
  }

  if (NewVT.getVectorElementType() == MVT::i1) {
    EVT Elt;
    switch (Op0.getValueType().getSimpleVT().SimpleTy) {
    case MVT::nxv2i1: Elt = MVT::i64; break;
    case MVT::nxv4i1: Elt = MVT::i32; break;
    case MVT::nxv8i1: Elt = MVT::i16; break;
    case MVT::nxv16i1: Elt = MVT::i8; break;
    default:
      llvm_unreachable("unexpected predicate type");
    }

    EVT VT1 = EVT::getVectorVT(*DAG.getContext(), Elt,
                               Op0.getValueType().getVectorElementCount());
    EVT VT2 = EVT::getVectorVT(*DAG.getContext(), Elt, NewEltCnt );

    Op0 = DAG.getNode(ISD::ANY_EXTEND, dl, VT1, Op0);
    Op1 = DAG.getNode(ISD::ANY_EXTEND, dl, VT1, Op1);
    SDValue VS = DAG.getNode(ISD::VECTOR_SHUFFLE_VAR, dl, VT2, Op0, Op1, Sel);
    return DAG.getNode(ISD::TRUNCATE, dl, NewVT, VS);
  }

  EVT SelVT = Sel.getValueType();
  unsigned SelEltBits = SelVT.getVectorElementType().getSizeInBits();
  unsigned EltBits = VT.getVectorElementType().getSizeInBits();

  bool FloatCast = NewVT.isFloatingPoint();
  EVT SavedType = Op.getValueType();
  EVT TruncType = SavedType;
  if (FloatCast) {
    assert(NewVT == VT &&
           "Float bitcasts in vecshufvar currently rely on types being equal");
    NewVT = VT = VT.changeVectorElementTypeToInteger();
    Op0 = DAG.getNode(ISD::BITCAST, dl, VT, Op0);
    Op1 = DAG.getNode(ISD::BITCAST, dl, VT, Op1);
    TruncType = VT;
  }

  if (EltBits == 8 && SelEltBits > 8 && Op1.getOpcode() != ISD::UNDEF) {
    // We're using a 16-bit mask to select 8-bit elements.  Since the
    // architecture limits the size of SVE vectors to 2048 bits,
    // an i8 mask element is big enough to select any element of the
    // first vector but might be too small to select an element of
    // the second vector.  We therefore need to do the selection
    // on i16s and then truncate the result back to i8s.
    EltBits *= 2;
    EVT EltVT = EVT::getIntegerVT(*DAG.getContext(), EltBits);
    VT = EVT::getVectorVT(*DAG.getContext(), EltVT,
                          VT.getVectorElementCount());
    // Widen each element of Ops by a factor of two and then split each
    // widened value to get a pair of legal SVE vectors.
    EVT DoubleVT = EVT::getVectorVT(*DAG.getContext(), EltVT, NewEltCnt);
    NewEltCnt /= 2;
    NewVT = EVT::getVectorVT(*DAG.getContext(), EltVT, NewEltCnt);
    Factor *= 2;
    Ops.resize(Factor * 2);
    for (unsigned i = Factor; i-- > 0;) {
      SDValue Ext = DAG.getNode(ISD::ANY_EXTEND, dl, DoubleVT, Ops[i]);
      std::tie(Ops[i * 2], Ops[i * 2 + 1]) = DAG.SplitVector(Ext, dl,
                                                             NewVT, NewVT);
    }
  }
  // Convert the mask to the element size.  This is always safe if the
  // result is i16 or wider, since i16 can hold any value in the range
  // [0, 2*VL).  The code above dealt with the cases where truncating
  // to i8 would be unsafe.
  if (EltBits != SelEltBits) {
    Sel = DAG.getZExtOrTrunc(Sel, dl, VT);
  }

  // Get the number of elements in each legally-typed piece.
  SDValue Width = getElementCountVector(DAG, dl, NewVT, NewVT);
  SmallVector<SDValue, 8> Nodes(Factor);
  SmallVector<SDValue, 8> SubNodes(Factor * 2);
  for (unsigned i = 0; i < Factor; ++i) {
    // SubSel is the selector for piece i of the result.  The part contributed
    // by piece j of Ops is given by:
    //
    //   TBL (Ops[j], SubSel - j * Width)
    //
    // in which the elements not taken from Ops[j] are zero.  We can then
    // OR up the results to get the final value.
    SDValue Index = DAG.getConstant(i * NewEltCnt.Min, dl, MVT::i32);
    SDValue SubSel = DAG.getNode(ISD::EXTRACT_SUBVECTOR, dl, NewVT, Sel, Index);
    for (unsigned j = 0; j < Factor * 2; ++j) {
      if (j != 0)
        // Calculate SubSel - j * Width using a series of subtractions.
        SubSel = DAG.getNode(ISD::SUB, dl, NewVT, SubSel, Width);
      SubNodes[j] = DAG.getNode(AArch64ISD::TBL, dl, NewVT, Ops[j], SubSel);
    }
    // Create a tree of Factor*2-1 ORs.
    for (unsigned j = Factor; j > 0; j /= 2)
      for (unsigned k = 0; k < j; ++k)
        SubNodes[k] = DAG.getNode(ISD::OR, dl, NewVT, SubNodes[k],
                                  SubNodes[k + j]);
    Nodes[i] = SubNodes[0];
  }
  SDValue Concat = DAG.getNode(ISD::CONCAT_VECTORS, dl, VT, Nodes);
  // If we had to widen the elements above, convert the result back
  // to the original type.
  SDValue Shuffled = DAG.getNode(ISD::TRUNCATE, dl, TruncType, Concat);

  if (FloatCast)
    Shuffled = DAG.getNode(ISD::BITCAST, dl, SavedType, Shuffled);

  return Shuffled;
}

SDValue AArch64TargetLowering::LowerSERIES_VECTOR(SDValue Op,
                                                  SelectionDAG &DAG) const {
  SDLoc dl(Op);
  EVT VT = Op.getValueType();
  EVT ElemVT = VT.getScalarType();

  SDValue Start = Op.getOperand(0);
  SDValue Step = Op.getOperand(1);

  if (VT.getVectorElementType().isFloatingPoint())
    return SDValue();

  if (ElemVT == MVT::i1) {
    auto *CStart = dyn_cast<ConstantSDNode>(Op.getOperand(0));
    auto *CStep = dyn_cast<ConstantSDNode>(Op.getOperand(1));

    if (CStart && CStep && CStep->isNullValue()) {
      if (CStart->isNullValue())
        return SDValue(DAG.getMachineNode(AArch64::PFALSE, dl, VT), 0);
      else
        return DAG.getNode(AArch64ISD::PTRUE, dl, VT,
                           DAG.getConstant(31, dl, MVT::i32));
    } else {
      auto EltCnt = VT.getVectorElementCount();
      int ExtBits = AArch64::SVEBitsPerBlock / EltCnt.Min;
      EVT ExtVT = EVT::getIntegerVT(*DAG.getContext(), ExtBits);

      EVT SplatVT = EVT::getVectorVT(*DAG.getContext(), ExtVT, EltCnt);
      SDValue Splat = DAG.getNode(ISD::SERIES_VECTOR, dl, SplatVT, Start, Step);
      return DAG.getNode(ISD::TRUNCATE, dl, VT, Splat);
    }
  } else if (ElemVT == MVT::i64) {
    SDValue Op1 = DAG.getSExtOrTrunc(Op.getOperand(0), dl, ElemVT);
    SDValue Op2 = DAG.getSExtOrTrunc(Op.getOperand(1), dl, ElemVT);
    return DAG.getNode(ISD::SERIES_VECTOR, dl, VT, Op1, Op2);
  }

  // use default expansion for everything else
  return SDValue();
}

SDValue AArch64TargetLowering::LowerSPLAT_VECTOR(SDValue Op,
                                                 SelectionDAG &DAG) const {
  SDLoc dl(Op);
  EVT VT = Op.getValueType();
  EVT ElemVT = VT.getScalarType();

  SDValue SplatVal = Op.getOperand(0);

  switch (ElemVT.getSimpleVT().SimpleTy) {
  case MVT::i1:
    if (auto CSplatVal = dyn_cast<ConstantSDNode>(SplatVal)) {
      if (CSplatVal->isNullValue())
        return SDValue(DAG.getMachineNode(AArch64::PFALSE, dl, VT), 0);
      else
        return DAG.getNode(AArch64ISD::PTRUE, dl, VT,
                           DAG.getConstant(31, dl, MVT::i32));
    } else {
      auto EltCnt = VT.getVectorElementCount();
      int ExtBits = AArch64::SVEBitsPerBlock / EltCnt.Min;
      EVT ExtVT = EVT::getIntegerVT(*DAG.getContext(), ExtBits);

      switch (ExtVT.getSimpleVT().SimpleTy) {
      case MVT::i64:
        SplatVal = DAG.getAnyExtOrTrunc(SplatVal, dl, MVT::i64);
        break;
      case MVT::i32:
      case MVT::i16:
      case MVT::i8:
        SplatVal = DAG.getAnyExtOrTrunc(SplatVal, dl, MVT::i32);
        break;
      default:
        llvm_unreachable("Unusable extended element type for i1 splat!");
        break;
      }

      EVT SplatVT = EVT::getVectorVT(*DAG.getContext(), ExtVT, EltCnt);
      SDValue Splat = DAG.getNode(AArch64ISD::DUP, dl, SplatVT, SplatVal);
      return DAG.getNode(ISD::TRUNCATE, dl, VT, Splat);
    }
    break;
  case MVT::i8:
  case MVT::i16:
    SplatVal = DAG.getAnyExtOrTrunc(SplatVal, dl, MVT::i32);
    break;
  case MVT::i64:
    SplatVal = DAG.getAnyExtOrTrunc(SplatVal, dl, MVT::i64);
    break;
  case MVT::i32:
  case MVT::f16:
  case MVT::f32:
  case MVT::f64:
    // Fine as is
    break;
  default:
    llvm_unreachable("Unsupported SPLAT_VECTOR input operand type");
    break;
  }

  return DAG.getNode(AArch64ISD::DUP, dl, VT, SplatVal);
}

SDValue AArch64TargetLowering::LowerTEST_VECTOR(SDValue Op,
                                                SelectionDAG &DAG) const {
  assert(Op.getOpcode() == ISD::TEST_VECTOR && "Unknown opcode!");

  SDLoc dl(Op);
  EVT VT = Op.getValueType();
  SDValue V = Op.getOperand(0);

  if (V.getValueType().isVector()) {
    assert(V.getValueType().getScalarType() == MVT::i1);
    SDValue TVal = DAG.getConstant(1, dl, VT);
    SDValue FVal = DAG.getConstant(0, dl, VT);

    ISD::TestCode Pred = cast<TestCodeSDNode>(Op.getOperand(1))->get();

    // These are not a natural result of PTEST but can be obtained by inverting
    // the operand along with the predicate (i.e TRUE->FALSE, FALSE->TRUE).
    if ((Pred == ISD::TEST_ALL_TRUE) || (Pred == ISD::TEST_ANY_FALSE)) {
      V = DAG.getNode(AArch64ISD::NOT, dl, V.getValueType(), V);
      Pred = (Pred == ISD::TEST_ALL_TRUE) ? ISD::TEST_ALL_FALSE
                                          : ISD::TEST_ANY_TRUE;
    }

    SDValue Pg = DAG.getNode(AArch64ISD::PTRUE, dl, V.getValueType(),
                             DAG.getConstant(31, dl, MVT::i32));

    AArch64CC::CondCode CC = changeTestCCToAArch64CC(Pred);
    SDValue CCVal = DAG.getConstant(getInvertedCondCode(CC), dl, MVT::i32);
    SDValue Cmp = DAG.getNode(AArch64ISD::PTEST, dl, MVT::Other, Pg, V);
    return DAG.getNode(AArch64ISD::CSEL, dl, VT, FVal, TVal, CCVal, Cmp);
  }

  return SDValue();
}

SDValue AArch64TargetLowering::LowerCONCAT_VECTORS(SDValue Op,
                                                   SelectionDAG &DAG) const {
  EVT VT = Op.getValueType();
  assert(VT.isScalableVector() && "can only lower WA vectors");
  assert(isTypeLegal(VT) && "expected type legal result");

  EVT OpVT = Op.getOperand(0).getValueType();
  if (OpVT != Op.getOperand(1).getValueType())
    return SDValue();

  SDLoc dl(Op);
  SDValue OpLHS = Op.getOperand(0);
  SDValue OpRHS = Op.getOperand(1);

  assert(VT.getVectorNumElements() == (OpVT.getVectorNumElements()*2) &&
         "total source operand element count does not match result");

  if (OpVT.getVectorElementType().isInteger() &&
      OpVT.getVectorElementType() != MVT::i1) {
    EVT WideVT = OpVT.widenIntegerVectorElementType(*DAG.getContext());
    OpLHS = DAG.getNode(ISD::ANY_EXTEND, dl, WideVT, OpLHS);
    OpRHS = DAG.getNode(ISD::ANY_EXTEND, dl, WideVT, OpRHS);
  } else if (OpVT.getVectorElementType().isFloatingPoint()) {
    OpLHS = DAG.getNode(AArch64ISD::REINTERPRET_CAST, dl, VT, OpLHS);
    OpRHS = DAG.getNode(AArch64ISD::REINTERPRET_CAST, dl, VT, OpRHS);
  }

  // Are we extracting the hi half of a double legal width vector?
  if ((OpLHS->getOpcode() == ISD::SRL) && (OpRHS->getOpcode() == ISD::SRL) &&
      (OpLHS->getOperand(1) == OpRHS->getOperand(1))) {
    APInt ShiftAmount;
    if (DAG.isConstantIntSplat(OpLHS->getOperand(1), &ShiftAmount)) {
      if (ShiftAmount == VT.getVectorElementType().getSizeInBits())
        return DAG.getNode(AArch64ISD::UZP2, dl, VT, OpLHS->getOperand(0),
                           OpRHS->getOperand(0));
    }
  }

  return DAG.getNode(AArch64ISD::UZP1, dl, VT, OpLHS, OpRHS);
}

SDValue AArch64TargetLowering::LowerINSERT_SUBVECTOR(SDValue Op,
                                                     SelectionDAG &DAG) const {
  SDLoc DL(Op);
  EVT VT = Op.getValueType();
  EVT Op0VT = Op.getOperand(0).getValueType();
  EVT Op1VT = Op.getOperand(1).getValueType();

  if (!Op0VT.isScalableVector() || !Op0VT.isInteger())
    return SDValue();

  unsigned NumElts = Op1VT.getVectorNumElements();

  SDValue Vec0 = Op.getOperand(0);
  SDValue Vec1 = Op.getOperand(1);
  SDValue Idx  = Op.getOperand(2);

  // Idx needs to be a constant, either 0 or 1 for WA vectors for now.
  ConstantSDNode *CIdx = dyn_cast<ConstantSDNode>(Idx);
  if (!CIdx)
    return SDValue();

  unsigned IdxVal = CIdx->getZExtValue();

  // Ensure the subvector is half the size of the main vector.
  if (Op0VT.getVectorNumElements() != (Op1VT.getVectorNumElements() * 2))
    return SDValue();

  // Extend elements of smaller vector...
  EVT WideVT = Op1VT.widenIntegerVectorElementType(*(DAG.getContext()));
  SDValue ExtVec = DAG.getNode(ISD::ANY_EXTEND, DL, WideVT, Vec1);

  // Can only handle upper/lower half right now.
  if (IdxVal == 0) {
    SDValue HiVec0 = DAG.getNode(AArch64ISD::UUNPKHI, DL, WideVT, Vec0);
    return DAG.getNode(AArch64ISD::UZP1, DL, VT, ExtVec, HiVec0);
  } else if (IdxVal == NumElts) {
    SDValue LoVec0 = DAG.getNode(AArch64ISD::UUNPKLO, DL, WideVT, Vec0);
    return DAG.getNode(AArch64ISD::UZP1, DL, VT, LoVec0, ExtVec);
  }

  return SDValue();
}

SDValue AArch64TargetLowering::LowerTRUNCATE(SDValue Op,
                                             SelectionDAG &DAG) const {
  SDLoc dl(Op);

  EVT VT = Op.getValueType();
  if (!isTypeLegal(VT) || !VT.isScalableVector())
    return SDValue();

  if (Op.getOperand(0).getOpcode() == ISD::CONCAT_VECTORS) {
    SDValue CC = Op.getOperand(0);
    SDValue Lo = CC.getOperand(0);
    SDValue Hi = CC.getOperand(1);

    EVT CCVT = CC.getValueType();
    EVT LoVT = Lo.getValueType();

    if (CCVT.getVectorNumElements() == (LoVT.getVectorNumElements() * 2))
      return DAG.getNode(AArch64ISD::UZP1, dl, VT, Lo, Hi);
  }

  return SDValue();
}

SDValue AArch64TargetLowering::LowerDUPQLane(SDValue Op,
                                             SelectionDAG &DAG) const {
  SDLoc DL(Op);

  EVT VT = Op.getValueType();
  if (!isTypeLegal(VT) || !VT.isScalableVector())
    return SDValue();

  // Current lowering only supports the SVE-ACLE types.
  if (VT.getSizeInBits() != AArch64::SVEBitsPerBlock)
    return SDValue();

  // The DUPQ operation is indepedent of element type so normalise to i64s.
  auto V = DAG.getNode(ISD::BITCAST, DL, MVT::nxv2i64, Op.getOperand(1));
  auto Idx128 = Op.getOperand(2);

  // DUPQ can be used when idx is in range.
  auto CIdx = dyn_cast<ConstantSDNode>(Idx128);
  if (CIdx && (CIdx->getZExtValue() <= 3)) {
    auto CI = DAG.getTargetConstant(CIdx->getZExtValue(), DL, MVT::i64);
    auto DUPQ = DAG.getMachineNode(AArch64::DUP_ZZI_Q, DL, MVT::nxv2i64, V, CI);
    return DAG.getNode(ISD::BITCAST, DL, VT, SDValue(DUPQ, 0));
  }

  // The ACLE says this must produce the same result as:
  //   svtbl(data, svadd_x(svptrue_b64(),
  //                       svand_x(svptrue_b64(), svindex_u64(0, 1), 1),
  //                       index * 2))
  auto Zero = DAG.getConstant(0, DL, MVT::i64);
  auto One = DAG.getConstant(1, DL, MVT::i64);
  auto SplatOne = DAG.getNode(ISD::SPLAT_VECTOR, DL, MVT::nxv2i64, One);

  // create the vector 0,1,0,1,...
  auto SV = DAG.getNode(ISD::SERIES_VECTOR, DL, MVT::nxv2i64, Zero, One);
  SV = DAG.getNode(ISD::AND, DL, MVT::nxv2i64, SV, SplatOne);

  // create the vector idx64,idx64+1,idx64,idx64+1,...
  auto Idx64 = DAG.getNode(ISD::ADD, DL, MVT::i64, Idx128, Idx128);
  auto SplatIdx64 = DAG.getNode(ISD::SPLAT_VECTOR, DL, MVT::nxv2i64, Idx64);
  auto ShufffleMask = DAG.getNode(ISD::ADD, DL, MVT::nxv2i64, SV, SplatIdx64);

  // create the vector Val[idx64],Val[idx64+1],Val[idx64],Val[idx64+1],...
  auto TBL = DAG.getNode(AArch64ISD::TBL, DL, MVT::nxv2i64, V, ShufffleMask);
  return DAG.getNode(ISD::BITCAST, DL, VT, TBL);
}

SDValue AArch64TargetLowering::LowerVectorBITCAST(SDValue Op,
                                                  SelectionDAG &DAG) const {
  SDLoc DL(Op);
  EVT VT = Op.getValueType();
  auto Src = Op.getOperand(0);

  if (!VT.isScalableVector())
    return SDValue();

  if (isTypeLegal(VT) && !isTypeLegal(Src.getValueType())) {
    assert(VT.isFloatingPoint() && "Expected int->fp bitcast!");
    EVT ContainerVT = getNaturalIntSVETypeWithMatchingElementCount(VT);
    auto Tmp = DAG.getNode(ISD::ANY_EXTEND, DL, ContainerVT, Src);
    return DAG.getNode(AArch64ISD::REINTERPRET_CAST, DL, VT, Tmp);
  }

  return SDValue();
}

SDValue AArch64TargetLowering::LowerVSCALE(SDValue Op,
                                           SelectionDAG &DAG) const {
  SDLoc DL(Op);
  EVT VT = Op.getValueType();

  if (VT != MVT::i64) {
    int64_t MulImm = cast<ConstantSDNode>(Op.getOperand(0))->getSExtValue();
    return DAG.getZExtOrTrunc(DAG.getVScale(DL, MVT::i64, MulImm), DL, VT);
  }

  return SDValue();
}

// zip([a, b, c, d], [e, f, g, h]) =
//  = {[a, e, b, f], [c, g, d, h]}
//      ^^^^^^^^^^    ^^^^^^^^^^
//         zip lo        zip hi
static std::tuple<Value*,Value*> getZip(Value *A, Value *B,
                                        IRBuilder<> &Builder) {
  Intrinsic::ID zips[] = { Intrinsic::aarch64_sve_zip1,
                           Intrinsic::aarch64_sve_zip2 };
  Module *M = Builder.GetInsertPoint()->getModule();
  auto ZipLoIntr = Intrinsic::getDeclaration(M, zips[0], {A->getType()});
  auto ZipHiIntr = Intrinsic::getDeclaration(M, zips[1], {A->getType()});
  Value *Ops[] = {A, B};
  auto ZipLo = Builder.CreateCall(ZipLoIntr, Ops, "ZipLo");
  auto ZipHi = Builder.CreateCall(ZipHiIntr, Ops, "ZipHi");

  return std::make_tuple(ZipLo, ZipHi);
}

// Unzip([a, b, c, d], [e, f, g, h])
//    = {[a, c, e, g], [b, d, f, h]}
//        ^^^^^^^^^^    ^^^^^^^^^^
//          even            odd
static std::tuple<Value*,Value*> getUnzip(Value *A, Value *B,
                                          IRBuilder<> &Builder) {
  auto Zero = Builder.getInt32(0);
  auto One  = Builder.getInt32(1);
  auto Two  = Builder.getInt32(2);

  auto EC = cast<VectorType>(A->getType())->getElementCount();

  auto EvenIdx = Builder.CreateSeriesVector(EC, Zero, Two);
  auto OddIdx = Builder.CreateSeriesVector(EC, One, Two);

  auto UnzipEven = Builder.CreateShuffleVector(A, B, EvenIdx);
  auto UnzipOdd = Builder.CreateShuffleVector(A, B, OddIdx);

  return std::make_tuple(UnzipEven, UnzipOdd);
}

bool AArch64TargetLowering::lowerGathersToInterleavedLoad(
                                               ArrayRef<Value *> Gathers,
                                               IntrinsicInst *ReplaceNode,
                                               unsigned Factor,
                                               TargetTransformInfo *TTI) const {
  assert(Factor >= 2 && Factor <= getMaxSupportedInterleaveFactor() &&
         "Invalid interleave factor");
  assert(!Gathers.empty() && "Empty gather input");

  auto FirstGather = cast<IntrinsicInst>(Gathers[0]);
  const DataLayout &DL = FirstGather->getModule()->getDataLayout();

  VectorType *VecTy = dyn_cast<VectorType>(FirstGather->getType());
  if (!VecTy)
    return false;
  // Test if factor can be efficiently vectorised with LD(2|3|4)
  // instructions.
  switch (Factor){
  case 2:
  case 3:
  case 4:
  case 6:
  case 8:
    break;
  default:
    return false;
  }
  // This code assumes scalable types
  if (!Subtarget->hasSVE() || !VecTy->isScalable())
    return false;
  // We only support legal types for now
  if (!TTI->isTypeLegal(VecTy))
    return false;
  // We don't handle <n x 2 x float>.  SC-1277 will remove this
  // limitation
  if ((VecTy->getNumElements() == 2) && VecTy->getElementType()->isFloatTy())
    return false;

  // A pointer vector can not be the return type of the ldN intrinsics. Need to
  // load integer vectors first and then convert to pointer vectors.
  Type *EltTy = VecTy->getElementType();
  if (EltTy->isPointerTy())
    VecTy = VectorType::get(DL.getIntPtrType(EltTy), VecTy->getElementCount());

  Type *Tys = {VecTy};
  static const Intrinsic::ID LoadInts[3] = {Intrinsic::aarch64_sve_ld2,
                                            Intrinsic::aarch64_sve_ld3,
                                            Intrinsic::aarch64_sve_ld4};
  bool IsNativeStride = (Factor <= 4);
  auto FactorIdx = IsNativeStride ? Factor : Factor/2;

  Function *LdNFunc = Intrinsic::getDeclaration(FirstGather->getModule(),
                                                LoadInts[FactorIdx - 2], Tys);

  IRBuilder<> Builder(ReplaceNode);
  auto Addrs = FirstGather->getOperand(0);
  auto FirstAddr = Builder.CreateExtractElement(Addrs, Builder.getInt32(0));
  auto PtrType = VecTy->getPointerTo();
  auto Ptr = Builder.CreateBitCast(FirstAddr, PtrType);

  // Create loads
  CallInst *LdN, *LdN2;
  if (!IsNativeStride) {
    Value *Pred = FirstGather->getOperand(2);

    // Create zip for the predicates, e.g. (1,1,1,0)
    // -> (1,1,1,1),(1,1,0,0) for the two loads
    Value *ZipPredLo, *ZipPredHi;
    std::tie(ZipPredLo, ZipPredHi) = getZip(Pred, Pred, Builder);

    // Create first load
    Value *Ops[] = {ZipPredLo, Ptr};
    LdN = Builder.CreateCall(LdNFunc, Ops, "ldN");

    // Create second load
    auto Ptr2 = Builder.CreateGEP(Ptr, Builder.getInt64(Factor/2));
    Value *Ops2[] = {ZipPredHi, Ptr2};
    LdN2 = Builder.CreateCall(LdNFunc, Ops2, "ldN");
  } else {
    Value *Ops[] = {FirstGather->getOperand(2), Ptr};
    LdN = Builder.CreateCall(LdNFunc, Ops, "ldN");
  }

  // Replace uses of each shufflevector with the corresponding vector loaded
  // by ldN.
  for (unsigned i = 0; i < Gathers.size(); i++) {
    if (!IsNativeStride && i >= Factor/2)
      break;

    auto Gather1 = Gathers[i];
    auto Gather2 = IsNativeStride ? nullptr : Gathers[Factor/2+i];
    auto ActiveGather = Gather1 ? Gather1 : Gather2;
    if (!ActiveGather)
      continue;

    auto II = cast<IntrinsicInst>(ActiveGather);
    assert((II->getOperand(2) == FirstGather->getOperand(2)) &&
      "Expected gathers to have the same predicate arguments");

    Value *SubVec = Builder.CreateExtractValue(LdN, i);
    if (EltTy->isPointerTy())
      SubVec = Builder.CreateIntToPtr(SubVec, II->getType());
    SubVec = Builder.CreateBitCast(SubVec,ActiveGather->getType());

    if (IsNativeStride)
      ActiveGather->replaceAllUsesWith(SubVec);
    else {
      auto SubVec2 = Builder.CreateExtractValue(LdN2, i);
      if (EltTy->isPointerTy())
        SubVec2 = Builder.CreateIntToPtr(SubVec2, II->getType());
      SubVec2 = Builder.CreateBitCast(SubVec2,ActiveGather->getType());

      // Do an unzip
      Value *Even, *Odd;
      std::tie(Even, Odd) = getUnzip(SubVec, SubVec2, Builder);

      // Replace uses
      if (Gather1)
        Gather1->replaceAllUsesWith(Even);
      if (Gather2)
        Gather2->replaceAllUsesWith(Odd);
    }
  }

  return true;
}

bool AArch64TargetLowering::lowerScattersToInterleavedStore(
                                               ArrayRef<Value *> ValuesToStore,
                                               Value *FirstScatterAddress,
                                               IntrinsicInst *ReplaceNode,
                                               unsigned Factor,
                                               TargetTransformInfo *TTI) const {
  assert(Factor >= 2 && Factor <= getMaxSupportedInterleaveFactor() &&
         "Invalid interleave factor");

  const DataLayout &DL = ReplaceNode->getModule()->getDataLayout();

  VectorType *VecTy = dyn_cast<VectorType>(ValuesToStore[0]->getType());
  if (!VecTy)
    return false;
  // Test if factor can be efficiently vectorised with LD(2|3|4)
  // instructions.
  switch (Factor){
  case 2:
  case 3:
  case 4:
  case 6:
  case 8:
    break;
  default:
    return false;
  }
  // This code assumes scalable types
  if (!Subtarget->hasSVE() || !VecTy->isScalable())
    return false;
  // We only support legal types for now
  if (!TTI->isTypeLegal(VecTy))
    return false;
  // We don't handle <n x 2 x float>.  SC-1277 will remove this
  // limitation
  if ((VecTy->getNumElements() == 2) && VecTy->getElementType()->isFloatTy())
    return false;

  // StN intrinsics don't support pointer vectors as arguments. Convert pointer
  // vectors to integer vectors.
  Type *EltTy = VecTy->getElementType();
  if (EltTy->isPointerTy()) {
    Type *IntTy = DL.getIntPtrType(EltTy);
    VecTy = VectorType::get(IntTy, VecTy->getElementCount());
  }

  bool IsNativeStride = (Factor <= 4);

  SmallVector<SmallVector<Value*,2>, 6> Ops = { {}, {} };
  IRBuilder<> Builder(ReplaceNode);
  // Push the values to be stored, casting to int if necessary
  for (unsigned i = 0; i < Factor; ++i) {
    if (!IsNativeStride && i >= Factor/2)
        break;

    Value *StoreVal = ValuesToStore[i];
    if (EltTy->isPointerTy())
      StoreVal = Builder.CreatePtrToInt(StoreVal, VecTy);

    // Bitcast may be necessary if, for eg, the store values are a mix of
    // int and float types of the same size
    if (StoreVal->getType() != VecTy)
      StoreVal = Builder.CreateBitCast(StoreVal, VecTy);

    if (!IsNativeStride) {
      Value *StoreSecondVal = ValuesToStore[Factor/2+i];
      if (EltTy->isPointerTy())
        StoreSecondVal = Builder.CreatePtrToInt(StoreSecondVal, VecTy);

      // Create zips for vectors
      Value *ZipLoVec, *ZipHiVec;
      std::tie(ZipLoVec, ZipHiVec) = getZip(StoreVal, StoreSecondVal, Builder);

      Ops[0].push_back(ZipLoVec);
      Ops[1].push_back(ZipHiVec);
    } else
      Ops[0].push_back(StoreVal);
  }

  static const Intrinsic::ID StoreInts[3] = {Intrinsic::aarch64_sve_st2,
                                             Intrinsic::aarch64_sve_st3,
                                             Intrinsic::aarch64_sve_st4};

  auto FactorIdx = IsNativeStride ? Factor : Factor/2;
  Function *StNFunc = Intrinsic::getDeclaration(ReplaceNode->getModule(),
                                                StoreInts[FactorIdx - 2],
                                                {VecTy});

  // Calculate the base address (this extract will be folded later)
  auto FirstAddr = Builder.CreateExtractElement(FirstScatterAddress,
                                                Builder.getInt32(0));
  auto PtrType = VecTy->getPointerTo();
  auto Ptr = Builder.CreateBitCast(FirstAddr, PtrType);

  // Push the predicate arg (must be the same for all scatters)
  if (!IsNativeStride) {
    Value *Pred = ReplaceNode->getOperand(3);

    // Create zip for the predicates, e.g. (1,1,1,0)
    // -> (1,1,1,1),(1,1,0,0) for the two stores
    Value *ZipPredLo, *ZipPredHi;
    std::tie(ZipPredLo,ZipPredHi) = getZip(Pred, Pred, Builder);
    Ops[0].push_back(ZipPredLo);
    Ops[1].push_back(ZipPredHi);

    // Create first store
    Ops[0].push_back(Ptr);
    Builder.CreateCall(StNFunc, Ops[0]);

    // Create second store
    auto Ptr2 = Builder.CreateGEP(Ptr, Builder.getInt64(Factor/2));
    Ops[1].push_back(Ptr2);
    Builder.CreateCall(StNFunc, Ops[1]);
  } else {
    Ops[0].push_back(ReplaceNode->getOperand(3));
    Ops[0].push_back(Ptr);
    Builder.CreateCall(StNFunc, Ops[0]);
  }

  return true;
}

static SDValue tryCombineVecOrNot(SDNode *N,
                                  TargetLowering::DAGCombinerInfo &DCI) {
  SelectionDAG &DAG = DCI.DAG;
  SDLoc Dl(N);
  EVT VT = N->getValueType(0);

  assert(N->getOpcode() == ISD::OR && "Unexpected root");

  if (!VT.isVector() || VT.getVectorElementType() != MVT::i1)
    return SDValue();
  // Try to combine or (not a), a => ptrue.
  // Represented as: or (xor a, splat(true)), a
  auto LHS = N->getOperand(0);
  auto RHS = N->getOperand(1);

  if (LHS->getOpcode() != ISD::XOR)
    std::swap(LHS, RHS); // Try swapping operands.
  if (LHS->getOpcode() != ISD::XOR)
    return SDValue();

  auto Splat = LHS->getOperand(1);
  if (Splat->getOpcode() != ISD::SPLAT_VECTOR)
    return SDValue();
  if (LHS->getOperand(0) != RHS)
    return SDValue();
  auto SplatVal = dyn_cast<ConstantSDNode>(Splat->getOperand(0));
  if (SplatVal && (SplatVal->getZExtValue() == 1)) // &&
    return getPTrue(DAG, Dl, VT, AArch64SVEPredPattern::all);
  return SDValue();
}

/// Checks if a given node is a first faulting load.
static bool isLoadFF(const SDNode *N) {
  switch (N->getOpcode()) {
    case AArch64ISD::LDFF1:
    case AArch64ISD::LDFF1S:
      return true;
  }

  return false;
}

static bool isConstantSplatVectorMaskForType(SDNode *N, EVT MemVT) {
  if (!MemVT.getVectorElementType().isSimple())
  return false;

  uint64_t MaskForTy = 0ull;
  switch(MemVT.getVectorElementType().getSimpleVT().SimpleTy) {
  case MVT::i8:
    MaskForTy = 0xffull;
    break;
  case MVT::i16:
    MaskForTy = 0xffffull;
    break;
  case MVT::i32:
    MaskForTy = 0xffffffffull;
    break;
  default:
    return false;
    break;
  }

  if (N->getOpcode() == AArch64ISD::DUP ||
      N->getOpcode() == ISD::SPLAT_VECTOR)
    if (auto *Op0 = dyn_cast<ConstantSDNode>(N->getOperand(0)))
      return Op0->getAPIntValue().getLimitedValue() == MaskForTy;

  return false;
}

/// Checks whether the node \param S is the end node of a loadff chain that
/// starts with a SetFFR instruction. If so, it sets the value of \param SetFFR
/// with that setffr node. The parameter \param Pred is added to make sure that
/// changes in the lowering of llvm.load.ff that would allow the generation of
/// chains in the form (1) would not be recognised as valid and be converted
/// into teh chain in (2), which is clearly not equivalent to (1).
///
///     (1) S->ld(p1)->ld(p2)->R->S->ld(p2)->R
///     (2) S->ld(p1)->ld(p2)->ld(p2)->R
static bool chainIsValid(SDValue S, SDValue Pred, SDValue &SetFFR) {

  if (isLoadFF(S.getNode()) && S.getOperand(1) == Pred)
    return chainIsValid(S.getOperand(0), Pred, SetFFR);

  if (S.getOpcode() == AArch64ISD::SETFFR) {
    SetFFR = S;
    return true;
  }

  return false;
}


static SDValue performAndCombine(SDNode *N,
                                 TargetLowering::DAGCombinerInfo &DCI,
                                 const AArch64Subtarget *Subtarget) {
  SDLoc DL(N);
  SelectionDAG &DAG = DCI.DAG;
  assert(N->getOpcode() == ISD::AND && "Unexpected root");

  EVT VT = N->getValueType(0);
  if (VT.isVector()) {
    if (!DCI.isBeforeLegalizeOps() &&
        (N->getOperand(0)->getOpcode() == ISD::SERIES_VECTOR) &&
        (VT.getVectorElementType() == MVT::i64)) {

      // Try to remove pointless scalar extends of INDEX operands.
      //
      //   zext_inreg_w(index_d(sext(A), sext(B))
      //      ==> zext_inreg_w(index_d(aext(A), aext(B))

      auto Data = N->getOperand(0);
      auto Mask = N->getOperand(1);

      // NOTE: zext_inreg_w is modelled as AND A, 0xffffffff
      bool MaskIsZeroExtend = false;
      if (Mask->getOpcode() == ISD::SPLAT_VECTOR ||
          Mask->getOpcode() == AArch64ISD::DUP) {
        auto SplatVal = dyn_cast<ConstantSDNode>(Mask->getOperand(0));
        if (SplatVal && SplatVal->getZExtValue() == 0xfffffffful)
          MaskIsZeroExtend = true;
      }

      auto DStart = Data->getOperand(0);
      bool DStartExtended = (DStart.getOpcode() == ISD::SIGN_EXTEND) &&
                            (DStart.getOperand(0).getValueType() == MVT::i32);

      auto DStep = Data->getOperand(1);
      bool DStepExtended = (DStep.getOpcode() == ISD::SIGN_EXTEND) &&
                           (DStep.getOperand(0).getValueType() == MVT::i32);

      if (MaskIsZeroExtend && (DStartExtended || DStepExtended)) {
        if (DStartExtended)
          DStart = DAG.getNode(ISD::ANY_EXTEND, DL, MVT::i64,
                               DStart.getOperand(0));
        if (DStepExtended)
          DStep = DAG.getNode(ISD::ANY_EXTEND, DL, MVT::i64,
                              DStep.getOperand(0));

        SDValue SV = DAG.getNode(ISD::SERIES_VECTOR, DL, VT, DStart, DStep);
        return DAG.getNode(ISD::AND, DL, VT, SV, Mask);
      }
    }

    if (!DCI.isBeforeLegalizeOps()) {
      SDValue Data = N->getOperand(0);
      SDValue Mask = N->getOperand(1);
      unsigned Opc = Data->getOpcode();

      // This instruction performs an implicit zero-extend.
      if ((Opc == AArch64ISD::LDFF1) || (Opc == AArch64ISD::LDNF1)) {
        EVT MemVT = cast<VTSDNode>(Data->getOperand(3))->getVT();

        if (isConstantSplatVectorMaskForType(Mask.getNode(), MemVT))
          return Data;
      }

      // These instructions perform an implicit zero-extend.
      if ((Opc == AArch64ISD::GLDFF1) ||
          (Opc == AArch64ISD::GLDFF1_SCALED) ||
          (Opc == AArch64ISD::GLDFF1_SXTW) ||
          (Opc == AArch64ISD::GLDFF1_SXTW_SCALED) ||
          (Opc == AArch64ISD::GLDFF1_UXTW) ||
          (Opc == AArch64ISD::GLDFF1_UXTW_SCALED)) {
        EVT MemVT = cast<VTSDNode>(Data->getOperand(4))->getVT();

        if (isConstantSplatVectorMaskForType(Mask.getNode(), MemVT))
          return Data;
      }
    }

    // Check for AND of the FFR of two loadff that can be chained
    if (VT.isScalableVector()) {
      auto FFR_L = N->getOperand(0);
      if (FFR_L.getOpcode() != AArch64ISD::RDFFR_PRED)
        return SDValue();

      auto FFR_R = N->getOperand(1);
      if (FFR_R.getOpcode() != AArch64ISD::RDFFR_PRED)
        return SDValue();

      if (!FFR_L.hasOneUse() || !FFR_R.hasOneUse())
        return SDValue();

      SDValue LoadVal_L = FFR_L.getOperand(0);
      SDValue LoadVal_R = FFR_R.getOperand(0);
      auto Load_L = LoadVal_L.getNode();
      auto Load_R = LoadVal_R.getNode();
      // We can accept only LoadFF nodes,
      if (!isLoadFF(Load_L) || !isLoadFF(Load_R))
        return SDValue();

      // Check if the chains are valid chains made of a setffr followed by some
      // loadff (and nothing else).
      SDValue SetFFR_L, SetFFR_R;
      if (!chainIsValid(LoadVal_L.getOperand(0),
                        LoadVal_L.getOperand(1), SetFFR_L) ||
          !chainIsValid(LoadVal_R.getOperand(0),
                        LoadVal_R.getOperand(1), SetFFR_R))
        return SDValue();

      // Now that each of the RHS and LHS chain are valid, we have to make sure
      // that the SETFFR happen simultaneously, i.e. that they are parallel.
      if (SetFFR_L.getOperand(0) != SetFFR_R.getOperand(0))
        return SDValue();

      bool isLoad_L_SetFFR =
        Load_L->getOperand(0).getOpcode() == AArch64ISD::SETFFR;
      bool isLoad_R_SetFFR =
        Load_R->getOperand(0).getOpcode() == AArch64ISD::SETFFR;

      // At least one of the two nodes must be preceded by a setffr, because we
      // can chain only a single load and not a chain of loads.
      if (!isLoad_L_SetFFR && !isLoad_R_SetFFR)
        return SDValue();

      // Swap the nodes if the one marked as the Left one is not the
      // one with the SETFFR
      if (!isLoad_L_SetFFR) {
        std::swap(Load_L, Load_R);
        std::swap(FFR_L, FFR_R);
      }

      // Both loads must have the same predicate
      if (Load_L->getOperand(1) != Load_R->getOperand(1))
        return SDValue();

      //create the replacement of the left hand side load
      SDValue Chain = SDValue(Load_R, 1);
      SDValue LoadOps[] = { Chain, // Chain in after the RHS load
                            Load_L->getOperand(1),   // GP
                            Load_L->getOperand(2),   // Address
                            Load_L->getOperand(3) }; // MemVT
      SDVTList LoadVTs = DAG.getVTList(Load_L->getValueType(0), MVT::Other);
      SDValue Load = DAG.getNode(Load_L->getOpcode(), DL, LoadVTs, LoadOps);
      SDValue LoadChain = SDValue(Load.getNode(), 1);
      SDValue PredOps[] = { LoadChain, FFR_R->getOperand(1) }; // Chain in, GP
      SDVTList PredVTs = DAG.getVTList(FFR_R->getValueType(0), MVT::Other);
      SDValue FaultPred = DAG.getNode(AArch64ISD::RDFFR_PRED, DL, PredVTs,
                                      PredOps);

      // Replace the use of the original values of Load_L and of FFR_L
      // and FFR_R with the new ones created before, Load and
      // FaultPred
      DAG.ReplaceAllUsesOfValueWith(SDValue(Load_L, 0),
                                    SDValue(Load.getNode(), 0));
      DAG.ReplaceAllUsesOfValueWith(SDValue(Load_L, 1),
                                    SDValue(Load.getNode(), 1));
      DAG.ReplaceAllUsesOfValueWith(SDValue(FFR_L.getNode(), 1),
                                    SDValue(FaultPred.getNode(), 1));
      DAG.ReplaceAllUsesOfValueWith(SDValue(FFR_R.getNode(), 1),
                                    SDValue(FaultPred.getNode(), 1));

      return FaultPred;
    }

    return SDValue();
  }

  return SDValue();
}

static SDValue tryConvertSVEWideCompare(SDNode *N, unsigned ReplacementIID,
                                        bool Invert, SelectionDAG &DAG) {
  SDValue Comparator = N->getOperand(3);
  if (Comparator.getOpcode() == AArch64ISD::DUP ||
      Comparator.getOpcode() == ISD::SPLAT_VECTOR) {
    unsigned IID = getIntrinsicID(N);
    EVT VT = N->getValueType(0);
    EVT CmpVT = N->getOperand(2).getValueType();
    SDValue Pred = N->getOperand(1);
    SDLoc DL(N);

    switch (IID) {
    default:
      llvm_unreachable("Called with wrong intrinsic!");
      break;

    // Signed comparisons
    case Intrinsic::aarch64_sve_cmpeq_wide:
    case Intrinsic::aarch64_sve_cmpne_wide:
    case Intrinsic::aarch64_sve_cmpge_wide:
    case Intrinsic::aarch64_sve_cmpgt_wide:
    case Intrinsic::aarch64_sve_cmplt_wide:
    case Intrinsic::aarch64_sve_cmple_wide: {
      if (auto *CN = dyn_cast<ConstantSDNode>(Comparator.getOperand(0))) {
        int64_t ImmVal = CN->getSExtValue();

        if (ImmVal >= -16 && ImmVal <= 15) {
          SDValue Imm = DAG.getConstant(ImmVal, DL, MVT::i32);
          SDValue Splat = DAG.getNode(AArch64ISD::DUP, DL, CmpVT, Imm);
          SDValue ID = DAG.getTargetConstant(ReplacementIID, DL, MVT::i64);
          SDValue Op0, Op1;
          if (Invert) {
            Op0 = Splat;
            Op1 = N->getOperand(2);
          } else {
            Op0 = N->getOperand(2);
            Op1 = Splat;
          }
          return DAG.getNode(ISD::INTRINSIC_WO_CHAIN, DL, VT,
                             ID, Pred, Op0, Op1);
        }
      }
      break;
    }
    // Unsigned comparisons
    case Intrinsic::aarch64_sve_cmphs_wide:
    case Intrinsic::aarch64_sve_cmphi_wide:
    case Intrinsic::aarch64_sve_cmplo_wide:
    case Intrinsic::aarch64_sve_cmpls_wide:  {
      if (auto *CN = dyn_cast<ConstantSDNode>(Comparator.getOperand(0))) {
        uint64_t ImmVal = CN->getZExtValue();

        if (ImmVal <= 127) {
          SDValue Imm = DAG.getConstant(ImmVal, DL, MVT::i32);
          SDValue Splat = DAG.getNode(AArch64ISD::DUP, DL, CmpVT, Imm);
          SDValue ID = DAG.getTargetConstant(ReplacementIID, DL, MVT::i64);
          SDValue Op0, Op1;
          if (Invert) {
            Op0 = Splat;
            Op1 = N->getOperand(2);
          } else {
            Op0 = N->getOperand(2);
            Op1 = Splat;
          }
          return DAG.getNode(ISD::INTRINSIC_WO_CHAIN, DL, VT,
                             ID, Pred, Op0, Op1);
        }
      }
      break;
    }
    }
  }

  return SDValue();
}

static SDValue LowerSVEIntrinsicDUP(SDNode *N, SelectionDAG &DAG) {
  SDLoc dl(N);
  SDValue Scalar = N->getOperand(3);
  EVT ScalarTy = Scalar.getValueType();

  if ((ScalarTy == MVT::i8) || (ScalarTy == MVT::i16))
    Scalar = DAG.getNode(ISD::ANY_EXTEND, dl, MVT::i32, Scalar);

  return DAG.getNode(AArch64ISD::DUP_PRED, dl, N->getValueType(0),
                     N->getOperand(1), N->getOperand(2), Scalar);
}

static SDValue LowerSVEIntrinsicEXT(SDNode *N, SelectionDAG &DAG) {
  SDLoc dl(N);
  LLVMContext &Ctx = *DAG.getContext();
  EVT VT = N->getValueType(0);

  unsigned ElemSize = VT.getVectorElementType().getSizeInBits() / 8;
  EVT ByteVT = EVT::getVectorVT(Ctx, MVT::i8, { VT.getSizeInBits() / 8, true });

  // Convert everything to the domain of EXT (i.e bytes).
  SDValue Op0 = DAG.getNode(ISD::BITCAST, dl, ByteVT, N->getOperand(1));
  SDValue Op1 = DAG.getNode(ISD::BITCAST, dl, ByteVT, N->getOperand(2));
  SDValue Op2 = DAG.getNode(ISD::MUL, dl, MVT::i32, N->getOperand(3),
                            DAG.getConstant(ElemSize, dl, MVT::i32));

  SDValue EXT = DAG.getNode(AArch64ISD::EXT, dl, ByteVT, Op0, Op1, Op2);
  return DAG.getNode(ISD::BITCAST, dl, VT, EXT);
}

static SDValue LowerSVEIntrinsicPTEST(SDNode *N, AArch64CC::CondCode Cond,
                                      SelectionDAG &DAG) {
  SDLoc DL(N);
  SDValue Cmp = DAG.getNode(AArch64ISD::PTEST, DL, MVT::Other,
                            N->getOperand(1), N->getOperand(2));

  auto TVal = DAG.getConstant(1, DL, MVT::i32);
  auto FVal = DAG.getConstant(0, DL, MVT::i32);
  auto CC = DAG.getConstant(Cond, DL, MVT::i32);
  auto CSEL = DAG.getNode(AArch64ISD::CSEL, DL, MVT::i32, TVal, FVal, CC, Cmp);
  return DAG.getNode(ISD::TRUNCATE, DL, N->getValueType(0), CSEL);
}

static bool isSplatConstVector(SDValue Vec, unsigned Val) {
  if (Vec.getOpcode() != ISD::SPLAT_VECTOR)
    return false;
  ConstantSDNode *COp;
  if (!(COp = dyn_cast<ConstantSDNode>(Vec.getOperand(0))))
    return false;
  if (COp->getZExtValue() != Val)
    return false;
  return true;
}

static SDValue tryLowerPredTestReduction(SDNode *N, unsigned Opc,
                                           SelectionDAG &DAG) {
  SDLoc dl(N);
  SDValue Pred = N->getOperand(1);
  SDValue Data = N->getOperand(2);
  EVT DataVT = Data.getValueType();
  EVT EltVT = DataVT.getVectorElementType();

  if (DataVT.getVectorElementType() != MVT::i1)
    return SDValue();
  ISD::TestCode TC;
  if (Opc == AArch64ISD::ORV_PRED)
    TC = ISD::TEST_ANY_TRUE;
  else if (Opc == AArch64ISD::ANDV_PRED)
    TC = ISD::TEST_ALL_TRUE;
  else
    return SDValue();

  if (!isSplatConstVector(Pred, 1))
    return SDValue();

  // If the operand has been inverted, then we can do an ALL_FALSE test of the
  // un-inverted value.
  if (Opc == AArch64ISD::ANDV_PRED && Data.getOpcode() == ISD::XOR) {
    auto DataOp1 = Data.getOperand(0);
    auto DataOp2 = Data.getOperand(1);
    if (isSplatConstVector(DataOp1, 1)) {
      TC = ISD::TEST_ALL_FALSE;
      Data = DataOp2;
    } else if (isSplatConstVector(DataOp2, 1)) {
      TC = ISD::TEST_ALL_FALSE;
      Data = DataOp1;
    }
  }
  auto CC = DAG.getTestCode(TC);
  return DAG.getNode(ISD::TEST_VECTOR, dl, EltVT, Data, CC);
}

static SDValue LowerSVEIntReduction(SDNode *N, unsigned Opc,
                                    SelectionDAG &DAG) {
  SDLoc dl(N);
  LLVMContext &Ctx = *DAG.getContext();
  const TargetLowering &TLI = DAG.getTargetLoweringInfo();

  EVT VT = N->getValueType(0);
  SDValue IID = N->getOperand(0);
  SDValue Pred = N->getOperand(1);
  SDValue Data = N->getOperand(2);

  EVT DataVT = Data.getValueType();

  // Bitwise OR/AND reductions of i1s can be expressed using a TEST_VECTOR.
  if (SDValue Res = tryLowerPredTestReduction(N, Opc, DAG))
    return Res;

  // If we still have failed i1 reduction->test_vector, then promote the result
  // and operands for legalization to handle later.
  if (DataVT.getVectorElementType() == MVT::i1) {
    EVT NewDataVT =
        getNaturalIntSVETypeWithMatchingElementCount(DataVT);
    auto Extend = DAG.getNode(ISD::SIGN_EXTEND, dl, NewDataVT, Data);
    auto NewOp =
        DAG.getNode(N->getOpcode(), dl, NewDataVT.getVectorElementType(), IID,
                    Pred, Extend);
    return DAG.getNode(ISD::TRUNCATE, dl, VT, NewOp);
  }

  if (DataVT.getSizeInBits() < AArch64::SVEBitsPerBlock) {
    // The following does no real work but will allow instruction selection.

    // Promote the element type.
    EVT VT1 = getNaturalIntSVETypeWithMatchingElementCount(DataVT);
    Data = DAG.getNode(ISD::ANY_EXTEND, dl, VT1, Data);

    // Cast back to the original element type.
    EVT VT2 = getNaturalIntSVETypeWithMatchingElementType(DataVT);
    Data = DAG.getNode(ISD::BITCAST, dl, VT2, Data);

    // Cast predicate to match the original element type.
    EVT VT3 = getNaturalPredSVETypeWithMatchingElementType(DataVT);
    Pred = DAG.getNode(AArch64ISD::REINTERPRET_CAST, dl, VT3, Pred);

    DataVT = Data.getValueType();
  }

  if (!TLI.isTypeLegal(DataVT))
    return SDValue();

  EVT ReduceVT = EVT::getVectorVT(Ctx, VT, 128 / VT.getSizeInBits());
  SDValue Reduce = DAG.getNode(Opc, dl, ReduceVT, Pred, Data);

  SDValue Zero = DAG.getConstant(0, dl, MVT::i64);
  return DAG.getNode(ISD::EXTRACT_VECTOR_ELT, dl, VT, Reduce, Zero);
}

static SDValue performExtendInRegCombine(SDNode *N,
                                         TargetLowering::DAGCombinerInfo &DCI,
                                         SelectionDAG &DAG) {
  if (DCI.isBeforeLegalizeOps())
    return SDValue();

  SDLoc DL(N);
  EVT VT = N->getValueType(0);
  SDValue N0 = N->getOperand(0);
  SDValue N1 = N->getOperand(1);
  unsigned Opc = N0->getOpcode();

  if ((Opc == AArch64ISD::LDFF1) || (Opc == AArch64ISD::LDNF1)) {
    EVT SrcVT = cast<VTSDNode>(N1)->getVT();
    EVT MemVT = cast<VTSDNode>(N0->getOperand(3))->getVT();

    if ((SrcVT == MemVT) && N0.hasOneUse()) {
      SDVTList VTs = DAG.getVTList(VT, MVT::Other);
      SDValue Ops[] = { N0->getOperand(0),
                        N0->getOperand(1),
                        N0->getOperand(2),
                        N0->getOperand(3) };

      unsigned SignedOpc = (Opc == AArch64ISD::LDFF1) ? AArch64ISD::LDFF1S
                                                      : AArch64ISD::LDNF1S;
      SDValue ExtLoad = DAG.getNode(SignedOpc, DL, VTs, Ops);
      DCI.CombineTo(N, ExtLoad);
      DCI.CombineTo(N0.getNode(), ExtLoad, ExtLoad.getValue(1));
      return SDValue(N, 0); // Return N so it doesn't get rechecked!
    }
  }

  if ((Opc == AArch64ISD::GLDFF1) ||
      (Opc == AArch64ISD::GLDFF1_SCALED) ||
      (Opc == AArch64ISD::GLDFF1_SXTW) ||
      (Opc == AArch64ISD::GLDFF1_SXTW_SCALED) ||
      (Opc == AArch64ISD::GLDFF1_UXTW) ||
      (Opc == AArch64ISD::GLDFF1_UXTW_SCALED)) {
    EVT SrcVT = cast<VTSDNode>(N1)->getVT();
    EVT MemVT = cast<VTSDNode>(N0->getOperand(4))->getVT();

    if ((SrcVT == MemVT) && N0.hasOneUse()) {
      SDVTList VTs = DAG.getVTList(VT, MVT::Other);
      SDValue Ops[] = { N0->getOperand(0),
                        N0->getOperand(1),
                        N0->getOperand(2),
                        N0->getOperand(3),
                        N0->getOperand(4) };

      unsigned Opc;
      switch (N0->getOpcode()) {
      case AArch64ISD::GLDFF1:
        Opc = AArch64ISD::GLDFF1S;
        break;
      case AArch64ISD::GLDFF1_SCALED:
        Opc = AArch64ISD::GLDFF1S_SCALED;
        break;
      case AArch64ISD::GLDFF1_SXTW:
        Opc = AArch64ISD::GLDFF1S_SXTW;
        break;
      case AArch64ISD::GLDFF1_SXTW_SCALED:
        Opc = AArch64ISD::GLDFF1S_SXTW_SCALED;
        break;
      case AArch64ISD::GLDFF1_UXTW:
        Opc = AArch64ISD::GLDFF1S_UXTW;
        break;
      case AArch64ISD::GLDFF1_UXTW_SCALED:
        Opc = AArch64ISD::GLDFF1S_UXTW_SCALED;
        break;
      }

      SDValue ExtLoad = DAG.getNode(Opc, DL, VTs, Ops);
      DCI.CombineTo(N, ExtLoad);
      DCI.CombineTo(N0.getNode(), ExtLoad, ExtLoad.getValue(1));
      return SDValue(N, 0); // Return N so it doesn't get rechecked!
    }
  }

  return SDValue();
}

static SDValue performTRUNCATECombine(SDNode *N,
                                      TargetLowering::DAGCombinerInfo &DCI,
                                      SelectionDAG &DAG) {
  if (DCI.isBeforeLegalizeOps())
    return SDValue();

  EVT VT = N->getValueType(0);
  SDValue N0 = N->getOperand(0);

  // Vector shuffles of predicates are first expanded into data registers where
  // TBL can be used to perform the shuffle.  Sometimes a TBL is not required,
  // with a dedicated instruction (REV for example) used instead. Here we check
  // for a predicate equivalent thus removing the need to use data registers.
  if (VT.isScalableVector() && (VT.getVectorElementType() == MVT::i1)) {
    unsigned Opc = N0->getOpcode();

    if ((Opc == AArch64ISD::REV) ||
        (Opc == AArch64ISD::UZP1) ||
        (Opc == AArch64ISD::UZP2)) {
      SmallVector<SDValue, 4> Ops;

      // Check all operands are predicate extensions.
      for (const SDValue &Ext : N0->ops()) {
        unsigned ExtOpc = Ext.getOpcode();
        if (((ExtOpc == ISD::ANY_EXTEND) ||
             (ExtOpc == ISD::SIGN_EXTEND) ||
             (ExtOpc == ISD::ZERO_EXTEND)) &&
            (Ext.getOperand(0).getValueType() == VT))
          Ops.push_back(Ext.getOperand(0));
      }

      if (Ops.size() == N0->getNumOperands())
        return DAG.getNode(Opc, SDLoc(N), VT, Ops);
    }
  }

  return SDValue();
}

static SDValue performLD1RQCombine(SDNode *N, SelectionDAG &DAG) {
  SDLoc DL(N);
  EVT VT = N->getValueType(0);

  EVT LoadVT = VT;
  if (VT.isFloatingPoint())
    LoadVT = VT.changeTypeToInteger();

  SDValue Ops[] = { N->getOperand(0), N->getOperand(2), N->getOperand(3) };
  SDValue L = DAG.getNode(AArch64ISD::LD1RQ, DL, { LoadVT, MVT::Other }, Ops);

  if (VT.isFloatingPoint()) {
    SDValue Ops[] = { DAG.getNode(ISD::BITCAST, DL, VT, L), L.getValue(1) };
    return DAG.getMergeValues(Ops, DL);
  }

  return L;
}

static SDValue performLDNT1Combine(SDNode *N, SelectionDAG &DAG) {
  SDLoc DL(N);
  EVT VT = N->getValueType(0);

  EVT LoadVT = VT;
  if (VT.isFloatingPoint())
    LoadVT = VT.changeTypeToInteger();

  // NOTE: It's important we match ISD::MLOAD's operand order.
  SDValue Ops[] = { N->getOperand(0), N->getOperand(3), N->getOperand(2),
                    DAG.getUNDEF(LoadVT) };
  SDValue L = DAG.getNode(AArch64ISD::LDNT1, DL, { LoadVT, MVT::Other }, Ops);

  if (VT.isFloatingPoint()) {
    SDValue Ops[] = { DAG.getNode(ISD::BITCAST, DL, VT, L), L.getValue(1) };
    return DAG.getMergeValues(Ops, DL);
  }

  return L;
}

static SDValue performSTNT1Combine(SDNode *N, SelectionDAG &DAG) {
  SDLoc DL(N);

  SDValue Data = N->getOperand(2);
  EVT DataVT = Data.getValueType();

  if (DataVT.isFloatingPoint())
    Data = DAG.getNode(ISD::BITCAST, DL, DataVT.changeTypeToInteger(), Data);

  // NOTE: It's important we match ISD::MSTORE's operand order.
  SDValue Ops[] = { N->getOperand(0), N->getOperand(4), N->getOperand(3),
                    Data };
  return DAG.getNode(AArch64ISD::STNT1, DL, N->getValueType(0), Ops);
}

static SDValue performLDFF1Combine(SDNode *N, SelectionDAG &DAG, bool isNF) {
  SDLoc DL(N);
  EVT VT = N->getValueType(0);

  if (VT.getSizeInBits() > AArch64::SVEBitsPerBlock)
    return SDValue();

  EVT ContainerVT = VT;
  if (ContainerVT.isInteger()) {
    switch (VT.getVectorNumElements()) {
    default: return SDValue();
    case 16: ContainerVT = MVT::nxv16i8; break;
    case  8: ContainerVT = MVT::nxv8i16; break;
    case  4: ContainerVT = MVT::nxv4i32; break;
    case  2: ContainerVT = MVT::nxv2i64; break;
    }
  }

  SDVTList VTs = DAG.getVTList(ContainerVT, MVT::Other);
  SDValue Ops[] = { N->getOperand(0), // Chain
                    N->getOperand(2), // Pg
                    N->getOperand(3), // Base
                    DAG.getValueType(VT) };

  unsigned Opc = isNF ? AArch64ISD::LDNF1 : AArch64ISD::LDFF1;
  SDValue Load = DAG.getNode(Opc, DL, VTs, Ops);
  SDValue LoadChain = SDValue(Load.getNode(), 1);

  if (ContainerVT.isInteger() && (VT != ContainerVT))
    Load = DAG.getNode(ISD::TRUNCATE, DL, VT, Load.getValue(0));

  return DAG.getMergeValues({ Load, LoadChain }, DL);
}

static SDValue performLDFF1GatherCombine(SDNode *N, SelectionDAG &DAG) {
  SDLoc DL(N);
  EVT VT = N->getValueType(0);
  if (VT.getSizeInBits() > AArch64::SVEBitsPerBlock)
    return SDValue();

  const SDValue Base = N->getOperand(3);
  const SDValue Offsets = N->getOperand(4);
  unsigned EltBits = VT.getVectorElementType().getSizeInBits();

  // These are to be changed based on available addressing modes.
  unsigned Opcode = AArch64ISD::GLDFF1;
  SDValue Scalar = Base;
  SDValue Vector = Offsets; // 64bit Offsets
  APInt ShiftAmount;

  // Is a better addressing mode available?
  if (Offsets.getValueType() == MVT::nxv4i64) {
    if (Offsets.getOpcode() == ISD::SIGN_EXTEND) {
      Opcode = AArch64ISD::GLDFF1_SXTW;
      Vector = Offsets.getOperand(0); // Signed 32bit Offsets
    } else if (Offsets.getOpcode() == ISD::ZERO_EXTEND) {
      Opcode = AArch64ISD::GLDFF1_UXTW;
      Vector = Offsets.getOperand(0); // Unsigned 32bit Offsets
    } else if ((Offsets.getOpcode() == ISD::SHL) &&
               DAG.isConstantIntSplat(Offsets.getOperand(1), &ShiftAmount) &&
               ((8u << ShiftAmount.getZExtValue()) == EltBits)) {
      if (Offsets.getOperand(0).getOpcode() == ISD::SIGN_EXTEND) {
        Opcode = AArch64ISD::GLDFF1_SXTW_SCALED;
        Vector = Offsets.getOperand(0).getOperand(0); // Signed 32bit Indices
      } else if (Offsets.getOperand(0).getOpcode() == ISD::ZERO_EXTEND) {
        Opcode = AArch64ISD::GLDFF1_UXTW_SCALED;
        Vector = Offsets.getOperand(0).getOperand(0); // Unsigned 32bit Indices
      }
    }

    // We must reapply extensions for offsets that are now smaller than i32.
    if (Vector.getValueType() != MVT::nxv4i32) {
      switch (Opcode) {
      default:
        break;
      case AArch64ISD::GLDFF1_SXTW:
      case AArch64ISD::GLDFF1_SXTW_SCALED:
        Vector = DAG.getNode(ISD::SIGN_EXTEND, DL, MVT::nxv4i32, Vector);
        break;
      case AArch64ISD::GLDFF1_UXTW:
      case AArch64ISD::GLDFF1_UXTW_SCALED:
        Vector = DAG.getNode(ISD::ZERO_EXTEND, DL, MVT::nxv4i32, Vector);
        break;
      }
    }
  } else if (Offsets.getValueType() == MVT::nxv2i64) {
    if ((Offsets.getOpcode() == ISD::SHL) &&
        DAG.isConstantIntSplat(Offsets.getOperand(1), &ShiftAmount) &&
        ((8u << ShiftAmount.getZExtValue()) == EltBits)) {
      Opcode = AArch64ISD::GLDFF1_SCALED;
      Vector = Offsets.getOperand(0); // 64bit Indices
    }
  }

  if (!DAG.getTargetLoweringInfo().isTypeLegal(Scalar.getValueType()) ||
      !DAG.getTargetLoweringInfo().isTypeLegal(Vector.getValueType()))
    return SDValue();

  EVT ContainerVT = VT;
  if (ContainerVT.isInteger()) {
    switch (VT.getVectorNumElements()) {
    default: return SDValue();
    case 16: ContainerVT = MVT::nxv16i8; break;
    case  8: ContainerVT = MVT::nxv8i16; break;
    case  4: ContainerVT = MVT::nxv4i32; break;
    case  2: ContainerVT = MVT::nxv2i64; break;
    }
  }

  SDVTList VTs = DAG.getVTList(ContainerVT, MVT::Other);
  SDValue Ops[] = { N->getOperand(0), // Chain
                    N->getOperand(2), // Pg
                    Scalar,
                    Vector,
                    DAG.getValueType(VT) };

  SDValue Load = DAG.getNode(Opcode, DL, VTs, Ops);
  SDValue LoadChain = SDValue(Load.getNode(), 1);

  if (ContainerVT.isInteger() && (VT != ContainerVT))
    Load = DAG.getNode(ISD::TRUNCATE, DL, VT, Load.getValue(0));

  return DAG.getMergeValues({ Load, LoadChain }, DL);
}

static SDValue performPrefetchGatherCombine(SDNode *N, SelectionDAG &DAG,
                                            EVT VT) {
  assert(VT.getSizeInBits() == AArch64::SVEBitsPerBlock && "Unexpected VT");
  SDLoc DL(N);

  const SDValue Base = N->getOperand(3);
  const SDValue Offsets = N->getOperand(4);
  const SDValue PrfOp = N->getOperand(5);
  const EVT VectorTy = Offsets.getValueType();

  // These are to be changed based on available addressing modes.
  unsigned Opcode = 0;
  SDValue Scalar = Base;
  SDValue Vector = Offsets;
  EVT EltTy = VT.getVectorElementType();
  const unsigned EltBits = EltTy.getSizeInBits();

  // Is there a constant base that would fit in the ZI form? (0-31, scaled by
  // number of bytes)
  SDValue SmallConstantBase = SDValue();
  if (auto *CBaseSDNode = dyn_cast<ConstantSDNode>(Base)) {
    int64_t CBaseOffset = CBaseSDNode->getSExtValue();
    int64_t EltBytes = EltBits / 8;
    int64_t Index = CBaseOffset / EltBytes;
    int64_t Rem = CBaseOffset % EltBytes;
    if ((Rem == 0) && (Index >= 0) && (Index < 32))
      SmallConstantBase = Base;
  }

  // Is this a scaled vector of indices?
  SDValue ScaledVector = SDValue();
  APInt ShiftAmount;
  if ((Offsets.getOpcode() == ISD::SHL) &&
      DAG.isConstantIntSplat(Offsets.getOperand(1), &ShiftAmount) &&
      ((8u << ShiftAmount.getZExtValue()) == EltBits))
    ScaledVector = Offsets.getOperand(0);
  else if (EltBits == 8)
    // Scaled and unscaled are identical for byte addressing
    ScaledVector = Offsets;

  if (ScaledVector) {
    if (VectorTy == MVT::nxv4i64) {
      if (ScaledVector.getOpcode() == ISD::SIGN_EXTEND) {
        // Scaled 32-bit signed offsets
        Opcode = AArch64ISD::GPRF_S_SXTW_SCALED;
        Vector = ScaledVector.getOperand(0);
      } else if (ScaledVector.getOpcode() == ISD::ZERO_EXTEND) {
        Vector = ScaledVector.getOperand(0);
        if ((EltBits == 8) && SmallConstantBase) {
          // We can use the unscaled ZI form for byte addresses
          Opcode = AArch64ISD::GPRF_S_IMM;
          Scalar = SmallConstantBase;
        } else {
          // Scaled 32-bit unsigned offsets
          Opcode = AArch64ISD::GPRF_S_UXTW_SCALED;
        }
      }
    } else { // VectorTy == MVT::nxv2i64
      if ((ScaledVector.getOpcode() == ISD::SIGN_EXTEND) &&
          (ScaledVector.getOperand(0).getOpcode() == ISD::TRUNCATE)) {
        // scaled unpacked 32-bit signed offsets
        Opcode = AArch64ISD::GPRF_D_SXTW_SCALED;
        Vector = ScaledVector.getOperand(0).getOperand(0);
      } else if ((ScaledVector.getOpcode() == ISD::ZERO_EXTEND) &&
                 (ScaledVector.getOperand(0).getOpcode() == ISD::TRUNCATE)) {
        // scaled unpacked 32-bit unsigned offsets
        Opcode = AArch64ISD::GPRF_D_UXTW_SCALED;
        Vector = ScaledVector.getOperand(0).getOperand(0);
      } else if ((EltBits == 8) && SmallConstantBase) {
        // We can use the unscaled ZI form for byte addresses
        Opcode = AArch64ISD::GPRF_D_IMM;
        Scalar = SmallConstantBase;
      } else {
        // scaled 64-bit offsets
        Opcode = AArch64ISD::GPRF_D_SCALED;
        Vector = ScaledVector;
      }
    }
  } else { // Unscaled vector
    if ((VectorTy == MVT::nxv4i64) &&
        (Offsets.getOpcode() == ISD::ZERO_EXTEND)) {
      if (SmallConstantBase) {
        // Unscaled unsigned 32-bit bases with in-range constant index
        Opcode = AArch64ISD::GPRF_S_IMM;
        Vector = Offsets.getOperand(0);
        Scalar = SmallConstantBase;
      } else {
        // Unscaled 32-bit bases plus out of range (or non-constant) index.
        // Only byte prefetches (prfb) supports this addressing mode.  The SVE
        // architecture team feel, if a user requests such a prefetch, it is
        // better to use prfb, regardless of the requested element size, rather
        // than legalising and generating two prefetches
        Opcode = AArch64ISD::GPRF_S_UXTW_SCALED;
        Vector = Offsets.getOperand(0);
        EltTy = MVT::i8;
      }
    } else { // VectorTy == MVT::nxv2i64
      if (SmallConstantBase) {
        // Unscaled 64-bit bases with in-range constant index
        Opcode = AArch64ISD::GPRF_D_IMM;
        Scalar = SmallConstantBase;
      } else {
        // splat the base onto the vector
        auto Splat = DAG.getNode(ISD::SPLAT_VECTOR, DL, VectorTy, Base);
        Vector = DAG.getNode(ISD::ADD, DL, VectorTy, {Vector, Splat});
        Scalar = DAG.getConstant(0, DL, MVT::i64);
        Opcode = AArch64ISD::GPRF_D_IMM;
      }
    }
  }

  if ((Opcode == 0) ||
      !DAG.getTargetLoweringInfo().isTypeLegal(Scalar.getValueType()) ||
      !DAG.getTargetLoweringInfo().isTypeLegal(Vector.getValueType()))
    return SDValue();

  SDVTList VTs = DAG.getVTList(MVT::Other);
  SDValue Ops[] = { N->getOperand(0), // Chain
                    N->getOperand(2), // Pg
                    Scalar,
                    Vector,
                    PrfOp,
                    DAG.getValueType(EltTy) };

  return DAG.getNode(Opcode, DL, VTs, Ops);
}

// Analyse the specified address returning true if a change of IndexType will
// yield something that's more efficient to legalise.  When returning true all
// parameters are updated to reflect their recommended values.
static bool FindMoreOptimalIndexType(SDValue &BasePtr, SDValue &Index,
                                     ISD::MemIndexType &IndexType) {
  if (IndexType != ISD::SIGNED_SCALED)
    return false;

  // This is the only illegal type we can do much with. Smaller types can be
  // easily promoted and bigger types will require splitting regardless.
  if (Index.getValueType() != MVT::nxv4i64)
    return false;

  // If we're starting with a vector_of_pointers.
  if (isNullConstant(BasePtr) && Index.getOpcode() == ISD::ADD) {
    SDValue Base = Index.getOperand(0);
    SDValue Offset = Index.getOperand(1);

    if (Base.getOpcode() != ISD::SPLAT_VECTOR)
      std::swap(Base, Offset);

    if (Base.getOpcode() != ISD::SPLAT_VECTOR)
      return false;

    if (Offset.getOpcode() == ISD::SIGN_EXTEND)
      IndexType = ISD::SIGNED_UNSCALED;
    else if (Offset.getOpcode() == ISD::ZERO_EXTEND)
      IndexType = ISD::UNSIGNED_UNSCALED;

    // Only recommend actual changes of addressing mode.
    if (IndexType == ISD::SIGNED_SCALED)
      return false;

    BasePtr = Base.getOperand(0);
    Index = Offset.getOperand(0);
    return true;
  }

  // If we're starting with a base plus vector_of_unsigned_indices.
  if (!isNullConstant(BasePtr) &&
           (Index.getOpcode() == ISD::ZERO_EXTEND) &&
           (Index.getOperand(0).getValueType() == MVT::nxv4i32)) {
    IndexType = ISD::UNSIGNED_SCALED;
    Index = Index.getOperand(0);
    return true;
  }

  return false;
}

static SDValue performMGATHERCombine(MaskedGatherSDNode *N,
                                     TargetLowering::DAGCombinerInfo &DCI) {
  SDLoc DL(N);
  SelectionDAG &DAG = DCI.DAG;

  SDValue Index = N->getIndex();
  SDValue Chain = N->getChain();
  SDValue PassThrough = N->getSrc0();
  SDValue Mask = N->getMask();
  SDValue BasePtr = N->getBasePtr();

  EVT VT = N->getValueType(0);
  EVT IVT = Index.getValueType();
  EVT PVT = Mask.getValueType();
  EVT BVT = BasePtr.getValueType();
  EVT IEltVT = IVT.getVectorElementType();
  EVT MemVT = N->getMemoryVT();
  ISD::MemIndexType IndexType = N->getIndexType();

  if (DCI.isBeforeLegalize()) {
    // SVE gather/scatter requires indices of i32/i64. Promote anything smaller
    // prior to legalisation so the result can be split if required.
    if ((IVT.getVectorElementType() == MVT::i8) ||
        (IVT.getVectorElementType() == MVT::i16)) {
      EVT NewIVT = IVT.changeVectorElementType(MVT::i32);
      if (N->isIndexSigned())
        Index = DAG.getNode(ISD::SIGN_EXTEND, DL, NewIVT, Index);
      else
        Index = DAG.getNode(ISD::ZERO_EXTEND, DL, NewIVT, Index);

      SDValue Ops[] = { Chain, PassThrough, Mask, BasePtr, Index };
      return DAG.getMaskedGather(DAG.getVTList(VT, MVT::Other),
                                 N->getMemoryVT(), DL, Ops,
                                 N->getMemOperand(), N->getExtensionType(),
                                 N->getIndexType());
    }

    // Some uses of MGATHER naturally lead to illegal types. For example,
    // unsigned indicies are typically zero extended because MGATHER's
    // default IndexType is SIGNED_SCALED. Unsigned offsets within nxv4i32
    // become signed offsets within nxv4i64. The latter is illegal and triggers
    // splitvec style legalisation that's very difficult to undo.
    //
    // Here we catch such cases early and change MGATHER's IndexType to allow
    // the use of an Index that's more legalisation friendly.
    if (FindMoreOptimalIndexType(BasePtr, Index, IndexType)) {
      SDValue Ops[] = { Chain, PassThrough, Mask, BasePtr, Index };
      return DAG.getMaskedGather(DAG.getVTList(VT, MVT::Other),
                                 N->getMemoryVT(), DL, Ops, N->getMemOperand(),
                                 N->getExtensionType(), IndexType);
    }
  } else if (EnableSGToContiguousXForm) {
    // After everything has been legalized, we want to recognize gathers with
    // a constant stride of two and convert to two contiguous loads with
    // shuffles and masking. This hurts a little bit on 128b, but is quite
    // beneficial for greater register widths.
    //
    // We don't currently consider strides greater than two because that
    // wouldn't fit nicely in 128b. A stride of four could work with 32b
    // element types, but that should only be implemented if found to be
    // common enough to warrant it.
    //
    // TODO: If we try this on a vector legalized from a wider type, things
    // seem to go wrong; not sure why this is yet. For now, we bail out by
    // checking whether the mask was extracted (SC-1425).
    if (Index->getOpcode() == ISD::SERIES_VECTOR &&
        isa<ConstantSDNode>(Index->getOperand(1)) &&
        PassThrough.isUndef() &&
        Mask->getOpcode() != ISD::EXTRACT_SUBVECTOR &&
        IndexType == ISD::SIGNED_SCALED) {
      auto Step = cast<ConstantSDNode>(Index->getOperand(1))->getSExtValue();
      if (Step == 2) {
        unsigned ShiftAmt;

        switch(MemVT.getSimpleVT().SimpleTy) {
        case MVT::nxv2i64:
        case MVT::nxv2f64:
          ShiftAmt = 3;
          break;
        case MVT::nxv4i32:
        case MVT::nxv4f32:
          ShiftAmt = 2;
          break;
        default:
          return SDValue();
        }

        bool ExtendIdx;
        switch (IEltVT.getSimpleVT().SimpleTy) {
        case MVT::i64:
          ExtendIdx = false;
          break;
        case MVT::i32:
          ExtendIdx = true;
          break;
        default:
          return SDValue();
        }

        // Get the first index value.
        auto IdxVal = Index->getOperand(0);

        // If the indices are 32b, we need to extend to 64b.
        if (ExtendIdx)
          IdxVal = DAG.getNode(ISD::SIGN_EXTEND, DL, MVT::i64, IdxVal);

        // Split the mask into two parts and interleave with false
        auto PFalse = SDValue(DAG.getMachineNode(AArch64::PFALSE, DL, PVT), 0);
        auto PredL = DAG.getNode(AArch64ISD::ZIP1, DL, PVT, Mask, PFalse);
        auto PredH = DAG.getNode(AArch64ISD::ZIP2, DL, PVT, Mask, PFalse);

        // Figure out the offsets needed for the two loads -- scale the
        // first index up based on element size, then scale up a count of
        // the number of elements in the vector.
        auto EltCount = DAG.getVScale(DL, MVT::i64,
                                      VT.getVectorNumElements() << ShiftAmt);
        IdxVal = DAG.getNode(ISD::SHL, DL, BVT, IdxVal,
                             DAG.getConstant(ShiftAmt, DL, MVT::i64));

        // Perform the actual loads, making sure we use the chain value
        // from the first in the second.
        BasePtr = DAG.getNode(ISD::ADD, DL, BVT, BasePtr, IdxVal);
        auto LoadL = DAG.getMaskedLoad(VT, DL, Chain, BasePtr, PredL,
                                       PassThrough, MemVT,
                                       N->getMemOperand(),
                                       N->getExtensionType());

        BasePtr = DAG.getNode(ISD::ADD, DL, BVT, BasePtr, EltCount);
        auto LoadH = DAG.getMaskedLoad(VT, DL, LoadL.getValue(1), BasePtr,
                                       PredH, PassThrough, MemVT,
                                       N->getMemOperand(),
                                       N->getExtensionType());

        // Combine the loaded lanes into the single vector we'd get from
        // the original gather.
        auto Res = DAG.getNode(AArch64ISD::UZP1, DL, VT,
                               LoadL.getValue(0), LoadH.getValue(0));

        // Make sure we return both the loaded values and the chain from the
        // last load.
        return DAG.getMergeValues({ Res, LoadH.getValue(1) }, DL);
      }
    }
  }

  return SDValue();
}

static SDValue performMSCATTERCombine(MaskedScatterSDNode *N,
                                      TargetLowering::DAGCombinerInfo &DCI) {
  SDLoc DL(N);
  SelectionDAG &DAG = DCI.DAG;

  SDValue Index = N->getIndex();
  SDValue Chain = N->getChain();
  SDValue Data = N->getValue();
  SDValue Mask = N->getMask();
  SDValue BasePtr = N->getBasePtr();

  EVT VT  = Data.getValueType();
  EVT IVT = Index.getValueType();
  EVT PVT = Mask.getValueType();
  EVT BVT = BasePtr.getValueType();
  EVT IEltVT = IVT.getVectorElementType();
  EVT MemVT = N->getMemoryVT();
  ISD::MemIndexType IndexType = N->getIndexType();

  if (DCI.isBeforeLegalize()) {
    // SVE gather/scatter requires indices of i32/i64. Promote anything smaller
    // prior to legalisation so the result can be split if required.
    if ((IVT.getVectorElementType() == MVT::i8) ||
        (IVT.getVectorElementType() == MVT::i16)) {
      EVT NewIVT = IVT.changeVectorElementType(MVT::i32);
      if (N->isIndexSigned())
        Index = DAG.getNode(ISD::SIGN_EXTEND, DL, NewIVT, Index);
      else
        Index = DAG.getNode(ISD::ZERO_EXTEND, DL, NewIVT, Index);

      SDValue Ops[] = { Chain, Data, Mask, BasePtr, Index };
      return DAG.getMaskedScatter(DAG.getVTList(MVT::Other),
                                  N->getMemoryVT(), DL, Ops,
                                  N->getMemOperand(), N->isTruncatingStore(),
                                  N->getIndexType());
    }

    // Some uses of MSCATTER naturally lead to illegal types. For example,
    // unsigned indicies are typically zero extended because MSCATTER's
    // default IndexType is SIGNED_SCALED. Unsigned offsets within nxv4i32
    // become signed offsets within nxv4i64. The latter is illegal and triggers
    // splitvec style legalisation that's very difficult to undo.
    //
    // Here we catch such cases early and change MSCATTER's IndexType to allow
    // the use of an Index that's more legalisation friendly.
    if (FindMoreOptimalIndexType(BasePtr, Index, IndexType)) {
      SDValue Ops[] = { Chain, Data, Mask, BasePtr, Index };
      return DAG.getMaskedScatter(DAG.getVTList(MVT::Other),
                                  N->getMemoryVT(), DL, Ops,
                                  N->getMemOperand(), N->isTruncatingStore(),
                                  IndexType);
    }
  } else if (EnableSGToContiguousXForm) {
    // After everything has been legalized, we want to recognize scatters with
    // a constant stride of two and convert to two contiguous stores with
    // shuffles and masking. This hurts a little bit on 128b, but is quite
    // beneficial for greater register widths.
    //
    // We don't currently consider strides greater than two because that
    // wouldn't fit nicely in 128b. A stride of four could work with 32b
    // element types, but that should only be implemented if found to be
    // common enough to warrant it.
    //
    // TODO: If we try this on a vector legalized from a wider type, things
    // seem to go wrong; not sure why this is yet. For now, we bail out by
    // checking whether the mask was extracted (SC-1425).
    if (Index->getOpcode() == ISD::SERIES_VECTOR &&
        isa<ConstantSDNode>(Index->getOperand(1)) &&
        Mask->getOpcode() != ISD::EXTRACT_SUBVECTOR &&
        IndexType == ISD::SIGNED_SCALED) {
      auto Step = cast<ConstantSDNode>(Index->getOperand(1))->getSExtValue();
      if (Step == 2) {
        unsigned ShiftAmt;

        switch(MemVT.getSimpleVT().SimpleTy) {
        case MVT::nxv2i64:
        case MVT::nxv2f64:
          ShiftAmt = 3;
          break;
        case MVT::nxv4i32:
        case MVT::nxv4f32:
          ShiftAmt = 2;
          break;
        default:
          return SDValue();
        }

        bool ExtendIdx;
        switch (IEltVT.getSimpleVT().SimpleTy) {
          case MVT::i64:
            ExtendIdx = false;
            break;
          case MVT::i32:
            ExtendIdx = true;
            break;
          default:
            return SDValue();
        }

        // Get the first index value.
        auto IdxVal = Index->getOperand(0);

        // If the indices are 32b, we need to extend to 64b.
        if (ExtendIdx)
          IdxVal = DAG.getNode(ISD::SIGN_EXTEND, DL, MVT::i64, IdxVal);

        // Split the mask into two parts and interleave with false
        auto PFalse = SDValue(DAG.getMachineNode(AArch64::PFALSE, DL, PVT), 0);
        auto PredL = DAG.getNode(AArch64ISD::ZIP1, DL, PVT, Mask, PFalse);
        auto PredH = DAG.getNode(AArch64ISD::ZIP2, DL, PVT, Mask, PFalse);

        // Figure out the offsets needed for the two stores -- scale the
        // first index up based on element size, then scale up a count of
        // the number of elements in the vector.
        auto EltCount = DAG.getVScale(DL, MVT::i64,
                                      VT.getVectorNumElements() << ShiftAmt);
        IdxVal = DAG.getNode(ISD::SHL, DL, BVT, IdxVal,
                             DAG.getConstant(ShiftAmt, DL, MVT::i64));

        // As with the mask, split the data into two parts and interleave;
        // Here we can just use the data itself for the other lanes, since
        // the inactive lanes won't be stored.
        auto DataL = DAG.getNode(AArch64ISD::ZIP1, DL, VT, Data, Data);
        auto DataH = DAG.getNode(AArch64ISD::ZIP2, DL, VT, Data, Data);

        // Perform the actual stores, making sure we use the chain value
        // from the first in the second.
        BasePtr = DAG.getNode(ISD::ADD, DL, BVT, BasePtr, IdxVal);
        auto StoreL = DAG.getMaskedStore(Chain, DL, DataL, BasePtr, PredL,
                                         MemVT, N->getMemOperand(),
                                         N->isTruncatingStore());

        BasePtr = DAG.getNode(ISD::ADD, DL, BVT, BasePtr, EltCount);
        auto StoreH = DAG.getMaskedStore(StoreL, DL, DataH, BasePtr, PredH,
                                         MemVT, N->getMemOperand(),
                                         N->isTruncatingStore());

        return StoreH;
      }
    }
  }

  return SDValue();
}

static SDValue performVSelectMinMaxRdxCombine(SDNode *N, SelectionDAG &DAG) {
  // A vselect ((setcc op1, op2, gt), op2, op1) is doing a min selection,
  // while a cc of 'lt' will do a max.
  // There will be an AND as well if this is coming from vectorized code.
  assert(N->getOpcode() == ISD::VSELECT && "Unexpected opcode");
  SDValue Pred = N->getOperand(0);
  SDValue True = N->getOperand(1);
  SDValue False = N->getOperand(2);
  EVT ResVT = N->getValueType(0);

  if (Pred->getOpcode() != ISD::AND)
    return SDValue();

  SDValue PredOp1 = Pred->getOperand(0);
  SDValue PredOp2 = Pred->getOperand(1);
  // One of the operands should be a compare.
  SDValue SetCC;
  SDValue GP;
  if (PredOp1->getOpcode() == ISD::SETCC) {
    SetCC = PredOp1;
    GP = PredOp2;
  } else if (PredOp2->getOpcode() == ISD::SETCC) {
    SetCC = PredOp2;
    GP = PredOp1;
  } else
    return SDValue();

  SDValue CmpOp1 = SetCC->getOperand(0);
  SDValue CmpOp2 = SetCC->getOperand(1);
  SDValue CC = SetCC->getOperand(2);

  // The compare operands must match the select sources.
  if (False != CmpOp1 || True != CmpOp2)
    return SDValue();

  ISD::CondCode CondCode = cast<CondCodeSDNode>(CC)->get();

  assert(CmpOp1.getValueType().isVector() && "Unexpected vt");
  EVT ScalarVT = CmpOp1.getValueType().getVectorElementType();
  if (ScalarVT != MVT::f32 && ScalarVT != MVT::f64)
    return SDValue();

  bool IsMin = false;
  bool NoNaN = DAG.getTarget().Options.NoNaNsFPMath;
  switch (CondCode) {
    case ISD::SETGT:
    case ISD::SETGE:
      IsMin = true;
      break;
    case ISD::SETLT:
    case ISD::SETLE:
      break;
    default:
      return SDValue();
  }
  unsigned Opcode = IsMin ? AArch64ISD::FMIN_PRED : AArch64ISD::FMAX_PRED;

  // Use faster NM versions if we have NoNaNs.
  if (NoNaN) {
    if (Opcode == AArch64ISD::FMIN_PRED)
      Opcode = AArch64ISD::FMINNM_PRED;
    else
      Opcode = AArch64ISD::FMAXNM_PRED;
  }
  return DAG.getNode(Opcode, SDLoc(N), ResVT, GP, False, True);
}

static SDValue performInsertElementCombine(SDNode *N,
                                    TargetLowering::DAGCombinerInfo &DCI) {
  SelectionDAG &DAG = DCI.DAG;

  EVT VT = N->getValueType(0);
  if (!VT.isScalableVector() || VT.getVectorElementType() != MVT::i1)
    return SDValue();

  SDLoc DL(N);
  SDValue Vec = N->getOperand(0);
  SDValue Idx = N->getOperand(2);
  if (Idx->getOpcode() == ISD::INTRINSIC_WO_CHAIN) {
    SDValue AllOnes = Vec->getOperand(0);
    SDValue Pred = Vec->getOperand(1);
    if (getIntrinsicID(Idx.getNode()) == Intrinsic::ctvpop &&
        Idx->getOperand(1).getNode() == Vec.getNode() &&
        Vec->getOpcode() == ISD::PROPAGATE_FIRST_ZERO &&
        AllOnes->getOpcode() == ISD::SPLAT_VECTOR &&
        isa<ConstantSDNode>(AllOnes->getOperand(0)) &&
        cast<ConstantSDNode>(AllOnes->getOperand(0))->getZExtValue() == 1ull) {
      // Invert (propff -> brk)
      SDValue InvPred = DAG.getNode(AArch64ISD::NOT, DL, Pred.getValueType(),
                                    Pred);
      // Create the brka with AllOnes as Pg
      return DAG.getNode(AArch64ISD::BRKA, DL, VT, AllOnes, InvPred);
    }
  }

  return SDValue();
}

static void ReplaceFP_TO_INTResults(SDNode *N,
                                    SmallVectorImpl<SDValue> &Results,
                                    SelectionDAG &DAG) {
  unsigned RootOpc = N->getOpcode();
  assert(((RootOpc == ISD::FP_TO_SINT) || (RootOpc == ISD::FP_TO_UINT)) &&
         "Unexpected root!");

  EVT VT = N->getValueType(0);
  if (!VT.isScalableVector()) {
    assert(VT == MVT::i128 && "Unexpected illegal conversion!");
    // Let normal code take care of it by not adding anything to Results.
    return;
  }

  assert(VT == MVT::nxv2i32 && "Unexpected illegal conversion!");
  SDLoc DL(N);
  unsigned Opc = (RootOpc == ISD::FP_TO_SINT) ? AArch64ISD::FP_TO_SINT_INREG
                                              : AArch64ISD::FP_TO_UINT_INREG;

  SDValue SubType = DAG.getValueType(MVT::nxv2i32);
  SDValue FCVT = DAG.getNode(Opc, DL, MVT::nxv2i64, N->getOperand(0), SubType);
  Results.push_back(DAG.getNode(ISD::TRUNCATE, DL, VT, FCVT));
  return;
}

// If the node is an extension from a legal SVE type to something wider,
// use HiOpcode and LoOpcode to extend each half individually, then
// concatenate them together.
void AArch64TargetLowering::ReplaceExtensionResults(
    SDNode *N, SmallVectorImpl<SDValue> &Results, SelectionDAG &DAG,
    unsigned HiOpcode, unsigned LoOpcode) const {
  SDValue In = N->getOperand(0);
  EVT InVT = In.getValueType();
  assert(InVT.isScalableVector() && "Can only lower WA vectors");
  if (!isTypeLegal(InVT))
    return;

  EVT InEltVT = InVT.getVectorElementType();
  auto EltCnt = InVT.getVectorElementCount();
  unsigned InEltBits = InEltVT.getSizeInBits();
  if (InEltBits != 8 && InEltBits != 16 && InEltBits != 32)
    return;

  // The result must be at least twice as wide as the input in order for
  // this to work.
  EVT VT = N->getValueType(0);
  EVT EltVT = VT.getVectorElementType();
  if (EltVT.getSizeInBits() < InEltBits * 2)
    return;

  // Extend In to a double-width vector.
  SDLoc dl(N);
  EVT NewEltVT = EVT::getIntegerVT(*DAG.getContext(), InEltBits * 2);
  EVT NewVT = EVT::getVectorVT(*DAG.getContext(), NewEltVT, EltCnt/2);
  SDValue Lo = DAG.getNode(LoOpcode, dl, NewVT, In);
  SDValue Hi = DAG.getNode(HiOpcode, dl, NewVT, In);
  assert(isTypeLegal(NewVT) && "Extension result should be legal");

  // If necessary, extend again using the original code.  Such extensions
  // will also need legalizing, but at least we're making forward progress.
  NewVT = EVT::getVectorVT(*DAG.getContext(), EltVT, EltCnt/2);
  Lo = DAG.getNode(N->getOpcode(), dl, NewVT, Lo);
  Hi = DAG.getNode(N->getOpcode(), dl, NewVT, Hi);
  Results.push_back(DAG.getNode(ISD::CONCAT_VECTORS, dl, VT, Lo, Hi));
}

void AArch64TargetLowering::ReplaceExtractSubVectorResults(
    SDNode *N, SmallVectorImpl<SDValue> &Results, SelectionDAG &DAG) const {
  SDValue In = N->getOperand(0);
  EVT InVT = In.getValueType();

  // Common code will handle these just fine.
  if (!InVT.isScalableVector() || !InVT.isInteger())
    return;

  SDLoc dl(N);
  EVT VT = N->getValueType(0);

  if (!isTypeLegal(InVT)) {
    // Bubble truncates to illegal types to the surface.
    if (In->getOpcode() == ISD::TRUNCATE) {
      EVT TruncOpVT = In->getOperand(0)->getValueType(0);
      if (!isTypeLegal(TruncOpVT))
        return;

      EVT EltVT = TruncOpVT.getVectorElementType();
      EVT SubVecVT = VT.changeVectorElementType(EltVT);

      SDValue SubVec = DAG.getNode(ISD::EXTRACT_SUBVECTOR, dl, SubVecVT,
                                   In->getOperand(0), N->getOperand(1));

      Results.push_back(DAG.getNode(ISD::TRUNCATE, dl, VT, SubVec));
      return;
    }

    return;
  }

  // The following checks bail if this is not a halving operation.

  if (InVT.getVectorNumElements() != (VT.getVectorNumElements()*2))
    return;

  auto *CIndex = dyn_cast<ConstantSDNode>(N->getOperand(1));
  if (!CIndex)
    return;

  unsigned Index = CIndex->getZExtValue();
  if ((Index != 0) && (Index != VT.getVectorNumElements()))
    return;

  unsigned Opcode = (Index == 0) ? AArch64ISD::UUNPKLO : AArch64ISD::UUNPKHI;
  EVT ExtendedHalfVT = VT.widenIntegerVectorElementType(*DAG.getContext());

  SDValue Half = DAG.getNode(Opcode, dl, ExtendedHalfVT, N->getOperand(0));
  Results.push_back(DAG.getNode(ISD::TRUNCATE, dl, VT, Half));
}

void AArch64TargetLowering::ReplaceInsertSubVectorResults(
    SDNode *N, SmallVectorImpl<SDValue> &Results, SelectionDAG &DAG) const {
  SDLoc DL(N);
  SDValue Vec0 = N->getOperand(0);
  SDValue Vec1 = N->getOperand(1);
  SDValue Idx  = N->getOperand(2);
  EVT VT = N->getValueType(0);
  EVT Vec0VT = Vec0.getValueType();
  EVT Vec1VT = Vec1.getValueType();

  if (!VT.isScalableVector() || !VT.isInteger())
    return;

  unsigned NumElts = Vec1VT.getVectorNumElements();

  // Can only handle double width
  if (Vec0VT.getVectorNumElements() != (Vec1VT.getVectorNumElements() * 2))
    return;

  // Can only handle upper/lower half
  auto *CIdx = dyn_cast<ConstantSDNode>(Idx);
  if (!CIdx)
    return;

  unsigned IdxVal = CIdx->getZExtValue();

  // Extract appropriate half of larger vector, then concat with smaller vector.
  if (IdxVal == 0) {
    SDValue HiVec0 = DAG.getNode(ISD::EXTRACT_SUBVECTOR, DL, Vec1VT, Vec0,
                                  DAG.getConstant(NumElts, DL,
                                                  Idx.getValueType()));
    SDValue ConcatVec = DAG.getNode(ISD::CONCAT_VECTORS, DL,
                                    Vec0VT, Vec1, HiVec0);
    Results.push_back(ConcatVec);
  } else if (IdxVal == NumElts) {
    SDValue LoVec0 = DAG.getNode(ISD::EXTRACT_SUBVECTOR, DL, Vec1VT, Vec0,
                                 DAG.getConstant(0, DL, Idx.getValueType()));
    SDValue ConcatVec = DAG.getNode(ISD::CONCAT_VECTORS, DL,
                                    Vec0VT, LoVec0, Vec1);
    Results.push_back(ConcatVec);
  }

  return;
}

// Lower illegal vector element insert into compare + select instructions.
// The types/operations that we create here are illegal and will be legalized
// separately.
void AArch64TargetLowering::ReplaceInsertVectorElementResults(
      SDNode *N, SmallVectorImpl<SDValue> &Results, SelectionDAG &DAG) const {
  SDLoc DL(N);

  // Get all operands
  SDValue InVec  = N->getOperand(0);
  SDValue InElem = N->getOperand(1);
  SDValue InIdx  = N->getOperand(2);

  assert(InVec.getValueType().isScalableVector());

  // Element type
  EVT VT = InVec.getValueType();
  EVT EltVT = VT.getVectorElementType();

  // #Elements #Bits
  unsigned NumElts = VT.getVectorNumElements();
  unsigned EltBits = EltVT.getSizeInBits();

  // Only support lowering for scalable types and index
  if (isa<ConstantSDNode>(InIdx) ||
      NumElts * EltBits <= AArch64::SVEBitsPerBlock)
    return;

  // Get types for splats
  EVT SplatVT = VT.changeVectorElementTypeToInteger();
  EVT IntEltVT = SplatVT.getVectorElementType();
  EVT BoolVT = EVT::getIntegerVT(*DAG.getContext(), 1);
  EVT PredVT = SplatVT.changeVectorElementType(BoolVT);

  // Create splats
  SDValue Splat = DAG.getNode(ISD::SPLAT_VECTOR, DL, SplatVT,
                    DAG.getNode(ISD::BITCAST, DL, IntEltVT, InElem));
  SDValue SplatIdx = DAG.getNode(ISD::SPLAT_VECTOR, DL, SplatVT,
                       DAG.getZExtOrTrunc(InIdx, DL, IntEltVT));

  // Insert using compare mask and select
  SDValue Zero = DAG.getConstant(0, DL, IntEltVT);
  SDValue One  = DAG.getConstant(1, DL, IntEltVT);
  SDValue Seq = DAG.getNode(ISD::SERIES_VECTOR, DL, SplatVT, Zero, One);
  SDValue Cmp = DAG.getNode(ISD::SETCC, DL, PredVT,
                            SplatIdx, Seq, DAG.getCondCode(ISD::SETEQ));
  SDValue Res = DAG.getNode(ISD::VSELECT, DL, SplatVT, Cmp, Splat, InVec);
  Res = DAG.getNode(ISD::BITCAST, DL, InVec.getValueType(), Res);

  // Leave splitting of illegal types for seriesvector and vselect
  // to LLVM for further processing.
  Results.push_back(Res);
}
void AArch64TargetLowering::ReplaceMergeVecCpyResults(SDNode *N,
    SmallVectorImpl<SDValue> &Results, SelectionDAG &DAG) const {
  assert(N->getValueType(0).isScalableVector() && "Can only lower WA vectors");

  SDValue Pred     = N->getOperand(1);
  SDValue Scalar   = N->getOperand(2);
  EVT ScalarVT = Scalar->getValueType(0);

  EVT VecLoVT, VecHiVT;
  SDValue VecLo, VecHi;
  SDLoc dl(N);
  std::tie(VecLoVT, VecHiVT) = DAG.GetSplitDestVTs(N->getValueType(0));
  std::tie(VecLo, VecHi) = DAG.SplitVectorOperand(N, 0);

  EVT PredLoVT, PredHiVT;
  SDValue PredLo, PredHi;
  std::tie(PredLoVT, PredHiVT) = DAG.GetSplitDestVTs(Pred->getValueType(0));
  std::tie(PredLo, PredHi) = DAG.SplitVectorOperand(N, 1);

  SDVTList LoVTs = DAG.getVTList(VecLoVT, PredLoVT, ScalarVT);
  SDValue LoOps[] = { VecLo, PredLo, Scalar };
  SDValue LoCpy = DAG.getNode(AArch64ISD::DUP_PRED, dl, LoVTs, LoOps);

  SDVTList HiVTs = DAG.getVTList(VecHiVT, PredHiVT, ScalarVT);
  SDValue HiOps[] = { VecHi, PredHi, Scalar };
  SDValue HiCpy = DAG.getNode(AArch64ISD::DUP_PRED, dl, HiVTs, HiOps);

  SDValue Concat = DAG.getNode(ISD::CONCAT_VECTORS, dl, N->getValueType(0),
                               LoCpy, HiCpy);
  Results.push_back(Concat);
}

void AArch64TargetLowering::ReplaceMaskedSpecLoadResults(SDNode *N,
    SmallVectorImpl<SDValue> &Results, SelectionDAG &DAG) const {
  EVT ValVT = N->getValueType(0);
  EVT PredVT = N->getValueType(1);
  assert(PredVT.isScalableVector() && "Can only lower WA vectors");
  assert(ValVT.isScalableVector() && "Can only lower WA vectors");

  // not expecting a pass through value
  if (N->getOperand(5).getOpcode() != ISD::UNDEF)
    return;

  EVT EltVT = ValVT.getVectorElementType();
  unsigned NumElts = ValVT.getVectorNumElements();

  EVT NewVT = ValVT;
  if (EltVT.isInteger()) {
    int NewEltBits = AArch64::SVEBitsPerBlock / NumElts;
    EVT NewEltVT = EVT::getIntegerVT(*DAG.getContext(), NewEltBits);
    NewVT = ValVT.changeVectorElementType(NewEltVT);
  }

  if (!isTypeLegal(NewVT))
    return;

  SDLoc dl(N);
  SDVTList NodeTys = DAG.getVTList(MVT::Other, MVT::Glue);
  SDValue SetFFR = DAG.getNode(AArch64ISD::SETFFR, dl,
                               NodeTys, N->getOperand(0));
  SDValue LoadOps[] = { SetFFR,                               // Chain in
                        N->getOperand(4),                     // GP
                        N->getOperand(2),                     // Address
                        DAG.getValueType(ValVT),              // MemVT
                        SDValue(SetFFR.getNode(),1) };        // Glue in
  SDVTList LoadVTs = DAG.getVTList(NewVT, MVT::Other);
  SDValue Load = DAG.getNode(AArch64ISD::LDFF1, dl, LoadVTs, LoadOps);
  SDValue LoadChain = SDValue(Load.getNode(), 1);
  SDValue PredOps[] = { LoadChain, N->getOperand(4) }; // Chain in, GP
  SDVTList PredVTs = DAG.getVTList(PredVT, MVT::Other);
  SDValue FaultPred = DAG.getNode(AArch64ISD::RDFFR_PRED, dl, PredVTs, PredOps);
  SDValue PredChain = SDValue(FaultPred.getNode(), 1);

  if (EltVT.isInteger())
    Results.push_back(DAG.getNode(ISD::TRUNCATE, dl, ValVT, Load));
  else
    Results.push_back(Load);

  Results.push_back(FaultPred);
  Results.push_back(PredChain);
  return;
}

void AArch64TargetLowering::ReplaceVectorShuffleVarResults(
    SDNode *N, SmallVectorImpl<SDValue> &Results, SelectionDAG &DAG) const {
  EVT VT = N->getValueType(0);
  assert(VT.isScalableVector() && "Can only lower WA vectors");
  EVT EltVT = VT.getVectorElementType();
  unsigned NumElts = VT.getVectorNumElements();
  unsigned EltBits = EltVT.getSizeInBits();
  if (NumElts * EltBits <= AArch64::SVEBitsPerBlock ||
      AArch64::SVEBitsPerBlock % EltBits != 0)
    return;

  unsigned NewNumElts = AArch64::SVEBitsPerBlock / EltBits;
  EVT NewVT = EVT::getVectorVT(*DAG.getContext(), EltVT, { NewNumElts, true });
  if (!isTypeLegal(NewVT))
    return;

  Results.push_back(LowerVECTOR_SHUFFLE_VAR(SDValue(N, 0), DAG,
                                            NumElts / NewNumElts, NewVT));
}

void AArch64TargetLowering::ReplaceFP_EXTENDResults(SDNode *N,
                                            SmallVectorImpl<SDValue> &Results,
                                            SelectionDAG &DAG) const {
  EVT VT = N->getValueType(0);
  EVT InVT = N->getOperand(0)->getValueType(0);

  // Let normal code split the vector before we get involved.
  if (!isTypeLegal(InVT))
    return;

  assert(VT.isScalableVector() && "Can only lower WA vectors");
  SDLoc DL(N);
  SDValue Op = N->getOperand(0);
  EVT SplitVT = VT.getHalfNumVectorElementsVT(*DAG.getContext());
  EVT SplitInVT = InVT.getHalfNumVectorElementsVT(*DAG.getContext());

  SDValue Zip1 = DAG.getNode(AArch64ISD::ZIP1, DL, InVT, Op, Op);
  SDValue Zip2 = DAG.getNode(AArch64ISD::ZIP2, DL, InVT, Op, Op);

  SDValue Lo = DAG.getNode(AArch64ISD::REINTERPRET_CAST, DL, SplitInVT, Zip1);
  SDValue Hi = DAG.getNode(AArch64ISD::REINTERPRET_CAST, DL, SplitInVT, Zip2);

  SDValue FCvtLo = DAG.getNode(N->getOpcode(), DL, SplitVT, Lo);
  SDValue FCvtHi = DAG.getNode(N->getOpcode(), DL, SplitVT, Hi);

  Results.push_back(DAG.getNode(ISD::CONCAT_VECTORS, DL, VT, FCvtLo, FCvtHi));
}

static SDValue
performFirstTrueTestVectorCombine(SDNode *N,
                                  TargetLowering::DAGCombinerInfo &DCI,
                                  const AArch64Subtarget *Subtarget) {
  SelectionDAG &DAG = DCI.DAG;
  if (!Subtarget->hasSVE() || !DCI.isBeforeLegalize())
    return SDValue();

  assert(N->getOpcode() == ISD::EXTRACT_VECTOR_ELT);
  SDLoc DL(N);

  SDValue VecOp = N->getOperand(0);
  EVT VT = VecOp.getValueType();
  EVT EltVT = VT.getVectorElementType();
  auto *CI = dyn_cast<ConstantSDNode>(N->getOperand(1));

  if (!CI || CI->getZExtValue() != 0)
    return SDValue();

  if (!VT.isScalableVector() || EltVT != MVT::i1)
    return SDValue();

  // Extracts of lane 0 for SVE can be expressed as TEST_VECTOR(Op, FIRST)
  auto CC = DAG.getTestCode(ISD::TEST_FIRST_TRUE);
  return DAG.getNode(ISD::TEST_VECTOR, DL, EltVT, VecOp, CC);
}

void AArch64TargetLowering::ReplaceVectorBITCASTResults(SDNode *N,
                                              SmallVectorImpl<SDValue> &Results,
                                              SelectionDAG &DAG) const {
  SDLoc DL(N);
  EVT VT = N->getValueType(0);
  auto Src = N->getOperand(0);

  if (!VT.isScalableVector())
    return;

  if (!isTypeLegal(VT) && isTypeLegal(Src.getValueType())) {
    assert(!VT.isFloatingPoint() && "Expected fp->int bitcast!");
    EVT ContainerVT = getNaturalIntSVETypeWithMatchingElementCount(VT);
    auto Tmp = DAG.getNode(AArch64ISD::REINTERPRET_CAST, DL, ContainerVT, Src);
    Results.push_back(DAG.getNode(ISD::TRUNCATE, DL, VT, Tmp));
  }
}

static SDValue
performLastTrueTestVectorCombine(SDNode *N,
                                  TargetLowering::DAGCombinerInfo &DCI,
                                  const AArch64Subtarget *Subtarget) {
  SelectionDAG &DAG = DCI.DAG;
  if (!Subtarget->hasSVE() || !DCI.isBeforeLegalize())
    return SDValue();

  assert(N->getOpcode() == ISD::EXTRACT_VECTOR_ELT);
  SDLoc DL(N);

  SDValue VecOp = N->getOperand(0);
  EVT VT = VecOp.getValueType();
  EVT EltVT = VT.getVectorElementType();

  if (!VT.isScalableVector() || EltVT.getSizeInBits() != 1)
    return SDValue();

  // Idx == (vscale * NumEls) - 1

  SDValue Idx = N->getOperand(1);
  if (Idx.getOpcode() != ISD::ADD)
    return SDValue();

  SDValue VS = Idx.getOperand(0);
  if (VS.getOpcode() != ISD::VSCALE)
    return SDValue();

  unsigned NumEls = VT.getVectorNumElements();
  if (cast<ConstantSDNode>(VS.getOperand(0))->getSExtValue() != NumEls)
    return SDValue();

  auto *CI = dyn_cast<ConstantSDNode>(Idx.getOperand(1));
  if (!CI || CI->getSExtValue() != -1)
    return SDValue();

  // Extracts of lane EC-1 for SVE can be expressed as TEST_VECTOR(Op, LAST)
  auto CC = DAG.getTestCode(ISD::TEST_LAST_TRUE);
  return DAG.getNode(ISD::TEST_VECTOR, DL, EltVT, VecOp, CC);
}


static SDValue performVScaleCombine(SDNode *N,
                                    TargetLowering::DAGCombinerInfo &DCI,
                                    SelectionDAG &DAG) {
  assert(N->getOpcode() == ISD::VSCALE && "Expected ISD::VSCALE!");
  if (!DCI.isAfterLegalizeVectorOps())
    return SDValue();

  // ISD::VSCALE has an embedded constant multiplier to simplify leagilisation.
  // However, for values that don't map to VL based arithmetic instructions
  // (including loads and stores with a *VL based offset) a multiply is
  // selected.  This means we miss out on logic that replaces such multiplies
  // with shifts, chained adds, etc. Here we expand the likely cases to make
  // the multiplication explicit and thus optimisable.

  int64_t MulImm = cast<ConstantSDNode>(N->getOperand(0))->getSExtValue();
  if (MulImm % 2)
    return SDValue();

  if ((MulImm < (-32 * 16)) || (MulImm > (31 * 16))) {
    SDLoc DL(N);
    SDValue One = DAG.getTargetConstant(1, DL, MVT::i32);
    SDValue All = DAG.getTargetConstant(31, DL, MVT::i32);

    SDNode *Op;
    if ((MulImm % 16) == 0) {
      Op = DAG.getMachineNode(AArch64::RDVLI_XI, DL, MVT::i64, One);
      MulImm = MulImm / 16;
    } else if ((MulImm % 8) == 0) {
      Op = DAG.getMachineNode(AArch64::CNTH_XPiI, DL, MVT::i64, All, One);
      MulImm = MulImm / 8;
    } else if ((MulImm % 4) == 0) {
      Op = DAG.getMachineNode(AArch64::CNTW_XPiI, DL, MVT::i64, All, One);
      MulImm = MulImm / 4;
    } else {
      assert((MulImm % 2) == 0);
      Op = DAG.getMachineNode(AArch64::CNTD_XPiI, DL, MVT::i64, All, One);
      MulImm = MulImm / 2;
    }

    SDValue Cnt = SDValue(Op, 0);
    SDValue CntImm = DAG.getConstant(MulImm, DL, MVT::i64);
    return DAG.getNode(ISD::MUL, DL, MVT::i64, Cnt, CntImm);
  }

  return SDValue();
}

// Here we perform late DAG transformations to make address generation more
// amenable for SVE load/store instruction selection.
static SDValue performSVEIndexedAddressingCombine(SDNode *N,
                                           TargetLowering::DAGCombinerInfo &DCI,
                                           SelectionDAG &DAG) {
  if (!DCI.isAfterLegalizeVectorOps())
    return SDValue();

  MVT VT = N->getSimpleValueType(0);
  if (!VT.isScalarInteger())
    return SDValue();

  if (N->getOpcode() != ISD::ADD)
    return SDValue();

  bool Skip = false;
  MemSDNode* User = nullptr;

  // Only split VSCALE multiplication when used for address generation.
  for (auto UI = N->use_begin(), UE = N->use_end(); UI != UE; ++UI) {
    auto MemAccess = dyn_cast<MemSDNode>(*UI);
    if (MemAccess && MemAccess->getMemoryVT().isScalableVector()) {
      if (User == nullptr)
        User = MemAccess;

      if (User->getMemoryVT() == MemAccess->getMemoryVT())
        continue;
    }

    Skip = true;
    break;
  }

  if (Skip)
    return SDValue();

  EVT MemVT = User->getMemoryVT();
  unsigned MemEltSize = MemVT.getVectorElementType().getSizeInBits() / 8;

  // Bytes accesses can handle VSCALE multiplication as is.
  if (MemEltSize == 1)
    return SDValue();

  // load(x + (vscale * C1)) -> load(x + (vscale * C2) * sizeof(elt))
  if ((N->getOperand(1).getOpcode() == ISD::MUL) &&
      (N->getOperand(1).getOperand(0).getOpcode() == ISD::VSCALE)) {
    SDValue Mul = N->getOperand(1);
    SDValue VS = N->getOperand(1).getOperand(0);

    int64_t MulImm = cast<ConstantSDNode>(VS.getOperand(0))->getSExtValue();
    if ((MulImm % MemEltSize) == 0) {
      // Peel of part of the VSCALE multiplication that when combined with the
      // add will match against an indexed load/store.
      SDLoc DL(N);
      SDValue Scale = DAG.getConstant(countTrailingZeros(MemEltSize), DL,
                                      MVT::i64);

      SDValue NewVS = DAG.getVScale(DL, VT, MulImm / MemEltSize);
      SDValue NewMul = DAG.getNode(ISD::MUL, DL, VT, NewVS, Mul.getOperand(1));
      SDValue NewShl = DAG.getNode(ISD::SHL, DL, VT, NewMul, Scale);
      return DAG.getNode(ISD::ADD, DL, VT, N->getOperand(0), NewShl);
    }
  }

  return SDValue();
}
