//==-- AArch64FrameLowering.h - TargetFrameLowering for AArch64 --*- C++ -*-==//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_AARCH64_AARCH64FRAMELOWERING_H
#define LLVM_LIB_TARGET_AARCH64_AARCH64FRAMELOWERING_H

#include "llvm/Target/TargetFrameLowering.h"
#include "llvm/CodeGen/MachineFrameInfo.h"

namespace llvm {

class SVEVecStackRegion : public StackRegion {
  /// Scale is 2 for SVE Predicate regions, 16 for Vector regions,
  /// because an SVE vector has n*16 bytes, and a predicate n*2 bytes
  int  Scale;

  bool IsPredicateRegion;

  void SaveRestoreSVEFromPointer(MachineFunction& MF, MachineBasicBlock& MBB,
                              MachineBasicBlock::iterator MBBI,
                              DebugLoc DL,
                              uint64_t Offset, unsigned Basereg, bool IsSave) const;

public:
  SVEVecStackRegion(bool isPredicate, StringRef name) :
                          StackRegion(/*IsVarSized=*/ true, name),
                          Scale(isPredicate ? 2 : 16),
                          IsPredicateRegion(isPredicate) { }
  ~SVEVecStackRegion() override {}

  bool allocatesRegClass(const TargetRegisterClass*) const override;
  bool allocatesType(const Type*) const override;

  /// \brief Estimate the size of a StackRegion before being properly laid out.
  uint64_t estimateRegionSize(const MachineFunction &MF);

  /// \brief Lay out the Region starting at offset Offset from SP|BP (depending on
  ///        which is used)
  /// \param[in] MF           The MachineFunction containing the Region
  /// \param[in] Offset       The offset from FP|BP|SP (whichever is used)
  /// \param[in] Align        The value to which the region should be aligned.
  /// \returns the StartOffset for the next region.
  uint64_t layoutRegion(MachineFunction &MF, uint64_t Offset, unsigned Align);

  /// \brief Emit code to store CSRs and allocate space for this region.
  ///        Manual allocation may be required to allocate all space if
  ///        AddedSize is > 0 after calling this function.
  ///
  /// \param[in] MBBI          The insertion point for this Prologue
  /// \param[in,out] AddedSize The cumulative size from previous regions that
  ///                          needs to be allocated.
  /// \param[in] Basereg       is the register from which the CSRs need to be
  ///                          spilled at offset (AddedSize + Offset)
  /// \param[in] Offset        is the offset from Basereg from which CSRs need
  ///                          to be spilled assuming AddedSize = 0.
  void emitPrologue(MachineFunction &MF, MachineBasicBlock &MBB,
                               MachineBasicBlock::iterator MBBI, DebugLoc DL,
                               uint64_t& AddedSize,
                               unsigned Basereg, uint64_t Offset) const;

  /// \brief Emit code to restore CSRs and deallocate space for this
  ///        region. Manual deallocation may be required to deallocate
  ///        all space if AddedSize is > 0 after calling this function.
  /// \param[in] MBBI          The insertion point for this epilogue.
  /// \param[in,out] AddedSize The cumulative size from previous regions that
  ///                          needs to be deallocated.
  /// \param[in,out] Basereg   is the register from which the CSRs need to be
  ///                          reloaded at offset (AddedSize + Offset).
  /// \param[in] Offset        is the offset from Basereg from which CSRs need
  ///                          to be reload assuming AddedSize = 0.
  void emitEpilogue(MachineFunction &MF, MachineBasicBlock &MBB,
                               MachineBasicBlock::iterator MBBI,
                               DebugLoc DL,
                               uint64_t& AddedSize,
                               unsigned &Basereg, uint64_t Offset) const;

  void emitCFI(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
               unsigned Basereg, int64_t UnscaledOffset,
               int64_t ScaledOffset) const;

