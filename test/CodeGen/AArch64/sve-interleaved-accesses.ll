; RUN: llc -mtriple=aarch64 -O3 -sve-lower-gather-scatter-to-interleaved=true -sve-igs-all-blocks -mattr=+sve < %s | FileCheck %s
; RUN: llc -mtriple=aarch64 -O3 -sve-lower-gather-scatter-to-interleaved=true -sve-igs-allow-unsafe-loads -sve-igs-all-blocks -mattr=+sve < %s | FileCheck %s -check-prefix=UNSAFE-LOADS

; TODO: add st2 with partial stores where there is a matching ld2.
; TODO: doesn't deal with negative strides yet

; *************** ST2 *******************
declare void @llvm.masked.scatter.nxv16i8.nxv16p0i8(<n x 16 x i8>, <n x 16 x i8*>, i32, <n x 16 x i1>)
declare void @llvm.masked.scatter.nxv8i16.nxv8p0i16(<n x 8 x i16>, <n x 8 x i16*>, i32, <n x 8 x i1>)
declare void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32>, <n x 4 x i32*>, i32, <n x 4 x i1>)
declare void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64>, <n x 2 x i64*>, i32, <n x 2 x i1>)
declare void @llvm.masked.scatter.nxv4f32.nxv4p0f32(<n x 4 x float>, <n x 4 x float*>, i32, <n x 4 x i1>)
declare void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double>, <n x 2 x double*>, i32, <n x 2 x i1>)

