//===- SVEAddressingModes - A SVE Optimizer ---------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This pass attempts to work around artefacts introduced by loop strength
// reduction.  After LSR vectorised loops have a tendency to look as follows:
//
// vector.body:
//   %idx = phi i64 [ %idx.n, %vector.body ], [ 0, %vector.ph ]
//   %1 = bitcast double* %0 to i8*
//   %uglygep580 = getelementptr i8, i8* %1, i64 %idx
//   ......
//   %idx.n = add i64 %idx, mul (i64 elementcount (<n x 2 x i64> undef), i64 8)
//   br i1 %cond, label vector.body
//
// which requires a reg+reg addressing mode SVE does not possess.
// This pass transforms the above into:
//
// vector.body:
//   %idx = phi i64 [ %idx.n, %vector.body ], [ 0, %vector.ph ]
//   %idx.new = mul i64 %idx, 8
//   %1 = bitcast double* %0 to i8*
//   %uglygep580 = getelementptr i8, i8* %1, i64 %idx.new
//   ......
//   %idx.n = add i64 %idx, i64 elementcount (<n x 2 x i64> undef)
//   br i1 %cond, label vector.body
//
// that allows us to make use of SVE's reg+scaled_reg addressing mode.
//
//===----------------------------------------------------------------------===//

#include "llvm/Transforms/Scalar.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include <algorithm>
using namespace llvm;
using namespace llvm::PatternMatch;

#define DEBUG_TYPE "sve-addressing-modes"

STATISTIC(NumVisited,   "Number of loops visited.");
STATISTIC(NumOptimized, "Number of loops optimized.");

namespace llvm {
  void initializeSVEAddressingModesPass(PassRegistry &);
}

namespace {
struct SVEAddressingModes : public FunctionPass {
  static char ID; // Pass identification, replacement for typeid
  SVEAddressingModes() : FunctionPass(ID) {
    initializeSVEAddressingModesPass(*PassRegistry::getPassRegistry());
  }

  bool runOnFunction(Function &F) override {
    this->F = &F;
    LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();

    bool Changed = false;
    for (auto I = LI->begin(), IE = LI->end(); I != IE; ++I)
      for (auto L = df_begin(*I), LE = df_end(*I); L != LE; ++L)
        Changed |= runOnLoop(*L);

    return Changed;
  }

  bool runOnLoop(Loop *L);
  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequiredID(LoopSimplifyID);
    AU.addRequired<LoopInfoWrapperPass>();
  }

private:
  Function *F;
  LoopInfo *LI;

  bool OptimizeBlock(BasicBlock *);
  bool onlyUsedForAddrModes(PHINode*, Instruction*, ConstantInt*);
  PHINode* findBetterPHI(PHINode*, BasicBlock*, BasicBlock*, ConstantInt*,
                         APInt&);
};
}

char SVEAddressingModes::ID = 0;
static const char *name = "SVE Addressing Modes";
INITIALIZE_PASS_BEGIN(SVEAddressingModes, DEBUG_TYPE, name, false, false)
INITIALIZE_PASS_DEPENDENCY(LoopInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LoopSimplify)
INITIALIZE_PASS_END(SVEAddressingModes, DEBUG_TYPE, name, false, false)

namespace llvm {
FunctionPass *createSVEAddressingModesPass() {
  return new SVEAddressingModes();
}
}

bool SVEAddressingModes::runOnLoop(Loop *L) {
  bool LoopOptimized = false;

  for (auto BB = L->block_begin(), BE = L->block_end(); BB != BE; ++BB)
    LoopOptimized |= OptimizeBlock(*BB);

  ++NumVisited;
  if (LoopOptimized)
    ++NumOptimized;

  return LoopOptimized;
}

