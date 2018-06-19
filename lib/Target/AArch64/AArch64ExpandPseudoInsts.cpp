//==-- AArch64ExpandPseudoInsts.cpp - Expand pseudo instructions --*- C++ -*-=//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains a pass that expands pseudo instructions into target
// instructions to allow proper scheduling and other late optimizations.  This
// pass should be run after register allocation but before the post-regalloc
// scheduling pass.
//
//===----------------------------------------------------------------------===//

#include "AArch64InstrInfo.h"
#include "AArch64Subtarget.h"
#include "MCTargetDesc/AArch64AddressingModes.h"
#include "Utils/AArch64BaseInfo.h"
#include "llvm/CodeGen/LivePhysRegs.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineInstrBundle.h"
#include "llvm/CodeGen/RegisterScavenging.h"
#include "llvm/CodeGen/MachineOperand.h"
#include "llvm/IR/DebugLoc.h"
#include "llvm/MC/MCInstrDesc.h"
#include "llvm/Pass.h"
#include "llvm/Support/CodeGen.h"
#include "llvm/Support/MathExtras.h"
using namespace llvm;

#define AARCH64_EXPAND_PSEUDO_NAME "AArch64 pseudo instruction expansion pass"

namespace {
class AArch64ExpandPseudo : public MachineFunctionPass {
public:
  static char ID;
  AArch64ExpandPseudo() : MachineFunctionPass(ID) {
    initializeAArch64ExpandPseudoPass(*PassRegistry::getPassRegistry());
  }

  RegScavenger *RS;

  const AArch64InstrInfo *TII;

  bool runOnMachineFunction(MachineFunction &Fn) override;

  StringRef getPassName() const override { return AARCH64_EXPAND_PSEUDO_NAME; }

private:
  bool expandMBB(MachineBasicBlock &MBB);
  unsigned generatePtrue(MachineInstr &MI, MachineBasicBlock &MBB,
                         MachineBasicBlock::iterator MBBI);
  bool foldUnary(MachineInstr &MI,MachineBasicBlock &MBB,
                 MachineBasicBlock::iterator MBBI);
  bool expandMI(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                MachineBasicBlock::iterator &NextMBBI);
  bool expandMI(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI);
  bool expandMOVImm(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                    unsigned BitSize);
  bool expand_DestructiveOp(MachineInstr &MI, MachineBasicBlock &MBB,
                      MachineBasicBlock::iterator MBBI);
  bool expandSVE_SelZero(MachineInstr &MI, MachineBasicBlock &MBB,
                      MachineBasicBlock::iterator MBBI);
  bool expandSVE_FMLA(MachineInstr &MI, MachineBasicBlock &MBB,
                      MachineBasicBlock::iterator MBBI);
  bool expandCMP_SWAP(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                      unsigned LdarOp, unsigned StlrOp, unsigned CmpOp,
                      unsigned ExtendImm, unsigned ZeroReg,
                      MachineBasicBlock::iterator &NextMBBI);
  bool expandCMP_SWAP_128(MachineBasicBlock &MBB,
                          MachineBasicBlock::iterator MBBI,
                          MachineBasicBlock::iterator &NextMBBI);
};
char AArch64ExpandPseudo::ID = 0;
}

INITIALIZE_PASS(AArch64ExpandPseudo, "aarch64-expand-pseudo",
                AARCH64_EXPAND_PSEUDO_NAME, false, false)

/// \brief Transfer implicit operands on the pseudo instruction to the
/// instructions created from the expansion.
static void transferImpOps(MachineInstr &OldMI, MachineInstrBuilder &UseMI,
                           MachineInstrBuilder &DefMI) {
  const MCInstrDesc &Desc = OldMI.getDesc();
  for (unsigned i = Desc.getNumOperands(), e = OldMI.getNumOperands(); i != e;
       ++i) {
    const MachineOperand &MO = OldMI.getOperand(i);
    assert(MO.isReg() && MO.getReg());
    if (MO.isUse())
      UseMI.add(MO);
    else
      DefMI.add(MO);
  }
}

/// \brief Helper function which extracts the specified 16-bit chunk from a
/// 64-bit value.
static uint64_t getChunk(uint64_t Imm, unsigned ChunkIdx) {
  assert(ChunkIdx < 4 && "Out of range chunk index specified!");

  return (Imm >> (ChunkIdx * 16)) & 0xFFFF;
}

/// \brief Helper function which replicates a 16-bit chunk within a 64-bit
/// value. Indices correspond to element numbers in a v4i16.
static uint64_t replicateChunk(uint64_t Imm, unsigned FromIdx, unsigned ToIdx) {
  assert((FromIdx < 4) && (ToIdx < 4) && "Out of range chunk index specified!");
  const unsigned ShiftAmt = ToIdx * 16;

  // Replicate the source chunk to the destination position.
  const uint64_t Chunk = getChunk(Imm, FromIdx) << ShiftAmt;
  // Clear the destination chunk.
  Imm &= ~(0xFFFFLL << ShiftAmt);
  // Insert the replicated chunk.
  return Imm | Chunk;
}

/// \brief Helper function which tries to materialize a 64-bit value with an
/// ORR + MOVK instruction sequence.
static bool tryOrrMovk(uint64_t UImm, uint64_t OrrImm, MachineInstr &MI,
                       MachineBasicBlock &MBB,
                       MachineBasicBlock::iterator &MBBI,
                       const AArch64InstrInfo *TII, unsigned ChunkIdx) {
  assert(ChunkIdx < 4 && "Out of range chunk index specified!");
  const unsigned ShiftAmt = ChunkIdx * 16;

  uint64_t Encoding;
  if (AArch64_AM::processLogicalImmediate(OrrImm, 64, Encoding)) {
    // Create the ORR-immediate instruction.
    MachineInstrBuilder MIB =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::ORRXri))
            .add(MI.getOperand(0))
            .addReg(AArch64::XZR)
            .addImm(Encoding);

    // Create the MOVK instruction.
    const unsigned Imm16 = getChunk(UImm, ChunkIdx);
    const unsigned DstReg = MI.getOperand(0).getReg();
    const bool DstIsDead = MI.getOperand(0).isDead();
    MachineInstrBuilder MIB1 =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::MOVKXi))
            .addReg(DstReg, RegState::Define | getDeadRegState(DstIsDead))
            .addReg(DstReg)
            .addImm(Imm16)
            .addImm(AArch64_AM::getShifterImm(AArch64_AM::LSL, ShiftAmt));

    transferImpOps(MI, MIB, MIB1);
    MI.eraseFromParent();
    return true;
  }

  return false;
}

/// \brief Check whether the given 16-bit chunk replicated to full 64-bit width
/// can be materialized with an ORR instruction.
static bool canUseOrr(uint64_t Chunk, uint64_t &Encoding) {
  Chunk = (Chunk << 48) | (Chunk << 32) | (Chunk << 16) | Chunk;

  return AArch64_AM::processLogicalImmediate(Chunk, 64, Encoding);
}

