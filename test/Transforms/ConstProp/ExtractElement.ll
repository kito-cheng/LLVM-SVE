; RUN: opt < %s -constprop -S | FileCheck %s

; When the vector length is unknown all indicies become valid.
; CHECK-LABEL: @extractelement_unknown_vl
define i64 @extractelement_unknown_vl() {
  ; CHECK: ret i64 5
  %elt = extractelement <n x 4 x i64> stepvector, i64 5
  ret i64 %elt
}