/// Try to find the original PHI used before LSR introduced the new one.
///
PHINode* SVEAddressingModes::findBetterPHI(PHINode *OrigPHI,
                                           BasicBlock *EntryBB,
                                           BasicBlock *BackEdgeBB,
                                           ConstantInt *OrigScale,
                                           APInt &ScaleDisp) {
  assert(OrigPHI->getNumIncomingValues() == 2 && "Unexpected PHI");

  for (Instruction &I : *OrigPHI->getParent()) {
    auto PHI = dyn_cast<PHINode>(&I);
    if (!PHI)
      continue;

    if (PHI == OrigPHI)
      continue;

    if (PHI->getNumIncomingValues() != 2)
      continue;

    int Idx = PHI->getBasicBlockIndex(EntryBB);
    if (Idx < 0)
      continue;
    if (!match(PHI->getIncomingValue(Idx), m_Zero()))
      continue;

    Idx = PHI->getBasicBlockIndex(BackEdgeBB);
    if (Idx < 0)
      continue;

    ConstantInt *Scale;
    if (!match(PHI->getIncomingValue(Idx),
               m_Add(m_Specific(PHI), m_Mul(m_VScale(), m_ConstantInt(Scale)))))
      continue;

    APInt ScaleVal = Scale->getValue();
    APInt OrigScaleVal = OrigScale->getValue();
    if (ScaleVal.getBitWidth() != OrigScaleVal.getBitWidth())
      continue;
    if (!ScaleVal.isPowerOf2())
      continue;
    if (!ScaleVal.slt(OrigScaleVal))
      continue;
    ScaleDisp = OrigScaleVal.sdiv(ScaleVal);

    return PHI;
  }

  return OrigPHI;
}


// Only fold into an addressing mode when the PHI is used for loads/stores
// where the conversion between load/store-type and EC type equals Scale.
// If this cannot be determined, than we may not safely be allowed to re-scale
// the start value of the PHI before the loop: we must know for sure that
// the start value is a multiple of Scale.
//
// For example:
// body:
//  %lsr.iv = phi i64 [ %lsr.iv.next, %body ], [ %start, %preheader ]
//      :
//  %uglygep = getelementptr i8, i8* %43, i64 %lsr.iv
//                                             ^^^^^^
//                                             Uses Scaled indvar (scale = 8)
//  %uglygep2 = bitcast i8* %uglygep to <n x 2 x double>*
//                      ^^               ^^^^^^^^^^^^^^
//                     sizeof(<n x 2 x double>)/sizeof(i8) == n * Scale
//  %wide.masked.load =
//      call <n x 2 x double> @llvm.masked.load(<n x 2 x double>* %uglygep2, ..)
//      :
//  %lsr.iv.next = add i64 %lsr.iv, mul (i64 vscale, i64 16)
bool SVEAddressingModes::onlyUsedForAddrModes(PHINode *PHI,
                                              Instruction *PHIUpdate,
                                              ConstantInt *Scale) {
  auto &DL = PHI->getModule()->getDataLayout();

  SmallVector<User*, 64> WorkList;
  WorkList.append(PHI->user_begin(), PHI->user_end());

  while (!WorkList.empty()) {
    auto *U = WorkList.pop_back_val();

    // Do not consider induction var update
    if (&*U == PHIUpdate)
      continue;

    // Make sure we load/store of EC type
    if (isa<StoreInst>(U) || isa<LoadInst>(U))
        continue;

    if (const auto *II = dyn_cast<IntrinsicInst>(U)) {
      switch (II->getIntrinsicID()) {
      case Intrinsic::masked_load:
      case Intrinsic::masked_store:
        continue;
      default:
        break;
      }
    }

    // Scaling must match up
    if (auto *BC = dyn_cast<BitCastInst>(U)) {
      Type *DstETy = BC->getDestTy()->getPointerElementType();
      Type *SrcETy = BC->getSrcTy()->getPointerElementType();
      SrcETy = SrcETy->isArrayTy() ? SrcETy->getArrayElementType() : SrcETy;
      int64_t BCScale = DL.getTypeStoreSize(DstETy) /
                        DL.getTypeStoreSize(SrcETy);

      if (BCScale == Scale->getSExtValue()) {
        WorkList.append(BC->user_begin(), BC->user_end());
        continue;
      }
    }

    // Make sure this is a GEP that uses our PHI
    if (auto *Gep = dyn_cast<GetElementPtrInst>(U)) {
      if (Gep->getOperand(Gep->getNumIndices()) == PHI) {
          WorkList.append(Gep->user_begin(), Gep->user_end());
          continue;
      }
    }

    // One of the criteria failed
    return false;
  }

  // All of the criteria passed
  return true;
}

