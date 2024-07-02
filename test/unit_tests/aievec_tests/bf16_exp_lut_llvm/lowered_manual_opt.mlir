// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (C) 2024, Advanced Micro Devices, Inc.

// REQUIRES: valid_xchess_license
// REQUIRES: peano
// RUN: mkdir -p %t/data; cd %t
// RUN: cp %S/lowered-manual-opt.ll mlir-part.ll
// RUN: cp %S/dut_simple.ll .
// RUN: cp %S/lut_based_ops.ll .
// RUN: llvm-link -S mlir-part.ll dut_simple.ll lut_based_ops.ll -o dut.ll
// RUN: %PEANO_INSTALL_DIR/bin/clang %clang_aie2_args -c dut.ll -o dut.o
// RUN: xchesscc_wrapper %xchesscc_aie2_args -DTO_LLVM +w work +o work -I%S -I. %S/testbench.cc dut.o
// RUN: xca_udm_dbg --aiearch aie-ml -qf -T -P %aietools/data/aie_ml/lib/ -t "%S/../profiling.tcl ./work/a.out" >& xca_udm_dbg.stdout
// RUN: FileCheck --input-file=./xca_udm_dbg.stdout %s
// CHECK: TEST PASSED

