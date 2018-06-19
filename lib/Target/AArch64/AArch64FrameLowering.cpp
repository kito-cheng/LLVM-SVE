//===- AArch64FrameLowering.cpp - AArch64 Frame Lowering -------*- C++ -*-====//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the AArch64 implementation of TargetFrameLowering class.
//
// On AArch64, stack frames are structured as follows:
//
// The stack grows downward.
//
// All of the individual frame areas on the frame below are optional, i.e. it's
// possible to create a function so that the particular area isn't present
// in the frame.
//
// At function entry, the "frame" looks as follows:
//
// |                                   | Higher address
// |-----------------------------------|
// |                                   |
// | arguments passed on the stack     |
// |                                   |
// |-----------------------------------| <- sp
// |                                   | Lower address
//
//
// After the prologue has run, the frame has the following general structure.
// Note that this doesn't depict the case where a red-zone is used. Also,
// technically the last frame area (VLAs) doesn't get created until in the
// main function body, after the prologue is run. However, it's depicted here
// for completeness.
//
// |                                   | Higher address
// |-----------------------------------|
// |                                   |
// | arguments passed on the stack     |
// |                                   |
// |-----------------------------------|
// |                                   |
// | (Win64 only) varargs from reg     |
// |                                   |
// |-----------------------------------|
// |                                   |
// | prev_fp, prev_lr                  |
// | (a.k.a. "frame record")           |
// |-----------------------------------| <- fp(=x29)
// |                                   |
// | other callee-saved registers      |
// |                                   |
// |-----------------------------------|
// |.empty.space.to.make.part.below....|
// |.aligned.in.case.it.needs.more.than| (size of this area is unknown at
// |.the.standard.16-byte.alignment....|  compile time; if present)
// |-----------------------------------|
// |                                   |
// | local variables of fixed size     |
// | including spill slots             |
// |-----------------------------------| <- bp(not defined by ABI,
// |.variable-sized.local.variables....|       LLVM chooses X19)
// |.(VLAs)............................| (size of this area is unknown at
// |...................................|  compile time)
// |-----------------------------------| <- sp
// |                                   | Lower address
//
//
// To access the data in a frame, at-compile time, a constant offset must be
// computable from one of the pointers (fp, bp, sp) to access it. The size
// of the areas with a dotted background cannot be computed at compile-time
// if they are present, making it required to have all three of fp, bp and
// sp to be set up to be able to access all contents in the frame areas,
// assuming all of the frame areas are non-empty.
//
// For most functions, some of the frame areas are empty. For those functions,
// it may not be necessary to set up fp or bp:
// * A base pointer is definitely needed when there are both VLAs and local
//   variables with more-than-default alignment requirements.
// * A frame pointer is definitely needed when there are local variables with
//   more-than-default alignment requirements.
//
// In some cases when a base pointer is not strictly needed, it is generated
// anyway when offsets from the frame pointer to access local variables become
// so large that the offset can't be encoded in the immediate fields of loads
// or stores.
//
// FIXME: also explain the redzone concept.
// FIXME: also explain the concept of reserved call frames.
//
//===----------------------------------------------------------------------===//

#include "AArch64FrameLowering.h"
#include "AArch64InstrInfo.h"
#include "AArch64MachineFunctionInfo.h"
#include "AArch64RegisterInfo.h"
#include "AArch64Subtarget.h"
#include "AArch64TargetMachine.h"
#include "MCTargetDesc/AArch64AddressingModes.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/CodeGen/LivePhysRegs.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineMemOperand.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/CodeGen/MachineOperand.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/RegisterScavenging.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/CallingConv.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/DebugLoc.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Metadata.h"
#include "llvm/MC/MCDwarf.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/MathExtras.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Target/TargetInstrInfo.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Target/TargetOptions.h"
#include "llvm/Target/TargetRegisterInfo.h"
#include "llvm/Target/TargetSubtargetInfo.h"
#include <cassert>
#include <cstdint>
#include <iterator>
#include <vector>

using namespace llvm;

#define DEBUG_TYPE "frame-info"

static cl::opt<bool> EnableRedZone("aarch64-redzone",
                                   cl::desc("enable use of redzone on AArch64"),
                                   cl::init(false), cl::Hidden);

STATISTIC(NumRedZoneFunctions, "Number of functions using red zone");

/// Look at each instruction that references stack frames and return the stack
/// size limit beyond which some of these instructions will require a scratch
/// register during their expansion later.
static unsigned estimateRSStackSizeLimit(MachineFunction &MF) {
  // FIXME: For now, just conservatively guestimate based on unscaled indexing
  // range. We'll end up allocating an unnecessary spill slot a lot, but
  // realistically that's not a big deal at this stage of the game.
  for (MachineBasicBlock &MBB : MF) {
    for (MachineInstr &MI : MBB) {
      if (MI.isDebugValue() || MI.isPseudo() ||
          MI.getOpcode() == AArch64::ADDXri ||
          MI.getOpcode() == AArch64::ADDSXri)
        continue;

      for (unsigned i = 0, e = MI.getNumOperands(); i != e; ++i) {
        if (!MI.getOperand(i).isFI())
          continue;

        int Offset = 0;
        if (isAArch64FrameOffsetLegal(MI, Offset, nullptr, nullptr, nullptr) ==
            AArch64FrameOffsetCannotUpdate)
          return 0;
      }
    }
  }
  return 255;
}

bool AArch64FrameLowering::canUseRedZone(const MachineFunction &MF) const {
  if (!EnableRedZone)
    return false;
  // Don't use the red zone if the function explicitly asks us not to.
  // This is typically used for kernel code.
  if (MF.getFunction()->hasFnAttribute(Attribute::NoRedZone))
    return false;

  const MachineFrameInfo &MFI = MF.getFrameInfo();
  const AArch64FunctionInfo *AFI = MF.getInfo<AArch64FunctionInfo>();
  unsigned NumBytes = AFI->getLocalStackSize();

  // TODO: Add check for non-empty StackRegions?
  return !(MFI.hasCalls() || hasFP(MF) || NumBytes > 128);
}

/// hasFP - Return true if the specified function should have a dedicated frame
/// pointer register.
bool AArch64FrameLowering::hasFP(const MachineFunction &MF) const {
  const MachineFrameInfo &MFI = MF.getFrameInfo();
  const TargetRegisterInfo *RegInfo = MF.getSubtarget().getRegisterInfo();
  // Retain behavior of always omitting the FP for leaf functions when possible.
  return (MFI.hasCalls() &&
          MF.getTarget().Options.DisableFramePointerElim(MF)) ||
         MFI.hasVarSizedObjects() || MFI.isFrameAddressTaken() ||
         MFI.hasStackMap() || MFI.hasPatchPoint() ||
         RegInfo->needsStackRealignment(MF);
}

/// hasReservedCallFrame - Under normal circumstances, when a frame pointer is
/// not required, we reserve argument space for call sites in the function
/// immediately on entry to the current function.  This eliminates the need for
/// add/sub sp brackets around call sites.  Returns true if the call frame is
/// included as part of the stack frame.
bool
AArch64FrameLowering::hasReservedCallFrame(const MachineFunction &MF) const {
  return !MF.getFrameInfo().hasVarSizedObjects();
}

MachineBasicBlock::iterator AArch64FrameLowering::eliminateCallFramePseudoInstr(
    MachineFunction &MF, MachineBasicBlock &MBB,
    MachineBasicBlock::iterator I) const {
  const AArch64InstrInfo *TII =
      static_cast<const AArch64InstrInfo *>(MF.getSubtarget().getInstrInfo());
  DebugLoc DL = I->getDebugLoc();
  unsigned Opc = I->getOpcode();
  bool IsDestroy = Opc == TII->getCallFrameDestroyOpcode();
  uint64_t CalleePopAmount = IsDestroy ? I->getOperand(1).getImm() : 0;

  const TargetFrameLowering *TFI = MF.getSubtarget().getFrameLowering();
  if (!TFI->hasReservedCallFrame(MF)) {
    unsigned Align = getStackAlignment();

    int64_t Amount = I->getOperand(0).getImm();
    Amount = alignTo(Amount, Align);
    if (!IsDestroy)
      Amount = -Amount;

    // N.b. if CalleePopAmount is valid but zero (i.e. callee would pop, but it
    // doesn't have to pop anything), then the first operand will be zero too so
    // this adjustment is a no-op.
    if (CalleePopAmount == 0) {
      // FIXME: in-function stack adjustment for calls is limited to 24-bits
      // because there's no guaranteed temporary register available.
      //
      // ADD/SUB (immediate) has only LSL #0 and LSL #12 available.
      // 1) For offset <= 12-bit, we use LSL #0
      // 2) For 12-bit <= offset <= 24-bit, we use two instructions. One uses
      // LSL #0, and the other uses LSL #12.
      //
      // Most call frames will be allocated at the start of a function so
      // this is OK, but it is a limitation that needs dealing with.
      assert(Amount > -0xffffff && Amount < 0xffffff && "call frame too large");
      emitFrameOffset(MBB, I, DL, AArch64::SP, AArch64::SP, Amount, TII);
    }
  } else if (CalleePopAmount != 0) {
    // If the calling convention demands that the callee pops arguments from the
    // stack, we want to add it back if we have a reserved call frame.
    assert(CalleePopAmount < 0xffffff && "call frame too large");
    emitFrameOffset(MBB, I, DL, AArch64::SP, AArch64::SP, -CalleePopAmount,
                    TII);
  }
  return MBB.erase(I);
}

void AArch64FrameLowering::emitCalleeSavedFrameMoves(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
    uint64_t StartOffset) const {
  MachineFunction &MF = *MBB.getParent();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  const TargetSubtargetInfo &STI = MF.getSubtarget();
  const MCRegisterInfo *MRI = STI.getRegisterInfo();
  const TargetInstrInfo *TII = STI.getInstrInfo();
  DebugLoc DL = MBB.findDebugLoc(MBBI);

  // Add callee saved registers to move list.
  const std::vector<CalleeSavedInfo> &CSI = MFI.getCalleeSavedInfo();
  if (CSI.empty())
    return;

  for (const auto &Info : CSI) {
    unsigned Reg = Info.getReg();
    int64_t Offset =
        MFI.getObjectOffset(Info.getFrameIdx()) - getOffsetOfLocalArea();
    unsigned DwarfReg = MRI->getDwarfRegNum(Reg, true);

    unsigned CFIIndex;
    if (StartOffset) {
      // If there is an SVE region and no FP, the CFA will be all the way
      // on top of the SVE region. This means that accessing the saves
      // of non-SVE registers need to be done from the SP+stacksize
      // (as if there weren't any SVE stack objects at all). This reuses
      // 'createScaledOffset' with an empty scaled offset.

      unsigned DwarfBReg = MRI->getDwarfRegNum(AArch64::SP, true);

      // Add comment for Asm
      std::string Comment;
      raw_string_ostream CommentOS(Comment);
      CommentOS << "cfi(" << MRI->getName(Reg) << ") = "
              << MRI->getName(AArch64::SP) << " + " << (StartOffset + Offset);
      DEBUG(dbgs() << CommentOS.str() << "\n");

      CFIIndex = MF.addFrameInst(
        MCCFIInstruction::createScaledOffset(nullptr, DwarfReg, DwarfBReg,
                                             StartOffset + Offset, 0, 0,
                                             CommentOS.str()));
    } else {
      CFIIndex = MF.addFrameInst(
        MCCFIInstruction::createOffset(nullptr, DwarfReg, Offset));
    }
    BuildMI(MBB, MBBI, DL, TII->get(TargetOpcode::CFI_INSTRUCTION))
        .addCFIIndex(CFIIndex)
        .setMIFlags(MachineInstr::FrameSetup);
  }
}

