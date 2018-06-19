; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; LDNT1B
;

define <n x 16 x i8> @ldnt1b_i8_off0(<n x 16 x i1> %pred) {
  ; CHECK-LABEL: ldnt1b_i8_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: ldnt1b {z0.b}, p0/z, [sp]
  %stackobj = alloca <n x 16 x i8>, align 4
  %ret = call <n x 16 x i8> @llvm.aarch64.sve.ldnt1.nxv16i8(<n x 16 x i1> %pred, <n x 16 x i8>* %stackobj)
  ret <n x 16 x i8> %ret
}

define <n x 16 x i8> @ldnt1b_i8_off1(<n x 16 x i1> %pred) {
  ; CHECK-LABEL: ldnt1b_i8_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: ldnt1b {z0.b}, p0/z, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 16 x i8>], align 4
  %cast = bitcast [2 x <n x 16 x i8>]* %stackobj to <n x 16 x i8>*
  %gep = getelementptr <n x 16 x i8>, <n x 16 x i8>* %cast, i32 1
  %ret = call <n x 16 x i8> @llvm.aarch64.sve.ldnt1.nxv16i8(<n x 16 x i1> %pred, <n x 16 x i8>* %gep)
  ret <n x 16 x i8> %ret
}

;
; LDNT1H
;

define <n x 8 x i16> @ldnt1h_i16_off0(<n x 8 x i1> %pred) {
  ; CHECK-LABEL: ldnt1h_i16_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: ldnt1h {z0.h}, p0/z, [sp]
  %stackobj = alloca <n x 8 x i16>, align 4
  %ret = call <n x 8 x i16> @llvm.aarch64.sve.ldnt1.nxv8i16(<n x 8 x i1> %pred, <n x 8 x i16>* %stackobj)
  ret <n x 8 x i16> %ret
}

define <n x 8 x i16> @ldnt1h_i16_off1(<n x 8 x i1> %pred) {
  ; CHECK-LABEL: ldnt1h_i16_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: ldnt1h {z0.h}, p0/z, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 8 x i16>], align 4
  %cast = bitcast [2 x <n x 8 x i16>]* %stackobj to <n x 8 x i16>*
  %gep = getelementptr <n x 8 x i16>, <n x 8 x i16>* %cast, i32 1
  %ret = call <n x 8 x i16> @llvm.aarch64.sve.ldnt1.nxv8i16(<n x 8 x i1> %pred, <n x 8 x i16>* %gep)
  ret <n x 8 x i16> %ret
}

;
; LDNT1W
;

define <n x 4 x i32> @ldnt1w_i32_off0(<n x 4 x i1> %pred) {
  ; CHECK-LABEL: ldnt1w_i32_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: ldnt1w {z0.s}, p0/z, [sp]
  %stackobj = alloca <n x 4 x i32>, align 4
  %ret = call <n x 4 x i32> @llvm.aarch64.sve.ldnt1.nxv4i32(<n x 4 x i1> %pred, <n x 4 x i32>* %stackobj)
  ret <n x 4 x i32> %ret
}

define <n x 4 x i32> @ldnt1w_i32_off1(<n x 4 x i1> %pred) {
  ; CHECK-LABEL: ldnt1w_i32_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: ldnt1w {z0.s}, p0/z, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 4 x i32>], align 4
  %cast = bitcast [2 x <n x 4 x i32>]* %stackobj to <n x 4 x i32>*
  %gep = getelementptr <n x 4 x i32>, <n x 4 x i32>* %cast, i32 1
  %ret = call <n x 4 x i32> @llvm.aarch64.sve.ldnt1.nxv4i32(<n x 4 x i1> %pred, <n x 4 x i32>* %gep)
  ret <n x 4 x i32> %ret
}

;
; LDNT1W
;

define <n x 4 x float> @ldnt1w_f32_off0(<n x 4 x i1> %pred) {
  ; CHECK-LABEL: ldnt1w_f32_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: ldnt1w {z0.s}, p0/z, [sp]
  %stackobj = alloca <n x 4 x float>, align 4
  %ret = call <n x 4 x float> @llvm.aarch64.sve.ldnt1.nxv4f32(<n x 4 x i1> %pred, <n x 4 x float>* %stackobj)
  ret <n x 4 x float> %ret
}