/// \brief Check for identical 16-bit chunks within the constant and if so
/// materialize them with a single ORR instruction. The remaining one or two
/// 16-bit chunks will be materialized with MOVK instructions.
///
/// This allows us to materialize constants like |A|B|A|A| or |A|B|C|A| (order
/// of the chunks doesn't matter), assuming |A|A|A|A| can be materialized with
/// an ORR instruction.
///
static bool tryToreplicateChunks(uint64_t UImm, MachineInstr &MI,
                                 MachineBasicBlock &MBB,
                                 MachineBasicBlock::iterator &MBBI,
                                 const AArch64InstrInfo *TII) {
  typedef DenseMap<uint64_t, unsigned> CountMap;
  CountMap Counts;

  // Scan the constant and count how often every chunk occurs.
  for (unsigned Idx = 0; Idx < 4; ++Idx)
    ++Counts[getChunk(UImm, Idx)];

  // Traverse the chunks to find one which occurs more than once.
  for (CountMap::const_iterator Chunk = Counts.begin(), End = Counts.end();
       Chunk != End; ++Chunk) {
    const uint64_t ChunkVal = Chunk->first;
    const unsigned Count = Chunk->second;

    uint64_t Encoding = 0;

    // We are looking for chunks which have two or three instances and can be
    // materialized with an ORR instruction.
    if ((Count != 2 && Count != 3) || !canUseOrr(ChunkVal, Encoding))
      continue;

    const bool CountThree = Count == 3;
    // Create the ORR-immediate instruction.
    MachineInstrBuilder MIB =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::ORRXri))
            .add(MI.getOperand(0))
            .addReg(AArch64::XZR)
            .addImm(Encoding);

    const unsigned DstReg = MI.getOperand(0).getReg();
    const bool DstIsDead = MI.getOperand(0).isDead();

    unsigned ShiftAmt = 0;
    uint64_t Imm16 = 0;
    // Find the first chunk not materialized with the ORR instruction.
    for (; ShiftAmt < 64; ShiftAmt += 16) {
      Imm16 = (UImm >> ShiftAmt) & 0xFFFF;

      if (Imm16 != ChunkVal)
        break;
    }

    // Create the first MOVK instruction.
    MachineInstrBuilder MIB1 =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::MOVKXi))
            .addReg(DstReg,
                    RegState::Define | getDeadRegState(DstIsDead && CountThree))
            .addReg(DstReg)
            .addImm(Imm16)
            .addImm(AArch64_AM::getShifterImm(AArch64_AM::LSL, ShiftAmt));

    // In case we have three instances the whole constant is now materialized
    // and we can exit.
    if (CountThree) {
      transferImpOps(MI, MIB, MIB1);
      MI.eraseFromParent();
      return true;
    }

    // Find the remaining chunk which needs to be materialized.
    for (ShiftAmt += 16; ShiftAmt < 64; ShiftAmt += 16) {
      Imm16 = (UImm >> ShiftAmt) & 0xFFFF;

      if (Imm16 != ChunkVal)
        break;
    }

    // Create the second MOVK instruction.
    MachineInstrBuilder MIB2 =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::MOVKXi))
            .addReg(DstReg, RegState::Define | getDeadRegState(DstIsDead))
            .addReg(DstReg)
            .addImm(Imm16)
            .addImm(AArch64_AM::getShifterImm(AArch64_AM::LSL, ShiftAmt));

    transferImpOps(MI, MIB, MIB2);
    MI.eraseFromParent();
    return true;
  }

  return false;
}

/// \brief Check whether this chunk matches the pattern '1...0...'. This pattern
/// starts a contiguous sequence of ones if we look at the bits from the LSB
/// towards the MSB.
static bool isStartChunk(uint64_t Chunk) {
  if (Chunk == 0 || Chunk == UINT64_MAX)
    return false;

  return isMask_64(~Chunk);
}

/// \brief Check whether this chunk matches the pattern '0...1...' This pattern
/// ends a contiguous sequence of ones if we look at the bits from the LSB
/// towards the MSB.
static bool isEndChunk(uint64_t Chunk) {
  if (Chunk == 0 || Chunk == UINT64_MAX)
    return false;

  return isMask_64(Chunk);
}

/// \brief Clear or set all bits in the chunk at the given index.
static uint64_t updateImm(uint64_t Imm, unsigned Idx, bool Clear) {
  const uint64_t Mask = 0xFFFF;

  if (Clear)
    // Clear chunk in the immediate.
    Imm &= ~(Mask << (Idx * 16));
  else
    // Set all bits in the immediate for the particular chunk.
    Imm |= Mask << (Idx * 16);

  return Imm;
}

/// \brief Check whether the constant contains a sequence of contiguous ones,
/// which might be interrupted by one or two chunks. If so, materialize the
/// sequence of contiguous ones with an ORR instruction.
/// Materialize the chunks which are either interrupting the sequence or outside
/// of the sequence with a MOVK instruction.
///
/// Assuming S is a chunk which starts the sequence (1...0...), E is a chunk
/// which ends the sequence (0...1...). Then we are looking for constants which
/// contain at least one S and E chunk.
/// E.g. |E|A|B|S|, |A|E|B|S| or |A|B|E|S|.
///
/// We are also looking for constants like |S|A|B|E| where the contiguous
/// sequence of ones wraps around the MSB into the LSB.
///
static bool trySequenceOfOnes(uint64_t UImm, MachineInstr &MI,
                              MachineBasicBlock &MBB,
                              MachineBasicBlock::iterator &MBBI,
                              const AArch64InstrInfo *TII) {
  const int NotSet = -1;
  const uint64_t Mask = 0xFFFF;

  int StartIdx = NotSet;
  int EndIdx = NotSet;
  // Try to find the chunks which start/end a contiguous sequence of ones.
  for (int Idx = 0; Idx < 4; ++Idx) {
    int64_t Chunk = getChunk(UImm, Idx);
    // Sign extend the 16-bit chunk to 64-bit.
    Chunk = (Chunk << 48) >> 48;

    if (isStartChunk(Chunk))
      StartIdx = Idx;
    else if (isEndChunk(Chunk))
      EndIdx = Idx;
  }

  // Early exit in case we can't find a start/end chunk.
  if (StartIdx == NotSet || EndIdx == NotSet)
    return false;

  // Outside of the contiguous sequence of ones everything needs to be zero.
  uint64_t Outside = 0;
  // Chunks between the start and end chunk need to have all their bits set.
  uint64_t Inside = Mask;

  // If our contiguous sequence of ones wraps around from the MSB into the LSB,
  // just swap indices and pretend we are materializing a contiguous sequence
  // of zeros surrounded by a contiguous sequence of ones.
  if (StartIdx > EndIdx) {
    std::swap(StartIdx, EndIdx);
    std::swap(Outside, Inside);
  }

  uint64_t OrrImm = UImm;
  int FirstMovkIdx = NotSet;
  int SecondMovkIdx = NotSet;

  // Find out which chunks we need to patch up to obtain a contiguous sequence
  // of ones.
  for (int Idx = 0; Idx < 4; ++Idx) {
    const uint64_t Chunk = getChunk(UImm, Idx);

    // Check whether we are looking at a chunk which is not part of the
    // contiguous sequence of ones.
    if ((Idx < StartIdx || EndIdx < Idx) && Chunk != Outside) {
      OrrImm = updateImm(OrrImm, Idx, Outside == 0);

      // Remember the index we need to patch.
      if (FirstMovkIdx == NotSet)
        FirstMovkIdx = Idx;
      else
        SecondMovkIdx = Idx;

      // Check whether we are looking a chunk which is part of the contiguous
      // sequence of ones.
    } else if (Idx > StartIdx && Idx < EndIdx && Chunk != Inside) {
      OrrImm = updateImm(OrrImm, Idx, Inside != Mask);

      // Remember the index we need to patch.
      if (FirstMovkIdx == NotSet)
        FirstMovkIdx = Idx;
      else
        SecondMovkIdx = Idx;
    }
  }
  assert(FirstMovkIdx != NotSet && "Constant materializable with single ORR!");

  // Create the ORR-immediate instruction.
  uint64_t Encoding = 0;
  AArch64_AM::processLogicalImmediate(OrrImm, 64, Encoding);
  MachineInstrBuilder MIB =
      BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::ORRXri))
          .add(MI.getOperand(0))
          .addReg(AArch64::XZR)
          .addImm(Encoding);

  const unsigned DstReg = MI.getOperand(0).getReg();
  const bool DstIsDead = MI.getOperand(0).isDead();

  const bool SingleMovk = SecondMovkIdx == NotSet;
  // Create the first MOVK instruction.
  MachineInstrBuilder MIB1 =
      BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::MOVKXi))
          .addReg(DstReg,
                  RegState::Define | getDeadRegState(DstIsDead && SingleMovk))
          .addReg(DstReg)
          .addImm(getChunk(UImm, FirstMovkIdx))
          .addImm(
              AArch64_AM::getShifterImm(AArch64_AM::LSL, FirstMovkIdx * 16));

  // Early exit in case we only need to emit a single MOVK instruction.
  if (SingleMovk) {
    transferImpOps(MI, MIB, MIB1);
    MI.eraseFromParent();
    return true;
  }

  // Create the second MOVK instruction.
  MachineInstrBuilder MIB2 =
      BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::MOVKXi))
          .addReg(DstReg, RegState::Define | getDeadRegState(DstIsDead))
          .addReg(DstReg)
          .addImm(getChunk(UImm, SecondMovkIdx))
          .addImm(
              AArch64_AM::getShifterImm(AArch64_AM::LSL, SecondMovkIdx * 16));

  transferImpOps(MI, MIB, MIB2);
  MI.eraseFromParent();
  return true;
}