// Find a scratch register that we can use at the start of the prologue to
// re-align the stack pointer.  We avoid using callee-save registers since they
// may appear to be free when this is called from canUseAsPrologue (during
// shrink wrapping), but then no longer be free when this is called from
// emitPrologue.
//
// FIXME: This is a bit conservative, since in the above case we could use one
// of the callee-save registers as a scratch temp to re-align the stack pointer,
// but we would then have to make sure that we were in fact saving at least one
// callee-save register in the prologue, which is additional complexity that
// doesn't seem worth the benefit.
static unsigned findScratchNonCalleeSaveRegister(MachineBasicBlock *MBB) {
  MachineFunction *MF = MBB->getParent();

  // If MBB is an entry block, use X9 as the scratch register
  if (&MF->front() == MBB)
    return AArch64::X9;

  const AArch64Subtarget &Subtarget = MF->getSubtarget<AArch64Subtarget>();
  const AArch64RegisterInfo &TRI = *Subtarget.getRegisterInfo();
  LivePhysRegs LiveRegs(TRI);
  LiveRegs.addLiveIns(*MBB);

  // Mark callee saved registers as used so we will not choose them.
  const MCPhysReg *CSRegs = TRI.getCalleeSavedRegs(MF);
  for (unsigned i = 0; CSRegs[i]; ++i)
    LiveRegs.addReg(CSRegs[i]);

  // Prefer X9 since it was historically used for the prologue scratch reg.
  const MachineRegisterInfo &MRI = MF->getRegInfo();
  if (LiveRegs.available(MRI, AArch64::X9))
    return AArch64::X9;

  for (unsigned Reg : AArch64::GPR64RegClass) {
    if (LiveRegs.available(MRI, Reg))
      return Reg;
  }
  return AArch64::NoRegister;
}

bool AArch64FrameLowering::canUseAsPrologue(
    const MachineBasicBlock &MBB) const {
  const MachineFunction *MF = MBB.getParent();
  MachineBasicBlock *TmpMBB = const_cast<MachineBasicBlock *>(&MBB);
  const AArch64Subtarget &Subtarget = MF->getSubtarget<AArch64Subtarget>();
  const AArch64RegisterInfo *RegInfo = Subtarget.getRegisterInfo();

  // Don't need a scratch register if we're not going to re-align the stack.
  if (!RegInfo->needsStackRealignment(*MF))
    return true;
  // Otherwise, we can use any block as long as it has a scratch register
  // available.
  return findScratchNonCalleeSaveRegister(TmpMBB) != AArch64::NoRegister;
}

bool AArch64FrameLowering::shouldCombineCSRLocalStackBump(
    MachineFunction &MF, unsigned StackBumpBytes) const {
  AArch64FunctionInfo *AFI = MF.getInfo<AArch64FunctionInfo>();
  const MachineFrameInfo &MFI = MF.getFrameInfo();
  const AArch64Subtarget &Subtarget = MF.getSubtarget<AArch64Subtarget>();
  const AArch64RegisterInfo *RegInfo = Subtarget.getRegisterInfo();

  if (AFI->getLocalStackSize() == 0)
    return false;

  // 512 is the maximum immediate for stp/ldp that will be used for
  // callee-save save/restores
  if (StackBumpBytes >= 512)
    return false;

  if (MFI.hasVarSizedObjects())
    return false;

  if (RegInfo->needsStackRealignment(MF))
    return false;

  // This isn't strictly necessary, but it simplifies things a bit since the
  // current RedZone handling code assumes the SP is adjusted by the
  // callee-save save/restore code.
  if (canUseRedZone(MF))
    return false;

  if (hasVarSizedRegions(MF))
    return false;

  return true;
}

// Convert callee-save register save/restore instruction to do stack pointer
// decrement/increment to allocate/deallocate the callee-save stack area by
// converting store/load to use pre/post increment version.
static MachineBasicBlock::iterator convertCalleeSaveRestoreToSPPrePostIncDec(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
    const DebugLoc &DL, const TargetInstrInfo *TII, int CSStackSizeInc) {
  unsigned NewOpc;
  int Scale = 1;
  switch (MBBI->getOpcode()) {
  default:
    llvm_unreachable("Unexpected callee-save save/restore opcode!");
  case AArch64::STPXi:
    NewOpc = AArch64::STPXpre;
    Scale = 8;
    break;
  case AArch64::STPDi:
    NewOpc = AArch64::STPDpre;
    Scale = 8;
    break;
  case AArch64::STPQi:
    NewOpc = AArch64::STPQpre;
    Scale = 16;
    break;
  case AArch64::STRXui:
    NewOpc = AArch64::STRXpre;
    break;
  case AArch64::STRDui:
    NewOpc = AArch64::STRDpre;
    break;
  case AArch64::STRQui:
    NewOpc = AArch64::STRQpre;
    break;
  case AArch64::LDPXi:
    NewOpc = AArch64::LDPXpost;
    Scale = 8;
    break;
  case AArch64::LDPDi:
    NewOpc = AArch64::LDPDpost;
    Scale = 8;
    break;
  case AArch64::LDPQi:
    NewOpc = AArch64::LDPQpost;
    Scale = 16;
    break;
  case AArch64::LDRXui:
    NewOpc = AArch64::LDRXpost;
    break;
  case AArch64::LDRDui:
    NewOpc = AArch64::LDRDpost;
    break;
  case AArch64::LDRQui:
    NewOpc = AArch64::LDRQpost;
    break;
  }

  MachineInstrBuilder MIB = BuildMI(MBB, MBBI, DL, TII->get(NewOpc));
  MIB.addReg(AArch64::SP, RegState::Define);

  // Copy all operands other than the immediate offset.
  unsigned OpndIdx = 0;
  for (unsigned OpndEnd = MBBI->getNumOperands() - 1; OpndIdx < OpndEnd;
       ++OpndIdx)
    MIB.add(MBBI->getOperand(OpndIdx));

  assert(MBBI->getOperand(OpndIdx).getImm() == 0 &&
         "Unexpected immediate offset in first/last callee-save save/restore "
         "instruction!");
  assert(MBBI->getOperand(OpndIdx - 1).getReg() == AArch64::SP &&
         "Unexpected base register in callee-save save/restore instruction!");
  // Last operand is immediate offset that needs fixing.
  assert(CSStackSizeInc % Scale == 0);
  MIB.addImm(CSStackSizeInc / Scale);

  MIB.setMIFlags(MBBI->getFlags());
  MIB.setMemRefs(MBBI->memoperands_begin(), MBBI->memoperands_end());

  return std::prev(MBB.erase(MBBI));
}

// Fixup callee-save register save/restore instructions to take into account
// combined SP bump by adding the local stack size to the stack offsets.
static void fixupCalleeSaveRestoreStackOffset(MachineInstr &MI,
                                              unsigned LocalStackSize) {
  unsigned Opc = MI.getOpcode();
  (void)Opc;
  unsigned Scale;
  switch (Opc) {
  case AArch64::STPXi:
  case AArch64::STRXui:
  case AArch64::STPDi:
  case AArch64::STRDui:
  case AArch64::LDPXi:
  case AArch64::LDRXui:
  case AArch64::LDPDi:
  case AArch64::LDRDui:
    Scale = 8;
    break;
  case AArch64::STPQi:
  case AArch64::STRQui:
  case AArch64::LDPQi:
  case AArch64::LDRQui:
    Scale = 16;
    break;
  default:
    llvm_unreachable("Unexpected callee-save save/restore opcode!");
  }

  unsigned OffsetIdx = MI.getNumExplicitOperands() - 1;
  assert(MI.getOperand(OffsetIdx - 1).getReg() == AArch64::SP &&
         "Unexpected base register in callee-save save/restore instruction!");
  // Last operand is immediate offset that needs fixing.
  MachineOperand &OffsetOpnd = MI.getOperand(OffsetIdx);
  // All generated opcodes have scaled offsets.
  assert(LocalStackSize % 16 == 0);
  OffsetOpnd.setImm(OffsetOpnd.getImm() + LocalStackSize / Scale);
}

