// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (C) 2023, Advanced Micro Devices, Inc.

// REQUIRES: valid_xchess_license
// REQUIRES: peano
// RUN: mkdir -p %t/data; cd %t
// RUN: cp %S/dut_inlined.ll ./dut.ll
// RUN: cp %S/../lut_based_ops.ll .
// RUN: cp %s .
// RUN: cp %S/testdoc.txt .
// RUN: %PEANO_INSTALL_DIR/bin/clang %clang_aie2_args -c dut.ll -o dut.o
// RUN: %PEANO_INSTALL_DIR/bin/clang %clang_aie2_args -c lut_based_ops.ll -o lut_based_ops.o
// RUN: xchesscc_wrapper aie2 -f -g +s +w work +o work -I%S/../../ -I%aie_runtime_lib%/AIE2 -I %aietools/include -D__AIEARCH__=20 -D__AIENGINE__ -I. %S/../../testbench.cc dut.o lut_based_ops.o
// RUN: mkdir -p data
// RUN: xca_udm_dbg --aiearch aie-ml -qf -T -P %aietools/data/aie_ml/lib/ -t "%S/../../../profiling.tcl ./work/a.out" >& xca_udm_dbg.stdout
// RUN: FileCheck --input-file=./xca_udm_dbg.stdout %s
// CHECK: TEST PASSED
// below is code to generate easy to parse test results, has nothing to do with the success of the test
// RUN: grep Cycle xca_udm_dbg.stdout | tr -d '\n' > testsummary.txt
// RUN: cat testdoc.txt >> testsummary.txt
