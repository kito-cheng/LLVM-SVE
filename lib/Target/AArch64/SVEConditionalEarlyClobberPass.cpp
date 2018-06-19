//==-- SVEConditionalEarlyClobberPass.cpp - Conditionally add early clobber ==//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//  This pass solves an issue with MOVPRFXable instructions that
//  have the restriction that the destination register of a MOVPRFX
//  cannot be used in any operand of the next instruction, except for
//  the destructive operand.
//
//  We chose to create Pseudo instructions to implement false-lane zeroing,
//  where we specifically tried not to use the '$Zd = $Zs1' restriction
//  so that the register allocator doesn't insert normal
//  MOV instructions. The downside of doing that, is that the register
//  allocation of:
//    vreg1 = OP_ZEROING vreg0, vreg0
//  may result in:
//    Z8 = OP_ZEROING Z8, Z8
//
//  At expand time, the OP_ZEROING will either need a scratch register to
//  implement an actual 'MOV(DUP(0))', or will need to use a MOVPRFX Pg/z
//  with a dummy ('nop'-like) MOVPRFXable instruction, like LSL #0.
//
//  This is better handled by the register allocator creating an allocation
//  that takes the above restriction into account, e.g.
//    Z3 = OP_ZEROING Z8, Z8
//  which can be correctly expanded into:
//    Z3 = MOVPRFX Pg/z, Z8
//    Z3 = OP Z3, Z8
//
//  After Coalescing of virtual registers, we know whether the input operands
//  to the instruction will be in the same register or not.
//  For our example:
//    vreg1 = OP_ZEROING vreg0, vreg0
//  we know that vreg0 and vreg0 will be equal, but we don't know the
//  register allocation of vreg1. We want to force that vreg1 will be different
//  from vreg0, which can be done using an 'earlyclobber'.
//
//  This pass adds the earlyclobber to the machine operand, and also updates
//  the cache of live ranges so that subsequent passes don't need to
//  recalculate those for the newly added earlyclobber.
//
//===----------------------------------------------------------------------===//

#include "AArch64InstrInfo.h"
#include "llvm/CodeGen/LivePhysRegs.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/Target/TargetSubtargetInfo.h"
using namespace llvm;

#define PASS_SHORT_NAME "SOME PASS NAME"

namespace llvm {
  void initializeSVEConditionalEarlyClobberPassPass(PassRegistry &);
}

namespace {
class SVEConditionalEarlyClobberPass : public MachineFunctionPass {
public:
  static char ID;
  SVEConditionalEarlyClobberPass() : MachineFunctionPass(ID) {
    initializeSVEConditionalEarlyClobberPassPass(
                    *PassRegistry::getPassRegistry());
  }

  bool runOnMachineFunction(MachineFunction &Fn) override;

  StringRef getPassName() const override { return PASS_SHORT_NAME; }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesCFG();
    AU.addRequired<LiveIntervals>();
    AU.addPreserved<LiveIntervals>();
    AU.addRequired<SlotIndexes>();
    AU.addPreserved<SlotIndexes>();
    MachineFunctionPass::getAnalysisUsage(AU);
  }
private:
  const TargetInstrInfo *TII;
  LiveIntervals *LIS;

  bool addConditionalEC(MachineInstr &MI);
  bool hasConditionalClobber(const MachineInstr &MI);
};
char SVEConditionalEarlyClobberPass::ID = 0;
}

INITIALIZE_PASS(SVEConditionalEarlyClobberPass,
                "aarch64-conditional-early-clobber",
                PASS_SHORT_NAME, false, false)

FunctionPass *llvm::createSVEConditionalEarlyClobberPass() {
  return new SVEConditionalEarlyClobberPass();
}

// We could also choose to do this with a new instruction annotation
// like 'earlyclobberif($Zd=$Zs1)', but because this is so specific to SVE
// it should be fine to explicitly check the type of SVE operation where
// we know what the conditions are.
bool SVEConditionalEarlyClobberPass::hasConditionalClobber(
                                                const MachineInstr &MI) {
  int Instr = AArch64::getSVEPseudoMap(MI.getOpcode());
  if (Instr == -1)
    return false;

  uint64_t DType =
      TII->get(Instr).TSFlags & AArch64::DestructiveInstTypeMask;
  auto mo_equals = [&](const MachineOperand &MO1, const MachineOperand &MO2) {
    if (MO1.getReg() == MO2.getReg() && MO1.getSubReg() == MO2.getSubReg()) {
      // This is needed to deal with cases where subreg assignment means that
      // the earlyclobber isn't necessary.
      return MI.getOperand(0).getSubReg() == MO1.getSubReg() ||
             ((MO1.getSubReg() == 0) ^ (MI.getOperand(0).getSubReg() == 0));
    }
    return false;
  };
  switch (DType) {
  case AArch64::DestructiveBinary:
  case AArch64::DestructiveBinaryComm:
  case AArch64::DestructiveBinaryCommWithRev:
    return mo_equals(MI.getOperand(2), MI.getOperand(3));
  case AArch64::DestructiveTernaryCommWithRev:
    return mo_equals(MI.getOperand(2), MI.getOperand(3)) ||
           mo_equals(MI.getOperand(2), MI.getOperand(4)) ||
           mo_equals(MI.getOperand(3), MI.getOperand(4));
  case AArch64::NotDestructive:
  case AArch64::DestructiveBinaryImm:
  case AArch64::DestructiveBinaryShImmUnpred:
    return false;
  default:
    break;
  }

  llvm_unreachable("Not a known destructive operand type");
}

bool SVEConditionalEarlyClobberPass::addConditionalEC(MachineInstr &MI) {
  // If the operand is already 'earlyclobber' or it doesn't require
  // adding a conditional one (based on instruction), then don't bother.
  if (!hasConditionalClobber(MI))
    return false;

  if (MI.getOperand(0).isEarlyClobber())
    return false;

  assert(MI.getOperand(0).isDef());

  // Set the 'EarlyClobber' attribute for when the live ranges need
  // to be recalculated.
  MI.getOperand(0).setIsEarlyClobber(true);

  SlotIndex Index = LIS->getInstructionIndex(MI);
  SlotIndex DefSlot = Index.getRegSlot(0);

  // Update the LiveRange cache by extending the liferange of the
  // 'Def' register to be live earlier, so it overlaps with the
  // live ranges of the input operands.
  unsigned Reg = MI.getOperand(0).getReg();
  auto *Seg = LIS->getInterval(Reg).getSegmentContaining(DefSlot);
  assert(Seg && "Expected Def operand to be live with instruction");
  Seg->start = Index.getRegSlot(true);
  Seg->valno->def = Seg->start;

  return true;
}

bool SVEConditionalEarlyClobberPass::runOnMachineFunction(MachineFunction &MF) {
  LIS = &getAnalysis<LiveIntervals>();
  TII = MF.getSubtarget().getInstrInfo();

  bool Modified = false;
  for (auto &MBB : MF)
    for (auto &MI : MBB)
      Modified |= addConditionalEC(MI);

  return Modified;
}