/// \brief Expand a MOVi32imm or MOVi64imm pseudo instruction to one or more
/// real move-immediate instructions to synthesize the immediate.
bool AArch64ExpandPseudo::expandMOVImm(MachineBasicBlock &MBB,
                                       MachineBasicBlock::iterator MBBI,
                                       unsigned BitSize) {
  MachineInstr &MI = *MBBI;
  unsigned DstReg = MI.getOperand(0).getReg();
  uint64_t Imm = MI.getOperand(1).getImm();
  const unsigned Mask = 0xFFFF;

  if (DstReg == AArch64::XZR || DstReg == AArch64::WZR) {
    // Useless def, and we don't want to risk creating an invalid ORR (which
    // would really write to sp).
    MI.eraseFromParent();
    return true;
  }

  // Try a MOVI instruction (aka ORR-immediate with the zero register).
  uint64_t UImm = Imm << (64 - BitSize) >> (64 - BitSize);
  uint64_t Encoding;
  if (AArch64_AM::processLogicalImmediate(UImm, BitSize, Encoding)) {
    unsigned Opc = (BitSize == 32 ? AArch64::ORRWri : AArch64::ORRXri);
    MachineInstrBuilder MIB =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(Opc))
            .add(MI.getOperand(0))
            .addReg(BitSize == 32 ? AArch64::WZR : AArch64::XZR)
            .addImm(Encoding);
    transferImpOps(MI, MIB, MIB);
    MI.eraseFromParent();
    return true;
  }

  // Scan the immediate and count the number of 16-bit chunks which are either
  // all ones or all zeros.
  unsigned OneChunks = 0;
  unsigned ZeroChunks = 0;
  for (unsigned Shift = 0; Shift < BitSize; Shift += 16) {
    const unsigned Chunk = (Imm >> Shift) & Mask;
    if (Chunk == Mask)
      OneChunks++;
    else if (Chunk == 0)
      ZeroChunks++;
  }

  // Since we can't materialize the constant with a single ORR instruction,
  // let's see whether we can materialize 3/4 of the constant with an ORR
  // instruction and use an additional MOVK instruction to materialize the
  // remaining 1/4.
  //
  // We are looking for constants with a pattern like: |A|X|B|X| or |X|A|X|B|.
  //
  // E.g. assuming |A|X|A|X| is a pattern which can be materialized with ORR,
  // we would create the following instruction sequence:
  //
  // ORR x0, xzr, |A|X|A|X|
  // MOVK x0, |B|, LSL #16
  //
  // Only look at 64-bit constants which can't be materialized with a single
  // instruction e.g. which have less than either three all zero or all one
  // chunks.
  //
  // Ignore 32-bit constants here, they always can be materialized with a
  // MOVZ/MOVN + MOVK pair. Since the 32-bit constant can't be materialized
  // with a single ORR, the best sequence we can achieve is a ORR + MOVK pair.
  // Thus we fall back to the default code below which in the best case creates
  // a single MOVZ/MOVN instruction (in case one chunk is all zero or all one).
  //
  if (BitSize == 64 && OneChunks < 3 && ZeroChunks < 3) {
    // If we interpret the 64-bit constant as a v4i16, are elements 0 and 2
    // identical?
    if (getChunk(UImm, 0) == getChunk(UImm, 2)) {
      // See if we can come up with a constant which can be materialized with
      // ORR-immediate by replicating element 3 into element 1.
      uint64_t OrrImm = replicateChunk(UImm, 3, 1);
      if (tryOrrMovk(UImm, OrrImm, MI, MBB, MBBI, TII, 1))
        return true;

      // See if we can come up with a constant which can be materialized with
      // ORR-immediate by replicating element 1 into element 3.
      OrrImm = replicateChunk(UImm, 1, 3);
      if (tryOrrMovk(UImm, OrrImm, MI, MBB, MBBI, TII, 3))
        return true;

      // If we interpret the 64-bit constant as a v4i16, are elements 1 and 3
      // identical?
    } else if (getChunk(UImm, 1) == getChunk(UImm, 3)) {
      // See if we can come up with a constant which can be materialized with
      // ORR-immediate by replicating element 2 into element 0.
      uint64_t OrrImm = replicateChunk(UImm, 2, 0);
      if (tryOrrMovk(UImm, OrrImm, MI, MBB, MBBI, TII, 0))
        return true;

      // See if we can come up with a constant which can be materialized with
      // ORR-immediate by replicating element 1 into element 3.
      OrrImm = replicateChunk(UImm, 0, 2);
      if (tryOrrMovk(UImm, OrrImm, MI, MBB, MBBI, TII, 2))
        return true;
    }
  }

  // Check for identical 16-bit chunks within the constant and if so materialize
  // them with a single ORR instruction. The remaining one or two 16-bit chunks
  // will be materialized with MOVK instructions.
  if (BitSize == 64 && tryToreplicateChunks(UImm, MI, MBB, MBBI, TII))
    return true;

  // Check whether the constant contains a sequence of contiguous ones, which
  // might be interrupted by one or two chunks. If so, materialize the sequence
  // of contiguous ones with an ORR instruction. Materialize the chunks which
  // are either interrupting the sequence or outside of the sequence with a
  // MOVK instruction.
  if (BitSize == 64 && trySequenceOfOnes(UImm, MI, MBB, MBBI, TII))
    return true;

  // Use a MOVZ or MOVN instruction to set the high bits, followed by one or
  // more MOVK instructions to insert additional 16-bit portions into the
  // lower bits.
  bool isNeg = false;

  // Use MOVN to materialize the high bits if we have more all one chunks
  // than all zero chunks.
  if (OneChunks > ZeroChunks) {
    isNeg = true;
    Imm = ~Imm;
  }

  unsigned FirstOpc;
  if (BitSize == 32) {
    Imm &= (1LL << 32) - 1;
    FirstOpc = (isNeg ? AArch64::MOVNWi : AArch64::MOVZWi);
  } else {
    FirstOpc = (isNeg ? AArch64::MOVNXi : AArch64::MOVZXi);
  }
  unsigned Shift = 0;     // LSL amount for high bits with MOVZ/MOVN
  unsigned LastShift = 0; // LSL amount for last MOVK
  if (Imm != 0) {
    unsigned LZ = countLeadingZeros(Imm);
    unsigned TZ = countTrailingZeros(Imm);
    Shift = (TZ / 16) * 16;
    LastShift = ((63 - LZ) / 16) * 16;
  }
  unsigned Imm16 = (Imm >> Shift) & Mask;
  bool DstIsDead = MI.getOperand(0).isDead();
  MachineInstrBuilder MIB1 =
      BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(FirstOpc))
          .addReg(DstReg, RegState::Define |
                  getDeadRegState(DstIsDead && Shift == LastShift))
          .addImm(Imm16)
          .addImm(AArch64_AM::getShifterImm(AArch64_AM::LSL, Shift));

  // If a MOVN was used for the high bits of a negative value, flip the rest
  // of the bits back for use with MOVK.
  if (isNeg)
    Imm = ~Imm;

  if (Shift == LastShift) {
    transferImpOps(MI, MIB1, MIB1);
    MI.eraseFromParent();
    return true;
  }

  MachineInstrBuilder MIB2;
  unsigned Opc = (BitSize == 32 ? AArch64::MOVKWi : AArch64::MOVKXi);
  while (Shift < LastShift) {
    Shift += 16;
    Imm16 = (Imm >> Shift) & Mask;
    if (Imm16 == (isNeg ? Mask : 0))
      continue; // This 16-bit portion is already set correctly.
    MIB2 = BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(Opc))
               .addReg(DstReg,
                       RegState::Define |
                       getDeadRegState(DstIsDead && Shift == LastShift))
               .addReg(DstReg)
               .addImm(Imm16)
               .addImm(AArch64_AM::getShifterImm(AArch64_AM::LSL, Shift));
  }

  transferImpOps(MI, MIB1, MIB2);
  MI.eraseFromParent();
  return true;
}

