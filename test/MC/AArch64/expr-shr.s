// RUN: llvm-mc -triple aarch64-unknown-unknown-elf %s | FileCheck %s --check-prefix=ELF
// RUN: llvm-mc -triple aarch64-unknown-darwin %s | FileCheck %s --check-prefix=DARWIN
// RUN: llvm-mc -triple aarch64-unknown-unknown-elf -mattr=+sve %s | FileCheck %s --check-prefix=ELF
// RUN: llvm-mc -triple aarch64-unknown-darwin %s -mattr=+sve | FileCheck %s --check-prefix=DARWIN

.data

// ELF: .xword 3
// DARWIN: .quad 3
.quad (~0 >> 62)
