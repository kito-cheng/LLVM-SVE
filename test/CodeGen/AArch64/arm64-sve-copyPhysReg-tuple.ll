; RUN: llc < %s -verify-machineinstrs -mtriple=arm64-none-linux-gnu -mattr=+sve | FileCheck %s

define <n x 4 x i32> @copyPhysReg.ZPR2Reg({<n x 4 x i32>, <n x 4 x i32>} %arg1,
                                          {<n x 4 x i32>, <n x 4 x i32>} %arg2) {
; CHECK-LABEL: copyPhysReg.ZPR2Reg:
; Shuffling two ZPR2 requires 6 mov's
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
  %res1 = tail call <n x 4 x i32> @foo.ZPR2({<n x 4 x i32>, <n x 4 x i32>} %arg2,
                                            {<n x 4 x i32>, <n x 4 x i32>} %arg1)
  %res2 = extractvalue {<n x 4 x i32>, <n x 4 x i32>} %arg1, 0
  %res = add <n x 4 x i32> %res1, %res2
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @copyPhysReg.ZPR3Reg({<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} %arg1,
                                          {<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} %arg2) {
; CHECK-LABEL: copyPhysReg.ZPR3Reg:
; Shuffling two ZPR3 requires 9 mov's
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
  %res1 = tail call <n x 4 x i32> @foo.ZPR3({<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} %arg2,
                                            {<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} %arg1)
  %res2 = extractvalue {<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} %arg1, 0
  %res = add <n x 4 x i32> %res1, %res2
  ret <n x 4 x i32> %res
}

define <n x 4 x i32> @copyPhysReg.ZPR4Reg({<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} %arg1,
                                          {<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} %arg2) {
; CHECK-LABEL: copyPhysReg.ZPR4Reg:
; Shuffling two ZPR4 requires 12 mov's
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
; CHECK: mov {{z[0-9]+.d}}, {{z[0-9]+.d}}
  %res1 = tail call <n x 4 x i32> @foo.ZPR4({<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} %arg2,
                                            {<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} %arg1)
  %res2 = extractvalue {<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>} %arg1, 0
  %res = add <n x 4 x i32> %res1, %res2
  ret <n x 4 x i32> %res
}

declare <n x 4 x i32> @foo.ZPR2({<n x 4 x i32>, <n x 4 x i32>},
                                {<n x 4 x i32>, <n x 4 x i32>})
declare <n x 4 x i32> @foo.ZPR3({<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>},
                                {<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>})
declare <n x 4 x i32> @foo.ZPR4({<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>},
                                {<n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>})