  /// Resolve FrameIndex reference (ptr+offset) for a StackObject allocated
  /// in this StackRegion. Returns Offset and stores the pointer in Basereg.
  int resolveFrameIndexReference(const MachineFunction &, int FI,
                                         unsigned &Basereg) const;

  /// Adjust the stackpointer by +/- Size, where Size is in #predicate elements.
  /// \param Basereg          The register to be adjusted by Size.
  /// \param Size             unsigned value, to be added/subtracted from SP.
  /// \param IsPositiveOffset Because Size is unsigned, IsPositiveOffset tells
  ///                         whether to add or subtract this value from the SP.
  /// \param KillBaseReg      If set, the ADDVL instructions will set a KILL flag
  ///                         on the Basereg operand.
  /// \param Dst              Destination register. If Dst is not specified or 0,
  ///                         a temporary destination register will be created.
  static unsigned adjustRegBySVE(MachineFunction &MF,
                                 MachineBasicBlock &MBB,
                                 MachineBasicBlock::iterator MBBI,
                                 DebugLoc DL,
                                 unsigned Basereg,
                                 uint64_t Size,
                                 bool IsPositiveOffset,
                                 bool KillsBaseReg = false,
                                 unsigned Dst = 0);

};


class AArch64FrameLowering : public TargetFrameLowering {
public:
  explicit AArch64FrameLowering()
      : TargetFrameLowering(StackGrowsDown, 16, 0, 16,
                            true /*StackRealignable*/) {}

  void emitCalleeSavedFrameMoves(MachineBasicBlock &MBB,
                                 MachineBasicBlock::iterator MBBI,
                                 uint64_t ScaledOffset) const;

  MachineBasicBlock::iterator
  eliminateCallFramePseudoInstr(MachineFunction &MF, MachineBasicBlock &MBB,
                                MachineBasicBlock::iterator I) const override;

  /// emitProlog/emitEpilog - These methods insert prolog and epilog code into
  /// the function.
  void emitPrologue(MachineFunction &MF, MachineBasicBlock &MBB) const override;
  void emitEpilogue(MachineFunction &MF, MachineBasicBlock &MBB) const override;

  bool canUseAsPrologue(const MachineBasicBlock &MBB) const override;

  int getFrameIndexReference(const MachineFunction &MF, int FI,
                             unsigned &FrameReg) const override;
  int resolveFrameIndexReference(const MachineFunction &MF, int FI,
                                 unsigned &FrameReg, int &ScaledOffset,
                                 bool PreferFP = false) const;
  bool spillCalleeSavedRegisters(MachineBasicBlock &MBB,
                                 MachineBasicBlock::iterator MI,
                                 const std::vector<CalleeSavedInfo> &CSI,
                                 const TargetRegisterInfo *TRI) const override;

  bool restoreCalleeSavedRegisters(MachineBasicBlock &MBB,
                                  MachineBasicBlock::iterator MI,
                                  const std::vector<CalleeSavedInfo> &CSI,
                                  const TargetRegisterInfo *TRI) const override;

  /// \brief Can this function use the red zone for local allocations.
  bool canUseRedZone(const MachineFunction &MF) const;

  bool hasFP(const MachineFunction &MF) const override;
  bool hasReservedCallFrame(const MachineFunction &MF) const override;

  void determineCalleeSaves(MachineFunction &MF, BitVector &SavedRegs,
                            RegScavenger *RS) const override;

  /// Returns true if the target will correctly handle shrink wrapping.
  bool enableShrinkWrapping(const MachineFunction &MF) const override {
    return true;
  }

  bool enableStackSlotScavenging(const MachineFunction &MF) const override;
  void registerStackRegions(MachineFunction &MF) const override;
  void layoutStackRegions(MachineFunction &MF) const override;
  bool hasVarSizedRegions(const MachineFunction &MF) const override;
private:
  bool shouldCombineCSRLocalStackBump(MachineFunction &MF,
                                      unsigned StackBumpBytes) const;
};

} // End llvm namespace

#endif