void AArch64FrameLowering::emitPrologue(MachineFunction &MF,
                                        MachineBasicBlock &MBB) const {
  MachineBasicBlock::iterator MBBI = MBB.begin();
  const MachineFrameInfo &MFI = MF.getFrameInfo();
  const Function *Fn = MF.getFunction();
  const AArch64Subtarget &Subtarget = MF.getSubtarget<AArch64Subtarget>();
  const AArch64RegisterInfo *RegInfo = Subtarget.getRegisterInfo();
  const TargetInstrInfo *TII = Subtarget.getInstrInfo();
  MachineModuleInfo &MMI = MF.getMMI();
  AArch64FunctionInfo *AFI = MF.getInfo<AArch64FunctionInfo>();
  bool needsFrameMoves = MMI.hasDebugInfo() || Fn->needsUnwindTableEntry();
  bool HasFP = hasFP(MF);

  // Debug location must be unknown since the first debug location is used
  // to determine the end of the prologue.
  DebugLoc DL;

  // All calls are tail calls in GHC calling conv, and functions have no
  // prologue/epilogue.
  if (MF.getFunction()->getCallingConv() == CallingConv::GHC)
    return;

  int NumBytes = (int)MFI.getStackSize();
  if (!AFI->hasStackFrame()) {
    assert(!HasFP && "unexpected function without stack frame but with FP");

    // All of the stack allocation is for locals.
    AFI->setLocalStackSize(NumBytes);

    if (!NumBytes)
      return;
    // REDZONE: If the stack size is less than 128 bytes, we don't need
    // to actually allocate.
    if (canUseRedZone(MF))
      ++NumRedZoneFunctions;
    else {
      emitFrameOffset(MBB, MBBI, DL, AArch64::SP, AArch64::SP, -NumBytes, TII,
                      MachineInstr::FrameSetup);

      // Label used to tie together the PROLOG_LABEL and the MachineMoves.
      MCSymbol *FrameLabel = MMI.getContext().createTempSymbol();
      // Encode the stack size of the leaf function.
      unsigned CFIIndex = MF.addFrameInst(
          MCCFIInstruction::createDefCfaOffset(FrameLabel, -NumBytes));
      BuildMI(MBB, MBBI, DL, TII->get(TargetOpcode::CFI_INSTRUCTION))
          .addCFIIndex(CFIIndex)
          .setMIFlags(MachineInstr::FrameSetup);
    }
    return;
  }

  bool IsWin64 =
      Subtarget.isCallingConvWin64(MF.getFunction()->getCallingConv());
  unsigned FixedObject = IsWin64 ? alignTo(AFI->getVarArgsGPRSize(), 16) : 0;

  auto PrologueSaveSize = AFI->getCalleeSavedStackSize() + FixedObject;
  // All of the remaining stack allocations are for locals.
  AFI->setLocalStackSize(NumBytes - PrologueSaveSize);

  int OverlapOffset = 0;
  const SmallVectorImpl<StackRegion *> &StackRegions = MFI.getStackRegions();
  if (StackRegions.size()) {
    assert(StackRegions.size() == 2 &&
           "Two StackRegions expected for SVE predicates and vectors");

    SVEVecStackRegion *Pred =
        static_cast<SVEVecStackRegion *>(StackRegions[0]);
    SVEVecStackRegion *Vec =
        static_cast<SVEVecStackRegion *>(StackRegions[1]);

    // Insert SVE Stack Region before local region
    uint64_t AddedSize = 0;
    Vec->emitPrologue(MF, MBB, MBBI, DL, AddedSize, AArch64::SP,
                      Vec->getRegionSize());
    Pred->emitPrologue(MF, MBB, MBBI, DL, AddedSize, AArch64::SP,
                       Pred->getRegionSize());

    // If the functions above did not allocate all the space, do it here.
    if (AddedSize)
      SVEVecStackRegion::adjustRegBySVE(
          MF, MBB, MBBI, DL, AArch64::SP, AddedSize,
          /*IsPositiveOffset=*/false, /*KillBaseReg=*/true, /*Dst=*/AArch64::SP);

    // EXTRASTACKREGION: The extra region overlaps with the area to save the
    // previous frame pointer and link register, so we need to reduce the change
    // to the stack pointer such that the last store will overlap.
    if (hasFP(MF) && (Vec->getRegionSize() > 0 || Pred->getRegionSize() > 0))
        OverlapOffset = 16;
  }

  bool CombineSPBump = shouldCombineCSRLocalStackBump(MF, NumBytes);
  if (CombineSPBump) {
    emitFrameOffset(MBB, MBBI, DL, AArch64::SP, AArch64::SP,
                    -NumBytes + OverlapOffset, TII, MachineInstr::FrameSetup);
    NumBytes = 0;
  } else if (PrologueSaveSize != 0) {
    MBBI = convertCalleeSaveRestoreToSPPrePostIncDec(MBB, MBBI, DL, TII,
                                             -PrologueSaveSize + OverlapOffset);
    NumBytes -= PrologueSaveSize;
  }
  assert(NumBytes >= 0 && "Negative stack allocation size!?");

  // Move past the saves of the callee-saved registers, fixing up the offsets
  // and pre-inc if we decided to combine the callee-save and local stack
  // pointer bump above.
  MachineBasicBlock::iterator End = MBB.end();
  while (MBBI != End && MBBI->getFlag(MachineInstr::FrameSetup)) {
    if (CombineSPBump)
      fixupCalleeSaveRestoreStackOffset(*MBBI, AFI->getLocalStackSize());
    ++MBBI;
  }
  if (HasFP) {
    // Only set up FP if we actually need to. Frame pointer is fp =
    // sp - fixedobject - 16.
    int FPOffset = AFI->getCalleeSavedStackSize() - 16;
    if (CombineSPBump)
      FPOffset += AFI->getLocalStackSize();

    // Issue    sub fp, sp, FPOffset or
    //          mov fp,sp          when FPOffset is zero.
    // Note: All stores of callee-saved registers are marked as "FrameSetup".
    // This code marks the instruction(s) that set the FP also.
    emitFrameOffset(MBB, MBBI, DL, AArch64::FP, AArch64::SP, FPOffset, TII,
                    MachineInstr::FrameSetup);
  }

  // Allocate space for the rest of the frame.
  if (NumBytes) {
    const bool NeedsRealignment = RegInfo->needsStackRealignment(MF);
    unsigned scratchSPReg = AArch64::SP;

    if (NeedsRealignment) {
      scratchSPReg = findScratchNonCalleeSaveRegister(&MBB);
      assert(scratchSPReg != AArch64::NoRegister);
    }

    // If we're a leaf function, try using the red zone.
    if (!canUseRedZone(MF))
      // FIXME: in the case of dynamic re-alignment, NumBytes doesn't have
      // the correct value here, as NumBytes also includes padding bytes,
      // which shouldn't be counted here.
      emitFrameOffset(MBB, MBBI, DL, scratchSPReg, AArch64::SP, -NumBytes, TII,
                      MachineInstr::FrameSetup);

    if (NeedsRealignment) {
      const unsigned Alignment = MFI.getMaxAlignment();
      const unsigned NrBitsToZero = countTrailingZeros(Alignment);
      assert(NrBitsToZero > 1);
      assert(scratchSPReg != AArch64::SP);

      // SUB X9, SP, NumBytes
      //   -- X9 is temporary register, so shouldn't contain any live data here,
      //   -- free to use. This is already produced by emitFrameOffset above.
      // AND SP, X9, 0b11111...0000
      // The logical immediates have a non-trivial encoding. The following
      // formula computes the encoded immediate with all ones but
      // NrBitsToZero zero bits as least significant bits.
      uint32_t andMaskEncoded = (1 << 12)                         // = N
                                | ((64 - NrBitsToZero) << 6)      // immr
                                | ((64 - NrBitsToZero - 1) << 0); // imms

      BuildMI(MBB, MBBI, DL, TII->get(AArch64::ANDXri), AArch64::SP)
          .addReg(scratchSPReg, RegState::Kill)
          .addImm(andMaskEncoded);
      AFI->setStackRealigned(true);
    }
  }

  // If we need a base pointer, set it up here. It's whatever the value of the
  // stack pointer is at this point. Any variable size objects will be allocated
  // after this, so we can still use the base pointer to reference locals.
  //
  // FIXME: Clarify FrameSetup flags here.
  // Note: Use emitFrameOffset() like above for FP if the FrameSetup flag is
  // needed.
  if (RegInfo->hasBasePointer(MF)) {
    TII->copyPhysReg(MBB, MBBI, DL, RegInfo->getBaseRegister(), AArch64::SP,
                     false);
  }

  if (needsFrameMoves) {
    const DataLayout &TD = MF.getDataLayout();
    const int StackGrowth = -TD.getPointerSize(0);
    unsigned FramePtr = RegInfo->getFrameRegister(MF);
    // An example of the prologue:
    //
    //     .globl __foo
    //     .align 2
    //  __foo:
    // Ltmp0:
    //     .cfi_startproc
    //     .cfi_personality 155, ___gxx_personality_v0
    // Leh_func_begin:
    //     .cfi_lsda 16, Lexception33
    //
    //     stp  xa,bx, [sp, -#offset]!
    //     ...
    //     stp  x28, x27, [sp, #offset-32]
    //     stp  fp, lr, [sp, #offset-16]
    //     add  fp, sp, #offset - 16
    //     sub  sp, sp, #1360
    //
    // The Stack:
    //       +-------------------------------------------+
    // 10000 | ........ | ........ | ........ | ........ |
    // 10004 | ........ | ........ | ........ | ........ |
    //       +-------------------------------------------+
    // 10008 | ........ | ........ | ........ | ........ |
    // 1000c | ........ | ........ | ........ | ........ |
    //       +===========================================+
    // 10010 |                X28 Register               |
    // 10014 |                X28 Register               |
    //       +-------------------------------------------+
    // 10018 |                X27 Register               |
    // 1001c |                X27 Register               |
    //       +===========================================+
    // 10020 |                Frame Pointer              |
    // 10024 |                Frame Pointer              |
    //       +-------------------------------------------+
    // 10028 |                Link Register              |
    // 1002c |                Link Register              |
    //       +===========================================+
    // 10030 | ........ | ........ | ........ | ........ |
    // 10034 | ........ | ........ | ........ | ........ |
    //       +-------------------------------------------+
    // 10038 | ........ | ........ | ........ | ........ |
    // 1003c | ........ | ........ | ........ | ........ |
    //       +-------------------------------------------+
    //
    //     [sp] = 10030        ::    >>initial value<<
    //     sp = 10020          ::  stp fp, lr, [sp, #-16]!
    //     fp = sp == 10020    ::  mov fp, sp
    //     [sp] == 10020       ::  stp x28, x27, [sp, #-16]!
    //     sp == 10010         ::    >>final value<<
    //
    // The frame pointer (w29) points to address 10020. If we use an offset of
    // '16' from 'w29', we get the CFI offsets of -8 for w30, -16 for w29, -24
    // for w27, and -32 for w28:
    //
    //  Ltmp1:
    //     .cfi_def_cfa w29, 16
    //  Ltmp2:
    //     .cfi_offset w30, -8
    //  Ltmp3:
    //     .cfi_offset w29, -16
    //  Ltmp4:
    //     .cfi_offset w27, -24
    //  Ltmp5:
    //     .cfi_offset w28, -32

    uint64_t TotalSVESize = 0;
    const SmallVectorImpl<StackRegion *> &StackRegions = MFI.getStackRegions();
    if (StackRegions.size()) {
      SVEVecStackRegion *Pred =
          static_cast<SVEVecStackRegion *>(StackRegions[0]);
      SVEVecStackRegion *Vec =
          static_cast<SVEVecStackRegion *>(StackRegions[1]);
      TotalSVESize = (Vec->getRegionSize() + Pred->getRegionSize());
    }

    if (HasFP) {
      unsigned Reg = RegInfo->getDwarfRegNum(FramePtr, true);
      unsigned CFIIndex = MF.addFrameInst(
                             MCCFIInstruction::createDefCfa(nullptr, Reg,
                                         2 * StackGrowth - FixedObject));

      // Define the current CFA rule to use the provided FP.
      BuildMI(MBB, MBBI, DL, TII->get(TargetOpcode::CFI_INSTRUCTION))
          .addCFIIndex(CFIIndex)
          .setMIFlags(MachineInstr::FrameSetup);
    } else {
      unsigned CFIIndex;
      if (TotalSVESize) {
        unsigned DwarfBReg = RegInfo->getDwarfRegNum(AArch64::SP, true);
        unsigned VG = RegInfo->getDwarfRegNum(AArch64::VG, true);
        std::string Comment;
        raw_string_ostream CommentOS(Comment);
        CommentOS << "cfa = "
                  << RegInfo->getName(AArch64::SP) << " + "
                  << MFI.getStackSize() << " + "
                  << RegInfo->getName(AArch64::VG) << " * "
                  << (TotalSVESize/2);
        CFIIndex = MF.addFrameInst(
            MCCFIInstruction::createScaledDefCfaOffset(nullptr, DwarfBReg,
                                                       MFI.getStackSize(),
                                                       VG, TotalSVESize / 2,
                                                       CommentOS.str()));
      } else {
        CFIIndex = MF.addFrameInst(
            MCCFIInstruction::createDefCfaOffset(nullptr, -MFI.getStackSize()));
      }

      // Encode the stack size of the leaf function.
      BuildMI(MBB, MBBI, DL, TII->get(TargetOpcode::CFI_INSTRUCTION))
          .addCFIIndex(CFIIndex)
          .setMIFlags(MachineInstr::FrameSetup);
    }

    // Now emit the moves for whatever callee saved regs we have (including FP,
    // LR if those are saved).
    emitCalleeSavedFrameMoves(MBB, MBBI, (!TotalSVESize || HasFP) ?
                                           0 : MFI.getStackSize());

    if (StackRegions.size()) {
      SVEVecStackRegion *Pred =
          static_cast<SVEVecStackRegion *>(StackRegions[0]);
      SVEVecStackRegion *Vec =
          static_cast<SVEVecStackRegion *>(StackRegions[1]);

      // Also do this separately for the SVE regions, which need a complex
      // expression using VG (Vector Granule) to calculate the offset to
      // the saved SVE registers.
      unsigned SP = AArch64::SP;
      unsigned Basereg = HasFP ? FramePtr : SP;
      int64_t UnscaledOffset = HasFP ? 0 : MFI.getStackSize();
      Vec->emitCFI(MBB, MBBI, Basereg, UnscaledOffset, TotalSVESize);
      Pred->emitCFI(MBB, MBBI, Basereg, UnscaledOffset, Pred->getRegionSize());
    }
  }
}