static bool isIndVarPHIUpdateValue(Instruction *I, PHINode *PHI,
                                  BasicBlock *&EntryBB,
                                  BasicBlock *&BackEdgeBB) {
  if (I->getType() != PHI->getType())
    return false;

  if (PHI->getNumIncomingValues() != 2)
    return false;

  // phi [ <value>, %vector.ph ], [ %idx.next, %vector.body ]
  if (PHI->getIncomingValue(1) == I) {
    EntryBB = PHI->getIncomingBlock(0);
    BackEdgeBB = PHI->getIncomingBlock(1);
  }
  // phi [ %idx.next, %vector.body ], [ <value>, %vector.ph ]
  else if (PHI->getIncomingValue(0) == I) {
    EntryBB = PHI->getIncomingBlock(1);
    BackEdgeBB = PHI->getIncomingBlock(0);
  }
  // invalid phi
  else
    return false;

  return true;
}

static bool isScaledElementCountIVUpdate(
            Instruction *I, SmallVectorImpl<PHINode*> &PHINodes,
            ConstantInt *&Scale,
            BasicBlock *&EntryBB,
            BasicBlock *&BackEdgeBB) {
  PHINode *PHI;

  // e.g.
  //  %update = add %phi, mul (i64 vscale, i64 32)
  if (match(I, m_Add(m_PHI(PHI),
                     m_Mul(m_VScale(), m_ConstantInt(Scale))))) {
    if (!Scale->getValue().isPowerOf2())
      return false;

    if (!isIndVarPHIUpdateValue(I, PHI, EntryBB, BackEdgeBB))
      return false;

    PHINodes.push_back(PHI);
    return true;
  }

  // e.g.
  //  %phi = i32* phi [ %bc2, %vector.body ] , [..]
  //       :
  //  %bc  = bitcast i32* %phi to i1*
  //  %update = getelementptr i1, i1* %bc, mul (i64 vscale, i64 32)
  //  %bc2 = bitcast i1* %update to i32*
  if (auto *Gep = dyn_cast<GetElementPtrInst>(I)) {
    Value *Opnd = Gep->getOperand(Gep->getNumIndices());
    if (!match(Opnd, m_Mul(m_VScale(), m_ConstantInt(Scale))))
      return false;

    Value *Ptr = Gep->getPointerOperand();
    if (!match(Ptr, m_PHI(PHI)) &&
        !match(Ptr, m_BitCast(m_PHI(PHI))))
      return false;

    // If the pointer is a bitcast then only consider a single
    // user so that we won't 'break' any other addr modes.
    Instruction *Update = I;
    if (auto *BC = dyn_cast<BitCastInst>(Ptr)) {
      if (!BC->hasOneUse())
        return false;
    }

    // An update may be used in multiple PHIs, go through
    // all users of the update.
    BasicBlock *NewEntryBB = nullptr;
    BasicBlock *NewBackEdgeBB = nullptr;
    for (auto *User : Gep->users()) {
      auto *UserPN = dyn_cast<PHINode>(User);

      // If the user is a bitcast, look through it
      if (auto *BC = dyn_cast<BitCastInst>(User)) {
        if (!BC->hasOneUse())
          return false;
        Update = BC;
        UserPN = dyn_cast<PHINode>(*BC->user_begin());
      }

      // The update must be used in a PHI
      if (!UserPN)
        return false;

      // And it must be a proper PHI update
      if (!isIndVarPHIUpdateValue(Update, UserPN, NewEntryBB, NewBackEdgeBB))
        return false;

      // The PHI must be in the same block as the other updates
      if (EntryBB == nullptr) {
        EntryBB = NewEntryBB;
        BackEdgeBB = NewBackEdgeBB;
      } else if (EntryBB != NewEntryBB || BackEdgeBB != NewBackEdgeBB)
        return false;

      PHINodes.push_back(UserPN);
    }

    auto &DL = PHI->getModule()->getDataLayout();
    int64_t ElemTypeSize =
        DL.getTypeStoreSize(Gep->getType()->getPointerElementType());

    // Scale must be in bytes
    Scale = ConstantInt::get(Scale->getType(),
                             Scale->getSExtValue() * ElemTypeSize, true);
    return true;
  }

  return false;
}

