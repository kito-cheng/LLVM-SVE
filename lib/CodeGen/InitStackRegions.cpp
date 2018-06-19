//===- InitStackRegions.cpp - Assign StackObjects to Regions ---*- C++ -*-====//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//  This pass assigns StackObjects to StackRegions based on their type or
//  Register Class (for Callee Saved Registers). The pass is run before
//  LocalStackSlotAllocation so that all passes related to locals are
//  aware that they should not try to allocate these types/locals/registers.
//
//===----------------------------------------------------------------------===//
#include "llvm/ADT/Statistic.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Type.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Target/TargetFrameLowering.h"
#include "llvm/Target/TargetRegisterInfo.h"
#include "llvm/Target/TargetSubtargetInfo.h"

using namespace llvm;

#define DEBUG_TYPE "initstackregion"

namespace {
  class InitStackRegionPass : public MachineFunctionPass {
  public:

    static char ID; // Pass identification, replacement for typeid
    explicit InitStackRegionPass(): MachineFunctionPass(ID) {
      initializeInitStackRegionPassPass(*PassRegistry::getPassRegistry());
    }

    bool runOnMachineFunction(MachineFunction &MF) override;
    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.setPreservesCFG();
      MachineFunctionPass::getAnalysisUsage(AU);
    }
  };
}

char InitStackRegionPass::ID;
char &llvm::InitStackRegionID = InitStackRegionPass::ID;
INITIALIZE_PASS(InitStackRegionPass, "initstackregion",
                    "Initialize StackRegions", false, true)

/// Collects the set of Callee Saved Registers to
/// the registered StackRegions.
static void collectCalleeSaves(MachineFunction& Fn) {
  const TargetRegisterInfo  *RegInfo;
  const MCPhysReg           *CSRegs;

  RegInfo = Fn.getSubtarget().getRegisterInfo();
  CSRegs  = RegInfo->getCalleeSavedRegs(&Fn);

  // Walk through all CSRs and ask each registered stackregion if
  // it wants to handle it.
  for (int i=0; CSRegs[i]; ++i) {
    for (StackRegion* Region : Fn.getFrameInfo().getStackRegions()) {
      if (!Region->allocatesRegClass(
          RegInfo->getMinimalPhysRegClass(CSRegs[i])))
        continue;

      Region->addCSR(CSRegs[i]);
      DEBUG(dbgs() << "Adding CSR " << CSRegs[i]
                   << " to " << Region->getName() << "\n");
      break;
    }
  }
}

/// Collects the set of Locals to the registered StackRegions.
static void
assignLocals(MachineFunction &MF) {
  MachineFrameInfo &MFI = MF.getFrameInfo();

  // Go through all Stackslots
  for (int i = 0, e = MFI.getObjectIndexEnd(); i != e; ++i) {
    // Get the (LLVM IR) allocation instruction
    const AllocaInst *Alloca = MFI.getObjectAllocation(i);

    if (!Alloca)
      continue;

    // Find the StackRegion that allocates this type
    for(StackRegion *SR : MFI.getStackRegions()) {
      if (!SR->allocatesType(Alloca->getType()->getElementType()))
        continue;

      SR->addObject(MFI, i);
      SR->setMaybeUsed();

      DEBUG(dbgs() << "Adding object '" << Alloca->getName()
                   << "' to " << SR->getName() << "\n");
      break;
    }
  }
}

static bool clobbersCSR(const StackRegion &SR, const MachineOperand &Opnd) {
  assert(Opnd.isRegMask() && "Expecting MO_RegisterMask");
  for (const unsigned CSR : SR.getCSRs()) {
    if (Opnd.clobbersPhysReg(CSR))
      return true;
  }
  return false;
}

static bool allocatesReg(const MachineFunction &MF, const StackRegion &SR, unsigned Reg) {
  const TargetRegisterInfo *TRI = MF.getSubtarget().getRegisterInfo();
  // Determine the right register class for Reg
  const TargetRegisterClass *RegClass;
  if (TRI->isPhysicalRegister(Reg))
    RegClass = TRI->getMinimalPhysRegClass(Reg);
  else
    RegClass = MF.getRegInfo().getRegClass(Reg);

  // Ask the StackRegion whether it allocates the type
  return SR.allocatesRegClass(RegClass);
}

static bool checkRegionMayBeUsed(const MachineFunction &MF, const StackRegion &SR) {
  // Walk all MachineInstructions in the Function and test
  // if we really need the StackRegion
  for (auto &BB : MF) {
    for (auto &I : BB) {
      for (auto &Opnd : I.operands()) {
        if (Opnd.isRegMask() && clobbersCSR(SR, Opnd))
          return true;
        if (Opnd.isReg() && Opnd.getReg() && !Opnd.isDebug() &&
            allocatesReg(MF, SR, Opnd.getReg()))
          return true;
      }
    }
  }
  return false;
}

/// The InitStackRegionPass registers Target's Stack Regions
bool InitStackRegionPass::runOnMachineFunction(MachineFunction &MF) {
  const TargetFrameLowering *TFI = MF.getSubtarget().getFrameLowering();

  // Register handlers for custom Stack Regions
  TFI->registerStackRegions(MF);

  // Print some debug information
  for (const StackRegion *SR : MF.getFrameInfo().getStackRegions()) {
    DEBUG(dbgs() << "Registered StackRegion '" << SR->getName()
                 << "' for function '" << MF.getName() << "'\n");
  }

  // Collect all non-default callee saves that belong in a separate
  // stack region, so we can filter them out later.
  collectCalleeSaves(MF);

  // Assign all locals to their corresponding StackRegion
  assignLocals(MF);

  for (StackRegion *SR : MF.getFrameInfo().getStackRegions()) {
    // If the region allocates locals, we are sure its used.
    if (SR->maybeUsed())
      continue;

    // Otherwise do a more thorough check.
    if (checkRegionMayBeUsed(MF, *SR)) {
      SR->setMaybeUsed();
      continue;
    }

    DEBUG(dbgs() << "Unused StackRegion '" << SR->getName()
                 << "' in function '" << MF.getName() << "'\n");
  }

  return true;
}