; CHECK-LABEL: st2_2_i8:
; The interleaved gather scatter pass adds an extract instruction on the address
; ptr - the below fmov check verifies that it is not code generated.  The same
; holds for all these tests, but it only needs verifying once
; CHECK-NOT: fmov
; CHECK: st2b {z0.b, z1.b}, p0, [{{x[0-9]+}}
; CHECK-NOT: st2b
define void @st2_2_i8(<n x 16 x i8> %val1, <n x 16 x i8> %val2, i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep1 = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  call void @llvm.masked.scatter.nxv16i8.nxv16p0i8(<n x 16 x i8> %val1, <n x 16 x i8*> %gep1, i32 4, <n x 16 x i1> %predicate)
  %ptr2 = getelementptr i8, i8* %ptr, i8 1
  %gep2 = getelementptr i8, i8* %ptr2, <n x 16 x i64> %sv
  call void @llvm.masked.scatter.nxv16i8.nxv16p0i8(<n x 16 x i8> %val2, <n x 16 x i8*> %gep2, i32 4, <n x 16 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st2_2_i16:
; CHECK: st2h {z0.h, z1.h}, p0, [{{x[0-9]+}}
; CHECK-NOT: st2h
define void @st2_2_i16(<n x 8 x i16> %val1, <n x 8 x i16> %val2, i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep1 = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  call void @llvm.masked.scatter.nxv8i16.nxv8p0i16(<n x 8 x i16> %val1, <n x 8 x i16*> %gep1, i32 4, <n x 8 x i1> %predicate)
  %ptr2 = getelementptr i16, i16* %ptr, i16 1
  %gep2 = getelementptr i16, i16* %ptr2, <n x 8 x i64> %sv
  call void @llvm.masked.scatter.nxv8i16.nxv8p0i16(<n x 8 x i16> %val2, <n x 8 x i16*> %gep2, i32 4, <n x 8 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st2_2_i32:
; CHECK: st2w {z0.s, z1.s}, p0, [{{x[0-9]+}}
; CHECK-NOT: st2w
define void @st2_2_i32(<n x 4 x i32> %val1, <n x 4 x i32> %val2, i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %val1, <n x 4 x i32*> %gep1, i32 4, <n x 4 x i1> %predicate)
  %ptr2 = getelementptr i32, i32* %ptr, i32 1
  %gep2 = getelementptr i32, i32* %ptr2, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %val2, <n x 4 x i32*> %gep2, i32 4, <n x 4 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st2_2_i64:
; CHECK: st2d {z0.d, z1.d}, p0, [{{x[0-9]+}}
; CHECK-NOT: st2d
define void @st2_2_i64(<n x 2 x i64> %val1, <n x 2 x i64> %val2, i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %val1, <n x 2 x i64*> %gep1, i32 4, <n x 2 x i1> %predicate)
  %ptr2 = getelementptr i64, i64* %ptr, i64 1
  %gep2 = getelementptr i64, i64* %ptr2, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %val2, <n x 2 x i64*> %gep2, i32 4, <n x 2 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st2_2_float:
; CHECK: st2w {z0.s, z1.s}, p0, [{{x[0-9]+}}
; CHECK-NOT: st2w
define void @st2_2_float(<n x 4 x float> %val1, <n x 4 x float> %val2, float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4f32.nxv4p0f32(<n x 4 x float> %val1, <n x 4 x float*> %gep1, i32 4, <n x 4 x i1> %predicate)
  %ptr2 = getelementptr float, float* %ptr, i32 1
  %gep2 = getelementptr float, float* %ptr2, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4f32.nxv4p0f32(<n x 4 x float> %val2, <n x 4 x float*> %gep2, i32 4, <n x 4 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st2_2_double:
; CHECK: st2d {z0.d, z1.d}, p0, [{{x[0-9]+}}
; CHECK-NOT: st2d
define void @st2_2_double(<n x 2 x double> %val1, <n x 2 x double> %val2, double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %gep1, i32 4, <n x 2 x i1> %predicate)
  %ptr2 = getelementptr double, double* %ptr, i64 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %gep2, i32 4, <n x 2 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st2_double_i64:
; CHECK: st2d {z0.d, z1.d}, p0, [{{x[0-9]+}}
; CHECK-NOT: st2d
define void @st2_double_i64(<n x 2 x double> %val1, <n x 2 x i64> %val2, double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %gep1, i32 4, <n x 2 x i1> %predicate)
  %ptr2 = getelementptr double, double* %ptr, i64 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  %bitcast = bitcast <n x 2 x double*> %gep2 to <n x 2 x i64*>
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %val2, <n x 2 x i64*> %bitcast, i32 4, <n x 2 x i1> %predicate)
  ret void
}

; *************** ST3 *******************

; CHECK-LABEL: st3_3_i8:
; CHECK: st3b {z0.b, z1.b, z2.b}, p0, [{{x[0-9]+}}
; CHECK-NOT: st3b
define void @st3_3_i8(<n x 16 x i8> %val1, <n x 16 x i8> %val2, <n x 16 x i8> %val3, i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep1 = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  call void @llvm.masked.scatter.nxv16i8.nxv16p0i8(<n x 16 x i8> %val1, <n x 16 x i8*> %gep1, i32 4, <n x 16 x i1> %predicate)
  %ptr2 = getelementptr i8, i8* %ptr, i8 1
  %gep2 = getelementptr i8, i8* %ptr2, <n x 16 x i64> %sv
  call void @llvm.masked.scatter.nxv16i8.nxv16p0i8(<n x 16 x i8> %val2, <n x 16 x i8*> %gep2, i32 4, <n x 16 x i1> %predicate)
  %ptr3 = getelementptr i8, i8* %ptr, i32 2
  %gep3 = getelementptr i8, i8* %ptr3, <n x 16 x i64> %sv
  call void @llvm.masked.scatter.nxv16i8.nxv16p0i8(<n x 16 x i8> %val3, <n x 16 x i8*> %gep3, i32 4, <n x 16 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st3_3_i16:
; CHECK: st3h {z0.h, z1.h, z2.h}, p0, [{{x[0-9]+}}
; CHECK-NOT: st3h
define void @st3_3_i16(<n x 8 x i16> %val1, <n x 8 x i16> %val2, <n x 8 x i16> %val3, i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep1 = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  call void @llvm.masked.scatter.nxv8i16.nxv8p0i16(<n x 8 x i16> %val1, <n x 8 x i16*> %gep1, i32 4, <n x 8 x i1> %predicate)
  %ptr2 = getelementptr i16, i16* %ptr, i16 1
  %gep2 = getelementptr i16, i16* %ptr2, <n x 8 x i64> %sv
  call void @llvm.masked.scatter.nxv8i16.nxv8p0i16(<n x 8 x i16> %val2, <n x 8 x i16*> %gep2, i32 4, <n x 8 x i1> %predicate)
  %ptr3 = getelementptr i16, i16* %ptr, i32 2
  %gep3 = getelementptr i16, i16* %ptr3, <n x 8 x i64> %sv
  call void @llvm.masked.scatter.nxv8i16.nxv8p0i16(<n x 8 x i16> %val3, <n x 8 x i16*> %gep3, i32 4, <n x 8 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st3_3_i32:
; CHECK: st3w {z0.s, z1.s, z2.s}, p0, [{{x[0-9]+}}
; CHECK-NOT: st3w
define void @st3_3_i32(<n x 4 x i32> %val1, <n x 4 x i32> %val2, <n x 4 x i32> %val3, i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %val1, <n x 4 x i32*> %gep1, i32 4, <n x 4 x i1> %predicate)
  %ptr2 = getelementptr i32, i32* %ptr, i32 1
  %gep2 = getelementptr i32, i32* %ptr2, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %val2, <n x 4 x i32*> %gep2, i32 4, <n x 4 x i1> %predicate)
  %ptr3 = getelementptr i32, i32* %ptr, i32 2
  %gep3 = getelementptr i32, i32* %ptr3, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %val3, <n x 4 x i32*> %gep3, i32 4, <n x 4 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st3_3_i64:
; CHECK: st3d {z0.d, z1.d, z2.d}, p0, [{{x[0-9]+}}
; CHECK-NOT: st3d
define void @st3_3_i64(<n x 2 x i64> %val1, <n x 2 x i64> %val2, <n x 2 x i64> %val3, i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %val1, <n x 2 x i64*> %gep1, i32 4, <n x 2 x i1> %predicate)
  %ptr2 = getelementptr i64, i64* %ptr, i64 1
  %gep2 = getelementptr i64, i64* %ptr2, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %val2, <n x 2 x i64*> %gep2, i32 4, <n x 2 x i1> %predicate)
  %ptr3 = getelementptr i64, i64* %ptr, i32 2
  %gep3 = getelementptr i64, i64* %ptr3, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %val3, <n x 2 x i64*> %gep3, i32 4, <n x 2 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st3_3_float:
; CHECK: st3w {z0.s, z1.s, z2.s}, p0, [{{x[0-9]+}}
; CHECK-NOT: st3w
define void @st3_3_float(<n x 4 x float> %val1, <n x 4 x float> %val2, <n x 4 x float> %val3, float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4f32.nxv4p0f32(<n x 4 x float> %val1, <n x 4 x float*> %gep1, i32 4, <n x 4 x i1> %predicate)
  %ptr2 = getelementptr float, float* %ptr, i32 1
  %gep2 = getelementptr float, float* %ptr2, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4f32.nxv4p0f32(<n x 4 x float> %val2, <n x 4 x float*> %gep2, i32 4, <n x 4 x i1> %predicate)
  %ptr3 = getelementptr float, float* %ptr, i32 2
  %gep3 = getelementptr float, float* %ptr3, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4f32.nxv4p0f32(<n x 4 x float> %val3, <n x 4 x float*> %gep3, i32 4, <n x 4 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st3_3_double:
; CHECK: st3d {z0.d, z1.d, z2.d}, p0, [{{x[0-9]+}}
; CHECK-NOT: st3d
define void @st3_3_double(<n x 2 x double> %val1, <n x 2 x double> %val2, <n x 2 x double> %val3, double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %gep1, i32 4, <n x 2 x i1> %predicate)
  %ptr2 = getelementptr double, double* %ptr, i64 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %gep2, i32 4, <n x 2 x i1> %predicate)
  %ptr3 = getelementptr double, double* %ptr, i32 2
  %gep3 = getelementptr double, double* %ptr3, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val3, <n x 2 x double*> %gep3, i32 4, <n x 2 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st3_6_double:
; CHECK-DAG: zip1 [[PEVEN:p[0-9]+]].d, p0.d, p0.d
; CHECK-DAG: zip2  [[PODD:p[0-9]+]].d, p0.d, p0.d
; CHECK-DAG: zip1 [[LO1:z[0-9]+]].d, z0.d, z3.d
; CHECK-DAG: zip2 [[HI1:z[0-9]+]].d, z0.d, z3.d
; CHECK-DAG: zip1 [[LO2:z[0-9]+]].d, z1.d, z4.d
; CHECK-DAG: zip2 [[HI2:z[0-9]+]].d, z1.d, z4.d
; CHECK-DAG: zip1 [[LO3:z[0-9]+]].d, z2.d, z5.d
; CHECK-DAG: zip2 [[HI3:z[0-9]+]].d, z2.d, z5.d
; CHECK: st3d {[[LO1]].d, [[LO2]].d, [[LO3]].d}
; CHECK: st3d {[[HI1]].d, [[HI2]].d, [[HI3]].d}
define void @st3_6_double(<n x 2 x double> %val1, <n x 2 x double> %val2, <n x 2 x double> %val3, <n x 2 x double> %val4, <n x 2 x double> %val5, <n x 2 x double> %val6, double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 6, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %gep1, i32 4, <n x 2 x i1> %predicate)
  %ptr2 = getelementptr double, double* %ptr, i64 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %gep2, i32 4, <n x 2 x i1> %predicate)
  %ptr3 = getelementptr double, double* %ptr, i32 2
  %gep3 = getelementptr double, double* %ptr3, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val3, <n x 2 x double*> %gep3, i32 4, <n x 2 x i1> %predicate)
  %ptr4 = getelementptr double, double* %ptr, i32 3
  %gep4 = getelementptr double, double* %ptr4, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val4, <n x 2 x double*> %gep4, i32 4, <n x 2 x i1> %predicate)
  %ptr5 = getelementptr double, double* %ptr, i32 4
  %gep5 = getelementptr double, double* %ptr5, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val5, <n x 2 x double*> %gep5, i32 4, <n x 2 x i1> %predicate)
  %ptr6 = getelementptr double, double* %ptr, i32 5
  %gep6 = getelementptr double, double* %ptr6, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val6, <n x 2 x double*> %gep6, i32 4, <n x 2 x i1> %predicate)
  ret void
}

; *************** ST4 *******************

; CHECK-LABEL: st4_4_i8:
; CHECK: st4b {z0.b, z1.b, z2.b, z3.b}, p0, [{{x[0-9]+}}
; CHECK-NOT: st4b
define void @st4_4_i8(<n x 16 x i8> %val1, <n x 16 x i8> %val2, <n x 16 x i8> %val3, <n x 16 x i8> %val4, i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep1 = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  call void @llvm.masked.scatter.nxv16i8.nxv16p0i8(<n x 16 x i8> %val1, <n x 16 x i8*> %gep1, i32 4, <n x 16 x i1> %predicate)
  %ptr2 = getelementptr i8, i8* %ptr, i8 1
  %gep2 = getelementptr i8, i8* %ptr2, <n x 16 x i64> %sv
  call void @llvm.masked.scatter.nxv16i8.nxv16p0i8(<n x 16 x i8> %val2, <n x 16 x i8*> %gep2, i32 4, <n x 16 x i1> %predicate)
  %ptr3 = getelementptr i8, i8* %ptr, i32 2
  %gep3 = getelementptr i8, i8* %ptr3, <n x 16 x i64> %sv
  call void @llvm.masked.scatter.nxv16i8.nxv16p0i8(<n x 16 x i8> %val3, <n x 16 x i8*> %gep3, i32 4, <n x 16 x i1> %predicate)
  %ptr4 = getelementptr i8, i8* %ptr, i32 3
  %gep4 = getelementptr i8, i8* %ptr4, <n x 16 x i64> %sv
  call void @llvm.masked.scatter.nxv16i8.nxv16p0i8(<n x 16 x i8> %val4, <n x 16 x i8*> %gep4, i32 4, <n x 16 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st4_4_i16:
; CHECK: st4h {z0.h, z1.h, z2.h, z3.h}, p0, [{{x[0-9]+}}
; CHECK-NOT: st4h
define void @st4_4_i16(<n x 8 x i16> %val1, <n x 8 x i16> %val2, <n x 8 x i16> %val3, <n x 8 x i16> %val4, i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep1 = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  call void @llvm.masked.scatter.nxv8i16.nxv8p0i16(<n x 8 x i16> %val1, <n x 8 x i16*> %gep1, i32 4, <n x 8 x i1> %predicate)
  %ptr2 = getelementptr i16, i16* %ptr, i16 1
  %gep2 = getelementptr i16, i16* %ptr2, <n x 8 x i64> %sv
  call void @llvm.masked.scatter.nxv8i16.nxv8p0i16(<n x 8 x i16> %val2, <n x 8 x i16*> %gep2, i32 4, <n x 8 x i1> %predicate)
  %ptr3 = getelementptr i16, i16* %ptr, i32 2
  %gep3 = getelementptr i16, i16* %ptr3, <n x 8 x i64> %sv
  call void @llvm.masked.scatter.nxv8i16.nxv8p0i16(<n x 8 x i16> %val3, <n x 8 x i16*> %gep3, i32 4, <n x 8 x i1> %predicate)
  %ptr4 = getelementptr i16, i16* %ptr, i32 3
  %gep4 = getelementptr i16, i16* %ptr4, <n x 8 x i64> %sv
  call void @llvm.masked.scatter.nxv8i16.nxv8p0i16(<n x 8 x i16> %val4, <n x 8 x i16*> %gep4, i32 4, <n x 8 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st4_4_i32:
; CHECK: st4w {z0.s, z1.s, z2.s, z3.s}, p0, [{{x[0-9]+}}
; CHECK-NOT: st4w
define void @st4_4_i32(<n x 4 x i32> %val1, <n x 4 x i32> %val2, <n x 4 x i32> %val3, <n x 4 x i32> %val4, i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %val1, <n x 4 x i32*> %gep1, i32 4, <n x 4 x i1> %predicate)
  %ptr2 = getelementptr i32, i32* %ptr, i32 1
  %gep2 = getelementptr i32, i32* %ptr2, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %val2, <n x 4 x i32*> %gep2, i32 4, <n x 4 x i1> %predicate)
  %ptr3 = getelementptr i32, i32* %ptr, i32 2
  %gep3 = getelementptr i32, i32* %ptr3, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %val3, <n x 4 x i32*> %gep3, i32 4, <n x 4 x i1> %predicate)
  %ptr4 = getelementptr i32, i32* %ptr, i32 3
  %gep4 = getelementptr i32, i32* %ptr4, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4i32.nxv4p0i32(<n x 4 x i32> %val4, <n x 4 x i32*> %gep4, i32 4, <n x 4 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st4_4_i64:
; CHECK: st4d {z0.d, z1.d, z2.d, z3.d}, p0, [{{x[0-9]+}}
; CHECK-NOT: st4d
define void @st4_4_i64(<n x 2 x i64> %val1, <n x 2 x i64> %val2, <n x 2 x i64> %val3, <n x 2 x i64> %val4, i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %val1, <n x 2 x i64*> %gep1, i32 4, <n x 2 x i1> %predicate)
  %ptr2 = getelementptr i64, i64* %ptr, i64 1
  %gep2 = getelementptr i64, i64* %ptr2, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %val2, <n x 2 x i64*> %gep2, i32 4, <n x 2 x i1> %predicate)
  %ptr3 = getelementptr i64, i64* %ptr, i32 2
  %gep3 = getelementptr i64, i64* %ptr3, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %val3, <n x 2 x i64*> %gep3, i32 4, <n x 2 x i1> %predicate)
  %ptr4 = getelementptr i64, i64* %ptr, i32 3
  %gep4 = getelementptr i64, i64* %ptr4, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %val4, <n x 2 x i64*> %gep4, i32 4, <n x 2 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st4_4_float:
; CHECK: st4w {z0.s, z1.s, z2.s, z3.s}, p0, [{{x[0-9]+}}
; CHECK-NOT: st4w
define void @st4_4_float(<n x 4 x float> %val1, <n x 4 x float> %val2, <n x 4 x float> %val3, <n x 4 x float> %val4, float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4f32.nxv4p0f32(<n x 4 x float> %val1, <n x 4 x float*> %gep1, i32 4, <n x 4 x i1> %predicate)
  %ptr2 = getelementptr float, float* %ptr, i32 1
  %gep2 = getelementptr float, float* %ptr2, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4f32.nxv4p0f32(<n x 4 x float> %val2, <n x 4 x float*> %gep2, i32 4, <n x 4 x i1> %predicate)
  %ptr3 = getelementptr float, float* %ptr, i32 2
  %gep3 = getelementptr float, float* %ptr3, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4f32.nxv4p0f32(<n x 4 x float> %val3, <n x 4 x float*> %gep3, i32 4, <n x 4 x i1> %predicate)
  %ptr4 = getelementptr float, float* %ptr, i32 3
  %gep4 = getelementptr float, float* %ptr4, <n x 4 x i64> %sv
  call void @llvm.masked.scatter.nxv4f32.nxv4p0f32(<n x 4 x float> %val4, <n x 4 x float*> %gep4, i32 4, <n x 4 x i1> %predicate)
  ret void
}

; CHECK-LABEL: st4_4_double:
; CHECK: st4d {z0.d, z1.d, z2.d, z3.d}, p0, [{{x[0-9]+}}
; CHECK-NOT: st4d
define void @st4_4_double(<n x 2 x double> %val1, <n x 2 x double> %val2, <n x 2 x double> %val3, <n x 2 x double> %val4, double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %gep1, i32 4, <n x 2 x i1> %predicate)
  %ptr2 = getelementptr double, double* %ptr, i64 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %gep2, i32 4, <n x 2 x i1> %predicate)
  %ptr3 = getelementptr double, double* %ptr, i32 2
  %gep3 = getelementptr double, double* %ptr3, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val3, <n x 2 x double*> %gep3, i32 4, <n x 2 x i1> %predicate)
  %ptr4 = getelementptr double, double* %ptr, i32 3
  %gep4 = getelementptr double, double* %ptr4, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val4, <n x 2 x double*> %gep4, i32 4, <n x 2 x i1> %predicate)
  ret void
}

; *************** LD2 *******************

declare <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*>, i32, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*>, i32, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*>, i32, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*>, i32, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*>, i32, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*>, i32, <n x 2 x i1>, <n x 2 x double>)

; CHECK-LABEL: ld2_1_i8:
; CHECK-NOT: ld2b
; UNSAFE-LOADS-LABEL: ld2_1_i8:
; The interleaved gather scatter pass adds an extract instruction on the address
; ptr - the below fmov check verifies that it is not code generated.  The same
; holds for all these tests, but it only needs verifying once
; UNSAFE-LOADS-NOT: fmov
; UNSAFE-LOADS: ld2b {z0.b, z1.b}, p0/z, [{{x[0-9]+}}
define <n x 16 x i8> @ld2_1_i8(i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  %res = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  ret <n x 16 x i8> %res
}

; CHECK-LABEL: ld2_2_i8:
; CHECK: ld2b {z0.b, z1.b}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld2b
define <n x 16 x i8> @ld2_2_i8(i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep1 = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  %res1 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep1, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %ptr2 = getelementptr i8, i8* %ptr, i8 1
  %gep2 = getelementptr i8, i8* %ptr2, <n x 16 x i64> %sv
  %res2 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep2, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %res = add <n x 16 x i8> %res1, %res2
  ret <n x 16 x i8> %res
}

; CHECK-LABEL: ld2_1_i16:
; CHECK-NOT: ld2h
; UNSAFE-LOADS-LABEL: ld2_1_i16:
; UNSAFE-LOADS: ld2h {z0.h, z1.h}, p0/z, [{{x[0-9]+}}
define <n x 8 x i16> @ld2_1_i16(i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  %res = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  ret <n x 8 x i16> %res
}

; CHECK-LABEL: ld2_2_i16:
; CHECK: ld2h {z0.h, z1.h}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld2h
define <n x 8 x i16> @ld2_2_i16(i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep1 = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  %res1 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep1, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %ptr2 = getelementptr i16, i16* %ptr, i16 1
  %gep2 = getelementptr i16, i16* %ptr2, <n x 8 x i64> %sv
  %res2 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep2, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %res = add <n x 8 x i16> %res1, %res2
  ret <n x 8 x i16> %res
}

; CHECK-LABEL: ld2_1_i32:
; CHECK-NOT: ld2w
; UNSAFE-LOADS-LABEL: ld2_1_i32:
; UNSAFE-LOADS: ld2w {z0.s, z1.s}, p0/z, [{{x[0-9]+}}
define <n x 4 x i32> @ld2_1_i32(i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  %res = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  ret <n x 4 x i32> %res
}

; CHECK-LABEL: ld2_2_i32:
; CHECK: ld2w {z0.s, z1.s}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld2w
define <n x 4 x i32> @ld2_2_i32(i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %ptr2 = getelementptr i32, i32* %ptr, i32 1
  %gep2 = getelementptr i32, i32* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %res = add <n x 4 x i32> %res1, %res2
  ret <n x 4 x i32> %res
}

; CHECK-LABEL: ld2_1_i64:
; CHECK-NOT: ld2d
; UNSAFE-LOADS-LABEL: ld2_1_i64:
; UNSAFE-LOADS: ld2d {z0.d, z1.d}, p0/z, [{{x[0-9]+}}
define <n x 2 x i64> @ld2_1_i64(i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  %res = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  ret <n x 2 x i64> %res
}

; CHECK-LABEL: ld2_2_i64:
; CHECK: ld2d {z0.d, z1.d}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld2d
define <n x 2 x i64> @ld2_2_i64(i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep1, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %ptr2 = getelementptr i64, i64* %ptr, i32 1
  %gep2 = getelementptr i64, i64* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep2, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %res = add <n x 2 x i64> %res1, %res2
  ret <n x 2 x i64> %res
}

; CHECK-LABEL: ld2_1_float:
; CHECK-NOT: ld2w
; UNSAFE-LOADS-LABEL: ld2_1_float:
; UNSAFE-LOADS: ld2w {z0.s, z1.s}, p0/z, [{{x[0-9]+}}
define <n x 4 x float> @ld2_1_float(float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  %res = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  ret <n x 4 x float> %res
}

; CHECK-LABEL: ld2_2_float:
; CHECK: ld2w {z0.s, z1.s}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld2w
define <n x 4 x float> @ld2_2_float(float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %ptr2 = getelementptr float, float* %ptr, i32 1
  %gep2 = getelementptr float, float* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %res = fadd <n x 4 x float> %res1, %res2
  ret <n x 4 x float> %res
}

; CHECK-LABEL: ld2_1_double:
; CHECK-NOT: ld2d
; UNSAFE-LOADS-LABEL: ld2_1_double:
; UNSAFE-LOADS: ld2d {z0.d, z1.d}, p0/z, [{{x[0-9]+}}
define <n x 2 x double> @ld2_1_double(double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  %res = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  ret <n x 2 x double> %res
}

; CHECK-LABEL: ld2_2_double:
; CHECK: ld2d {z0.d, z1.d}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld2d
define <n x 2 x double> @ld2_2_double(double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep1, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr2 = getelementptr double, double* %ptr, i32 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep2, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res = fadd <n x 2 x double> %res1, %res2
  ret <n x 2 x double> %res
}

; *************** LD3 *******************

; CHECK-LABEL: ld3_1_i8:
; CHECK-NOT: ld3b
; UNSAFE-LOADS-LABEL: ld3_1_i8:
; UNSAFE-LOADS: ld3b {z0.b, z1.b, z2.b}, p0/z, [{{x[0-9]+}}
define <n x 16 x i8> @ld3_1_i8(i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  %res = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  ret <n x 16 x i8> %res
}

; CHECK-LABEL: ld3_2_i8:
; CHECK-NOT: ld3b
; UNSAFE-LOADS-LABEL: ld3_2_i8:
; UNSAFE-LOADS: ld3b {z0.b, z1.b, z2.b}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld3b
; UNSAFE-LOADS: ret
define <n x 16 x i8> @ld3_2_i8(i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep1 = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  %res1 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep1, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %ptr2 = getelementptr i8, i8* %ptr, i8 1
  %gep2 = getelementptr i8, i8* %ptr2, <n x 16 x i64> %sv
  %res2 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep2, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %res = add <n x 16 x i8> %res1, %res2
  ret <n x 16 x i8> %res
}

; CHECK-LABEL: ld3_3_i8:
; CHECK: ld3b {z0.b, z1.b, z2.b}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld3b
define <n x 16 x i8> @ld3_3_i8(i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep1 = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  %res1 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep1, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %ptr2 = getelementptr i8, i8* %ptr, i8 1
  %gep2 = getelementptr i8, i8* %ptr2, <n x 16 x i64> %sv
  %res2 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep2, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %ptr3 = getelementptr i8, i8* %ptr, i8 2
  %gep3 = getelementptr i8, i8* %ptr3, <n x 16 x i64> %sv
  %res3 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep3, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %res12 = add <n x 16 x i8> %res1, %res2
  %res = add <n x 16 x i8> %res12, %res3
  ret <n x 16 x i8> %res
}

; CHECK-LABEL: ld3_1_i16:
; CHECK-NOT: ld3h
; UNSAFE-LOADS-LABEL: ld3_1_i16:
; UNSAFE-LOADS: ld3h {z0.h, z1.h, z2.h}, p0/z, [{{x[0-9]+}}
define <n x 8 x i16> @ld3_1_i16(i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  %res = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  ret <n x 8 x i16> %res
}

; CHECK-LABEL: ld3_2_i16:
; CHECK-NOT: ld3h
; UNSAFE-LOADS-LABEL: ld3_2_i16:
; UNSAFE-LOADS: ld3h {z0.h, z1.h, z2.h}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld3h
; UNSAFE-LOADS: ret
define <n x 8 x i16> @ld3_2_i16(i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep1 = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  %res1 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep1, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %ptr2 = getelementptr i16, i16* %ptr, i16 1
  %gep2 = getelementptr i16, i16* %ptr2, <n x 8 x i64> %sv
  %res2 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep2, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %res = add <n x 8 x i16> %res1, %res2
  ret <n x 8 x i16> %res
}

; CHECK-LABEL: ld3_3_i16:
; CHECK: ld3h {z0.h, z1.h, z2.h}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld3h
define <n x 8 x i16> @ld3_3_i16(i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep1 = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  %res1 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep1, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %ptr2 = getelementptr i16, i16* %ptr, i16 1
  %gep2 = getelementptr i16, i16* %ptr2, <n x 8 x i64> %sv
  %res2 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep2, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %ptr3 = getelementptr i16, i16* %ptr, i16 2
  %gep3 = getelementptr i16, i16* %ptr3, <n x 8 x i64> %sv
  %res3 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep3, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %res12 = add <n x 8 x i16> %res1, %res2
  %res = add <n x 8 x i16> %res12, %res3
  ret <n x 8 x i16> %res
}

; CHECK-LABEL: ld3_1_i32:
; CHECK-NOT: ld3w
; UNSAFE-LOADS-LABEL: ld3_1_i32:
; UNSAFE-LOADS: ld3w {z0.s, z1.s, z2.s}, p0/z, [{{x[0-9]+}}
define <n x 4 x i32> @ld3_1_i32(i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  %res = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  ret <n x 4 x i32> %res
}

; CHECK-LABEL: ld3_2_i32:
; CHECK-NOT: ld3w
; UNSAFE-LOADS-LABEL: ld3_2_i32:
; UNSAFE-LOADS: ld3w {z0.s, z1.s, z2.s}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld3w
; UNSAFE-LOADS: ret
define <n x 4 x i32> @ld3_2_i32(i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %ptr2 = getelementptr i32, i32* %ptr, i32 1
  %gep2 = getelementptr i32, i32* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %res = add <n x 4 x i32> %res1, %res2
  ret <n x 4 x i32> %res
}

; CHECK-LABEL: ld3_3_i32:
; CHECK: ld3w {z0.s, z1.s, z2.s}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld3w
define <n x 4 x i32> @ld3_3_i32(i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %ptr2 = getelementptr i32, i32* %ptr, i32 1
  %gep2 = getelementptr i32, i32* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %ptr3 = getelementptr i32, i32* %ptr, i32 2
  %gep3 = getelementptr i32, i32* %ptr3, <n x 4 x i64> %sv
  %res3 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep3, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %res12 = add <n x 4 x i32> %res1, %res2
  %res = add <n x 4 x i32> %res12, %res3
  ret <n x 4 x i32> %res
}

; CHECK-LABEL: ld3_1_i64:
; CHECK-NOT: ld3d
; UNSAFE-LOADS-LABEL: ld3_1_i64:
; UNSAFE-LOADS: ld3d {z0.d, z1.d, z2.d}, p0/z, [{{x[0-9]+}}
define <n x 2 x i64> @ld3_1_i64(i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  %res = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  ret <n x 2 x i64> %res
}

; CHECK-LABEL: ld3_2_i64:
; CHECK-NOT: ld3d
; UNSAFE-LOADS-LABEL: ld3_2_i64:
; UNSAFE-LOADS: ld3d {z0.d, z1.d, z2.d}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld3d
; UNSAFE-LOADS: ret
define <n x 2 x i64> @ld3_2_i64(i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep1, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %ptr2 = getelementptr i64, i64* %ptr, i32 1
  %gep2 = getelementptr i64, i64* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep2, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %res = add <n x 2 x i64> %res1, %res2
  ret <n x 2 x i64> %res
}

; CHECK-LABEL: ld3_3_i64:
; CHECK: ld3d {z0.d, z1.d, z2.d}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld3d
define <n x 2 x i64> @ld3_3_i64(i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %ptr2 = getelementptr i64, i64* %ptr, i64 1
  %gep2 = getelementptr i64, i64* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %ptr3 = getelementptr i64, i64* %ptr, i64 2
  %gep3 = getelementptr i64, i64* %ptr3, <n x 2 x i64> %sv
  %res3 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep3, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %res12 = add <n x 2 x i64> %res1, %res2
  %res = add <n x 2 x i64> %res12, %res3
  ret <n x 2 x i64> %res
}

; CHECK-LABEL: ld3_1_float:
; CHECK-NOT: ld3w
; UNSAFE-LOADS-LABEL: ld3_1_float:
; UNSAFE-LOADS: ld3w {z0.s, z1.s, z2.s}, p0/z, [{{x[0-9]+}}
define <n x 4 x float> @ld3_1_float(float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  %res = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  ret <n x 4 x float> %res
}

; CHECK-LABEL: ld3_2_float:
; CHECK-NOT: ld3w
; UNSAFE-LOADS-LABEL: ld3_2_float:
; UNSAFE-LOADS: ld3w {z0.s, z1.s, z2.s}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld3w
; UNSAFE-LOADS: ret
define <n x 4 x float> @ld3_2_float(float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %ptr2 = getelementptr float, float* %ptr, i32 1
  %gep2 = getelementptr float, float* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %res = fadd <n x 4 x float> %res1, %res2
  ret <n x 4 x float> %res
}

; CHECK-LABEL: ld3_3_float:
; CHECK: ld3w {z0.s, z1.s, z2.s}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld3w
define <n x 4 x float> @ld3_3_float(float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %ptr2 = getelementptr float, float* %ptr, i32 1
  %gep2 = getelementptr float, float* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %ptr3 = getelementptr float, float* %ptr, i32 2
  %gep3 = getelementptr float, float* %ptr3, <n x 4 x i64> %sv
  %res3 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep3, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %res12 = fadd <n x 4 x float> %res1, %res2
  %res = fadd <n x 4 x float> %res12, %res3
  ret <n x 4 x float> %res
}

; CHECK-LABEL: ld3_1_double:
; CHECK-NOT: ld3d
; UNSAFE-LOADS-LABEL: ld3_1_double:
; UNSAFE-LOADS: ld3d {z0.d, z1.d, z2.d}, p0/z, [{{x[0-9]+}}
define <n x 2 x double> @ld3_1_double(double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  %res = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  ret <n x 2 x double> %res
}

; CHECK-LABEL: ld3_2_double:
; CHECK-NOT: ld3d
; UNSAFE-LOADS-LABEL: ld3_2_double:
; UNSAFE-LOADS: ld3d {z0.d, z1.d, z2.d}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld3d
; UNSAFE-LOADS: ret
define <n x 2 x double> @ld3_2_double(double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep1, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr2 = getelementptr double, double* %ptr, i32 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep2, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res = fadd <n x 2 x double> %res1, %res2
  ret <n x 2 x double> %res
}

; CHECK-LABEL: ld3_3_double:
; CHECK: ld3d {z0.d, z1.d, z2.d}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld3d
define <n x 2 x double> @ld3_3_double(double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 3, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr2 = getelementptr double, double* %ptr, i64 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr3 = getelementptr double, double* %ptr, i64 2
  %gep3 = getelementptr double, double* %ptr3, <n x 2 x i64> %sv
  %res3 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep3, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res12 = fadd <n x 2 x double> %res1, %res2
  %res = fadd <n x 2 x double> %res12, %res3
  ret <n x 2 x double> %res
}

; CHECK-LABEL: ld3_6_double:
; CHECK-DAG: zip1 [[PEVEN:p[0-9]+]].d, p0.d, p0.d
; CHECK-DAG: zip2  [[PODD:p[0-9]+]].d, p0.d, p0.d
; CHECK-DAG: ld3d {z0.d, z1.d, z2.d}, [[PEVEN]]/z, [{{x[0-9]+}}
; CHECK-DAG: ld3d {z3.d, z4.d, z5.d}, [[PODD]]/z, [{{x[0-9]+}}
; CHECK-DAG: uzp1 {{z[0-9]+}}.d, z0.d, z3.d
; CHECK-DAG: uzp2 {{z[0-9]+}}.d, z0.d, z3.d
; CHECK-DAG: uzp1 {{z[0-9]+}}.d, z1.d, z4.d
; CHECK-DAG: uzp2 {{z[0-9]+}}.d, z1.d, z4.d
; CHECK-DAG: uzp1 {{z[0-9]+}}.d, z2.d, z5.d
; CHECK-DAG: uzp2 {{z[0-9]+}}.d, z2.d, z5.d
define <n x 2 x double> @ld3_6_double(double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 6, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr2 = getelementptr double, double* %ptr, i64 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr3 = getelementptr double, double* %ptr, i64 2
  %gep3 = getelementptr double, double* %ptr3, <n x 2 x i64> %sv
  %res3 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep3, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr4 = getelementptr double, double* %ptr, i64 3
  %gep4 = getelementptr double, double* %ptr4, <n x 2 x i64> %sv
  %res4 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep4, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr5 = getelementptr double, double* %ptr, i64 4
  %gep5 = getelementptr double, double* %ptr5, <n x 2 x i64> %sv
  %res5 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep5, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr6 = getelementptr double, double* %ptr, i64 5
  %gep6 = getelementptr double, double* %ptr6, <n x 2 x i64> %sv
  %res6 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep6, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res12 = fadd <n x 2 x double> %res1, %res2
  %res34 = fadd <n x 2 x double> %res3, %res4
  %res56 = fadd <n x 2 x double> %res5, %res6
  %res1234 = fadd <n x 2 x double> %res12, %res34
  %res123456 = fadd <n x 2 x double> %res1234, %res56
  ret <n x 2 x double> %res123456
}

; *************** LD4 *******************

; CHECK-LABEL: ld4_1_i8:
; CHECK-NOT: ld4b
; UNSAFE-LOADS-LABEL: ld4_1_i8:
; UNSAFE-LOADS: ld4b {z0.b, z1.b, z2.b, z3.b}, p0/z, [{{x[0-9]+}}
define <n x 16 x i8> @ld4_1_i8(i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  %res = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  ret <n x 16 x i8> %res
}

define <n x 16 x i8> @ld4_2_i8(i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
; CHECK-LABEL: ld4_2_i8:
; CHECK-NOT: ld4b
; UNSAFE-LOADS-LABEL: ld4_2_i8:
; UNSAFE-LOADS: ld4b {z0.b, z1.b, z2.b, z3.b}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4b
; UNSAFE-LOADS: ret
  %1 = insertelement <n x 16 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep1 = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  %res1 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep1, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %ptr2 = getelementptr i8, i8* %ptr, i8 1
  %gep2 = getelementptr i8, i8* %ptr2, <n x 16 x i64> %sv
  %res2 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep2, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %res = add <n x 16 x i8> %res1, %res2
  ret <n x 16 x i8> %res
}

; CHECK-LABEL: ld4_3_i8:
; CHECK-NOT: ld4b
; UNSAFE-LOADS-LABEL: ld4_3_i8:
; UNSAFE-LOADS: ld4b {z0.b, z1.b, z2.b, z3.b}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4b
; UNSAFE-LOADS: ret
define <n x 16 x i8> @ld4_3_i8(i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep1 = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  %res1 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep1, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %ptr2 = getelementptr i8, i8* %ptr, i8 1
  %gep2 = getelementptr i8, i8* %ptr2, <n x 16 x i64> %sv
  %res2 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep2, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %ptr3 = getelementptr i8, i8* %ptr, i8 2
  %gep3 = getelementptr i8, i8* %ptr3, <n x 16 x i64> %sv
  %res3 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep3, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %res12 = add <n x 16 x i8> %res1, %res2
  %res = add <n x 16 x i8> %res12, %res3
  ret <n x 16 x i8> %res
}

; CHECK-LABEL: ld4_4_i8:
; CHECK: ld4b {z0.b, z1.b, z2.b, z3.b}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld4b
define <n x 16 x i8> @ld4_4_i8(i8* %ptr, i64 %index, <n x 16 x i1> %predicate) {
  %1 = insertelement <n x 16 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 16 x i64> %1, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %3 = mul <n x 16 x i64> %2, stepvector
  %4 = insertelement <n x 16 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 16 x i64> %4, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %sv = add <n x 16 x i64> %5, %3
  %gep1 = getelementptr i8, i8* %ptr, <n x 16 x i64> %sv
  %res1 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep1, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %ptr2 = getelementptr i8, i8* %ptr, i8 1
  %gep2 = getelementptr i8, i8* %ptr2, <n x 16 x i64> %sv
  %res2 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep2, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %ptr3 = getelementptr i8, i8* %ptr, i8 2
  %gep3 = getelementptr i8, i8* %ptr3, <n x 16 x i64> %sv
  %res3 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep3, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %ptr4 = getelementptr i8, i8* %ptr, i8 3
  %gep4 = getelementptr i8, i8* %ptr4, <n x 16 x i64> %sv
  %res4 = call <n x 16 x i8> @llvm.masked.gather.nxv16i8.nxv16p0i8(<n x 16 x i8*> %gep4, i32 4, <n x 16 x i1> %predicate, <n x 16 x i8> undef)
  %res12 = add <n x 16 x i8> %res1, %res2
  %res34 = add <n x 16 x i8> %res3, %res4
  %res = add <n x 16 x i8> %res12, %res34
  ret <n x 16 x i8> %res
}

; CHECK-LABEL: ld4_1_i16:
; CHECK-NOT: ld4h
; UNSAFE-LOADS-LABEL: ld4_1_i16:
; UNSAFE-LOADS: ld4h {z0.h, z1.h, z2.h, z3.h}, p0/z, [{{x[0-9]+}}
define <n x 8 x i16> @ld4_1_i16(i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  %res = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  ret <n x 8 x i16> %res
}

; CHECK-LABEL: ld4_2_i16:
; CHECK-NOT: ld4h
; UNSAFE-LOADS-LABEL: ld4_2_i16:
; UNSAFE-LOADS: ld4h {z0.h, z1.h, z2.h, z3.h}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4h
; UNSAFE-LOADS: ret
define <n x 8 x i16> @ld4_2_i16(i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep1 = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  %res1 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep1, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %ptr2 = getelementptr i16, i16* %ptr, i16 1
  %gep2 = getelementptr i16, i16* %ptr2, <n x 8 x i64> %sv
  %res2 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep2, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %res = add <n x 8 x i16> %res1, %res2
  ret <n x 8 x i16> %res
}

; CHECK-LABEL: ld4_3_i16:
; CHECK-NOT: ld4h
; UNSAFE-LOADS-LABEL: ld4_3_i16:
; UNSAFE-LOADS: ld4h {z0.h, z1.h, z2.h, z3.h}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4h
; UNSAFE-LOADS: ret
define <n x 8 x i16> @ld4_3_i16(i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep1 = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  %res1 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep1, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %ptr2 = getelementptr i16, i16* %ptr, i16 1
  %gep2 = getelementptr i16, i16* %ptr2, <n x 8 x i64> %sv
  %res2 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep2, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %ptr3 = getelementptr i16, i16* %ptr, i16 2
  %gep3 = getelementptr i16, i16* %ptr3, <n x 8 x i64> %sv
  %res3 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep3, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %res12 = add <n x 8 x i16> %res1, %res2
  %res = add <n x 8 x i16> %res12, %res3
  ret <n x 8 x i16> %res
}

; CHECK-LABEL: ld4_4_i16:
; CHECK: ld4h {z0.h, z1.h, z2.h, z3.h}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld4h
define <n x 8 x i16> @ld4_4_i16(i16* %ptr, i64 %index, <n x 8 x i1> %predicate) {
  %1 = insertelement <n x 8 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 8 x i64> %1, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %3 = mul <n x 8 x i64> %2, stepvector
  %4 = insertelement <n x 8 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 8 x i64> %4, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %sv = add <n x 8 x i64> %5, %3
  %gep1 = getelementptr i16, i16* %ptr, <n x 8 x i64> %sv
  %res1 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep1, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %ptr2 = getelementptr i16, i16* %ptr, i16 1
  %gep2 = getelementptr i16, i16* %ptr2, <n x 8 x i64> %sv
  %res2 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep2, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %ptr3 = getelementptr i16, i16* %ptr, i16 2
  %gep3 = getelementptr i16, i16* %ptr3, <n x 8 x i64> %sv
  %res3 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep3, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %ptr4 = getelementptr i16, i16* %ptr, i16 3
  %gep4 = getelementptr i16, i16* %ptr4, <n x 8 x i64> %sv
  %res4 = call <n x 8 x i16> @llvm.masked.gather.nxv8i16.nxv8p0i16(<n x 8 x i16*> %gep4, i32 4, <n x 8 x i1> %predicate, <n x 8 x i16> undef)
  %res12 = add <n x 8 x i16> %res1, %res2
  %res34 = add <n x 8 x i16> %res3, %res4
  %res = add <n x 8 x i16> %res12, %res34
  ret <n x 8 x i16> %res
}

; CHECK-LABEL: ld4_1_i32:
; CHECK-NOT: ld4w
; UNSAFE-LOADS-LABEL: ld4_1_i32:
; UNSAFE-LOADS: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [{{x[0-9]+}}
define <n x 4 x i32> @ld4_1_i32(i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  %res = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  ret <n x 4 x i32> %res
}

; CHECK-LABEL: ld4_2_i32:
; CHECK-NOT: ld4w
; UNSAFE-LOADS-LABEL: ld4_2_i32:
; UNSAFE-LOADS: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4w
; UNSAFE-LOADS: ret
define <n x 4 x i32> @ld4_2_i32(i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %ptr2 = getelementptr i32, i32* %ptr, i32 1
  %gep2 = getelementptr i32, i32* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %res = add <n x 4 x i32> %res1, %res2
  ret <n x 4 x i32> %res
}

; CHECK-LABEL: ld4_3_i32:
; CHECK-NOT: ld4w
; UNSAFE-LOADS-LABEL: ld4_3_i32:
; UNSAFE-LOADS: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4w
; UNSAFE-LOADS: ret
define <n x 4 x i32> @ld4_3_i32(i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %ptr2 = getelementptr i32, i32* %ptr, i32 1
  %gep2 = getelementptr i32, i32* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %ptr3 = getelementptr i32, i32* %ptr, i32 2
  %gep3 = getelementptr i32, i32* %ptr3, <n x 4 x i64> %sv
  %res3 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep3, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %res12 = add <n x 4 x i32> %res1, %res2
  %res = add <n x 4 x i32> %res12, %res3
  ret <n x 4 x i32> %res
}

; CHECK-LABEL: ld4_4_i32:
; CHECK: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld4w
define <n x 4 x i32> @ld4_4_i32(i32* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr i32, i32* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %ptr2 = getelementptr i32, i32* %ptr, i32 1
  %gep2 = getelementptr i32, i32* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %ptr3 = getelementptr i32, i32* %ptr, i32 2
  %gep3 = getelementptr i32, i32* %ptr3, <n x 4 x i64> %sv
  %res3 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep3, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %ptr4 = getelementptr i32, i32* %ptr, i32 3
  %gep4 = getelementptr i32, i32* %ptr4, <n x 4 x i64> %sv
  %res4 = call <n x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0i32(<n x 4 x i32*> %gep4, i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef)
  %res12 = add <n x 4 x i32> %res1, %res2
  %res34 = add <n x 4 x i32> %res3, %res4
  %res = add <n x 4 x i32> %res12, %res34
  ret <n x 4 x i32> %res
}

; CHECK-LABEL: ld4_1_i64:
; CHECK-NOT: ld4d
; UNSAFE-LOADS-LABEL: ld4_1_i64:
; UNSAFE-LOADS: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [{{x[0-9]+}}
define <n x 2 x i64> @ld4_1_i64(i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  %res = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  ret <n x 2 x i64> %res
}

; CHECK-LABEL: ld4_2_i64:
; CHECK-NOT: ld4d
; UNSAFE-LOADS-LABEL: ld4_2_i64:
; UNSAFE-LOADS: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4d
; UNSAFE-LOADS: ret
define <n x 2 x i64> @ld4_2_i64(i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep1, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %ptr2 = getelementptr i64, i64* %ptr, i32 1
  %gep2 = getelementptr i64, i64* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep2, i32 8, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %res = add <n x 2 x i64> %res1, %res2
  ret <n x 2 x i64> %res
}

; CHECK-LABEL: ld4_3_i64:
; CHECK-NOT: ld4d
; UNSAFE-LOADS-LABEL: ld4_3_i64:
; UNSAFE-LOADS: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4d
; UNSAFE-LOADS: ret
define <n x 2 x i64> @ld4_3_i64(i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %ptr2 = getelementptr i64, i64* %ptr, i64 1
  %gep2 = getelementptr i64, i64* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %ptr3 = getelementptr i64, i64* %ptr, i64 2
  %gep3 = getelementptr i64, i64* %ptr3, <n x 2 x i64> %sv
  %res3 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep3, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %res12 = add <n x 2 x i64> %res1, %res2
  %res = add <n x 2 x i64> %res12, %res3
  ret <n x 2 x i64> %res
}

; CHECK-LABEL: ld4_4_i64:
; CHECK: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld4d
define <n x 2 x i64> @ld4_4_i64(i64* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr i64, i64* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %ptr2 = getelementptr i64, i64* %ptr, i64 1
  %gep2 = getelementptr i64, i64* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %ptr3 = getelementptr i64, i64* %ptr, i64 2
  %gep3 = getelementptr i64, i64* %ptr3, <n x 2 x i64> %sv
  %res3 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep3, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %ptr4 = getelementptr i64, i64* %ptr, i64 3
  %gep4 = getelementptr i64, i64* %ptr4, <n x 2 x i64> %sv
  %res4 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %gep4, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %res12 = add <n x 2 x i64> %res1, %res2
  %res34 = add <n x 2 x i64> %res3, %res4
  %res = add <n x 2 x i64> %res12, %res34
  ret <n x 2 x i64> %res
}

; CHECK-LABEL: ld4_1_float:
; CHECK-NOT: ld4w
; UNSAFE-LOADS-LABEL: ld4_1_float:
; UNSAFE-LOADS: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [{{x[0-9]+}}
define <n x 4 x float> @ld4_1_float(float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  %res = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  ret <n x 4 x float> %res
}

; CHECK-LABEL: ld4_2_float:
; CHECK-NOT: ld4w
; UNSAFE-LOADS-LABEL: ld4_2_float:
; UNSAFE-LOADS: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4w
; UNSAFE-LOADS: ret
define <n x 4 x float> @ld4_2_float(float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %ptr2 = getelementptr float, float* %ptr, i32 1
  %gep2 = getelementptr float, float* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %res = fadd <n x 4 x float> %res1, %res2
  ret <n x 4 x float> %res
}

; CHECK-LABEL: ld4_3_float:
; CHECK-NOT: ld4w
; UNSAFE-LOADS-LABEL: ld4_3_float:
; UNSAFE-LOADS: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4w
; UNSAFE-LOADS: ret
define <n x 4 x float> @ld4_3_float(float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %ptr2 = getelementptr float, float* %ptr, i32 1
  %gep2 = getelementptr float, float* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %ptr3 = getelementptr float, float* %ptr, i32 2
  %gep3 = getelementptr float, float* %ptr3, <n x 4 x i64> %sv
  %res3 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep3, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %res12 = fadd <n x 4 x float> %res1, %res2
  %res = fadd <n x 4 x float> %res12, %res3
  ret <n x 4 x float> %res
}

; CHECK-LABEL: ld4_4_float:
; CHECK: ld4w {z0.s, z1.s, z2.s, z3.s}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld4w
define <n x 4 x float> @ld4_4_float(float* %ptr, i64 %index, <n x 4 x i1> %predicate) {
  %1 = insertelement <n x 4 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 4 x i64> %1, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %3 = mul <n x 4 x i64> %2, stepvector
  %4 = insertelement <n x 4 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 4 x i64> %4, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %sv = add <n x 4 x i64> %5, %3
  %gep1 = getelementptr float, float* %ptr, <n x 4 x i64> %sv
  %res1 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep1, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %ptr2 = getelementptr float, float* %ptr, i32 1
  %gep2 = getelementptr float, float* %ptr2, <n x 4 x i64> %sv
  %res2 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep2, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %ptr3 = getelementptr float, float* %ptr, i32 2
  %gep3 = getelementptr float, float* %ptr3, <n x 4 x i64> %sv
  %res3 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep3, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %ptr4 = getelementptr float, float* %ptr, i32 3
  %gep4 = getelementptr float, float* %ptr4, <n x 4 x i64> %sv
  %res4 = call <n x 4 x float> @llvm.masked.gather.nxv4f32.nxv4p0f32(<n x 4 x float*> %gep4, i32 4, <n x 4 x i1> %predicate, <n x 4 x float> undef)
  %res12 = fadd <n x 4 x float> %res1, %res2
  %res34 = fadd <n x 4 x float> %res3, %res4
  %res = fadd <n x 4 x float> %res12, %res34
  ret <n x 4 x float> %res
}

; CHECK-LABEL: ld4_1_double:
; CHECK-NOT: ld4d
; UNSAFE-LOADS-LABEL: ld4_1_double:
; UNSAFE-LOADS: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [{{x[0-9]+}}
define <n x 2 x double> @ld4_1_double(double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  %res = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  ret <n x 2 x double> %res
}

; CHECK-LABEL: ld4_2_double:
; CHECK-NOT: ld4d
; UNSAFE-LOADS-LABEL: ld4_2_double:
; UNSAFE-LOADS: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4d
; UNSAFE-LOADS: ret
define <n x 2 x double> @ld4_2_double(double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep1, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr2 = getelementptr double, double* %ptr, i32 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep2, i32 8, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res = fadd <n x 2 x double> %res1, %res2
  ret <n x 2 x double> %res
}

; CHECK-LABEL: ld4_3_double:
; CHECK-NOT: ld4d
; UNSAFE-LOADS-LABEL: ld4_3_double:
; UNSAFE-LOADS: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [{{x[0-9]+}}
; UNSAFE-LOADS-NOT: ld4d
; UNSAFE-LOADS: ret
define <n x 2 x double> @ld4_3_double(double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr2 = getelementptr double, double* %ptr, i64 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr3 = getelementptr double, double* %ptr, i64 2
  %gep3 = getelementptr double, double* %ptr3, <n x 2 x i64> %sv
  %res3 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep3, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res12 = fadd <n x 2 x double> %res1, %res2
  %res = fadd <n x 2 x double> %res12, %res3
  ret <n x 2 x double> %res
}

; CHECK-LABEL: ld4_4_double:
; CHECK: ld4d {z0.d, z1.d, z2.d, z3.d}, p0/z, [{{x[0-9]+}}
; CHECK-NOT: ld4d
define <n x 2 x double> @ld4_4_double(double* %ptr, i64 %index, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr2 = getelementptr double, double* %ptr, i64 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr3 = getelementptr double, double* %ptr, i64 2
  %gep3 = getelementptr double, double* %ptr3, <n x 2 x i64> %sv
  %res3 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep3, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr4 = getelementptr double, double* %ptr, i64 3
  %gep4 = getelementptr double, double* %ptr4, <n x 2 x i64> %sv
  %res4 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep4, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res12 = fadd <n x 2 x double> %res1, %res2
  %res34 = fadd <n x 2 x double> %res3, %res4
  %res = fadd <n x 2 x double> %res12, %res34
  ret <n x 2 x double> %res
}

; *************** Multiple groups *******************
; CHECK-LABEL: two_load_groups:
; CHECK: ld2d
; CHECK: ld2d
define <n x 2 x double> @two_load_groups(double* %ptr, i64 %index1, i64 %index2, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index1, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv1 = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr double, double* %ptr, <n x 2 x i64> %sv1
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr2 = getelementptr double, double* %ptr, i64 1
  %gep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %sv1
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res12 = fadd <n x 2 x double> %res1, %res2
  %6 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %7 = shufflevector <n x 2 x i64> %6, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %8 = mul <n x 2 x i64> %7, stepvector
  %9 = insertelement <n x 2 x i64> undef, i64 %index2, i32 0
  %10 = shufflevector <n x 2 x i64> %9, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv2 = add <n x 2 x i64> %10, %8
  %gep3 = getelementptr double, double* %ptr, <n x 2 x i64> %sv2
  %res3 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep3, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %ptr4 = getelementptr double, double* %ptr, i64 1
  %gep4 = getelementptr double, double* %ptr4, <n x 2 x i64> %sv2
  %res4 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %gep4, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res34 = fadd <n x 2 x double> %res3, %res4
  %res = fadd <n x 2 x double> %res12, %res34
  ret <n x 2 x double> %res
}

; CHECK-LABEL: load_store_load:
; CHECK-NOT: ld2d
; CHECK: st2d
; CHECK-NOT: ld2d
; UNSAFE-LOADS-LABEL: load_store_load:
; UNSAFE-LOADS: ld2d
; UNSAFE-LOADS: st2d
; UNSAFE-LOADS: ld2d
define <n x 2 x double> @load_store_load(double* %ptr, i64 %index1, i64 %index2, <n x 2 x double> %val1, <n x 2 x double> %val2, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index1, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %loadsv = add <n x 2 x i64> %5, %3
  %loadgep1 = getelementptr double, double* %ptr, <n x 2 x i64> %loadsv
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %loadgep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %6 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %7 = shufflevector <n x 2 x i64> %6, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %8 = mul <n x 2 x i64> %7, stepvector
  %9 = insertelement <n x 2 x i64> undef, i64 %index2, i32 0
  %10 = shufflevector <n x 2 x i64> %9, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %storesv = add <n x 2 x i64> %10, %8
  %storegep1 = getelementptr double, double* %ptr, <n x 2 x i64> %storesv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %storegep1, i32 4, <n x 2 x i1> %predicate)
  %ptr2 = getelementptr double, double* %ptr, i32 1
  %storegep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %storesv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %storegep2, i32 4, <n x 2 x i1> %predicate)
  %loadgep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %loadsv
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %loadgep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res12 = fadd <n x 2 x double> %res1, %res2
  ret <n x 2 x double> %res12
}

; CHECK-LABEL: store_load_store:
; CHECK: st2d
; CHECK-NOT: ld2d
; CHECK: st2d
; UNSAFE-LOADS-LABEL: store_load_store:
; UNSAFE-LOADS: st2d
; UNSAFE-LOADS: ld2d
; UNSAFE-LOADS: st2d
define <n x 2 x double> @store_load_store(double* %ptr, i64 %index1, i64 %index2, <n x 2 x double> %val1, <n x 2 x double> %val2, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index1, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %storesv1 = add <n x 2 x i64> %5, %3
  %storegep1 = getelementptr double, double* %ptr, <n x 2 x i64> %storesv1
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %storegep1, i32 4, <n x 2 x i1> %predicate)
  %ptr2 = getelementptr double, double* %ptr, i32 1
  %storegep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %storesv1
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %storegep2, i32 4, <n x 2 x i1> %predicate)
  %6 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %7 = shufflevector <n x 2 x i64> %6, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %8 = mul <n x 2 x i64> %7, stepvector
  %9 = insertelement <n x 2 x i64> undef, i64 %index2, i32 0
  %10 = shufflevector <n x 2 x i64> %9, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %loadsv = add <n x 2 x i64> %10, %8
  %loadgep1 = getelementptr double, double* %ptr, <n x 2 x i64> %loadsv
  %res = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %loadgep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %storegep1, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %storegep2, i32 4, <n x 2 x i1> %predicate)
  ret <n x 2 x double> %res
}

; CHECK-LABEL: multiple_store_sink:
; CHECK: ld4d
; CHECK: st4d
; UNSAFE-LOADS-LABEL: multiple_store_sink:
; UNSAFE-LOADS: ld4d
; UNSAFE-LOADS: st4d
define <n x 2 x double> @multiple_store_sink(double* %ptr, i64 %index1, i64 %index2, <n x 2 x double> %val1, <n x 2 x double> %val2, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index1, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %storesv1 = add <n x 2 x i64> %5, %3
  %storegep1 = getelementptr double, double* %ptr, <n x 2 x i64> %storesv1
  %ptr2 = getelementptr double, double* %ptr, i32 1
  %storegep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %storesv1
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %storegep1, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %storegep2, i32 4, <n x 2 x i1> %predicate)
  %ptr3 = getelementptr double, double* %ptr, i32 2
  %storegep3 = getelementptr double, double* %ptr3, <n x 2 x i64> %storesv1
  %ptr4 = getelementptr double, double* %ptr, i32 3
  %storegep4 = getelementptr double, double* %ptr4, <n x 2 x i64> %storesv1
  %res3 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep3, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res4 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep4, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %storegep3, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %storegep4, i32 4, <n x 2 x i1> %predicate)
  %res12 = fadd <n x 2 x double> %res1, %res2
  %res34 = fadd <n x 2 x double> %res3, %res4
  %res = fadd <n x 2 x double> %res12, %res34
  ret <n x 2 x double> %res
}

; CHECK-LABEL: multiple_store_sink_unaligned_overlap:
; CHECK: ld1d
; CHECK: ld1d
; CHECK: st1d
; CHECK: st1d
; CHECK: ld1d
; CHECK: ld1d
; CHECK: st1d
; CHECK: st1d
; UNSAFE-LOADS-LABEL: multiple_store_sink_unaligned_overlap:
; UNSAFE-LOADS: ld4d
; UNSAFE-LOADS: ld4d
; UNSAFE-LOADS-NOT: st4d
define <n x 2 x double> @multiple_store_sink_unaligned_overlap(double* %ptr, i64 %index1, i64 %index2, <n x 2 x double> %val1, <n x 2 x double> %val2, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 4, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index1, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %storesv1 = add <n x 2 x i64> %5, %3
  %storegep1 = getelementptr double, double* %ptr, <n x 2 x i64> %storesv1
  %ptr2 = getelementptr double, double* %ptr, i32 1
  %storegep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %storesv1
  %word_ptr = bitcast double* %ptr to i32*
  %unaligned_word_ptr = getelementptr i32, i32* %word_ptr, i32 3
  %unaligned_double_ptr = bitcast i32* %unaligned_word_ptr to double*
  %storegep2.5 = getelementptr double, double* %unaligned_double_ptr, <n x 2 x i64> %storesv1
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %storegep1, i32 4, <n x 2 x i1> %predicate)
  ; this unaligned scatter will alias with following gather
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %storegep2.5, i32 2, <n x 2 x i1> %predicate)
  %ptr3 = getelementptr double, double* %ptr, i32 2
  %storegep3 = getelementptr double, double* %ptr3, <n x 2 x i64> %storesv1
  %ptr4 = getelementptr double, double* %ptr, i32 3
  %storegep4 = getelementptr double, double* %ptr4, <n x 2 x i64> %storesv1
  %res3 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep3, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res4 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep4, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %storegep3, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %storegep4, i32 4, <n x 2 x i1> %predicate)
  %res12 = fadd <n x 2 x double> %res1, %res2
  %res34 = fadd <n x 2 x double> %res3, %res4
  %res = fadd <n x 2 x double> %res12, %res34
  ret <n x 2 x double> %res
}

; CHECK-LABEL: multiple_store_sink_unaligned_separate:
; CHECK: ld1d
; CHECK: ld1d
; CHECK: ld1d
; CHECK: ld1d
; CHECK: st1d
; CHECK: st1d
; CHECK: st1d
; CHECK: st1d
; UNSAFE-LOADS-LABEL: multiple_store_sink_unaligned_separate:
; to allow some holes, i used stride = 6, so ld3 are expected
; UNSAFE-LOADS: ld3d
; UNSAFE-LOADS: ld3d
; UNSAFE-LOADS: st1d
; UNSAFE-LOADS: st1d
; UNSAFE-LOADS: st1d
; UNSAFE-LOADS: st1d
define <n x 2 x double> @multiple_store_sink_unaligned_separate(double* %ptr, i64 %index1, i64 %index2, <n x 2 x double> %val1, <n x 2 x double> %val2, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 6, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index1, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %storesv1 = add <n x 2 x i64> %5, %3
  %storegep1 = getelementptr double, double* %ptr, <n x 2 x i64> %storesv1
  %ptr2 = getelementptr double, double* %ptr, i32 1
  %storegep2 = getelementptr double, double* %ptr2, <n x 2 x i64> %storesv1
  %word_ptr = bitcast double* %ptr to i32*
  %unaligned_word_ptr = getelementptr i32, i32* %word_ptr, i32 3
  %unaligned_double_ptr = bitcast i32* %unaligned_word_ptr to double*
  %storegep2.5 = getelementptr double, double* %unaligned_double_ptr, <n x 2 x i64> %storesv1
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %storegep1, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %storegep2.5, i32 2, <n x 2 x i1> %predicate)
  %ptr4 = getelementptr double, double* %ptr, i32 3
  %storegep4 = getelementptr double, double* %ptr4, <n x 2 x i64> %storesv1
  %ptr5 = getelementptr double, double* %ptr, i32 4
  %storegep5 = getelementptr double, double* %ptr5, <n x 2 x i64> %storesv1
  %res4 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep4, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res5 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %storegep5, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %storegep4, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %storegep5, i32 4, <n x 2 x i1> %predicate)
  %res12 = fadd <n x 2 x double> %res1, %res2
  %res45 = fadd <n x 2 x double> %res4, %res5
  %res = fadd <n x 2 x double> %res12, %res45
  ret <n x 2 x double> %res
}

; CHECK-LABEL: multiple_store_sink_sub_element_stride:
; CHECK: ld1d
; CHECK: ld1d
; CHECK: st1d
; CHECK: st1d
; CHECK: ld1d
; CHECK: ld1d
; CHECK: st1d
; CHECK: st1d
; UNSAFE-LOADS-LABEL: multiple_store_sink_sub_element_stride:
; UNSAFE-LOADS: ld1d
; UNSAFE-LOADS: ld1d
; UNSAFE-LOADS: st1d
; UNSAFE-LOADS: st1d
; UNSAFE-LOADS: ld1d
; UNSAFE-LOADS: ld1d
; UNSAFE-LOADS: st1d
; UNSAFE-LOADS: st1d
define <n x 2 x double> @multiple_store_sink_sub_element_stride(i32* %ptr, i64 %index1, i64 %index2, <n x 2 x double> %val1, <n x 2 x double> %val2, <n x 2 x i1> %predicate) {
  %1 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index1, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %storesv1 = add <n x 2 x i64> %5, %3
  %storegep1 = getelementptr i32, i32* %ptr, <n x 2 x i64> %storesv1
  %bc1 = bitcast <n x 2 x i32*> %storegep1 to <n x 2 x double*>
  %ptr2 = getelementptr i32, i32* %ptr, i32 1
  %storegep2 = getelementptr i32, i32* %ptr2, <n x 2 x i64> %storesv1
  %bc2 = bitcast <n x 2 x i32*> %storegep2 to <n x 2 x double*>
  %res1 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %bc1, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res2 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %bc2, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %bc1, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %bc2, i32 4, <n x 2 x i1> %predicate)
  %ptr3 = getelementptr i32, i32* %ptr, i32 2
  %storegep3 = getelementptr i32, i32* %ptr3, <n x 2 x i64> %storesv1
  %bc3 = bitcast <n x 2 x i32*> %storegep3 to <n x 2 x double*>
  %ptr4 = getelementptr i32, i32* %ptr, i32 3
  %storegep4 = getelementptr i32, i32* %ptr4, <n x 2 x i64> %storesv1
  %bc4 = bitcast <n x 2 x i32*> %storegep4 to <n x 2 x double*>
  %res3 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %bc3, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %res4 = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %bc4, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val1, <n x 2 x double*> %bc3, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %val2, <n x 2 x double*> %bc4, i32 4, <n x 2 x i1> %predicate)
  %res12 = fadd <n x 2 x double> %res1, %res2
  %res34 = fadd <n x 2 x double> %res3, %res4
  %res = fadd <n x 2 x double> %res12, %res34
  ret <n x 2 x double> %res
}

; CHECK-LABEL: sub_element_stride:
; The gathers below cannot be transformed because the stride is less than the element size.
; CHECK-NOT: ld2d
define <n x 2 x i64> @sub_element_stride(i32* %base, <n x 2 x i1> %pred) {
  %1 = insertelement <n x 2 x i64> undef, i64 1, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 0, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %gep1 = getelementptr i32, i32* %base, <n x 2 x i64> %sv
  %bc1 = bitcast <n x 2 x i32*> %gep1 to <n x 2 x i64*>
  %wmg1 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %bc1, i32 4, <n x 2 x i1> %pred, <n x 2 x i64> undef)
  %offgep = getelementptr i32, i32* %base, i32 1
  %gep2 = getelementptr i32, i32* %offgep, <n x 2 x i64> %sv
  %bc2 = bitcast <n x 2 x i32*> %gep2 to <n x 2 x i64*>
  %wmg2 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %bc2, i32 4, <n x 2 x i1> %pred, <n x 2 x i64> undef)
  %add = add <n x 2 x i64> %wmg1, %wmg2
  ret <n x 2 x i64> %add
}

; CHECK-LABEL: mixed_loads:
; CHECK-DAG: ld2d
; CHECK-DAG: ld1d
; UNSAFE-LOADS-LABEL: mixed_loads:
; The below loads can be performed with one ld2d
; UNSAFE-LOADS-NOT: ld1d
; UNSAFE-LOADS: ld2d
; UNSAFE-LOADS-NOT: ld1d
; UNSAFE-LOADS-NOT: ld2d
define { <n x 2 x double>, <n x 2 x i64> } @mixed_loads(double* %doubleptr, i64 %index, <n x 2 x i1> %predicate) {
  %i64ptr1 = bitcast double* %doubleptr to i64*
  %i64ptr2 = getelementptr i64, i64* %i64ptr1, i32 1
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %doublegep = getelementptr double, double* %doubleptr, <n x 2 x i64> %sv
  %i64gep1 = getelementptr i64, i64* %i64ptr1, <n x 2 x i64> %sv
  %i64gep2 = getelementptr i64, i64* %i64ptr2, <n x 2 x i64> %sv
  %i64res1 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %i64gep1, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %doubleres = call <n x 2 x double> @llvm.masked.gather.nxv2f64.nxv2p0f64(<n x 2 x double*> %doublegep, i32 4, <n x 2 x i1> %predicate, <n x 2 x double> undef)
  %i64res2 = call <n x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0i64(<n x 2 x i64*> %i64gep2, i32 4, <n x 2 x i1> %predicate, <n x 2 x i64> undef)
  %i64res = add <n x 2 x i64> %i64res1, %i64res2
  %res1 = insertvalue { <n x 2 x double>, <n x 2 x i64> } undef, <n x 2 x double> %doubleres, 0
  %res2 = insertvalue { <n x 2 x double>, <n x 2 x i64> } %res1, <n x 2 x i64> %i64res, 1
  ret { <n x 2 x double>, <n x 2 x i64> } %res2
}

; CHECK-LABEL: mixed_stores:
; The below stores cannot be performed with st2d, because the stores alias
; CHECK-NOT: st2d
define void @mixed_stores(<n x 2 x double> %doubleval, <n x 2 x i64> %i64val, double* %doubleptr1, i64 %index, <n x 2 x i1> %predicate) {
  %i64ptr1 = bitcast double* %doubleptr1 to i64*
  %i64ptr2 = getelementptr i64, i64* %i64ptr1, i32 1
  %doubleptr2 = getelementptr double, double* %doubleptr1, i32 1
  %1 = insertelement <n x 2 x i64> undef, i64 2, i32 0
  %2 = shufflevector <n x 2 x i64> %1, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %3 = mul <n x 2 x i64> %2, stepvector
  %4 = insertelement <n x 2 x i64> undef, i64 %index, i32 0
  %5 = shufflevector <n x 2 x i64> %4, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %sv = add <n x 2 x i64> %5, %3
  %doublegep1 = getelementptr double, double* %doubleptr1, <n x 2 x i64> %sv
  %doublegep2 = getelementptr double, double* %doubleptr2, <n x 2 x i64> %sv
  %i64gep1 = getelementptr i64, i64* %i64ptr1, <n x 2 x i64> %sv
  %i64gep2 = getelementptr i64, i64* %i64ptr2, <n x 2 x i64> %sv
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %doubleval, <n x 2 x double*> %doublegep1, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %i64val, <n x 2 x i64*> %i64gep2, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2f64.nxv2p0f64(<n x 2 x double> %doubleval, <n x 2 x double*> %doublegep2, i32 4, <n x 2 x i1> %predicate)
  call void @llvm.masked.scatter.nxv2i64.nxv2p0i64(<n x 2 x i64> %i64val, <n x 2 x i64*> %i64gep1, i32 4, <n x 2 x i1> %predicate)
  ret void
}