// Returns whether U is a GEP that can be trivially hoisted out of the loop
static bool IsHoistableGEPCandidate(User *U, BasicBlock *EntryBB, Value *PHI,
                                    GetElementPtrInst *&Gep,
                                    Value *&PointerOpnd,
                                    BitCastInst *&BC) {
  Gep = dyn_cast<GetElementPtrInst>(U);
  if (!Gep)
    return false;

  // Function to determine if all operands are invariant or the IV
  auto AllInvariantOrIV = [EntryBB,PHI](Value *V){
    if (V == PHI || isa<Constant>(V) || isa<Argument>(V))
      return true;
    if (auto VI = dyn_cast<Instruction>(V))
      return VI->getParent() == EntryBB;
    return false;
  };

  if (!std::all_of(Gep->idx_begin(), Gep->idx_end(), AllInvariantOrIV))
    return false;

  PointerOpnd = Gep->getPointerOperand();
  auto *PointerOpndI = dyn_cast<Instruction>(PointerOpnd);
  if (PointerOpndI && PointerOpndI->getParent() != EntryBB)
    if ((BC = dyn_cast<BitCastInst>(PointerOpndI)))
      PointerOpnd = BC->getOperand(0);
  PointerOpndI = dyn_cast<Instruction>(PointerOpnd);

  return !PointerOpndI || (PointerOpndI->getParent() == EntryBB);
}

#define MAX_LOOPSTRENGTH_LOOPVARS 5