void AArch64FrameLowering::emitEpilogue(MachineFunction &MF,
                                        MachineBasicBlock &MBB) const {
  MachineBasicBlock::iterator MBBI = MBB.getLastNonDebugInstr();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  const AArch64Subtarget &Subtarget = MF.getSubtarget<AArch64Subtarget>();
  const TargetInstrInfo *TII = Subtarget.getInstrInfo();
  DebugLoc DL;
  bool IsTailCallReturn = false;
  if (MBB.end() != MBBI) {
    DL = MBBI->getDebugLoc();
    unsigned RetOpcode = MBBI->getOpcode();
    IsTailCallReturn = RetOpcode == AArch64::TCRETURNdi ||
      RetOpcode == AArch64::TCRETURNri;
  }
  int NumBytes = MFI.getStackSize();
  const AArch64FunctionInfo *AFI = MF.getInfo<AArch64FunctionInfo>();

  // All calls are tail calls in GHC calling conv, and functions have no
  // prologue/epilogue.
  if (MF.getFunction()->getCallingConv() == CallingConv::GHC)
    return;

  // Initial and residual are named for consistency with the prologue. Note that
  // in the epilogue, the residual adjustment is executed first.
  uint64_t ArgumentPopSize = 0;
  if (IsTailCallReturn) {
    MachineOperand &StackAdjust = MBBI->getOperand(1);

    // For a tail-call in a callee-pops-arguments environment, some or all of
    // the stack may actually be in use for the call's arguments, this is
    // calculated during LowerCall and consumed here...
    ArgumentPopSize = StackAdjust.getImm();
  } else {
    // ... otherwise the amount to pop is *all* of the argument space,
    // conveniently stored in the MachineFunctionInfo by
    // LowerFormalArguments. This will, of course, be zero for the C calling
    // convention.
    ArgumentPopSize = AFI->getArgumentStackToRestore();
  }

  // The stack frame should be like below,
  //
  //      ----------------------                     ---
  //      |                    |                      |
  //      | BytesInStackArgArea|              CalleeArgStackSize
  //      | (NumReusableBytes) |                (of tail call)
  //      |                    |                     ---
  //      |                    |                      |
  //      ---------------------|        ---           |
  //      |                    |         |            |
  //      |   CalleeSavedReg   |         |            |
  //      | (CalleeSavedStackSize)|      |            |
  //      |                    |         |            |
  //      ---------------------|         |         NumBytes
  //      |                    |     StackSize  (StackAdjustUp)
  //      |   LocalStackSize   |         |            |
  //      | (covering callee   |         |            |
  //      |       args)        |         |            |
  //      |                    |         |            |
  //      ----------------------        ---          ---
  //
  // So NumBytes = StackSize + BytesInStackArgArea - CalleeArgStackSize
  //             = StackSize + ArgumentPopSize
  //
  // AArch64TargetLowering::LowerCall figures out ArgumentPopSize and keeps
  // it as the 2nd argument of AArch64ISD::TC_RETURN.

  bool IsWin64 =
      Subtarget.isCallingConvWin64(MF.getFunction()->getCallingConv());
  unsigned FixedObject = IsWin64 ? alignTo(AFI->getVarArgsGPRSize(), 16) : 0;

  auto PrologueSaveSize = AFI->getCalleeSavedStackSize() + FixedObject;
  bool CombineSPBump = shouldCombineCSRLocalStackBump(MF, NumBytes);

  // Remove the SVE region as well
  int OverlapOffset = 0;
  const SmallVectorImpl<StackRegion *> &StackRegions = MFI.getStackRegions();
  if (StackRegions.size()) {
    assert(StackRegions.size() == 2 && "Two StackRegions expected for SVE"
                                       "predicates and vectors");
    SVEVecStackRegion *Pred =
        static_cast<SVEVecStackRegion *>(StackRegions[0]);
    SVEVecStackRegion *Vec =
        static_cast<SVEVecStackRegion *>(StackRegions[1]);

    // EXTRASTACKREGION: The extra region overlaps with the area to save the
    // previous frame pointer and link register, so we need to reduce the change
    // to the stack pointer to match the change from the spill code above. The
    // first load will be in the overlap area.
    if (hasFP(MF) && (Vec->getRegionSize() > 0 || Pred->getRegionSize() > 0))
        OverlapOffset = 16;
  }

  if (!CombineSPBump && PrologueSaveSize != 0)
    convertCalleeSaveRestoreToSPPrePostIncDec(
        MBB, std::prev(MBB.getFirstTerminator()), DL, TII,
                       PrologueSaveSize - OverlapOffset);

  // Move past the restores of the callee-saved registers.
  MachineBasicBlock::iterator LastPopI = MBB.getFirstTerminator();
  MachineBasicBlock::iterator Begin = MBB.begin();
  while (LastPopI != Begin) {
    --LastPopI;
    if (!LastPopI->getFlag(MachineInstr::FrameDestroy)) {
      ++LastPopI;
      break;
    } else if (CombineSPBump)
      fixupCalleeSaveRestoreStackOffset(*LastPopI, AFI->getLocalStackSize());
  }

  // If there is a single SP update, insert it before the ret and we're done.
  if (CombineSPBump) {
    emitFrameOffset(MBB, MBB.getFirstTerminator(), DL, AArch64::SP, AArch64::SP,
                    NumBytes + ArgumentPopSize - OverlapOffset, TII,
                    MachineInstr::FrameDestroy);
    return;
  }

  NumBytes -= PrologueSaveSize;
  assert(NumBytes >= 0 && "Negative stack allocation size!?");

  if (!hasFP(MF)) {
    bool RedZone = canUseRedZone(MF);
    // If this was a redzone leaf function, we don't need to restore the
    // stack pointer (but we may need to pop stack args for fastcc).
    if (RedZone && ArgumentPopSize == 0)
      return;

    bool NoCalleeSaveRestore = PrologueSaveSize == 0;
    int StackRestoreBytes = RedZone ? 0 : NumBytes;
    if (NoCalleeSaveRestore)
      StackRestoreBytes += ArgumentPopSize;
    emitFrameOffset(MBB, LastPopI, DL, AArch64::SP, AArch64::SP,
                    StackRestoreBytes, TII, MachineInstr::FrameDestroy);
    // If we were able to combine the local stack pop with the argument pop,
    // then we're done.
    if (!hasVarSizedRegions(MF))
      if (NoCalleeSaveRestore || ArgumentPopSize == 0)
        return;
    NumBytes = 0;
  }

  // Restore the original stack pointer.
  // FIXME: Rather than doing the math here, we should instead just use
  // non-post-indexed loads for the restores if we aren't actually going to
  // be able to save any instructions.
  if (MFI.hasVarSizedObjects() || AFI->isStackRealigned())
    emitFrameOffset(MBB, LastPopI, DL, AArch64::SP, AArch64::FP,
                    -AFI->getCalleeSavedStackSize() + 16, TII,
                    MachineInstr::FrameDestroy);
  else if (NumBytes)
    emitFrameOffset(MBB, LastPopI, DL, AArch64::SP, AArch64::SP, NumBytes, TII,
                    MachineInstr::FrameDestroy);

  // This must be placed after the callee-save restore code because that code
  // assumes the SP is at the same location as it was after the callee-save save
  // code in the prologue.
  if (ArgumentPopSize)
    emitFrameOffset(MBB, MBB.getFirstTerminator(), DL, AArch64::SP, AArch64::SP,
                    ArgumentPopSize, TII, MachineInstr::FrameDestroy);

  uint64_t AddedSize = 0;
  unsigned Basereg = AArch64::SP;
  MachineBasicBlock::iterator TermI = MBB.getFirstTerminator();

  if (StackRegions.size()) {
    SVEVecStackRegion *Pred = static_cast<SVEVecStackRegion *>(StackRegions[0]);
    SVEVecStackRegion *Vec = static_cast<SVEVecStackRegion *>(StackRegions[1]);
    Pred->emitEpilogue(MF, MBB, TermI, DL, AddedSize, Basereg, Pred->getRegionSize());
    Vec->emitEpilogue(MF, MBB, TermI, DL, AddedSize, Basereg, Vec->getRegionSize());

    // Deallocate SVE region (if not completed yet)
    if (Basereg != AArch64::SP || AddedSize)
      SVEVecStackRegion::adjustRegBySVE(MF, MBB, TermI, DL, Basereg, AddedSize,
                                            /*IsPositiveOffset=*/true,
                                            /*KillBaseReg=*/true,
                                            /*Dst=*/AArch64::SP);
  }
}

/// getFrameIndexReference - Provide a base+offset reference to an FI slot for
/// debug info.  It's the same as what we use for resolving the code-gen
/// references for now.  FIXME: This can go wrong when references are
/// SP-relative and simple call frames aren't used.
int AArch64FrameLowering::getFrameIndexReference(const MachineFunction &MF,
                                                 int FI,
                                                 unsigned &FrameReg) const {
  int ScaledOffset;
  return resolveFrameIndexReference(MF, FI, FrameReg, ScaledOffset);
}