bool AArch64ExpandPseudo::expandSVE_SelZero(MachineInstr &MI,
                                            MachineBasicBlock &MBB,
                                            MachineBasicBlock::iterator MBBI) {
  unsigned Opcode;
  switch(MI.getOpcode()) {
  default:
    llvm_unreachable("unsupported opcode");
  case AArch64::SELZERO_B:
    Opcode = AArch64::SEL_ZPZZ_B;
    break;
  case AArch64::SELZERO_H:
    Opcode = AArch64::SEL_ZPZZ_H;
    break;
  case AArch64::SELZERO_S:
    Opcode = AArch64::SEL_ZPZZ_S;
    break;
  case AArch64::SELZERO_D:
    Opcode = AArch64::SEL_ZPZZ_D;
    break;
  }

  MachineInstrBuilder MIB;
  MIB = BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(Opcode))
          .add(MI.getOperand(0))
          .add(MI.getOperand(1))
          .add(MI.getOperand(2))
          .add(MI.getOperand(3));

  transferImpOps(MI, MIB, MIB);
  MI.eraseFromParent();
  return true;
}

bool AArch64ExpandPseudo::expandCMP_SWAP(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI, unsigned LdarOp,
    unsigned StlrOp, unsigned CmpOp, unsigned ExtendImm, unsigned ZeroReg,
    MachineBasicBlock::iterator &NextMBBI) {
  MachineInstr &MI = *MBBI;
  DebugLoc DL = MI.getDebugLoc();
  const MachineOperand &Dest = MI.getOperand(0);
  unsigned StatusReg = MI.getOperand(1).getReg();
  bool StatusDead = MI.getOperand(1).isDead();
  // Duplicating undef operands into 2 instructions does not guarantee the same
  // value on both; However undef should be replaced by xzr anyway.
  assert(!MI.getOperand(2).isUndef() && "cannot handle undef");
  unsigned AddrReg = MI.getOperand(2).getReg();
  unsigned DesiredReg = MI.getOperand(3).getReg();
  unsigned NewReg = MI.getOperand(4).getReg();

  MachineFunction *MF = MBB.getParent();
  auto LoadCmpBB = MF->CreateMachineBasicBlock(MBB.getBasicBlock());
  auto StoreBB = MF->CreateMachineBasicBlock(MBB.getBasicBlock());
  auto DoneBB = MF->CreateMachineBasicBlock(MBB.getBasicBlock());

  MF->insert(++MBB.getIterator(), LoadCmpBB);
  MF->insert(++LoadCmpBB->getIterator(), StoreBB);
  MF->insert(++StoreBB->getIterator(), DoneBB);

  // .Lloadcmp:
  //     mov wStatus, 0
  //     ldaxr xDest, [xAddr]
  //     cmp xDest, xDesired
  //     b.ne .Ldone
  if (!StatusDead)
    BuildMI(LoadCmpBB, DL, TII->get(AArch64::MOVZWi), StatusReg)
      .addImm(0).addImm(0);
  BuildMI(LoadCmpBB, DL, TII->get(LdarOp), Dest.getReg())
      .addReg(AddrReg);
  BuildMI(LoadCmpBB, DL, TII->get(CmpOp), ZeroReg)
      .addReg(Dest.getReg(), getKillRegState(Dest.isDead()))
      .addReg(DesiredReg)
      .addImm(ExtendImm);
  BuildMI(LoadCmpBB, DL, TII->get(AArch64::Bcc))
      .addImm(AArch64CC::NE)
      .addMBB(DoneBB)
      .addReg(AArch64::NZCV, RegState::Implicit | RegState::Kill);
  LoadCmpBB->addSuccessor(DoneBB);
  LoadCmpBB->addSuccessor(StoreBB);

  // .Lstore:
  //     stlxr wStatus, xNew, [xAddr]
  //     cbnz wStatus, .Lloadcmp
  BuildMI(StoreBB, DL, TII->get(StlrOp), StatusReg)
      .addReg(NewReg)
      .addReg(AddrReg);
  BuildMI(StoreBB, DL, TII->get(AArch64::CBNZW))
      .addReg(StatusReg, getKillRegState(StatusDead))
      .addMBB(LoadCmpBB);
  StoreBB->addSuccessor(LoadCmpBB);
  StoreBB->addSuccessor(DoneBB);

  DoneBB->splice(DoneBB->end(), &MBB, MI, MBB.end());
  DoneBB->transferSuccessors(&MBB);

  MBB.addSuccessor(LoadCmpBB);

  NextMBBI = MBB.end();
  MI.eraseFromParent();

  // Recompute livein lists.
  const MachineRegisterInfo &MRI = MBB.getParent()->getRegInfo();
  LivePhysRegs LiveRegs;
  computeLiveIns(LiveRegs, MRI, *DoneBB);
  computeLiveIns(LiveRegs, MRI, *StoreBB);
  computeLiveIns(LiveRegs, MRI, *LoadCmpBB);
  // Do an extra pass around the loop to get loop carried registers right.
  StoreBB->clearLiveIns();
  computeLiveIns(LiveRegs, MRI, *StoreBB);
  LoadCmpBB->clearLiveIns();
  computeLiveIns(LiveRegs, MRI, *LoadCmpBB);

  return true;
}

