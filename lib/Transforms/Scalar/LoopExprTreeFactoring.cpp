//===- LoopExprTreeFactoring.cpp ------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This pass rewrites fadd/fmul trees into mathematically simplified form if the
// correct fast-math attributes are set.
//
// For example:
//      (c0 * x) + (c1 * x) + (c2 * x)
//  <=> (c0 + c1 + c2) * x
//
//      (c0 * x) + (c0 * c1 * x) + (c0 * c2 * x)
//  <=>  c0 * ((1 + c1 + c2) * x)
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/StringSwitch.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Scalar/LoopPassManager.h"
#include "llvm/Transforms/Utils/LoopUtils.h"

using namespace llvm;
using namespace llvm::PatternMatch;

#define LETF_PASSNAME "loop-factor-expr-trees"

namespace {
// We keep a map of 'ordered values', per DFS-order, to keep the
// algorithm deterministic since we are using various unordered data
// structures like DenseMap.
DenseMap<Value *, unsigned> OrderedValues;
}

/// Accmulator tree of multiplicands (Value*) and addends (AccumTree).
//  Given the following tree hierarchy:
//  T  = ( {v1,v2}, {T2, T3} )
//  T2 = ( {}, {v3} )
//  T3 = ( {}, {v4} )
//  The generated expression is:
//    (v1*v2) * (v3 + v4)
class AccumTree {
  /// The multiplicands that are common to all subtrees
  DenseMap<Value *, unsigned> CommonMultiplicands;

  /// A list of subtrees (Addends)
  SmallVector<std::unique_ptr<AccumTree>, 2> Addends;

public:
  AccumTree() {}

  AccumTree(ArrayRef<Value *> Values) {
    for (auto *I : Values)
      CommonMultiplicands.FindAndConstruct(I).second++;
  }

  AccumTree(const AccumTree &Other) {
    for (auto &I : Other.CommonMultiplicands)
      CommonMultiplicands[I.first] = I.second;
    for (auto &A : Other.Addends) {
      auto UniqueCopy = llvm::make_unique<AccumTree>(*A);
      addAddend(UniqueCopy);
    }
  }

  /// Transfer ownership of unique_ptr C to this subtree.
  void addAddend(std::unique_ptr<AccumTree> &C) {
    Addends.push_back(std::move(C));
  }

  /// Partition the accumulator tree into a multi-layer tree
  /// where we try to hoist out invariant multiplicands.
  void partition(Loop *L);

  /// CodeGen this expression tree before insertion point II.
  Value *codeGen(Loop *L, BasicBlock::iterator II);

  /// Cost of generating this tree, defined as:
  ///     Cost of all individual subtrees
  ///   + Cost of adding the subtrees together
  ///   + Cost of multiplying the multiplicands
  unsigned getCost(Loop *L) const {
    // First all subtrees.
    unsigned AddCost = 0;
    for (auto &A : Addends)
      AddCost += A->getCost(L);

    if (Addends.size())
      AddCost += Addends.size() - 1;

    unsigned MultCost = 0;
    for (auto &KV : CommonMultiplicands)
      if (KV.second && L->isLoopInvariant(KV.first))
        MultCost += 1;
      else
        MultCost += KV.second;

    // For leaf nodes, we don't need the extra multiply with
    // the addend
    if (MultCost && !Addends.size())
      MultCost--;
    return AddCost + MultCost;
  }

private:
  /// Helper function to recursively generate the AccumTree expression.
  Value *codeGenTreeList(Loop *L, BasicBlock::iterator II,
                         ArrayRef<std::unique_ptr<AccumTree> > Values) {
    // For an empty subtree, a common multiplicand must have been factored out
    // and so we can safely return the addend '1.0'.
    //    i.e. (a * x0) + (a) => a * (x0 + 1.0)
    if (Values.size() == 0)
      return ConstantFP::get(II->getType(), 1.0);

    Value *Res = Values.front()->codeGen(L, II);
    for (auto &Val : Values.drop_front()) {
      Value *Tmp = Val->codeGen(L, II);
      Instruction *Op = BinaryOperator::Create(Instruction::FAdd, Res, Tmp);
      Op->copyFastMathFlags(&*II);
      Op->insertBefore(&*II);
      Res = Op;
    }

    return Res;
  }