int AArch64FrameLowering::resolveFrameIndexReference(const MachineFunction &MF,
                                                     int FI, unsigned &FrameReg,
                                                     int &ScaledOffset,
                                                     bool PreferFP) const {
  const MachineFrameInfo &MFI = MF.getFrameInfo();
  const AArch64RegisterInfo *RegInfo = static_cast<const AArch64RegisterInfo *>(
      MF.getSubtarget().getRegisterInfo());
  const AArch64FunctionInfo *AFI = MF.getInfo<AArch64FunctionInfo>();
  const AArch64Subtarget &Subtarget = MF.getSubtarget<AArch64Subtarget>();
  bool IsWin64 =
      Subtarget.isCallingConvWin64(MF.getFunction()->getCallingConv());
  unsigned FixedObject = IsWin64 ? alignTo(AFI->getVarArgsGPRSize(), 16) : 0;
  int FPOffset = MFI.getObjectOffset(FI) + FixedObject + 16;
  int Offset = MFI.getObjectOffset(FI) + MFI.getStackSize();
  bool isFixed = MFI.isFixedObjectIndex(FI);

  ScaledOffset = 0;
  if (StackRegion *SR = MFI.getObjectRegion(FI)) {
    ScaledOffset =
        static_cast<SVEVecStackRegion *>(SR)
          ->resolveFrameIndexReference(MF, FI, FrameReg);
    if (FrameReg == AArch64::SP && MFI.getStackSize())
      return MFI.getStackSize();
    return 0;
  }

  // Use frame pointer to reference fixed objects. Use it for locals if
  // there are VLAs or a dynamically realigned SP (and thus the SP isn't
  // reliable as a base). Make sure useFPForScavengingIndex() does the
  // right thing for the emergency spill slot.
  bool UseFP = false;
  if (AFI->hasStackFrame()) {
    // Note: Keeping the following as multiple 'if' statements rather than
    // merging to a single expression for readability.
    //
    // Argument access should always use the FP.
    if (isFixed) {
      UseFP = hasFP(MF);
    } else if (hasFP(MF) && !RegInfo->hasBasePointer(MF) &&
               !RegInfo->needsStackRealignment(MF)) {
      // Use SP or FP, whichever gives us the best chance of the offset
      // being in range for direct access. If the FPOffset is positive,
      // that'll always be best, as the SP will be even further away.
      // If the FPOffset is negative, we have to keep in mind that the
      // available offset range for negative offsets is smaller than for
      // positive ones. If we have variable sized objects, we're stuck with
      // using the FP regardless, though, as the SP offset is unknown
      // and we don't have a base pointer available. If an offset is
      // available via the FP and the SP, use whichever is closest.
      if (PreferFP || MFI.hasVarSizedObjects() ||
          FPOffset >= 0 || (FPOffset >= -256 && Offset > -FPOffset))
        UseFP = true;
    }
  }

  assert((isFixed || !RegInfo->needsStackRealignment(MF) || !UseFP) &&
         "In the presence of dynamic stack pointer realignment, "
         "non-argument objects cannot be accessed through the frame pointer");

  if (hasVarSizedRegions(MF) && isFixed) {
    uint64_t RegionsSize = MFI.getStackRegions()[0]->getRegionSize() +
                           MFI.getStackRegions()[1]->getRegionSize();
    if (UseFP && RegionsSize)
      FPOffset -= 16;
    ScaledOffset = RegionsSize;
  }

  if (UseFP) {
    FrameReg = RegInfo->getFrameRegister(MF);
    return FPOffset;
  }

  // Use the base pointer if we have one.
  if (RegInfo->hasBasePointer(MF))
    FrameReg = RegInfo->getBaseRegister();
  else {
    FrameReg = AArch64::SP;
    // If we're using the red zone for this function, the SP won't actually
    // be adjusted, so the offsets will be negative. They're also all
    // within range of the signed 9-bit immediate instructions.
    if (canUseRedZone(MF))
      Offset -= AFI->getLocalStackSize();
  }

  return Offset;
}

static unsigned getPrologueDeath(MachineFunction &MF, unsigned Reg) {
  // Do not set a kill flag on values that are also marked as live-in. This
  // happens with the @llvm-returnaddress intrinsic and with arguments passed in
  // callee saved registers.
  // Omitting the kill flags is conservatively correct even if the live-in
  // is not used after all.
  bool IsLiveIn = MF.getRegInfo().isLiveIn(Reg);
  return getKillRegState(!IsLiveIn);
}

static bool produceCompactUnwindFrame(MachineFunction &MF) {
  const AArch64Subtarget &Subtarget = MF.getSubtarget<AArch64Subtarget>();
  AttributeList Attrs = MF.getFunction()->getAttributes();
  return Subtarget.isTargetMachO() &&
         !(Subtarget.getTargetLowering()->supportSwiftError() &&
           Attrs.hasAttrSomewhere(Attribute::SwiftError));
}

namespace {

struct RegPairInfo {
  unsigned Reg1 = AArch64::NoRegister;
  unsigned Reg2 = AArch64::NoRegister;
  int FrameIdx;
  int Offset;
  enum RegType { GPR, FPR64, FPR128 } Type;

  RegPairInfo() = default;

  bool isPaired() const { return Reg2 != AArch64::NoRegister; }
};

} // end anonymous namespace

static void computeCalleeSaveRegisterPairs(
    MachineFunction &MF, const std::vector<CalleeSavedInfo> &CSI,
    const TargetRegisterInfo *TRI, SmallVectorImpl<RegPairInfo> &RegPairs) {

  if (CSI.empty())
    return;

  AArch64FunctionInfo *AFI = MF.getInfo<AArch64FunctionInfo>();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  CallingConv::ID CC = MF.getFunction()->getCallingConv();
  unsigned Count = CSI.size();
  (void)CC;
  // MachO's compact unwind format relies on all registers being stored in
  // pairs.
  assert((!produceCompactUnwindFrame(MF) ||
          CC == CallingConv::PreserveMost ||
          (Count & 1) == 0) &&
         "Odd number of callee-saved regs to spill!");
  int Offset = AFI->getCalleeSavedStackSize();

  for (unsigned i = 0; i < Count; ++i) {
    RegPairInfo RPI;
    RPI.Reg1 = CSI[i].getReg();

    assert(AArch64::GPR64RegClass.contains(RPI.Reg1) ||
           AArch64::FPR64RegClass.contains(RPI.Reg1) ||
           AArch64::FPR128RegClass.contains(RPI.Reg1));
    if (AArch64::GPR64RegClass.contains(RPI.Reg1))
      RPI.Type = RegPairInfo::GPR;
    else if (AArch64::FPR64RegClass.contains(RPI.Reg1))
      RPI.Type = RegPairInfo::FPR64;
    else
      RPI.Type = RegPairInfo::FPR128;

    // Add the next reg to the pair if it is in the same register class.
    if (i + 1 < Count) {
      unsigned NextReg = CSI[i + 1].getReg();
      switch (RPI.Type) {
      case RegPairInfo::GPR:
        if (AArch64::GPR64RegClass.contains(NextReg))
          RPI.Reg2 = NextReg;
        break;
      case RegPairInfo::FPR64:
        if (AArch64::FPR64RegClass.contains(NextReg))
          RPI.Reg2 = NextReg;
        break;
      case RegPairInfo::FPR128:
        if (AArch64::FPR128RegClass.contains(NextReg))
          RPI.Reg2 = NextReg;
        break;
      }
    }

    // GPRs and FPRs are saved in pairs of 64-bit regs. We expect the CSI
    // list to come in sorted by frame index so that we can issue the store
    // pair instructions directly. Assert if we see anything otherwise.
    //
    // The order of the registers in the list is controlled by
    // getCalleeSavedRegs(), so they will always be in-order, as well.
    assert((!RPI.isPaired() ||
            (CSI[i].getFrameIdx() + 1 == CSI[i + 1].getFrameIdx())) &&
           "Out of order callee saved regs!");

    // MachO's compact unwind format relies on all registers being stored in
    // adjacent register pairs.
    assert((!produceCompactUnwindFrame(MF) ||
            CC == CallingConv::PreserveMost ||
            (RPI.isPaired() &&
             ((RPI.Reg1 == AArch64::LR && RPI.Reg2 == AArch64::FP) ||
              RPI.Reg1 + 1 == RPI.Reg2))) &&
           "Callee-save registers not saved as adjacent register pair!");

    RPI.FrameIdx = CSI[i].getFrameIdx();

    int Scale = RPI.Type == RegPairInfo::FPR128 ? 16 : 8;
    Offset -= RPI.isPaired() ? 2 * Scale : Scale;

    // Round up size of non-pair to pair size if we need to pad the
    // callee-save area to ensure 16-byte alignment.
    if (AFI->hasCalleeSaveStackFreeSpace() &&
        RPI.Type != RegPairInfo::FPR128 && !RPI.isPaired()) {
      Offset -= 8;
      assert(Offset % 16 == 0);
      assert(MFI.getObjectAlignment(RPI.FrameIdx) <= 16);
      MFI.setObjectAlignment(RPI.FrameIdx, 16);
    }

    assert(Offset % Scale == 0);
    RPI.Offset = Offset / Scale;
    assert((RPI.Offset >= -64 && RPI.Offset <= 63) &&
           "Offset out of bounds for LDP/STP immediate");

    RegPairs.push_back(RPI);
    if (RPI.isPaired())
      ++i;
  }
}

bool AArch64FrameLowering::spillCalleeSavedRegisters(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
    const std::vector<CalleeSavedInfo> &CSIWithSVE,
    const TargetRegisterInfo *TRI) const {
  MachineFunction &MF = *MBB.getParent();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
  DebugLoc DL;

  // Create a temporary list of CSRs, where we have removed the SVE CSRs.
  std::vector<CalleeSavedInfo> CSI;
  for (unsigned i = 0; i < CSIWithSVE.size(); ++i) {
    if (MFI.getStackRegionToHandleCSR(CSIWithSVE[i].getReg()) != nullptr)
      continue;
    CSI.push_back(CSIWithSVE[i]);
  }

  SmallVector<RegPairInfo, 8> RegPairs;

  computeCalleeSaveRegisterPairs(MF, CSI, TRI, RegPairs);
  const MachineRegisterInfo &MRI = MF.getRegInfo();

  for (auto RPII = RegPairs.rbegin(), RPIE = RegPairs.rend(); RPII != RPIE;
       ++RPII) {
    RegPairInfo RPI = *RPII;
    unsigned Reg1 = RPI.Reg1;
    unsigned Reg2 = RPI.Reg2;
    unsigned StrOpc;

    // Issue sequence of spills for cs regs.  The first spill may be converted
    // to a pre-decrement store later by emitPrologue if the callee-save stack
    // area allocation can't be combined with the local stack area allocation.
    // For example:
    //    stp     x22, x21, [sp, #0]     // addImm(+0)
    //    stp     x20, x19, [sp, #16]    // addImm(+2)
    //    stp     fp, lr, [sp, #32]      // addImm(+4)
    // Rationale: This sequence saves uop updates compared to a sequence of
    // pre-increment spills like stp xi,xj,[sp,#-16]!
    // Note: Similar rationale and sequence for restores in epilog.
    unsigned Size, Align;
    switch (RPI.Type) {
    case RegPairInfo::GPR:
       StrOpc = RPI.isPaired() ? AArch64::STPXi : AArch64::STRXui;
       Size = RPI.isPaired() ? 16 : 8;
       Align = 8;
       break;
    case RegPairInfo::FPR64:
       StrOpc = RPI.isPaired() ? AArch64::STPDi : AArch64::STRDui;
       Size = RPI.isPaired() ? 16 : 8;
       Align = 8;
       break;
    case RegPairInfo::FPR128:
       StrOpc = RPI.isPaired() ? AArch64::STPQi : AArch64::STRQui;
       Size = RPI.isPaired() ? 32 : 16;
       Align = 16;
       break;
    }
    DEBUG(dbgs() << "CSR spill: (" << TRI->getName(Reg1);
          if (RPI.isPaired())
            dbgs() << ", " << TRI->getName(Reg2);
          dbgs() << ") -> fi#(" << RPI.FrameIdx;
          if (RPI.isPaired())
            dbgs() << ", " << RPI.FrameIdx+1;
          dbgs() << ")\n");

    MachineInstrBuilder MIB = BuildMI(MBB, MI, DL, TII.get(StrOpc));
    if (!MRI.isReserved(Reg1))
      MBB.addLiveIn(Reg1);
    if (RPI.isPaired()) {
      if (!MRI.isReserved(Reg2))
        MBB.addLiveIn(Reg2);
      MIB.addReg(Reg2, getPrologueDeath(MF, Reg2));
      MIB.addMemOperand(MF.getMachineMemOperand(
          MachinePointerInfo::getFixedStack(MF, RPI.FrameIdx + 1),
          MachineMemOperand::MOStore, Size, Align));
    }
    MIB.addReg(Reg1, getPrologueDeath(MF, Reg1))
        .addReg(AArch64::SP)
        .addImm(RPI.Offset) // [sp, #offset*scale],
                            // where factor*scale is implicit
        .setMIFlag(MachineInstr::FrameSetup);
    MIB.addMemOperand(MF.getMachineMemOperand(
        MachinePointerInfo::getFixedStack(MF, RPI.FrameIdx),
        MachineMemOperand::MOStore, Size, Align));
  }
  return true;
}