define <n x 4 x float> @ldnt1w_f32_off1(<n x 4 x i1> %pred) {
  ; CHECK-LABEL: ldnt1w_f32_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: ldnt1w {z0.s}, p0/z, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 4 x float>], align 4
  %cast = bitcast [2 x <n x 4 x float>]* %stackobj to <n x 4 x float>*
  %gep = getelementptr <n x 4 x float>, <n x 4 x float>* %cast, i32 1
  %ret = call <n x 4 x float> @llvm.aarch64.sve.ldnt1.nxv4f32(<n x 4 x i1> %pred, <n x 4 x float>* %gep)
  ret <n x 4 x float> %ret
}

;
; LDNT1D
;

define <n x 2 x i64> @ldnt1d_i64_off0(<n x 2 x i1> %pred) {
  ; CHECK-LABEL: ldnt1d_i64_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: ldnt1d {z0.d}, p0/z, [sp]
  %stackobj = alloca <n x 2 x i64>, align 4
  %ret = call <n x 2 x i64> @llvm.aarch64.sve.ldnt1.nxv2i64(<n x 2 x i1> %pred, <n x 2 x i64>* %stackobj)
  ret <n x 2 x i64> %ret
}

define <n x 2 x i64> @ldnt1d_i64_off1(<n x 2 x i1> %pred) {
  ; CHECK-LABEL: ldnt1d_i64_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: ldnt1d {z0.d}, p0/z, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 2 x i64>], align 4
  %cast = bitcast [2 x <n x 2 x i64>]* %stackobj to <n x 2 x i64>*
  %gep = getelementptr <n x 2 x i64>, <n x 2 x i64>* %cast, i32 1
  %ret = call <n x 2 x i64> @llvm.aarch64.sve.ldnt1.nxv2i64(<n x 2 x i1> %pred, <n x 2 x i64>* %gep)
  ret <n x 2 x i64> %ret
}

;
; LDNT1D
;

define <n x 2 x double> @ldnt1d_f64_off0(<n x 2 x i1> %pred) {
  ; CHECK-LABEL: ldnt1d_f64_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: ldnt1d {z0.d}, p0/z, [sp]
  %stackobj = alloca <n x 2 x double>, align 4
  %ret = call <n x 2 x double> @llvm.aarch64.sve.ldnt1.nxv2f64(<n x 2 x i1> %pred, <n x 2 x double>* %stackobj)
  ret <n x 2 x double> %ret
}

define <n x 2 x double>  @ldnt1d_f64_off1(<n x 2 x i1> %pred) {
  ; CHECK-LABEL: ldnt1d_f64_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: ldnt1d {z0.d}, p0/z, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 2 x double>], align 4
  %cast = bitcast [2 x <n x 2 x double>]* %stackobj to <n x 2 x double>*
  %gep = getelementptr <n x 2 x double>, <n x 2 x double>* %cast, i32 1
  %ret = call <n x 2 x double> @llvm.aarch64.sve.ldnt1.nxv2f64(<n x 2 x i1> %pred, <n x 2 x double>* %gep)
  ret <n x 2 x double> %ret
}

declare <n x 16 x i8> @llvm.aarch64.sve.ldnt1.nxv16i8(<n x 16 x i1>, <n x 16 x i8>*)
declare <n x 8 x i16> @llvm.aarch64.sve.ldnt1.nxv8i16(<n x 8 x i1>, <n x 8 x i16>*)
declare <n x 4 x i32> @llvm.aarch64.sve.ldnt1.nxv4i32(<n x 4 x i1>, <n x 4 x i32>*)
declare <n x 2 x i64> @llvm.aarch64.sve.ldnt1.nxv2i64(<n x 2 x i1>, <n x 2 x i64>*)
declare <n x 8 x half> @llvm.aarch64.sve.ldnt1.nxv8f16(<n x 8 x i1>, <n x 8 x half>*)
declare <n x 4 x float> @llvm.aarch64.sve.ldnt1.nxv4f32(<n x 4 x i1>, <n x 4 x float>*)
declare <n x 2 x double> @llvm.aarch64.sve.ldnt1.nxv2f64(<n x 2 x i1>, <n x 2 x double>*)