/// \brief Expand Pseudos to Instructions with destructive operands.
///
/// This mechanism uses MOVPRFX instructions for zeroing the false lanes
/// or for fixing relaxed register allocation conditions to comply with
/// the instructions register constraints. The latter case may be cheaper
/// than setting the register constraints in the register allocator,
/// since that will insert regular MOV instructions rather than MOVPRFX.
///
/// Example (after register allocation):
///
///   FSUB_ZPZZ_ZERO_B Z0, Pg, Z1, Z0
///
/// * The Pseudo FSUB_ZPZZ_ZERO_B maps to FSUB_ZPmZ_B.
/// * We cannot map directly to FSUB_ZPmZ_B because the register
///   constraints of the instruction are not met.
/// * Also the _ZERO specifies the false lanes need to be zeroed.
///
/// We first try to see if the destructive operand == result operand,
/// if not, we try to swap the operands, e.g.
///
///   FSUB_ZPmZ_B  Z0, Pg/m, Z0, Z1
///
/// But because FSUB_ZPmZ is not commutative, this is semantically
/// different, so we need a reverse instruction:
///
///   FSUBR_ZPmZ_B  Z0, Pg/m, Z0, Z1
///
/// Then we implement the zeroing of the false lanes of Z0 by adding
/// a zeroing MOVPRFX instruction:
///
///   MOVPRFX_ZPzZ_B Z0, Pg/z, Z0
///   FSUBR_ZPmZ_B   Z0, Pg/m, Z0, Z1
///
/// Note that this can only be done for _ZERO or _UNDEF variants where
/// we can guarantee the false lanes to be zeroed (by implementing this)
/// or that they are undef (don't care / not used), otherwise the
/// swapping of operands is illegal because the operation is not
/// (or cannot be emulated to be) fully commutative.
bool AArch64ExpandPseudo::expand_DestructiveOp(
                            MachineInstr &MI,
                            MachineBasicBlock &MBB,
                            MachineBasicBlock::iterator MBBI) {
  unsigned Opcode = AArch64::getSVEPseudoMap(MI.getOpcode());
  uint64_t DType = TII->get(Opcode).TSFlags & AArch64::DestructiveInstTypeMask;
  uint64_t FalseLanes = MI.getDesc().TSFlags & AArch64::FalseLanesMask;
  bool FalseZero = FalseLanes == AArch64::FalseLanesZero;

  unsigned DstReg = MI.getOperand(0).getReg();
  bool DstIsDead = MI.getOperand(0).isDead();

  if (DType == AArch64::DestructiveBinary)
    assert(DstReg != MI.getOperand(3).getReg());

  bool UseRev = false;
  unsigned PredIdx, DOPIdx, SrcIdx, Src2Idx;
  switch (DType) {
  case AArch64::DestructiveBinaryComm:
  case AArch64::DestructiveBinaryCommWithRev:
    if (DstReg == MI.getOperand(3).getReg()) {
      // FSUB Zd, Pg, Zs1, Zd  ==> FSUBR   Zd, Pg/m, Zd, Zs1
      std::tie(PredIdx, DOPIdx, SrcIdx) = std::make_tuple(1, 3, 2);
      UseRev = true;
      break;
    }
  // fallthrough
  case AArch64::DestructiveBinary:
  case AArch64::DestructiveBinaryImm:
    std::tie(PredIdx, DOPIdx, SrcIdx) = std::make_tuple(1, 2, 3);
    break;
  case AArch64::DestructiveBinaryShImmUnpred:
    std::tie(DOPIdx, SrcIdx, Src2Idx) = std::make_tuple(1, 2, 3);
    break;
  case AArch64::DestructiveTernaryCommWithRev:
    std::tie(PredIdx, DOPIdx, SrcIdx, Src2Idx) = std::make_tuple(1, 2, 3, 4);
    if (DstReg == MI.getOperand(3).getReg()) {
      // FMLA Zd, Pg, Za, Zd, Zm ==> FMAD Zdn, Pg, Zm, Za
      std::tie(PredIdx, DOPIdx, SrcIdx, Src2Idx) = std::make_tuple(1, 3, 4, 2);
      UseRev = true;
    } else if (DstReg == MI.getOperand(4).getReg()) {
      // FMLA Zd, Pg, Za, Zm, Zd ==> FMAD Zdn, Pg, Zm, Za
      std::tie(PredIdx, DOPIdx, SrcIdx, Src2Idx) = std::make_tuple(1, 4, 3, 2);
      UseRev = true;
    }
    break;
  default:
    llvm_unreachable("Unsupported Destructive Operand type");
  }

#ifndef NDEBUG
  // MOVPRFX can only be used if the destination operand
  // is the destructive operand, not as any other operand,
  // so the Destructive Operand must be unique.
  bool DOPRegIsUnique = false;
  switch (DType) {
  case AArch64::DestructiveBinaryComm:
  case AArch64::DestructiveBinaryCommWithRev:
  case AArch64::DestructiveBinary:
    DOPRegIsUnique =
      DstReg != MI.getOperand(DOPIdx).getReg() ||
      MI.getOperand(DOPIdx).getReg() != MI.getOperand(SrcIdx).getReg();
    break;
  case AArch64::DestructiveBinaryImm:
  case AArch64::DestructiveBinaryShImmUnpred:
    DOPRegIsUnique = true;
    break;
  case AArch64::DestructiveTernaryCommWithRev:
    DOPRegIsUnique =
      DstReg != MI.getOperand(DOPIdx).getReg() ||
      (MI.getOperand(DOPIdx).getReg() != MI.getOperand(SrcIdx).getReg() &&
       MI.getOperand(DOPIdx).getReg() != MI.getOperand(Src2Idx).getReg());
    break;
  }

  assert (DOPRegIsUnique && "The destructive operand should be unique");
#endif

  // Resolve the reverse opcode
  if (UseRev) {
    if (AArch64::getSVERevInstr(Opcode) != -1)
      Opcode = AArch64::getSVERevInstr(Opcode);
    else if (AArch64::getSVEOrigInstr(Opcode) != -1)
      Opcode = AArch64::getSVEOrigInstr(Opcode);
  }

  // Get the right MOVPRFX
  uint64_t ElementSize =
      TII->get(Opcode).TSFlags & AArch64::ElementSizeMask;
  unsigned MovPrfx, MovPrfxZero;
  switch (ElementSize) {
  case AArch64::ElementSizeB:
    MovPrfx = AArch64::MOVPRFX_ZZ;
    MovPrfxZero = AArch64::MOVPRFX_ZPzZ_B;
    break;
  case AArch64::ElementSizeH:
    MovPrfx = AArch64::MOVPRFX_ZZ;
    MovPrfxZero = AArch64::MOVPRFX_ZPzZ_H;
    break;
  case AArch64::ElementSizeS:
    MovPrfx = AArch64::MOVPRFX_ZZ;
    MovPrfxZero = AArch64::MOVPRFX_ZPzZ_S;
    break;
  case AArch64::ElementSizeD:
    MovPrfx = AArch64::MOVPRFX_ZZ;
    MovPrfxZero = AArch64::MOVPRFX_ZPzZ_D;
    break;
  default:
    llvm_unreachable("Unsupported ElementSize");
  }

  //
  // Create the destructive operation (if required)
  //
  MachineInstrBuilder PRFX, DOP;
  if (FalseZero) {
    // Merge source operand into destination register
    PRFX = BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(MovPrfxZero))
               .addReg(DstReg, RegState::Define)
               .addReg(MI.getOperand(PredIdx).getReg())
               .addReg(MI.getOperand(DOPIdx).getReg());

    // After the movprfx, the destructive operand is same as Dst
    DOPIdx = 0;
  } else if (DstReg != MI.getOperand(DOPIdx).getReg()) {
    PRFX = BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(MovPrfx))
               .addReg(DstReg, RegState::Define)
               .addReg(MI.getOperand(DOPIdx).getReg());
    DOPIdx = 0;
  }

  //
  // Create the destructive operation
  //
  DOP = BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(Opcode))
    .addReg(DstReg, RegState::Define | getDeadRegState(DstIsDead));

  switch (DType) {
  case AArch64::DestructiveBinary:
  case AArch64::DestructiveBinaryImm:
  case AArch64::DestructiveBinaryComm:
  case AArch64::DestructiveBinaryCommWithRev:
    DOP.add(MI.getOperand(PredIdx))
       .addReg(MI.getOperand(DOPIdx).getReg(), RegState::Kill)
       .add(MI.getOperand(SrcIdx));
    break;
  case AArch64::DestructiveBinaryShImmUnpred:
    DOP.addReg(MI.getOperand(DOPIdx).getReg(), RegState::Kill)
       .add(MI.getOperand(SrcIdx))
       .add(MI.getOperand(Src2Idx));
    break;
  case AArch64::DestructiveTernaryCommWithRev:
    DOP.add(MI.getOperand(PredIdx))
       .addReg(MI.getOperand(DOPIdx).getReg(), RegState::Kill)
       .add(MI.getOperand(SrcIdx))
       .add(MI.getOperand(Src2Idx));
    break;
  }

  if (PRFX) {
    finalizeBundle(MBB, PRFX->getIterator(), MBBI->getIterator());
    transferImpOps(MI, PRFX, DOP);
  } else
    transferImpOps(MI, DOP, DOP);

  MI.eraseFromParent();
  return true;
}

