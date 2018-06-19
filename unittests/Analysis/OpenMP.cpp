#include "llvm/Support/SourceMgr.h"
#include "llvm/AsmParser/Parser.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "gtest/gtest.h"

using namespace llvm;

namespace {
const std::string Pre = "vec_prefix_";
const std::string Post = "_vec_postfix";
const std::string Mid = "_vec_midfix_";
}

TEST(OpenMP, isMangledName) {
  using TLI = TargetLibraryInfoImpl;

  // valid names
  EXPECT_TRUE(TLI::isMangledName("vec_prefix_vfoo_vec_midfix_foo_vec_postfix"));
  EXPECT_TRUE(TLI::isMangledName("vec_prefix_v_vec_midfix_f_vec_postfix"));

  // wrong prefix/midfix/postfix
  EXPECT_FALSE(TLI::isMangledName("vec_prefix_vfoo_vec_midfix_foo_ec_postfix"));
  EXPECT_FALSE(TLI::isMangledName("ec_prefix_vfoo_vec_midfix_foo_vec_postfix"));
  EXPECT_FALSE(TLI::isMangledName("vec_prefix_vfoo_ve_midfix_foo_vec_postfix"));

  // no function names
  EXPECT_FALSE(TLI::isMangledName("vec_prefix__vec_midfix__vec_postfix"));
  EXPECT_FALSE(TLI::isMangledName("vec_prefix__vec_midfix_xxxx_vec_postfix"));
  EXPECT_FALSE(TLI::isMangledName("vec_prefix_xxxx_vec_midfix__vec_postfix"));
}

TEST(OpenMPTest, GlobalValueSignatures) {
  using TLI = TargetLibraryInfoImpl;
  LLVMContext C;
  FunctionType *DummyTy;

  // invalid: not pointers to functions
  EXPECT_FALSE(TLI::isValidSignature(Type::getDoubleTy(C), DummyTy));
  EXPECT_FALSE(TLI::isValidSignature(Type::getDoublePtrTy(C), DummyTy));
  auto FTy = FunctionType::get(Type::getDoubleTy(C), false);
  EXPECT_FALSE(TLI::isValidSignature(FTy, DummyTy));

  // invalid function pointer: not a valid signature
  EXPECT_FALSE(TLI::isValidSignature(FTy->getPointerTo(), DummyTy));

  // invalid: a function returning void with not valid input parameters
  Type *NoTys[] = {Type::getDoublePtrTy(C), Type::getInt64Ty(C)};
  auto VoidFTy = FunctionType::get(Type::getVoidTy(C), NoTys, false);
  EXPECT_FALSE(TLI::isValidSignature(VoidFTy->getPointerTo(), DummyTy));

  // valid: pointer to function returning vector
  auto VFTy =
      FunctionType::get(VectorType::get(Type::getDoubleTy(C), 4), false);
  EXPECT_TRUE(TLI::isValidSignature(VFTy->getPointerTo(), DummyTy));

  // valid: pointer to function returning void with at least one vector
  // parameter
  Type *Tys[] = {Type::getDoublePtrTy(C),
                 VectorType::get(Type::getDoubleTy(C), 4)};
  auto VoidVFTy = FunctionType::get(Type::getVoidTy(C), Tys, false);
  EXPECT_TRUE(TLI::isValidSignature(VoidVFTy->getPointerTo(), DummyTy));
}

TEST(OpenMP, Mangle) {
  const std::string VF("vfoo");
  const std::string F("foo");
  const std::string Out = TargetLibraryInfoImpl::mangle(VF, F);

  EXPECT_STREQ("vec_prefix_vfoo_vec_midfix_foo_vec_postfix", Out.data());
}

TEST(OpenMP, Demangle) {
  StringRef In = "vec_prefix_vfoo_vec_midfix_foo_vec_postfix";

  const std::pair<std::string, std::string> Out =
      TargetLibraryInfoImpl::demangle(In);

  const StringRef VF = "vfoo";
  const StringRef F = "foo";

  EXPECT_EQ(VF, Out.first);
  EXPECT_EQ(F, Out.second);
}

TEST(OpenMPTest, NotValidGlobals) {
  LLVMContext C;
  std::unique_ptr<Module> M(new Module("Test", C));

  const std::string Mangled = TargetLibraryInfoImpl::mangle("vector", "scalar");
  const auto Ty = FunctionType::get(Type::getDoubleTy(C), false);
  M->getOrInsertFunction(Mangled, Ty);

  TargetLibraryInfoImpl TLII;
  TargetLibraryInfo TLI(TLII);
  TLII.addOpenMPVectorFunctions(M.get());
  EXPECT_FALSE(TLI.isFunctionVectorizable("scalar"));
}

TEST(OpenMPTest, ValidGlobals) {
  LLVMContext C;
  std::unique_ptr<Module> M(new Module("Test", C));

  const auto VFTy =
      FunctionType::get(VectorType::get(Type::getDoubleTy(C), 4), false);
  M->getOrInsertFunction("vec_prefix_vector_vec_midfix_scalar_vec_postfix", VFTy);

  TargetLibraryInfoImpl TLII;
  TargetLibraryInfo TLI(TLII);
  TLII.addOpenMPVectorFunctions(M.get());
  EXPECT_TRUE(TLI.isFunctionVectorizable("scalar"));
}
