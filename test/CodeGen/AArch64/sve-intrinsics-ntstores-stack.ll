; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; STNT1B
;

define void @stnt1b_i8_off0(<n x 16 x i8> %data, <n x 16 x i1> %pred) {
  ; CHECK-LABEL: stnt1b_i8_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: stnt1b {z0.b}, p0, [sp]
  %stackobj = alloca <n x 16 x i8>, align 4
  call void @llvm.aarch64.sve.stnt1.nxv16i8(<n x 16 x i8> %data,
                                            <n x 16 x i1> %pred,
                                            <n x 16 x i8>* %stackobj)
  ret void
}

define void @stnt1b_i8_off1(<n x 16 x i8> %data, <n x 16 x i1> %pred) {
  ; CHECK-LABEL: stnt1b_i8_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: stnt1b {z0.b}, p0, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 16 x i8>], align 4
  %cast = bitcast [2 x <n x 16 x i8>]* %stackobj to <n x 16 x i8>*
  %gep = getelementptr <n x 16 x i8>, <n x 16 x i8>* %cast, i32 1
  call void @llvm.aarch64.sve.stnt1.nxv16i8(<n x 16 x i8> %data,
                                            <n x 16 x i1> %pred,
                                            <n x 16 x i8>* %gep)
  ret void
}

;
; STNT1H
;

define void @stnt1h_i16_off0(<n x 8 x i16> %data, <n x 8 x i1> %pred) {
  ; CHECK-LABEL: stnt1h_i16_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: stnt1h {z0.h}, p0, [sp]
  %stackobj = alloca <n x 8 x i16>, align 4
  call void @llvm.aarch64.sve.stnt1.nxv8i16(<n x 8 x i16> %data,
                                            <n x 8 x i1> %pred,
                                            <n x 8 x i16>* %stackobj)
  ret void
}

define void @stnt1h_i16_off1(<n x 8 x i16> %data, <n x 8 x i1> %pred) {
  ; CHECK-LABEL: stnt1h_i16_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: stnt1h {z0.h}, p0, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 8 x i16>], align 4
  %cast = bitcast [2 x <n x 8 x i16>]* %stackobj to <n x 8 x i16>*
  %gep = getelementptr <n x 8 x i16>, <n x 8 x i16>* %cast, i32 1
  call void @llvm.aarch64.sve.stnt1.nxv8i16(<n x 8 x i16> %data,
                                            <n x 8 x i1> %pred,
                                            <n x 8 x i16>* %gep)
  ret void
}

;
; STNT1W
;

define void @stnt1w_i32_off0(<n x 4 x i32> %data, <n x 4 x i1> %pred) {
  ; CHECK-LABEL: stnt1w_i32_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: stnt1w {z0.s}, p0, [sp]
  %stackobj = alloca <n x 4 x i32>, align 4
  call void @llvm.aarch64.sve.stnt1.nxv4i32(<n x 4 x i32> %data,
                                            <n x 4 x i1> %pred,
                                            <n x 4 x i32>* %stackobj)
  ret void
}

define void @stnt1w_i32_off1(<n x 4 x i32> %data, <n x 4 x i1> %pred) {
  ; CHECK-LABEL: stnt1w_i32_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: stnt1w {z0.s}, p0, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 4 x i32>], align 4
  %cast = bitcast [2 x <n x 4 x i32>]* %stackobj to <n x 4 x i32>*
  %gep = getelementptr <n x 4 x i32>, <n x 4 x i32>* %cast, i32 1
  call void @llvm.aarch64.sve.stnt1.nxv4i32(<n x 4 x i32> %data,
                                            <n x 4 x i1> %pred,
                                            <n x 4 x i32>* %gep)
  ret void
}

;
; STNT1W
;

define void @stnt1w_f32_off0(<n x 4 x float> %data, <n x 4 x i1> %pred) {
  ; CHECK-LABEL: stnt1w_f32_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: stnt1w {z0.s}, p0, [sp]
  %stackobj = alloca <n x 4 x float>, align 4
  call void @llvm.aarch64.sve.stnt1.nxv4f32(<n x 4 x float> %data,
                                            <n x 4 x i1> %pred,
                                            <n x 4 x float>* %stackobj)
  ret void
}

