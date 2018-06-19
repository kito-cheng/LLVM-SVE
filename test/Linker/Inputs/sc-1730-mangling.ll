%struct.bar = type { i32, float }

define void @foo2(<n x 2 x %struct.bar*> %ptrs, <n x 2 x %struct.bar*>* %dst, <n x 2 x i1> %pred) {
  call void @llvm.masked.store.nxv2p0s_struct.bars.p0nxv2p0s_struct.bars(<n x 2 x %struct.bar*> %ptrs, <n x 2 x %struct.bar*>* %dst, i32 8, <n x 2 x i1> %pred)
  ret void
}

declare void @llvm.masked.store.nxv2p0s_struct.bars.p0nxv2p0s_struct.bars(<n x 2 x %struct.bar*>, <n x 2 x %struct.bar*>*, i32, <n x 2 x i1>)