  /// Helper function to generate a multiply expression from a list of values.
  Value *codeGenMulList(BasicBlock::iterator II, ArrayRef<Value *> Values) {
    // For an empty multiplicand list, multiplying with '1.0' gives the same
    // result.
    if (Values.size() == 0)
      return ConstantFP::get(II->getType(), 1.0);

    Value *Res = Values.front();
    for (auto *Val : Values.drop_front()) {
      Instruction *Op = BinaryOperator::Create(Instruction::FMul, Res, Val);
      Op->copyFastMathFlags(&*II);
      Op->insertBefore(&*II);
      Res = Op;
    }

    return Res;
  }

public:
#define INDENT(n) (std::string((n), ' '))
  void dump(raw_ostream &OS, unsigned Indent = 0) {
    OS << INDENT(Indent) << "(\n";
    for (auto &I : CommonMultiplicands)
      for (unsigned J = 0; J< I.second; ++J)
        OS << INDENT(Indent) << *I.first << " *\n";

    for (auto &A : Addends) {
      A->dump(OS, Indent + 4);
      if (A != Addends.back())
        OS << " + ";
      OS << "\n";
    }

    OS << INDENT(Indent) << ")";
  }
};

Value *AccumTree::codeGen(Loop *L, BasicBlock::iterator II) {
  // Recursively generate the Addends
  Value *Add = codeGenTreeList(L, II, Addends);

  // Expand the extracted values into an array and sort by invariants first.
  SmallVector<Value *, 5> Expanded;
  for (auto &IV : CommonMultiplicands)
    for (unsigned NumV = 0; NumV < IV.second; ++NumV)
      Expanded.push_back(IV.first);

  auto InvariantsOnRHS = [&L](Value *A, Value *B) {
    if (L->isLoopInvariant(A) && !L->isLoopInvariant(B))
      return true;
    else if (L->isLoopInvariant(B))
      return false;
    else
      return ::OrderedValues[A] < ::OrderedValues[B];
  };
  std::stable_sort(Expanded.begin(), Expanded.end(), InvariantsOnRHS);
  Expanded.push_back(Add);
  return codeGenMulList(II, Expanded);
}

void AccumTree::partition(Loop *L) {
  // Create a histogram with multiplicands as bins for all addends.
  DenseMap<Value *, unsigned> Hist;
  for (auto &A : Addends) {
    for (auto &I : A->CommonMultiplicands)
      Hist[I.first] += I.second != 0;
  }

  // Find the most common multiplicand.
  typedef std::map<Value *, unsigned>::value_type MapType;
  const auto Max =
      std::max_element(Hist.begin(), Hist.end(), [](MapType A, MapType B) {
        return A.second < B.second ||
               (A.second == B.second &&
                ::OrderedValues[A.first] < ::OrderedValues[B.first]);
      });

  if (Max->second < 2)
    return;

  auto MatchTree = llvm::make_unique<AccumTree>();
  auto NoMatchTree = llvm::make_unique<AccumTree>();

  // Factor out a common multiplicand
  Value *MaxVal = Max->first;
  MatchTree->CommonMultiplicands[MaxVal] = 1;

  // (while maintaining program order of addends)
  std::reverse(Addends.begin(), Addends.end());
  while (Addends.size()) {
    auto ACpy = Addends.pop_back_val();
    if (ACpy->CommonMultiplicands[MaxVal] > 0) {
      ACpy->CommonMultiplicands[MaxVal]--;
      MatchTree->addAddend(ACpy);
    } else
      NoMatchTree->addAddend(ACpy);
  }

  if (MatchTree->Addends.size()) {
    MatchTree->partition(L);
    addAddend(MatchTree);
  }

  if (NoMatchTree->Addends.size()) {
    NoMatchTree->partition(L);
    addAddend(NoMatchTree);
  }

  // Try to squash into a single subtree.
  if (Addends.size() == 1) {
    auto Addend = Addends.pop_back_val();
    for (auto &I : Addend->CommonMultiplicands)
      CommonMultiplicands[I.first] += I.second;
    for (auto &A : Addend->Addends)
      addAddend(A);
  }
}

// Find expression in the loop that match BinopMatch.
static void
findNodes(Loop *L, Value *V, SmallVectorImpl<Value *> &Res,
          std::function<bool(Value *, Value *&, Value *&)> BinopMatch,
          bool IncludeInnerNodes = false) {
  Value *LHS, *RHS;
  if (L->isLoopInvariant(V) || !BinopMatch(V, LHS, RHS))
    Res.push_back(V);
  else {
    if (IncludeInnerNodes)
      Res.push_back(V);
    findNodes(L, LHS, Res, BinopMatch, IncludeInnerNodes);
    findNodes(L, RHS, Res, BinopMatch, IncludeInnerNodes);
  }
}