bool AArch64FrameLowering::restoreCalleeSavedRegisters(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
    const std::vector<CalleeSavedInfo> &CSIWithSVE,
    const TargetRegisterInfo *TRI) const {
  MachineFunction &MF = *MBB.getParent();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();

  // Create a temporary list of CSRs, where we have removed the SVE CSRs.
  std::vector<CalleeSavedInfo> CSI;
  for (unsigned i = 0; i < CSIWithSVE.size(); ++i) {
    if (MFI.getStackRegionToHandleCSR(CSIWithSVE[i].getReg()) != nullptr)
      continue;
    CSI.push_back(CSIWithSVE[i]);
  }

  DebugLoc DL;
  SmallVector<RegPairInfo, 8> RegPairs;

  if (MI != MBB.end())
    DL = MI->getDebugLoc();

  computeCalleeSaveRegisterPairs(MF, CSI, TRI, RegPairs);

  for (auto RPII = RegPairs.begin(), RPIE = RegPairs.end(); RPII != RPIE;
       ++RPII) {
    RegPairInfo RPI = *RPII;
    unsigned Reg1 = RPI.Reg1;
    unsigned Reg2 = RPI.Reg2;

    // [SVE] Only handle non-SVE spills here
    if (MFI.getStackRegionToHandleCSR(Reg1))
      continue;

    // Issue sequence of restores for cs regs. The last restore may be converted
    // to a post-increment load later by emitEpilogue if the callee-save stack
    // area allocation can't be combined with the local stack area allocation.
    // For example:
    //    ldp     fp, lr, [sp, #32]       // addImm(+4)
    //    ldp     x20, x19, [sp, #16]     // addImm(+2)
    //    ldp     x22, x21, [sp, #0]      // addImm(+0)
    // Note: see comment in spillCalleeSavedRegisters()
    unsigned LdrOpc;
    unsigned Size, Align;
    switch (RPI.Type) {
    case RegPairInfo::GPR:
       LdrOpc = RPI.isPaired() ? AArch64::LDPXi : AArch64::LDRXui;
       Size = RPI.isPaired() ? 16 : 8;
       Align = 8;
       break;
    case RegPairInfo::FPR64:
       LdrOpc = RPI.isPaired() ? AArch64::LDPDi : AArch64::LDRDui;
       Size = RPI.isPaired() ? 16 : 8;
       Align = 8;
       break;
    case RegPairInfo::FPR128:
       LdrOpc = RPI.isPaired() ? AArch64::LDPQi : AArch64::LDRQui;
       Size = RPI.isPaired() ? 32 : 16;
       Align = 16;
       break;
    }
    DEBUG(dbgs() << "CSR restore: (" << TRI->getName(Reg1);
          if (RPI.isPaired())
            dbgs() << ", " << TRI->getName(Reg2);
          dbgs() << ") -> fi#(" << RPI.FrameIdx;
          if (RPI.isPaired())
            dbgs() << ", " << RPI.FrameIdx+1;
          dbgs() << ")\n");

    MachineInstrBuilder MIB = BuildMI(MBB, MI, DL, TII.get(LdrOpc));
    if (RPI.isPaired()) {
      MIB.addReg(Reg2, getDefRegState(true));
      MIB.addMemOperand(MF.getMachineMemOperand(
          MachinePointerInfo::getFixedStack(MF, RPI.FrameIdx + 1),
          MachineMemOperand::MOLoad, Size, Align));
    }
    MIB.addReg(Reg1, getDefRegState(true))
        .addReg(AArch64::SP)
        .addImm(RPI.Offset) // [sp, #offset*scale]
                            // where factor*scale is implicit
        .setMIFlag(MachineInstr::FrameDestroy);
    MIB.addMemOperand(MF.getMachineMemOperand(
        MachinePointerInfo::getFixedStack(MF, RPI.FrameIdx),
        MachineMemOperand::MOLoad, Size, Align));
  }
  return true;
}

void AArch64FrameLowering::determineCalleeSaves(MachineFunction &MF,
                                                BitVector &SavedRegs,
                                                RegScavenger *RS) const {
  // All calls are tail calls in GHC calling conv, and functions have no
  // prologue/epilogue.
  if (MF.getFunction()->getCallingConv() == CallingConv::GHC)
    return;

  TargetFrameLowering::determineCalleeSaves(MF, SavedRegs, RS);

  const AArch64RegisterInfo *RegInfo = static_cast<const AArch64RegisterInfo *>(
      MF.getSubtarget().getRegisterInfo());
  AArch64FunctionInfo *AFI = MF.getInfo<AArch64FunctionInfo>();
  MachineFrameInfo &MFI = MF.getFrameInfo();
  unsigned UnspilledCSGPR = AArch64::NoRegister;
  unsigned UnspilledCSGPRPaired = AArch64::NoRegister;

  // The frame record needs to be created by saving the appropriate registers
  if (hasFP(MF)) {
    SavedRegs.set(AArch64::FP);
    SavedRegs.set(AArch64::LR);
  }

  unsigned BasePointerReg = AArch64::NoRegister;
  if (RegInfo->hasBasePointer(MF))
    BasePointerReg = RegInfo->getBaseRegister();

  unsigned ExtraCSSpill = 0;
  const MCPhysReg *CSRegs = RegInfo->getCalleeSavedRegs(&MF);
  // [SVE] SVE saves are handled separately by SVEVecStackRegion class
  for (unsigned i = 0; CSRegs[i]; ++i) {
    const unsigned Reg = CSRegs[i];
    if (MFI.getStackRegionToHandleCSR(Reg) != nullptr)
      SavedRegs.reset(Reg);
  }


  // Figure out which callee-saved registers to save/restore.
  for (unsigned i = 0; CSRegs[i]; ++i) {
    const unsigned Reg = CSRegs[i];

    // Add the base pointer register to SavedRegs if it is callee-save.
    if (Reg == BasePointerReg)
      SavedRegs.set(Reg);

    bool RegUsed = SavedRegs.test(Reg);
    unsigned PairedReg = CSRegs[i ^ 1];
    if (!RegUsed) {
      if (AArch64::GPR64RegClass.contains(Reg) &&
          !RegInfo->isReservedReg(MF, Reg)) {
        UnspilledCSGPR = Reg;
        UnspilledCSGPRPaired = PairedReg;
      }
      continue;
    }

    // MachO's compact unwind format relies on all registers being stored in
    // pairs.
    // FIXME: the usual format is actually better if unwinding isn't needed.
    if (produceCompactUnwindFrame(MF) && !SavedRegs.test(PairedReg)) {
      SavedRegs.set(PairedReg);
      if (AArch64::GPR64RegClass.contains(PairedReg) &&
          !RegInfo->isReservedReg(MF, PairedReg))
        ExtraCSSpill = PairedReg;
    }
  }

  DEBUG(dbgs() << "*** determineCalleeSaves\nUsed CSRs:";
        for (unsigned Reg : SavedRegs.set_bits())
          dbgs() << ' ' << PrintReg(Reg, RegInfo);
        dbgs() << "\n";);

  // If any callee-saved registers are used, the frame cannot be eliminated.
  unsigned NumRegsSpilled = SavedRegs.count();
  bool CanEliminateFrame = (NumRegsSpilled == 0) && !hasVarSizedRegions(MF);

  auto getCSStackSize = [&CSRegs, &SavedRegs]() {
    unsigned Size = 0;
    for (unsigned i = 0; CSRegs[i]; ++i)
      if (SavedRegs.test(CSRegs[i]))
        Size += (AArch64::FPR64RegClass.contains(CSRegs[i]) ||
                 AArch64::GPR64RegClass.contains(CSRegs[i]))
                    ? 8 : 16;
    return Size;
  };

  // FIXME: Set BigStack if any stack slot references may be out of range.
  // For now, just conservatively guestimate based on unscaled indexing
  // range. We'll end up allocating an unnecessary spill slot a lot, but
  // realistically that's not a big deal at this stage of the game.
  // The CSR spill slots have not been allocated yet, so estimateStackSize
  // won't include them.
  unsigned CFSize = MFI.estimateStackSize(MF) + getCSStackSize();

  // In case of SVE regions, we know a scratch register is needed
  // to calculate the address of a SVE vector on the stack when:
  //  - There is no framepointer and accessing a SVE vector requires
  //    first calculating the base of the SVE region from SP.
  //  - There *is* a framepointer and we need to step over the
  //    16 byte framerecord (x29,x30) just above FP.
  //  - The address of the furthest SVE vector would not fit the
  //    immediate field.
  uint64_t StackRegionsSize = 0;
  for (StackRegion *SR : MFI.getStackRegions()) {
    auto *SSR = static_cast<SVEVecStackRegion*>(SR);
    StackRegionsSize += SSR->estimateRegionSize(MF);
  }

  unsigned EstimatedStackSizeLimit = estimateRSStackSizeLimit(MF);
  bool BigStack = (CFSize > EstimatedStackSizeLimit) ||
                  ((StackRegionsSize/16) > 31) ||
                  (hasFP(MF) && StackRegionsSize > 0) ||
                  (!hasFP(MF) && StackRegionsSize > 0 && CFSize > 0);
  if (BigStack || !CanEliminateFrame || RegInfo->cannotEliminateFrame(MF))
    AFI->setHasStackFrame(true);

  // Estimate if we might need to scavenge a register at some point in order
  // to materialize a stack offset. If so, either spill one additional
  // callee-saved register or reserve a special spill slot to facilitate
  // register scavenging. If we already spilled an extra callee-saved register
  // above to keep the number of spills even, we don't need to do anything else
  // here.
  if (BigStack) {
    if (!ExtraCSSpill && UnspilledCSGPR != AArch64::NoRegister) {
      DEBUG(dbgs() << "Spilling " << PrintReg(UnspilledCSGPR, RegInfo)
            << " to get a scratch register.\n");
      SavedRegs.set(UnspilledCSGPR);
      // MachO's compact unwind format relies on all registers being stored in
      // pairs, so if we need to spill one extra for BigStack, then we need to
      // store the pair.
      if (produceCompactUnwindFrame(MF))
        SavedRegs.set(UnspilledCSGPRPaired);
      ExtraCSSpill = UnspilledCSGPRPaired;
      NumRegsSpilled = SavedRegs.count();
    }

    // If we didn't find an extra callee-saved register to spill, create
    // an emergency spill slot.
    if (!ExtraCSSpill || MF.getRegInfo().isPhysRegUsed(ExtraCSSpill)) {
      const TargetRegisterInfo *TRI = MF.getSubtarget().getRegisterInfo();
      const TargetRegisterClass &RC = AArch64::GPR64RegClass;
      unsigned Size = TRI->getSpillSize(RC);
      unsigned Align = TRI->getSpillAlignment(RC);
      int FI = MFI.CreateStackObject(Size, Align, false);
      RS->addScavengingFrameIndex(FI);
      DEBUG(dbgs() << "No available CS registers, allocated fi#" << FI
                   << " as the emergency spill slot.\n");
    }
  }

  // Recalculate the size of the CSRs
  unsigned CSStackSize = getCSStackSize();
  unsigned AlignedCSStackSize = alignTo(CSStackSize, 16);
  DEBUG(dbgs() << "Estimated stack frame size: "
               << MFI.estimateStackSize(MF) + AlignedCSStackSize
               << " bytes.\n");

  // Round up to register pair alignment to avoid additional SP adjustment
  // instructions.
  AFI->setCalleeSavedStackSize(AlignedCSStackSize);
  AFI->setCalleeSaveStackHasFreeSpace(AlignedCSStackSize != CSStackSize);
}

