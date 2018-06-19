// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s

// CHECK: error: expected compatible register or logical immediate
dupm z20.b, #0xff
// CHECK: error: expected compatible register or logical immediate
dupm z20.h, #0xffff
// CHECK: error: expected compatible register or logical immediate
dupm z20.s, #0xffffffff
// CHECK: error: expected compatible register or logical immediate
dupm z20.d, #0xffffffffffffffff


