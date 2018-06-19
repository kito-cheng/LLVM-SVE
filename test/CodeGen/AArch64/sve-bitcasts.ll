; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

; Test we can bitcast between legal and illegal vector types.
define <n x 2 x half> @bitcast_nxv2f16(<n x 2 x half> %a, <n x 2 x i16> %mask) {
; CHECK-LABEL: bitcast_nxv2f16:
; CHECK: and z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %a.int = bitcast <n x 2 x half> %a to <n x 2 x i16>
  %a.masked = and <n x 2 x i16> %a.int, %mask
  %out = bitcast <n x 2 x i16> %a.masked to <n x 2 x half>
  ret <n x 2 x half> %out
}

define <n x 4 x half> @bitcast_nxv4f16(<n x 4 x half> %a, <n x 4 x i16> %mask) {
; CHECK-LABEL: bitcast_nxv4f16:
; CHECK: and z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %a.int = bitcast <n x 4 x half> %a to <n x 4 x i16>
  %a.masked = and <n x 4 x i16> %a.int, %mask
  %out = bitcast <n x 4 x i16> %a.masked to <n x 4 x half>
  ret <n x 4 x half> %out
}

define <n x 2 x float> @bitcast_nxv2f32(<n x 2 x float> %a, <n x 2 x i32> %mask) {
; CHECK-LABEL: bitcast_nxv2f32:
; CHECK: and z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %a.int = bitcast <n x 2 x float> %a to <n x 2 x i32>
  %a.masked = and <n x 2 x i32> %a.int, %mask
  %out = bitcast <n x 2 x i32> %a.masked to <n x 2 x float>
  ret <n x 2 x float> %out
}
