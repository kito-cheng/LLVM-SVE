//==- PreInlinerTransforms.h - Transforms that must happen before inlining -=//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_TRANSFORMS_IPO_PREINLINERTRANSFORMS_H
#define LLVM_TRANSFORMS_IPO_PREINLINERTRANSFORMS_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class PreInlinerTransformsPass
    : public PassInfoMixin<PreInlinerTransformsPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

class PreInlinerTransforms : public ModulePass {
public:
  static char ID;
  PreInlinerTransforms() : ModulePass(ID) {
    initializePreInlinerTransformsPass(*PassRegistry::getPassRegistry());
  }

  bool runOnModule(Module &M) override;

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<CallGraphWrapperPass>();
    AU.addPreserved<CallGraphWrapperPass>();
  }
};

} // end namespace llvm

#endif // LLVM_TRANSFORMS_IPO_PREINLINERTRANSFORMS_H