bool AArch64ExpandPseudo::expandCMP_SWAP_128(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
    MachineBasicBlock::iterator &NextMBBI) {

  MachineInstr &MI = *MBBI;
  DebugLoc DL = MI.getDebugLoc();
  MachineOperand &DestLo = MI.getOperand(0);
  MachineOperand &DestHi = MI.getOperand(1);
  unsigned StatusReg = MI.getOperand(2).getReg();
  bool StatusDead = MI.getOperand(2).isDead();
  // Duplicating undef operands into 2 instructions does not guarantee the same
  // value on both; However undef should be replaced by xzr anyway.
  assert(!MI.getOperand(3).isUndef() && "cannot handle undef");
  unsigned AddrReg = MI.getOperand(3).getReg();
  unsigned DesiredLoReg = MI.getOperand(4).getReg();
  unsigned DesiredHiReg = MI.getOperand(5).getReg();
  unsigned NewLoReg = MI.getOperand(6).getReg();
  unsigned NewHiReg = MI.getOperand(7).getReg();

  MachineFunction *MF = MBB.getParent();
  auto LoadCmpBB = MF->CreateMachineBasicBlock(MBB.getBasicBlock());
  auto StoreBB = MF->CreateMachineBasicBlock(MBB.getBasicBlock());
  auto DoneBB = MF->CreateMachineBasicBlock(MBB.getBasicBlock());

  MF->insert(++MBB.getIterator(), LoadCmpBB);
  MF->insert(++LoadCmpBB->getIterator(), StoreBB);
  MF->insert(++StoreBB->getIterator(), DoneBB);

  // .Lloadcmp:
  //     ldaxp xDestLo, xDestHi, [xAddr]
  //     cmp xDestLo, xDesiredLo
  //     sbcs xDestHi, xDesiredHi
  //     b.ne .Ldone
  BuildMI(LoadCmpBB, DL, TII->get(AArch64::LDAXPX))
      .addReg(DestLo.getReg(), RegState::Define)
      .addReg(DestHi.getReg(), RegState::Define)
      .addReg(AddrReg);
  BuildMI(LoadCmpBB, DL, TII->get(AArch64::SUBSXrs), AArch64::XZR)
      .addReg(DestLo.getReg(), getKillRegState(DestLo.isDead()))
      .addReg(DesiredLoReg)
      .addImm(0);
  BuildMI(LoadCmpBB, DL, TII->get(AArch64::CSINCWr), StatusReg)
    .addUse(AArch64::WZR)
    .addUse(AArch64::WZR)
    .addImm(AArch64CC::EQ);
  BuildMI(LoadCmpBB, DL, TII->get(AArch64::SUBSXrs), AArch64::XZR)
      .addReg(DestHi.getReg(), getKillRegState(DestHi.isDead()))
      .addReg(DesiredHiReg)
      .addImm(0);
  BuildMI(LoadCmpBB, DL, TII->get(AArch64::CSINCWr), StatusReg)
      .addUse(StatusReg, RegState::Kill)
      .addUse(StatusReg, RegState::Kill)
      .addImm(AArch64CC::EQ);
  BuildMI(LoadCmpBB, DL, TII->get(AArch64::CBNZW))
      .addUse(StatusReg, getKillRegState(StatusDead))
      .addMBB(DoneBB);
  LoadCmpBB->addSuccessor(DoneBB);
  LoadCmpBB->addSuccessor(StoreBB);

  // .Lstore:
  //     stlxp wStatus, xNewLo, xNewHi, [xAddr]
  //     cbnz wStatus, .Lloadcmp
  BuildMI(StoreBB, DL, TII->get(AArch64::STLXPX), StatusReg)
      .addReg(NewLoReg)
      .addReg(NewHiReg)
      .addReg(AddrReg);
  BuildMI(StoreBB, DL, TII->get(AArch64::CBNZW))
      .addReg(StatusReg, getKillRegState(StatusDead))
      .addMBB(LoadCmpBB);
  StoreBB->addSuccessor(LoadCmpBB);
  StoreBB->addSuccessor(DoneBB);

  DoneBB->splice(DoneBB->end(), &MBB, MI, MBB.end());
  DoneBB->transferSuccessors(&MBB);

  MBB.addSuccessor(LoadCmpBB);

  NextMBBI = MBB.end();
  MI.eraseFromParent();

  // Recompute liveness bottom up.
  const MachineRegisterInfo &MRI = MBB.getParent()->getRegInfo();
  LivePhysRegs LiveRegs;
  computeLiveIns(LiveRegs, MRI, *DoneBB);
  computeLiveIns(LiveRegs, MRI, *StoreBB);
  computeLiveIns(LiveRegs, MRI, *LoadCmpBB);
  // Do an extra pass in the loop to get the loop carried dependencies right.
  StoreBB->clearLiveIns();
  computeLiveIns(LiveRegs, MRI, *StoreBB);
  LoadCmpBB->clearLiveIns();
  computeLiveIns(LiveRegs, MRI, *LoadCmpBB);

  return true;
}

/// \brief Uses RegScavenger to find a spare PPR_3b register, and generates
/// PTRUE_B into it.  Returns the registerID
unsigned AArch64ExpandPseudo::generatePtrue(MachineInstr &MI,
                                            MachineBasicBlock &MBB,
                                            MachineBasicBlock::iterator MBBI) {
  RS->enterBasicBlock(MBB);
  RS->forward(MBBI);
  unsigned PReg = RS->FindUnusedReg(&AArch64::PPR_3bRegClass);
  assert(PReg && "Failed to scavange a predicate register to generate PTRUE");
  BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::PTRUE_B), PReg)
         .addImm(31);
  return PReg;
}
/// \brief Returns the defining instruction for MachineOperand MO,
/// which should be a register. If we are searching for the defining
/// instruction for the purpose of removing it, it only returns
/// the defining instruction if it is not read between Def..*MBBI.
static bool getRegisterDefInstr(MachineBasicBlock::iterator MBBI,
                                const MachineOperand &MO,
                                MachineBasicBlock::iterator &Def,
                                bool ForRemoving=false) {
  assert(MO.isReg() && "Operand must be a register");
  unsigned Reg = MO.getReg();

  if (MBBI == MBBI->getParent()->begin())
    return false;

  MachineBasicBlock::iterator RI = MBBI;
  for (--RI; RI != MBBI->getParent()->begin(); --RI) {
    // If we want to remove the Def, it cannot be *used* anywhere
    // else in between the Def and MBBI
    if (ForRemoving && !RI->definesRegister(Reg) && RI->readsRegister(Reg))
      return false;
    else if (RI->definesRegister(Reg))
      break;
  }

  if (!RI->definesRegister(Reg))
    return false;

  Def = RI;
  return true;
}

/// \brief Replace instructions where the destructive operand is
/// a vector of zeros with a bundled MOVPRFX instruction, e.g.
/// Transform:
///    %X0 = DUP_ZI_S 0, 0
///    %X0 = FNEG_ZPmZ_S X0, P0, X2
/// into:
///     X0 = MOVPRFX P0/z, X0
///     X0 = FNEG_ZPmZ_S X0, P0, X2
bool AArch64ExpandPseudo::foldUnary(MachineInstr &MI,
                                    MachineBasicBlock &MBB,
                                    MachineBasicBlock::iterator MBBI) {
  // Zd != Zn
  if (MI.getOperand(0).getReg() == MI.getOperand(3).getReg())
    return false;

  // Zsd must be a DUP_ZI_(B|H|S|D) 0, 0
  MachineBasicBlock::iterator Def;
  if (!getRegisterDefInstr(MBBI, MI.getOperand(1), Def, true))
    return false;

  switch (Def->getOpcode()) {
  case AArch64::DUP_ZI_B:
  case AArch64::DUP_ZI_H:
  case AArch64::DUP_ZI_S:
  case AArch64::DUP_ZI_D:
    break;
  default:
    return false;
  }

  if (!Def->getOperand(1).isImm() || Def->getOperand(1).getImm() != 0)
    return false;

  unsigned MovPrfx;
  switch (MI.getDesc().TSFlags & AArch64::ElementSizeMask) {
  case AArch64::ElementSizeB:
    MovPrfx = AArch64::MOVPRFX_ZPzZ_B;
    break;
  case AArch64::ElementSizeH:
    MovPrfx = AArch64::MOVPRFX_ZPzZ_H;
    break;
  case AArch64::ElementSizeS:
    MovPrfx = AArch64::MOVPRFX_ZPzZ_S;
    break;
  case AArch64::ElementSizeD:
    MovPrfx = AArch64::MOVPRFX_ZPzZ_D;
    break;
  default:
    llvm_unreachable("Unsupported ElementSize");
  }

  // Create a Zeroing MOVPRFX
  MachineInstrBuilder PRFX, NewMI;
  PRFX = BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(MovPrfx))
    .addReg(MI.getOperand(0).getReg(), RegState::Define)
    .addReg(MI.getOperand(2).getReg())
    .addReg(MI.getOperand(1).getReg(), RegState::Undef);

  NewMI = BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(MI.getOpcode()))
      .add(MI.getOperand(0))
      .addReg(MI.getOperand(1).getReg(), RegState::Kill)
      .add(MI.getOperand(2))
      .add(MI.getOperand(3));

  finalizeBundle(MBB, PRFX->getIterator(), MBBI->getIterator());
  transferImpOps(MI, PRFX, NewMI);

  Def->eraseFromParent();
  MBBI->eraseFromParent();

  return true;
}