define void @stnt1w_f32_off1(<n x 4 x float> %data, <n x 4 x i1> %pred) {
  ; CHECK-LABEL: stnt1w_f32_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: stnt1w {z0.s}, p0, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 4 x float>], align 4
  %cast = bitcast [2 x <n x 4 x float>]* %stackobj to <n x 4 x float>*
  %gep = getelementptr <n x 4 x float>, <n x 4 x float>* %cast, i32 1
  call void @llvm.aarch64.sve.stnt1.nxv4f32(<n x 4 x float> %data,
                                            <n x 4 x i1> %pred,
                                            <n x 4 x float>* %gep)
  ret void
}

;
; STNT1D
;

define void @stnt1d_i64_off0(<n x 2 x i64> %data, <n x 2 x i1> %pred) {
  ; CHECK-LABEL: stnt1d_i64_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: stnt1d {z0.d}, p0, [sp]
  %stackobj = alloca <n x 2 x i64>, align 4
  call void @llvm.aarch64.sve.stnt1.nxv2i64(<n x 2 x i64> %data,
                                            <n x 2 x i1> %pred,
                                            <n x 2 x i64>* %stackobj)
  ret void
}

define void @stnt1d_i64_off1(<n x 2 x i64> %data, <n x 2 x i1> %pred) {
  ; CHECK-LABEL: stnt1d_i64_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: stnt1d {z0.d}, p0, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 2 x i64>], align 4
  %cast = bitcast [2 x <n x 2 x i64>]* %stackobj to <n x 2 x i64>*
  %gep = getelementptr <n x 2 x i64>, <n x 2 x i64>* %cast, i32 1
  call void @llvm.aarch64.sve.stnt1.nxv2i64(<n x 2 x i64> %data,
                                            <n x 2 x i1> %pred,
                                            <n x 2 x i64>* %gep)
  ret void
}

;
; STNT1D
;

define void @stnt1d_f64_off0(<n x 2 x double> %data, <n x 2 x i1> %pred) {
  ; CHECK-LABEL: stnt1d_f64_off0
  ; CHECK: addvl sp, sp, #-1
  ; CHECK: stnt1d {z0.d}, p0, [sp]
  %stackobj = alloca <n x 2 x double>, align 4
  call void @llvm.aarch64.sve.stnt1.nxv2f64(<n x 2 x double> %data,
                                            <n x 2 x i1> %pred,
                                            <n x 2 x double>* %stackobj)
  ret void
}

define void @stnt1d_f64_off1(<n x 2 x double> %data, <n x 2 x i1> %pred) {
  ; CHECK-LABEL: stnt1d_f64_off1
  ; CHECK: addvl sp, sp, #-2
  ; CHECK: mov [[BASE:x[0-9]+]], sp
  ; CHECK: stnt1d {z0.d}, p0, {{\[}}[[BASE]], #1, mul vl]
  %stackobj = alloca [2 x <n x 2 x double>], align 4
  %cast = bitcast [2 x <n x 2 x double>]* %stackobj to <n x 2 x double>*
  %gep = getelementptr <n x 2 x double>, <n x 2 x double>* %cast, i32 1
  call void @llvm.aarch64.sve.stnt1.nxv2f64(<n x 2 x double> %data,
                                            <n x 2 x i1> %pred,
                                            <n x 2 x double>* %gep)
  ret void
}

declare void @llvm.aarch64.sve.stnt1.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>*)
declare void @llvm.aarch64.sve.stnt1.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>*)
declare void @llvm.aarch64.sve.stnt1.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>*)
declare void @llvm.aarch64.sve.stnt1.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>*)
declare void @llvm.aarch64.sve.stnt1.nxv8f16(<n x 8 x half>, <n x 8 x i1>, <n x 8 x half>*)
declare void @llvm.aarch64.sve.stnt1.nxv4f32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x float>*)
declare void @llvm.aarch64.sve.stnt1.nxv2f64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x double>*)
