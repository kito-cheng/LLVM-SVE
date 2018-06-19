; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

%stype1 = type { %opaqtype*, i32*, i32 }
%opaqtype = type opaque
%stype2 = type { i32, i32, i32, %opaqtype*, %stype1*, %opaqtype* }

; Check for a bug fix where the multiply for the scaling of the offsets was being lost.
define void @scale_with_zext(%stype1* %base, <n x 2 x i1> %p, <n x 2 x i32> %offs, <n x 2 x %stype2*> %val) {
; CHECK-LABEL: @scale_with_zext
; CHECK-DAG: mov [[SCALE:z[0-9]+]].d, #3
; CHECK-DAG: and z0.d, z0.d, #0xffffffff
; CHECK-DAG: ptrue [[PTRUE:p[0-9]+]].d
; CHECK: mul [[OFFS:z[0-9]+]].d, [[PTRUE]]/m, z0.d, [[SCALE]].d
; CHECK: st1d	{z1.d}, p0, [x0, [[OFFS]].d, lsl #3]
entry:
  %extoffs = zext <n x 2 x i32> %offs to <n x 2 x i64>
  %addrs = getelementptr %stype1, %stype1* %base, <n x 2 x i64> %extoffs
  %bc = bitcast <n x 2 x %stype1*> %addrs to <n x 2 x %stype2**>
  call void @llvm.masked.scatter.nxv2p0s_stype2s.nxv2p0p0s_stype2s(<n x 2 x %stype2*> %val, <n x 2 x %stype2**> %bc, i32 8, <n x 2 x i1> %p)
  ret void
}


declare void @llvm.masked.scatter.nxv2p0s_stype2s.nxv2p0p0s_stype2s(<n x 2 x %stype2*>, <n x 2 x %stype2**>, i32, <n x 2 x i1>)