/// \brief If MBBI references a pseudo instruction that should be expanded here,
/// do the expansion and return true.  Otherwise return false.
bool AArch64ExpandPseudo::expandMI(MachineBasicBlock &MBB,
                                   MachineBasicBlock::iterator MBBI,
                                   MachineBasicBlock::iterator &NextMBBI) {
  MachineInstr &MI = *MBBI;
  unsigned Opcode = MI.getOpcode();

  // Check if we can expand the destructive op
  int OrigInstr = AArch64::getSVEPseudoMap(MI.getOpcode());
  if (OrigInstr != -1) {
    auto &Orig = TII->get(OrigInstr);
    if ((Orig.TSFlags & AArch64::DestructiveInstTypeMask)
           != AArch64::NotDestructive) {
      return expand_DestructiveOp(MI, MBB, MBBI);
    }
  }
  else if ((MI.getDesc().TSFlags & AArch64::DestructiveInstTypeMask)
            == AArch64::DestructiveUnary) {
    return foldUnary(MI, MBB, MBBI);
  }

  switch (Opcode) {
  default:
    break;

  case AArch64::ADDWrr:
  case AArch64::SUBWrr:
  case AArch64::ADDXrr:
  case AArch64::SUBXrr:
  case AArch64::ADDSWrr:
  case AArch64::SUBSWrr:
  case AArch64::ADDSXrr:
  case AArch64::SUBSXrr:
  case AArch64::ANDWrr:
  case AArch64::ANDXrr:
  case AArch64::BICWrr:
  case AArch64::BICXrr:
  case AArch64::ANDSWrr:
  case AArch64::ANDSXrr:
  case AArch64::BICSWrr:
  case AArch64::BICSXrr:
  case AArch64::EONWrr:
  case AArch64::EONXrr:
  case AArch64::EORWrr:
  case AArch64::EORXrr:
  case AArch64::ORNWrr:
  case AArch64::ORNXrr:
  case AArch64::ORRWrr:
  case AArch64::ORRXrr: {
    unsigned Opcode;
    switch (MI.getOpcode()) {
    default:
      return false;
    case AArch64::ADDWrr:      Opcode = AArch64::ADDWrs; break;
    case AArch64::SUBWrr:      Opcode = AArch64::SUBWrs; break;
    case AArch64::ADDXrr:      Opcode = AArch64::ADDXrs; break;
    case AArch64::SUBXrr:      Opcode = AArch64::SUBXrs; break;
    case AArch64::ADDSWrr:     Opcode = AArch64::ADDSWrs; break;
    case AArch64::SUBSWrr:     Opcode = AArch64::SUBSWrs; break;
    case AArch64::ADDSXrr:     Opcode = AArch64::ADDSXrs; break;
    case AArch64::SUBSXrr:     Opcode = AArch64::SUBSXrs; break;
    case AArch64::ANDWrr:      Opcode = AArch64::ANDWrs; break;
    case AArch64::ANDXrr:      Opcode = AArch64::ANDXrs; break;
    case AArch64::BICWrr:      Opcode = AArch64::BICWrs; break;
    case AArch64::BICXrr:      Opcode = AArch64::BICXrs; break;
    case AArch64::ANDSWrr:     Opcode = AArch64::ANDSWrs; break;
    case AArch64::ANDSXrr:     Opcode = AArch64::ANDSXrs; break;
    case AArch64::BICSWrr:     Opcode = AArch64::BICSWrs; break;
    case AArch64::BICSXrr:     Opcode = AArch64::BICSXrs; break;
    case AArch64::EONWrr:      Opcode = AArch64::EONWrs; break;
    case AArch64::EONXrr:      Opcode = AArch64::EONXrs; break;
    case AArch64::EORWrr:      Opcode = AArch64::EORWrs; break;
    case AArch64::EORXrr:      Opcode = AArch64::EORXrs; break;
    case AArch64::ORNWrr:      Opcode = AArch64::ORNWrs; break;
    case AArch64::ORNXrr:      Opcode = AArch64::ORNXrs; break;
    case AArch64::ORRWrr:      Opcode = AArch64::ORRWrs; break;
    case AArch64::ORRXrr:      Opcode = AArch64::ORRXrs; break;
    }
    MachineInstrBuilder MIB1 =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(Opcode),
                MI.getOperand(0).getReg())
            .add(MI.getOperand(1))
            .add(MI.getOperand(2))
            .addImm(AArch64_AM::getShifterImm(AArch64_AM::LSL, 0));
    transferImpOps(MI, MIB1, MIB1);
    MI.eraseFromParent();
    return true;
  }

  case AArch64::LOADgot: {
    // Expand into ADRP + LDR.
    unsigned DstReg = MI.getOperand(0).getReg();
    const MachineOperand &MO1 = MI.getOperand(1);
    unsigned Flags = MO1.getTargetFlags();
    MachineInstrBuilder MIB1 =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::ADRP), DstReg);
    MachineInstrBuilder MIB2 =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::LDRXui))
            .add(MI.getOperand(0))
            .addReg(DstReg);

    if (MO1.isGlobal()) {
      MIB1.addGlobalAddress(MO1.getGlobal(), 0, Flags | AArch64II::MO_PAGE);
      MIB2.addGlobalAddress(MO1.getGlobal(), 0,
                            Flags | AArch64II::MO_PAGEOFF | AArch64II::MO_NC);
    } else if (MO1.isSymbol()) {
      MIB1.addExternalSymbol(MO1.getSymbolName(), Flags | AArch64II::MO_PAGE);
      MIB2.addExternalSymbol(MO1.getSymbolName(),
                             Flags | AArch64II::MO_PAGEOFF | AArch64II::MO_NC);
    } else {
      assert(MO1.isCPI() &&
             "Only expect globals, externalsymbols, or constant pools");
      MIB1.addConstantPoolIndex(MO1.getIndex(), MO1.getOffset(),
                                Flags | AArch64II::MO_PAGE);
      MIB2.addConstantPoolIndex(MO1.getIndex(), MO1.getOffset(),
                                Flags | AArch64II::MO_PAGEOFF |
                                    AArch64II::MO_NC);
    }

    transferImpOps(MI, MIB1, MIB2);
    MI.eraseFromParent();
    return true;
  }

  case AArch64::MOVaddr:
  case AArch64::MOVaddrJT:
  case AArch64::MOVaddrCP:
  case AArch64::MOVaddrBA:
  case AArch64::MOVaddrTLS:
  case AArch64::MOVaddrEXT: {
    // Expand into ADRP + ADD.
    unsigned DstReg = MI.getOperand(0).getReg();
    MachineInstrBuilder MIB1 =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::ADRP), DstReg)
            .add(MI.getOperand(1));

    MachineInstrBuilder MIB2 =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::ADDXri))
            .add(MI.getOperand(0))
            .addReg(DstReg)
            .add(MI.getOperand(2))
            .addImm(0);

    transferImpOps(MI, MIB1, MIB2);
    MI.eraseFromParent();
    return true;
  }
  case AArch64::MOVbaseTLS: {
    unsigned DstReg = MI.getOperand(0).getReg();
    auto SysReg = AArch64SysReg::TPIDR_EL0;
    MachineFunction *MF = MBB.getParent();
    if (MF->getTarget().getTargetTriple().isOSFuchsia() &&
        MF->getTarget().getCodeModel() == CodeModel::Kernel)
      SysReg = AArch64SysReg::TPIDR_EL1;
    BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::MRS), DstReg)
        .addImm(SysReg);
    MI.eraseFromParent();
    return true;
  }

  case AArch64::MOVi32imm:
    return expandMOVImm(MBB, MBBI, 32);
  case AArch64::MOVi64imm:
    return expandMOVImm(MBB, MBBI, 64);
  case AArch64::RET_ReallyLR: {
    // Hiding the LR use with RET_ReallyLR may lead to extra kills in the
    // function and missing live-ins. We are fine in practice because callee
    // saved register handling ensures the register value is restored before
    // RET, but we need the undef flag here to appease the MachineVerifier
    // liveness checks.
    MachineInstrBuilder MIB =
        BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(AArch64::RET))
          .addReg(AArch64::LR, RegState::Undef);
    transferImpOps(MI, MIB, MIB);
    MI.eraseFromParent();
    return true;
  }

  case AArch64::SELZERO_B:
  case AArch64::SELZERO_H:
  case AArch64::SELZERO_S:
  case AArch64::SELZERO_D:
    return expandSVE_SelZero(MI, MBB, MBBI);

  case AArch64::CMP_SWAP_8:
    return expandCMP_SWAP(MBB, MBBI, AArch64::LDAXRB, AArch64::STLXRB,
                          AArch64::SUBSWrx,
                          AArch64_AM::getArithExtendImm(AArch64_AM::UXTB, 0),
                          AArch64::WZR, NextMBBI);
  case AArch64::CMP_SWAP_16:
    return expandCMP_SWAP(MBB, MBBI, AArch64::LDAXRH, AArch64::STLXRH,
                          AArch64::SUBSWrx,
                          AArch64_AM::getArithExtendImm(AArch64_AM::UXTH, 0),
                          AArch64::WZR, NextMBBI);
  case AArch64::CMP_SWAP_32:
    return expandCMP_SWAP(MBB, MBBI, AArch64::LDAXRW, AArch64::STLXRW,
                          AArch64::SUBSWrs,
                          AArch64_AM::getShifterImm(AArch64_AM::LSL, 0),
                          AArch64::WZR, NextMBBI);
  case AArch64::CMP_SWAP_64:
    return expandCMP_SWAP(MBB, MBBI,
                          AArch64::LDAXRX, AArch64::STLXRX, AArch64::SUBSXrs,
                          AArch64_AM::getShifterImm(AArch64_AM::LSL, 0),
                          AArch64::XZR, NextMBBI);
  case AArch64::CMP_SWAP_128:
    return expandCMP_SWAP_128(MBB, MBBI, NextMBBI);