/// Attempt to restructure vectorised loops so that we can better utilise SVE
/// reg+scaled_reg addressing modes.
///
bool SVEAddressingModes::OptimizeBlock(BasicBlock *BB) {
  bool LoopChanged = false;

  auto &DL = BB->getModule()->getDataLayout();
  IRBuilder<> Builder(BB);

  for (BasicBlock::iterator it = BB->begin(), e = BB->end(); it != e;) {
    Instruction *I = &*it++;

    // Find the scaled elementcount update
    SmallVector<PHINode*, 2> PHINodes;
    ConstantInt *OrigScale;
    BasicBlock  *EntryBB = nullptr;
    BasicBlock  *BackEdgeBB = nullptr;
    APInt ScaleDisp;

    if (!isScaledElementCountIVUpdate(I, PHINodes, OrigScale, EntryBB, BackEdgeBB))
      continue;

    for (auto *PHI : PHINodes) {
      // Try to find an unscaled PHI with same elementcount.
      auto *OtherPHI = findBetterPHI(PHI, EntryBB, BackEdgeBB, OrigScale,
                                     ScaleDisp);

      // If it cannot find a suitable one, continue
      if (OtherPHI == PHI)
        continue;

      // Transform patterns like:
      //   body:
      //     %lsr.idx = phi(..)
      //     %ptr = getelementpr %addr, %lsr.idx
      //     %ptr2 = getelementptr %ptr, i64 4
      //
      // Into:
      //   ph:
      //     %addr2 = getelementptr %addr, i64 4
      //   body:
      //     %lsr.idx = phi(..)
      //     %ptr = getelementpr %addr2, %lsr.idx
      for (auto *U : PHI->users()) {
        // Limit number of new pointers created
        if (U->hasNUsesOrMore(3))
          continue;

        GetElementPtrInst *Gep;
        Value *PointerOpnd;
        BitCastInst *BC = nullptr;
        // Check if we can split the base pointer from
        // the offsets and make it partly loop invariant.
        if (!IsHoistableGEPCandidate(U, EntryBB, PHI,
                 /* out args: */     Gep, PointerOpnd, BC))
          continue;

        SmallVector<Instruction*,2> ToRemove;
        for (auto *UU : U->users()) {
          // User must be a GEP
          auto *OffsetGep = dyn_cast<GetElementPtrInst>(UU);
          if (!OffsetGep)
            continue;

          // With only constant offsets
          if (!OffsetGep->hasAllConstantIndices())
            continue;

          // It must be an offset to the same type
          if (OffsetGep->getType() != OffsetGep->getPointerOperand()->getType())
            continue;

          bool AnyStructTy = false;
          for (auto GTI = gep_type_begin(Gep), E = gep_type_end(Gep); GTI != E;
               ++GTI)
            if (GTI.isStruct())
              AnyStructTy = true;

          if (AnyStructTy)
            continue;

          // Cast the pointer to the type we're expecting (in preheader)
          Builder.SetInsertPoint(EntryBB->getTerminator());
          auto *NewPointerOpnd =
              Builder.CreateBitCast(PointerOpnd, Gep->getType());

          // And create a new base pointer with offset,
          // and cast the result to the right pointer type
          auto *NewBase = Builder.Insert(OffsetGep->clone());
          NewBase->replaceUsesOfWith(U, NewPointerOpnd);
          NewBase = cast<Instruction>(
              Builder.CreateBitCast(NewBase,
                                    Gep->getPointerOperand()->getType()));

          // Copy the original GEP and use the new base
          Builder.SetInsertPoint(Gep);
          auto *NewGep = cast<GetElementPtrInst>(Builder.Insert(Gep->clone()));
          NewGep->replaceUsesOfWith(Gep->getPointerOperand(), NewBase);

          // Replace all uses and cleanup
          OffsetGep->replaceAllUsesWith(NewGep);
          ToRemove.push_back(OffsetGep);
        }

        // Remove original nodes from parent
        for (auto *OffsetGep : ToRemove)
          OffsetGep->eraseFromParent();
      }

      // Start value of the LSR variable
      Value *Start = PHI->getIncomingValueForBlock(EntryBB);

      // First handle scalar types
      if (!Start->getType()->isPointerTy()) {
        auto CI = dyn_cast<ConstantInt>(Start);

        // Simple case, scaled indvar starting at '0'
        if (CI && CI->isNullValue()) {
          Builder.SetInsertPoint(PHI->getParent()->getFirstNonPHI());
          auto *Scale = ConstantInt::get(PHI->getType(), ScaleDisp);
          auto *Mul = Builder.CreateMul(OtherPHI, Scale);
          PHI->replaceAllUsesWith(Mul);
        } else {
          // Check it is only used in suitable addressing modes
          if (!onlyUsedForAddrModes(PHI, I, OrigScale))
            continue;

          // Re-scale the start value
          Builder.SetInsertPoint(EntryBB->getTerminator());
          unsigned LogBase = ScaleDisp.logBase2();
          auto *ShiftAmount =
              ConstantInt::get(Start->getType(), LogBase, false);
          auto *StartI = Builder.CreateAShr(Start, ShiftAmount);

          // Add the unscaled PHI
          Builder.SetInsertPoint(PHI->getParent()->getFirstNonPHI());
          auto *NewIV = Builder.CreateAdd(StartI, OtherPHI);
          NewIV = Builder.CreateShl(NewIV, ShiftAmount);

          // If the start value is constant, create a new pointer in
          // preheader for each user (GEP)
          if (CI) {

            // Create a new scaled induction var without constant offset
            Builder.SetInsertPoint(PHI->getParent()->getFirstNonPHI());
            auto *NewIVWithoutOffset = Builder.CreateShl(OtherPHI, ShiftAmount);
            unsigned Counter = 0;
            SmallVector<User*,4> PhiUsers(PHI->users());
            for (auto *U : PhiUsers) {
              BitCastInst *BC = nullptr;
              GetElementPtrInst *Gep;
              Value *PointerOpnd;

              // Test if the GEP + offset can be hoisted
              if (Counter < MAX_LOOPSTRENGTH_LOOPVARS &&
                  IsHoistableGEPCandidate(U, EntryBB, PHI,
                                          Gep, PointerOpnd, BC)) {
                Counter++;

                // Clone the GEP in the preheader
                Builder.SetInsertPoint(EntryBB->getTerminator());
                auto *Clone = Builder.Insert(Gep->clone());

                // If the pointer is a bitcast, reconstruct it in the preheader
                if (BC) {
                  Builder.SetInsertPoint(Clone);
                  auto *NewPointerOpnd =
                      Builder.CreateBitCast(PointerOpnd, BC->getType());
                  Clone->replaceUsesOfWith(BC, NewPointerOpnd);
                }

                for (unsigned J = 1; J < Gep->getNumOperands(); ++J) {
                  Value *Opnd = Clone->getOperand(J);
                  Value *NewOpnd = ConstantInt::get(Opnd->getType(),
                                      Opnd == PHI ?  CI->getSExtValue() : 0);
                  Clone->setOperand(J, NewOpnd);
                }

                // Finally, bitcast the new pointer to the original pointer type
                Builder.SetInsertPoint(EntryBB->getTerminator());
                Clone = cast<Instruction>(Builder.CreateBitCast(
                                 Clone, Gep->getPointerOperand()->getType()));

                // Create a new GEP in the vector body and use new IV
                Gep->replaceUsesOfWith(Gep->getPointerOperand(), Clone);
                Gep->replaceUsesOfWith(PHI, NewIVWithoutOffset);
              }
            }
          }

          // Insert the new indvar and scaled start value
          PHI->replaceAllUsesWith(NewIV);
        }
      }

      // Handle pointer inductions
      if (Start->getType()->isPointerTy()) {
        auto *GepI = cast<GetElementPtrInst>(I);
        Builder.SetInsertPoint(PHI->getParent()->getFirstNonPHI());

        // Find scalar element type
        Type *BaseTy = Start->getType()->getPointerElementType();
        uint64_t ElemTypeSize = DL.getTypeStoreSize(BaseTy);
        int64_t ScaleVal = ScaleDisp.getSExtValue();
        if (!BaseTy->isSingleValueType() || (ScaleVal % ElemTypeSize) != 0) {

          // Do everything in largest possible type that fits the Scale
          LLVMContext &Context = BB->getContext();
          Type *NewBaseType = Type::getInt8Ty(Context);
          if (ScaleVal % 8 == 0)
            NewBaseType = Type::getInt64Ty(Context);
          else if (ScaleVal % 4 == 0)
            NewBaseType = Type::getInt32Ty(Context);
          else if (ScaleVal % 2 == 0)
            NewBaseType = Type::getInt16Ty(Context);

          ElemTypeSize = DL.getTypeStoreSize(NewBaseType);
          Start = Builder.CreateBitCast(Start, NewBaseType->getPointerTo());
        }

        // Rescale
        int64_t NewScaleVal = ScaleVal / ElemTypeSize;
        auto *Scale = ConstantInt::get(OtherPHI->getType(), NewScaleVal, true);

        // Multiply with scalar indvar
        auto *Idx = Builder.CreateMul(OtherPHI, Scale);

        // Calculate address
        auto *NewGep = GepI->isInBounds() ?
                        Builder.CreateInBoundsGEP(Start, Idx) :
                        Builder.CreateGEP(Start, Idx);

        // Bitcast to original type
        auto *BitCast = Builder.CreateBitCast(NewGep, PHI->getType());

        // Replace
        PHI->replaceAllUsesWith(BitCast);
      }

      LoopChanged = true;
    }
  }

  return LoopChanged;
}