// When stack realignment is required the size of the stack frame becomes
// runtime variable. This manifests itself as a runtime variable gap between the
// local and callee-save regions. If FP is used to build the callee-save region
// then FP must be used to access any locals placed within it. This does not
// happen today causing corruption to callee saves by SP relative stores whose
// offset is calculated assuming FP-SP is a compile time constant.
//
// An option is to force all callee-save region accesses to be relative to the
// same base (SP or FP) but given the alignment is likely to reduce the benefit
// of slot scavenging it's simpler to disable the optimisation.
bool AArch64FrameLowering::enableStackSlotScavenging(
    const MachineFunction &MF) const {
  const AArch64FunctionInfo *AFI = MF.getInfo<AArch64FunctionInfo>();
  const AArch64RegisterInfo *RegInfo = static_cast<const AArch64RegisterInfo *>(
      MF.getSubtarget().getRegisterInfo());
  return AFI->hasCalleeSaveStackFreeSpace() &&
         !RegInfo->needsStackRealignment(MF);
}

bool AArch64FrameLowering::hasVarSizedRegions(const MachineFunction &MF) const {
  const SmallVectorImpl<StackRegion *> &StackRegions =
      MF.getFrameInfo().getStackRegions();

  if (StackRegions.size() == 0)
    return false;

  return StackRegions[0]->maybeUsed() || StackRegions[1]->maybeUsed();
}

void AArch64FrameLowering::registerStackRegions(MachineFunction &MF) const {
  MachineFrameInfo &MFI = MF.getFrameInfo();

  SVEVecStackRegion *Pred =
      new SVEVecStackRegion(/*IsPredicateRegion=*/true,
                              /*Name=*/"SVE Pred");
  SVEVecStackRegion *Vec =
      new SVEVecStackRegion(/*IsPredicateRegion=*/false,
                              /*Name=*/"SVE Vec");

  // [SVE] Register a new StackRegion handler for SVE
  MFI.addStackRegion(Pred);
  MFI.addStackRegion(Vec);
}

void AArch64FrameLowering::layoutStackRegions(MachineFunction &MF) const {
  const SmallVectorImpl<StackRegion *> &StackRegions =
      MF.getFrameInfo().getStackRegions();

  if (StackRegions.size() == 0)
    return;

  assert(StackRegions.size() == 2 && "Two StackRegions expected for SVE"
                                     "predicates and vectors");
  SVEVecStackRegion *Pred =
      static_cast<SVEVecStackRegion *>(StackRegions[0]);
  SVEVecStackRegion *Vec =
      static_cast<SVEVecStackRegion *>(StackRegions[1]);

  // EXTRASTACKREGION: We allocate an extra empty VL sized spill slot which is
  // overlaid by the frame-record (x29, x30) to prevent having to materialise
  // the base of the SVE region for each spill/fill by calculating (FP + 16).
  // From this, we can just access any SVE object directly from:
  //
  //      FP + (#offset + 1) * VL
  //
  // Note that this favours performance over stack size, which may change in
  // the future. The offset starts at (n x) 16 bytes and requires the size of
  // a full SVE vector, since the FP needs to be 16 byte aligned.
  //
  // If this is a leaf function (doesn't have a frame pointer) then
  // we don't need to perform this hack.
  //
  // See also AArch64RegisterInfo::eliminateFrameIndex

  bool HasFP = hasFP(MF);

  uint64_t Offset = HasFP ? 16 : 0;
  Offset  = Pred->layoutRegion(MF, Offset, 16);
  if (HasFP && (Pred->getRegionSize() > 0)) {
    Pred->setRegionSize(Pred->getRegionSize() + 16);
  }
  Vec->layoutRegion(MF, Offset, 16);
  if (HasFP && (Pred->getRegionSize() == 0 && Vec->getRegionSize() > 0))
    Vec->setRegionSize(Vec->getRegionSize() + 16);

  // The MF.VariableDbgInfo cache of debug info for each variable needs
  // to be updated separately from all DBG_VALUE instructions in the IR.
  // Here we can add the expression to get it from the VL-scaled region.
  // This may not be the best place to do this, but we need to do it
  // somehwere.
  for (auto &VI : MF.getVariableDbgInfo()) {
    if (!VI.Var)
      continue;
    unsigned FrameReg;
    int ScaledOffset;
    resolveFrameIndexReference(MF, VI.Slot, FrameReg, ScaledOffset);
    if (ScaledOffset) {
      // This code does not need to add 'DW_OP_deref' like it does in
      // AArch64RegisterInfo.cpp:eliminateFrameIndex(), because the
      // expression is interpreted more directly.
      SmallVector<uint64_t, 10> Buffer;

      const MCRegisterInfo *MRI = MF.getSubtarget().getRegisterInfo();
      unsigned VG = MRI->getDwarfRegNum(AArch64::VG, true);
      Buffer.append({dwarf::DW_OP_bregx, VG, 0});
      Buffer.append({dwarf::DW_OP_constu, (unsigned) ScaledOffset >> 1});
      Buffer.append({dwarf::DW_OP_mul, dwarf::DW_OP_plus});
      Buffer.append(VI.Expr->elements_begin(), VI.Expr->elements_end());

      auto *MD = DIExpression::get(MF.getFunction()->getContext(), Buffer);
      VI.Expr = MD;
    }
  }
}

//===-----------------------------------------------------------===//
//         SVEVecStackRegion utility functions
//===-----------------------------------------------------------===//

unsigned SVEVecStackRegion::adjustRegBySVE(MachineFunction &MF,
                                               MachineBasicBlock &MBB,
                                               MachineBasicBlock::iterator MBBI,
                                               DebugLoc DL,
                                               unsigned Basereg, uint64_t Size,
                                               bool IsPositiveOffset,
                                               bool KillBaseReg,
                                               unsigned Dst) {
  // If we write to the same register as Basereg, we always kill it.
  if (Basereg == Dst)
    KillBaseReg = true;

  // Instead of directly updating the Basereg into SP, we can also create
  // a SP' that contains the updated Basereg+Offset value. This is used
  // in the epilogue if BP+offset cannot be reached with an
  // immediate.
  if (!Dst) {
    auto *TRI = MF.getRegInfo().getTargetRegisterInfo();
    Dst = MF.getRegInfo().createVirtualRegister(&AArch64::GPR64RegClass);
    DEBUG(dbgs() << "TMP " << PrintReg(Dst, TRI)
                 << " = " << PrintReg(Basereg, TRI)
                 << (IsPositiveOffset ? " + " : " - ") << Size << "\n");
  }

  // max(abs(offset)) encodable in simm6 field
  uint64_t MaxOffset = IsPositiveOffset ? 31 : 32;

  const AArch64InstrInfo *TII =
      static_cast<const AArch64InstrInfo *>(MF.getSubtarget().getInstrInfo());

  // Create copy when Size == 0.
  if (Basereg != Dst && Size == 0) {
    BuildMI(MBB, MBBI, DL, TII->get(AArch64::ADDXri), Dst)
        .addReg(Basereg, KillBaseReg ? RegState::Kill : 0)
        .addImm(0)
        .addImm(0);
    return Dst;
  }

  assert(Size % 2 == 0 && "The number of elements should be aligned "
                          "to SVE vector or predicate length");

  // If Size is small enough, we can suffice with 1 or 2 'addvlx'
  // instructions that take immediates, rather than filling registers
  // and using a MADD instruction.
  const llvm::MCInstrDesc *Op;
  int64_t Sign = IsPositiveOffset ? 1 : -1;

  if (Size % 16 == 0) {
    Size = Size / 16;
    Op = &TII->get(AArch64::ADDVL_XXI);
  } else {
    Size = Size / 2;
    Op = &TII->get(AArch64::ADDPL_XXI);
  }

  // Loop while subtracting chunks of immediate from Offset,
  // and using them for addvl/addpl, until offset is 0.
  while (Size > 0) {
    uint64_t Subtr = std::min(Size, MaxOffset);
    BuildMI(MBB, MBBI, DL, *Op, Dst)
       .addReg(Basereg, KillBaseReg ? RegState::Kill : 0)
       .addImm(Sign * Subtr);
    Basereg = Dst;
    Size -= Subtr;
    KillBaseReg = true;
  }

  return Dst;
}

//===-----------------------------------------------------------===//
//               SVEVecStackRegion implementation
//===-----------------------------------------------------------===//
bool SVEVecStackRegion::allocatesRegClass(
    const TargetRegisterClass *c) const {
  if (IsPredicateRegion)
    return AArch64::PPRRegClass.hasSubClassEq(c);
  else
    return AArch64::ZPRRegClass.hasSubClassEq(c) ||
           AArch64::ZPR2RegClass.hasSubClassEq(c) ||
           AArch64::ZPR3RegClass.hasSubClassEq(c) ||
           AArch64::ZPR4RegClass.hasSubClassEq(c) ||
           AArch64::ZPR_HIRegClass.hasSubClassEq(c);
}

bool SVEVecStackRegion::allocatesType(const Type *Type) const {
  // Support for array like structs.
  if (auto ST = dyn_cast<StructType>(Type))
    if (std::equal(ST->element_begin(), ST->element_end(), ST->element_begin()))
      return (ST->getNumElements() != 0) ? allocatesType(*ST->element_begin())
                                         : false;

  if (isa<ArrayType>(Type))
    return allocatesType(cast<ArrayType>(Type)->getElementType());

  const VectorType *VT = dyn_cast<const VectorType>(Type);
  if (IsPredicateRegion)
    return VT && VT->isScalable() && (VT->getBitWidth() % 128 > 0);
  else
    return VT && VT->isScalable() && (VT->getBitWidth() % 128 == 0);
}

// Get a quick estimate without all details of exact layout
uint64_t SVEVecStackRegion::estimateRegionSize(const MachineFunction &Fn) {
  const MachineFrameInfo &MFI = Fn.getFrameInfo();
  const AArch64RegisterInfo *RegInfo = static_cast<const AArch64RegisterInfo *>(
      Fn.getSubtarget().getRegisterInfo());

  // First all objects
  uint64_t Result = 0;
  for (unsigned I = 0, E = MFI.getObjectIndexEnd(); I != E; ++I) {
    if (MFI.getObjectRegion(I) == this)
      Result += MFI.getObjectSize(I);
  }

  // Then all Callee Saved Registers
  const MCPhysReg *CSRegs = RegInfo->getCalleeSavedRegs(&Fn);
  for (unsigned I = 0; CSRegs[I]; I += 1) {
    if (!Fn.getRegInfo().isPhysRegModified(CSRegs[I]))
      continue;

    if (MFI.getStackRegionToHandleCSR(CSRegs[I]) == this)
      Result += this->Scale;
  }

  return Result;
}