#define EXPAND_SVE_ADR(X) \
  case X: {\
    unsigned Opcode;\
\
    assert(MI.getOperand(3).isImm() && "Expected immediate operand");\
    switch (MI.getOperand(3).getImm()) {\
    default: llvm_unreachable("Unexpected immediate");\
    case 0: Opcode = X##_0; break;\
    case 1: Opcode = X##_1; break;\
    case 2: Opcode = X##_2; break;\
    case 3: Opcode = X##_3; break;\
    }\
\
    MachineInstrBuilder MIB =\
      BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(Opcode))\
             .add(MI.getOperand(0))\
             .add(MI.getOperand(1))\
             .add(MI.getOperand(2));\
    transferImpOps(MI, MIB, MIB);\
    MI.eraseFromParent();\
    return true;\
  }
  EXPAND_SVE_ADR(AArch64::ADR_LSL_ZZZ_S)
  EXPAND_SVE_ADR(AArch64::ADR_LSL_ZZZ_D)
  EXPAND_SVE_ADR(AArch64::ADR_SXTW_ZZZ_D)
  EXPAND_SVE_ADR(AArch64::ADR_UXTW_ZZZ_D)

  case AArch64::STR_ZZXI:
  case AArch64::STR_ZZZXI:
  case AArch64::STR_ZZZZXI: {
    unsigned Opcode;
    switch (MI.getOpcode()) {
    default: llvm_unreachable("Unexpected opcode");
    case AArch64::STR_ZZXI:   Opcode = AArch64::ST2B_IMM; break;
    case AArch64::STR_ZZZXI:  Opcode = AArch64::ST3B_IMM; break;
    case AArch64::STR_ZZZZXI: Opcode = AArch64::ST4B_IMM; break;
    }
    unsigned PReg = generatePtrue(MI, MBB, MBBI);
    assert(MI.getOperand(2).isImm() && "Expected immediate operand");
    int64_t Imm = MI.getOperand(2).getImm();
    MachineInstrBuilder MIB =
      BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(Opcode))
             .add(MI.getOperand(0))
             .addReg(PReg, getKillRegState(true))
             .add(MI.getOperand(1))
             .addImm(Imm);
    transferImpOps(MI, MIB, MIB);
    MI.eraseFromParent();
    return true;
  }
  case AArch64::LDR_ZZXI:
  case AArch64::LDR_ZZZXI:
  case AArch64::LDR_ZZZZXI: {
    unsigned Opcode;
    switch (MI.getOpcode()) {
    default: llvm_unreachable("Unexpected opcode");
    case AArch64::LDR_ZZXI:   Opcode = AArch64::LD2B_IMM; break;
    case AArch64::LDR_ZZZXI:  Opcode = AArch64::LD3B_IMM; break;
    case AArch64::LDR_ZZZZXI: Opcode = AArch64::LD4B_IMM; break;
    }
    unsigned PReg = generatePtrue(MI, MBB, MBBI);
    assert(MI.getOperand(2).isImm() && "Expected immediate operand");
    int64_t Imm = MI.getOperand(2).getImm();
    MachineInstrBuilder MIB =
      BuildMI(MBB, MBBI, MI.getDebugLoc(), TII->get(Opcode),
              MI.getOperand(0).getReg()).addReg(PReg, getKillRegState(true))
                                        .add(MI.getOperand(1))
                                        .addImm(Imm);
    transferImpOps(MI, MIB, MIB);
    MI.eraseFromParent();
    return true;
  }
  case AArch64::AESMCrrTied:
  case AArch64::AESIMCrrTied: {
    MachineInstrBuilder MIB =
    BuildMI(MBB, MBBI, MI.getDebugLoc(),
            TII->get(Opcode == AArch64::AESMCrrTied ? AArch64::AESMCrr :
                                                      AArch64::AESIMCrr))
      .add(MI.getOperand(0))
      .add(MI.getOperand(1));
    transferImpOps(MI, MIB, MIB);
    MI.eraseFromParent();
    return true;
   }
  }
  return false;
}

/// \brief Iterate over the instructions in basic block MBB and expand any
/// pseudo instructions.  Return true if anything was modified.
bool AArch64ExpandPseudo::expandMBB(MachineBasicBlock &MBB) {
  bool Modified = false;

  MachineBasicBlock::iterator MBBI = MBB.begin(), E = MBB.end();
  while (MBBI != E) {
    MachineBasicBlock::iterator NMBBI = std::next(MBBI);
    Modified |= expandMI(MBB, MBBI, NMBBI);
    MBBI = NMBBI;
  }

  return Modified;
}

bool AArch64ExpandPseudo::runOnMachineFunction(MachineFunction &MF) {
  TII = static_cast<const AArch64InstrInfo *>(MF.getSubtarget().getInstrInfo());
  auto UniqueRS = make_unique<RegScavenger>();
  RS = UniqueRS.get();

  bool Modified = false;
  for (auto &MBB : MF)
    Modified |= expandMBB(MBB);
#ifndef NDEBUG
  // Verify the MachineFunction as we may be missing def/use/kill flags
  // on some of the instructions/operands we added.
  if (Modified)
    MF.verify(nullptr, "In AArch64ExpandPseudo");
#endif
  return Modified;
}

/// \brief Returns an instance of the pseudo instruction expansion pass.
FunctionPass *llvm::createAArch64ExpandPseudoPass() {
  return new AArch64ExpandPseudo();
}
