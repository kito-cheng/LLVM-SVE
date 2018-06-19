add_llvm_library(LLVMVectorize
  LoadStoreVectorizer.cpp
  LoopVectorize.cpp
  LVCommon.cpp
  SVELoopVectorize.cpp
  SLPVectorizer.cpp
  BOSCC.cpp
  Vectorize.cpp

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/IPO

  DEPENDS
  intrinsics_gen
  )