// Calculates the cost of an expression tree, with a selection given
// by 'MatchSequence', which matches the IR in the given order.
// (e.g. For Add-chains with multiply-subtrees, we'll look for adds first,
// and then multiplies)
// DeadCodeCost is the cost of the remaining tree that will remain if
// we choose to rewrite the entire expression tree.
static int calculateCost(
    Loop *L, Value *V, int &DeadCodeCost,
    ArrayRef<std::function<bool(Value *, Value *&, Value *&)> > MatchSequence,
    bool IsRoot) {
  Value *LHS, *RHS;
  if (L->isLoopInvariant(V))
    return 0;

  if (!MatchSequence[0](V, LHS, RHS)) {
    // We first look for Adds, and only then we look for Muls
    if (MatchSequence.size() > 1 && MatchSequence[1](V, LHS, RHS))
      MatchSequence = MatchSequence.slice(1);
    else
      return 0;
  }

  int DeadCodeCostLHS = 0;
  int DeadCodeCostRHS = 0;
  unsigned SubTreeCost =
      calculateCost(L, LHS, DeadCodeCostLHS, MatchSequence, false) +
      calculateCost(L, RHS, DeadCodeCostRHS, MatchSequence, false) + 1;

  bool SubtreeIsDead = !IsRoot && V->getNumUses() > 1;
  DeadCodeCost =
      SubtreeIsDead ? SubTreeCost : DeadCodeCostLHS + DeadCodeCostRHS;

  return SubTreeCost;
}

bool MatchFAdd(Value *V, Value *&LHS, Value *&RHS) {
  return match(V, m_FAdd(m_Value(LHS), m_Value(RHS))) &&
         cast<Instruction>(V)->hasUnsafeAlgebra();
}

bool MatchFMul(Value *V, Value *&LHS, Value *&RHS) {
  return match(V, m_FMul(m_Value(LHS), m_Value(RHS))) &&
         cast<Instruction>(V)->hasUnsafeAlgebra();
}

static Value *breakAddChain(Instruction *I, Loop *L) {
  SmallVector<Value *, 8> Addends;
  findNodes(L, I, Addends, MatchFAdd);

  if (Addends.size() < 2)
    return nullptr;

  AccumTree T;
  OrderedValues.clear();
  for (auto *A : Addends) {
    // Create the partitioning tree from here.
    SmallVector<Value *, 4> MulOpnds;
    findNodes(L, A, MulOpnds, MatchFMul);

    int Cnt = 0;
    for (auto *V : MulOpnds)
      OrderedValues[V] = Cnt++;

    auto AT = llvm::make_unique<AccumTree>(MulOpnds);
    T.addAddend(AT);
  }

  int DeadCodeCost = 0;
  int CostBefore =
      calculateCost(L, I, DeadCodeCost, { MatchFAdd, MatchFMul }, true);

  T.partition(L);
  int CostAfter = T.getCost(L);
  if (CostAfter + DeadCodeCost < CostBefore)
    return T.codeGen(L, I->getIterator());

  return nullptr;
}

namespace {
class LoopExprTreeFactoringPass : public LoopPass {
public:
  static char ID; // Pass ID, replacement for typeid
  LoopExprTreeFactoringPass() : LoopPass(ID) {
    initializeLoopExprTreeFactoringPassPass(*PassRegistry::getPassRegistry());
  }

  bool processLoop(Loop *L) {
    // Keep a set of nodes that we don't want to revisit
    std::set<Value *> ProcessedNodes;

    for (auto *BB : L->blocks()) {
      SmallVector<Instruction *, 10> WorkList;

      // First build up a worklist
      BasicBlock::reverse_iterator BI, BE;
      for (BI = BB->rbegin(), BE = BB->rend(); BI != BE; BI++) {
        Instruction *I = &*BI;

        if (I->getOpcode() != Instruction::FAdd)
          continue;

        WorkList.push_back(I);
      }

      for (auto *I : WorkList) {
        if (ProcessedNodes.count(I))
          continue;

        Value *New = breakAddChain(I, L);
        if (!New)
          continue;

        if (auto *NewI = dyn_cast<Instruction>(New)) {
          // If we made a change, discard both the old and new chain
          // from the worklist.
          SmallVector<Value *, 8> Addends;
          findNodes(L, I, Addends, MatchFAdd, true);
          ProcessedNodes.insert(Addends.begin(), Addends.end());

          I->replaceAllUsesWith(NewI);
          I->eraseFromParent();
        }
      }
    }

    OrderedValues.clear();
    return !ProcessedNodes.empty();
  }

  bool runOnLoop(Loop *L, LPPassManager &LPM) override {
    if (skipLoop(L))
      return false;

    return processLoop(L);
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesCFG();
  }
};
}

char LoopExprTreeFactoringPass::ID = 0;
INITIALIZE_PASS_BEGIN(LoopExprTreeFactoringPass, LETF_PASSNAME,
                      "Loop Expression Tree Factoring", false, false)
INITIALIZE_PASS_DEPENDENCY(LoopPass)
INITIALIZE_PASS_END(LoopExprTreeFactoringPass, LETF_PASSNAME,
                    "Loop Expression Tree Factoring", false, false)

Pass *llvm::createLoopExprTreeFactoringPass() {
  return new LoopExprTreeFactoringPass();
}
