; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define <n x 16 x i8> @add_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: add_b:
; CHECK: add z0.b, z0.b, z1.b
; CHECK-NEXT: ret
  %res = add <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @add_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: add_h:
; CHECK: add z0.h, z0.h, z1.h
; CHECK-NEXT: ret
  %res = add <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @add_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: add_s:
; CHECK: add z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %res = add <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @add_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: add_d:
; CHECK: add z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = add <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 16 x i8> @mul_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: mul_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-NEXT: mul z0.b, [[PG]]/m, z0.b, z1.b
; CHECK-NEXT: ret
  %res = mul <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @mul_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: mul_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: mul z0.h, [[PG]]/m, z0.h, z1.h
; CHECK-NEXT: ret
  %res = mul <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @mul_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: mul_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: mul z0.s, [[PG]]/m, z0.s, z1.s
; CHECK-NEXT: ret
  %res = mul <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @mul_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: mul_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: mul z0.d, [[PG]]/m, z0.d, z1.d
; CHECK-NEXT: ret
  %res = mul <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 16 x i8>  @sdiv_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: sdiv_b:
; CHECK-DAG: sunpkhi {{z[0-9]+}}.h, {{z[0-9]+}}.b
; CHECK-DAG: sunpklo {{z[0-9]+}}.h, {{z[0-9]+}}.b
; CHECK-DAG: sunpkhi {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK-DAG: sunpklo {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: uzp1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: uzp1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: uzp1 {{z[0-9]+}}.b, {{z[0-9]+}}.b, {{z[0-9]+}}.b
; CHECK: ret
  %res = sdiv <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @sdiv_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: sdiv_h:
; CHECK-DAG: sunpkhi {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK-DAG: sunpklo {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: sdiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: uzp1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: ret
  %res = sdiv <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @sdiv_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sdiv_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: sdiv z0.s, [[PG]]/m, z0.s, z1.s
; CHECK-NEXT: ret
  %res = sdiv <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @sdiv_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sdiv_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: sdiv z0.d, [[PG]]/m, z0.d, z1.d
; CHECK-NEXT: ret
  %res = sdiv <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 4 x i32> @srem_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: srem_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: movprfx [[TMP:z[0-9]+]], z0
; CHECK-NEXT: sdiv [[TMP]].s, [[PG]]/m, [[TMP]].s, z1.s
; CHECK-NEXT: mls z0.s, [[PG]]/m, [[TMP]].s, z1.s
; CHECK-NEXT: ret
  %res = srem <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @srem_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: srem_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: movprfx [[TMP:z[0-9]+]], z0
; CHECK-NEXT: sdiv [[TMP]].d, [[PG]]/m, [[TMP]].d, z1.d
; CHECK-NEXT: mls z0.d, [[PG]]/m, [[TMP]].d, z1.d
; CHECK-NEXT: ret
  %res = srem <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 16 x i8> @sub_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: sub_b:
; CHECK: sub z0.b, z0.b, z1.b
; CHECK-NEXT: ret
  %res = sub <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @sub_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: sub_h:
; CHECK: sub z0.h, z0.h, z1.h
; CHECK-NEXT: ret
  %res = sub <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @sub_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sub_s:
; CHECK: sub z0.s, z0.s, z1.s
; CHECK-NEXT: ret
  %res = sub <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @sub_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sub_d:
; CHECK: sub z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = sub <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 16 x i8> @udiv_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: udiv_b:
; CHECK-DAG: uunpkhi {{z[0-9]+}}.h, {{z[0-9]+}}.b
; CHECK-DAG: uunpklo {{z[0-9]+}}.h, {{z[0-9]+}}.b
; CHECK-DAG: uunpkhi {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK-DAG: uunpklo {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: uzp1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: uzp1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: uzp1 {{z[0-9]+}}.b, {{z[0-9]+}}.b, {{z[0-9]+}}.b
; CHECK: ret
  %res = udiv <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @udiv_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: udiv_h:
; CHECK-DAG: uunpkhi {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK-DAG: uunpklo {{z[0-9]+}}.s, {{z[0-9]+}}.h
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: udiv{{r?}} {{z[0-9]+}}.s, {{p[0-9]+}}/m, {{z[0-9]+}}.s, {{z[0-9]+}}.s
; CHECK: uzp1 {{z[0-9]+}}.h, {{z[0-9]+}}.h, {{z[0-9]+}}.h
; CHECK: ret
  %res = udiv <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @udiv_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: udiv_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: udiv z0.s, [[PG]]/m, z0.s, z1.s
; CHECK-NEXT: ret
  %res = udiv <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @udiv_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: udiv_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: udiv z0.d, [[PG]]/m, z0.d, z1.d
; CHECK-NEXT: ret
  %res = udiv <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 4 x i32> @urem_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: urem_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: movprfx [[TMP:z[0-9]+]], z0
; CHECK-NEXT: udiv [[TMP]].s, [[PG]]/m, [[TMP]].s, z1.s
; CHECK-NEXT: mls z0.s, [[PG]]/m, [[TMP]].s, z1.s
; CHECK: ret
  %res = urem <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @urem_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: urem_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: movprfx [[TMP:z[0-9]+]], z0
; CHECK-NEXT: udiv [[TMP]].d, [[PG]]/m, [[TMP]].d, z1.d
; CHECK-NEXT: mls z0.d, [[PG]]/m, [[TMP]].d, z1.d
; CHECK: ret
  %res = urem <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 2 x i1> @and_bool2(<n x 2 x i1> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: and_bool2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: and p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = and <n x 2 x i1> %a, %b
  ret <n x 2 x i1> %res
}

define <n x 4 x i1> @and_bool4(<n x 4 x i1> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: and_bool4:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: and p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = and <n x 4 x i1> %a, %b
  ret <n x 4 x i1> %res
}

define <n x 8 x i1> @and_bool8(<n x 8 x i1> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: and_bool8:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: and p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = and <n x 8 x i1> %a, %b
  ret <n x 8 x i1> %res
}

define <n x 16 x i1> @and_bool16(<n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: and_bool16:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-NEXT: and p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = and <n x 16 x i1> %a, %b
  ret <n x 16 x i1> %res
}

define <n x 16 x i8> @and_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: and_b:
; CHECK: and z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = and <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @and_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: and_h:
; CHECK: and z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = and <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @and_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: and_s:
; CHECK: and z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = and <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @and_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: and_d:
; CHECK: and z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = and <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 2 x i1> @or_bool2(<n x 2 x i1> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: or_bool2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: orr p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = or <n x 2 x i1> %a, %b
  ret <n x 2 x i1> %res
}

define <n x 4 x i1> @or_bool4(<n x 4 x i1> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: or_bool4:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: orr p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = or <n x 4 x i1> %a, %b
  ret <n x 4 x i1> %res
}

define <n x 8 x i1> @or_bool8(<n x 8 x i1> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: or_bool8:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: orr p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = or <n x 8 x i1> %a, %b
  ret <n x 8 x i1> %res
}

define <n x 16 x i1> @or_bool16(<n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: or_bool16:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-NEXT: orr p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = or <n x 16 x i1> %a, %b
  ret <n x 16 x i1> %res
}

define <n x 16 x i8> @or_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: or_b:
; CHECK: orr z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = or <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @or_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: or_h:
; CHECK: orr z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = or <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @or_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: or_s:
; CHECK: orr z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = or <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @or_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: or_d:
; CHECK: orr z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = or <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 2 x i1> @xor_bool2(<n x 2 x i1> %a, <n x 2 x i1> %b) {
; CHECK-LABEL: xor_bool2:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-NEXT: eor p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = xor <n x 2 x i1> %a, %b
  ret <n x 2 x i1> %res
}

define <n x 4 x i1> @xor_bool4(<n x 4 x i1> %a, <n x 4 x i1> %b) {
; CHECK-LABEL: xor_bool4:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-NEXT: eor p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = xor <n x 4 x i1> %a, %b
  ret <n x 4 x i1> %res
}

define <n x 8 x i1> @xor_bool8(<n x 8 x i1> %a, <n x 8 x i1> %b) {
; CHECK-LABEL: xor_bool8:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-NEXT: eor p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = xor <n x 8 x i1> %a, %b
  ret <n x 8 x i1> %res
}

define <n x 16 x i1> @xor_bool16(<n x 16 x i1> %a, <n x 16 x i1> %b) {
; CHECK-LABEL: xor_bool16:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-NEXT: eor p0.b, [[PG]]/z, p0.b, p1.b
; CHECK-NEXT: ret
  %res = xor <n x 16 x i1> %a, %b
  ret <n x 16 x i1> %res
}

define <n x 16 x i8> @xor_b(<n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: xor_b:
; CHECK: eor z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = xor <n x 16 x i8> %a, %b
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @xor_h(<n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: xor_h:
; CHECK: eor z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = xor <n x 8 x i16> %a, %b
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @xor_s(<n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: xor_s:
; CHECK: eor z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = xor <n x 4 x i32> %a, %b
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @xor_d(<n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: xor_d:
; CHECK: eor z0.d, z0.d, z1.d
; CHECK-NEXT: ret
  %res = xor <n x 2 x i64> %a, %b
  ret <n x 2 x i64> %res
}

define <n x 16 x i8> @add_pred_b(<n x 16 x i1> %p, <n x 16 x i8> %a,
                                 <n x 16 x i8> %b) {
; CHECK-LABEL: add_pred_b:
; CHECK: add z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %toadd = select <n x 16 x i1> %p, <n x 16 x i8> %b, <n x 16 x i8> zeroinitializer
  %res = add <n x 16 x i8> %a, %toadd
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @sub_pred_h(<n x 8 x i1> %p, <n x 8 x i16> %a,
                                 <n x 8 x i16> %b) {
; CHECK-LABEL: sub_pred_h:
; CHECK: sub z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tosub = select <n x 8 x i1> %p, <n x 8 x i16> %b, <n x 8 x i16> zeroinitializer
  %res = sub <n x 8 x i16> %a, %tosub
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @add_pred_s(<n x 4 x i1> %p, <n x 4 x i32> %a,
                                 <n x 4 x i32> %b) {
; CHECK-LABEL: add_pred_s:
; CHECK: add z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %toadd = select <n x 4 x i1> %p, <n x 4 x i32> %b, <n x 4 x i32> zeroinitializer
  %res = add <n x 4 x i32> %a, %toadd
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @sub_pred_d(<n x 2 x i1> %p, <n x 2 x i64> %a,
                                 <n x 2 x i64> %b) {
; CHECK-LABEL: sub_pred_d:
; CHECK: sub z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tosub = select <n x 2 x i1> %p, <n x 2 x i64> %b, <n x 2 x i64> zeroinitializer
  %res = sub <n x 2 x i64> %a, %tosub
  ret <n x 2 x i64> %res
}