uint64_t SVEVecStackRegion::layoutRegion(MachineFunction &Fn,
                                           uint64_t StartOffset,
                                           unsigned Align) {
  MachineFrameInfo &MFI = Fn.getFrameInfo();
  const MachineRegisterInfo *MRI = &Fn.getRegInfo();

  // Early exit if this StackRegion will never be used
  if (!MaybeUsed) {
    CSRs.clear();
    setRegionSize(0);
    return StartOffset;
  }

  // Do not save registers if they are not used
  for (std::vector<unsigned>::iterator i = CSRs.begin(); i != CSRs.end();) {
    if (!MRI->isPhysRegModified(*i))
      i = CSRs.erase(i);
    else
      ++i; // advance loop
  }

  // Count the number of locals/spills to be allocated to this region
  unsigned Count = 0;
  for (unsigned i = 0, e = MFI.getObjectIndexEnd(); i != e; ++i) {
    if (MFI.getObjectRegion(i) == this) {
      // Normalize and align object size to #predicates.
      unsigned ObjSize = MFI.getObjectSize(i);

      // Assign subsequent offsets to StackObjects for this region
      // e.g. [ 0, 1, 2, ... K ]    where K is number of SVE locals
      unsigned Offset = StartOffset + Count;
      // Align element if needed.
      unsigned Alignment = MFI.getObjectAlignment(i);
      unsigned Padding = 0;
      if (!MFI.getObjectAllocation(i)) {
        // for ZPR2,3,4 register classes, the spill/fill instructions have a
        // very restricted immediate field, of multiples of the object size (eg.
        // for st3, offset must multiples of 3 * vector length).  Add padding to
        // ensure the stack offset naturally fulfils this restriction.
        // We should take care not to do this when this object is from an alloca
        // instruction, for e.g. arrays of SVE vectors we only want to align to
        // the natural alignment (see below)
        if ((ObjSize > Alignment) && (Offset % ObjSize > 0))
          Padding = ObjSize - (Offset % ObjSize);
      } else if (Offset % Alignment > 0)
        // Align to natural alignment of object
        Padding = ObjSize - (Offset % Alignment);

      MFI.setObjectOffset(i, Offset + Padding);
      Count += ObjSize + Padding;
    }
  }

  // Saves are never referenced in user code, only in the epilogue
  // and prologue, so we don't need to give offsets. We only need
  // to count the number of saves that we need to allocate for
  // the save area.
  Count += CSRs.size() * this->Scale;

  // Align to 'Align' elements if needed.
  if (Count % Align > 0)
    Count += Align - (Count % Align);

  // We now know the final size of the stack region in #predicate elements
  this->setRegionSize(Count);

  // Return new offset in right scale (for SVE, this is #predicate elements)
  return StartOffset + this->getRegionSize();
}

int SVEVecStackRegion::resolveFrameIndexReference(const MachineFunction &MF,
                                                    int Idx,
                                                    unsigned &FrameReg) const {
  const TargetFrameLowering *TFI = MF.getSubtarget().getFrameLowering();
  const MachineFrameInfo &MFI = MF.getFrameInfo();

  //  +-----------+
  //  | obj @idx1 |
  //  +-----------+
  //  | obj @idx0 |
  //  +-----------+ <- FP/SP
  FrameReg = TFI->hasFP(MF) ? AArch64::FP : AArch64::SP;
  return MFI.getObjectOffset(Idx);
}

/// Saves or Restores registers from a given pointer (Basereg)
/// at offset Offset.
void SVEVecStackRegion::SaveRestoreSVEFromPointer(
    MachineFunction &MF, MachineBasicBlock &MBB,
    MachineBasicBlock::iterator MBBI, DebugLoc DL, uint64_t Offset,
    unsigned Basereg, bool IsSave) const {
  const MCInstrDesc *Insn;
  const AArch64InstrInfo *TII;
  const AArch64RegisterInfo *TRI;

  TII = static_cast<const AArch64InstrInfo *>(MF.getSubtarget().getInstrInfo());
  TRI = static_cast<const AArch64RegisterInfo *>(
      MF.getSubtarget().getRegisterInfo());

  // Find the right instruction for the job
  if (IsSave) {
    if (this->IsPredicateRegion)
      Insn = &TII->get(AArch64::STR_PXI);
    else
      Insn = &TII->get(AArch64::STR_ZXI);
  } else {
    if (this->IsPredicateRegion)
      Insn = &TII->get(AArch64::LDR_PXI);
    else
      Insn = &TII->get(AArch64::LDR_ZXI);
  }

  // Store the saves at Offset+Idx from Basepointer.
  // We first scale the Offset, because Offset is in #predicates.
  // (LDR|STR)_V is in SVE Vector elements (i.e. scaled by 8)
  int Idx = 0;
  int64_t Adjust = (Offset / this->Scale) - 1;
  for (unsigned I : CSRs) {
    BuildMI(MBB, MBBI, DL, *Insn)
        .addReg(I, IsSave ? RegState::Undef : RegState::Define)
        .addReg(Basereg)
        .addImm(Adjust + Idx);

    DEBUG(dbgs() << "CSR " << (IsSave ? "spill: " : "restore: ")
                 << TRI->getName(I) << (IsSave ? " -> " : " <- ")
                 << (TRI->isVirtualRegister(Basereg) ? "(BP'|SP')"
                                                     : TRI->getName(Basereg))
                 << "[" << (Adjust + Idx) << "]\n");

    --Idx;
  }
}

void SVEVecStackRegion::emitCFI(MachineBasicBlock &MBB,
                                MachineBasicBlock::iterator MBBI,
                                unsigned Basereg,
                                int64_t UnscaledOffset,
                                int64_t ScaledOffset) const {
  MachineFunction &MF = *MBB.getParent();
  DebugLoc DL = MBB.findDebugLoc(MBBI);
  const TargetSubtargetInfo &STI = MF.getSubtarget();
  auto *TII = static_cast<const AArch64InstrInfo *>(STI.getInstrInfo());
  const MCRegisterInfo *MRI = STI.getRegisterInfo();

  unsigned VG = MRI->getDwarfRegNum(AArch64::VG, true);

  // Doing the divide by 2 because VG = n * 64bit.
  // e.g. with 16 byte vectors (Scale = 16, VG = 2) and e.g. 6 Vec CSRs,
  // The first callee save is at byte offset:
  //    VG * ((96-16)/2
  // => VG * 40 => 80
  int Idx = 0;
  int64_t Adjust = (ScaledOffset - this->Scale) / 2;
  unsigned DwarfBReg = MRI->getDwarfRegNum(Basereg, true);
  for (unsigned R : CSRs) {
    unsigned DwarfReg = MRI->getDwarfRegNum(R, true);

    // Add comment for Asm
    std::string Comment;
    raw_string_ostream CommentOS(Comment);
    CommentOS << "cfi(" << MRI->getName(R) << ") = ";
    if (Basereg == AArch64::SP)
      CommentOS << MRI->getName(Basereg) << " + " << UnscaledOffset;
    else
      CommentOS << "CFA + " << (UnscaledOffset - 16);
    CommentOS << " + " << MRI->getName(AArch64::VG) << " * " << (Adjust + Idx);
    DEBUG(dbgs() << CommentOS.str() << "\n");

    unsigned CFIIndex = MF.addFrameInst(
        MCCFIInstruction::createScaledOffset(nullptr, DwarfReg, DwarfBReg,
                                             UnscaledOffset, VG,
                                             Adjust + Idx,CommentOS.str()));
    BuildMI(MBB, MBBI, DL, TII->get(TargetOpcode::CFI_INSTRUCTION))
        .addCFIIndex(CFIIndex)
        .setMIFlags(MachineInstr::FrameSetup);
    Idx -= (this->Scale / 2);
  }
}

void SVEVecStackRegion::emitPrologue(MachineFunction &MF,
                                       MachineBasicBlock &MBB,
                                       MachineBasicBlock::iterator MBBI,
                                       DebugLoc DL,
                                       uint64_t &AddedSize, unsigned Basereg,
                                       uint64_t Offset) const {
  // If Region is empty, no CSRs need saving.
  if (RegionSize == 0)
    return;

  // If we have no CSRs to save, leave allocation for calling
  // function or for the next invocation of emitPrologue.
  if (CSRs.size() == 0) {
    AddedSize += this->getRegionSize();
    return;
  }

  // If the offset becomes too large for the immediate field to handle
  // after updating Basereg, we create a temporary copy and save from there.
  unsigned TmpBasereg = Basereg;
  if (CSRs.size() > 0 &&
      (((AddedSize + Offset) - Scale) > (uint64_t)Scale * 255)) {
    TmpBasereg = adjustRegBySVE(MF, MBB, MBBI, DL, Basereg, /*Offset=*/0,
                               /*IsPositiveOffset=*/false);
    Offset = 0;
  }

  // Adjust the Stack Pointer to allocate the space
  adjustRegBySVE(MF, MBB, MBBI, DL, Basereg, this->getRegionSize() + AddedSize,
                 /*IsPositiveOffset=*/false, /*KillBaseReg=*/false, /*Dst=*/AArch64::SP);

  // Reset AddedSize, because Basereg is now updated
  AddedSize = 0;

  // Restore the SVE registers
  SaveRestoreSVEFromPointer(MF, MBB, MBBI, DL, Offset, TmpBasereg, true);
}

void SVEVecStackRegion::emitEpilogue(MachineFunction &MF,
                                       MachineBasicBlock &MBB,
                                       MachineBasicBlock::iterator MBBI,
                                       DebugLoc DL,
                                       uint64_t &AddedSize, unsigned &Basereg,
                                       uint64_t Offset) const {
  // If Region is empty, no CSRs need restoring.
  if (RegionSize == 0)
    return;

  // If we have no CSRs to restore, leave deallocation for calling function.
  if (CSRs.size() == 0) {
    AddedSize += this->getRegionSize();
    return;
  }

  // If we cannot reach the last save with an immediate from the
  // Basepointer, create a temporary SP' from which we restore
  // (at Offset 0).
  bool BPChanged = false;
  if (CSRs.size() > 0 &&
      ((AddedSize + Offset) - Scale) > (uint64_t)Scale * 255) {
    Basereg = adjustRegBySVE(MF, MBB, MBBI, DL, Basereg, AddedSize + Offset,
                             /*IsPositiveOffset=*/true, /*KillBaseReg=*/true);

    // The change to Basereg also resets the cumulative AddedSize relative to
    // Basereg.
    AddedSize = 0;
    Offset = 0;
    BPChanged = true;
  }

  // Restore the SVE registers.
  SaveRestoreSVEFromPointer(MF, MBB, MBBI, DL, AddedSize + Offset, Basereg, false);

  // Update cumulative offset to Basereg.
  if (!BPChanged)
    AddedSize += this->getRegionSize();
}
